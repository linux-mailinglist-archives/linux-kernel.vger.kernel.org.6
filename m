Return-Path: <linux-kernel+bounces-181367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792658C7B15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9FD2836BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E2156642;
	Thu, 16 May 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LIe5TSa3"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43753392
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880335; cv=none; b=ngzlgqepFP+Knt4xJ7P7nIf0BK+QoEpQg4eHYzHwX/6Xc/YX4ftvYUoUroNSl7+Klob0wsj8TRDixGTNedUEyQSNDcJuqmJnYxgRGertdUaKsCkzTsqJKr7kMn8ZxEJuM6EoFC3jfdUxxZKKCDckX7JisX3uN0IcvholMQoAhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880335; c=relaxed/simple;
	bh=pNLCm2T6MuWaee5MduBM9YVuC9CmG8Q2+vsEy1hbTO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMLFiGZnKYRwXdF33Ms0rLKuYq245+ERkqwd3WHxMNzYniKwe8xspBD8udB2+i4N3no5UCDs1GnzZdHfWmLgo0mjzOnwsP6JEfgN/wK1g0NwQIeNDNctiBvA45L126xLuDboJsc9mpLeCh54/B0bRoq12K9Ex5U49NfXqfOFRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LIe5TSa3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a352bbd9so486380166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715880331; x=1716485131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoJcT9IN7CXxnbK0d4qtbKbdlGqkhITWkFsznFTzj4Q=;
        b=LIe5TSa3aB+ID9C2WCpGTRzgIAxNf8IgVbLW2Pkg4Ga3vGbVcPU2STNPsO91zW8xsb
         /28U7OUXXlPxD746Ng1QXa243nYTQ+8aITyqfEJognbnKgz7UnFUpFE7B8n9iFSX8Zco
         No1p6wtCrvxiixFxMp8OTFW6+klr1t7mnQOMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880331; x=1716485131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoJcT9IN7CXxnbK0d4qtbKbdlGqkhITWkFsznFTzj4Q=;
        b=u5uF4D3oHGnfp5PXmyjB+9gCSh7mt3AmQYSNSqskBMDvfeZgoe73JKcemknBdxfELn
         nyaSbN1Yni9mc83xUTYm/AK4vPrhXd54oqGrqirIU3Qbnv80q31yhIXUP4so6gluHyRf
         NgBMy8Yd2fZfiGw+gjS6n88LgjDSIPJvkxVlkZQ5ww/AgE1mRWtzA+VbhshDVSU7PTkk
         t/k/guANEj5m5EAAP8GRVbC3qMbPjrEfNkKQL0DaL0WOdQNQd34tHukhvATGMVxxCYvE
         EuFRbOYYXUYKT97i15JhCGdACpeOAHNviSrB/FJgiZK4OzTivVZWU6pFspunUZbIFrPP
         T4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj0KbXWuUHJ76Z/80gNVY0RzBV8z94GKHVCxhpVxt1bpNf0nVB0VXmEmglivYLE4DXFo4vtfnQVqOPopt57z2LCbrD0vH5wZo8Dd0D
X-Gm-Message-State: AOJu0Yyo1s7vpP7dOnAUxt+Znx6JBosF4d7qVk6OjYFsS+veP4wR8T+C
	BuNUd1nCBqM8+bfZFRd0P54xPSqAfv8/gLro6eQ64Ya0Hbk7qgSf6oHJio6JaVzC/JVwtmJAT3o
	8p5YHVA==
X-Google-Smtp-Source: AGHT+IGz+dlNPw2JOvhYz73WNvC0rDuMXXd8EbzatXqtI7fdkCotia02Yi9S9Tnh80G5FqHTicmqCQ==
X-Received: by 2002:a17:906:5291:b0:a59:9f88:f1f1 with SMTP id a640c23a62f3a-a5a2d1de7b1mr1813434266b.19.1715880330981;
        Thu, 16 May 2024 10:25:30 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01932sm997045566b.168.2024.05.16.10.25.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 10:25:30 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a352bbd9so486375466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:25:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXV0DdrwFHLK1C6BzJfS/lryrd2K6qFOlOMs5+A0C+NQ18hq521uGCNWqOM0+FAl/jBGZRPc1p4alYd36H3VA8Gi36Y2EsINTcK+oIY
X-Received: by 2002:a17:906:6547:b0:a5a:8896:73de with SMTP id
 a640c23a62f3a-a5a88967610mr708543966b.26.1715880330099; Thu, 16 May 2024
 10:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
In-Reply-To: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 May 2024 10:25:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com>
Message-ID: <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com>
Subject: Re: [git pull] drm urgent for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 19:54, Dave Airlie <airlied@gmail.com> wrote:
>
> Here is the buddy allocator fix I picked up from the list, please apply.

So I removed my reverts, and am running a kernel that includes the
merge 972a2543e3dd ("Merge tag 'drm-next-2024-05-16' of
https://gitlab.freedesktop.org/drm/kernel") but I still see a lot of
warnings as per below.

I was going to say that the difference is that now they trigger
through the page fault path (amdgpu_gem_fault) while previously they
triggered through the system call path and amdgpu_drm_ioctl. But it
turns out it's both in both cases, and it just happened to be one or
the other in the particular warnings that I cut-and-pasted.

As before, there are tens of thousands of them after being up for less
than an hour, so this is not some kind of rare thing.

The machine hasn't _crashed_ yet, though. But I'm going to be out and
about and working on my laptop the rest of the day, so I won't be able
to test.

(And that kernel version of "6.9.0-08295-gfd39ab3b5289" that is quoted
in the WARN isn't some official kernel, I have about ten private
patches that I keep testing in my tree, so if you wondered what the
heck that git version is, it's not going to match anything you see,
but the ~ten patches also aren't relevant to this).

Nothing unusual in the config, although this is clang-built. Shouldn't
matter, never has before.

            Linus

---
CPU: 28 PID: 3326 Comm: mutter-x11-fram Tainted: G        W
6.9.0-08295-gfd39ab3b5289 #64
Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS MASTER/TRX40
AORUS MASTER, BIOS F7 09/07/2022
RIP: 0010:__force_merge+0x14f/0x180 [drm_buddy]
Code: 74 0d 49 8b 44 24 18 48 d3 e0 49 29 44 24 30 4c 89 e7 ba 01 00
00 00 e8 9f 00 00 00 44 39 e8 73 1f 49 8b 04 24 e9 25 ff ff ff <0f> 0b
4c 39 c3 75 a3 eb 99 b8 f4 ff ff ff c3 b8 f4 ff ff ff eb 02
RSP: 0000:ffff9e350314baa0 EFLAGS: 00010246
RAX: ffff974a227a4a00 RBX: ffff974a2d024b88 RCX: 000000000b8eb800
RDX: ffff974a2d024bf8 RSI: ffff974a2d024bd0 RDI: ffff974a2d024bb0
RBP: 0000000000000000 R08: ffff974a2d024b88 R09: 0000000000001000
R10: 0000000000000800 R11: 0000000000000000 R12: ffff974a2198fa18
R13: 0000000000000009 R14: 0000000010000000 R15: 0000000000000000
FS:  00007f56a78b6540(0000) GS:ffff97591e700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5688040000 CR3: 0000000198cc9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ? __warn+0xc1/0x190
 ? __force_merge+0x14f/0x180 [drm_buddy]
 ? report_bug+0x129/0x1a0
 ? handle_bug+0x3d/0x70
 ? exc_invalid_op+0x16/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? __force_merge+0x14f/0x180 [drm_buddy]
 drm_buddy_alloc_blocks+0x249/0x400 [drm_buddy]
 ? __cond_resched+0x16/0x40
 amdgpu_vram_mgr_new+0x204/0x3f0 [amdgpu]
 ttm_resource_alloc+0x31/0x120 [ttm]
 ttm_bo_alloc_resource+0xbc/0x260 [ttm]
 ? memcg_account_kmem+0x4a/0xe0
 ? ttm_resource_compatible+0xbb/0xe0 [ttm]
 ttm_bo_validate+0x9f/0x210 [ttm]
 ? __alloc_pages+0x129/0x210
 amdgpu_bo_fault_reserve_notify+0x98/0x110 [amdgpu]
 amdgpu_gem_fault+0x53/0xd0 [amdgpu]
 __do_fault+0x41/0x140
 do_pte_missing+0x453/0xfd0
 handle_mm_fault+0x73c/0x1090
 do_user_addr_fault+0x2e2/0x6f0
 exc_page_fault+0x56/0x110
 asm_exc_page_fault+0x22/0x30

