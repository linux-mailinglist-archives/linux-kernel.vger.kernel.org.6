Return-Path: <linux-kernel+bounces-385285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633BA9B3509
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2809728291F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B381DE3AA;
	Mon, 28 Oct 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfp3OCps"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A751DE2D8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129850; cv=none; b=QltxzJ4wgCMpHd0isvocLmm1xD7fTyXRyxd9jelEGepghTMm3E2OfL91Na/CTVWX8n3WRIfbfPo3aQ1Lg7TadZGUNMSVFT1lGbeVFG2k0LnB57UMEoKTjkiLa3Bb4fh2QD3VWa69QPD3re1HnQwtqiiMG4cJV5nv4DE37liQ5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129850; c=relaxed/simple;
	bh=XY8IqEjmiR/k6mOfN74XcFBXQneq68BIlwqWEmj5YnI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=fkQLtvx7DMao/H8a7b0o+1Ol558tqRmsCKPhFeDTLlVGE6fghWIayMIzcczfaTh+7jQsttF46OAz4Q4TB80Yq1T7+I1XY0QyeqkUVfihW3B2qOo9damiG19vUJICKTh3Vzfs+kXxgg5OybS/f1EGSaemkVmlNuTm+ETkQ9jlGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfp3OCps; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4551318e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730129846; x=1730734646; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=7e74bDnvczhbgPY2hFm8VtRHbs4Ka+p6FF5bmoD6B5w=;
        b=dfp3OCps1S1mtO9li2mEKy0lyfaoWN05TaDpg0NX+6gB0WXiy1AFo3781RSrnQ8Cpr
         9O3RI3+XVlMxQqpSiltNUOb62SemMwvbYHltAJ6M/KIyN3kFYL9eZcDzkftiCf9Bpy+j
         S5oO/w4WI4PMYuF+SKC6/xLd1YffRtGalBoU5vlmIO8oEJ29a0kSZX/8zMrcRXX5XDz7
         l2EVZ8iuuGtPvun9RAl3wTfn8vxtGYn38DIKYkv2v3++chHRc3U/1LorPofIIOIGnAzU
         rDnUeTwgeLhoQuKMMfgYlnAQs+b1EDGczPoQHqnyRB+do7w5bG3spp9hRE7FpDqEoVUE
         Cskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129846; x=1730734646;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e74bDnvczhbgPY2hFm8VtRHbs4Ka+p6FF5bmoD6B5w=;
        b=gfxkTfJTEWp9vG34Qq39/c5NwGJA1ASzmvruzo1R9KQ1zmxVpxa+/biOwFu5RfXjLG
         ryBisXiogEjjD3ecGg9DychXcggmLTKjOOLoIa5Lhkf78SsR1ob5HzvPp25TG96gEkk5
         ja8jBmYFelJZZ2c34H8kE6D9dnGud4X+v3SdQGP4AFOjZCGPsIrr1S7kEF1E/B9UBJ9U
         BCeARW6kOS5NM1/YQu61jDYeLoB0XYTWAGtBXx7oHaXSn+g6z0+c76veHw/YpAlthapg
         xXkPe7/eQTC5gEUKT41uX5imfB/Sg+z38T4ockb1+u/UiSSTlwo4gLedM/4gsHANxhwm
         vJGg==
X-Gm-Message-State: AOJu0YwjtN7E6LPaoAZfeepvgfweO2uB535GEAoGWeBu/odkAmIP7PQw
	slrAA2xKCvNyL+x5RTfmR91jQycg8A0vFrb2GkORwzG46H6V1TIa
X-Google-Smtp-Source: AGHT+IEKqRcc/BlM5jdtPFigKOcuoyKaziXHTFpzuCBlf/+AQSM1aLQDV5fQ2Q5I6XrKnFzSoZmINQ==
X-Received: by 2002:a05:6512:401f:b0:52c:9383:4c16 with SMTP id 2adb3069b0e04-53b348cea2amr3986159e87.22.1730129845496;
        Mon, 28 Oct 2024 08:37:25 -0700 (PDT)
Received: from razdolb ([45.12.135.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1dcbbdsm1110984e87.236.2024.10.28.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:37:24 -0700 (PDT)
References: <20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.4.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
    Mark Brown <broonie@kernel.org>,
    Alex Bee <knaerzche@gmail.com>,
    Lee Jones <lee@kernel.org>,
    Quentin Schulz <foss+kernel@0leil.net>,
    Linus Walleij <linus.walleij@linaro.org>,
    Chris Zhong <zyw@rock-chips.com>,
    Zhang Qing <zhangqing@rock-chips.com>,
    Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: Re: [PATCH] regulator: rk808: Add apply_bit for BUCK3 on RK809
Date: Mon, 28 Oct 2024 18:20:55 +0300
In-reply-to: <20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com>
Message-ID: <87v7xcp7bh.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gentle ping.

Also Cc more potential reviewers.

On 2024-10-17 at 21:37 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:

> Currently, RK809's BUCK3 regulator is modelled in the driver as a
> configurable regulator with 0.5-2.4V voltage range. But the voltage
> setting is not actually applied, because when bit 6 of
> PMIC_POWER_CONFIG register is set to 0 (default), BUCK3 output voltage
> is determined by the external feedback resistor. Fix this, by setting
> bit 6 when voltage selection is set. Existing users which do not
> specify voltage constraints in their device trees will not be affected
> by this change, since no voltage setting is applied in those cases,
> and bit 6 is not enabled.
>
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/regulator/rk808-regulator.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
> index 14b60abd6afc..01a8d0487918 100644
> --- a/drivers/regulator/rk808-regulator.c
> +++ b/drivers/regulator/rk808-regulator.c
> @@ -1379,6 +1379,8 @@ static const struct regulator_desc rk809_reg[] = {
>  		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
>  		.vsel_reg = RK817_BUCK3_ON_VSEL_REG,
>  		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.apply_reg = RK817_POWER_CONFIG,
> +		.apply_bit = RK817_BUCK3_FB_RES_INTER,
>  		.enable_reg = RK817_POWER_EN_REG(0),
>  		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
>  		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),
>
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241017-rk809-dcdc3-388632b4da03
>

--
Best regards,
Mikhail Rudenko

