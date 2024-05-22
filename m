Return-Path: <linux-kernel+bounces-186631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1128CC69E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B67AB2162B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89435146013;
	Wed, 22 May 2024 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DNbBbZK2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92F1BF2A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404168; cv=none; b=bx1ue7ztAKSrAVbPzxU0Ah/21qK1UAQgETg9Jm5BdxU/bgMcK486xfbl626O6RoDhas2iBAjItyJtwHLc1NgG5fPCTRpF7WwHw1eKrqbEVYuluxGFJbUYvtPWpqOgwim4NKVFmRp3qgnVk7tRIuabhye91A29g9Nrzs9TVZ78NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404168; c=relaxed/simple;
	bh=xSNNEFl/Or2oWrm6xKX/wFgWrfyMQSIVuBPLnP2I2FY=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=Yatdi8TQLRLIjl/qZyeS0JpsCWgSbtSX4yv6eHXoxIGn0qf63uF5KVdQ7ofjPceUQ0MLsiG/uRyRN+RrGRfNF5Q6aBd3s1cHlR8oYJn8QjrKekSckEvXgd2//IjppxR8fndsrR4dOFp6g751ZcaDLFjtJx/vlFxWuFcUiGqHoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DNbBbZK2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso1416972a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716404165; x=1717008965; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=dnzy+P27CG9g1SjT29AHyztBT8s8Vr6GnIB5bhcdo10=;
        b=DNbBbZK2fAtW/apXXzUe8erLqW49i2mF9hILN2Lw4ZI7QzhLVnXz7yhy4/IL+kgA0A
         CTyplxgsnnIugM6frU4+cKo1ZKBUVURg1z+4IDmZcNFfcldagqfDZhVKMh7ZllS7LEgl
         oYt6ZD+GnejFctU4gaXJNWP3CCiqGQI2UsNPd2Iq+GElpRtxNmjcWrYm7L5cOpwZKBAK
         uJlwgVHdL88dLnLVklZHx8zs+EKpzv7hAbQz6GpfMtnu9udj7AvxFNokh+OkLRHSY52A
         xXMxv57Ro4YMVyvz2sH/EBoA/X16e7Pj4vAIuJ+vC20zkVAMABOv5WTjFQNMPLEdbnr+
         XYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716404165; x=1717008965;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnzy+P27CG9g1SjT29AHyztBT8s8Vr6GnIB5bhcdo10=;
        b=M9CCYGjc4J/3L0VWiruAbqV5Zx9NeESW7RKd5B0VZaoIqKh8sTSY4ffyR7UnoxOoOl
         wqg1mj5tKjS/A+iyctOcxEyWc1y1M8+DraIphZk0ntT0LcPZ4GTP6is+113++ICbBs9e
         cuyuTSNT4yr+vHeaj8Dpsgt8OKZzW5U3nCox6p702eAeD6MavziwBIv9R5k0jxuyQQ2n
         8jnH/jqUt4dBPUXNfgy6wBVm7BSoV57PwZMycpogTWqRDAz1R9hB6lCNobFbO12P4UVN
         u37B5LcMu5wIuM46pk7AqwbxDcTVCoDeiTffbYWquyuIhIm/Mf5YkN4D1zQyzPjelFuE
         0dFg==
X-Forwarded-Encrypted: i=1; AJvYcCWEe1o0rqortM6DqdFyeQNPdAlFl5EwOGWfuS6pbtYVSzJx9MUaVtEn7KrHvbNokXpssrV51hukvECmPSYY0k41AQ1Qh8aDMUVmI2co
X-Gm-Message-State: AOJu0YzM6EVqzI1D9D3ZWzylGLSEMfYQWQBCGCs5jhZe6HW9E0CGrSU4
	jazzOlB0aapY2chjjNmGA+C0lFZko3i3UxduJg+t/RLmI9fFJk2gkTsAQc/mcck=
X-Google-Smtp-Source: AGHT+IGu2YOuF8nlRehcHho+rj9d+wag8HDJWVH5TjU1gb3maLVKxYpE3+bvJ1t/Oj/1dk5a004niQ==
X-Received: by 2002:a17:90a:4315:b0:2bd:4759:46dd with SMTP id 98e67ed59e1d1-2bd9f59ec18mr3032141a91.37.1716404165448;
        Wed, 22 May 2024 11:56:05 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ed3812sm115120a91.11.2024.05.22.11.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:56:04 -0700 (PDT)
Subject: [PATCH] irqchip: riscv-imsic: Fixup riscv_ipi_set_virq_range() conflict
Date: Wed, 22 May 2024 11:49:55 -0700
Message-ID: <20240522184953.28531-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: anup@brainfault.org, tglx@linutronix.de,
  Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
  Tomasz Jeznach <tjeznach@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: tglx@linutronix.de

From: Palmer Dabbelt <palmer@rivosinc.com>

There was a semantic conflict between 21a8f8a0eb35 ("irqchip: Add RISC-V
incoming MSI controller early driver") and dc892fb44322 ("riscv: Use
IPIs for remote cache/TLB flushes by default") due to an API change.
This manifests as a build failure post-merge.

Reported-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Link: https://lore.kernel.org/all/mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9/
Fixes: 0bfbc914d943 ("Merge tag 'riscv-for-linus-6.10-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Sorry I wasn't clear about this one, but looks like it got dropped as
part of the merge.  I'm happy to pick this up via the RISC-V tree if
folks want, but I'll keep it stashed off to the side for now as it's
just touching irqchip.  I'm planning on sending some more stuff on
Friday morning, so just LMK.
---
 drivers/irqchip/irq-riscv-imsic-early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 886418ec06cb..4fbb37074d29 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
 		return virq < 0 ? virq : -ENOMEM;
 
 	/* Set vIRQ range */
-	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
+	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
 
 	/* Announce that IMSIC is providing IPIs */
 	pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_IPI_ID);
-- 
2.45.0


