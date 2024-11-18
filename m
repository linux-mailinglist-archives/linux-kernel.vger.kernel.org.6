Return-Path: <linux-kernel+bounces-412906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3E9D1101
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169AEB23A35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB21993B9;
	Mon, 18 Nov 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QOMzIOTv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E81190468
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934458; cv=none; b=E4bl6xUFPJx6WNjLbwFwyvfTaUrjh5icZBk2GpWzT0CPd0SPZFd+bCfgOGJmYNCykQxWpkq+vsIkn2KH8thSjYpOZKgJMDeWgcUKYAfL4Z8bdoUX25T479DUbWkYj4py+6eue1D1KkdAHkGxoJZCYO6c/D6IqPM3JbwMOA03/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934458; c=relaxed/simple;
	bh=JsiQ74lSJhEvKUrChcF8WIs8NQWZMLgUUxS86s/3s7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxHApl9fkGpXavZtV7I7OlomPtC34Hl0v+zjhY7osn8Ue7Oe9dvACJsSTHtjLhXTClIi/7mB3bvvhwiQPfwhNW83iazWO0fW0gQbCiaiHDknSc2SoYEe31ZgCA1mlFzzR5N0aFpRyhajePVVDf/65k831nH+jWpiYvmvNtSq8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QOMzIOTv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-432d866f70fso36251215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731934455; x=1732539255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75HTXdXjmxNI1/MMWma5rxHneXLyGS9ZEHRlSoUGgbw=;
        b=QOMzIOTv9vsXBnlP+P2xGuKEluuoWkbYwx1jONnyBfki6RZxHVYQHidh7yaheGRYpT
         kJKIIqWA2KqR4oK+ovqsuzOr1aHO9t9c9u/k+jwNlSDKUEzYvK8ncbg2hhbCPskluiS1
         zNpQ2sKbSxCYtIwRYEloGY062QscE1jm52SfrYu3x6qI52Lb7q/0c9K3tUHfi3eCg5Rw
         bo5Ko780RcBi+P4Wd/LiE0u0sTWbeV0KqQiVhFY8C4srZQwU6NLXwptGQH3x+7qVSdHU
         hwx+O6q4sU61dFqekKWf312CwBgIwUNTFhTelZV83A+HKO6uwQ14gpvM+9rBKoJdOGcN
         50iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731934455; x=1732539255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75HTXdXjmxNI1/MMWma5rxHneXLyGS9ZEHRlSoUGgbw=;
        b=eb1zYR7Pbmanri00QGqHOd6H+Y2/pKU+NI7J+0RZ8hzqY9gR7xNJZo4F2d3DtSy9pe
         KRk9ursMImj0VqhmvaGhF/K/dCe+cDBDaBP3kaoVZmtA/lJ1czjR0AWb+OgKLGsM5BcR
         Qwxa2ymqLt2OztRAzqPTsRLCa5r3hjcSZYPVMk9p4Qu/4o/L71ANXY37b7FBJVR/+jlj
         bIDUHlQlXZZOe6kvuuDQ4lZypW500tDjqINOdvEEDi9fRsz7Oc+9Ccf6IZyjA/g3CDT3
         ywg0p8hGytj7sgSOyV0vX80kK0ltKhJfFm/MAFuVvTZMEQlJrGSFFUv9V+tG1aiv1/MN
         2RxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmNBc2RVsoFzTPbawl7JR4O6grIFPe+XjOMfnKo9Dc7TmlVPAC2Zn/j2YYbPMpmTSTFRB100teZkuAub4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+BOGgqVgnuL1rn/EnzDa0Rc7w7Rvbhej6tiLlHbpL47oyVe5
	PDRpENZB14NOXciQ4/yGac2pIjC31TiqrT3J8O2qOPuCMXl7pmOKa2KuNCEOCIw=
X-Google-Smtp-Source: AGHT+IHtcfcSTW3xmt/su9LfzXPc+GJ9f+Q/89GDTtssOykRYD56WDM8/ZtEa6ZYEaudxFspzVkXUQ==
X-Received: by 2002:a05:600c:3b9c:b0:431:59ab:15cf with SMTP id 5b1f17b1804b1-432df74f8b6mr99668175e9.19.1731934455240;
        Mon, 18 Nov 2024 04:54:15 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm154405505e9.12.2024.11.18.04.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 04:54:14 -0800 (PST)
Message-ID: <8ea8dfed-608f-44b9-8adb-fb1798619215@suse.com>
Date: Mon, 18 Nov 2024 13:54:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kmod: verify module name before invoking modprobe
To: Song Chen <chensong_2000@189.cn>
Cc: mcgrof@kernel.org, samitolvanen@google.com, da.gomez@samsung.com,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20241110114233.97169-1-chensong_2000@189.cn>
 <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
 <524b444f-4b81-4005-b93a-39b7d3fd3db1@189.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <524b444f-4b81-4005-b93a-39b7d3fd3db1@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/13/24 03:15, Song Chen wrote:
> 在 2024/11/12 20:56, Petr Pavlu 写道:
>> On 11/10/24 12:42, Song Chen wrote:
>>> Sometimes when kernel calls request_module to load a module
>>> into kernel space, it doesn't pass the module name appropriately,
>>> and request_module doesn't verify it as well.
>>>
>>> As a result, modprobe is invoked anyway and spend a lot of time
>>> searching a nonsense name.
>>>
>>> For example reported from a customer, he runs a user space process
>>> to call ioctl(fd, SIOCGIFINDEX, &ifr), the callstack in kernel is
>>> like that:
>>> dev_ioctl(net/core/dev_iovtl.c)
>>>    dev_load
>>>       request_module("netdev-%s", name);
>>>       or request_module("%s", name);
>>>
>>> However if name of NIC is empty, neither dev_load nor request_module
>>> checks it at the first place, modprobe will search module "netdev-"
>>> in its default path, env path and path configured in etc for nothing,
>>> increase a lot system overhead.
>>>
>>> To address this problem, this patch copies va_list and introduces
>>> a helper is_module_name_valid to verify the parameters validity
>>> one by one, either null or empty. if it fails, no modprobe invoked.
>>
>> I'm not sure if I fully follow why this should be addressed at the
>> request_module() level. If the user repeatedly invokes SIOCGIFINDEX with
>> an empty name and this increases their system load, wouldn't it be
>> better to update the userspace to prevent this non-sense request in the
>> first place? 
> 
> If the user process knew, it wouldn't make the mistake.

The user process should be able to check that the ifr_name passed to
SIOCGIFINDEX is empty and avoid the syscall altogether, or am I missing
something? Even if the kernel gets improved in some way to handle this
case better, I would still suggest looking at what the application is
doing and how it ends up making this call.

> moreover, what 
> happened in dev_load was quite confusing, please see the code below:
> 
>      no_module = !dev;
>      if (no_module && capable(CAP_NET_ADMIN))
>          no_module = request_module("netdev-%s", name);
>      if (no_module && capable(CAP_SYS_MODULE))
>          request_module("%s", name);
> 
> Running the same process, sys admin or root user spends more time than 
> normal user, it took a while for us to find the cause, that's why i 
> tried to fix it in kernel.
> 
> Similarly, if something should be done in the kernel,
>> wouldn't it be more straightforward for dev_ioctl()/dev_load() to check
>> this case?
> 
> I thought about it at the beginning, not only dev_ioctl/dev_load but 
> also other request_module callers should check this case as well, that 
> would be too much effort, then I switched to check it at the beginning 
> of request_module which every caller goes through.
> 
>>
>> I think the same should in principle apply to other places that might
>> invoke request_module() with "%s" and a bogus value. The callers can
>> appropriately decide if their request makes sense and should be
>> fixed/improved.
>>
> 
> Callees are obliged to do fault tolerance for callers, or at least let 
> them know what is going on inside, what kinds of mistake they are 
> making, there are a lot of such cases in kernel, such as call_modprobe 
> in kernel/module/kmod.c, it checks if orig_module_name is NULL.

Ok, I see the idea behind checking that a value passed to
request_module() to format "%s" is non-NULL.

I'm however not sure about rejecting empty strings as is also done by
the patch. Consider a call to request_module("mod%s", suffix) where the
suffix could be empty to select the default variant, or non-empty to
select e.g. some optimized version of the module. Only the caller knows
if the suffix being empty is valid or not.

I've checked if this pattern is currently used in the kernel and wasn't
able to find anything, so that is good. However, I'm not sure if
request_module() should flat-out reject this use.

-- 
Thanks,
Petr

