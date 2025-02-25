Return-Path: <linux-kernel+bounces-530442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D9A4337F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E0918925E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996224C67B;
	Tue, 25 Feb 2025 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sH69G2Vd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7524418D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453467; cv=none; b=QAtIlwzzajDZ8aO37FYRWoVnOlj03vn1EivmfoszAcNzpim3WkqK2buz5jzX0ow7O9GKXeadyN2ymml1IbR0bgl57LqHW5saJYfdM/Hja/B+vCCcXbUilwePnxQJjk4ueCain7b73hd6N5hNN2mOeL+6eR1CJ/53JoSi9AHgSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453467; c=relaxed/simple;
	bh=tbCy+DgoiEqp7P0KYIuTrwCALW4WbEtXM2gHBfT/4WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgkWLP/4WvbJUKEFPqAHYquGkV7RGYRlyqLriUGBIIXKd5y0TnPgCiNNGe7LSckVLNovaBtfm3gLgVreaJhavv1qRAy8VFWTCrYQcE0Gck+w6zCgJ38/b0cMjGl46k/bGzFXdS96/baNYTzJLR6UZPPR1z3c+cuwtAUmz9woZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sH69G2Vd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5462ea9691cso5691929e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740453463; x=1741058263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8Rx6B8ENt8mk1zd17zD1gzF1s2RlMqc2vCUueRva0w=;
        b=sH69G2VdlqLiGIFCFR3nAQ+um7Pz52pf5q3zAYcHfmf8s4vu6+T0ATnUwLXIX7lsYd
         jjl/itK4fIxqlfAaT7QeZSNpF7++5qGmFgLyVm16byAmmKvFJjJsfp9is3KkkUuBSY4b
         awJyHpLXzDhDIXIfrtMnBRm2m/gWPeb4ssx80sX5RJfVCUJbNqjTYnLqo9IRJJxQjAuz
         uLibC6AoDxu8XT9nlnqz5wCIWE3AZSPsGu6jsLI4NeHZzziEVvWiSc70HBucHh4af3Kg
         jKE9N9qTkkjbFSRQ4LT9V3neQ9lh1bDpzRh9EygiSpwLIl6I0Ga0W9a2NvbqAPtWLS4o
         deLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453463; x=1741058263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8Rx6B8ENt8mk1zd17zD1gzF1s2RlMqc2vCUueRva0w=;
        b=ZoINMa+PAcqJMWTGjWxXk66vY1yWheks6O3+PYVSj8eeTMYQilD/O9WLFbWMRkbe2M
         667kbTsyeMF3tVgeoiZRCO1foRpYm+tTYK6DpJrhjHh40aMXbZC9Q8AL2VfglLAJ+2IN
         e3LQB2BIr0BInqaSt7/Pd6ntNC+sRV0oYBJbhcpwjP045+e5vvKMG4JlLytSFgBSBe4w
         8To+p2Huzt5keYfzFzxoMkzwZzcR1rotYgcHfQbQKsE8zowhiouUHsYRvJWPvjP2mKsQ
         HOqBEMcpkHN93/jMgq2dzdP/xMS2NpXF+Pi6c+2t/+op6ShjZ7PAGYNKwPtOB2fJK1LC
         OZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa5f5nGIhHOHn8HEvLrb2fMMFAzTVW3Ogv2Xbe77YcINv5uR5OMvxAG1fl10ovhQrnMpEC39UdAd2QJ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBNi5V9sGddrJr3hidA8/3SJTbnCctY8FzSZr8ZFI2K1gWSJI
	P4loKI6dCgnH/dMaWtL66hzLbPo7aq8A796aYAvNU9jiIvo/RwPExLDit77fj+g=
X-Gm-Gg: ASbGncu1FBcL7JF7AW2OCDHjFuFC9umeug8YkaIwCG8nidGCXsM1b0w65uskMWIBzWD
	f+u3IpY7Qp/I4L1vpUAr/Ua92rW/341NuWzx8RU3t0bfGpR02KU3EJIqJGHEr1M9E/HSn7nCfeq
	3ktBOoYynczRziDXFqeweNEGhR6Ci5xvefgNzGSSTysfdfyFQTuwIif/8uWlDjbceu0iTxCNLx8
	8rLDVJzppb8x8LH7fkw4qOaOlaO0RXHMEMUA6iHESAssgVvT3SUitn1hjbJfnLaEbg+Y7vIY7BY
	clCNwcHP2VRjIoTsD4+GDsv2zvc4Hg4VApdVq+zGPpXwWvyxMShDUfTgRiZIihs8ffRaj0DWIw7
	6BfklHQ==
X-Google-Smtp-Source: AGHT+IFC1G+Qt1OfzDp64XzP6VaS1qBh0uBCplEpmO2VczKHd5eRQaq8KvOqpCDlmmDiv/XhQqWkzg==
X-Received: by 2002:a05:6512:108f:b0:545:27af:f2e4 with SMTP id 2adb3069b0e04-54838ee8c9fmr6726358e87.18.1740453463391;
        Mon, 24 Feb 2025 19:17:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b25d0sm62961e87.32.2025.02.24.19.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:17:41 -0800 (PST)
Date: Tue, 25 Feb 2025 05:17:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sdm632-fairphone-fp3: Enable modem
Message-ID: <osoaqtrqtm3s4lksqmlsimyjsbcgozfo7gzjfmxntdm5mvekch@5hhumagio6ks>
References: <20250222-fp3-remoteprocs-firmware-v1-0-237ed21c334a@lucaweiss.eu>
 <20250222-fp3-remoteprocs-firmware-v1-4-237ed21c334a@lucaweiss.eu>
 <bz3mola5r7v4rs4esmhiticq2ahpkhtwxqnv6nweyfkebszvrp@ap6yn6pvrtww>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bz3mola5r7v4rs4esmhiticq2ahpkhtwxqnv6nweyfkebszvrp@ap6yn6pvrtww>

On Mon, Feb 24, 2025 at 02:18:55AM +0200, Dmitry Baryshkov wrote:
> On Sat, Feb 22, 2025 at 02:00:50PM +0100, Luca Weiss wrote:
> > Add the necessary supplies and set an appropriete firmware-name for the
> 
> Nit: appropriate
> 
> > modem and enable it.
> > 
> > Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > index 5611209dbfa41d7834af7903535ed3e05604ba63..31ed26c31e6ea381a8942ccf569513df3300cdeb 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > @@ -87,6 +87,14 @@ &lpass {
> >  	status = "okay";
> >  };
> >  
> > +&mpss {
> > +	firmware-name = "qcom/msm8953/fairphone/fp3/mba.mbn",
> > +			"qcom/msm8953/fairphone/fp3/modem.mbn";
> 
> THe comment from the previous patch applies.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

