Return-Path: <linux-kernel+bounces-445389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1229F1563
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13536284CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526941E8826;
	Fri, 13 Dec 2024 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="NiUr2i6E"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1073186E26
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116485; cv=none; b=jHaM29/q0aXmGh6AKfPaXanXkz9nMvndAotbx44nI3gZZclgPWe4OJlD7dS89buMNyTwpux3dE3kig+TjcNbpCODtMsQ8mrcoltQYApD3pgVT349W6hFFz2JrLVddpctm1TbM45/TTl1edwkLLd95XPh7NdW3kmRml5LtzZIMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116485; c=relaxed/simple;
	bh=6qZZv74j3Eh3+j2GI8n67jgclLOm4gEfgC9POYlD918=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAvxBFTxu9nadgnp3NMqzFeo84lJUZsjJ7hKCud11Tv+JnKxuiFbzTPj+161EQu8IO0H/JFRZ7Q6TjQzmzBj8MQdl+74qJFRG2toDGCdz/bpRe8yhNO7wCKF/vEzaHAzOwoEbML4KpoOowOHWyBPRlKbgPLbcMdHtffZWXtV6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=NiUr2i6E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385dece873cso988120f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1734116482; x=1734721282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4m13vCCBKTqBry3aFlhV2JfiYUb/7guhNHrTwL+mtiE=;
        b=NiUr2i6EtkXpAfF7Tt0l2eXSGfK+z4rHDfiaF8WY5ObO8nmpAG29krgsXOtiG82t7z
         42bGDY2w2pWCKYGvaRIwb7vbEB/FQ6wHTa7foIufNw7guSaf/JozBmjxvls0WKNP0N+I
         Zf3GnbDmXNkWXgInZWOodK712IvBNRGi61tg8KrPhl5mjC8bFWOibSX+d0KDJXkLMhP6
         Ui4Nqb3Tx/ra/pvJYTRp33EQDEylUz7YAuO2f1KAfIJUdCcqDItmwzw5by7TaZY90srd
         YhlQz2i4cKpH3HBSd84vx6il1w1d3w0RAcKJtFzqQljVorzzDZ1puPWBgBgOpvGoX8hv
         ljYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116482; x=1734721282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m13vCCBKTqBry3aFlhV2JfiYUb/7guhNHrTwL+mtiE=;
        b=lPoVzzBy+tXbqq4Vuz4bbg6QiTmRzNdxbvRlfEm/D7kCGneXu8KhU92rQLiCgMZV39
         d4dTjPNzfZ13i/SXIAAmgY49EH6E8mThe64B4d73JxJPYjItu2ZgLhKZqM2zNol/Qoui
         H+Nugz/PLuWMr7jJF46lCoolNCDfuppn7k901kiZeM2uhcMpFgsMYjOsxbAnQBF0be7F
         BLy+N622QJfNliIcOMvg1dHqxAzp9qmva451kSLJF3Dvb27nkHULm25h0yLBb+qyy8+9
         551scuysqDaQZv6GXh8g7lkS5ocy6oh4yQCEugvuWhwM3NPcHkMlYjN6rLizhyCTa2hy
         vZbA==
X-Forwarded-Encrypted: i=1; AJvYcCVTnj3ZPvFzr/EYaA4jfBZHAbunCWRerlC+NtQtTvebTBhkzwJtOd5egg/kSVmbt8f14y1IN3LnujAb5cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMChqZYnjQPbgFUYKR1e2aI0Yh4k6X+dRYdMKn1DYNLvB92edC
	t3SAwxrXcnJ0HZ5/DxLD5KY4K/HN2TJAON2oclKOtpTD6UmWKhmwT7oyngiWpx4=
X-Gm-Gg: ASbGncu56LpWyNX9KQ4f26ryrdmVXJhACMqDyqLsZ58mKkJxvZtvwrOY12b9XqJYuQ4
	rSMWcwjhcatsPpA2kP+bmIKN4kdfSS6yz3crAbj1n6oAppI3zNIExB7Duh31MCAARXZXdJb49UK
	vTMHZFowDkJwEkjICrxG4vYJo/6mwRvPSafr8UBuH7PlL4I3v9kyE8TpICMpahlmH2SSN2lwBoj
	eS2kzMMowv0K2d0oeoGaDhv/XoWLsOkVKbf/hVJzCbU/4J83YL94B7jsA==
X-Google-Smtp-Source: AGHT+IG+XpcnzLmneWQaGoVkhVxssdOFtaSeSE5WQ0scRH6YIC08hml7qiFRgDFa4KE5e2pufSRZ9w==
X-Received: by 2002:a05:6000:1f82:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-38880ac4e71mr2829693f8f.2.1734116481724;
        Fri, 13 Dec 2024 11:01:21 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::319:ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012249sm287238f8f.10.2024.12.13.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:01:21 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: Jakub Jelinek <jakub@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <matt@readmodwrite.com>
Subject: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
Date: Fri, 13 Dec 2024 19:01:19 +0000
Message-Id: <20241213190119.3449103-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

I've run into following Oops when running with KASAN enabled:

  [   22.938710][    T0] Oops: general protection fault, probably for non-canonical address 0xdffffc00000087c8: 0000 [#1] PREEMPT SMP KASAN NOPTI
  [   22.939369][    T0] KASAN: probably user-memory-access in range [0x0000000000043e40-0x0000000000043e47]
  [   22.939369][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.1-cloudflare-kasan-2024.11.20 #1
  [   22.939369][    T0] Hardware name: MACHINE, BIOS VERSION 09/04/2024
  [   22.939369][    T0] RIP: 0010:switch_mm_irqs_off+0x43/0xd70
  [   22.939369][    T0] Code: 48 83 ec 20 48 c7 c0 40 3e 04 00 65 48 8b 1d 14 41 91 77 48 ba 00 00 00 00 00 fc ff df 65 44 0f b7 25 11 41 91 77 48 c1 e8 03 <0f> b6 04 10 84 c0 74 06 0f 8e be 09 00 00 65 44 0f b6 2d a6 41 91
  [   22.939369][    T0] RSP: 0000:ffffffff8ce07e00 EFLAGS: 00010012
  [   22.939369][    T0] RAX: 00000000000087c8 RBX: ffffffff8d20a740 RCX: 0000001850076000
  [   22.939369][    T0] RDX: dffffc0000000000 RSI: ffffffff8d7a28c0 RDI: 0000000000000000
  [   22.939369][    T0] RBP: ffffffff8d7a28c0 R08: 00000000aa299018 R09: e4977f26b7bc541a
  [   22.939369][    T0] R10: ffffffff8ce07e00 R11: 8000000000000063 R12: 0000000000000000
  [   22.939369][    T0] R13: 0000001850076000 R14: 0000000000000000 R15: ffff889850076000
  [   22.939369][    T0] FS:  0000000000000000(0000) GS:ffff8887efa00000(0000) knlGS:0000000000000000
  [   22.939369][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   22.939369][    T0] CR2: ffff88c04f1ff000 CR3: 00000037f4852001 CR4: 0000000000770ef0
  [   22.939369][    T0] PKRU: 55555554
  [   22.939369][    T0] Call Trace:
  [   22.939369][    T0]  <TASK>
  [   22.939369][    T0]  ? __die_body.cold+0x19/0x21
  [   22.939369][    T0]  ? die_addr+0x46/0x70
  [   22.939369][    T0]  ? exc_general_protection+0x119/0x210
  [   22.939369][    T0]  ? asm_exc_general_protection+0x26/0x30
  [   22.939369][    T0]  ? switch_mm_irqs_off+0x43/0xd70
  [   22.939369][    T0]  ? __pfx_efi_memmap_init_late+0x10/0x10
  [   22.939369][    T0]  switch_mm+0x14/0x20
  [   22.939369][    T0]  efi_set_virtual_address_map+0x75/0x180
  [   22.939369][    T0]  ? srso_alias_return_thunk+0x5/0xfbef5
  [   22.939369][    T0]  efi_enter_virtual_mode+0x6fb/0x7c0
  [   22.939369][    T0]  ? alt_reloc_selftest+0x1f/0x50
  [   22.939369][    T0]  start_kernel+0x323/0x3a0
  [   22.939369][    T0]  x86_64_start_reservations+0x24/0x30
  [   22.939369][    T0]  x86_64_start_kernel+0x7f/0x80
  [   22.939369][    T0]  common_startup_64+0x13e/0x141
  [   22.939369][    T0]  </TASK>

This was supposed to be fixed by the compiler version check in
f61f02d1ff78 ("x86/percpu: Re-enable named address spaces with KASAN for
GCC 13.3+"), but I'm still able to trigger this problem with both GCC
14.1.0 and GCC 13.3.0 which include fixes for PR sanitizer/111736.
(Reverting f61f02d1ff78 obviously prevents the oops)

Here's the assembly that shows the ASAN protection kicking in for the
per-CPU addresses (cpu_tlbstate):

  ffffffff8112fc40 <switch_mm_irqs_off>:
  ffffffff8112fc40:       f3 0f 1e fa             endbr64 
  ffffffff8112fc44:       e8 e7 79 fd ff          call   ffffffff81107630 <__fentry__>
  ffffffff8112fc49:       41 57                   push   %r15
  ffffffff8112fc4b:       41 56                   push   %r14
  ffffffff8112fc4d:       49 89 d6                mov    %rdx,%r14
  ffffffff8112fc50:       41 55                   push   %r13
  ffffffff8112fc52:       41 54                   push   %r12
  ffffffff8112fc54:       55                      push   %rbp
  ffffffff8112fc55:       48 89 f5                mov    %rsi,%rbp
  ffffffff8112fc58:       53                      push   %rbx
  ffffffff8112fc59:       48 83 ec 20             sub    $0x20,%rsp
  ffffffff8112fc5d:       48 c7 c0 40 3e 04 00    mov    $0x43e40,%rax
  ffffffff8112fc64:       65 48 8b 1d 14 41 f1    mov    %gs:0x7ef14114(%rip),%rbx        # 43d80 <cpu_tlbstate>
  ffffffff8112fc6b:       7e 
  ffffffff8112fc6c:       48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
  ffffffff8112fc73:       fc ff df 
  ffffffff8112fc76:       65 44 0f b7 25 11 41    movzwl %gs:0x7ef14111(%rip),%r12d        # 43d90 <cpu_tlbstate+0x10>
  ffffffff8112fc7d:       f1 7e 
  ffffffff8112fc7f:       48 c1 e8 03             shr    $0x3,%rax
  ffffffff8112fc83:       0f b6 04 10             movzbl (%rax,%rdx,1),%eax

         Fault occurs here due to ASAN -----------^


Anyone got any ideas how to debug this further?

