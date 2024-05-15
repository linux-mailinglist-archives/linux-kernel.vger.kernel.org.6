Return-Path: <linux-kernel+bounces-180204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E978C6B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DE91C2404D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C5156871;
	Wed, 15 May 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvQDi612"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577234CB4B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793794; cv=none; b=h4hu7+4ZzXRVpTnywgAh7zVRxSef97DPAVZfLjXWUWx9BHryBz/LEYGtOCGtX3y5zrJg2Hx78iE7bkqaPuywa6ta5tsyVwfJ3OtRI/6KTOaIq1or6n95D+UN8Mnp7LNQZaoW/r8En7XirAN4Wz1l6KZDDZ2/PGkk7x+rzT6E0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793794; c=relaxed/simple;
	bh=QYil/6bNPDyLFlt/IP4iXiqn4VhW5HCAEKor3jRfRXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HceAza/yvVXezVorxsnomzNFtDNerN+vmmGFLYSgqEbB5XSQNEdXIJVWHvp9fDE3Eb6KrApNnrJpEa+dprr8kpgGqNdWP0LokKKvS5OqFfNi/TjHJbJDcs2ne6GQxb5yQqtEA1xQiXC5JJh9Mb9fVpf2+tl4jv9WIFqq5WOyQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvQDi612; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-622ce716ceaso47313057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793790; x=1716398590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQNv0L9f8Ur9QycJthQG4bmvCcJmqN/f24s1YQ7H6/M=;
        b=tvQDi612Ipa88MK2QxJUWJ/nhiJ7zfNUiSVs6JfJbJ1q2ufXfmGXNVPAr04CLrK5QY
         jJ3ooBQvMhrNSVJ3g6emQvtAsMf0UEi3nuVKILxsDh0u5jagd+D0PmxftqJbLsr6yavI
         8MRNwbXXxvkitciCxr0O+rV09JV2LKM8gs6juL9I5pk6oTANS5/QEZZIdMjhf6V+4yS0
         OqaHtRPxBWVgi3rEbh/Rld+S/vJhHs1xE3i7JVqVEQJ5iZHeVkzzMhYJfmoCCOnTrfnu
         vUMXtSSWGs0SdJJWLQGeq/nNjeLRBlKhIQoCruWgWtEAEwp83H9A8fA7M01tlgKGl6jB
         rLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793790; x=1716398590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQNv0L9f8Ur9QycJthQG4bmvCcJmqN/f24s1YQ7H6/M=;
        b=F8BI8jRIJKu94ApetpkCYZ5zwutPM1jIws1dW8R3ezhvMD63X9jDNpyFPWvLr9St80
         wedhSzKFWdCYeUQw76B5uCxDtKuog2zXQ1F7XKLiM7qCDMw19uXb/2aphrGg8jQ8VUiv
         nkOBIgHNUvKLRBC/OjOfG213S78w0DcnlK0gy3Bi1LICadGM0K8EoafN+dSaXfd6yVG5
         WVgI/VYNSosW7FSterlossq7erXs7dAD7CZVxLU9wb367FIle4cLxg/S9AUxQL0S595N
         1Q8xfzsL0ROvzJFntCQjp9T7Gtab4HM38AT6kw7Tvog97NemtZQjxnlpOyCaNbMDusMw
         cKzg==
X-Forwarded-Encrypted: i=1; AJvYcCVC48StlQKflokKXHvqLMCWG4l9LvQlbn8yqP0GqvdOUDp2sOkNvKysqYdT9hHU3K6o0GZzdlbFr2itIIdb/ilp4dezNphu2UxAZh5J
X-Gm-Message-State: AOJu0YxyXTndLbWSrlcpCAF2mBmz4QAhsumZABcyVkNDLVuNCC34MMQC
	IL297dT0o8r5D7vVWMIeyT3yhpA333U/kWwm404asND2xFNG7dG4IDAd2iNOh7sNJBapyqmOb4A
	VVsG/cxP12BN5KeF2D6OAdzfFEQ==
X-Google-Smtp-Source: AGHT+IFWj0CPWZNjkZCa8D6KDWXhJ9Flvad+9yi5Xs81Nbt0wNqI/d2+oXKWmpATfuUhMILUHaW60rmoGvWSagTvTps=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:690c:6904:b0:611:6f24:62b1 with
 SMTP id 00721157ae682-622af7a98aamr44278057b3.1.1715793790276; Wed, 15 May
 2024 10:23:10 -0700 (PDT)
Date: Wed, 15 May 2024 17:22:55 +0000
In-Reply-To: <20240515172258.1680881-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515172258.1680881-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515172258.1680881-2-sebastianene@google.com>
Subject: [PATCH v2 1/4] KVM: arm64: Trap FFA_VERSION host call in pKVM
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com, 
	lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

The pKVM hypervisor initializes with FF-A version 1.0. The spec requires
that no other FF-A calls to be issued before the version negotiation
phase is complete. Split the hypervisor proxy initialization code in two
parts so that we can move the later one after the host negotiates its
version.
Without trapping the call, the host drivers can negotiate a higher
version number with TEE which can result in a different memory layout
described during the memory sharing calls.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 123 +++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 320f2eaa14a9..72f1206c85fb 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+//
 /*
  * FF-A v1.0 proxy to filter out invalid memory-sharing SMC calls issued by
  * the host. FF-A is a slightly more palatable abbreviation of "Arm Firmware
@@ -67,6 +68,9 @@ struct kvm_ffa_buffers {
  */
 static struct kvm_ffa_buffers hyp_buffers;
 static struct kvm_ffa_buffers host_buffers;
+static u32 hyp_ffa_version;
+static bool has_version_negotiated;
+static hyp_spinlock_t version_lock;
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -640,6 +644,83 @@ static bool do_ffa_features(struct arm_smccc_res *res,
 	return true;
 }
 
+static int hyp_ffa_post_init(void)
+{
+	size_t min_rxtx_sz;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != FFA_SUCCESS)
+		return -EOPNOTSUPP;
+
+	if (res.a2 != HOST_FFA_ID)
+		return -EINVAL;
+
+	arm_smccc_1_1_smc(FFA_FEATURES, FFA_FN64_RXTX_MAP,
+			  0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != FFA_SUCCESS)
+		return -EOPNOTSUPP;
+
+	switch (res.a2) {
+	case FFA_FEAT_RXTX_MIN_SZ_4K:
+		min_rxtx_sz = SZ_4K;
+		break;
+	case FFA_FEAT_RXTX_MIN_SZ_16K:
+		min_rxtx_sz = SZ_16K;
+		break;
+	case FFA_FEAT_RXTX_MIN_SZ_64K:
+		min_rxtx_sz = SZ_64K;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (min_rxtx_sz > PAGE_SIZE)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void do_ffa_version(struct arm_smccc_res *res,
+			   struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, ffa_req_version, ctxt, 1);
+
+	if (FFA_MAJOR_VERSION(ffa_req_version) != 1) {
+		res->a0 = FFA_RET_NOT_SUPPORTED;
+		return;
+	}
+
+	hyp_spin_lock(&version_lock);
+	if (has_version_negotiated) {
+		res->a0 = hyp_ffa_version;
+		goto unlock;
+	}
+
+	/*
+	 * If the client driver tries to downgrade the version, we need to ask
+	 * first if TEE supports it.
+	 */
+	if (FFA_MINOR_VERSION(ffa_req_version) < FFA_MINOR_VERSION(hyp_ffa_version)) {
+		arm_smccc_1_1_smc(FFA_VERSION, ffa_req_version, 0,
+				  0, 0, 0, 0, 0,
+				  res);
+		if (res->a0 == FFA_RET_NOT_SUPPORTED)
+			goto unlock;
+
+		hyp_ffa_version = ffa_req_version;
+	}
+
+	if (hyp_ffa_post_init())
+		res->a0 = FFA_RET_NOT_SUPPORTED;
+	else {
+		has_version_negotiated = true;
+		res->a0 = hyp_ffa_version;
+	}
+unlock:
+	hyp_spin_unlock(&version_lock);
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
 	struct arm_smccc_res res;
@@ -660,6 +741,11 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	if (!is_ffa_call(func_id))
 		return false;
 
+	if (!has_version_negotiated && func_id != FFA_VERSION) {
+		ffa_to_smccc_error(&res, FFA_RET_INVALID_PARAMETERS);
+		goto out_handled;
+	}
+
 	switch (func_id) {
 	case FFA_FEATURES:
 		if (!do_ffa_features(&res, host_ctxt))
@@ -686,6 +772,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_MEM_FRAG_TX:
 		do_ffa_mem_frag_tx(&res, host_ctxt);
 		goto out_handled;
+	case FFA_VERSION:
+		do_ffa_version(&res, host_ctxt);
+		goto out_handled;
 	}
 
 	if (ffa_call_supported(func_id))
@@ -700,7 +789,6 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 int hyp_ffa_init(void *pages)
 {
 	struct arm_smccc_res res;
-	size_t min_rxtx_sz;
 	void *tx, *rx;
 
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
@@ -726,35 +814,7 @@ int hyp_ffa_init(void *pages)
 	if (FFA_MAJOR_VERSION(res.a0) != 1)
 		return -EOPNOTSUPP;
 
-	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
-	if (res.a0 != FFA_SUCCESS)
-		return -EOPNOTSUPP;
-
-	if (res.a2 != HOST_FFA_ID)
-		return -EINVAL;
-
-	arm_smccc_1_1_smc(FFA_FEATURES, FFA_FN64_RXTX_MAP,
-			  0, 0, 0, 0, 0, 0, &res);
-	if (res.a0 != FFA_SUCCESS)
-		return -EOPNOTSUPP;
-
-	switch (res.a2) {
-	case FFA_FEAT_RXTX_MIN_SZ_4K:
-		min_rxtx_sz = SZ_4K;
-		break;
-	case FFA_FEAT_RXTX_MIN_SZ_16K:
-		min_rxtx_sz = SZ_16K;
-		break;
-	case FFA_FEAT_RXTX_MIN_SZ_64K:
-		min_rxtx_sz = SZ_64K;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (min_rxtx_sz > PAGE_SIZE)
-		return -EOPNOTSUPP;
-
+	hyp_ffa_version = FFA_VERSION_1_0;
 	tx = pages;
 	pages += KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE;
 	rx = pages;
@@ -773,8 +833,9 @@ int hyp_ffa_init(void *pages)
 	};
 
 	host_buffers = (struct kvm_ffa_buffers) {
-		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
+		.lock   = __HYP_SPIN_LOCK_UNLOCKED,
 	};
 
+	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
 	return 0;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


