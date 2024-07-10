Return-Path: <linux-kernel+bounces-247504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5092D057
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536BA287F88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFBA19004A;
	Wed, 10 Jul 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuBBgvYG"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF418FDB7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609995; cv=none; b=f1Q4Ybh+mjV6NHroqoZQp/oVpzWa6jz7uXZ4JcPtQh/b3ctmC0ZKQDHoG4Y3fqCli2kjWe4evBDbg3TR02AuTBoyIVzlCT6wDLfgWBCSgvlpW3J5NRQriCe2WkkmEtD3mjAXzWRlvcuha/BchFIc/0Tw9ti4evzeoxSm6uy0tNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609995; c=relaxed/simple;
	bh=otZeNf2SHFNG0ERFFNIt4JImzvXeOaXJSd088iYkW5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awzyNPlvnhCH26ax3eUIavek76fRvcHKYqrpg/GAn+E34doX2Q8V80hc9nlFYr0Zpv9J8CtKm1+mznUnmr7Y+rFeWG9H8SUsUfuZmYnmOJa4H7mlJ6Wl9Sj53Qv2ttet3bCfB9pxjDM0tailpTdXSogGZNIEu7equOMwcXuZ0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuBBgvYG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36799a67d9cso4924591f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720609993; x=1721214793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsPComXSgMYoXbh6GwwHIJBYo7ADPLRK550OuHmMbfs=;
        b=FuBBgvYG6AzH1m6e+hlihrHenktS6zPPI0GKn6JK4o7xq0DMpSLHYvews7oSm7XdwC
         /3Kvg8o95XHaKU5bKZQLye3h07mkiVc64yXsmY24ZaIitrVxEZJvGoarktuyxtoMT3bC
         U7SHSPvqczTkAse1/QG5KKC9OokcsC7UHntNbdVmL2+soDEwajuZ2XHXjJn2XfZfZNrY
         FH+qqmMa0eWszxJZya5R/gGblHTh+47Faqe9Rx/roZvMUXo5Uu1fXc6sUVo62eYDKPih
         ltbuRb0LNo4zX57M71NpLazuxUAXERoT7c9s90A3oGwBoHEHeYskIj38bOH/+Cg3ppq9
         CQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720609993; x=1721214793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsPComXSgMYoXbh6GwwHIJBYo7ADPLRK550OuHmMbfs=;
        b=XTF/GEKKkPvGr+VFlVnD9ubakTP3yiTwlP/siiihpZUyp1eszb2E9etWi/pcQVMiHP
         PXuprCSFMCvGsZKSQLoGNFfrHzX5Jm6xvHlGsia6N/MsoobvB5YWj+fIwojvS/a2SfuV
         8GwLbf9KtkpU0wtxHVzCKite77Nbihxz3ArWodJZ3i1HK8AqeYHfAaue1rxk18xnONI+
         J9+SfemfQTNMSXYLyy4XDsXHCtGFRSvlWqdzDUKEnjItY+OIKDjTUoocbtPGeqe9wJ+E
         qwLG0XZCnPuWyVjAEkyHtpXcnP5jwtYN6O7M1hiIIg0Ab3ODA7oEkdQy+uv+VxHs45re
         p/xA==
X-Forwarded-Encrypted: i=1; AJvYcCXrZPWvS9Cbi2+IO/zqqD4RJqJJRTzoF5A2CkR2S+jxwV3M36evDAvwEvq2bWyD15hvbpk7YJGUfmuOl4/yfQe7eXjrXuNjdiLMgf5t
X-Gm-Message-State: AOJu0YyeWYRnoX8o0vD36YBpdo7nLKUDAocNpOQX6v+5r2EQYNmMVx+L
	fQfwukhsPk/HPzIi9z7HkdL3UzWCHwfn6llYESymRV8c2/wYzZW3LKI2SyHSUPw=
X-Google-Smtp-Source: AGHT+IE9Q8uB0tpFi0kr4mRGgRNV2tp0EcJHs7Mk8PmLwgRcY2a5qgIkjyMwJ1YxeuQGOK6gnQ6IjQ==
X-Received: by 2002:a05:6000:d04:b0:367:92c7:3ac0 with SMTP id ffacd0b85a97d-367cea6c063mr4245452f8f.22.1720609992742;
        Wed, 10 Jul 2024 04:13:12 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7df5esm5075040f8f.22.2024.07.10.04.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 04:13:12 -0700 (PDT)
Message-ID: <02e34bdd-3e84-4f93-b9a8-a814fcfd465b@linaro.org>
Date: Wed, 10 Jul 2024 12:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] media: qcom: camss: csiphy-3ph: Add Gen2 v1.2
 two-phase MIPI CSI-2 DPHY init
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-9-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240709160656.31146-9-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 17:06, Depeng Shao wrote:
>   
> +/* GEN2 1.2 2PH */
> +static const struct
> +csiphy_lane_regs lane_regs_sm8550[] = {
> +	{0x0E90, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0E98, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},

Definitely not DPHY 1.2 init sequence.

Could you update to something like /* GEN2 2.x - two phase 5 Gbps DPHY 
mode 4 lanes */

Since the PHY can be in DPHY or CPHY mode at different data-rates it 
would be nice to call out the exact mode we are upstreaming here.

---
bod

