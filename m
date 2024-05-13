Return-Path: <linux-kernel+bounces-177236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024A8C3BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1104E1F2155E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14D146A71;
	Mon, 13 May 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjTCCHq5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7733146A67
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584291; cv=none; b=nmDU8aXexugxGEGMnngwdCSHw0EVlCmUBGZFafMxuadWKChOp37KORpQqIqLipcGHMBL6hz875kIWN/vjAfs8oxZ/Mc13UoIVysWL2LfPdO3FS/oTQf47iyZDvsI6O7pGvCSTzFGi3bxIOiu9QJzgf3OzSWilqlUM5aqaesy0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584291; c=relaxed/simple;
	bh=i4EKOqRXXyAg4XhfzmALDFUBzU22F1etWcRLjzu+WBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xl4Asb5mtAJjBGYEeC2TGr2BYYUPA5bybGlk0ESAJKSy+k+XVwsgNUW2fQypsQ9YZes3A5ZmYL0BDW3kVF5sHhO17WCm5VzdamAKqWg1FfGw2kz8VDMeeZ+xL/whcFP2ptVBMdT/Nvvc3ferbRWnbEp8I4As+A5NsfOquijaewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjTCCHq5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so209100566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715584288; x=1716189088; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+/z2edFUWkgRAAy6UbLOvgEWNPcfFzHYjwa4Jec58Es=;
        b=NjTCCHq5fEl2DVQstq+fcwzQ7QFGc+ExEryBWkOCb628mlnu7hFEdh/ccqrG1wwexr
         sQGMXtOKJEyZje80uY+A/S1eoN3dgXTDLDhxxh2+xCNBihqi6ae4Ty+v+uPUbx2kJk7/
         Ypqc+OdlRcKRLI4YFHudhYW5One3TB2lygPazTsQOkLjvqh+tvJ60I2mYIQizcoM2MOP
         rJOiwNnxPYUSpt4govZa6A4LBtpxAFRd72AlBY1XAccQR8SOjBA5Qjodq21dfCABQeiK
         gpqy9lrHKxDJV/OjIHX1G7WJbUpEg0Ceh+qW4cu37Sg1+/BgtqkKUduc+DaM/Ig/JNpU
         6R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715584288; x=1716189088;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/z2edFUWkgRAAy6UbLOvgEWNPcfFzHYjwa4Jec58Es=;
        b=LUytMrryS09HKOb7DwBgaLXw30ToZ03Ql4LkRhA5mBig5ZnOkP/KBh+5FXuQp0DAGa
         zFirkT0hnD5Pqc4pP4rXvMeWZn0OOO/LXNZkv4KBkuZHLZTfmMuCyo7c7KRi5kox6Flf
         3Y/ZAshVwRulh0Lzoj/S2gjnTtit/l+pddI3CH/UR06rDm1NJwYmJWYtO5+xBxCPoHYf
         EMDCB+reOU4aYzlNB6xcsOOk9TfuaBM3kaHTRY9eTIqpo7k8EumWRdNqKfHGSzDoFpa5
         8X19fw35N+FhnXacwproXc3tnr+sPyqDb2aB7yOoH3OsydNUKI6l3ClsbomSbmjzqcrS
         S49A==
X-Gm-Message-State: AOJu0YytEcsarc9ECeowhXbmUm4SfRppQ45baoIdRZtQqrWtckVQMzeN
	5Ef1nRl3mmJvXrfQXh1g2KmDNzmhIbJ1TlcMQuqjFGQL912dGvFqn/NP8zZa
X-Google-Smtp-Source: AGHT+IFdoVV+Rv2mmnzA9YRq0vIm0qwvp8nd7EdvSfDIB5r2MeW35Ar8GL378FY3hHXCl4Q4gjXB5Q==
X-Received: by 2002:a17:906:e2c4:b0:a59:c9ce:3390 with SMTP id a640c23a62f3a-a5a2d572bf8mr574076766b.30.1715584288003;
        Mon, 13 May 2024 00:11:28 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a3c8724edsm386119566b.34.2024.05.13.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:11:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:11:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.10
Message-ID: <ZkG9HSBHAdwqQrEY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/cleanups Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-05-13

   # HEAD: ad3bd7659b68add28920982e02233b5dc4b483c3 x86/pci/ce4100: Remove unused 'struct sim_reg_op'

x86/cleanups changes for v6.10:

 - Fix function prototypes to address clang function type cast
   warnings in the math-emu code

 - Reorder definitions in <asm/msr-index.h>

 - Remove unused code

 - Fix typos

 - Simplify #include sections

MERGE NOTE: There's a new conflict in <asm/msr-index.h>, it's a context
            conflict, the resolution is to keep the entries in numerical
            order.

 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      x86/rtc: Remove unused intel-mid.h

Arnd Bergmann (1):
      x86/math-emu: Fix function cast warnings

Brian Gerst (2):
      x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
      x86/syscall/compat: Remove ia32_unistd.h

Dr. David Alan Gilbert (1):
      x86/pci/ce4100: Remove unused 'struct sim_reg_op'

Jiapeng Chong (2):
      x86/xen: Remove duplicate #include
      x86/virt/tdx: Remove duplicate include

Paul Menzel (1):
      x86/fred: Fix typo in Kconfig description

Pawan Gupta (1):
      x86/msr: Move ARCH_CAP_XAPIC_DISABLE bit definition to its rightful place

Tong Tiangen (1):
      x86/extable: Remove unused fixup type EX_TYPE_COPY

YueHaibing (1):
      x86/32: Remove unused IA32_STACK_TOP and two externs

Yuntao Wang (1):
      x86/head: Simplify relative include path to xen-head.S


 arch/x86/Kconfig                           |  2 +-
 arch/x86/entry/entry_64_compat.S           |  1 -
 arch/x86/include/asm/asm.h                 |  3 ---
 arch/x86/include/asm/extable_fixup_types.h |  2 +-
 arch/x86/include/asm/ia32.h                | 11 -----------
 arch/x86/include/asm/ia32_unistd.h         | 12 ------------
 arch/x86/include/asm/msr-index.h           |  9 ++++-----
 arch/x86/include/asm/seccomp.h             |  2 +-
 arch/x86/kernel/cpu/mce/severity.c         |  1 -
 arch/x86/kernel/head_32.S                  |  2 +-
 arch/x86/kernel/head_64.S                  |  2 +-
 arch/x86/kernel/rtc.c                      |  1 -
 arch/x86/kernel/signal_32.c                |  2 +-
 arch/x86/math-emu/fpu_etc.c                |  9 +++++++--
 arch/x86/math-emu/fpu_trig.c               |  6 +++---
 arch/x86/math-emu/reg_constant.c           |  7 ++++++-
 arch/x86/mm/extable.c                      |  9 ---------
 arch/x86/pci/ce4100.c                      |  6 ------
 arch/x86/virt/vmx/tdx/tdx.c                |  1 -
 arch/x86/xen/enlighten.c                   |  3 ---
 20 files changed, 26 insertions(+), 65 deletions(-)
 delete mode 100644 arch/x86/include/asm/ia32_unistd.h

