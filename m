Return-Path: <linux-kernel+bounces-515946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521CA36AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0E33B03BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540F155308;
	Sat, 15 Feb 2025 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgE/8kVj"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24B13AD1C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582084; cv=none; b=C2buqB1sywupfkeUGyRxEqtvrFaOEsusBrkeN/UvHWjUIbAfkWcbBdJ/uZKlbh/YoRnH23gssOjbikUpGedF0F6zF2wglQSAkMiqvQOqE41+EOW37K7RcU96WanetWnHHo8UKPghozf5QHcm1rC7U+OiF/KgEDLaMcIs/sceENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582084; c=relaxed/simple;
	bh=JbnvHaDptxn9NsbJMw3UZ8db940ba/YMp/UB9zJLz0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koTITtWESxza5VTaG1N67xO7OMJOuB8HtB+yLNyhbBYkxvYqeEgIH/FYiphQFr6J6LQrQRuUWVc5ks2EyNnfefHWh0tRfSbfh1a+JzPjbuEaEZZlTs0PxHd1J3yvid87/9n5tRDJp+2sNJynm23zmuOQoP9/Uwvqjay0m0++2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgE/8kVj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so5473054a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739582083; x=1740186883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Q49hFnWXm1R0ExDb7g/KnSF2lPa5FS0gZ3iojWO2T5A=;
        b=BgE/8kVj4LXa5SEfCCcYIYy2360/CFrjQFAzSybIVXQzBgjDZJjsAE8dBP0GzUMYUG
         Tn8JBpkdNp20LuepheOt6YiYKxD1mHin8pmpWObuv2PZpCh4Yf1AXqOyW74a54g4vPBm
         1BoHm7JYU2xxp3ExJ0n6cpGgGuWs8R8Xg3olznGsHXRBs4sl+K0qJmsWRSF7eTl9kgnE
         v2JdCuxmMlS6fUBFs4ipUNeSu6FfZIqb3ZeBhd9v8UhWgdMUpdCeVYOLu2GAYggKvqTm
         JcHnKy0KmZklQy02hA53Ka3y/qqDzyd0z8vPiKLL/hNuA1/10spkGo/TCQjStPRggpPp
         bfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582083; x=1740186883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q49hFnWXm1R0ExDb7g/KnSF2lPa5FS0gZ3iojWO2T5A=;
        b=oqCMU4rDou+PGGhZcct/xjyoWXwvc9BF5fHFuvomlkIGtkvUPe5W2qf+hX6sjz01Gr
         q5amdbbt6ocJVuJzQH9yaKUsVhGsUuf8P9EXTSMLtJsMmyO1UFynjsSoQfK2gdcmjGW7
         4moGyat+UY97ofWUpEtTdwhRmehJX4brKlz/TP5qcga3trcqAvVJZcXxMrJWqirO56Y2
         LWVEZiqoW5GNE4q3RPvRAVRBILiifnanHZ54ZR5sVhau8xWAnXdFkuu2N7nDkYGSqdrV
         xDFeaXPC0M8Dja0TtBgQl7aW6kRoVGNg4CYf9X30Rz116Gc9z0R2jhJkuo5ltygmKd4y
         2qxg==
X-Forwarded-Encrypted: i=1; AJvYcCW0K26rxTqHMW60Gz41rqYlaEC4gj+ZSnTo/nrsI3aMQJbCsalTnMhz2lGsaimXrkLLCehgZtYAJe886q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoEviSTpZQEzx2s6UtTsBNprD5URnMg9JJq5t5Rm5WsuWu6vJ
	nZyrQRDMMg4Lh8XZphnql1GSQQsBpQDLMe7X4vDi+LXYVOQjbozjldgYB6APC0ubCvxstrAy/do
	eTA==
X-Google-Smtp-Source: AGHT+IHBkyl4PIpFpkFkqS6pqT2rwD3MsxlYDyDhMSaF0m4JLwYlAZEuhy23IIj9HKSlsdXErMSDNcJbz7A=
X-Received: from pjbnb2.prod.google.com ([2002:a17:90b:35c2:b0:2fc:c98:ea47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3949:b0:2ee:db8a:2a01
 with SMTP id 98e67ed59e1d1-2fc41153d87mr1793706a91.30.1739582082789; Fri, 14
 Feb 2025 17:14:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:14:34 -0800
In-Reply-To: <20250215011437.1203084-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215011437.1203084-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215011437.1203084-3-seanjc@google.com>
Subject: [PATCH v2 2/5] KVM: x86/xen: Add an #ifdef'd helper to detect writes
 to Xen MSR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joao Martins <joao.m.martins@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Add a helper to detect writes to the Xen hypercall page MSR, and provide a
stub for CONFIG_KVM_XEN=n to optimize out the check for kernels built
without Xen support.

Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c |  2 +-
 arch/x86/kvm/xen.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 462a5cd6ac4a..12c60adb7349 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3738,7 +3738,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	 * page setup; it could incur locking paths which are not expected
 	 * if userspace sets the MSR in an unusual location.
 	 */
-	if (msr && msr == vcpu->kvm->arch.xen_hvm_config.msr &&
+	if (kvm_xen_is_hypercall_page_msr(vcpu->kvm, msr) &&
 	    !msr_info->host_initiated)
 		return kvm_xen_write_hypercall_page(vcpu, data);
 
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index f5841d9000ae..e92e06926f76 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -56,6 +56,11 @@ static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 		kvm->arch.xen_hvm_config.msr;
 }
 
+static inline bool kvm_xen_is_hypercall_page_msr(struct kvm *kvm, u32 msr)
+{
+	return msr && msr == kvm->arch.xen_hvm_config.msr;
+}
+
 static inline bool kvm_xen_hypercall_enabled(struct kvm *kvm)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
@@ -124,6 +129,11 @@ static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 	return false;
 }
 
+static inline bool kvm_xen_is_hypercall_page_msr(struct kvm *kvm, u32 msr)
+{
+	return false;
+}
+
 static inline bool kvm_xen_hypercall_enabled(struct kvm *kvm)
 {
 	return false;
-- 
2.48.1.601.g30ceb7b040-goog


