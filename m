Return-Path: <linux-kernel+bounces-426489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18F9DF3D1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40618281363
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E81A9B4B;
	Sat, 30 Nov 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv20cWyP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE178289;
	Sat, 30 Nov 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733008732; cv=none; b=Va3hHRnPcjAqgPUtG7+UDpZYdSK3ImKiRsMGRxF/Je/01iHfv1HLAYO5/yFk5dbvAMa6bubDEWxSyZPy5bLw5e5oooKwfAxJ9bsnmyZZVpLN+BNGsHY/5dr+ghEBRUPr4+tPfGq5SCeAGFN/v2DWOSwSRGIZ+sKHwDR8UzdFu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733008732; c=relaxed/simple;
	bh=AgqAfEqDDZ2lfMjNy/FRXMR9A6CJfeLI8ffzBZ3QYoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSUfYO+JUryP8mC95tQ1QbMsQHDp1w15EAgwDzaKICUXHMLxhdSwfSnfm0RIYsTFIf5YV+8GSeffuSIGHid5AqIyImbt5YKuW0b8pqzpFuZtHO+M+H63EYQgfPYry/XN8Y5nRYBF9Vn6knWDcCrJZsXhQuZ9Dz4+NieYHAeenmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv20cWyP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso4831967a12.1;
        Sat, 30 Nov 2024 15:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733008729; x=1733613529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv+HBFgQgXFvHEyt7eHr/uJFoatAinyVnxkm0RiL6mc=;
        b=Zv20cWyPyDVeznQfEr6YnDjza8wE3+e7jSBjS5fgitTNGaEK4BYQlyVmLisUu6+2N/
         80AlJYHTbKtz0J++Lr6fAS8csHMtyqTrnykLyLyLpOas0sbWMsTLClyCXa50pM/emtr9
         6LODqkzO5P0YSwhwK/ry6aqTHCt28aSfT2lohPhcwnNPHdXI6t9kIv16M+TC3BXASpsB
         6ZfLpYYGeeI4jfRV0RnAcRGEDvowmCzGzk3MSL/YxMnX3i2h1Hgph1/Am4cjsHVn2FSj
         cEvtF0EykL39Jm8AlcSFlJlN8mhPa05t287GBDhUsb29ROAOcSXOapMgH4K1p6EU9C0w
         ZpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733008729; x=1733613529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sv+HBFgQgXFvHEyt7eHr/uJFoatAinyVnxkm0RiL6mc=;
        b=YtDszUHmR6KuihSxI5dEJmV4rF/Aa23KKKyuqAEUavvGwRGm77kewvME/yubEibRlk
         jGGWomX/jFuyCF8iZlOv/gHcPYfdCc+f8Rd1pq09fSgiiCfRU9oBP1Pwo4Khc/XKtbY1
         JKxlb3UwEfw5KIMXsnjAcZPeyF0kJem5JI4lAfOU7FmQBmp9cnhHRC9h5BpnnMZ8UFAE
         JA30/QetqI+e22BSJDp4/OTM2Eny/lWpm28UiIDaEtfrXMdZaMjkThHvGSGoS7DVqyff
         2aDEuo7mP+HwdUC4WeN7HRcdfgi7djrhcFyWhWiwrxst+DIQdi+8QtVaaFwpuWUPIuVd
         iqlA==
X-Forwarded-Encrypted: i=1; AJvYcCUe2OgLQ3aB91EVYPH8DwG3H72B3fr5Xf0nZC7LjGmNtboKgqnGaSGq1KRewTsCAlMesHsp/ZIc8tQKTro=@vger.kernel.org, AJvYcCVbrXSaAteCVOgqEMP79J4cUOAa92OUmjJoYG8qNTrr7w/zvmpgfgBuoVXSr7VFhMtny+NCgZMN/Xq0Vrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfnaNSkohzv0GFZ/ys6Y0QyrhSA3OrC3bKR41Fmgdiqd7WXlc
	i+I5yprO+qamrjfXehk8/Kfze6sDLt4OhBHKU1KYvaZEmNIjjPym6cQVUnC6
X-Gm-Gg: ASbGncsA2GmIN/2brXevQao3R3itEyLoTbgN21rOx37rVcs7FR+OkVHbH3Mww1eG7CR
	+nRTLPkiaalqaIvsjI/bnU5ns/KDOHtC+fxoY/a2djEFNP0oYeMcjlhnIej0EROPj4sLM7CVSdb
	loKXiGx5fqwHe5gsh+Eh/49PSNwnqswIRcNaxmLY+/2tvWnUJ7nSb+09fu1AQXhehNw65Kp94ET
	u6N6V2Cl02GFIx5KqA3e74Y2dS3xkDiKHGwprUhGYPRufFvww==
X-Google-Smtp-Source: AGHT+IFTD2JxJZLrerjvUW2+MlxwpGFrWWXINGOgY4bboPpx+pXYM++hVXUwXgvEMPf/dxpjxmUYzg==
X-Received: by 2002:a17:906:18a2:b0:aa5:1ccb:79b1 with SMTP id a640c23a62f3a-aa58103dd25mr1828612566b.38.1733008728705;
        Sat, 30 Nov 2024 15:18:48 -0800 (PST)
Received: from probook.lan ([109.207.120.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953d53sm329449766b.181.2024.11.30.15.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 15:18:48 -0800 (PST)
From: Nazar Bilinskyi <nbilinskyi@gmail.com>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nazar Bilinskyi <nbilinskyi@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8
Date: Sun,  1 Dec 2024 01:16:31 +0200
Message-ID: <20241130231631.8929-1-nbilinskyi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HP ProBook 430 G8 has a mute and micmute LEDs that can be made to work
using quirk ALC236_FIXUP_HP_GPIO_LED. Enable already existing quirk.

Signed-off-by: Nazar Bilinskyi <nbilinskyi@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2bf5c512e..877c5d20a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10340,6 +10340,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.47.1


