Return-Path: <linux-kernel+bounces-329043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73812978C61
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D928134F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73524DA1F;
	Sat, 14 Sep 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHNB1SQS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B13CF5E
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726276445; cv=none; b=Epc0qlxuwf4YHVZFfq2/pa+88zNt1RLx1tt7U2WDPxg2xLqKfzpmkuPER/ZBv0ByDhslzQPGBwLIXTw58u+J4s0HFWNAVWxrIBXQ6IBA1FYKvLn4FnyvJn71U4Q71ltNIpvgZQNDiNCr3ZZs4tRP+Ki+xta8mDTzqSxJJxX944U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726276445; c=relaxed/simple;
	bh=8hGFnDmx97YvmntVh7A6887mN5n1bo6yLTTUAOGk2Z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gQABz3nGvDDWBoQwP/RACcRTCnyV31JgvPkmtqlQZ2IE5TzujdZiSc+nZjw1IGkXdJjJxvdiZUv7i0UAtD1Q5ZrdsMGgCpwYtgqzyMNykrZOIPTgBUet8eP0X6bgex84GkR8ffl5BFOJIPJW7PEYc/IHSV+j14Di78omDwi8jDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHNB1SQS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1e275db7faso33379276.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726276443; x=1726881243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/wusTrY/RaRpW8ZSA2W7PXFPM2ScRlEcVob6BeeQf34=;
        b=lHNB1SQSKi16zGJR5BT2upfl57z+qabwnPGnzSFfwhQI0nrPF9DFW0zq77gheiU/4T
         wu0KpttkVuidniVrRh5jbW2YQE4lyX/tlMRqIQIGSz+PDLFwQ/8JZrQ+u8rbUcmBtv82
         Fdg/yTCMDvbdiFAVyH67C+ku+6mggTS7oLczIcExton3DsfJLIWIlcnKNNa374x3uj/3
         CcyRn9rC+V5Yp00YCg0JlsLGE/blNdNnuZ26vwnB+kFYU3DpBJtWNqBeI8da1j2zoxie
         kYGeIQS2DeRjn1eSTDIGGdxgdQMEb3JnjHaRoOY/1ijHFs+mz4wnzcgkG4eYBjmxL9Zn
         LGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726276443; x=1726881243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wusTrY/RaRpW8ZSA2W7PXFPM2ScRlEcVob6BeeQf34=;
        b=GzTlfN2K4638u4dbJ6WLoDaocRhu3N4Dm8DCaAheGD1uXkHghikcfaolqDEV7iLqSr
         8iXoK9qUdjEHct9iyUdLQ+6Sza44MisqzLG5KJO0GsYoH/Z3+2Oehl3Ls1Fe9wS4yPRS
         A2uo4B6DpRqCOayZl/AWqD/YglaGLG3fg7ugnXltZOmg2VL8gLdEQIzvnIjxm3VEIVUE
         8UFvJKdpwPsyQJk30B1bg3U00oe1v/ZdnJpcV0PtHGUea6DugIEekFU470O5zr1AsIwv
         Xqlj6VUY4+RMOSJx4eBxPFg+g0xQDvYYEHsvXlvsiz5rLixq+mcZ75yfQRrbQ7oj3Zfm
         uNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXolixbFeSC+d7ZS+OsnmVXI9bDusDhLHs6nbEyxjai2Ktwbvdwz6ZHJgwGNkaPow4F0/1fmvmjFFh67HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3zZKGF+31owHl6xXgmuJcMVQei4dJ32xUDczOGMJIOU6y710
	SU5UGsVR7bLcrGfWnjgOKQ36ykWjRcaB2iGWXHK7xa/hdf2U0bc2NrNOwlrY/mAC6OEkTvVDJ5N
	jJg==
X-Google-Smtp-Source: AGHT+IGqMoVw7IyDOoeQsf0VKAfkCs3rgUl0XVcRxqiZgLjIaoMEzdFDDd3f9P30bTFCqJfct6AgL/JcPJU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6890:0:b0:e16:55e7:5138 with SMTP id
 3f1490d57ef6-e1d9daabfb5mr12120276.0.1726276442805; Fri, 13 Sep 2024 18:14:02
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Sep 2024 18:13:47 -0700
In-Reply-To: <20240914011348.2558415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914011348.2558415-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240914011348.2558415-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 6.12
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

I got nothing clever or interesting to say for this one.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.12

for you to fetch changes up to 4440337af4d415c8abf8b9b0e10c79b7518e6e3c:

  KVM: SVM: let alternatives handle the cases when RSB filling is required (2024-09-10 10:27:53 -0700)

----------------------------------------------------------------
KVM SVM changes for 6.12:

 - Don't stuff the RSB after VM-Exit when RETPOLINE=y and AutoIBRS is enabled,
   i.e. when the CPU has already flushed the RSB.

 - Trace the per-CPU host save area as a VMCB pointer to improve readability
   and cleanup the retrieval of the SEV-ES host save area.

 - Remove unnecessary accounting of temporary nested VMCB related allocations.

----------------------------------------------------------------
Amit Shah (1):
      KVM: SVM: let alternatives handle the cases when RSB filling is required

Sean Christopherson (3):
      KVM: SVM: Add a helper to convert a SME-aware PA back to a struct page
      KVM: SVM: Add host SEV-ES save area structure into VMCB via a union
      KVM: SVM: Track the per-CPU host save area as a VMCB pointer

Yongqiang Liu (1):
      KVM: SVM: Remove unnecessary GFP_KERNEL_ACCOUNT in svm_set_nested_state()

 arch/x86/include/asm/svm.h | 20 +++++++++++++++-----
 arch/x86/kvm/svm/nested.c  |  4 ++--
 arch/x86/kvm/svm/svm.c     | 24 ++++++++++++------------
 arch/x86/kvm/svm/svm.h     | 18 ++++++++++++++++--
 arch/x86/kvm/svm/vmenter.S |  8 ++------
 5 files changed, 47 insertions(+), 27 deletions(-)

