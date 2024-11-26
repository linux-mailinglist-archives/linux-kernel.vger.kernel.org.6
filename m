Return-Path: <linux-kernel+bounces-422398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22A9D9924
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647831660A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954F1D5AB7;
	Tue, 26 Nov 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUvUvxKt"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953501D47B5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630121; cv=none; b=lujhu871rHaSud2rHYAha/y6W5seBzcka9Fue+lGFP/B4k40Jp2Mw9J0x4BHncoGj4fmfpdOMqKFr8i1FNQG8fLpzRQtcC5WThgaEcHawEX4rk+GTMavy5KfxJYcTjTMoNGJiz3i3yTan1cx+VwoXxWJRp1ZuDxyGBQXrMckLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630121; c=relaxed/simple;
	bh=TBFDk6n5p3Ok7a9f59nLR0qfFhfTz84rCQHeYRhiemA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjhxbbL96x2v06cx20bTifG/cFzAwwHwbfXPkn8+MM5UifveB55SNrVvD2LlUmekaDFghcalbHcjSg2adpq3l6e4NQzllaUvZpRPTViaHoD9tHDCeMviAbDJN5ZfpqYv6NN2kYl7yydmcyr+fht2eF3NKokEpfzav/t3ODx/TtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUvUvxKt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so2801541e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732630118; x=1733234918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9nEgjsuX9i9WDOFc1qk+82AoXsJqVH3Z5AhmpQUDqg=;
        b=vUvUvxKt0vftjSjpeoPl43LExwpTzX/8w28h0n2Pz2cEqibpV+zOoRucZd/fBqejC5
         XFYkXelICNkaIc07LQwG8NPPumgfaCNvgXyMTVbFmaI6k6jBdRXBD6nswBxStacDA+qL
         zjKdpNkC3OU6k+gQwCQ1w98gX4l5XBLErQvIpHuS7glkLW+n/jRAKSYQpX1EqpiAKWMw
         gu0yrEEKoz8va1GsowOtorGMd343XgFOj2kdzYBGufC0buBMBNAph3Mnxwk9YKzvEzcj
         +XI3HJh1u8LI3XCyXPr5qL6aSAUh9K8rZKHBoPgFvIsmrK7aXjFIRuIVPWwiuo1RZ0e3
         pK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732630118; x=1733234918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9nEgjsuX9i9WDOFc1qk+82AoXsJqVH3Z5AhmpQUDqg=;
        b=WItttZk6d84KD65d4lfVt+7NPHQ72xrtEsiUwyPjrBe068y5UOJuTugsrfTikvhFMf
         2+YYkXaiux+/3Maua5V0NTlPGfFzGkDNEFQNqpmqpsguBZ6Jj1q/Z/bGCHg9imAK81x9
         Nvw8n/E1BhQung+wSH/wu75yu2TfSZofYanDzSsfbTkdHUfGcmDqDAlSgREUIIu0Asv8
         78k6p0Mog5DIQ6hIjq6vGMDcZnysAT1sFkGbc/mALZV0fzqQoaSEfC2cXVFQtkLS+q40
         pQuyRQFKrJyOSnge3WWO8PEp8RirnOsn2ruWGKhzpAprFyq+042DOt3ZWRnupmuGa/WP
         bvyw==
X-Forwarded-Encrypted: i=1; AJvYcCWGdBJrSscwpJU1SyK1XM6EiLLMSiA0NYVRMcCqfJY1cfRKOlSc/Js2WwwfoYCogqspwlI7BH2JSKppVoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RqqGTIjHVbdyxizryEq9yczYxXkItrdfJqRUOezRPF85RBsL
	rZlHsYpejaRORisqFP9SJF383WOEupRV/rJfaJecANYnne2fr7NwvFRAdQN635w=
X-Gm-Gg: ASbGncsamqcsoSO+L9RtBiQWF1jNYjlKb3ocPC4XUskP7Vroh3GY8XBBwpIYdQmaH3U
	O4gYfqZRXJHTl9nJn0LRYC+Y8QD3FdUCT6NotuRkkYAHJRD1Sj/R+pcIMO4UkGE8Otoh7HEneQP
	N56EKSwPPJDSBBTgd78CDv1Yaa2cm+sZnyj3EqiDZl1VOMAKEQJgjAtZgVEObKfKs3sDXB51Qr+
	RTw7di74BuYZWehoYi+D4vOYWeGeS9Aozy2a5H+raEuMGfVOV6JtEfY31l7gjFHNEBrxA1luTy7
	hRHyGbRCZwR1jCCYLj3Z6fcQNte6Zw==
X-Google-Smtp-Source: AGHT+IHFo0u9dZeqasaGK/11AiEVRHpr6/TNKRrMBD8HtygsZB7hj/KBCWrxrNtWfqK7NAgihmRiwA==
X-Received: by 2002:a05:6512:400c:b0:53d:eefc:2b48 with SMTP id 2adb3069b0e04-53deefc2f0amr277753e87.33.1732630117611;
        Tue, 26 Nov 2024 06:08:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ddd09737csm1385252e87.156.2024.11.26.06.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 06:08:36 -0800 (PST)
Date: Tue, 26 Nov 2024 16:08:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Melody Olvera <quic_molvera@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: qdu/qru1000-idp: Fix the voltage
 setting
Message-ID: <makbiq4pby5qoqpraonia3rorytb5uqhiab3tri5bjimdbcoc2@z6jkhg2u3reb>
References: <20241119070812.16079-1-quic_kbajaj@quicinc.com>
 <orvnnjclxlwrab34daxrepn3m3la3heogkxbncl44yjyn3wxkt@vnp4knb5nedo>
 <6ebf5fcc-011c-4984-ac5b-8139d0da8588@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebf5fcc-011c-4984-ac5b-8139d0da8588@quicinc.com>

On Mon, Nov 25, 2024 at 06:02:40PM +0530, Komal Bajaj wrote:
> On 11/20/2024 5:27 PM, Dmitry Baryshkov wrote:
> > On Tue, Nov 19, 2024 at 12:38:11PM +0530, Komal Bajaj wrote:
> > > While adding the USB support, it was found that the configuration
> > > for regulator smps5 was incorrectly set. Upon cross verifying for
> > > all the regulators, found that smps4, smps6 and smps8 are also
> > > incorrectly configured. The patch corrects these configurations.
> > > 
> > > In particular -
> > > - smps4 is 1.574V min and 2.04V max
> > > - smps5 is 1.2V min and 1.4V max
> > > - smps6 is 0.382V min and 1.12V max
> > > - smps8 is fixed at 0.752V
> > Could you please comment whether your values represent the min/max
> > supported by the regulators themselves or the shared min/max by all the
> > devices powered by the corresponding regulator?
> 
> values represent the min/max supported by the regulators themselves

This is incorrect. Please take a look around. The regulators in the
board files specify working ranges, which are suitable for the
particular board, not the ranges that are supported by the regulator
itself.

So, NAK. If working ranges need to be corrected, please send another
patch.

> 
> 
> > > Fixes: d1f2cfe2f669 ("arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs")
> > > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > > ---
> > > Changes in v3 -
> > > * Minor nit pick in commit message
> > > * Link to v2: https://lore.kernel.org/all/20240524082236.24112-1-quic_kbajaj@quicinc.com/
> > > 
> > > Changes in v2-
> > > * Updated the commit message as suggested by Krzysztof
> > > * Link to v1: https://lore.kernel.org/linux-arm-msm/20240514131038.28036-1-quic_kbajaj@quicinc.com/
> > > ---
> > >   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 16 ++++++++--------
> > >   arch/arm64/boot/dts/qcom/qru1000-idp.dts | 16 ++++++++--------
> > >   2 files changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > > index e65305f8136c..6e8f9007068b 100644
> > > --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > > @@ -96,20 +96,20 @@ vreg_s3a_1p05: smps3 {
> > > 
> > >   		vreg_s4a_1p8: smps4 {
> > >   			regulator-name = "vreg_s4a_1p8";
> > > -			regulator-min-microvolt = <1800000>;
> > > -			regulator-max-microvolt = <1800000>;
> > > +			regulator-min-microvolt = <1574000>;
> > > +			regulator-max-microvolt = <2040000>;
> > >   		};
> > > 
> > >   		vreg_s5a_2p0: smps5 {
> > >   			regulator-name = "vreg_s5a_2p0";
> > > -			regulator-min-microvolt = <1904000>;
> > > -			regulator-max-microvolt = <2000000>;
> > > +			regulator-min-microvolt = <1200000>;
> > > +			regulator-max-microvolt = <1400000>;
> > Having 2.0 V regulator with the range of 1.2V - 1.4V is strange.
> 
> The configuration for this regulator was incorrectly set, as its nominal
> range is 1.2 V.
> 
> There was no scenario utilizing this regulator, but we discovered this
> misconfiguration while enabling USB.

Well. Then the name also needs to be corrected. You can not have
1.2-1.4 V regulator having the 2p0 name.

> > >   		};
> > > 
> > >   		vreg_s6a_0p9: smps6 {
> > >   			regulator-name = "vreg_s6a_0p9";
> > > -			regulator-min-microvolt = <920000>;
> > > -			regulator-max-microvolt = <1128000>;
> > > +			regulator-min-microvolt = <382000>;
> > > +			regulator-max-microvolt = <1120000>;
> > The same applies to this regulator, 0.9V usually can not go to 0.382 V
> > and still let the devices to continue working.
> 
> 
> This regulator supports a minimum voltage, but it won't actually drop to
> that level. The previous voltage values did not align with the Power Grid.

What is the actual minimal voltage for the regulator on this board?
Please use it instead.

> 
> 
> > 
> > >   		};
> > > 
> > >   		vreg_s7a_1p2: smps7 {
> > > @@ -120,8 +120,8 @@ vreg_s7a_1p2: smps7 {
> > > 
> > >   		vreg_s8a_1p3: smps8 {
> > >   			regulator-name = "vreg_s8a_1p3";
> > > -			regulator-min-microvolt = <1352000>;
> > > -			regulator-max-microvolt = <1352000>;
> > > +			regulator-min-microvolt = <752000>;
> > > +			regulator-max-microvolt = <752000>;
> > 1.3V at 0.752V?
> 
> 
> same applies here as well.

Same comment. No 0.752V for 1.3V regulator.

> Thanks
> 
> Komal
> 
> 
> > 
> > >   		};
> > > 
> > >   		vreg_l1a_0p91: ldo1 {
> > > diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> > > index 1c781d9e24cf..8b0ddc187ca0 100644
> > > --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> > > @@ -96,20 +96,20 @@ vreg_s3a_1p05: smps3 {
> > > 
> > >   		vreg_s4a_1p8: smps4 {
> > >   			regulator-name = "vreg_s4a_1p8";
> > > -			regulator-min-microvolt = <1800000>;
> > > -			regulator-max-microvolt = <1800000>;
> > > +			regulator-min-microvolt = <1574000>;
> > > +			regulator-max-microvolt = <2040000>;
> > >   		};
> > > 
> > >   		vreg_s5a_2p0: smps5 {
> > >   			regulator-name = "vreg_s5a_2p0";
> > > -			regulator-min-microvolt = <1904000>;
> > > -			regulator-max-microvolt = <2000000>;
> > > +			regulator-min-microvolt = <1200000>;
> > > +			regulator-max-microvolt = <1400000>;
> > >   		};
> > > 
> > >   		vreg_s6a_0p9: smps6 {
> > >   			regulator-name = "vreg_s6a_0p9";
> > > -			regulator-min-microvolt = <920000>;
> > > -			regulator-max-microvolt = <1128000>;
> > > +			regulator-min-microvolt = <382000>;
> > > +			regulator-max-microvolt = <1120000>;
> > >   		};
> > > 
> > >   		vreg_s7a_1p2: smps7 {
> > > @@ -120,8 +120,8 @@ vreg_s7a_1p2: smps7 {
> > > 
> > >   		vreg_s8a_1p3: smps8 {
> > >   			regulator-name = "vreg_s8a_1p3";
> > > -			regulator-min-microvolt = <1352000>;
> > > -			regulator-max-microvolt = <1352000>;
> > > +			regulator-min-microvolt = <752000>;
> > > +			regulator-max-microvolt = <752000>;
> > >   		};
> > > 
> > >   		vreg_l1a_0p91: ldo1 {
> > > --
> > > 2.46.0
> > > 

-- 
With best wishes
Dmitry

