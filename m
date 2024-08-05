Return-Path: <linux-kernel+bounces-275492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB7948675
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C753328499F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF916EC0B;
	Mon,  5 Aug 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="BTB9+Y3z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pq5gODej"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153D14830D;
	Mon,  5 Aug 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902299; cv=none; b=hvFJeANc4P/Iu6WfBAUh4l67b7SMeJxS0ewUqRH+c+5OIedn1tBmKfOPKqEvwaf0eudCfQIyINhLoxDMiM7aNUqvbDPQ/cIWoEtPqNR2tjb/nEu0wU6BnAgKdExgRxLPjDryuXglB/QBZVCqZJa3NPNitgeWaDdk7i7XIlH0Jpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902299; c=relaxed/simple;
	bh=W9GtxTd9T+38Pj4tNG9Q1S18UlkoVJ2nfUbToI+tdr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UII2PHp3zxHcia+oJEhAHw26pikAf3fay3Gn3TbDRUvuPvpih5boCLZ1WSGDQZsx/sHBf4kCN0jGsZxNUI6nV0aR5yoxEiESM3DkIXu+Kj6UOBYgAqVPBNBe+GI/0hzuoB3C9Dm8oV5nz29LXnnvZAXf/kgwpYsRvUhePFPSumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=BTB9+Y3z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pq5gODej; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E84CD114E9D5;
	Mon,  5 Aug 2024 19:58:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 19:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1722902296; x=1722988696; bh=Qs2ZX7Tx/MCvMucJo4+0l
	WeQSNbdGfxg/N8nwlZzDgs=; b=BTB9+Y3zVCBLPck7TXMAcn7U4cUH/2KLQwwCG
	kG8SVSkCFmRYuKQJOGKcVz7PcQ8WYZ8a3MA4nrIW6yMoj2aTpDLPWwrty5xI0sZw
	C+iRbGxuWmczrOBIdr3575EhsxCzWDXNnUfFrezlyD2rgNmUjiRr4lwxwhxts9wA
	xv6G3NbxLCnKr5g2zVI31M7YmblO0jY+F0L/Ks83YBzCjwJyYIZKf1I1XFUlzi6N
	MEgkXZ8GuRpBKIb1sg5e/igV9AfVv8zi5I45s0Z8SY2rdjDfuPNjfJa7h1FdzIoj
	iaOfLqqYa7Hovrf+8AE4oTsxg/IVDUw4Wo5x/FT3Juq+rHBCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722902296; x=1722988696; bh=Qs2ZX7Tx/MCvMucJo4+0lWeQSNbd
	Gfxg/N8nwlZzDgs=; b=pq5gODejx7+uGLek1ku2m+rhISK/sTusGKx/kAVPmHjv
	lORUMcDhZtvBveKXmTJvtZ3y4aD2NxogkfZHx9RgpYi5fm/E0BYgjfY9qyiBexee
	7NLOES+YxXMJESNyzalvF9/y7hxzbcgBS8yxnKCgarD0Lmos4kS/lkQBTiV6twFW
	7otpksuKBH2gy2xOr/Tngqt5/3intZ9EYqQchFdJ/W+GG3RYEQNuM2+uA/DbHMM/
	VP22dxiq64LXsICLhQcthEG5vgsIFGgW4eJluYlv2C2bCsSj2wSnaQB+R/qwFDAX
	zzC9n8cDAe5xm99ritpHO+I8BPPtBRyOeGOtsGvr8Q==
X-ME-Sender: <xms:GGexZinuDgS5O9NSc5d7sEgNSEJeoeU1TmHgRRVDicf85T2f54PUXQ>
    <xme:GGexZp1ZFogqZuPeCncVPB6d5Zr87_iHBipv_dY_rZ1p2CffozzY9__Ah20tox6_q
    5ydnECcDuDw7cFhpwA>
X-ME-Received: <xmr:GGexZgqOI8A2U-gOm4Ui6rBgHvdQ9WeRvLyC6thkcwgelo8eDhGDNHb0Sn-3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtph
    htthhopedt
X-ME-Proxy: <xmx:GGexZmni26LUBeC90wEwHDRhXIfEOVKFwLAmVUoDpGFJ-mOKTsiekQ>
    <xmx:GGexZg2BGegyS7PpNEYFwAE8ySHMnjRFP7_fd4rSGFLC6rFbPPrJSg>
    <xmx:GGexZts8sHuSL46ProKijybQso9blv649fHcJXNlUmS6D6FtKbNyPQ>
    <xmx:GGexZsU8OHe4NRCPWESrRrWbePZ3mWkk-mQpdnLJ7C4mSnjDxabhlQ>
    <xmx:GGexZk8Xm0wzhPD4nWZj9YvpZ149CIIbViC6wq3Wh8w9fjhYinEFg1RA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 19:58:13 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2] platform/x86: asus-wmi: don't fail if platform_profile already registered
Date: Tue,  6 Aug 2024 11:58:08 +1200
Message-ID: <20240805235808.40944-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some newer laptops it appears that an AMD driver can register a
platform_profile handler. If this happens then the asus_wmi driver would
error with -EEXIST when trying to register its own handler leaving the
user with a possibly unusable system - this is especially true for
laptops with an MCU that emit a stream of HID packets, some of which can
be misinterpreted as shutdown signals.

We can safely continue loading the driver instead of bombing out.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cc5dc296fb2d..2fdfa84f7efb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3897,8 +3897,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
 		asus->platform_profile_handler.choices);
 
 	err = platform_profile_register(&asus->platform_profile_handler);
-	if (err)
+	if (err == -EEXIST) {
+		pr_warn("A platform_profile handler is already registered, this may be a driver conflict.\n");
+		return 0;
+	} else if (err) {
+		pr_err("Failed to register platform_profile: %d\n", err);
 		return err;
+	}
 
 	asus->platform_profile_support = true;
 	return 0;
@@ -4773,7 +4778,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_fan_boost_mode;
 
 	err = platform_profile_setup(asus);
-	if (err)
+	if (err && err != -EEXIST)
 		goto fail_platform_profile_setup;
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
-- 
2.45.2


