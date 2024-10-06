Return-Path: <linux-kernel+bounces-352345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588C991DE2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854281C20BCD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7F173355;
	Sun,  6 Oct 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dijUyOvR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4F7F6
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211104; cv=none; b=I7ovcl0hRYS3TW+uo80vbLDXwzkmQ8Xvepzc7RrIixZ95z1kYXvOE+jcwL6I6+xNJxLPR5tpw+ztOLgfIQPS5Z3MSNGEvxIpulfz3Zg9FxR/psI7zWXI2dLNtV6lR4O9blTpEx1H8dUN4MIxh0BaTyk3xtMUnCcFZ+M9tmCd2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211104; c=relaxed/simple;
	bh=f2xxi2DKOs66PGZFJ5bjsk68GauCtWp8hrFiJiYR5JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGdP/Fx3R3CtV+UQTF59reV9wOSNevFzTZoS0KXI/lmdpdBtNyKiJXqqd1RyPtCu7ik8Iwt3CwW2jj591uoxcIUxNUamdqclARvS2h3fzLGSPUItlfbX5teuPVBzmWOx2jpM91tv+8SiHrxCE2sV1BrUtPzUjutMYLy6oKMIL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dijUyOvR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728211101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3jIevzNX1rCjaTgjZLvCdPeQriMBLs6C6UIuyj0VsKA=;
	b=dijUyOvRd3UPKnfyNhfwBe578tuAerOvrVzrNGwtwIh3dPmv1LRmPinsNlnz4j/SMkK4Ot
	yLh6Shjo/ZCEB18x8W70l1MXuKhWOvjpwBV1kOirgSV7k8A7bGrBUAVOUvgiYfjZOmfp2Z
	StjMXig4YI04H7BDSxXh4THhIp0kVlk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379--FDeMN-vOfuwZphPpaqz5g-1; Sun, 06 Oct 2024 06:38:20 -0400
X-MC-Unique: -FDeMN-vOfuwZphPpaqz5g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c87a33e5bfso4543177a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 03:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728211099; x=1728815899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jIevzNX1rCjaTgjZLvCdPeQriMBLs6C6UIuyj0VsKA=;
        b=Shz8F1cKqQCOLeQgcPy6A6eBouqNZp1NWYLTtVQJcOcl8KGln1Ns/IZE8uzK/pdrkG
         oE0wBfIij0l/+kzxI5sr1bZNn6CRz41vGorBFsfjNJfiKejyGd8p9qifkYhyMt7sWZS/
         00v667y2TkPeDjaZ38VJke5/8ZSSh6ZAHlTUkJxzV47t284A3ITItVfkhpsnaBYl9WzI
         ZXC0CXCGatkFpcaZcQmrjVAIkZAN1FmQjQ3ghk6Anp3vNJi1lN8QTJtYmR1T+sOKuhg9
         4pegh6L309sjL9UuOmfDbcGq8RKtqFzWQRz9KOsCIV38UdJq8G8HyoKqSVrgLRjfyoVp
         s2pg==
X-Gm-Message-State: AOJu0Yyi8vcmftwKlQCvd/bdejTCHRh51Fucd4E+2r0XTMDUTZECaPz2
	C8uBn+mlILBnRgO7bL05jsI6Z01TLp/wuuEsqTV6s7QajZ0BvgNtw/GMmGmpLGzOCOJ3+7+2Oib
	40x3uZyL6N9yNC7XMA+7MeIcqPhRJhveFH2ZZ4ph0sXvMyKg4LB3iAnKVYTGAsQ==
X-Received: by 2002:a17:907:97d5:b0:a99:3eae:87f3 with SMTP id a640c23a62f3a-a993eae8b86mr403715766b.47.1728211098985;
        Sun, 06 Oct 2024 03:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnLTM5tVtHu/M77oCObxmLChhB1MJWc1zEWDoVC80fUmtRwNGJNwtxYPzjHmHgXDBx8JZuTQ==
X-Received: by 2002:a17:907:97d5:b0:a99:3eae:87f3 with SMTP id a640c23a62f3a-a993eae8b86mr403713766b.47.1728211098583;
        Sun, 06 Oct 2024 03:38:18 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9937dbb84csm204933666b.99.2024.10.06.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 03:38:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 6.12-rc2
Date: Sun,  6 Oct 2024 12:38:14 +0200
Message-ID: <20241006103814.1173034-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to c8d430db8eec7d4fd13a6bea27b7086a54eda6da:

  Merge tag 'kvmarm-fixes-6.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2024-10-06 03:59:22 -0400)

----------------------------------------------------------------
ARM64:

* Fix pKVM error path on init, making sure we do not change critical
  system registers as we're about to fail

* Make sure that the host's vector length is at capped by a value
  common to all CPUs

* Fix kvm_has_feat*() handling of "negative" features, as the current
  code is pretty broken

* Promote Joey to the status of official reviewer, while James steps
  down -- hopefully only temporarly

x86:

* Fix compilation with KVM_INTEL=KVM_AMD=n

* Fix disabling KVM_X86_QUIRK_SLOT_ZAP_ALL when shadow MMU is in use

Selftests:

* Fix compilation on non-x86 architectures

----------------------------------------------------------------
Marc Zyngier (2):
      KVM: arm64: Another reviewer reshuffle
      KVM: arm64: Fix kvm_has_feat*() handling of negative features

Mark Brown (2):
      KVM: arm64: Constrain the host to the maximum shared SVE VL with pKVM
      KVM: selftests: Fix build on architectures other than x86_64

Paolo Bonzini (4):
      KVM: x86/mmu: fix KVM_X86_QUIRK_SLOT_ZAP_ALL for shadow MMU
      KVM: x86: leave kvm.ko out of the build if no vendor module is requested
      x86/reboot: emergency callbacks are now registered by common KVM code
      Merge tag 'kvmarm-fixes-6.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Vincent Donnefort (1):
      KVM: arm64: Fix __pkvm_init_vcpu cptr_el2 error path

 MAINTAINERS                                        |  2 +-
 arch/arm64/include/asm/kvm_host.h                  | 25 ++++-----
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 | 12 +++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  6 ++-
 arch/x86/include/asm/reboot.h                      |  4 +-
 arch/x86/kernel/reboot.c                           |  4 +-
 arch/x86/kvm/Kconfig                               |  9 ++--
 arch/x86/kvm/Makefile                              |  2 +-
 arch/x86/kvm/mmu/mmu.c                             | 60 +++++++++++++++++-----
 .../kvm/memslot_modification_stress_test.c         |  2 +
 tools/testing/selftests/kvm/memslot_perf_test.c    |  6 +++
 12 files changed, 91 insertions(+), 43 deletions(-)


