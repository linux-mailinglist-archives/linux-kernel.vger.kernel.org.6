Return-Path: <linux-kernel+bounces-250575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B0B92F941
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1AD1F22B53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8416A957;
	Fri, 12 Jul 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fl09nFMz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715715FA66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782230; cv=none; b=CtgZcX+JLu+rVMP0fs3649lQoMaVTDBCWmB9u1a+CggKuG8/ajgY9suqC3ZoBqUtdhLRWNEzxPaMyHk6yowaIp+08Gziw+NNclHWkZbHHxJC2RsdlBA/dXwagb2rxnPzngr3sFLCZnK9fIvBLMuWNvjbAjrOQkVo8IVCftf5r8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782230; c=relaxed/simple;
	bh=dLBBaMqHPPQsYGXel7Tg/y3cknFXfDOZMFogS4bCL30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf5H5zbO/e5Y9h08G0M0ujan8rwxA4uoN1I7DqkfBF2Ifdg3aCRcNEgxWeltLOsJOKjrqxEmxLdEBFa54BZ1IJO/ZCoJIN0vTav1YpSeHaJPXuoTv8ufyL3ReWs0yvrGmB9PbAGywhadcGWOCKoInIsJYB4DRk8zIq0VreEHBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fl09nFMz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720782227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xAST+V6lWXBsnEaGTLUMH67LdmttdDtWSOQgal7aQQ=;
	b=fl09nFMz0m/iK5a+qpblsgugVTnT/DC50bU8CMwGLMpFRu+7sTEOkQQrq51NawNFsl8unM
	R6Zo48YsIJ8p4Q3r7w2PywZ2o2KMXo6O3F9Mmr9s+yMj5J5oXhBQlIjPMZAJdlhT8j/fPW
	MDrw2m4v/dPaR6CcPvdAGIRNVN0Zf7M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-l3g6O4n_NuymK5JRXtSUBQ-1; Fri, 12 Jul 2024 07:03:46 -0400
X-MC-Unique: l3g6O4n_NuymK5JRXtSUBQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79f0283223eso244761685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720782225; x=1721387025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xAST+V6lWXBsnEaGTLUMH67LdmttdDtWSOQgal7aQQ=;
        b=SQuOYVLhMchgiQPU4rFGXtrqlVgZ6Xtez4tOz3MLj2cBBSvG8+Q+iVg/nK8AkM4NvD
         FV5Dja0uu0LufYj/RXKRjhvnRk4EZMBS1Y3AiG7BYZNyqt2RCRl+ez1a3oNdnMybEZmE
         MfIDeufekhV9d1G0BsYDXSbpbrTOPWoa0tVx48dldGJWvyklG2EIugGgeF5bv/DgAcyd
         QxHSN7cLUDwA0wBUSV4/zqtfg9rp5jRgezy00XXeQKdSjQz1gd+90O+YHxudWIk4SrgE
         nxmldq2gvwW8MtKjbI4ghXsDeGqbwjKGGEVPJp9wPksZYYmBXATBG5lXIKAuBZBLbYgX
         /6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUUZa+ucNm08FOE+HhaF3M4N9YcOFW9VVlUGLIvH8LLhBMFvblsmnWEhWuHL2IJ+onjoi3xSZrhg7ebCrynVs9rdRpt/ZD3VZawEDfT
X-Gm-Message-State: AOJu0Yw+1GoqnW1sMNlH7hxiII/dUiKOLDGWdeNrmcrm4qhlEX3n4I9e
	Cz6GQx2nr9J1+n1PKzohSgQMykBzNUUI9Zt9M4Fm6S4wJ/KsdXEqfHKi/hffdbpfZvJs/d49tKg
	QoaGh4o3Uy0gPLZLpxgYdhuHanQ0yE00iOmHoMKewcBWrneOLc6yks9qyHxm92A==
X-Received: by 2002:a05:620a:909:b0:79e:f850:e4de with SMTP id af79cd13be357-79f1991b083mr1092096485a.0.1720782225622;
        Fri, 12 Jul 2024 04:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRtK3var3gfeKJIjD1DbrBau/cSSmMTHNiKReqsoRwrLr/R+k8zDdqm587bqmZ6Jq9LLcrog==
X-Received: by 2002:a05:620a:909:b0:79e:f850:e4de with SMTP id af79cd13be357-79f1991b083mr1092094585a.0.1720782225283;
        Fri, 12 Jul 2024 04:03:45 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff834csm390498685a.5.2024.07.12.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:03:44 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/3] KVM: arm64: fix kdoc warnings in W=1 builds
Date: Fri, 12 Jul 2024 13:03:31 +0200
Message-ID: <20240712110332.10970-3-sebott@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712110332.10970-1-sebott@redhat.com>
References: <20240712110332.10970-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kdoc warnings by adding missing function parameter
descriptions or by conversion to a normal comment.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/arm.c             |  1 +
 arch/arm64/kvm/vgic/vgic-irqfd.c |  7 ++++---
 arch/arm64/kvm/vgic/vgic-its.c   | 18 +++++++++++-------
 arch/arm64/kvm/vgic/vgic-v3.c    |  2 +-
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c818818398a5..2cbc23dd554d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -164,6 +164,7 @@ static int kvm_arm_default_max_vcpus(void)
 /**
  * kvm_arch_init_vm - initializes a VM data structure
  * @kvm:	pointer to the KVM struct
+ * @type:	kvm device type
  */
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index 8c711deb25aa..c314c016659a 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -9,7 +9,7 @@
 #include <kvm/arm_vgic.h>
 #include "vgic.h"
 
-/**
+/*
  * vgic_irqfd_set_irq: inject the IRQ corresponding to the
  * irqchip routing entry
  *
@@ -75,7 +75,8 @@ static void kvm_populate_msi(struct kvm_kernel_irq_routing_entry *e,
 	msi->flags = e->msi.flags;
 	msi->devid = e->msi.devid;
 }
-/**
+
+/*
  * kvm_set_msi: inject the MSI corresponding to the
  * MSI routing entry
  *
@@ -98,7 +99,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	return vgic_its_inject_msi(kvm, &msi);
 }
 
-/**
+/*
  * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
  */
 int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 40bb43f20bf3..ba945ba78cc7 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2040,6 +2040,7 @@ typedef int (*entry_fn_t)(struct vgic_its *its, u32 id, void *entry,
  * @start_id: the ID of the first entry in the table
  * (non zero for 2d level tables)
  * @fn: function to apply on each entry
+ * @opaque: pointer to opaque data
  *
  * Return: < 0 on error, 0 if last element was identified, 1 otherwise
  * (the last element may not be found on second level tables)
@@ -2079,7 +2080,7 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 	return 1;
 }
 
-/**
+/*
  * vgic_its_save_ite - Save an interrupt translation entry at @gpa
  */
 static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
@@ -2099,6 +2100,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 
 /**
  * vgic_its_restore_ite - restore an interrupt translation entry
+ *
+ * @its: its handle
  * @event_id: id used for indexing
  * @ptr: pointer to the ITE entry
  * @opaque: pointer to the its_device
@@ -2231,6 +2234,7 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
  * @its: ITS handle
  * @dev: ITS device
  * @ptr: GPA
+ * @dte_esz: device table entry size
  */
 static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 			     gpa_t ptr, int dte_esz)
@@ -2313,7 +2317,7 @@ static int vgic_its_device_cmp(void *priv, const struct list_head *a,
 		return 1;
 }
 
-/**
+/*
  * vgic_its_save_device_tables - Save the device table and all ITT
  * into guest RAM
  *
@@ -2386,7 +2390,7 @@ static int handle_l1_dte(struct vgic_its *its, u32 id, void *addr,
 	return ret;
 }
 
-/**
+/*
  * vgic_its_restore_device_tables - Restore the device table and all ITT
  * from guest RAM to internal data structs
  */
@@ -2478,7 +2482,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
 	return 1;
 }
 
-/**
+/*
  * vgic_its_save_collection_table - Save the collection table into
  * guest RAM
  */
@@ -2518,7 +2522,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
 	return ret;
 }
 
-/**
+/*
  * vgic_its_restore_collection_table - reads the collection table
  * in guest memory and restores the ITS internal state. Requires the
  * BASER registers to be restored before.
@@ -2556,7 +2560,7 @@ static int vgic_its_restore_collection_table(struct vgic_its *its)
 	return ret;
 }
 
-/**
+/*
  * vgic_its_save_tables_v0 - Save the ITS tables into guest ARM
  * according to v0 ABI
  */
@@ -2571,7 +2575,7 @@ static int vgic_its_save_tables_v0(struct vgic_its *its)
 	return vgic_its_save_collection_table(its);
 }
 
-/**
+/*
  * vgic_its_restore_tables_v0 - Restore the ITS tables from guest RAM
  * to internal data structs according to V0 ABI
  *
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index ed6e412cd74b..3eecdd2f4b8f 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -370,7 +370,7 @@ static void map_all_vpes(struct kvm *kvm)
 						dist->its_vm.vpes[i]->irq));
 }
 
-/**
+/*
  * vgic_v3_save_pending_tables - Save the pending tables into guest RAM
  * kvm lock and all vcpu lock must be held
  */
-- 
2.42.0


