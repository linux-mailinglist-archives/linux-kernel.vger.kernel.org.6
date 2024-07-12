Return-Path: <linux-kernel+bounces-250574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DD92F93C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B095BB237B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB915F407;
	Fri, 12 Jul 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZvQEFXA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051AD15ECC6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782227; cv=none; b=Zb0elXDt02ORRBMimi5Jv/OHu+CYp/Guc2UzENFqYFcNyAAV3JLj3yrhU6g2JsSZoGf2YV11+wtmlmEfkscu35dragcyhSleAwgn4vugUBGChhKPI5zyJx5Z3itLksUacDCftclP4wSl/d2BHdEeNM+SRC77wR/I5FmJ/Jgmqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782227; c=relaxed/simple;
	bh=ukDXw37dhq+dYuSOWjdciN0yQwOu+nqVZTB9iN2+Ls4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW57Q4lL9W1c2JfZ0kVYjFLizjcnsxFD7E0X9E1MfGy7lHLfsAkjllBNX6m0izWSCMgrdxWvQIsu+imaJ1+XnWUY0T3Sygm6wew1uoAu09lKNz+T2REVLnwSbGDEKS2YFRmE1QLHsWTHKE3wNqYu/wRWbAGEQTzVSCBADuOBMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZvQEFXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720782225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veUUGt+GBKRUflAP/4u3UadYVzXIYYKM+vDLIvIs2Yc=;
	b=IZvQEFXAaS9RkhLBqbNJSTm0SHl+N/VVgGEqKfY67SVb9GvOUPvf8dDEzJfyDt3VAVFO18
	9vPpyoE5UvdAHf+VlDU2sl+uy+X8mf2i0dwgyv0L9MguC4rWFCc6/pqQXGrybVVyrtQlOd
	VA4J3GyGbll5CwWLnYBQZNqXNsi/G9E=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-1c-q5B2RNa2t4E10s6wEXw-1; Fri, 12 Jul 2024 07:03:44 -0400
X-MC-Unique: 1c-q5B2RNa2t4E10s6wEXw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d1c48fafe4so1291394b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720782222; x=1721387022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veUUGt+GBKRUflAP/4u3UadYVzXIYYKM+vDLIvIs2Yc=;
        b=Yn6DytkNC7Qtur3pqmPhg718ojO7kklnH3ImmWz0BRqiC1nG7lNoCFU4zWtJo2dcEh
         CRau3PO7GUt4kj9uwsUj/HEA1rM91yNxdtNWmkL9e33CQ/ha3O6zFqLV5qgGEbb4P0vC
         nTwUKrY0LteY0on7MJGTjs0IZcxnoGUJdePkT7M93FvYIW23O+FIdPqxPesGK506+nSY
         ktYeYbWIbT8DpS7Ck7Ff/8cXnD4uW0u60FtSiqZE5nRVB52WqCNWqAsn+H7PptNxzvX2
         dDrObB4vf8SV1No3uJzXci9QAtnOARIIfgQOF0gNIZelsCcNmPuVwXC/yFIICR3b9DSd
         JuPw==
X-Forwarded-Encrypted: i=1; AJvYcCVkl4377hUlSWw0KAewGU5+6V9i2f8l6PMhgUBbdjnHZntkxUUSeHB3BqggoIv6XN0jzUsVdfV8TMoMwSFLOtkQdswpKM/81XmEETDA
X-Gm-Message-State: AOJu0YxP0X1RPwHncdKVRjyehjdvX5eFj6Al75o2dHcBPMe1/RTLNocg
	oHaAZJqSADRgcnzU5qIkH+hxZh3+w58tWMEQp6yooL4wR7r5+31UYaqw8lK28lWvVysUDkoX/h6
	Q37+5NKdyxcWgm5GV5f5SAYJmgikDg5qawj+Fb01fdlPRcgRmjyAnxm/JAnJOGgTob7cm9Q==
X-Received: by 2002:a05:6808:1451:b0:3d6:2fb8:2905 with SMTP id 5614622812f47-3d93c08ccc9mr12087097b6e.42.1720782222495;
        Fri, 12 Jul 2024 04:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaYoe9jS++ITWpl1K24bjqJ7Ih4Tcqa5GejquSQMQtKX8znz1DvmZfOWT4pcFyOh59vOw1Ew==
X-Received: by 2002:a05:6808:1451:b0:3d6:2fb8:2905 with SMTP id 5614622812f47-3d93c08ccc9mr12087065b6e.42.1720782222096;
        Fri, 12 Jul 2024 04:03:42 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff834csm390498685a.5.2024.07.12.04.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:03:41 -0700 (PDT)
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
Subject: [PATCH 1/3] KVM: arm64: fix override-init warnings in W=1 builds
Date: Fri, 12 Jul 2024 13:03:30 +0200
Message-ID: <20240712110332.10970-2-sebott@redhat.com>
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

Remove double initializations in cases where that's easily possible
- like extra NULL initialization in static global structures. In the
other cases just silence -Woverride-init.

To fix warnings like the following:
arch/arm64/kvm/hyp/vhe/switch.c:271:43: warning: initialized field overwritten [-Woverride-init]
  271 |         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/handle_exit.c     | 5 +++++
 arch/arm64/kvm/hyp/nvhe/switch.c | 6 ++----
 arch/arm64/kvm/hyp/vhe/switch.c  | 3 +--
 arch/arm64/kvm/sys_regs.c        | 5 +++++
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index d7c2990e7c9e..2c049746657c 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -291,6 +291,9 @@ static int handle_svc(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+__diag_push();
+__diag_ignore_all("-Woverride-init", "Allow field overrides in exit_handlers");
+
 static exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
@@ -319,6 +322,8 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_PAC]	= kvm_handle_ptrauth,
 };
 
+__diag_pop();
+
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 {
 	u64 esr = kvm_vcpu_get_esr(vcpu);
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6af179c6356d..bf49afc01542 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -200,8 +200,7 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 	}
 }
 
-static const exit_handler_fn hyp_exit_handlers[] = {
-	[0 ... ESR_ELx_EC_MAX]		= NULL,
+static const exit_handler_fn hyp_exit_handlers[ESR_ELx_EC_MAX + 1] = {
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
@@ -212,8 +211,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
 };
 
-static const exit_handler_fn pvm_exit_handlers[] = {
-	[0 ... ESR_ELx_EC_MAX]		= NULL,
+static const exit_handler_fn pvm_exit_handlers[ESR_ELx_EC_MAX + 1] = {
 	[ESR_ELx_EC_SYS64]		= kvm_handle_pvm_sys64,
 	[ESR_ELx_EC_SVE]		= kvm_handle_pvm_restricted,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 77010b76c150..4e4ff2bd51c9 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -415,8 +415,7 @@ static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return kvm_hyp_handle_sysreg(vcpu, exit_code);
 }
 
-static const exit_handler_fn hyp_exit_handlers[] = {
-	[0 ... ESR_ELx_EC_MAX]		= NULL,
+static const exit_handler_fn hyp_exit_handlers[ESR_ELx_EC_MAX + 1] = {
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg_vhe,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c90324060436..00fb6f1e9a48 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2255,6 +2255,9 @@ static bool access_zcr_el2(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+__diag_push();
+__diag_ignore_all("-Woverride-init", "Allow field overrides in sys_reg_descs");
+
 /*
  * Architected system registers.
  * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
@@ -2803,6 +2806,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	EL2_REG(SP_EL2, NULL, reset_unknown, 0),
 };
 
+__diag_pop();
+
 static bool kvm_supported_tlbi_s12_op(struct kvm_vcpu *vpcu, u32 instr)
 {
 	struct kvm *kvm = vpcu->kvm;
-- 
2.42.0


