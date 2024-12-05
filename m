Return-Path: <linux-kernel+bounces-433107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA489E53EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965C016370F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D5207675;
	Thu,  5 Dec 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxpBiDYY"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD14206F3A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398119; cv=none; b=Aw/W3j7U3TREDmBwQdjGjWpFOuNl5L6XgEHgc92LxHywjrlGfjvLVhkceBCJIvps2oAdfDoCMkrLDcaMZ34DoPz/XWrnXTZTyzTy0FdD0+93JQS7nyOH8bqy8r2vhIwNQZGtoqUZqPXHDViDZ0W0kv6ruiDcMeDR4ZSrnaF+V9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398119; c=relaxed/simple;
	bh=lUZhqz1dSG6yLNkf6C6Z8bFBbE6mrOupQ3iqOOA6Lx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKW8d0vjJWHeMbu60Sy/f8s8JwIO8rVi2Laci4cXMXirCxqdf9iUNe019vVKaIwxuLD22+083GIx2SlmasolWo8Mq3QvFkBXKyQv5xpZ/gDq4FNOjqBzk3kChF7vm9yrGU5VF3Bvr4DwBrtxkMvwMUySYpIWKskM9OvJRe75Mw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxpBiDYY; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385e03f54d0so388451f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398115; x=1734002915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWjxfMYp9wpJ6/N4DjNwAjmUtIPYUBCW2BMl/ScViUo=;
        b=qxpBiDYYeilK1yVNG6QyQEe6lSZGV2ELO2MaZ8zT3ChHE9RMHb1Rx/ViNn5ADiHVWT
         xFw3RhyhjJHkNeP8LuSxhHIoN0CP8/jfuSUTvX5bMK6oB3+gIH2ZHWQWiQ5USer7gIjC
         eIA+82AidSPKtITTywNxsdOiJk7rKyYWCyaIPHpllc9LKV/jkUNB/emGeQFDot2w2JMs
         ponN2F+YfmwswXP5twZFpqB/1bfiAklCMdLIoEensKtUi7cFCWOkSKeI/yXFVRWfHK/M
         Hsoas8qp6PD/9HLSCknAtR/9UudnsRk0Il8Q1DG3RhN/UAmjTAUcKZE+ZPkHlB5hU1Ra
         AaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398115; x=1734002915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWjxfMYp9wpJ6/N4DjNwAjmUtIPYUBCW2BMl/ScViUo=;
        b=FdY+ek1P2aMrmRE6l8XzpRtfUTT+3HXi3WXv2+y6i7N8YURxSeJyxZEZ/lr79S4fV1
         0hB5PbqHZo/NPyR3+hzZRZFA07u515W5bbP8bV0lFhutstRxmD+n6X3V4Zw7REOyrkWa
         n+dhi3UhTPya7kPEqx1kdP07EN2BpbIh4/rvpjcjQQBHZXzjzOPGch/FFwGCW7MomvMy
         Uo3mFyLsMK1M5FWZNprywyyi/H6FZqkIXP3KCTF1lsJpDxOH/98mF0Bp8ia7DvTFP9Xw
         3J2RwmGwBRX2VsEF+ckBohCaqF7wTYRkgpKbH1YZELsrdDEbYhjcf9GeJveGdYHr1IPY
         sOKQ==
X-Gm-Message-State: AOJu0YwTeEXLV79I4u6tJ8t13n4HjQ8yC4v4FJ1jgCetVqlNBMpHrMIh
	aeXg5OO19P62ODVBY2uLBCmmNeLjxXH07og0YGgPXkKKDiLslu745Qf3kxqWuRFgD87o9Idmq3f
	bp25DLigvQpo0ZnjWzTEJ6PNeLqvw8HvFDDmrLK1q85SPOdgJ6FfwT/zLcvSPYyBHssMjn8aDTh
	MeuftsRnTWq2mteKyltaCLQGKnJVOxQQ==
X-Google-Smtp-Source: AGHT+IHP7qPBHC2qIq+bZhcco/G5754G9BU63cH6/TpLd9DE8dE9EPo5Vaif+IOCOzxB2XA2s4ayHih2
X-Received: from wrbfr7.prod.google.com ([2002:a05:6000:2a87:b0:385:e1f3:ed59])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1f8f:b0:385:f071:a1c9
 with SMTP id ffacd0b85a97d-38607c28575mr6314966f8f.50.1733398115691; Thu, 05
 Dec 2024 03:28:35 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:12 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=ardb@kernel.org;
 h=from:subject; bh=sCoQOT0ZZK/f9nS0zUZRW3b6rs/HLppuqFwCRLR4Kgg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wzz/X8HyQ/XLWj76/ZkVkuM3kiVKxkQqVLliacdlee
 Y5uO3NHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMifQIb/Vdbt4dLZ2xZun1Sm
 ZTQp7KoE97RQ4U8t83pWLZdtec8nzMjw9ObxQtHVy2q3G8oyLJ4U2d/xzJXpj9in6sOpdfxT2ze zAQA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-16-ardb+git@google.com>
Subject: [PATCH v4 7/7] x86/boot: Reject absolute references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section used to contain asm code that bootstrapped the
page tables and switched to the kernel virtual address space before
executing C code. The asm code carefully avoided dereferencing absolute
symbol references, as those will fault before the page tables are
installed.

Today, the .head.text section contains lots of C code too, and getting
the compiler to reason about absolute addresses taken from, e.g.,
section markers such as _text[] or _end[] but never use such absolute
references to access global variables [*] is intractible.

So instead, forbid the use of absolute references in .head.text
entirely, and rely on explicit arithmetic involving VA-to-PA offsets
generated by the asm startup code to construct virtual addresses where
needed (e.g., to construct the page tables).

Note that the 'relocs' tool is only used on the core kernel image when
building a relocatable image, but this is the default, and so adding the
check there is sufficient to catch new occurrences of code that use
absolute references before the kernel mapping is up.

[*] it is feasible when using PIC codegen but there is strong pushback
    to using this for all of the core kernel, and using it only for
    .head.text is not straight-forward.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/tools/relocs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27441e5863b2..e937be979ec8 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -841,10 +841,10 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
+	int headtext = !strcmp(sec_name(sec->shdr.sh_info), ".head.text");
 	unsigned r_type = ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset = rel->r_offset;
 	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
-
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
@@ -900,6 +900,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			break;
 		}
 
+		if (headtext) {
+			die("Absolute reference to symbol '%s' not permitted in .head.text\n",
+			    symname);
+			break;
+		}
+
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when
-- 
2.47.0.338.g60cca15819-goog


