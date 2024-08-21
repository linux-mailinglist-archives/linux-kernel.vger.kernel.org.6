Return-Path: <linux-kernel+bounces-295453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E7959B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725991F2439E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1878199FD7;
	Wed, 21 Aug 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiZzbWix"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72219E7E9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241373; cv=none; b=R0RY+0AHZ1L13g4DHFF8GgFA7cbXhIH6DpAOMaOA/vskteur3xPfQJoPFTtDPr8XMsMdgHlp8phzBrqSp/X7jO4ZcwftkKBXNcUeVeaeRC/zZSNShd29YNFhk+honmYjCNuMB9t3tfqRBTE/50CTZBLyWiZqPFsPsqbnC1GOed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241373; c=relaxed/simple;
	bh=X3QTt06ZPlEFG0ggW40B36+MBYRU68cM/AweCMu3aS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDOAdTcilBvasEjtUp2RbmFpW4zxfx9XoISJaAhKSOClvTKIZ8LI/RNXMMuz5Ro8A0lI3+yGXkj8AnNyRMgNH6QqWoXwPQaALiDlrsd552hOQ009SER8V5qfpPHq2m5UZoxExir8AGsBdW4T7WUAK430zZ5QZziv3rYmgBApd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiZzbWix; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1871066f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724241370; x=1724846170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLRc2YOZCfMRGC9RWlW0UoA1di0uC0RC1vdzrS0l0Mk=;
        b=xiZzbWixfRtH4p1Jlj/mESVhzxpQcxhB/UQTma289BSSs6nxDM5o3n06c6myzDO3cB
         eIfSn91Ljvbz9lTEPc3Fjey6er5i9qETnOgwrnkOnDZtxtcmiwTuYtpfcalx/Zd8iP7p
         EsoUyC4vLgspp1QFR0imvcKstBh8X8JbEYK77WCuQ5djO51DXuvyDQ0NGDTDrm2yVlnb
         TJdgnhNA7GL7osVZC5O3SajQXbCvxpH/7b9Fs6FgX4ArcdUiIJnvVWJ07Jqnj911JPrG
         Uy7i/HOG57ST7Q1G6BNgZqpEvpT3z+HWGdNQHobMCBsMb6mHCYJf/eoeqdLBBDuS/DRW
         qwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724241370; x=1724846170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLRc2YOZCfMRGC9RWlW0UoA1di0uC0RC1vdzrS0l0Mk=;
        b=sYtHRiSZ/9ChHfuLYDFmAX+3tTLXB/vH828zkfSI7jAQDGJtGFux70ZJNxs8L9Is5J
         syGy+qqdkdg+nosjFxTN5rhnLX/JUZa06+11M5kOckVkfMTTN76LZhx5YddvbDLE4m9y
         bx/8G49SbrGBp7czcku6cCH6lUwqrP0RO1/6TNimlUiKzgD0/SqSOvqnsghLZbhVvrB+
         P+qh5w3zV0sJHiuRJ8UEEJbvXlObPqIandxax33j5yqd2zFcjDz/ZRY37i0NQrJCm8l8
         K1/M6rDFkY7BZL4X1CJbKazhU4SMAuBMWAs4TlS8ObA+f5MM5ygx0k94SEKTluDNMexp
         HC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDB3oMygKHxlvMPMEFlE/GKpBiJHl09vOkxDMFnerWJgVR5hTxEDV2nDkPvGdL2o7+y6fFTMu11/oSDC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdR/F7nNScKrGuUZFvaIlVQvT9q+JaEOX1m2uOyhAvCEBTud1
	Uh+09qSAMT8VpZaUSr+1fpbmeiuJAdui44ITof+3Cf5zKrwYBHHkXQIhRjRlJ8k=
X-Google-Smtp-Source: AGHT+IGw6cpMHi9itIY0JNP0g0swHOu8yw9cp+tSN4XfqU/gzjfG1u2zLD0W70uTXB5NGbUwMZ5ywA==
X-Received: by 2002:adf:e802:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-372fd5769c1mr1284058f8f.13.1724241369999;
        Wed, 21 Aug 2024 04:56:09 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718984980dsm15517785f8f.40.2024.08.21.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:56:09 -0700 (PDT)
Message-ID: <4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org>
Date: Wed, 21 Aug 2024 13:56:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance
 checks
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <10527734.nUPlyArG6x@rjwysocki.net>
 <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org>
 <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 13:11, Rafael J. Wysocki wrote:
> On Wed, Aug 21, 2024 at 1:01 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/08/2024 17:52, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Because the trip and cdev pointers are sufficient to identify a thermal
>>> instance holding them unambiguously, drop the additional thermal zone
>>> checks from two loops walking the list of thermal instances in a
>>> thermal zone.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> I'm wondering if the thermal_instance 'tz' field could be removed too ?
> 
> It is used in a debug printk in __thermal_cdev_update().  If that
> message can be dropped, then yes, but that would be a separate patch
> anyway.

Yes, I don't think it is really worth the debug message here


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

