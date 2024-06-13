Return-Path: <linux-kernel+bounces-213906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB2907C60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F2C1C255A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728691586F4;
	Thu, 13 Jun 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MnOpkS3q"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251E14E2D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306269; cv=none; b=nOpKqfw9WzroFYKBgpnPIkPT9gKEm99GsVanljmFKavX5RqbDxgG2GYRUiPV/1lgdTCryP2Hg2+4OfKT0e1lOU+AUC4WVnDbJYwUXL1yOxoOEhpOhJcB2e6YVmhxzhBCVrRGbSY0HUvMjt2DQ+TL2XFLF1wxqUH8IoslEdIfGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306269; c=relaxed/simple;
	bh=Q/3uwJcP0awQ0cZ0zuOOajZzP1zhz0U9p5QjUO0IuwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGvpmRpzIPvEG8IQtKV8Rjvf/yOxFY0mmGitdXMnflTWKU7aJFwJBFDcFRbbuC1zGXapWo9SDjWVwh1dJ0Eb0kdOymAvnexXJswEVuE+b4bf5abAggvzbrbTufFKlP1MnLewjvqyVdGREQ7VyxjBt2DGGetpUitpB+ORD+wnYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MnOpkS3q; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-630640c1e14so20344127b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306267; x=1718911067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvm0BsFAFI1cdP2yPyZHFfaL98AuxIoGBUiXiDXnc2A=;
        b=MnOpkS3qY/AcUnB3iHdlNZNicTqe9wOWurJFGMRwZOoPZlDFUGT6fHqXpwxfDkOjGW
         AQbsOOC1D1kFDc0q3uvVTJJbwebqs8NCtmjHNCRzhDqrKCLSpZcHTuqaDTDnEckWbz/k
         MR5Zcxu+l46UDSPNypFK05eLE1tmfdJWloDxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306267; x=1718911067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvm0BsFAFI1cdP2yPyZHFfaL98AuxIoGBUiXiDXnc2A=;
        b=xCcH4gTxi7T63O4oo5bgLto3iXI1NbXalNV59tAEE1VV9Wu28l6sBX2GSzchj7YQjM
         WZmkdycAnEHzCWv9u9Z8uxwMHkiG8M5NVTo1reuOjPTyeBPpCzkbPptXg+lqNmnE9ER6
         /7RuwSEUzVseKlIch3RvGVyPo+qRiws3gV7NXNHp+tWyrKSa0oGigI6SyNODRHr5OTys
         9ZIEgX3ubEVJxZRm2Oerj21TAyAorroQ5Me4gPikSVMZtFjS+cdHY4vSpgsrs89vnmo8
         m2a7DpbpsDb02LNrLmJHdjZC6QlNeDywIFrGbMzS63c5LPdKo2N4o20E+EbTJqeQ4WFR
         cS2A==
X-Gm-Message-State: AOJu0YzuZ1TLqJfYHgtnjx7jeaKhfAndWKDJ+7vbSbpZcCgbc1qo9sZq
	NUFsgQ+Rcg0VXn8mb+R/I8wYbwMc3TkGIprC7BU4PVw/uDwZmc/zkkAOyz76E53R0nSjZH8s6Uc
	53jqx12Gt7dnUVBDWYW6baPM77Hxd3X1LjHYUUMdGYgeFs1i0JbY2ZLQhD7jXVpXEi+DCYEdHhY
	vW126KF7WfDfucuXBbheh/fRJ6OijqOJ5JbJJYQ6JJy0BxApYfdfGl
X-Google-Smtp-Source: AGHT+IFE9wLsZ7ENC3mJ6qucAwCj2u4sQKXs6B3ZL4fkGGOEpeG9V3zFRYPhrCcwGDxwPGGrlz4D+Q==
X-Received: by 2002:a81:8d13:0:b0:62f:b04c:2442 with SMTP id 00721157ae682-63222070cafmr4181267b3.7.1718306266717;
        Thu, 13 Jun 2024 12:17:46 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:46 -0700 (PDT)
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
Subject: [PATCH v11 7/8] x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
Date: Thu, 13 Jun 2024 12:16:49 -0700
Message-Id: <20240613191650.9913-8-alexey.makhalov@broadcom.com>
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

No more direct use of these macros should be allowed.
vmware_hypercallX api still use new implementation of VMWARE_HYPERCALL
macro internally, but it is not exposed outside of the vmware.h.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 724c8b9b4b8d..d83444f03969 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -279,30 +279,4 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 #undef VMW_BP_CONSTRAINT
 #undef VMWARE_HYPERCALL
 
-/* The low bandwidth call. The low word of edx is presumed clear. */
-#define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
-		      "inl (%%dx), %%eax",				\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth out call. The low word of edx is presumed to have the
- * HB and OUT bits set.
- */
-#define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep outsb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth in call. The low word of edx is presumed to have the
- * HB bit set.
- */
-#define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep insb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif
-- 
2.39.4


