Return-Path: <linux-kernel+bounces-198265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19F8D75CD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC401282659
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09513FBA4;
	Sun,  2 Jun 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXR6BTbH"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C63AC1F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336185; cv=none; b=LJCji/PM2IFI/eMMLC2pPjzcHuXcwvlV8HhFoWpyKHhlKOtMPw0E4SwI4ZPbsC+bibDrOg9cw98ctA3w/j6HBqi0uPPYg1iF6oEKpVJRiD6prZSS4EE11KPwUVo2Cwkg08qqj129WSWj/DUZ3xrYJCOkFMesOi8wAE//BN6/qgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336185; c=relaxed/simple;
	bh=OFBLy/93aDcasO+7L2Af/xULO+GOP6Ah177EDibhun0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=newb32TAj7GeYQ2d9RYzbzoJtl9Q4X8/VRG2Z3gFkv/DhHuMvfArm2mVuH4Pcmn9/Ya3iCTnLqcomsJUjWLv/VNHn0NibjhLMLbMtXU+09mW7UL4Rcp2JUwOUiZmPLngdSd1Sicid60w+FX4XacvBCq3Wtk9oa1YJk44UfMrd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXR6BTbH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b82d57963so3352485e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717336180; x=1717940980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RK+gSspnDvIjQ8g7XKh+hwU9n45tiCyCGsEgB2oOglo=;
        b=LXR6BTbHkE/GeQ+iE/7+lWWLaUBANMlELk2e8im2xKHxF/7032gWxpWpvWS1jAUaOs
         +LLADlmTl/n/uAKsAk5V6AfL9GGI0rEL2htjnDmoRac2pRxucAsx7rn2FITgu1qXLHkZ
         ydzR7dyMWCa5S95WE24E2Uijk4BsdONj1Axc4COCna3k1MFVwfMWF9bDzJWUUP+dRuPo
         oGcNHrLtL5EzvPiz6kWnvD4h7lMoXWTZLxlAwO9mQJtplnpTcbO1yFQ17VqCoAcKqk5V
         dZFDFchgbzL5iBR+d8dFq2UpDZ2a0zPsPt12ZP7/cWR5b4mzEFnm41CZhgY1n3CLMDro
         vGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717336180; x=1717940980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK+gSspnDvIjQ8g7XKh+hwU9n45tiCyCGsEgB2oOglo=;
        b=aSTXr9r+SL4g9E/RUcX7P9W+4F+aeRMIiJJeNboNo19/1ARvzpKnyfNln5gc5eb3Cq
         MbsX9IYPNJZGMo1d3Jg+3IK81ooI1z19+uWmNNjzDe5F43FEp3J3OpH2vcNVHopTPtre
         ymJ7i/w40i53KFIAByqk6MmFeSnXxbUCkIm69MCzsIM9t8DhzQ31TUjWeLeBaZBI62G1
         BbjI4wEP/X2Jp/dvJYabT9sfDpMvSQVsWsqXxw2sozsNNe8nMFfB+M5kMAP93fRPCudP
         wxYTPDEc6MFum+Cm4f/AT435G53w546Espc1nyTcmaugvMH3o8VSZdwlxFkETO1q6b72
         6GdA==
X-Forwarded-Encrypted: i=1; AJvYcCVgwYIUqeJ95kGGOc4kBKmVzObOMVwSCsG1Cb3nyEU+Ixaqut+uvXm3s2QF3KwxOEZCYX3SYQuiLl4V/d4zq/U7w81YQo6kUSfwNKj0
X-Gm-Message-State: AOJu0Yz4KN9lwn1JOGGzVqi/y57J5FoTMEHWnwC0W9dm/9EmrbRKYgmb
	nESAxVneJJjjI8xSvBoluCJvD4EtAIT5FkHmoJyedx3nGRYhw3TjDyb8ZlVW5GE=
X-Google-Smtp-Source: AGHT+IFHtYW/9mmf4mBFaBwKb2/rlrKnB1nEhfK0SBxsg0mk+z6IYwfe5eM8PmYnq+8HBzEZeU9iBA==
X-Received: by 2002:ac2:4246:0:b0:521:6c38:6949 with SMTP id 2adb3069b0e04-52b896dab8cmr4494872e87.45.1717336180547;
        Sun, 02 Jun 2024 06:49:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8e557sm956327e87.297.2024.06.02.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 06:49:39 -0700 (PDT)
Date: Sun, 2 Jun 2024 16:49:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH V4 8/8] arm64: dts: qcom: sm8650: Add video and camera
 clock controllers
Message-ID: <fxh3urdpdugkdgqureddxurgusqrexomi2v4h77enm5ncvoa52@nkh2p7e6dsto>
References: <20240602114439.1611-1-quic_jkona@quicinc.com>
 <20240602114439.1611-9-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602114439.1611-9-quic_jkona@quicinc.com>

On Sun, Jun 02, 2024 at 05:14:39PM +0530, Jagadeesh Kona wrote:
> Add device nodes for video and camera clock controllers on Qualcomm
> SM8650 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

