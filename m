Return-Path: <linux-kernel+bounces-261120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2016A93B2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE5828216A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29615EFAF;
	Wed, 24 Jul 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkF+pIE4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAC157A58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832334; cv=none; b=YcF7DeF6YrQDK1CVqceI//IEjOT7qkKEU2FblcEEuoWivruZaqd+yrvH45sHx3RbARk/D60VhKHsc2hN/gm7s8DIIYudtnStSCBDpBQvaUxxPUOqhcDTrilx+aNKo3OGGvEBc6zOt9Xq0osL+tGHZSNLIot5h1KQ/wmGYpX2Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832334; c=relaxed/simple;
	bh=JZnpCi9Frq0lCxcb7fxxkXZtKHAKBOCpknIvr0Tvdas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+3l9wMwxJhIYYwpz8Xv+/4Ox5pwc36CP6x4RdP/0YHfcPNfwAdbWGNW79Pi6rW1NlnEdYnXSJE4OFfP514DIR7b/gVFiF4/WGwsHtaZbF1GBWzxp/2EfLYXA1wkVbtRj+L6W0YMVxof797ohPDODwBRb/VgNJ65U2pmUxOqmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkF+pIE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nXrIH3xeZ9pFu4FFpyXc+aDy1CmvWcitI0lR4FgXA0=;
	b=bkF+pIE4eKHEQv4ovLBml16UdSNyoI2u5q8mVVO58+1lwp+QtnlUSITp6t0WCA5F+fvdoT
	Lit/fC8fLCtw5w5z7PDnc5DMxDLppaA/TUAbNoDI8bmTzPqj2TG+l+aa4Q0Fhg3jKCypml
	aEGt9ciYl7MJJfRNWp71HagLQQYD2UQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-kgEGJlXhPDeh9rJTp03qvw-1; Wed,
 24 Jul 2024 10:45:29 -0400
X-MC-Unique: kgEGJlXhPDeh9rJTp03qvw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C85CF1955F2D;
	Wed, 24 Jul 2024 14:45:25 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8A3A1955F40;
	Wed, 24 Jul 2024 14:45:21 +0000 (UTC)
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
Subject: [PATCH v3 11/25] context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into ct_nmi_nesting_cpu()
Date: Wed, 24 Jul 2024 16:43:11 +0200
Message-ID: <20240724144325.3307148-12-vschneid@redhat.com>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree_stall.h                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 8f32fe599c5c0..34fd504e53a86 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -92,7 +92,7 @@ static __always_inline long ct_nmi_nesting(void)
 	return __this_cpu_read(context_tracking.nmi_nesting);
 }
 
-static __always_inline long ct_dynticks_nmi_nesting_cpu(int cpu)
+static __always_inline long ct_nmi_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b1d84a47493..ec49f0155becc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -516,7 +516,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       ct_rcu_watching_cpu(cpu) & 0xffff,
-	       ct_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
+	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.43.0


