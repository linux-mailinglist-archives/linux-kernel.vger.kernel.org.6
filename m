Return-Path: <linux-kernel+bounces-289144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E0954266
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062301C2346D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4DE136E23;
	Fri, 16 Aug 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3fUmAGb9"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490B129E93
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792128; cv=none; b=ofu8Jzt33WcGNsclSvDyLEgscPRIN2l+PbXWhW+SGJAh9EuomGygq3Ckzo8igMKr7szodSNti2AxitEi89noITnLqBaqWYLoa4OHFnAkgSKPbf29XiPksoONb1RmXweuX1J9oCQP34GLZrc3LBEAHpa3UDz0mjoarmQRAy78Kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792128; c=relaxed/simple;
	bh=CZ69ixTJ13HXS+S3ulrEg8gSIWyr0fCR/AmVgmn5v7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbLMpJwk/4oCZrZrKqI3/Tt56z28+YjIH6EwsUAeJF3alR+9rX5CxZ6Q50tKX6c+xFBnyxTLIpcF9Jruhgz7cIIfCY8GBLhmHKG1F+e8lzW61jJ0m3is/Tz821TCDr1MtvjMzzf0m2Bwsv4E1+InFnElHFdKAh8WVDvRQaKdljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3fUmAGb9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1813645b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723792125; x=1724396925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pw60AMQmDUGOq7sBB5Z5rKu5bDKRw5A77nRIXJhY5Ak=;
        b=3fUmAGb94wUm7RJckuykwdufiwHQK90BN9qEXO1t2LZt/56F/r++zN7K1CvbC4mOUO
         yIksmgzh2frMgoGX97VXS7Kb9rstHOZjWkp0rnxHS8s1fv8isnDAoj46GhfbionvJVlD
         3NbxVt8yWVvfnqRcNbCmxjxmEMVpzC6PoBYHe97P7MEj7eMntjVRnLaLSI81zJfrLgNM
         c5ewS60AlkglnAmEug5DiWYvpZ70OBx3vb6GnUYlCLd+Kvw4fPtIambPNxoUzLZ3ZgIv
         ZFsjUa2k1DV7nol4DSq83i9LhpWLQWFy5CJ73haZJ5sdcQ9YuJuLIXPTANVpoQ+X3ZIq
         I5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792125; x=1724396925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw60AMQmDUGOq7sBB5Z5rKu5bDKRw5A77nRIXJhY5Ak=;
        b=E/xtVG9hAd54S5eavGb+Rsp77kRFlQKobYsFivxOaC8ixq0IW1sf4g1VZhlqhVxwFY
         egygp77fzTx/DrQQ7NP5BHMQf6ih416aPcu0DLNegDo51SwO4xPcsyxWxExtaYVuAVqX
         Fh/mUAPwezqhu/ksFiUgJuHeaBdviYIexBk8lpx811IncW23jwngB0CbUYH3bz4Z/zDD
         kBx7jyTLR+R7wcmAVil8xEaY2HY//Mlgs0TkQ9/z7VMOCM/gwkp3ehAMUVp3yVwuq/WK
         3QZK2XJL6LtxjFck68VVoyBIqq1IiZwdF5MP2F+urwwDzv2u1koaw6B2k/S2wnVGiITm
         Ws/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhO1pOS6GtllglTF3QTr5YUmtK9CNqYdYz84/uQAEbZ1RWvNc2Uvpn991fL+k7p4wVhrz9x9yY6j2WrgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kjAka4nAYfDRAJhHjg0qBwUT/UrA46D9hl+dQeGSeZ3pImFz
	entelnaw4n53TLu709Fx8ZpDrOfUXKj/wa84lElW0gd6U/IhhDaMynoi8DMB46KAiVPybADm/Ma
	S
X-Google-Smtp-Source: AGHT+IGfPiFtzcHt7xqywSUtWik5isvNee8OUxNOoMhtzMTbtl8SwHVtQ2tadLTbV6ViRAikB2BvDQ==
X-Received: by 2002:a05:6a20:244b:b0:1c8:aa88:f10a with SMTP id adf61e73a8af0-1c8f85f45e0mr7807946637.10.1723792125575;
        Fri, 16 Aug 2024 00:08:45 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b636bcabsm2293792a12.90.2024.08.16.00.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:08:45 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 16 Aug 2024 00:08:09 -0700
Subject: [PATCH 2/2] RISC-V: KVM: Fix to allow hpmcounter31 from the guest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-kvm_pmu_fixes-v1-2-cdfce386dd93@rivosinc.com>
References: <20240816-kvm_pmu_fixes-v1-0-cdfce386dd93@rivosinc.com>
In-Reply-To: <20240816-kvm_pmu_fixes-v1-0-cdfce386dd93@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The csr_fun defines a count parameter which defines the total number
CSRs emulated in KVM starting from the base. This value should be
equal to total number of counters possible for trap/emulation (32).

Fixes: a9ac6c37521f ("RISC-V: KVM: Implement trap & emulate for hpmcounters")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index c309daa2d75a..1d85b6617508 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -65,11 +65,11 @@ struct kvm_pmu {
 
 #if defined(CONFIG_32BIT)
 #define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
-{.base = CSR_CYCLEH,	.count = 31,	.func = kvm_riscv_vcpu_pmu_read_hpm }, \
-{.base = CSR_CYCLE,	.count = 31,	.func = kvm_riscv_vcpu_pmu_read_hpm },
+{.base = CSR_CYCLEH,	.count = 32,	.func = kvm_riscv_vcpu_pmu_read_hpm }, \
+{.base = CSR_CYCLE,	.count = 32,	.func = kvm_riscv_vcpu_pmu_read_hpm },
 #else
 #define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
-{.base = CSR_CYCLE,	.count = 31,	.func = kvm_riscv_vcpu_pmu_read_hpm },
+{.base = CSR_CYCLE,	.count = 32,	.func = kvm_riscv_vcpu_pmu_read_hpm },
 #endif
 
 int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, unsigned long fid);

-- 
2.34.1


