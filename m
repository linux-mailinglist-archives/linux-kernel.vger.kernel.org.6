Return-Path: <linux-kernel+bounces-322078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B639723AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A7AB211B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F390189513;
	Mon,  9 Sep 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKcVYR8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1574428;
	Mon,  9 Sep 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913829; cv=none; b=dhiWBU0lsOO+Dh0YKrNsxfWQcEqSCH0kRUE1MrHfNaRWN/aK4BW4eb9Xh0z6QBwn+yNX+OtIcmvrDJsxH9o/+CYkba3Y6XQVUKlpbl2Pusz6meqkOdiYOX2p2MWjJlcEcwbLx6BAIMzygdIlEuYOCdH8DjP8GxQUtw7RZ0hAg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913829; c=relaxed/simple;
	bh=oKfmWm3IfneM0HZc0vrh0zuvBoU1g5YiwFElUI+GMiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4CXB+6qBYezdITyZ2+RsHliKjXP2euGoLgXet8z9lVT48MlMgp5yMulFABMJoJihu3w8ykHigBDPE1ow1iTtyi8n2oGKr8FgZvY5wlWkAXwd9Ej6AWWHoz27GxX1mYfGn2mXshza1sSevtUcj72zY8zUnJYHAVzFM8fhE4g+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKcVYR8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61727C4CEC5;
	Mon,  9 Sep 2024 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913829;
	bh=oKfmWm3IfneM0HZc0vrh0zuvBoU1g5YiwFElUI+GMiw=;
	h=From:To:List-Id:Cc:Subject:Date:From;
	b=EKcVYR8eVCldZikPrYbPQqXiCSz23NGnT9RFVA3T+jtstgjvhyR50z/Hzed0I50yW
	 WsWkurfl3DDknMNg9NhavYhGQi36fL4SxBBWJo3AczajYphoc9cnjdA78HxugZZRne
	 An7xvI2KrxviWpGfJivU+azBJH1dKLYJJXgU77F1Bb797UXSb02q64bB6p/SeicXjK
	 iDD88B0eKqNgBtR2OQL4Suz/7lu+niYUc8hHqsNx/iLH33NFkMplE3JWamfJHvdiLR
	 idl7yYwMIvFmTbVkYkv9NxRshCGDPXlguQ1knjESCpdythACLVafEbT1jRLfBpMQvq
	 SQdB45UpUp7Xw==
From: Arnd Bergmann <arnd@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()
Date: Mon,  9 Sep 2024 20:30:18 +0000
Message-Id: <20240909203023.1275232-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These two functions have a stub definition when CONFIG_IMX_SCMI_MISC_EXT
is not set, which conflict with the global definition:

In file included from drivers/firmware/imx/sm-misc.c:6:
include/linux/firmware/imx/sm.h:30:1: error: expected identifier or '(' before '{' token
   30 | {
      | ^
drivers/firmware/imx/sm-misc.c:26:5: error: redefinition of 'scmi_imx_misc_ctrl_get'
   26 | int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
      |     ^~~~~~~~~~~~~~~~~~~~~~
include/linux/firmware/imx/sm.h:24:19: note: previous definition of 'scmi_imx_misc_ctrl_get' with type 'int(u32,  u32 *, u32 *)' {aka 'int(unsigned int,  unsigned int *, unsigned int *)'}
   24 | static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
      |                   ^~~~~~~~~~~~~~~~~~~~~~

There is no real need for the #ifdef, and removing this avoids
the build failure.

Fixes: 0b4f8a68b292 ("firmware: imx: Add i.MX95 MISC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/firmware/imx/sm.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 62a2690e2abd..9b85a3f028d1 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -17,18 +17,7 @@
 #define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE SAI4 MCLK */
 #define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE SAI5 MCLK */
 
-#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_EXT)
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
-#else
-static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
-{
-	return -EOPNOTSUPP;
-}
 
-static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val);
-{
-	return -EOPNOTSUPP;
-}
-#endif
 #endif
-- 
2.39.2


