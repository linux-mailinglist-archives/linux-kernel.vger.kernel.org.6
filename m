Return-Path: <linux-kernel+bounces-201639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9E8FC127
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96CEB268F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D2B672;
	Wed,  5 Jun 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ONRhfvDT"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6871754B;
	Wed,  5 Jun 2024 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550029; cv=fail; b=PNbm2V7FWzUYx48t0hUhDwTO4L8s8RC3R0LWKazoJkHiTsrYwMW/oqzoAy298A1njn472aL+MIGKLVfphKxblNnQPthjX7+rQv22J1asUnuDokdZE4N0bnhG662SVhkl72No/SqYux1cTWT06Wbz7yn1/cPAvpG1+r92mfqN1CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550029; c=relaxed/simple;
	bh=grkM6SGvuBZZVRN3CdydC6WaUEf3mPaQGRlZbFs5AxY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Q4dPoLiZ5Ui0Of4MOMd9wGdfdgkjpMzTDdACRIArGTkuRHmDHmNMmGl0ZUgeNR9VU/+7cNx5VBu7cai9k02VBahzDchOk2i7StUgVUMAainXjfNDUzBq+XNFVeEhGMriKmZ9TFzj3YTV4SHb1oFRDOvC57PxtWgeNqAdHZTYfP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ONRhfvDT; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRN/A/TQJWc3cZAZKnrGizDyQPA8kt8ZY5vuh/V74fC8cOS24AXwF1Z4kKGiyGM6S5tHTPjoOxdyHtV1ESccWkt9USmFPyqOP5GNQWAAMNymXV0g03kc0fuLcSE4+5jxgRbUuDMs38v+bgreK0dZAgIgTnCU+7pVrkUpdgu0AvovvaLBXdCef9m6r2WMWh2Rg3MW78hEeQlKQZyuktsOlapQ+k9vhjGcF6sLbY0LBfSlhYZnHBDw46X7CRTgDVAR63KmXqoMEaa7OETVkL1O4YTW8xi55hGCTa7q7YXVcSzK0hSXa02TWN/XucOy5k+wNHiCZNzx05zp0XxlKB8nYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pv43HvNO5u70TBIOrJNp1iiZkmij+H8thAxMZhrauY=;
 b=DZei4FiSN0nbWR50O7PBOQ2m1Llw4LzIe0ay2RbOJ5nSY2XOp4MS1j1UcYJhu2K4+crJHJumkGG1ug5gNLfqKt5424fjIJbyEHaEu7NLfZb0/wVHKdksK46ee6fiDL0v3VKXZuNxRQ5W9xkojvN0yo0MOeh4dUo2qantKwPgAlzOajJWmJ6prz1V7S7wPXG20cDEGsl9yqWFdDNn2cu6CEmnVH+IrMewaHLbuVhZPMqRyyLT8bkF+IeYJyo0e92vh3wFz7h2veYjatg0F0T8CWUjCtk/F+bUyzu2f7po0Gk6XL67zgUUhZgIoP6W6bfmTVl6Oz1KmE46jWrZE7QQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pv43HvNO5u70TBIOrJNp1iiZkmij+H8thAxMZhrauY=;
 b=ONRhfvDTB54xlpOToWeUvUfLBdG7MiaWcWzdqUV+3+yvvI+ADxXLWgv6LUrl2ROC8NXP0jXr5Zv9TlcdLtdzMXeAifnJ837TyTy1RhChbtFRsUf0HZiBxlamXkI464Vd3DF6L9WA3b7/WMYLxppPDgzfAr6UXCNh7NF3+my4TfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 01:13:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 01:13:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v6 0/3] arm64: dts: add i.MX95 and EVK board
Date: Wed, 05 Jun 2024 09:22:47 +0800
Message-Id: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOe9X2YC/3XNTQrDIBCG4asU17WIZpJMV71H6aLq2LjIDxokJ
 eTuNdk0DRTcfAPP68wiBU+RXU8zC5R89H2XR3k+MdM8uxdxb/NmUshCFLLmvp0QuB0jT4prIkA
 nCAA1y2QI5Py05e6PvBsfxz68t3pS6/VPKD/BqxIUgqtrje7WTcPF9C1bM6n4UhDqQItMQYG1R
 mpLlfqlsKflgcJKyaBGNE7L3a/LsnwAZ2UeMRwBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717550578; l=3142;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=grkM6SGvuBZZVRN3CdydC6WaUEf3mPaQGRlZbFs5AxY=;
 b=2FFiTXy78K2Yij+gw7a+eYpS9dbJvLZKLssvHQB/CqBkyMXj7tHNhZHn9Iq83CW+kBCPob9K7
 EcWyNITqKVeDcRbCxqSwXERfNgwMuY3UZdHhRUsXUcTtGm9yE8LgrMp
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0e2a51-05d2-4e3c-5608-08dc84fcbcae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWNZd2tXMDdPSkZkdFd6d1NyaUttY2l5RFBSSDd3SURHdW1leHdlTFdPUkNK?=
 =?utf-8?B?UEdHYnhxcDRTbGw1ZVJVTXllcG05Wjd2Znd0QWo1Y0paMnRSbzFxNVoralFX?=
 =?utf-8?B?bkluZ1d6dXNmVjZSNTM3ZEM0SkVuMHNzLzhDMnZkbjdxdGdpaHAxSHRUZ0lQ?=
 =?utf-8?B?amxGTlc3UjJYMkt0QUgwTU1HcTBSdFlOYTM3SExQOFpOcld2WmV2ZFZHdit3?=
 =?utf-8?B?aFVBYW1rZ0ZhajFvbXYyM1VzcUtiZ2dTRUV1ZlozdnFvVUZVRU1LQjhhb1BI?=
 =?utf-8?B?S3lVMmxpSGhRbkZna1l4ejZ2dGlpYWFyQVFSL3E4RHhDd2ZsSHZKTzk5aCtE?=
 =?utf-8?B?bXdMaElhOHJmdTc5Z0M0RUoxYXhublFTTUtGaGhOMnJsZCs2UTE0VXp1UWR1?=
 =?utf-8?B?emx4R29DR29USGhrNUxUTElWcVl0WFQ2RkIrdUFyei96dWJmWEJJclY3UWdt?=
 =?utf-8?B?cE5pQWVZakZHanN0WWt5MlVvYUhiQ3VRWFpadk1pR3BmeW1lbmc5UFhVY2Ux?=
 =?utf-8?B?VE40UzZIdU5hUk1QUEVLZk16VHRIOG1wcHJvNFBrYzNHU1g1YTNjdkhIa2N5?=
 =?utf-8?B?Mit2WGxmdjJTSTFZVTlvdVNlTmhSSHJaWUlJSVV0TFJWbmlLRTJiYm9YUWo1?=
 =?utf-8?B?YXlPUzZqL3k0UEFGekoyeDBBWnpTZUNxNnFYS1MzN2lsZkpEeXdiUUVyMFZO?=
 =?utf-8?B?WWhHRVFzeG8waUlDZnNiRHhMaDJBY04yeTJXZVBnVm9WMnlpSmNtWUFXZEJt?=
 =?utf-8?B?R0JjTGFpd0RHSnFLTlpWR0JZTFJLazNRdUFLM2dsMllrV21zQkxnZWF2K1dC?=
 =?utf-8?B?SjZtRThKMVZjcUlkMm1EZVBESUJ2Zy8vZDk4MEtoWWdncFRYbVMycGNDSWNK?=
 =?utf-8?B?UUhrS1JvNjgxYTd2NWJaWEthWWo1Vm5TTGZTSEY3YlJKS2RraHJKeDV3MEpX?=
 =?utf-8?B?V1o4TWNkVDV1NDZ5MUJka1NuWEZ2czRzdmFkc0dhUDE0QW0wK21MbjkvQVRU?=
 =?utf-8?B?bGFwdHlsVWF1Q041bExIemRKaEZFanl5NkVFVzlHT3lXNU9hZVNqNHc4aWtE?=
 =?utf-8?B?STRrL2RnMXVQTzBxa2xrLzdkL2JDMG9mRlIvVkJsd3FoaVBKa3JyQnJsWEpC?=
 =?utf-8?B?RElzMGI2ajhCWk90WVlIN0J6NmI5cE1LRy8xcnpTSFZ6THlZQkFJMzVKV1l6?=
 =?utf-8?B?YWVDNUY0Y2ZwdWk3ajI1bEVJMTZUNksyaW1VaXZmNTljUnl3RlFNWGhSM1ZW?=
 =?utf-8?B?dFdmWWdjbUU0aG1tbkVYYXpPS2FTRjZITWdaYmdQSkNnMTZPZmM3Y0pxbHV4?=
 =?utf-8?B?NDhaTjVtRTZMSmpwcU5vTWVqMUduWlhGaE1FdXl5c1poaWNMbHFBdXdtRVlu?=
 =?utf-8?B?SVlmTGJDYTZ5aHVrVEZRNVErZHJsaFBNTmhyaGY1VzRlNXNQMmhDZmJ5UXZN?=
 =?utf-8?B?UFpzc1plZWFUWXFrYXJWaXl1dnYyUEVvVDJOYXRlN1J4QnpXRU5kdTFnZW9U?=
 =?utf-8?B?NFNBbkg2clVpd1B0Z1U5a05kbUJBK1NzL214NDVsOU9RbGpSdTB6UmdBN2Fk?=
 =?utf-8?B?V2NKOU5ab29XK0U0QUVCM0xkajV1c1ZsRm1KVGpPOUU0NkNkUUpIQ1pqdVE0?=
 =?utf-8?B?NkpvVmZ4SjY3S2NUbXdjSXR3UnU5U3QwMnRwODZkVnNRam5HZTRXbmRSRGw1?=
 =?utf-8?B?bnMrTElQR1hoVHZSdWwxQkhVME12RGhGTUZzZ0RtV3BUR2cyWGszbHRnMUFJ?=
 =?utf-8?B?b1I1Ym5PYXQxSHhqM1hkeEM2dXpuV3B0SUNuL2lKdEcxTm0rMVR5ZDcxR3pm?=
 =?utf-8?B?WlFNOWRtZGNyTjRqS1N4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alE4dHR6eFJMOHFSNkt6cnVKQ25Gbm5vQ1c5QlNnd1pFNVdhNThmemJkWVF6?=
 =?utf-8?B?em1IY09vNUsyY3NJdkxHOXBEQVZ1dWcwQk0vdnQrM2NZSDFpMW8rQzNseHEy?=
 =?utf-8?B?S05IeDNnS01sa0RHTjMvSFlOUGhuY0ZwS29LeW5JZklLUTBjR1VPQjMvQjlZ?=
 =?utf-8?B?U1hLcENzMDAyazZ2OXhnelRIcGxzWmN6TnZ0U0txVXVTanJwQWd1dUFIcWNL?=
 =?utf-8?B?VXlIWTlOVGFXTms0UG4xS0ZWYVRJZzR1QUl2OHRjRDBieVppblI5YkJ4bDRO?=
 =?utf-8?B?Z05zMS81YzQxekw2RFVVcktyY2ZTVkVFZE9YN1NWLy8vT0dKOWg4cmozaENX?=
 =?utf-8?B?ZDU5K1BWMEZZRzNrWXUyK2NHR3lvdTYwSzZiTkVTMXRCYTlOMXpsdDd5MFUw?=
 =?utf-8?B?UkxJRWVHZjhoeWlac1VTb0lvSTdPUVgya1Zyd0dkbTFrdzJrSkU5Zi81T0xn?=
 =?utf-8?B?V0MvTFQxc3ZKZnRZZFFYcHkwU0NpWU85UlNSK0FxbCtVb29pQTJZK3hhN1Ur?=
 =?utf-8?B?d1VDcVZYOEtuTFBOZTdUb2RYMXo5L0l6ZVd5YlFsMlVERnZvSjdrZXg5MHN0?=
 =?utf-8?B?UEUrZDJHOGZyUHcwaElQQ28zcXA0WFduaTFNUVRWSmpBRXhlN09PU1pFNVVx?=
 =?utf-8?B?VFVCalpta2QrWVYrZnVrTzZiVkQwbENubFh1SUZwKzdkOUE3R3JsRng1bHBY?=
 =?utf-8?B?NUQxbTZKVlRTeTA3RGluclFJcXBSTGovOHlsOTZ3STdqdytkSUxYRkJ1bTI5?=
 =?utf-8?B?eXBIQTFoOU85SkRnd3JONlBWQXd4cmpGRHBRV3dwVlFMdXpvT3VNQUZydkRr?=
 =?utf-8?B?UklVVkJYd1dQZGFoMlRDaVRPYWNyZkEwdUt0TXlIRjJCVjZZcXpER1pLcHhh?=
 =?utf-8?B?OG00YzRVMER4Q2h5c0JLN2JDRDVBdk14NXBhVG1Ka0NKRWpUNVZxVFlUUkpE?=
 =?utf-8?B?cmxQUm1WQ1puV1ZuWU9yUFBrU3g0bW4vc2VBaDZDbDBNZEhRRDY1Y20xL3BI?=
 =?utf-8?B?Y0E2V052V3JjSE93TXcrcUhhR0crRVM3M2xQUEpCMjN6dllSNnlRcGs1SC9k?=
 =?utf-8?B?M0x2c3d0Ry9DR3JiSmZFQVhQeVlGMXJ0UjdUTzZaS28wbjR1MjhDRmJKOHpD?=
 =?utf-8?B?NHZqeUMzUVlkTjJKMzFtcXMxeWJvS1ZPYWdPSURSTTlSdVh4ajZzRm16MFFu?=
 =?utf-8?B?NGR4eWxVQ1kwZ1ZxSFpmWlA3WTArYlhNQ3BseG1GUks0NVR1MFpDZm5pZ1NV?=
 =?utf-8?B?b0RqcHFhVnlrNGlPeUpkY21FN2lsZGI3eWxSRS9FLzRNaDRIZnZ2d0cwSkxJ?=
 =?utf-8?B?eHJsS2NvMXJnOW01MzM4SlpSUWZiZWJsdEtTb0Zjb3dDU29iWkxlQkxOK3Fm?=
 =?utf-8?B?WG1kcW5lVy9PbjdKMEJxcTA3NTZRSWVOOG8xeHlxaGZjNFJpWVUyQTByYjlv?=
 =?utf-8?B?V2lWNUFwODFKYWlidVRLOU1hYWVWbGJXMExRZlRzUFR5UFpRMWEveXhzNFJs?=
 =?utf-8?B?UHd6a05oQUJVZmtISXRKaXpLQUFvK2lTanNid25MQVB5SG5MTEp6dzl5QWRr?=
 =?utf-8?B?UCtWbUVTVmVKYW15OExzbkFEd3AyRWJNVGJtQXdWbmRMVUhhVUNpMHBzeTVs?=
 =?utf-8?B?MHB1M1ZEUmtrWHNzSDRKdUtNVjJ1UUFUSDJncFd0SU9FdlEwby9jTEdwWVdT?=
 =?utf-8?B?TzE1aVhzSllnVERHVTZCMzJTZ3RpUHRycEpsZ3NFT3NrcDRLeGxFVjN1aXh0?=
 =?utf-8?B?aWdUUXBJUEpJVTJMb3htNTByZmUrLzE1RGhFQVgxY09lU0pPdTQyUk1RRWpo?=
 =?utf-8?B?MGdEZkF4MU5oZ3pGNUowaExuT3JaSWs4RlcxK2dsY0gwdFM1T0duNXVWc2dU?=
 =?utf-8?B?V2VRRk5SMUtMdzdwRjc5ZGk1OTUvNTJYd0wvblI0RkFWS3J6bVdxVytGZVRp?=
 =?utf-8?B?ZFZ6NFo2R1dPaGZJU1FCRklkaUpUbTd3TXpCTk0zVEVGdWxMMlV6RXk5L0pV?=
 =?utf-8?B?NXl3Vk0vSW5iTjNNT01aS0V6VzJ2WWlQQndCRVhzNGxWa2ZrNHNxSlJ4cTJi?=
 =?utf-8?B?c1lXYzNpTWZ3enJabmt0cWFKSDU5ZTRwMlpZcXVvZktwQTVxZVVrL01yNEgv?=
 =?utf-8?Q?Et7yd1ulit1Fy5W3tWY1Nyvgt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0e2a51-05d2-4e3c-5608-08dc84fcbcae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:13:41.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIOC7jITeshi9+2zHy3tIzWq3b0lD1UOtEc3VkyrRo7Y46pqAdy2Y1CzCUqhYAq3KWf5Wlr0WsV0WbxUhrFSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware that supports
pinctrl/power/perf/clock and etc.

imx95-pinfunc.h will trigger checkpatch error, that is expected and same
as other i.MX platforms.

In v6, I added back a dependency on pinctrl, because [1] has got A-b/R-b
from Maintainers, so it would be soon got merged.

There will be dtbs_check error before [1] got landed. With [1] merged,
there will be no dtbs_check error.

[1] https://lore.kernel.org/all/20240521-pinctrl-scmi-imx95-v1-0-9a1175d735fd@nxp.com/

This patchset is just a minimal support for i.MX95. After this patchset
is accepted, a following patchset will include more nodes and features.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v6:
- Add pinctrl nodes and pin settings
- Add imx95-pinfunc.h
- Drop fsl,cd-gpio-disable-wakeup which is downstream property
- Per i.MX M33 SCMI firmware, drop unused PERF entries in imx95-power.h
- Rebased to next-20240604
- Link to v5: https://lore.kernel.org/r/20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com

Changes in v5:
- Drop unused regulator and alias for now.
- Fix CHECK_DTB warning.
- Link to v4: https://lore.kernel.org/r/20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com

Changes in v4:
- Sort nodes by address
- Drop coresight nodes
- Align clock rates for SDHC1-3
- Drop wdog3 board specific property
- Link to v3: https://lore.kernel.org/r/20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com

Changes in v3:
- Drop irqsteer node because binding not accepted
- Pass dtbs_check
- Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com

Changes in v2:
- Addressed Rob and Krzysztof's comments, and fix dts_check issue
  To pass the dtbs_check, need apply:
  https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/

- Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com

---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  200 ++++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-pinfunc.h     |  865 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   47 +
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1063 +++++++++++++++++++++
 7 files changed, 2369 insertions(+)
---
base-commit: a1bede4830147a5a29ea6443724837ee0b126fd9
change-id: 20240428-imx95-dts-v3-bee59f0e559b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


