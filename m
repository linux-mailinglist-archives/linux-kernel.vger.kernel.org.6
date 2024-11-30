Return-Path: <linux-kernel+bounces-426122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8399DEF3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF88BB215CE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E29146D6B;
	Sat, 30 Nov 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WiS74vGm"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565343F9C5;
	Sat, 30 Nov 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732951514; cv=none; b=E4il0swQVYigPnWnduHBrkD+fjrPXypUEsydl5yQBnB17T/mfJiG8VschXToMPirHgV7RIGznWu+4zbKNzpgyRuclFFy1lOf0moWVvZU1pZRb5rSqtQAMM0vl0LZfoB1fb6IZ+NCV36e7gwEbVqQ9MZXRPwGgC8JgC5B/J9oXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732951514; c=relaxed/simple;
	bh=LICcckQkru5CpGOmAfj2wJHeUlAGjzb19Eq74fabSP4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=H/A21EeKUwxPAg5+5aMkSAR41irO1LYbCTUvoSqTqTiYJ/4LIf6BdsFLz8wAVGM94wsOX6pNpuTudr/yhlVkrQQUgcouuw0f0OrWqD4BHSK1uVQ4ZPpK9no1V+8yqjErkOr579TEsFdOV8QoU5o+qsSisZd8dvxyNOjI1622bcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WiS74vGm; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732951204; bh=+hzNBE9amkyYQdP9ayXOyy9tr1GoK7JE/JfLRn4dZDA=;
	h=From:To:Cc:Subject:Date;
	b=WiS74vGmJzs+Gp/eCzEcy4jK8XQdTtcpT1PFg9h6RbCzhjdd2r62PlpUnLLckEvbB
	 tzxg5NnQjUnL59Aec5CVr8zzms4pMHxFlTWO+kJLxjYCrzVLQ0Q2tgowZOwgDHvotR
	 WIZvZYRezQuWV4wPsQ00did8FBaBM0NVBKbTMlfI=
Received: from archlinux-sandisk.localdomain ([115.153.151.69])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 502846A3; Sat, 30 Nov 2024 15:20:02 +0800
X-QQ-mid: xmsmtpt1732951202tjysz4kw6
Message-ID: <tencent_DCE08C78F5890298305882057326444C4C0A@qq.com>
X-QQ-XMAILINFO: NsET35+4SAsGeiDbM1wcA9SeIqU5HoWtlbxqNJE4pbpnFw9K+3Lb9sERzpkfOm
	 pnRJ43XoCVK9H1AYq8vSmQbPumHwe2FraVjaThndwlR0F3TJkEofpYVObI1Dt92IeAsA471vK70E
	 unoBpPHfNbRiLPp4tu/Sn7cAFXY3b70dKPBXwUJldHtqq4m3JCMaTUZuwiqbuwe5QwjYUtLNTmaT
	 jslSDuHvDWqDZ0JTO6KIo1CVIdJmZ2peQXIpRjaQkBZGh0bWHKpJE83EZywK+UcuJpgn+AtuxVMj
	 ekJwd81bMRDomgU1wsLTfluwnlalr6cR2AQqZzdXDy1wJSLrBJtx11YnzWgJpL8qrEigPVwoLgfu
	 fWfp/LALkYYNQjHb21F0D4SwBYj+PrJxXqNXbDD1OiiqEcLHxKZACUNeWZdAY+h1aWf6j3QgAjEl
	 DknwQr/VnSda5juEbFtbUaFKDc3ZFaHEL7TPUoY1sUGGrJ97fpB2JiSMDtMDKFnDEu8a3P+qC1xU
	 11cpvZRJ66yJn2XPYYrBQ7a5gPXPBnDcGdv8XFndmwM6W1wOrZR5FQB8dayP/EsWM7/OWEfOqEHj
	 whSIHUTihRGm0Su6fkhfIsTwPePZElRQnlcqMMnWqqtwcNBGDw/CF7tGjFjTIzWw+YPRiZCwx81E
	 Ny9rIAbS6kCEQWLCbNZMOnRlxmBVS5irW6C/02MPaBeXjhFaVea5X+m1b3RNQemFvJiOlrUQsoyq
	 tzjt05dl3PB7tjdj+r9dcnU+gjk9lTXCOkV3BRAggQwdeK09AV4eVVlP+DXeGa5AfoHWxddo1SLU
	 h0WKxB4oKlLIx9Y4gKnPcXmborIi6nJSUddUng3Z+23OnLa7mo4x4SC3rRy528NFeBzE21ngBM9r
	 Qla7vgwgfcmgQ5YgQ4kC277DPhJQqN98E7rUYIFusL1BbZevUlj9c7G+GwIXSlZsh2nADL5tQr
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Jiale Yang <295107659@qq.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiale Yang <295107659@qq.com>
Subject: [PATCH] sound: remove unnecessary return statement
Date: Sat, 30 Nov 2024 15:20:00 +0800
X-OQ-MSGID: <20241130072000.1091-1-295107659@qq.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A return statement at the end of a void function is unnecessary.

Signed-off-by: Jiale Yang <295107659@qq.com>
---
 sound/core/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 114fb87de..f16d78d58 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -616,7 +616,6 @@ void snd_card_free_when_closed(struct snd_card *card)
 
 	snd_card_disconnect(card);
 	put_device(&card->card_dev);
-	return;
 }
 EXPORT_SYMBOL(snd_card_free_when_closed);
 
-- 
2.47.1


