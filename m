Return-Path: <linux-kernel+bounces-299501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934795D598
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D15B1F23BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03891193408;
	Fri, 23 Aug 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AB7cH2+N"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55688192D67
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439237; cv=none; b=g4IwJMQ3NrJt4sUm3Aaq6s42qsSUyxWoKwX75DNl0qTxlqIWLTd4A+b7nf9fHbYYzOckJs4mUtTFaHpa2c7kY5vYo8uLdLLFyKDc1a1fbGMCIS1jx0a7G8JohODH32oMwaGA+K8INNMvafqVZXzF5EkgeBW1FIb/AAlcIH+IqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439237; c=relaxed/simple;
	bh=NbZ6C/T+ZCVhDcFWCkfg5AfdlArNrEwsL3Hq4JGm01U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T2AXjc9lCC5cTgXJvd6s+a0JR1nQDeA3UFo1g7MKLN3nZVhsMbcNX5k0b2Mx0VXKg/nsusr7dcPqmXitZs77UtKqHg6C7fAgHtj2mvdjt5hhDUxGsNqH4S+0dyH1Fo9/mkOfLI0CsKkqzAyEuD0bOJDHuJVqSAWcfcE+Hx077u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AB7cH2+N; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1653c8a32eso3721220276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724439234; x=1725044034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZhuyhwkXzq5TLpNWTsJTlY8QsgB091bBfZe2SCWV7A=;
        b=AB7cH2+NFVAmFBTOcluuqyZUyS7gRY/HCenqd8+oaI/JRk/JmzPey5sY3ux4lvZQyj
         iEyK0SKHNSWvk1+TyWSLsL0zPRoaXiG5VWzxLDf1aTlJKBJ7Es8FGlAIhjiF/uf+xERj
         9RcaAAgZMOv7QvMYgsZD95jZGqgOSNjxPKoTmrjdF4ri2ZqhqPOYfZ1jM2b5gQTx2F7G
         /y0pS5TzPhuRg92vEZBYkCta6uTeGesplSjaAU18eHLnmrNKMYKRnx+aFzfD3+9th0fk
         L6aH9IGrTTOWFF8PMrtf9cbgeFD4euuGHqLmF61rpF0yeFSEnQc2/1IQKtSnyhK1MSE5
         zqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439234; x=1725044034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZhuyhwkXzq5TLpNWTsJTlY8QsgB091bBfZe2SCWV7A=;
        b=Y9rs8XHWAJlQjf0VUEx7hPITXs8h8seSeAcuuOac04Ff+wD8krhlPLTSXuDvuMZOOY
         Fzpc/LA21IsoxHgsh89aAyFbcATozIwzKWkHEQPe0jqPiznH6SodkZZqm2TBBDRnYvY3
         a8NIlMjgPFp8s9WKKigojU8SJn32gcACOQMumL9iC7fmuRH7LClVdBNkcDG9WHRRv84P
         1qUqvihecly9GWfRDqJvbl32vX4cfl3Oei0M7s0okTv9w/gSkj4Hlg0iSaosgstmEAQa
         7ZsbB5JBBW3vYFYJcB1yBoleOkyozDkzOVQv1YQZ1VG+AnB4jRtPkfShOo/4o+EdO0wk
         13cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCmoF9vLlbHSPmcom1k+tc/bdgKEcDKe4Bco1X7XqARWyykR0GzELJkWiYuTaYqG8UN8uVgLJHIdnx2Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSa77OLhmEhs1roaEkp609yPl6f9CxcYSo/IV5Fl8e9C0m0gCo
	4S5xiWg3zZUUdjaodAXM7orX2pGCKQCmJJx4hpG/59Fu9HgaXtQevyCG3hnszrz4dUmJHBG0Auk
	rmAwNKzDhTQ==
X-Google-Smtp-Source: AGHT+IEypgUJ5wnYpxkM8UoctfuiVZ7zGv0wV5gsWQk1EXSBHETI8UYVQUPub68MaSVJRIAEV6qFA/ajyKJHpw==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a25:bf91:0:b0:e16:67ca:e24f with SMTP id
 3f1490d57ef6-e17a865aba3mr4635276.10.1724439234156; Fri, 23 Aug 2024 11:53:54
 -0700 (PDT)
Date: Fri, 23 Aug 2024 11:53:12 -0700
In-Reply-To: <20240823185323.2563194-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240823185323.2563194-1-jmattson@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240823185323.2563194-4-jmattson@google.com>
Subject: [PATCH v3 3/4] KVM: x86: Advertise AMD_IBPB_RET to userspace
From: Jim Mattson <jmattson@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

This is an inherent feature of IA32_PRED_CMD[0], so it is trivially
virtualizable (as long as IA32_PRED_CMD[0] is virtualized).

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2617be544480..ec7b2ca3b4d3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -751,7 +751,7 @@ void kvm_set_cpu_caps(void)
 		F(CLZERO) | F(XSAVEERPTR) |
 		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
 		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
-		F(AMD_PSFD)
+		F(AMD_PSFD) | F(AMD_IBPB_RET)
 	);
 
 	/*
-- 
2.46.0.295.g3b9ea8a38a-goog


