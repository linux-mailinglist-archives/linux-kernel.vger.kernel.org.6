Return-Path: <linux-kernel+bounces-283081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96194ECE4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE05B2131C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47317A58E;
	Mon, 12 Aug 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K5IAu3Na"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246C17997A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465434; cv=none; b=OLbhX7If9VMvRGvIBbLGJQILPJClGG9i073xTIuJVR4gowK7TB4QfCMWmfEpVCMpw1sxQbA2791fjJ0Nzd7C7VPIT0MT1lRnan9dfEiq3wb3WJlbf8TR9Zx6omDVlUtvW+Bj/OLjI6K57EVU2eFyklEwCITp7rzShncT8Xrp9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465434; c=relaxed/simple;
	bh=jGosGmNqg+3CGldQhIO8Q9Yl5xt8JrZV5L5omlJeBwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cf7a7MgUuU9ld05AJvJYxVRfCuRot9RZj/ML7qJpLRz1lce6CinswNC0ZFS5uwyty63IpugGM3XuYy3m6ExtvfrG1vrIKCVV+wwPqyMxrtCW5dBick6FLrmt0AcN4epuLcL0b1CBn1PbfQFKzi2o0xIpTZu1Op5j3fVKTUmE3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K5IAu3Na; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso32707685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723465430; x=1724070230; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XehwAsVHbXNGMp5RdCTcg+jS1mcwWOdOd2oDmc3/TGI=;
        b=K5IAu3NaZSfFJo/Ug25gkdnHhcrxc6Gf7bVzfcHY37cpY1KVuDPj6Fu1KZBnJXOX6c
         vaNaZBNtnG7N//fUwFWZIyOcrG4cTvqUu3G9HI8p/y7mC4N6G0dBbyO46KWxVDhkoD6w
         zY+4WRu5wmPFK3sNEzZlYbcpTBIV6pdjYOLmVgUkH5Tradch/X4MHWypFS2wJNxWoC2t
         AFNv8e+FJC796/NJAqeW6pAOlKtD/RCSZbgA9DjOkiDGgOmdXdb0XFYuYVmlHQK5vDp+
         Ekjb6UEOYZot/l9fAovsgIBnMbhIeZdeRH5llcDJqClMGaaJKV2QCMyKDzP5qrIdjoQn
         NxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723465430; x=1724070230;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XehwAsVHbXNGMp5RdCTcg+jS1mcwWOdOd2oDmc3/TGI=;
        b=iZwFO3hRHQUrl2QhxrcMz7WUyDZeiw4voB1VE7Fjqg0hA8HSTi/8uppMrlTzxN+LT5
         zLS69UDQbtyWiv0YwJvsZNyk+9Zur9KpONgfA1AXnCSdC6hQ17AzJjg05z+cXyBckg0B
         MCX/fdt6I8hCHvVBLK/ufVF4wPLd1Ykni1fmGBC5bEvZJUB6/Lfa+u28x421cN4oB0f9
         W8OvYzWN8HUQwpdlnJ7WNCaDdXmjQnLdxGq+YZWDnjIGBrFkPoiTRKX3n9Ud1yCmoivY
         yS/XprPtKBUwVrsKbYiH8/ljiXLy5SmVrJ4oF4WLUkgBN7e60hoLMpkD6FFJRYofV7nd
         sAqg==
X-Forwarded-Encrypted: i=1; AJvYcCUgD28HHFN00BcZlfwD+Vy8b2a+3+yAMVxxaJr+111Z6RqbudHtTM8TzoFLNLSzjzBauQHVWJRsjwIdOFc4X2AFK4TrO22pvytmzuQQ
X-Gm-Message-State: AOJu0YxyvqmBAwmxqjR4TloYXMrqGPmAjoTiaKlh+eII7OUvmFgQ3QjM
	Xov4mn5+2fpFDnVggMj4cTkkx8bBz6US9avoQyfoFrHdNZQHGZIzByLpNVmllV0=
X-Google-Smtp-Source: AGHT+IG8N1oZwbzivFuOXMO8KjI25Y2SXPR/dyyxOki85347hWjVPqJg+oatclhLoGiEpsJJCbZ3lw==
X-Received: by 2002:a05:600c:468d:b0:426:55a3:71af with SMTP id 5b1f17b1804b1-429d4894febmr1580465e9.33.1723465429768;
        Mon, 12 Aug 2024 05:23:49 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e555:6809:45b3:2496])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775e0e8sm100690605e9.41.2024.08.12.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:23:49 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-mmc@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: fix wrong conversion of __bf_shf to __ffs
In-Reply-To: <20240812115515.20158-1-ansuelsmth@gmail.com> (Christian
	Marangi's message of "Mon, 12 Aug 2024 13:55:10 +0200")
References: <20240812115515.20158-1-ansuelsmth@gmail.com>
Date: Mon, 12 Aug 2024 14:23:48 +0200
Message-ID: <1j8qx2x73f.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 12 Aug 2024 at 13:55, Christian Marangi <ansuelsmth@gmail.com> wrote:

> Commit 795c633f6093 ("mmc: meson-gx: fix __ffsdi2 undefined on arm32")
> changed __bf_shf to __ffs to fix a compile error on 32bit arch that have
> problems with __ffsdi2. This comes from the fact that __bf_shf use
> __builtin_ffsll and on 32bit __ffsdi2 is missing.
>
> Problem is that __bf_shf is defined as
>
>   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
>
> but the patch doesn't account for the - 1.
>
> Fix this by using the __builtin_ffs and add the - 1 to reflect the
> original implementation.
>
> The commit also converted other entry of __bf_shf in the code but those
> got dropped in later patches.
>
> Fixes: 795c633f6093 ("mmc: meson-gx: fix __ffsdi2 undefined on arm32")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Hi Christian,

Are you fixing an actual problem you've seen with the platform and or
this solely based on the original commit description ?

If I dump the shift values with what we have right now, on sm1 at least
* Mux shift is 6
* Div shift is 0

This is aligned with the datasheet and has been working for while now.

> Cc: stable@vger.kernel.org # see patch description, needs adjustements for < 5.2
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index c7c067b9415a..8f64083a08fa 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -464,7 +464,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	init.num_parents = MUX_CLK_NUM_PARENTS;
>  
>  	mux->reg = host->regs + SD_EMMC_CLOCK;
> -	mux->shift = __ffs(CLK_SRC_MASK);
> +	mux->shift = __builtin_ffs(CLK_SRC_MASK) - 1;
>  	mux->mask = CLK_SRC_MASK >> mux->shift;
>  	mux->hw.init = &init;
>  
> @@ -486,7 +486,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	init.num_parents = 1;
>  
>  	div->reg = host->regs + SD_EMMC_CLOCK;
> -	div->shift = __ffs(CLK_DIV_MASK);
> +	div->shift = __builtin_ffs(CLK_DIV_MASK) - 1;
>  	div->width = __builtin_popcountl(CLK_DIV_MASK);
>  	div->hw.init = &init;
>  	div->flags = CLK_DIVIDER_ONE_BASED;

-- 
Jerome

