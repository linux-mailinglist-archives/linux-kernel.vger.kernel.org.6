Return-Path: <linux-kernel+bounces-261134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3593B30D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD81C22A87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513315B0E0;
	Wed, 24 Jul 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo2yapnT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A2134AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832400; cv=none; b=slg4njWOQJNBoKxmV+1sKNx6ACbHw7OcjtAJHSHRNke7OPIbhBCtIdtQh2n49j3UnHGXHXVZGl3ILpEZBAEw06k29qKbBGcStRLpuJByuxR3n5h1PP8Wl6unHsyw1ypIqp9BJbGobLwDka3T1OYHwOR2QdMD5VFTn33Ygp2am7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832400; c=relaxed/simple;
	bh=zh+pwsVPmLj0A1kog/0tqgtVIr5tV0kueiP5uHRjCyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omsnB+IjQLsaH9H709GFLfjLa5hIfzoMIAa2T8qSHGDXCkzc0sZGB9c5sjbA8IxqBcXZI3eG+aftqCFnHtR1xjYkGKheyKQIj5WBlq3nCWpNRpw+jeX6+gdeHpEEPK/YAO01KgyYw69qrfRvOpsuqumgDK4Gp9rly0xPwwfgvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wo2yapnT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cw25iOFzOXb0VLzy8Vp7LzU2k9dE7gWMulYvQgiiBps=;
	b=Wo2yapnTRjwUILxYN5wB/9apNDAVoWd3mUKyWSIIFGnUQGAKs/00eLgU6oJEaNykzToh1i
	Pu6rvFKT5EX3HKF/sUzuFVnhPlr07KhdUUJbIMw4U07hLxEC64O2dtG0rcC1FDOkuG1iAl
	CdCT6DPy9GWHAddMpgc+30Vyw3WLb7o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-DdpLRMXQMkCoIYCFOndrPg-1; Wed,
 24 Jul 2024 10:46:32 -0400
X-MC-Unique: DdpLRMXQMkCoIYCFOndrPg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C2131955BFE;
	Wed, 24 Jul 2024 14:46:25 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1816A1955DC7;
	Wed, 24 Jul 2024 14:46:07 +0000 (UTC)
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
Subject: [PATCH v3 21/25] rcu: Rename dyntick_save_progress_counter() into rcu_watching_snap_save()
Date: Wed, 24 Jul 2024 16:43:21 +0200
Message-ID: <20240724144325.3307148-22-vschneid@redhat.com>
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
---
 .../RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg        | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg         | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg   | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg        | 2 +-
 kernel/rcu/tree.c                                         | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index 423df00c4df9d..13956baf748ad 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -528,7 +528,7 @@
        font-style="normal"
        y="-8652.5312"
        x="2466.7822"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">rcu_watching_snap_save()</text>
     <text
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
        id="text202-7-2-7-2-0"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index d82a77d03d8cc..9de55fbf5be49 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -844,7 +844,7 @@
      font-style="normal"
      y="1547.8876"
      x="4417.6396"
-     xml:space="preserve">dyntick_save_progress_counter()</text>
+     xml:space="preserve">rcu_watching_snap_save()</text>
   <g
      style="fill:none;stroke-width:0.025in"
      transform="translate(6501.9719,-10685.904)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 53e0dc2a2c793..286a098b9c42f 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -2974,7 +2974,7 @@
        font-style="normal"
        y="38114.047"
        x="-334.33856"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">rcu_watching_snap_save()</text>
     <g
        style="fill:none;stroke-width:0.025in"
        transform="translate(1749.9916,25880.249)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
index 4fa7506082bfe..bab69a15c9c22 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
@@ -516,7 +516,7 @@
        font-style="normal"
        y="-8652.5312"
        x="2466.7822"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">rcu_watching_snap_save()</text>
     <text
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
        id="text202-7-2-7-2-0"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e1dd424f8a4c0..e43d4e1ac4e18 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -768,11 +768,11 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 }
 
 /*
- * Snapshot the specified CPU's dynticks counter so that we can later
+ * Snapshot the specified CPU's RCU_WATCHING counter so that we can later
  * credit them with an implicit quiescent state.  Return 1 if this CPU
  * is in dynticks idle mode, which is an extended quiescent state.
  */
-static int dyntick_save_progress_counter(struct rcu_data *rdp)
+static int rcu_watching_snap_save(struct rcu_data *rdp)
 {
 	/*
 	 * Full ordering against accesses prior current GP and also against
@@ -791,7 +791,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
- * the last call to dyntick_save_progress_counter() for this same CPU, or by
+ * the last call to rcu_watching_snap_save() for this same CPU, or by
  * virtue of having been offline.
  *
  * Returns negative if the specified CPU needs a force resched.
@@ -1984,7 +1984,7 @@ static void rcu_gp_fqs(bool first_time)
 
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
-		force_qs_rnp(dyntick_save_progress_counter);
+		force_qs_rnp(rcu_watching_snap_save);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
 		force_qs_rnp(rcu_implicit_dynticks_qs);
-- 
2.43.0


