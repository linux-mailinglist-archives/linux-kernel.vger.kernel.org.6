Return-Path: <linux-kernel+bounces-357298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF829996F54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E38283E19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590301DF759;
	Wed,  9 Oct 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRzJwMuW"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC561DD86A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486303; cv=none; b=h6MlI9raLhj6VU7FwJWXCeeD4nPSI27n7an9ANVrIO3ZbPxTp6X6dfSExraP4a5WmZ2HzK8eT7XefjhJllrDLImwBOGxKA9Uz/pv3102RJ42vNPQrhWzkBYtwh3URqwgeVuRCoGQ50CcbMlkrBwI9ihYr7HnsXlLyG0d6HCcQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486303; c=relaxed/simple;
	bh=joP1gyCPe+hwOJUfhGfPr0n9jMYIyiFIDeC9OZBymQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aVgOXADKvPH8doxsH/yXCrOX6ZoTNPRpZlwQWmubA544wHICQbHBsMWOGOfiHG1ivuTmcDdkIi0bmIkIQVvYY/yO4i4Hlm2frR774mnI61KQsC5U2I0CH5Zg+x1z2BdePqWQbGt2cz77EZyXD+HhGpk0oQD5V4HW23GfqroFPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRzJwMuW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7e6cc094c2fso808652a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728486302; x=1729091102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/RsDegA7EWZeVtL+/24jQ2r/aKoJnN7q7/C9Z+6EiSU=;
        b=CRzJwMuWtc3wpumgCbjGwmOtbdA7MjeQKSed4nO7Zh63YFFx6csYGczkzuUmGgpKI2
         YqhteQ9cjLDe4auqI9I8enpQCpyW45brCSydLpwsQIAa+KMFR6WxJajFH6NFXIDGfywL
         H1rvLb+7+RLO1cDwkpLJHWvJFtT9SDE7kWJsRshhQSoHNOZSg20ejzwgNUmPMeDwvp0C
         B1pVXUFfQdnMxFhLNJJg78MjqX5+O///+a9rJblkrgJryFOnY8pQfaJktgwv95FRt1BY
         4Dn/Jz2Gua8pDIr6z51OxTTKsrLrDwwo3y3wW8I6nX7i9jVgjPBXsomMA50NMNUYPuHX
         ov+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486302; x=1729091102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RsDegA7EWZeVtL+/24jQ2r/aKoJnN7q7/C9Z+6EiSU=;
        b=rg1t/O2hFINb20VAN2Csee13o5Lqw6y3PWMRIpd0Ubx6s3A44+bmWuQEhk2+3qGgns
         mOjjPFD8+X3EVVlw0dINigt/rILNQi9Gpju/IfSMMGCYlHdp2rZcX/vtZk+6emapBOec
         wrvKSkNIOIHV70b7VWlSG1Iq9ZKVlA5uCYCcS7FC5fn/VoRF5inBK5eWnIzBY3VUZbKE
         apDOyWkMsVpeNX6H6eRUmUjKonkheyzKzC3iI6rEknI2c5qC8d4GG3EaerT40VPyReeo
         sy1tJ/2uTSkPIY3diPTAnOI5hxaHrDVhn8zfntcsW2QyjBo7MvOyGE+dsUybxJAtWmFY
         a1cw==
X-Forwarded-Encrypted: i=1; AJvYcCUSJC2FESLuapm6AcDXjEddDW1nsG0lJIIL5CzzgCtTnHNyoVRsHhXGc5ejQj9wdwLfrPt8NbG/pFqOlQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHBWzstkhiBWvPy6WJ+KNGrgirhngBo0g2D7dLhIYAZg0wSob
	DYa3oswkEDGzs25LRShqMdH0tH8a70hj8SESPIj6UOeT6uuJ1RfrhbkjsSrqs6mkhftbyZrxh3M
	TOg==
X-Google-Smtp-Source: AGHT+IGXEo6jBIzb0et6Z+0Bgl35nZ3qw5fx0ehgX+u+72GQ6GGS5KT3St9rZ3gVnOUrSzXWlGjg9Rucm8E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:bd93:b0:2e2:8f4d:457 with SMTP id
 98e67ed59e1d1-2e28f4d04cdmr10803a91.2.1728486301403; Wed, 09 Oct 2024
 08:05:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:04:51 -0700
In-Reply-To: <20241009150455.1057573-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009150455.1057573-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009150455.1057573-3-seanjc@google.com>
Subject: [PATCH 2/6] KVM: Verify there's at least one online vCPU when
 iterating over all vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Michal Luczaj <mhal@rbox.co>, Sean Christopherson <seanjc@google.com>, 
	Alexander Potapenko <glider@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Explicitly check that there is at least online vCPU before iterating over
all vCPUs.  Because the max index is an unsigned long, passing "0 - 1" in
the online_vcpus==0 case results in xa_for_each_range() using an unlimited
max, i.e. allows it to access vCPU0 when it shouldn't.  This will allow
KVM to safely _erase_ from vcpu_array if the last stages of vCPU creation
fail, i.e. without generating a use-after-free if a different task happens
to be concurrently iterating over all vCPUs.

Note, because xa_for_each_range() is a macro, kvm_for_each_vcpu() subtly
reloads online_vcpus after each iteration, i.e. adding an extra load
doesn't meaningfully impact the total cost of iterating over all vCPUs.
And because online_vcpus is never decremented, there is no risk of a
reload triggering a walk of the entire xarray.

Cc: Will Deacon <will@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 450dd0444a92..5fe3b0c28fb3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -985,9 +985,10 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 	return xa_load(&kvm->vcpu_array, i);
 }
 
-#define kvm_for_each_vcpu(idx, vcpup, kvm)		   \
-	xa_for_each_range(&kvm->vcpu_array, idx, vcpup, 0, \
-			  (atomic_read(&kvm->online_vcpus) - 1))
+#define kvm_for_each_vcpu(idx, vcpup, kvm)				\
+	if (atomic_read(&kvm->online_vcpus))				\
+		xa_for_each_range(&kvm->vcpu_array, idx, vcpup, 0,	\
+				  (atomic_read(&kvm->online_vcpus) - 1))
 
 static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 {
-- 
2.47.0.rc0.187.ge670bccf7e-goog


