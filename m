Return-Path: <linux-kernel+bounces-188553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162438CE352
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355B81C2157B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7C84FCE;
	Fri, 24 May 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgfcu2z1"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C26E615
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542970; cv=none; b=fUuAMCIvRF6dc5EMkhMz+dZ7yPrhegn7xiGjpiwgSaO2p/nlkvRHiJOM/40mtRic2DcxgNYtce5uY8cwku8LbEGEU0d+0ysNbNMlS/gjtdn+DSIG/ncyRdXJUHqNP1JSr0ryR3k+FD38gLY4KMC+QueGXg1GESO5/zAffpw6C/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542970; c=relaxed/simple;
	bh=IBAnQ9CMDXIKWvV3wLZ+swiAC1EyC37vO4/qOtqoCMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtP6IWMrOnSU7o7HJjLSBB6sc/5ZbCjDJTu8tZDmGHTWoZmuvaqUa8CxdcfF6R+Gsma9Na7Cmt5hRsvxOgQZYhkHT5rf8csEBRgPutDGi1h4ZdVE2Le0FxN7Hm4IGco70vvD1Cqaalq4HBSkRMlpc9ivMhfkdc9Yh+ZGsY0hBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgfcu2z1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df475159042so6361406276.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716542967; x=1717147767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P22112kFA90ysUyH7aovtgsokvUOX3eAoJT9LIJl3U0=;
        b=bgfcu2z1QZ6L3HdKDCAYPMoL9pFCBtI1g7qWpfB1rveE2HjnM9yZOD0uq+uLoJi6NF
         p6CN7nsMEdmwRQzuTYf35A4zNpwnf0CrngOjZHC8F2X28In1HiNH8hKNFIFcHvTmOyde
         aSiKTFqH1JvosHvNo5RZ/ihFLhmKAOvMZhDoZHFoZ5ZkQYHb9/4Z8Ktn9bzoeJHZS/Ce
         L6bf3OsNaVdZgiT/2kJiahpJiLMZNYpy9HP/6rMO5kh0RFkWqHJ1/lntYPMuHCK/RLf4
         WoonNVsxZrVzVouWLycGTCSquKPgpVwyZ9Xi6duYsNs4MWsB/yxysC3+htvqfKajZCnj
         MUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716542967; x=1717147767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P22112kFA90ysUyH7aovtgsokvUOX3eAoJT9LIJl3U0=;
        b=ATmg5fHTcEPByrarBPfrPjlyDBWPRBQ7qoGRlSm9XpxNNgV7StudwP2JVm1vFzhrV+
         mgWxZLjIP2hS5vnw2VYUsGbG98lZbkgLDreBwbi/5xhV8u0TLmbMYx6Q3rknHgJHBCTg
         pj6JCbhICn+wsNDHD6ixK2e03qwmyurVOr+FfS8yM0m4zOu0ca3+TUNLtqLW9ypdofkN
         BdPTmTufVwxonROSbmnsdfLP3IkpL8cVy9Csxq6FkqbmHx15ZkzF6n6d2kzcS+/VbnPk
         jwKrriwyCkI+aoj6bZP0uNGg7RSZ17PlcYJMbBib+d2RAm3dN6HKybMzrLON/T3RQkJF
         CatA==
X-Forwarded-Encrypted: i=1; AJvYcCWQC+rqWba4KJMi/JDDf0iR0Oso7LxViF5ELFpwqZKd3+zHrssWGFszWGrwxSjwJ1xhajXXpmsp78+73CCj6KVe6YMkS/ltx5/aZQ52
X-Gm-Message-State: AOJu0YzsKTV8nrzombtc/HWDzTRKyWUXBPZ3LvCU+IFUYuFGry+/H+7v
	i2pgoxs0xUAPDQ/DeUhngf3zoWUYLE5S0d1H5TYUj8ylod2fu2OExwhcgLN9vLRf4sMpoxEcLuX
	gAiDRB2HQlVFtE2oBlbPlJJ9KfD12unxEtwE34g==
X-Google-Smtp-Source: AGHT+IH5kMYZ/J9vZ252zm8A3SdbGG9Q4CU9lCHy4KU17bWRixODcdgT+jPb7hSuOZsaT0YhwZFPjRji7j89YbQD+8E=
X-Received: by 2002:a25:add9:0:b0:de5:f0ef:788e with SMTP id
 3f1490d57ef6-df77219deb4mr1663549276.20.1716542967414; Fri, 24 May 2024
 02:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524082236.24112-1-quic_kbajaj@quicinc.com>
In-Reply-To: <20240524082236.24112-1-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 24 May 2024 12:29:16 +0300
Message-ID: <CAA8EJpp9U-ucMAiNmVvWDuupd=OR_fLK9fQ+n21SVmktWMxhmA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: qdu/qru1000-idp: Fix the voltage setting
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Melody Olvera <quic_molvera@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 11:23, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> While adding the USB support, it was found that the configuration
> for regulator smps5 was incorrectly set. Upon cross verifying for
> all the regulators, found that smps4, smps6 and smps8 are also
> incorrectly configured. This patch fixes the same.

Nit: see Documentation/process/submitting-patches.rst, "This patch..."

> In particular -
> - smps4 is 1.574V min and 2.04V max
> - smps5 is 1.2V min and 1.4V max
> - smps6 is 0.382V min and 1.12V max

Just for my understanding, will anything further constraint these values?

> - smps8 is fixed at 0.752V
>
> Fixes: d1f2cfe2f669 ("arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs")
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
> Changes in v2-
> * Updated the commit message as suggested by Krzysztof
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240514131038.28036-1-quic_kbajaj@quicinc.com/
> ---
>
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 6e129dc123ed..89b84fb0f70a 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -96,20 +96,20 @@ vreg_s3a_1p05: smps3 {
>
>                 vreg_s4a_1p8: smps4 {
>                         regulator-name = "vreg_s4a_1p8";
> -                       regulator-min-microvolt = <1800000>;
> -                       regulator-max-microvolt = <1800000>;
> +                       regulator-min-microvolt = <1574000>;
> +                       regulator-max-microvolt = <2040000>;
>                 };
>
>                 vreg_s5a_2p0: smps5 {
>                         regulator-name = "vreg_s5a_2p0";
> -                       regulator-min-microvolt = <1904000>;
> -                       regulator-max-microvolt = <2000000>;
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1400000>;
>                 };
>
>                 vreg_s6a_0p9: smps6 {
>                         regulator-name = "vreg_s6a_0p9";
> -                       regulator-min-microvolt = <920000>;
> -                       regulator-max-microvolt = <1128000>;
> +                       regulator-min-microvolt = <382000>;
> +                       regulator-max-microvolt = <1120000>;
>                 };
>
>                 vreg_s7a_1p2: smps7 {
> @@ -120,8 +120,8 @@ vreg_s7a_1p2: smps7 {
>
>                 vreg_s8a_1p3: smps8 {
>                         regulator-name = "vreg_s8a_1p3";
> -                       regulator-min-microvolt = <1352000>;
> -                       regulator-max-microvolt = <1352000>;
> +                       regulator-min-microvolt = <752000>;
> +                       regulator-max-microvolt = <752000>;
>                 };
>
>                 vreg_l1a_0p91: ldo1 {
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> index 2a862c83309e..258483af065b 100644
> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -96,20 +96,20 @@ vreg_s3a_1p05: smps3 {
>
>                 vreg_s4a_1p8: smps4 {
>                         regulator-name = "vreg_s4a_1p8";
> -                       regulator-min-microvolt = <1800000>;
> -                       regulator-max-microvolt = <1800000>;
> +                       regulator-min-microvolt = <1574000>;
> +                       regulator-max-microvolt = <2040000>;
>                 };
>
>                 vreg_s5a_2p0: smps5 {
>                         regulator-name = "vreg_s5a_2p0";
> -                       regulator-min-microvolt = <1904000>;
> -                       regulator-max-microvolt = <2000000>;
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1400000>;
>                 };
>
>                 vreg_s6a_0p9: smps6 {
>                         regulator-name = "vreg_s6a_0p9";
> -                       regulator-min-microvolt = <920000>;
> -                       regulator-max-microvolt = <1128000>;
> +                       regulator-min-microvolt = <382000>;
> +                       regulator-max-microvolt = <1120000>;
>                 };
>
>                 vreg_s7a_1p2: smps7 {
> @@ -120,8 +120,8 @@ vreg_s7a_1p2: smps7 {
>
>                 vreg_s8a_1p3: smps8 {
>                         regulator-name = "vreg_s8a_1p3";
> -                       regulator-min-microvolt = <1352000>;
> -                       regulator-max-microvolt = <1352000>;
> +                       regulator-min-microvolt = <752000>;
> +                       regulator-max-microvolt = <752000>;
>                 };
>
>                 vreg_l1a_0p91: ldo1 {
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

