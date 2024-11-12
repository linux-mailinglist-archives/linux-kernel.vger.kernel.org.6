Return-Path: <linux-kernel+bounces-406632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C268A9C648E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92909BE6E03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D021CF84;
	Tue, 12 Nov 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbLMLdel"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDE21A4C6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440033; cv=none; b=GuNGh0IzkKtJATOsqN39s9rZkTWL+8lAe6Pg9Nr6codpPM/u9OXVezD0WqDKRDBcVkD9EP+dwwpr/rtRCExFY8QyxSkk+PbbW8CpUaHGAr10fYriBU1zl00IG/16/yY91xl4XNjbErUVeYdANJTdl1dU9jA8LMBxYoEntclWCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440033; c=relaxed/simple;
	bh=tUstlFYUE5Ro46J0W3oBsm7yeRSexS0wPVgjFeOcJms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VP4EnbAyil3HEFnjKVZ9UbL/fMx6fJhuTRSPhwbQo9UZnomXqjMQDPJ3CwGC4Q+c/eJCWc1Rh4FSzNmuuujbTzWjNj94XWnH2S5ZvIogHuYR1SnCJzwj1kqSXr/DJLz261bHDSX/yv6RvG46+dfOfIqGDqJT31ydxV9APYDU8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbLMLdel; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e3b9fc918fso7147608a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440031; x=1732044831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I0OFj8NuBj9Thj9BWLf8Hhe/7zNK1TzrK/w3mRIYIeQ=;
        b=FbLMLdelORLObpo8SSKXYAeCbtMB/0bAmYYwrGV1JsUld8VouRsxb7EvbLGfWK7vew
         IZc0R7m5C4XiUvtVZMQzXF3tduduRubX5C8Oe8NwPvQVBlX1Jh0C5I4e1y31SFUwj/8R
         KJylpuxuRX0QE2sw3T6UkHnULssP7S/swjI9bRHFGVFysxYo7sGa0nat7eBgdQqARfq7
         dtZO6IxtHBNbzp5/z15BwLcJ/MaYICJET1b2ieHDjrTrEiJcJP1ojOnPn6qHQwideVCk
         3RvvxUFovNQnxIuYs9xCEIMdodQK952Chnd16NUr5ZH1IBHkrHsaf1ZLFcYhbe5mE/tF
         Fo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440031; x=1732044831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0OFj8NuBj9Thj9BWLf8Hhe/7zNK1TzrK/w3mRIYIeQ=;
        b=b4idfQxEHDMPkj51cy+yZhXl0sLXDMFLJCdo1TcVPL72RD8J8sk79TXruKICE6pWa+
         3QqWDeOQuTxNlLkYLTIgo7Wyl6kyvXO7BRfUJJqn/HpVOSUCn2yFjgFDjmAj8dM+FWpx
         lI0Q95ctLf4FC4pfQPa4tsAY+wqK5lfMHLZ4LWwkbllX93qMjfULbCZjpbEG7o0Xz3b9
         7Y5+0oXxVpUc780tjiOcZB258SWB4NOoM6vdSnEeLB7YorkWmVwJ86zwzHsW0vHaJ8Q9
         4ABLrxxB+tJk3HqYGwZIkTK6ewcwlef6chP0Ckyn5cw9MLDEJ3PPi/IgFgzOumVwMNLt
         V2jg==
X-Forwarded-Encrypted: i=1; AJvYcCVynnL9AgV5ZPsGVGlKXMZk0i0oAFNWOFWhZv9kcwbLoaj/bk6L0kvax78GirUacYYj69bXvxqIF39JCp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXK4Fqi8w1vzayKNqhoCysO5hboV5NcTJL8aftFIJn2G5B7YV
	+AEjkPDG4AW+n0XIPpmNyLv1Zf6kehCtdJtblw30FDZItvl+nz+d1mwfMZ9cipfzkOhz0QQfsIg
	XBQ==
X-Google-Smtp-Source: AGHT+IFpm1Pj02L8m1sOYi1J0dviaKmwPrK/zdMQNEzkWqskvzHEiuCfkxc/N184zX/2UIvMehrLDOPYzMQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1007:b0:2e0:b741:cdbc with SMTP id
 98e67ed59e1d1-2e9b17783a4mr164109a91.4.1731440031384; Tue, 12 Nov 2024
 11:33:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Nov 2024 11:33:34 -0800
In-Reply-To: <20241112193335.597514-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112193335.597514-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112193335.597514-5-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests changes for 6.13
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Essentially AVX support, plus a few minor cleanups.

Far more noteworth is what's not in this pull request.  For 6.14, I want
to I want to land series with KVM-selftests-tree-wide impact: one that
changes^fixes the prototype for vcpu_get_reg(), and another that uses the
kernel's canonical $(ARCH) directory scheme instead of KVM selftests'
homebrewed $(ARCH_DIR).  My plan is to refresh both series after all arch
pull requests for 6.13 have landed, and then pester you incessantly to
apply them :-)

  https://lore.kernel.org/all/20241009154953.1073471-1-seanjc@google.com
  https://lore.kernel.org/all/20240826190116.145945-1-seanjc@google.com

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.13

for you to fetch changes up to 89f8869835e4da836bc60ab20568b7864706f94b:

  KVM: selftests: Ensure KVM supports AVX for SEV-ES VMSA FPU test (2024-11-01 09:26:37 -0700)

----------------------------------------------------------------
KVM selftests changes for 6.13

 - Enable XFAM-based features by default for all selftests VMs, which will
   allow removing the "no AVX" restriction.

----------------------------------------------------------------
Ba Jing (1):
      KVM: selftests: Remove unused macro in the hardware disable test

Jiapeng Chong (1):
      KVM: selftests: Use ARRAY_SIZE for array length

Sean Christopherson (10):
      KVM: selftests: Precisely mask off dynamic fields in CPUID test
      KVM: selftests: Mask off OSPKE and OSXSAVE when comparing CPUID entries
      KVM: selftests: Rework OSXSAVE CR4=>CPUID test to play nice with AVX insns
      KVM: selftests: Configure XCR0 to max supported value by default
      KVM: selftests: Verify XCR0 can be "downgraded" and "upgraded"
      KVM: selftests: Drop manual CR4.OSXSAVE enabling from CR4/CPUID sync test
      KVM: selftests: Drop manual XCR0 configuration from AMX test
      KVM: selftests: Drop manual XCR0 configuration from state test
      KVM: selftests: Drop manual XCR0 configuration from SEV smoke test
      KVM: selftests: Ensure KVM supports AVX for SEV-ES VMSA FPU test

 .../testing/selftests/kvm/hardware_disable_test.c  |  1 -
 .../selftests/kvm/include/x86_64/processor.h       |  5 ++
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 24 ++++++++
 tools/testing/selftests/kvm/x86_64/amx_test.c      | 23 ++------
 tools/testing/selftests/kvm/x86_64/cpuid_test.c    | 67 ++++++++++++++--------
 .../selftests/kvm/x86_64/cr4_cpuid_sync_test.c     | 53 +++++++++++------
 tools/testing/selftests/kvm/x86_64/debug_regs.c    |  2 +-
 .../testing/selftests/kvm/x86_64/sev_smoke_test.c  | 19 ++----
 tools/testing/selftests/kvm/x86_64/state_test.c    |  5 --
 .../testing/selftests/kvm/x86_64/xcr0_cpuid_test.c | 11 +++-
 10 files changed, 123 insertions(+), 87 deletions(-)

