Return-Path: <linux-kernel+bounces-182710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F38C8EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F811F22490
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BD5C96;
	Sat, 18 May 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Evs33zy7"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48974653
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990679; cv=none; b=IxsCOVyikDvPPuAKLYxNpSguQO22/UrrIGUbNKMjTl5gB8h17LreFlUKdKkGOqB3n6hdfgd/PSB4nc76fVzaykdFF74B5QvVjRxcMNzPEcOirpuOgrxwT6ilCfBsLBkAIZrJuJO7YJdf2mcpKUVauADeYF9thMFfLU74s6V7OHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990679; c=relaxed/simple;
	bh=rvIusehJzyfZSU3DUGfZk3ycQpyzGMDHRsg3jAj+Fmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMYmuw+nGWxIA82NZqNCZfznyhPI+G/CvhKIjWqumU9VFuXa1OZHDqAlLZSESMKj7vaqqNb69pLwqGIIQ3vMP18+ZuyUqQy+cvBnSYctXPRquICQT58QNM4GSAC+RNqI7tlqWOjQg62J2iViT/yBE/HV4JdQLGBhD7wkbMAlejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Evs33zy7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2bd5f87a0e1so274953a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990677; x=1716595477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lj20UPkGYyPVSIzMYtQicJyMaFFHUkTnXbi2b/YJs04=;
        b=Evs33zy7rS9tKW6zWsgeD6fwSsJy5yVUeQMorSYou/bVEFHs7fC71O1KyAvgOUD/Cs
         D7W3UqdauEvezPDstiPYmK5GyrgykeKXFRVCdtbCtpt+hUV6BfAEDZHG/w5FvmIRLdot
         B7XezgmiCp3/eteM+IUcXmuf667vrgJasr8DjdM18iwTs6uAWth86iKLSVBSrWm04M85
         YWtYc2i0V4wCJyDS+XHpCHPfZAQXpoZvSUM5uooK0DTIMIpMyLfvdxvdMmrcqnNpvbJg
         s0SvW9wpmKvQWBiSY+851mY02Hj/3OhUmDm7Z/B7vHLc2YDin01V7nKwscsThwTWOxgk
         PT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990677; x=1716595477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj20UPkGYyPVSIzMYtQicJyMaFFHUkTnXbi2b/YJs04=;
        b=bRQ2mIim37dA84Q7+ffVTgEwC+omDbvFl8E6/eFZtX8KOHrxOOmvGqFyWDwJbFXNHh
         lazbTG4DS09jHCxbqcUN92PjktyBUB4bLkW0YSBeX33V+swzle5hI0jc7pH4PF9t42cI
         rgsOiyl8sf78P7zKr3hu5qNPIpHUsT33484WRIBImyWyW/QRR4z7CyxtDXmRSBXHF7oD
         p77Y8ev5meqC/eX4ILWuyMEWYmUfRjY219128GPsxSJ32BZ/AknNoPCPrf/+ZSYybhzL
         aqnt4t1nGhWL/0BEAtk7KCo21DAnaGICt+UPkO3NGh/ktuDXY/a/xs1hyckK+yGNiLcs
         u++w==
X-Forwarded-Encrypted: i=1; AJvYcCUUeckymHimvNJt9JmcRWhrk+LgZkJLc0s2/MHoorn5QfjDn2/LqgbqKOdVaYxtPxuHqi519U0xqJUEzOF4XNAx8/Mc+iHeZTyQLPEV
X-Gm-Message-State: AOJu0YzAAgYrZp7Fq1pe/LUYcwzJymT7m3LGCWAGPXcqDhkKFnj3t2YH
	RTiowkee0/NPdX/HfIk/Xdn7NHIq/U+y54L+bebZ8QK65hElFKeHLf/997clF+T8CmR038IvpSz
	3Fg==
X-Google-Smtp-Source: AGHT+IGpdxtM8Gr2Cby17gotkm6Me/GjSzJCCJjzc+9CZGnGeexqUy7HUOGADG/0D9GVxcMlmsZaUfGAvLs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8809:b0:2ad:df73:31c4 with SMTP id
 98e67ed59e1d1-2b6cd20f995mr63818a91.9.1715990677507; Fri, 17 May 2024
 17:04:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:22 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-2-seanjc@google.com>
Subject: [PATCH 1/9] KVM: x86/mmu: Use SHADOW_NONPRESENT_VALUE for atomic zap
 in TDP MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Use SHADOW_NONPRESENT_VALUE when zapping TDP MMU SPTEs with mmu_lock held
for read, tdp_mmu_zap_spte_atomic() was simply missed during the initial
development.

Fixes: 7f01cab84928 ("KVM: x86/mmu: Allow non-zero value for non-present SPTE and removed SPTE")
Not-yet-signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[sean: write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 1259dd63defc..36539c1b36cd 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -626,7 +626,7 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 	 * SPTEs.
 	 */
 	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
-			    0, iter->level, true);
+			    SHADOW_NONPRESENT_VALUE, iter->level, true);
 
 	return 0;
 }
-- 
2.45.0.215.g3402c0e53f-goog


