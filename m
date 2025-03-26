Return-Path: <linux-kernel+bounces-576917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17BA715F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F3179495
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAEC1E32C5;
	Wed, 26 Mar 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeBKjAaC"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49B1E1E0A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989154; cv=none; b=Urtc/RD3KFpzgq9Qjg7aR+zTdO0+zUX7/X4AEgNCoOyPqEfB8BkoXAfCmJdBsdcmetbkg4ZDXuhhmaqQSuYBRXTYvrdItXWPog83d86IqJY081/lM4X5K3FjUv/2p+nv9kKJEfO/Y1uxXcKcsgvFlVSCZzEGPlySZvVt0dbvpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989154; c=relaxed/simple;
	bh=gBk9lt7tJRLeaaZ+rHtlU9qDo0L2uhlfMTlwA/Ull7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/FdqeMzr4RiCBbOMyjegRs2RlA+/Gfp8Hu8E9FBv+BLzoNvE+iQHUhvQCXH7GUKkvjBrsQSAzOiEVZ1id8pQgvc9wITeAcojwcwTiSJjzFCmTYmUZYTC9n3Ddi3uRbgWa6PYFDMiVA/XOOYPh5cj4mIlsv9WBCqnD5jmYK3h2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oeBKjAaC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so35350815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742989151; x=1743593951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHf91QhT51iYy83lJisFmODA+pFXdAkAB/GuCBpC2zk=;
        b=oeBKjAaCQJTYZmnJxRxZdRbWE4dPgXv4VIXzrSf1cm/ILybF0ZsYNA4MBYW/5aagAr
         uARAPq1Rdxyi83S/ez50ReTyKYqCfuC8qgSbLj7nUtDS/DxDAd0AjKH10iLHy12qNfoq
         7Fiw28K2FoIdGL3HhJhXISPoW+6R3vv8xkAZirmRIR7RN3nM3aPN2it5mvyDQJPHFsOK
         Z1uCsvaGESA+crST8tcdIE8PVJ6TDiDJKMtLANlq0Fs3fVgWkLCpkYqxwGgjBcu1YmRy
         F/z2HcaJIF7bIeP30glLZ4sHPzpALv7XBjWgxkRI/8So4C1dctDgvo/n3T0v7qF1y0rc
         0XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742989151; x=1743593951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHf91QhT51iYy83lJisFmODA+pFXdAkAB/GuCBpC2zk=;
        b=ItoZn9ByXs8xUH6QPYRIdycGGIAXjcyDXQ6gDOEBOZ3DrKsI0X5tIy5todl4nenQD4
         6q8EQ0JiPCsgvLEsKNuv4ASxPZXKaeVc5G1R2CAsuPJWCi8tnI66nf2EOqihNRrWVSFy
         oyIDZ4QmGr+By4xC+unr37sUMJ7ne2/bDMWO9xvxjgOr4JKUBAQuIlq5xvf/JPrkdBY0
         9WaLPXZr6utA0TAo6Ce+SrrVknfBFb3HrnsNePgsTTe2ks159kqqPR6cpAiMZzaMSKrW
         i1DU5LApfpOBaNoC75ghm6dSMx4CsAmdsKzHIWUVtecZn3i55g8aaIc1aYzHzd3MLw3x
         aRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgFvONAldkU8qn15E5mJ4/NcZwx7aShjW7lLvzd97Hqjr8AclwxOPc6VFIf2TP06NaWZGqNN9tV+YeV6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6m6aVPPUbZgcdoTPGC3AJ4ZE5w2wm3HtmTiSGBLDr0ubuxpz
	VcnJMYks6mqb9AxUo1msvbqdmmuJ4iUle+B3yJBl+CRtFE/FH4kIeFELhkt9OjUcI9coZE5Z1fI
	T702cFqJb+s33QPanSMJm3agCpw==
X-Google-Smtp-Source: AGHT+IHs0QnGDLw9n/4cRwsa7oyAsEcllQx68V0oWKnfOqB/3TAlLPJ14NKv8m2ojEKJA3YBjubucjAO0uNkMu+4Lz4=
X-Received: from wrck14.prod.google.com ([2002:a5d:524e:0:b0:390:e325:456e])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6c61:0:b0:390:f902:f973 with SMTP id ffacd0b85a97d-3997f8f5c08mr18860296f8f.8.1742989151526;
 Wed, 26 Mar 2025 04:39:11 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:39:01 +0000
In-Reply-To: <20250326113901.3308804-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326113901.3308804-1-sebastianene@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326113901.3308804-4-sebastianene@google.com>
Subject: [PATCH v4 3/3] KVM: arm64: Release the ownership of the hyp rx buffer
 to Trustzone
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com, qperret@google.com
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
 1 file changed, 6 insertions(+), 3 deletions(-)

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
-- 
2.49.0.395.g12beb8f557-goog


