Return-Path: <linux-kernel+bounces-187918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1678CDAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15838284DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3D85272;
	Thu, 23 May 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c4eA4mnd"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D884FDA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491740; cv=none; b=h7Qheo2OxNR4f/5+65PXnmch8zEHhAmuN2UhmLahnZa4S2MXgoowBQNxYLAYt+aiv7EgWrlHIBV3KMoBS1SbcA5vbgDrrdJ7HYpaDfzDAQrTFES3Mws5+qXaNod8B3EMETAiCxEnxoihbpJ0PFpYNeFGqwf2S24tEdgUcgP91v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491740; c=relaxed/simple;
	bh=cwPi0cwLaudKiJrBxIwug/LIGv5XW3nEwzrdc3S5Ovs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8Cq3PgPcyfQz2E0NsXjoSxr/4xG75bnkmnGWeVItpbR89vE846B+9CpfYAhQEiaYz1P20mSS67dt/RknKGohqAQ89JnWePxZCR35TRVsR3y8HZr9KEaKZCdOgwnxPOxo7CFyDlwT8zuecvkq1wbkrQ6+sh3BtF39aSDtmlkwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c4eA4mnd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7949747a23fso190958185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491738; x=1717096538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZPMIYqCPOQ9lUONW9JG6SX+420+rT4m9cGMXu5m3VI=;
        b=c4eA4mndxPWiqDouHwPB4iuYfxv67n2nXdO7PRYwrY/GgNXMFIWo2TfIYxjMx7fHaq
         GlHHxxyMOp0hxHHIvooOf/yN8utRGd/XwHdzUA7UvnS+Auh8wmW4xJ89A46Zwtm/IcOH
         aPLXH1PVnq7TTbJJN36SRowxi0I4Knlwsw9LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491738; x=1717096538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZPMIYqCPOQ9lUONW9JG6SX+420+rT4m9cGMXu5m3VI=;
        b=Q61kQjS8Vow9LEdG7KpZx8FSDNLYVy283n3Tj0l5+tENK23EINo+mIu4Q2e2HcI3hR
         j5jNGv446Af7+jWg/J8vHm9P6+jpqb2rdRLJAPJ2vfA//9Vtu5eagx/BVwHzYDwkeiYe
         5oCMO9vFKO7hpV3Grmd7rJaY2bBXxLc9NaUNQe8k+1bmZO69E9nOP8MuaSxxCPkbuLuZ
         wKMejzvLdaHjUWm7G8h0lN0UndvU+yda8iE7PZrNZnLDe88/kEZF2rxlPSRpkqDKX/t2
         PkPLIr4cVV4HczZRT4NwgnhJUbkFWOHpMadYlscUgBCZnRmP1VTXoExn53MLcw52JZsh
         opFA==
X-Gm-Message-State: AOJu0YxCT1VctKUUzeTPZtLUi43Tlfm9YFrL40dTZWod2cEXWwUI7z5m
	4I+DY8fNgbtIkiJhr7WOlDSQxdQoHLM6Io2RNfOhX77eJTYwmqt+R7CGDkjS8Ax6q/xVA6wqJgk
	a9Xjql/YyKrm17wGJ9Wp86qJ5Vjb0/knX5Mcf/0raGJsTlwYEaomwOQDlJr11QS9+mDfpLfj6mU
	7jqCuwBrDZN/1SoYK23O2wTr9drBZrzvnJmpkNUqFCNMhdKXUCj1lP
X-Google-Smtp-Source: AGHT+IG2JzfPFZy3xWsQUnDD6DVaCv75DpVNO+T61rq9vujIHdvBjciczesgyKtATQ7tmpk6hsg4FQ==
X-Received: by 2002:a05:620a:5608:b0:792:9d32:d37f with SMTP id af79cd13be357-794aaf8eeccmr19545485a.0.1716491737788;
        Thu, 23 May 2024 12:15:37 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:37 -0700 (PDT)
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
Subject: [PATCH v10 6/8] x86/vmware: Correct macro names
Date: Thu, 23 May 2024 12:14:44 -0700
Message-Id: <20240523191446.54695-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
References: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
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
index 6796425eaaa1..58442c2581e7 100644
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
@@ -424,8 +424,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.0


