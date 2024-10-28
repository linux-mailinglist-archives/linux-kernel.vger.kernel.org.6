Return-Path: <linux-kernel+bounces-384425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB299B29F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2502877ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E418FDBC;
	Mon, 28 Oct 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGGn/8DL"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED018A6BC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102950; cv=none; b=mqyGMjt6mEhN+ge628B6Ij1ct8CWd4XF4zO8F0d0CktOC3SwJ9O/aJ5vUixURTdYtXb/2s+h4M+iOgxxgXyCg/LW75FyovSH/fxeAarjzPIgYWztj599k32V30E6BxKtU8KUJ8FGt00VqQRaalGVZKEaLg01I6bHM5pCLy64zLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102950; c=relaxed/simple;
	bh=xEdRK0X0E9YhwoSe/GbMgkWa18PbkIUtqM2+5lUXVQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYIb9AeqYcJND8hd/6/DYaLZRMbxneFJamYZbGNdB+278Ze4ZgrSEzQ3DBArRtKmQRBrvhM4w7rsYc/OVLUtqcNR5SheOT5aBn36PwFA8A9FfmX8gzrGx6xyOLMy6T0Mv6d8XraUpNXHhSggDMnDEaNtQOAD8cvcqwyG/pqs96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGGn/8DL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53b34ed38easo1296168e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730102946; x=1730707746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XOl5JaLDEpKRUaM7KP5DrWdcgyDuDxiqmeU6xCx0h0=;
        b=TGGn/8DLL1OXqbnVv3VUcKlpe3uArXh8aogq5sC4zPEfaDU93gCsESps6jV/j1tt1+
         WwqDdXICFYhSkQHBYwJ3J8FhU6GvD+gGQVFoGjJjQXmosWU8YoUKrYmTav9tzHTJwPfa
         iHQzsgij/HB43FnmpzV+9HU6H0/B1tnoIzrXuO/A9yvgC0uv61G8tHHif4/hQTXBq6Ts
         yplQpv2RbOE9f/Vb+n4Vb0CbQCXWxsgRWbCKU7UxjFG0Qupob6NOHnboBjCt0kL9k1YV
         iWB9qHMY+jmyoOc1Wf+eAVm06glMR7OO3AvmBTBcycaghCpIhcspedxwlm+tUvp0hfLv
         OHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730102946; x=1730707746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XOl5JaLDEpKRUaM7KP5DrWdcgyDuDxiqmeU6xCx0h0=;
        b=U2pzxb37V3UhDnCyLsCuXTQ0PJQRxlX4I9L7tV14lsvIn5V+MrmuMhffkh27ycvFQC
         6UuIEcbY5IvlCBijFtdjTpZDv5d9cyj8d5IrmDlgWBUI/B0rbtpnaCyTGEqfUAB8zCh9
         zfvzhMF+1tqivosgBRYL7HpBr/31I2eF97AZNHYi2AV9+X2wR3H8C8UyCE/VUhL4R/ZL
         pHvyKZ0kQgLvFBBjhiUL88ST83A1gnqgBhl4DadXJK2qlfLdrejy5Caq2ow/1EUmPtLS
         EROaet/73/3SAddFA9RmO5E43XR7/T2YkciF/lTutff2gn97M7gKKlDk5vlj/LdLle3A
         Y72Q==
X-Forwarded-Encrypted: i=1; AJvYcCV10MH5EjxCGiQf/dCTBYQt20lNDnsU2TYM7VFV6Ajuu5HkVgUJqvbnuWOCc9hTIgNPdVN5a1bbMJ76nJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykpNLGnVnTLGdW9DCirkrdg+W+XtLlrxOYGzPtTmhtbTR1Y56h
	xpGcjoxK8DthXxeS5zFJiuijyi5rP6XZWJnCnvxtS5ZDrrLVl50eB7RAXEtNvog=
X-Google-Smtp-Source: AGHT+IE8CXRzYs3i3lRForAL+30n5gewApLz4e5WRTKig3Hr7I3Rs1VoWgkaR5EenOLaanClnuJp3Q==
X-Received: by 2002:a05:6512:15a9:b0:539:ecef:376d with SMTP id 2adb3069b0e04-53b34a33d05mr2826898e87.54.1730102946365;
        Mon, 28 Oct 2024 01:09:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a915sm987402e87.12.2024.10.28.01.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:09:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:09:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable USB controllers for
 QCS8300
Message-ID: <byzzazzbepnnijxm6j4acnpe4noje4vccfqlbse3gtoeaqj3es@lv2odr6vpztt>
References: <20241011074619.796580-1-quic_kriskura@quicinc.com>
 <20241011074619.796580-3-quic_kriskura@quicinc.com>
 <xijjs445fzeuzbj2bg3ziwlzenrk4wo5zlyze4j5mldb444oj7@73ynic4xqfdj>
 <720aa372-a04b-4b0f-b2da-3be37a319ec9@quicinc.com>
 <fhgw2re45vn63lqox7vikg3hcak3wjf4wududebw7ow2enrqiq@inajq4l5qqir>
 <c87f96a7-f391-41d0-821b-cbd4e25b5831@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87f96a7-f391-41d0-821b-cbd4e25b5831@quicinc.com>

On Mon, Oct 28, 2024 at 12:32:02AM +0530, Krishna Kurapati wrote:
> 
> 
> On 10/27/2024 11:14 PM, Dmitry Baryshkov wrote:
> > On Sun, Oct 27, 2024 at 11:59:44AM +0530, Krishna Kurapati wrote:
> > > 
> > > 
> > > On 10/26/2024 11:06 PM, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 11, 2024 at 01:16:19PM +0530, Krishna Kurapati wrote:
> > > > > Enable primary USB controller on QCS8300 Ride platform. The primary USB
> > > > > controller is made "peripheral", as this is intended to be connected to
> > > > > a host for debugging use cases.
> > > > > 
> > > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
> > > > >    1 file changed, 23 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > > index 7eed19a694c3..3e925228379c 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > > @@ -265,3 +265,26 @@ &ufs_mem_phy {
> > > > >    	vdda-pll-supply = <&vreg_l5a>;
> > > > >    	status = "okay";
> > > > >    };
> > > > > +
> > > > > +&usb_1_hsphy {
> > > > > +	vdda-pll-supply = <&vreg_l7a>;
> > > > > +	vdda18-supply = <&vreg_l7c>;
> > > > > +	vdda33-supply = <&vreg_l9a>;
> > > > > +
> > > > > +	status = "okay";
> > > > > +};
> > > > > +
> > > > > +&usb_qmpphy {
> > > > > +	vdda-phy-supply = <&vreg_l7a>;
> > > > > +	vdda-pll-supply = <&vreg_l5a>;
> > > > > +
> > > > > +	status = "okay";
> > > > > +};
> > > > > +
> > > > > +&usb_1 {
> > > > > +	status = "okay";
> > > > > +};
> > > > > +
> > > > > +&usb_1_dwc3 {
> > > > > +	dr_mode = "peripheral";
> > > > > +};
> > > > 
> > > > So, can it be used as a USB host controller / connector? What needs to
> > > > be done in such a case?
> > > > 
> > > Adding vbus boost pinctrl and changing dr_mode to host must be enough for
> > > this case.
> > 
> > Could you please mention those either in the commie message or in the
> > comment before the board DT file?
> > 
> 
> Sure, I can update commit text to add something like the following:
> 
> "In case first controller needs to be configured in host mode, X-GPIO to be
> enabled and dr_mode to be changed accordingly."
> 
> But when we add second controller (which I will after SPMI node is done),
> this commit text would be redundant as the same file would show example for
> host mode as well.

My point was that it might be not obvious that the controller isn't
designated to be peripheral on a board level and can be easily switched
to work as a USB host.

-- 
With best wishes
Dmitry

