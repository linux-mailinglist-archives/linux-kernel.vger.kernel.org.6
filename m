Return-Path: <linux-kernel+bounces-557262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADCDA5D5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5290B3B3C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CC1E376C;
	Wed, 12 Mar 2025 06:18:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075851925A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760324; cv=none; b=lh6VRkD2kikkKJRBnGorRNtK1zwsoZ/u64X+HiyMti8DcITOA1i4a3Bp2Bc9fPED90ZxFLCjLClDWTpNz3y4ubB1oB2Q5TpHMFFoO+nmSSC0+TALXl4qx4RaNffZwZurMpN/SyL+AtObLaRVRyOhCD4X9K58KNUpjl52J6p24Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760324; c=relaxed/simple;
	bh=tFcs81LD6K7zSwx6FzkSCLL3f2rawGm+KCqWSnfMdIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O19Fj3gyHMmp6YK/EFUAgVuLhMWyF0CkbAjds+009OgMVOV/fAF4EdrIDQsOryYZePXTUSWsIX0yZW2KVqS6y+4XQun/eW/Aj9i+RwZLu9SVj0A8Tc0ji40vsx190KDBOUfUgVTX3FBywigxZqKZGHVzMHSdC1PYqU/1K1jw1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFD7868AA6; Wed, 12 Mar 2025 07:18:36 +0100 (CET)
Date: Wed, 12 Mar 2025 07:18:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Huan Yang <link@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Christoph Hellwig <hch@lst.de>,
	Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250312061836.GA12841@lst.de>
References: <20250312061513.1126496-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312061513.1126496-1-link@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 12, 2025 at 02:15:12PM +0800, Huan Yang wrote:
> When invoke vmap_pfns, it call vmap_pfn_apply to set pfn into pte.
> It check pfn is valid, if true then warn and return.
> 
> This is a mischeck, actually we need set a valid pfn into pte, not an
> invalid pfn.

As just discussed this is wrong.  vmap_pfn is for mapping non-page
PFNs and the check is what enforces that.  What is the point of having
that detailed discussion if you just send the broken patch anyway with
a commit log not even acknowledging the facts?


