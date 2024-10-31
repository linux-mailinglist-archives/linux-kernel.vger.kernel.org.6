Return-Path: <linux-kernel+bounces-391253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A993E9B846B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E587DB25D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571D1C9EA3;
	Thu, 31 Oct 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDRsLbkw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5991494D9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406739; cv=none; b=HvJWeejsqP3mBXgYmbRxUOEWrr1WjbF1IqB/lSpiGMW8OSxxlQfYvY1ojNDyz2pJmROsNVZMWC1eLDzitEPGRnQFymbG+YRi//fwFyO/S18in8sdWMZvR60ssedPRmTuyB6+qjuVblI8FYjzRw2TXMEtFKGfy3aEu7d9ABTpuNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406739; c=relaxed/simple;
	bh=Ci+gadG9vK91lwDAZWto+nvmTJoDDX1wy8w81KMkbw0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lSOQUC8MLIgl2zvcPH5AH7GeS3bjaqk3A6+pSmywcLfqxIn4Qz4z2TuglPq4Ehd/Kv2K9zjE+zIU5dB41q/ncItfdt5D0ZIvSw8keumE+W4/SOeKRke9CgSjcu9QzpgCYwcgBiFuk6NZ+Xo8TXIXnMoJCatNa+5ocINdscpP/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDRsLbkw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e578061ffso1933662b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730406737; x=1731011537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgEcY/iu+PuV+Ho8Elw8cqw/X4GJ2SmTQdt9g4Zs0NE=;
        b=NDRsLbkwRp+O1pU2unKGTj8MSDdbhxs/sxe3W5QULonEhN0JVOgYNnoB4Ygx/hVdtq
         rRet5Ro/7xwVNfSJ/ic6PB5Wt5ApgKB5D1dA/px7MHXr2+c+tQ/TH9tlpEz6oYegGfGL
         jOG2LxjZsjxD7NnAZkivdfQpyMfSSEiE9Lpp9EXllyJO2wFga20uWhUs0kOBE8Hgi8fg
         9hKDve939dJOkEMoVMyrix42s7B+TghxEuNUPh41MkheRs5jS7OPB4XV+lZwE69PxogM
         uxjtWywxpINaSY0gHxYmQXzEQi6yKQrYwg+xjhrnYJ/mv1ZkAmqL/dNRsnUBcWXHTVDU
         bP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406737; x=1731011537;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgEcY/iu+PuV+Ho8Elw8cqw/X4GJ2SmTQdt9g4Zs0NE=;
        b=LHrL5FGBgeJn/l3e1KnTGImDMRyUokNEGiBK7CqEDBBrpWTlXCi9TTUgdzwaA3uoFf
         NOD5DdLm+mFsRySEuuKoCueczJ0XH/DNUxR0i/GXLZUfQkqMYqkWI+fyqemH8vLqONJA
         pXDkcW/rfBqLVixsJX724WvgsIq6K25rhAN7zGYCmNg4kZ7p8Jm70lMYIXNSSJN3JC7h
         LD7tv2IAUzEFjHb1aAvU//V0OjRrKfcn/L5TnUsvh2DKhrE0D90rLrzZvqxooh+sMb+C
         uumHJv6fjE9qU1fgRO2y0SsSWEWAKtG9JTekcSp/rdzWO4x8QaQ8VlgOqWgqhhR0iLmw
         gv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJthmpZMAXBG3q2lgl3fkZMi3jWFCkyLvzK2r2iSnzu7L1NeaiK5O2ymSUTNmrVM/7tm/g6v8+PBV4hVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CqmyVxPUrX5XKRWir7HynbFWxcywlmZoRx10KDWnek0gxEgm
	390JLWVeSEVZGMEPz7Lnh0PyzP22ysYW0JclPpCRptNvs8p7k7axrCPTcbcOvaHxXKNr5zVHCLW
	7CA==
X-Google-Smtp-Source: AGHT+IF+C75ZCAmHvmxAjzhcUtAXvoh5HpQaB44u3ZGPOz1JZ+/WF0cVumwkJeFwB4JXlQHlXveEb82zZuo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:aa7:87cf:0:b0:71e:5f55:86ed with SMTP id
 d2e1a72fcca58-720ab508471mr16104b3a.3.1730406736852; Thu, 31 Oct 2024
 13:32:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 31 Oct 2024 13:32:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031203214.1585751-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Propagate error from snp_guest_req_init() to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

If snp_guest_req_init() fails, return the provided error code up the
stack to userspace, e.g. so that userspace can log that KVM_SEV_INIT2
failed, as opposed to some random operation later in VM setup failing
because SNP wasn't actually enabled for the VM.

Note, KVM itself doesn't consult the return value from __sev_guest_init(),
i.e. the fallout is purely that userspace may be confused.

Fixes: 88caf544c930 ("KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410192220.MeTyHPxI-lkp@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c6c852485900..9cfa953088ce 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -450,8 +450,11 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		goto e_free;
 
 	/* This needs to happen after SEV/SNP firmware initialization. */
-	if (vm_type == KVM_X86_SNP_VM && snp_guest_req_init(kvm))
-		goto e_free;
+	if (vm_type == KVM_X86_SNP_VM) {
+		ret = snp_guest_req_init(kvm);
+		if (ret)
+			goto e_free;
+	}
 
 	INIT_LIST_HEAD(&sev->regions_list);
 	INIT_LIST_HEAD(&sev->mirror_vms);

base-commit: e466901b947d529f7b091a3b00b19d2bdee206ee
-- 
2.47.0.163.g1226f6d8fa-goog


