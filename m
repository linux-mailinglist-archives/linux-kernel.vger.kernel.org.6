Return-Path: <linux-kernel+bounces-428599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AA9E110F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83798164717
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF281ADA;
	Tue,  3 Dec 2024 02:06:02 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B9219E4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191561; cv=none; b=D7kfcpwAqLxe8e8TxP1RSW2lkP3M/t/VuWG72a1rTqHovr0faJPb3UKgN95B60YE4zLlBhXtfcW34v84VxWSn7nyB+wtmwTVB7fbMhCzMBV/HwRIyLUojbTUOx418YXIY86Ha1ceIHEd2ufMeS/IU50uhhbMV0bU6H9pqi/uYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191561; c=relaxed/simple;
	bh=M8XZygseboVCZLiAytY3CJrNjwjk7uve6eHCfdh/Pck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGo0IzjqlkGeZdvJtA3Hd1HootSfcIEp+Aai+k91Yd5aK4gfruN9H37rjmKKL4M6AN90x42P7M5sB3SeuQxeTZ9183U1oPv76Q8fvl3vXp0cDaNGcxW017SonshoUyD4XRkUFjvoMDOhlB2A5SxM1WkOSTtV8AtKEdc9EqgI6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5674e678085a-bc871;
	Tue, 03 Dec 2024 10:05:52 +0800 (CST)
X-RM-TRANSID:2ee5674e678085a-bc871
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9674e6780fc6-0f9e7;
	Tue, 03 Dec 2024 10:05:52 +0800 (CST)
X-RM-TRANSID:2ee9674e6780fc6-0f9e7
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: thomas.orgis@uni-hamburg.de
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	ismael@iodev.co.uk,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] tools/accounting/procacct: Fix minor errors
Date: Tue,  3 Dec 2024 10:05:50 +0800
Message-Id: <20241203020550.3145-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The logfile option was documented but not working.
Add it and optimized the while loop.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Reviewed-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
---
v1->v2:
	Add logfile option.

 tools/accounting/procacct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/accounting/procacct.c b/tools/accounting/procacct.c
index 90c4a37f53d9..e8dee05a6264 100644
--- a/tools/accounting/procacct.c
+++ b/tools/accounting/procacct.c
@@ -274,12 +274,11 @@ int main(int argc, char *argv[])
 	int maskset = 0;
 	char *logfile = NULL;
 	int cfd = 0;
-	int forking = 0;
 
 	struct msgtemplate msg;
 
-	while (!forking) {
-		c = getopt(argc, argv, "m:vr:");
+	while (1) {
+		c = getopt(argc, argv, "m:vr:w:");
 		if (c < 0)
 			break;
 
-- 
2.33.0




