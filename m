Return-Path: <linux-kernel+bounces-349747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF898FAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297401C212CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5271D2B12;
	Thu,  3 Oct 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2yQJtIB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E1CF7C9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999038; cv=none; b=o65QxnXhcHVS2FtXkUOp0Uoc5D7X9X5J/dVA/E/i4PLznME3By/FS5i6Oa4ewxr09ePHYtUTGaXeJycGz2I+ctwY6S3W2dmsY53Dfqnf/VfPSQV5L/oRdDunvnOovVLvfXb5IKpHEhDDa4LEQvFm8dD2RBWa635B8YjehLvdBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999038; c=relaxed/simple;
	bh=V7rKuwPrSY+SRxJi0K7vLggqsnLA/DoeF2YXdfDToSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DuSIkTZCqezlJ23mt+ScSscmJS+M7UgT9SdDAX9NFHiQMu/8yKzdPeVizSR5DTOofsDoUVGojd9+6qkGYI/UjCKAkH8idSXbkYXE5PSRgpqzG9za5QkSJzCNsrXVgIINgLHpOncWmY8dsahmRPvBYbuHRWZ33mznhCfy34FkY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2yQJtIB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2acec0109so29599207b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999035; x=1728603835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cYdreTQ2dGWT694xFw76MeJwXKyqFrydL4ES/jVoY04=;
        b=l2yQJtIB38Znd+mhBEM7C0hGpm/tqgYVtznuP/a3WnRKKT+e6oR5VlTiaBM4OZWw48
         o3q9FqDgV/hDqNJUNqO/FuT9xKH/DQkrhGTNUBYLIsTcBTaTz4kEsrB9PriagXNeAWqT
         UIXG4QRTRu/cUIGp9UUFAtLXuxY3CeayzuA+t3AOgPmICPYAXCOXjpTG5LE9qMUHHT2N
         NaO7RfDGXV75r+T1wBPog7Rnnp77iRIWAl6d2ck5q+1dyMi6cBmjt47I+j55TEzrW7Y/
         PxVK/TzBxq+oIKa8xgiEtYf5zogMQnjXGEjOGhXs2bkyBp9Mla8CSX/OBlIA54W38RlA
         AaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999035; x=1728603835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYdreTQ2dGWT694xFw76MeJwXKyqFrydL4ES/jVoY04=;
        b=vusq9PwzqDc3uPQHvjlmAbL93yv4X44wBWrfNJhZG2shu1t4/CJbNbZT8qaQkxKO+b
         XFindTo/HUXa4BMm8Hu0HSvjLDsK/b0WeSglSXDgW8jIH8+qViz8lvinbeuwyJJnbmuy
         xpMH3yiCQEIlK0eXxAf1T57yxJ4R1x8bMlBgckSwoGK1wxMQQtnHNcdKky/NNeVpql6u
         3DWnuPPvhe1tLU1PJicgwR71DNtGz6lfw2fJdCYtMf95f9T8r5Ddc9l+8RjWbgPeWlNE
         Fhgz3hTR44Cp0KoHIe0tgl5qRX0ZUEmwh7xbVk0T7YEzJlRyULMfLORN6hpoDKhpYqVk
         DpWA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kIuYGNq7LzSn8H6JP28Dyt3lJcqC9VS05ZnU/VrngptMboNbxk2is0rqebqjHpeN+NKhNOdnyHK2lB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzEERXcBzbQqg9w1Dv1nlYKJ3zNn/XwNfNU49sIUoUSG0PmwDN
	9HdRLagTncwIqPZpaGevdaEFTkuBt8B+YJSGADgccwP9gwpojZIYPprdvhtGq94GURy2n4a7RWc
	eyQ==
X-Google-Smtp-Source: AGHT+IEd91DInd0W/wFySOQh235Qh88p94i5fGTLkUED1r7q1hClizhaqe0VKQW4C1DefHLLlGROsyVnmok=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6a0c:b0:6dd:bc07:2850 with SMTP id
 00721157ae682-6e2c7295006mr136787b3.6.1727999035387; Thu, 03 Oct 2024
 16:43:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:34 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-9-seanjc@google.com>
Subject: [PATCH 08/11] KVM: selftests: Drop manual XCR0 configuration from AMX test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that CR4.OSXSAVE and XCR0 are setup by default, drop the manual
enabling of OXSAVE and XTILE from the AMX test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 23 ++++---------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 903940c54d2d..f4ce5a185a7d 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -86,6 +86,8 @@ static inline void __xsavec(struct xstate *xstate, uint64_t rfbm)
 
 static void check_xtile_info(void)
 {
+	GUEST_ASSERT((xgetbv(0) & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE);
+
 	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0));
 	GUEST_ASSERT(this_cpu_property(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0) <= XSAVE_SIZE);
 
@@ -122,29 +124,12 @@ static void set_tilecfg(struct tile_config *cfg)
 	}
 }
 
-static void init_regs(void)
-{
-	uint64_t cr4, xcr0;
-
-	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE));
-
-	/* turn on CR4.OSXSAVE */
-	cr4 = get_cr4();
-	cr4 |= X86_CR4_OSXSAVE;
-	set_cr4(cr4);
-	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
-
-	xcr0 = xgetbv(0);
-	xcr0 |= XFEATURE_MASK_XTILE;
-	xsetbv(0x0, xcr0);
-	GUEST_ASSERT((xgetbv(0) & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE);
-}
-
 static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 						    struct tile_data *tiledata,
 						    struct xstate *xstate)
 {
-	init_regs();
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE) &&
+		     this_cpu_has(X86_FEATURE_OSXSAVE));
 	check_xtile_info();
 	GUEST_SYNC(1);
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


