Return-Path: <linux-kernel+bounces-192617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E415F8D1FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067C91C22FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75656F9D6;
	Tue, 28 May 2024 15:08:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F6173334
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908888; cv=none; b=nQGKVIjjX/138EEPe7ifuNWJOzya49njSbstlcc2JuSBcos6/Yb/Xm/W2b/9tpdC76890hj04OzPuirYfUNLqyNJ/F/0bJdOye0A77g3xMBpiX5xhx0H9XWflwSemgtRXh9ij/XarPIga1hO03TgSSb0if3NZlw1CdrhsnP/5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908888; c=relaxed/simple;
	bh=I+IpNMECOJXL+vdv5iTJxoyXJAP5asFI6LVgsSUqkd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFJBv6Lxkhs49IusSJCFO9QjcMOI8J8YYzDTPqNko2bmm+CwGXjyIeiHPkhlyKHj0qiTBFg76t6Aoufyr1GoDHte9w7R4qnkaIChlWyOSs3ANEHiq+P9eEKRBrD3wGb3cm9dqVwpkK/zANDbGSDMfrAVb0LiCYLow2fi8NJHpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44SF6o8a089649;
	Wed, 29 May 2024 00:06:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 29 May 2024 00:06:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44SF5urw089523
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 May 2024 00:05:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d775ae2d-a2ac-439e-8e2b-134749f60f30@I-love.SAKURA.ne.jp>
Date: Wed, 29 May 2024 00:05:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] serial: drop debugging WARN_ON_ONCE() from uart_write()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Al Cooper <alcooperx@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineet Gupta <vgupta@kernel.org>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Alexander Shiyan <shc_work@mail.ru>,
	Baruch Siach <baruch@tkos.co.il>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linar.smtp.subspace.kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-13-jirislaby@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240405060826.2521-13-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting lockdep warning upon

  int disc = 7;
  ioctl(open("/dev/ttyS3", O_RDONLY), TIOCSETD, &disc);

sequence. Do like what commit 5f1149d2f4bf ("serial: drop debugging
WARN_ON_ONCE() from uart_put_char()") does.

Reported-by: syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Example is https://syzkaller.appspot.com/text?tag=CrashReport&x=100271ec980000 .
But not using this example, for this link will disappear eventually.

By the way, do we want to also guard uart_port_lock'ed section using
printk_deferred_enter()/printk_deferred_exit(), for trying to use e.g.
WARN_ON() inside such section will result in the same lockdep warning?

 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2c1a0254d3f4..0c4d60976663 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -622,7 +622,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		return -EL3HLT;
 
 	port = uart_port_lock(state, flags);
-	if (WARN_ON_ONCE(!state->port.xmit_buf)) {
+	if (!state->port.xmit_buf) {
 		uart_port_unlock(port, flags);
 		return 0;
 	}
-- 
2.18.4



