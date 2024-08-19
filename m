Return-Path: <linux-kernel+bounces-292577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585C95717F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C773B276E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF4517BED4;
	Mon, 19 Aug 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fdyg4dn/"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083E176AA3;
	Mon, 19 Aug 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086993; cv=fail; b=LwNw2LGhJzOMQqdYHnYERH1FRaoZSCcIBaIVpAUXuQHaR/oxnULWTX5VjMt2aVFh2MPzIWUM49nOILGzZX/FIfPDESLQeHaNGvnyKLrNmWEkrmsYVdcubcPQV+C/SOLqIeF6k4cy5DZvxQ3tfiZnfE+hUM/qCAHw2N1txPZ6eDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086993; c=relaxed/simple;
	bh=2fsHcVqpA4YJZDp/CBpE8FVx45PCbc2KL6pBPGoY7jM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cSl3paExjgANVtAEVMiLQl3PtRX9oYvJA7GG+3Th1ah4lz8harNuE0G4oBLxn0qJ2OH5qy7xbuY9UAcc0N2qHwT0ditke2FsYYKsYy4iMO49XJWsmA1n3KPRrHmwh5xHa3lX4VIYoZmkgGbt11nMaGh5r3osoklSMVxXkJbeRWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fdyg4dn/; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPrEhzyQSQmUvcLDNklYiXNx5R228cEc765Hln/7Gfnn269qKwAqWTx6N7j3ICuKqu9b+oO3QnMtvqNakRVJkfI/J14dwY0kvLTnDAUhXPqWDTFkBpmTAsZ32ktgZgV/JJom+8etFCvS7XvnxIMf2hbM5esV74rqvpvEdNbU6PJPhzDw1plEiv6Seqtd/o6jphbF6Qte3w6S9h7cRZAse1nNKJvmDDa/LVO3PMmHw/h4Bz2dI+EGEWT2m32BEw0R7I82Qswxpkujixc7q9yY5C4a/WiZ3J16qzgSl5YxF12SlndBWjWBo9BjKKQt7GTNBNCklHoD4uFC5iNPYt2aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXndktea5ygTZQegwfjucd0subT4uXeYxI72LUcdEBU=;
 b=YIlF+GAD1C3TshfATOds4aUGYbilIyVKsq2ejaRcBD5hWC8mejs4C+R88X61pxlIyQEr29VQEFT3oPBeXSnegRAYFCdeSxrOQPgXECTKtdHrgL+X8qe0sliZOFAa5OT4jL98m9lQ2fvOvpE0HHAzXWzq4vk8NBkMq03PjPvg61K/uihxxqpThvp+rRLzzO8NODI/NgixU509Md8x+SJ9XbMj0TcSxOCb+nUJR9U6Ww3tQIYeop2FFkue9KpzkePcbLzuCnEGI0Mj9t9rU3iGu+rZiw0+LlnBpZtrj6CI2f9CGBVImulroHgu7pu0WdWoOuFj9cyxVRFMg5YdNFUASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXndktea5ygTZQegwfjucd0subT4uXeYxI72LUcdEBU=;
 b=Fdyg4dn/1sj1bm7vL2yvu43dFboMJyyOxB6riuC/70gby4pS4TyHQ0e8AAIoX4huFpJUW6ixb+BTDUcxcOI+dOJkZpqv+tLV5XjsokKxiTQDx888L1PovAPmniyRywdch+QGgCV0gU+Mk4m7Z9WVQNSbI86Knr6mVnT2AfpchatYrYq34Ug3v2vBLBpPOa9XPynMiJjVnLYMWVhJls8tXu/hsOzScsxA0wXhcI07JVVTRXbdNg1yCmBizDrQcxM5fJQSFWpQk3xcMCxrWcLmBvTQEAvcBro+cxMCp/VQqyccGajiucoLkRplgtYz4kKP6720FDT2FABMzON7wULYdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10857.eurprd04.prod.outlook.com (2603:10a6:800:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:10 -0400
Subject: [PATCH v2 01/12] arm64: dts: imx8-ss-img: remove undocument slot
 for jpeg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-1-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086981; l=1425;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2fsHcVqpA4YJZDp/CBpE8FVx45PCbc2KL6pBPGoY7jM=;
 b=NUG2bwh3rm9L1X33Ez9n8BMwXy3Xg9SfMmzx2z01oaw3COg9F8LoZlcch/ohzaosf1MpLFD+F
 FDpB40cOSBbC4UQJotjTmNA/WuRZi3fK3ziNAYXe4u80AREwhPlX1rK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10857:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fd7ac3-e54d-4971-f88e-08dcc070cd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TERGcXNEbmVNbVJzdHdwa0lCL2dxcDdpc0E4WXByclUxTlVVRWpBenBPOGZt?=
 =?utf-8?B?R2ZyZkZoOUFGTTZpcVJZMGFjc0Z0OWc0MVdYdkg2cEhYSWxKajJyN3ppcFI0?=
 =?utf-8?B?WUJTb2tOWlh3MVI2dnBDVEg5WDUzZU00eEg2VmhiSlQvVSs5aERydFM3SjEw?=
 =?utf-8?B?c2plNFFIb1QxVlhxLy9xSmhpRzF2dFlKQUpFYWlTeTBZTXYxZnBMeXJ5V2Z4?=
 =?utf-8?B?b2pUMjMydmk3OGFySFZzQXdhTWhHR1p2clNnYVhtZFIzRitYMWY3a3NLMXg0?=
 =?utf-8?B?cnh2NEhGTTRJMWU1L2wxZnVaNTloTkZwNlRGaXNhRHN6dmpiVThEd0t1UUxV?=
 =?utf-8?B?djEzSXNRS2p0K3BHUC9yQzl3QVhQVDJXOXo2M1c1K0NJc0xOb3RmOFZYS2cx?=
 =?utf-8?B?eTF4dFAzTmxIS0FYNGxIVm9RSDZtOWVmeTlJK0M3WnhCUGRGN25veFF1WUMz?=
 =?utf-8?B?QUlFdElZQyt4NWlYOFZsNXVNdVNhUlZoS1dVdmU4VGx4MEdJK2hPN0xRWnNh?=
 =?utf-8?B?Qk1RVUpEVklxZGlUdEFQZDZUb3M3U2d5NW9tMUErNjNxN3Zuam92NGJLcDYv?=
 =?utf-8?B?bXBTMi80TTUveElPQzdDdHZkclg5bTVseHE0b0N4Wnd2UnV1ek1BUm1Cb3Zh?=
 =?utf-8?B?Q05kaHNkam52b21nR0tGQ054OHh5YWVvclpFNThBanRPazhSbjVudWtITHo1?=
 =?utf-8?B?dmtuODZTdm4xMzlseEhNU1NMZjNISHYrei9HcEZtQXQ4OUZxVnAwTG9PMFlw?=
 =?utf-8?B?SWM4ZE5SLytkdkhHU1JUQWV3RkFlUGV5RmUwVWlvdUwwR2hmaUhTeCtuS1l6?=
 =?utf-8?B?WUxMa0ErRVkrUTJ0azFkVWd3bXFLYWljMzVEbnU0R3Z4U3lCMUlZOFhGbURG?=
 =?utf-8?B?UXFBemt0ZE9PckpHL25CYS9rblZBSVNBTTJQVHB4amo4UlhBWXZOdElCbitw?=
 =?utf-8?B?clV6RzNramVlai9XVjQyZTV6NWRxQXlLSU55RVF1bWNXSXkvajI5ZVNUNVdk?=
 =?utf-8?B?cmM3UmFuWGxlTzNSVTc5U2owS2JmZTdRMk1zUm02a09VblVPZmcxZFp3M2hC?=
 =?utf-8?B?cXB1ZStEWUZ0S04yNUlkemJxemlaVTFqeE5aR3duenZCZ0x2ZXRoMU0yZXdI?=
 =?utf-8?B?d3ZxUEFCTlZIaDlraUlnUDhzSm93NVp1TnlJdzErcjYvcFBObGlnYmxpdy9x?=
 =?utf-8?B?UStqWDU4TkVZaHIzdmFBTHQ3UUxaemhIaDRleG4zMWxxVFdrWlhsY01CeTNl?=
 =?utf-8?B?dGFoQVBwM2lOS1VWL0ZGVkdaVEdGLzgwcXpPZzhBYndHM3E2U3loQ21QcVNx?=
 =?utf-8?B?dFBraVBiTjJBd2QzN2N0L3Z3RXgzRHlzTEg0dUR4anFFWFNReVJTQVRwT3NI?=
 =?utf-8?B?dnlZQmQvUkVyTWRXSitaUkxLSnc0S1NQSVZ3MnhmYTlZcTNERU1CZ0FqRjFj?=
 =?utf-8?B?RHZrNTFKZ0NkbWc0cDRKZzFMZkZBQVR0QlJYS0lNbExSaXRMcTJrRUpRNEtt?=
 =?utf-8?B?UTV5WFVOeFo3dGhBK2pjaFBWeUlsWTBFbmQybWNEMjlUaVVWTXpEdnVhUms4?=
 =?utf-8?B?aENid0kwMXhzRnlkOHpvelBwYSt0VVh1NzVuZTlia3F1OU1hQ2pOeG9IUGdQ?=
 =?utf-8?B?aHVDUm9tbGdvNTFlajBPZG50K1dud05xdjhqK1pWUDVhcFNSQUlXNTNTSUNI?=
 =?utf-8?B?VFcyYnh0WE9kZXRRV21oSC9qUHM3NENBNnN2U3BtODNzekg5d2dLcGJpR2lP?=
 =?utf-8?B?UDhseUk4MGFSamI2MWwwSzE1UG42WnIyYVhsOFRSanFBM2Raa2lOM2hrcHkz?=
 =?utf-8?Q?r4RAybFfmOkhuEEDxpp0k1cPWYltu62QXzc4U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nlh6dWd4RU85ZUJhSlFISUx2NEJ1aEpuZ2hJWE01YkNFdXV4ME9sYzF2Qk16?=
 =?utf-8?B?SWVmMEZiMDgyMlVIUXlsK2RUdmJHdUg4eWVBOGFURm96eC9XSjJXY2Zia3N6?=
 =?utf-8?B?cjdoL2hVUG5GRW1VMXdKUkJ6K1J4aFZZSmt6cktKS0E4ODh3UWh6ZGpUMjRU?=
 =?utf-8?B?ZEIyZC9nODI4ZEE2SXEwRmJ1QXFaeG5IMlZLbm9sTjNQd1FhVGVNRUI3Snc5?=
 =?utf-8?B?RjdWRDJlVGxRUTN6UHlCN3dWbEM0OWU2QUxUektHb2I1V1N4b1pKZ0tIS1p1?=
 =?utf-8?B?MVdTa3BPaG96SlI3VDRYYndKNnFVUmRkTlNuTlY2NkVCdXM2cDhYVlY3K0w5?=
 =?utf-8?B?MS9WVWt3R1lhNzk0dHA2NGtaaGtFU0hielV5dnJnbnlKdy9hTTZydnNGZEkz?=
 =?utf-8?B?bTlUSTdoV1B2TVRYY1NCUDF4UWtQWFNVNzFGelprWnRGd1BQTmxXWFNlSjZV?=
 =?utf-8?B?YlJKQjBtVC9HSHB4WWUxcHlYTk94dVRoVCtTMEl6ejY1VGZ1RURaODFzQkd4?=
 =?utf-8?B?VzJtTVB0SjFKenJBWWdIK2xjVEZLVFhEWkVqbUdHQi9sRlYxOGxDeTdoTDZh?=
 =?utf-8?B?U3lUL1plYWIrTVh0ZHhyaHByWE9HT21XOXQ1c1NDbitIL0w4OEdXT0ZCOVZM?=
 =?utf-8?B?VlczeEx5Ry85RlZrd0VsY2ZIQmxBb2tpcVFaZ09yVmFGMmxTSUc0dm5CSEM2?=
 =?utf-8?B?b2dCazZkbG5tNXorcWpPTGR6MDE0cVkvLzJxWUFFZEIwNktmZHpYdTYvZXp0?=
 =?utf-8?B?MncyQndTZzlFODBPSEg0VTluY2xjclpNL2RVTU1qYUtKZ1BJTjdaVUJBWE0x?=
 =?utf-8?B?R3pScGRkZWpDcXhlNlBlM1BidWQ3R1pzUkxCc2M4Qm54VkFDUGE0QWxUWFlP?=
 =?utf-8?B?a0lFMlJaUXhzQWlONFpjempsQ1lKdEJveFNBUldKUU5HbjRwZHF1ZDAvQ05t?=
 =?utf-8?B?WW0vMWw4RkRpOWJUbTBQblNWSDlabFgxVzJFVnBzM0dmdGJVYVdKWUVVS0hx?=
 =?utf-8?B?VGVSN2hoY2hnL1JJRkhBQkF6WEpoa0R6RDI4S1VMVGV5SURNNEZWMzlzUjhh?=
 =?utf-8?B?dXUwNVFHUDFhcThwbytRVHd6TzhTUWhuZFd2TTllT0xGblZYSlo3VXlrM0xn?=
 =?utf-8?B?b1h3NC9xczVScGlySmYyVk9JM3U0UmF5Nit6RWh1UDdodGxQVVFnZlBDY0R4?=
 =?utf-8?B?SGZQem5Bc2piVlJjOTYvajdwejhmbm91OTQrNzhISDFJY0xCQW9yck1nanNi?=
 =?utf-8?B?bldZaVVuLzNrSlo1UmlsUVRHVER4YURtYmFHWnZmNGRXeXhZdG9DSmRvOVNv?=
 =?utf-8?B?QUYxbU9aaU1XSE9LQWw4eG5DcGUwdjNVSjN5ZkYvRVIwUTdsZko0M2ZaSjJ4?=
 =?utf-8?B?dURjYmUzWWxDRnZLSFhFVS9SVnk2T1A2cFIxRmlaN2M5WnB1aUFqY0hub05o?=
 =?utf-8?B?dHhzM29KMGRIcmFoUmhGUjVLcFZYWi9qZngyVVNsbDVvc1VmODExSUlKSjlD?=
 =?utf-8?B?bGpycGRnS0RpWEozdXA4Vmg5dlppZGJtTnVzY25qZ2lhUmtQRDJwRmlpMlEy?=
 =?utf-8?B?OXgwWUd5QU1FWVJ6eEZtMmJlVm9ZemVVYlIrTnRqU2syaGZUTjBSQTlRaXU2?=
 =?utf-8?B?akFLVlJqOENGenhTTHJma2JpUEpKM2E5Wm1Pc2dmaCs0MVVMUW5lRVE3K3Nu?=
 =?utf-8?B?emZEQkVCNEllNURHQ0M1VHBkSTJTZVRhUnZqa2QwQTEycERoN2NFYjRTVGU2?=
 =?utf-8?B?SU13TllaTXFXMTVHVzBmSTF1bWMvWWZZcHRXWkRkemJIUmE5aUpiZGtid2xB?=
 =?utf-8?B?R0xQREtSVjZqM1dNbHpnNDZGOTlqVVZWTWN3SmR4NjMrVFY1RysxWnZkYXpO?=
 =?utf-8?B?aEJtY2xHNFlUVUROTWZKMWNLeWdwQmZ3N0Fhd2JlcXJFam83ZmEvYWREVkU5?=
 =?utf-8?B?Z0lCYUF3ZnpzVkhXR05TcTNyWE5tU1FlZ1JjQzJOR3gwZTFsUGkxYkNRRTdj?=
 =?utf-8?B?dUIvV1o4SFRxRklla3dkbHJ4eVRpMHdtZkVCTFMwTVR3UVgvbkZiVkRXdEtn?=
 =?utf-8?B?aG5WNUJzZSs5S0pPaFY4V3NEUFhYanZHU1BqOWxBaEJoT3d1dGIxci9kYXR3?=
 =?utf-8?Q?qrKxrs8XS+AURFExHxO2d/vEi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd7ac3-e54d-4971-f88e-08dcc070cd7f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:09.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDFUuvBqh7gPQd4If9DpKxlDBhNsYJ6Ewd55cK9RQ3pf04Ho+OCIjcGcrUYAIGZmbo4ShqaMyot5wN0++jeEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10857

Remove undocument 'slot' property. It is default 0 at driver. We can remove
it safely.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: jpegdec@58400000:
	'slot' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Previous discuss at thread
- https://lore.kernel.org/imx/e3d64b07-98fc-4d43-a1ef-561cbac58552@nxp.com/
- https://lore.kernel.org/all/bbb1875b-7980-46aa-80b4-dbaf2a2d5755@linaro.org/

Slot should be managed by driver self. So remove "slot" in dts file.
---
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index 77d2928997b4b..d39242c1b9f79 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -26,7 +26,6 @@ jpegdec: jpegdec@58400000 {
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
 				<&pd IMX_SC_R_MJPEG_DEC_S0>;
-		slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
@@ -39,7 +38,6 @@ jpegenc: jpegenc@58450000 {
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
 				<&pd IMX_SC_R_MJPEG_ENC_S0>;
-		slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {

-- 
2.34.1


