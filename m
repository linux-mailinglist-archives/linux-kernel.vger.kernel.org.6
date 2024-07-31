Return-Path: <linux-kernel+bounces-269791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED309436EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090DF1C21905
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34934168492;
	Wed, 31 Jul 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miCcdDS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A3166308
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456876; cv=none; b=NA1UbdH6LwDg23TK22GViVd3Fb4ovW8dSS+RN3rxlhSNAFvSkx49NxVnrTbCrUIXsZm/xTm3/1upWZ+kn3MsUGvGzJ8gPTKsJ2J1MXtQ962s1osIHfyN7TmMrg164xZupNy1B1BCoXBnzrJ74CC0JK1UVeiZiliqD8vW2TaEcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456876; c=relaxed/simple;
	bh=M+Tz5VtrPahR60wYhrP5uNuiYTcPNjq7pq/plSzVD90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GemL0whdvcnZUs0uFEpLWZX2SvUsqn+MN4vp/gqhIsE3g3fhGNQoop0YUO0d7uhE4P6WhUAbWJAGInyMQnPkyg6xSZvHRhT+qg9SlXE6UMp2ipKVlbz20CH5teeZMbksgZEDoQYk4MLZC+uiv508FtuxDky1aoCSOLRK7hQd6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miCcdDS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C98C116B1;
	Wed, 31 Jul 2024 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456876;
	bh=M+Tz5VtrPahR60wYhrP5uNuiYTcPNjq7pq/plSzVD90=;
	h=From:To:Cc:Subject:Date:From;
	b=miCcdDS+MKXAlrHucvcdqOzeA/zUrzm7selWNUVeog/0tD3UNsiEuOC81ibfI3pT7
	 NkfzgwoSXmUYKvf66I+xTAftazsfyas0/cahZlSHst3eRdDOcA9AiCIAwQxf75AhSm
	 HGkadHxiQtNe3mMuoq5WL5oADQ6yAamvlvS4ing1J+wM6okimEX6wrdsdF7uvjWFu4
	 XLZQ8I9SZ/xBdyicMqgpoN+Gy5xQo+oUncv1+uUn2pjRxWOWze1wZ7fZuWbz5qArmG
	 pz1WXYGBMS16BqcDdKmunIbQNpjd4i1q8o3uYEx/rv0LM3yp1qSCWzK4K3uSOct564
	 UPWzCvkhRww0g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: knav: Drop unnecessary check for property presence
Date: Wed, 31 Jul 2024 14:13:57 -0600
Message-ID: <20240731201407.1838385-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32() returns -EINVAL if a property is not present, so
the preceeding check for presence with of_get_property() can be
dropped.

This is part of a larger effort to remove callers of of_get_property()
and similar functions. of_get_property() leaks the DT struct property
and data pointers which is a problem for dynamically allocated nodes
which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/soc/ti/knav_qmss_queue.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index f2055a76f84c..a15eaa1900ab 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1104,11 +1104,6 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 			continue;
 		}
 
-		if (!of_get_property(child, "link-index", NULL)) {
-			dev_err(dev, "No link info for %s\n", region->name);
-			devm_kfree(dev, region);
-			continue;
-		}
 		ret = of_property_read_u32(child, "link-index",
 					   &region->link_index);
 		if (ret) {
-- 
2.43.0


