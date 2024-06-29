Return-Path: <linux-kernel+bounces-234921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7591CC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC1EB21E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED074C09;
	Sat, 29 Jun 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQvilf/n"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056373455
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719662018; cv=none; b=S3sjE3OgIacA/sxr0nK3svOy7TktXKZs4eCARmIPkDLRaqXz4a8is2IeGzQYte53wF17BXf/7OrGTU03etdAy1lXqmb5vqOY3+uyTRQNHg0jqiT7MIfyUV0V550pZ2GaP2JgXBOXhQ1p0b907L9ENrpa3Rsx2kUIvizRMuYeVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719662018; c=relaxed/simple;
	bh=UbW5VL7aSa1hgKnV9lDs4v940Pz0n7ElVXgY/D4jBAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxjGAbMsX02g+28RGv7OfW/Uzf0E43Jt5eKGeRbj5/Z94ZkZV0ZD/OJx4m0l3z+53MymW/aisEw+CceczN9/D3UL5bUYh7Agguams8jv9BUt9YP/ic8wmQX6k4zv8ZfzWx+Lx36cVkCa52U8kURlRLQDcdz7koqkkqyDtaTxOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQvilf/n; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cd717ec07so1818266e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719662015; x=1720266815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ATHMh5/H1vZRHirTenpuAs/sN2H2934t5NqxWY6ds4=;
        b=FQvilf/ndhqn7bnF3Sc+iOzAXgP04tV/fUdxQPG6CwK0ZR4FIZm4pNKEv/H0v/jKoN
         /RcWy1OJ5Eq9A7he2UyiKnM8bzFVtN0dFOR9enooqyUzD2NESxqtBg3NKkl+aNC9lePv
         /D7YNSeW2jfvR+XVfDSZBrn8mzmTcJJ2LM2kRlKWP5j5z12r0uiQoke2KSKvqmKI2bKE
         Ks2BfKVub9f1reUwtl+4ZzL7JXgykl3YuP5UKCQKWEZoewEKDOPWcKUKZ7Qzkx4CTDd3
         sfEMskOiKzuRPfV+J0EffSNiiwhp4XOnyBP+TeqgD3DZ7yLG+tqUYiVKnfZYizQ9s51t
         Z7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719662015; x=1720266815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ATHMh5/H1vZRHirTenpuAs/sN2H2934t5NqxWY6ds4=;
        b=jsJOTevRbVTyING3ZqnFGUZK3ClJ2ODv0K8SRonu/kx0FDQccjqiexoiTpoEZSR8eE
         7o/3YB8Uvaag02+iiH2/pqcdQi+3O7EAXGz6+ZSuveBExRlW0k9u9wD1EltJwaglming
         8cUX6nTGc2hKbK9LUyKlsqfs0mlbP+nVO85A5kjfmKnP115MoVu/Bv7GnKdjKS2YYr6r
         hlV3fdPSZb78oVuD3wj3j/RONmpEGE+vlIHZus1FXmioDRLEwHQkOMjd1nqcxIDl3LKc
         YPrKBW4FDICZr56R9RpfIzT0DgRnF1S/DQb078nCkV2BHhHsS/5P/dTQKQKdb+/ycNCt
         AJEA==
X-Forwarded-Encrypted: i=1; AJvYcCW5+DKr66bGxwIqfQGnPm/HsgEH24ZzFOsRPLajcYBWlz3sudkdkVP6Gh3WccC0nKjSpMDamlnb0tTpDLwYDi5pZyjwiZgnUE+NNrQn
X-Gm-Message-State: AOJu0Yyq2bWEmyJc3eBjk4u05vZW5zvaw66ondcv+wqb3Lg/fKg/iTZd
	vZJueAj5AoHzvGR5Bwg+fx+7tsONtxD8zONl/+bEBtP9pXAaSreWMxdj5BJNJOs=
X-Google-Smtp-Source: AGHT+IHKoL94pLcsMI7QP+3lZDqkLV7sHYZhKQLx78VMLc+Pq1ZBED67zoxq06OAHmRWOXzc9VSZag==
X-Received: by 2002:a05:6512:39ca:b0:52c:cd0b:f0a9 with SMTP id 2adb3069b0e04-52e8274ffc9mr670858e87.58.1719662014897;
        Sat, 29 Jun 2024 04:53:34 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc412sm4751177f8f.70.2024.06.29.04.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 04:53:34 -0700 (PDT)
Message-ID: <da278419-f8dd-4f8a-a8e9-06ffbbe3fbe7@linaro.org>
Date: Sat, 29 Jun 2024 12:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sc7280: Add support for camss
To: Vikram Sharma <quic_vikramsa@quicinc.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kapatrala Syed <akapatra@quicinc.com>,
 Hariram Purushothaman <hariramp@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, Suresh Vankadara <quic_svankada@quicinc.com>,
 Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
References: <20240629-camss_first_post_linux_next-v1-0-bc798edabc3a@quicinc.com>
 <20240629-camss_first_post_linux_next-v1-2-bc798edabc3a@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240629-camss_first_post_linux_next-v1-2-bc798edabc3a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/06/2024 19:32, Vikram Sharma wrote:
> +			reg = <0x0 0x0acaf000 0x0 0x5200>,
> +			      <0x0 0x0acb6000 0x0 0x5200>,
> +			      <0x0 0x0acbd000 0x0 0x5200>,
> +			      <0x0 0x0acc4000 0x0 0x5000>,
> +			      <0x0 0x0accb000 0x0 0x5000>,
> +			      <0x0 0x0ace0000 0x0 0x2000>,
> +			      <0x0 0x0ace2000 0x0 0x2000>,
> +			      <0x0 0x0ace4000 0x0 0x2000>,
> +			      <0x0 0x0ace6000 0x0 0x2000>,
> +			      <0x0 0x0ace8000 0x0 0x2000>;
> +
> +			reg-names = "vfe0",
> +				    "vfe1",
> +				    "vfe2",
> +				    "vfe_lite0",
> +				    "vfe_lite1",
> +				    "csiphy0",
> +				    "csiphy1",
> +				    "csiphy2",
> +				    "csiphy3",
> +				    "csiphy4";

Per my comment in the last patch for this series.

In V2 we should see csid and csid_lite registers defined in the dts and 
yaml, with the offset enabling code being dropped as a result.

---
bod

