Return-Path: <linux-kernel+bounces-440886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC699EC5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6430A163924
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A81C9EAA;
	Wed, 11 Dec 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8FqMhg7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731A1CACF3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903399; cv=none; b=Q+YXR/sGPRuGskb/OXxus1acRGVWoKSpnzNo8fQvG/Cxmeu4lrNAE3Wei32MKL/KBfagA8jeXr6FaNQFbrBMb5uX9s9/FVer+95nkkepZ52CYGeDvHC7/yrLZhF1ZHSA1dSSj/Oa4wduSU2Q8mRCWCmVn0lHNK2+eE1gojcrPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903399; c=relaxed/simple;
	bh=R4JRU1wwpj4gJaPCPuHVg/GU0aFIBHykhTf+OJgifac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ9P+387F218mQ7vuYX3dbdC0APsIzS92PWevPKDimFvLFGCM/k8PZCp3CBcDoF4sjycVQwcBeOkyAtYbYf/hXJAmmpuipLIjn0cN4TNEVwRB+AMLM3f5Nc92Aw7UWOBI7uHEz1H7Lkm4WD/2ObMR7q62CeQP352DeOZkPIUCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n8FqMhg7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216634dd574so18538905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733903397; x=1734508197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gh7jJBz4Hlp1C/HnjHjxeskziRu/Aqy/U+q0/grM/lc=;
        b=n8FqMhg7zA0r3CRmwAoq1WwB4uw58mHNGuZX7Wkq/iLgsPENNF9YpOtBGZTgfHSZsk
         YuBvRDtQcte2mZmXAC9DoazCZ+UyxJvxyrv8OWAA2eD3lq5dRGojDP8XYehLXqPzQmD6
         axKLF+XoqPDdKK9AkbB8Pm1f8GE3Kbn7FIPTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903397; x=1734508197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh7jJBz4Hlp1C/HnjHjxeskziRu/Aqy/U+q0/grM/lc=;
        b=nFSJDHMswk5whcunCwAt0Xwj7cihmhSLr1rXYO+Efk7WgOQVMq2nCxXufgAJL+N3L1
         UF+nt8Qh7GQxZHECV5fdG95GOmEUT4mvnhfb99wAVH9OaiTw8OVIF/yVqF1hMApGfCfd
         mnIoM4u1hhGMZ/gQidvNAQz4uBzM+YOGh8VZU1RoANtJvMQyTY1yG2rvHnDfL9sjDObs
         mBGpL3uKOjXZ/Gm2n1Ae/73AWB5xDCRfOi6UalDdCaSFGgCpZXYbXYII7EltVakTN6TP
         LD2UiBB9B0J8sdR7Z8CyGav2oTYXEV1UFfGzJmIaAaGxnMqR6H62ITOX0J7iyep3CbVF
         Cv7g==
X-Forwarded-Encrypted: i=1; AJvYcCVYFFtLpZ7n3Sd4tTeprhyZydmj1/HgTXTS+buy/y2EvhYAUxIrVTPxKFQu4wyt9bectYQusG3VIr0ap6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3+SIjAhGvqOQgIXioLLj76oQQLGKfZzc3As8iTYj5218rfer
	Bw7880xxaCEKL/1Yqqqt0gXWBNNKEdIwCnl7wPodIs8M9dOFOr/G3nZ7hSYmwQ==
X-Gm-Gg: ASbGnctZ86BP35HQIZuXnZdeycq6laiRdyu7ODYy5o+vlYoBNazmOg+Xg9QMmBH9XvT
	1fiY6Un34DquBY9m5/qr97y1ryUFNO8wSjgShYkGpDszgkJlBYar+YzxbC89fbubmf16IhN7F8X
	AJflmeDBbpuD5VDf6gsBpUdQuBpyKMIVM6WL/8Xz5q+JYtS5hUtGycdpg+wqcKV5Jw5AQm68AKn
	Q4LawGV3K4zh/0QnvMdDX0gsXYRVqun3XTNaizBIv0E/MnaX4ns6IoL9Q==
X-Google-Smtp-Source: AGHT+IGSlNUF7KIOYCUwpKVcHSymyAaxeCJJAsfNxmcP9F1/4Se1zEfx7f6/D60Sb7fISVeFpmHqhg==
X-Received: by 2002:a17:902:fc50:b0:215:97a3:5ec5 with SMTP id d9443c01a7336-21778509f8cmr39019975ad.22.1733903397017;
        Tue, 10 Dec 2024 23:49:57 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f3d9c4sm101045665ad.274.2024.12.10.23.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:49:56 -0800 (PST)
Date: Wed, 11 Dec 2024 16:49:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] zram: cond_resched() in writeback loop
Message-ID: <20241211074953.GD2091455@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-2-senozhatsky@chromium.org>
 <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>
 <20241211041112.GC2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211041112.GC2091455@google.com>

On (24/12/11 13:11), Sergey Senozhatsky wrote:
> On (24/12/10 16:54), Andrew Morton wrote:
> > On Tue, 10 Dec 2024 19:53:55 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > 
> > > Writeback loop can run for quite a while (depending on
> > > wb device performance, compression algorithm and the
> > > number of entries we writeback), so we need to do
> > > cond_resched() there, similarly to what we do in
> > > recompress loop.
> > > 
> > > ...
> > >
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -889,6 +889,8 @@ static ssize_t writeback_store(struct device *dev,
> > >  next:
> > >  		zram_slot_unlock(zram, index);
> > >  		release_pp_slot(zram, pps);
> > > +
> > > +		cond_resched();
> > >  	}
> > >  
> > >  	if (blk_idx)
> > 
> > Should this be treated as a hotfix?  With a -stable backport?
> 
> Actually... can I please ask you to drop this [1] particular patch for
> now?  The stall should not happen, because submit_bio_wait() is a
> rescheduling point (in blk_wait_io()).  So I'm not sure why I'm seeing
> unhappy watchdogs.

OK, so.  submit_bio_wait() is not necessarily a rescheduling point.
By the time it calls blk_wait_io() the I/O can already be completed
so it won't schedule().  Why would I/O be completed is another story.
For instance, the backing device may have BD_HAS_SUBMIT_BIO bit set
so __submit_bio() would call disk->fops->submit_bio(bio) on the backing
device directly.  So on such setups we end up in a loop

		for_each (target slot) {
			decompress slot
			submit bio
				disk->fops->submit_bio
		}

without rescheduling.

