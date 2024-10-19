Return-Path: <linux-kernel+bounces-372839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D539A4E21
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91E11C2310A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097442AF17;
	Sat, 19 Oct 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgNZPk/A"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C78BEC
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729343759; cv=none; b=usrz5kTgf2/jZM2sQbP9cB4g+RUMTkAUcFfBPIcUXquKzxJFwI8H3xcwsCsUawTBoAB3wIDTQgYyDDWitYF/ecHEptJqiJZxqG6u0E1g8oNS+ldekGvHNAGNjCF31y09mk572ssfjyHzAI9+eYETmfxvMSj1WYrO5pUmerBXg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729343759; c=relaxed/simple;
	bh=wISQD/DiPmIf9nJtmm3pdMffWiKrAmYAz8lDC5keNaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RchjaG0tZuKD5jqGLiZAYW/q7p1fIZl1CjKsE8MFvts4U4s2Sak4M+0wQwQ3rz3xyd2BsqsPT8m50+0UNzhq1owTYbbUNyz6flaP4TYd/UvqIOLWLuWDpfEETirkzp6L60Jxmgxt75hKkx36c1OGSRzdVgssbBm5wtb68bCNxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TgNZPk/A; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f7606199so3451763e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729343754; x=1729948554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nLoh5AgznUgCvu6vNVjF8MRQRk0OBbGWJlXddyz8ddc=;
        b=TgNZPk/AFrSxalV3Pmt+6FoQ4aaYZEQYLxPxIPZevJUopeuazvj1mucDc/NtRItd+t
         kWGLgKGyb8eXtrd6fk4Dha+BROIFnR2FVMABf6RS6ksn88d2YjO9es+lZpOOb+7htBRX
         WbVXK3grEMqm4WDl6y2ndz0tRnMDuF6NcdVjrq+g7no/KbD+FV3Bn1eOr0aPuJmVqLbe
         6Pivxj5JfRdzIlaLV9z+GgKN3DDiRXxvgHZ7/+3L+7XsjdtoKmcaS5xPqoQt3NDrW8gC
         TUHC+qmOTtML2l31RiBTbBNnYV3LlOrX1XeP7pWZOiVzuIOqzYva1n8vC8G7gh7phuSu
         JevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729343754; x=1729948554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLoh5AgznUgCvu6vNVjF8MRQRk0OBbGWJlXddyz8ddc=;
        b=LrtyZTbcvztxbbrnVd1j0EFSF90ORm86XAau+U5pf5wbHZGDQFu69Zc4okKj0d5oAJ
         XhOY7kzh8CvTmP1nycOWuTp+9BIzmr5TNjWWfJ1dkyOYamS1pnMpMcpbRVbrErWE8yBD
         EtqU1I+UMrP8kMauDFzMaZ/OgPBHHpLS2hbPpTBiGAhnaJPP6JPJ8v4WKuPFogt3n7x5
         KwcsITd8bzt8Y0JittdEFX0RF/CYOUXnvSl2GhU5dKnbSBSsLCcrGUFfzjFp4X2/xmHz
         XQyeXjC8SCI5qdHhDxcsA4hWzEKigmFE9RRT3U8mS66m0fOcACAmDlqa71QqXmT5OFI0
         EZUw==
X-Forwarded-Encrypted: i=1; AJvYcCVRzSRqeOyz41yH1CVQiy8T2910fiNIZwmGfaVM3XSRZH4Vy0JXiO299UDQPLg9a6syfI6J8sQxZjS7qnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQQXJ8PIumiqTBMzAtPSeLSzMIuThgLgxfgTbog3dAfGsyWiD
	TjI9x+oS+M0V0d1C9WZDE5n2ypbMB7vvRU8T3EPRUQt8Zcv0xFBz0HRV++5g38E=
X-Google-Smtp-Source: AGHT+IEFu0zK/9TF3cCcvEBZ0sen2jyT+GhSIm6vpUBEVskQof02UdUG/LGmK+X/rDmb1iKrzkMzDg==
X-Received: by 2002:a05:6512:b92:b0:539:f922:bd4e with SMTP id 2adb3069b0e04-53a15219231mr3301905e87.23.1729343753896;
        Sat, 19 Oct 2024 06:15:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b90b5sm533532e87.88.2024.10.19.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:15:52 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:15:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH RFC 04/14] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
Message-ID: <bg66uzc7i7bsounvl3vrhweiwbtvsomrt4tfkpojd63zd2ynrn@2pk4pypken5g>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-4-f1f3ca1d88e5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019-msm8917-v1-4-f1f3ca1d88e5@mainlining.org>

On Sat, Oct 19, 2024 at 01:50:41PM +0200, Barnabás Czémán wrote:
> The PM8937 provides 4 MPPs.
> Add a compatible to support them.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

