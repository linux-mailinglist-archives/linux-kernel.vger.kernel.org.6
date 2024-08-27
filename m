Return-Path: <linux-kernel+bounces-303178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F3A9608AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C9E1F23A79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227119FA89;
	Tue, 27 Aug 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjiuJ4ha"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9919EEB4;
	Tue, 27 Aug 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758183; cv=none; b=HmLz6KUFWVmbWzc6HbuLtK91drPUkkrl5yn+wcY17o5Oa4aEU3bif4NZb07KLx6WZv/lU7/Ov5Zlt517X+b7pKG7a+ZETVpqCuFEg15XDfVw3XclIyom/Qi4i2Ne3rNeIW31sCfEgPoltDlzL3OxPdDcexj0KJGXhlc7LPCCtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758183; c=relaxed/simple;
	bh=mtE/DIzdIY0aE9jx+lSBwiZujkAm3EwvIh0iOHY1Qao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=olXgPuNBeOnNssqhi2BTGivEWDCuPtkbdngcSQyCu+knVJf1Nii/I0xkXa8MVtR6rKD8VO4dfioftpEScge3/Y7itktzGoEStqQnRfbiB9aQEmPy7NSsN34wCE86MpGIJte+4QtHWH54zBIPCxhC8YyVWDBPAoaBaIaKj9HKefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjiuJ4ha; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2021c08b95cso48013355ad.0;
        Tue, 27 Aug 2024 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724758181; x=1725362981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7IeMX+lfboWSCnTtBGO5TJWMMf36fE1uWbBvF6c/AE=;
        b=FjiuJ4haI0G+vStvs4xTGaXjdfitrJ4zMntXp7uqYW/0AznAVezzd3CJwMFUxBrvTD
         iMsIjZD3E/7LfvgMTpZe2pow3S4FYB1/6M5GigdlCRo/Efz2no/4RZ82Zy3csiLrIrPG
         Oyo1ElHLGVk4QIZUnmksIHOlV5BPdpZR0ToVLfDdCe8h0Sy+c2Lk6WTw7SW2WBF8JGjb
         pfyjSBUwLVOt0wTlB4sb/+/pLEaqAs4eCGS5CgV1aUO4y6m41GnADGaJMK7jx8TxCT9A
         ACMjKoMKpgKHcy8RW8v43OripyANLBaUVXqaA+SYWu3aNyZ2WTXEzb+ZFn0D6wuVukgJ
         oWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724758181; x=1725362981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7IeMX+lfboWSCnTtBGO5TJWMMf36fE1uWbBvF6c/AE=;
        b=pF0YtIgGHQ22q5/wuhr047wuyoqVROA4WAwz4UHBHZp8AqrpXE5A26f2d15XXyqJKS
         sQhAd4aAn05jPxR0lhM4TBBvp0tlsRLgSEGCKaBJQlUzjQFtN8TvLfKjm0P8zVw6Sog7
         lwyIReliUgsZNPR+Nxv1SObKvoCdgHN9ISDsQfs6Q/SxhKLlcJTUYWhLm5UAkx1a+FBN
         UqMLQfAeRyS4ofQCPQNF0aWJ/GTe6G97ZMN7+GQu8nmvGpjXdypSc9ewKXiLFhjJo8Sy
         UAEG0B8uhQQI52bXyQ9Y0sXCcWYAGUlHYIJPDJ/ttAmfYflFcE+Y9bjs0ehzfmGiqA4V
         znOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDfIh2bQdEJUSPu+Iht0fMhZ8+1kKMPigQMsIQ9ee0ouzwgxWJX9Zty2Qy+jx5v5xdm9yHxAXKYkhEKWA=@vger.kernel.org, AJvYcCXEoEaaGSkjKyGRziea07AGq7axsHMXiCdXQ+6I91/ct95SC4XpYLE2Ct15PTwxF3cOIo32IfF+xasPKVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4q8vq91PzSIQeGynTfTg9tTw5JEagLsKXFxnhcwoEKcxbVvDC
	1xmFvp8h/ls8QcN6jC/e+YNI2qpNJk/kIpHIpJS5xjFDUsD+55iD
X-Google-Smtp-Source: AGHT+IFtdkg4ZwyN3DCZQ/8qYdcfbbVtSHPLmh6oAuOhdnauyWoi7H1AtD8qepuDQR373OtKdfRc5Q==
X-Received: by 2002:a17:903:1104:b0:1f9:d6bf:a67c with SMTP id d9443c01a7336-204ddcba2eamr48490605ad.5.1724758180954;
        Tue, 27 Aug 2024 04:29:40 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae4e3fsm81464375ad.235.2024.08.27.04.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:29:40 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
X-Google-Original-From: Edson Juliano Drosdeck <edson@policorp.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com,
	Edson Juliano Drosdeck <edson@policorp.com>
Subject: [PATCH] ALSA: hda/realtek: Limit mic boost on Positivo DN50F
Date: Tue, 27 Aug 2024 08:29:12 -0300
Message-Id: <20240827112912.3397-1-edson@policorp.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal mic boost on the DN50F is too high. Fix this by applying the
ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine to limit the gain.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d022a25635f9..b6bd3903701e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10767,6 +10767,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1e50, 0x7038, "Positivo DN50F", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
-- 
2.39.2


