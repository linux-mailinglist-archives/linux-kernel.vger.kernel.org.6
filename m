Return-Path: <linux-kernel+bounces-429252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A59E1980
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F6C2822EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AA1E3DC4;
	Tue,  3 Dec 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hirlSGAf"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478151E377F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222277; cv=none; b=eHd8KSdGATUd+BZ54fkWTtdp5dCaZNvCKFMH1ln3Mv+ZJ7nQvpMb1/UYDwlQepp6R2gU2WyNgwecNGhaWRdyby9XkgypVSy2+DHFBPUI47s8UMyxW0CObR2FVxibEsYYOvZp/KDyjFRz8rN0qyRCobpSB1tsvtio2UwOGB3U8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222277; c=relaxed/simple;
	bh=IuYyF+ZnGppO8PAFBi7Chs+i2+5hGe6b9QeErqyYhmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ux42e9vbVjs63McGR4w7oHmDNJdPRqxlmTr6Wa6VT9OM0OD6AiYC4vfAjTtk/d7iGW/VL0UNe1pqO2YHBNK8dKB0OUh/Bk9OwZ/7amQtvIkSjdlwYcw/wPFJaB/tA4Y4o1vpeG2VliXD7lXTtqWFbMmgdjzlXVUPie4dw5WUqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hirlSGAf; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-30011d2f7a8so2141441fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222274; x=1733827074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRZ2cEpW+rSNUfUs/q11EvB+KMkExBUSGtmow/HBwh4=;
        b=hirlSGAfimz8UekkydtdkaF2iTnr4EG2k1ebhySMz83MfrbP0XmTMNJNBo+vpxOixK
         O2+oxiofbWG7FkJlQSVzJPa9a9e4Docb+2iKPoOUpQqMUsIHvSmoAFwfrSu/M0C7sT5T
         a+yXYxneq2kHrBdrwbB6g0dEzwd8QMK4Fj4mDIhCYR4k4o9t47DvuKoAyYBC7fg3mz7G
         mR/vAAWfLnvHMEfBlzdRWgPqcUg+kmecMv9EAc+tRcuwqwIM20Yw7hXXtG8ZhMTuucvz
         8msKsIDhlyqjo3s8Jj1VT4UThUjENG7tR4UiKfFo6LxZAjG0wAjaveqbyK/VJr13S7jC
         /QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222274; x=1733827074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRZ2cEpW+rSNUfUs/q11EvB+KMkExBUSGtmow/HBwh4=;
        b=jH8BjMApVxVmQOI7xTQ8+SqrkqT/19OdKfbaJeesSofTeHK+d08n+WhtZ2HHD+rDD5
         pgRFN2XzH//VBFO+/ySwDGHFjcK8GRVjYcUpHZ8a7M4yLqjP8sd7I0HYfZPdhWi0vwEq
         p7BdsnX90Pt2Ife8HKitGW71QbTFVWHAFlzByho0VhYmVulIDv9t5RROb2S813na7/PX
         FHGODmK5H7iYCW6iwndrqU7FhpCOJOUaEtMnJd+uoYq+ndqv0pkQX3Y7DffbAZlzN4W6
         ibCQpigGGnF5yyzm5tdB3Mqwzne4kcmNYHNBWuCpRVltWl8FMWrwf4cB7ZHqGCA2Ia/x
         vBEw==
X-Forwarded-Encrypted: i=1; AJvYcCV+o0s/RIrgegE0LGJ8yGNQ8nx8jHoPrD1RR6dgN9aTpL71Br3fyR3bOOLdbkH8YySPzE6JvgPfsbmkplI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7h6TpWEct3J9KJdM/vawdq8BiHEp9ITdAFRIeejP7L77OjYa
	QuxqZd8ltLsxSErvSjy+9q0KgdV2NZeC4tMMlbN6+O7I0SGDT4pvpju0Pa9mwALTQ1rxL1J539q
	NhChgeQ==
X-Google-Smtp-Source: AGHT+IEj8AuZHCZpDYFglBJG72MANHTDv565iypJfWiYGscbgWwh2Qi7NN2thjRyh4mSRHfuIeZ5D8lm4Rqv
X-Received: from edxz12.prod.google.com ([2002:aa7:cf8c:0:b0:5cf:ac1b:14fa])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:b890:0:b0:2ff:8e69:77ef
 with SMTP id 38308e7fff4ca-30009c0d863mr13033771fa.1.1733222274568; Tue, 03
 Dec 2024 02:37:54 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:25 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-9-qperret@google.com>
Subject: [PATCH v2 08/18] KVM: arm64: Add {get,put}_pkvm_hyp_vm() helpers
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
index 01616c39a810..4db88bedf8d5 100644
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
2.47.0.338.g60cca15819-goog


