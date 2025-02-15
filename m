Return-Path: <linux-kernel+bounces-515944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5ADA36AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8D3B0183
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57813959D;
	Sat, 15 Feb 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/Chh4V1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F829CE7
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582082; cv=none; b=CGyT8bTScLApsDNsGk5OBwRoHAKoEUoXbDqcbItY+oBv7THTi4KYsNmMVG9/vjEsPKNgtfvwA3BxD+FxqfHBdIl8C37G4UQ+p82oYyMk14eC4JtPLMN9euDIR3pybbVMREqh7cOqI2VUe/zWAPrG3PAgoT4grBFtXGa7WHCNHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582082; c=relaxed/simple;
	bh=fXAP+EFhzTA0wWutw9G/BqB7OpJJNUcHbfw6HUvM/u0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QCe/AjIsTLnhH0SEH71GiBX8mi99N9Ei8jWg8J6Kld0+vAe/phESvtirK7Zc1qNb6ZvO3EfJ5aqvinnEGqyTcLBptWepB3/Q7O3QnwabqBbqaWYZ+OfHyx+UZc16Yeqo400pbytQ8BqUh+ru/FkECV50Yp+fcDGxrGo/hZusPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/Chh4V1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc45101191so78493a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739582079; x=1740186879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFW8HcMPEFBtu4QpEr86rSfrtjpZ1XO/Hv2S9x6GxYY=;
        b=w/Chh4V1OcgTXYzkhQop6nSdGibpqCorYCkWnTiql2j9CimJ7ojfP5o6c2zOcbUf9c
         KpXHlS1lYIg7JK/RONInq4saQFVVzd/EAz+YVv1iY7RyPpHk3bJ0iQ2H1s63Kc6xKfCA
         eHACaV3ZGyme5Vv/E1F4pUIg5M5xWjKXgHHHwM1vWNJupFInBppHddO/YRl2j0XuwFBx
         gEFkVkZwmpeFhkjmx+uURAi57RU9L147dHhN9QKM7N5MD2xhG/pEmINj7T5smaJwd0y/
         FgyLa/MqnYaxUzMlp6BCNVjPtXUoiqTdBh405eA2R/VhwWbw98jWTquEcsepCDsMa97+
         HqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582079; x=1740186879;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFW8HcMPEFBtu4QpEr86rSfrtjpZ1XO/Hv2S9x6GxYY=;
        b=tJTMkfHoubPzGwGc5223ugGwBBCrUrSadWxg9lGZxFikr3bK57qf29z4izn2GWYO7L
         tY6OEeiNJwgoPOrivI11tjTnvvanl0IwIqK8YNcfkChUetTzaWUF8NogHun5diD+brI4
         JsOR9ilcXseNe5Dzfs4UnTRo1iAFAb2/A3R4R2U3ZOxFmOl3ufwn9M6XUfuI+SABD7vp
         vunx0p7Ytsbj2nJrfpqHCCn5EfIQSFw96/YhIn72AI7owTLD/MY861q7gyeAKpG2Ier/
         l7S+wtdk7WWFN+bPrbTnIYfKud/klv5vMJmr6/B8zc3aoiLVr8Y2PXfvi99XerJncucO
         IgOA==
X-Forwarded-Encrypted: i=1; AJvYcCXhHWTNO6CcBtgMXbcugTv61MEcqNkBVVj9RXVVW2BJw4AuzMnl2bGGAP+UiNv1dNgkw0UW9vjZfTXSduw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTXXQfE+Txk2bSPty2XVsJdHJaGfBas1I8hvLRy03dXTOKiD2
	inTydhJ5LQRB+OeEWoZSeJzs+d4/U/XDK4GKSp6ulhZqsbNjZMGHqybHf7c1svMQqJFZ19JZbuh
	SJg==
X-Google-Smtp-Source: AGHT+IH3KMxbwmXsOp13PDSlvkQwNBb95UY8fwQIbGWuhZj5HiS3WvB0Cvx3flqG2Ernendo6FqCfQgrnW4=
X-Received: from pght6.prod.google.com ([2002:a63:eb06:0:b0:ad5:4620:b05d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a9:b0:1e1:e2d8:fd1d
 with SMTP id adf61e73a8af0-1ee8cc031aamr2720410637.33.1739582079524; Fri, 14
 Feb 2025 17:14:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:14:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215011437.1203084-1-seanjc@google.com>
Subject: [PATCH v2 0/5] KVM: x86/xen: Restrict hypercall MSR index
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joao Martins <joao.m.martins@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Harden KVM against goofy userspace by restricting the Xen hypercall MSR
index to the de facto standard synthetic range, 0x40000000 - 0x4fffffff.
This obviously has the potential to break userspace, but I'm fairly confident
it'll be fine (knock wood), and doing nothing is not an option as letting
userspace redirect any WRMSR is at best completely broken.

Patches 2-5 are tangentially related cleanups.

v2:
 - Collect reviews. [Paul, David]
 - Add proper #defines for the range. [David]
 - Drop the syzkaller/stable tags (rely on disallow host writes to fix the
   syzkaller splat]. David

v1: https://lore.kernel.org/all/20250201011400.669483-1-seanjc@google.com

Sean Christopherson (5):
  KVM: x86/xen: Restrict hypercall MSR to unofficial synthetic range
  KVM: x86/xen: Add an #ifdef'd helper to detect writes to Xen MSR
  KVM: x86/xen: Consult kvm_xen_enabled when checking for Xen MSR writes
  KVM: x86/xen: Bury xen_hvm_config behind CONFIG_KVM_XEN=y
  KVM: x86/xen: Move kvm_xen_hvm_config field into kvm_xen

 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/include/uapi/asm/kvm.h |  3 +++
 arch/x86/kvm/x86.c              |  4 ++--
 arch/x86/kvm/xen.c              | 29 +++++++++++++++++++----------
 arch/x86/kvm/xen.h              | 17 +++++++++++++++--
 5 files changed, 41 insertions(+), 16 deletions(-)


base-commit: 3617c0ee7decb3db3f230b1c844126575fab4d49
-- 
2.48.1.601.g30ceb7b040-goog


