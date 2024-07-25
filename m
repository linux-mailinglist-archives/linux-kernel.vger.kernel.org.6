Return-Path: <linux-kernel+bounces-262547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDE93C879
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4111F21CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C3376E0;
	Thu, 25 Jul 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csHkEztU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517820EB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933165; cv=none; b=Bqv7CB2U924Wh+hl8qBh0tKJszEYG1H0IdMKdTixNXCltho3NmRv8Ztc8b8hP8IC40U5aCtGvez5/ihc2uWSfjx3/nBq3UPxEzBtyHPCxrexHsNLaoH2OuqSuQMOvC8d/7UlvM8xAyNZ7NKHCVmSxzXftlp+2CfIv0BqsfsawPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933165; c=relaxed/simple;
	bh=GL+W4IQ9dIC6tntRozC+78iXCBgXWTYLFnp6qNQJgAI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CWujAN17MhRqF2Co8nChNkT20oag1z+Mbi6RX8yBgBhFQoLv2bG+cKqw85J1wfFH+vFcPmemQEceBeecs9ryI1v8sYjYl4i9k54IwyatLCXaa/KZiGe0CBRjr8EPDSzovxwtHIAjvCaMZJx5dKqVY3PidWa9t8ZzGgBwhOxseUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csHkEztU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721933162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=O0E/eY0dP8GiWhfwu+yERL1mpz4cZWPkuwDbaogrgiQ=;
	b=csHkEztU69XNPaehFyfidpAORCsab/zcLmUnP6GSLI9PPl3QMjDK8cPt02U5z16bOfP+Fb
	8ddLFE4IWDOdxc0znBsoOLlsDzVp9f/U4bq3Zjd4hOniBK2OYNa3ViJwP4mOEKQx+7Rc8J
	4cR/cJpJYHkVpvjNoefz8W0N3SUBmZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-AmNQJS2eN_6JZ9s-BxuIJg-1; Thu,
 25 Jul 2024 14:46:01 -0400
X-MC-Unique: AmNQJS2eN_6JZ9s-BxuIJg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E772A1955D52;
	Thu, 25 Jul 2024 18:45:59 +0000 (UTC)
Received: from localhost (unknown [10.22.16.162])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA87B300019A;
	Thu, 25 Jul 2024 18:45:58 +0000 (UTC)
Date: Thu, 25 Jul 2024 15:45:57 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: suggest the fix for "lockdep bfs error:-1" on
 print_bfs_bug
Message-ID: <ZqKdZZp7TI69DWRE@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When lockdep fails while performing the Breadth-first-search operation
due to lack of memory, hint that increasing the value of the configuration
switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.

Preface the scary bactrace with the suggestion:

    [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
    [  163.849248] ------------[ cut here ]------------
    [  163.849250] lockdep bfs error:-1
    [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
    ...

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
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
+	if (ret  == BFS_EQUEUEFULL)
+		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
+
 	WARN(1, "lockdep bfs error:%d\n", ret);
 }
 
-- 
2.45.2


