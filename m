Return-Path: <linux-kernel+bounces-381633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914319B01CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F201C212F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDB2022E9;
	Fri, 25 Oct 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FCAag47M"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CF1E47DB;
	Fri, 25 Oct 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857663; cv=none; b=VNbvXgPszPFvhx/Nt+kVcsZ96hPOvOVdNFKyoCG31Awlw+R8XpwcQ0rAtpzylC+tERptKN9mX0oyRcKxBa5TxVXWxB8yK5qHafEgrZPV6Iv1+pdG1vhlFC8hwKAQOtplqOjauKhZ8RHt6nEz8kCVSgIeMr76mLAqx1pBCwR7N78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857663; c=relaxed/simple;
	bh=mEN1+3VhWjr5X3RuBbsVZ0hbnhfF1z7OWwlsV9ECEzI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqjjzilIhwdxmTSxppW9Z9h8co3EDKiFmJoI03/SOChgzt5oQyujqfs2iIsjLB3x1ePWmxenesmjPiDYVwNtrLKYhGs2cNt5zprSV4Wm5T5MlcYWCiFcO1EOKQRDwEMWTHhbfLiBUEjaMEQ6zWGjkyzvJuPn1ttn6XMRuBYyI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FCAag47M; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7Lp6K027923;
	Fri, 25 Oct 2024 08:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=JErI5NNee6NaaSl0zqZCyvKEi01
	/BOods/kMqUZjtQ8=; b=FCAag47M2ay6ezMVFpJX88/WSUOKUl/L4lMFgW4E9BQ
	alrxpriCRg/VIftqvUnU7x6PegRI0k5jrVNAeGNVtEvXUc8Oqg7IMvAmj+XdIaa7
	xGBbwoZsBm3e94ivjX2mAAgFPnb9h4cVqRwqu3XdLlgiNSJbAJnrPXULDLC2R1C1
	gTxpASCvcJ/hr53FO8c2d7hoEfVtY8zExnhnLiskEIW4kpfnztnO/Yy0atkeXTVw
	QPo6Tuv9jKaBE7JTiEpuMjbJZbDTnkIk+pctJEdpJEsf/Sc6oyEfp4Abzv0OPobz
	cpDZ6YjjKudtdFYt3nIGGc6zhV1EOJ9aeVwTbNjSp+g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42fjqqp1tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 08:00:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49PC0hSb045682
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 08:00:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Oct 2024 08:00:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Oct 2024 08:00:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Oct 2024 08:00:43 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.117])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49PC0XRs016585;
	Fri, 25 Oct 2024 08:00:35 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add Support for LTC4296-1
Date: Fri, 25 Oct 2024 14:56:09 +0300
Message-ID: <20241025115624.21835-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8vvpOwC_eONBbYm_4PqKy7MNUEjTv-Ak
X-Proofpoint-ORIG-GUID: 8vvpOwC_eONBbYm_4PqKy7MNUEjTv-Ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxlogscore=794
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250092

This is an initial driver support containing the features that are
used in current projects.

The LTC4296-1 is an IEEE 802.3cg-compliant, five port, single-pair
power over Ethernet (SPoE), power sourcing equipment (PSE)
controller. SPoE simplifies system design and installation with
standardized power and Ethernet data over a single-pair cable.

Antoniu Miclaus (2):
  dt-bindings: hwmon: add ltc4296-1 support
  hwmon: ltc4296-1: add driver support

 .../bindings/hwmon/adi,ltc4296-1.yaml         | 105 +++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/ltc4296-1.c                     | 644 ++++++++++++++++++
 4 files changed, 760 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml
 create mode 100644 drivers/hwmon/ltc4296-1.c

-- 
2.46.2


