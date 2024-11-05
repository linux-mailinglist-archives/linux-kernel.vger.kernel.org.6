Return-Path: <linux-kernel+bounces-396980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72529BD535
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B81C22B48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDE1F4FBD;
	Tue,  5 Nov 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ae95Zujj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25151EE037
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832228; cv=none; b=sxCkPZQ6i8OtPRjjMDYVMuZGekvxv2Uzm9slClU7eQ2h1NChoe4VmBXDqc9iscxAR2KguDFqG3UM2we9Oh3/JXktd1s0b+oPsbdNX70ehuM8QZaD2dAX3XNqbjPe1lCNdIVXLXRcCcIRnrvCVmnjjhN5FZNuWFkYWEB9JmK/g6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832228; c=relaxed/simple;
	bh=/iQ+9SFHr3+eSC4MwdAWPvkjN09yEjcpMjdI5J7/Kp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOZTWA/R12Q6Wepc3usEyzdJ8+1ybXBWvwQjXd6+2YNj99KLmNQ0B1IpPrPQRX2QxULt+mHX+U29IQFlumtXeAwi+TYpxow3Trs++JGdcLLuf3EskAIr83qK0QiDzftgIPioHPVkJpYJbDdxVGqxrTCVM7inc74I6wrrioN73hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ae95Zujj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea7cfb6e0fso76883867b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730832226; x=1731437026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eFxuwycLsLAbgeJ2mfRY/GmSrQy75uRCa7WJGSthvA=;
        b=ae95ZujjfyW78zQnIBmR5OUT0kRdRx/L4PsTlm6rDh0wwlRfBX3jUUzpDY7rUTFAYj
         zFzR2IiCdf/T/wGVnvhjq11fhh97u2EZxOdvZ5cM2fT6vd6Y3NMTIDs2QgqIiAC01EK5
         FBPGuA83J4/uRbiipCteE5Sm7IP8DAlU248Orq9qrhjIv8XJzC3SiPrzLAayil06Xwzt
         R4i2dHlOCxTggHiHEmlo9VPhviO3RgBQtqtNcM5pro5aHRioLZVBiG7dphG8cDYzDVh+
         YJYQKzp24sbV/dIgN+yfxNCIQUAgoozMDoeRXr6vXSz4Unv1xGgwkELeEL8SHkEoq1Pu
         MTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832226; x=1731437026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eFxuwycLsLAbgeJ2mfRY/GmSrQy75uRCa7WJGSthvA=;
        b=eQBHiEpVu/pccYQJfTeIUppcnAz1rmPBQUr9p227AmpZjwmGWHmACWpmtK1P/VcuLW
         aM3sPM5C+ADmi8FKjPc8KPhi4Y3KHccFysI5yD4vyLQAwSlryb5Dklb4JBqZVIr9XcF2
         vsvQgvYQ1z/JgDR8LJ0z7Ob90WCqFUae1LjF01oVrGwOrxii2MZCvam3JNrPcuHObdQi
         UVfDId8qGm88LLvcWeXVqRHAjrAxmiT8HcGqBsvos2BkHv/MAxfHDP5jtJNRfFjca3vN
         I4f7LQFpWrtvAsSy3Pxw9jZvFO8WdPaKXFitgJIm/oBWUEWIziDUNW+1gwjR+1sRg55y
         gZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcNoAFlJkuwpJuKvwnCXGqjiW7wgi3QVU2Izge4dhd9FaHfU8I3l21QJ78zv8rfso0arGxBrSCpnbyrE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsQZRbyTPzNmBAvKzbKU/NkbHbJqyCmPcopPpNUhC2Ia/tB97
	VaSqqKLbvSs6zYQhtFZiBRyPd5VUVWcSBvzTT+jTyw0NXMSpIizeWo78dHLD+wW68yqmVwkoTdL
	+H5NpuuDtLXIyWF6dwg==
X-Google-Smtp-Source: AGHT+IENfGBOOxiMAGivPRvdHYCFkRZ7cQKI8lrn9MmMEy60InS9mwDJ6R0bcKfhRAeslM5j1SEZ1ph/hIA93Day
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:4512:b0:6e2:1b8c:39bf with
 SMTP id 00721157ae682-6e9d88ad8b5mr10038697b3.2.1730832225710; Tue, 05 Nov
 2024 10:43:45 -0800 (PST)
Date: Tue,  5 Nov 2024 18:43:25 +0000
In-Reply-To: <20241105184333.2305744-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105184333.2305744-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105184333.2305744-4-jthoughton@google.com>
Subject: [PATCH v8 03/11] KVM: x86/mmu: Factor out spte atomic bit clearing routine
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Houghton <jthoughton@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This new function, tdp_mmu_clear_spte_bits_atomic(), will be used in a
follow-up patch to enable lockless Accessed and R/W/X bit clearing.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 2880fd392e0c..a24fca3f9e7f 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -25,6 +25,13 @@ static inline u64 kvm_tdp_mmu_write_spte_atomic(tdp_ptep_t sptep, u64 new_spte)
 	return xchg(rcu_dereference(sptep), new_spte);
 }
 
+static inline u64 tdp_mmu_clear_spte_bits_atomic(tdp_ptep_t sptep, u64 mask)
+{
+	atomic64_t *sptep_atomic = (atomic64_t *)rcu_dereference(sptep);
+
+	return (u64)atomic64_fetch_and(~mask, sptep_atomic);
+}
+
 static inline void __kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 new_spte)
 {
 	KVM_MMU_WARN_ON(is_ept_ve_possible(new_spte));
@@ -63,12 +70,8 @@ static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
 static inline u64 tdp_mmu_clear_spte_bits(tdp_ptep_t sptep, u64 old_spte,
 					  u64 mask, int level)
 {
-	atomic64_t *sptep_atomic;
-
-	if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level)) {
-		sptep_atomic = (atomic64_t *)rcu_dereference(sptep);
-		return (u64)atomic64_fetch_and(~mask, sptep_atomic);
-	}
+	if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level))
+		return tdp_mmu_clear_spte_bits_atomic(sptep, mask);
 
 	__kvm_tdp_mmu_write_spte(sptep, old_spte & ~mask);
 	return old_spte;
-- 
2.47.0.199.ga7371fff76-goog


