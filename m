Return-Path: <linux-kernel+bounces-521984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F5A3C491
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C719161418
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51561FDE01;
	Wed, 19 Feb 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7YeYMf5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FC1F9421
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981374; cv=none; b=mESTD22pYXwz0rBtTT7oaloGylIZ9mv6Ws6kCtxQYvYPKRBSOawnrvAbswOjUIeA5jTnHnCxq174qYeJjsJeZY7FFJ/aruLK975SAmZvaP4rsM8Tw6aUL5m1FcaMYKuLCM3zyhKiBQwa2DGtgPd64DmFBkLsNUVzw+M9lq3rxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981374; c=relaxed/simple;
	bh=/lekqJfKGMjw1dQxyTeqadS7uFPIGjGMoohx7NzndQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsbByfQcqpJXj4oOY67zZ8fJ2576F3hTpmALyp4K9cBxl6eOsCIo6a1a0AyJ8f4FEgPBk0t9GPVsAePsXwkivDNMpmBs6dHiZIfAaMUdc2hdbkd1mn2guuI1G3skTrEiaV5uDLbqNFrEUu924E2BIhSCPBOjNJvVH1BR6nA7Tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7YeYMf5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a823036so71336195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739981370; x=1740586170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdBoFnuhqMD4bPK9q59QOYbccPf40KzMHKr/84iucLw=;
        b=u7YeYMf5dRram62SnlWh22KgU4LPjiB652elxEey2Q5REk8J2or/uo1C59oo64U4xR
         LmOp1sK/GmiMiifQFVO/Jk7UEZiEz6mpbSW4X7bxez3sLLW5n4P2DPUX1RLeWId8Kfm0
         8yuJVlHtV8MqU3THAwyNqumlIV2lqGRR2DOiIZKkoTi0Bia1gFt9nbhrFInaNpZwMEzq
         oSeuBCWfEjc/eDsOd37yHgcRQ6VBKf21sR2a9YSeT5ZE9GFTQNvkVd9bidGyNCwyr6aF
         rrwADKmcdlb5wcrenyH6j/JXFlT1Cfhia7LGCL11Zm3AIZBQGHh44RI5JiqIiTRfzG9M
         R4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981370; x=1740586170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBoFnuhqMD4bPK9q59QOYbccPf40KzMHKr/84iucLw=;
        b=gunmd8AMvt/fOoQVsv5KYqYNtkjfaoEZNd/MrElFdH7XpE+LaEORS7uJoBWsBRxAGv
         MqNxhNNTQGXXJRI4/QTMs1XAJOhrtNrxPqElrpLabvFwu43BARDolvo5IWKFfPH/ctrF
         I6apXFAImVPd3nClRWukq5UvcHe6Pzj2A3QKtvTAuwfqyQWnJaK/UE92XwdpSvTHWcpc
         FIwvVoL+uyA0BH0gwTngxRQQOaPbNxba9PcjX6wHzhtqnztdoA9czZS1VkuHv+Ynm2Dq
         sSSzotEDpb3or/ataCk7+ECFU8JUigz/kfTmfG/C8pXX2LTdax4fDj9exUIWko0V3NDO
         5NhA==
X-Forwarded-Encrypted: i=1; AJvYcCXMPwpb13Vg96nc5DjNyWdUPf21DlagoCD1xGmoNMRhifVLbSjz04A/nt9bldI56WF+whz1jCm3J7QBhzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSlPMRZCXyaVfqd9IyrWW8DFUL6tFKmGqp4V/o4FztLU9GKvN
	dHk2CuoHTKYAkSWJmI1L1vaW+zXCbn5wNJzKYN9E9aXh9HRYU0KHDBST5o/jP2g=
X-Gm-Gg: ASbGncvjb3uwBmOTu+8TrQ81HIrlBUe/GOj0SyqIm+NaSRfB3Ja3CBnqr7vga37+hyA
	Fy86F2+kbwJSzzXqWz8aEVkeXsGGaQoLu/2vumnjgu/V6pgU110LvHbMNax2jWKL8iO3pAPU2pd
	vAKfON+4TSU67TUJjpZ9oslXG2ytmsQ91TeKY2T9q3qtkpVIFgT6ANCYeALyyJCr5n3vjL/9Raf
	ZJdhPZqSkPjH24vw38zn1YWu8FBmbv5lcq2Su6svW3r9yDInlVPsCeAwu1ni11xWlL4YjZp6NDk
	1cNgPvY6SxAk3Bx+F50qIfqv+g==
X-Google-Smtp-Source: AGHT+IG87mSbuSo594YlU8iwWTPKAQqVV2chSBKXzyuZ7LJ3HKDzFEKHoFoqCd1APAlb8lVP4Vl8fQ==
X-Received: by 2002:a5d:64a3:0:b0:38f:50bd:ad11 with SMTP id ffacd0b85a97d-38f50bdadd5mr6657402f8f.5.1739981370330;
        Wed, 19 Feb 2025 08:09:30 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm3617686f8f.21.2025.02.19.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:09:29 -0800 (PST)
Message-ID: <f8f5b7bc-0219-4891-9ffd-f54102b90b45@linaro.org>
Date: Wed, 19 Feb 2025 16:09:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/11] arm64/perf: Enable branch stack sampling
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Leo Yan <leo.yan@arm.com>
References: <20250218-arm-brbe-v19-v20-0-4e9922fc2e8e@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250218-arm-brbe-v19-v20-0-4e9922fc2e8e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/02/2025 8:39 pm, Rob Herring (Arm) wrote:
> This series enables perf branch stack sampling support on arm64 via a
> v9.2 arch feature called Branch Record Buffer Extension (BRBE). Details
> on BRBE can be found in the Arm ARM[1] chapter D18.
> 
> I've picked up this series from Anshuman. v19 and v20 versions have been
> reworked quite a bit by Mark and myself. The bulk of those changes are
> in patch 11.
> 
> Patches 1-7 are new clean-ups/prep which stand on their own. They
> were previously posted here[2]. Please pick them up if there's no issues
> with them.
> 
> Patches 8-11 add BRBE support with the actual support in patch 11.
> 
> A git branch is here[3].
> 
> [1] https://developer.arm.com/documentation/ddi0487/latest/
> [2] https://lore.kernel.org/all/20250107-arm-pmu-cleanups-v1-v1-0-313951346a25@kernel.org/
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm/brbe-v20
> 
> v20:
>   - Added back some of the arm64 specific exception types. The x86 IRQ
>     branches also include other exceptions like page faults. On arm64, we
>     can distinguish the exception types, so we do. Also, to better
>     align with x86, we convert 'call' branches which are user to kernel
>     to 'syscall'.
>   - Only enable exceptions and exception returns if recording kernel
>     branches (matching x86)
>   - Drop requiring event and branch privileges to match
>   - Add "branches" caps sysfs attribute like x86
>   - Reword comment about FZP and MDCR_EL2.HPMN interaction
>   - Rework BRBE invalidation to avoid invalidating in interrupt handler
>     when no handled events capture the branch stack (i.e. when there are
>     multiple users).
>   - Also clear BRBCR_ELx bits in brbe_disable(). This is for KVM nVHE
>     checks if BRBE is enabled.
>   - Document that MDCR_EL3.SBRBE can be 0b01 also
> 

Tested-by: James Clark <james.clark@linaro.org>


