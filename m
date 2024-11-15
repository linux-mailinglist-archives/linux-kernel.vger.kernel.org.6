Return-Path: <linux-kernel+bounces-410292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AE9CD8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD487B2417F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FD189BAC;
	Fri, 15 Nov 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cssjMrsB"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D11885AA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653695; cv=none; b=G7HWoqlQX05XWGj2xWU7AiyL5VxWdNTc/44B/RCpXzkVntETBqEEjiFZLiX0XySDtVcVenrHIvsqdp/+87+7aQyLZWtzTd1pOkPDRhDjNjtLbVmRix2vUtvhiwUEmb5H43XkFtXlX21JO44AqIe6beuOEJncY1+vcm5n14JBfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653695; c=relaxed/simple;
	bh=wcimBfT4KdslFpSdb7Mnrzgcs31Xrk5aFoelt2AivPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZvAXyOOMfN8tKaYrvJC71E3Ip0BkfetsK+9g0/FI0G9P5GgYVhmFWTudhMGcS739ZBD90+HYGoo7QwOrnoiOJhg5Ol5Yamztv+s2YIWHh8ClSTwCnSfQJXtPNj6ZFo7/lsH1TMd+ziTv8MuOl5og6sBXSnkc0rbnFA1PcGr1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cssjMrsB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e59dadebso1632998e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653692; x=1732258492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjKLBvWETSBADZGUV6yqhakCmIaLRuQjCHp/Lt9M3AA=;
        b=cssjMrsBLmM4fuB1gxR6lBwHNDLFni1ZVgPu/TbhlRN6Abd45Hqv6os9vWOjpoRyE3
         DI20WIN8WYqYP/mZvCGBCTiX2KCx+ZxEFmXUBlb0Dj0b3ofQRSavHuv4I5n9HcKcbx/u
         UL8+7SWQGcILQsVUf1JPLEqlEoUiZudk+nCFdNOoqRcsoHaV10wtZNuBW0isd7R72Yxf
         tLgRd4eOTroka/AEdQ1oTucahlMvdzIXAmli8lp2qkRYvJNRzvLvOpy+kmiNRJxmlBVw
         KRkqUIKqJZjB85EuTWMsjMNcPXAW871ZGvrdQlVg/cp0RrMGmEdRFB0s1XcfuW+Xs6jq
         218g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653692; x=1732258492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjKLBvWETSBADZGUV6yqhakCmIaLRuQjCHp/Lt9M3AA=;
        b=AojtPt3U3dbQTOQVLiFmgsR/sZW2LKF2LXXImo9FUeUTv+HJ5JTxYUv18EeqgmtrFS
         3N3kDsQRu42ocosYhP8Kt3osfCFPn7UZwDstXeTZHBtL3r2/WOQqaGohN3PYUsJh5mPq
         D6qtKDpeKl8pJF59/QeGq9YB/glG9njIAVeNE6YeqsJW1ta01I1z13GwElWwoR4+CNd4
         j7bRcxBmKvMIdvQXXfxdCohj/97cAtHTBPtk9E06oWvFrs2a2TQq5TXR2bDcHeKbqhbg
         7JQ+rFS7PtNh9HrjGGClNMBxp6W7TINb70zVVT4w2GDw3xxRr5ckSFq9sB86gXcpUOo4
         LodQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi+xr7ZgCHKGPKYxjYuuRxWmeZ+KKoZwdmiu9u4q06sxZTBZeizojBMh21VUBwqeOKAbPdKpVSKa/zySY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtsPbfM9lGREe/05PvozAvVcywnEafWBmg6OdXrLYSnM80d86
	psn3OHEgSqWdST6lUIYngoZH0DEbLPJ96i/0y4YrGp21nJEO+TXhiOOa8Po1Xrw=
X-Google-Smtp-Source: AGHT+IFYT9QcCK1sZ7kStHf5ogo5eN6v02g0qjiZW9C6KciiPEArLV3TRbiCPgAuKP6fFkQC+XS51w==
X-Received: by 2002:a05:6512:3ba1:b0:53b:1f90:576f with SMTP id 2adb3069b0e04-53dab2a6022mr601193e87.22.1731653691696;
        Thu, 14 Nov 2024 22:54:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548eb8sm457776e87.255.2024.11.14.22.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:54:50 -0800 (PST)
Date: Fri, 15 Nov 2024 08:54:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	andersson@kernel.org, konradybcio@kernel.org, mantas@8devices.com, 
	quic_kbajaj@quicinc.com, quic_kriskura@quicinc.com, quic_rohiagar@quicinc.com, 
	abel.vesa@linaro.org, quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: Add USB controller and phy
 nodes for IPQ5424
Message-ID: <qx22rgezkym3guofdxwmvhrjjwjzshngb4cvpdhqahlykeeqhg@wc4zy3gicrsb>
References: <20241114074722.4085319-1-quic_varada@quicinc.com>
 <20241114074722.4085319-7-quic_varada@quicinc.com>
 <CAA8EJpr6xb=TPPgk7ERhKVp7OnYdPGCK6+1_2TBRLBt_eWM43A@mail.gmail.com>
 <ZzbZGnKEovwoDPrP@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzbZGnKEovwoDPrP@hu-varada-blr.qualcomm.com>

On Fri, Nov 15, 2024 at 10:46:10AM +0530, Varadarajan Narayanan wrote:
> On Thu, Nov 14, 2024 at 03:28:36PM +0200, Dmitry Baryshkov wrote:
> > On Thu, 14 Nov 2024 at 09:48, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > The IPQ5424 SoC has both USB2.0 and USB3.0 controllers. The USB3.0
> > > can connect to either of USB2.0 or USB3.0 phy and operate in the
> > > respective mode.
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > > v3: Regulator node names, labels and 'regulator-name' changed per review suggestions
> > >     Stray newline removed
> > >
> > > v2: Add dm/dp_hs_phy_irq to usb3@8a00000 node
> > >     Add u1/u2-entry quirks to usb@8a00000 node
> > > ---
> > >  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts |  66 ++++++++
> > >  arch/arm64/boot/dts/qcom/ipq5424.dtsi       | 159 ++++++++++++++++++++
> > >  2 files changed, 225 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > > index d4d31026a026..859e15befb3f 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > > +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > > @@ -16,12 +16,70 @@ / {
> > >         aliases {
> > >                 serial0 = &uart1;
> > >         };
> > > +
> > > +       vreg_misc_3p3: regulator-3300000 {
> >
> > Technically these names are correct. However they don't match the
> > approach that Qualcomm DT files have been using up to now.
> > You can compare your data with the output of `git grep :.regulator-
> > arch/arm64/boot/dts/qcom/`
> 
> Dmitry,
> 
> This name was suggested by Rob Herring [1]. Shall I rename them as follows
> 
> 	regulator-usb-3p3
> 	regulator-usb-1p8
> 	regulator-usb-0p925

I'd say so. Rob clearly stated that this is not a strict rule. It's
always better to follow the customs of the particular platform, it helps
other developers. Also in _many_ cases just defining the voltage is not
enough, usually there are multiple networks providing 0.925 V or 1.8 V.

> 
> Thanks
> Varada
> 
> 1 - https://lore.kernel.org/linux-arm-msm/20241113181138.GA1011553-robh@kernel.org/
> 
> > > +               compatible = "regulator-fixed";
> > > +               regulator-min-microvolt = <3300000>;
> > > +               regulator-max-microvolt = <3300000>;
> > > +               regulator-boot-on;
> > > +               regulator-always-on;
> > > +               regulator-name = "usb_hs_vdda_3p3";
> > > +       };
> > > +
> > > +       vreg_misc_1p8: regulator-1800000 {
> > > +               compatible = "regulator-fixed";
> > > +               regulator-min-microvolt = <1800000>;
> > > +               regulator-max-microvolt = <1800000>;
> > > +               regulator-boot-on;
> > > +               regulator-always-on;
> > > +               regulator-name = "vdda_1p8_usb";
> > > +       };
> > > +
> > > +       vreg_misc_0p925: regulator-0925000 {
> > > +               compatible = "regulator-fixed";
> > > +               regulator-min-microvolt = <925000>;
> > > +               regulator-max-microvolt = <925000>;
> > > +               regulator-boot-on;
> > > +               regulator-always-on;
> > > +               regulator-name = "vdd_core_usb";
> > > +       };
> > > +};
> 
> [. . .]

-- 
With best wishes
Dmitry

