Return-Path: <linux-kernel+bounces-203368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AB8FDA00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E351E1C24E53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B304215EFDF;
	Wed,  5 Jun 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjMWPMjy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4890161308
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627538; cv=none; b=q5fREHvIxr9eK7rjghE5ozWz30ZcABzV3fyEhaWYTYwXJ6F20LL7Paf/6kCHe9pfcwjhHCLx5yh5DKaWxdX98EcebuwZniJ4VzgXq2x4edtpfQf+oP8RPO/bq92KP81bGLp05D4SukkWzMhYijVCj5ls3P+l4LWQVuAIDuXVxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627538; c=relaxed/simple;
	bh=H5E6ncyGVW3J9VzqX2R9V45822GIjv50XU65bGoKJ5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qientdag0UumdtZPKQRi5CpI1m7j0YQEOkBzXDeHYG7vO5SDuIYcO7l0DSPRfDgRaSvTvkPHmzVofL/E1hmdVaDVoBFVb9OPxeBlDvjyFTJNEF/Y9HGKwwMjxve85wicOLzGo2SQxaxHRnkVvflYQ11fcovam5LVWStjoJvoTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjMWPMjy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c1a590cc96so278083a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627536; x=1718232336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3XLuxlT5eqMO4wpf2LjDOYZMmpN8g8ZUAPOiTDNZbfU=;
        b=TjMWPMjyb3/srUlSCDViWOkE2xGpIYUSAajPIHP0Sn+gXHSWNzNYy8zXMCIGEYEMUO
         S5DGdS/M0lWXU8d41CTZQmxv0kqN7iP+0sPgHHKfAI9eqLUwOpRMAVKVsjZEDiGFt8dN
         VKAZsN/fpucsKXM987Y451NlMN1idRJqjuzEVAqNyaHX7YQiubgtO/+ULFZ/O4J21yuy
         EKJRILolDi39VopYur5v4seA0fKtyWwdbWYrH93CsWKG+4HXwVv/ZTPlNSZ7/K4LvgPr
         urG0J/42MZiglkWIZ1y3PPOcKKme5q99X1sPLtdNXOJC+2NaAGc1dy7JW0PqFOSGey5p
         oMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627536; x=1718232336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XLuxlT5eqMO4wpf2LjDOYZMmpN8g8ZUAPOiTDNZbfU=;
        b=eDJ3/z+8qQ7hEol2/JdOPKu87ZAQke66mi0NDCO6Zge1l3mc3WIVXDrpOn7exF8u72
         2hoJZ1dcXNDmDjYe5NRdVR9XCJVI5jNMjRj3n1wIY7EkxxsqTm8Y1hYqr4QihHSs7j4p
         20nrjZmvCFTyGPT6bSavT492P12OP29I4vFFwKDXfmNFzVUHwnMjzitIzHqPwBtviVBN
         w1uA4cNF5ckfRaV3FeVrhyKm/rkS0NGH9MzYBebkUvvxtyceWcAXrvfq+6OZi9k1YlbW
         CUxDmulzwGguoex8U1LWdSw86vIlpjlpEtUK9dztU4inXKKPC3DMg/B0s02CIVtsdMhV
         aPbw==
X-Gm-Message-State: AOJu0YwxwuJ4jyXPl5n5IkA/arg8lwV9l8RyfU1tlu0YFUsmDdeqSlBB
	XjVJTwZ7vPj2sV07dz5novwPuDNTFGG4SR1qDYABL8vdROxsO70NjfUolxlSBnm2zGu/EMYIcpo
	Uig==
X-Google-Smtp-Source: AGHT+IFNRbxHM8LYlyjxSOmnMynhnUM2miYnMUrojEKxtDRrz4w8OkIwmY6zGHnWrGKQ5YQP9pcq0aVy2Gw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1205:b0:2c1:9baa:dbef with SMTP id
 98e67ed59e1d1-2c27db45037mr9944a91.5.1717627535864; Wed, 05 Jun 2024 15:45:35
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 15:45:27 -0700
In-Reply-To: <20240605224527.2907272-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605224527.2907272-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605224527.2907272-3-seanjc@google.com>
Subject: [PATCH 2/2] nVMX: Verify KVM actually loads the value in HOST_PAT
 into the PAT MSR
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Xiangfei Ma <xiangfeix.ma@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check that the PAT MSR is actually loaded with vmcs.HOST_PAT on VM-Exit
in the testcase that shoves all legal PAT values into HOST_PAT.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx_tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 8a17dd90..ef7e0ea9 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -7275,6 +7275,11 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
 					error = 0;
 
 				test_vmx_vmlaunch(error);
+
+				if (!error)
+					report(rdmsr(MSR_IA32_CR_PAT) == val,
+					       "Expected PAT = 0x%lx, got 0x%lx",
+						val, rdmsr(MSR_IA32_CR_PAT));
 				wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
 
 				report_prefix_pop();
-- 
2.45.1.467.gbab1589fc0-goog


