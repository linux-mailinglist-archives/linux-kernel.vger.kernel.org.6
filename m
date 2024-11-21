Return-Path: <linux-kernel+bounces-417261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6C9D51AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D6B1F21DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C580D1A01C6;
	Thu, 21 Nov 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCE6hxrE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A959198A3F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209825; cv=none; b=KLkBsaLKg8NI4jfEXj8gQ965W0b1bZ+t9zhE270Me3nBObX3RIrz7nRE5fNknDnzZ++mCCMcKk5sPz5P/Q4qTwCIfJgZa7lJYYAIHY5YJuLnWkXLfCA2gf+vRf4DXqtwEQVIw2dOYPPvtqosnqfZJkYj/3XXU9xEjBi6EgduuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209825; c=relaxed/simple;
	bh=iBNhjFCDpKRTQH2Pa9QqQQCjVzMOzhs91G1qfusImRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTAoqfzEda7Zvey+1t6QzV1ZecFLZkRX8vnq9vK492xaRtjSD+DPF7QBPYuFQH9DrYMt4iwKatvxAvuOqcn/IvipzEdkbv8eoYkNLVUCkz2CV2oWR7uVY/nNteqdkkeYgUFgdYC96WhsgIAb1szShkZgJISJtiwZbyZsu/PRA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nCE6hxrE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f8490856so1191600e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732209820; x=1732814620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bx9m0NYVTC3ArzZdszszzOV9nbuxX3SN1ILoUcGqLA=;
        b=nCE6hxrEJW4ie8c/ZuhZa5GIS/1hxxZrH+bKbAJjAc3BDDJYVnRiissYoR8D5SDZbq
         it/VywnN7lhMZ7IZiXdueCC36ezFM2jeHmekn84i9PnaxIi+2MSceJ1b6Heh50LrYNi8
         pb9awfTx0bbcGGGlaiqTvEKku2NkNW87BaC3fM4qraMjs+mELm4T8RfUtvmd2TNAJjAA
         uhtNSuN5dyjTwE8nqU0+naj3+LLfUoDVX0GwWRQIcHjYYY2JN3nOv5n6sRqPDRExNTd+
         pw2+/aKimCAH42Aw4uHZiaeUZsnrqS3LcTS5/Qss8hO43Yg/Jycd/BW4Z/fxPrIrv1nb
         oQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732209820; x=1732814620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bx9m0NYVTC3ArzZdszszzOV9nbuxX3SN1ILoUcGqLA=;
        b=naEXjo8Jwd2JwtFp+rTWi6CD6doazFAD8WzsJVnRGgqvZYw1swNXxYKXAjH+1KcRGi
         GPq+Jl0mcB15euo1izLM90tIH1uQx9ZUkx0DtFzqw3knO5+v6jQ9C/SskwL+yJe9Sxas
         EEd0M/76bVGUfmQCcP/1IJYvEUNIplc6a5UPUpJ1S7tSSRYmAmD+0VbM/YisImdQAuHD
         UGK36mOi25P51sid1BYo7ERyd/e14MRqP5mPNWq0MMoyss+x2CkA9LB7QkfhkaWytZgD
         WUuUoXlAiuaHFh6pmqN/aL/IJykJwaqXS9U9WrZ0GV3Bqh/WabDjVw1ggAqprPGNmMq9
         /IzA==
X-Forwarded-Encrypted: i=1; AJvYcCWie1yPUKeY++sncitpY/OGczEh34iu/owgqy8NWbiktF2c6L7TfWZ6enEugAoqICAGjg7nlIGKOO9xCGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6y9ZIg+S/2q60ATqy0/KlGlzLhMjLvXOIxv6fmNZgTP37dsx
	ZkbfeMiMrPuSzyO2mvsSmX9fOOnRZRYqH4DSCCpbZctbU3tBIhrKcNBTGoEo7ag=
X-Gm-Gg: ASbGnctYqDtCYdXngMRsDOlTalYUronVxww8QHdv0a71DLW5SvIXwplcFu7YSBrCTE2
	xQJRG1/jBhS+Qz1U2As19nYQ0LCSR1vnt9qns9cmkIeJ1CxNURK3sGvQ07eKCPMVViYM/HSVrhU
	RDB3jlj3tKkDJADRq1LxuTg7lC+asZR2zwDJ4XUN3AZOD9N4uR45E2O50UiQRPrcOPKj88ASIdI
	3AW0rpvYInv5E5iM5yA9X7kvgDlxiTPh+c8nRx4u8qz3mm4yFdd7a30ou0KBO3Zh8f1lQLF9F8o
	iwDgC8Szusg1ElVNVGAHweWROMSXvw==
X-Google-Smtp-Source: AGHT+IH/XSj++10aoySNlzzQLcgiL+7za6dnX0DKLcp3Sj+liy95mgnkIbfDUPV9rEtzoScDC0W0JQ==
X-Received: by 2002:ac2:4c38:0:b0:536:53a9:96d5 with SMTP id 2adb3069b0e04-53dc132df6dmr3274397e87.17.1732209820394;
        Thu, 21 Nov 2024 09:23:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497f04sm20981e87.254.2024.11.21.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:23:40 -0800 (PST)
Date: Thu, 21 Nov 2024 19:23:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable Primary USB controller
 on QCS615 Ride
Message-ID: <nt366bsajm4vci6p76qj5bdzcfyutykc5yykkifajzpqnsucwb@lpotlu2ihocc>
References: <20241121063007.2737908-1-quic_kriskura@quicinc.com>
 <20241121063007.2737908-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121063007.2737908-3-quic_kriskura@quicinc.com>

On Thu, Nov 21, 2024 at 12:00:07PM +0530, Krishna Kurapati wrote:
> Enable primary USB controller on QCS615 Ride platform. The primary USB
> controller is made "peripheral", as this is intended to be connected to
> a host for debugging use cases.
> 
> For using the controller in host mode, changing the dr_mode and adding
> appropriate pinctrl nodes to provide vbus would be sufficient.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

