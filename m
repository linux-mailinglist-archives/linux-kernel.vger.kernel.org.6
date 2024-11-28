Return-Path: <linux-kernel+bounces-424056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D8D9DB023
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E792B21825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25D13D893;
	Thu, 28 Nov 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyhCEObj"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33D40BF5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752019; cv=none; b=ucjUAkSEev+l3clm3X4AaKF3jkTJMf6j2b89/hNUE7jP+aQmMqNATXTG0aGFzS+mB9C7SqLZN8M0Ob5Qk/qlMVj+4NbLFbA35UuuyP22d6MOnBRPo3hHNnObtfganCUG66bfMu8CRhCNu1CwJ/VCEAA8eWop2/q2nKcV1/5fDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752019; c=relaxed/simple;
	bh=JeeQkhVLwazNPCRejNXGNMdl03WAOaQXDbfEy3i796M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZQiWF8qGrurl0Up522BVKB53JNiAlxyiGb4PTRkwhd1spAlSKmXcqvUFWvjiG7zRYyVlXukpowtxp8hpDn6TzzTAnFWHsAbuiU6/cV642hNHqhq4VoldmOmkpEqr8yHXPzvh6EjHacoihZZux+OBao5nDj0Mppvp5uVuk8k7zws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyhCEObj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72522df68a9so261352b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732752017; x=1733356817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1rHARWFvprU48rair2lVrKITld+pfqBEh2Nx1sP9VU=;
        b=uyhCEObjKvf0iIvvS9IgJOMhrT9mSZAD/T5mxokRwWQRWkLdy3UnxmVPQZafRpC9iS
         fywBYUWTJRdI0SBReiu99rLIZaAnN95nP5LNPR1k80qFkmn4pqAIynGFQ/EOvy9W5GO0
         cB96pUx0trwVBOcinvczagMVapr+hyhe4rmlFpa/wUKtjtE9v/RE66f/zSi6Of+rv8k8
         ErmlEKIG90Fj6tRhIIy933+pfvyfJlj6FG34sT0M5wSvFNJDA0utgmHCiHa1Tws6rdjy
         nyRTMPUUwUYtJUqICvRzAXCXjHmtQMr2wd9BYXqNOF45ZgYQMY7Mh5zsDQvk4lvnUPbM
         CjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732752017; x=1733356817;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1rHARWFvprU48rair2lVrKITld+pfqBEh2Nx1sP9VU=;
        b=jVuTbkI1+v6wll5IJjmZhsQjPuFoXO/jfTLlW4AzLoyYqbyPSk+cCmHxhljsAor66w
         kGA/DdB+tU9jPAxQIAnLI1/q7/kSo7NWTSRpnR/Nd5xFxQCAJDXpQABQG+X7yV2nHE2U
         bTUQ+yMT9nPpi2MIxQ8E/duhgUuqErPZ0QiZ+wR8QA2AtnuoGGcpnIGt5EgYmoKzKaoS
         gsClYSy2E2eCJQYtmbeuloqiepMIr6nUIxmbp3LZqtCs59WG1SfX68/k72L6gZ6cVrQg
         4Dz3Fkw4PIr2AEH+nqFfxDSnrJYCpvHvlDvab7VrrwEtLSj2AV9kwXdRo2QAa9ovMYbA
         GWLg==
X-Forwarded-Encrypted: i=1; AJvYcCUyeJyXDujOTN/1Eig/srtUGwV2P5b4QiBb9UqiQM2Dk904Eaa9WUoOi2Vz1JBEaMFpqme97eHk36YtzPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ozVIsHhWs5cO9zl7sRZZQ7kbaKFkjvvUdXrxAgliZUQr9RY3
	oBRo2C93NTKPutbYWtjC3NJxlerbFc37PnrpkO5yXv1K1p2Ps/n4ljmG8aU8GC2ioExBgATG7Mp
	+iw==
X-Google-Smtp-Source: AGHT+IF3oxNpWWC0IELw0de5Uwrohdy5JIdxef496SC7Ot/M8YjazPh5NNQ41Km9tyZt+1V3W1kI3JbKWz4=
X-Received: from pjbpt17.prod.google.com ([2002:a17:90b:3d11:b0:2ea:5be5:da6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1850:b0:2ea:3ab5:cb9d
 with SMTP id 98e67ed59e1d1-2ee08e9928amr6628539a91.8.1732752017446; Wed, 27
 Nov 2024 16:00:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:00:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128000010.4051275-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: nVMX: Fix an SVI update bug with passthrough APIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, 
	"=?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?=" <mankku@gmail.com>, Janne Karhunen <janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Defer updating SVI (i.e. the VMCS's highest ISR cache) when L2 is active,
but L1 has not enabled virtual interrupt delivery for L2, as an EOI that
is emulated _by KVM_ in such a case acts on L1's ISR, i.e. vmcs01 needs to
reflect the updated ISR when L1 is next run.

Note, L1's ISR is also effectively L2's ISR in such a setup, but because
virtual interrupt deliver is disable for L2, there's no need to update
SVI in vmcs02, because it will never be used.

v2:
 - WARN only if the vCPU is running to avoid false positives due to userspace
   stuffing APIC state while L2 is active. [Chao]
 - Grab Chao's Tested-by.

v1: https://lore.kernel.org/all/20241101192114.1810198-1-seanjc@google.com
Chao Gao (1):
  KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is active w/o VID

Sean Christopherson (1):
  KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/lapic.c            | 22 ++++++++++++++++------
 arch/x86/kvm/lapic.h            |  1 +
 arch/x86/kvm/vmx/nested.c       |  5 +++++
 arch/x86/kvm/vmx/vmx.c          | 23 ++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/vmx/x86_ops.h      |  2 +-
 7 files changed, 47 insertions(+), 9 deletions(-)


base-commit: 4d911c7abee56771b0219a9fbf0120d06bdc9c14
-- 
2.47.0.338.g60cca15819-goog


