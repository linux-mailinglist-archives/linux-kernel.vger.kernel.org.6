Return-Path: <linux-kernel+bounces-303107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F26596077D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD71281BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD219DF94;
	Tue, 27 Aug 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="nK+NNnT/"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E186619;
	Tue, 27 Aug 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754677; cv=none; b=cg/h7KVBAWj/lc9NqgqMZ2XkIX/DznC+O30RbmZnHURFAeNCx9D4dAy7K9GE8LOnxvYfFFOOVAYUVs2cu2GfuK0AD21y2gUPUgiHF4r6I/QE6nUytbyZJ9INqjqqAqqGYYszAQysJHjK+Z3fc3wVLWNFge44pjIGlBEgbzqMlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754677; c=relaxed/simple;
	bh=yVOmi2XZIT+5yOT0zGbLE2bPhY/YXdPgNKaGxrWx3uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+1sKVI0ldCWP+bjdNXkgiAMB6ntdw7SaUwORYg2Cmba6pvcNDAlk2d/NL3PWuvu3PNla+KGKH3HsxO+HwGVvqIrRA5c1MjmsaLQcIV2FGSDadalS9cJ/fl/thEoA4Y3HUmrBg70irBEWMz8z0NUa+FtoW4brqFLqcaAIPbLfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=nK+NNnT/; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (p5b164fa4.dip0.t-ipconnect.de [91.22.79.164])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id D02452FC005D;
	Tue, 27 Aug 2024 12:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1724754344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CJt2JEMqegJVIz/p2NrInMq+BWwEqn0X9WqmTwWyEx8=;
	b=nK+NNnT/rSDaE2ZDyMMh27ayV9F3Hm+xCYJB8fzTQhaqFr5J1ok2C4iobs6GCfJxY5LJUd
	CyzN4Xj5yoW5nV7AEvvZA5sxxVzkXl3Q3KHzzzaqe7XpzqL4Klb1RKE6d1TBTnKYJhhAOD
	Wb2ADdtBHJhqOgjqKpOoN8xUQo/2w8A=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices
Date: Tue, 27 Aug 2024 12:25:40 +0200
Message-Id: <20240827102540.9480-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoffer Sandberg <cs@tuxedo.de>

The Sirius notebooks have two sets of speakers 0x17 (sides) and
0x1d (top center). The side speakers are active by default but
the top speakers aren't.

This patch provides a pincfg quirk to activate the top speakers.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org

---
 sound/pci/hda/patch_conexant.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f030669243f9a..e851785ff0581 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -307,6 +307,7 @@ enum {
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
+	CXT_PINCFG_TOP_SPEAKER,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -974,6 +975,13 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
+	[CXT_PINCFG_TOP_SPEAKER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1d, 0x82170111 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1070,6 +1078,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
+	SND_PCI_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
 };
 
@@ -1089,6 +1099,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
+	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
 	{}
 };
 
-- 
2.34.1


