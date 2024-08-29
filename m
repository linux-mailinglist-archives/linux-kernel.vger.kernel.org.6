Return-Path: <linux-kernel+bounces-306085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A39638E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7F1C213B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8004D8C6;
	Thu, 29 Aug 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RVXgD6wX"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FC2837F;
	Thu, 29 Aug 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903203; cv=none; b=O6nJ4XqHo/DshjfPqUSSt3JFnolCca705EDfeJQhVTtxamJATt77ZFaPv3t8tJQwmg6F1oh7Ai1VC5+Fp4bvkk4WRywTncJ46jPNRcH3w2U2Ie0D3TxfGmCgI2LsulkJLmRdMk6SEcoS0tdSx5GGvKSjOgxvGFCEmg4u358/FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903203; c=relaxed/simple;
	bh=5e0ziAjXZ4d3aftInu5vbDt0gIVNrJLL/mjGOP67n8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQ1v+x89eslPivoGzXBh3wByRfmcM20aQBFScbYsrQgy//QaHEzHMeIU2+orLaGMDwp6S+zCr3y6J5ewuS4YOmw2snyVLLkE9iyOC6zlTbNuC/puaHwSCv3tD+id2UDg8fPX9bTgnOz9X3TQYj5rRE9Q3/DGMBVa8zzulCHEQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RVXgD6wX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47T3kVu153104151, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724903191; bh=5e0ziAjXZ4d3aftInu5vbDt0gIVNrJLL/mjGOP67n8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=RVXgD6wX5R5obNiexy4VBFNwod340qh41C32vVan74CoPV0qlND23VgpjmtJ4i4jV
	 +blkcZ67gw6rUrVsOSSenB2iOgiL0S8/F+W6++LtvngqmXPu6J3gXuWSZR0IR8toH3
	 XztW9/e1lncMQJOA2+iZLSre4vgjKyuv6MH5w0T6Zs4/WLUnlypTbNx4q9q+4It0Fa
	 ViM0UwEFSeF991zx5IsbuC+HKa0vNUaMs3TRK3E4V+qFO7bu8CAFPbydAdR0wqFq7A
	 eou3q6UB1nA08+11lKTVyedq5lhHghwvIEpD54pWuuXSa3SpG6/iKriDeQg7QQRYqH
	 OgVWJC0buaHYg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47T3kVu153104151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:46:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 11:46:31 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Aug
 2024 11:46:31 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>
Subject: [PATCH v3] Bluetooth: btrtl: Set msft ext address filter quirk
Date: Thu, 29 Aug 2024 11:46:27 +0800
Message-ID: <20240829034627.676529-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

For tracking multiple devices concurrently with a condition.
The patch enables the HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk
on RTL8852B controller.

The quirk setting is based on this commit.
Commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by
address filter")

With this setting, when a pattern monitor detects a device, this
feature issues an address monitor for tracking that device. Let the
original pattern monitor can keep monitor new devices.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change:
v3: edit commit log and title
v2: Add reference commit, update commit description
---
---
 drivers/bluetooth/btrtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 4c0f551a9975..2d95b3ea046d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1308,6 +1308,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
 
 		if (btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B ||
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
-- 
2.34.1


