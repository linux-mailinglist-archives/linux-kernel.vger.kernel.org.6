Return-Path: <linux-kernel+bounces-255949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE10A9346F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDD21C22B71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F941C6C;
	Thu, 18 Jul 2024 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brYnvFUP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1C3E467
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274644; cv=none; b=gdd8UZcRRuwJ4cBCEW5mLE/ysrGn/idLq9elTVh88gYd66C9lmXR824UnjogHl+3B8TnZ2d8qmOg+g8OeKkQSZux+2M+AtlL0BoCHVKMDePRGOidFFMMOf8wR7Fx6tKqFrV3afiAt3ccLzBT3h5EOVkDQckvVCYdVpKRDMN2CLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274644; c=relaxed/simple;
	bh=oMFhQ3QxnmOyJFBLq5dfBbQ59iYFLZ5ny16U/t8rmkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFo+V5ylvJdC8QIoi9LZN/KPeA1Jotr85JwjfPZ7WxT1eMZ1lOjFsj2u4amOtJjFxB7wv4DEEAexMHUJHtuWB2K/OFantMr8DbqVAZvHeUadOFsPuY89RWZUUdc+GhgRDZePa4siv9/JL2IwWA231Tj/RAZUK5qkA9lnbW+1KRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brYnvFUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721274641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01+xBiZ/0gp1jFVu1EnU7xZgjeS+cc/9RhAq/NQ3xxQ=;
	b=brYnvFUP9TklM2Xuk76IVSAH9i0vCZWUqHiBFzWNoLueAvYvXIh+VEPMzs4Ds/FbdMImeO
	8dqFHNlIVs+cd3ccegAtJMe/9dtd/5QKtx1KIQXv3zIdg/gXQ/5yk9UjC1Dh0Sn2uLIVqm
	cQyeqRh+M1C+EtzfhFfXL6dMuezttWY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-RhUDsuHeN9aINI0bg63zLA-1; Wed,
 17 Jul 2024 23:50:38 -0400
X-MC-Unique: RhUDsuHeN9aINI0bg63zLA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 354B71955F43;
	Thu, 18 Jul 2024 03:50:36 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FD561955D47;
	Thu, 18 Jul 2024 03:50:33 +0000 (UTC)
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
Subject: [PATCH v4 1/3] KVM: arm64: Disable fields that KVM doesn't know how to handle in ID_AA64PFR1_EL1
Date: Wed, 17 Jul 2024 23:50:14 -0400
Message-Id: <20240718035017.434996-2-shahuang@redhat.com>
In-Reply-To: <20240718035017.434996-1-shahuang@redhat.com>
References: <20240718035017.434996-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

For some of the fields in the ID_AA64PFR1_EL1 register, KVM doesn't know
how to handle them right now. So explicitly disable them in the register
accessor, then those fields value will be masked to 0 even if on the
hardware the field value is 1.

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


