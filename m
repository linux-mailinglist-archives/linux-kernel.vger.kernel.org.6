Return-Path: <linux-kernel+bounces-202570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056158FCE1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFB2810D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD841B29BC;
	Wed,  5 Jun 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TdXZ+kdV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7D198830
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589752; cv=none; b=Nm3BRu7mE8KuAc6RRzDz6MqJ8f2KDkG8Nzg6DkSWCBko6t2iJdUXVqkooIIIEVRiiHNDsnuOh8ItaWXdJkBX5n50B1vgyiPsKrlUK2KoEyRMjrqvXz3+OSh0W+7ojRqZs6ptSi19m8C0uvcnYO6UagZ+vUM24sv+lhYTFkmgqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589752; c=relaxed/simple;
	bh=CRu+PRCiIUbcgK7k+OALzNd3CLHlGYyDDJJ1/w/c3G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IlcVgViUHlQM1mr/H3CG9lmO1mY8hrQPJsPBhVMxxC9clc2ooOAuWOsxJWOcHqOMJuW5p5IvlX2tBGmiYifH6GLFnP7u97XU3dUwlauUUZMZ9pnASdoytgC5WNm48Rhvv8ZSI7iNnlszlDixhfKOFH/02qMdzbvWCPOTKdx+0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TdXZ+kdV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70257104b4dso3371365b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717589750; x=1718194550; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9yGW+vb+251DuCHvQ6eWHokjrDaPZ1CHdh15Wr7+D4=;
        b=TdXZ+kdVAYeqgf6FzrHoOcCipHaldgDwM/fSwuj5BsxAeA3j2UOuE6q55DCelFKbjh
         Lp97yCa0oHXKisVjjsxb5p/4OuM/weATVjS7bJmlCyakg8R/Lq3MELYNB7yfAeo9resh
         EnGTAFRW6KQQIRk6ImmTYvV6l/D1aYljinGQO23JG6qBsxKBoGJHFKwrxQr5ekrIIMcH
         /cTiTVl7HUD9an23rhSAWyXx2BfH3dZAE/JgUdP9M7cBtJKoQ9//GqyQLBJmM6Scf9R0
         UHn9PIgtmTxvPKO2lAm+56eUrk3B4QWgtCSdMpX5rPZ+TZaIw8yonyS1h8sXXh6I9+Ri
         IuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589750; x=1718194550;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9yGW+vb+251DuCHvQ6eWHokjrDaPZ1CHdh15Wr7+D4=;
        b=ZOKFGOoYCLTvXzYRen3bE3QiWAxsRx5qGhkSngvhgV850LY6usXxKbC+qmZJAj2+7+
         rbzulO77Yn+RgTrZOTttBuRlvWao7gAfdlJzwrZV+QxeiztnOcrk64ycSWIcSPElZZ8K
         Z/H2kKl3kIAQWgXU9Iw4PRnVQECRSeidI2wiDJeQT257gH9QyMgG1gDxctGfdwC0hRlF
         MHJcFIXXJeUqPXad//1vaa1hDYss9v2qYZoqW0u1ZI/BBrFjpmDJVanF9DOWX/KXvnc4
         i+XmkQqRLa3xCZ9lv10BM/EtmPSk7VZyVRR66Z7PdVqWbwDhJlaoFNlyy/UYHLSYkBDM
         gHNg==
X-Gm-Message-State: AOJu0YzWgH4STmnJTlvI104SRyHTGJsc8WJGXHW/a4sfAIPGoQfVOhp2
	6Cpw70JqgpID6XgToUcoaoMvEZRAECfCKuytgOO3D4ykROYqN5PZrgBwG2kdRUyPjnq/W/OrioC
	LpTMt9k5en+ysONP4SE3YsG3vbIlPpZ1YQd/a5D+4r0XEnzpMeG/TUwOtWq+ec/yHzRpAR5tsKb
	C9D7MCinoPYGObd/NS3r8gYFcu5plmwVPm4CPY7b3larT/PNDQcjZb5A==
X-Google-Smtp-Source: AGHT+IHuMhXVgloS9T7u/eogW1nwS9cEhCJiBxA9pyATWrWX01kMIqq28iggOkL5AgJrH0kuilEjvg==
X-Received: by 2002:a05:6a00:18a0:b0:6e6:98bf:7b62 with SMTP id d2e1a72fcca58-703e594abe7mr2644243b3a.8.1717589749923;
        Wed, 05 Jun 2024 05:15:49 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703ee672fb3sm885379b3a.216.2024.06.05.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:15:49 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: apatel@ventanamicro.com,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v5 3/4] RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
Date: Wed,  5 Jun 2024 20:15:09 +0800
Message-Id: <20240605121512.32083-4-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605121512.32083-1-yongxuan.wang@sifive.com>
References: <20240605121512.32083-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We extend the KVM ISA extension ONE_REG interface to allow VMM tools to
detect and enable Svade and Svadu extensions for Guest/VM. Since the
henvcfg.ADUE is read-only zero if the menvcfg.ADUE is zero, the Svadu
extension is available for Guest/VM only when arch_has_hw_pte_young()
is true.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu.c             | 6 ++++++
 arch/riscv/kvm/vcpu_onereg.c      | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e878e7cc3978..a5e0c35d7e9a 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -168,6 +168,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_SSCOFPMF,
+	KVM_RISCV_ISA_EXT_SVADE,
+	KVM_RISCV_ISA_EXT_SVADU,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 17e21df36cc1..21edd60c4756 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -540,6 +540,12 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
 	if (riscv_isa_extension_available(isa, ZICBOZ))
 		cfg->henvcfg |= ENVCFG_CBZE;
 
+	if (riscv_isa_extension_available(isa, SVADU))
+		cfg->henvcfg |= ENVCFG_ADUE;
+
+	if (riscv_isa_extension_available(isa, SVADE))
+		cfg->henvcfg &= ~ENVCFG_ADUE;
+
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
 		cfg->hstateen0 |= SMSTATEEN0_HSENVCFG;
 		if (riscv_isa_extension_available(isa, SSAIA))
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index c676275ea0a0..06e930f1e206 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -15,6 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/kvm_vcpu_vector.h>
+#include <asm/pgtable.h>
 #include <asm/vector.h>
 
 #define KVM_RISCV_BASE_ISA_MASK		GENMASK(25, 0)
@@ -38,6 +39,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SSAIA),
 	KVM_ISA_EXT_ARR(SSCOFPMF),
 	KVM_ISA_EXT_ARR(SSTC),
+	KVM_ISA_EXT_ARR(SVADE),
+	KVM_ISA_EXT_ARR(SVADU),
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
 	KVM_ISA_EXT_ARR(SVPBMT),
@@ -105,6 +108,9 @@ static bool kvm_riscv_vcpu_isa_enable_allowed(unsigned long ext)
 		return __riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSAIA);
 	case KVM_RISCV_ISA_EXT_V:
 		return riscv_v_vstate_ctrl_user_allowed();
+	case KVM_RISCV_ISA_EXT_SVADU:
+		/* The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero. */
+		return arch_has_hw_pte_young();
 	default:
 		break;
 	}
-- 
2.17.1


