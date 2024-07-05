Return-Path: <linux-kernel+bounces-242699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330C928BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E64B28515D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFE16D302;
	Fri,  5 Jul 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="In8NeMtq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F21146A69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193409; cv=none; b=LpS2MO15vFqVLd6SqRvqiJDD8wzGDeCM7ttCcFhDT2/sGVvThEgmaYj4Aix+CXhaigZbax5djyW2oSOzuA4StRoAQ/hnJKK/vT0Gpp4llDpoQCN3b5WE8sNT2GMU1dEBE50wcAoRt60xIESsGJSzsLxN5LqY66E8b4eyXzfmw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193409; c=relaxed/simple;
	bh=yEgkAHLT9xLT/kpLsE5GeojmOuuYLdB0Rj2xt8hrjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxqW4v10doLtb7uibdnHOw/CdJJaY4mgFt8LzRBKnEu84Z2mVejBc12CQ2eBcpo4AQpi7m1Y9al99TO5ErqURAEYgHsJFkvC8JP9YxuInYeEiLhrWR1rly6x1YujNo7l8WjyfVUEwgWdBloG5DYESJYwyluqXG7y/RemjEcGs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=In8NeMtq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720193406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74RpSZvpnxQTfE/ido1/Stn3pY4Si/dshmNfWAA5MUE=;
	b=In8NeMtqK1GliMQMCFJZWNQ7bswtghpIAVSEDjz/U7M0Ytjbp/051sQOmPb06NZOW7jj+/
	ETTm9JNd/CkE5jWgtB75hxseDCpQ6qtUrCR/VhoY4rGxYNJqF4+cWEZaUV/3eAvGaGBmYF
	hiS+9x3dnjpkMNWoIM1I/yP5NAE/SDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6WUkrZEsOUa5kARufP6Ovw-1; Fri, 05 Jul 2024 11:30:05 -0400
X-MC-Unique: 6WUkrZEsOUa5kARufP6Ovw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4265d3bf59dso760815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 08:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720193404; x=1720798204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74RpSZvpnxQTfE/ido1/Stn3pY4Si/dshmNfWAA5MUE=;
        b=DZhw35w4vc1ct+ttX5iQTzqJsfTAYguKsUBzGcfhag1UmQyMnpC5iGk9CiSTiVw4fn
         EPjg0VmTMnv8QRhN24QyMWOZIjvuGsljQTcaVkfFjtkefMNt4K39kcep9Z2rzPabxSDR
         2XgCtEY/DCTEwlhMLwidULz38aixHQhG5mzF3Yfbsh7jw9g5GxesUYV7dtZ3oxiw/LOq
         wwUEzShqIgM6W51JWapqXJCg1O6u/Xc7f93U6Nw/K5sPbyZPafhYtY43Jsd1U1vYBMtr
         KUUCRbqVvEEqD8tdgypZkBCUeHldTROEsdvc2OzYcZRkm71YMsvXdZ4Ge1I432pLomzC
         8aCA==
X-Forwarded-Encrypted: i=1; AJvYcCVtnppLRgPq9B16Zg6iER7lQWrXhT/eTsYP4F2jv+vD74MCZzpncYaKcxIt2cAu0hDPKrDTPwz7auSWLz4AfgYrP2/Ep39pkLc5j1Bv
X-Gm-Message-State: AOJu0YwSD2asZmaaKPjClSBAe9sX/KWAzdYVA8g3Wh+I6ABnzVzi9Vhj
	nG1R7W2gP1BXTH4NHuErHBeIKGTUWSdE9SeBjZfVzjp3r2qvqip/QxstkhBt8NeIEJgwE+DEXXh
	wxW5HZJRRHgQMGNfHh2HDGzqQDxrvIOLzirnU40EZGBlTTvL4CpF2gfgoMBL7Uw==
X-Received: by 2002:a05:600c:1382:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42651dcf78amr13275315e9.18.1720193404493;
        Fri, 05 Jul 2024 08:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkVrboDczs0dPxo4wunbHpnYmaIVmXlNE6+0TzmZu7gg/JiVCnHif8sPUpik4uc7u+5wZ2JA==
X-Received: by 2002:a05:600c:1382:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42651dcf78amr13274985e9.18.1720193403888;
        Fri, 05 Jul 2024 08:30:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca492sm67562515e9.34.2024.07.05.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:30:03 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:29:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 0/5] Validate logical block size in blk_validate_limits()
Message-ID: <20240705112922-mutt-send-email-mst@kernel.org>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>

On Fri, Jul 05, 2024 at 11:51:22AM +0000, John Garry wrote:
> This series adds validation of the logical block size in
> blk_validate_limits().
> 
> Some drivers had already been validating this themselves. As such, we can
> mostly drop that driver validation.
> 
> nbd is problematic, as we cannot only change to just stop calling
> blk_validate_limits(). This is because the LBS is updated in a 2-stage
> process:
> a. update block size in the driver and validate
> b. update queue limits
> 
> So if we stop validating the limits in a., there is a user-visible change
> in behaviour (as we stop rejecting invalid limits from the NBD_SET_BLKSIZE
> ioctl). So I left that untouched.
> 
> This topic was originally mentioned in [0] and then again in [1] by
> Keith.
> 
> I have also included a related virtio_blk change to deal with
> blk_size config fallback.
> 
> [0] https://lore.kernel.org/linux-block/10b3e3fe-6ad5-4e0e-b822-f51656c976ee@oracle.com/
> [1] https://lore.kernel.org/linux-block/Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com/

virtio bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I assume this everything will go in gother with block patches?


> John Garry (5):
>   virtio_blk: Fix default logical block size fallback
>   block: Validate logical block size in blk_validate_limits()
>   null_blk: Don't bother validating blocksize
>   virtio_blk: Don't bother validating blocksize
>   loop: Don't bother validating blocksize
> 
>  block/blk-settings.c          |  2 ++
>  drivers/block/loop.c          | 12 +-----------
>  drivers/block/null_blk/main.c |  3 ---
>  drivers/block/virtio_blk.c    | 31 +++++++++++--------------------
>  include/linux/blkdev.h        |  1 +
>  5 files changed, 15 insertions(+), 34 deletions(-)
> 
> -- 
> 2.31.1


