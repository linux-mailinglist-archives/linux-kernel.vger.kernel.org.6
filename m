Return-Path: <linux-kernel+bounces-512990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D259BA3402C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6531889330
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D9623A98A;
	Thu, 13 Feb 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpUD3bTQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECF23A9A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452832; cv=none; b=VgV5QtDiWlPke9mOJKSTB2L+RfrhjYWTzl7oVqWsoSA40l09zY/U66n8XDftN7MR9MoQPmv5RvSdUhTVaNBT9lN9VfYvuJtZVKWP+Hn9bd9UIdr4SGkGjR4tY+rWZIKQ8dWuiBJSsS2N/2K5MCwf02TMwxP9OAYc/v5+6lKCO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452832; c=relaxed/simple;
	bh=5mMVKySb8+gpzJOBAymm9Q7LjgPAm74RfF5CFTTcYUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkSdbmPVxY608VxWzWsfUWIY0mKN3nmgk27KQtbkCoRF/mS756yAD6hb/PFgKQiFTymqwcOBX4loq9sQa3TKSLnA9QkGLjd8ye/zUj7Wn3hZ7qe+/5uTn84kzmTi19hvY/tfukeYjQotlbjtM0m5r4Vx63yjeztFzPBdcscBWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OpUD3bTQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so6142545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739452828; x=1740057628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwLioipVK8naZwbwKxpHl8Exj/kHTAEgP/Hsr4XIrU4=;
        b=OpUD3bTQ3kRN85fqZamyvZOWeCkLAa9MZ/vGRhLsBViPwCcqFwS5ywWBYQzTMZ5XMP
         OJIWYcvaBJLNn00jyI1AbTHjxT7gDaL4sui+bZWlTMgp3lkkvaRbHWKbrsaUzr8Op6Gu
         uoQO/0y9Mk6vz3ClY2nevXd+WRv7alXVSRE9uFLPptS16fZIHIkiNmZsBJwBOd86DeDM
         gp5oUeXLX90eGLjgrtbyYfT4v3npmYXSxderwI2cbhzoj1SYZEeAW2zkSOlIwKuESkC9
         U6s8qE+gi4ay+v7WsG+EXcG3naZ2lb/4qlW03mDcOcqWz8VqvM7VAF7z7o6k2qVvVDMI
         gp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452828; x=1740057628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwLioipVK8naZwbwKxpHl8Exj/kHTAEgP/Hsr4XIrU4=;
        b=sz4JJIY7esDU+WsGU2L6uWdGKTZMTXtncMx9MI/jn0v/sUO2DyyhqhBJRWqU6EQjl9
         z4yM+TCciopdwNUA0BNxAuXJp3gniFNM8MmXg220nxKkA7mVGcunyphjBmsYY6OisKx9
         UDkK99AFltEA86eSua8BmynhQEzi/jdX+GP9zHY8RAZmt5lnkSrF8oBT056D19iMoVmo
         fnUSmMpkLniIQLsha0q4GthA9qqWh5tTx+0T/jNszyH+A6IzTPJZMpEChza7nov1VeGr
         MQvp2z6BlNFx8bBOaYfaL5Kf/7uYkqiQgTEHFibp2CTx8Wbhd5/Nvp8b9cpP067KqlSr
         XDRw==
X-Forwarded-Encrypted: i=1; AJvYcCVvXQ0VXNLg82k7S6/CzTYxeHG1C8cI97832cDh+qt9PJAGA70liCDb5vAM9l3olY0NtZFEYXstOaU19II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrMUZSho5siOur89yf2nzmCh8eun+ljc++505mkguR9Jyt5bB
	iAjTAbaw3myx2VtT6KoTjnXZt+pFS+3sF2XNCLAo2LZDeBsl/h9TlYlBLNhgfJU=
X-Gm-Gg: ASbGnct2aNRROhoFuEgIj0dqOeBpM8Ok16i0ra7aV7RUJii47117grMv9HdG0lH69Sq
	TwXUURPLvjo2TK4TPw/pjs3zNWB69psmq/u2odhaaFd2BFaBVtRohwmVopKon9OTXsoHwzYW0Tr
	fPyqRgK8nM0nVFbJETU8janElAISVoel/jkLzVzTsznx56Ygkwxm0j4bl3W2MWi5By6BMVXzf+5
	oZsusIb2bG0q1W671YvO1p0J+ERdOhk1TL94EDpFJPoyUjvVtb6Fuw8g9Lg/HjGoLN9wjpODX+z
	tR5rUcRquOJZzezlBSsXHM6Qavc=
X-Google-Smtp-Source: AGHT+IHa0iJhUdI7Oeca63Utadvd2nIPWbwBwu9HdjYNmDjYhPAnw2Ag6cr+5vfrRyb7rW16Cvn+DQ==
X-Received: by 2002:a05:6000:2aa:b0:38b:da31:3e3e with SMTP id ffacd0b85a97d-38dea28ccf8mr7582277f8f.28.1739452828283;
        Thu, 13 Feb 2025 05:20:28 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:5695:683f:dbf5:a2f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbb2sm1858848f8f.40.2025.02.13.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:20:27 -0800 (PST)
Date: Thu, 13 Feb 2025 14:20:23 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add crypto engine
Message-ID: <Z63xl4_Lii0zBIYo@linaro.org>
References: <20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org>
 <Z63xEdcvCRHchHWu@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z63xEdcvCRHchHWu@linaro.org>

On Thu, Feb 13, 2025 at 02:18:09PM +0100, Stephan Gerhold wrote:
> On Thu, Feb 13, 2025 at 02:44:02PM +0200, Abel Vesa wrote:
> > On X Elite, there is a crypto engine IP block similar to ones found on
> > SM8x50 platforms.
> > 
> > Describe the crypto engine and its BAM.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > https://lore.kernel.org/all/20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org/
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index 9d38436763432892ceef95daf0335d4cf446357c..5a2c5dd1dc2950b918af23c0939a112cbe47398b 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -3708,6 +3708,36 @@ pcie4_phy: phy@1c0e000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		cryptobam: dma-controller@1dc4000 {
> > +			compatible = "qcom,bam-v1.7.0";
> 
> Hm, I would expect this is at least "qcom,bam-v1.7.4", "qcom,bam-v1.7.0"
> given that this is a pretty recent SoC. I don't think this makes any
> functional difference though, and we don't seem to have it on other
> recent SoCs...
> 
> > +			reg = <0 0x01dc4000 0 0x28000>;
> > +
> > +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			#dma-cells = <1>;
> > +
> > +			iommus = <&apps_smmu 0x480 0>,
> > +				 <&apps_smmu 0x481 0>;
> 
> Should be same as <&apps_smmu 0x480 0x1> (0x1 is applied as mask to the
> SID, and 0x481 & ~0x1 = 0x480).
> 
> > +
> > +			qcom,ee = <0>;
> > +			qcom,controlled-remotely;
> 
> Please add "num-channels" and "qcom,num-ees". Otherwise you risk causing
> crashes if the interconnect listed below isn't up (anymore) when the
> driver probes the device. See:
> https://lore.kernel.org/linux-arm-msm/20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org/T/

Sorry, I meant:
https://lore.kernel.org/linux-arm-msm/20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org/T/

Oops.
Stephan

