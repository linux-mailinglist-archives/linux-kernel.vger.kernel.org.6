Return-Path: <linux-kernel+bounces-182443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D366C8C8B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6FA1F26425
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B85142634;
	Fri, 17 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oM2K22Z8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C81422B2
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967606; cv=none; b=fBSfKbk0i6Vu5lYGLM++EIxGbMI940bVqW3NME1HT1qjvEDrCKZ6bOkP+fwpe+Oyrn0NlT6v0so0ORD91fHsB9BPbFRAEl+k/gWFi5++uO8qqqQDYsgn9rK/d+0fHnubnGvm/6Va4Gj6/CuzDf6yJ3qie7gZ8Uuutlmva2yOi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967606; c=relaxed/simple;
	bh=DI4/ELxTH3hzY9OTkrbKa9h7i7MUceWpwjMcWgYJsuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZ5dg2Jdqv4TFswaO6EK9kgOOQjwiB3ysR5J8ZHdDeohw9pZY7o1xEiQXmQO6AHrsKjkQm01BptzDdoEq4LAz8k2oyXpKX8KTq8ExBxuZOUoeDyO4hn8ZaDEi+GXCUYaQX7OkxiJfJkFI6mMeMJTEDQB960wvJMtdl0JBOzivGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oM2K22Z8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bed763956so176287607b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967603; x=1716572403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dldllaDcGBZvZH6NtOcaE7tueeJFAAYCu1TGcHgzlU8=;
        b=oM2K22Z8FmNS47bFwu00xOYqe5DEWO7bE3qj58hG+j7RdknlfvTwf9RpQmW0Nlp5SK
         MC/148hYsKnXI7nwZT+vc4k6GB62opJtyi6diY6iu9nX/eNmAoyZu0oJ+4SB7UPk1T1p
         gT1yoQOyuxWaU0kO7GUJ8eAWkBf1PgL4kZuh27xexx+ZI7mgQtzYZltTNsbY6WXAoNYV
         WcsLK/e7mePnUmdXqkBAa0XxfBSLpLq/PC+3VohzIvvMhvV4s7Whf9Mz9XFdhfzx218w
         frghS+2rVTy+gvJZIQYk0OWMjZU6zf81oN+DTxFZL9Sq4hj3u3zG32oRQrHwZP40IoGk
         M9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967603; x=1716572403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dldllaDcGBZvZH6NtOcaE7tueeJFAAYCu1TGcHgzlU8=;
        b=LPEwkW+BC2q+YmY3gey/9pfsfu8isNz6Baldpd5PjaldBLwLx2IjoKmSBOOd5laMHM
         MK47LB0297g5AV26GJT9AhmxLUgwJPz/RpKlbi6PiiaXNYJX4gvDzapjFRwvLoCaUj2s
         U0ni27BMJQrJ5NiKjEgiaXJCslE9aOs4zQDMvIcJBhcvvVN7TDfu2yIVnU8x2JGH667c
         Yi2N/YpuHPSbrUKEaopCcA5O7RriaZF3WeCoIxbewLAByF7OTmx0U3xmIDxiGtClxttI
         WJb01BkX/wXemOBxKPbqs1m8zxReVCNtUrgm0HJy7Zoig6qpYYLo5+M1/GkrlUK5p1su
         4unQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI6VKiOuihTwxM+8yiCTdzJiBkicztQLJFihlzltNuyj+qgeIUR9VN8r8FwQ90tPXbBn30gvb+Z+U+e4XfOBhgPM0nOeqVBddDyecu
X-Gm-Message-State: AOJu0YzNDdVINfv67VSc+vh75E/2HDlN2HywzvFGNVrac5n8qWxi59mP
	2JYHDBfIWWyso16DoDQGLcWyheTpOcM0963OetoZoptJW6+DyP9YRZOHk2IouWEwUeidjyPGDxY
	pMw==
X-Google-Smtp-Source: AGHT+IGp/H+cqfU495ksr+oE46qvKy404WMzXw+PGCZ59Lj28TEHAa8o+ZTpLfzkwzVNkH98BBdmewU+62c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102d:b0:dee:6802:dc49 with SMTP id
 3f1490d57ef6-dee6802f337mr4772620276.1.1715967603141; Fri, 17 May 2024
 10:40:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:47 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-11-seanjc@google.com>
Subject: [PATCH v2 10/49] KVM: x86: Drop now-redundant MAXPHYADDR and GPA rsvd
 bits from vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Drop the manual initialization of maxphyaddr and reserved_gpa_bits during
vCPU creation now that kvm_arch_vcpu_create() unconditionally invokes
kvm_vcpu_after_set_cpuid(), which handles all such CPUID caching.

None of the helpers between the existing code in kvm_arch_vcpu_create()
and the call to kvm_vcpu_after_set_cpuid() consume maxphyaddr or
reserved_gpa_bits (though auditing vmx_vcpu_create() and svm_vcpu_create()
isn't exactly easy).  And even if that weren't the case, KVM _must_
refresh any affected state during kvm_vcpu_after_set_cpuid(), e.g. to
correctly handle KVM_SET_CPUID2.  In other words, this can't introduce a
new bug, only expose an existing bug (of which there don't appear to be
any).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2f6dda723005..bb34891d2f0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12190,9 +12190,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		goto free_emulate_ctxt;
 	}
 
-	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
-	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
-
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
 	kvm_async_pf_hash_reset(vcpu);
-- 
2.45.0.215.g3402c0e53f-goog


