Return-Path: <linux-kernel+bounces-409639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F13D9C8FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D42B478D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C81AB6D4;
	Thu, 14 Nov 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V4MChWXo"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5E1A76C7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601149; cv=none; b=Mqm8sV820SwZy/VcR4bHpZxIdHzQiDr7loCWJk+8xoqLmPZUoE6McdYSmIPwcpdjPSO9OQ6Z5T4yIWju0Soy4tmKJrnucZf7Xu7HQGL2oeK55rHnySPaYuSrCwlxoOWVOsNYdi+f1qD5+Prm4Tts+wtB/RKItiEpboOf57x/4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601149; c=relaxed/simple;
	bh=mWR/+tZ7zPAyQgPDW6T1+Yz2Dl/T8S6Wjb1XP+iFats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InrgkbMeVnERMR8LHNZbZDQZOSCYbKZCPLFMXX4pJNUAVV8XLOrAlZCGJuQxpPOQok372Cxu9t+g6UGTyXXyWrVgAeBudb215ie91KQzqCZVNjSm+fdFtj/KS1CDoxcYmkR36Xp42ats5wCKxNkF8mey99yIH5LY4mSZflVYeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=V4MChWXo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da3545908so857829e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601146; x=1732205946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftdmF/h5yhFV9hvEqaih+NCLoaifWjggdlhRka1xblk=;
        b=V4MChWXoTH/de5eiio/PWHY2gS252zyJrZmd26MMgFImZ9oZJrrTHQj55XbjCshc7I
         UT2lu83aGx9xiccEqDAz0dG7xqcjol/pjMNVXLDXE+inOdtF+1TVShli5emzmLOGpbIz
         PYiG3/5SfMZl4TIwlk8qdvCfZsYThRRcujHfj4M35XuZF8x/8GgqqUfngihVmg7wS5Qu
         efP+atBdKIP883PIWsRI3iPJmW3OL7Oq+dqP443wcKSVh3MhZnZFqLGAlDEEU4F3kgcq
         K6iCmIN6Aj1cipwnHWwIeXrMppxQjgvxnVN9iyiZ3y6tR72Btv+HQt4pFvYy2Xlx+dCm
         xoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601146; x=1732205946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftdmF/h5yhFV9hvEqaih+NCLoaifWjggdlhRka1xblk=;
        b=cbAeoo/luRH4S8YNeKgTGf3mx5o60rD2LQ02lEZUFg43YuoLZbo9bpWO6xg1pIYxvb
         ZlOCVevMYp3D3cYU8tEcCnsOZFPKl9b3gHMC8nmFnhczuCqJSgPdzBgQ0owPnpSEKcVh
         Jc4ymsPyqoyoMLNj17JOTVQaNn7bjONEPPBSZaHHV+X5MATyrq54J8JEzbQXYjvRL8di
         WfqAbaBVOf2/ZB7sKBWtp9EePjGz4o1eRMgNkZMmMpb0Q5MgfLykIlgU3J4GpTLecWnL
         up44w7otimmZJ4CEJaKUh3bVuK+3XIPZBtSPnL6GKZGlnqUddo2/1W//tWzowE0pT3mC
         8Uew==
X-Forwarded-Encrypted: i=1; AJvYcCXEqaLPpjtya4t3wJWGJQU+UJu+n3gR22biqq4RbjLSJaGT+TtWayyjFnzeYYMyXB2eyQEIqPIBAVDCHlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3UQD8YlY3heTkLoIUHcsH1jG1SVXz1VETth5tEANdJWATR+Q
	BUODGmrlGwWGiNfS32owZ4iRGHA8GtqIvfk1CTIK8fE00YdCdS9RJR3Rkj6Dmqc=
X-Google-Smtp-Source: AGHT+IEJJHbd90NQ7GNwzK7jz3We2gQcoeU/8zkdAd9xuaV8q/ybA/J9tvQBrrlFpg45NfoyESG9lg==
X-Received: by 2002:a05:6512:39c2:b0:53d:a99e:b768 with SMTP id 2adb3069b0e04-53da99ebce0mr590942e87.25.1731601146055;
        Thu, 14 Nov 2024 08:19:06 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab76dafsm25510275e9.10.2024.11.14.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 11/15] RISC-V: Define irqbypass vcpu_info
Date: Thu, 14 Nov 2024 17:18:56 +0100
Message-ID: <20241114161845.502027-28-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vcpu_info parameter to irq_set_vcpu_affinity() effectively
defines an arch specific IOMMU <=> hypervisor protocol. Provide
a definition for the RISCV IOMMU.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 7b038f3b7cb0..8588667cbb5f 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -23,6 +23,15 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
 
+struct riscv_iommu_vcpu_info {
+	u64 msi_addr_pattern;
+	u64 msi_addr_mask;
+	u32 group_index_bits;
+	u32 group_index_shift;
+	u64 gpa;
+	u64 hpa;
+};
+
 #ifdef CONFIG_ACPI
 
 enum riscv_irqchip_type {
-- 
2.47.0


