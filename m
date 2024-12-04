Return-Path: <linux-kernel+bounces-431489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022039E3E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF63F28132B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160720C03E;
	Wed,  4 Dec 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="MC2l8HoL"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01920205E1C;
	Wed,  4 Dec 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325634; cv=pass; b=cyOKIN4265ciE9PWRxGNGZaHnhmAk7Sn58lzXns35yyzj96LFpeqelKDZNs8KfFpvS4uM39DqP8EuXqjFHGE9Wp6L09fuU3CjxHCF79OQZXmKYM/DS5U0nHWUtiJL828LITZTI9lHpv7gLHnVIVxMLWtk62OU/bKCU8D4sKX07M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325634; c=relaxed/simple;
	bh=pNsY3H88UMxdc1Mkr9gppa6XdoCNDHF9kIE2qRziSws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUg16NWjPso67AbdIcJ5FeTr53y6jhCN3K1/wO7a0qyTxHyyUit/KstF/UNbFFxpJEVFMvI1Up/aj0TSBKYNc1pGKKXR6tCdcwUGrnCRZHRauvi8UmTSNLyB577VF43srbzqWBq4g0p7gLPQd4IdTda/4w4jqLphXD37seXKyOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=MC2l8HoL; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733325613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=boAXN/K2qknXZxbaWLhya8COZAzvQzsXTGkrUwHLp0+afADd541t1E2p7HI+ctkMaWivkv4eUFkOJJOBfZA4DxIGzPsiADMdLRSFKlcAGmUhD9CYfn8JHzyJ8+KETSxq1Y0jdgsToylEFmJyUG4jGIiTsa9oKeNBzvS375Xi3yc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733325613; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QP8dut9Mq3hDvfHHmrDZ5/80uuIlOS9sVHmLsu7uV3E=; 
	b=ZnmIqIOYe4dRaXEqseOK1RYnSpESLhKDSL/WRR30F82r9dPJYX/4QLNxKziO0Y7fIUPcD6lHshgd9p0eZ0r7QTVvJsSrmU9JI96CH27rqQ+zwiZ04vB/z+v+73+mivfYKuXXJLRAcAaxsSK5nzRCnDWnjzoF11KhMnJdGJWEtAY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733325613;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QP8dut9Mq3hDvfHHmrDZ5/80uuIlOS9sVHmLsu7uV3E=;
	b=MC2l8HoL5J9SWKsEXFcnJsKyZ9WPJPhhf//RLvofSWmOcv65YQh3Z0f66Nk3E+/C
	aPk1KY0I7pxZQXTpQ6BbQwnTUeVm2YRCAJEPZtDbVsBzmMGhhjB6Rwo8HTU39ihcnfC
	uZNAIHBS3uDw2xdC1rtb7mVnZz8wSgglPIgGLP9w=
Received: by mx.zohomail.com with SMTPS id 1733325610566947.0058495254816;
	Wed, 4 Dec 2024 07:20:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 2/2] sound: usb: format: don't warn that raw DSD is unsupported
Date: Wed,  4 Dec 2024 17:19:54 +0200
Message-ID: <20241204151954.658897-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204151954.658897-1-adrian.ratiu@collabora.com>
References: <20241204151954.658897-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

UAC 2 & 3 DAC's set bit 31 of the format to signal support for a
RAW_DATA type, typically used for DSD playback.

This is correctly tested by (format & UAC*_FORMAT_TYPE_I_RAW_DATA),
fp->dsd_raw = true; and call snd_usb_interface_dsd_format_quirks(),
however a confusing and unnecessary message gets printed because
the bit is not properly tested in the last "unsupported" if test.

For example:

usb 7-1: new high-speed USB device number 5 using xhci_hcd
usb 7-1: New USB device found, idVendor=262a, idProduct=9302, bcdDevice=0.01
usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
usb 7-1: Product: TC44C
usb 7-1: Manufacturer: TC44C
usb 7-1: SerialNumber: 5000000001
hid-generic 0003:262A:9302.001E: No inputs registered, leaving
hid-generic 0003:262A:9302.001E: hidraw6: USB HID v1.00 Device [DDHIFI TC44C] on usb-0000:08:00.3-1/input0
usb 7-1: 2:4 : unsupported format bits 0x100000000

This last "unsupported format" is actually wrong: we know the
format is a RAW_DATA which we assume is DSD, so there is no need
to print the confusing message.

Thus we update the condition to take into account bit 31 for DSD
(notice the "format <<= 1;" line above).

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 sound/usb/format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 0cbf1d4fbe6e..fe2e0580e296 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -142,7 +142,7 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		pcm_formats |= SNDRV_PCM_FMTBIT_A_LAW;
 	if (format & BIT(UAC_FORMAT_TYPE_I_MULAW))
 		pcm_formats |= SNDRV_PCM_FMTBIT_MU_LAW;
-	if (format & ~0x3f) {
+	if (format & ~0x10000003F) {
 		usb_audio_info(chip,
 			 "%u:%d : unsupported format bits %#llx\n",
 			 fp->iface, fp->altsetting, format);
-- 
2.45.2


