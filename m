Return-Path: <linux-kernel+bounces-432571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F058C9E4D20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA486166737
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B81940B3;
	Thu,  5 Dec 2024 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kTW1O4Qx"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EC14A90;
	Thu,  5 Dec 2024 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374620; cv=fail; b=VTL8wO1JvmimuxDqQZimoW65LYbm97YzdI1bBSs0mtBD/08qD6hnMtITld+xFemQ/3jqd12rfeIrivDqEAoppUP1xkGXpyP4+qFygzI4gjycoHSv/dLOfbldH5A9BBnu9Fuat8LQfhSF3HjRRPz+V7ALx6ZupttBk1r1Mb/oefI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374620; c=relaxed/simple;
	bh=ye0Px8Z8s2/SVfmDWTRVZ67goEAONgsAujQea3Yb+eM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nyKGhJdRdxWrxH/ZRD/NWBmBYpxDa6hfAffGD71TNZVNM5EkpaLef87ODEuIdtc7yKdvHeqAVauK0tZvmGkFtyQBf030b/R6kCEpTspqn7pKuW32naoFxzt8JRUAYH0md3PrLebRab2O/kGDKrarp9OAzQ7JMOtwJkqTXmMIH5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kTW1O4Qx; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTTtRmqwfG1qDPXoEDnwVXDUmBtWZkpqmLIQbdjvL8zjYKhQwDyjtb27tqn6NsgzNeVOkqKDDiNlm+fk+t1jO7vZurSjT42QVU4UbkD1rH/O+/mteV3FdO1XP6bsNrONpqNK5K/AgtL0chM6C2+WC/Szb+5qJIWaSUl9rK4OiB9EIHVJ8WWqDeK20Ngq6FP0+FfzeQ7nPc8/BJZC7ZuC/21/apaw95lgCLttYx4eY3s84mJ57W6RSpw3ZEs8SA6Lrb/s9l80RUN99iWKQnMudZ2+gcJClCkFNuvkuqfMiWbaT7THU034/6+tATelM2RKkG1tGtsKc5u/XcVY+GOznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iVW/Qlwy9lp7qpESljJRNndbTTtiVaVKUWesau8r6k=;
 b=Dl0/V/EqzJfvdknYzbKntcnxdRfgwVC3Fnr4U09fHy3JaWVRKA7LHnYzfqZMBirXxJ+K+FU7HKKxwex1Gyhr8NVh8bLx8ie7i0f6QuHCJhYJUT78cw+iPOKYpJ9xtBlfdwLuD93bJp6WWPEy3eHYOIijFUmb7v6xoFA3dDUstmCeY9URVxb3iaDaKYOInrp5WA5Xz/wsXojcjsWBemk2UBwaBQaQcpbrRkrjrqGf0XocVY39xVg/J8UvKEWaUWczHR6wc61SjlZZvpV2DkkymrcbqazL1znP3QXb9KaPv6jlMEy+8HPOqJprnhA7HMpjJvJj5Kzum/lVfqYrc7Ox+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iVW/Qlwy9lp7qpESljJRNndbTTtiVaVKUWesau8r6k=;
 b=kTW1O4Qxoxsw9QwZU6ydXoOxudfU7+JfzKxstZUxhCgE4uKLjcQRoYuF9Gcd/NFYtjxa7IQZfs6ew6MV0oCoQhMPx/TPm9FGHt3eyLRu+IMDlfcnZu0GWgWSKSLSCQKOQI5UoaAAy/dBa2nXvIJ3ZL5Ui90LrxkvadoRoqJQs3Q5cWMveQfHbkBpERHa+wWsXHEwCE2jZ8EPweeM6Dp0rgMfpnIyeuUpLEDnvjeRGvTQCMRO/bKZ13p0qgr+m1+sOHn4RqSjS/MP2e8j0po/VH5Nt5l9Pj5VAv8ZxHTpBsDbnqS70abYAC6DsBXrsCaclgaK4lWG6SyMCy3s2obogw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by DB8PR04MB6794.eurprd04.prod.outlook.com (2603:10a6:10:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 04:56:55 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 04:56:55 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 05 Dec 2024 05:56:32 +0100
Subject: [PATCH v4 1/4] dt-bindings: firmware: imx: add nvmem phandle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-secvio-v4-1-5c37cdc39573@nxp.com>
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
 Vabhav Sharma <vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68f81206-baa5-40b0-0406-08dd14e93cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG1RSzRObFFCd0dzUm9CSXEweE5iU3lYYWxoa0pWNjZvSG01S0hLbkdsU2J6?=
 =?utf-8?B?VGZNOFpxcmhlR3FYNjVqQXpoYUdzTDZUNDN4ZmpiK2VpWkpQTVdNVFY1Qlk2?=
 =?utf-8?B?SHZSakxRZ2JXWHpTd3dVZDU0TDRmSDFsNHZ3SXBtNVpnOGV0V2ZpelI5a29x?=
 =?utf-8?B?Vi9Ock5XUWJFcm44SGhaV0EzTmUrZi94SHNqODBkeXNvcHlFR29WMFhkRU5E?=
 =?utf-8?B?TkJCYkpZZTg3OGhEZ3JBV0tZL01iMW9MVXJobjRaekxlcEg3UWQ5ZWpBRFlm?=
 =?utf-8?B?bThOamNUeHNaM3JIN3IvSE5UR0dzVWhTYnJIOGN5R3dUT2VrZTRiT2FBS2NG?=
 =?utf-8?B?Z1o2aitqMysxOXIyOHhBWGx1MFU5VUhwUWR2aHpuM2dDU2J1YUVlYmV2bjFl?=
 =?utf-8?B?VXRuSTMxQUQyaXE0aGxGK3g0SnFPVllwaUlDRzF2R0g0OGtWQVlwSm11Mlo2?=
 =?utf-8?B?cmdHcEFrTm9JZW9IbDByMmhXVjI5WHRQS2FGcnh5VGptbWNmZHdkVjBMWmtC?=
 =?utf-8?B?U3lPMWM2NXY4c3dFdjd1YU5JcUFZdUNXclJIeEVxRG1PcDlkM1F4bFZvMkM4?=
 =?utf-8?B?elVHV2FwZm8yQS9qRHhxaFJNdFVMZTVKakNWT09iN3g3b1ZQaUhadVdLRzlr?=
 =?utf-8?B?VDgxK2hUbndadjZKVGpDajRSd2hIeFR2TWVMVjQ5Vk1kL1l6K2RoL3FSOGtF?=
 =?utf-8?B?S2lidmhZemVHU0dRaklqK3F3UWpkOWtXeklGVGJRdm5mSU9rdGZZeHQycjlN?=
 =?utf-8?B?d0IySWtPeWFxanB3K01YZk02ZXp6RVY2TXZJelhldmRVS1ZxVVFQY04wa1hG?=
 =?utf-8?B?RWdtS2VmMzhndGRFWmRsUG1UU09nRDBnVWVpaXBXNFdIWk5lanl5U04zeFBT?=
 =?utf-8?B?bGU5eEpJZHhnVkdkUUZkRm41amZ6d24vMVQyeU81ZzdHQTZiY3JvQjdIaHEv?=
 =?utf-8?B?bGVncGR5Umg5SFM0dzJIbEtCWUdacXkvWTdrNnhsTlFmK1QwTCtXRVNHMHRI?=
 =?utf-8?B?M2pqMFFaOWYxdG9lNy9FN3d4TG5nTGpjWUNtU3BMcTlWOUFVYUxoVG50aHJB?=
 =?utf-8?B?cEZ5Sm5JbkdKNEErWEkzaUdpNzBjUmdEMkUyNmJOaENmV1h2NmQ0Y0htQWpk?=
 =?utf-8?B?VmZ3bEhLam5MVTVmdFlGdjBiSjVYeHN6eVk5dXVxVTBYYmpLZlRWamFwQ2dy?=
 =?utf-8?B?bU9MTDZ2QjFsdFAvekpLNmhxbjVvWi9KeTdXNDRlaGtlUW9NYjNROGdYMytP?=
 =?utf-8?B?Q0JRV0hsM25EYVhkRVJqdVQ3ZjdNRmNMU2RCZ2NCdDFNbnV2S3NCaWkvRysy?=
 =?utf-8?B?b1ZDR0pMMVZiMEhlVFEydHoxbDN3RjRxVGFXWVhWM1A2ZlRpOFd1ZUlTNC9p?=
 =?utf-8?B?bHZHL1d1OEdETCtkcGxwWmhmN08reSs4Sy9DT3B2OStHdWU2bTdmdzVHdzZM?=
 =?utf-8?B?UWNUZFE2M2VmRlNraW9lcENwc1REWGVobVdaOVY4UFAzeDNMSTBTK21yVnRH?=
 =?utf-8?B?WnhGTHpWOVltbWdpckhKNkpKaW5lVU5jY1RyYXFVcTBTMWdsaXVycTZKKzZR?=
 =?utf-8?B?R2w1VjFRNkJsTk1lNUpkV01Ia3ZZVHNQYTdhdGpaVDJ1ZGJDRXFacXFoTVNm?=
 =?utf-8?B?NFd0bHlzbGhvY3lNZ0FIR0ZOaDNoV2NsZ2NESUlMb0tZb0QvdVFYNVg3Z3NJ?=
 =?utf-8?B?djdLT2pWMXh3dENyYXlvUVV3SThlbFQ1bGpPVC8yWTNSb2JNVUp2RGZuR1hr?=
 =?utf-8?B?Z1V5UEVaQkpsWXhpRHUzNXU2cjFlNW8zVEliZHkvMHRJR3UrUWhUN2wvbmh3?=
 =?utf-8?B?UDNCZ1NBYVNITkZ2SUlyTlU2Y0F4L29EaHpFa0JvZ1I0WVVOS2o0aDdoRXVu?=
 =?utf-8?B?SzM1MUROanJacjFuSmVqVkc2WUVjdk1uSkRUaFlGSHVxZlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJSTDNFWFI1Qk54WGtCeWN1dTIyd1VYM3RFaXhaajRJSEVjT1VDR3N1aVUr?=
 =?utf-8?B?dGhUeFQ5aTVnSGtpcnFKN2V5T1orZXQrMkFzVmpzMndUNVptVXgvWlBLVVpQ?=
 =?utf-8?B?bEw0QUVVdE94Smp3V1BCenJIYmU1RFRmQmZrYzAvQ0VKQWdydWlWdG00UGNT?=
 =?utf-8?B?L0FIbzd3YnVsRlFiMmZlZlpBajZYUzlmUHJhK1J5NGtzMTI4MTRkdmY0a0x0?=
 =?utf-8?B?SnhudHFLNHBXQlBvd1RCZ2dmTVk2RzEwSTh1S2YxZ1RDSGRjWWI4b0hKdC9J?=
 =?utf-8?B?cllEYXdhRk5BVlViNzlhWDA2bVJob3B6MWVqVlExbTVTL2REZmFoUDM3b01m?=
 =?utf-8?B?TndvM056OWFLQ0s5Z29ibmFCcTZvMFN0akRma2M4c0tHbEVOaXpsa285b3pG?=
 =?utf-8?B?eGF0N2xCaWZUc0xiS0orNXc1Z1FQSkpPQ2NsNFo5TnNtS1lQZm1nazdvS0ox?=
 =?utf-8?B?WWxRVmRSNzVXUjl0NlRudUlHZkpMUmtTM1dnU3JzcndULytwdmVIOTJyZTdh?=
 =?utf-8?B?K2IwNzBsYlduWGgzRVVMYnpuVFduOXVKcGdsQUdWS0JtTmYrVDdHZEFTdVE5?=
 =?utf-8?B?ajFwdTdkL0VZMHBFc0xwb3NQK0hxZE9sNVo3WUYwMTRmVlZMb0tLZERveFk0?=
 =?utf-8?B?OWxpRFdhSDBSWlRLQWNIand5SFNIK2ZYMjVWbHBaZkswWXdxZUN6eEJ0a2Fp?=
 =?utf-8?B?WjlPYVFEeXdJMVZnNzFValFxdzF4MFkxcW9WcFo3bDFmY2pvRzM5dHFIcnZC?=
 =?utf-8?B?Z0owTlJYV20wSzRLdnI3WExRelB5ekowNzFCUEgrSXpNMW5OQjE2N05QVkRm?=
 =?utf-8?B?N2w2dE94ZXpZNU50Z3FaS0hWY0NRZkZHMW05ZnA2NktYT0VjV1ZiTkwxc2Nn?=
 =?utf-8?B?clk2TENtNDNtRnArMVNPbENWUkRUdXJPU01vTlZTc05aL3B2Z2RuMHErQlIr?=
 =?utf-8?B?UVdRaWdCNUMrelJSQkRuZnFRVGRXME1OVGhMSS9UYlhRelBzRmt4WGkzN05a?=
 =?utf-8?B?ZEFaQk9FenlJQTVnRHpCNDdiYnNQazkrOWEvNnphblQyWkF4dGszekR3ZXJv?=
 =?utf-8?B?UE1DNGE5WTJBZ3V3Q3ZYMVZIa1F5Z1FtMjgyemRDZEhtTzlMblhiblBhVFB3?=
 =?utf-8?B?R3FFMTNnV3hlL2lEVUZhOUdaaTM2S0hQdjJaVDRyQVd3MVpKSi9FVTlrTGFi?=
 =?utf-8?B?OExDTk9BOVVJUFplcXBnWXZXM2RLQnpxWGFGRGE5dFlaa2E4ckdOS0pSL0Ji?=
 =?utf-8?B?RzlBTkJyMGErN1JGOWFsaXZLL0ZwT0NYWm9tQlY3VXlva0RuMDBUMmFyZitP?=
 =?utf-8?B?ODl1VUZjL3FvMnZmY1llMkNtSG0vY1BZWjBmaFZlSERSbTRvNU9tdmgxazUv?=
 =?utf-8?B?ZnhIRkhxUUo0OTNBVVdSYk9Fb09GOHVYdDBybTdRTG82OXozM05TTm1weFYz?=
 =?utf-8?B?ZWdyQXVCSzhlL01ORVo5c3VqWGppT054UjNnaTdGVGZBRWVxWHVjQm1WNVlG?=
 =?utf-8?B?dXpSQkJBY0hDNzlIaUYwV2ZGUUhERlhqS2dzL29SY3JkTGEzU0t5bzladi9H?=
 =?utf-8?B?a1BkVmxhWmQxZEU3ZEMrZFJ6Nmh2K2ZwZDVseGFXaXVLV0prckxaMGx6czVz?=
 =?utf-8?B?enc2YndMMStrNis4WklnMWdMcGd6YWY4d09TaDA1RnlhNVNiSktIeTkwbXhw?=
 =?utf-8?B?bzF1bXR5VlpORHNucnRIYWF1bEhuRnF5R0RBU1FKamg1TWNMTnpGOGpPNFNT?=
 =?utf-8?B?eUNXRjdEOW1nazlOM01tZDdLdkdhVkRlNlJLQngxT1p0bXN0ZDdoMUs0MTFs?=
 =?utf-8?B?VVpEZXpONkEveFlIQ3F4V2lJMmZHN2FqZnBtYWY2WVVqdkxGVGFLVlFSZzd3?=
 =?utf-8?B?ZXl2bjREWVhJNU5BVFNJZytxR0t2Y0pnaVFvYUViMWxTZjFxZmRTUWdzcWxD?=
 =?utf-8?B?N0srRVovdVhYdXB4ZTVCVlYvd09qazNiQ1AxSUVBemxDbnJPY2Z1RzFqRThk?=
 =?utf-8?B?THdKSGFFUHRIK1UrRGVwWUZNc0tHNE0rK2NSaUQ4aGtrTzhwYnFzMllVLzRv?=
 =?utf-8?B?NTkwUE5POGhoT05lTm9LcDNHdCs0VG1WdmwxcWdiTDhsd04rcWRLaFJBb2gr?=
 =?utf-8?Q?vbD1t4awsjFBLTHX/gb2iN25J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f81206-baa5-40b0-0406-08dd14e93cc2
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:56:53.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g8SE4lltTuhRCKzkpTJRrZdMfpjNbL+z+XnJ6frtePhVEddKLaobgCR+l2gh8X7NwgsGa7RwvD/+ul/7PMFbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6794

nvmem phandle is required by secvio driver to
read fuse.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index 557e524786c2..c88d9c2dac24 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -112,6 +112,9 @@ properties:
           - const: rx2
           - const: rx3
           - const: gip3
+  nvmem:
+    description:
+      phandle of NVMEM controller provided by the SCU
 
   pinctrl:
     description:

-- 
2.25.1


