Return-Path: <linux-kernel+bounces-349748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C698FAED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707EA1C23077
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8831D2B26;
	Thu,  3 Oct 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnj2GkHD"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE251D0941
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999039; cv=none; b=Rk+U3nBJzQdcGbQg5Zcunf0Zy2wFXhixIQVGCQC6QKzPjY4CFtNjsrNzFvSY920QL3tNi2SshHFLs8WSoiWUrubNmAL9E0KvRHdSBJAvQ0lBWGS1P08l2uqspcQ0845XvmY5IJb2wAI+XV6imPqooq++LsGbHNPWAc6wrg1zcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999039; c=relaxed/simple;
	bh=xqBlrWuS6MCxk0gww17oourN4jowUONsWvqCnk9wPn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/ydsmNs8wz0B+e7HKa1Raal4Iu5i1P6ZLvbEw/qFVmGdedz3xcT1wuqwYZfLfy2tvRXir6QcZu2JoT4ULYavV51jP4NRD5m3wqb+5PZ19fA5dW+qH1Og2Or9I7V610ozRXzBFElW79x3xWumTyhahgdznvd8xCNKAEI5U2EDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnj2GkHD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e08517d5afso1452858a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999037; x=1728603837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lHVxAupwVdLj9JS6H09y9gDY/v8cy7swDNQclaU5Fj0=;
        b=gnj2GkHD8H7lDTYPvn9kCqFhDvtxpsIaGjxuYiU9RxwrELTxOjmbGcSLg0lI3OLt5L
         Ul9h+sC8EK9sVF4hA0f1BiHB1Mmy8h7+CeEzHKOkyl1I9Eb7e9E+shTIQoLXZeNSt6l1
         fdOmPQ3mcZfdo5HGiIwbGIeetjrOJnwy9hh1fLlS05YBeGE2dwJFdm3AWQTsmARXlnBq
         Bogd0xGiLGRoFKJIlj7qpHfTOEhD4Eo6YZF3Q3hw5+Ao9tpEmmJpld8iF9KazCwSFiTe
         itkM3KiaX+xjwSzNYci0LcGcIuOK87kgNcraXB4kt60/O9bmXVJfPL0spN8Ei5l7i8Ns
         abNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999037; x=1728603837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHVxAupwVdLj9JS6H09y9gDY/v8cy7swDNQclaU5Fj0=;
        b=sCnmJiYnWmsnC61gh3tKtOfj6d0efeOa/EVeTJyOHpj08lf8ZAfAX0j/G9Af+DLe5H
         Fd0iGYy8jk9X/f8xYzNe+OZbK1oHka37xVR8se/WLqZEDkktB7rDGVnFfO2XMIWS8Svk
         42WyTVma7cOM6TylOMDxTuRm9owQRw4fWKWSXTvgR2HR3QrqTeAxOxXS0fMRoKB71bRp
         f8pL/QwxfuYx/vf0V4ALsOmByWaKsc380bpoVZAO6wYLSmrzEyWSJOAR5Elr37NbELW+
         X240kYx3JPY2Lya9RN2OZtT71S7XFsQNHCiOSbImMbUHsVmQnFyFSfPAmdORQre+O+PV
         NBDw==
X-Forwarded-Encrypted: i=1; AJvYcCV1G4gk+mFtrx5bjP2OMXM8kRJC6mMClmGLClkH6gRVk9ew+thV4bw/9xkdEIqXLCEVH6nFZLwxuFbBxlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCJ6nD/pJsupL/NHwYIB7lcKxppGUCmP3DwZqQppGhk4meaz3
	CAkShBjwMqg6kf4oyN85D80Lxvey+yV1+sGhXRdsg4UoVWxnvayy2pBqil92EB3936oNM04NhCH
	nnw==
X-Google-Smtp-Source: AGHT+IGKroOpNriNfmU45AkA6nSG4g4BolcTa1/5RFMDjU2V8x+RltKhqqMU4YNPO1VDq4XZodpXpHwhZw0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:17ca:b0:2e0:8e0f:7bfd with SMTP id
 98e67ed59e1d1-2e1b393e2eemr25111a91.2.1727999037305; Thu, 03 Oct 2024
 16:43:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:35 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-10-seanjc@google.com>
Subject: [PATCH 09/11] KVM: selftests: Drop manual XCR0 configuration from
 state test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that CR4.OSXSAVE and XCR0 are setup by default, drop the manual
enabling from the state test, which is fully redundant with the default
behavior.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/state_test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 1c756db329e5..141b7fc0c965 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -145,11 +145,6 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 
 		memset(buffer, 0xcc, sizeof(buffer));
 
-		set_cr4(get_cr4() | X86_CR4_OSXSAVE);
-		GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
-
-		xsetbv(0, xgetbv(0) | supported_xcr0);
-
 		/*
 		 * Modify state for all supported xfeatures to take them out of
 		 * their "init" state, i.e. to make them show up in XSTATE_BV.
-- 
2.47.0.rc0.187.ge670bccf7e-goog


