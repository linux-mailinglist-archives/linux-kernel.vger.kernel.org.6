Return-Path: <linux-kernel+bounces-285098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2F95094D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81FBB219AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD31A0724;
	Tue, 13 Aug 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoZMvWjb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TLUnJ2Qg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoZMvWjb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TLUnJ2Qg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5B1E86A;
	Tue, 13 Aug 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563778; cv=none; b=AKNB33KVF6c7asB99FYdlY+ygGvZ1SmImonO7hcjOmVKSX0+AqWPNpo7jUaK/6cWv/us5wwG2ieaZbUIlQMDO77NoE+kd+Y5erA2PhX9AltHFe+cXVb501ZPPedVFCPY8zprkI1ntKt2Q5ThGF4GcbUs3EgJTmqoIpptWumRWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563778; c=relaxed/simple;
	bh=xIYfFPq3vPk4FargRs0GKxm/pFpyikMHY1ZN7+lL55c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEt8m+brZTbuBXi5yxHk3NoAoSztLB4gidsz4dBCbnbNUYlwTR9sobAxLmDYAKRj1NIA8Xp1d4xvTAhH2qQFro3PVjxJHqpqDPlcVdxWtuoARlIbKZCzI+CslwrvYFvA7W5sDOupk7miHer0e//4VsKXK2UApMrJ0gluXGDDgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoZMvWjb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TLUnJ2Qg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoZMvWjb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TLUnJ2Qg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4257A203DF;
	Tue, 13 Aug 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723563774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qi5iCxX1Hq1CM510Gifrla2/m2sCHYgbJH0ytKi3uk=;
	b=ZoZMvWjbPl0r5Zx0oXXmusx/IKjsWCQ6DuG+BaXYqvTOIgGHGixpWUy8aneZOqOt/d5DEf
	FXAF01oDdTP1ARHI5HjeJfOxe02VfYO/54pQvvuVaGz27V4ZKxSNRWJQKUW7NXXWMd0lTi
	YSkBtrKHLVDCOqysBw0qKuprpRRvAdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723563774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qi5iCxX1Hq1CM510Gifrla2/m2sCHYgbJH0ytKi3uk=;
	b=TLUnJ2QgRBO1Q+uyISKd1KxwM346Be4CkZGxemKJIRtzicLSxkxoN7wtQ6jRGI79xpK/ik
	jWX0ldRk40MXOJCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723563774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qi5iCxX1Hq1CM510Gifrla2/m2sCHYgbJH0ytKi3uk=;
	b=ZoZMvWjbPl0r5Zx0oXXmusx/IKjsWCQ6DuG+BaXYqvTOIgGHGixpWUy8aneZOqOt/d5DEf
	FXAF01oDdTP1ARHI5HjeJfOxe02VfYO/54pQvvuVaGz27V4ZKxSNRWJQKUW7NXXWMd0lTi
	YSkBtrKHLVDCOqysBw0qKuprpRRvAdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723563774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qi5iCxX1Hq1CM510Gifrla2/m2sCHYgbJH0ytKi3uk=;
	b=TLUnJ2QgRBO1Q+uyISKd1KxwM346Be4CkZGxemKJIRtzicLSxkxoN7wtQ6jRGI79xpK/ik
	jWX0ldRk40MXOJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 013A913ABD;
	Tue, 13 Aug 2024 15:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkkhOv1+u2ZtQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 15:42:53 +0000
Date: Tue, 13 Aug 2024 17:43:33 +0200
Message-ID: <87sev8l97e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juan =?ISO-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH 2/2] ALSA: usb-audio: reduce checkpatch issues in quirks-table.h
In-Reply-To: <87cymcdi62.wl-tiwai@suse.de>
References: <cover.1723518816.git.soyjuanarbol@gmail.com>
	<6dabfd5c05c04b0e4fc00a708cc65d691af4e267.1723518816.git.soyjuanarbol@gmail.com>
	<87cymcdi62.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: multipart/mixed;
 boundary="Multipart_Tue_Aug_13_17:43:33_2024-1"
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.996];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:~];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

--Multipart_Tue_Aug_13_17:43:33_2024-1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On Tue, 13 Aug 2024 08:57:09 +0200,
Takashi Iwai wrote:
> 
> On Tue, 13 Aug 2024 05:31:28 +0200,
> Juan José Arboleda wrote:
> > 
> > Reduced checkpatch errors from 185 to 2, and warnings from 4 to 1 in
> > sound/usb/quirks-table.h.
> > 
> > Remaining issues were reviewed and considered non-blocking.
> > 
> > Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
> 
> Honestly speaking, I don't find it's much improvement from the code
> readability POV.  (And you don't have to "correct" the spaces in
> comment lines :)
> 
> That is, if the reason of the changes is only about the complaint from
> checkpatch, we can simply ignore it.  Above all, applying space-only
> fixes would make the stable backports more difficult.
> 
> OTOH, if we really want to improve the code readability, maybe it'd be
> better to introduce some macros to simplify the definitions.  e.g.
> 
> /* Quirk driver_info, use like QUIRK_DRIVER_INFO { ... } */
> #define QUIRK_DRIVER_INFO \
> 	.driver_info = (unsigned long)&(const struct snd_usb_audio_quirk)
> 
> /* Quirk data entry for struct audioformat */
> #define QUIRK_DATA_AUDIOFORMAT \
> 	.data = &(const struct audioformat)
> /* Quirk data entry for struct snd_usb_midiendpoint_info */
> #define QUIRK_DATA_MIDI_EP_INFO \
> 	.data = &(const struct snd_usb_midi_endpoint_info)
> 
> and replace accordingly.
> 
> But again, I'm not sure whether it's worth.  Macros might be good from
> the code safety as the open code is error prone, though.

FWIW, the patches below are what I had in my mind.


Takashi


--Multipart_Tue_Aug_13_17:43:33_2024-1
Content-Type: application/octet-stream; type=patch; name="0001-ALSA-usb-audio-Define-macros-for-quirk-table-entries.patch"
Content-Disposition: attachment; filename="0001-ALSA-usb-audio-Define-macros-for-quirk-table-entries.patch"
Content-Transfer-Encoding: 7bit

From aebbbb046619b2d694c2faa803b89a8aad98a38d Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 13 Aug 2024 13:23:14 +0200
Subject: [PATCH 1/2] ALSA: usb-audio: Define macros for quirk table entries

Many entries in the USB-audio quirk tables have relatively complex
expressions.  For improving the readability, introduce a few macros.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f13a8d63a019..4e920afb3d74 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -35,6 +35,47 @@
 	.bInterfaceClass = USB_CLASS_AUDIO, \
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 
+/* Quirk .driver_info, followed by the definition of the quirk entry;
+ * use like QUIRK_DRIVER_INFO { ... } in each entry of the quirk table
+ */
+#define QUIRK_DRIVER_INFO \
+	.driver_info = (unsigned long)&(const struct snd_usb_audio_quirk)
+
+/* Quirk composite array terminator */
+#define QUIRK_COMPOSITE_END	{ .ifnum = -1 }
+
+/* Quirk data entry for composite quirks;
+ * followed by the quirk array that is terminated with QUIRK_COMPOSITE_END
+ * e.g. QUIRK_DATA_COMPOSITE { quirk1, quirk2, ..., QUIRK_COMPOSITE_END }
+ */
+#define QUIRK_DATA_COMPOSITE \
+	.type = QUIRK_COMPOSITE, \
+	.data = &(const struct snd_usb_audio_quirk[])
+
+/* Quirk data entry for a fixed audio endpoint;
+ * followed by audioformat definition
+ * e.g. QUIRK_DATA_AUDIOFORMAT { .formats = xxx, ... }
+ */
+#define QUIRK_DATA_AUDIOFORMAT \
+	.type = QUIRK_AUDIO_FIXED_ENDPOINT, \
+	.data = &(const struct audioformat)
+
+/* Quirk data entry for a fixed MIDI endpoint;
+ * followed by snd_usb_midi_endpoint_info definition
+ * e.g. QUIRK_DATA_MIDI_FIXED_ENDPOINT { .out_cables = x, .in_cables = y }
+ */
+#define QUIRK_DATA_MIDI_FIXED_ENDPOINT \
+	.type = QUIRK_MIDI_FIXED_ENDPOINT, \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+/* Quirk data entry for a MIDIMAN MIDI endpoint */
+#define QUIRK_DATA_MIDI_MIDIMAN \
+	.type = QUIRK_MIDI_MIDIMAN, \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+/* Quirk data entry for a EMAGIC MIDI endpoint */
+#define QUIRK_DATA_MIDI_EMAGIC \
+	.type = QUIRK_MIDI_EMAGIC, \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
-- 
2.43.0


--Multipart_Tue_Aug_13_17:43:33_2024-1
Content-Type: application/octet-stream; type=patch; name="0002-ALSA-usb-audio-Replace-complex-quirk-lines-with-macr.patch"
Content-Disposition: attachment; filename="0002-ALSA-usb-audio-Replace-complex-quirk-lines-with-macr.patch"
Content-Transfer-Encoding: 7bit

From be6199c759736526964c08572352ddb2558ba867 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 13 Aug 2024 13:24:08 +0200
Subject: [PATCH 2/2] ALSA: usb-audio: Replace complex quirk lines with macros

Apply the newly introduced macros for reduce the complex expressions
and cast in the quirk table definitions.
There should be no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 1219 ++++++++++++++------------------------
 1 file changed, 429 insertions(+), 790 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 4e920afb3d74..e409c53c9837 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -79,7 +79,7 @@
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "STARR LABS", */
 		/* .product_name = "Starr Labs MIDI USB device", */
 		.ifnum = 0,
@@ -90,10 +90,9 @@
 {
 	/* Creative BT-D1 */
 	USB_DEVICE(0x041e, 0x0005),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = 1,
-		.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-		.data = &(const struct audioformat) {
+		QUIRK_DATA_AUDIOFORMAT {
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 			.channels = 2,
 			.iface = 1,
@@ -128,18 +127,16 @@
  */
 {
 	USB_AUDIO_DEVICE(0x041e, 0x4095),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.fmt_bits = 16,
@@ -155,9 +152,7 @@
 					.rate_table = (unsigned int[]) { 48000 },
 				},
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END,
 		},
 	},
 },
@@ -169,12 +164,11 @@
  */
 {
 	USB_DEVICE(0x0424, 0xb832),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Standard Microsystems Corp.",
 		.product_name = "HP Wireless Audio",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			/* Mixer */
 			{
 				.ifnum = 0,
@@ -191,9 +185,7 @@
 				.type = QUIRK_IGNORE_INTERFACE,
 			},
 			/* HID Device, .ifnum = 3 */
-			{
-				.ifnum = -1,
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -216,7 +208,7 @@
 
 #define YAMAHA_DEVICE(id, name) { \
 	USB_DEVICE(0x0499, id), \
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
+	QUIRK_DRIVER_INFO { \
 		.vendor_name = "Yamaha", \
 		.product_name = name, \
 		.ifnum = QUIRK_ANY_INTERFACE, \
@@ -225,7 +217,7 @@
 }
 #define YAMAHA_INTERFACE(id, intf, name) { \
 	USB_DEVICE_VENDOR_SPEC(0x0499, id), \
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
+	QUIRK_DRIVER_INFO { \
 		.vendor_name = "Yamaha", \
 		.product_name = name, \
 		.ifnum = intf, \
@@ -316,12 +308,11 @@ YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
 {
 	USB_DEVICE(0x0499, 0x1503),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "MOX6/MOX8", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -334,20 +325,17 @@ YAMAHA_DEVICE(0x105d, NULL),
 				.ifnum = 3,
 				.type = QUIRK_MIDI_YAMAHA
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x1507),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR10", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -360,20 +348,17 @@ YAMAHA_DEVICE(0x105d, NULL),
 				.ifnum = 3,
 				.type = QUIRK_MIDI_YAMAHA
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x1509),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "Steinberg UR22", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -390,20 +375,17 @@ YAMAHA_DEVICE(0x105d, NULL),
 				.ifnum = 4,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x150a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR5A", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -416,20 +398,17 @@ YAMAHA_DEVICE(0x105d, NULL),
 				.ifnum = 3,
 				.type = QUIRK_MIDI_YAMAHA
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x150c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR10C", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -442,9 +421,7 @@ YAMAHA_DEVICE(0x105d, NULL),
 				.ifnum = 3,
 				.type = QUIRK_MIDI_YAMAHA
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -478,7 +455,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	               USB_DEVICE_ID_MATCH_INT_CLASS,
 	.idVendor = 0x0499,
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUTODETECT
 	}
@@ -489,16 +466,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_DEVICE(0x0582, 0x0000),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "UA-100",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 4,
 					.iface = 0,
@@ -514,8 +489,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 1,
@@ -531,26 +505,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0007,
 					.in_cables  = 0x0007
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-4",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -561,26 +531,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x000f,
 					.in_cables  = 0x000f
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SC-8850",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -591,26 +557,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x003f,
 					.in_cables  = 0x003f
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0004),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "U-8",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -621,15 +583,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0005,
 					.in_cables  = 0x0005
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -637,12 +596,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	/* Has ID 0x0099 when not in "Advanced Driver" mode.
 	 * The UM-2EX has only one input, but we cannot detect this. */
 	USB_DEVICE(0x0582, 0x0005),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-2",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -653,26 +611,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0003,
 					.in_cables  = 0x0003
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0007),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SC-8820",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -683,26 +637,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0013,
 					.in_cables  = 0x0013
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0008),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "PC-300",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -713,27 +663,23 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x009d when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0009),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -744,26 +690,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x000b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SK-500",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -774,15 +716,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0013,
 					.in_cables  = 0x0013
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -790,12 +729,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	/* thanks to Emiliano Grilli <emillo@libero.it>
 	 * for helping researching this data */
 	USB_DEVICE(0x0582, 0x000c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SC-D70",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -806,15 +744,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0007,
 					.in_cables  = 0x0007
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -828,12 +763,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * the 96kHz sample rate.
 	 */
 	USB_DEVICE(0x0582, 0x0010),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-5",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -842,21 +776,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x0013 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0012),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "XV-5050",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -865,12 +796,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0015 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0014),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-880",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -879,12 +809,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0017 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0016),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-90",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -895,27 +824,23 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x000f,
 					.in_cables  = 0x000f
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x001c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x001b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "MMP-2",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -926,27 +851,23 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x001e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x001d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "V-SYNTH",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -955,12 +876,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0024 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0023),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-550",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x003f,
 			.in_cables  = 0x003f
 		}
@@ -973,20 +893,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and no MIDI.
 	 */
 	USB_DEVICE(0x0582, 0x0025),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-20",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
@@ -1002,8 +920,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 2,
@@ -1019,27 +936,23 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x0028 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0027),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-20",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1048,12 +961,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x002a when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0029),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-80",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -1066,12 +978,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * but offers only 16-bit PCM and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x002b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-700",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
@@ -1084,21 +995,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 3,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x002e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x002d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "XV-2020",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1107,12 +1015,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0030 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x002f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "VariOS",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -1121,12 +1028,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0034 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0033),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1138,12 +1044,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * later revisions use IDs 0x0054 and 0x00a2.
 	 */
 	USB_DEVICE(0x0582, 0x0037),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "Digital Piano",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1156,12 +1061,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x003b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "BOSS",
 		.product_name = "GS-10",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1174,21 +1078,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 3,
 				.type = QUIRK_MIDI_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x0041 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "GI-20",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1197,12 +1098,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0043 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0042),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "RS-70",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1211,12 +1111,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0049 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0047),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "UR-80", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			/* in the 96 kHz modes, only interface 1 is there */
 			{
 				.ifnum = 1,
@@ -1226,21 +1125,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x004a when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0048),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "UR-80", */
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1249,12 +1145,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x004e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR-A",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1263,21 +1158,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x004f when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR-A",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1289,12 +1181,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * is standard compliant, but has only 16-bit PCM.
 	 */
 	USB_DEVICE(0x0582, 0x0050),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-3FX",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1303,15 +1194,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0052),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1SX",
 		.ifnum = 0,
@@ -1320,7 +1209,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0060),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "EXR Series",
 		.ifnum = 0,
@@ -1330,12 +1219,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0066 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0064),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "PCR-1", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1344,21 +1232,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x0067 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0065),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "PCR-1", */
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0003
 		}
@@ -1367,12 +1252,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x006e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x006d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "FANTOM-X",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1385,12 +1269,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0074),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-25",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
@@ -1403,21 +1286,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* has ID 0x0076 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0075),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "BOSS",
 		.product_name = "DR-880",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1426,12 +1306,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x007b when not in "Advanced Driver" mode */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x007a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		/* "RD" or "RD-700SX"? */
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -1440,12 +1319,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0081 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "G-70",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1454,12 +1332,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x008c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x008b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PC-50",
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1471,12 +1348,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * is standard compliant, but has only 16-bit PCM and no MIDI.
 	 */
 	USB_DEVICE(0x0582, 0x00a3),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-4FX",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
@@ -1489,19 +1365,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* Edirol M-16DX */
 	USB_DEVICE(0x0582, 0x00c4),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1512,15 +1385,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -1530,12 +1400,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x00e6),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-25EX",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
@@ -1548,19 +1417,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* Edirol UM-3G */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0108),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -1569,10 +1435,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* BOSS ME-25 */
 	USB_DEVICE(0x0582, 0x0113),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1583,31 +1448,26 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x0120),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "OCTO-CAPTURE", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 10,
 					.iface = 0,
@@ -1624,8 +1484,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 12,
 					.iface = 1,
@@ -1642,8 +1501,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1656,25 +1514,21 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 4,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x012f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "QUAD-CAPTURE", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 4,
 					.iface = 0,
@@ -1691,8 +1545,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 6,
 					.iface = 1,
@@ -1709,8 +1562,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1723,20 +1575,17 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 4,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0159),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "UA-22", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1747,15 +1596,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -1763,19 +1609,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* UA101 and co are supported by another driver */
 {
 	USB_DEVICE(0x0582, 0x0044), /* UA-1000 high speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
 {
 	USB_DEVICE(0x0582, 0x007d), /* UA-101 high speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
 {
 	USB_DEVICE(0x0582, 0x008d), /* UA-101 full speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
@@ -1786,7 +1632,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	               USB_DEVICE_ID_MATCH_INT_CLASS,
 	.idVendor = 0x0582,
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUTODETECT
 	}
@@ -1801,12 +1647,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * compliant USB MIDI ports for external MIDI and controls.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x06f8, 0xb000),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Hercules",
 		.product_name = "DJ Console (WE)",
 		.ifnum = 4,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 			.out_cables = 0x0001,
 			.in_cables = 0x0001
 		}
@@ -1816,12 +1661,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Midiman/M-Audio devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 2x2",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -1829,12 +1673,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1011),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 1x1",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1842,12 +1685,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1015),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "Keystation",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1855,12 +1697,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1021),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 4x4",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -1873,12 +1714,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Thanks to Olaf Giesbrecht <Olaf_Giesbrecht@yahoo.de>
 	 */
 	USB_DEVICE_VER(0x0763, 0x1031, 0x0100, 0x0109),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 8x8",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -1886,12 +1726,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1033),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 8x8",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -1899,12 +1738,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1041),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 2x4",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x000f,
 			.in_cables  = 0x0003
 		}
@@ -1912,12 +1750,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "Quattro",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			/*
 			 * Interfaces 0-2 are "Windows-compatible", 16-bit only,
 			 * and share endpoints with the other interfaces.
@@ -1962,26 +1799,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 9,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_MIDIMAN {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "AudioPhile",
 		.ifnum = 6,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1989,12 +1822,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2008),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "Ozone",
 		.ifnum = 3,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -2002,12 +1834,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x200d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "OmniStudio",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -2046,26 +1877,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 9,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_MIDIMAN {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x0763, 0x2019),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Ozone Academic", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -2080,15 +1907,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_MIDIMAN {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2098,12 +1922,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track C400", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
@@ -2111,8 +1934,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 2,
@@ -2137,8 +1959,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Capture */
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 3,
@@ -2160,21 +1981,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x80,
 				}
 			},
-			/* MIDI */
-			{
-				.ifnum = -1 /* Interface = 4 */
-			}
+			/* MIDI: Interface = 4*/
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2031),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track C600", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
@@ -2182,8 +2000,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2208,8 +2025,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Capture */
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 3,
@@ -2231,29 +2047,25 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x80,
 				}
 			},
-			/* MIDI */
-			{
-				.ifnum = -1 /* Interface = 4 */
-			}
+			/* MIDI: Interface = 4 */
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -2276,8 +2088,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2299,28 +2110,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			/* interface 3 (MIDI) is standard compliant */
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2081),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra 8R", */
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -2343,8 +2150,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2366,9 +2172,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			/* interface 3 (MIDI) is standard compliant */
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2376,7 +2180,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Casio devices */
 {
 	USB_DEVICE(0x07cf, 0x6801),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Casio",
 		.product_name = "PL-40R",
 		.ifnum = 0,
@@ -2386,7 +2190,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* this ID is used by several devices without a product ID */
 	USB_DEVICE(0x07cf, 0x6802),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Casio",
 		.product_name = "Keyboard",
 		.ifnum = 0,
@@ -2403,12 +2207,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	.idVendor = 0x07fd,
 	.idProduct = 0x0001,
 	.bDeviceSubClass = 2,
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MOTU",
 		.product_name = "Fastlane",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_MIDI_RAW_BYTES
@@ -2417,9 +2220,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2427,12 +2228,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Emagic devices */
 {
 	USB_DEVICE(0x086a, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Emagic",
 		.product_name = "Unitor8",
 		.ifnum = 2,
-		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_EMAGIC {
 			.out_cables = 0x80ff,
 			.in_cables  = 0x80ff
 		}
@@ -2440,12 +2240,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x086a, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Emagic",
 		/* .product_name = "AMT8", */
 		.ifnum = 2,
-		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_EMAGIC {
 			.out_cables = 0x80ff,
 			.in_cables  = 0x80ff
 		}
@@ -2453,12 +2252,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x086a, 0x0003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Emagic",
 		/* .product_name = "MT4", */
 		.ifnum = 2,
-		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_EMAGIC {
 			.out_cables = 0x800f,
 			.in_cables  = 0x8003
 		}
@@ -2468,7 +2266,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* KORG devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0200),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "PANDORA PX5D", */
 		.ifnum = 3,
@@ -2478,7 +2276,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0201),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "ToneLab ST", */
 		.ifnum = 3,
@@ -2488,7 +2286,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0204),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "ToneLab EX", */
 		.ifnum = 3,
@@ -2499,7 +2297,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* AKAI devices */
 {
 	USB_DEVICE(0x09e8, 0x0062),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "AKAI",
 		.product_name = "MPD16",
 		.ifnum = 0,
@@ -2510,10 +2308,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Akai MPC Element */
 	USB_DEVICE(0x09e8, 0x0021),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -2522,9 +2319,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_MIDI_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2533,10 +2328,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Steinberg MI2 */
 	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x2040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -2551,25 +2345,21 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* Steinberg MI4 */
 	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x4040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -2584,15 +2374,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2600,7 +2387,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* TerraTec devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0012),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
 		.ifnum = 3,
@@ -2609,7 +2396,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0013),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
 		.ifnum = 3,
@@ -2618,7 +2405,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0014),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
 		.ifnum = 3,
@@ -2627,7 +2414,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0ccd, 0x0035),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Miditech",
 		.product_name = "Play'n Roll",
 		.ifnum = 0,
@@ -2642,7 +2429,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Novation EMS devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "ReMOTE Audio/XStation",
 		.ifnum = 4,
@@ -2651,7 +2438,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "Speedio",
 		.ifnum = 3,
@@ -2660,7 +2447,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x000a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Novation", */
 		/* .product_name = "Nocturn", */
 		.ifnum = 0,
@@ -2669,7 +2456,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x000e),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Novation", */
 		/* .product_name = "Launchpad", */
 		.ifnum = 0,
@@ -2678,20 +2465,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x0010),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Focusrite",
 		.product_name = "Saffire 6 USB",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -2719,8 +2504,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 0,
@@ -2746,24 +2530,20 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_MIDI_RAW_BYTES
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE(0x1235, 0x0018),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "Twitch",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -2786,15 +2566,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_MIDI_RAW_BYTES
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x4661),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "ReMOTE25",
 		.ifnum = 0,
@@ -2806,14 +2584,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* VirusTI Desktop */
 	USB_DEVICE_VENDOR_SPEC(0x133e, 0x0815),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0003,
 					.in_cables  = 0x0003
 				}
@@ -2822,9 +2598,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 4,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2852,7 +2626,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* QinHeng devices */
 {
 	USB_DEVICE(0x1a86, 0x752d),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "QinHeng",
 		.product_name = "CH345",
 		.ifnum = 1,
@@ -2866,7 +2640,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Miditech devices */
 {
 	USB_DEVICE(0x4752, 0x0011),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Miditech",
 		.product_name = "Midistart-2",
 		.ifnum = 0,
@@ -2878,7 +2652,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* this ID used by both Miditech MidiStudio-2 and CME UF-x */
 	USB_DEVICE(0x7104, 0x2202),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = 0,
 		.type = QUIRK_MIDI_CME
 	}
@@ -2888,20 +2662,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Thanks to Clemens Ladisch <clemens@ladisch.de> */
 	USB_DEVICE(0x0dba, 0x1000),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Digidesign",
 		.product_name = "MBox",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]){
+		QUIRK_DATA_COMPOSITE{
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
@@ -2923,8 +2695,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
@@ -2945,9 +2716,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -2955,12 +2724,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* DIGIDESIGN MBOX 2 */
 {
 	USB_DEVICE(0x0dba, 0x3000),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Digidesign",
 		.product_name = "Mbox 2",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -2971,8 +2739,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 2,
@@ -2996,9 +2763,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 4,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
-				.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+				QUIRK_DATA_AUDIOFORMAT {
+					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 4,
 					.altsetting = 2,
@@ -3021,8 +2787,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 6,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_MIDIMAN {
 					.out_ep =  0x02,
 					.out_cables = 0x0001,
 					.in_ep = 0x81,
@@ -3030,21 +2795,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.in_cables = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 /* DIGIDESIGN MBOX 3 */
 {
 	USB_DEVICE(0x0dba, 0x5000),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Digidesign",
 		.product_name = "Mbox 3",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -3055,8 +2817,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.fmt_bits = 24,
 					.channels = 4,
@@ -3084,8 +2845,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.fmt_bits = 24,
 					.channels = 4,
@@ -3110,35 +2870,30 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 4,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 {
 	/* Tascam US122 MKII - playback-only support */
 	USB_DEVICE_VENDOR_SPEC(0x0644, 0x8021),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TASCAM",
 		.product_name = "US122 MKII",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
@@ -3159,9 +2914,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3169,20 +2922,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Denon DN-X1600 */
 {
 	USB_AUDIO_DEVICE(0x154e, 0x500e),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Denon",
 		.product_name = "DN-X1600",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]){
+		QUIRK_DATA_COMPOSITE{
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE,
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -3204,8 +2955,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -3229,9 +2979,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 4,
 				.type = QUIRK_MIDI_STANDARD_INTERFACE,
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3240,17 +2988,15 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	USB_DEVICE(0x045e, 0x0283),
 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Microsoft",
 		.product_name = "XboxLive Headset/Xbox Communicator",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				/* playback */
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 1,
 					.iface = 0,
@@ -3267,8 +3013,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				/* capture */
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 1,
 					.iface = 1,
@@ -3282,9 +3027,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_max = 16000
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3293,18 +3036,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	USB_DEVICE(0x200c, 0x100b),
 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 1,
@@ -3323,9 +3064,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3338,10 +3077,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * enabled in create_standard_audio_quirk().
 	 */
 	USB_DEVICE(0x1686, 0x00dd),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				/* Playback  */
 				.ifnum = 1,
@@ -3357,9 +3095,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 3,
 				.type = QUIRK_MIDI_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3373,7 +3109,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_MIDISTREAMING,
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_STANDARD_INTERFACE
 	}
@@ -3382,7 +3118,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Rane SL-1 */
 {
 	USB_DEVICE(0x13e5, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUDIO_STANDARD_INTERFACE
         }
@@ -3400,10 +3136,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and only the 48 kHz sample rate works for the playback interface.
 	 */
 	USB_DEVICE(0x0a12, 0x1243),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
@@ -3416,8 +3151,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 2,
@@ -3436,9 +3170,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3451,10 +3183,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * even on windows.
 	 */
 	USB_DEVICE(0x19b5, 0x0021),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
@@ -3462,8 +3193,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 1,
@@ -3482,29 +3212,25 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
 /* MOTU Microbook II */
 {
 	USB_DEVICE_VENDOR_SPEC(0x07fd, 0x0004),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MOTU",
 		.product_name = "MicroBookII",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 6,
 					.iface = 0,
@@ -3526,8 +3252,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 8,
 					.iface = 0,
@@ -3548,9 +3273,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3562,14 +3285,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The feedback for the output is the input.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0023),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 12,
 					.iface = 0,
@@ -3587,8 +3308,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 10,
 					.iface = 0,
@@ -3606,9 +3326,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3651,14 +3369,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * but not for DVS (Digital Vinyl Systems) like in Mixxx.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0017),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // outputs
 					.iface = 0,
@@ -3676,8 +3392,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // inputs
 					.iface = 0,
@@ -3695,9 +3410,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 48000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3708,14 +3421,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The feedback for the output is the dummy input.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000e),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -3733,8 +3444,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 0,
@@ -3752,9 +3462,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3765,14 +3473,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * PCM is 6 channels out & 4 channels in @ 44.1 fixed
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000d),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6, //Master, Headphones & Booth
 					.iface = 0,
@@ -3790,8 +3496,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4, //2x RCA inputs (CH1 & CH2)
 					.iface = 0,
@@ -3809,9 +3514,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3823,14 +3526,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The Feedback for the output is the input
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x001e),
-		.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -3848,8 +3549,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 0,
@@ -3867,9 +3567,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3880,14 +3578,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * 10 channels playback & 12 channels capture @ 44.1/48/96kHz S24LE
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000a),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 10,
 					.iface = 0,
@@ -3909,8 +3605,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 12,
 					.iface = 0,
@@ -3932,9 +3627,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -3946,14 +3639,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The Feedback for the output is the input
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0029),
-		.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 0,
@@ -3971,8 +3662,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 0,
@@ -3990,9 +3680,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4010,20 +3698,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_AUDIO_DEVICE(0x534d, 0x0021),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MacroSilicon",
 		.product_name = "MS210x",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 3,
@@ -4038,9 +3724,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_max = 48000,
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4058,20 +3742,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_AUDIO_DEVICE(0x534d, 0x2109),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MacroSilicon",
 		.product_name = "MS2109",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 3,
@@ -4086,9 +3768,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_max = 48000,
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4098,14 +3778,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * 8 channels playback & 8 channels capture @ 44.1/48/96kHz S24LE
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x08e4, 0x017f),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4125,8 +3803,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4146,9 +3823,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100, 48000, 96000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4158,14 +3833,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * 10 channels playback & 12 channels capture @ 48kHz S24LE
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x001b),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 10,
 					.iface = 0,
@@ -4185,8 +3858,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 12,
 					.iface = 0,
@@ -4204,9 +3876,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 48000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4218,14 +3888,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Capture on EP 0x86
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x08e4, 0x0163),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4246,8 +3914,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4267,9 +3934,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100, 48000, 96000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4280,14 +3945,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and 8 channels in @ 48 fixed (endpoint 0x82).
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0013),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // outputs
 					.iface = 0,
@@ -4305,8 +3968,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // inputs
 					.iface = 0,
@@ -4324,9 +3986,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 48000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4337,10 +3997,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 */
 	USB_DEVICE(0x1395, 0x0300),
 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			// Communication
 			{
 				.ifnum = 3,
@@ -4356,9 +4015,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4367,12 +4024,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Fiero SC-01 (firmware v1.0.0 @ 48 kHz)
 	 */
 	USB_DEVICE(0x2b53, 0x0023),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Fiero",
 		.product_name = "SC-01",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -4380,8 +4036,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4402,8 +4057,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Capture */
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4422,9 +4076,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x29
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4433,12 +4085,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Fiero SC-01 (firmware v1.0.0 @ 96 kHz)
 	 */
 	USB_DEVICE(0x2b53, 0x0024),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Fiero",
 		.product_name = "SC-01",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -4446,8 +4097,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4468,8 +4118,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Capture */
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4488,9 +4137,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x29
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4499,12 +4146,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Fiero SC-01 (firmware v1.1.0)
 	 */
 	USB_DEVICE(0x2b53, 0x0031),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Fiero",
 		.product_name = "SC-01",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -4512,8 +4158,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Playback */
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4535,8 +4180,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			/* Capture */
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4556,9 +4200,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x29
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
@@ -4567,12 +4209,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * For the standard mode, Mythware XA001AU has ID ffad:a001
 	 */
 	USB_DEVICE_VENDOR_SPEC(0xffad, 0xa001),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Mythware",
 		.product_name = "XA001AU",
 		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE,
@@ -4585,9 +4226,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END,
 		}
 	}
 },
-- 
2.43.0


--Multipart_Tue_Aug_13_17:43:33_2024-1--

