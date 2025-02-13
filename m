Return-Path: <linux-kernel+bounces-513531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3839A34B47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B987165B50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473E1FF7B9;
	Thu, 13 Feb 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si/Ctduw"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F619AD93
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466043; cv=none; b=qToBOC1DCu7/Stst++BD/IVIOnfa0TM34rEyjk1OhfoDrSv6lsHLR+QOw2qlSLQfhAobUNAMQecXYWfRGx9hoLIEL7qys26NAQOoY6DUNFERXYgp0X7Y6S3T8qEgSHVxZV5GyDzhuU8i8m8NXeYpWxVKISVF1n1DiCfEgi0W0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466043; c=relaxed/simple;
	bh=zmrS0xInz7ZPMUNPbz50a5drJQVT6ULUv+bzAYPXgk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujcxs5Budq7oT9w7Ke+1WOYEiTcOSsLP8cREUCUF8dPY/rEhqTUeXhAObxxMSuWqrH9ufVe4hzSQX1V0UMwyb1nugLPN+S3Cc5CBQskyIeXMp4C+5JfHiMEFI252JgeNQC2H7u7viWDpN2PbjQyJlDWVaYciRpEZQp/8KVC+kOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Si/Ctduw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307c13298eeso11132661fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739466040; x=1740070840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UZNM2cfJDvWcZt1Er+PnBNRIi/F3g3nkljefPZmTuQ=;
        b=Si/CtduwsftKKkyi4Tc7D+f13nEYGhj+mj8tcD4oK/vbczAm2L9R/AzIFuhDr3VywJ
         9dNO4vyekO1OfgEvvuiqEKbEQMsYx8/RlcKUZVOdXZBliX0FibDO1F7C/59LyaKlcCwS
         XNJl0Uevqzb6zOgmiiC6cZevOc1oiT5zLQyDbWK0afHgrAyBPhGoOzIXMl5jQijuIrsy
         +7Hw3pZURMqqAzcT3K8aajjZM4ewnjWhWrTGTNU+bb0acOQGW87wiCHf0VU6AViyfbMH
         1GFQu/vibqQmhruem1WxaVYagX1U5xAVawytRt7N2d3KjgcarHWDgLiYYyDqZc/DjLZO
         3wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466040; x=1740070840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UZNM2cfJDvWcZt1Er+PnBNRIi/F3g3nkljefPZmTuQ=;
        b=LO+Rx5uG1AbEbGZHghRV6En6Mvu//WNjZZCunSO5bKHbIQxinD60Y0DGpn/fIbgI2Q
         SMBP0F0Sykp8xjNYfRXL2v2Kq/vk3Ch4Vk662rIAaXVv2kr10fpU0jMRtiTopdwPjMjR
         f9/5bivEiGcHwU7bk+wU8v6Lebswwn8BL8DazvDtf942i34pjhf7edEpLeInJsa1nvCB
         J1Wx99MzRQtCs4GxyZjd6byaAzrp/xH2OJR8I9unPtohYkbtcfh4hNa3aV3b3FgQtil8
         1zSX/r1GlZuKcHqyRwdzg3sAQMIGUArgIBzu4aKQzMmu0hB8DBFaMooPnCZh5xkd1G2H
         MyPA==
X-Forwarded-Encrypted: i=1; AJvYcCXSjUx7+7Ns2fg72iI1pZPrc1rKmZ4xpkkNx7kOdG2zHk7xCX7rrxY4bw/idFnn3xgd3Cl4dtZhkskLXE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGR9dOmpOhP9SJJiWJ3y777xv6Q1aXu4xNn0za1oeKYXutyvA
	bOkUp6dJfvVJ4wnapGVqJu6aNdD56vpdJaHQXH0Wtf4hFep2Z5ocTeY8Ap1wYmc=
X-Gm-Gg: ASbGncsntVqdboqVNTijE+LA6QcRnARg26s1B6VfmebwxV+AUGoCtgWwC/DCyiviyUU
	w28PrTibjyoOSeBUWFNLkrIvE6B/RTTs2Hptlo3KVh7PW9QGEsX3KRdR3uOjl1GoZPA25fL5RPJ
	MgAnmIB1cUP8/QiO1l8/k4n4K7S7FXYhB9BuIcxiIct1j7FbHozX3EUbxxToZJCwBtttElot5nj
	TWyUqaT3YCvatUe4DlqGJCj6BqgprDcMaXBgeqJOwBDHns3PH3jEoqVN0+4kKi5UgVDqO6oGNOC
	CsOxmvgt7UB+Wth7HJs/bXEyjeWWZcpUmAK85MQ+Lu+LuZ5Y8sBMsOk8uTHisL4kBDrSMh8=
X-Google-Smtp-Source: AGHT+IFxfLzjVADe+NQ9hyecFQjlri4ibXGiH0NU1miK6ClkLcEickWMwRLitIzMvkrGViP4aYFupQ==
X-Received: by 2002:a2e:8887:0:b0:300:17a3:7af9 with SMTP id 38308e7fff4ca-3090f3bee24mr11613931fa.19.1739466039832;
        Thu, 13 Feb 2025 09:00:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091029b835sm2457111fa.100.2025.02.13.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:00:38 -0800 (PST)
Date: Thu, 13 Feb 2025 19:00:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sm8650: add missing cpu-cfg
 interconnect path in the mdss node
Message-ID: <7mojw3jf5skm4esa3xquthkpwez52u5fnbvyqj7g7hdjgsz5dz@ewfsb36sa7tx>
References: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
 <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-4-3fa0bc42dd38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-4-3fa0bc42dd38@linaro.org>

On Thu, Feb 13, 2025 at 05:27:59PM +0100, Neil Armstrong wrote:
> The bindings requires the mdp0-mem and the cpu-cfg interconnect path,
> add the missing cpu-cfg path to fix the dtbs check error.

Same comment. Nevertheless

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Fixes: 9fa33cbca3d2 ("arm64: dts: qcom: sm8650: correct MDSS interconnects")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry

