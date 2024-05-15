Return-Path: <linux-kernel+bounces-180205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1B8C6B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC40286810
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC5433BC;
	Wed, 15 May 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hs1ieU/I"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D528156674
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793795; cv=none; b=dpIXoFNp2FiMJ66AFKpb0SgjooZsAvA4eY0bCS7HLETzXfLfYlYZCBr9DpcZm/aLUfW1fSQGYpkO4ua2a8rUq02UtWfHk43wC+Weqq6Jk84ku1gpPR+M5xsubtkLw3U3XFtk+oNU2UY/1IixM6/XQk/pDlCt1Jn0VDC5c9DKENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793795; c=relaxed/simple;
	bh=VaTIobEA8JkI6Wa8oziZkFqV/LwUPyiZSfvuV+7j/LA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TYGZKqvjHSvDWUWqhRUi4MPPvWKPfVl8pTOU4m7G5eA8OHvJ35kuDLNO3kHskON3SaEJ0VZIEGHDLUO50uNg7YK+fzLVEKqyf5xTWX3IgIbJ6P+kLaIyhoiyYSL5TO/7vylPkaYTGJZYZtKH9Q+5PJ3Eg6Md3+L9iVirkcL+iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hs1ieU/I; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41fe329e720so33008085e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793792; x=1716398592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcqaauEjDoHXh8ji52zP7N4xCK0LJvzWgGd8bzIHFvQ=;
        b=hs1ieU/IwWgOW+yAhflV5c2nGEjIjIUzFkdcOrNvET/sVazNQfcOkwjrRreyKzCsgk
         dBTeRL448vCBvhtbPBmYsTmZr5MeBSUuOKmalKYMzR6khj74pq52v4dGW4Kym5A+z8Yu
         NjpJAXFRAg/lxiMsJdHdqz7aJrtCEXJ8NiOYS5zUamV3RoTXrsmyqUeUHFX9kW69wUzc
         zOwkROTOkH9I3/z+FuzDOGe3oAFBCXD1bknjcySbXuWN5ubv3LGA/0af5diJOPJ+kSV4
         DlOM+W1MxjpTmob2yNYYk6f50xhLHfiK2xecJEaBuyBjnw4FPiQ6quWydF2vsaQ1fpVg
         BvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793792; x=1716398592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcqaauEjDoHXh8ji52zP7N4xCK0LJvzWgGd8bzIHFvQ=;
        b=K8jbnxGppHTdKk2Kal8VaT5sCGLNxGEpPZKFu58v6NNSCiodBsaWCadJunEjYu5tBo
         U1U0h50+28yq88tRTc4bjcRAgcKC9HjkeHN40FKTIYdV5xlGp5tl1r4ObhonrFVgR3kz
         NuixQ8MUREA/piACw6mdo5uhKzVMNiM0xyfv7OBWQdLomADbkmi7CmbBV11+lNRBwEzE
         LeuJg5jSgRxXSsNChIhE02rm+IfoVA0y4jIfAZojERM6WfDGphXJyTMlD1Tl0+X6Io0n
         vFo1CDXz4UqWrhHcnswnvBHdqtgc/OSCRLQeu6qnACQ+0RPmubVuj+XIHP+X+zKeWOVQ
         h5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrSs3SO6FA8pYTPr6m8Z0F7lgkIwE1enSBDErlLKCdkh6Rk7WSFe/XdT4YPBKzLDGA6UXDSIwNjBjfuZUjPLWkdygE38BgYUfCa/Jx
X-Gm-Message-State: AOJu0Ywq1yky9gh2HJa+xVn7yuR1zURX1sMNq1J/3BU1mZnUXAwtAoR+
	u+KQPCKbiIN7Dv1Jsp1mfSD1JOAJHLrSHqRlK+34XWqMcZ8VVIx6kCdnIMSudLDqIlog+6ReklB
	o0md/65ekwQblYFWQAc0FQxH6sQ==
X-Google-Smtp-Source: AGHT+IGGUIJb5pGjjG4rjRgqRcd958BlLvK0rXB3oHHp6PSS+i2nJgNusaT1TQYCxhhQR4CzKLUcSXY1cFz2pqMA+h8=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:502b:b0:420:217f:4f7 with
 SMTP id 5b1f17b1804b1-420217f0761mr367455e9.6.1715793792652; Wed, 15 May 2024
 10:23:12 -0700 (PDT)
Date: Wed, 15 May 2024 17:22:56 +0000
In-Reply-To: <20240515172258.1680881-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515172258.1680881-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515172258.1680881-3-sebastianene@google.com>
Subject: [PATCH v2 2/4] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
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
and copy the response message back to the host buffers. Save the
returned FF-A version as we will need it later to interpret the response
from the TEE.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 52 +++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h       |  3 ++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 72f1206c85fb..f9664c4a348e 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -721,6 +721,55 @@ static void do_ffa_version(struct arm_smccc_res *res,
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
@@ -775,6 +824,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_VERSION:
 		do_ffa_version(&res, host_ctxt);
 		goto out_handled;
+	case FFA_PARTITION_INFO_GET:
+		do_ffa_part_get(&res, host_ctxt);
+		goto out_handled;
 	}
 
 	if (ffa_call_supported(func_id))
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index c906f666ff5d..12a7fa2d6550 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -211,6 +211,9 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
 
 extern const struct bus_type ffa_bus_type;
 
+/* The FF-A 1.0 partition structure lacks the uuid[4] */
+#define FFA_1_0_PARTITON_INFO_SZ	(8)
+
 /* FFA transport related */
 struct ffa_partition_info {
 	u16 id;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


