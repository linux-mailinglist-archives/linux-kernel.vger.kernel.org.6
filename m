Return-Path: <linux-kernel+bounces-312476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFB969724
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D28283CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBAC2101AB;
	Tue,  3 Sep 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="thOY1Vo2"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21A1D417C;
	Tue,  3 Sep 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352381; cv=fail; b=s1utB3ztt1FhNEwK6ySaR2jk8XPdF69wbSM5DOeDOmF2TgobPJjdkEKk5d4BgW9kSIPFA4XLc6ZHKcr0IPtbIWG7Ou6lBM9sY9NeHs0XF5LlNSXZ/UXfkBBqvkbkX62Jo1mndQn1gHu4/wzSSPX4F1ZJ5SOHpy0QS6z+zYBqP8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352381; c=relaxed/simple;
	bh=+iUc/sKdzPVM9xQQXn9Zy+vxC/oSXd7eo76zq87+fhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOs9FuFFrdo2E4yndOZjqmXFEKyKjRk73B1dTURuhaH894jMnG+rxB8244r/05XJ9jJ0w7fGKELxWo6hH6hV2CPCB41eH5023+2bFvmxfzf6aC+F1gB0xobq0LFCqHdOJp1GTJkPdqo7xnag1RXQsvaAWHgWyyxJGd92L/Tf300=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=thOY1Vo2; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l21FrsmqcN4VISfXXbJWdegLcyTA0h5pU7YrU22zZU1hMJGc0roIfVByyiZWQAIMCDpZPlyFCJdu3Y6jobond517mm2jVsjtbEU8UfXPcwzUrtLmbjqAVWtNTnpBPVZSiioITPDEYYmrtEqzTldYmQOssdm7cfPmr37GogT3H1YaUsbiHwMQbSYSq0RyvO8YBlP6HvUVpYtb5Wp9DFDgczgxf+0GIC543xH6IteVh8Gyp3aJCckHvdYuPkGbPsbMPRQ0+nvVqnK2EoJdrp4mfDTj4XXiGpwRfLuEQducZPUxdhs9YHVJJ8VAJehkNeTrFvcjuvMmrDSDV462g+9n8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iUc/sKdzPVM9xQQXn9Zy+vxC/oSXd7eo76zq87+fhw=;
 b=KB2PH7BHsspt125Mfuy15N0Ed0gKrFDvSmf5rtnpKqKTZfDotsCY/sT0Bp5eI368Nk51mlzDdw3S/AQ/I1rMpWQ+Jwf+76RsD+jtODP9IH5wPntG08QEa2HanTTowy9DwdgTsUD4yZpHng791/mO64qkBMkDvWMJ1WUJemnk6FLQ3c+dYpKFbIOeLSZOpLm02qE0Vue/Ei2gfQ9WMIHYslJIBtXE283TV+54O+ZZ33Ns+M41WBDTx8MimutmyQ7TXQQYsf4BHt8gHcx6JeZjiH2+7rJ7h9w8LxELx4uHkcBZ9toByr16NDO5eBLSIiF1qwEQ+Ejm3fQEG+DU9azlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iUc/sKdzPVM9xQQXn9Zy+vxC/oSXd7eo76zq87+fhw=;
 b=thOY1Vo2RJQ7tHL35JNLcWytxyXSlCExPNhN0n0tyTzNXQHra6wOm/gmewPiYPdtQ4klHWE0TNS1s7NPKJ3e4vG5XZqulJ0Woi5bsx1OpIKRgCjuZPWRuc/7cGlC7sLLdaFaY2Fg1Wxl3hlkXv5JYIhl7HF+vUcDpdeM8TrHyps=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:32:55 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:32:55 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH 3/3] arm64: zynqmp: Add thermal zones
Thread-Topic: [PATCH 3/3] arm64: zynqmp: Add thermal zones
Thread-Index: AQHa/dve7MzGT/lzZUukzSd6PQlDZA==
Date: Tue, 3 Sep 2024 08:32:55 +0000
Message-ID:
 <LV3PR12MB9260AC14D997DED122284940E2932@LV3PR12MB9260.namprd12.prod.outlook.com>
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
 <20240812215129.3599832-4-sean.anderson@linux.dev>
In-Reply-To: <20240812215129.3599832-4-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|IA1PR12MB7519:EE_
x-ms-office365-filtering-correlation-id: a2a46c5d-63e0-4d0d-4bdb-08dccbf3021c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0hPR2gyS1BZRDFlTEtPZ0F0QTc0OEF1ZDJKOUFSb3VOZmlkTDNZWGF3R2kr?=
 =?utf-8?B?bVdIelBYclEzemU4MGhrdHJRL3l3YW9qQjN2dG1BSXpZM1hmcEpQR1BhQUVV?=
 =?utf-8?B?Uk80REh0TlhNekxZaU1FVGE4ZVBIWDl6M0JJUHFoVzhwZzZXd2VXSkZCK29F?=
 =?utf-8?B?M0l5NkZhS2doamlrRGh1ZW1Jcm50MUZhaURvempKV28vcmZHbG5BRUh6cXM4?=
 =?utf-8?B?ZElPNHVQeEwyOUpvM0xmeCtmbVp0aHhPdTBWTVlzdUxOWE9yeVJNbzc1ZGxO?=
 =?utf-8?B?STBVTHZjcDloY3VmbUY0TXFEM2lPVzZ3YVd6ejlvWUZsM3pDSUJ6V21ENmVT?=
 =?utf-8?B?ZlJlOHFWZUJPVENRMHZmUTJucERXZUYrQS9XbTRIaUY4KzdaQ2tiaVY3WHVH?=
 =?utf-8?B?V1F0T2xaT0pZVU8xUE81Z3pucmtoM3pwOWJLNGV5MU00V3djbEpVY3FWVHBT?=
 =?utf-8?B?YlVWdDZoRExxeW14U3B3cnRZcGlDZDFCcUgxbFpCcVNMdTFjdngwQXk4RkJz?=
 =?utf-8?B?cWlsbHFBSXRHUzVHYmJzZm1DYkdRejVMOU1pTEJWbUZBQTgvc05JT1RXRFVU?=
 =?utf-8?B?ZHNUK0JLblk2VG5rZGQ0Tmlrbm5hRmxXS1dYQWhyOFlMb0xWRzlQUWJqdjVi?=
 =?utf-8?B?bmkreXRCa0Z0WFgyYUFuRlVCUlZJb2h1YWl4UG5HOVMxNnZvWDFneDZLOTJp?=
 =?utf-8?B?UHUweWNhUzd3VHdjdlR0T0xaYkxpcTNicWxVb2trRndjeVpNM2ExT3BhRkdZ?=
 =?utf-8?B?MWI0aS9oZzY1RFhjaTlKTnAveVJmTy9ac1VrNzkzRXpxbDdmVEJZc0U1LzQv?=
 =?utf-8?B?MUVWUGJXZmhBcnpPcVdvbDQ4VDZlTWRnSmlFa0Q1bGNuOXJxYktLY1gxQlh6?=
 =?utf-8?B?WTdFOFo1VnhVYm1FTTVQT1cydHdXTnZSK1UrN3pUY3owOVpzaFRIWk1jalB0?=
 =?utf-8?B?QWVsOFFMNHZ0OHVBODdqandoZ2RYNzZLUmVSbnpBaHpnYXYwd1J5cmU2OVJw?=
 =?utf-8?B?TDFrcER1KytWSGN5OXY5S00zVXFUWFdjRjRsOGVRbFZ4N0FKQXd4UzVRMnM4?=
 =?utf-8?B?NW1DR1BhVzJpN1JnUlVqOWNnOGpaVVYzUEFkTGVnS3EvZUdONXpZakNtQkt0?=
 =?utf-8?B?WEdpaS82SXZVa0wvNSt4Q0tIaEY5UGtTU1dNN2J3U1hNdlpteHdiTy8wbUFE?=
 =?utf-8?B?K3NUS2lUSDNEVjRiVnR5ODZqc0tDVzhmZmZZTFhQUndsM2lTZ2ExRGJJUW9k?=
 =?utf-8?B?MmJodkMvRC9nQmdQbHlYcDY1a1JpZzhlU3hCaVVNOVpud0ZKcDNZWGVnMTkw?=
 =?utf-8?B?c3dWQXhoYjhib2t3SXFUVnF0QUQ3QXBuWlB2dzFxcHV5a3RNcW11MzRqYW1L?=
 =?utf-8?B?MUZJckl2SFdkcFl1U2paY0xWZ2hCa1QwQWNuOWhOejZRM0JuSmlmZCtiL1RJ?=
 =?utf-8?B?QTQ5ZWtOc3pXT0xPTTN2L2w3WVFqdDBVek1lTVZnMGV2Y2IvSWpDYjIwTlFK?=
 =?utf-8?B?dnNiSldIc0hzREZudERzRWVwUWRFaEIzM1BaRnNFaEh3ai9SeFFoV3g5ZVc2?=
 =?utf-8?B?d25YWE1xYWNpZ3FIV0RuZTFKN1grUkZsWnNUMmpqczNFMUVPcWNUNzliblR6?=
 =?utf-8?B?K3FTdktOUlhGZnRUY0dONGdwSGMrcW4wcVc5WCtMMFFQMHVkSmRRVEJxL0hz?=
 =?utf-8?B?WGpnVDdxdkxzT3hKK0duYmhEa0xRRC9DdFN5WFJUdHFXT2lsVk1uWmlvWlBx?=
 =?utf-8?B?UWo3Q2thRytXeDRNNEx3WmdXNVRZNFA3RFJoUVkxcHk5V3NKMzFvTjFJVU4z?=
 =?utf-8?B?ekZEUTFLdXkvRXhsMHNrak9haVU3SXpnWVNqcUV4QityRjg3TXVSNkdCWjly?=
 =?utf-8?B?M3VsQldUOGViNlNGL09XejYrd1hoYTlqVXRldE1aTmN2N0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlVIek5jQWczR21QS1BvNFVNNGxEeDJ1bS95Zzhtd0xCTmlyUVNpQ1VuN0VH?=
 =?utf-8?B?UkdkVWNpVWtUS2FPc21BUFA3QjNKM21ybXZScWlMWWgvRmVlNEtuTVgvd3J0?=
 =?utf-8?B?ZlVqSUZ1Q3g2cTJ3d1I3R3g4RytzV3FtbjlHK2NuNWh1WVB6cGxCdnNNWnBX?=
 =?utf-8?B?TUFFZ2FtelRjVk1xWFZodEk0YTZQOVRocklmR3l6UTRxTEtaK0thQnRLejFh?=
 =?utf-8?B?SFF4bzRBS2JaVlpmTHZGUTVPYlhXZC9JcjBqcnhhMGM5V1k2ZjdLdEwwYzBR?=
 =?utf-8?B?UHlLNi9OanJmUkFrSkNEamhNM2swRjY5RmI3SjQveno1SXVQeHpvTlFNVWx1?=
 =?utf-8?B?cXZWenpJc2tad2xjUzBmcjZ3cHFWb1JmTUY1dm1jMlkzSXp3Wjl4U1pnSjM3?=
 =?utf-8?B?R1RSTFVxblkySG9ubGZRYi9scHlQN0swQ2c5Y3Jnam9seFczdHZYdndOZGhE?=
 =?utf-8?B?U242bFJnekxMdVZoRkxUQjIydVBRTWNsMGNhTjRTR3hkTnp0WERkeWZGSzBz?=
 =?utf-8?B?RVRYbEZoNTFDZUNVWTFZcjNlaHJPN29YNERQalVyd1VNUFV4WTlHSkpDVzZp?=
 =?utf-8?B?ZEhuSWdVNXIwbktBejZIcXErNGpZRnUxeFQ1R2xlemk2aVdsN05iY1VsaGxS?=
 =?utf-8?B?WktzNkZpYm5USW1NQjkySXhIZ2Myc3lKMEVFYXo2bjF3NUlOaTk0YjlUVFNq?=
 =?utf-8?B?Nlk4R00rRW00ZmExZE9MM3J0TitlcE9LdjlIMHNwYXEyVzVZWGhUc3dYdVVx?=
 =?utf-8?B?Z3A3WEluTjEvQTFmelhlQkRtWHRpNUk1K3Y1Wi9HK3FOeDVxVitCMWs3NFFK?=
 =?utf-8?B?ZUNNMXNvNEM3dThIM3dlTkhlRHpTRXRHbTZrbGJycllEMEZTTm9KNjgzV0xn?=
 =?utf-8?B?WUJFYmxOUk53Mk12S1dvYVk3eTdobDkrb1V2VWY0SjJLVEtrOGduYXkyOWpW?=
 =?utf-8?B?OEpWOUdyQytWa0dlbmpqckV1cVBIcUhlN2VXMVVYQllDNmpFblJQMzBCQ3hI?=
 =?utf-8?B?WnRpU1JnTlhnME5nMFQ2Qkd6NXAzY3FJZHV5eit2ZkJGUUltL0tTOWxxaVlo?=
 =?utf-8?B?dUNXZTh1UnYwQUJvZ2pPUmg5ZGxreitiVG5XNVNXc1BrZy9TT1lvR2JCL2Zw?=
 =?utf-8?B?VTB1TWw3MlRueFNJVzlXTzdxS0FOcHR3cEhYSVNWemNEajgyZllNY1JISVVQ?=
 =?utf-8?B?bG5RcDZuQkhOWHJZd1N5SlJ6OXhQUmNXWXR2V1JDeGtQOHQyZWMxaDhsOUk0?=
 =?utf-8?B?OVF6T2V3MEloaHlpM3M5emZiVk9DUTEzZzhqOUZBY2FqRzk2c09QOHJNUHR3?=
 =?utf-8?B?TndSUk5XaEVvMWdhQXJCbEUrc0t4aHBadE1YczVOV3M2cWNWWC90ZWJpenR3?=
 =?utf-8?B?cytXclIvNi9QTm12bVp5RDUxTkdPVjRWZGZlOHVsb2g4MkV5ajFNNCsydnhI?=
 =?utf-8?B?NlMvRk5Lc2dyZE9uQkNXUXYvY0dJMFBFcnlqS2IzUGx1Y3hoTDhJcHRuaklB?=
 =?utf-8?B?TzJ0c2VnVUp3RVFaeEYxV05ucFhOTTFzQndjVU9NSmRrcUxzcm9wa2dubVR1?=
 =?utf-8?B?SkhjRlJzd1ZaRWhGc0JYbk9VOFoyZWh6bmQxT1NJS2RobTh1cEFYL2sxb2VO?=
 =?utf-8?B?ZSthLzByZTNJR2tLTWx2Q2NvTGlHblVpMGZGR2E3VENydFVjTHFXNDNRRVRC?=
 =?utf-8?B?SWhxalFUdkw3M2c3R0d6UCt0TnYvK2xuVFdNT0xlaXowNWw4RnVFNWFWTnZJ?=
 =?utf-8?B?UGlQLzFqSTJqREROanhXeWNDNzJwd2k0MitYK0pSSm5xOW5PaGY1NXg3UVVW?=
 =?utf-8?B?cFVCZ3ZZMHBhRXNnVnUxVVVwL256UGRIenhBcTFRZ3lwd0lEcDJRalVRbm8x?=
 =?utf-8?B?SDRXa1BPYjRIZ2xsZFR0dWpNb1gwMllMbGoxTE51SjFPWnRRR3NrV2dPdjdX?=
 =?utf-8?B?VDhiVm91YVF2YytMMi9jUERmNkxabWEzNzU0UW5oWlpqcm9vNFpOUFNrNUUz?=
 =?utf-8?B?cXRVSGpWL1NKbDdneUZEQjFTUCtpeW9UUGNYaE95SWhoazZDbDFiSWw5Vlpy?=
 =?utf-8?B?QlIzZmlaUUxQMmM3Ukxrd01NYlJPYlUyTFVZMlBNbGd4d0o0bjZXUTBvZ0I5?=
 =?utf-8?Q?1PcY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a46c5d-63e0-4d0d-4bdb-08dccbf3021c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 08:32:55.2113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuVzYlgcgxhp8EG5VYqQC+kInNtULZFpYh6gv77/GBxHOu3EWOvv42/D2ICh5kjE5jDWHSafQMLJM6EVnFq4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

SGkgU2VhbiwNCg0KUGxlYXNlIGZpbmQgbXkgcmV2aWV3IGNvbW1lbnRzIGlubGluZS4NCg0KVGhh
bmtzLA0KU2VudGhpbC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
ZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogTW9uZGF5LCBB
dWd1c3QgMTIsIDIwMjQgMjo1MSBQTQ0KPiBUbzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVr
QGFtZC5jb20+OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENj
OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBr
ZXJuZWwub3JnPjsNCj4gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IFNlYW4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25AbGludXguZGV2Pg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMy8zXSBhcm02NDogenlucW1wOiBBZGQgdGhlcm1hbCB6b25lcw0KPiANCj4gQWRkIHNv
bWUgdGhlcm1hbCB0cmlwIHBvaW50cy4gV2UgY2FuJ3QgdW5kZXJ2b2x0IHRoZSBDUFVzIHRvIHNh
dmUgcG93ZXINCj4gd2hlbiB3ZSB1bmRlcmNsb2NrIHRoZW0sIHNvIHRoZXJlIGlzbid0IHJlYWxs
eSBhIHBvaW50IGluIHRocm90dGxpbmcgdGhlbSB1bnRpbA0KPiB3ZSBhcmUgYWJvdXQgdG8gb3Zl
cmhlYXQuIEFzIHN1Y2gsIHRoZSBwYXNzaXZlIHRyaXAgcG9pbnQgaXMgcmlnaHQgYmVsb3cgdGhl
DQo+IGNyaXRpY2FsIHRyaXAgcG9pbnQuDQo+IA0KPiBUaGUgY3JpdGljYWwgdHJpcCBwb2ludCBp
cyB0aGUgZXh0ZW5kZWQvaW5kdXN0cmlhbC1ncmFkZSBtYXhpbXVtIGp1bmN0aW9uDQo+IHRlbXBl
cmF0dXJlIG9mIDEwMEMgbWludXMgdGhlIG1heGltdW0gdGVtcGVyYXR1cmUgc2Vuc29yIGVycm9y
IG9mIDMuNUMNCj4gKGluIHRoZSByYW5nZSAtNTVDIHRvIDExMEMpLiBBdXRvbW90aXZlLSBhbmQg
bWlsaXRhcnktZ3JhZGUgcGFydHMgY2FuIGdvIHVwDQo+IHRvIDEyNUMsIGJ1dCBhcyBmYXIgYXMg
SSBjYW4gdGVsbCB0aGVyZSBpcyBubyB3YXkgdG8gZGV0ZWN0IHRoZW0gYXQgcnVudGltZS4NCj4g
VXNlcnNwYWNlIGNhbiBhZGp1c3QgdGhlIHRyaXAgcG9pbnRzIGF0IHJ1bnRpbWUsIGJ1dCB0aGlz
IG1heSBub3QgYmUgdmlhYmxlDQo+IHdoZW4gYm9vdGluZyBhYm92ZSAxMDBDLiBJIHRoaW5rIGl0
J3MgcmVhc29uYWJsZSB0byBhc2sgYXV0b21vdGl2ZS9taWxpdGFyeQ0KPiB1c2VycyB0byBlZGl0
IHRoZWlyIGRldmljZSB0cmVlcyB0byBidW1wIHRoZSB0cmlwIHBvaW50cywgYnV0IGlmIHRoYXQg
cHJvdmVzIHRvIGJlDQo+IGFuIGlzc3VlIHdlIGNhbiBhbHdheXMgZ28gd2l0aCBubyBkZWZhdWx0
IHRlbXBlcmF0dXJlcy4gSG93ZXZlciwgdGhhdA0KPiB3b3VsZG4ndCBiZSB0b28gbmljZSBmb3Ig
dGhlIG1ham9yaXR5IG9mIGV4dGVuZGVkL2luZHVzdHJpYWwgdXNlcnMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gLS0tDQo+
IA0KPiAgYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1wLmR0c2kgfCA4Ng0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDg2IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3hpbGlueC96eW5xbXAu
ZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC5kdHNpDQo+IGluZGV4
IDIxYzFhZGJhZjM1Zi4uNDY3ZjA4NGM2NDY5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL3hpbGlueC96eW5xbXAuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3hp
bGlueC96eW5xbXAuZHRzaQ0KPiBAQCAtMTgsNiArMTgsNyBAQA0KPiAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3Bvd2VyL3hsbngtenlucW1wLXBvd2VyLmg+DQo+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cmVzZXQveGxueC16eW5xbXAtcmVzZXRzLmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvdGhl
cm1hbC90aGVybWFsLmg+DQo+IA0KPiAgLyB7DQo+ICAJY29tcGF0aWJsZSA9ICJ4bG54LHp5bnFt
cCI7DQo+IEBAIC0zNiw2ICszNyw3IEBAIGNwdXMgew0KPiAgCQkjc2l6ZS1jZWxscyA9IDwwPjsN
Cj4gDQo+ICAJCWNwdTA6IGNwdUAwIHsNCj4gKwkJCSNjb29saW5nLWNlbGxzID0gPDI+Ow0KPiAg
CQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1MyI7DQo+ICAJCQlkZXZpY2VfdHlwZSA9ICJj
cHUiOw0KPiAgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gQEAgLTQ2LDYgKzQ4LDcgQEAg
Y3B1MDogY3B1QDAgew0KPiAgCQl9Ow0KPiANCj4gIAkJY3B1MTogY3B1QDEgew0KPiArCQkJI2Nv
b2xpbmctY2VsbHMgPSA8Mj47DQo+ICAJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTUzIjsN
Cj4gIAkJCWRldmljZV90eXBlID0gImNwdSI7DQo+ICAJCQllbmFibGUtbWV0aG9kID0gInBzY2ki
Ow0KPiBAQCAtNTYsNiArNTksNyBAQCBjcHUxOiBjcHVAMSB7DQo+ICAJCX07DQo+IA0KPiAgCQlj
cHUyOiBjcHVAMiB7DQo+ICsJCQkjY29vbGluZy1jZWxscyA9IDwyPjsNCj4gIAkJCWNvbXBhdGli
bGUgPSAiYXJtLGNvcnRleC1hNTMiOw0KPiAgCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gIAkJ
CWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+IEBAIC02Niw2ICs3MCw3IEBAIGNwdTI6IGNwdUAy
IHsNCj4gIAkJfTsNCj4gDQo+ICAJCWNwdTM6IGNwdUAzIHsNCj4gKwkJCSNjb29saW5nLWNlbGxz
ID0gPDI+Ow0KPiAgCQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1MyI7DQo+ICAJCQlkZXZp
Y2VfdHlwZSA9ICJjcHUiOw0KPiAgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gQEAgLTQw
Niw2ICs0MTEsODcgQEAgYW1zIHsNCj4gIAkJCTwmeGlsaW54X2FtcyAyNz4sIDwmeGlsaW54X2Ft
cyAyOD4sIDwmeGlsaW54X2Ftcw0KPiAyOT47DQo+ICAJfTsNCj4gDQo+ICsNCj4gKwl0c2Vuc19h
cHU6IHRoZXJtYWwtc2Vuc29yLWFwdSB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZ2VuZXJpYy1hZGMt
dGhlcm1hbCI7DQo+ICsJCSN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwwPjsNCj4gKwkJaW8tY2hh
bm5lbHMgPSA8JnhpbGlueF9hbXMgNz47DQo+ICsJCWlvLWNoYW5uZWwtbmFtZXMgPSAic2Vuc29y
LWNoYW5uZWwiOw0KPiArCX07DQo+ICsNCj4gKwl0c2Vuc19ycHU6IHRoZXJtYWwtc2Vuc29yLXJw
dSB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZ2VuZXJpYy1hZGMtdGhlcm1hbCI7DQo+ICsJCSN0aGVy
bWFsLXNlbnNvci1jZWxscyA9IDwwPjsNCj4gKwkJaW8tY2hhbm5lbHMgPSA8JnhpbGlueF9hbXMg
OD47DQo+ICsJCWlvLWNoYW5uZWwtbmFtZXMgPSAic2Vuc29yLWNoYW5uZWwiOw0KPiArCX07DQo+
ICsNCj4gKwl0c2Vuc19wbDogdGhlcm1hbC1zZW5zb3ItcGwgew0KPiArCQljb21wYXRpYmxlID0g
ImdlbmVyaWMtYWRjLXRoZXJtYWwiOw0KPiArCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MD47
DQo+ICsJCWlvLWNoYW5uZWxzID0gPCZ4aWxpbnhfYW1zIDIwPjsNCj4gKwkJaW8tY2hhbm5lbC1u
YW1lcyA9ICJzZW5zb3ItY2hhbm5lbCI7DQo+ICsJfTsNCj4gKw0KPiArCXRoZXJtYWwtem9uZXMg
ew0KPiArCQlhcHUtdGhlcm1hbCB7DQo+ICsJCQlwb2xsaW5nLWRlbGF5LXBhc3NpdmUgPSA8MTAw
MD47DQo+ICsJCQlwb2xsaW5nLWRlbGF5ID0gPDUwMDA+Ow0KDQpIb3cgZGlkIHdlIGFycml2ZSBh
dCB0aGVzZSBkZWxheXMsIDEwMDAgYW5kIDUwMDAgPyBjb3VsZCB5b3UgcGxlYXNlIGNsYXJpZnkg
Pw0KDQo+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zX2FwdT47DQo+ICsNCj4gKwkJCXRy
aXBzIHsNCj4gKwkJCQlhcHVfcGFzc2l2ZTogcGFzc2l2ZSB7DQo+ICsJCQkJCXRlbXBlcmF0dXJl
ID0gPDkzMDAwPjsNCj4gKwkJCQkJaHlzdGVyZXNpcyA9IDwzNTAwPjsNCj4gKwkJCQkJdHlwZSA9
ICJwYXNzaXZlIjsNCj4gKwkJCQl9Ow0KPiArDQo+ICsJCQkJYXB1X2NyaXRpY2FsOiBjcml0aWNh
bCB7DQo+ICsJCQkJCXRlbXBlcmF0dXJlID0gPDk2NTAwPjsNCj4gKwkJCQkJaHlzdGVyZXNpcyA9
IDwzNTAwPjsNCj4gKwkJCQkJdHlwZSA9ICJjcml0aWNhbCI7DQo+ICsJCQkJfTsNCj4gKwkJCX07
DQo+ICsNCj4gKwkJCWNvb2xpbmctbWFwcyB7DQo+ICsJCQkJbWFwIHsNCj4gKwkJCQkJdHJpcCA9
IDwmYXB1X3Bhc3NpdmU+Ow0KPiArCQkJCQljb29saW5nLWRldmljZSA9DQo+ICsJCQkJCQk8JmNw
dTAgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gKwkJCQkJCTwmY3B1
MSBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJNQUxfTk9fTElNSVQ+LA0KPiArCQkJCQkJPCZjcHUy
IFRIRVJNQUxfTk9fTElNSVQNCj4gVEhFUk1BTF9OT19MSU1JVD4sDQo+ICsJCQkJCQk8JmNwdTMg
VEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPjsNCj4gKwkJCQl9Ow0KPiArCQkJ
fTsNCj4gKwkJfTsNCj4gKw0KPiArCQlycHUtdGhlcm1hbCB7DQo+ICsJCQlwb2xsaW5nLWRlbGF5
ID0gPDEwMDAwPjsNCg0KU2FtZSBxdWVzdGlvbnMsIGhvdyBkaWQgd2UgY29tZSB1cCB3aXRoIG51
bWJlciAxMDAwMA0KDQo+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zX3JwdT47DQo+ICsN
Cj4gKwkJCXRyaXBzIHsNCj4gKwkJCQljcml0aWNhbCB7DQo+ICsJCQkJCXRlbXBlcmF0dXJlID0g
PDk2NTAwPjsNCj4gKwkJCQkJaHlzdGVyZXNpcyA9IDwzNTAwPjsNCj4gKwkJCQkJdHlwZSA9ICJj
cml0aWNhbCI7DQo+ICsJCQkJfTsNCg0KQW55IHJlYXNvbiB3aHkgd2UgaGF2ZW4ndCBkZWZpbmVk
IGZvciBwYXNzaXZlIHRyaXAgcG9pbnQgZm9yIFJQVSA/DQoNCj4gKwkJCX07DQo+ICsJCX07DQo+
ICsNCj4gKwkJcGwtdGhlcm1hbCB7DQo+ICsJCQlwb2xsaW5nLWRlbGF5ID0gPDEwMDAwPjsNCj4g
KwkJCXRoZXJtYWwtc2Vuc29ycyA9IDwmdHNlbnNfcGw+Ow0KPiArDQo+ICsJCQl0cmlwcyB7DQo+
ICsJCQkJY3JpdGljYWwgew0KPiArCQkJCQl0ZW1wZXJhdHVyZSA9IDw5NjUwMD47DQo+ICsJCQkJ
CWh5c3RlcmVzaXMgPSA8MzUwMD47DQo+ICsJCQkJCXR5cGUgPSAiY3JpdGljYWwiOw0KPiArCQkJ
CX07DQo+ICsJCQl9Ow0KU2FtZSBxdWVzdGlvbiwgYW55IHJlYXNvbiB3aHkgd2UgaGF2ZW4ndCBk
ZWZpbmVkIGZvciBwYXNzaXZlIHRyaXAgcG9pbnQgZm9yIFBMID8NCj4gKwkJfTsNCj4gKwl9Ow0K
PiArDQo+ICAJYW1iYTogYXhpIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4g
IAkJYm9vdHBoLWFsbDsNCj4gLS0NCj4gMi4zNS4xLjEzMjAuZ2M0NTI2OTUzODcuZGlydHkNCg0K

