Return-Path: <linux-kernel+bounces-334669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508897DA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F9D1F222A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5631186E50;
	Fri, 20 Sep 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="N9Ey1Hlw"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348594CB36
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868030; cv=none; b=LCFNhgpH5ZnNwj0w/60GWeDOv1ZBVolAhhsH8FpGm5+NmuppvTYy5ZrX3eKocwLNixM0yeKIhPYmqD+5/AT2MNSys98a8eyronnWxe5556IB23/+HcIpCZ7ua6aZgdEL3GIle9JveLqKssj6uon3GHkcwcLvb8nHu1HsRwe8j2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868030; c=relaxed/simple;
	bh=N5xHjDMfogJvgvGbcrVM2UHL/wrfDjKYGHhGaWQdfAQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P5Bn98TS5U7ObD1OniptHTxb3ttRXmLSgfQ1GfdHioMOBiD1lKOc+qCz/8ZYcMWZcQugfb264/KW4SMw1PMi+NzxeBWLbV/3vyxaB1qKP/KP6BYyLB4Z4BQ88hTWFhL/NfA3/x1rGDNRoXMo+yNkBKaDPoxVpwDJ8M50Z4rFYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=N9Ey1Hlw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717839f9eb6so346544b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1726868027; x=1727472827; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQjDKsSkVR2nTxnOrcaZ6/YsVGVO5vKqyOAyBxgc5iA=;
        b=N9Ey1Hlw72PWUaWnCbupJnHhnjiTYNENHIxWf+XhKjqcx3gDQQX/i9vXNKDvtM4M12
         t9zFXXVys8kiLwQSTRqS266XFjAo+bfX4vOsFyiE9UCxJ8jMN8oeDDvPNit2mCqEpx/h
         9n9szlcVuQEbhGZu+pwIRvITazmnHsKKBYoaoNWvAPGjKQYhQGKSldB1X6RLgQw5hw0n
         7c+4om20MME6Vi6SXIeiFpKUwz1+s4Bwm5x1HZYgNpWp3NgIAg2O7uDh46otoh5o/n7p
         LS6Q4DlWOuN4ooYsGROf3J2fnkszoZ1pTVkPqW62mLoI9o3qC3i1wjYZGf3cuMmASJ2s
         9L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726868027; x=1727472827;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQjDKsSkVR2nTxnOrcaZ6/YsVGVO5vKqyOAyBxgc5iA=;
        b=ifszruVVtFbkM0XoUqEV6kR/oR9cOBMMMwNAJ03pE6ITt2u/p7Ez6oF+40p7qswvQo
         7UzyJVG0ScfxHdxJ64GOfDiuiNxX90o2+HSMxpRoWVKCgCcF74qxgRY9130jOV3AiXJt
         17Rl0OIt5IsI6Oy/SSfAy0SKDFcNvNWua6qZQrJ8L3tM66A+1a7oWDPyNF1FoZY4wHvh
         bkgC5INgQFavL0uODqvVsbAxXiQUziTozIXEpZXl7H6jzwUFg8KsX/uTWUxo+R23jJys
         EzOncqfQncJJEfTtGGztVo1Unh4KTqe6cpvpw4noAAxHLA896c+k8EOG57kAkLAnchsw
         SiFg==
X-Gm-Message-State: AOJu0YyRHOAWnIXwtV3Awlucg8nFcHDYJ39dhkDoSQ/d5KFEczIV4DEt
	eJsDgcF2pkNZXsYu3/gud3QVrin1kSHamUfqU9zeo2oQWQvWf1Yl/nQP1vW61Sd1Ui5N8aCmL6j
	F
X-Google-Smtp-Source: AGHT+IGy/w+NfVyN226ycapxQodd0y5Al5Vm/2r80z4ckzuv0rU5J8HxBWM+RoKQa/+kkoHRPQ6MgA==
X-Received: by 2002:a05:6a00:2d22:b0:70b:705f:8c5d with SMTP id d2e1a72fcca58-7199c9f4f2dmr2676807b3a.4.1726868026609;
        Fri, 20 Sep 2024 14:33:46 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:3f32:90e7:d647:b08f? ([2001:56a:f979:1f00:3f32:90e7:d647:b08f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a973bbsm10232717b3a.27.2024.09.20.14.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 14:33:46 -0700 (PDT)
Message-ID: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
Date: Fri, 20 Sep 2024 15:33:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
Content-Language: en-US
Cc: regressions@lists.linux.dev
From: Bob Gill <gillb5@telus.net>
Subject: 6.11.0 crash, 6.10.0 git bisect log
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.  Kernel 6.11.0 crashes.  6.10.0 builds.  Al Viro and Dr. David 
Alan Gilbert have been helpful, and asked that I

post a git bisect log.  The last log step seems odd, but the second last 
step "Remove useless function call" might be what broke.

My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem with an 
AMD RX 6500XT.  That's the odd combination.

Thanks in advance,

Bob

Config:  (.config)
/data/kernel/bobtest6.10-64

Build line: (last command tells me the job is finished)
make menuconfig && make -j $(nproc) && make modules && make 
modules_install && make install && /data/music/pl.sh

Rule 1: Do not modify ANYTHING in the source tree

git bisect start
git bisect bad
git bisect good v6.10

Bisecting: 11273 revisions left to test after this (roughly 14 steps)
[2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of 
git://git.kernel.org/pub/scm/virt/kvm/kvm

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0+

RESULT:  boot 6.10.0+ fails
          screen black for more than 2 minutes,
          (caps lock key unresponsive, reset, power
          buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
Bisecting: 5677 revisions left to test after this (roughly 13 steps)
[280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0+

RESULT: boot 6.10.0+ successful
tree: git bisect good
Bisecting: 2855 revisions left to test after this (roughly 12 steps)
[dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 
'x86-percpu-2024-07-17' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0+

RESULT: boot 6.10.0+ fails
         screen black for more than 2 minutes,
         (caps lock key unresponsive, reset, power
         buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
Bisecting: 1478 revisions left to test after this (roughly 11 steps)
[32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL state 
verification in TBT mode

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ successful
tree: git bisect good
Bisecting: 739 revisions left to test after this (roughly 10 steps)
[b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize GC IP 
v11.5.2

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ fails
         screen black for more than 2 minutes,
         (caps lock key unresponsive, reset, power
         buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
Bisecting: 369 revisions left to test after this (roughly 9 steps)
[cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase 
autosuspend delay to 100ms on 40xx

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc1+

RESULT: boot 6.10.0-rc1+ successful
tree: git bisect good
Bisecting: 184 revisions left to test after this (roughly 8 steps)
[0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add 
`__counted_by` attribute for flexible arrays

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.9.0-rc5+

RESULT: boot 6.9.0-rc5+ successful
tree: git bisect good
Bisecting: 92 revisions left to test after this (roughly 7 steps)
[9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use periodic 
detection for ipx/headless

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ fails
         screen black for more than 2 minutes,
         (caps lock key unresponsive, reset, power
         buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
Bisecting: 44 revisions left to test after this (roughly 6 steps)
[a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag 
'drm-intel-gt-next-2024-06-12' of 
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ successful
tree: git bisect good
Bisecting: 22 revisions left to test after this (roughly 5 steps)
[51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix cursor 
size issues

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ successful
tree: git bisect good
Bisecting: 11 revisions left to test after this (roughly 4 steps)
[871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add 
workaround to restrict max frac urgent for DPM0

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ fails
         screen black for more than 2 minutes,
         (caps lock key unresponsive, reset, power
         buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
Bisecting: 5 revisions left to test after this (roughly 3 steps)
[5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check HDCP 
returned status

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ fails
         screen black for more than 2 minutes,
         (caps lock key unresponsive, reset, power
         buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
Bisecting: 2 revisions left to test after this (roughly 1 step)
[e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove 
useless function call

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ successful

tree: git bisect good
[2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check and 
log for function error codes

latest kernel:
ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
6.10.0-rc3+

RESULT: boot 6.10.0-rc3+ fails
         screen black for more than 2 minutes,
         (caps lock key unresponsive, reset, power
         buttons on computer case do nothing).  Reset with power bar.

tree: git bisect bad
[a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and 
log for function error codes






