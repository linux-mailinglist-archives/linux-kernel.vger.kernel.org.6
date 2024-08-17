Return-Path: <linux-kernel+bounces-290634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF69556AA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EF5B21B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBF1465B4;
	Sat, 17 Aug 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="n4QGgbTu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7RhsaH0"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB13146585
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885897; cv=none; b=Cd1sGSjSb4HyY3iCBJ+6Yaubc5DXO5ES4fx+0zjQfxT4NlK8/qQUd4qshePjystp9lRF6SUCzndE3RH6PH8SMA0wnUOcqi1jhHu749QpeiiUyD4VubCGgaTy194h1OIkN5eTt60whNH6R5UxqDlFevDu9z5t4Edx9Mk/uGuD8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885897; c=relaxed/simple;
	bh=jYq9klboZMOJntlwsUvait/V9Ok55Xt8RzcQozqL4dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDRtRiIOYk+zHxepom4bwIDr/EsRr5IpSxaWz88hVdn+BmUzocy2nUKwatukj25NGkAzFMHzspYxO+4kzj9xHE4gdNj40GZYc68amDlQD0A/CxGuOHxL4nNAb9bHV151stIPEmYvTZZw6x0ITo8XXCMl/geGi/v+1R/l4gtykWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=n4QGgbTu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7RhsaH0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B66091151BB5;
	Sat, 17 Aug 2024 05:11:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 17 Aug 2024 05:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1723885893; x=1723972293; bh=f0gyP4x/rZ
	ij5x6yxUUAtFK2OLWmK/9anptWI0/I9oQ=; b=n4QGgbTuDqyGzyEhyedr85PXQb
	Icj0XJNlBRNfIIDWHZqrE4dla4nG+YhcXYOfMXJk4+1Zop0cqGAAuVkZT5uAO0Gj
	gdyCtb30YpM34x2BapQzJuDo4jiUEopiNmUrlJmRxuu7mdrC7tKfPvLz7n/XjDFd
	QHY92y7Z5WS6/QWoNqrT7v9YofkLX+UWoYK8gNypSENSU/UYxgrNOhWomjyBH+FH
	1M1w4tdERqwZ4JZCfXoM/uNA/Av/+9OqKwXnwU8dPcd6MXyucMJxrVqRy2St0KvY
	bdg/XLJcEK7E/3Zs/nxGScKPdfAR6Wz5E5tgOPYuAGM4DMOSeTe65qbH2bsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723885893; x=1723972293; bh=f0gyP4x/rZij5x6yxUUAtFK2OLWm
	K/9anptWI0/I9oQ=; b=L7RhsaH06+J16CutMW2D3gkEV1QhSwD6myQNLiWglVgC
	Hy0lDv0gK+IeELWay2IXVFl0t+zgL/rIbBiNDK1xIQxvLLf0e6ZSafeHI1D9bHcA
	3Z5xW0nl2FrrXbHztb8soEkdjVpgpEq2JHR9ZScLe5OTECevbm24+E0M5z8RR6fB
	v7ilc4ZVTMQjADks5zZugqLOfXp2fZe3I7yRsZK6hCn5eDFEK0Vt9pjbwUZ1DYFa
	qSV/2O94p0ENBzbfBs9g/H8PRdisau8vcsQXViP3HN5ZDZzvBKMyn5euspFBsWPt
	mUKDS5dhOZhThx5SZ/KotOIJB3kcsEuKL8PhIl2Euw==
X-ME-Sender: <xms:RWnAZgMjQ0L_9YVzPFHGPI_FwUjgvf4c3wYxzTfsbn_OYcuunS3Z_A>
    <xme:RWnAZm-2xLCi9yhfvNPGf8hn5L58Hb4frdVSbh3Vs3rTW5B2zLQT-Fe5a5RAfxlKn
    Vi9SjTgBm54TlM4NIA>
X-ME-Received: <xmr:RWnAZnS_XWfep5GarjMvJIrOnR95m29k6B69BhIYLmN35x3EvxzV87RqrjShsRHMjs_rI1Qu1P3BvUGP0bEutJVe3omEJ88L3wCZ_MQ94IwvOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddutddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhfetjedu
    ffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
    hhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhg
    vgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdr
    ohhrgh
X-ME-Proxy: <xmx:RWnAZosowJgTL14O3xE_xLnyEwx0TRRbzsfB4wAUqTDs2DmfoE3jtg>
    <xmx:RWnAZofppdTq_ZP_wzmNL11bJ7l-kblVJRsVs8Q56nVF0lxmwKcjyw>
    <xmx:RWnAZs1UznVSjFpEN8dMhbPNsgIpZPZNOQxXvT3Q1leghcBxieEr-A>
    <xmx:RWnAZs_ao-5FJh4PrOBdDdQxS_moEXXgRspLBif6kkchmjEi5dL-8A>
    <xmx:RWnAZg6njdCqRHjFugfa6RHzGyMvJQzxs1tq-1EZJfwb4HGpHh2eU_h4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Aug 2024 05:11:32 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] firewire: ohci: fix error path to detect initiated reset in TI TSB41BA3D phy
Date: Sat, 17 Aug 2024 18:11:28 +0900
Message-ID: <20240817091128.180303-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit 404957c1e207 ("firewire: ohci: use guard macro to serialize
accesses to phy registers") refactored initiated_reset() helper function,
while the error path was changed wrongly.

This commit fixes the bug.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 404957c1e207 ("firewire: ohci: use guard macro to serialize accesses to phy registers")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 53132eae37fe..a3a37955b174 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1919,7 +1919,7 @@ static int get_self_id_pos(struct fw_ohci *ohci, u32 self_id,
 	return i;
 }
 
-static bool initiated_reset(struct fw_ohci *ohci)
+static int detect_initiated_reset(struct fw_ohci *ohci, bool *is_initiated_reset)
 {
 	int reg;
 
@@ -1946,7 +1946,9 @@ static bool initiated_reset(struct fw_ohci *ohci)
 		return reg;
 
 	// bit 3 indicates "initiated reset"
-	return !!((reg & 0x08) == 0x08);
+	*is_initiated_reset = !!((reg & 0x08) == 0x08);
+
+	return 0;
 }
 
 /*
@@ -1956,7 +1958,8 @@ static bool initiated_reset(struct fw_ohci *ohci)
  */
 static int find_and_insert_self_id(struct fw_ohci *ohci, int self_id_count)
 {
-	int reg, i, pos;
+	int reg, i, pos, err;
+	bool is_initiated_reset;
 	u32 self_id = 0;
 
 	// link active 1, speed 3, bridge 0, contender 1, more packets 0.
@@ -1985,7 +1988,6 @@ static int find_and_insert_self_id(struct fw_ohci *ohci, int self_id_count)
 
 	for (i = 0; i < 3; i++) {
 		enum phy_packet_self_id_port_status status;
-		int err;
 
 		err = get_status_for_port(ohci, i, &status);
 		if (err < 0)
@@ -1994,7 +1996,10 @@ static int find_and_insert_self_id(struct fw_ohci *ohci, int self_id_count)
 		self_id_sequence_set_port_status(&self_id, 1, i, status);
 	}
 
-	phy_packet_self_id_zero_set_initiated_reset(&self_id, initiated_reset(ohci));
+	err = detect_initiated_reset(ohci, &is_initiated_reset);
+	if (err < 0)
+		return err;
+	phy_packet_self_id_zero_set_initiated_reset(&self_id, is_initiated_reset);
 
 	pos = get_self_id_pos(ohci, self_id, self_id_count);
 	if (pos >= 0) {
-- 
2.43.0


