Return-Path: <linux-kernel+bounces-432635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539D89E4DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63F21881740
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C11ABEB0;
	Thu,  5 Dec 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsO9kCsX"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7A7E0FF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382586; cv=none; b=NVD554hwOkHkj7W9W3/an//yTUMrjRYbmBNAuD1TB/dOHaQaZjoD7w8l8RhFqlbDxL092/oDGbMxnJC3D7GWZIscFi5rmd4Tr3VKw+vqqCW3gatu5OjVT3PqvosKZmzp1xRlc4eWNjqFaDPkQF5Ih7ixEMtENZrG304EjDFZoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382586; c=relaxed/simple;
	bh=grkbsRH6D4ZYbAuOb1wmAAyXnV7iDlG0b6TewkJIGas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9godCG7hLSBFpr5BDXbTwG/aQSO8GpfogPyXyzY4atpxVqOX8pqyRC55IOPuhwNpRS9sOmGrX3HFzD9xgYR5cWrxSUFyKW6Jz8Kbwbe9uypIfBDpHrhA/GNdxsvXsAG5IxPbMqBvd4inYnCbv0axxUiZsG79G8WX8LI8BLINFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsO9kCsX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so494791a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733382584; x=1733987384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHVMmQ/KzbcoO5ieQjC56n0uvyFf9M/Mj/sBzX0iX8s=;
        b=NsO9kCsXqWNmeiqUXxTVF1KOXwcQtipmoak50kQZQMmK89e+Y3q7VfDOcOrUJb215S
         30qmslclFKHLfVF0YXJ4r3429pPKL7d8uSaAXoJ5Yjw5p5liTy3VW8hQ/pxYlqYb9S4T
         TfFaNRfkjmVRSfy/6sMdyAVzbFWBAyvcM7Ucw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382584; x=1733987384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHVMmQ/KzbcoO5ieQjC56n0uvyFf9M/Mj/sBzX0iX8s=;
        b=UGxUD+s22PUC40oWg5ZmOKHifQBH5Xd+FnNlIwEoIE76vBn2Z5laYEFtFCpXFK4AiK
         HUvvMkmESzMU911ASoH94FMe8KvvWW8CuWrSEKpzcrf1/V3mKlRMctah3KoeePfMgAsj
         tzx0ahwMfBxGwtHd6L2v91LqxV1iKJkS0/oaYdWVX5GopBCPYDpB3EJGhVa730wXl71T
         Y/LvwREUNtihY5/ugq047q4s6Xzmf4OT5zWC+OO+aEOq7yD7sWLua9o8RW8RbO3Eo4TU
         i9/8YMnJfZ5mU81xS7mUXDWlnqdStTtImmCny7NWjaZSN4sOt2iu0Rtc7bDKMh//6U8b
         g23w==
X-Forwarded-Encrypted: i=1; AJvYcCU6lf+qXpndF/K8QGgTR6NaAYuCXFJAbztHkZwLa7puaSV6/swwUJQVRV4+4DONI8Gl7qPIRmyjmbIgSQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGehDwwoE5MV3qy0ubuUbN63atlat9vu5nvMjIHQsXsx7QzUf4
	kh9LGQsa473YiaH4kqMJU6U1XTRlX/6kBhAMycA6NBCX0+t6W14lhA6ZA6ctKA==
X-Gm-Gg: ASbGnctCr72kr+eCKlq2eZ0R77SOJMAsre2M3yz8SgKV1HBHRDw2cm60vf4TY37k7BC
	NmUu1t+bNk2XznXz4mUyh/d8tzo/Ab+O5ckLv/Q5vMuQauPkwNvKJ3xVzau254+U+eR/xQKWz+m
	N14MJBy2S+qfNkTkgUrGBjsdLquLa/5J5LVTRxkII1BkUerzT5APGBjddPc/EK9MZWsOLQ19g9Y
	tuuNjhOrvdNM1hHL4AjI2olFJIQb/9/GDOKcFVJykGSeLD1e2zn
X-Google-Smtp-Source: AGHT+IG6kRB6dDFmeXz1ne2Hv+akOd+C09aPhvGPo0ufEzIuAUB/OWr1JBmHkYw/DqGSl8lg7DDPHQ==
X-Received: by 2002:a05:6a21:7e89:b0:1e1:6db4:8a29 with SMTP id adf61e73a8af0-1e16db48a6cmr8797451637.41.1733382584222;
        Wed, 04 Dec 2024 23:09:44 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156e1e20sm652384a12.32.2024.12.04.23.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:09:43 -0800 (PST)
Date: Thu, 5 Dec 2024 16:09:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Desheng Wu <deshengwu@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: fix uninitialized ZRAM not releasing backing
 device
Message-ID: <20241205070939.GF16709@google.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
 <20241204180224.31069-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180224.31069-3-ryncsn@gmail.com>

On (24/12/05 02:02), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Setting backing device is done before ZRAM initialization.
> If we set the backing device, then remove the ZRAM module without
> initializing the device, the backing device reference will be leaked
> and the device will be hold forever.
> 
> Fix this by always check and release the backing device when resetting
> or removing ZRAM.
> 
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/zram/zram_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index dd48df5b97c8..dfe9a994e437 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2335,6 +2335,9 @@ static void zram_reset_device(struct zram *zram)
>  	zram->limit_pages = 0;
>  
>  	if (!init_done(zram)) {
> +		/* Backing device could be set before ZRAM initialization. */
> +		reset_bdev(zram);
> +
>  		up_write(&zram->init_lock);
>  		return;
>  	}
> -- 

So here I think we better remove that if entirely and always reset
the device.  Something like this (untested):

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0ca6d55c9917..8773b12afc9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1438,12 +1438,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -2327,12 +2331,6 @@ static void zram_reset_device(struct zram *zram)
 	down_write(&zram->init_lock);
 
 	zram->limit_pages = 0;
-
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 

