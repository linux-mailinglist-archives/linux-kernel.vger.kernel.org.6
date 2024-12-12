Return-Path: <linux-kernel+bounces-443658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D79EFA71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041DA28D643
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AC92288C0;
	Thu, 12 Dec 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6ba5Gr4"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357423A1A0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026759; cv=none; b=kyeZa5GC1FyIfUMCp6/JtuLJIyqsWDddxb19VZUoGEtmSHWD1xD9PDLLuZBUApZ5kiBb7gXhuLjMYmT/Nv+p1TRyb99j/cRY9W3ZRi2EO9OpvmCpQUtJqlH4RzZbBkfUeZYVQiJlJXUAgMV7mNy19Fj2HQ/GLsX9OLegMHIflRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026759; c=relaxed/simple;
	bh=xoLHfhtpFrxTH540A3d41QMdNpP9ylrvZba0P+No9Hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WEjwPw7rT8DGYc6UVgogaYHBxzNgs6tSEjKtudj9YW+m7EptjYP8RV3sbfJasBoHVBqK8ntMuTtEz/ZsheweP3eLGkTDfKvF1UGSsAcLKhO2v8UuMAdizT/B8QJV+oQQiLVweBNSMu+poTo+4+fjEK+kyrcUtOLztDXkh8R3Pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6ba5Gr4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43627bb20b5so4508065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026755; x=1734631555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jsol/FD7xLO/XnO3v0kMgo+OuMQmHauwbh0Fn9n2Qc=;
        b=R6ba5Gr4IDjmdpBU6Mvb9qo0s+/aC4wfWXqSlt8ES4IKvzAQBEDcEE1TvOu4uEp9TX
         QAZKG7wx8lIEQDw5KnvFGna9T05/dFoVrbJ/Hf958ZhuaWPX0MvZdhPetvRWHKF2xqJQ
         jqhPvFBUuRUhjvwVoI08uY8JWRYJRe3AveGyYtlIzuonjEmPV4F26qZ5zOWlJMMnACIv
         oh59Xpw4CDkc2HoY6tYXcJkKtwjhS0W6jhcBbbuEIR2kgJaVErxmwHUceRMNLA3siBD9
         PPeHkYBxDWpK1MowRln0DDaOwqCmt9qPzuIwvctBe9JbMXC6+RJN2g8qTM6x9eXJFpUs
         J5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026755; x=1734631555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jsol/FD7xLO/XnO3v0kMgo+OuMQmHauwbh0Fn9n2Qc=;
        b=PUne/X+8NTUndWI7kvJ8E4lMp+IOGDvViUwfAayZVLlUagRmKPGamWfBCVOLKRLe8Q
         CBwPxsQ8MCPpTygoQywHA1vkLKN0UbCFbu7bzgahILFDXUvMG+sBHNI/FF4hr/bsjn0V
         aPZ6QlgkqKNt70+sFg8g+9eYgK87TQxg5gF0pwLJPsM9i02/QlRaXArbW8uvGlRWPi+1
         9a0RwMfAKz3QKAePIBSBUa5Ud/cAnx6aaYvhZCMhJviJG2REkdpUeOz+NhDenDBsvpY4
         ugVrE+teTkEhazpOwpNb3enZ/EsXnzW0ILVEf1Z4IqM7rCJgqSjYLBnLqCtAfD1F9rG9
         HJNg==
X-Forwarded-Encrypted: i=1; AJvYcCUUyPyc0gzFVEKtLU0aCkX7Kzeyo4gM4YNa8NZOiKkmFN3B4OinF2uPBz+IVI/pQKydcfNh4HEmxG9bNVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEOc1jYvRsmUfEsnh04gsCmg1En3kT0jnXYHYn8UyAKSxV79q
	2GAYolBC3DfvDl1sXAKmM/MMoV14xa3wXCVplpm2nzWqDBTtfHlZvUVOIvrbNEoET0wMCMPZe4+
	bWptJNSZUVg==
X-Google-Smtp-Source: AGHT+IFPvic4v0yXTXsiiS55qmyvRxNfbGXACyTICF0QYMQMm//s6fh52UUXvcsaAQ5ADTdRambhNe92sr/RSw==
X-Received: from wmol7.prod.google.com ([2002:a05:600c:47c7:b0:434:a471:130f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35cb:b0:434:f9ad:7238 with SMTP id 5b1f17b1804b1-4362286391fmr34351085e9.22.1734026754968;
 Thu, 12 Dec 2024 10:05:54 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:58 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-35-smostafa@google.com>
Subject: [RFC PATCH v2 34/58] KVM: arm64: smmu-v3: Add context descriptor functions
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

Add functions to allocate and access context descriptors that would
be used in stage-1 attach.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 5f00d5cdf5bc..d58424e45e1d 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -215,6 +215,19 @@ static int smmu_sync_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
 	return smmu_send_cmd(smmu, &cmd);
 }
 
+__maybe_unused
+static int smmu_sync_cd(struct hyp_arm_smmu_v3_device *smmu, u32 sid, u32 ssid)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_CFGI_CD,
+		.cfgi.sid	= sid,
+		.cfgi.ssid	= ssid,
+		.cfgi.leaf = true,
+	};
+
+	return smmu_send_cmd(smmu, &cmd);
+}
+
 static int smmu_alloc_l2_strtab(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -291,6 +304,46 @@ smmu_get_alloc_ste_ptr(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
 	return smmu_get_ste_ptr(smmu, sid);
 }
 
+__maybe_unused
+static u64 *smmu_get_cd_ptr(u64 *cdtab, u32 ssid)
+{
+	/* Only linear supported for now. */
+	return cdtab + ssid * CTXDESC_CD_DWORDS;
+}
+
+__maybe_unused
+static u64 *smmu_alloc_cd(struct hyp_arm_smmu_v3_device *smmu, u32 pasid_bits)
+{
+	u64 *cd_table;
+	int flags = 0;
+	u32 requested_order = get_order((1 << pasid_bits) *
+					(CTXDESC_CD_DWORDS << 3));
+
+	/*
+	 * We support max of 64K linear tables only, this should be enough
+	 * for 128 pasids
+	 */
+	if (WARN_ON(requested_order > 4))
+		return NULL;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		flags |= IOMMU_PAGE_NOCACHE;
+
+	cd_table = kvm_iommu_donate_pages(requested_order, flags);
+	if (!cd_table)
+		return NULL;
+	return (u64 *)hyp_virt_to_phys(cd_table);
+}
+
+__maybe_unused
+static void smmu_free_cd(u64 *cd_table, u32 pasid_bits)
+{
+	u32 order = get_order((1 << pasid_bits) *
+			      (CTXDESC_CD_DWORDS << 3));
+
+	kvm_iommu_reclaim_pages(cd_table, order);
+}
+
 static int smmu_init_registers(struct hyp_arm_smmu_v3_device *smmu)
 {
 	u64 val, old;
-- 
2.47.0.338.g60cca15819-goog


