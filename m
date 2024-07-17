Return-Path: <linux-kernel+bounces-255156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7880933CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92E51C2284A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4917FAB2;
	Wed, 17 Jul 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Af+pHljf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E817F4FD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218250; cv=none; b=YF0dDV9j3mhurZ1RS3nueFBYCV8jDyWjpPa/b/lJ6pZMBH/WiFLag0DJvrBixMYLp7Jm1PxzIKP7HZf3RxFa7LKtjj4F0KPkIjoT2Rs8mOKlMt/yH0ZJVvaP0Pnkb8z7PE28G4rKrvDAjIWMEtkjrVgwjyzugyEfsBHaE4Vt6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218250; c=relaxed/simple;
	bh=tL2zO8sShVnMqsumwVetJoNc6QDlU07aXRYDJkCzAwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGcryCZgGDDVktkWdL2oJE88ml6FTZpmAKtvHWa4EV51pwbntU0qRhZAng3nuwlCb2p1c6SDz0j+XTThLszHdWa4TviO8ZdKQ/69+g9qZf3hC4b1AAJCsEXeHJNObCvNNRawOWYFp0+XCePuvg2KjlcABQupoW8//3FDQmD99Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Af+pHljf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HBrFsc114994;
	Wed, 17 Jul 2024 06:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721217195;
	bh=L7Y4bvkhhvsibrE1C4aidBkH3gAAnG2XmDY6RVwdt2w=;
	h=From:To:CC:Subject:Date;
	b=Af+pHljfiQeUImkzDHFjRXbJuK9Yv4Wt0Y9GARE1w3TXCc5u5UDryWiufQzMQK0HM
	 qsTI3Qyw7Akid6KUsKHjRJ1uZjMw+4NFAvaE+cEFpTgo5rk+mvchkrFfk97eST4XM+
	 TbEZKUyOU02FZgZHDI7sLgcztXCq6rX8z9GwVOdk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HBrFVT003347
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jul 2024 06:53:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 06:53:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 06:53:14 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.243])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HBr8n9112673;
	Wed, 17 Jul 2024 06:53:09 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13564923607@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <cameron.berkenpas@gmail.com>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Add new quirk for Lenovo Hera2 Laptop
Date: Wed, 17 Jul 2024 19:53:04 +0800
Message-ID: <20240717115305.723-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add new vendor_id and subsystem_id in quirk for Lenovo Hera2 Laptop.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 766f0b1d3e9d..bac68a84fd50 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10539,6 +10539,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
 	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
+	SND_PCI_QUIRK(0x17aa, 0x2326, "Hera2", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.34.1


