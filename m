Return-Path: <linux-kernel+bounces-414973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B29D2FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53F528431E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634971D31B8;
	Tue, 19 Nov 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9xt6i1Y"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297A19C54E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049926; cv=none; b=UXaI9czjDoF70kavoWAf3d6huBxKw4iJcuXYc0POCO3K3aoAfTmcrqhBEBTwGVTf2/7q7F7fz6hW5hE5oXgVjFpAaXwxRbof3dBHbWuRTqWb6+qb6YRjxVtJdHW8H3zA/bWZO4d0OvJH5qfq1Kfn6y8YRJdmU2tE0oR8PTI4cMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049926; c=relaxed/simple;
	bh=8WEdVpyGErxs99Yh1r9MEMQl5LIFDjaIDidlxrekh0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T40oIyfM33Ozvv/lzKJaClsCcN20AtiYXQSJkXY28+tgXGHpYfiGosHeAN2Mf3ZaEg5QxAWwM3VOsUz5u4kR9juIDpd0aMDm6l+/nf3QhzKIWf6NJxmfqFxH3nwcJN94paq/xD2J09g+kvieYm+32wiYqfwLZ1lZMOx9wYuBTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9xt6i1Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e389bce2713so4054151276.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732049924; x=1732654724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6S4rOH3+OQSdJMr5U+1w/fQ9eAelD/5+HuDvTmNypE=;
        b=l9xt6i1YuApNUB+9iRAFkk7IVe7G35NBDB2dwpPST1RF8TF+kQi62HDn550kYaGVa6
         VklbDet7iwzBtASf2YjvEL23sGE8VBuMd7GB4uX+Vi4NKR46bMpKACy7erbjCHZERhXj
         GF1WtnURGMpWbzhyQxXGYwL16384acnbOxD07CyYY/oRaT9FO12Wns48waGCoBZBLSqh
         IBiqIZY73BN3W20+5bMYHxoukYYi2O+WOFECfGr/wxWGY8p9qQfI3+rYw2UI38lqRboc
         ZtKF20ImsnimunplMJEPi+ayzEW7jjT4hiN+uwT9fu4mYYUxDDRLt452IjgPgQUxY3w5
         Xqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049924; x=1732654724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6S4rOH3+OQSdJMr5U+1w/fQ9eAelD/5+HuDvTmNypE=;
        b=lOdToMOQsCPjWe5YKIcX6MTRYm2ftAyPso0irhNz+ZjFlCDzLaOejhQ3TXXEbjY+IV
         TkCNFzTKkBADvfadG1Hik2uPiOVQeG0t2LaJvzXnpcZndUbPHK0JkZOlILEfWxAQ0HMQ
         IhTNsakSDj+m/k723G9RgYVqlKos6XLrFmPhKI5LAWcdku1bUiqwqDW2WJV3+3qnPB4/
         z21Bffd1zt5NwTc6j7RQBrqOQwGzH/h0bEIjQy/SRxWxsR8XJ6OEKmRIYNsnpXb4efNC
         ESGNRDjZ1Eu6EkZ7js6xK4NiFGaqzHrvnqI7uZJyM25TIHbDShmGzQ6OXozV8AKE7gm8
         HvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvY4kMAXPZyXIWdnYaG+Oncjn8Wlb88DD5NpsISWjUgAbdZwPXbF1uerJIOa+j0wB26UpgeIWqS0P4sMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNmACuffQZjnT6p4wiMQLPj8lTDSe1uBoKVkjjRmPB9dCv70s
	6e4YVZFiWckMxM+y9Uk28r2I85lp1oDPkh8wYilnQrSHLfP/tqi5iVUabon/xt3PCcaSACOwa8y
	8EQlBLw==
X-Google-Smtp-Source: AGHT+IHpK5pQqyJ2pkrSLDCOOUklWO2InSnJR1eVoVoMwnsqp16+77q4Yb5PQps1c7yCQOY0bhbxQaG15qmS
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fac1])
 (user=rananta job=sendgmr) by 2002:a25:2d0b:0:b0:e38:c40b:a0a9 with SMTP id
 3f1490d57ef6-e38cb60bac3mr38276.5.1732049924316; Tue, 19 Nov 2024 12:58:44
 -0800 (PST)
Date: Tue, 19 Nov 2024 20:58:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119205841.268247-1-rananta@google.com>
Subject: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kvm_pmu_overflow_status() currently checks if the PMCs are enabled for
evaluating the PMU overflow condition. However, ARM ARM D13.1.1 states
that a global enable control (PMCR.E), PMOVSSET<n>, and PMINTENSET<n>
are sufficent to consider that the overflow condition is met. Hence,
ignore the check for PMCNTENSET<n>.

The bug was discovered while running the SBSA PMU test, which only sets
PMCR.E, PMOVSSET<0>, PMINTENSET<0>, and expects an overflow interrupt.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/pmu-emul.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index ac36c438b8c1..3940fe893783 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -342,7 +342,6 @@ static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
 
 	if ((kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E)) {
 		reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
-		reg &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 		reg &= __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
 	}
 

base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0.338.g60cca15819-goog


