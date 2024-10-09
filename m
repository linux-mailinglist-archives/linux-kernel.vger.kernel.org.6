Return-Path: <linux-kernel+bounces-357426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0299711E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F17B24203
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7395193432;
	Wed,  9 Oct 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsAdgXLf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A121D31B2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490147; cv=none; b=HFWnATg8jbBn6vuW1xfwuHXinAMGdn7jkMGXSFoyf46/0+Q3DTTzTdQz7W2jtUDmhpkc2ZEyQA9ddJzu7OPfZyAoAV+AbNQNHsPxTy6cT7J9u0yRZ5exd5JVqiUUHxpPShhdx1HlcoxDf5EC9bmzjKeo+japMutGPI6Y7FzJsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490147; c=relaxed/simple;
	bh=vOzOPPaToCAPc2MfPAtHgXAdeLJLl63hoTdiVwY+R8A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a6EVGqz+c9yFk8Nu7XCBlF9vAFfceSccMN4kayrCt647tPieYbrIJyEn8BwPSS+4bdYFFc7d/79zmPv6vr+lsrrrL6jcvWhjw6ZqU0WL6mY35Cb5LYSjvCs8nr+zgxtMrvErW0ziAWhtXNE1TGokqDJYWcfTGAIU/K7skgOqeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsAdgXLf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso1767111276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490144; x=1729094944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihUuPfSAQAcR0+bkMhCvtEzjM7mpMFX5i7pmWzbSWjc=;
        b=MsAdgXLfTTwI78xxAvKQHL0BntSgSeiHnxb89o6rIHAK6reAonC41qXw0yVBaEQkzP
         +22g7KoYSOacZUobjgZQqeOHTdw7XlNIAXK636/0Eur2wk+vA3ZVEFEbpGIhFc3WP72D
         e8tiyPWrgGJLmVYgh3Th7OW7sT0+2l4LLQLTyrddy/awVFLCWYWAxPv04LMHYhz0dj+A
         07PltUt+ZSXHzuYEg2Yy7fbsBpQI2hThyfhPXtOQKrgLdzdnnmhvxAd0loC89mpjTWRg
         7owb5lIaRakvOjfbnLEJTkg1twq32LEYVPVvfQ0CpaI+DT5nf7JTXHqVkkhF6Q0skp28
         fS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490144; x=1729094944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihUuPfSAQAcR0+bkMhCvtEzjM7mpMFX5i7pmWzbSWjc=;
        b=LvHKUXMG1goZabzr1a9+tPPKhmIRtY9GPpkXUVj84t0yfNkG/klJPaIvyaGjzia5mv
         S5RCyijsv9mPiRpa1PHhVAwTPs9VyBPsWA+w9tzQtAw+QdZPxkcc4Dr9F+j4H1GfKkYP
         DKaISqU2KEvB0pEsNUo6u6CZyN/Vgt7QUrkL7KiboapjovBfPZBytlUKK1X83EB4iaX6
         vax/7pnDKGLdz4uUOm3ILniGAwiCarGl1N7oZ2HfXq9A5hFn12nmxtp75OTD8ODcunVz
         FH8qzgitS3YU3IVy7CtuAOEKLPe2FpAFcT7HRcMeDhvdP/XQI7UcZkwCW2aiDwi/zG48
         YGVA==
X-Gm-Message-State: AOJu0Yy2G/GpXpOuyF1/rsd+6OR4p+fBxuAZYHoPHckVHD/v8/YZt3/T
	M+N92SL97nJ6vrOPvxVTWR83QxZeCoQ1TwHmBV5GUz2wxrpFH5okXdBkyNEVCF20nq3MFW1XhRO
	InBnsr9ONHdPF64I8YglINoh7Apq6/01XlevJD+vAsmGcAVhJvy7ITFJWhFgrVD+XaYpv9Tb/6A
	C+c29Hx6gBbnSSRyTh/gZet7hksj5eJw==
X-Google-Smtp-Source: AGHT+IEIxpbQfQQkvY9ZXHbacw3miId8a+O5WNpa3HE+ve/Un0kg4t6qYCHSzqoicfWVZn+irr7o5Cut
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:9105:0:b0:e20:25f5:a889 with SMTP id
 3f1490d57ef6-e28fe4a5550mr2103276.5.1728490143922; Wed, 09 Oct 2024 09:09:03
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4871; i=ardb@kernel.org;
 h=from:subject; bh=tMu7HK8XnBJOEjLli1NIwyalC9VG3W6HEH9wUQOYTH0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t5XS+J7quVVZTrJ7cil4T81dtaszZE44H8pKZf3C/Z
 bxXv3RXRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI3U6GPzwNvgynJjYJJMWH
 J1Qs27DUwe/Peq7CJalLHxTEXs3uZmFk+CeY0/xMVeYARzhPfu7DSw/9vxl//PmwcamGgcn3C4p aDAA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009160438.3884381-7-ardb+git@google.com>
Subject: [PATCH v3 0/5] x86/xen: Drop absolute references from startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series was broken out of the series I sent recently [0], after
Jason pointed out that my Xen startup code changes conflict with his
changes to make the PVH startup code position independent.

Jason's work reduces the delta of my changes, and given that my other
series will likely advance at a much slower pace, the Xen changes are
presented here so they can be merged independently.

The end result after applying this series (see below) is that there are
no longer any Xen-related absolute relocations that need to be applied
to .head.text, a section which carries code that may be invoked from the
1:1 mapping of memory before the kernel virtual mapping is up.  The use
of absolute references in this code section has resulted in a few boot
issues that were very hard to track down (Clang built kernels running
under SEV-SNP in particular, which does not provide the best debug
experience).

Even though the occurrences in the Xen startup code were fine, there is
now a lot of C code emitted into .head.text as well, and so it would be
helpful to teach objtool to reject absolute references entirely in this
section (or rely on the linker for that). Therefore, not relying on them
in the first place is a step towards that goal.

Changes since v2 [2]:
- add Jason's Tested-by to patch #4
- use a better name for the linker defined symbols used in the ELF notes
  (patch #4)
- add a comment in the linker script explaining why the symbol values
  are constructed in the way they are
- rebase onto v6.12-rc2

Changes since v1 [1]:
- add Jason's Rb to patches #2, #3 and #5
- drop the use of a 32-bit field for the ELF note- QEMU reads a u64 and
  so the top word needs to remain 0x0
- tweak #ifdefs in patch #4 so the hypercall_page linker symbol does not
  depend on CONFIG_XEN_PV
- rebase onto v6.12-rc1

Changes wrt [0]:
- add Jason's Rb to patch #1
- rebase onto xen/tip's linux-next branch
- split out fix for GDT descriptor size field
- add patch to remove the zeroing of phys_base, which is no longer
  needed
- use a 32-bit field for XEN_ELFNOTE_PHYS32_ENTRY, and use its contents
  to obtain the build time physical address of pvh_startup_xen()

[0] https://lore.kernel.org/all/20240925150059.3955569-30-ardb+git@google.com
[1] https://lore.kernel.org/all/20240926104113.80146-7-ardb+git@google.com/
[2] https://lore.kernel.org/all/20240930071513.909462-7-ardb+git@google.com/

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

 arch/x86/kernel/vmlinux.lds.S | 19 ++++++++
 arch/x86/platform/pvh/head.S  | 50 +++++++++++---------
 arch/x86/tools/relocs.c       |  1 +
 arch/x86/xen/xen-head.S       |  6 ++-
 4 files changed, 52 insertions(+), 24 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


