Return-Path: <linux-kernel+bounces-298176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C6B95C36B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9251D1F23E93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95F28DB3;
	Fri, 23 Aug 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IE4Or6PQ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3D20B33;
	Fri, 23 Aug 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381458; cv=fail; b=mh6hepDMpKZMorvGfwAwNg6QYafXYqdYGSDR3yBjQAwFH7McwDUC4nvr5O4BDXin7XYSZ541wpXrjP09dr7OnWvj4I577HlY7oNB7CWeRIDTFz785Uv7SiPU005O6OCwJ/F0yOSiFTwgbEIohRrrhlQnE1TL4fo48worl3gHVf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381458; c=relaxed/simple;
	bh=eXG0hTlQpt0HjwgPTX05m1UkfBr7xbGuOlX0CrrEYH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWnTX69YAF6l5neunlDW857ZJLNT6XaRv87vNEjbl09ygTtcPPweW4zOSgEuvM4XMbjq1ca8FppX8Z4vp8P6xbxyuNq7ZP64iINEBPT8HCnjWOb15PV0uu6t4K4bsMESDTQn2F6HLqUPFa6rwAI/HE88f20bWPPF46hP2CmkiH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IE4Or6PQ; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdttKQnFV2p/ImLkrBCiQEHLx8kdiUOnSE46Y41Hk+0eeQ+8ND6hMitY4eGqyRMTIa9/JWOTzi3Zro6dWKJaEJNd8hvBOlc+6a//evt/Tma55CKzCmBAKoe03kM12Q+fPjDe+R12XhCjpqMJ7DWtEMPWmVPsjSgV2p9EsgzjCCGDTPjUAVDKw8riepV5OLUdnp8w5OHgcOeZS8zhhLkro/enhCfnvDSDS/c51eVxSGSgX+SNOwAOonEwmzMsWrLgFvb27sUOQ2TS4rEYewS0tnG+/gGE9+euPvhzU6XAWztnUOPPKHe2sxg+LWOf/duAPyJn4SwjMtmyauOfjAobjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4evDawbomR/it7gHdFBxMtdYSu9ejGqKWqCPhdl6kA=;
 b=JfEQPsnicN3YClA4+JUaNoDB3fN6d57nu3KJISQwsSIHtC1ic5uxbe4G6+oCwKQTxJcHK+ypMwsLr1IjRvkQTa9A/EzNGUBX0wPAfSWROgPIYZ+vzi6rWbusxvHr52eUo8UGWzWLhiSFOWYspjqJ3ywUVzmb0LrLi8yzHSjh5tPEyH5EAN3JuZnNXVGaDxZ/uG6F4AVciyUbaHYFlnD4kP0kGNs0t0nbzu3YonLGQ+tJDUMmX8lkrWv1R86zWfhuBvo+QieV9ooZwMH1Sx0i4iTjlW8xUD/ct+CU61OQDv1ikFmGRwnHBbf+hvDmegUo4G4/WpP3QB8PTkHXfLMcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4evDawbomR/it7gHdFBxMtdYSu9ejGqKWqCPhdl6kA=;
 b=IE4Or6PQ176zsu0Z4mi7dkxQdGDjxyHk2vtdb9AVfEYDkCVg1E5nQdBnZIGXSrOwv6x7grLF8HkLMWD5etV1o9VgEVOsDczqeSzxa7GGEWA7+5zdxDa4z7UUILpflJDPySD6rH1jlFB0c1PVGDCb+nbDRpJ+H3IQyAFpuY+Vf0geYXJ7MNU2F6LxxWNzddJWQNk0kpmRs8AYhTe5Zo02Aqww6JB7yhGztwEq57hEUnUkpJb5up5hvtYao3lAP6xwv61ByFmd9hUSe/pexY1OCZ0Snkf3LkVEo+Tg7WT/Ape7JdMbSjQdoihPeeg252JaXsZ9k03u2IZre6nsrDKfOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU4PR04MB11078.eurprd04.prod.outlook.com (2603:10a6:10:584::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 02:50:53 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:50:53 +0000
Message-ID: <cca0af80-8265-45dd-aaa1-e28887f343f5@nxp.com>
Date: Fri, 23 Aug 2024 10:51:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: imx8mp-evk: Add native HDMI output
To: Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 alexander.stein@ew.tq-group.com
References: <20240823021257.1067054-1-victor.liu@nxp.com>
 <CAOMZO5AN=yx5RSkVuMrym1QF7s622gm8+Qnf09r9mgZKr5sypQ@mail.gmail.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5AN=yx5RSkVuMrym1QF7s622gm8+Qnf09r9mgZKr5sypQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU4PR04MB11078:EE_
X-MS-Office365-Filtering-Correlation-Id: c02ce43a-ba94-416d-0b21-08dcc31e677b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXlpa1dTZFNwUlhKVytVNHE4K2pFT21BdFZEVytBeDd2UUxvbmpQejF5SmVz?=
 =?utf-8?B?c2JPbXZTOWl2RUtTUzJ5di84Tytsb1R1RXg3N2Q0eEU1M1ZxdjQ3UTFscmxS?=
 =?utf-8?B?eU9XMndPR0VtVUFCbW4vSjlqNEowMVh3bytPeVV1SkN2TWh5Yk5qbkxDVlVw?=
 =?utf-8?B?bFRERldCSWtyY0h0aGpPNUJvZzZURDdPTU50enB3Yk9QNVJ6TXh1Z3hQQUtv?=
 =?utf-8?B?Nk4vNzllTDJuVGZsdWdoTytCLzZCVFFtS0lpOHN3aWtyR1I4a3NTVitTVU83?=
 =?utf-8?B?T1p0b25ieGpoSlpZSUIxY0NUdFV6Tit6bjRQeU5BZm9RYjFMOEpaOHRxekF2?=
 =?utf-8?B?L3JXbEJmVjUxWnVNaGVrVGFKR25pQ0VsYU50MlpGVTMxck85ajhTVldDZHVO?=
 =?utf-8?B?WnlnbE1BaDYxaFVTY3NscURZcS9aTkRTNmg1b1M0b1RoSEtNb1YrUE1RN1JE?=
 =?utf-8?B?Skw5cGV4TGhHY1NzdUpQUVNFcTc4aU1qeFN3eXNNTWZtWStVSzUxR1I0R1Az?=
 =?utf-8?B?bnJpV2o2UHVlMzZrTFg3S1RtaVMvU1dUZmVpQ1dvNkRDcE1yWk02VDlMNW91?=
 =?utf-8?B?YllJSER6U0ZpU0FsNno4bTFmQUdxMUJZVnRCS212d1JKTm5UZkk3YWJTNjdk?=
 =?utf-8?B?ZjdXUVY2bHpPOUtHbVdDR2FkRSt2OWwrTjNIN2NjSk84TURZUURPRE5hd0w2?=
 =?utf-8?B?S3VTdUVqZXJ5Sjd6Z2ttOWIyM0ZLR3FQY0FPWkwrS0VNejlDbmRQdXNnL2ZP?=
 =?utf-8?B?OXJTbWNxTGdsdGNkeU95R1ZydlE1eTI5U204SVBCRmRydHNPa3UzYVMraUV3?=
 =?utf-8?B?TDJndFZaQ3drMEFIK3JjTllWSVJIbEx2QTJObGJSV1JtU3drc29NNm9MNXQx?=
 =?utf-8?B?M1crY0FNVVYwUDJvSjVXdUF0RDVVUUFWQWl2VXdTZkhOaVM5SFhaN0p1cSts?=
 =?utf-8?B?MTExYmhONUtsTmxxNzVsaEJGR2xjV1BaOCtLNFlMeTR1aGlJR0VVdm1zc2tM?=
 =?utf-8?B?UTVyNmZwK3I5Y1BUdUo5N2U0eURzN29IQmZRYXVPS2tuRjFKRVNBcU82OEh2?=
 =?utf-8?B?cnEyYkk1RFRDYzVHVnJuVUdZdzZ3K2l2bjE0b0tOTFgxVDY1M2hhQlNMaEtu?=
 =?utf-8?B?N25HcjQyQ2kwY3VGMDNnKytuWEFQNzl0ZHFVa0xwZ0NJVG4xMElXb2k3NERw?=
 =?utf-8?B?TkN1VkZnVUxlN0pNWGw0Ym5xbHhVUkVBVmVnUWdRQnJpcjNoY2NtRkMrdFgv?=
 =?utf-8?B?dlB4aldXMVNTRWhXd2FKaFJ1aXp4N0xKdnN0UFdRcW0rWE1JVEdjVjlWYUVp?=
 =?utf-8?B?SXQzVFFPOUNwZ2tNYUZjSmJzOEVza3NwZEIwbkVlVkI1MXZKRWxOL2lhTHJP?=
 =?utf-8?B?aGVPYTNiaTAzcGRrakd3eFJxc2ZLTDlSTEpBWHdvZ3dydjFoQWhYOFRHSXYz?=
 =?utf-8?B?N2pCNWhDY1J3dHFPazVaRlFLeW5FY2FORTZXRWtuNkQ3R0VPMzY0NXkwdjJ2?=
 =?utf-8?B?RXdMTExFdzNodml0MXp3elpuMDNxemlnaSt1cHhGcGtQLzAyd2dMK0NGYWVG?=
 =?utf-8?B?MGpLK1FSN2hCTHpWZlNLKytJUEs5QkNmOHdwVzJTcS9rclYxYmg5OGI1VUFS?=
 =?utf-8?B?ZDVJRWxKcXQ0bmxLTTZiTmJDSmplWjRPckJiK3dUeTM1dm9FTmlqUFlqWS9D?=
 =?utf-8?B?VWpyM25FMnhuem50RlpRWmRKUithS2NLSUM3UDB6Q3B5NUU5ZjUyUTFKQlpV?=
 =?utf-8?B?clVrcmpnSytZendXVFI2anVWRWw2Vmp5U0FjVis5VkJTd29rdWdGT0svZTI0?=
 =?utf-8?B?VWUzL3hncDczUUxEQUdOZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTRYaC9iZS85UmdsRXlFVmEyWEJ5TzVWRjR3RERvekIwQXgrNU1NRy9GZ1pX?=
 =?utf-8?B?QUNmU29aU1EzditKVlZWUGQ4bC9scHZRUE1ZbXIwdktLVXhlclgrWWhDS0Ny?=
 =?utf-8?B?ZTBROXhNTTFWallSNzVkWGl2V3lJZEVBOGxwbWlUWjlLSGJiVk84NWFoYXhR?=
 =?utf-8?B?RnNVVHJTaTcwZ052S2N5MFp1U2xJYyt1ZTdGaWJNenBiVW56Q3ZXY2xUZWUv?=
 =?utf-8?B?dE52L2h3S3ZMZXRXOHdjQkhVQ08xb3lwTGIxbDZuUUFyZkQ0TDJKam9zMitL?=
 =?utf-8?B?VGNzeVdZdWw3cjVHdnRGdDZCZ3RCNEx1d2o4VlVCNi9aaFZNVFVLVStWZVA4?=
 =?utf-8?B?NWVmM3lzVlROUW81OVF5ekxaYXFrMGE2Z2hJaE5XckRiZTJ4cDlXQzUwRG54?=
 =?utf-8?B?eGJIelBEVkVreDVyRjc5dG9xbk1PUHNrMHQrUlZYY2lMUVFMZWxhUnB4cG0v?=
 =?utf-8?B?MDFqR28rb2wwckxsVVc1ajI1eUVYL1pWd3kxWDZzUDJvUGRyWjl5SVFqbVVa?=
 =?utf-8?B?OGJteWQ1eGVGRlRqU3pRV2NEb0NVYkZCVHJuTk5Vd1l1RHk4SzlGbG5XWGdh?=
 =?utf-8?B?bW1uaE9PZTcyRjJIL1l2K0Ivc0xjcmNBaGpwcHpRcmM1Mk9wMjZJejR4eGh3?=
 =?utf-8?B?c1Z6UGxZOGgwanZhQjdHUUJmYVlCNW9ITXFjZVJieWovcHFZd2IxM25DSk1v?=
 =?utf-8?B?K3FIT0pXUGVWZnhYYlhsMDBZV2ZmaEovSW1NSDJZNUpkOW1QZ3lvQ3VWeng2?=
 =?utf-8?B?Q3NqQ0dzWlBkT3FtbHJvMHBGVFlyUlFYQWgza2ZKNXYvODFJRGpqd213eFVS?=
 =?utf-8?B?L0NEVjY1T1hYVkFvejJDcndBcFBkWGJlZWNrbUVCM3dPc1dRTXNTYUZxR0c1?=
 =?utf-8?B?UzdHNzNlYmp6aXYwY3VtR1Y5dkFiZndpS2h3OTBTSG1ZeUc5cjNRTjQ5dDJ5?=
 =?utf-8?B?UFJVWUREaW9pQ3dRVmpjbjV0eFViQVlwT3R6bDhjZUFBcUs2c0IzanNSanR0?=
 =?utf-8?B?THE4ZGkwczFFMFF1RnFHV1V6N3dQZTVaeTZEOTA3K3djNHVWT0N3b1dqV0JH?=
 =?utf-8?B?YWY4cmNPVTgvZU0vajV5aC9TYlFlaldCNDBMdnpqKzNiazdpaFRYLzQzMmEw?=
 =?utf-8?B?VTU0LzRRcWNyRlhEVzltRmtYblNZRnl2TTBzZkUvbkRvaldxUy81S1N2NGFP?=
 =?utf-8?B?MU50ek9IOENFWjM4Mk43MWVTTDAvbTZZV2l2Q1E0ZUNJclhWaXJRRStlZUN0?=
 =?utf-8?B?akJQRDY0YkcrT2laTGF3WGpQRXZYcjlSN2x0N0dVRWdoQ0Q2dUNmN2VJOHhK?=
 =?utf-8?B?MUtPWnpIaWhrMkxGcXUwMnVCc1VmRUMrcHowWm9relpCME9lODVzTld5cUp0?=
 =?utf-8?B?OVJjWFNUZ2JUODU3d2Q5MDZkUzY5azhOVlIvOFRHWmRLdVRBZEFvdk1xSTdT?=
 =?utf-8?B?T0dhRERKV3VRQ3huWHArMk8xT0lMRW02MklOODBKQmZhclRTWGxSdnFRdmJk?=
 =?utf-8?B?bE94OVJNdG82UGIvREcxRzl2VUdpYS93djVSYU1lbU1WbUhkeHgxR09MdkdG?=
 =?utf-8?B?SkcwYjRDbWh6eXBveVF5M1VGZzREOXIvRWhPZFd6aXZKem8wU1ozVW9QVnV4?=
 =?utf-8?B?SUxxdnQ3Q1RwRHRYRTF2djRROHpHR2RZRmlRQ21aM20wdjFuUVp3MElETjhJ?=
 =?utf-8?B?TlIwYjdCSTNTcEdJYk5BT1pRTEtUam1yaE9HOUlVVW43OVFYb1BRNGpoRFN3?=
 =?utf-8?B?YzhLeE9iL2tiWC80eDFNdzZ6U09tNHBOVGpnZGg0T3hxNzdVM3Byb2FzVEti?=
 =?utf-8?B?S2JVa2M2bVUxZWx0Z0gxcGUyM3d0Wkh0VXZGK0NUNUQ4djRFb2FBWlhSTnpm?=
 =?utf-8?B?d0hJYi9QRHBzblZTekxicjdKYTJPRjIvdkpzTEdjTXdWTURFbzZWL0ZWMjg1?=
 =?utf-8?B?aTFTaVhEVUVWUkVMTVQvTllwaFpRZEY3b0FIVUpLZy9uRWJ0Mkx4VE5wZ3RJ?=
 =?utf-8?B?K0hmZCtwVHlMQ1RQUUhYSTJvUEx3QU1RWUtsNWk2bU5DUmtVT0dZNDJZK2RS?=
 =?utf-8?B?bDZvQkdTNU5qeXVoSTZpY2ltdERuR1FNY3pxK01hVDk0ak1KL0JaL2hCUVdm?=
 =?utf-8?Q?gU/m+qWpxN3VXjyiZ50L+wh6c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02ce43a-ba94-416d-0b21-08dcc31e677b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:50:53.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJlhb8i3S0u3dgoo2qg3IOp/FqwgYJ8e9HpbusZnLo95prIQYHBdczY6ftnj0q6k8TsxcG1S+xGnOoB8ZcyV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11078

On 08/23/2024, Fabio Estevam wrote:
> On Thu, Aug 22, 2024 at 11:12 PM Liu Ying <victor.liu@nxp.com> wrote:
> 
>> +       ports {
>> +               port@1 {
> 
> @1 without reg = <1>; will cause a warning.

reg = <1>; is in arch/arm64/boot/dts/freescale/imx8mp.dtsi,
so it is not needed here.

I don't see any warning without reg = <1>; here.

Do you see the warning you are claiming?  If yes, can you
paste the warning and what command do you use to trigger the
warning?


-- 
Regards,
Liu Ying


