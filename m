Return-Path: <linux-kernel+bounces-529346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30546A42328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CC81894361
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359123371F;
	Mon, 24 Feb 2025 14:30:30 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17244C94
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407429; cv=none; b=MJZuTw3s32HPzpHca05E0nBCMSG/cv0KXvmksS92kQfYVa99P/0SL9bcOKITqr6e15S/RTob1Diru6hNlIXZZwfHNy3tCaTCgcqMpoOesp3Mp3hKmTtMOpSAfv7VNRKYu0Qr8pGo7XqbS94Qovq2ao07/CNcVyQTB/3S8D8i5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407429; c=relaxed/simple;
	bh=M3GmmYhya6xHQLZD4CkdMSghc5D0OhVwWeUh2SzCfns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3yk+4xByyqS/b9yV3Z2nw7mdaTJdQXlkvtyHAbAYhw2xjtwwwvgdoK2xuucttY+gRYo8gHUZKOnuzW+AV9AH6VKvZAQfM/J7pppyTcANfqRkEW+9FuLDCMeTihYubbdi3C+NkeFtXwv2BRFwTMrpCKWc7koYPsgRBbKKPrfIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 24 Feb
 2025 17:30:14 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 Feb
 2025 17:30:14 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [media?] WARNING in call_s_stream
Date: Mon, 24 Feb 2025 17:30:11 +0300
Message-ID: <20250224143012.1215895-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008cabee0614a97e81@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Test a simple fix.

#syz test
---
 drivers/media/test-drivers/vimc/vimc-streamer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
index 807551a5143b..64dd7e0ea5ad 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -59,6 +59,12 @@ static void vimc_streamer_pipeline_terminate(struct vimc_stream *stream)
 			continue;
 
 		sd = media_entity_to_v4l2_subdev(ved->ent);
+		/*
+		 * Do not call .s_stream() to stop an already
+		 * stopped/unstarted subdev.
+		 */
+		if (!sd->s_stream_enabled)
+			continue;
 		v4l2_subdev_call(sd, video, s_stream, 0);
 	}
 }

