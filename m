Return-Path: <linux-kernel+bounces-431041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794B9E386D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D55161E46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602971B21B9;
	Wed,  4 Dec 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NH5lT/dO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089011B218D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310496; cv=none; b=HZrWFeSB+qdAfub3aQWd2DavtElkWHf3r9xLNNpSEhwa5idVJ52HbLVuJ3Al/6nl2N1LI2JRjvAUckBrBwEVGQu8vhz44kAQx2Ad4r8qvif6XXO/o0JMUkf8OJxA4Oz6+RlGEVnTPju/uOjBDXHs9B1gYvHdqplROGOL8Zz862o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310496; c=relaxed/simple;
	bh=+RY6ohi9sFPlxkhpxwJXOS/UxS/f9iEvJNG9RSPIfkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5GN03l4srCp5rjUsuQWK1+H6IIZY4BNwtfUQFb/jgWyHDsvcDSUh8+JVBRvahCEvhMJjGaPEEH29y78oqDtLKAXphC3LJCY5RGy0UHRG+KfPvOlXvVbV9bM7bYgO38uqJgDLSxPDDHvsX/dPbJrDJ/CrFloK5vgmS2Jdn8ntXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NH5lT/dO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de852a287so7318570e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310493; x=1733915293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYzXxKS9pvS6m9YWg7f10P9BUeef0GzPwC4VorO/deo=;
        b=NH5lT/dOKvi5ckfHYGJ1XqYv7R4uMwQBtmJ2mNwzG5f+x4dxpKE+6zBNLfcWCReo3J
         r5ehmIqxGL/xKgIrhwtPskZ71S8doVO++UH0rCdCs4ZdAnXWsGXrQrsC9IdXHfelgVM0
         hJpgJ3vRF0wRY87QXMo8KARMOaZSgCVHaXICXQoVQQUWxOYHOjW7xjDtlVKVXbaPz+sr
         F27oKZ2ngNWzOf/vyU3QiKirhwKeUX2p9Mt0uYrix3Es7En6C1s6vWrfaEcNNUrO+T5h
         is+sLRERCjy5HMD/LdAx5YLaGjXRtbsTlJyqfzLEQk8WcZlCCuiraODsQTCD/qc7NM3s
         aY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310493; x=1733915293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYzXxKS9pvS6m9YWg7f10P9BUeef0GzPwC4VorO/deo=;
        b=Lm/emURQTh4UrRpviskuvR9G90EashlEzzGfLcvXK1nuRykdEw3SEFBGwITUWrhU6n
         8YKyKSGZEwciUVsMHF2dMfRucbriEdgWGW3mRDTivR2yWue19yOCeUZSLsUeRebkGhD9
         AOOWkzD2waFKSdU4UNOkekLA7kcy+lf2CLCcu/MTua0wRDHMRwl7aNVr2Afx+8jefZsd
         pRzitsG3BeovbRP6WkXVuRyPVp27rtHvmX26c6xUusAjZoVC/p65FVxklX6YgSroUtAa
         XGSEIHLpOKmGjE0AtbHolh0F4MHdMuozu99bFPCN2m9tAusEMK99IRAmBE3KgQd30kr+
         MUBg==
X-Forwarded-Encrypted: i=1; AJvYcCW83+3GhHDz+fB1MwKwdSsIcpS+eAalHUnv8J0nENBv5JBzKN10qRNTGKBmgrUGWUEOvyz2KQZj+Scwn0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XGOknw5Pu9ZJL2K8sS8pxFDMueMHEwFeQMyb9KocgArCx2Md
	mpX0lgFCOe94CSGw18ASwSC7WbTjOLmQg1nyKCX8Ag1Nbg5ABCqKVvvdp/1QqLA=
X-Gm-Gg: ASbGnctsCda+bPJsWg0OnZ9a7ioyKHFDX2hF9ngyNZ6Okm5g2tfVNKP+Y0StU6JYFha
	PjIhc/i/G6srZBLyEGoBK5wiAjSaaln1fEVubJ5/EaQV37RcPy5YYuImtz38MjPazPobhPJYPN0
	mTqC12KQ/MvLVEX+B07Na/OCb5qTKuuRxXBW2yLrhZ/XTewYGidoF7SWCWVt2d58U58kpAXPOiZ
	hyUDCkmuy2OeX61KWXDT9IYD/Rp7OV3iwrGcRWjr/r5PvbmwlRJ1Ym0lE/HTfiF43LFh6UUjhQL
	0NI1yUWY3+frTFtEV9Ly9A2+JOqHRg==
X-Google-Smtp-Source: AGHT+IGELuEbjRgnVDODbB41rhvdxo1vdb+kOa96jTHi0iriMuN3VSziSI0b2CaPZwJDkoAtxZYX/Q==
X-Received: by 2002:a05:6512:1107:b0:53d:d210:4060 with SMTP id 2adb3069b0e04-53e1b8c1a94mr1283260e87.53.1733310493137;
        Wed, 04 Dec 2024 03:08:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1bff42b1sm283793e87.177.2024.12.04.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:08:11 -0800 (PST)
Date: Wed, 4 Dec 2024 13:08:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc7180: fix psci power domain node
 names
Message-ID: <f7pivzwjn3wmybdm3pgue6azi2jb7afc26pj6vyyfixspumpsx@cwjrgxojcr2o>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-5-6d320b6454e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-5-6d320b6454e6@linaro.org>

On Wed, Dec 04, 2024 at 11:56:57AM +0100, Neil Armstrong wrote:
> Rename the psci power domain node names to match the bindings.
> 
> This Fixes:
> sc7180-acer-aspire1.dts: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6', 'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

