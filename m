Return-Path: <linux-kernel+bounces-398445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6250E9BF166
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DE71C22F31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B52036E2;
	Wed,  6 Nov 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYK5+U5i"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89202038CA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906241; cv=none; b=HDEej38Mj9EWV/GHiySm/pOQGhv6UueTRsTGorj8xcAH90Fvv47pxOkd5WjHsUvpCQnHkUALdamR0j/VXHQfE1JQAYDQbK00cVLmpYE2k/xXknsn+WxpGn74IRSBgIO5QpgkN6NxN+OFFSJtGZE3XccCUCpd3kZe8DAgSSQ+TF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906241; c=relaxed/simple;
	bh=ic8cVOX8Eb6eg3pSMbWKLDgRehM3KQGs7TIkjwW/x88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyR6wR7zMgsh0dQfQDK750lGo86eIiZfeI+rXYCqFXwFSJ3uS6/d6qdfhjKMj3vrQUifIl1LVQMsEYi/N2PmYWrugMLUNFABJzKAlxatTGMEBG0iqtDXQdQL4E3XUWG6grNuPVcYTOW7z6Z1xnsN9zJhLOHB2md7OBKaLMIml5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FYK5+U5i; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so6679589e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730906238; x=1731511038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIEbwD5dLW8FMUuswU9FQws7jt6ecUWe6Cmn0F+XQJU=;
        b=FYK5+U5ipyfre4PXeV2yxoNp2To3yjgZKWPV3QPQjzQ0k4XUajA55xQDDoF8Im7mLq
         ZxUGW6avfrmOWrB/d/5VsJOgcAG9QFzS9hwuXDovtT4a25mBw93RRCzw1zPY2oWNK49q
         vu1DH3VocdLByW2VveC6ec+7NPcbwlli+mq0bfamWwSxkZtRf244U8InbDHXQx4fHEo2
         4BftKv/wicxhSUOANDlixvrPC+pGSx8iT9gzVVrqD4GD4SWDixpY2xCIZbYnP+vrxefn
         xsHBgDAy7VUtuZ815urDWJH/2pI6is/P/hGM9mh+tgwhE+OMjxN5lSEFWqe3PhgYeTuC
         G8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906238; x=1731511038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIEbwD5dLW8FMUuswU9FQws7jt6ecUWe6Cmn0F+XQJU=;
        b=wJ3EmXAq4TzX2Ia/186DMWOtvkzsYgP7yrPNJIVsOaoQz7hjFhvFuRrCdw43xhP7c2
         m4PupAQvygQS4gESZDvRAtTBgaKQiBIjTuOnHb/rOMzgEvqpYuNR7OUEk8ddfdpglzUo
         E5ShJ1jvA6bJPPxc4h95cyYPc1rXRPFPdSJwQ1VWbo7PtN0KkytxIC+BBICoIIo+uxSO
         hQTYd1LgeouA9rqpO7J10yr/ZJnAWl93Mp5UoPEocDsHb9SpasWh7Yt/1EOSPZHfrcmE
         +S3uU2EK3ByshYyP0uiRG0TI3ndf9cQeJK/ti1YDXeQPtCDSgnh400oRG1J9coVJupzK
         xppg==
X-Forwarded-Encrypted: i=1; AJvYcCXTS8UlwIY1/L0YIPOPWzDmgi6Ou31RFphZ0FLHv6/9Ak+bZzLyiwZDXEJdbGXkO1YfNngezc/LDWgdx9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkASCROHAxo+RE3IrqFurLwHnxtprxINYB6f64urEGa/zrsiXt
	7MCX97QDz8zsI9SEn4t0/sEFRI0MOUvMy/goRYFgMRPkKywMiqXKyPOWenUwHEc=
X-Google-Smtp-Source: AGHT+IG7dwaa2yN3o8y7YIOO0cvRLcrkbQ+DzFVy+RFiOkuyFesN3/6MQCXs3ZxexqpX8BK5K41+LQ==
X-Received: by 2002:a05:6512:3b1e:b0:539:f37f:bed9 with SMTP id 2adb3069b0e04-53b348c38d4mr21239539e87.8.1730906237946;
        Wed, 06 Nov 2024 07:17:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcc305sm2520122e87.227.2024.11.06.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:17:17 -0800 (PST)
Date: Wed, 6 Nov 2024 17:17:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>, regressions@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: enable OTG on USB-C
 controllers
Message-ID: <5mfq3xf2qkqyrtaybtfutx73rny737rqdd6exdbhljcebg7brs@fxaz6zhsy4pd>
References: <20241011231624.30628-1-jonathan@marek.ca>
 <hw2pdof4ajadjsjrb44f2q4cz4yh5qcqz5d3l7gjt2koycqs3k@xx5xvd26uyef>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hw2pdof4ajadjsjrb44f2q4cz4yh5qcqz5d3l7gjt2koycqs3k@xx5xvd26uyef>

On Wed, Nov 06, 2024 at 02:37:43PM +0200, Dmitry Baryshkov wrote:
> On Fri, Oct 11, 2024 at 07:16:21PM -0400, Jonathan Marek wrote:
> > These 3 controllers support OTG and the driver requires the usb-role-switch
> > property to enable OTG. Add the property to enable OTG by default.
> > 
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> For some reason commit f042bc234c2e ("arm64: dts: qcom: x1e80100: enable
> OTG on USB-C controllers") seems to break UCSI on X1E80100 CRD:
> 
> [   34.479352] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: PPM init failed, stop trying

#regzbot ^introduced: f042bc234c2e

> 
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index 7778e17fb2610..fb16047d803c9 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -4199,6 +4199,8 @@ usb_1_ss2_dwc3: usb@a000000 {
> >  
> >  				dma-coherent;
> >  
> > +				usb-role-switch;
> > +
> >  				ports {
> >  					#address-cells = <1>;
> >  					#size-cells = <0>;
> > @@ -4452,6 +4454,8 @@ usb_1_ss0_dwc3: usb@a600000 {
> >  
> >  				dma-coherent;
> >  
> > +				usb-role-switch;
> > +
> >  				ports {
> >  					#address-cells = <1>;
> >  					#size-cells = <0>;
> > @@ -4550,6 +4554,8 @@ usb_1_ss1_dwc3: usb@a800000 {
> >  
> >  				dma-coherent;
> >  
> > +				usb-role-switch;
> > +
> >  				ports {
> >  					#address-cells = <1>;
> >  					#size-cells = <0>;
> > -- 
> > 2.45.1
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

