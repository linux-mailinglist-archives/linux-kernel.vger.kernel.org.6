Return-Path: <linux-kernel+bounces-325539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D2975B00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A80286BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4EB1B6543;
	Wed, 11 Sep 2024 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VVv0keVm"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995829CF6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083989; cv=none; b=mqAUtoXFGI9jkT3YNGgq8JdSbkH/IO7jqgq8iBlvRySYCviYheqbCgxhocwMWJl9qvadiwxJFtkwIMrzp1VLkb68+HTu+9h1eEs8v1u6M2Xz4/Etj+tDxzmM9jmDdem+SZ4yqShnBCUnmMUb6wCzuO2+aY/Eti9QTSRla6WLT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083989; c=relaxed/simple;
	bh=0YpFFNK8bMKBXBRLSUQVDbz0AYRE1/qX4X5j8wtkEEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO+U6G79fxfLl2XbjgNQPZG3m+1ZSUmJL57G5oRUFX0T0x0YnRqwyZrwPvYF6z9AzMwg+v6i6O6CK+ES8HEXbItTMsziEYR1JHk5i7xLN1Q6kmHfxBw1JJ7hOeJhWc3rrsHG5i2JwtSophi66IqaQfBcbU2oniQ2jc9JYqv0xY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VVv0keVm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so174179f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726083984; x=1726688784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFnRWlFSe4PDSZ4F4hVyjvbhytHuIuhgXwYJmdX//3g=;
        b=VVv0keVmq/Vo67FgIhANv3Cqh6HNCXOhet/7PGXg590PNmgxFyLufLofFZLWSNUeu1
         bpUcshDPIq9wIr2hh718MUiotsaw6bWglIegbgGsTkMsuecqb0w9FawsYbMu8xl6QAsW
         WmE9SvOI/3+4q+O73rhenAI2Kcc8wgTfjpXInQAJj50mqpjUNYzNERK/Y5FHKydXUK4/
         8gU/0rGXmOOtxinIn8TTQS6yHkR7IhthD0GvAmVyv/tgkxdQhDnc266zuqBCfafNmK0L
         nr2Uo+UEVaRoFQ8QHSg4s1TBT4uqDLkiStUXj04T3wHo0z93ZvN5cnGAgHO3l6y2L504
         UVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726083984; x=1726688784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFnRWlFSe4PDSZ4F4hVyjvbhytHuIuhgXwYJmdX//3g=;
        b=EIsm3SfXLsQgEbmttGw7Gbw1eBFL23iQj0S0lL8sC8phPwvENbeWeV09vZnUledcCt
         vCKTA0WIWXdv2InX9/f+XTlyUtRyUblEMKCY6xm79gca5Ojvf4Xs/EJ9axxSjtmlNzwv
         XHFBtgObmbT85580rVXJaKlwrM0HTl1g2SC8DzM81W9wRyM899tKFGuA582r6ZYlYEkJ
         ERR96N0Pd/5j6KSvzF9CmpC/Y9Q9mXtu+p4Iou/o3gpCTenlxObMD3CTfw11yJAO20qP
         jrl6JhpAFXql9h4xCE/I+MBIM5u6Qi5AjdN+SAKVi05Ob591GgQXS2Y8Vw9Viztt13cm
         B+YA==
X-Forwarded-Encrypted: i=1; AJvYcCW2cSEoUSHbQZ0WRiUSbwu/2X3ukIzcZLQ1q40mpImfVuJZx3rg5syk4DoRnMyYH2wav/Ovp0zP73GKY/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFWDWJrIcgXR01VH3/OeqoKdLW6GAVtzXd9P1H4X9pwjOGQeK
	j+dKKiH1kbz/hVcVA0BPk27eX2EFu8gT+ZZrWv5OKr/93//JOV5IaT7rDaHn2w0=
X-Google-Smtp-Source: AGHT+IFZ9xZzCfGupagei9ygOewILaTvKGb/PfgRjZrW+idW0CTukBxvpeVh8OUNEBh4yTb7XcxLyA==
X-Received: by 2002:a5d:5403:0:b0:376:5234:403f with SMTP id ffacd0b85a97d-378c2a76209mr193961f8f.0.1726083983884;
        Wed, 11 Sep 2024 12:46:23 -0700 (PDT)
Received: from blmsp ([2001:4090:a247:8233:9b31:6031:9e78:61e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm12326248f8f.24.2024.09.11.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:46:23 -0700 (PDT)
Date: Wed, 11 Sep 2024 21:46:22 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Ruihai Zhou <zhou.ruihai@qq.com>
Cc: srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: Fix memleak in nvmem_add_cells_from_dt
 error path
Message-ID: <fze2ujtmyqnvtoorn6xqsgcvd4vgwqpvn3brqxy4xr5k2ayytc@hbeh53dmybt4>
References: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>

On Wed, Sep 11, 2024 at 08:06:55PM GMT, Ruihai Zhou wrote:
> In the nvmem_add_cells_from_dt(), if the devicetree 'bits' property
> is outside of the valid range, the info.name alloc by kasprintf will
> cause memleak. Just free before return from nvmem_add_cells_from_dt
> in the error path.

Thanks for spotting and fixing this.

Alternative to addding a kfree() I think the info.name allocation can be
moved down behind the if-block so it can't leak when returning inside of
the nested if block.

Both is fine for me.

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> 
> Fixes: def3173d4f17 ("nvmem: core: Print error on wrong bits DT property")
> Signed-off-by: Ruihai Zhou <zhou.ruihai@qq.com>
> ---
>  drivers/nvmem/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 516dfd861b9f..ce71bee5e1a9 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -826,6 +826,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
>  			info.nbits = be32_to_cpup(addr);
>  			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
>  				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
> +				kfree(info.name);
>  				of_node_put(child);
>  				return -EINVAL;
>  			}
> -- 
> 2.31.1
> 

