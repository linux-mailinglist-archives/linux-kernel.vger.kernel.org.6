Return-Path: <linux-kernel+bounces-529334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D4A42316
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84D37A976D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF04155744;
	Mon, 24 Feb 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GvyU8712"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51E23BCE6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407327; cv=none; b=l9wvTZhZHXDIhIZt6TultxG2fkFwhhyysgOpBZ/PCoI0jmPwWskj5gcAvVlpag4tmn7nRkIzH+pVmyHhKr5nEIuP6X03UH3qeaucZYBzC0ZDu3D0oHPWIkMB4JyevLrAHcsbhEtA741QaMcLbnGVGNf9KhzxnyvFvpFfdx0hY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407327; c=relaxed/simple;
	bh=mapRDN3HmNowumqQ4AbGWmkw1jGcaPY0QCuprNxO1Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHrjXbTWcr1JGFTwzXWqBA97sr1EnzYj8w7S3LzngfGxaZRPQ0NVPyXO8W6DTflV22FJ68L5Q5BwbA9woGI2+gB2vECkZEEn0R0FvOdsRwSxU02lOWM94AaSPV8s/yOUaaZXhfabg31A6lr83+omWyKYyPQLOzUQP2PV1Jztqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GvyU8712; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=vvliTZqkvFiLtaTFlSrVgIoli1W/zpsKrqdEP7k/+Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=GvyU8712glho1BNcs0stlsdMOQ78+YVZ27WpqajF2AaqRFC4US0LiOOHXJk6+JBxE
	 T6oK3/CQpCZjhP4RVHJACQGfkS8Hh/Q0F6i5g9tK04YVZtqQIpg0XjCmQFJmfRpfdY
	 jsGUGmV3LEiHuBALPqayQXlBen6SuGnogz/j+uJFI7aZvJPrkNRPtjKrJeH+nJyjMd
	 Vrt4HnKoJLA6XxKtMt7IAi0ZN7jmXAULp4yh3TReNVEEphZfbTgQRsj3LnTuggee0B
	 C70FdWHQUXqCP9RIL6+GIR/+6ayA/+laW0hvNDZQS1WbqvT6Hv+PgiqcnVQUschUKk
	 PG2ElWrUTtBzw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id D0C344A0437;
	Mon, 24 Feb 2025 14:28:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 24 Feb 2025 22:28:01 +0800
Subject: [PATCH 5/5] of/platform: Do not use of_get_property() to test
 property presence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-of_bugfix-v1-5-03640ae8c3a6@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
In-Reply-To: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Gg8-Nbpk663mvUZGSILliK5xphjlUl91
X-Proofpoint-ORIG-GUID: Gg8-Nbpk663mvUZGSILliK5xphjlUl91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=670
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502240104
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Use of_property_present() instead of of_get_property() to test property
'compatible' presence in of_platform_bus_create().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c6d8afb284e88061eb6fb0ba02e429cec702664c..242172e4b8757eec9a7ccb413764b475046dbae8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -334,7 +334,7 @@ static int of_platform_bus_create(struct device_node *bus,
 	int rc = 0;
 
 	/* Make sure it has a compatible property */
-	if (strict && (!of_get_property(bus, "compatible", NULL))) {
+	if (strict && (!of_property_present(bus, "compatible"))) {
 		pr_debug("%s() - skipping %pOF, no compatible prop\n",
 			 __func__, bus);
 		return 0;

-- 
2.34.1


