Return-Path: <linux-kernel+bounces-547337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA818A505FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E93C7A7685
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7442505A0;
	Wed,  5 Mar 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DzB46ah8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578C1A5BB2;
	Wed,  5 Mar 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194457; cv=none; b=srjiEmiS1pcZTWjoG6Nlq+Sh52NEAJIbHr0QV7mlIC/xu6umvbvoFHfyZPtRW5zNKyltRUEbEpw+i6/gVgl/Xq6E1j9rnC2daNzXcF6WV5lVDE/szCcIKU58Z8RMWI53sy/9MBb/UqIMofj+igHazyAYHsgvwt9OykrMehZm0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194457; c=relaxed/simple;
	bh=VtOv6vTCYss3fo+fJoS0vMlGJL9BWrK+pJYF412wFlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxE7iEeGv8nkEmeVdBMLVTUFL7H/ueiXnWHm9+y4SlRd5HwpWoPJr/lT7MrEAaMBja/si0ZwO1OoIJt+s39DmeMLAObTjPzyEfnpHfBzsTkS/oD7GauC8OdRF3bWnnjhWcCNmjU5OBCyjaQcR/y+4fAYej1nnrXy4SadBkc2RUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DzB46ah8; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5254p2QB002458;
	Wed, 5 Mar 2025 11:07:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zLPXuwFTfzgJITbHhmHowhhEO8JHUCcG0LetCi/Tn9M=; b=
	DzB46ah8boIFJUQjVH+t0VzWF0dpOF3hnYoeQLwxG8O5gyDoW8OyzX/zcQlx0+Gy
	iI4AQJ7Dheki4IsFb6jQTBwMzUO9hAGbN9x0qxs2g5KLeF2kjrJFe6mUodq1EXRQ
	d24QQjMer2xHJHX6/82vK80nZ2/If4LPN/FHgzlTE1UPtkAIcW3SDn046WF0n2Zu
	tsY4lcIC7PwPUS4+XeoXyUR2qnOfjdU66m619K9VlsoQWWYKf1wWTXLmLxZG/Bhd
	raR+XEBCDlEUbtjD0I124w6AK2nH8e+ELo+U2WpqQMS6c6Nyte9+1OGnKnxXuIDH
	aMeuUWKwbxrZn6o5mMErfA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 456e8nsap8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:07:23 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 17:07:21 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 17:07:21 +0000
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CDB5782025A;
	Wed,  5 Mar 2025 17:07:20 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
Subject: [PATCH v1 6/7] ALSA: hda/realtek: Add support for ASUS B5405 and B5605 Laptops using CS35L41 HDA
Date: Wed, 5 Mar 2025 17:06:50 +0000
Message-ID: <20250305170714.755794-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
References: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DpWs+H/+ c=1 sm=1 tr=0 ts=67c884cb cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=ViH9WLEzzpDX3eh6sM8A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: uzCHIdFNFJtstGnWGcLwpN-J1_QtY2Fu
X-Proofpoint-ORIG-GUID: uzCHIdFNFJtstGnWGcLwpN-J1_QtY2Fu
X-Proofpoint-Spam-Reason: safe

Add support for ASUS B5605CCA and B5405CCA.

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with SPI

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc1d9beeaa2b..99be1220de63 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10743,8 +10743,12 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3011, "ASUS B5605CVA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x3061, "ASUS B3405CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3071, "ASUS B5405CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x30c1, "ASUS B3605CCA / P3605CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x30d1, "ASUS B5405CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x30e1, "ASUS B5605CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
+	SND_PCI_QUIRK(0x1043, 0x31e1, "ASUS B5605CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x31f1, "ASUS B3605CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-- 
2.43.0


