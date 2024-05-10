Return-Path: <linux-kernel+bounces-175826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F68C25BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491721F22C51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43111304BF;
	Fri, 10 May 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nk/NAfob"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A412CDAF;
	Fri, 10 May 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347815; cv=fail; b=AJQyWwezbmE9TtZK9vFq4RVj1/iRe+vKsnptZbxMHOJX6Eqo79jUJkE49OlqpRwcuhzPoJEcthFOlrlB4a3oSvBva9sQSZ0zmdYESHFosJqz35+itDHavn2cB1rOFQHsmX7CC3UC7p4JItH3Hcppr3CVoGu/YiDn650NjLoR+xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347815; c=relaxed/simple;
	bh=AXZXvqE6Gxblm+aJPPtZQPhQAnao9xEnzL1eD8DvzRU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bUscYdjVCEl+7e1HqMO9MGWrvWn3W7+u7khMjajAl3OOWnmLOuEzvtLk5ZYtw5hQOqWM4duhXPw4+61Vu4okmz+mjJQ8QgqeEfEAyzvd128NI8SJhUSgWwxhSZlER8PseXnMjh6ipc8VG/wxMCVuI37yZUL013cSsAC6bvJbfcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nk/NAfob; arc=fail smtp.client-ip=40.107.8.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnqDbxZ3Ar9kdjHShCiGvHERKqcRKrG62FvtSxHZU8zUu1AGB3zb0UqWFMIVbBHf9xWi0HQHOp6mTfbjDgSmIlR7FTIbrVosHpB9ZDJE5wy2Bfn5Jsq1Wm4Yp6XPrJTz2vidvqEVVwm01de3dPKfiooP6Xl1wi3JAcVOqBkZGmiNwrVwOyTbTY7t8N35kWlhCQOqiQgis67OLFdJbh7xOxJv1T/m74vJdo9CeCT3JYyRWRvLcUWZPotrL3OM4JxbWQQnVj4NbGqUsmOEO7WTE7eOndB3Mbv77UKBY6MnBMwP3Lsv4UP6xyyW7g93S0MJHoIBWKTXGJy7+WCfLiOZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ9qGOFX5ulJwTcvjI+Pfd4VCZkt7u7tmDdmYtVimYI=;
 b=PTzbGZ5fQN/FU+inPPRbeRrhXT6U4ALZTCnpz5lt0sEVzXqEaQiodTJ7EVv246558V72hajdG7aZ8XS92vvKeE5NgM7XZ4GwDMa+7LkE4ihy+U1/ESUW9FTiMYiuwqOUIKH+lcgkw8giqYusF6+6G3D1OzJT0nTZLbceHGc6zIBJq08w5nSP8DXBwkszZBMV/aD39owzWFcxe5edtsWDMN/Eq+1sqBV2JnzPMnILdIPQPrW76F651w0flPaaQdhOvG8bxVwwkZwpvrPA/cau1kSewBK+pZF5sg91S3fVrPbgEKAlvzz6hWG1hg9Rqzd4MmndESfyloOGCn+3Gpj0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ9qGOFX5ulJwTcvjI+Pfd4VCZkt7u7tmDdmYtVimYI=;
 b=nk/NAfobYwRkc6pYKNyvcVuLMKYqEhyUrrFNDpDNuSzaUBT+AOfrpD8vjJbn+LSyIdV1Uso0m5K1oWPQHpd7HKhreOoF6fScXNSk2WAP1mDqIVVMGnTEbcqbVp2v0nrhQ4vKuVXskIjY+e510tSOO7d/BAbqfTxpkjMDOeg/P/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:30:11 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:30:11 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 10 May 2024 18:57:29 +0530
Subject: [PATCH 3/4] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-se-if-v1-3-27c5a674916d@nxp.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
In-Reply-To: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e323ef5-cfb0-4fa9-a8ad-08dc70f550f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzgxeXJOcElLRVpXZmppZWtWSDd4bEFuVERFZTZPL2d4Nm1HbXU2QTM4cldr?=
 =?utf-8?B?ZEc2c1lHcFl0bllXZVZ3dWdmN2ZUdWxZV25MOTNrSjNLWHhTekFTQXVFKytH?=
 =?utf-8?B?SDZvNDNOa28wSGg5S1FmL2N1RWs0QWw2cklyQnpla1pDT2gxa0NMM3N6d1NE?=
 =?utf-8?B?MFEwUmoxSDlCVjVJRkNZOWswUnZKOFYwbGZQK0dJSEx6YW5CN09NNW5jYld4?=
 =?utf-8?B?YlZsejc0L2F6UmhaaVBlaHF3RzNyRGM4V1BrOGJZN3g1UXV4eWUreVRNaGpv?=
 =?utf-8?B?SW1UUTdlVVRLZFZ3RnFCbXhsM0NpdDBTUy9VZ1Y1V0ptRWxNbnpMZUVFeXJN?=
 =?utf-8?B?V2RrLzc3VEJ4UkVvdDVnVVV4cnpEN2M1VVYwcGY1UFpOcVZkdURVL0QrMzlo?=
 =?utf-8?B?TlhPLy9LSklyVytNMVMrQmN1bEhXdkFFaGx5MkRFdkJydmkyK2ZiYUlmSTlv?=
 =?utf-8?B?dkErUVc3UkxOQ0FoeE1XVEtJWkFkL3BmRzhvRUFmellTUHlQS3lmS2dpYlE4?=
 =?utf-8?B?aEhMMFE2dTkxam8wY0UwbGpxdldWQ05kZnVuZ3Y2TEdyak8rUVoxdGd3U2Nj?=
 =?utf-8?B?anp3TWJvSWt5YW5INlI5MUpKc2lLcDUxUEs3eWM5Yi83bnQxQmpMOFFJdzRM?=
 =?utf-8?B?RkxyZnJFbmN4MWx6dVd5VXVrS2VqOGhyNmJ6Nk5pdjB4MEN4NTFJRFpQdkY5?=
 =?utf-8?B?ZWdqbHhnb0JaRk9yR2VVbXZ3MnJRaTRabUtjZ01FNmFWZjlRUkZuQTNwUm9Y?=
 =?utf-8?B?M0R1SFpyRlFSNFA3L0lMZjlMQUZHSFYzK3FNVVFXWFJCMnc2clN5UEtCZG5w?=
 =?utf-8?B?bERNMTdyYllWTlZZNE9idGlzT1dXZ2dIQVNSVkZkZDFBUWRXSWtBT0g0TU1t?=
 =?utf-8?B?VjJORlR3T08rcTMydWdsMzA0dzBMZktmaEhEQXdtNHBKRTVGY1Q3NVQ4OFVV?=
 =?utf-8?B?Y2RtQnliYUhnVEJiRVpZQjduUjM2cTR3ZXpJUlNuT1ZKSGhGNEhraWh2L24z?=
 =?utf-8?B?UGtnclFrNVRSdUZBT3p1dmFEOElTbjNQeUJheC84ak80djBubnltYzRRRlc4?=
 =?utf-8?B?WExxZ1RtSWFtOVpRQ3VXWStQZmNiUnNDK2ZFUGo4cU81NUMrdGJxbzVDN2ZL?=
 =?utf-8?B?d1E0T1Z0VUJ3Y2tOWGVLcTl4VitMQ3llSU9xMWo2OXZTem5oUm5rQ1NGdXFN?=
 =?utf-8?B?ZjZJdElzd2dkMGFmMENHY3dYa3ZaY2ZmSDhMNkJLUzhub2FtNkF4TmQ0RTdY?=
 =?utf-8?B?WStTK3ZxUjZUUElJWm45S2cvbnhkRHlKV2Z0TktaM2I3R3c4SnJaRy9uNHV3?=
 =?utf-8?B?U2tQWDFteFNjL1ExbnFvMVdqakhDcHExVlN4bzZMcVo5NzQrR0J2dmRkcWNW?=
 =?utf-8?B?d0k3Qjh5WWZtRXhucnRaVnNoc2s1RDBuMU9IWlpoYXZtTEo4M0hmM1c3bzM0?=
 =?utf-8?B?QUxGQWtldnZTSjFNMzVoaEdiRFVBNUF3U3pqMWtXOUVKYlhvQXgzUmkzV3Ar?=
 =?utf-8?B?bDN2eXFlYzJaY3ZJV3NjVTZRckpoV0p6SlROa1paZDNvVCtHcE04TXR1STN1?=
 =?utf-8?B?SnBwL2owbzdlNG8wRlJjRTZCazRpamNqeGtROElNZmQrMk41RVFZT0ZQc2ti?=
 =?utf-8?B?Wk5hRHdBMGZPQ016UnlQNFFscE5QOFc2MFdib2E5R0tCRUx0ditPRG1aQktx?=
 =?utf-8?B?U2dVMzJRcE1ETTVqK2NLTG13WUpaUzE3YzJ4S2l5NUlPajhTcUZwQ0lGL2VX?=
 =?utf-8?B?QnVlRWQxWEZIVnNFYW4vaXR5UU9UQUdzbi9rZURoNFF3aHhFakUxYmx6ZWgy?=
 =?utf-8?B?VlpBTFVnQVhlOGtuTFc3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0ZEVWw2ZFZYaVJCZE1lSWNlK3ptejBtR2ppWForaEsvaTNjRjhCSGZFL21n?=
 =?utf-8?B?RWcxSHNobXVGcjZ1TExLNzliVnE2dnIzaVJ0TDQ1YUxOMmJZWHRRR3hiZzl6?=
 =?utf-8?B?bElyRW5hRWdVWTRhUGNMN0FSRWF2NHZsbUt4WHRkbDNQaWl4R1d1WlBJMWxK?=
 =?utf-8?B?UUxSOG9yTlNadytzdHlMUm1DSEZFcjJwM0ZUZTkzcGx5eUYrZlAwamd5Y3NC?=
 =?utf-8?B?cjhWcDd6ZjQvVWNaU1NHQ0U1RGErL0IwZWhyQ2tJNEk5L0ttZ1hPamV4d2Mv?=
 =?utf-8?B?b0pteHU0ZXVmMnhTQkNhRWl1Z0p1TXE3bFJ5SkpwemlxNVc4RDV6QnVwbW93?=
 =?utf-8?B?ZGlkRG1Tb3BlcHAwd0dWNWlQdll1bnhPMnhGa21oa2hYRzlqMG1HZmI5V1Rx?=
 =?utf-8?B?d0VlcU4wWlVZK2VWOFFkMHkrU0FWZGdyMU4wUE5XR014Sk93YmRMNkdQQ0Yw?=
 =?utf-8?B?bHptbEcrUDF0Nk9tR1dtWVNVd01GdFlScTRkd0ZVMFFEZGpuSk5zUk1SYXh4?=
 =?utf-8?B?TEhEeXQxMFN1YTBaSjFLcElmRXFyY1BRV0FDL1g4UDNHTjcvY3pRU3dOelQ2?=
 =?utf-8?B?YTVsRENkSXBieWZjQmQ5SGd5UGpYNXBLVVZhSy9XM25sUVQxV1FuT2QrMlhi?=
 =?utf-8?B?ZmNGK1pjRmVDK3Y5RkJmMDhvUXorMFozSEdETXlPUUVxcUpjemlIR1NNOFI5?=
 =?utf-8?B?a1ByTEFQbytHWXB2c0U5SE02OExScGRlTUxyeldHWWpDcE9MaFhsSDdIRkli?=
 =?utf-8?B?THNienJ6OW9PZThHSHZ1L1dZUkoycjZ2TmI2SVRHWWZoWkd0eklaK1ZQZ3hy?=
 =?utf-8?B?b09vSXl6cEV0MEk1cWxiR25MRjBXWU1MSXEvU2FIeWZkbjNWaXNUS3YraXgw?=
 =?utf-8?B?S3VLNGNJL2tCK040RkRnWElWRy84QjI4MlpISTd4Z1B3a1ZxQUNnbzlQU3ZJ?=
 =?utf-8?B?aWlvQ0d1U09XcGVQM2pWak50UlBPZHozTVVjdEtKRzFCNTFSUUg4MG5pdCth?=
 =?utf-8?B?U0VzL2ZtcXFJN25jdG50WEFLVDBsenYxaDFna2Y4NjczN2pPOHJuTGt6NVFy?=
 =?utf-8?B?RVNjUnhubHp0VjQ4dWc0bTVoSlkwcGdXRllNaHpWeVFWOEZUMFZHZXVxSGdG?=
 =?utf-8?B?UzhMVC9mMWVZUXExL1l0K2lCaDY3MFNhVlVSWHBoZmlDQmhNZlBpY1hHb09P?=
 =?utf-8?B?dmVtMmszaldTN0ZUdExLTTNOOWFhQjZmVHpxM0pJSlhsSUZLWk1MY3FzZm5J?=
 =?utf-8?B?TVY4NmVybC9ySHgyMlpmeVJuZ3pGU0ZRU3oxWWRYeG9ibVRYUjhxK256eXJN?=
 =?utf-8?B?L0VnOGRWTGpjWm02WmF5dkt4QkdjUHJGdHU3YU9ZcGNRTEpETVRCdVdrNnAv?=
 =?utf-8?B?Q2o4WlB4T0hCVW9kdFhreFdSNW1MVTM3dThxSU11Y2liN1ZRRUE0ZGwvK3VP?=
 =?utf-8?B?cVdLdGJ2NStWdEVQN2NBbzFyMmNnVys0cFJENnoxUDRISW9ZWFpvN2dmTmpT?=
 =?utf-8?B?ZVZiYUtPR2NWc1JXTnhMNFQzOFF4dlJIWGFIWjMyWis1NldjSXRFRVZqSW1h?=
 =?utf-8?B?L1JaTWZLRHB1SnFHWGZJUVExNjRoS1dpbU9kSk1xSEJQVnIvaUtKcUh2ckRW?=
 =?utf-8?B?dDgxY3NHMmZtb1JHUlJwaFBwMUUzVE53UWR1dlBPWDBKWlJkV3lwb0tqVGwr?=
 =?utf-8?B?clc2VHBpRUFkRXU0QjlocnBlalJ3bFo1TmcwNjJpYVNtOFZLYiswbzhRaE5M?=
 =?utf-8?B?UmtoM2RrWk85bWVKWll2Tm5ZTUdHMnMwd3NCcDdNczlmcGFGSFZCR0M4VnJF?=
 =?utf-8?B?dklmSVQxKy9aQVI2NFQ4bmRGRlArcEhpWEJDNUovUnBVOFhLd3g5Z0lsckM4?=
 =?utf-8?B?WlZRSmVPVEg4NGxZbGhoWGM0MmFMMzAzL1BTVzAwM0kxS1BYWDJTT1kzdEhl?=
 =?utf-8?B?TzN5ckxPVDVBOXg2Y1dQNTJmQlI4bE1mRUg0eWRHYUIzeUxmMzRqaTBnSmUx?=
 =?utf-8?B?c1JoanVselMwTmxOL3VvUk5MSVpSa1hwUEhGZUo1T3FtSkdOR0xBUGlhYXlh?=
 =?utf-8?B?QXlDWG5tendWZ3BxNkZwRGRzSjh0eHZsNXA1WmJYYzRFeWt4bU9udkVlRDJD?=
 =?utf-8?Q?ntZMnBcAD0MRyX4N+z9m56qwZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e323ef5-cfb0-4fa9-a8ad-08dc70f550f0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:30:10.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve4fq1Q1GJP9veTw0BH1SGNKkeem5zAVtqQm5hPRUrabEYMpMtr/Cgg5fUPimuRgtlrBJZrbrd08Aqtr5dkvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..bac08297ef68 100644
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
index c4a0082f30d3..fc00f05fa166 100644
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
 
@@ -184,6 +184,20 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele {
+			compatible = "fsl,imx8ulp-ele";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ele_if0: ele-if@0 {
+				reg = <0x0>;
+				mbox-names = "tx", "rx";
+				mboxes = <&s4muap 0 0>,
+					<&s4muap 1 0>;
+				sram = <&sram0>;
+			};
+		};
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


