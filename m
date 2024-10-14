Return-Path: <linux-kernel+bounces-364569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16C99D63D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E8B1C218B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E91AC8AE;
	Mon, 14 Oct 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iq/e39Ho"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79281BFE10
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929774; cv=none; b=mkdtdiHUj434lBo3AxErQtQrDJGaY53htz//W24vKXCCeeV0u860FEcxDfL1s3rEkR53n0gC7PT8EQSxqJKqhy05GGaUecn4jrvpm2I9PdW8rsDhBCF2czv4PwrGoT7ScRJymNzCdKPfSX0+l8eGZTquOtCO7ApeQwTG0vwoIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929774; c=relaxed/simple;
	bh=LNSqYzxmmz9OD/0UUcyOFn6AeN1Z072goWVOC0q2yrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjmEWE7MPG0fgTCApvVTvk2Q9b86o8+m0qkMZ82T9sX+oUt87CLKp7wgE1X5jplX/oaWr56cQqVxD/51FqbgP6Zw3eZHmllqZqUtk/CPBHy9f4yDJ1nPPacERbow6EUb8yWgjMVA6JfXy3aJR1XhSqktqej8zObPfoT+Jzva2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iq/e39Ho; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so2903540f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728929771; x=1729534571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtdPkrYN7fe8w5mEL3LeVayblW7M45DrbmZRpipI97s=;
        b=iq/e39Ho83LrRJLweE7RmoiKxCReXY6UGTvGrYtrofUdDQoUHE2k87bTo/K11qN6rN
         QHS3lNmmOLU8cRSkovgIjMcq0fccawkIyu1ZjtmBKd2SK6Ar3/l4j0JB3ruCTyJNuMKg
         GdNFjTih7u6y5wWQ7JCiANNECKZ5y6hHBLORgSnfvr3h1YM2/KLAHQzqgvGpvetdeySg
         DQ/e0VAm/uk3pGbb8lbgpoQC9/eg5RPcXPiYhM2nCJgQf7z6dRNJGV5XwDqO2i2EmWIv
         YahG0RMxnK1NDCbQCtixyS5k2KdA6ardCV/9Fopma4f4wRGaT18U3awUXRjPB+l2L5yr
         rcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929771; x=1729534571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtdPkrYN7fe8w5mEL3LeVayblW7M45DrbmZRpipI97s=;
        b=whNldjFCrpJ4qnFrURp9+CNPnqGJeNvXYrhujb0rmFInznZmr/xdo9gsP+hJsiY2gV
         5aa85hXgTc7YcTl4462azcFYpZ7j7gQD9skwn9rqYPKGFdcYQLvKJ85tHop65SifF06D
         XWP4Thg5NUYcnsNtu6JAXLr9mNyIG0pFutbecr9Q7OCMBisAzY5esUv96LVk5Nn1ShBW
         i8CC8kWWqKS7XXGHHvxN3jGsJuXOHdLwMofb4SqlEMtwwi+zCLgLry4NALk0oXSNh7rg
         0ms0g6U/W7YM1TPfel9miqyaquu1p6/kTO+uSYotTshFBYkXtepoGwo/bciartzBTHa0
         TidA==
X-Forwarded-Encrypted: i=1; AJvYcCX6CdndMK5qbds/Y41I1EUfMMMahmPNAxA44rdSW6obrQRDdNJSSkN1FXgyUGOB4cZOeEpXzPSm9UZbnJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMn4p1E8a0tUiuZtTdajj/oKpWqqfymrUehG4e/0Ueu/kT7+2w
	YonZVaxnM9v4pbAgLGvAjcXOosIJT9iRNIWy7ayFYz/nPNqu/Yt8o4pW/zMgqvY=
X-Google-Smtp-Source: AGHT+IHIQJqhAsmdVgPSCMWemS66sPfa9EYola/ZvTPYafkvTQqqNnZqlNbzsw8xXyLnNoUxhgl25w==
X-Received: by 2002:a5d:4dc6:0:b0:37d:4657:ea78 with SMTP id ffacd0b85a97d-37d5529f8d6mr8858619f8f.54.1728929770899;
        Mon, 14 Oct 2024 11:16:10 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7f05bfsm12010610f8f.108.2024.10.14.11.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:16:10 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:16:09 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Force host dr_mode for usb_2
 controller
Message-ID: <Zw1f6S9d1JygJ6VU@linaro.org>
References: <20241014-x1e80100-usb2-dwc3-set-dr-mode-host-v1-1-3baab3ad17d8@linaro.org>
 <c1cd82c2-5af7-44ec-ac18-996dbc212ce0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1cd82c2-5af7-44ec-ac18-996dbc212ce0@linaro.org>

On 24-10-14 17:48:37, neil.armstrong@linaro.org wrote:
> On 14/10/2024 16:14, Abel Vesa wrote:
> > The usb_2 controller has only a USB 2.0 PHY connected to it. There is no
> > USB 3.x PHY fot it. So since dual-role is not an option, explicitly set
> > the dr_mode to host to match the hardware.
> 
> I don't follow, dual role is perfectly possible with USB2 only, where is the limitation ?

You're right. USB2 could be OTG.

Consider this patch dropped.

> 
> Neil
> 
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index 0e6802c1d2d8375987c614ec69c440e2f38d25c6..4da13c8472392d842442193dc740027fa011ee1f 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -4143,6 +4143,7 @@ usb_2_dwc3: usb@a200000 {
> >   				iommus = <&apps_smmu 0x14e0 0x0>;
> >   				phys = <&usb_2_hsphy>;
> >   				phy-names = "usb2-phy";
> > +				dr_mode = "host";
> >   				maximum-speed = "high-speed";
> >   				ports {
> > 
> > ---
> > base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> > change-id: 20241014-x1e80100-usb2-dwc3-set-dr-mode-host-35312d1d25b2
> > 
> > Best regards,
> 

Thanks for reviewing.

Abel

