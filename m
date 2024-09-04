Return-Path: <linux-kernel+bounces-315909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2696C8B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60DA2896A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F2148848;
	Wed,  4 Sep 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PErKCY51"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80241146A79;
	Wed,  4 Sep 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482404; cv=none; b=Baf5cinlgkQZIfPZDivcKFr/bVSbceTf+4L+WGqZtU/QUe46VE0YrDqNHx+Sx7NXcx8Dc76VPv2gYOFQOhqI/hlocpM9X3plV7JdsWrEpfMig8CIjdOY+lhohfnLuiX1pLf6ObJFU8xSHUPrA5+KKYLRg/PdYJ981Q76dIiSfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482404; c=relaxed/simple;
	bh=zqe6+b/FTfJHgkE9MkhgaaAsT5L43NyeI82wDMeUKAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjK6xX6ASAOq4zAeoNL2+YuyyZ77N3OAxMZUolunUTwvcUdJZF8jWkwuWjMdGZqauytyfzouPnlnkYdSVTjR2WELUjNJ1U+g86sD4wm+3pa6vYcllmroC7aBcycpYsILlWqfk23n3gj/0UQlpQ36l9qRI/wdLeVGNamvhJ1f468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PErKCY51; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so50914205e9.3;
        Wed, 04 Sep 2024 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725482401; x=1726087201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMC9PyIWnX47bjnEnEHO5NXAPXt5crdtOv8guFK+s5k=;
        b=PErKCY514ngUKSSN0GrT3UTuExk8foQw/F6qqyRs5YyDvtf+nx2HYO1HbRZo1GD0xd
         67p/5LdLsr3AbQb9XZ+rqGTzGooENi2BfSCDHHJLieRnD0H52aD3tw4gmqy5VivRUiaQ
         +N7i3i81coA61STH7KnOAWGuvwxyE2+Hnz739HO1EyrcsbJ9QyCDYVEqezdM8PQLbyO9
         9YXEAetoBy6JJvaNtvIE+nHetBxA7h5NngBcdUQkREQWK7AWCKR+j7ovi/kWy+auGss+
         I5/AJ/wKLgIJ6tiu1o4qX4R0lOYjTAfpSezZtpfaI2znvsUVSO4VFUSmJe9xRbDRwEDQ
         3bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482401; x=1726087201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMC9PyIWnX47bjnEnEHO5NXAPXt5crdtOv8guFK+s5k=;
        b=eOs+FDvqiKkNiWFiXeQJCHDaSkEoleSVuSsoWJ7RPi3Nqj1zLk5GPgEZf64BFcZEiX
         1+qIfUPDKLFjMDKQk2Az47B5bQLgZiIIRTP/pqMo6fVdMec5SqwAZT0ugpTNwRxe50Ig
         0jlXna20cJTe9iCcUR8+mXynXa1dJZsfpojYPO7JHV9hukQZPPlpPHrw+Knadfn7XA7o
         Sl8bfsXpNTyr5Gz1hSU06FhUmi/xUiJee+0Y6DV92DWavMQKqDdTO/GAU/1yFWGpBsoI
         +HHaM4rCfeMnVJtoU27+cxHOoTorVtb1Yc7SPZaMoXHABaYm/NXO7pQ8qC9gBm4iYCTr
         4s5w==
X-Forwarded-Encrypted: i=1; AJvYcCVg4k8nuV+jVAG85ANnBf7iNszwAlaaKqeODlwzh8KRRt+vE+aL9KwfWLPsi/XrKVO89aCBARNSFf/d6bY=@vger.kernel.org, AJvYcCWLHctdPDJh0mjjHJmFwbw44peqTqcN1+hnA+sVf1IDse8+7+fjsfkk3V0Q4+V9VSSgojTqi/Jd31dbi24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHq7RErUVa7SiVArX5GNriHofsKfFUJI+5+C0HgoNwyoT4vJ0E
	locKmcAX8XJ3AVP0RVIZuWttTXr32CpNJlX29MaQ3aYQeSzFB+xg
X-Google-Smtp-Source: AGHT+IEGXVfuDlPCdE0TrKvq2ls5isaLcHyGYBvzekLbPYPrZI+rDOevIiOOPR/3gKoYxFzozgP+TA==
X-Received: by 2002:a7b:cb11:0:b0:429:c674:d9de with SMTP id 5b1f17b1804b1-42c9a36029fmr2136315e9.2.1725482400217;
        Wed, 04 Sep 2024 13:40:00 -0700 (PDT)
Received: from localhost ([185.220.101.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c7a41bdc8sm158287955e9.3.2024.09.04.13.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:39:59 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Peter Wu <peter@lekensteyn.nl>,
	Lukas Wunner <lukas@wunner.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] ALSA: hda: intel: Fix Optimus when GPU has no sound
Date: Wed,  4 Sep 2024 23:39:55 +0300
Message-ID: <20240904203955.245085-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
the discrete GPU. snd_hda_intel probes the device and schedules
azx_probe_continue(), which fails at azx_first_init(). The driver ends
up probed, but calls azx_free() and stops the chip. However, from the
runtime PM point of view, the device remains active, because the PCI
subsystem makes it active on probe, and it's still bound. It prevents
vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
power management for the video and audio devices).

Fix it by forcing the device to the suspended state in azx_free().

Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 sound/pci/hda/hda_intel.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b79020adce63..65fcb92e11c7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
-		if (hda->vga_switcheroo_registered)
+		if (hda->vga_switcheroo_registered) {
 			vga_switcheroo_unregister_client(chip->pci);
+
+			/* Some GPUs don't have sound, and azx_first_init fails,
+			 * leaving the device probed but non-functional. As long
+			 * as it's probed, the PCI subsystem keeps its runtime
+			 * PM status as active. Force it to suspended (as we
+			 * actually stop the chip) to allow GPU to suspend via
+			 * vga_switcheroo.
+			 */
+			pm_runtime_disable(&pci->dev);
+			pm_runtime_set_suspended(&pci->dev);
+			pm_runtime_enable(&pci->dev);
+		}
 	}
 
 	if (bus->chip_init) {
-- 
2.46.0


