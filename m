Return-Path: <linux-kernel+bounces-357297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC16996F53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC26B228E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22571DF751;
	Wed,  9 Oct 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7pVMymw"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319F1CACDC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486303; cv=none; b=EMtt3SrSbUk/pneayUgm11wmZcJ0SrzOj/V+BzUD8APMqjtYqt4qFd/ubzJgHgHwBiMERRqzfQCnsxffXCWtqwIWVYqXaqFp6luXRI8aDeKK0AsgdS6NCZzR2ln0u4RSo8pIAJw1UEkMi8Oc1cIIbYYwQ8eU40QpjnOApFF1F/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486303; c=relaxed/simple;
	bh=+oj5QjgRYUWlQPTdUOSdE9zuunwSy+1gZhbpvg1B0rU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QszylGaRE1wMG0q3Z5lod8u1hDf2ZphOjmkiN5gnLHL0dqLe0nbivF4gscpk4y/JvztaEPhk0r2JqFnBIPMOBfbYwQWpYrKjwyQvPodr4I52QsqeaRgAlHtcucgYupmm67UrXx5anZj4Arb+QVMScy1Ipn+BdY6pLMQQ0hUO0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7pVMymw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71df07ac9faso933893b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728486300; x=1729091100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=482l0fwpXLeH5fAxMtu97517+8ynn9/0BPprPVE2Acc=;
        b=B7pVMymwrmZZhcwKI/5/w4QjeSxguDheGjlVlOy0c953GNMi3SIWMSmFfwXagTmizF
         xVTlN2Fs2vDPZdAgAfpJ/GJ9i5Q6oXcG41+aXiDi6Qs8epMF2kLJc4j1hkBHv8m21TQk
         jRF6rwbL7xEcWZ4tSeYAKYE2tMA7F/7BjKRTYZWFKkcsTo/a53u72pyNoGSDLC0Es4Zx
         +bUwNEJMk8pIoDwkApbx7oMApbCWgtWG6jcbTgaD1VKivQk1NSTB8MJ2ons1VKd1gYjD
         2x+M0nsDb0IMRzext/d1mwUia2cpphnC6FyVT/JijFrGbz+diqkL6T8aVIVFiziB44jH
         31aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486300; x=1729091100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=482l0fwpXLeH5fAxMtu97517+8ynn9/0BPprPVE2Acc=;
        b=d+wOkMKHwPj81H3Z0sbnG1o0VTY9XHla/RssER7dKeEtoNWeUB0uKeVg2MiWijeV9c
         AZ9YjmIMY2pkv/GRT+uDhRcpuzaH9Ycz+jGZW389L4CKy+gG9MvkhdvJbhudP5xGDVrG
         EIIKC9Fz6B0PAjq0Cn1JRUh1UP8waxAGOkJ3mAYlg13aS8mTrWXRn0KcSKPNeZQznEko
         qjUcJcLazaFn62OPWoABvK4+2Mk85TqGeQMN5ByZBIXuiACxNnDzX9hZuWmt6moDRo69
         gdkp9oXpMXop3vB3WX02hnx4nUzIl5GKxhPrP6BbaOKwOCPA8U3pBGM8YoNpPKvnMKuj
         ep5Q==
X-Forwarded-Encrypted: i=1; AJvYcCURtbFO4+8UgL4PG1a1/kSM+mpC4BIyVp5GJpi1lxefTVKP+Gl2Lruv2EQupedzx2g76N7eHLX74fa7+Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbddzv3ENwEjLxHWaKT7xZxl4fLS1QiDbx8ObHusLxfLNBN9op
	tgp5wHgOHXDJlZi2FSwZlzj7lPU7kqAYFMIvdwoMFClPgcWAQt9wHs9l9Mfrg04iuk3jrh4VRC2
	Kuw==
X-Google-Smtp-Source: AGHT+IGbHyxhG0VOrj443QjPk8zcAmuh38MdDz+1jWmIwKpnngvhIPQUBQZPCKoH5loilolLVOXuqiMDmF8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91c5:b0:71d:f744:6e with SMTP id
 d2e1a72fcca58-71e1d6a9ee5mr18504b3a.2.1728486299695; Wed, 09 Oct 2024
 08:04:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:04:50 -0700
In-Reply-To: <20241009150455.1057573-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009150455.1057573-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009150455.1057573-2-seanjc@google.com>
Subject: [PATCH 1/6] KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Michal Luczaj <mhal@rbox.co>, Sean Christopherson <seanjc@google.com>, 
	Alexander Potapenko <glider@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Explicitly verify the target vCPU is fully online _prior_ to clamping the
index in kvm_get_vcpu().  If the index is "bad", the nospec clamping will
generate '0', i.e. KVM will return vCPU0 instead of NULL.

In practice, the bug is unlikely to cause problems, as it will only come
into play if userspace or the guest is buggy or misbehaving, e.g. KVM may
send interrupts to vCPU0 instead of dropping them on the floor.

However, returning vCPU0 when it shouldn't exist per online_vcpus is
problematic now that KVM uses an xarray for the vCPUs array, as KVM needs
to insert into the xarray before publishing the vCPU to userspace (see
commit c5b077549136 ("KVM: Convert the kvm->vcpus array to a xarray")),
i.e. before vCPU creation is guaranteed to succeed.

As a result, incorrectly providing access to vCPU0 will trigger a
use-after-free if vCPU0 is dereferenced and kvm_vm_ioctl_create_vcpu()
bails out of vCPU creation due to an error and frees vCPU0.  Commit
afb2acb2e3a3 ("KVM: Fix vcpu_array[0] races") papered over that issue, but
in doing so introduced an unsolvable teardown conundrum.  Preventing
accesses to vCPU0 before it's fully online will allow reverting commit
afb2acb2e3a3, without re-introducing the vcpu_array[0] UAF race.

Fixes: 1d487e9bf8ba ("KVM: fix spectrev1 gadgets")
Cc: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index db567d26f7b9..450dd0444a92 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -969,6 +969,15 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 {
 	int num_vcpus = atomic_read(&kvm->online_vcpus);
+
+	/*
+	 * Explicitly verify the target vCPU is online, as the anti-speculation
+	 * logic only limits the CPU's ability to speculate, e.g. given a "bad"
+	 * index, clamping the index to 0 would return vCPU0, not NULL.
+	 */
+	if (i >= num_vcpus)
+		return NULL;
+
 	i = array_index_nospec(i, num_vcpus);
 
 	/* Pairs with smp_wmb() in kvm_vm_ioctl_create_vcpu.  */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


