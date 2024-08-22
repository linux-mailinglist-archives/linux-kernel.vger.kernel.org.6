Return-Path: <linux-kernel+bounces-296817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60B95AF76
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305D71F237BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597016DEAA;
	Thu, 22 Aug 2024 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ArbWaV4l"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2054.outbound.protection.outlook.com [40.107.215.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821215572C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312398; cv=fail; b=TScGFPnkXhOxK//05ZTqbXrTBlxb0ViQ4wmFh2VL9QRMFSowKR8OtJY+qrSHVZA/2tyiROT+TSW4EcOBPYrQMVg7U7Zd73LF/4kW9CpFAHQ/ReKOel0Y0pVSAWEIYCNJ1m/JFyP5NXIDoyn7htoY0nJQh4j4jVlZ/44XfweL+EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312398; c=relaxed/simple;
	bh=3H7/zAmTRbhZ6+ZTDova6vbxpa0vy5nJM0Iqr4x8mik=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hiR4sDPaXC8W4jgQRMwjap7Tn+qGMbE1ZeSs9n/I77n2aF3R08zaS8WUVCpYye03JYVKwijkvGMoZQaj4j0NeoBdPEDTTEyMcgHdQhDmN6o40TiEuXHficSXIXlc7kOn0yeHQMAcoTjKykOQSoFs7qSllJAwBmzzzECZweEDPwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ArbWaV4l; arc=fail smtp.client-ip=40.107.215.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsXXL22EC/n8BuEWsSXQ5x6FinXgsAkrojVeDmh25vcdiT5l5a48W+YjMJW/dgDXOE8Mnb/1YetnfuO9ej2QkpjQRmT8K9QMV/01cumgExPuYDq4lTCfAVUGCwKGscN5uRCWOTpik3vNHD1l4MgdrrW+z/TbuU8TGYU19QCdY+VV22SIkGWCiLxDeSyF4xqE9CC8eN5Yj4UflL7eXabwNEVm4C+QgVjdnpCy3l8j+JXm1FylmMaloO0o+o/DyWUN7XlE5uWIzdQ8k2UppXC/ElVGEVgexIDqR4F23sblZr2iwQFwrc/UWuhliNs6gI8PZQNu5c7xsZ7Su5h1xmueEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1aE2v37axUTElDV4xrs1e0vBjNAvZbs1lh5zQC6OPA=;
 b=wPtmf/ws2dTWFDBMXLJQsZ0Xyu0cixgf5wSKGZ/GB7wChDWxP1D84opj9mJseZ9lpZXx/03DLu70RW2mVWeByglc7AHss/bx60+CeHhjNdW1JgasVblaazaxh4QcGUXaWJUZOCeq+nzQjj5mI/GME+1Zc+V57kXdCKUiHXm7/EUjQ89hBFtIWLmDJq+6VmF1sRmkxieDF7nfhgYT93PhWM6OpxKzC+lV+Ked/Vua9kINBtGYqcw9EsP5HWWUJ0Pu0os63WHzzV66e7sH152e4o3uyOiVy0lgzw/CjQvGm8YsEjkQcFXNf7Lf1DJPv9awF6rK2hRkkRWQ5/R7UTLq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1aE2v37axUTElDV4xrs1e0vBjNAvZbs1lh5zQC6OPA=;
 b=ArbWaV4lJtxT1ULTtrMharuGoUFEvbtl//XgPJuzZSOVKhzMnArR/cxHEMgHTkNNppvN9lrvj5rxr9Leg3xiv7FpZ6NyO/1umBY8aKGndk6lrD0H4ZV8gMoE3W6/wBm7kQ6fBr1AOVp6HFCr2wcGJxgEOjVbty/g9Xxj+/xBW9u5DJKbEPXPIX2j2y/AnMpGfkJoDA4mWcxvsKs/F4Enq26h6auh9O3F2S2obit4rzFKDWukQNoJ3R6dn8lkaROXj5+QtBU2p7WCnHKklFO1lC9FdCqgXhzGfGwqm/GR0S8Wr6v7LMPe1WiM0Zs9ej5J0FN9jjLOD1MyJrtE+BLY2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by KL1PR06MB6274.apcprd06.prod.outlook.com
 (2603:1096:820:e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 07:39:53 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 07:39:53 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Chen Yufan <chenyufan@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] virt: sev-guest: Convert to use jiffies macro
Date: Thu, 22 Aug 2024 15:35:32 +0800
Message-Id: <20240822073533.13148-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0122.KORP216.PROD.OUTLOOK.COM (2603:1096:101::19)
 To KL1PR0601MB5487.apcprd06.prod.outlook.com (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|KL1PR06MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: d77aedf6-abe3-4a94-a496-08dcc27d9c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fIDuP+kR8gCqRjWvBrGwih+fCo4ag31YgpnafBzVACiwIgaMlyUuYSEvp6Ze?=
 =?us-ascii?Q?pRFwIzAfHvfZivv1V9tPjxBEPnkdhtm7htIrZb3KPB0wD38TxkYqiKYe6536?=
 =?us-ascii?Q?ZlZzgaqtwFfPJ/Q+CmSnJI5bHFeApaBcXiSSgaFBNvZTyYVS0M/eQkY1xVnS?=
 =?us-ascii?Q?zta/2vAtf3luyi8NRZBJNQVBI0KtnAeHdi2d2BATYUNjQZbRqd1mGrMgbljw?=
 =?us-ascii?Q?29q0wK+yk+O8UHy0cS2sTIpd4/WN9HbpwEpH4TB6fPLL5hjx997KDjuzZBzp?=
 =?us-ascii?Q?l/JIEAcL9UDTGEHUVkaaN4nyTUyZfFLvCeRzqYcwU++QvMS8w+Z7RrrHRlkD?=
 =?us-ascii?Q?hvaoBEmbStqNWBeCnERg8sqAljPbe3jJUTkp8QwntMfeD1MsWwZWyKvuexBG?=
 =?us-ascii?Q?RuR5cTXuFbeyrNuhEW6Nzry5imKrfZvFSN+cGVD6RUxFP9PdB9oCTq2vsBix?=
 =?us-ascii?Q?z3Ll6Zob6G5h2MqqMWgvSmx9CButoiP/myPtBuWFnrJMWPnhq9ea+S18iRrG?=
 =?us-ascii?Q?pyJxUxwSqiz59Odjy1IbUrc/1HiLA3AzrmjRphMH7DXTVJakesp7wrHY+gVs?=
 =?us-ascii?Q?GKPuh/h8T6xeV41jfNq5XvwrvaWMPbJEgsZAwlE3YiJ3oYz323+MjS9ciBho?=
 =?us-ascii?Q?scV0OfDbZfd2vRXzeMvK0pBkwLo+AYLTtId/Cfku4U6xnjfV8O9gRi5RANKP?=
 =?us-ascii?Q?3YLAWDWWJfJlMP6Xy78mNPA2wgRelV6RxGerHER4qpWnF8Ul/gHKsRoZMMGj?=
 =?us-ascii?Q?pAU7G3ZrjhTiun0JM+UIqIYL97sWRmvihJM3sl8x577xo15pbeK9EmxK4uUp?=
 =?us-ascii?Q?xUOuW/HN2seIiI56VtOuYZPi5Wfd/dK32McRjLZv3p6VcrF/4OvAOJ6O0JhQ?=
 =?us-ascii?Q?5KchukFYPAAqO6wXPSbWIaE23kgMFYnJk730/puW5AVBcnRxbw6yWKZ+Vkn/?=
 =?us-ascii?Q?euPRenapcmbSkSR2nVhJxNxdNUO01O8NIVS3HKll1IadDJzRRg4yl4lI/QTD?=
 =?us-ascii?Q?9tMLO/2RVYCdkCLqjANeXvIzDpPfyR4XGUaburYjEworJZMUgMG88yiTG9zQ?=
 =?us-ascii?Q?q0G2/A14gnAGVQ3I24kVnzlx9tTBCJ2nSQTYwlUY0fWDFnViedtu5jmIZwzT?=
 =?us-ascii?Q?cWXDmWOQrII6yvVNjJnGYjoTBw4fVF8H5HplHIwAlgtrySrgY0bod4tAGFp8?=
 =?us-ascii?Q?b4Jyul/x2BvgjZcu+Xm/AYc9LzpTZvDYWKwm4/nUvGuCxOcNlmVMcu6aaiz2?=
 =?us-ascii?Q?AlegxkvVP7C/mrD1AyA4mr0Ymq9RsfJlH1jApH5yHMM55kF9NIihc++WfSe0?=
 =?us-ascii?Q?E1nkYyBvDSj88R2btc4ICiwkM/jledXtZ4HhAX4wu2JsBnwqJjoSL5dGMrYB?=
 =?us-ascii?Q?3G3H20NKrnPi/yoMRQ+I2UhqgIAY6oJfvFrOFBKmBXrxCWV1rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tff73v5V/6/60xfCc6kvYczStqTcfRCeoIFj4C/TvN4H7BWCAJGR8LkACKI?=
 =?us-ascii?Q?b3Tv6f2OZ7m2bTOWlaBct+ZwPT+3bSHpEJR0Vt/Sz20zXxzgIs7JGFYWmLU/?=
 =?us-ascii?Q?haqwYosY6LIqTOaVBbO9kvYjizf17CGQewVlejkVvMVWX1Y0wNiMVhAD4rHH?=
 =?us-ascii?Q?I2WMItJ/f2y9ge/DyNp3xsm9z75DoVyH57cLIVb/ha7puxEUrpAspgtMlROC?=
 =?us-ascii?Q?oe2UeCa8/Y9G8sCdBBkU5odaFg6v//ATI+rsNbvZdzX0MPvy6sFfbxd7rVgv?=
 =?us-ascii?Q?8+6a6du800LSPhfSj4tVQyEWUlFroUlkQ9wK0F+k5Kak2iwsc6BA4oYUh5yM?=
 =?us-ascii?Q?rpaV+PnMxVt2WKvmK8pXUmjY4QH0ql0fF57l1OKnyYy6Pg+jrS5jWp2EQTnz?=
 =?us-ascii?Q?KcLHBYGeNmISxaSWjJFXztt/L8+uNfphsCFef9pQZP0T3ur3e5r/tvgCntQD?=
 =?us-ascii?Q?RGS01GU1dVA32/moZzyFZzDhQxmUC5hCObMPlvQQv4Ws24vSg0pnYs5kEdnV?=
 =?us-ascii?Q?lEKkVUY92MldMAbBQZo5KDyuYERhdvngFwcwQ992Omnw8Olz8hGFVPT7vxFl?=
 =?us-ascii?Q?prRiztqhvMd7fL/eG6PTCzTMUwcKStYzJz7wsvl5583XKh+9YtSm3ie7UF8h?=
 =?us-ascii?Q?6TyBx4pUVGN0KLfKtTzzTmqq+02mpnv/SigMDrG5u8JzdkNCxZLiJuCY5gCK?=
 =?us-ascii?Q?tPUP7Ni2OyqbAQuSRlTF8vV4ECeOEoaMa54hH+ZwxU/Z2KWoH3mk7Mwy2tEz?=
 =?us-ascii?Q?1W3y9sNIiYLuXEPEsg/QWnn2Qc44FX2QJOrvPRtRpchOjsSZude2t4ZceQQo?=
 =?us-ascii?Q?Dtbqi4ToJMLB1PhTic0lYGhjMJEpOrlZGJKq7xKmAHozWumDPrXKf7QQGfzh?=
 =?us-ascii?Q?x4ucFXVyeJc+dvRuWScekEWaRdqzPNVRJbqODAMAmgg0uGDlIi7oSaYHdDSY?=
 =?us-ascii?Q?PP+8dQ32WX3Wfj+VEX2Wp6K3YT2BqNr4/XBf4kbI88yLteZPb25rn5PXlQNc?=
 =?us-ascii?Q?tnmrZID5uuKtUSYpq958BeVOvWPYm/41yhEAL2pxtxxQPdX7EXP+lgWKKlQe?=
 =?us-ascii?Q?D768LLSwt3o8NRAhlyDbva/n3D2laAUOWe8va70ydSE/G9o71Z1AfwuErEAy?=
 =?us-ascii?Q?dQlLTOTZxAZaayaxfnqIkmOjJsnP2R4LySBEFg2rO+x42AWGROnNHfhJx/+r?=
 =?us-ascii?Q?bYilGvWg+ThCP6+a6hr+odwbNCnvsw2pWWlQIH+KF6SeE3dId8O6utFNdSKU?=
 =?us-ascii?Q?aEOQH7ZW4yZYKnd/95reODObpW06HO81hIjnhFgkEi9HUfBVCM/cPvp+yrRA?=
 =?us-ascii?Q?Tfnt5Z1YT7XO03NP4wF+jnSyElyfHLe0jOFzL4JcLNOftYbN6D3k3aMhmDzB?=
 =?us-ascii?Q?Ca6tMTRrWc9K/3OHIax9GdcoO3wcnZG00F9NgP+0li7tSbslL6y58I+XppnR?=
 =?us-ascii?Q?IRBIDbqVex8TjnpX+9REI9ZxTjMEkJWNyuJlhlbuixc+xqTxesdZAsj/qa2P?=
 =?us-ascii?Q?TP5tqQW3VY2xWEbOE3mSc3h0OzS3G6hsfSYtb2qMGzAO1ETFo+KWIVfGwmF2?=
 =?us-ascii?Q?VCNy6HlujVlbKwFs0/SVCIZonw5YPnYahtd8yITH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77aedf6-abe3-4a94-a496-08dcc27d9c95
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:39:53.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4lN46+R23kssDeWSHVAVAcciY7r60lY8Sy1ov72htUhtlc6UUa5XU+UvtMmZDssssMcCEs1/5KT/jZrDPOwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6274

Use time_after macro instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 6fc7884ea..937f655f2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -24,6 +24,7 @@
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
 #include <linux/configfs.h>
+#include <linux/jiffies.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
@@ -400,7 +401,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * message sequence number on a different message.
 	 */
 	case -EAGAIN:
-		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
+		if (time_after(jiffies, req_start + SNP_REQ_MAX_RETRY_DURATION)) {
 			rc = -ETIMEDOUT;
 			break;
 		}
-- 
2.39.0


