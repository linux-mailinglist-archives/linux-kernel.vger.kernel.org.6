Return-Path: <linux-kernel+bounces-257729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C49937E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F41F21F54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAB014A4E1;
	Fri, 19 Jul 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZjBILDz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AED14A0A5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433082; cv=none; b=ZSUHbZhwZissQmGxCsdxL2Tyc5DtuWcqqrfs5lvmLl5KK1rp8/9LjQf996AipxmljRWZvWLqBYTyzG2setpIXL0kXIKQpv18j7DwAJWVD6j75KNozgLKyg8gL1NLGwBfKEmsnV37ceC2hZI21uhCHlH0g7zY4uZBFMAAc/zkqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433082; c=relaxed/simple;
	bh=PPn7G+f4jddXFxEDGFar00uqs+OIt5lJ4PTBlh2FQQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qtmwph1CNoyxd6IPTk6/Wl+Sos2rC59JBP3rOn/6LjYEH9vSfbxQh6GcRLGYJvcoj26HD2aC2guPTFuvQe+cZhLP4dVdOqRJ+7oHqlGB253Hcwilku/YtRV9ZCYRer9hnLkJuSjhVtNnbd/iQabZ+LSwLYX5wsdhrIIJz2/WvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZjBILDz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66619cb2d3eso69476157b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433079; x=1722037879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nPt/EFV+Nq2FbP/DjJ0bFlMBOKC3xPMXdgZnshJlA9c=;
        b=pZjBILDzGMLIzTMk4KSIwXeP5e6nq/sdp4wgqzhrdQd96GqoCjJT23WBQmt8lvNeov
         2MWeQOssg1MaTIuvHFQd+AfWEwl9QF7lD1XQegKSJO7rr8KILs/oznyMWhLKdHeYbWtp
         41N4eeqngBaUh3bNppkfLxf4RfQbjW8FO3faMeR3HobYD+WTXdPYi1CmL2Fey2PvZqCd
         jYAjiRu8Wg66/AXxJ6O/hLI4oatpRyPCDRGMkukNMD4dkVaOz4ZmhxQSVQHSYNU4OtH/
         GX25wdlO5iW5ijvfkr4m4W/zKhFOe/NgqEN5bxoNPFaUEQyN1A04LNlmsC2F5eaV1yI/
         2LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433079; x=1722037879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPt/EFV+Nq2FbP/DjJ0bFlMBOKC3xPMXdgZnshJlA9c=;
        b=uM9BOgXSB1vGmmfshGPbztXjVGcLobGtt39NIgMJyzI6HqF3q92MWGYvyUKjcxOL8E
         108TipYvahjCx6bi71PrBbl1QlVG/aTkrRHKA2FaFokByCgtFfo5c81y5d3muxJt26kP
         eLf0XierN3S1uLrYQm5vzuY4sxDZnqlrvUHI7FiRhvlu6qGQ09IdSyFRDVcjeBpQZDmz
         MGLpJtXt3X9P1KZ+ok8eGymISchu0DCs597z/AHvdTZllJbnviIkLXW2StBFwj0H/lkN
         PITrnAa6hDKVR4KnWa6EX2vB8T/aoU1ligEiYYOOo/7j9dGY4sP6SNPCMJd55wz3NO/W
         N5fw==
X-Forwarded-Encrypted: i=1; AJvYcCUjjypn+jEb9YP8GAPJfjGnq+lu9Azef7R+gn/jpuxmvYTfm+lq8zVu+FhBThmVDNdsfy694cdLAtK3NsbQS+JGOyftbMuHDMmYMNQD
X-Gm-Message-State: AOJu0Yya4ns3dWpBKTQJTXKavUe+KvZ2nFrhqS6ai5O8R50BdRp5gw+X
	+FpEsKTyC9uxGz42H8omEA/KBDah3uOxB9c0dWjUiUY+1GnIow/MDkvMDU+zipoBhtaAph2yRQX
	uRg==
X-Google-Smtp-Source: AGHT+IFZOc2svS1nRDHn9/lIMIWxUAGZrgOUxvS3LRxd2PpdM60KCUus+surZW2V4+iDZWwX226BH+eHTGY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:727:b0:e03:a2f7:72e with SMTP id
 3f1490d57ef6-e086fcb6929mr2828276.0.1721433079385; Fri, 19 Jul 2024 16:51:19
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:51:02 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-6-seanjc@google.com>
Subject: [PATCH v2 05/10] KVM: selftests: Report unhandled exceptions on x86
 as regular guest asserts
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


