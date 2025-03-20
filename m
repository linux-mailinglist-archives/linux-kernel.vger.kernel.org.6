Return-Path: <linux-kernel+bounces-569711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F6A6A671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1847F1893329
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1D156CA;
	Thu, 20 Mar 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="irJZgoZh"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620041367
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474965; cv=none; b=TnbP4RXUbMI9/bVswiItBx6+dm+2QpL0pTK+f0xqjrE3Zh4q2p4CkNr2ezdyiUVY9FBLF18e2A8wss7Df3FykImqO2Arjb8v4PikvQZfEczy8upBbN5YkTCNMrRIdcqPFXbnInCqo86Pb5mZf0RXBk4VeXm/6Zm7XcqjrGFBWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474965; c=relaxed/simple;
	bh=aStHTjdtJrpDKacYsLyzO+frL12AwKU5p8uNGZysYew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fg7wdBFC01+fIvvkiTNR910nzeamZI/Fq8ddYvVUqksyocZoEryFFxYCQiPu4TFM7DH/nz8J4N9qcQJkcN2LkKy7w4BYGfZQ5H29IO738cJBP6nWZ98U9rLClpazMLS/zw7+D1L3L1tbV1W0dChRuz12S+KZqd6ZM2zDx+O/Krs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=irJZgoZh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F08D3F2E7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742474960;
	bh=z9wosfMTvKly19CGRaWf+kiQFrol15FV6ibGh+/i9lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=irJZgoZhpqfP+6voT3aN/sbpPSKqW8vi/qtfhHT/F/jhCQKJTQPEAhL8KKXOtQrg4
	 PWf6FqtGQQpwtIk/KuYd4hQlrjf9p6FmTrT7JfP65KEzLRvrbKV3LugaCaMrfrIIhv
	 gd8SnOv6xVi6yjDddQJvPfrZgZZGms808NEKADLPUUl50p6gP9P51cEAtFovfvE6Gv
	 rr8e0q0E1+Kizk6Pbt5om/UFzXVur0BPKGi7s35O8kuavbxFF5MjCpklGIXRIbcsrh
	 0vs3SfQoE5xrybWe77AuMPeENtzY2OZ5I006ELOf3n4n8Obv81mmGGlb1FrqId4vJG
	 ryCI8mBguuR4g==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22650077995so17011405ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742474957; x=1743079757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9wosfMTvKly19CGRaWf+kiQFrol15FV6ibGh+/i9lo=;
        b=hPu/hreeyJbpdUJxNwltR2jsVtQPlKfovYRK/fPS543N3Uj0h5nxKHuwwFU2sO/W3h
         xq8GwIRXT6HVbEyYteKPTbWgIXyPdso8xwI0czxzWmk8ZtUzSsZqCgwK3IThvx5gPt0V
         G/sSH2J+lGwPjNaqSlsGK48oZ+A3+HjYSkYV3PN/ZrdtdQ6tf65LSfqkneOKiGer+u4D
         43MuxKY2enFtV4SjEtV2TQsMDuVoyum3vnnA3/bNU8EzJnHBoJcYSCc9ARDdva1Do7cI
         7QSDudfVzSqxwtso3LGxWuyA1vMFOWSP38yOa01GflQW/TIQr5mpBQQiDRnAtuJsJkl7
         fYsg==
X-Forwarded-Encrypted: i=1; AJvYcCVmEjyUjYpI6lj8baE5AtPztQ6o0ds1YqsXa9+MUyOY/1QhMgQ1Yq1L/04oDqQwFi2uE5/ddqrZ3QWuUME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61Nv6OeV7PQAwboCF6kRgRu53PMiph4T7u+PNqihsKvl7BBWB
	qOJEyFJnOFOfn4M6L7w07+xrDDgn0AVzeZ183mqOmli9eUe8Q9iWLBRbppO+yHDeBrcNYE/gf8e
	TwenoXdehYE2k3yVlo/mKwzZLZa0in6SbUyFfijPvn2NVxnnzfngiNeL0R06B7jmX2M7sJwHQOq
	Cz1g==
X-Gm-Gg: ASbGncvyW/dy0NXeMTdiHrkfpCmnHxVsXqn7gjMgnBHG8Oq2DLYhy5gHSW4MDb+ofOE
	Sz1dJIVRgzBuiev/KdzPjLoJ723HyZAGW7nJyajehTrsoY4vIfNp3Zed1isSPa58pdFLhn/ZptC
	R50GW4BwvLclbITp3YDtTYGvC0u6jucErphIP63n7s/liuIM7R375WP/8sLkKGp6rnf1IzbGfsn
	MdU6JJkfJlORtVIQ6RJ32Q8HWsuhNFElk/vbFXFYyFAbkuaO8AGVvOmix6jT8m5DRsFHm2uV5pP
	G8nclA6Eg3bXoBDlcZAKRolH2EjzDB78ckymBxB90u6MhadBNQkQe8Stl5c/7A==
X-Received: by 2002:a17:902:ccc7:b0:224:ff0:4360 with SMTP id d9443c01a7336-22649cb6a06mr113139245ad.53.1742474956694;
        Thu, 20 Mar 2025 05:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkAIUG73MYvFMvy4ljvO26jN+wzckVfdN6iVioSHGSBxuYYkhKK4/wmd9nZ+AQsMUZfxvlQA==
X-Received: by 2002:a17:902:ccc7:b0:224:ff0:4360 with SMTP id d9443c01a7336-22649cb6a06mr113138785ad.53.1742474956214;
        Thu, 20 Mar 2025 05:49:16 -0700 (PDT)
Received: from u-XPS-9320.. (114-36-229-113.dynamic-ip.hinet.net. [114.36.229.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d2csm134194055ad.125.2025.03.20.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 05:49:15 -0700 (PDT)
From: Chris Chiu <chris.chiu@canonical.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: simont@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 1/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
Date: Thu, 20 Mar 2025 20:49:07 +0800
Message-Id: <20250320124908.529842-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More HP laptops with Realtek HDA codec ALC3315 with combined CS35L56
Amplifiers need quirk ALC285_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1d8caf791dbc..30d4cd93dae1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10723,13 +10723,27 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d86, "HP Elite X360 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8c, "HP EliteBook 13 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8d, "HP Elite X360 13 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8e, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8f, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e17, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1b, "HP EliteBook G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1c, "HP EliteBook G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.34.1


