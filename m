Return-Path: <linux-kernel+bounces-550922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0FA565E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304DB1899392
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320F3212D9E;
	Fri,  7 Mar 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Ha7Ctr/q"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A18212D9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344945; cv=none; b=CztktRPagB2eSr/wXDTUKkQ+5oOF8GIcPEnKuXXaNzVpTKDZIa3vgGcK/WzMl7kAPW3DkKuuO8twjP8oN9rOzIRaBQrJIdp2+RinxCSFqqcqSxlMEF7Fz+SpRuarNAQw/FhhuuOmA6D0aohuAZlijuqXdcjXzh68w5VB0C/GnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344945; c=relaxed/simple;
	bh=JTuqG6l6qjIX+SUzFlgt+HussqtRooAlWSw54eqLKxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAohhwFUrEXUUDrZDlAzTs/vxEPfNpOM3KkFSl20k9ll5lyCTASPsotqpYGXmWTZqP2MUhsvRF8d0XcRwKpqZr01YyVjQThybPkE0AndZeW9PTSrnzw1ch13ssz1GNnpWSyfnPlqf2aHdDOpWQdcp2JwkxUU2nS181EAnCkT5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Ha7Ctr/q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22355618fd9so30708965ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741344943; x=1741949743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFXBjMpQQucibqgokFHkSZnj9y5cZChrzp1Sa0fcrAc=;
        b=Ha7Ctr/qCm5+1hgx0YI8SLyUWZJqYz0MTWC9Nl4vHmYBmvIh6WmECxaofWXpVypnHl
         IG8X+R4isdIzqOt6IhssAkO9kwyT64Gus5rHV1aKCGmWZwLt76midbX2cUzRdtSYnmFc
         60XDYlzQ9Nf2/WXenSFnIF+/Mz0JOtCs2+cIxJ0fNaaM9unpYAfhsLPgitO9jw+4qTST
         zb3Gh7xdI0AWu/hb3fXMyE3Qt8DBZL9p6/6kGnGXyKft/4koN7yAudsJfowFy5zr18qA
         en5m0hVSEn2tWx5/7lMeTwaQzzlUwgBSPLmF3vDMttZoFOGw/1NhovV2xKSWsyf8lCRg
         k2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344943; x=1741949743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFXBjMpQQucibqgokFHkSZnj9y5cZChrzp1Sa0fcrAc=;
        b=UlLgFVU4hSR6ccE9Eh3dA0u6ayc0G/VMAJL3FnUtHmQU8BtSGsH+m/jHAQ6eTxcqzJ
         /0UIRNXhxMaJeT77Q/DuwbJdWYNoCTX1LuCjWD1LnVh1lU2n+Or9m0gmbQHFSs9qyKKW
         O5ZadDja4piSAXX7rZO3oPUy3rxDLsM1rG5IdzdZ4X9FCBMZkee53ZZygcYwdaOSe/Rc
         gmPg59+Tvlg56xma9hY+qXN9+b6KvcmHBDHDgTupf2Frb5AFc5EnF/SMWgCQpGV2qqUE
         NforTMYo4r8OkDEjsJWxJtwaG+1YyVnkrE1cGZCiBelsGCglS+WTW9HaA0pYDVycorP8
         yYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/TLOH4jt6ikr4dWkslSJFT2g1mjMXADQ+q3rVVaePomFPbOHOtLYKvaFPpzxK5T5awzcgiPRGNZSNxDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19XMPTPashwSKyJdOuhHUC4+b6NRxeG6ctbc7SBhxNOQCVdFT
	7ddSI3o7ro83+C2US/TBkLh6Nf10wNUBtbl6FRwvoXeNEs0HUR/pDteNkkWQsI/G9pTYN6/xrCp
	pYVU=
X-Gm-Gg: ASbGncvPBgCaXsXfzTPEsqVvF6LBzW2z9/9SFsA8ZdyaySFx5Q3IEWdqQS5vLSBOpDe
	6+7wtV15XbWAW7dIxO/9MkYd8Dw5fjNAiwwnuP/B20kDUlMmRQZYGRqnHUozO2vaMcJjSwRvQSa
	RkxDpqqydGvqxLo+5/4OdqloMnQ7f7E1PJbiv5aabHsSuGrhFY1gotfDqX3nH9y8kV0S9wGyzjy
	RNFGXNVlg3/+uiUEUZvVsJNA5sJ9KkqncJW4t0LjrV83l8pqJ1QfkvRfXfn2L0dSWIz4G27qwDm
	w5G4iugYn8N87zoymd8ddn3vWJII4Z/T5FjtWxkEXREnn5oa
X-Google-Smtp-Source: AGHT+IEoXfkwPsJZHGHUH2StrQHAqmGfaA3Jdeh6jSgOLkAwNCLg5rn0a7T5je10X9eqSxa+av8pdw==
X-Received: by 2002:a05:6a20:1590:b0:1f3:47cf:514b with SMTP id adf61e73a8af0-1f544acd2b0mr5322641637.3.1741344943258;
        Fri, 07 Mar 2025 02:55:43 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736ab812cb0sm1257087b3a.164.2025.03.07.02.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:55:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 19:55:29 +0900
Subject: [PATCH v2 2/3] KVM: arm64: PMU: Reload when user modifies
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-pmc-v2-2-6c3375a5f1e4@daynix.com>
References: <20250307-pmc-v2-0-6c3375a5f1e4@daynix.com>
In-Reply-To: <20250307-pmc-v2-0-6c3375a5f1e4@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Commit d0c94c49792c ("KVM: arm64: Restore PMU configuration on first
run") added the code to reload the PMU configuration on first run.
Trigger the code when a user modifies a PMU register instead so that
PMU configuration changes made by users will be applied also after the
first run.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 3 ---
 arch/arm64/kvm/sys_regs.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 1402cce5625bffa706aabe5e6121d1f3817a0aaf..04eb3856b96576fad5afc8927c8916ff9738f9d7 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -888,9 +888,6 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 		   return -EINVAL;
 	}
 
-	/* One-off reload of the PMU on first run */
-	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
-
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 27418dac791df9a89124f867879e899db175e506..51054b7befc0b4bd822cecf717ee4a4740c4a685 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1162,6 +1162,8 @@ static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 va
 	else
 		__vcpu_sys_reg(vcpu, r->reg) &= ~val;
 
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 	return 0;
 }
 
@@ -1322,6 +1324,8 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 		val |= ARMV8_PMU_PMCR_LC;
 
 	__vcpu_sys_reg(vcpu, r->reg) = val;
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 	return 0;
 }
 
@@ -4276,6 +4280,7 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	}
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 }
 
 /**

-- 
2.48.1


