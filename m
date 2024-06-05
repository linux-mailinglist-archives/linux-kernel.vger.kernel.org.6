Return-Path: <linux-kernel+bounces-202849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB708FD1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EDB1F275A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD434778E;
	Wed,  5 Jun 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXN3XcWF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA419D891;
	Wed,  5 Jun 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601993; cv=none; b=oriWWinPVqszG4b8goBY7NDhFs4cv4OsQ6oPiaty3GZo9HMrYQdtCDtfO1yh0dQdXweC6ByEcopi0MASeEntCDAGBhti0HjYVFZiztvi0Q9YsbtIRLNyrzZNxMaSgt9xaQO9t6oxU1D+0Hv9FvWQWkGvwbno25H2iUvgLRHUYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601993; c=relaxed/simple;
	bh=ECDnOyiQLAmYm+6NIVtabmHRHILiUX7B5uhb+fjyY7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKJdTwp8L0ZqcZlNBuMLOOMcq2TxJEPzPeOqOtxCSmQ3rT+Fz8H1LsU9uw9woDR4x2lyJ13dR139oY1Jqia4UO/pK4B97ptu459QPB8bwHbYWvTrvs5MTjMkJOAKe55wduZuy/otRBtoUlKuvWUlXhgLfcXgr0Wd8OOdgYrmfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXN3XcWF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso4156121b3a.3;
        Wed, 05 Jun 2024 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717601991; x=1718206791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2xNS1QpSz+39wQah+1VAzcgSUdGcXWkgWovx8I8wiU=;
        b=PXN3XcWFkYejSGCbd9TFCB9wxwTwuMOUqkL40bPMqBQxZLeCzPxo6mtyFAM9MPG8kQ
         atRrZHj+s/K6aauFxl/VG2ejENOhSkeEnDWqsIFunlyjXkR0U/xnFHsK772q0Gjnu4h5
         ZeFHhu4M6clasJjDb6LFRB2ij7SrMchyFTctib9iBcz7fU/S4JIaNRLFZOv5pieFkd0S
         79s+24LgwXbu3mXJ6TAJB5CpnBN3hCmNYAqbPGazO56CY27hiwl9bz37TfSbOpA9Ijie
         2Wj/abIUVTMt//B5QSUo/6mBDwAkZSXBBBndSzloD3L8NAt6isjiaZ5X2sArX7qIxbt+
         LfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601991; x=1718206791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2xNS1QpSz+39wQah+1VAzcgSUdGcXWkgWovx8I8wiU=;
        b=eTyocJOpfUbj64oofXNyjRKYjzOuKWaL1lZFXXO1A70LealAxuwj5Yyl6OkU0s9WAb
         2hXc2FG6nL7wk4GYie8k0dmY+qUqaTvsXNu8dHWPqKAg+srs9BDLqsrkDbN1ePRCRf+U
         nFTw2Fqaa4sIxf3HGTESLSDCysbYi/he0zKa+YvoMgc7iDH+U8fcxgWVv0bivxLcBqOV
         7CbMCNLq6OHD0UP2CBUhF/q/BuvP3xe74uFpExAbEWGzicha1hqyqMCkM+xpYMwr0cSS
         NcszpGvMUyqgkCIt1zkFVpdEv6Bx1hnMI7Zz5/B8lg9g4S4Y13ApJ5Dl70dn2ZNd/7xk
         jyhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzDGTFx3OkPxrr7ugVGhDvrBsW6ORJf6fD2ZSMucR4WS44exvGlhWoweBOsbb2smESE2fLyZ+KixQdnXLEbgv+fGlADe7fThIFarllV9e47qfYj3kQG8jpY6BKa8QqTQcguseArDKDNno=
X-Gm-Message-State: AOJu0Yxe7fm6h3mMGjJeZVBo7TjijCFpnOTc8veX2Leikgk3a7fIp9RQ
	XEDAV6QflcgKjhPvLSFC/1Sz5WsNIXIt4teo3f18SeL6XUYjcbKW
X-Google-Smtp-Source: AGHT+IFDb5++yO3LfHDxhNCfQvPlDLfkklcdPlokRUpM/gagER8qJQ6me/S2riN97LKFOdJuJ5jq+g==
X-Received: by 2002:a05:6a20:7487:b0:1b2:a899:e57e with SMTP id adf61e73a8af0-1b2b71542b8mr3242481637.59.1717601991368;
        Wed, 05 Jun 2024 08:39:51 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae8980sm8739622b3a.128.2024.06.05.08.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:39:51 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Limit mic boost on N14AP7
Date: Wed,  5 Jun 2024 12:39:23 -0300
Message-Id: <20240605153923.2837-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal mic boost on the N14AP7 is too high. Fix this by applying the
ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine to limit the gain.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa76d1c88589..5e016b1f0c4a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10581,6 +10581,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
+	SND_PCI_QUIRK(0x1c6c, 0x122a, "Positivo N14AP7", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1c6c, 0x1251, "Positivo N14KP6-TG", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_SET_COEF_DEFAULTS),
 	SND_PCI_QUIRK(0x1d05, 0x1096, "TongFang GMxMRxx", ALC269_FIXUP_NO_SHUTUP),
-- 
2.39.2


