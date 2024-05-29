Return-Path: <linux-kernel+bounces-193591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE18D2E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0641C22BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD5167293;
	Wed, 29 May 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DCnF8XFC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Xmi7Y0WE"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBB1E86E;
	Wed, 29 May 2024 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967982; cv=none; b=nKSDDiU8WbGMSz0lbLyYpu2nsjdB6/f5ABUZUB1h6HK/gnwDljoO0McN0TZwan94jQYHBSadW2ZNtyA8UekwSoLqgKTjXBIR1zRCtBm4ZPfC7Ma9BYdq2t+XURlzbI6Du1tkqwu/ciTkX9z/bj3fW9xBuey6pAshTA7zRkcKKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967982; c=relaxed/simple;
	bh=D1PMDmY7B62LLigAhABIlGGAGk04ey+K45A2yPKHQ8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GvzVrA2lUNmPPTqFpdxTVQHFYLXBlLH4IYZ+c7NP4JQ1egmsSQdABt87iA250j6xAgylrUAsLO+ibznRcudDnBTlPa2umeDtcA5MuX0CZBqDkYfYDOg+JsqiafCTc+Isc99ksOEBei+yC4duuQkkLz9cY3MwiEezsMfv8GXJnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DCnF8XFC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Xmi7Y0WE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716967978; x=1748503978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Uvjpg//uk2S1oFAIM3ILUNUZ2Z9dsYxohU3k74RCHA=;
  b=DCnF8XFCht7wpSjh+5y0YatIHuCwB2D6a2NQVAG0KeGdv9RQK4BkEWE3
   P6gPPJ9ya4LyScMo9OvjozOPaCoRugQb2zgx5NKFp9YqXPLzQYOk1XK5H
   cyVlzBVnqjYKFz/dGOiqwWCUECCbzPVQiB8YFJz8X61hT/XiDDQCTF+/6
   uUFlfsGqnOGjKGY55YZuK30I1bebRldnox3tS5fUQQMs58OE8bRDGN8dA
   iqDWAD3BdFSb4JsmRvks0S26vtMjDp1DvZ4fFiFk2nKBsfGREL6rpbifd
   P/Q3ggpW7h7BEVcOQYSW3g3weqGJ5uIX+uRLOHpbCxVdgVlzh3qIVsWq/
   g==;
X-CSE-ConnectionGUID: KnYAZ6j/QCG6eLoxON9ozw==
X-CSE-MsgGUID: ZQPLnvlpQDKFiLtWWuhKOA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712613600"; 
   d="scan'208";a="37119280"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 May 2024 09:32:56 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22D83160AFE;
	Wed, 29 May 2024 09:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716967971; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=0Uvjpg//uk2S1oFAIM3ILUNUZ2Z9dsYxohU3k74RCHA=;
	b=Xmi7Y0WE7ucZHtPgb8lbCAbcrf4tY7uazmcIvMh9QkA4CqkgZfl9GHH96bxNTEzW9+vQL7
	vomEHCJE3/J2mWOY6/W8rJTu016jQLcbXE6qhh14/qDGHs2bMpEHqOTMjSP91L5Yc7rFhH
	1wgPVJ0K5fY1Uh8caBFf5eZtsP5Q5cK5YbljO4jop9gy8DAlc0ukHVcLiIrGYOGLEeZxPF
	ln59RerdK0ZiLpZeesZRPX8gi4U+0OlBi/yO2fFq4QHXeuqB82hH91w6PAe5IDINWMTRQs
	JqERgNrwNG399k1vJL6cgQiJOPIthjIcDYbrghYv+KOAFENlyfdhon44ShLH+A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Shresth Prasad <shresthprasad7@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: property: Fix device_node cleanup
Date: Wed, 29 May 2024 09:32:46 +0200
Message-Id: <20240529073246.537459-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

'__free(device_node)' attached to remote will cause a double release:
> OF: ERROR: of_node_release() detected bad of_node_put() on
> /soc@0/bus@32c00000/dsi@32e60000

In case remote is to be returned it must not be cleaned up by a call
to of_node_put. The caller has to do that as the documentation mentions.
Partly revert commit b94d24c08ee1a ("of: property: Remove calls to
of_node_put") to fix it.

Fixes: b94d24c08ee1 ("of: property: Remove calls to of_node_put")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I get the following trace starting with next-20240529:

OF: ERROR: of_node_release() detected bad of_node_put() on /soc@0/bus@32c00000/dsi@32e60000
CPU: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0-rc1-next-20240529+ #2511 610eecbb638fc5fab9a27e01b78203e8a379a280
Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0x90/0x10c
 show_stack+0x14/0x1c
 dump_stack_lvl+0x6c/0x80
 dump_stack+0x14/0x1c
 of_node_release+0x11c/0x188
 kobject_cleanup+0x48/0x17c
 kobject_put+0x78/0xc0
 of_node_put+0x14/0x20
 drm_of_find_panel_or_bridge+0x84/0xd4
 devm_drm_of_get_bridge+0x3c/0x8c
 lcdif_attach_bridge+0x88/0x270
 lcdif_load+0x144/0x28c
 lcdif_probe+0x34/0xcc
 platform_probe+0x64/0xe8
 really_probe+0xc8/0x3ac
 __driver_probe_device+0x84/0x188
 driver_probe_device+0x38/0x150
 __device_attach_driver+0xcc/0x194
 bus_for_each_drv+0x80/0xdc
 __device_attach+0x9c/0x1d0
 device_initial_probe+0x10/0x18
 bus_probe_device+0xa4/0xa8
 deferred_probe_work_func+0x9c/0xe8
 process_one_work+0x154/0x3fc
 worker_thread+0x2f4/0x404
 kthread+0xf4/0x100
 ret_from_fork+0x10/0x20
OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 11 at lib/refcount.c:25 refcount_warn_saturate+0x150/0x214
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0-rc1-next-20240529+ #2511 610eecbb638fc5fab9a27e01b78203e8a379a280
Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
[...]

 drivers/of/property.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 83536216ed4fe..e5c6301643e4c 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -836,9 +836,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 {
 	struct device_node *endpoint_node __free(device_node) =
 			    of_graph_get_endpoint_by_regs(node, port, endpoint);
-
-	struct device_node *remote __free(device_node) =
-			    of_graph_get_remote_port_parent(endpoint_node);
+	struct device_node *remote;
 
 	if (!endpoint_node) {
 		pr_debug("no valid endpoint (%d, %d) for node %pOF\n",
@@ -846,6 +844,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 		return NULL;
 	}
 
+	remote = of_graph_get_remote_port_parent(endpoint_node);
 	if (!remote) {
 		pr_debug("no valid remote node\n");
 		return NULL;
@@ -853,6 +852,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 
 	if (!of_device_is_available(remote)) {
 		pr_debug("not available for remote node\n");
+		of_node_put(remote);
 		return NULL;
 	}
 
-- 
2.34.1


