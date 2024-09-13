Return-Path: <linux-kernel+bounces-328644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB19786D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6374E1C21E96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4A12C470;
	Fri, 13 Sep 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4m3+MVz"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9EF126C01
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248776; cv=none; b=tb7OKT8XhhCNLetpShbsbaAV3n5FHpPK+qcBRiauajXJKB4haMERWtDVFtlLxtf7BgBxObf+vXN+nkecJFYZqtO89AZq+2kRVQ5PJ/U2mPwRBMVTUhYk461wKNz/UVGFLNZoHJbQY0BiOuPxnBRz9gNmzhLadOPZb0pLqexaOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248776; c=relaxed/simple;
	bh=xjay2CBwiCBq12bGlndFnnErz6A9u1ntnHfvd8gjIxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AfBbA6k6uSgUstj427eSf6r0Q7v2F0J5j9GRyIsxT0XbZP8rRaG1FWkZCTe71XTxABMNpOQSNw+7U4rPelgsgm5xwfeTRUx3kVAoJwRqSm5GIjB9McDHAwuUjuXop43EP4MC0I7lBDNwq/uhWSveoja6/EYRPoSJRlcQO8nfl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4m3+MVz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d9e31e66eeso31792547b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726248774; x=1726853574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3WawTJXscEZHW+HHwjyEYFYW96KcqSVaobUybf0kTc=;
        b=g4m3+MVzeTgN/iLC2AEsSuQ7xIHfGV30ls7b7F2heHALW/zioDMSvHm7WWkK4FLiZW
         0WbSBPLYESKeMmONW6jrjs0oKXKxXx38jbHJYL0ZFQe13uUP0U8GUIqaCzTH2y0fgPDu
         b93ubuiX280MHKu5YuOaz3FXCMo+qWPJ6PyK5Jj2rWVXmR78sHs0y8x1T/F2GQEO3a0a
         J6YYRLe3cIzgmOvnVQXXH0Ir9AzXdjLLK9w06EstozKw2uNijUMh/2QO4ImFgI5Jp+tx
         9RLoyGJS4sBmJ9StXxEtjicn2u29vvuxPeP8fSa87mbcNg/y87P+nP2idKws+lYC4yFj
         3Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726248774; x=1726853574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3WawTJXscEZHW+HHwjyEYFYW96KcqSVaobUybf0kTc=;
        b=YHrUipg7/TvF0gLoiwsHsTORVmviFyz96Hx9v8JuTrs1hcuN1nU+C4nNVKsAfhZQFa
         L/shvH/uQ2/MQwdb2fMA8KwfN7DGxuqv5b/TmxlFzRyi37ZK9RCsiXlxrH0fybuUmW+X
         xB7w1eNUcdgTlbSQCx0DufEqUCRB1fFOWsij+hltvR6I18Z4GeAhvTPTPoARpmDxesw7
         qv+1x1kLD0xLyz3uNaUIsuSo8fzf9DAsXqOrO6333MLcWY/KHrno6tgp/lV5ZYW80t9l
         +YxHEHCJ2lFMVjI+ldA+UORcs7q3dlkPfCV7Dh71SMTgKZ4jjN/NMVYMg9a2Hp9/NqGf
         Bbpg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhnnM4xNLyifDQJajW12IoGstaGgaxDeUr/6mh+iRLsR7l/cu2wIyrEuySRSsoSBck+a9JrM29MKOlPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/09C0ylBlBCfFzs9iw05z8xCxudTnV6+/zif3apDAANKQ8HK
	1vvRI0kAZCj7FAGi6NrGv1tBTXWP//l9F8BVHTZT5I5y7IFjcULRbJKMxbrKA2CHcdpm/2G85oJ
	HSUdgR/vmDQ==
X-Google-Smtp-Source: AGHT+IH1DurPlTxXWjA3nswyL98NGzJfftHUY2cOTogCVmKjqUSTXxMzYDUdelJDMpXHUhHOWBbACI4EY1DVmA==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a81:b049:0:b0:68d:cbd6:e28 with SMTP id
 00721157ae682-6dbcc579af6mr673767b3.6.1726248774214; Fri, 13 Sep 2024
 10:32:54 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:32:28 -0700
In-Reply-To: <20240913173242.3271406-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240913173242.3271406-1-jmattson@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913173242.3271406-3-jmattson@google.com>
Subject: [PATCH v4 2/3] KVM: x86: Advertise AMD_IBPB_RET to userspace
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
2.46.0.662.g92d0881bb0-goog


