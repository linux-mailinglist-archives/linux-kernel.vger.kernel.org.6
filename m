Return-Path: <linux-kernel+bounces-447199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E39F2ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641AE16670E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52F204584;
	Mon, 16 Dec 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e8M2/1+f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A32040A1;
	Mon, 16 Dec 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347060; cv=none; b=YMjhKu+AsrK2mTbfLCzBWDRnl1UYuOsLn178J8vPJQzIOVWjVTjmAXicuJU2FEJZC7ZNAHhNMpCPl6KlhyFwKUXfZ/xKyO36uAetujYdoqWdMdyHKrwhrRVx5PCKvUJy4bIY7U9cabPK09SxiwJeUak0TGFF185YZP6YboT1ClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347060; c=relaxed/simple;
	bh=PodrToQcpndsqzWfwGjN3f2AxoazqFYE2Kqd7IJ0G4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NbOX0JQR1t195fYB1mdHI5zrsgzIxt8Ysyo//dJa8eZUbXhRR0kMb8V+VLRJ3xe9m7ecmjgK+YW2DDY7altXNAaC93avlCLSz8e8utFm7GC0o7GNQySNWPmMS+4IK5s3uC8FtaPH2P6BHlbs2dJWjMhUahd59rsbon09sM3XvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e8M2/1+f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5RsJX017506;
	Mon, 16 Dec 2024 11:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Hye8/Gs4paw9AVARMgrw3wl4Sef/conbSjFvvhGsjxQ=; b=e8
	M2/1+fQH4JkQvsEaCoWO+63Xm9VGGJ69u9G4g4kUJKVJ2Ell9WYAecHO7a+fuKOU
	cV97TnRFqOt2yjDzrUrRqOOtkJfV2MOAjSA+ZwNl3256dkPqVR+Tot1pDC4FOiih
	88Wqp+nM6iLlHTACrD0N92evlw8b7EgPtzvryaSa/h3hFeKpQYJvIxVgBkdCI5xU
	cXzrTK6uvojBhzJpZ3Cp9tCTA+c56zipqTLO6oQOwxr/9LmVuV+ZHUuaZl4ObUda
	Js4lwo0WXlS7UgRuksoBMm8OGXzjk4hK10Jy7TE7GaESEWiHe8QGGgd4uIQ2Ms62
	UGfSc3tHhlR0cxcswmyQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43je3010pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 11:04:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGB1R2f009444;
	Mon, 16 Dec 2024 11:04:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43h33kna2x-1;
	Mon, 16 Dec 2024 11:04:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BGB41tL011357;
	Mon, 16 Dec 2024 11:04:01 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-pkumpatl-hyd.qualcomm.com [10.213.109.81])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4BGB41H3011354;
	Mon, 16 Dec 2024 11:04:01 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3914174)
	id A4BF45001BF; Mon, 16 Dec 2024 16:34:00 +0530 (+0530)
From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To: Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mohsquicinc.com@qualcomm.com,
        kernel@quicinc.com, Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH v1 2/2] ASoC: sgtl5000: Introduce "mclk-rate" Property for Device Tree Configuration
Date: Mon, 16 Dec 2024 16:33:41 +0530
Message-Id: <20241216110341.3707-3-quic_pkumpatl@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216110341.3707-1-quic_pkumpatl@quicinc.com>
References: <20241216110341.3707-1-quic_pkumpatl@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4SisbxiMHLvXV8f0PlA6fxH2osPd-58r
X-Proofpoint-GUID: 4SisbxiMHLvXV8f0PlA6fxH2osPd-58r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160093
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce the "mclk-rate" property, enabling the configuration of the
Master Clock (MCLK) via the device tree. The Codec Slave supports
a defined range of frequencies, and users can request the desired rate
from the Master, using `clk_set_rate()`. If the property is not specified,
the default MCLK frequency will be applied.

Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 sound/soc/codecs/sgtl5000.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 7aa89e34657e..7e134a3219c7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1615,6 +1615,16 @@ static int sgtl5000_i2c_probe(struct i2c_client *client)
 		goto disable_regs;
 	}
 
+	if (!of_property_read_u32(np, "mclk-rate", &value)) {
+		if (value > 0) {
+			ret = clk_set_rate(sgtl5000->mclk, value);
+			if (ret) {
+				dev_err(&client->dev, "Failed to set mclock\n");
+				goto disable_regs;
+			}
+		}
+	}
+
 	ret = clk_prepare_enable(sgtl5000->mclk);
 	if (ret) {
 		dev_err(&client->dev, "Error enabling clock %d\n", ret);
-- 
2.17.1


