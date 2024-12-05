Return-Path: <linux-kernel+bounces-433779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDA9E5CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A38B1884C68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10666224AE9;
	Thu,  5 Dec 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of16J4oi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887422259A;
	Thu,  5 Dec 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419197; cv=none; b=TMn6YAQHR36HFdu61u+WPUp+xihxY0L5RULVPU+dyb2TpOtqFY/LFhxINMjahg0waqjTmeD1OFjgX4hh0ni8GLILlh2yNODxV8tzptUX2EA/3S0m40jxtqhGw/cLerpTOkH+yUPZIy2CvbWdqfdjZxvwUNAeeJ4qZ1sHi0qkUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419197; c=relaxed/simple;
	bh=t/wBNcHC9SYSckp9Xl5qfb+MZAnQUAFym4KWBLEcmR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Imqt+Naop+HLl+tw4BoiCam1x1cbbrL+crRKsn8YgY2rBIeLOtITHISsM1oPyshDMR7WdK470/fo7bY61XcikahYtS8KLi4yME/eR7wAIXJdGCs6zRUR3lZ3AtHGG5uXN2hmU0MvyasY5pB516fELjRlqLgMCpGTr1LHmnzlt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of16J4oi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215ac560292so12041065ad.2;
        Thu, 05 Dec 2024 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733419195; x=1734023995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs+bdC7fmuLJY/Z7Szzgzwh7fG5FZFm9oQK+ZbxckvU=;
        b=Of16J4oiAdZ+8ofN3xebmRiSbU5aD9eGsir9sTiUmNfz9wGcq8f1lZ9K4e0V3Gvw2Y
         5vFk/oK77cGqt1RMq+rS138UGrMKOz4lJazeER0rz7e6d7KGZDlpRyUikhcfuap7LOeT
         RdraJu8RrFyMhYZVe49os+PJPDVYer6hduASQd740NGY68UBSV9iOfTdn9b0gcSe6IHj
         fh5A4/PMP+ayav5MyfwCVKNDnJYnGcmgfX4CjoDJo+mSjdO50/yAFsUAtzuK5sEnGaEI
         w2iAjnBmiHq9CWBaaOrZy7QG4JSauVqyLFJKxpSjDk9MZWB4lNaL74JG2eThio6kKprC
         BY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419195; x=1734023995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qs+bdC7fmuLJY/Z7Szzgzwh7fG5FZFm9oQK+ZbxckvU=;
        b=qg2BFzgzSfATHKtIvzKJ2I/K+bDtjOIrHaDZi5OZTyubmNdAaXYZP1jlqGgMPeMvI1
         tn7H7D9+yGjfQuL7pZDJQyXBElA7A6/JNqbN9QeTL1LUdBu0y+zTFR77o7Ld4vQ+Zkzr
         oYv0JhBY5Rve4mu88ACVRhiWFLFn7+NrigFUcaH+uprUN1d/wAOC6yWVzUi4HDd12S2x
         VdB3PsHvg1OTEV756tEfGYtE+/bl+lIhmsx5jdREo/WrtFo2r3E116s7pTJuNpbhTJLx
         TGNUejB6GSWi4b6F6/7aeuSTKVcOT5Fjs2PaW9JZ9VpTUi0bzSmZKWwh5F7ROoqYXRA1
         28XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8zLaA/CFIawVpehKQv8oNEScrpy5Gu5kndNmzNiQ/k+hTCx3IFT/43QSaZWVrReFYJIURCgzF3Nk0a9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUjvvfqquPwmptdduD4vcc/oZZ2FZ3bkpwZ9WdVIMvKw3xjJC
	Q5X8MRBAspNQ9xrDlRzVJD84jzPvXtRRneCXRra+jR4qk0skDIZ7xgvfLI0lNjQ=
X-Gm-Gg: ASbGncsR9l3HaSB+DPMMu2zUMA9kDJW7peTYxJSeVZCUX8nO6/NUTcH8KejS+LYtK9S
	ayOHeuFtdcd0oVH6evdKEYDhZckFL5hmaiE54gWDZXm81Z8eNep+HQSWnd3+qWKdTtC1l9HBMBb
	mcEA3aciQF2udLFZTGQ479GMdejL9COekOVyQjQrPG1rovjhgSDCtRqNI0Xpm5gP4eQOm1/1Zjj
	an4/zd0TKgJFhm7s2s5G2vBSnpr4NjaHIy/cOKYbATce2rPEP6DEkm1+irgKbMgUmA8CP7tQuM2
	X57f2eJb
X-Google-Smtp-Source: AGHT+IEmmmT1mNJBcxgt+hNGHjTQC+qdD5JEpbkVGF6VqQO6Obj+gNIfFuf8xv0agL865HsArRyriQ==
X-Received: by 2002:a17:903:189:b0:211:6b21:5a88 with SMTP id d9443c01a7336-215bcfbe4f4mr140871855ad.20.1733419194995;
        Thu, 05 Dec 2024 09:19:54 -0800 (PST)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0a886sm14588505ad.208.2024.12.05.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:19:54 -0800 (PST)
From: Hridesh MG <hridesh699@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
Date: Thu,  5 Dec 2024 22:48:42 +0530
Message-ID: <20241205171843.7787-1-hridesh699@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a PCI quirk to enable microphone input on the headphone jack on
the Acer Nitro 5 AN515-58 laptop.

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
Changes from v1: https://lore.kernel.org/all/20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com/
	Replaced the custom verbs and pin configs with a fixup model
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e675f09aa795..2b9b118afde9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10142,6 +10142,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP_ACER_HEADPHONE_AND_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x053c, "Dell Latitude E5430", ALC292_FIXUP_DELL_E7X),
-- 
2.47.1


