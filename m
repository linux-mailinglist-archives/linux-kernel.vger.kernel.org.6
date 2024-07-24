Return-Path: <linux-kernel+bounces-261133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B9793B30C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39E31C213E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459FB16E897;
	Wed, 24 Jul 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyZhuKkY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201416C84B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832379; cv=none; b=OT07igkSfSKor8Roc5428B1LNiGYdkJYJ7VsaryXy79lJ0Nv1SEJuCCronVcN6QIFNZgnO8pV0eAr3TUs8KEGpl5uoz7ABNM99RFgeos3Ex79xR+vMLsbr66iEaY37Doket4378Q28mzQQl8JR6lfTVUoZx+gkvY6UZpZLDXy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832379; c=relaxed/simple;
	bh=5mEPjoKQW5BHdWdvNrGAj2kKV+FsTYSyIUHrrbrnGXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgZK0W7dXUmK+UkoiRUKhCqyAJjs5vK1HYtdtjSDwBNOep7C7C8gjL+o9XVA5XqFtfSQCaDkou+1R+aR2A6x0WBjF7c6e+CzcZdp+dV4odfdjFfmN20tTwxRFS9IbX6Fxdqv+H+9ceeFXoKxpiCvKFafWqFYEKOW29HU5eFg0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyZhuKkY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TQGqQDiI/5OiOC7IG620onCoGvWp9gtzdqXHidOzw8=;
	b=dyZhuKkYwLofFUeRpHODbvYNP8ObrdLARpopfHg19AoAE8G4seoSr5P5PDVtteOOsTaLAe
	4FOQRZe7E365LHEOuXaFpT4MZoKYIA/f829R9/ROhUp+a8LKUg5ylPnkAU9adH1FWBKgu6
	Ghbgg7MvYKyz/puAcohTaYq1bf3Q58M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-Z-GMn-ydOKeN7kSuze9BUQ-1; Wed,
 24 Jul 2024 10:46:10 -0400
X-MC-Unique: Z-GMn-ydOKeN7kSuze9BUQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 949E31954229;
	Wed, 24 Jul 2024 14:46:07 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FB381955F3B;
	Wed, 24 Jul 2024 14:46:03 +0000 (UTC)
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
Subject: [PATCH v3 20/25] rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
Date: Wed, 24 Jul 2024 16:43:20 +0200
Message-ID: <20240724144325.3307148-21-vschneid@redhat.com>
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
RCU_WATCHING, and the snapshot helpers are now prefix by
"rcu_watching". Reflect that change into the storage variables for these
snapshots.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.h     | 2 +-
 kernel/rcu/tree_exp.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f5361a7d7269c..13fdcc2aa0812 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -215,7 +215,7 @@ struct rcu_data {
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
 	unsigned long barrier_seq_snap;	/* Snap of rcu_state.barrier_sequence. */
 	struct rcu_head barrier_head;
-	int exp_dynticks_snap;		/* Double-check need for IPI. */
+	int exp_watching_snap;		/* Double-check need for IPI. */
 
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 29f94bcf34033..c481e440de6bd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -372,7 +372,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			if (rcu_watching_snap_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-				rdp->exp_dynticks_snap = snap;
+				rdp->exp_watching_snap = snap;
 		}
 	}
 	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
@@ -392,7 +392,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_dynticks_snap)) {
+		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.43.0


