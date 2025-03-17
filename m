Return-Path: <linux-kernel+bounces-564747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E644FA659EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24117B03A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42503201278;
	Mon, 17 Mar 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B6RaHu7w"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBA1F460B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231303; cv=none; b=sJFbNgLp5RO2tq0X/eyZ6z8GqxHBGkeXI/QJ8If8zhY2/UoTy6kgQnbRkciOK1L/CYdbEuQupkGys5KRcefjM2ev1Ax1gkUOwHQ3UnusqVIcj5dWtHD5xGd6L4tMj0LFlFOaaJ3ao/Xw2myTxGuhViGtCXFkjBsYgcoE7EsZocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231303; c=relaxed/simple;
	bh=o8LicozigsBJPUxfw0UjH/+haPfd2EDEodthfJ8bhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQOYgMAimgTnuVnxwXB6Q8QKHqoaBoaKkdwC3XTjEJDsl7r1tBjQRBdeneNO4q8d+RQnup8KSg6kMgQNsz7J0PRcR5kqyN18r3AmI0nVBJaA4IpFxoFzAHlRhJfLd3JMATxO0//E7xlwsnMcprpuX93DAI2Wjh27p8UCtzb7WeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B6RaHu7w; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso12575255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231299; x=1742836099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTEMNxwWUDdJDHTSWR5BaYosnBDapUg7Ev6g031TeV8=;
        b=B6RaHu7w/vTAvs3i8oBRPcmJ8fCdI1+ASycCRjRmU/aXVuSytN2BuFIBoIc/VNDS5a
         NM94toxBLBIm/xJCFrkkhoiXwUpvIWUSb2+QdDFKNuxKKtVxkTcAGDRu8jO8QoM3x1Tj
         UgBIsidJk3qPU5H4UexAOs+t6ejR2FHSdgnPPqiZAHZ9zyFGESmhdYPzQVKSx4zDjoGn
         vxbI1J96zO5+8wdjI5Qpr6x3DnEQQoh2/vy3LjWzuvxVSJn6EVEXhJzwdTtD9C6XzQ3Y
         958QFE5CsO7gK5IobDmz9kvdgiUHGgDP2kOqv8+gMczVqY6NDEra89bHpU0q5sfomCoV
         XrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231299; x=1742836099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTEMNxwWUDdJDHTSWR5BaYosnBDapUg7Ev6g031TeV8=;
        b=eB72ar7qmp81HJpFFFJedhV8j/5dFZP4sX/ZdskU7XddL+WgM2xpKYPi7UQ/DR1Rx9
         FUBG2zCGU6QNCAwCHYnsw6Hu8B30zO3WK+Y+ZVQbeAim7cRJxfpYRvmbf/NYdb1CdeZe
         o3EG+1xB+vdYhnLpgkf3ij1sv1N8w7Q2l/uKp5+/iEGmxF1o68LnknGCvTDBnG5MEIGC
         KeQtPtwwQRUWaRsVLZRZvW6sSLfhJ13w6GtN8+GCWDaRBD3eUVgrw6VTdfLmG5lq0OB0
         e4Rk6P8NdomFXPr6iBLHYKeVu5fv5KSHDDPA1cyFn1d/vH1MCd6ZqUF8EmAkCwdip9Ab
         uefA==
X-Forwarded-Encrypted: i=1; AJvYcCUDJ7+NgmXpQAw2k/c7xE8DdbXPmPfzER8XATzbvNaVYjs1rAUquE5BO2TZteBC4dzVcRaV0j2rdKafgGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHcCghDY/Lgktu6dATVp6JMgr5xmmhERR9fKxMeopI7GozXZul
	wNb/kb/invT6lLz6I6ALoGWxLKUiS3YpTrV+5UXlalp+GHx07Yis/Q7YQSSPH9o=
X-Gm-Gg: ASbGncsMpNLinkGvztXfvFm8WeIO93EehUb3Uc6a0MzYg5SGUGlITAY7pWWct3xfQkj
	OaBT6OKt05QyahCOCiX73D2XbzpiCogn9zdoLMMKw59sriJEzqdRZvbU22LpKR4Td3juT+WY9Y2
	m50ICO+Pvd6fWEXFYJiIwQit8OSKp9uAc+xaKDOIR+vku7ROUyNyJpbJqdKss3ozY1O5JZHCX92
	R3Ue7K0qIs3blVGQOSrHRkjQVXjPUStPYYvtZXBv3PVhLBdE7vETqMuhS/+ghhRHVS6oCE3OJB8
	zMM4ytY1g9dAcSTOBiVIi2/o3NwcAuvVtTwXIrmzt4xvDg==
X-Google-Smtp-Source: AGHT+IF/jPZgtuKO9F2UOB0NNJAFXUmhCJVLus67Lul9R3bvXGZReu7Tw2V0Z3eVtQhps9kA5NlJfg==
X-Received: by 2002:a05:600c:4451:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-43d1ec8a44cmr134590325e9.17.1742231299101;
        Mon, 17 Mar 2025 10:08:19 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:18 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 11/18] riscv: misaligned: enable IRQs while handling misaligned accesses
Date: Mon, 17 Mar 2025 18:06:17 +0100
Message-ID: <20250317170625.1142870-12-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We can safely reenable IRQs if they were enabled in the previous
context. This allows to access user memory that could potentially
trigger a page fault.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 55d9f3450398..3eecc2addc41 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -206,6 +206,11 @@ enum misaligned_access_type {
 static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
 	irqentry_state_t state = irqentry_enter(regs);
+	bool enable_irqs = !regs_irqs_disabled(regs);
+
+	/* Enable interrupts if they were enabled in the interrupted context. */
+	if (enable_irqs)
+		local_irq_enable();
 
 	if (type ==  MISALIGNED_LOAD) {
 		if (handle_misaligned_load(regs))
@@ -217,6 +222,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 				      "Oops - store (or AMO) address misaligned");
 	}
 
+	if (enable_irqs)
+		local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 
-- 
2.47.2


