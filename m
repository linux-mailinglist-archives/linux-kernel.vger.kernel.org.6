Return-Path: <linux-kernel+bounces-182717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D77358C8ECA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8611F22596
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDB3611A;
	Sat, 18 May 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31/gGNFl"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40033E8
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990695; cv=none; b=bTyyamyEG0xVc4y8qwU3RpBtp3dFHKJi9tQpFIW5x+m0KOXryhShqRoHoCXsx3k8jZB0Tdv4Cia7UEy7vHN7NscV4ZLEWLYmoin6DWdubtHQQk4Rq5QxigUkCrW1eDo7BncTDKLTwq0y8p/iZvwTMpY0NYjVUN87Il4fByL7p0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990695; c=relaxed/simple;
	bh=ectuSuFOojgkLLmjDmKbjYyngGKrMAV7Dv3oP241fUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G3eaNuiEjdm9gRAVUgZxS+Stg56fiUD6KvtJeLxJzsap0OCU4ZgAaTxPNUsskN9hsG8DdpingDCsmvah5s/a1i5GMtAcTjst462HpLxQxDLkmv/oybbBUS4O6ya4Xwmx5joOWmnCYsUgX66LbXWXRzDL1Fx61Gl3oOSquGFUARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31/gGNFl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de74a2635e2so15969144276.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990692; x=1716595492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PmNsMiZYuI21fzAH4xPEmM+x/ygJuUkqhfrSS79CJmk=;
        b=31/gGNFlyljWFYLmBC24TzcComNO9PXyscXqyzQGPwj7pM70dSfcJp0KH+Y3HNnmR2
         vEh01tsKNPQY60emtKQ7iuRx3YYpcSP/DwQq4coxRRUYpd6L8e+fs0ra5MvZXIypoQvR
         hFfx1SLPFVvG8pLMk7VjVySSeYiax2xnMA59s/zjafs82OZ2ZWeQFPdxOhFjaar9OXgk
         m19uLx6F6GCigbthGjgWTLSbub2yDCOWNqhDNrVDx+V2tcF+PQjNpo90GJ4nXAfm6KTm
         rAybeF4o9VGrcKf2npUqvoEN78AlZCRlPbfVEXJ00jpHa50WKlmffjX4JMHNs6Db7qd2
         uB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990692; x=1716595492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmNsMiZYuI21fzAH4xPEmM+x/ygJuUkqhfrSS79CJmk=;
        b=ZVc3k7ff90Z45sPvV2y2VwKHymbZo+yjL5yhrg8NVuVq1vfIg+CGTLrJVOTEmN5e92
         dnvbAtPmbsPGYNRH9HBerOii5xTn/PRq6JeUq6L1yK2mSOSnjEGEORqcFKjMrGhQpdzR
         9XyvXdPsdff1ooyFAZKv5DEGOBGasY5uJtI3LI3WLqPuYPk+iRc3UW+k2MiPZICdfDoX
         a9iYBIp97bHXfjtAmNyPTl52oHlTiL+PTdIs1x5SnwhAiQ9Is82i567Q+Q5ijI1ssazM
         vrxBrNwnim36Xd2GlZDofAaJ5Qm/uMgeikAw63M06b/pVFP/k15DIIvTt0AqI6PKsWzX
         CdHw==
X-Forwarded-Encrypted: i=1; AJvYcCXr/zViYAymKSi15MskpgC2wNokZ++JaMOTPBn9s0LZv5hmH76Qh8XAXE0TpsRY07B4Zg/T+QxqRke+mQbD4vYMsD21xhSGzrpXKuFx
X-Gm-Message-State: AOJu0YyAhcoecML2WfgubH86LnyYzMTk0tFmJEPuUc8wYdvdm7trWsBl
	+SHK27sAc1EBKdHKwiXYEyTT2SHLSEhDwtCc0JpywXNQAwSQ52l2O++2YQBe+13c6GA4fymH5C/
	m/w==
X-Google-Smtp-Source: AGHT+IEKsAdKYBFpozQHbHXiVJ/HspTDM2CFInyHubWioj3i50BbfdUhI4/kUioYnKr2iux2sNvJgfiTfs4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:b0:dee:63ce:9718 with SMTP id
 3f1490d57ef6-dee63ce9a16mr2061685276.1.1715990691759; Fri, 17 May 2024
 17:04:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:29 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-9-seanjc@google.com>
Subject: [PATCH 8/9] KVM: VMX: Enumerate EPT Violation #VE support in /proc/cpuinfo
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't suppress printing EPT_VIOLATION_VE in /proc/cpuinfo, knowing whether
or not KVM_INTEL_PROVE_VE actually does anything is extremely valuable.
A privileged user can get at the information by reading the raw MSR, but
the whole point of the VMX flags is to avoid needing to glean information
from raw MSR reads.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmxfeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
index 266daf5b5b84..695f36664889 100644
--- a/arch/x86/include/asm/vmxfeatures.h
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -77,7 +77,7 @@
 #define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* "" VM-Exit on ENCLS (leaf dependent) */
 #define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* "" VM-Exit on RDSEED */
 #define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
-#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "" Conditionally reflect EPT violations as #VE exceptions */
+#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* Conditionally reflect EPT violations as #VE exceptions */
 #define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* "" Suppress VMX indicators in Processor Trace */
 #define VMX_FEATURE_XSAVES		( 2*32+ 20) /* "" Enable XSAVES and XRSTORS in guest */
 #define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* "ept_mode_based_exec" Enable separate EPT EXEC bits for supervisor vs. user */
-- 
2.45.0.215.g3402c0e53f-goog


