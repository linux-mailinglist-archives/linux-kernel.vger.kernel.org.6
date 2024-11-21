Return-Path: <linux-kernel+bounces-416788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C319D4A40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32902282429
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55961CB522;
	Thu, 21 Nov 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="YuEXK8Wg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="z4Hcy9ie"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5123099D;
	Thu, 21 Nov 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.100
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182857; cv=fail; b=NvYAABmdGW/71hVtl7Fwt227Gt9pwVKGFEXPxRIQqYSk6HNFw7E1Mu+SLLU7LurSwqU95CHptFHH0l0enwny3mihS8z3pvyZaClMTU2A947tK12q7u6ipy/9+LHsOFTW/9l5UtCRV8KWsy81Yn52rMG9kUcftDFtqUWHQSiDRJE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182857; c=relaxed/simple;
	bh=UrPK3r0SvBiRjSiCnx9NbylfVXYMMGXoiyGpsVyAMrs=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BR4Hde6MTH5xA9XBekoBzsnCIrH87J4SpQ/x7m5PxiXU40fHC2AIPHyyTPuN/W7AHOY2HaITdzoNN1tmwhMYNPIVfTpUO44xNdALScAkRqY1+Vio54BSe83cSfATKnC9ml7Qp2g1qYrB4evpG7sOmHQMBUD/TTwmgrVNN0pcFkc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=YuEXK8Wg; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=z4Hcy9ie reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=GlveT00Pdgt8kKJZCSNOeDEvv99rIqUzjnStpJodIwuUDTpW1VkWI/3c9iHi3H1C/fgX5B7CJRwgMag55lE8B/XwDTN4b6Sx6UFNrOMtaBDSfz7AtqmMv95rMyjlDvzaJbm1guygCdAZ2xeDIJ/fiI/npr6Y6g30TvW463j+QgS7PYC+2FRlAMlybfKmGwGdJT8xB3971XWFZlXCPox7jXCRFYN8da2oMSQWZPylcV1D2iQIPJvQJVaEGageebY0vfRD3G4T9koOgjQHkAjbTFbeFuu+4v+T6KzU+OWoe+zRT1chEj72OvBaB2yS/MCgFAbgaMCkRF78vDPOYFEAGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrPK3r0SvBiRjSiCnx9NbylfVXYMMGXoiyGpsVyAMrs=;
 b=aObcmaiJ5nm7Xc9X7t4PGwFCxYkT33y9ooVkhb3iFjUh7aFA1RzEZpgfBVMIGwisnJhUKXZySpi9Zsbv9gwawWth7Pe5C+AAMsAmEmonO7db14UodFVO8frDjRpeGNplWYg1eEZSxTAdTQEB0EID8mbkGt3rNp/+6shuRLM3darnlHXP+VtmuE3vZ2oP7NlgUI3rPmHeQOsKuJaYATNIBaXES/BraJo5xY9UcDrswp4YV1Jq/ey/fKLoN9t7grbWi7D13Zan2FCjoU4wx13/795Q8AKIFpQovz8kz3FtmRXlFsCPQZTp+5OS7W+xNz+m/OcZrm5M/69Zg6OgKIFeSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=quicinc.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=fail
 (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrPK3r0SvBiRjSiCnx9NbylfVXYMMGXoiyGpsVyAMrs=;
 b=YuEXK8Wg2oafwb+p4whaJgh3iEXY4NRN1KcJXIk6/VJu7DRIgNJGMg+zSlZIomLaTEWfWfd9umhgw5h6IOu6i53Bp9WCjqvmqJeHnukOCjn8wl8YGnSw8I6Y16D/DzPPBc0qiakPB52mL2Ltu3SjUa7dY2uzToIHBxpMRA1c0wSLQIWbs257QUljXq32r+STN8Da1evoW659MsTNvDtzEYUZET3HOeUSwhxGjmGiDWN7NSmQJplNR0tIByYufzUfIqpxcsts/wLQ0ytOlDXEc2KhVc58kjD/c4nQuznFDyG/tw+FUQLCXsoa+KbOJqjCfK6FeIpkCp3ocxoFPISDZg==
Received: from DU2PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:10:234::22)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 09:54:07 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::95) by DU2PR04CA0047.outlook.office365.com
 (2603:10a6:10:234::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Thu, 21 Nov 2024 09:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 09:54:06 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.40) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 21 Nov 2024 09:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cShXL+s4V3n9/RNFnGCxRoWmyskbwlqD35JyYAhyPHnAmFBCOZz7B10p7MTwbguNusnTgEg1HqnzN6hrzIoy1yRD3Rk6sBvz/Zbak1pnnrZ2GSIbqY/0BI7OOez4M+mgsHE1F+WULAnZMNNM0UXxMh12yBlnBwFahVjegiFFiDYajSL23+uojt2An/PhzdIIivDaSpeDkjcJUQdwiIdKXwHNia1wIY86uKC/GkxMYwuJPe6/g9a1uYnWu6Uoy+UnmSmCklBIH7YYLkA0+yToSIBhc0knOtMoqHiAc1e8CV5k2vRF9989DmLh4sNsUBiN7YGtmkGQIM+bzegEA44rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8RMSz4kz1rPDz/R7hw9nUq/ThXHAsVEEgnhBLG3UB0=;
 b=SXDD81POWDVRp8X+4ZUR3FOIXqV0do4ib1hQeUibT1Np3ZhT6NnzAHAOa9h0sNeI44CNPOclwrSBxAL7jjTZ57uEIyW+Uw1ylaCBha77q3k/a3j30wXjtMV4OB1jyvzY/lTri+wabcQemrz3oWerG3atcT/+kR2C8wpQvDHgvzKwUeqNmJSXb9ZIKUrbvCXZmStDlrAXkVkVKcYOnmiLfcIlyN8UTDgfn3cvxhH86LlhSL8UhXumNni6wohJflwx8hMhi7ceQenl1ECQBUp4Om4aEcQ8g2lO98fzkmkcgdsd5y2yGk4Nepo2CFrK63xk6aGMuT9zyOmhzSHEDueaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8RMSz4kz1rPDz/R7hw9nUq/ThXHAsVEEgnhBLG3UB0=;
 b=z4Hcy9ieOFKKl9fHdJGqXrYvmwdZRdocm1MDGEz0EApSXD7G9JH5uk+MZhbOR5w94OFBOYXza/hv5YAkAaSU2I5Zhlod0Ph2kiT301xbFokBACTx2zsFXw0YxCruWScBd9lCHZSUrY5zxSUscNqn39RoHxbsXOB40c1DZzuTgh0fiMDbFpOJ2cvEqjA+1qwfgVgLTcHK4OdVGgQxEhx+WsbpENq4wXpXinhXwuTSPmgLr79owkNYfLgv8nKpaM/BqU7wv8m1ASGw6+DYKyrpxgUBqKQYrm7TA9rVpn+6+znWsslYtZVNEzvIfUvOndf734li8s8x2Q0CHu3KKDcTtw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 09:54:00 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 09:54:00 +0000
Message-ID: <e3c88450-fbe3-42b9-a2ed-901ffdadfe1c@topic.nl>
Date: Thu, 21 Nov 2024 10:54:00 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add microchip USB5807 HUB
To: AKASH KUMAR <quic_akakum@quicinc.com>, Rob Herring <robh@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.656f2a13-85bf-42a3-8490-f97f2538d8c3@emailsignatures365.codetwo.com>
 <20230522074510.16367-1-mike.looijmans@topic.nl>
 <168474408440.1935852.10036260685386476051.robh@kernel.org>
 <96bc29bf-b601-4852-ac9a-50091698529d@quicinc.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <96bc29bf-b601-4852-ac9a-50091698529d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM9PR04MB8437:EE_|DB3PEPF00008860:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: c51e7f94-b343-430f-26f3-08dd0a12707a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VjljSjk4cS80S3lGUlIrb3NWM0o4UUc0bVF5a1NxSWJJUlliWDZrZGhIQ3RE?=
 =?utf-8?B?b2hyaGJobzBxMHdFelJUL05LSDhuTlpXdjJrQjNvOUt5RFUyVHNVQWgwK21j?=
 =?utf-8?B?clhMWHR2S25EdWRsMWdNenNuWlFna1pLN0VBRGtocHpJN3RGV05pYVcrSE1C?=
 =?utf-8?B?aERMQ09FL012ZGRhTklIdEoyZVR0eUlNMHpJR1hZTFF5aTdHVURmN2JnWUhY?=
 =?utf-8?B?cGZpMXlzam9TZWV3SUErTVZxWnVsL3FFWFgxeTVxUkNaRFljT3hUdTJwNjVw?=
 =?utf-8?B?L3RJdUVpZ2ZiRzFQa1NzMi9MYzdZWllzQ2tCdkFjNkR2VXVQN09aRm9xUE5z?=
 =?utf-8?B?a3lYS3RuNWhSS2czVDlPbGJiUXFrV0RKUGQ2Z1FVMFhBeGtEcUlKTGJPZUtF?=
 =?utf-8?B?K0VEdVVOcWY2T3pkTC9mRnhqbndacGhjTVdvM0ZlUlhBVjVSNUhOV3JTMEw1?=
 =?utf-8?B?RFNXLzRmL1ppNE9oNjlhRm5RTUpZVkJqWTU1V3pDVmpuUllodXdUdUZsMExQ?=
 =?utf-8?B?TjVzNStOOXlYL0pzRjBEVWQxb0g0NDVRcTNiU1Y5TWRRbTdtNGJOR25Rengw?=
 =?utf-8?B?REl0aWM3YVNvd2xJWitVM09hZ1djaVo2aTVyWFJCRDJlYUxSbThDOEVPU3Zn?=
 =?utf-8?B?NUVLWm9zQWlzYXdIODFmMkFTT1hSL3FndnFyamhHWHVMemtvZHlvN0JNdUc2?=
 =?utf-8?B?NVFqVStSd0pHdUNHUzQ2L3RLZjVORTNyMUY1L1B5ZkhTWmhNVzhKaFBCdDhq?=
 =?utf-8?B?S3E4RFN5Yk9YSVExRUp0c251eFBkSVIrR1lwOHJrYUxTSXFDTm16a1BvcjVY?=
 =?utf-8?B?UHdpYTEvc0pMRUt0emQvQnZ3QWhudnkyeXlpNmJaOTdGSlRNbGdnN1dIR2F3?=
 =?utf-8?B?cnpvWHdPOEx6b3JUZjYwa3NVSXBZUGl6UDJaQnBMdmxBSHBJb3Q2Z042TFFo?=
 =?utf-8?B?WmxyVkFUalRxdytkZ014eEtvcU5jTHBESTVTUER1SHdPelVRMWMvVGZKUnd2?=
 =?utf-8?B?dmtwYkFnUlZxcTBScjRKcjBzWENhSWh3ODlwMU1pSUxtUFhKZVMyclFxbjNy?=
 =?utf-8?B?QVZRbVBmMi93WHcxMkpmUzcyd3dQK0wzYnU3ZzQweFVid3NTSVY3d0tYK3Zz?=
 =?utf-8?B?S1RJSkJ5U3hRdXptaGYyaFZpQVJqNkxNNGNlamtRNEF5U1grZGtKS3YvNkxv?=
 =?utf-8?B?NEVXdTU1dHE1YVlJN2dPRFdOTjBjZXFRZms3YjFIYlhEK29mcXVjTm1Tblcz?=
 =?utf-8?B?TWFzM0RyOEY5V3VMMVJ3S2hQaEU5MkdFc0xHYlphcmVEV1NmcUFOUGc3Vjcz?=
 =?utf-8?B?ZmUvNDVralBjR0N1NmlQbC9UaUdNUkdGSkRsb3BCTmpEWUdFNjBCOXRLclZj?=
 =?utf-8?B?MTFJVEYvMENMOTBzZmVsSTZEdXJweVR4WnhVNG1JWWUxZTNhOFh1MFdQbzBB?=
 =?utf-8?B?OXJhZ1JzN1NZbHFVbFpuZTVkcXZ5VEd6a2VDRGRPelZLcGwzVERiczgrc3Ra?=
 =?utf-8?B?N0tPMGYxTE1UZEdzTyt3R24yUElpZFo3aDdhY3pFZzJBR3g1R2ZtK3FTSDVv?=
 =?utf-8?B?QUVhb2FyOWtqeTZESEtmV0htcEhoMUlnV29yZXR0dHN5SFFBMmp3TVh0bERw?=
 =?utf-8?B?Zmt6ZVd0Q3dmWlIyZVVGWlRFK3lKT0xXWG1yUDdoQURWVXp2Z3N2bXBMR2dm?=
 =?utf-8?Q?VMapNd6uWKkPe4fC5tjS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
X-CodeTwo-MessageID: e03bd4a3-ab3f-4e17-822a-9330ad84efac.20241121095405@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	264aed8a-f48e-4851-2faf-08dd0a126c9f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlE4ZURzbXlvS2pWUk04aEtEQ1ZpV3VJRWUrUVd5MWQ5bnhYaTQ0M2JpdVpk?=
 =?utf-8?B?NEJzbWpLV1FUZmVvMzRuRzg5V1Erbk45SGpUT3VwT0sxb1g4dithL091M2ZH?=
 =?utf-8?B?Ynl1OGRuOVg2RzRCQXdtTjQ0bzdsMjBoM0YrTGw3ZllJNndmeURJaWx5bGJG?=
 =?utf-8?B?Wm1BYVdxSGROVVBxeXBob0NLNnVLazVxOTF5SUdzSEprNE9qZTdnNlJIc201?=
 =?utf-8?B?RnBrTy9Ka0pPWGVURUtKcEJDR3owQWVYVVdWdlBmTCtQbXNNL0JUNmplRG1U?=
 =?utf-8?B?bk9uaHcrVkxwdnVyLzV5OFQrdVowU2VSK0NNQkRXeit0N1NGaGQ5bXhCN1l1?=
 =?utf-8?B?MzNWVkVYa29PanZISEE2RHMvUDE5OERUVW0vNE42VkJrVjZKM214VEFWUHhU?=
 =?utf-8?B?dkJaSmt0V0Q2VjZFNE0rcW1YbmFhbEZyeVkzTjV5YncyN1NtQUlva0lqTnpU?=
 =?utf-8?B?TDQ4cUdEZjZYamloaVhLcmZtU0ZaRUk1ZVVGcUZsYlF6bDBZaGRUaUsrTlc0?=
 =?utf-8?B?b05hK05JcXZvWUgyUlhoNTc2aXhKK3NiWGZJb3NGbGJVbUw5djVQSVFoWG80?=
 =?utf-8?B?QzJyaXQ4QnF6MVBsWDdvMjRCUlBITXZmVDlZYU9Ec3VJc1hBRm9oNE5OWWZF?=
 =?utf-8?B?N1dlL3hiQXFMS2lOYXdROENLZEVwUE1rMTh5djMyb24yY201M3hrUU1CT2U1?=
 =?utf-8?B?eUQ4TXl5OVc3K3Z5SHZEUTVEalZrazNKbkFFTUd2T3ZhQVFCSlpBMWhmc3ZE?=
 =?utf-8?B?SnM1NUdyVEovL3pMc1l2YW5DYkdJNEZ6Q3dWOTNiSWlCdFB1YnFqTTZNbG9z?=
 =?utf-8?B?bXJNbVhaV01waE5maU5JZmdocWZ1Umx0VExxNlpmYU9ydERFUGJ3eS9Bay9B?=
 =?utf-8?B?WnRldXlXcml5QnJKcjgzYnVKUEdRdzZnR3BUUGt4cWgzUHVyWFFhd2dUQjVF?=
 =?utf-8?B?VlFQa1lQRmtGREg0ZksyWjViZW5mVHVuZkRLRHhqY3gvZTFuKzlVbTNneEFF?=
 =?utf-8?B?KzJvL3JXZi8yaFRRczZYOFp6blZpUXFPLzZoT2tDMDJkWWlWamx5eUlGTVM2?=
 =?utf-8?B?NmxRU2RYK1lydWY0dkhUeUEzdUVRVllqRFBXcjlEOUVsU3pzUks0LzhyUnFy?=
 =?utf-8?B?UE9sSGxSbldRVHYxN3UvbHloblFTV1lVNFA1aU41V0h1b00zM2toRGFoYkdL?=
 =?utf-8?B?WE9XYTJmQVoreVY2VllpcVN4aUUrc1ZoUWlQd3RhWnZzOWNRRy9UaUtHbGJ4?=
 =?utf-8?B?WHFMM3dSUHZjVTRobWt0MURUWm5BakJaNTlXbTl1TWpsMnMwaHZ6SmVDN1VF?=
 =?utf-8?B?K0RYWWJtS1hBSjQrM09ldnpLVHZmVjdIVkxqeGJNcGJWS3hRUEdmck9QVUR1?=
 =?utf-8?B?aDJrWGtPTmNWUWVlWUxJU05ZanFyUGd6dzlkTjZxbHdtUzNmVTdrQXA2Wm8v?=
 =?utf-8?B?eTJLUWh4bkQ1U3Z1ZVRuK1pMQ2IyM2JCUkpXdTFzVFJSWnUxbVgxUjdqWlNE?=
 =?utf-8?B?ZHdGcFhCcEJ2UnBWWm1tZDh4SFZXaGFEckNXa3FqN3hUdDM2QXFLRW9uRWdZ?=
 =?utf-8?B?Tm40cERLM05KSnNiTVVWekJNbFphK0tzNGNCelExaVp0UWdrVUdhSXRtS3Ft?=
 =?utf-8?B?ekRiclNnT3dlNjJKT2NyVWNuN0IrZmRYajE0WFF2WjNUQmdFYUZESmMzSmdJ?=
 =?utf-8?B?d3pOUVdZMkV6YXcyb0MzZFQyZ0hYUVZDZEdKeDhUczFwT25NYkdkaU9OUUxy?=
 =?utf-8?B?L3dyY0V0TEMzSnR5ZE11ZzNOYTgzazdITU5NZEZRSFc1eUt4U1RYaFVselpn?=
 =?utf-8?Q?FfPGK9NuJ8J7YZ9Lzz5LW0jadSAXqkiZhTgP0=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:54:06.7658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51e7f94-b343-430f-26f3-08dd0a12707a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

Hi Akash,

I was planning to, but the project was terminated so there was no budget to=
=20
finalize it. You're free to take over and make the required changes.

M.

On 21-11-2024 09:34, AKASH KUMAR wrote:
> Hi @Mike
>
> Do you have plans to mainline this change?
>
> We are using microchip hub in one of our project and we need this driver,
> we have taken your change and able to enable usb hub.
> Please check if you can push updated patchset addressing the comments fro=
m Rob.
>
> On 5/22/2023 1:58 PM, Rob Herring wrote:
>> On Mon, 22 May 2023 09:45:09 +0200, Mike Looijmans wrote:
>>> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
>>> This driver resets the chip, optionally allows D+/D- lines to be
>>> swapped in the devicetree config, and then sends an ATTACH command to
>>> put the device in operational mode.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> Add minItems
>>>
>>> Changes in v2:
>>> Rename to microchip,usb5807.yaml
>>> Remove reset-gpios description
>>> Add maxItems
>>> Add vddXX-supply properties
>>>
>>> =C2=A0 .../bindings/usb/microchip,usb5807.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 58 +++++++++++++++++++
>>> =C2=A0 1 file changed, 58 insertions(+)
>>> =C2=A0 create mode 100644=20
>>> Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check=
'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
usb/usb251xb.example.dtb:=20
>> usb-hub@2d: swap-dx-lanes: size is 32, expected 8
>> =C2=A0=C2=A0=C2=A0=C2=A0From schema:=20
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
usb/usb251xb.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>> See=20
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202305220=
74510.16367-1-mike.looijmans@topic.nl
>>
>> The base for the series is generally the latest rc1. A different depende=
ncy
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Not=
e
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your sc=
hema.
> Thanks,
> Akash




