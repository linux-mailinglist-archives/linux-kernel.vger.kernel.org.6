Return-Path: <linux-kernel+bounces-554538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10EA59986
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C4916ED39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C103522D799;
	Mon, 10 Mar 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sdD/23dZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8A22F144
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619653; cv=none; b=U7CLWfZDmDw+A0weMpT/XkfIuVPE1HyCibjV+KH8JF3QVABcP8JenChtMaoWV8iHqnuDYmBcMCmPDC0dlIxF3cgw3XvW5sQA9A38YDaluiq/VDf4P3EeXSkCBrVNJzePEzG8mOYNimc7OQ/dc12aZFPR9jbsKj76ydsiEtBqFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619653; c=relaxed/simple;
	bh=o8LicozigsBJPUxfw0UjH/+haPfd2EDEodthfJ8bhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1e47Jl7RTgxi4HvmS2gSu8pAfwa+CV4NS1U8KL4RrNnl1/306LzhPZmxC7tEebrrSwSm1Qt+QjnpqtXt0ZNJPyxiypgJ2iBv22/V/M99s8gyQZ4t5pOQnzmFpy31jlxj/a1zDTmihy6G05vt+LJBzN5xkzLhPgKj+07/hWNm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sdD/23dZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2241053582dso69944615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619651; x=1742224451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTEMNxwWUDdJDHTSWR5BaYosnBDapUg7Ev6g031TeV8=;
        b=sdD/23dZh56zIGm8cLD57MT1KljzYrdDdt0dTNjXryen8/XPut3abB0rYHPCsTnwIl
         xBltirmFV6nHe57X0hLBs9mWLRWy4vI+sZj2qGbIKjKJtVbtnuJzYRLZrCiM7XM/ahwJ
         ZpXOcffhvM+w+4+bsrIeOXs0dN1CGZ+NFBFTQYQR27GGRth8cMejLYM8u6/i1a3mc9xP
         IrDyfcCA2Q4tgWfDQV/kcIlWNB4HFx1rOX3QKICsv9NkXWic3SPDGx2De36h2SGf+uJ9
         4KAjrCmLACeHBpGjvTXIMYcZmASp0gPbF919FzQkH6r9/oZLBGobFP9q65GeHJklT/Uk
         Hu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619651; x=1742224451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTEMNxwWUDdJDHTSWR5BaYosnBDapUg7Ev6g031TeV8=;
        b=BjJfeYo1jRRLdasB6Lj9C04/qyO3V3pFH30wzlUqn1yAMHmfDpgs8ndpzPsFvEQ15c
         Yhq/gFKQspBwcsi9A/GSW1R532fyFowumeOqjMJSUrSFiNlNnsJpKkIDn0Qo144HwRej
         dsxQ0Rr7gDv5Iwc9RlyOkq0bRqV18cFc7+DO8FaAvTEiBzp0l64K+cEydomBprn9mVG5
         PkjYsLquZonkPZuipBLHgjWExlfpCZZn66p7xup5nJqL+qiMu0j04yv3QXgZG4SMV2nL
         DVnRVeIaiLQt2FC17TDQTi3i5WgbgeHiWjn9lAtke3hZhqDbxamuZdfDlXLfhu28nuoE
         dnOA==
X-Forwarded-Encrypted: i=1; AJvYcCXEvc6KS1RlmVfbBs44XFjuAfTFzlUe3xaxwD53JrR2gT/lzOsJLhYbboDqQw7dsrKmSObkCXpxD2f6g8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Z/qXGKTin9sy61k5WSHkxl/SutP2GKzacJcFryuh2T6r4OOx
	O3cgiQ9LhZ9zMg4ESm241LOssXqeSAZMXVcIyq6158Pwt3Niyj9puI3KYRzliuM=
X-Gm-Gg: ASbGncvsgVTeueA5G2Tg/hYxiT1SYu57M+T9cYmtgDeC6DrPQowfd4c/qIHckG8SCfS
	A/QsK3LbIx3c5TO1HVFh48QhrfFGiS248lry019q1incenZfzKGNe2N5afI67rs/rwGFOwqYisk
	wm7HGsSB3Gl877yAAKff4byNZEmKjyxJBP5oZzRY56/iK0FGUWAPOHpFvm4t7rkLdiQ9YxhU3q7
	OMZ1A0sJV5qm3ubvqiunpbC3OlO5Vh9YycNnC1BcHyhEMtu+NoFP0IAPYs3u/o6CGpUOesZWdCU
	ZQoGHCTNuN4dA/DYhPALDSvg00Weo5PEVwfOQnerdOSp2w==
X-Google-Smtp-Source: AGHT+IFrDg0cMkxcg3xxzzqPCaOQUBTnQwFpZHXCVcuWzC1x8fPkcfYHuG4bXSCleAdszR5qGgJy/A==
X-Received: by 2002:a17:902:d54e:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-2242887b415mr253277735ad.1.1741619651099;
        Mon, 10 Mar 2025 08:14:11 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:10 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 10/17] riscv: misaligned: enable IRQs while handling misaligned accesses
Date: Mon, 10 Mar 2025 16:12:17 +0100
Message-ID: <20250310151229.2365992-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
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


