Return-Path: <linux-kernel+bounces-577560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A2A71EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBD1889882
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8824C09B;
	Wed, 26 Mar 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2KrIH9X0"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1828F4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015914; cv=none; b=IA7iDHlkvCPoRxWljF+AoGcyYioIL83wjYKntv8V7vkPPCQmVYto6F4tmWaxUm1e58fb/a1wLry6CXTRATP+lh52la0nc8ODAafkmuWB4I2FQ5AgYF3CAA5ovXkUXvcVgLzXuEoaKqP5jIjAn3PnkXApSxeOJOBIYZEjpE3EhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015914; c=relaxed/simple;
	bh=tLUm45R8/GPZ/LUcfff6E8CHOJ0CuOLBzUUipjlMJAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wjgjcjrz2/raDeufLik2wPpFaMsgj46Srig57UOJ0BT37GWQhtwBkjodiOzmJC05oRWhLVWPWK615urxSfS1D8mz6mZhBDShkhIkKdn9RpfzON5pa3YUtszMbxPp/FRiwOxFcwuNpqyKxIvB9RwgscRNl8OB1n6cODYyt2Jq1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2KrIH9X0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225107fbdc7so3629445ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743015912; x=1743620712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DXr60kPcHkddAhJfp9MCcqTGpCcxatqv7lUBWSRFhw=;
        b=2KrIH9X0UldHmMi0bXWIi7ZDO+QjjHNdyHxCXIJ/TZL3RtCGdw37PGNrP2DF9zgZ9c
         tKYpWOw2xDVtT/66qwntYFxB3pX9HUIqOVyppbx1dkxAEsX0rfUIU2glYHwN3oItAPWj
         zBConMTajYsx8w8kdv6ZIW5wYhGaTUIZHdmHxuvsOzbLSgE+Cg4qW++1BsF1Hm35VS65
         RfkPfmaxgTxGOu6RG61TqfAny50YRDwYmOn/4Qa/PnNO1jm8BrS9GarBUp1cGQi89aMO
         SrstZkd0/bp59xwFi/GRB99ovrGi0HAkCyd9VMPdnTkReSzaAZRsIiYwB9lQse0R4QCn
         zuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015912; x=1743620712;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DXr60kPcHkddAhJfp9MCcqTGpCcxatqv7lUBWSRFhw=;
        b=tK9lharwj4NKJSoeDAZvSB13EJg9U5Tp+ROKIV9AivAJ+tdODjgf15AIs+IdlXKZuP
         RzEhavCg5mmE/A9dbWOJW3ST/2FerkETbFtD9YKjaIORPlaKuNk6VuRCgO2/mi/1K3Oy
         yFFGr/TueGZA9AHgU4eRCsuHDrH+zs0ptS7T4WAaD0wVGa+8PLc3XOFWuoWS78rCNqvQ
         sN/jG0Lmcw2OV6hMPGJkhjY/dNMTyF8a4x5FYb2pe9kiBhV1Hy1u3vLO/6sEaZGQmGZM
         krL8Xk5/ygJIaj77+nWOEzAEV8lUDmCU34izZz6TILfP9NFiZ6bwL5unad2lydmUI6rA
         vShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX1WnhmNejMdBJGpdjfAZ00JrFXIGFWrqI8o2HcZeotCPhQerB8iKAWveHWWDHpYRzBOj/nlVoGUPfWdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfa9wqO+H5uBkeH6gyg649oFyEU9iA5oku2d8k9Erhqx04qrX0
	RPvIJvObVn43Eu/nc7I+PaRrXMAT1abfIDSaJMzjDu1jpg1oriUnzp1EB6nBBZBa4l4B/vibQgw
	YCLSIM74yHW4HwRvkwzz/E9sDWQ==
X-Google-Smtp-Source: AGHT+IF04rFI7uoAifaalhzOSSMCwcat9J+XcqeRT6msx0P5SIjYgnCWtRVcBKSFkGMVYS8CI98R5W6v50aBUub08xQ=
X-Received: from plhd14.prod.google.com ([2002:a17:903:230e:b0:223:69a1:46da])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccc6:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22804858ff9mr9113005ad.20.1743015912058;
 Wed, 26 Mar 2025 12:05:12 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:05:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=samitolvanen@google.com;
 h=from:subject; bh=tLUm45R8/GPZ/LUcfff6E8CHOJ0CuOLBzUUipjlMJAY=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOlP/O/IKn8+7H5115bELZkCkUxvroZFGsZH6D392Pigj
 6nxCnNrRykLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZhI6T2Gf6bWwgGGQoqz3T1n
 X1cVXyhwJbdZ4YDGl439ErNr6y9GxTL802hf4cX61CJ8vZZn2AbeltWvuxe6Wvdd5i5fpH1E7uo MJgA=
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326190500.847236-2-samitolvanen@google.com>
Subject: [PATCH] um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h
From: Sami Tolvanen <samitolvanen@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, kernel test robot <lkp@intel.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With CONFIG_GENDWARFKSYMS, um builds fail due to missing prototypes
in asm/asm-prototypes.h. Add declarations for cmpxchg8b_emu and the
exported checksum functions, including csum_partial_copy_generic as
it's also exported.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503251216.lE4t9Ikj-lkp@intel.com/
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/um/include/asm/asm-prototypes.h | 5 +++++
 arch/x86/um/asm/checksum.h           | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/include/asm/asm-prototypes.h b/arch/um/include/asm/asm-prototypes.h
index 5898a26daa0d..408b31d59127 100644
--- a/arch/um/include/asm/asm-prototypes.h
+++ b/arch/um/include/asm/asm-prototypes.h
@@ -1 +1,6 @@
 #include <asm-generic/asm-prototypes.h>
+#include <asm/checksum.h>
+
+#ifdef CONFIG_UML_X86
+extern void cmpxchg8b_emu(void);
+#endif
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index b07824500363..ddc144657efa 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -20,6 +20,9 @@
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
+/* Do not call this directly. Declared for export type visibility. */
+extern __visible __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+
 /**
  * csum_fold - Fold and invert a 32bit checksum.
  * sum: 32bit unfolded sum

base-commit: f6e0150b2003fb2b9265028a618aa1732b3edc8f
-- 
2.49.0.395.g12beb8f557-goog


