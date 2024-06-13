Return-Path: <linux-kernel+bounces-213905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C0907C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0C8288678
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF81158209;
	Thu, 13 Jun 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VO+LQ/rx"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA91581E5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306264; cv=none; b=AHTe2vh+G2itGJ7aMWX3RzX7dI2CDLSFRNgtCRLXGZmoYTnyKshXvB1kH0YNCxuG5CWUzVfz2sJRlDsXmlAvzkPwuyVytNVabv/CYAChob2+2fIBNEh06QZuMR45tA5MdAMh2Bsvmml6EQ+/PSIXhIKUVQIU5AK8GM7zbJc1jFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306264; c=relaxed/simple;
	bh=gJtizgfTtQbGQhXe0Ffz4OqK1Rt5xK/EhfhSkvCPdfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI9wJCx0rODsac6n0QNVftoz9/Z4ruMkZEkf028ETccgDx8mbFpqmyUKrHZmg+r0HrsrUKFF4vDDlxWsQ1LIIrUsdYhd/RmZ0qGYMwvGksli1H+xd4ARjZl+5xmGTkRR6shyvrdXj8jH32nV4yJJ0en13/q0LlTXLGrtB/GuNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VO+LQ/rx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62f86eaffbeso15590707b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306262; x=1718911062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pPcaHiPPoaU0LCl+3obAd9PjZsEURqyWYfZZD0IxMg=;
        b=VO+LQ/rxkY5qmDwqBrKhAiIIR5z9/aYq1uw29LHl0/Yg3H5MEFkxUA4L7TZewJ+mLE
         cncqIoMFL4+S/xxjQdeBIIKNj7sVZxFiLk82sgDQu7RfpW+hkbGm7uw4ksOjEdT9V8YY
         GUSEIEDH0pbGajjKwqQGtBL7aWEwGcXxQQZIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306262; x=1718911062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pPcaHiPPoaU0LCl+3obAd9PjZsEURqyWYfZZD0IxMg=;
        b=dfgFyw1w+YIeEw0bDOUVZUXOnu8MMDGD72mjY59lkqsIlGyUcTHv3rUFiggfYayOeP
         dMC9gjespIuLxn0zQv1YEnzIi39Ksh8CGdaPQt6Rxw3tL4s6n8TRrNPTRlh4UFoEsiB6
         gvyhA2FojnpzaT4ZlovMEP1Coizi0SkfZsSFX3FChV+GDfbmmT7AhCfRuaFVBE32jPmQ
         snzAUPPXpFFRERJMId4WCet99WgPBXmdgSttVVskjhd4XkxiVkGpPaj4KcRnEtQt02e+
         77kRJ8r36QBQM21d9zAjuEXR7AePd0XeXeifVY3zdqtNzG7BvqSUTsBbg1ENX6J5DhuL
         5stQ==
X-Gm-Message-State: AOJu0YyKjdqxQBj3eRKkfQeo7V9RQWhFuQWUEKFvMz09wZYw8TbtVKim
	J3JpPON2KA8vwSHibEQQuIOFqD99rctt8ICefay/oqkuIYP4ZAs0tfZ223cjp1kVkSlmyKhAZgI
	GG83wy1dXEodYyScMvDCnxfrS2uZfrFaR3v9s45l+5ExFD+DwX4L33AHgZFYK9DRrCUIg9uJjf1
	my05MMj3yveguaNP36M9OhZR7bU+1qNN79IkpuBi1mdOXF1lGpE348
X-Google-Smtp-Source: AGHT+IEWURrmB3A2rOUKWL00yxGmIpKcgzJOWJY4x+5FfERXRFuKFdGultRWCA+8ZJ4Et9888+QB5w==
X-Received: by 2002:a81:e90b:0:b0:618:83a4:588e with SMTP id 00721157ae682-63223d3b72emr4007287b3.37.1718306261554;
        Thu, 13 Jun 2024 12:17:41 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:41 -0700 (PDT)
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
Subject: [PATCH v11 6/8] x86/vmware: Correct macro names
Date: Thu, 13 Jun 2024 12:16:48 -0700
Message-Id: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
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

Fixes: 4cca6ea04d31c ("x86/apic: Allow x2apic without IR on VMware platform")
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c0a3ffa9e023..d24ba03b30b8 100644
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
@@ -473,8 +473,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.4


