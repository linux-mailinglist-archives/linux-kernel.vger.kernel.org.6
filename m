Return-Path: <linux-kernel+bounces-282272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730CF94E182
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285C02816A3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDF1494B2;
	Sun, 11 Aug 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bxUMu2Ho"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C307446AF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384435; cv=none; b=nAK6LXKVnTwNZiEYOVy1e4Bc1EebxUkgMpPB5C2G3JMtH/dS/tPKtpVfDOOySia9sPYLLYRYsFD9hbOZEkVPf2sauDrsw8C9CfeJdts1TXnkF64ki21RJI1AE39swivZpu6ZpTt9ua01ZG8ecPRh93wEb8Gb7lnIZoTEY2drb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384435; c=relaxed/simple;
	bh=+eKFhUBG5MdbsmZp8szLTALinAN26PPb9DQlFCbKXTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+PAjzeESQO5K7b8UGaPmPK9VEvUx96eMH1WQ0FHIUCJ/YVqVIGtSssnC4sPAJvRtPVNFBDaXgS+UY63eSgoSzxqbOCPtdV5ibOs4eyVus3WLxaYpZzCK/ki+8OPeLqxA5kCvmYyXnvtj/3R6STWlHUxsTmBSg9I/W+Hr5LtL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bxUMu2Ho; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47BDq0ii106747;
	Sun, 11 Aug 2024 08:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723384320;
	bh=uK2VYFW2nPZkyvTRmIhW5bqxKz/MBQlcffHhnp1/j1E=;
	h=From:To:CC:Subject:Date;
	b=bxUMu2HoNPQ8pRjLn8Hyy6W8slU6SBUeSZlXdUY4pfpvJNdIz/OhBnodXqC0kFD8c
	 L1gFVa2on7rzqa1KToZkNGCDGHapZE+oNEUSchJVAZxfBrnQBA+2jwWF+LyB7yyaOZ
	 uUW1oMkiPsgO17JayvPP6WysVYOLdl39EzPX1FYA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47BDq0jA037287
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 11 Aug 2024 08:52:00 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Aug 2024 08:51:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Aug 2024 08:51:59 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.152])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47BDpn6v100681;
	Sun, 11 Aug 2024 08:51:50 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <zhourui@huaqin.com>,
        <alsa-devel@alsa-project.org>, <i-salazar@ti.com>,
        <linux-kernel@vger.kernel.org>, <j-chadha@ti.com>,
        <liam.r.girdwood@intel.com>, <jaden-yue@ti.com>,
        <yung-chuan.liao@linux.intel.com>, <dipa@ti.com>, <yuhsuan@google.com>,
        <henry.lo@ti.com>, <tiwai@suse.de>, <baojun.xu@ti.com>, <soyer@irl.hu>,
        <Baojun.Xu@fpt.com>, <judyhsiao@google.com>, <navada@ti.com>,
        <cujomalainey@google.com>, <aanya@ti.com>, <nayeem.mahmud@ti.com>,
        <savyasanchi.shukla@netradyne.com>, <flaviopr@microsoft.com>,
        <jesse-ji@ti.com>, <darren.ye@mediatek.com>, <antheas.dk@gmail.com>,
        <Jerry2.Huang@lcfuturecenter.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [RESEND PATCH] ASoc: tas2781: Rename dai_driver name to unify the name between TAS2563 and TAS2781
Date: Sun, 11 Aug 2024 21:51:41 +0800
Message-ID: <20240811135144.178-1-shenghao-ding@ti.com>
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

Rename dai_driver name to unify the name between TAS2563 and
TAS2781.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/soc/codecs/tas2781-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 313c17f76ca4..8c9efd9183ff 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -672,7 +672,7 @@ static const struct snd_soc_dai_ops tasdevice_dai_ops = {
 
 static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
 	{
-		.name = "tas2781_codec",
+		.name = "tasdev_codec",
 		.id = 0,
 		.playback = {
 			.stream_name = "Playback",
-- 
2.34.1


