Return-Path: <linux-kernel+bounces-421405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2E79D8AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DF5166C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AED1B87F3;
	Mon, 25 Nov 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yb029CR0"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19B1B87CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554279; cv=none; b=hrTJto4PtjAUqMqxKyR1ypx/yevvZNLrmyHSR4PEl7L7p4y6F3VOsH2HgsnJ9hWY2X7wMvcng/VqtteJk+UGqzAAfhaeEHa9j61g2tJzhZaypUylTNXbKFZuZWESGGS77iz9ULYXb98dEu+F7ltUPNTdvWUVOk7Heoi0631c8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554279; c=relaxed/simple;
	bh=CI4anSzhc+btJM996ZvdCCGUYSZiwSHK+Z0r0gQTl7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8Viv94JAI12DRo9Qq8g+grJ0PdG3CupxqmnEZmN2SGNdlPNP6eNOd9n7tlgDO8GK5kaIwD5/5DfEiqfQe6gxLEq6P67/nJhmUO5tXVpB28mMMlCe630TXXWGqusCpTcixoR1LLAmANWZgZaG6wNugUMef1j8sMLIbJw68WgQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yb029CR0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a4ad78a1so1043345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554276; x=1733159076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0X5ksPuZEo9fE4vkgZvo0Iqh/N6D2VPGhMHc4zrWIk=;
        b=yb029CR0kV5O69wHXaF2Z56hwCq8cB8E2tBHQuiotlbuwmahh2WzuVzXnpTR9vZ0ru
         axqfy+dczn3vQO4LwgQflEQXE3anQswBuzUeXWKs5PbUEACVaSwaWpN9fFSaWAe6sbhv
         bRSIgLtifdzmoflAtLdLzjG1rVWFSqaQ0H5aVJxLs9QeMnLCCYGftpAyEYLqLkJebSJh
         0cNpttqk9+ouZQiG51XFq4MtyfEmZGKlapXsas32lhhj1lxDvgbQ83sRlg0m3f0nMrJ7
         yO/20dyVLJrm/EKeMdP+euDI/NQJ8MY+y7Fu+REaS25hZ2y5iLf41y+hV7xTLqFCz7Wn
         JHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554276; x=1733159076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0X5ksPuZEo9fE4vkgZvo0Iqh/N6D2VPGhMHc4zrWIk=;
        b=rxCR3WB42Y+dV3zaoQdfV525gD8t3Rx2LWmSg+2np4lotLps8JKZywTPr0VjT58Fpw
         amMOTKZIiXWyBT8x7I7DXNnenEOEkBUMVMvbm3Z/F+cc5bU6I3nHI80nsLbA+dbpWRye
         oNjglk+wDczat3WG0MtZlqoelBSH6KbqCZaRFmVGe6HPytMK5X6wDZ46rvPrQsbaVhgH
         +q8Z0MDlVegBOgW04iqLv/AyLqBVsY2B5rqvb0q/aZo0awfYtla1cS+P49a2iuswWSM1
         6wXB8viXgqSnenTs1ZHR4HNYjY4GIPTAeWJ3iSY+YGxoVDsP0IdjOiGKaQQBhJMITJq1
         WmbA==
X-Gm-Message-State: AOJu0Ywm+JBrkptw2xa5bXS3zJm2d1kXR4yaGYXqnliAWLtsV4lRUz4O
	hfKhaD4lcy9Fde0GiECtpve+PfnVym0xMkIu3mPKmmM8RW8XFAf5Qazl1xo+m27KeDNxB23ZUTg
	LNNjQ9ads2ORpqMODrj1BbVwTuftC+YsDS0XID0kmJsrx45zgcfRz0PODOQtp00kQg/1clTdEAK
	sgOA8iGJZ3OpsYs7eo8nkXZDGePaAnNQ==
X-Google-Smtp-Source: AGHT+IHrmSGMgE6f03x/Cmg7ximfWeS/1p7HLiyXtOdJ80HhKgb7hv9SeHXlrujjx+JDF4obC/NMOnTb
X-Received: from wmqu8.prod.google.com ([2002:a05:600c:19c8:b0:431:5e49:aa41])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d28:b0:431:40ca:ce44
 with SMTP id 5b1f17b1804b1-433ce4b2ec7mr127410755e9.30.1732554276235; Mon, 25
 Nov 2024 09:04:36 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:15 +0100
In-Reply-To: <20241125170411.1898410-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125170411.1898410-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=ardb@kernel.org;
 h=from:subject; bh=gQApAEz6gfUSRYP49oQW0MpQbQMjxKRKRaOdqIRoi3c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lnZCczOGOolmrK5NzDv/KDzOcwXhn5pWrnVNTrf6Xr
 H32pUCuo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzksBYjw5Z4/1rzKYWGakur
 1K+URv9aYVI0PedkYeN99g3MrSLVexkZWjjXRl4M69u2gUfx7qXN0teDN2dknvwhwNnwZhtDVsN +VgA=
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-12-ardb+git@google.com>
Subject: [PATCH v3 4/6] x86/kernel: Move ENTRY_TEXT to the start of the image
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  7734a0f31e99 ("x86/boot: Robustify calling startup_{32,64}() from the decompressor code")

it is no longer necessary for .head.text to appear at the start of the
image.

Considering that ENTRY_TEXT needs to appear PMD-aligned, move it to the
start of the image, where the alignment requirement is trivially met.
Doing so removes the need to place ENTRY_TEXT at the end of .text and
right before .rodata, which appears PMD aligned as well. This will allow
.head.text to be moved into a separate output section in a subsequent
patch, without incurring more padding overhead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 68efd8cd8bf1..c98bc91bafef 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -121,19 +121,6 @@ SECTIONS
 	.text :  AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
 		_stext = .;
-		/* bootstrapping code */
-		HEAD_TEXT
-		TEXT_TEXT
-		SCHED_TEXT
-		LOCK_TEXT
-		KPROBES_TEXT
-		SOFTIRQENTRY_TEXT
-#ifdef CONFIG_MITIGATION_RETPOLINE
-		*(.text..__x86.indirect_thunk)
-		*(.text..__x86.return_thunk)
-#endif
-		STATIC_CALL_TEXT
-
 		ALIGN_ENTRY_TEXT_BEGIN
 		*(.text..__x86.rethunk_untrain)
 		ENTRY_TEXT
@@ -147,6 +134,19 @@ SECTIONS
 		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
+
+		/* bootstrapping code */
+		HEAD_TEXT
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		SOFTIRQENTRY_TEXT
+#ifdef CONFIG_MITIGATION_RETPOLINE
+		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
+#endif
+		STATIC_CALL_TEXT
 		*(.gnu.warning)
 
 	} :text = 0xcccccccc
-- 
2.47.0.371.ga323438b13-goog


