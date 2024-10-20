Return-Path: <linux-kernel+bounces-373422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8A9A567A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D6B282270
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B244199EA8;
	Sun, 20 Oct 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I5pCJdqA"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB772199395
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453677; cv=none; b=GUF0HakWSQ4Xi7FvsovDoIaEop1vKl3vjBcJdV6k4UdgLjjCiCdVWXCy8yWezfGQgtJ8oEEgW+FW2aCVHB6JV8EclQzPU/YUXW2/bno+mWMmBMmJDf/tmBFSDuUyl8Jt9HNHNrZpTzmTnHDHeJbCyeJL+UT2OoGhftyym97I4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453677; c=relaxed/simple;
	bh=XeJ4zURiPtRwRC7wqRQygMzynUWW7n969d9Luma7yik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6QmAeMp11CfxTzKdH9RJTFzGhMsY952ApoiubCdTLPCgz9tKPZF5oSx6Eu3Wr7TAk1k25urjh3N1lWCQUC27JCHLYsMDBX+06Ym6oNlHim2/8AmGq2jJg3XAhWltNEwAjkVkeTCtn5VI3MDm8jUkBfin+9DaxficghFo3ydJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=I5pCJdqA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so2778174a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729453675; x=1730058475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=160oEn3Hw+w/iZ7EFhTc6TJAcZCL3iOZo0psz4xgbB0=;
        b=I5pCJdqAd2b3aGVebqpW8FkbzPcHmpz8scO/8DjliVrbGRjkqHQyLuuwCez7Bqc3fX
         01XvBIRvpM+15C86Tmcb1zEPTwe0okn7z9kLjybEn9+w1atNqJC2NUK/98/BYm7qHfnl
         k+yZ/Ca+e7dfLMjVhefNOrKGJjGtrxlZiopZHjp4futM8yw2BfcRXmOlIRjHeKvnkVC+
         53IVyb9iLmg2m+vZndIwbO+0ygevLcZmu8Am7MCR35dnzxJ61N1vB2XRQ2zSK0x10y4b
         HIyrBaM7lth8dW3+sLwqPbr1L6pOTaS04Jj34upU6aoOn8kFTsDrTDGPhdqGhnNSGCn+
         pBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453675; x=1730058475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=160oEn3Hw+w/iZ7EFhTc6TJAcZCL3iOZo0psz4xgbB0=;
        b=w01yuEs8Zg1TbYr6NSw/5Uef3Uj51ccIoy+XSRmSVWA+FW7CkDROI7X/xwGvJI5V7N
         6ACq8rdN6SiMyUpJtMFSIYbgFd+FGAUdm0uTJk54QnC3o/EO3WWWaHV2kC8FfH7P5yFS
         B44CHkN3/rRBmHKSVfx7olZUVoF4voR2Ru00BXKXYBymWzlFrMaCBAazLUHr0SFu/Y6i
         T7QIQvYB6p7GZiWGIQPlTs0182N9H5Bn3RMifWTZssI/zwZrDgVmOUlrjcei/ey1v23g
         D+s95UmgqM4XXhgF2NFVDoqG9bY7oqbdlMlsZDzznrcpz6+7++rpH4lPWyaT5bo+psHP
         i72Q==
X-Forwarded-Encrypted: i=1; AJvYcCXR59MYeFXSeCAnB9vAhsxtPTndJg7MM3LkN9Sdr0ub6XDkJliatsFIfLfBVfcjD8Zg+Ptf6BU3uZO+VI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZAfFYuG5+TFdQGL+R734JVozcORQ9aUcwZN3ufPSrKkJKmVY
	KYRIIxYDtHgyJPz7LUHHFYGUASVQzxpttunHDEGrudFUjuGzeEJ/aToKkmo5pEw=
X-Google-Smtp-Source: AGHT+IFjSRTaADFfRKm/pM//eGuPDafKddIxjEZ6I/KXrnokbyilNV7LBvfBGmNKmpBhs1ancwD0CA==
X-Received: by 2002:a17:90a:ab0e:b0:2e0:74c9:ecf1 with SMTP id 98e67ed59e1d1-2e561718d7amr7870206a91.10.1729453674952;
        Sun, 20 Oct 2024 12:47:54 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([50.238.223.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d4dsm1933188a91.14.2024.10.20.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:47:54 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 06/13] RISC-V: KVM: Don't setup SGEI for zero guest external interrupts
Date: Mon, 21 Oct 2024 01:17:27 +0530
Message-ID: <20241020194734.58686-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020194734.58686-1-apatel@ventanamicro.com>
References: <20241020194734.58686-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to setup SGEI local interrupt when there are zero guest
external interrupts (i.e. zero HW IMSIC guest files).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/aia.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 17ae4a7c0e94..8ffae0330c89 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -499,6 +499,10 @@ static int aia_hgei_init(void)
 			hgctrl->free_bitmap = 0;
 	}
 
+	/* Skip SGEI interrupt setup for zero guest external interrupts */
+	if (!kvm_riscv_aia_nr_hgei)
+		goto skip_sgei_interrupt;
+
 	/* Find INTC irq domain */
 	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
 					  DOMAIN_BUS_ANY);
@@ -522,11 +526,16 @@ static int aia_hgei_init(void)
 		return rc;
 	}
 
+skip_sgei_interrupt:
 	return 0;
 }
 
 static void aia_hgei_exit(void)
 {
+	/* Do nothing for zero guest external interrupts */
+	if (!kvm_riscv_aia_nr_hgei)
+		return;
+
 	/* Free per-CPU SGEI interrupt */
 	free_percpu_irq(hgei_parent_irq, &aia_hgei);
 }
-- 
2.43.0


