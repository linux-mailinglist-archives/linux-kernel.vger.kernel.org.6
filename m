Return-Path: <linux-kernel+bounces-182475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558888C8BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5791F23804
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11638158A01;
	Fri, 17 May 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYdfVY/M"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67713E405
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967665; cv=none; b=rDO/wUqsByVnuwnt5WlWIeu6qxaVLhsK3tU54n0nfDGhFOfTztPrb5FdZtIfLStexOgpX9yeCLmxuyRRD7XpJpuZfAVLtuXZCDBntEyyeG+PqhF+etzvMyYsp0j7xWeWeDOyxg+GlYLoSgjcAPRLu60XNlsuSAy7KHxtkXI6KwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967665; c=relaxed/simple;
	bh=Pyxmn/hLqxlhDGyDfXFPGC0l79mx96nG13APkFcZDms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDf+mUBPAiR4+Msi5MN++d+XdUtXuJbbDoATjtiFZtKv3O5JjLWd5TIq4Az8RijWdjJrzobdMm/yvs0cTF64lt7w/BaTQ4DYIXVSsmED3qV85LhEyyrBZZbf3opwk4DdiOz+4qoTkWqjg9X3YafdXzYo3peYXCm8eyezRawGr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYdfVY/M; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so8099498a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967663; x=1716572463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AwwL9FWRmXo2naByXgzSbdIqVHMYablwKObp8DFQ5ks=;
        b=BYdfVY/M7WGu8WjuZdumhzU77shgWy1TxEHlkeQ4xqe+ZkH6PIN9xvfU3FskfXkWRr
         HG/c932TNJtgkwirpebhTVl9CDYFnbpY50TbMkByqH0zHKFt5MTzSy0zyCsjz5FOJM6j
         6ym0rg3kC4bemU1pk5dn/fnKWfXSzL/9575R6krA3sfyXJHADa1xiv0jOEdHYyY/LRLa
         VfmGSCP2DqaBWYguKzwPaRcwjmtPrdrZpdfL916l+H2nig3+PFCVFzWtbPc2IgQpZkdW
         dZbBQDupedCuIPrq5L/bnfDJwJIxwGMGVHTulnyzN+EwQSkQb6/InJPrIt7DS9xpVe14
         hxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967663; x=1716572463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwwL9FWRmXo2naByXgzSbdIqVHMYablwKObp8DFQ5ks=;
        b=wgF47Tea1djKlyuWA5FfKzptdqslMrPwbVvCJ9TH1YBugWt1RXOnwF3Uklq1V6Nyu6
         WFzHSOXD8vfRKTAp4iKmsJ1w7lOuVXDNyf2ISofNLKdqALFBr+XKOBhB6J5ez7B6d0cX
         dqTip0vCk3LyB9HeH5t6F1BmA+bYzkDNAMSzpbM7yZ6q2u6/ZVHSno5lSWYkcKPygWu3
         BMjdE8WQ+QT73SA34dv5ClcR8LAvvK3gp927/CiR4QA6emQxt5lXU3yunLaF6YAh3LsX
         tHw9XS77Z+uj5kVLR7iel4evrEFzqzWEoPY8m2cAa+d8EtUzHa+YzIfPQJlbsVcf28FG
         TL/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEP8ZaH3W+Y2m1H2RxI9Ui1UDFfroBmpBwGamzNX19VdlIjqZJH/26huzrA10+7Bt+KYvpD/uokTOiPi5FY9UEEol7c8ohhxycQ5Xb
X-Gm-Message-State: AOJu0Yy06BnCYGBxMKtSQsgfthO0Rpp3fExL743A/2HbIbU6y9072HXx
	Sg0Ee0C3/FdS6WlFFQcTnkk1W6VI10a/8l/yagpWma7Sq2gKvWOMpAL4QLwcmEtjwv9sFqB0m8c
	JuQ==
X-Google-Smtp-Source: AGHT+IH3iv4H05a8SLZPVYBpYK75/A99SyLmuT0NMhMtOyMTHRzxTnApE6uqfjZ4bjLYrbV2sV/rMsu5umw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f2d2:b0:2b0:e2cf:1187 with SMTP id
 98e67ed59e1d1-2b6ccc73af7mr62788a91.4.1715967662931; Fri, 17 May 2024
 10:41:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:19 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-43-seanjc@google.com>
Subject: [PATCH v2 42/49] KVM: x86: Drop unnecessary check that
 cpuid_entry2_find() returns right leaf
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Drop an unnecessary check that kvm_find_cpuid_entry_index(), i.e.
cpuid_entry2_find(), returns the correct leaf when getting CPUID.0x7.0x0
to update X86_FEATURE_OSPKE.  cpuid_entry2_find() never returns an entry
for the wrong function.  And not that it matters, but cpuid_entry2_find()
will always return a precise match for CPUID.0x7.0x0 since the index is
significant.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 258c5fce87fc..8256fc657c6b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -351,7 +351,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
-	if (best && boot_cpu_has(X86_FEATURE_PKU) && best->function == 0x7)
+	if (best && boot_cpu_has(X86_FEATURE_PKU))
 		cpuid_entry_change(best, X86_FEATURE_OSPKE,
 				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
 
-- 
2.45.0.215.g3402c0e53f-goog


