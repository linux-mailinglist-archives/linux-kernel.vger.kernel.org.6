Return-Path: <linux-kernel+bounces-312760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D868F969AE0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902E628320A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E81DA0EA;
	Tue,  3 Sep 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="Owd+i6vA"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C851C62A8;
	Tue,  3 Sep 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360787; cv=none; b=Uuu01fgr1mpXP9psT4etJaPMkaRgdmRP/M/DYcMwd4t/iwa83fGaWEOoQ0L9Rsncv4BK3NMRk26HjfVNhA7393UJwGIhY1my4ckM+jY1Pe40U0o1wOfvMgipdfnxck8v8q23kaBuT7ZHVBZwTymVTq9m89doE5zlJyQepwuWB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360787; c=relaxed/simple;
	bh=JgvJqVTf/u0LE0bfE/k5DEn8YPyIpzNmeGr9DZ3HNVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBJRJT6C+64nesvbrPmBADy8FcbzprGLCYjaVxMw1e+9KewDevLizSgb9gDmy46BS7QRjhY4sKDhtaospjTW79hixqDjGF3Ei1XyBnPVJEqtgP9OC4Og2VLw94K7q7sPdMaaKrpfMYrbYnYOr8SVHfPDT4YoMqFKUYBAqGR59kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=Owd+i6vA; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 8C44B4425F;
	Tue,  3 Sep 2024 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725360774;
	bh=JgvJqVTf/u0LE0bfE/k5DEn8YPyIpzNmeGr9DZ3HNVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Owd+i6vAmlXWlsnZLWaLZBZqaC7FGgd3qooN5pEpcaWYESRhiseBCFPYw+8M3TruZ
	 9iqgFz8N43ExNRlBHSes3A3U6sUlTZZ4F+dsvAqVJL7ErECJaH/EGKESFwA/eVdgOA
	 VfIxfzuoLbC4wUW51FW8PMpLNhYyX1q/4PX7S7tP5sejdscUeMAVo5obr+/76eG1Yh
	 PkpPMbRhDzSdrHmEnf6P0TCE4Y7xf2cbzdYjAUK4SJhwcJd4Impk9j1gJuMeS5sMYS
	 CAJxbUm7AdXzaK9XXRp0ObKklt7bSgi5VDO0NaXUInVSVL6D08BOz7i43wY8sVIIWh
	 MAW9WS3r8iMyw==
From: Asahi Lina <lina@asahilina.net>
Date: Tue, 03 Sep 2024 19:52:30 +0900
Subject: [PATCH v2 2/2] ALSA: usb-audio: Add mixer quirk for RME Digiface
 USB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rme-digiface-v2-2-71b06c912e97@asahilina.net>
References: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
In-Reply-To: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Geoffrey D. Bennett" <g@b4.vu>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Hills <mark@xwax.org>, 
 Arun Raghavan <arun@arunraghavan.net>, Cyan Nyan <cyan.vtb@gmail.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725360771; l=15325;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=JgvJqVTf/u0LE0bfE/k5DEn8YPyIpzNmeGr9DZ3HNVA=;
 b=pB+8J1+dsvbcIo7/TCZHwn8ZAwlpQrGSiFIaMBJ6No+gcCI1cQixUUiFP0xvt6TugnHuvTYqM
 EO7TQwBM52LCZ+21uCJShRulmDvBSt932h4vsianIP9NsjIVKZ/VDn8
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

Implement sync, output format, and input status mixer controls, to allow
the interface to be used as a straight ADAT/SPDIF (+ Headphones) I/O
interface.

This does not implement the matrix mixer, output gain controls, or input
level meter feedback. The full mixer interface is only really usable
using a dedicated userspace control app (there are too many mixer nodes
for alsamixer to be usable), so for now we leave it up to userspace to
directly control these features using raw USB control messages. This is
similar to how it's done with some FireWire interfaces (ffado-mixer).

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 sound/usb/mixer_quirks.c | 413 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |   1 +
 2 files changed, 414 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 5d6792f51f4c..2a9594f34dac 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -14,6 +14,7 @@
  *	    Przemek Rudy (prudy1@o2.pl)
  */
 
+#include <linux/bitfield.h>
 #include <linux/hid.h>
 #include <linux/init.h>
 #include <linux/math64.h>
@@ -3087,6 +3088,415 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/*
+ * RME Digiface USB
+ */
+
+#define RME_DIGIFACE_READ_STATUS 17
+#define RME_DIGIFACE_STATUS_REG0L 0
+#define RME_DIGIFACE_STATUS_REG0H 1
+#define RME_DIGIFACE_STATUS_REG1L 2
+#define RME_DIGIFACE_STATUS_REG1H 3
+#define RME_DIGIFACE_STATUS_REG2L 4
+#define RME_DIGIFACE_STATUS_REG2H 5
+#define RME_DIGIFACE_STATUS_REG3L 6
+#define RME_DIGIFACE_STATUS_REG3H 7
+
+#define RME_DIGIFACE_CTL_REG1 16
+#define RME_DIGIFACE_CTL_REG2 18
+
+/* Reg is overloaded, 0-7 for status halfwords or 16 or 18 for control registers */
+#define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
+#define RME_DIGIFACE_INVERT BIT(31)
+
+/* Nonconst helpers */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
+static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			      item,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      val, mask, NULL, 0);
+	if (err < 0)
+		dev_err(&dev->dev,
+			"unable to issue control set request %d (ret = %d)",
+			item, err);
+	return err;
+}
+
+static int snd_rme_digiface_read_status(struct snd_kcontrol *kcontrol, u32 status[4])
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	__le32 buf[4];
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      RME_DIGIFACE_READ_STATUS,
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      buf, sizeof(buf));
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"unable to issue status read request (ret = %d)",
+			err);
+	} else {
+		for (int i = 0; i < ARRAY_SIZE(buf); i++)
+			status[i] = le32_to_cpu(buf[i]);
+	}
+	return err;
+}
+
+static int snd_rme_digiface_get_status_val(struct snd_kcontrol *kcontrol)
+{
+	int err;
+	u32 status[4];
+	bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
+	u8 reg = (kcontrol->private_value >> 16) & 0xff;
+	u16 mask = kcontrol->private_value & 0xffff;
+	u16 val;
+
+	err = snd_rme_digiface_read_status(kcontrol, status);
+	if (err < 0)
+		return err;
+
+	switch (reg) {
+	/* Status register halfwords */
+	case RME_DIGIFACE_STATUS_REG0L ... RME_DIGIFACE_STATUS_REG3H:
+		break;
+	case RME_DIGIFACE_CTL_REG1: /* Control register 1, present in halfword 3L */
+		reg = RME_DIGIFACE_STATUS_REG3L;
+		break;
+	case RME_DIGIFACE_CTL_REG2: /* Control register 2, present in halfword 3H */
+		reg = RME_DIGIFACE_STATUS_REG3H;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg & 1)
+		val = status[reg >> 1] >> 16;
+	else
+		val = status[reg >> 1] & 0xffff;
+
+	if (invert)
+		val ^= mask;
+
+	return field_get(mask, val);
+}
+
+static int snd_rme_digiface_rate_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int freq = snd_rme_digiface_get_status_val(kcontrol);
+
+	if (freq < 0)
+		return freq;
+	if (freq >= ARRAY_SIZE(snd_rme_rate_table))
+		return -EIO;
+
+	ucontrol->value.integer.value[0] = snd_rme_rate_table[freq];
+	return 0;
+}
+
+static int snd_rme_digiface_enum_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int val = snd_rme_digiface_get_status_val(kcontrol);
+
+	if (val < 0)
+		return val;
+
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int snd_rme_digiface_enum_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
+	u8 reg = (kcontrol->private_value >> 16) & 0xff;
+	u16 mask = kcontrol->private_value & 0xffff;
+	u16 val = field_prep(mask, ucontrol->value.enumerated.item[0]);
+
+	if (invert)
+		val ^= mask;
+
+	return snd_rme_digiface_write_reg(kcontrol, reg, mask, val);
+}
+
+static int snd_rme_digiface_current_sync_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int ret = snd_rme_digiface_enum_get(kcontrol, ucontrol);
+
+	/* 7 means internal for current sync */
+	if (ucontrol->value.enumerated.item[0] == 7)
+		ucontrol->value.enumerated.item[0] = 0;
+
+	return ret;
+}
+
+static int snd_rme_digiface_sync_state_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status[4];
+	int err;
+	bool valid, sync;
+
+	err = snd_rme_digiface_read_status(kcontrol, status);
+	if (err < 0)
+		return err;
+
+	valid = status[0] & BIT(kcontrol->private_value);
+	sync = status[0] & BIT(5 + kcontrol->private_value);
+
+	if (!valid)
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_NOLOCK;
+	else if (!sync)
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_LOCK;
+	else
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_SYNC;
+	return 0;
+}
+
+
+static int snd_rme_digiface_format_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const format[] = {
+		"ADAT", "S/PDIF"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(format), format);
+}
+
+
+static int snd_rme_digiface_sync_source_info(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_sources[] = {
+		"Internal", "Input 1", "Input 2", "Input 3", "Input 4"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_sources), sync_sources);
+}
+
+static int snd_rme_digiface_rate_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 200000;
+	uinfo->value.integer.step = 0;
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_rme_digiface_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 0,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0H, BIT(0)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(3, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, BIT(13)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(7, 4)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 2,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, BIT(14)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(11, 8)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 3,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, GENMASK(15, 12)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(3, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 1 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 2 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(1)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 3 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(3)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 4 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(4)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_sync_source_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG1, GENMASK(2, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_sync_source_info,
+		.get = snd_rme_digiface_current_sync_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, GENMASK(12, 10)),
+	},
+	{
+		/*
+		 * This is writeable, but it is only set by the PCM rate.
+		 * Mixer apps currently need to drive the mixer using raw USB requests,
+		 * so they can also change this that way to configure the rate for
+		 * stand-alone operation when the PCM is closed.
+		 */
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "System Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG1, GENMASK(6, 3)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1H, GENMASK(7, 4)),
+	}
+};
+
+static int snd_rme_digiface_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_rme_digiface_controls); ++i) {
+		err = add_single_ctl_with_resume(mixer, 0,
+						 NULL,
+						 &snd_rme_digiface_controls[i],
+						 NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Pioneer DJ DJM Mixers
  *
@@ -3645,6 +4055,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x2a39, 0x3fb0): /* RME Babyface Pro FS */
 		err = snd_bbfpro_controls_create(mixer);
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		err = snd_rme_digiface_controls_create(mixer);
+		break;
 	case USB_ID(0x2b73, 0x0017): /* Pioneer DJ DJM-250MK2 */
 		err = snd_djm_controls_create(mixer, SND_DJM_250MK2_IDX);
 		break;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 631b9ab80f6c..24c981c9b240 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3620,6 +3620,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			 * Three modes depending on sample rate band,
 			 * with different channel counts for in/out
 			 */
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
 				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,

-- 
2.46.0


