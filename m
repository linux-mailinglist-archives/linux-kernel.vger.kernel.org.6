Return-Path: <linux-kernel+bounces-195696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA658D5066
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DC5288E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0585405FB;
	Thu, 30 May 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/U5QU7Y"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6613F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088564; cv=none; b=en1Fxt/YPEr8yvV+jrw1kaMR05/s0Uqkgztd1mTFHBRAHmZTPBDElVPDVi33WvAaFUUXBWbQMbg55WbpwDb263lG7kmwXAiL9ejqCwgAVNy1oQds1HD3PJraT9O8t0IUt9ZQH0cmjlD1FHh0M1d8FB1OErJIi+4k4glGMyp3jyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088564; c=relaxed/simple;
	bh=NdeAZFb/TEcSPW596tqV59n63pD22xeumxgqmJWgrkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGxkaYLF+QQeIVfSt5ZbrF/xyx5Y5+5CV0gE+KJZxh9KVxR1CebBkiD8oYi26weTJCm4HnMyskI9aKbczToCF81dtmOascBQ8rTOJ9UwSabSwav8XdMAdt3BBQE5oBpS2DH1Nwm20z5s6eJaxtnKBK5TXT4tNTdhXzIRVx8tqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/U5QU7Y; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e9819a6327so13234381fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717088561; x=1717693361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXYZN/m1C6PG6AKOiFq8myIP4DlpPrlE9EpwRqlB3rc=;
        b=I/U5QU7YBRAFFV1+xlZ4rHsPBF1WB5JG7G7PQ95yyFbphN6K/3HJ+cZE//1cRogBL5
         fGvhWxzSuXwoxA4eVBAau0Bh0JQG2554EmZBkroYkDFFCA7iTUcmnRRyUlRiewww/zVi
         kjrgTeTxAsed5DJjJQb8xpIePlE7eJ/Wn07CVP9Tvb0L2AoaRFnb6PxCD3jJapOjZlcm
         1dhqEHPAbH3/jntx0BfNUHIZipuWs4lHZKMy020r1eBacLvDLDW0+el/9A5k4HbQjBGt
         Oir76rXgC3DoqkFs0Ygy90lP+f3o2fDeZLynK12RNXBmIKHOPSrwEC4nonq1YAgWFv4h
         SzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088561; x=1717693361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXYZN/m1C6PG6AKOiFq8myIP4DlpPrlE9EpwRqlB3rc=;
        b=IZ3B6fAdLXQbkxllCt1NN6pYwIy5s7V+ZDGcy58+5+dwdMSJnCJHYDdP4kf+AOv8cd
         VuJwROOivHFuTT2NPfXL9BUnEonW+fG081EJvAZh+l8icjn3hpIdUis/2di7uYHTFW1X
         IXNQIwrudTKgGdKX2vkJ433Pucy4LIe48r7u8ezL3Sk7DCy91T765WW+zZcb2njT9GNG
         nnheoiD9MJUkncan+aXQ6RFe4sNi0j865tZ5WDkihTLuZZM58yMOKqa0NX/hyboLzaZx
         C5olYTm9cMKsDK48DnDccdC/JIQLYvWuElxjyzfI+7Volp4kIXaw3CcS9IZit5dT6BvK
         R5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV5Z05j5vI8RrFN/PCrca6jTb3HaRPs0zOILxzzOa5QrXJi4XN8gA1O5P8xUim7pJDxo6+8ckDhPcFHXBMRQ3dem9CG/kWcaDChBMU6
X-Gm-Message-State: AOJu0Yz60f4FqbudJVqTNT2AGubfrce4zupm2ji+1UA2SNd4YqCM0Yad
	Q0kFL+0sgRuVvFH98pnp0d1lZLRfjyJ+ZxgMwyhT4aSUi43hZCd6a0xONl4tCjg=
X-Google-Smtp-Source: AGHT+IGfsP4JlJIU3M/U8H0MbKgZB3+fSFpnjQllEv3/kyjSgbEmTlO5kxEjkv7SgLcb/drvXLwjlQ==
X-Received: by 2002:ac2:5594:0:b0:52a:1987:baf7 with SMTP id 2adb3069b0e04-52b7d428977mr1743551e87.26.1717088560648;
        Thu, 30 May 2024 10:02:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8e413sm14912e87.285.2024.05.30.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:02:40 -0700 (PDT)
Date: Thu, 30 May 2024 20:02:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 USB role switching
Message-ID: <p2k7fyqew7u72yjv64cvbzacpgh2sf2lexb3heuvls65wu7whf@34bcxd7jbqna>
References: <20240530-fp4-tcpm-v3-0-612d4bbd5e09@fairphone.com>
 <20240530-fp4-tcpm-v3-3-612d4bbd5e09@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-fp4-tcpm-v3-3-612d4bbd5e09@fairphone.com>

On Thu, May 30, 2024 at 05:05:49PM +0200, Luca Weiss wrote:
> Configure the Type-C and VBUS regulator on PM7250B and wire it up to the
> USB PHY, so that USB role and orientation switching works.
> 
> For now USB Power Delivery properties are skipped / disabled, so that
> the (presumably) bootloader-configured charger doesn't get messed with

From my understanding the no-pd, typec-power-opmode disable
PD negotiation over the USB-C. If a device gets connected to the power
supply, it will still negotiate something like 5V / 1.5A.

> and we can charge the phone with at least some amount of power.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    |  1 +
>  arch/arm64/boot/dts/qcom/sm6350.dtsi               | 50 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 58 +++++++++++++++++++++-
>  3 files changed, 108 insertions(+), 1 deletion(-)
> 

Usually the SoC changes come in a separate patch, but I won't insist on
that.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

