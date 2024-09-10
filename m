Return-Path: <linux-kernel+bounces-322802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675C972E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FD628811F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1551F18C32E;
	Tue, 10 Sep 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Pj9ZVy"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331418BC3F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961260; cv=none; b=KBfpJliOqUN5V+SxMRM5pom+x8CGQm1c+KE6/tUOdTpChetkaxGmEt/ThTKTpQVHyO6LiamXqQ+8DYpeXpxE8aCJs70CB8YHf5+FEP09oAwBHfFnrTN+bb6pASDG3WI6hGF14Ut6A2G42qtfvFVvW3wS6dmbBCBpQs0XEie1ls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961260; c=relaxed/simple;
	bh=QezpWS23xd5vJDMMNigCK5XhC99wLHRZ/swRepKuqCc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZqLSrE3SyvraV916RpIa3OsQ+bG2aovdVLRFb/7V8dLoQkUknF+negcCH4hnqQcD0mM6jxjcYv7rjrjTI7qHvXZG7rg/z3fT4yUS+ZLZzjT9VqNBUQo7YDSDytcPgqfFO3VXIZHQRL+vT+u/SIQz1kq0LEanc+pMRZJS6OoSDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Pj9ZVy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365cc68efaso3294542e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725961257; x=1726566057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fajWxBiy4PS4lT/zSjH/RDRg02stX3Be05OcCvOuUaI=;
        b=Z0Pj9ZVyB5L8eb8mRpP1bZcWFq9W9vx7hph6l8vRIjSE+4J+54+eR97I5ms6wXwx/1
         h7tVmcklDg0ANHNwG692nMggZLsajmeGtBEn183KYyvPun69tTGGDuVGsOQdKPiN57H0
         Yvy3w6EA62pU9bWBkicMl9Osm1ScLAoiTDCpM07wVdYL0NdOY7rrAqFfDtyu70LkL0Ov
         qtespoHgG5+Jmumek9mwZdfIwTCghVlpAsLS8Z60eFw0esU7qmFZML4SOaaUhTgBfqRg
         JgAGonA1TEyiLX34D0Sf4ZEhECcyGLKfU+/8/j8aNlqWUOMPHlz0PHRt/Xet3zw4zYxY
         E69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961257; x=1726566057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fajWxBiy4PS4lT/zSjH/RDRg02stX3Be05OcCvOuUaI=;
        b=WtoA6rbrGNNAV6o8FA0TY+SBreHo1vs2ecTtrAHUbiKadywNm8a8LS0ICcEcZtF3Lu
         ctvpk1p8PET4IZCUfbqPNLhED8PTsbRoH7mWnx4S6VxqFqHuPrJzypV1v7ocDOTd4Kej
         nKlY/OeED4K86WPxZPZ6UPEGWV4AEF0ltOjCfsHNb+CeKZ6X4nLAFCqW/qDihNetj6j9
         easO8RyS3vC9StnIzXukpbP/CrCPXRHGH4uYK0UE3tXQTcF4itD4lkEFS8KMLgRqOgMf
         9RwM5OHnBBMdMRHq50JiPJAyh51AyMBl/H4lH6XuFzy3wQRx1Ez/+xmym9llospeWrO9
         N4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGKSdcWdy/N4Lk2u4vIpSLOwQa25ZM6UCXbp7Y5y8birbO921BtFYaCqe7GfqzivibhBH2b0sfdURZ1tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKWLQdSvvf7UMzi4QbjDr6XbUwa7ri674ijZdAKurCs5rObDo
	ARXDoYUadyoSbabaK2lfON8MR8B2U+8MEEI3Hwv9tM5rV7e5LA+r
X-Google-Smtp-Source: AGHT+IFR8pHm2fMH39Q46tLYMV0naDybZlhCm5bcPv5GJ0t8ujY0n6ef4iASZg0nRoroU8WNUNqkeg==
X-Received: by 2002:a05:6512:1092:b0:533:e4d:3374 with SMTP id 2adb3069b0e04-53658813b0emr8796902e87.57.1725961255684;
        Tue, 10 Sep 2024 02:40:55 -0700 (PDT)
Received: from ?IPV6:2001:6b0:1:1041:b4e6:135d:cfae:1d65? ([2001:6b0:1:1041:b4e6:135d:cfae:1d65])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f870b71sm1059500e87.95.2024.09.10.02.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:40:55 -0700 (PDT)
Message-ID: <a0d77ee7-ff3c-4c63-903c-e7c9e2fb70c7@gmail.com>
Date: Tue, 10 Sep 2024 11:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:locking/urgent] [jump_label] de752774f3:
 kernel_BUG_at_arch/x86/kernel/jump_label.c
From: Klara Modin <klarasmodin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <202409082005.393050e2-oliver.sang@intel.com>
 <20240909091531.GA4723@noisy.programming.kicks-ass.net>
 <20240909105623.GH4928@noisy.programming.kicks-ass.net>
 <4a554ab4-b53b-485f-beef-96001100511a@kasm.eu>
Content-Language: en-US
In-Reply-To: <4a554ab4-b53b-485f-beef-96001100511a@kasm.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-10 11:39, Klara Modin wrote:
> Hi,
> 
> On 2024-09-09 12:56, Peter Zijlstra wrote:
>> On Mon, Sep 09, 2024 at 11:15:31AM +0200, Peter Zijlstra wrote:
>>> On Sun, Sep 08, 2024 at 09:06:55PM +0800, kernel test robot wrote:
>>>>
>>>>
>>>> Hello,
>>>>
>>>> kernel test robot noticed 
>>>> "kernel_BUG_at_arch/x86/kernel/jump_label.c" on:
>>>>
>>>> commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7 ("jump_label: Fix 
>>>> static_key_slow_dec() yet again")
>>>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
>>>>
>>>> in testcase: boot
>>>>
>>>> compiler: clang-18
>>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 
>>>> -m 16G
>>>>
>>>
>>>> The kernel config and materials to reproduce are available at:
>>>> https://download.01.org/0day-ci/archive/20240908/202409082005.393050e2-oliver.sang@intel.com
>>>
>>> So the whole thing actually boots and works on my real machine, so I had
>>> to resort to using this qemu nonsense, as such I did as instructed in
>>> the reproduce file.
>>>
>>> I build the thing using clang-17 (for some reason debian is shitting
>>> itself trying to install clang-18 on this machine and I don't want to
>>> spend the day fighting that).
>>>
>>> Except, once I do:
>>>
>>>    bin/lkp qemu -k /usr/src/linux-2.6/tmp-build/arch/x86/boot/bzImage 
>>> -m /usr/src/linux-2.6/tmp-build/mod/modules.cgz job-script
>>>
>>> The whole thing grinds to a halt like so:
>>
>> Since I'm not able to reproduce, could you please run the thing against:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git 
>> locking/urgent
>>
>> and see what that does?
>>
> 
> I hit this bug on today's next. Reverting 
> de752774f38bb766941ed1bf910ba5a9f6cc6bf7 and applying the updated 
> version (6b01e5a8c11611a3dbd3d9efd915427cbce9352a) fixed it for me.
> 
> Thanks,
> Tested-by: Klara Modin <klarasmodin@gmail.com>

Sorry, this should now be from my usual email.

