Return-Path: <linux-kernel+bounces-393635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426E9BA375
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309CB1F22A10
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1D433D9;
	Sun,  3 Nov 2024 01:29:13 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F684A945
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730597353; cv=none; b=uWE2lQpIw498VsCFa8u9Pb6TXQQEmfP7MWM6fbRkB7ek+OcpFWLAf9djhzDi6aVrnQuBGQEIb21Mz6DfffFX/6owLJxIpLWt3cGWeWme1q/RgS/m8JDsJHIjGMaOQzTu/TzMmBXAhsQTxcw4VKTQ/Q3QkR0cEzl4912Nfi/YIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730597353; c=relaxed/simple;
	bh=J+6s9VNEuEhgdBvkDdZt8JDODq1cSYiKg8A1kqkM5Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uS9KALGCOX3fCSQwWoraXa55NjWthreNDUY9bPg/rQLWTjKrqAyqrxSaeudVJc1qBXHsWMbK50S7DJpJDJ8hW6JKygfxevznwQ1X3J2IA3t8FxXkZsKdOjvBI7blwy1MtminRNZ6nntVrNrc7J6f2qdyo3xSLB3XLEYorWYpXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.217])
	by sina.com (10.185.250.22) with ESMTP
	id 6726D1D4000069DD; Sun, 3 Nov 2024 09:28:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 123997602704
X-SMAIL-UIID: C70D961D36D74CDD987A4438F95FBB83-20241103-092858-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Sun,  3 Nov 2024 09:28:45 +0800
Message-Id: <20241103012845.3066-1-hdanton@sina.com>
In-Reply-To: <6726bf35.050a0220.35b515.018b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 02 Nov 2024 17:09:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1274ca30580000

#syz test

--- x/sound/core/init.c
+++ y/sound/core/init.c
@@ -577,9 +577,13 @@ void snd_card_disconnect_sync(struct snd
 }
 EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
 
+static DEFINE_SPINLOCK(release_sl);
+
 static int snd_card_do_free(struct snd_card *card)
 {
+	spin_lock(&release_sl);
 	card->releasing = true;
+	spin_unlock(&release_sl);
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
@@ -591,8 +595,10 @@ static int snd_card_do_free(struct snd_c
 		dev_warn(card->dev, "unable to free card info\n");
 		/* Not fatal error */
 	}
+	spin_lock(&release_sl);
 	if (card->release_completion)
 		complete(card->release_completion);
+	spin_unlock(&release_sl);
 	if (!card->managed)
 		kfree(card);
 	return 0;
@@ -637,16 +643,20 @@ void snd_card_free(struct snd_card *card
 {
 	DECLARE_COMPLETION_ONSTACK(released);
 
+	spin_lock(&release_sl);
 	/* The call of snd_card_free() is allowed from various code paths;
 	 * a manual call from the driver and the call via devres_free, and
 	 * we need to avoid double-free. Moreover, the release via devres
 	 * may call snd_card_free() twice due to its nature, we need to have
 	 * the check here at the beginning.
 	 */
-	if (card->releasing)
+	if (card->releasing) {
+		spin_unlock(&release_sl);
 		return;
+	}
 
 	card->release_completion = &released;
+	spin_unlock(&release_sl);
 	snd_card_free_when_closed(card);
 
 	/* wait, until all devices are ready for the free operation */
--

