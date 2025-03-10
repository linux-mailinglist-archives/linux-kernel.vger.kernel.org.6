Return-Path: <linux-kernel+bounces-554542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34134A59997
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CA57A4F80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B49233126;
	Mon, 10 Mar 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ind7pQE/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B77F232378
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619688; cv=none; b=MHu8bC8EVXwSB51vFFgCfXBus9AIiAio4g3ITKJi255dolyQQ0Gx4sJ2rUWRSv2OQIj6gDMoSd/ir6eYSfjduVKVQ2h1X4LEKZJdOY5T29RcyMixr5BG5xpiU3niq6tBBgA/cKO2tiYuTaYRDLe/tGEeDzLGv/FBnmanayAcjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619688; c=relaxed/simple;
	bh=RjDzKYoAvlKNtUWvQ+NXMggJmy91OtoJ6HGr5PDli6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCGRhpZH3zMCtXYDv8g8yNYzbviQQv41Wa3FKi26IHA1XEMlmTt49en5vU8lHlehvOWR3M8hU9Fpq+tS9AIGUt+0artfER1XNtAzRJf5Sgcvdj8ArZw4X0L+iGVyv6968qTErTRmB0Vd9ON7HztbZhpk1Sxrgv/6JhDQJVWZox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ind7pQE/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so47854935ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619685; x=1742224485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO198dOv/JV7u6RiN4qQUqM3nesMDxD5mvDVMd+k3NU=;
        b=Ind7pQE/WbUNlyQ8d9R9VZr5ciqGoOFgMuRXw1GIkh7lHxrddDKVHsEjvDNnYeiV3j
         1WFPUCs2Zyi+QMdenoulBDEZxrfSTrRyFkVkvOlTEBBVXfCU9GHtxNK/Ulq0WhrvBxZi
         pfmNnsFpdZvIJ1BXV28hSP+SVqLghqLnxCLGWj1bj9JR8mSNIzIEctxTNqaAQAz2r/n0
         7r4GOD8dYLeqnz9DyqI8d9lifUCaT3/tEAOksVUv+IxdRNPmwsOuBaw40egXSkVGRSol
         Kifq3xa+7jRHCIdsxsgZ83YWltTAby5EmBWonSrugE1o6AHpnb3uRIhBAccvlVK/wBX6
         iHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619685; x=1742224485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO198dOv/JV7u6RiN4qQUqM3nesMDxD5mvDVMd+k3NU=;
        b=cYlDTuCIb0FodrThoLOjrHQTfHP9mErRQb6C26rLTOA7XmhHJQWxpEi8rYAUXKcORD
         gav/VxH9ThsFdV7VLm2Zyow6xZwhxk48D2TSwu0/sLLo5Ji6Im0Ko3dpj4KuHvgjLebz
         CmPx/rYMW0isersdwHagOsfu54TFQochFkmNGU7+OlJOv4NOdWMd8lrVwVXF6rH8k8/8
         XfHrSK/TotDHiyIrnOzLRgL/50d1LVawnrqdcmX7ALuP4H4Sx2jB/xadlJ7E93vTeLpB
         lt1NYhKzvFFZsvkebvO+GT4dZ924Z7YH8tIFfkEMkKWxV5jd+isll5noqvSBTF5PMC4R
         lTXw==
X-Forwarded-Encrypted: i=1; AJvYcCWQqBoeA8nGU/R+X6ViYvxNSKiJnuUJoxl6yWZbzocy4jJLUOt8OKLvgFf+zDRhYLuv7J9SZzHVAaiLNJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVg97YbidDue3Eh3pl08mZxkt7RekF0Je9qib0AMJMZ/9ofRr
	9djJBNpoo1CFQITUEvdZXXjlXkA2/uodAZ/5pRmrd1Zzq3lkqS5VqGIbUbRfCIU=
X-Gm-Gg: ASbGnct2ad8s2O5dIQvNq1mXtYCdfz7L0Jh/tfGLfIvycwh5y0O6Oos0dC/Drj6ha4+
	n4rtg8lL5OJsSRmNug22WHZxMVw41uooG1nSwi/HvcQOMOoNJxzF1PxMfQoHdGwa+tVaSzVJ/s6
	ivaDcI+JPvJul1OgxHZw4xBSVTuhEaCv6xQR2+ymhVbkIzGfKpZS78g94NVJ1d9z7Z4iVQK+qRH
	1vuxi823NxtCREhnUZ9QuTKhoGMz+Gk6w+3PaoSa40tQ1jRDZiwu7/wMpXMTPU+E+ygApOcyzv1
	zOpwzAShIISJoXe3jCyy/2B86RNZhq7cfyfjs82Cfq+MxA==
X-Google-Smtp-Source: AGHT+IGIS2XxIf4TQa/glKSShb2DPMKV2nM+32P/jFh4qY9T5snUhs8ena+pzkKO/eEMPCMRH58+YA==
X-Received: by 2002:a17:902:eb81:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22428bd592amr282084395ad.40.1741619685003;
        Mon, 10 Mar 2025 08:14:45 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:44 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 14/17] RISC-V: KVM: add SBI extension init()/deinit() functions
Date: Mon, 10 Mar 2025 16:12:21 +0100
Message-ID: <20250310151229.2365992-15-cleger@rivosinc.com>
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

The FWFT SBI extension will need to dynamically allocate memory and do
init time specific initialization. Add an init/deinit callbacks that
allows to do so.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
 arch/riscv/kvm/vcpu.c                 |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 29 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 4ed6203cdd30..bcb90757b149 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
 
 	/* Extension specific probe function */
 	unsigned long (*probe)(struct kvm_vcpu *vcpu);
+
+	/*
+	 * Init/deinit function called once during VCPU init/destroy. These
+	 * might be use if the SBI extensions need to allocate or do specific
+	 * init time only configuration.
+	 */
+	int (*init)(struct kvm_vcpu *vcpu);
+	void (*deinit)(struct kvm_vcpu *vcpu);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
@@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
 
 int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
 				   unsigned long *reg_val);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 60d684c76c58..877bcc85c067 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
+	kvm_riscv_vcpu_sbi_deinit(vcpu);
+
 	/* Cleanup VCPU AIA context */
 	kvm_riscv_vcpu_aia_deinit(vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index d1c83a77735e..858ddefd7e7f 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -505,8 +505,37 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
+		if (!ext->default_disabled && ext->init &&
+		    ext->init(vcpu) != 0) {
+			scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
+			continue;
+		}
+
 		scontext->ext_status[idx] = ext->default_disabled ?
 					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
 					KVM_RISCV_SBI_EXT_STATUS_ENABLED;
 	}
 }
+
+void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	int idx, i;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+		idx = entry->ext_idx;
+
+		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
+			continue;
+
+		if (scontext->ext_status[idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE ||
+		    !ext->deinit)
+			continue;
+
+		ext->deinit(vcpu);
+	}
+}
-- 
2.47.2


