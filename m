Return-Path: <linux-kernel+bounces-395741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943729BC247
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE851C2198D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE351E868;
	Tue,  5 Nov 2024 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfbKMEEW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C018622
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768776; cv=none; b=qC2jKsBmOK4Xji5xYCK/F/WGfkLLYys9JSnPMRyeLcSDY8Rci5lCBd97mysTsiXXxYqDS3oatrjrWdEDq2eI+Xmfkjsi9YDuzdJa9ptqLUfjBBemW4YBX9EyDz2wOVmhrlzdLxId4fpjWw1lZDXrDbIRgUh9EUZp/GRtQc3MPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768776; c=relaxed/simple;
	bh=Kzdi0RzTuVT4R4Dg9LFcvCPoh0zzneOm7NKP09EYwSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dm75CJmwKyxhOn+jFuVdD3MBZfrFQP+f2DpSkyzUNZaep+PNvmYuWMnNu9s5YejycI6xgjukuI3geVqCDFVuSHTjmWIPxCAjCK5y7WpF/NBEqs/TkcdnPw1bwT/F/DJdJOlB7OiWlNb+9vaXN3zaVxKhSmcYu9oLqm4TN76EtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfbKMEEW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30ceaa5feeso8530997276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730768773; x=1731373573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpDF7a5A3aTccPubMOlN8ORp4a2Anb2LX7mvFNgWFxg=;
        b=EfbKMEEWcow6Jvv5mrxOBXcLAZ6aoaGeoGn+baLceRIAlgpoXYGT8AGglxvq+IPePy
         WmsrVJBak1eLT0yO87SntPZ7GFbb94c9S313Jx9zr9bqq/Hfg1OSFOnSGyLhf+AeT1uj
         SnxnrtDgKa0ffH0lH3qqGSC1PZXEV3JwzsDD+UlO54XwhlgRXNKT8ACcmQ4fPJVSSN5r
         j2ypsf/upID7pMiezDWBfqK/mCNVPtKsQCN+f/Bze1JhWd++tnMlaxAThGNz27JqG+zi
         7apyfTXQfWV1qTFuz4ZyV7kUBwjyKHciyzymtFQout1+t5wpO0V/HtIvKIRREdpGoqGB
         at8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730768773; x=1731373573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpDF7a5A3aTccPubMOlN8ORp4a2Anb2LX7mvFNgWFxg=;
        b=KAAXE0MieCDtj67/UA2z4rV8i446oQU0Gh8U51ChKDwpQgMcdOlyOyB9MSOmTZyI3H
         15ftcHMSOF5eZkmV2J0Oa/t15E2xI4MPFFEnSxqZxQnjwHNu+mJ5lk/6RgnpG8iGgrO6
         eXQq68xI/ua+TXBfuVvcpTqcgopPbuPJ929Zez/MBUjWMj1fbJZG2LpqquKzHWtCuxxF
         JYItCzWklmAsQvfEpJSiiGicN6cv+tEYLPs/HvkISJ+V1a95uVJnu7lduL+5++5qWZ9s
         5neB2yawL2kXheTWgPTDkxpkhTFVu4ngZMZUOA7PbnuI2Q2AyhfBEQEXoUOqIhfuuNep
         XkZw==
X-Forwarded-Encrypted: i=1; AJvYcCUK5i5u85wEaHmxYtZ+8v/x+laQHiiWdAfKG+ZGgqvSaoNBCZ+sVmQ+OJxDRTxRkrBAquyve4LWGz6mxkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuPtk2lDXCVj6JdW5BJEMGQDg+w07u0UXWnJLJVc89UNwiILG
	N02PBoAGXGIW4v5nO3RkkqlePE37xDb/JXhQX08fkEQGL5V/BbVHmgtoL35rA44MJYlJeRIJcVt
	o85aNbMN3pS/uwygiYiXbbg==
X-Google-Smtp-Source: AGHT+IEQ3QoZttD5CvPaZEByw/wYbzenHWOgazcrDI8nLp1Wph7OSasa8It4OvkgM6y0uzeLKTxOeD9HcmMY9/BBsA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a25:d695:0:b0:e2b:d28f:bf28 with SMTP
 id 3f1490d57ef6-e3302537c7dmr18862276.2.1730768772981; Mon, 04 Nov 2024
 17:06:12 -0800 (PST)
Date: Tue,  5 Nov 2024 01:05:48 +0000
In-Reply-To: <20241105010558.1266699-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105010558.1266699-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105010558.1266699-2-dionnaglaze@google.com>
Subject: [PATCH v4 1/6] kvm: svm: Fix gctx page leak on invalid inputs
From: Dionna Glaze <dionnaglaze@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure that snp gctx page allocation is adequately deallocated on
failure during snp_launch_start.

Fixes: 136d8bc931c8 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_START command")

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 714c517dd4b72..f6e96ec0a5caa 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2212,10 +2212,6 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (sev->snp_context)
 		return -EINVAL;
 
-	sev->snp_context = snp_context_create(kvm, argp);
-	if (!sev->snp_context)
-		return -ENOTTY;
-
 	if (params.flags)
 		return -EINVAL;
 
@@ -2230,6 +2226,10 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (params.policy & SNP_POLICY_MASK_SINGLE_SOCKET)
 		return -EINVAL;
 
+	sev->snp_context = snp_context_create(kvm, argp);
+	if (!sev->snp_context)
+		return -ENOTTY;
+
 	start.gctx_paddr = __psp_pa(sev->snp_context);
 	start.policy = params.policy;
 	memcpy(start.gosvw, params.gosvw, sizeof(params.gosvw));
-- 
2.47.0.199.ga7371fff76-goog


