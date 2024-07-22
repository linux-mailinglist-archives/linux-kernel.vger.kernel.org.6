Return-Path: <linux-kernel+bounces-258461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA344938829
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFACB21047
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3D1798C;
	Mon, 22 Jul 2024 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jUXsDQwg"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DE1946B;
	Mon, 22 Jul 2024 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721624120; cv=fail; b=k4+DrbPkTGSpEOApR+Vpnuxk7kZEX3WOm23f0ZorMoAC+YY1ceEhZnG7+xi99SJdeK/C5j8ztw81DaU/oFSYHS3G4hQXeaHyZdx4Crn8/369Sne9W5IVipm6PPVFgm5fFCdl2WzilVPeooF49J/hjYq/ccNknxFUISctH2c+IyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721624120; c=relaxed/simple;
	bh=p01y1F3mtu4/IyjRRrfQFm0niw7DcIt25jToCIAh9cQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GcYtZ4Nc7Kkh0A/Tn3UVbeDLJLQqzRTY408q0orQG1w41J4cX69XVBNbzufWmwZDrzdw+nW+AmjGv7njC0usWFEMirKWypR+8lYaHrf9PQx8UehRWuWOCeXHMoCgJQ57fL/hK9ovCp7vNLFOs+UDGmNX0BMfvX26kYX4e0ked/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jUXsDQwg; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu+cyGp8+RxQcsBJUC8z8BFV9ymGmaAjo/EeVjyq1cLiAnW1oI+nCMZ3WbryiWGBMus1KHzTlL3SXcP8uvEI1Dd3sInum6L5Y46lNhsIc8tMh+b+aMMWcKRERKEyoiCeLNloL32R8/Wyvgjok/3hSPa3fHOxWWUWSgf0mxsY6WjVKU+q62zMWRVOw9td++EY7Twd8hQxWccdcyhvu8lRgf3u9ARoKK3bHplI3JP7a7NSfboOuHjowmxKWLbdsUFMgxPMf+K7gM0J6AeaJOowBqT2/TeEm5YQREEAEguHGRAhfhOVPSrhhCU8MENdyzgn+G62q5oRGiwwIwyZxDM8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUwG4D//bYdWW65zaoUU+xIqorkaZ+9JNmzPUZxW9jk=;
 b=OsUgrN+jb0JtgNEPwTgDBmF46P0nRyMBcnaHar1myrwPl2r9IG0eV4BqSS7ryqJaBUCbvThlKqa4Qep8ef4KYt1tDXBntQOEl7R6kMMP8zCIG6iaFnQXy+0RnWDvaPeWR+or7r/Y0uzdFaUncJJYFasWsBv6fwzeskz0watXDQCVh6eRk4OZ2RnIUJt9CLtRRBWVec1T/KdCgbkkNG4tng1V7T+hV1M2QM10BCyJk0eM4549a/RRGp9E+Fnwx46z1V5nbGOGov5ARIAIQngavfstIfRWtztyWFgWod6yDQnoQrtjt8rJHzLmvQ0d2odDaamDIJ/onoLtijNGADoq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUwG4D//bYdWW65zaoUU+xIqorkaZ+9JNmzPUZxW9jk=;
 b=jUXsDQwgqzcfsu4alWOaxGUceWxeaSFo04rBGzkXWovx2X5J7KwAt7BiS6ffMR7tnZuqlGOv/p58kUUixAcdsZqCk9H9jFM3NsiUahXUbh4eCLH6Ys5vmUy+GT75Q/jVUeVu16hzXtwDO1Fbvnfl4OrHi0icNU1biNkw32cX17c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 04:55:14 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:55:14 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 22 Jul 2024 10:21:38 +0530
Subject: [PATCH v6 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-imx-se-if-v6-3-ee26a87b824a@nxp.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
In-Reply-To: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721623911; l=2645;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=p01y1F3mtu4/IyjRRrfQFm0niw7DcIt25jToCIAh9cQ=;
 b=ls33F4ltYc7NeUlz8EpN3sPMwUCwjnxQIDb5EjodE5V4NDHee8eTyOFx6iwSxQ8Ddkk2l8sj4
 lzQuIGtawzoCf0zxv6PBftP8zU935trgxd8DmIwfqkgrojw/2ZZdTSh
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d512ef9-28ed-4ed9-78bb-08dcaa0a7947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmVpdGVucy9uNHVFTGxSV3dlZlRMbUQ0UW1QQ1VLb3N5MlhBS1Y4WmhmaG41?=
 =?utf-8?B?MVV2TUhKVHIxemxpaXdzY3dLMW9HUnBGZ2F2amZ0UEFTclVvV3Evc3YzNTVE?=
 =?utf-8?B?aDZJSWVjWW5YcUpaR1FPQW9IVHU5eDRTNi91YVFWOHdaL1RjUGU2Y29FaXdm?=
 =?utf-8?B?OE0rUW1NTTZ1MnJSMFRJbEJkNzJDY3RzQnQzUU9MZHN4WEN4VHJwU3hWSzNX?=
 =?utf-8?B?UGRBcG0vN21GZUZOQmtWcnhJRU04Vi9NRmY2U2NreU9tdTY0RW84V01xUUM0?=
 =?utf-8?B?emtsR0RyOUVrcWRXMjFJZWs0R2hzYU5HWVJLUS82T2RlUzlkS2NDT0ZqUXk0?=
 =?utf-8?B?bnJkVzhjTTAvRTlMeFJwaStSWmdHci9WcUpLS2FtTjdTSjlpenFhaUQ4dUV4?=
 =?utf-8?B?aHJnT3lpN2lzYUtGR0RxZ0ZMSVBYUlFPTXNtV2hVWVZsN1VzOXQ4M3BheXBS?=
 =?utf-8?B?U2NmS2dlYmNKZkdORisxSndDWTdqZkx6QTRIR1hyTkhHNXBrMExXZmZjY2Ru?=
 =?utf-8?B?Uk45UnlHZ2dHWTh4MTZiZU1HaDVaQ1NDTU50aHlSV01PZWdKMGQrUG5uOVZh?=
 =?utf-8?B?aXVvL2JtZ1B1bFJQQ2NvU3lYUTJYZDRmN0hCSWZGdGF0cUZrUm1WN1U2eE9J?=
 =?utf-8?B?c1NQUmVFWUJPc0tWRlFhMnpVVUFWZGEwSWF1YTlMd212QjdOdlFIaTB3Z1BQ?=
 =?utf-8?B?SklBbEJ0OExZYTBJZVBOOFlUZFQzdWtBTFg5T3J5SVhoaE95SEFzbmFYY3lT?=
 =?utf-8?B?cnc4b0oyVWJLeVJ2Y0VDMmREbHZDVE84MDYwT1diTG85am5mOTdNMmtvd3dU?=
 =?utf-8?B?d2hrNVdhZEJBUmlERDdoazZwMWlaYU1Hd1dPSVlFVk5NSWVhU0VWYnVNVnJW?=
 =?utf-8?B?SnpVMFRJUEZMUlFhNGEyRG5jNy9KS3ByNWlZQThEY3Y0b3Q2Vy96cndCVWp5?=
 =?utf-8?B?Y0hVN2lyd1FUZkNmMi84NEozR2ROdnNxS0FJY0ovSldVNkF6aEVkMkhuRFMz?=
 =?utf-8?B?RkozWndRVHZKZE9jOFNueXlhaC83ZEZ6R04xNEQwSmpuay8zNUVqVm9tRzZl?=
 =?utf-8?B?bXIvdHBLTmtZTGI5S2xTc080TGVlZFdoYXdQUUlIV0pBNENNYUJEQ3BHbTJt?=
 =?utf-8?B?MWs2eEQ2QWVaSVA0N0NrbUZKOVFvK2tNRFNSS2lHRW9TNGxtNHRuRU1aeEFk?=
 =?utf-8?B?WlNyNzFWbCtaV1dLeUtINTNwTVNTZ1NmNTZ1TlFUTEF0UEdWSXlydjhtamE1?=
 =?utf-8?B?clFPU0lZUzdCYW8weUlpVlg1eTJpVDl5R01RTFA0cmhML1FTR2VDa0NZdEVI?=
 =?utf-8?B?d2ZCRTlZZHV1K09LcThNZWdOck03WHM1K0JwamFjRmNHc1NIVERIVzh0eUVq?=
 =?utf-8?B?djYzN2VEUHhYSGQ2NmpUdWJmU2daaG8xVWFSdi9lbkJVZDlkbUd2T2tobDBn?=
 =?utf-8?B?aDJsQWVBeDFUVkNPdGJUOE1iMW5oVUY1WWlvMVNRdlBCWk54dDRGMGthdnJt?=
 =?utf-8?B?cjA4YkVseUY3bkRaaUw3SG10L1d0elBkUkxvUWNyTlowblZaTjVaTldrVUVi?=
 =?utf-8?B?OVB4cTBybVhRTDdtZmJlRzJkc0lHcHJaUnpQb3FNc1dCRklUSzBRaVM2Y24x?=
 =?utf-8?B?YVNGOXErRTl3aGJha0ZvNmVFOFRuRmxibXUyQmUyZkN5WE1Well3TDhDTTdO?=
 =?utf-8?B?dWlUQ3hDWlNmTXNESnM3dUtXWTNTWTVKdEU1MzF0SGh6UUNuS05vQktVS2tr?=
 =?utf-8?B?RzM5UHNveVcyRndrRFhkTFpyQnlUZ244dUhYLzFsQTNOcGdCK0w4WHBBWHpY?=
 =?utf-8?B?a3ZJQmI2WFcrU01nUzJHUks3bVFWcy9MMUZvQWVxNXliRlVlbVN4bzlZZmxs?=
 =?utf-8?B?QzJtS2krODBQZkY2bXN0RklPY0k2VWd2dzQ1T28zYzFubkdLdnV1OWVVWDBK?=
 =?utf-8?Q?AumiK9Vi1UM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmxzeTVWZWpWUDJHTVh5Z0lZUEdjZDB2Z1RhUDdndFpBSG16bzBkdTJpdmt0?=
 =?utf-8?B?aXp1RitoaEdsVmlnZEQ4RkhaMzEraGJ2dkRhWTZaU1pNYjM1OFJxUHpWNG1z?=
 =?utf-8?B?Ky84NHpMN2dnT3kyVnpmZUxKWFVOcGF5TU9ja3dkbHdzb3dqMDZhVTBJM05N?=
 =?utf-8?B?UUhtM0ZGU2paL24ydlNqUmwrclk0R2VnQ1hLZlpCYlBYVGtFNWJZeGQrQXNU?=
 =?utf-8?B?c3puajRzcGFzdWpGWWJtUThMR0RQeDNWbUJHaU5Td3duMEJ6dWgvSWRwcllo?=
 =?utf-8?B?clJjMWlqMnRQcEN5VFpUektpZkRHbklzTlJ2bFFTdUx4OEtxMUVBclkvTk91?=
 =?utf-8?B?YWRnbjMzNVBodW1WUk9lbEh5OUVZdWMycDUvblFCVllvSW01NjFodm5jOWJJ?=
 =?utf-8?B?bnVFbHpBSEthb25mTHZsV0x0S2wydUZyN3dpVjJVV28vZFdBV1hzZHp1U1Bn?=
 =?utf-8?B?SmV0Y2pmTnNnRnVLMlpaNW12QnNjM0hlR0U5U1FUa0JDMXl1dmdVYzlqemZy?=
 =?utf-8?B?VVNCL3RFbTlibGUxZDU1d3NUNnFYcWQ4WnBlUTU5QXhZNkt2MlV3Wll1R0th?=
 =?utf-8?B?UEQ3eE0rRWRlNVBtWEpqQkthZ0wzcEJ1RU9tL2RwU1Byc3BBTk9TTXh2T1pj?=
 =?utf-8?B?cWNCU3R4MnVtdGFwd0pYYVlEcFQ0ekt5Zll3R0JnQkVVL1haZ2NuRGpSZHdi?=
 =?utf-8?B?NnhQdUFMbGFRMmhVUXQ3d2c3d3VUeG1lL2dBZnRlK1hCN3RGcG9PZ2xObWJt?=
 =?utf-8?B?L2pUcHlJK0hIdDVmTExrZlJmVGZiWURoQ00ya1J3U3lucXNaTW9qaVYyU2RM?=
 =?utf-8?B?Ym0ydW9pZ0p0U3B3SGdQY21HVjF4MUM0VUN0NFJ3cjdOcUdwb2xFa29JOFZh?=
 =?utf-8?B?SU4xTHA4bWxGc01LdTRwcFY1K3NSVmxaNXF5VVVGWHY3SW9vRmZ1S3hDekov?=
 =?utf-8?B?L3lTakVvdzRoV1plMUhXdXhDQ2FvQ2t4SjRXZnAwUUtvWUl4TWpieW1MQms2?=
 =?utf-8?B?KzVCRzhvU0xWSmdSUk1WSVlPNFF5NXlwZjB6Y21GNHBoYVFPbVlpeVBpeVRU?=
 =?utf-8?B?N3EvTktYU254Q2lSSEY0LzlsZzdRc3BDMkRLSkZJc2ZtcEFLTWxHT3RqMGw1?=
 =?utf-8?B?RXlYSWZaeWk5OGxhN29STXdlck1vT3dQQ3dOVUFydlF5UHQ3YXlHZ2NwV25j?=
 =?utf-8?B?eXFseUdONThlZmEvOHRValZBVEsvSnBPRHhFeE4vT1VpMGFBbWFGVXZLWHlK?=
 =?utf-8?B?Y0tzMEN0aXVkdjhzWDRsTHdxUE1jdEhSRkN3OU9LRGo3K3E1ZWJJWm1ZbDRv?=
 =?utf-8?B?a0w3L21YYWRiSGE2NmVnR0FIQUV3bXJKc1NudEZLdW9ESXZOUGRoa2tKQnhj?=
 =?utf-8?B?UHorQTNRS1BxUVNHZC9hSnU1WWI4VCt3NnBmRFRIQzN2QUZzd2N5cjJycEdJ?=
 =?utf-8?B?NjN3K3J4UkZDQkFveG1KeVdBWklyNzVnRHRzbkIxQUNsMlRKNmM0TGJ0NWJ4?=
 =?utf-8?B?aDFqeExUUCs1SXdNd1NKVlptYmFieE9mR1pTc0NoRHV5UXBMZ3ZYdDdZVGFz?=
 =?utf-8?B?a1dqcDAwSXQ2L3JlbStrSnp0NDg2TStwQ1lOaHcwbnZMWjc5MjVaRGZ4UTNC?=
 =?utf-8?B?amp0VFRIdER6QUszblplK01EQVFpVkNJcEtMOCt6Ui9GcjRsV0tyUDFNMHVU?=
 =?utf-8?B?UTU2OFYwcGM4cHBXcFJaZGZNbzlNN0hzbHFXLy81MWoxQ1BrWXM4YVhyZTRZ?=
 =?utf-8?B?WE44KzRHb2cxUGgydUxmQzRJcmRyRWU2V0d4L0RacnF1bDVwamtNMFY1WnNw?=
 =?utf-8?B?WERpM3gxVzFmbkVXdFB5bnIvOGFvM3RCNGk0NklZWEZRV3dHMElNRTlqY1Vo?=
 =?utf-8?B?ZjVkL3FUUUNlbnMxRlBMeW9RdnVzOVpLUDQ3SjJZWFFIWW5RZWtnM2dXTUla?=
 =?utf-8?B?WERzTEVoa2FJcVh1NTFuVlg0OVc2Y2RWc0lqSnpPZXBSeklKWVVtdUNBY3JK?=
 =?utf-8?B?K0lQQmNkSklVWFk5Q2IwRE9tUmo4dDhveVNSUk80cXFqczkwSnc5ZEJjbUI5?=
 =?utf-8?B?ci9KSU9VWWRiZWsreEg1eXBTcTVVSVNMN3pRbUY3MDl6Y3hyR01RTEpmVVpE?=
 =?utf-8?Q?0nPrN7DVYk9gCrhi5BfEZ98Ag?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d512ef9-28ed-4ed9-78bb-08dcaa0a7947
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:55:14.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr1YILFJes7gl7XAZKcEcQRrq1JDXDtS0qmmDde7iCk1c/mcqc5Ncq8VSsSu2mEGqK02VK4QPR+KC2IxpNfe4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..ca8958f28a83 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c460afaa76f5..94fd89d18019 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: senclave-firmware@0 {
+			 compatible = "fsl,imx8ulp-se";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


