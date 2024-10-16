Return-Path: <linux-kernel+bounces-368720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E379A13F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A303280EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982921A6E2;
	Wed, 16 Oct 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q+R3q3Yk"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE5218331
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110516; cv=none; b=WtqPnuAAaeH9BhTjLvT8f9A2aFQO4wLOwGcbl+D3KNsgDTv5d14YNFg076lx0lT+blu/jKCQ0DnfeVhdKAN+1pxZKEkyvTzTJQXZTwhvkxVikrCMsFJWsTfsmYLQvdu2kejEnjexKsIVRCgpUWekNp6yjo/2r4C4mYFxTn49m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110516; c=relaxed/simple;
	bh=WEXFA6nYI8AcdN86jF1gE6DwkQveVeLPsBkK9MprTG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSn77n8GRBB8EIkezS0UH/M1oWG7Yqzko25j4BS1RoFpL0N6o3xphB0lZb98+oshPlcrChYOWuzjfxy7aHdDEk2e1v1vIHDO8+/jX5DjDTLe+iBaq+PQyHwdjbwK766ZXmwOkTJzI/tKGgUQUIW4IqSkp/aI0T/5P28sYaKquLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q+R3q3Yk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so173778a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110513; x=1729715313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8qp+tseh4bMUHTaD+Myf/jjkdJffKFnGUeOTquYIl8=;
        b=Q+R3q3YkcI0xLUvZqfMSx4BKAUF+JWhjv0oCrgpwCH+XYiCJXny7jgXkr7Uo6Lw7Ay
         SmQXdTg0+FWVdiDyh3D8GlGn4V/Ezd8lCml1YJQNL2CWJLVUju2OetR7t5P6LQA4T2Zm
         SMnSfXTl98qKMDR2mhEg4AjVp2bQdQcS9sUdnJrl/yF4APsQo8nMoeJEe0KXbRDnDR1J
         2VfmsnnGFAG+uX+pmSGCR6lHgWBs0bNWDvbchC24v9Zg0q4S/iS4ZCjzF1KytWQ541yT
         A3xuxHZfI5LPDtWt5ZLIpCjDr5Wot+cep3Op0+gyrswV9HA7yCD4/8eId8jFPJ05rTCa
         FXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110513; x=1729715313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8qp+tseh4bMUHTaD+Myf/jjkdJffKFnGUeOTquYIl8=;
        b=Vsf/61v7KJRV+QWs37OZWQxBM1tRKKQrTSP63AdFM4SAsMSJGFkGKtntAAp9hdqMEe
         AmSPH7CqLlb16L7QGQzFu+yBqvgfh8I8JJVlpcSepANXNJtg9f6KQBMwOrIumtFBXuum
         RJnrqh4om8cAzQaUvmLO+gCok2a236a1QjUz0gd69IOLWNP53UmFqV/NvKG0dQhEspGF
         tbfXMJOqVIDOe6omazi1X2KKMYXe1W5UwADLoj5dYe7trj8aiHhEBBmwsJOYcICeqHvH
         OQ/RtAYxGIflNV8QQG8lgBYBSiTmXwpJCMhqXWBCM4EOShVWs9yVsjR883lQyRy0bg9P
         eeAg==
X-Forwarded-Encrypted: i=1; AJvYcCXGOkZ3kH+vGtcC2jRUxSMN09bvHVowurLC0fYeJmzVtdEJLWcjxo3IKpOlos9lA78z/YeTGMDWwzoZb+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiskpCxZXjTtUrEaM7LthUVLbzbKROIjlGo3mUlKdftbKuKy6n
	9XvAEkfhEqmJazZm+tl9nvXINWy+F3HBtZeNl3DFYBM4Oj8O0+T7SUujboBZzUE=
X-Google-Smtp-Source: AGHT+IGt9EJhWPb2QUdkiIkAH1GPre203CbDhO3HM7OqUiVLzcm8QmSQg0UHLFTAJE4hx0loBwaHQg==
X-Received: by 2002:a17:90b:617:b0:2e2:991c:d7a6 with SMTP id 98e67ed59e1d1-2e3152eb736mr19638942a91.19.1729110513399;
        Wed, 16 Oct 2024 13:28:33 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:32 -0700 (PDT)
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
Subject: [PATCH v5 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
Date: Wed, 16 Oct 2024 13:27:50 -0700
Message-ID: <20241016202814.4061541-10-samuel.holland@sifive.com>
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

The interface for controlling pointer masking in VS-mode is henvcfg.PMM,
which is part of the Ssnpm extension, even though pointer masking in
HS-mode is provided by the Smnpm extension. As a result, emulating Smnpm
in the guest requires (only) Ssnpm on the host.

The guest configures Smnpm through the SBI Firmware Features extension,
which KVM does not yet implement, so currently the ISA extension has no
visible effect on the guest, and thus it cannot be disabled. Ssnpm is
configured using the senvcfg CSR within the guest, so that extension
cannot be hidden from the guest without intercepting writes to the CSR.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Do not allow Smnpm to be disabled, as suggested by Anup

Changes in v2:
 - New patch for v2

 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu_onereg.c      | 4 ++++
 2 files changed, 6 insertions(+)

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
index b319c4c13c54..5b68490ad9b7 100644
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
@@ -127,8 +129,10 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_C:
 	case KVM_RISCV_ISA_EXT_I:
 	case KVM_RISCV_ISA_EXT_M:
+	case KVM_RISCV_ISA_EXT_SMNPM:
 	/* There is not architectural config bit to disable sscofpmf completely */
 	case KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_RISCV_ISA_EXT_SSNPM:
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
-- 
2.45.1


