Return-Path: <linux-kernel+bounces-381359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2F9AFE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E01B248A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78871206E9E;
	Fri, 25 Oct 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sb52vvB3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F01D8E1A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847746; cv=none; b=rXTmH1OHjv8jTZyzE09/OMmQdGvRTGvQo5qxl0SytohfwsMJDzpsRUDa9/6+uE+Vvc02qJfPKvAhbBM+ekSH/CCLmxIiAXJJ3aRC9N76u/gC+SFIsYNBpOx/J70ZuRdLcb8Zf/LUvqUFTkuaYZiGMWp1Q7ItP6nKQ7bg99kaaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847746; c=relaxed/simple;
	bh=y14/TUYv+pOTh8zRwcQM0iH6LlKjb0hA4mvEhgkzWJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VrBff3dYEL0NRS+XyIXUj4P8ufrHNMbDIuNZd//lzmxgfTxPKQiqb5+koipQqdWAB7/6CzpM2aWhhNtblLnGMJl0G6oqDpphID7qYh+L4ZlAWYF/jfBtwkTdLLvGxkgwrzSUhGLrOEuDuOgU8tKkMoCtpDwGiwDmLqnAXfa1J9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sb52vvB3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8c50fdd9so17993585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729847744; x=1730452544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DTUkSYOlRU3ybbwBrGBMsEPjomkF1Ub5awaswPrW1E=;
        b=Sb52vvB3kjsmkjSeTwYNEhCUY/WWWQI6ujKccjgVyThnoM/LdVBZcNFvsS5uILfWdn
         mOBtDWOPxR1gciqqMcrdQ9krLTNPfcQRNMbbhlgjC6WhCFCbxVWJT9QVYNjBLofdqXzP
         NARPVSLEf1DsA7ewcIjr2bpot9Zp2UG1qt8vSQWxDyrFsf5WbE0MKv+BUfcbLEjgR4OQ
         GeZF65AHXbnYJtQ3cmTJ30IORZC3vlF5HTOBnQEIivDzjqewZM8kTlTHc3iv/srPEKbP
         uJfSwYllmPrpTB/7ZZQYPg3ryX0uzVw5b+ZSSazSC3OT7xKClpK+PCIg/AsYSB/nGfc7
         DFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847744; x=1730452544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DTUkSYOlRU3ybbwBrGBMsEPjomkF1Ub5awaswPrW1E=;
        b=WSjAsgOaRnBjvAYyyrdYRCTG4ZYgOOYwiREw7Wme0CwQ+mRuC0m+PgbdEte1LqppmY
         f7Mf9T+MR6Q7PlpfC6P4GKNz/QLrCqJoNDKsegAWpEBKMv8VFTWKsPype4tsXWodfW2r
         Pfa4ovwG+gOSf9fNVx8+6xzL2yhQefRtGjA7i6z/OBoDqsQBpttZQvMTsFfRjOnD3FfG
         sCiO6YDB8HHCByqsCi27ZWdjpgrREeH4kiUbNGtT5WTyNrupaFSodqz/9BpIJ89WVOpe
         wlGqCcawpnLs0G8Ox173hqv1Q0FagBBdChR9biB/wlUc8PKjuB4qKiXTyw/uq8T8JIMk
         6tEg==
X-Forwarded-Encrypted: i=1; AJvYcCUb4MAGXpVbbf3qIogyAwbYsGCm/Y9jVMtXTGJk2fXZKfXEU7Fbl2bDna1V/QoFNMKpxi17hqk3oOqg9ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNIQiWcDVpFfYjNUguySo3YYGqIsqgDpYat9ifYXP0HcjTE9z
	Jjpks2ENU7D7SxyYIOQC4slLofCuiJMt1XZ9lObGpKca4ADuRG7LAebb0V47jew=
X-Google-Smtp-Source: AGHT+IGn8hflKpoueeCF8Bfpe5DVo3zhQbZebM4N8tBs0x45FvRc0cwkNA0yiljQQ0ZAfVnKIyBHZg==
X-Received: by 2002:a17:902:fc4f:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-20fb89650ffmr77091225ad.15.1729847743607;
        Fri, 25 Oct 2024 02:15:43 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02ee43sm5946325ad.214.2024.10.25.02.15.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Oct 2024 02:15:43 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor@kernel.org,
	cleger@rivosinc.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	samuel.holland@sifive.com,
	andybnac@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] RISC-V: Enable Zicbom in usermode
Date: Fri, 25 Oct 2024 17:15:27 +0800
Message-Id: <20241025091527.57825-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like Zicboz, by enabling the corresponding bits of senvcfg,
the instructions cbo.clean, cbo.flush, and cbo.inval can be
executed normally in user mode.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1992ea64786e..bc850518ab41 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
 void __init riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
-		current->thread.envcfg |= ENVCFG_CBZE;
+		current->thread.envcfg |= ENVCFG_CBIE | ENVCFG_CBCFE | ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
 }
-- 
2.39.2


