Return-Path: <linux-kernel+bounces-283780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F794F89D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F531C2196D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688319AD8D;
	Mon, 12 Aug 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qi1Jjn4F"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1719AD6A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495994; cv=none; b=ol9PpMngapH3RuZRrVC+SRFhJF3oJJLlERXKju/jifLgsc/NceIkX9aJPUjbIY3k+tugirgVkx9YocBN6Z3JmekcyTlJ3alZqG3TO+9Ycy8CDEfdg3B4j+eeDFLKS8LGBzYNT3oAWxCF42LE7TyDQ98dgaPAOWqg0kMFTaidqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495994; c=relaxed/simple;
	bh=AO7ZaM0rV8gCeZFa0CDgjrQUyGvXxJgF5ZrE/xJh6Xk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQnpy2++q2AUdw7svpFVXFjDZeWUu1MvOKDSFmSfoOvur4dBHzu25GGPXoerSlV0ybaZ1DSciN6yUqn8H88sY19jfhjCcl24vrSdQFOoCEyOkoLrVjLTn1I+5j6+z/QbNbxDJ9wk39il6R9KYDrrFMu7X3W2Y9qJrfkm8rXStb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qi1Jjn4F; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42817980766so32319665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495992; x=1724100792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XoN+HaFS5yfD0CNRqQpWijMjbiOviXEPumC1NW+kKU=;
        b=Qi1Jjn4Fms/+3D0r3zpT4LgYg3AlLQx3k2MpVzwJ4fVPRdrwmroo3t0cAntx5Yj4cT
         iXoWnzymncgwccqSFZq54B900xpW83y/k/rKD8Mw8kOAy8jHN9p0S/rLqCqAQVS+tKjt
         N8FrrKQOlg54tES0xN3ervSesaoHIFM78XlV1O//cyZE2nxXC9U0ikwr80x73n5Q9WSq
         J9rXkaz+Fmh04jo4i17OUwOQD6/QdM5xdbfGl4FG4m99ZpOpDNA9jwjQ8ZL3RDbBya45
         HJyaQYPTjIALz0U3+MDUh/OKcbKVHTGMVXWRGijL6BB7jQP7DnWw6DUAG9mjNci2SeRS
         dwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495992; x=1724100792;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XoN+HaFS5yfD0CNRqQpWijMjbiOviXEPumC1NW+kKU=;
        b=XQkp5o1loHPf2WjUnfk2/cMiU8qiZqPS1eEywBGwD+hH3ynHKJJo1FiHovuFV84OwZ
         884GZgMtfAehcRPNY+0Wyd02lq/gWSqyxU1gKrVSwiJWO7JAgEKMxoup6SR7lUd/opPU
         BAOiIhNzfE91GKoyNsZSegEFOXofRgTY/niSvEg0W/+7/JmOVxnJnxRd4YbfFmt3qBLP
         B9EtzCkNUcrHQhS7C9BwunL53bNp+NNF6sH90DlWIyCEN5fu+1aodDlqBo78p3QkUuA2
         MFOufTpdNGIq2KgjcZJIMQpvRaPKxEKSr5C9FbhisYgU/VzL49zrqU4S+8FY+lBmlUV/
         +mGg==
X-Gm-Message-State: AOJu0YwNBxDdA5QFmNrtVY7jZeOpvZEChGQCUTy0V/PunN8xyjd0fqIb
	hI7y4sAqdPahCfeMzidrhrWVw4gCtK+yOIaIR7QjZjJVXZ88GS270zf4Upi3Gdv4ieeMoT7MOH0
	5+sHIaFuRMiUKpLJGth5fJjF4OuQWnktAZv20EQ+uXSfJwmUvKQU9SXFisqdD+T2lSVAj0TbyRO
	MRiWFKmjtzaqHk1JDmQHfrMU0ToBJd67oYs0M2lpAjMiiOrmMMwUM=
X-Google-Smtp-Source: AGHT+IFttRPjHqcCMA/MGAc53YWP+S1ssedfHB7twOrXF8ji7+KWw2xkkyaVB0s2fmulVPed+0z3LTjiheg2UQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a7b:c304:0:b0:426:59d7:dcc4 with SMTP id
 5b1f17b1804b1-429d48b0061mr30705e9.7.1723495991252; Mon, 12 Aug 2024 13:53:11
 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:52:54 +0000
In-Reply-To: <20240812205255.97781-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812205255.97781-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812205255.97781-2-smostafa@google.com>
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

S2S must be set when stall model is forced "ARM_SMMU_FEAT_STALL_FORCE".
But at the moment the driver ignores that, instead of doing the minimum
and only set S2S for =E2=80=9CARM_SMMU_FEAT_STALL_FORCE=E2=80=9D we can jus=
t match what
S1 does which also set it for =E2=80=9CARM_SMMU_FEAT_STALL=E2=80=9D and the=
 master
has requested stalls.
This makes the driver more consistent when running on different SMMU
instances with different supported stages.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..8d573d9ca93c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1562,6 +1562,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *=
target,
 		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
=20
+	/* S2S is ignored if stage-2 exists but not enabled. */
+	if (master->stall_enabled &&
+	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
+		target->data[0] |=3D FIELD_PREP(STRTAB_STE_2_S2S, 1);
+
 	target->data[1] =3D cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
 		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
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
2.46.0.76.ge559c4bf1a-goog


