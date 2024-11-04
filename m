Return-Path: <linux-kernel+bounces-394933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285D39BB637
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BB81F2318A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719341B6CF6;
	Mon,  4 Nov 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCOOcgR7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004191B4F02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727152; cv=none; b=KKdrEhH1g0MIIIy1wCfhASGugrhxg3b9Tm7aWU9WCkRBRg+XoxOsDmSCfjtS54QjfHkBUWPhT1VKC8scnt9hXEU7cZU5bkqHvcfw8+9AhP+MJ5RZyhij6BdAWSRJwNnsH8F/SZSu3Uorkoy9PSBkCu9Hy1I4qlx2Y9siY9Kss2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727152; c=relaxed/simple;
	bh=2zzcr8dahGRVDNl3wZ1YqXvn1JcqJa8MzblIuk2DUSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ov+7kaLqwoakzQqmMwokulG0rAsQnDgLjvCU7VvcjH68m1j50QiuIyRSVjZVTH8XZxZBoZuLAjs0xhV2lHJ0TSh8dZqx4i+qBYJxfln4X8GBSW0J52yTF2A4VWf+Ge+O7X0HbeNGa/JAcohUzXKGlyg1VdgVQnxPpo4Zeeqvk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCOOcgR7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so4446703276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727150; x=1731331950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBItirLg5Oir0h+eEpcfLT0BceEfQcKCnavoc0LgXGQ=;
        b=VCOOcgR7kOI97hxUZOZiHjmmU7Dsc0oyyejwW3ZlFNFJavsXPdyFGkg8ptzzm+QFx/
         kOQ/Ivfb8GjbzrdftUdhCQ/3y56sACcv3n9W1TdwgL0YvMqNHLUymmC2dLWttfOwbQvM
         VLIKMeDEzHtGlCZ943VHoJd81L96C72fin0AbakhRT5J51nOIY7PbPRWUaoQZPNzaS3X
         pmFSjozoDBR0leUBxcKs7/BR2+IziDyQnpfhJ9VwB8l6Rk56DXWLEn0R+sWrLPlmc0rA
         YfadIueWNjwuI8vLYBsZg/IQVwt19bH3BmA8YAIZrw9+AGKpG9xmLWf40d2bYen8whVr
         zsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727150; x=1731331950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBItirLg5Oir0h+eEpcfLT0BceEfQcKCnavoc0LgXGQ=;
        b=mRECtllT636LpfKgXeTNDgtNDgbkqAPRQTahz8pchUylfCQERGPgCXAoMJwJ2WPKAR
         0TBD9ucIQZSbEwx2BbWT39foVQf8HxybAvntxA/C/9+pIluh05+/0VtXNLoPCTTCLTN9
         UPFGgBUxm896rQUiP4ZdiBr9B9txn6+nBdc7WeRhxVWCAkkIqa3fuhlvXs0fT9FHVF2z
         bh5FN/8rnypTeOzjgPVaQrSg6V5cfPq1jCjHV6f7j1pbuZ5kTynu/bGJgOD5joyG5l8Q
         +LZ0kXphzzICOzKhNMbbg0XYXTsk4SbKhYntDF9UGCoM8vIsA72HaU2ZKgdtQt4d+LRW
         /xvw==
X-Forwarded-Encrypted: i=1; AJvYcCWQFIdxuNxSvyvfrI1/TJH2801TecZ0EidzKLt2UvOykpeJD9t3/0Z81ax6GaneiMFWweomsvG1y/RQoPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqddk0NyMvag90gjxqLrygWekcHJGQpHdTKh+TpXZxijT2lem
	Ha26H6OxgBjUV6hgyxZpEG9XgHXdbxil5mwQsVoi3zm6Wamczd4OOIZqxtiiWJ5MSih/wUSewj1
	mAmr63w==
X-Google-Smtp-Source: AGHT+IFvrgh3CVf1TWze2me+UFlYP3CJE1J8M2LCwjOfq5XmD1MuK3gwOqhUj0cOzAZs1ZrUlVldZRwY5pmA
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a25:2bc9:0:b0:e27:3e6a:345 with SMTP id
 3f1490d57ef6-e33026dcafemr8506276.10.1730727149901; Mon, 04 Nov 2024 05:32:29
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:55 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-10-qperret@google.com>
Subject: [PATCH 09/18] KVM: arm64: Introduce {get,put}_pkvm_hyp_vm() helpers
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
introduce get/put helpers to gettemporary references to hyp VMs from
any context.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  3 +++
 arch/arm64/kvm/hyp/nvhe/pkvm.c         | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index 6940eb171a52..be52c5b15e21 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -77,4 +77,7 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
 struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void);
 
+struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
+void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm);
+
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 9ed2b8a63371..d242da1ec56a 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -317,6 +317,26 @@ struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void)
 	return __this_cpu_read(loaded_hyp_vcpu);
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
 static void unpin_host_vcpu(struct kvm_vcpu *host_vcpu)
 {
 	if (host_vcpu)
-- 
2.47.0.163.g1226f6d8fa-goog


