Return-Path: <linux-kernel+bounces-400787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A389C126A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631B728682C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0E21A6E0;
	Thu,  7 Nov 2024 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlVqdYI+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473D218D9C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022129; cv=none; b=EvkBBTOdIMO/E9gYE5G3I55UaD6GA6dZEM+gLRnSI/CW6Ru5u7TMMIct7VPEsXrPJuQAp5GRqip/LzWmoQmMrRlaaH6GST48zoClYtxxZG0akZ49aUA5s7scOctmB3TkHCnMe3YOX/sPy2ObO403HztkxulEW8wWVM/L0WYHQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022129; c=relaxed/simple;
	bh=ayby78yQOyjOz6ls+yE5cxTfghhQvc3yyzZlL7gs+bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E587HyikrAoz6s8cD9vagVyYDupHhPPqEv+GUfZiLok6xgoJD52d88yYd2lI6fcuI/i3V35P8/9d24oCmu16tC5t2NN5R1Oq2sppxa9WuYYTDVRNJ+SOkOXAa8VVNhEaHGC8W4yLcYX+kbA5O3h+9a3IptaBJjbfOQDQYlPhJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlVqdYI+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso29411087b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022127; x=1731626927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmL++hD8fgHMSusvyHDFwqq57StgWysj/njcEHmccMk=;
        b=rlVqdYI+EAwB1xQX211zKzdMzzBynt0ZHcfEUHFPIVYGDZF1ix6tBbhiycTjOX80eK
         q/AVgh9akdcnnLrZdxRVy/KD2jieeJdtmPmxdeSSv+UjOdT6NmeJrbPGKk9h9yt+9hOt
         nhBYnbVOQWZryA9O5f7BmjkZ1x1T7g00LegEFlZf9QzMlE9FsNhaM1dIjbs4c25pDByS
         7AlFMUpBYIIWD72ed/yHVa5tlUBFyiTudQElYA3+G7AqPbvZ2IxWEUUjncM+8k1XaHlh
         70+OLwz+Jazs6dYeSLDchlnS+L3ay0SERffUcwozdbukffjE+XS980VMJBSK2Q+mFFLg
         lgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022127; x=1731626927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmL++hD8fgHMSusvyHDFwqq57StgWysj/njcEHmccMk=;
        b=XMi0Yk2aoTO8LAIDnPAymq/lW61wWXN4eXO/hzYeizaSr+05T+qYmV6ggdTTZuQ/Jf
         zL5vqaNR+ZZ7xJnE0KG6ZpsIy0rNuNBYsuEJbF2/3ZvOjIxnTs19YUVGotmNMRQ0qOS0
         /+HsLIVe4IMLMfl17a8s1+0jeYF43gyWJc8O42tlV8eGpg6VblzmN5grwc1Q+Ue7d/lo
         26vE8/YTrTKa07/ymSZuPdg9+l0rLYdcm4/Iu4hCTqycspP9BlHvDGqeKFf1S4JYD01o
         Z6dYFv8MpEXjquSaZbTHec7z4qjMaS4TZImcg0qsoN5VLe6W+1CDaBzitxHkrDLroT2k
         6MZA==
X-Gm-Message-State: AOJu0YxL1LafUF2BOceGfVf+4/Dbnxlno7x2GbASw/1YCynZR8xBL76i
	3OZP0aisfnLox3PO3Knxf32grL2otT7fKM8rYiI4YKARMpzJeMqtPRMOrpsF96fQJish830HQ8x
	VR0DMKFAYt6wkyx0V05kOujPqfbcmlYB4Uz6Me3RylxSCjejSVovXS6d5gTkJLnVOLkNEjn03Om
	zkwomi/Yz39YssuktRNUd3sx5pM/2KfTOqgCYEce7KuzxDfSyor0bPOsBK1ZxX1R/4Yvs=
X-Google-Smtp-Source: AGHT+IHZp/clRKmQZ8fJk7ELtkAKGCrs2CU91VNe+31QXmURSkfx5SINiU/puhbXGTHvPt4yQyv2DjU9QK+SpStkvA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:690c:7307:b0:6ea:3c62:17c1 with
 SMTP id 00721157ae682-6eaddd75f83mr94917b3.1.1731022126529; Thu, 07 Nov 2024
 15:28:46 -0800 (PST)
Date: Thu,  7 Nov 2024 23:24:42 +0000
In-Reply-To: <20241107232457.4059785-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107232457.4059785-3-dionnaglaze@google.com>
Subject: [PATCH v5 02/10] KVM: SVM: Fix snp_context_create error reporting
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>
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


