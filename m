Return-Path: <linux-kernel+bounces-427917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC39E0773
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1355F280D65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B64B5C1;
	Mon,  2 Dec 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NG6YzGtI"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D94204D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154417; cv=none; b=RJGCnpPT6UjafTSBMDBN3dWHLkQNlcey1KFFbMhWEVGnfUghaLv3vl/lFQR+gUuIF2AaAReao9xRhEOU+1219oYFxwZfmo+9AznOE1abwzRIbjKeABRbMjgZTuFVcHoJQyeiZt7wVpS4cIL1Tyi/xyi25eEdVjEWCHsdCoyxVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154417; c=relaxed/simple;
	bh=Tx+ZLe2ZIJV/zaCLAnlNZO8r+QVu0lMIp/IrqxEUi/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4HA0u9EWtwgOEHpXksM4b4aAoe/CRwhQpO/0IZJLAU+Y8eJOXtjHsvLq7dNKNGQjU8TCsv+P1dtmwirux2MazxImE3X3MpUTwkgTMNKiMY+VkiEqul9Q4JMILsTa3l+pV7C6/f8vHDVtu64/ihwKli2VMb7smDS3yIR6iExZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NG6YzGtI; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733154413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VEgBfFikoD7MHQLGzfVrQiZrtnF9fKdquPoRWlqKtgM=;
	b=NG6YzGtIjaATUX3/UDc+RJCuQrfzV4IAyw/+RCqCfcmjER1LJpGTGDU6gJ0WOInBCyMHOr
	F/o+ghUL/VJfEPRoHIwxMaAxtttIhIW9UHRs1ekqFVvt5Jf5R+fd6PoGZhOt7cTsViPt/L
	JMV5wcf+H3yNCecdy6jRQn+esQS9BLY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Erick Archer <erick.archer@outlook.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: joystick - use str_off_on() helper in sw_connect()
Date: Mon,  2 Dec 2024 16:46:00 +0100
Message-ID: <20241202154603.1193-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_off_on() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/input/joystick/sidewinder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index f6e92db4d789..3a5873e5fcb3 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/jiffies.h>
+#include <linux/string_choices.h>
 
 #define DRIVER_DESC	"Microsoft SideWinder joystick family driver"
 
@@ -677,7 +678,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 				case 48:				/* Ambiguous */
 					if (j == 14) {			/* ID length 14*3 -> FFP */
 						sw->type = SW_ID_FFP;
-						sprintf(comment, " [AC %s]", sw_get_bits(idbuf,38,1,3) ? "off" : "on");
+						sprintf(comment, " [AC %s]", str_off_on(sw_get_bits(idbuf,38,1,3)));
 					} else
 						sw->type = SW_ID_PP;
 					break;
-- 
2.47.0


