Return-Path: <linux-kernel+bounces-517180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89EA37D66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58637A3A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33751AAA10;
	Mon, 17 Feb 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dBElo0Sp"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E41A83E6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781915; cv=none; b=n19EBLelx8vV14DuH+FBmt+Focpxe236Hf9syk2ZeM4KuzcNHIB4tKEg4d9WIselG5dTxn36CMZD8V2X4X61XE+Pbk6IjS6AO5BdqSxi+1jUzhD+6jEU5YbdEQ4Z8yeAR8dGoGXDLVG0uROy/oZ0W1XEG+im3Hvy7rV9+6E0l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781915; c=relaxed/simple;
	bh=QoNKwm0QNeOBdMCU6xE83bRH5pRe22ZWzqS6Q+iNQVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5NdnxSidMluFUsIXPT2VaedJoTFipaZL9YDmSqR5wkByy3bqjq/kYVZUacSJfYKju5sbgBnAa+d4QCAfcUANrvUErhcfRrsYHEaHloZTqfS5W6q7yjow1biuNN3+iumF2Malh8W1ys3k0eESRnwQuCUfF4VBXdr1KhLqlrW5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dBElo0Sp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2276175f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739781912; x=1740386712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ3VO18adCEYhhZu71Kqt+W1Lctj7LPPm0C4PWap/Pc=;
        b=dBElo0Sp4C7qWDmXAnCqqCNvTMgnvRre1PgYs/YrLAtnvySNLhwrSJZInnRGkQJLUP
         W0SskwmSjW26EaYVtk0VHvJ/bM9e0XY2VMUlUAPeps3KXn04RBmHxAXR8b2ZmOkR2b3U
         4WqpGQ5PrecGob4EaoMH+wLoOMZtuBdYM0iaVDLy30MVS2yGS5/o5K5tmQND5B6McvJW
         o+PZn5wyMs0WWhqYMuO54TXTauAzDLaXIkRWEwIIUWSs4BpZR7ogVA9M0mIwmiO8+/D9
         A1x+eseCUL/jIJD2akcBNqyteNrMsAThv3VjFFPeOeR4YpZMWdbwMi8dmoPu0CuyVe4y
         Hpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781912; x=1740386712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ3VO18adCEYhhZu71Kqt+W1Lctj7LPPm0C4PWap/Pc=;
        b=sB+pICcOVpSZOoxwlhYb5+HfB/xpTCHs+HGG66Z29QaDtCQjgn+qxgNeaNQaG4eLbp
         uRb+l3SwAy5UDzjX9BI9+s5jg/DL8q32qwAFhXYgh9SHBHtgx8jOzkON0W+Ziux4WSaV
         u8xh6n7fxlZ9b/BSRXC4I2o4uIEoZf1dRMrC/TFT1nYUAQJlvyFVJhQHdYv9zt1WHDBe
         qc2fD6RuPZh3wcfXoZIylT+XkpuhIixgDNee0fuo+IFUegYJcpPUWZRbQlkkE+S7qPZf
         kNGXQ31G3adhdFMB5aBKbNN4MlDtEgxQv+bp1o7MBrqBDVS+SEJQVahE1GxweCZmWuFc
         LZPg==
X-Forwarded-Encrypted: i=1; AJvYcCVwtVogfS4kIeMh+XZtkFLjp3HR2LRqzjKh18wGKvtt0wu8ljZ9JkjnIMUrEJuZwrzMhYiiPXW0ATQR08Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMB/Dv1fTXgtSjKKwYwh+DVczrzcaVE9HnHPejupQqmL94P/8
	sOQ4kYGMQwhvtsMC/0WGX4RM9WVm9RpDBTc0qbAvaJ6d0wlwF6U0dQMmkM2fXEs=
X-Gm-Gg: ASbGncseT2lSPiWL0QrRdMqTtDraSpYiLXeEEayDD6dHLECTkfVYSY/nX4WZruUmLgU
	8nZ1gkRKdefPVKWEbaFZlicF5RHVzMhvkBZO0jrw2K/3IPihzSQVj7ZmfKlWL+Qv9CEoo/gIz51
	WQc0Wu7xmevMCBYCdJMqXCfe1VTz2m4MkdFxy3/fXIJqryjv4wzSz9VLDYLUpELXHDs0d491g0N
	uLNF3pM84oHaXxtGba9RPQdi3DWIuB1l4tEUvtMtltKmNdNfklvomanwzd5IMHUmR023clHlIz8
	RrA=
X-Google-Smtp-Source: AGHT+IFjCjQDRbtQRRPY7ND3UbrR6FOcJiCBfSPf1KsHHS/VGqmXJkoBgEpraPdPyIlzSWNaqsOAIg==
X-Received: by 2002:a05:6000:1548:b0:38f:4251:597b with SMTP id ffacd0b85a97d-38f42515b99mr2778376f8f.8.1739781911976;
        Mon, 17 Feb 2025 00:45:11 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fe1efsm11711548f8f.97.2025.02.17.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:45:11 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com
Subject: [PATCH 3/5] riscv: KVM: Fix SBI IPI error generation
Date: Mon, 17 Feb 2025 09:45:10 +0100
Message-ID: <20250217084506.18763-10-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217084506.18763-7-ajones@ventanamicro.com>
References: <20250217084506.18763-7-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an invalid function ID of an SBI extension is used we should
return not-supported, not invalid-param. Also, when we see that at
least one hartid constructed from the base and mask parameters is
invalid, then we should return invalid-param. Finally, rather than
relying on overflowing a left shift to result in zero and then using
that zero in a condition which [correctly] skips sending an IPI (but
loops unnecessarily), explicitly check for overflow and exit the loop
immediately.

Fixes: 5f862df5585c ("RISC-V: KVM: Add v0.1 replacement SBI extensions defined in v0.2")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_replace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 9c2ab3dfa93a..74e3a38c6a29 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -51,9 +51,10 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
 	unsigned long hmask = cp->a0;
 	unsigned long hbase = cp->a1;
+	unsigned long hart_bit = 0, sentmask = 0;
 
 	if (cp->a6 != SBI_EXT_IPI_SEND_IPI) {
-		retdata->err_val = SBI_ERR_INVALID_PARAM;
+		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 		return 0;
 	}
 
@@ -62,15 +63,23 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		if (hbase != -1UL) {
 			if (tmp->vcpu_id < hbase)
 				continue;
-			if (!(hmask & (1UL << (tmp->vcpu_id - hbase))))
+			hart_bit = tmp->vcpu_id - hbase;
+			if (hart_bit >= __riscv_xlen)
+				goto done;
+			if (!(hmask & (1UL << hart_bit)))
 				continue;
 		}
 		ret = kvm_riscv_vcpu_set_interrupt(tmp, IRQ_VS_SOFT);
 		if (ret < 0)
 			break;
+		sentmask |= 1UL << hart_bit;
 		kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
 	}
 
+done:
+	if (hbase != -1UL && (hmask ^ sentmask))
+		retdata->err_val = SBI_ERR_INVALID_PARAM;
+
 	return ret;
 }
 
-- 
2.48.1


