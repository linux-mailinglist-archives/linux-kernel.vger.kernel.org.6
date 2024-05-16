Return-Path: <linux-kernel+bounces-181480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32C8C7C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83F9B23CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAE156F28;
	Thu, 16 May 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtZcDybT"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30484156642
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884331; cv=none; b=ORfgTUkjj0ucthDCHja8E9xO72Clyglt1FPjp/MqLwaHFAxp8ooxkzs0Tslat9NZSvdeVeW0GKC07xY274Ezd8YJcXLIif83JrF/s72CaKSjkDxn0Q+RoqIaVNZiMSdN8qEzSpF79fGd2jOr8vplweCy9fhYx3t+OaAiKnljrpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884331; c=relaxed/simple;
	bh=ulBmgDpYl9RqmMUoQZb4ifLaUEnl1P+8yVh3QdiK0tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEs31+S7C2SBewCDy812SXUABmXog9bQ4nDDa+gkzfLh9pfmJBsh1nYd36HITlUZP3llA1h1C1Q754Mje/l71yDvBe+h8jtBWPwQF2h5V70UbOtH1U3dfcU/PUnVDhvZ4iHZnTnjqw2swm+YyNU66KD/LJUWVNFbDo0GOz/dyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtZcDybT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso435234a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715884329; x=1716489129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9nxwbG6gb8ueBywH4meN9WHXcrWE2uzTDdW5y8fNX4=;
        b=GtZcDybTU0FSmo8AhY2T6z/oLMjLa0Eo/B7qPVfjwMEWnPoaEz6Vd2GWUbi+Zsh9Df
         cQ5YCzm7lEIeAp/kw46AhqbKMTZNR9ayKYumq18xEel4j8iMI6n7HW5AGJF6NERroSnD
         +LUXGXklwpNgrOmFKC3d5HQgCZSaHpcShy9NDKSrTe6SALYVjBXl5kpA5UVo0mq3448a
         vYsTH3ppddh1lRlv/LCc/APUrzc+g5hStEgJwf3vm+dDhHaTQ3dEVxPyTtAPn6oEZ+XY
         1YC4slClweoXvPI7pQ9au9freBOCRZhblVanp0EcZBlncd1y9ZK89vEN10dEOAd3TD27
         ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715884329; x=1716489129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9nxwbG6gb8ueBywH4meN9WHXcrWE2uzTDdW5y8fNX4=;
        b=VekGsTa6NqvGIW5mcKYeWFtsLVCG7v8rg5Px6R017pqo2LVL40RrGiv6psAdMvpJeU
         STpWHD04QTTkhTVY5hoJP6iYRMfArPj8BQ0NDTfhWZ5gIANENLwU94ZyrNclDYPA5eTE
         BTNo2e4dUa6aKkK7JyBrCNblpMQkoMpd0QEviF3KVyApX5W6gnS5kPcLasvWY5fBCfsx
         vcOVmwFy2dLLdi6Tqs0DhNGVe0yJOyyBBMvgQ1Sh4r9etlshBX2E9x/3SU/bes3M86AK
         91j4m9p5QCA96VBHjjbZ6gUzNZDrSUXFf4C44qq2VZv/GLAP31KJgSq0uyVyV0UPTTP7
         w/mw==
X-Forwarded-Encrypted: i=1; AJvYcCX6OYfmWWB7I5dgeRH5n+NZI9c7IeOafkHIRoZ3lNcDwCOT0Fym5F+Ou0wxyePcXGxsr0Nj1Wfq+irpb7lG5PTcuHK2e4f6AHZpRcsY
X-Gm-Message-State: AOJu0Yy37lRSeG+1txcaXBUrpdOlfTL53hgwSgyE1zLZ2HxywkY4mDsJ
	bTGkAHI2TDMod9r2KZQQSz63mVj0pmQlubzyFAsHM1fPNYgTCbq3BMAS/a9tvc+QFnUF47P7LDC
	4Y2PY041oyFtoeIi9ky3lpX+ad9g=
X-Google-Smtp-Source: AGHT+IHZ4P921nR29yCMtTxUXYhj08WmtLOz5u90bzk2FKHb1mib22+S/j0SRqZy3C/6k9WA6jxsHYZha5Y6GQCsDqY=
X-Received: by 2002:a17:90a:e009:b0:2b1:a632:60f6 with SMTP id
 98e67ed59e1d1-2b6ccef66abmr15883107a91.44.1715884329461; Thu, 16 May 2024
 11:32:09 -0700 (PDT)
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
Date: Thu, 16 May 2024 14:31:58 -0400
Message-ID: <CADnq5_NmC9bYkPFUD35gBtxsk_9jYhOTugni-q4WGXggf6=rLA@mail.gmail.com>
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

Arun is investigating and trying to repro it.  You still have a
polaris based GPU right?

Thanks,

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

