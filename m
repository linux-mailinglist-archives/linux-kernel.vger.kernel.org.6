Return-Path: <linux-kernel+bounces-520154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43DFA3A666
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5516BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46A280A37;
	Tue, 18 Feb 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot2Z+cxe"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785FF280A35
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904671; cv=none; b=qkzVYzmw9BwF9Ef5JIDStkx8z+UVQhdxHMKkIgaO11YGV1EfHby1r5iv9qxwrzNA5poC51AZPO3C619YBGjQb/AdsYQkeoL5x6MzuvKMjEqceVBpy9qu4oELjQovbhpces0+9oX4RBA1b20HKQxS41zzPDBSFaG7hFFauu0VDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904671; c=relaxed/simple;
	bh=MoO/m337yGrtN/rDuUa+yPCfHoVc7loFFqayxFZslPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7S900X1PyY8oXy92QpyFgZzuftlGXa+jDPXjOTpvZhQY1QyilpCNDULF18ofDz7Girl7AcYDETMVspCUD1PkyhEJFQy3LW1dk0F4SwTI0etFkOXlJWJiRkrLKeQ5YIgcoFLAGkUTeLxUXGU5zc0ZP8pLYS6dzjsCtHDun3u/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot2Z+cxe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f378498c9so3183352f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739904667; x=1740509467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2kLFupIIGJ1/RHSRRNvz/y3ILtkw1UuLgcN/irDm3o=;
        b=Ot2Z+cxe2KPTWucxmt9j5VoLNgsLicyCTipf+BIfC/4vRWQV9X7spfF8A9G9qLez2K
         x3SoKf+BWNdIWLENBXTu/LK6bJKb6w3pVXyU206iFtyl4vLde9wKLKMly2zjLVi03O72
         voAIjx7hJGIenJLEvs/2e5xcnOsjlFsqZVngj3pU+1spSsavKwBBNFTxCG/Sd0Hm9gG/
         ZyxfmV3u2YyPtD2gOKxl6t5M2usxAKyElt7x/cCHcTw8CkYYhhnFn1ZT8qG7tiwumrED
         PRI5+qDW8ps6IYKoNpg06P4lp8Dr8wbT7YeSr/n3esLeS+BjGYsGzQp+bxmtzqNODBp2
         9g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739904667; x=1740509467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2kLFupIIGJ1/RHSRRNvz/y3ILtkw1UuLgcN/irDm3o=;
        b=dM38nsrdz1HnPghOLb6VB//4ddR+pux1+PFDSLbasqDWpa63flqX7YkirLC3pmC5dl
         MRE5ArW0KRwFfk4ldATH0rhwV2XwPZyIb7rtNqFJ+9O1Q2i9W8L9VlFwN1FZsdg/LJRU
         TsQL/UjhUqiNbkk2PL8U/xYcyY3+PeCm16au3ge5J35BW4N/OEZfBdeKN/AUPS5rxIhQ
         xRsYEs03RMRknuq8JbGH7+8Rie6bOsx+yq1Ek+lSw6pV5nlJgyLpWc8Ly+sJwG6wYwZh
         9rqkxFWTwSMqUY/OLVmhQ1fkQ5UfmkQsQfGwNWq05wqABPVldb4q0rYVqph8xVJKjAad
         g4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVDUJvCK0PQPMB7dHAQTDe5lamHZ/6dzVV6vcARRUp85s7jyTQhURyuNZEXntP8rMw1m0863lua9r7tO7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6i7pJ0EnINpmjCIJp8x8AhMNKUUsk/pH3N2Jqjdm+L+n4MHS
	BpZS7d6dw1osjnqhZLSlpAgmRmaEH6lbR+TOhHulIJDTtT4A9PHWZ5AOO2A5Josr3VQ+7Xhi0rw
	v5cE=
X-Gm-Gg: ASbGnct18nKg8NrVTx9T0R6T26R2RB7Aq7uN7wlu1Ldh+8lYIrNIl/sJBlPhXmFqu/V
	j6OwXi/TyWc8JcWTfDNBPIm8mZ3TSnryyFxKDLLGy5MhMiYjAyRGCJvasBT0BCCI23udZGtMNwn
	B5FryuccaPsKCjyV+GZDEdoUqAFogg6K/R3Ocn3VBKfIVHIrS+SnOkHXp8o5+jn/lq+a4LAMgLg
	Fv6q0qF5CXVKksQmsf5i3squ79fvlDQ7SJn1sXbXsgc3I39rK5F2HJkghbdkunC815u3jqBwTVq
	szxOsN5BaMQHFxThNOzTGuTMH1Bwu4oNwqU9g5F93IW+fvvRILOWuUg=
X-Google-Smtp-Source: AGHT+IGWiGnjxl9amPWMtpBg/TTVGWv0w0/3DeUvonXPRwth4gPx2Sx4xPYck/WL22fVGRawD9RD9A==
X-Received: by 2002:a5d:6d01:0:b0:38f:4e30:6bbb with SMTP id ffacd0b85a97d-38f4e30bc4amr8481365f8f.25.1739904666800;
        Tue, 18 Feb 2025 10:51:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm15924221f8f.66.2025.02.18.10.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 10:51:06 -0800 (PST)
Message-ID: <5f7f39b9-5cf8-4ebe-816f-d56e52bc7408@linaro.org>
Date: Tue, 18 Feb 2025 19:51:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal/drivers/qoriq: Use dev_err_probe()
 simplify the code
To: Frank Li <Frank.li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
References: <20241209164859.3758906-1-Frank.Li@nxp.com>
 <Z5EULLr7hsk1RIZy@lizhi-Precision-Tower-5810>
 <8693bf83-9878-404e-b609-dcaf758d485c@linaro.org>
 <Z7TEGQQ/JM/q454F@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Z7TEGQQ/JM/q454F@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2025 18:32, Frank Li wrote:
> On Wed, Jan 22, 2025 at 06:41:22PM +0100, Daniel Lezcano wrote:
>> Hi Frank,
>>
>> On 22/01/2025 16:52, Frank Li wrote:
>>> On Mon, Dec 09, 2024 at 11:48:58AM -0500, Frank Li wrote:
>>>> Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
>>>> code.
>>>>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>
>> I applied the patches, thanks
>>
> 
> Thanks, I have not seen at linux-next/master. Anything missed?

No, it is in the thermal/bleeding-edge ATM and will go through 
thermal/linux-next tomorrow.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

