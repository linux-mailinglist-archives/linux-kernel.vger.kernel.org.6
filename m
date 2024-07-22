Return-Path: <linux-kernel+bounces-259472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B119396BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0DE1F220EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D9B44C68;
	Mon, 22 Jul 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q+ryCMk2"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9351401B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688822; cv=none; b=km6QIAe6B4ay/wmZiBUrvV9FBM3Ff3W65TQP9t//mSbKnSIgYNENdqYm2z7uParMV7toM9uSFxdn3C0TKVRTBPiTX+v9zYhUVoo0sc3pY3JDxcOr6yR9hETIoKE2tcU0qyWKpDK2wueOot34h7dN9jpvDOgJ9yZmiiag0Jh4kKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688822; c=relaxed/simple;
	bh=l8AwgpZnG+79Ae4e/d4yVGhPw1Lu69/PXeEjRRTKius=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4z5IrD84OUiL6dDFYxdXFTs9WNAyLxfWvmJ4LYOifNM33bjOlkfuZyvYQKXoBlDcnkLNwesQMv6E0PhqAcZr5uTKtjqzgsBQgb0bdn1zuHjO1gkU0Ezv+gpAQFoSyVVrFkxuyk8qYRwaTtky1GjhXQfspMOrZEVpFCD0UiDJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q+ryCMk2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721688818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8sJwcAqpBiYi821c2Fxl1tovp9YkMU1/UiqUIEtndtA=;
	b=q+ryCMk283FwBMLX6O+k0tRZUIoK+vY1U7KunrRpvdrBVkgIxujDh6a8hTFNIj2sT6z3cE
	luiDeDDF0TYV+axoK/nYChqYM1tPD8pDQJc8JKY+8eX1qdW/S3eTom2gzZvzjii2IQbnL4
	TloVih+CMWIcFja7lo9M9FnIjBw0BCA=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: gthelen@google.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: Greg Thelen <gthelen@google.com>,
	Facebook Kernel Team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] memcg: expose children memory usage for root
Date: Mon, 22 Jul 2024 15:53:06 -0700
Message-ID: <20240722225306.1494878-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Linux kernel does not expose memory.current on the root memcg and there
are applications which have to traverse all the top level memcgs to
calculate the total memory charged in the system. This is more expensive
(directory traversal and multiple open and reads) and is racy on a busy
machine. As the kernel already have the needed information i.e. root's
memory.current, why not expose that?

However root's memory.current will have a different semantics than the
non-root's memory.current as the kernel skips the charging for root, so
maybe it is better to have a different named interface for the root.
Something like memory.children_usage only for root memcg.

Now there is still a question that why the kernel does not expose
memory.current for the root. The historical reason was that the memcg
charging was expensice and to provide the users to bypass the memcg
charging by letting them run in the root. However do we still want to
have this exception today? What is stopping us to start charging the
root memcg as well. Of course the root will not have limits but the
allocations will go through memcg charging and then the memory.current
of root and non-root will have the same semantics.

This is an RFC to start a discussion on memcg charging for root.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
 mm/memcontrol.c                         | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6c6075ed4aa5..e4afc05fd8ea 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1220,6 +1220,12 @@ PAGE_SIZE multiple when read back.
 	The total amount of memory currently being used by the cgroup
 	and its descendants.
 
+  memory.children_usage
+	A read-only single value file which exists only on root cgroup.
+
+	The total amount of memory currently being used by the
+        descendants of the root cgroup.
+
   memory.min
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 960371788687..eba8cf76d3d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4304,6 +4304,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "children_usage",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.read_u64 = memory_current_read,
+	},
 	{
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.43.0


