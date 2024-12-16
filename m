Return-Path: <linux-kernel+bounces-447882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609869F3844
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9065A16C87B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941220CCF2;
	Mon, 16 Dec 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqOHSezX"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8754207E16
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371905; cv=none; b=CByqn7PGzUuBDOZ31W28Y70vkm6PXEEwCkc8nF418ARCUqGTp8wse/jvLiel88p5IiBUlf3oC09CS7ua8ocpu2iESl7z8n/PuF3CmO3o5u0KiID0UXeC64qEW4kekA+aTMJDmdMiP1NrE4phkp1hyMMlM0khofH29SX38A5W2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371905; c=relaxed/simple;
	bh=3XHMTTobse3q0dEwknl/B4DvUFVndatcPNdmNVk4PtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ikerUxOAAuQNFn60beIVi9mUDKNxPyDESrStG2DMzLGMf9J3Ywv+/YwgsiSmrLaO7re4jwnpC3ZcyUxcqrFC5Scgv1kVDohllcqsEL54ayR1gxhf7kPVy0/Ov53bodGVFeWtlRKYHbW4oZNW1A0br1WOkhQeRs+zcb3g0dZ/58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AqOHSezX; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso337418466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371902; x=1734976702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdcyBmRiYnupt5usNoa8YsTNzt1V3OCJZIqsaCSd/iY=;
        b=AqOHSezXX+lreDw14OvGmpGfaMzg+7oGK2suDC6PPL6WdzI7d1llGZXu+LIHTMTfgw
         lZA8vADxHiZrxgVeE2M+GVlVgIFrZkCdFI1or3qo2SnOXsV5lAZeRq6N4s4T0aD5IqlH
         IEY3dcZdwRUktMzFU/UcpCFiPtPYuxukJTqmByJXGilSHwjHgza1fM8fFKbM+XT6PYki
         0wPPK9wJxFFWnO+1t/4RvTyVrCREdxm29qPR+H0gQXw1DuheKV5OntDZXab+8LzeXrIz
         3FabWSIIbwKEEb4/4Oq3q/wPajaSdMpLCh3T9ytE+DtWPm4omqrt+kEZlSNHBnR9sDu8
         98Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371902; x=1734976702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdcyBmRiYnupt5usNoa8YsTNzt1V3OCJZIqsaCSd/iY=;
        b=eci2zGrVtSiLBdFaYeMfae3U8ose9IbTQi9Vks2D7Wo+9Q0Bgw09UKWlxO2/2Z/50s
         0w3SuaWqXU9lvhQMyQARb1r3PTSXkakFV4M96lEyu68+jmUISgHtZG3ok8CCGLSuHn3P
         vbYxEk0HLIP+mb8sFrew4BNs3K0SI62QQXghKb+Zk4DZC4LaV+nIOVY/8N3SY/BWf2SJ
         dy8XDOYt0TVNqyZmc1JtwyEywLBBNgWOVNhnm8YCAAIZ5slU3XJiXa0a3Q4g8vDoqrMp
         daFJ3u6lLQOyThZa14AP++0qNanj16f8HfTgeD8+GWew7x+2GXfdMRYaMjZ8/UsXvAF2
         omUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfd8sXPHjhrrK2GJReYax1M3ihMdXZ4PmdCA+Am7PoCZOAWYUwLg9ilbPJy127D+fErp1i9kGvi7z7+1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7P+4MNb1LmlOhfV8EhjMRZvRk8vax2vy2TJQrIayfhp1qJEli
	a9WumSTKQAZkYl8DsCiTDZKIXxPeSc+VVnCT8G/kvlqqE68IDfy/O0W0Bf7mz7w/SDthKqypLrk
	Siz5Grw==
X-Google-Smtp-Source: AGHT+IHpcpJq4kyenHoOx1fxav7mIvFDvXklCXubp7lwpwsMau839iNr+DB/Q2jwccyvsQCELDrIix68lHxb
X-Received: from edbfj7.prod.google.com ([2002:a05:6402:2b87:b0:5d3:e71d:9abe])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:254e:b0:5d2:7270:6128
 with SMTP id 4fb4d7f45d1cf-5d63c3dbe25mr31398284a12.25.1734371902351; Mon, 16
 Dec 2024 09:58:22 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:53 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-9-qperret@google.com>
Subject: [PATCH v3 08/18] KVM: arm64: Add {get,put}_pkvm_hyp_vm() helpers
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation for accessing pkvm_hyp_vm structures at EL2 in a context
where we can't always expect a vCPU to be loaded (e.g. MMU notifiers),
introduce get/put helpers to get temporary references to hyp VMs from
any context.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  3 +++
 arch/arm64/kvm/hyp/nvhe/pkvm.c         | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index 24a9a8330d19..f361d8b91930 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -70,4 +70,7 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 					 unsigned int vcpu_idx);
 void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
 
+struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
+void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm);
+
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 071993c16de8..d46a02e24e4a 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -327,6 +327,26 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_spin_unlock(&vm_table_lock);
 }
 
+struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle)
+{
+	struct pkvm_hyp_vm *hyp_vm;
+
+	hyp_spin_lock(&vm_table_lock);
+	hyp_vm = get_vm_by_handle(handle);
+	if (hyp_vm)
+		hyp_page_ref_inc(hyp_virt_to_page(hyp_vm));
+	hyp_spin_unlock(&vm_table_lock);
+
+	return hyp_vm;
+}
+
+void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm)
+{
+	hyp_spin_lock(&vm_table_lock);
+	hyp_page_ref_dec(hyp_virt_to_page(hyp_vm));
+	hyp_spin_unlock(&vm_table_lock);
+}
+
 static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struct kvm *host_kvm)
 {
 	struct kvm *kvm = &hyp_vm->kvm;
-- 
2.47.1.613.gc27f4b7a9f-goog


