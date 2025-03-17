Return-Path: <linux-kernel+bounces-564009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC9A64BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9257D3A8266
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939662356C5;
	Mon, 17 Mar 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5FOTMtS"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7742069
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209866; cv=none; b=oUu8Bmv7PNsK02qNq6p5C6GkzsZ7G8uqNHZyeb/u9fK/24FSaHNdyFvkqHa2O8fCmIy//NsOhs3G1YvcFsIvkDY9WB4Fgr8fC7lec46PRV1ZCs9ym6Hm+dRAiVjVWDI6x3AoQ0ScLzDv3NdKlV+YyEgAJXfKZ5K4Tz2K/0dk+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209866; c=relaxed/simple;
	bh=jg6joZ76On4Zk98zQcL1bwxylUFIIHw3eHHZ8nAKwZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLr0XKEVIEZy5k7mYcKzYonQGjWXDn1aiI8U766XUHNG+GCJuBaEEHCGzA+iazTsIsbyLF5xZJALpE8DCHLuwbS6S7hKJd4VmjkN5TvCL+R/Ler8vCsx/NSkGzu3kcVKn0pnpfYVPByf/89NoCcqhttUyIaNzJ2gUWIBC3B4za8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5FOTMtS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so11044455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742209862; x=1742814662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDzJ2VOAzEbHd4YJavbMDLDdsevX9sVYERz7dfOZXGw=;
        b=R5FOTMtS+TGrB8ws/dJYpPPZGz5/PgBB0a3nUXS0wV7OQFdXFav7zE+559ND66fj93
         Ujdi+GpTLsZra/0jACsFtu7MQIgHNr0/KxoYxlkkui7MWyp37fXMznp/+4qifU2/zwKs
         YamPWJTSlLJiORcPlWRZ5BgNabzTUtLBp7w2xDMPzJCKcA9NusH6tNCLUY6lwSzmdo6N
         IStR1SgmXpQXiwtPCRHCDMOUtbR3FpKx+Jg8in+8e2KKWbWmA+ndoiq1OhMX759Ab5KG
         p9UAf1P2qSWGrthkhcZn+BLIHydadh40xWTl4qvNS3dXrPqlELDTujmAY0QotuAlJZch
         9wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209862; x=1742814662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDzJ2VOAzEbHd4YJavbMDLDdsevX9sVYERz7dfOZXGw=;
        b=bGY3/ckzIGQuTMurkifZomw6RdoRAgJeHgThGBv/K+iQoyPHni/wWab6RfkUg3B5N9
         v+s95SRMieqQNLzRPc6YpdHfLg43A/2EW7qadDpzUSvEhJM04P+YnVjlH3BAgC6ZfPmA
         Qa2kAYKWpS3NeDUVlAuviFcqeolHE7To8WyvyEY7x7kcmbfQT9bpBkNdUlDF+9fb8Emk
         akTGjJQ11allBUFlTdQGeFaS5cDX1VrGpLKKtSuCW52GV1Rm6TSXCqC7baxcjaToatAL
         V+jwc5uJ+/ziHpMHEk9JKGvUqb0xUWmQogDVDYppDz/guJYtiX5gNCLphYxAuewDeki6
         3prA==
X-Forwarded-Encrypted: i=1; AJvYcCXZhvd7ipx87m/UOaB3AIPisUUu+TbwkjLdCyToPr3+NPuO2dU6vxkRAPsX5lQWCjHeP2gRsPhWA9kA1wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3CYM/mtPOOdZZK2jJfYxHC1N898aFBd9QQ7OsPeHhpS44jKD
	EHPKrN3Oir1mng3FnvJhZDYxM0yUqg/wJBY+FZZwyjhMRfqLj6akQLdUG7KcP8MGgZIEUjUK3c5
	y
X-Gm-Gg: ASbGncvriLmeAhfJ+lCDGO7ALgtqN3aa1Kpi8+JiuUVh+NLrq5adLeIJ+WgGOEBV/Rf
	GttaxB0+t4IHy0LsgrEQStuseNRMAD7JSDnFCmf4+UriyJag1WADxykOby8hVtENbvgb3ZxpaZy
	aDzVOU9EhbT/49B+rEuYsFdnv8q0pj/DCN0XRp/yolg3zwdikRvQi/k5G7chmJUcpcc6j4GMKOY
	0vR/2LoKKggB9zZh6ExMd0KO1ceWYY+mjozaGTIJiSKSwmMTxsjqRl32Zs3HqjkL+JIAA0ySC+t
	b6iGRD41xk8Dibmhkc614G23uq/NjMVorfr1TxXvK7de9W0CVPxRmg==
X-Google-Smtp-Source: AGHT+IE03/gw38YLSXA2yKf2gnc0bYqatqbU69Cuyezj6/XGCnmhURjlT9yMf7Kvkxg1rjJbu9xTyQ==
X-Received: by 2002:a05:600c:4ed2:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43d1f1d2bb6mr120674475e9.3.1742209861923;
        Mon, 17 Mar 2025 04:11:01 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe294b5sm102277455e9.21.2025.03.17.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 04:11:01 -0700 (PDT)
Message-ID: <4cfcb9d8-3187-4ed7-8951-d54d781b4bd9@linaro.org>
Date: Mon, 17 Mar 2025 11:11:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64/sysreg: Sort sysreg by encoding
To: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <20250115162600.2153226-1-james.clark@linaro.org>
 <20250115162600.2153226-4-james.clark@linaro.org>
 <20250313215840.GC8101@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313215840.GC8101@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 9:58 pm, Will Deacon wrote:
> On Wed, Jan 15, 2025 at 04:25:57PM +0000, James Clark wrote:
>> It's mostly been sorted by sysreg encoding, but not 100%. Sort it so
>> new entries can be added without wondering where to put them.
>>
>> The following python script was used to sort, keeping the top level
>> SysregFields and comments next to their current Sysreg entries by
>> splitting on "EndSysreg":
>>
>>    # cat arch/arm64/tools/sysreg | python3 sort.py > sorted-sysreg
>>    import sys, re
>>    def key(block):
>>            reg = r"\w+\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)"
>>            match = re.search(reg, block)
>>            sort_val = ''.join(f"{int(n):02d}" for n in match.groups())
>>            return (sort_val, block)
>>    sysreg = sys.stdin.read().split("\nEndSysreg\n")[:-1]
>>    sysreg = sorted(sysreg, key=key)
>>    print("\nEndSysreg\n".join(sysreg) + "\nEndSysreg")
>>
>> Tested by diffing sorted outputs:
>>
>>    $ diff <(sort arch/arm64/include/generated/asm/sysreg-defs.h)  \
>>           <(sort before-sysreg-defs.h) -s
>>
>>    Files /dev/fd/63 and /dev/fd/62 are identical
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   arch/arm64/tools/sysreg | 1006 +++++++++++++++++++--------------------
>>   1 file changed, 503 insertions(+), 503 deletions(-)
> 
> This looks like unnecessary pain for backporting...
> 
> What do we gain from sorting this?
> 
> Will

It's from the discussion here [1]. But yeah backporting wasn't mentioned 
as a possible issue, it's something to think about.

The summary is:

  * I added one out of order because it wasn't obvious from the unsorted
    file that they were supposed to be in order
  * To avoid more of the same review comments and save time I wanted to
    put a "keep this file sorted" comment
  * But the comment wasn't ok because the file wasn't already sorted, so
    we ended up with sorting it

To be fair adding a "keep it sorted" comment is a bit awkward because 
there are sometimes multiple places you can insert something if it's not 
already fully sorted.

[1]: 
https://lore.kernel.org/all/996c7843-7f51-49a0-9122-e688e37f9902@sirena.org.uk/


