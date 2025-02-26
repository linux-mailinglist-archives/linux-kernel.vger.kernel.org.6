Return-Path: <linux-kernel+bounces-533091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831EDA455A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AD13A7902
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D62686AA;
	Wed, 26 Feb 2025 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I9sdic8D"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DD16C854
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551548; cv=none; b=kqfca+CvgOlSXPoJS33Hey2iWrCwhMolxPTZLK8LuPBv0z9TvNe+z4W4fzXBdXXi8mdxYsSeojrGcX0QUg/H9ELo6m8Gq9a52Qa3B0YKsKfUX3+/FJ9loEqytV6tzq3jZP++2jPNFxVLekvjEgUVvzJrzKuQDF7Im7YwjTSz0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551548; c=relaxed/simple;
	bh=6A+KzqvEXADqQRFxfflnjdJnKHnamJmScDSK6m9touM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVNVgfSVDUxe8OA0oZdy+n8uA98IvY/uQAx5EPWhOtQZn9en/mwRPkxEz7bF+R2PGVfrhESfuLY74cjBo665Gt/mHei+Ddegt1hnCtmxzkaqM6HirLpOhDUSbA0qP8RIHXAzqS1rNuFeDeIp1MD0JXwSA3wDco4bRIDV9zmAZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I9sdic8D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e6028214so140354435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740551546; x=1741156346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLyDt49U/qvQrnUcu83brJz3XFH8EzOsk0B+VADLLKM=;
        b=I9sdic8DvQaA+ur5tIZjSHBAtWVFMY0lJrbu2EEGMxGkgrG7J6EtEK+N6GU4SV52+r
         Q4Ce7jP/Utk5l1Bpfagyc1W9/GAfL0k4nmnY9kRiVrm8NIuj4khH9ygZO3BnzSNKSzp/
         EESJ7bwGDgz8yFihIUfjn6Ok0mJjtHf463yH30n4cdP0C5nbwZMtNULyB4ZXzgbEMs4S
         /QZsqfCEvGKp8J4+k3ulw01qenQ9sdbSbU0YqqieXZ07ozMOzD/AqFNJKnqI03Cvy45O
         Sfr9FWPomBecz51A7KIxJNtoxDOFiS9ZQP0gjhglW+Wx2q0rV6o363f0DSf/F3UCWfqe
         k13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551546; x=1741156346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLyDt49U/qvQrnUcu83brJz3XFH8EzOsk0B+VADLLKM=;
        b=H10w5//bVE/VuuPpT3jxWOvydQ5U09mrxytnE4uTc19INg+FmBgllHs2ayQHOTNjdU
         lRmL7lcUn3/lRLog6DqO3r27f8jhdppB/6SHApjY3/26D/gLaRTG2VT1IKwgDK2v4S38
         6XxaP/Oq3BkdcDS9dP6qqQeZcGrIgRc+aCq/zDx0YCOt0rX4sNXD2Q4OZkktW6E3c6tT
         fdWcT2WBwMpcewhTSmlj/eSBbJsbe1Lu4LX9+UKWxn1ZyddlsnkYjny3SpvG27o1eUd1
         uTZSpu7alNZ0iXiDNAb7jooEaf1cDoHo5P4u4wC/8Y5Oja1Q7AbMzIKDNBacyBpq8JyC
         naEA==
X-Forwarded-Encrypted: i=1; AJvYcCXFqGZycxQg9HxXSy6+pGTmy6Vdc12k0IujbdBtwW7meyk+ot08k5IOZbpQ7edhNFBKU3cguSg39iWZXxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfPoL+TuqzcZrC4FP8CdAX1Ot5cmkzpN8HbGxVeidMGSaIxI4
	Jhp5X9CYHWpADFSyXPRmY8aqE6gMGuoI9d+nF4HrME9ZYANx+xQlF3xjUnrYu2M=
X-Gm-Gg: ASbGncv3XLJDKTykyG+8ZrQNrJmjpseY7zULIzdB/0jaB6FbpA041zfMYyf8jAobggM
	4x1nSOVeBVerGXcR2L86ZkuP1ssbd1Tn+ouL9959NOPPwnaUKckyEKJwjYVQfYkuQhS12hdIyiP
	JMrwSPzhOQVqcCzgGlnCPrguR5o7Fh/mWgqx2PtLW0PAL2pgqhY2uRZrslEC46QctUDRElYw9a2
	ausugFME0wGhaw1MGaRSfmkl0t9QHk56cVjoficv2c7rCpyf/I6UCC4SACH+02jGsNLZZdAxlZu
	iwhkDwka16aOtzAmQE4MG+G+HUW8sbRPZLBTbhtxp0ElYJd5C6JUlPQONU14
X-Google-Smtp-Source: AGHT+IFFs8SZ5lPd2kWTT1U7ETWzPeSTog8WGxZry4kav5NnRHKIbt7T9I/ZeIxsd70AumwEzTSVFg==
X-Received: by 2002:a17:902:d48d:b0:21f:136a:a374 with SMTP id d9443c01a7336-221a0025a63mr347304555ad.43.1740551546420;
        Tue, 25 Feb 2025 22:32:26 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f152sm682599a91.46.2025.02.25.22.32.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 22:32:26 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v7 1/3] RISC-V: Enable cbo.clean/flush in usermode
Date: Wed, 26 Feb 2025 14:32:04 +0800
Message-Id: <20250226063206.71216-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250226063206.71216-1-cuiyunhui@bytedance.com>
References: <20250226063206.71216-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling cbo.clean and cbo.flush in user mode makes it more
convenient to manage the cache state and achieve better performance.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cpufeature.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 40ac72e407b6..a8b726d0dab8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -32,6 +32,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicbom;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -91,6 +92,8 @@ static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+
+	any_cpu_has_zicbom = true;
 	return 0;
 }
 
@@ -1001,6 +1004,11 @@ void __init riscv_user_isa_enable(void)
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOM))
+		current->thread.envcfg |= ENVCFG_CBCFE;
+	else if (any_cpu_has_zicbom)
+		pr_warn("Zicbom disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.39.2


