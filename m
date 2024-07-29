Return-Path: <linux-kernel+bounces-266165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7293FBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827451C223E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F1158D63;
	Mon, 29 Jul 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm30Xwvu"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9A147C79
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271890; cv=none; b=dFEtt9VE7u0Qsdr+pZwOIFTEzyCqjxx+/nQlFKj34P6ixR/JRoO1wrfoVnDURngcsMxh8VejGI2slm+e32WGC17TQEnygaYRsi9kZUoLWimFgMU0BR6uW3IFqYBR3BYenl21UDwtGJGkZAnccqD8yFFBpXyNYWnKJMluPFFZdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271890; c=relaxed/simple;
	bh=o0QNt0n9ugEX4273aecspDdMhL1dqvnv8WC083LxeqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S1aed6zKV/IUMLKUdAOgVTIMdEBo053a5vTDP8QQBJKIUuboXABI/fSqeRerf6mllHnGKQfa+y0vB/az+ygAW8kYzBDSXeq9Hx21UmJ7bYwVgEz0CRq1IZfBCXTajVcjXuXK+KGqSy5fMgXERDmejZbAMybpaObSM5waPv+95nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm30Xwvu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d153fec2fso2737921b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722271888; x=1722876688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rts0y+qLM2ySyPg07tBoZfL+20ST62xQmVk7z7Jd+No=;
        b=Sm30Xwvu91Ep1ewfh7wEnJSRwZOZpx3QXi1d5Ys70cClyfJzm2/3W8J5stxb6BfD/D
         8H2OPqd0ybKVT3FcJaFlILPvNI9yLueTriJK7ceC+gnwJ6vwh6/e6GBMOUF7/0A6ObmH
         MBK97N67I/q52MnEduQ3+bpGuCgR5oEA1ZP2ZW1vFEnxfg6kFjjOu8haVlkvIZICUHzz
         FEbJt+dX3bgNiwi2RxDUFIApV+L9WDXkIV5CFkwVqPcGmVUf6s1JE1o+pQMjGE4wDqmZ
         PAlkzYm9+IEjQ8ZOQBqBkicSENL58A/2Kk8dsaqqUsiluJg0+jv7JYsSECSWiIV0x0lI
         tLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271888; x=1722876688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rts0y+qLM2ySyPg07tBoZfL+20ST62xQmVk7z7Jd+No=;
        b=e6K+Y7v50hVJxKDZFbjpsfcL2Io6tH8y3HlMioQyIpermaC/u+r6yL2hUXaEUcvm9L
         Ntjod4JdXB2Gvy95U9xvy4faoi0udD1MXi8/+L2XpQeEoF8INytCPcsgCZGL2h4ibyLD
         y6e/Rxt+2BCJQpBxRwxb9UsT6KTuwiKhY1JO83bSZoVie/Zu51KkEAge7tvUW3jHSDFF
         SlIwlZfxRTfdh7kSqhAaUpY+Of9kNDH1ystDKTIoV0ELrHu0Xi38besJLqtIGICUJhMP
         6ZXnmyB2MVotmxawwqJEh4ZpBVQEPyoJho6yuMm7zO4sS5TUs2CLQIxSAZ4tJd82S3d6
         B0tw==
X-Forwarded-Encrypted: i=1; AJvYcCUJMBKthLyTADir+UNXYus/CJssoY49Rq4JQ4nMpWrjPzmDPajzWskngDW6qYiGtm7vAiXwed0GHgwB4IET26oYvls4NTgImdtsxtbP
X-Gm-Message-State: AOJu0YzITW7yTTom1xZnVDIrCk2v77Z8JxPw4zn8ipkl1fAnOJh2Wreg
	a7c8HeUox40XbNNN3Rol39ZCzuyY8DxqNR1wNL6e/pHKQhkfopNP
X-Google-Smtp-Source: AGHT+IHnbiUjwgfgIVJN2GRioWxLaHrItbrosA7uh3elsqVXByxks0pOTbIXM1nSuJNuYlh4gBIoxQ==
X-Received: by 2002:a05:6a20:43a8:b0:1c1:d866:7db8 with SMTP id adf61e73a8af0-1c4a117916dmr11125685637.9.1722271888106;
        Mon, 29 Jul 2024 09:51:28 -0700 (PDT)
Received: from tank.hsd1.ca.comcast.net ([2601:647:4d7e:13e5:90c1:2418:d929:e1bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812718sm7026140b3a.119.2024.07.29.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:51:27 -0700 (PDT)
From: Mikhail Iakhiaev <mikhailai@gmail.com>
To: linux@armlinux.org.uk
Cc: mikhailai@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm/patch: call flush_icache ASAP after writing new instruction.
Date: Mon, 29 Jul 2024 09:50:36 -0700
Message-Id: <20240729165036.7368-1-mikhailai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch moves flush_icache before the patch_unmap call.
The change avoids the possibility of the CPU seeing
partially-patched instructions if a function from patch_unmap
call tree has just been patched. That HAS been observed
in practice, leading to kernel panic or freezing in early boot:
https://bugzilla.kernel.org/show_bug.cgi?id=219089
Specifically, the patch_unmap invokes _raw_spin_unlock_irqrestore
(could be non-inlined) and that function is being patched
during the ftrace_init, so the original code would run the
patched code BEFORE flushing the icache.

Note, some arches are more careful about flushing icache early. E.g.
arch/riscv/kernel/patch.c:
  __patch_insn_set and __patch_insn_write call the
  local_flush_icache_range before the patch_unmap and have an
  explicit comment about this.
arch/x86/kernel/alternative.c:
  text_poke_early calls sync_core (flushes icache) before
  local_irq_restore.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219089
Signed-off-by: Mikhail Iakhiaev <mikhailai@gmail.com>
---
 arch/arm/kernel/patch.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index e9e828b6bb30..f003867f085a 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -99,13 +99,19 @@ void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 		size = sizeof(u32);
 	}
 
-	if (waddr != addr) {
+	if (waddr != addr)
 		flush_kernel_vmap_range(waddr, twopage ? size / 2 : size);
-		patch_unmap(FIX_TEXT_POKE0, &flags);
-	}
 
 	flush_icache_range((uintptr_t)(addr),
 			   (uintptr_t)(addr) + size);
+
+	/* Can only call 'patch_unmap' after flushing dcache and icache,
+	 * because it calls 'raw_spin_unlock_irqrestore', but that may
+	 * happen to be the very function we're currently patching
+	 * (as it happens during the ftrace init).
+	 */
+	if (waddr != addr)
+		patch_unmap(FIX_TEXT_POKE0, &flags);
 }
 
 static int __kprobes patch_text_stop_machine(void *data)
-- 
2.34.1


