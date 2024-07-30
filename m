Return-Path: <linux-kernel+bounces-268329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2894233D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9970F284C61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C1191F72;
	Tue, 30 Jul 2024 23:07:17 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0318A6CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380837; cv=none; b=geb83/kAH9fu8dzqeD/js54M0xGN6eJhzWFjckHiAZXJOu2NI9CjEp53AI6RR9nawHByJ+/YrFUYCHXj9Re02OH8npNSJf9dIn3aqQv0mkzczLwgdccSt+296DCmgA4yhYKmMraHJeNfE5blZ+zNH2Kb2vqPcUn67pI4kRbnvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380837; c=relaxed/simple;
	bh=1noXkunZN3gQi2vG5qpPw8sb2RAUtWCuXWp123ND5H0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=shZ66Lm9/JizN9mVmsdxl7+g9R8BE6G79PL7uqslvryWanlF3u8akOYkyburaK13EYD5OKnp8u73nlYwo16BlLSmrJeLaWj4D62RHiztqchTYtOokSGJZFRBvAIiL/jQCLakPv7TZfmZM1qswZL4+uYKXJgqooOZPa9U1zUBK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b0bee2173so12869495ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380835; x=1722985635;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9v9paM8Lj8efL3GCk8sm5nEZe6QDiGfNBzMFtr5P4s=;
        b=FNsBAlDbT+VAmEAY8buTHaZ7lew0+ZimshmPw/XdbJKWpcYgZtQc+o2lZSxZDGHU6y
         2wPDVe7Hz72RZDAr9w6kACfdrA1trbtk/y5OWpEjnHOIY2DvPqqVp7RYv6xwbY+s1rQe
         NRplbd/7YOEAlFKAqL8DIztdgCKRqXCBWIkgS9Pv+032PYklpFVlp2yyc5wMwj6zu1wQ
         7b7zyujqSEgHL9uiwPKr/lEAANbPKCTqEo5PGlQOT+cJyge3Tf2COyMUz4+Gs9wDaxT+
         uEigpTIoIqI8jx5zIrVgaQN1Zrb48Rv2sCS+na+4mbFYBZ13FRykqSGT7QA72bLnLKIM
         dhIA==
X-Gm-Message-State: AOJu0YxOjeH2k3ezS21ZqhNqp53N5XIBJF+RYgVs6yRCDvNTMeCkrARy
	1cIBsNz2SDOMAdHdJy+zc7P8eaGPQgAFiQ0rrF+KlKaNy3auCnbaAp8DQp7W85i7bmMuKJSCwua
	GEacoEVYlseWksrtGw116ceTJjFLogJWzbx/E0XX7wT7Bsxh047CdpXg=
X-Google-Smtp-Source: AGHT+IFER72ehWh8ljK4AhUZn/FWKkdt47LhFK+aPcn4KELKdfwymPh2yzX6RQ33fS7rFcZnI5spKAdFSYw7VogoFprIj+xXCCNO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c6:b0:4c0:ac4e:3295 with SMTP id
 8926c6da1cb9f-4c64b545c48mr1075234173.6.1722380834764; Tue, 30 Jul 2024
 16:07:14 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:07:14 -0700
In-Reply-To: <000000000000c9ff1f061e7cfc05@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d309be061e7f099c@google.com>
Subject: Re: [syzbot] [PATCH] usb: fix slab-out-of-bounds Read in cougar_report_fixup
From: syzbot <syzbot+24c0361074799d02c452@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] usb: fix slab-out-of-bounds Read in cougar_report_fixup
Author: cam.alvarez.i@gmail.com

#syz test
report_fixup for the Cougar 500k Gaming Keyboard was not verifying
that the report descriptor size was correct before accessing it

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 drivers/hid/hid-cougar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index cb8bd8aae15b..0fa785f52707 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -106,7 +106,7 @@ static void cougar_fix_g6_mapping(void)
 static __u8 *cougar_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				 unsigned int *rsize)
 {
-	if (rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
+	if (*rsize >= 117 && rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
 	    (rdesc[115] | rdesc[116] << 8) >= HID_MAX_USAGES) {
 		hid_info(hdev,
 			"usage count exceeds max: fixing up report descriptor\n");
-- 
2.34.1


