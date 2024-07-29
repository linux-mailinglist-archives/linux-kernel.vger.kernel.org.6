Return-Path: <linux-kernel+bounces-265946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794E93F808
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E011282D76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6315E5CD;
	Mon, 29 Jul 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FEE6VnZ4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC80154449
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263005; cv=none; b=Ik/49yeLtmDrZNeHaAGfF0BMvZg71kTOMHWIp1GTKnysKQBa6IIbH+w/Kp6rSr2EPOJiI2ImlkpmZ6HxmJRRQnSu/j8EEDBQ/ek3VrqBNTN5h06qgCtoK8CEvtxnl6tm5zlhwKzhf5IUKV9vGwEt0X83rxC4WDIhleYsht9r6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263005; c=relaxed/simple;
	bh=YbAVdkDhATK17JF+AivZDXdHFeXfvAlpUUxX6dv05dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH+ittE7xITS3Nal6tkKDr340vjML62gAK1h38DeQGLpOo2FM+INoiYZHj1hL8oxNvFce6smu0lWWz/dNniOSYl4X4bIkznvxrQqn2SbnxCUI+Tl9D3JuzQZskAB3ZOX0p4Uua9vr6K1v4rLCsniwMIZ4tc5726fjU+PNjoc/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FEE6VnZ4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd70ba6a15so19916025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263003; x=1722867803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKYwRAs6GZjX8rwxqPz6RZqcRKMFxP3sTbkHp6BG6OY=;
        b=FEE6VnZ4rAL+FkT7LSCfu0VHTGypLrQRDKjJwUX1tZ+fEINSmBB/lB7f2P2tqaen9F
         OF0X1WlEYqu3t5Tcx0chszc0kT+xmjOZZZ/razbB/zuiCmxDWa7kIZU823mGokl0EOWx
         s62dYK4m/mrfbzAy4NpnbVFGQ9VbULe+RQ4dUqWQBeOCWiDCFMl4nXu4AW/xJGbgWr4L
         nY40g1F1WuTJAuje+DHa0TTvP9ZhwfTfvUkKbdnPNWiPWJ+5QOclo7LNRFZlpiogd2/f
         IwTQHqtTkbe2V4e3uNxJhWUHETlTKFRIAoI8Yr3slUQg7ckmvJOffNQeOwgJrp/Hitwi
         QKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263003; x=1722867803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKYwRAs6GZjX8rwxqPz6RZqcRKMFxP3sTbkHp6BG6OY=;
        b=ZDKmFm4tFyEFKRmVUpij5lB6Ml7p24f8g2b97tRyfQL4xeZp2q0hk2PJG+lBx/9SJO
         wcHvRTisfRA25rdZm6HpOt/fvOiXOkhLNbItNQk2CH+1hJYpQL0UTS0a7/r15xS1FyOc
         VazHQh3O5yiYEPAfUL18AsgbB04oZVvlkNxMBBHX0ZemJTs6YeJ4Uf1xRuxkAzZ39wJY
         U3+nwnuTh20AxwfAp/oV5eapAHXjxBji8jxuCXrnWNKtlSnYmS+Z8RUpf36lnvF5/pxR
         Dy9FeviA+x/zSTCILb0zgLvkODqYc5PlJkqLwMvecQ9sAGQt6hZU1t1KoY0KEWh/okgj
         +SNw==
X-Gm-Message-State: AOJu0Ywx365zPfUpUAyW6BlDtsqY/KX7/uYCQqBBE+3zsrO1g8zYLISO
	a5WX+ax6WjiiISXGnMTeDmnH1jCJ9oJYhWnQjNEJlv9WiC4WvLzUVhdGpZVexQQNq5i76jM/jBI
	/a7z6vw==
X-Google-Smtp-Source: AGHT+IHlmBVDHSe6PUvNsr600YNWcBMY907Dx80p++dt4s49fUoZ70tkMwcDAnmuTUCJtN3oxZs+cQ==
X-Received: by 2002:a17:903:191:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-1ff048e1db3mr52120535ad.41.1722263003482;
        Mon, 29 Jul 2024 07:23:23 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Mon, 29 Jul 2024 19:52:27 +0530
Message-ID: <20240729142241.733357-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 374cae4aef78..39b3ccae9f79 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -861,6 +861,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.43.0


