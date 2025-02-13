Return-Path: <linux-kernel+bounces-513927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9DA35061
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4151188ED31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DF2661BE;
	Thu, 13 Feb 2025 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snvZs8k/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB223A9AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481383; cv=none; b=TRjZm8DZsroqxbgCYOHlV1TtcYQeBBrsCBr8MP1IDsLVMYuhCOq3C9O/n7/Tm1sbqtr4pHKV9BTe3lsU8mdlz6dbTc9DfgyQkHyKp7/NQhv5mbmYJlkHnLKIy2LhUKh/+X1pdvwdydvwnjBnNcrAHct7N7k/hICz4zu9fI4+S9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481383; c=relaxed/simple;
	bh=3WQdWhlcAt5RMELpv6jN3CIGB4FcQWFJOyPQ1BhboU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZtkhH1z8FERnq9KN9CjXMjEwkYPbvhMMrCwkMJnq3rOJcZtbTqWne1ycOC6FaMZ6iN1xOhI00jIIb7pXudD4cMW42GluV01OLIfBWu14OWfs8M0wpPVTKdeKj4R4YL7rB7CEjdnl2fpuQxRplwEFDHx9abRQNw+N1kKgeCvJqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snvZs8k/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso2632976a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739481382; x=1740086182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pj2vmCrH3lGmsWMC7Z5CvqsyCPHKSUhgpwUVDrBeFe0=;
        b=snvZs8k/unJpr25vUODl5TIjzYZ5QeE9foi1dktjqjFF1471VKi8SwjwI8ujAmb6Kw
         lMNemLGcEpjqYUsPXAtbiAI9EreZQOU9SKmOAgp73ag+pieTJaHAhP2gS467rc+19Uln
         lnAmRVaiC2hv8to1NLJf9sWZe7SF9box32FSVovQmNU0/JuDuunAt86R4bmSVSHngk2/
         WOiBm1/Zwqs7hjMVjZPeEWAQ4N7w554/rMfphzgzHNXkQkhDtrj8ogHOYPgnQbjttdfq
         62a7FiE17UjeCLXXrXTiu7W3HJQovqYYgFJi6ooOFHYK+DFy/WKCwTYCot+P84QPsrnL
         Tzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739481382; x=1740086182;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pj2vmCrH3lGmsWMC7Z5CvqsyCPHKSUhgpwUVDrBeFe0=;
        b=e/veDyygpwjEd7avK/Axn/JgadqKKJYDg32Tw2l35SRoZ4h5bOqMOj30dpTpjErDX/
         zDu6jRduzvtvJWspbrEjM2XMC8NiRkP+ViQ0U0/+aNUfSuEZHB245AVjJPZYxcyuMbp8
         wufQNHup4XtP5350pEQ3SrkO1GiTO3yuulhhIXqerr1HL2MI67+X3Bk42zGG1c2kUHMX
         huXlGKqNZLHFYq4+ZrZwEVszbI6KGf3ak5M/FdN3DP3cznuTGo6H7FAXFhioLqLXmXSW
         qeAFHbteVCKw7poh1RiZhpHYLeYWkCXPOVkti7L9KP1yJxWt/s/2EpBTAe/fc9+XESuL
         f55w==
X-Forwarded-Encrypted: i=1; AJvYcCWV3/H8h3qLo5HFHMGVc6FjyAYx/rdggSuf379+5ADetpNBqQUWhrJMqyq0LQ81jkDePYjY3FhK/qeBgQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriGhM4Lu8ue5cK06t3H+H0iO4oHYapThWcJsxxQjqxfZJlC2J
	0fe5SxYAmMDPWoz6amfzGAYpnNWOjvqTt/EjfxMUR4NUj81/3FCLI9ryWN2RPAfYJ9DagGjsTc4
	Bysf3KMfgYTeFqfyTNRDJ45QZGw==
X-Google-Smtp-Source: AGHT+IEHVfFE/UqvS5dO+GvH3uIJcuQt27d5Ry/qWjuIp40om+JrXO2vtEBPz+YXbTsmJ6Cg1wki5CWKSxzDlWaRpDI=
X-Received: from pfbbi29.prod.google.com ([2002:a05:6a00:311d:b0:730:83d2:d6a3])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734a:b0:1e1:ac4f:d322 with SMTP id adf61e73a8af0-1ee6b33e8c9mr9215805637.14.1739481381735;
 Thu, 13 Feb 2025 13:16:21 -0800 (PST)
Date: Thu, 13 Feb 2025 21:16:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=samitolvanen@google.com;
 h=from:subject; bh=3WQdWhlcAt5RMELpv6jN3CIGB4FcQWFJOyPQ1BhboU0=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOnrEuUaKxl4F/+xmM1p7nSqL69ELmXL3XcJvYuecT44e
 na15V/tjlIWBjEOBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjARpnMM/wwTH7/cm1r2Ql1M
 y3mVlPSyyb8eCm+/EKM7q64zf8utD48ZGZbuDcnyuhfqmCjo18i09ftyfd+nW3zO8TOHe03beoM vihUA
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213211614.3537605-2-samitolvanen@google.com>
Subject: [PATCH] s390/purgatory: Use -D__DISABLE_EXPORTS
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, kernel test robot <lkp@intel.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The object files in purgatory do not export symbols, so disable exports
for all the object files, not only sha256.o, with -D__DISABLE_EXPORTS.

This fixes a build failure with CONFIG_GENDWARFKSYMS, where we would
otherwise attempt to calculate symbol versions for purgatory objects and
fail because they're not built with debugging information:

error: gendwarfksyms: process_module: dwarf_get_units failed: no debugging information?
make[5]: *** [../scripts/Makefile.build:207: arch/s390/purgatory/string.o] Error 1
make[5]: *** Deleting file 'arch/s390/purgatory/string.o'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502120752.U3fOKScQ-lkp@intel.com/
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/s390/purgatory/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bdcf2a3b6c41..bd39b36e7bd6 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -8,7 +8,7 @@ PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
+CFLAGS_sha256.o := -D__NO_FORTIFY
 
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
@@ -19,9 +19,11 @@ KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
+KBUILD_AFLAGS += -D__DISABLE_EXPORTS
 
 # Since we link purgatory with -r unresolved symbols are not checked, so we
 # also link a purgatory.chk binary without -r to check for unresolved symbols.

base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
-- 
2.48.1.601.g30ceb7b040-goog


