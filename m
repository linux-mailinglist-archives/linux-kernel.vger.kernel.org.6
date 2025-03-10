Return-Path: <linux-kernel+bounces-554545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8715A599A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D073188B43F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF5233D65;
	Mon, 10 Mar 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="F3f9iuDZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A923371F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619714; cv=none; b=LpDAJ2QVSPsScjvzKBzpA40gKFZKUM8mnY2emGO9y1CNvo+66jUDwYi8lYZsTjiq/fViMSwZPkLvpmVXGmrNI9qYMfJatcKYcrNdi1C1a5C5smuqpGRFypetdYhWQZCqmzEMO+ORGreKpYDEu05D4Vdw5RcvCaHdhrOHit5o9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619714; c=relaxed/simple;
	bh=3H55FORtmwscKRH5SzHI+X59iFLs94AL05N994sGaPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0aobcB4CV9Umaxj0wS7lCYhOgJqDJH8ysgvGwmWZ9LdY0uHi+xOmpICrLWMBqgcEia5uKmY/wyLf2UcKz3Pp+5SpZrGhAVG+bbpTIxWTx/8wIHX31gzQc0NlqFx15IT823szfYIRHqe8Zx5k6ZYXfm+61llwmet1vLookh3ZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=F3f9iuDZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223959039f4so86625295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619712; x=1742224512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfJ3/5A+8eTTKYRN2eD83evjq8eHQRgBJnaNQ4fOKIc=;
        b=F3f9iuDZ1gOqc3bM+g71TDUDFrV5Wy9sxXs9cJY0K2EbYAMPyrkJC+UiSz8LIDVbFv
         J0/B1JUSX7Z2WkFNIf6ZKynschBkvbKEGje0HL2xDZ3MQvqiU5+h2zyg0w7RqLZxqBfp
         ja+pS5WGrVwDHiCrYtGtPYfHtkDbX0Dv2CUl8QBv15kaVhWCH1e3zj2mFBfTD+uEMYhy
         dR8961lSy7MeQiKgauCfV+z/0sBVx+wwv4ZBOOcXmqTw8eopHTryxz862AUA3sH2m6iU
         QXBTSLXOkHkQKKTXvUkGeICoE0bqxqLe32VTrW3opBh4e5DN7+NkFup8vKoep06R2adb
         9i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619712; x=1742224512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfJ3/5A+8eTTKYRN2eD83evjq8eHQRgBJnaNQ4fOKIc=;
        b=Hkc5esRbsaVwWcA42tNoxIyp7jyJMKo4rndcNuqLEj3JhedDAau7x3hVK5Z1J2wMKs
         IAneM6dwWaiEI2xI+YvICB4DPDYEGT2XiPvlAVGudCv48ClJ1wAsZ09v1lu6AFUtD2QX
         G237C/8GpHnST/a/bxt0TiOz5Ft7DgXjBqFeJO9jcx2MO0YX7pOY5L+4nhvbGSgD4oqV
         8pvlAKdAsWu9XuhkoXeRu6f8BqtlmfQ4wu5BkD7wN+ghjtPoyuf4d1yeVXiEystnxWfy
         N4YEoW9tnV19RnVjaxzBP/KHroQUB7WIfKAeDqOo3ttDIddx361ZRZbNlpfOnQPuue1v
         VUww==
X-Forwarded-Encrypted: i=1; AJvYcCXYipnJQJBIWOPleyC1vnr+2dpAzSQTu5X10ups/Y1x+fFf6++tc6XBSKkgi7PJc/NzLq9LQMeE/Cyk7QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjP/EYmepEiWPIpcmQeh2Xtfcm5Y2nlggvuGOYchqAD49ItUCB
	eKuuU1Hna/Q9qVhgGtagoHn2hVJ0LZ8mFE5W5ps+S+//tVkQZnZXLPldwI910qQ=
X-Gm-Gg: ASbGncu/i9YfIiP2Yp14F+KPwqoUMXDBrrsDOOjZMHF61ppwK75MU85AKsw5GBc1BW9
	Hd8fnhRCT5u2+6VKh2WSmjYZ0iCmHFRhWzaWICWIOb0/KJgAAeG2iBG4AP8m/jakQ7s806wrlM5
	wOzaUGtISAGmfVj5Y0mqs+ooZ3IDf7EO6/1YU772aKYpyvS7rg6e00cKikz7eYs4Mi5H9ii6RSR
	jzDSrN9CT+oRgpe/yhQyGemKvL4HLqP4SCbl+HDeNFTPl4Fa69PG228Xn1RhtnNzERxChMCukvQ
	1a6ZbHWOhZlRT9JevCn5HyFOPZYrxkImccFuvzWLetgQbg==
X-Google-Smtp-Source: AGHT+IFwcAES82fPdZN2juakD/f3DtxEXqN8fLDByuuUWFv0PrmjGf+tQ1Z8z/EN2hDCjCyy0IsnJg==
X-Received: by 2002:a17:903:2b0f:b0:21f:8453:7484 with SMTP id d9443c01a7336-22428a9d15dmr204592905ad.30.1741619710747;
        Mon, 10 Mar 2025 08:15:10 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:15:10 -0700 (PDT)
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
Subject: [PATCH v3 17/17] RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
Date: Mon, 10 Mar 2025 16:12:24 +0100
Message-ID: <20250310151229.2365992-18-cleger@rivosinc.com>
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

SBI_FWFT_MISALIGNED_DELEG needs hedeleg to be modified to delegate
misaligned load/store exceptions. Save and restore it during CPU
load/put.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kvm/vcpu.c          |  3 +++
 arch/riscv/kvm/vcpu_sbi_fwft.c | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 542747e2c7f5..d98e379945c3 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -646,6 +646,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
 
 	vcpu->cpu = -1;
 
@@ -671,6 +672,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		csr->vstval = nacl_csr_read(nsh, CSR_VSTVAL);
 		csr->hvip = nacl_csr_read(nsh, CSR_HVIP);
 		csr->vsatp = nacl_csr_read(nsh, CSR_VSATP);
+		cfg->hedeleg = nacl_csr_read(nsh, CSR_HEDELEG);
 	} else {
 		csr->vsstatus = csr_read(CSR_VSSTATUS);
 		csr->vsie = csr_read(CSR_VSIE);
@@ -681,6 +683,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		csr->vstval = csr_read(CSR_VSTVAL);
 		csr->hvip = csr_read(CSR_HVIP);
 		csr->vsatp = csr_read(CSR_VSATP);
+		cfg->hedeleg = csr_read(CSR_HEDELEG);
 	}
 }
 
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index cce1e41d5490..756fda1cf2e7 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -14,6 +14,8 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/kvm_vcpu_sbi_fwft.h>
 
+#define MIS_DELEG (BIT_ULL(EXC_LOAD_MISALIGNED) | BIT_ULL(EXC_STORE_MISALIGNED))
+
 struct kvm_sbi_fwft_feature {
 	/**
 	 * @id: Feature ID
@@ -64,7 +66,44 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
 	return false;
 }
 
+static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
+{
+	if (!misaligned_traps_can_delegate())
+		return false;
+
+	return true;
+}
+
+static int kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
+					struct kvm_sbi_fwft_config *conf,
+					unsigned long value)
+{
+	if (value == 1)
+		csr_set(CSR_HEDELEG, MIS_DELEG);
+	else if (value == 0)
+		csr_clear(CSR_HEDELEG, MIS_DELEG);
+	else
+		return SBI_ERR_INVALID_PARAM;
+
+	return SBI_SUCCESS;
+}
+
+static int kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
+					struct kvm_sbi_fwft_config *conf,
+					unsigned long *value)
+{
+	*value = (csr_read(CSR_HEDELEG) & MIS_DELEG) != 0;
+
+	return SBI_SUCCESS;
+}
+
 static const struct kvm_sbi_fwft_feature features[] = {
+	{
+		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
+		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
+		.set = kvm_sbi_fwft_set_misaligned_delegation,
+		.get = kvm_sbi_fwft_get_misaligned_delegation,
+	},
 };
 
 static struct kvm_sbi_fwft_config *
-- 
2.47.2


