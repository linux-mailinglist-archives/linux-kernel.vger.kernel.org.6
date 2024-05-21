Return-Path: <linux-kernel+bounces-184856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990A8CAD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B441F22839
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91974E0A;
	Tue, 21 May 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMdkcpFZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EC74BF0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289456; cv=none; b=cnoByeBo+MPeNP5cXj0opXqVN9v0dxchnvpCF37WJaNV1JHmPWWXT1o9fVwCCqoXJ6ZsZTAR02mgb8r7m4gtpDwSrX8mf1WTEIfn7tYncKZU16YN587OFyABz2rsRTwjh81IktJ+cNH4NthBUykH1VZvhIClGOHLzGAtc5Eeu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289456; c=relaxed/simple;
	bh=+IKlBVlD/h7faCTONpWveY4gzpLBM4zKzUbzCl6In4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRib7b2AOUH9z7A3jLhiEldDOQ8y9nfoXBGEqNc1qD5Lmv/jQfliBCYaYbV9/TIA3miHCxri22QuK4rhD4oPcw/vrgTciwDZW0JaFVgjfMRFmifC5KAAlVpb3MUZrE4OPPmCUABZBf30f2JNxXNq9E6FVhcAA9OcisDRoSVbFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMdkcpFZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34e28e32ea4so2924043f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716289453; x=1716894253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSXIhpVryOt7s4zHDJSLS8LgF9+/tvqxquQt58i9klo=;
        b=aMdkcpFZJUwHbEPmL8IxgngLw6+8QiztxJJRibfVcuG4A36Hn2c9AJXNhF7Z/ItFBy
         ePwiu78HbY/RiTzSwWC0q3U1//KUsYRzQtbH9qWwmQ3HnAoxQ4j+vWdqoScf80iEVdhI
         LlPVMyG9OvVeyUWdNybA/ZJUwSSFW7KBaING/FzzI15NIeUw5R3XQmVRCQUhcgKXE+DP
         I+f0vH/0eG0H8q1NzoXOcfB9dzQX/OJ0T+OkNrvVV0AziRM1UXvHCJOUGwDxfrGIf08I
         xwwbOL5lFNezzX5bfwo8HcqezEyvfPlYTJgfYHit9nJli0zHCkljpwi1/5EuyAVJ5alI
         RoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716289453; x=1716894253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSXIhpVryOt7s4zHDJSLS8LgF9+/tvqxquQt58i9klo=;
        b=sF/tgk9wlASdFDxJ0i0yPI+rWU8bIoqVgLXwsWKWzoaILqAuxCm0h8OrLc3Yw5WhZs
         BZBSBxRjAK7hu2ZWF3vuE7n2VzmgE258ZJGhszhXna4rrs1aWUR4QvyPPmF195eM+RMl
         lGTG71MMJi6OVVbZ87hPSlSTiUhcF8vAYzbDYLxy+f1Af582rIdgCzqUPNfFEwZjFzFH
         sEspig8hs99iubenPu31kVQeeuRaCzHwrLsCduQz10+eOLT1GAoDfwykTB2Igf+tLBw6
         /Xg+d5akVI22RE7reOj03LomjghJHuFsH17wk+Am22fasut9lnzpZU6lmJMuwLRGWTiH
         mEfw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2UW/9B9v5Cayrsmfm7kJNECwoED8Ss4BcOzr1llJCM2JFw3k1zE5ViBh592BplXyayV8wvxvFdEdj5kW/n03vaTiRTKT/eMATtqO
X-Gm-Message-State: AOJu0YxpCVOc1WAHzruTtS/kKbviMglWm/uZkdmiyGZn3eeQhrDAk4Ki
	O/Y9/EXmu4Jb7bJ45vZMm6M4yl3Prtv5fBDMK/7PuwRIrTFbS0tz
X-Google-Smtp-Source: AGHT+IEl//NivIIcUS3kBHqz17NWQPQUFeUg+fzch19f3EUMPQ/DZUm1QYVnnrX9Wyjb4wvmUZL9Fw==
X-Received: by 2002:adf:ee8d:0:b0:354:d052:e485 with SMTP id ffacd0b85a97d-354d052f128mr898918f8f.63.1716289452677;
        Tue, 21 May 2024 04:04:12 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c7df311esm4932168f8f.3.2024.05.21.04.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 04:04:12 -0700 (PDT)
Message-ID: <d1cea1c8-bef0-48fb-887a-88d0eee9ad6d@gmail.com>
Date: Tue, 21 May 2024 13:04:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tim Van Patten <timvp@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 alexander.deucher@amd.com, prathyushi.nangia@amd.com,
 Tim Van Patten <timvp@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
 <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.05.24 um 17:46 schrieb Alex Deucher:
> On Fri, May 17, 2024 at 2:35 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 16.05.24 um 19:57 schrieb Tim Van Patten:
>>> From: Tim Van Patten <timvp@google.com>
>>>
>>> The following commit updated gmc->noretry from 0 to 1 for GC HW IP
>>> 9.3.0:
>>>
>>>       commit 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=1")
>>>
>>> This causes the device to hang when a page fault occurs, until the
>>> device is rebooted. Instead, revert back to gmc->noretry=0 so the device
>>> is still responsive.
>> Wait a second. Why does the device hang on a page fault? That shouldn't
>> happen independent of noretry.
>>
>> So that strongly sounds like this is just hiding a bug elsewhere.
> Fair enough, but this is also the only gfx9 APU which defaults to
> noretry=1, all of the rest are dGPUs.  I'd argue it should align with
> the other GFX9 APUs or they should all enable noretry=1.

Completely agree.

It's just that while the hardware should theoretically be able to handle 
recoverable page faults it's just that this features is never tested on 
APUs because our hw engineering assumes that they don't have to support 
the use case. That's also the reason why we physically don't have the 
second IH ring on APUs.

I strongly suggest that instead of doing that for each hw generations 
individually to just disallow enabling retry on APUs.

Alternatively we could start testing it on hw and sw side and try to fix 
all the bugs.

Regards,
Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>> Fixes: 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=1")
>>> Signed-off-by: Tim Van Patten <timvp@google.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index be4629cdac049..bff54a20835f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -876,7 +876,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>>>        struct amdgpu_gmc *gmc = &adev->gmc;
>>>        uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>>>        bool noretry_default = (gc_ver == IP_VERSION(9, 0, 1) ||
>>> -                             gc_ver == IP_VERSION(9, 3, 0) ||
>>>                                gc_ver == IP_VERSION(9, 4, 0) ||
>>>                                gc_ver == IP_VERSION(9, 4, 1) ||
>>>                                gc_ver == IP_VERSION(9, 4, 2) ||


