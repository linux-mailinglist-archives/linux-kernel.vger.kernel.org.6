Return-Path: <linux-kernel+bounces-265948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A284993F80D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54791C2034E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CF190675;
	Mon, 29 Jul 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TXHKdDQ4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AA15EFA0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263017; cv=none; b=pXNJbFgzn/rId/hIB5cAN4sM4zJhuHwFFP2nENh5D4esHzJXPGuK1TgHS9sXk1fZ4b2+5xtxioHCksLP2kND7GMyoSB5xkW7JOFYc7cJwXQo3xR6yXvIyj0H9HkspY8oId59C79HF16kRAvI7LOdZNKKoKNN6Ce+sVUPEwpH/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263017; c=relaxed/simple;
	bh=qJRebCqrm7pwIO+IpT+0VoIBqHNcWGYUdekFfnvXGMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlL+VnF2bjmkoxc0IMB80NB7XeetApUYHWQOZroY5sCkBtc8WfaSKwLn3MvPqyzG7m46opHzdgd5E0ugIkAK4IaBk/glGVgzJX2i5NorKa+epczB8tzW+x62HUM/VtirTZ/5c1P3W+MXlU4TZSStBACj5gd2eGZoA4gfDVcPbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TXHKdDQ4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc6ee64512so19632405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263015; x=1722867815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6K3rvuzx+kcxCA/RkAijYB8PiaVxGHgknWl7+W2h8I=;
        b=TXHKdDQ4xIAxUmFpLGgGpg6RiblaD4O+4pxC6YxCVCqCBZSjyQAJHBO+Mn1Y0Ug2lR
         lOCvFgDJ/SKX/IizXJkfW9Pt3lstAwvxjGsZ/Fd+gNw2WQhFqRN4XNPTeQSTmvs2dUT+
         2aK9IFObYKe2Vg/Stk57hfWoop6m/ScE/3OPjjUDbMdrQRybEFTuTUNxQmqRXf8+UjD8
         xeNJQvhyidWRZqbZk+1B655x+RZZCbs75EZpCiEvZnqSkUZz+qmQ8ipiVYr0gGz428aq
         Fw8HDIK/2nVJbtp9nrXrbBYbs2VrK3KVAljS+j+Je5A9pSMIpiuaqqPcA2oGVV4vHYuW
         JUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263015; x=1722867815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6K3rvuzx+kcxCA/RkAijYB8PiaVxGHgknWl7+W2h8I=;
        b=G43JHQulc3G1hWcB/nzY7h4qx88anDUd7w46lEFERcLqe/kZtkTRCMPUWJ518fVTWo
         2SRmBUflJ/wEA1JpaBBkNfwiGw4bFrwnLIjry6bhU3nNKnAxaxzrVq0qLlLs2rDLZK29
         dfqVlzrGcwcNX5rhhU67ufMMvtuaMegKqvvMhd+PvhflCCK9VaWeO4/lWGPN+hp6AagG
         nVfO442Ur+QFcEtpMKKkylz5bUyhNDAiOS3dLhV2ai1WyleakxY6XKoxX+kpj3kLTiJP
         Wr55OTlLzqj1f9QlBBe0UaTpFMWwJbB8ADJJ839K4SwXjnp9xXeGKArVg1Om4OQBnmvx
         dYhA==
X-Gm-Message-State: AOJu0YzPSlqvCuptdNT2+2JGeKZs+lpXxHaXVcR+Sjdc2SlPcZJdb5kc
	fJvLr2RyuzSk4ONYDnhzLjSQFkB07aoXKO3I2ImPbHELSapvzoxl6KLtavTzCYh9AOtsAFUPfYI
	MO2Fb7g==
X-Google-Smtp-Source: AGHT+IHuqnyr1wGz5leAhutHIAJO97R4WBnGGYBJopHkXMNgwgilRpOmng0OCq0p9dkCz8Wkxaglow==
X-Received: by 2002:a17:903:8d0:b0:1fd:9105:7dd3 with SMTP id d9443c01a7336-1ff049711f5mr56820415ad.64.1722263014706;
        Mon, 29 Jul 2024 07:23:34 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:34 -0700 (PDT)
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
Subject: [PATCH v7 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Mon, 29 Jul 2024 19:52:29 +0530
Message-ID: <20240729142241.733357-8-sunilvl@ventanamicro.com>
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

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 48d277657203..16917dc3ad60 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1203,6 +1203,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 892025d873f0..3a21f1cf126f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.43.0


