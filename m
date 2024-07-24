Return-Path: <linux-kernel+bounces-261125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E471393B301
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701C0B24805
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5D1684B9;
	Wed, 24 Jul 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqrV/Lxs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C715F3EE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832352; cv=none; b=MjK+O2dZxhGTsEPSHufRsU6QAgwu582BzvKzWLcDXwDgGrcmLPYLmm2gzusDHAzJ0dIT3eEQ66bUM/UTbBM20yaT7xB8jkwFj7Z19pHXmFmfPnYzp9xVqc4qx1LXvpNEFcIW79Ch2/OlqNczoNERbdggLw6Yt/hyrmSVqzK3G0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832352; c=relaxed/simple;
	bh=nUAqcBbKOtvlez+E5NArgTwpL5aCcnoKZc9jXPV8L+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrtNA3RJNSsK2TkN04MTW9e+yd+CF3l006RNCJ6mF3VZ2n5GLzJQs4LDHKC2Z66/yUDEuZDiRlyLnfuRXuvwmIDZGdwW6Awx5xwdpSrA7d//jQZzwBDdaz100xFH0aqQCX/C0WfhJQZwuqfOXk8Xn95oj+O6BjXOCaSugb3ju8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqrV/Lxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Odpk09ikjpAZdpR1iQePnzedSl1xTPXvIzvkUChbMvw=;
	b=eqrV/Lxs7lYpPDTnZZon9bXgl47VkwUqeba8IuovRyy6p0yI2cOnh47Ba4eWifAeCOC0+9
	eGa/fVrtTMT8WIH944nw3fOLOV1o/38BqXaLZ60dYoPCwPLBg92Swjs0RkPUVEfHfsIXx7
	03EBNHXNm0NCdsedwMIhG6e9vBSC1WQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-g_0UJ3ciO5GPFUd2LRoLZA-1; Wed,
 24 Jul 2024 10:45:46 -0400
X-MC-Unique: g_0UJ3ciO5GPFUd2LRoLZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F14041955F49;
	Wed, 24 Jul 2024 14:45:43 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E758B1955F40;
	Wed, 24 Jul 2024 14:45:39 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 15/25] rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_online()
Date: Wed, 24 Jul 2024 16:43:15 +0200
Message-ID: <20240724144325.3307148-16-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90a0c14f80542..ffec0e7513466 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -283,16 +283,16 @@ void rcu_softirq_qs(void)
 }
 
 /*
- * Reset the current CPU's ->dynticks counter to indicate that the
+ * Reset the current CPU's RCU_WATCHING counter to indicate that the
  * newly onlined CPU is no longer in an extended quiescent state.
  * This will either leave the counter unchanged, or increment it
  * to the next non-quiescent value.
  *
  * The non-atomic test/increment sequence works because the upper bits
- * of the ->dynticks counter are manipulated only by the corresponding CPU,
+ * of the ->state variable are manipulated only by the corresponding CPU,
  * or when the corresponding CPU is offline.
  */
-static void rcu_dynticks_eqs_online(void)
+static void rcu_watching_online(void)
 {
 	if (ct_rcu_watching() & CT_RCU_WATCHING)
 		return;
@@ -5046,7 +5046,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
 	arch_spin_lock(&rcu_state.ofl_lock);
-	rcu_dynticks_eqs_online();
+	rcu_watching_online();
 	raw_spin_lock(&rcu_state.barrier_lock);
 	raw_spin_lock_rcu_node(rnp);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-- 
2.43.0


