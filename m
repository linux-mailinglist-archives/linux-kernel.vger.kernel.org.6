Return-Path: <linux-kernel+bounces-421744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AABD9D8F76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2ED4B27198
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40D653;
	Tue, 26 Nov 2024 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORbQMwZE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8708F54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579678; cv=none; b=lNTRn43woy8ctLMQhx1hXjbp8HCn2IqqWCnVUningIaBLpd04+86z+vXKCfDGWCBQmlucSWbdCY5AdeZCwB5L98h/kIP2GHaKQBsOrfsr0qn+Lh/vu24cfrN1xk8HMF1bLfkSz3Vm9ypeIJ/0wsB0iGRaIvT8XH+HqdfX/6elMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579678; c=relaxed/simple;
	bh=X6mpm+0aSH+yONFTblg/2zcjomYbcE73fIlBfI5RHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugcujsLKapmbnrMeCu1xQR/qKM8OPYEEze5Nec2d3J8IabmWmvDjQra7+jvS82UF4OlTF5gXrSnWEHGEhnNhxjdbVxoQsgHiqSUgJemLUKKh3HbZzM6X0DBBdBz2DrZ15LkTNVJJuJ/VwH/0kt36SIfxhwRukpo4Wgetl4i8Na0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORbQMwZE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de50a3885so1643305e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732579675; x=1733184475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0h1yJRyvRJoHgt/KNNsfZgVIwPLNDSnb2kihwUErsQ=;
        b=ORbQMwZEVk0ABiGLa8623WNatb027pWFXlY4SxlKYjZ7H6G48PI8e+vuX7z1lFFXnt
         +4e65DMtXe98gkorqTPk2CxKj4HwnSIJjZxkv92okceEmwZ46K9fjGl0Gf379ZWEyUq1
         9ueVSJKq9QrAkimIZNdXTsoua3dTFiCWbhBD0VrhrEgG4xazcme8RiEneHzQlJ733zWc
         b3+7oRqHaM30Z6A3l42U4lS58K17slfycpArKk4AF95MNw+qKGJwJOhkCCwpp0hPJq34
         NI7dZVzkLQYzoKsCM4El/VLhlp7hdirxc/rCPNYMruALCbIZd/0Cbx5Cblf0Q27OYHuT
         U84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579675; x=1733184475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0h1yJRyvRJoHgt/KNNsfZgVIwPLNDSnb2kihwUErsQ=;
        b=xGnREug+U/mqr/eGRRlZOnif31rj4fdAF0gNNVYMf1/Uvl5MG8mJ4mTXp9st6Hktr5
         iT3rfQIdaslP4yONilUSzCvjEh6misdHwVUEaLkV/D9xYQeZhiFhYmI8rviJr5jZ5x3d
         nb+74Tvxh+fYZBX6ig+2JANMgFp7Zi1q1FoqU/qGhiX5Sb3O7ewXRurro33vYDbgVBQE
         aPlvioBQcwqpA9oiqYZl5F0UxyrSoijKgUIgm/LJtFIEJRbItKS9MPd1fyEpBPom9eeO
         vQEKel0GaIO524tlt9jkgkNCyI2XMqvZZZbm7auEikHRZiQhqS10WO3HbONsTFKLhIOq
         0zxg==
X-Forwarded-Encrypted: i=1; AJvYcCUp+QZ0dCF7o1Keg0R4aaFtdU/4cyke3Yub8fJD5rM1fRwsvyoJ4RYjScYDXVOrutx9/mqfT2oc4att46c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mICGYeSoMDAEdmCtbz7Cud0Flc2APyaG/bGnkcCgGgcrzJtr
	BcH4w/ybDZLpkZSuVpT7u4f69zHmfS8JmqPWrravWriTaR3xsnPzlcsvHmPaL2A=
X-Gm-Gg: ASbGncvsxt/FuRkX7qmSZyExue3UMejIjAwXlZ3GeHrbgSHtaykroLe8c1ees4tOyDX
	jUQ8JcFpox4U/sWxt0cduI0kylWaCQe4Up1lTa1njStqidLh5mUXynwuY4fCu4t4fuJiHyJYAkQ
	xWff0UnCrDy4Q8GzQzd8C0+7pxeNL851AdETrOrNMw20OQiaWMBcdPQ78KNFIeOpvs/TX9Go3Cu
	m4bhV1SHzgK3c+/2mki3og2Q4aYYHrBxNKSU7PJNkoWGrdm3/hIXTgYjm7z05iPSvDZJIZnqEsX
	e8IZuMizBOKfvJ57aHbPfZE5xZKIxg==
X-Google-Smtp-Source: AGHT+IHNAOdFRvV/LBBc9GEXqWd+CaGlgu2KPTG20eKSwEZ7/zIcGDm+IM+4HhB+6bbrWpaYrRfyCw==
X-Received: by 2002:a05:6512:118d:b0:53d:dc12:7cb4 with SMTP id 2adb3069b0e04-53ddc127db7mr3683910e87.29.1732579674934;
        Mon, 25 Nov 2024 16:07:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451f8csm1824556e87.79.2024.11.25.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 16:07:53 -0800 (PST)
Date: Tue, 26 Nov 2024 02:07:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Yuanjie Yang <quic_yuanjiey@quicinc.com>, ulf.hansson@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhupesh.sharma@linaro.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
Message-ID: <frjnnd7bvrdn5frfo4xnz35rb5zxa33eayu3oc5wux7casay64@t2tfbsf5jrva>
References: <20241122065101.1918470-1-quic_yuanjiey@quicinc.com>
 <20241122065101.1918470-2-quic_yuanjiey@quicinc.com>
 <7c0c1120-c2b2-40dd-8032-339cc4d4cda4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c0c1120-c2b2-40dd-8032-339cc4d4cda4@oss.qualcomm.com>

On Mon, Nov 25, 2024 at 02:13:22PM +0100, Konrad Dybcio wrote:
> On 22.11.2024 7:51 AM, Yuanjie Yang wrote:
> > Add SDHC1 and SDHC2 support to the QCS615 Ride platform.
> > 
> > Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs615.dtsi | 198 +++++++++++++++++++++++++++
> >  1 file changed, 198 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > index 590beb37f441..37c6ab217c96 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > @@ -399,6 +399,65 @@ qfprom: efuse@780000 {
> >  			#size-cells = <1>;
> >  		};
> >  
> > +		sdhc_1: mmc@7c4000 {
> > +			compatible = "qcom,qcs615-sdhci", "qcom,sdhci-msm-v5";
> > +			reg = <0x0 0x007c4000 0x0 0x1000>,
> > +			      <0x0 0x007c5000 0x0 0x1000>;
> > +			reg-names = "hc",
> > +				    "cqhci";
> 
> There's an "ice" region at 0x007c8000

Shouldn't ice now be handled by a separate device?


-- 
With best wishes
Dmitry

