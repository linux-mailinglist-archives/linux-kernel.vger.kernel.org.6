Return-Path: <linux-kernel+bounces-223242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FBD911022
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3555B1C2433D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB51CE0BE;
	Thu, 20 Jun 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUnQp5nq"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0D1CE09E;
	Thu, 20 Jun 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906316; cv=none; b=OpISsrcwPPhvW8PNlBvF/qQWwTFFKj5IF1XLeXZKwkcKF41KY0cChcTEbbf7cZAF4orbMTIi6HeVoLVxGpa/IZVKXU468mRqiQOCt0shoSZwBE8PF9XcqvUEuOsMt/qt/8QINybDTbJMoWnOZD1sWY2gxm0+uKPD32zvq/Gm2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906316; c=relaxed/simple;
	bh=RuFo+rj7IH+rMOczKL4ih3dsBtps5oyKpsIg/YRyQz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bd5g8LIHnIEtqxyYpMcSZ9oOu0jgan7gZzVANzuvtN5phuc7lmkh6YyAzCgANUfOikZBx2jvYDyObG86LPF+f6Zcnuj2/WA4xIIX38kuo45n51D9TQPCCpKRLh9YH2G2AtdSbEeYOTo6P2cFdk88PMHs4THq9WnEKdSIxgz/WuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUnQp5nq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7062bf6d9a1so953086b3a.1;
        Thu, 20 Jun 2024 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906314; x=1719511114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW85PghmUwc3BgHXRaYJ+DzXpmwYGv3Aew2YdRltNsw=;
        b=bUnQp5nqJIWUAOvQEkxHkXrxZC1VmKvFsJT5jnzaDAuwKWqNVV7zXc4xyZgPovG15R
         5dKtdAHRMW6XU1BZPAIZoDvDDKgwoA6mebkKystDnPygppmxvMqr5WhQl51mjc+sNEs0
         htJ2eRoIOq8hYdY3lu921s5D+VByM1Gwkxs9IYOqyGZhVQ8fOWVFgVmt0bp5k+r44+fT
         w2XGl/S0owQoSfCnTRbOUok/o0AIeoHF0iHsJ7He4150hKky6SmOh0ZoHL7uwN/vgbkh
         JPQTmf3dWak9WkMTOqFBF35oSKdrdFJP75TIWzRyb1/z2WVhiZ4aZWZ19hYJppGLs2z+
         JtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906314; x=1719511114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FW85PghmUwc3BgHXRaYJ+DzXpmwYGv3Aew2YdRltNsw=;
        b=AyBnD3IIozEEDeTCiaFSVcfGGo39IkO8qc6paxkNYCPTorkoaY4ePT1iWT84TUrSef
         b/KbSPxM/IYb//UosSdBcujoRCeEeTlZgBvdUiMFTF0O6rJpfYoNQzBcxEbBIicTx84W
         bhLo1xEuaL+OepF067/2H7j5bc8G71mQszdZhZKv3HoGAVmD2ICo3/P/Z1uqxWIbyUuo
         YQq455jj3wk8cmlw5aVjz1pIdTZPP0c8VK87jDyKyiymQTQKOMAEuKwEHi+qXDmcLJoQ
         5oIMsSsakKO1rgLAuB0Ajq0M0si2/h3FOdhjJVfeHfjlSMMbH/9cdF8qQIsfB2lyH9vH
         FsYg==
X-Forwarded-Encrypted: i=1; AJvYcCVcnxvPMCr7GrSD8awRZNLT3Z5EG4Q5ZVkJnj9zDi/6DMJp6nvH49nwmXAXv36I29deNxTYCQ3h7PyQ6aB5q2LvQMZUbJ/qAXqBBuk=
X-Gm-Message-State: AOJu0YzFYtdbm4HwoiQM1eoXRdnjI3Vhw7ZngY/1S/oqKCT01Giox8Ep
	ffV78eoBwTAefmtWMZ1WI6W34k6o++NEUMiwJb0q88QSwQm7AfVwayoTaUzWeiM=
X-Google-Smtp-Source: AGHT+IEoH3Qng23SGIOniQLh/mfoKH0d8yH2qow3ztjr66B8CysNLSQkypEK4r+/80Kz1cmwQvxiZw==
X-Received: by 2002:a05:6a20:7291:b0:1b5:cf26:ecfd with SMTP id adf61e73a8af0-1bcbb426fb3mr7450803637.24.1718906314118;
        Thu, 20 Jun 2024 10:58:34 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee2d34cc2sm11211938a12.64.2024.06.20.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:33 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <zonque@gmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v4 30/40] ALSA: use atomic find_bit() functions where applicable
Date: Thu, 20 Jun 2024 10:56:53 -0700
Message-ID: <20240620175703.605111-31-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ALSA code tests each bit in bitmaps in a for-loop. Switch it to
using dedicated atomic find_bit() API.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |  8 ++++----
 sound/usb/caiaq/audio.c   | 14 ++++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 325e8f0b99a8..7201afa82990 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/find_atomic.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -3263,10 +3264,9 @@ static int get_empty_pcm_device(struct hda_bus *bus, unsigned int type)
 
 #ifdef CONFIG_SND_DYNAMIC_MINORS
 	/* non-fixed slots starting from 10 */
-	for (i = 10; i < 32; i++) {
-		if (!test_and_set_bit(i, bus->pcm_dev_bits))
-			return i;
-	}
+	i = find_and_set_next_bit(bus->pcm_dev_bits, 32, 10);
+	if (i < 32)
+		return i;
 #endif
 
 	dev_warn(bus->card->dev, "Too many %s devices\n",
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 4981753652a7..93ecd5cfcb7d 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -4,6 +4,7 @@
 */
 
 #include <linux/device.h>
+#include <linux/find_atomic.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -610,7 +611,7 @@ static void read_completed(struct urb *urb)
 	struct snd_usb_caiaq_cb_info *info = urb->context;
 	struct snd_usb_caiaqdev *cdev;
 	struct device *dev;
-	struct urb *out = NULL;
+	struct urb *out;
 	int i, frame, len, send_it = 0, outframe = 0;
 	unsigned long flags;
 	size_t offset = 0;
@@ -625,17 +626,14 @@ static void read_completed(struct urb *urb)
 		return;
 
 	/* find an unused output urb that is unused */
-	for (i = 0; i < N_URBS; i++)
-		if (test_and_set_bit(i, &cdev->outurb_active_mask) == 0) {
-			out = cdev->data_urbs_out[i];
-			break;
-		}
-
-	if (!out) {
+	i = find_and_set_bit(&cdev->outurb_active_mask, N_URBS);
+	if (i >= N_URBS) {
 		dev_err(dev, "Unable to find an output urb to use\n");
 		goto requeue;
 	}
 
+	out = cdev->data_urbs_out[i];
+
 	/* read the recently received packet and send back one which has
 	 * the same layout */
 	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
-- 
2.43.0


