Return-Path: <linux-kernel+bounces-424132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41D9DB0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C371281ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614A823D1;
	Thu, 28 Nov 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kj57NTTt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90530199236
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757708; cv=none; b=gw9wzWcwITVGxnubTEQs3ZhY443JAYLF7UgKziEy9HfiZrXui/IxvjfzxBUETW50besMY9DAHRMOUsAEe+9PnYwsEja9a9F4XEOkvjJwww5i/jkcDLjbk2DBrtzIPmJXNEBpKgegGX2S6BkY6SJfG0eOOSQctVnaNTMz1VPSquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757708; c=relaxed/simple;
	bh=2Q1kVrEyCnyB3DjsUNAWh7he2DHh+lSAwEDhcvm0RHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMBp80tG/j49y36C1ibuvS9zb04Cc6TNagy/jLDjB8twl0kBpYlvGtUtahMs8BcHoMaYhmddYwviKgHBW3LuRW5m8uf2x2jBnRPpeN16np8XExNvd220mPqe+hK93WdIItMpytuQ4GV4ujRgvdOwlhv8n8QXRBAIgQFUYev788w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kj57NTTt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so286647a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757707; x=1733362507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sl6X5b0bxyRkVbn+G689ru052xqCH1IMhImemP9sZRw=;
        b=kj57NTTtd3xPYX+QUmYbH2dI45xf3uqtFUw1jR6NPFywnkEB7qMJbZCvFH/gqRjTIR
         uudzROw7hTQlYvVQcm03ZLm8SN+nQIgOyjo7xoNCxj5qJOgEXynyKGMJWuLwcjkdjPww
         XXEO9WMUWZM2OwQqpy9q6ZKTUtSkAVJYM9zmXoWsLXAxeO6V6zQOfZ1uuGdPfsRnifPv
         +Vci9jN/8DMrwTCf9Aiw8l5JXkFCquf0HHZZks961rla/B3qX2IRTn/niNp0RlrnVKlN
         J0ETxJLV6VvSUGRrW7bmFkspJwhqmeIZBjHqm9j+zeEisnYeVtpcnF5xX92Kkp66vpnf
         qheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757707; x=1733362507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sl6X5b0bxyRkVbn+G689ru052xqCH1IMhImemP9sZRw=;
        b=ccOdJ4/WLnKceajPpxhcNbTJa9bUAVZuPI1mDvZb5moDc62RUUQfcBKLcQ/3ZkkN2d
         x+N5Y1kpBsC4mSM/gzcSrjJlNHmKJHMkuWDpXIPIOS5n7YC1z6lYt4MjbHMGOw+QQOgu
         dtHy69il5AcdruaIS7hUCTLrbfMQWg+xarlHEAJTyByM+1DJ+22mLABs/4F4CbEv4Cg8
         2KLlgs9BdC5ByNYDLvhw0mjJoFMjhKoWrbtD5R1P6H50x9tuQROMKXaVVyOxB/4SJdZv
         FY9sx0Zl+cVTF59kfvk2IJoegsTtBTTstBGRnT6oSVQyxPIisG/vj9QV2e4tSwi5Jzxl
         Pkxg==
X-Forwarded-Encrypted: i=1; AJvYcCVRl2MYbmoqSdFB6xogYV2O9Duu+OGmaIHY81Dpx+yzJMoJqF7Ndaw4MR3lL7hIoa1+0u3u4vZHm6UbFT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWanySVo+rZjkqfftjV+uDnR6HzRfUPQZWN6MZrR9NzXOde560
	3azVKGXZWDhBzsKuhGp8HdYY14XbH50x+3fSk4VwfCoMmqU9qlVKd160ILMoGMy9XU9sy11P2IB
	Q9A==
X-Google-Smtp-Source: AGHT+IFDjKtecjGMKpdFToT37L1qnVgC6GL8sx1BJdKN0jqOJokIXOGEzKpUpCWGpaEd4aGPKFnXmjp1aMI=
X-Received: from pgg4.prod.google.com ([2002:a05:6a02:4d84:b0:7fc:2241:1b32])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2583:b0:1e0:c8d9:3382
 with SMTP id adf61e73a8af0-1e0e0b8c5d1mr8141450637.45.1732757706780; Wed, 27
 Nov 2024 17:35:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:47 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-21-seanjc@google.com>
Subject: [PATCH v3 20/57] KVM: x86: Do reverse CPUID sanity checks in __feature_leaf()
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

Do the compile-time sanity checks on reverse_cpuid in __feature_leaf() so
that higher level APIs don't need to "manually" perform the sanity checks.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.h         | 3 ---
 arch/x86/kvm/reverse_cpuid.h | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index d4ece5db7b46..5d0fe3793d75 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -179,7 +179,6 @@ static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	reverse_cpuid_check(x86_leaf);
 	kvm_cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
 }
 
@@ -187,7 +186,6 @@ static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	reverse_cpuid_check(x86_leaf);
 	kvm_cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
@@ -195,7 +193,6 @@ static __always_inline u32 kvm_cpu_cap_get(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	reverse_cpuid_check(x86_leaf);
 	return kvm_cpu_caps[x86_leaf] & __feature_bit(x86_feature);
 }
 
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index e46220ece83c..1d2db9d529ff 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -145,7 +145,10 @@ static __always_inline u32 __feature_translate(int x86_feature)
 
 static __always_inline u32 __feature_leaf(int x86_feature)
 {
-	return __feature_translate(x86_feature) / 32;
+	u32 x86_leaf = __feature_translate(x86_feature) / 32;
+
+	reverse_cpuid_check(x86_leaf);
+	return x86_leaf;
 }
 
 /*
@@ -168,7 +171,6 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned int x86_featu
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	reverse_cpuid_check(x86_leaf);
 	return reverse_cpuid[x86_leaf];
 }
 
-- 
2.47.0.338.g60cca15819-goog


