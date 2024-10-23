Return-Path: <linux-kernel+bounces-378289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822559ACDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D20B1F21A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F01FDF9D;
	Wed, 23 Oct 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsrgFca1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745731FCF53;
	Wed, 23 Oct 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694691; cv=none; b=mVzBiO8gRbqGg5CXDBPsaA502CYaoFJVHdtjhpJ6SaLQ0IVFlRIIPxbDcNT1dx/G+Pp4svxW8ghOb7RFvdMO1D9oGmdcdHIMoQJb2i5CBrEE8D1XwDr5JYGtLdZuCmaQB0apghfDxFVUSAIYfW/WsYnRk7cgcRFbxLGz3jmuf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694691; c=relaxed/simple;
	bh=i6gTQQWR/Q7iITKihWhTyePD6C8brJ6TfXHAPQzb59Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gx290zi2Gib8ppgfeU8edJgCs3GCEULwgeK+QITPn5ul/3Kg/wmswLoxWyPqqUcSdsDNC9wzM3nUWQJej5oSrkntGifRNf26tQ4VwZnAkEOjiD5LDzaYiVsGw0miW9pPTl+72H0J7+Qs7F+UHRvhKLSSevn/++cd/QHa3GvQc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XsrgFca1; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEfhWI004197;
	Wed, 23 Oct 2024 14:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=iPM1LjVOR7/cD8+l6cv2bbnI+DWzh
	Dz1FfPcamF+CvU=; b=XsrgFca1Aysfrwdc6K1+dC0MxvNFx5WAYYtPmMqshH6t7
	rosRkcirIEDMgWPoRoXOZr3M3SYlZ/HV4uY4wcVL8193YX+77ycSE2EWqN9qFbDi
	pRsNKfaiKxlXJ20WLzPjJJqUNxVvKrdG8/mRPfWlpXFrIjFrF0wfbTBi3jajJ6xn
	VEGsQkqKJHzhHHlxfq/5Xdzzz5ladNYlv8cutxH/dd1QaTacxHv2SK4fbFHw0Wm8
	8vnLkBtUMoGe2eZcb2RbeXA5gYy1p0bpMbMzK15Jf9gHkyLhwa9ixQf3Zhoulefd
	or39+hqVbzodDLhJWWvMSgEVDV/DXefXuGOSRx0lw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53ur9sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:44:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEWPJU030950;
	Wed, 23 Oct 2024 14:44:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1max6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:44:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49NEiP91016804;
	Wed, 23 Oct 2024 14:44:25 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42emh1mawh-1;
	Wed, 23 Oct 2024 14:44:25 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Igor Prusov <ivprusov@salutedevices.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH next] ASoC: codecs: fix error code in ntp8835_i2c_probe()
Date: Wed, 23 Oct 2024 07:44:11 -0700
Message-ID: <20241023144421.1720234-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_12,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230089
X-Proofpoint-GUID: zId7C4s-5whJgfiO-z1nCfoess7VTI58
X-Proofpoint-ORIG-GUID: zId7C4s-5whJgfiO-z1nCfoess7VTI58

When reset_control_deassert() fails it returns valid error codes stored
in return, pass that to dev_err_probe() instead of
PTR_ERR(ntp8835->reset).

Fixes: dc9004ea273a ("ASoC: codecs: Add NeoFidelity NTP8835 codec")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202409281054.DUTb5KxU-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Based on static analysis, with smatch, only compile tested
---
 sound/soc/codecs/ntp8835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ntp8835.c b/sound/soc/codecs/ntp8835.c
index 800bda6b49dd..796e1410496f 100644
--- a/sound/soc/codecs/ntp8835.c
+++ b/sound/soc/codecs/ntp8835.c
@@ -428,7 +428,7 @@ static int ntp8835_i2c_probe(struct i2c_client *i2c)
 
 	ret = reset_control_deassert(ntp8835->reset);
 	if (ret)
-		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
+		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to deassert reset\n");
 
 	dev_set_drvdata(&i2c->dev, ntp8835);
-- 
2.39.3


