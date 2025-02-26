Return-Path: <linux-kernel+bounces-534729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD28A46A81
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2903A85B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23EC22D793;
	Wed, 26 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRm3ned/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220C238D45;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596417; cv=none; b=sLS+Ban/cVvBnApDEYat1EjwTaMZqpGVWqScxx334UEPaQNz287aQvTM+JbGsC5UirS4x8q6oluvEaV+uKXOKTf5+gnwCC/PjiI+8uEEZ+lRnCjzdNeJbefwsPcaM1l7N4wG5j+GPYEn5XoJ4JA7rUyK9fOSgtDhvMqpIx9ViDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596417; c=relaxed/simple;
	bh=wRpTgVNyj3uFgb5wwu79FFUhOzFVyOzLcCfMgdRPLUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uHX8KDigbtafqsYzNdUJhCoYWUBxOmpthECSFpJNShfjoUsVKCfBlrKSLDScYp7Kp+urdC507ySPJU5FR1ZKDy8UD3ca1tTyRk+TBOCU0hNHHjV58B1faCiuyZCZkpyLXf9dUkor/Te2J+ve35FY2Ttud+Ctg5Xxd4NGuASz11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRm3ned/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3035C4CED6;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596416;
	bh=wRpTgVNyj3uFgb5wwu79FFUhOzFVyOzLcCfMgdRPLUM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lRm3ned/BUYf6GvWxpgCOO8QFq0tstqJRUiEyXTgUmphlSq/KNZ2g9vEMjPaJN6fZ
	 53QIPBAUNEr3J/bMDqJoy69IctFdFrPzJ0TWsquINlXC5lylaZd+8DyMVrD3tZDnBk
	 wN1LVVuCmiXu783iLZ4z/XCDcwO1srFHyECKo46pcCOhcsAczakaHtizpRdzFBF6IB
	 ZoEUMHAFNWBUgq/Sf2sDD0vXxyQ96348PWD4b6HNpzfxouzpUMB/LNeFGoZSDiDbDA
	 kc5hOWbt7EaGrET+x+asYSMybMdx/L54cfuj4+G701/BbW/fXlCSJIwkY2V0vwd0Oh
	 hKBKiRD/J6T+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F09C021B8;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH v2 0/4] Miscellaneous Apple RTKit fixes
Date: Wed, 26 Feb 2025 19:00:02 +0000
Message-Id: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJkv2cC/13MQQrCMBCF4auUWTuSjClUV95Dugjp1A5oGzIlK
 CV3NxbcuPwfvG8D5SSscGk2SJxFZZlr0KGBMPn5zihDbSBDrSEy6GN8MOoS8CkasG05WHK2c+M
 A9RQTj/LawVtfexJdl/Te/Wy/64+ifypbNGj9yY/u7Lzr/FUzz5FXTseBM/SllA9SysEtsAAAA
 A==
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=wRpTgVNyj3uFgb5wwu79FFUhOzFVyOzLcCfMgdRPLUM=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/r+lF0rtmXPCKrcHZwkdkdrq9kvHjMe3mcezRsknjxdt
 ERMTVyqo5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjARrQaG/zHO/8T+hOSnBcwU
 Yw9u38vbtfb/l+/zvW9eiuPY+cD2GhfDf3fjQ68NFCcdn3JxEtuRx7IqsixdG2dIrJ8xgfHQ1oV
 cAvwA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

Hi,

This series contains four unrelated minor fixes to our RTKit driver.
These are mainly required for drivers which aren't upstream yet but
have been part of our downstream tree for quite a while now.

Best,

Sven

---
Changes in v2:
- Changed commit message for APPLE_RTKIT_PWR_STATE_INIT to make it clear
  this is a behavioral change
- Added a comment for the new oslog logic that the asymetric shifts are
  indeed correct
- Collected r-b tags
- Link to v1: https://lore.kernel.org/r/20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev

---
Hector Martin (1):
      soc: apple: rtkit: Implement OSLog buffers properly

Janne Grunau (3):
      soc: apple: rtkit: Add and use PWR_STATE_INIT instead of _ON
      soc: apple: rtkit: Use high prio work queue
      soc: apple: rtkit: Cut syslog messages after the first '\0'

 drivers/soc/apple/rtkit-internal.h |  1 +
 drivers/soc/apple/rtkit.c          | 63 +++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 25 deletions(-)
---
base-commit: 00834971f0d9e38beae37e92055b1432782827d0
change-id: 20250220-apple-soc-misc-55ec124184fd

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



