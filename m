Return-Path: <linux-kernel+bounces-564754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA9A65A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F07F19A0901
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED142063EB;
	Mon, 17 Mar 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xjlWxnSL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC6205507
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231313; cv=none; b=RP6yFvn22N2aiUYuDFgozje2Hq3wJwaBUBCZmWMXo5psYicxcQ+4HGHJTzUxW03h5g6ZyTWkmobBYDm9JOhO631NgWWYNSznhnYf0q5nvMQp/Ffr35ZPdj7TF423Wt2kayi8byg4nSzVOqYkr7RKkDluSUboEedZrSfVSSxbiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231313; c=relaxed/simple;
	bh=4He7dvOKishM2ucXHkTOK3TfNl17p9VqU9eRpxqFxeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScrObdiPGPNYDr+vSPKRqrVROpOGH5lKPsAJulO8aqRWD5vVWVJgkpbOwWCdiddiaND7aDnz2qPsz2xt4EmvV4FnJMZ+JkoHc5IyHDujOVqwrISxffAphyP3OSBT97GzRBns1CDPW1RcU45V9xB0Y8kl59qkQe9uewZGwGSlH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xjlWxnSL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394036c0efso16189095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231308; x=1742836108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8A8Qnnc9KJsjMpibTJNoHdSMni25LFd1e2ExEX8AcE=;
        b=xjlWxnSLh6PdUsNvp3BNdORMZz3Az9IpPa3hSuX1GcrPNJJw6fi8wrqWDDvbmuTxQg
         nfjiRaRmsYBV2SBZSsPMK0Q9G5RFEfE4VimhCdcAAOgt/yPrBpQKiU5FkNj03B7pLgXY
         ARtTOal2PIyExzpb2OhTVW7rWd98Wm3eO4Lt90+jeH/QJzMDAt9NbwEc/2T9xwkaR08p
         iwNwAOc7bmHoSpP4Uv8bTcAv0NfxwKg/I7AyEQFPwY8wEU44z6ckvvy9/Fj5hDLl4wue
         UhaX+fKRQLFF0EZUkxQFpouH9ZXvns8vXhWYLBMd5yr0AdcJ0RvJpIjj4SObCh1zsIG/
         uwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231308; x=1742836108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8A8Qnnc9KJsjMpibTJNoHdSMni25LFd1e2ExEX8AcE=;
        b=JT0uEhNDq7mEpK4XeOEl3OjuteI2phX/VKJhr3/4ysrXh+fi0OOIhgiO5fV/ast0oP
         BZo5ZO5vzl1lSBLsyAOoHlHliDZ5o4YZE8dTm+Vgybo0pt0nNdINpnM7YBlAEyLcXOfH
         nGS4eDalPe5flemBn64tLz5lowhiclkCuw08JpHGa8Vy7DSXS87cbkw4qAcW9Q8SSulm
         tYHLt9P62TT5ZG7Xokw4G4ouScoocXVT9N2OCgq11mobX51vSDXFC8w4epjIbvqmN99X
         S/8Q1e3nsX6yMLgyHcHKQQvAJ6FpsNdRtHPkE8cpHj/81uxQ+o25nTl9hd1CxfVVCgDR
         2k6w==
X-Forwarded-Encrypted: i=1; AJvYcCV14veBZbpg4+0MCIAfXedcqxU1g/NelWgng7GYV4ueJrPcl9hMHLmts0k6HlhjwfarvFULWzB4k7QEgBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4gZ3+GB/lAE4iqpU1HLmld/AevyZ3qI3u9MGAqJhnxuEyBcj
	TcU+ti1J2b4THmj/W9utstc6ByhPYfTGxVFZ2HWQhvFzRZUvH436WWl7jVe0Y1o=
X-Gm-Gg: ASbGnctspBYOoOaB0dhahWFYk+vV/isKrCZrOnJFivvAqZR3oZEr4JVvSICNzfLaPH0
	GFzlNfexGPL+sUjvFHUCGdFQwy0iosBKxdscXo04tFM2QVKQVxXbHD9A/bXgTDZydNZwLgEQz1j
	mE8bhFop+4mAplq7Ul2ugBP3BHrX7zM9cFXSyVgnRj7CB6VoC84xLKXQebyrgix/Bgpv7jpZTYI
	3LhGMcGdClB6L4+k+BmdTyPyMN8S2/hJ7DSCTXAVhiBz2c9+IyTHT45yaTXtdRP1Zzg/APSunr+
	ySfVX2OqbPEEyMigXPnIIgcDZlh/t/L2IBAmZaJzl1BT7w==
X-Google-Smtp-Source: AGHT+IGdYqlnvEy/PawZt8Sx5CxSE5paeIGe9C/m17bEJMfGQaAbMdJsnw0bGmy+W1Inh7nCACydaQ==
X-Received: by 2002:a05:600c:4f0f:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d1ec8632dmr150023255e9.15.1742231308146;
        Mon, 17 Mar 2025 10:08:28 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:27 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 18/18] RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
Date: Mon, 17 Mar 2025 18:06:24 +0100
Message-ID: <20250317170625.1142870-19-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c          |  3 +++
 arch/riscv/kvm/vcpu_sbi_fwft.c | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

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
index 8a7cfe1fe7a7..b0556d66e775 100644
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
@@ -68,7 +70,41 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
 	return false;
 }
 
+static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
+{
+	return misaligned_traps_can_delegate();
+}
+
+static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
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
+static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
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


