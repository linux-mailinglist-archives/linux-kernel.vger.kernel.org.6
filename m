Return-Path: <linux-kernel+bounces-537199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1279A48918
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AA916DA10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDD21ABA0;
	Thu, 27 Feb 2025 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZfDTGNEp"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283A21ABA1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684878; cv=none; b=LCTJGQpHp27Zcj9dRfruZYuiQiUyiXJ3u1MlYdZyhtzMxDo1kKT1zUsNUESiFhDurfKHaj2CnGX6zOWT7peWhwpo8Kn15Pm2WYfjd9aifincNxZfTBskWUY1wikYoilE8deT2hNAvuVYpZXGOM7xWd7YbOA0YpiluUW0bTUV4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684878; c=relaxed/simple;
	bh=SPKq0f537XTA+GTcZbaHH1ds54HovQwjZ7yNek1b10I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Kc8NUN/c7WX7X8clhhMDWvwt+1fWsfDTwIZnkzgtzG+WBwgdRW+2/zI8AEG3X1MHKpdQsokit6SUUzTHk/X3TjQorwTT8UUE0pmjx7Jg7n//2LFgkPHTTWmxmsRoBDfszLKfI35iR0H20djBeRtP9wH8gfrjzyEe+FDA5yGLvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ZfDTGNEp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so9015195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740684875; x=1741289675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SPKq0f537XTA+GTcZbaHH1ds54HovQwjZ7yNek1b10I=;
        b=ZfDTGNEpeGsh7gHjicK3G6CTRNsE0gLPkxAR7HO3xQVMvYqdZUYeRQZInYROvGgiu9
         l1mH4JDWOD3ZWJZho8dCPHDfs/LyCD/Di9tF5PWyDytJQI01W7DyuwMJwGK1Mwxf4U74
         D0FwS6qBoXG7G3OJvLliCJXeJoEqc9lDv3Boo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684875; x=1741289675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPKq0f537XTA+GTcZbaHH1ds54HovQwjZ7yNek1b10I=;
        b=JzHm3icgRf/2Em3fkIaMsHp4QUq8vkv/7ZVD4QPKKbosdPAikI+6Xa58sGVyW51cHY
         +ihpSBhcHXQrahhAR3iRyxN7DkZgO3TGRbFlaxIoZPJ1WlfY8wVENSL89xXTLnz3JaPX
         0jx20HM/+fUaK/ONirdbSH2wz6uNPCpqurW6qn+wjjbdaH/VbsLIbkZz+BO7VhM/yVv2
         ASXdBB3Ezh1a/MNQLJQOHvG/cO8A8rNYdpAxM2mR4+MOZwteNn1Wsd/OVLK34uKnKpWk
         vBwBbctJ+6HY02PSL1beqz3h6OeCMYLVdklNxFCckUrrgd8xqpw5AZW90NI/7FKj/n6v
         X9sg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Fh45+gKKdfKWvDgF3YsjZTIPIxPpSwAVnQSK1PAFMmm9ebnOHiC1/+vm11vS0/NEsijqx3srhC1X6Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4AwY63I9ccg1wSvUVVpq2iciuH7np+E84jq2C+ZhBL+RqeDW
	MZqL4yMzmv65bvk+8wOgQxerIEkBTOvy3Jh49anAt/WeTm/HoPbTWdPoYMIyLzU=
X-Gm-Gg: ASbGncvWYNntjMmLhubQIHomqTFY2KVt9C/L+rqwll2JadRu+qQJrl+dhShaFXY+1PJ
	y2TGtl4McNiRaX7jFn2TZ4ui62CwXRlgpe5hl5m51/eO+FUu6jJTrWwY05YJ0yBNpQyVXUjPrhg
	nySHHLEtOxotr2SsUf/5bUzQ1MC2f24zEabtqAfaqPCBCXBkqjtkC8Ew8RgX6OMhajZ6XfWJraD
	H4Y+WE8/IyFYXNVaUZMwfI4CBOcyKuvlv3/+JxbnydiddPqfVRtrgGx9KBCtISWkoQPMgtcFUps
	pqHVwSji2HZa8HpNlqON+7JUkz8htEH6zVR4bJANeZfwpEXxA6C1+ueX2bVO7ZwKyg==
X-Google-Smtp-Source: AGHT+IG+21Iov3jBjBZ0Z0Nbab+ewYkTBsybyNKaOFWbXOUqpQ21hSo6NGuJ7oKLVF8mteEUZWnPDw==
X-Received: by 2002:a05:600c:3505:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43ba66d588bmr4206255e9.3.1740684875179;
        Thu, 27 Feb 2025 11:34:35 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b70b1sm2925254f8f.48.2025.02.27.11.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 11:34:34 -0800 (PST)
Message-ID: <1a73d33b-e943-4ddd-9373-4678ff85c90a@citrix.com>
Date: Thu, 27 Feb 2025 19:34:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dave.hansen@intel.com
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
 x86@kernel.org
References: <7fa02be2-0884-4702-ae73-a3620938161b@intel.com>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <7fa02be2-0884-4702-ae73-a3620938161b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 19:03, Dave Hansen wrote:

> On 2/27/25 10:44, Chang S. Bae wrote:
>> The kernel has largely assumed that higher xstate component numbers
>> correspond to later offsets in the buffer. However, this assumption
>> does not hold for the non-compacted format, where a newer state
>> component may have a lower offset.
> Maybe "no longer holds" instead of "does not hold".
>
> This never happened before APX, right?

I'm afraid that AMD beat you there by a decade with LWP, index 63 but
also overlaps the MPX state.

Except LWP support never became mainstream, and it also got sacrificed
to make room for IBPB in microcode, so you can safely ignore it[1].

~Andrew

[1] Other than for competitions of who did the silly thing first.

