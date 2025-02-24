Return-Path: <linux-kernel+bounces-528663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A6A41A67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4BB1885DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32124A075;
	Mon, 24 Feb 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c30knrbo"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC640242934
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391921; cv=none; b=SY9pHIzOEGMEKdKiy6qfBNLFLpCFvfJbdmlTcos5pKJR9nt6RmHhn1dzep8LUd001627X1WB5ZvvXJJkSxw6I4IjqwbmZrJS6VNO4PHLBh1zAI+EAyZCDqSWHcO3brqJeFN+U5Nyr9z7GnEoD3JqboQFi7OCd/E+VNVhPothMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391921; c=relaxed/simple;
	bh=fKXxxp8mVUx99PTCuJ9lTvEvjgM846KcN6TPo4R/fBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGBunRQKse85XNq2Z7Awx81c1D869XXL51ZZQEGle2JliOcqfoMtonEwyWcUq7W7k1lHauDLdQ8b/4DQ7Ak3mC/e9qdEcJlPXgCkal3G0gU+blSziVLhtvcKrjSpUyPoaMi4DoWxh7zpKen8jCxh5BkqbraFhU5XVgoi/AlcS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c30knrbo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so9537784a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740391918; x=1740996718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CU8WACFROSgTLo9Ox03v99I3iVcvKceQqegZUMUwxvk=;
        b=c30knrbovl3LBy7d2vKl26KV58/0RgFZW4EkY+B1DWzfBl7ME2Edr/dHTXtYikfdxK
         yzWpg/oBlkywJGY5kaSLpi05rGfM5Q7zFslmflLb14NcoYDkYyno72qm2qZc5OPnhS8P
         qgNXKXwC5Yny/w8CYqdx+zWzUh92DPQHJOhktShNgeaqj+CtYc7okbURNPR9kWy6YEVa
         Qr5qUyZkN1X24XCGhvhSo6gcGk5kqawU+3TI2iVs0FXtrAEY6t1/fPugH0DQtLW3xIYd
         /3kdrWCifI12DGZpTuRYZJuNavfygRQlCuJazK4L4gh7GIT20Hz83tJQRmSUbLsJ0m9d
         j5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391918; x=1740996718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU8WACFROSgTLo9Ox03v99I3iVcvKceQqegZUMUwxvk=;
        b=UWoMyMQoaaJOtxkXqIz3xPHMWBqunQM6ePhXIky9rNHGE3pArbp9mN+hVrWFBpQt8u
         h7ZTncfxoVQHJERuryPbfsXmzC846OcjlmN45GSJuejG2scyVmRWwYWJEIxlx94z/+Yb
         TzWMoiJFr5x85hsKTLQH7cSEAueJ+Wpf1p3B8NNm8PUlEKCr+N+yQ7LNSk6KiXP3rqsc
         v3/aINc+zPduAVK7oLLe1qdWH8cVq+WZPkQurIyNMD0mko9VmUtzWLduoDyDZ4cf21lB
         aa3TTVksGjL4dfyOxP26G2gUQ32WQxZ/qT5G0Zy2oXGq+V+IJ87g3og62zHm4+/2glpn
         HnEA==
X-Forwarded-Encrypted: i=1; AJvYcCVyjOpLcfYCsFs+HMKdE8WTnHUd5/v7sgA1CeJ82RQ2raMY+YH89eCyrzY0L9QSAsiJ8xuUlFPSVOGf+bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoL4WilwUg2icV6ak4LvTNb1ZtL2FGt6LghPs2hoKhW0+Xe3+1
	ibnohyB2/tFnPT14/F9Xbjd8hFI3HGsshMJLMOEq434TgQ14hz0kwtY6zQAvMW0=
X-Gm-Gg: ASbGncsJI6kM4YhwobIziht45JvuQTOtHMmBQUwf5YOpMmb7ZJq4RHWhohSn5U1Vp5O
	qPsASoADBNVjB+17bKRYefV4i1VST+vj6g+iTFmX52GRX3ZpZZELJXunFud0/60gpKAzIEjuP6X
	V3INTBlGHS/Zayo6FwkL7ttyfBde6VfQU6QD+jOlwElyirLlLSMkViMQBHcZ4XhEbs/netgBW2f
	7HhEuZEyVLB9KddKaucZt4cUjopYinqWKzd/EPOjeZe8waJdYnAF5wBrmqehZro2/bcVJuyjamr
	nDyfpIykvnSoH1pWb4bIdek=
X-Google-Smtp-Source: AGHT+IFBYGv39ku/WXgGCB6eZU2Nhkmme9NrVcRsypJZXftUwbVR6qfXWzvvkzePYp6cqUbaZIeE6g==
X-Received: by 2002:a05:6402:524b:b0:5de:50b4:b71f with SMTP id 4fb4d7f45d1cf-5e0a12baa86mr13103989a12.12.1740391918073;
        Mon, 24 Feb 2025 02:11:58 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2709b4sm17963793a12.57.2025.02.24.02.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:11:56 -0800 (PST)
Date: Mon, 24 Feb 2025 12:11:55 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] phy: phy-snps-eusb2: make repeater optional
Message-ID: <Z7xF66TctF2wuoGj@linaro.org>
References: <20250223122227.725233-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223122227.725233-6-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223122227.725233-6-ivo.ivanov.ivanov1@gmail.com>

On 25-02-23 14:22:24, Ivaylo Ivanov wrote:
> Some platforms initialize their eUSB2 to USB repeater in the previous
> stage bootloader and leave it in a working state for linux. Make the
> repeater optional in order to allow for reusing that state until
> proper repeater drivers are introduced.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  drivers/phy/phy-snps-eusb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
> index 4e5914a76..dcc69c00a 100644
> --- a/drivers/phy/phy-snps-eusb2.c
> +++ b/drivers/phy/phy-snps-eusb2.c
> @@ -461,7 +461,7 @@ static int snps_eusb2_hsphy_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get regulator supplies\n");
>  
> -	phy->repeater = devm_of_phy_get_by_index(dev, np, 0);
> +	phy->repeater = devm_of_phy_optional_get(dev, np, 0);

Maybe make it optional based on compatible or something?

>  	if (IS_ERR(phy->repeater))
>  		return dev_err_probe(dev, PTR_ERR(phy->repeater),
>  				     "failed to get repeater\n");
> -- 
> 2.43.0
> 

