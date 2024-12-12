Return-Path: <linux-kernel+bounces-442862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740339EE312
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FBF282DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130520E6EB;
	Thu, 12 Dec 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qq4eOKbE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4B187870
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995876; cv=none; b=hM7mYogi/R9BYeolyEsmK4ThBdqOlR77/rqKicGixi83wPQe+Kl3h83FFJRLmSJLH4rBrmCbbg7WzYIHC2iqDoabLkZJjkAj0KzmX3VBCfzoVj9gvc2ikYCP2zKNKVhAdqIFTLQSArsMw80Xgpr3YwN8B+M1qN3HmCPkeIen3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995876; c=relaxed/simple;
	bh=UEcmycjj+ersRmGzbxUSVT9OKoCelIca8HtPxnMVDLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLYrBAabOslMghGXFDMyldzb7sbXpHcwCmgszKHzIrF662ZdPtKatJSM9trm+Zv2I6eX/C3I+q1gOH9GU4d/4Rm4qKOYZdzAI/gJMWwRjKDEjbtcfAD7+ljbCzghVXM+UNP6vobTsrtP/C5tKE2UKoTIH8ekBXP+rzpsX2REcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qq4eOKbE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f09be37so393695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733995873; x=1734600673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z5iFFc2Aa0JRZM6u0xT5JQCOgUmJrcBcm3xHoAeXrQk=;
        b=Qq4eOKbEhppcZ8n9nJp+wHzfBbVOqi6o7CRwm/CuTWI5E6QO74IcHIUO2WD9kLDCkp
         qI0h7s9DMQQSivmLQ+cfmnhOiAnAHCPAAObcH4rldf1WYZ5iMfLlncwPqx6K2iRto3m4
         PKydq2JQzxljlluKgOOz/0gkf5uTRvLEDTNIiQRiyhSYTh2aNNF/+wV+ZSzdI0qSXe0A
         IFHuJUol3xeM1AdMqFqRK4JvVvQ0Ogjze3cBRQyDk6z3W3rfz/OyA8NexnIKJmYrPX7D
         yoGmQOXcuY6r74Z7dYEG6Edne20U2O4zwNbHQPpQgBaAOEZtsgmFMq/5ixf2qQE6rmx2
         Hv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995873; x=1734600673;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5iFFc2Aa0JRZM6u0xT5JQCOgUmJrcBcm3xHoAeXrQk=;
        b=fNDs0kS73ZrMUGGjcIVGqQ6eGQRtVy51zrsXBdL+DMFz/XaWOMn5eQit1V7aSLFX9M
         2GDwt2FtOF6hpekQqTAm6ePjmPk3WSSz3IvXjOnWBQxl2+TiYSzxe8J0jTfhD664sNqg
         SC92+wKubBJ4FkH34w+kSquzwt6eYb8bIpp/NjZM/mQlIXgw/YhgM9PrBMeb91JETf7g
         E2Mx8FLGEBjUM3loQrPfcDw3xlHd5xGGsKqQ1GK4dArMFu5mM2cK3uGtqChaYgSmHfeA
         igZqZScbbsJhXbQ9r02lLx7naQEh9WIzNAiuN4jHljXQenny0vvh7s+7f40Xbp6AB8K5
         7jdA==
X-Forwarded-Encrypted: i=1; AJvYcCVJHLnCfLEybSio1lqM0+JyAwDY18eviQiiKTlPTfY+EhJrSXexPR5S+vC70RfssYuFO2EdbtGhG1O4rq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzAPLKkwp+gmG5lyINGl5I5Sp5Bv/1DLMF5o17RpqxuSdCmRd
	tmB1PzlDkQLXRdSsGcOFy6TpOsjgUzBy2jXaNjhLSXVMHrnCWRNxeNlZ3hPM9kI=
X-Gm-Gg: ASbGnculRqg+HbEZnsZzgZ7xqKwfho6Negd5/FevTha8yWrbg2IFflmUTNmjZn4tQYQ
	OnZUxhgsY3VFWSAAGqKHaVtnXyfRGE7xnr+cVDhLVQa8PTsmYE/XyYnZyMsxkp1iVp4qLtCJdBy
	RLDu5m3QeTNsWWMlReHoPzOZv/z4TK7IiMqy+GM/c+dXaC0HaEZG4tgkHxGWD7UlSWLyGbgk76z
	2I8HCv+QYvNAWPIo3sSoOVYSF+0EVOax+Qpw0JefhCILTlGr384uIy9nH86NIV8IZq1ofsPggsD
X-Google-Smtp-Source: AGHT+IEC5Dbme6GU0zsn8tf8T5BnHG+sFgiAI0kaQ8F4P6lFFOjsYVRYuWjeBx+EdEK3pJ21Mt7Bjg==
X-Received: by 2002:a5d:47cf:0:b0:385:efa2:e69c with SMTP id ffacd0b85a97d-3864ce8696cmr1831650f8f.2.1733995873344;
        Thu, 12 Dec 2024 01:31:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878252d22csm3467172f8f.110.2024.12.12.01.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:31:12 -0800 (PST)
Message-ID: <9e91fd4d-8589-4403-8025-4c8ccb8e67b8@linaro.org>
Date: Thu, 12 Dec 2024 10:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mfd: syscon: Fix race in device_node_get_regmap()
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Pankaj Dubey <pankaj.dubey@samsung.com>,
 Heiko Stuebner <heiko@sntech.de>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
 <20241211-syscon-fixes-v1-1-b5ac8c219e96@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241211-syscon-fixes-v1-1-b5ac8c219e96@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2024 21:57, Rob Herring (Arm) wrote:
> It is possible for multiple, simultaneous callers calling
> device_node_get_regmap() with the same node to fail to find an entry in
> the syscon_list. There is a period of time while the first caller is
> calling of_syscon_register() that subsequent callers also fail to find
> an entry in the syscon_list and then call of_syscon_register() a second
> time.
> 
> Fix this by keeping the lock held until after of_syscon_register()
> completes and adds the node to syscon_list. Convert the spinlock to a
> mutex as many of the functions called in of_syscon_register() may sleep.

Maybe mention the reason for conversion to mutex: lock will be now
containing non-atomic kzalloc and regmap_init_mmio, where the latter
calls clk_get and clk_prepare, which both are sleeping, I believe.

Otherwise it feels you are converting to mutex just to make code better,
which would be then a separate commit.

Everything else looks good.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

