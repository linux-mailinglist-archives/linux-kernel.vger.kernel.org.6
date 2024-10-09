Return-Path: <linux-kernel+bounces-357728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A289974C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFAC1F210AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87671E3769;
	Wed,  9 Oct 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcIw2BMi"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AD1E32A1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497879; cv=none; b=EN2v4ay0kIUP/Sk1BfMZmV8fr/tlL7CaamWfkTPIyAkGPxeOwNTHSuoaGKG1H9359YsNB0GAwcZSddVcXnGzeKQHH0n1XXmnIBY0pQjIAmkYlny0UTwh9hpRZZrG5cthaeci1CmJsiSl78vugy6fGbhxQrAkmEbowOrTNafSLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497879; c=relaxed/simple;
	bh=ExK2B45+IldPIhcp+mgV/yZse0LGT5sPNb9IYvCVpXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kGA95wHswqg5Yly0zkyxNYoHWhgF/riTzsZTdv+HkzEjVL/FYMnSKizFPRtrv37n2Db3CCVRIh1saNwi0tcRxkMlfeCWEdyra9X3NhrQQOYu+VJ5D/0L48a4RocRF2xZQ1FmxKvEVbbqGV3/bOp+5PAZP9ibaDRIYm40xTb4V+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcIw2BMi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7e6cc094c2fso1011802a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728497877; x=1729102677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MaWbmPdh1mO0Nq8ZJC6BrpKNBUmVzBfz3tM+bJ0ag3A=;
        b=gcIw2BMi/bfSPdDa4tBo7uKhSBh3/pnSwyGnAkUxFr0gR9ECcOUUSqHugiRYlba5XF
         IKXq7BPM+Pr3C7mlIu3E39myJEVsPwOw62HecrAvXJgHiBYblUqGIBY87TKc8N5w4Oks
         1nVcA8+Mx4doXEjL6R6zWweUo3Hl16rfnk/xYUc8WxJ8hcvLEH6mrNv51VwAlK4/TMoz
         DU7HkI7EshmXbilQlp7+e8NY0ePgVfZXAct3Tscg+4WNzOGPtIgGHVdpnTVX6rXZz1yw
         A3CNvy6tPe5/j8oz5A7ZjOu85YiYHe4gsNcZVFpax9SXQ7gVC3Cwkm4Yy6CpjWPKVVoe
         PXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497877; x=1729102677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaWbmPdh1mO0Nq8ZJC6BrpKNBUmVzBfz3tM+bJ0ag3A=;
        b=hOy2OlTKanjHgzePfcrWKUzAKKf7TWngICXEdhZrhuEQPIek/Oub5xCCa9sUI1L4Nb
         S45NOAgeliasAWiDIMKHRcfM0AtKWfnA6Vs0rUtSMtvqMwDahLDTCZIcei7kZXEu9bBW
         +Yjzr/Mo+y/vvVhhHgi9KJqq0+1UWCXuC71ySmDeG90Gd3AwRyaxLzzOyTryFHiZU5mZ
         6UCh8vt3H6brmuqaIt8GTeRbhxoMo6O8jNyd4/Ak62mE48eU8hWVz0xXu7FS+9WHFWeQ
         So4ck5VhSz7EiQQd4/PEgaIie/xX+7kmi8f6uUHYnPDHSEMrXyb1JcdjR+piAnuL3Qq+
         02yQ==
X-Forwarded-Encrypted: i=1; AJvYcCURncCYg9vrpOdYAaUgUI+pIXAs9MYvKNDrCMsqksRx10pxbVYCQ2ZunUmJDTCM/DatfFjNi0hezV53GK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSab4ueD5KoWs64kAoBoyuNbSTn3fcioryI1QY3LBgSnbR93s9
	si9gDb924mQ9/JJCmhq24uBQwxfhpnmm9TRhR1qHV/prqDZMb+UIduO4GT4CnyLPqZX+L4Y9w1/
	xJw==
X-Google-Smtp-Source: AGHT+IGNIE/edZnSUhMLEyYIvFpZ/Bc88mfOHpXxJTPoPiSpDG28tToOr/MFA+a/5VyqkU8h8H9o9tS/A/o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:815:b0:2e2:bf47:956e with SMTP id
 98e67ed59e1d1-2e2c7ff9325mr656a91.1.1728497877077; Wed, 09 Oct 2024 11:17:57
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 11:17:41 -0700
In-Reply-To: <20241009181742.1128779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009181742.1128779-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009181742.1128779-8-seanjc@google.com>
Subject: [PATCH 7/7] KVM: x86: Make kvm_recalculate_apic_map() local to lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make kvm_recalculate_apic_map() local to lapic.c now that all external
callers are gone.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 arch/x86/kvm/lapic.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0a73d9a09fe0..21fe50aad603 100644
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
2.47.0.rc1.288.g06298d1525-goog


