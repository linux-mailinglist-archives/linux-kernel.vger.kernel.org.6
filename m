Return-Path: <linux-kernel+bounces-213288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A777907377
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000E6B25F71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5FC144D1A;
	Thu, 13 Jun 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2IGXTvq"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77C1448E6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284860; cv=none; b=dxvD97bZYq/87e9jRzX4ioTucvbHwhd2lYQ+MIZPTYF0IHfcWF58+sFGP96jHR2XUR8/IK0QUUgc+5inn6Dzus1L2kdKIZ3awwbNz7ic2spwT6G2p9rqAdL98wlZZhLM26M0hkylLRop/raKCkv2q3qEl4PdNJYPA9el3edKp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284860; c=relaxed/simple;
	bh=0UaewSnSZaqX/LB6q0/QFseucXjnapEsPBanSqkdT5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZPdV7ShYB/cwuKi8lI3nmrks7vC98uMz5RrGcx+VTbr3T12NpKjtqMUR6gmd2UUQAe+kC9tY93EPIx0+Q9W+3vKy1s3t306zd75fUUL5tfg2bDiLr2Fls6ud3FyxL1utVKVes1t86soq+VAa25r1RYkgmM10rqW3bTz92Dnlf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2IGXTvq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-35f0b9c5bd4so538623f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718284857; x=1718889657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2687N4QagcW+pS81LF/2jVULFoFlDTqmG4f02lwQvU=;
        b=Y2IGXTvqCtqX5qYdUepLY5lw5nHOmqWuA+XhAFAeDeid3Hc1U3tCa5VdNzfYO46mbQ
         3KU4MR0NGwTt13xZVRa9EAkEpZtPWU/P9SfhGjNXSYXI/x/xrWJJHyp/Ju/pccPrZ4RY
         aokKE1kvqXc+bKHijePrvNjRxgYmpty7K3TIakc9AZMmNCqrf1O8eUbx6IyYI/sjSoCE
         MQs4SV52Sb1TfxuLUJnyoJtBbaDAyANfPRIz9tQsolBAbRKQeqUDI1p0SCeEDTMt9Gzd
         lBYwTaQrXi1GIVGNcxF+QVQksRMAu7Zg+1wqTLDB7x/hR2vl8E8IGj7fH5jDSpMZm0pg
         WSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284857; x=1718889657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2687N4QagcW+pS81LF/2jVULFoFlDTqmG4f02lwQvU=;
        b=p/VoHdzGjNfPDXgIDFMZmDt4SYrJmqttXt4xF72tqvaN4upA77qKuLL1JzBmQ/3bGG
         UOVjCTXZtTAI9SlrRGJ3348S6sgXf8o95J3FyNWiYB8S7BsigpmTm/Ixkp/s8XMEfcbW
         GrLmbiE51G5WGpcJKs/R6k04kT1Q6GZ192UUMuqMzba8d4i/PPxwNIU4YT+JaqFPTAip
         QeJKgkSm276Q6zERUI4zfVz9vi1jWF2JKlPC+Dht+Od2tiHWNEEhHbfWRUCM0Wsn6q+1
         eoJc57qHtkPm7zKFHlPmKE/l2mqs0pB7o81YHTrXzac8dZbN1PEwxaV8AbnCb/1k7bLk
         Ja6A==
X-Forwarded-Encrypted: i=1; AJvYcCUVsxOXhkV8gUQzfg7WAcTBV7lScIOu12rJEIg4+jwa0ubdVTwWN8Nh7NJCFV7ocdyIU3+IYyZAyFQEEkwOL+y1CIG5o29028ptHmqh
X-Gm-Message-State: AOJu0YylF53RPliA04q/XhjjUrnReMK4wXhwYPVef2hqVqVqIHb0YKb6
	W4yox4uNYBEohD18zy51kZpLXM1tKupZ+mgh7hr8v8ZGU4J0GVWoWG3hpyeOb50rCu07/UFzfsT
	ZrEIHeb7T3fMzngZTJK7SeKW7Vw==
X-Google-Smtp-Source: AGHT+IGQhQ+fUdEpXPrfB7jjNHTVpmKDUpNbwNUPEJVt9Lbm8XyWi+3c3WFMeVAAl0KV4ewCMNJr1OmROkbzIeA/6/Q=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:522d:0:b0:360:791c:afee with SMTP
 id ffacd0b85a97d-360791cb125mr1885f8f.3.1718284857386; Thu, 13 Jun 2024
 06:20:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:20:33 +0000
In-Reply-To: <20240613132035.1070360-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613132035.1070360-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613132035.1070360-3-sebastianene@google.com>
Subject: [PATCH v3 2/4] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
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

Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
and copy the response message back to the host buffers.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 52 +++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h       |  3 ++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index c8ab51c331f0..4eaef673e98d 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -719,6 +719,55 @@ static void do_ffa_version(struct arm_smccc_res *res,
 	hyp_spin_unlock(&version_lock);
 }
 
+static void do_ffa_part_get(struct arm_smccc_res *res,
+			    struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, uuid0, ctxt, 1);
+	DECLARE_REG(u32, uuid1, ctxt, 2);
+	DECLARE_REG(u32, uuid2, ctxt, 3);
+	DECLARE_REG(u32, uuid3, ctxt, 4);
+	DECLARE_REG(u32, flags, ctxt, 5);
+	u32 count, partition_sz, copy_sz;
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (!host_buffers.rx) {
+		ffa_to_smccc_res(res, FFA_RET_BUSY);
+		goto out_unlock;
+	}
+
+	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
+			  uuid2, uuid3, flags, 0, 0,
+			  res);
+
+	if (res->a0 != FFA_SUCCESS)
+		goto out_unlock;
+
+	count = res->a2;
+	if (!count)
+		goto out_unlock;
+
+	if (hyp_ffa_version > FFA_VERSION_1_0) {
+		/* Get the number of partitions deployed in the system */
+		if (flags & 0x1)
+			goto out_unlock;
+
+		partition_sz  = res->a3;
+	} else {
+		/* FFA_VERSION_1_0 lacks the size in the response */
+		partition_sz = FFA_1_0_PARTITON_INFO_SZ;
+	}
+
+	copy_sz = partition_sz * count;
+	if (copy_sz > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
+		ffa_to_smccc_res(res, FFA_RET_ABORTED);
+		goto out_unlock;
+	}
+
+	memcpy(host_buffers.rx, hyp_buffers.rx, copy_sz);
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
 	struct arm_smccc_res res;
@@ -773,6 +822,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_VERSION:
 		do_ffa_version(&res, host_ctxt);
 		goto out_handled;
+	case FFA_PARTITION_INFO_GET:
+		do_ffa_part_get(&res, host_ctxt);
+		goto out_handled;
 	}
 
 	if (ffa_call_supported(func_id))
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index c82d56768101..c6d18f50f671 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -212,6 +212,9 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
 
 extern const struct bus_type ffa_bus_type;
 
+/* The FF-A 1.0 partition structure lacks the uuid[4] */
+#define FFA_1_0_PARTITON_INFO_SZ	(8)
+
 /* FFA transport related */
 struct ffa_partition_info {
 	u16 id;
-- 
2.45.2.505.gda0bf45e8d-goog


