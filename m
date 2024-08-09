Return-Path: <linux-kernel+bounces-281424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4A94D6D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A071F2229E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362A194089;
	Fri,  9 Aug 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsE49SMl"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3E16B751
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230220; cv=none; b=HukfvXqkWtMxYXOaqQxmw5+syU+ghJC8gWPl+d5Xn9AerOdePdrbIfm8q8CB4+fUgOQdaA+ISIZwJPYdY6mybJGhT3K8gLEK0zE0m7vKI25juWgWFqFaIyPAI74ke7KWajk1ImBrozSeSXff+5IUUMI5aIspZ3PDVcS1Qr8wspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230220; c=relaxed/simple;
	bh=21Oqbef94jP18zcmD++heqnas/lAgBbqRkP0cSKsWBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S84kbQhJdnWWCbbhA0fCVyd3l4DurMRAhONYTpR41Zz6lNIbIwj5P4/usKZ4+AZQYaOoLCNwj3pPcg+VZBuCpESYCg4nkHhlSVrKMAG0JRVntBGl1Xsj0+oBnCoMJaeaM0kkrfjJX3zC6GwFf4YozIuudSLfYei7nkXWPFxk4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsE49SMl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fee7c9e4a4so21209975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230218; x=1723835018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PEo03FT/iIpJNEkcG69iehsrgcwll+jefs5K49ylrzM=;
        b=CsE49SMlL7nWanmZvTPdH6LvkdOzHU26mJ5JlEsfPgTJXu4AOFYZkq10s7hO9mqG8t
         RZQrWRqY3nsHSzXneNzBfQ0u3xcvtJ9RyFQqyJj6jjEYc4/kz+6OWhVPavppyppxA1BM
         83yvDojTNxcGyAb522UrBuMO61CDyUBTzNY6ZFAXPYBp201pErBD+5GpLZjqPjuq2+/r
         5pepx/FKt4oO3OKQgjf3wVaOzKdY/QaR89mIKFcxRhfm2210RHEGRZYLiL6ft8V6+YiN
         qy1w3BTkPXxlIva1y+4yCGX5vnB9xQL7HsnV5cMaWzjSH0155izC4OklzaOXC5d/ex2t
         uHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230218; x=1723835018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEo03FT/iIpJNEkcG69iehsrgcwll+jefs5K49ylrzM=;
        b=VEEpJ2Sb1wLsRZQ7VT004w0u3fb2XVRZbmWTtaCOnp7q6V926MErM5tqC0v4jaNsqi
         NS2YuiFKQX7ODQ71dYosEIYaAt4mHSXFU+NOl53lM3qwUgFgGVG/KGwgWYx/+WhQjKmj
         r+yJjHy5jVswsfdw4sTliZcmcOPw0PGU7j3NEttV9PQl56tqGJTGstr/XO/z2fZ9ScWR
         s1176J9AGj55ywGdtNCNX7ImBkiSQsmKdoJ60EZw92UaYhHGQNPyhfjTAkGas9HUUtuV
         ICfhLBQmBS+zU0ID0oK1wugu5DIjsb2gSWiLr8VamQHcAskZY/SSpHok//TSeK2L7jp/
         6tXw==
X-Forwarded-Encrypted: i=1; AJvYcCWuN7n5w8dbsATAD/YpVkVbYySlsIeEzyBB54xZzQOmgrmPhHGFfYx5StYQBfSHFUkt98OfG6yJnYbe8xTm62uzLIriNRsxGMxB91Wl
X-Gm-Message-State: AOJu0YyqwsstDQbjO5/FwLXJFTSaK5Nt1aoPLQPGPEdLaM4VlYEGfAtV
	xj2KIVGVZACIgi0Qd1F9dSGx/Zchjv0XsvIRhlN+f3uJ5HTr3iw7jMIgnjrE5ft3lLI4dF/Y5dt
	GkA==
X-Google-Smtp-Source: AGHT+IH5LOjJ12m73lV027giJooc8yKy5h6vOUlHboXG6c+B/Zn9yoHT1SD7ZeiYbKu/63dWHfYsnexMC/M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e74b:b0:1f7:3e75:20cf with SMTP id
 d9443c01a7336-200ae5cb75amr1696075ad.8.1723230217981; Fri, 09 Aug 2024
 12:03:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:03 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-7-seanjc@google.com>
Subject: [PATCH 06/22] KVM: x86: Get RIP from vCPU state when storing it to last_retry_eip
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Read RIP from vCPU state instead of pulling it from the emulation context
when filling last_retry_eip, which is part of the anti-infinite-loop
protection used when unprotecting and retrying instructions that hit a
write-protected gfn.

This will allow reusing the anti-infinite-loop protection in flows that
never make it into the emulator.

This is a glorified nop as ctxt->eip is set to kvm_rip_read() in
init_emulate_ctxt(), and EMULTYPE_PF emulation is mutually exclusive with
EMULTYPE_NO_DECODE and EMULTYPE_SKIP, i.e. always goes through
x86_decode_emulated_instruction() and hasn't advanced ctxt->eip (yet).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2072cceac68f..372ed3842732 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8973,7 +8973,7 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
 	if (!kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa)))
 		return false;
 
-	vcpu->arch.last_retry_eip = ctxt->eip;
+	vcpu->arch.last_retry_eip = kvm_rip_read(vcpu);
 	vcpu->arch.last_retry_addr = cr2_or_gpa;
 	return true;
 }
-- 
2.46.0.76.ge559c4bf1a-goog


