Return-Path: <linux-kernel+bounces-219077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393A90C99D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43A41C21539
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E414E2DF;
	Tue, 18 Jun 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EWExldOW"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81C13A410
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707092; cv=none; b=cOI5BDOac3s7O28u3U0eee90QTbEjLUzHa2cziSBzDJZZazvEKaLOvJp6IJlerg/v4ydEOqaLZEozb+tU5w6LpP9PJyCRDCWjsJlhaetGzi9wEnaK9vtFMa3Se7ZucXvrSFv/gROOyRJ/nJWoqlkkkelqERom9eexxgG8sVAn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707092; c=relaxed/simple;
	bh=rDC8IOSBsEF47eknnh++CAvoM08YFYdbqau0AY8SWdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S+kA1JilJvCX9fdbA0O65KUI27QHY+xo/uK2NemEl7L1hb9R/sd4DPmktGG0AT1HK3fDST7879JuIp0mVXj9tIE33si/aLmqUoQMkU8sONS8mYNwh+BPQtx2N7AAu3fc5dsuzrkDvS4pOSN7famX3xsi2/cMvZzqAaLq6OBWeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EWExldOW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70625e8860cso88313b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718707090; x=1719311890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=catoYdsWevgpEjlIZ+NShj85YA1mrFcOHb8JN6JQXXA=;
        b=EWExldOWI+YKDhVUTYadEtTPFyu9FVO9yaPzEMwTIRoCnhj5pNqAmrxbRtaOYzG/rX
         DOkCgJPba0j6Jt6GliPg2COXURDtXEfGawLBf4WuHh5A0EFu/1PBnXoUgW2JAklMxpgv
         40SXuepRqPNBhbtv8TMjkIQNYVF9LahxzktCKnb5tnF18+93nG9F3jdRnB67AKgZ2sP4
         ajCHQKNLTf5ZVAsloje3epNYpcopHA0O9ZbqnvmfCRT+RkK9aWkFrCyQB+roHMAv13tM
         8/hSr9P45Vh1ueU3LfTVyR7a7iubxz15nxgtkfI7Dqke+nUIeg3GObdE5gOOegWwbZqd
         q8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707090; x=1719311890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=catoYdsWevgpEjlIZ+NShj85YA1mrFcOHb8JN6JQXXA=;
        b=qwgjuT89/pswir1rEJXsx1txoBAEhVHLGs3/JQ06yuRGGd3WLpemJ2IpA7BYqpANu2
         JnvGVKysNwQU6QCSz43DHKRZdNDkSBtahGTEEkAQEPCSvS5j/Ym0VxHgz4t5/bSUivS8
         uiANzfn/kd1ztmaCDRXX3rRpB791EOfDqIugMqtsELv9LrIKRJ4gs/fLVGCiMhOgNY61
         VPdlF3U0L9iW7gMlTBZCPZtsuQkjmEpNbNoKMCE/qtJtYdhGT6uHP/sRBY7GONqrGaFm
         ycCSTqoQ+iK8OBHo7Ms//4TpZ7jWDuEv5ahre4xHvTiGRc/IqIiHxUVQumn6pQy6fwsa
         AJuw==
X-Forwarded-Encrypted: i=1; AJvYcCVK/yrWKQijFD+/hEv/+M5pvDzMjpiR0lvU48AZsS5CoSj676USojz5+gtOkjKGkdSc+Pl4I9umzmytibRs43GON1Xxmqeio30Y2Q1w
X-Gm-Message-State: AOJu0Yz/d+DyQ/0mXKMIrdYaszp/Y0Ldl6uEMa6rLNEdSXoZbdJuWmTd
	NkNbixQTdF2r2Qi1j0XSvMjYEv4AeirQdxUNXdEtSX89hqTJqONNuhZ9yNNGnUY=
X-Google-Smtp-Source: AGHT+IHf+BZuoVA2Xpv7qf8brMwvsr1IjVgs7uVQL0X7eDnkfLxqGefrMgAitNCtb2bohl/3B7BEAw==
X-Received: by 2002:a05:6a20:daa8:b0:1b8:622a:cf7b with SMTP id adf61e73a8af0-1bae80222f8mr14219877637.44.1718707089932;
        Tue, 18 Jun 2024 03:38:09 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9a23ee04esm3375205ad.258.2024.06.18.03.38.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 03:38:09 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: alex@ghiti.fr,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] riscv: Fix local irq restore when flags indicates irq disabled
Date: Tue, 18 Jun 2024 18:38:03 +0800
Message-Id: <20240618103803.40578-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When arch_local_irq_restore() is called with flags indicating irqs
disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
implementation based on csr_set() function only sets SR_IE bit of
CSR_STATUS when SR_IE bit of flags is high and does nothing when
SR_IE bit of flags is low.

This commit supplies csr clear operation when calling irq restore
function with flags indicating irq disabled.

Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 6fd8cbfcfcc7..f3aad7bfadb7 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -48,7 +48,10 @@ static inline int arch_irqs_disabled(void)
 /* set interrupt enabled status */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
-- 
2.20.1


