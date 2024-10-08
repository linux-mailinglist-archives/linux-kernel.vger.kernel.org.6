Return-Path: <linux-kernel+bounces-354458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE4993DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A38028609D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB86A332;
	Tue,  8 Oct 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJ+rsFaC"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C51DA5F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359695; cv=none; b=Q4Ik1+wWPw4jiAiYSA+UK2xpzMW95mxEMvGE4VQAGrdzz+c3AANua7MsW10hAJzduEbHQXyQDEIak70THcraRQKnmSkx4+LV3VLkJJ85mWWo9Zc2sVcJinGLnpnJgxsK24siqKX2cCGzsRuwGW0CN3cw68gXhU3T1vUdCiea0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359695; c=relaxed/simple;
	bh=0PEz/jKn+ajaev1oPF/rydjqwjCUZFH3xAdB5Z4Nyus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH5El0uOrXPJSzY8z3QThwWNjiGq87ian1ghWV9sRKLNYSii7ontXszyPNJkeaQwgydUMl1dP0cTnHAIvUo53RHMCafRJhYg4EnjQcxnrEdBpFpUVQUnquRS8mEmUwrAvtXvZy8JUkBJsyk/Zb846FyJOiZjEHZUlb+zW7H03t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJ+rsFaC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so6231746e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 20:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728359692; x=1728964492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nRlKhfifvIAB/EJfaeexHmlwHrMNdL1n0epQWySoAw=;
        b=kJ+rsFaCT2Ws6hP48NKutfrw9ZkTtbyt5Z1voJw/HDHNxVoHAliwm8gfH/0YQKtUZK
         90TYp/5lBKIUQT1wPpO7TAqGFUZAT2MpLuX1ZPz9ou1HqDOYhDwF16lRid+IIynHrR2Y
         7c+/iY/2FzDJOadFmyfD6Vk04TwjJEYyVVP6NMzcafTdqH7iYtF2WohkEyo/xrhioUJP
         VI1u0EED+UpCsQBj2dJPj0PVNuXahOyYjxs7pU7f5YSo/7lyXHP70hR5oL5YEBsXWCfw
         knoFUF2K86L5tdybg39PxTlAsGzMZ3Kkp/Pw3rSYH2+tEzNsa/t5GyB69b6x/lOGPa+M
         Ulow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728359692; x=1728964492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nRlKhfifvIAB/EJfaeexHmlwHrMNdL1n0epQWySoAw=;
        b=JaRAVi7Bk6gF+ORj79YovZaJQwYglBQm/Kl+udeF8acCCApdC/MyM8lXDnNF/fbFpz
         DHsDOIj2vcqlsG4MGORSktT+J/rR1/um/mcLj6KzBBHSPPwTIYQOWB1LEAWKe1TzLZbp
         6j8DIVg2cV5y6u/ZDY6ZXv7jyo5VYjmBTYAUMDZxZB7fA8+itpybVuUChrTmBWSaG3Lc
         Q8hS7FYHRIeaMcEIr2Da++TlSeudkRqVPAtknFadSH4Hu2ckztB+j3DOtzG6gh+/ITpF
         iepjCDwZa3N/jCmADtGBE5rIwbN7ymdO9/nNABzA+MQjRtk4HHP9LIra9IbNeIpw+TQo
         mhxA==
X-Forwarded-Encrypted: i=1; AJvYcCVeAZg+PJ7MA9mzMRKt3Il9X3f8uCPjkK7wwDXY3Q0gOXe9AMdfXURCiE9g070DHL5obSO4q91PCYRNN2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zyeRTk2RqAz2G6W0LotjbL5OnYZfgvCZcKSMazKTlnR0tBKc
	7XsziNt+U+ivaL5ME9X2mCjh2svrSr5IzSW3K0yHmfsrNQyWzlHjr31S+0WJ7ps=
X-Google-Smtp-Source: AGHT+IHDWk7UdKuI7fw/ojRtA1FqJ5kejz4LsVPchGMjwgdp5uzqO/I2uyEm/3MjlHKDLSPXOv04xg==
X-Received: by 2002:a05:6512:3085:b0:539:8a9a:4e56 with SMTP id 2adb3069b0e04-539ab8c6fb8mr7233324e87.53.1728359691813;
        Mon, 07 Oct 2024 20:54:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec12d2sm1057846e87.15.2024.10.07.20.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:54:50 -0700 (PDT)
Date: Tue, 8 Oct 2024 06:54:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, 
	"open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rpmsg: glink: use only lower 16-bits of param2 for
 CMD_OPEN name length
Message-ID: <orvsvjg75lb3kzns3cnq7um2n6sjv4hj3grtnbrpvi4sbk2hnk@g7t7zqpmftov>
References: <20241007235935.6216-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007235935.6216-1-jonathan@marek.ca>

On Mon, Oct 07, 2024 at 07:59:35PM GMT, Jonathan Marek wrote:
> The name len field of the CMD_OPEN packet is only 16-bits and the upper
> 16-bits of "param2" are a different "prio" field, which can be nonzero in
> certain situations, and CMD_OPEN packets can be unexpectedly dropped
> because of this.
> 
> Fix this by masking out the upper 16 bits of param2.
> 
> Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

