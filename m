Return-Path: <linux-kernel+bounces-339782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D4986A79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3FF1F22F46
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8C17C9AA;
	Thu, 26 Sep 2024 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkFfrtNo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722F13C9C7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314521; cv=none; b=S3AwIy3c+UUvj6oIzdWhd2baHziFWqiA6zSzzZo//k2xqTR0ItJWqnRJgYRKogGcMtSK6xJvYdsJHWM1OLty0Qdan9kkX6Sh2nc9KmFrSKAh4PWz2dJsSF/fH8CbPsHbIDWFWoKvWMJ6TaJCYhklLC+kzR3KRANMLKrB6SxBrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314521; c=relaxed/simple;
	bh=LXeRxqanC6hgm//uBKuWRGkPuW268d3E0Jk8XF6EZn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OsbO/jZosSxi+xG7RCOLElKFlzPdVjMTWPJ70nkQJ8mfH2AXOiEpH5kdpn59/vnSdLUR1j+iWsZjq6uw1cIeAT015S+1G+dX1KwTLSkgxjtvD/SdAQMfhPxEiEckQxaS4fxnMsfcg1zWunXp8unXURiQuPlAe79sArSs2XYVeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkFfrtNo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2270a147aso11245947b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727314518; x=1727919318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIRgMt/tPt8dDHjlNVeDudvk1PSxwGvmBpyKYz5f4us=;
        b=hkFfrtNoec1yRcXv24pnRpLHXmbsLnZ9lnI+bVu4IWbUK7jtup7ZDPU2kEYOn1cCHs
         xU8CfMNAGzvjiLuastARaTCBgxvkpyUGOVrG6SN4PtBwZnHd4CGdRE0yaEACB9hGbIkf
         h95169iSJMWvN3gydyhMQIe+25D2Je+ZLNOWv8u2M7TXPACcoB7GnOLmuTEmxG9ZC+tk
         JG6uhOMzx/TPEU7xQeerGEFDJNKMQ8ZrW23AIp5FavhV8RFwWtNG6Fai9MpGbzAsEE8B
         4jvxsUZe04qnggdR93yWRirPG9Vub51uZDBzSt+GIxPvs2+LkDnaU+wADQDwzYf11hGj
         KzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314518; x=1727919318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIRgMt/tPt8dDHjlNVeDudvk1PSxwGvmBpyKYz5f4us=;
        b=L1ha6etO7hQHC+ZeNykV4oFSyZvBJSL5UtpTyHWxcv5+oHqkKRXuhkMCgWQmydhpVU
         3E94LY2OMN/fZPd3nwP9QgtEWk3H7ygDlFBRZVik30YNXmQK78sv2Fl8AsqbrqFL8A2w
         efHRIiauM22VY/n3jauxq4w4DKz+KHgzPBNMjLDPlN69ukIfORMrQzY4KgnblXDr9/XH
         4d1Ecz0+DJ8veoL5kfU31OhrabR6HOWWb7JqWUQzKbux0JxO26KEG189HPloq3saKim2
         FjO9Wh5JPFK0djlXbo+HqfnBo8dlcwnaNSmu7D8GbhY2NDGxwNWOHCg5obo1O93o5N9P
         uk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVDlae6O0O6T3WmHEPikB3sz42XsAhkHkVqNhrcYDY+qXII0oUXpoJTeB9Kp1HvcUXHsnTSMjdg6GO9Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwUz9xOPvDywzV60atZF18uT2Sa1WCvBreNXYDFAooAnQBdg/
	paXMhHJ/deoFwFwSu7si/noZ7d1J99Ej166/qD5lH/rausoVoqozReIN/3NMc8w6qaRsLXYh33H
	K1MjCxqEFcekXZvLwtQ==
X-Google-Smtp-Source: AGHT+IHo9npkiN5cwqAiCiI3e58k0AahBEai2pKIEYXOCcGxS2Z6C3puLSeMWFdZt66z08Hill7horZ6pvVyPTNq
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:4a08:b0:6e2:371f:4afe with
 SMTP id 00721157ae682-6e2371f4d7dmr1417b3.4.1727314518344; Wed, 25 Sep 2024
 18:35:18 -0700 (PDT)
Date: Thu, 26 Sep 2024 01:34:51 +0000
In-Reply-To: <20240926013506.860253-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926013506.860253-1-jthoughton@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926013506.860253-4-jthoughton@google.com>
Subject: [PATCH v7 03/18] KVM: x86/mmu: Factor out spte atomic bit clearing routine
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This new function, tdp_mmu_clear_spte_bits_atomic(), will be used in a
follow-up patch to enable lockless Accessed and R/W/X bit clearing.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 2880fd392e0c..ec171568487c 100644
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
@@ -65,10 +72,8 @@ static inline u64 tdp_mmu_clear_spte_bits(tdp_ptep_t sptep, u64 old_spte,
 {
 	atomic64_t *sptep_atomic;
 
-	if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level)) {
-		sptep_atomic = (atomic64_t *)rcu_dereference(sptep);
-		return (u64)atomic64_fetch_and(~mask, sptep_atomic);
-	}
+	if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level))
+		return tdp_mmu_clear_spte_bits_atomic(sptep, mask);
 
 	__kvm_tdp_mmu_write_spte(sptep, old_spte & ~mask);
 	return old_spte;
-- 
2.46.0.792.g87dc391469-goog


