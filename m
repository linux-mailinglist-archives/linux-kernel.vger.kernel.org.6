Return-Path: <linux-kernel+bounces-519871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0F6A3A2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3058D3A3112
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5726B0AF;
	Tue, 18 Feb 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghT2sY0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF01B6D18
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896564; cv=none; b=Jrc3qMWJSHsD6NFN2Jrvl10H1+WIeqymjS9IIiulv3zKYfdbsWGr4zPAWN2beJ/WzPPtD+NA7p8AapE4xNcKSHWC2ZzlElBKGDQY75MXjaYWr3/MVDxMoAS6ruX4bsZwqCeF1z7XmYz4RpOBy/WMmYN+0NcuOQ9EJHNVsoY4OaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896564; c=relaxed/simple;
	bh=kI8f+ZCKDCxxkN6vwc72VPsmzF9WcnNXHOsT35Jb1nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abmsQc8wNEXO2wPGbI+53RhXe5l+0AWD3PlEv/TRGRVgGe0DRp902vYpoOlpscCQglk5Xox0+M/Ig45LrOvFftRgE6L24Qjq1dxZLR+JQ/Rdobw4VL5432KIp+anh3eGz8lew7lJcPEwcSMAfJcbFVn9TmZZzV1/Y8krfoVrra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghT2sY0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeQXcS3pEHXKPjpS1aBvSo5HEPQatvaCcC9yZ+tXu5k=;
	b=ghT2sY0fQdwA20BCjKW1pqtun8pUwWt4hnVNwJc+fPD9D7LcMVrXs7qoozD6cziBHdf83O
	pBo5Mdb9CS4iC1rmREVzmkleTCXgDFagMt+x63U3nslVgNIUGYRj/BA0QNsST9E0mSNCfP
	3zGdpYnc9YJncmQakJApIwHU8oVwOIE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-fe5DnT7sPAGC36alDfQumQ-1; Tue, 18 Feb 2025 11:34:49 -0500
X-MC-Unique: fe5DnT7sPAGC36alDfQumQ-1
X-Mimecast-MFC-AGG-ID: fe5DnT7sPAGC36alDfQumQ_1739896488
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so30269725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896488; x=1740501288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeQXcS3pEHXKPjpS1aBvSo5HEPQatvaCcC9yZ+tXu5k=;
        b=N6X7PjW+aEAK+M8QN6T1tvTy8WGbvmVX/hT6V6rjVIzwE7h9rXUfcvbxLKPqdtNV0e
         F7tpT01kTx48qrKn+aRBpfVSoKB97febaGll/NUXJp1mON0TnzkN/pgxbg4hizNf7CEv
         ueM1nctE97neHpOfgYTUaWjtfklkrYIpEeB6QaEENXQuKz4gvDRik98qzfWMKnPCKUF6
         kCN4j0nTE+QMcYXxBPrqDGtkXcv3njualR478hkcyPKzueBkc4wN4mAg2RKfPw8W6zND
         nM1b9bRYnM+QnegPRA2aCPLOZwWlg4Btys8gramoB8oOx1k5AaxUh/wYQ+Iur4EGiiuA
         psow==
X-Forwarded-Encrypted: i=1; AJvYcCVg5vPPAZKm7+w+rRdz5EPW+BeEzizCCpNgMAGUHT+EMfU69puRelKuAypMh4+Xpa4i89a50QodfuH27ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfI+qyCRKxyDS3qkHeQ2E29RZWVIpjbJeGNrvOLhDuk1kA36mB
	bDljd4n1US2G5mg5teB1isUbxjXKVe9qo/R195MChK6iPe2uBEoh2eQgKA8OzvGEHgxg8ceuiGh
	BJpyg/It56f4IZXw3kcOrb2aUfkuP3SIqpS02q5wuCarC/HQhUgf7hkOSTOarUQ==
X-Gm-Gg: ASbGncv1B8lq4bfBuotNf69LEKRSvlLBzeaNZGP++IeOTeTtezBwLuLDj51bsZjKx+c
	9z+trWlh58ESbe7BX+h60g9gPwDkPEl2tCZFGy2Z6x6C+EmqqIkm6pfFnGWeRq/O/EnPxDJwKdM
	hefvH5cu/rJagAamRB8NLiMWEb6pjjaUhufrSNZH1irnhWJnfxJQLMcSymDTdMRkqpFmwaCJv1P
	fIfr1825kLiU4wNO4qaxVKpZ8K96XWSHMpBjjWtOf/Ir5lzu0vleLEEa1pxhu3jDrdEr3R8a1P6
	Pd2UVsb+bQvqnuX/3yDo+R4fyazR3UfL2uQ3I4htqpBXOiY2GunWksYwMQyhQM+hsa/t
X-Received: by 2002:a05:600c:1c86:b0:439:9863:e876 with SMTP id 5b1f17b1804b1-4399863e985mr12624665e9.24.1739896488297;
        Tue, 18 Feb 2025 08:34:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhjzSey7Os9gD/9cBHHf8QXaWprjYC5klxAlQo6nfv7hgprgS0BPQtKhe2iSIdbXKsawM7OA==
X-Received: by 2002:a05:600c:1c86:b0:439:9863:e876 with SMTP id 5b1f17b1804b1-4399863e985mr12624455e9.24.1739896487978;
        Tue, 18 Feb 2025 08:34:47 -0800 (PST)
Received: from rh.redhat.com (p200300f6af0e4d00dda53016e366575f.dip0.t-ipconnect.de. [2003:f6:af0e:4d00:dda5:3016:e366:575f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm85091845e9.0.2025.02.18.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:34:46 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] KVM: arm64: Allow userspace to change REVIDR_EL1
Date: Tue, 18 Feb 2025 17:34:41 +0100
Message-ID: <20250218163443.32836-3-sebott@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218163443.32836-1-sebott@redhat.com>
References: <20250218163443.32836-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable VMMs to write REVIDR_EL1 by treating it as a VM ID register.
Trap guest access of REVIDR_EL1 when the VMs value differs from hardware.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/sys_regs.c         | 11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3db8c773339e..c8fba4111b77 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -374,6 +374,7 @@ struct kvm_arch {
 	u64 id_regs[KVM_ARM_ID_REG_NUM];
 
 	u64 midr_el1;
+	u64 revidr_el1;
 	u64 ctr_el0;
 
 	/* Masks for VNCR-backed and general EL2 sysregs */
@@ -1472,6 +1473,8 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 		return &ka->id_regs[IDREG_IDX(reg)];
 	case SYS_MIDR_EL1:
 		return &ka->midr_el1;
+	case SYS_REVIDR_EL1:
+		return &ka->revidr_el1;
 	case SYS_CTR_EL0:
 		return &ka->ctr_el0;
 	default:
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3cd4dfdd287a..c12fd91574ab 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1666,7 +1666,8 @@ static bool is_feature_id_reg(u32 encoding)
  */
 static inline bool is_vm_ftr_id_reg(u32 id)
 {
-	if (id == SYS_CTR_EL0 || id == SYS_MIDR_EL1)
+	if (id == SYS_CTR_EL0 || id == SYS_MIDR_EL1 ||
+	    id == SYS_REVIDR_EL1)
 		return true;
 
 	return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
@@ -2528,6 +2529,7 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
 	}
 
 FUNCTION_RESET(midr_el1)
+FUNCTION_RESET(revidr_el1)
 
 
 /*
@@ -2581,6 +2583,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ ID_DESC(MIDR_EL1), .set_user = set_id_reg_non_ftr, .visibility = id_visibility,
 	  .reset = reset_midr_el1, .val = GENMASK_ULL(31, 0) },
 	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
+	{ ID_DESC(REVIDR_EL1), .set_user = set_id_reg_non_ftr, .visibility = id_visibility,
+	  .reset = reset_revidr_el1, .val = -1ULL },
 
 	/*
 	 * ID regs: all ID_SANITISED() entries here must have corresponding
@@ -4632,12 +4636,10 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
 		return ((struct sys_reg_desc *)r)->val;			\
 	}
 
-FUNCTION_INVARIANT(revidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
-	{ SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
 	{ SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
 };
 
@@ -4985,6 +4987,9 @@ static void vcpu_set_hcr(struct kvm_vcpu *vcpu)
 	else
 		vcpu->arch.hcr_el2 |= HCR_TID2;
 
+	if (kvm_read_vm_id_reg(kvm, SYS_REVIDR_EL1) != read_sysreg(REVIDR_EL1))
+		vcpu->arch.hcr_el2 |= HCR_TID1;
+
 	if (vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
 
-- 
2.42.0


