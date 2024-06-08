Return-Path: <linux-kernel+bounces-206840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCE900EA6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7701C2199C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3179E5;
	Sat,  8 Jun 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyDK515H"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65E17E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805208; cv=none; b=rlyUVZQP15vaKaXCIACtKMJH7WMSvJpYqR1RDAJsIzIPDiqbCtNCLKhB8i/0wZUu+sQAeWkOb2lKTJxTquGlkBkZxlIGnA8NXnkxkYXiGezTwJgCn8PIJ1henDoyHzvt2ZJdsnUmhYg40SA7zr5Z6JD15CwYTjjBsbrmszbuujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805208; c=relaxed/simple;
	bh=XVPTv+MRyQaDkK3HkOQFBqvjgvmyQ5edgR1y0le2kPE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QxXiXobNP2xxP/WWe4krczNNnbsmZddLBIAJRjSmWnET8MFRRkf3uGB9BDzjUbQjuyiTxdvB3B2+X0T9EhBgc1Z4s17x0DZauDNb7/cEiPJi8O3wpaHOseANoXxpESp3bsNJwvmSM0YRITZchfENaB6YJtIqjzRX5fpITk3xXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyDK515H; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a2aec8521so42479007b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717805202; x=1718410002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0P/4UOR35lqVOzzO8NYcY7SPrBDZTXh2q6gNOWxYAI=;
        b=OyDK515H/AGi8Ex2I9KZcTIXO3f0MOLdjlAsWkur/FQHYQ5k3YQa/HIdAqFr7rPUCj
         R7jRjHsv4uxGrU1DcnZwEB/5iXbJ4CJLmCSiVDAV3DkHkVGwh7E+oozXwZH8iMPsiWUW
         GtLWI3t0Bg8pbT3kO+pc9g8Qb9Z/lJb7VOVRjqD985bx1r1+J7n7+rvMh6LxdLgricDs
         6gwyBt97fd1FEqQ56jVPJ8MWIZN/y/yvska3BK3fVxP1oUYPPhDKM6NGXHhJJixbwwok
         mN4TdpZat7uDISgC7nbq0+zomU8bnRVm4Hmeo7qd8tE6QqyGEvnwBOSqrBTGhWZ3aQSP
         ZE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717805202; x=1718410002;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0P/4UOR35lqVOzzO8NYcY7SPrBDZTXh2q6gNOWxYAI=;
        b=IwhzDuQ4dVG7+hIZPUUDMfAkIVelTGFGgdtnQNduFhTgtLUrIWuvvQBA//fjdySGgX
         vAteV5iTWF3YELtYW4cdQUJJYmTz/mUs84xqw51BHsMRdx17vSAetljgBnVC8iZOPQgV
         tlE8yQzBvXhgMEjfQfOQeKgayar4USJ72eOWt2KYUWv7p3+w+2tpT5RhfuzLNillzp7g
         bmeOTS9oPIGHietlwM12YXXxtlE5gPNwfX27Wjo8FiD7nOG3hvxa4b2KpemjGXfdDo6S
         KnehkDmbd9iF6oTjcoCD+a+qwJXziVyMs8rV8ziVjxUemqtbzgfpUqw13oHwEVlhu6hL
         1XdA==
X-Forwarded-Encrypted: i=1; AJvYcCXbHz2vi4TJOkvXaOV7itBibwfmbm1t356bQ/wtjrsS2wWMenqg4SwBo+uzOB387dsgB1IIDlq7bV5s3GJcww8Cp+0cB6Eoh+t03WmA
X-Gm-Message-State: AOJu0YyyLSgl7C2WWeYeSNXOZ6+Z6KezTNSEPk8meRvxafKH8lo0X28V
	ky01FzXDJFbBvv7QxrhQhLRQADIcIqZHQyLf9ChDjtS2UxgfSFqiHape7jaeneX2wWgYGAcsnNj
	nCQ==
X-Google-Smtp-Source: AGHT+IFwFGUu4a2gd3YVZgag51+UKBWx+Irxs5YXa+JjqjNYxaDeP1xNMO/cMl4Jibd6nngY7z8aWIx4e0M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100a:b0:de6:bf2:b026 with SMTP id
 3f1490d57ef6-dfaf6679f20mr433495276.13.1717805201794; Fri, 07 Jun 2024
 17:06:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 17:06:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240608000639.3295768-1-seanjc@google.com>
Subject: [PATCH v3 0/8] KVM: Register cpuhp/syscore callbacks when enabling virt
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Register KVM's cpuhp and syscore callbacks when enabling virtualization in
hardware, as the sole purpose of said callbacks is to disable and re-enable
virtualization as needed.

The primary motivation for this series is to simplify dealing with enabling
virtualization for Intel's TDX, which needs to enable virtualization
when kvm-intel.ko is loaded, i.e. long before the first VM is created.  TDX
doesn't _need_ to keep virtualization enabled, but doing so is much simpler
for KVM (see patch 3).

That said, this is a nice cleanup on its own, assuming I haven't broken
something.  By registering the callbacks on-demand, the callbacks themselves
don't need to check kvm_usage_count, because their very existence implies a
non-zero count.

The meat is in patch 1.  Patches 2 renames the helpers so that patch 3 is
less awkward.  Patch 3 adds a module param to enable virtualization when KVM
is loaded.  Patches 4-6 are tangentially related x86 cleanups to registers
KVM's "emergency disable" callback on-demand, same as the syscore callbacks.

The suspend/resume and cphup paths still need to be fully tested, as do
non-x86 architectures.

v3:
 - Collect reviews/acks.
 - Switch to kvm_usage_lock in a dedicated patch, Cc'd for stable@. [Chao]
 - Enable virt at load by default. [Chao]
 - Add comments to document how kvm_arch_{en,dis}able_virtualization() fit
   into the overall flow. [Kai]

v2:
 - https://lore.kernel.org/all/20240522022827.1690416-1-seanjc@google.com
 - Use a dedicated mutex to avoid lock inversion issues between kvm_lock and
   the cpuhp lock.
 - Register emergency disable callbacks on-demand. [Kai]
 - Drop an unintended s/junk/ign rename. [Kai]
 - Decrement kvm_usage_count on failure. [Chao]

v1: https://lore.kernel.org/all/20240425233951.3344485-1-seanjc@google.com

Sean Christopherson (8):
  KVM: Use dedicated mutex to protect kvm_usage_count to avoid deadlock
  KVM: Register cpuhp and syscore callbacks when enabling hardware
  KVM: Rename functions related to enabling virtualization hardware
  KVM: Add a module param to allow enabling virtualization when KVM is
    loaded
  KVM: Add arch hooks for enabling/disabling virtualization
  x86/reboot: Unconditionally define cpu_emergency_virt_cb typedef
  KVM: x86: Register "emergency disable" callbacks when virt is enabled
  KVM: Enable virtualization at load/initialization by default

 Documentation/virt/kvm/locking.rst |  19 ++-
 arch/x86/include/asm/kvm_host.h    |   3 +
 arch/x86/include/asm/reboot.h      |   2 +-
 arch/x86/kvm/svm/svm.c             |   5 +-
 arch/x86/kvm/vmx/main.c            |   2 +
 arch/x86/kvm/vmx/vmx.c             |   6 +-
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |  10 ++
 include/linux/kvm_host.h           |  14 ++
 virt/kvm/kvm_main.c                | 258 ++++++++++++++---------------
 10 files changed, 175 insertions(+), 145 deletions(-)


base-commit: af0903ab52ee6d6f0f63af67fa73d5eb00f79b9a
-- 
2.45.2.505.gda0bf45e8d-goog


