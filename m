Return-Path: <linux-kernel+bounces-550519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F8A560AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC381617BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF118DB1B;
	Fri,  7 Mar 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZL8Z9dT7"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7E154BFE;
	Fri,  7 Mar 2025 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741328158; cv=fail; b=X9eCkxkpreiHSVAF/xWpWh51EGhEDt4rOuKSFWUnHAl9jD5YVwiCviGclWyi/mr842H3g5PSXaeKWdCntTNm0djpAORusH/49bvdBLjnA127KMvBK4yG+GdcRuUsTKhsuWosZQ304juCvWc5ptgMxg+tptw18+f/PZGBsPLiTkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741328158; c=relaxed/simple;
	bh=0smNyrxSzAAG9ZFHF6AwR10Cz/qeDhEM7oNwbEhTjq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1UxETy/eM9S1Ra+5Qszpk1dojtzN5K92+YTSmAncIO3wlU/P0tLQatF2CU+4FeGgZ6p7fr0nCCfU+Pou4HUWXYU66qh2LJzz+QFQltaPvpP8RWGE+ctGP8BQyzOr2jHTN+5dhHRIHdNZvNxsxnwZF7d+dNr1ye0YlbDGf7mBk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZL8Z9dT7; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0y5oStwey3NLeyDGs2CAORyyU55UdROpINyc4WY0s9Zbm6pZmNZsDF9LRDVkfmFzj77IWtUkx5xgYI/JrSZGjgQpTMBfrsHOC1SZad35h0QtLYAuGqQOAEJzoWweqP/ReH5KTXMMqa9H9H0FIaSNaIV+1GPG33RWAixQRVUzutEKGvTf3Ygo3XsfybKSmg/hkMkGYUPOqqNzhCaHtpmnp/0FiJiv1qCilZhR+NS50UaL9igIcCUw+tKhKqHNoG9LvNQrfR+DtLlGDF3hwJNAVH0wION05oJGDVEXrPiuZSZhXOeO+LaTz5jXmPgvAu15Ll/hE4xjgC9nA35uMV9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie81iNnUy4KwSWGO7y3DFzv7qY3ZpGj+pemNCaAduac=;
 b=Slh/M9SeeQpsEjnRz9NNr4Gef0MV4rrQK/4Jm872Wn9rpQ7QxQDeyt/4o7Zrl34o03+oDB+DgdnE1KG6MdQWfvvEUJwjl9IaNDmWx2Sl1IHgzdPkHTuVUCQKq9YvgGmzCZIdbPNEi/zdZd7xg4S2K8nISmntYcwH7+8nPc3YSng0eNAHxCRUqAd7DRw5F2dKIU7rweiB/rOTOXiOQk+uML+GEg+RGNc9i6uGlv4gFak68Y+LfGlFkSJJ7T+/Bhi4rQGS9kuzn9ah++RLhKmwdkgn/AcEKaA1T4Cba/HDQkccios4qphPqTPORCPhT+qjgDQH1woRhfnaAtqVu4K+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie81iNnUy4KwSWGO7y3DFzv7qY3ZpGj+pemNCaAduac=;
 b=ZL8Z9dT7CWTkow0+1bE5AdMZUuxT5f/q3k1S/opr7QCQCakNX8wOvs0h86jjwNL1hFjvY78RAQEdhZrrpHG29POl+c2GYGlkPTaQruazF/ARKqWu/hdQkKbTWOtKrG5COWsWNssZaPRM8W35HH5qGKD+aG7zKE7Vs3cWxoAy+oAoGlTDfh6luRpW3ASfKdnvIgQVfj+6cF1xP+HjeGNuP4JTOsVEDadQVijXSCBnUOIbtNVxsc+coUaGBVogY4HrM7VaWBnL76qT1I+PdPn8wd5lRd4nk5Q6zGDZu0CMmgBzG98lOg01ETg5MXuAMmEbKIgecYfQOAZzA8SoTLeL6A==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAZPR01MB6242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:4d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 06:15:50 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 06:15:50 +0000
Message-ID:
 <PN0PR01MB1039316B7E02955833244F426FED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 7 Mar 2025 14:15:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 MSI controller
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
References: <20250307010649.422359-1-inochiama@gmail.com>
 <20250307010649.422359-2-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250307010649.422359-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::36) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <3cae6051-e31b-4a44-93d0-fd32c1f16fde@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAZPR01MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee3eaa2-07ea-4748-9493-08dd5d3f8086
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|7092599003|5072599009|15080799006|461199028|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjBhYXBXL2pVY2FpMVFzUjVHYm50SG9jc09rU1FlU1RXNnVTMFZkYnBQV2Vs?=
 =?utf-8?B?amFXL2lCTVdaMkdFbERmRVVaMnU3RmVBU1pBY2lNbU5leFBqNG43cEFmbzR6?=
 =?utf-8?B?YjBjczB2MWduZ1YvL0JDTkppZjkvU1VWMFFHVWRxdlVIbEI1T2F5ejh0Tnkr?=
 =?utf-8?B?cmgzajJYUzVUd1gwWlpFU20za2Zxb0hEU21PTEhoeTgwbGsxQitMMDFtM0Yy?=
 =?utf-8?B?L0pmUTkrRm5ZdVZzWEhUNEFJczhuelVZWmVjMTdSSk1ERGNQMDV4ZGVRTHAy?=
 =?utf-8?B?ditUTjZnZ3hTK25GNnJURWZnUHQ4UzN6dE5OUmVVS2ZsbTVOeEtQY0VRcExI?=
 =?utf-8?B?U0h3eXFXKzQwTURNQWFBOFJ2L1paSmtJN0ZqdzBNdDhlYmZ3WXJOQi82ZVB2?=
 =?utf-8?B?LzNFMHlHSTVZR1l0dWJSNm9zc2hxUTREYjVDdHF6ZCtFWW9xR3c5Y0NKSWR4?=
 =?utf-8?B?dHZxZHFjTnUyWWVPTEVmT1dTc2NIRXZ3UzZJbkFJaTRCdithTDEvZlhEVVpR?=
 =?utf-8?B?NTNHTllYdkc5VlE3MUNZeld1WGV3TThnTkpUa2VEeUpWamlmNjJ4UHJjRlhz?=
 =?utf-8?B?czd4M3Aybmt3TEVHRzEzNzVaWk43ayszaEJxay9wR000VlhxT3BtK3ZXQnhJ?=
 =?utf-8?B?SHdieWtDVGpGbW9uTjZ6VDdYM3pQZjR5UStXWjZHcGZUaDN0N2VmK3F1cUpp?=
 =?utf-8?B?NWM1RUFUTEdRTXM1dTdPQ01wSFhITi9mSlFhR0hTa0U4YWZaRFdWcUxJdHpP?=
 =?utf-8?B?dit0eFZyU3ppb1lCRHkwQ3BhSXVFQ0lCaWlSZmp2ZXgwbWR2S3dSd29ERXAz?=
 =?utf-8?B?dEpuYzBGTmlTZzlFcFBpeHV1UjA3K1Y3bkN5UTh3aWNMcFFsN1VwdlVMMHNK?=
 =?utf-8?B?NVVITEdrY3d5MTZUaE9XbFNIcWhjQjk5NmJaTDVtQUI1ai93aFZZbVBIN1pQ?=
 =?utf-8?B?bDJFL3pFTzArWmhwTkxIN0c1NDNicDNhb2pFdGFZT0tDbEdpTmZQU0x6OTN6?=
 =?utf-8?B?ZHdXL0Erb2QxZmJMUGlDYVRzZUFHNFpXcmR3bmtXdHBsQitBNmErWXRVOWdL?=
 =?utf-8?B?RjVjM2RkTEhIS2dndm14WjZjWm5ONkdVU2pWT2dLOEdVNzJtTGgydDVPVjhR?=
 =?utf-8?B?TytlcjJpak1LaGkwdTlGTVB1OXE3L2IrQ2ZUeDVKYUp0V3RIRWlCcUhKa2Vx?=
 =?utf-8?B?MUZUcEN4T0RIaStDbXRad2gyQ3NOZHdzNmJIMlJmSjdPY2JBKzBMc1ZIeEhw?=
 =?utf-8?B?UEVFTGwwYVlhcnJmcEZoczZ5NVpLOCtFd0lScDZqNVlzU0gxM0dPOHZtYmlM?=
 =?utf-8?B?ekZ5eExodlRBM2RNZGF2RUdjR0JuSXVtdmpyOTdoSjU5WW5uSCt5QVArOXZh?=
 =?utf-8?B?WHRJQTBhOCtJM0ZSVDAvbjNKbzZ0dHVCTG40eUJMZ2lJTDNBTFJIVWhPSE9z?=
 =?utf-8?B?LzJwSzVIcktOQ3dpZ1RzMU1HUlNuU2J6WHlBNzhpQjMzMDlwMzZKUjN4aytk?=
 =?utf-8?Q?N+/UUk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDY0S2hta0s2dDk4ZFdqaWM4VDdPQjhFV0pSMFJwNGMvQytVVFBhMjIzQmtY?=
 =?utf-8?B?dHNqYk5sY0JsYm13YldWbFlPbWM1R3pZZmdRSnJsK3YzcHY4Z1hqdmNZRVd0?=
 =?utf-8?B?MXNnMWk4RHpub24vSzRlR2lLUHIvaHRRQW16WHlFRXhJdG5NZjhueGRFWWxH?=
 =?utf-8?B?QTJ4MnBXZkFzMExKQjdTeTNXaTk1d3ZNSHNNbjIydkJHYUM4aWh4SGx2Unh3?=
 =?utf-8?B?QlZxcDNRYjhMRkRvN09iYUNRUDlEdFVRR2pxbWk5WEt5RnpISFk4YmhsY0Rx?=
 =?utf-8?B?eGRHSStuUnZrSWUwQ2M3VVBVSWlScm9NbG80REtqb0cyOUgvcTZ6M0k3cnA2?=
 =?utf-8?B?Y2ZtbllPYWlkQy8vRXFYbXkvVEMzdjFzNFNRRHFqekdNYjFUbUc0MlZYR3dy?=
 =?utf-8?B?bzFxbTQ2QmNTOTRNQlI0aXRwU0RnODlsRHBJOW9NdktrNDFoUkJZbkFSRmQ0?=
 =?utf-8?B?YnFIQ2QwVnhHRzRQVld3Ylc5VHhaS05NMVJhbmF5VUQ1Rm5sYW5KVkFFVVI4?=
 =?utf-8?B?MEdETEpSeTVUNlBHa0svMEFSbVFRTFl2SEZTWnlZTFIwRFR4R0tXK2djN0pm?=
 =?utf-8?B?bktXRjZRbHFOWXNGbDhEb2duZ2k3anYxeHlTSHBnUnNJNzlBZlluTEpnV1JL?=
 =?utf-8?B?emhQMzRhQ1RZWWcxU2p5Uk5TNW9RdU9qVFA5Q0J1SWhDOVJGS2h5UEZtdENm?=
 =?utf-8?B?cTVBUE9uTlIwKzZxNlhDSDF4YjVaNTBJQkxkMzhiZGp2UzF6YmNkbVVSUG5t?=
 =?utf-8?B?bEFTSll5RGhvWDNDMlJyeitHMllyN0R4aytOVmpvNTZuZWU4WVhzdHFrNzBO?=
 =?utf-8?B?N2VibE1ZSnlyVGpBSmtXRk8zdGpKMUVrallXM2NmbkxFUmpnL2grNFZzbjh5?=
 =?utf-8?B?dFgrdGpKRFBxSGpIVDJudFR5elJid1p0bXc5RmVad2o0MHJyT0Q0cHZuN0tr?=
 =?utf-8?B?MkpyK0pLbjQyZlM2WWpRZUo4M0I3YkRDaUpkVjN4YTA3eVpmcDkwRm5QZGNw?=
 =?utf-8?B?VjhFWW5PcnV1aXVncldub215L1VxQ3BKZGRDYStITENqRkNzOE1WbnVpemdx?=
 =?utf-8?B?SEFIbWsrdkowMGVyZWRNeW9Yay83ZUY4c2NFUUZOT1RaK1V4MmVDT1ZHUGNN?=
 =?utf-8?B?Y1dSQWVlNG4rV3Rsa3lhdlJwc2VDaGZEM1VMaXpDbWV5RU5BeWtlOFh2NVJG?=
 =?utf-8?B?eWszME13eHBBZG9YUWZScW4xdlVuWWxNODRDZlhPSU8rRnVwSU16Q3VqSUc1?=
 =?utf-8?B?VnRmbTFSK2ZFdGQ5NWJZeHpyRzgvTk9YakJtd2ZsUmVzUVMrM1JkVnJ6ZDg3?=
 =?utf-8?B?cTFpOHpMWE5SKzhUZmpyOWNvcjRXTUZlKzNCei80ZHpmb3IwMW54aXJWeXYv?=
 =?utf-8?B?WTlYd2UyVkNHZ2p3TWE1cjdWRCtmbW9YOE5QRm9RaW5nUkJqQ093UytuY1pX?=
 =?utf-8?B?M3Q1cVd2NTVoWDNrZUJQejV2dG5mL21kMnZqU21NRlFhZ0tOV2ZDVDBYSzFV?=
 =?utf-8?B?MVpib1FCTkEyeXJDZnNFZ1o2ek9KalJBUnVZZFl1VFM2V2JtakZSMmpFWHR1?=
 =?utf-8?B?WHdsM292WTZtak9QN3FSeEplM3J5R0JyalAzTE5mS0twZnBEYWFwY0lFSWg0?=
 =?utf-8?B?a1VxNUFDOWNEM2J2em93dU9LUkptZys0SzVTZUhhTy8wTFEvV3B3YVEzY0VG?=
 =?utf-8?B?SU5VUmRETXExdnVLU3VESFd5enV3VnNLYzFISWZGRUxtYWdvMWx3TnVZTlhM?=
 =?utf-8?Q?qDQXIPXUATy9jXUU/PpAc9DDkdpaYTwFxJkLlA7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee3eaa2-07ea-4748-9493-08dd5d3f8086
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:15:48.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6242


On 2025/3/7 9:06, Inochi Amaoto wrote:
> Like SG2042, SG2044 also uses an external msi controller to provide
> MSI interrupt for PCIe controllers. The difference between these
> two msi controlling are summary as follows:
>
> 1. SG2044 acks the interrupt by writing 0, as on SG2042 by setting
>     related bit.
> 2. SG2044 uses interrupt number mod 32 as msi message data, but
>     SG2042 uses setting related bit.
>
> Add support for the SG2044 msi controller.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   .../bindings/interrupt-controller/sophgo,sg2042-msi.yaml      | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> index e1ffd55fa7bf..f6b8b1d92f79 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> @@ -18,7 +18,9 @@ allOf:
>
>   properties:
>     compatible:
> -    const: sophgo,sg2042-msi
> +    enum:
> +      - sophgo,sg2042-msi
> +      - sophgo,sg2044-msi
>
>     reg:
>       items:
> --
> 2.48.1
>

