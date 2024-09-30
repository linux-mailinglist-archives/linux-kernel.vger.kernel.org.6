Return-Path: <linux-kernel+bounces-344288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA598A7D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D98B26DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACCF192B73;
	Mon, 30 Sep 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad7rn+Bg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579A191F81;
	Mon, 30 Sep 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707990; cv=none; b=Q2llzy2ruGrpCIQLehB2IqBF8NMvfbLHGrpNRecNQwnwgrMWSg1MpPrkIGZpSLmpOmfZbmQXhbWZIPEF5U5EJXyP4ueAco2JjZ4yl7CJ8UASGq0nKoDegxYZMQ3oK8cfTkoH8YMH6n+fhhHbvTxTU6F8A88qPIXqkSW20q8wmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707990; c=relaxed/simple;
	bh=IEZyqI9p1dpM5X1TBW/EbjmZcituc+iGg9sknYVX4co=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOBcdvTs4FllJ+SnkqsuzIwKEuX0g3c2C4b3+FYs7d/7lBzSmsDsxEzBReeegISR61rbceNhJ2t5Tt/ZzOEOmqJobXhEI16o2EYWy/2Kb57lzkRtXWenjuzjQjdnqBJB59MtNeD/RN0k4Kn6NSX6/8MR01BXU3po+YxuQXs8ivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad7rn+Bg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e137183587so696390a91.3;
        Mon, 30 Sep 2024 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707988; x=1728312788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzZUrPo7VwF9JRFW0jXLatknVBb1CHVP9jTUv/xcRtc=;
        b=Ad7rn+BgSZXRRPT4z/0I4Vv+s6eCcUOSEmKAKY9yQuQWJBjcX/EkufKao6P+QiZzeP
         s2/+bDgCnsyKqD34f4G3hTkBW9kYuvnTy+oJH/LV1OY0Nlf3ADwev0Onw+qrfYH3ohp+
         OY1d/5UAo7skQSAbA2d2fA4/Yh+ayaNLA55LWsr2rxSaZXadCWAoKd9J/MjKB3DT+jHZ
         Z6aFemtOo9hzfZIAhBpvQpHcsFn0KiAq4wtIc8C5EiyLwLGclTTlmsAoUxCb0PQdhAOy
         A5Nm9AYr3rspUmzZK54hZo0KJzJUyDGsRf5vLKp6tMANOqEeDJlbZPcyTQpsOoMrDoe4
         FRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707988; x=1728312788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzZUrPo7VwF9JRFW0jXLatknVBb1CHVP9jTUv/xcRtc=;
        b=qsJanICcH3YYK/5NeaprALVTpsJPRf68mReqgwvFFkS2o7zlJy/OViaeuHzhs1uMS+
         1v/0wYkdtt3luqjOArEW6zpMyFZjakIRRGONu/10Nf9ThpPRRnj04+6vwPfCjn1M4AN4
         J7V91tUfWBX4zmKqiyxn0Nh/CclpoqtbrjyDQJ3Gzg1owNL+VsRxkKvJB0euDMXp9Hzl
         k6zoB1oe9AxJzuA/hLu1BVaXINcqH64JyedC+mYH/pVl7FFvYLvqpnO2A2AA6Yz7QnV5
         eCn2brzN0cm2s67rHfd7sPTdjoQAzHg+pcbBEbeJ6U73S1xL8krUh7RTHN9lKCgp8GJv
         q9MA==
X-Forwarded-Encrypted: i=1; AJvYcCWk9r07pk+l29RWLQPg6nHzhQ40uzySbEMGrYbu41y1x0y/RxIOK6TPkF6hMf2r6pEK9lGgRguBLF1tpf8=@vger.kernel.org, AJvYcCXLQAf8CqTEI6+rjZYnqGprA/8Q9PmtjsBl547nhRhEBUilwzCLIxcee02fO0ooPLR33tnOHDhUmrRwoxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0U8bwjg1d4wSNlMy0CxNkYA4+2QTdMcK8WTCBlwAKTBZRXV/E
	twQ8wTLPKJ6aqjqGSgRqLvA3B8dsZHsxBndS0XuvfCJqXuHU/uTl
X-Google-Smtp-Source: AGHT+IE76nvgMp3ss1EgYURcxr6slKLUutk2wg0KfFLhK9sMF9tqejGLNevkpTYdm/YhLLGA3ILB8w==
X-Received: by 2002:a17:90a:9a83:b0:2e0:7e46:5ecb with SMTP id 98e67ed59e1d1-2e0b8e97ee9mr14496868a91.31.1727707987968;
        Mon, 30 Sep 2024 07:53:07 -0700 (PDT)
Received: from embed-PC.. ([2401:4900:1c26:3294:a303:135d:2d56:fd2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6ca63f9sm7966808a91.33.2024.09.30.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:53:07 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
Date: Mon, 30 Sep 2024 20:23:00 +0530
Message-Id: <20240930145300.4604-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
quirk for this model.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219303

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Add the quirk entry in PCI SSID sort order.
- Use lower letters for hex numbers.
[v1]: https://lore.kernel.org/all/20240926155112.8079-1-abhishektamboli9@gmail.com/

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ca66234e561..b8e33e4a0baa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10349,6 +10349,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x88dd, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
--
2.34.1


