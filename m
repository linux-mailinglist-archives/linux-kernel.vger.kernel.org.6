Return-Path: <linux-kernel+bounces-171765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE318BE83C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9F31C2429A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98A16D9B0;
	Tue,  7 May 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nFVPttSH"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE54168AF1;
	Tue,  7 May 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097815; cv=none; b=ti7SSfYLQfloMgc+D/mUu1gxf53IbUYhxzDDdbuePOV6e00bCctPYQikVbs86UuwiShM3SXn+fb/QUOvzDCoTXK0ncoj4o1cUwRM6gkOX7lQgont3eRgriaD4vV8IJfUJROPMEVjPf8DCoxHEDPloZ7xALO3nPcBlFCKPNknFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097815; c=relaxed/simple;
	bh=Xx7Ej+9S8evVgDf2z9EGwZnJvMuS9cGkKNaqI+0ELtk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLG4nFG7wzGEbBo7mhLEGZUomu555d2f/ND+gJp38HP9mj9H7LS+ye+3/cnGrCG/7/tJB4nZMKZyj6qIn6Vul70lzGFZWtZ1UTKwmkqAY8/98u6wNLOgXVzlENoHJp61qbugtK3kuxSZ2Q6srG3zBzRMKN8XTQAqiv7XyfQv404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nFVPttSH; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447EWXPR028438;
	Tue, 7 May 2024 11:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=j
	tTiHU6Lrbbii6hLYj4QMHgZinWZVyyt0Dx+k7hmrAw=; b=nFVPttSHSfcNq1Jsu
	jLJs/RRTgPTLtdRDLJEJgAxc6g5VBkef9AWQFy1LF0Z7Egj36Lwh00aLaF6LJUW2
	ev58XGFHZkH/oPLRFSgp51B7R2DOs7PGfA23xsNWRvu00xKBx/ZDKQBzB6GLZvGD
	VvnedakDIfZuJKwgjPtRBYGtC74l5VZHNawBxsK0Cu8lQtlzZbLP6oW5DbygQYAp
	MqOCsMC8flRzw6C08eOBVd6dc7+dkv/U/n31rsE4+UMfbX8duQclTW1/Lvu497fb
	cf5NfYlYp7SSWVxQFu+psdtURePhGIJorpW2PG8ynBQQpbGgX2QcpYVj+v0T/MwB
	Vc37g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xy2cmhaug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:01:38 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 17:01:35 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 7 May 2024 17:01:35 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.12])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 81891820249;
	Tue,  7 May 2024 16:01:35 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda/realtek: Add support for ASUS Zenbook 2024 HN7306W
Date: Tue, 7 May 2024 17:01:31 +0100
Message-ID: <20240507160131.356114-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eH9MVN0oIpQj7gMEwNvdblta-VVel0L3
X-Proofpoint-GUID: eH9MVN0oIpQj7gMEwNvdblta-VVel0L3
X-Proofpoint-Spam-Reason: safe

This laptop uses CS35L41 HDA with 2 amps using I2C and Internal Boost.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8502b30d5d5d..8c157158f1cb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10276,6 +10276,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALC285_FIXUP_CS35L56_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_CS35L56_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1ed3, "ASUS HN7306W", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
-- 
2.34.1


