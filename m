Return-Path: <linux-kernel+bounces-558422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54625A5E5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B0D189ABEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5F1EEA40;
	Wed, 12 Mar 2025 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qLInnF3t"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA71D5CE8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812848; cv=none; b=TBA21kUgZ37GhAiIfWxAmCNII9GdTglalMdRq5K9nWQT9wlouUBRlaaQS+T3Gwe99xAV3bRW6G+pNZVHHjtJQbEIMgNPLvsPWyOihfURTQ902ZFgaUvlG7XIYYgU9iZ7mmy3mmIcTL7eQOVmbfV08tk2TTnZUMMdSBhLlnVeut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812848; c=relaxed/simple;
	bh=DXSo/AARNRbRkGlPXt4rqTs8Rz3Z5GaAFHVdjYcdPQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MMtCrW97cmWYd9t+3OygOkQDdgqSLtmYP1ig4nlTIqrTHhXaIX3N5JSRpWyKJ9cuZAZOJdM/rFs/jTucpfHV09m2wIaZWkJOMc4Cqidt65/XPcFqFT8QPpy/t7br/YoozbmgSFUbjb92mvHXGblQx1oV+pGz7o7st2EhiMtYRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qLInnF3t; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-854a68f5afcso7162839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741812844; x=1742417644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGkc/HsqNjPMc69ATOsv5UcZ0yYP7/GpqqJyOxIH5G4=;
        b=qLInnF3td2SwTSg2uKjy1Anpi8J6rAqMqLRZVz8k3X+wE4+rBPxXlNutWLWP5wIUhn
         QwKDXxiw9iIXNgg69ZcNdiK+mbgU3G8zAKY0RqgSg07I3SEDE5VJouBVA9GZrnWW4kJz
         s2PNKZqvmTE3UiYXHF/sFDmccPE8fuEwV6MlwGCuHonTuKHFu18wrC/9HgdzzmRE3QR6
         xT1C4Wrw9ewWaOQuUSsVFr8LdOmLZBM4uj+FphLpQHwHivXWKwmmoibWw1cPjfLwhG9r
         8KAZ7I4LE9z35Dy9ly1rlsVtXg8NUeYRk26r+j+nuW2EXeSKQUeU2OTcCVo9dMVgabaD
         hgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812844; x=1742417644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGkc/HsqNjPMc69ATOsv5UcZ0yYP7/GpqqJyOxIH5G4=;
        b=UIpN4IpBnQSUDjvcJgAkb8+y6Y8ZPisnSkfR6AjZ2Pl/pVhqR2oz8MGgNkcShN6TR6
         z37kh3PWAOR18WIealGrJDKFZTrXKsju83UGxDUMizhDO9bZAqcmi0EtfLYm1PzziGJP
         MgmiN3iJYR51iHtTM8rPDy3ofpASmBwi1/GmIoTAlRS71pbkZ+fi5ngLI9LgIJ/0TQUn
         bqYv2blCmCCmoxT2ICwJywKQ4XswHoiPtT9I/B03DZzCONPySlwflQM+TexfI4gaNnJE
         UazoMp+uLqn9c7Sg0ax7OGiZClils3aAS5cWk4Bm0ohnP9vxR3++d0EByFaEqMDZlaEL
         IBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTuZKWK/CirMetuZNK7+J/2KLKOPyJl8Tgn+RTxMRLswBwfG2vkd1N9kUGVsN5xM/oYQcMOldXsQYBGNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLQGEqj3vzzOUvcP/ZPl62h+IDTSlABB4jddAVzvPol+XeeIe
	NWsjkDeQch569VYxxz5qNU/NVANSc+9mC1zV9cLCQuOs5OGWEANzM8phBdnHPtY=
X-Gm-Gg: ASbGncsTAa7K8fM8GQK9c/u7SNjuNCWJxD2dwZnaUrVHtGVJbNXNDHme/ss3jk99awh
	0kK9EPMnNpY6YKFRtFsvnqXMgN8kklvNpDExbh0dtqCQdH8vZMVltfazkaHFzhWx+CW4yWGHrFO
	lTI8HkjMrys7JWsBYiyKC4hnt2ApjYsGtjgA2mlPJjzcRvs2mRpngD+j4aDPYNwTsQQfP83YGqz
	xc8K2X8qM6l14W67Xrur5Yp33sPUHTcrk7QacDNr0hwQitX23iFbZIjCPqcXVOUWe0vwX3Os4fV
	K7CzGA4NRSe990XAHowQ9i2B36zeuVGROk2t+cF8
X-Google-Smtp-Source: AGHT+IFqtgkrRv5kgFAR8EC7J+G1ndYiYnAUZ21tfLuFxL+rv+ZsCZpp+xykY/ZRBHVekXMHNfhp5Q==
X-Received: by 2002:a05:6602:6cc4:b0:85b:59f3:2ed3 with SMTP id ca18e2360f4ac-85b59f33589mr1471463239f.8.1741812844024;
        Wed, 12 Mar 2025 13:54:04 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b5e8be48esm106836739f.19.2025.03.12.13.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 13:54:03 -0700 (PDT)
Message-ID: <8ca3d37a-19cd-4adc-9f2e-37be77e9a89b@kernel.dk>
Date: Wed, 12 Mar 2025 14:54:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] possible deadlock in io_uring_mmap
To: syzbot <syzbot+96c4c7891428e8c9ac1a@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67d0bee4.050a0220.14e108.001f.GAE@google.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <67d0bee4.050a0220.14e108.001f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 4:53 PM, syzbot wrote:
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.14.0-rc5-syzkaller-g77c95b8c7a16 #0 Not tainted
> ------------------------------------------------------
> syz.3.85/7036 is trying to acquire lock:
> ffff0000cf4f89b8 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_write include/linux/mm.h:770 [inline]
> ffff0000cf4f89b8 (&vma->vm_lock->lock){++++}-{4:4}, at: vm_flags_set include/linux/mm.h:900 [inline]
> ffff0000cf4f89b8 (&vma->vm_lock->lock){++++}-{4:4}, at: io_region_mmap io_uring/memmap.c:312 [inline]
> ffff0000cf4f89b8 (&vma->vm_lock->lock){++++}-{4:4}, at: io_uring_mmap+0x37c/0x504 io_uring/memmap.c:339
> 
> but task is already holding lock:
> ffff0000f51da8d8 (&ctx->mmap_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
> ffff0000f51da8d8 (&ctx->mmap_lock){+.+.}-{4:4}, at: io_uring_mmap+0x100/0x504 io_uring/memmap.c:325
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #9 (&ctx->mmap_lock){+.+.}-{4:4}:
>        __mutex_lock_common+0x1f0/0x24b8 kernel/locking/mutex.c:585
>        __mutex_lock kernel/locking/mutex.c:730 [inline]
>        mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:782
>        class_mutex_constructor include/linux/mutex.h:201 [inline]
>        io_uring_get_unmapped_area+0x84/0x348 io_uring/memmap.c:357
>        __get_unmapped_area+0x1d8/0x364 mm/mmap.c:846
>        do_mmap+0x4a8/0x1150 mm/mmap.c:409
>        vm_mmap_pgoff+0x228/0x3c4 mm/util.c:575
>        ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
>        __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>        __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>        __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
>        __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>        invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>        el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>        do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>        el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>        el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>        el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Not sure I see how this isn't either happening all the time, or
happening at all... But in any case, it seems trivial to move the vma
lock outside of a dependency with the ctx mmap_lock, we can just set
VM_DONTEXPAND upfront. Yes that'll leave it set in case we fail, which
should be fine as far as I can tell (though it'd be trivial to clear it
again).


diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 76fcc79656b0..aeaf4be48838 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -311,7 +311,6 @@ static int io_region_mmap(struct io_ring_ctx *ctx,
 {
 	unsigned long nr_pages = min(mr->nr_pages, max_pages);
 
-	vm_flags_set(vma, VM_DONTEXPAND);
 	return vm_insert_pages(vma, vma->vm_start, mr->pages, &nr_pages);
 }
 
@@ -324,6 +323,8 @@ __cold int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
 	struct io_mapped_region *region;
 	void *ptr;
 
+	vm_flags_set(vma, VM_DONTEXPAND);
+
 	guard(mutex)(&ctx->mmap_lock);
 
 	ptr = io_uring_validate_mmap_request(file, vma->vm_pgoff, sz);

-- 
Jens Axboe

