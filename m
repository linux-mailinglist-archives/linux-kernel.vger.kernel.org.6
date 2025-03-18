Return-Path: <linux-kernel+bounces-566536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F78A6794A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA00616A322
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042ED211283;
	Tue, 18 Mar 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMEF++xz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E5211486
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315143; cv=none; b=vCh+NhlAQzmxdgqLSXsUvbM0cX8z1JGJKOa0QZdcecDkO+/VLyKo72fA1cPg6g2MBnj8koYG/oGtH/nhHRoMGHyYcQRDRZ6FavgCK6MJ6NusVJdrhd0yqk1XWjm3ehiPkNchDIYcpfsNlQbp0N2BcmrLbjpXK1mvecUIVq63s0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315143; c=relaxed/simple;
	bh=APr23r7WvaanM9oDUyKut3wB8DoFtC1/LjrigTitMVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=baRUiLRGsP2l2j5GIldyIq01ayRhDHsVv2MVni+oDphr4MFsvDNh8QKgIgDPw+oZNT6jd9ce1xBECqwwth4VMcKpWhUFeZpTcftTdtGMxcedkBewj8BXL+HNZm7twHQow6dqq6nzSiS7OGZKSm7W+Ag5+7lLgrSklPZFHXlzTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMEF++xz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so23084745e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742315136; x=1742919936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zO3ZzM+RurQ0HVvhTyBHJz7UiXcbKFmS1I/Hti/J8oU=;
        b=IMEF++xznRWBbGnEVR1uyOMRMfyQ7MusizATOpJ8DBaFuhYMbyMVhXrdUsrgyGHusu
         aYUZ1ZP9B1seHM76AirH4sy1RdAIsHVvX3Hk3C1h2+auz+6iFITJvNRZeyC9uFX5aaZw
         09a4FcpGI517XIK3t6Gb+nZCtmWMaiiPfISh5d/DQk7zbK4gH0MDJUkRHVIyp5p29BJ4
         AIGSvV4RzZyC2e4t4ubEjSKJ2IxmHbDLHc61Y6i6J7TtDCWyZxlcA1GvG7bz/7+t6jbZ
         Kr2l/8HGqZNnmaTwNuMxi+a7XeCQUOCZJ64mu9fXZMjAwD0qqUa/qCUUgPf+6oon5hpT
         R/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315136; x=1742919936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zO3ZzM+RurQ0HVvhTyBHJz7UiXcbKFmS1I/Hti/J8oU=;
        b=UPKH7cCBeqbmJyy1uqjGM4tYPWEkvaKeESIHJFOT010+ICU7rsocYQrbz98IQ+Fwgc
         0bJ8+NG1fd9utywaA6gIgj51ISAnhg6DLV+JCJxJp3hgkWPIS5IwRyYfG3ZFWdK94nzk
         3vNacJqX/RXlzkK2OYOuCPH+mISK4FwUtT1wQeAbSeDkKD9XoCLkWLSTL6HczCHUyFKY
         KSUQFmzy5hjA/zswEl6RsojF6P8/zAZVYjla7ctaIgcIRdmmL7dNOw9xs/H7wvTgRXuG
         VF6bjgb9isqo0HNZlolmCbxk3vyX73OOq8xiNMNet8S0tPh04mnkVWclx4fngCS9jMKY
         bdkw==
X-Forwarded-Encrypted: i=1; AJvYcCVs/bHhJfRlSNPRnckUcgGL7dzaVV3Pw7jf/+zXSs7luFAxOJU7FgdqiWFphHtqmD6nDxddXQ/tdJD0yKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF4WnKhcudJBhn4Bcx715G6mq8NSkQmYVvI/Hwh3gTDzd9RnuQ
	sucmXRBjQyyX09kDr2kLXh8pKqa6DloDkxbW2grrnOR7JFrUum840xs5CRxHASejWFZRvjVgOIv
	Qs9fPy6tEA80jg5qPjf7zIE1oog==
X-Google-Smtp-Source: AGHT+IHi1UgeMel0/A+rXKxvMkXf6AY2s0C2/6FsLbf6+yhSlW/MgJVCp1Jp/o/iLc/G34hYG7cfGijEvYJBHA3IS0U=
X-Received: from wmbbd27.prod.google.com ([2002:a05:600c:1f1b:b0:43d:4055:98e3])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470e:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43d3b9dc569mr30076925e9.30.1742315136406;
 Tue, 18 Mar 2025 09:25:36 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:25:10 +0000
In-Reply-To: <20250318162510.3280359-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318162510.3280359-1-sebastianene@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318162510.3280359-4-sebastianene@google.com>
Subject: [PATCH v3 3/3] KVM: arm64: Release the ownership of the hyp rx buffer
 to Trustzone
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Andrei Homescu <ahomescu@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the release FF-A call to notify Trustzone that the hypervisor
has finished copying the data from the buffer shared with Trustzone to
the non-secure partition.

Reported-by: Andrei Homescu <ahomescu@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 9 ++++++---
 include/linux/arm_ffa.h       | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 6df6131f1107..ac898ea6274a 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -749,6 +749,7 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 	DECLARE_REG(u32, uuid3, ctxt, 4);
 	DECLARE_REG(u32, flags, ctxt, 5);
 	u32 count, partition_sz, copy_sz;
+	struct arm_smccc_res _res;
 
 	hyp_spin_lock(&host_buffers.lock);
 	if (!host_buffers.rx) {
@@ -765,11 +766,11 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 
 	count = res->a2;
 	if (!count)
-		goto out_unlock;
+		goto release_rx;
 
 	if (hyp_ffa_version > FFA_VERSION_1_0) {
 		/* Get the number of partitions deployed in the system */
-		if (flags & 0x1)
+		if (flags & PARTITION_INFO_GET_RETURN_COUNT_ONLY)
 			goto out_unlock;
 
 		partition_sz  = res->a3;
@@ -781,10 +782,12 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 	copy_sz = partition_sz * count;
 	if (copy_sz > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
 		ffa_to_smccc_res(res, FFA_RET_ABORTED);
-		goto out_unlock;
+		goto release_rx;
 	}
 
 	memcpy(host_buffers.rx, hyp_buffers.rx, copy_sz);
+release_rx:
+	ffa_rx_release(&_res);
 out_unlock:
 	hyp_spin_unlock(&host_buffers.lock);
 }
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 850577edadbc..32e235a2bedf 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -223,6 +223,9 @@ extern const struct bus_type ffa_bus_type;
 /* The FF-A 1.0 partition structure lacks the uuid[4] */
 #define FFA_1_0_PARTITON_INFO_SZ	(8)
 
+/* Return the count of partitions deployed in the system */
+#define PARTITION_INFO_GET_RETURN_COUNT_ONLY	(1)
+
 /* FFA transport related */
 struct ffa_partition_info {
 	u16 id;
-- 
2.49.0.rc1.451.g8f38331e32-goog


