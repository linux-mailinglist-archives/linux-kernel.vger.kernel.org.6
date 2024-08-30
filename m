Return-Path: <linux-kernel+bounces-308651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EED965FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A121F27CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF5192D9B;
	Fri, 30 Aug 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpSJMhIk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FC192D80
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015842; cv=none; b=aC7mSW+5WalbUT29z1QEv1O5YRkD7qxE3VKNNq2WHggjPv2efE5oaY0xyBPW4pLFn6y3OFx6My+UERKiK1DD8RjQhj1sx2zUAT8cmpheTjiNcaMnPnLevAaSJrfxyMb/ze1jdO0IHH4bUOqzSydrXZlpD1dnPCgVei21C3F7AwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015842; c=relaxed/simple;
	bh=+K0m8Z/tfxXArd2ca1OsFLwOmWFwm4/wH1OpiRtKoks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AP9CWtjMFknJshs4icQmF4xRiOzHiAHdh72NvkxbrI5DEBdJvk2cB/tFXTs39r3QLX1da2Rr4J0y+W3Q0xDmhyJ482Xl8JeuCM/NaO8QeY0PfDFawL6ewi+iIBn+NLcw3/zTvpkcX3JcSrd7WJbNXvRWnnQOuUmnrE/qsOuCjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpSJMhIk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4bd76f5a8so823007b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725015840; x=1725620640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ic37IELEQRRYuBS18VKDjuHeMlY5e56pj2JA+eqlY6M=;
        b=vpSJMhIkQphVoJiPZN9lf+Tu5LHoEUwey9OUGFj14bH9K7Qm2LK8nL9wFJn2fgEcy2
         KirN2jG7TKZf2IsQrSZLzfvtKkj40BYk1wvfuAdlQgs50hdF5vRyG2pnxZU74NEi+uJn
         JZUXJIj9ixdnwLKYCeKaYqgN5i4X0oTRvIZiNU4p+iiENF10hABWpDbQU2PBIiaq8Iwf
         qk9hKTkMmLeuOKRzY4KRQFutYAfGktciE0R5LXIsxhQ/K8Eec4IObDL/TdXjRqVlV9Jb
         n8ZJA8ciVlTm5Z4MTXh922UQSEX71TRQzL1YxX9eo7EOgqTtbPnJOGu8nDeC5zwPbstw
         TKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015840; x=1725620640;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ic37IELEQRRYuBS18VKDjuHeMlY5e56pj2JA+eqlY6M=;
        b=jTTlWN3Z4djS6tQ9//EolCni0dM0THIvUIeOtyOq0KPYPfZ3pRqELQC3RJ89Non9hc
         KmzCEBXdVeMCFaQ/yNOKkZZPeRzEeyzI+PyDCb/5GBYAq1rj05U8YW4g1hkxHHHaRZBx
         Zy3kyBERy7VdDzB3qUVAc5vRQr/hg5zf+WYvGoeQKCbDSfe11kZ8us/wMiYEtuSbeVAK
         IgfEwkdjT+5b+VniCvkDZBqr4sGJJJulChYKzSTibVz1Ubety1whRtuuYDBcIVMOkwKV
         fnviAbEhuRe+uKSexwH6tM7Cx6Kc20HE6jO3fTZG6PPpdIc1MLQL8BBN5bHGPT9kSMn/
         SgXQ==
X-Gm-Message-State: AOJu0Yx6bOpl7TeEk3H2MZnFUw8PuUVqQ/jXXE813G6/t9u0G/+vTwfE
	STmVQV2ynMw6BgQe4/80YHrgp1ECYOiH8L4jElyorHfgNtpjj0IOP2ObZgOOsV/X42GVRwc4J+F
	F8gJ8tjNt4CCDoIhX2urEdwkRwx2tgm8WhfVGoJAr/f1RZRFqpNBfRPoZFgmCfivk3hV6DY+wRl
	g/Lrbprg9N7mhQQE0hSvewL6Hj2ii2x8VMWne1K6m6S52gPPYdPgI=
X-Google-Smtp-Source: AGHT+IEhIgqCCVpoJF04izZWNpGhj9w4DRkBO4N4vRbTNO83ovpMlTZbUepHXnCpHONa5Hk4mWllX9/lH0OXjQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:3744:b0:64b:5cc7:bcb7 with SMTP
 id 00721157ae682-6d40d890122mr37757b3.1.1725015839642; Fri, 30 Aug 2024
 04:03:59 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:03:47 +0000
In-Reply-To: <20240830110349.797399-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240830110349.797399-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830110349.797399-2-smostafa@google.com>
Subject: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
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
"ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..a0044ff2facf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1012,7 +1012,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 =
*used_bits)
 		used_bits[2] |=3D
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2S |
+				    STRTAB_STE_2_S2R);
 		used_bits[3] |=3D cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
 	}
=20
@@ -1646,6 +1647,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste =
*target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
+		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
=20
 	target->data[3] =3D cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -1739,10 +1741,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_devic=
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
2.46.0.469.g59c65b2a67-goog


