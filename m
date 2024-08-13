Return-Path: <linux-kernel+bounces-284040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEEE94FC49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F7C1C22429
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EE1B970;
	Tue, 13 Aug 2024 03:34:32 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7051CD02
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520072; cv=none; b=BOp+XGJSGmgX38Mib9T3/5HpM9klxnpIryEE+eVa0WgwSmuKf9sEZZ2LiLYYFvxwGYRHt94cJKUSaZ2yAjsAzh292wVSJuWRJLVZtO4OSnUutawJHsOsEkPkZ2wRXaz4ye0yC/xUtsp2bTqhzKWJQP7B80Shz6v5i3aGlxXzTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520072; c=relaxed/simple;
	bh=eTm18ZngRiVimKMmAP6CJfhETHdjVT6K9NFBjTNn5pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsUdJ4Tf5dewa/HGd5jzafXeSg2DR7Gi9eZj82FRam1slE5h/LWsCwK0WmBXhlZfm00yiaVT/oWApqLzBrl5Cpzerj37vMPshYGabqGVZzJ3m/lfpmpQqND3l7Tp3QtxVK00XathykCoDyea6keCnSqi87v/TaodJmT6vrQwlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666bad37d751-0000c;
	Tue, 13 Aug 2024 11:31:16 +0800 (CST)
X-RM-TRANSID:2ee666bad37d751-0000c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166bad36f405-aab6a;
	Tue, 13 Aug 2024 11:31:16 +0800 (CST)
X-RM-TRANSID:2ee166bad36f405-aab6a
From: bajing <bajing@cmss.chinamobile.com>
To: w.d.hubbs@gmail.com
Cc: chris@the-brannons.com,
	kirk@reisers.ca,
	samuel.thibault@ens-lyon.org,
	bajing@cmss.chinamobile.com,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] speakup: genmap: remove redundant post-increment
Date: Tue, 13 Aug 2024 11:17:53 +0800
Message-Id: <20240813031753.5902-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the while loop, the variable lc is unused and is reinitialized later, so this redundant operation should be removed.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 drivers/accessibility/speakup/genmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
index 0125000e00d9..836276327bdd 100644
--- a/drivers/accessibility/speakup/genmap.c
+++ b/drivers/accessibility/speakup/genmap.c
@@ -72,7 +72,6 @@ main(int argc, char *argv[])
 
 	open_input(NULL, argv[1]);
 	while (fgets(buffer, sizeof(buffer), infile)) {
-		lc++;
 		value = shift_state = 0;
 
 		cp = strtok(buffer, delims);
-- 
2.33.0




