Return-Path: <linux-kernel+bounces-263872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB893DBB7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696F4B247D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8BF155A58;
	Fri, 26 Jul 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljInQIc+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C117FAB8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038030; cv=none; b=Ivpp1gfFyJY9aeg2/R9+NDE/9EE5IXuxdNJM7WU0+aunMpRJzKHUdl+oeoNbgApkp3HDnMIPDDL1XNsVY7Jkl+FUbIiEMJo5FGDFL6QjLUUHKqq0U+sTDAl/JHfKL+q77/rM89I5zPX3a53ka5CSgaaxzE6hnHwJYoK4pPpVheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038030; c=relaxed/simple;
	bh=iyko0n6fwOnAH7YleGpA9px1iO4LPswzFGIVpqZk3kk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMObYMHHwdotJpkZi5rJWvDzzFyoIgZK4wPw4toDJYpWnLX7SqPiFUXWFqQyWUQPxbXfz3Jc7XvtGP7DWOR9NOPr7bu4uxKxnbUnGJ06hkLMqZucU3faxqbal1sBMR0HvZRqxop7ugSD4bcHD4wa5P8ii1mp1ZMc1sW7q/Oan/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljInQIc+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fd72932d74so11082025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038028; x=1722642828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f0UOaTihDpRJ7PP+Ej2doGcOk+AHWo0BkuOsHzozLVI=;
        b=ljInQIc+FH+iLIEq0W0ax1ur+rgWMLOAZ7lB66J7DrMKkIHt89l0ApJT7HkNUcQjni
         rrs/SAAkmKIWGpCkmbrh3msCXlJCubg1tdmoXX9dYifErIRRpEwTzxl1/NAPWPFDhOiR
         blPLqUrBlpKdppCGjC7aY/mZSKk3KmBKrPlp2DOZ95ho+7+x8uc9YSeoB/VzH9ZnlWLj
         Bx0tPwwK0LX06t7Odw2T6P/7ew8fDBcmEwH4UX5IoqLWVGxXtnHAHiMOIg9Y5MLaqA39
         GLlqtmx6TXjK4EsxoDCb8jL4Q5M+cQuinpnH0uo4Bv11r2wCGXikBhew/0vMXBLRNiJI
         4aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038028; x=1722642828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0UOaTihDpRJ7PP+Ej2doGcOk+AHWo0BkuOsHzozLVI=;
        b=XxeQcS2MfaYnr13ESsMWsZtJkyhMAhK/RJnUcuST3CqJYHx4JuOLkJqhh6ZrcfkOwh
         s7Rf7ocpryU+GalNmXZ/Ocx8U4XHy+E13hOGTp9n4/hHCbItDNR0JdC9TZw/L7/PQKc5
         i2F1NrJaJGN3O9R7NQZhyObVsRpkCLxE2R8NgrsogWnNxxd1FtZ8xSgtyOBXq/IVpxrM
         wTwwTIMEW75HZPuxDokbzV3/YxsGekb/orUJeIr/m2M8EejnxwMiE5v0sjy50zgXxhWF
         0klC149mxFYrz1cfsztoHyTFBdiA7bqR4MohoIz1m02MjQNkbk1xzArODgmyhmI/7ebf
         QLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWENokx/+81SH1NmMp+Qw2s2SPjiGGhoLyjEUS1RuqYPDsJxty9TBEDe6A8qRKE6Tz3UKibz0lr3jw080Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkmFoOuaCTRBZEjskArFrxb5rR2hnBMIEWd5rWS4qQdie/wSUw
	DEWjO8nx86Ny1001lSto+Ngyr+IonThhz8P07/tnO3Pj5SamBrspAwyiWpu2nqrjpFRw44Zn0xU
	nbg==
X-Google-Smtp-Source: AGHT+IGYUMRc1uUxr912DKcgHH4gUUnvf0wLEKnF8dkY5ruUFOJLgoqFTBS1LD3evC3JUrfTD0ZWGbhz678=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:cecd:b0:1fd:6529:7443 with SMTP id
 d9443c01a7336-1ff0486a65amr545105ad.11.1722038027663; Fri, 26 Jul 2024
 16:53:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:43 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-35-seanjc@google.com>
Subject: [PATCH v12 34/84] KVM: Add a helper to lookup a pfn without grabbing
 a reference
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Add a kvm_follow_pfn() wrapper, kvm_lookup_pfn(), to allow looking up a
gfn=>pfn mapping without the caller getting a reference to any underlying
page.  The API will be used in flows that want to know if a gfn points at
a valid pfn, but don't actually need to do anything with the pfn.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 82ca0971c156..5a572cef4adc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1212,6 +1212,8 @@ static inline void kvm_release_page_unused(struct page *page)
 void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
 
+kvm_pfn_t kvm_lookup_pfn(struct kvm *kvm, gfn_t gfn);
+
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0b3c0bddaa07..ad84dab8c5dc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3118,6 +3118,22 @@ kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_pfn);
 
+kvm_pfn_t kvm_lookup_pfn(struct kvm *kvm, gfn_t gfn)
+{
+	struct page *refcounted_page = NULL;
+	struct kvm_follow_pfn kfp = {
+		.slot = gfn_to_memslot(kvm, gfn),
+		.gfn = gfn,
+		.flags = FOLL_WRITE,
+		.refcounted_page = &refcounted_page,
+	};
+	kvm_pfn_t pfn;
+
+	pfn = kvm_follow_pfn(&kfp);
+	kvm_release_page_unused(refcounted_page);
+	return pfn;
+}
+
 int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
 		       struct page **pages, int nr_pages)
 {
-- 
2.46.0.rc1.232.g9752f9e123-goog


