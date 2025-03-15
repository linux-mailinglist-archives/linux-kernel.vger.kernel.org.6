Return-Path: <linux-kernel+bounces-562383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF25A6251C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD71B17F01A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA941195980;
	Sat, 15 Mar 2025 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNe9Xnby"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49601917D4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007999; cv=none; b=M4pjlyu3950BSvaOjUTTwZzvA5V+u3IYkeDXARAJoumcGVe4ZqxEexl1ac7SjynCdV6dNssKIkwWop9lZqEb3lcPWk0xRIKww4RnLbEm+kLwEoVc2wzXEatRHc8Yb/DnAGAKTOag54DbGEYc4oWTbc72XxdNlPUZ4mpoKRsAUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007999; c=relaxed/simple;
	bh=3oNkXBgr8EIWda3cEEvkfRlryoj/MBVyRM1tKseboAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XPOS3KIJ/IMGFb9j/FQ45U0pf5I1+H075szp6ZcOAjIAP/EroXxHdo6E8a9cRQmTqt9gBOYA7oVr1VmS+4cs7wmpuLsZ48iULuHQhXi1vgGB6VMWEogarI5a1/SPp9Oy7fxxHUBweB+5HgQSQ3VYxlU269y7JqKp6nsGJK4/zIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNe9Xnby; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3011cfa31f6so482463a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007997; x=1742612797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+rGaV7EYztjwjHpumFCPp4cbhOrFaDcpQIEQlQEwrkg=;
        b=DNe9XnbyHkEO2O9917aoGeXFKUsA0CwhCFQts+2Z6d16hTD0cDo2z+tcdm3vi6pGRA
         mSGxOg1adjI3cwv98CcSuEaL5G0xzWwlGXooeAmp/Kie0SsGcV2w2Iys7hSBy4sErbd1
         kI6ZiY2Auut6Ljo+4KkQO/n7p33prOYE5h+XYJ+PeN1bgpZn4fCCAzCF5ELhN+n9qICp
         lTT6vYBM/dXcCUfjbY8C223SFc3P9ddVos8YA+9jYVDjbaIKLpXDUo3NcrIvF/s9Bjx4
         x6dU9nfkSvIzLt/dsUvWRJP2mFBMeuEKxPZMmW9k/OhNTYXaiU/bwxCdGAOL4dnOSqDq
         5Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007997; x=1742612797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rGaV7EYztjwjHpumFCPp4cbhOrFaDcpQIEQlQEwrkg=;
        b=D2X/jlDmy3bsskvoGkU0dqLpRat5WEiI8ZxEpKZtx4dRJokTJtDFQ0mBT/dcnPr316
         6pWXAYny0QMFvSXEeVUpkdi/8cbMenTFCjbLMST/bMBOj8g5Deafx69Athy/ASlC6nQn
         OxraUzaeDrPodPx6qo7fdar2kxRJpxaA9cSYqOJ/E7KSPomk7AP+UmRXZzKjj7NIoBbz
         IiVY4b/p5SEbFX7g6xkTdUEQ+t3Zd4lnk0uoAWJkaLsTFFtnRg0APgki1WHWEqnaI9ab
         Z3Fz0qcOJACkfnHopmft+aMXUdVSCbT1ccdtob3eSVD959BuQINVy6Dl8gwZ7psjIBSN
         JKoA==
X-Gm-Message-State: AOJu0YwYoqpLGo5YZT8vqJCBQOoApQ8New1ZS9dHBFjWx3nu2qpu/cd/
	WSmyyEe1oyXKnuAA0fKNY9ddRtSTSVU7L6jqlOk8xVsne/WTFgRTpovTot9NYj3nsHDL3lMgjWZ
	/Gw==
X-Google-Smtp-Source: AGHT+IHToyeqUaA2FjyTnWkl7XfPw0+f99lKhBPLNQjpZdYLGzY/BKFwEs/MhlWIFqJRpb5ryLcdl7TDFNM=
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:2ee:4b69:50e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec3:b0:2ee:d7d3:3019
 with SMTP id 98e67ed59e1d1-30151c7a384mr7020001a91.12.1742007997207; Fri, 14
 Mar 2025 20:06:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:06:24 -0700
In-Reply-To: <20250315030630.2371712-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315030630.2371712-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315030630.2371712-4-seanjc@google.com>
Subject: [PATCH 3/8] KVM: VMX: Ensure vIRR isn't reloaded at odd times when
 sync'ing PIR
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Read each vIRR exactly once when shuffling IRQs from the PIR to the vAPIC
to ensure getting the highest priority IRQ from the chunk doesn't reload
from the vIRR.  In practice, a reload is functionally benign as vcpu->mutex
is held and so IRQs can be consumed, i.e. new IRQs can appear, but existing
IRQs can't disappear.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9dbc0f5d9865..cb4aeab914eb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -667,7 +667,7 @@ bool __kvm_apic_update_irr(u32 *pir, void *regs, int *max_irr)
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
 		u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);
 
-		irr_val = *p_irr;
+		irr_val = READ_ONCE(*p_irr);
 		pir_val = READ_ONCE(pir[i]);
 
 		if (pir_val) {
-- 
2.49.0.rc1.451.g8f38331e32-goog


