Return-Path: <linux-kernel+bounces-343290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB4989938
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3F0283D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97B1C6BE;
	Mon, 30 Sep 2024 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K3Yyc+EE"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CC3C39;
	Mon, 30 Sep 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663144; cv=fail; b=gPhQIDM2DCEswFiM8dEFXzGQ07lAbHDayzp6YsyQ3aRl3zpFhrOtlV2+eIVdv+hkcqaa+V6fE66ak2IjUuP+yzLZMf8YfUcwBrOrh/zpbn/cJTdcbwKDKno2xnJ9T1Q9LJrv3cCuWWPyAxxvJEPX4xISJfvS+GGVnLmpih4h12U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663144; c=relaxed/simple;
	bh=OEbGGMMdcHx2Hy1PtitY4IlrEAPvyPgHG0tmuyJkOwI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=McIoexFyh3NRldYW3P/D/AZeVV03BJMUTgaELCaL6toXqozWOx92NLEzLstsvBxlwfD9BksFWia9D7yZCfGgQ+mO6f9/kGZhH6IwJRvfRvWuVSPQFcKZOTPZOaHGq3yiarAuGCg5AonVKDSSabB9pfHcQA92BvSRdc2wijgJLyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K3Yyc+EE; arc=fail smtp.client-ip=40.107.215.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0vjdeZc1i/J6oTO7VTs2QsqpG8zgQVdPeqlfBGV/clezFhMCz+boKPw9RZLFe68kII5psFDLWzzECWhDZnzoMZuh+NChfQYUmzWKvUHl8j9q4TF3sea8NNLF/kFHw80kz+eckBFbR9CsAEQ6hv8GzW91uL9teEM3IIDtIuICsL1i8HM9WxzIT4TyRdSVoYZp/7skkvDZcucKL8KqWkKqirXIb91CWBrsGn89TycxxWMWFS0WmvEq3tAbD+NJgdRhXc18rPXNjvbkCieobrPztUCIZUZuZGQ4DUeMqy84kpjUiBV5XQPX4q/Dgv0DY6JbTcWbM1SiC6yI7eiIFTZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfrMk5FyHLtkJuVR/HxD659U18pzVaN4bsT5chle1U4=;
 b=Ms/BGhY34Uyb7A6I5A0l+T053JLSKUufl5HJKkzsuslqlE0I+cqJkJe6vpkJjAsTpcEGRuGMsidnGktStLeEBnRXJjizM/mAhHkxS9fWmWAZU8X/eU04Sxmx2xGKcpGc4D3Fmm+V6l08Pao28uZrrgw5VQ/cX2etTW8L5V1si5WxcC4xr3DschGEsogvEqQAg078DdqmcyaxgImd/r/gKVmdvfrxaAshOpium+8VPfSN7MRShGLcad97O+XjJaPZBmPRxMVSBgsEgjwalal/UtkpEWi5yhKmj7m1XGa6Ml6B0XUM9/UXAmfh7WoKoGQ1wOKbvG6OZXHK2ELqY//S7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfrMk5FyHLtkJuVR/HxD659U18pzVaN4bsT5chle1U4=;
 b=K3Yyc+EEeE3DkJqQiouocSgn2yNiY1zw7kcGF2BEH0C7AXj41bsXfi3s66zVNtUEf8EDn8AUKYQGCBLgdNxUtASvSpgsaWVgcaIOipX+OzwgHHUMr76LFCfK2tUHECb4Lgi1dm8pSagMWEbjwOfyMkj5YskTBhDIis0qNZ8NR/U+Z7uWs50L2oTMJBMmykq/mHET6avpGoCTQGKUkmgm5MfE4KPHWNbojsmrl4f/gzR/7hocXqQWmYTeXY79lQYRHTrUf40weUr1zZHXg+yBizJ7nZf5FGqOA8pHbfM2EG4PZPask4CVelkksN3cegxDrGLGDrmZBWSQgTu/PhpXeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by KL1PR06MB6370.apcprd06.prod.outlook.com (2603:1096:820:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 02:25:35 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%6]) with mapi id 15.20.8005.020; Mon, 30 Sep 2024
 02:25:35 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v2] usb: dwc3: Correct some typos in comments
Date: Mon, 30 Sep 2024 10:25:26 +0800
Message-Id: <20240930022526.7255-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0217.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::18) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|KL1PR06MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: d24e7cd4-60fe-423c-9344-08dce0f72a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1vSvCq1GAK3uJzQ3oDlOiWGJ7izuvqofyUZsDKqbxzCUoFMkQ0dI16ZEUQGv?=
 =?us-ascii?Q?wZ7IaUEMwDeA4PUPXy2MD/+W/31rw2aMYajmPhz4nHzlbHVBn3FIrTPDFcNC?=
 =?us-ascii?Q?LbA4iZaGXQfwAzjxISPpnQJzeuVvCds8dFN8ltB0SsH8gMoicxUs6FuYvzI1?=
 =?us-ascii?Q?GQU4qiapF2QhPwvlKfkUKDhaFq2lnqfZwBTstA12izZ1CBDzBZOweMN6VgNh?=
 =?us-ascii?Q?M7etem3338ggWiR9fe9jzrX3JLMnqSF1uQWi20/KDqN/c8bViV3R76lGwPvF?=
 =?us-ascii?Q?m8vijhN+b1fhCuNzkZA4IORcLv5VmhAdkGQZ+P9w1f4gGMcRSdSOFBSLm8b8?=
 =?us-ascii?Q?26qVFkBPCQw9GprkeT5rueRz8NQ77hfgXekBbD64Ory0UpaRgPEKtpQYp5a4?=
 =?us-ascii?Q?j3I1cvtZpSTbgpnV4v7XtUHpKrjjX0SsVhJF3i6dWClKiYYoEK37VLZkUZfi?=
 =?us-ascii?Q?y0oFFRMUzv3rmWDPGRAGn7g3IzEWKMUsb8wF66nKPTFTiyzCrz19T41J+ROE?=
 =?us-ascii?Q?M2YSpdXESX5VWr42Tz2WqyF4tspddV7Y5Uo/vEua8MGEW6NNoXB65wmnbGvu?=
 =?us-ascii?Q?GAo6Az/EJ7gINVPPzD7zd9GNaXWwiueSZ3MaM5w0p5Hgi2b1V75+PUI4ymqT?=
 =?us-ascii?Q?tLRkL0bQbrL6i/kGW/NsrtzPfn4km77Onoy2NIOZXykuv0baMJvgarjyMFnY?=
 =?us-ascii?Q?5SrZmHNELAlrbYRzVQa0A+lYnkJQiIGZ/XLg2M+AbFKs30CCNrLIimOSey3j?=
 =?us-ascii?Q?vy4RNeQC+/P4TSoLhaVwmBvtNKZ0JOzdAX4Fcm3kwfuuWctzYdQk+sN3Aw8m?=
 =?us-ascii?Q?CNppAb7UUBySxU23OK5lTfYC1PAol1/N+C3Ve5N55JqiguGDEK5PuEpCcGaS?=
 =?us-ascii?Q?I8vfRI2byIhf8su/o54Uzc4+7ItBJFWI2zPUSMKKMgiNknwkVs7OS4jDgU5O?=
 =?us-ascii?Q?KcEBuDMxxwcVp35Vmxf7R+jpRccFprPN9ATz+/QuACEIb4yOKlWsN9qO2n7v?=
 =?us-ascii?Q?dsxFuDCvs+XGFrPG357y6k9qCEAbKSnWnboSPYH1uN2MdLMXLFN36vx1FDHQ?=
 =?us-ascii?Q?SaAxgWRJKPGjRFQe8SzfEHzeG4H+bKQ6S9j/pF49+UyKk/TPwg8UkmFCULXw?=
 =?us-ascii?Q?LUz9BYuWXYz2lSS40iPyHvdtcSjqB9C2JohMug1FANooz37LsFimMquXruwq?=
 =?us-ascii?Q?OLnSsZlvFrj0Llgaa12qOombPcPbHE+zog6b1sAC4lRiSQOAifvCrL8XgY9x?=
 =?us-ascii?Q?p2RUQGlpbS3KcYuD88TyqkSdecEufAybdnLUi23DxE4OSYxgBZccxIDdi6kv?=
 =?us-ascii?Q?dclKsHQb1OOqs8iIucur0ezpAhJ+BADnaKjSS9hb6TAS53aQqZ7839wnUri3?=
 =?us-ascii?Q?iBf/uJvcn4C+imXhpwSwLGGkAQn2yvXar8/WxG0B8rSfb4s2Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cQJvKAv+Vkvkx80XA/uIoCNenULnqZmFlrU2Zf9yRDj/CzERz0Xl6DJEAAP?=
 =?us-ascii?Q?9ced45hMNZm3Jt9bGoXnuAehXmrLJ34QNKj9r26E71wpopU4bj+oaJ3hQohh?=
 =?us-ascii?Q?XvZzuGZQ6gMrf2t3vF3l5pLwTzNphO8f2CztirQld+nx6qRDEHKgdSOYOCMM?=
 =?us-ascii?Q?DL6u3laL+m8NPVHXhmAHDOZZMQHBuuzaerH5+FYnxqYmmEfT4eBwUcQQp8Pi?=
 =?us-ascii?Q?QPGovLbnrN5boIzZOLfcuduYcpfWHnPdHTW4h9lSMcTLBxTrgtyEnHrmNFFu?=
 =?us-ascii?Q?dU2Crm/OJ5hUvd4JF9nuk5ihvohu6KC6oyryFNyOmu6EAeVVr7o40BzzUXkS?=
 =?us-ascii?Q?Dn3A4WWTGHg2tuSYBU8RxZaSxl/IdBAw9NjI5rP/ispSpru6bUQbGLdvh0jk?=
 =?us-ascii?Q?FDUzTgRJWbFIeMOxfO76EOIxvKk2zvlmPHTTSb5qaNxFk+b4JZaCsQY/d7EA?=
 =?us-ascii?Q?Q3lGU9GrOCL7Na0w+7mvN4oxMh+JWZih8X8t6zfbQMq6wSAJbnrmI+Jnp/3q?=
 =?us-ascii?Q?yQIo5zzzIqvek2VODKcDxd9b4wVa4c9fPbszHaulvyjJFENs7hHeLXyQUv/X?=
 =?us-ascii?Q?rSzd4kXZrPl1sJQEvQZOp8Cp6qQJReU7RlIuHHHgSa//mDU08LILGroFjm2T?=
 =?us-ascii?Q?W6rhoD5i6X/9FVMkXnUQTRy3E4t9cqhT3/twZtTCe/dGp72UXTHSHJjp0dm1?=
 =?us-ascii?Q?OXbBWBWQQucwE2LBHM3ZHlNAVylvS7+Atx6P3dNjPm+1sj9FWjnaoIaV56wL?=
 =?us-ascii?Q?5i2/1ii6pruS/QoBF1GK2GnQaarr2tGX5uqjzds9+wHegOfdyLolGU0GUWun?=
 =?us-ascii?Q?0GEdq+cCNxVZ5o9vS6tvDCpEpi/GQ3DKpUpRhT2WETmYJRP4KJNmZy6p5wir?=
 =?us-ascii?Q?iDINuACV1OILZ0drvmlpcanZuEHCoH5zsuhQI+ewrzCBRb0DuQWdM6HmXK9Y?=
 =?us-ascii?Q?dc2dp6a0RdKo68p/+W/HXSrieQGXJfIm1MqFEDd77wPV0CF4Ec2Ea8qL1BF9?=
 =?us-ascii?Q?OgRRhTXRVHuXb8QeltzpVejeNYCsPLmr6v8+5bJQtQxYBDLd5ziFGCEhYeZI?=
 =?us-ascii?Q?sgTr+bf+/XcXu4IqF8Y1z0sqF7GAou04IU+GaOiVtXAAC7SsnZQgmb+Ug14X?=
 =?us-ascii?Q?VTeSoJ7a1m89AKn/rKnwv6JRMaWWuSGMokPWlExUWLcpzSUubJVeW8358Di0?=
 =?us-ascii?Q?ql2i2v2DuZqZ+/QDYc+hdq2CjHKWhOFlqsHOqu6vs/L7EB226JfsipbZmJKo?=
 =?us-ascii?Q?14eCPofopJdzVL8wJ/uJYIqLW7pTVweATElhpmdRbbHm39w9gHR7Y5hKB1Oy?=
 =?us-ascii?Q?1mCOkDGiohdOBExmkmxf/2pMJ/N/nUC/LfLhNA/gzh3RfwAnHbUDm3+8PMuq?=
 =?us-ascii?Q?W0dgjMlkjqPa/XnjA3YQ+FwUS0nkn1A0c//XXigP49DjzxrbnoMGidaRagYw?=
 =?us-ascii?Q?bys3zRgoPoiP1DFBVYxQuvLxzkSy8C8/vV7Uvw3nJl9eq+/0q41UFTYjRNTl?=
 =?us-ascii?Q?S7xS+9eOtmD51zUxl00v9aBdL4i6/8kanL4Llo73pYuoVztjHWn7kI3bvL7X?=
 =?us-ascii?Q?IMG+Id2PhywNCU39FYsmrsQbbcs6VXMVIKxpY542?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24e7cd4-60fe-423c-9344-08dce0f72a86
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:25:35.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qauc0p5jfCvLtrM5oTDp2LcpW+7aWLbYujX4H6MCTpar5BSwx8ALREUcJkTp100tjeayLgeBqHog3w3mJR4fNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6370

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

-in the code comments:
drivers/usb/dwc3/core.c:1406: feild ==> field
drivers/usb/dwc3/core.h:84: boundries ==> boundaries
drivers/usb/dwc3/ep0.c:148: issueing ==> issuing
drivers/usb/dwc3/host.c:38: temperary ==> temporarily

Also fixed a syntax problem in the comments.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
v2: Corrected the grammatical errors in the commented sentence.
v1: https://lore.kernel.org/all/6591a368-e2aa-fa8b-c3d0-2a438f52c126@omp.ru/

 drivers/usb/dwc3/core.c | 2 +-
 drivers/usb/dwc3/core.h | 2 +-
 drivers/usb/dwc3/ep0.c  | 2 +-
 drivers/usb/dwc3/host.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..3612a57f7877 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1403,7 +1403,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
-	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * fails to send proper CRC checksum in CRC5 field. Because of this
 	 * behaviour Transaction Error is generated, resulting in reset and
 	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
 	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..2cb88e08e746 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -81,7 +81,7 @@
 #define DWC3_GSNPSREV_MASK	0xffff
 #define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
-/* DWC3 registers memory space boundries */
+/* DWC3 registers memory space boundaries */
 #define DWC3_XHCI_REGS_START		0x0
 #define DWC3_XHCI_REGS_END		0x7fff
 #define DWC3_GLOBALS_REGS_START		0xc100
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c9533a99e47c..f3d97ad5156e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -145,7 +145,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * Unfortunately we have uncovered a limitation wrt the Data Phase.
 	 *
 	 * Section 9.4 says we can wait for the XferNotReady(DATA) event to
-	 * come before issueing Start Transfer command, but if we do, we will
+	 * come before issuing Start Transfer command, but if we do, we will
 	 * miss situations where the host starts another SETUP phase instead of
 	 * the DATA phase.  Such cases happen at least on TD.7.6 of the Link
 	 * Layer Compliance Suite.
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index e0533cee6870..b48e108fc8fe 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -35,7 +35,7 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
 	u32 reg;
 	int i;
 
-	/* xhci regs is not mapped yet, do it temperary here */
+	/* xhci regs are not mapped yet, do it temporarily here */
 	if (dwc->xhci_resources[0].start) {
 		xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
 		if (!xhci_regs) {
-- 
2.17.1


