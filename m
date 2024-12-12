Return-Path: <linux-kernel+bounces-443645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644839EFA70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C753C170C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF72358BD;
	Thu, 12 Dec 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xicHqKN1"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FB235887
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026730; cv=none; b=kfxppNrYYtMM0DMinDvkytEL7tYAH7HmJVdTzi0H4K9SZY06pAhdOpmNQv9uIfDieT6xzigqb9uWH5eGkGetQIrkPCSUNYmlrwiPnSb+ZgC0qxq+S5Jwa11827hYt1c8dj2n7CP/HulXCvqLmZ5hoB1zlFlvOJB1SLf4pFR2BJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026730; c=relaxed/simple;
	bh=93WTzLCk66oie5FDAwVxQF18Hew2J+sHUmJc+JJamG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JlLulBVroYe9IWxuJ3AWCejycd9hObKwKN/crzg3hweXrOBl4cvTdm5cLJ3f3saO17C9I6nTYuRfG4EkKGbyIw9hNzhKdKLj5O2sKVBYMYyw4vCdlWVOMFSNG9VEeFsJqfKySzJ7jk9iO3ty9fVRviVdkwKzPQGK4NF+3W/64hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xicHqKN1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso8314975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026727; x=1734631527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/Ra//4VkvS4Qrc/csXRRquQ5N0sclWFpXtLU13M1U0=;
        b=xicHqKN1pPvMhPNh7LWMUyhLFxKNiUQaoSzOfu8BMarRBplNFm65IaWkmpAhEXvtsu
         3djDwEJPY7Phg9L/GyLIDehrdZrA3UMhgWpxqEdGwAGdgQ1nYkAB+3Olncf/EitUf2N1
         6T/koq2QoG/Xfo/LLPXgeBA4CNbe0VVDf2EOCz9xLwWjZ73xjQx6xwt+trK0PIFtjRdm
         1nNQwY4xJLDIMKTIWw8t9ePqL0M2F26XYvPT+7P0kjl9VHPBIvOLwilX9SAHkjARTdso
         hZXycZDQd285x7G6MTH1fya6wIjm6Bw+8YdAv19j6W7chTMehQaJxL3OIzN4+wxSMXCb
         tMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026727; x=1734631527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/Ra//4VkvS4Qrc/csXRRquQ5N0sclWFpXtLU13M1U0=;
        b=jUmK5M1tbASfZcTWkgDg7jG1/7Aj3Ej6lS6sQOBMeC2676mT/4q/XJbcw0KzuuWcGk
         0u55iTNV+ILyxzmH6MkA74bAncXCkXl1XWbOW95cjvSxD1rCHauFBjWzWv1T5xLdFGXB
         +PtOq8QG7fY5+gSvp9OWmWgdM6xKUiSPGl1aTI7UzfM2Gni9fH9b3jMHZD7BkdbSpR4A
         LHf3BR3InhV3qcaZ37lDgA3yzL1sHX/i5r8mxzxX/M9KDXWBOjU6jYrzI2ZfoutBW5VX
         Lv2qkrbn7/hge+3mCb6IKInfewhiOysaod0MY1wqgj8IlEA2Y89IJKRNHJ6AAT7zIxpJ
         Ei7w==
X-Forwarded-Encrypted: i=1; AJvYcCW2yNwrrUHN8IKqH6abJ8ot0GHcqRFHCVoMNwJTh8ldlHgzPeydEHBeYm3vAVefzj36RZjMRZNsCvNgb3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZV8oSVkoJgiQNAapXrlLGtEDajRmcCBhUrGxauy3NQZ/LNLDO
	0mSGCMkJwpY8nPRi/RLWS42oUt3Z6nSB/zCwlMSNe2SoW6B1tlp76N9XNCUiuBYz4NnIAj8utkE
	04sdTJhI73g==
X-Google-Smtp-Source: AGHT+IFrLa5teCkiJUmugRTGmiVyWcF7Bk2iiIesqhTlDV4Jk+wP67mU9JHmnXeWzq6SoD15OWfRPDjTEIR09g==
X-Received: from wmik26.prod.google.com ([2002:a7b:c41a:0:b0:434:f801:bf67])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4446:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4361c3723acmr67363395e9.13.1734026727341;
 Thu, 12 Dec 2024 10:05:27 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:45 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-22-smostafa@google.com>
Subject: [RFC PATCH v2 21/58] KVM: arm64: pkvm: Add __pkvm_host_add_remove_page()
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a small helper to remove and add back a page from the host stage-2.
This will be used to temporarily unmap a piece of shared sram (device
memory) from the host while we handle a SCMI request, preventing the
host from modifying the request after it is verified.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index d75e64e59596..c8f49b335093 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -94,6 +94,7 @@ int __pkvm_guest_relinquish_to_host(struct pkvm_hyp_vcpu *vcpu,
 				    u64 ipa, u64 *ppa);
 int __pkvm_host_use_dma(u64 phys_addr, size_t size);
 int __pkvm_host_unuse_dma(u64 phys_addr, size_t size);
+int __pkvm_host_add_remove_page(u64 pfn, bool remove);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 0840af20c366..a428ad9ca871 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -2521,3 +2521,20 @@ int host_stage2_get_leaf(phys_addr_t phys, kvm_pte_t *ptep, s8 *level)
 
 	return ret;
 }
+
+/*
+ * Temporarily unmap a page from the host stage-2, if @remove is true, or put it
+ * back. After restoring the ownership to host, the page will be lazy-mapped.
+ */
+int __pkvm_host_add_remove_page(u64 pfn, bool remove)
+{
+	int ret;
+	u64 host_addr = hyp_pfn_to_phys(pfn);
+	u8 owner = remove ? PKVM_ID_HYP : PKVM_ID_HOST;
+
+	host_lock_component();
+	ret = host_stage2_set_owner_locked(host_addr, PAGE_SIZE, owner);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.338.g60cca15819-goog


