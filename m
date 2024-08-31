Return-Path: <linux-kernel+bounces-310019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD14967326
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1C62832C4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0D17BB3E;
	Sat, 31 Aug 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diekuehnen.com header.i=@diekuehnen.com header.b="T7lf2pXs"
Received: from mail.diekuehnen.com (mail.diekuehnen.com [78.47.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C2524F;
	Sat, 31 Aug 2024 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.205.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725133291; cv=none; b=hBHxFFPevRvX+UTVdOJ0MEJwD34hjpfR+JK5qMHQAvqTH0RMIsVcYbf3atmfcf+YheSjW0mBND/NzqjN4bFGtBlBER98xeScWYizh/OsxSO6sV5Ob5EDFu9a0AmRngT9TbokeqVr1Y6ixA200cKOsC6hn1JlPYVbNRjPzGBhgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725133291; c=relaxed/simple;
	bh=Z01ZmUqepmagPSiRrE/hPtUaOltU1UjTBA+jKJSPPQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3SWdAch/QixgfKqa28JGsmcpKBpGEpFwfBTkQDbFHz8tbecYiVyhyOl0mXw/6laTW5ZaGubzpx7CQxEQsKZmYhDG7oSo06zutLGkB1OCaaLwiLxJyiygj8siCzW3UYlTS7PuxvyTr2NvlrGbOD57IuchynOBD5TKNNGKqJ3VqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diekuehnen.com; spf=pass smtp.mailfrom=diekuehnen.com; dkim=pass (2048-bit key) header.d=diekuehnen.com header.i=@diekuehnen.com header.b=T7lf2pXs; arc=none smtp.client-ip=78.47.205.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diekuehnen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diekuehnen.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17CBA7E699;
	Sat, 31 Aug 2024 21:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diekuehnen.com;
	s=dkim; t=1725132967;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=46QX0kuhx180X/8BVQKfdic538oR3Z6r3UiNROg8Mi8=;
	b=T7lf2pXsSKOnmASVTCVThS7v+FSiSl+ZgeUhKY/kPdUlCRCWjb+hHnoj/rHaBsnEU+lj1h
	et9GEtGPAYjp5isu1sRgRrmL44oBlOYNl/NV5dDEZecEi6aJqrfFwS90nQxUF9Ee1xOzfR
	v2tsGDtD0Se+IENU7xyLpg0q5Aelm7J5fJPJYaM56xA+2Oj2w1mbCgN9vVYdTCR/g87LZz
	ajljGKi1MYGSF5oQRQRtedXIYUjDKsc7TWxcCLmggbZmDGHqRr++uzPpm0nJQViJi2BgBF
	JIvtc23HLLmXj+BJb4lv+rNQWcYZL918sHbUp3UbCxFaJrXVcP7xqhuu+HEb8w==
From: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	peter.chen@kernel.org,
	gregkh@linuxfoundation.org
Cc: openbmc@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>
Subject: [PATCH] usb: chipidea: npcm: Fix coding style with missing space
Date: Sat, 31 Aug 2024 21:34:06 +0200
Message-ID: <20240831193407.11302-1-andreas.kuehn@diekuehnen.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fixed coding style issue: added missing space.

Signed-off-by: Andreas Kühn <andreas.kuehn@diekuehnen.com>
---
 drivers/usb/chipidea/ci_hdrc_npcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_npcm.c b/drivers/usb/chipidea/ci_hdrc_npcm.c
index b14127873c55..c89c68f41ccc 100644
--- a/drivers/usb/chipidea/ci_hdrc_npcm.c
+++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
@@ -28,7 +28,7 @@ static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned event)
 		hw_write(ci, OP_USBMODE, 0xffffffff, 0x0);
 		break;
 	default:
-		dev_dbg(dev, "unknown ci_hdrc event (%d)\n",event);
+		dev_dbg(dev, "unknown ci_hdrc event (%d)\n", event);
 		break;
 	}
 
-- 
2.43.0


