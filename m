Return-Path: <linux-kernel+bounces-528987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC46A41E99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D503C165A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73754221F3D;
	Mon, 24 Feb 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BIutqpFC"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE421931A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398995; cv=none; b=HxnS4ZX6wNw4u2g1y1ioSioYiUyWay2Q8TcIRiUjnwL6jCCfdLnQbfDdGUMvrugb/DiUnZWPpr1H34bdDmUCc/yKnq56FJmnoLTp9HCjFpJr8//+sVFziIXHnv0aYs7AEHmwp3kL86bA3gLVX9bBz7h84kU70ITvpHs8WxqygDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398995; c=relaxed/simple;
	bh=z8pcrbRHBMw1omBrRmpP+2/7ZYzZBQTHD1BEN2JetF0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kB0fmlrTku+9qOFrV/giGENTRRAcdgnmrifgzPhIhKq/Lh+y0ZEfMwPO0d4/rty0MFTLR6SFWNmfMvxprdeRgLgTlA9wg9JWJTvpEq6N4uYjhWwWqQJ9jecWbgAzqjx5Bp8H7+r48iEw1R2ySdchpUY8gs5fwOqhYu+a66O6ntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BIutqpFC; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740398682; bh=Roc7aiKjE8z1drJG9lhM6cRd6Kjhel870ZZzDVlZjrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIutqpFCkN5LMeNRFQOd43f1IhERm3Io7SH7sVAutQj7ATJYBnQSdOcC9SBJwg1v6
	 w8LytOGVSjorxF4jtDNfgBGyqRC3DBGdSRQNKSyQgKW+VUKo9ZMQV0hHQib2COoRkG
	 eRXT6g4e6XlkRzP/JksaZA8wrNuw+8QiMY7dmYT4=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 12881ACF; Mon, 24 Feb 2025 20:04:40 +0800
X-QQ-mid: xmsmtpt1740398680t5e7405m9
Message-ID: <tencent_B22DF56DC89700E9F2EF4ECDEC797E6F9C0A@qq.com>
X-QQ-XMAILINFO: MZChPk4K8ikNNHAuC1l9Xm091X3KtlOK1JHKZCRKa9haL4DIXzcJCSlRfcheMP
	 JLRfQYFfm4eFBdqnC+v91aMgY0jrxqIINOFmyEhk4ib21VV/IgmP73bxqUiO+45qCE67zdIqzN8U
	 lGvwJMIIvJKLHTHODxvcskSLBl4hBw4a71Y72OMqthOYqvq4r8OhB34GeddjSBZNiMxHZTD6Yf2R
	 jZFqNfvwvC12aw84pQ5BIxc7fmNEHTgJ0i+VoerAF0eHMLtr4OVa5Nwgv/FahfM7M4ZIdplwIZKv
	 r6Dy7OhSM4pCOPRD90MSU+V+MDPLRC3cEpVFnl7GzFBz0Gles86tzVgHOYYGNPDzGl1zaes3SpH8
	 RL1qw/9GwhVBGxeO4dnkSmFZf3ljwpEPkVbxlF7SET3hYwTk3aMCAAH+Mo/adZWQMkECqi1bP/Oq
	 /TXnhj/lNAxYwglEoKbJnrK2D1VT0A3Yj/Fs824RJibTMXZcT1NnaxqyZaepuB0N51jgCirXadqU
	 lTx4/JANDpd43blKW/3Lj0Jz6njlg7L9yYo9k+Ggu21Pcc96kBBDV3ORo9yraR5+xyLEBsPhFeRp
	 Q38f+v66vZM1WJNwkJNIR4Ps5nUV8xgoV5KdQmaxgUQCTi5Lb2sYlw8kScb1OfOOfKEUydnNofv+
	 cPXEInsUbDgzuraSnLe3whNWEvGFCk+KeBONmwgh39iRtujHU4FEaiAEa58WAKj2AKN9WTc5HfhL
	 gIXCCcBwrPQTC9yL61HNsufsKNX6H85HhksFo04tLgzKxRET5HEZr5MLdG68uGy3nQIZHmY5+Vt3
	 m2ziuegKoU5AQJ4KguNGjicknpQFrSb+1/g4edJqyuFLG1jHBwKk4iShailspR+SzOEFtWnRjJNM
	 FnbPM5UE34Cp7k9FrGW5VDsVgeAu7pP1zTnFdKU4+/
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Mon, 24 Feb 2025 20:04:41 +0800
X-OQ-MSGID: <20250224120440.621557-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
References: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index c9e65e9088b3..12ad00be57bc 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1139,6 +1139,9 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 	unsigned long flags;
 
+	if (!steam->client_hdev)
+		return;
+
 	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
@@ -1153,11 +1156,12 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 
 	unsigned long flags;
-	bool connected;
+
+	if (!steam->client_hdev)
+		return;
 
 	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened--;
-	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	schedule_work(&steam->unregister_work);


