Return-Path: <linux-kernel+bounces-315569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19296C44D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6212D1C24AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28A1E0B98;
	Wed,  4 Sep 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT2JLx+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CA1E0B8A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468212; cv=none; b=g+xGdnnmDYZRs5gyPyqbFOTPSgY00S1H5MBTrCQ5vQa++eyCqwbeI3SWNf8hN3a3gmEczh5bQUUMb0xJ6vUVJ5YzwmwIXX34eK4SdrnCBRV+F58wigiAucccsqoAhLAAz4y23aNQ3MkDi6JeERe6bibk0VpCyBDTu4xD6J5h2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468212; c=relaxed/simple;
	bh=26ZEl6QMKJ5v4vPy/HIvc8nMTK/vU9HllBLJ0W+IXgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8clY9dbjoGJXWlLUU13hGTG+m1nnZHgYtk74tftpMmIbQ77L4thimnJEn2tiZlqn/nFwyo1lHld2Q2tNzRs65F6zAwCneCQ6EhGjH/zCs+BHwSCqYn4w4bHqbLaOyu0CQaGuxT4UraJMlzjJrTDyCSiXDmOwvWYSanneVgmhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT2JLx+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F965C4CEC6;
	Wed,  4 Sep 2024 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468212;
	bh=26ZEl6QMKJ5v4vPy/HIvc8nMTK/vU9HllBLJ0W+IXgc=;
	h=From:To:Cc:Subject:Date:From;
	b=WT2JLx+ZIk66a3uGF1jyhPMh6kZp+/qvcFgvk2raTzdHJ+HTp+IpetQI6y74d4iwm
	 5R7XA/0WCfDqswvoR4rNp1tvGYzWw0BdKus9EbaSX+VLnfxxSk4ALExdWFh9/aOx9A
	 BoWzoUbfKS8nJukwi0O+3lXGmJ2hm9FjaCOVmHnOGEfYXMmGRiZKaCODsuRLaECFJz
	 FvdIpQiIL0eF68lEK55dLl7Y5HR+kLIWghm6RiIYQ5lvHcyUuSTHSrUEzkHcqpV3XI
	 KZevSpKa+1ZVVXlcnHiA659HmCbQhiA4AbO9PjiUJfdvwxuRKT2X/90M5VgN1Rru5Q
	 vzvqHmMoWWsaQ==
From: chanwoo@kernel.org
To: linux-kernel@vger.kernel.org
Cc: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	hdegoede@redhat.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] extcon: lc824206xa: Fix build error of POWER_SUPPLY_PROP_USB_TYPE
Date: Thu,  5 Sep 2024 01:43:25 +0900
Message-Id: <20240904164325.48386-1-chanwoo@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephen Rothwell <sfr@canb.auug.org.au>

commit 364ea7ccaef9("power: supply: Change usb_types from an array into a
bitmask") changes usb_types from an array into a bitmask. Fix the build error of
usb_types variables.

Link: https://lore.kernel.org/lkml/20240831142039.28830-7-hdegoede@redhat.com/
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1
- Update patch description with correct commit

 drivers/extcon/extcon-lc824206xa.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-lc824206xa.c
index d58a2c369018..56938748aea8 100644
--- a/drivers/extcon/extcon-lc824206xa.c
+++ b/drivers/extcon/extcon-lc824206xa.c
@@ -393,14 +393,6 @@ static int lc824206xa_psy_get_prop(struct power_supply *psy,
 	return 0;
 }
 
-static const enum power_supply_usb_type lc824206xa_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_ACA,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-};
-
 static const enum power_supply_property lc824206xa_psy_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_USB_TYPE,
@@ -410,8 +402,11 @@ static const enum power_supply_property lc824206xa_psy_props[] = {
 static const struct power_supply_desc lc824206xa_psy_desc = {
 	.name = "lc824206xa-charger-detect",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = lc824206xa_psy_usb_types,
-	.num_usb_types = ARRAY_SIZE(lc824206xa_psy_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = lc824206xa_psy_props,
 	.num_properties = ARRAY_SIZE(lc824206xa_psy_props),
 	.get_property = lc824206xa_psy_get_prop,
-- 
2.25.1


