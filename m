Return-Path: <linux-kernel+bounces-256919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A8937279
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685FA281B18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FC8F77;
	Fri, 19 Jul 2024 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VApZSabf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3718622
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721356327; cv=none; b=PsvQeQreymuAeKWjHA0lkzFus2zsTt+DCcroc/Pt6LIiMymaVhd9s7wSB6SOmcrA8mUWRcwsu3GMicbwpN+cb6vWv199nsaRSTVDwAOfbEYscCbjZdvBeFLIHICKYV7QDc9eOPMjaJE05Cw/z/uZ2mcKxwE6qrdbeJ5CK4Aabw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721356327; c=relaxed/simple;
	bh=wwGG3+YyY8mIogBdU+KkOQ0+dRIFSZNY44DPqE3xv6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMuv0Db4MHNopc7e3GOgzwK5Z27jaPksj1+wImGKAgtgclT64vydsJplS646KVWto/YGCRLg/XrC1TM4PksUdhp7Kjt+mRSEk2sUShn3ybndmwxhCeJLkO0aLy+E255XxIPUmmCcNunR9sgdQodrBZpYlGPQRjq0cTOgwweijPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VApZSabf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/f5De
	nBV8OntvTIl0L+VxVkHwc/+e99DtksAYzxlBJg=; b=VApZSabf1jxvPCTJskWVV
	5ZB+OV7+slVZzwAKOwU//LOmuUeV5zKnJxfc9n84nhZF/skBMYKjnZDCCeJTr/b1
	V5D+5qDBrwWEi2BzI7AdDztbZnin5JdVHld3Py/D/w1CZYHxSJSldabrpLvhQ6QV
	MYjjvtCEJiKyBfnvKfO5Jg=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wCXH5qmz5lmZ9ulDQ--.12874S2;
	Fri, 19 Jul 2024 10:29:58 +0800 (CST)
From: wangdicheng <wangdich9700@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: usb-audio: Add a quirk for Sonix HD USB Camera
Date: Fri, 19 Jul 2024 10:29:56 +0800
Message-Id: <20240719022956.9861-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXH5qmz5lmZ9ulDQ--.12874S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrykJr1kAw4kXw4fXFyfXrb_yoW8XF45pr
	4xua4ktrn8Wr1UXw18ta1UX3WkXws7A3y5JFyagwsxJr15Kay5JF92y3ySgw42yrW5Caya
	qas0v395KFZ5Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYKZXUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbiRwchT2V4KXHRAQABs6

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
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 09712e61c606..c1fd690cbac0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2033,6 +2033,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0499, 0x3108, /* Yamaha YIT-W12TX */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04d8, 0xfeea, /* Benchmark DAC1 Pre */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
-- 
2.25.1


