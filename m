Return-Path: <linux-kernel+bounces-182472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834958C8B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E645284DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D3157A5B;
	Fri, 17 May 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvrM72hR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64C157474
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967659; cv=none; b=BHIwwcrAQgJ1h4XQjU5ntuTrkMUiAIupDypF4ILercuIYh/4RUXSKz/fIdBP/En1aHdbMlWE8jtdFIdLeYb897Pq/R3oXKenQbljtonsuH+ASFWFP24hW/gNTTIsj9Nw1jCWgz39vmST1b+8d9FcDOtCeIUzSpNmpBwdFT1B3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967659; c=relaxed/simple;
	bh=Cay94HGTWkCzW13eekg17Dn31y1awAvnR4+4hGNuRyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b9o4g27hDylCBb2q5InIQOEwOOWox2BW+xozXCgi8a//nbGC9o14ikU1gv3XN99rfsAoTQs+Shkdz8rISxVaoA8yqcwegWBfER6AFPE8ESKad4xAO75QPnTdeDlLi6P4NlC7yzkBbEeLyk0A2kgFDnzC8+l9Srjgdc2BtH++4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvrM72hR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b1200cc92so167442837b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967657; x=1716572457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WUhNdB9iIqzolqucVtWTAnagZOY7Bg6qZcQz9vFUY2A=;
        b=FvrM72hRN10JnzzFU2byT4KjiuE8GSzH5W4rV7WdvMX5fkuO4q6nZZ9+dpKB4LPS7V
         a702gWXPOWyiqLXaMOtDl7BROReWuRV76Iez9cEMWg6nYFW/y6rOb83u7tRVSLW7swv4
         YQCVftglVElFz2eKxySCa2mKYOfq+cwslaNGybKabWKxNJPufeUFQHJnG3syAuR6laTF
         qxQRDSzrfd4FTjxPoTqdnIPUNlYr+wDTYCKgMJHYBDTIREcZsJajSCxQD7wpfDHxX71I
         hIsrmoNsKSRJWyHW3pObJIpucI6zO89DRS3+rwyU3vv3jANavajrinLorrkZntqYnqo4
         stEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967657; x=1716572457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUhNdB9iIqzolqucVtWTAnagZOY7Bg6qZcQz9vFUY2A=;
        b=a2qh0kQYz8ZyDN69VzV/2MD0TF+MGLHdETS58yr/vGWvTOBmfTLL4XrWlbpoSGRdns
         Smtoi0gkrVpUPccfx1cHVmfDmRaJ3UUqB1Yx568EE8EoFi5TtN2xNKxqEXOWQcW/18wU
         jdZhFQGzgBwx6gty9KxVkFOZ5X/ltBcvLYSce2dx9tAWpdYV/VoKPqRxmFJXauSYBNwB
         aHyQlz4oJHkhbv9TvSQax93e6hONF98LLyxKByFMPrXBhUpZ1TXyZNA4PPA3UPXGV0Fd
         qmEjrF53tDws4/bVd6zU4cjHeFGUIPNAItW9Q7di6U6dw1fBSsAwpRzK3yaxqhhaTEGF
         9K6A==
X-Forwarded-Encrypted: i=1; AJvYcCVU1827vgb6/3b+38qqecWMOSiPfqihXMHHKqHFXzyDKLIKesYeb93uxBtbsD0JlPRRgrjzZ1K4iOD+kjBMl9lDTfgmN3InT3TRICdB
X-Gm-Message-State: AOJu0YyNv+QtaNrI7jURbMqpHE/H+HzgeQaONYZ+FZjx+hfNxbqjUh59
	B8wJ8mCi1hxgK5f9vfkL3jYX9ASAritkLUCiDusbzUKRAvWpjJWTLR07AnpAV1OE8dg5jFllwtV
	uKw==
X-Google-Smtp-Source: AGHT+IFTPW0Wk1n6XlZB5IqAqWVV2h1MhuwZJjgg+6IrPpL1gJ4VNQ4RI3DWEO/Zf6NkYtQyC5efPJOIdJ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d353:0:b0:de8:ac4a:1bce with SMTP id
 3f1490d57ef6-dee4f3210b7mr5483067276.13.1715967657453; Fri, 17 May 2024
 10:40:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:16 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-40-seanjc@google.com>
Subject: [PATCH v2 39/49] KVM: x86: Extract code for generating per-entry
 emulated CPUID information
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Extract the meat of __do_cpuid_func_emulated() into a separate helper,
cpuid_func_emulated(), so that cpuid_func_emulated() can be used with a
single CPUID entry.  This will allow marking emulated features as fully
supported in the guest cpu_caps without needing to hardcode the set of
emulated features in multiple locations.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fd725cbbcce5..d1849fe874ab 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1007,14 +1007,10 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	return entry;
 }
 
-static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func)
 {
-	struct kvm_cpuid_entry2 *entry;
+	memset(entry, 0, sizeof(*entry));
 
-	if (array->nent >= array->maxnent)
-		return -E2BIG;
-
-	entry = &array->entries[array->nent];
 	entry->function = func;
 	entry->index = 0;
 	entry->flags = 0;
@@ -1022,23 +1018,27 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
 	switch (func) {
 	case 0:
 		entry->eax = 7;
-		++array->nent;
-		break;
+		return 1;
 	case 1:
 		entry->ecx = F(MOVBE);
-		++array->nent;
-		break;
+		return 1;
 	case 7:
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 		entry->eax = 0;
 		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
 			entry->ecx = F(RDPID);
-		++array->nent;
-		break;
+		return 1;
 	default:
-		break;
+		return 0;
 	}
+}
 
+static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
+{
+	if (array->nent >= array->maxnent)
+		return -E2BIG;
+
+	array->nent += cpuid_func_emulated(&array->entries[array->nent], func);
 	return 0;
 }
 
-- 
2.45.0.215.g3402c0e53f-goog


