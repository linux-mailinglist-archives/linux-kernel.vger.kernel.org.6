Return-Path: <linux-kernel+bounces-387372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC439B5011
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05241C22A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB71D79BB;
	Tue, 29 Oct 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJSncrlj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10417D355
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221537; cv=none; b=esamotnghZSxRJCKJ2vhoSaeKypGq3j4y4KQtin11bycjbO6b1WybohSzwgdX7zWztBTyT/tXrjZoLqIIIRLA+SnUzpZrZfT94oUHseayeAq60qQICVpW6nGM6A8n3IxDEwWXPwSj1sbmXKDXEbC6sDeRRGr3M/zwJScJ7HtOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221537; c=relaxed/simple;
	bh=iPmAFEvO+sDcEGLA6dukBMLTp9fkP6QG8tH3ixPztVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBu0RhkJxrPCEWD9MijqV7zNWGdu1UTeK/sL6Xi6PUiTDVXQSRVpSLPw5cqORu/di2sUroAE9saNzgd8qA36bL8SguL6uVkwAGoiNjxhIPP7Lp06InT6TkJZICAViSHxwXY0zGJ8Z2RYNbDSUDFQUkxv/hfcrJqwILIYzaVg06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJSncrlj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b533c6865so5237325ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730221535; x=1730826335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ri7MEvCu1YimVlmWq4RcIi4fsfAsB9YQsSyk/h/+zFk=;
        b=JJSncrljYj+DYHRkqS0Ct4/mn5bseFLa/JRskbf1hEcNFCBCxLWVeOpnjsDR8EVt+l
         X+JbBnIzjIe72xh2/Rgzu2bbN+B68q5cVf4XzHfxGmwo4D0Mq9z6PSyyzeQNsxDD5luv
         Kc3SS6W6z91ddIqDqX+q9F8KpD0XO72+RoMiRYQF9YGIb05BD8qgFW2Tz4PzFcQ65KEa
         bqNrtMsVoMtPGepjoCGMzpn4oNOohzLA+YuoUM5BB25P3DpBZ7dqqKlNh7wTX16gccti
         jPYOsp/AdH0L9JwnlpP4iZyEvnc7pgnHz/M/Mlfk+GYe86cLVGLfg6F1RqpqSiyr2Whs
         qoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221535; x=1730826335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ri7MEvCu1YimVlmWq4RcIi4fsfAsB9YQsSyk/h/+zFk=;
        b=i8z2fAf6z/H/SwNZU1/jWy8OUA75W8o86maKHew6biWLaDLa/GUsAzl82G2r8gojz4
         VR+LxuFkrqwzMupndZHMQ3vSG9+0PRCHlsS6WaAlb7qeW+KWICMhRPA0u23sYdy1UHL6
         2hGpxGMjjjzhbGhSfJNRE4GW0sI+B4C1vCOw8z3Gy/G73lWL1BmfoBtem6MYd3tFdy7c
         YkYUEUv45n72wlCzOhwEumM088F2Km55f8sMv8hVuoh5n/guSjni9ZibM3V3Ht0/XJps
         kQwQ6UNJQ+sphat5q1wHAqbVD2lEhaacokUgo/QBheJ/OT8/YpaYSTVQTk4FhYSgp2ro
         f4cw==
X-Forwarded-Encrypted: i=1; AJvYcCVIMvVk6PkJRbwEyGVQGp2JiIUyBk0oaernq8Xp3Sszeuy4uFTD00N7NK/p0elqH2QrXM6Haqbh+FR1Vmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7t/73kRVbGZ4AJCHegbRzXGzm6InweeiTt6nZtwTEUUIF3qu
	gnPAZYCDw0QSiWVBCOhJ6pVv7nus9aeDmL0fSmvzeeFXY1tWmUzs
X-Google-Smtp-Source: AGHT+IHT5/roU/4mSk/m+oKx+/csSBDyCP+jJiFd98PSY13Rg95wM5KFEENyo902h9hqdsGmjTpOqQ==
X-Received: by 2002:a17:902:e5ce:b0:20c:da9a:d59e with SMTP id d9443c01a7336-210c6c6f398mr70539565ad.9.1730221534582;
        Tue, 29 Oct 2024 10:05:34 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:e12b:a9a3:6d06:6d0a? ([2402:e280:214c:86:e12b:a9a3:6d06:6d0a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210f6a461b2sm1908925ad.169.2024.10.29.10.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 10:05:34 -0700 (PDT)
Message-ID: <3d38112f-9235-4643-ae2c-ffb9fae7a5d2@gmail.com>
Date: Tue, 29 Oct 2024 22:35:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] drm/amdgpu: use string choice helpers
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, tao.zhou1@amd.com,
 kevinyang.wang@amd.com, Hawking.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, luben.tuikov@amd.com,
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
References: <20241027140537.503264-1-prosunofficial@gmail.com>
 <CADnq5_M4QwRfROybHrQfNuiXNhHH7VFAUVZMWkriwZs7K4KLUQ@mail.gmail.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <CADnq5_M4QwRfROybHrQfNuiXNhHH7VFAUVZMWkriwZs7K4KLUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/24 19:11, Alex Deucher wrote:
> On Sun, Oct 27, 2024 at 10:18 AM R Sundar <prosunofficial@gmail.com> wrote:
>>
>> Use string choice helpers for better readability.
> 
> I personally find this less readable, but if this is the preferred
> method going forward, I'm fine to take the patch.
> 
> Alex
> 

Hi,

Thanks for the comments.

I came across this comments in string_choices.h files, where 
str_read_write() helpers are present.

Using these helpers offers the following benefits: 

  1) Reducing the hardcoding of strings, which makes the code more 
elegant through these simple literal-meaning helpers. 

  2) Unifying the output, which prevents the same string from being 
printed in various forms, such as enable/disable, enabled/disabled, 
en/dis.
  3) Deduping by the linker, which results in a smaller binary file.

Kindly, I'm leaving the decision to maintainers.

Thanks,
Sundar

>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Julia Lawall <julia.lawall@inria.fr>
>> Closes: https://lore.kernel.org/r/202410161814.I6p2Nnux-lkp@intel.com/
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
>> ---
>>
>> reported in linux repository.
>>
>> tree:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> cocci warnings: (new ones prefixed by >>)
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity for str_read_write(read)
>>
>> vim +145 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> index 35fee3e8cde2..8cd69836dd99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> @@ -200,7 +200,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>>                  dev_err_ratelimited(&i2c_adap->dev,
>>                                      "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
>>                                      eeprom_addr, buf_size,
>> -                                   read ? "read" : "write", EEPROM_OFFSET_SIZE);
>> +                                   str_read_write(read), EEPROM_OFFSET_SIZE);
>>                  return -EINVAL;
>>          }
>>
>> --
>> 2.34.1
>>


