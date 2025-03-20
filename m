Return-Path: <linux-kernel+bounces-569712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66565A6A672
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5CD3A3B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469417591;
	Thu, 20 Mar 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AlVCBGZs"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B582D023
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474978; cv=none; b=Z+7Z4nzZjKIhGiB7EZ30FL4xMubi2C81Pzt93zGrUEywa8TjaZukhsy+DcyAbfLykZZLN3+TL6ieOn8DnGOsqVCd6bDna4fmn5vwHqTHavOJwNgqAIfeUZlEtm4x/Jl+xz0nGCGr1Uch1T5hfuZh/VoTSB7x4J161NgO2xsg26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474978; c=relaxed/simple;
	bh=MRJbpzMReFBOxOrW2BCv7any1qqOc/3lriNrQn7Saow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIyP7OFaZ0a+BKMcunswJYFw0ixplLOkEQRNN21o3Lh2llzFO96Qf8HEKdugYe/pOjUKYwYxMatefm8RkOKQsnhOjqaqAu1YCDDBQg2A+o4jMf1H0jCDmRcJhmipz/PivbUr69lPGXTdRDCo2aD+RfyQmxBlCX7HsaWp4LO3gFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AlVCBGZs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62B1C3F290
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742474974;
	bh=v8Q/8heYF64qru5snKMgVSU4IL0ROPu0H5zemtfSsX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=AlVCBGZseP2Op9R7BgdSLrNlooml9tVacIAFiZmhBODMtsvsnoqgsQQkW8cXcI4gP
	 dQ8JPsjLuEW78ASHRyJGubm8ePKKay0LPzZ9af3LGeVxsZ2d8xgFdzdVN9eHO+L7kk
	 YMgUJoqYF3Q6EpUMxM8reALhg8IZkOdXwiTPRgmHjD9nFdNhTWDwWKM7jGOn3+u4iW
	 OQRfWnMYeiMGb31un90u5OzmYfUsRMcPidojFhsPyAybCvtu6WEAltuOKw1TscXMOM
	 MvJp5pKdKTc36NbvKlTAJUU2CBAFxPcdni0yL3GY4iZxHyIufr9J0nnvn1UwRr34iT
	 GPoOxLAd1NX9Q==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2264c423e37so14473685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742474973; x=1743079773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8Q/8heYF64qru5snKMgVSU4IL0ROPu0H5zemtfSsX0=;
        b=C8L31RkhfUVrBziYdA6pwZt5ODZ5KkvClbYuTdg/0gzeF4RAF5nQzOnQYDFrhmtPTx
         jtfLe6fKLF7txSskV2tU40jrLoRJA/rqK3N9d15G/ywQmWkQxpesZnxskS+EMJxAhgqe
         t2Uha2UMbOvPllLEkHOLmUmaUkHHPsf9HJJJxh6VthVzkx05SqFqnPhKR/fedANkcd2b
         NbGizjCe8CCMuaaXf1PlmaPp4sd5rRnYbxFwXH/OQAxzyVo9tX2pFAvJK6LF7fUnincT
         GOzS4ekiGHD1Zc0kAGHY9YtKsX/rqn17ZoFYqEEindjzJv7SRwkDfIA7ELtBf0Y5qSiQ
         KPWA==
X-Forwarded-Encrypted: i=1; AJvYcCUxTE23O84xFPMW8JfgDdSScLCggkssFNEfwJRLqKTFLjU4uXZjm9anF5R8u4Wt9lDUhsCd3dyAeueXVdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98w6a1/d+z4LVp+nnZ/1hvwH6DsVyYhnNqQII630VAqiyH002
	9OkZd3BsB5aJhPYKnQUFoeYyCAFvkzcnuqIU9oQFtTJI9Pz4n2iFBy58sOL/yspwKtWOmzOd680
	37NZfPTGAd1M1Mn9TpToC0lrh2aNmmg+r5t2hIBWLwbUfW44MYqa+xXxSlS5fDdTR/uao2brcIp
	pEuQ==
X-Gm-Gg: ASbGnct81hw0Jf9goAW0K2hcV3+jiMPegDeofVNJFadXbtO3qDUcpSuUFVu1fhrEYVa
	titHML1X0nurwb3g1qorarw0rqqJhZaiosP+6JUPMppQnwR3ANUBvSreQoK8MVNqJDlMF9jC82F
	PeDmb8OB02w49/NkDEoGxf8/cm+LFFOryVdRH4BinWbEG+Sd8QEnY4jT55G3+3ruiCAOXVwZV9k
	0Z+Wa4AxpkJ415pJ+DSLIfzxWSnv0hN2eIqy6wFk5bNEG/Kyff0KYf2bwKgoLnn6agqt9ZiMP0G
	zFkJGwBEAwWtAq0mAXayPMXxVIK1YKx8t3BFMBjp8wOlHgWtyyn0PYaMtooNNA==
X-Received: by 2002:a17:903:2291:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22649927ca8mr97177905ad.16.1742474972955;
        Thu, 20 Mar 2025 05:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoyeYgcr58fvSndjMn85y79K0CVlqga5tgoq3Ufnsa4hK9r118Dtma+rlPl7qfamNL9i575g==
X-Received: by 2002:a17:903:2291:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22649927ca8mr97177665ad.16.1742474972646;
        Thu, 20 Mar 2025 05:49:32 -0700 (PDT)
Received: from u-XPS-9320.. (114-36-229-113.dynamic-ip.hinet.net. [114.36.229.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d2csm134194055ad.125.2025.03.20.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 05:49:32 -0700 (PDT)
From: Chris Chiu <chris.chiu@canonical.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: simont@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 2/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247
Date: Thu, 20 Mar 2025 20:49:08 +0800
Message-Id: <20250320124908.529842-2-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320124908.529842-1-chris.chiu@canonical.com>
References: <20250320124908.529842-1-chris.chiu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More HP EliteBook with Realtek HDA codec ALC3247 with combined CS35L56
Amplifiers need quirk ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 30d4cd93dae1..eda406a4b52a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10734,6 +10734,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.34.1


