Return-Path: <linux-kernel+bounces-443660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECF9EFA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D70188AEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89223D420;
	Thu, 12 Dec 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5xP6Yqx"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09723A575
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026762; cv=none; b=ZJnzdIYzJjvb9K9Iu8OL5A/px/NR+Z1cU++7mP4Cfe6FzQoOO2tevYoQcJNblLmSBNytyuIBUNNccYASwdVpBRB1/6iOlRIqB4zZ3WiE8/43rrHxolJ+F+LuCctUl3WVSLKdTq/xBqDhnnHOCEcNO++aPdA9wxb47lIz/AEOF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026762; c=relaxed/simple;
	bh=Esq0hs9+O5d4DdE62i+3pgWl+hf7rAK4wQPxx+ppKUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejnUnjaqNBrG5lF69r3dRjto8d+fBkdHzaJNm0656g8IAM24rIAuZrC4C3TfGoXdtTfJJa89MDh+PseMFkASYrlBQHqIDxQn/9z3UDPQVygyp93bG52rPi3M+EUkYk5HBPaxTvq4SkCBjGHewvOI9GvYF7m42we9zDIlqdSPwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5xP6Yqx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434f387f346so5761875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026759; x=1734631559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUMjhbgyZS8tSMuBeujFF8/B0cPiplUozEzmSYJ1apc=;
        b=k5xP6YqxhxEc7+QrSlY39QJuZ3j+h9CTRQvxEzZB3xoaskKuscdvtZW+YDMD6RtJEW
         K0ZdZj34lHKWfnr28Ma8xs/zFPstMxHjmotK1B0qBRrQq0xIcEbyhTF7eGmZkZhvLmmz
         oYeq+mmzU0643xh4MzkSrsBbeh3iCIbi9R7tWk40HK7EgsgkPW7fIX+Ues/KhYhT83mZ
         WHxnCQgvheiwZuC3M8kCSMGJTw97Hi0L5vHvPFEWSZeKOcO0g2FA/GV59WuqjPAOEFQE
         1JX+7NbmI81oNnojDQtW02PGJSTjc965jWPJj0uvFTeT+VaTnjrtFfYgtlpeUSl5oGBf
         TVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026759; x=1734631559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUMjhbgyZS8tSMuBeujFF8/B0cPiplUozEzmSYJ1apc=;
        b=WLLfxTYvu+VVuC0bo0bZ5x0QaxqEMbIqCX2/ANerQ2sB8Z55CjtFti1CX9+c10AyVi
         7Sbxv99z2BjxBsD2U5BcOeOrPyj0LNrY+2tH3YjqKIO1ZRJFO7z+2F0TRMzk04s0SwMZ
         VulBoFYMXmfFRxWcjxcpNOePMVsuib2TXmbEkyPLbdR81N+7T9q7pliMeCz4sps6iroM
         ZOt1afE275XK74EHZBm+WCNVlcWubwMEHyAoOvMOAVzmTqSsigZsNyAdsog7KEuxq7rN
         hYKP+p1+e9SnFRx4ef71/Fj5nSTRlCOvRXvDIPCZS7pUsSxDH9ZFdLFMvSxbZEfHIlRL
         Y6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmbiO/suEMsJ+tLWV7dEftSV8kV8/T5/CUO4167kHi5bCrrDmYdD0E1W/8N2yHit97efNpFD5g4sM3oh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKv11gyFbRDipPiHwAkgCUeZaHwe8GUuDW0qtKJbzY0VDRTiSg
	7AH8VN7XPcaYThqwzx4nzKpaROfjWgoDHzzXAv1Kjngtym0NSwRdhiSkENYUxg4q47tPKRE59lq
	0/0UtZm4EQA==
X-Google-Smtp-Source: AGHT+IFcyCwxNNcgpiKYzT5jMC9sdAfx92qcWV3X5IeJOyZQbObkA8pT7Uz0LF7/zxo+itcxy4bJEL7vJH7gOw==
X-Received: from wmro18.prod.google.com ([2002:a05:600c:3792:b0:434:f2eb:aa72])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3583:b0:434:f871:1b9d with SMTP id 5b1f17b1804b1-4362287091cmr39010485e9.33.1734026759052;
 Thu, 12 Dec 2024 10:05:59 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:00 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-37-smostafa@google.com>
Subject: [RFC PATCH v2 36/58] KVM: arm64: smmu-v3: Add detach_dev
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

Add detach_dev for stage-1 and stage-2 domains.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 76 ++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index a96eb6625c48..ec3f8d9749d3 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -335,7 +335,6 @@ static u64 *smmu_alloc_cd(struct hyp_arm_smmu_v3_device *smmu, u32 pasid_bits)
 	return (u64 *)hyp_virt_to_phys(cd_table);
 }
 
-__maybe_unused
 static void smmu_free_cd(u64 *cd_table, u32 pasid_bits)
 {
 	u32 order = get_order((1 << pasid_bits) *
@@ -1052,6 +1051,80 @@ static int smmu_attach_dev(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_dom
 	return ret;
 }
 
+static int smmu_detach_dev(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_domain *domain,
+			   u32 sid, u32 pasid)
+{
+	struct arm_smmu_ste *dst;
+	int i, ret;
+	struct hyp_arm_smmu_v3_device *smmu = to_smmu(iommu);
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	u32 pasid_bits = 0;
+	u64 *cd_table, *cd;
+
+	kvm_iommu_lock(iommu);
+	dst = smmu_get_ste_ptr(smmu, sid);
+	if (!dst) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	/*
+	 * For stage-1:
+	 * - The kernel has to detach pasid = 0 the last.
+	 * - This will free the CD.
+	 */
+	if (smmu_domain->type == KVM_ARM_SMMU_DOMAIN_S1) {
+		pasid_bits = FIELD_GET(STRTAB_STE_0_S1CDMAX, dst->data[0]);
+		if (pasid >= (1 << pasid_bits)) {
+			ret = -E2BIG;
+			goto out_unlock;
+		}
+		cd_table = (u64 *)(dst->data[0] & STRTAB_STE_0_S1CTXPTR_MASK);
+		if (WARN_ON(!cd_table)) {
+			ret = -ENODEV;
+			goto out_unlock;
+		}
+
+		cd_table = hyp_phys_to_virt((phys_addr_t)cd_table);
+		if (pasid == 0) {
+			int j;
+
+			/* Ensure other pasids are detached. */
+			for (j = 1 ; j < (1 << pasid_bits) ; ++j) {
+				cd = smmu_get_cd_ptr(cd_table, j);
+				if (cd[0] & CTXDESC_CD_0_V) {
+					ret = -EINVAL;
+					goto out_unlock;
+				}
+			}
+		} else {
+			cd = smmu_get_cd_ptr(cd_table, pasid);
+			cd[0] = 0;
+			smmu_sync_cd(smmu, sid, pasid);
+			cd[1] = 0;
+			cd[2] = 0;
+			cd[3] = 0;
+			ret = smmu_sync_cd(smmu, sid, pasid);
+			goto out_unlock;
+		}
+	}
+	/* For stage-2 and pasid = 0 */
+	dst->data[0] = 0;
+	ret = smmu_sync_ste(smmu, sid);
+	if (ret)
+		goto out_unlock;
+	for (i = 1; i < STRTAB_STE_DWORDS; i++)
+		dst->data[i] = 0;
+
+	ret = smmu_sync_ste(smmu, sid);
+
+	smmu_free_cd(cd_table, pasid_bits);
+
+out_unlock:
+	kvm_iommu_unlock(iommu);
+	return ret;
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
@@ -1060,4 +1133,5 @@ struct kvm_iommu_ops smmu_ops = {
 	.free_domain			= smmu_free_domain,
 	.iotlb_sync			= smmu_iotlb_sync,
 	.attach_dev			= smmu_attach_dev,
+	.detach_dev			= smmu_detach_dev,
 };
-- 
2.47.0.338.g60cca15819-goog


