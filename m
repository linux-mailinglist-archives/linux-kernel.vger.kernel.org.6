Return-Path: <linux-kernel+bounces-576915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E1A715F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C291895B29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12521DE2B6;
	Wed, 26 Mar 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hArIpLSc"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C61DDC0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989150; cv=none; b=LRDf1isBVJscZpqETU5KuT9z/F5Uox5VGmzjzrzV59nWAbQrOn8J2OjnzyLtPtr8cIdgau5NOKjnQ/8OBpCoVmXd5Bc1jgamhH+tgUhOPL3mkJU/oIc/00Jx5r+EU77fVgsSxKtvAvh2CGqdF2rW9/tbqTC2/dlL06t7o103FrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989150; c=relaxed/simple;
	bh=suNMKt6I15eicpIrRigEwbTXV0qPPOxVmXKEqjZInKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mkP4jopD+Cj900pjURtou4jqsfe7wd6y0JlIWDToNvqeDuF0WjIAoVOkwfNkizGwTS+xeigEvwQ+1f74ecE7zCVHCrewRDS8TAPgp3M32G18Kr0H+BK080IZr5ymIiWCN9S6fmsYeplMMc5gbDvDBCWfpKtfw166UBOXm7OWSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hArIpLSc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c489babso31344895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742989147; x=1743593947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXpneY+J8yPscOLP7jhAaiNlTKvyhknsIBSzw8J5v1o=;
        b=hArIpLScYbFZ8BdkcuBEypEHlPDw+5Nkub8/7JUbl8tzJ+IS4xJU8rakGqw4HFv9yP
         1ZYjDxVG0ChoVs4yqKmJ0XNN0Qhu8ykEKDb34jxR1erxpgodqIZBa0/HhF1g+Y5FWrTL
         4VRU27xghfE9TNuhJMg/fMHzcpPptjMVoqOQgrwy8cxYNwkz2bVTtjJJ2Qhsu1zbYiZr
         9kBptH3bODY/aHjk+A5bXuPXvsxyxOX6+pZpHeGNkmeSZIvDV3lnz2nBB/xUf0HlcgHT
         mM+TiaPnfcJOW75jf9TqWJ+n5KKJH0COOarh0n+PneaaaBX3vYpxrk4rgFnO4xn9dsbR
         XqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742989147; x=1743593947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXpneY+J8yPscOLP7jhAaiNlTKvyhknsIBSzw8J5v1o=;
        b=CQBgkRQqqYl+kj6dB7bMAqksV07Pu+iP+9nxEl5b3hf4d51Ue2xTVrpqwU1IPVYS6I
         qm5aMo3RFmpzVlex1DduNtlBOztGagJWMd/uh5H6Rf9WZSiVaC4rRUcMuBRqbWdYktPr
         WkSnazNjmz2AYrPxn++ZC7eu6cC64wGv0C6DCPo7fmh0RHHVtKxR6t8bPX/X5YxJ0xJI
         MerOsoSccCsXi9d6USNy9J7OY0EIrbz33vpcaOEQl3E2otMRJi9vcQBVMy1Au1Ylm9Zv
         iVskKNAQNTAnEm0cLSCTgNY2g+Nsm6VidC22l4XV8CWHlKOLeksDOnBYY1T+YpEb1Evh
         Miiw==
X-Forwarded-Encrypted: i=1; AJvYcCUlv1/BET7uJOKQxBrYNJYqZWE0yT7lgzQ1PNCKeDi9ucHsGMclPGBxpHlTRXRr/rDbkWI6xiircxPUFdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPS4s1QkiQ+P0aMo1nNsGVlsWARQxDS7PIP+kC4aPCyYNgDFS0
	3rsuA30So28OFs5OxU6Ye2r5T7mVd1xihpBtGK4vTcsXi8gkPeHUji6FBd6CB3x/wbok4FZl3P/
	ZM6ESR1ME9ovxwJNZ9iUOakoX+Q==
X-Google-Smtp-Source: AGHT+IGmIIwQP0bm2M7IlxhsZXhvvis8SEyv8YAEqMxAp7vxQ4ixz0CF6DGy8JLA3pEu/5AAb31WyHaG1CNXPPwbNdA=
X-Received: from wrxt15.prod.google.com ([2002:a05:6000:1cf:b0:39a:bf28:66d8])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59a6:0:b0:390:f6aa:4e72 with SMTP id ffacd0b85a97d-3997f8fabdbmr17862518f8f.18.1742989146887;
 Wed, 26 Mar 2025 04:39:06 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:38:59 +0000
In-Reply-To: <20250326113901.3308804-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326113901.3308804-1-sebastianene@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326113901.3308804-2-sebastianene@google.com>
Subject: [PATCH v4 1/3] KVM: arm64: Use the static initializer for the version lock
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com, qperret@google.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Replace the definition of the hypervisor version lock
with a static initializer.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e433dfab882a..6df6131f1107 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -69,7 +69,7 @@ static struct kvm_ffa_buffers hyp_buffers;
 static struct kvm_ffa_buffers host_buffers;
 static u32 hyp_ffa_version;
 static bool has_version_negotiated;
-static hyp_spinlock_t version_lock;
+static DEFINE_HYP_SPINLOCK(version_lock);
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -911,6 +911,5 @@ int hyp_ffa_init(void *pages)
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
 	};
 
-	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
 	return 0;
 }
-- 
2.49.0.395.g12beb8f557-goog


