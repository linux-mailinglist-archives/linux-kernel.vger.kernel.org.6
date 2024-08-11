Return-Path: <linux-kernel+bounces-282107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54E94DFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3CF1C20CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0BD134405;
	Sun, 11 Aug 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="feyJhaRY"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE53130A5C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343190; cv=none; b=szfm0asXzJheFJWkTbOw438V7xVXAMUKK6pKOm9WbkpUjQuizjPFYrDSmu9ZBwX/OIMaJphXOHpvQyivyacfZEKdf5kNX3hSES/A4NViNNQY07MvL6I0CX5yf28vXdRSAt4oIysxo8N4rrVy3hs/zYMwOvfJh98PRI4wIFEd0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343190; c=relaxed/simple;
	bh=AhZ05ozCUecwRCBlwSgVawve6lwbY0vKM3Py3AxLPLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMZnEvuUWIg8UIWO71Zp0ajohgbVDFwdgWaf2tzD7iupIrCNvloMS3So8FA6VvRb6zRDHmK2puBdz0F9eWJWJgUxcHnX9Vwzdluhyl9an+iiuRvWZUfFkRyeAbEK30EqJm4fYsnoTToK6xxUVqiUwEUwXxbAsw+PaqkCSqpLUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=feyJhaRY; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343188;
	bh=9ViwxDuDdvmHAXDaL9naGiKQC8nQq8UohJZLmHzKyi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=feyJhaRYN3+bdp+f5ib8fJLJwqsbz11BHyGGz33g3JOLubtGjvnMYndwrQBsN+KrX
	 /Pd7JxIwwg4DyZnCigKTaiGkj5YVQa67Y3LFPxTY/X2u4HSfPHwE20ow5lYRch7Sy8
	 xP1iemwMIgSAU/e4SScMk0EBTyeoUh28riTH2rLSg5JEhfWyZTD+LySKrUrJSfVNKC
	 lq6DPimjMwGmvX41981HUvH8eb2Jak50Cwi/Adm49vz9iAzlMdMjiKCu9VDvEYSsqX
	 gBEitzak1nKZGTHTsAE++HbBQft+xF7VUeNLwq0s7NrKG1q7zMbsC90Y7f6tcqTsuK
	 cncT07YZA/qtw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 9EBE91349C17;
	Sun, 11 Aug 2024 02:26:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:10 +0800
Subject: [PATCH 19/27] firmware: arm_scmi: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-19-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: ljX435Lpl225rlIbD6jtJOV41yzzdEv6
X-Proofpoint-ORIG-GUID: ljX435Lpl225rlIbD6jtJOV41yzzdEv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=952
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
scmi_match_by_id_table() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/firmware/arm_scmi/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 96b2e5f9a8ef..14c2cc141d8c 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -238,10 +238,10 @@ static int scmi_dev_match(struct device *dev, const struct device_driver *drv)
 	return 0;
 }
 
-static int scmi_match_by_id_table(struct device *dev, void *data)
+static int scmi_match_by_id_table(struct device *dev, const void *data)
 {
 	struct scmi_device *sdev = to_scmi_dev(dev);
-	struct scmi_device_id *id_table = data;
+	const struct scmi_device_id *id_table = data;
 
 	return sdev->protocol_id == id_table->protocol_id &&
 		(id_table->name && !strcmp(sdev->name, id_table->name));

-- 
2.34.1


