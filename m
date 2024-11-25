Return-Path: <linux-kernel+bounces-421408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF49D8AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06563289EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546B1BD9DC;
	Mon, 25 Nov 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CobyWpQ5"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9891BBBF1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554284; cv=none; b=rruSG+jeRTZW6d3FE0YcOar1vtFhuaLaXQR5muCerHAHCC6D05V9UT0fhBKTRmTmMcfKmt4Y8P0g3q1SN/V1/TOqAhHvBdQM5VXAkxkv29Cgmd2xwxCrKekPtmfF746hN9NIHe7UNve0ExR7oR6fj1jXXoYVtrJk0qvFE6DNnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554284; c=relaxed/simple;
	bh=OgZLfOdkYJAHguPWsMKw2rOe00b7KmkS1kMAWr3l+oY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fADT/pORbT95eK/i4sto0R5c+sgRAKPx+U0f6UiAonrCJ4dR7Hwkyl8Z2nnCheh/7hPKjHYk+p/hTo3ZHDn1bYMOoUu/RsSNGyb1/wVY7WYwmL6FcnVxg5Ujg7UrskYaTZ9gWKTor0yWNyodG66dNEICF2AqripeVyZkbYatqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CobyWpQ5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so15111075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554281; x=1733159081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e7rZWkrWCKIltWBYJFB5Sv4+3gijylBrzyi+uA36II=;
        b=CobyWpQ5tAYOLgEFhNd6ZJQyw/Qe6QUgUt8Shy71wLDniHTqeOrz+CtpObutX9irwx
         yGRq2h9UF5Cm97PIhwMcoEWhdo2UYFHMvGDqkKn1bBK1phwg8yXVHz963P1AU5Ef/6mV
         smH0vKmUBkWW2RkfWwTk1UunYJ+9T++6h8h5e+IPo52RWflyFqnbqm93lOPb7KK4rs5S
         LXOkzXt53ZaDnoOyIEBffgxCWP4Y6bv1tORKyJ3vXMo7aUOfD2L3kEza/mxdQMbMWk3I
         +jQ4N0hIgKIr/IAiusXYOvymRNwkqTExVljEf/ItAQVR5WAu3wF2oRZsGBJmz7fgh2cm
         yRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554281; x=1733159081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e7rZWkrWCKIltWBYJFB5Sv4+3gijylBrzyi+uA36II=;
        b=ThXbz6sRiBSWUR2edpMJIhbLB6+fbfnf1MJjP2IdZj45qsLdwk3guTjxKdB/iZFCQa
         cv51Od8gMK5U7rQyarYTIB7se/WdPYqLUl3/nD2iUJcrxiOnc79XjFnCl9iTDHtNsPWp
         FRy3TI2DZ5FOVVQlmO8InYXwICy+f2VwlwjxtQs4XMdZqMsq1MSzOkqeRWPJ6N0Upw/E
         lGSXscev/HbnuVqS10VAFgtIaDSpTztD1pOU1iT+1t2PUxJT5Z2FCsHiAl2Ucgwp/r7a
         xn9D6wewBE8gf4h64R75v5gTOJYxSkedqhsGMngB5qWURedDTlFbbWRcdeWsFAsbezC1
         qcgQ==
X-Gm-Message-State: AOJu0YzVBBts+qkw6zH38d9pQ0ec/O+50eQMXinStEBk8ybpnKmYt6BR
	hO6sSqJxacKy/HZgIqlj/a3zYYQqH3k9jUsl0vhKj9oPlmorINcUbzIX4E/AZwM5X0DkuRvfVop
	svd0XjDkvnS7AAZbcO2WC9/IfM6bUdw2BXmKQetdexARJiFb7U62U0dpYNICivOZg09hHOpwVA2
	HIS8tPK5zDK0AgDHiIy8OuuQf/ZRbFIw==
X-Google-Smtp-Source: AGHT+IHqK8dhfD7pFigahXKEXirWL6H4Hdtrdnqwuz3TB4wp2JcizpNvQU0Mof6GuuxFs+sxkdlaGcwg
X-Received: from wman10.prod.google.com ([2002:a05:600c:6c4a:b0:434:a08d:7adb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fcc:b0:42c:ba83:3f00
 with SMTP id 5b1f17b1804b1-433ce410337mr123783725e9.1.1732554280854; Mon, 25
 Nov 2024 09:04:40 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:17 +0100
In-Reply-To: <20241125170411.1898410-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125170411.1898410-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=ardb@kernel.org;
 h=from:subject; bh=S4miXky9ROA9mMVR9FfU2kYSlO0PVsaeXD5POFetRIM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lncgrrk2HqtzSMu947/z4eOffpdvvzW+PmvJGLaaO5
 Wojq83CjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRMjdGhrlHnn0Q9Kp5sijk
 ZmXuIyefr+oTrWQUw/h7ji+vrJ53u53hf7rAf/88poPXtn4IbG3Kd/UvqDkkWeq4X6TI5vxy7jv LWAE=
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-14-ardb+git@google.com>
Subject: [PATCH v3 6/6] x86/boot: Reject absolute references in .head.text
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
2.47.0.371.ga323438b13-goog


