Return-Path: <linux-kernel+bounces-558837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73DA5EBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32A218977A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92E1FBCA0;
	Thu, 13 Mar 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yxlUpcy5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2D1FBC93
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849080; cv=none; b=tVI9GObX3MvUWCmQGxqBZcKgoau93QfOu1ZC2d06C9x7pkuwfv0WpwzH0IrH+q7KtZPqd6b0dSUKskSd//B9qMFjfcPoHB4hovAYkpMIhyo9qnBQim3KlWg/aCFvYpCuazZb2V+MI1F3xQzGaE08hNh6elF6wIp/fhpOd9Q280w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849080; c=relaxed/simple;
	bh=i+aS6230F9Pf7oru2l/exa62ii5VwUSG1UgYivlTBkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eFMRjHbhRdxtqbwqiLljYrOwQ+q0BX0OO6uoReHBdvMjOiTBFPuCGzs4ubiuAy/GCkplNb8pJdM8deG/UC2kakpBG2W1W3YtRO5m1quwe0xVK6/Q1d9God/VGzVtR/RzrSc0qcx/2cC4Eefx3emHVlQ0klORmMfBupbWdPWrcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=yxlUpcy5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223594b3c6dso10848435ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849077; x=1742453877; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzZ/OwKmmQbXUKB6Ig9nkspgT/x2zvQUcWtNQDAlXJ8=;
        b=yxlUpcy5tJiKgdl/Nm6aV/oPpYabNkPkYFarREDWohXAJPYE2KsyADGSvVZnj1IIXk
         3NllRgW7kPsugRoFW9SIXycNjwRbrKUH24zlU46o57tqKUr5h89y9s4qClMVsgpnsIFP
         z9CKHdEaqpGe6a2V9QDqSiuSWD3FhKPAbJMEm9m6MgwpPilEnwiYWarSX/+AuzR4LpJ0
         dws8nm0ex2PIB7A1Jq3WtKTIcp5o0imVSyQwMnTPKTKSfz6p5RXrfeNKfSZwoSyg1qUi
         vCxPgJEBBN5mbCe2ZCvrcMRnnuP8pQpSiyBTaus1OrGZG5imU9z8/THhs7JbvE7vncTl
         jNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849077; x=1742453877;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzZ/OwKmmQbXUKB6Ig9nkspgT/x2zvQUcWtNQDAlXJ8=;
        b=SG23FJ3baladFgZvajMyoBGT8QmESjiAlHj4qRc9O36rU32g21KEj8XIQ0x1qmQJEm
         0taZA3HuQAM2MCk8KS/IKYr+pPXITXQ/5MlPY3/20Z3ecipCoFoA8N/zRHcnVofnmj9R
         aGfte/cI07lpCtXl0fIuQ8C+BGeHzlX1oT08ovTA2OOVzG5efZlF2sAUcOVJfFViyN88
         g/5qB+e5RSS6Yvki3Y9P+m8AtA6xZVoE/brnqf1fnMXjiOf+n2ppT3zzoReEVXXEQQEj
         aQ2I51hvIfiL3ZndJTN5KlnI9Ee2MPFDKA6+42A7hqwQ39zyplDBckGbSjDOilo3A6Rl
         dIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGIwJCIRVaK4cXv9vdPs+fqydwOnWMTAhIywTzmGZaAEw148bbceAuJ7b+fQfKx8STMnFs4tFLh+JIIUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31hMG+Rp8BV+zWl+fJdnMukYi/Ncp0/0mOLhfFQL5HWcBUbgS
	1BVLaU4sN4Xck6bGKW0ceLFEuh0HZjd7POe75T8QtM/3KpGbHrQMBNsvSIK3bAQ=
X-Gm-Gg: ASbGnctQvbQdQG7y+1N4XcM4m0t9akfLoK1B3C3XCaGFlQWwUoyCn/b7FFJ3AHzQ0cr
	ttiNBmavGmnryjtBKxRyG5RfNITfU7VPA2j+mKM2g4gGoCZIWeSmNwjnI0R8GzeJirEBbsW6efA
	vICm5itwPZwmYTnCJcCr1nwsqJmLq/0cbJlhf82s8b11Z0cCMXqwkBNf2qiQO1EaGB8DqCEnEI8
	b0+xJp2MqsI3t7VSIRYMtd8+VjBVawtTaM8/nW4xOC+7UTmOzoSppiwSgQkY7tJ0VZ5m0jco0FJ
	s6/a1Ybh84M2K9T81B23nnK5jKemzWQnZ4j5LfQiWPptO6rY
X-Google-Smtp-Source: AGHT+IFJys5eR6oUmPsgD0nQ7bgGFWSfRnMTkiQzEi9pZgL77FdSzGwIkj2Od2Zq73fxdD3yVQX53g==
X-Received: by 2002:a05:6a00:c95:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-736aab16545mr42898380b3a.24.1741849076765;
        Wed, 12 Mar 2025 23:57:56 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711694b2csm624169b3a.129.2025.03.12.23.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:57:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/7] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Date: Thu, 13 Mar 2025 15:57:41 +0900
Message-Id: <20250313-pmc-v4-0-2c976827118c@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWB0mcC/2XNyw6DIBAF0F8xrEvDU6Wr/kfTBQ5QWfgINERj/
 Pei7ULT5b2Zc2dB0QZvI7oVCwo2+eiHPgdxKRC0un9Z7E3OiBEmCScMjx3gRhFdl9opIQHlyzF
 Y56d95fHMufXxPYR5H010a88+UUwxaOdUrYjiBu5Gz72frjB0aBtI7IiqL2KY4BI4r6SWjlrxh
 /gB0d8nnhERlIJupAFuTmhd1w9opBY6AQEAAA==
X-Change-ID: 20250302-pmc-b90a86af945c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-edae6

Prepare vPMC registers for user-initiated changes after first run. This
is important specifically for debugging Windows on QEMU with GDB; QEMU
tries to write back all visible registers when resuming the VM execution
with GDB, corrupting the PMU state. Windows always uses the PMU so this
can cause adverse effects on that particular OS.

This series also contains patch "KVM: arm64: PMU: Set raw values from
user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}", which reverts semantic
changes made for the mentioned registers in the past. It is necessary
to migrate the PMU state properly on Firecracker, QEMU, and crosvm.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Reverted changes for functions implementing ioctls in patch
  "KVM: arm64: PMU: Assume PMU presence in pmu-emul.c".
- Removed kvm_pmu_vcpu_reset().
- Reordered function calls in kvm_vcpu_reload_pmu() for better style.
- Link to v3: https://lore.kernel.org/r/20250312-pmc-v3-0-0411cab5dc3d@daynix.com

Changes in v3:
- Added patch "KVM: arm64: PMU: Assume PMU presence in pmu-emul.c".
- Added an explanation of this path series' motivation to each patch.
- Explained why userspace register writes and register reset should be
  covered in patch "KVM: arm64: PMU: Reload when user modifies
  registers".
- Marked patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}" for stable.
- Reoreded so that patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}" would come first.
- Added patch "KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after masking
  PMCNTENSET_EL0".
- Added patch "KVM: arm64: Reload PMCNTENSET_EL0".
- Link to v2: https://lore.kernel.org/r/20250307-pmc-v2-0-6c3375a5f1e4@daynix.com

Changes in v2:
- Changed to utilize KVM_REQ_RELOAD_PMU as suggested by Oliver Upton.
- Added patch "KVM: arm64: PMU: Reload when user modifies registers"
  to cover more registers.
- Added patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}".
- Link to v1: https://lore.kernel.org/r/20250302-pmc-v1-1-caff989093dc@daynix.com

---
Akihiko Odaki (7):
      KVM: arm64: PMU: Set raw values from user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
      KVM: arm64: PMU: Assume PMU presence in pmu-emul.c
      KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
      KVM: arm64: PMU: Reload when user modifies registers
      KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after masking PMCNTENSET_EL0
      KVM: arm64: PMU: Reload PMCNTENSET_EL0
      KVM: arm64: PMU: Reload when resetting

 arch/arm64/kvm/arm.c      |  8 ++++---
 arch/arm64/kvm/pmu-emul.c | 60 ++++++++++++++---------------------------------
 arch/arm64/kvm/reset.c    |  3 ---
 arch/arm64/kvm/sys_regs.c | 53 +++++++++++++++++++++++------------------
 include/kvm/arm_pmu.h     |  3 +--
 5 files changed, 53 insertions(+), 74 deletions(-)
---
base-commit: da2f480cb24d39d480b1e235eda0dd2d01f8765b
change-id: 20250302-pmc-b90a86af945c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


