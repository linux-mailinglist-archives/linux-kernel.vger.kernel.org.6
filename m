Return-Path: <linux-kernel+bounces-210830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CEB904910
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5720B21727
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175B208CE;
	Wed, 12 Jun 2024 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLXnRXNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26C14AB4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159778; cv=none; b=OvXJf/cKmUCi5/IJEh4QvsElCNg1nBQdx4Mc6DfL8tZ47G0dANrCBGJPUoOj/QidalthLuGj6xVeviYywJUJx4qlt2i3HKfC0F28lHrCgxyesiJFKMfkhS2MsnwoBrgRfzqvsVplHktB0OuuJzIEKVaLk//TcGNvefWL5YlPct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159778; c=relaxed/simple;
	bh=clWISYVP+y4RIgSGIBJSTDnPvfKxZ6zB5K37+T0yH4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIkziR6sBk5FM7gAO3MQwVMgmZwlohYSqQ80DKy6BIqZhNgqg6oeVnDRghQUzHO7NM3Ai5zcExOa4UZO0lg1aljmJMspWXOi/tGA6/c+u/LvEJybx+RliQVYjVfjVc77PQLUDZydoeTpkyisWOUC0qqchOE3Bz/H03moBdoTp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLXnRXNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718159775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Skhula7518PMXu1UZDnu+UyfH0UgWPzNpluBrfVr+JQ=;
	b=QLXnRXNwDII0UirK0DmqQXRvljBxfTOHqkSmC9YEqJ0Lj/ll7lDqjmAozkwigZRfKPXUnt
	MCc81Rqfm/tnTXMUtOU0DF5Vu5UJ9T1MLDXn1UP2LbPV3kwoJ3m8xK0wLITRPzbpBFtG4a
	UsqNfRYvosHEQ082QSVpJ+TF/Wumopk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-5a8JObh9M8incYscAze6kQ-1; Tue,
 11 Jun 2024 22:36:08 -0400
X-MC-Unique: 5a8JObh9M8incYscAze6kQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0564C19560AB;
	Wed, 12 Jun 2024 02:36:06 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E96719560AF;
	Wed, 12 Jun 2024 02:36:03 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
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
Subject: [RFC PATCH v1 1/2] KVM: arm64: Allow BT field in ID_AA64PFR1_EL1 writable
Date: Tue, 11 Jun 2024 22:35:51 -0400
Message-Id: <20240612023553.127813-2-shahuang@redhat.com>
In-Reply-To: <20240612023553.127813-1-shahuang@redhat.com>
References: <20240612023553.127813-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When migrating from MtCollins to AmpereOne, the BT field value in
ID_AA64PFR1_EL1 register is different and not writable. This causes
the migration to fail.

The BT field means Branch Target Identification mechanism support in
AArch64 state. The value 0 means BT is not implemented, the value 1
means BT is implemented.

On MtCollins(Migration Src), the BT value is 0.
On AmpereOne(Migration Dst), the BT value is 1.

As it defined in the ftr_id_aa64dfr0, the samller value is safe. So if
we make the BT field writable, on the AmpereOne(Migration Dst) the BT
field will be overrided with value 0.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
But there is a question, the ARM DDI mentions from Armv8.5, the only
permitted value is 0b01. Do you guys know if there are any consequence
if the userspace write value 0b0 into this field? Or we should restrict
that at some level, like in VMM or kernel level?
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c9f4f387155f..8e0ea62e14e1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2292,7 +2292,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_GIC |
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
-	ID_SANITISED(ID_AA64PFR1_EL1),
+	ID_WRITABLE(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_BT),
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
-- 
2.40.1


