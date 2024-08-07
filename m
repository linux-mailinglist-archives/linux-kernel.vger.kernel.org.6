Return-Path: <linux-kernel+bounces-278004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13494A942
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95981C22A00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9D1EB29;
	Wed,  7 Aug 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Oi0xSqiK"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C5282FB;
	Wed,  7 Aug 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039320; cv=none; b=QL+f4jC355msQYQy/AegckHjzSVX1Z0zTutQT9q7xZxRb59uzwZPcmG/dc3aHO0DsLG21Wrg6kONBC9MLncQjVqjOjhu2Og/9F3mwawQtUOtr+07aJudzOZRsXYlmq0J2angH6J3ypG6vId/EsQQRj0IZINK0VSBrb4/g1wCsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039320; c=relaxed/simple;
	bh=p6Ih6Fj/GQiuIgYaiibF22nNrzJMKGCLR5MjTHrzu+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdJmYWKNzro0quLpP8ZmL9ZEPIXtNHHG4puK83lbxRi+aWIEENOKkYkNHpkwE7NVxduueQw68wlT/MsEYXQ4670ZXQeE4TioKDC/7xqfKvuP6Bk5kL79JBp0rWhglwcUd/YZ4zvv6QgjGDttkKjDDUGCj0MpegvWwCkwpDCnoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Oi0xSqiK; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476KWxHv015964;
	Wed, 7 Aug 2024 09:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Hp2tyKW9duBah9PL
	4qyKva/RaDOMI9TcPcj3LQY4tnU=; b=Oi0xSqiKtm/95TlnQcuVlH927hVSXuAo
	7PQvE4z9A2qKZHXdQ3/L6Bc1i4MoZgpxfehq1KEW0+oLIUk0t/cG/rLTz9xXq7ev
	i3ISVCDj3YpqNc+rLa3oiMRI/oFhugds6DKd5awvV4nA3Kt4iHSnBYoQH30EOM9R
	MXvaj/UKBYPywv0j+X7bkOwMPfvHnEuni+9cWw9csHjV2YCz0x2sCdoXLH8HpfgW
	Iio8DO6bc6//0D9VWCsAcFLRmDKSNJUXJANTL4+6AJwBLB4l/XpO4TKmWH6zN9Gc
	2GoegWjqdkkqyHk404MSMj+S3Ln2qrP0FuZXC16iRKReFtPpaQvp1w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40shxx4gjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:01:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 15:01:41 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 7 Aug 2024 15:01:41 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EFEF1820244;
	Wed,  7 Aug 2024 14:01:40 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] MAINTAINERS: Update Cirrus Logic parts to linux-sound mailing list
Date: Wed, 7 Aug 2024 15:01:40 +0100
Message-ID: <20240807140140.421359-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tUwATWGKb5oOcTJmXmL2k9MJv4kmlTz3
X-Proofpoint-ORIG-GUID: tUwATWGKb5oOcTJmXmL2k9MJv4kmlTz3
X-Proofpoint-Spam-Reason: safe

Now that most kernel work on sound has moved over to the linux-sound
mailing list so should the Cirrus Logic audio parts.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88a40557db32..5babee26f20c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5306,7 +5306,7 @@ F:	drivers/media/cec/i2c/ch7322.c
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	David Rhodes <david.rhodes@cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
@@ -5375,7 +5375,7 @@ F:	sound/soc/codecs/lochnagar-sc.c
 CIRRUS LOGIC MADERA CODEC DRIVERS
 M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	patches@opensource.cirrus.com
 S:	Supported
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
-- 
2.39.2


