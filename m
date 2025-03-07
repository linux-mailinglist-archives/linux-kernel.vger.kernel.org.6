Return-Path: <linux-kernel+bounces-550923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCFA565ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0259F18993B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21821324B;
	Fri,  7 Mar 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1X5Mj994"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D6213252
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344950; cv=none; b=GgRlWu7u6f6EEpQUxUm9gMJlPjQKObnMaxNbTjuiraz99p1DH+le96RZDxa9DeKmLQsG3VJVVoAzdVdi8hS5TD5F2gj8TSQZm4ceznVBgZ5MympcG1cBSSp3p81X6HkfBxXtrlQ000CVX0+sHbKynEPT/3DNczEfw3da9LOKLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344950; c=relaxed/simple;
	bh=YkK0gICK/vMLYgGrmG2Il3cIUNO5rmXo9eTXUuoDgdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfEncOl+uAXRd10NM2aG1vCHXthAMggrFso9hyF7oUdDTGPBgVPGUXkK0/y84qdiAApKsZimnWGDc1VljJZDuWSdKNQoneXLi1PfevgE1UgkuhK6UdnZ08dmp98GcwGr5S4FAuK4pBt/ic7ecs20nBEERkfel1q+mdwPcy/5ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1X5Mj994; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223594b3c6dso29389225ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741344947; x=1741949747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84BQ3xuE/YOejwCkRVmGYfJqvNZTn+GmxFcneIOkJqE=;
        b=1X5Mj994oQLf/m17yTdhHM3N7+gEgBtyYq8Z/gNNqyg+KkpIn7BTsWNuEu+OC/x7T+
         vlBJWNBGWD2f3vlM85Nlyn0ODu8raWWtd3dyVkEYtXVhhKfRTetF+4sIrbj1v2lx4jmx
         dfvPdDWu1iohjO/2/TEuf6MH3YHBp4iwFwpDMNEijM4XyrccqpXK08/MtbbyHU+2sch6
         SR1xFAraU0fXId9ZvPgOrF4r0pPsqYmeoGmM8qDV0wuol44z3gTWSXA4vIFym8lUSEGr
         URDwx987vxX84kEusIijI4Xi2ml8szZFaOpFkDu/7i/eT9Ns5hcQysN9YxoFpl8vTLzq
         X80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344947; x=1741949747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84BQ3xuE/YOejwCkRVmGYfJqvNZTn+GmxFcneIOkJqE=;
        b=Qb8GlTNJT9Jy9wYGRrNcCN2o+wZIt1MHQIZ0e2QmRpAMavYDRAZbJb+jtshkvrMpWs
         kd8Et+4Est190vu6heA9tLa4VhKtDpK0ue8kwjHDIPjuMUyTaB+gHw1s1XILJX5ZtLMV
         2vO++equ5kQpaxrYbb0HI5H/CFfJTt8b18031Pd03znJzUXksu3UKJ+KEjy7Mjmu5Wfz
         O5Du6/42OB7uXvDamuw3tUJH6jPZLP8kEPtNzfHNaFwwEjxLzEYkDrbCFDWt2GNc5YfM
         2DsmVQwMNB20PFhQQpJwqJFM4dxKafobRs9fserMd+FgYGKoZny+CZNeT4M/QeEnjKZ9
         Zvbg==
X-Forwarded-Encrypted: i=1; AJvYcCU+1V54f0m7h3clPc7Ss6vpSEqxcbhRT+MockZ9PR6XCHqirr9r7hG8PqwcDByLJDeLOfx3iVuLyWbx9VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9l4IR5vg0dN3MTq69szpDY5Gv+9wD8FZvpSsmTMGiATbffjD
	yKaz81fZ5EOFu1HNyI+4LPzAsFa+nSK4RKjKgBg8TKS3OF/NJpTQeybQ1c37JsA=
X-Gm-Gg: ASbGncttELUAcO9PfYgKgBImdihC5FsZvRuq+GuKQctnduBjLTMUYw6s+ng2I5yBeoA
	5ffP8ZTiYDY/X4I64Kos3jagLh6MgcZkJeZNBIJnE6I95UtZVmyceLtZ/xEz43OCuxwcC4iMHjh
	fz1a8mkQyxoer9dWlSMspIInHW88lqTzB/kJ/wg51/6YZx2Tv86ZLcMw6rwB7nI7hv6Tn6LfvDZ
	UsXV/bsVeLHk6S17b8KCJsdTvPDJHt3U1PubniGUWA4qXdz6qIlb6zWA0D8+F0veys2VZfvqQkV
	d5IUsaFwUI5fS75pAeyRKZOmW14vgibgTP9dAJSW1p9+qHvg
X-Google-Smtp-Source: AGHT+IF+CLimdfiOZ0VORULGUWByolFc/6pJXp6pWb1JSm9n2C2SEbnZP1Xs53CSe+DMcCSm/ABWvA==
X-Received: by 2002:a05:6a00:174b:b0:736:6ac4:d204 with SMTP id d2e1a72fcca58-736aaa0f48amr3972025b3a.11.1741344947618;
        Fri, 07 Mar 2025 02:55:47 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736985191cfsm3016761b3a.145.2025.03.07.02.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:55:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 19:55:30 +0900
Subject: [PATCH v2 3/3] KVM: arm64: PMU: Set raw values from user to
 PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-pmc-v2-3-6c3375a5f1e4@daynix.com>
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

Fixes: a45f41d754e0 ("KVM: arm64: Add {get,set}_user for PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/sys_regs.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 51054b7befc0b4bd822cecf717ee4a4740c4a685..2f44d4d4f54112787683dd75ea93fd60e92dd31f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1142,26 +1142,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
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
 	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 
 	return 0;

-- 
2.48.1


