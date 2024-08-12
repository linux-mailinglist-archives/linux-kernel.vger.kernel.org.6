Return-Path: <linux-kernel+bounces-282453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E112394E450
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E321C21136
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BFF9EB;
	Mon, 12 Aug 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J+GnryFQ"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D51CD24
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424428; cv=none; b=ndl4trQB5jkd4S/bgqg8hL/oyN7jXUQ/9xo5xILvRUmv5cq1wEua92TB2HcAUNqxm22ncvsU3yaEkKWaV9h25S7Vf8e7H/fq/qmJswU6NuNz2MoKPMq+5sDkLIi7LXa21VCLhCkcunKWj9TPAWvQ7b040lmN2z8my0W1U1f1zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424428; c=relaxed/simple;
	bh=8EwPwWa3yJI98774dHhpFkxvDEk2uSVsbNpCxj1n9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3wJXk8QCVRvlvcKIxEz7l/UGN2+h+1EdKbz8llaVW1As1CEP/TeDCCUCoSGYXHYrEfu+atCG6pjD5Y/Nmyr4c5Tx06SKTZwo8A/KIKEcbS3PEaXdG93blM6QWnlGM7QALK++6lYYVM9fL2InGcpP/wXnoUvedKyO9QK7Umczno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J+GnryFQ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81fd925287eso150017539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424426; x=1724029226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBzMby0USGxgSPaQIBT4AQA8EH7Ak7bVCmTWfoSfRt4=;
        b=J+GnryFQ7i9JXCza3j1/+/bvPi+QD4mssQVagEriBiMRPEKEU0BGTlXYtKSzTN+2+V
         HzF4Ip+IWmL43dOZND1PzFdVypHXNSXfSAQT7xRlLZS3BPECFD+rXQ4zWqm6Wx6tceYg
         6H6oS7JKDyVC4Z1cqg1C9OeoX+33SjyZs4kasH0IDl1eaEdpgWmAP8Q8MeDRwUyBX+Vx
         xi7h0STdfH1rVHQDcvFZUfWMqX0KfdTuzd3IlSg/11xynRM5XdAnBI80muzuWmoOS2LW
         I1wf6pbGGqUuiiRnaZOvFP7RMoi3kVkIZVBB/dwwclwKVYXdAeWN9rKfuPokDif0cGYc
         tlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424426; x=1724029226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBzMby0USGxgSPaQIBT4AQA8EH7Ak7bVCmTWfoSfRt4=;
        b=m/cm25mQpYdNx8wLH9Rv9KW8kn18n0HTF0xsn2vrpLAkt2b85f+jcGHDbthP1q8XPL
         2XdWRP0Ayigp4SmFROUTCFfa9T5qvjbxRz8a2z4a3qQf+Z5Y8vci5SbjfGyPtkifolbJ
         yhbSYJXOgcWRydXGPEoE5HYfqAiq3haoKFcM3u/y5AisvjAflGapQHFKn/ydYmtTLKLN
         am2II78EiMP/MpZ+k3Tg9HJpIQVFRqnantNIPUQ3LJjpy8j2Qut5BDx2446Ku0T+5t3N
         zVQL/6IvDERX05fVm3W5ASKKW5xOps6ayBA9ri2hC0613XXcmCkIKPeXeeE8qNbNbMMK
         qPig==
X-Gm-Message-State: AOJu0Yzqw2dRokJxDf21BoH7roOZdBOgNmt33H71glgEWCoD5C9HYEnq
	h4Tu1UM2J6X9t6HHC9eqzFfN2kMu0bq22LZfe6HINBcaIcjyd0eIn0eoOxCWg1nDi03I85fIdRh
	ZKn4cOg==
X-Google-Smtp-Source: AGHT+IGLgGjZy1f4lXkyD9IeGxkMxZC7bl0GKZ86dlIJhEZNBpnAOTW5ak8/coJIxlUXH7m3lfD9qw==
X-Received: by 2002:a05:6e02:20c9:b0:39a:ea4c:8c26 with SMTP id e9e14a558f8ab-39b7a475a0amr105191515ab.1.1723424424986;
        Sun, 11 Aug 2024 18:00:24 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:24 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Mon, 12 Aug 2024 06:29:19 +0530
Message-ID: <20240812005929.113499-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
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


