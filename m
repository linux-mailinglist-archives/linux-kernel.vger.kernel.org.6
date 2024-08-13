Return-Path: <linux-kernel+bounces-284748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5739504B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAED1F22D92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268891993A7;
	Tue, 13 Aug 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jHrfDQ32"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811A187348
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551293; cv=none; b=ZjxQz7k5YuhzjE7ra/53OopQ6huCtFmIpWPyFmScjHk3i+apcIErKGzId0zeMtHaj63g4mRsWXiUIvoxfcXk+gvhoeiHTyxtctwCh0R1ltUCLvwJ9W43XbbHhPPB/5UkrI9ZMhxT2iITp4yEkgWudQIb0sHVYR5xGEUbFMPm2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551293; c=relaxed/simple;
	bh=7JED9j77PKutsGABbXNBQkcMJG/2imqFd4wNMLEJ8F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cf7vpahZPS94GJvNmR8Ul+cjpgdCd457mjvV3V5ADo/wbM1rGmH5UdCcPeGOXOmEkBC94/Y3qq79R3+t7z7C+EzLU3oTJ0w9Jy8+x4cTiizwRPv/6gHQ1wbt6TqW295AFexGxQRQdVOGSj1L9/h1o7a7Is+Oj/+i2p3BMMFJH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jHrfDQ32; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c1b624e3b0so359088a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723551291; x=1724156091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOHfasRrYR/IurZgZK4bKz+ZtwqF3wUb8jW3AIXAOx4=;
        b=jHrfDQ32rBeLiUalhp0oCWrbxY1cWvrQ+332y40foRlXazFu26JcKfUzefDi0fwS1/
         h8DMyCM2PLifuekV9dCEfi3/gVEHuwcz5UkA1NXgELxkm64qIAl69qzlI32bGhWIDZZ9
         9HYKmxoqRXhi6G0w1qW6QGDp5KgwTdb1FKyGtD+5tukBcu/9flbDOEn0Ih/8fgpUddUq
         kn5YBtEn4hWFIngrfQ6Sg4d36hQZiHRr83qa9ovjMdhlDhFhEi45UXDgKQZDyfEaExoz
         sMdkMtVS8EFRKgukbKPkot/pRYaB6mRRaHTRe0fRZqWAr6g5BP5WM0iVTc1hLpQLvkiD
         aZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551291; x=1724156091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOHfasRrYR/IurZgZK4bKz+ZtwqF3wUb8jW3AIXAOx4=;
        b=u2zYcebWi2rqeBTi+UxEbTJgrloASmJe0UA61/hV4bSR4sVKEmTrxqG5o88D9PZgcK
         bddkIrhH6QmT31rh0s7/dgZOB+hT8WEHu7ZG/8uKu6y7aBYR5PuAdZw4MjlNNjXBYjQB
         Ld8B1BC8wRaz9CEM1wf8a0cQIXsPcC1Jy69gak6q2QyPkv9f4uIt+vmejc+FAYW0IY8Z
         uWZA/mXCZxBVS1U8yXy8DUAwMOZtPKSUMvaSagjgyiAPga9XgZa97DlScuq93KeONQmI
         vUG7wmW/RF7/F+skBo3MWzsKHxizfvZKSMeMphPlqu/LQkd2kRELljkHYtB6ufUQIjhK
         Wy9A==
X-Forwarded-Encrypted: i=1; AJvYcCUGurjy7AC7p+kxOiBuX79KMeAjftD0HQC/qLuui4l1yqgTy0Lc0iPGJicxF5NefWlrUrI1azNdipYM55I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTdCO7SQfddT74OsDpJ8uNL1CujkcOyH0fhKq6GvTaceCP7Ir
	2AS+PZ8CtAtNA3WFdhXaIX46fs9+RbNWgUQjqh8uRayJqKYF7K7vuCFKB7sTqtV+J/j1+MQQp57
	X
X-Google-Smtp-Source: AGHT+IHhvtlPy5GSVWgMeqS8qWX78qZ4pIqMSOFlNGCfFcHZFx0tbT3MGHx/cq3MmeWdSwWeHozC9Q==
X-Received: by 2002:a05:6a00:91c7:b0:70d:140c:7369 with SMTP id d2e1a72fcca58-7125a26d0a4mr1269317b3a.3.1723551290669;
        Tue, 13 Aug 2024 05:14:50 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a4357asm5600846b3a.133.2024.08.13.05.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 05:14:50 -0700 (PDT)
Message-ID: <43b7c2c4-9bba-444a-ba27-9a8f3623a953@kernel.dk>
Date: Tue, 13 Aug 2024 06:14:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KCSAN: data-race in io_sq_thread /
 io_sq_thread_park (9)
To: syzbot <syzbot+2b946a3fd80caf971b21@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000065552a061f8cb396@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00000000000065552a061f8cb396@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 2:50 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6a0e38264012 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1019759d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb57e6ebf675f9d2
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b946a3fd80caf971b21
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/753a842a966b/disk-6a0e3826.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e12e23519777/vmlinux-6a0e3826.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bce0584a8cb4/bzImage-6a0e3826.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2b946a3fd80caf971b21@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in io_sq_thread / io_sq_thread_park
> 
> write to 0xffff888111459638 of 8 bytes by task 10761 on cpu 1:
>  io_sq_thread+0xdab/0xff0 io_uring/sqpoll.c:383
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> read to 0xffff888111459638 of 8 bytes by task 10329 on cpu 0:
>  io_sq_thread_park+0x1b/0x80 io_uring/sqpoll.c:47
>  io_ring_exit_work+0x197/0x500 io_uring/io_uring.c:2786
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3312
>  worker_thread+0x526/0x700 kernel/workqueue.c:3390
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> value changed: 0xffff8881223d0000 -> 0x0000000000000000

It's just a debug check.

#syz test

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index b3722e5275e7..3b50dc9586d1 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -44,7 +44,7 @@ void io_sq_thread_unpark(struct io_sq_data *sqd)
 void io_sq_thread_park(struct io_sq_data *sqd)
 	__acquires(&sqd->lock)
 {
-	WARN_ON_ONCE(sqd->thread == current);
+	WARN_ON_ONCE(data_race(sqd->thread) == current);
 
 	atomic_inc(&sqd->park_pending);
 	set_bit(IO_SQ_THREAD_SHOULD_PARK, &sqd->state);

-- 
Jens Axboe


