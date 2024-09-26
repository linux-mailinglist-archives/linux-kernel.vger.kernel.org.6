Return-Path: <linux-kernel+bounces-340335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD89871BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8613C1C227CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEA1AD5E6;
	Thu, 26 Sep 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSLW1jLP"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE61AD3FE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347313; cv=none; b=BQ6QCgHBr9ob4in5RnLslAcS3xatb63FSidTl+pBZggsTFOJR+5ktKJKN1lUYm11iqrMWSGLhLqC+l9W4h2DdpjaEM2nxFZD+JNYvHnYZ2V9NbkD7B7AAgna3JiLvYngctUZm0tksjV8OuuFQKTH75K5Hb5KKJLNAzOBVGdGHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347313; c=relaxed/simple;
	bh=i+rTe3Ud96FXPYDbFGQ69+Pp7Cq4F9R865FOwFP2JRk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o7vEuUfXLQ4VnRH2S4evsnUwB74glxspF4a6HuQKs3IV1WIgPdCTahcAPbub3FJByfRozolNAO7vS3HoPeR217eSYXpvcHeCSfnSaCAk/gYw0Z+/dCxVwWwWY6NJ37YcHMi3ViV6/hux80ko+Qyzze+u9sljVE2r6gAbppif6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSLW1jLP; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a8a6fee3ab1so66874066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347309; x=1727952109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSLBX9kmp1nbYan62YJy8OBvQyiXlF26r+PplytHp80=;
        b=xSLW1jLPW7bs+E/mKaRzvdDtj7Eor/vqoeYjKdR9YGiN1DOj6nhBuJYCrn9kJIRlCj
         Kqyh5S0IDXel/EZEy7uWzTKK3+1IDJiJgE4Lamx0nPhYL1OAYoPfMGttSjW82H140zBq
         brTE+xS9Wxs+QhKV6EOrDspyOsuzBQVtwlhAgjmYz0uHQypmN8rxw9/wk4rvlLoN2KF6
         0lOAYjKfcHNAOtRPRYp0BrNehWE9BCmx7iIodi/nr8OvuDcBRXOSuMolP1md579yBM/g
         iadxlKfUwF+NHMDu1DDZTFBL3VEWAiV9aoHfSd/i8Piea82Bf6R0MGTwvvcLcgt4BWyJ
         h2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347309; x=1727952109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSLBX9kmp1nbYan62YJy8OBvQyiXlF26r+PplytHp80=;
        b=sWvXg9e7dD4Hduij9spvSmM9t0uwIeQTpnFplZdereI4us0V69WjjIzwjkkWsTYKdX
         S7C7f5392bBWT9VnC3UMmzlZLlqsL2GGKzOLIX96kK+amFTRKZ9rNCN7PS1In+fnKPDJ
         GYijxx+ScFMI45jUUxfZ/ODMTl686PNgrxG/GBThuA0pKDCTbnlO07wK1rDnFu1yMTRC
         l+s+ebuqi0xpguPAYkOUqkYV/AdNej/6rH0IRJP6SdrxmMY0grFEA8VXjXDDGhw8qomH
         41xYvHHYFfJK2YgJVehYtiMxdFQVhc9T2U/mSucoV5a7UoRSGAAuih2ytHOHMP6qQEu8
         YnXg==
X-Gm-Message-State: AOJu0Yz5XnodkWa3aiYebtppvgTcDIGbzkaXJkRn5WmO7GdbKSZ1a6Li
	QGfqpbusRaqkdVkPIuc5u9tzTDe4VpHw1OmTk3zdRz+AxobaDrmJu77YLQ3U0d5xKtRu4wTBjfE
	/zH7GoSboXolOtVfLH9NofHl/Uitm9HTzhz5jymuJffwatRZSyslxb239NTKXPT7ETUBBD+xwlt
	1HaQkwPu5zc9S2QggqU2MUue61/LWYvA==
X-Google-Smtp-Source: AGHT+IHnqm4XoQMPFbClWJRFC7BHLidpH9Q8eU25gNI0jgFL8aZqDFQy6hanTue4qdLPPwt/LZTQNTfO
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a17:906:cf8a:b0:a8d:da3:dc with SMTP id
 a640c23a62f3a-a93a035ca9bmr300366b.4.1727347308814; Thu, 26 Sep 2024 03:41:48
 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:41:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4166; i=ardb@kernel.org;
 h=from:subject; bh=Uws/4OaEYtp6QUfD5Ms5Ag3QaKuSAmOS3eQ0kcg80f4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2rlZcV4/v+gpv7xcz/NR3P2fp5y2zHt7vsF7psfBqlV
 Ji+5pVWRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI8Q+MDLtPTb9VOblUzGLi
 3Q83zsrNkf57Ma2GY63zmRkTmZMi9oUzMvyTn73lYtxLq+lRQfU3LRLzWx4vzlnyIrVNtWdqskg JHx8A
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926104113.80146-7-ardb+git@google.com>
Subject: [PATCH 0/5] x86/xen: Drop absolute references from startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series was broken out of the series I sent yesterday [0], after
Jason pointed out that my Xen startup code changes conflict with his
changes to make the PVH startup code position independent.

Jason's work reduces the delta of my changes, and given that my other
series will likely advance at a much slower pace, the Xen changes are
presented here so they can be merged independently.

The end result after applying this series (see below) is that there are
no longer any Xen-related absolute relocations that need to be applied
to .head.text, which carries code that may be invoked from the 1:1
mapping of memory before the kernel virtual mapping is up.  The use of
absolute references in this code section has resulted in a few boot
issues that were very hard to track down (Clang built kernels running
under SEV-SNP in particular, which does not provide the best debug
experience).

Even though the occurrences in the Xen startup code were fine, there is
now a lot of C code emitted into .head.text as well, and so it would be
helpful to teach objtool to reject absolute references entirely in this
section (or rely on the linker for that). Therefore, not relying on them
in the first place is a step towards that goal.

Changes wrt [0]:
- add Jason's Rb to patch #1
- rebase onto xen/tip's linux-next branch
- split out fix for GDT descriptor size field
- add patch to remove the zeroing of phys_base, which is no longer
  needed
- use a 32-bit field for XEN_ELFNOTE_PHYS32_ENTRY, and use its contents
  to obtain the build time physical address of pvh_startup_xen()

[0] https://lore.kernel.org/all/20240925150059.3955569-30-ardb+git@google.com

Relocation section '.rela.head.text' at offset 0xb428 contains 15 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000018  000800000002 R_X86_64_PC32     0000000000000000 .init.data + 18
00000000002f  000e00000002 R_X86_64_PC32     0000000000000000 pvh_start_info + 2f
000000000037  000f00000002 R_X86_64_PC32     0000000000000000 pvh_start_info_sz + 37
000000000042  000800000002 R_X86_64_PC32     0000000000000000 .init.data + 4092
000000000060  001000000002 R_X86_64_PC32     000000000000002c xen_elfnote_phys3[...] + 60
000000000068  001100000002 R_X86_64_PC32     0000000000000000 phys_base + 68
00000000006e  001200000002 R_X86_64_PC32     0000000000005000 pvh_init_top_pgt + 6e
000000000089  001300000002 R_X86_64_PC32     0000000000006000 pvh_level3_ident_pgt + 89
000000000091  001400000002 R_X86_64_PC32     0000000000008000 pvh_level3_kernel_pgt + 91
0000000000a3  001500000002 R_X86_64_PC32     0000000000009000 pvh_level2_kernel_pgt + a3
0000000000be  001200000002 R_X86_64_PC32     0000000000005000 pvh_init_top_pgt + be
0000000000de  000800000002 R_X86_64_PC32     0000000000000000 .init.data + 1c
0000000000e9  001600000002 R_X86_64_PC32     0000000000000000 xen_prepare_pvh - 4
0000000000f8  001700000002 R_X86_64_PC32     0000000000000000 pvh_bootparams - 4
0000000000fd  001800000004 R_X86_64_PLT32    0000000000000000 startup_64 - 4

Relocation section '.rela.note.Xen' at offset 0xb668 contains 1 entry:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
00000000002c  001a00000002 R_X86_64_PC32     0000000000000000 xen_elfnote_phys3[...] + 0

Cc: Jason Andryuk <jason.andryuk@amd.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org

Ard Biesheuvel (5):
  x86/pvh: Call C code via the kernel virtual mapping
  x86/pvh: Use correct size value in GDT descriptor
  x86/pvh: Omit needless clearing of phys_base
  x86/xen: Avoid relocatable quantities in Xen ELF notes
  x86/pvh: Avoid absolute symbol references in .head.text

 arch/x86/kernel/vmlinux.lds.S | 12 +++++
 arch/x86/platform/pvh/head.S  | 49 +++++++++++---------
 arch/x86/tools/relocs.c       |  1 +
 arch/x86/xen/xen-head.S       |  6 ++-
 4 files changed, 44 insertions(+), 24 deletions(-)


base-commit: 47ffe0578aee45fed3a06d5dcff76cdebb303163
-- 
2.46.0.792.g87dc391469-goog


