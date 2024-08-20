Return-Path: <linux-kernel+bounces-294165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC1C958A31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E5DB21CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C121917FA;
	Tue, 20 Aug 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eHK4aPyt"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58E8F48;
	Tue, 20 Aug 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165633; cv=fail; b=AokNvDYDW13uk4/7sMjHaK6onLQfYigvT0cWZ6sPdnXIEoP+SFZU/eaDB+aPlQxRre8HWcJfoTM+8aoCfWLSxA5+wcOVVaJ7y4EZtoxBa2bb1Ge9I6qsdF5yl4+b3TcI00OyeUqCbQRznM9l41ljAZbOikYsX764c8QUucKjfjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165633; c=relaxed/simple;
	bh=2sjJw5uG127xcqw1l2KHsZwRg9xsxxD1mEbbFCSwwt0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FXb3aRWpu3WmPhjXjOYqUHMwhVOFazMAwk2PLvD2drc6YITOiui9K+ChefD6vzOOxRyoE7qIU0rqsD10wbCkZtB37xKAVxtfe5BUYYDPa/JumJmHxW0bUeKMALlESAPutmK2tTKSYt5Aq8Mrn8tsimI+AVuKJxCXNQNYwD0vG7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eHK4aPyt; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Czq/ks/vHbOQn9kUUFi+fsmSu0+tFGefXzPoEG1KBommuIdCRlZKObq11jaReeuKWnbHqD4p/15mJyMq8wi0A2YXT7UHPF6/wGRNnnvF/6cF6mGQbVfgSD5T6gWoE/xbONBkJqLvhu2dnx4B+DyoD8oCecLqsbfV/k5O5Kgi9scZTF2hdMlgrhoyBV7oyGHKjWB9MELBLoZv9iq+w6/hgvzl9x4Md2tqRZZ8IUpydJrFE7G8JFjF2XXP2lg4Tvm0d9beCWmLkWMVjsaXz9bJ7e9BRlqrhWohW4UNQTQ5LfhOnmGIWs9NdN6HvkwaVKAvYwrsNuF8aJWv99zLyJCoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1kVs+gqtqzSgb7sgIwo+ePwdQGn86dd1fLxPLW9sfc=;
 b=uUNA3sJVSh3a8uExCEyKt4l02P4a7zKbRADS596bc7Vlb55DYz71s8bcZnQr8K02/1Rs4/vh2hJJPj/vw6ATUpbxjKj+cIvxzBKN2YNDUYucKn5vNcvMCM0o6KvYlQIsV3WAARQXEuoodTzK4D2HAibxG12a+6RojtFqGTHxR/OwVlxPazrHWaz8QLKBcx6xRCSv6l4JU+qNS7imSWvEf3uD4DYYpiX41mAGTwFuALumD6l2rMm2SP1tNczQNREaIQQcUaM1PjFXC28Uc3z1LHpYTsa+aSouWY4PCOBxpzU8v/mPp7OxsPxWWh8IRCX7mHXyiNx4/00ypb5gna44LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1kVs+gqtqzSgb7sgIwo+ePwdQGn86dd1fLxPLW9sfc=;
 b=eHK4aPytt0XfQnG+Y+YZqQL+lKQLahrJUf/IwMTof9P2dR/rWQEBIzQumN/6G3/oB//FnbOPLwalFjgFhi2Z25zWNXvxSvRGmtKt3SOzRJDTbLT0WJQshlMLaIMfe6Fj1mBlslvnM2xPN/EcY0ZrLYW07LSLvEuffsnorB8ZTsDQhSKxNkJDBAdEBJBI7FyCQJ6lzARIakcrXaB/xsa7m3WWulkbLBJeRxjdqCVbMMGmKsFKvNh1hMad3qU8nLj1eo6E6apBDcJWzYOPwDs29Dasa3NDCSMAxsF7u44+ZfyXkdK7NBLalIsqfPD+0WhqG8HYSgk56IvQrM8TbzsUeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:53:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:53:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] arm64: dts: freescale: Enable wdog_b trigger pmic
 reset for i.MX93
Date: Tue, 20 Aug 2024 23:02:38 +0800
Message-Id: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+wxGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyMD3czcCktj3fKU/HRdS9OUlKQki0RDYxMjJaCGgqLUtMwKsGHRsbW
 1ABnXYCJcAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724166168; l=770;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2sjJw5uG127xcqw1l2KHsZwRg9xsxxD1mEbbFCSwwt0=;
 b=pUwx58udZGOOrEshkPBen0eADlY5PlIKdiXsz+HXCQWkW9Z77xDSMDz7dwj4g++9im1UgBID/
 vvhUgy0WYzUDkjWGyEVbpNgp3L1oaxE3cvUpf9CbeSgMs1yheiEUGRV
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ad02fe-5e37-4d53-2a75-08dcc127e542
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJuNEtlQ1hYNXcySHlhcXFaNW1MTzJpQjNpQmxYS3gwbzFzcUVIV3FDSXRK?=
 =?utf-8?B?M2N0dk5JakJzcGx6bjdjejVOOGdjMkp4cW8vNERyS3MyS0FYOG9FMHkrN0xO?=
 =?utf-8?B?ZWhOc0QzSUFibnQ0N3NpSmRFcUJhUUF4d29VQUZCMzQ1ditkUWV1MTRISjBH?=
 =?utf-8?B?aVU3dSt0ZGtHbnVnUnc4QzFJY3RuZlAvZExUMGpiamJPMFhmNEJCdzYwNExi?=
 =?utf-8?B?dzZ5VWllQUM5bkt5OGhhQk92dlNqdVUxcWhZRjV5cUpzaXFFNGtERlU1c01h?=
 =?utf-8?B?UFJDTk5TcnQwRVhyV05HOXFWa1Z0OGRLT3pBOFJKeHJsUG11eGNqdHZCTlRM?=
 =?utf-8?B?NW4yVVlIdlVEK0ozbXFNaE90TnVNZHRxK1FJUU9HWWdiMjFlSGt2a2hqcGZB?=
 =?utf-8?B?SC9SSGZ4Wk5CMzdMNDQzUUhKbnJKSU1pU1pHQk5aYk5laWlQN0dWc1FRbnhN?=
 =?utf-8?B?R1g1RUlEWVZIR3NUcTJPeHFvRVM1WTZHZWZwK1IrTUJIdDA1RFJKamRQNWxV?=
 =?utf-8?B?cHRtSHhWS2ZzdGZCU1VWb0NPaHJiU2VKdnJDR3ZEZ3B0VHh0ZWtZTU0zcXVa?=
 =?utf-8?B?QmV5MEtEd0JTQ05ZWnpBc3g5ZlQ0NEgwZy9pQXdUVTE0YmF6Ui8vbTAydExN?=
 =?utf-8?B?WWtJNko1NTNVRXRUc1lsRW9JVUYzQ0FmTHJlRDgvSTBsUjlZbUwzMnVSQ3hC?=
 =?utf-8?B?Ty91VFZ3V242LzFSeGRHUnh0QkdKRENSQjJzU0pMZ01pbXhVM2tpU2pSVGJV?=
 =?utf-8?B?U05lUGpMMWc5dlhIQW8xWFp6RENoaldZWERNVjM5M1dYbm52NXgxK1VNUUNh?=
 =?utf-8?B?Zlg5a2JGWU5mNmFmOHJCMnpDSnh3YnNLZ2JZWGxIZURZRndybUdVeEl5MnhS?=
 =?utf-8?B?dFVHbTZscGtzdE5zajhnaDI4K1JtUTZuZllTTXhPMDBDc3dtaFhXQ29ldFBr?=
 =?utf-8?B?T2haN2ZxWStaSS9wNitBRmxKMGNoRWNmTHcycUlJN3lrdisyODVyUkJ4TVN0?=
 =?utf-8?B?dHRWRFpRRVZWR09aYkdXNjlZRGFwM093ZTNJZUtBUndOSnB0Wml4M0VJTE42?=
 =?utf-8?B?eFRNZWFFOXBqQWs0Qjg1N0pETEs0MDZncHRBNTk4aWp6WkQ5R2NpK01TVUx6?=
 =?utf-8?B?UE9SUFNiUTJSMTJBamFISUV4Sm5VbFZHZEloSHEzaW5RV1huT01rZmZzaEVT?=
 =?utf-8?B?ZW1Pamk1SnVCZFYxbWYyc2w0bkFIL09hN3d0WjVvZzNoVmpwRm05WXF4VkhG?=
 =?utf-8?B?UEpkbGNlTyt1bnREdXQ5WDRpSXRLNmFXbjIyL0FDcVAzV1hhSm1GZUNnNzU2?=
 =?utf-8?B?Z0Nyc3NyWW1Id3FTQk5hdEtTWEk5WHZBZXg1UUNQSE1hVGEwRzVwSjMyM0NE?=
 =?utf-8?B?YmowWTBVY0ZmWkx2WmJjdi9YazJRcXV5M3pDSWZWUG1ra2J3dHlpQXVPaVho?=
 =?utf-8?B?UzExa0lQb1hvYmFNNmRERGwwc0hmVnY1c2RlVmYxK1ZvZXJuTHdwb0dpcFNP?=
 =?utf-8?B?dVI0UVQrcEJ4RnV3cnNxZDlmblRUMjdXK1QrNXlFMVNvWDlheW9GQWQ3WDBP?=
 =?utf-8?B?UDUwRWxZd1RIalpqZ2owSHJmMUo3S1dpRHVzM1A3RXJOK2ErcTlCTW5YMTkz?=
 =?utf-8?B?dStzV0oxRGpRQ1FtdVN3UGVYZ29nOHBGL2tTc0RIWEcraThTVk1PSTQ0ZU9q?=
 =?utf-8?B?dU56djB6MjROelpCYmJOdCszZ1MwY0grOUZwbHVUSUsxVDh0a2tPUnliRXV0?=
 =?utf-8?B?THRLTzQrSlVmRWJuQ2VnK0w3L0JHN1Bpa3NVY1JJQ2U1cXRBdDRKVG93N2Zp?=
 =?utf-8?B?TVFJZ0ZMb05wNE5TL0hNUFJsYlluc040SXFCZ2ZNK3k2amtteCtGa0ZLOGY1?=
 =?utf-8?B?MVdxa3o0dEZHWUxUUUpDWjVzazN4VTdKRUxxSDlVM1RFd2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW50V2tHMWJjTHBibUZsa2lrcjdFZDFCNjBpZjhPaUhPTzNMN2hUcEpiV1BV?=
 =?utf-8?B?MWlleFhSM2I0RlRhSE5OT1BSc1NXMjEvNTdYVnd5TExkeWhMY25JMnc0MG52?=
 =?utf-8?B?Y2RoY05FQmNxU2E3RG9ER09NdXE1UDZwSFRwbzJmS1BaYm15QjUxUWpHZG5J?=
 =?utf-8?B?NFZ1c0d6V2VJY21vUURNRjJuVWN4dEdSOUtmVmVGQ2ZxUDEzS2FpZHhuNGZX?=
 =?utf-8?B?a2tEZU50Y21qTlByL0tvVmsrMDVMeXdWTGRiZGFWOUQzbnZTVTE3MDFVejli?=
 =?utf-8?B?ZWZ3ck1YcFY4alJqRWNJR2o1YVpPVkFoNzEweVgxYWFocUI2WnVVY011eEpS?=
 =?utf-8?B?MmRlMDJNSnBKTGU5RTBCcFVlV1FET040R2FPbjRnRDEzMGQ0dXoyd1BtbkJv?=
 =?utf-8?B?dGZmMWNWbmNab2Z0QlIwRzdVVmtGcGFYSmlDWlhOM2dBWFl5a2krL29WMGZj?=
 =?utf-8?B?dGtYenZYelozeWN3WDRONlE1UnduZnFWTG83bGVKQWxpVDAvdWN1MVFwUEdn?=
 =?utf-8?B?OEZ5M1oyaUVncUpBdW92ZTFPUjVKM2IzbnRYZFFBRDlQNElPMkRKOGZSbnlZ?=
 =?utf-8?B?N3VkcGRnM2hkNDRwSWxQNGdYOXdmRDJyNDFVQUtURnA3UTBWTytFZzd3a1ZN?=
 =?utf-8?B?a1dBWDlVYkptYlBCeHgvMUFla1ZWak1jODVRUFdOVnRwN3RlQTV5dVdkMUk3?=
 =?utf-8?B?S2RjaWNUM3Exem1oRHg2amdoUWl5YmJ6aDJsbVVXYUFzdURxZjdUckVZMmZP?=
 =?utf-8?B?ZTJZeG1xK1hjT1dNM0gvNnF6a3M3aVBRMk1BQzJNbWNZVlF4UDQ1bjZUVnNX?=
 =?utf-8?B?THVmcGZMaUFSdHlrOFZUeEY0ckx3a2N0Tk4wQUxJZ1YrTHRHU05iRU5ZdmV5?=
 =?utf-8?B?dnB6dk0yYXhEeDNobDlsRkdIUnJpL2hIZmlLbG5HWTFHaTQ0b1NkbGIxa2du?=
 =?utf-8?B?TWhvNUlCdnlUNHg3cTNMVkphVHRZMk9MM0NhN3ZxOUxOUlRveVRIMndITWU1?=
 =?utf-8?B?dFJKMjdubC85OTRvd1l2TXkrN0M2LytMWmhKM1Rsd1gyd1Z2VStHcmd2eVNH?=
 =?utf-8?B?UHZvQ0RPN2t1Ni9DaHFLYkdhNXJJYjhhOTZEaW4xaTJneFhYU0dTaDFjVlF0?=
 =?utf-8?B?anozamtYdklVd2hwWElNS3d1WVkvNjBPemE1Q2VJVWFoYW1MUG1TYjJKOTNz?=
 =?utf-8?B?TjRhWHl3a3M1eHIyZCtGTklWRGEra1ltbmJBcG9aN0FvY1JBajVHckdMYnZt?=
 =?utf-8?B?WFE4OXQxUzFiNGd2Rm95N0NJYllIQTgxQnMya2lDYXQ2djI2eSsrNUpoOGZi?=
 =?utf-8?B?RWt0dEtUZjVtY0VhbWJ1ZW5LZGgwY3BkTVVpbkVEdXNwUHVtM05JdVpsWVZD?=
 =?utf-8?B?VDF5VG5SSHJsY3pmbTAzcVB3ekJLcDlUZkxkVVFuMHFVUXR1UGd1cm5xVG1k?=
 =?utf-8?B?dlB2VkR4QnV0YStuMHEzNHhmeW0wdXdFd2VyT3BBWWYwb1RsMlFhSEpuL2lz?=
 =?utf-8?B?NmVnNFU0Zy9YbHJteHJxODVDTmJpalpTNlp5Y1FRd1cwRjNtM3E2YmxGL1NN?=
 =?utf-8?B?alNIT0FVaHNUMlNWUUt4K05SbW01VFFPY0J3cmtiV0lZZ0txUmlQQ0hnNTVs?=
 =?utf-8?B?ME1EdnphZW11S1FwWFVCaHZOeTRrblFNU21Ndkl0L1FWQ25uNDBRajB4aW9V?=
 =?utf-8?B?QS9YR0tQVjJCREpXNGhmb1B4TUhzS3NFUXVFSFpod3l3azRYUmJjMkJwaVJT?=
 =?utf-8?B?dzdFZ04za0RRRnJvUFk1bGE1YlUyQmN4TXVTM3NDMjM0bWV0dzUySnFyN2Nm?=
 =?utf-8?B?TE52UkIxazdRK1JxWHU0aG9LQVhMQ2VzM05CWjd0WmFHd0x3YXBmOUtGT2hk?=
 =?utf-8?B?UTVVRG01YktDQjF0dFloMDZsWXJkcm5Yc0tweXAxZ2lCcUdwaTRFVnc0OWlj?=
 =?utf-8?B?UlRpaUp6YklvNzBzMDNjMHNhT1gyWHZmQk9aV3dZS1lYSTJGT3hZcCtxQ1p5?=
 =?utf-8?B?MlJRWFh1c1hSUzNqZlNTcmw4Rkd1L29IQlNxcFJLL3hmNWFQdCt4N1B4MnRO?=
 =?utf-8?B?cVR3SzlocnBDL1RaSWlGeUJMTjgyc3UxakNocUNYeG5SNTYvZCsvY253Ulcx?=
 =?utf-8?Q?BfNxax6DUx5T+Hwyjpxn7k3Wa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ad02fe-5e37-4d53-2a75-08dcc127e542
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:53:47.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfkOuv3vGW2+GaZas8euTnxe4qTWC5Fzxm15Xml+9fLZXd/n8NVtzltx9QkrmgsIWhQJTKz710RqZ6hpc+67rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

Enable WDOG_B to trigger pmic reset for i.MX93 11x11/14x14 EVK and 9x9
QSB board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      arm64: dts: freescale: imx93-11x11-evk: enable fsl,ext-reset-output for wdog3
      arm64: dts: freescale: imx93-14x14-evk: enable fsl,ext-reset-output for wdog3
      arm64: dts: freescale: imx93-9x9-qsb: enable fsl,ext-reset-output for wdog3

 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 +
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts | 1 +
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts   | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
change-id: 20240820-imx93-wdog-95ddbb8a1342

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


