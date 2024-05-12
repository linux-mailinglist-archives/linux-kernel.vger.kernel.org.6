Return-Path: <linux-kernel+bounces-176859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBE8C3634
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535E6281724
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3215200C1;
	Sun, 12 May 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RC7wpxE3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930BF9F7
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715513183; cv=none; b=oOal/Fb4CwmFoGblwwx0iDd/7eH6XBOypqOVJSQVBPYtLhDqDzQ8vV1xHFZb4O6klPHqMb1DDQEu5i+ITQPbe0dv8+Vx2EqEKFfJqiVcEBrRy/AJuGgoqYGaitAKvIeSzOraCxyG53dq5FPHem0LzP/6HS0kL2O/S/iIz/h6cjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715513183; c=relaxed/simple;
	bh=oi4tXNBwdMWHpwao/JpAnY5vRdxyZ7Hdoa62eDg5XYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8aD2SslRZ+y7bQF3w0Q55dNN65r2L/9o290TkKB4hMGZEFI+BWHbKAMXYz//AJJBip5TT8hruXIWJbPKi5r+RxdQtzReRXrlq+9xOqI456yyYsb/d5Gg1AmnqdtIGoXzjdS/G0g7tfipEjxJg/YZAV60PHoG5wW4q82eSVAh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RC7wpxE3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715513180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUR0UZti1lE2smopgq2+r8fhUDTBOIVHzU3OV21Q2YA=;
	b=RC7wpxE3jxJL7LeaMLP2ZzXVgSDFuJVV9M8qkgLMT2qgjlwsfTZJpfsEU86cWbRVuNLDmU
	nVtUMd6MJkhjTLdUOQIhZkcY5Npswio4CdPojwBclSZoINWkXbd6czRYRFH+3ujhyXwMV8
	1MN117zEjp0c1/mmWQfRXUrSf5lfecs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-_QPEU4ZWM6-50bohXRkLWQ-1; Sun,
 12 May 2024 07:21:18 -0400
X-MC-Unique: _QPEU4ZWM6-50bohXRkLWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E278380008B;
	Sun, 12 May 2024 11:21:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4BB182026D68;
	Sun, 12 May 2024 11:21:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 13:19:52 +0200 (CEST)
Date: Sun, 12 May 2024 13:19:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] rcu/sync: don't read rcu_sync->gp_count lockless
Message-ID: <20240512111948.GC7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507093530.3043-26-urezki@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

rcu_sync->gp_count is updated under the protection of ->rss_lock but read
locklessly by the WARN_ON() checks, and KCSAN noted the data race.

Move these WARN_ON_ONCE()'s under the lock and remove the no longer needed
READ_ONCE().

Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/rcu/sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 86df878a2fee..b50fde082198 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -152,9 +152,9 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
 
 	spin_lock_irq(&rsp->rss_lock);
+	WARN_ON_ONCE(rsp->gp_count == 0);
 	if (!--rsp->gp_count) {
 		if (rsp->gp_state == GP_PASSED) {
 			WRITE_ONCE(rsp->gp_state, GP_EXIT);
@@ -174,10 +174,10 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int gp_state;
 
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
+	WARN_ON_ONCE(rsp->gp_count != 0);
 	if (rsp->gp_state == GP_REPLAY)
 		WRITE_ONCE(rsp->gp_state, GP_EXIT);
 	gp_state = rsp->gp_state;
-- 
2.25.1.362.g51ebf55



