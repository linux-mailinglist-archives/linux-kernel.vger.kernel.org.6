Return-Path: <linux-kernel+bounces-432575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4A9E4D28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6ED166D35
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D90194C92;
	Thu,  5 Dec 2024 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVGApMWl"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765D1A76A4;
	Thu,  5 Dec 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374630; cv=fail; b=MgZ/Ig+V5PDrBny1oA7Y+OMAnqY++Hf8kD7dlUpzxEkkplSoJsBmp2XjwiAXemI8Qu4LMqjP95zp9Zng5BnYa9tU1roC9nGnzu+VrYbUN5fxlTZfuxcGHKP3gHzklRWx+9PdcmrcaBkWG125l9Z/w1Ddvkx3S7OwHYogcA06OvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374630; c=relaxed/simple;
	bh=9L1zZa9eeF5I7SxsWRc6f2C+1iArp8Ib//lGttKdElY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WRv/fk/xUX7kLLwHtfcN508ymst9ZGEil5noWAfbaegD2/ugBTpCTpfpboarWJdmhCXmz+HcC7FPyd2tNZw0n8CH+MTlwivJfmiRV8xCPCf2cpPJhDxJUi6uqyu4d5AsRfRYdvCHbvv4wBcUd4iqkrozsgF0Hb/yKsB+uTPA5pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVGApMWl; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlrrOzbMOnstlsmoFoM/othyxEnCy2IpQ2clk6G9xRGdkVsba3f1TxyC/XpVFl7V5x+HdqvQ63iiL0HN5s04Kms5lf06hOlobM184Cp75JPMuskhYG/zg82aUjMhHF/raEMG8x/mrp6FyVhj2HTwiDpyjXmkbMfjGKVLV9EOUNojqPMk8ak+YBmYc6mtjQ7OoX8a9QH4asa/FVkKrV7zBLpDJMGXI9Wwfp6SNAsO5Z41CXICjNhGEwvystvkJx1HKlDaFjB0UfMKE5+6GT73pagE8hd/Ct42VLllOvdgvxKdUPqQ7q2HwrePKaiKtSm1NscdbAKSqq7rMTwbgg/nfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ/Ti1E+3HLgDe2DihLGzzNVE5vDiObZEfRx8YHM57A=;
 b=eojqSbOC2iatZHzdFHpMNCc/FcO4vX/NIX/iBJlJUIH6kTvacy6kbrtWwIdxQoe77g9uZhwhjcVIYG4mx2JhYqFKHouZZmAc8ulxTgdxdchT54WOpcTCUHEP4ycWMJlKy/Gt7p+tSRuk3Rz4mWOMkMRsHdDfL57O0BRHVp6Sm3wGeQOLf4RuBHh6nKhL21nNsU9s8t6S2TYyKZxcODNG3Rg5XAkeU4vDnAyEuegaGxSdSzrRHzvRsidfvEdANnpluVAGF66AsXxNuXc+BxDCgVqQ8HAFLBaWlGp/WUsps8NhQoJKsbSmC4eY4PNWJr4UlR2NOY0SwNPUuRxLmfeZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ/Ti1E+3HLgDe2DihLGzzNVE5vDiObZEfRx8YHM57A=;
 b=ZVGApMWlsLbJq5E7ZD+z1oqOzCe8zLGLWL2FH4M8k+Sia3ZratcDMVu+EKqoqDaHG/D07Yi68uEclZAWqEwVDWW/iK8DHJjGxUKmUzz73vddZVN8pnQ5Z0pGMSW/ba4OSYCl+wh+L8G1fOYdqzdtAQqgSqqKc6YawnRBiQWgljxN/PolW3ChdNJMZcjH6cy6un4YHOLOUc+gEiwny9jdsPvvfUr4qhSXVeGVgD2zTZA02GuelIYFk5iv5Z70bS0jhWJdSSXw22i1z2iGXi9VqylXGijNHtfQvNv+M1pOwjxiVIl9s7x4//PIjEmiOYIGf0W/wHxIpuma29iK/8h6Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by DB8PR04MB6794.eurprd04.prod.outlook.com (2603:10a6:10:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 04:56:56 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 04:56:56 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 05 Dec 2024 05:56:35 +0100
Subject: [PATCH v4 4/4] firmware: imx: secvio: Add support for SNVS secvio
 and tamper via SCFW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-secvio-v4-4-5c37cdc39573@nxp.com>
References: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
In-Reply-To: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
 pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, 
 V.Sethi@nxp.com, meenakshi.aggarwal@nxp.com, 
 Vabhav Sharma <vabhav.sharma@nxp.com>, 
 Franck LENORMAND <franck.lenormand@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|DB8PR04MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 38be55c9-ecba-43cf-477e-08dd14e93d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3FNQUoxa3pBNWR1YStpbjlFbFRtUWxZV01iVEt5MVlIMW9XOVRtbzJVNjBT?=
 =?utf-8?B?N3diQ1p5OS9NNFB2MXFRV0dyd3k0cCtsTGxjcGxuUmVEUmg1SVBHVDBUQmo3?=
 =?utf-8?B?ems2QldMeHJUZVBobHk2RTdJK1g2NjJBZ0I5WGJwZThwT2RaV1lTVlhtRFdn?=
 =?utf-8?B?WjNncXhWWWJ1V1BaSU5vNVA0aEw2MUR3SVJaUzlSK1RIZG9id3dsYzAzYyth?=
 =?utf-8?B?MjBGZkNjcitPS0VaMXR0ZW1QWUZnTVpHcEphRnc4ZVNKMzgwNEcyNnVQakpU?=
 =?utf-8?B?V3ZEOG5ic0V3aVNYbWoySkJWYjdkdmwwZU1IaCtDRnRTUUJrUTJIYWpoa3Vp?=
 =?utf-8?B?U0lDU2Y4WDNsWCtLY1hyQzVEaTFiNWF1SEM5cld2UnRwTk52VndYWmRGR1hJ?=
 =?utf-8?B?UHNJR1E5b3RxOU9Dcm12Y3VPWFBGd0J6ZkcydTdTTEgxM3RkRnRld0hUWHg1?=
 =?utf-8?B?VzllMDl6elB6MU5DT1laTkZLaitmSWhqSlZmZU5XZXE3SmM2WUt6eWZIbGNI?=
 =?utf-8?B?QTJUYmJMSktLNjMvd3F4KzlmbUx6OVFRQjAzanRxSXJESFpycFQxMk9Bazlq?=
 =?utf-8?B?SC9nOW1nSDlXMXZlUlRHbzdxMzhwNUlPTENJUUdwcjRTb3hMZWVrUzh3Uk56?=
 =?utf-8?B?U3h2ejRxYTBQd0o4dmp2TGx5ZUs0U2tZaSsrWWRUK3hiNXZ3MkFOUkR1VW9t?=
 =?utf-8?B?b3dlRlpGeHMyTXI3dXVYbGUybjVNZ05vQnFta2tUTFVJcFJ0UTBnWWdnQU50?=
 =?utf-8?B?akREUEI3UjlRVlN2WE5rVjVJa1c2Y0hUdVpHM3ZhSWFtRmFBajJROHUrZ3lJ?=
 =?utf-8?B?M0ZxZnk3UDNyak1MS1lqUDV3UXZWWmVCWkE5TTlrcjRJMlM3dXR2aTVpeklU?=
 =?utf-8?B?WkNOTlIybUV3akVnejNGRDV0L2VKbzBtNmlQd1BoUGFRTGwvSHJaNWJDcUly?=
 =?utf-8?B?aTc0QTBKQndRTyttbmdva0NrMnJWa0NrQ1Vhb1k0SVdBdlk3aFFlaklhNWNS?=
 =?utf-8?B?VzMwTmVacEhtRXVGUmhFekVTTFI0ZkhLdzRNMElMdytsM3RWWXJoZkN2NlB1?=
 =?utf-8?B?c1gzRVVYQTRNV1Y4T3VuY2NjYlIzU2d1eDVIT1NDYzh3YjF1bDZqdC9QMkx0?=
 =?utf-8?B?aUwzQjRvSmVsamxkeVFYc2M3MEprK3pSbVRIQlJvMnkzMEtFVmE3a0xGQjVz?=
 =?utf-8?B?ZjlGQzNwbVVwTjNPaEovbUZZeU0yTzV5TjYxZ2JXeVlGdDAvY1M5T0lFaVUw?=
 =?utf-8?B?RDV3RC84TUZ0UURZTUZMdDNDM0hOQ2JDYWxOOVpQMWUyaFJ5ZWtkY0xOTWsr?=
 =?utf-8?B?eVdDNzRSalYyaUprZ1hjVTUrcHYvOGlXdGZDbmxsWVNlcjUxWmo0cUd6YnYz?=
 =?utf-8?B?d1FmSTJsdTNjb2dRK3l6VjJHUW5JQXZyMlBGbUJZckNXKzl4cDZuSXdUVEls?=
 =?utf-8?B?UXdkdFdTRW9Vd3djdVRSK2IvSHluL3NGZjhxenlBQVFiY0NGMWU1a1pzemYw?=
 =?utf-8?B?YWpZb2RyaHR0UjdIZzJ5Nk1yVDZIeW1OdTE2VkgwZnVjQW1yaExoRkZoWGVS?=
 =?utf-8?B?L0RGcDZzYk5lMjJGTWFuZzgycHNvRHBOSTViS2w2VW5teXFJU2czSTFzTmpm?=
 =?utf-8?B?Rkw3QU9vK3A5VmxJTkl5Vmt1QmR0dUM0RnF6MEFQRU5lU21ib0hOS2pPcENn?=
 =?utf-8?B?Tk1wZGZVcDc5Qkw5cWdSSXU3bzJaTXJNZVVzNVdsK1dJb2U2M3hZUU9ZVWUv?=
 =?utf-8?B?MWtjZytZd0ZJRmZzaWEyeDFPWGp0VXdIMndNNWZRaXRoYmR2M1pSeDVPT1pa?=
 =?utf-8?B?QnFTVkVuNjNLc0VaTHBpMzh4QmU3em9YdEZ0ZFNZT2NBTHRCVjd3WTVvdDlN?=
 =?utf-8?B?N2tYK3V3Z1RtREhUbTdHdXhTSXNLUUZTZVNlY2REVlNZWUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEU5WHo1RUxRdFZoWGllWjl1WnJZa2RXWXBUQkkxbnMvK3BIdEdTV3BSVUZo?=
 =?utf-8?B?dFgvYU01QTc1NjE0a0p5SDZSYnFOZ2dTYUZzdHNKQUR2RXV0eUdJeFpnM0JU?=
 =?utf-8?B?YzZsc3pXVHp2cFFIcXhENUNyeXRGRUkxYzh4MmxpMmtyU1hieTZZVFQrejc1?=
 =?utf-8?B?M0JEZ2pacnlvL0tIbzkxakVpM3MxQlZVc0dOSlgxNlN0c3EvQWhkckQ2Ulgr?=
 =?utf-8?B?cGZuU1hwUFNzSzl1WmxoeEUvMGs3VXEwNTdPR2Z5Z2haTmxiQmxlWHlsbHJ2?=
 =?utf-8?B?RGYyVzNLaGFoVWVWanQ5OTQvZ2dHdEx2bDV3MFlzMjU3RjdQZVlpRDcrMFlw?=
 =?utf-8?B?amd5YzNHQy9qRkVjdDVURDgyL0doSVJ5Y3YyKy91dyszUmN5T0k3dXNBSENz?=
 =?utf-8?B?VE1VbTVIOGE2Rzc1d0JaV1E3OWh4ZXAxU0xhZ2hKS1FxNHhPcXBNLzNKNzFS?=
 =?utf-8?B?WVZGaCtUV2MxcEhSZVdabWZaQlA2dnZFdzI4QnpNU0VGNXczMFNRQWxkYk0v?=
 =?utf-8?B?ekdIVzdFQ0JxYWlhNnFJWkpZYi9NSVUrTWNraE5rVnovaGRHZ1ZDSGhScDE1?=
 =?utf-8?B?dVhzbEpvRnp2OGY3b0JHNldnclV6cE5IRUhyZmFIK1Z2NU94T01QQkMwYita?=
 =?utf-8?B?MEFXUTNXZ2t2ZWdnOEtMM01qbm1KRGNWNUV0UUJNT2UvQ2grSGFLcjFWNUYx?=
 =?utf-8?B?bXIzN0FoOVhmbGZHTm5zN1FGdVQwNktvN0FsK09GMk9SOTFHNW9SUjdrTlNs?=
 =?utf-8?B?UW1xS1dKTENwSU1ldVkxSEhBbS9TMHh0NVVJWThydG80RmZaZGd3Zm55aU9x?=
 =?utf-8?B?UCtGTm9YeHNFY3J5U2dGYU9NczN2STRaUS9KVkZRSnUrVVlnN0tZeTFMa1BD?=
 =?utf-8?B?MTM5QVJhNkJvcWJFbEJDLzdOeCtZSjNTQjRKdVlYRURmSUovWVBnWlRPalhl?=
 =?utf-8?B?YnpTZ3hCVk1lUlZxSTRWTUlzNDdJZW5iS0FTU1VrMVIrYUZOMUl4NWoxc3kr?=
 =?utf-8?B?WitCeGExcXlqTFA2VzRjenovNnRkMDk2WmM3SmxhMTh1eVlKS21JTFMrdytz?=
 =?utf-8?B?dlI4cnRQeUNhMlo4VzN3bWNNYmMwajVodDJzSjlIS0JwRzlWbWorYjR1ZlVu?=
 =?utf-8?B?RERSb0tkY05EalJZNTRSZGFXYnFkd3hoL1lVdVZGay9QSHJlOXNjNFpLKzc1?=
 =?utf-8?B?Z2tMaU9mQnVLallkajBpWWNtWU5zUE1zd3MvNE1jdWFqQ3dNYXB6dzVaTkpy?=
 =?utf-8?B?TkN0b3h1b01rbjQ4dHFtS1Y3SUx1ZjBpR0JhNW0rcGVhZ1ZUdkhLdWpGYUVZ?=
 =?utf-8?B?L0dsRVlVc3hESG40bzNyQ0lNT3hNR3dBek5vVzMvUDNDeW5HZVplUjFkYi9i?=
 =?utf-8?B?MUpwM0JWZE55ZnBZNW43b0RCckRnZVRYNDk2R0F1UkJhWTYvdXR1Q3BHMEVs?=
 =?utf-8?B?aHo2VHRzajVvM200RmZYODdQeDgxNWlxWVdTeDd0cUx3aURRSXB5cDJOL1BP?=
 =?utf-8?B?ZjV2TXZ2YzhlbDRwKythaVJSek5BdzJYSW1mLytXNDg0TmJQdDZwSzBGbXFp?=
 =?utf-8?B?YmduT1hzd1lLbmhqNnBPUDlzbWhsdzJWc0NiclpDcjRGQjZLbWhoeFpQZ1h3?=
 =?utf-8?B?UnhyVVZLNmw5aktIbkoveXhjQk5mamZEYXRFc1pDOHE5cW1VTUg5L1REN00w?=
 =?utf-8?B?QmhqV25mVDAyWEN0Z0JCVkE5TlRKK09QMVRjTmREMXJxN2RMcVRSRmhVRWt6?=
 =?utf-8?B?SzV2N3NLWGdsT21XNEJwUGdnWGtaYzl4YnZwZkVOcCtZNE4rNzc4cWt0TkxB?=
 =?utf-8?B?dHd0bThmUHl4RmZHU1Irc3I3YVlPS3QvcUttK2RBdGtuSkc4cHhkNlNvemlL?=
 =?utf-8?B?MjA3WGIzNTM2c250VFFmbElkODIvdE5mdzRKYTZZYWxIMEtkQWpDUGdXaDBs?=
 =?utf-8?B?Z0tHY2NpbzlEZE0xYTZtMkxSU3gxa29iQ1Y0aWRMd2VncndXUHNUWnpwVGhS?=
 =?utf-8?B?QzMwUGpyT042ZU1jMVJrWkQ0UTNOOE94c1NtTE51S3VLd29nNVdJNE5vVTNo?=
 =?utf-8?B?eTlxT2VvQllGcGRreXBHK04wNXBEZTkwODJXL21IMjRVOW1ZOVNuNHkvVWFv?=
 =?utf-8?Q?ojxJPnZgOqbaD1TWKMHXdHyKG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38be55c9-ecba-43cf-477e-08dd14e93d44
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:56:54.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXo4j/6HlrHZg9iYVc0EDuAvJnv5u74VSr3NGetqw8BmfrZ2rrvbWBmTQxRp/GRjRoACJUAOjYzEdS1qJCddwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6794

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
 drivers/firmware/imx/Kconfig                   |  11 +
 drivers/firmware/imx/Makefile                  |   2 +
 drivers/firmware/imx/imx-scu-secvio-debugfs.c  | 274 +++++++++++
 drivers/firmware/imx/imx-scu-secvio.c          | 619 +++++++++++++++++++++++++
 drivers/firmware/imx/imx-scu.c                 |   4 +
 include/linux/firmware/imx/sci.h               |   5 +
 include/linux/firmware/imx/svc/imx-secvio-sc.h | 216 +++++++++
 7 files changed, 1131 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 477d3f32d99a..14976bd9f5c6 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -33,3 +33,14 @@ config IMX_SCMI_MISC_DRV
 	  core that could provide misc functions such as board control.
 
 	  This driver can also be built as a module.
+
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
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 7aaecf570c56..80a2bd4bbc2d 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+obj-$(CONFIG_SECVIO_SC)		+= imx-scu-secvio.o
+obj-$(CONFIG_DEBUG_FS)		+= imx-scu-secvio-debugfs.o
diff --git a/drivers/firmware/imx/imx-scu-secvio-debugfs.c b/drivers/firmware/imx/imx-scu-secvio-debugfs.c
new file mode 100644
index 000000000000..55bce7d0b7b4
--- /dev/null
+++ b/drivers/firmware/imx/imx-scu-secvio-debugfs.c
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
+#include <linux/firmware/imx/svc/imx-secvio-sc.h>
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
diff --git a/drivers/firmware/imx/imx-scu-secvio.c b/drivers/firmware/imx/imx-scu-secvio.c
new file mode 100644
index 000000000000..30eb9e4bf7b8
--- /dev/null
+++ b/drivers/firmware/imx/imx-scu-secvio.c
@@ -0,0 +1,619 @@
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
+#include <linux/of_platform.h>
+
+#include <linux/uaccess.h>
+
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/seco.h>
+#include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/imx-secvio-sc.h>
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
+static struct platform_driver imx_secvio_sc_driver;
+static struct platform_device *pdev;
+static struct device *scdev;
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
+		ret = copy_to_user((void __user *)arg, &info, sizeof(info));
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
+		ret = copy_from_user(&info, (void __user *)arg, sizeof(info));
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
+int imx_scu_secvio_init(struct device *np)
+{
+	int ret;
+
+	scdev = np;
+
+	pdev = platform_device_alloc("imx-secvio-sc", -1);
+	if (!pdev) {
+		pr_err("%s: secvio: Failed to allocate secvio device\n", __func__);
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret != 0) {
+		pr_err("%s: secvio: Failed to add secvio device\n", __func__);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	ret = platform_driver_register(&imx_secvio_sc_driver);
+	if (ret != 0) {
+		pr_err("%s: secvio: Failed to register secvio driver\n", __func__);
+		platform_device_unregister(pdev);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_scu_secvio_init);
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
+	data->nvmem = devm_nvmem_device_get(scdev, NULL);
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
+static struct platform_driver imx_secvio_sc_driver = {
+	.driver = {
+		.name	= "imx-secvio-sc",
+		.probe_type     = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe		= imx_secvio_sc_probe,
+};
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index c96dc73689a8..5c27a767fe2f 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -339,6 +339,10 @@ static int imx_scu_probe(struct platform_device *pdev)
 		dev_warn(dev,
 			"failed to enable general irq channel: %d\n", ret);
 
+	ret = imx_scu_secvio_init(dev);
+	if (ret)
+		dev_warn(dev, "failed to initialize secvio: %d\n", ret);
+
 	dev_info(dev, "NXP i.MX SCU Initialized\n");
 
 	return devm_of_platform_populate(dev);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 947e49d8bebc..08237fa47c3d 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -27,7 +27,12 @@ int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
 int imx_scu_irq_get_status(u8 group, u32 *irq_status);
 int imx_scu_soc_init(struct device *dev);
+int imx_scu_secvio_init(struct device *dev);
 #else
+static inline int imx_scu_secvio_init(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
 static inline int imx_scu_soc_init(struct device *dev)
 {
 	return -EOPNOTSUPP;
diff --git a/include/linux/firmware/imx/svc/imx-secvio-sc.h b/include/linux/firmware/imx/svc/imx-secvio-sc.h
new file mode 100644
index 000000000000..d8c9208217fe
--- /dev/null
+++ b/include/linux/firmware/imx/svc/imx-secvio-sc.h
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


