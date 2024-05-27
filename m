Return-Path: <linux-kernel+bounces-190197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A68CFB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5141F2108E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036C3BBE5;
	Mon, 27 May 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KBksRvJj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374B3A1B6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797482; cv=none; b=kgku0gD9RxC2i5NfU0ceEPC/gap5+BHevu1ff8ut5rmGVvVIci+7ozdmPaJQYTsIe6XeVlS+gj2Y14PpAVyzOVRgMoCC7Log1t7TZe5WSP8RtB0pgbR794HWV2sbwU4axRqMj5bY6p+mYZXVI8iSITXllrzNV5LJGWaxCBCD+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797482; c=relaxed/simple;
	bh=l1SZqiOisOw3QrYdnCdq5AhVJ2t+mqdxeJrMhhh+k/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+m/dpcCn/KYHkjzCoeUEN+0jN5oes5HdAl5Bf/68G1WR2zy9JV4x7T8lC6swS0IQF4pTBT64MR0pkvg4ou9yPwtzi4yA62AdOP1pRfZEhW2X3xjRmSOKcjDuHUUDLe66WAIM+IVbHwY4xem+6Za2B8kTSLFMHCCGqQnbROtv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KBksRvJj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b5d0c50so18909335ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716797480; x=1717402280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShhWOlbRbljYcCB82u9Yc+j3xNaMQh3hMlbDkH2dDLw=;
        b=KBksRvJjqlYv5wRKBZ9f94NElATPNNUFZ2r8buDTaUbcJJFfPKGWUCKvKpG40lAe/d
         3adOfqYu88MRNla8Ml6fp8keGglV4phpelljtACXxVK73m723At0wl0AvunrAhc8FyK7
         fGeaoLzsAx4iVYNwrSAdCpSj9EcUm0bmeiDAcsc6m3vcHGPXYrYRfI2Aex1GbBroyNP7
         dljLOgpuk0LGEInr9QLEM/mRz+ZXPe97qa7I//T2j3e2nmrD9FcHdOgnEFT7Jv8XeR3u
         8TqK1tStuNSNuZWQyyD+M915h/1c0jnrP2cjusNG9qj8kFhAwXKt1l+ru5M3+EJ183nC
         6r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797480; x=1717402280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShhWOlbRbljYcCB82u9Yc+j3xNaMQh3hMlbDkH2dDLw=;
        b=Wqm66mx9xtUYQ+Imb62HOo9u+l2DBfOniLThfWgGIRVzzrhArTEgMcj1lDi0LhzZvI
         ofGTc1Jo0IPv3Lp7OlkcF7A+I+0mkMkq25CgcduT/TWD3J7iNgSz/CoXQ0trA+U8tLOx
         LwhHLjdhcOvh0RjVZRSzFOAT32nwN2vXaw0hnOV+bZqanUb0UsStfo3xe34E+EKrBqIS
         7//xLNl0iDCbFPpEUzz1zeArGDdEynvS1f03jYA/7i+Bkdd2LUmhsnHDgKahOR9Fpgy4
         NpU194IWVFSGuXC7wD0ex3r+4dAztURpwwmN5TIetS8EwwjVMbgkICRpjyZ8+OqTd9gL
         UwlA==
X-Forwarded-Encrypted: i=1; AJvYcCVFU9Fr+W74aC2cy2iYhdlLAxrhRN3gLzk9YtiCcj8Yaal3B8sGGGIU5ghfWLGJrsE5o8lBs22M52QPJZe5mwAkhCtKn8cVxXdeMDjO
X-Gm-Message-State: AOJu0YysIFs+meeXidlwkMAnjHRE3M6NoF4BtPxinbhSRh1qlDaSay/p
	SwlMhwDRqKUBsKjmKp1Zh2ZigM87B/n+1LOsSvA7Si88elGfl91t8vwGg3MZIpo=
X-Google-Smtp-Source: AGHT+IF3Dwp8qVbt9gAvWo9YG6a7jqOmzBDgGznW3uIcuYTMmMrN58KhaZ3iwOrfO3nFDaUzBRrQ9A==
X-Received: by 2002:a17:902:c401:b0:1f2:f954:d6a3 with SMTP id d9443c01a7336-1f4486d1cb5mr96471525ad.5.1716797480025;
        Mon, 27 May 2024 01:11:20 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7c59e0sm55078605ad.103.2024.05.27.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:11:19 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] irqchip/riscv-intc: Fix memory leak when riscv_intc_init_common() fails
Date: Mon, 27 May 2024 13:41:13 +0530
Message-Id: <20240527081113.616189-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When riscv_intc_init_common() fails, the firmware node allocated is not
freed. Fix this memory leak.

Fixes: 7023b9d83f03 ("irqchip/riscv-intc: Add ACPI support")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 9e71c4428814..4f3a12383a1e 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -253,8 +253,9 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
-	struct fwnode_handle *fn;
 	struct acpi_madt_rintc *rintc;
+	struct fwnode_handle *fn;
+	int rc;
 
 	rintc = (struct acpi_madt_rintc *)header;
 
@@ -273,7 +274,11 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn, &riscv_intc_chip);
+	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
+	if (rc)
+		irq_domain_free_fwnode(fn);
+
+	return rc;
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
-- 
2.40.1


