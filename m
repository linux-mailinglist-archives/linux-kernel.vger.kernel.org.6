Return-Path: <linux-kernel+bounces-363315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009D99C07F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACEEB2171B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106651459FD;
	Mon, 14 Oct 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AHJGElTf"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B09145346
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889069; cv=none; b=NKiwswUstin/18H1Dn0tT8RYWeGnCu75+ms9NIsK6W2z4/SA6W2mP1YLuPuAETMzfRs5x5/YHet/3/MyxvAVj1fHI3OFK2VlIK9yrPKK7fsSjssVWasE91v2nTGqLjm6rSz00XWMDO33R7tx9tyc7/0VVpoUPAlgxXkNVmtvHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889069; c=relaxed/simple;
	bh=zqZYEcWkDRyO+7URoPRw/6UaSjwM4b235ptlvpfVYd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDq8uR+FJQiw2iBWiO1yUbZHkJLeWZAMbLGvNBQwy+2auhrm+3hT//3erxQE7HsH+xYYHLiw3MhLPJYIAQadKn6GrDnJGiMxiOH4fvMTgOqHFVb6ygtr3sZdlY/XHraTsJ7XGC6YXr6Q5cSICipcUg2KpggM2azHIhjczKahpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AHJGElTf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2449623a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1728889067; x=1729493867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbc6XJjTsJcUlouhG07nINxP0CXcC/f2VOnFjv0x5Ns=;
        b=AHJGElTf8cJ24RYqRdrixcA9H6Uh+q9klCTzL8y3Bq5NVdB3qoOi6+1TpF7MJ0dE8v
         giQASqAihX2u104An/WQm/L4yUvDWdfMIagdh4c3IhhhS5KFI96maVNAT3hL5kkpxjl5
         Re/N/dYtCg8kXSUG9wqBTxTUjMhwUkEFYcHCszqjLBYFrNWoGkauvZ/0o/aa6dS7g1tK
         nzFbdMr6tB1jagrOvW127rtD95LEBU2hHBE2QaCh1K7vlmKMuw50u7p+DfG9U4V6TxSU
         ybySOAk+AGeKhaBOIuT1OXerxbD10I51xHe+yYNr7m3whZjBlC9C9fO9hw8CXldQegHk
         mSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889067; x=1729493867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rbc6XJjTsJcUlouhG07nINxP0CXcC/f2VOnFjv0x5Ns=;
        b=J/5uLos5v3Kcv+FMZrSvParKHB+lB5l3hTpqQlvC/337gDTTeweHOQFH95Yw2+4F4L
         ZIWzGtDy84CtQqlzSzjQ6acPQOdMGMRTwC7kPHPKNfTwk8ZiwccRra+9+eZRw3uIVIKN
         L0vziGBGlXnqBLT0NqllDihj4YGhdCfdmLiohOmemLiXuBzX8XdkCxQY01KLPgDHVjbv
         w0SxrcnyHLSzG7D+BwhyEZCsLep0RePSBqPH0myH/+Tcxhkj/Vtn6akPHtgIrS7oOuHy
         jUxTL8TEyBgM8p7UIRidFteKsWxM1WQ3h6yyyZ0Kk+ze9gclTeHVJn8sR64yEu6JGX8u
         VT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh2inKTAi2IX1fdQ1YRyyGDZHxtk6ldiizIKIgRoyqGh2/z7I/gt136t65K+Xo5/BCnh2gHtCWTnzV/gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvb7AHzES2mJUUqJ+3nGiLPw99QW8Sxqi3CV3gRbhoEy8Kxr5
	6plP5+oQDZVrdUJYiNuc/xtMgU6QW/zkqJ1gRUBa35F4G9q9MHCBajjh7/8q6Eo=
X-Google-Smtp-Source: AGHT+IGyd+pL/ndfFmOv6vLWrI3D0Qpobrjvr+ZrdZ9LrtfowVZj1cOB8MrRM6MMFrz4gjs+FCB7TQ==
X-Received: by 2002:a05:6a21:2d08:b0:1d6:de67:91c0 with SMTP id adf61e73a8af0-1d8c95abca4mr10553848637.27.1728889067325;
        Sun, 13 Oct 2024 23:57:47 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.192.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448f93a7sm6229120a12.20.2024.10.13.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:57:46 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH] irqchip/riscv-intc: Fix no-SMP boot with ACPI
Date: Mon, 14 Oct 2024 12:27:39 +0530
Message-ID: <20241014065739.656959-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
NR_CPUS will not be sufficient to hold all RINTC structures passed from
the firmware. All RINTC structures are required to configure
IMSIC/APLIC/PLIC properly irrespective of SMP in the OS. So, allocate
dynamic memory based on the number of RINTC structures in MADT to fix
this issue.

Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
Reported-by: Björn Töpel <bjorn@kernel.org>
Closes: https://github.com/linux-riscv/linux-riscv/actions/runs/11280997511/job/31375229012
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 8c5411386220..f653c13de62b 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -265,7 +265,7 @@ struct rintc_data {
 };
 
 static u32 nr_rintc;
-static struct rintc_data *rintc_acpi_data[NR_CPUS];
+static struct rintc_data **rintc_acpi_data;
 
 #define for_each_matching_plic(_plic_id)				\
 	unsigned int _plic;						\
@@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res)
 	return 0;
 }
 
+static int __init riscv_intc_acpi_match(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	return 0;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
 	struct acpi_madt_rintc *rintc;
 	struct fwnode_handle *fn;
+	int count;
 	int rc;
 
+	if (!rintc_acpi_data) {
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, riscv_intc_acpi_match, 0);
+		if (count <= 0)
+			return -EINVAL;
+
+		rintc_acpi_data = kcalloc(count, sizeof(*rintc_acpi_data), GFP_KERNEL);
+		if (!rintc_acpi_data)
+			return -ENOMEM;
+	}
+
 	rintc = (struct acpi_madt_rintc *)header;
 	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
 	if (!rintc_acpi_data[nr_rintc])
-- 
2.43.0


