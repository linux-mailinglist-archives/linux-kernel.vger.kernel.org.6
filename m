Return-Path: <linux-kernel+bounces-212314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63D905E60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AFD1C224C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1312BF32;
	Wed, 12 Jun 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z1ApWSwz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C21DFF0;
	Wed, 12 Jun 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230978; cv=none; b=ijARZmNx3VaHuFSayaHZhofVwQOzDXX0XsJpeWYJcdEqFAccVqEtYSvfRNQ7B10ahxMrL9RRa/pLTBebPHA50moN2xkyT17XSnFY/pAJSdd8I3mWHxFKwXCauM1/IWut6QatlogeKZc6OvANEsAl4PcZ5Du2pBeVlSTydwLo//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230978; c=relaxed/simple;
	bh=kjGjPKRkxzNWFzgE6y4cA/bYXf9LyB4+K5/alp3/Ne8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Zj84ONjvxPqDVVMLWjDaIr9QZNqkq5PF5LbNkckxa8S9xr5xPx6fAH9KREV2K1DRWX0TaMezs7n283MBInzP8tfBEeYV9+ZIgH1SbzqSIvARJuyDeJYcGMHtJbCMcUmDborW3LBWNSZnt+qsyjr180nRUvuYG5hhHTGqFj6RF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z1ApWSwz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKnJKr024376;
	Wed, 12 Jun 2024 22:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i6UukDRRZJzedinienBhid
	zn17tHAMUbF3e55BtT55Q=; b=Z1ApWSwzuXF/KQc/9Dv2RhCvimvC6xs57zRfld
	mLNRiETzBed6Pk+oMkksYKEtL1DtbMpSU7fuUVGfXy1Rp82rAF6v9I+FCADQINLl
	FJuc0Ll0bYRIZLat9ESinxZjMjYQtHdfEVY29dmCvEPZtL0UNWVTPsOpND1YEbaT
	rEtnFUgERWVXZiO2HpsrdG3z7xP3tQRggEptH9cZd1yqBIHiRpuuzoSibSOUMTJH
	hxOJBwsVh7hU6odeet6tnVbYe8moYcHDmuXi2PW+BgpTPKXYx/hbCJ06Q/6PRFMt
	Fg2+pufbKY3PbMgzX9fkR/JiMjQLRBWzsaZvSEX8rlAmlx0A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqcxthb6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 22:22:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CMMqLM028847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 22:22:52 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 15:22:51 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 15:01:11 -0700
Subject: [PATCH] fbdev: goldfishfb: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-drivers-video-fbdev-v1-1-68b1f7316835@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKYaamYC/x3MwQqDMAyA4VeRnBfQ0gndq4wd2ibOwKwjmUUQ3
 33djt/h/w8wVmGDW3eAchWTtTQMlw7yHMuTUagZXO98Pw4OF0JSqayGVYhXnBJxxZwC5dGHHPw
 VWvxWnmT/j++P5hSNMWksef7tXlK2HZdoH1Y4zy/JL2l4hwAAAA==
To: Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _lw1Ga2g9ZjHDXoZvWK77lt8G-CYap4y
X-Proofpoint-GUID: _lw1Ga2g9ZjHDXoZvWK77lt8G-CYap4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_10,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120159

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/goldfishfb.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/video/fbdev/goldfishfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index ca9e8255947c..5f8de1ec23c3 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -321,4 +321,5 @@ static struct platform_driver goldfish_fb_driver = {
 
 module_platform_driver(goldfish_fb_driver);
 
+MODULE_DESCRIPTION("Goldfish Virtual Platform Framebuffer driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-drivers-video-fbdev-cb9dc649c945


