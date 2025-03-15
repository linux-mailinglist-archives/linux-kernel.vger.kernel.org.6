Return-Path: <linux-kernel+bounces-562493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D81A629A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B457117D26B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840A18FC9F;
	Sat, 15 Mar 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZBuVIxAe"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8611F4706
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029968; cv=none; b=npnhtfhTM+sk8MU5RMJhY0NbXyf2XYTXkA/F5sNB1L/8yMjPFFqj7y0G+N9DHV7ftpEOx0OLN81rKp/mtP7FBrwQnHXQZdNWw5QxfBvMdf6YVuB/STRx90iB8lnzfG/DueP3Sd0p/rcujpd0BnaO6m/XQ9NwUfvHGqdCV5VqpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029968; c=relaxed/simple;
	bh=pLEJhlfw3fbIq3nvqJiuw0vOJP9zyUhLd4sW/C6OrrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzbMJNk62XB0RPauiB78Qlffp/KY0TLqsJ6BdrcVE1g/BUEVIxUEh4k76M/S8Nnpzv7p03kHfdDoSUTq+CIct+xu3RGRoZmxS+JVc55G71DXeQbKUbZOjGbwTmmwES0CkdnDodwF7QZkMcGK3VT+rssRCzCNFILNsuP73QOHyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZBuVIxAe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22359001f1aso73397925ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742029966; x=1742634766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVQeHb+cCKo9FI3oCd5KZj2+ztmvI+IS1H6dV0Bffso=;
        b=ZBuVIxAeujgieAmNiJU7uEPhv8quEDbmWM1ekcacXm7H1Qcle5/WiokQ6PITIP/KpC
         2LxvcpvIIHXdfPAqQApMnlxAQo2kXbgFIs+/+cMr7Crrd2Zopr3SvD5HvR0ykmYPoKAt
         GJrDAkxvDTKd3o6vfCfaMBDI2rA6iD6jcMu2Ug8nsmiTiUyAOdji1+mKUBeq+Agvg04i
         ZH/UaqwqzVG6eGPba3Vm0AR9gM69uhHz9W4kU1PiqU8b/ct2CzfUK5NGWWpQs1Ud70G/
         HDu3if3ctlJO+sFibaY4tBXgHA9t8ziNP3gZR5ewPgNQPGttIu1Uf01VRSbMZJsEb3h0
         8s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029966; x=1742634766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVQeHb+cCKo9FI3oCd5KZj2+ztmvI+IS1H6dV0Bffso=;
        b=Fy1kEm+t+IhvOU/293uHD2QoXqKvqcWF8uDVg5VTjv+eNSdY1eJL518UnskY/LsjfA
         K4CLN3P8KfvdHEpfZ/61CTDgI0hk4ltcbkmr/ZJeYaujhKB3k8g8rz0Q3IJB3xKJWaC0
         pqHIxj0sZyOs4sdnC+fYPfTfONKyOQrRkj3c4i1XKnLluNfxttulDrtFvrZQr+e53rM5
         5L2mqArzKAELES5vrxR0v3j3E5pWQysS18/F1POALrPZy7mfHboz7IeZK38mTXy34OF5
         3IGexXgHk/sf91brilo5dOz/Ss7NFUSqTkyE2doa+YIZ23S8HGJ1Uf1n4IUMMr7R1f0u
         awBg==
X-Forwarded-Encrypted: i=1; AJvYcCXD5H2HINiTFeFbLpmYw3tCHaAYoO0KYbvkg+bAplUBdUz9/jdInnSMK+K4gEltC7sdSkJf3y+jawT8msk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QZ3MH7ASUO4dxd168JmKZRPe1pJuiYLjUlwFzIsX0mXxxXWF
	JBWmaclqfBLTeE3XU+QYwitFEHGt32FYJjMIDbB+RAkTKOTA8nMV2wJPTQ4KhBSJK1ohvBzIQ8x
	dvLc=
X-Gm-Gg: ASbGncvjx4GWF1zQnsLIii3mh2GviylQhrPetXdTrPnwwcHQb1M3zA0Awq9TEy/gNoQ
	zPAYdmq/77FLLq2Nlj2tv0ByjNhU92qUgZy2ZCdKtRozRGaazCDEkVO0yxtsNHN7fDp1xKeS/5r
	0F1P91IafcU1erjZKB4mK0vv/W1JI86PX59krMdghW2ZkETK75mrPqyO7J6cJLfx7XWoKOzVAYI
	N4lHL+dO3l/7ifA1OTLbwV/dvWdizJ4USrqD3jhkbBC5o7voTk6s36osfIAA7e33jfXLEwkigA9
	msuUg9D7xnck9CMlxRleTmRIV1N6QYlJA3hJB9Ee39mOT6cA
X-Google-Smtp-Source: AGHT+IGQ8Gz6JOShy4dRcyVD/SiQ18YggMiPkdBJ/XbTFh26anmZdWe+vf8X98ZKiGLO7S3+Q3G5dQ==
X-Received: by 2002:a17:902:e750:b0:223:90ec:80f0 with SMTP id d9443c01a7336-225e0a6b3f8mr76818965ad.22.1742029966450;
        Sat, 15 Mar 2025 02:12:46 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd4a8fsm40925235ad.234.2025.03.15.02.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:12:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Mar 2025 18:12:10 +0900
Subject: [PATCH v5 1/5] KVM: arm64: PMU: Set raw values from user to
 PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-pmc-v5-1-ecee87dab216@daynix.com>
References: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
In-Reply-To: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
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
 arch/arm64/kvm/sys_regs.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82430c1e1dd0..ffee72fd1273 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1051,26 +1051,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
-	bool set;
-
-	val &= kvm_pmu_accessible_counter_mask(vcpu);
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
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
+	__vcpu_sys_reg(vcpu, r->reg) = val & mask;
 	return 0;
 }
 

-- 
2.48.1


