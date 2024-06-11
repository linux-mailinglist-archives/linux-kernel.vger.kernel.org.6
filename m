Return-Path: <linux-kernel+bounces-209163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A93902E11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8A11F23D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB66AD2D;
	Tue, 11 Jun 2024 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtl5AVTB"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429F749C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070530; cv=none; b=M016pbpF3LdxRM2fkZorxc4SBEwj6732V9QnajhNRitR0rDFHpipCW/NM0a+V6GVh4Cn90T7EJshx0cUyyipOl/PYz9rlUaQ8O87l1x2nYgWLWbhUrPY5XF6qk4U3BZAG8cmxMwuYv8gdmIb5KPcU41t3kWbRMav0wNbYAM98VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070530; c=relaxed/simple;
	bh=wl+V6pxR8NYQMEO4cSIeFOpU8DdHxYn8iGsc8lsby2c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ksYiwQuCpla4sQkubgGQmnChwG81Hw+rvHkj4gCWB5XQ980xLjUuVfjbiTJ0c4OWMQ9TXwfGx/KMJRPOEdgn3om0ZzAmPDCqiyJlv20OckOm1A2fe8Q/ETN177tKW5JR0w0XW8zjAUrYBsvFRJx0C4D3C9x38gGoVhGL9BloYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtl5AVTB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6658818ad5eso4123981a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718070528; x=1718675328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IujQsYojV/JdU3ox2fNDmOq+JhEUEkoTs1HPTwTybmA=;
        b=dtl5AVTBR0+OsvApgnUoRnRZg6cPTiB7tH7OUKiZUdqmU+mwKnEDsgVfnTMp10Un10
         V75WzA/LQnx7tQqucPLW/ghEmzNlGN4D9CQt07399FwbZRWj5c3FUCH1cRa7Cs2VxjaM
         ZpqH92q6XhkkDbP4K9/82VxtzFLdY6nBM3pbQqWXvKsMyiAQfR4ALNWx5+9gZnUv2GLe
         Ahf+WUI6Fy685Gr6PT1M0MTUIOUr+r+Hu4uT5jJYu9dEqj93JwIcm7Zs1+2dq1W6SXgB
         KqCqc76Zalthn3oFybjP2CqjUaty22mg9I+EPHTJdbfdillDb35FGMk6llD6XkgBaljh
         5v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718070528; x=1718675328;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IujQsYojV/JdU3ox2fNDmOq+JhEUEkoTs1HPTwTybmA=;
        b=sT9bCRJhjU2mq0HqPnhRxuMkyJQuHW8rS86lc8BmWjjwK3DCw7NTfPZ1w1sqFNRR5n
         9DxU6OBBVlDVvzT5M0mFqHIBzKP3i/AwLZ6I5F/kptYFX7Y1TleAd0zSlaPIboKRQ9ym
         Z1QDhcgMBetPUZUBhJuGqI7nBJPzH3TTz62ERV+0r0TOxRVeLGOrUTJRWKALA3jxH42s
         Vqa9eStPf79r5aRPIqwGPbdpK2R7F4afPU5Zei3mrduPTtl06VUrlyHw9Ysl3cAAFQV4
         Ed7oLIOyu3EGuiEKxdem+XaetoSIUdC1IhF/RkNNWwgD5J/AQ4BoC1CroERP+7tZxFA0
         No0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7b67+GXXtQT2DFo+UggR4D2oRnGotumzFKwkAlgbdC1S0sLoNO1EqH0Yy3WjvtY6EmkheN+G+pLt6QHWcpNXKEeVXdNTPFBdDTU+O
X-Gm-Message-State: AOJu0YwZkoaIPAOCNJ1kaLG4sDC7jPq1zbqjjDqVNjK70WLZbdPGCeOh
	lPGqgHeIyzumlcZJLVLxappgwWvW9F0E2c3s9t3HnGflg/hIwNrVjQ+/lTJMIBVYVj/wPjHWhEv
	2PQ==
X-Google-Smtp-Source: AGHT+IFjnsXaXaCah0afjleJHFBmdlDr4s6g7i3DVWeWFHIpMsaJO+Kb4zX4oCIquO7XtZI3OHT+chZpglI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3f82:0:b0:6e5:1191:1900 with SMTP id
 41be03b00d2f7-6e511beeee7mr21262a12.2.1718070528145; Mon, 10 Jun 2024
 18:48:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Jun 2024 18:48:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611014845.82795-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adamos Ttofari <attofari@amazon.de>, Raghavendra Rao Ananta <rananta@google.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync pending posted interrupts to the IRR prior to re-scanning I/O APIC
routes, irrespective of whether the I/O APIC is emulated by userspace or
by KVM.  If a level-triggered interrupt routed through the I/O APIC is
pending or in-service for a vCPU, KVM needs to intercept EOIs on said
vCPU even if the vCPU isn't the destination for the new routing, e.g. if
servicing an interrupt using the old routing races with I/O APIC
reconfiguration.

Commit fceb3a36c29a ("KVM: x86: ioapic: Fix level-triggered EOI and
userspace I/OAPIC reconfigure race") fixed the common cases, but
kvm_apic_pending_eoi() only checks if an interrupt is in the local
APIC's IRR or ISR, i.e. misses the uncommon case where an interrupt is
pending in the PIR.

Failure to intercept EOI can manifest as guest hangs with Windows 11 if
the guest uses the RTC as its timekeeping source, e.g. if the VMM doesn't
expose a more modern form of time to the guest.

Cc: stable@vger.kernel.org
Cc: Adamos Ttofari <attofari@amazon.de>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4157602c964e..f2322af38242 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10736,13 +10736,12 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 
 	bitmap_zero(vcpu->arch.ioapic_handled_vectors, 256);
 
+	static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+
 	if (irqchip_split(vcpu->kvm))
 		kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
-	else {
-		static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
-		if (ioapic_in_kernel(vcpu->kvm))
-			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
-	}
+	else if (ioapic_in_kernel(vcpu->kvm))
+		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 
 	if (is_guest_mode(vcpu))
 		vcpu->arch.load_eoi_exitmap_pending = true;

base-commit: af0903ab52ee6d6f0f63af67fa73d5eb00f79b9a
-- 
2.45.2.505.gda0bf45e8d-goog


