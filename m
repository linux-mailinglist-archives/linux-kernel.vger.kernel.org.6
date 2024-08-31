Return-Path: <linux-kernel+bounces-309601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D473D966D52
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890A81F22B16
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581BA58ABF;
	Sat, 31 Aug 2024 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGo2+jyr"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823DAD2D
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063369; cv=none; b=EVjWlaNOWZP/k4ax2hVmIPQzLTwnt6YY1GGA1XC44Uw1DbZxpxDSybud+D2lwHcxaFpvmv0VmZmVCm0wB1sfRM0fp5bOGcsliZTACwAOkcNZj/zMhCEoG1fsTymyoab/bAXCYGLBV3i4vhU1iqjfpK3HDAxL6gGnj6rkgJj3A70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063369; c=relaxed/simple;
	bh=LzpJ/JVED9Xy/kfec+E0sqmDsVm4jZ8PMfDy2LTQRhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cA22eJuhMyNRtA+4DXibdSa0t91QxzhKbDpZ8rE1IzR3rRkg41a9du59SEW9whl+LkkfMMba3zkan1A9GzyiajDhrp8x5DCNQYxWaPV7h/bkXEmLEL62U2A3rV5iY4r+zA9CxqjLOJJfBLrf5xWv58befWH9HdYPM+juBNQrFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGo2+jyr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7144c67e3d0so2311957b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063368; x=1725668168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i1F/rHShfrDTgNHmv4cG1toMKdrxBDoSppyZEKY7y+E=;
        b=cGo2+jyrnJ7A6D0zsP/8TWXvElPKXRdHnVxx4M30gHzMwr6sjOoERCtL/GVa6EJIZt
         3q4b4lkWMrPO8CFxRBjC0r6cP2AKMqWGiaEFxDhfPAcqw2+j5Pu94ZiTmXO/ks8THxev
         52CFV4LvzYVEmIjaNVeF3eudhcI3fbIdIKYBYKoF7GJEJPTuVGTkReNq3yJj7OaP3OfI
         f5pWwse4xl4FtUcmJu2pwiZ5ursqgtKV42lHKzZvV4NCzX4K2dPgsASV/OLDv+2NjH97
         3bW9KuD2O6R/3o3SzsSOgmPQBQbJ1KXZL8BOCLt3RypMpLDcxSjsz2nCVA3gABcALOEW
         5n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063368; x=1725668168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1F/rHShfrDTgNHmv4cG1toMKdrxBDoSppyZEKY7y+E=;
        b=Ui7IMffFmrFl+kpoIj6kOBEOZvQf9y2wf6wsjButXK7Yi4f6blvNAb7eeE5SPSdz24
         M9M0AQwu+I7Ig5QzwRveMx0hg9COcnYBIRqBi4dttJPNDCaAfawRGGMUKmZIfC9gLPlz
         WZ2Kj/nS/qX+nX8MjbxFJrXFVwfoOm0aKl79x+t/dccRZ5BZX6L7wHYGbiF3FUSaqBSj
         +Imjxc0XTNN5Z2gaJyDs/85MTk+PeXldaUg2DourEXReDW8j3omYfbdVNuCWy2tcLqVl
         vsQa6E+rKYdI0oZCA56Tc48o/MKjz0x057v6GDprDgzbOcgpKVbnO3+Q/TStauqfPjMA
         WHyg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+e5FPegaNgrEGrWv5awHxi0196ekwpAVrP89BwELD9/7x8mLnCFcm6H3svnp4ce5xnfzCMNTe/dse2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sh2baikAZPdkzpZ7KRavti+YjGPWZcleZW6Vn422lwEqO5Ia
	hcdb6OB1BdFeKjyE9VYCfHmoV2NCfdmYqQia6pMIw65Y5fB4Vfqq9PjRws/rKwY6IaxAtvEsl+P
	zHA==
X-Google-Smtp-Source: AGHT+IFRLF5vuwLCmCExGGa5XYbATHrgktWltU4k7xw5DL+Mn8fkJtnEkifE9EVPqwBnNdQM3Vq7ebbZ5c4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:8983:b0:710:5cfc:8795 with SMTP id
 d2e1a72fcca58-7173045b0b6mr7558b3a.0.1725063366272; Fri, 30 Aug 2024 17:16:06
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:28 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-14-seanjc@google.com>
Subject: [PATCH v2 13/22] KVM: x86/mmu: Always walk guest PTEs with WRITE
 access when unprotecting
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When getting a gpa from a gva to unprotect the associated gfn when an
event is awating reinjection, walk the guest PTEs for WRITE as there's no
point in unprotecting the gfn if the guest is unable to write the page,
i.e. if write-protection can't trigger emulation.

Note, the entire flow should be guarded on the access being a write, and
even better should be conditioned on actually triggering a write-protect
fault.  This will be addressed in a future commit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ee288f8370de..b89e2c63b435 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2751,7 +2751,7 @@ static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 	if (vcpu->arch.mmu->root_role.direct)
 		return 0;
 
-	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
+	gpa = kvm_mmu_gva_to_gpa_write(vcpu, gva, NULL);
 	if (gpa == INVALID_GPA)
 		return 0;
 
-- 
2.46.0.469.g59c65b2a67-goog


