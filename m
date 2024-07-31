Return-Path: <linux-kernel+bounces-269722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEAF94362A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F451F22EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722216D306;
	Wed, 31 Jul 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIl0FHnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0216CD3F;
	Wed, 31 Jul 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453232; cv=none; b=hsLiBO4Oeyn7FJTe0DTp4yMuJZFv95kp2bZGEHNl52fEfdtDZGmQ+dhQJvgYTqxeovK/q0aEQ+VXbha81jCQC2+WslnwFhweY3emAUERQzPd/gMPpsQrmmZ3fqZZmyIwT0AGkCpLECc61WvomWfCIfFc6DKbjdHuotxDbIY0Rd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453232; c=relaxed/simple;
	bh=fXAMjj7dSs6h3Nw41flPbSTbFCcIwWBTwFYCOeYCgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZsLaIv+z5+swkn6TMDxguzaOSJwHhS+TC/k4vhP4oh4qNZod/gVNLy9xGkMT+gsOLeyYbxd3tMP5ns9XOO9EY7CNGyJpXU/WDIA6IJboqOzR1ngnwqpmkKvEMeRsPjFtF50OB/3JEUvT9PuDfQO0gxLve6fS7XxS0PyqWGEmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIl0FHnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65500C4AF0C;
	Wed, 31 Jul 2024 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453231;
	bh=fXAMjj7dSs6h3Nw41flPbSTbFCcIwWBTwFYCOeYCgYE=;
	h=From:To:Cc:Subject:Date:From;
	b=gIl0FHnLqBUXhg35F74I+8mg/Zo0m6zjDJK5v/pEnRR19qaMwl29atr06NE02Lz15
	 nbG4qw78iYptnl4NS5yThrXm31rkIj1I+td/F0zG4ieTMnGyN+Td1BJeGkwtOsXN/Z
	 Q4Mcx9+9UpSZlsUachQZk8W6dnLcHbJTpOhFXzWOP8FyltbPYIlCffeIkuq42Reb5g
	 9uM7LluGV1o+svBJyWbTUSKXWLkT/MYvMHmdAqr8F9xD54y/k11csCGamj0CtvWRBB
	 KVKpDNMEeA/lGoCWiYOMGD2InLL+0qlEJJ/FRowb6fgOsUK+mof6cJCjg0wHgJ2VW3
	 zN9g2kAIeF3dg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: unittest: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:48 -0600
Message-ID: <20240731191312.1710417-10-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_find_property(). This is part of a larger effort to remove callers
of of_find_property() and similar functions. of_find_property() leaks
the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/unittest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index c830f346df45..b60b4b7d7172 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -900,8 +900,8 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_find_node_by_path("/testcase-data/changeset/n2/n21"),
 		 "'%pOF' still present after revert\n", n21);
 
-	ppremove = of_find_property(parent, "prop-remove", NULL);
-	unittest(ppremove, "failed to find removed prop after revert\n");
+	unittest(of_property_present(parent, "prop-remove"),
+		 "failed to find removed prop after revert\n");
 
 	ret = of_property_read_string(parent, "prop-update", &propstr);
 	unittest(!ret, "failed to find updated prop after revert\n");
-- 
2.43.0


