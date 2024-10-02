Return-Path: <linux-kernel+bounces-346979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C698CB94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09531C21E94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3318052;
	Wed,  2 Oct 2024 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CzTeLnxh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238A11C83
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840316; cv=none; b=rHQBAI58f/LmGy1X9/I8vwNZZj/Vgb0NEjZWJ5eV1UQjCqwIalkayX1HORXdrfeVcd9n6wj5+Xw0gFgmLZPBaVlxHSEHa5lENOM+mA9LnpA+8nu6rbpzVDjmVOuflxZY5JaFaCW1T9KFJzaV674q6Q2RiPGq3b8OYOs8mFbCIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840316; c=relaxed/simple;
	bh=BhL009NZOUV2luJOkrEytr5MMxTgpZMzCufvrhe5KiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIWKdT7TzlHWSJojUgkMFyTGjJh6Em9No07ruGYTqwDdw5eCfWSWmSehRRW11oVBCYAkcj6P+yuFYCZgZeqMExotD5TTzgbhld1cQUNIRRVgyglhSWlZyVy4TmKEJgIWHYswjn2uxLslVmgKqsYEVE5G+MG3aai9KypwQTG/v5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CzTeLnxh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ciCu5avsDLxUiWUnFeF8OV+7HKY4FNxRpx45aFZ6ISI=; b=CzTeLnxhoVhYlObrEaGn7wEZR8
	FOxdTc96fXvWFMe9t+8ib5dMgDW+4w/VdosULccb9H8hdgmevpKiZ7Rzzsa2Y1P4rKkquV4X6dyRX
	sg7c8WLfwWh/UTf2F2SkfcTcAU4VZlUAv3Yg0QR7hmFcuQeGCSQy/dLIHZrXbWvJk131bgqZ/RUSV
	0ngK74qF4Zjowu3YAFKon7VF91+hr5qnLWcexT7oSUbY+kdY7tLUHrJynvxAhyHn2ygVRbiqintFI
	lA60qa8P288GUR0ry240j8w6BOZpDWL10m+lO7kLqwA9o0u9Pt3AR9f+L6Vq7yvCRahoWtyT2I8zG
	3jc3QyCA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqBx-00000004FGy-2Fst;
	Wed, 02 Oct 2024 03:38:21 +0000
Date: Wed, 2 Oct 2024 04:38:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, joe@perches.com,
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Subject: Re: [PATCH 3/3] zsmalloc: replace kmap_atomic with kmap_local_page
Message-ID: <ZvzALYgWMSUYXsol@casper.infradead.org>
References: <20241001175358.12970-1-quic_pintu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001175358.12970-1-quic_pintu@quicinc.com>

On Tue, Oct 01, 2024 at 11:23:58PM +0530, Pintu Kumar wrote:
> @@ -1059,12 +1061,12 @@ static void *__zs_map_object(struct mapping_area *area,
>  	sizes[1] = size - sizes[0];
>  
>  	/* copy object to per-cpu buffer */
> -	addr = kmap_atomic(pages[0]);
> +	addr = kmap_local_page(pages[0]);
>  	memcpy(buf, addr + off, sizes[0]);
> -	kunmap_atomic(addr);
> -	addr = kmap_atomic(pages[1]);
> +	kunmap_local(addr);
> +	addr = kmap_local_page(pages[1]);
>  	memcpy(buf + sizes[0], addr, sizes[1]);
> -	kunmap_atomic(addr);
> +	kunmap_local(addr);

This looks like memcpy_from_page().

>  	/* copy per-cpu buffer to object */
> -	addr = kmap_atomic(pages[0]);
> +	addr = kmap_local_page(pages[0]);
>  	memcpy(addr + off, buf, sizes[0]);
> -	kunmap_atomic(addr);
> -	addr = kmap_atomic(pages[1]);
> +	kunmap_local(addr);
> +	addr = kmap_local_page(pages[1]);
>  	memcpy(addr, buf + sizes[0], sizes[1]);
> -	kunmap_atomic(addr);
> +	kunmap_local(addr);

memcpy_from_page()?

> @@ -1798,14 +1800,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	migrate_write_lock(zspage);
>  
>  	offset = get_first_obj_offset(page);
> -	s_addr = kmap_atomic(page);
> +	s_addr = kmap_local_page(page);
>  
>  	/*
>  	 * Here, any user cannot access all objects in the zspage so let's move.
>  	 */
> -	d_addr = kmap_atomic(newpage);
> +	d_addr = kmap_local_page(newpage);
>  	copy_page(d_addr, s_addr);
> -	kunmap_atomic(d_addr);
> +	kunmap_local(d_addr);

copy_highpage()?


Maybe check the other uses, see if there are appropriate helpers for
them too.

Also, what testing have you done of this patch?

