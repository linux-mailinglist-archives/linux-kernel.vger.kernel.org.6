Return-Path: <linux-kernel+bounces-416419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA209D447A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649EB1F22357
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFD1C7B64;
	Wed, 20 Nov 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/Mcxkf2"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147E183CA2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732145274; cv=none; b=mINljN/20JSDp5/+qOuB/BtMCql7e4N+J1G6XepHw7gbmsAsYd/TZTPywxwlLbfRqobcIUBgT/8BN+spmzx9TvNYnntTijlhZKcumImQX9egqJBfuYVomoI7wCYPHgoun0PdghXkJ6JGCI6yJbbWODYIDcBmqpAeS2sFN5lVIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732145274; c=relaxed/simple;
	bh=R7FO0aXretlov5s1jlU4aC1Z9PHGuhQa0RZWXL48ies=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecPGtqAzsEAawKS5u6cGYzHbka6ILAcTUcsxY7BxnmdkrCovoJRsA80dG3Kn7l8JcTnUabTPGF3IMjPoGkzBycOfETdMtuVROGkQVodb3GEcX2nz9rcQgsP58Hgfs8ApgF1+bAgp50O+kxn0FP+ziweLKcbimzkGLX2KzwTA4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/Mcxkf2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382325b0508so176826f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732145271; x=1732750071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdF7i9t9y6Q2JmYr14WDMyhUqwzAt7uL91F4oFpLQD8=;
        b=X/Mcxkf2r7YISOlT4zaIivtz3AU0J6fw0uE1HczWNB5GuTQRKGZf4s+sozFPrA+qF3
         +XoZkPfpuJp9/7OZANlkQYZf6PLKG437v2IwTWS+BP3nju7i/RGzrF47NA8UroxhIfkj
         TUzjpy5DqrOsDr3f1cv6jJK2wndjdbdXMW4xlQmN7JV0OvJXVU1iNt3zfazQlVGm2Gdi
         aryOgPInEUwzfun6SbbbrhwFyP+S9KzwvTVP3sMnFEvvZSfqvIJ+J6yxLP9K0PPOM+Aj
         M4lCe4KwdMOFbBakEXKBosChPsYBkGPzLsRHNUGJ1Z33nWiHS7boTfXP5XmxYd/eLrXO
         rIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732145271; x=1732750071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdF7i9t9y6Q2JmYr14WDMyhUqwzAt7uL91F4oFpLQD8=;
        b=olmujyKLeJPsmZqmclP6VnUho+h91zi5vZDXdwPr4rPCvE33AKOd6Wa7Z9TF4e07nv
         iQZiv8vLzbzejd9tmAJB6rI8+hPy/tgGbY/qVMGOlOW54X997Hh4JnvmTL1j7iYKyOjz
         KWmNsXZ3Xau7hTVnTBtB98swP4ZvWaZVS2ByGFwkePYS+VjPSkSkN8r8o319C66l3+S3
         fpF6vDGFvLqGMKzwsLmJdt2hlrRAkWC5kNa0SP3mwfhtSJKOWqzei2UIZOohJJXl8Zt8
         IL9hwZmxUdloGnIwIJnXwWCGYe7Cr9Ylb48s/yCzHV9wJxNEORaahvUi6+SmUEpvWuIF
         k2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUtByGmuLrRREJHnPNaLZvZ7kXYWGpmpnwyXUBti/CmjBVOSC8vzc6H93UaXy9ZGGsUKx0PaJCHKIa6vng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjOOaWWDM9nxe9CT0gkGC9COZq6723JkEvy73chG2vEPDYFYv
	WeHhHQUYlAAz+O/X59lyNGKVqe6N+4lwzGLRreDemKtMuI1oc18YAzyoO/s1tcw=
X-Google-Smtp-Source: AGHT+IEfLUUlagqKYooznfNavSLOyyt8Ol8BKvDgl4qFGK4oImPluKpMPaOxoqZdYaZhgp6PBDcZ1Q==
X-Received: by 2002:a05:6000:154e:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-38254a83f8fmr4165083f8f.0.1732145270251;
        Wed, 20 Nov 2024 15:27:50 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bfd6sm3248330f8f.25.2024.11.20.15.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:27:49 -0800 (PST)
Message-ID: <91afb347-e8ee-4a97-bd8b-9a1413051cb9@linaro.org>
Date: Wed, 20 Nov 2024 23:27:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: media: Add qcom,x1e80100-camss binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
 <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-2-54075d75f654@linaro.org>
 <92f3f608-1ca6-4c41-9406-28c7ad589872@linaro.org>
 <66d1c50f-ebfc-41c7-95a4-5d555b336da4@linaro.org>
 <bb58d02f-9ed6-476f-8bc6-ad56cb35e37f@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <bb58d02f-9ed6-476f-8bc6-ad56cb35e37f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 23:02, Vladimir Zapolskiy wrote:
> like "vdd-csiphy-0p9-supply" and "vdd-csiphy-1p2-supply"?

In theory, however I'd like to avoid adding endless strings of new names 
into the driver code for each different power input.

We can add this additional string name though in the interim between now 
and refactor for the PHY API.

> Also you put a description like "supply to PHY refclk pll block", but if I
> remember correctly once you've said that the datasheet (of another SoC)
> does not give any clues about the usage of the supply, thus it invalidates
> the given description.

I'm surmising by extrapolation - that's "probably" what those are just 
at different voltage levels based on previous iterations of this PHY.

I'm just as happy not to describe this or to describe it as no mor that 
the 1.2v supply etc.

---
bod

