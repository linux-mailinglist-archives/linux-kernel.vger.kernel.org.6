Return-Path: <linux-kernel+bounces-258390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A6938761
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432BE280F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E9B8BEA;
	Mon, 22 Jul 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qQOU12gz"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167043232
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721612798; cv=none; b=p9mUh0GfU8DKpLako3AcQs5+521Z2QCvwr+iXELmxawKq6v1kR2IXrf499SbxrGyxLqV6yBeMjEOXZ9+SgelsggNzwbawdpl0ph8Dj9qCBhG6aB7Y+t4qaj8+/igJaEE0VKRzCPT3m7Q8JW3fmtGdtThHivvVjXvz02A2eGuexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721612798; c=relaxed/simple;
	bh=Irjznp9s1xHSOnjL1LRDWbTo0pqFCAdZy/M6HPja0s0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acUtZ0TR1FCUBODJ33boyISD8dsyEpw3R8b8WVMtNwRrlRZcpzcBdUjJDi8gtf+efua0tRWLmyRr3y9Nx5cFPAcNqp7EZ9OtB0anJsR7sjWJH9xHoHlGsgT7UPZQnsHG6OD51PXZzyusPgLDHRJcXRDSV9QTlxlY6m7xLxbWM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qQOU12gz; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xWXa+
	yb0Rmb14pkRECozZYNIRdp7liyu1MZuBlUcxow=; b=qQOU12gz++VWEmMFpSqlh
	b71LaJCBqda5uJt+avURs9HYpvYr6GUvsRsFoC4MxqHUrKq0rG1ws+jzX2UPaq9S
	khde5mCbE4n+krvf3qhw0dr+24QLYnGmsvyAazNS385iZB3quN1P17mpLiv/pKYi
	492Gr2UVcd02FRwaExCluo=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3P5Mvtp1md4p1EA--.57896S2;
	Mon, 22 Jul 2024 09:30:25 +0800 (CST)
From: wangdicheng <wangdich9700@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2] ALSA: usb-audio: Add a quirk for Sonix HD USB Camera
Date: Mon, 22 Jul 2024 09:30:21 +0800
Message-Id: <20240722013021.10727-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P5Mvtp1md4p1EA--.57896S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrykJr1kAw4kXw4fXFyfXrb_yoW8Xr18pr
	4xC395trn8Wr1UXr1UtFWUX3WfWw4kCay5Jry3Wwsxtr13Ka1rJF97A3yI9w42krZ8Caya
	q3Z0v395KFZakaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYMKZUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbiNREkT2V4Iu6kVwAAst

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
v1 -> v2: Arrange the ID in order
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 58156fbca02c..54b2d2f314ac 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2225,6 +2225,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.25.1


