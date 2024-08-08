Return-Path: <linux-kernel+bounces-280188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524E94C6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DA8282C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1C15ECCD;
	Thu,  8 Aug 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGaWCErp"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63F15A85E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155334; cv=none; b=PLJzMc2Vuqzxzr5362JUqM7aftzjpBwvgbzNEjXbqy50eN7bHTI+0Vc/dL9R/a7QFoN+rQ54oSgueGOI94MfDkn4zF4dsNnsneZsN+IYcMlS82/6+LSAicKhd8oUJicEH5Oisc1ke+Ty5e9mJ7yA5xS4jqglYmayGLo2IMSvV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155334; c=relaxed/simple;
	bh=9zyI8z68fzGopxERXuoou68ly0ANfcjbaOMAP0dK3KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBXZn1vVucKuKoHO7pwbZrq5F5a+s6C+8muOEN9HNDNrYQladSOYRk+0rdtq+SGiT8dwuYnPb7ZkdqhkqT8bwvFWKUv3sPKpoKrfWDGiZdAUiUKMrh8Off4mXsovVVgIt5mvSMCYUkGFwxqOxIs+patBve0l1TwRSPLbEEjejnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dGaWCErp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso1142321b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723155332; x=1723760132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iBpvKT+iFysA9eWtnAKgSqQdT+LODIrwOig/KiWngE=;
        b=dGaWCErpmRmpYzAKvBKKeqYT3BJNiQFPt4x3xybIXfMfU+8bzdXvQPOGm7SAYAbNuM
         /ek3tEZv0za8sMflVtRwVL4JPyXoCFE6ZoxDC+aS9NDx4DGSc4qC7xctQzP7UgOS5Jyj
         bAW00EscBOcYumhhfHwDhT2Vrv3cWMSHCXGps71OTTjzzIptC9clNe4bBzcc68k/yQvq
         6HBTjpP6UzuXtBG1FwATlYamhfn+3tMCsnIOzQpD7r+ajnfkVBwxFDLrIzFoKxjrhy0n
         4K19vsYXxNhmb3noxWJPFG1uOb4MGSyMIOC6n8ExXfh6Pt/crfMgEuG7elJ5JZSXWenM
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723155332; x=1723760132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iBpvKT+iFysA9eWtnAKgSqQdT+LODIrwOig/KiWngE=;
        b=FB80n3D91DInYkV9iU72/UiDLsr4P4lzSnsHlBl8uBd5j1whmSIAvYJroOeCmE61oT
         Omb8Kz4BgxdqxeaYKoDDYWtk/1nOlOxBZI2uozy/eEMBLwuVc18YjrnmLrc/S93PysNV
         3kTszIf3F+ycLN+vEA1Iiu5a96dgUrqAtF8Td3XppOPryaU8pCjnXWtxPBRJxa61uCp9
         BqoJDsSmdLKpStwe5uV2nB+gIHnW2/iKdh8W9rpJR2X+vJWK6Aokt5pbMThiY1xPvWmT
         4q3F0UltShhQIGcfWAaF7E6hF1gSujSLcC8W7WapK6KMJoXhTl1g7DRzHVi2yfk1ftlA
         VJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb3SwnwiNAq16xuO3gfbYgsGdsL7q4QoFzB7Zhc6NPpVYTqjTzKNmPwEYFyP6O5+fRl/PNt1CpCXraDGAJPl13MX9TkWHceaGG5ZYI
X-Gm-Message-State: AOJu0YweSyhEy7r7NN9NsCb7PNfHkilXfwQTc03OESh9cBJqFXxwdfE9
	vJOOSkYocAZwNB8cetCbTtE7tBXeYzJfcENbFQeL0R+aUISDFQy1611OnR+nseQ=
X-Google-Smtp-Source: AGHT+IHgMqHjegz55uVNn5igSOB+CNCSyR2o/Xgh4++y01uQn3EOrmtnuc4nV7d/X4ws8d9zYRhCWw==
X-Received: by 2002:a05:6a20:7349:b0:1c6:ae03:670b with SMTP id adf61e73a8af0-1c6fce82c9bmr3926689637.9.1723155331645;
        Thu, 08 Aug 2024 15:15:31 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca796fsm1767276a91.30.2024.08.08.15.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 15:15:31 -0700 (PDT)
Message-ID: <c2c2ab07-8f24-44c2-ab30-dbe6c2c5fde4@linaro.org>
Date: Fri, 9 Aug 2024 08:15:22 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx>
 <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx>
 <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
 <eba27c56-dc36-4410-bb6b-cbe8769b8a6d@roeck-us.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eba27c56-dc36-4410-bb6b-cbe8769b8a6d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/24 06:52, Guenter Roeck wrote:
> On 8/8/24 11:19, Linus Torvalds wrote:
>> On Thu, 8 Aug 2024 at 10:48, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>
>>> Here is the disassembly from my latest crashing debug kernel which
>>> shifts it up a couple of pages. Add 0x10 or sub 0x20 to make it work.
>>
>> Looks like I was off by an instruction, it's the 28th divide-step (not
>> 29) that does the page crosser:
>>
>>>      4121dffc:   0b 21 04 41     ds r1,r25,r1
>>>      4121e000:   0b bd 07 1d     add,c ret1,ret1,ret1
>>
>> but my parisc knowledge is not good enough to even guess at what could go wrong.
>>
>> And I have no actual reason to believe this has *anything* to do with
>> an itlb miss, except for that whole "exact placement seems to matter,
>> and it crosses a page boundary" detail.
>>
>> None of this makes sense. I think we'll have to wait for Helge. It's
>> not like parisc is a huge concern, and for all we know this is all a
>> qemu bug to begin with.
>>
> 
> Copying Richard Henderson who recently made a number of changes to the
> parisc/hppa qemu implementation (which unfortunately didn't fix the problem).

Wow, that's quite the agile bug you've got there.

You can eliminate one class of qemu bug by attempting to reproduce in qemu-linux-user: 
arrange for the page crossing at the appropriate spot and see if the split between two 
translation blocks causes carry flag weirdness.

If that doesn't reproduce, then I'd be likely to blame something in the exception delivery 
or return process.  Still could be a qemu problem, but it would be something in the system 
emulation of the exception path.

It should be possible to write a small system mode test case for this hypothesis.  Ideally 
the itlb miss handler would be as simple a possible, e.g. computing an identity mapping 
rather than using real page tables.

Only after that would I start digging into the linux kernel's exception paths.


r~

