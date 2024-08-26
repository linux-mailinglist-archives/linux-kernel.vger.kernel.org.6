Return-Path: <linux-kernel+bounces-301057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C495EBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC75D1C22CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C7148317;
	Mon, 26 Aug 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="epXNdYT+"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2076.outbound.protection.outlook.com [40.107.255.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990111482E7;
	Mon, 26 Aug 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660632; cv=fail; b=a2c2FnLz7zgq99HUoHzj0iye93BoiWM59X7G3q5sIgebqDjIUMF5Gyuk8JhMMdwU8vkYblFiQLRyJSe41Q4vV4VMni9gkcLfWc5+4RdvKJzDIJ3oss+WxN4NAKKEhQK1Tg38HBtpdPZoxLuNFU98Dxcky7q3hJPkUYt2iTdNEYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660632; c=relaxed/simple;
	bh=4JEh5659lE4oCzyGydPMyjW1bqFusCVtsG62nasmUeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A30qqXFAVBHkDFUfdsN12H/SQB+jeS2Oc80i5skDuz4sFlRks9xK3dQLltejd7Ly8z97vE7f0MhMSBLyWyDy7o3ypxBiuQgsHwNQF+L9e7bHySBHapAu72xJj08PGv26xBVqU2FA1vHFnAPaKRCvzby2Xg4oaL+zK46mHT2dfaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=epXNdYT+; arc=fail smtp.client-ip=40.107.255.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+rThOSVDE81U/Eu6t0P/TbfcO/tDNnNGqaFnrq4XuBr2cMhXlsDZsDiJZDdljZ2UYKgyQjOXsBL9kEGI03QueC6fBS55aWf6TWG/1eK5oTvRJ1HEgUAVWibda6B0Bc2A3JmcspiSGZicZiuaE8x0zKN0/IexS9EsObAl49gCctS5BFXmT9M06BaE8oPy1yRTorJVghzmsdpqVBdjFJdaFmnCrXUKWAHyZiclSlo1ic9thkpCrtfphtaZbeyn49gCAq1pTsfMKqxDNswO4Sxxue/nB4TsIHWQZNU1/XnHNUK4Z4Uqbu21YUMXz1Cgwrd2iiH7B6PRuq+OU8dBScNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=BA8U1KbHJ0+WSl+DX6vlcmDJDFnpeVHjQzfyr4xMrMWhqPNB1D9XjjAttoemK66+bu9HhsCijSm9muE3lEEZLH3PoOQ0F7PhWNDvmVNAWERpATsi09b5EcPAIc8ZRZmIEsP8nbK4akEAm31BIT3fqV7LixCv/tq5NXjIdFXhP7jGUgxd/vFI8E7Hh4zpMAx2/1hIeL+TGvx/lBzjkoOnm2/MaoKXl2YxKxBve4p8XGFJmY5jEsNBAK+6eWZmP6RV2MYR1q1QerICwmpNyrMPAjR9KI8y8JxLbKgCC4NgMHnwALwJIBykULxJ9zdF1ddufsIz2f3YYlZGpy6+AemvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=epXNdYT+UPyJ076fAo0Z11gY9g87nA2STXAmCe7u4lpnqNoYS9/6UnWvW0Zg6s1GeI2mruYtrR1FpXU3/bOpLHvBMLJagXUIJwXgUltGcMgjOz9akXuOATIgCdX7S6IAmscr+OfoBpBBDXdT0mrkCKaHuUN7Ixj29vEedq5EtEOX+oe7BTHyaQIWruwQTta5iC2c7HiMkMkRbdL+ZQ5qZIg7Q2aiuClA9XEf73zG9KdDTMp9GvXKKvYlVjGEih7G1U2sQ2sFRteW26pvad7LnPe7NSk3MTHrqgZPnyJjMTNdxphFQ71bosjwUPcgXvMmSmpdXwOmwBxi641TU8POVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6054.apcprd06.prod.outlook.com (2603:1096:301:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:23:47 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:23:47 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lei Liu <liulei.rjpt@vivo.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 3/5] usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 16:23:31 +0800
Message-Id: <20240826082334.2351-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:404:e2::27) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c202a4f-3b64-4f0b-df48-08dcc5a86811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6T4p0syyCNfjTnZ3F81U4PPxHZ3Qq68Y/3J3fWaINVEzx5UyjwOdtrLolvH?=
 =?us-ascii?Q?CkeoqzdBg7KkjTEZfVra0TLlYPEWLqh/8CMF/cK6yHh9Xdfu0kTgAPqnzvxf?=
 =?us-ascii?Q?i9cc9SXXFbIeOMU0gslkZrOfnpv3Mu6F8/hyWcDQKx+UJAcciZs0t/Ea1+I0?=
 =?us-ascii?Q?5qezN8Tsd8xtR1MbIaf3sGtzMV2f6fU/4dAnhXuMWTWxgYlCxTbTFGmtqWXO?=
 =?us-ascii?Q?6Yn/3meeub84qFygBi5LKhqVbLCh4l8tiMCC6K1iH4Iw/d8tEfR+5IyuZte1?=
 =?us-ascii?Q?BDD4ZxYn1tcP8Td9md0sel/CvvQslV7uA6BfhGNakzmlgAyPx1blKKzFUJtT?=
 =?us-ascii?Q?qXjWZRuFv0xW1yuWVCB0ZHvIasr2m6yA0peW1xE45H2b1d2RGB9PPGM3wtiP?=
 =?us-ascii?Q?4fAvvQfYeZjwmGqtgoVQcUg9Z2el/Eu2Ljd2jFgWRcbM/qtoSaJwBYXZri4c?=
 =?us-ascii?Q?q7y1MhhoqU4ZyyCXw44DbjtSeeALwh0T3UwvdUnAYmLMhr5J87ROLqaOYM92?=
 =?us-ascii?Q?d+n/oH/zD+O9R/+wsp3+2r0SlTTWRoLf9754rqItyt6s+lwVXJCsiJp8eY/x?=
 =?us-ascii?Q?CaL+67Yl0NJESXCvlfb1PYECsplXnHbwXmJ+b85fYOOyc7rdEuAyarJnGpy3?=
 =?us-ascii?Q?8QrzncNwlfUUs15ecboIb2RKa/ZT876+UdhmtblpE6whMvEq63h3Fkl5X2jL?=
 =?us-ascii?Q?BjEqfwtCDHbxIzLywkc0rk2WvfNQLKJghyGFAosSCanMJaKsp39MiTsRJ9tZ?=
 =?us-ascii?Q?sCHABbJ65VIwFOfWYMSsvIxmhZuztsWAe45/qtv4Oufzhed7M20g6dPx2Zp1?=
 =?us-ascii?Q?63TeqL7Yn6uYCG0wHbx7fjSFHrUPvrhM1q3jPOn6jc6PIciPBA0PM/thSpt9?=
 =?us-ascii?Q?J/dSHaY8gjMSMQPfZpNXwPsczVPsnhbRlCY2ObWctXdSF6d74+aEo7+rviJa?=
 =?us-ascii?Q?WcNP8LWsJGo1MFM9guDawd8xWDibas/jijDoux90mSskkCiIxdxHsnTKkIUt?=
 =?us-ascii?Q?yZVNW7re4oky71LrquzllOEyeKKkPwGTj+C9x4gPtWc9tkcuOcUPd9+W6Zmd?=
 =?us-ascii?Q?KLSocGf/V2M9UGx2VNqKie2cTHw7V85uncRlzEVvno/bNCMA12pHiToUNXH4?=
 =?us-ascii?Q?rTP3K69MDG+sfS8TSzsLoJxcE42qUb49EUzhaEzpFeqk+FpMWRw+rbOzLT7K?=
 =?us-ascii?Q?Tuas+VKi5uU7pGHEvXEYIhygCHpnV8kkN6mjIC7XuodfiKmK7zvW08lWUprL?=
 =?us-ascii?Q?VqEUlAjFDMCO/ru1gcpwvcOsoM8jSHF53d+keIRqklpqbHkm2UIPzsSyf50T?=
 =?us-ascii?Q?mlD84k7T3kUo0ormLpLanWcGzWM8ZDkcTY/QqRIaxlRRDiAFxcxnglTFj93x?=
 =?us-ascii?Q?ueLF7f2yqzRYs9OuiC1yHWKCzhtLJ/UEiA5gGDCZqzvx8o86Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNkAW35tiSfntYE34CoQpM2Oe+uA4G0OA1mlIzrEqGJvXO1mpv5F7BQiakZq?=
 =?us-ascii?Q?AHU0mj/KLYV1LBrqi+OXr2JVFhfEsQFvux+fMarJJ6zGsOmk3Lk1qOETk51V?=
 =?us-ascii?Q?33x+LwlcjTrmIkXLgp+zDYrSP98mnvdIw97brUUb7hBH8YJMYkfSFebybQls?=
 =?us-ascii?Q?mEb7wM5iUWx9VM2tAM/nZBqUf+wqMqnX6cYZ9E1ff6IJnDAkghH1dxK7ZywB?=
 =?us-ascii?Q?LxFn8fBj58OFNh2ILd1MQtKk346TBIi7IbTP6Y0/zCfxvr6BbSHhPytodFpv?=
 =?us-ascii?Q?ocJbotpFoy3AkAMX6ht6c0ePog5Y9SWEvMC3oJKoVaYafUXIRwLma6dHtZYZ?=
 =?us-ascii?Q?MEyhsj5hA3MfQbFzacSNp43ievqf5qo8IQXrl+vuoyhMSF1MYR7tT7Hr0sKf?=
 =?us-ascii?Q?i6qhP8YGAKHMMOFQCvVzjx41vcBH5vVEAYYiyt8jaxsE9R7qLgoZqljkkQXB?=
 =?us-ascii?Q?6/f7Cf69A+90fCO9qf+84gid+BasDh9c64Io5ypWrJ3CNg/bFEGU9nAazpdr?=
 =?us-ascii?Q?epYJmuPbajca3eASaiksGG+95YpbTxgnqazKu/ABtCESUVUaaw0Dnkh57ZZT?=
 =?us-ascii?Q?m35M0oOL5EgxiE6ZRqZKdistnQMkYFIaqMO+pLgvf6PceTAJRLB8OZS5kGB9?=
 =?us-ascii?Q?Fokc60XFnlioUuEj0kZC+Rla67I0Rp6Tz+mOqVOvh/619tYHWNKltfWGc3rw?=
 =?us-ascii?Q?J+fme85RRwURWkaq1WqFRsdnGf2U1VBIETrvhiSBjOlz5ZBXlp+p+uoXVObK?=
 =?us-ascii?Q?whFgiul0PfXWMkBUZMfB/SvvDw0K3uYmh95cL+yz41s+PLp4me4ZVUcX8U4L?=
 =?us-ascii?Q?sT0gLwhEfG56EH7WBGbHyN9VG3E8Kg5/uJH6p7rq44WdlBmAtVBjiPql0pGg?=
 =?us-ascii?Q?MPLCRYjLjv/8UxPE2q89iLIprTtDK0f/V9CnukPU5lRQcb82YwV3n+cX1lt4?=
 =?us-ascii?Q?sCp7uRRMahYQTZsWHoRTyt2FSMK9QzgMRKHRNttZFFhH9HzhfUrwL6uFKl40?=
 =?us-ascii?Q?5eNB7z/sRBgEAzOVDN+kuIFvlwcKx5Goxkt6ejhCsdQA/9vPF0/1BDTA49Vg?=
 =?us-ascii?Q?KLBIwDDJ8sggJeaZ5zdUuXjYTT1KhwbAt78OVlkEavxbaXGMbS7yJY51/6Sm?=
 =?us-ascii?Q?8/iLk+hW91cyZY1Ejd3xbstRZkJGTrRAuH1Oj1m0C5fyuLFWYDRDT18h422a?=
 =?us-ascii?Q?J3IgQxP/tP7SgphXUNZwvrajEK5vHW6Fmd58FdUYsk7FJTzhoix1rddZ5x8G?=
 =?us-ascii?Q?/ZO8vsRA/FyhuOM0OsrS3gTPWHeEtTM/tKh1aSnyLQVZZoV1NjRYpV8fCzVh?=
 =?us-ascii?Q?yQoqeaDrLGzpe0huP8w0Cr6hE/RbNn5kAyBDVtNrh7nrczd+1MKAV3J9tExT?=
 =?us-ascii?Q?PwUdLxJqOX2suTyuU6C+cV1vNOpvVt3/xgeQl/+OEF2jSrWHTWs5bCTVF5M/?=
 =?us-ascii?Q?RUAyu3v4qT34N/5MoPFLDiqbb3KgjZTY+jVrWp7upG3xSto107zd2hwv59Mn?=
 =?us-ascii?Q?Ql268dyHgQiZt9LmLu00f6qAvytwZ6UT39ed639N/efk2ysDX6PxmSITJQL2?=
 =?us-ascii?Q?dfXHnUvTnUPRtxFY34BBXUII5PibSfYaSFAa+fz2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c202a4f-3b64-4f0b-df48-08dcc5a86811
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:23:47.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98JeypoN/feg0FXQnOz5gJZfHd3m/Ilw1ECUdSJAAPIgo/XZaBi/M349LsRctjTlFscASkmk5d0lVnmMicz6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6054

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..bdbe5ead741e 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1812,10 +1812,6 @@ static void r8a66597_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-
-	if (r8a66597->pdata->on_chip) {
-		clk_disable_unprepare(r8a66597->clk);
-	}
 }
 
 static void nop_completion(struct usb_ep *ep, struct usb_request *r)
@@ -1876,18 +1872,17 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = devm_clk_get(dev, clk_name);
+		r8a66597->clk = devm_clk_get_enabled(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
 			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
 			return PTR_ERR(r8a66597->clk);
 		}
-		clk_prepare_enable(r8a66597->clk);
 	}
 
 	if (r8a66597->pdata->sudmac) {
 		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
 		if (ret < 0)
-			goto clean_up2;
+			goto err_add_udc;
 	}
 
 	disable_controller(r8a66597); /* make sure controller is disabled */
@@ -1896,7 +1891,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 			       udc_name, r8a66597);
 	if (ret < 0) {
 		dev_err(dev, "request_irq error (%d)\n", ret);
-		goto clean_up2;
+		goto err_add_udc;
 	}
 
 	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
@@ -1939,7 +1934,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 							GFP_KERNEL);
 	if (r8a66597->ep0_req == NULL) {
 		ret = -ENOMEM;
-		goto clean_up2;
+		goto err_add_udc;
 	}
 	r8a66597->ep0_req->complete = nop_completion;
 
@@ -1952,9 +1947,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-clean_up2:
-	if (r8a66597->pdata->on_chip)
-		clk_disable_unprepare(r8a66597->clk);
 
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-- 
2.34.1


