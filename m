Return-Path: <linux-kernel+bounces-392697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8599B9733
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AE21C21E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FD1CEAC2;
	Fri,  1 Nov 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhPIakyU"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC71C9DFA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484949; cv=none; b=MDNEc16KegcQpqZfWMeIjs8dt/0epsDDLrqL4fr9vH0vJeBXOjSoBE3FneJqHODJal6lQxZUnGMY8TJf9zbzBQS3wFB28MlAJX+gwdLPXdFpoyAKWqJm9tUwIrdFlSlSsF9PJxUzJqdgqCpC2okT15AnZVgobXNIePSp7qBX/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484949; c=relaxed/simple;
	bh=FW8JHk3YGfbCYGtZ3Mzk1ogv3Mmj+0IgvWXC0ldYUQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pgL1wpUmSS4/Y2LLDskYac59SWCxZVIzS9AR6XQAGFV/ULvKML+IK9Oe+7AR8KXCCCrBdT3pgxcJWDvLAtc/YKmWT7QpKTnz5TF4y66O6+16HUds8j1ENhXPuJf4EqjYJzNBYwSH0EAXnLdvDqigdIHOQpli01GVkstKdW5xQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhPIakyU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2ed2230fcso2694408a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730484948; x=1731089748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2bdkQ9H/fP+Nu98WcPEJqY3qMdHmveh6b6/XkHLIus=;
        b=DhPIakyU+PGljn1IYsHRJVHApfz5j7W8fLttrF7UCdH7rPJezxDMskrTzm1OFfjINW
         NSqzlasgKXkhEvKZ7HuwuENlL/+1CbRpU0CMrIdsuyoz64WYdmZN/Le1jL5MvCls4aaU
         bjhZvi2n1vz93RzxOg8fLCbN87wyJ6u/gVv1AuDqRFfsehrDq+lWTzArpYJrBtl6XWW7
         OgAn7PDdxc3aX36wfNudo1AL6ipuB1pj7KYKcJfuN3E20J5pdyg53kbYqNDpxkfT1SPS
         9aKwI26xrSAOBlg32C26DMzY7vEYFZiA3KS04TrYMCyWQ7jT7wDJqlKdF14fCUoKEO/K
         fb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484948; x=1731089748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2bdkQ9H/fP+Nu98WcPEJqY3qMdHmveh6b6/XkHLIus=;
        b=ljLlu6GCYDMIt9yjf9jVpF+V8felhDbdso+A45EL05YMOkEl+gtpz95ntEF5hMd9UT
         QcBVN5oJMu4EcheyqAZNAcTdTHqhbrUJzOLXfXqS8+UrKuyRmlDA9Sg/UDhke3NcPuQR
         SmxByjCQuU3OUbcWFA2aoE/TOaSVWGIFwBZvN6ZMtMBFEE4tDz/CfPExdqxlMu/mMTbl
         O47Owo8MtpoC0lomI7ZAgahZa0Et3lq+mEw0AYXEpIM1PQBrkcD+1QabrghuGAeCLnxu
         M3rDwuCfG7qYwcCSP3D07ugUAaLaNGjFpW95vUTLqJf2PV9hF6iv2L6ODFgt4xHbzb6s
         rdqA==
X-Gm-Message-State: AOJu0Yz9XoirMV0psTK16ljCtuFA/Mfi52t+al5mP5d5xyHYbQdLDy0l
	L7POgXntDaAXAgBZ28eXRkphAWRvKHFJYKREtM/u0cjehIAfAIFd4fSGLq7XVhZ58JZ0jjjToAx
	x+btBjRqOu1C5oGCt2s9IL/CBVPFXx4KZcKnqnwrt8bf++Ru0s0hBbULUYmmr57GqaCtsikyGYQ
	qY8TLdZIYWXDZAx0kXyWBGChhGGhdP1HJhoNXoLk5tk2u/d5q4qtOlTdnYz4D1Qqvhx2U=
X-Google-Smtp-Source: AGHT+IFlwPuf/K5AJA0znbtgKqO2qjyZICURRqpIPVlJ0DxEHxgaCJsPPCi1KIaDOmrvJ9kcdz+yRyVUuPdSr5nT+g==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:62c5:b0:2e2:bad0:926e with
 SMTP id 98e67ed59e1d1-2e93c1c9adamr28528a91.4.1730484946570; Fri, 01 Nov 2024
 11:15:46 -0700 (PDT)
Date: Fri,  1 Nov 2024 18:15:26 +0000
In-Reply-To: <20241101181533.1976040-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101181533.1976040-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101181533.1976040-2-dionnaglaze@google.com>
Subject: [PATCH v2 1/4] kvm: svm: Fix gctx page leak on invalid inputs
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
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
	Tianfei zhang <tianfei.zhang@intel.com>, kvm@vger.kernel.org
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
2.47.0.163.g1226f6d8fa-goog


