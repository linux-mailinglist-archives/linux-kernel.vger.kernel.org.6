Return-Path: <linux-kernel+bounces-253713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F869325B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D1CB245B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4E719922A;
	Tue, 16 Jul 2024 11:33:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EED1991CD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129629; cv=none; b=EdoZBgWu80B69uP49YRcDS91tN1vL0mxIM2qDLyq6HAxV6lFgBvSg2uYxFLhZupOBKuyHKSSncEnMUtZslE6oHQ1AdHntczwkW+0X19rAQUTh32cdjGU+Kur2i03vWY0mNwJ3b/OcDOkB66n+Zq/LRaHDBag43PXS0ZIG2BaoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129629; c=relaxed/simple;
	bh=OecnYhmAKmIrEHR9tlf+DLf3fBjhHDrDi+XiPTBGFL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jnP+QIDc8gVdf966FcpFWCG+4OaEiIjzTgkCDpRb3e3CJpP43x/+2aMOJr00clBP2DucLhS3FmrolIfEWQBLrwOV0lL+OfCgAHufnDmM+XKKU2/zJ77mqFJDeBkjC7g5dHXDyQAQ6ZktnipOMrZeOdD9uQfULl2a+6BTq8I2U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQz-0007kQ-8w; Tue, 16 Jul 2024 13:33:29 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQy-0007Kz-O2; Tue, 16 Jul 2024 13:33:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQy-009ho5-27;
	Tue, 16 Jul 2024 13:33:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/2] mwifiex: add support for WPA-PSK-SHA256
Date: Tue, 16 Jul 2024 13:33:26 +0200
Message-Id: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZalmYC/x3MQQqEMAxA0atI1hOoUSvjVQYXVVMNMloa0IJ4d
 4vLt/j/AuUorNAVF0Q+RGXfMspPAePitplRpmwgQ7VpS4v/U7xwwjM4DLqiLo4aizSR+/qxGow
 dIMchspf0jn/9fT+Sb3QXaAAAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721129608; l=652;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=OecnYhmAKmIrEHR9tlf+DLf3fBjhHDrDi+XiPTBGFL8=;
 b=CunJgc6ADlYPjBoQ89yj0/Mj8rq+Hp7g8NcWrMZlxGSdpa0hQFL4LQ5sxQK8m1AST07BcbtaM
 8KgEnABRBJLCpBgarmbhV7Pt/hpKEhe55aJGXFo7i7NVUMjqLyu4hLB
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series adds support for the WPA-PSK AKM suite with SHA256 as hashing
method (WPA-PSK-SHA256)

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (2):
      wifi: mwifiex: simplify WPA flags setting
      wifi: mwifiex: add support for WPA-PSK-SHA256

 drivers/net/wireless/marvell/mwifiex/fw.h      |  1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 30 +++++++++-----------------
 2 files changed, 11 insertions(+), 20 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240716-mwifiex-wpa-psk-sha256-2d2a9fc3b06b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


