Return-Path: <linux-kernel+bounces-175791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5628C2513
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17EA1F25A03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE299127E0D;
	Fri, 10 May 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8uMkKM3"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BF7BB17
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345402; cv=none; b=OIUCWl+u9gd5iq273CsyHznnnnGsW+stlzWHLAxtV8zp3QbiCg05MtB0hamPvT6+yLSuSuGdlRyD3w4GRNiQcLuwa6SxrJiPDRyHuGcwM8XqrqZpZ/+lWGDH9Y1Xd3PkS0s1Btb3QZfHVXtfkSEYa9ugvk1Q4Ug6B6iscSgB4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345402; c=relaxed/simple;
	bh=e8oYhO8gpIXlkw2NTCH4PCGRI63BGYDQZ+LoX+zEZoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/G6l6K6gFtSZTvLXsuaLXU/RC+z1Zf/UWcrOwUVS4MQ1urFTo8YN9FCNwd9FUIw03xV0yWTwCjR78rEa+tL0V8H6KcJdFVFu6EI4MfjPBtTrsVCpoKJsY7fIS3fo0HBWxOFGYkInxP5huks2QqB7dCLaJ/fixqmOO+Jq8M9oqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8uMkKM3; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-41fd5dc0508so11601445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345397; x=1715950197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGh1C5y3FLEijiqD4sM17A/yGAQ20EDxp/D2IyXBR8o=;
        b=F8uMkKM3StAvUVv/zAgU0Zs/KiSTRl4+AXJkopLxasPYpuXBOAnKbJXg8SA5o1eowq
         Gbf3f1YKK4Z2AxS1w2PPEe43G1bNncOCDk9ZQlCfjeY+FVQ/3Vh5sl/fAnfKDxqNFtkA
         CNQ/L5kOGV4KYFKp4tA8q7PxM4cMgcEcE6VN33JpF5+oQL9uIvUgCF6xWMJLqXbFfhl5
         mPCcj4RoW3mMbm1sDNO9ok2p1T3bTBFiJ/1A66ZTYOfyYRnx1KGl8FvTnUP+Pu9NmcUj
         pZRYm4seHxgNeNGPR3s/VPo13osz0CGyowTzexWIqPTvyZwVyuewqu7yPdjMos7orG2I
         E3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345397; x=1715950197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGh1C5y3FLEijiqD4sM17A/yGAQ20EDxp/D2IyXBR8o=;
        b=uVRZJUyyewacGgSTErhQqaFIm0oDSoK+yEW02GbJN6UPj2GWHgtQdRaZ+DLc3PdWoj
         q+jy1bSEdPO3Q8YeCJgKrSIqfHG8t5DwyJA9cuwKIJ4fZu05dIBZKu4t7K8DxaBg4OyA
         gZStPlNKhrZeaGF0oanwu1+Ubig+rlFYrEht3EGALF9XXZpgGrWPo7YHaGiR4lVbK/bK
         AA1S3dBsVsY7Zu46633jLyaD2sJXTZlqAoHpkbHgaOHdCfoD5OhfLjS+vXJczkMbuKcq
         jV4+zMZo+gLCB3YvJ/r7zjr7zIsQS3k7BYyV5Kb9xXbIp3LBjVMqKMD5bUg22/YAOBO4
         2iFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1T/B3vRvypLo05+sHDFuv0ZEyFeG+1VjT7eXeA1ULIpTZxIf2PvvgcBXxv+nA0/YoXWOxNoIU4rkEs/Z9WCsKf9cK4zm+M5/jlWWy
X-Gm-Message-State: AOJu0Yw9L3ZE8SxIqjs4OghiwHonUhdc/BVAQmnwZyBWZUbwpUefsTlm
	Bovk4Dd3rCEjbT5PnT4kN6iYUOS0Wvd0fbMZBNAZR7h3CVR5Rn7DAFxS8S7iPCE=
X-Google-Smtp-Source: AGHT+IFsnS46zswqbpjJ71i4j/fP7pM80I7qhCs6nr0ajA+gbaKAJxnCuGqoRsRhUI941tuQahemjg==
X-Received: by 2002:adf:ff92:0:b0:34d:8f9c:e742 with SMTP id ffacd0b85a97d-3504a62fb49mr1871728f8f.5.1715345397278;
        Fri, 10 May 2024 05:49:57 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7748sm4499570f8f.49.2024.05.10.05.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 05:49:56 -0700 (PDT)
Message-ID: <b4dba1d5-448a-4a4b-94d5-f27c6ff0010d@linaro.org>
Date: Fri, 10 May 2024 13:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/31] Clean up thermal zone polling-delay
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2024 12:59, Konrad Dybcio wrote:
> A trivial follow-up on the changes introduced in Commit 488164006a28
> ("thermal/of: Assume polling-delay(-passive) 0 when absent").
> 
> Should probably wait until v6.9-rc1 so that the patch in question is
> in the base tree, otherwise TZs will fail to register.
> 
> FWIW, Compile-tested only (except 8280).
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: cros-qcom-dts-watchers@chromium.org
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Changes in v2:
> - Un-drop passive delays. Whether they're useful where they're enabled
>    is a topic for another patchset, as it requires examination on a case-
>    -by-case basis.
> - Better unify the style (newlines between properties)
> - Link to v1: https://lore.kernel.org/r/20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org

So perhaps you can answer the question I have.

Right now, we have non-zero delay values, doesn't this mean the thermal 
framework driver has a delay between evaluating dT/dt values per

Documentation/devicetree/bindings/thermal/thermal-zones.yaml

Your commit log implies or my reading of it is, there's no functional 
change because its currently driven by an IRQ but, is that actually _so_ 
with non-zero values in the DT?

---
bod


