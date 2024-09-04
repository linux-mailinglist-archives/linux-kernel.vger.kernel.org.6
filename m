Return-Path: <linux-kernel+bounces-314805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5596B949
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1040B288317
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045751CFEAD;
	Wed,  4 Sep 2024 10:51:49 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E71CF29F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447108; cv=none; b=U0WeT6EynmR0+lrMTbLJRJ6a1zdagfxA2JfF9hj2MPLeVKIkh2gFi7NLUKRtFBUcpLuXmYCAQZxTKHpptb03AGeJWNSwWQqct+3MKNZoTZh2QSrNfPz9AqleENYO25O0q93VkcN4398aYxb+KfYSzvd9LExXagTOff261AyPXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447108; c=relaxed/simple;
	bh=nkBQ73HymBZt/bsPEBtUyaZPA/L7p+A9eg/ZaQ6jDBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUDR3a+t1LB7xlZ68a9iUS7Y9bSJ4K6pmRZYQKZtD4q/U6GRZy93du/zHSeUro+MaN0HDYoY9Jo+AyxNvJaSWVHnisHv1DILp2NrIs9UmmybjVX29GI9eWoFIBzho/d2lKgh+pkqjpmZLAznYBtKvSwpsuPSyhWsP4QWVsTcgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566d83bbbc68-e5c6b;
	Wed, 04 Sep 2024 18:51:41 +0800 (CST)
X-RM-TRANSID:2ee566d83bbbc68-e5c6b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d83bbc3fe-25b17;
	Wed, 04 Sep 2024 18:51:40 +0800 (CST)
X-RM-TRANSID:2eea66d83bbc3fe-25b17
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] delayacct: Fix missing free
Date: Wed,  4 Sep 2024 16:59:51 +0800
Message-Id: <20240904085951.104910-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Free string allocated by strdup().

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/accounting/getdelays.c | 1 +
 tools/accounting/procacct.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 1334214546d7..b08d3e2c871c 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -562,6 +562,7 @@ int main(int argc, char *argv[])
 			err(rc, "error sending deregister cpumask\n");
 	}
 err:
+	free(logfile);
 	close(nl_sd);
 	if (fd)
 		close(fd);
diff --git a/tools/accounting/procacct.c b/tools/accounting/procacct.c
index 90c4a37f53d9..28825fd68a12 100644
--- a/tools/accounting/procacct.c
+++ b/tools/accounting/procacct.c
@@ -403,6 +403,7 @@ int main(int argc, char *argv[])
 			err(rc, "error sending deregister cpumask\n");
 	}
 err:
+	free(logfile);
 	close(nl_sd);
 	if (fd)
 		close(fd);
-- 
2.33.0




