Return-Path: <linux-kernel+bounces-406509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA89C604F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A628B63EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715921621F;
	Tue, 12 Nov 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKt2uut4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CA230996
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435430; cv=none; b=bp/8rOIxT/zbyEWXOMc75TKuTw5xbFkOF3k+1cmF2KdRhTnaZDVf34WKF3jJxe9Xo8FmLbWmyZrZdj7Ad2gfUoJJZC+mQ/rnvxZ6FDXSmYnVhJ65bxMTO5fYr6iQUxcQUY4dfqw6FeQew7w5xjW1PoDWWnANdGxuZZHxT+FQoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435430; c=relaxed/simple;
	bh=xK5HOA2LNsN0wxu7/nfc+HoQUfhGTyz3JySS+gepupQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4RtzubOI8oeiORBy0D3HvHyS+0UzitS+yWA0ZsIa0odBaG9v91gMBblqoW1V6pYG3IeEzBSv8hut2wLEPTuac8lblMrHGcC28O4bv3SLTzZCsMifILAQ068Ge7jR/OEycVsB3dGzy/VP5Wrg0ffA3RhqiyV38kpb1aNQA34di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKt2uut4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731435425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UN31SK4HZ8LG9aqwjD3UUbiCVM5Zzt1ZT9FMaSigEAM=;
	b=jKt2uut4UghL6vUiX7Trvp88d/wRMi0SOCYGx6yq9Ab5bmLHUSnvS7JHdOjcW4bcrYu2c6
	zEe4VNiMeI9V3qtTTFe1DJ6BLQWQtQxl5mVU5dblzZd+ojmKzKINVTpbr5K3GFZjrKKOe3
	kV3kfT1U9YSrSjz7iGo4+f6OzmD1WK8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-j7arXNJbMReA734ZpwpGlQ-1; Tue,
 12 Nov 2024 13:17:03 -0500
X-MC-Unique: j7arXNJbMReA734ZpwpGlQ-1
X-Mimecast-MFC-AGG-ID: j7arXNJbMReA734ZpwpGlQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A86891955BD2;
	Tue, 12 Nov 2024 18:17:02 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1705430000DF;
	Tue, 12 Nov 2024 18:17:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 6.12-rc8 or final
Date: Tue, 12 Nov 2024 13:17:00 -0500
Message-ID: <20241112181700.384873-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Linus,

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to aa0d42cacf093a6fcca872edc954f6f812926a17:

  KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN (2024-11-08 05:57:13 -0500)

----------------------------------------------------------------
KVM x86 and selftests fixes for 6.12:

x86:

- When emulating a guest TLB flush for a nested guest, flush vpid01, not
  vpid02, if L2 is active but VPID is disabled in vmcs12, i.e. if L2 and
  L1 are sharing VPID '0' (from L1's perspective).

- Fix a bug in the SNP initialization flow where KVM would return '0' to
  userspace instead of -errno on failure.

- Move the Intel PT virtualization (i.e. outputting host trace to host
  buffer and guest trace to guest buffer) behind CONFIG_BROKEN.

- Fix memory leak on failure of KVM_SEV_SNP_LAUNCH_START

- Fix a bug where KVM fails to inject an interrupt from the IRR after
  KVM_SET_LAPIC.

Selftests:

- Increase the timeout for the memslot performance selftest to avoid false
  failures on arm64 and nested x86 platforms.

- Fix a goof in the guest_memfd selftest where a for-loop initialized a
  bit mask to zero instead of BIT(0).

- Disable strict aliasing when building KVM selftests to prevent the
  compiler from treating things like "u64 *" to "uint64_t *" cases as
  undefined behavior, which can lead to nasty, hard to debug failures.

- Force -march=x86-64-v2 for KVM x86 selftests if and only if the uarch
  is supported by the compiler.

- Fix broken compilation of kvm selftests after a header sync in tools/

----------------------------------------------------------------
Dionna Glaze (1):
      kvm: svm: Fix gctx page leak on invalid inputs

John Sperbeck (1):
      KVM: selftests: use X86_MEMTYPE_WB instead of VMX_BASIC_MEM_TYPE_WB

Maxim Levitsky (1):
      KVM: selftests: memslot_perf_test: increase guest sync timeout

Paolo Bonzini (1):
      Merge tag 'kvm-x86-fixes-6.12-rcN' of https://github.com/kvm-x86/linux into HEAD

Patrick Roy (1):
      KVM: selftests: fix unintentional noop test in guest_memfd_test.c

Sean Christopherson (6):
      KVM: selftests: Disable strict aliasing
      KVM: selftests: Don't force -march=x86-64-v2 if it's unsupported
      KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID disabled
      KVM: SVM: Propagate error from snp_guest_req_init() to userspace
      KVM: x86: Unconditionally set irr_pending when updating APICv state
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN

 arch/x86/kvm/lapic.c                            | 29 +++++++++++++++---------
 arch/x86/kvm/svm/sev.c                          | 15 ++++++++-----
 arch/x86/kvm/vmx/nested.c                       | 30 ++++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c                          |  6 +++--
 tools/testing/selftests/kvm/Makefile            | 10 +++++----
 tools/testing/selftests/kvm/guest_memfd_test.c  |  2 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c    |  2 +-
 tools/testing/selftests/kvm/memslot_perf_test.c |  2 +-
 8 files changed, 65 insertions(+), 31 deletions(-)


