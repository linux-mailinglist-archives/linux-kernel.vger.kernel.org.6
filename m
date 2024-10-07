Return-Path: <linux-kernel+bounces-353119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FD9928EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D2D1F242AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124A1B4F12;
	Mon,  7 Oct 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNzXnKlk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CF1B4C23
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296083; cv=none; b=i6Z7L4nodE/VpgmnVDZrqOGuLZtlJsUVqRPy55wIBify2fTLLcMcngBVRPUlXCEEcph4Cir0XNbwF2LcO3iIjkUI6oBEFHDlvzZY6lv45Bqr9XXuVp4m2qhcOCMd6LCfouYiZNufdqJOfLp2d86GAe0JWhZxJGGSC57GzYmUias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296083; c=relaxed/simple;
	bh=/e87TIRhMNaoB0p1RReT7keK7xxF1cuUqXVWKLEd0oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIuKQDmZ8RhPO2vet8sR6sc3cntiQutJ6O+QP7YkgKeXtU+nUW8ECtjMDRQ9KTKhkfYuZbfyORAJZqAVhcM6Sx9eVYmQ7+8F4XEw9a/6zmvoGhZyNyf4jgGEXn/mUZqKo03N3p0ih3dRS33JZhDftWdRBy39n5hpygjxpxG83Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNzXnKlk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728296080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3IjXN8FnwsXp6zfExtH8ltC2YeZMQ8iJiIBUY0fo+fE=;
	b=aNzXnKlklUweou6WEExbvuaZiLj5ri83HjVGPsdjeTDlq4RfGvZcJpvLS7UwHGC1OwcRh4
	BZuL4N9Vh0Gz8KCyTmff5cMPF6/aBRcmbMCFh66ReTBRPA/br41RMZfqudEkFF2fx3LdR4
	yJG9SJABEE5RH0ThXuyDAbToJQcvidk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-oC1ZLCL6NUOrNr405DA1fA-1; Mon,
 07 Oct 2024 06:14:37 -0400
X-MC-Unique: oC1ZLCL6NUOrNr405DA1fA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13C1F19560B7;
	Mon,  7 Oct 2024 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AF31300018D;
	Mon,  7 Oct 2024 10:14:31 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/srcutiny: don't return before reenabling preemption
Date: Mon,  7 Oct 2024 12:14:15 +0200
Message-ID: <20241007101415.466155-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Code after the return statement is dead. Enable preemption before
returning from srcu_drive_gp().

This will be important when/if PREEMPT_AUTO (lazy resched) gets merged.

Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 kernel/rcu/srcutiny.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 549c03336ee9..4dcbf8aa80ff 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -122,8 +122,8 @@ void srcu_drive_gp(struct work_struct *wp)
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
 	preempt_disable();  // Needed for PREEMPT_AUTO
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
-		return; /* Already running or nothing to do. */
 		preempt_enable();
+		return; /* Already running or nothing to do. */
 	}
 
 	/* Remove recently arrived callbacks and wait for readers. */
-- 
2.46.2


