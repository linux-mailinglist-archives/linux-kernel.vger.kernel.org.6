Return-Path: <linux-kernel+bounces-267979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE0941EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9221C216D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4AA188008;
	Tue, 30 Jul 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuvxqRWk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229741A76C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361556; cv=none; b=mObV5TngeeKnVsoASiY6iBnGhLrAG6lDWFn/uuhjdGc8UgmoRpeqOYEfJ5q56/+QYHaMoq5EMl5dHU0Sp8IStvVpmAx2xwxbKWfj0eldbyFkQ8krwidzfP3ep2HSbmCNE5VlWPpxdX2TD+lSko+SVN6uzHoWchTFkqCtPo05+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361556; c=relaxed/simple;
	bh=aMT+ozBRTbYdHL+fhh5svvBL+WbYmjyLUnaF92OcDaw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WOWrbldrF1FwNeNQw0rmyL+FIPpUoHwMzLFJ56XIR09QMGbU0Xm8OV8XLu/BXj0gpQTdfengYBnmxQR+KE8pS86VmYZFaRR184QQYBrPXIXXP3bgVWqkRlDy1IIa+7NiakIMSBvD+KcBQVUkpv9EZd6Fp7wGrMmDhusIltKnU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuvxqRWk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722361553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=2JtWX8h/qlZ5cL2mugzGiR7VThwI4jeywtxnPIFTnFc=;
	b=RuvxqRWkGtexiN4PRfnUSo19uIoaTu9VHw9G/04J0ggxlTfoyMltciWFi4BvFRHv3cjYHO
	9eoovfen90loS8LLXSXFlNm1Zx5qvIYtZQh+uMg37AiiDSqtdd7qMkjOtzo2dATBE5L4oG
	bygVzrRZKnGtA5jCI4vHkLTe44QMFEw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-hYIRVspJM9Cp1Bwu3q_gyw-1; Tue,
 30 Jul 2024 13:45:50 -0400
X-MC-Unique: hYIRVspJM9Cp1Bwu3q_gyw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A69D619560B1;
	Tue, 30 Jul 2024 17:45:49 +0000 (UTC)
Received: from localhost (unknown [10.22.34.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0B3C19560B2;
	Tue, 30 Jul 2024 17:45:48 +0000 (UTC)
Date: Tue, 30 Jul 2024 14:45:47 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] lockdep: suggest the fix for "lockdep bfs error:-1" on
 print_bfs_bug
Message-ID: <Zqkmy0lS-9Sw0M9j@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When lockdep fails while performing the Breadth-first-search operation
due to lack of memory, hint that increasing the value of the config
switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.

Preface the scary backtrace with the suggestion:

    [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
    [  163.849248] ------------[ cut here ]------------
    [  163.849250] lockdep bfs error:-1
    [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
    ...

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---

Changes in v2:
  - removed extra space from the if condition.

 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58c88220a478a..1cf6d9fdddc9c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
 	/*
 	 * Breadth-first-search failed, graph got corrupted?
 	 */
+	if (ret == BFS_EQUEUEFULL)
+		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
+
 	WARN(1, "lockdep bfs error:%d\n", ret);
 }
 
-- 
2.45.2


