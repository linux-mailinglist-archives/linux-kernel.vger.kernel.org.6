Return-Path: <linux-kernel+bounces-544273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9AA4DF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149F318985AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0040204C0A;
	Tue,  4 Mar 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjVYZagB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E72046B3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095839; cv=none; b=r27HNTqDWuE7cbWn8OMfnW2oJQNfXMNQxOxy5gVNCVIjo+mMIwgVEWGDu+cQdvXMj2xXXunmYUzaF4ibdc0h7+b004DjXPVLJ719iMh6kOdKqySYvWNmLA1ueRPV1z/epm8RyFyIXbYbdFIlNYOc0/coA7mypeA8s/6k4vqT03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095839; c=relaxed/simple;
	bh=9Cw1IH7xoxtLsb0KLmFRhEqUvO2U41ms9Pgb7VR+2vE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ND82FhTL0N+Tz50d7lNilzss1ZfxZacH9LdIsDD3zn6g4oQiheRdR5MgYhQt1xwE18mTQgIagfnWKNCaC0tOgP281mSnOklwM47D4BcaPznWmzt9Edmfopqi0xJq6nPao/QZ9z3HRRXasq9imJ7due/xC3dntijRJqIlAFvwsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zjVYZagB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43947a0919aso51041545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741095835; x=1741700635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJwR7NM7qgJyDoaMyIjmipwZ0p8zhJtFWoNDi35Q6UY=;
        b=zjVYZagBqoUyP09Puk6an0p1Wx5ihFm3XIOsUfkFvXwLQ5jUghfadIClLYZBC0CSo5
         87LkyO5J8Jg1pd/ZUaUycQi9uwLrxCD4CG5sw24BX6Mluqc6l0A0B3flkI4QBF/aeDuQ
         Ruj+p7UsO4kkxXcd5CRNDKgfrpVOI/Zxv72w+LbnTGMPJSWACn25BZtLZD8J5YOS/cYW
         bA21e3Qjmq3RwSD4O/HJa7LFtDBd3XVlXkTxQThXP9bBg2KslBFOS7UfIwjSOpmH6lJW
         8FqePKWXlRUCyaPLkD9IWdzLcXq0xg0Lwa5KwcOfyUUq9IqVg++6aCpL7PNi6OkGkKPL
         2QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095835; x=1741700635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJwR7NM7qgJyDoaMyIjmipwZ0p8zhJtFWoNDi35Q6UY=;
        b=uxLaGyI76egPfmG5IXWpfq1h2S8TMZJydksThHCGZ78wwMSft9HwN7T8QpMNpDUwnm
         TpdNJZUEjPos9M+QsAorHS9kFmZE3iVAv4bKmpP0ApIrg5BlDtbKiuRjyOp9CLPjf6MI
         kSECXo8xkyAFwZdJ/keKOKZTuxF3e633Of0Njm4+f0H9lhgsI5hgm+leNei7nLbrbb75
         8mmciqFcDHBAS9UdhmqKqZd5stQ2g78Gaxwb/DwseenXZAces9+aFT0OEy98MIzH5llV
         xJ04LeebLihWDYF5u2Vz3zSE/3JT9NyNb5zr9N/eoAzUXZsPbhIMrL56l6l8mbmj74ym
         V15g==
X-Forwarded-Encrypted: i=1; AJvYcCWwHw8Khi6szFCuypXGn4ujZJGeXRjT5NzXbNSVOhsUfje88YBM4RboEH9IIwEIEdHx5O8O5vuUEfJ0v2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKrmr1FGnHU1Lg62KhRUVxybqeF98JWeNbHs6zQosQvq7Xzi9
	qac8/T+dfLrD2nd1NAYOPcnPQ5nujHpuPziNiOY0cf9uNFROOqb23SUcu8RsnLhw/cvvAkXKem8
	AHEWi+bl2CeRJtN0vUA==
X-Google-Smtp-Source: AGHT+IHuciObnyTqS58fROBaIT+QoD8DEu2FY6Ra9IE8fIz0oz/Si6xHw1earUtEBbeoC9ZyaeZgeRKxDyWAOb/F
X-Received: from wmbay1.prod.google.com ([2002:a05:600c:1e01:b0:43b:c9a4:5137])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba0:b0:43b:cbe2:ebeb with SMTP id 5b1f17b1804b1-43bcbe2ef02mr21962745e9.24.1741095835455;
 Tue, 04 Mar 2025 05:43:55 -0800 (PST)
Date: Tue,  4 Mar 2025 13:43:45 +0000
In-Reply-To: <20250304134347.369854-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304134347.369854-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304134347.369854-3-vdonnefort@google.com>
Subject: [PATCH v2 2/3] KVM: arm64: Distinct pKVM teardown memcache for stage-2
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to account for memory dedicated to the stage-2 page-tables, use
a separated memcache when tearing down the VM.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 12691ae23d4c..ace3969e8106 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -246,6 +246,7 @@ typedef unsigned int pkvm_handle_t;
 struct kvm_protected_vm {
 	pkvm_handle_t handle;
 	struct kvm_hyp_memcache teardown_mc;
+	struct kvm_hyp_memcache stage2_teardown_mc;
 	bool enabled;
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 3927fe52a3dd..15f8d5315959 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -678,7 +678,7 @@ teardown_donated_memory(struct kvm_hyp_memcache *mc, void *addr, size_t size)
 
 int __pkvm_teardown_vm(pkvm_handle_t handle)
 {
-	struct kvm_hyp_memcache *mc;
+	struct kvm_hyp_memcache *mc, *stage2_mc;
 	struct pkvm_hyp_vm *hyp_vm;
 	struct kvm *host_kvm;
 	unsigned int idx;
@@ -706,7 +706,8 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
 
 	/* Reclaim guest pages (including page-table pages) */
 	mc = &host_kvm->arch.pkvm.teardown_mc;
-	reclaim_guest_pages(hyp_vm, mc);
+	stage2_mc = &host_kvm->arch.pkvm.stage2_teardown_mc;
+	reclaim_guest_pages(hyp_vm, stage2_mc);
 	unpin_host_vcpus(hyp_vm->vcpus, hyp_vm->nr_vcpus);
 
 	/* Push the metadata pages to the teardown memcache */
@@ -717,7 +718,7 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
 		while (vcpu_mc->nr_pages) {
 			void *addr = pop_hyp_memcache(vcpu_mc, hyp_phys_to_virt);
 
-			push_hyp_memcache(mc, addr, hyp_virt_to_phys);
+			push_hyp_memcache(stage2_mc, addr, hyp_virt_to_phys);
 			unmap_donated_memory_noclear(addr, PAGE_SIZE);
 		}
 
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 930b677eb9b0..19921ca407c6 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -111,6 +111,7 @@ static void __pkvm_destroy_hyp_vm(struct kvm *host_kvm)
 
 	host_kvm->arch.pkvm.handle = 0;
 	free_hyp_memcache(&host_kvm->arch.pkvm.teardown_mc);
+	free_hyp_memcache(&host_kvm->arch.pkvm.stage2_teardown_mc);
 }
 
 /*
-- 
2.48.1.711.g2feabab25a-goog


