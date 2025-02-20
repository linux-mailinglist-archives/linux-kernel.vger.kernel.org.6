Return-Path: <linux-kernel+bounces-524334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68912A3E203
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1092070319F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF042215192;
	Thu, 20 Feb 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPjiDDgQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FC215060
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071190; cv=none; b=JSwg1iuWfp3LAM28PcBOU1UMR9VgrXJ40roje7JDcf02myD/k5aIZzoTO3qBxtca/ZVU8/6wHso4TkpTx1Q3kC7rxphjvtPZlZcqBHZbm1wWkOyCsGNrXqLgRxZJmlaj/5H1Q44T4WNg0V1xUp4n5l58dWbaN9SeOxqSIF4xb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071190; c=relaxed/simple;
	bh=WgEnRfvr5VjeDmHmE/772MoRbufnJXhWpD9DKHVCZGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRZ7ufXhOqxnRaXzNu5e/1mFgxUSfmbIAn33qer5Q0moQ25NYMrpPsr9dSc7GfNNxg+uCiqr7StSmxFMAiuMC8qRnddwg9JMmEiS7161JFZGKWJdUE7g8MxUXmsD/qMI9E+9FGMdW9BbR4g0S0Tf/qmPemOSwEXz3QpBG8iTw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPjiDDgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740071187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9Jhpoq6MLF9SSDoFe1IcDKpKG0153ZwG7g/LjbLYXo=;
	b=NPjiDDgQKNNiUQ00Zc/3Xslw2AvQNBMokxcitWbCh2a4mAa1jnZQxS7zMJotUPmy3CtR+T
	jI9Mabi5hmU/unnYdpqvhS2i/rumKJ3VPWGfQZ3AfA4zcYvT2MUQQglZMV2wf8MfTKANJ0
	tpYCjwSE1EDJyCvbAEOSgcVyQcYghCo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-EZFt9lh5M2Wv7Ec8vtK4Rg-1; Thu,
 20 Feb 2025 12:06:24 -0500
X-MC-Unique: EZFt9lh5M2Wv7Ec8vtK4Rg-1
X-Mimecast-MFC-AGG-ID: EZFt9lh5M2Wv7Ec8vtK4Rg_1740071183
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D9C519783B2;
	Thu, 20 Feb 2025 17:06:23 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24620180035F;
	Thu, 20 Feb 2025 17:06:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 10/30] KVM: Export hardware virtualization enabling/disabling functions
Date: Thu, 20 Feb 2025 12:05:44 -0500
Message-ID: <20250220170604.2279312-11-pbonzini@redhat.com>
In-Reply-To: <20250220170604.2279312-1-pbonzini@redhat.com>
References: <20250220170604.2279312-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Kai Huang <kai.huang@intel.com>

To support TDX, KVM will need to enable TDX during KVM module loading
time.  Enabling TDX requires enabling hardware virtualization first so
that all online CPUs (and the new CPU going online) are in post-VMXON
state.

KVM by default enables hardware virtualization but that is done in
kvm_init(), which must be the last step after all initialization is done
thus is too late for enabling TDX.

Export functions to enable/disable hardware virtualization so that TDX
code can use them to handle hardware virtualization enabling before
kvm_init().

Signed-off-by: Kai Huang <kai.huang@intel.com>
Message-ID: <dfe17314c0d9978b7bc3b0833dff6f167fbd28f5.1731664295.git.kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  8 ++++++++
 virt/kvm/kvm_main.c      | 18 ++++--------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f34f4cfaa513..1e75fa114f34 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2571,4 +2571,12 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range);
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
+int kvm_enable_virtualization(void);
+void kvm_disable_virtualization(void);
+#else
+static inline int kvm_enable_virtualization(void) { return 0; }
+static inline void kvm_disable_virtualization(void) { }
+#endif
+
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ba0327e2d0d3..6e40383fbe47 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -143,8 +143,6 @@ static int kvm_no_compat_open(struct inode *inode, struct file *file)
 #define KVM_COMPAT(c)	.compat_ioctl	= kvm_no_compat_ioctl,	\
 			.open		= kvm_no_compat_open
 #endif
-static int kvm_enable_virtualization(void);
-static void kvm_disable_virtualization(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
@@ -5576,7 +5574,7 @@ static struct syscore_ops kvm_syscore_ops = {
 	.shutdown = kvm_shutdown,
 };
 
-static int kvm_enable_virtualization(void)
+int kvm_enable_virtualization(void)
 {
 	int r;
 
@@ -5621,8 +5619,9 @@ static int kvm_enable_virtualization(void)
 	--kvm_usage_count;
 	return r;
 }
+EXPORT_SYMBOL_GPL(kvm_enable_virtualization);
 
-static void kvm_disable_virtualization(void)
+void kvm_disable_virtualization(void)
 {
 	guard(mutex)(&kvm_usage_lock);
 
@@ -5633,6 +5632,7 @@ static void kvm_disable_virtualization(void)
 	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
 	kvm_arch_disable_virtualization();
 }
+EXPORT_SYMBOL_GPL(kvm_disable_virtualization);
 
 static int kvm_init_virtualization(void)
 {
@@ -5648,21 +5648,11 @@ static void kvm_uninit_virtualization(void)
 		kvm_disable_virtualization();
 }
 #else /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
-static int kvm_enable_virtualization(void)
-{
-	return 0;
-}
-
 static int kvm_init_virtualization(void)
 {
 	return 0;
 }
 
-static void kvm_disable_virtualization(void)
-{
-
-}
-
 static void kvm_uninit_virtualization(void)
 {
 
-- 
2.43.5



