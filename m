Return-Path: <linux-kernel+bounces-561097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CAA60D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC2B3B2EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941001EEA4E;
	Fri, 14 Mar 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="F7JUvvkA"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F61DF261
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945231; cv=none; b=EJp//VqCpn+miB2BcjzWVFqxj07Hd3Um9cFc5U5wNrUoDCjkyVPpvEyhfsN4LQ2QaeJBj6xQ4f9J9BDwgExEy0o5DVn28BZvbErpBcdZh+eoY9hn/fQjTRNpPT0AxHuRee/wJE552cLqO8+bRh3Ni7I54TimAqoBSf9Sd6bZlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945231; c=relaxed/simple;
	bh=Zy4ENLi/Fj53oOnr6AF0AyeVaoAeYA5yVcfxCGdbmXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FSTtNne9mu/jIXEitDSU/ugvkehXYvkhy0SPPl+Stn/GlIuojB40r23QBJL+vV5XcssAIgcN6FokIb2lwySPQNspB3FsK/Wh23KJkCog+MFGIWG2MqnkzYxNXf6+A+4B8oMsaM5mz12zxixEgtYH6D08/kZlU2pmflHj1SBcYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=F7JUvvkA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E9eGn852853244, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741945216; bh=Zy4ENLi/Fj53oOnr6AF0AyeVaoAeYA5yVcfxCGdbmXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=F7JUvvkAQVLktAfInx6rRci6PU2m/Nr7OOCucXagrBNFQqsIpo3p1ZtjOtmq1QuGy
	 i8LeT7608Agh4z+ePkdUg56kIiAHhTOekVtcX5HlqPU6gqMvCAWToqSM/0QG+uE35O
	 ydcs42SxOC0x2TERuSUgFACiqOtpMOI7q0o7dMwedeASzQePTEkBeJW+7Nqa7TF2Ef
	 M4WuPjb0d4OvImK6Q1rStYFlgVS0vfGHpwqFEiLU84BwzAh82nWjsw/z3+zjqB+HCG
	 snjpXE5EmYs/SAO4fmVLAXYz+5o4mX/NYLH6GxK6FTgwiGNjV9LjZkAgI7jxsPJoNO
	 EsdspdAMOuQiw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E9eGn852853244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 17:40:16 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 17:40:16 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 14 Mar 2025 17:40:16 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Mar 2025 17:40:16 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ricky_wu@realtek.com>,
        <David.D.Wang@dell.com>, <Qian.Fu@dell.com>
Subject: [PATCH] misc: rtsx: Enhance the signal handling processes in SVID/SSID 1028:0CE1 platform
Date: Fri, 14 Mar 2025 17:40:13 +0800
Message-ID: <20250314094013.663223-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch introduces improvements to the signal handling processes on
the SVID/SSID 1028:0CE1 platform. By optimizing signal handling processes
we aim to deliver a more stable and reliable user experience.
The enhancements ensure robust connectivity and enhance signal process
performance. We have conducted extensive testing to ensure these
modifications result in noticeable improvements without impacting
existing functionalities.

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5264.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/cardreader/rts5264.c b/drivers/misc/cardreader/rts5264.c
index 8be4ed7d9d47..06d7a8a95fd6 100644
--- a/drivers/misc/cardreader/rts5264.c
+++ b/drivers/misc/cardreader/rts5264.c
@@ -605,6 +605,22 @@ static int rts5264_extra_init_hw(struct rtsx_pcr *pcr)
 	return 0;
 }
 
+static int rts5264_optimize_phy(struct rtsx_pcr *pcr)
+{
+	u16 subvendor, subdevice, val;
+
+	subvendor = pcr->pci->subsystem_vendor;
+	subdevice = pcr->pci->subsystem_device;
+
+	if ((subvendor == 0x1028) && (subdevice == 0x0CE1)) {
+		rtsx_pci_read_phy_register(pcr, _PHY_REV0, &val);
+		if ((val & 0xFE00) > 0x3800)
+			rtsx_pci_update_phy(pcr, _PHY_REV0, 0x1FF, 0x3800);
+	}
+
+	return 0;
+}
+
 static void rts5264_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
 	u8 val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
@@ -682,6 +698,7 @@ static const struct pcr_ops rts5264_pcr_ops = {
 	.turn_on_led = rts5264_turn_on_led,
 	.turn_off_led = rts5264_turn_off_led,
 	.extra_init_hw = rts5264_extra_init_hw,
+	.optimize_phy = rts5264_optimize_phy,
 	.enable_auto_blink = rts5264_enable_auto_blink,
 	.disable_auto_blink = rts5264_disable_auto_blink,
 	.card_power_on = rts5264_card_power_on,
-- 
2.25.1


