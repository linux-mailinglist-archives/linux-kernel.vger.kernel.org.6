Return-Path: <linux-kernel+bounces-189526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759F8CF13C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD3DB20E74
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AB1128808;
	Sat, 25 May 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf3yvl00"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6B127B6A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667936; cv=none; b=JWjhjCd71jA+ANHb+ZaVQihVZQryPAm7gxIBbkQhrb0uj+WRBssSrA3rS8iZOJOBrdacdX3A5DNbT7FH5cbebo4/WsxYDSQuOr5M6QrOPjhZcTBkHYakji/5BesM1m3YneqZnNCac+uiFQvEVPI45eD359JxmNP+9K0ODQoW8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667936; c=relaxed/simple;
	bh=GCkb8VpIK5yTvW6Od6UzlY1UVmtUIlmab/m5x0kcX9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPhzJGL7g3yxuuSYoAtvWki+Wbj+8jfznUiOoBKteMlQ6aBYnGT5LPnPsY4H1r1x3+fThRMNmtmvfS2bycGRxxcRGDH6NHmmnVsxNO62a5zmjDlql8Fsrrq83gt+M6IZXoeQ9niYGv4wCte5aHCRnvfeOK6a+I47X9V/EcB1p3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf3yvl00; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95b03e0d6so17713651fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716667932; x=1717272732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sADZzhExqTF5ighoBfS1sBeZMakfeGbASWxc2TzHoV0=;
        b=Pf3yvl00sbQrkElgHBymzGSyGGuvWruUozP/hi7jeM2+QSrtdpECV/9qSn3CDj+JU1
         Qek3LUvGeokt1HVp2UQsTpCypaefVM9xDReyFz0KC50aevaPdYWvsm4fAB5PrMgXfxzu
         YVgHYdb2NI9/XtKB8ohKl9/dOtDbAZn+LXZ/B4AzuDSCxVm4LgpVLCcB1ACCml3QDbMa
         hKiqmbM5RzZtBMJgyqbOYkELQGgQrkh1YU89uDerWLwqhtri8ySWngRV2Jyyd5Iq7xdq
         8PdgQs0vlrTqZHL7PNfoNc/vIJX7YUzH9uZwmTEsyBQRmplr7Lx5QpNKULEHtLLH6h/p
         WIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716667932; x=1717272732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sADZzhExqTF5ighoBfS1sBeZMakfeGbASWxc2TzHoV0=;
        b=FI1vLIgGBTgPC2JPAISE3T/Uwy+rLh0gl0syJPnb0BvcZIt4CVVVz2aatAI8BXW2Kh
         SwNw37XaEVVOmnrGOaPmzD3rgFXhvdkkFrbEbmOQ3WPgndNPw0sI6glXP72oUjg793zz
         p1btgpUuXRgRe+n+kF+suJ+h4iwGY0WfrvHbC47uqkxSxEdHewEpWwjBouwc8gcd7AIv
         au/l8kA2BiYOgiAndbshJhVsHPV3GwlhF0Yx9FGuBLFTQIWu2MXzZQdLSNsZDhEWV0yi
         WvOchCB+MK5BeDWakZNYRQ4T0kZKBsMWgllZG6PsjfY/Cl+MxXsP8pcGH7EuZMsjNfa5
         ZzGg==
X-Forwarded-Encrypted: i=1; AJvYcCUdIZnZLJJ8tlkcLGrhBc56vBmK2Nx4CTb7n14NTlPWxLi2eTRzC6y0juGctLhmJssLSrlIGollYWdEhwxGW4BGUHOueBsyQWhI7EfN
X-Gm-Message-State: AOJu0Yz7uRwmpcdixXZvearQmDTh39nVln9pC78MdzoZO6Emc6H8n3XI
	u0F7I0fLcHdTiyoZRRhaRB6NUy8T0GxUL3/gaylXvnlB5E2xmvxhBX81lN1TNVI=
X-Google-Smtp-Source: AGHT+IFqhwDDv3N63doOvlPH07F4vAQD70/YFm2+cAidzJLN6LyukrPD1Qf58Yu1YCc6YnzMrtc47g==
X-Received: by 2002:a2e:2e19:0:b0:2e6:a1c4:4328 with SMTP id 38308e7fff4ca-2e95a104423mr16964041fa.22.1716667931997;
        Sat, 25 May 2024 13:12:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd7bbcsm8824091fa.32.2024.05.25.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 13:12:11 -0700 (PDT)
Date: Sat, 25 May 2024 23:12:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix aoss_qmp node
Message-ID: <bd4cklk6dh7n7fparardg7kii5xm6vijibw2442ogfoisvzjdh@srpclqicd4ju>
References: <20240525-sc8180x-aop-validation-fix-v1-1-66cfa3c9ccf6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-aop-validation-fix-v1-1-66cfa3c9ccf6@quicinc.com>

On Sat, May 25, 2024 at 10:54:07AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The #power-domains property is no longer accepted according to the AOSS
> QMP binding, drop it from the node.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

