Return-Path: <linux-kernel+bounces-331959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F2C97B372
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE991F23D09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5718E05A;
	Tue, 17 Sep 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xg+cFc3B"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBA181339
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593423; cv=none; b=URJO4WL0pisJBXLYYQTbpCV7tGDEXY5hUkzMlndedoBncE+6gRElLnP36eKO5cWbgDMSWWxOA+AO9XQQIKhFQey+RPgRikmC6qvhNceqxatRdboO4+0W1Z3EFSAnwnT6URfYv4RbHHGZhplrWDpZf+DxqN7whj95yHutS4Pfqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593423; c=relaxed/simple;
	bh=v9lP3LDc0A27jTbdyuIFtQjxcl9DZISNvo/u3EtcGIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ork30OgJJh7oFFlNZxne4ByNc7nVXzYUWQOGQfU501Qd4rp8UAbEWoF28aSHq/GuifA9MPdwhLNf33C68nIjg+tehsScNC6nmA+Dj42orONyAZ5mf4Nfbew7tmaA471xN8cJafETCjGz4xra55oG7aO8n0dta4UWlCqqBZj0fG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xg+cFc3B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H9pkd7022492;
	Tue, 17 Sep 2024 17:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=dnGqzXOeX4T8Q
	hvF6PDp/id4OxgamrxvQO99vsDWvIc=; b=Xg+cFc3Bhy3bq3PNYOapIfw4KW8eZ
	ow8KN07jmcs7X6y5/Tk8JbtnqDmWpqcOEqHqKkUXN50/9+pHeEtdZ13L8/11MGMh
	qJcj03+r4ZcM3kvk/4G+asLcVnFFf3mO/OWh1BOXnO8Fiwgv2pAiKJHBjZemqu2Z
	GMrIzsa2Kk2CJh3KHrF1lNJQ9x+77w+UaykOXC42heyvwOlz87BSZGNGhvAxYFmk
	qegQbGeNw89SRi2N2oGuMwttGztOA1QHevRDJRTPpwzizPn/gi9hl8Nv7GRJB+qz
	evP75WFhsMQNzwK7C8XYU4OBcGQI3UM43+8xQ20IM3kJW/DleShp4zo9g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud9hgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HGVuB3025033;
	Tue, 17 Sep 2024 17:16:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mx7ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGpeA23658906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EDDF58057;
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B0A58059;
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 15/15] fsi: i2cr: Reduce status checks for read operations
Date: Tue, 17 Sep 2024 12:16:47 -0500
Message-ID: <20240917171647.1403910-16-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917171647.1403910-1-eajames@linux.ibm.com>
References: <20240917171647.1403910-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eguy6qpgCxaVN2TdNyw2OM6_Z2OcTuhe
X-Proofpoint-ORIG-GUID: eguy6qpgCxaVN2TdNyw2OM6_Z2OcTuhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=896
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170122

As an optimization, only check the status register if the eight
byte i2c read operation returns 0xffffffffffffffff. This indicates
that the I2C Responder operation failed and the status register
will provide the reason. Otherwise, the operation was successful,
so no status check is necessary.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-i2cr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 61e55740946b..44dbc7029942 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -145,9 +145,11 @@ int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, u64 *data)
 	if (ret)
 		goto unlock;
 
-	ret = i2cr_check_status(i2cr->client);
-	if (ret)
-		goto unlock;
+	if (*data == 0xffffffffffffffffull) {
+		ret = i2cr_check_status(i2cr->client);
+		if (ret)
+			goto unlock;
+	}
 
 	trace_i2cr_read(i2cr->client, command, data);
 
-- 
2.43.0


