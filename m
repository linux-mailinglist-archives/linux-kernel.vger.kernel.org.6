Return-Path: <linux-kernel+bounces-565772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AECA66EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBC71898244
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FCE202967;
	Tue, 18 Mar 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M3Nvhzfl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B975205AD1;
	Tue, 18 Mar 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287672; cv=fail; b=agqdH7aWZlPPYc/2o/ZosHkPIFMcGikGQpFIYsvKAQnPTV3URFeXu0heCeN1j2O/5KkHv2nRTUTQ+H80+mA9M4rGiG5eU1HeDxXzv29E+/mHiPYexQht4QGdBlHPETvuOrrRWDVlUJJ5IG6jDjg0caH0TxYTXFH3aJntgdTX36A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287672; c=relaxed/simple;
	bh=34FKGbtHN+nZmrUTP2Abds4hcBVFhHTKoeh9myNQfFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyBOotsSSUuvaMGVYlzV/YqY7lCyh/WMCb+dz2478QYbZCi60u3+Fc3qMAO6j7l7odQpNpsgigKoXzW/uLvzNV72obW4yfr/3zEqFqdJEZkhuEEZsLYSj18NbLb6fz9DOvBnHXq6mBLvQ2jdCVofn/Q93Rs4oV4qJ9ybCQuqRqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=M3Nvhzfl; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIaLTzhDRZ04CkS4lYn1hMbyLQD0QMPc/t4IDAMGkxAQy0/QdNZGw/jXdjB859ktq5Daxi8HcPl9TFp8Dur+RqUgF8n23ljBmVUi028sgKXhhwtGowSHBD9L+uffBNQw/c9PumMPli4MvCKOpKsnZh/mq3NyKLphEsTEnsxSDr/OIKB1GG8HBzGhhO+ZEcP+pCuUdqKXjJMlbV0fIDcBL0RFlx6ZtwH98sSg/LA7CmtNkY+yB/A/eSIjlpMmXPi55jf2oVNX6Xsch3+caAch8H59iHWFqusc/YgNg522FenuphnZ1Ij+Byn3ECu/am196sIntfhhCYVF4c0TcUqJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNzWX/IcDeJNyL5VsXyGRekJJgX/6YRIR0yRi8CoWTE=;
 b=iRlh/DEXLKJFx6p9vf7mP/+V7j6+SLToBj5jRvPH6kBcWtU8LC6lgRDOdCQFd7W5ePEzjOJVxP8gl3TO8B8ZvGvIUiCBU6jCKyjyoUqwQbOosEOgo6IQwFphDjYenZwX5xp9r0eliGFNd8PHvq1eWJz8K6gKWzLZDygEV8wF3uxrCWNErZR499SIq0IyMzKUXi6y5LaAGp9E98kc2N28FjpZH4Kp0k+P2C0Vb/BV3IV9VWuEgWVoqh4f1zMT2N7V2v+w5jCqWweS9k6b/TF04TUossRE6PjyKZ0rntjdTMeHVi+t7h4O9tZ1C2sp6HzbTlvbc5iwHYDwx4TXgU/sjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNzWX/IcDeJNyL5VsXyGRekJJgX/6YRIR0yRi8CoWTE=;
 b=M3NvhzflehZu8HyWL1U3sFUwZSyYW8Lqm6Bg0mva+1v2CptA2UO9i90IqoP6FChAf5babHbQRJx/BTjufpwv1Dg2mZbauirEX7+bqDUPBpVUcxhXPfod8wwkp9SxoFslo8u6Z3czkEMVcAgKKs7UqHqtdf+0DntroKYGBMEVTwDf7Iyg91XGZSfl/knd3MH/hNyWU9bYGVr8bzHSL1Eyk7Ny/lJe/H/MDlj5X80+2KQcUHe6cMVSrnJT0r9qpMintQBhlGNzeEFR1ngx4kkUs4qUnm/xrIxGio1qkFKA3tBsfun67mnbmP+vySzoEBj5y6zqbCgTCa4jxVD2cvq6Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA4PR04MB7742.eurprd04.prod.outlook.com (2603:10a6:102:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:47:40 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:47:39 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 2/3] hwmon: emc2305: Add OF support
Date: Tue, 18 Mar 2025 10:54:43 +0200
Message-Id: <20250318085444.3459380-3-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0063.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::13) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8a434d-f44d-47de-9650-08dd65f98a33
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?U36BexpoVcuBWUkm+1h1DfkZnpvKLWUsICnsKDJa+ySXyIlZ7393gx8wws?=
 =?iso-8859-1?Q?7Awi8peCJJmObRXzERhZ56vAjMNFyCDO//1E991Q9OuEVGn0+KKKF03J0E?=
 =?iso-8859-1?Q?zDPv9K+Kmm3Iv+VvyT9EIoRxDBHnBaY12drQ6RUqbiKjaOFQwXrAOqVrbq?=
 =?iso-8859-1?Q?Wbtp6uZr+rKdI/virOdajML0pP045XMdkh8oOsf3YNmPPF3KZzELGgqSIV?=
 =?iso-8859-1?Q?MIpTwPC0AyloW+2zl6zGqhY4/35CUZvU+5MP6xUXNNA30pIdJwr/Nr1Rk3?=
 =?iso-8859-1?Q?Yzm7T4MBzVApEZUiLkjj/axeEEnLeoi5obDWwvV6nroAyualu0MWhTkK+R?=
 =?iso-8859-1?Q?niZgZzUIOaPiPYnBPmnMYr2fjOEBHThmUmdhYsqC2h8y7ZZX/+jmid3Fuf?=
 =?iso-8859-1?Q?vLRfXlIPZEyas7EFDLOiriMj0P7tPqKPzPRqdJDyBFAz8oww5BgwlpGdCI?=
 =?iso-8859-1?Q?qad7lfzmY5wZcppsm82H9SbvKZkLQykKxphnSgOtMJmd50WVC7bOIVWGOw?=
 =?iso-8859-1?Q?WeWAoQ9FGXOQ6G/Lx9taUv9Wvz8QMGDeRBXVAbZFcuGIeWjrV+0P9Yjyrw?=
 =?iso-8859-1?Q?yyXJTm54V858l/9LVxIXqWz2r3NYDi4sGaKfPMIaxQd+O0AfMswvFvSm1v?=
 =?iso-8859-1?Q?dBh3OEomek8eGe3V+m9VaJYotHp+jI1uSSzZznsZNU6+UcNElScQIdPivv?=
 =?iso-8859-1?Q?TCtg3DBUFV2Hh4j3PEiWMcnmw79MPEXi0Ye1OI5zlkESgB+lFv/YUEBBab?=
 =?iso-8859-1?Q?aPqQgNWZJk1xx2H4Yj5YQTVV5pJDdsXPejbPFLX7ixBP5sgn27eN9Ps3A0?=
 =?iso-8859-1?Q?xOm7JdxUcQSDPyTQu8e1ZOVLtO5KUyM9ozj6u/VcrPlBsl9N3/nghJCoAp?=
 =?iso-8859-1?Q?XkMUVG2JCJ+FLQE7wUGsjJUrlqG9MHSAl0SEskJivbyeimoPnbz++X3lmW?=
 =?iso-8859-1?Q?Ka7SD9VGNlPFEO1dRpACAdK7nEc74Tcn38wOQ2Q9Pn6IYXv/mqvSL+BdIy?=
 =?iso-8859-1?Q?1A0gH8o+N4yDleMVo2bMrMBs0ZNMMIROgkyDysOk1l/XyVMTIgD3mKqfJ0?=
 =?iso-8859-1?Q?WDiwAaggaH5LJXHaVlKnhJwhTxRoemAjVL5H2OvJA6Yr+GMYOkc7nQzp+x?=
 =?iso-8859-1?Q?Wqp+qG3VHwl/7e+9OLWoIqXHpB3gYIQVEdU1B3f9D2IpMKS1F8UbTLjybx?=
 =?iso-8859-1?Q?BmdUCwpib1JmZpxcx5I2LyO1rrGW/dCfBsDurk+BJ0TE+9IssNrTBihStx?=
 =?iso-8859-1?Q?UDSNMQG6oj2pDLB+LG77DTts+j9t6f+dm3UwahWC7M/DP6DlZZDr1T9pWi?=
 =?iso-8859-1?Q?DfL+RMZ3b0REyv/uWXwkGcGcJTEpDtbv2YP/tKwV4jABvv2LeWGXM89Ota?=
 =?iso-8859-1?Q?dZnGRJZTe2Xwma/PuHFAaQdzsK6r509FKB/MIwtLmW81FXHrWFQt8MCyut?=
 =?iso-8859-1?Q?xlNHtBXsR8vxO6Vm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?qtthf6PTlNzlBZ5XuqvTWPTIxKK+kwpOtS7bFCceWeyDn7BK1+XtHXu5Hw?=
 =?iso-8859-1?Q?kgSUC58L2s7PHgU+cOh11CA95Hu22f4UhfYdB9aTidVypJkWZb7+b7s2dx?=
 =?iso-8859-1?Q?Z+nBscs1h0BOxYg/R6bUt+KcFBRdGcbRNWkmpH/ZTYIk5aMSzNGpCFgiN6?=
 =?iso-8859-1?Q?qG4HdFv6I/SE3Pir1K+G6mYCmRH+7h38r4osnItvrDfNYhnVxIjs7xGm+s?=
 =?iso-8859-1?Q?rvYzS5ax42Cq4Nd5UpafT6uJxdXYOZrKgrXyYkQOcqN2J5kGo0LVomhISz?=
 =?iso-8859-1?Q?vBHhur5AhUULL4ERlogA9JMNLScZHaCBAoaTZ60qVOGR8h7tajMwTrZko1?=
 =?iso-8859-1?Q?5vYVOIVR+CtTf1Av6J3P0dTIEB0eqcqY2VoeYr5fz3xAOEznW38Tw+qmrw?=
 =?iso-8859-1?Q?9U9akuX3byZrVVhcCp/B0tkL+M2bQV/30YPwpu9WdOdXE9PTnaBg0V+P21?=
 =?iso-8859-1?Q?6WrrozVjjOvNsxQJ8UChi2GEzq3avcy+B1PwORmKbkltzH7GvPBP4ZlxO8?=
 =?iso-8859-1?Q?ZeRykel9sur7sE/jyP0909y9prgUvkdb2kp0i1sn5u8z9Jj2igyN6a5SHZ?=
 =?iso-8859-1?Q?uaCMqO9pccKRrnfpx41w3HoXHW3209fBPckMGnKW+X1nRTP7MP7QDhG+NA?=
 =?iso-8859-1?Q?WQzAP5k+Gmwf9HZjyidHT5YK0YC7Yd2gLAfx7c53Ks6fUOB9OB1dc4EIV1?=
 =?iso-8859-1?Q?65TxQ06pawWfyt98fMLIQwR0t97AYIPpKzkg1YuaSjO3WYQItsJAgSWePX?=
 =?iso-8859-1?Q?dJWfqBIHEq/s0MTQrEqg37wNqSc7Rfk9XChRWQ99/CFJdF20Lcbun9E18U?=
 =?iso-8859-1?Q?Mws7G+3YaJFM/zvPDzq0IgAHpXVB/Z/Pre3hJEAGXxBF2JZrltkw0lJ/U8?=
 =?iso-8859-1?Q?hFjSGoaXpIiyiy1pykwCQeXJd8TkzazdFtjORpxa63yhsNiMBTxVzxFtbn?=
 =?iso-8859-1?Q?wjahbATlBSUatNc+AtYLis59VMca6eqNdJL+JGVs5oAcKpNJeJoLnJwegQ?=
 =?iso-8859-1?Q?wN1/w3B8rcFwiGdyfTBfy6Q0bWS674+r5QWfCYdwstWFn1rOv9Y+x5mZ1k?=
 =?iso-8859-1?Q?eOb9tuJs7Aim/r/awkD5E1VXCyjxcegpTTICQVfyE6ZdoKQHQ+SqLXneMs?=
 =?iso-8859-1?Q?NtxfV98Bz7vlqOiFm8+jFwRggDbNka40pd1gugipgnap4eAKxmOBGO/+Et?=
 =?iso-8859-1?Q?ssxoiWuuefRztKyfHbxkvvyaZrlMPLPxRVvK1A+nrL1yVeECu4hRfZEBcU?=
 =?iso-8859-1?Q?rCsieJRh3UpQlzv4ak/KyCEYPmbsJUsk2VZj7Rw/JOYBmkjtIKKtlHxRjm?=
 =?iso-8859-1?Q?stScy64gmOedsSIimFnD+QEgk8RL5vMwAhEyxgbL5UFH+HJuir3NbZfq/n?=
 =?iso-8859-1?Q?lAWwY/a6iIdK29dRjqa+959+Kt7EOqyL2p644ySExRRz9HkE9i+5mmQTae?=
 =?iso-8859-1?Q?6BXn38rbCtNQeE0QcKI+DHqYmmXD3Vsnocfn11oeoMXzhkd2ArbXrO5i2M?=
 =?iso-8859-1?Q?ioyL+6Jr3ocNShtkVw+ErYUqJQ/B/7pOwL7dHiZf5/9IZl7cIXkoVjK/3d?=
 =?iso-8859-1?Q?n0BcsSK/2fFcVsqnu2+iAlyz5DNIe9fc7vDv3sa73VqtOrk8r72Y3ZCqyM?=
 =?iso-8859-1?Q?W6dANh54c0YxDwm3XgM5Cn1XQwR8mXt5sRaxv1EkQ0A825HNWcKdZ6SQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8a434d-f44d-47de-9650-08dd65f98a33
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:47:39.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmUqfi65hzHhxp3XnKdaBDcbP5jb4cRwz/2DYzlyZBZR7/QLaXIdkk0Q+m4TSgNQhMXtH2ipjIiEwqkWWfb1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742

From: Florin Leotescu <florin.leotescu@nxp.com>

Introduce OF support for Microchip emc2305 pwm fan controller.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/hwmon/emc2305.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 4d39fbd83769..f8a4c76fcadd 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -607,9 +607,16 @@ static void emc2305_remove(struct i2c_client *client)
 		emc2305_unset_tz(dev);
 }
 
+static const struct of_device_id of_emc2305_match_table[] = {
+	{ .compatible = "microchip,emc2305", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_emc2305_match_table);
+
 static struct i2c_driver emc2305_driver = {
 	.driver = {
 		.name = "emc2305",
+		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
 	.remove	  = emc2305_remove,
-- 
2.34.1


