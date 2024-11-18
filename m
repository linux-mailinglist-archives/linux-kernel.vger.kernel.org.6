Return-Path: <linux-kernel+bounces-412536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C79D0A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20161F22588
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CD1885AD;
	Mon, 18 Nov 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hrsaAmB0"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F873161302
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914993; cv=none; b=ItKVrhJabg2My9r/o2i24Ha6lqARWvSMLeRiZ9sZocO17U1uDpCYEPKXQPW5aYPF+hbUUJO5zv5vloJGBs1m49jO05wre+gQguYOXSr0wRAj/RMZ++RrvcmHb4zBREC4F+YIt6yyfkYxIMw6u6dXEL942RbnEd26I9L2vMgrDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914993; c=relaxed/simple;
	bh=j51QES524V6Lvo4VxS8TZ7Xq0q7gurYLsawzeKbYgJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c66Ko194Mjoca85tSsgOu37YC7AFrGnqHV/4Tr+OyBFPHTsS25x2qU83qlbUKWPcTZcyWyxYM8rHULZBm3yPPpRejkZDYi7dvKAsKlnMmR9n4D/2my6hGW1LkFnbIu86uigNdNWt059hW070koIBlIFDIw4GJju9VU1hRwMBXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hrsaAmB0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=7MvBvuTrpMs5f+v0wMZNFkx2vQfhzDzE30IHrhAS8O8=; b=hrsaAm
	B066nWAb48rZMSp6L06CZ+GYRaoy/OYs0rncSMq+V/c+quM8IYaIU3sR2Vhk/rTT
	OnCKBb3LkEiI3w9dt8xOvXaJ8QKoQyVYKH3ngreGCHDFmzpUnDc0g+1Ao5LLQDrp
	hk2KTj/n4hrIQ+7zbC2XjM4QF1AIiNe7fXuC1JFHcRcIFQbLegS0SDZ9WHUKY4Z2
	NxIlY/NR3tneY9OSaWKR7PjCCsmenapZPEf1AJgsE4EMNOIQ9HA/Xg/ZlmJzYZVB
	OXJGfwI3fWhTW3thhgNvrlad+5W/Ru3SXfR6yVSdNJB217hzdc4t8hvXkuwZH7T9
	DdocJ8XFq2tV/mlQ==
Received: (qmail 112362 invoked from network); 18 Nov 2024 08:29:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:36 +0100
X-UD-Smtp-Session: l3s3148p1@gX/34ConyNUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 03/15] HID: google: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:02 +0100
Message-Id: <20241118072917.3853-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/hid/hid-google-hammer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 22683ec819aa..1be4366f740f 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -22,7 +22,6 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
-#include <linux/pm_wakeup.h>
 #include <linux/unaligned.h>
 
 #include "hid-ids.h"
-- 
2.39.2


