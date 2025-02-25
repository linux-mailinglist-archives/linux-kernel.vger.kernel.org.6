Return-Path: <linux-kernel+bounces-531605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29463A44277
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CD27A83E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5B26D5A4;
	Tue, 25 Feb 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="nIsJWFUV"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758926A1B4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493255; cv=none; b=eu+H36cu4zaCWlqb+rkMBh+K9NWJRil27ye/sWiqRg2MqB1eFPQqRI2dLbj4m3+kMcycmot61Cbch3OJLtOhhVz9gEnLmQH/wPHg2LaWJSbEHpSRom5QU1h9ims3zJMZBhYTpEDT0Fm0mjEyu+jNAMRDhTrvuzYThD6Tqyv0VHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493255; c=relaxed/simple;
	bh=4aRVcR1MtxzUuDinO58olTCgo2qDQEdNqepuqBaC/20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USM7iuzc4KBq9mpZG+5DCEYk+78PQuuvurDn3Ep4Gi7SEI3ZJSfQzHqLHJefa/zXAVIyqgXiOQR6LA9f6GKdA6W3KMpUAWPFxqDMAgBq9a8XYIyan5xTIG/3LJKQL3IYAnkmemzxkUxc9pztmXZI2wH6XhT8g9zSbur2c3MAgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=nIsJWFUV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so4593661276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1740493252; x=1741098052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLGj3f01/5YqskB/AMHKol9KSvNGpbV7f974e7GtQ0U=;
        b=nIsJWFUVPNvfheUD0MUZufKF654v4pxGi87gALKIYaHHUUQuyeU5xFijZM0cJ2RYqG
         phYCIFwesyEK4kRNVgrTrDApp8aDCjaF5XMJTh7oYacvAvPFUdcOTA+mrm2veSm5OA9O
         rnjDunJ8Itk42bUf8qlqQVQm72kx2oZAhSFLglqTIg15K0WShjUmB2Z/FExjSaV16wI2
         WDu6gUMuEFpU8Z1OzSNdXYShzINVOrzpRN8pYUsqtGayndG9ykZkzx1tzcCarUrdl2uP
         Crg/YSNkSq3i9dmLuA5s/fLI4baibikpicY8gAVfxBRDrYjs3lnku29eFfDLOn7t979l
         bbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493252; x=1741098052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLGj3f01/5YqskB/AMHKol9KSvNGpbV7f974e7GtQ0U=;
        b=guKZXrkooDd7DUkHuRKOyIpG2BgMgEAGiWT2bJ7xPOfG4Quz5TuKWJJa5DdhGbikkm
         /TdTxcBRxdFAAQ5IcaK3SuYqw0pc9Lqy7dMKUwfQcylO/Q0yeafKZv8PjeZBeR2xfxUg
         Jyv9PY0woC6nSwLp4oEPGpYhcUhl1Ir4aM6JXjwM+VTYOgcHuKthjvJ5HeZ73shrGfw5
         EG3TGIt2W1SDGdO8QhQiCgr5W9LuMEYFuZLr68oizGyFJlpF+RNNXP265q40B08XBxB1
         KR25iUIxmGOheXJUSn91OrV2LoYMbLSyR5Ux/WSZAUXCdNsTElWcJ6EOX6QJUjLpN0Hu
         +gLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUVolD+T/YUAosny5uC73Slj6B4sKRJJHslnO0YuEX6JEi2orReYtFpBHGjpz50VAXEdVUbNJlJ39woWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFynJ9RrSY4OIyqyO5AQaAtNezcpHGEas4hXTkalMEGnMElm4
	l6OvnLd7C8QOVUb0JVqBfE6wtE287Uv8eZHI75RP3vW4YTedcwk9ph/E6nqlUT914iw9uymigdI
	QN769fE0xAxiezEfWXi3ilVmRYCgN0fcTC2Sxbw==
X-Gm-Gg: ASbGncvg4Dh1XqYoFOQUlO2c1uD6SVEfEgMP/5nmB0qZpc6uYUHlg4DZvSxVYf45/tB
	GP3x4IuSXLP7DyaHHdc0DpQKKhbCIeCLJKrg4scPaLUFiwKXEhNSEWrOhqaDv+Xu7O4uyJbeeV/
	nOuXP2DSyoK3G4PxaPCvQB6ErKI2kXaGb6lIYG424=
X-Google-Smtp-Source: AGHT+IENualTBjQ0gC23IsPS4Y3OAVTdoidslIODPAXgztEQkt/QwuDATXiFsWJ/F2T2gnPhUdShHIX8sQEr6smL7nA=
X-Received: by 2002:a05:6902:2493:b0:e5b:43dd:cf18 with SMTP id
 3f1490d57ef6-e5e2490dc3amr14360779276.22.1740493251235; Tue, 25 Feb 2025
 06:20:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-b4-ov9282-gain-v1-0-a24af2820dde@linux.dev> <20250225-b4-ov9282-gain-v1-2-a24af2820dde@linux.dev>
In-Reply-To: <20250225-b4-ov9282-gain-v1-2-a24af2820dde@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 25 Feb 2025 14:20:34 +0000
X-Gm-Features: AQ5f1JpnFy2Fej1Tv3LO4JDgq3THZkPkBcXgbtSirWhgQwozrTWSiHSj1Na7Bi0
Message-ID: <CAPY8ntCoerdGgM1CjLWzNPx-0gACR1O9yaccRoHByq-B3D-rJg@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: i2c: ov9282: add AEC Manual register definition
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Richard

Thanks for the patch

On Tue, 25 Feb 2025 at 13:09, Richard Leitner <richard.leitner@linux.dev> wrote:
>
> Add #define's for the "AEC MANUAL" (0x3503) register and its
> values/flags. Use those in the registers single usage within the
> `common_regs` struct.
>
> All values are based on the OV9281 datasheet v1.01 (09.18.2015).
>
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/ov9282.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index c926842257893c4da3319b847fab9908b5bdaec6..c882a021cf18852237bf9b9524d3de0c5b48cbcb 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -44,6 +44,15 @@
>  #define OV9282_EXPOSURE_STEP   1
>  #define OV9282_EXPOSURE_DEFAULT        0x0282
>
> +/* AEC/AGC manual */
> +#define OV9282_REG_AEC_MANUAL          0x3503
> +#define OV9282_DIGFRAC_GAIN_DELAY      BIT(6)
> +#define OV9282_GAIN_CHANGE_DELAY       BIT(5)
> +#define OV9282_GAIN_DELAY              BIT(4)
> +#define OV9282_GAIN_PREC16_EN          BIT(3)
> +#define OV9282_GAIN_MANUAL_AS_SENSGAIN BIT(2)
> +#define OV9282_AEC_MANUAL_DEFAULT      0x00
> +
>  /* Analog gain control */
>  #define OV9282_REG_AGAIN       0x3509
>  #define OV9282_AGAIN_MIN       0x10
> @@ -214,7 +223,7 @@ static const struct ov9282_reg common_regs[] = {
>         {0x3030, 0x10},
>         {0x3039, 0x32},
>         {0x303a, 0x00},
> -       {0x3503, 0x08},
> +       {OV9282_REG_AEC_MANUAL, OV9282_GAIN_PREC16_EN},
>         {0x3505, 0x8c},
>         {0x3507, 0x03},
>         {0x3508, 0x00},
>
> --
> 2.47.2
>
>

