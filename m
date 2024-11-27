Return-Path: <linux-kernel+bounces-424045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB89DAFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA1E162968
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F61990D8;
	Wed, 27 Nov 2024 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iV8hwQfJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B1193432
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750539; cv=none; b=c+qs45Yiyqh/cxuF0uKYwVG2T8h0IkBYU9UA/87o3lb82E5z7DHXD0O2EzDbJQyvqX67mwcqt8LKwAVDqzSVCqhVPAB5xEsWpDfKQd9tZ9MsfE+wA4HmGla8wThRE1bTaC2Da64WBCj/QFXWo3KJ0Q94Oua+24R2NLfUDhN+/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750539; c=relaxed/simple;
	bh=liH9zGaIWgK7a5JT7Q4wKhBA1YpRT8vrGoOgfa2R1lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKZSP9tUd7KDIKfvQe0O9awesZGoDIy2gNficTAa1liqTK7lr2dDZmMRmYfKy4YKvaeRE7yj49vmbdaU5QrsHcyfOUERFvWwcv/J1ew6wfgo2z9vdb8ft3TfNONE6+tEVZFrZD1tikxZOfkG5Q7qdqk3/0cPtpIsRAUdDVpaZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iV8hwQfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732750536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDyrVpPbQdpGgZ56QjXDlJ+uyzgClDFKcgQedrvZBNo=;
	b=iV8hwQfJIx4QznuRykKt98QA9HJHBQZRuuwxexL4b6UCRvaKgmZWh7rpxV04Qp2jtg4u15
	6gFawi//hn3OKARRZbrGHl3mXuQjwIm3xVf7pfEoc42TEL+nrXYo1znv3yUe6vkXBxagsK
	wLpjsRZ9jcGC2/7VDOVDPt7eaG02Bqg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Tqq-A3j9PaWhkh-iUqufLQ-1; Wed,
 27 Nov 2024 18:35:32 -0500
X-MC-Unique: Tqq-A3j9PaWhkh-iUqufLQ-1
X-Mimecast-MFC-AGG-ID: Tqq-A3j9PaWhkh-iUqufLQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B3001953942;
	Wed, 27 Nov 2024 23:35:31 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A7E619560A3;
	Wed, 27 Nov 2024 23:35:20 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/nmi: Use trylock in __register_nmi_handler() when in_nmi()
Date: Wed, 27 Nov 2024 18:34:55 -0500
Message-ID: <20241127233455.76904-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The __register_nmi_handler() function can be called in NMI context from
nmi_shootdown_cpus() leading to a lockdep splat like the following.

[ 1123.133573] ================================
[ 1123.137845] WARNING: inconsistent lock state
[ 1123.142118] 6.12.0-31.el10.x86_64+debug #1 Not tainted
[ 1123.147257] --------------------------------
[ 1123.151529] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  :
[ 1123.261544]  Possible unsafe locking scenario:
[ 1123.261544]
[ 1123.267463]        CPU0
[ 1123.269915]        ----
[ 1123.272368]   lock(&nmi_desc[0].lock);
[ 1123.276122]   <Interrupt>
[ 1123.278746]     lock(&nmi_desc[0].lock);
[ 1123.282671]
[ 1123.282671]  *** DEADLOCK ***
  :
[ 1123.314088] Call Trace:
[ 1123.316542]  <NMI>
[ 1123.318562]  dump_stack_lvl+0x6f/0xb0
[ 1123.322230]  print_usage_bug.part.0+0x3d3/0x610
[ 1123.330618]  lock_acquire.part.0+0x2e6/0x360
[ 1123.357217]  _raw_spin_lock_irqsave+0x46/0x90
[ 1123.366193]  __register_nmi_handler+0x8f/0x3a0
[ 1123.374401]  nmi_shootdown_cpus+0x95/0x120
[ 1123.378509]  kdump_nmi_shootdown_cpus+0x15/0x20
[ 1123.383040]  native_machine_crash_shutdown+0x54/0x160
[ 1123.388095]  __crash_kexec+0x10f/0x1f0

In this particular case, a panic had just happened.

[ 1122.808188] Kernel panic - not syncing: Fatal hardware error!

It can be argued that a lockdep splat after a panic is not a big deal,
but it can still confuse users. Fix that by using trylock in NMI context
to avoid the lockdep splat. If trylock fails, we still need to acquire
the lock on the best effort basis to avoid potential NMI descriptor
list corruption.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/nmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index ed163c8c8604..0b8ad64be117 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -171,8 +171,23 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	if (WARN_ON_ONCE(!action->handler || !list_empty(&action->list)))
 		return -EINVAL;
 
+	if (in_nmi()) {
+		/*
+		 * register_nmi_handler() can be called in NMI context from
+		 * nmi_shootdown_cpus(). In this case, we use trylock to
+		 * acquire the NMI descriptor lock to avoid potential lockdep
+		 * splat. If that fails, we still acquire the lock on the best
+		 * effort basis, but a real deadlock may happen if the CPU is
+		 * acquiring that lock when NMI happens.
+		 */
+		if (raw_spin_trylock_irqsave(&desc->lock, flags))
+			goto locked;
+		pr_err("%s: trylock of NMI desc lock failed in NMI context, may deadlock!\n",
+			__func__);
+	}
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
+locked:
 	/*
 	 * Indicate if there are multiple registrations on the
 	 * internal NMI handler call chains (SERR and IO_CHECK).
-- 
2.47.0


