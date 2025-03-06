Return-Path: <linux-kernel+bounces-548114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AEA5402C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022E8188C216
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5401118B47C;
	Thu,  6 Mar 2025 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cGjuCDsY"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB9BE46;
	Thu,  6 Mar 2025 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226059; cv=none; b=qVmjKneVHcdZ+7W510QwJ30F2MnssbidkDDdHfyg3Lp5MDTVz0cEFD66QCwB4HEjvnfmaybNVd2FFtL5HQ87qLcadaaYp3x8C+/0hF/t4OB89tTQoNJlmU/8pwvnSNfoQ7V0fe654GMXzA032Sel5nH/ng+zmi1RY5eZTtM2nIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226059; c=relaxed/simple;
	bh=AkAKi3PbiZB5dAWeQf6u/pkb8ldqQZsBekM7g0BEAwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzOUlPCWdcQCEeDUXc1ommrti80qI1fOgcn7n07jDCbqAac9Ga3JGTWP9rROIt8dw7rpDYhTXBzoG3+xCEKVFMs00rNk3Rw+Qqh1uYuuNjUFX/BCdvrg/QZmw5mkQVMbDnR5xSPOP0oKOnvYyGvafB49rKo5QOtl9zlK1dc1lUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cGjuCDsY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zUxmmMbgf1RNRHXcyd++iuassFmugcTEcG95pQk+WSA=; b=cGjuCDsYXzKjmAhq
	B96877Nl4wqf/6a8vCfJFvBq/syZjJA4UZvny5ycWw1d1xe5erw5uo0cP2mDr9VxwtvzjMRoWmWry
	ci8qpagKCs1aRr8D5w+bl3kv1QxfFiKwl8P+1rdqGbN7bNFu74gDyDK4GxVIV5YITsjOthvjdIh3G
	+rwTMGeZIMPiQepRfjLA5vrFfrc9SX9Xk7v70UdS9wHTdvuGkSfcbTZyVzjEcxiM8GKmzEm6TFpTP
	kJVCmi/1dOsZQUWoyxdt9USsIJTlWmy5k/Lzcee4eBYGpm6UC3gGOPHDRkizlfNwPqG1CRi0uMnHL
	G9ubgnnHABbx8AiV7g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tq0R6-0030Fm-2b;
	Thu, 06 Mar 2025 01:54:08 +0000
From: linux@treblig.org
To: vkoul@kernel.org,
	kishon@kernel.org,
	corbet@lwn.net
Cc: linux-phy@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] phy: core: Remove unused phy_pm_runtime_(allow|forbid)
Date: Thu,  6 Mar 2025 01:54:08 +0000
Message-ID: <20250306015408.277729-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

phy_pm_runtime_allow() and phy_pm_runtime_forbid() were added in 2013
as part of
commit ff764963479a ("drivers: phy: add generic PHY framework")
but have remained unused.

Remove them.
Fix up the (English) docs - I've left the Chinese translation.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/driver-api/phy/phy.rst |  3 +--
 drivers/phy/phy-core.c               | 24 ------------------------
 include/linux/phy/phy.h              | 12 ------------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index 81785c084f3e..719a2b3fd2ab 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -198,8 +198,7 @@ pm_runtime_get_sync of PHY provider device because of parent-child relationship.
 It should also be noted that phy_power_on and phy_power_off performs
 phy_pm_runtime_get_sync and phy_pm_runtime_put respectively.
 There are exported APIs like phy_pm_runtime_get, phy_pm_runtime_get_sync,
-phy_pm_runtime_put, phy_pm_runtime_put_sync, phy_pm_runtime_allow and
-phy_pm_runtime_forbid for performing PM operations.
+phy_pm_runtime_put and phy_pm_runtime_put_sync for performing PM operations.
 
 PHY Mappings
 ============
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 8dfdce605a90..8c2c13978299 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -214,30 +214,6 @@ int phy_pm_runtime_put_sync(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_put_sync);
 
-void phy_pm_runtime_allow(struct phy *phy)
-{
-	if (!phy)
-		return;
-
-	if (!pm_runtime_enabled(&phy->dev))
-		return;
-
-	pm_runtime_allow(&phy->dev);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_allow);
-
-void phy_pm_runtime_forbid(struct phy *phy)
-{
-	if (!phy)
-		return;
-
-	if (!pm_runtime_enabled(&phy->dev))
-		return;
-
-	pm_runtime_forbid(&phy->dev);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_forbid);
-
 /**
  * phy_init - phy internal initialization before phy operation
  * @phy: the phy returned by phy_get()
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 03cd5bae92d3..e63e6e70e860 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -227,8 +227,6 @@ int phy_pm_runtime_get(struct phy *phy);
 int phy_pm_runtime_get_sync(struct phy *phy);
 int phy_pm_runtime_put(struct phy *phy);
 int phy_pm_runtime_put_sync(struct phy *phy);
-void phy_pm_runtime_allow(struct phy *phy);
-void phy_pm_runtime_forbid(struct phy *phy);
 int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
@@ -321,16 +319,6 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
 	return -ENOSYS;
 }
 
-static inline void phy_pm_runtime_allow(struct phy *phy)
-{
-	return;
-}
-
-static inline void phy_pm_runtime_forbid(struct phy *phy)
-{
-	return;
-}
-
 static inline int phy_init(struct phy *phy)
 {
 	if (!phy)
-- 
2.48.1


