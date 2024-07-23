Return-Path: <linux-kernel+bounces-259693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783A939BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394FE1C21B19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67D214B954;
	Tue, 23 Jul 2024 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbhsj/9S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32E14B086
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719226; cv=none; b=Z4HxEi+2TyYSGrpwSj47FiBwTp+YM9kkM65ypAAotH7s4gGIY/xkmDGfHulgh11aGQ+Y9cy1rd3DZu+0QxUdyySCN2ecjTrXbwEZGbhurfYOXos9o4FlY8eXQJsIn0XwMqkMD7FPeZsAQtvxi/lAJ00ivofNwsLGOAbgLIB2Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719226; c=relaxed/simple;
	bh=uhRsYbCA0NHQbeKMtZ1HldKAz1j/cFiV4RW46nKzz9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p429Rm1UCQ9E5ECFX9WnjVtq3Vx6njD76Lh+/SEplfoF9lNPrysT2gYKL0QUMNU04LoZl4cSteThdAyiyEzAY+lYeEerEjuMXxFUWupZCnNkbV5QkFi+praoDXK8Cw00meuHHhlF31nKl/D/T169dmS5xPcwbjt+iqgljY/L0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbhsj/9S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721719223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEFLN3C1npdDEFSgLdjRte39ulWAdAjqQadHX/VuSxs=;
	b=hbhsj/9SqxuyBEcHUQ4Uph9Rk3KT3ROEIEGeL6P62ytoxs9ryFP6GvYAn3BKEv+KWXC30o
	uwLri2AqzXJlDLc7nqzciZ0pekkxJhZLSfDSMzFhnL3h/vhQ3Zm8gFKPhjPHY5dRsIZ3QX
	Dy9bR0nE5WGf8MWDiZRil/dRRCIAbB4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-I4BTyTP9ORiWisyCchxL_g-1; Tue,
 23 Jul 2024 03:20:19 -0400
X-MC-Unique: I4BTyTP9ORiWisyCchxL_g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A246419560A2;
	Tue, 23 Jul 2024 07:20:16 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B0E21955E70;
	Tue, 23 Jul 2024 07:20:13 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev,
	Mark Brown <broonie@kernel.org>
Cc: Eric Auger <eauger@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] KVM: arm64: Disable fields that KVM doesn't know how to handle in ID_AA64PFR1_EL1
Date: Tue, 23 Jul 2024 03:20:00 -0400
Message-Id: <20240723072004.1470688-2-shahuang@redhat.com>
In-Reply-To: <20240723072004.1470688-1-shahuang@redhat.com>
References: <20240723072004.1470688-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

For some of the fields in the ID_AA64PFR1_EL1 register, KVM doesn't know
how to handle them right now. So explicitly disable them in the register
accessor, then those fields value will be masked to 0 even if on the
hardware the field value is 1. This is safe because from a UAPI point of
view that read_sanitised_ftr_reg() doesn't yet return a nonzero value
for any of those fields.

This will benifit the migration if the host and VM have different values
when restoring a VM.

Those fields include RNDR_trap, NMI, MTE_frac, GCS, THE, MTEX, DF2, PFAR.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22b45a15d068..4508288b9d38 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1531,6 +1531,14 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
 
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_GCS);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_THE);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTEX);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_DF2);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_PFAR);
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
-- 
2.40.1


