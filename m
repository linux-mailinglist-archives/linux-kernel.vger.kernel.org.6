Return-Path: <linux-kernel+bounces-433104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68F29E53E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821A9286F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AFD206F20;
	Thu,  5 Dec 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tPQl8TN"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1F2066DD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398114; cv=none; b=dY2pNln7hvh1H0ZK1oXpsW+HZMx+Goao5is1xLYQACuo1U2ztUW/OvX7rdhqX5sdPMMI2aYcMFomFSh7kX+XKFaBZhvRL8MqGu0o5St5gAnnJ2O5qSsudi39S5995uADs9jcsQR6kw03VG3ISEN+KuURrbxqfGyXIfBt8iR6wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398114; c=relaxed/simple;
	bh=/YvV9l3pQm76dLk2s+A4wuevSEt3hiNsmv08HgXWrpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=auGh3jzM6MT+Sk4QgunkjyAvRQXApPCvbcFPQTgdMldO0NeOMD7oF3qdZlTsenZCfQmoyMeaFNoZFPcrjGl7DC1bOWjocJcIbiVCQTwLynOHNxaRsh3EYx0EhlVCXQZdKbw8MugZa8kXZiqkljFBKvI5/kbhyRj2tj0O3NkZSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tPQl8TN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434996c1aa7so6826115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398111; x=1734002911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnvdN3VftUWkRI82445ybOQvXbk1ghezwmtQPxwxKiQ=;
        b=2tPQl8TNuz3e5tQvmPdupH3qBDrWekie1Xa9dmys2SRr+Ys/+A+Xm01XCOaW6Sspu5
         5QDLiD5dEjkvF7eNC9idQ0hUuggZodPImcVkpVZjqaldViuWK1uEf1DDl6FjCn04Yj4M
         Esksd4/DU+cA1Q0wZobbdhn5xfVVocfX0d98NRFaM7jiz9p/ro7ByJmcq/0zZcPsc3ey
         fUSPMUw8p59G/N4v+ErXCe0GwXAAXgtUzNPFtOxH/H12rvQRSQLvKi1DGKKr5YYsc47B
         ssnRv+CYyo9jpc5irYlKaMwfQXCayuowhCWuogZVZsIKHbwaMqZPwrRxkkW5oSnW51jT
         UkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398111; x=1734002911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnvdN3VftUWkRI82445ybOQvXbk1ghezwmtQPxwxKiQ=;
        b=qQfyYOG+Qqr9Cb/TOC+ZLxOnOPJLLor0lUrldi73YWJs2bLqINgGHQOWLp0LtvkfIv
         sbUOxjCtf04hNTikRGBb9VRl9F7tPVWZ+YAJPDzrbF6GtSwPaSxvAanfRjJcCZh9HdE/
         sJ4XVi11dhwbzvGUAGFM6n1KGU6xhyrcf2cAic6+H0tU8YnbS4uTG7779xCiXt8N0MSk
         lVvELn9Pg/le1bgkkdgN6y0jfIF5JoM0FFLRegjMeKcrHaGbd7ZEBP7fZc4zlxpZ9W4S
         9miHDbRwElYF56G4K93LiLwOntjh2sJX6myIMAT1Gg/LLlxXFKP/R2LRyW8q/7/ISRBl
         0FUw==
X-Gm-Message-State: AOJu0YzzNOvS0o187lBDZj5wmgveuBkYizr6Sn7DFXy5F96rqXR+kFYE
	LyLbTxfqjSKJqTYcnh67OUO7csebTweNJ0Mu7MCkbHWi5zs0Aj4+t6x2xUeNmKX5xvtpadpCIK2
	Rsm1jcAGlE51hqrvT9lnj8a7hg2rFlumfCCXujG8spNrgcczinmCO3yiSCVH/80xHpCJpPcptrw
	R3sZOC+E7MF9l5S1YrcW84j3Hpju2F4A==
X-Google-Smtp-Source: AGHT+IEuIlfhARIcbOHb5Y5tBc1TaoHS8JRg698S5VHSBKDpvfagxN57YF4M3ejpY8ZErkAl6cttgrQU
X-Received: from wmlc19.prod.google.com ([2002:a7b:c853:0:b0:434:a16d:950d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3ca7:b0:434:a1e7:27b2
 with SMTP id 5b1f17b1804b1-434d09b1817mr82261385e9.7.1733398111547; Thu, 05
 Dec 2024 03:28:31 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:10 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=ardb@kernel.org;
 h=from:subject; bh=C9f1Jrw/jMP8yxDP/tyUNWCXL7TLAnJYYswszi7hh0Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wz8f7280Fhsens+d/Fwwqf/c9q0a0cPe3dz/NP4sff
 MN2OSezo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk8V9GhkkFfGd8nJQkBbjP
 8D5bwi/w+CmTzwwxs7zLP00q570OvcfIsKd53SLW4Ky2B7vdHq3QTWK42X6rLnO3rHXfM70vz1/ y8QEA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-14-ardb+git@google.com>
Subject: [PATCH v4 5/7] x86/kernel: Move ENTRY_TEXT to the start of the image
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
image. Since ENTRY_TEXT needs to appear PMD-aligned, it is easier to
just place it at the start of the image, rather than line it up with the
end of the .text section. The amount of padding required should be the
same, but this arrangement also permits .head.text to be split off and
emitted separately, which is needed by a subsequent change.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index fab3ac9a4574..1ce7889cd12b 100644
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
2.47.0.338.g60cca15819-goog


