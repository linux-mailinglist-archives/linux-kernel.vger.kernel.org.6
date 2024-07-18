Return-Path: <linux-kernel+bounces-256039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37980934816
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06DC282F65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78D344366;
	Thu, 18 Jul 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZAB5xZS"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD91BDD0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284381; cv=none; b=mseH62KQJllJTDEEbuH2dzKqSut5L31dtwhpwGgDzyr3v6jMnHMLa1+FYbRo5CaGF+agfGMSVnzXqIu7jVGUC5rLOr1LQBtpzrLsuW2y+3UkRcgiUiiao4x5eV/r+VnlppZz+xfnUOOMf68fyNhwHg3yHlOzZSr6hr70OQpbjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284381; c=relaxed/simple;
	bh=HJAB6KTe1NBLU+nAkS0Ft7hMTfrWUepm/9Sflwf58kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYy3pndKfuR+3NN60uCkWMZkG6HuoXHvfdWhDXIl/5huwlOgv3WxgGlE+Xzd1iL7c9sCfZDEnVq157szYT22Z7TkjuhQ6LPG6ZezDA3KJYR9NBqBsp/yag4qICbUYAnyFk1mhyEJ1rUOjgW+Md/6w89zXftARsH7xOa6aMrVA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZAB5xZS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so284288f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 23:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721284378; x=1721889178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xw66+GudDwZFqroCKpttPJq6HRt/fwTWt4ipOV3S4nI=;
        b=BZAB5xZSY40GKiSgPqdhwju04NdsOk+FDGT7vWBWjBL1i2yQN86c5ES7tIE6EfYQIz
         9L9C898RHhqvvqFq1X06misKOExGJBj/UFV3oVfcOY7U4ditPElC6tKLUIfYFCRwJbtr
         siH9BsMnbATQzHKgaILFqnXCWNq4KEAGPdA3yof1+7y6btH52rn0YD+O3SDqaw/5sUON
         Twq84BJHgUxEUr6tNV/adY60OvvaCW6wjtzPaME5ZBbt6TAHW1NArjOvoRtoOrNWBbaY
         83lh8mFWCuqiNo/PmyPigwqUZoFP59KnhuYaGz2caCNjc+1FqHEKiMZk+k4Q8DH523PB
         fEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721284378; x=1721889178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xw66+GudDwZFqroCKpttPJq6HRt/fwTWt4ipOV3S4nI=;
        b=HLbWTsXF//bjIyzD1jwPdB6EvYaFpLMI6yaM8ZX0mwUqTeqmwio5tU4Gn8ZveAHpsS
         eg2EJCXF3e3WQz/DgBD/uLndQtAUKqXT11Xx/ylfTrN9dz5MVdg9IT25In6TTPyXMyYZ
         IrTzKQkgznrYMliEpsLwt/pOMDIkLY5LkOqUFGjMOkHN4b3NCqGM6fxreEnuktLg2aCL
         yYvzjhd2NWPjaUPUYI/oeKlle5xiv/1tUiw+AXRZ/6bcB0tFyg4jYi27SMmP1ij1FpWB
         uBm0tNaTjTsDU2D4p9Vg/EyqOPMhczs/hK6Uhf+fwXWRMgLJxhvIu9x25qqNzxmVtMZx
         0bIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCCFLONXgZcb83YKXSq2yUiVC51m9mlFaFf6Og2yDobpGziqZo1DmunhjuMJf7aAEZQxwPTyhtF7DaTk5q+cAltSn4Hq7LVjIkgGQz
X-Gm-Message-State: AOJu0YzLKn6d9lwAYztxgZXZ2kPcRNCxXVtZtcH6V/iDSjMpXyk14H0o
	+bdKkvYAoys0YtyblCHDYlDSPb6FBRgjjpyHV3QSpalQAvDvBVVf
X-Google-Smtp-Source: AGHT+IG6EMI94mx59foLA4B8tczx/e7ClWKpTKE6zuG/70QMY3da2rBpWhLrqFmAZokUlRP+M37Kwg==
X-Received: by 2002:adf:cc04:0:b0:367:9516:ffb4 with SMTP id ffacd0b85a97d-3683164cad7mr2801833f8f.19.1721284377439;
        Wed, 17 Jul 2024 23:32:57 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf3bdsm13320373f8f.30.2024.07.17.23.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 23:32:57 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/boot: Use __ASM_SIZE() to reduce ifdeffery in cpuflags.c
Date: Thu, 18 Jul 2024 08:32:18 +0200
Message-ID: <20240718063242.52275-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/boot/cpuflags.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237ba7ce9..aacabe431fd5 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include "bitops.h"
 
+#include <asm/asm.h>
 #include <asm/processor-flags.h>
 #include <asm/required-features.h>
 #include <asm/msr-index.h>
@@ -36,13 +37,8 @@ static int has_fpu(void)
  * compressed/ directory where it may be 64-bit code, and thus needs
  * to be 'pushfq' or 'popfq' in that case.
  */
-#ifdef __x86_64__
-#define PUSHF "pushfq"
-#define POPF "popfq"
-#else
-#define PUSHF "pushfl"
-#define POPF "popfl"
-#endif
+#define PUSHF __ASM_SIZE(pushf)
+#define POPF __ASM_SIZE(popf)
 
 int has_eflag(unsigned long mask)
 {
-- 
2.45.2


