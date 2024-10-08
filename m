Return-Path: <linux-kernel+bounces-354514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673D9993E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22321F22324
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19A13B2B0;
	Tue,  8 Oct 2024 05:55:12 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7C762D2;
	Tue,  8 Oct 2024 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366911; cv=none; b=OrlbHWc2BUqtcxLqSKNCp9Fh5z/t3GP834UUKYdOjf/Fs7DafkkmLcMjhwXVKIAvasGA0BJ6VAoY1+b4JFvDhWI1ycTeVnjosEOANwx1hvqzR0ouaA3NzyYBZf/eL0vwD/pk942rcMgJGnTUXXeGPuh0LtJ/h89whZ/gmgb/R34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366911; c=relaxed/simple;
	bh=PYmwgXpWrt1phEqTis9Rx2QkoWAdT+7VWDXsAxD5Acg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eEz/OdqPMoKMY4Cse082oA7JJYXuqQxy1nVcaO8ncEEmQOmlqr5qqGNfnENV8Xo5kJL9ZgY5eLO9dOISypQH+xlYXDVuxgzY83z2uvp8pB2m3TTndupXwBmxrG/poJuOAGmky3DtvTSmi5Nq3WoRsktDSlKD1xwzBFgD7Pb7ZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16704c87b1af-b0ab5;
	Tue, 08 Oct 2024 13:51:57 +0800 (CST)
X-RM-TRANSID:2ee16704c87b1af-b0ab5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36704c87bb1f-90696;
	Tue, 08 Oct 2024 13:51:57 +0800 (CST)
X-RM-TRANSID:2ee36704c87bb1f-90696
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Sound:dbri:Fix formatting issue in dbri.c
Date: Mon,  7 Oct 2024 22:51:55 -0700
Message-Id: <20241008055155.11798-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changed sprintf format specifier for rp->start from %016Lx to %016llx
to correctly handle unsigned long long values.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/sparc/dbri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 050e98f32d36..b5d53c5550d3 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2616,7 +2616,7 @@ static int dbri_probe(struct platform_device *op)
 	strcpy(card->driver, "DBRI");
 	strcpy(card->shortname, "Sun DBRI");
 	rp = &op->resource[0];
-	sprintf(card->longname, "%s at 0x%02lx:0x%016Lx, irq %d",
+	sprintf(card->longname, "%s at 0x%02lx:0x%016llx, irq %d",
 		card->shortname,
 		rp->flags & 0xffL, (unsigned long long)rp->start, irq);
 
-- 
2.17.1




