Return-Path: <linux-kernel+bounces-243871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F5929C01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52B11C2145D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5814267;
	Mon,  8 Jul 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hh+hZFbn"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174811720;
	Mon,  8 Jul 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419236; cv=fail; b=UKKgGfOGBbvXg7Yw1Js9Pyn2MxOkpGbgmUOARoUN+0qphyhrI0nlm5hyTTg9USNk1ze3DoPor7kpm2KxsshBNus8B6Z3nqkG/riW30mIWk0v48u4HzUUvW4oSspH9eS24F2baVAo3gYrQGyOJOCpxUWUShNIG4S5Ggk9hMWQvr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419236; c=relaxed/simple;
	bh=5sWm1MuZI2/tXBJsUIDnPEyb0YpHC76xlHFBXmvV6qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ukLun2gOkvil7rz4xWlifpiq2ZCfQ1oTJaYhIdf1Rrbp9rj8OUQel1/XQCjYIaLJsm8V0OeiYS781Pkob8HzAG/L7MUEmPQMLRNjh+Qgw10kRLrob+zPhligVTzkNcHW1LnjIKM8gkPc/oSmJY6cGtMPuocRmX4/G0oGnEoq+cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hh+hZFbn; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkGZF7VmXijiIpOZYC3TRIDlpECk4aX2cTO1Dw64/J1OY4JHdE6z1ANCF92heHicJ8iicARLtBm30TfX17lRacVBlazWg9Bstr8Sqe+vIJO7fNugbR8tlsBVS7VdNpmQLmJ1N/1JjJRfCzwWl6if237tAlhZOacCiGvTZ4YgvAFa0g45XJoGUbtD3XwgS9DOUogpvZtIp5TAy5yR4Jr2344tj/Ze9buY+mfhZgPX7FEG1ruKh7VwQ/JPYZ9aYwsME4oH0XuNQonO6okO4b9fwVzP1DzDP7S94rlQb6duFAqm7kpIfaxd6Wi8PdFz9b7daVCDEh2jLTbdEjBQYlVn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayA9waMH1/UC7abqLleBnJkWIWSyCQXa4uqsgGZps0Q=;
 b=W3RVaOnEwTXvNJ42e1T7Y8RP1IQ1pXrb/gNL9u/UklUHVJzAat/EdAJ52Kqbq5tGbd4XCue9EQIpaeSD1KCoRWx1mpl4vo35Cv2DEUMNBxzvti0H1TRZO8XnqXnXsLKZHl4QiJws6S3hifRPNr8VrYHMsKm7koZyNxNP/8ysNfIh2WUEbfzb315xeCs/nKV+CVFA+3kb31tKXOYXBnH086AoOEX9ukGs+OaHhaQJzx9XczmNgJUhgsyb1dusanW74cksZB7tj5RWrrqR49f5pINFKC7Tzjx/Amt8qAHO3q0iV5M49TZuzS44XSLcpaNwO2Fl2czOLEScBixfE/biqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayA9waMH1/UC7abqLleBnJkWIWSyCQXa4uqsgGZps0Q=;
 b=Hh+hZFbnbDYXoggoZKmRcc3046Fyrg5gAq+h+raJUgeofPSv6Vij1nuQKOvmx7hRq9e82jG8W433HLehXt5rXZ4mVi3kU8CeqWlWs0/x/9BVlyyl7zxgACEbhTxsUSxhi7q7YmfpWWa+WHpQghw0m4CGKVmvdLx9WOIYT9noA18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB8266.eurprd04.prod.outlook.com (2603:10a6:10:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:13:52 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:13:52 +0000
Message-ID: <2992d8a8-3185-44a5-b875-4ab1b806ba06@nxp.com>
Date: Mon, 8 Jul 2024 14:14:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] MAINTAINERS: Add maintainer for i.MX8qxp Display
 Controller
To: Frank Li <Frank.li@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de
References: <20240705090932.1880496-1-victor.liu@nxp.com>
 <20240705090932.1880496-11-victor.liu@nxp.com>
 <ZohDSDPZ+mS63TQv@lizhi-Precision-Tower-5810>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <ZohDSDPZ+mS63TQv@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4ed02a-6797-4bea-d57b-08dc9f15236c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW9DS29GcmhYQ004R29TdGNJN1lSZEEvcDdCaUtDNWRmTmYxVnVJS0JUQXBK?=
 =?utf-8?B?QnlyNDc0ZE9oYWVHeVZGSHJpdlhsVjcxRU4zT2NEd1FwbG41ZHBUMWdYQW1X?=
 =?utf-8?B?a3FLR200cnRQc3o3aVQzUlBsWk5lYWF0UFRyZ2F3cThObXFsYy9CbnRtVzRs?=
 =?utf-8?B?aHE3R1hkU0YrOEZvaEtLVE93akZFTDFudDRtRnV2VzBDc2RWOE55Q3RwaG9D?=
 =?utf-8?B?Q1pTbjRqZmVicytCRzFSWnB5OEp4VGk1dXZTYkVOcDlKZCtBYnF3RUhaY3pK?=
 =?utf-8?B?c1VRdm5teDZQcFZiSmR4T3I4cFpwZ0xmUThWU3dzZlVZdTVQNEtjaTFuUkwy?=
 =?utf-8?B?WjNBWXIyWVZNa3RVNjBZMXdIaTRpWWdsbFR2Z2dZQ0VHTkczREE5SUkwdkRq?=
 =?utf-8?B?TnFHcHN4UWZ2SjQ5ZFNoTzRHZEFtMUdaeWNGU2dCUkViSEIvTXBhRVlNK01x?=
 =?utf-8?B?R1ZMRmRXbEEybFAzcGlmNEIrSzNRdDZEMjlBNmduTUVydkxRRmYyc2pyNWpq?=
 =?utf-8?B?K08wcFZaUTg0KzZXRUwvcjU0bitjTWlkNnlUYmxnbTczd0k5SUtBRnFwM1N2?=
 =?utf-8?B?UDkxd1ZVeVJVU25lWUVTekpGZnA1bXVZZEk2VlkzbERuS0Q3WGt2RTkvK05x?=
 =?utf-8?B?RmM3c3AxeUtBbWhtbVhyQkRDeWZLS1FZcGxEMWMvQXdGcm8wbm9vbWQzNklE?=
 =?utf-8?B?S2p6ZTlHVW82NHpPMGluc0hjaDhIQmY1aVA4NVN0eFVKK1NRcFpzenUvSGhV?=
 =?utf-8?B?YlIyMWI0S0ZtNUc3YmNoUUpUdmx1ZXFnZHJ6bk9STnc1N3ZYbW5abUpTd2N0?=
 =?utf-8?B?NzBqRkpZZ1ZnWVUzb2RSd1hYMHZ6UlloSWRpSzdQbkZjZkNGdjgycjQ3V2V2?=
 =?utf-8?B?d282SVBPczVDeFRwNmJSeFJJOHdoYSs5YXNZVXpNWVpGYjEvOW9vL1ZoTTJQ?=
 =?utf-8?B?NnBDTE9lc2ZlQmFxK2ZwR1poZ1BKaTFaejU3UTh6dzYyQUZtWnQ5blA3eFBR?=
 =?utf-8?B?RGhPc0o3UE1aN05nNER6ZzBNaUc1bjV0RzhybmRYclhmN3NvRVo3UVFubWFj?=
 =?utf-8?B?bDB0VmRMZFFCb0U4ODB4a2xNcitjd1R4YkhXenhGcVpiVDByZnFpWlZuSnhy?=
 =?utf-8?B?N0ZXSFFTdmtsMHk4R3RGL05rVkErcEJZanFrZ2dxTXFVdmF0Z2RhRjkvV0FP?=
 =?utf-8?B?ZCtjTmdvODFXN0tlM1R6dVEyejJac2tUd2dJU3UrcFd6WlJMMVErQzEwTHNo?=
 =?utf-8?B?MWhPNUhkS1NOV0pzV1V2TEQwTWZybExURzhOTHp2TGtobTM4MlF6SkZ2ZnZP?=
 =?utf-8?B?SUk4UzNjNXVVS2JUcEMrbjhtRE9aek56VG83bzlxMS84VFRBZXpOUFdsMEtn?=
 =?utf-8?B?aWtFcVVRdTJmVE1VbVBHenJ1WmFFT3pPQ04rbHpXc1FacEtGQkwwUjlGNU1h?=
 =?utf-8?B?N1RrRE5CVWxaSVd4Z0FNVXUrWVJmSzM2SW1WSWloaUpqL1hKRTVKTjI5d05t?=
 =?utf-8?B?VHdya3BqbTNmM0IvTnF3b0tVNFN3RXBTUHJ1OVdzVmNwZlhGUDhsOHoxRi81?=
 =?utf-8?B?R0MxSDhiaS9EZW5Ta3RKTDlBVFNyeHIzRkxNK2JZRWNUZWNoSG9WVVpaUlpk?=
 =?utf-8?B?TzNtbldMMGZJMGdlQ2kweDV4QW9UUGJKSjRUS3NoOGpWYnJXN21Yakx6N1Uv?=
 =?utf-8?B?UGxzemEzQ2JZVmZKKzB3TUxDUUtDZEZUT25FNG5VWW4yR3p4NFRFdExPZEJG?=
 =?utf-8?Q?67N4OTStw0jkV2HwQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNPbkt1T2JMb2JwZzVJL3ZnenFCWHduWVhaWW1ORk1LaTZHQkk5Q0wzM0JY?=
 =?utf-8?B?a0R4WXlPRXVTQmw4Nmx2aTkvWElyUmE0bzF4d3AyU0Z5b21qaCsxMWVxSCtR?=
 =?utf-8?B?V3RwbXhVWmltdkg1bHpyOHR5T1RpM3F1eGFwbGJGM0cyZ1lyVnFTVUNneDly?=
 =?utf-8?B?Z21qMUFmYUVNNU9aYVVUUHpna0NqSkJOd1JUWm9lN2s4bDJsSnlxdkFFdmZw?=
 =?utf-8?B?emNrVzg0bWRHYUNsTit3SzBLeGRFYmo1djVzbWU2WFlMRTdpZm5ObG96Y2FX?=
 =?utf-8?B?Y3UzdExVOU5GeFEwM1JOcmxnV0htc01SRFY3YjZRNEUydHFHQ3JYVDl4WTJp?=
 =?utf-8?B?MG1mRklRdCtyMVhxWkQ1N3hmeUd1MHNjTklOMW1kYWhvUDhqTklVWUpKcHVv?=
 =?utf-8?B?R2V1UTh1RkU5SzVkYmJrNlJZRGdnTjhhRVJiNWo2b05ZSjYyOURLN3RNbTNS?=
 =?utf-8?B?SmpQcWtwZUwwUDFxMGpBM2lkSG1tY3U4eWcyNlNIYWh5Y01PM3BTNGJGejE1?=
 =?utf-8?B?Tm94Mkc0K2FwL0I3dEhuaG5iMXBHRi80alZoVGpxbjFocE5xTjJobktCamxs?=
 =?utf-8?B?WjJ4a0F2dlRYTGJCRENXNnVpb0o4MnJVYk8rRzZ2L3ZLM1UvNmZOc05zcUI2?=
 =?utf-8?B?NDl1S0kyMEFqQi9veHVzc2t4R0xJM1YzNkF0aTBRREEyeTVsb0RWR21BdHpu?=
 =?utf-8?B?aXZaMXV0d2hsYVArNW9WeC9TK0xJdmJ1L0ZLc3JwOWVaeGhaWW4rS3JqM2Y5?=
 =?utf-8?B?RWlJSTFkZ0VhTEpiUzFEb2E1U3VSQkpvaTh1eUZlYmZZeS93dEJHbHFFV1Fv?=
 =?utf-8?B?QkV0N2FrS0ZLdjBBL2dLeEpHSDJ4OE9GaWdjejhNcWpLUGYyYy9ETlJuNTRD?=
 =?utf-8?B?TEpySXZNWC95T3cwZDNjc3gyOC81RmJleE14UG9NLytzTVpQNmV6enlaU0My?=
 =?utf-8?B?Vi9iV0lFZktnSUtJeWxrbWUrS2ZXdlphNzdQakR4enRiZVEya2d4N3ZxMGlx?=
 =?utf-8?B?TU1wSmdkRXY0VTFBUWUrdGxFZnJDSVNGaVhYTG9xMWJ5Um9zQW9GRmhIVExp?=
 =?utf-8?B?Ymd3UDlwOEo1TkV3N0FIQzhhSXU5SWZ5Y1cwanRhU253Sk9MSkVsQkQyZklF?=
 =?utf-8?B?SjdYc093N3c0ajNTYXdFWmR5T1ZnZDFTOEdOL2lOUHZ4UHVBeFFLcG9lc0Ro?=
 =?utf-8?B?YmtlcnBPdTNTK2ZlTnVnRDFINWNRNFl4WG5hcjdLbjZ1VUN4Y01oZ0VwMnhO?=
 =?utf-8?B?Z2Yrcyt4RURsYWxaQUhWUmVEdjcxUFVJcG9ZcTdiMFVuOTRDSHpXMkk3Zmt4?=
 =?utf-8?B?RTIrZnhQWjkzaFFtcTM4UHNHVi81SW81cmFMTEZjeVBHNk9iclA2OGNUTjN1?=
 =?utf-8?B?akVHWGRmN20xNnNreFNyYkMyWWZFNEd5S210NXRDaXpDU3ZvcTN5dThwbWpK?=
 =?utf-8?B?WStZb3lpbHRHWFV0U1dmTUZJandCOHljamJVY3Bra0JBVUkyVW11aUFtUnlx?=
 =?utf-8?B?c2JjWFAvOHlOMys0Y0xRaUlPKzFaRWFISUd3aXorQVBXcjZkc0dyZVZBR2xM?=
 =?utf-8?B?eXF1blh6aXNwU2lQaWprN0Jmcmtka0VSWjBuNE5ZdW1nTmV3enoxTXNFbU1Z?=
 =?utf-8?B?eWtiYzVhTkFNV3BydjV1blZtSlAzbElHaVJLUDhxeTlnZk56UzRMTFI2em5V?=
 =?utf-8?B?QmVtcXhCOFZCUDVVc210dWhUbEVVZm1oQVRMeXBYL0w0NXNyRktOQkJpZko2?=
 =?utf-8?B?Ym9oMkNCbUxBMmNSekVNbWpnaXM1WDlRZ3ZzNlRaUkNNa2MrU0pNSTFYcDI3?=
 =?utf-8?B?SlBCVldUT0t1cUE2ZklxOHVqOHN4dFlGUTlNWDFwaldkZDlHZjVaajVWejB2?=
 =?utf-8?B?UmxTbTlhYXlYYUozMmhlMU5FRUJucmNOcFFtR0NPTzRNblNzc1RMVjZYSkF2?=
 =?utf-8?B?R2h6VER6dVY4NEEvUEswc1Z0RE1xdDhQVHZON0NaaGJzYTJEN05ad3JjRFVB?=
 =?utf-8?B?aW8zZDRQTHJSRUNBVG1HVnd3K01PWVc5K1VFTXF0ZHFNZHErM0F0K2tEYnRp?=
 =?utf-8?B?NWNIRVZpeGw0R1lTcXNZck9hczB3WW42WDZ5MFJuVkREekR3ZUE2eHF6RFEz?=
 =?utf-8?Q?Ax4aefamrPP19qjrlNP90gI4y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4ed02a-6797-4bea-d57b-08dc9f15236c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:13:51.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVFAYV9NIh1gH6ixNV88dHDjlLNjcUDp3WF1ThV5Y0niJawupV3q2K1eQHdmd0yQ+hTnmP95PB+ddzA0szTv2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8266

On 07/06/2024, Frank Li wrote:
> On Fri, Jul 05, 2024 at 05:09:32PM +0800, Liu Ying wrote:
>> Add myself as the maintainer of i.MX8qxp Display Controller.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>  MAINTAINERS | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 35db18d26c11..29c9d52e74d1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7379,6 +7379,25 @@ F:	Documentation/devicetree/bindings/display/imx/
>>  F:	drivers/gpu/drm/imx/ipuv3/
>>  F:	drivers/gpu/ipu-v3/
>>  
>> +DRM DRIVERS FOR FREESCALE IMX8 DISPLAY CONTROLLER
>> +M:	Liu Ying <victor.liu@nxp.com>
>> +L:	dri-devel@lists.freedesktop.org
>> +S:	Maintained
>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchlayer.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchunit-common.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchwarp.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-framegen.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-intc.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-layerblend.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-tcon.yaml
>> +F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc.yaml
> 
> How about 
> 	 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml

Ok, will use this.  Thanks.

> 
> Frank
> 
>> +F:	drivers/gpu/drm/imx/dc/
>> +
>>  DRM DRIVERS FOR FREESCALE IMX BRIDGE
>>  M:	Liu Ying <victor.liu@nxp.com>
>>  L:	dri-devel@lists.freedesktop.org
>> -- 
>> 2.34.1
>>

-- 
Regards,
Liu Ying


