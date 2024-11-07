Return-Path: <linux-kernel+bounces-400786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D69C1267
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5FE1F237C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819F521A4AD;
	Thu,  7 Nov 2024 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3U/bDQ40"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF52194BB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022127; cv=none; b=IDAN7OVMSZb5/PQOsbBasFGefKdgjtDFCP0AYb4KJBmBrFNKau9Tj/3UJr8/vocxfmtrdkYqr8QQbXbQ+JPksA3BbYLJlTRbu3tr2F1n8MwU3C73bTuyKYIpyx7bZq6e/ofwpxGx4If8RbF99OxIGvgDZXeajAPQ+UGjMMkBcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022127; c=relaxed/simple;
	bh=Jb7bsAHuq1g+F+AyFt83enXaiVLr1zlWcNhrBiuDpbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T95bTDWsg1sfwqYY4y46zDWKAz+BnxbwH0lsJ2RkCFjCQRadPHs6+zqw+MyJ6d6BYK9/R4UgEHpsK9zMocKIijpKrt5aGIb7sWBLDsi//JmqfhKdmgcx9XA5Xkn8kjXFoP1fEb8w8KlDBTOrUT/c/ynRJ+JanjtBGdEvXXDSaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3U/bDQ40; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c2cffd698so17093815ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022126; x=1731626926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=te/cfPXpVlK1XxYIx1bZceEtuwPH7dTOHve13FO/vjw=;
        b=3U/bDQ40TkVzsMt30R0S+Fwm2H/hcT9BAmf+zbuerBFrmg4RFUK0l75Iy0vpqC9MKP
         0ELooTvngU95Cs56TPuiqU711QveYtrB5G7ojA9r/KYtFBtOfRdN2tj4qqDSTXObRtxl
         kNgThL7/O6I4VO3tncIJ8+HVwQEx1c+Z4K/zVvlnWf9Kf3Bcy9NDqmBFJXFbfpPV5tXt
         VKItVKU4xJQ7r9gq+bpNkS4AJOX0JU0Yx+tjafyEBH+OiCvWMbWl+5Ba0DWM10+VnHi9
         BuMvbWg3hCYPtOOmwgg3+y1SBfEm0uiB0hZ2maYWh0Jh/6selCoiC+7X6PV0ygjOrx12
         itFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022126; x=1731626926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te/cfPXpVlK1XxYIx1bZceEtuwPH7dTOHve13FO/vjw=;
        b=HlVKHZ4Vs8+G0mpHy1zdKq8jdKVfykUUN0DTrNL1IUr8//8AepFQWhL27VkUYQIPfl
         7PwqyNInIK8JmweZ6jpFVC4XjAyqp9qA46aqAByeaMprhtvYeLwqb9sE8jZOCbP2sCu7
         iHRigz4kYKXvM2trcDNl11IPKRvFVffSglR7AppAdDvJ4h0G5/Bqa/OZNLdnaSUhfqzE
         mXJRaL8Zah/8Z3c2Q1vyIco3HGTRPNjsRZWc8wAgm++Tlf+N9BfkrfTfFJ+rCFuYJZwX
         blVWRB7eGVwE9O5FoKswIGeqToCXzaiGCgfRMLdja8SibFLux0OK+X8HP+qcoFWhCDR8
         PxYg==
X-Gm-Message-State: AOJu0YxZauj56tY6xlOk15J+cs90GcsVSkN/1q1I2kCXCtVoNDkL7w5C
	bqX4AVVgSrDE0WOh5wLq923HDLjMQ42oiEf9TtL6J6DtruRN7+xhJu6J8SL6EFcNwJNd0WLR6pg
	N1LQd8kVcxYYiA0vcNct9/NXIkVhxgzywp3uKlNYcvDWY55LMo9wmshPlj1Wylnw+LwBkVg4JCA
	mUnZ6wuaiZJDVQ1EJ+czB09N9e6YMMu4ZtrFS49m43QV5TgzidKtlkuRoc5pAcMufTXSY=
X-Google-Smtp-Source: AGHT+IHFPAiltfAOVNolJAl2h+HhOSP1M/MZxsyy6Dv9FYk8AEUT5WM30aZEucZ6W0XBVDTeoqUU8aas5mUiHtIsXw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:8a87:b0:20b:bc4b:2bc4 with
 SMTP id d9443c01a7336-2118359a483mr25935ad.10.1731022124362; Thu, 07 Nov 2024
 15:28:44 -0800 (PST)
Date: Thu,  7 Nov 2024 23:24:41 +0000
In-Reply-To: <20241107232457.4059785-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107232457.4059785-2-dionnaglaze@google.com>
Subject: [PATCH v5 01/10] KVM: SVM: Fix gctx page leak on invalid inputs
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, stable@vger.kernel.org, kvm@vger.kernel.org
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
CC: stable@vger.kernel.org

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Acked-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c6c8524859001..357906375ec59 100644
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
2.47.0.277.g8800431eea-goog


