Return-Path: <linux-kernel+bounces-258675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3F938B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FB1C2111D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14616190C;
	Mon, 22 Jul 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y+F7Wt7f"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFA8F66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638158; cv=none; b=OfkCom7na3sgPQhfNWQHPwch8LzQwEOhB/bcb1mFHHZd+XMJyNA9a7MUlNlqvXkOIkZ6INrtjtWmde9+dg0mliKnQBem+JLAdpw3pyHbEUqCpp5XP4kSF2kMsTyC36lKd+YiGgDMm6ZfCmX1SD54e1V+yU2Zo2QULWqhrUrn960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638158; c=relaxed/simple;
	bh=eKAoRhRBHdoGTQMFIzXbD4i+756bnaT0Wb8pX4ENf/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DW8kUkWmt7PkwVYjXutzG9S0Cx+25KuvwZj5yYPYbJPtRIGL4JxuZLwlYsnUj1pqGhR3ypKxq1SuqAzoy8u0PtR4ShPd9Sg4qeQuQbHBmk3349hgMQwCwNRilY5WTwprfSaCBFGL1iAsWXZt3u76+zoer/ip7kjJc1YHOPWiNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y+F7Wt7f; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9xWlT
	Jv12XCC0n8wbvF4dnppY+xU0yYtgqnHm9eH5Ls=; b=Y+F7Wt7fEDZK793cd7X4+
	hhrJ2wKTDoHkyw42PmAToO1/gVHN7x9VICvMWJEhFIoHlSqym3BW8JaLVY9joKfN
	cGjFzH742iUV802CDNL7efIrHbnveOniUYinav5o3dyh98AZwBAUWty4k/wSsa6E
	FhpLIqcdFNakSX0jJ+LI7k=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3fx_YHJ5mPX+sDw--.22519S2;
	Mon, 22 Jul 2024 16:48:25 +0800 (CST)
From: wangdicheng <wangdich9700@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v3] ALSA: usb-audio: Add a quirk for Sonix HD USB Camera
Date: Mon, 22 Jul 2024 16:48:22 +0800
Message-Id: <20240722084822.31620-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fx_YHJ5mPX+sDw--.22519S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrykJr1kAw4kXw4fXFyfXrb_yoW8Wr1kpr
	s7C3s5KwnYgr1jqr18tF4UX3W8Ww4Ik3y5Ja4aqwnxAr1Yqa1rJF97A3yfK3yUtrs8Gaya
	qwn0v3s8Ka93GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYKZXUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbioxskT2VOEie29QAAsO

From: wangdicheng <wangdicheng@kylinos.cn>

Sonix HD USB Camera does not support reading the sample rate which leads
to many lines of "cannot get freq at ep 0x84".
This patch adds the USB ID to quirks.c and avoids those error messages.

(snip)
[1.789698] usb 3-3: new high-speed USB device number 2 using xhci_hcd
[1.984121] usb 3-3: New USB device found, idVendor=0c45, idProduct=6340, bcdDevice= 0.00
[1.984124] usb 3-3: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[1.984127] usb 3-3: Product: USB 2.0 Camera
[1.984128] usb 3-3: Manufacturer: Sonix Technology Co., Ltd.
[5.440957] usb 3-3: 3:1: cannot get freq at ep 0x84
[12.130679] usb 3-3: 3:1: cannot get freq at ep 0x84
[12.175065] usb 3-3: 3:1: cannot get freq at ep 0x84

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
v2 -> v3: Update the insertion order of ID 0c45
v1 -> v2: Arrange the ID in order
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 58156fbca02c..b42654033c33 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2125,6 +2125,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
-- 
2.25.1


