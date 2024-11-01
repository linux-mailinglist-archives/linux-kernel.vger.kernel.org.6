Return-Path: <linux-kernel+bounces-392746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404999B97AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F9A1C21D62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1D1CF7CC;
	Fri,  1 Nov 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5A/luYT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA121CF2BF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486164; cv=none; b=t3/1il0Zj4w6tqNRYXKB7Nud+w0EE04s3PS4e7av15BR+KJXRT/ENNvKEM1jzdDNtpn9mOUy4JLu7Q/SzQ30Y6oyQvwsvb34n26lb8IvD8BpLlAD+8xWipwmUmE6cETj+7sJgqH8aaYZxmG+Mjbff6kPD6asufq3Rw5xJDWJAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486164; c=relaxed/simple;
	bh=kVsh1e4mXUBXaMtm0DNpuubdczbQWRrvs26jscxulfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3d9kOFBf7EZdTuKTrfnieMmM4Al9m+AvQ54dlj+Q82Ny/xQjqijhWcccTwywYLxNipb/KE+yXqAcYQ44NgfaT7c2OHsYfaH3nXsD5IPZaDklwhCCkq7DwJ8fX03+3uPqepYAka6iNmstgOpffsytMyWzDDIlXtAvGtNg4OIerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5A/luYT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so48998267b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486161; x=1731090961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UwAATxlpk+S16792LfWJF7rOwrCD8DVw6q+MsAm54QM=;
        b=T5A/luYToY6RzQ9SW6D1lr5sw65OXrPWtsdBJ8HnNWZz2oTbWjf2OizRzAdNgYlOLm
         JSIBHRqVXFyUeY1tSoGS+PO+Bu4+X1PO3ahiNqmKCR5RqjcZ7sc84XEuEWueos2aNhPm
         8UjWBG8oXtC6COStoiJutd0CX23yyOo4DJ87zAm/dJ5bowzwNi5Ty8Yn/hFtqklQInIy
         oTYeKrSzCMzQByWoFIH4CSRrX76oYRKrIziN4C5o+bdXkbWShXpCYyhyo49SN2ZJpbzu
         AhVhuvQp1+mqAYDEUFjNTCFifjXQ6/NZ/PktygCLbqEq8/KmEscluCr03U11smP20FVr
         bivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486161; x=1731090961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwAATxlpk+S16792LfWJF7rOwrCD8DVw6q+MsAm54QM=;
        b=Lzvv42L4fA7qMv2N4WyyFhS/2mM2vrM2IoSvQvxTi+i31/ppJhGorBc987q/tgQ1Mm
         YXg0R8F81DmyeALLZicpXOJez4aPhV1TtGMX5UI7ZRU1N62Fn646onSJnueeAWoCioy3
         UNBsPigIB6AE/eWBG+Vixr8ilFyDrDtXPEdB3AC5LfuAcbOVoljx5MpBAOBNAJ3oTgLY
         /W/mAVKlFMHA2cKgX0zSDhwzwuK2zj8M8S1jRWMUCOpxp1lR/IvBskJKxG3cIgeZko75
         F8YZGy+4HPggoOe42HoYKnOJrR03Z+Ks7sjV5lRAx284AXLukVlD/9ORuoARiaazK4/0
         DTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkRQlLXodPJKeCO9H6ryAcyT4NaCfKt0aPLDM0dEbCMbH9kM64Y6pcV6fVqDcZZV0iHkaHYg5m+IrwlVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyskQVKs+Y3CFt/aX5vIa2j7BrnTQ1LUY0ymmnh8yT/iKHCGLIk
	5bqf+KecCu9I+H6Bj80MieETs4v/8uUvFFh7LCL3C345RL4FGGaoECyslyTdKAUNMxgJZFAXjYi
	tpA==
X-Google-Smtp-Source: AGHT+IGIOQ0uPuaobqh//fSiVB6HaPkTpJ/i3mQUQwamiGOepXC3UO6URBxNFd8cT/8+saz/WWzVM7BUBbA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4c09:b0:6db:b2ed:7625 with SMTP id
 00721157ae682-6ea521c92b4mr298177b3.0.1730486161589; Fri, 01 Nov 2024
 11:36:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:48 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-3-seanjc@google.com>
Subject: [PATCH v2 2/9] KVM: x86: Drop superfluous kvm_lapic_set_base() call
 when setting APIC state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_lapic_set_base() does nothing if the "new" APIC base MSR is
the same as the current value, drop the kvm_lapic_set_base() call in the
KVM_SET_LAPIC flow that passes in the current value, as it too does
nothing.

Note, the purpose of invoking kvm_lapic_set_base() was purely to set
apic->base_address (see commit 5dbc8f3fed0b ("KVM: use kvm_lapic_set_base()
to change apic_base")).  And there is no evidence that explicitly setting
apic->base_address in KVM_SET_LAPIC ever had any functional impact; even
in the original commit 96ad2cc61324 ("KVM: in-kernel LAPIC save and restore
support"), all flows that set apic_base also set apic->base_address to the
same address.  E.g. svm_create_vcpu() did open code a write to apic_base,

	svm->vcpu.apic_base = 0xfee00000 | MSR_IA32_APICBASE_ENABLE;

but it also called kvm_create_lapic() when irqchip_in_kernel() is true.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241009181742.1128779-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8fe63f719254..9f88a49654b0 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3060,7 +3060,6 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 
 	kvm_x86_call(apicv_pre_state_restore)(vcpu);
 
-	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
 	/* set SPIV separately to get count of SW disabled APICs right */
 	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
 
-- 
2.47.0.163.g1226f6d8fa-goog


