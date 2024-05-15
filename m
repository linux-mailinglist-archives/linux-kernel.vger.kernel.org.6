Return-Path: <linux-kernel+bounces-180338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9C8C6D13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460E128317B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE17815B0E6;
	Wed, 15 May 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NAGeddX2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85215B0E0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715803597; cv=none; b=X56lEIDWvMBw2s+Lszd/A7g2Onm4utRQ94r7sRarL60WOAz/xi1tnJ6oIhoxBSR3thwqMy/w0YPMQ3pcjbhb55sa/lExsDxz94rheXmX8QQLGNLJXBcOmTYP+pBry2qIj3rzKMhb50OwG3BjrcOLA0OBjRp4oDwmAMLPscdvUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715803597; c=relaxed/simple;
	bh=ejIzs9P9rhmjm8Nt6Yv5p+ApcjV56VkPMqnVSGc1X7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUyJS+++4Vtpj7iIlFTszXp7L5YDCqNOQL/slx6OAHXi0oOj6SohLwVe/4XzLUhQ2tIrXFWrHos2FkZQnPKPMDQpNdLvxmHzCbsJO/wF6nb9b0ApeZrZ/rVNugHQv+UXHYLXgW8l+vdvJRo/kIach1p7dLuBgvJJqtoep9GxriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NAGeddX2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a387fbc9so253544766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715803594; x=1716408394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xgWTsnppDGQ+VtFfLUk2HloVqk5skXTycI5AJpTh8zw=;
        b=NAGeddX2nT7bjGVWdvqEKg2yn4qtChu1N2Ghc/xiEe/nrSb2BnZXeletjX/X+Jg2Ji
         vi0CqU3PJ4zf0ccznVxvbeELBylT2n8w9QqPwnLB7op/i6y0IzKD0NKDaS1oFUlY6i9n
         q9JCGP+ksetWculFQWXwGpmzr6o7ebcuZdnbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715803594; x=1716408394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgWTsnppDGQ+VtFfLUk2HloVqk5skXTycI5AJpTh8zw=;
        b=BcrfE8lBMl0d0NQwerZ32ff1mKxfcbYZ/YFge2AgV+JMNFEuWYT+CKlxn2eEZsoSGR
         i96OECRvs9Szxag/J3zx9qQ98TtSUbKNkp32PUF3M46thqLCUy+KdUFHlmWn4DS/Guv0
         ZsaWneH37tNNzvwiCdXmmIGYttJsjduP9jpEEG6AuM/1UNAEX+0JAL4ipFBy2XUuhirW
         8xZoqnMC6yZDirWZEr1+XV/IJJGT9hZabT0r4gKlTIdPF19n0Eg8GWTI0cKLVaS44JNJ
         V1bG5NuPajfS55jNXTpb1u185YWaag2CmTovblx3UaKuMRntpk04KuGEN0Y0fi/eZq0G
         +WxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy9+zUd61uvh3+qvy9ynzNdHEFicVvH8TedTBoluZan6JVDoHGr19Y/PxGdkXvE58qStIu/evzLUHpdKQZnzvMuW+JbvLpqhhM5ct1
X-Gm-Message-State: AOJu0YzjcAgHOeX9PsxYbeQFmt+Fa6QNIG4CIlIlzmsUVIHP1tT4WPIl
	wx+c+K4IjSDQP3b7KmNKZ1ZtHDbmCLfKdBQ/56RPYCSKvvo2Tfgf7JpeBJOY/vF+PAzntEu+NtY
	PixExcA==
X-Google-Smtp-Source: AGHT+IGEe5ZS8cCpt7j18cO0k2s0tu3Zjutg6So3ubAQaqJd38C8rnweULigMrtyUaS7Im9p235s9w==
X-Received: by 2002:a17:907:7e92:b0:a5a:6686:ff9 with SMTP id a640c23a62f3a-a5a66861068mr720547166b.77.1715803593594;
        Wed, 15 May 2024 13:06:33 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d2bsm891188566b.120.2024.05.15.13.06.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 13:06:33 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59ad344f7dso175650366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:06:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhTPQnwmvVg07cGpLQH0vdP2i0g2fvg0onkVM6qGHBVV7cM+1RVtOss0xpxy8dJnksIHYEMpSOz2cFFf5ALJ49DWNHEBXjZ32Q7mXf
X-Received: by 2002:a17:906:b2d3:b0:a59:cf0a:4e46 with SMTP id
 a640c23a62f3a-a5a2d5d53a0mr1067386566b.42.1715803592607; Wed, 15 May 2024
 13:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
In-Reply-To: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 13:06:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
Message-ID: <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 23:21, Dave Airlie <airlied@gmail.com> wrote:
>
> In drivers the main thing is a new driver for ARM Mali firmware based
> GPUs, otherwise there are a lot of changes to amdgpu/xe/i915/msm and
> scattered changes to everything else.

Hmm. There's something seriously wrong with amdgpu.

I'm getting a ton of__force_merge warnings:

  WARNING: CPU: 0 PID: 1069 at drivers/gpu/drm/drm_buddy.c:199
__force_merge+0x14f/0x180 [drm_buddy]
  Modules linked in: hid_logitech_hidpp hid_logitech_dj uas
usb_storage amdgpu drm_ttm_helper ttm video drm_exec
drm_suballoc_helper amdxcp drm_buddy gpu_sched drm_display_helper
drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel drm
ghash_clmulni_intel igb atlantic nvme dca macsec ccp i2c_algo_bit
nvme_core sp5100_tco wmi ip6_tables ip_tables fuse
  CPU: 0 PID: 1069 Comm: plymouthd Not tainted 6.9.0-07381-g3860ca371740 #60
  Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS
MASTER/TRX40 AORUS MASTER, BIOS F7 09/07/2022
  RIP: 0010:__force_merge+0x14f/0x180 [drm_buddy]
  Code: 74 0d 49 8b 44 24 18 48 d3 e0 49 29 44 24 30 4c 89 e7 ba 01 00
00 00 e8 9f 00 00 00 44 39 e8 73 1f 49 8b 04 24 e9 25 ff ff ff <0f> 0b
4c 39 c3 75 a3 eb 99 b8 f4 ff ff ff c3 b8 f4 ff ff ff eb 02
  RSP: 0018:ffffb87a81cb7908 EFLAGS: 00010246
  RAX: ffff9b1915de8000 RBX: ffff9b1919478288 RCX: 000000000ffff800
  RDX: ffff9b19194782f8 RSI: ffff9b19194782d0 RDI: ffff9b19194782b0
  RBP: 0000000000000000 R08: ffff9b1919478288 R09: 0000000000001000
  R10: 0000000000000800 R11: 0000000000000000 R12: ffff9b192590fa18
  R13: 000000000000000d R14: 0000000010000000 R15: 0000000000000000
  FS:  00007fa06bfa9740(0000) GS:ffff9b281e000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000555adb857000 CR3: 000000011b516000 CR4: 0000000000350ef0
  Call Trace:
   ? __force_merge+0x14f/0x180 [drm_buddy]
   drm_buddy_alloc_blocks+0x249/0x400 [drm_buddy]
   ? __cond_resched+0x16/0x40
   amdgpu_vram_mgr_new+0x204/0x3f0 [amdgpu]
   ttm_resource_alloc+0x31/0x120 [ttm]
   ttm_bo_alloc_resource+0xbc/0x260 [ttm]
   ttm_bo_validate+0x9f/0x210 [ttm]
   ttm_bo_init_reserved+0x103/0x130 [ttm]
   amdgpu_bo_create+0x246/0x400 [amdgpu]
   ? amdgpu_bo_destroy+0x70/0x70 [amdgpu]
   amdgpu_bo_create_user+0x29/0x40 [amdgpu]
   amdgpu_mode_dumb_create+0x108/0x190 [amdgpu]
   ? amdgpu_bo_destroy+0x70/0x70 [amdgpu]
   ? drm_mode_create_dumb+0xa0/0xa0 [drm]
   drm_ioctl_kernel+0xad/0xd0 [drm]
   drm_ioctl+0x330/0x4b0 [drm]
   ? drm_mode_create_dumb+0xa0/0xa0 [drm]
   amdgpu_drm_ioctl+0x41/0x80 [amdgpu]
   __x64_sys_ioctl+0xd2a/0xe00
   ? update_process_times+0x89/0xa0
   ? tick_nohz_handler+0xe2/0x120
   ? timerqueue_add+0x94/0xa0
   ? __hrtimer_run_queues+0x12b/0x250
   ? ktime_get+0x34/0xb0
   ? lapic_next_event+0x12/0x20
   ? clockevents_program_event+0x78/0xd0
   ? hrtimer_interrupt+0x118/0x390
   ? sched_clock+0x5/0x10
   do_syscall_64+0x68/0x130
   ? __irq_exit_rcu+0x53/0xb0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

and eventually the whole thing just crashes entirely, with a bad page
state in the VM:

  BUG: Bad page state in process kworker/u261:13  pfn:31fb9a
  page: refcount:0 mapcount:0 mapping:00000000ff0b239e index:0x37ce8
pfn:0x31fb9a
  aops:btree_aops ino:1
  flags: 0x2fffc600000020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x3fff)
  page_type: 0xffffffff()

which comes from a btrfs worker (btrfs-delayed-meta
btrfs_work_helper), but I would not be surprised if that was caused by
whatever odd thing is going on with the DRM code. IOW, it *looks* like
this code ends up just corrupting memory in horrible ways.

            Linus

                Linus

