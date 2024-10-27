Return-Path: <linux-kernel+bounces-383715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDD9B1F72
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E068C28140D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3B1E517;
	Sun, 27 Oct 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ru1BjncU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DF152E1C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730051058; cv=none; b=fytdH6hSzjzfXTUNEPwI1MTZ5U2Xiff+6TA9HozUqAPktTSMiflkTEz3LDNyjZoK7vsNI66f1ltwIzmrRSXCf4LFsn/0UsEdoH/WqIlmec1duxe4rP/BIYnlw557wI8zLg9UQAAK9FTegAtNrqvMgFHh3Luyc/BI083Gs3WB5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730051058; c=relaxed/simple;
	bh=MdunEshAHQ53TVlHzQQbbg3QFVE1V08Xf4kR7qvr/rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHPy9stVKHqJIGuXH6c0/ke5mwCiFE632atjzbYlULknQxVLlfVGxuPCA3vtZUkjAcSglEPcKwtn0Zd8rPxcN6B7DTR4RJGDrhYAbdjF4anS3ifDtMt5PVIhwPc8J7rm5iwbAUAx8hBgnd0u+7lm71osFtt+i9Hr2n1m6XhhRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ru1BjncU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so4236086e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730051055; x=1730655855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N63/GxDEd0wfP94caNCMDYpxPCrMq7BQqlGivmRDQpI=;
        b=ru1BjncU7A48bGD0XCZS05ySvFPHgowOYhwlbBI4LKwI+jOLvfD8RuknPyxzsxFl38
         xP1VQD+JxI+vRj5/pk4Lr6PCj3j7ISNWtcMLFnHO3DcNRm7zZknKLi9OcZOaneRVPiDQ
         iLRbAIf3CmV4T5RJxP71NKMiO6cVhZmiuy8wz5IiflfmfoTQvn8mj6ohGzkO1IsGGFJX
         Td2CEWmYKJpMKfKEx+Ri1OEuJdgWhgtCbHdhZsHW6s4tlnQczLZv9Qgv+W+wY+QcV3EC
         05zLCpVGeUOfjRznntef7e+27z/yf6kV0dYrV2dn85R9lZmDaaGUDZqlaDhmVzvSxcHY
         QG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730051055; x=1730655855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N63/GxDEd0wfP94caNCMDYpxPCrMq7BQqlGivmRDQpI=;
        b=oxFDpGmkE8UTHqwSR4ntr0hPME9EBBl7pQujPiI2SRMkHDist1g5VldqXUD59HydEz
         GaaU6AqlYaWxJG+Wp5JXgDz7dLSNqOPD2OngW8VkBNGxX6ZtgRE751pr1T5EVDTbJ5Ve
         46L31RzBuAAZ+l/gGch6DHv3y3ATlYArqJbHmM3578CmYqNGEeHNYOPXXv+fNYJiSLH0
         U3yLQw+h7qZBZjorhYLWjMTakS/IeszeQAyLAbvN3AJW68UIKEoLrLzIQ+kmXtbjoXc3
         DIoUobtzOReZlBogNdH490OELoxEIyHVj51wM+STHBnY21bRdXC8S8/RHhdpMTHvq2TP
         m4yg==
X-Forwarded-Encrypted: i=1; AJvYcCXtwYkm76bxjqxyE8zwjOh9QhrGe20/0rLjPPKR6edAIFqesiSL9nAhPrDVjKVXFPYFBd1gOOFbB0mOo+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFNlLA6iVGPJqlMs+wF9kpfTONDNX0NNNx/MeTVilbO0AMBBwO
	wFT1uiL+IXAGUOxn1FBL3kUBzzCEHCNBcATRz+0CM1KQ1Meze/eyTQBOPis0/dM=
X-Google-Smtp-Source: AGHT+IEi/BxS5gMf/iVtcnfxqJkFsy//exVzbziM/ENyiYlUaB6IIu+67ZYUw4eK0ffqLydC7BaiXQ==
X-Received: by 2002:a05:6512:3404:b0:53b:27ba:2d11 with SMTP id 2adb3069b0e04-53b348cb2cbmr2582585e87.16.1730051054730;
        Sun, 27 Oct 2024 10:44:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1f4322sm825710e87.297.2024.10.27.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 10:44:13 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:44:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable USB controllers for
 QCS8300
Message-ID: <fhgw2re45vn63lqox7vikg3hcak3wjf4wududebw7ow2enrqiq@inajq4l5qqir>
References: <20241011074619.796580-1-quic_kriskura@quicinc.com>
 <20241011074619.796580-3-quic_kriskura@quicinc.com>
 <xijjs445fzeuzbj2bg3ziwlzenrk4wo5zlyze4j5mldb444oj7@73ynic4xqfdj>
 <720aa372-a04b-4b0f-b2da-3be37a319ec9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720aa372-a04b-4b0f-b2da-3be37a319ec9@quicinc.com>

On Sun, Oct 27, 2024 at 11:59:44AM +0530, Krishna Kurapati wrote:
> 
> 
> On 10/26/2024 11:06 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 11, 2024 at 01:16:19PM +0530, Krishna Kurapati wrote:
> > > Enable primary USB controller on QCS8300 Ride platform. The primary USB
> > > controller is made "peripheral", as this is intended to be connected to
> > > a host for debugging use cases.
> > > 
> > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
> > >   1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > index 7eed19a694c3..3e925228379c 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > @@ -265,3 +265,26 @@ &ufs_mem_phy {
> > >   	vdda-pll-supply = <&vreg_l5a>;
> > >   	status = "okay";
> > >   };
> > > +
> > > +&usb_1_hsphy {
> > > +	vdda-pll-supply = <&vreg_l7a>;
> > > +	vdda18-supply = <&vreg_l7c>;
> > > +	vdda33-supply = <&vreg_l9a>;
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_qmpphy {
> > > +	vdda-phy-supply = <&vreg_l7a>;
> > > +	vdda-pll-supply = <&vreg_l5a>;
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_1 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_1_dwc3 {
> > > +	dr_mode = "peripheral";
> > > +};
> > 
> > So, can it be used as a USB host controller / connector? What needs to
> > be done in such a case?
> > 
> Adding vbus boost pinctrl and changing dr_mode to host must be enough for
> this case.

Could you please mention those either in the commie message or in the
comment before the board DT file?

-- 
With best wishes
Dmitry

