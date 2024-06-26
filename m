Return-Path: <linux-kernel+bounces-231312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB74918DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F4B1C2155F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D575190075;
	Wed, 26 Jun 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pX8aWjRr"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641718F2F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425195; cv=none; b=hDYBpSLZR/hHpBa4JENKu9K9i76ykLuILV4iX1pOuNGC8OEETMGlit4Lqf603CGRLT+R5LcjP0W/PRyWHu/7biRnnJ+yTtaiNhCZrXyzrtUpuXHZIGr9nm52zQoQKdyyqyKbjo+bsG9CJS4GTzL8pYGsKRXa96M4i9eRiSWPERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425195; c=relaxed/simple;
	bh=C3S4oWLamxpu1QmLYi2HftbBwj0w9rHMNgxb3DYHnLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPyj/OQ6n503C7VomLuEKRDyr2h3RIuZJ+uBibyzb7fCWG4zxuxw6fH7pLupL7yj0+Bvlx6G0noeUYXt+lQQMIk/fsQQrirTkfU6+u+ZI1teEnrJSd4dEOEkkTJK/CN8OyyTFbwBIyj2do1/KfEN3/EukONegMGp/qkjRjPA0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pX8aWjRr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mhocko@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719425190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oYN+ptDdc+VW/Y5Ad3Dz7fG7XoJpsThVWCIN2IxS+Q=;
	b=pX8aWjRrsrjIIymjQqgcTmn4feMUhQRVVjTfxS4mQjNR7ePsCf6zG2cxRsCaDkhfkQJsci
	mKT873AIt4ySayv/kNdz6V3XIeaFvilvUtMKbinwwqBbmjfEmERv68zsDdqPAhMriN3Gfk
	vqTzqgeOyvDEdVlBbHPxp4Qoqx5InXg=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Wed, 26 Jun 2024 18:06:27 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 13/14] mm: memcg: put cgroup v1-related members of
 task_struct under config option
Message-ID: <ZnxYo-zsqjb32Xrc@google.com>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-14-roman.gushchin@linux.dev>
 <ZnpvaFCLrwmzTRGO@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnpvaFCLrwmzTRGO@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 25, 2024 at 09:19:04AM +0200, Michal Hocko wrote:
> On Mon 24-06-24 17:59:05, Roman Gushchin wrote:
> > Guard cgroup v1-related members of task_struct under the CONFIG_MEMCG_V1
> > config option, so that users who adopted cgroup v2 don't have to waste
> > the memory for fields which are never accessed.
> 
> This patch does more than that, right? It is essentially making the
> whole v1 code conditional. Please change the wording accordingly.

More than that, it doesn't do this at all. This commit message was taken
from another patch in v1 of this series by a mistake.
> 
> I also think we should make it more clear when to enable the option. I
> would propose the following for the config option help text:
> 
> Legacy cgroup v1 memory controller which has been deprecated by cgroup
> v2 implementation. The v1 is there for legacy applications which haven't
> migrated to the new cgroup v2 interface yet. If you do not have any such
> application then you are completely fine leaving this option disabled.
> 
> Please note that feature set of the legacy memory controller is likely
> going to shrink due to deprecation process. New deployments with v1
> controller are highly discouraged.
> 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> With that updated feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

An updated version with a correct commit subject and description and your config
option description is sent to Andrew, you're cc'ed.

Thank you for suggesting the config option description and reviewing the series,
appreciate it!

Thanks,
Roman

