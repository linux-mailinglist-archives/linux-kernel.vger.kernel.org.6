Return-Path: <linux-kernel+bounces-348398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969798E724
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06C31F24332
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF219F464;
	Wed,  2 Oct 2024 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1fj+9z1"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8E1C0DCB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912215; cv=none; b=PM3MWJsolyImOIHDoxOXPf7Ii4n4+MaWFtbc/+gehozL9Vt56ss/03sH/hbWiMx6HRePfjgr4LNKxHk/H504a5CGNgZLUoaVzs4emOoLGOADgbAB1f8XK1OTeb88CWXF6xudOgRc7r1LEQZQ7C/9zHOrFP91O/ay9TfRPp5n3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912215; c=relaxed/simple;
	bh=S0EHAmn7sJ7Y8qtHbi0S1W/nuxkxgSWXJhHOgzuX/os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad+Z9pfv0Sjim3v1k2qgcnvAblK/+XqYFHwv5OUgwPU7uXwMQGkp00qD04VX+/pslJEeOo+qg/b3v3vOkXncN6ZB85GPeTGLRN2JEQU5NHEytkJH86Meh6CbllrhNU3Pe2DPMkoHvI9dOADtr5ygOriJ/VXf3uA/WMPE+N81rwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1fj+9z1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso348629276.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912213; x=1728517013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nY/F4CTExAOuUkjf0nz7rLS5b9eUxUi19ZbRKHEJLRc=;
        b=L1fj+9z1yiNOu7feHKiRnXLd6ZnJwjVYAzyj9D7PFmY8rjcOe2l6+JokcdBmx6Np9u
         HUiw6kBedH5wpZ6cjNI2d2VR+N4hUs/kNJ3sg6NkBcg07FLn+bTxUUonQu5xk6cY+vxT
         hrCN9dGf154JUpw1/cl3G0NeDFbnyaOSpwZEP0AaFc90XI94+0SodTS5/fU5OG/G0eos
         VAEB6W4LOfxRJ5Pk7813oeI+4D2LtDVJINtMpzmMA/0feBXSiNwPD9tFEGPp40K502Z7
         0RAAFvJlqwl6gr/mX1rDCPYwXLVgj9yB/bilvwFOv7HinpCv0r5DbbgR/IHjom9EMdOn
         KF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912213; x=1728517013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY/F4CTExAOuUkjf0nz7rLS5b9eUxUi19ZbRKHEJLRc=;
        b=PJzX50BgEYdmymUjWBubLh0ItRt9nRSTsBSRpt2CR3/3piO5ViA95YDiTvwUWHGfO0
         qP0liJzm5GyFHJGVpADIV40n2W/9hYkK3vp17n8U8+YXMUpyLXwLbA7RGayDAU47xYxt
         9EfNOKksV+CZkP1w+2vX7ld6M0+gdu0tthn2NSXH0nzF5538uMXsrrcp/4cqxWeRqhbf
         Z0C6IuC5LVF9MmA5Km2OA5qEKxp8oqF597joWzyHDyvS3qgo1T75/3lUJk/Nt5e9saES
         ImSv9G25I6WAW5bsh0rNlTm9DKqfEjfs+fDvPMorhHNLXR6ZI90+xKcd5elFr6pze3M3
         k2fg==
X-Forwarded-Encrypted: i=1; AJvYcCX/EVwAqmzH0l3g0PUKWsO3yLW7ESf3NWBL1QK1OUojFCpQ+GrCjvgvCMSydVawsN/jf9ez/P3dm0yk8yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMcpAwjaZ1/neUlU7vB2tbVbCX3GCfGBnnIiOzmZcjUTeAauj
	bXBYTGD4tu+suHt9r1q1eSITXKYt3WGKv/1X/kuKCURK/p+/nylujJFlLB961SM/kgug06V3P96
	e8jqhuXyco/n0rU3RaNKmfkIbN52qfAtNQ2BTWQ==
X-Google-Smtp-Source: AGHT+IEqtBvDPMiSYGEm5TXVX8Sxz6COAlI/JwMlP602/bf3/owumvcuy4u17DBfBna1bb1pV8OpNWPenXFZIJKVLxg=
X-Received: by 2002:a05:6902:91f:b0:e26:365a:6488 with SMTP id
 3f1490d57ef6-e2638385296mr4616693276.12.1727912212845; Wed, 02 Oct 2024
 16:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924210123.2288529-1-linux@roeck-us.net>
In-Reply-To: <20240924210123.2288529-1-linux@roeck-us.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:17 +0200
Message-ID: <CAPDyKFqPPF7RAzmS2Lb69rb-T6T2WgNrwx8vcRLJ5WUZF2UOHA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is supported
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 23:01, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
> from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
> not supporting DMA results in a warning traceback. This is seen when
> booting the sifive_u machine from SD. The underlying SPI controller
> (sifive,spi0 compatible) explicitly sets dma_mask to NULL.
>
> Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
> supported.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d0b3ca8a11f0..4d6844261912 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -388,7 +388,8 @@ static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
>
>         blk_queue_rq_timeout(mq->queue, 60 * HZ);
>
> -       dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
> +       if (mmc_dev(host)->dma_parms)
> +               dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
>
>         INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>         INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
> --
> 2.45.2
>

