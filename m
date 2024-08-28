Return-Path: <linux-kernel+bounces-305770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF39633FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776E91F24B46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2041AD400;
	Wed, 28 Aug 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="aP5QZB4O";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="SvtfCZxt"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AED1AB531
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881044; cv=none; b=HsUfs7LUJOu7BaPdfnt8NmgDfJ2s64NPwFhszdx2yxeit2UaD1bVcM7gzhM/54Y8BPgMfHXeMhyuNeL36F2H78HnK8V4uzD8Wer16PXChCb2n2ERADxC6L9P80MnOsy0GH9LFiiOkY0qGPF8bF5zkMcHwjIGPAx48mVk2in+x1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881044; c=relaxed/simple;
	bh=0haksBrdfYlCNq5hQizhK6BxPSsBBu/Anbu24tJfB+A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mqzSObh8aJZy9R7k78rnpHwBQ8+FBvO070ytPbvEjv2Kj9W6Y/gSpWWTg5hPOnoPjA0vg+MFmLq6QEe4kplorbJoN6t7G21y5fkfpIp3qlWlZDW+00BlT3fduVhtfxQx+Xd9+y8cayv6NJIQrg+jmUHMKvVAC2KYBRGlDmede8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=aP5QZB4O; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=SvtfCZxt; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724881043; x=1756417043;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=0haksBrdfYlCNq5hQizhK6BxPSsBBu/Anbu24tJfB+A=;
  b=aP5QZB4OhdaxFKJ+BGttnwKGgK/Ht6o7q+gj5/ZN/enN1b6iMYIX+sQA
   NSFNfsm+4ald2Luk/2z4kdleRxPqsxznP0baB01qu+p9thTOQOhBsTEb0
   hCMc3JedDkUzyOzbFTJgnPdxjCE6z+VM+RMGFg32GMRdQsKU+fcSJoHC9
   hoHFRdRF/9n4v8s9/NnQXkVdYZZoQVhAHHI3rS7dkF/75aaf1YdZnXFxD
   hmhw9psZPyzmUAEuhK7uYts9hBup/oD8lOYnewYj3irkFy8QzNQf3bgIe
   Y8/T+Jdk4aPkvY9QVpRV4Ooesjx/z3Uq+yoFM53Sr6ye+8Os8bw9kTfVF
   g==;
X-CSE-ConnectionGUID: Poirwb6rStaDpY4TNpvrOg==
X-CSE-MsgGUID: OaYiz+6GQ1eWA66BPuGKVA==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 14:37:16 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d699beb78dso5100450a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724881035; x=1725485835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QU8B1TkKudrXi3t6vU2mLRqC95KcE+EPN+9AF0WMWOU=;
        b=SvtfCZxtGcfA6sxhfc7KvvhN8u2/b3bv7Fg/fPra9iLNptFeCGtd5LhnTjh/qZZqGx
         nfRRSZKEk33lIY5tFeFLfMtxae5ixvm08Xme3hbeF45T0uDT9XA3JkO4+ce7Ojigabho
         3nTvDsZg0mcjuEXUy3yN8KdVFWNU4QYaInoaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881035; x=1725485835;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU8B1TkKudrXi3t6vU2mLRqC95KcE+EPN+9AF0WMWOU=;
        b=N5ZZRdvojchn3M6ZGEQEMFxCvkkhZBoSTV6CT5TJ3Fvd5YkkLZHowo7uU31WhFVZrA
         t0juKJushhbx8eCPQU3zgCttIpzpB8PAFlaIx6Vb3KJBenwE7Kgwzm7KgY2/ugfWLWnW
         jt1UMqKX8OfAoJIF+RCjh6bIqW3gEAtb8HQZk1LQzrez5RRlyhJvXEa0Io0klj8/ricp
         eELoq6q/aiXNJzG06yt9lyE4Sv2L2IKQCmy3+7BdxWySSDzIJUaZ/mQqXRANvyNP31op
         3F8RypQqYkUu3c698/WXuL0Sd26Pb+IxBRktceRhgHhcm7qGcJ3oSk6jrmJxsdfPKCXK
         3LKw==
X-Forwarded-Encrypted: i=1; AJvYcCWK+GFRM6U0vN806r5rCSm+GNy9/CchICMgcY+uAHetcLVRhC3sk35LEkaMCHNPvJE8wG7DxlzxBL0DOsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPB4Ngr69DZxwcS5D4x2Ipcwtn8SJjRGBGKX7embF3whnzWH03
	hJmwQ53oSVUQzk8iULXctEfgO2ZWGgobCfSTSu8e49riEV3Ydn5kIj0ImugHdY8vonOaoV5bDrs
	m/9yvu/OdeYHvTAlQbKHtel86+8EeqFst5AiqCsOvA5+p/J7DyBBzmq7sz1yUO2gLKEc9gL4lK5
	Y0SxKdHaQs55TTlkiOgLLiu7SmfaRNh2UC+BbEaJ86HxScGE6vnSc=
X-Received: by 2002:a17:90b:204:b0:2c4:aa78:b48b with SMTP id 98e67ed59e1d1-2d8564ad2e8mr717421a91.38.1724881034964;
        Wed, 28 Aug 2024 14:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhmH98AhDlCMsobVBa8AbjzqM3ZS37VCwF14SOZHioc0I5Lh1Ow0KhTADaXXlDeEYLA0Zv9EhmZ2wPQa+/NoI=
X-Received: by 2002:a17:90b:204:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2d8564ad2e8mr717406a91.38.1724881034589; Wed, 28 Aug 2024
 14:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 14:37:04 -0700
Message-ID: <CALAgD-5kt+F6S1aAwRhKMKb0KwFGzfJCWyHguotEvJGBBBvFkA@mail.gmail.com>
Subject: BUG: WARNING in free_pgtables
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a  logic bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/5f0c95e95e1bc0fb681e504114b61de8

The bug report is:

WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203
mmap_assert_write_locked include/linux/mmap_lock.h:70 [inline]
WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203
__is_vma_write_locked include/linux/mm.h:714 [inline]
WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203 vma_start_write
include/linux/mm.h:733 [inline]
WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203
free_pgtables+0x4df/0xbb0 mm/memory.c:403
Modules linked in:
CPU: 0 PID: 8053 Comm: syz-executor107 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:rwsem_assert_held_write include/linux/rwsem.h:203 [inline]
RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:70 [inline]
RIP: 0010:__is_vma_write_locked include/linux/mm.h:714 [inline]
RIP: 0010:vma_start_write include/linux/mm.h:733 [inline]
RIP: 0010:free_pgtables+0x4df/0xbb0 mm/memory.c:403
Code: 04 00 4d 85 e4 0f 84 86 03 00 00 e8 3b 46 b6 ff 4d 89 ee 4d 89
e5 49 bc 00 00 00 00 00 fc ff df e9 86 fd ff ff e8 21 46 b6 ff <0f> 0b
e9 b8 fe ff ff 48 c7 c1 6c 91 24 8f 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000ac7f748 EFLAGS: 00010293
RAX: ffffffff81db0b3f RBX: ffff88801d8cbe98 RCX: ffff888021fa1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81db09ea R09: ffffffff8aed5df0
R10: 0000000000000004 R11: ffff888021fa1e00 R12: ffff88802ce66ba0
R13: ffff88801d8cbe88 R14: ffff88802ce66aa8 R15: 1ffff11003b197d1
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff0448ce6b0 CR3: 00000000244bc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exit_mmap+0x435/0xa20 mm/mmap.c:3352
 __mmput+0x114/0x3b0 kernel/fork.c:1346
 exit_mm+0x207/0x2e0 kernel/exit.c:567
 do_exit+0x996/0x2560 kernel/exit.c:863
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 get_signal+0x1697/0x1730 kernel/signal.c:2909
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fb06353406d
Code: Unable to access opcode bytes at 0x7fb063534043.
RSP: 002b:00007fb0634d10c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000002 RBX: 00007fb0635c92e8 RCX: 00007fb06353406d
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 00007fb0635c92e0 R08: 00007fb0634d1640 R09: 0000000000000000
R10: 00007fb0634d1640 R11: 0000000000000246 R12: 00007fb0635c92ec
R13: 0000000000000000 R14: 00007fb0634f67c0 R15: 00007fb0634b1000
 </TASK>


-- 
Yours sincerely,
Xingyu

