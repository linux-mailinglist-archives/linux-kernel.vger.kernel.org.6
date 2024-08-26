Return-Path: <linux-kernel+bounces-302077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E295F98C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A906B222A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4746199243;
	Mon, 26 Aug 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2HnS3eV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BC7A15A;
	Mon, 26 Aug 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699904; cv=none; b=tohhZC5EQlLMZI1jHz3qIi/6m1RV69iqB0dWmGzSEceL4/3qH2XFYoj9058Z3xKqdwK6nDr0MgbOxjmkxRqcOCBfR8Mhg4dxPAeJgaOW0Xx2gY4XjJ841hnN9ULvqBYJajHtAJUHzJ8XGLUieT/CHbjtz1VY+JClpQWoqGw30VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699904; c=relaxed/simple;
	bh=V0uRwbHGFT0hnqRfD3rsPaGQbmmBOqjtGOD9Tut0qNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4aLg/rvgDXAX6LUfdTh5Ev7TPqMi4V52eN4v9nj1fcgoEJ9xnpGXqsYUejRFlzRNk24O/+LucawXCS4GGNRWL4PGSLuSw1KsyTWtdaBukx+8pKwnIEYxND+NQ2uI1ZX0WC4qLVnYDv8bCmQXw9oaLJPfh8CYixliynXRfy/lVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2HnS3eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A706C4FF6C;
	Mon, 26 Aug 2024 19:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724699903;
	bh=V0uRwbHGFT0hnqRfD3rsPaGQbmmBOqjtGOD9Tut0qNk=;
	h=From:To:Cc:Subject:Date:From;
	b=r2HnS3eVr3U0gUojBSugB1keReT16PKzoHDYdKwV9Ug2FuUevKUAWyCNwOxqdyLXY
	 iIhIennDpQxmXmxrh+UrgaJvz1Jgb287LnVBvGDlnO6UBvzw2D/Yt4vBNMK1NpxO+2
	 9tTh7PQUuO0EhCou2AF5tyMkk6w4vnyOILwT5ZI/dXvBWi9mJ0djVFILdvAbbSMlT7
	 GBiqZTixVcs9++kQG0j0k1kfaMIVzz4bJ2o9yHZvciCj3f2EM1YyuVenPvxewEmYHN
	 jDVBKcNckQtj72gwLzQoAXxy61KcBTIk0ArqTaG/TT9lNHuYB/FZJ1Uvw7drR20fAK
	 txGBDuzbLFSxg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: stts751: Add "st" vendor prefix to "stts751" compatible string
Date: Mon, 26 Aug 2024 14:18:11 -0500
Message-ID: <20240826191811.1416011-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documented compatible string is "st,stts751", not "stts751". Even if
"stts751" was in use, there's no need to list "stts751" in the DT match
table. The I2C core will strip any vendor prefix and match against the
i2c_device_id table which has an "stts751" entry.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/hwmon/stts751.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/stts751.c b/drivers/hwmon/stts751.c
index e7632081a1d1..f9e8b2869164 100644
--- a/drivers/hwmon/stts751.c
+++ b/drivers/hwmon/stts751.c
@@ -77,7 +77,7 @@ static const struct i2c_device_id stts751_id[] = {
 };
 
 static const struct of_device_id __maybe_unused stts751_of_match[] = {
-	{ .compatible = "stts751" },
+	{ .compatible = "st,stts751" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, stts751_of_match);
-- 
2.43.0


