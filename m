Return-Path: <linux-kernel+bounces-263089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687D93D0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41BF1F2285B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D3178CC3;
	Fri, 26 Jul 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="plreNQT5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5A17623E;
	Fri, 26 Jul 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988506; cv=none; b=ZFVeyi4Z7cjCx/U9EinhzJpIzrAQTbzsvtJLFdY7cW/psgowyglKpYT0uL2UaALmPsAJoinhe26KuAjfL8BWt3YeU9O/pAarOKUSlESLuEDZ9B1BYOHLb1fzTXc8tfEfr4yw/rF45E91o1wqVKw7HsHpmVuHK/sUiOzHRN1XBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988506; c=relaxed/simple;
	bh=Ood64rNIOWuYqSpflyYa5lV4UQwXqOLunxYo926e0IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrLlHtAj9U5GRyCl31BBIsX/Acs3YFGJK9S0oGtZQf3DINqAeXG+UHEkycmpONCKhaI/ifEnZpWhqAfr5ncIiEmCo1xVXstDBaq6/OlD89B1aEUZXbJ8q6iKvOa8fGRXUXNEL1b09GNqySKlAaUavcDdQojanArDAy3G+NUAoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=plreNQT5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pg+iy
	yeRYmJJkwTJ+9hZ3wWgHFf7YDFOM4S6n15Ntzk=; b=plreNQT53znNl3EYtM7Vd
	9lnyLIWglDjr7FeCoAmhZSPKPBcZdiH/15ttk9XqyTv7ShU8OvdFVWcTVSOkbdkC
	HBtTwLlIV0Ej328MddeYD/zT74l7BZZfFWWYx2ctPZnQ2JWxsDyVvdspAe9ykkOg
	HpuY00VDgKW87m2wvwZIcA=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wDHjxtgdaNmPaOCAA--.28851S2;
	Fri, 26 Jul 2024 18:07:29 +0800 (CST)
From: soxiebing <soxiebing@163.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH v2] ALSA: hda: conexant: Fix headset auto detect fail in the polling mode
Date: Fri, 26 Jul 2024 18:07:26 +0800
Message-Id: <20240726100726.50824-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726012342.8645-1-soxiebing@163.com>
References: <20240726012342.8645-1-soxiebing@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHjxtgdaNmPaOCAA--.28851S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1xuw1kZF13JFWrXFy7ZFb_yoWrZF1fpF
	1rCF1fXrZ3tF1vvayrJws7u3WUCFyrZFZrG347t3yfJw1a9ry8Xa4IgrySqFWfJFyDKF12
	vr4qgFyUtr4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/1tbiJx4ow2XAm9gpvAACsj

From: songxiebing <songxiebing@kylinos.cn>

The previous fix (7aeb25908648) only handles the unsol_event reporting
during interrupts and does not include the polling mode used to set
jackroll_ms, so now we are replacing it with snd_hda_jack_detect_enable_callback.

V1 -> V2: fix char persent compile error

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Co-developed-by: bo liu <bo.liu@senarytech.com>
Signed-off-by: bo liu <bo.liu@senarytech.com>
Signed-off-by: songxiebing <songxiebing@kylinos.cn>
---
 sound/pci/hda/patch_conexant.c | 54 ++++++----------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 17389a3801bd..4472923ba694 100644
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
+	unsigned int mic_present;
 
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


