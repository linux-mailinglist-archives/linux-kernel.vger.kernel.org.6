Return-Path: <linux-kernel+bounces-392700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E69B9736
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8DE1C21D95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9061CF2BF;
	Fri,  1 Nov 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpTHgRMA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86D1CF28A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484956; cv=none; b=utsdGEFkknYRYre/W3VJKQtfvFNPtBRsjx3+eHE8btMACLoxDNnVJ3rQSDto8HFCBkaZtrmuA7R/bvJQXsh8LRPzB+6blQmFQBAqnvxG42jkyPCh/PSERytLNU605GS19XqLkS3c0YykJZMzeZqoSJM0NP/lcNVHQf3dtavNLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484956; c=relaxed/simple;
	bh=GSHbBwZfkYhqvZmnpUSaXG42ezayg8nwJR7cfig/aho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VeZlUjFT0SozizWfYCZtqXpL/1PfF/EsideIE4cFJ6KLpJIjGVhtVsyWWLQjMvKvmQon06MsCb5FURTBPvtAnkC6W6bcS87r7eJjPEy84OqJ9V5rTKEWhKCNa9TFeLblFuJlQhQW6v4QHhppisv1UXuchUtEsdl/yxqpmW1JCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpTHgRMA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2ca4fb175so2519477a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730484954; x=1731089754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEZAnkCadaVg1BrSWxgRmpQSE/TbQcmppmH+q7yf6WQ=;
        b=YpTHgRMAdoZAKkHFfRpC6r90RhqV0TD28pXPHSyTRIlrKLTuXKZA3RT+jLb9A+siZ4
         itulhAA4Yjk+kzxe09vqyvG+OEq7iV0EnBEVNxzKrEbxzQZC/938l+ci149VTBvIPzrZ
         WAdZvDFKD3rZ9oo0vWUfuRMl+Fo2dm9oSesxWg1OPy51yZFdw1Ixsum4ha8XajpBkvdM
         up5Nzb6a+F9Ald2mzE81CzXdkQD9W64EIhqRu1F/trpWNTL7XHuM32xDPM3YUOXOOUt6
         TZ+xEJzh9Ma9CAKccIYa/X2HUnBc3O0461XALm0ivGX5ZgXEcfQBMdbjRbmbU2UojZWx
         x2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484954; x=1731089754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEZAnkCadaVg1BrSWxgRmpQSE/TbQcmppmH+q7yf6WQ=;
        b=MAfye74NlRqs1fu5MglvwU+67ZrOtNIMapso3DSr8SW3isqP6fNydOl3m4h0Q/7UZ8
         AeGwrgB3X4LfT/iOwaQPRh6FkRKafQ12tEpVpWo6HDwmpWLKbLZe5QZM9MPVKv0LYRKV
         goMkoUOfpHnoum1AZB12j/0hE0UuqjK1QZ1+uwiR3yHa+1gWOWp8TWwy/0wjQ2vvWLQ1
         877XIoKksjxCq90OCakgHjjBNr12idfjSZ7xYfmtHT8Xp8Wur/bPX6gIMvHUHwURUZIp
         qRx8f5mRj8QFRp3/kb5ae9rYVfl26Itv3sKSClZU3UdybDfezerScMxvKlVcdvEF9EFT
         bixQ==
X-Gm-Message-State: AOJu0Yx1Nab+hSRRxmU04C4m+pPuDumNYrKnTkJlrt2qTRelxFGolUkF
	pZBqDyqnByU/JTna6iPhA0zFOzigsVCH4SQKnlIoKO7XnTeYQLB09x4jkPaVXUTRTw5xhWyxYZA
	YKoBGwdWY0a084S9HrPqtz1XdeWQqobppuqDr+x8LS3vQgeC+gFsRmQlj9RULZSPzeAH9M4ww5b
	07c51trnVYLGOTpsYilEdjCp3UHHY/0youQu5B6+b3iTudAYRNMixNP8TF+VUAbnxBxNA=
X-Google-Smtp-Source: AGHT+IEXa+QnTPnVNgHoaewOLlIH8wFAnb+M/ihAEAGqYML1uHaPbaA1TFQ+R1PS5raQE1UTHGA6cnlOKUra43n49A==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:616:b0:2e2:af52:a7c3 with SMTP
 id 98e67ed59e1d1-2e92cf4f915mr20243a91.8.1730484953636; Fri, 01 Nov 2024
 11:15:53 -0700 (PDT)
Date: Fri,  1 Nov 2024 18:15:29 +0000
In-Reply-To: <20241101181533.1976040-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101181533.1976040-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101181533.1976040-5-dionnaglaze@google.com>
Subject: [PATCH v2 4/4] KVM: SVM: Delay legacy platform initialization on SNP
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Michael Roth <michael.roth@amd.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When no SEV or SEV-ES guests are active, then the firmware can be
updated while (SEV-SNP) VM guests are active.

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

Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f6e96ec0a5caa..8d365e2e3c1b1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -445,6 +445,8 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		goto e_no_asid;
 
 	init_args.probe = false;
+	init_args.supports_download_firmware_ex =
+		vm_type != KVM_X86_SEV_VM && vm_type != KVM_X86_SEV_ES_VM;
 	ret = sev_platform_init(&init_args);
 	if (ret)
 		goto e_free;
-- 
2.47.0.163.g1226f6d8fa-goog


