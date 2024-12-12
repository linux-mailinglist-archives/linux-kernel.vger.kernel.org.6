Return-Path: <linux-kernel+bounces-443928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18E9EFDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D9164A31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9341D435F;
	Thu, 12 Dec 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d+Q8SSrs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DA1AF0B4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037022; cv=none; b=lpiE7SezSeCAFIJvd8Wgr5mfDILMxkPdM3nWZQzTltNu+qjBCT6ho9i7tI+xx+zzvedBpXpAP7XNcPrj6hBHiDIquAn559eJMCCZyuWlebbNUFTtqXgzeMk+ytslV/lSOeR0jpHSttj9HVrkY6I5uNjM3KM9+YXPbP3ZrqUAjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037022; c=relaxed/simple;
	bh=aB7frMBfUTuHgeG2iqJQRR7h5YH7OQziiHAZLJcCY3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulGm3E7rLSKaIP4uM5qtEW1gpzrmOaKxexGeOVD00gX3/+LQ2QFfPiuP1iaJkbdqLnKoo1T4QRIUzrzU7+MMzro7iq+MtxKDyLTZ3pXysnRZD7GIe6Flb9rDQqiE0G87m9NGDtTCZ11K0+l9lf7E2JCyyTWgajsb7bM+j7N42b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d+Q8SSrs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166360285dso10425015ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734037020; x=1734641820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaPMD+BdCyI5hLi3/kV/S6HLELSeYS1h2xBFfdAEcTQ=;
        b=d+Q8SSrsINXoShh+rKMAzeMdQY1OXx2224FD6ttzuoN81TfnIiUkbd2SalstFDhMrg
         vhVMAosz+DXP4dFkEXQqq2zJyhEseFgAoqS/fKP2aJKwwKsjIq5PEdLs5yuDw9Ru63S8
         AQvkPfUbnfpXSCO0dyevNW74nHrWYWKQ2e0pfGKJMem0zLd+ip8pOk+Ay+wzjqi9fmyr
         CsGaSxK3S0IT5P200d7+8oYCKY7nxYVUzFq4OCAWAYp8pOkZPSbXbgSYx4XsGi6/GMn7
         LUbeMntVtq3le9xl6/4f2QmZ+4DzxK8Ia06XC5gg66vptQbmGgVBrPvTplTBAAO9zTik
         tNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734037020; x=1734641820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaPMD+BdCyI5hLi3/kV/S6HLELSeYS1h2xBFfdAEcTQ=;
        b=ilvuSnWJkpANmj2SrRMSadRnrsK/fg3yRoA3ywACPuarz9sPHdcS3ay80zxzWtqIdo
         bHcNeY2dSCOlf5LgMQD6niIwEBoIqNAPq6TQrKEhMffSq8mzvmnay3NKqS2AWCp9iNps
         r2J5LzenfoWdu2WJ3gA1ho88YKg82cFeO/Bbossxer8wM/tyFMuQ6iORey0aj0LkuBHI
         vDOuDlif7uDA2Ot9TXwGB7P0HTWjdKyyiHkVAdVm7s+dNdSj1Z8CSxeKtWRMbSrF3xHt
         lqXtFJMN200wA1SpUCRy75W1WMaziktLj7IHIjapVwraqTnJEMwXISIqQOHYuJ1RvEjS
         sdFA==
X-Forwarded-Encrypted: i=1; AJvYcCXCYKpqOTqCfU0YiuZrPMLz3UjsPjXxVlC0v4dyhORNGk/oJtkrES4HaDXYm+2ZzWD6GzEkPHr8/NsFb98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ajz10sNHCkVeMWuNqyiGISC6azn6NR3HXzaWOhCYN6emoYsR
	oEr6DejN8XYA2Wx3ZX7rdC4slaCvpFLKdWa/yOHTHroYY1R4fFLaQAcsPx1wlWI=
X-Gm-Gg: ASbGncvHGp4xQEZYOx3tPS/1IZetKWKYpXiXIXv0NawRMI/M4aFosuW7FYnjK73Okgp
	hbGitCQHkCoSYpO67LPhuMIGjOpcIRhOaMu6nz05Z2XpBdlrZEw0Hut7KoqLOLpGRRVaiS/QgxY
	H6tasaT72LAByGSNCEXQdx+mfXB6rl8mbRBhG0aj4sl6OfPs5D2IjEzD6fSEH8xptK5v7CS2Vq6
	spuez0BkVMwbEEYtz2NYS3vcoL5EfwzyVpSehhU0St8Phhe8FHFCl0qqyXnPETJGA2oMA==
X-Google-Smtp-Source: AGHT+IGLXA772pUTt0BVGAPXfaZJ5WaJQ7JivmCyvoMmFNjKdV2TZP6t/5GpHJeWN5LeMnNdr4yhBA==
X-Received: by 2002:a17:902:f908:b0:216:69ca:7714 with SMTP id d9443c01a7336-21892980b8dmr2076045ad.11.1734037020131;
        Thu, 12 Dec 2024 12:57:00 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e53798asm94019785ad.60.2024.12.12.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:56:59 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 12 Dec 2024 12:56:55 -0800
Subject: [PATCH 2/3] RISC-V: KVM: Update firmware counters for various
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-kvm_guest_stat-v1-2-d1a6d0c862d5@rivosinc.com>
References: <20241212-kvm_guest_stat-v1-0-d1a6d0c862d5@rivosinc.com>
In-Reply-To: <20241212-kvm_guest_stat-v1-0-d1a6d0c862d5@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

SBI PMU specification defines few firmware counters which can be
used by the guests to collect the statstics about various traps
occurred in the host.

Update these counters whenever a corresponding trap is taken

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_exit.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index c9f8b2094554..acdcd619797e 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -165,6 +165,17 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 	vcpu->arch.guest_context.sstatus |= SR_SPP;
 }
 
+static inline int vcpu_redirect(struct kvm_vcpu *vcpu, struct kvm_cpu_trap *trap)
+{
+	int ret = -EFAULT;
+
+	if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV) {
+		kvm_riscv_vcpu_trap_redirect(vcpu, trap);
+		ret = 1;
+	}
+	return ret;
+}
+
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to userspace.
@@ -183,15 +194,27 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	switch (trap->scause) {
 	case EXC_INST_ILLEGAL:
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ILLEGAL_INSN);
+		ret = vcpu_redirect(vcpu, trap);
+		break;
 	case EXC_LOAD_MISALIGNED:
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_MISALIGNED_LOAD);
+		ret = vcpu_redirect(vcpu, trap);
+		break;
 	case EXC_STORE_MISALIGNED:
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_MISALIGNED_STORE);
+		ret = vcpu_redirect(vcpu, trap);
+		break;
 	case EXC_LOAD_ACCESS:
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_LOAD);
+		ret = vcpu_redirect(vcpu, trap);
+		break;
 	case EXC_STORE_ACCESS:
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_STORE);
+		ret = vcpu_redirect(vcpu, trap);
+		break;
 	case EXC_INST_ACCESS:
-		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV) {
-			kvm_riscv_vcpu_trap_redirect(vcpu, trap);
-			ret = 1;
-		}
+		ret = vcpu_redirect(vcpu, trap);
 		break;
 	case EXC_VIRTUAL_INST_FAULT:
 		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)

-- 
2.34.1


