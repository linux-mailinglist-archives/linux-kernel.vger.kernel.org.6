Return-Path: <linux-kernel+bounces-406851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37A9C65A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C09B3C46D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136D21D20A;
	Tue, 12 Nov 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKsxBg6K"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACE21CFA4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453787; cv=none; b=AUxAJsbNs/NuJ9tO2Dg5t4s3BpH8yBksBa4qLPnLCxO/ZnFxPPFyzIn+gI/QICvBaMqDcYl9/5W5bFz4r1fCnL7JvdJJPGzIKn/IN39GxqSV/rHqpeuQ2ZeAHuBmyNVB4/j1/KqxYH/t4sVXxMRSfWL6Jve7jHQzzkxUHe6oV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453787; c=relaxed/simple;
	bh=ayby78yQOyjOz6ls+yE5cxTfghhQvc3yyzZlL7gs+bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qDDLc7+oZTIEw0oUFkpwQBqjecUHQDldMa3L3vPdxdBW6C12/c39UvoNXy2H7AcTu2/XRdHj0Cd9EvXwnVGSx7rDvPPeeCsofirNxaSkmDJD3E8aCQnUKeS5JlymR73E7HCuUYnedwaxWf+lHJFhl1hD/71+u+qU8EzhEB3I9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKsxBg6K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2bb354e91so6498038a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731453785; x=1732058585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmL++hD8fgHMSusvyHDFwqq57StgWysj/njcEHmccMk=;
        b=qKsxBg6KK1KzmbyM0Qc41DcpDFnsE0GF+9Cuu59tvTI93sVv9ldwTQ8gYUTB/lQUgN
         scdqqDh3wEvmDuaHzVOIvpddU+ghfl63E/8FIMrxDuR1X5iPb3oVEDLZd8s60mOTIsh5
         S9LH10gSP4qPwq0olBcEx1YoV6dwVMe6f0dN3X6J3BdjT8IfRYvF8hvsN/XpVZhnftib
         K3CNOt/g+lPNfsPBbYgPOi6XcCY9pSKCccqyowLLfc7PRMbDN/nxdXtE+6eVkKE52g5+
         08mfOQjmYBpvAWFEPMwTMvCQM21GBLGbLRexMe2h2Kno1gPP+vt7VPv1TPJ9Y390UeFu
         qt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453785; x=1732058585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmL++hD8fgHMSusvyHDFwqq57StgWysj/njcEHmccMk=;
        b=L4R8qOq5Bq1b7c5CQZKwAnYQ31uMqr8JiqXKM74fe0+rIYIYjRxLbQM2TMgNabR4Dz
         h/yLsL+dMsdA/a9zllkcFPZcPJpRZcIfYUhmQJ758zRoYaJ4A9hQEpMK9GwzdIFM2Ckq
         cn4iio37+lgv7tF2WN380KuHlS/SDUT4OCDvn2JpGseC++XsJ+yYD962ot0SP8yLdpcf
         BGlMJsSk4L5N55Na443uWjXAWwhAfsrIAAzHVaRz3a52RgS0/Vhs/VB7BKQtBnNqR3HU
         wH8ZpIOAZ+P/1tFD0FV9/RCO5D27QZ+XHFkmYmhQ1HDe1kRaLlZse8eTdiqCRQop/4q4
         zydg==
X-Gm-Message-State: AOJu0YyiJ6G0uSbD9dfTxRqcnGncLobX9n7UdKeLCuSRuKkPwwAzpgEb
	HCfd+Qop1Buz2qxFfOuoSfE0BEAIgk1q+2R9/3OaY65yixOX/KrzX+9Noxq0u7m2/8G0Sozkb0S
	NEZQNcetip4DCLKgVpKnTSka62TtOgs5onWH2+iP+Q8tfbvaN7qJg9D08fv8kxD+Jfg1kC1A8wq
	bLdnwb6yr2TYCUswJMamUZqtMdXv9PNLRBN6uszhCIBy39jdJ6dv978wL1/+7kciHCnZE=
X-Google-Smtp-Source: AGHT+IEKIx/zzlZD9qfrCEEtWDHbsmZlYa32pBSY0nOxUmKrJ4QniZXwOwxKWzCDaGQhHEeyreWYnDeyUdJT3VYCwQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:2ec3:b0:2e2:bb49:1052 with
 SMTP id 98e67ed59e1d1-2e9e4c7f1aamr70975a91.4.1731453784634; Tue, 12 Nov 2024
 15:23:04 -0800 (PST)
Date: Tue, 12 Nov 2024 23:22:41 +0000
In-Reply-To: <20241112232253.3379178-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112232253.3379178-3-dionnaglaze@google.com>
Subject: [PATCH v6 2/8] KVM: SVM: Fix snp_context_create error reporting
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, stable@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Failure to allocate should not return -ENOTTY.
Command failure has multiple possible error modes.

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
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 357906375ec59..d0e0152aefb32 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2171,7 +2171,7 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	/* Allocate memory for context page */
 	context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
 	if (!context)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	data.address = __psp_pa(context);
 	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
@@ -2179,7 +2179,7 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		pr_warn("Failed to create SEV-SNP context, rc %d fw_error %d",
 			rc, argp->error);
 		snp_free_firmware_page(context);
-		return NULL;
+		return ERR_PTR(rc);
 	}
 
 	return context;
@@ -2227,8 +2227,8 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		return -EINVAL;
 
 	sev->snp_context = snp_context_create(kvm, argp);
-	if (!sev->snp_context)
-		return -ENOTTY;
+	if (IS_ERR(sev->snp_context))
+		return PTR_ERR(sev->snp_context);
 
 	start.gctx_paddr = __psp_pa(sev->snp_context);
 	start.policy = params.policy;
-- 
2.47.0.277.g8800431eea-goog


