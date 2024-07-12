Return-Path: <linux-kernel+bounces-250767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4192FC95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BCF1C22670
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3ED171E5A;
	Fri, 12 Jul 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGUiEDUY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6E441D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794604; cv=none; b=Zvmt41HdbQSAE8WrtJZdZbEjMoN8OnuQ9sIxUL6b63AGAoRL7buOMCGVfBKRpywj4aIU23CICT41MF28DVh+ZpHGFTySgE+doaSuGU6StzWqSuO6gBWdT6tbXBWIf0K1au09l+Xktt5tCZL4u8cE7MJoYG3X+QHnMSFmTl7HGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794604; c=relaxed/simple;
	bh=xNf1tJFXF2XZo5kA4RL74P4CbwPpLhsf5gbnmAkL9hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu3hFRbqX8hygH7cRRDsfk1yAkSl875L9/SuVflH+lYtrNxVqSllKY2MR6KnMoWYp+MNDFDQcL5UwpMH093ipMAGa0EFG4Obhb0pwQ6J1an2+mXneWgt2yHMn3R81Jcu3g7uqHK1tef6LhoYG5G/fHnRLiw9BDfDY0608/awxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGUiEDUY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720794602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Em+4lpr48F+sTPUkNgk9R0TQyrZ2qwV17RRP7sfDWpk=;
	b=hGUiEDUYXMYqBEK6OouKdEyiBHzpEyeEsqLPmLnKwnIxERD3aoniJRFu3WSvugJ0F8chOd
	hY5zrk45q95ue2PjGBZm+GrBNO4IGx6h0snMTScMW7uTru9rotg5vU4WafXfoEzW4lbmzj
	fNNwiaSSSN7JCXS6AOwPO3porhUB7mQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-vrWwab8kOD-6noca_F_X7A-1; Fri, 12 Jul 2024 10:30:00 -0400
X-MC-Unique: vrWwab8kOD-6noca_F_X7A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so1836599a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794599; x=1721399399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Em+4lpr48F+sTPUkNgk9R0TQyrZ2qwV17RRP7sfDWpk=;
        b=R9lUYNViak3BSuZNhgoNmE8Z+mFfpcw8JIQ+v61RNaawaaOz+u5ViWwdCuHv5Km6Pd
         DDdw+EeyJ91dUbbTEBwoDzO3Dkrwk9WfJ+Aeeq5GD8y59XT+HTStT97YxLy12fyUZQbq
         Cnys6WHL74y8B/uzzknnZiEHmIcRFflWUXXRD4+MXcA97IN6CMlF44B/SA+8yJDYBhVM
         oOuRbbnPmYJlhLmZlOFIQvg7o94xRZd9Nz8vE/Zm8BsJArQ+59r6M0W7ChttrBhlJq8w
         +2zmnR+edDF4B6q1lasfEVfJ/YkohB38iqUlFdpchvqSY9ZMHPh8ubAYYFMqlE4NZ0Xo
         KuXw==
X-Forwarded-Encrypted: i=1; AJvYcCV+zgJ5uvRwb8sn12wPwxb92tvl6LYSv28+T9G/E5I5SEZr5sm3siWC6f1D12zw6ZzWykRKj8Ua2kR4w5zzBDsbU+NX0i6zBTrofNEH
X-Gm-Message-State: AOJu0YwOOmQlBvaT5wjeGN7i5ANFCL26AZmBKdXWDaxqbwK5Q+1Kl7In
	lLRAELiw1lml67skVwhCHi686G5YL7kjQLOnU+yPzA2ewVwK/9JEMZtdsQlseUfdb7FzUEWPuJP
	afrVUUuoMRB+fMXjWqAzOCvzR3PbqX4cRdXH4nldvzPSXQq2IaO/wHw+vuc8kPXFIJiNKl81FYj
	TwYSgi7TM3lGUPtbc/q4srKXgAuTAsl0wupvin
X-Received: by 2002:a17:90a:70c6:b0:2c8:87e:c2d9 with SMTP id 98e67ed59e1d1-2ca35d43887mr9092110a91.39.1720794599179;
        Fri, 12 Jul 2024 07:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyEXCNphbXM4G/rPhQQo3eVo3TcpH/vUgTlLXnK+HK0NsMDnIjoeWz76/qY2/k2Ca8KWUcmscnLjrUmqi++Q=
X-Received: by 2002:a17:90a:70c6:b0:2c8:87e:c2d9 with SMTP id
 98e67ed59e1d1-2ca35d43887mr9092063a91.39.1720794598057; Fri, 12 Jul 2024
 07:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
In-Reply-To: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 12 Jul 2024 15:29:21 +0100
Message-ID: <CAOgh=Fx6hcJdbQpna2JJhnzp=YG_nyg-gpd=ZH7CewudtgDhAA@mail.gmail.com>
Subject: Re: [PATCH] nvme: apple: remove some dead code
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 15:13, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> platform_get_irq() never returns zero so we can remove his dead code.
> Checking for zero is a historical artifact from over ten years ago.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

There's quite a few return paths in platform_get_irq_optional, are we
sure it can never be zero?

Not calling out a specific case here, but it's not so clear to me how
we can guarantee platform_get_irq() is never zero,

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/nvme/host/apple.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index b1387dc459a3..f5a3a4e8b1e5 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1417,10 +1417,6 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
>                 ret = anv->irq;
>                 goto put_dev;
>         }
> -       if (!anv->irq) {
> -               ret = -ENXIO;
> -               goto put_dev;
> -       }
>
>         anv->mmio_coproc = devm_platform_ioremap_resource_byname(pdev, "ans");
>         if (IS_ERR(anv->mmio_coproc)) {
> --
> 2.43.0
>
>


