Return-Path: <linux-kernel+bounces-511527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1EA32C47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7302162E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1492505AB;
	Wed, 12 Feb 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="0/9lTd/a"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EAB250C13
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378856; cv=none; b=koBknl/cgwIKMshDdu7pU42Yt8EgTlmdufK1kBKo95Hx1ugOJaYtAc4nLc+JDTOcWipGE0AYmPvLkBMwjqZU8yGiceBDqWH3Co/FFWOBn39vx+B6TuqdcKnDd6RX2DRcFvE9x49c9prVS60Neb/jyL4odCdl4hTUKz4FC7wNu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378856; c=relaxed/simple;
	bh=rGi7U/MUxFCANynaU3unAj/JggyMGN42imfIaOSgOfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4MdsFLqQvizlp8+TIPRLm2HR4b/63P+FBAPS3wY8NYLQqSrlRVVzmGd6xsSE837XU23FRAlRJg5SzfMnTMgUDEkL9Hk/y59yLH+NWLlQ/O1q+TBSnnpd0OsWSG4Jpzfcrs5qPZGpyG/oZeAC+7O7Sz59m04VoFdbmkhxmGpS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=0/9lTd/a; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43937cf2131so29468435e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1739378853; x=1739983653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qa3lHlvYdLNFaksRYkAdLaRy9lcsKO0x9V6FGVIyLMI=;
        b=0/9lTd/a1nTbxgR02eNia7bU5QsdpPKapNIqyW1C6iavrdMDVuEGsP6gkuidMpVWjO
         JKy1Go1rMzjO4W/XISbbi/FBxDzByUSjmnf3kMkuUYX8z8kzqw9FS2e1npDAkASL6fKg
         f0dppGC9kAr/JCBxiCCZj2QyqRMPgaJurDGaDxntWoaYY1OUEg1rhDQt+0Dhxz3UW0ND
         69NOzMWTAXbpKX3kEHfg7zP+lM83gBKCRt5EnA1MUnXnalq4WG4G8IvJ9gCYRKdBzteq
         Q8w8bogr+iaLcWe6gnzwy4TDiqRA3qfJxzr6k2rR2XIuCEAGdVTkeTe0YwR46kpsaN9a
         VzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378853; x=1739983653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa3lHlvYdLNFaksRYkAdLaRy9lcsKO0x9V6FGVIyLMI=;
        b=f/wvq7c4etTXbtu0UGRNLcqnljMoDWGV603p3aE4/wnodkKFN071jeDkUvHASB0QyA
         MY7zPLXU6jX21tAft1lMKV/XIweDXdLBdBGTfHTCxprNxWb+XbYW/v2MlM0qXUS7DKbu
         xpOst1pQ7Cbkb7OHOZrmUfeAs8QaXGpHxJg8NWRg1bK/1UonmZnmhVCq8mqc9xfny2J3
         rXzvfw5rIpohMmLe+F+GMk2E+tbqug7PvGhIcVM96ymscDZLcZTaMX2/+7gVI1yUsc1c
         NCZZwz/DXnozgOcr6I+oiwHNPh9phJm2ol7rrZvon74alTVc2fZQK65GZfi1RQ1LWr9i
         gB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGneCNIRSLUhuN27LgLKGn5HcgfwqT/og6pWBtrceLbeweWanYIHvcX0SD8bOTjFnAYncgjytaodQ0jEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+GyAqryEwPGMICCeIMHy4r6lw/mOZjQvQYRp/0WnL8CDZGPF
	d8rabhbkr95L6LL78/kRgmy6EUQ8yBf+zciVNkQRJI7T5N3imiPNmtiWRXe/ydE=
X-Gm-Gg: ASbGnctjXPoRrUznbT+wqmqXA4bjQni6TbaYRGnGnUMNFQdnds5ZF6l6WuFq2NXcYuu
	GkNUI7LSfp0myfOKQLZcSco/30PNrBDm6Unas5zZqoYRfOyZgAd7jfxMmGQfcWVwMO3iCN/NEsC
	bDwBaOIxW9iqJ1jmEgDOOrMjIi5tzyfyf8o7tq6hLmnycKrHUve49XSSuwkqJYVRqUdzBWP5TMB
	Ql2or70BJsOPq/B1rfPHfpVb/WI61EgiQwx+XyJRhcm0aP/7ESQL7AUoaw0kqEivCa/BomYlYK+
	AncBRAhSas6fgI3hWBZ9fff00AjXh9E=
X-Google-Smtp-Source: AGHT+IEwx8ygIaZZRDY7oazT3QtnE2fMAh2TiojaLr2hVucu7dTdzOo+MVxVHndyN6Fo+KGkJ8h68w==
X-Received: by 2002:a05:600c:3505:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-43959a930b2mr29548845e9.27.1739378852618;
        Wed, 12 Feb 2025 08:47:32 -0800 (PST)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc3a10fffsm17117045f8f.12.2025.02.12.08.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:47:32 -0800 (PST)
Message-ID: <b0664a84-6bef-44b6-90bd-7c60e9875933@ursulin.net>
Date: Wed, 12 Feb 2025 16:47:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panthor: Replace sleep locks with spinlocks in
 fdinfo path
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250210124203.124191-1-adrian.larumbe@collabora.com>
 <2ec2a848-90f4-49bc-aaaf-8eb256f271db@ursulin.net>
 <ddnsckbpr2fcxby4i2o5xyrt3pdhornzbrvlbivuvzlyhgg66q@ejhkiz33sewn>
 <7ee0205a-6522-465b-8795-3d7b867e2d97@ursulin.net>
 <20250212173356.10f47318@collabora.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250212173356.10f47318@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/02/2025 16:33, Boris Brezillon wrote:
> On Tue, 11 Feb 2025 11:39:49 +0000
> Tvrtko Ursulin <tursulin@ursulin.net> wrote:
> 
>> On 10/02/2025 16:08, Adrián Larumbe wrote:
>>> Hi Tvrtko,
>>
>> Thanks!
>>
>>> [18153.770244] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
>>> [18153.771059] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 203412, name: cat
>>> [18153.771757] preempt_count: 1, expected: 0
>>> [18153.772164] RCU nest depth: 0, expected: 0
>>> [18153.772538] INFO: lockdep is turned off.
>>> [18153.772898] CPU: 4 UID: 0 PID: 203412 Comm: cat Tainted: G        W          6.14.0-rc1-panthor-next-rk3588-fdinfo+ #1
>>> [18153.772906] Tainted: [W]=WARN
>>> [18153.772908] Hardware name: Radxa ROCK 5B (DT)
>>> [18153.772911] Call trace:
>>> [18153.772913]  show_stack+0x24/0x38 (C)
>>> [18153.772927]  dump_stack_lvl+0x3c/0x98
>>> [18153.772935]  dump_stack+0x18/0x24
>>> [18153.772941]  __might_resched+0x298/0x2b0
>>> [18153.772948]  __might_sleep+0x6c/0xb0
>>> [18153.772953]  __mutex_lock_common+0x7c/0x1950
>>> [18153.772962]  mutex_lock_nested+0x38/0x50
>>> [18153.772969]  panthor_fdinfo_gather_group_samples+0x80/0x138 [panthor]
>>> [18153.773042]  panthor_show_fdinfo+0x80/0x228 [panthor]
>>> [18153.773109]  drm_show_fdinfo+0x1a4/0x1e0 [drm]
>>> [18153.773397]  seq_show+0x274/0x358
>>> [18153.773404]  seq_read_iter+0x1d4/0x630
>>
>> There is a mutex_lock literally in seq_read_iter.
>>
>> So colour me confused. What created the atomic context between then and
>> Panthor code?! I just don't see it.
> 
> It's actually the xa_lock() we take when gathering fdinfo data that
> puts us in this atomic context. In other words, the fix is correct, but
> the explanation is wrong :-).

Huh I did not spot that when glancing over it yesterday or so, but 
anyway, excellent you figured it out! Now the commit message can be 
fixed and not mislead someone in the future to think mutexes cannot be 
used in fdinfo. Thanks for taking time to check it!

Regards,

Tvrtko


