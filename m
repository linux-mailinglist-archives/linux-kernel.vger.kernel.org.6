Return-Path: <linux-kernel+bounces-335676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237A97E8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422F81C202C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA487195F3A;
	Mon, 23 Sep 2024 09:43:54 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BBF1957E4;
	Mon, 23 Sep 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084634; cv=none; b=EW7LQL+7EyBehzzfuTbHokWDW040kdEYjBvUftICFFTjaq58NwROXspm8jvclpRW9ZY70dEcTiSOFx4sLfYJXzvjExbg9WNBevNSDuY/AYemQ1nqBtV+Kd05XOh+OzJO1EmHkgL9Y1DysYsQbVhHN0j4yl+rz5vCDZPRdfUqmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084634; c=relaxed/simple;
	bh=ydBWyQAf1j55SxemS703r61aCRERlgQqdP6UFOehUGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrXi2hvQl4+nAOvh1VdkWSxsv9zBXX8U2kFmYm7Yel+OX7FuBs1+OnmJth+gL8j4weZgDlM7LWjq0/txwmnQGbvl4SsdEpbMqcvRpIsS/HLTOd3gEAA/GtIj1DoJ8exPrqyQA9W5oABQAQffQ/UbT/rmOcvyylElSclK2kwDFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 51b7f0b0799011efa216b1d71e6e1362-20240923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:443a2a91-c211-4926-b0f3-9bf9b8ad4984,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:9fc400b48005e8f7e8c12eef4317d0b7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 51b7f0b0799011efa216b1d71e6e1362-20240923
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 703584644; Mon, 23 Sep 2024 17:43:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4A235E0080FF;
	Mon, 23 Sep 2024 17:43:42 +0800 (CST)
X-ns-mid: postfix-66F1384E-1126261213
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id C3600E000E82;
	Mon, 23 Sep 2024 17:43:41 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: linux@armlinux.org.uk,
	robh@kernel.org,
	saravanak@google.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 2/2] of/platform: PCI: Use dev_is_platform/dev_is_amba to identify platform/amba devices
Date: Mon, 23 Sep 2024 17:42:48 +0800
Message-ID: <20240923094249.80399-3-chentao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923094249.80399-1-chentao@kylinos.cn>
References: <20240923094249.80399-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use dev_is_platform()/dev_is_amba() instead of checking bus type directly=
.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9bafcff3e628..1937cbef55ee 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -619,10 +619,10 @@ int of_platform_device_destroy(struct device *dev, =
void *data)
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
=20
-	if (dev->bus =3D=3D &platform_bus_type)
+	if (dev_is_platform(dev))
 		platform_device_unregister(to_platform_device(dev));
 #ifdef CONFIG_ARM_AMBA
-	else if (dev->bus =3D=3D &amba_bustype)
+	else if (dev_is_amba(dev))
 		amba_device_unregister(to_amba_device(dev));
 #endif
=20
--=20
2.43.0


