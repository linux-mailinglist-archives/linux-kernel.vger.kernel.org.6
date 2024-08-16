Return-Path: <linux-kernel+bounces-289693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6627D954A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FF1B20DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A81B5818;
	Fri, 16 Aug 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="13GawA2R"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2E1A01CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813149; cv=none; b=Xug7KvWb5km9BfRj9ZjOY0GYjookbCV/42//674ptOLLvN9JyqhvrJA4Lj5h17RwziJDb6N18oaHeO4WGRSpBULw8h0Ey5Y1U3smiZO3n/8LhwqBV5SoNKUkNthQHB+5i52HUA151qg6jjGaINCwVoI9+DpXaalwA8VHBlPkaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813149; c=relaxed/simple;
	bh=bmIKnf+aYFVfy2PtsWNu8vvl7H49+OOvZsr2wuRYyYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nWtno+1h2QSxDNKbtoJFhO4gRv7hlwKWbjc1eemuoMbDGbwniPZGh+UBfEgR3Cm53smTBsFJL1wQE1h5I4ISAJM7fEuZbLTLBWt7umjDmdYebOUxd6fIiA3jAgFniZfmLHDHWvVYU9f/Tz6oa0ZB9GyktQ8G1K7jKp4UF66e/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=13GawA2R; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42820af1106so14118245e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723813146; x=1724417946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUuRruggY6sGV8WBcDN0bfpHup5Gn81C3NBKfiCKxF8=;
        b=13GawA2RQ3vmRbOKqXfBSRb9yURF7I5evVxq65X7xdf0foPN5PH8T5V+Bhp1UExkew
         dUXMo4g6ShGCXpNaXCwXqoMcj8JswAt4YEO65XoiKFvlfzCcSEkjQtJmqXVyZ1NMF2Os
         3igVFU7fn2CXiV8IHvKgvnKY1vpeRv50FXjJOXqpcZ1AKTg3/C0+nrDTfbrwYuY/KKNG
         blr0qF0Mh3bT6jKrWW7FOG81IyaJWAUrxk3z/NSEBOCdz/BwAhMixkZfnoxPwV+/Unzp
         aHkOxILvQGMxjMxtmwez4IgWpj+FHBIgu4YUyoh7lVQwZWSiebj3KYTJGTiceBKYrySq
         GwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723813146; x=1724417946;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUuRruggY6sGV8WBcDN0bfpHup5Gn81C3NBKfiCKxF8=;
        b=tSW49ZkUewnLuf28QGeyT+c9V7eykzIUu2rv5iFbO3U7SQEjA6iV6AzZWfV7hD/n3z
         vhGrMRCuC8hUWzA/GrOLKBUlkJl3/qX5+ivlJ8grvpCeR9bPZsTsUr7EVlR1w5qq7aj5
         PPeQX0DjN4E8Iz2bG7I9orvCvJI+gSn2Yl48aj32C2Jm9iAoa4gSu/h3wDSgjQ//iPvW
         68D8P6UD61g+LqvR8Ox2/gq4ePpOkHln2MtiIoa+Bjw5IDehNP2wYZIzkZVrovZ6HM54
         6Y9iWFIkprkpo9oY4EfWvjUPUeo6b4GFIrRxNJHgwrmv1tGGHMqIPFus/HQoaLfEPft8
         QhGQ==
X-Gm-Message-State: AOJu0YxsaMzk4xZ86UOg76F+r6xOdphLwQVg5rzmMmVR7L6Vq3XTHsAX
	aNXwBpagge61ilV+O1SKVnY7I4W3CA2mvqCi4LtyICTJ+2GHkMfBA5uETc5A8JMyJ6FcY82n2pT
	fNLOgXOMc9Xa1nCxHOOpTDfSyAV01URihePvNehcmqgU8eJcOrrNQA7MC+duBv8Oxbsou/QFMqe
	11XMlfhAvxXuOOuGgux8aNbafCxWz0v/aE0mMsHqbidueTHU4GEr8=
X-Google-Smtp-Source: AGHT+IF3c31cZ4DPn0r2ni2UeKQVM2zXgvvKXtpEYOooEILBNhmH81y68JJGWiAdVf4AXsSFddC/hPe/MlToXA==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:6b08:b0:426:5c35:ffce with SMTP
 id 5b1f17b1804b1-429ed7d68bfmr186365e9.6.1723813145790; Fri, 16 Aug 2024
 05:59:05 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:59:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816125901.3773388-1-smostafa@google.com>
Subject: [PATCH v3] iommu/arm-smmu-v3: Match Stall behaviour for S2
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jean-philippe@linaro.org, jgg@ziepe.ca, nicolinc@nvidia.com, 
	mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

According to the spec (ARM IHI 0070 F.b), in
"5.5 Fault configuration (A, R, S bits)":
    A STE with stage 2 translation enabled and STE.S2S =3D=3D 0 is
    considered ILLEGAL if SMMU_IDR0.STALL_MODEL =3D=3D 0b10.

Also described in the pseudocode =E2=80=9CSteIllegal()=E2=80=9D
    if STE.Config =3D=3D '11x' then
        [..]
        if eff_idr0_stall_model =3D=3D '10' && STE.S2S =3D=3D '0' then
            // stall_model forcing stall, but S2S =3D=3D 0
            return TRUE;

Which means, S2S must be set when stall model is
"ARM_SMMU_FEAT_STALL_FORCE", but at the moment the driver ignores that.

Although, the driver can do the minimum and only set S2S for
=E2=80=9CARM_SMMU_FEAT_STALL_FORCE=E2=80=9D, it is more consistent to match=
 S1
behaviour, which also sets it for =E2=80=9CARM_SMMU_FEAT_STALL=E2=80=9D if =
the
master has requested stalls.

Also, since S2 stalls are enabled now, report them to the IOMMU layer
and for VFIO devices it will fail anyway as VFIO doesn=E2=80=99t register a=
n
iopf handler.

Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
v3:
- Set S2S for s2 and not s1 domain
- Ignore ats check

v2:
- Fix index of the STE
- Fix conflict with ATS
- Squash the 2 patches and drop enable_nesting
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..d8fe16901afb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1646,6 +1646,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste =
*target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
+		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
=20
 	target->data[3] =3D cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -1739,10 +1740,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_devic=
e *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
=20
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
=20
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..0dc7ad43c64c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -267,6 +267,7 @@ struct arm_smmu_ste {
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
+#define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
=20
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
--=20
2.46.0.184.g6999bdac58-goog


