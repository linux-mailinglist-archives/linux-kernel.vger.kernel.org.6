Return-Path: <linux-kernel+bounces-510874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96334A32310
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC407A42ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F42080F6;
	Wed, 12 Feb 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag+g7u1q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3744209667
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354480; cv=none; b=rPNczF51AewFsCvMvfGKm31dhqqyJJbqvcjBngcXwCMPJ0TvnPhoJ9RfLMXjSKvaZAtPMsTgDKwubKApxPd9CZvAttvVVwo5nJC9+4mqBJ9VMFKKpLdZH8/ZA8nZhvUN/ATJtf9myTaf0TohAecPtbOuVo2ecO+0YvmMRyw3ucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354480; c=relaxed/simple;
	bh=sLtMNl2PIK/GBgnQIKx/qPFCh0ea5y3KjwR+JGxQbxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX5dK8dCm3VIH3iQRdI0gRvl3Vs3vxSjYUfH5zkFRSN3awD9CQ5cbv8hsoDyzziKFPSUzvur7IMuw9JW4eP3DpE0HbOTueBsEFJ8yWTn5aija8wKpqQ9RQFFvGPLuuWopZa6lfjckF/l2APhjD3B9LwIM5oYUr/DaTiCHVVVLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ag+g7u1q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739354476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k10/aEW9kI4Fw7g7ICooPKDGPu1yctxg0l9c8ZseCIM=;
	b=ag+g7u1qDtYw/QcwbCDCqqQ2lfEpfwLaab9xlmie5m+S8UTLb6pOvlZL//kQIwfKDAsq41
	hQF8WUT9Y+3wRTNLBtPrAHgUTavzMtOQQvNnsWxor1X71VeZrrLKqKLoZxEp0BlwVzuuPd
	BeV97o+4a1mGPPmBLrNX3nIVvTYb7uY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-SwR-GNjfMVC7-J-gPafkNQ-1; Wed, 12 Feb 2025 05:01:14 -0500
X-MC-Unique: SwR-GNjfMVC7-J-gPafkNQ-1
X-Mimecast-MFC-AGG-ID: SwR-GNjfMVC7-J-gPafkNQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so13104137a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354473; x=1739959273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k10/aEW9kI4Fw7g7ICooPKDGPu1yctxg0l9c8ZseCIM=;
        b=si5d7hR2/MZPz1CfritT5WOkte+EJpWslGMsT5JxTOQBAhHUPrBR7vPKfUEmSjmRJg
         lVcdV0kVP+hexulKeHMj1+gBrktL0gOiAIir6iIP/oeVFwZJFu3lEWCTLxTUMtU5N7HD
         p4bw+UOIWcdP9aJj2vy5wHydB9rOLVhdUlg6hOgKNIuk4yz7hK4h1vjaAy3yZN503zTo
         jpk9rCFARY/xDRWhCKoAD8IvvV0puPb0Q4trqmWKxKwscleQr5f/cIFdhpiF8zO1PuDA
         8nlXOthvw2NxBGXvJGuTuiAoShjnQDxIRZi8AUmz2ER6khcmssRfd+KgKFa9qZ64CjTT
         2v6A==
X-Forwarded-Encrypted: i=1; AJvYcCVUX2vFZhZjAJDi4wEvkHhWp2p5Z2d4hfIHmVkzuz0b/YFTHX/hID6zLWVRl/erabi1b/Fn2kfLMdsO0Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZV3IjaraLvcfdRUM13NGHLksM1Sl+TVCDgRKEWpvWSWFzapZ
	rF1gnWAH0aJ6GmxVxxluJGOE8JrTVSkxsJJlWpMDllUZ3QMTxWneLOmzBxRsIem6ybVBp0y6H5O
	qzs1IPXUOnK3y2KsScLPsE55NwLgwJqQyAVxyzRce1LtTCdNTt3R68J9PZ/RrKeJj02MMF1ugFv
	4cKbfRqFE0Wc80f7Ip4qKvE2b0sc5jJla1ulqT
X-Gm-Gg: ASbGnctcpTenhAV276f79R68LKTNhW2dlOmxNg96ZCHZB4fvN/fpgIPt1Ho4thTrTTS
	K0ZZD1K9hhCZ9kmm5aVH8zRRKwfZQ392FQU7DV0hBherQowckYFyY3mBZ7w5a4ieRnE+oCfqzYK
	KJ2aTOVqdfnWFWqb6e/gw=
X-Received: by 2002:a17:90b:3a08:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-2fbf5c6a05amr3885262a91.30.1739354473033;
        Wed, 12 Feb 2025 02:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHapn9jYWGyKoK8rERdyukBRLyP6apd4I5Sp/cSU8BhLWDuyyGc2UAEQe4Lq75zmYbK/CB6jhRtH7HcRUIhM4Q=
X-Received: by 2002:a17:90b:3a08:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2fbf5c6a05amr3885222a91.30.1739354472720; Wed, 12 Feb 2025
 02:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Wed, 12 Feb 2025 10:00:36 +0000
X-Gm-Features: AWEUYZn-hP_kxTTtLow8M16VioOce2ZF8-IggRFFQ_uJOeNCeNsgfNjbEVocXew
Message-ID: <CAOgh=FzNk089VSrLbuAS=UA45dpY3mVFoebE2xg5ZGvTrtmVWg@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>, Jens Axboe <axboe@kernel.dk>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, 
	kernel-janitors@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 09:08, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> This code calls kfree(bfr); and then passes "bfr" to rtk->ops->crashed()
> which is a use after free.  The ->crashed function pointer is implemented
> by apple_nvme_rtkit_crashed() and it doesn't use the "bfr" pointer so
> this doesn't cause a problem.  But it still looks sketchy as can be.
>
> Fix this by moving kfree() after the last usage of bfr.
>
> Fixes: c559645f343a ("soc: apple: rtkit: Pass the crashlog to the crashed() callback")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

I wish we used the attribute cleanup stuff by default more in the
kernel, it would prevent a lot of things like this, it does what we
want it to do, most of the time.

Although I'm not sure it was introduced yet when the code was written.

Is mise le meas/Regards,

Eric Curtin

> ---
> This is based on static analysis with smatch, only compile tested.
> ---
>  drivers/soc/apple/rtkit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index 4b0783091a92..1ccec7ba640c 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -360,7 +360,6 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
>                 apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
>                                    rtk->crashlog_buffer.size);
>                 apple_rtkit_crashlog_dump(rtk, bfr, rtk->crashlog_buffer.size);
> -               kfree(bfr);
>         } else {
>                 dev_err(rtk->dev,
>                         "RTKit: Couldn't allocate crashlog shadow buffer\n");
> @@ -369,6 +368,8 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
>         rtk->crashed = true;
>         if (rtk->ops->crashed)
>                 rtk->ops->crashed(rtk->cookie, bfr, rtk->crashlog_buffer.size);
> +
> +       kfree(bfr);
>  }
>
>  static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
> --
> 2.39.3
>
>


