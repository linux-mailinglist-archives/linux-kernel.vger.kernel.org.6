Return-Path: <linux-kernel+bounces-447881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F199F383E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C674167869
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AB20C477;
	Mon, 16 Dec 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+Zdwoh+"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8220C472
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371903; cv=none; b=pVbNVFzHcjlTkqQy18dbMeRPbuXlog/wlu5aMy1lyuP0jsp2TUPHxDtPgl5Etsr//JbxZ1BQMVdv86DEe86HkTDWtGDe38aNzsdal4iaYdVSCKWO34+QkjLCA/Qg2g7vbyDY0krqofF5BK98dajPnjTNy3kOAEvQHsgwoFlJ5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371903; c=relaxed/simple;
	bh=VDPjyhAniiGam9OPIR7Fg0/TYc5hRZJY+waFhhN2Kqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tg59RFEcMvfUQvQExSZvyacH0XbzOCiAEIWvaHQmG3cBxxLDtDVAc6k75nsWiykyWDg70dkM6iYPBUApkUAQfC/B2EK4cTi9xpa9EPZA3F8azsKj55OYxMrQD3wlUs7UFJyRV3OsHluCKENqtNJ1Xp9n8Lau+U3UqmCMmF6JMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+Zdwoh+; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3f4cbbbbcso1957052a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371900; x=1734976700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qd1/ZR7yY7ReH6NCWgcpm0z1q63UQhmB9TeGY0t0ioU=;
        b=k+Zdwoh+Cykuv43gxHIQYhXsJV4Nemi9c9JGzcwmMEOiWy5YDYvM/S1BIa3wPplxTs
         Ay5gQL38do+TEvSuHKkvJtt5tTMb0JOdVjulUyYAgKDb08+2ZnpqcDIzfAqa2LCkYYj1
         s1NYf+JPdQJ3EfUInjiQhNeHlH4dnlBkTFFmBhKhc7tLYXM/Aw8KaQiwFXa1i3YkKVjo
         Aga0cmpIkYlMVtj2Amm/1521WEawVQjY/gkTe43Myg85Jrpan1zvm9g8LF0Rb5swnQJD
         O5dVIgLu7dz1CkISzKFig7d2FgkN73RpcPhqLEVrr3A4twXFCuMJ2x+WocFpRrZ6u18L
         p3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371900; x=1734976700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qd1/ZR7yY7ReH6NCWgcpm0z1q63UQhmB9TeGY0t0ioU=;
        b=nkF2tZu8Tcb/LEZdQoqhgvT+a9Zb/cO/V5rhAK58BPHRbowqeTS8ak+7HkQDb3zogJ
         /3SFXmstTAwHWQ4iWuQJnT0KeqbNvDc5C14ySQQCew3ERK/uhDJ0UkZFWcaJYBmdI0MP
         v3t1Mvwg28eMzUjZocWhlVzErP3ZJiHGJrSL779D0oiifJcGKqCNtCBJgqir6uboU6Gy
         xZ3wtUI9U5ASj53FlcQ7kyBffBsDkA6AWQgLSWwWk/wgq919tLzBinP/JhnpUjLjVHNE
         vAMgnjoTNmvQr097wAKDwmDtQ54lWgPJnYBaylzWxangWIlDM7aUERCTsJTyfzn4JKYU
         SOpw==
X-Forwarded-Encrypted: i=1; AJvYcCXGFiwRruTscctyl3vu9ysbu0i/dupkUllzNTTBjBkjoo/Al7l54BtXYQIQlyR3qvIPxRYzFlHoUTjPrGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1wU/bHgF76Une1mJdvZPz2h2TFYZnGMb2ytdyuiFbe/BEA2e
	rR8FBLdq2b35/LpK526nj0uC3Dcj/1nYhtbhls5P/f44yq3me/F0kE8fAf316oJnR4k6s48Irym
	It1YAPA==
X-Google-Smtp-Source: AGHT+IEZAZq2KaUjkxJv0f3RrehRlI6rnfYsshuZuD5/X0wPwG8guYjpqgqhcPwLPFFRfZ50xXtdhX2JySHz
X-Received: from edyv15.prod.google.com ([2002:a05:6402:184f:b0:5d0:1fec:60a3])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:270f:b0:5d0:bcdd:ffa8
 with SMTP id 4fb4d7f45d1cf-5d63c2e7bcdmr11529217a12.1.1734371900235; Mon, 16
 Dec 2024 09:58:20 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:52 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-8-qperret@google.com>
Subject: [PATCH v3 07/18] KVM: arm64: Make kvm_pgtable_stage2_init() a static
 inline function
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Turn kvm_pgtable_stage2_init() into a static inline function instead of
a macro. This will allow the usage of typeof() on it later on.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index c2f4149283ef..04418b5e3004 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -526,8 +526,11 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			      enum kvm_pgtable_stage2_flags flags,
 			      kvm_pgtable_force_pte_cb_t force_pte_cb);
 
-#define kvm_pgtable_stage2_init(pgt, mmu, mm_ops) \
-	__kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL)
+static inline int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
+					  struct kvm_pgtable_mm_ops *mm_ops)
+{
+	return __kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL);
+}
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
-- 
2.47.1.613.gc27f4b7a9f-goog


