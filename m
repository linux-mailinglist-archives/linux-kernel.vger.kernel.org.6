Return-Path: <linux-kernel+bounces-315531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A7496C3CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224E7281D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE381E0B80;
	Wed,  4 Sep 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEnVA0Xj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB81DCB0A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466541; cv=none; b=BXTCN8XLrh+3CFeH1r1MvK1FsQxaZwdz+UvPZWTdaBEGbEmhf+cBQrORb0Gajihg4cIEUczYRXJTFQLK939ZHFQYv9ULnLTrX3OVM9Cjjhp/5odEGQXAKdYu7HzGwn6OsDfIQ5Q06KOfWasfxJTOd6IkUABNq4PJoXQq1finyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466541; c=relaxed/simple;
	bh=Ulwka/c5hH8eKKdzzPSardKglUJGwOJBPsiGJbzHoUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ui5iPqWXZJa5tjhykVdtl9eitikmF486HsjcZ0zEUIQoRM3oxSG67OGiPOa1NTGHMTIwJNliM0UV0ckf6pv/f3mKyqjB2ZWOgdVcFBWFmcCbTntZAklTgfXvX2HIwrtgbfXgWq71vcj2chAC18+67LkF0ug9wUa4q3ZcA6A1LGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEnVA0Xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29980C4CECA;
	Wed,  4 Sep 2024 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466541;
	bh=Ulwka/c5hH8eKKdzzPSardKglUJGwOJBPsiGJbzHoUw=;
	h=From:To:Cc:Subject:Date:From;
	b=BEnVA0XjcG3FoDPu2p5/vWt2MBYTcSUlcDsesX5LvVLhS3qoLqLChODm4gzkFnitG
	 fidsrF8CFSpjqXdDKot5u+MphyI2OmVRSOGiY3+eQEMEaRAbL3N1EtWHfn73abDv1k
	 CKo1X/oMvhbJsZEW10plQ/kUexFelj9r5VIfzBNkY/iE8wfElqof/VANRQbzaef+TE
	 qCNdLGcPLiiVQ3mygR9e1aq01fvtaBhL1m2mojrVKxbg9ckf154HVs6wJvHImm+wnT
	 UOlJYLUGZRDfQ0uq3YV9K8I28ygw4sIJmvdYoXr8khGA8NWYZou6SPvRGbiNfXUg6j
	 UV0YpxJSbpSBw==
From: chanwoo@kernel.org
To: linux-kernel@vger.kernel.org
Cc: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	hdegoede@redhat.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] extcon: lc824206xa: Fix build error of POWER_SUPPLY_PROP_USB_TYPE
Date: Thu,  5 Sep 2024 01:15:37 +0900
Message-Id: <20240904161537.37460-1-chanwoo@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephen Rothwell <sfr@canb.auug.org.au>

commit 0d9af1e1c93b("power: supply: "usb_type" property may be written to")
changes POWER_SUPPLY_PROP_USB_TYPE from read-only to writtable.
In order to fix build error,

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
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


