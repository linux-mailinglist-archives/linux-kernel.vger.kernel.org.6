Return-Path: <linux-kernel+bounces-261933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E5693BDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80ED1C21A07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AE1741F2;
	Thu, 25 Jul 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="knvRw69S"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A0172BD8;
	Thu, 25 Jul 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896149; cv=none; b=rHlnTFzM3NwnL2nOkd3yxH3nT9483NIhHCjtdYkF+mEWqTpxYLMSNWEdmHF9uYCJ7iVyAy/J34DtAMT4/V/CGnUqcKV8w1+bP/7782M7MZ4fG+U+Hy9jV7LQU3crvMs1a6sWgnEo1mTig3y0u/IhLRP26BOQLp79ZTJ1hA0AYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896149; c=relaxed/simple;
	bh=tN6cAHdUmUxkAdTjBaHHA6rIz2i23coQvVGIBgNEO3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cllqHAx0cZxMD9fgfnbohGUmeXpsVLLdinso2a6eQbB0CK/pXzLx1TqZwUYGXxCm1pytVWCcoM5+junYZ72JvoJgz2jTMsPZv5OIcjsI83f9YDwGkNC4d8liIZpvqq6y894yd6Ny9IB2KsuZ/zkk6yWOYoKaVwIlAlPJnplAWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=knvRw69S; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wKwqb
	elMp4OiKqBXRvZ4oGV+SEc29Z6xEPPoTzINaBI=; b=knvRw69SXUVrA8YBOWApt
	Lw7HB28aZXOOdoI8Bt/oSfrttucygnZBMUShgICFWGh4BTr//aRK4r1kq0Sy0wE1
	YKkWbJEHOQN9EakRmay3Tw+KRSy+QnEptxqxlzIDd+gv4OgcjkNhu3QU3vlWr4av
	Ekgr5MsFBdwSmDpaJa+3Ig=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3f0YmDKJmW11tAQ--.48631S2;
	Thu, 25 Jul 2024 16:26:15 +0800 (CST)
From: soxiebing <soxiebing@163.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH] ALSA: hda: conexant: Fix headset auto detect fail in the polling mode
Date: Thu, 25 Jul 2024 16:26:10 +0800
Message-Id: <20240725082610.45504-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f0YmDKJmW11tAQ--.48631S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1xJw47uF13JFy3Cry3urg_yoWrCrWDpF
	1rCF1fXrZ3tF1vvayrJrZ7u3WUCFyfZFZrG347tryxtw1a9rykXa47WrySvFWfJFyDKF12
	vr4q9a4Utr4UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeoGQUUUUU=
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/1tbiRAwnw2VOD6Po+wAAs4

From: songxiebing <songxiebing@kylinos.cn>

'Fixes: 7aeb25908648 ("Fix headset auto detect fail in cx8070 and SN6140")'

This patch only handles the unsol_event reporting during interrupts
and does not include the polling mode used to set jackroll_ms, so
it's changed to use snd_hda_jack_detect-enable_callback function.

Co-developed-by: bo liu <bo.liu@senarytech.com>
Signed-off-by: songxiebing <songxiebing@kylinos.cn>
---
 sound/pci/hda/patch_conexant.c | 54 ++++++----------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 17389a3801bd..e994ebad53fa 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -21,12 +21,6 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
-enum {
-	CX_HEADSET_NOPRESENT = 0,
-	CX_HEADSET_PARTPRESENT,
-	CX_HEADSET_ALLPRESENT,
-};
-
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
@@ -48,7 +42,6 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-	unsigned int headset_present_flag;
 	bool is_cx8070_sn6140;
 };
 
@@ -250,48 +243,19 @@ static void cx_process_headset_plugin(struct hda_codec *codec)
 	}
 }
 
-static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
+static void cx_update_headset_mic_vref(struct hda_codec *codec, struct hda_jack_callback *event)
 {
-	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
-	struct conexant_spec *spec = codec->spec;
+	unsigned int mic_persent;
 
 	/* In cx8070 and sn6140, the node 16 can only be config to headphone or disabled,
 	 * the node 19 can only be config to microphone or disabled.
 	 * Check hp&mic tag to process headset pulgin&plugout.
 	 */
-	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	if ((phone_tag & (res >> AC_UNSOL_RES_TAG_SHIFT)) ||
-	    (mic_tag & (res >> AC_UNSOL_RES_TAG_SHIFT))) {
-		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
-		if (!(phone_present & AC_PINSENSE_PRESENCE)) {/* headphone plugout */
-			spec->headset_present_flag = CX_HEADSET_NOPRESENT;
-			snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
-			return;
-		}
-		if (spec->headset_present_flag == CX_HEADSET_NOPRESENT) {
-			spec->headset_present_flag = CX_HEADSET_PARTPRESENT;
-		} else if (spec->headset_present_flag == CX_HEADSET_PARTPRESENT) {
-			mic_persent = snd_hda_codec_read(codec, 0x19, 0,
-							 AC_VERB_GET_PIN_SENSE, 0x0);
-			/* headset is present */
-			if ((phone_present & AC_PINSENSE_PRESENCE) &&
-			    (mic_persent & AC_PINSENSE_PRESENCE)) {
-				cx_process_headset_plugin(codec);
-				spec->headset_present_flag = CX_HEADSET_ALLPRESENT;
-			}
-		}
-	}
-}
-
-static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	struct conexant_spec *spec = codec->spec;
-
-	if (spec->is_cx8070_sn6140)
-		cx_update_headset_mic_vref(codec, res);
-
-	snd_hda_jack_unsol_event(codec, res);
+	mic_present = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (!(mic_present & AC_PINSENSE_PRESENCE)) /* mic plugout */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+	else
+		cx_process_headset_plugin(codec);
 }
 
 static int cx_auto_suspend(struct hda_codec *codec)
@@ -305,7 +269,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = cx_jack_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
 };
@@ -1163,7 +1127,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f11f86:
 	case 0x14f11f87:
 		spec->is_cx8070_sn6140 = true;
-		spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
 		break;
 	}
 
-- 
2.25.1


