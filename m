Return-Path: <linux-kernel+bounces-278088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083F94AAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18B91F21666
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB987D417;
	Wed,  7 Aug 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I/E03qGj"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4085260;
	Wed,  7 Aug 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042355; cv=fail; b=HsbGLpDckWwSLVZXZIONstVMNhQ4xhZrDYQ6IgBCbA/4bhua4MglZjIwgp5MDKormZ/Qi1ue1w/TcF10N/+cCwp091E0QbITs8QIhL+kykHLJlxeX68ZTFCqKN2TidqSHAlRnN+xLxX9OvliFx4pvPRtBr9/KTYaWeRtKlgGzV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042355; c=relaxed/simple;
	bh=iouRsOKgRGRGr4+NKHRXhr+VczTd0eKUqPVGhMbbdGc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GLfC4u/h3VvfYrkT0Y0V4TwNHn2toGY2RzmjbH+C1aAZZ2DIM4gg0MUhsIkQqOYrnGFTqbtS28hj5gDbqhxGTRMkAGOgIFd9I9LxQbmyCPawZE8AJPhT7rYGI71PgdJ3nh/CR5mWQ9uoL++NSDP3oEq52iyJN8W35D1lCgBIxsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I/E03qGj; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc/2DyJLPJe0l7H/GwJxWDsWa0xt9zSV6okRmwG9h7A80vf3r0hem0MQTbIE80xAs9AT5NdT2TeFXyVFQ1vnWnS0y/ioYlVts9qmS30Lsdar2MpmqZBk/eDI6JaAtE/PfyL10099ra73Nqa9M2K5QxJWO6mZ7wz2FsMNRuQz0TyZ3ndJWsKtlduhKPYHkMZnsb73FI+ctstL5KG3K8fwiUoqh8RZR2prtXd+MjffYjdZ56EGvWroG+4NC1M9p2hCusyLbA8JowqW5iDA3aSdyVWSNw/a0yAMV89Dhdcs/CJ8U40QKtX5uZut6YBElJPLQl6kJ25j2p6QdYoXXk5kVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6NlqoKdc7MxQLDfLvL3WviLbenl9O5+BQiX2K1VOoY=;
 b=kRZqfNjfHtHAbURLTUwM6eBRB4Oazxet/+WIVi5eNJKY5JN3SQH2+HEDVV1EvLyn9VZz4OvHi+3OhndUqdaqBNcUIyOh+OOwazKUlY9ab6nARvl1/sHvQBHn2bAHCCuyx3WwsZ+VsFkNJdYhd3H7HWnioNuCvzA70nWt4LTPv5Pxe7StLHTYHdRUYK3NvSwQCgF4i/anCUgEf2dS6LJhS8m+FR0gbMGQ0dJ7iOZlKLOFB8oCYPptQyoOmB3U8i2LjnevzoGB/hBRiA1VztlCIBnaeEjYN3Uo0H5ogztdpaWSnxskqg7Q1DeE/kb7M3SgzPGMGR/apyxuTfFOSgtbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6NlqoKdc7MxQLDfLvL3WviLbenl9O5+BQiX2K1VOoY=;
 b=I/E03qGjSU/lCI2xHdUdw43pooqOSBr3KxWQa3rw++JcwcsjDCiBdROYkJr0tyssg+A4VAvV3ZYvnir/ncjFsAgVoe+XKBaZ6psYqmYS+4Ofh0Vwnp42Cfst8A4woNsYcSepA/KYS9dFZ5eK7wXcQHIe3p1b+3Vejx3vDOKrErFdYAQa1UPio8KEYworaRoOsnMtfv1eb+yk5xj5M+5irtKMeL3gu5JFv8cCgHs6TeVuvsnGIUrQec5hIrC8pp6kuSid6wiUSHiJsO1sUFVff01SAAkV331nqAZHC2ExarDWZpaUvK3R7Ps0AtKYwrlXNgp0aG7U6D5xqJiRrodxdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:52:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Aug 2024 10:52:08 -0400
Subject: [PATCH v2 5/6] arm64: dts: imx8mp-venice-gw74xx-imx219: remove
 compatible in overlay file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-fsl_dts_warning-v2-5-89e08c38831a@nxp.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=888;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iouRsOKgRGRGr4+NKHRXhr+VczTd0eKUqPVGhMbbdGc=;
 b=8LfG0SBnvPfxoCs1Pwfa0ESZN+YUwFy6pC7cThq1VlkGPgeGG40Af+aHckyWU9PpVYsJzUzwt
 cmL+ab+hBtoAyVWxPueYYJHNaFT3x9h8ikri9I5Z7cT/fPA2qgp50Su
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9e660d-8c37-4db0-2d56-08dcb6f08ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjlPeTB2dVVZRDQ5YU9vRkZhZVV3bVlsZ002TkU3UUpiaFRkQkJpbGlRQ1Z6?=
 =?utf-8?B?VHFVMVprUmZZc1lraFB2bG9lVlE2UFdaV29zK0Vxdm5rR2EycVBXZVpneUR4?=
 =?utf-8?B?QnowNFdseE9aVWhnSzlBT1RLTThjK1ZDWWFQbFQ4WTZEUWlXWWNmZ2o3VzNW?=
 =?utf-8?B?NWdVY0pmNHBhUkVwQTYxZnBkSXI2Mk55WGg3Qjl6L3VLa3FPN2k4VWdaWGZV?=
 =?utf-8?B?UmtVZjg3M1M2V2NYanRvZG84UlJlMm5zZFZ2Q1MrWk5jS0dwSHJPYm9zVW9M?=
 =?utf-8?B?aDVGTFBiN3FIeS9taWQwSi81cmhxb0ZGUGwxc2VsbnJSVjNPeDBiYnRYR1Zu?=
 =?utf-8?B?elNHbkk3cXExTjkzeFJxOHBoazVCV3FxYVV1T1FXdXB6bE9wd1dOV3VmTXdS?=
 =?utf-8?B?dXYwVVE4RG9USkg3NWNGTnJKY2haWXFUTmxFRGlnZ2orK1RmZWxVRTdNVWxQ?=
 =?utf-8?B?dnpIaXlGaEJyT1d0dUNIWWhHQlBQZ21LVzRxYytvRVByVzhJczhzUTBqS2hk?=
 =?utf-8?B?THNNcUtROWJwbmVBZlg5a2l4bGtzdllTR0RjZVpLQjBYR3VvL1JhbEs2WlU3?=
 =?utf-8?B?TStSNFkzTjNQRGZucTJ1dVM0Vmp2cmdqNzQ3Uzh4a0J2MlBYczlETUZ2Nmc2?=
 =?utf-8?B?ZG1HRVc2dFg0c3Rab0ZxU3VNRnhOaU4walRjZjBsVWtsOUE1aEYzRnJiblFB?=
 =?utf-8?B?emw4dW5HZ0RvWVNGY1hlRzE4V2ZwRmcyaHlOT0UrZWdOdFFDZXZDbTlqT2xV?=
 =?utf-8?B?WGN0K3BjalV4QXVhY2VlSlMwMFdoc0FsUTJpS01TTW83MkxGSFJBRFpueS9N?=
 =?utf-8?B?SHczL2xBN253ZlFlTkVHNmRnODJVUnR4VGRhRS9SWlNDSGhKM2NPS0pTY282?=
 =?utf-8?B?QzU2S0gzNmREaG5qN2NLdkRiVlZ4S1JuN1krdlNxMkYzV2E1OGRwZ1Z3RGJh?=
 =?utf-8?B?MmlqOHUzQnovTHE3VDBpQWtzMTA3QUdoeUt0NDg1a2dpR0xGbnZKQ2ZkWDh3?=
 =?utf-8?B?b3p5TVdkSkVaeXMvcmJkalpSWnR0K1JGankxcThhTlM3elRxaFN2K2Y4VDFj?=
 =?utf-8?B?enA5cWJOcklhK0hrQzJiY3ArWTFkSTJLSmJ2YmF6dnYveUpwcGZlR0tHTDJa?=
 =?utf-8?B?TWthSHhuY1pmeDQ3L05HdGlERTlOM1c2MlNobDN0bEI4eWFrZ0dSVVZNeERp?=
 =?utf-8?B?eEllT2IxSzUraVl0NXZjc0ZWaDdzV0YvbHhSUlErY3BVWW1PMkQ3SzR0YXVQ?=
 =?utf-8?B?am5iaWxjekh6Yno5SjBZQXBaVFNNdFhpdGphL2tyV00rTmJjQ2g4c0F6TmRE?=
 =?utf-8?B?Ym9qMEhJZWQ0VmVwS1dxc3d2UG9hMnVKVmpCZFc4cXMzZHo4RlZuSkFLWjFQ?=
 =?utf-8?B?ckk4WjcrQW1UcmVCR0owYnF6bEw0RHNCRGd1YWRTQjhCZ09wcmljWHNEUElJ?=
 =?utf-8?B?clJmRUtjbG9ZMWJxZ2JmZXFEdytVeTZKeFU1cnU5d0hRdWRCOHhDcjNXS3Zi?=
 =?utf-8?B?U0hwQ3ZUOWlEMkZPM3owK2JXTFM0NzlONzlTSkxGbVd5eW1PV09XZTlrWk5K?=
 =?utf-8?B?Skg1NksrMXptd0Y4c0pSV1JjaUxsTW5GcGFmMEVnNUpoNnpEYmFCb3FSQjRk?=
 =?utf-8?B?dlk4SFdFSTVDOW04S2FycHZIZTRmb1hnR3I1bDVodGMxLzFKd3FBZlYveDFP?=
 =?utf-8?B?UkY1bHZSSU5PUm5sVFpPd1lYWTMzVFVmVmNiaTFwc1dqYTMxcjRtdTNrdWM0?=
 =?utf-8?B?SHdwOU1NMWRneld3T25rUE1HazFtYjRBUmxITFhSNktaVGQvWEk4YXFmb3Rn?=
 =?utf-8?B?Qk15bVdPZkJWZzAwWk9wUEFjQm1zNzgzOGs3WE1HZkRFUmVEZHErK0JBT3cr?=
 =?utf-8?B?OHMvdnM4M3c3Y1JhYTNGRmxQK3J1bW1GVEZiazAwbkZYWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGFsMFQ4TWpQRldBc2p0cWhRZWFGclV1RVlQMHVpR3UwRXJrYnBCeGZMd3Jq?=
 =?utf-8?B?aUFIeW5KVXhQeWpabWtUaTI2OC9aTktMQWtqMVhiSngrVUlreVFEWmlNNlFZ?=
 =?utf-8?B?UDVlV3NVb2xoWUFNRkFWU3VTMVBGQjAwQ2xrZzY2ckdIaURBOFhTeGkvc2xU?=
 =?utf-8?B?dENiREdybGFXdzdyVnRvRVpsdGIyZWV6bjA1cGN1czQrQVQ0MDBYQnRCTG1B?=
 =?utf-8?B?bTVyaUl3SFVLRXFPZDBaMkVZMGx3aW9kdFhjSHQzTXk0UXdnVnh3NTlITE5q?=
 =?utf-8?B?dGY0VGYwckV4dFBkQ1phcGsrVDBYcFBVOWxZV3lOZ0VUalVWRmhQVy9OdGhU?=
 =?utf-8?B?eEttdG84RXM1WEd6dzluUldFN29Sa1VrVExscFlFRWJSQi9vbmlnVHlXV3Nt?=
 =?utf-8?B?ZTNVdS9sZ1l0MU84SWpzWmhaUjRqcWRJQ1k0RzVQOStNK2hiNFNZa1lsRldm?=
 =?utf-8?B?RzF6Y2t4Q2M3ZHBNblRmeW8rbktjdE42QkNISzRUeFRhbmpvVGxpWXFpbncv?=
 =?utf-8?B?UHI1QkV1Umh1QUVnNTZyNGg4NkdraDdUcVcxcjlWRlh1M1B5dTRGMml0cWto?=
 =?utf-8?B?b2ZaMDVQWkErb2VPczJTMGdMaGp5Ui9pakNCblRpV2s3MVZyMnJjY2RXSWRW?=
 =?utf-8?B?UTA2UE55Q2ZNUE02QkRMWDhaTUwraEhnWWt0eVJ2ekNYa0RQRXQ3L0FFTFRa?=
 =?utf-8?B?KzFWR1dhVTBCaFRwWFROeHh5VGFzeGtJb0wyY2YzbElvcUthTlhMK2hIQURa?=
 =?utf-8?B?b1pTNWg1ZHUxZS9zRTluYUlJb2p5STVxMEpVanQ1eHRFYlFiOGQrTzFmSzBM?=
 =?utf-8?B?NE9FWWZTMzlvSWhiMzRRU0JpUFpsSWFRVHlTUjhiU2RUQ1lxdURBZUtDQXNu?=
 =?utf-8?B?eWh2dzhGREtsUlNlalo1ZnVRZC8xSnQ3NzNyZS9NR3I0Ui9XaGorQkt1d0Vr?=
 =?utf-8?B?WjNHaWpBSXczRWFJVjNORklDRUhLek9Ra0RieWpIdElCa205d3lLRjBNSTRX?=
 =?utf-8?B?UlF6b2ZBMWdVYmhXbG5iZGExWUdJWnRkc3BxeHcxUlVWU05QcFlpTWpNM1Mr?=
 =?utf-8?B?UmRHbno1ekoxaCtmdG1jdHA1TVBndUlyZE1VV1g3Y0lTVGhMMUJQMzYvZVND?=
 =?utf-8?B?ZTc3TXkvOUV4UkQrajJESUZ3MHNUUDJYdFVxMEJPOFRoUWZsMHRPMUMwbWhL?=
 =?utf-8?B?bkJrRkpDUlE0RnAxZUxVeEVDemV5ZE5VOVFIV1NxZXZjdHk2OUhySE5SN1JP?=
 =?utf-8?B?eDZmWkF5WCs3N21xYVpEM3crdDlGRitEVnhqWGNBL2pNb05MNnNGY1ZmcFZR?=
 =?utf-8?B?NklMUEhvN2Nkc3VoVnhGODN3dDhlakdZc3ZoM0NlTThpblgvUVBYUjYvcmYv?=
 =?utf-8?B?dURnTUFTMnhIYWY4UnJCSFJZTWJrbkp4WkQ2MDV5UVBlOEh6aDdMVERpbk5O?=
 =?utf-8?B?OWtSS3JPZWc0SGVHWmVXc0FRYmhFajYzQUxGNEthaGJSaWdBK2NpOGtGT21X?=
 =?utf-8?B?clgyVmt1NjhCSmsweWtiM3VraEFETEh1Rlg5bW5QVTROMVV5dHY5dEE2Y3J6?=
 =?utf-8?B?Z2JCaTd5bVB5OWZ5WWRvTzdRbWUzeU9MRktEbkMzeU9NM3FwdFFicE5mcjJm?=
 =?utf-8?B?L21uZGtSV0htckJjR015NGtjUmRTZWVEa2x6SUU3L3IrcnZJczZSd1dUR3Vw?=
 =?utf-8?B?OFNISFo2UXFMSDluSy9FbllDRko0U1Rna3hTa2lTaTdXRmZzMXc2TUVrMGw3?=
 =?utf-8?B?UWRnNFlJYjdLbTVETmNLUDlTallwK29TbmM3NEs5eUhWZU1XRFFpT2tla2Nm?=
 =?utf-8?B?bHlkYmtXRDRRVFl6ZjNHV2hPb2R4cjZZZnFTbW5wVXZ3UTBtMkhiVCtzS1lm?=
 =?utf-8?B?K0N5eXVadzBId2ZNZ0d6czFIQVFhQzkxV0pLZ0xyTE5YZEhWMHZqWFlHMU5T?=
 =?utf-8?B?ZGpIdFIvc3JscnRxRXUyN3RYTlNqQ0NORGxhN0JJdmxIM3dvOFFzcjRoVitl?=
 =?utf-8?B?R2xMUzJLOVRNVEQ5N3Q5ZnAzZ3BSN1VvaTZabDNaTVBzeVdiWS94azNkWE5W?=
 =?utf-8?B?eDk2MGRYRGpTQjF0Q3d6bHVLQWM1SU1HNUt4cXNqUHU0Z2JRQmtPSm56b0dM?=
 =?utf-8?Q?qg2k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9e660d-8c37-4db0-2d56-08dcb6f08ffc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:30.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZyFnbn4LiQ08KsnuysPXdloPJG+IIrzRca/WBAddqdhRYbdxdjN2Zfdmjb1zD6ExBXUhj/WGj8g1dlHTI2YWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113

Remove compatible string in overlay file to fix below warning:
gw,imx8mp-gw74xx' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove compatible string totally
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
index edf22ff549a47..eb673a947484a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
@@ -11,8 +11,6 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mp-gw74xx", "fsl,imx8mp";
-
 	reg_cam: regulator-cam {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_cam>;

-- 
2.34.1


