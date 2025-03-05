Return-Path: <linux-kernel+bounces-547499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02255A50A33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388F0171916
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED025290F;
	Wed,  5 Mar 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CgSQZKTY"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5C2512EB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200393; cv=none; b=FWZvsebZopmfJ2rYhdyy5KAD1w89WMZyqbJiRcIQ18oGzWcMvo2QxdcMm0RpGKjygBdvLR4tdqX5y1yg+VUThNXL8PxxvSOuZpPVMPy+4jYuIiP5pBc59wxlBdbpMTzN0xgk43slrDnPaeutGP7bRyGdJ5blnNkRKlN04Q1tAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200393; c=relaxed/simple;
	bh=EfO+eU+9ipz1OTtI4xWsRlg5Bq7v+cDR8kd0D6VZ/60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dinSufmavwtUpiktVEfbn7DRatmNBdfm1vDZDOnK7dJthT9nRH+D998krJTRoSERarFu0ZuxLaF/I/2jAObjw0xsxrMifyNrdEKzjzv2lbLqK30Jj+9ZmPJ1S8ltVfvbKxK/a84Vdq9SRvhweNDKJThHAgvg9/0q9QweF2O+Nes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CgSQZKTY; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 18:46:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741200384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ucfgsix0oowqP24fIT+M10+ojZiyuKkeB730wJpBX2Y=;
	b=CgSQZKTYf3TtLNgJK3W72xUGYPzZ7wlIVY/rEvUnO/Rm5xxaFryuAt1j5h0wcnmVOUVezh
	9Q90TZY7PAn8rJ31PeCw8OuSrXCsMxLDYy25NeWgpff8/IrUYxOdqBnS7nXNP1D+banfdy
	OdOAFukMdf8QEJ+96dLXYOzQzF5W6NQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: fix uninitialized return code
Message-ID: <Z8ib8K9bPTbes0vn@google.com>
References: <20250305172800.3465120-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305172800.3465120-1-arnd@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 06:27:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'err' variable is set in a conditinal branch and is not
> set otherwise:
> 
> mm/mremap.c:1017:7: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>  1017 |                 if (vma->vm_start != old_addr)
> 
> Set it to zero before the initial value is set.
> 
> Fixes: 3129f7896afb ("mm/mremap: initial refactor of move_vma()")

I think Andrew already fixed this:
https://lore.kernel.org/lkml/20250304151556.635d9041a7ca36f1960fe664@linux-foundation.org/

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/mremap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 456849b9e7bd..9c51a2360d84 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1014,6 +1014,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
>  		return -ENOMEM;
>  
>  	if (vma->vm_ops && vma->vm_ops->may_split) {
> +		err = 0;
>  		if (vma->vm_start != old_addr)
>  			err = vma->vm_ops->may_split(vma, old_addr);
>  		if (!err && vma->vm_end != old_addr + old_len)
> -- 
> 2.39.5
> 
> 

