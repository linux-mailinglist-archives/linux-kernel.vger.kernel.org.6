Return-Path: <linux-kernel+bounces-565765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65437A66ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB17E1891CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237B2054F7;
	Tue, 18 Mar 2025 08:45:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E559201000
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287501; cv=none; b=XHhck2Y5W+VwLdj9BYU9TZ0K2SVLxQs1d5BIoQuOGNf6VK0MM8F1voqflAlUB4iWcDgXHg2LHh+Yis5E4+PEO5ym2556Xmm50lqgII/xPkAqlnmBb+U1fA3AulEbDXsTpVEf7m1KXbQK9TK4q3FujQ/PmctBJQEM1GZl0xlF/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287501; c=relaxed/simple;
	bh=ThDGE9X2iEvDiMJRCmZeOqrRz8dPcqTR36aHTZ8bWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHPKo/S1bWeKj+AKsoEtYUf4wrJTjssM4wKpav0o79Y4OWbuFprZ96q2/tZdfKTjdVYFQeM3RduttMzq818RJNLza9pKZ6I9k3RSHXgKEp/uhwPU1Gc5It4LXIqC8pag/uqNlgWbntJmM2z0a5QZ+9nIECN41FOoozN+Jse3NuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 26DC268AFE; Tue, 18 Mar 2025 09:44:54 +0100 (CET)
Date: Tue, 18 Mar 2025 09:44:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Huan Yang <link@vivo.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
	bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	opensource.kernel@vivo.com, rppt@kernel.org, ryan.roberts@arm.com,
	urezki@gmail.com, ziy@nvidia.com, vivek.kasireddy@intel.com
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250318084453.GB19274@lst.de>
References: <20250317055304.GB26662@lst.de> <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com> <20250318064805.GA16121@lst.de> <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com> <20250318083330.GB18902@lst.de> <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 04:39:40PM +0800, Huan Yang wrote:
> A folio may be 2MB or more large 1GB, what if we only need a little, 1M or 512MB, can vmap based on folio can solve it?

Then you only map part of it by passing a length argument.  Note that
in general when you have these large folios you also don't have highmem,
so if you only map one of them, or part of one of them you don't actually
need vmap at all and can just use folio-address..

> Normally, can offer 4k-page based array map it. But consider HVO, can't. That's why wanto base on pfn.

Well, for any large folio using this 4k based page interface is
actually highly inefficient.  So let's fix that.  And my loop in
willy as Mr. Folio while you're at it.


