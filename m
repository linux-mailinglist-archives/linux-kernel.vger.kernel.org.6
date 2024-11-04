Return-Path: <linux-kernel+bounces-394847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B09BB4CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69271C21C68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B01B1D65;
	Mon,  4 Nov 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtaIRm2e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701B18C025
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724085; cv=none; b=X/Cpg8VbI+54S+AVPNARh9mWlU2NTyhuFUUPW2RKRWFZSEl9Fu2hELp4WWJYeq8aVI0/vuNkQkpZs0hK9JGUpu9vcwxP3iDpSjFsDWJHBXHlv/Fi5nq5HqL4g0AeLU+1XzCVP/7pf1UqX5MX30dOJaNhpFfzbZ/ee1KXV4hlh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724085; c=relaxed/simple;
	bh=K2670CLvWu848B9Z+a2LlS5M3E7jNuSgLozZti5polE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQCKJYWT38d1cKmEnAlKXGzWucAMG0prTObjeRP36QYR9Kr1pwgk9YATjeCo/+7cfymvOdDapBC0tY+SsBIlfx3ogD8rZ2tZOU1xpSWJYyNEIS35D976obYckl/c05dL0P5mInGX8UBuPEuTlA/5q+vvFnwJ36HT5uxhH09TR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtaIRm2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730724082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aKQ0/YooIp1QYyef8Z9BF7zgosXNwWGR/ZRQNwN6Nbo=;
	b=PtaIRm2eIcIDb6xUCVhtZ8XvsWUMClLAruk5ffaBgWoRM+Cvii5o/mo+6/LmqjfhpwaAYy
	dY6HCsMOZaSnAJcZ/9J3wUvJpszNfho8Xez0KfcupbZQD8bw1NS28sequMxK/ObVJz81Bv
	yohlq0i+u3yPZ4LSTpckISPE77FMcig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-JVFTtb9zNw-d_g3XSvp-jg-1; Mon,
 04 Nov 2024 07:41:21 -0500
X-MC-Unique: JVFTtb9zNw-d_g3XSvp-jg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 249C81954AE4;
	Mon,  4 Nov 2024 12:41:18 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7D66300018D;
	Mon,  4 Nov 2024 12:41:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: tglx@linutronix.de,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] Revert "igb: Disable threaded IRQ for igb_msix_other"
Date: Mon,  4 Nov 2024 09:40:50 -0300
Message-ID: <20241104124050.22290-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.

Sebastian noticed the ISR indirectly acquires spin_locks, which are
sleeping locks under PREEMPT_RT, which leads to kernel splats.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b83df5f94b1f..f1d088168723 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -907,7 +907,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	int i, err = 0, vector = 0, free_vector = 0;
 
 	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, IRQF_NO_THREAD, netdev->name, adapter);
+			  igb_msix_other, 0, netdev->name, adapter);
 	if (err)
 		goto err_out;
 
-- 
2.47.0


