Return-Path: <linux-kernel+bounces-432951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC29E5242
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE6A1882462
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D351D79BB;
	Thu,  5 Dec 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTiUcC1Y"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2891D5CCC;
	Thu,  5 Dec 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394517; cv=none; b=fSuUokKDQeVXEmX14DvE/bWTRrAU3q1E2pNCSH4VcevDDMKGmqCk73yID2OLdnakcrO/H36qD2xFCoYUZXEhjxOmiZgjPNeKYEZh3WCQrFWVKiVvyeDEeuMOFKPHRVJLN3KU9EUMssn9k7MSUH3RMTqzkPJqXKz8/7JEoBdi6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394517; c=relaxed/simple;
	bh=OQeiJ+NE9OwpTFtGSQ4jKHeHGdZbhTpl87XQ0ZGeGUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RbbfHZrdNwn/mpZbjLQR4TrUa/byU0pBwvmZGhDRvBXLMbdDiwmc1we+Y91dlR8koyr95WU2cuFVb9fssoBuHjxjWmmWxbTmQs3SW5/xoYQ5417BMZ/0ayHGAo3WaUVwj7O17Mj7tpEPWjJN1NjjhJ/Q2io+hQys4Ng9e6QCoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTiUcC1Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349fb56260so4767425e9.3;
        Thu, 05 Dec 2024 02:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733394514; x=1733999314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdOKJy0aTwi4bBTPR9itNWI3r8b6MmxdtvpvxZTZOg0=;
        b=WTiUcC1YRqRvdJ+TrnWIjAz9HZmvI86p1XXLqZjq2bLdw4cTIbB5WOSPvoXV8egCKW
         J0us4o6KAcRUJbW9OveqMyG2K4M9FxN3oBjudFp4D5qs4xrgKDcaEpYbdlDX0zAN3LtF
         3K6g/zFM0bb0NTkhF0t+fOxmdPkNNsID1SXKKRgcgpr0DQrX4vMYmHo/VmWPoO9w76W7
         WNPHG2/c49JH5cX0uVs63n8ad4VVom0udpvSCOsMrQCTt3mjl6FXq+aFouYV0erjPjQq
         rkGnj8KmvzutJLWAwvuNubaY9gSEKSN9Zly/HIa87VQ/Aon4dqlNA/DJtUrVPoo6tRhZ
         /N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394514; x=1733999314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdOKJy0aTwi4bBTPR9itNWI3r8b6MmxdtvpvxZTZOg0=;
        b=AtXjhOtuWVlrLG6s9HUoC7NioRHRqFDJpZtdFBO4TZlPoz8S2VlSQ1VgnT1yVL/iGM
         tve64AfsMa5OGM5lwcyk6UjNe4s6VDuWvrPt2DAzdZDlsO49E4n0KfbjK8o0oeNwkFam
         AxSlL69AcYAWFT0JIv2JboL6f9chFKfUKrtsuQqj0npOuj+Kt0I1TqAYwe1gyXYb1WmE
         KloSXyhE/0LiaAg4XEyM9aqWfy1d01SRhgtWM88p+3MvHOMjvIcJAXSX5HgyU4l7fL85
         /G0KKL06QN4ZYYtZBGIEBf2lk5o6/SF6o2IgOf2YFijvDHxWQz6VgsMWgXWFP9Vi82Zl
         unng==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8n780vn9Y3zT2HeKFT/4AsI+71rdQTMh45unHRSN1MEPLxDCEx9YJg4CH3lBpbvsbT8aSZZ5KOeO5Dw=@vger.kernel.org, AJvYcCXYVI3Lnw3Hl7KOCYT+4RIW+VGVGYWXiKHrFvARe4rNVWGonNUNEf3sfRdCR7vPYsRbLsepeOyIAepbI7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QtRbPyDHP17ml+nw7+5L0VsRvJqi2Ceg3cF3L1vmGfKWkwje
	oPJ7c7JhBhtateb45ydxaS2cG9X113hnaVHfJMpFQ0WQo1tTGcu/
X-Gm-Gg: ASbGnctDFkWYv2Bsc1C7JKLQkAxLZjoHL/o79kiPO/08XT0bonAYOhLdB6UtbD/LSAf
	zl/TmgEV0GoMq8zMTDvCNCEFfxhTEJjD2BjveoXTK+fVFb2qa2IlNigBm5M+DiZkj2sZ0Ld0iL2
	hAmPw8wp0DxRbSPefHznqblOhrcuJQxCH4nqT7i94HARCGRmlVxmmgM068DwmD/31ApoD1DGiaY
	JGQpfyUFQOm+Tf6QgayugNOe85ifkKHowipaVAOmtX7ZrsVDiM=
X-Google-Smtp-Source: AGHT+IF88i/cdTFhU0Lhv+NRvnU86WK2W1nOMi5pE6FZDNViUiJqkQ5sP2KjxOfupteC9U1bQqunNQ==
X-Received: by 2002:a05:6000:1885:b0:385:f1f2:13ae with SMTP id ffacd0b85a97d-385fd437640mr7658681f8f.41.1733394514006;
        Thu, 05 Dec 2024 02:28:34 -0800 (PST)
Received: from localhost ([194.120.133.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861d0f75b4sm1629523f8f.0.2024.12.05.02.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:28:33 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"
Date: Thu,  5 Dec 2024 10:28:33 +0000
Message-Id: <20241205102833.476190-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string in the alc269_fixup_tbl
quirk table. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e675f09aa795..17392b21d5bf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10527,7 +10527,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firelfy 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
-- 
2.39.5


