Return-Path: <linux-kernel+bounces-558141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C7A5E22D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4C41897EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B851F541E;
	Wed, 12 Mar 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbhsNF87"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80718E025
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799101; cv=none; b=jC2egMcmJqkpgLZxidzO5Zf91UZMBMdMfzptYgeXw2zvHfayYSqXpmkcoEBWeYgrcEQugal3JBMej5g70nzfjK4rWEQmTFQv824+m13J5lBMAXtlja/9wn1yZ5oithOJsoUApz1wxZj3+oM8k8wrsBLh2Ph/6Cjl7BR8WHfHEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799101; c=relaxed/simple;
	bh=nX86hHp1qdiOkLNhsNCma9PDRneRB/+gKu1EhJWXeZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2/vtIGf1HWJXVZX3+ehfRLpd946I0Z2PCx5wn/2EYHcrmp57T8r85/A9jB8Ts0vwEofosIP+b6aAMltvkEM2pOGgsaj+YEGhjyvS98R/xhLYLqCP4RLrg+2Vy2KyymSN6sLida4ksXWhhgikMGTzVLHE62atn0x6EBEAxUVlZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbhsNF87; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2c663a3daso17686666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741799098; x=1742403898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nX86hHp1qdiOkLNhsNCma9PDRneRB/+gKu1EhJWXeZI=;
        b=TbhsNF87hs2VFei+kokO2hGZlJnev97d4rTL3olEshERlLSQH70RTQW7vLeUCU2PLE
         55ukX/9eXreT1A8QOPNNOF9JGR4upDojDNR9QUkIqATYgpSKObHZprCj67ra/QLtkttO
         BQzAkoxhbrpEQjjfy/rJZiEFfWJZGVjs7BnitTi9a3n0howbjwdR5dXZrvhnV+pZ6yhv
         Bm5nY4r/rKkIuKoaBHscdA6zLchmYVwPrjwCCQb7G3ciZql5U2WWQ2O79b3yj6vopGd/
         qg++R1PzZS6zmduviSai/mOiZ0F3lCggXVgDI8VXdzDWN1lmCKn2pR3yIn0xULTn9xJn
         3vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741799098; x=1742403898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX86hHp1qdiOkLNhsNCma9PDRneRB/+gKu1EhJWXeZI=;
        b=EQCeWQXxzOGp6FfpeuEobrHND6jOWVkgIhlR5SdpJswvbwAxzJ6/x/6Imz9Bkuer4F
         rT0yXhAsSIauGMfLughapqpjD4uVvd/MbXpFOsw6AFpJiCUJ4ZtEjy+jfCejYnZZKQY3
         gdvA+UOcZJLz3MjIvOJ5dVs2e8QL7oUfq7XXa/mxPnGxbLg+70aRqcYnzztETmaRyIEH
         uBfvQXBywGW+7xM4/lDKbPWqAMuCgBal9P98G+/5cyoNq0Csy+HIbZ3P8juXsR34jVlt
         5rNsrnUtWhWLfZwozGh9Us+ooO7kHHKXgyt4prnLteCoX4ywj35wJmS7NJL8vtL0dZ9m
         G1fw==
X-Forwarded-Encrypted: i=1; AJvYcCXYIM1AIm2/HOYyTtojn0LH/Rcqke7bGJpYMsoI6caXOwY29E5xpgoKKuR1f9JPsfpe5uJnOlgnLtc0CD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5bYdLHv6zHbYU0OyuhhX8UyuRs17OdKbdIXD3EKrt2umJr9v
	jYRl+fEzYCeopc1K1Lsg7V6EaKUkG4B7EcKoRiNo3jX9OepGfM++
X-Gm-Gg: ASbGncujj6x35mRwl4bYF6bUPw0nRNrgLnjnQbYopdJHrR0G1FLxEWWO3lqF8v7QuZo
	HqUpgr5jqi6FAfYmTjMBtTtGiH983G3xqPgv1ENcZFHxywn7D8QH3spAoo3Ud/urmB8Lp65YUCS
	Et71joguiR0dq4ag1K0QHfc18l5oGO7Z+xdWZbj8iRaBprKDpv+MgnqLF0lc1UX8eRUQAHN15PV
	CkB7pxcDBoUeGD65Y80Ln85RsSrsKnh7muIhWMVkC024cdhXFXnNxuTlsmPRirNJeXT5ERg6RD9
	WXNsqX+pcvvfAJUHSrtvmDO5PazgquroDInkCmkANQxXJe98pxMm
X-Google-Smtp-Source: AGHT+IHr0VyU5sTMf/ZLGSagxgxpron7nn6L2XMbdy0O2tsLvGm/2LBGnY0KL6Sdx5iVf+sTBQbakA==
X-Received: by 2002:a17:907:2d20:b0:ac3:aa7:fa0b with SMTP id a640c23a62f3a-ac30aa7fbf3mr59796866b.53.1741799097251;
        Wed, 12 Mar 2025 10:04:57 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a27d2613sm507862966b.12.2025.03.12.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:04:56 -0700 (PDT)
Message-ID: <356a4c72-2155-47ef-9ee1-180b861b94b1@gmail.com>
Date: Wed, 12 Mar 2025 18:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to
 v1.4.0
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org,
 "Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
References: <20250312111915.2970032-1-naresh.solanki@9elements.com>
 <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
 <CABqG17im5hO7xv-r16mFhJwcXyXt-6OKA_vTaRdc7kuQrdZyzA@mail.gmail.com>
 <130308e4-b9c5-4e6c-97d2-c36f9edc1f43@gmail.com>
 <CABqG17hBviQ64jXgZ1fa5+ir37YPyK62LZvMgrSGADOxSTFo-w@mail.gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <CABqG17hBviQ64jXgZ1fa5+ir37YPyK62LZvMgrSGADOxSTFo-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12.03.25 17:56, Naresh Solanki wrote:
> Hi
>
> On Wed, 12 Mar 2025 at 22:09, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
>> On 12.03.25 17:03, Naresh Solanki wrote:
>>> Hi Gyorgy,
>>>
>>> On Wed, 12 Mar 2025 at 19:47, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
>>>> On 12.03.25 12:19, Naresh Solanki via lists.openembedded.org wrote:
>>>>> -Upstream-Status: Submitted [https://review.coreboot.org/c/flashrom/+/51960]
>>>>> -Signed-off-by: Khem Raj <raj.khem@gmail.com>
>>>>> -Change-Id: I55c4e8529d36f0850dd56441c3fb8602c5d889fd
>>>>> +Upstream-Status: Inactive-Upstream
>>>> Is that really the case? I mean it is just being updated to a new
>>>> version, it doesn't look that inactive. That PR seems to be abandoned by
>>>> the submitter at the first superficial sight, is this not the case?
>>> Yes. its being inactive for long time.
>> The last commit date in the main branch of
>> https://review.coreboot.org/flashrom is "Sat Mar 1 19:19:16 2025 +1100"
>> - less than 2 weeks ago, with last release just before Christmas. It's
>> not as busy as Yocto, but doesn't look abandoned.
>>
>> Or am I looking at a wrong repo?
> Your right.
> I can work on flashrom 1.5.1 release. Please let me know.
>
> Thanks,
> Naresh

I was mostly interested about the Upstream-Status, thank you for the
confirmation.

I have no strong opinion about the new version - please do as you see it
fit.

>>>>> +
>>>>> +EXTRA_OEMESON="-Dbash_completion=disabled -Dtests=disabled"
>>>> Nitpick: Could you please fix the whitespaces around the equal sign?
>>> Sure.
>>>
>>> Regards,
>>> Naresh

