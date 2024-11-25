Return-Path: <linux-kernel+bounces-421401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136169D8B50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F0BB2CC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474B1B6CF0;
	Mon, 25 Nov 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Juc+rM8a"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6801E48A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554271; cv=none; b=Wig588CGSn09CQPwtosH4yVumov1dkLKTwtPUDqXcGi2mCjSf+/Wlm0nQ/ajKn6//Q0p2ZUPdU4xLINY9oV5oxS08dHTvCQ1Elkerpy4sYLkJEfpNd1VBl9UhLdpZdwZBGSMxBiqpWHS/w+RM0YdLrdQmyqSBaAdt+TvwwLA9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554271; c=relaxed/simple;
	bh=LXnppzaLopkH8yFaLvADe4QEdjfASsmcPYE+mrv6Xfk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l9He2XUhZ/6Haxpm1lRN9z109btzC+WFVht6Co8ZgIFWsJVIu9PJCd4naVHC+RZwrnhR0RYzZGA6WhI1Tau8VJY7UedcWfyRngIJOHZI+VpDNYTnG3zixgMAHw/1AJoHaRCX+u6RZdWxkLu30Q0T7K0QaTbzARKwnW5EnK1oPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Juc+rM8a; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43499c1342aso13539055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554268; x=1733159068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=En+QDiDwo7kop9ITr26Z1Iw0LuGKzJ43ZCYIlaql1mU=;
        b=Juc+rM8aYNlQgiqprIjQ37dL9w5xgWtYqG8Wnj1v3F44Uc2SRPJL1kUnvggGDwlB+y
         W29HUfR2j/AAkcKIEaeYCmv0PpJKbMAcLi3cDpuQQrknMMhU7biZYdCwAIVBH/P4iTsP
         Hz0hYaXcMQxgFt10bI6exZh0MxMuhzZWcTYLdFbynUGuv4KVqC8FBz7hvHIf7bG6s5n7
         oLlWmV6jznYpRHfi7oPzApb4JDraoIW3moSWtbYQn+0GwBmTU98f8V6RQ9pS5IXBMqaK
         9dGewo8U+wZ71A9lvCeZ9GbJIi7MopDm8NmPJAvCnbyjnfIMmZzomeTu594UZJ3pOzvI
         C6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554268; x=1733159068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En+QDiDwo7kop9ITr26Z1Iw0LuGKzJ43ZCYIlaql1mU=;
        b=qfUUXZMhB01ta7fo1ZnmeeqOWHyV9fVFp6f4Zh/PCXZqxa+aESPOjEfOe1avM+PJPi
         avzTXiP3ZjU8SIu36zgS3ePDgof95wC6RTExLbBDP140N1AZoO6cjzvpJxm3TBLjJ4PV
         I4MMRZzgmjwzdYjqDIK1HmdLNK5jYzjNXY1lGQmvEZgExAmQagKiHDuSe8qGiDb9ZuT4
         ZCb+3tZyRg6DXzur16NegqOwDCl3psZ5qxrvCE2LMwZgfU+MLRnF+zOLZgaPx3TcKTZN
         e0JaXXoUyJmllOMCLbj0eBSrmVxmM/WlOqsO6I7FI+fJRcTh8sLD/KE3fwb5xuTbVJ8R
         Af6w==
X-Gm-Message-State: AOJu0YyjWIFuaanS8wvoCrWeXrkSe53w8qaG6fs7uP2sD2Dws5KNLGuk
	k48tL6t3cIO3EmQL+RYLVhWXz12x4tPfa/esyp4qVqhhDcdeKFDsvaLNky3UBS1QalCX0my3l3K
	wN+ESfJWQW4+/VTsB48ShdfP+mqbCpiLwXCVbPUdpijI++soXP5Loa0CduXDZWayXoXmvhgLry1
	iYnPCH/WRHNgyd1Zq6+KyLyIts/o8LIA==
X-Google-Smtp-Source: AGHT+IF0/QdJpprRCVp3vA20Zv1bpIAiF2Bd8hXLcbARrWwCA5KqWuhx/3wBGbATwq1iOpDs/zjSWdv/
X-Received: from wmz13.prod.google.com ([2002:a05:600c:6b6d:b0:431:21be:a0dd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6dab:0:b0:382:4851:46d8
 with SMTP id ffacd0b85a97d-38260b4d514mr10362320f8f.8.1732554267815; Mon, 25
 Nov 2024 09:04:27 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=ardb@kernel.org;
 h=from:subject; bh=d4vgMHue2zDq3wzGd4aV4Ya8eCZu5/wbsaLvAG7iBeo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lHc+phRddJ5bJtufG7X7z4s2GPUuNd+pYcTQzMW+zi
 NCJnxbWUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZydiojw9mjP02E+KWkd77j
 TPKx2vXiufWP15tMjJ4vi5x4PJrr81KG/wkX/nD/+XnCTSFsh8+5afIPymetaQj4+eRY54+4cCX 2eDYA
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-8-ardb+git@google.com>
Subject: [PATCH v3 0/6] x86: Rid .head.text of all abs references
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

Ard Biesheuvel (6):
  x86/sev: Avoid WARN()s and panic()s in early boot code
  x86/boot/64: Determine VA/PA offset before entering C code
  x86/boot/64: Avoid intentional absolute symbol references in
    .head.text
  x86/kernel: Move ENTRY_TEXT to the start of the image
  x86/boot: Move .head.text into its own output section
  x86/boot: Reject absolute references in .head.text

 arch/x86/coco/sev/core.c      | 15 +++-----
 arch/x86/coco/sev/shared.c    |  9 ++---
 arch/x86/include/asm/setup.h  |  2 +-
 arch/x86/kernel/head64.c      | 38 ++++++++++++--------
 arch/x86/kernel/head_64.S     | 12 +++++--
 arch/x86/kernel/vmlinux.lds.S | 29 ++++++++-------
 arch/x86/tools/relocs.c       |  8 ++++-
 7 files changed, 66 insertions(+), 47 deletions(-)

-- 
2.47.0.371.ga323438b13-goog


