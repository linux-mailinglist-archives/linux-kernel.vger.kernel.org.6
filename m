Return-Path: <linux-kernel+bounces-385255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB09B349E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D19282E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43031DE3C7;
	Mon, 28 Oct 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6v8TU8F"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A31DE3B3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128752; cv=none; b=iVOuwdJlBUhfa8ULJtLJaU0Fd7Y7qyc3DlCWVofYqAKDS+rH38fDaAZpqJGKxdBpWBW92t1Y+iv6Expt3/QgeXNIByyXZElCWbDyHCipQCHQTLkxNu7izeQFU1+vt7uD0sYTDt3uVmbiYZ9Nrs3EHjI9xFD9bu0SxgtzGPvnr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128752; c=relaxed/simple;
	bh=VllxgaeAxK8ya5awbEYif/GTv+HwiWvVjE+QOtBgID8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0D8E90/MgcHLkBPmFt1JO4mJAYRpD/PzlW/h1XysjRQMoXP5oNIG7xK32HnFa4yjZdaNbMbaBXD0UuPAVJQWGZq/h2Ia2LpFytjM29I4KZG7zjtCa7c5knpVscY+NVkr7IIF21Cu4gnbWtXSQFU2jPnLgs7YyeNPu5Z3XDzX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6v8TU8F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431695fa98bso43449305e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730128749; x=1730733549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMehf1cmdH70vQG9fYSA+nflJUhXY7J4qMYXjLbnvAo=;
        b=l6v8TU8FXWMJg1Jjqjr7hH0mmeOBEUqeP1LATELUIXzJ/SLXArLjMZ9N5NEQ2x76Nz
         5m863gqIs0g0e50/qGGYeL61cxrO5r/AIy18ImW+WRgz2+XE32KBoAloMC0VeHalCMMI
         1vbkd4oTwIAnuisJDdERwoRVd1Hm6OhWqSFNiwcXkuAXdK/oMH1HYeq9q9XxhMD1lY/o
         uT8uZ9UHu7TLevifL4tDoVucMXPMn0oJUbML+dErC/ECV7yt4DiSvI0AF2aLQgXAszFS
         2qEkYrlspOagCyETubqrUatOm19r0UmOCpunSVT57fYwU2sATpqVGYEaTct0Ovb4urDd
         1S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128749; x=1730733549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMehf1cmdH70vQG9fYSA+nflJUhXY7J4qMYXjLbnvAo=;
        b=m4x5Zc0yGAmIZczQBSBmLyW+JWPIRDexCZJd5PH2v+8yQKa0A1ou4eKrFrijKotKze
         46Oo+JujcEcYQL6jY+XbK2EBZ/imyhQRbjrpcxazAeJMOxBKGCRORwYpxmzs6bUkkf5Z
         by54gW79DMD3s/RlJ+sQHF6rI5ytmvx+i/IVqqOCdqluQbTx4lUEVqI5R3QqexIpsqfA
         yBI5q1aNYk3fDKsl8iGyy7q5yNFeUdB3p7pjylQVFfrAavJBw8vNRrTpbXBGGCW704uZ
         YKetj2Eu3+tWstf9fUeAFkH6Qz5vxPr02f5tRN8c2wiNid9Eyw+XkTKfRx/Xb3wLwjnr
         6Q+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoa8h34x9aC53GKM3EXNrUTlYQ1MnxrlQvkxhlLMNkQsJkrZ/KxN3INNHuGAn+ha0nnPipBS5BIysjm04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWvgkAGItwuTSg5MMJJ+dmKJtxv8WBZKUEvxOeDRec+IJc0bo
	kHi+DONRTGWOzE0mXgKh1w5Jr2lZPxRr1pOtIN0LO9OajwFgqWurbZPv1BZjMp4=
X-Google-Smtp-Source: AGHT+IGqWBuggalF2VXXcJZ2EXD/713dHl0Cg5IYvuxKR1Y1NivxEcBCDFYslrN2INjSCJjCmJyyiw==
X-Received: by 2002:a05:600c:4eca:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-4319acad842mr94286995e9.17.1730128748659;
        Mon, 28 Oct 2024 08:19:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b58b79esm145072845e9.47.2024.10.28.08.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:19:07 -0700 (PDT)
Message-ID: <56b07267-a192-42b7-a4e9-5fe7d86076f7@linaro.org>
Date: Mon, 28 Oct 2024 16:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-sprd: Select driver on ARM and
 ARM64
To: Enlin Mu <enlin.mu@outlook.com>, tglx@linutronix.de, orsonzhai@gmail.com,
 baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, enlinmu@gmail.com
Cc: linux-hardening@vger.kernel.org
References: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/09/2024 09:25, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> sprd timer is currently available on ARM and ARM64 based devices.
> Thus select it for ARM and ARM64


Can you answer Baolin's question ?

Or can you tell what is the rational behind this change ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

