Return-Path: <linux-kernel+bounces-286687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B0951DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704BB1C21153
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3611B3F0E;
	Wed, 14 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7wRk3PA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115A1B3754
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647401; cv=none; b=thwfaBklxwC0vXgdHhUWpAqq4WokP1mClJQEEBhN9hSMgWhMOoFd1T7nSbCUVyxTBFnMvoerozcXqTo5REK3QW9fg/w909+ul+gsel0t1+dKiX5yy+W/lbQKeC4vSB7RAIUSKeH+M1i2OHlBu+GdknuxZSCxsrVZb4n6A0YUcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647401; c=relaxed/simple;
	bh=yya8mCdkJzXy0zL2NV+oNlw8ZrqamjEaG8Jd95WqXKM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VCHvPk+t1BzsGxNIwEzrmwDZFdU9PIITquJiYTuYEsBgaVppACotZ+5RvGOIG4LUwXX7KiNl58CauMRs95u5JB6SYk6zXg/Qr6TyNMsNGJG77pXbsIMp7nL3RuXGAKSUDaB6IunUSNRizlr28jEGIWATWQpLrDWcJQjSyme3bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7wRk3PA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0bb206570aso11962848276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723647399; x=1724252199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QiimjaWFQigtWp7gc9RJ6NeS58KxDmWelajHEyqbgQ=;
        b=I7wRk3PAJj5iKifjpwun70oUlFqbd1kAfcINukJcROFeDm5bWkec46PcU0E16s1xeV
         /e2X6yuIOAI+VF62ScDLtXhLNSVbezj2txLjgqGyVxgyJL8anGQpZYIwRgtf7RAtUpv9
         khqrZSs5xYhFhZ++obHhp64o7UTx5Nf4jj7Y8zXc50yjpYBp+Qb2D3/jkt6vg+PhvC7m
         3uBtCGTaAPo6Kjtb++bRowPNU3qp4hLOqTqd1wNJ0ZaL63pF0O6bnqR7S8auBvgjkmar
         HG14g2rJbfI9mhQhPC7aOTggCfSymQT2rRSFGu1IDlZ1PY2+iKqTHdXgO566K2gPH8M0
         Nb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647399; x=1724252199;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QiimjaWFQigtWp7gc9RJ6NeS58KxDmWelajHEyqbgQ=;
        b=Tu4q5V0eOP/BMOzRez4zsrv69LsGzEIGcGlZqBGAd1iNClcxNZItPGzTnz6klzK+Tn
         ZxOyNDoIrrCgKb6koOgOhlAJ9URfB54mxUFLMz1D6NViRPdjTQnOeFB36EP9FzE6UTOC
         nakITC1NPUQqqC6H9Egyz30hr2OE8USryE4vnYByA9nehddmureR4klJ0W0tpVbIq6k4
         ow74Y8ZUb2YdtkGVkYGa6EPg71GPr2ZTU8zxIBq7ShZdGjH+rvZH2FFbR3vMlBtbcSYW
         YIGA3ttD8o9lbT0jnHraEVAwtiKjezh7tpxivgAkdfow23RSG6D7ZoCdwikp40D8AVbR
         S0iw==
X-Gm-Message-State: AOJu0YzaJlhSHqnN6Y1Dsq7wWT9h7i3Wym6t0WkikSFl80f/ceUUlpw0
	4MiPkpEL4COl4pTkKxBmTIt++EjYMjKzCvRU7jSQzM0fpV7mDOGZHOXUpuzcnoSTiC04lyAT/63
	q7ktbpiJkVf5y7/MQhkc6tKc87E5yBGQW/BvuncM43djlCbdMP8Xy4bGQvPlcbfHKx7PS8sESM2
	Y2se0t8OFNx9GykSxd3BCL3Mc5IvICA25dbNHKPEV86FIB7MUKsV8=
X-Google-Smtp-Source: AGHT+IEwZKpbi2DVRDWHPR9t5KsZu510hTwOo8qGv7V3OsKoQsm3WmSQ4c6RbXYHvqRaHKRLcB9RJgCyn8fG3w==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:ed04:0:b0:e0b:bafe:a7f3 with SMTP id
 3f1490d57ef6-e1155ba2f29mr125325276.11.1723647398061; Wed, 14 Aug 2024
 07:56:38 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:56:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814145633.2565126-1-smostafa@google.com>
Subject: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
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

One caveat, is that S2S is not compatible with ATS, this mentioned
in =E2=80=9C5.2 Stream Table Entry=E2=80=9D:
    In implementations of SMMUv3.1 and later, this configuration is
    ILLEGAL if EATS is not IGNORED and Config[1] =3D=3D 1 and S2S =3D=3D 1.

    In SMMUv3.0 implementations, this configuration is ILLEGAL if EATS
    is not IGNORED and S2S =3D=3D 1

This is also described in the pseudocode =E2=80=9CSteIllegal()=E2=80=9D

Also, since S2 stalls are enabled now, report them to the IOMMU layer
and for VFIO devices it will fail anyway as VFIO doesn=E2=80=99t register a=
n
iopf handler.

Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
v2:
- Fix index of the STE
- Fix conflict with ATS
- Squash the 2 patches and drop enable_nesting
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..3b70816a2b81 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1601,6 +1601,14 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *=
target,
 		target->data[2] =3D
 			cpu_to_le64(FIELD_PREP(STRTAB_STE_2_S2VMID, 0));
 	}
+
+	/*
+	 * S2S is ignored if stage-2 exists but not enabled.
+	 * S2S is not compatible with ATS.
+	 */
+	if (master->stall_enabled && !ats_enabled &&
+	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
+		target->data[2] |=3D STRTAB_STE_2_S2S;
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_cdtable_ste);
=20
@@ -1739,10 +1747,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_devic=
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
2.46.0.76.ge559c4bf1a-goog


