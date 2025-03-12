Return-Path: <linux-kernel+bounces-558489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C221BA5E69F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4AF7ACCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267B15CD74;
	Wed, 12 Mar 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jve3+tw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5C1EF363;
	Wed, 12 Mar 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814993; cv=none; b=ZvjtYKNYHezA8fb65LgcA2Yk4HlsYd6dDpAZEBXRrbqtXaJ4EwjZHX7am082E1synpHJIWO8dzkdkiIJ8hO6iPfKrK3sAr5Ylt9wtaSOkRfja45TJXZpsQJiA8tLhF8+y+w9xqM4tXw9m4Ng9auWJXHNioNfcar72RnZp6n1i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814993; c=relaxed/simple;
	bh=5aq16VBsHjeXNSAr0Vds5cG/UDAOZ/pyPbzvqxsdieM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBNxKnaYC9ka45dxB2NyBZTeEoe6qpXbV9h02yf0uInvF8KwSgkYktcHS9cuVc7fe+3ovN0qyZTD9N5YJ6CqanPcvSJPbhOCN8peK9E4e3rL2kLnotXTfHt7QBr2ZRbbAHpkXL1K9aiObYOtsfBAQwx1tXaIj9Je62EE3wOKZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jve3+tw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C3FC4CEDD;
	Wed, 12 Mar 2025 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814993;
	bh=5aq16VBsHjeXNSAr0Vds5cG/UDAOZ/pyPbzvqxsdieM=;
	h=From:To:Cc:Subject:Date:From;
	b=jve3+tw+8cNTfuLCv7NHfQiifyJMI+mbcVSIkwvkyaAx7lcAEKE098pfJFfWYSTcv
	 DltGXlHS4D1UcKY7SnExgamFQUBK7FcCeaOoeAaW62WcsPdX/cBLNxezfxFDlzWHwK
	 8VMtRiKld+v57XJSl+guxSmaPM+x1V0hcfSX9htaE5GevrwO7qrHHofHAX8K23cwuL
	 qCJrHIoWjJ+Kmxn4LOtX3Xjj97dF/Aribar8lkp/8MT5wUlAwPaPZecG4vLwm20xtC
	 GkIzhjP2+Pnx5MBezywarJHbIRgG1SbxXMgXLJcpOQZJt2AlvJcZ8qMmrjbBSGirBS
	 896eZIJmZIEnQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: Move of_prop_val_eq() next to the single user
Date: Wed, 12 Mar 2025 16:29:46 -0500
Message-ID: <20250312212947.1067337-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's only a single user of of_prop_val_eq(), so move it to overlay.c.
This removes one case of exposing struct property outside of the DT
code.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/overlay.c | 6 ++++++
 include/linux/of.h   | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 434f6dd6a86c..19edbc322cec 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -84,6 +84,12 @@ static int devicetree_state_flags;
 #define DTSF_APPLY_FAIL		0x01
 #define DTSF_REVERT_FAIL	0x02
 
+static int of_prop_val_eq(const struct property *p1, const struct property *p2)
+{
+	return p1->length == p2->length &&
+	       !memcmp(p1->value, p2->value, (size_t)p1->length);
+}
+
 /*
  * If a changeset apply or revert encounters an error, an attempt will
  * be made to undo partial changes, but may fail.  If the undo fails
diff --git a/include/linux/of.h b/include/linux/of.h
index eaf0e2a2b75c..77a4bd275a5c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -908,12 +908,6 @@ static inline const void *of_device_get_match_data(const struct device *dev)
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 #endif
 
-static inline int of_prop_val_eq(const struct property *p1, const struct property *p2)
-{
-	return p1->length == p2->length &&
-	       !memcmp(p1->value, p2->value, (size_t)p1->length);
-}
-
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
 
-- 
2.47.2


