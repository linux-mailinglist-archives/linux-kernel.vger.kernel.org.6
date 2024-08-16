Return-Path: <linux-kernel+bounces-288799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E8953EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6054C1F2633E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B01E864;
	Fri, 16 Aug 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SBtZUkZu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680615E88
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771522; cv=none; b=HSt/jHjG/SKxb47npM+7F2qG+gvaHqCTi0ckQ9F8ycJi2lvjIpKOYX79vfYZwQsmz7LE9LQXkZFUWSC1WTWggSdIxjDUaHZfB157XnYSFOnF4vko6Ur33EaW0mhoXWkmW3itAc9xnOAmbwv7ThNveWgbPoLsrHCm27IwaWitiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771522; c=relaxed/simple;
	bh=CYpwr6StzSj2+7DzSMHAY4aXezq3O6/CadyyDKmzt1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e1AMimXPkQJ8c+eNNLA9HO/VSPnFjnhvFk55LDkITT130yI9l+S60vuBY3YKSktOvogIGIsRUji4FcDE8ESIIB61EvrSmBlCie5xlPdXSoDYB9BL0ahNcJRU27+y61AVH3YwwTxgP8n0xNop6PRaRYT41/XuYmTd/cur3kty/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SBtZUkZu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc47aef524so1488585ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723771519; x=1724376319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESMhcPFphyXhqA8QukLZ6cV9TYtHR+VBt5t6iYkD0kQ=;
        b=SBtZUkZu3qfMIMyjHakeQKOnRsthZxN0kue4inhDjl9xnma5K2WKoKyl3bBTFKhMvL
         WNHwZwAi/1zEakbiWXuSWQivkNKu0YmZ9sgFXV3CL4xqHslWbzPd/1r5Vwdn4M57n0F4
         035ONPcURelaHoK5Kxc/RGZXnD4JAwC22itaHAZUZ6HyeiVR9DBrKBmdro6qt4uOMSAJ
         pG2h2b73Z4NMVB/hfB5L/mMAaGBUHUoKhLYtw21DUx7sZZoiK969mOg0fbzMFpTsh6PR
         KlMmf8yQqlrcavYHYBGcqPzSYEqzW4D+x1qCu+0BdY/FSm3YZAflRoYCgLDduyzqwNXl
         DaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723771519; x=1724376319;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESMhcPFphyXhqA8QukLZ6cV9TYtHR+VBt5t6iYkD0kQ=;
        b=Q4FKwHjoavucxjhMTln75Jj+TtapovUnqdQBB2iNwdErk1mzScpjj6wtsIwpCLUCiw
         nSDvF9kP4dmm34cVttC31ueMrzqA5XMb/VHIH3fANsuXfkqj3acUJ/rdNwxMlOJvgNKE
         F7g+X66tziDAchSUv/sWoaydivLDzngHKEWW1uzUE74jZi+mmMwXoaaMlMvQ3fuREOrd
         IMGXnefX5f10yEQj2sPs8ZUrkF0RrF362HRiNrTIpkL9BxG7aHdAytG+oQvkcHZlDoEL
         FC5MmbCmIQcudJPGaHues5r9XDnfkBPDN4K+DXN1ltM8TJTIob8EhDWr0OGdwsF2xCG9
         GnEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5LO+nev7AWWy5hhf1oA/++A7xqjd6odGS4VGC7TKEOualyWTcHllObZggOaCPLZXXx7Qq4B+fsQGGwvfRZhIpzWLwVjAxMrx9lqaf
X-Gm-Message-State: AOJu0Yx906VKBH5Yuuj6+lzorCv6fAfKpjEUaP+KGYQkfwroTr/oeL0E
	CQg58KTvDsh5CUpLRjsyx0F/hT6rFoNeylmypKST0Igy98iubdVl2hzqeQHTohE=
X-Google-Smtp-Source: AGHT+IEmPxntCuqf16ABuO4U2q3vD1ru4bN8oaWiUd542npnxXCCHFqNnh1QyOtbYK+souYGazCsng==
X-Received: by 2002:a17:902:e5d0:b0:1fa:ab4a:fb02 with SMTP id d9443c01a7336-20203b110edmr10091285ad.0.1723771519299;
        Thu, 15 Aug 2024 18:25:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0301f8csm16038475ad.50.2024.08.15.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 18:25:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: bvanassche@acm.org, hch@lst.de, jack@suse.cz, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: yukuai1@huaweicloud.com, yukuai3@huawei.com, houtao1@huawei.com, 
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
In-Reply-To: <20240815024736.2040971-1-lilingfeng@huaweicloud.com>
References: <20240815024736.2040971-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v2] block: Fix lockdep warning in blk_mq_mark_tag_wait
Message-Id: <172377151781.214020.14270712076295454810.b4-ty@kernel.dk>
Date: Thu, 15 Aug 2024 19:25:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 15 Aug 2024 10:47:36 +0800, Li Lingfeng wrote:
> Lockdep reported a warning in Linux version 6.6:
> 
> [  414.344659] ================================
> [  414.345155] WARNING: inconsistent lock state
> [  414.345658] 6.6.0-07439-gba2303cacfda #6 Not tainted
> [  414.346221] --------------------------------
> [  414.346712] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [  414.347545] kworker/u10:3/1152 [HC0[0]:SC0[0]:HE0:SE1] takes:
> [  414.349245] ffff88810edd1098 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x131c/0x1ee0
> [  414.351204] {IN-SOFTIRQ-W} state was registered at:
> [  414.351751]   lock_acquire+0x18d/0x460
> [  414.352218]   _raw_spin_lock_irqsave+0x39/0x60
> [  414.352769]   __wake_up_common_lock+0x22/0x60
> [  414.353289]   sbitmap_queue_wake_up+0x375/0x4f0
> [  414.353829]   sbitmap_queue_clear+0xdd/0x270
> [  414.354338]   blk_mq_put_tag+0xdf/0x170
> [  414.354807]   __blk_mq_free_request+0x381/0x4d0
> [  414.355335]   blk_mq_free_request+0x28b/0x3e0
> [  414.355847]   __blk_mq_end_request+0x242/0xc30
> [  414.356367]   scsi_end_request+0x2c1/0x830
> [  414.345155] WARNING: inconsistent lock state
> [  414.345658] 6.6.0-07439-gba2303cacfda #6 Not tainted
> [  414.346221] --------------------------------
> [  414.346712] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [  414.347545] kworker/u10:3/1152 [HC0[0]:SC0[0]:HE0:SE1] takes:
> [  414.349245] ffff88810edd1098 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x131c/0x1ee0
> [  414.351204] {IN-SOFTIRQ-W} state was registered at:
> [  414.351751]   lock_acquire+0x18d/0x460
> [  414.352218]   _raw_spin_lock_irqsave+0x39/0x60
> [  414.352769]   __wake_up_common_lock+0x22/0x60
> [  414.353289]   sbitmap_queue_wake_up+0x375/0x4f0
> [  414.353829]   sbitmap_queue_clear+0xdd/0x270
> [  414.354338]   blk_mq_put_tag+0xdf/0x170
> [  414.354807]   __blk_mq_free_request+0x381/0x4d0
> [  414.355335]   blk_mq_free_request+0x28b/0x3e0
> [  414.355847]   __blk_mq_end_request+0x242/0xc30
> [  414.356367]   scsi_end_request+0x2c1/0x830
> [  414.356863]   scsi_io_completion+0x177/0x1610
> [  414.357379]   scsi_complete+0x12f/0x260
> [  414.357856]   blk_complete_reqs+0xba/0xf0
> [  414.358338]   __do_softirq+0x1b0/0x7a2
> [  414.358796]   irq_exit_rcu+0x14b/0x1a0
> [  414.359262]   sysvec_call_function_single+0xaf/0xc0
> [  414.359828]   asm_sysvec_call_function_single+0x1a/0x20
> [  414.360426]   default_idle+0x1e/0x30
> [  414.360873]   default_idle_call+0x9b/0x1f0
> [  414.361390]   do_idle+0x2d2/0x3e0
> [  414.361819]   cpu_startup_entry+0x55/0x60
> [  414.362314]   start_secondary+0x235/0x2b0
> [  414.362809]   secondary_startup_64_no_verify+0x18f/0x19b
> [  414.363413] irq event stamp: 428794
> [  414.363825] hardirqs last  enabled at (428793): [<ffffffff816bfd1c>] ktime_get+0x1dc/0x200
> [  414.364694] hardirqs last disabled at (428794): [<ffffffff85470177>] _raw_spin_lock_irq+0x47/0x50
> [  414.365629] softirqs last  enabled at (428444): [<ffffffff85474780>] __do_softirq+0x540/0x7a2
> [  414.366522] softirqs last disabled at (428419): [<ffffffff813f65ab>] irq_exit_rcu+0x14b/0x1a0
> [  414.367425]
>                other info that might help us debug this:
> [  414.368194]  Possible unsafe locking scenario:
> [  414.368900]        CPU0
> [  414.369225]        ----
> [  414.369548]   lock(&sbq->ws[i].wait);
> [  414.370000]   <Interrupt>
> [  414.370342]     lock(&sbq->ws[i].wait);
> [  414.370802]
>                 *** DEADLOCK ***
> [  414.371569] 5 locks held by kworker/u10:3/1152:
> [  414.372088]  #0: ffff88810130e938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x357/0x13f0
> [  414.373180]  #1: ffff88810201fdb8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x3a3/0x13f0
> [  414.374384]  #2: ffffffff86ffbdc0 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x637/0xa00
> [  414.375342]  #3: ffff88810edd1098 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x131c/0x1ee0
> [  414.376377]  #4: ffff888106205a08 (&hctx->dispatch_wait_lock){+.-.}-{2:2}, at: blk_mq_dispatch_rq_list+0x1337/0x1ee0
> [  414.378607]
>                stack backtrace:
> [  414.379177] CPU: 0 PID: 1152 Comm: kworker/u10:3 Not tainted 6.6.0-07439-gba2303cacfda #6
> [  414.380032] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  414.381177] Workqueue: writeback wb_workfn (flush-253:0)
> [  414.381805] Call Trace:
> [  414.382136]  <TASK>
> [  414.382429]  dump_stack_lvl+0x91/0xf0
> [  414.382884]  mark_lock_irq+0xb3b/0x1260
> [  414.383367]  ? __pfx_mark_lock_irq+0x10/0x10
> [  414.383889]  ? stack_trace_save+0x8e/0xc0
> [  414.384373]  ? __pfx_stack_trace_save+0x10/0x10
> [  414.384903]  ? graph_lock+0xcf/0x410
> [  414.385350]  ? save_trace+0x3d/0xc70
> [  414.385808]  mark_lock.part.20+0x56d/0xa90
> [  414.386317]  mark_held_locks+0xb0/0x110
> [  414.386791]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  414.387320]  lockdep_hardirqs_on_prepare+0x297/0x3f0
> [  414.387901]  ? _raw_spin_unlock_irq+0x28/0x50
> [  414.388422]  trace_hardirqs_on+0x58/0x100
> [  414.388917]  _raw_spin_unlock_irq+0x28/0x50
> [  414.389422]  __blk_mq_tag_busy+0x1d6/0x2a0
> [  414.389920]  __blk_mq_get_driver_tag+0x761/0x9f0
> [  414.390899]  blk_mq_dispatch_rq_list+0x1780/0x1ee0
> [  414.391473]  ? __pfx_blk_mq_dispatch_rq_list+0x10/0x10
> [  414.392070]  ? sbitmap_get+0x2b8/0x450
> [  414.392533]  ? __blk_mq_get_driver_tag+0x210/0x9f0
> [  414.393095]  __blk_mq_sched_dispatch_requests+0xd99/0x1690
> [  414.393730]  ? elv_attempt_insert_merge+0x1b1/0x420
> [  414.394302]  ? __pfx___blk_mq_sched_dispatch_requests+0x10/0x10
> [  414.394970]  ? lock_acquire+0x18d/0x460
> [  414.395456]  ? blk_mq_run_hw_queue+0x637/0xa00
> [  414.395986]  ? __pfx_lock_acquire+0x10/0x10
> [  414.396499]  blk_mq_sched_dispatch_requests+0x109/0x190
> [  414.397100]  blk_mq_run_hw_queue+0x66e/0xa00
> [  414.397616]  blk_mq_flush_plug_list.part.17+0x614/0x2030
> [  414.398244]  ? __pfx_blk_mq_flush_plug_list.part.17+0x10/0x10
> [  414.398897]  ? writeback_sb_inodes+0x241/0xcc0
> [  414.399429]  blk_mq_flush_plug_list+0x65/0x80
> [  414.399957]  __blk_flush_plug+0x2f1/0x530
> [  414.400458]  ? __pfx___blk_flush_plug+0x10/0x10
> [  414.400999]  blk_finish_plug+0x59/0xa0
> [  414.401467]  wb_writeback+0x7cc/0x920
> [  414.401935]  ? __pfx_wb_writeback+0x10/0x10
> [  414.402442]  ? mark_held_locks+0xb0/0x110
> [  414.402931]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  414.403462]  ? lockdep_hardirqs_on_prepare+0x297/0x3f0
> [  414.404062]  wb_workfn+0x2b3/0xcf0
> [  414.404500]  ? __pfx_wb_workfn+0x10/0x10
> [  414.404989]  process_scheduled_works+0x432/0x13f0
> [  414.405546]  ? __pfx_process_scheduled_works+0x10/0x10
> [  414.406139]  ? do_raw_spin_lock+0x101/0x2a0
> [  414.406641]  ? assign_work+0x19b/0x240
> [  414.407106]  ? lock_is_held_type+0x9d/0x110
> [  414.407604]  worker_thread+0x6f2/0x1160
> [  414.408075]  ? __kthread_parkme+0x62/0x210
> [  414.408572]  ? lockdep_hardirqs_on_prepare+0x297/0x3f0
> [  414.409168]  ? __kthread_parkme+0x13c/0x210
> [  414.409678]  ? __pfx_worker_thread+0x10/0x10
> [  414.410191]  kthread+0x33c/0x440
> [  414.410602]  ? __pfx_kthread+0x10/0x10
> [  414.411068]  ret_from_fork+0x4d/0x80
> [  414.411526]  ? __pfx_kthread+0x10/0x10
> [  414.411993]  ret_from_fork_asm+0x1b/0x30
> [  414.412489]  </TASK>
> 
> [...]

Applied, thanks!

[1/1] block: Fix lockdep warning in blk_mq_mark_tag_wait
      commit: b313a8c835516bdda85025500be866ac8a74e022

Best regards,
-- 
Jens Axboe




