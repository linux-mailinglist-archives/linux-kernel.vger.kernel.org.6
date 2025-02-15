Return-Path: <linux-kernel+bounces-515947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B9A36AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC853B0536
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AED21624E0;
	Sat, 15 Feb 2025 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmQvAmy6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F351514EE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582086; cv=none; b=G9iWhoM3cWRhwrXyXXJlX19NLgOB619U1BX2T+VKwM3g1y9mtL1hqokUgSxrs6rK+jsCLOaduBk7D8a+l/RafdF06pmhljUkdfQEvfG5rsm0NBPNvfflreBqOJuma7Dj7S1RRYLuJ94EYxWZHY3eB/N01l3/FeypquI0eDpr+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582086; c=relaxed/simple;
	bh=Nq45uqSKHEPg4dzpAAVHI0Nbkbth2NKJarH67mwYrqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BfHE6bdpjW8oeydBgwBrBMAa/mDNimSnRvMDqnYtXP1mhe08kk36QuOdSve62eRvX81KPYau0gds2RXOLSHgV8wILNFq126+3cUFg660dVwFslTYQwOnDyglZf9gt+Af5m5u83U4cad7mu4uyoPL6Q2IBDOnOoVrbgFs5lzScPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmQvAmy6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc45101191so78586a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739582084; x=1740186884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6j/gglXJS1yN/9vw2FthXhPcheEiRDBsR2pbz8PXCNU=;
        b=ZmQvAmy6oVbzJNNwxqGkJh2wH+/p+6/WNgY+os8wZiVBuwL2jTlyen8C0Ya4W4dKfJ
         MQO+28RdiVXLZUBtUDefqx8KCG4ZyL5OPKWSjnS23gtS5QZBbCGnVXLWTq45krMqn/GF
         oRxyELLtllONZJ1U6u3sBs5Ax3zOqsKbuA6ySMlGM+f660Me3PB1O6c24PpsZAIMJ4DA
         vPQXHrqMaWLDRiocl3J5l6GaJBRmmMDz6dvI1w3uBNsffeNdPDFzdmLEwax7KPOdz/bs
         1SRMn6R5KQEJKLp920EY5IbJYmxKf+r59hXw+uaaQCsIVtgfd0rbB0qcmlBvi6aZIFde
         aDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582084; x=1740186884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6j/gglXJS1yN/9vw2FthXhPcheEiRDBsR2pbz8PXCNU=;
        b=ss3kTAIaP08V7rTSMx5fcN0oEUYX+8wUuEkRj4F7dfkcpDK16WDZGTe95b9xf6XlJJ
         5NorkXTil+cybZ2wouD/qMsi4EDBXyErhG57LvQ65/PZnudk8umPRVjB3nw8tOOzgALi
         CjFCzYMWKLdlevP3n1cZtgzLf4ks7ebBSlZbdg9efClTJ9LCNLQYZ+ZDJOIHNKmOsngA
         ASmnuH4WcB7oeqZSo2PBYlIaQZza8h5gP8WGEkyYYaLRNpV/g4I7oHgX7WDTaltcSLCo
         8T2rofR4ME8QG9oAOqIob7JW3EDPn2OL+DYZfNb+GmCeGONqvbR3nqo48A0xF34lhazl
         2Czg==
X-Forwarded-Encrypted: i=1; AJvYcCVqYEoFNpKtGI35fXiYd1psJncajJ49LAkrQ15SN1PzJusKq47+DxYntTnhXVjSjvUwO9zZYm1lPElIXLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlnl9WuIGseUWQ2/aA8tsBWHLCaSmLw8ZhgYrRELwcl3gx8+i
	tKgCz7Dxakaz15v8Rgg2/47WKuE4XQyiywElV6womSdkeBGo6YSfatK63/KwstaWgCrdbXFVOCA
	1/Q==
X-Google-Smtp-Source: AGHT+IHDz0saxK+uDPiFg1p1YwHS66b4lZqXWidBMXMNqLNQVQfSJrHTu3y8P9oy8wEHlGtCW8YLz5mUoCk=
X-Received: from pjbsi4.prod.google.com ([2002:a17:90b:5284:b0:2ee:53fe:d0fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f06:b0:2fc:3264:3667
 with SMTP id 98e67ed59e1d1-2fc40d131bemr1894760a91.1.1739582084469; Fri, 14
 Feb 2025 17:14:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:14:35 -0800
In-Reply-To: <20250215011437.1203084-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215011437.1203084-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215011437.1203084-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: x86/xen: Consult kvm_xen_enabled when checking
 for Xen MSR writes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joao Martins <joao.m.martins@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Query kvm_xen_enabled when detecting writes to the Xen hypercall page MSR
so that the check is optimized away in the likely scenario that Xen isn't
enabled for the VM.

Deliberately open code the check instead of using kvm_xen_msr_enabled() in
order to avoid a double load of xen_hvm_config.msr (which is admittedly
rather pointless given the widespread lack of READ_ONCE() usage on the
plethora of vCPU-scoped accesses to kvm->arch.xen state).

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index e92e06926f76..1e3a913dfb94 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -58,6 +58,9 @@ static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 
 static inline bool kvm_xen_is_hypercall_page_msr(struct kvm *kvm, u32 msr)
 {
+	if (!static_branch_unlikely(&kvm_xen_enabled.key))
+		return false;
+
 	return msr && msr == kvm->arch.xen_hvm_config.msr;
 }
 
-- 
2.48.1.601.g30ceb7b040-goog


