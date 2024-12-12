Return-Path: <linux-kernel+bounces-443304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960C9EEC15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D9F2831F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70C21E0AE;
	Thu, 12 Dec 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Xe+22TEh"
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF832185A8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017427; cv=none; b=h6YBlKSZYigOFco2sac7eTr6kk7dgbeMhzsPdK6lz3Sc9DWMod12dus7ZSnzP7yAQPGZC6ueQDzwPeaSAmsOw7bT5G2lSkmQ+kb9f+UIjjePRjYJxr5A7GET1JAvon0zsCuGUQa8uw/A/looI9YN+BimszLoGzMsUD7i8oy7cyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017427; c=relaxed/simple;
	bh=HVk0QKjL62NPOUjJQrE9JQALgT+9aa0UmJ3UcU7Wy70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f/E4LW0hVwxepAyITBCtZQm4lalbdB3/okYTRhAdHRYPto7yESKMCVqGZRxyxWcXQktD2VPn35/tLreQOj59Ijd1MO1AGseTU/jXcpF1b/3OmlLnnOUSZmmq3KSoU/NujaLVhQnMQzGXS94DxkGPOZSgQtBLZw++3NJHNr8wXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Xe+22TEh; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734017424;
	bh=Cctk2qAtwnvI3xFZ/EVdw7MBeOFHAX5H/Kag2fyVKw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Xe+22TEhSI8uDO5pfVRBMl3ASKjYouXoOjudrw5iyZMZh4VcNHhZ2qdTQ/t1X9zCO
	 SIrhl61qzq5UHFdSoOJFBtnIU6lkkzw/QP+xZ9Rxn04P79xGJVvg6wy0y2hZq5yxZv
	 7+A5H3Q7g5AJtAmrXluXQ2WRYCN13PZcY+86dOqJS6i+HmlgtbQunCm8/w6tZN5yR0
	 69bDmwTBso0HRutqQ8O+W80flV6Wi2ZanUDGGIGi1FNG34pVBDmM2CcaeRHuXRoItq
	 FtKcEtXS6bgVn5lfT1tFi8E++KRLQZRuY+a1P0Mn1T+RmTn2jxMkyrV4eLydo4WRDf
	 UjTBuE6OcFQug==
Received: from [192.168.29.172] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id AB15F305885E;
	Thu, 12 Dec 2024 15:30:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 23:30:05 +0800
Subject: [PATCH] USB: Optimize goto logic in API usb_register_driver()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fix_usb-v1-1-300eb440c753@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHwBW2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3bTMivjS4iRd0yRj81TDFCNzY4MUJaDqgqJUoBTYpOjY2loAAqD
 KJ1kAAAA=
X-Change-ID: 20241129-fix_usb-5b37e1d2730d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: cIdlUipoE5S9mFvj87-bnH82c39O8T4o
X-Proofpoint-ORIG-GUID: cIdlUipoE5S9mFvj87-bnH82c39O8T4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=851
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120112
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

usb_register_driver() uses complex goto statements to handle simple error
cases, move down the goto label 'out' a bit to

- Simplify goto logic
- Leverage pr_err() prompt for driver registering failure.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/usb/core/driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f203fdbfb6f68e6cf52feb077f042045cb9bf3a8..460d4dde5994e783bdcad08b2abb6bb85ab3258f 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1086,15 +1086,14 @@ int usb_register_driver(struct usb_driver *new_driver, struct module *owner,
 	pr_info("%s: registered new interface driver %s\n",
 			usbcore_name, new_driver->name);
 
-out:
-	return retval;
+	return 0;
 
 out_newid:
 	driver_unregister(&new_driver->driver);
-
+out:
 	pr_err("%s: error %d registering interface driver %s\n",
 		usbcore_name, retval, new_driver->name);
-	goto out;
+	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_register_driver);
 

---
base-commit: d8d936c51388442f769a81e512b505dcf87c6a51
change-id: 20241129-fix_usb-5b37e1d2730d

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


