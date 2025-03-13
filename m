Return-Path: <linux-kernel+bounces-558838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA596A5EBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BCB16C4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263A1FBEA8;
	Thu, 13 Mar 2025 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gjAFG3s6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB41FBE8F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849083; cv=none; b=A7kjnbkAmcDWkmJb7wSdRxkTEr5xhY6yZ/Manu2NpaLGe4n65Pv3kg63TtJHSICzQQAkQo8MoE3O9r8ZHYI3LdESvREh+wYKB2LOXTWNWnSi2sEzPJKJXhna44ucpAlJzBVqNR444Bozb8rDgmsuqWL7EAXU9EU1mDGa8ZWo6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849083; c=relaxed/simple;
	bh=Nls52lkzjmJ+bhk/FuveEgJphMZM3lsoGJmXIHJqvZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnFglmQOQm3UxpEpeN8p6gfAaXFHyXw4+ehMJKTgc1PhjVL68ltoxCQCvlV1cfMa1xvm+HgBS9m4eLYLkQedhlvMiUzA26wWf6Q8G2XCMPmxJPqMnABU14N0YMA3osSoFi1kN9P33lddVWq+2BJ/VFBQ96qb/Lp7Ku12zfoS4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gjAFG3s6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22113560c57so11500295ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849082; x=1742453882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAMd6rGhip9Etdi0DcL12HaRjFlmNQeXSBT7tbE4ZZA=;
        b=gjAFG3s6pD6mOnEojLYvn3uoPULYar8ByMme9l8i7wtitk7bSbDmij5K4SxHE6VMIQ
         RF9ldvoTZsTFhJHOsA9SFbQ1/0bhKMPgQBdmTF2dksPO9V2edzhdORPgIL14NTaUDIO4
         OVBL0OOJ30PdIOE2THkNco31veVkMExZM8ju/ax0rPPdKxy6Ufky/oeT5I18DB8hPSpe
         Qnf/0i+Oq8AKzswv0KrEMf7dViP1WJW+41NINkayNUB48wyCNBNqp4COKFiOUkXPrNks
         IMFWZoT6ffvhfuHCwL0OQwN5XyTZH1TrAACW4X1AEJq8+oOBaGTfHC58WN+6JBNSkMjO
         L46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849082; x=1742453882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAMd6rGhip9Etdi0DcL12HaRjFlmNQeXSBT7tbE4ZZA=;
        b=jZ1K/y7jyd9SM7feLn75uUudtGvbsVNd7zlSvROlvG4UqtD6gMtFSjGk3dzR+s1tYq
         YZFa/0t/p39gEBQXLWN4Aorc14sLhiWPV+fXYdTGOiGFxzbB67t+kiu5sMbdy0LwAx/3
         tka+aL3Wz+zik4bi2XgX/GQU7bJbJX64JjvtL63TfVka98uqxDXyIkn3D183fJ4kqq2S
         inuF5BdiFONU282j5jHNef04sNS0opkJpV2rHdnyE4qfdCFa7TFQh3ZAziRbNT4HuEQ5
         voHW+hCEBfJ20fv9JFodp6v09m2rN0YG8AsJCt3H/L55yPzFNi0VEfdWoyQAV+o4v5Lx
         6ylQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHjX7M99uAGYnU5jUgtYHHSoKDU026gVEDnzPIEE4u+p2L01jb0EpZq0vNDjvPzr6AE7ZscgwnSWPST5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7GFOggcGuoTo5yrEuZR8H7UvBUbsCmC1ANRVI+l8p57ZjSNV
	RMazxnxasInI03JW/BfY0y8D0rzuFlWMLbVIjqPB0HqFusvenJbPrqc15soD/8o=
X-Gm-Gg: ASbGncsGQ29P16ncRx7aixqQtMGtNY9Yb7l60xBReYrNdWiRf+P2RAzY+GHv+B1bsgl
	cDVsnLkaW83D/CRcWWpZEVzTBq2mAi8mDvMUj3D6xkYtpGFvPCMzmv0XVp7a/xDQdzHWwpJ8B9v
	kWjl1b2GKUl8N772f8h4Ec6eihMe4Su2C5a+LYvWQxB/8D9kaSoTAKg3kYZ56L8up2oqOluj6/d
	MRrOqbkoi9WKCTVPqsnIrWqCqivmIwMe6gWaih4HmbQFp2940AE6OQqLRw5UdH5W6ACSgCKIgD7
	5i32bDfsoqckElvva9AlkvJv+4DwNGBJUZxZQ6D5QzFunO38
X-Google-Smtp-Source: AGHT+IGCLVrEGNjCO/QnspZOy0VKIly8ZUkVAApjFMGze7gowWxFFi+tM448yykvGdA29pKzg5pogw==
X-Received: by 2002:a17:902:d2ca:b0:216:3d72:1712 with SMTP id d9443c01a7336-22428ad53e6mr379581645ad.48.1741849081724;
        Wed, 12 Mar 2025 23:58:01 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd7bb4sm6378025ad.237.2025.03.12.23.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:58:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:57:42 +0900
Subject: [PATCH v4 1/7] KVM: arm64: PMU: Set raw values from user to
 PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pmc-v4-1-2c976827118c@daynix.com>
References: <20250313-pmc-v4-0-2c976827118c@daynix.com>
In-Reply-To: <20250313-pmc-v4-0-2c976827118c@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-edae6

Commit a45f41d754e0 ("KVM: arm64: Add {get,set}_user for
PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}") changed KVM_SET_ONE_REG to update
the mentioned registers in a way matching with the behavior of guest
register writes. This is a breaking change of a UAPI though the new
semantics looks cleaner and VMMs are not prepared for this.

Firecracker, QEMU, and crosvm perform migration by listing registers
with KVM_GET_REG_LIST, getting their values with KVM_GET_ONE_REG and
setting them with KVM_SET_ONE_REG. This algorithm assumes
KVM_SET_ONE_REG restores the values retrieved with KVM_GET_ONE_REG
without any alteration. However, bit operations added by the earlier
commit do not preserve the values retried with KVM_GET_ONE_REG and
potentially break migration.

Remove the bit operations that alter the values retrieved with
KVM_GET_ONE_REG.

Cc: stable@vger.kernel.org
Fixes: a45f41d754e0 ("KVM: arm64: Add {get,set}_user for PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 42791971f758..0a2ce931a946 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1126,26 +1126,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
-	bool set;
-
-	val &= kvm_pmu_valid_counter_mask(vcpu);
-
-	switch (r->reg) {
-	case PMOVSSET_EL0:
-		/* CRm[1] being set indicates a SET register, and CLR otherwise */
-		set = r->CRm & 2;
-		break;
-	default:
-		/* Op2[0] being set indicates a SET register, and CLR otherwise */
-		set = r->Op2 & 1;
-		break;
-	}
-
-	if (set)
-		__vcpu_sys_reg(vcpu, r->reg) |= val;
-	else
-		__vcpu_sys_reg(vcpu, r->reg) &= ~val;
-
+	__vcpu_sys_reg(vcpu, r->reg) = val & kvm_pmu_valid_counter_mask(vcpu);
 	return 0;
 }
 

-- 
2.48.1


