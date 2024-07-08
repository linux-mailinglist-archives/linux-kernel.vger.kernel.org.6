Return-Path: <linux-kernel+bounces-243877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9401929C16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA29280D1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A014287;
	Mon,  8 Jul 2024 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oB+8nmAs"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95423C148;
	Mon,  8 Jul 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419652; cv=fail; b=YUQriyMCj4u8TSljBsxjXQwSSyx5xgAVYvNav+EZ4fxWmHauT+IdmLBV0z6NdaAZAI++DhjKew68koOETttgGaS6bEd5v3DkLoXjZnx8q5iWFwwEGyRWBO23E4qAW4auTQM9QrWARYQ64MqvIuOMKF3QMmO9ghflN2iHreKkOcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419652; c=relaxed/simple;
	bh=CuVF0ckeImwR7D7HDLMRa0EY5ywzS1yIxg9tlJr2Qv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1Y6IiLPMU0k+XLwwrro/0f/nVpCFyqbBevNGM4lsmWlvhCuq6JcA1lFMMcER4RhDLUI2HxrSvj1h/eFP7gvgSkAxsY/0H0GOOjNlF37yzxG6bWtRAWgjcgjf59QOiFXRVRxqoDVI7Ovr8tvR19oqdTqdaC7viFzQYgl34zAxEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oB+8nmAs; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu5/aN06yKbAl/yjB42Yd7fsQQpxcQtD+psLXlUvZqTOvgSjIyL9ztmpx+SXmvt2Iz81GCS9YEC8PZtoynPQWzQY4UmzwWGRBoLMJUjCtku6HwcG4vkYrC+dJgDWtR0xqGIdQb9E+3GhFdUcI3vtX3jAGqDXr4/LxnbRTBt1Sp07enyQ1nrVuy5n8ySyzE8/QzakgNYWOPqQjPN0Tbe1f2QkOF4kHp65jyLkuFTiKDXaVvPWn4dXNvs+VJ9MC6l4L6HffKNeSQ9awRU1ShALwOqwXmyKVoEz9SO4tEK5wZHY9uz5+4xGmBCoaAUw8byNBiY2lj/Vrugbw78RiNFC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kmatg/3SvgrhV2x1i3VOvvAfgzfbpIWrpFYsUP/9Pww=;
 b=YZ51G1rQZBzBzFsp31V1mE53V9K2mTmpPPk1vLMkbi5B6z5PvD+Fm9JdMrviT2oUq6JGfBAOb8UFMahXC3wE56UkvRZNfCQtMJQYRcOvBGJCI83047P/7r2/YXjz/eA5VH4KSXUqQbUzUG034+czGnKPyAf85IcL4Z3Px2nBncF3BY3ZMHwfszxsABMcl2XNjteYbJV7S5fdJo7zn2DXyT2dMKcoNFDU/Eu4yyYTKoKZBNpKJRKJQJ7IKuynLO1U5+wT5oxk26PwwX+0/DfiKyw1AAV4QT90T3T4z/HqwcTn6hkn+hjngSUKW8mf7trGIoG6VOEKRe7K1pn8lzxZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kmatg/3SvgrhV2x1i3VOvvAfgzfbpIWrpFYsUP/9Pww=;
 b=oB+8nmAsrud1Dno2PBVQwpFQ3OJEat5D9xPZ8Xz1U6JNY0I6gNpjksz9e7jR2Tq836KzvtkKXo96p9SYPjK60osEIIYI3nF+AWlI/bXdF6S+I2e/4p17gZWCbaYJb0ooJwSsvDWhFbvM5fyftMKXBZbzloerwIEnHhUAUS44mjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU4PR04MB10599.eurprd04.prod.outlook.com (2603:10a6:10:593::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:20:42 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:20:42 +0000
Message-ID: <3b91320f-730e-46e4-9c96-8c348bf9a2a2@nxp.com>
Date: Mon, 8 Jul 2024 14:21:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] drm/imx: Add i.MX8qxp Display Controller KMS
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240705090932.1880496-10-victor.liu@nxp.com>
 <6595d4fa-2e83-4380-b36e-9c4d910aadea@web.de>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <6595d4fa-2e83-4380-b36e-9c4d910aadea@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU4PR04MB10599:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5089e6-11d4-457d-becc-08dc9f1617e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzgyanc4NjBEak5YT3k3am1heUI4dDhHNkpLWkE0SE8xNGhpZjhiUVdOckpm?=
 =?utf-8?B?T0tycCtyZnBBYzZPZVBUUUJKamtwMVlOWlpYUGt3SnltdC9RMjdhZDN5YWo0?=
 =?utf-8?B?bkFUSGg0S0FvLyt0SGpUenU1cGEycThFUHR3YkEwSHN2dGtVcVMrZGpLbjVN?=
 =?utf-8?B?SSt4aWdZZWtCb2p5L1h3N1YySnJrNW5NcFZpYmJGdzFFa3pUdVdPQ0FXZU1p?=
 =?utf-8?B?T0ZQOS9MN3Z1MVVYWWFYcVRPMDY0NGQrR2xRK1hYb3F5TXlRQS92NStBUDlh?=
 =?utf-8?B?czBvWlFSYk42Sm54bCtzQkdrL1cxZ3FLWnA1ejhtSGdPUy8zTHZsN29OcVdF?=
 =?utf-8?B?eDhyZzFtS21pNnUvUGplV25zc21vV0xHa3VDWmsvblFjZHFNWTRSeFZlY1R3?=
 =?utf-8?B?ZkNyVXBNSVhoQXp3TWNqRHBLWTJ3NElZNHJWeVQ3WHh1R3lia0VSZCtibEF5?=
 =?utf-8?B?UHZaV24rUVp2U1JzdUtiTVpHYmNtR1NENllhbFk0RnlWZVV0dG1sU200NE9u?=
 =?utf-8?B?VlAyazhMdGNZcTUrT3RXNHgyT1V1TUFlVHdvSzF2UGlzNmx4bGpPcTR4eDkx?=
 =?utf-8?B?cXRGeE9XVW0zS2psSndxc3FCYU80RmRqV2FLVSs0eUJjbVdBalNVcTRoMm5K?=
 =?utf-8?B?N1k3ckJPNUpKdXN6N29ONlJEUkdwZW82b3JHSFdPU2NqY1BZTERSUU9wS0VC?=
 =?utf-8?B?V210WGYrSVI1b2JuS1dZR2ZVcW9qdzM0cTgrWnV4Yk43cUJDSjlwVjhGRVpx?=
 =?utf-8?B?eW1Zb1lUblova01lL2VHai81MlRKODBJNGRORnJqVFh6SE90WkVhMk82ZGow?=
 =?utf-8?B?cHZYTzUzOWd1REdIdVd1aWdkMVljMTBjTk9LbnZ5SnBXc3h3SGxsU2VFY0lV?=
 =?utf-8?B?aUI0VTY2SlhQQnR4TS9oUkU2SkdkY1F1NFFaSTV5dTV2eXF6NWNxcWtwMFhW?=
 =?utf-8?B?aXlBVTQrS0R2U2JLY3o3ZndsdVlucHFUNDkyN0RSTGRxUnJwQWpHT1A1U2Zz?=
 =?utf-8?B?eVhPeTQzTUxUN2RPYTFzRzdPSlh1OURKMm9lenI2b01DcEZUMTgvdmx1dkdC?=
 =?utf-8?B?WTRwQUJFdWMyRmJDYk10d0JBT3BIektBejJKdWhYL1ZkVVIveXUrU3lVTm4y?=
 =?utf-8?B?THJsQ3AwdTgzazVoQ1A0WnA0WS9oKzhKUHpWUlFoM3FpaTZ5R2VKamY1SHlh?=
 =?utf-8?B?NlNsVXVLc3IzR1JWbE9ic0oramFPVUJBWEJYTUJMejRsbHUyN2V6cXR4bkZD?=
 =?utf-8?B?eXc2d0dJT1k3UUhZM2MyczRTNThQMHNNVmxWekswNjl2QTBHY1RCdHpjK01H?=
 =?utf-8?B?T1NZakRaMmM0K2dFdUJ0bWxKLzhBRHpMREFPWlhRNU01QnhlTk5KSTNwc0No?=
 =?utf-8?B?NVlWWHdVNElPVXBRblRUTWdiUkdFNThZVHVHeTVpbmRIZUhUdjRQbFFWT1FW?=
 =?utf-8?B?am9zSWdQT09LcGMzc1Z0TU0xb1oyUGh3dXZLUzloamhGSktLNFRNNGM5SXhL?=
 =?utf-8?B?dG5Yd2Vhenk2Uk92c1FlRFp3dDFBYXhYSWZOYkk4VkM2YmwzdGZtZjl1OU5T?=
 =?utf-8?B?cGpjbEFrWXF0T3JmVGVHYXVpenhzU1BKTWtsa1IyOTloMFZvRTMwMWhrMDhN?=
 =?utf-8?B?cGhndkE5N2JXd1czTDYyM09QWnFzWmI2V3ZkMDJndTRuN2laWDRvOHNaTEM1?=
 =?utf-8?B?T2RReDVpbjJPREF1cHp1ek5ZYUM1cUxpQVo2SXdYNHN6VUFXSlJCdjlSeGE1?=
 =?utf-8?Q?cj42/vgXE3UVmdlNyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUs4Kzh0Ri9ZSld1cm13c0N0TXNoc3FiTDVkTmJ1SWs0L280Z3pNODBWNmFz?=
 =?utf-8?B?dzA1Tmx3aktpUWY3aUNISFloa2dUNmIxbGdaYys3OWtSUGkyOWV2M3h0bUti?=
 =?utf-8?B?alk3aVA3MU9XcTNsMDlxbFp4VkdvMTdnUDRsRWljczBGVC9WcjZtVE5RVGVM?=
 =?utf-8?B?UFQvM1dtazNYM2ltb05NYlMzbDdWQnFzZDYzTGRqeGgzQUNkcTBOWU5mWTZq?=
 =?utf-8?B?UE9jN0g5eUo5bkRPRVQzYXVscVR1MC9LMkx5SWsvS0QrVFdlTFVSejU1YS92?=
 =?utf-8?B?ZHF0Qi9iMzZINEQvbm1ibUNqR1BTN2lLYmFzVmpseUtMUFdWYmQya3k1eHYx?=
 =?utf-8?B?YmV5VU9icStZUE9YV1NqSjI2NFlKQ2dnVDlpTVVzMU1mZy96bkE3T3h4OWxC?=
 =?utf-8?B?eTF0bjZUY0Rmd0ZIMmF4ZlNGMXROa2FTZWY2RmlRdnVsZHJPbFdkanNsTUJI?=
 =?utf-8?B?bXIzTGhOSVJ0VllZU3dpd1NTeFVEdnFuNTQ2NUhxMkRZc0hkVVhUQ0FFWHZ3?=
 =?utf-8?B?aWhtSmpOOFhtYWc3S0NPWWltaCtDTFBka0NXMU53dTFZbW51NitGOStTTmVK?=
 =?utf-8?B?NC91MVFhRzR5ajQrTjhXVjFMakh0T2VjaFBrQ01KdzN0b1lhb1RyOVBzeno3?=
 =?utf-8?B?VExPbFVueEh5ejN3SXZSeUN3dmhkWmVvbHlxNXpENXR2QjNkbi90K0g5U1VJ?=
 =?utf-8?B?NFpzMEdnUk51RlRPeHB6MisrczZlajE1MmtRWnQvNlNiRTROUXFheWl3M1Bi?=
 =?utf-8?B?SllRODd5ODdMOER0YTZvcXpabk1ZWXZiVWU2L1RqUHU0NEZJMitldTNycWJ1?=
 =?utf-8?B?VGdoaFJBdHpPRHRpZHpLWTJyOURRTjJJYXdsd3Y0QUpNa0tXem1sdlVHR3N3?=
 =?utf-8?B?NEwraWJrWmxQbVpUaFBmeUFSZTk0NE51Q0ZDelNCcHpuMmJLUnNBVVBWaThU?=
 =?utf-8?B?VXlsYW04bkNNTlM0c1oyanlKNDEwVDFpWGVVU2pyb2xrREY5TXp6SS9Vd1Ba?=
 =?utf-8?B?MG91NTVGU0N1S0o3YloxbWxrbXlVYitvVDBVQVc2TThRTkJ6VVovSVowTWU0?=
 =?utf-8?B?THdrb09sa3A1QzRIUTQ2UndGaFgzZlRNQk13S0F0N2EraWFjalJuakdiODRL?=
 =?utf-8?B?SVpWczJNTjcyZDZod2djMXJNNWRMTUlXT0VyWlVRZVdJYXhFWThYTzFvaUtV?=
 =?utf-8?B?eE5Pc3I4dEdNWXJYamdYMFV3S1FMekpSRWpxOVpON0Foc0lWTFBXK0ZvL2lX?=
 =?utf-8?B?SDRiVEFZRnVybC91NjBxZHp0bkhzMVNzTDRQQzB3OWJFSkxFdis5U0FwOWt3?=
 =?utf-8?B?djVnc2lJeGZzWHdlRXhYNER0YXFTYjdzdUxuaERJTTJkdEU2U0ZOMk91cmYy?=
 =?utf-8?B?bHVaWDFISmJvMURXYlJFdGxUVlE4RG5tRnFPdjFORHkreFA5Ty9iYURsQjJU?=
 =?utf-8?B?SWR4enNCc3VPb1M3S2V2S2JFL0d4akcrUGsyTld2NUswc1JWblpqSmtyWVBV?=
 =?utf-8?B?SXBudDM2T0N6NzZ3NGhBL0c3Q3k1ZFFoMEIvOFVsOGN1T2RiQjh0ZjdhdUZp?=
 =?utf-8?B?a0tZNkg4RjhnL0l2SGxGMVBoclJPbTVjaG9rSFdzbVFSUnlzeXYyUFBOZWNt?=
 =?utf-8?B?OTFRR2FlaVVCQU9YejNoU1ZkNmJCWnlSSWRXeGMwd01YVDducXR5VEE1YmFi?=
 =?utf-8?B?ejdtclJzS2pza1JBY1k3bUMwQ3dRMVVnUGZydG54MFFEbk1MZWpqVHNyVlNS?=
 =?utf-8?B?WVZKcEJQTGthRW5wNUIvVHExMzRIVkQ0N0FoSzVBZEdoV2w2YmN1TU5BMWN1?=
 =?utf-8?B?eFU5aTIxMmtoZVNnYXlLZ3YxOE1UcFZQUW5kbkhGeGJac2hBQzE4Tm9ad25R?=
 =?utf-8?B?RlViblRKOWF4YW9jMHJRSUpEZndyNnN6SWhnY1BMYnFnWFg3MWtIZlRnWW4z?=
 =?utf-8?B?RWtjQmJEdkRHN1FaazcxU0VnWUR3anYvRjMrSUFpbjRPMjBENDE3WDJVMHVK?=
 =?utf-8?B?Vmo4ZXo5RStVLzhaNU1WbFF4c0doN0RQMEpMbWVhYnpyenpPOWJ0eWNGcjFn?=
 =?utf-8?B?bktJOStYMzVIZzh2RUYra2svb2tiV0VNYUJZK3IvaDZuWjNwbE5DWTc3WXZL?=
 =?utf-8?Q?FlKSLxAQ3a/p8RsaXgGp8ZwDf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5089e6-11d4-457d-becc-08dc9f1617e2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:20:41.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkD4V2uoQjOt/L2QVYfMIX6GKat0J/GbGXUFWmbWH5BiN8ZBT5ogKfcw2JEpIC8SpmmPCc/Zyh7g/k5lwNHO5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10599

On 07/08/2024, Markus Elfring wrote:
> …
>> registers of the display controller is accessed without command sequencer
> …
> 
> Wording suggestion:
>   The registers of …                  are …

Will do.

> 
> 
> …
>> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
>> @@ -0,0 +1,578 @@
> …
>> +static irqreturn_t
>> +dc_crtc_dec_framecomplete_irq_handler(int irq, void *dev_id)
>> +{
> …
>> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
>> +	if (dc_crtc->event) {
> …
>> +	}
>> +	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>> +
>> +	return IRQ_HANDLED;
>> +}
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(spinlock_irqsave)(&crtc->dev->event_lock);”?

I just follow the kerneldoc of drm_crtc_send_vblank_event() to
hold event lock like many other drivers do.

https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/gpu/drm/drm_vblank.c#L1120

> https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/spinlock.h#L574
> 
> Regards,
> Markus

-- 
Regards,
Liu Ying


