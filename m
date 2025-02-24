Return-Path: <linux-kernel+bounces-529718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58679A42A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16D516BFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8C264F9A;
	Mon, 24 Feb 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWTyMLTb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCA13B298
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419118; cv=none; b=NOuHd7n0KCFdJ0DJXibugJXAxffoyz02JRkt4RrZJLY1LXRUeOZyF5k3EZjN3gNKhnWC3TED9MdqMgUC69W1VJ5Rx2v9VWQEyXUh/SBZv4tEgJ9UYMFrxEqgtkZUsNInbS70bjFNqaKW3hDJCgt85QCEwTW6zUff5jRgwieNHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419118; c=relaxed/simple;
	bh=gu/wlPkEa9mQgoMthKANU0ZDCM7tCdynkNJLVCB9fDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKf/skLxPr6/BjWJZRJE2g/N0bEPzd5P7aEibDLWw7prEURuDYVGje6WfiFPUT9tzcYlJDhrz6jy8M9uyFpu5nIDO6i0qer54KDZBnq4yzVh3o9thBAiQiU1x1IIZVV2gkeoYBwLhjEjwkDAqSKLT1IPRZuG+i4u1ltWupJSkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWTyMLTb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216513f8104so11101935ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419115; x=1741023915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcuzKtFPPtst6WZXsPXBZwCkXSRuweXNYzPclr2Anaw=;
        b=kWTyMLTbzRzyJRQlPrHUKPxSPvoD0G3AJ6wMFVomglQcdiT3adPXdEwe39h1CtLsxU
         qL1IAqz5Ixgk1mFPg35II7zDW8uzdeaC73AATHDfPC7WFQ6Kyts5qDdIPUOFwi6Lqauz
         s/GmdnbEZJUTA+ZgiVDTp3y3LMVNE8eY985ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419115; x=1741023915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcuzKtFPPtst6WZXsPXBZwCkXSRuweXNYzPclr2Anaw=;
        b=ezaOVSMKufDGUu31FQBSxvfhzur0bMHAgR8Ym7Ht7Z5CvEHIfjU4hIfr1B1JZmIs8/
         uW+KAq51DDMCmdIgX4npjN8Zp4FjX/0cJ1iT0U5dWC3MwP2PpQxJURb/X2EE+O3lvzFO
         CjACGUUPtHizhBVdTy8i8TS5dgc8O8vL/KLUBID/b8Hv3rApEr872dZ91/SZzgm6oRBk
         imrBqo12un1QraWJqVGr1GglnQD5501vEedASCwD4z/ImQzXUdsnj6Lg486HBBh06dRc
         7HMYud8SXpUm7ppETJeuRQ+6RrjHNOm3QjcfQnu0lq27l8l6Jp5Lkzsmg7AIcA9pbCeQ
         psHQ==
X-Gm-Message-State: AOJu0Yx6gEuYAcN19fdEEF1EgeCP7r4Jp0Ct2y12l5NBaQPagieS3lmv
	i4IdTxVVhnzGu2il30A1B8nCEwEOHmESC2Tux25RWCw9VKbMbWKq4Ug98zvi/Q==
X-Gm-Gg: ASbGncuymYniC1UEiseLbTYU8LPphVWYR6aa/ZJacfZnA0CcQyPGwNzPdCP3tEy1CYh
	hJulikPCUJsq9I00z9fL+7RUQ/zN3Xyzx8+iNLSHXS5ef8imSGAzFdKUsXVnnFkYQUcQemqzVL2
	4UOefWilwQmHSxVKHNiTSLJsBIlaDDdSRbNrS5ARwb3IoycPNfayuSw/dXuXoJz6iAZCHJPqVk5
	rbWLltZhe/kNuIU2RHSM+3c16vbbAizsx/P834DcjZH4C8kYgKaDgs32HcUw/1BLouTOHmOOEpR
	NZrECus/82IG2j9JGAyZ65Y9nZui8MtVpTrBrgcPdHyc3Rvdx2bIl60mKLkJ
X-Google-Smtp-Source: AGHT+IFSLRh6SHQWvPSx2gIUkQXGWRiXe2mxqOjv3oqPRMC739LlRyLpyZpC4QGjTaVVt5mEnutt1A==
X-Received: by 2002:a05:6a00:987:b0:730:8526:5dbc with SMTP id d2e1a72fcca58-73426d77d7bmr9320754b3a.3.1740419114668;
        Mon, 24 Feb 2025 09:45:14 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732771a01bbsm15361992b3a.78.2025.02.24.09.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:14 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 0/7] mseal system mappings
Date: Mon, 24 Feb 2025 17:45:06 +0000
Message-ID: <20250224174513.3600914-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is V6 version, addressing comments from V5, without code logic
change.

History:
-------
V6:
  - mseal.rst: fix a typo (Randy Dunlap)
  - security/Kconfig: add rr into note (Liam R. Howlett)
  - remove mseal_system_mappings() and use macro instead (Liam R. Howlett)
  - mseal.rst: add incompatible userland software (Lorenzo Stoakes)
  - remove RFC from title (Kees Cook)

V5
  https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.com/

V4:
  https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/

V3:
  https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/

V2:
  https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/

V1:
  https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

------------------------------------------------------------------------
Provide infrastructure to mseal system mappings. Establish
two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and MSEAL_SYSTEM_MAPPINGS_VM_FLAG
macro for future patches.

As discussed during mseal() upstream process [1], mseal() protects
the VMAs of a given virtual memory range against modifications, such
as the read/write (RW) and no-execute (NX) bits. For complete
descriptions of memory sealing, please see mseal.rst [2].

The mseal() is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped.

The system mappings are readonly only, memory sealing can protect
them from ever changing to writable or unmmap/remapped as different
attributes.

System mappings such as vdso, vvar, and sigpage (arm), vectors (arm)
are created by the kernel during program initialization, and could
be sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [3]. It could be sealed from creation.

The vsyscall on x86-64 uses a special address (0xffffffffff600000),
which is outside the mm managed range. This means mprotect, munmap, and
mremap won't work on the vsyscall. Since sealing doesn't enhance
the vsyscall's security, it is skipped in this patch. If we ever seal
the vsyscall, it is probably only for decorative purpose, i.e. showing
the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the system mappings during restore operations. UML(User Mode Linux)
and gVisor, rr are also known to change the vdso/vvar mappings.
Consequently, this feature cannot be universally enabled across all
systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.

To support mseal of system mappings, architectures must define
CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS and update their special mappings
calls to pass mseal flag. Additionally, architectures must confirm they
do not unmap/remap system mappings during the process lifetime.

In this version, we've improved the handling of system mapping sealing from
previous versions, instead of modifying the _install_special_mapping
function itself, which would affect all architectures, we now call
_install_special_mapping with a sealing flag only within the specific
architecture that requires it. This targeted approach offers two key
advantages: 1) It limits the code change's impact to the necessary
architectures, and 2) It aligns with the software architecture by keeping
the core memory management within the mm layer, while delegating the
decision of sealing system mappings to the individual architecture, which
is particularly relevant since 32-bit architectures never require sealing.

Prior to this patch series, we explored sealing special mappings from
userspace using glibc's dynamic linker. This approach revealed several
issues:
- The PT_LOAD header may report an incorrect length for vdso, (smaller
  than its actual size). The dynamic linker, which relies on PT_LOAD
  information to determine mapping size, would then split and partially
  seal the vdso mapping. Since each architecture has its own vdso/vvar
  code, fixing this in the kernel would require going through each
  archiecture. Our initial goal was to enable sealing readonly mappings,
  e.g. .text, across all architectures, sealing vdso from kernel since
  creation appears to be simpler than sealing vdso at glibc.
- The [vvar] mapping header only contains address information, not length
  information. Similar issues might exist for other special mappings.
- Mappings like uprobe are not covered by the dynamic linker,
  and there is no effective solution for them.

This feature's security enhancements will benefit ChromeOS, Android,
and other high security systems.

Testing:
This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
- Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
  i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
- Passing various automation tests (e.g. pre-checkin) on ChromeOS and
  Android to ensure the sealing doesn't affect the functionality of
  Chromebook and Android phone.

I also tested the feature on Ubuntu on x86-64:
- With config disabled, vdso/vvar is not sealed,
- with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
  normal operations such as browsing the web, open/edit doc are OK.

In addition, Benjamin Berg tested this on UML.

Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
Link: Documentation/userspace-api/mseal.rst [2]
Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]



Jeff Xu (7):
  mseal, system mappings: kernel config and header change
  selftests: x86: test_mremap_vdso: skip if vdso is msealed
  mseal, system mappings: enable x86-64
  mseal, system mappings: enable arm64
  mseal, system mappings: enable uml architecture
  mseal, system mappings: uprobe mapping
  mseal, system mappings: update mseal.rst

 Documentation/userspace-api/mseal.rst         |  7 ++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/vdso.c                      | 22 +++++++----
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vdso/vma.c                     | 16 +++++---
 arch/x86/um/vdso/vma.c                        |  6 ++-
 include/linux/mm.h                            | 10 +++++
 init/Kconfig                                  | 18 +++++++++
 kernel/events/uprobes.c                       |  5 ++-
 security/Kconfig                              | 18 +++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
 12 files changed, 127 insertions(+), 16 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


