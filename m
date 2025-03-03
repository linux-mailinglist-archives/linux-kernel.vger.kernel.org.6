Return-Path: <linux-kernel+bounces-540912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498EA4B65B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C034D1891D09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8D1E5701;
	Mon,  3 Mar 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ISEAQJd9"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21111D5143;
	Mon,  3 Mar 2025 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970507; cv=fail; b=h1UgkpkfbgdV4Pi/LxP+8NJn4ZPCvdZwRqjvNOo1OXkGzA8K/Lpcx8hT/dlhSWSPFT5o1ZE5dVUuXRRFO83eXS6D8+BAcXN9BX2fSQF61fI7jP2LKix/xtCV+J9P9SlAvSNAx4pl1604ZGJwuKoxA6cIFGblw/Z/D4oedKB4Aa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970507; c=relaxed/simple;
	bh=F4r+LZLEzB9u9VVMvSfCPOeO9GCfOo6JqbvfjN/ZzbU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Btj29knnSboay4NVk5/XtQgkIXY9gEAFEIZfsW6eYKOE0eXE45vJVesQaZL8hKm0mIZ2kt7UKpdiQgTu7ksoCs/39pxFrNcKA8OXu5NVfwUK0Fac6oCWPiHzoBDu/OTt5el9vgK3nVtziAwz1WkWib5jSDAINvau9KWbhxV4/LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ISEAQJd9; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq2JF+1v6SV8DCafhsNJk0iH1tEhZi4dhjMFY1VkDBZl51HsDJlMhGze6wxwLs1XGfx0fg0KFuWq3pLScnm6sdPq9ysVujliyQF1Rt2gjXXYQkfJYnrLoiy4ZFKIqeBqHff3ipFuyut0ZdpZdeAyKMiDuwW5F6G2s/msBAhYk/o7rpYMvnohIbBbr55DXnxhXunug9VMTP8y4xtuiYaHhOjdEBBDpuIdqKhUdt0zhyNaZrqRJeo8Pt2rinFLuWXYRyVzEfZEEAoq54fZS/zZNS3hIZoWGF1/GhHtuQLZ8h5kEhhDGTxFx2mkEKhGHZYyp/A2foylSD3/LimNhYc2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4saOsBOgi+0f8h7V4n7y53N8/9491i6tjLs18l8SaA=;
 b=CbQMGVJs45ejdaiaHUH7YWVq2nCgRR/lVx9PxD/SiE3a8+QVIEUmrU/hdCmVo5Vx4qRgSo+ClaQSKW414C5l8Y52j9lkRlTJ2eWAgvdcLWF7EQZa/Gl8mtQ0xHBJIifmccFPBwq6SXbW+HcY+MrcQjZRk4IaPi/2NjxxDE89Li1VNhdxr8cCqkYPZNrvpoSNl64TrjbVGjpFi4/Wgty1+/6G0OZpbagU9J+D0lsZelKdZIVWjv+YTwv10Ao5XFFI9Z9XyD8SH9/YI3xykdIiOmCFu4y+rCKG0zHYskpb5zLa7Tmr17QMuAtwIrf1pfvvv5Tzrcg92Tn7MPEshv//wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4saOsBOgi+0f8h7V4n7y53N8/9491i6tjLs18l8SaA=;
 b=ISEAQJd9/6aSHhhKC5CjhSl490lHuxjGn/wEBfbdhux+dt7H4OqOFCxi3JTqgkAcQzFQPhUIH8bYEvvnByzkpLZ0B9iMlnKMdGyGZ2AY2U8SvKkz/ZUAceJT7eawgHNZR9TD6+n8lesz2wTyKibEorYyzG0lFysRc4ArSULytx+Oh0PzFdL6Qz/YY9ZoaLe/FcmwLp0zZVtRi/EC1NicaUYiKShp7b/B6d2nY/BH4+4zJK/I5ritIbGYZcWQRxrtRNqSL46F0KmNF5SKd0cepipTAz5Etxa8BvyMHvYLRv33UMe629dvTeL15LrWYIEp2NDLdq0XQ89lHqVH6ymngw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:28 +0800
Subject: [PATCH v3 7/7] MAINTAINERS: add entry for i.MX SCMI extensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-7-7695f6f61cfc@nxp.com>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
In-Reply-To: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970414; l=977;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7kqFdT1HlaAgIuYv1Gz74ALQ5FFCXeTzlpMG9JzOxgs=;
 b=k3LLYaOlQRG4qd78R4F36U7+EdF8Xvz3744bqhClV5WaruFBWb6uy4ddqbTVD5RN6hzmgcJAu
 ldMIaRWp5yACkQ44WVvCEg541o2LSGYrJRQPHbX4yWX986SwFIreJHh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 68272bbe-ab33-4061-47cd-08dd59fec833
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkR5MzVjaEE4bEIrcDJ3bENpS1NzNE92c1VRREZoSkM4R240YndGNU9sYUt3?=
 =?utf-8?B?cWl6eUxROEd2NWVDNitXaGh6SXZIUlJHUlhhVGhabVIwNlBKY2x5WnR5T0dl?=
 =?utf-8?B?OVBGQW5CenY3REV1YVpkUktubWpaSDduQXp1SWNMdHFaRTBKWUp6OHVzVGN3?=
 =?utf-8?B?a0pHQWxaZHpXeG9aVGhqczFUMG1wZ3c1bVFhbFBzZzNhVGNNUXJWbUd5SjJC?=
 =?utf-8?B?c2NBcTJidG9GaG5Vc1BVMXdMVUtHQjBTTmY4Y3NGRENaUTNUMkF3cFJMUVM5?=
 =?utf-8?B?MWlHN00xRVlFTk9WUGl2YXdZNllJcEs0VTZpWU8rZ2syNzl3dXBHOXljMkRV?=
 =?utf-8?B?elNzaS9EYkVybGJqYkZJcjBCNk9UNENVYm5GZ1pRZWJpbFpicEJGRGwyS012?=
 =?utf-8?B?SGhudXhDcGUrL1JlK2xMa0xRellaeitGQm5MMnBkNzJiRmtLWlJuYWVaSGpO?=
 =?utf-8?B?N1Y1NlhYZ3ZxaS9lcmxRQStpRWNER0VrRlJCYlVxNXc3enU3d25wb3JEVGEy?=
 =?utf-8?B?LzF6VzNsMEJwL0RzSHJ5eHAwNWN0ZkdhUjNiNWRhcGtiK1FOMUcvbHB1SmlG?=
 =?utf-8?B?MUphMGd4Q1dCOE81TFUwcjdYOFd1Wk9MS3IrY3RSWU5EbjBFV1BXYmJwWWYv?=
 =?utf-8?B?SG5hVDZFVVRKOXFiNFo2VVJZTkZhR1RaTFNMN0tjOCtFS2dBQUhxdkRlQ3Av?=
 =?utf-8?B?aGdGUlZkc1hrYWNzYVoyTW1MUENKWTRpbUV2RDRFUmdpejlqYXduL2JsOFNG?=
 =?utf-8?B?OFZhU2h3eFhqaElEV0IrMVE2d1daWk1KcXFBNVNTTDBLQ3EvaEw2d09TQWVm?=
 =?utf-8?B?cE4yR2hxK28xeHNWK1E2WmtKNzg1SEpwclFkM1VpQmNxQTZyOVF4Tml0N09t?=
 =?utf-8?B?TVdydCs3T29PV1ZoY1p4ZWJIbUF3THphWmd1Z2htWnIyeXVJSTc5OWxadkFx?=
 =?utf-8?B?a0J1Z0cwUW1OVHMxSUdYeVVIRnJtZWVNSHQ5enppQ0gxcVJESVdZOWsxN1F4?=
 =?utf-8?B?VUg4L04rRyt0WTVCUEJDRWtxK0tsNFAwTW8zdDgrb1QxWDdVT2pTZm05Mm9O?=
 =?utf-8?B?d2tJeDVSR3l0d2RYMzFXR1FyckpvRXowbUg2ajZ1MkxrQUdDSERtVUY5TE9T?=
 =?utf-8?B?V3RuM0wreVIrNFcwWHF1V1JZM0w4ekJHNHI1dHBLeEhiOVFLUExLaU8wNFl0?=
 =?utf-8?B?OWpEY0l3TmJNeExqZTFXMm5LTGY0azAzaGExOXdacUxLOTFQUVp3b2R3WXFy?=
 =?utf-8?B?dlRNVjIzUWFNckZsLzlRcDlrSlBBanBEQTB5eGxvc1RtcUVaelV3MEREL21V?=
 =?utf-8?B?RzllR3ZGL1I5ZldnKzk3MjR4L09IOXo1aDdsNjduNGt6RCtkNXF2SDRiSUZE?=
 =?utf-8?B?UU93UE93ZklJQ1V2NWw5eTJVeHV2UllPZ1FuaERtUWhqYmtmay9PY1ZxZXht?=
 =?utf-8?B?a3UxQ1ZKSDhicXhWR09HWitaejl4Q2F2dnZQRW1kL3JYa2g1ajJtZFVUd2Jv?=
 =?utf-8?B?aGtLS2d1MDMzc00zSnBFZU1GOGtQR3k1UGhsL0xMbGNNcmNhSEJWdUxZVWRC?=
 =?utf-8?B?VFkvWXFUbURFaG9jbmE5RVhCdVJiQWJDSldJZDkzZUpMVGc2Y2Rtakl2RVZZ?=
 =?utf-8?B?c3dOMC8wTnV0VTBFM2tJdW9NVUZ6MmxHY0tjbmIxNFRCb0NJV3Z1bENvYTF3?=
 =?utf-8?B?NjhNWTVFdGV5c0Jyc0RLZ3p5QmpPVFhCRzlkd2lVVkhNTVFra0FHajM0TkVO?=
 =?utf-8?B?YmdDOWhDN0d4OUkzelZYcXZIQk5tRHppQy9KVmNLdFdnNHBCZHEwRkRFcDZx?=
 =?utf-8?B?dDFKMHdPa3FRWlkxZ1dEN3M2ZmVoWktQb1JJaWRTYTNLankwV2VoZzFQM3kx?=
 =?utf-8?B?ZXFnRzVWWmZGdlpyak14elBMT2NZaXY0aHJCdlJ1ckNkWlJxZ2VPNjJocTJN?=
 =?utf-8?Q?tsgOYQV7ypljaZuFBZ7KKiUc6pcoFBOk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC84cnhPRXMyTmtIYmtCak1DRjY1aGhWMy8rNU5DMFo4Z0lvdHd0V1MzRzBm?=
 =?utf-8?B?dm9LQWkzYjVraXZHU0cxdHNCeEVqSnZPd2RQMVdTNXEvTkVCdWdPb1lKQlRV?=
 =?utf-8?B?Yno4bXduYzFNbDJqQUI5VGJKZWFad25xL3hBY3BEeEEyRnl4c25pWVh0TDdX?=
 =?utf-8?B?d04waTBUa0pCNFMwWklTMnFzMnBmR2V6V0VtNTZVejR0Z1YrQXA4M3NQVUk2?=
 =?utf-8?B?dG9LdDdVY2RiMVFUZWFnOEgxUFp4U1Y1dTFwbXJpblRaVGdHR2lsU1E0NEtG?=
 =?utf-8?B?QzdpbVpVZGlRakEwbFdkdDAxdDNjbGlOKzByQTB0c0VTU3NtTFR2VVcxRXJK?=
 =?utf-8?B?eUpzQ0lPdDdGbWN2czIzSXFJUW0yUityM2VXa3JhcmE5dEFqanM3OURoNzl2?=
 =?utf-8?B?M2JVV1R4cFo2QlBkSnpaUHN3azhCYnpoZ2xSS3pjMnVLNGN2SHZ4TXp6SzlK?=
 =?utf-8?B?NCtCYUlCSzZSUVdkRU05ZkZUNmh2bG5ZQWYyZFg2eHo4OEQ0Y2RrcDlNR3BE?=
 =?utf-8?B?TjUxdXgzazdodThBcFlDa0ZTMWdtQ2tldjJiUFE0U2lJUWRlN1ZmQlgwUEQ1?=
 =?utf-8?B?WjJIUlNYTmtvSjB6azN3cWNvU0FqaTVMRzhjQ20wSjFoSHo1L1ZQV0VPcUty?=
 =?utf-8?B?V016RWFvd3JCKzRhb2lpM1NNUk9uanNRSU5tUzFSblBjdG81cm9BaVRoZVVq?=
 =?utf-8?B?ZGtIeDNEaDhpMTJac0hZRk5DVXJRalNGOUlua0RBcFJYSll5MWdaYU0weTB3?=
 =?utf-8?B?RzhUSnpBOXkrKzRQUWNVYkxteVVFSndpd1VkUTlzL2ZNNk9qdEFzZEZZZVdI?=
 =?utf-8?B?MEUvQUVHWmlZakx0OXFSU1V2Qk5HQ3ZPalE4VUhuY0ppdHU2OXg0T08rTXVj?=
 =?utf-8?B?d3lGSGt0SjhmRzlMQ2JoeXQ0VDgybGNVdjVsWmZ2ajhNb1pJaXFpMDB1SXhx?=
 =?utf-8?B?eCtMdkMzZTljR1U5enZEcHZvRCtDZ2tOcFZ0dkRETkR1dXBXOWsvRVlURit3?=
 =?utf-8?B?VmlEYlVzcEQ1bUhKaXhVNHFHWVFKTkVVb1NyUHg2UldYVXBoNy9HeTZjRE4z?=
 =?utf-8?B?TkhaNm8wN29mcHJJTHpiOHlxNGpDblp6QjM5OER5THQ0NmFoSC9QYkRwdWYx?=
 =?utf-8?B?Y05EN0lnZWYvajhpOUMxZmdMT3VPSUlhSDJtbXA2TUxRamNoU3VFTW1RaUwx?=
 =?utf-8?B?OG92eDBEZUgwcEVDcnFRekhKQ1NVbEZhUTRIOVh2MFZXU2Q3T1BoaDJhOTdB?=
 =?utf-8?B?YUJSanJ3eml4NGRVcWpJRlpVczVZL2lRbXVYSDgwY0VBQ2ZLOHc4Q2pEQiti?=
 =?utf-8?B?S3psZm5qYk8yTVFPMkh3U3lWdXRiU0Fhdys4SXVjWEJKSjRFSkhZOUpxMTd1?=
 =?utf-8?B?Rlh6YSs1WnFUcTJSMlVRN0pqUjVWK0xzT3JCZGl3Z0NvdEZRRFZqTE9NbG1N?=
 =?utf-8?B?dDJPMk9ZZXl0RG5PeElueS9ZMWlkMmZrUVhUWVVrZytTYzBBYzg3SGFySWFX?=
 =?utf-8?B?NFg2TlU4ZmR1OGtxR1hBdWNoKzB6bUJ4cE11YzJvby9QODFHL0tBeXlrRTZi?=
 =?utf-8?B?MXplQXJoT1dkc2FkaklUWVhjb0krMEFWSGU0NGhMQWNJQmJlR25qRVBvZjlV?=
 =?utf-8?B?Qm03OXdFS0VOdDFEQTkwcit2REMrWVdBVE9Za1NBaDNlK1lNQlhBa3E1ek5a?=
 =?utf-8?B?SDRGOEFrb0FudVZvNDdEMWJTTGV6YzQ3dzRheEcwRmw0d2hqc0NBbUlGYVZS?=
 =?utf-8?B?MzZBd09tcDZPb1ZzWFFxTDFYVWdPbmlEQ3NHVmlET2czd0JDbjNDQmRjK1RM?=
 =?utf-8?B?MTJKcnE0c1Zqd0VZNU9qZ0R5VEg1R0VJWXRCTjltN3JlZENEQlg5MGFsMDZh?=
 =?utf-8?B?SnQzeTZrT0dvNXdISkdmYm9zWS9ZTHlGVTl4SW1PK2l5NjVvbW96QVBTTFZD?=
 =?utf-8?B?cDg3bUN1eWFRL3Jac2V4NHRoU0tkVkJ6RjZ3ek5SRHZOOU56ZHpuOXhTbm00?=
 =?utf-8?B?V2ROOGF4Y0RTMUhEeWo2RFFnekZZbGVQRWxmZGhtcWl0ZE93VmYyTnRXWitL?=
 =?utf-8?B?RURSeVY0bnZ5SWtFRmVLTFgra1EyZU1NUGI0cnFWQzJXdGExd0g4SEtxNWw0?=
 =?utf-8?Q?1W3MrYKCK/UZOzbrbxVpHmJ+S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68272bbe-ab33-4061-47cd-08dd59fec833
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:57.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj02v+nT7asGnR1LG/0ybYQvhVN7ezRI7FBcNVdblQXNfYW4nFtsDCP8mDGodcYOV8ATVk+cIUOZqXIdasd1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

Add entry for i.MX SCMI extensions and myself as maintainer

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd15d86a3ad7f832e189451a2ebdbed1e5d46c96..23cac57ee9dffcfaa729f736457359841766106d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23169,6 +23169,15 @@ F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
 
+SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
+M:	Peng Fan <peng.fan@nxp.com>
+L:	arm-scmi@vger.kernel.org
+L:	imx@lists.linux.dev
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/nxp,*scmi.yaml
+F:	drivers/firmware/arm_scmi/vendors/imx/
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org

-- 
2.37.1


