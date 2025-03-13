Return-Path: <linux-kernel+bounces-560106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD211A5FDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A13880436
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EBC15747C;
	Thu, 13 Mar 2025 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KwgxIzgu"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F7225D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887103; cv=none; b=cywnbHceRuaLAQ1E2DMEKhG1ufk5yihGBC6sNecDBETFKZcAVdpgAWmtVUHkf0yAqahZozFkem2xtzA6uRMZKIjmpET8pVbchf7LnWqY4CB9DCV97Bz4ta3NHSZuE9VU6/NMpuKasW8pTKvjJgYUdVLMnRw8FJ96UbgI6lY5kX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887103; c=relaxed/simple;
	bh=yfW1gIa1MbRIx3vJ4nkUHmJnpytrI2/a0Qk/PMxYlCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZH/i1kIh+9cQB6Noj/5SNv5Rs7PcKUX0unEPFl3wMvIzPgo8pvFh01UcZWi2ETpSJLS3mpDIzIrHG02JslJHot9OD1kA9utqPavSLMzORciwPW2DAMAIEu0WyZ3AwN+1vRPrhrULLNcey9/G+ik/wfAN4r11uStUeqzx+OoQd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KwgxIzgu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso4465364a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741887101; x=1742491901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggMXVBojLEYrYjpK3rBBG/mb1zKKBgNArl4a0+lTQ20=;
        b=KwgxIzguf6oSprsVGgZhsVBmBOb9K0RO3fpa/F8+A7Am9vwm/C09O/8F/I9uDYZXW1
         u4w2noASygZa8b4F2yMC/lvaywPU1PQ8H3zzgdCdcwiOy3lUCF0kYQRiWMqIMY3a/PAN
         k5FbcVuIsIvjgXYfUBk7W8Zf2Ih0PFTmlE0b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887101; x=1742491901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggMXVBojLEYrYjpK3rBBG/mb1zKKBgNArl4a0+lTQ20=;
        b=KUkmpehaGVXLsxpYu/wVxyN9dc2qo/ZqXsKq6Or2xIanAGnkAdXQbVvMMEd+LfpdGS
         nkIbkeS/vTWLaTMSTrj1oZ9445iLehQsYT+RGgnwYynyDhjsUCO+UGwnbKcb06cfKNgP
         x34p4KjnLHb1P6UItZ1CqkB9+G8QzRzO0WXa3gFzsoCPbab5xT9B//3ZzfdtBXRWWpSV
         /JGP3VlG0SaE21Iv2kyvHoaaIs0h9heoom3J9VfAJyMAmQ6Is3D14G4tAT+2n6R3hr3n
         YfnOAxbSEWitUc8EEPg6fSBiWxnZlh4Z61x0Q+EEWbxsPyncj/dnW4Ake5OAAaQcP3sB
         pyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEZa4rnGHvt3SBUrss57jKP05Xk5seokzPb27Fuiwr5P9PDhDDMgSFh1me6DlA7RATj4FG/cPFU8gPqyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmPmeh8rVgSNWvYznJhdIeC1ZDksdZfpyTku+7vLf6wsgca6l
	1JZceEDglY0m/bGOWljhQLqMnIIsW/US1wQcW/n1AWBBzhmzIY8/D1CsyYVDWg==
X-Gm-Gg: ASbGncss4jMiSHAxSPwE6FOBEfW1L2sfBR4y7EUr3oiLGpebksefgxR4pBVGprr85ll
	O60cIKiGA1TFH/HDcKu3rFMZ5nOEYHnpZWyqnZDhAUvJDSjipACbTgk1HciPqmSY9arc4t9qcVs
	GyFdWKJEzF4hVsqJYr3kJh3buAGEWwOfdVk/VvuqJ9fCakx1nFvF4UQZ6NvKipVgnuvNW8BwxM+
	aos6RBqOOm/VanNhXydst8bFjR6GvDJjVK0lb9OCRmROzkFUJ17Bs/emRV/tpZHSq+gxuaqmdP5
	bMEwR/l4pEYN90D064DyGtuDPgsEX1L70hDo+FxUuHcFdpQziPa1gi+YSOKWVq/uxdQfG1Vp/w=
	=
X-Google-Smtp-Source: AGHT+IHTh9DQK18PXTqgsKvgHuC0vEOJvBIRPhsGggDCXl4nz4ApyCfoHStC5pwpS2+3w/OHm4FWkQ==
X-Received: by 2002:a05:6a00:844:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-737107120d6mr4984412b3a.4.1741887101113;
        Thu, 13 Mar 2025 10:31:41 -0700 (PDT)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167d89asm1646471b3a.94.2025.03.13.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:31:40 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: bp@alien8.de,
	thomas.lendacky@amd.com
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bo.gan@broadcom.com,
	dave.hansen@linux.intel.com,
	florian.fainelli@broadcom.com,
	hpa@zytor.com,
	kevinloughlin@google.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	vamsi-krishna.brahmajosyula@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	ye.li@broadcom.com
Subject: [PATCH v2] sev-snp: parse MP tables for VMware hypervisor
Date: Thu, 13 Mar 2025 17:31:11 +0000
Message-Id: <20250313173111.10918-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
In this case, mpparse_find_mptable() has to be called to parse MP
tables which contains boot information.

Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
Co-developed-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
Tested-by: Ye Li <ye.li@broadcom.com>
Reviewed-by: Kevin Loughlin <kevinloughlin@google.com>
---
Changes since v1:
https://lore.kernel.org/lkml/20241219114400.858980-1-ajay.kaher@broadcom.com/
        - use cc_platform_has(CC_ATTR_GUEST_SEV_SNP) instead of
          (sev_status & MSR_AMD64_SEV_SNP_ENABLED)
	- remove unwanted header files
---
 arch/x86/kernel/cpu/vmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cdeb..cb3f900c4 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
+#include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <asm/div64.h>
@@ -429,6 +430,9 @@ static void __init vmware_platform_setup(void)
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !efi_enabled(EFI_BOOT))
+		x86_init.mpparse.find_mptable = mpparse_find_mptable;
+
 	vmware_paravirt_ops_setup();
 
 #ifdef CONFIG_X86_IO_APIC
-- 
2.39.4


