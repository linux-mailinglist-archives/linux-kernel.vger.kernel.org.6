Return-Path: <linux-kernel+bounces-305974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D6963748
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6290B247AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8E1B949;
	Thu, 29 Aug 2024 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VfiSCjzu"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C212D766
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893330; cv=none; b=ijW9qifIvRUAEcb1Ha+EZ8LK98U+izSDc/GR0AnfOxjb36ee6GWZE8W4u0gk/I27QJw4Rhulbjr6itrQ4FtacYZ7LtXMaab0GAoCecWfkTfbCWHwQxfhgyhtkcfoFy5C5jZiMPrj/M7Ex9g1WvCINqx2Ykgoyn8a50Frlb3cGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893330; c=relaxed/simple;
	bh=FTANMXx9niaisfK+aQOXv+t1NRHVUzMLkPl/sK5KrN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmAkkhOvcAF7Wd+hZ8L2xk07ucIi/k6ZpYPF9PGRclokCyzG73FxRUuJWnjR5ApQD0UcYPiq8KcVf6RXCYO5jPVO/hWouMUmuNgJ4ZihLzazInsdn7y/x1nj1NBfkW7dIzrFZbazzrEQ03iZfT8tWI+ngF1cbk3uopLkSxtehNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VfiSCjzu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71446fefddfso106620b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893329; x=1725498129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVeUN5Mn4knmfhlWREJV6zJkPuiqFserRZxouOs1BJI=;
        b=VfiSCjzuwhvb4Zr591fzQqVeOyP2asgXO4s2l0vzl9CJQnPgZBrJg2aXPRD1QHKn63
         e3tyGJzQNUWi5+DtPCmqhflejxz/AYqgJ5aWoF6kMFjvBAP8jVu+gH7zx3P6zWiPk+sp
         OO5yIFliWuHTgnbenuN7yWUgjFZNPx+SF5jaBW9r8/xqUpG6KhYnqfEmd09EmlYKBbZk
         dvb6nCeZLkthdHZpGOKtJVo9TAXIa74evM1cMZrbWiExTsxmKRmq+cJF6jdV5JNFGfMC
         sDd7/vniF75iV0I8lHhsIj0wUpesjILpm9G5U3komg8L0Ms8XLj49ZzlqXUsO6spVOvq
         ygsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893329; x=1725498129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVeUN5Mn4knmfhlWREJV6zJkPuiqFserRZxouOs1BJI=;
        b=oQzIIrSKiD2Y2zE1stfEUUWyWh+ll9qYOxNO0inw+krBWllM9tfrpc1SF7rKUQsIcs
         tWUCbi4/YayPxHRqdSYfL6gN3TG5m0gTQj67RLi8YogQWuGfaBWt9sTuvRf/oN8Ngqkf
         PDePWsJvW7dQwbOMkBYXqGwLo5VVgE7s6kLHto8mGiTKMK5Hiaq+YzNgU1KRG/NzKkGp
         aCpuU6/0geLKod7wLK469XMj/9oMgbJ8Amx5R3OtJxygIjl+KMCtzio4AnI/m0lpCoxW
         538sqzOcLKKasqzmdk/WRn3t8ZmKRUZznX9om1/1ntu1utlv4jz7OMfBf33EvOazPwtx
         7fog==
X-Forwarded-Encrypted: i=1; AJvYcCVtTI4+Rd3zoAfghcbX3+f9EV5q1Vu2D0/mjz0nGyMxMC0xIdrDmkuceCoIlBkloaRPGLA48TeB7GNdrGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1q+F4Epv5YS7tYS+cWx/lIVx40EkD+BzkbF2k1FxUFPX77nv
	GA0PMOx0pL1yQOWKymEMGR5XMfwK9+YUil6o0A7qRVt5Kz9yyeKsOgVcgoq5oCGmVzydBh9Zsdd
	b
X-Google-Smtp-Source: AGHT+IE20Iz5wZXTitHFQF8jSuAcL+G/x9Gpo+1x4hS8Jq+hDLNQBGiIr2r+fj9xMkWCy+9sL14ZDA==
X-Received: by 2002:a05:6a21:e94:b0:1c0:f315:ec7e with SMTP id adf61e73a8af0-1cce101e3eamr1074001637.28.1724893328672;
        Wed, 28 Aug 2024 18:02:08 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:02:08 -0700 (PDT)
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
Subject: [PATCH v4 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
Date: Wed, 28 Aug 2024 18:01:31 -0700
Message-ID: <20240829010151.2813377-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240829010151.2813377-1-samuel.holland@sifive.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
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

(no changes since v2)

Changes in v2:
 - New patch for v2

 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu_onereg.c      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e97db3296456..4f24201376b1 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -175,6 +175,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_ZAWRS,
+	KVM_RISCV_ISA_EXT_SMNPM,
+	KVM_RISCV_ISA_EXT_SSNPM,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index b319c4c13c54..6f833ec2344a 100644
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
@@ -129,6 +131,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_M:
 	/* There is not architectural config bit to disable sscofpmf completely */
 	case KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_RISCV_ISA_EXT_SSNPM:
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
-- 
2.45.1


