Return-Path: <linux-kernel+bounces-525959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEAFA3F7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5434D17A185
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3E2116FB;
	Fri, 21 Feb 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gEAefyF9"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CE211267
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149845; cv=none; b=h3aa9tarMhOV/u+zAJ8v4XymawOrPrPelmDFvJkYbKEN4q+rruHFT7PMePWH7eSauA3Ndpl2ixW3JS1pFB297QHLmP+oabmDvfTZJadU4tQ19TKvma+XwkWKQGhu4+gqRsKtWsvd2RUa6Ary1RprzdIMtEyaASMk79loIyuQY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149845; c=relaxed/simple;
	bh=bKMa8fqW6fjvU7IC3trRLzO9pEfTAhYdgpAHUxI/OBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECvZjCKXl6+33QvCvSN8OIbjoB209Dmm8sH0cE0zruflqo+D4KlXMgsNCdtAuoysTb1rFRtNLnNZ6DBXejB/8pVdLP2MngLEhLfIzcz6/BmxUU8c1yfu5RlzxUIgXWBxemUhYWgSN4z+FmJl6il6L0Ef9XoOWJOpogbMjtsolOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gEAefyF9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f31f7731fso1114801f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149842; x=1740754642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoVXTPIMs1CQCffXwitKYw9GB5bSc15mRPYc+pFsBJQ=;
        b=gEAefyF9ybRBy0vSRxEfUdPpdzq8NJI9MxC4V48kN0MxACuhVmbYAQ2NHIMD//2ici
         dgluLXtO2kEhCEC35fPjV6Dbs0NM2a/w3NV2F8jInFKkk2HorxOoJa4xFDwmuCb2S6vl
         m6F7u9turCp0a1WGf2WfWDcxouCkJi+l1dGCWh88+Q9fpsVQziSHaf2gJk7d66+7cdD8
         Cc/wCR2n/jyMD+KxDWKSeKMZs0HcCzD1w0vXTSCHEgg1hMTnuKHInKSy/sQa2+ubJxfe
         6iGN2Tr0gDFDoAX2AHvo3nPadzdSdzuClZUfb74U4KNoWU9uiKLLg42cEQxz0whf3bsZ
         36Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149842; x=1740754642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoVXTPIMs1CQCffXwitKYw9GB5bSc15mRPYc+pFsBJQ=;
        b=K7EXybPeFZ8TBqYzfiTGrX3slKXYiVflGpDBPiv31EAUZEm6J3kboC3vQBfxHbcrXc
         rRYDcIDK0EgRVb72psCV4yx0DcYKKPtaSdhewxt6SN4LYqVUzUi+VCT7UEsjoZP6ZWG6
         +Dg2fX1q8J/H41resTVza7LPOT29xtfJ0Igruqiki+qBEsLNJWHTznjOC94BZB12ywRV
         4FLIgmPASIXbtMQ0828e7y5uWrKUNKcwwjTIinyPI2Zs8cu+aRyPrWyAu+e/ShRGL4Jq
         fKWjfUUigQn55nhh6K2MPjyOs7ljHY+yQgqZtbYPu5guyYWr9pkAEsOygs2STTHKvy/+
         Z8uA==
X-Forwarded-Encrypted: i=1; AJvYcCUlbnVkfQXMJtkR/iX+pY7xTsFafuRuNWUq21HuLP8BXUrTY03XWR+F+n9ptuICOUufraLe0a0XZrVG1jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQ9IvkbPykjW4rfi0u3cjR3jzFDGkbgoh9v3XZ4hKwfw2bWj0
	JOw/CzMZooJu2A3At0GeBWQqfnOZNYgsPtD4gf38+ZlmFjsG7gJL3m2M2eiL4VM=
X-Gm-Gg: ASbGnct6iDOThNlBSqZMFIqT6XMYRYwJeDbw5iqUrISbIwaF6dIQtJyG6JompYVRMVz
	jH3FcmWI+dCmruljGqVx2tZxBILzf4jfeAXzNHRCjA0aDwByuUVMmvqeav1eKkFjMrgVsRgsqkv
	+CiP3pod4/YZwEA/d4EWnsgFk31ncAE0P3KB4psEeNeoxwhDKspA6v/0r9rg/bNhpT/TCDThrWp
	3suYv15qZO8Y+3+4ZWW7WfJ+/tKRKRXlHnbTpx7K1dbB78ijQxiPBxpKptY7jJla9Hdn/iEfYvG
	7YkcWMx8t9kdPA==
X-Google-Smtp-Source: AGHT+IGLjeXtLMpaUfMeTJi1dFbDUAJnf03JHPPfMuqHzy+Icmy6f1wZrpg8Ii10se+UcAaYlTJT4w==
X-Received: by 2002:a5d:584b:0:b0:38f:3b41:c952 with SMTP id ffacd0b85a97d-38f6e754b82mr2673644f8f.4.1740149842284;
        Fri, 21 Feb 2025 06:57:22 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371c67sm19561065e9.34.2025.02.21.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:21 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 2/8] riscv: Fix riscv_online_cpu_vec
Date: Fri, 21 Feb 2025 15:57:21 +0100
Message-ID: <20250221145718.115076-12-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221145718.115076-10-ajones@ventanamicro.com>
References: <20250221145718.115076-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We shouldn't probe when we already know vector is unsupported and
we should probe when we see we don't yet know whether it's supported.
Furthermore, we should ensure we've set the access type to
unsupported when we don't have vector at all.

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index b7a8ff7ba6df..161964cf2abc 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -367,10 +367,12 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 
 static int riscv_online_cpu_vec(unsigned int cpu)
 {
-	if (!has_vector())
+	if (!has_vector()) {
+		per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
 		return 0;
+	}
 
-	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED)
+	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN)
 		return 0;
 
 	check_vector_unaligned_access_emulated(NULL);
-- 
2.48.1


