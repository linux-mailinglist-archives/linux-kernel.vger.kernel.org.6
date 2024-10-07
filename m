Return-Path: <linux-kernel+bounces-354198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09399396C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFB51C21313
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0E18CBF4;
	Mon,  7 Oct 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1lcH8bh3"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3A18C02D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336973; cv=none; b=Eadd/zg9p/ZMUywsl5+jhcbmboPYRGZxsUF2R60+EJcwkwYJhFeyCoYs7EdyrrFVhmMRp/SgUMjm6ohPab3KA7HHNabZZaM5XXf0AYGenqOfw1vt0VJzfe0hweTlKCBaIMwWdZtP25D/+pE28v7CIxw1nCBAUh82RFOMwIqeFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336973; c=relaxed/simple;
	bh=JQy2zL4oAPwikhk17+kQURqFnFir6FA9LSRRTMyBm94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMtRkLYdZRjup9UQKT1Obfe+TaWW1Edp2zXHQIb8uOjS3dJ+rma9E1z0x+WCJ3x1n3tiKotEGgO18+9WJWtUsl68YizSMCCIXnMU7KJOmAQ99CTn7iBKZ28+UFROkb+fNcsrgQ4/StdQJnI5MkFPRWr+SpCaYIcWWqUvoKZksDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1lcH8bh3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e27f9d2354so160893a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728336971; x=1728941771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNElnBEDYpWFvzvIDSHHM3zq8aWA/ncVSKt50m3p1Uc=;
        b=1lcH8bh39HF271zxC7f/9QOlPIFBVEiK+3cBJFPbGZCLGTIL3oNRGCdO1XzZ5gyx9M
         C9VUkO+daumxDm2DQxn/0Qi22u+L6aZd95zGOtziaexvsTPLakSPs/lV3kei/6dnS4u2
         rLRxhrLXO11ePx6usyKjeX8pcYv7F1GxSlVK+/RBk1pzFjFazGymb5dQRJebZ6BfIlfO
         FnZt0Yw69K/wT6FhLFCqtNJOaUHIfQQGVADpUzMk8ViIZnKwohZOsE/L1EdSRSxGFEGV
         q0dT1TLhYxXZ5fLtQ8X+stp995foTIzxmhSChuevYci1PvxbkHtQO+BIwMjH45c5NqC0
         tRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336971; x=1728941771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNElnBEDYpWFvzvIDSHHM3zq8aWA/ncVSKt50m3p1Uc=;
        b=tNhrBeGbrTZJgvk4RSMXTuxs5T+wrSQBGoBO4r5p+Z3ydgR5e1Y+Pvb3BNqrXgBjd8
         vY32KDl+gGmRIcl+/+ZqoS8ruhPQOUJCnDCsi/Pmh192WadDZJE/mPgf6x+iEuT+Z14q
         +Q2xOioU+G1+DT+4Djw18yeXYDflQcYwyaIPmKA9Wgfv0IFDRQxeCiWd8FwexKNJR0jp
         e9X9pavv7IzGi8AjWNGXe/MdEqkO5uU+dagCvtPM6xQDAz62uGiIejT9zDGl3y82rk/d
         yc+qhZORaY24QvFmLzwbM86c+VkUpYUR372ENBmmS6t0loZR/9ktfVLzR7SJXErydRzU
         Simg==
X-Forwarded-Encrypted: i=1; AJvYcCVHeF519Ouaxnj4vWpUX+2lN0eaLew7F5+uJmLeY3YoXaJyRvyahH7ddmznuufMGYhRamFT60UgwIOFcFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4V4ldqEzs6xG4Ze8RIQulOB/6g7vZax69+Z4PB7MO8uTXeeIr
	AeKO9HtJnlUHLJ5mzigj+Qk31f3x6SimUhosECMxyIZeEnmTUdLe0YYdzSpx4Vk=
X-Google-Smtp-Source: AGHT+IExu8G+LbTmre/7Wvi64/0zNdjewTInymIURS0AgdTaL/5h/Wa336/N3B/Hwt0kgIfIZhHc+A==
X-Received: by 2002:a17:90a:ec07:b0:2e0:8095:98d9 with SMTP id 98e67ed59e1d1-2e1e6222221mr14172739a91.11.1728336966427;
        Mon, 07 Oct 2024 14:36:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca284sm7699214a91.11.2024.10.07.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:36:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sxvOc-00FJuO-37;
	Tue, 08 Oct 2024 08:36:02 +1100
Date: Tue, 8 Oct 2024 08:36:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: jack@suse.cz, hch@infradead.org, willy@infradead.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <ZwRUQvq4wqfL8rBd@dread.disaster.area>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
 <20241006152849.247152-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006152849.247152-4-yizhou.tang@shopee.com>

On Sun, Oct 06, 2024 at 11:28:49PM +0800, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Since commit 1a12d8bd7b29 ("writeback: scale IO chunk size up to half
> device bandwidth"), macro MAX_WRITEBACK_PAGES has been removed from the
> writeback path. Therefore, the MAX_WRITEBACK_PAGES comments in
> xfs_direct_write_iomap_begin() and xfs_buffered_write_iomap_begin() appear
> outdated.
> 
> In addition, Christoph mentioned that the xfs iomap process should be
> similar to writeback, so xfs_max_map_length() was written following the
> logic of writeback_chunk_size().
> 
> v2: Thanks for Christoph's advice. Resync with the writeback code.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  fs/fs-writeback.c         |  5 ----
>  fs/xfs/xfs_iomap.c        | 52 ++++++++++++++++++++++++---------------
>  include/linux/writeback.h |  5 ++++
>  3 files changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d8bec3c1bb1f..31c72e207e1b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -31,11 +31,6 @@
>  #include <linux/memcontrol.h>
>  #include "internal.h"
>  
> -/*
> - * 4MB minimal write chunk size
> - */
> -#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
> -
>  /*
>   * Passed into wb_writeback(), essentially a subset of writeback_control
>   */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1e11f48814c0..80f759fa9534 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2016-2018 Christoph Hellwig.
>   * All Rights Reserved.
>   */
> +#include <linux/writeback.h>
> +
>  #include "xfs.h"
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
> @@ -744,6 +746,34 @@ xfs_ilock_for_iomap(
>  	return 0;
>  }
>  
> +/*
> + * We cap the maximum length we map to a sane size to keep the chunks
> + * of work done where somewhat symmetric with the work writeback does.
> + * This is a completely arbitrary number pulled out of thin air as a
> + * best guess for initial testing.
> + *
> + * Following the logic of writeback_chunk_size(), the length will be
> + * rounded to the nearest 4MB boundary.
> + *
> + * Note that the values needs to be less than 32-bits wide until the
> + * lower level functions are updated.
> + */
> +static loff_t
> +xfs_max_map_length(struct inode *inode, loff_t length)
> +{
> +	struct bdi_writeback *wb;
> +	long pages;
> +
> +	spin_lock(&inode->i_lock);
> +	wb = inode_to_wb(wb);
> +	pages = min(wb->avg_write_bandwidth / 2,
> +		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> +	spin_unlock(&inode->i_lock);
> +	pages = round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
> +
> +	return min_t(loff_t, length, pages * PAGE_SIZE);
> +}

I think this map size limiting is completely unnecessary for
buffered writeback - buffered writes are throttled against writeback
by balance_dirty_pages(), not by extent allocation size. The size of
the delayed allocation or the overwrite map is largely irrelevant -
we're going to map the entire range during a write, do it just
doesn't matter what size the mapping is...

>  /*
>   * Check that the imap we are going to return to the caller spans the entire
>   * range that the caller requested for the IO.
> @@ -878,16 +908,7 @@ xfs_direct_write_iomap_begin(
>  	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY))
>  		goto out_unlock;
>  
> -	/*
> -	 * We cap the maximum length we map to a sane size  to keep the chunks
> -	 * of work done where somewhat symmetric with the work writeback does.
> -	 * This is a completely arbitrary number pulled out of thin air as a
> -	 * best guess for initial testing.
> -	 *
> -	 * Note that the values needs to be less than 32-bits wide until the
> -	 * lower level functions are updated.
> -	 */
> -	length = min_t(loff_t, length, 1024 * PAGE_SIZE);
> +	length = xfs_max_map_length(inode, length);
>  	end_fsb = xfs_iomap_end_fsb(mp, offset, length);

And I'd just remove this altogether from the direct IO path. The DIO
code will chain as many bios as it takes to issue Io over the entire
mapping that is returned. Given that buffered writeback has done
arbitrarily large writeback for quite some time now, I don't think
there is any need to limit the bio chain lengths in the DIO path
like this anymore, either.

i.e. I'd be looking at removing the "arbitrary size limit" code, not
making it more complex.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

