Return-Path: <linux-kernel+bounces-433099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA29E53E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E228699E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BBD1F4722;
	Thu,  5 Dec 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whVgrgHc"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307CA1F03F6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398104; cv=none; b=lpr6lzCWvuoV6UYHV7AMfw9ab/KVFDjVSBKm1cIX3h6U430GNUepQjI3iZ6FKMaf5S1vLSPuwp62lKGyouOCiwYHMXRQ9NK9xrLJdusyqqfsr2Mqi1gbtnapUTU5mugCEAFDLH7g+XDPnkZS8F8t8OmZj0VzRs98/RkotOMJB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398104; c=relaxed/simple;
	bh=+6ELOdEq9nBnpmyDQJAkZG3cQy/GW+O/nO+riyG3Xeo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m3v5unyGpqX2JQjhBGqwdde53/3WtibAv6mnZrUIRT/k8uPZDxJLo4QqHFlonSFr9rQL2d77iDBmX7iUqIpbQNfal34cDpSojRQhPcDuo9PhWvCHsgTGMXUKwqIrju3aNJHdKOGS0R3PGE5BT+Z407uJm42eh1oc30iLH+tNdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whVgrgHc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso7094155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398100; x=1734002900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YAZZ0WpgGIZu/bzFY6xLZcLtMnDngG9yy1aR037VSfk=;
        b=whVgrgHch62Jrl69ygPISL1GjeDZ36rIC6jsVCd2nY7rsuow1zc++/kE7V1uXivFIG
         3OwgsC2V19XHCGyJrPV+V9Qk3V3wxiXw+cWiUx0YPl7sHRvHQUkyZR7M6Wdrr/CDmstq
         eR28mlQhvME9qNZVeJjG8JsNXEgdCRC00/aztnJ4LIqur0LAna9+6GLTcS5PfmfIP54l
         L01gXmStF84O4xV/iBJ1KB6+mujlPKIURmnth1TuwKeaZ8fWAqEvj59QnKNv6ku5vJHg
         7zo3vKzTIUrSNlGFp+cObJAY0WWtsAMFuhyxy1G3xamZaoD4LbmMY+3NjrL6POaic4Id
         JWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398100; x=1734002900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAZZ0WpgGIZu/bzFY6xLZcLtMnDngG9yy1aR037VSfk=;
        b=TC+8dFCnr4mrZfy26pbIrsMGG7qlgqcGxRtLcq0g3OsZ9XY8CaxzAs4u+/xwcMuLni
         yGo6VanR/QgYbljTN2WjoIfE8aBNdiZ37IpLjjzKEo32N2kVDs6ZaSOU+dY089p5JwSg
         Nu05SG3UXiyTRbL2VGaY1Kgb6EcMa75qWCPaEl720suUcJJwOmijQnZbvl5Kwttf2guW
         C7MwwVPfyw7hCUh+9n97nrYgqQFV8oBC0CuKpckxjCATRd00PdvnJRtxMW85RwbBHaDE
         l7UYuFYvcCDj7Q3Px8jzUHTcOxqihgEMQw4EA6slmCG/hxrV0h9GlBP8foS1moN23U3Z
         TNjg==
X-Gm-Message-State: AOJu0YwzVHKhByhpMe9hif27Hxy5lzYznlH9aRnG5bxSsKcPg5m9PN58
	BVr1pbhYiKD1YNtNQJuzlTIXl36ATU8M/cTJipIMfr4fmUKWgPzJKcUmWr5xDXVZnvjlt/YKoc6
	hrFNG4FY6oMZSX16sEQ2VOFEnhE4yV4JrQ5lqMcNnA4Q/LHBfEOsXX2YuUZsQdIBBKtbXOroBle
	TqoRv3yEY1FPLJ1j40CKR6lfwTdcljBA==
X-Google-Smtp-Source: AGHT+IE9qQFZ/SE7Qw/oOvAz+cebjp06rwDEUqVCLp9FWzH6yxMWB4HNP209kyF8tF3cRsTQCSnH7PhV
X-Received: from wmaj9.prod.google.com ([2002:a05:600c:6c09:b0:434:a9d2:dfae])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4590:b0:434:8827:f713
 with SMTP id 5b1f17b1804b1-434d09b5182mr89708355e9.12.1733398100641; Thu, 05
 Dec 2024 03:28:20 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860; i=ardb@kernel.org;
 h=from:subject; bh=zJRfRS765coZQ8gU19GAsK2IHhN/nOjrwvLPPaaTNzc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wz3VG9+e7fWfseeValH/Kne95vP/wSu29//+tyJUS1
 3m2w+BGRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIwDFGhuN9ItyaIVNttVdc
 /7rgxQULZuEiuXnHJ/o+fepRarGlJ5rhN/uJjb/VL4Y861v0+IXELsnbmZk7orY9FzKftfhLdFb 2fgYA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-9-ardb+git@google.com>
Subject: [PATCH v4 0/7] x86: Rid .head.text of all abs references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series removes the last remaining absolute symbol references from
.head.text. Doing so is necessary because code in this section may be
called from a 1:1 mapping of memory, which deviates from the mapping
this code was linked and/or relocated to run at. This is not something
that the toolchains support: even PIC/PIE code is still assumed to
execute from the same mapping that it was relocated to run from by the
startup code or dynamic loader. This means we are basically on our own
here, and need to add measures to ensure the code works as expected in
this manner.

Given that the startup code needs to create the kernel virtual mapping
in the page tables, early references to some kernel virtual addresses
are valid even if they cannot be dereferenced yet. To avoid having to
make this distinction at build time, patches #2 and #3 replace such
valid references with RIP-relative references with an offset applied.

Patch #1 removes some absolute references from .head.text that don't
need to be there in the first place.

Changes since v3:
- add patch to disable UBSAN in .head.text C code
- rebase onto v6.13-rc1

Changes since v2:
- drop Xen changes, which have been merged in the meantime
- update patch #1 with feedback from Tom
- reorganize the .text section and emit .head.text into a separate
  output section for easier diagnostics
- update the 'relocs' tool to reject absolute ELF relocations in
  .head.text

Changes since v1/RFC:
- rename va_offset to p2v_offset
- take PA of _text in C code directly

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>

Ard Biesheuvel (7):
  x86/sev: Avoid WARN()s and panic()s in early boot code
  x86/boot/64: Determine VA/PA offset before entering C code
  x86/boot/64: Avoid intentional absolute symbol references in
    .head.text
  x86/boot: Disable UBSAN in early boot code
  x86/kernel: Move ENTRY_TEXT to the start of the image
  x86/boot: Move .head.text into its own output section
  x86/boot: Reject absolute references in .head.text

 arch/x86/coco/sev/core.c      | 15 +++-----
 arch/x86/coco/sev/shared.c    | 16 +++++----
 arch/x86/include/asm/init.h   |  2 +-
 arch/x86/include/asm/setup.h  |  2 +-
 arch/x86/kernel/head64.c      | 38 ++++++++++++--------
 arch/x86/kernel/head_64.S     | 12 +++++--
 arch/x86/kernel/vmlinux.lds.S | 29 ++++++++-------
 arch/x86/tools/relocs.c       |  8 ++++-
 8 files changed, 71 insertions(+), 51 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


