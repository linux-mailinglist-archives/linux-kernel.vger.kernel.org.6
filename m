Return-Path: <linux-kernel+bounces-283457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C35694F530
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB37FB22B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ED3187552;
	Mon, 12 Aug 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GQUCKUGK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E9130E27
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481266; cv=none; b=myg2rzR3jMU9ryMkY5BNwEpqxECeh+weSfEMXWhWuR/e2VS7RCrBIXQ3ZAN61lxt9uPBtxgs2NWY5RNRzcHBXz8AWr5JNTrtqiTVwGnfM7e1kmKNj1RlKAgLHhsID2jT+EZLZdM9F50+juVAHvPJl7Z2IVTj5LTClRqe3DRw5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481266; c=relaxed/simple;
	bh=dvVG0rsyTzj5mqsxi11/XWlFc+7NA1zur2Arrxl7HdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU7O11QS67uluqjmYUmIxzA5qMBDkCtgSzoemq4njgrs7ogHZGbnJZoJ8F2+B2W5mKF3tomn5ZdPuE/HLz3xc+Q3VIKhNMX+HHULVsCc4INMHha/QdbgWJyAGIv1GZ+2qFYYjeKGKeXo+dzAVmsjTfeQGc9OmFSkXMRFphvPL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GQUCKUGK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd6ed7688cso39173745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723481263; x=1724086063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1gGdvqcddohTVFT8kQob0xd7CgQ7ZF2Hz/Ht3G6YiU=;
        b=GQUCKUGK1UkE6dGYTSe4HwO96ytgn7Psgcz/r+u38ndSdQIXkdn63K27EsG78sOa0M
         tgCwQQGWY2k+OVZXLCse9Xo4ROVA3PPGDMHcWkZZUHhqkJDfRCNCgS+W4o83avB3OLmy
         ys8y0vkS8Y3r4tsp6JngAQ6KS0v2ymIdWbBYoEZOYZYBLsp3vgRqQMXHhV0eq6Su3K2w
         I3UqCyqlpAGwa5ZGD8bal2XH2Rs/+ND93onbs+PHx1u38W37DDpH2Vt04R+h4HBNDNf8
         /rr2s7Yfc9ZsqM2vregNZ/5Jt+PF9hJJZuqsLVckFdk2OjanN5+yVB058WjqL+j4vL6w
         Q1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481263; x=1724086063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1gGdvqcddohTVFT8kQob0xd7CgQ7ZF2Hz/Ht3G6YiU=;
        b=dpxb6OQK8tIcDboqbH7f2Yx/PzboC7aqS+e3gDjrwD3eAbnvG8DXeWGYMYgNJdx4GE
         gdYTgYgH35kB8+YHzaCRPaAt6DwwAzshAxnoSKjAfoa2Iwx8xicFkgXNpoRssndvIgxT
         EZFcG7oNwAf2h61KEFIoQ9i/K+a3tixE8QXitWdDk3/rddNSsyGFb+svsiItU4+TPOx3
         8tUIkC8KFoFI3ASXeXg3ETa99+yAY8TIZUc9uGwPYY1ZOKb4ncxBzUwAlB98URWIX/gP
         UQoFwbjDcWlY/j7oSA7NtI+yX43TjA/iT1txzE0/CGXd+HKx00qOakRAJKHrdczV7/Jd
         KCkg==
X-Forwarded-Encrypted: i=1; AJvYcCVSMsMjPq2jWtdU/d7k/cVh1UL0B8U235/fzCsf6YZ9FMCBGm4kXTUzS2LlBre3Kjv31YQ8rxWrX7R28guYLh2Zkq7K7rFt6QrQ2lIQ
X-Gm-Message-State: AOJu0Yw7JlVtil+JUw4xnlcJmG2fvLmPuvFdRxQ5xH27Em+r1ROOA6zM
	g7bbOlIQeeCVVEr3c9haow91IxlTVTqvG93N/5jlNEFLyJRnT6AmyWiCe129gAs=
X-Google-Smtp-Source: AGHT+IE87fk8grq8YxzQ9ZqK4uANOdymebfW6zNzfLJz+Z6OjMVTMLP9gdbfzi43oiHSHopfRLN5Zg==
X-Received: by 2002:a17:902:e80a:b0:1fc:2e38:d3de with SMTP id d9443c01a7336-201ca120563mr9639125ad.7.1723481262725;
        Mon, 12 Aug 2024 09:47:42 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb3b2easm40030505ad.284.2024.08.12.09.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 09:47:42 -0700 (PDT)
Message-ID: <72e49c54-6473-413b-a4b4-4d0d67a41923@rivosinc.com>
Date: Mon, 12 Aug 2024 12:47:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: riscv: Add Zicclsm ISA extension
 description.
To: Conor Dooley <conor@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>,
 Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240809162240.1842373-1-jesse@rivosinc.com>
 <20240809162240.1842373-3-jesse@rivosinc.com>
 <20240809181536.GA976083-robh@kernel.org> <ZrZmTvJgyQ5nB70H@ghost>
 <20240812-rogue-enable-9194afe10621@spud>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <20240812-rogue-enable-9194afe10621@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/24 11:56, Conor Dooley wrote:
> On Fri, Aug 09, 2024 at 11:56:14AM -0700, Charlie Jenkins wrote:
>> On Fri, Aug 09, 2024 at 12:15:36PM -0600, Rob Herring wrote:
>>> On Fri, Aug 09, 2024 at 12:22:40PM -0400, Jesse Taube wrote:
>>>> Add description for Zicclsm ISA extension.
>>>>
>>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>>>> ---
>>>> V1 -> V2:
>>>>   - New patch
>>>> V2 -> V3:
>>>>   - No changes
>>>> V3 -> V4:
>>>>   - No changes
>>>> V4 -> V5:
>>>>   - No changes
>>>> V5 -> V6:
>>>>   - No changes
>>>> V6 -> V7:
>>>>   - No changes
>>>> V7 -> V8:
>>>>   - Rebase onto 2d1f51d8a4b0 (palmer/for-next)
>>>
>>> Please also put the version in the subject. '-vN' is the git-send-email
>>> option to do it for you.
>>>
>>> Rob
>>>
>>
>> These patches were originally part of a different series [1] but are no
>> longer related to that series so I had asked Jesse to spin these off into a
>> different series. These version tags probably should not have been left
>> on here when made into this new series though.
> 
> I dunno, I disagree. I think the versioning should continue on being
> split - especially when there's been tags provided on earlier versions.

Good to know I should keep the version number when splinting a set.

Thanks,
Jesse

