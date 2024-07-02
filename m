Return-Path: <linux-kernel+bounces-238133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A827C9243F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517601F2622B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D41BC08A;
	Tue,  2 Jul 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJ8JYCrs"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2861BD4F8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939135; cv=none; b=OMrMc7jcL7yHvHa6SOZJ7gYSA+C7d390qpdmv1a/JNEiYaz3rrmYiJPDl9EipOsjOTI+VRcPcA7QLbvG7AXT/VH995I04XuIU8ln+TvKRjMLJo+7r2jpiYbjZTiye1iXlz1c+y5Udma9q96WTWcrouai4T84nTGFGxplZWFTZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939135; c=relaxed/simple;
	bh=67wdZHMGthQ9tYMWUTf83nlNhKOnjz2Zui5kHHhZWVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0JM8iCWMrUV4kgjhZHnTtGdYaJb0JSaHA7r2k6+ZWZIKiMBqCyjYv1DCE27k0SrjnwT0+4N99L6efd7s0cE4VdO7aeVxDz1CpbIv8kHS3YtaAofNm/n2Sajm6sE+TVS6/V3LCE7zqwu19gsiHQ9+x9XEzWHa8vAPwGxYdfEKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJ8JYCrs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso22735955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719939132; x=1720543932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eehroHY6jsxRCXVO0ZlO8N+9Mr345Lhd3RIOJPZlnAY=;
        b=NJ8JYCrsx8afLy1T6M8bA1WiodCFtQsH7vLP2kB8q0/4ekAdOY4bDeeV0fYcQO+0ZV
         lXzr4Z+/+ywQE7L7I61ti/ffc+4Zd3qEiK0r8gbon2TwEQE1QOzf1hj28vdHnSsDCmpc
         CYQjrA1HqfmGVlCclWUzBFkcl9C2NUGUSm2b+CsErmgydE77Y/hdnC6Qlp6GPWLreaPN
         FKMwdw622kW6dD4cNu0wo3Bil4Gv6sDvCnfjeSjUNiNsT/BlOmpFwB+59G7u8aw2Cemk
         593TjzNi4/EKxnbwA5vIvKc0A5uCgstfqKPpGiyver7mwmIOA6Hj/U3+qtWR0IeAPacl
         UvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719939132; x=1720543932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eehroHY6jsxRCXVO0ZlO8N+9Mr345Lhd3RIOJPZlnAY=;
        b=TSBBq/hUWTXDr6xFayM0jV0wPpSKZlHO+QpiKtBWwx7KPbJvyw92vzlxi+fE72+/lV
         r7n0K+8NWnSvvB+imSqVt37WVIOseLTEoSwAGBmFuyIT7xviTZdrelhyP279bjx2sRI7
         mNRLZ8njFYpzxlqg7OG37dlEG7QH3d0N0UpXPWXEjSt16fWKAHi5HFZMxP21b2qxiDAe
         YnxknqG2WJtQgm6UQjDcca3Jps/Rnd74eRHiT4Ik7MT93yCuWOQShhIPsVNTctznJXVs
         Lox8s4MwgmgBkehXpOYVpGuw2C5z90B8UX1DFpL1HTdzNisPiofcYD28T4j2RF67CgWi
         PASQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPGNZohjKqKsnDx4o3Gl69tr6lJP1QZWGw0c87Dty1pFg0Sz09BdcqLcRF/WVXPx5KBAOboIjSBVs31Uib2nNpV/3F/2hAqf9Yq/GU
X-Gm-Message-State: AOJu0YzX7jbUkMQPDN3gBv7CaB24z4fyfHO//l4KfwWcRI57sGmcsmD9
	wwxpa5P3QCfGBWIIXmqN9UGxFPsgEJbj5B3J9wOLqLOyk8cy4d5ZYEI3EfmF5fQ=
X-Google-Smtp-Source: AGHT+IF3V1HC4chVUPw7FP944I/P3u9IFqa0gz5TuDk7AOj8IDGj87TQ830i2eIZSX6jeLFY+OsoJw==
X-Received: by 2002:a05:600c:2d8c:b0:425:7833:db91 with SMTP id 5b1f17b1804b1-4257a00cd97mr64098005e9.20.1719939132436;
        Tue, 02 Jul 2024 09:52:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af5a3b0sm206096705e9.13.2024.07.02.09.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:52:11 -0700 (PDT)
Message-ID: <eee20abf-6bb2-48f5-a0c1-a8c023a2b7b4@linaro.org>
Date: Tue, 2 Jul 2024 18:52:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: correct thermal zone node name
 limit
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240702145248.47184-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240702145248.47184-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 16:52, Krzysztof Kozlowski wrote:
> Linux kernel uses thermal zone node name during registering thermal
> zones and has a hard-coded limit of 20 characters, including terminating
> NUL byte.  The bindings expect node names to finish with '-thermal'
> which is eight bytes long, thus we have only 11 characters for the reset
> of the node name (thus 10 for the pattern after leading fixed character).
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com/
> Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


