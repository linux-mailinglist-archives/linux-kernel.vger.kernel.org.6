Return-Path: <linux-kernel+bounces-334035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D797D1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F1AB22F82
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6200D2AF0B;
	Fri, 20 Sep 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9/ZH120"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8920ED
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817166; cv=none; b=Le4GmLaTvkI610nk5U8q/ntR1nNZHT831AF49MkMqjIQs7uA8gv9lJjeUKFqTywXNFTjTB89trz4jrvQkcsHbpwXQY2kzfZZYWHkN5B6xR+Ov3Cr4I/Mo27Y9ZsZgF3lJctf3m/rX70eClIaaqHoaCzR0ylVHh7JX8/TPau4Ef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817166; c=relaxed/simple;
	bh=oXEnFJwNfWwAX7+EFdBKG6ZvXR+KF+DCzgf0AyAIJWo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mDyQgDwb35ib4rYwgZRbhi/BxcBW5ktYTDc5LQXrnTnkqRTOQFmcbK6vN5IY3FyVVvhoIQfQCsJPlaTE5ViB0LSrvakhwvC5/jJAhkBoZTck6NhdZdimbTFnDsagUL6pxV/l6UylH4qpZQKNRmCv+nWgBLuB2lCskBYLEMP0VM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9/ZH120; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208ccde82e6so14733205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726817164; x=1727421964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TLR5GVT/zVa6b58PYxjO2bKhU2CX4JQk4WFiq4WQ7BQ=;
        b=T9/ZH120uU+xAktjezgyDQav1O9RRyWmKsJa9rrc9SxTUQ1ZWitGxT2i0yrsYlbFRb
         QuULuGTIi+wOW5dOaAuXGEC1kP5zHp66iACyaGJSnBXBqTAiXy3yR1B43HgeRtGoJNTB
         HEPxeidq4jt8l4uZUCJpBjpUJ6TmEjoCZKPEA7kltBz+oGvIFlZWH406CrqxiHfZhqLg
         FKxgmr9eU5uMYT3iskeFJpAiY7DYtHtZZd8S1sf6Rwr6QRv266vg9rqzSS2P3eSnp277
         r7q/rDYlk7KCBuJRCZq3Xvk2/N34CYRpPsug53dqq8Oda+Q72iThZf7fkOVm3WaEueNT
         r5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726817164; x=1727421964;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLR5GVT/zVa6b58PYxjO2bKhU2CX4JQk4WFiq4WQ7BQ=;
        b=IC+PqNlfQtkYYQpVgXH33xPPK5leqvRsS8KRhul+Y3HKvPYnsnoEgRE9Fgr+45/7eF
         djAX7+tVccIn55mmmsn90WpF775Eaf7YSMlTpCerSUJqnWXi+1a+XjrMgAlJrPjLkZ2v
         gPlofEIpJzsqrKXmnY6ONa6tnl64jxB3ssFzGYGOzY2l+m4xa/9AwrnKACB4Yu8sZh5t
         trx9i8T5HTwN8ZOLqtJqjI9SkBBw1P7c1F9aTtmD2xYKU1PmwGNz29Vu9J33FymDSISH
         u4tx+XpyWkN1Q8MihJoh/EWh4DMwLuJQQjtaAY+2FVTZhkWDKlcZEG6arXZMwseFdkyw
         rxQQ==
X-Gm-Message-State: AOJu0YycJUVQmA+TOPHjL11pa0aq214D09BBBVhaZ27zsWBZZfPvebFZ
	TCCWkuTEt42bsXbnSICoIafjNiZWsQR+WjBVe/0nWcvd/5vUMKU45Ex33u1p9oYR7Npcqw9kwVR
	hg5v0UU6w3HpBeCFNaRmJiTGR89iXrcTrfhQNDA==
X-Google-Smtp-Source: AGHT+IEUxPLfZGcfZDms3e9DWJ7RIAL6AODSM2rUNR/nHOwLN3LVl3C6RxWSOT1tkbwYAFCTuzM/bCzun9x2/tAuCcI=
X-Received: by 2002:a17:903:18a:b0:205:8425:e9c6 with SMTP id
 d9443c01a7336-208d854e7bemr28546445ad.52.1726817163711; Fri, 20 Sep 2024
 00:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Yan, Zheng" <ukernel@gmail.com>
Date: Fri, 20 Sep 2024 15:25:51 +0800
Message-ID: <CAAM7YAkHjVg5qj+6b9HAqbE_d6fugAhdCxqsOHgN06VMjbmQvA@mail.gmail.com>
Subject: [Bug] premature worker thread wakeup
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: vschneid@redhat.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

We recently encountered a kernel oops at for 4.18.0-477 el kernel.

crash> bt
PID: 1501282  TASK: ff232219e1528000  CPU: 17   COMMAND: "kworker/70:0"
 #0 [ff61ef13b2f67c00] machine_kexec at ffffffffb346c033
 #1 [ff61ef13b2f67c58] __crash_kexec at ffffffffb35b5b8a
 #2 [ff61ef13b2f67d18] crash_kexec at ffffffffb35b6ac1
 #3 [ff61ef13b2f67d30] oops_end at ffffffffb342a9c1
 #4 [ff61ef13b2f67d50] no_context at ffffffffb347e913
 #5 [ff61ef13b2f67da8] __bad_area_nosemaphore at ffffffffb347ec8c
 #6 [ff61ef13b2f67df0] do_page_fault at ffffffffb347f8a7
 #7 [ff61ef13b2f67e20] page_fault at ffffffffb400116e
    [exception RIP: _raw_spin_lock_irq+19]
    RIP: ffffffffb3e02113  RSP: ff61ef13b2f67ed8  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: ff23222dcf1d8740  RCX: 0000000000000000
    RDX: 0000000000000001  RSI: 0000000000000246  RDI: 0000000000000000
    RBP: 0000000000000000   R8: ff232206b00739f8   R9: 0000000000000001
    R10: 0000000000000000  R11: ff232206b0071c04  R12: ff232219e1528000
    R13: ff61ef13e16efdc8  R14: ffffffffb35164d0  R15: ff23223f8e6072c0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ff61ef13b2f67ed8] worker_thread at ffffffffb351658f
 #9 [ff61ef13b2f67f10] kthread at ffffffffb351d6a4
#10 [ff61ef13b2f67f50] ret_from_fork at ffffffffb400024f

The cause of the oops is that work_thread function get executed while
worker->pool is  still null

The oops happens immediately after a kernel warning from work_thread's creator

crash> bt 1168590
PID: 1168590  TASK: ff23225d4f078000  CPU: 70   COMMAND: "kworker/70:11"
 #0 [fffffe0000fa1e48] crash_nmi_callback at ffffffffb345e713
 #1 [fffffe0000fa1e50] nmi_handle at ffffffffb342b393
 #2 [fffffe0000fa1ea8] default_do_nmi at ffffffffb3dee089
 #3 [fffffe0000fa1ec8] do_nmi at ffffffffb342b8ef
 #4 [fffffe0000fa1ef0] end_repeat_nmi at ffffffffb40015e8
    [exception RIP: fbcon_redraw_blit+164]
    RIP: ffffffffb3965f44  RSP: ff61ef13e16ef8f0  RFLAGS: 00000006
    RAX: 0000000000000e61  RBX: ff2321a8d2a7c740  RCX: 0000000000000000
    RDX: ff2321a8d2a7c740  RSI: 0000000000000001  RDI: 0000000000000002
    RBP: ff2321a8d2a7c640   R8: 0000000000000010   R9: ff61ef139c4703e0
    R10: 000000000000001e  R11: 0000000000000000  R12: ff2321a8d2a7c742
    R13: ff2321a8d2a7c800  R14: 0000000000000020  R15: 0000000000000006
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ff61ef13e16ef8f0] fbcon_redraw_blit at ffffffffb3965f44
 #6 [ff61ef13e16ef950] fbcon_scroll at ffffffffb3966d58
 #7 [ff61ef13e16ef9a0] con_scroll at ffffffffb3a05adf
 #8 [ff61ef13e16efa10] lf at ffffffffb3a05ba4
 #9 [ff61ef13e16efa38] vt_console_print at ffffffffb3a07cc4
#10 [ff61ef13e16efaa0] console_unlock at ffffffffb3567396
#11 [ff61ef13e16efb60] vprintk_emit at ffffffffb3569521
#12 [ff61ef13e16efbb0] printk at ffffffffb3569b0c
#13 [ff61ef13e16efc10] show_trace_log_lvl at ffffffffb342afe0
#14 [ff61ef13e16efd00] __warn at ffffffffb34f6e74
#15 [ff61ef13e16efd38] report_bug at ffffffffb3dd62a1
#16 [ff61ef13e16efd60] do_error_trap at ffffffffb342733e
#17 [ff61ef13e16efda0] do_invalid_op at ffffffffb3427916
#18 [ff61ef13e16efdc0] invalid_op at ffffffffb4000d64
    [exception RIP: __kthread_bind_mask+29]
    RIP: ffffffffb351c99d  RSP: ff61ef13e16efe70  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ff232219e1528000  RCX: 0000000000000000
    RDX: 0000000000000001  RSI: 0000000000000246  RDI: 0000000000000246
    RBP: ff2321a8c0024a20   R8: 0000000080000000   R9: 00000

Looks like the newly created kthread got woke up prematurely. Checking
the source code, path "workqueue: Unbind kworkers before sending them
to exit()" looks suspicious. The patch wakes up dying worker's task up
without holding pool->lock.  Is it possible that another worker thread
recently died, the newly create worker thread reused the dead thread's
task_struct and wrongly  got woke up.

Regards
Yan, Zheng

