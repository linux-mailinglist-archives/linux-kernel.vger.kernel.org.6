Return-Path: <linux-kernel+bounces-173235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C638BFD6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3061F21144
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4354BCB;
	Wed,  8 May 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4GFvdIF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD515102F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172165; cv=none; b=OZNuxOyIqs2BxQ5ymWXS+JIrgvMdwdSKImwuXuaNle+WMenbaXSiNobNoLjlE3oxmTwkMO7dg1ilGPABn7nxHlFx3B4FNdGbbNPyrngo927pnWOpLNumXrlu5ClFMs02TzfN9HaFJM2ZD7bJgv0fcCVKVc5oGMUoYe9oQmVCGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172165; c=relaxed/simple;
	bh=feq48cNug3s+tLhKQSxR/rgeiYdCnZck9qxHjzZMtAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsB9BpTTDjgK8QQhNQ2owrj7/lwQakspddi20aHBuXd3GAcy7kjI6Bt6KrXZjUqSVcTYrMKm8uaLXCZACFOfC4Uw0Vg7xKWGeyZOw1EHvDE10pj+pRma2W//FTbJl78mpsMBoMdoIM/HknM58A/98phtqFrcl2vYNBrZQHz20Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4GFvdIF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so21409141fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715172162; x=1715776962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApysZcF/hqgTR5K+moV5cGuzcGBPRqn9VmuyeK0mucs=;
        b=h4GFvdIFvCuOV93PRVSg06z+HxbuPDnbi+/LKyjCgI0ZY6k9SJabkXv4+dwuZQOLI/
         Vjt+75M8JoGU9Rv4tqS1GKKCk5dSToaJIfu4suc4fNt8YXfk6ejH7EQZGoRr3kYUh4aw
         xrKrVgOmAci3X3jJdQwd77QHaAewIARgW4A+MqwiJx1mTAROAYXElfrwvm/j2te1N81W
         0SyJ5FRNEkZkKds5KUHRiBWmDokCKtbFOTT4AAZDQXQfcMuNA9isga9us6kbwCc7ockQ
         Sa44/RwJHD1j6DJbeI0BZtw3yE/wQiwE0B956Z1EgHvMvoJG+b68czuhoI6bO3StdcpF
         lztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715172162; x=1715776962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApysZcF/hqgTR5K+moV5cGuzcGBPRqn9VmuyeK0mucs=;
        b=dQ02h0monJpgbT11aeIQbwjhbN6Hr8Kf5PW7X1GBn6CM5qmXTOGE/0WB2hEiAEZcGn
         6jtOj0IS3fuwyIrYGCi4Txv9kyredKHx7DI5Ij6qibkhJS3YjqN2jCDHUgKlP0DB3Vpp
         IQlr1gnMyoUKnsvMuLLIU8IoxxVWDU4Zx+9dkHHw8NoSHedh6qxZM8kQoInoy1qkYVfF
         Q2i3BXrxPtWDYauE5/oIR2ecqj9cDuaKt1/IHDkr95J1k71ngbuW5oyUaCZG9/ElgrnI
         1q/eq2rUq4C1SwoHlUyTQ2S/xn7GRWNF5zr4z2AAHLjirwhBHcN6p2vYwrm4fdpPMms/
         K+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWWVf5m0+jYg/Z2msXMWmOAuXeET9gQtdSFx1wC/EpywSazJjoc6XBpaRXgK7vzh56IGuQmHrNc/WFk5YZN3+uz+nJi/dKbGs51F1Rn
X-Gm-Message-State: AOJu0YzSX94UdWzDllx5a0bRddYKyMOzldlD8IIIxNk1s9l7HB/qdZjE
	xPGKcTLHjjEZV/9b/Ilf3/uWI+0WtR+onHAtRLab820AsWY5SHQG
X-Google-Smtp-Source: AGHT+IH8pxDKh/yo3PxEVsJGOJ/RJtfMrlFX4Gy8HCDeyFI2EpmJxcXU7vAji3dNw+weTulgmAjYeg==
X-Received: by 2002:a2e:b88b:0:b0:2df:e2d1:f4b5 with SMTP id 38308e7fff4ca-2e446d8a24cmr20751091fa.21.1715172161637;
        Wed, 08 May 2024 05:42:41 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id x23-20020a05651c105700b002dffa4aef20sm2402065ljm.2.2024.05.08.05.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 05:42:41 -0700 (PDT)
Message-ID: <e26ba70d-340a-43bf-8e39-7214e76ab141@gmail.com>
Date: Wed, 8 May 2024 14:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
To: Steven Rostedt <rostedt@goodmis.org>, David Airlie <airlied@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Maxime Ripard <mripard@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alex Constantino <dreaming.about.electric.sheep@gmail.com>,
 Timo Lindfors <timo.lindfors@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
References: <20240502081641.457aa25f@gandalf.local.home>
 <20240504043957.417aa98c@rorschach.local.home>
 <20240506-cuddly-elated-agouti-be981d@houat>
 <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
 <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
 <20240507050354.66bd88a0@rorschach.local.home>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <20240507050354.66bd88a0@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-05-07 11:03, Steven Rostedt wrote:
> On Tue, 7 May 2024 15:54:21 +1000
> David Airlie <airlied@redhat.com> wrote:
> 
>> I expec this will reintroduce the other problems that caused this
>> change in the first place, but I think this should at least bring us
>> back to regression equilibrium. I can't recommend anyone use qxl hw
>> over virtio-gpu hw in their VMs, since virtio-gpu is actually hw
>> designed for virt.
> 
> I agree that it will likely cause the issues that this was addressing
> to come back, but you can't have a fix that introduces a deadlock.
> 
> Perhaps the deadlock didn't exist before, and the printk updates
> changed the way it works to introduce it now?
It deadlocks on 6.8.8 under qemu/kvm,  reverting the patch fixes the problem there as well (6.8.7 hangs as well, but I have not tested reverting on that version)

/Anders

