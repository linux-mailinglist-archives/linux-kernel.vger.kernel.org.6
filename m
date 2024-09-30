Return-Path: <linux-kernel+bounces-343455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB8E989B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB64EB2118A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8B13D8B2;
	Mon, 30 Sep 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pdv+xe+J"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB910E6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680528; cv=none; b=Pl8dguhxPN4tyCqyqbl7gHxyZ3tryn7dNThiTWEc+KTTnywk8LIs8BBkgj8rxhaHCxBZjDLW2tcQ7rFuyK+80xE65iTbjP+sA+2kRw+SOQXfII0VxfamBkOf3ZdsAG6n2OFE8u7BUzgDvoEj76ycDGP9qr3nt1sLzq/iL9CXqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680528; c=relaxed/simple;
	bh=+yyDUR7absLG/sYbeAQha0wO5TCxIJcrlUk8Fq+RTxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NLUPS0B0aqZEo0FjqpC+F6lCaEtduNomaqOV8BK/IUaPWlu7f/TuuMMMxqtGvVrgpk3ZSH/cuSh/5WdMXkTL92/HoGhgynnxzQly1bY8MPqnlA2kOfUuifV5vauGENokHmCQJv3ZALiX/pTh/BkyVYWxvJaBj11v1wap2W7q/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pdv+xe+J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6dbbeee08f0so69846467b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727680526; x=1728285326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dd2dU9j63HpFzKeIXYCV0ITt+nTkDZ82tpZxGhtecTo=;
        b=Pdv+xe+Jk+etGPRTCQqGKrmqtSSV+4du5aieu9kbIoddeJ8lsP9cHc2G0fRzJP8Uhz
         114v8RBrPnmIDi4E52GKycaS4dyMj1g3K4vSdSMUHfwUOaqclW4SG71AfEu6W9v78wlg
         Exr05wQ0Nh9FXCojEH8dT8ZRm8JSmD/hi7XQVHFAredqlMdUc4YwN0wxBGt8ttXs4x+w
         DogWsfEm6lYyw9xpkQyRkAbNS0pyE8Lk8W3vrgj+qGXJ81LkT882ohKhG1vegaPl5UR+
         iPIbPhlUcpkEnybET7NT5ng9QGegbAcyPbHMpMrImqcToLlOI76sxTUfk1aLQQXvLKa7
         Mvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680526; x=1728285326;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dd2dU9j63HpFzKeIXYCV0ITt+nTkDZ82tpZxGhtecTo=;
        b=iOEsszppBCVzTEaBhCmflKcwoRAMW8B7OCAxO6lhOWoEgefO8dcYG9yIEO0l4wQHOS
         GhNGDGitTsJulAHQ3A95AMG8HU7b0eAEDW3Z/t0gbNHm3rpxVu+lqVC8NfWuCsWhAycY
         S2RDhgm2QBeigdAPY7lnVBDGQCy38ZApN89ErlXZNLA5aNk5I8LnR+MRr8xu8+rIaHbr
         aY8sZypxSMY3r1xliT/xkBx12UCzrql8ccRsuDkTEnk5Wjq3NLAu51roaSujf1Z1r7sx
         SM54i4q5YW3Px6KuNNKNiV94va003kzgfbMqWsTJv9OX9llVb3UC4iOuTJnbJEhvhIVa
         YNHg==
X-Gm-Message-State: AOJu0YwOyLyczKA5ahOanbG53JH1GbRNahYbGMX/8dgYB3pEf0lQUpwa
	FaGDx5lCVJjYXn289ajPLNPlOwnOW6ukwR6DbAN6WTlFEvtgdfjaOXNvMAtjZNG2PUL7Xi7b/Ms
	4OMrjAvlkMsSgJzdrgJC2dWzEixi80b8Ye1Hlvxm6EIWJ5Uv9nsNG/tlMYWQehEbr/g1jp6qwTS
	1V7I07HNtik3Ed4DOiZbXmHDzl61RPpg==
X-Google-Smtp-Source: AGHT+IFgoJFdvUw1WZNNF4OsQs1dOK1QNV7js/Ei9XHiPgieX4mGBxnaX8R4ucwmBMQxn1XQRmJxJa1I
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:2c11:b0:6d3:e7e6:8462 with SMTP id
 00721157ae682-6e22eda4173mr625237b3.1.1727680525612; Mon, 30 Sep 2024
 00:15:25 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4492; i=ardb@kernel.org;
 h=from:subject; bh=rUUiEoTKPN8ZdAnAJkMvJAt9AG57D9uPhDvEs+Q7iyc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1XANMElzk/FE8WFsZEGh29Enkt2nPf29S7Oaa1xkt0Q
 vpS/Dd0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInsWcbwP6g9eeVn91f+B5vu
 r5uwsuinoIt+p1qCT2uM/YVdQUeVqhkZNj7b9m3aogObjI6or55vytk+uX/KN60Q67eSB66bz51 7jAcA
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930071513.909462-7-ardb+git@google.com>
Subject: [PATCH v2 0/5] x86/xen: Drop absolute references from startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series was broken out of the series I sent last week [0], after
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

Changes since v1 [1]:
- add Jason's Rb to patches #2, #3 and #5
- drop the use of a 32-bit field for the ELF note- QEMU reads a u64 and
  so the top word needs to remain 0x0
- tweak #ifdefs in patch #4 so the hypercall_page linker symbol does not
  depend on CONFIG_XEN_PV
- rebase onto v6.12-rc1

[0] https://lore.kernel.org/all/20240925150059.3955569-30-ardb+git@google.com
[1] https://lore.kernel.org/all/20240926104113.80146-7-ardb+git@google.com/

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

 arch/x86/kernel/vmlinux.lds.S | 13 +++++
 arch/x86/platform/pvh/head.S  | 50 +++++++++++---------
 arch/x86/tools/relocs.c       |  1 +
 arch/x86/xen/xen-head.S       |  6 ++-
 4 files changed, 46 insertions(+), 24 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


