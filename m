Return-Path: <linux-kernel+bounces-321768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A38971F34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A311C234AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A114B96D;
	Mon,  9 Sep 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYS+RqKx"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC582C87A;
	Mon,  9 Sep 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899307; cv=none; b=e4Lw5XKzxS+UMcADeQtVS6fEwEUQLAgfNfGTdWdBX7p1Wk2gQZTSaCqd2A/Jbl0fZtnVpPM0qwX4v3osA4+bICWPoqvorWGp/mKiA1Q5+b+QNZSF4fu+ZMk9zyxxFjQkvzTlGCsvNrn4pLDMOEf/AcPMcD0v52Q76/eQfDis7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899307; c=relaxed/simple;
	bh=AT3uhYXs4WQk5nUGzcghStqSzCBcYc5YHN4gjc6Dq3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2kkwZ9ffzqHTxMuekYmzBoZTfuvuMz2i4dPssPO3fYjVBncrhKMMs2LFLE0hhHUUzpLQv05xusUNVjlzcjQMh4llPGx5VhU+O1WGPK5PvqOOEApYAOJKvDDEs3W6v8ptD2tHS3J4B+367YL74JBFw1S5cs/n038Suy/0elTSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYS+RqKx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so3556925a91.1;
        Mon, 09 Sep 2024 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725899305; x=1726504105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AO2g12o97GrYb+jXYO5BZ62vGbQeOV8uZETbJlcrW78=;
        b=jYS+RqKxVevddQ8uGpT9ylm5ZX/izqXWcBkuvghXq49wMyVg+kd8bSWzZJtVkcIpdo
         1fEeErZItfE3cqlDXA/4xgfW1VLPWMbGbdkNdiyYXiPMaSPc1HjkW7JAIiKJFt4WBAqs
         nV+f8JvJrdvciCbtJWs98Pgc0yPgVqXwEA87vnTazTrfHp1naD6NB5NlIGYeHQIXVZO+
         b7HTNM4x6CbrLIzgCNX8GgPGKHHICcxoDoNeZ6KEY6iUu7WaM2Ml7xIxgejIBEpfovj5
         LztEoGm+HASE+Uw4HDG8TAqZ+xig2/bAs0VmbN2lqbxSBBDfTw6h+yJnUmKtjZZl/9cu
         jfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899305; x=1726504105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AO2g12o97GrYb+jXYO5BZ62vGbQeOV8uZETbJlcrW78=;
        b=nYr4uOwBex/F5dOzJihaaIkp8NjoQJR+RQq5g62Jqntmos6Zh15iguILKWqYhUotjH
         xeC789O86jCrcSiGO4dkwcctQnGUNVt2G6lanz2SojkWF09eGKpRAXZULld6g/vS3+NN
         3JoRshsX6dPIURRYpFcCNDmqblzc9Pzv4Pt3M1NWSjJw/HBLvWIxLamvCGHvOPVj5PTt
         XeT/3mGe57FCkamsp6PrHxIQ8R+mZJ+85nEW1nt7M62SkSiFhPtrRWoPUxe8sRo9ej0F
         SrtDOyBde9QvPcdl8rvF5EETfOYMwNCpfoWS1Pj9UMY/8MYqbkPRjo0MwJQ7o3Z8Jyk4
         B/uA==
X-Forwarded-Encrypted: i=1; AJvYcCVB06/5y5hB9phdYSnrLOH6vsv657V6579cJh9xunPblQN/35OsgkwqgPRrBtd0fJqTUpWJY5OveB6DlaM=@vger.kernel.org, AJvYcCVJh7kWXmubMJYAwaJIQTIlNG7rnsUEWYqx6+OXT0YcX7IppNr4AGtJ+HPMOk1NN+FxyDoivofDXn0f3P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hcwc/0xh0g1a5zuDnpAjyQnT7/V6J5bSGpS2PoF8yTypXAA2
	l6iuAztLsujugJNOe+/26ieQtA+GpTAOJbRZHIGxifb4cTwE/IJNRvpRpQSF
X-Google-Smtp-Source: AGHT+IFxNVuk2fduecKMw2WpwK9T5MHZCQJjHo+MrHekAxaaaCiRiRg/e/Q09PKzkErJUPOHHMP5Vw==
X-Received: by 2002:a17:90a:d143:b0:2d8:905e:d25b with SMTP id 98e67ed59e1d1-2dad4ef223emr13696799a91.9.1725899304980;
        Mon, 09 Sep 2024 09:28:24 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm6867579a91.34.2024.09.09.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:28:24 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Enable mic on Vaio VJFH52
Date: Mon,  9 Sep 2024 13:27:51 -0300
Message-Id: <20240909162751.4790-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vaio VJFH52 is equipped with ACL256, and needs a
fix to make the internal mic and headphone mic to work.
Also must to limits the internal microphone boost.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 452c6e7c20e2..6c7e7330da3a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7639,6 +7639,7 @@ enum {
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
 	ALCXXX_FIXUP_CS35LXX,
 	ALC245_FIXUP_CLEVO_NOISY_MIC,
+	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9984,6 +9985,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	},
+	[ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a1113c }, /* use as headset mic, without its own jack detect */
+			{ 0x1b, 0x20a11040 }, /* dock mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10633,6 +10644,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x961d, "Clevo N960S[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL5[03]RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa554, "VAIO VJFH52", ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.39.2


