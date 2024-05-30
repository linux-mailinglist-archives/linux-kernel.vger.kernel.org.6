Return-Path: <linux-kernel+bounces-196057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882748D569E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C0D1C24D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EA1862AB;
	Thu, 30 May 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUmR6IyU"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10218398A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113188; cv=none; b=LRDUgcqih+Hbtw6gOrxNS6k3CP/i+e/c0+l5z5PYhM8M+BHHz3La5l8/yw25hKSW77vcOJs3AnJEXpoyB5cAZ7eNDMpHOS/1SWHosnrp8wXYASL/WR4hG1/hiq1N3WX/e2c23khRMiU8rZoQFH97WOWEXsy3dNXIMRC/8uSq/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113188; c=relaxed/simple;
	bh=ch9JOiWMJJiOnUpYGVLTxj7kFd7UnTTTyRR8CRFU7rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK/MBYfcOF3VNMAg044t7fD8HbgMo+l1BCvZ2GkwfFYycPGSyTmspZyXEtWBYeSNK3YHEhmQJYY3j3YVyTQ8wqER8vxKhEtVK+94o3J8PqtGH7QxfBRGmc//H5TEPkvPe0G4R5iKT0gM/C/FVbJPyaDZ+uFt41q+693Ip+FD4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUmR6IyU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b7b4812f3so1361404e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717113185; x=1717717985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlJj/+/ssB3tzpOxPNXGmmF1sQcYcHLzfsgA/Q8exQs=;
        b=vUmR6IyUR+waUkrJ+VrlMdu6+gQc9NbtD9ccN1aoYCOFkGU645t8xVZ97UbcjOoS67
         QlY3tTUYRLYw/PgSyp0vW8RTUKa88CmO6+Jp6BwnfXfvKiY7FXe/eKtXcyvefPbUkwkg
         nXg2gBgFNRFo6AtNO8JZiacbC9snNcOb479H3sq6OVnXj8P1MnTHlvZin3hIk8YD/v36
         HITv5JSs0IbQds8TtU8tQAohn0FsiV1/XoQmJmqctxHewdvZBbCGT7o2t//9jAcU+Pw5
         WlE9L/vXPMW6eo1zG4Gd27hlsM/Y96bKqs7Emh1efoVWfkrQ3sSD4dEcGoWBJT6QjJWC
         mY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717113185; x=1717717985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlJj/+/ssB3tzpOxPNXGmmF1sQcYcHLzfsgA/Q8exQs=;
        b=MEn4fiRKK98fy+rYNJcKTDBfkdSGUvZj9unujmes/Ki7+MTQqMc5p4i5d7w4zxg3Om
         J61421HwUt8xQzp+3YIGSc8MQMZ5+rCegbkMH7/kNBN7pANTTmqRSGznvmumhHlUwZ0f
         rCPZTBtfH/+SBljl4iR/CT240ga9s6oUifOeatY5ItFo+hZR+w5lppaK9fxiO8GjscKp
         t7V7Zm1m7Lxjv19hN4rteCR48E9TUgoqbU5Mcxlb19XveM9dZuwhon55teza27vu+Gna
         x+hsPIhOjfzNJ2mizrGKckZyNijmuUMOgq+eO5jl+V43yzP6S/xSOyRhUAh1W/mDWevd
         1vvw==
X-Forwarded-Encrypted: i=1; AJvYcCXWox4F7z1lbq4koG+i7F3Ip/yLKlaa4dW7GiwQTFoqQDVBGdjZSEMGiqYliOsSd0UsmQy4UBZOstNNCQfxhlmFtoVAS+nI/ibYpFYA
X-Gm-Message-State: AOJu0Yxl/Q4zPbxhlcyuGJ5yIWNWaPLPTUgNpDRaiX9vfNsWIPr+uQWA
	I51+MeHf36yBeSkstWy48JAIQDaCfsoFUcfgMlk5Aes6bjmAV2S7Y6CEzf3xVuo=
X-Google-Smtp-Source: AGHT+IFj3K/ODweCD15rlhGe1SP3IwwnmKl+c3p0FovbaaNRXGZ07AuOQFeYzCXBfqCYq3scprljbg==
X-Received: by 2002:a05:6512:34d4:b0:523:7680:d07 with SMTP id 2adb3069b0e04-52b88740613mr98923e87.6.1717113184849;
        Thu, 30 May 2024 16:53:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3f3cdsm128263e87.76.2024.05.30.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:53:04 -0700 (PDT)
Date: Fri, 31 May 2024 02:53:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100-crd: Fix the PHY
 regulator for PCIe 6a
Message-ID: <tbnstgvm67iiiyet47hdtkhhkn5bpabthu2c3kf2zydddraa6t@ficbm2sy7i4s>
References: <20240530-x1e80100-dts-pcie6a-v1-0-ee17a9939ba5@linaro.org>
 <20240530-x1e80100-dts-pcie6a-v1-1-ee17a9939ba5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-x1e80100-dts-pcie6a-v1-1-ee17a9939ba5@linaro.org>

On Thu, May 30, 2024 at 06:43:39PM +0300, Abel Vesa wrote:
> The actual PHY regulator is L1d instead of L3j, so fix it accordingly.
> 
> Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

