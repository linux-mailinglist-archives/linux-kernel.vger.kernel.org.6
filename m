Return-Path: <linux-kernel+bounces-222089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F132E90FCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27022B23B84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909473BB48;
	Thu, 20 Jun 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W+wzj8Qw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8F1CFA9;
	Thu, 20 Jun 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864960; cv=none; b=rD3H1tuUSTVB2ct/IVHYVx1Oj6huU/cyvOAL/K5/m/q/oKrsw+gTnBqGWreHi5OldxDtOSCIqVbd8/TB7MhTqyUx80os+UknaYwbvfmIamnfzC26N1+V3DSXrGi0/EJ0c629ZrViUIvRC1HVxs59MSYV4cvfjLVob8RmBLbG6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864960; c=relaxed/simple;
	bh=AJU+IcQK9TNFEQT1vsa902xQ13yY9qya1GOcSpNF5Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cb0rdK/WoNYkhzjQGQdgezkLfNd7Ty+wSWzXxnkvrY354Oh4mXXATPLNCq+U4TMhqcOYszrVwuXxiUq3JENZMTDEYYWWVQJx4EsadbzuQxX/8Ys888Pgq6rwHLW1GQ8dBTL5WxiMkqZlxkSKgk9H7/hCwyMQYIbqZsmz+PXVBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W+wzj8Qw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K1NcKF024459;
	Thu, 20 Jun 2024 06:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+iJ+ZcNNMMRRyKHxGbCQrp
	ouL0wP99StKm757wGOd9o=; b=W+wzj8QwzY3J/GDwd0vsGFgW4scH805NqRnJSB
	MsmUkG83WXzVzdP7nbtRtp5Lg+et3hgdYiUZuOsC2XkVfs7QO/snt5BaC1X00Thd
	5uGjI7HAnqNotM1GDqoCs62YLqexpOF1YmOZu03qdec+LwU1IkYNTphl7YblNV+k
	JQhG/GA8WZ8IIwNmrpf34rSOZ9r2L5pdaeUEEW56IjW+7heuFwmbgUAIWV1RGN/g
	Fvp3uzpFrW8JlvdnakDzrc/fDwTUSfJqkswl3dkcxi5POihq/xLwHClA3EibSjAD
	nurLevnkk0AKDhwKkNYikEHPlrhhYNPbilpQu1BGpE1Pq9Hg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvaqbrhee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:29:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K6T4Um007576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:29:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 23:29:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 19 Jun 2024 23:29:02 -0700
Subject: [PATCH] drm/tests: add drm_hdmi_state_helper_test
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-md-drm-tests-drm_hdmi_state_helper_test-v1-1-41c5fe2fdb4a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC3Mc2YC/x2NUQrDIBAFrxL2uwvRlqT2KqWIiWsVGhN2pQRC7
 l7t3xsezBwgxIkEHt0BTN8kac0V1KWDObr8Jky+Muhe3/pBGVw8el6wkBRpy0a/JCvFFbKRPhu
 xbR+OehxIm3C/KgPVtjGFtP9Lz1flyQnhxC7PsfmbM6yMmfYC5/kDtF1hyZgAAAA=
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Dave Stevenson
	<dave.stevenson@raspberrypi.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gx46bUwopQ1zNNN4zwehclrcZ-GSZXR_
X-Proofpoint-ORIG-GUID: gx46bUwopQ1zNNN4zwehclrcZ-GSZXR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200045

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_hdmi_state_helper_test.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Fixes: eb66d34d793e ("drm/tests: Add output bpc tests")
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 2d3abc71dc16..34ee95d41f29 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -1740,4 +1740,5 @@ kunit_test_suites(
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_DESCRIPTION("Kunit test for drm_hdmi_state_helper functions");
 MODULE_LICENSE("GPL");

---
base-commit: b9578c49456340ca4d3c7ddbaca054ffc2b51bc1
change-id: 20240619-md-drm-tests-drm_hdmi_state_helper_test-7276e29f8319


