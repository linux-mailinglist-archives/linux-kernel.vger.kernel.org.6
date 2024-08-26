Return-Path: <linux-kernel+bounces-302070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C0995F975
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F071F22D87
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D71991BA;
	Mon, 26 Aug 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfmbDiJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AA18E058
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699598; cv=none; b=FgTX9UoNImxI7ogh2W60TrVkboMlt2GN23JbQaK1r85vzAb66u4M3EgIcXjn8Z2vDvqr5ADhUVJgr8xWW3inGzksjCbTW7WueGNfc861beLZE8d9VCJo4LBtVP85wrIcjceQ2AZS8g5tRMGoGvvvDCuqsVgw4jmo5nnbcIk4wOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699598; c=relaxed/simple;
	bh=jzfVwV+qAA5RAstlTnwawRr7jscEqIss+6fByV8Ic9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jvu+k2VCgaW6UE/I/NdWAyXVuzI8vmQeL9E6bVeFJSZWnoBrwVbZwSNEbLdDCjChr1j99z3yrcN7TqSfJSKPKoCXVG+pbNMdQwgcxSqjuS3JD4BxwsRe6rhMoE8ttbxV5sR3gqp7ePeFvac1UfBh2qUav8JupfIq/pglWuyONng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfmbDiJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F1CC4AF67;
	Mon, 26 Aug 2024 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724699598;
	bh=jzfVwV+qAA5RAstlTnwawRr7jscEqIss+6fByV8Ic9M=;
	h=From:To:Cc:Subject:Date:From;
	b=qfmbDiJUO0VnlvzXrvZZhT5/1nsU+5x8PYkfb1Iaz0d61Yf9fpJTc7aICRPc6Qgrw
	 FcRcMkQCGPTv0Voaz+fUYbEL3QQF3ZuhOa+R5bQsC3oVIR6HibMnRqHxkLsQ/PjmgA
	 oOre8xPm69ePVm2S45u6cqwETI4yDRzGGK9UUwTk3ZUE/2k5B10OjCr9rz2vDBiyUS
	 9he+0KBJFK7V9AT8GV3JqXA2l3R8vFtR/oEg6Mup2lJmSdxVFBBHt0tLTIsjnR020Q
	 gzqD8hQnUz2c5ArozdxIX9/rPlfyq5QnWEftBG99rEBJzGNWCBhC0ZEbJDWfftD3ni
	 OJGByOrEJT4Nw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: tc3589x: Drop vendorless compatible string from match table
Date: Mon, 26 Aug 2024 14:13:00 -0500
Message-ID: <20240826191300.1410222-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to list "tc3589x" in the DT match table. The I2C core
will strip any vendor prefix and match against the i2c_device_id table
which has an "tc3589x" entry.

Probably "tc3589x" and TC3589X_UNKNOWN could be removed altogether.
Use of that compatible was only on some STE platforms and was dropped
in 2013. There were ABI breaks in 2014 claiming no DTs in the wild. See
commit 1637d480f873 ("pinctrl: nomadik: force-convert to generic config
bindings").

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mfd/tc3589x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index db28eb0c8995..ef953ee73145 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -312,8 +312,6 @@ static int tc3589x_device_init(struct tc3589x *tc3589x)
 }
 
 static const struct of_device_id tc3589x_match[] = {
-	/* Legacy compatible string */
-	{ .compatible = "tc3589x", .data = (void *) TC3589X_UNKNOWN },
 	{ .compatible = "toshiba,tc35890", .data = (void *) TC3589X_TC35890 },
 	{ .compatible = "toshiba,tc35892", .data = (void *) TC3589X_TC35892 },
 	{ .compatible = "toshiba,tc35893", .data = (void *) TC3589X_TC35893 },
-- 
2.43.0


