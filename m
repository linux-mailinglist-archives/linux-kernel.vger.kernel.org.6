Return-Path: <linux-kernel+bounces-213290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4D907379
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591CF2811EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AAD14535E;
	Thu, 13 Jun 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9CwySmF"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32539145343
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284865; cv=none; b=TZw3X+p2ehiLHuP7qCh0di6L7ikUHwdvO0S3gSLRTuszD7aHGew5dA2mBL6LKqplNd+C/J2SRushW1J4U01U0qd7HLsTM1u34TZgS4tLSDxoQJb7OWwf/HKdUqBS0dHCMweA5piPozcyKeqZ3k2qKJSb/lEF+z6oGA/AW1dJPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284865; c=relaxed/simple;
	bh=kxJ6yca6FhrEdaeRJHlyh47eGEiERJamoE3DlUAPJas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pxur2o03zWc1wUGaT0pLrKGyqMr39JPzshPmG4/iG7znQmhuHUxD5Qv56cWdfOUTWtcwSiUdr00w0O1V4GRtVg7UuZFrYOfPHXum5mQ0o+Tx8siHxYPOcr/GJRTv+kE7F3jgyl6Q1i5lSorW7Z5JICXJJenHmbH/uDfo9pZ2YHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9CwySmF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-421739476b3so9398245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718284862; x=1718889662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85ojJxkNYXxh97Mo9k1gfrYfK0JeNvYJnaS4+QvvHCA=;
        b=T9CwySmFiPGAIyyPzRBeYmfEZWcJ9U4n0VwFg2EBH9pkMCGXx4h3VZnzvJXYNZiJxq
         AEmSxr5IihDIAF9MTRpltqtpe4mwb1h4TFOnQw+WfNBvRJ4d9ViO73Uzq4Prkv8E2wYw
         zeT25QoUO8jxVHDJlzjkGd60nNrqYjg+wCkmHKBlp3l1jnazZdvpCbHTsFdhoplBBcD4
         Lcobhs5boJhlLDW3ouokVvJ23xC+7nV8PHuT8Hm0377eWCTnAdmcpXKIKK8XC/BGt5br
         irK3PQ5Wnn31XhBTvVl0NteSYgqyCFKIfYxtOl1MFaW31yzK7Be++4OsJ/n5vRtxOaI5
         XrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284862; x=1718889662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85ojJxkNYXxh97Mo9k1gfrYfK0JeNvYJnaS4+QvvHCA=;
        b=RZxGZZgysjwiZHok4KKjypCL7oa6qQeOXglhtkCl9Ox8g0lf5YPr37i2deJjUukuRE
         tV3iCVsvuRsHblxRv+TXDoK2nzFXF/TmH9O64KunEzlThoGMuyQ/Dp+AYA+VMEek04f7
         F2Hq6JCJe4Q8CU5s0QP8f0I1al0h7B9nIaDc/SjSne4C3Q0aKgNMxwf/XcmiPTCgPvZn
         xm8BGaxQRv8IEJ0sU0/X7Nq+tJGcqpYBeL9YGxZbyjJ9RvWidPbE5+DQkH0hQB5qknOR
         GrJDOeXCCOgox6dLe89LNpdBKC15UgOMnicYto4QCOzraaP+BfnS3V659ttpJbEmDby0
         xCEA==
X-Forwarded-Encrypted: i=1; AJvYcCX/vdGKnTdHdRdHXJOOVb05TrysEDY5YkatykAgpQbPFonC7F9OZv4qt/QdbQN957KmaZGklz6M/IuJ+lBgk6XzRYDj3YAwEaCJYdNe
X-Gm-Message-State: AOJu0YznO4csDUp+nz/WtMYrMQsxr+xfaREZL6iZZNrxR42pdm2EKVkr
	pYJMRVVw/2ZMexkNSUvp5TEvmAk+8j6oKrsj/Bnqg+rzOlrreLdNqi6O8R0yhHR1YfCT6WISFhC
	6bpneuMhzLsyhplZcnTlynB/okQ==
X-Google-Smtp-Source: AGHT+IEGmcAxjB2wRcZVPwbydQye9U+Lfxf52+t870ONm/t/2enRlN5yWNU9fxSxYfGOvDAZatwr0XKHsQNvtwSMq2I=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:4e09:0:b0:354:f4a4:6d35 with SMTP
 id ffacd0b85a97d-35fe8928988mr10512f8f.13.1718284862437; Thu, 13 Jun 2024
 06:21:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:20:35 +0000
In-Reply-To: <20240613132035.1070360-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613132035.1070360-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613132035.1070360-5-sebastianene@google.com>
Subject: [PATCH v3 4/4] KVM: arm64: Use FF-A 1.1 with pKVM
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

Now that the layout of the structures is compatible with 1.1 it is time
to probe the 1.1 version of the FF-A protocol inside the hypervisor. If
the TEE doesn't support it, it should return the minimum supported
version.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 4eaef673e98d..fdb63b7857ec 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -457,7 +457,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	memcpy(buf, host_buffers.tx, fraglen);
 
 	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
 	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -536,7 +536,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	fraglen = res->a2;
 
 	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
 	offset = ep_mem_access->composite_off;
 	/*
 	 * We can trust the SPMD to get this right, but let's at least
@@ -844,7 +844,7 @@ int hyp_ffa_init(void *pages)
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_1, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 == FFA_RET_NOT_SUPPORTED)
 		return 0;
 
@@ -864,7 +864,11 @@ int hyp_ffa_init(void *pages)
 	if (FFA_MAJOR_VERSION(res.a0) != 1)
 		return -EOPNOTSUPP;
 
-	hyp_ffa_version = FFA_VERSION_1_0;
+	if (FFA_MINOR_VERSION(res.a0) < FFA_MINOR_VERSION(FFA_VERSION_1_1))
+		hyp_ffa_version = res.a0;
+	else
+		hyp_ffa_version = FFA_VERSION_1_1;
+
 	tx = pages;
 	pages += KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE;
 	rx = pages;
-- 
2.45.2.505.gda0bf45e8d-goog


