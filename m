Return-Path: <linux-kernel+bounces-170455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B38BD719
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092FE1F237EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0E15E5D2;
	Mon,  6 May 2024 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W9r2eaGw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038E15E218
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032423; cv=none; b=mIBarPlnG4bE4EWCX3v4CvHi80OgY90hQXYHvHvvDVyl1eM3XmkhKfgEIuE8C+tZViHkq7ceQVGBTUiZ/Mt9uTGM6HiQR8Iw0AOYj9ruaVoLODGM/obCNNByYbYOLr0e2b4wxCUE72ChDrkWnZzQfrWdnhXY1iDmkmmn6InXNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032423; c=relaxed/simple;
	bh=36Y3BMpDPZQyyL3FNj9mP3vbrfKi4AzrJYNgKvH4gwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRpDl6OZum0QC9m2/Irj862auyGa+dJPCnL4kfblLFrq1FTnX18+KlUU647xtejYacByJ7Z2O8dkHMJcw/ALSuQe7gmFqEfo/rdxZaU+b0TBgq5Z1Krw6/mB0RJtBhWr9dIVRRX1kQ9+2eC6HStJWZLJlrHi8zypRmnZle+v31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W9r2eaGw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ecd3867556so17075105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032420; x=1715637220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XasMM8RHDoAht3zV8M7CkVA/nSY/Z484OZ0/rKT1mpc=;
        b=W9r2eaGw7b0CODKbjJ4KDZBQd6fygnxByFwgbXu/i07s4qAO/SVNi2ssgwziM6YdVQ
         y97MG5tcwjuyPSOYWtNhlMZ01nqt+S5tx2FID1xR6gd3sBAnEQ8Ymmq8WMwqDoHAs/4S
         UAUs5JjPYsf/vCs9hU5sjW7KoFZk3OcwmUgeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032420; x=1715637220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XasMM8RHDoAht3zV8M7CkVA/nSY/Z484OZ0/rKT1mpc=;
        b=CRwpvOjFqM9hDJg8Hrp5B97J7U6urwdlDa9mn64mo13EH8mfjEol4weJco/6tZjeLW
         2mrWZcepz8+bgQc4iGVQmYB+8eSy4Md5shfplDfFC7tuvN6D+uegMD7356N1BQ2AQIH0
         xTFsOj0YE+snnDmA4Lc/WuLEwfUi2tAZgCi2K+SyWCrxHNlE8AUXTUjsSMMla0GAyYuu
         yZ5TaeT0TDd2zbKsOCEiPwejtvtpvf8bZFVGo6EG/rGWnDXTdU940RWxQrPYcTK13ExV
         3/J8SMEGFQP7wjS0F7DbTVIhT9/+lJQ6VW9SAUx8/UeDgqiGUbf8whZ6aPZ7vyTamJQ9
         +9Gg==
X-Gm-Message-State: AOJu0YxdKXQQVFUJ0BVIVkGKTV8QTAgZ5oZjgeIvlU8rshh3Zbog8fgN
	g1NwQ4AGG4LIznqcwtIiwEn4GiLajYLQs/6q4I+GxDNViKtwUQQJVnSlRESAwD4IUkBa3rjU7C4
	m0Cl/dPIOavE66kMYUWfL/uE7fOjhfX9Py9Wo3oBMLtHZFhBjxkTsKv4YZeqakAQ9/SrvFEekoS
	dinggn0b1AaXxBJcgFQBJMnDnYFV2x60fZEIDmVDnk+Bb28xi+80/R
X-Google-Smtp-Source: AGHT+IENEOGN0tWde3qp/pU38RH6aIHaQEh28095AqfBsIIDAqJikcahIU1wceH2ANpCTzdN1vcY4A==
X-Received: by 2002:a17:902:d355:b0:1eb:3e13:ca0b with SMTP id l21-20020a170902d35500b001eb3e13ca0bmr9908685plk.37.1715032420197;
        Mon, 06 May 2024 14:53:40 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:39 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v9 2/8] x86/vmware: Correct macro names
Date: Mon,  6 May 2024 14:52:59 -0700
Message-Id: <20240506215305.30756-3-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.
These are bits in return value of VMWARE_CMD_GETVCPU_INFO command.
Change VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move bit-shift
operation to the macro body.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 68d812e12e52..9d804d60a11f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -42,8 +42,8 @@
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
 
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -431,8 +431,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.0


