Return-Path: <linux-kernel+bounces-560440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7721A60447
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14BC3B6598
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F91F75A9;
	Thu, 13 Mar 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=butoba.net header.i=@butoba.net header.b="jDDKyIl/"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBB1F582B;
	Thu, 13 Mar 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904876; cv=none; b=OGrCYNwC/R7lMjMfHjEBBwJftSMmxYkbtvl99ijKTd4z4dUYsU3xEhV1WsiFgZGK7ssOWbXLHZyTEFfHzfrIxz+3wNTzYXnCr+AJVhCHkJEBUHqxR6HkXv+xlRpQVR7npiqYvAoLoP+Xr7vpTPKR8oiuOzR0Lr3V5rTKQYjjbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904876; c=relaxed/simple;
	bh=VCiyo9qh2qsP+UIqbZBxs79RnpIfoKZDn1xq5OHT2kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=deaJV/XU4V4n52Cl+uY9AoT2Zz+WYu+V+XW+q9SomlscFn4Enta7F8DW+kVXGkzjD1cqLIkYZf23Q0RD/3SASaf+siGuliE5ruXDaEm0bWLZlYUgaUNVShzd+P3NugX0ZDbgjjnjDfFHkup1PmPa1Q4L9LQ+y5SxEJL6dNnnBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=butoba.net; spf=pass smtp.mailfrom=butoba.net; dkim=pass (1024-bit key) header.d=butoba.net header.i=@butoba.net header.b=jDDKyIl/; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=butoba.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=butoba.net
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4ZDMN15bh2z1DR2p;
	Thu, 13 Mar 2025 23:18:41 +0100 (CET)
Received: from localhost.localdomain (c188-150-74-79.bredband.tele2.se [188.150.74.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4ZDMMt322tz1DHW7;
	Thu, 13 Mar 2025 23:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=butoba.net;
	s=unoeuro; t=1741904321;
	bh=wq5o/h9J6qHu2CeQN+MnmcVFY03Ny4fDQbQWqXd3rZk=;
	h=From:To:Cc:Subject:Date;
	b=jDDKyIl/oabgmH3FgnxDyZcDtRC+Vao/Cq7+tzJ/1bQDbGO8at6e5z67VlHP9e8gO
	 Z0lmK4tWyFQRk4WLjNnW2JU7BDeLPyBUqGhcGoFIRjCPYtTalWyRiQ5lyCXjPQkBlV
	 XwOyojTrmP2HyEYhWyVvrGnWP9UrOS5IiMyRDQhk=
From: Ricard Wanderlof <ricard2013@butoba.net>
To: Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Ricard Wanderlof <ricard2013@butoba.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix CME quirk for UF series keyboards
Date: Thu, 13 Mar 2025 23:16:17 +0100
Message-Id: <20250313-cme-fix-v1-1-d404889e4de8@butoba.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250313-cme-fix-087b7321ed46
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit

Fix quirk for CME master keyboards so it not only handles
sysex but also song position pointer, MIDI timing clock, start
and stop messages, and active sensing. All of these can be
output by the CME UF series master keyboards.

Tested with a CME UF6 in a desktop Linux environment as
well as on the Zynthian Raspberry Pi based platform.

Signed-off-by: Ricard Wanderlof <ricard2013@butoba.net>
---
The CME UF6 not only sends sysex messages using CIN 0xf which
in the standard is only intended for single-byte unparsed
messages, but also song position pointer, as well as ordinary
MIDI timing clock, start, stop and active sensing.

The old quirk sent all four bytes of the USB MIDI message through
when CIN 0xf was received, which caused trailing bytes in the case
of single byte data, which would be interpreted as zero-valued
repeats of the previosly received channel message due to the
running status feature of MIDI. (In practice, this causes
continuous controllers to be reset to 0 as soon as a new value is
set. For note messages, it basically results in a note off for
note number 0, which is an annoyance although harmless in 
practice.)

Furthermore, the UF6 can send multiple messages in the same
packet. Because of this, and the 0xf quirk, we need to parse each
such message individually to get the length right, before sending
it on.

Finally, the UF6 sends messages with length 0 when it has nothing
else to send; don't forward these useless messages.

According to the original comment in the code, the old
functionality was intended to handle sysex messages only, and this
commit will still handle that case properly, so should be
compatible with all devices utilizing this quirk. I have only
tested this with a CME UF6 as don't have access to any other
CME devices (which are pretty old and rare these days).
---
 sound/usb/midi.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 737dd00e97b142148fc8b9c997067528d86e6543..aa2b7c589c019d8ec1e92dfe54e0e33ac4132709 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -489,16 +489,84 @@ static void ch345_broken_sysex_input(struct snd_usb_midi_in_endpoint *ep,
 
 /*
  * CME protocol: like the standard protocol, but SysEx commands are sent as a
- * single USB packet preceded by a 0x0F byte.
+ * single USB packet preceded by a 0x0F byte, as are system realtime
+ * messages and MIDI Active Sensing.
+ * Also, multiple messages can be sent in the same packet.
  */
 static void snd_usbmidi_cme_input(struct snd_usb_midi_in_endpoint *ep,
 				  uint8_t *buffer, int buffer_length)
 {
-	if (buffer_length < 2 || (buffer[0] & 0x0f) != 0x0f)
-		snd_usbmidi_standard_input(ep, buffer, buffer_length);
-	else
-		snd_usbmidi_input_data(ep, buffer[0] >> 4,
-				       &buffer[1], buffer_length - 1);
+	int remaining = buffer_length;
+
+	/*
+	 * CME send sysex, song position pointer, system realtime
+	 * and active sensing using CIN 0x0f, which in the standard
+	 * is only intended for single byte unparsed data.
+	 * So we need to interpret these here before sending them on.
+	 * By default, we assume single byte data, which is true
+	 * for system realtime (midi clock, start, stop and continue)
+	 * and active sensing, and handle the other (known) cases
+	 * separately.
+	 * In contrast to the standard, CME does not split sysex
+	 * into multiple 4-byte packets, but lumps everything together
+	 * into one. In addition, CME can string multiple messages
+	 * together in the same packet; pressing the Record button
+	 * on an UF6 sends a sysex message directly followed
+	 * by a song position pointer in the same packet.
+	 * For it to have any reasonable meaning, a sysex message
+	 * needs to be at least 3 bytes in length (0xf0, id, 0xf7),
+	 * corresponding to a packet size of 4 bytes, and the ones sent
+	 * by CME devices are 6 or 7 bytes, making the packet fragments
+	 * 7 or 8 bytes long (six or seven bytes plus preceding CN+CIN byte).
+	 * For the other types, the packet size is always 4 bytes,
+	 * as per the standard, with the data size being 3 for SPP
+	 * and 1 for the others.
+	 * Thus all packet fragments are at least 4 bytes long, so we can
+	 * skip anything that is shorter; this also conveniantly skips
+	 * packets with size 0, which CME devices continuously send when
+	 * they have nothing better to do.
+	 * Another quirk is that sometimes multiple messages are sent
+	 * in the same packet. This has been observed for midi clock
+	 * and active sensing i.e. 0x0f 0xf8 0x00 0x00 0x0f 0xfe 0x00 0x00,
+	 * but also multiple note ons/offs, and control change together
+	 * with MIDI clock. Similarly, some sysex messages are followed by
+	 * the song position pointer in the same packet, and occasionally
+	 * additionally by a midi clock or active sensing.
+	 * We handle this by looping over all data and parsing it along the way.
+	 */
+	while (remaining >= 4) {
+		int source_length = 4; /* default */
+
+		if ((buffer[0] & 0x0f) == 0x0f) {
+			int data_length = 1; /* default */
+
+			if (buffer[1] == 0xf0) {
+				/* Sysex: Find EOX and send on whole message. */
+				/* To kick off the search, skip the first
+				 * two bytes (CN+CIN and SYSEX (0xf0).
+				 */
+				uint8_t *tmp_buf = buffer + 2;
+				int tmp_length = remaining - 2;
+
+				while (tmp_length > 1 && *tmp_buf != 0xf7) {
+					tmp_buf++;
+					tmp_length--;
+				}
+				data_length = tmp_buf - buffer;
+				source_length = data_length + 1;
+			} else if (buffer[1] == 0xf2) {
+				/* Three byte song position pointer */
+				data_length = 3;
+			}
+			snd_usbmidi_input_data(ep, buffer[0] >> 4,
+					       &buffer[1], data_length);
+		} else {
+			/* normal channel events */
+			snd_usbmidi_standard_input(ep, buffer, source_length);
+		}
+		buffer += source_length;
+		remaining -= source_length;
+	}
 }
 
 /*

---
base-commit: 520a563b9a162d8a7484a32086de8e7c84d69945
change-id: 20250313-cme-fix-087b7321ed46

Best regards,
-- 
--
Ricard Wanderlöf                              [ http://www.butoba.net ]

Analog synth, railroad, magnetic recording and Citroen GS/GSA enthusiast
        -- "Ich bin der Musikant mit Taschenrechner in der Hand" --


