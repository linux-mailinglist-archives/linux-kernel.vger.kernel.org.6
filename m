Return-Path: <linux-kernel+bounces-392751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A959B97B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CCF283CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCEB1D12EC;
	Fri,  1 Nov 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmPeNUEG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168CD1D0950
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486175; cv=none; b=lz8uajirGQ6mBkbcjU8mGC3gt/s6naxP5F7BeFuxXbjLjWpfUJZ6skuklp0Rm/KR7uFQ9TnUuXvwvVkLYGP7zHKVwyCHSWLStKfJ1suJQ5UHuOVrpucvW3Oxys2Kln/XVJtQy6xn3Qty9Bom6ZjuYKJiWKd8mMwVrKHa9pwFrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486175; c=relaxed/simple;
	bh=zFx2TIjK1OdJNejtX+ft1iBzbu3KT2YeNAnYrxfGZuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OE6RZqEhQA5d4vrYJ0w+k5RZF/ZR6H2CMv70+AT4cD7HYsqWlFIp1hsWzIyT5ISsEw1QstyAMAJWYJZIH4WhlsOhR8TCwJBqyIIzEA/yo4xH7ftCNtkTLAm679wGNC8Ze4o/uvwsb1cXA8QQ56dXYN+f+HtFnEWFckgRDnwWOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmPeNUEG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so3880722276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486173; x=1731090973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SuEo4GUloct+B3/M5HAiS1mpZ2QSXRnWVclEOfjiYAM=;
        b=SmPeNUEGRTa0t+Z9O7shSsbiu4qZme35Tu4LOjjQlIMEnw0SlqQgMhQCFFRAOUDnwy
         yZKBvrtZTMc8PG0DzD8rB28oK93eF8GjfDEZhoqqvc09o2LOT0gIGdkOaDNntholTXTZ
         2ctFvQTMK5uRqkwe4TugrZsPy4mhGALHRl3B7V6vyO/OCTii+5kkMaB9riy0ySREAOOB
         pqZeXfTXNdEHuM8q0ru49RzXUUInwBT8pEMQRyDkncFfZ9Bt2YnEpmsNVg+pAZpcjJpy
         ktU3Rs5LUtAY5Dq1j/k79OxbaArXdSvr5CMdheGEPDC9UDI/6CGU9bnBP+NIsR18U2OT
         3Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486173; x=1731090973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuEo4GUloct+B3/M5HAiS1mpZ2QSXRnWVclEOfjiYAM=;
        b=gyWAVSiekFkDntOwLJNQby0whA9iKFJ9UfeVBf1s2KMVOMoTd1QD6U7vY9M6V6Ki90
         0vlEq0uLPBTGVV8eG0WsnbHbWe0DdtVsIBZPhit+v/duk2Gy626ty55UoS6raLT2/4ui
         asIOtfjReQnDAJgorLXdZi+MQlZetcQAXNU3l3Iw5DsB0tsUTS6eL7eYhha1Qpq6TO6O
         PVNXJzbM5QyBFAW8Da/3WlxFtvAMwAbRZpXWx1g4rHlD94hbIFqp75af6axe0pK1mjuX
         yyWgqd3pRoV2HZhjU+Ev0DkLAPTPdKOBofKrl2UROnW+/kwwsblDU5kVHV1bOaB8RfFT
         wZIg==
X-Forwarded-Encrypted: i=1; AJvYcCU/DBb1qE7cGzGpjxCmCDbIXl/OuCsg86KDjjTrhISnMHThheOBB1LbyMzvFPbHI3QIqLymUBpVrXK/Wys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk65wqPmMFU0ZQW0WWcnUtVX77Y754D4X6oA6Djs4k79aTlTGx
	zV8qC8cHnD/UxQCV9yTXMzKtTNM6f6AJ1BYIQybaff5Eh+Jkx4VenmegXs6SvuvU+C2DIByK575
	7nQ==
X-Google-Smtp-Source: AGHT+IE22lmjUlicPPO8OKaqhuLO/T4xSBECZnj8FSh00/I8mPt7rNgmEDffLoleV3L6b6O0qgyc6nCwMfY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8541:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e30e5a3e278mr4578276.4.1730486173118; Fri, 01 Nov 2024 11:36:13
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:53 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-8-seanjc@google.com>
Subject: [PATCH v2 7/9] KVM: x86: Make kvm_recalculate_apic_map() local to lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Make kvm_recalculate_apic_map() local to lapic.c now that all external
callers are gone.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241009181742.1128779-8-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 arch/x86/kvm/lapic.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0472a94e7b3b..7ddbebf78761 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -382,7 +382,7 @@ enum {
 	DIRTY
 };
 
-void kvm_recalculate_apic_map(struct kvm *kvm)
+static void kvm_recalculate_apic_map(struct kvm *kvm)
 {
 	struct kvm_apic_map *new, *old = NULL;
 	struct kvm_vcpu *vcpu;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 0dd5055852ad..fdd6cf29a0be 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -95,7 +95,6 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event);
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8);
 void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu);
-void kvm_recalculate_apic_map(struct kvm *kvm);
 void kvm_apic_set_version(struct kvm_vcpu *vcpu);
 void kvm_apic_after_set_mcg_cap(struct kvm_vcpu *vcpu);
 bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source,
-- 
2.47.0.163.g1226f6d8fa-goog


