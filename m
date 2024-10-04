Return-Path: <linux-kernel+bounces-349873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3D98FC89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1309D1C21E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817B53D982;
	Fri,  4 Oct 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Cr6KkxBG"
Received: from sonic314-22.consmr.mail.ne1.yahoo.com (sonic314-22.consmr.mail.ne1.yahoo.com [66.163.189.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1E22067
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728012966; cv=none; b=SgDXcv1b7iEY9iefOqOjGm8tS1hvITtsKJwpdRDrubgdwkxoAmaK6ZB6zehkn2CaWQc7twLRYT24n1c8pdlY3dLFih6XCufYbKxiIKeUyc8GSe1GtsvpwtnwZSdb5X5/stEA8DQp8cYd+9g8lFWMuVDLDs+elTgfBnSkmlgJWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728012966; c=relaxed/simple;
	bh=VJuuzroqJgZYENLBrsW3aheh2WTfa0sOcRL9hbIbKUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=HYiKx+wXvLWDhzCiE3HWYUELof2q6DmvQo9bLR4Pu+3yXN7+CumPNxFIwXFoP5Q3MxPrU1M6H8196llxshUX3VwruSnc3hN71ro5iisHxvYY/fj/K5nUmWwIA0z4B6hqR/V8MFDxxYM3BbqqDpYTuyqHRo5j5wmyLd2cg5L0exY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Cr6KkxBG; arc=none smtp.client-ip=66.163.189.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728012964; bh=fxOLENbaZk22qLVdZz3DCzbj36kx6WCUGmr+2MaK+U8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Cr6KkxBGzCw+X9/J+190Mg8FY6jKxG1Dj0rsZPHkg6NwI2snY33ozEvQeVmf2Xmvb9t2DMSnpcTig3GD1ScqktgEYDDUWUQxbGd7G0yPCLa1LyoXW3u589+hzU7fDeT7+M1LOb1cXGYGJDmzcCW8THJJqzEjXRRLm5LKQj6DTEujlktXNU/usEFsvMwiqh7Okrcmcbae/iULO3lesOdsv++YEbV69sFBOwPSlO8kxiwuTxWuIb67mLha+QUygSoxxoB39uUVtUusm+F7MOEuB1d111cUUcv6QWAJUk9hxI6MjEkIhWOD0r3agz+LO8zl0HVIq9lplHABpebqy1G09A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728012964; bh=Ser77fXLRxjJXREjUFK/rp6RhmUEwg4+1xIRNchgJlW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hc/9Y/bEIIop/3s4xzxcu1B8mI1RryOvWTNX8mUr1ds6wik2xgAf8UAkvPOj0YHBcjAkwZRS4fw7DDsYRWQiKRiZRe6hePzoNoN9l7RqhV6ZYihKx2RrfIMsQAG3Cx3ial/bKBgbNfG2dg9IgQVzru5qT/CUz39t0nKtHZSnuHPIo+V5c1lT2HOfc/8Fjf2A2zeHi9X4FHVyM40pFJADCI0dKrrq2eId1M1CR+f/2+MyDplRMn0rgsN9ADEdkcWpe4dP/2ePE0JFIxLaWD9UbYzmcM60D5rIR9kZPuL/VieT23oEP+v9jGQ2GpRzltkhtoIcOMfK7Urp9RNTw6a7zA==
X-YMail-OSG: xCE0O_0VM1n_xotxNcZHDv19peA5qp5wy4JsF8ze8yFcUc0YIOVGwt.6dzFIq_P
 Z52fsYrNv61YGF__DbjgNkEYykhuFJ1qTfO8YpBeEtYmd0hHI3bZ5iry54IqiJBv47Mgdx60Plmd
 AfHHKCQWw3trF8xxPZMUpAzw8ryRLJLdVyerJiHM_abK2NPGVcCJaxyCOjpNVmKOidF63RjzR4SM
 g16UEZkYHQ51tPb.ZW6lK5X_Keg21XUJ50eHDclD7AIFfTtozyaWKbzXsDtRMsiM53j.MoHL5bt.
 BgupeJVjoMN0fiQXq3Oxy5FUAtfso89MYiu0WkKAqfEuYd1lVxhtoXWAKZDtvQKAe3ZUVsCf8czN
 p6WKNO9j3rFw0HzsWiKfbKoxV5pRxtU2hbne1LXatKNgYyyZCP4Ioao0g993MQicZgF00MOa3ecr
 8b5Bmdsjmi_8RqLB65X_mhVLvWxB4lZZihPlDQ9RlY._L3cU7CeU5nwOOEF5ef8DZhgYF6Rnz9mg
 LqeRtsL1t8OkFEuFn0yr96robJMC0oJML..dh.qWB3Iw0VqyO4s2FPLRv6RzvfoWlfLwBH1qW8H_
 .SdeZrkn4Ms8LhSFWE0IH1KpWh2OEDRQA3eN7DoVqmtFTmfpeKDahCIrSE3Kx7kO1_F1lNho6crq
 2VskS_QnWXD.HcaUt.EwiStOCmCFzKp8thzFAILqTZpt7eEZSvbQxUl3_GR.EVAJPKiyy.rm.3T3
 m9um4c8mfNpmlJEQxoPZ28i_iVBR7JJjZAXUGeTnRH7LiOqwlP8iU52Lwm7W0vGva.KLk_O0LlvE
 5osZlHj.Nqc8qhxaBjs2oSkkEWPRhfLgtTBBT_lBvjUePoyJJmTgw1Tgk_iSsLwLuBziWTjevs0M
 qvgKM2gQb93P5NcdJSpKf7lFq5SnveCgbKGKYeNMN90AkA8qyDru51ujtFDYBnxu_R5et6ZtSdIZ
 yijs097FA51Zcc6osh9pKqQX2wDr8NUNkGL_UV4SufUG.7rlm6nEi7fQZDahgjOicngmCAn0r4bQ
 tgLAK7DP8mlP80TpIZ4gFJ8aeVPt_6yzj2fp7IqGVkJINp2yWHh59SdE92Yd.1s0YEVKihMs4RvF
 JA2_zMVDapo5D1UbqgAph.APvQQUSnYhiVT.rOjCODRLGCH7CvB4SYpW5MxgVDptDvq21He8K.Jo
 Jd7N8V7blO79BOCfqb60kQmXzRTgd5BSRQ67VW9xJXP9TtyGDBl5xJbByfQSKcjtxD5vGHMFc_qF
 1Q70a7BKb2SXo5TILXd6nCeqaMUZ0UnHyFPNSmUWN6qvVAddhHvQtisscv095Hku6qXADM_iEe1Z
 fW1TizvcBhtGT_u9EEURr2fw9ZYnmo4ZI1dPxFEuwu2u.a1.pT3L7ZYe_Xs9QSqeTmdGSMgXsqqS
 E6CeONvx_J3_HkFlaxnczzfXCOfWHWSElvTrlqOxxKMkuAjHDnzXFD6cFOds6gQwmGw04_RWFliV
 8kJfVh0y6RM.CZbc8aGHCjIy8Jdc_Hu6s7IXFR9NItH.fA0sJchUESqQqubQ4NZCnp8uzHNkuuB5
 AGA1dYNfuf1EvtxLdI5K.yPyFCS2K5CNqoAchlrMpZQ5mjR63jW6cnsedUo3Tq6qMb.mFvpdFcFs
 YkQm2VwpJ73H2PUkscPHC5o9cGFER_SqtlLJAg6H.QAww3CnkZ7BAzDLbslUtiToWkb51.woRifm
 NukZuf5GJFrL61cH1qrCXZCJbnFj6h4ouHp2EIUY_SPf9ePPcHcgnUQ5_LvbJtuvb2ZPm9ZfxSQI
 NWKoGl.Y92rEL1O7TZ1fPcdrpkdR44cjARTSlXt_jWMq358zQs_fi8YwnJy04AckJWiAf3Y6vjhs
 CS5jEmAwGQx2ke5gbuaYSdgdp8ZsRCklWAEtzhspn7dVkHr.HfpWMxdnxAgspaYkp5Vxfbl.qIc6
 myfgNysfR0zDj7cBce7zgF1cTQmukiVVkQLZBu0X38FMEYLmjN79Jdq.kvbipdBbdiqqCTfJyf0X
 UWMWLdr4zFEyby5ARfKp.dnG89D.RjcmNnRovae0simqIbG7DeAV4yC077vAopeGT_tKhYDizW7R
 NQ4IetVtDF6fvjR5tMjN2gbjk0rIT43DmnOy9eWqdPRiqa8Oo1WicJLIlD.3cdgQLUgvHStZ15Q9
 1O4EWp6jCBNxBMgvgB9mkcoOjh9OFR3fcs7_NOSD6eZQnB5ye2lvWkdENv3Y0kCjckUsdmwLQP7I
 1v3zC0HB9iBOSXhex1InKnEc9M3ueVlFAYX69INSTQa8SD5m.HLYKlA9cjqPXhOk-
X-Sonic-MF: <sakunix@yahoo.com>
X-Sonic-ID: 091dc0ee-1610-478a-ba36-5e008efc94f0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 4 Oct 2024 03:36:04 +0000
Received: by hermes--production-gq1-5d95dc458-5n5gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 976521b2d41838e24b741dfbee830839;
          Fri, 04 Oct 2024 03:05:38 +0000 (UTC)
From: Manuel Quintero F <sakunix@yahoo.com>
To: duncan.sands@free.fr
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manuel Quintero F <sakunix@yahoo.com>
Subject: [PATCH] USB: atm: speedtch: do not use assignment in if condition
Date: Thu,  3 Oct 2024 20:05:12 -0700
Message-ID: <20241004030512.2036-1-sakunix@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241004030512.2036-1-sakunix.ref@yahoo.com>

Fix checkpatch error "do not use assignment in if condition"

Signed-off-by: Manuel Quintero F <sakunix@yahoo.com>
Signed-off-by: Manuel Quintero F <sakunix@yahoo.com>
---
 drivers/usb/atm/speedtch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
index 973548b5c15c..dfd362abf602 100644
--- a/drivers/usb/atm/speedtch.c
+++ b/drivers/usb/atm/speedtch.c
@@ -324,7 +324,9 @@ static int speedtch_upload_firmware(struct speedtch_instance_data *instance,
 	   because we're in our own kernel thread anyway. */
 	msleep_interruptible(1000);
 
-	if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting)) < 0) {
+	ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
+
+	if (ret < 0) {
 		usb_err(usbatm, "%s: setting interface to %d failed (%d)!\n", __func__, instance->params.altsetting, ret);
 		goto out_free;
 	}
-- 
2.45.2


