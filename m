Return-Path: <linux-kernel+bounces-443681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383F9EFAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BDA16BEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D61242ABB;
	Thu, 12 Dec 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSZDZUrI"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34D242EFE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026807; cv=none; b=kddswKL344XeE6aGNfDcPdYrbVgg7gGHz8vMyTF/5lxjVka47IxuC7EX29jiF24bZ0kB6tEiyD9goSzIp+oQnqoUMcvqRw3Q90R2MsCGgoqGhm0rMeKpM5rwHe1I1QCVL/6uVv3hrHvM/1WgCEQ6y4T/5Zw4fDUF7xWhVdrKkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026807; c=relaxed/simple;
	bh=P++rIyJ+yBr2b2PG0f2OKkeFdIE8TkpF4epFXwZ2v60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AFduQ3/6N90R8M5sAj4FQnRkSBobTNrQcWmQ2F1o3GfpYPjUpA1copvK8IYn3EitPIZscjOAmh8Aes1y/k4uP+laMILc7cLcx8TezmBNyL4CfcesHPFLYXWI6lIiJ+APYp/5Q6kIjlQbWnnAggm7HPzpmlPYY8dZICMjQ3ic8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSZDZUrI; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385dcadffebso432404f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026802; x=1734631602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyZdzXRtf8rptaiCXBMnMziyj8QgYtzTFp7Z15tvNkk=;
        b=OSZDZUrIs+ZS+eDeHed7AlGBDz/UKkynDUU0RQVJWEdQZTvlgVyuKlTiTcGtHlPb3h
         +CBypEJ6uIpe8T+riAjTweoo7OxEVoXXULXcut3hn8xY4UInL77a0VRcMBB4HGMW1xTK
         f2AKulqaFUGc7OQ0Wpgr4MQFbo2TBc6aqSsQu1+L8eA1UVEFNgNAuz6fHjFIEvUS6kec
         hkRo3kiZ3c7Qq+fo8ka5AypBnF/cftjsflWEmmXlChVvVxEZENt42v3rYCVjJoyupEzo
         PMZEWjWB8uFRu5uA98D/a+Yt8ruEekgV5TT5H3HfF41NuTRgM6ZKHTg4KtPW0nLF5l9X
         djhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026802; x=1734631602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyZdzXRtf8rptaiCXBMnMziyj8QgYtzTFp7Z15tvNkk=;
        b=llceoU9w820qb3q9GczLLHjfgSOA2vWw3ssMVesOY7V4XmBYgKNwWo2vKzfyZeBZI1
         KNRHnAan2nHK8/w3+7cK8tbnN8w/jbt62sc2KL6DMZ5+mBLkf8KxB94JyGfgWtdY5G9I
         qDYr4PC7HectDECO0fcPzxKvJUgSZLwIn92G2KCzT/eQ1E1phSOwiT5KEGZ8ZwLKbAQ1
         Tj0LdDKly8yz/FS52+oLiEZjS4x/cTSte2zHUUmUBNs4P9xYddyld4jmKW6cGbQtkEKN
         sKmq9jb2Tfsim6o6UqVZdd1tG36eBGQIuMFco+HdNGJYfHFCaoBz4ZI/IZJLw9r62Jb9
         M/DA==
X-Forwarded-Encrypted: i=1; AJvYcCV5PPdaj14VafSkwXgKmnPkKfSyaVus1mHxFVRNGO8CRizjQLiXJzgu1U2/IIJFduk1sx0CK43bnJwstE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIWyFQMnokmOLaY7jdxI1vzknIEy7qolHhXQmItd6aqD9M5M8
	bcUIo4w5vvMJ8wldR2PatgAMq1p9M9naMWvkcYqZvq0r0+p6QHbi456pi6UGImdIVGRlH/dnH78
	TGzZ54dYmxg==
X-Google-Smtp-Source: AGHT+IEWuyPM5Tx5DrErgHedylcB+E6oTYTHFOjRcJ9mqKpISiuwj0ormAbEHASo9YOkKlzy9zSUKaeU8xtaEA==
X-Received: from wmbay15.prod.google.com ([2002:a05:600c:1e0f:b0:434:ff52:1c7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5886:0:b0:385:faad:bfb9 with SMTP id ffacd0b85a97d-3864ce8644emr6392550f8f.8.1734026802739;
 Thu, 12 Dec 2024 10:06:42 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:21 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-58-smostafa@google.com>
Subject: [RFC PATCH v2 57/58] iommu/arm-smmu-v3-kvm: Implement sg operations
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

Implement the new map_sg ops which mainly populate the kvm_iommu_sg
and pass it in the hypervisor.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index e987c273ff3c..ac45455b384d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -445,6 +445,96 @@ static phys_addr_t kvm_arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return kvm_call_hyp_nvhe(__pkvm_host_iommu_iova_to_phys, kvm_smmu_domain->id, iova);
 }
 
+struct kvm_arm_smmu_map_sg {
+	struct iommu_map_cookie_sg cookie;
+	struct kvm_iommu_sg *sg;
+	unsigned int ptr;
+	unsigned long iova;
+	int prot;
+	gfp_t gfp;
+	unsigned int nents;
+};
+
+static struct iommu_map_cookie_sg *kvm_arm_smmu_alloc_cookie_sg(unsigned long iova,
+								int prot,
+								unsigned int nents,
+								gfp_t gfp)
+{
+	int ret;
+	struct kvm_arm_smmu_map_sg *map_sg = kzalloc(sizeof(*map_sg), gfp);
+
+	if (!map_sg)
+		return NULL;
+
+	map_sg->sg = kvm_iommu_sg_alloc(nents, gfp);
+	if (!map_sg->sg)
+		return NULL;
+	map_sg->iova = iova;
+	map_sg->prot = prot;
+	map_sg->gfp = gfp;
+	map_sg->nents = nents;
+	ret = kvm_iommu_share_hyp_sg(map_sg->sg, nents);
+	if (ret) {
+		kvm_iommu_sg_free(map_sg->sg, nents);
+		kfree(map_sg);
+		return NULL;
+	}
+
+	return &map_sg->cookie;
+}
+
+static int kvm_arm_smmu_add_deferred_map_sg(struct iommu_map_cookie_sg *cookie,
+					    phys_addr_t paddr, size_t pgsize, size_t pgcount)
+{
+	struct kvm_arm_smmu_map_sg *map_sg = container_of(cookie, struct kvm_arm_smmu_map_sg,
+							  cookie);
+	struct kvm_iommu_sg *sg = map_sg->sg;
+
+	sg[map_sg->ptr].phys = paddr;
+	sg[map_sg->ptr].pgsize = pgsize;
+	sg[map_sg->ptr].pgcount = pgcount;
+	map_sg->ptr++;
+	return 0;
+}
+
+static int kvm_arm_smmu_consume_deferred_map_sg(struct iommu_map_cookie_sg *cookie)
+{
+	struct kvm_arm_smmu_map_sg *map_sg = container_of(cookie, struct kvm_arm_smmu_map_sg,
+							  cookie);
+	struct kvm_iommu_sg *sg = map_sg->sg;
+	size_t mapped, total_mapped = 0;
+	struct arm_smccc_res res;
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(map_sg->cookie.domain);
+
+	do {
+		res = kvm_call_hyp_nvhe_smccc(__pkvm_host_iommu_map_sg,
+					      kvm_smmu_domain->id,
+					      map_sg->iova, sg, map_sg->ptr, map_sg->prot);
+		mapped = res.a1;
+		map_sg->iova += mapped;
+		total_mapped += mapped;
+		/* Skip mapped */
+		while (mapped) {
+			if (mapped < (sg->pgsize * sg->pgcount)) {
+				sg->phys += mapped;
+				sg->pgcount -= mapped / sg->pgsize;
+				mapped = 0;
+			} else {
+				mapped -= sg->pgsize * sg->pgcount;
+				sg++;
+				map_sg->ptr--;
+			}
+		}
+
+		kvm_arm_smmu_topup_memcache(&res, map_sg->gfp);
+	} while (map_sg->ptr);
+
+	kvm_iommu_unshare_hyp_sg(sg, map_sg->nents);
+	kvm_iommu_sg_free(sg, map_sg->nents);
+	kfree(map_sg);
+	return 0;
+}
+
 static struct iommu_ops kvm_arm_smmu_ops = {
 	.capable		= kvm_arm_smmu_capable,
 	.device_group		= arm_smmu_device_group,
@@ -463,6 +553,9 @@ static struct iommu_ops kvm_arm_smmu_ops = {
 		.unmap_pages	= kvm_arm_smmu_unmap_pages,
 		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
 		.set_dev_pasid	= kvm_arm_smmu_set_dev_pasid,
+		.alloc_cookie_sg = kvm_arm_smmu_alloc_cookie_sg,
+		.add_deferred_map_sg = kvm_arm_smmu_add_deferred_map_sg,
+		.consume_deferred_map_sg = kvm_arm_smmu_consume_deferred_map_sg,
 	}
 };
 
-- 
2.47.0.338.g60cca15819-goog


