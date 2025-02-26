Return-Path: <linux-kernel+bounces-534918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6905A46CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8033B3AEB92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C802248B4;
	Wed, 26 Feb 2025 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="Eh7NE8Fl"
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0C275614;
	Wed, 26 Feb 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602850; cv=none; b=aRjIj4loMIOublDEnfc40mZxb01toqeLNibMg2RNOryxevkTBz1keueMk1ksEG9wENbzItAgTyaSGHTYIn+HTWo8KjkN4l3OdJrJqV8+8CBv49hCW+Ss2wy1eMlhYFODs+Rih2dBC5pS3nAiypTTngFQ4vneSgloAHBqj0rROYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602850; c=relaxed/simple;
	bh=K9bqffrO2e2aLZ4y4VAa6+K26EGBBsGBkT9p9s2QLaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QMhP5Ihoh17zL4/7PuDf+8In66j5N0dTc/DstaPBgRHGxWx15YbB7gewCV/GokxMgI+2h96PodC1URtOs8X/XuHzhuosWhtEi5Aj0INOcCKGeVSPwFxvZd4FlDgmrKIwIx9ExpoYa4jqb2QIWwkAbaooUDv0QkBVgfKcb19OP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b=Eh7NE8Fl; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=valentin-vidic.from.hr; s=2024; t=1740602842;
	bh=K9bqffrO2e2aLZ4y4VAa6+K26EGBBsGBkT9p9s2QLaw=;
	h=From:To:Cc:Subject:Date:From;
	b=Eh7NE8FlcajrTcJWPdjXtb9PuAaBRyJZ9pX+Z0y6F1kKwNxv7/0D4n5A2ouqAFTXt
	 DncHI7OZCtlmFRwdUxRD+urQrv+qrDy9AnWBN+2S4Ws6zsj80q2yiua6r1P9c1G42n
	 9LIuGeQqeMWw0h7KciJhATHLbtZqdh0eAEakkgDyougNDzWRfVf9y1SISwgHQjmGeh
	 Ldwon1qQK41g5EQY9+juOi5Wwj9g7MXQKXzBYaA6vQtP0TjkbGYQNhV3nMt4Hy7co2
	 T1iV1oFVSBPPiwB9dLO/CTmsaUGERaVZ8MQ0Bu3aUQI65lsXx1GgBP2QuPx4efvNs6
	 JRN839VU1nTM4vp4XsJLays77tDi83xAd+RydySA5wvOeVwR7mk6inCHrst4OmAgg6
	 w+6hgfXO7nGDLJeTJ+Qce3f+REmobDX1Lgcvf+Z4AaWoBbRC3EJhtNf8QPhqFziJcN
	 xCPZFelrwJh46m/GuTr56K0sbuG46sIP4JGZnSnfd315wdC2sSEVXlcXwfm7W2Czsk
	 yBkBt+Ugxu4qGrjQSHkyqkjSGtxuXr69aHnfeyocnUMGhklv4WcAi+uBTowO7yabnN
	 OGN4v3azMmEQqWUUcszfSsexBZyqTnr8Q6EFuXzEcA1bYiywAU9hCO6+CF5uOPYM3s
	 OgeB1OiPIhFiiY5I8ome3W/4=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id B627230A01; Wed, 26 Feb 2025 21:47:22 +0100 (CET)
From: Valentin Vidic <vvidic@valentin-vidic.from.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] tty: pty: remove redundant local variable
Date: Wed, 26 Feb 2025 21:47:07 +0100
Message-Id: <20250226204707.1941274-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of to is only used once, so no need to store it in a
variable.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/tty/pty.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index df08f13052ff..c6eb711500b6 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -110,12 +110,10 @@ static void pty_unthrottle(struct tty_struct *tty)
 
 static ssize_t pty_write(struct tty_struct *tty, const u8 *buf, size_t c)
 {
-	struct tty_struct *to = tty->link;
-
 	if (tty->flow.stopped || !c)
 		return 0;
 
-	return tty_insert_flip_string_and_push_buffer(to->port, buf, c);
+	return tty_insert_flip_string_and_push_buffer(tty->link->port, buf, c);
 }
 
 /**
-- 
2.39.5


