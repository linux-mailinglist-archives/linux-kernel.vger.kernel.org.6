Return-Path: <linux-kernel+bounces-572558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3834BA6CB6C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B061B6515C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7449233722;
	Sat, 22 Mar 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooXs3H3A"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F9230BDF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742660317; cv=none; b=Hm7vIWgTwKRq64q29FakkizrhBV0hXZoRoqdaV53Qp69DqbBEk/d4f7EIHFhG3vyYHL93iVCe+V+HvllpmnA3ImL5byY7MCIVJuRjgN7WEapoSxd/HJGT6Y2CapmMVoh1Yqf7fIZjD1inzC9IJw+36Oknmt9ZuXEhsWShCp/EfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742660317; c=relaxed/simple;
	bh=EhSc4gMtJQ8VkenQ8q7Z4o6Gq8b7xOdff+lboxzPoxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awVknqNsDKogKX6ehLdPxhZhFsdDr7R+C5w8YBR7nJ5CKoCxmG0x2T1VQgjInoQt4OU4odwPRUIe2ddobV1rG5WUyxbWosbIDLzwpgoEhogq/gMfoUVnDFgPxepDM7wX195QDD2I/t4pY+pwFLgc6dwdUYn8lGamLxdj0YigDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ooXs3H3A; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913cf69784so2467650f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742660313; x=1743265113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQg7akAtbWC+F80WejdnIt/45y4xXX2jqP1rGiQwyO4=;
        b=ooXs3H3AhCsiuyXIipjwFaBOAB6wacnrQhLHJLhO3ypFwA2NiaXliJoNqlWUuRo5R4
         SLILP+vUKmOUkM6JlTPgUj0mGLXq2SZzgMrSmhJoi8j55q23Kavntc8zxiGaM1iURFFf
         ps/FCEzFddE6bJBnHdF1ler91EQrkZvIrYOMuGcJMjk5A9Bbwjj+/VjkTJVO9SGMoum2
         tNiKtXpxjBPWffJBhzhKeoLVWqwJtXGWOqSQjyw/rYYEAe/yQpeSSn64j7Q4wBRbs8P+
         ZdLhS2iRLM8cFjaNFCydfFB8dvWWl4jwL+FOsVaHwefnzHfVi//E92oJTQqundgyu6BH
         TR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742660313; x=1743265113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQg7akAtbWC+F80WejdnIt/45y4xXX2jqP1rGiQwyO4=;
        b=C9t9VO2jHoEqD+PN8dN/7g6DAySl1IT3zrmNqPZswsHNMxc7PjbnMu9YK0z16sPPab
         yrPir/S9c1cxrZnJvrAbszQa2IjW2sL8CUzwzAsi6IyoOfL2eiFK99rbrBD8QZ6XZOP+
         ZeGNNpzm7O7zcjSjxUB4qlN0Z+egUkJPR9Am7iqXCzqkhFOxS/9Io/E4usR7ptHdLNAU
         0i1KOjw5B82mXKLjigJmaD0whI5oOJ6SEf/bSiCP+PeVnMa4zkdO7H2T3tImOHCTdEhJ
         q5uVnfchPd3HfXkEdj7nPeZPFoTKoJn1uwpt7+11z2EwaUkAQi6w8afwtGlO36XT4Ei9
         Y4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVGvMJup/nEaLrv0jbRi5OZcmDIzD/G7dRzimv7Tzz2oOon8olUF4isyGeCWsmJ0boZDWUK+swuN48fKaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuI4rBsWBfV8+sYdHYasxlNOF7ZB4airy4k99lvyZ+/C1M9RG4
	ZsZnhCj16NXyxU1/CyMMBT0gBZN+s3j8t2L+7VgcMdsylKJ22NADCAtELOl2ri/spy7Q2OyPtFs
	AXDqOxABfb9NDf4SnKYz9hQxj69guhfsUxOvHWg==
X-Gm-Gg: ASbGncuiinBdaxxt+UXqJaq/QtTrArPbEN6GW23G6ro8QH4wRjYUevUIS/moek/Ki0V
	3Jeesee5SmFxWVE6fjjhij50m4y4lHxicUfAJSEyeRRo7sMTGKlh35EAKLMaif5FKs24OCw0/uq
	AfExW8PaT/GRNVjwgcI5ZE54vNxS0XMLOIkpLPdhY9YJBFGB9RuY1DXSKVvrI=
X-Google-Smtp-Source: AGHT+IG/dP5kfjpo9N6hZ95W4x5TZDS77CcIFlzLNp1DQjbAjfhRKFsF02WSvZgsoXhLBeGn8IYRmz0UhAyj7EU/6/s=
X-Received: by 2002:a5d:64af:0:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-3997f8f8c14mr7295628f8f.1.1742660312674; Sat, 22 Mar 2025
 09:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322144736.472777-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250322144736.472777-1-andriy.shevchenko@linux.intel.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sat, 22 Mar 2025 16:18:22 +0000
X-Gm-Features: AQ5f1JpS0ZHpf8trIuKoL__I_GBotdRkSDBFtV3W0xRYYiAh7VkraP9v-DaXLwI
Message-ID: <CACr-zFCF_b0_3NSLFvtgfpAbsSwUOYv5fS==PPbn9zXPBS0NHw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] i2c: qcom-geni: Use generic definitions for bus frequencies
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, Viken Dadhaniya <quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Sat, 22 Mar 2025 at 14:59, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since we have generic definitions for bus frequencies, let's use them.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me.

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 515a784c951c..ccea575fb783 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -71,7 +71,6 @@ enum geni_i2c_err_code {
>                                                                         << 5)
>
>  #define I2C_AUTO_SUSPEND_DELAY 250
> -#define KHZ(freq)              (1000 * freq)
>  #define PACKING_BYTES_PW       4
>
>  #define ABORT_TIMEOUT          HZ
> @@ -148,18 +147,18 @@ struct geni_i2c_clk_fld {
>   * source_clock = 19.2 MHz
>   */
>  static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
> -       {KHZ(100), 7, 10, 12, 26},
> -       {KHZ(400), 2,  5, 11, 22},
> -       {KHZ(1000), 1, 2,  8, 18},
> -       {},
> +       { I2C_MAX_STANDARD_MODE_FREQ, 7, 10, 12, 26 },
> +       { I2C_MAX_FAST_MODE_FREQ, 2,  5, 11, 22 },
> +       { I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 2,  8, 18 },
> +       {}
>  };
>
>  /* source_clock = 32 MHz */
>  static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> -       {KHZ(100), 8, 14, 18, 40},
> -       {KHZ(400), 4,  3, 11, 20},
> -       {KHZ(1000), 2, 3,  6, 15},
> -       {},
> +       { I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 40 },
> +       { I2C_MAX_FAST_MODE_FREQ, 4,  3, 11, 20 },
> +       { I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3,  6, 15 },
> +       {}
>  };
>
>  static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
> @@ -812,7 +811,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                                        &gi2c->clk_freq_out);
>         if (ret) {
>                 dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
> -               gi2c->clk_freq_out = KHZ(100);
> +               gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
>         }
>
>         if (has_acpi_companion(dev))
> --
> 2.47.2
>
>

