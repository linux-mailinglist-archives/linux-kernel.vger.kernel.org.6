Return-Path: <linux-kernel+bounces-287931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D041952E50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7101F2166A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2AB17C9BD;
	Thu, 15 Aug 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBFLgYKc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDB60B96
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725254; cv=none; b=pOAZzalNikp2n2oLaSGtZDv1fB+zCrGiPM9v5UtKaVdHpTTrsZ2aCm5fQMDSuMS5NnanYviUxNIbcxxZW/fN2Fzwlv+8CKCLqAZiPs02WAkLLTAQpFNT+8aZQeH2Cu+hUZQN4DEfIBqc/00Ly+4p/CFPay1n1L2KxMB88Uq0n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725254; c=relaxed/simple;
	bh=Ip3DfgIfN/iZJYWp08QQAg+ME8NN/fe0LbCTaznaaxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hnxy7BMw7nqJnM//mmVBQr1v3dksh8G97lwSMzIEZxf1eL9JkRjN7IwJ5K193Yrykj/kwzACohSVJvL8xDriSZISkX2b1dDOtmqxuBHCO2gPtlPjvlyBOVWlJQoF3ZpQzNagFuAlxzDSdU9b/hsgr5jVkscY+f8B8P0s2eEosgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBFLgYKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723725251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hJ6ioE0qi1nVhPKtJ9V/HwodmHmg0fVHiHq7A1zD6PE=;
	b=ZBFLgYKcYZafAC2amsm8rAn04sGvJ6jhhktRLETLj3+t7XAEn7pfXL6/X6OMiF3bR1JCzK
	C+L08lA8dPtYAiEx8grHzV+0dsdU20HgAfr890q2btu0Bpv8Lh0yImvwW4ve0pHxt6Ftcp
	WE+eQLURDYZun3qmISLvPT8ZYvBTPFA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-FFs6FjPNOaSYZvVEvNWJmw-1; Thu,
 15 Aug 2024 08:34:06 -0400
X-MC-Unique: FFs6FjPNOaSYZvVEvNWJmw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A7791955D56;
	Thu, 15 Aug 2024 12:34:05 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.47.238.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D16A3300019C;
	Thu, 15 Aug 2024 12:34:00 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v3 0/4] Relax canonical checks on some arch msrs
Date: Thu, 15 Aug 2024 15:33:45 +0300
Message-Id: <20240815123349.729017-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Recently we came up upon a failure where likely the guest writes=0D
0xff4547ceb1600000 to MSR_KERNEL_GS_BASE and later on, qemu=0D
sets this value via KVM_PUT_MSRS, and is rejected by the=0D
kernel, likely due to not being canonical in 4 level paging.=0D
=0D
One of the way to trigger this is to make the guest enter SMM,=0D
which causes paging to be disabled, which SMM bios re-enables=0D
but not the whole 5 level. MSR_KERNEL_GS_BASE on the other=0D
hand continues to contain old value.=0D
=0D
I did some reverse engineering and to my surprise I found out=0D
that both Intel and AMD indeed ignore CR4.LA57 when doing=0D
canonical checks on this and other msrs and/or other arch=0D
registers (like GDT base) which contain linear addresses.=0D
=0D
V2: addressed a very good feedback from Chao Gao. Thanks!=0D
=0D
V3: also fix the nested VMX, and also fix the=0D
MSR_IA32_SYSENTER_EIP / MSR_IA32_SYSENTER_ESP=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  KVM: x86: relax canonical check for some x86 architectural msrs=0D
  KVM: x86: add X86_FEATURE_LA57 to governed_features=0D
  KVM: nVMX: relax canonical checks on some x86 registers in vmx host=0D
    state=0D
  KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and=0D
    MSR_GS_BASE=0D
=0D
 arch/x86/kvm/cpuid.c             |  2 ++=0D
 arch/x86/kvm/governed_features.h |  1 +=0D
 arch/x86/kvm/svm/svm.c           | 12 ++++++++++++=0D
 arch/x86/kvm/vmx/nested.c        | 30 +++++++++++++++++++++++-------=0D
 arch/x86/kvm/x86.c               | 29 +++++++++++++++++++++++++++--=0D
 5 files changed, 65 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.40.1=0D
=0D


