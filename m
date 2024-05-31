Return-Path: <linux-kernel+bounces-197570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA38D6C93
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721CB286165
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069181AD7;
	Fri, 31 May 2024 22:44:42 +0000 (UTC)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69C81730
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195482; cv=none; b=U6N/IuhQfu4TFvOP3767L4qF7gpXzTwy/7XNymMeBcOh/c6CZCWLVl5suKnI//5ezsE4F1ymOaUFyq8532c0AHEBOfopLFahuAcmTAueoqfeujWNVhoH9/FCsHMp1u5WoHBoh5+nkVWrR38YypXchq0nhlLQBr2d/gS/avsBFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195482; c=relaxed/simple;
	bh=sWPIj3ckBZI10Hnygx2NOzfdvE4v56Vx+HGpCcUYPT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sf/AobrANg2jm5Lz8SYYhKLXXtfNJBuh64Vu90qRUL8EsXieUMIMdnD8ypslHey7Cwdzo/A1eC6fKYCGjrmMUkgNENa2m+8Snm7RQFaSzwhzGSLZ1/lkfKfNcYKeJyQrCA1dLrj/HS92jN3mfNJHiArsnLdjo9KRsL32WlGiEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44VKeKQr006533;
	Fri, 31 May 2024 22:44:31 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dhpe.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:date:from:message-id:mime-version:su?=
 =?UTF-8?Q?bject:to;_s=3Dpps0720;_bh=3DVx6JoJ4VI0e4C9Ieoj7qbwUrOQgHwUd4bcK?=
 =?UTF-8?Q?0druKUJE=3D;_b=3DNPPArVP72NXvUvvhVXuMUPUqDTBrUKy9dT/gXT7MEwCQpj?=
 =?UTF-8?Q?LwluG3yL3XzXPda2GvtdK4_98kYB8RuUIaJD4nIKIttprJoG8uLopFiCwIN3Ojp?=
 =?UTF-8?Q?kLmPRVMONU3mm4U+VydP/sk/+oRt_Lq97pkv9orWz6vDT0goPYh3TWpAO1eD0bB?=
 =?UTF-8?Q?ae+VGq0gyHybqC4qO85WHPmEheJ2+Hy+cK_iruTdMuepL0/MHZXPOUJwaqM1Iul?=
 =?UTF-8?Q?brWMxd118BDN2rotInTjndBlQ1muqU+5WfnPsTLG_rs+odFvee7C2rJ5J0o0VCj?=
 =?UTF-8?Q?92WOYvwlunpQKqrBI7zTQbxZmyE+3iUJSMnwDZBzCJA+Gs_Ag=3D=3D_?=
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3yf67j03y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:44:31 +0000
Received: from hpnsw6056.rose.rdlabs.hpecorp.net (unknown [192.58.206.38])
	by p1lg14881.it.hpe.com (Postfix) with ESMTP id B84B4805E9C;
	Fri, 31 May 2024 22:44:30 +0000 (UTC)
From: Curtis Klein <curtis.klein@hpe.com>
To: giometti@enneenne.com
Cc: linux-kernel@vger.kernel.org, Curtis Klein <curtis.klein@hpe.com>
Subject: [PATCH] pps: clients: gpio: Continue after failing to get optional ECHO pin
Date: Fri, 31 May 2024 15:44:11 -0700
Message-Id: <20240531224411.3515712-1-curtis.klein@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lcuGxPxzCKkRoN12KtqAhGjK6amCZcCA
X-Proofpoint-ORIG-GUID: lcuGxPxzCKkRoN12KtqAhGjK6amCZcCA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=788
 spamscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310173

Warn but do not fail when devm_gpiod_get_optional returns an error when
trying to get the ECHO pin. When creating a pps-gpio device using
platform data and GPIO lookup tables, the call to gpiod_get_optional
will match on the unlabeled pin meant as the input when searching for
the "echo" pin. Since it is already in use as the PPS input, it will
fail with -EBUSY. As the ECHO pin is optional, we just warn on the error
and continue the initialization. This allows us to support devices
created using GPIO lookup tables instead of ACPI, DT, swnode, etc.

Signed-off-by: Curtis Klein <curtis.klein@hpe.com>
---
 drivers/pps/clients/pps-gpio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..b7db4a3ee97e 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -114,9 +114,12 @@ static int pps_gpio_setup(struct device *dev)
 		device_property_read_bool(dev, "assert-falling-edge");
 
 	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
-	if (IS_ERR(data->echo_pin))
-		return dev_err_probe(dev, PTR_ERR(data->echo_pin),
-				     "failed to request ECHO GPIO\n");
+	if (IS_ERR(data->echo_pin)) {
+		dev_warn(dev, "failed to request ECHO GPIO: %ld\n",
+			 PTR_ERR(data->echo_pin));
+		data->echo_pin = NULL;
+		return 0;
+	}
 
 	if (!data->echo_pin)
 		return 0;
-- 
2.34.1


