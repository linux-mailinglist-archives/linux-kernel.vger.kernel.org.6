Return-Path: <linux-kernel+bounces-205865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD321900189
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECCDB249C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3C1862AD;
	Fri,  7 Jun 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRFcj5rr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44A186E2E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758237; cv=none; b=A9QmzpFNv0tLW4OVUmdQsymEHv5q8cYUECzbKCb9X2/82wo7VxRwxUmc1K19ciFjt7LvCuI7Wsx0IkBUerlR3kYsWXlbfGheOW2wc/FzjahEpI2A1HoYttVVyKA8GggmGjQ8q8MVzD7pE4EU7rsbviUKbsSDcy7YhTWpevdLvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758237; c=relaxed/simple;
	bh=iqK4sXvyXYzwRawxLH7Qmttv0TpUxcESQppaLdEEsnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+a0ZG5f8m3FjmkAKoaE829kd5tFRyTTNOp6b/uNAu8vSN18vwpGWwR/zyKxEszOKdqpUdXU8lrw3gMN9N1naGGL3uhCX2Woxjy3DL5uyNZZfvNvYjluDVjbgP+vWX3cb0sopiscjjp8BXZy0c4XRIVb8LMrUTiZh4OjWXKNFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRFcj5rr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so22384451fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717758232; x=1718363032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELTaPx5YTbXM+uNiIF/L+aaSl4VA6PsxXQKScV0FjyM=;
        b=qRFcj5rrNpkwu8qTh0QvsfXZVkTMy4kDDQ3RkXJjmD1VO2xKhFQP7leyC85BrgWDS2
         dXX0M96UEeisdO8au9tek2pdOhctbSZauyOx9WMDrvjw8DHmwYFGXIwizn+8IiGw2gcF
         l8nk6LfmKu9ssJsFDKduG8RWFSnzOoj3LRVFd6r1ovM9v+EjveE+dYnhQ2Z60YhUHUrA
         oyiZMqaTLxpObQZRLaXnSHdIi00biHJYgkfw9g5zP+QuQ+/oFnoyeZHj4P9k2i12faEz
         3QAa0hGmjOeNMa5hdeUXhZTtFaWxSlNKH2/W/ofdSwb/526x2Vv78876S4kOdL4Vt39+
         T2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758232; x=1718363032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELTaPx5YTbXM+uNiIF/L+aaSl4VA6PsxXQKScV0FjyM=;
        b=W9RiWqhbv5womgLRkjAVuLHDh/9kIrSTLZvEOdCDIcGDqUpXpV6HIB4kd+eUgV/CIO
         TsXeAbm8rP8KP0WjRxscUeSM9b1bDsBQD5mlubzHC8woMgRxH0hCAoEa4SC8Na2oSbMU
         A6/un8jNq2a2sEe8ct1JezJOLCPdjUPIE9jmLaRgmZCSNhrT1/tkEpGY6NyXBuOr4tS3
         encJFLXhDMzaVkNkyZ1dYgjTaJgtst6ydY+naNi6nO6fv2qMzF+ouNGu0m9x2d5GIbR0
         6qreS9jcc/8F+L6ZDAkH0H1tu+YOHJN1kpv5EhDYSl6zUSK86lu0uz7riAHD8S2eVdGe
         60Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVyF0fgskp1NY+AK1nKAZv+J3wftR1IGOTmd0o1b7oGVna/f25HzBA63wMeWb+t2N5dLUZTF5LoaKfFOe8PssxMaKg9OAdTXj3tOMfE
X-Gm-Message-State: AOJu0YzE8FuXbMDt4hT4xEqBO4nZ4UqZBYZMbqrOf8R0ZF/MM7hLwTxq
	O8zKWyrpx2KrVUrGJMbEoiwsmNwKW389EUrLZQ9SoZfePo4dOUdTWOwk6sNp3/c=
X-Google-Smtp-Source: AGHT+IEhWGOMR5X97P8Fo2mgAd+J/etXVja+ifCzLsW/ZWUAvf+VNwo9A9i6JB4oljzk7wS6Jg1shA==
X-Received: by 2002:a2e:2c19:0:b0:2e9:84f9:3e17 with SMTP id 38308e7fff4ca-2eadce9253dmr14699141fa.50.1717758232226;
        Fri, 07 Jun 2024 04:03:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eae2c7e33esm1351191fa.0.2024.06.07.04.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:03:51 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:03:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	krzk+dt@kernel.org, neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 2/2] ASoC: codec: lpass-rx-macro: add suppor for 2.5
 codec version
Message-ID: <qjyuvejxvjfanhqi3xpgobqjuugh52okxiutdprprx43emee7t@gzh7go6yc77z>
References: <20240606122559.116698-1-srinivas.kandagatla@linaro.org>
 <20240606122559.116698-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606122559.116698-3-srinivas.kandagatla@linaro.org>

On Thu, Jun 06, 2024 at 01:25:59PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> LPASS Codec v2.5 has significant changes in the rx register offsets.
> Due to this headset playback on SM8550, SM8650, x1e80100 and all SoCs
> after SM8450 have only Left working.
> 
> This patch adjusts the registers to accomdate 2.5 changes. With this
> fixed now L and R are functional on Headset playback.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 565 ++++++++++++++++++++++--------
>  1 file changed, 410 insertions(+), 155 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index f35187d69cac..bb8ede0e7076 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -158,7 +158,7 @@
>  #define CDC_RX_INTR_CTRL_LEVEL0		(0x03C0)
>  #define CDC_RX_INTR_CTRL_BYPASS0	(0x03C8)
>  #define CDC_RX_INTR_CTRL_SET0		(0x03D0)
> -#define CDC_RX_RXn_RX_PATH_CTL(n)	(0x0400 + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_CTL(rx, n)	(0x0400  + rx->rxn_reg_offset * n)

It's probably a stride or pitch, not an offset.

>  #define CDC_RX_RX0_RX_PATH_CTL		(0x0400)
>  #define CDC_RX_PATH_RESET_EN_MASK	BIT(6)
>  #define CDC_RX_PATH_CLK_EN_MASK		BIT(5)
> @@ -166,45 +166,47 @@
>  #define CDC_RX_PATH_PGA_MUTE_MASK	BIT(4)
>  #define CDC_RX_PATH_PGA_MUTE_ENABLE	BIT(4)
>  #define CDC_RX_PATH_PCM_RATE_MASK	GENMASK(3, 0)
> -#define CDC_RX_RXn_RX_PATH_CFG0(n)	(0x0404 + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_CFG0(rx, n)	(0x0404  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RXn_COMP_EN_MASK		BIT(1)
>  #define CDC_RX_RX0_RX_PATH_CFG0		(0x0404)
>  #define CDC_RX_RXn_CLSH_EN_MASK		BIT(6)
>  #define CDC_RX_DLY_ZN_EN_MASK		BIT(3)
>  #define CDC_RX_DLY_ZN_ENABLE		BIT(3)
>  #define CDC_RX_RXn_HD2_EN_MASK		BIT(2)
> -#define CDC_RX_RXn_RX_PATH_CFG1(n)	(0x0408 + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_CFG1(rx, n)	(0x0408  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RXn_SIDETONE_EN_MASK	BIT(4)
>  #define CDC_RX_RX0_RX_PATH_CFG1		(0x0408)
>  #define CDC_RX_RX0_HPH_L_EAR_SEL_MASK	BIT(1)
> -#define CDC_RX_RXn_RX_PATH_CFG2(n)	(0x040C + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_CFG2(rx, n)	(0x040C  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RXn_HPF_CUT_FREQ_MASK	GENMASK(1, 0)
>  #define CDC_RX_RX0_RX_PATH_CFG2		(0x040C)
> -#define CDC_RX_RXn_RX_PATH_CFG3(n)	(0x0410 + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_CFG3(rx, n)	(0x0410  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RX0_RX_PATH_CFG3		(0x0410)
>  #define CDC_RX_DC_COEFF_SEL_MASK	GENMASK(1, 0)
>  #define CDC_RX_DC_COEFF_SEL_TWO		0x2
> -#define CDC_RX_RXn_RX_VOL_CTL(n)	(0x0414 + 0x80 * n)
> +#define CDC_RX_RXn_RX_VOL_CTL(rx, n)	(0x0414  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RX0_RX_VOL_CTL		(0x0414)
> -#define CDC_RX_RXn_RX_PATH_MIX_CTL(n)	(0x0418 + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_MIX_CTL(rx, n)	(0x0418  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RXn_MIX_PCM_RATE_MASK	GENMASK(3, 0)
>  #define CDC_RX_RXn_MIX_RESET_MASK	BIT(6)
>  #define CDC_RX_RXn_MIX_RESET		BIT(6)
>  #define CDC_RX_RXn_MIX_CLK_EN_MASK	BIT(5)
>  #define CDC_RX_RX0_RX_PATH_MIX_CTL	(0x0418)
>  #define CDC_RX_RX0_RX_PATH_MIX_CFG	(0x041C)
> -#define CDC_RX_RXn_RX_VOL_MIX_CTL(n)	(0x0420 + 0x80 * n)
> +#define CDC_RX_RXn_RX_VOL_MIX_CTL(rx, n)	(0x0420  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RX0_RX_VOL_MIX_CTL	(0x0420)
>  #define CDC_RX_RX0_RX_PATH_SEC1		(0x0424)
>  #define CDC_RX_RX0_RX_PATH_SEC2		(0x0428)
>  #define CDC_RX_RX0_RX_PATH_SEC3		(0x042C)
> +#define CDC_RX_RXn_RX_PATH_SEC3(rx, n)	(0x042c  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RX0_RX_PATH_SEC4		(0x0430)
>  #define CDC_RX_RX0_RX_PATH_SEC7		(0x0434)
> +#define CDC_RX_RXn_RX_PATH_SEC7(rx, n)	(0x0434  + rx->rxn_reg_offset * n)
>  #define CDC_RX_DSM_OUT_DELAY_SEL_MASK	GENMASK(2, 0)
>  #define CDC_RX_DSM_OUT_DELAY_TWO_SAMPLE	0x2
>  #define CDC_RX_RX0_RX_PATH_MIX_SEC0	(0x0438)
>  #define CDC_RX_RX0_RX_PATH_MIX_SEC1	(0x043C)
> -#define CDC_RX_RXn_RX_PATH_DSM_CTL(n)	(0x0440 + 0x80 * n)
> +#define CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)	(0x0440  + rx->rxn_reg_offset * n)
>  #define CDC_RX_RXn_DSM_CLK_EN_MASK	BIT(0)
>  #define CDC_RX_RX0_RX_PATH_DSM_CTL	(0x0440)
>  #define CDC_RX_RX0_RX_PATH_DSM_DATA1	(0x0444)
> @@ -213,6 +215,7 @@
>  #define CDC_RX_RX0_RX_PATH_DSM_DATA4	(0x0450)
>  #define CDC_RX_RX0_RX_PATH_DSM_DATA5	(0x0454)
>  #define CDC_RX_RX0_RX_PATH_DSM_DATA6	(0x0458)
> +/* RX offsets prior to 2.5 codec version */
>  #define CDC_RX_RX1_RX_PATH_CTL		(0x0480)
>  #define CDC_RX_RX1_RX_PATH_CFG0		(0x0484)
>  #define CDC_RX_RX1_RX_PATH_CFG1		(0x0488)
> @@ -259,10 +262,58 @@
>  #define CDC_RX_RX2_RX_PATH_MIX_SEC0	(0x0544)
>  #define CDC_RX_RX2_RX_PATH_MIX_SEC1	(0x0548)
>  #define CDC_RX_RX2_RX_PATH_DSM_CTL	(0x054C)
> +
> +/* LPASS CODEC version 2.5 rx reg offsets */

Please separate 2.5 support into a separate patch.

> +#define CDC_2_5_RX_RX1_RX_PATH_CTL		(0x04c0)
> +#define CDC_2_5_RX_RX1_RX_PATH_CFG0		(0x04c4)
> +#define CDC_2_5_RX_RX1_RX_PATH_CFG1		(0x04c8)
> +#define CDC_2_5_RX_RX1_RX_PATH_CFG2		(0x04cC)
> +#define CDC_2_5_RX_RX1_RX_PATH_CFG3		(0x04d0)
> +#define CDC_2_5_RX_RX1_RX_VOL_CTL		(0x04d4)
> +#define CDC_2_5_RX_RX1_RX_PATH_MIX_CTL		(0x04d8)
> +#define CDC_2_5_RX_RX1_RX_PATH_MIX_CFG		(0x04dC)
> +#define CDC_2_5_RX_RX1_RX_VOL_MIX_CTL		(0x04e0)
> +#define CDC_2_5_RX_RX1_RX_PATH_SEC1		(0x04e4)
> +#define CDC_2_5_RX_RX1_RX_PATH_SEC2		(0x04e8)
> +#define CDC_2_5_RX_RX1_RX_PATH_SEC3		(0x04eC)
> +#define CDC_2_5_RX_RX1_RX_PATH_SEC4		(0x04f0)
> +#define CDC_2_5_RX_RX1_RX_PATH_SEC7		(0x04f4)
> +#define CDC_2_5_RX_RX1_RX_PATH_MIX_SEC0		(0x04f8)
> +#define CDC_2_5_RX_RX1_RX_PATH_MIX_SEC1		(0x04fC)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_CTL		(0x0500)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_DATA1	(0x0504)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_DATA2	(0x0508)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_DATA3	(0x050C)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_DATA4	(0x0510)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_DATA5	(0x0514)
> +#define CDC_2_5_RX_RX1_RX_PATH_DSM_DATA6	(0x0518)
> +
> +#define CDC_2_5_RX_RX2_RX_PATH_CTL		(0x0580)
> +#define CDC_2_5_RX_RX2_RX_PATH_CFG0		(0x0584)
> +#define CDC_2_5_RX_RX2_RX_PATH_CFG1		(0x0588)
> +#define CDC_2_5_RX_RX2_RX_PATH_CFG2		(0x058C)
> +#define CDC_2_5_RX_RX2_RX_PATH_CFG3		(0x0590)
> +#define CDC_2_5_RX_RX2_RX_VOL_CTL		(0x0594)
> +#define CDC_2_5_RX_RX2_RX_PATH_MIX_CTL		(0x0598)
> +#define CDC_2_5_RX_RX2_RX_PATH_MIX_CFG		(0x059C)
> +#define CDC_2_5_RX_RX2_RX_VOL_MIX_CTL		(0x05a0)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC0		(0x05a4)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC1		(0x05a8)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC2		(0x05aC)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC3		(0x05b0)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC4		(0x05b4)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC5		(0x05b8)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC6		(0x05bC)
> +#define CDC_2_5_RX_RX2_RX_PATH_SEC7		(0x05c0)
> +#define CDC_2_5_RX_RX2_RX_PATH_MIX_SEC0		(0x05c4)
> +#define CDC_2_5_RX_RX2_RX_PATH_MIX_SEC1		(0x05c8)
> +#define CDC_2_5_RX_RX2_RX_PATH_DSM_CTL		(0x05cC)
> +
>  #define CDC_RX_IDLE_DETECT_PATH_CTL	(0x0780)
>  #define CDC_RX_IDLE_DETECT_CFG0		(0x0784)
>  #define CDC_RX_IDLE_DETECT_CFG1		(0x0788)
>  #define CDC_RX_IDLE_DETECT_CFG2		(0x078C)
> +
>  #define CDC_RX_IDLE_DETECT_CFG3		(0x0790)
>  #define CDC_RX_COMPANDERn_CTL0(n)	(0x0800 + 0x40 * n)
>  #define CDC_RX_COMPANDERn_CLK_EN_MASK	BIT(0)
> @@ -598,6 +649,8 @@ struct rx_macro {
>  	int rx_mclk_users;
>  	int clsh_users;
>  	int rx_mclk_cnt;
> +	int codec_version;
> +	int rxn_reg_offset;
>  	bool is_ear_mode_on;
>  	bool hph_pwr_mode;
>  	bool hph_hd2_mode;
> @@ -755,11 +808,15 @@ static SOC_ENUM_SINGLE_DECL(rx_int1_2_interp_enum, SND_SOC_NOPM, 0,
>  			    rx_int1_2_interp_mux_text);
>  static SOC_ENUM_SINGLE_DECL(rx_int2_2_interp_enum, SND_SOC_NOPM, 0,
>  			    rx_int2_2_interp_mux_text);
> +

unrelated?

>  static SOC_ENUM_SINGLE_DECL(rx_int0_dem_inp_enum, CDC_RX_RX0_RX_PATH_CFG1, 0,
>  			    rx_int_dem_inp_mux_text);
>  static SOC_ENUM_SINGLE_DECL(rx_int1_dem_inp_enum, CDC_RX_RX1_RX_PATH_CFG1, 0,
>  			    rx_int_dem_inp_mux_text);
>  
> +static SOC_ENUM_SINGLE_DECL(rx_2_5_int1_dem_inp_enum, CDC_2_5_RX_RX1_RX_PATH_CFG1, 0,
> +			    rx_int_dem_inp_mux_text);
> +
>  static SOC_ENUM_SINGLE_DECL(rx_macro_rx0_enum, SND_SOC_NOPM, 0, rx_macro_mux_text);
>  static SOC_ENUM_SINGLE_DECL(rx_macro_rx1_enum, SND_SOC_NOPM, 0, rx_macro_mux_text);
>  static SOC_ENUM_SINGLE_DECL(rx_macro_rx2_enum, SND_SOC_NOPM, 0, rx_macro_mux_text);

[skipped all split default + add 2.5] chunks

>  static int rx_macro_component_probe(struct snd_soc_component *component)
>  {
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
>  	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
> +	const struct snd_soc_dapm_widget *widgets;
> +	const struct snd_kcontrol_new *controls;
> +	unsigned int num_controls;
> +	int ret, num_widgets;
>  
>  	snd_soc_component_init_regmap(component, rx->regmap);
>  
> -	snd_soc_component_update_bits(component, CDC_RX_RX0_RX_PATH_SEC7,
> +	snd_soc_component_update_bits(component, CDC_RX_RXn_RX_PATH_SEC7(rx, 0),
>  				      CDC_RX_DSM_OUT_DELAY_SEL_MASK,
>  				      CDC_RX_DSM_OUT_DELAY_TWO_SAMPLE);
> -	snd_soc_component_update_bits(component, CDC_RX_RX1_RX_PATH_SEC7,
> +	snd_soc_component_update_bits(component, CDC_RX_RXn_RX_PATH_SEC7(rx, 1),
>  				      CDC_RX_DSM_OUT_DELAY_SEL_MASK,
>  				      CDC_RX_DSM_OUT_DELAY_TWO_SAMPLE);
> -	snd_soc_component_update_bits(component, CDC_RX_RX2_RX_PATH_SEC7,
> +	snd_soc_component_update_bits(component, CDC_RX_RXn_RX_PATH_SEC7(rx, 2),
>  				      CDC_RX_DSM_OUT_DELAY_SEL_MASK,
>  				      CDC_RX_DSM_OUT_DELAY_TWO_SAMPLE);
> -	snd_soc_component_update_bits(component, CDC_RX_RX0_RX_PATH_CFG3,
> +	snd_soc_component_update_bits(component, CDC_RX_RXn_RX_PATH_CFG3(rx, 0),
>  				      CDC_RX_DC_COEFF_SEL_MASK,
>  				      CDC_RX_DC_COEFF_SEL_TWO);
> -	snd_soc_component_update_bits(component, CDC_RX_RX1_RX_PATH_CFG3,
> +	snd_soc_component_update_bits(component, CDC_RX_RXn_RX_PATH_CFG3(rx, 1),
>  				      CDC_RX_DC_COEFF_SEL_MASK,
>  				      CDC_RX_DC_COEFF_SEL_TWO);
> -	snd_soc_component_update_bits(component, CDC_RX_RX2_RX_PATH_CFG3,
> +	snd_soc_component_update_bits(component, CDC_RX_RXn_RX_PATH_CFG3(rx, 2),
>  				      CDC_RX_DC_COEFF_SEL_MASK,
>  				      CDC_RX_DC_COEFF_SEL_TWO);
>  
> +	if (rx->codec_version >= LPASS_CODEC_VERSION_2_5) {
> +		controls = rx_macro_2_5_snd_controls;
> +		num_controls = ARRAY_SIZE(rx_macro_2_5_snd_controls);
> +		widgets = rx_macro_2_5_dapm_widgets;
> +		num_widgets = ARRAY_SIZE(rx_macro_2_5_dapm_widgets);
> +	} else {
> +		controls = rx_macro_def_snd_controls;
> +		num_controls = ARRAY_SIZE(rx_macro_def_snd_controls);
> +		widgets = rx_macro_def_dapm_widgets;
> +		num_widgets = ARRAY_SIZE(rx_macro_def_dapm_widgets);
> +	}
> +
>  	rx->component = component;
>  
> -	return 0;
> +	ret = snd_soc_add_component_controls(component, controls, num_controls);
> +	if (ret)
> +		return ret;
> +
> +	return snd_soc_dapm_new_controls(dapm, widgets, num_widgets);
>  }
>  
>  static int swclk_gate_enable(struct clk_hw *hw)
> @@ -3523,11 +3748,12 @@ static const struct snd_soc_component_driver rx_macro_component_drv = {
>  
>  static int rx_macro_probe(struct platform_device *pdev)
>  {
> +	struct reg_default *reg_defaults;
>  	struct device *dev = &pdev->dev;
>  	kernel_ulong_t flags;
>  	struct rx_macro *rx;
>  	void __iomem *base;
> -	int ret;
> +	int ret, def_count;
>  
>  	flags = (kernel_ulong_t)device_get_match_data(dev);
>  
> @@ -3567,6 +3793,33 @@ static int rx_macro_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	rx->codec_version = lpass_macro_get_codec_version();

What guarantees that VA macro has been probed already? If I'm not
mistaken, we might easily get a default '0' here instead of a correct
version.

> +	switch (rx->codec_version) {
> +	case LPASS_CODEC_VERSION_2_5 ... LPASS_CODEC_VERSION_2_8:
> +		rx->rxn_reg_offset = 0xc0;
> +		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
> +		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
> +		if (!reg_defaults)
> +			return -ENOMEM;
> +		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
> +		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
> +				rx_2_5_defaults, sizeof(rx_2_5_defaults));
> +		break;
> +	default:
> +		rx->rxn_reg_offset = 0x80;
> +		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
> +		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
> +		if (!reg_defaults)
> +			return -ENOMEM;
> +		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
> +		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
> +				rx_pre_2_5_defaults, sizeof(rx_pre_2_5_defaults));
> +		break;
> +	}
> +
> +	rx_regmap_config.reg_defaults = reg_defaults,
> +	rx_regmap_config.num_reg_defaults = def_count;
> +
>  	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
>  	if (IS_ERR(rx->regmap)) {
>  		ret = PTR_ERR(rx->regmap);
> @@ -3629,6 +3882,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clkout;
>  
> +	kfree(reg_defaults);
>  	return 0;
>  
>  err_clkout:
> @@ -3642,6 +3896,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>  err_dcodec:
>  	clk_disable_unprepare(rx->macro);
>  err:
> +	kfree(reg_defaults);
>  	lpass_macro_pds_exit(rx->pds);
>  
>  	return ret;
> -- 
> 2.21.0
> 

-- 
With best wishes
Dmitry

