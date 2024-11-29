Return-Path: <linux-kernel+bounces-424684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4C9DB807
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B7CB2090C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6A1A9B25;
	Thu, 28 Nov 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cs/4DFkN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461221A265E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798567; cv=none; b=r3riYmP+Q+wyrjV2yboXYkUqFM0WmDNy5TmTljGykLdJGIPGRbV3uRVQcdo+9oV3PPptua+uPU0Lb4hHVhgwu0UKbFTGkJyXyQEJ1Hzm4CEFGNF/+zld88vBhKfYyuJ+/q6Ux3MdF6VA098q8q2bpL0Bod/fAUTr8jeXalouBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798567; c=relaxed/simple;
	bh=KE33bIQNDDN7hmfh908Em70bRrmlPBc7MOheUcsgmYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNrZ/tpsY5gsCT+su7s42dKtpu17yHdNCkGruyj/fAxXHO6nUK7r+oudxmnRSx2fs/s/WeyUUKcoSuRUel2R9C3pyfFllKCLmoctB3I15oTlirBAgFBrmDrH5wKl0IA7Of8gyhnnNw7VWF6D74C9cty/vbPpCgKQcJMnPY4m/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cs/4DFkN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df1d1b6f8so887731e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732798563; x=1733403363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZFhxM1Wfrl96ajWNDFTXwyeLdFznnvDSZr/eouTC0Y=;
        b=cs/4DFkN1a1r5EZ9qxSh+l7E8mTp7dncamtbhG67qmrXDQBC8/acQ1k9sH/eshpi9s
         s+OFUsYe0aauMYzwE919z81cvpPHFODUjjdC+pWwAX0HJ9VUeT5CWR8LshuHobqoTHZg
         rKpgIo0+9jML0elgyBGk7e7D0AOK9Uhq/cOPDbNQ0CIuMdt/VM9AyHuOz58t9T36i1Um
         Fvi8rPhVQjybLlxvGB4AyvWaMsLJALusj9moyuA/SoQn9XNeD/Qj2D/o+nhkQHkiXAEf
         5dPyDdvBRBDGJZO0buP/F19fV1Ckds+m/h+Om/hf1qjCnt6Z+DTnZozTN+r16KH6UH3x
         q+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798563; x=1733403363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZFhxM1Wfrl96ajWNDFTXwyeLdFznnvDSZr/eouTC0Y=;
        b=bicOlfadDAKZB2U/1FQoK3W0S7E77ZtgdtiiaYr2vTUtcQM4sV6dBKsRoNC8XnhCzL
         drfXIlPeNY8X4H9X46lHN0PBo6OYAG2Ojx1ChA1Th8siwMoBjPDPRjuQAdXmi8n0iH6Z
         VAZb/zKW+9DrPjTcvoHv/FMw3IV/gqMAiGFemiKK7Stxb+cpdSbZsw9waE3xs5llWaTM
         acZSVBju0szOAizXuj9/OTLREI/6W9p1MHIBASAsvrbxJU32r8CXWD+x5Wf0a+ow9sJJ
         XA40TFWLIZy3S7/bfnPUBALUgCBbYBxr+N0lEsjzbe4zHcFzG8hZdM2gEJSpb2OxphA/
         O07w==
X-Forwarded-Encrypted: i=1; AJvYcCW0khG8WgkXMLzXv+bfgQlC0gnvfAzkY+DDN6a/GLWD2JheF3IOZLz79AWAXr11VZk/I9QySGKmyPf0Z5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvrE26KI4/F0Dq/dW2KDTBunqRE0YHCR/tBO0EDIo3/vL/vV/
	KjS/Hkgz1Vxo6QSwXt/2U8Ipu9UHRC7+kcEnuGIg0uZDRiyOKus/zLr/WohneXg=
X-Gm-Gg: ASbGncujCCMXM1N3hAa9qpyZY5Nh7Em1a3EGPlgvsO5kGIaG+lRbsI2G/zohb5S2AuN
	l2NXn7u/Ymj7+jcop8BOhsnWJMTTJxN11cLtr+FEm9gQ46qiokRZ3riBf/r+8QuKRwPzqY8vQXy
	HLQSoLg8iZwXX7/PaqSmkVdw5uKekFWquu68t6PUNyA7d0FcDbMqQ758RuA+2Z9HsXvglDTbAiC
	Tb7ltMZWQpKN8+UbXqfEVBqdL2CnEfkEWvSPOJoftky03e72gqrgUY7jLdHlwXgMqU1/g/j0l93
	pFY/v37WDrenekIWYfNlsqi23NPeVg==
X-Google-Smtp-Source: AGHT+IEjlByPnA0lC/jOh6OlDRwPifRqj1mqE2GEQSjR2tEKRT8HHBqPHe2pVp4y08dMA/E3FKBPeA==
X-Received: by 2002:a05:6512:239f:b0:53d:d3f1:13a9 with SMTP id 2adb3069b0e04-53df00d119amr4169548e87.22.1732798563196;
        Thu, 28 Nov 2024 04:56:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6431213sm171763e87.10.2024.11.28.04.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:56:02 -0800 (PST)
Date: Thu, 28 Nov 2024 14:56:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs8300: Adds SPMI support
Message-ID: <vgv4nucgfnrlov4lj33sprytnkbhoj6yxolwrqddbwwkmrevn3@4sacxzyhciyp>
References: <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-0-28af84cb86f8@quicinc.com>
 <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-1-28af84cb86f8@quicinc.com>
 <wtnsepmoulfhm5ydbu7udtsrexaogaiqjyt737g6a2bhf4drnv@jwmktibj2swd>
 <624393e7-0681-41c3-9008-de50cdf997b5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624393e7-0681-41c3-9008-de50cdf997b5@quicinc.com>

On Thu, Nov 28, 2024 at 03:55:31PM +0800, Tingguo Cheng wrote:
> 
> 
> On 11/26/2024 7:50 PM, Dmitry Baryshkov wrote:
> > On Tue, Nov 26, 2024 at 05:35:05PM +0800, Tingguo Cheng wrote:
> > > Add the SPMI bus arbiter node for QCS8300 SoC which connected
> > > with PMICs on QCS8300 boards.
> > 
> > Could you please comment, what is the version of the SPMI controller /
> > arbiter?
> Sure, let me add the version information in the commit message.

Answering here would have been easier to follow.

> > 
> > > 
> > > Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs8300.dtsi | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> > > index 2c35f96c3f289d5e2e57e0e30ef5e17cd1286188..03bf72d6ec5c9ec92f6f53df9253c8c5953e13c4 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> > > @@ -939,6 +939,28 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
> > >   			#clock-cells = <0>;
> > >   		};
> > > +		spmi_bus: spmi@c440000 {
> > > +			compatible = "qcom,spmi-pmic-arb";
> > > +			reg = <0x0 0x0c440000 0x0 0x1100>,
> > > +			      <0x0 0x0c600000 0x0 0x2000000>,
> > > +			      <0x0 0x0e600000 0x0 0x100000>,
> > > +			      <0x0 0x0e700000 0x0 0xa0000>,
> > > +			      <0x0 0x0c40a000 0x0 0x26000>;
> > > +			reg-names = "core",
> > > +				    "chnls",
> > > +				    "obsrvr",
> > > +				    "intr",
> > > +				    "cnfg";
> > > +			qcom,channel = <0>;
> > > +			qcom,ee = <0>;
> > > +			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "periph_irq";
> > > +			interrupt-controller;
> > > +			#interrupt-cells = <4>;
> > > +			#address-cells = <2>;
> > > +			#size-cells = <0>;
> > > +		};
> > > +
> > >   		tlmm: pinctrl@f100000 {
> > >   			compatible = "qcom,qcs8300-tlmm";
> > >   			reg = <0x0 0x0f100000 0x0 0x300000>;
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Thank you & BRs
> Tingguo
> 

-- 
With best wishes
Dmitry

