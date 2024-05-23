Return-Path: <linux-kernel+bounces-187365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95E8CD0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32212B227E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E8144300;
	Thu, 23 May 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Da+awofq"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8631442F7;
	Thu, 23 May 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461567; cv=fail; b=QtNJ/yivO3jaD13XdzM7qJqzp+mD/vzxF449B+HsoAud0UvEcq0fx9mXVihnIh3buLL9yrgdollOHWOTuQ91nNb0QRJl/WxSQLFi3pbGhQlRywbviMVlg3wO/S3D2Kw/LBRLarS1FFlzll76mO3rnDkUJC57G/x43p+AHLwme8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461567; c=relaxed/simple;
	bh=CtJ/9FTiq7DaG4rGNNzuWMxNzyVd800PfyXkOB1QQ7E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t6e1EBT2+L9iJB5FYMeAvoSBOIjtDi0YvavDCdOcy/7TdAo2MLaZCd0CwfHfxHbnYrRRjRStaovlidQZ8Uf4mj9D0hgBDElgmNeXyMhWo4twboldFxzM66bjxyOIvxlljxFeaE265nVjlENuvUadvJVGsMubROnMVWWujBZpb8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Da+awofq; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9QwDw5s/P8dKmTn4pi0d6RXX1RKH6cGLKUk7fOodP6mwI2toenp8O0frXVpbajAKdXBxCIBGf6kaTISl6GtaXlQu7oT4rlKjK7qKUIeayYxpmdvUOauLFC8vXGV0ZKLGu3QZjJlRhGtGQi9Yr8lPaWTEebOugYLdTkXp5y9DxKuHTh40ZkDGyVzGg0yde5KCa5yIUQyPcQ3qurqT2QoMoMJ8Pz3P/qkzcIdt5AzZoTTIiLYb0kP8zjVp2goAr1cZ9ki3VPPATs8M/+WLJcUUQN9XIxqJfmMc0qCg77WG2zXdK4r3ejVxAYUSd1wf2Ba9osIqC3q8kbHqeake9vywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFIBcXJB06KrE3tsEaa3tWXz5wvR/OOHA+nSukvl1p8=;
 b=TSSSzCx6dud9E+HPl5j7u4CZg8Csn0kXCLhZJsT5faxvCjTYArN4hoJ/WcWuaVvDdlOmxygpNoXKrIb2Nbl3al6TT6mbVGaWTbk6X2mDzCPe5DdtjtsenFbFJOGCXXnMG74Sc1UuuIGg3cGNP7SF2sXc7+7te22xh3uGX3OkynopcKHS4my/fnSjXdQ6jzLB21h0IJRJhBanf6U4aN26PhCi02r8bstGjbGTqR+aaOaV9HXowyfqi4MQE+SzYYtG9zGLFuhGNDuwC+xk6sMEN5lw4u4RGUwKuF26S6+W0zl+wWkhw6MhIWtaC3HudYL3ft1fTkEnzAYkEYcp3akj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFIBcXJB06KrE3tsEaa3tWXz5wvR/OOHA+nSukvl1p8=;
 b=Da+awofquRbDS7mNSDpsfncqx216sbsl2SBiYmvDaBWGdNu3JHxE6yEwq9+kXxMX9LWwLKCVkQMH7GU17RyLalADtSP9XQ6R+FpE5AtpCeRelMw3iVjqwag7HKwCl96qGtXoaag2nk8SF2JGxu+sq7GaQwxkXFK0mWJsrkivAqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Thu, 23 May
 2024 10:52:43 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:52:43 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 23 May 2024 16:19:34 +0530
Subject: [PATCH v2 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-imx-se-if-v2-3-5a6fd189a539@nxp.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
In-Reply-To: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716461396; l=2655;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=CtJ/9FTiq7DaG4rGNNzuWMxNzyVd800PfyXkOB1QQ7E=;
 b=ksQFOGmKQBbuqhjL7n87sDcZMrLTO+Uji/m1vdodmOJprUmDdOehWgWsXeuBgeuu53ZLMasWQ
 81kGJcCblzPCr4onptYffJ8F0dz6VKazl2Vs6YiylIfoO9QskGq6Xxs
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: fead4d1f-d239-43d1-9c52-08dc7b167913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|7416005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K01rK1JKd3NFNVRZRGRCUkVadTlSQmhJckw4R1c4THdEREpZZDlyYnVaenBN?=
 =?utf-8?B?RnV3R29vQkJuNUdCNU4vWlJsU2trajdYU2NyUkNyYjBsZjdQNDBQRERUSGpy?=
 =?utf-8?B?QURtc1BuUThlZDBEaWIwbUsvQStJbmJhcU9SOG5TeldkWWYwaDlUWVRmK05v?=
 =?utf-8?B?TXFSbDRrUHRhdHlRelpsVUVzbnBwTEpGRHlRT0FpVmFUVnMxRU9XNlpaY2NU?=
 =?utf-8?B?MUhXOUkrUk8xNXI4R3Bnb1E4enhialM4YS9BSTNpd3dieXc4TEZQdDVPMTY5?=
 =?utf-8?B?bW9sbzNPdEdNWnFsVU9kQTY3TGszaG1UaVoxVjhVSGNBTDRkME5SL0FxSzBF?=
 =?utf-8?B?K2RlN3RMb0tRalRjWVoxZXBteWJ3a3QreEVaakJJaCt0cTVCWDRtTkxmSGov?=
 =?utf-8?B?Ny9TUm9JZVFoL0lqbUFzZWJ5YmJKOG16Y3IvL3NQOGViYjlGblp5UmlMRFRR?=
 =?utf-8?B?V2tJc28wanorZ2xoWStmZEEwb1k5MHZtaHZSMGlPa3I0dWhpc1lQNFl3cEhk?=
 =?utf-8?B?RUVhQnh3QTJ4QlBhdVBPMGpteHB1TWROODJFdzZGVkR2WFlydXlWU3l5b3pR?=
 =?utf-8?B?R3hxblJ6U2s1MVIyY3hPNWp6VUdpek1TaDFJdmtUa2QrN2UvNi9YemxXaGln?=
 =?utf-8?B?SnNxQ01EVXBCcHI2RllpQ1NocnNOTWxyYVFKUmdCc2dtTW9JVnFzc1JDRG8w?=
 =?utf-8?B?ck5jUkZlUTFnblJmSDVWTTd2Y0p0aTZOckxkUzlVbEVGWVNTcGY5ZkEwNlN2?=
 =?utf-8?B?cENmODdadEpBQlBpTjNuZEhEYmRnMGdBbTdnWnNJWlNHNnY3Z01YTmpMaFRV?=
 =?utf-8?B?UUcrOWtVekxxQUo3WlVvZm12VkQ4TkdIRlNDVmQ1Z1RxTWg1R2M5MmowUSti?=
 =?utf-8?B?cmN1am5lcW5hS2k0cGhjQmdsaUxCS0lRWUdPTllUdHJZaThBd0pFcWQ0Szkw?=
 =?utf-8?B?ZG5CQ2hoS2pIQXR1N21qT0FWbFhSRkY1bmNYRDhwQTNHQWtoZmx0Yjg3Y3dy?=
 =?utf-8?B?MGZMU0JKRThoMFkrU3J4VWJJUGxabWZxU25GVUdXeHNkZEtQVE93ZmlETXFT?=
 =?utf-8?B?a3I4c3hBNXI3MWdVVHI0bW0rdlhTWGtPVFkydmM1RU9GYXk4MWd3ZjdYTitO?=
 =?utf-8?B?V3kvOUlpUnRjUXdKeE5waWtCZ0l1MFpQcXZoOTZRYTNjTm4xYkl4cnpjOVhS?=
 =?utf-8?B?NUJpYUN2UkhQYWNTTmxKeWc0M0t0UHlwT01HVk1RdUFOMXZNOHh2VkdDdmZn?=
 =?utf-8?B?WTN0b0sxUmFFbU1JTlVOVzRJKzQ1ejdJcHQwRVpFSXFyWVFqMldSYzZrcmdm?=
 =?utf-8?B?clpiSzJhbFE0RDBxTkhPdDNNVjcwcFR5OUh3NjRQY2ZGVVZvVFBNUEEvdnJZ?=
 =?utf-8?B?SWc2ajRxZm1LWDU2SnZrbVlybktaei8reG5FRm14NklOUk9IWFdQaUVyRlZy?=
 =?utf-8?B?TEVKTHlEUTY2c1RmMnVQN3ZTUkl3UjMvZWhlQXBqN2lqVis2dzVyTjRCMmo3?=
 =?utf-8?B?Uk40a2doOC9IZFZrVnRZRmpFY2RUNFM4aWYyM3J1SmxYZExwSVFVdEc1RGtu?=
 =?utf-8?B?QVpqbVFYdytqdEYwL1FqMXdTL1gvS1AxL00xQWZLMncySHdEZE16d2lOQjQr?=
 =?utf-8?B?ZE9pdW5tZkdnaE1Bd2tWd3M0ZUZtdU1IU0tNSzhteVArVW1LUWEwNTlsbHUx?=
 =?utf-8?B?a3BLMzZxMWpOTDhlenJqbWsxUjVTdVYvMzNOOHdFMStjSFA0Ym9tNk9wOEFB?=
 =?utf-8?B?aXduNU9HMjBQeWZhVzA4V1VKNTdVODBTZVZuYmIyQ1EzZzB1bEdxa0owRVhz?=
 =?utf-8?Q?vSD33ddFjNujvNXGoomNwWycWvo0mWi6mwMK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VmMDdTL3pTWm5UQ0YvL04yQnJOUjJySnpCYnduVEhCZkI0WWpxVUhyTlUr?=
 =?utf-8?B?bkVLeVpNanZqdU5ScFV2Rit4Z3BaNWFPc1FDVUo3b3A2NzE3dlRkZVpEcitG?=
 =?utf-8?B?R3dJZGsyUUFVYkhYYmsxUHFpT2szU2FDUUdEb1Via0tZOFBRTWtXUTlOV05W?=
 =?utf-8?B?N0tTVmhuSjNxTUtCanZQaU5mdFp1ZldXb3V5MmlhcUN0dmpjMGJwVytFUnBB?=
 =?utf-8?B?cFUvdWs0eFdsaG9tano5OEM1aklUVGtUWElyOE9wY0c3UVNaV0hRK04vVFMr?=
 =?utf-8?B?UDVTOGhQTkMzNGdhWXJna2pJWm1nYnNhTDZsZGZEdWlFZjJYYmFYNmpGV0xI?=
 =?utf-8?B?VDdXTnZldWswRGhtVnNxZEw1Y2RIY09YYUlhWllVbnNDRGhuaGxsTy9jUmFY?=
 =?utf-8?B?VEdmbWxWY082Y1VVUzRMbkZYQ0tKaXlnZFdWdWVzV0R2NWJBM1dSZEg3M0Fq?=
 =?utf-8?B?UWhzRkJETTdMMjVST1hNVGc5OWZIZTlVUDM0N3Bjc1lYMlE4eHhwSXUzTENF?=
 =?utf-8?B?aEdrUFRmVjQ5eUZwcHlydDA0b0ZqV3pUTDl3MGZRK1pyWTBRTkpSa2Rmc1JZ?=
 =?utf-8?B?eTdrTHNtT0Q3SHZPQ01sK01OQ1JnazZRVCt2ZTJoSld0cVJNNWQ0SnFtMko3?=
 =?utf-8?B?aXZnSFVIYUhvWGVSN3l3NDAvMU1QTzlZMUgyVlc1b3BvdlJoNU1OV2tPdTly?=
 =?utf-8?B?WVE4ZUlTcW9xeWc3a0xBV29RWG1SN3FuREV0ekVSZkFzdElCVnhpMzBseDhZ?=
 =?utf-8?B?RGNIejF2N05jSmNKZzZ4MHJRdkdxcVpKSUVtZ3Bza2NMd1Z4QStLMm93c0xn?=
 =?utf-8?B?NlJWcjE0dGdQMnhybU1MUGUramtqdTNGUEF6S2U4cjZucFFKSWw3Nm8xcDd3?=
 =?utf-8?B?MzlveEFWaExNZGhaUDhSNVNlajMyZHROaHNRWCtHQVZDYStaUlJhWWlwT0lR?=
 =?utf-8?B?Ri9TSEt6U0FoNDBtSUZaalNRbG9qUmNwVTB4VExpMUxCV21mZVkzMHU0TjZH?=
 =?utf-8?B?QVJLQ3JXMW5SdVVCZmkvTGVkWnVOT1lZaGVGMGZ0WVZva09CNGg5TmpnR2Vx?=
 =?utf-8?B?K3hWNUw0MzBhdFoxNVBVYXBpZUtoQi9QT2xyaFE3ZVZjUHd1UnpXM0l1c1FE?=
 =?utf-8?B?bG5ObG1WUGZ5dVNFSXQ4SUxBbzBSVCswTDRaM2EzVFFHUHQ1ZWdHZlNGdVNu?=
 =?utf-8?B?Ni9KQ0FPV3FSYlhCd1A1Y0N5WDFObHh6V29nZ2sxTTZHV0FvOWdrNHE5eHZ1?=
 =?utf-8?B?Ry9GQmpjTWhhVWR3b1hnblVtdm5UekFXdmR3WGVLOW0vRkc1dm54Sm5NSkpR?=
 =?utf-8?B?UURQeHFkOVlCalFvMCtyYWZDQW0wNHBPa3VhdndpZmhzWlA3UTRtaFBTeWNn?=
 =?utf-8?B?b2lHek1OSWxLQTlCL0dacTA5OU1rMkdtQzBhL2RqaTJYUFJqV2ZiRFhrSFRo?=
 =?utf-8?B?cjE5MDRXMjdZMThieVR2T1lWRkp2VXJRTUFFRU9Vak5ON0NGREFoaVAzZ2VD?=
 =?utf-8?B?bUUzVjZBNVBiWENYSFhkcXBtNUFwS0dCaTdwS3kyVlExSUdOMTJnMm11QXRa?=
 =?utf-8?B?WnB2MVFaMGVuRUhYK3RiWVY0TW1DK0NQMk5SZndWZG9zckViTDI4TUlVSWVC?=
 =?utf-8?B?ZGFETEJNeTVyNUZrMnJ3Z1F2MXplOURLeE9QUzE2OXFwNXB2bHAxclM1amty?=
 =?utf-8?B?ZkUxdTdVQjVIZ3BybG05TXEyM1VabFR4YUl6bjQ3TXM0K05XU3dhalRuTk4y?=
 =?utf-8?B?ZCtiL3NPSGNVM3hCVk1MUldyM3RiNml3bGEwREVNUnhPNWIyWUNFRCtzdVlB?=
 =?utf-8?B?SEc4cWVjSm9KQVVRYkNVOGRyMEJmNFdkK0ZxcGhzMWZnSzNIQTJRMENKWVZ4?=
 =?utf-8?B?KzlDdmRWTDhXZXNucFNSQzlCK3M3bGtNUkZtc1dPZ204SlRtdTZ0dmlRQ2FP?=
 =?utf-8?B?Q3FLQ1lZd3MxR3JOam9ZbUxvYzVCS3lIZkVKWlFXeDlEZW1jcFl5MWN4bHZY?=
 =?utf-8?B?S0p3LzdyejUxYlJla2NaRWNuWklLbXRKZmhaSFVjVVBlMk9ENFdFSHhHN3hF?=
 =?utf-8?B?VisxdDN4Y2J4L2I2amJmTzI2UDR4WElBcG4vR2lFYWVqdjFXNEZkd3V1ZjE5?=
 =?utf-8?Q?JDoAFH151EwlCAvgGQr96SofQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fead4d1f-d239-43d1-9c52-08dc7b167913
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:52:43.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCHiu5mwLjQRPhsD1YTiENzc6dLVUyFVQ8xGIff3/fBpt2t4FtvYhJs+u9FGqkbYrw7bX9r93c+uvF7rnmwvlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 14 ++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

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
index c460afaa76f5..0d74995b7049 100644
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
@@ -184,6 +186,14 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: ele-if@0 {
+			 compatible = "fsl,imx8ulp-ele";
+			 reg = <0x0>;
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


