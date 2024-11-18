Return-Path: <linux-kernel+bounces-413297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D739D16FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9F42848D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7071C2DB2;
	Mon, 18 Nov 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXvSMFBD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766921C1F38
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950412; cv=none; b=BIRHreRGxgQ9n0UJfq7Vlx2he8n4xNXpNeflllWF/yk3B2daM6Jv4UJimzoKre0pcsgi8e7L1dOQK+MYpXfwoBWXbYYuOdf1N0rNPTVOSRKcKR2qnJxdTA8S3Xh9NPWdw+3w7utrdrC0VCvDOe4oMy6R7uAKX+Nx3SOG23YfWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950412; c=relaxed/simple;
	bh=N5R/4FtDw0N3yusA4O8BioFqu3X2Sgch3e5Yy83zhhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pLPCvydx+I4rOv0dkIKiCq3+67qQK8kDpt7pohLTn1YOxD7j5YYf55a2SrzX6BNzy0plM++ObVqNcmb+oXJt4H8jt4sOfJEABzRrRmx6k3aZWdxHN7fgQjDE91VEDD3xtXreMZxVHqXjpzD4+Iz4P9nPtU3bZrLWQrhx66iX+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXvSMFBD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eac7417627so1253487b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731950409; x=1732555209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sgtLcMTJEjPEalmZ9zl8RzwpzJCWvEmQXuhCm+oPkB8=;
        b=vXvSMFBDuY3xAtA2v27YHQv3eSELjF3DV5p1iDKR18ik4jqtAS30J7AN2+Ax0wAA0S
         3keV0FODykPFr4Ir4dK0dqujH0wg7N49Lve0bxWNSI6M534iobdVW2+IhwdYbHQAo6+P
         5allEdp4fljr34Cp5TCgclmzMGza6HGAl+nxi+Dbma75duTevg5pQLyjTfXwnd4kRPJJ
         LQ3VrjBbRTrfgFpzbrp9+SfExcx3kVNQxz14DSAu1jl/qp6LUyjFnxGElY+vPQIHlTSO
         xlDbYCiblFq+4ZE5bdxiW0N6dqhvu6pbslP22ft+H8BNby90ezDKMDXs+KecEOglye6p
         BS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950409; x=1732555209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgtLcMTJEjPEalmZ9zl8RzwpzJCWvEmQXuhCm+oPkB8=;
        b=H3mz3MpfhF3Tn4OssRnkqwqULT3exhzrNlwa1RO5B9VveoPPBvWZwSRlRJaM+cMWuS
         xNh1a8zhtVwUIXQL+N5N4vk/Cwn7B9ImpoJta94Ew2cVNOY0fpDq0vgzdNfRxObG0HmZ
         NDrUcYsItPAkyomfn6dLI+PFJvWTuspbIHA6fxTrqh7rwCp7l+6LtwrRWCFLbOGWtLD9
         ZNg5cktAMegLgvhbRQaclcuqt3rwcRaWMGzCWc5JCr05aNqI2HbSR8MTRaobajfpD7l4
         nHTIPqBXwcH2m/P2juKr1+VyfOislc+BhcGezkJLnycq+aoOESyAVeNonZfYqnffLGjy
         GXCg==
X-Forwarded-Encrypted: i=1; AJvYcCVtuVgw3IYEdG/yCV7tUUzSO+UlTvzS6UiNb08/HXTdjtwPGOr1gzOTYVXGAG+2hswG3wn43TM9rwHt/K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYqSQZZ9RtxLpJ/EQNWxXi8Ap+WhSZgOvGT4MqYkNOcgZKzlB
	3qE8Wxoq3az1Je8uSVNuamTlIvPYYzv6r4SqKL8us/N8Tf267UlVRR7V4vovu7WrW2OtJ8561q+
	b3A==
X-Google-Smtp-Source: AGHT+IEtVCOpP39tTFVwQnJjsV3PYNG2x18HZgOMURORvWB+91/HhO57tnwC7V9xek4bGfXWXJWZqLCV66Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:dc2:b0:6ee:93e6:caac with SMTP id
 00721157ae682-6ee93e6ceebmr2351967b3.7.1731950409577; Mon, 18 Nov 2024
 09:20:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 18 Nov 2024 09:20:02 -0800
In-Reply-To: <20241118172002.1633824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118172002.1633824-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118172002.1633824-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Break CONFIG_KVM_X86's direct dependency on
 KVM_INTEL || KVM_AMD
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Rework CONFIG_KVM_X86's dependency to only check if KVM_INTEL or KVM_AMD
is selected, i.e. not 'n'.  Having KVM_X86 depend directly on the vendor
modules results in KVM_X86 being set to 'm' if at least one of KVM_INTEL
or KVM_AMD is enabled, but neither is 'y', regardless of the value of KVM
itself.

The documentation for def_tristate doesn't explicitly state that this is
the intended behavior, but it does clearly state that the "if" section is
parsed as a dependency, i.e. the behavior is consistent with how tristate
dependencies are handled in general.

  Optionally dependencies for this default value can be added with "if".

Fixes: ea4290d77bda ("KVM: x86: leave kvm.ko out of the build if no vendor module is requested")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 887df30297f3..b91ec2e9c916 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -18,7 +18,7 @@ menuconfig VIRTUALIZATION
 if VIRTUALIZATION
 
 config KVM_X86
-	def_tristate KVM if KVM_INTEL || KVM_AMD
+	def_tristate KVM if (KVM_INTEL != n || KVM_AMD != n)
 	select KVM_COMMON
 	select KVM_GENERIC_MMU_NOTIFIER
 	select HAVE_KVM_IRQCHIP
-- 
2.47.0.338.g60cca15819-goog


