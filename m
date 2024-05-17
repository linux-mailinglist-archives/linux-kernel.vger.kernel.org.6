Return-Path: <linux-kernel+bounces-182285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277818C8938
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6A91F27830
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CF12D1EF;
	Fri, 17 May 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOJwOG77"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1A78691
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959199; cv=none; b=EmCNkoQOtyl3yxQLRxkoSCido9la/oHvVTz6IQ6iMu7M+nF+ysovt3njhMPO+EQQbKjImMcCa5ZToGUi8+wUNro4FCIEfkH3yA6ru/kzZhvML1NM58Sbry3GH+XHIA2Be4ZluY6MCFmzqRptoR9wSJGjR+gnUd6w6wrwnJli5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959199; c=relaxed/simple;
	bh=VjxD+K/xMuR4bfD9tSlRbtw7G0gjxJhfduzYuca6/ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fteBVFAMq8F+Ms2c4sGjd2WB76ixUDObw3Fx3cH4uNLb27Tsa8R+SB0fcY2yTT+HbrMeU5aPIHnEa5xUTJWCTX5TyYLyi0+LEW280Bg3ZE0nHXUKpF4qEe4Qp8V0kOMS3vGJJEyzCW5OCo0rH3Ep5BfF4SPRdoJo8CLivD9XUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOJwOG77; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f447260f9dso42272b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715959197; x=1716563997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ0Iz6mAJE61rWHZ5SYis6nQnIUkMezcTOB1z3PJxiI=;
        b=NOJwOG77lXTTf7SD0mLL4+RASeyDEi90soLDOLmkr5RlohIBAoGsy0HJp2AkBxZcuz
         nXZcw1UC9wqcBnrQgQBmbNwHurMDs1mQXudgDWLrjE8RSuZmp5XS14WyMW25ektYy7mt
         Zv4eNaZjqF8mwryZ/UWb/9loV5VLQ2vGiLoZkpTzsoB/96CafbNQHgYujQnLbPv41NqA
         u0xc46XFnOi84thYG2ZF9g39Ia2Hta298up9C3+0GggDTESrXX0BzuZ6y5F0ffYdsld+
         TUDPZTIXKunk8VhE/1tXjggXgqjvN+7QrHaSSaS/vW3PZtRCDyJc05t095KwzEw6sGrP
         ElpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959197; x=1716563997;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ0Iz6mAJE61rWHZ5SYis6nQnIUkMezcTOB1z3PJxiI=;
        b=mLgW0fDGWe+vyiCDPWv45MTYVSTVqlCvbow+pVeqjeCWHwMTZ3lRCzDi51X1Zs4L/a
         mtBGZKM4v3eYcdG3QvK7YlK4SaONmD8FpMLHrJP78f9KfM3m3sMPd2ryUAusjUuLOlh4
         pjxJs5i9dJ6hU4plgivBXTQX71lGUJK5fP8ryg/7iqWffWmsmsxuxqoqsjrd83lRISKl
         omnDkJYpE1r7Uir42Md9tRTQdICEMhUdyLxxpS39+QP2BleMohQMReFC3kHSJhB5hSlK
         k2FBzEwmYxBLTi1wzJs9CzpSnyD8G1cO7LrC+n6vshTpPQ03EfTaigJHUnQeBeBjT/tR
         VywA==
X-Forwarded-Encrypted: i=1; AJvYcCV8FIqs5cUapxEIuZMCfhrWWdGwqpIQUV/OfC4HVsga5CBBlK4zwql7cNSyXorWrwqUEBSeu5QZsoe6EH5D/leLFTnDsWxvUyXTiINb
X-Gm-Message-State: AOJu0Yz4p7nEQC1v7zsWftZ+JTlyctbTZLwVDmAMdEDPvfqMDIWRE8XV
	9ZJ4N2uufq/K56+N3o6ndAWPZChzq7kVg1hhotVpRGLsNtOG/uU/
X-Google-Smtp-Source: AGHT+IEPDw2jNZAjH5SFORpLIpWw5Gc3E2miJhhdy07+5Uilj6m3u3oOZ8YduqzjcOSbdOcNh/g68A==
X-Received: by 2002:a05:6a00:1826:b0:6ec:da6c:fc2d with SMTP id d2e1a72fcca58-6f4e034853dmr29486149b3a.23.1715959197282;
        Fri, 17 May 2024 08:19:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fe07sm14822746b3a.216.2024.05.17.08.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:19:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <785b652f-3f62-4bf5-aa4e-28d24ff22b49@roeck-us.net>
Date: Fri, 17 May 2024 08:19:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] regmap: kunit: Run sparse cache tests at non-zero
 register addresses
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
 <20240408144600.230848-5-rf@opensource.cirrus.com>
 <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
 <5cccbf9e-d706-441a-87f9-578975f8e81a@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5cccbf9e-d706-441a-87f9-578975f8e81a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 04:28, Mark Brown wrote:
> On Thu, May 16, 2024 at 12:53:34PM -0700, Guenter Roeck wrote:
> 
>>
>> With this patch in mainline, I get lots of errors such as
>>
>> [   23.494308] =============================================================================
>> [   23.496391] BUG kmalloc-64 (Tainted: G                 N): kmalloc Redzone overwritten
>>
>> Bisect log and first of many backtraces attached for reference.
> 
> What's your kernel architecture and config for this - it looks like
> there's some sanitiser enabled?

I have CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON enabled. I also have
various other debug options enabled, but slub debugging should be the
relevant one. I see the problem with several architectures.

- arm (all variants)
- arm64 (little and big endian)
- loongarch
- mips (all variants)
- nios2
- ppc (all variants)
- riscv (32 and 64 bit)
- x86 (32 and 64 bit)

Guenter


