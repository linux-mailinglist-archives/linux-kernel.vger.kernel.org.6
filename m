Return-Path: <linux-kernel+bounces-520557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21DA3AB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D156F1897F13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71511D61B1;
	Tue, 18 Feb 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="axsDoCVz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69071C701A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916613; cv=none; b=HYTYfNdQeMH7S2td5JcqMfsyzmN9gFNwtnqNkpJXTuEB5uPv7q9oTml8TmpPaLtXXFzleJW2MIzlSGNGQD8I6nEtFfCF2BpqabN3XQi01FddOHuwiQsnzWjTQOI1JEIWDgWSI8fEpyriS+BsnbcrvYNVOa5ZnTH6Ifm1Y1aSR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916613; c=relaxed/simple;
	bh=SgOfmhjNmzrC6xVsZvSG0cd0Ha1NK4tnIIitV/UgBPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZN0eSC4jk39aX4ooPkEd5O9Gryy/c4tj1t+zWwGSSGps8zJVQIlt360TIj+CBBIejAkllNnAKQo6XxKXzmcnhPrSBfXQmmCtPcDaprkGq5r9CRu+ihK/sOv0Dsoq6jw/Lf7hW//e/eHbC3HgdlbfoIXqmRW2QYtxRWTJvmjjT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=axsDoCVz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIxgki025477;
	Tue, 18 Feb 2025 22:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/plLf3kPn9dNPbC1Yfkv6XWIvd8CxUdbEsg8CtzJX
	m8=; b=axsDoCVzeeCfpc5OGQPykfyIvevZBAjUwfWW1cQ4JDWTFPbBpJKmYqpfF
	ilKUCwvMfuSl4UvjUUfAQEV/xI++OAP+J9ZZlwBwLNK0bKyYEL2haaKc+eREdf/4
	TBelGbQLEid8xSirclKitKpJF53MVYnZ/RFTIZv5+03uoA9isipQ8a2OtCq3iRna
	fqkYFSJdoW7JyQPT+EQNxzhbEiwQUQLNTtbiTYlXukhi/zZfLI+LacV9eSrTInJo
	RMv+YjzTlv5CtgWC/rQelRCxSAUCEqJNKu6Mz0Lj1xIwuNiLeVpa1kTtcvSL9FOK
	11GZpIqU9MwezE708UJL36hXU/c4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyynrr05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 22:10:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ8hVw002330;
	Tue, 18 Feb 2025 22:10:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03x0q56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 22:10:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IM9xUo49938762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 22:09:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E0CF58043;
	Tue, 18 Feb 2025 22:09:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 568F958059;
	Tue, 18 Feb 2025 22:09:59 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.48.195])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 22:09:59 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, eajames@linux.ibm.com
Subject: [PATCH] eeprom: ee1004: Check chip before probing
Date: Tue, 18 Feb 2025 16:09:59 -0600
Message-ID: <20250218220959.721698-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dzwU-RlyWVXJFkgFo32xKRMg6HFgEBSD
X-Proofpoint-GUID: dzwU-RlyWVXJFkgFo32xKRMg6HFgEBSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_10,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=900 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502180148

Like other eeprom drivers, check if the device is really there and
functional before probing.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/misc/eeprom/ee1004.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 89224d4af4a20..e13f9fdd9d7b1 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -304,6 +304,10 @@ static int ee1004_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_READ_BYTE_DATA))
 		return -EPFNOSUPPORT;
 
+	err = i2c_smbus_read_byte(client);
+	if (err < 0)
+		return -ENODEV;
+
 	mutex_lock(&ee1004_bus_lock);
 
 	err = ee1004_init_bus_data(client);
-- 
2.43.5


