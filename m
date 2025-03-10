Return-Path: <linux-kernel+bounces-554528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94E9A59958
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DFF3AA64A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FFC22D7A4;
	Mon, 10 Mar 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rdo7WFjv"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5422CBF4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619577; cv=none; b=kG5yM9vkI0YbjklOfPR4XYaOhRhyJnhN4wCmdYZbS/qoPU4ELzOZjFP+WtVIVICXSUbsSPGOfg7xAmqM0qZnQZvtLjkSUX6QUP3gJHdkutLp74zab33oqac8zfV4FgWtZdefSlKGHf1/yn7xlpQeL1Ag3Fw5YEcAMCNb/BhkCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619577; c=relaxed/simple;
	bh=2FK1ieYZVZDkEHp8Xg07qiKFT3KgfWyXTE481sBPnIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwiD+4lDnRnX2OZblef/zFqGm85PX5S1VxwLIRaBasqUAqfMT4Hy5boeXmk7kEve19T0AR8Bx9pVmm95FY1VKDQi/gfDlJfS3xA5Q8cHy+6xE65r6Kp0gLAWGEb/FBZxAnvYkRQuUJ/YkNJ4dEU1aFCb4j7/vdVexlKVEuWekG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rdo7WFjv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fb0f619dso82333245ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619575; x=1742224375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqoT5ixPEtXdLEI6ocjejwPv6xnA8RHlbYFtktGXOjg=;
        b=rdo7WFjvTeKJtoU112wx9O/+WnrH9Nr6eQPPOxl2HeDyIGXDkuLa68YKG4RUHniJnV
         x9NKr/g424ByAPmYXBCdjpfJyctB8imVHykEsmeBozhg8OyKzihy3RFwjXa7ilFOT4rs
         7B4rT5wFwWirFR/vL+hHKgoDwl+ika+cbhAlMTYbmrqRuV3BbOwyrravS1bnH2UXKcV9
         r60k91AJ1/5t69NGXA52BnkwrY5hWStrrGoPEoqNr9a7Fi3lvfJoTI0cCtPJV1jEUKMA
         3G0sUJ0Sx9HszNH0Az4WFeADsVPbjXXceQs6g/tfLETMqn4Wds2BZokdtrG+a7QZ5dn/
         PD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619575; x=1742224375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqoT5ixPEtXdLEI6ocjejwPv6xnA8RHlbYFtktGXOjg=;
        b=wDvyIxyga1UJAE5R9ztQLggSnOGm+C0UKmMdnB3oshwjEq4XyPUCJzEfMTH2qKquL2
         vCPKDAgjRTwB1SDFPBrBx1JW0A6rP8ZQaoVEE44s7y5ZZKpxbzQIqFEaedxlHUUC11Mv
         689V8lQBSwKyHMyUIGcWKGNwAmCH/P5oYN4MlXrL5dayo2aGOQ88Yp5V4NUbhZ+VjfZe
         PN69debOIGiQqqwFtuHIQXZeXuM9BGh3Zywi6eDViApGl6LmVyUCPXCpdcQucwAiAkXJ
         nNxT8ZMZM6atK6KKlV981hoLNNqMoFGqDGJ4r1iw/mvFsI9tv2E9dmaF9Y6k0v+B+QqO
         Lk5A==
X-Forwarded-Encrypted: i=1; AJvYcCVOOGr2p75OmlOoW829voRhF2w3FHhSBU6XmtGwzE8kF1kgl/RPLPjNUKo2KuVpZsXMa7KNP3EUwOfa1U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EJ+A5+PHI+t27mnyz6+63kto91fmgnrXWpR76ZTVvKDr0rDZ
	K0kSNPAR4CCQwGkIYV3LEaKcG6vnBV7E2VbY3oBrDIkTVXAq88YXEh6v1zVO1ZY=
X-Gm-Gg: ASbGncsIIshzjy+zMHMg9izGgtu1GqDjcJrwNS2U6FDhIlOpkLlTD8d09T+SV4g0VKj
	ux6FO8S+ue6+6xo+3m4fMxR9PmUqgsbWH86sabC7/UVJbTvahooXjSBKK8WSPpZB++si1xIZj2z
	Uj85qpsXVn1eFHeCDcJW/lSPO6XcHv2rBVMVUS22eShbj3pfSFnRi/vqd9HlstD8ulpw4/vrjf7
	AbZQHXr2SXsESWbYuMWsHrgnFmCS+mOc0vPOyhlZ2WCeJXuSy52sEtIFpYbk+7r4YPsYN5D+hvY
	TSluzIF2YHt0JNQMaWLhpUsYb9VoYtRGHwLpC0vLmmKSLA==
X-Google-Smtp-Source: AGHT+IFvzTd5QCV2TCtNaJ/EaL6UD5ar2zJmoTEAdGnVQhe1E8h+p63CvIu3O7VcRgR7VvKsoM8L/A==
X-Received: by 2002:a17:902:d483:b0:223:4537:65b1 with SMTP id d9443c01a7336-22593185c80mr2418925ad.36.1741619575178;
        Mon, 10 Mar 2025 08:12:55 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:12:54 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 01/17] riscv: add Firmware Feature (FWFT) SBI extensions definitions
Date: Mon, 10 Mar 2025 16:12:08 +0100
Message-ID: <20250310151229.2365992-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Firmware Features extension (FWFT) was added as part of the SBI 3.0
specification. Add SBI definitions to use this extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..bb077d0c912f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -402,6 +403,33 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FWFT_SET		0x0
+#define SBI_EXT_FWFT_GET		0x1
+
+enum sbi_fwft_feature_t {
+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
+	SBI_FWFT_LANDING_PAD			= 0x1,
+	SBI_FWFT_SHADOW_STACK			= 0x2,
+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
+	SBI_FWFT_POINTER_MASKING_PMLEN		= 0x5,
+	SBI_FWFT_LOCAL_RESERVED_START		= 0x6,
+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
+
+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
+};
+
+#define SBI_FWFT_PLATFORM_FEATURE_BIT		BIT(30)
+#define SBI_FWFT_GLOBAL_FEATURE_BIT		BIT(31)
+
+#define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
@@ -419,6 +447,11 @@ enum sbi_ext_nacl_feature {
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
 #define SBI_ERR_NO_SHMEM	-9
+#define SBI_ERR_INVALID_STATE	-10
+#define SBI_ERR_BAD_RANGE	-11
+#define SBI_ERR_TIMEOUT		-12
+#define SBI_ERR_IO		-13
+#define SBI_ERR_DENIED_LOCKED	-14
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.47.2


