Return-Path: <linux-kernel+bounces-368713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49979A13D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DDDB21B20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026C216A16;
	Wed, 16 Oct 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G+sN4Fqs"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140B216A19
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110502; cv=none; b=GDJXkOB2W1LSPUtj3LpLnQ2nuA+/Z2sXTp72buC1g/Z/60IMXBpK7zVvSTrCGEo0Qz210mdeF0hHrEAnS4p9MtKJJWnymHRuiMf2ip+MQwGb5TyB2/yGH0lKsF9ron+ejBcQXxQCWuTmQBmXcR6+weNBLPF27caQ2ow25o/yDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110502; c=relaxed/simple;
	bh=OXtwgpX1p78eIzz35BpZxxK9L/PdXgpGUs52e85uLCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI2Q+wRRZEhZs4+jBoO6Azyd3L+hWJMUdTkiKYXqvhTPvQE1ooS5phCyj33K484U/lR7Y/P/1w24rpiEcxeIEnxR63izKnBlghjr65rU1iSFqnnFwaBdAfFr/rs+W7fYng00y/Q3uKNFM1YZMjiPMHrLkkCabcZpGGBv8Mnu4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=G+sN4Fqs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so173633a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110501; x=1729715301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UwuohaBpRoU5PwojE5+Gkdri+a8AExwGUOzfsduKVM=;
        b=G+sN4FqsxkHrmO6xPSaI6OwKIJARb9IWkg4iW0znyY8WRCcpQi519mDxAehsJZGuM1
         v9+SJUbL9JrEiFwpQjtEA1B/DIQ26qBNT2yAGZTbIlmdBASmJEdzKllEtyYJ6a8pwnIj
         dX2uYPs0geavcphePV7b4g/EECR2pHP3tboIF1rS6sOhyDyqiodXs5KJqHlwHR9D47V/
         bE2jSTnIOZKs/dYwLBPDDF2SXr2MxukSUuvH1GC0lqhWe6vIHB4yWXirxXJ8HYpHJ8h1
         CawAh5dafgE06KTfE/b3sFpx8lE8iBP5xPw+iDmfmJt5BNKAKmGHxFKRBYEbWeLcYsIK
         vnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110501; x=1729715301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UwuohaBpRoU5PwojE5+Gkdri+a8AExwGUOzfsduKVM=;
        b=c0GC9cdSv7Ia32ARTYv1qr1EXx8vqB8aPa3GPifdBvZWTHVnXWb4owK5F9k1/h8QzJ
         JvxQWpwYr7RmQOhTnfIHW8r/x0FNWFkvnPS/F9mCIyA2nJE+zYEArxtgE6sZKouQ8Hmb
         eXquQ6cNQ5AGogp05NxAvSwxqD7q10gyuAXWYM+s/4SyRmvcQ7nVtnrxfrU7c1Jx/daC
         BKwSbfTcw4T1teD2AFun/iZx7yV1zKR9VJxhojJOIBdiVHQP1v2fCfAJbkdyVEE2DOGK
         MOqhMUhMAf4MgDF72vGUwADZbtGNcIWlPNcUk0frdOkasnZWC1xpb6jSowRcF/UQU2fe
         w6nA==
X-Forwarded-Encrypted: i=1; AJvYcCW6UEyjlwQZgT1HrSsN+ZXJQtMAEVowk8FIGOLqE1vYhmkgGC4giP8CbewkqGgXty6CG0lQkKlydcwnH5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxV6X8xeteU0BuP0Fc/rXF1lhPU0HuDlnThgJvxOj1eR+lU2Lc
	oDCWQuu7NT35BX/lPfdiRMzZW1BmvlkF7xKvWkJPT3+iwrbXuhii9ONO6L5sTns=
X-Google-Smtp-Source: AGHT+IErL2Sdr8ec9Qw+ve0FvDLKKtrRKua+qTZ3t0Y1FVqURXGPbdbwTPYS3WSCoIo51bNOUX9RUA==
X-Received: by 2002:a17:90b:802:b0:2e1:ce7b:6069 with SMTP id 98e67ed59e1d1-2e31538f1camr20096245a91.33.1729110500826;
        Wed, 16 Oct 2024 13:28:20 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:20 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 02/10] riscv: Add ISA extension parsing for pointer masking
Date: Wed, 16 Oct 2024 13:27:43 -0700
Message-ID: <20241016202814.4061541-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Add support for parsing each of them. The
specific extension which provides pointer masking support to userspace
(Supm) depends on the kernel's privilege mode, so provide a macro to
abstract this selection.

Smmpm implies the existence of the mseccfg CSR. As it is the only user
of this CSR so far, there is no need for an Xlinuxmseccfg extension.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Rebase on riscv/for-next (ISA extension list conflicts)
 - Remove RISCV_ISA_EXT_SxPM, which was not used anywhere

Changes in v2:
 - Provide macros for the extension affecting the kernel and userspace

 arch/riscv/include/asm/hwcap.h | 5 +++++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 46d9de54179e..8608883da453 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,9 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_SVVPTC		86
+#define RISCV_ISA_EXT_SMMPM		87
+#define RISCV_ISA_EXT_SMNPM		88
+#define RISCV_ISA_EXT_SSNPM		89
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -101,8 +104,10 @@
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3a057c36996..94596bca464e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -377,9 +377,12 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
+	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
-- 
2.45.1


