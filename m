Return-Path: <linux-kernel+bounces-567937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DFA68C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F563B6FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17002254AFE;
	Wed, 19 Mar 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GBaJ895h"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065BB207DE2;
	Wed, 19 Mar 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385304; cv=fail; b=OET1c9n14KLdkS420lfQ8BS9CdEkSx4auOKAzyzYz+LYWMbC847N/i7aTNTFzGqtDl80KF9vFm0HvukKTtQ6ceDH3qk6NV9++VbUXLyui65y+lF4QlEAwbU297RTraewDtm+yeE/d7vVSUgkhTSbXkomgJbyi34q58NVA2PdxzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385304; c=relaxed/simple;
	bh=GgAnZy40SGeffOzc3UEV2JJtgpsYJnjm9SRfktYn3Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qtNnOH6H8En6bozL0tdEX6niwtfAKhBTkez9X5inE4fJNX3BVnvWYFn4lwB0oHJqQC/f0ZYNPgGVSZTcXHuiSF5CjXxEUjeu/kYRMxzL4Ggtiv3tQsMNfP198eFYDRjrf6tH5zPt3z+35kpzPk9o0B5xFjabOaybgdP7I8ISVjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GBaJ895h; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuWYO/gPDC0lOVWSpz1wQf2LMJ+ZVQoCV6EqFbTz5RddteFd/31f3mh3tFvfapAeDfCbZD44Su6xkwZgesY1KUcwWKDELOlzPXS5FDeOE6AVDWkY9dmiUm49QbLbInuKtoa56C6kDT130YVxp6vXVJ1gJDo4NGnYjuqKgP+L+E2jYgtRt4LuGJQvETw/zfiIrDzd1z16ujLHBThVtlxdcImbJoYB2PCAj5PWmzvdnVFhbHc9FG9SPvbMJmJvZ4lPmdakGb8IjrjvvXGRZUthkml8o/BWcCQYkkr17jYBvpLrWQqRWdQRzDj/7vQEc9uLmA9hoKozRODNqihral49Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgAnZy40SGeffOzc3UEV2JJtgpsYJnjm9SRfktYn3Pk=;
 b=B29e2yfxRDwxyd4f1JF3STnthlK26tuORPhUQSW10ZcbTiF6H95l9caIaVKwStP6OYV3NO8hGAhZmt0d2dV3kzce/ltn/lt47QvBr52h8oS0noXlCC/lv+ZtvVqVHgrKI69fDTplF1AeuxnZGcUYbLH+1UZ9AnoI8RVroYTyYks3Ang7fQu5JKX4D08f5Yao94yJq82G/01UB2H74l1jMSlWW+fsndZuZ0c4G9kymNqDVbKraqvCnLErbo+gH6vq1H9Wo0T4KUPsab0xot3K2lwNHW/CJYtfBf8RxxffeW2uVYeXgSFmlUksslZd6IKRuiAnhe4OOyQN717NaY6gzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgAnZy40SGeffOzc3UEV2JJtgpsYJnjm9SRfktYn3Pk=;
 b=GBaJ895hHLlK8eK4qogLHaNx5WODlQZWVX/DwXRmWGi/RZR6DsvBt3Q3XJz6xADCXNQSL8SygXYps76WVALTOCXiw1AGNC6pZxhxqm0AH73nJsQTBRXllL3V84zm4jFpNdR4MXTImU3awjykPo5SSDg/u9xS/EOU2/Ti3s5+aXuFehQmrbepFhslPOADTih896+uO1uPg6TAnPfCY/vgdXK643GVujq87Qs5CjIMhSe4DDJSiznHojHaXkYPCUqjlAyZ+ypjOTs1lW2UCMjNkoHTmp1a8voj5lxVmW8RIYX4i3br9HJi2ZlUFHx2ay9sngDCBrDxlZ/c2eSINyIcHw==
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PAXPR04MB8701.eurprd04.prod.outlook.com (2603:10a6:102:21c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Wed, 19 Mar
 2025 11:54:57 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 11:54:57 +0000
From: "Florin Leotescu (OSS)" <florin.leotescu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Florin Leotescu (OSS)"
	<florin.leotescu@oss.nxp.com>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman
	<viorel.suman@nxp.com>, Carlos Song <carlos.song@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "festevam@gmail.com" <festevam@gmail.com>, Florin
 Leotescu <florin.leotescu@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Thread-Topic: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Thread-Index: AQHbmMW8Q28MT9cR4kuOYH4VYVqiGQ==
Date: Wed, 19 Mar 2025 11:54:57 +0000
Message-ID:
 <DU7PR04MB111631E2E5B074A306033D001FFD92@DU7PR04MB11163.eurprd04.prod.outlook.com>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>
 <20250319-optimistic-positive-peacock-cc26b1@krzk-bin>
In-Reply-To: <20250319-optimistic-positive-peacock-cc26b1@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU7PR04MB11163:EE_|PAXPR04MB8701:EE_
x-ms-office365-filtering-correlation-id: 6f82039a-adbc-4c8c-f5c8-08dd66dcdf08
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RG9nWGtiYXMzRG5DdTZVeGtDa0hrVHBqWkI2RlhXV1M5bG9DUkVoY0JEMEpy?=
 =?utf-8?B?ODF3S1BhSUpvUXZYZXg4MjZadzBYTmJORTdpR0l1WXIwcUJaWmZUR2JPUXlm?=
 =?utf-8?B?c092SU5iQ2JhMzNNdU9qMEVCakhGUFZuZW4waEdWY2VLTTJ3K3c4NlZSb2Q1?=
 =?utf-8?B?eTNTbDdoUy9Yc1Fhc0UzR1FoeVh2bG1iMzJQRWgvMDV3OE9aYTlHWDVodTdl?=
 =?utf-8?B?elg5WDNjY1Npd1M1d0dMNEltMGdpeGNBWEFHbWN5VmJNY3Jzc3NoK29jc2Rl?=
 =?utf-8?B?bkJoQXo1SFZWNCtSZXNXaHlLTVc2S0QwZDEyd2F3YUJ1NzZYYTFoQWhKNkdm?=
 =?utf-8?B?czNIemp0SEc4MmVuODRFNWtrcGdZNVBWTFNVY1hTaGlQVUl6Sk9SUHNjTlI3?=
 =?utf-8?B?SmpIVzVJQ3dQR2QvMmw5ZmxtejZsSnB6NmZ4QXZWVmNGODlNa1VBY2NWZndq?=
 =?utf-8?B?NjdQOERNL2ZXWE1xRDJDMm9OYnBvd0ppTm9tbytNcWR3NTRML3hXZ1pTRTh2?=
 =?utf-8?B?aHAveDREWElCd2NDYU1VOE9POUE0L001cFMra005cng4SGpxZUxvMTlrTUw2?=
 =?utf-8?B?NjdhZlB3OWRKZTFFb1pnKy9EZmVQN29YZ1hGQUlQS2g4WTdpKy9vZHJncTdu?=
 =?utf-8?B?ZDVQLytPQ1Z5d0hvazdOa2pLZWgveDFxZzhEUDRIbGRuaXRCK1hjcDYyUDBK?=
 =?utf-8?B?ejVXQ2t1N3Zxa21saTdHNUppUWxZU082Q1NHVXplaVV0RHM2WGFxZThOYXBL?=
 =?utf-8?B?K09KcmdkYVBTdmtaQUsxMWUwUVU3ZWJmUUhkSjNvckhVVlNrdkJQVUpvQ0x3?=
 =?utf-8?B?d3hZRWlGSklmZURSUWxxc0VPY3c2ZktGWGtxYWxsRlp3ZmhiUW9JM29BdHEy?=
 =?utf-8?B?RVVNOEo2Rzd0OVZEdjh5dmJBbm5Ld0ROdFNlZDNPYnJQVmcyTkdFa21lR1BF?=
 =?utf-8?B?bm96K2pjbEIrbVpSTjdyU2VTdXVVOVV0aVE1VVkydFhUQ2FvbFVrWmxLSFFL?=
 =?utf-8?B?QU0rbGk1bVBiRGhrQ0ZzT0FmYzVpYUc5dVZ4QmxMbStzb0ltTGF4akFWcEQx?=
 =?utf-8?B?Z1dVS0JBSXpseHQ1V1cyWHdNZ2VSOGRCMzNBOEtjVFJhZGV2ZlF5OTYvSTJR?=
 =?utf-8?B?ZzJJOXBzWmFsSHNDWHduT2VKRWlZSGc2eVNvbzVqclRyZ2hlNnE2SDFUeUM3?=
 =?utf-8?B?ZXFITG5XMkgxRkJHR3NuWmFBaVQrY2NETjZXYTVhWVg2cW91RXZPQnVMUU5I?=
 =?utf-8?B?UUV2VkNQbkExVVMwV0ZONEwyd1htSHFNRXVMS0Vyc2x2TEhQUks2K250QmVn?=
 =?utf-8?B?T0V4dFBiTG1ERVJwVzVqM003WXJFN2hiR0VXdzBia25Bd0dMMExndWhlUjhl?=
 =?utf-8?B?clI2NCtHRHUyMTZPNldmUERjc1h2WmozZ0MwcW5tU29oMnROZzhJVWtEOG5h?=
 =?utf-8?B?a2R6S1dzUTlNb2g5ZEJMcVFvQ1dtMEkxZjdRa1VRSU5lZWt5b1FHZSs5Zmhl?=
 =?utf-8?B?SjYxdC9WQmFBaUlzQ0Q4bEMvY2RNMVBqZ29ZMFVVYkFtUXRrcEhUZGZwYXgz?=
 =?utf-8?B?U2tyL0Z6b0hFV3BRdkVPWHJ1OWlFc2w1NFRjZlEzL3pqUDRmNTh6S0Rzb0NG?=
 =?utf-8?B?Y1RGTkNSU1o2SWRNS3JDWlVtZUNGY2lMdERzUEZ4TFFPM2xjeENIcmNSZm8y?=
 =?utf-8?B?U3NhS0l6Vk9MVXB3cFVRUkIxbkFoRS9sTTc5WVpNZkVWN1RjcWRvSmk4N3Nx?=
 =?utf-8?B?MmQ0SEhBVzkrd2MycTdkQlM3QTAxUjlkMHI4T3hheUl1bmpvME1UMHZQV1hx?=
 =?utf-8?B?Qm5JZnZJeXhiNmhNMEFJb1R2MlQ3Mzk5a2pRaUc1OGM0YmVyaSszSDRrWGxZ?=
 =?utf-8?B?WlRwMDdiUThqNGR3VzlXTWRzYzZFUENtUHFZMXpxeVFIMVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE1YNU1wU1VLTEZBVitwY1NjbkdESUtaUmhqcUxnemtBMTBveGZEc0svbWw0?=
 =?utf-8?B?anM5NnZ6K1FFUWd5OEtPUDlleUVPdU9pSUh1bjVsdlNQOW4wTlhTT0M5NUg1?=
 =?utf-8?B?b0J0MWFnQm1sdUo5UnptUDhmVnFubVE3MXZUOGJORzg5NklMZDM0aG1DSlRF?=
 =?utf-8?B?KzdYakQxbEFkYTlJaHRwSVZYUFZCbkFsWTBxVnp3MWxWa0ZIbEIrTXFVVUo4?=
 =?utf-8?B?bzRhdDVxZ1RJTlp5c2FHODlzTzltbG8rOE9PTXJ0anY3VnFwNEJqMnpCOXpz?=
 =?utf-8?B?bWVkemhRdlJBWGFlckV2Q3MvSkxtV1NrV1JCVVAraU9iU2ZKWGJER2U3SlNW?=
 =?utf-8?B?S2tiemxUU3ZWdndQdHRwY1p4TllXOWhvbC9ZZkMzRnZGTnBNczV5TE5rRldU?=
 =?utf-8?B?TDVEY2pzU3dLbDBndGZOUGtZQmNqbWF4RmZTVkV5SDRQeWdEMXR3YkhzS0FG?=
 =?utf-8?B?eTRSY2FBWTZjYzFCR2J3di9ZZnRMVjdjc2xGeHRBNWh5WUZSMHIwdVZpbXA3?=
 =?utf-8?B?dzZ3WURhc0lTeDdNbXNIVWw4Z0kwb1luV3VETlhaR2FDLzRrQlFJSnpVeEhj?=
 =?utf-8?B?TkJadVcwRUJhZ0Q2VUppUWZkYnpsZTlnRnNHcTNOalg0SzQ4WnVxNTdhclNM?=
 =?utf-8?B?TnFxdnlyT05hSWQxYnp5MkRhS0lTR3hydVZkbXZNV1h0cE8rNWlGWGttMmFt?=
 =?utf-8?B?TzI3Z3NvVzZCT1JNcjBqSjRyT21STG1iK2QrSkxQck8vSXU0UEhmcDg0UXY0?=
 =?utf-8?B?L2xTcVI2MTRUYUdaSjdzd28rQ1ovbXJmQjBSMXk2cG9STm5odVFSbHlIUFR1?=
 =?utf-8?B?MFNWRm9wZmY3Z21IYlpCM2RVUVd0a2V4ZWZZbTQrOTFuU0xrZUJweFU5LzdB?=
 =?utf-8?B?ZXkwYkRSYS9qaHJ1MHBiSlRoaytXaEI4U0wvU0hMMTFsQjhBb2laTUdBODNs?=
 =?utf-8?B?T29ueU9NQ2F5YlVVQXE1K2I3REZwK3d3c1orMTdBOVphN1lEWDd6ZnlHbGEy?=
 =?utf-8?B?aDUwaTRKV0xaQW5kcmh3SlcvV3dOVWNkcVIrT3Vvd2NocHQ5enNKRGF3UVQw?=
 =?utf-8?B?OEhrNXIrMVVSL3QvSXhpZXc0ZVY3TDZYK0h4U1NzOCs5cXV2eFQzMkRwa1k3?=
 =?utf-8?B?YVVOblhtQjFpL2RkVWMxYTAxQ21ZTzJ1Z3A0MlI4NHlmUUxDZmJpRkV3MFJJ?=
 =?utf-8?B?R2M4ZkRUL0VENFpnbFpueU9TMmI2TjVVaGcxWmN6OURKaEcyNk5mbmZ2WjJu?=
 =?utf-8?B?UThZeGZtbVQ4TFpvMVNCdlNRMU5UUE1CK2JYazBRV0RPV2ZDcWs3ZTU3N0Zx?=
 =?utf-8?B?QnF6WFdrSk1HRUk5OGRUR2xOS0ZjYS9HNGZCU29JQUlBZG9yNDRhRFk2SGZl?=
 =?utf-8?B?cVNRNGlocks2TEZVcmpIa1FLb3AzdXFGZzNSVTNrdk9Yd0cvMEdzZ2NkRXpK?=
 =?utf-8?B?alZLb0Y4RnhhMUtHM3NHTGxOQUFuZXI5QVJVNmxxMWEyM3doT2VwNCtLVUFR?=
 =?utf-8?B?MnRUUG1lY1JyWm01K2xHNnV3S0pBUnU2R2VCQXBHZXRJbW1halRTUDB4OHNQ?=
 =?utf-8?B?WDArZ0xxUEFQdXpkbDBNRXlnTG9pMGZlMHJWRnhqcGlocFh2SDFKSWtGRlRv?=
 =?utf-8?B?NURnZWJ5dVkwY0htMG5tT0RjN0pGN2dYMUNYdW1MYXBwUHNTaXpPK2tVb0hz?=
 =?utf-8?B?bVNJek1EMExKZzQyaThHbTBOQTVva04wc3pWM0lVWDBhUXBoVk9WWFBlaHlk?=
 =?utf-8?B?dkpac1lvNndrVHFIMCtZclJlREZibU5zQnhWZzdiMW5INS9YNzF2NWdRczFB?=
 =?utf-8?B?elBUVHZCK2JobVJ4Y2VVUkF2eWphL1Y0TjJOWkcwcjg0bFRRaEQ1cGlldnh5?=
 =?utf-8?B?NGgvZjRLbzJoMjc5bWlHblRrOXNsQTJpejlZZVBibi9MVzl0NmVEdytoOUJo?=
 =?utf-8?B?UXNzeVg3dTU4aXJocFROSmJ2WmRvcGtURVJtZ3o3aTlDMEdrSG9JMi9sZXZO?=
 =?utf-8?B?RVhNQ3VoWGt0eTFTc1J6eUtzVFllMmtrZS9Sb3RJeXY4TThEc2tUUThzcnFv?=
 =?utf-8?B?dkNqNW1TY2w3QWtMblgrbUcyRFUvczRDZm0xcWN2TTIzcHhlMnhmQU1mcitC?=
 =?utf-8?Q?F52ZEXAFZrDJM5MhcJF99WngF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f82039a-adbc-4c8c-f5c8-08dd66dcdf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 11:54:57.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEBxy8gB6PXniy4o8HyeBU6isKJIdrPipM2K3CrDWFfHeIe+loQfJiJmAJCZDi9OCWyZcJq4juosWLv/SaZ6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8701

Pj5PbiBUdWUsIE1hciAxOCwgMjAyNSBhdCAxMDo1NDo0MkFNICswMjAwLCBmbG9yaW4ubGVvdGVz
Y3VAb3NzLm54cC5jb20gd3JvdGU6DQo+PiBGcm9tOiBGbG9yaW4gTGVvdGVzY3UgPGZsb3Jpbi5s
ZW90ZXNjdUBueHAuY29tPg0KPj4gDQo+PiBJbnRyb2R1Y2UgeWFtbCBzY2hlbWEgZm9yIE1pY3Jv
Y2hpcCBlbWMyMzA1IHB3bSBmYW4gY29udHJvbGxlci4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTog
RmxvcmluIExlb3Rlc2N1IDxmbG9yaW4ubGVvdGVzY3VAbnhwLmNvbT4NCj4+IFJldmlld2VkLWJ5
OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9o
d21vbi9taWNyb2NoaXAsZW1jMjMwNS55YW1sICAgICB8IDExMyArKysrKysrKysrKysrKysrKysN
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEzIGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgDQo+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vbWljcm9j
aGlwLGVtYzIzMDUueWFtbA0KPj4gDQo+PiBkaWZmIC0tZ2l0IA0KPj4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vbWljcm9jaGlwLGVtYzIzMDUueWFtbCANCj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL21pY3JvY2hpcCxlbWMyMzA1
LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmU2
MWVmOTdlNjNhZg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2h3bW9uL21pY3JvY2hpcCxlbWMyMzA1LnlhbWwNCj4+IEBAIC0wLDAg
KzEsMTEzIEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBP
UiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKw0KDQo+IE5vIGJsYW5rIGxp
bmUgaGVyZS4gVXNlIGV4aXN0aW5nIGNvZGUgYXMgdGVtcGxhdGUuIElmIHlvdSBmaW5kIHN1Y2gg
Y29kZSwgc2hhcmUgc28gd2UgY2FuIGZpeCBpdC4NCg0KVGhhbmtzISAgIEkgd2lsbCByZW1vdmUg
aXQuDQoNCklkZW50aWZpZWQgc2ltaWxhciBibGFuayBsaW5lIG9uIHRoZSBmb2xsb3dpbmcgZHQt
YmluZGluZyBmaWxlczoNCg0KMSBhZGksYWQ3NDF4LnlhbWwNCjIgYWRpLGFkbTEyNzUueWFtbA0K
MyBhZGksbHRjMjk5MS55YW1sDQo0IG1heGltLG1heDIwNzMwLnlhbWwNCjUgbWF4aW0sbWF4NjYz
OS55YW1sDQo2IG1heGltLG1heDY2NTAueWFtbA0KNyBudXZvdG9uLG5jdDY3NzUueWFtbA0KOCBu
dXZvdG9uLG5jdDczNjMueWFtbA0KOSBudXZvdG9uLG5jdDc4MDIueWFtbA0KMTAgdGksYWRjMTI4
ZDgxOC55YW1sDQoxMSB0aSxhZHM3ODI4LnlhbWwNCjEyIHRpLGluYTJ4eC55YW1sDQoxMyB0aSxs
bTg3LnlhbWwNCjE0IHRpLHRtcDUxMy55YW1sDQoxNSB0aSx0cHMyMzg2MS55YW1sDQoxNiB3aW5i
b25kLHc4Mzc4MWQueWFtbA0KDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9od21vbi9taWNyb2NoaXAsZW1jMjMwNS55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNy
b2NoaXAgRU1DMjMwNSBTTUJ1cyBjb21wbGlhbnQgUFdNIGZhbiBjb250cm9sbGVyDQo+PiArDQo+
PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIE1pY2hhZWwgU2h5Y2ggPG1pY2hhZWxzaEBudmlkaWEu
Y29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgTWljcm9jaGlwIEVNQzIzMDEvMi8z
LzUgcHdtIGNvbnRyb2xsZXIgd2hpY2ggc3VwcG9ydHMNCj4+ICsgIHVwIHRvIGZpdmUgcHJvZ3Jh
bW1hYmxlIGZhbiBjb250cm9sIGNpcmN1aXRzLg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiAr
ICBjb21wYXRpYmxlOg0KPj4gKyAgICBvbmVPZjoNCj4+ICsgICAgICAtIGVudW06DQo+PiArICAg
ICAgICAgIC0gbWljcm9jaGlwLGVtYzIzMDUNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAg
ICAgICAtIGVudW06DQo+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxlbWMyMzAzDQo+PiAr
ICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxlbWMyMzAyDQo+PiArICAgICAgICAgICAgICAtIG1p
Y3JvY2hpcCxlbWMyMzAxDQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxlbWMyMzA1
DQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICAnI2Fk
ZHJlc3MtY2VsbHMnOg0KPj4gKyAgICBjb25zdDogMQ0KPj4gKw0KPj4gKyAgJyNzaXplLWNlbGxz
JzoNCj4+ICsgICAgY29uc3Q6IDANCj4+ICsNCj4+ICsgICcjcHdtLWNlbGxzJzoNCj4+ICsgICAg
Y29uc3Q6IDMNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBOdW1iZXIgb2YgY2Vs
bHMgaW4gYSBQV00gc3BlY2lmaWVyLg0KPj4gKyAgICAgIC0gY2VsbCAwOiBUaGUgUFdNIGZyZXF1
ZW5jeQ0KPj4gKyAgICAgIC0gY2VsbCAxOiBUaGUgUFdNIHBvbGFyaXR5OiAwIG9yIFBXTV9QT0xB
UklUWV9JTlZFUlRFRA0KPj4gKyAgICAgIC0gY2VsbCAyOiBUaGUgUFdNIG91dHB1dCBjb25maWc6
DQo+PiArICAgICAgICAgICAtIDAgKE9wZW4tRHJhaW4pDQo+PiArICAgICAgICAgICAtIDEgKFB1
c2gtUHVsbCkNCj4+ICsNCj4+ICsNCg0KPiBKdXN0IG9uZSBibGFuayBsaW5lDQoNCk9rLCBJJ2xs
IHJlbW92ZSBpdC4gVGhhbmsgeW91IQ0KDQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQoNCkJlc3QgcmVnYXJkcywNCkZs
b3Jpbg0KDQo=

