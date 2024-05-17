Return-Path: <linux-kernel+bounces-182163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8EE8C878E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918FD281962
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F555769;
	Fri, 17 May 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbeYyxqj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC247A7D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954120; cv=none; b=mjFtiTHL4A2/XxzPcbXIlC1lK0wr7zPTkRAIvQ1Q6q9HFxnC99X36U8//JHtldOIJWwGIdraCYVxX4hH9iwifKQhUoTMlS8wQ5tEPeXbEUs0YwqJqYRR4PNsdSAYjHPEoMrFtRQsOFKKmyvKrT/VJrwVOfCgG1oRza7/x3gBXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954120; c=relaxed/simple;
	bh=kmLRaan199TtvtBsPNWNz/2/KbfZ7Bw18heNS9jkiDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P192FB3o8ahUzshKimgaGDD7PlEfkkSSbqnbgc+i9MKVbfveKcHZobT/4l8fAxf2eeLXu4V9cSGFA7ZENbX0VmDrJo1isIgK01o8sPRJlgDYlnrwwAbjWwe50VvOVnKOmbGiGsUnGLxfc92Bkq/37c6ADVCJmJxmcE9ox9LwE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbeYyxqj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso7198215ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715954118; x=1716558918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZxQSJrLWHCfnaAsDV35fIgvxplbZ5Wh2f2VjoJkfWc=;
        b=ZbeYyxqjPKeG19eA3LE8eG5aaq2N7DZtHi36Lxd821HWKcm5O0P2awUoylIyuHg/Fd
         PnaHHQLTT/1NzaAAWOeCeB9drDAU58j3OzLADV3vg8Way5UgN9k7bnWQ5qgbfiU0cpWh
         j1hfAv5eYAG2Yj1vs9ksVvTFXQEHZs2l00H+RRuZ1s0fqd4p8wlZBRX2EuC9oXGmnoHG
         ANrxgKier+Yhsf0t0GhRMlcB0neohB1fA4LQKIT+KPZzbDKgDJu1Hg6VMHkHbQ5soxtl
         DjO9ol/dWpfC/s0nTB4B+oAW3DyZhCKuWP4pFmE6Vj3P8K8QiE3t/VBN3JcbzJdLi+wN
         zfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715954118; x=1716558918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZxQSJrLWHCfnaAsDV35fIgvxplbZ5Wh2f2VjoJkfWc=;
        b=IVioAmhjDESBB7zAeIWT7G5ZBE/kxM+bjApZxaDoOkcu9ae40ZD4a13sc/5GgKUv9w
         WJsu50FMvDTtagYgaglBB5DLCVDxNbd9Bx0g8zPObPw/gw55wfmlqE80uqiTZbnLViTy
         VelfBNvTkF5JGjtfEUoNnFdCMDo8ZsEZ1nQA5iZ8gZzNYxSJisOwR1bpWdy2Hrd4Sm7O
         32EKeVrCS/ZcB2XO1e1Iry+HKsov5XJCc0mLr2uqUv0TWO4rymDI6akGe6ZjV+T/bNvI
         SGU6cxb+ibTlq+kwlkY+dTPSZUzbFM+/Bl4GXY1L/GVByyX+d42bvYd4ii2QqdreOkRa
         0kWw==
X-Forwarded-Encrypted: i=1; AJvYcCU0D9YJ7QjxMicUVdS181rlspTV5b214CiypTcc0Ra+a47afMBzyqY4BCDT3QduvKYPexidAqVCE39L5/H+Afmw7tUIhuN/Q3Ml0vr1
X-Gm-Message-State: AOJu0YwjISa+PRGwaGHIdWek0Gb/3/4YYylN57WlILu1iNypdmMftEy6
	wrkDW2ccEQXnLlL5Ppt7QYNOxuBoXnFHnmtV6PDLe5eLgJ8C610DGdhZRb+x5Qc+IUpW+Jvmcv1
	CqyKeDg0J8ceca4bpsSHWh4TvxSY=
X-Google-Smtp-Source: AGHT+IGwEX78O0IPn/LXQEz9L1cBE2phMOdId85UeU23Pc2FrTGewlbOW/8t6Hjkh2Ub/HWo7jrIvmSVn/vzYm5neUc=
X-Received: by 2002:a05:6a20:914f:b0:1ad:89e:21b5 with SMTP id
 adf61e73a8af0-1afde0d4ce4mr24848771637.15.1715954118578; Fri, 17 May 2024
 06:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
 <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 May 2024 09:55:07 -0400
Message-ID: <CADnq5_P3pR8C=SsZWv85h7rZUxxfoQBeMsNbTWnLpOqeQ-2m=Q@mail.gmail.com>
Subject: Re: [git pull] drm urgent for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 2:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 15 May 2024 at 19:54, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Here is the buddy allocator fix I picked up from the list, please apply=
.
>
> So I removed my reverts, and am running a kernel that includes the
> merge 972a2543e3dd ("Merge tag 'drm-next-2024-05-16' of
> https://gitlab.freedesktop.org/drm/kernel") but I still see a lot of
> warnings as per below.
>
> I was going to say that the difference is that now they trigger
> through the page fault path (amdgpu_gem_fault) while previously they
> triggered through the system call path and amdgpu_drm_ioctl. But it
> turns out it's both in both cases, and it just happened to be one or
> the other in the particular warnings that I cut-and-pasted.
>
> As before, there are tens of thousands of them after being up for less
> than an hour, so this is not some kind of rare thing.
>
> The machine hasn't _crashed_ yet, though. But I'm going to be out and
> about and working on my laptop the rest of the day, so I won't be able
> to test.
>
> (And that kernel version of "6.9.0-08295-gfd39ab3b5289" that is quoted
> in the WARN isn't some official kernel, I have about ten private
> patches that I keep testing in my tree, so if you wondered what the
> heck that git version is, it's not going to match anything you see,
> but the ~ten patches also aren't relevant to this).
>
> Nothing unusual in the config, although this is clang-built. Shouldn't
> matter, never has before.

Can you try this patch?
https://patchwork.freedesktop.org/patch/594539/

Alex

>
>             Linus
>
> ---
> CPU: 28 PID: 3326 Comm: mutter-x11-fram Tainted: G        W
> 6.9.0-08295-gfd39ab3b5289 #64
> Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS MASTER/TRX40
> AORUS MASTER, BIOS F7 09/07/2022
> RIP: 0010:__force_merge+0x14f/0x180 [drm_buddy]
> Code: 74 0d 49 8b 44 24 18 48 d3 e0 49 29 44 24 30 4c 89 e7 ba 01 00
> 00 00 e8 9f 00 00 00 44 39 e8 73 1f 49 8b 04 24 e9 25 ff ff ff <0f> 0b
> 4c 39 c3 75 a3 eb 99 b8 f4 ff ff ff c3 b8 f4 ff ff ff eb 02
> RSP: 0000:ffff9e350314baa0 EFLAGS: 00010246
> RAX: ffff974a227a4a00 RBX: ffff974a2d024b88 RCX: 000000000b8eb800
> RDX: ffff974a2d024bf8 RSI: ffff974a2d024bd0 RDI: ffff974a2d024bb0
> RBP: 0000000000000000 R08: ffff974a2d024b88 R09: 0000000000001000
> R10: 0000000000000800 R11: 0000000000000000 R12: ffff974a2198fa18
> R13: 0000000000000009 R14: 0000000010000000 R15: 0000000000000000
> FS:  00007f56a78b6540(0000) GS:ffff97591e700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5688040000 CR3: 0000000198cc9000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  ? __warn+0xc1/0x190
>  ? __force_merge+0x14f/0x180 [drm_buddy]
>  ? report_bug+0x129/0x1a0
>  ? handle_bug+0x3d/0x70
>  ? exc_invalid_op+0x16/0x40
>  ? asm_exc_invalid_op+0x16/0x20
>  ? __force_merge+0x14f/0x180 [drm_buddy]
>  drm_buddy_alloc_blocks+0x249/0x400 [drm_buddy]
>  ? __cond_resched+0x16/0x40
>  amdgpu_vram_mgr_new+0x204/0x3f0 [amdgpu]
>  ttm_resource_alloc+0x31/0x120 [ttm]
>  ttm_bo_alloc_resource+0xbc/0x260 [ttm]
>  ? memcg_account_kmem+0x4a/0xe0
>  ? ttm_resource_compatible+0xbb/0xe0 [ttm]
>  ttm_bo_validate+0x9f/0x210 [ttm]
>  ? __alloc_pages+0x129/0x210
>  amdgpu_bo_fault_reserve_notify+0x98/0x110 [amdgpu]
>  amdgpu_gem_fault+0x53/0xd0 [amdgpu]
>  __do_fault+0x41/0x140
>  do_pte_missing+0x453/0xfd0
>  handle_mm_fault+0x73c/0x1090
>  do_user_addr_fault+0x2e2/0x6f0
>  exc_page_fault+0x56/0x110
>  asm_exc_page_fault+0x22/0x30

