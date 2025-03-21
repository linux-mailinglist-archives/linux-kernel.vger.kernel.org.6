Return-Path: <linux-kernel+bounces-571796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3EA6C25B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D41483727
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96987222582;
	Fri, 21 Mar 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="VFhFFPxN"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5222E3E2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581644; cv=none; b=glF9/heNEGam3pW8G2nvwQuXKIQ3Kfj3YYa6Bd7eUX191QT1d9uphdIcfMPg2wV+msuD3RRbTYzRP5tQ/xHp9c0BxfOpzefFjMrU5/RkhPky8wYeP3kZOzQCdES8OXUolUgxgye1IPtA+x+Zwfg4JHMdgcXW9kHgEb2WNuneHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581644; c=relaxed/simple;
	bh=NnQwNZhrJn0kJOUxGptj8Ywrr5SlWHhb++N9tf5qPV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIglgOyWJDdUI6qNDtyl0jQ0YL6Lj80fmihZLpjbHLffIX6Oi0bznKVLIl/v6uU9WFTXlRim4gTXCUSl/8asAbNO0noLGzvoD7gpiNPSZoVm3aFD2lbWJPid3NgxhDsAjkmND79RqCd96P/FwwYGx5MAHeu0Afbz/HNTSpF8X/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=VFhFFPxN; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id D673F1C1577
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:27:19 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1742581635; x=
	1743445636; bh=NnQwNZhrJn0kJOUxGptj8Ywrr5SlWHhb++N9tf5qPV0=; b=V
	FhFFPxN0iOOYIXzPPmogOULoKLMWG3s+KIRocSY73nJRaPQ+92UXVt7QR4yQOijL
	LNYMgXZSGTECc8lHtV/0mBhSGv1tkGgMSCumxaCKfOWTSGnK+Euimw3UhjmlJd+M
	4JH+75YrJo0dzKIF/K6mrW1SfKrkuekMJKuSBq765g=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ks7UUQIakEBT for <linux-kernel@vger.kernel.org>;
	Fri, 21 Mar 2025 21:27:15 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id E0C2B1C16F4;
	Fri, 21 Mar 2025 21:27:09 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1] ALSA: control: Avoid WARN() for symlink errors
Date: Fri, 21 Mar 2025 18:27:00 +0000
Message-ID: <20250321182701.1729403-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

commit b2e538a9827dd04ab5273bf4be8eb2edb84357b0 upstream.

Using WARN() for showing the error of symlink creations don't give
more information than telling that something goes wrong, since the
usual code path is a lregister callback from each control element
creation.  More badly, the use of WARN() rather confuses fuzzer as if
it were serious issues.

This patch downgrades the warning messages to use the normal dev_err()
instead of WARN().  For making it clearer, add the function name to
the prefix, too.

Fixes: a135dfb5de15 ("ALSA: led control - add sysfs kcontrol LED marking layer")
Reported-by: syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/675664c7.050a0220.a30f1.018c.GAE@google.com
Link: https://patch.msgid.link/20241209095614.4273-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Alexey Nepomnyashih: changed &card->ctl_dev->kobj
 to &card->ctl_dev.kobj. ]
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 sound/core/control_led.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 3cadd40100f3..6d81a6a59f29 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -688,10 +688,16 @@ static void snd_ctl_led_sysfs_add(struct snd_card *card)
 			goto cerr;
 		led->cards[card->number] = led_card;
 		snprintf(link_name, sizeof(link_name), "led-%s", led->name);
-		WARN(sysfs_create_link(&card->ctl_dev.kobj, &led_card->dev.kobj, link_name),
-			"can't create symlink to controlC%i device\n", card->number);
-		WARN(sysfs_create_link(&led_card->dev.kobj, &card->card_dev.kobj, "card"),
-			"can't create symlink to card%i\n", card->number);
+		if (sysfs_create_link(&card->ctl_dev.kobj, &led_card->dev.kobj,
+				      link_name))
+			dev_err(card->dev,
+				"%s: can't create symlink to controlC%i device\n",
+				 __func__, card->number);
+		if (sysfs_create_link(&led_card->dev.kobj, &card->card_dev.kobj,
+				      "card"))
+			dev_err(card->dev,
+				"%s: can't create symlink to card%i\n",
+				__func__, card->number);
 
 		continue;
 cerr:
-- 
2.43.0


