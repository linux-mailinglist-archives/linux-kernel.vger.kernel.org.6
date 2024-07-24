Return-Path: <linux-kernel+bounces-261511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289C93B818
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2BD1F218FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE126132494;
	Wed, 24 Jul 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O7R+R6CI"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908276A347
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853296; cv=none; b=BMz4hmlJQt01uXX/NIrkESPRhcEGCPIaK7vni+LaOHWf3mlR09TEt0/gd+OrvvztZWYEDulJZHJbPjHYyuOJoMSPFieNjItd/UqRLmxhowt+3BgR3BIwxTFLCNy+e7YDFJ0TwH3fWmNy1hmrS/Pu6rwYn4WA2M+G9e6xsX2kz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853296; c=relaxed/simple;
	bh=lFEytbKWIPr979a5YtTLvnRR4ZNlpfrU++2SDTHEKvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jNWc9JuX6XM684E6klgnl79VbnNunjaA4rt52k0iabtDcwGAzbUvZ6obQVjhuep9CZzYfpuqhwdgfV00ClibCni3sNKZjseiHpa+Kjpp7xxA43d/gxPxmJKe1IUYaKzKHLzEMGykRVhIhQGYYL5ZfF1FxdBkL/qaAUy2CnRKqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O7R+R6CI; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-396d327b05cso16735ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721853291; x=1722458091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITFL6TaaGbjCL8QPAJWVh8nPn81p1UqgDWGP/j76/rQ=;
        b=O7R+R6CIc5RKMdREUtmvtn3b5vsk7yW5WvwfGYO+Cab7LXzKAvvVKToHz9ACrGMnhV
         vtKy7nUuNYq2nPCpW9V/DNbutrRNhi+F4T4kj0qERimOJzESJobBbcmLhWalXQ6Ug1gK
         3LKxx2p4oMZqL+ycy+BGdNSDW2Tom9yxsxUS7GheQ2iYu4Q3WyUaiRfOJ7bzsjPX5s7f
         WgMLSZlUCDhXkKRjhM7U26S0RYjcL6mL/G3sZSHlk+dbi+RzAQk0fyS5EKkG2hyHxLpl
         nKfGm0ehKHFQ1f4hb4FjWEm9RWMyT/oEglXivchQMXo0jJ1l4rLj1F0j0OugPefqvTC4
         cHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853291; x=1722458091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITFL6TaaGbjCL8QPAJWVh8nPn81p1UqgDWGP/j76/rQ=;
        b=aOGLVbZKt+yvNGPgoNPFRgSJw5R2xvMIgZoHuN9TbDtInKU8VI657k+v9Crcd4MnkH
         FE0tNSRavrydaQ/noRqeq//myl+IhvMpOT6gFfKEcHUAALEmehu9/R2ghacB/AD0exe8
         ypVYbQjoVmksoy7ojZk94AwSn0q14xuUkSbVTakK/vMw3evPeG7cocNlWHcmtxeb7I9D
         0gsoz7+1ktshmYX93ynzeA+K1OfDDL6sYXO6jy5C9LaEPUyt3gUw5r8TCLIXDqF5UAwJ
         EI+voiUC2rids7zj7tJHlGtraizuB6k9m7Ni97JzVICqNzXvvuXIyFaaeyZMo0dQUog1
         U/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUmsfNscuEHadyDCus3Jr8Q09ApNDHQtSYViSqyIEpFZnmvyCXCh5pHkQGZQ0IvEZBRkm4Gb4f0+4bIiDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUF6dQL8IIPal/6Sl8QB7LymH/UdKFRRizCbIkIox4Aik+MxuE
	fQ7L9HoazhJcgvPlMvwjD5GGWvuZidzp55ia9oFa/eR92/WHSAyI/BvJ2FPa230=
X-Google-Smtp-Source: AGHT+IHIEcyMCS7/ebL50ZLHqMDFbOdW6NLPu0XatoQrNuzWdbE5LSo6BdOb20YoC46n3fBu6PQ71A==
X-Received: by 2002:a05:6e02:1c8e:b0:39a:1b94:9730 with SMTP id e9e14a558f8ab-39a22cb891bmr2011665ab.1.1721853291378;
        Wed, 24 Jul 2024 13:34:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22f13d3fsm410105ab.62.2024.07.24.13.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:34:50 -0700 (PDT)
Message-ID: <64844b2a-d4aa-4b1f-8954-049850e38c1e@kernel.dk>
Date: Wed, 24 Jul 2024 14:34:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in
 io_req_task_work_add_remote
To: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000360ee4061e02dffe@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000360ee4061e02dffe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 12:59 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KMSAN: uninit-value in io_req_task_work_add_remote
> 
> =====================================================
> BUG: KMSAN: uninit-value in io_req_local_work_add io_uring/io_uring.c:1193 [inline]
> BUG: KMSAN: uninit-value in io_req_task_work_add_remote+0x592/0x5e0 io_uring/io_uring.c:1241
>  io_req_local_work_add io_uring/io_uring.c:1193 [inline]
>  io_req_task_work_add_remote+0x592/0x5e0 io_uring/io_uring.c:1241
>  io_msg_remote_post io_uring/msg_ring.c:102 [inline]
>  io_msg_data_remote io_uring/msg_ring.c:133 [inline]
>  io_msg_ring_data io_uring/msg_ring.c:152 [inline]
>  io_msg_ring+0x1c38/0x1ef0 io_uring/msg_ring.c:305
>  io_issue_sqe+0x383/0x22c0 io_uring/io_uring.c:1711
>  io_queue_sqe io_uring/io_uring.c:1925 [inline]
>  io_submit_sqe io_uring/io_uring.c:2181 [inline]
>  io_submit_sqes+0x1259/0x2f20 io_uring/io_uring.c:2296
>  __do_sys_io_uring_enter io_uring/io_uring.c:3206 [inline]
>  __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3143
>  __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3143
>  x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4719
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page mm/slub.c:2321 [inline]
>  allocate_slab+0x203/0x1220 mm/slub.c:2484
>  new_slab mm/slub.c:2537 [inline]
>  ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3723
>  __kmem_cache_alloc_bulk mm/slub.c:4759 [inline]
>  kmem_cache_alloc_bulk_noprof+0x486/0x1330 mm/slub.c:4831
>  __io_alloc_req_refill+0x84/0x560 io_uring/io_uring.c:940
>  io_alloc_req io_uring/io_uring.h:393 [inline]
>  io_submit_sqes+0x171b/0x2f20 io_uring/io_uring.c:2285
>  __do_sys_io_uring_enter io_uring/io_uring.c:3206 [inline]
>  __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3143
>  __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3143
>  x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 0 UID: 0 PID: 5924 Comm: syz.0.16 Not tainted 6.10.0-syzkaller-12268-g7a3fad30fd8b-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> =====================================================

#syz test

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8e6faa942a6f..198bbbfe465c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1164,8 +1164,10 @@ static inline void io_req_local_work_add(struct io_kiocb *req,
 		 * previous adds should've tried to wake the task.
 		 */
 		nr_tw = nr_tw_prev + 1;
+#if 0
 		if (!(flags & IOU_F_TWQ_LAZY_WAKE))
 			nr_tw = IO_CQ_WAKE_FORCE;
+#endif
 
 		req->nr_tw = nr_tw;
 		req->io_task_work.node.next = head;
-- 
Jens Axboe


