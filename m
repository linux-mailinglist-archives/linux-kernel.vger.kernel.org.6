Return-Path: <linux-kernel+bounces-434193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2869E62EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168B62819D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FC1428E3;
	Fri,  6 Dec 2024 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rik7sw6l"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690813B5AF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446978; cv=none; b=FxNpU+yK/VVr1Q8dl5UnZpNIKLmSR7fMSOLlMHpGUXW/Rp3NXt7R8ELdWbtrkBLjpLWh3zWMYvP1ZMf3puAwcKaUdrJvGbpTi1IDFl79KXj0GMOR5JsboutDDDygJSn59NSt/S9ti9OP7OrekgDxczSKpgwXt3ziHA11Z8Miju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446978; c=relaxed/simple;
	bh=ct+i7VPOT7WsAUB0e2nofOLm4XRPPEhATcLjH3zAifo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Op1Uj0YmN3FMx+n8FYB+GgNwkv/PHXrG7Q/4Tykj9AgEwI2uYlyYv3xqlbN87499QqR8bkfE3SECi8i5A17NH/rlsoLSrA2padrmhMASi0dSfNkzSEnBJIsFqMFgWZ29QFdXu3ok8d3rldnTuU7TA7uHfjtsgsAAh0qo8MW34Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rik7sw6l; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so1755993a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733446976; x=1734051776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E69J+2d2iF7wp/ivOT/6vtBgFfFDMf+WrmT04fDpQV8=;
        b=rik7sw6lrOdG8voJpabPOn0v2ZxTW6mTZh2Cgr+OmyrBXvGk/KISijucArFGjtHhv/
         fY4LeeiPove8VYirtuwlVV99C4quJVEH+C1bT6jREzq7LbFH2Dxne6WYrib3ST7dJOPQ
         o5ihzDugJ91ALPqstJrIGNjvCp6YtA6u0mE01qJCD1V7hbb9ncKF0AhOKNP1jvlOG/28
         ZBJTpDbHPKxKfHEUWwiK101wj4aDMCY+GQ40Q8Nqn/kuPbIPxX8SSnJL84/qx8jZjZCZ
         SrvoVVMXlHN+KtKdEVhvm+V9UFFx+bHrIhnm0BGS6TEbwtM0J3nwkdFXiDFQv4iGUsYm
         lyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733446976; x=1734051776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E69J+2d2iF7wp/ivOT/6vtBgFfFDMf+WrmT04fDpQV8=;
        b=ZQO6mafDe8qqzZGgpa2NtB+zS34i5frauk4K2fU+9OsVhTAziGLONewTZDein3HwVW
         OKBxKaBHaPlEv6VIdb5yx4qqmNQPDqSlNX8siFLmD1vjTPIJeaCTY6z0xHrbClYL27CM
         jJyy4+DX3uS0/qZIKgHWmQYaVLtNg9Ia4xBwdNYO6AfCHBLpYnizabHSxpOcscooSXG0
         q3vPEyVRzbckreXcNV1uKNtFHPUFaBpKBeYudEnxlZMyZrJbGOLrvfEEeWRe3yHOlTHM
         Z7OVBikE2hDDVqUC+6lT+eTlARO3HfWMlp4fRnTVuLXOeHVM64/IhnvB5vx/5mPnMvnl
         uWJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVSBfe5yHMFL/kqaNik4gb3JbGgUD5COh4oXc5BMLQFPVTSNBtJtT0TFOfjU1eXgzNYtvRYeTzEQJCpUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsojeTFTlNCvS/5gLhEB5USs2wDDISAcB3rrd0eM2IYObW4rj
	uMRGfTykG5NXbqHyd0zdcOR3tWB3QnKUOBBiZ6IpcB2QML7BPcm6uw9M6NJHtNdBrJ0aFPc01TH
	rqs/NshvDkQ==
X-Google-Smtp-Source: AGHT+IF8Xr3ZU+SUR6OpvZcjlpe9CogaDlgckw7I+MWP1P15dWO/yWLOygkWrh/pIlrxSKbsRGZqKXsI9AbbGA==
X-Received: from pjl16.prod.google.com ([2002:a17:90b:2f90:b0:2ea:9d23:79a0])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:33c4:b0:2ee:8430:b834 with SMTP id 98e67ed59e1d1-2ef6945f076mr2087792a91.4.1733446976124;
 Thu, 05 Dec 2024 17:02:56 -0800 (PST)
Date: Fri,  6 Dec 2024 01:02:46 +0000
In-Reply-To: <20241206010246.40282-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206010246.40282-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206010246.40282-3-jiaqiyan@google.com>
Subject: [RFC PATCH v2 3/3] Documentation: kvm: new UAPI when arm64 guest
 consumes UER
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the documentation for new UAPI when guest consumes uncorrectable
but recoverable memory error (UER). This new UAPI enables userspace
to inject SEA into the guest.

Tested:
make htmldocs and proofreading

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/virt/kvm/api.rst | 46 ++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 454c2aaa155e5..67645bdb66fe5 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1288,16 +1288,48 @@ ARM64:
 
 User space may need to inject several types of events to the guest.
 
+Inject SError
+~~~~~~~~~~~~~
+
 Set the pending SError exception state for this VCPU. It is not possible to
 'cancel' an Serror that has been made pending.
 
-If the guest performed an access to I/O memory which could not be handled by
-userspace, for example because of missing instruction syndrome decode
-information or because there is no device mapped at the accessed IPA, then
-userspace can ask the kernel to inject an external abort using the address
-from the exiting fault on the VCPU. It is a programming error to set
-ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO or
-KVM_EXIT_ARM_NISV. This feature is only available if the system supports
+Inject SEA
+~~~~~~~~~~
+
+- If the guest performed an access to I/O memory which could not be handled by
+  userspace, for example because of missing instruction syndrome decode
+  information or because there is no device mapped at the accessed IPA, then
+  userspace can ask the kernel to inject an external abort using the address
+  from the exiting fault on the VCPU.
+
+- If the guest consumed an uncorrectable memory error, and RAS extension in
+  Trusted Firmware choosed to notify PE with SEA, KVM and core kernel may have
+  to handle the memory poison consumption when host APEI was unable to claim
+  the SEA. For the following type of faults, KVM sends SIGBUS to current thread
+  (i.e. VMM in EL0) with si_code=BUS_OBJERR:
+
+  - Synchronous External abort, not on translation table walk or hardware
+    update of translation table.
+
+  - Synchronous External abort on translation table walk or hardware update of
+    translation table, level 1.
+
+  - Synchronous parity or ECC error on memory access, not on translation table
+    walk.
+
+  - Synchronous parity or ECC error on memory access on translation table walk
+    or hardware update of translation table, level 1.
+
+  If the memory error's physical address is available, si_addr will be the
+  error's host virtual address in VM's memory space; otherwise si_addr is zero.
+  When userspace VMM is interrupted by such SIGBUS, it can ask KVM to replay
+  an external abort into guest.
+
+It is a programming error to set ext_dabt_pending after an exit which was not
+KVM_EXIT_MMIO, not KVM_EXIT_ARM_NISV, and not interrupted by BUS_OBJERR SIGBUS.
+
+This feature is only available if the system supports
 KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which provides commonality in
 how userspace reports accesses for the above cases to guests, across different
 userspace implementations. Nevertheless, userspace can still emulate all Arm
-- 
2.47.0.338.g60cca15819-goog


