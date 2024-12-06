Return-Path: <linux-kernel+bounces-435605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDC9E7A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D429B1881814
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0819204581;
	Fri,  6 Dec 2024 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hf5DwuEr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DE1D222B;
	Fri,  6 Dec 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517189; cv=fail; b=mJ6udhU0B678UFyocsYswmfx6ljNJ7p4Tj2BOzcM3OgBGrMpNWMMMDMq9cyELISEXX8IPUkW6mrsw97sXCw+98ccUyYzrcLHcxf9LUPHnrLYKGgohuLRd9rGVOeaY8zeofxFatgBBsNarX4gDmg1kxoChqFVvJvh3j92dGj/tGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517189; c=relaxed/simple;
	bh=i3dcSqogjyuNNtm/jysadkQJ+VCYRGt8e0x4rlyxqkQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=khapjI2VI7xTQfdyuYlefkmDKGPdmeU/shpPznmn6RGsptlkyG0D/Bjvl39+NfWbzckbzGBYxAHOBoMRct8KgWdE3yXDo0vRi+hnzKLW1jmCEy/XXsJNbM84DtB75jXsimrKwlKcpacdNYEq0+ou1sn+u0jyVREpKHjKRk5YBuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hf5DwuEr; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsUFtpu0RW7LL9gZIp58UjjxTcJNeitntvC/J/rpSj5Kh6u92i9UUoFsTYsTPHOG7oDX/alP2XM/DHDKMjUPJI7e0m0jT5okUkkf3gYVoEg+WLu1N7WbPZx4EzzazrGSgv/6PSTWJB7uM57t4z28O7kKBqq7vRYZrqtImkIrKPboIUom/+h4IKM4bxoZ3wc3joJbfJGiZuJ1zcPV+XQeDgUf5nKotw043NOkTLsophKmx6w17hGlbTzXE8uJ8xC9d9I5eLkdasBO6/KPBpk42UmLKp8rxZdwa32gRbay+MnHp5HZ86eKeA2pqvVGLbNCA3/hqSRMSuGaRxZEvzQejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhiTsZy3Nho0Qgddk3k1/rpqhcytpYNom98fFsY0bAE=;
 b=b31T7uRR79rkU7ypgR6MwVYKYo7UBd4EXPjLiu/CeSbhb1QPNGyeP74+tgjUGe19RUqvonBiPFESGyiDNsK++vf5bvhBcGnPc2+Hh1uLCWytrwal0K2fFfH52vFHQ3S8bJTSJ75I8bbKkS19tgiuSAlAjxfBktt7fSpNh2ORQkSUhnFZa2x6PbKilMyPS5l1JSqOG1xADpBtKqAKF0LK13gjQJGtO4CLQjHrILrsNm4Ox0UbVkm74iGexnqaMu70asqnQQc5/A2VXZ5a4z9uUHbxto8hQ4Kv2awOWwQjY5EMVABVVSfy9Ulyj7MK0b4STsdMvF91wLTjlN1564y8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhiTsZy3Nho0Qgddk3k1/rpqhcytpYNom98fFsY0bAE=;
 b=Hf5DwuEr7unFoMgegOScbiEIS2Pf63e4UqiWcMUxGQeGrPkXDrhDtStmlqxI89Q0ySt+UNmGXDir1+oA0HjBe5SdXXFlWF5iNBmN7Xlfmq8+nmbVmue/YV7OkBlC01PwvR+MzXgdX0LiKADI6zKA5UIqhYLz7zOhrxDN7HL5MRuNAx0T7O1HAtHeAUbTCoFutclb1TZQ5zvI7gH4JwGJtF9k45wc/dTFWdwJN1+kgkVNLo2WBBSd9hkUlU62fLe4qSMTOTRyfQBLHx1kEmuqQjvYbhPWUx0zxgQY7CNeBzTv699yVyIUkWIN5x2fKk5DDdQBHXA6UCSJOLT3mIh6Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 20:33:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 20:33:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 06 Dec 2024 15:32:40 -0500
Subject: [PATCH 1/2] regulator: dt-bindings: pf9453: add new PMIC PF9453
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pf9453-v1-1-1e4685114271@nxp.com>
References: <20241206-pf9453-v1-0-1e4685114271@nxp.com>
In-Reply-To: <20241206-pf9453-v1-0-1e4685114271@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733517178; l=5519;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TAA5qXpRqILSuanf30/8Y8A28VnSDJGJ52xrfZmqhcg=;
 b=s2PDemboU8j5ZKBO0pEvG+oOwpqMNYFOKNMxPUg631U39d/2bjNOmONAit0HCxojTWVrtsYI/
 AzFN4E/eiqrByGX5544p0YFensYqN6Y6jnRyV2YUaDKIyuQM+ZYx0/G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10297:EE_
X-MS-Office365-Filtering-Correlation-Id: cad1acb2-5b73-4e03-10a3-08dd16352f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBCdXFXMi9oNFBFeXJhT1hYVE5WdUcxT3p1cE4zUDBsRDRzSXo2RTBqNm1k?=
 =?utf-8?B?aHIzaURwNHI4Y3k1RUtKRjJtSTU4b2dUdUptQjljWmdiTE5FaHN5ZjdTcXJx?=
 =?utf-8?B?bU9RSEZRc2RYN29PM2VxcWdaYWE4TU9acW9qMFRwQXRBS3FNWVBVU3JRbXpM?=
 =?utf-8?B?dE1aUWNVQUtKVGlJYXBZZUphYXU3UUdTdURwNXBHZm1MTnVCNi9sUWlsRHlo?=
 =?utf-8?B?NDgxbGZIT3d0L3N3eFdHbHBZdGFPNTdmSGFKUEdoVnowL094SmRvbTNRR0Zo?=
 =?utf-8?B?V3hFdmNqSEFHWk0wb0QrNVFJMzBRT0Zmck1wdi9LZFNJcmVPY2s5WGRhQ3Rv?=
 =?utf-8?B?T3lEMUVna1Z3V3BEcExMYUZJZmo3b3F3S3lwNW93RjlTb1UwcVJvRVlMVUtw?=
 =?utf-8?B?WjkzdFJBOEZjRnoxQkl2Z1FEUFgrZWliTVdkYkRQV2NvK2lsVTBkeWUwV3lk?=
 =?utf-8?B?OHFrUFBYY3NHRHorZ3o5UnlNQXNmUnRkQjFHdFVDa252WllaWUdlUi9mRFUv?=
 =?utf-8?B?Q1psTlhzcTJ0dVRRT1NwVE4xc0NGT21nbVc4MlRjVFV3dkxZWjBZNmdUbG1F?=
 =?utf-8?B?eFUwYlNTRzU0RWpNZWtsWW1SeFZjOFMxRmVybkF4eFgxNGJXS29ndllwNlc5?=
 =?utf-8?B?TkFvR3p0c1FZTUg3N3NtTDRtUjdFVkc4eW5HUHJGMUlESUJ1QXJCc21wa1V4?=
 =?utf-8?B?VGRPUEliWUtJcVlrUXlKcXhXWlNKUE9yMy9PNVZaNGQwZVJXZStvdUVqd0JE?=
 =?utf-8?B?SUZLRWVBcGowcTQxbVlUUkdEY2djMDVmS3R4TnRuWmk0L1BXdXVjNTE5Z1Q5?=
 =?utf-8?B?cnhHcGVmWDRUbzBXL2NHQWNOd2dhMTlKS0NwZVRiNzIraUZxaFovaVN0WHky?=
 =?utf-8?B?SkExUkhBb0hBb2NVaUYrTEV5dTVoNmxYZG1Cc1ROZ053N2FjZjNGd0xoL2xl?=
 =?utf-8?B?MDBDSUJJL3pBQ2hPdnpQVFI3VmZucGFaVUlsQTNnUjkyTWZWOWx5bjQyZXhW?=
 =?utf-8?B?a055THR4YTVFM25JczF1cTVUY0NDNjVXc1UwUGpZRmxIRWcxWllmclBhWm9o?=
 =?utf-8?B?YnBtazVmN2JUL0c4dmFmZ1VQTjZLQ1p0QTJ6RG45MXBFYVZ1Q3pOTjlCUEtN?=
 =?utf-8?B?TDJkU3FlVFJ2U1hDdU5BL01BbXRlbjAxUjlvdVpnQzVsYWhkanhuSjNZQ2pr?=
 =?utf-8?B?NVg4YUhlamRlRkZpem1lajZuc2NWN2hoc0tvQytZTTF1QzZHWERpcjBCaE5Y?=
 =?utf-8?B?THo4MXgzZ0dvUjlkVVFoRFBqYjVxQUtBUU9nbmUxMm1EakdtQ1JVYkd5NlJu?=
 =?utf-8?B?QTFBTWszRmpFRjJ3c1REODN3bHJJUk5va0JxcUZnYTlKOU5YS2Z3WVJvTHVJ?=
 =?utf-8?B?RTAxbUNvZnpUMGhSR1NkVG1MRnFodXB4bllhTnFROU1sQzc1Z1Y3dm9rcWRa?=
 =?utf-8?B?aHhlMFZmamF2UXB6ejd6M3BEYjljQm92Wjk3bFhaZVlGQXJhbXBBYS9qbEpo?=
 =?utf-8?B?ZVJPVGQxby9wdUwrRGNKNmd3blBib3VSNU1paks3UGlCeVNmWXJ3b2ovRk41?=
 =?utf-8?B?dktqd0tVR1RyZVlpRmREYnk5c3grSGw1MGhrNzBzc250cU15R1lqRmFWV2tS?=
 =?utf-8?B?OXJJSW9TZGhxNis5dHZFTXZ3alBwOHNaOXh4K3VLbFdLVW5XSFlFTkhJRitH?=
 =?utf-8?B?elJFUElxK3RKczZpRTFNMUk3WGpwMVVEa2ovZW1VaDZQT3BWdDhHeC9EalJz?=
 =?utf-8?B?RVc0cnEzVmpuempLQWlxdVFRSkdpMnk2c1EwZ2lvanMvbjVHL2J1QUp2Tjd5?=
 =?utf-8?Q?RxmK1pnyoIto5I/ZAZUfjtgMq6KzjYH/xhJ1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNGQS9pdE51VnhobW01aU43MVMxT01FamVlSkFpbWlTMnl6V004b0doZjVW?=
 =?utf-8?B?eW5wVnhVaVdlZUkxM0oxRkE5cHpSbFpPUmVKbFFvcWtqaDJxT1dPZzdmcFhj?=
 =?utf-8?B?czB2Q2tFRW5rK3lWZHpWVk1Ob1h4SHB5S1IzVXhSWURpUXhQQzVQb3JWQ3dU?=
 =?utf-8?B?RTYvTnBmVGNVNGpOSCtqTDdUYWFDakFGemJxL1FWQnZ1c3lWaS9MRFM1MVA0?=
 =?utf-8?B?d3dDeHE1V0hxNVpjbzBuVk5BREdENWJnNUVhQ09zWkQvWmhtRjcvdGkvMjQr?=
 =?utf-8?B?bXF5bk9UY0o3Y1Z1VE5KQXRIWnduU2thR0VtNkRiMDBrdVFreDJvNDlRZENl?=
 =?utf-8?B?Y3ArbC9NR1V6SWpQV3NFaWQ5dWRmKy9MZVJQTWo5K0pxVUVFV01waVZHUlc4?=
 =?utf-8?B?dk1DYkVweVRuQXIwQlBwaXNxZEkza0MxMjAwbFlzSUE1dnFHcWJBd1hZdUtG?=
 =?utf-8?B?YXFTNmN5dm5qdlF0b3hrd1VmUWlqVGtKZjZrZjdiT3JjUXNsdng2cTVXQXUz?=
 =?utf-8?B?dlozdHQydjJxNDdDWHE3dHlvOWpjeUlzakoxNkhVVm1GbFlLQThkdEhEaVkv?=
 =?utf-8?B?N25vUytHdXJ0UXVRd0huNU1CNloxZmh6UE9GaWJralh3TVZzWkJRZEpwdmFD?=
 =?utf-8?B?WVRiZFkvd0Z5anRyZjJ2OWZwNmNtNUNVNHFnTmtORkJBTUFicHVUY1ZxenBB?=
 =?utf-8?B?T04vRGFaMWp6aVpVakRSdFFCLzdXRjhJTm54eXlUOEhZMkVzM1AzeTNqRWFw?=
 =?utf-8?B?WGFoc2hRU3BBeU1CM1AyVlhNcXduSEpaaytyNE1IZTA2RFlUNS9VZmFZUkI4?=
 =?utf-8?B?VHpDR1dBWkFXWjNjaE15Si9kYUZVNTUzWDFFazdLcDlWdHpQbXVHSEcyS0Rh?=
 =?utf-8?B?OG0rZWVnNFlxc0xVRW8yNTc3WkJ0bk83ckZoWk4xb2dkSGhkNzBCUTVRRWlu?=
 =?utf-8?B?K0VqTlZBS1dXaUVWVEN1YllyM1BqS3puZ2pSMXZFNkdVSEI1YStzYzRmSC9J?=
 =?utf-8?B?dVVLYkpvc2Y4SnY0bTBFd0NUWkRmVisrY2NoOU8wTUZ3Q0JpZTVUeER0dG4r?=
 =?utf-8?B?R0QwaHFPMk5RQ1NjNExoaTFpR29FWnNBWUxYOERSM1R4MkRrT1FjSGdyRHUw?=
 =?utf-8?B?d1V0U3U4U0NUVmNzc3NObS9VTExXN2o0cGx5UGNhdDBzV0FDays3dFBSallo?=
 =?utf-8?B?UWV4NU1sSEl1anR6dkJmdVg0cHVTZ2k3NGhOVVBzTkZDak4zQXRWdStqd0Yr?=
 =?utf-8?B?M25iRlVRWE1rUDRLeGIwVzQzUUVvSTVkN3NKSFpoWjVSdjhKMThwK3UyQ29a?=
 =?utf-8?B?V1c1RG1lSmhWUU5ySy92VTRlZGNzSmVoczdGNk1uZ01PVXE0V0czTjhxRkJj?=
 =?utf-8?B?Z09FSjJjMWVac05jSDdJWnJ2VnNaYmRUT09raUZmRGhQczhpTUg3cnltcmFD?=
 =?utf-8?B?T2ZHSUVVUUV0UmVNS2IveG5xNkZvRHFpV29BY1BoNnRUVTNTWXQ1ZTc3Y0RC?=
 =?utf-8?B?c0x4WGJDcXVFYjhHWHV6NjY0LzZxcDdxbWpCMC9NRHduNkZYNHRuYWZRRVBS?=
 =?utf-8?B?NGN0ZE96dkEzTFhMbmFIaVQvckwxRkcrMEltOUY3dC9JeVFSNnVEY2JXMlZ2?=
 =?utf-8?B?WVRlbFdpdXlKbEI5c3cwaitVUEkrN2JhMDF0VzJhVUN5ZGN5ZVFTRXp6bk5D?=
 =?utf-8?B?QXZic3dWUk1lU0RZVkJaWGRWSzYya3Z5UkdwbHJVRXVESGtnZ0d0NDdPWmwr?=
 =?utf-8?B?VC93UWxHZ0t3NjM5ODBMUGtWWXBoM1BWUmxST2FWZzhhNzlJSk9tWlg2UUxu?=
 =?utf-8?B?OVUwZW9MZTN4cTB1TjdQekN3T1lybjFweFZxdUJsS0E0dVFRQ094a0NLMFpM?=
 =?utf-8?B?NTI1K0NmZWlJYjZ1R0haMmJNcjBjdG1MNmpSeHRPMlJxaXB6c1Q1Qm96cm9P?=
 =?utf-8?B?NVk4U3ZKZXlmR0hhSjNvQkMxRUVMbGFiM3VHeFppRFBydTNZWU5TOUljS2FJ?=
 =?utf-8?B?SUNsTW16WkdoN3J1cEVDMXArU2QrZEt1RmczazQwRjhpay9STHlqUTBHa3Yy?=
 =?utf-8?B?OUYxN2k4eFgyWno2cVZxUTl3ZzF3dk1jQWdRM3NQSXBhVW9UOXBBQmJrSGEw?=
 =?utf-8?Q?d4by0L0aYgwrdJmLRBbTn9hwL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad1acb2-5b73-4e03-10a3-08dd16352f57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 20:33:04.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5WbfBUsmxY2DGxT9N2TFSFoZ3/yE/b6eWKMfZdL2VKryMFMzAZAY4hTvSd6Qj9bkV11+r2zbrmfs3vuzr1XdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297

From: Joy Zou <joy.zou@nxp.com>

Support new bindings PMIC PF9453, which is totally difference with existed
PCA9450, so create new file for it.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/regulator/nxp,pf9453-regulator.yaml   | 158 +++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf9453-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf9453-regulator.yaml
new file mode 100644
index 0000000000000..07e9c3d3efdff
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf9453-regulator.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf9453-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF9453 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Joy Zou <joy.zou@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf9453
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: list of regulators provided by this controller
+
+    patternProperties:
+      "^LDO(1|2|_SNVS)$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO regulator.
+        unevaluatedProperties: false
+
+      "^BUCK[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single BUCK regulator.
+        unevaluatedProperties: false
+
+        properties:
+          nxp,dvs-run-voltage:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 600000
+            maximum: 2187500
+            description:
+              PMIC default "RUN" state voltage in uV. Only Buck2 have such
+              dvs(dynamic voltage scaling) property.
+
+          nxp,dvs-standby-voltage:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 600000
+            maximum: 2187500
+            description:
+              PMIC default "STANDBY" state voltage in uV. Only Buck2 have such
+              dvs(dynamic voltage scaling) property.
+
+    additionalProperties: false
+
+  sd-vsel-gpios:
+    description:
+      GPIO that is used to switch LDO5 between being configured by LDO5CTRL_L
+      or LDO5CTRL_H register. Use this if the SD_VSEL signal is connected to
+      a host GPIO.
+
+  nxp,i2c-lt-enable:
+    type: boolean
+    description:
+      Indicates that the I2C Level Translator is used.
+
+  nxp,wdog_b-warm-reset:
+    type: boolean
+    description:
+      When WDOG_B signal is asserted a warm reset will be done instead of cold
+      reset.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic@32 {
+            compatible = "nxp,pf9453";
+            reg = <0x32>;
+            interrupt-parent = <&pcal6524>;
+            interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+            regulators {
+                BUCK1 {
+                    regulator-name = "BUCK1";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <3775000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                BUCK2 {
+                    regulator-name = "BUCK2";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <2187500>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <12500>;
+                };
+
+                BUCK3 {
+                    regulator-name = "BUCK3";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <3775000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                BUCK4{
+                    regulator-name = "BUCK4";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <3775000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO1 {
+                    regulator-name = "LDO1";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO2 {
+                    regulator-name = "LDO2";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <1950000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO_SNVS {
+                    regulator-name = "LDO_SNVS";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+    };

-- 
2.34.1


