Return-Path: <linux-kernel+bounces-440598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34919EC18A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D7C1881DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E219F41B;
	Wed, 11 Dec 2024 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZ6TOzIO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403C1714D7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880792; cv=none; b=knEXGElP+IH91SHvs+cCyQJ7L61YIFDCsa7k1joJFO9acLzBICz28q74qNzHdWHzzk/Open4/6XcMUJmu4uI4eYKmoanuOaQwTj5qEmHAikfvw5ZQBkDgziZP59AiMsal696XWuszmHlm8PEFmXniDmgEkmAPA/VPETrr68F+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880792; c=relaxed/simple;
	bh=MEVW6xDzLLQfv9y9OXgkK6FmeeyEKbPbGZpDIKqPQkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GvKg9MgLDuXe1va62Z7iNRWYnWUSwDJ+5l7ZIgq26PpASzSkAtilH8Y6IcYfrY6Y2EXc8jtgK3WquKjGszwHE3o2qn8aXmxJuCQPeSaQpUmtembko3qqyz6k/8AyInsaWuNIHelyev/exk25w8n3Aqo5uaw2Mesn9z98ahNiURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZ6TOzIO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so3422758a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733880790; x=1734485590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cL3NRVkBfZBJU3o2RWiXYFqfXEQDl3zXojuDagzC/0c=;
        b=IZ6TOzIOQvGBH83BDvXv2u1PeruzxdX5qpwBGsgZ9BAJMrIeXaP87bqxWdmLBX4ZC5
         sCB8xBxLpq70sYr5hINj6hdHHoniCDDJ+zEr80ss/WGvsoe7q8lJdlQjQTBO0NTdgdEU
         k+3W32niR8oDMep3bbPPUWesNATE1QKGEpp3IkCWX2Ts3JoKa5Ze6M0snSj8Wt04v1kc
         fgnW37Di+2pihN8lshttc0GKs37kojvd/FSO4w2Tcwln2iNFUM7Ng7nqqlCWyYOdwaoj
         aHupjFYwz8n8aGtzl7lPUPdA8vOCgGwXGsml5ls30UspEq/JV0Egz9uwrinhwjEYPJF0
         5Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880790; x=1734485590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL3NRVkBfZBJU3o2RWiXYFqfXEQDl3zXojuDagzC/0c=;
        b=uZ0d2nVi/I8/RL9G4wc7SX+7KDpbAezJkn00kk1dwgxjQ3Nfvh7iX0buKmSXHNFOr+
         vTH71Gb5dikb0p0DCs8m+6H9ENOxWiVs2bliCa+SbesCaGLKkFYWj4ntoPLK4w8YNSyY
         WZusRplbhcC3h1LkU03NjKIdno3urnnxDDB5fQaBREXEAY7+9LnKDafsAAmmWKOTLZ4O
         tNsLNKhMoB9UsHgYABFEUpw+n+xmagEZDsUtE+zoI/aJl950uSeLMyUKx8/QRI7KbK/5
         GoJt1OLeDXOIG5iWnKRBSJaTgurWjdHbOXRYLmVfxbnmKIusLpws5lItf7EXZft0nSYv
         ne1A==
X-Forwarded-Encrypted: i=1; AJvYcCULionMKf5o+LXZ7nL/NqN+GuXCgXOBl2GhBbwdfCFFsU3Y1CfuLnJjw52JcfagIrgK7qakW0YkR9p3uek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8+1FKISot2nxXYfGzIxJlMFTu9vBolXbyMd5MK1U1buUq3bx
	NH3zci+Hg2uC05qXToNDUMYR6BsVubtttSHHUAEbx8dhNNMIynVZLv76VZR54ri6ZivOi7SLGN2
	ulg==
X-Google-Smtp-Source: AGHT+IHE/2gxSbX+S+9LU/gh8HaW14iyj5UQ7k4tSNCWmJQgUFrk9t8D9rOA16e9oYsL7aftQDmDCAMD5+A=
X-Received: from pjbqx8.prod.google.com ([2002:a17:90b:3e48:b0:2e2:9021:cf53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e82:b0:2ee:94d1:7a9d
 with SMTP id 98e67ed59e1d1-2f12804a1cdmr1552457a91.32.1733880789942; Tue, 10
 Dec 2024 17:33:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Dec 2024 17:33:00 -0800
In-Reply-To: <20241211013302.1347853-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211013302.1347853-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211013302.1347853-4-seanjc@google.com>
Subject: [PATCH 3/5] KVM: x86: Apply TSX_CTRL_CPUID_CLEAR if and only if the
 vCPU has RTM or HLE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When emulating CPUID, retrieve MSR_IA32_TSX_CTRL.TSX_CTRL_CPUID_CLEAR if
and only if RTM and/or HLE feature bits need to be cleared.  Getting the
MSR value is unnecessary if neither bit is set, and avoiding the lookup
saves ~80 cycles for vCPUs without RTM or HLE.

Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f73af4a98c35..7f5fa6665969 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1998,7 +1998,8 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 		*edx = entry->edx;
 		if (function == 7 && index == 0) {
 			u64 data;
-		        if (!__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
+			if ((*ebx & (feature_bit(RTM) | feature_bit(HLE))) &&
+			    !__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
 			    (data & TSX_CTRL_CPUID_CLEAR))
 				*ebx &= ~(feature_bit(RTM) | feature_bit(HLE));
 		} else if (function == 0x80000007) {
-- 
2.47.0.338.g60cca15819-goog


