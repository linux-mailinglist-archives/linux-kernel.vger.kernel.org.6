Return-Path: <linux-kernel+bounces-242607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52C928A65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91DB2817CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC101684A3;
	Fri,  5 Jul 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgYM1ut1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7414D28C;
	Fri,  5 Jul 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188646; cv=none; b=XAhJLkEclg9Ac1F82x9HB75F3InocRKLroRvyNxcJ6pPfzZkKUW2WIW9i56I2Y5QjYuvcodZK/ptG0LoWNW5JsAuLfSRPpS0TdaxddVatHx/Olj66jANpaCDWws2HruYu5vG/JlfWjTbpWc8EBtDC32/Gu92lgfs9t4ZKTnTEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188646; c=relaxed/simple;
	bh=zhOC8EgulT623GW8OHmAHlavnJ8n5NEkG+iPKDoE594=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g61MYUGjqUPhTKstwE/rzHXjb+FJqGv8ejbK+I/JLJX09JG51VyVTcd7EGpUPP9EbIX+AKbn6M3MaaEv3LtwZ0qtQpyrSM2UzkTOzFAf3sstVd9r7qqPEog7FPg4BqoSG+9bOd5HppQIuS/5126G0le2dwr3tI1yU2IU2zcwtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgYM1ut1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fab03d2f23so11572665ad.0;
        Fri, 05 Jul 2024 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720188645; x=1720793445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NKT8pIUChblG2z50TWBzNNQKMtBzVs4m5rYofm6wv8=;
        b=UgYM1ut1ST0v/LXoiHn6oOpXCsHkPxyr+ofGMkojhLbPFrm6hq+5+yXCMQv4Dg4gF8
         s2hDG93v4eYLKpH4Plyb9ZrPus3cAFxVeNR+T9YJUE1DDolXNEgzFuxB8qx2sivuxuJN
         gT4MnpHszhQGjyToQ2U3PpfVGMq75VVhbLShtrYUxBQttmusNyekMdz520WPW1yCyQE2
         ff99HRsbL4bf8TGQd2+d76qRyHy6cPN7OmfiQXgr7Z00DSB3rnwZVQZLAWNvzG/39/xj
         XVRxi5McB6RTDyhyz882An3uSMVbglgQFn3DrSVk1tqQFRrrzxi37NUYYWbmMX+MMSdj
         6gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188645; x=1720793445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NKT8pIUChblG2z50TWBzNNQKMtBzVs4m5rYofm6wv8=;
        b=S8n1pfCPicWDN/+8guOIGcC6xUSTk5YeZ+isYREosMQ8hqHjBT61DIQIwniuSR0tvw
         i79yAlqLldC4CRuo8gNfuhgmWMmtFxwi7fFVV5EKAj6IaYuHxAIrzNDTlHbf4qhuHj11
         v4gousQ3m26eZRx1alFtLSy8kaRZLeybO4LHtA1TRs6ZW+dBTIvqea8CahzmsPWDhh1c
         1BCiShFjJiW8hpYwMV7vEwekhSLm5rGd/36kUNtEvN360HiKjgsG7GMEu3KOAN4KCAsb
         aFqDbF5+2d/wRN6mhMH1hBtWpoOqU4iDU5PwcDtyirK99a+G2EyMlAn0DhAZDt5JB8LA
         gxJg==
X-Forwarded-Encrypted: i=1; AJvYcCVuSuWHGl2arI9z4ISbgUShJFocH3p3Ou6kDeCwikBIRHEwrGt1+x6jPh6/yacaBZucgW2G6z2ZoW/Xex9u/ouTQOyK5p25nv3bfxZsO+ifdiHWjh/lPnnScUOu4Q1tjcyu/YlqZAu4GUU=
X-Gm-Message-State: AOJu0Yy/82o9HpKugrS10zIVhrl59B0RBckgi/qLBZmKNLFmn5p99xeM
	wfCT6NpmjreOoJwWBE4TdUeEb2iessYzftmwmo//ZdtU+z9uvs/5
X-Google-Smtp-Source: AGHT+IGT7yUpAbC699qnMeL/R8v2MCRjyPXMS0+2rpgmZzAs1QhCVFoE3Gq+CJSNiziOvw3cTmTTFA==
X-Received: by 2002:a17:90a:e60a:b0:2c9:6f5e:f5c1 with SMTP id 98e67ed59e1d1-2c99c5838a8mr3376423a91.10.1720188644772;
        Fri, 05 Jul 2024 07:10:44 -0700 (PDT)
Received: from localhost.localdomain ([187.85.146.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9535f3sm3415086a91.17.2024.07.05.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:10:44 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Limit mic boost on VAIO PRO PX
Date: Fri,  5 Jul 2024 11:10:12 -0300
Message-Id: <20240705141012.5368-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal mic boost on the VAIO models VJFE-CL and VJFE-IL is too high.
Fix this by applying the ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine
to limit the gain.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 811e82474200..ca42a662f16e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10383,6 +10383,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
@@ -10655,6 +10656,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
-- 
2.39.2


