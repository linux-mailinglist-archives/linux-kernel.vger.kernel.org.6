Return-Path: <linux-kernel+bounces-551110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D4A56851
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611EE7A9957
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC68219E9E;
	Fri,  7 Mar 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tDg8pN7S"
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D221ABA6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351826; cv=none; b=Bvz/d8G0WyZKwBUoNnNU8P7A/DrZZhvCsQ9n3139cw1EmbqOukSd1COflpjfmiB3k2lLQtPfNZgUARvsfG1jCmxCzz0lLG6yT4llpwlwTXIT0VEYWJDa0CPOEsMmds2FF4DWeR9AeSlSi1TR4aBETptDWZifahaJt3KwZ9S4o5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351826; c=relaxed/simple;
	bh=ki2B8HmLzHt7SFGIKrwsoRPEZdjP8OBV4OmH0Gi+Xb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h7ubhY4IA5Gle+MVKRoxIiyEKxTWfRM6gPOl0Vjvv6mdPFArpkJtp8AUE8cj6GP8Rxj7RhMxShGkVYZ4RgOgw+OOySmRBFXqueyTmZqLIV83GYMttSZAALRQcoUdLJkxu19lOtWfJpbKQ/uRi5FkfJHI6vSExE6GqoMKFE/78TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tDg8pN7S; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=gUs8XrpApCfd2Rppq+ZXU8/T5MPfQ+c1pN1GeAjxBjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=tDg8pN7ShpHmm2rP4jh3CuAZBPYJB8YyQ3pKikjkcY8gekrCEvM05MGHprYsYHET3
	 7iGyPcoL4/iAcNQlyg2fJSKi0E/mNo9SXC4ZWn6g5bzcWupfI+beAyAZ6OMc7mh97z
	 WTqj4Or3Lqh6KaKpxUQSTM+CxTtCAX0O3UV/z7V3gEOWRqWyOrzesziynfFeKmew0I
	 MOlM7arCk97dyuo7tmxuLAXd0nlemvpz7X1IMZ81100kjs95EVSTRVQpvxA/wQ4ScA
	 saMBAHSGSx/5nUfy0eQvt+riRMKgmgOh6yiEkX95qXaGzovyxBp7RljYTfNWl6pQGJ
	 FybbisIEXbj/w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 6B8A03118BB4;
	Fri,  7 Mar 2025 12:50:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 07 Mar 2025 20:47:16 +0800
Subject: [PATCH] driver core: faux: Check device binding state by dedicated
 API device_is_bound()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-fix_faux-v1-1-91459764575e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANPqymcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNz3bTMivi0xNIKXQMTI4M0wxSL1OREMyWg8oKiVKAc2Kjo2NpaADa
 lKLFaAAAA
X-Change-ID: 20250307-fix_faux-0420f1d8eca6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: K61dMBVy0T_lXYoXmkWjQnXd33LrcncF
X-Proofpoint-ORIG-GUID: K61dMBVy0T_lXYoXmkWjQnXd33LrcncF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=682
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503070094
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Use dedicated API device_is_bound() instead of 'dev->driver' to check
device binding state in faux_device_create_with_groups().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/faux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 407c1d1aad50b7969a6dab9d2027d8beab66a754..76fe494a128254aaaf1339386ab37817a732781f 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -154,7 +154,8 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	 * if not, let's fail the creation as trying to guess if probe was
 	 * successful is almost impossible to determine by the caller.
 	 */
-	if (!dev->driver) {
+	/* Do not need to device_lock(dev) due to no race here */
+	if (!device_is_bound(dev)) {
 		dev_err(dev, "probe did not succeed, tearing down the device\n");
 		faux_device_destroy(faux_dev);
 		faux_dev = NULL;

---
base-commit: 21b0dc55bed6d9b5dd5d1ad22b75d9d1c7426bbc
change-id: 20250307-fix_faux-0420f1d8eca6

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


