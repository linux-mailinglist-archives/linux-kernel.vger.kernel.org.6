Return-Path: <linux-kernel+bounces-510234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D27A31A17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BB4164F93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E31FF7B4;
	Wed, 12 Feb 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vx9igdcK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8112641DA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318415; cv=none; b=DPCfauDKW6jqu6C+h3gvECGYFI8bOpJogsdOhwgMHL/jvTo/1xro/K802RCNplpijWwAA3eRNBswczWyMFHoIWPZqY1naCnFE7MCy74XCMlthd1gGv3IANLCT6Q0vF/7E7FZYBvFs5AoX2SFkynB7wqvD7igTIb0GdckiO0v8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318415; c=relaxed/simple;
	bh=sMG/IApRfPR8ZSL4CUKV7cJ8QKGC6AJC501nGxT0gJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr1zPeolqyPNbVasbC8J5ARC3StJvfbSPJKxLsI2k/Wqbfz6/Jv0Pil8FXXfCV1lw9M41zs9HV8+fgLtGIccS9uF/5oZkDVyF7YoLLXW8vpNqCD1Ne8CtTtvLOeesOHiP5y0SyQaP3gxjW957+0TkGVQ2RKsueovenBqrJblWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vx9igdcK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3076262bfc6so66553331fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739318412; x=1739923212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXlqploCpAbDafi9IQYW0m2Rs5Rua9IHjaJCRpBcJDI=;
        b=vx9igdcKGgE+gtqKHhX8BvqI0xPLKF6SMj3I4piamZrqduTKwdLLvZVKQDDOFCdMbl
         /qQv55Ke3JyfJ0+tm+KWXnJQBugdTouyBv+04zp7Ap7XfZlI3FEbV1nII/GQV6SirRHn
         jFV+TD3Y48/tyPM47NLT0qNV4lGf7o8ZT3fbwU6AccCCcrtR5s3p28NxzQkqwajT3p1x
         zLSoMHs8Mwg+ajI4/gpfgFhBmemFLQJ5k2zW07948ik0DSB01dKbgtf0WoRivw7jyWHX
         V+bCT1HvBVsUWr6UUENbk8sbaXYT5Uxl/fH/sRsSUNLAW0FYU5zoaACKcjhxQ64uMn3H
         KGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318412; x=1739923212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXlqploCpAbDafi9IQYW0m2Rs5Rua9IHjaJCRpBcJDI=;
        b=FeZiBavg3td++3LjONXjreBxJVG5T68Wyt60Y5AsZxwr+ipRsNqJPCzZzByYx1+Kls
         AapokjvpxP5Vz/6FCmVGKfdlvsoPLIr/51F3EgsxFHuliy5sLy8PlyOM9L1no15FJ5B8
         xMSpdria16zT/wKiJFobOb7mYp7cG5RNHHiUfeK59hoEKDVOAtnWOD36+UUEzOZ1otdk
         vd8+HknQFVg5LgVXl4K2YIrEe/b4zpbKbZb0JAQGYe31d3J/ELfCEBSehxydRizDM5pj
         m3XsdFzp9EThcFP99MCB9j28YO5K4lZReZ4qfvyqowStDHBHyZAYhx8ZnKURQBNJaSXV
         7Fvg==
X-Forwarded-Encrypted: i=1; AJvYcCV1U02OxfmV40/J9LKLSSFIT5WL5VajUuyolrR28TS9KmQ28qJJ3BzGM99VuJHoQ29mB4cCy71gz7s/p2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vX4x8kfzRB50gElmHf0romeisMe7O7wDHq9aSV0alazb0I/a
	ZZBeYSqaL7mKPBP1gJhBOGJIn3is+5OO7H23Iqp252lh0u4Q+DnlAFhGCUS4UWo=
X-Gm-Gg: ASbGncsIotUjdAgwhxzVGAb+VniO/UFShkIxoyLY3/kwmpA1va7C4bLO2KEKKHK07rR
	hym7ZkneEHS5JFG3Day46+OO8Ydo8UmfTQ9rrg2ad4nc2JAIh7CXUhrYIF6tgzlbbNVoxonulII
	7ujwm8QCwXuSVFVsl4vuvaGlaFRxZeBB9/ThCeks2hcQB9BZzpYdDlWpNSdq5cpwjA8e9tAt68R
	E6TjOk1vv03XYssWFvxNvAED96w4UQqMKaLOazj2RUc8AV3dZH5cQXR9Cv+8xFP8wfnLjHC5G0U
	rkwWM8IEvqxuPMw6WPx/SxgMf8t9Hxw3/NzMOsaBswcZ7r5OsPYxPjGKIKBwCDS9uSw1i+0=
X-Google-Smtp-Source: AGHT+IEtKS1j1XfkAmAx1DUeN3l7Ubdcq3ACfdQx+1tcVmJ21pVK1Fh04wiPd89wQLtVZljJuTb9ew==
X-Received: by 2002:a05:651c:19a3:b0:308:fac7:9cc3 with SMTP id 38308e7fff4ca-30903651950mr6337401fa.14.1739318412131;
        Tue, 11 Feb 2025 16:00:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308e2748fcdsm11095061fa.15.2025.02.11.16.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:00:10 -0800 (PST)
Date: Wed, 12 Feb 2025 02:00:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sa8775p-ride: Enable Adreno 663
 GPU
Message-ID: <iymxe2hmjobctdimupp656xeyhctwd4yswbp2wobaneuzgxedu@cyhjb5ibkqmj>
References: <20241030-a663-gpu-support-v3-0-bdf1d9ce6021@quicinc.com>
 <20241030-a663-gpu-support-v3-2-bdf1d9ce6021@quicinc.com>
 <4cfd1ebc-1a95-43d4-b36a-8b183c6dfd16@quicinc.com>
 <ah6nusoouth7ziu3iscxmafm6cxuwwebxt44ixsjmesp5adwc4@e5lnbztds2xd>
 <271e7b4f-454c-426e-a3f6-dcb55389374e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271e7b4f-454c-426e-a3f6-dcb55389374e@quicinc.com>

On Tue, Feb 11, 2025 at 06:41:39PM +0530, Akhil P Oommen wrote:
> On 2/9/2025 9:59 PM, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 02:18:43AM +0530, Akhil P Oommen wrote:
> >> On 10/30/2024 12:32 PM, Akhil P Oommen wrote:
> >>> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> >>>
> >>> Enable GPU for sa8775p-ride platform and provide path for zap
> >>> shader.
> >>>
> >>> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> >>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >>> index 0c1b21def4b6..4901163df8f3 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >>> @@ -407,6 +407,14 @@ queue3 {
> >>>  	};
> >>>  };
> >>>  
> >>> +&gpu {
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>> +&gpu_zap_shader {
> >>> +	firmware-name = "qcom/sa8775p/a663_zap.mbn";
> >>> +};
> >>> +
> >>>  &i2c11 {
> >>>  	clock-frequency = <400000>;
> >>>  	pinctrl-0 = <&qup_i2c11_default>;
> >>>
> >>
> >> Bjorn,
> >>
> >> Please ignore this patch for now. This is probably not the right
> >> platform dtsi file where gpu should be enabled. I am discussing about
> >> this internally. Will send a revision or a new patch based on the
> >> conclusion.
> > 
> > Akhil, any updates on this?
> > 
> 
> I am still waiting for the discussion about QCS9075 board dts files [1]
> to conclude.
> 
> [1]
> https://lore.kernel.org/lkml/Z3eMxl1Af8TOAQW%2F@hu-wasimn-hyd.qualcomm.com/T/

Why? We currently have several boards supported. We can enable GPU on
those as your patches are pretty fine. Then we can land Wasim's patches.
Not to mention that the discussion seems to be dead, last message was
sent almost a month ago.

-- 
With best wishes
Dmitry

