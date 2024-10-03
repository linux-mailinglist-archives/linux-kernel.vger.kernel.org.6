Return-Path: <linux-kernel+bounces-349746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C598FAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D906F1F21C22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333EA1D278B;
	Thu,  3 Oct 2024 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkK6Yrrz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E61D26FF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999035; cv=none; b=rF8zmHfGHNA5Qrl+0M4kcBXvHfSmCzz8C4Crm9xFKPtTdAiqjgwWHCmDe06sKQp5gM5jTZi+FetlgfBb1lJYQLdVPXStUg0AmmsaX3dCC3n7kkI130UOavE+ahCYlM0ScNBBJ83CIguU6BhWLTtuEJI+vEwp3A0Kay2DU6cIiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999035; c=relaxed/simple;
	bh=gl0Wr8APCYJH9gb2faxHbvqjAXiNHTO8/OWXX9MH4KA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DslmBPC+ofA4uvLDFwt2IL882RUa+cbPfyZ9Pc5V29bvPQDiJPQkw/8Fo0lhtL9YQ3J9w/MyEuB8i7HZAJwpA08EkfMxp3DAN7jPDoCFlEALSosXwKKpOe/MM+aMdk3dY0d5TvJfiAnu9coG2kXs0DncOdO8rKP5OCAvXwrsuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkK6Yrrz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d8b4a23230so1610273a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999034; x=1728603834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pDkQ3m0IH+ik1cLm4fl5hS775lZs/1BFcA2J8KjREsM=;
        b=ZkK6Yrrzcn5MfWOaz2j/G79z3a0O7N77tqsV2gqSQ1IEHGO8QRlz/rYiix7RbeJY6e
         srOmBqDMWy/cgBiBmBQzjA6kaLO4TI33Hj8UBvI9UCCyulD9dH1EGF3pcIra2/j0q6y0
         Ex3tzHTwzItdIQgPC1+weYLCW3WmOUdo/BSt5vNhNFWy4nSHQ8NT+olCJGAtTmhuYE5B
         uMP+KAWXPQA78QW4T6cgc0Q4gkySjOTzSVc8Bg2gsywbstg3hTHum/pyxNcKm8j+fV4L
         111GihK+l2POzkKIADWCbw0FYZiSK10h939Ae4dA9eTVy5Y4sNNZDysnuwNyEgz2MXkU
         xa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999034; x=1728603834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDkQ3m0IH+ik1cLm4fl5hS775lZs/1BFcA2J8KjREsM=;
        b=sxn7ksaVzvWPX3wI/JnWpS+rk4TrwBGw5+rn/i9xPNXJr/Xnec6FBQJZGdhWngMcF8
         10ggHIWTQby/rcaOcAUHI4xsh3U2n9NqfVgPW5ewrQO6utDE+VcnMXsiSwCHJsGP5gKq
         TbGAugfSu205h+7ryNhAttppq5MkirsWFzhN+x32rMAvLF0UbGdpG+FmMAWhXlxyA6oL
         hUKZMW9CsGvcu5u7BbBMtmcsRzkZjbx+80axaLXuwLyDTTeLk3Qj8+4YrBIOeZRrjfhK
         qIvOQvHV1utcKL4PYaoIquCJv1Sp0WIu7MYEtSbyk1tYtQnozf+BE/aV4Z70g686/3hk
         oFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVby4bYOVsFxmdDwxuCCiif6xIfPMhniezXfr6yMU3dWmz7Tz8v/zD2FEchPUO5d6Iecynl7vI1+zp0h+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFBuxCMC9eaboxGzuvewmx0yWlHx/bw9pkRgdBlIe/JUN/+vF
	A3dVDkkc2bBDRip/rA8Ir9v8mhQzNW19gcmlHQfP1kC79AVM45bqFM24R9QdrEnQYH6r96652g9
	fEQ==
X-Google-Smtp-Source: AGHT+IEPUf60YVy3+qxeYEMLExtz6vIBv7c6bd/YO+J15uqPf7aKwNWa1u5iohopHmwKZq52HVRfPFla+t4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:156:b0:2e0:876c:8cb6 with SMTP id
 98e67ed59e1d1-2e1e620c428mr2878a91.2.1727999033692; Thu, 03 Oct 2024 16:43:53
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:33 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-8-seanjc@google.com>
Subject: [PATCH 07/11] KVM: selftests: Drop manual CR4.OSXSAVE enabling from
 CR4/CPUID sync test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that CR4.OSXSAVE is enabled by default, drop the manual enabling from
CR4/CPUID sync test and instead assert that CR4.OSXSAVE is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index da818afb7031..28cc66454601 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -27,12 +27,9 @@ static void guest_code(void)
 		[KVM_CPUID_EAX] = X86_FEATURE_OSXSAVE.function,
 		[KVM_CPUID_ECX] = X86_FEATURE_OSXSAVE.index,
 	};
-	uint64_t cr4;
 
-	/* turn on CR4.OSXSAVE */
-	cr4 = get_cr4();
-	cr4 |= X86_CR4_OSXSAVE;
-	set_cr4(cr4);
+	/* CR4.OSXSAVE should be enabled by default (for selftests vCPUs). */
+	GUEST_ASSERT(get_cr4() & X86_CR4_OSXSAVE);
 
 	/* verify CR4.OSXSAVE == CPUID.OSXSAVE */
 	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
-- 
2.47.0.rc0.187.ge670bccf7e-goog


