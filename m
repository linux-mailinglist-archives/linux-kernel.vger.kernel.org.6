Return-Path: <linux-kernel+bounces-286242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDAB95187B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD68D1C218B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E31A01A1;
	Wed, 14 Aug 2024 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnB73+uC"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7734137C37
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630685; cv=none; b=jm3FLMn49aaPUPfP1aAh9fJUtLJokJlLltUWXx9mODpzeJSoE64kHEOJyThtm0T45q73M2HJzwnKkS71dJq3LYePKA8r6ayrN74gfg6SxPfpY0Q4ql9DrBledEs3HxPCnzSHAXgG33xEvrE4eORVKReViwIgNNHmKtu+gvEeIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630685; c=relaxed/simple;
	bh=dO+V3Q4mP5ciW1bskPsfNP/iO06+JgIWP+/xapvpFuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWD+JKpNpmguEDJVrY68Yb5yawd129TtGIZRK/p9AMP2Hr/wt7Ek/bATVAgX7P2yIcZ4uWrFjYyV9AUKIhpz7KK4FRp9vwK3lK2cdPxtuuotnDPgAJEx83HM+XTbH1BKbNKTj7SGbTR+YXXA4/AueppB2JxOQL91Y5ATLq+Yh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bnB73+uC; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723630680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kvi/W8gOyyklHrp/rAIiYdjJk0RXfYfHnh/CvWe1Mpg=;
	b=bnB73+uC8YaUXiP1QvbZ43ueP4gSV5uMMrv5clNaQAlIngqwu2M8OeUJ2ehBq/Fa7/gGD5
	Ml1MK0ufFq/abZeihTeJ5pCiWf7dnyE826yZWpayw6uZlMQtuV7SyT1j8AjCWVu3B6B0Ts
	mXuzbn/PjnrWrLeL26XOll2n+HEodNM=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Milind Changire <mchangir@redhat.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] ceph: fix memory in MDS client cap_auths
Date: Wed, 14 Aug 2024 11:17:50 +0100
Message-ID: <20240814101750.13293-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The cap_auths that are allocated during an MDS session opening are never
released, causing a memory leak detected by kmemleak.  Fix this by freeing
the memory allocated when shutting down the mds client.

Fixes: 1d17de9534cb ("ceph: save cap_auths in MDS client when session is opened")
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ceph/mds_client.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 276e34ab3e2c..d798d0a5b2b1 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6015,6 +6015,20 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 		ceph_mdsmap_destroy(mdsc->mdsmap);
 	kfree(mdsc->sessions);
 	ceph_caps_finalize(mdsc);
+
+	if (mdsc->s_cap_auths) {
+		int i;
+
+		mutex_lock(&mdsc->mutex);
+		for (i = 0; i < mdsc->s_cap_auths_num; i++) {
+			kfree(mdsc->s_cap_auths[i].match.gids);
+			kfree(mdsc->s_cap_auths[i].match.path);
+			kfree(mdsc->s_cap_auths[i].match.fs_name);
+		}
+		kfree(mdsc->s_cap_auths);
+		mutex_unlock(&mdsc->mutex);
+	}
+
 	ceph_pool_perm_destroy(mdsc);
 }
 

