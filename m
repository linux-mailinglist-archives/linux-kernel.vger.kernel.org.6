Return-Path: <linux-kernel+bounces-173981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD138C08A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B397A1C217DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773743B185;
	Thu,  9 May 2024 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NaMOW6S6"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD8405FD;
	Thu,  9 May 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215555; cv=fail; b=RjJTwzY0USJx/NXPcbawhYtm3Z0kriRrHOCnVFJQy4zZZrbXrkx8sWbtBmmdE22tlAJ99ni5K1pA7FKqq0kktOPe/rTkQXP7bBM6Bm6wgSZN4dAG3kG8iQ7Y6n3PDOEmFijrR7K41oPufNZUAUngM3w5IaIGiUHYFiTXtBUjjnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215555; c=relaxed/simple;
	bh=9zvnpB2bk2tGbmlKkEt54oxdz7pJh24wBJ8LY9xQsGg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ocQS66KqJIwJ8nTNeoLIj9DSjml+eIQYWsUyQwf3mOEhyCZiNtMmfkoLvA3v91R6nQWJaHcK8mTiLXchnzPV7INQajVA1s5mmPZC0FlLIZe0TpWcmgE4wG15KHpiFhFBBshwHJR8T5Si+pLoU1DhtA2QOm94Zny4m2PYj4tz9iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NaMOW6S6; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndhM6BI/ccGc+RV6i/2ra6KUk8FJuyboPmGR/BmY9MwtH/ebgmQKooTrb6rW5QjD2gNJPc/zLa7Ag+jZf0RiNgQwkeOJffHmN1ttYtRKC8Vli4Q6ifhfK3NrfmUmbz6uS3FwQKtzFAwhfvIg39/9zLOciqGQrFzk9ngiJaM8oNgQHQqdf9e6FIw5J7Vn1wOWVQ13I04eNJDRWoWSk4ugto+9XkNFbuxCcMyVbJgo9nje5oMjA0qUxv0dnvQbT3b1FNV2taSYtK1qKoV4Z4IyKE43+cgvahU18IzkO9jwr9iC7iuw8UmsYzuprknGN/BgTYoEabEDMNb0TohUYCyHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy27gOVkDJ8PqhuqMBgVtfrF1vHhszeCToXAyuZLAa8=;
 b=FBbSbPSFGp4U5/DnloBvSB4e35EVggXbUDtHSHOIj8/8OXKiAW6UoZGExco8BgUDUtxNMZ1n690xtFMI+1AJXbo4DSbsgg1YFdqAhS09cE2Hrfs+kDedlMDulMxA9nzmbYRgZfmoNpF3J7Xh+N8zC2VAR0ccDkqNS/wgbFIXEkslLDdMNEl64w66tmHEttR02kaIpeBanE/XlFAbYuaPADHLf2EfvT4Od+0Tr6V7bE9NLD3QEJ4WGKVFliUoBfjuoxcSrxTGXATDxov7Mztx9KCyAfd/Cke5bO7mJm8emQ+lEUEg+TF/hN79yCw/nJlf75fvwIB7cZ906F8h0oWK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy27gOVkDJ8PqhuqMBgVtfrF1vHhszeCToXAyuZLAa8=;
 b=NaMOW6S6aq6JxLPukdkahWjBQAKCybMlQ4IQHsmECgcEORBWhR4wdkgRzxgeUShgXftfwtBBiO8ZEm/pxJD2mAznQhcoUyUFHWjE+18yon3bDRr9LAw5ntii3Zv021H43Uw+zvaWYYzB51YNn57HWvl15kBaav9n+1ogHryLhMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 00:45:40 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:45:39 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 09 May 2024 02:45:34 +0200
Subject: [PATCH 3/4] soc: imx: secvio: Add support for SNVS secvio and
 tamper via SCFW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-secvio-v1-3-90fbe2baeda2@nxp.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
In-Reply-To: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>, 
 Pankaj Gupta <pankaj.gupta@nxp.com>, frank.li@nxp.com, 
 daniel.baluta@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: f3afea78-4981-459a-6939-08dc6fc1594e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1JQbTZGMlYxdXZHbTdjbWlFTWNkRTRoWUxGQXJuRnpOSEpmazdFU2MxY25U?=
 =?utf-8?B?cEZ5MW1wak94NzZkaHVmUk9WT3pjYUljUGowS2hscGo0bDh6SkxQYTM0Lzk1?=
 =?utf-8?B?aFVxM1FaZWcybGNkT29ZUTJCczFkeXZNVVROL3paTElRYUxnb2lhUGFCRDNL?=
 =?utf-8?B?VGhQMDR6aFZEY2xQRmNRSDIwdHR2blBkK2hxSXJlclZ5cmRZbEh4cWJqL1pN?=
 =?utf-8?B?RE8rNHR6L3NmcnBQNFBIWnZSZ1djNVVCaXBwU3NEVlVvU3U5bmIyeFhIYW9a?=
 =?utf-8?B?aTh1dkt6Sld4bHI3d24rMHg3bFRDaWlsL3FhOUU1ZTFIZXRaOU1IRFBieUgz?=
 =?utf-8?B?VU9jc3JUS2x4dFVIYXRwMThqT1dwRU1GM1JvM013VnNDTWpOQURhSTlTYzYw?=
 =?utf-8?B?U1VydEozYkwwWmNZRko0cFVBV3RNUWw2enNOYkNVL1NYdGk3dGxUbHczbFkz?=
 =?utf-8?B?ZWU1dHVTN2lUS1JjYm12Uys2YjJPZVZUbWZ4S1VQa2NNaXJseFAzREhiMytH?=
 =?utf-8?B?eWUxc01ZY3RkOFFacXU4ekhvNUFqV3pETk5GUU42SDMxSmlzS1Jud1FZWGxV?=
 =?utf-8?B?SzIrSG80cmhSQ2lRSzNLbWZjWUlaVCtVWEpoZTF5MVpnZ3ZxYllFVisrV1Vi?=
 =?utf-8?B?b3BhQm1GaWpIdklGajZBTXBuamV3MEloNkR2Yk96RElYK3hmUmMxNTZOcnBN?=
 =?utf-8?B?NTR1T2RUbzdkeHRzVjR5YkRFcFhPTXZUbUdyN053aXQwS0JsMXB2a1RTZXkz?=
 =?utf-8?B?K09ZTW83bEttVEhaSXVkTUNQWlNzMGdWcEVGWjhncnBJRXhTOWdrcmdPVnRa?=
 =?utf-8?B?ei9VZlVTVUNxK04rVDd4bjNlMUFBVkRsVTRvTEFYb2diNUZmTm1JRE9LbVo1?=
 =?utf-8?B?SngyclhROEJyQzFZRGQ2SGNBSCtERTN3WUVpUTRMcm9SUEMwYTFNSlo1RmlW?=
 =?utf-8?B?NkY2ZzdIdkJyV3ROKzFsVzlzb09Ya2QraHU5d3FaaG8xRlVkbzRjY1NLbzZL?=
 =?utf-8?B?QW9qTmVFalk1dm84Tmt3eG9IZWo4T0pxUFNhamxPTGJLdURxR1ZKSjhJNHBk?=
 =?utf-8?B?dTdQd0xWS2JEWTZoVDFkanJlSDV3S0NLSURYekJ1RnVhc21sdVVKbUI4MGNi?=
 =?utf-8?B?bGxaVTZyRlQxZFlIdDVwT05LaDFaTWtGVk5Tb1crK3NqSXE1TjdUWU1FTmx0?=
 =?utf-8?B?UFpBaGdDaUZONXVXUFZPMUhrb0lXdHhSdS9pUXh1MzlCQmNLeWx2TFBHUUox?=
 =?utf-8?B?cEFramQxd0xFTnY5a0FKeVJseWNDVGV6bHlJL2Q5Ni9CMGVCNGxTQzBKSjdN?=
 =?utf-8?B?ekFzeFFaOXlKQVNkaEJyNExtY09hVkV4VWJKNElCRlJNd3hVUzNNY0RObzc5?=
 =?utf-8?B?UkNRY1IwWnZZRjhjYks1elRqdnlJbXpGSXlKc3RyMEFsYkFDanJBZ29rNGFj?=
 =?utf-8?B?bGdvZXU0RWZmNWJKWG1oNUIrUWlBaVAwUTIxMWI2NTVPTy90VFk3elFGaEwz?=
 =?utf-8?B?dnM3SVRrOHhMOGtRVFN1UGt0ZkxBeG02Ny93OHk4UFdNTkdMbW9rU3RZWGcx?=
 =?utf-8?B?Mk4yV3lYMnplbU5sTjR0RWwwdmwzVTZHbXpiUXZCYjhjc25XdlFSamdpWERy?=
 =?utf-8?B?emJtTXlxRWNiejZtYUFldUEvUjV1VFpEcGJPcWhXaXhLcWJGRkZLMGpyOGFE?=
 =?utf-8?B?MWEvaEVHV1puWUJDdEFEVmkrTXhGOFNnejRkcmQ0RTBOMGhnak1oeXZtdEsw?=
 =?utf-8?B?SWFyaVdlOTRlTkh4SkYvbk5PazNVcDIyZm1YV3VPUlUyZVpHUk1YdFFOSVFx?=
 =?utf-8?Q?wjKLj8OsxO3Om7uX9QZIYrqRBEEsv/JrjFr00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxvVjM1eE9SUE10L3E1QTRmdHBPa2JDSkhQYWRqOUhSbUEvaTNlUDlrOFp5?=
 =?utf-8?B?VEVyS2toamxDa0Eyc0FUWU5mOEJONzNjVHNoTVg2Sk9qUmVtNTd4Vno4QkMy?=
 =?utf-8?B?K1drQk03YWNKNHFEb0RETFdhdzh2ZCtPcVNFOEFLT1FvT1M3dkpiSnJMMVFQ?=
 =?utf-8?B?YmFHSW03b3J4U05XYm5zYk1SYURLeHJOMFlGZHFLNUZKZHdzK0EzMkkzOE8v?=
 =?utf-8?B?Z2JlTGxVTGdEMmVxY0xjSkdYZG1NTFFzYlVJUFQxbk1KRlNjNnFDN1ZZRzg0?=
 =?utf-8?B?OFd3eFZhLzFaZm1nQkpFWW9aUnBydk9yOEhZbjV2YmlVaExzNGRrbDRlS1Vq?=
 =?utf-8?B?ek12am50UU94VnRhb0N0MkUyaXdYMnI4cTVMS3hBVm1vdk0xaFRXQWtIUzRY?=
 =?utf-8?B?WEFJa2JSd3p6akwxR1laTUFUYStOWWl3M3dWRUt0eHFvVmpvSWdhZThocEVu?=
 =?utf-8?B?cWI2ellER05vRlNwQlFNalpDYThIZk9KRlZGVmp4SGcxb1FXUWxXNkZnWDFp?=
 =?utf-8?B?bWVZOXl3dUVBQUc5QnYwNko4QzcrZWd1YXU2YVlJZjZCOVZIUWVHTnFtMXd6?=
 =?utf-8?B?cXE5NCt1R3d1Z2dmQVZHQ3F5a2VzdTJhTXB2M0pNb0hZOEw0dkNOY0xBZFlO?=
 =?utf-8?B?OEwxN3JJU2RWYmVWaDlmK0lrT1ZQWk1iZTdqRDcrcitrU2t2REdyYmpsL1hR?=
 =?utf-8?B?SzBWNGtlUGUyVC9QWGgyZTNzbGQyY2YrcmhuU0FVWXpDOXNuMjFieUYrZHB3?=
 =?utf-8?B?emNsVnBjelBzbzNHUTN0QUU1RHVVcVo1c2JYMjR2SXZNQTQ1b1RNODJvMGpZ?=
 =?utf-8?B?cDJSMExsKzZ4M09wdll2MVZPNWFPNHU4RVB1bzltRnRWeEVWRHpCVll5d1FG?=
 =?utf-8?B?SnV0ZXRZTlAxK0Y1MzRuYkxKWHZkcEs5RHJKZEVxZEdOTnE2WlEyNVpkWkxp?=
 =?utf-8?B?T2xmMTQwTHdWSEJEWkNRcHIyT1hqRGFMaGtIdG5sV01yei9yTkNSc2p3SWdt?=
 =?utf-8?B?SWVEQzc4ZDRDaVRHYTBqSWdlRGpTWk90VkFpd3ZFSWZkaWdXSjQ3a21rMEw5?=
 =?utf-8?B?WHZNQXNhVkE3U1Z0QW9lMjA0ZENhK0VZUVJPdjAxeW1UbC90clErZlpHd0wy?=
 =?utf-8?B?N0Frc3VsTStyZEhxbEV1U2hoZDB6d2YyRlFnS1dEUkY3WU5rVCt1WkJQM0Ux?=
 =?utf-8?B?R012RlhYZWs0OTFLK2UvQkVIVFV3YWlVWjl0Q01DcUtXeUVOS1FVbEtGVEgz?=
 =?utf-8?B?U1RSUmNHSWRLVjdZMzhwQmp5bXl2eHF1dW5TMUN5RzVhVUIra0FnWlU3VHF1?=
 =?utf-8?B?SlpUL01idk9zdjd4dkx5QnVPWTZIMWVoSUtiZ2tFL2dBTURjcVl3WDQ2VlJx?=
 =?utf-8?B?bVdVM0VyUDdEeXBIdVlBeXNTZmduNjJyQkpFRWQzMzJLTm16eTRncTZEK2dK?=
 =?utf-8?B?dkRjSG1rSGlrUVJ4SnNpQzdTWkxPcWNDNjVEV0VvWHAwTFVMMU9SVEREN1dW?=
 =?utf-8?B?ZjJEWmMwTkhXTXdnMGFFMm1lUjJXZXZCd3Y3akdHeHFFT294OWJhVHcwRDdX?=
 =?utf-8?B?VXlHamhYU1RjbUNIOXdBODF3MU1NaFM1NE5JT09peUkzSks3cHNpaEZQMjJy?=
 =?utf-8?B?NUVDRzcrQzBhZ3krQVloUTRkUmpITWJLZXdVRVd6UGxIakkxaUJ4ZnFoQ05T?=
 =?utf-8?B?bkQxS0pieC81bFpROE50Wjk3RVg5RzFGK3ViNjlCUHNsN0dZMGJ2eEtKWlc3?=
 =?utf-8?B?NWhyTmp0RDhvbzRRWjBSZXpGdnp5d3Njd2x3ZFVoU002aWtYMFprQ0NRQVMv?=
 =?utf-8?B?b2d6WWc0b1N2enIyT0piaW5rQkxmUUgya1JMa1VST1dVSzhMM3QvQ0U3UmJF?=
 =?utf-8?B?cGhjMEI1SkUwdTJNdGRSNWZ1ZUR2YWNBZk8yOE05T2VFZzJQZU1jRm91aG9l?=
 =?utf-8?B?ZmNOWFgrRGpFMnRmRGhkYTh0aTd2Q0lOcVZOUWN0N1M0cURRcmlrZyt2eDBV?=
 =?utf-8?B?SFlVUFZpSFdvclhIVGk0S0cxWk51cFppWlhjT0hUdWkwTU9ES1ZPRlFpKzBo?=
 =?utf-8?B?RWlGclZpYWRDNmNZWUx1MDdhTFVoZmtoTDh3Qmp5Z1NpcnJnSloybk1VV2Zv?=
 =?utf-8?Q?+QN53nbEKYVk5VLdIDaXSz3BW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3afea78-4981-459a-6939-08dc6fc1594e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:45:39.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLhTKqCPq2Yws3xAva8qM2tmJWlTKBWwLvCgJBz+Fx4BjNHxXL3wJs4+kuPGZXPRfa3Cx/78pwxuPH08ARmDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

The i.MX8QXP SoC contains the Secure Non-Volatile Storage (SNVS)
block. This block can detect specific hardware attacks.This block
can only be accessible using the SCFW API.

This module interact with the SCU which relay request to/from the
SNVS block to detect if security violation occurred.

The driver register an IRQ handle to SCU for security violation
interrupt.

When an interruption is fired, the driver inform the user.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/soc/imx/Kconfig                     |  11 +
 drivers/soc/imx/Makefile                    |   1 +
 drivers/soc/imx/secvio/Makefile             |   2 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c | 274 +++++++++++++
 drivers/soc/imx/secvio/imx-secvio-sc.c      | 595 ++++++++++++++++++++++++++++
 include/soc/imx/imx-secvio-sc.h             | 216 ++++++++++
 6 files changed, 1099 insertions(+)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2a90ddd20104..3d2715a8b798 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,15 @@ config SOC_IMX9
 	help
 	  If you say yes here, you get support for the NXP i.MX9 family
 
+config SECVIO_SC
+	tristate "NXP SC secvio support"
+	depends on IMX_SCU
+	default y
+	help
+	   If you say yes here you get support for the NXP SNVS security
+	   violation module. It includes the possibility to read information
+	   related to security violations and tampers. It also gives the
+	   possibility to register user callbacks when a security violation
+	   occurs.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 3ad321ca608a..bda0259077be 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX9) += imx93-src.o
+obj-${CONFIG_SECVIO_SC} += secvio/
diff --git a/drivers/soc/imx/secvio/Makefile b/drivers/soc/imx/secvio/Makefile
new file mode 100644
index 000000000000..55ef1c044009
--- /dev/null
+++ b/drivers/soc/imx/secvio/Makefile
@@ -0,0 +1,2 @@
+obj-y +=  imx-secvio-sc.o
+obj-$(CONFIG_DEBUG_FS) += imx-secvio-debugfs.o
diff --git a/drivers/soc/imx/secvio/imx-secvio-debugfs.c b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
new file mode 100644
index 000000000000..8dd0cd4361b9
--- /dev/null
+++ b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019, 2024 NXP
+ */
+
+/*
+ * The module exposes below files in debugfs:
+ *  - secvio/info:
+ *      * Read: It returns the value of the fuses and SNVS registers which are
+ *              readable and related to secvio and tampers.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/nvmem-consumer.h>
+
+#include <linux/firmware/imx/svc/misc.h>
+#include <linux/firmware/imx/svc/seco.h>
+
+#include <soc/imx/imx-secvio-sc.h>
+
+static int fuse_reader(struct device *dev, u32 id, u32 *value, u8 mul)
+{
+	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
+	u32 size_to_read = mul * sizeof(u32);
+	int ret;
+
+	ret = nvmem_device_read(data->nvmem, id, size_to_read, value);
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to read fuse %d: %d\n", id, ret);
+		return ret;
+	}
+
+	if (ret != size_to_read) {
+		dev_err(data->dev, "Read only %d instead of %d\n", ret,
+			size_to_read);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int snvs_reader(struct device *dev, u32 id, u32 *value, u8 mul)
+{
+	int ret;
+	u32 *v1, *v2, *v3, *v4, *v5;
+	struct imx_secvio_sc_data *data;
+
+	data = dev_get_drvdata(dev);
+	v1 = NULL;
+	v2 = NULL;
+	v3 = NULL;
+	v4 = NULL;
+	v5 = NULL;
+
+	switch (mul) {
+	case 5:
+		v5 = &value[4];
+		fallthrough;
+	case 4:
+		v4 = &value[3];
+		fallthrough;
+	case 3:
+		v3 = &value[2];
+		fallthrough;
+	case 2:
+		v2 = &value[1];
+		fallthrough;
+	case 1:
+		v1 = &value[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, id, SECVIO_CONFIG_READ,
+					v1, v2, v3, v4, v5, mul);
+	if (ret < 0)
+		dev_err(dev, "Failed to read snvs reg %d: %d\n", id, ret);
+
+	return ret;
+}
+
+static int snvs_dgo_reader(struct device *dev, u32 id, u32 *value, u8 mul)
+{
+	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	if (mul != 1)
+		return -EINVAL;
+
+	ret = imx_sc_seco_secvio_dgo_config(data->ipc_handle, id,
+					    SECVIO_CONFIG_READ, value);
+	if (ret)
+		dev_err(dev, "Failed to read snvs dgo reg %d: %d\n", id, ret);
+
+	return ret;
+}
+
+static const struct imx_secvio_info_entry {
+	int (*reader)(struct device *dev, u32 id, u32 *value, u8 mul);
+	const char *type;
+	const char *name;
+	u32 id;
+	u8 mul;
+} gs_imx_secvio_info_list[] = {
+	{fuse_reader, "fuse", "trim", 30, 1},
+	{fuse_reader, "fuse", "trim2", 31, 1},
+	{fuse_reader, "fuse", "ctrim1", 260, 1},
+	{fuse_reader, "fuse", "ctrim2", 261, 1},
+	{fuse_reader, "fuse", "ctrim3", 262, 1},
+	{fuse_reader, "fuse", "ctrim4", 263, 1},
+	{fuse_reader, "fuse", "OSC_CAP", 768, 1},
+
+	{snvs_reader, "snvs", "HPLR",    0x0, 1},
+	{snvs_reader, "snvs", "LPLR",    0x34, 1},
+	{snvs_reader, "snvs", "HPSICR",  0xc, 1},
+	{snvs_reader, "snvs", "HPSVCR",  0x10, 1},
+	{snvs_reader, "snvs", "HPSVS",   0x18, 1},
+	{snvs_reader, "snvs", "LPSVC",   0x40, 1},
+	{snvs_reader, "snvs", "LPTDC",   0x48, 2},
+	{snvs_reader, "snvs", "LPSR",    0x4c, 1},
+	{snvs_reader, "snvs", "LPTDS",   0xa4, 1},
+	{snvs_reader, "snvs", "LPTGFC",  0x44, 3},
+	{snvs_reader, "snvs", "LPATCTL", 0xe0, 1},
+	{snvs_reader, "snvs", "LPATCLK", 0xe4, 1},
+	{snvs_reader, "snvs", "LPATRC1", 0xe8, 2},
+	{snvs_reader, "snvs", "LPMKC",   0x3c, 1},
+	{snvs_reader, "snvs", "LPSMC",   0x5c, 2},
+	{snvs_reader, "snvs", "LPPGD",   0x64, 1},
+	{snvs_reader, "snvs", "HPVID",   0xf8, 2},
+
+	{snvs_dgo_reader, "dgo", "Offset",  0x0, 1},
+	{snvs_dgo_reader, "dgo", "PUP/PD",  0x10, 1},
+	{snvs_dgo_reader, "dgo", "Anatest", 0x20, 1},
+	{snvs_dgo_reader, "dgo", "T trim",  0x30, 1},
+	{snvs_dgo_reader, "dgo", "Misc",    0x40, 1},
+	{snvs_dgo_reader, "dgo", "Vmon",    0x50, 1},
+};
+
+struct imx_secvio_sc_info_seq_data {
+	struct device *dev;
+	const struct imx_secvio_info_entry *list;
+	int size;
+};
+
+static void *imx_secvio_sc_info_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct imx_secvio_sc_info_seq_data *data = m->private;
+
+	/* Check we are not out of bound */
+	if (*pos >= data->size)
+		return NULL;
+
+	return (void *)pos;
+}
+
+static void *imx_secvio_sc_info_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	/* Increment the counter */
+	++*pos;
+
+	/* call the start function which will check the index */
+	return imx_secvio_sc_info_seq_start(m, pos);
+}
+
+static void imx_secvio_sc_info_seq_stop(struct seq_file *m, void *v)
+{
+}
+
+static int imx_secvio_sc_info_seq_show(struct seq_file *m, void *v)
+{
+	struct imx_secvio_sc_info_seq_data *data = m->private;
+	const struct imx_secvio_info_entry *e;
+	int ret;
+	u32 vals[5];
+	int idx;
+
+	idx = *(loff_t *)v;
+	e = &data->list[idx];
+
+	/* Read the values */
+	ret = e->reader(data->dev, e->id, (u32 *)&vals, e->mul);
+	if (ret) {
+		dev_err(data->dev, "Fail to read %s %s (idx %d)\n", e->type,
+			e->name, e->id);
+		return 0;
+	}
+
+	seq_printf(m, "%5s/%-10s(%.3d):", e->type, e->name, e->id);
+
+	/* Loop over the values */
+	for (idx = 0; idx < e->mul; idx++)
+		seq_printf(m, " %.8x", vals[idx]);
+
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations imx_secvio_sc_info_seq_ops = {
+	.start = imx_secvio_sc_info_seq_start,
+	.next  = imx_secvio_sc_info_seq_next,
+	.stop  = imx_secvio_sc_info_seq_stop,
+	.show  = imx_secvio_sc_info_seq_show,
+};
+
+static int imx_secvio_sc_info_open(struct inode *inode, struct file *file)
+{
+	struct imx_secvio_sc_info_seq_data *data;
+
+	data = __seq_open_private(file, &imx_secvio_sc_info_seq_ops, sizeof(*data));
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = inode->i_private;
+	data->list = gs_imx_secvio_info_list;
+	data->size = ARRAY_SIZE(gs_imx_secvio_info_list);
+
+	return 0;
+}
+
+static const struct file_operations imx_secvio_sc_info_ops = {
+	.owner = THIS_MODULE,
+	.open = imx_secvio_sc_info_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
+static void if_debugfs_remove_recursive(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
+int imx_secvio_sc_debugfs(struct device *dev)
+{
+	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
+	struct dentry *dir;
+	int ret = 0;
+
+	/* Create a folder */
+	dir = debugfs_create_dir(dev_name(dev), NULL);
+	if (IS_ERR(dir)) {
+		dev_err(dev, "Failed to create dfs dir\n");
+		ret = PTR_ERR(dir);
+		goto exit;
+	}
+	data->dfs = dir;
+
+	ret = devm_add_action(dev, if_debugfs_remove_recursive, data->dfs);
+	if (ret) {
+		dev_err(dev, "Failed to add managed action to disable IRQ\n");
+		goto remove_fs;
+	}
+
+	/* Create the file to read info and write to reg */
+	dir = debugfs_create_file("info", 0x666, data->dfs, dev,
+				  &imx_secvio_sc_info_ops);
+	if (IS_ERR(dir)) {
+		dev_err(dev, "Failed to add info to debugfs\n");
+		ret = PTR_ERR(dir);
+		goto exit;
+	}
+
+exit:
+	return ret;
+
+remove_fs:
+	debugfs_remove_recursive(data->dfs);
+	goto exit;
+}
diff --git a/drivers/soc/imx/secvio/imx-secvio-sc.c b/drivers/soc/imx/secvio/imx-secvio-sc.c
new file mode 100644
index 000000000000..a4e96c730a23
--- /dev/null
+++ b/drivers/soc/imx/secvio/imx-secvio-sc.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019, 2024 NXP
+ *
+ */
+
+/*
+ * The i.MX8QXP SoC contains the Secure Non-Volatile Storage (SNVS) block. This
+ * block can detect specific hardware attacks.This block can only be accessible
+ * using the SCFW API.
+ *
+ * This module interact with the SCU which relay request to/from the SNVS block
+ * to detect if security violation occurred.
+ *
+ * The module exports an API to add processing when a SV is detected:
+ *  - register_imx_secvio_sc_notifier
+ *  - unregister_imx_secvio_sc_notifier
+ *  - imx_secvio_sc_check_state
+ *  - imx_secvio_sc_clear_state
+ *  - imx_secvio_sc_enable_irq
+ *  - imx_secvio_sc_disable_irq
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/seco.h>
+#include <linux/firmware/imx/svc/rm.h>
+#include <soc/imx/imx-secvio-sc.h>
+
+/* Reference on the driver_device */
+static struct device *imx_secvio_sc_dev;
+
+/* Register IDs for sc_seco_secvio_config API */
+#define HPSVS_ID 0x18
+#define LPS_ID 0x4c
+#define LPTDS_ID 0xa4
+#define HPVIDR_ID 0xf8
+
+#define SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER 0x53
+#define SECO_VERSION_MINOR_MASK GENMASK(15, 0)
+
+/* Notifier list for new CB */
+static BLOCKING_NOTIFIER_HEAD(imx_secvio_sc_notifier_chain);
+
+int register_imx_secvio_sc_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&imx_secvio_sc_notifier_chain,
+						nb);
+}
+EXPORT_SYMBOL(register_imx_secvio_sc_notifier);
+
+int unregister_imx_secvio_sc_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&imx_secvio_sc_notifier_chain,
+						  nb);
+}
+EXPORT_SYMBOL(unregister_imx_secvio_sc_notifier);
+
+static void if_imx_scu_irq_register_notifier(void *nb)
+{
+	imx_scu_irq_register_notifier(nb);
+}
+
+static void if_unregister_imx_secvio_sc_notifier(void *nb)
+{
+	unregister_imx_secvio_sc_notifier(nb);
+}
+
+static
+int imx_secvio_sc_notifier_call_chain(struct secvio_sc_notifier_info *info)
+{
+	return blocking_notifier_call_chain(&imx_secvio_sc_notifier_chain, 0,
+					    (void *)info);
+}
+
+int imx_secvio_sc_get_state(struct device *dev,
+			    struct secvio_sc_notifier_info *info)
+{
+	int ret, err = 0;
+	struct imx_secvio_sc_data *data;
+
+	dev = imx_secvio_sc_dev;
+	if (!dev)
+		return -EINVAL;
+
+	data = dev_get_drvdata(dev);
+
+	/* Read secvio status */
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, HPSVS_ID, SECVIO_CONFIG_READ,
+					&info->hpsvs, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		err = ret;
+		dev_err(dev, "Fail read secvio config status %d\n", ret);
+	}
+	info->hpsvs &= HPSVS_ALL_SV_MASK;
+
+	/* Read tampers status */
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPS_ID, SECVIO_CONFIG_READ,
+					&info->lps, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		err = ret;
+		dev_err(dev, "Fail read tamper 1 status: %d\n", ret);
+	}
+	info->lps &= LPS_ALL_TP_MASK;
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPTDS_ID, SECVIO_CONFIG_READ,
+					&info->lptds, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		err = ret;
+		dev_err(dev, "Fail read  tamper 2 status: %d\n", ret);
+	}
+	info->lptds &= LPTDS_ALL_TP_MASK;
+
+	dev_dbg(dev, "Status: %.8x, %.8x, %.8x\n", info->hpsvs,
+		info->lps, info->lptds);
+
+	return err;
+}
+EXPORT_SYMBOL(imx_secvio_sc_get_state);
+
+int imx_secvio_sc_check_state(struct device *dev)
+{
+	struct secvio_sc_notifier_info info;
+	int ret;
+
+	dev = imx_secvio_sc_dev;
+
+	ret = imx_secvio_sc_get_state(dev, &info);
+	if (ret) {
+		dev_err(dev, "Failed to get secvio state\n");
+		return ret;
+	}
+
+	/* Call chain of CB registered to this module if status detected */
+	if (info.hpsvs || info.lps || info.lptds)
+		if (imx_secvio_sc_notifier_call_chain(&info))
+			dev_warn(dev,
+				 "Issues when calling the notifier chain\n");
+
+	return ret;
+}
+EXPORT_SYMBOL(imx_secvio_sc_check_state);
+
+static int imx_secvio_sc_disable_irq(struct device *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	/* Disable the IRQ */
+	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
+				       false);
+	if (ret) {
+		dev_err(dev, "Cannot disable SCU IRQ: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int imx_secvio_sc_enable_irq(struct device *dev)
+{
+	int ret = 0, err;
+	u32 irq_status;
+	struct imx_secvio_sc_data *data;
+
+	if (!dev)
+		return -EINVAL;
+
+	data = dev_get_drvdata(dev);
+
+	/* Enable the IRQ */
+	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
+				       true);
+	if (ret) {
+		dev_err(dev, "Cannot enable SCU IRQ: %d\n", ret);
+		goto exit;
+	}
+
+	/* Enable interrupt */
+	ret = imx_sc_seco_secvio_enable(data->ipc_handle);
+	if (ret) {
+		dev_err(dev, "Cannot enable SNVS irq: %d\n", ret);
+		goto exit;
+	}
+
+	/* Unmask interrupt */
+	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
+	if (ret) {
+		dev_err(dev, "Cannot unmask irq: %d\n", ret);
+		goto exit;
+	}
+
+exit:
+	if (ret) {
+		err = imx_secvio_sc_disable_irq(dev);
+		if (err)
+			dev_warn(dev, "Failed to disable the IRQ\n");
+	}
+
+	return ret;
+}
+
+static int imx_secvio_sc_notify(struct notifier_block *nb,
+				unsigned long event, void *group)
+{
+	struct imx_secvio_sc_data *data =
+				container_of(nb, struct imx_secvio_sc_data,
+					     irq_nb);
+	struct device *dev = data->dev;
+	int ret;
+
+	/* Filter event for us */
+	if (!((event & IMX_SC_IRQ_SECVIO) &&
+	      (*(u8 *)group == IMX_SC_IRQ_GROUP_WAKE)))
+		return 0;
+
+	dev_warn(dev, "secvio security violation detected\n");
+
+	ret = imx_secvio_sc_check_state(dev);
+
+	/* Re-enable interrupt */
+	ret = imx_secvio_sc_enable_irq(dev);
+	if (ret)
+		dev_err(dev, "Failed to enable IRQ\n");
+
+	return ret;
+}
+
+int imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, u32 lps, u32 lptds)
+{
+	int ret;
+	struct imx_secvio_sc_data *data;
+
+	dev = imx_secvio_sc_dev;
+	if (!dev)
+		return -EINVAL;
+
+	data = dev_get_drvdata(dev);
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, HPSVS_ID, SECVIO_CONFIG_WRITE,
+					&hpsvs, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		dev_err(dev, "Fail to clear secvio status: %d\n", ret);
+		return ret;
+	}
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPS_ID, SECVIO_CONFIG_WRITE,
+					&lps, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		dev_err(dev, "Fail to clear tamper 1 status: %d\n", ret);
+		return ret;
+	}
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPTDS_ID, SECVIO_CONFIG_WRITE,
+					&lptds, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		dev_err(dev, "Fail to clear tamper 2 status: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(imx_secvio_sc_clear_state);
+
+static int report_to_user_notify(struct notifier_block *nb,
+				 unsigned long status, void *notif_info)
+{
+	struct secvio_sc_notifier_info *info = notif_info;
+	struct imx_secvio_sc_data *data =
+				container_of(nb, struct imx_secvio_sc_data,
+					     report_nb);
+	struct device *dev = data->dev;
+
+	/* Information about the security violation */
+	if (info->hpsvs & HPSVS_LP_SEC_VIO_MASK)
+		dev_info(dev, "SNVS secvio: LPSV\n");
+	if (info->hpsvs & HPSVS_SW_LPSV_MASK)
+		dev_info(dev, "SNVS secvio: SW LPSV\n");
+	if (info->hpsvs & HPSVS_SW_FSV_MASK)
+		dev_info(dev, "SNVS secvio: SW FSV\n");
+	if (info->hpsvs & HPSVS_SW_SV_MASK)
+		dev_info(dev, "SNVS secvio: SW SV\n");
+	if (info->hpsvs & HPSVS_SV5_MASK)
+		dev_info(dev, "SNVS secvio: SV 5\n");
+	if (info->hpsvs & HPSVS_SV4_MASK)
+		dev_info(dev, "SNVS secvio: SV 4\n");
+	if (info->hpsvs & HPSVS_SV3_MASK)
+		dev_info(dev, "SNVS secvio: SV 3\n");
+	if (info->hpsvs & HPSVS_SV2_MASK)
+		dev_info(dev, "SNVS secvio: SV 2\n");
+	if (info->hpsvs & HPSVS_SV1_MASK)
+		dev_info(dev, "SNVS secvio: SV 1\n");
+	if (info->hpsvs & HPSVS_SV0_MASK)
+		dev_info(dev, "SNVS secvio: SV 0\n");
+
+	/* Information about the tampers */
+	if (info->lps & LPS_ESVD_MASK)
+		dev_info(dev, "SNVS tamper: External SV\n");
+	if (info->lps & LPS_ET2D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 2\n");
+	if (info->lps & LPS_ET1D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 1\n");
+	if (info->lps & LPS_WMT2D_MASK)
+		dev_info(dev, "SNVS tamper: Wire Mesh 2\n");
+	if (info->lps & LPS_WMT1D_MASK)
+		dev_info(dev, "SNVS tamper: Wire Mesh 1\n");
+	if (info->lps & LPS_VTD_MASK)
+		dev_info(dev, "SNVS tamper: Voltage\n");
+	if (info->lps & LPS_TTD_MASK)
+		dev_info(dev, "SNVS tamper: Temperature\n");
+	if (info->lps & LPS_CTD_MASK)
+		dev_info(dev, "SNVS tamper: Clock\n");
+	if (info->lps & LPS_PGD_MASK)
+		dev_info(dev, "SNVS tamper: Power Glitch\n");
+	if (info->lps & LPS_MCR_MASK)
+		dev_info(dev, "SNVS tamper: Monotonic Counter rollover\n");
+	if (info->lps & LPS_SRTCR_MASK)
+		dev_info(dev, "SNVS tamper: Secure RTC rollover\n");
+	if (info->lps & LPS_LPTA_MASK)
+		dev_info(dev, "SNVS tamper: Time alarm\n");
+
+	if (info->lptds & LPTDS_ET10D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 10\n");
+	if (info->lptds & LPTDS_ET9D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 9\n");
+	if (info->lptds & LPTDS_ET8D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 8\n");
+	if (info->lptds & LPTDS_ET7D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 7\n");
+	if (info->lptds & LPTDS_ET6D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 6\n");
+	if (info->lptds & LPTDS_ET5D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 5\n");
+	if (info->lptds & LPTDS_ET4D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 4\n");
+	if (info->lptds & LPTDS_ET3D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 3\n");
+
+	return 0;
+}
+
+static void if_imx_secvio_sc_disable_irq(void *dev)
+{
+	imx_secvio_sc_disable_irq(dev);
+}
+
+static int imx_secvio_sc_open(struct inode *node, struct file *filp)
+{
+	filp->private_data = node->i_private;
+
+	return 0;
+}
+
+static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct device *dev = file->private_data;
+	struct secvio_sc_notifier_info info;
+	int ret;
+
+	switch (cmd) {
+	case IMX_SECVIO_SC_GET_STATE:
+		ret = imx_secvio_sc_get_state(dev, &info);
+		if (ret)
+			return ret;
+
+		ret = copy_to_user((void *)arg, &info, sizeof(info));
+		if (ret) {
+			dev_err(dev, "Fail to copy info to user\n");
+			return -EFAULT;
+		}
+		break;
+	case IMX_SECVIO_SC_CHECK_STATE:
+		ret = imx_secvio_sc_check_state(dev);
+		if (ret)
+			return ret;
+		break;
+	case IMX_SECVIO_SC_CLEAR_STATE:
+		ret = copy_from_user(&info, (void *)arg, sizeof(info));
+		if (ret) {
+			dev_err(dev, "Fail to copy info from user\n");
+			return -EFAULT;
+		}
+
+		ret = imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
+						    info.lptds);
+		if (ret)
+			return ret;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+	}
+
+	return ret;
+}
+
+static const struct file_operations imx_secvio_sc_fops = {
+	.owner = THIS_MODULE,
+	.open = imx_secvio_sc_open,
+	.unlocked_ioctl = imx_secvio_sc_ioctl,
+};
+
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int imx_secvio_sc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_secvio_sc_data *data;
+	u32 seco_version = 0;
+	bool own_secvio;
+	u32 irq_status;
+	int ret;
+
+	/* Allocate private data */
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	data->dev = dev;
+
+	dev_set_drvdata(dev, data);
+
+	data->nvmem = devm_nvmem_device_get(dev, NULL);
+	if (IS_ERR(data->nvmem)) {
+		ret = PTR_ERR(data->nvmem);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err_probe(dev, ret, "Failed to retrieve nvmem\n");
+
+		goto clean;
+	}
+
+	/* Get a handle */
+	ret = imx_scu_get_handle(&data->ipc_handle);
+	if (ret) {
+		dev_err(dev, "cannot get handle to scu: %d\n", ret);
+		goto clean;
+	}
+
+	/* Check the version of the SECO */
+	ret = imx_sc_seco_build_info(data->ipc_handle, &seco_version, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to get seco version\n");
+		goto clean;
+	}
+
+	if ((seco_version & SECO_VERSION_MINOR_MASK) <
+	     SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER) {
+		dev_err(dev, "SECO version %.8x doesn't support all secvio\n",
+			seco_version);
+		ret = -EOPNOTSUPP;
+		goto clean;
+	}
+
+	/* Init debug FS */
+	ret = imx_secvio_sc_debugfs(dev);
+	if (ret) {
+		dev_err(dev, "Failed to set debugfs\n");
+		goto clean;
+	}
+
+	/* Check we own the SECVIO */
+	ret = imx_sc_rm_is_resource_owned(data->ipc_handle, IMX_SC_R_SECVIO);
+	if (ret < 0) {
+		dev_err(dev, "Failed to retrieve secvio ownership\n");
+		goto clean;
+	}
+
+	own_secvio = ret > 0;
+	if (!own_secvio) {
+		dev_err(dev, "Secvio resource is not owned\n");
+		ret = -EPERM;
+		goto clean;
+	}
+
+	/* Check IRQ exists and enable it */
+	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
+	if (ret) {
+		dev_err(dev, "Cannot get IRQ state: %d\n", ret);
+		goto clean;
+	}
+
+	ret = imx_secvio_sc_enable_irq(dev);
+	if (ret) {
+		dev_err(dev, "Failed to enable IRQ\n");
+		goto clean;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_imx_secvio_sc_disable_irq, dev);
+	if (ret) {
+		dev_err(dev, "Failed to add managed action to disable IRQ\n");
+		goto clean;
+	}
+
+	/* Register the notifier for IRQ from SNVS */
+	data->irq_nb.notifier_call = imx_secvio_sc_notify;
+	ret = imx_scu_irq_register_notifier(&data->irq_nb);
+	if (ret) {
+		dev_err(dev, "Failed to register IRQ notification handler\n");
+		goto clean;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_imx_scu_irq_register_notifier,
+				       &data->irq_nb);
+	if (ret) {
+		dev_err(dev, "Failed to add action to remove irq notif\n");
+		goto clean;
+	}
+
+	/* Register the notification for reporting to user */
+	data->report_nb.notifier_call = report_to_user_notify;
+	ret = register_imx_secvio_sc_notifier(&data->report_nb);
+	if (ret) {
+		dev_err(dev, "Failed to register report notif handler\n");
+		goto clean;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_unregister_imx_secvio_sc_notifier,
+				       &data->report_nb);
+	if (ret) {
+		dev_err(dev, "Failed to add action to remove report notif\n");
+		goto clean;
+	}
+
+	/* Register misc device for IOCTL */
+	data->miscdev.name = devm_kstrdup(dev, "secvio-sc", GFP_KERNEL);
+	data->miscdev.minor = MISC_DYNAMIC_MINOR;
+	data->miscdev.fops = &imx_secvio_sc_fops;
+	data->miscdev.parent = dev;
+	ret = misc_register(&data->miscdev);
+	if (ret) {
+		dev_err(dev, "failed to register misc device\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_misc_deregister, &data->miscdev);
+	if (ret) {
+		dev_err(dev, "Failed to add action to unregister miscdev\n");
+		goto clean;
+	}
+
+	imx_secvio_sc_dev = dev;
+
+	/* Process current state of the secvio and tampers */
+	imx_secvio_sc_check_state(dev);
+
+	devres_remove_group(dev, NULL);
+
+	return ret;
+
+clean:
+	devres_release_group(dev, NULL);
+
+	return ret;
+}
+
+static const struct of_device_id imx_secvio_sc_dt_ids[] = {
+	{ .compatible = "fsl,imx-sc-secvio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_secvio_sc_dt_ids);
+
+static struct platform_driver imx_secvio_sc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name	= "imx-secvio-sc",
+		.of_match_table = imx_secvio_sc_dt_ids,
+	},
+	.probe		= imx_secvio_sc_probe,
+};
+module_platform_driver(imx_secvio_sc_driver);
+
+MODULE_AUTHOR("Franck LENORMAND <franck.lenormand@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX driver to handle SNVS secvio irq sent by SCFW");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/imx/imx-secvio-sc.h b/include/soc/imx/imx-secvio-sc.h
new file mode 100644
index 000000000000..d8c9208217fe
--- /dev/null
+++ b/include/soc/imx/imx-secvio-sc.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2019, 2024 NXP
+ */
+
+#ifndef _MISC_IMX_SECVIO_SC_H_
+#define _MISC_IMX_SECVIO_SC_H_
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/notifier.h>
+
+/* Bitmask of the security violation status bit in the HPSVS register */
+#define HPSVS_LP_SEC_VIO_MASK BIT(31)
+#define HPSVS_SW_LPSV_MASK    BIT(15)
+#define HPSVS_SW_FSV_MASK     BIT(14)
+#define HPSVS_SW_SV_MASK      BIT(13)
+#define HPSVS_SV5_MASK        BIT(5)
+#define HPSVS_SV4_MASK        BIT(4)
+#define HPSVS_SV3_MASK        BIT(3)
+#define HPSVS_SV2_MASK        BIT(2)
+#define HPSVS_SV1_MASK        BIT(1)
+#define HPSVS_SV0_MASK        BIT(0)
+
+/* Bitmask of all security violation status bit in the HPSVS register */
+#define HPSVS_ALL_SV_MASK (HPSVS_LP_SEC_VIO_MASK | \
+			     HPSVS_SW_LPSV_MASK | \
+			     HPSVS_SW_FSV_MASK | \
+			     HPSVS_SW_SV_MASK | \
+			     HPSVS_SV5_MASK | \
+			     HPSVS_SV4_MASK | \
+			     HPSVS_SV3_MASK | \
+			     HPSVS_SV2_MASK | \
+			     HPSVS_SV1_MASK | \
+			     HPSVS_SV0_MASK)
+
+/*
+ * Bitmask of the security violation and tampers status bit in the LPS register
+ */
+#define LPS_ESVD_MASK  BIT(16)
+#define LPS_ET2D_MASK  BIT(10)
+#define LPS_ET1D_MASK  BIT(9)
+#define LPS_WMT2D_MASK BIT(8)
+#define LPS_WMT1D_MASK BIT(7)
+#define LPS_VTD_MASK   BIT(6)
+#define LPS_TTD_MASK   BIT(5)
+#define LPS_CTD_MASK   BIT(4)
+#define LPS_PGD_MASK   BIT(3)
+#define LPS_MCR_MASK   BIT(2)
+#define LPS_SRTCR_MASK BIT(1)
+#define LPS_LPTA_MASK  BIT(0)
+
+/*
+ * Bitmask of all security violation and tampers status bit in the LPS register
+ */
+#define LPS_ALL_TP_MASK (LPS_ESVD_MASK | \
+			   LPS_ET2D_MASK | \
+			   LPS_ET1D_MASK | \
+			   LPS_WMT2D_MASK | \
+			   LPS_WMT1D_MASK | \
+			   LPS_VTD_MASK | \
+			   LPS_TTD_MASK | \
+			   LPS_CTD_MASK | \
+			   LPS_PGD_MASK | \
+			   LPS_MCR_MASK | \
+			   LPS_SRTCR_MASK | \
+			   LPS_LPTA_MASK)
+
+/*
+ * Bitmask of the security violation and tampers status bit in the LPTDS
+ * register
+ */
+#define LPTDS_ET10D_MASK  BIT(7)
+#define LPTDS_ET9D_MASK   BIT(6)
+#define LPTDS_ET8D_MASK   BIT(5)
+#define LPTDS_ET7D_MASK   BIT(4)
+#define LPTDS_ET6D_MASK   BIT(3)
+#define LPTDS_ET5D_MASK   BIT(2)
+#define LPTDS_ET4D_MASK   BIT(1)
+#define LPTDS_ET3D_MASK   BIT(0)
+
+/*
+ * Bitmask of all security violation and tampers status bit in the LPTDS
+ * register
+ */
+#define LPTDS_ALL_TP_MASK (LPTDS_ET10D_MASK | \
+			     LPTDS_ET9D_MASK | \
+			     LPTDS_ET8D_MASK | \
+			     LPTDS_ET7D_MASK | \
+			     LPTDS_ET6D_MASK | \
+			     LPTDS_ET5D_MASK | \
+			     LPTDS_ET4D_MASK | \
+			     LPTDS_ET3D_MASK)
+
+/* Access for sc_seco_secvio_config API */
+#define SECVIO_CONFIG_READ  0
+#define SECVIO_CONFIG_WRITE 1
+
+/* Internal Structure */
+struct imx_secvio_sc_data {
+	struct device *dev;
+
+	struct imx_sc_ipc *ipc_handle;
+
+	struct notifier_block irq_nb;
+	struct notifier_block report_nb;
+
+	struct nvmem_device *nvmem;
+
+	struct miscdevice miscdev;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dfs;
+#endif
+
+	u32 version;
+};
+
+/* Struct for notification */
+/**
+ * struct secvio_sc_notifier_info - Information about the status of the SNVS
+ * @hpsvs: status from register HPSVS
+ * @lps:   status from register LPS
+ * @lptds: status from register LPTDS
+ */
+struct secvio_sc_notifier_info {
+	u32 hpsvs;
+	u32 lps;
+	u32 lptds;
+};
+
+/**
+ * register_imx_secvio_sc_notifier() - Register a notifier
+ *
+ * @nb: The notifier block structure
+ *
+ * Register a function to notify to the imx-secvio-sc module. The function
+ * will be notified when a check of the state of the SNVS happens: called by
+ * a user or triggered by an interruption form the SNVS.
+ *
+ * The struct secvio_sc_notifier_info is passed as data to the notifier.
+ *
+ * Return: 0 in case of success
+ */
+int register_imx_secvio_sc_notifier(struct notifier_block *nb);
+
+/**
+ * unregister_imx_secvio_sc_notifier() - Unregister a notifier
+ *
+ * @nb: The notifier block structure
+ *
+ * Return: 0 in case of success
+ */
+int unregister_imx_secvio_sc_notifier(struct notifier_block *nb);
+
+/**
+ * imx_secvio_sc_get_state() - Get the state of the SNVS
+ *
+ * @dev:  Pointer to the struct device of secvio
+ * @info: The structure containing the state of the SNVS
+ *
+ * Return: 0 in case of success
+ */
+int imx_secvio_sc_get_state(struct device *dev, struct secvio_sc_notifier_info *info);
+
+/**
+ * imx_secvio_sc_check_state() - Check the state of the SNVS
+ *
+ * If a security violation or a tamper is detected, the list of notifier
+ * (registered using register_imx_secvio_sc_notifier() ) will be called
+ *
+ * @dev: Pointer to the struct device of secvio
+ *
+ * Return: 0 in case of success
+ */
+int imx_secvio_sc_check_state(struct device *dev);
+
+/**
+ * imx_secvio_sc_clear_state() - Clear the state of the SNVS
+ *
+ * @dev:   Pointer to the struct device of secvio
+ * @hpsvs: Value to write to HPSVS register
+ * @lps:   Value to write to LPS register
+ * @lptds: Value to write to LPTDSregister
+ *
+ * The function will write the value provided to the corresponding register
+ * which will clear the status of the bits set.
+ *
+ * Return: 0 in case of success
+ */
+int imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, u32 lps, u32 lptds);
+
+/* Commands of the ioctl interface */
+enum ioctl_cmd_t {
+	GET_STATE,
+	CHECK_STATE,
+	CLEAR_STATE,
+};
+
+/* Definition for the ioctl interface */
+#define IMX_SECVIO_SC_GET_STATE   _IOR('S', GET_STATE, \
+				struct secvio_sc_notifier_info)
+#define IMX_SECVIO_SC_CHECK_STATE _IO('S', CHECK_STATE)
+#define IMX_SECVIO_SC_CLEAR_STATE _IOW('S', CLEAR_STATE, \
+				struct secvio_sc_notifier_info)
+
+#ifdef CONFIG_DEBUG_FS
+int imx_secvio_sc_debugfs(struct device *dev);
+#else
+static inline
+int imx_secvio_sc_debugfs(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+#endif /* _MISC_IMX_SECVIO_SC_H_ */

-- 
2.25.1


