Return-Path: <linux-kernel+bounces-550556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13656A56114
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28DE3B0A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727DB19E97B;
	Fri,  7 Mar 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPdKXMHl"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0F19DFA7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329940; cv=none; b=J0QEMf8enopYoCvyD6EZEZSc54qY9nbEzDEm5YaUt5YbwGLu3WN8SUzBhQW/FIPc5IBPaGAEkLE5xkbTFmdw/7OTzR5nzS4xV7ysAf1ddqLzGKQe/0bDy3zjYchegleyUpc/tFJ/pMjr6wLx5lDlqk52LAKlReC7ZYWHLCS+Y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329940; c=relaxed/simple;
	bh=2IbWjjX0WxGiZ8sC4vYfyq7mDesPs3GJVhh1I5IA2tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC3yiYRR7QV1atEskCTsXQOs7/L8+YBD+XrnQSQPJQRhfHH5VXTY/0K0uSJypvMo6khecVu/ksoPwzqFQd6k7l5YJt2L+ke2rcmT1L1si/IKPLvg/DIgDMgY89c3BaImVueW6JHsFblvfkOka3DxmhdGHeB1wiBHai5MH+KEMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPdKXMHl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so15517901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741329937; x=1741934737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DkifpUNIVfalfehyoZ5anyUq+7xOJAxWFQWwUGknXdA=;
        b=pPdKXMHlySjylHroamrtvXuQwvwY9J+lAvfKDC3EFIKu3h8unGh1552CwiLMhlqAdB
         KeB6WUq89tjsQThjl98nyH0OlYX26qrnKIW6xA7Zm0o6zw8VlnRGAA8dY16WjFVq/zw2
         SqCZKTx80MbWDJdKYP8v5HlsXVlg7D/EwrTBngBAjlMB1O+SFz+j0FaHVE/oX9+pkKP0
         htcEgdU8W2poWkMqBVJxOtkQZdjSIzrcJLkEtSHTMfYfAfFyZuArUmRhUac2DeDGlZd8
         zYfPMn3nKlDVTx8Fm4gx0nP1/aS6cyUT5ap3QGA3ph37H+FRAR4iEzZuKFLiR1pJ56bJ
         sW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741329937; x=1741934737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkifpUNIVfalfehyoZ5anyUq+7xOJAxWFQWwUGknXdA=;
        b=b2gdsqqdubFNZjonAgoqkGg02zDYDydO9uZ2n3qdQuLKrE43MXTtYglHLtJ0KHtN3F
         KAKUeBx2Ac2L7nabVyI4MQAfYLfaswKs9eqktlEY9E1Vcmw8wjrKCm8zXO1hzJoPTxHI
         Q+F1oWUury9dho/k1sPs08yiV3o/qRdHPydqcweKRHJQOzk5LpEy92QG+I0BgyiCzpIe
         ABBa68BCdhQ/6V3WcF0EJMQf0B7myymyzJP7UDCr60T8jA7j6XBoNT2eXbq/rIipT4Hu
         JQJ4+G5iS8/sT+RluVI2diKRDAQ0quFj7mumdkyx3P6/WEVko9Hovahtt9sEvguG1ZxA
         ZdkA==
X-Forwarded-Encrypted: i=1; AJvYcCWYAMTlMp31nZLV4HGInzUJX3vQPXU5Xb06GRbia1WP6Jlc/23ubdd/HU0nKhGPHyt6h+OCUaguLJW2GT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTIXMB5LPrn62DLGURARavht1fCLu6tU0GAdoDkKbOGk1vvqp
	e8NBoL0R/JrdeHCCRv6cHf0BV7Vzn/JvutaovuAmgcGJQ3mSO6zx82UgWeQ9YCc=
X-Gm-Gg: ASbGncvlthG0/uuyelAjQ+tSfMXJMKbleGPv6FzY0XtKVpg15cwzYLCt9NmOgXpO4gk
	+K5cpvjKEu85IA+0N5XQtigolqBrqa5Wb6sYJ2tB9nI81xJ/Am6xAouXqXFI3Yc/ydJNrfSXBt5
	sLGCTbZ5t3K+9EmYV/ED/nl8HGRzJhw91iFz1WrzCrkWWYMCytSLUlvxVkdR4WQZIUr7gG2WMGK
	0LXpPV9oejn78m+F/dh5mYNgUQE/h/pkajO+so/BgCVDAyu7+Jd9yIY57CBpSffi7TPHoYoXAo1
	XZ3LDJiUDPBfVIpAuwD5wD3ZdAMXMS1nbmR4Rw7EMuThxZ3Nx2INhDcxIJzfgzKd5uBsPCv9H5A
	fROiQZCkl4lIVXBUsa9INhdqJ
X-Google-Smtp-Source: AGHT+IEVwXNQL271t+0M8gZNNjaFYj/wP3rsGJm5Z+AyP5M40rV9YMISVPS8byjNiGXn0/FUIobKLQ==
X-Received: by 2002:a05:6512:3b9b:b0:549:38eb:d690 with SMTP id 2adb3069b0e04-549910b5e9fmr731477e87.36.1741329936903;
        Thu, 06 Mar 2025 22:45:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bcd96sm394407e87.207.2025.03.06.22.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:45:35 -0800 (PST)
Date: Fri, 7 Mar 2025 08:45:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wse@tuxedocomputers.com, cs@tuxedocomputers.com
Subject: Re: [PATCH] arm64: dts: qcom: Add device tree for TUXEDO Elite 14
 Gen1
Message-ID: <5hvghahezqms6x4pi3acgaujyhiql6mzl2xhzph5phhki2yiyq@oi3xjatj7r64>
References: <57589859-fec1-4875-9127-d1f99e40a827@tuxedocomputers.com>
 <5e72992c-170c-48b9-8df4-2caf31c4ae44@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e72992c-170c-48b9-8df4-2caf31c4ae44@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 01:50:56PM +0100, Konrad Dybcio wrote:
> On 6.03.2025 1:25 PM, Georg Gottleuber wrote:
> > Initial support for TUXEDO Elite 14 Gen1 based on Qualcomm Snapdragon X
> > Elite SoC (X1E78100).
> > 
> > Working:
> > * Touchpad
> > * Keyboard
> > * eDP (no brightness control yet)
> 
> in case your panel as a PWM backlight, you will need to set the PWM
> output pin function explicitly, see x1e80100-microsoft-romulus.dtsi
> 
> > * NVMe
> > * USB Type-C port
> > * WiFi (WiFi 7 untested)
> > * GPU (software rendering)
> > 
> > Not working:
> > * GPU (WIP: firmware loading but output is jerky)
> 
> Please tell us more
> 
> > * USB Type-A (WIP)
> > * Suspend with substantial energy saving
> > * Audio, Speakers, Microphones
> > * Camera
> > * Fingerprint Reader
> 
> If it's connected to the multiport controller, you should be able to
> just enable it, like on the T14s, similarly to the Type-A port
> 
> [...]
> 
> > Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../qcom/x1e80100-tuxedo-elite-14-gen1.dts    | 798 ++++++++++++++++++
> >  2 files changed, 799 insertions(+)
> >  create mode 100644
> > arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 140b0b2abfb5..f0a9d677d957 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -298,3 +298,4 @@ dtb-$(CONFIG_ARCH_QCOM)     += x1e80100-lenovo-yoga-slim7x.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-microsoft-romulus13.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-microsoft-romulus15.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-qcp.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-tuxedo-elite-14-gen1.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> > new file mode 100644
> > index 000000000000..86bdec4a2dd8
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> 
> > +&gpu {
> > +       status = "okay";
> > +
> > +       zap-shader {
> > +               firmware-name = "qcom/a740_zap.mbn";
> 
> Are the laptop's OEM key/security fuses not blown?

Can this laptop use "qcom/x1e80100/gen70500_zap.mbn" which is already a
part of linux-firmware?

-- 
With best wishes
Dmitry

