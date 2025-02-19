Return-Path: <linux-kernel+bounces-521293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B11A3BB41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7953AE489
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659B1D90D9;
	Wed, 19 Feb 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="R1kZsTQk"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722331CDA0B;
	Wed, 19 Feb 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959731; cv=fail; b=JqXoDeGo1YTwYV5k9B9/+Kys1Dof2P5iLXZBIv9WWURI/VrPnrHZoOZveT9ffcA32l7Ov+52LzsPf0aEtJgVilhCIQj+cKWEQijJ0UrUiaxytZ5XqBtefKeSpEcXCjAKxdK+63QPeAwv4E2YRqy5DsXgf435tBb6qz60hF7YfA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959731; c=relaxed/simple;
	bh=eNfygJ+SyipTD3wxWTQ/0fiY0x3tWzwkIQGqMe/GtGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEPi3Eonet4YX44FWGFqEi0kOpkiqRzNoTunih8r2fLJmFnhzsc4h0Of/vE0GE5STk0xPC0E4j+UNTwf5KzEbLvSxW4DSsGTLQ03jo35jkA6pFWvAtfixPzFs/w36LPbwxJnfe/v42A/Gj0srzdE7osd7NZ/dfEN3JnDtUnYrdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=R1kZsTQk; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf0G84MNE15d9rfRrit9vFOTnt8df7z4SPnHj3376vQhhM+uWCegIKI6O3w3Upms4eP6KTEaaxLxFUq1LP1j32SUd6Oiko91ZiG8224Ke+zLCvKyqaRAODzGsYVfGGY60jPT0nqd2KeY6M7qxZePzPMEFinu/Q1l+lfEBTa3N38WflahuOz7RAW1LOqGQYW/NrxS4hPeH3TezbfyHLnt5iw72y9JKThA16NrB6xYyMFVTFrLxHJSGGVNNZOUkDQI640+4uroaWpaN02kVAYzBty0wSU3eYi9/I3WBHQ5LfqkRB+miJmZ3GubITvEQyS3wxIv4RGacKpt9kycbyUQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjVJEgs16ylAJBI6/UJxAe+q7RI5FG2HBg1WXwGHxn4=;
 b=UGhfGK/AVapJCIbJR7IEyJCvphN9xMg/15EjqTi41uhtYQPpilviL6ILgRZQ36TuODQk0UMKRzPdRLE0WlJpX3ROe9SK43dP6riGi9yW9aZegbLJrVWT4F9703W9ZsIechgxd7LTwBHnBSEyxiBMPPRAeaVTPTLZRpgrzUZWmmcURpck2th4qU2eeRPRz6yE863BUKTCndUTsl3Lco8oAtD8t3WrteWIJ0rOTv26zNqdLKTNOwWPSKgQT3oflLh5sRSVgOH8LgOIkeR7paIvdhhVpFETKLzBFgWmiA/qOl9N3ShyrFGuZ6h+ys976DSsNTbiBE4EglYbAmvPrKXC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjVJEgs16ylAJBI6/UJxAe+q7RI5FG2HBg1WXwGHxn4=;
 b=R1kZsTQkFBiEfFB6x8esK02HHuFI7QZwXHz3N7PsXzGquKG4Qgk2iCJikC8y4FnGIWDZQA7/74UN4L3RbmGBDZVf02tEEgwFIboVEDwcZ7XqjIunXnsEcJFo2wg2/wq5kIDgFqjkAfYIW9FVcKnJKUH7KGOv4SgGI+/AoZcy3HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10529.eurprd04.prod.outlook.com (2603:10a6:10:55a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 10:08:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Wed, 19 Feb 2025
 10:08:44 +0000
Message-ID: <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
Date: Wed, 19 Feb 2025 11:08:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: (amc6821) Add PWM polarity configuration
 with OF
To: Francesco Dolcini <francesco@dolcini.it>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Farouk Bouabid <farouk.bouabid@cherry.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250218165633.106867-1-francesco@dolcini.it>
 <20250218165633.106867-3-francesco@dolcini.it>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250218165633.106867-3-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e7b12d-9e53-442a-2af8-08dd50cd6492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MElNeXMwWUZmUVJBVTJobGdOZVJINEFvNk1yMC9pM3h5Y2FmY0lNMStBU1c3?=
 =?utf-8?B?Snl1SklRV1FHa3VWSGlrY0dFeWtsY2l3RCs4cEtEdEx4bmkwVUVtakJ0azY4?=
 =?utf-8?B?REpES3pOMjU0TnJXcHhHSERYbnpQbndHaHhwQU5yeTRsaXRKdjRlTnZDWEJ4?=
 =?utf-8?B?K1hWcHFzNXEyRUMrNjZZSkdSQWlzWUVycE1EVDgvR0c4RnhnbUdqQ09DMWl5?=
 =?utf-8?B?dEhNUGFEOVNzOVdqYkh1d1dEZHJ1NnVKbkJxblVGWFd2Q0ErakVYL3g5UCth?=
 =?utf-8?B?ZTU3L2U4SVJYOEVVVHFncmhtMnh2T2tPd252R0w4L05iMWd1dGtVeDVXYUVp?=
 =?utf-8?B?M2NqMUcvZGJKVXg2dkFRQU1ERHQ1SzZwWWIzY1pnMVFjSWk1V01ZZnFxUmNX?=
 =?utf-8?B?eGx1UUxRa3NoVnRSMkxCVFBxV2ZRN1FTcUt3M0NBOEhoSUpvbnNnZ2YwTElR?=
 =?utf-8?B?WWx1OS93M3JoU21pNmdtYkNvcTkrWVNtbUpDc2FJUW9RR3JIOFNyYzdoZUgy?=
 =?utf-8?B?SHFldDFSdHJQU0hqQmtPTUpUUFV1UE9SMEJMV1g1aWd6UDE2MTNocnEwWGdL?=
 =?utf-8?B?b3pWNE5hSVRyd1NVMDNPeE9NekdzWFhlL1h1aEEyK2NBbjU4OE1qMXhxSjZV?=
 =?utf-8?B?M2Nwb0JmREtkNisyR3NGQS9INmpVQUtJTStFOVR1QXFJQXh0SWZyQVB2UUxw?=
 =?utf-8?B?ellSUnpsRmp2UUN5MHpLTG9RTDBVaVJaTStYZkFmaHRMbVVMa00vT1R3dFM3?=
 =?utf-8?B?R0hnT2ZaZGdyN2s1MmtFLy9Dd0U3TEdVczU1ekVZbDVZQUl2UUYzSUJoc0JG?=
 =?utf-8?B?SWdDcFo5VlFsL1B4eXFXdHNJYVhpTTBUQjVmMmZvdDdvNWxDT1d1UTdOckRp?=
 =?utf-8?B?NXdGQzFZSHRLeFVRRlJBdkVZUVB5RkdPSk9NNDV2TXFUMmFUaUFPZTZvZFZz?=
 =?utf-8?B?SjJrcllPYW9CRyt3WFRIUVFIYlNQbXhxQlo1SllrMDlNWUQxQ0VIbm9ybDFL?=
 =?utf-8?B?VlBvMk5UenlJUVp3VkVGZzhXcFRmc0lDRFBtQlIvLzVxSEloV0RVWVZ3R2JL?=
 =?utf-8?B?WjJHOHBUK1VWcURObUIwOHc1Rk11N0oxWC8veVpPL2pkUHlRbDhMSlI2YUtC?=
 =?utf-8?B?VlNadFFJVmlBTS9SeVd2WTJCck9oWVZjZnBiWXo3SG14VHMwVUhPZEt0OVlH?=
 =?utf-8?B?WE8xVkdjWVBiQTFnVzlrbkIrTXhiTlJRT2ZNODNiTG44M25qQWlQeHJ1VGZF?=
 =?utf-8?B?dnZSZmxCOU5FbFBjdmVmWHJJV3J3VUtCZXlvU3ZUamRxZUlSQjNsVzB0MmVU?=
 =?utf-8?B?dHUrM0F1dXJmbU90V21aN2lSWFJ6T1N0eW5ESUtFczM2MkNFVXpaWnljeWsy?=
 =?utf-8?B?eEpsY0Q4WDJocE5jSjVlOUg2ZXg0N2RNa3dYRDZmM2hublpIRkJQMXY5d3E0?=
 =?utf-8?B?ZTJ0bUJWQWUveXlkdEpZM0dSeUVNRnRaMlRBNENtVnhPRzV5eFMrc0Qzcjhv?=
 =?utf-8?B?NFptSUNNNFNSMFVEODdIRXlzbFFXbXRaV0pidFpmTHFsalZyNjFoL2JyK0xC?=
 =?utf-8?B?OTBpalU5SFVINmExRThZdnlSTnR2c014dSsvUHdQWEdwSnorM1pOYUJiVWxO?=
 =?utf-8?B?eWpYcG03QmdKWFBrcjdCQk9YNDVtRFhjN0tmQVNWNnFsQ29Pc3ZiK3ZoR3ZM?=
 =?utf-8?B?UmlOM2prbjI4Zzg1c2pnZWEwNjlhb29tb3duVDI0bi80RjhjdFlFY2p0RTVk?=
 =?utf-8?B?a2EwbjRLQVJ1TnpsMXI0VjhPblB6TDYxeVNvdjc5MWZlL3dPMnFZTHE3QUI0?=
 =?utf-8?B?RWdEM0h0U1NMUzhBdW5ISU5HU3d3VTRxZ1llM29yeStzMHVCbHNnRytWREdW?=
 =?utf-8?Q?hX71duVQEmtp0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGd3MllDQVVmM1E0cVFXVjNvVHEwV3FDU0p2VzB1RkpQRklzL2FBcUNlV2I2?=
 =?utf-8?B?dVRaTHdVQ0RjNFROSlRyT1ZCVElEcHZJcWE1TWVIdzdXTERUdk9wNUUyUEdD?=
 =?utf-8?B?bTZyR29vWlU0TE1NNEVTb05iSVZ0SWxEeHE4VU5STGdkUDN0eE1icVV1Vnlx?=
 =?utf-8?B?ZzlKYXFEdkM0OUZJeFVSaWZ1U1JFQUpNckpuWGdyU2pwM3E4Q0tDRXRtZFkz?=
 =?utf-8?B?eVlvd3BMV1FHYnQ2bkJyRjhsRGFQRE9PWWdEeTJFMVV1LzB0aE41ZWxoSHNi?=
 =?utf-8?B?a3pSVEF3UFd5aXZBWWFxZTNMeGxsZUs5dk12NWFWSW45NHhFZ3FOUDAvRWM0?=
 =?utf-8?B?a1ZQUlZKWDZ2bSsrOGdiY1RFQmNkUW9ZMUZUN2trSEY2RmNWbEVZRjRJVXh1?=
 =?utf-8?B?K2VWNTFkMjNvbXQySTBsN3F0d2ZKdDdWYlF6UFJWbTZrRVB0Kzc1YTIwNDlM?=
 =?utf-8?B?T1V4QTF3bFBjT01xcTBETUFzWmhVaHY1ZHpRNkVVSXV6UnUyQmZqMXMwZjQ4?=
 =?utf-8?B?bUJKNlB3dTE4djJ1UHZBanhQNW40cTdndENKMWJIT3YzYjhpTXlMNGgzVHg1?=
 =?utf-8?B?UmVCYTBkUkJVaDdnUE04T0xDcVoxZUlRMWNYM3lLVGhnUkZad2toNFRaNDE3?=
 =?utf-8?B?d2NpZTRrOU5McDFjcytGWnVaQmMwZEwzRHBseE1jNklraXRLU1JVbVZrQXpD?=
 =?utf-8?B?Y0ZGcjZYOWxLOGxsZjVleHdtWWxTSCt1cGRVZ2RKZHQ1SzQvRlRWazU1RjVv?=
 =?utf-8?B?MFlmdHlpUE1aZmt2dTBuem44RVMrMXhzeHJVbXRjbTJZSVg1RloxbDNzcWFm?=
 =?utf-8?B?RVVjTW1YTDJQc3c2SnErbjhFOWRvUkxCMlg5SVBiMTNmWlRTZ3lzVGhYSTl3?=
 =?utf-8?B?blFoWmQ4VmtUdVFzalhPS3M1REZhS0djZmZrVG5XMUpub08vb0xFRkRpb3pv?=
 =?utf-8?B?N0ZnZ21zaGVxZkFTMDZoYnVFWjNjZzNuRTVkbm1tK1pnQ0hFNjN5a1VCMFFS?=
 =?utf-8?B?UlNTL01laVF1bWVTcDc4Z0ZQMjkweURLZVpqU1plTTlUZ0duNWVZVGJVcmsx?=
 =?utf-8?B?UDdJd0dMQkhRQ0cvUW9WT3JJdExvZjBnMlpXdlViSk95YkFlNEdLeXBsNWwr?=
 =?utf-8?B?aVl3UG45ZEtLT2VsNVp4NVBwR094QTk5aEpGcmpSN1B3Sk9veFdaN0RyUFdm?=
 =?utf-8?B?blNVMXlHOXJVOExGNHZUYVBtVkFyaUMxMDJpRlJLMTIyUENtTWpSWUtyc2JU?=
 =?utf-8?B?SVRQaFk0TWVIakZ5TUE4NzRBdDI3U2kxb25qSHpZNk1oVWN0c21XYktnWHdy?=
 =?utf-8?B?cmJSQ3lJOExESFdnZ3piMTM5L0NWRndkUDBBUE5qbDVyT1VWaEhROW9RdmJE?=
 =?utf-8?B?bFNnYkM3dnczNzZtdlJtN1ovTFFSajFML1hnWWJYSkhYWFYwWkY1SzVrOVMw?=
 =?utf-8?B?N2cremk4Ukc0M0FJb1h2U1RldStiUVhVVmNUUTFjellwRGMxRi9vd2RraTRu?=
 =?utf-8?B?YWlkWC9qWGxVYVVIcDE0RzV4UzBSUitrcUNtWXIvMEhQc0pvZytjNXk2K3VT?=
 =?utf-8?B?R1lMVmVKbldoVE50MFl2bGUwbEpRMEY3QVQ4bzM2RDBNVW1kcldpZDJMYUZl?=
 =?utf-8?B?NE8ySVNvTjgvcFlBdHJSVHdwU25lbjFSMjZaVEVsQTV4V000TStBYTFxNXE3?=
 =?utf-8?B?UDJYeDMrNytZTWNNRyttZ1NaMEY0VkpIRkc1UFhsZzhzZC9IVlVEcVAxUmp0?=
 =?utf-8?B?V3k5ait4bnFxMXQxYitBT3h3YUlkdXNvdjk3ZUdEQ0NRZHpVNTVPN0h1eE5K?=
 =?utf-8?B?RCtwTnF5Q3hDTTh1R2dmK25WcGJhcmlEb2hDaUY3S3Nvb3g4bVU0Q3pxbjhz?=
 =?utf-8?B?MGh4RFRDditPU3c5Z0N4aFlJMm5NM3RVdzlFT21kV1Q0WDVqS2FaSko0R0lk?=
 =?utf-8?B?ZzlKS1g4czRkRlpYaHBpM3A4eG5zbHZ0YzNQb0ZvenhQSWFlYU84RFRFMUFV?=
 =?utf-8?B?WWFrejZCYitRK1Q5ZG0xK2sySVdMNnI5WTBHYkEveG0yWlVwTVE1UC9xaXlZ?=
 =?utf-8?B?dXBNVFhTeGFxazBzM1BqRy9tellic3YyaEhxVFkyWXVtOUlxaGM4QXVhZ2Zp?=
 =?utf-8?B?UEhhYjR2YlZmTnRrRGxjdExZUS81bU1TVzU1YlBOY3pPMUtOQVNQeEw3OTFF?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e7b12d-9e53-442a-2af8-08dd50cd6492
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:08:44.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myY8H/0NrGaRtsG3iVb0gJIn/qxVMN7X7vh5IC6tDD6gv696+zVOk+UWccaXPLed1n4qgl9gRxAL5NW2h6nH0ihkFdNWKztm6SX1uwNug/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10529

Hi Francesco,

On 2/18/25 5:56 PM, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add support to configure the PWM-Out pin polarity based on a device
> tree property.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   drivers/hwmon/amc6821.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 1e3c6acd8974..1ea2d97eebca 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
>   	return 0;
>   }
>   
> -static int amc6821_init_client(struct amc6821_data *data)
> +static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
>   {
>   	struct regmap *regmap = data->regmap;
>   	int err;
> @@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
>   		if (err)
>   			return err;
>   
> +		if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))

I know that the AMC6821 is doing a lot of smart things, but this really 
tickled me. PWM controllers actually do support that already via 
PWM_POLARITY_INVERTED flag for example. See 
Documentation/devicetree/bindings/hwmon/adt7475.yaml which seems to be 
another HWMON driver which acts as a PWM controller. I'm not sure this 
is relevant, applicable or desired but I wanted to highlight this.

> +			pwminv = 1;
> +

This is silently overriding the module parameter.

I don't think this is a good idea, at the very least not silently.

I would suggest to add some logic in the probe function to set this 
value and check its consistency.

Something like:

"""
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 1e3c6acd89740..3a13a914e2bbb 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -37,7 +37,7 @@ static const unsigned short normal_i2c[] = {0x18, 
0x19, 0x1a, 0x2c, 0x2d, 0x2e,
   * Insmod parameters
   */

-static int pwminv;	/*Inverted PWM output. */
+static int pwminv = -1;	/* -1 not modified by the user, 0 default PWM 
output, 1 inverted PWM output */
  module_param(pwminv, int, 0444);

  static int init = 1; /*Power-on initialization.*/
@@ -904,6 +904,7 @@ static int amc6821_probe(struct i2c_client *client)
  	struct amc6821_data *data;
  	struct device *hwmon_dev;
  	struct regmap *regmap;
+	bool pwminv_dt;
  	int err;

  	data = devm_kzalloc(dev, sizeof(struct amc6821_data), GFP_KERNEL);
@@ -916,6 +917,18 @@ static int amc6821_probe(struct i2c_client *client)
  				     "Failed to initialize regmap\n");
  	data->regmap = regmap;

+	pwminv_dt = of_property_read_bool(client->dev.of_node, "ti,pwm-inverted");
+
+	if (pwminv == -1) {
+		pwminv = pwminv_dt;
+	} else if (is_of_node(client->dev.fwnode)) {
+		if ((!pwminv_dt && pwminv) || (pwminv_dt && pwminv == 0)) {
+			dev_err(dev,
+				"Polarity of PWM output passed by module parameter (pwminv=%d) 
differs from the one provided through the Device Tree, ignoring Device 
Tree value\n",
+				pwminv);
+		}
+	}
+
  	err = amc6821_init_client(data);
  	if (err)
  		return err;
"""

maybe? Note that I have neither compiled nor tested this code.

This also changes the precedence compared to the patch you sent, I think 
we may want the module param to override the DT property if there's a 
conflict.

What do you think?

Cheers,
Quentin

