Return-Path: <linux-kernel+bounces-171137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90EF8BE01E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2636E1C23509
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A16152531;
	Tue,  7 May 2024 10:47:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8B14F9EA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078835; cv=none; b=KtOuZjrKbstCzWhh54DPkcfwEuTlMYFDyiT9AjJJ5M5w5RK0h+VreCGicg0vcYc4CsXZXl6/ZA3e3Wz19I/jReo7PqaZ08oMKuKkYAz09b16g0sdHdXR1mDeLc13g3TpQ/PU4uwuSyX654jycTZ5+DiSguN1DXz3ge7RiZvroJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078835; c=relaxed/simple;
	bh=Gw8Zom3D8btPf6vtzeSGuggXTkWgxf1voK1wa68RzzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LE3CFKZumK1akA3X0JawXBXA5ZT4MIrRjcaVk6pgO286TVKkWURS7TEU1qBRCLWXfoGUNLU/MfIFmtCFUghzpcZA908FjeNUyQijwv47pW2V/XOW+x2G8tJr1ZJj2sPzH7RvpA9i/YG36WUETpwCwwDX7wV6iVqxQQ9szIhlwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4ILm-0006UX-KK; Tue, 07 May 2024 12:47:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4ILl-0004r1-Nn; Tue, 07 May 2024 12:47:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4ILl-00HHWK-27;
	Tue, 07 May 2024 12:47:09 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] regulator: Mention regulator id in error message about dummy supplies
Date: Tue,  7 May 2024 12:47:02 +0200
Message-ID: <20240507104703.2070117-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Gw8Zom3D8btPf6vtzeSGuggXTkWgxf1voK1wa68RzzE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjQrtuVv00MtS5Xmvv8YkcCx5UKswKX0RoGCYKMMrWV/J havMmbsZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi3gzsf8Wzv2WbOlQyvT68 6FHCtA37+H53GLOudFk6rSY5eVHa9UcuK9f7s/f0fzt+s+U1j1Ot4IMe5q0mmRw7LXsrBSdN9jr U7zfXLpvrQ4n1lsaNuhcZl2YyiKj+Pmw9gfuznOpiEQf79Scld0ysZik34OzsqJr0bfrv6IuR51 xfHjH88cj37acc0/xb9p2hmztOtoUu82/UM8jU3V7ItFoiPiTztbpG0QPbxeV29ZcsnFaZCla/+ Cd1kLX5xnzF2L2fiiWPrkvTOrFuf8yBjqKFmbqaB79ZOhhKHCuSu12SpnDISO6bSsrlkPrvl9sZ phb1+oVIcFyIVW+ecEm9IbSl8rfaO/3Mz11bdKsVvkoAAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With the name that is currently looked up it is considerably easier to
understand the issue and fix the warning.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dabac9772741..30f8e46dacdd 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2195,7 +2195,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 
 		if (!have_full_constraints()) {
 			dev_warn(dev,
-				 "incomplete constraints, dummy supplies not allowed\n");
+				 "incomplete constraints, dummy supplies not allowed (id=%s)\n", id);
 			return ERR_PTR(-ENODEV);
 		}
 
@@ -2213,7 +2213,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 
 		case EXCLUSIVE_GET:
 			dev_warn(dev,
-				 "dummy supplies not allowed for exclusive requests\n");
+				 "dummy supplies not allowed for exclusive requests (id=%s)\n", id);
 			fallthrough;
 
 		default:

base-commit: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
-- 
2.43.0


