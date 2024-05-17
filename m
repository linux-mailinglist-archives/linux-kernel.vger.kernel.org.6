Return-Path: <linux-kernel+bounces-182455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F364C8C8B75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8E31F28B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F613E41A;
	Fri, 17 May 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHQekZrx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588414EC52
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967629; cv=none; b=ECcUbX1Fe2MRX7rbIUItq7+C1Dw6rd9RRmXQjpaxUp7arT4Bo3uQy1j0gUhaQsugnTMTE+XKzQbFdk9+CEu9UQJUePWMwHARZnHeUpyn3YF4kRHVF1aQlqSvTGYXRfr2ME5jPEZVzZT+izALPDufeVhtmmOYjhn25MplxrD4un8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967629; c=relaxed/simple;
	bh=p+s25bHf2EL3yVmaIP6rEQRJIA0++AOT0hqByZcz920=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XvBJOZvkJ1648wi9+oIUuVNUwfxRFp0vI3UPNYtwMMLtcETwFNrCRDupabg780x8yTVloV0HAy8ZsCA6ShxE1IjrQZxY/Q6n7Fpfh3wco1meVzOlyyezvX37nAbl+V2R/WMsjUIhoginAvmCSsTHKLyQ7vHKP9gT5upqLlHamYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHQekZrx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6256bc244b7so35004557b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967626; x=1716572426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3RmsUK0qxFawZDDL6v9ERsQJ0pa1o6uqtR6Eh3hXII0=;
        b=rHQekZrxGVM9GBf8X1HRb/sw+XXOjKLt+rHEWoW1VQmSeS1QJs6x6I3fQALLx+IdbW
         Np0NTAT+++XYshAP1wC7j3ByQ/QupmCcHtON0Se201MipcwD4to2us82LojJ7RSlt7rP
         UO7YMuCdpcN/l4rCxl+tkRxoNx+MXVxcT1pRu/W/T/f/UDJh6Xj79Ont+rdURV8gGiic
         GWy68xEKX3a1qybBc2UO1djY6mvidk/W8HxwSHP7u1WfgyRPYYHhC+xLa4alvMW4/+x9
         bB2ylfodQbU3VSReIY60MC6f7PJe+av5z5FD61ljqGZKna/jESh+jUsAnua4hVstQBXd
         sfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967626; x=1716572426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RmsUK0qxFawZDDL6v9ERsQJ0pa1o6uqtR6Eh3hXII0=;
        b=P6cnBzef3IhGQmjEXgZU33weWnmISsYtCOUo5kKXm/DzGSiSo2W7HUZ309rcQgyUnS
         WQ9s8YOGfLAwChjMfAQkaW6CcecieIXR7CrpLvzu5e6fPGCOoOsBkb0HaPmCX8TzQeej
         djHyv60eUptCN/CIRM68STu7cv54eAydZlgAT89xqBsPOgTdmTZ8zpDqOu4SasyS70Da
         wslR6O6j4jdasEhCIWWSsV6ce7xcWq9IO5K/nXajQr9ZLbKPIcN+itaQJGeMCyS9iRla
         37++mcICcD4BHKqfaQtkHWQg5lAphpYkv8BFc7YJUnif0ao7E921J+Z7QsMd2nNNPinh
         MiDA==
X-Forwarded-Encrypted: i=1; AJvYcCXV/OHbmvX6fX+K87KS3VnSwNXhVOEVon/D95ggi4RyY34kJInlM64++HD6Aalo6HMlxBYOwEPyyAfpf6ubtgkxZ0FMAh27RLcWyG44
X-Gm-Message-State: AOJu0YyotS+5IYc5jpk3MNh8cddroS7uuoI8Uiie7HyXfh1p03kEQTEb
	hGXMiRlEKEu6kSBztCSrfEvaafN8lKIc+FxuIdf5c6xKU4dQgGPx0D5M9ZH9kPe9hp5AmI31Z9u
	0rw==
X-Google-Smtp-Source: AGHT+IHC95oqnzGT3TpTixp7JrmzjWIq1Wgww0oHz4lhG3bou5Kk5QFkbCjKQNY2s5srpMsTTYFRu8w+RsM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6202:b0:611:5a9d:bb0e with SMTP id
 00721157ae682-622af90c63bmr59756837b3.4.1715967626017; Fri, 17 May 2024
 10:40:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:59 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-23-seanjc@google.com>
Subject: [PATCH v2 22/49] KVM: x86: Add a macro to precisely handle aliased
 0x1.EDX CPUID features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a macro to precisely handle CPUID features that AMD duplicated from
CPUID.0x1.EDX into CPUID.0x8000_0001.EDX.  This will allow adding an
assert that all features passed to kvm_cpu_cap_init() match the word being
processed, e.g. to prevent passing a feature from CPUID 0x7 to CPUID 0x1.

Because the kernel simply reuses the X86_FEATURE_* definitions from
CPUID.0x1.EDX, KVM's use of the aliased features would result in false
positives from such an assert.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 5e3b97d06374..f2bd2f5c4ea3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -88,6 +88,16 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
 	F(name);						\
 })
 
+/*
+ * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
+ * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
+ */
+#define AF(name)								\
+({										\
+	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);	\
+	feature_bit(name);							\
+})
+
 /*
  * Magic value used by KVM when querying userspace-provided CPUID entries and
  * doesn't care about the CPIUD index because the index of the function in
@@ -758,13 +768,13 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0001_EDX,
-		F(FPU) | F(VME) | F(DE) | F(PSE) |
-		F(TSC) | F(MSR) | F(PAE) | F(MCE) |
-		F(CX8) | F(APIC) | 0 /* Reserved */ | F(SYSCALL) |
-		F(MTRR) | F(PGE) | F(MCA) | F(CMOV) |
-		F(PAT) | F(PSE36) | 0 /* Reserved */ |
-		F(NX) | 0 /* Reserved */ | F(MMXEXT) | F(MMX) |
-		F(FXSR) | F(FXSR_OPT) | X86_64_F(GBPAGES) | F(RDTSCP) |
+		AF(FPU) | AF(VME) | AF(DE) | AF(PSE) |
+		AF(TSC) | AF(MSR) | AF(PAE) | AF(MCE) |
+		AF(CX8) | AF(APIC) | 0 /* Reserved */ | F(SYSCALL) |
+		AF(MTRR) | AF(PGE) | AF(MCA) | AF(CMOV) |
+		AF(PAT) | AF(PSE36) | 0 /* Reserved */ |
+		F(NX) | 0 /* Reserved */ | F(MMXEXT) | AF(MMX) |
+		AF(FXSR) | F(FXSR_OPT) | X86_64_F(GBPAGES) | F(RDTSCP) |
 		0 /* Reserved */ | X86_64_F(LM) | F(3DNOWEXT) | F(3DNOW)
 	);
 
-- 
2.45.0.215.g3402c0e53f-goog


