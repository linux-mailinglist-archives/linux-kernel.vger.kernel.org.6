Return-Path: <linux-kernel+bounces-537063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F2A487AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97263A69F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DF1EFF95;
	Thu, 27 Feb 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGk6j27g"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC422CBC9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680284; cv=none; b=Y67yUnUQMRR9/1GWtB6t80dZKFzmrKYoWGBtSxPUWzWjMWtqo+2MjJGT/O/Kg+KbcuMBdhX69HfsmALcLudz88CtB/uFU/vJfGY4BBs+zUyM6/jWwDfPDRkxYmuYIANYBmXzxCMpwot4F+oBSGYg72Xw7L8one8VooWwMq9EMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680284; c=relaxed/simple;
	bh=Ep7gH/oCf+sk9jHJM97qe5HKmg83XTq7tAH6ZdSDw0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daH/aSXKslwsiWMPBbWAaoAqJ8QjcLl+CNEoUDpWiv8nem3D41isOQU7cQzcPepBwNko5lzyDyK2bFfklk+JNlvITGWTC5btpcfVZIt8LPsxsNikJws2LQ86sQIHQeWe8rtSXKACRUKOaQB8G533XQhHSMThsQrbhXh8lD2+NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGk6j27g; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-390de58dc09so854470f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740680280; x=1741285080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hce1wCI+iJiN9AXNLgcvauNehWwU2rw17tT7g22I8ig=;
        b=HGk6j27gpzB3vYBXWdzAHbkNVMhi4WVqDaMdwrwvNcJ5FPT6jgBZUVkXrVUh/ats3m
         SNkzmUT5rA+JRzqjRN5i88wQTpWETtgsliroLELHM/bLm9eF7tBhual3+v7GPrCgBhCT
         Lx1Ynj3zwgXb35cDWmDNFKX55IlHGaURR4MqOd3JPmD18yyDPQocjTLSSruzbqodQe99
         WeQlnpzeNjTrCZwcLj/L/LEUv8dQFAFTbKQYnGHOJJl7hzf6uSZcWR4CTdHLN5oOogR0
         tIw1pCW4e6MTxTNJZZ9HuD3EzgwNRQSh+H8qcqc9ntAIkpYV7KFjAIfinuhMbYBRb5aa
         PHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680280; x=1741285080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hce1wCI+iJiN9AXNLgcvauNehWwU2rw17tT7g22I8ig=;
        b=Mp22nzFiNTd+yFRQp3ayh4lBtA6D0bdGB80UtlDCEoIcWbj+JmORhMCzunykfrREYu
         q9kBxTaIVEGsSWEo7dLG7Qim8l9lX2lAvbzYURKkRoxyjpEHbGr2X2b8n/cfuz5IZHU1
         69RZzXkP2dgP5sG8rBHjktr//X1JoyyzliXKKAbZQ75i7Ele3SUeZIL8/H0MfAieOFBD
         TgCfQ9dD4sBNaZipU00QGcGAGh38bFwdHsmWHmbr/ofnLbHX9pgnN0S51HSQxWjxaHP0
         W0afyrCN3RdS/TJOCUHuRh2zWRo10Rx+MeILtcpcyhnRzSuWuOVcieBSAMPhiQqks3HE
         EKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLYPH5hCUoOpDVT+gnEeEnNU7TDhbjVtvHgWOXv761n3XCF/fckP2YGcGTo1zYO99vYtp2HHD3A/Z+jHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzkOBp/utwAyha+fCIbI8ckFAMUZNras7cAJyUAo+GaTQUAdH
	G5QaPStXfmqgl3JPaHfADxckLotALRM4pH52oX9pjxd6VWoP/rkmNTnwhV0kah6gJ9ZGNGVfU8L
	zikWVui/XuYQC0cu0TyKKUlOEyw==
X-Google-Smtp-Source: AGHT+IFKf38sjXhANJwnxVv0t8bQO3XXUn605hIGPZLim6GWv0LFywIR25WQ1XrK1YmlUszpJyRh8MP2vxl9ngqoV7c=
X-Received: from wrbgz3.prod.google.com ([2002:a05:6000:4803:b0:38f:4458:9c7c])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2108:b0:38f:2289:90f1 with SMTP id ffacd0b85a97d-390ec7d20a4mr172276f8f.29.1740680280768;
 Thu, 27 Feb 2025 10:18:00 -0800 (PST)
Date: Thu, 27 Feb 2025 18:17:48 +0000
In-Reply-To: <20250227181750.3606372-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227181750.3606372-1-sebastianene@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227181750.3606372-4-sebastianene@google.com>
Subject: [PATCH v2 3/4] KVM: arm64: Map the hypervisor FF-A buffers on ffa init
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Map the hypervisor's buffers irrespective to the host and return
a linux error code from the FF-A error code on failure. Remove
the unmap ff-a buffers calls from the hypervisor as it will
never be called.
Prevent the host from using FF-A directly with Trustzone
if the hypervisor could not map its own buffers.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 6df6131f1107..861f24de97cb 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -69,6 +69,7 @@ static struct kvm_ffa_buffers hyp_buffers;
 static struct kvm_ffa_buffers host_buffers;
 static u32 hyp_ffa_version;
 static bool has_version_negotiated;
+static bool has_ffa_supported;
 static DEFINE_HYP_SPINLOCK(version_lock);
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
@@ -111,30 +112,18 @@ static bool is_ffa_call(u64 func_id)
 	       ARM_SMCCC_FUNC_NUM(func_id) <= FFA_MAX_FUNC_NUM;
 }
 
-static int ffa_map_hyp_buffers(u64 ffa_page_count)
+static int ffa_map_hyp_buffers(void)
 {
 	struct arm_smccc_res res;
 
 	arm_smccc_1_1_smc(FFA_FN64_RXTX_MAP,
 			  hyp_virt_to_phys(hyp_buffers.tx),
 			  hyp_virt_to_phys(hyp_buffers.rx),
-			  ffa_page_count,
+			  KVM_FFA_MBOX_NR_PAGES,
 			  0, 0, 0, 0,
 			  &res);
 
-	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
-}
-
-static int ffa_unmap_hyp_buffers(void)
-{
-	struct arm_smccc_res res;
-
-	arm_smccc_1_1_smc(FFA_RXTX_UNMAP,
-			  HOST_FFA_ID,
-			  0, 0, 0, 0, 0, 0,
-			  &res);
-
-	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
+	return res.a0 == FFA_SUCCESS ? 0 : ffa_to_linux_errno(res.a2);
 }
 
 static void ffa_mem_frag_tx(struct arm_smccc_res *res, u32 handle_lo,
@@ -213,18 +202,10 @@ static void do_ffa_rxtx_map(struct arm_smccc_res *res,
 		goto out_unlock;
 	}
 
-	/*
-	 * Map our hypervisor buffers into the SPMD before mapping and
-	 * pinning the host buffers in our own address space.
-	 */
-	ret = ffa_map_hyp_buffers(npages);
-	if (ret)
-		goto out_unlock;
-
 	ret = __pkvm_host_share_hyp(hyp_phys_to_pfn(tx));
 	if (ret) {
 		ret = FFA_RET_INVALID_PARAMETERS;
-		goto err_unmap;
+		goto out_unlock;
 	}
 
 	ret = __pkvm_host_share_hyp(hyp_phys_to_pfn(rx));
@@ -262,8 +243,6 @@ static void do_ffa_rxtx_map(struct arm_smccc_res *res,
 	__pkvm_host_unshare_hyp(hyp_phys_to_pfn(rx));
 err_unshare_tx:
 	__pkvm_host_unshare_hyp(hyp_phys_to_pfn(tx));
-err_unmap:
-	ffa_unmap_hyp_buffers();
 	goto out_unlock;
 }
 
@@ -291,9 +270,6 @@ static void do_ffa_rxtx_unmap(struct arm_smccc_res *res,
 	hyp_unpin_shared_mem(host_buffers.rx, host_buffers.rx + 1);
 	WARN_ON(__pkvm_host_unshare_hyp(hyp_virt_to_pfn(host_buffers.rx)));
 	host_buffers.rx = NULL;
-
-	ffa_unmap_hyp_buffers();
-
 out_unlock:
 	hyp_spin_unlock(&host_buffers.lock);
 out:
@@ -809,6 +785,11 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	if (!is_ffa_call(func_id))
 		return false;
 
+	if (!has_ffa_supported) {
+		ffa_to_smccc_error(&res, FFA_RET_NOT_SUPPORTED);
+		goto out_handled;
+	}
+
 	if (!has_version_negotiated && func_id != FFA_VERSION) {
 		ffa_to_smccc_error(&res, FFA_RET_INVALID_PARAMETERS);
 		goto out_handled;
@@ -861,6 +842,7 @@ int hyp_ffa_init(void *pages)
 {
 	struct arm_smccc_res res;
 	void *tx, *rx;
+	int ret;
 
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
@@ -911,5 +893,11 @@ int hyp_ffa_init(void *pages)
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
 	};
 
+	/* Map our hypervisor buffers into the SPMD */
+	ret = ffa_map_hyp_buffers();
+	if (ret)
+		return ret;
+
+	has_ffa_supported = true;
 	return 0;
 }
-- 
2.48.1.711.g2feabab25a-goog


