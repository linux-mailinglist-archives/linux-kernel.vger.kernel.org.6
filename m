Return-Path: <linux-kernel+bounces-536301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA20A47DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF703A7A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E022D4FA;
	Thu, 27 Feb 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TqbrQbZB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077322F14C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659821; cv=none; b=RtuWCq96i5GFDEhWeWXQf8ASIuu8/qCXA0IvI6HkM+CfkqAfrS41GP5lq15/AHidyTMuB0i3RdmRwwiXu1HKvsUMzBYN7h/KQ5CVIj8hnbkjnBinrV9oBa6DQ6SoMdP/UB7L3huN+5SPusH1tYHaI6y77FL/+wwcoec6hNiNbGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659821; c=relaxed/simple;
	bh=rGWTzIIeViWhGlD8y9psao/8+qBiPCPjAKNTSslE/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqd0QGras6wXqNl/Ivcx/CJPr+kR+oL4mb9LbxBurXjLcLQPVv1dmax3GzlBM4RP5hyLqoyOiZYkr1bfhgSHq3IkaLO4nMihN/FCPueEzBkiRl9R90hSiMyBOM0vo8EG21KWx6l2H9VPA2prRFcqd1kLygqdgwHzctGc2Ik9OrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TqbrQbZB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22359001f1aso9663455ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659819; x=1741264619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvAemUtNRi9tUzWy4d/eui/dPAc9laFlbuC1eHj4jHs=;
        b=TqbrQbZBaYvY5y2YdGx3D0sg+gCI3UW5XBphTHTYm5Cgh5IaLoFi1b6kmPZtkK9ott
         oFBlbok9irak0WiJ7CBLZdtotOAHfKN66/9y2wmUuyKF4TzfdrgmNLIpwcjW2Lskdsbj
         xRJAFeyMCsQ5NQYuj8x8G2me+OuBQHyzIwd4Jqn5TWUA/axkd3ipYiM/5T/jXRuod28s
         M40yFH5ryMwAuFHv2GiiZSGEindR4F6jOXsWRoL101D/+Ce5OwBqhME6rKmt8XUj51Tp
         S3nCzkxEtNCmkFjYEClVZqZlOs1mTk7MPLpnDk8xdn/kW3NKaYwxZ+CAkkCzx4qV0R5A
         q8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659819; x=1741264619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvAemUtNRi9tUzWy4d/eui/dPAc9laFlbuC1eHj4jHs=;
        b=vSHJAnL9QG/jhvOSdWxHCR7dwknM1AKjAAWmo6MeCAmY5frXnimAUOdgjIZxsJRdiw
         OFtrvDwG2d4FOGpGRFB1u+WuFBKvPVUGuGqxapbBT52/WKFAOQoQuai7jRXQuecx1Rjg
         MIGZGiTIPxFArEnaOZSlYYT44n/Y1IXDNJNBljrG73yRn/Asp5AIilQT+8xYydy7Xjtp
         eTnnVAi1IKlrWJrwQDK2xgXTeXV25FQj7XTol4lKz895BN3ZBQkgt5zELe1L03/t02WK
         N6VGExtmqJf1xRnvEoMI1enz4UGdyxP5k9Vv4HgHAz7tGKomStuWv6mHjyVAdMXlS3id
         R30g==
X-Forwarded-Encrypted: i=1; AJvYcCUG2IMgMTi7wuoqx04+4yw608pcc3bKeDi87GnvpGV6ZroV5cj6RznzhhA1fS4GuA/29swgyJZ5I2LX+YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVAmBwZTTXd/KIpoxbaMtqM6AyNaLtlFlawRRzkAy4zALHgRkE
	ABqX7aXndkAIxmFSaQqguVhcJSRj6s6LJoRr025zzn+ShspysEpTy/O2FshO8Ys=
X-Gm-Gg: ASbGncsc/Vr/4o7oMIfjcDEVTaQ/QC2zO5w6qgw4EVCoVMoiLQpzlSxeElsub6vZzUJ
	DMxA+TySwq07KwppmQN3HAyymlax4h/dzhattpIM9ZNIVOMV5P4N7hpRqHofUULiZ5x5PCilK/j
	e6O5h/52dw9WMe3pmFL1k0tyzPaybLrHTfY5Bk7f28bvxnWu5knyJuQoNcHsNFzCIafuOOdNm1n
	jeTYbBZwBTCWGooo8OvB17r8FuQcc3cKP9lvKtMtYsh3n5Ya3wwDVZQwdoHXbdLwpHCQGoEonyd
	/YeJbqazXb/3ovE1C6rsafGLKtZvC+y8HE44
X-Google-Smtp-Source: AGHT+IFYVtprbH9evLqNClf+RfnxGHGySs3bbzOLOoRiAZRk+G2rF8ng8rvkLS2SHiGq2QScEJQDTw==
X-Received: by 2002:a17:903:228d:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-221a0ed7e4cmr423165445ad.19.1740659819428;
        Thu, 27 Feb 2025 04:36:59 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:59 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Thu, 27 Feb 2025 18:06:22 +0530
Message-ID: <20250227123628.2931490-5-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..fa3a0ec0c55c 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0


