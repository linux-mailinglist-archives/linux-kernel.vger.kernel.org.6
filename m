Return-Path: <linux-kernel+bounces-398568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082749BF2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC83D281C80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0C204928;
	Wed,  6 Nov 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNbfNSoC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECDD1DEFC7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909563; cv=none; b=SRfCdeNtTLd0luK1rxUZDzL+na1ZtlHiDki8sR4EhRLItwQoe4eFIulpRV/D9AO5ddBmqIQvYKl9qbYTPoqYO9CMBB8dOA1Bxmpx0YD51sB9dhp+DY/qz1InYMIiRDceWoCdNb1uivuwT20KOYJxYhcFX6N0JXLfp8qsguWPnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909563; c=relaxed/simple;
	bh=QHlKEhY/AIIUdJMFadNDpFCHHpgPYS9bjBlO3hMTQYg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LMpSoVJjWyvAnwckBa6V+2a67MTMknyqC35KhyBVR3XdgDCcZIP8S3Y4j8WwXWz/E945m8KZxVEGxyj2Y+EIlH2DOpOHzZZmjBKLU0AwPA0YEp2ShZUuYVzFqVdqPID+wPO4I0OlnwsuIfZUyUYdYUAQTzJJ+gZGPgqUL7wzl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNbfNSoC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so128840297b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909561; x=1731514361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdMD5BosN2RfbHLWrwz8uCn9Mhxge705v2wH/rUtjSM=;
        b=KNbfNSoCz+8v5zjHLxzThsQgMdRr2bB0Gvty5n4HgxREQUNNlvPq253P8Gare0GeRa
         5EdYOskda8iT8nSOA0oFs26M5uuo1vah4x44GRf9bDA94tHID/+uv6sXuxI+nygRgg3x
         J9EmkX94r6Xvf4HR3SK85o0+bigKozMBYP0Oh2ptPmJah7GiPVQzN+bYol3ehQfQbdqK
         vjyJi4kiocZgjIsfaOxYen+yOZuJJU4WIYW8zHU8+cw9BRNq8+K+2obiAeom3ezxlDk7
         msItvpX2jkGEJiVC0m9Dr5gj9aio1cy2MFE0cx9Z38UiyCKv2ewgomhS8mjtLpE3AJbk
         sNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909561; x=1731514361;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdMD5BosN2RfbHLWrwz8uCn9Mhxge705v2wH/rUtjSM=;
        b=emYdHDM1IkpLySHA973l6uj0GkmeC+QDBvwOrwOj/KnVEAbc3B0dAHLI81m+hcZvCm
         CwSROM6u4x/m//USlVbMRHkTPg3M2ypL6GsfvemNwqrhI5Zr705+uMwWgg+vcH1n8tu4
         mCHvgiwgd+2tJrbIDnDu6y3oWSThf8V2VmtDtDCkWxlO/wMPSkCwXXN0EDcZIpVGk4Xa
         HiJMni6a41nR23TNIbquhij4g5RJTXA0pVW85/3BiYBn7x3s3pdt3z2xpHAxoCyls4bV
         WKtDFbFNO2jiInaom699KkSQo4tBnZyU8TOnrVWKyf1dYrOgvBHvhCijYodFI6t9BTSv
         bz6w==
X-Forwarded-Encrypted: i=1; AJvYcCU/1OGOxkuKX8uUV6wLzVDvJmkvQOA1Hdaz6UrYotfSoy4HNBCM2QA1gD9L1Sy4xwnTLLL3SQVBa4jG21s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhLgNRs04XO9xXW4podaowFMHxL81fkk9yyuS8GFGKQldBpL2
	KxP7SCAeDLjH8vGKKip1RvfmzBilQswkbnYQNUTw2P1TGQQF60Sy/hOppMcZiD60EUUddVCa4qD
	Jhw==
X-Google-Smtp-Source: AGHT+IFeE3a1gJ6+WLFgBQh9esgy9tnUuYeur36tttYGKm/72J+XCTEWa6Yc3oe1D9Q+GM9+45nD0LS+SK0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181e:b0:e28:fdfc:b788 with SMTP id
 3f1490d57ef6-e30cf4d455bmr19596276.9.1730909560885; Wed, 06 Nov 2024 08:12:40
 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Nov 2024 08:04:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106160425.2622481-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 and selftests fixes for 6.12-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull several fixes for 6.12, and to save us both effort, please also
apply several fixes that should probably go into 6.12 (the selftest fix
definitely needs to land in 6.12).

  https://lore.kernel.org/all/20241106034031.503291-1-jsperbeck@google.com
  https://lore.kernel.org/all/20241105010558.1266699-2-dionnaglaze@google.com
  https://lore.kernel.org/all/20241106015135.2462147-1-seanjc@google.com

And while I have your attention, I'd also like your input on a proposed "fix"
for Intel PT virtualization, which is probably belongs in 6.12 too, if you
agree with the direction. 

  https://lore.kernel.org/all/20241101185031.1799556-2-seanjc@google.com

Note, this is based on v6.12-rc5 in order to pull in the necessary base for
the -march=x86-64-v2 fix.

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.12-rcN

for you to fetch changes up to e5d253c60e9627a22940e00a05a6115d722f07ed:

  KVM: SVM: Propagate error from snp_guest_req_init() to userspace (2024-11-04 22:03:04 -0800)

----------------------------------------------------------------
KVM x86 and selftests fixes for 6.12:

 - Increase the timeout for the memslot performance selftest to avoid false
   failures on arm64 and nested x86 platforms.

 - Fix a goof in the guest_memfd selftest where a for-loop initialized a
   bit mask to zero instead of BIT(0).

 - Disable strict aliasing when building KVM selftests to prevent the
   compiler from treating things like "u64 *" to "uint64_t *" cases as
   undefined behavior, which can lead to nasty, hard to debug failures.

 - Force -march=x86-64-v2 for KVM x86 selftests if and only if the uarch
   is supported by the compiler.

 - When emulating a guest TLB flush for a nested guest, flush vpid01, not
   vpid02, if L2 is active but VPID is disabled in vmcs12, i.e. if L2 and
   L1 are sharing VPID '0' (from L1's perspective).

 - Fix a bug in the SNP initialization flow where KVM would return '0' to
   userspace instead of -errno on failure.

----------------------------------------------------------------
Maxim Levitsky (1):
      KVM: selftests: memslot_perf_test: increase guest sync timeout

Patrick Roy (1):
      KVM: selftests: fix unintentional noop test in guest_memfd_test.c

Sean Christopherson (4):
      KVM: selftests: Disable strict aliasing
      KVM: selftests: Don't force -march=x86-64-v2 if it's unsupported
      KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID disabled
      KVM: SVM: Propagate error from snp_guest_req_init() to userspace

 arch/x86/kvm/svm/sev.c                          |  7 ++++--
 arch/x86/kvm/vmx/nested.c                       | 30 ++++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c                          |  2 +-
 tools/testing/selftests/kvm/Makefile            | 10 +++++----
 tools/testing/selftests/kvm/guest_memfd_test.c  |  2 +-
 tools/testing/selftests/kvm/memslot_perf_test.c |  2 +-
 6 files changed, 39 insertions(+), 14 deletions(-)

