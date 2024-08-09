Return-Path: <linux-kernel+bounces-281438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FC94D6F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE18A287C05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219A19D88C;
	Fri,  9 Aug 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhJNpf1j"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1B19D075
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230245; cv=none; b=HTXKA+tSY+G+9kO8kX+jUlZuPFgt24V3JK4E6UEUuK3Z0DcftMy4ny45rDrxBMCeBC22/S7RWCAnj1yynTMc4jd0rRNtyyFBSdfleoZU+BfJ9D+15qAb1G0BU0khMp5An72K5W2vtpo75O8n15Lt+UPI0lG2S0YiYDVMw9F3zBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230245; c=relaxed/simple;
	bh=rL3+IDQm11patEvsiloUsWqSDQCzY8fDc8KY40xXf1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EFBUA5fauM2yaEnSkPxljd+9EU3n773p9EyS9cPQNcq3F04YpAFW90WcsSShEI00S4k1yjy+r5jlfr4n2T7ey2knOYgV387sAqdlcGK72Ga/vekcRJNZ2fA8CjZrMoBoEiZcY/kGNMDLM9pFICzF0Q06FvqaQC5cVbBduqk+77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhJNpf1j; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-710ca162162so2116674b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230244; x=1723835044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zAoc9f/zQ674f2x3bQLKg9kULz1L+f8jr5RFvkl+QSU=;
        b=xhJNpf1jG8biD/CMsNeOEXm7qfDsq4e/aYc/J8CAoTWqbDccKWylPufMFLRY3K8Gef
         Rqgfmci2qygfNkSXmMAIx1vhDHXmJAFrP0WdGVHdYPeKFfhaKXpjyaInpTgPFTwBGrqN
         PnQ3Z89L46S1KSp3dq0Sg/x5Osi32fys2jhg6YAgs/SGFnP8QivF7U9zVukzeMT5xCBZ
         FgooekYw9Zzlfy+8E99vRavo67yKUpuRPC+kXZOhVSK/7v5s+VHVXBr2E4kfbauCgL2w
         czSsWCj/dV7jpbkEILqadRrvS7S7iFUbQvsAKKCXXwl3DKQfRfT30fXdQ3r8qzTp/fch
         BqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230244; x=1723835044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAoc9f/zQ674f2x3bQLKg9kULz1L+f8jr5RFvkl+QSU=;
        b=We64LNBY7xA+wNPQoyLVDhfmIpcAM1PmdMRCIEz9Oqp6dMjxowZQuaVQ//xplpLndK
         JUU8bTxNWAKYLE+d6n2EPWQcjqmpV92leEApjkN3X1b2SbE0eWdLahjTcTVfUBk1Oeow
         DH44hyM/QRyOt2dmvhNt3J7uS9TRXsk35FF08kIMEdHN0hcbv/byR/OTUoUjz9M0CdRD
         V46bCeFwabkfETyL4yR9/RI0zyfDrghF4F0aZUDZ04qvuGIKylIQxgjIIdQYS85IQFxV
         p16d9ejsztb3xdyhbl9nRrXNtiBLq6V9pv1l4/dR7B1NPRknAAUnMT9FRD7ftfoyXTfM
         bg0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIu6O9l8QKqt4SAFP3qdZ00RLEhjhui+Wycg6enVsXYE8Ry/5H1fb1VfSD7jljmaCjQSIvyE2vaM/HFu8Lx80kCktoeQITgQw0SI0O
X-Gm-Message-State: AOJu0YyszZRlMKnMYsKTEBhYCMPAzWkLF8Cwq7sbuIWwtvgoISrFUVko
	LTrh6u949Iu1CUPgmvysQRbmXwIkMCpTp7iFf4bcrUvPKax+gcu4GNdTE5AfjiTLNTox/j7GI3G
	DBA==
X-Google-Smtp-Source: AGHT+IFWWDSkqm0UJUbqcujAzmPwVvL+hZvhhLf0wMFFrRq4oNl8ycj37ldJXO+dIolxfhHFVUMfScjgue4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9158:b0:710:4d39:c8f9 with SMTP id
 d2e1a72fcca58-710dcb62de8mr26720b3a.6.1723230243593; Fri, 09 Aug 2024
 12:04:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:17 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-21-seanjc@google.com>
Subject: [PATCH 20/22] KVM: x86: Rename reexecute_instruction()=>kvm_unprotect_and_retry_on_failure()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename reexecute_instruction() to kvm_unprotect_and_retry_on_failure() to
make the intent and purpose of the helper much more obvious.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 65531768bb1e..2f4bb5028226 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8863,8 +8863,9 @@ static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 	return 1;
 }
 
-static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-				  int emulation_type)
+static bool kvm_unprotect_and_retry_on_failure(struct kvm_vcpu *vcpu,
+					       gpa_t cr2_or_gpa,
+					       int emulation_type)
 {
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
 		return false;
@@ -9131,8 +9132,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				kvm_queue_exception(vcpu, UD_VECTOR);
 				return 1;
 			}
-			if (reexecute_instruction(vcpu, cr2_or_gpa,
-						  emulation_type))
+			if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
+							       emulation_type))
 				return 1;
 
 			if (ctxt->have_exception &&
@@ -9218,7 +9219,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		return 1;
 
 	if (r == EMULATION_FAILED) {
-		if (reexecute_instruction(vcpu, cr2_or_gpa, emulation_type))
+		if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
+						       emulation_type))
 			return 1;
 
 		return handle_emulation_failure(vcpu, emulation_type);
-- 
2.46.0.76.ge559c4bf1a-goog


