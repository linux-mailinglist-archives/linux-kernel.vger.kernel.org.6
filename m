Return-Path: <linux-kernel+bounces-305036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900A962876
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4597F28208D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA63187858;
	Wed, 28 Aug 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tho+4tKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6B18030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851140; cv=none; b=Le5aypHuQU/Rh/X0g6idEiR7ssMRz/+MPLjhwQqQxr9Y8+XNvcyxNd8b2tr7u+wF40RPEy1ea/wFal1PhDE3XxI/6z8jPvHVx/f/J3cPDxv0Bc8N53fBbBpT1Doksjlwf7Q1rq7ipoMRq1P8sHbUpwDlo4vZYc2G7fe3EU9IYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851140; c=relaxed/simple;
	bh=QDj25RmywIqrl5HDD5BjvREStBkTY8/Lk7ojibhewn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfwZQO8edv2jQLJTvZomPsE1/p8AbghjrnpZ0GCwimdvi+NshbH0KI1+CjbwAUVcAQhzIYTZBO1wEkfJgJXsUFuYxqyHR8gng+dBCItf9r18FetDRTmv013NbQlPmzahJLOuL+kXI9IfOskGT8RvAQE5fHP3aMGZLEVCQKJAKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tho+4tKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B93C98EED;
	Wed, 28 Aug 2024 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851140;
	bh=QDj25RmywIqrl5HDD5BjvREStBkTY8/Lk7ojibhewn8=;
	h=From:To:Cc:Subject:Date:From;
	b=tho+4tKJsO1Dme9HAP23Vp7Kc/tgh3hcfkY0KOqOZVXvUnxWm7dL1p2h7QP5H4rCB
	 XtHpP64FC84ctjLNNqge4wlpneKDT93/70u9HefWfy0ovl/KABKcSTBosWoSUYfBPJ
	 nB9aM7zFblOC2sKneceElip00rAGD+JUsrh+8BghqJ2G+UekYmt2LLdIQWwRblfJOw
	 rXqGbz3oHKPqRf3tHYEb9KQZj2zYyNfDPkN9xGvDMBdWR2fgLTezjKPE2GMea8JSXM
	 BoFFl4MJEZ2aOD35NJo9P5ePR2LytiiLRmL/KX0GParNincqigXuR6kv+YO72iJvxF
	 hebl25goSiQXA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eric Piel <eric.piel@tremplin-utc.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc: lis3lv02d: Fix incorrect of_get_property() usage
Date: Wed, 28 Aug 2024 08:18:51 -0500
Message-ID: <20240828131851.3631855-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of of_get_property() is wrong. What's returned in "val" is
the property's length, not the value. Fix this by using the preferred
typed of_property_read_u32() function instead.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 49868a45c0ad..1fc635a27568 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -1038,7 +1038,7 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 		pdata->wakeup_flags |= LIS3_WAKEUP_Z_LO;
 	if (of_property_read_bool(np, "st,wakeup-z-hi"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_Z_HI;
-	if (of_get_property(np, "st,wakeup-threshold", &val))
+	if (!of_property_read_u32(np, "st,wakeup-threshold", &val))
 		pdata->wakeup_thresh = val;
 
 	if (of_property_read_bool(np, "st,wakeup2-x-lo"))
@@ -1053,7 +1053,7 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_Z_LO;
 	if (of_property_read_bool(np, "st,wakeup2-z-hi"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_Z_HI;
-	if (of_get_property(np, "st,wakeup2-threshold", &val))
+	if (!of_property_read_u32(np, "st,wakeup2-threshold", &val))
 		pdata->wakeup_thresh2 = val;
 
 	if (!of_property_read_u32(np, "st,highpass-cutoff-hz", &val)) {
-- 
2.45.2


