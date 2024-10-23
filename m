Return-Path: <linux-kernel+bounces-377563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736859AC094
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F01F24BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983DA155C82;
	Wed, 23 Oct 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odJ7LRLg"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E215443C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669624; cv=none; b=Q0ZdkLw9dg4x004Cx8Qq3WFCwNqv6nBl86buQIDTAEC5MDkY71yMlF69Bi8UYEGo8uQ1nEqGfISHBcbg/9wYzUH5EGs96ZVTmmWugdIXh5Jherx/hhd40JFvT+9FsuKWaXkVroy8/McwJyVmYY2C6QcUsgeyVRKUePAetQVXBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669624; c=relaxed/simple;
	bh=QuCmoqfngmnxfQ6uT2MtG4cs70OVMHmJ586aBYRnGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkkDtKiBkQn0X6FTbq1SpEPhkFzIWjXLesGz2rDF7i4wWEOiq3q+shKMDb0tqMmHa2lZ1LiE0AamXWpWW6S47H4y3qXqOCWlCItiAODwW3jBZliRySoJsFaoYp11hGfgbaz9+Zz2zDB4fG+vLoxUPpMTRMqSxHsuBBw69cwyYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=odJ7LRLg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so68483365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729669621; x=1730274421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=liICTeLXULEGRFqaDSFlDIwiTh7kWdqnepDYW7yyxPA=;
        b=odJ7LRLgL0ZPB6aOH+1qJFPEmMNQPeyhTjstocRQ/MCXm5DkbHefiLph4bMeHnmBFf
         cNAG6U8uG7RIS2bZGtjt8Tu88oY9iZQtAePvEOk9tM7wLYD3al5RaL8y9EujDLR+owKD
         S3e+ztHU9J1g/anhH4gH5iFaSfwsRiFVerBOycL9Mzj1S3pjYT31LjNfvh8BHLgFfzVT
         h6/IAolg5pETY5YH+u+vf5jlB7ZrPqv3ZiJfGW8VFfp4KSx+at0hlutV3ubA4RevlCy7
         Ljx9MzojrJdZSTZArQx20C8uwBK6vFTF5OrkiMm1yQzR6GVdMzUocNbVZCncsANxbC9Z
         BgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669621; x=1730274421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liICTeLXULEGRFqaDSFlDIwiTh7kWdqnepDYW7yyxPA=;
        b=w1cUmL8B6W9g+R8SKFq+fAp4ElY6SrerCFfLKikl+e3l18TEP8JeU4w1nlUWpu8vgJ
         ilS+rpPaKDvwrEUgT4dUTyIWa2LOCsn/BaQPeU8/zegoMkq5fZ3LiNaE5cB0FPZgZU5t
         ph5up06fSnFTkl5V205CtlqJjpfNTMw1yF1bl/EXutDiRixrM7coh8Y2CKySusDFpjAs
         NgdXXzIrMuXyPFKYwULrFQ5sL3hpfvt32i4WvzC3sYIzp3IRI5hQYkKiqqMp+YhxwVUq
         XZPV2fF9X2v78trayklnkGQE75g8+u6P6qpRhU5K/nM6L054+cNcjuakREbeJCbcEYOG
         n3pg==
X-Forwarded-Encrypted: i=1; AJvYcCWa9d0NdlH1bRkNeyqsgPcmFJ3fsspNVKrcE+qD7X217qOjao2WEtq44GlCC4m2cP33MnbapOP1XKJ8KUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MESGhqFlKMTpnXIC4Vdeu001NYu+k/Q2uHrn5gMWrt6x1+9w
	DqeqV0w6N72Y6EFobG+yk7ciS5t2jIrrwCRwJnuULsAZzuw0AX0YHIl0LfnT59RjFfvKT65ci5B
	2
X-Google-Smtp-Source: AGHT+IG2L/bf+gjq24KqYERf6MQ4wawa9hyuhpxIU5GnUxegChtaKctOKmfVTwI/Jjig1MCKlllQNg==
X-Received: by 2002:a05:600c:1390:b0:431:1512:743b with SMTP id 5b1f17b1804b1-43184169c3fmr13602085e9.21.1729669620617;
        Wed, 23 Oct 2024 00:47:00 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37df9sm8303727f8f.19.2024.10.23.00.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:47:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:46:58 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: x1e80100-crd: Enable external DP
Message-ID: <Zxip8j7dgrWkjOH/@linaro.org>
References: <20241022-x1e80100-ps8830-v3-0-68a95f351e99@linaro.org>
 <20241022-x1e80100-ps8830-v3-4-68a95f351e99@linaro.org>
 <hoszdyny34qr5kmtkq2fk3m24kixuwlyavpr4ufrf5vo7gkz7o@gxo2mw2lbxj3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hoszdyny34qr5kmtkq2fk3m24kixuwlyavpr4ufrf5vo7gkz7o@gxo2mw2lbxj3>

On 24-10-22 19:32:18, Bjorn Andersson wrote:
> On Tue, Oct 22, 2024 at 01:26:57PM GMT, Abel Vesa wrote:
> > Enable the remaining MDSS DP instances and force 2 data lanes for each DP.
> 
> Please document why you're forcing 2 data lanes for each DP (should this
> restriction remain when we add support for 4 lanes?) - and I would be
> extra happy if you spelled out your abbreviations.

Will do. 

> 
> Regards,
> Bjorn

Thanks for reviewing.

Abel

> 
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > index 7cc45a5cd7eb7e70915d04ea7e181b56f693f768..db36e3e1a3660f3bcd7d7ddc8286e1ff5d00c94a 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > @@ -1105,6 +1105,30 @@ &mdss {
> >  	status = "okay";
> >  };
> >  
> > +&mdss_dp0 {
> > +	status = "okay";
> > +};
> > +
> > +&mdss_dp0_out {
> > +	data-lanes = <0 1>;
> > +};
> > +
> > +&mdss_dp1 {
> > +	status = "okay";
> > +};
> > +
> > +&mdss_dp1_out {
> > +	data-lanes = <0 1>;
> > +};
> > +
> > +&mdss_dp2 {
> > +	status = "okay";
> > +};
> > +
> > +&mdss_dp2_out {
> > +	data-lanes = <0 1>;
> > +};
> > +
> >  &mdss_dp3 {
> >  	compatible = "qcom,x1e80100-dp";
> >  	/delete-property/ #sound-dai-cells;
> > 
> > -- 
> > 2.34.1
> > 

