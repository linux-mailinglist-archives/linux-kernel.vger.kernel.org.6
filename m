Return-Path: <linux-kernel+bounces-369264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710809A1B03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB45B2539C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85691C230E;
	Thu, 17 Oct 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XLN9ZOYf"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094C193409;
	Thu, 17 Oct 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147880; cv=fail; b=lDqbNHBuMiSsMSCiFtDEbrHkwfz8CmAZgljtXnVwAZ1t774kMFekGCTTyo2pVCVxF8p6n6kalzY3btuK0qZ1sP4bhe384h6mGSak4KiMDYVRY6g0F9w6QyGJLRH0sJhZ2cBArV50aRpH3wKojYJeVcDO0ocO74EOeUEoCnY8+Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147880; c=relaxed/simple;
	bh=kox4S0U50cg+oceZbn73PPi7fpT//cYbkBaA5hfu9nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ogArEnocoYnFNXjK+e8M/9x9RK7u+zLddhufjWOzAi2bKxGnPHZ+RZztZ9N0tgsPil1THFzVwv/plsTQj+2Ji3+FQHav+m13JsFO/UEYSSbuXMQZqYvUBS88VEpJ4h0EcE4Vav/bq75kZGCSB8abDerlWCqCek/m+iQMlKPQU4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XLN9ZOYf; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZeOLp4jMOmrTZ98KwPSbDdrIeYqhYzPkb9eqgq6lZxSwQ7dc4XMt0Ike70mKtdTD2nTyr6H9IAumXnA24qbgApJGjkaFJVd3uZLh574QKdz5M83kAT7eEgNvh9gS3AemoPs0wKx6v/mddw676LTOUmkCW+YJfZQ3hkl0XFCKw/tH++ZpGECP7DhEnvhFsnAjKNxWlXQRHHxN0rDMkogP9F81lBUEOSlFWB3QW+hsrFBFtKYTo2gNB+6s6VgkyZe2/r4vXuBdkr9mmRNsPRmUUq4K1xqmE47/WvdelZVz3lxI9CZCIdT5JJaOoH1v7GERJywpWeKRtnPYduW3Gg6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGOreLL6v3FxwLAj80VblzRDR94u9mUNZuVBNQCURjA=;
 b=sk7lzQof36s43jGsyULndIDijSQALLPuyotOiuqWgzO/Ael7ZV/xjrEuTV/NPLsqpkdJzal0jmLdBRNgwOez5b9qEccktRyTOpg9tt+/gLe8CE546f/1tntTR4xT4tkp/l5tUWcEzEHbXKy3DLqYMgimsFRfsNKCsZ5s2AkbK2RIu7ConLRQ3UMAZqxEY59RJI2FNg5NFqvBA/A1hn+IIUJWS2WDm+oUnSXqT49lseCLxo23IMwT+5Q8vYkKWxidoO6HpHqPsa4+La8F1SUeUjYWb/Ed0yplea9qU5UnuXux41pMupqu9B1tlYFbyytNz77CpyyvulH0nL1d0F9E6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOreLL6v3FxwLAj80VblzRDR94u9mUNZuVBNQCURjA=;
 b=XLN9ZOYfnZeWndhMBjQSU4FqwAWsTqdj08Wvilbc5kOvjIqGt0K1muvJb01ZFRZoWwfDxtwoCWCdbowQrW5mQYYcgVP04C4c8skDTWUTFYgHZ9dyQmEdSafTEchsTydx9/9rgprAdtNxoN5nOxy09I6RFR5MIyAp8QhN8xrzsVTryG5mMiSYjFqY00I2p5n7YLEU6+LWP2ABRkTM2t3AmlQtrDlCXSpg7+7iXbBXjiHSv1fA0AWC+IaJImkzJhFjXdHN6EP1PLTJb5FmJuXU5vpRoOEgF1PNiiZhByfwrwCWe1UzL+bgqaUbcFR63FgcswlxK8WdImPBl5O/I/34pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by VI2PR04MB10148.eurprd04.prod.outlook.com (2603:10a6:800:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 06:51:14 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:51:14 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
Date: Thu, 17 Oct 2024 15:51:35 -0700
Message-Id: <20241017225137.1158924-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
References: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|VI2PR04MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce4265f-00c0-4f05-352e-08dcee7817a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aIS6/CehfvkLWKKN+QPCWjRz/9RsPO6JswgJ+mUCvZbHzc3yxu88BQgBCzdt?=
 =?us-ascii?Q?1LVcC43oIQwkLHi5IRNGKLNW0FGIOI7AU3KC1TK7d3I4HRuq4azvSKdOMsWj?=
 =?us-ascii?Q?qgMIyOW+fFc5QQ7HjTcZlVWBIHVNTALOrKzd5U4D65jZ4zlPz3L1XT3pCFGQ?=
 =?us-ascii?Q?KNGgQC/uRnbuG390Z45vmELj87RMRimguqgv/aeRbB8Nq5j3bCC23Hs8Eu9K?=
 =?us-ascii?Q?aqKrCOLg5N1+OtLQ1ya4QCjsh+cxUA1wvOuYsKXY0V1AwX4HCVSJNMsbmeFk?=
 =?us-ascii?Q?RsHJNmJIOdzpqK1XCckMf/OfeOFY5n9CdpAu7/04AEIK/emcr1uiSPt+TkjN?=
 =?us-ascii?Q?Ob3yPOz2PXmmqVB9WgJ4LJwK9Rs3aiajY9k8vJ13N1oT/SceqcNtNbOh6Dd0?=
 =?us-ascii?Q?tkOQ0XBUzKX5hFOK8vc0gdhIhP8vyt2mzStTVE2XsckqZ48OgTmGoVva3U4k?=
 =?us-ascii?Q?dCEgfMP894GnONxvDor1Y8tlzDaERufaxnn7+BmAaMgXzhYuLCU4vRVJ2zpO?=
 =?us-ascii?Q?GmSrOUXYEPW2xnccFltdcmOmia7lpUAPLBItYQUI/ItZ+bIg/0uVicPB/w+D?=
 =?us-ascii?Q?TI3NLNeO/JYs5enUbPgWTQzhDnPYwuQ9sbH6WGBHL0jxuymawgt4LA+5QgLU?=
 =?us-ascii?Q?oOJpUCgvJsCZQi/2ikEdnrqdpmthuIScpDuTdtGhrNrHfCgmayyn5GQDxnwL?=
 =?us-ascii?Q?YCX7lf7IaUbz/364mvgS+MXigMOcIzQYScs1epUie71MjjUaHKjTVH5j3jCU?=
 =?us-ascii?Q?nWA32xd1evAbNEUs86ta1VzMScysxD1xJziZzuYLp/M4Ox8Oq05T1BMZOaPt?=
 =?us-ascii?Q?fQ2cPCS+l1vw/uMZZtq7w8GmHAmvVmG0szchut0DbTXeWfZesK1sNeIbV4ev?=
 =?us-ascii?Q?Cb8ct9izEhmE/JLXtg+gxbHfSV3B1wJWSl6WTMeTL9QkesypmriySdMxe55o?=
 =?us-ascii?Q?ZNTVN64QvxhfAq/rgpe9p4tXg/u86RQwmUJy2IK4ZSYKkHr12ALEEZIgfenA?=
 =?us-ascii?Q?WC+S1ASCXDYWrifGL0PZcKYeLmnWs+tvMu0Ha5rMLLrVdBW7lWUcdNmwy+Eh?=
 =?us-ascii?Q?yJc9eNDRr5YIQ3GNXO0cC5fXQh1RqHmdBer289Y8evpJqiQdnwQvogKV+hd7?=
 =?us-ascii?Q?UMTn+1mvVDrilFLECDK1RRAl0gT7eyLA/fRX8bCliv4C+ezhz4z5uKXYek8B?=
 =?us-ascii?Q?es+zeUZwRFFt5Ex4oU/QMrMdAc4repfvb2kp0Q4otiynG/YbHZGDvXo6PS5N?=
 =?us-ascii?Q?vNBrOD8p/kovISsPvR/LAI3CylPDfPeamyMB/aUSFyWfK6lJQ9WA0tokFQaC?=
 =?us-ascii?Q?C3nLrYZaw6fMYkLbhjL1qaH+vX4CWk+8LEqwyugT3ggQbMxYzwVxbjFWxN6T?=
 =?us-ascii?Q?4DvMXgTP7RKwKQzSt7nXhZa7YtKB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qqhZzXTFaNggOza8KEfimNjoanqyvAq6E2C90LieaHqlT1nmVq90/dISSb6c?=
 =?us-ascii?Q?Pxisv8gA4z5hUcf31h1AupaHCCBLZOwq/X/X7b0xBLtACvRqeF2LHJd033j2?=
 =?us-ascii?Q?rN8Mee/uv4si3is9tKe6Ou1LclLdR8JvedKsKi9DGpJiMIEuIuUdAK8BJ1aR?=
 =?us-ascii?Q?qfqC9S/nKbxuzL/m6iIhFxQqxhCMVYWNnNHi/WyRNIugIsND5ezDhvP56gDk?=
 =?us-ascii?Q?OLk9XITiS+buX+wYH03BLsSbQcGovYMFKYN4V+hI6km+oQsETnlaynPCq9FS?=
 =?us-ascii?Q?7McBnhLLaCpc1ZK2meYJPWIOxf2QyuZ2GTuG8Abw3XlDqwAGpOcxDKg6M9Su?=
 =?us-ascii?Q?bsrR3q2gzKMMOKme2yOPIO0oT8blWtpHfsE7yLKzhWTfCKdbaLpP2G8eeaPI?=
 =?us-ascii?Q?iHLn5x6gu7T22gELHrDPJQi5FqqXM8tAihb8LEzJTfm5epgHOLcLQBPP+ldG?=
 =?us-ascii?Q?ItVhyLQ9o+chNS3U2kEahPkVo8l6lzmdyLEk9B+f6BE/pz2Fz99uEV09ZNtZ?=
 =?us-ascii?Q?s/BWBBGPUuiYIeH2l64xcR4x6adV5YOVZyRp88xONzntBEiLPb0DWBtozDgi?=
 =?us-ascii?Q?5XgbjauQ3Hxc2XcXocjkTlqErS6M/loJRFpd7Bvgy9HGUSN4I5CvcciW+qEg?=
 =?us-ascii?Q?fr70D4VROn9zddJ9V5xkgQQA54q7WjP7oAbdFEubbtVjXddeYzIWNf1JPbNU?=
 =?us-ascii?Q?4FkOybOMZle9fKf9XKTI+WwfdFiZrWmnz6YItNSJov3aU4sjCiSjqbISu6jN?=
 =?us-ascii?Q?fjvrny1sKhojgBPF6jEb9wYawnR1A9UQIyG0L7DAQmOt3pRardzOD9fTgjPE?=
 =?us-ascii?Q?0qj+ObYMktRo+Mn0jUTBZFPb+N34N4UQhiRC1zfvkT9CapDkWgEhUu5UrnUx?=
 =?us-ascii?Q?hkxGhpRedNp0Z9qNMQC3DqVr4zjJAGMNSBEDgL/2pDBCQje+NaP2M7wpAG7U?=
 =?us-ascii?Q?IDlcao1TdFKwzBiJaBjJUPgfYlb2RlBIYxqYTJIx6Ben/nbIcmzPHVTui8pd?=
 =?us-ascii?Q?hprcPd/ERcVhv8tU98eF2YtyW7o92NsGhMM+8oL0I8FaZhkRaAoaC8VAWoD2?=
 =?us-ascii?Q?vL7dv72b0mQ79hpHoGPDHL2DoUYT+0QqRpeZ4Rm15xrWdRgvKTMHdBbXyx72?=
 =?us-ascii?Q?Fld//pnbujV3BKX+H+Gft/12ovR6bEbCwLWaTAlSZB+F61ruxT4gAx63NNIu?=
 =?us-ascii?Q?djOvptI6rUNxNsLBgu38YMcQAt7iUS3pHp6k5rx50BnlShGaCjwStT/oassA?=
 =?us-ascii?Q?hZVkPqR6adSNVlGwFLKA+egeYL6RSnRzbLZfR92gwHD5Q/W/KN6XsJ9KPeMU?=
 =?us-ascii?Q?sum3JwnuPEnNt+HMQmTVu9W+/V79MYbJEYRz8AEjrCWpi/TUYTX/HYO4LuQB?=
 =?us-ascii?Q?BQtb+k3W/+oVjzquKpWa+mTUnNyd6NKZcrUlZBAUpfd8KwdB2chI/im1IyA2?=
 =?us-ascii?Q?sFWVwkyTADuzssHYQS2HLoOludT8c9+SyHQN2lRBvrpt8eeB4/sSDkIzqvWn?=
 =?us-ascii?Q?b4fOLbAGn24ROmOB22uqbbwBnh3WQlEBvL7VekJlP+UHmmhgNEZQaGByd2OW?=
 =?us-ascii?Q?J0/Nzmvv40nylUkAZb04TfdK1n39MBEjlyk+MZy1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce4265f-00c0-4f05-352e-08dcee7817a0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:51:14.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mppGtlF24mfaQzOWuCIIaINuuuUg7B1Sg34FalasDI+B72Oy499/w4paEjw1VMUHVPfC2ZoGi4fuwW77gyW0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10148

IMX93_CLK_END should be dropped as it is not part of the ABI.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/imx93-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..a1d0b326bb6b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,5 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
 
 #endif
-- 
2.34.1


