Return-Path: <linux-kernel+bounces-229714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1D917313
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932611C22C36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B4183073;
	Tue, 25 Jun 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CH3nGo70"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FF181CE0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349793; cv=none; b=Yd0tY1TrlG1xO4X/VESPe3/JZaNXm1RMCwrbrg0/vot5k3LhHVoy9h9m2FSF9Pq1Y/8Vz5ZsgfMzRL1omVKRlKysDRVRJKfHoQgWyzDgmzCRE6CXBMupWcuiSMO6rd1OD+91oyucRbGAQcEaQXgdgEOmGntG9AEqGleh1LL2itY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349793; c=relaxed/simple;
	bh=PI7B36y2IeGPu8CBf2Gu5A2WliKssIxixDQxXVVUuDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDGe50xLXhSBhCqP1uVfLqxPzWXlIA5LGAQBZbht7WhVZ0J1qkx0JZW19bd1slyTjG1wOjvCfTFp/qzibyxanphW7zlWqj+A2YSPkGjjjjaZPb91Ivn59ZSJfa57+gWe8KMJBcD3pJeSDcJKEFu/dU77CFFNedIVFQJm64FG8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CH3nGo70; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9b364faddso49242665ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349791; x=1719954591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmS6vWk00EfafKWbKkl85gc2oDZFAwwt7tuzVTWTGwo=;
        b=CH3nGo70CA3nxi/p1XOqc/btLvxIVraRNZIT2qMvRFRLNed7N3CfEhs/hvNInYomPO
         wwRuAqMTnPaVqKXtsR3wt6fCzLfWgJsAi4UWElwolIDOda7y96aMhRH/inQ6kWryR+zW
         z0yesFjTEKvLlQQDM7u6Ue3sjG8ZbA7p9ayJzWAvv5k6/vx4gCzWdMKWUDPCnA6gEU0h
         YxdFEtC9SNes72ZikfsXUpwKaQu6riYL43xfm4YQBK1sWjM7/d4zLJhVj2NGsXRWD17w
         tatVoiRfWgAcDSddk4U0k3neSpBUfVHLAt7zhYKDoH9AThbMgUI/e/fkGdsA+jp+mRFV
         SfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349791; x=1719954591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmS6vWk00EfafKWbKkl85gc2oDZFAwwt7tuzVTWTGwo=;
        b=PnXTjyFp+J5BY6+ppIAidTXygTTIXLDBi+mbaJhJmjAoWdYFqb6Dzyos/wd9rbR9NN
         AbtGYQtltODMIypLgfTJvNZICzQp0bl4SUkacGLpfdCPJ6xI0meONPug4Mkm3P78Rvbl
         aQ2a3hIA9oXP0SLUAsIJUjEc7lLR9NzlV9i8cazKxRupiAQBAL2WrvTHGRbtPGym9GtJ
         j51+PXUjon9R20LlllRInpnKvYGarAXt0wLuFS9607C+VdAvrfFcpYrCPGeU1fDeHOBG
         KvDK5Yj+RvF1yJpt52OTR5lplaxHXERClaiD1FP/SPimNOg5WXRE9mDtjSQDblvKhWEX
         FvnA==
X-Forwarded-Encrypted: i=1; AJvYcCWC/bPmdR1FRxuao8wiawaynoEK02xAf09U02vYK5bfEH3zx5iMr4pHO8O11E8qMCE1ANLW1PLjuaBsNrtCh6eyz/OCaZ+p+7FG6t41
X-Gm-Message-State: AOJu0YzxTt7FwrPU4w5ias4WUuLmT+wYjPBTGZg4l6jpN3Vg1JEgTi3W
	s82sE/VxXb0b4+owVkAAylms1RhB16KG4dM7HDjb9wTqio5TKYhPu0sCY/FrFX4=
X-Google-Smtp-Source: AGHT+IHTw5qN2SpgPrcqrPEXyzhXThDZldXGwPxQ/Q1c/gHxKEx75NLlZ00CvfUvOupr2aJXM+dfMw==
X-Received: by 2002:a17:903:32ce:b0:1f9:e95b:5810 with SMTP id d9443c01a7336-1fa24082313mr90605365ad.53.1719349791487;
        Tue, 25 Jun 2024 14:09:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:51 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
Date: Tue, 25 Jun 2024 14:09:20 -0700
Message-ID: <20240625210933.1620802-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240625210933.1620802-1-samuel.holland@sifive.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interface for controlling pointer masking in VS-mode is henvcfg.PMM,
which is part of the Ssnpm extension, even though pointer masking in
HS-mode is provided by the Smnpm extension. As a result, emulating Smnpm
in the guest requires (only) Ssnpm on the host.

Since the guest configures Smnpm through the SBI Firmware Features
interface, the extension can be disabled by failing the SBI call. Ssnpm
cannot be disabled without intercepting writes to the senvcfg CSR.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu_onereg.c      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e878e7cc3978..eda2a54c93e3 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -168,6 +168,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_SSCOFPMF,
+	KVM_RISCV_ISA_EXT_SMNPM,
+	KVM_RISCV_ISA_EXT_SSNPM,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index c676275ea0a0..71c6541d7070 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -34,9 +34,11 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
 	[KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
 	/* Multi letter extensions (alphabetically sorted) */
+	[KVM_RISCV_ISA_EXT_SMNPM] = RISCV_ISA_EXT_SSNPM,
 	KVM_ISA_EXT_ARR(SMSTATEEN),
 	KVM_ISA_EXT_ARR(SSAIA),
 	KVM_ISA_EXT_ARR(SSCOFPMF),
+	KVM_ISA_EXT_ARR(SSNPM),
 	KVM_ISA_EXT_ARR(SSTC),
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
@@ -122,6 +124,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_M:
 	/* There is not architectural config bit to disable sscofpmf completely */
 	case KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_RISCV_ISA_EXT_SSNPM:
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
-- 
2.44.1


