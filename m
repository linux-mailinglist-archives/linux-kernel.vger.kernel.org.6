Return-Path: <linux-kernel+bounces-288667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E4E953D59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A091284DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355B1547D2;
	Thu, 15 Aug 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r48m1Ifz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3D14A611
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761326; cv=none; b=s+v+X7JdIm8hTDcIWygdwCWJksVEw1qphXL9uL+6T61UP2R3Ja1ZvC6ablXPy8OHkBI/jDWRwJ7k+qPVmTVwfIh8OZ3tUg7+ReaCnRycozLTw1+LS2oeL0cb2s9TNvP2NY6fFhdAP8tVZHr0OgeGPGd2/g8jEmtpEJQs6b4xn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761326; c=relaxed/simple;
	bh=nz2vpWF0gWpmU5TwnjJ4/svSq1c7N9z+UbUg0aGlJMA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eDGRQwpdSOm4T9t2l4mwVI0FRZe7d6Bb/4/aQZz8CnJ/1sWSNAIFF0C3pzEV4EPe1GMOGayDTMFNG+7CQrE+xpLlHkNUPna0oviZLr1HWg4hv+zZQZPv4/jZwKEcX8gCPss8bukOb9+BTRsutrmbiwVgfPsCqskoI0xe8RMJz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r48m1Ifz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F9BC32786;
	Thu, 15 Aug 2024 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723761325;
	bh=nz2vpWF0gWpmU5TwnjJ4/svSq1c7N9z+UbUg0aGlJMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r48m1IfzWwY8XNCkaYv/YCKAzJM+/FW/Rc30nfLBjG41id+q0Ji5+B+7rPEuNny/L
	 Af+ISgcAfGDTY7Ot41P/wWo68nqBI+OoI8wk0qDZpI3+9XT2pQzxS3XwAMAb+KK9r8
	 xOBIi1xHAo+NFXQ98VYnjZMD7wbeMNy9kDEDzz3o=
Date: Thu, 15 Aug 2024 15:35:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huan Yang <link@vivo.com>
Cc: usamaarif642@gmail.com, yuzhao@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: move the easily assessable conditions forward
Message-Id: <20240815153524.6bb7c26dc32feb93dd1ba513@linux-foundation.org>
In-Reply-To: <20240815083102.653820-1-link@vivo.com>
References: <20240815083102.653820-1-link@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 16:31:01 +0800 Huan Yang <link@vivo.com> wrote:

> Current try_to_map_unused_to_zeropage try to use shared zero page to
> save some memory of sub page.
> 
> If forbids zeropage, no need to do anything rather than attempting to
> assess wthether to use it afterwards.
> 
> ...
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -192,6 +192,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>  
> +	if (mm_forbids_zeropage(pvmw->vma->vm_mm))
> +		return false;
> +
>  	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
>  		return false;
>  
> @@ -204,7 +207,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
>  	kunmap_local(addr);
>  
> -	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))
> +	if (contains_data)
>  		return false;
>  

Looks sensible.  I'll add it as a fixup to "mm: remap unused subpages to shared zeropage when splitting isolated thp".

