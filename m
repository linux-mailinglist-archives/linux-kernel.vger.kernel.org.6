Return-Path: <linux-kernel+bounces-182500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13418C8C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5EFB21C02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678B13E02E;
	Fri, 17 May 2024 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Knkm1XHQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9413E411
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969028; cv=none; b=DYqDU+jpxZG7V197XRL7X/cipuhE5EPmCHX7gaPyLZfMtuwxgaWeqLFTPJBtbrrXGJARJdbOX6pwP4EHhP2olDpqLdPntkJNmypMUJj4zBPCo4Pu/ZMFvrgq9EMoep2N9mimzEpDIsDl2RMJAsUYr0IYJ8wCcpuAvaq3FeWmu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969028; c=relaxed/simple;
	bh=e5qiKadWZo77LQN+kQyEGARAeYAsnzqKPBmd3wtpifo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M6oUQNEWi7j6Eitm8I/P3kS9ZlZCqW2qUV74OwaqDNoa8IURFw9XgDuPBtZeOqIHCHycgLVJsAkUrqHVy26HESNlyyks6MCJL7mYkLcqEio8GBq/xI2JkoAC68WaqczS5tZxoyFiOFXMEGFbLkKtrJ3yqsHMamEjuzFFx8HVNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Knkm1XHQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee5f035dd6so13485452276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715969025; x=1716573825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYJ0cnc0Zl4FGmkoO88+7b2WvQHMce7LkfnJgQxYQeI=;
        b=Knkm1XHQWjxiQCffE0i+RUry+KQiwfqwL6zQRtEguKaqRPpWY3p0mZVl7Bod9IvUpN
         dlIMTcrNKHKwup/YMnsOGdFEsEo5pjLkJfuNwfWHHKCpEDlceYOFM/mNYkeYUDS0CWJV
         6g6wT7IfES7wLo9n5IMdPnbecTPnTFEYVtjsT/D3IEyh0T2GNS9ERovuaYOSBKr/mD0B
         opwB38M/c6qn+2EdW7QgjPBuWBrWURtdECcp+1UUNlLhmAUlFxslCXrwNkltUPM8KEc0
         FL6p3EwrpAieqZjz/PhownJs2WoYwqEFYcdyHVrPi9ObLvuomOXmyUGBmJJAluuJsL9z
         nydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715969025; x=1716573825;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYJ0cnc0Zl4FGmkoO88+7b2WvQHMce7LkfnJgQxYQeI=;
        b=dZTGNfvaFA4dOtYnQpJi92RPgkvh15uQw+/wJyzG1Bvy9D1O4QRUWH0tMEclIg4Od6
         TXCsgDObZHJemLYFjgQJJiW218F4yKTxzzbj1TvBzEcAYo5ECRzOdyMmpMOWZ+0jtcCD
         7VlCvvj7dM1PB7VtQupFN8feOTDS6ACKJzTP/CwEpxXkHfmid3ttIfXBM5CrDWglLnMb
         6tAqCMoi1eB38IWSk0rCE+xTWwq7lOzIzxlHqOcJ3q9kd8N3QlwjcsJvdwBA68F1miAh
         fGvFxANsUolv7vDbJl+7B225HO1Ewunh1Ytz5/XJZaBVSRAbNokpfVORv3U4J4mw6mD5
         ftDA==
X-Forwarded-Encrypted: i=1; AJvYcCXx5ESjBD1sz81N/1JxgjvWhP6hCtRZJH5lXwGx8E0qRaBzRrhe1b1O6b3vyMmHBXSBYrg6oT3MQkhJ19QarPLHW6P1pOtHNXh8TabN
X-Gm-Message-State: AOJu0YyckiwccTntE8/AF1Sffc3yft4u5u+AsYd5ixlIWa3G+5VrdccP
	rdZda9+Nqx1vhimwmDd5lGWKWWpb5cNuo1T9HN2QytxlxEvnFvkHQ4EMQ+zDASZyN131Vm+wmlR
	iyQ==
X-Google-Smtp-Source: AGHT+IFWokv5NHdXBcUwPF1pMMwuaY9pZRDlvYpEU9fYybHuY65eGvaXjHSt2HAOe9THynPhPvsQYHX2faw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120c:b0:dee:8562:acc3 with SMTP id
 3f1490d57ef6-dee8562aee0mr3953967276.3.1715969025660; Fri, 17 May 2024
 11:03:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 11:03:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517180341.974251-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Force KVM_WERROR if the global WERROR is enabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Force KVM_WERROR if the global WERROR is enabled to avoid pestering the
user about a Kconfig that will ultimately be ignored.  Force KVM_WERROR
instead of making it mutually exclusive with WERROR to avoid generating a
config builds KVM with -Werror, but has KVM_WERROR=n.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2a7f69abcac3..75082c4a9ac4 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -44,6 +44,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_PM_NOTIFIER if PM
 	select KVM_GENERIC_HARDWARE_ENABLING
+	select KVM_WERROR if WERROR
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
@@ -66,7 +67,7 @@ config KVM_WERROR
 	# FRAME_WARN, i.e. KVM_WERROR=y with KASAN=y requires special tuning.
 	# Building KVM with -Werror and KASAN is still doable via enabling
 	# the kernel-wide WERROR=y.
-	depends on KVM && EXPERT && !KASAN
+	depends on KVM && ((EXPERT && !KASAN) || WERROR)
 	help
 	  Add -Werror to the build flags for KVM.
 

base-commit: 4aad0b1893a141f114ba40ed509066f3c9bc24b0
-- 
2.45.0.215.g3402c0e53f-goog


