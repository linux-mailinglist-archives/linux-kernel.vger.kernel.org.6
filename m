Return-Path: <linux-kernel+bounces-180207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9F8C6B70
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EA81F21ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA06157481;
	Wed, 15 May 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiVAIdKE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA7156F53
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793800; cv=none; b=dYo3bcG8zVS2T853U2hX8shCviwoa8IObaC99D1G6gcVcf/uwbE9jFOGP3uAY5gx6+YYOcnV01X1a6BjHmBSZoyb3+4qShW7NBIjdJ51t8Ukiv1/20lTDu7tWa5SM6NykiX9VRbEqXoGfJ3Sos2GWOo5DBX5B4+z5IJzRZswb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793800; c=relaxed/simple;
	bh=Mmpk3cTXYb9Cytx2OXyWdNPcR2iwoJfjJ8SD4AaSDlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fq4HwSpYwBDzzyMI+4UXnOV8b+v8wd5nuBflix6cA7tJqE8hN/UMr3Z+Ev8OCeQMx9UE7gC5h/S4HjY/6YqbhQJP23VvVcmyOYTSsvbVkBVUNQAGQJrE9/w/7ltnlYztvUcWuTvU00ooPOyC2IQw0sO37w2mBDfinzVLi2pPveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiVAIdKE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41dc9c831acso38466745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793797; x=1716398597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HVNMjO2akSMcTTiBfbdxnnFw0wMMSm8FW4gVmT1QRI=;
        b=wiVAIdKEAU9n4Ac4/Fu8IcH5llGe9EE5a2z71co+UoqlwZDcvuBA2Gs5A61Fz6foGh
         zTN4bLnrt2piQEAC0dPNQakXyoWTj8uwKJgurnGMLcOasJHMCtJzgdlAlU+v38f1+FwQ
         pUxQUlwjzkKKnKDd/pYhJEY8kQ12fdMtiI933hQYPESdV6gM2cBGaH+js9EVbmrbWheY
         xitpRJ9fnvuXR3999B/t6y31n4uKprk7k6JER3+q9W3/HUg/9o+kR0FtsQ9GA//ypb0q
         N48ZrfTVB727pDNur+gXs8D78iw2vIfpv7a6BQCHePNJlmYg/kOrM1INpGLdC2Uzc5hR
         AK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793797; x=1716398597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HVNMjO2akSMcTTiBfbdxnnFw0wMMSm8FW4gVmT1QRI=;
        b=SgSMh2VufTdt5suP4vrdqG96SszpDDlYQcegUzqKrY9f5A/XJkv1fhMGLFWp7+N5LO
         XhPmc2bk+XEIQ1Uxja0Xs4Lf8IghFYdY0PZ15X7E9Sg6naXTvIg77sm3CYf5BfYAqVAf
         Pwm1pZx5rfswzQvZv9/mDzfl8mXt7LrxC7L6rO04rtrJSv6NacgnZaYERx02RTb5Y/3x
         oWsQxYVuFQ0+2mRv/OwesFGgiBdOlHWHW84Iqi1taolaB8pJdK7KDWxPSAqkzcYKJ7T5
         ziBvk/6AXyav+OC5Wt37ubZfxDFgvhIs8GF+VWWHt3lZo0NnkpRoEySJTobRpJl1/pA1
         umTw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQAhE5+8vXRWEah/HgOMFZntpMzD5nzJXu2w1VieiQkqNyHJg1QfGXQohUimZPgh/g3GM81clWkYEr/UrT4mc1n+IMymRrLQVLJ+e
X-Gm-Message-State: AOJu0YxOpKsbT/O6NzDs+99m2wzbbZ97Fw7DB42LaViXu0O++xQekK0z
	FRU+x+1uPEC4m9XozY0SoKg48RXEn6mW4djYFyxOapXs33mWYP2ITpUIZI3YLOMOaA2XvJu95s8
	x0G0HfsJjKrJ8Ezbp3xVLj0L/dw==
X-Google-Smtp-Source: AGHT+IF2+ZdhABrnKPyUROWJCaWhOUajRbqGLHWL21MZQxT/ip0TW6XIGdVRzaMZh4Ur0gPZC6lIS0u4//WU4M/kut0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:511d:b0:41e:8c00:94a4 with
 SMTP id 5b1f17b1804b1-41fead6accamr2395155e9.3.1715793797270; Wed, 15 May
 2024 10:23:17 -0700 (PDT)
Date: Wed, 15 May 2024 17:22:58 +0000
In-Reply-To: <20240515172258.1680881-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515172258.1680881-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515172258.1680881-5-sebastianene@google.com>
Subject: [PATCH v2 4/4] KVM: arm64: Use FF-A 1.1 with pKVM
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
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index f9664c4a348e..bdd70eb4114e 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -458,7 +458,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	memcpy(buf, host_buffers.tx, fraglen);
 
 	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
 	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -537,7 +537,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	fraglen = res->a2;
 
 	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
 	offset = ep_mem_access->composite_off;
 	/*
 	 * We can trust the SPMD to get this right, but let's at least
@@ -846,7 +846,7 @@ int hyp_ffa_init(void *pages)
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_1, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 == FFA_RET_NOT_SUPPORTED)
 		return 0;
 
@@ -866,7 +866,11 @@ int hyp_ffa_init(void *pages)
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
2.45.0.rc1.225.g2a3ae87e7f-goog


