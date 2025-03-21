Return-Path: <linux-kernel+bounces-571092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB02A6B909
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B257189D37D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4451EFF81;
	Fri, 21 Mar 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NUd1oBFS"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2BC1D514A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554165; cv=none; b=VVDvpIWLvot9CMB5I5ihnikdTGTjXByXJ9HOQDB7mhCbTMgn7q2F/8EsV1ob5xGVTMwlBXEpbidjviJFchqgAZ/QPQnMKYRYNmi6GbJgoE4DP2A+rRNwxNDUr6/xEu6Cs30RKMQUGbt9lbnRbBZL7McIxBxc9MGIiWzncZM5Z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554165; c=relaxed/simple;
	bh=aStHTjdtJrpDKacYsLyzO+frL12AwKU5p8uNGZysYew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DNNTOuTenD/FfEMzGSqfGeJo1CieBwo5eBnSF4zK7A6YeKXY8J8FfHFtX03eFivwd9YkSDaHNjhrFCmWUEB9z53ATskX1dRCydbZLsG4bPhevwPaoPaGkYPxvKAqyU/o1NRjayQZHe6vUM9vhfLlsqTkAJatLtWK9PXgMQqcGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NUd1oBFS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 34F9F3F6CA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742554161;
	bh=z9wosfMTvKly19CGRaWf+kiQFrol15FV6ibGh+/i9lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=NUd1oBFSLTg9XdOQ8rRXvV+npO3sGgewvZRRMcqbc/m2PdmVNN/zXgAIe31EPrio5
	 aiuXJVjdiENqpF/vVax5x67tQXwTOgPls0zDAwAT89rHm7H57a1vV7Jg+y7VERWxN7
	 fTuNLLA627RjuvqKnp+iIqKJtRcZniT3QwYwHvMAWI7PDAsXPhbqzJYoDMOx0P1oVI
	 t2wa5GqhZpqCx+svJ8IZ/iGAk73H6XZswXgWv8vk3AHyI7ln+xg4NzLCnLOTdDuhcn
	 pl4tkGtaoWmL/y/B0A/qQrUME3G591bzcDjPwknZGqSCcZk4aguKk00SywOezlwkaT
	 TpeqmUaRrjIng==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff68033070so2772297a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742554159; x=1743158959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9wosfMTvKly19CGRaWf+kiQFrol15FV6ibGh+/i9lo=;
        b=r7ohWCmHJFoXtvhDclUxg+DvQ5JGXx7Y9ZJdJx9Ns90ltuP34+JNwyATSwZvrroOM+
         nvv/B9oOYJyZ8QF5br4oowzQQi7xzmn8hdlHZ6JZSfc36l8Ofi0k8ySyKAkoWmUvwD1d
         gjMvrMs6DwolZnqbI57zUCW2ZA1Ls1lH7+0/73s4obtrIK12i72iUxvP9IZbHKdhW/RR
         xyjYe18z2C4JsHztl/Oue2uBCVlLMjLVnJElNxenro9nmojnzv/11DueR7qDLEwMLX2H
         wB0wbReH7dqCT6C53fHYtvJmFEzQySzWXKUf3o6H1x+5Jsk7VTKOTgxb6hFWfdV631KT
         dhfA==
X-Forwarded-Encrypted: i=1; AJvYcCUeOuOq02NVwg6zwSQwXTqT8iaIZpXutJFbus7o8BFKmDSBKDsOcY7sDYyacQE3Io1XjQuQExIkUTl8bvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpW//7ONcZJ8ObPwpsXCWbQ6nXHGGcRh3Gmp3CmS/j63pn8PaX
	zeUNPGFPL5/vJpfgihocYoDn3CwwbnRunVL2ScVop4x6GKWhHJI4oBy1b4991ZNPX1B6KkLRXKP
	FwVb3JMl1DtrnwLJLSq2DemtMhgWwbyn+MN4gqXsl1NSZiK/l1ykjOZ88zbnBVhwgz2tREwxhcj
	/GSQ==
X-Gm-Gg: ASbGncvtzzNO+Dy6vyxrJodpLKOCdyc7VXWvXkGcEkXTWeHNXf2oeYVDfyIBocHNo2C
	yNhj1P8VWKEAzQk4oYoy8wBtpWzEPO2pEjy7sKk7had2z3jIUGOV/lZfcOVlH/AZ8AbCWwXBNrd
	FWh8Su74EOeHEkKSzAzMuh9MQ03eRsUzUJiTnkvJNPEnnAgx6UHHzUrq/0QF0Odo5rXr2wjcIGB
	dQAEw5ikRhaFhxSKae59OXWQJbZTMFrVsjVQ6ATuV2N+ZoL9ZvdHQywZuv7UjFb+B5sj+IkzHX8
	6MhJwV6T5uZ6T6GyAwzfJdCL4y4QrS8dtZXujr7HPlowGm6D0FLHEaWsGRpd4w==
X-Received: by 2002:a05:6a20:430c:b0:1f5:9961:c44 with SMTP id adf61e73a8af0-1fe42f09264mr5515683637.3.1742554159476;
        Fri, 21 Mar 2025 03:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCJ33UaDL4j8gJNAwbjlWs3Ea2yNfzjlg9zUYpfJQPH141PwlC3oJsanq+y+Pr9AOvWq9u7A==
X-Received: by 2002:a05:6a20:430c:b0:1f5:9961:c44 with SMTP id adf61e73a8af0-1fe42f09264mr5515649637.3.1742554159016;
        Fri, 21 Mar 2025 03:49:19 -0700 (PDT)
Received: from u-XPS-9320.. (114-36-251-180.dynamic-ip.hinet.net. [114.36.251.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa92bbsm1589353b3a.16.2025.03.21.03.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:49:18 -0700 (PDT)
From: Chris Chiu <chris.chiu@canonical.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: simont@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2 1/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
Date: Fri, 21 Mar 2025 18:49:13 +0800
Message-Id: <20250321104914.544233-1-chris.chiu@canonical.com>
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


