Return-Path: <linux-kernel+bounces-185411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD188CB4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09D71F222CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079E1448CD;
	Tue, 21 May 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPlyFa3p"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D501FBB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322654; cv=none; b=SPY7SJtV14DV1e8eAnxeYEviR/CxlBAyt7+/q2HdbyDMipnhRj2NFeQv3MlcEej3y/obLjDIzFvVTwnYQnl377oirVrz671snntKybso8EXijvt+Gqz40H/DqE/jG/curwnQFlBYKxpKEBSOEDrtAXdvrIW/owsMw9KbLoOJN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322654; c=relaxed/simple;
	bh=J+jTv5/XdKdeRhEkguVecTLtxwrTi+cdqmbIHbV7RsY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BqzT3MW1vyIwwvH8BkizoUu3R4KF8egsX/Kws6fKFpxy1VE9vsM0Mx+b4tmI/60+lmeGfe+u7LU4VLITF/IG+TUX5e7VUnfrtJpesaYO0UQQBGS3r5KqYmfPkHHig/HWfG3GyRALqrLWjpIT6JJqAnHZQMkhz/EBUyDdvzXl4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPlyFa3p; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b281f0d06dso526337eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716322651; x=1716927451; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOB8s62Zn2lIWiIrX8U53Ok8gPcOrtU1W9iR47SvD6s=;
        b=hPlyFa3pb6W7j4AR97iokSbTZXEdRpm6zdtnC0CLwme/oqLBGd9lOWWoivoZ9h8JYG
         h5WFzYYPqkgHFks07/N4dB0LO3jNKe+YFEPFTe+URDUo7sMPU5dX/vnzKvW4YLzrY/Z/
         5BLNneoXQsWYwpnsXGKQB621H+Rr4SJP+ccM09NvLZR+mJHCkoIogtMqr46VzTuqSTn6
         WughbFDKr1Ik4vaW1NPn2hnhIQWL5M3po29FhqUeh4PrpzNWu2WNOAYAcL7vfch9A+He
         ZhspXkdeJ2XKC8CcpgnhEbKQUBC/5H60WTaof+u6d78rWrZWSJRQj44gneS6JqwiwVfh
         mlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716322651; x=1716927451;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOB8s62Zn2lIWiIrX8U53Ok8gPcOrtU1W9iR47SvD6s=;
        b=QfWkGmY+2t9OZ7g5gentJdMI/PpGgEiQLdXn/QeM/mEIr0XuX6gAeKSZ7qURNHK0NR
         lqWbA7GUn6U++inss2rMVj16MI6fTOFN0TRu5sr9LTRER0hk7XN13LJ/nQakd75FBWIr
         04jQl4RwnQpCPSUdV8kfW/cSoeT+jgTredho/LRRqEhbFc4forYVmZtuyZmlhZzLlBWc
         xR1pmK7oZJSJ3/MgJQbaObR5zlwTJ3fHseiP0AC9Ct3ovh3tGZ1nnayPSXVoabHQ27lL
         BIz1QnlOQyiK4H0JiKMcim93vwEU6uNvT+MUCWmQKBVIDAM0HVQrBUlAcakf3IXbXjdk
         0D3w==
X-Forwarded-Encrypted: i=1; AJvYcCV4MTPMMaJ//Opje2dmhpkJC1xbpen8f6qyf2GFngiLQabgi7m238khFU70s2+daUhRcr1DiydBlG1pk4tLsgW2Ur9bYL7rKdMRNeLY
X-Gm-Message-State: AOJu0Yywer/DvY5djOPPT3b5P/qwEzZ3bYRInh0Rj2VEIqXGy3FO/LtY
	E1WqdSX1URLFJ6qmoNozMQ7htErXWVFalYiT/mNQo4XrNitOZEjh4+1iO28Vqh3zPyZE0Y8zzsd
	mxv/vb/MnPWu/czWGnhPXf3M/Pvs=
X-Google-Smtp-Source: AGHT+IGbVkdSN+H2TkGHSpeWP9tPCzjgpWs3+wDBGVSZLh9eB9NqqKpc2RItDQgKepehZeaIRK6FWO+GzTKeKrvtyR0=
X-Received: by 2002:a05:6358:e49d:b0:192:47fd:8bf0 with SMTP id
 e5c5f4694b2df-1974db69223mr465066055d.3.1716322651109; Tue, 21 May 2024
 13:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 22 May 2024 01:17:19 +0500
Message-ID: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
Subject: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
To: peterx@redhat.com, Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com, 
	David Hildenbrand <david@redhat.com>, nadav.amit@gmail.com, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,
Yesterday, after the next kernel snapshot update I spotted new warning
at mm/page_table_check.c:198 with follow stacktrace:
[    5.524572] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    5.572473] ------------[ cut here ]------------
[    5.572871] WARNING: CPU: 0 PID: 1 at mm/page_table_check.c:198
__page_table_check_ptes_set+0x306/0x3c0
[    5.573364] Modules linked in:
[    5.573604] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
  -------  ---
6.10.0-0.rc0.20240520giteb6a9339efeb.9.fc41.x86_64+debug #1
[    5.574089] Hardware name: ASRock B650I Lightning WiFi/B650I
Lightning WiFi, BIOS 2.10 03/20/2024
[    5.574339] RIP: 0010:__page_table_check_ptes_set+0x306/0x3c0
[    5.574591] Code: 74 24 04 89 ea 48 89 df e8 e7 f3 ff ff e9 12 ff
ff ff 0f 1f 44 00 00 48 c1 e8 06 89 c5 83 e5 01 e9 b0 fe ff ff f6 c2
02 74 31 <0f> 0b e9 de fd ff ff 49 83 e7 f7 48 89 c1 4c 21 f9 89 ca 83
e1 02
[    5.575434] RSP: 0018:ffffc9000018f9d0 EFLAGS: 00010246
[    5.575739] RAX: fff0000000000fff RBX: ffff888124da5000 RCX: 0000000000000001
[    5.576064] RDX: 0000000000000040 RSI: bffffffffffffff5 RDI: ffffc9000018fa00
[    5.576395] RBP: ffff888124511e40 R08: 0000000000000000 R09: 0000000000000001
[    5.576730] R10: ffffffff97f63527 R11: 0000000000000000 R12: ffffea0005000008
[    5.577048] R13: 1ffff92000031f3c R14: 0000000000000000 R15: bffffffffffffff5
[    5.577335] FS:  0000000000000000(0000) GS:ffff888df7e00000(0000)
knlGS:0000000000000000
[    5.577631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.577925] CR2: ffff888a53601000 CR3: 0000000a4de98000 CR4: 0000000000f50ef0
[    5.578208] PKRU: 55555554
[    5.578483] Call Trace:
[    5.578496] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    5.578760]  <TASK>
[    5.579331]  ? __warn.cold+0x5b/0x1af
[    5.579618]  ? __page_table_check_ptes_set+0x306/0x3c0
[    5.579903]  ? report_bug+0x1fc/0x3d0
[    5.580188]  ? handle_bug+0x3c/0x80
[    5.580461]  ? exc_invalid_op+0x17/0x40
[    5.580731]  ? asm_exc_invalid_op+0x1a/0x20
[    5.581003]  ? __page_table_check_ptes_set+0x306/0x3c0
[    5.581274]  ? __pfx___page_table_check_ptes_set+0x10/0x10
[    5.581544]  ? __pfx_check_pgprot+0x10/0x10
[    5.581806]  set_ptes.constprop.0+0x66/0xd0
[    5.582072]  ? __pfx_set_ptes.constprop.0+0x10/0x10
[    5.582333]  ? __pfx_pte_val+0x10/0x10
[    5.582595]  debug_vm_pgtable+0x1c04/0x3360
[    5.582849]  ? __pfx_debug_vm_pgtable+0x10/0x10
[    5.583099]  ? add_device_randomness+0xb8/0xf0
[    5.583334]  ? __pfx_add_device_randomness+0x10/0x10
[    5.583573]  ? __pfx_debug_vm_pgtable+0x10/0x10
[    5.583804]  do_one_initcall+0xd6/0x460
[    5.584034]  ? __pfx_do_one_initcall+0x10/0x10
[    5.584252]  ? kernel_init_freeable+0x4cb/0x750
[    5.584465]  kernel_init_freeable+0x6b4/0x750
[    5.584674]  ? __pfx_kernel_init_freeable+0x10/0x10
[    5.584877]  ? __pfx_kernel_init+0x10/0x10
[    5.585068]  ? __pfx_kernel_init+0x10/0x10
[    5.585253]  kernel_init+0x1c/0x150
[    5.585434]  ? __pfx_kernel_init+0x10/0x10
[    5.585616]  ret_from_fork+0x31/0x70
[    5.585791]  ? __pfx_kernel_init+0x10/0x10
[    5.585971]  ret_from_fork_asm+0x1a/0x30
[    5.586146]  </TASK>
[    5.586312] irq event stamp: 1743772
[    5.586475] hardirqs last  enabled at (1743771):
[<ffffffff92c35f2e>] kasan_quarantine_put+0x12e/0x250
[    5.586816] hardirqs last disabled at (1743772):
[<ffffffff9546895c>] _raw_spin_lock_irqsave+0x7c/0xa0
[    5.587185] softirqs last  enabled at (1742786):
[<ffffffff922721fb>] __irq_exit_rcu+0xbb/0x1c0
[    5.587379] softirqs last disabled at (1742781):
[<ffffffff922721fb>] __irq_exit_rcu+0xbb/0x1c0
[    5.587573] ---[ end trace 0000000000000000 ]---
[    5.656111] page_owner is disabled

Bisect is pointed to commit:
8430557fc584657559bfbd5150b6ae1bb90f35a0
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Apr 17 17:25:49 2024 -0400

    mm/page_table_check: support userfault wr-protect entries

    Allow page_table_check hooks to check over userfaultfd wr-protect criteria
    upon pgtable updates.  The rule is no co-existance allowed for any
    writable flag against userfault wr-protect flag.

    This should be better than c2da319c2e, where we used to only sanitize such
    issues during a pgtable walk, but when hitting such issue we don't have a
    good chance to know where does that writable bit came from [1], so that
    even the pgtable walk exposes a kernel bug (which is still helpful on
    triaging) but not easy to track and debug.

    Now we switch to track the source.  It's much easier too with the recent
    introduction of page table check.

    There are some limitations with using the page table check here for
    userfaultfd wr-protect purpose:

      - It is only enabled with explicit enablement of page table check configs
      and/or boot parameters, but should be good enough to track at least
      syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
      x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
      while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], which
      is similar.

      - It conditionally works with the ptep_modify_prot API.  It will be
      bypassed when e.g. XEN PV is enabled, however still work for most of the
      rest scenarios, which should be the common cases so should be good
      enough.

      - Hugetlb check is a bit hairy, as the page table check cannot identify
      hugetlb pte or normal pte via trapping at set_pte_at(), because of the
      current design where hugetlb maps every layers to pte_t... For example,
      the default set_huge_pte_at() can invoke set_pte_at() directly and lose
      the hugetlb context, treating it the same as a normal pte_t. So far it's
      fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() as
      long as supported (x86 only).  It'll be a bigger problem when we'll
      define _PAGE_UFFD_WP differently at various pgtable levels, because then
      one huge_pte_uffd_wp() per-arch will stop making sense first.. as of now
      we can leave this for later too.

    This patch also removes commit c2da319c2e altogether, as we have something
    better now.

    [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/

    Link: https://lkml.kernel.org/r/20240417212549.2766883-1-peterx@redhat.com
    Signed-off-by: Peter Xu <peterx@redhat.com>
    Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
    Cc: Axel Rasmussen <axelrasmussen@google.com>
    Cc: David Hildenbrand <david@redhat.com>
    Cc: Nadav Amit <nadav.amit@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

 Documentation/mm/page_table_check.rst |  9 ++++++++-
 arch/x86/include/asm/pgtable.h        | 18 +-----------------
 mm/page_table_check.c                 | 30 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 18 deletions(-)


For convincing that bisect was a correct I reverted this commit and
checked again kernel snapshot.
And yes, the warning message is gone.

I also attach below a full kernel log and build config.

My hardware specs: https://linux-hardware.org/?probe=b34f0353df

Peter, can you look please.

-- 
Best Regards,
Mike Gavrilov.

