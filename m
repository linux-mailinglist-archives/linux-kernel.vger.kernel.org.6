Return-Path: <linux-kernel+bounces-201393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E688FBDFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A5A1F224FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286E14C592;
	Tue,  4 Jun 2024 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IJnTxOZx"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DC143751
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536178; cv=none; b=bsZRyC+9ultteakw8QJmUxCzP1YRnCrgRr0aKZCAewnO9WfMNGU7LIn8EI5IzN7EH5ksoSCPeg9lzOBvajEQxwzOAdj276sjbvYJpsgMf8bpUMxR9P1xsb+E2mCy3HIqlcKuDTZc6GSVdIxXPpiAAtvlChvxOCVGGa88lkSlmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536178; c=relaxed/simple;
	bh=DFk9HGUZ1dn/QPKuOhev6jWzX0n9LtYQ4BOE0bxA2m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyPtBx8vXlQQzozW9ab6CKO1WXA7bt1A383Ni6emJEERJME/mEwaw3qgMDjc44OtX64QMDblEbiSN0ZHyuOy83cxR44g36eMf3yECtJRTQDVLEvQmh98vNcxIYakpnTxntR2m9ECxEwn2/P0jotpCSx4sWrPF7B2efrBzUfXtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IJnTxOZx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=SvCvXJcfmWPlEV++5++kUpd9aH8wU2Nv8Sax1bHiMk4=; b=IJnTxO
	ZxydCmYTevZlBfAC4WX1PuEaCHF8XzKFu58gmnWJ1dclq1I7h5yp37li+TN9TKM+
	LQsbWHb6w2UbgCjSTEC3D/inuEM1/U2xT+A7unEraQpBfkc/DmBXmVVWlxT+aV8v
	4c4qdQ+4HVn3gSoxtDnURjEnWI86YrfJbIifHJgBfmp3RcX6IgwXUWlpTqgbD4Ck
	FPy2rekP3vsUjvlQJe3mDvE7QRtCh63ha09jdrFEcnEu2Cbw7hDzzouxCeWt0MOa
	2slaZQiDfejiyyDpwD0oXlTIRMul1PR/VGxTkewjYpezQiiWTO6lebD5R9kbZiJE
	epX1nzBUQHGlVUQA==
Received: (qmail 2449499 invoked from network); 4 Jun 2024 23:22:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:22:53 +0200
X-UD-Smtp-Session: l3s3148p1@dC9/DRcaRN1ehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] misc: ti-st: st_kim: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Tue,  4 Jun 2024 23:22:39 +0200
Message-ID: <20240604212240.4529-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
References: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_interruptible_timeout() causing patterns like:

	timeout = wait_for_completion_interruptible_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/misc/ti-st/st_kim.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index c4f963cf96f2..ff172cf4614d 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -198,7 +198,7 @@ static long read_local_version(struct kim_data_s *kim_gdata, char *bts_scr_name)
 {
 	unsigned short version = 0, chip = 0, min_ver = 0, maj_ver = 0;
 	static const char read_ver_cmd[] = { 0x01, 0x01, 0x10, 0x00 };
-	long timeout;
+	long time_left;
 
 	pr_debug("%s", __func__);
 
@@ -208,11 +208,11 @@ static long read_local_version(struct kim_data_s *kim_gdata, char *bts_scr_name)
 		return -EIO;
 	}
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 		&kim_gdata->kim_rcvd, msecs_to_jiffies(CMD_RESP_TIME));
-	if (timeout <= 0) {
+	if (time_left <= 0) {
 		pr_err(" waiting for ver info- timed out or received signal");
-		return timeout ? -ERESTARTSYS : -ETIMEDOUT;
+		return time_left ? -ERESTARTSYS : -ETIMEDOUT;
 	}
 	reinit_completion(&kim_gdata->kim_rcvd);
 	/*
-- 
2.43.0


