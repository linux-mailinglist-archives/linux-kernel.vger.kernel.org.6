Return-Path: <linux-kernel+bounces-238729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF374924F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7631C2222F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275313FD66;
	Wed,  3 Jul 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dYrlpg/6"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DD4AED4;
	Wed,  3 Jul 2024 03:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976111; cv=fail; b=dbQGLAohXLpZmaOK+425OKxV6wVAjLg9od3KzKByjh7qw8uey8yYuvue1UaHfw3WlhTHbPMO5ewA1eU8BYWbxdi35lL0jt2tbe0fIjvvt27Jm9l+BSwiOpizzQ+SLFvzwLw+mqDNI2EhSP/0E6dv7knhVJqKErwp7tWnVqb0X9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976111; c=relaxed/simple;
	bh=tC9zCkJso5zdujyrFN1beU7HLtEeBpbDFTLrob/+B/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8LhCzmPhXhgs6nhvkwebKf0NwSBUXotxlPDu8mANax4g+6UPGnZk6W4FgCO+hjIDpdv0jf199c1cMtKfeS0ZyhEyqa7kyouASTJrfvBg0qBRIm0KzA4iRImqA008/Zu1pJlf+kQV2iJ+pXK50K5JrrN1JXPG1oEegNaw4qI1oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dYrlpg/6; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoaUKci7F5MRwnxToZbHFZlMkWIaBLTK2MfUL49Fii/EUXxWq+QxNvRO5sYIvaIY3AEmag4bB6phU+LKJNSq9j4aewb35MmZH4uJfT8Aw/NaVPUInxaYy/Ic4GV+mDYvvD2amdVhgOgoAMoIlX4I6uP5EyKC5SGelX/ghFl/ndjK2Ch+5M5R4uVFM+si0STPlTUrfubB5M2wuSeB8Phgn4xGYBh77AyZ8iphOdkzr4Cf4DzWqrjcMfVP6mWEc0Dw9jocVCgfWIumvP4O1UkPO9udjaqaSYHB6Nm2FDQ5NHRXJ6vgMWvOw1bM7nGfHT866hhDVhz7Ly9DzIQnnZApkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTAKJFwOAaDeAHn7xR+hXAhGCnbdi1gKav6+I2dj84o=;
 b=niiljXhS9EXyulSLkx2ROOHn1DwskS08DP2rXvT/fGb5gUXk7+umwudX27JUZjdh024ZVWM7nP4EJXY0diMsvHy3BtBl8dStX8IZkfwPNCspyLo/4fl+Kyr4qi98ZXSGA4m0Lyu4gRN8gXdVnB8sLS2P0j9ma8ifgkZmb8e8QlZyFgVNRjncEjbf1yTy/dOh3zG13ujD8gQiNxjG5auSBNBzoovqUqNxOQnStNVZPTY4fmNWrAryWH5ujYLi80d5L936kGnGeSt5WhGTujlZflMZqFC7o8Bvibmx3zHINu6FADhnXQT2Kyz5vu1w7+GXEs5TF1krYvAVevA92/QGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTAKJFwOAaDeAHn7xR+hXAhGCnbdi1gKav6+I2dj84o=;
 b=dYrlpg/6OC4IQ7XlKC0V9NdpUSuL7tYFObv4IRTQmNsgeL1m1JLZqrAvQkE1DN4TQUTdYp8N9N1MYzsZhBvBluOyzoFPrQRuR2iBz+IXTvnUcjOLKh+sST211ZLrqN/Pq/DjHwu+CtVIpmM2vFW/4XNBMAODEe7XqbrckzsWcl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 03:08:24 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 03:08:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] firmware: arm_scmi: set mailbox timeout value from device tree
Date: Wed,  3 Jul 2024 11:17:15 +0800
Message-Id: <20240703031715.379815-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240703031715.379815-1-peng.fan@oss.nxp.com>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df74ae8-6d7f-4456-2ee9-08dc9b0d66e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzRYSBNLVo0HAMw97z7WNNKJQdiS4r1lPRwHHlJ0LlknBoX3KhBhAPbOMZN2?=
 =?us-ascii?Q?wVir+D+AvH5LPt4Tfh5TCKVPstE0OLrMXBGPd828vPGua64kUro1ErPy46dN?=
 =?us-ascii?Q?aAR9ENuNshUjCTvWRBjWcDvwbStr7XY+sEMWV/LFRKZpPTxRZWruYC9DTxin?=
 =?us-ascii?Q?1YNK6eJNTJ9rhPOt4N92OH5eMijQX0Smc7ToIJYqupCo+YP7Fv3FLMxjqo0T?=
 =?us-ascii?Q?GIzWRgEE/k4stY1d/MFnak7EgqzeWHLCJ3pqBzW9Cw8eMJ+JVBF90TtA51jc?=
 =?us-ascii?Q?ndZDt2f6ZNfffIyD5bwksDgO3eGlAslI+Qnom3ExVCQcii5vSXJyKXlJePQ3?=
 =?us-ascii?Q?vAcKoy+mLrGIG3m1MSdBEdOQhxsCQTtdVWolkxesxiIVre8n1Tc8xkUh9LZ8?=
 =?us-ascii?Q?R/iSQAt16VDH4+qvSXGERPjTo97jBcMlBFcdKqEeJGqlFS3G8ZEd4J7LOAZC?=
 =?us-ascii?Q?9uKoZGVbnOS+WDCtbZtfboHQ9IgIHIqqqzScFyysb/j1EGuPh/FGCKWrLjQ7?=
 =?us-ascii?Q?tGiuoN9UhSR5EoVxlbBwg9fUPi58VHRoAywka7fiThZe8ysC16apF3ki1Uns?=
 =?us-ascii?Q?EmfOcMsuUqo9+fcCk2lGiIIbg+scIMcp9Q3F2y0SG8Kow1na5UgemfSVVMRF?=
 =?us-ascii?Q?ljTsO6o1VMpqT+KyVFpRCdc/eJ6mA+OkI2M52jHNby7ABIGvnLBVwCPxyV5a?=
 =?us-ascii?Q?4tfVaVdVeZEQyfBgai67RDrh/HNPkJ99S25qfAZ1D+y1j1eVPW4DrzYtXoFT?=
 =?us-ascii?Q?RvHkZQ6q5a4uKIoxmwXAK65175rEuWLeOD1b+jU9aEKS1dPK6QiIBJ35CANe?=
 =?us-ascii?Q?huMHYfbNgjmvRgppZmWBY3RH7w4EWItzN+1mYqgqdQEeqgzpEv5Gkrf+xgqJ?=
 =?us-ascii?Q?Rfw4FSawMHG75tIcPxDEOr7EpAuBwMsOXHioFQuSywAAb44m0xrtuR1UEaom?=
 =?us-ascii?Q?DT5Cw+RP7jb5x45dp/IgVXfiFrLrKhulzPgHTR/tLBFg/soDkHZMfcduGnha?=
 =?us-ascii?Q?Iln/dfQj6RIsztTZPJXlQR3cO9C2znJ7UfOPLMqrQI4VXDdkGZ8SQdeQjTG3?=
 =?us-ascii?Q?w5yOU4rG2l0Ma6obI634RstDdUD/7Q2/xdW66fa6akDmbNLSkMFtpW9NyfZg?=
 =?us-ascii?Q?NvOKwn4/9fa9LCgfhuN9nLJuYyKQPNi3QGYB+RKI9PVplY4amrhQUU0I3y9O?=
 =?us-ascii?Q?92dBkBZHnS2FhBdHw8injNNj6hG2Q0ob/oB/QYXW/uP1FtLBNe1nhB6zSAdP?=
 =?us-ascii?Q?cTUAaitWe5LKjbGs/R0pCyt3nezBYziky+NUTBcGs48Ud2kUinQFF/mXpMEJ?=
 =?us-ascii?Q?6P4CRHNq9CRyo2e78tAjExR4iqSIw23/lg3KKJRXE/HjwYruqQYnZpUPaZew?=
 =?us-ascii?Q?KFLhrUCArv7bic2afvB99xSdJzLzd38eAqZpEQNW8w0nzHb47Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gu/oRuR9D8OpMLGsDQCcmK0BHM2NMNR5URf0GRzxUj16MmgJhC+AGX2LrEiJ?=
 =?us-ascii?Q?HXTVMf1LdoQgqpNgt+QmmErJSSAtClkBL5EutUWVHJN1ng2xNMw/ftljT3td?=
 =?us-ascii?Q?85bzt/CFMw3UcyptkPtGbtV+UrvN+nUhKevwXJbI5F6Q+Hd1V9oWFOr1LOaK?=
 =?us-ascii?Q?yMTZK3g6g4YbZxfiuPhCLJhl2SqBzO27wQpfjbDc+W/15KlbBUaQj/UY0bbw?=
 =?us-ascii?Q?P8Rg+4clg/kgsqUzIKZcNYszKnfZi7c9uE1/q3//eNb7ezLFbNC0QS7kp0ac?=
 =?us-ascii?Q?KXSQiwEmFIPDzeLUtozSi77KWAz5ThXiwJY/emSDbNUgfLxZikxTJkPsPqUo?=
 =?us-ascii?Q?rysVBnpcSeBJwv4z+ZMGC9ucn73u5Omjp38A2VMLmXoe5S8TE/D4j0r9vNdm?=
 =?us-ascii?Q?TEa+VSpSgcsQfKUtZ5dwVqcRl71027CZVLvI/ZN6jTfavioRqfVEFIfqqiR4?=
 =?us-ascii?Q?nT7jIz0dfObzjSD0CuUSPIRYBnOKC42OrT6JH86N+GsGIVsMumAIZqlRdY8G?=
 =?us-ascii?Q?d1bo6WM6cSHAHhtu7+54zbEfmJz9h7jRjM7bH8KuhrmYMXAYdWgsetenr0EN?=
 =?us-ascii?Q?UarodARph6V3VXUkZ95BBjibG41v3alEM63o3sRQHljDD9oqefgnbQOSUmqe?=
 =?us-ascii?Q?RicOS+BmMwyeIqsPjoetY60z2TJIkU59bQ+/dRbW14rAtKmrVW+M2UXAd15S?=
 =?us-ascii?Q?ncDa0TL36fC8+2Slp2k/3VGArPiaIXWSir2rVjvxrkm3tBp5K14VpYWhH3y3?=
 =?us-ascii?Q?rvKstmojeTmOdc2bKEb/NNGUXeD/U20mobs9dQNkj58SdO+GgTLsc2ZJSdPY?=
 =?us-ascii?Q?HRvHZj5NZiGVv15Cv60jo7NKAztd+QH918+XDghcKPOziMIy1R4S5UXU+pKz?=
 =?us-ascii?Q?/2/7yAN5ImTBF5mh6bECrhHhWubi0ZKnbY0faq5frigU8DVARUkN+591eGC2?=
 =?us-ascii?Q?bfjbSCJrMiWzEkeRKw7ubJHmCGIBNkWgJzhPHKCIYCjFSCkuGV2Os010CVUu?=
 =?us-ascii?Q?MtisYn5coKsMpv7b30OHOlHmpFdNkzY4wbe0PYskQXfczZ5EjoLJxdqBDyH3?=
 =?us-ascii?Q?VNKxwyz5MEgynQGIjGD4XCDF3SMxtEeY+2qc2+k951xRCAEfZQDONnfKDzYj?=
 =?us-ascii?Q?hBftTgDAYxscUQhd1HXShYjQ2g0IoXnVVZG1nQZV/XfXgErhN1Bs5MmQnkjT?=
 =?us-ascii?Q?MGzENv9GFpERfD8MhxhRby2aY+u5rp2u5rSBbfcIFZ/9QDOqW2GU3ykVIS+H?=
 =?us-ascii?Q?g7xBmki7MO+4HUg+B5O3dk75wFk9ayP/TyKmc15Qh+jir3TD/JIqCPunOF/E?=
 =?us-ascii?Q?ipVkgQE7RUgg9Y2sCRonLfcDyNkqfL/Ohi0132RAGXeEQtV8hvDQsJ/cHMeK?=
 =?us-ascii?Q?bU4Wuze6Ao0M5UB5FiyRlAnbVlAWeedK8935NwZaxQNRthP4Qgk4ryXB/5gw?=
 =?us-ascii?Q?3K3kVYfZJ+YOke+mdvvAmSC4WMw2ND6gDP/pYV+FOrhuMDHqJZkB/wVws/iR?=
 =?us-ascii?Q?yTQfcPpBepr6B7PDs2kljqGU4t1VGssPk/q7zQ2KYoCvjpV9rOP4oOX1ZbnU?=
 =?us-ascii?Q?KavWJIEFVrFv0PAB1bN8ykDiQCCQ6JjLmDWuxE4G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df74ae8-6d7f-4456-2ee9-08dc9b0d66e1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 03:08:24.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4+bvHvsSKojWmZHHp0baOXMLO40Fe3eH2IWIJdIdRhMaFdbrFA012cwi5C4T5EfFWAUt06pm/81y4+0187OwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Peng Fan <peng.fan@nxp.com>

Each platform might have its own maximum mailbox receive channel timeout
value, so get property max-rx-timeout-ms from device tree and use it. If
the property does not exist, use mailbox 'scmi_desc' fixed value 30ms as
before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Fix build error for raw mode.

 drivers/firmware/arm_scmi/driver.c   | 19 ++++++++++++++-----
 drivers/firmware/arm_scmi/raw_mode.c | 13 +++++++++----
 drivers/firmware/arm_scmi/raw_mode.h |  3 ++-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..1aa613d4cb43 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -162,6 +162,7 @@ struct scmi_debug_info {
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  * @dbg: A pointer to debugfs related data (if any)
  * @raw: An opaque reference handle used by SCMI Raw mode.
+ * @max_rx_timeout_ms: the maximum receive channel timeout value
  */
 struct scmi_info {
 	int id;
@@ -188,6 +189,7 @@ struct scmi_info {
 	struct mutex devreq_mtx;
 	struct scmi_debug_info *dbg;
 	void *raw;
+	unsigned int max_rx_timeout_ms;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -1302,11 +1304,11 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 
 	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
 				      xfer->hdr.protocol_id, xfer->hdr.seq,
-				      info->desc->max_rx_timeout_ms,
+				      info->max_rx_timeout_ms,
 				      xfer->hdr.poll_completion);
 
 	return scmi_wait_for_reply(dev, info->desc, cinfo, xfer,
-				   info->desc->max_rx_timeout_ms);
+				   info->max_rx_timeout_ms);
 }
 
 /**
@@ -2614,7 +2616,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	if (!cinfo)
 		return -ENOMEM;
 
-	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
+	cinfo->rx_timeout_ms = info->max_rx_timeout_ms;
 
 	/* Create a unique name for this transport device */
 	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
@@ -2888,7 +2890,7 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_bool("is_atomic", 0400, trans, &dbg->is_atomic);
 
 	debugfs_create_u32("max_rx_timeout_ms", 0400, trans,
-			   (u32 *)&info->desc->max_rx_timeout_ms);
+			   (u32 *)&info->max_rx_timeout_ms);
 
 	debugfs_create_u32("max_msg_size", 0400, trans,
 			   (u32 *)&info->desc->max_msg_size);
@@ -2940,7 +2942,8 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 
 	info->raw = scmi_raw_mode_init(&info->handle, info->dbg->top_dentry,
 				       info->id, channels, num_chans,
-				       info->desc, info->tx_minfo.max_msg);
+				       info->desc, info->tx_minfo.max_msg,
+				       info->max_rx_timeout_ms);
 	if (IS_ERR(info->raw)) {
 		dev_err(info->dev, "Failed to initialize SCMI RAW Mode !\n");
 		ret = PTR_ERR(info->raw);
@@ -2953,6 +2956,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 timeout;
 	char *err_str = "probe failure\n";
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
@@ -3002,6 +3006,11 @@ static int scmi_probe(struct platform_device *pdev)
 			 info->atomic_threshold);
 	handle->is_transport_atomic = scmi_is_transport_atomic;
 
+	if (!of_property_read_u32(np, "max-rx-timeout-ms", &timeout))
+		info->max_rx_timeout_ms = timeout;
+	else
+		info->max_rx_timeout_ms = info->desc->max_rx_timeout_ms;
+
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
 		if (ret) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 130d13e9cd6b..06a764d106f8 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -165,6 +165,7 @@ struct scmi_raw_queue {
  * @wait_wq: A workqueue reference to the created workqueue
  * @dentry: Top debugfs root dentry for SCMI Raw
  * @gid: A group ID used for devres accounting
+ * @max_rx_timeout_ms: Max receive channel timeout value
  *
  * Note that this descriptor is passed back to the core after SCMI Raw is
  * initialized as an opaque handle to use by subsequent SCMI Raw call hooks.
@@ -187,6 +188,7 @@ struct scmi_raw_mode_info {
 	struct workqueue_struct	*wait_wq;
 	struct dentry *dentry;
 	void *gid;
+	u32 max_rx_timeout_ms;
 };
 
 /**
@@ -379,7 +381,7 @@ static void scmi_xfer_raw_waiter_enqueue(struct scmi_raw_mode_info *raw,
 	trace_scmi_xfer_response_wait(rw->xfer->transfer_id, rw->xfer->hdr.id,
 				      rw->xfer->hdr.protocol_id,
 				      rw->xfer->hdr.seq,
-				      raw->desc->max_rx_timeout_ms,
+				      raw->max_rx_timeout_ms,
 				      rw->xfer->hdr.poll_completion);
 
 	mutex_lock(&raw->active_mtx);
@@ -437,7 +439,7 @@ static void scmi_xfer_raw_worker(struct work_struct *work)
 
 	raw = container_of(work, struct scmi_raw_mode_info, waiters_work);
 	dev = raw->handle->dev;
-	max_tmo = msecs_to_jiffies(raw->desc->max_rx_timeout_ms);
+	max_tmo = msecs_to_jiffies(raw->max_rx_timeout_ms);
 
 	do {
 		int ret = 0;
@@ -574,7 +576,7 @@ static int scmi_xfer_raw_get_init(struct scmi_raw_mode_info *raw, void *buf,
 			dev_dbg(dev,
 				"...retrying[%d] inflight registration\n",
 				retry);
-			msleep(raw->desc->max_rx_timeout_ms /
+			msleep(raw->max_rx_timeout_ms /
 			       SCMI_XFER_RAW_MAX_RETRIES);
 		}
 	} while (ret && --retry);
@@ -1162,6 +1164,7 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
  * @num_chans: The number of entries in @channels
  * @desc: Reference to the transport operations
  * @tx_max_msg: Max number of in-flight messages allowed by the transport
+ * @max_rx_timeout_ms: Max receive channel timeout value
  *
  * This function prepare the SCMI Raw stack and creates the debugfs API.
  *
@@ -1170,7 +1173,8 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
-			 const struct scmi_desc *desc, int tx_max_msg)
+			 const struct scmi_desc *desc, int tx_max_msg,
+			 u32 max_rx_timeout_ms)
 {
 	int ret;
 	struct scmi_raw_mode_info *raw;
@@ -1188,6 +1192,7 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	raw->desc = desc;
 	raw->tx_max_msg = tx_max_msg;
 	raw->id = instance_id;
+	raw->max_rx_timeout_ms = max_rx_timeout_ms;
 
 	ret = scmi_raw_mode_setup(raw, channels, num_chans);
 	if (ret) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.h b/drivers/firmware/arm_scmi/raw_mode.h
index 8af756a83fd1..25d4a46261e7 100644
--- a/drivers/firmware/arm_scmi/raw_mode.h
+++ b/drivers/firmware/arm_scmi/raw_mode.h
@@ -20,7 +20,8 @@ enum {
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
-			 const struct scmi_desc *desc, int tx_max_msg);
+			 const struct scmi_desc *desc, int tx_max_msg,
+			 u32 max_rx_timeout_ms);
 void scmi_raw_mode_cleanup(void *raw);
 
 void scmi_raw_message_report(void *raw, struct scmi_xfer *xfer,
-- 
2.37.1


