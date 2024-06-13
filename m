Return-Path: <linux-kernel+bounces-212733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AF906572
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925BA1C2036F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5413C8FF;
	Thu, 13 Jun 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6GWlopt"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A513C8FB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264587; cv=none; b=JFwX99Uv39l9PkNjw98lxdH8rDs9br/ExnwYKohX2C0N55WENX7aMXRds86b65NKJJiLmtIQEwRCFKe3lZUC46TMeIea+wOYig+3SnEgfOaX4/Uzyd4C+eMOH1bvafEsnHkrwAup6cZC3ucczKtn1nXFOH7Yww3G/2mZefgX6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264587; c=relaxed/simple;
	bh=Oh2VIm7LM70YX19wn1LBpKXluX+l95XGAHjH23O4UWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNYqviPtnBPFbCAVu9TzeEY4z7E6Sol6yX3tCYLPiDxlHPNVbkCgTNiaoK8nck/wwu52TJRjMIBF/TZihN0/bYojHK6bkdxLpqiiaRznnzAddhShhm6NKn+/J7ipy6Wxp5fJzFXD8HMf4Cq7TEqfaS05xwYW4t2ih+dnZtYybJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6GWlopt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so1047003e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718264584; x=1718869384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZOybXwAmI6sCFAiKuwFaCnejrVzOy82tLHhHkRl/yc=;
        b=O6GWloptzZVIlynNBd9b1HYPFeqt0Y/O+DMoS9thPxUFjzdPOUOghummvAFI+Vu70C
         w7LVh/Gjnbf2b7alzSCo09ExJwbuRmMHjcq9zHRhc7E5KKeRa/uuycxqSzjLi47b41RS
         N3p0TTeC0UFJ64bbTwuSruSuUz4cyZsXekUY7PJMbxAisLXeenuP/xBfcPdFwyMWtKiT
         1q4+1TEMCdjfqiRspbiDX5ihBOlD5fqJs8EXzTQTUF834OGqLLVB6+o1XxpYi0HMB6Cd
         XrSsBnzA60Yok6B0geWeD2hevMQnVMpzx8MiLYce5VF3i9ng00fVWBINwRVbudezgUsV
         1UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264584; x=1718869384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZOybXwAmI6sCFAiKuwFaCnejrVzOy82tLHhHkRl/yc=;
        b=HgL6I0VvgQkFB8WxyXM/a+mf6u16H3hahmS+R/glUxm15IeqhynHsBVKSlo4qA78Sj
         Q2ZkYs2u26IvkozCxOv79Xx+ZSWj+L77M+YxOXmZEjy8zJKdDXLOkh2WbV3Pcd9Pk4qF
         gCRM6pi6SXz5bneG01ZQeIGEH4mzdOSqHc4Cg0mYNfLn1r7mfjNYw9IXssGu9zLgoGgF
         o0tpScaEaW1sUe3Vs0nD+nBtneUaVtVLbQxgwJjq/6yCwnFxc/YLj68noN3WeedQJQN2
         eIF4MPiUKwsD77QhOTotkqxJuk0V6nW29tS9Q8OeTSZvGAOVms+EoRnvLxP+OmN/yfgF
         u/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWBGrl4qu19A0PUM8VQnGi//mAVQc25RiZz1cc+LLua3fDHHPc7Ii26rRTYv0/8Lqw/dnwlx/PQljUd1C44KN90kHyaLAQO35FZiAA
X-Gm-Message-State: AOJu0YwBhxW9/k7Ah6QcIO+Ttbg3csbhVKrsIZFr8y3JlarQsmuSELWl
	3m/Ayns6JZjlP8eyGrw5yhxP9zALXD03Q35+oBZCNqHOSvDFBM/HBVVioJP9ZF0=
X-Google-Smtp-Source: AGHT+IFe/gSwHRfx1q7ZYMPUTWA0VfmkZpZ1Y1lZIoSjnPH4fuB+TI++MzvmI2FSLoRbqfPZzNXVvQ==
X-Received: by 2002:a19:7513:0:b0:52b:c14d:733c with SMTP id 2adb3069b0e04-52c9a406a18mr1685954e87.68.1718264584176;
        Thu, 13 Jun 2024 00:43:04 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:c71b:4253:8a9f:c478? ([2a00:f41:900a:a4b1:c71b:4253:8a9f:c478])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28723a4sm113108e87.145.2024.06.13.00.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 00:43:03 -0700 (PDT)
Message-ID: <10fd543e-7b3b-48ef-9a09-acf8d17662a1@linaro.org>
Date: Thu, 13 Jun 2024 09:43:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: fix WCD audio codec
 TX port mapping
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 16:25, Krzysztof Kozlowski wrote:
> Starting with the LPASS v11 (SM8550 also X1E80100), there is an
> additional output port on SWR2 Soundwire instance, thus WCD9385 audio
> codec TX port mapping should be shifted by one.  This is a necessary fix
> for proper audio recording via analogue microphones connected to WCD9385
> codec (e.g. headset AMIC2).
> 
> Fixes: 229c9ce0fd11 ("arm64: dts: qcom: x1e80100-crd: add WCD9385 Audio Codec")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

