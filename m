Return-Path: <linux-kernel+bounces-424148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77149DB10C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60071B260EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25271C07D8;
	Thu, 28 Nov 2024 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myU7Zt4J"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AC1C07D6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757736; cv=none; b=VIk48sWGZ0cENjOcT1k86oo/lj6MwQftw1nUoJ1PACSJJ+8umb1nad9e7fUo8wRThVKIW2kOoq+RUOiPWLMTXvomkwObGeK+9LKcriDwrIV6MJXAzta1mWTP6BTAN+8lhPYczt6nVyr58fT5/RlLRThUcSWDGsOrTG5X2uftpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757736; c=relaxed/simple;
	bh=dmANShCgt8TBaYCJdM9bvuNmFYoQV0bXx+2YV2AZHIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDGQBV+zZckytLENoAt/spCX3lWtrf1kpwd6d0RgfW0IU3oBheTRmQq4OghOa4NvnOp1cR9hFw0ofqoURyss3pYfVy48IP2+W/S4lNlUtbpxEhhxSm9CPrWWgD6+3rpt54kBJyzeThz+lNlRbHHWQ21ft4tPvQ8IYgnMkL+rT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myU7Zt4J; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea2dc1a51fso363559a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757733; x=1733362533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=d27fglAEZdmCFt7lZZWr0B6WUdudB3vEjO/vTpHdmOI=;
        b=myU7Zt4JPtvLg5f4HXY4JvSmGVA0hBshJV0A6kYJE8C6L19DEaUqcTwE0PuNJKfIrj
         h2cxc56ab1syygdvgst7j9q4H2EDSM3a6uUC9UcrrfNlS2nvazUwWEZmquI4gXo9qj9N
         1agnPgJYnKgB01Iu7NMJr8ZcwWUUt4O4NlN1Y6QYVqRT+U+ruzWHR4MJVmkdqgYv+Imi
         zp4DvUn+V3KVQzPgOoh4lILxgJUtzZ3Absrl39GcYjFEzPhaFb82ihkNOmyLl+WSZvjm
         q0YDSajhFualvXlM+asigZyoj4cuTyPbhe8AV2PK9l0QpP7AyxozWRK3h4UplB61OEco
         r/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757733; x=1733362533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d27fglAEZdmCFt7lZZWr0B6WUdudB3vEjO/vTpHdmOI=;
        b=w2M0dfCJzwlHCdrogysy9jsYsAkLBor5wBHzuNV5sO6uWUFap3FPBdnU9lVqzwOpzM
         FPKESLCDcdDhaDcfe3VQsB2bCJIDUIiiDOnFQwtZCdIKJwRLLWMSywJ+zwsV8MGBppsi
         l09Xp5vebNFJDAfJeNPldu/W2UTJ2u0CLxyol87ZjmTio8A+rEGp8Y0MuWRtUpF3EQOH
         jrKQ24seM3wmF6yBDQbJVfnZTadxRQ0RYSx6SV1Z4syBJ7O/Qd7WP7fQ1Q27QK8XKfFx
         Va0MzgTmtVJ0TL50iDl7rhWH51Owy5rMX+TJf9FExFyvxSI+SxSVRryJt4JYH3D4miD+
         5G5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWcemHsctk62L+IuLsf/MGbRum8r5Gj1zUbuvfT3l2zf5X8/w7DrIWfl9Ey4hbzCpe4wjjU9pIKKMFaJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qQd3Kuy1zeS416Nf7kIAYHouwmc+GovcZZXOtjhr6ZqbXfPB
	GdEp7VMNwQ6CNJtwGPvMmF1OoCZuyHI2go1Tl/O8oKCTcx0TL7VVizx65qV8N3HeSl+CD0pf/91
	lJg==
X-Google-Smtp-Source: AGHT+IGnxVUWBO7YupB29jJ/tSdtlBsbs6lN4f+B3+fX3YxFu7CEBseh4FCdW27RJ5F2vsaKMBwJEbVHbjk=
X-Received: from pjbsp6.prod.google.com ([2002:a17:90b:52c6:b0:2ea:5dea:eafa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c87:b0:2ea:3aeb:ecca
 with SMTP id 98e67ed59e1d1-2ee097c2965mr6144095a91.31.1732757732886; Wed, 27
 Nov 2024 17:35:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:02 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-36-seanjc@google.com>
Subject: [PATCH v3 35/57] KVM: x86: Move kvm_find_cpuid_entry{,_index}() up
 near cpuid_entry2_find()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_find_cpuid_entry{,_index}() "up" in cpuid.c so that they are
colocated with cpuid_entry2_find(), e.g. to make it easier to see the
effective guts of the helpers without having to bounce around cpuid.c.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index af5c66408c78..fb9c105714e9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -121,6 +121,20 @@ static struct kvm_cpuid_entry2 *cpuid_entry2_find(struct kvm_vcpu *vcpu,
 	return NULL;
 }
 
+struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
+						    u32 function, u32 index)
+{
+	return cpuid_entry2_find(vcpu, function, index);
+}
+EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry_index);
+
+struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
+					      u32 function)
+{
+	return cpuid_entry2_find(vcpu, function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
+}
+EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
+
 static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
@@ -1735,20 +1749,6 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 	return r;
 }
 
-struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
-						    u32 function, u32 index)
-{
-	return cpuid_entry2_find(vcpu, function, index);
-}
-EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry_index);
-
-struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
-					      u32 function)
-{
-	return cpuid_entry2_find(vcpu, function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
-}
-EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
-
 /*
  * Intel CPUID semantics treats any query for an out-of-range leaf as if the
  * highest basic leaf (i.e. CPUID.0H:EAX) were requested.  AMD CPUID semantics
-- 
2.47.0.338.g60cca15819-goog


