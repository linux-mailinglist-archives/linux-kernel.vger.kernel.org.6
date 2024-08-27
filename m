Return-Path: <linux-kernel+bounces-303991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD44896181F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847A3285521
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF0F1D31A8;
	Tue, 27 Aug 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5qitW3p"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EC156250
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787546; cv=none; b=c3tIMGuiprPxTrI4FjecqC/D401l7mhH1mq67bCg6IN3jroDz/4bTAVyutkdyZePJ/IlkFwYFlRrgWyyJF60INjHUK8RDPhllduoOYjNBXbRaLK3wtfO6WUNKyzWFeN95HQbpwzAaQFB+FkOvsdlS/hdR7XoEcuYcj9vFd6J1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787546; c=relaxed/simple;
	bh=K8CboGhZ9yuHVLKmofbIAcIxBqnTTRvLVVlSNw+SQII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akPT8s0TaragFQCdjNo3/J2fpTZVkSR8L90h25K1KVRljNgtuYr87a5ipY84boXNyH0S8uYOziDQLy2vn0ucIJvCQcJnY5VEn/a+Q6Uzp6EM55ADOwUmapN1jHR9H+EH2rrJ0z5Av3AK3oHCsoAY6ZSoGnUfJ3eXT1V++m7jiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5qitW3p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20219a0fe4dso58856675ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724787544; x=1725392344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FO60D97gOOTFkiNBFEwFM23LWZ49voULeyhtmHM4mI=;
        b=f5qitW3pSVHn8b1Qs2WA+Ruv0zx9PEu/Q2A0y0SRhFEHeGJDtrQxQwDnjttves6t1A
         K6g5VDGDmWHH/s+gZ861Usycquv23zJeV87PlF+6vv4F2ZrRZsbVMGtyDY35TAUvWbz8
         3jwxpiczgahUcMkS9WhLfZmCbXiga+UfQMgSFraJKyVkXaDNqTJm4Hs2VWS6W0zyiJLt
         XSQ0Hs8UJBTfd1VMiaXLqjkPIiOj9S9IBzCde1q01FXjMC5s2dPhAc8E0CPWC641Mkxt
         wUIujKh5Uv2W+PiuSAn0tCNhf54M4wO0MhXsmbDaG73U5qk8QNrvgRgiV+5RmU4VxIPe
         fPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787544; x=1725392344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FO60D97gOOTFkiNBFEwFM23LWZ49voULeyhtmHM4mI=;
        b=G1hj7pPhXC4sO0J4SQB89cffJ5DNB9mBxYELjNiaD83S1Ea8hURYgafvHUIZUqVKx9
         p/K6RTCoJjvvMXbT/drXgKMCjzxCvP/a0TH0aSzPZg0ltROwo6lxNKPE5zCii65x+vxL
         ebHr/LCQ0krtYbUB9YKEPsLC06sYlZaja277KOdhlp0FVaP/qK55BLS4MRShbFLpn8Xo
         sKjq9FxJ9RmO7KFFg2fe5L8v6EuGHwxWDkW61lQJ6yvKUR9d8+GR8HjOcTNZGsV1Qb8H
         hf2rkcz3CJ7fmONnvdTeuX9CTgtPVUfcFiOME2Nn0GmrVbPA6D/NA5TeDpGDW0j71JHw
         gxuQ==
X-Gm-Message-State: AOJu0YzfPKFFw++RyPI76KABUnbhGdHw5PGKNkUDvGPgmAqBfzp1rjku
	xnBlgLHDjU3kc0IiSrl7ue1s37J1Fin7wT3B/DlnXLNigsj/d3g0
X-Google-Smtp-Source: AGHT+IEdEo2C9MvAOXeKpa4R856afyBQRZuuGy0ZLczYjfA2hA/JnYu0nffVw179cBCBJKJWkDHbWA==
X-Received: by 2002:a17:902:c401:b0:203:a0ea:6266 with SMTP id d9443c01a7336-203a0ea6d13mr140108005ad.12.1724787544151;
        Tue, 27 Aug 2024 12:39:04 -0700 (PDT)
Received: from fedora.. ([2409:40d0:3a:e5b4:1c14:bc7d:2dd8:f670])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609a88sm86687205ad.208.2024.08.27.12.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:39:03 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: sm750fb: fix checkpatch warning architecture specific defines should be avoided
Date: Wed, 28 Aug 2024 01:06:37 +0530
Message-ID: <20240827193634.3291-4-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abstract out x86-specific code in ddk750_init_hw() to improve
portability and adhere to kernel coding standards. Replaces
architecture-specific defines with CONFIG_X86 checks.

Fixes checkpatch warning:
- CHECK: architecture specific defines should be avoided.

Changes made:
- Create a new function sm750le_set_graphic_mode to encapsulate architecture
specifc behaviour.
- Using CONFIG_X86 instead of i386 and x86.
- Added placeholder for non-x86 architectures in sm750le_set_graphic_mode
function.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 02860d3ec365..23196070bceb 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -210,6 +210,17 @@ unsigned int ddk750_get_vm_size(void)
 	return data;
 }
 
+static void sm750le_set_graphic_mode(void)
+{
+#ifdef CONFIG_X86
+	outb_p(0x88, 0x3d4);
+	outb_p(0x06, 0x3d5);
+#else
+	/* Implement an alternative method for non-x86 architectures */
+	/* This might involve memory-mapped I/O or other chip-specific methods */
+#endif
+}
+
 int ddk750_init_hw(struct initchip_param *p_init_param)
 {
 	unsigned int reg;
@@ -229,11 +240,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
 		poke32(VGA_CONFIGURATION, reg);
 	} else {
-#if defined(__i386__) || defined(__x86_64__)
-		/* set graphic mode via IO method */
-		outb_p(0x88, 0x3d4);
-		outb_p(0x06, 0x3d5);
-#endif
+		sm750le_set_graphic_mode();
 	}
 
 	/* Set the Main Chip Clock */
-- 
2.46.0


