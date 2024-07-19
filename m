Return-Path: <linux-kernel+bounces-257718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A42937E16
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3061C211C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1709314A4DD;
	Fri, 19 Jul 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Vq3fpFf"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C79148844
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432640; cv=none; b=CqOzYNFsdaqYjXeK3D013/myZhk/Wtc3qTuA/ql1e4dLdv0tO018ufuKFea9Ep3QSCkezaGuZewmmWaOhA9YODCpqZO7W0ZCQnkgnQON0gx7no/QUX6SlM3g4yqIZMmEBSoZdjrBQepR6MqpY9Xc6PVuZ8j4H04Nl3eJ1fREfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432640; c=relaxed/simple;
	bh=PPn7G+f4jddXFxEDGFar00uqs+OIt5lJ4PTBlh2FQQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TB139tiwqSKbNXG1McyzxmWrPngLI+K7e49zDpcjSQyVFP7V0Elob/qE+EGfV8SXCbQqeG94e5QaixmIUB6LYRWBoqAGjCe9uhS3iQHhdZyj12SqwmFZTsoH11CTyLFeFv5LcWeVpHQUMvZvbGmfsRTLFZReJmdX/VcACWCAyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Vq3fpFf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70af548db1eso1540557b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432638; x=1722037438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nPt/EFV+Nq2FbP/DjJ0bFlMBOKC3xPMXdgZnshJlA9c=;
        b=3Vq3fpFfznOlU1PmOXKDg2z39TyQyHZf9wYfhsx1zuLWJcaUMGN33VlX40g+DSYnnc
         wul05y62UHZoao/I1r6FAIBNtEDOQAABOrq1+djwvsWpE8kSU55ZL+NaDZxV3k+HZh0U
         MabqoUJLcTZ0WskElfDW5SlrJ07bkVVSJxMiOxPHmMRTqizMjQs4Y7T/Ej++VKOp7aVB
         IkJyGJNY1PCtKTHkRKkC+jAa+3/JY3EBVSBVFdIQDzgoqKh2x2g1wl2iSa4+qJIOdKkK
         Kgqb7Fd2YZM1XX/ePz6Wcbl8bokbGLJd18u7c40jcDyei6Uk6NwAyTZL7oPouTBREXRN
         +1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432638; x=1722037438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPt/EFV+Nq2FbP/DjJ0bFlMBOKC3xPMXdgZnshJlA9c=;
        b=xAbfrCIYhRprB6pPq2gxvnSSUdl0umhwjNPOXsC5B2AXrotYT0Alnm9R3wXzqfGWRp
         DM7Qfiih0XdXIMMRB0Er6x6827iDCXS19EAR4sM9zqZCfsfpeK6mWvLy136RCDXPFvjs
         fxCFxbfG1BRHV9sKG68nkY97RBLSVAl3ZLHIw2jx2NI7r3FGjY0QoC3MfOMoJuYGpVpa
         5RCNzl7TiyZDLsKeKA/6GpazpV3gsCVtZc28GwjaeMvhqWtUFD3eOwsuoGh78/InhgKR
         v0q5jAhVkPP4K4w/9/nUBqlpJNSf3A/432nu8TfCuD48FqSAhYrCrq14nVgQB1l1xlq9
         JAAA==
X-Forwarded-Encrypted: i=1; AJvYcCXFK+j+Is4gYJUZrtwds688fVHWsT5VaIozvmlC862mdvsnzX/l5Im8Z7/zdlK4AcRNQsPBulsycYOyBUYWEACf+MuFSzeIH4DApQbm
X-Gm-Message-State: AOJu0Yxy89/rvIEnl1+32J4MTwwqUll+G+yMJePCoTNEoJBAouiIO1Nx
	DRve9IIPlWOQsdXgt5iq3vj7UAQSrJXvToQyTk/qaqP4cPaL2vJn2xnvg1/B8SIhjjInfCgmTcA
	oeg==
X-Google-Smtp-Source: AGHT+IH0kpH/UFJ9YnQJ29R7jW5YI6r3QaHGi0uazNzGckCKBUeuNmJ/e1teSmk32abSP1lzY/T/0UsK7vk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1314:b0:706:3433:bf21 with SMTP id
 d2e1a72fcca58-70cfd58f8f9mr47559b3a.3.1721432638145; Fri, 19 Jul 2024
 16:43:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:43:42 -0700
In-Reply-To: <20240719234346.3020464-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719234346.3020464-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719234346.3020464-6-seanjc@google.com>
Subject: [PATCH 5/8] KVM: selftests: Report unhandled exceptions on x86 as
 regular guest asserts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Now that selftests support printf() in the guest, report unexpected
exceptions via the regular assertion framework.  Exceptions were special
cased purely to provide a better error message.  Convert only x86 for now,
as it's low-hanging fruit (already formats the assertion in the guest),
and converting x86 will allow adding asserts in x86 library code without
needing to update multiple tests.

Once all other architectures are converted, this will allow moving the
reporting to common code, which will in turn allow adding asserts in
common library code, and will also allow removing UCALL_UNHANDLED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 153739f2e201..814a604c0891 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -566,10 +566,8 @@ void route_exception(struct ex_regs *regs)
 	if (kvm_fixup_exception(regs))
 		return;
 
-	ucall_assert(UCALL_UNHANDLED,
-		     "Unhandled exception in guest", __FILE__, __LINE__,
-		     "Unhandled exception '0x%lx' at guest RIP '0x%lx'",
-		     regs->vector, regs->rip);
+	GUEST_FAIL("Unhandled exception '0x%lx' at guest RIP '0x%lx'",
+		   regs->vector, regs->rip);
 }
 
 static void vm_init_descriptor_tables(struct kvm_vm *vm)
@@ -611,7 +609,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED)
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
 		REPORT_GUEST_ASSERT(uc);
 }
 
-- 
2.45.2.1089.g2a221341d9-goog


