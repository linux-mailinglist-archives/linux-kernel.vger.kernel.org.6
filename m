Return-Path: <linux-kernel+bounces-342854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4009893A3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD121C213C3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6213C80C;
	Sun, 29 Sep 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ogPNFEl+"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44EB65C;
	Sun, 29 Sep 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596752; cv=fail; b=TcUdQiOutmpj6poLbWebyG0G1H6BXuxYx6TPlYlyFDL9sd1f31yD3DEF+KLPaGNMla07rDRUe24B0EmsThocaXqBRTt88iK+ycMRBaGFENdNLTCLE+ipvzvrIMXfFdXB9LWN7b6CQZL1va5wAorTWFmeq0hGNNji7GCgT+wBKJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596752; c=relaxed/simple;
	bh=oW3VHwu5WNbdIu0kuZO1IkyiOnfJztnZMO/L1wBWXi4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N2CtDWXdAsu/rorjvynAruJ6pczf6l8hiwSzIe9njH0i4y36MCBThyQFKaNE/Uzoic2qihLM5FjGvzFagJXqdDhtjOPR8XAeRGNg/bqRMX0A7bOHdCgSoMF/QgfQr8hlrIgM8KgKsJjZ/MRt40IAJD9uxCCtqg1z5YmxkIA0dsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ogPNFEl+; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyFnfgql8vtoqqG9Y610m8J920meQHCMn0/mCp5hjMg9CxB2tneb7A4J00/MXE4knnJixLeldmRNBmEqzyl+aog3lSBTPK9QF94R3kfmSTG/9pxbtASGPQZFt54kIiIOZYizbd11QbGthA6uQcHZrvgrL1G3NTuujfiarmGAhjQtPjh6Cu/3jWYaMXQKxkvHwqovjf7C9XPCbPcBi9bCF5i/IUgAY5VlQt7iuvLaDFDxQ47csYxi3D8i+q1XtAy10LtcsrJ3jfH5RYBKs0v0yoOlY3hIQwoAus1lSKeR9IQdVilwMCSQohfyHxKMBU16pjqYhTCBXZ39DTbbd8S8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si3Z8xSeV8mfWdF17F7xonfWpqzu5OXNUMHSOC3OMxM=;
 b=R3JIYB+clRgwy350zNbbRLcOdRctt8z1Vk9PxX5awS3t9H+67D1y5CZh3rbT4rcP1QhUCIREvswP2559LiJWUcBCHIIlWiz5mX6awu4DMdWyV4O6YVUWhP0iVVbnahGKdTT9ps/AuCSOJ4DEjwGxxAZc4mcMF4BcPtXy61FHo/63Wte3AWFSk35/XzEtu8nSGFcobtLuF5u7eIQVY7WBuuQ7v2eiVg1Sj4kCnyqG66fxPGzsNIr/iiwqDO8FDWlgQhfswRRq5uwNvuYrhzb0vHhUofwhIJpPnT0bcXmHXFI1bkANabRanfmB1rzqOcU6yfn12d7j4Z7zEj8rG5SDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si3Z8xSeV8mfWdF17F7xonfWpqzu5OXNUMHSOC3OMxM=;
 b=ogPNFEl+KOLCjYqpsvKzaeU/KkYTxxVfOr6RtWCgd5vdMSArU3PHKowcXV7Y8P8ML0TWZj2Mgfc0Y2qeuvKbC5eX0XWpwy68is9Rb6yx43KoauealF/pQw/RYFKSUANfILxh8NCDIXn2UrZN74tRw7nWcpuelTikB5SEsFDNN8A+Ykm0WXiiynsGJ2EBdqK52WPxoU1xvIts55Up7dbodQw1a9q/yQxEI2WnqHz70UhsGqHSsPSSJdNKaQwi1xlQsHyuRMgpVzEFjRn9ZnWSbKgNPQ3fJ2j762TtTsoel1R1xfq9JNM8KJEjwsBYs1eCumxjNp/JZk1d5L5danhsKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEZPR06MB5764.apcprd06.prod.outlook.com (2603:1096:101:aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 07:59:06 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%6]) with mapi id 15.20.8005.020; Sun, 29 Sep 2024
 07:59:06 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] usb: dwc3: Correct some typos in comments
Date: Sun, 29 Sep 2024 15:58:56 +0800
Message-Id: <20240929075856.11516-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEZPR06MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1484d08d-73b2-4ec7-3970-08dce05c972e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?esIq1BN6O5weEm9zv+gcuQcXv5cpVngLCVRRJtsLMPcbnzq5Btnl25ufnIC8?=
 =?us-ascii?Q?gIx5r7v651CvEQ7qcXJ7JleldQ4eYcXVB0G19OMTLAubg5O5MB4Ouj+oHMt0?=
 =?us-ascii?Q?p6FWiUKTlvximboWsSj04daOjs0OwN3SZpJVonFsujeSL67gS/vt4yaONH/m?=
 =?us-ascii?Q?RZSJgiGzgcp2d/f2bleF7VdqJHuR4C0ExPhIKSa6MuGDhbK7id+8QN5lzR+a?=
 =?us-ascii?Q?kQTXgznHClrf/YX9IExKABQTSHq/xHchTwsuTYShhS7Xb5s0GpXV9A1hA1dP?=
 =?us-ascii?Q?e+mD4SslsNE2EAJR4mTzobMWFncO8YolBvgxP5JlXnJuqW8pUFClCTvMf8IM?=
 =?us-ascii?Q?hlI71267tquTfEX4EPfxiCJyppRUKn65H3wu94RlEFal2Q67+swsLHteebm+?=
 =?us-ascii?Q?aUGora4kVjojcH3gXMrKCKVoeDSpMPPJ2Ue4vK6ub2fsdQZNiPbLnRJzg402?=
 =?us-ascii?Q?NFWVI3bcLbsM79t02zBE/tKP5296hxmRt7nqoVSWFu8MMm3pRd8p2VU29Nh0?=
 =?us-ascii?Q?M6nz/g34pFD+t15AhBdYbs6yWvjZgjWZYmdrkVlaRjXy6no5OJ0N2YQ1rSDE?=
 =?us-ascii?Q?WMX/Msff8pfpri1ISwDec3bUwO8d+4JGq6mSvXQDUpBddF+YJUoqO/+hT1DM?=
 =?us-ascii?Q?r45XARcb3uzIQMqyXxztNmwZqi0Y2palwwjBsCHbRn7ZGGgEQU0kxYAjdo8C?=
 =?us-ascii?Q?ZWrnDe5kCgGifYEjtKwJdkqMXiiu8D50ojIXTYBeGu6T0AybLZL6swd+7xb/?=
 =?us-ascii?Q?XseAhgyRE9a2sJGPRCszCnZOqEocmduufW/ohMeVepQXL3h/YX1GDJdDphmE?=
 =?us-ascii?Q?KtIQekFRIIXCp9LII8Nsb5jZI+MciTbbKGhNC28xrJ77eaLdeWEs6sFgCq41?=
 =?us-ascii?Q?d/+DNK96CHDkilzN3PDfWCGdN7+qv/TlqRlThA4+uDHUgIuPWto4ta8eVCld?=
 =?us-ascii?Q?b/Sv3vV5kYVfAm41qpDhSeFCZWlMfNDKTaGVpzLAwO4ni6De6UOIyxb1qXW1?=
 =?us-ascii?Q?qbiDMnKKZALhfblk7G8sAEYHPrBKNMZAzQOTmv8K4NwUJ5YkjnItpM82Pz8x?=
 =?us-ascii?Q?qqbRkevH78xxTaOF7dwkPVEkh3O3unR3Hxo7m8kSElhmv6UUC0q9B+efyY+2?=
 =?us-ascii?Q?aVspXGrTepO4mVxoJeTimpEwq1/kqZBlRh2tnrYTfGckHE7tsBNHS1THxSx4?=
 =?us-ascii?Q?sLA0CzxQgztjKm44t8CjkALeZ/w8ciGxeDqL1sFIK/p43E5hi66I7DgNXbSk?=
 =?us-ascii?Q?Iws8jTX/gUtNGfH+Er9+wsZe/19+S9taO+UK8OcvBq6ISGQ8JLMBmf/9nbkN?=
 =?us-ascii?Q?qegJSmRBNs0DpKcGcooWsgY7Hrk3qVz7f2689klWlwvZpCr9Gk2BICaZpirM?=
 =?us-ascii?Q?hrdDaYvZkJReibrkK7JnQyf3xL3p64DszG9hkUr7kjJGtT6Bnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yX7rOHq/U2+4U1d4UfitFflGaeYr65bg5zYtnIx0DhFDGD1LXfT6Q8mHUF9V?=
 =?us-ascii?Q?6yGfoHMR7PTWZf75Rbg1fXxeme6835w6Wvd041EyRsLZRUJjSycwJQdfppzD?=
 =?us-ascii?Q?SLu3Z/r0ZLdv46tjry1qefo+XvM4gjYMYRno4KBlPbq7A70tyXZlgRYzxdCY?=
 =?us-ascii?Q?Krd3BZneOzXqngVAUZIjjysCmRJCbH9yhJyt+EcaEQb1b8P3UXsDdETFgI9f?=
 =?us-ascii?Q?8YUQuHm+PiPDx66WbQFlqaH1NcAZoAZmLLTS3R6IMcB3RzGzRhu8T+8Z+DVp?=
 =?us-ascii?Q?pP8IIpUlsqJIBk0unC71ViXlh+5d5EdBMcN+oJjWtjV/54zR57kUWEIU/CNY?=
 =?us-ascii?Q?g9QywnAEgJ/vzP4wOpcpq0eFAYHhm7qlzv1hJMlYuZJxOEXDvrtBSl4fFdLd?=
 =?us-ascii?Q?5cwLQhtKUtGI4PyB2M1lut5SYnqeozZ3Tiqzid0kUxjHlJq10Upl32M7M5u4?=
 =?us-ascii?Q?nRv+ruaJs+i5mj1boVUNSUOHLWRg585amm0TcZ+awQd8g8mXyFKe3n4ZQ74B?=
 =?us-ascii?Q?8ljemaIyR0ZQTmo5aZni+XDOca9GdAcd+vOAqaaqerAlkp8yfX1VTwpcp1VY?=
 =?us-ascii?Q?FDv/6O/jKd+0eXODa5/OQ79UDgGTsoJhFjJKXEB9P7exu49FdzYPXiitfhPd?=
 =?us-ascii?Q?lGyOzb6buWgPgzgoOzunlUjzIuv2hjFMJckGUxQS2nXrmx4essq4uIr7tvQM?=
 =?us-ascii?Q?LVBq1nBSaalmvb0p8sfo1C1N5H2qu9XgruTlzc+PM0pFLoJyGgkKSf2fvR0v?=
 =?us-ascii?Q?hVkqBKPRx+dc/iW5M72fioEO5UkE3+fYD7pyqaGub5r4ITCUsLqsV1H3zw85?=
 =?us-ascii?Q?mseoLyuUkNrJ2LOvjBh8PIrVgLiK/mycQYM1LF+zyB4WjEQwx2ixx3bkSODp?=
 =?us-ascii?Q?Bt6EQ3FblgqFFoNv+Pjn64JHC7RXRIpAFjeqqL4i3tS4cjGETur1wMS3QBxD?=
 =?us-ascii?Q?zUtqKGDH6M/Fnrmz1r/UcHs0NhKVHHCpZBWrE62jzn5xcRUMAAjrekshhnwR?=
 =?us-ascii?Q?EaEfOCZpAXKdfzxOkbdl84Uxs2d5J86sCmr+aHHYOyDJDTJt99lMQnUVdKBe?=
 =?us-ascii?Q?5rurhM6FvvbIpZdi/hbMVuHyfg17MgsnjZO9Dqsgkm95Kb86ulgaSjHMcKW5?=
 =?us-ascii?Q?y3WVl5+x4+WoREFSZRuTJVKVoriW4hQBMEb0EpBWOQPcQ3SglyfgVZLI6phg?=
 =?us-ascii?Q?uMdp9DuU/YrC6VrHUfD4S03As4JYPuobjwvGdHQiO+XEdIfJ6egVZ4J3RT2a?=
 =?us-ascii?Q?ZXA/SmBL2pRG2pIvJG4E8ujdhGKPXnbAbkzkF2GSruxdxysXcLb5teRk95KM?=
 =?us-ascii?Q?NRpSwOtoGWLAUe+yxz6YRAIIAbopOgFJqdVV4wWShAY25ufBlPQVjYifRS7O?=
 =?us-ascii?Q?TbwJJE0vTJakaY4gP6OOvF3LPK+unUMIChhH93O2uUIoPvbfIFwIL0LXLA4m?=
 =?us-ascii?Q?KBhr5bmeRRzKbtyYaQh1y6OTgDvQkYTMVUf71khategiXZJtnFhKfQryxPCe?=
 =?us-ascii?Q?BsfZWOAKgY9gBdzgkt6G1t1Xc7iL3XBRxY3ft4fi+nb2psm5D5PscWy7o4Fo?=
 =?us-ascii?Q?tmRuARhZERr2fBLjCjuYMeLH8fgETAZB13iXYGvZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1484d08d-73b2-4ec7-3970-08dce05c972e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 07:59:05.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6+rJk59OdgrlO6sP88vW7MZA5Obao/pJMjcMCzH/3aaAyEWGuo6y147/2JkT8F+KqI7PCLsjn6YRo6sfiX4bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5764

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

-in the code comments:
drivers/usb/dwc3/core.c:1406: feild ==> field
drivers/usb/dwc3/core.h:84: boundries ==> boundaries
drivers/usb/dwc3/ep0.c:148: issueing ==> issuing
drivers/usb/dwc3/host.c:38: temperary ==> temporary

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
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
index e0533cee6870..60f7a55e1ea3 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -35,7 +35,7 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
 	u32 reg;
 	int i;
 
-	/* xhci regs is not mapped yet, do it temperary here */
+	/* xhci regs is not mapped yet, do it temporary here */
 	if (dwc->xhci_resources[0].start) {
 		xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
 		if (!xhci_regs) {
-- 
2.17.1


