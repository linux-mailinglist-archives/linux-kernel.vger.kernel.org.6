Return-Path: <linux-kernel+bounces-275850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B93F948AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405022834F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1C1BC9E8;
	Tue,  6 Aug 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T58vABGP"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011012.outbound.protection.outlook.com [52.101.129.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80144165F1A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931935; cv=fail; b=bDpjZkR2pGBJ/2GamCuYMxGZ4HXozIjNL+Q49ilMw2xlGOaXkcKl9AUa1O6+Xhs7sDytZzdttJIaIyOS6AzQ10eptmUcWieh1S/TCez/tqHYyOiI7m080/Cn9/gnIXqgXAaJDyD6FKhi5F8lcP2wH5gSVYVEo/kTZzC+8RQKvWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931935; c=relaxed/simple;
	bh=6g2PA67sqJJtUdpE0l3Oo/hnCjlraMG0uKI0VGBtlBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQkTwsTEZGkZvqoLLgg8wXtmudMPdkay0OBZrLhdAjv+T7QbkcHB7S/LMIbVK0zi/BxtqYvS8Pd9LBkaWo6PXqniU+2V/tap4XsBHOmLSSvX61vI7hBesLeT8Za++L7ImVoyRsHJl5VzadyOjIvngoJ2rHIo1UStnYKNFYHFgBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T58vABGP; arc=fail smtp.client-ip=52.101.129.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf1lBNbHv1NHmNN4nuCRKvni/n/aveCerCyOKCIUCry5euKIpAFRrhyAbDtxl6PpxmWwOw2xYnQQgKmM7Su8Km52L+Stq6Fe/UcYffWAM6trcPby7GanlvBw8DGjyHCmUC6ggxm9wM3+d72jiSixTgMYvURWiEGgJs8iGwCBwa21mHaDCVs4pa/IW3JjC8qGinK7rZkJMhzpjGj6h4bMR3d6dnMgRBrTI9tcFwveV2lwgQff3e1nWf/JKIFEBl1a9Iv3JiOEHeh2OkvIgSQrY6ik64rSIE8m9LBFar5hwiVZq+qVUMu3emK50UfaVTVJ5wgzWO99CD3/HdV24hyoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PEwvaEk98Iw6vu6Jkexsva4qaOfYwMqtQZ74w8pcYM=;
 b=s4abwdAiA1LzyZQm3Dft2/UeUKrF3gM6SU+Hsoqi31JP8ONO783rSLWNyCgjZuFXA9jUE1/wlBcVssuPRCq7iX5KfPm0uAohJlKmuQ9mqMhTa69ebg3Jf0AOqMRvNat1249qMAVbVoM8p6BrWavf1s2PY9DelwgYFZXDmIe5Lpx6QGmBGmTLWC9f67YC6K6vKKR5jg+GfOt0v/d86tSp0BtEY9zGxPFCSt0WxSxCzzYM90G5M96r3DARIQel4DF+b5RqlC3yvYyVZD0FDTrQlUPwInl6cWH+kYPQyzHXAppjj7K3wCaJdMDg6OQM4Uc2edy60ms4YJtMLN6cN1pt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PEwvaEk98Iw6vu6Jkexsva4qaOfYwMqtQZ74w8pcYM=;
 b=T58vABGP5Tuc0W/4gzRcBPiE6auiYrWU0b/qtpUir3zooch2M8GrApzde0c6AvsISm+UpDYy0Rb7VaMkg/atQ5CMSFvwl3yPf5SR2vJqWo6bHbDAQq0NSCeG0mC/SObbOglf0I8015me/dIcRLaZrS+5SCuqhgf16n7hp/2xwI1s2Da7OqM4MNBKx0BR3xAma54Cd0i4SEXBT7Wf/mB/MWexKY/ycNpRYXfvHOKYfdhMP4oALMwdwvvfrgbC+LvGm3EAEO9sn9fqEj/HH5XcCIQpla0lHFTsXI4x0Bo35dnKgPmYCsVXfrbHNHvPo4WKVLDUoJeTlBIwFnwjyY6YVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5600.apcprd06.prod.outlook.com (2603:1096:820:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 08:12:09 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:12:09 +0000
Message-ID: <dddf025d-ec58-4d54-8e88-96103e8cded7@vivo.com>
Date: Tue, 6 Aug 2024 16:12:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: mTHP frees entries as a whole
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 opensource.kernel@vivo.com
References: <20240805160754.1081-1-justinjiang@vivo.com>
 <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
 <3699860f-3887-4a99-b9ef-10e3f86ec3bb@vivo.com>
 <CAGsJ_4zNd5oCG1vpWRJxOQgPRvyO3AbjGM5nt9SxGjm=YTcrdg@mail.gmail.com>
 <dee6bf7c-ae73-435b-a6d5-ae966dfec048@vivo.com>
 <CAGsJ_4zC10LK+r9ugutiu3ys1HcrpRMzD-m8YYJ1ALbo-Fdyow@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4zC10LK+r9ugutiu3ys1HcrpRMzD-m8YYJ1ALbo-Fdyow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa5f570-407a-49a6-af34-08dcb5ef77b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGJIbS9rcm5LZkl6UnNxMkJLN2dvSEszM2NmRVhCSGpwU2hNcHBmNWgwbWxQ?=
 =?utf-8?B?TWRWa3A2SHBwU3Q0VTVuTUJqRzBsV3pXRkZZd2xvaXhuYjZzRlBLaC9DOHBE?=
 =?utf-8?B?eWdZNm9YT3Rvc3k5SGdFazdYekNDS0g0TWtTWndsY1dtSG54azB4MG9ya3li?=
 =?utf-8?B?dzJzMmE1N3dRdlJTK3pDMDZTYmFiYVRnNG1kVnVCVXd1WGJUTXk5QmdDZ0sr?=
 =?utf-8?B?SW9GYVVvVnJxZTJwM0JpdDNTd3lGWlFISFBLbTYzUUZwclZzZFlXaFhkY2Ju?=
 =?utf-8?B?aW4xd3RrRTdKcDVESFV5S21VN2svOHlDRGRZMU9MckVTZUQ4Ry8vZlFmeUIw?=
 =?utf-8?B?LzRTdnZPNTQ3cU5vK1ZqZHJINkZPM1FpT1ZkWXlYZGJwazh1YStvRzFLVVov?=
 =?utf-8?B?bGk5b3N1bHI1OEVxV05JeG1QN29wRGNmL3ZHQjIzYXlWQStRTEowczdGN29H?=
 =?utf-8?B?eHF5QVBOTnRndHRXYVBrSFk4elhkVFE2M25qYWNmVW9ac1BTYXIyVGl5S2RG?=
 =?utf-8?B?SElsa29ETnlJUmhWbCtucHYxTE5Id3RpaW41clZwS2lNSnltQ1dlc1RuOGRC?=
 =?utf-8?B?dTlwZjlmKytScjd4WjE2Y1Vma0hyaFJPZkZKTjNOVjZmMFh6eUNxUXdhMWtC?=
 =?utf-8?B?UHVJdkUyOXVHVUJNUFlBd3czTlRiRjBXM1pwQktwOG5ybmE1dDZpMGdmMFFw?=
 =?utf-8?B?bFA3bGFCSnJXbDU0MVpLaWtybU1iaVhaYVBSRXgxM01seER5Z3NURXF1RVF1?=
 =?utf-8?B?QUtvcnJSMVd4RzJZZS9YK3QydUtubVhGdSthMzFHNkRlTllKKzgyQnR1Q2V0?=
 =?utf-8?B?TnArcWpaOGJRbWVHZ0w5TXVTUFppbGlBak5uaDJtZDhkdkdGeC9MY0lySlZ0?=
 =?utf-8?B?ZnhsRytxcitCTVN3eWR6VTZzVlJ1YnNxQWVkOThQZktFTWUrdjZ4L0czNzhQ?=
 =?utf-8?B?cHlVaEFPUHhTM3EzSStObWVuaFFscUNGVkRjWk8xb0Nld2s1NFhITHhWb003?=
 =?utf-8?B?ZzNRMmx2Q2ROWmxKbnp2T2FVY1lqUWlvSDZDSmhqcDVhMWp3VGhOd3dreXJO?=
 =?utf-8?B?ZXAxVE8yWHA5T0VSNGZzTkt5bnZDa2o0MkUrWXRDckgrS1NxTExFbW1ZZlFq?=
 =?utf-8?B?QXdlc1J1MGFoUVZUbW04cndnUlRXY1hDYnBDU1pZL1dubkhSeThwdkVhbVBo?=
 =?utf-8?B?a05hLzFIREZWc3lJam9pVUdFb2dmakl4NGlEVXAxeGdzU0Q1TzdNeVRxWHlX?=
 =?utf-8?B?U0RMazNCNWhTbTY4L3ZMcHc2N1hnelI3VWtKbCtSTFhkdkxZYVBRWUdTbTA1?=
 =?utf-8?B?TjlCLzQ3azM4V1Z4YnZnVVZUV2FGajdLc09TSkxacUdzMmZZWW9oTnh5ckpm?=
 =?utf-8?B?bHFjVkhlVGdKNmtBMkEzdHRtRnFkdUlCczJQbVhFd0lwZXRQaUoycDloRVV2?=
 =?utf-8?B?THNFeEJrcFZraWVOdm0ycjQxNUtVN3c0TFplcHpuNmxwZkZzcENIWnE3TmRM?=
 =?utf-8?B?Y1VnMDRtM04wNTBqeWdvMU5zL1JLem5FVFM0eU5vRVBqTTZWUWNPcFg3RWpt?=
 =?utf-8?B?UzRtZ3VsUDZBR3VLQThOdmR6VVNNb0ovQjhOZTRvR2taYlpTUUhBVTJLeHhU?=
 =?utf-8?B?M2VLNU80YTN4dWtxTzNtVlVBK2tLbXdVakdlNGUxbnYydmR1dGIxcm9MOFNu?=
 =?utf-8?B?M1JZUGpLQWdEVm0xL21EYUdCRWRNd29iOHFOT2s4amZmZGV4NWlQcTJlSG1N?=
 =?utf-8?B?RUNPamdicTBwSEpHcXNOYmQ1YVJ5NkZpTFZSM0JYeWlEK1hzRlNYSlZ5OU04?=
 =?utf-8?B?WlN0QTd1M1lvTzA1L3l6UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEFDN3UrVzRKME9ya0NLa1lSL3JmVktucmZWZWM0N0JtQ0dNQStubG5EeFlG?=
 =?utf-8?B?S2tNNnlWbXJkYXRGSFpjQzZWc2ZsMlRYQTQxNXFZcUxXb0x0VldTZzY1cmpn?=
 =?utf-8?B?cFYwZEpKNUpxN1VTWlpVQTZ3ZFpYQzBacFY0cjhjalZKVFpPeUEreXVMcytK?=
 =?utf-8?B?TlNRTXZTSFRDbENZQm41V3hqN09seWE2M3JiNmVpeGoxa3RFZ2FqM2Q0OFU5?=
 =?utf-8?B?RGtLTFByNDgyc1F2TkF6eHc2NGhkQXZXenFKMmJiRXUvdUZBMTFaYkZlN1oz?=
 =?utf-8?B?ZEFJQUNRRStrK1pXWHRLd0J6UFh1S3NpV0RGRExxbHZKUWsvZDhJWGJuay9J?=
 =?utf-8?B?YlQ4QzZPbDF0YU5hQWE2bXZiQlMraW5STFowbTM1b0pQQTBmWlp6bGkxR2Rz?=
 =?utf-8?B?OTNZY0l5cmRhZzRUTHJnOVVka2hTd2h2WkNGcnNMWmVHb0ZGMVYxaGhoZFFm?=
 =?utf-8?B?UHphbEI1eTZVZDRlRXJiK1kyZ3pNRCtBSXN6elAyM056NW9JSTdjMEVMUjJC?=
 =?utf-8?B?d0c0WjRocEY0UWhkWEZtMDBFUUVTN3RONVE4YWdwS2VUNno1UEdhWVkxZjhi?=
 =?utf-8?B?dVY4cGxuV1IxNnlQeEVRTFk4bVg1dG9STC9TbEtKRGg3U3lYSVA2em1VVUNY?=
 =?utf-8?B?L3NmcmpMK21yRjljeWpiakVEUG5mTEJndmR3QkxJaFAzVVhnbDJyMXhha1RV?=
 =?utf-8?B?V2lyaDAzeDhNdTU1eVhHV3NZYUV5RmxMV3NOSE1MM2gra2tZZGtyeWl6YytQ?=
 =?utf-8?B?eTNQdDl5bVVsVjlnMzFCSVc0aUE2ZTAvRk16TjNxVXVsdTFmT3VFZG1hQ2FB?=
 =?utf-8?B?ellHSTBiUUFJMkdHQzdMQTZlNHM1NUpoMXFYOStYVTlKSTlKY0E4V09DOWsx?=
 =?utf-8?B?czdoZVFHRjVvd3BZbWQvV2N4YU5vTnFxNk9PMU5wREM3b2hydm9heCs5d1Er?=
 =?utf-8?B?V0tyTXFpMU14dy9KTm9pVkJYcmhzRzVPOXhsd3pCYzNVN2pKYWJCTEdnVHFD?=
 =?utf-8?B?eVZJUFJadWw4MjRaUG5LNXgyRy9UWElnNmplRFc2M1JlM2lvOWNQTlF2eHFL?=
 =?utf-8?B?RGFleW9iVkFWT3pLazZsdjFHSnNXUUtsRnFJTmRYL0RpQzNtRWp6U0hCVndw?=
 =?utf-8?B?R3pOV21sRHFTeTNGS1k1QTFJL0I0RUtYREM1REhpamgyVTQ2Nm9Rek00b1RI?=
 =?utf-8?B?Qk5vaFJ0UGJZb0p1V25LTGNVK0JxbHh6VitNbHlrOUpMcnIvSVJwREthc0Nm?=
 =?utf-8?B?YmkvSTZEdG9jcUp0bEhYSGE1bEhEanNxTjhGT09CRTY3Mm15RkEyTE5Ma2Fl?=
 =?utf-8?B?bzZLNlZTL1Y3dEg5dXhxRmpubldVRWVZSzY2d2gyN1ZrckszeDQ0Y00vaTQr?=
 =?utf-8?B?Zi9BV3dkazVLRVpNQnRSajFIc2xScFBRRzM0eGlMTkxLY1N6NnZBZGprcEIr?=
 =?utf-8?B?QkRSdDBtRkh0bzhnWkJJWVdHaDBTYU1BUEE0bjl6WHN2S2VMRXRHUFQvTDBD?=
 =?utf-8?B?dk02UHRCWTNyaGpZU0RaUmJReVdzU1puZUYrNlVSOHBmU2QwdEJwSWM1RVFs?=
 =?utf-8?B?eVU2blBOc3ROT2ZQa0psU0pTV2dhQ3RrbHp6T3RINzNYTWxYTjlML3ZTRGE2?=
 =?utf-8?B?d28zd2JVRVhVcFJaV0hpbGRVelVidHBQMVpqR2JQcU8yY0hpTzYzTzgwRWJk?=
 =?utf-8?B?KzFoRytkeWx5MHE5OEg5V1hiQjZiNXR3aXNhZ0pOOC93aVNWUHE2TEVzM01x?=
 =?utf-8?B?RURhbHpSWmdKekZ6cW5mQWRZakxEM24zZ0pEYk5LSGFab0NqTXpBRzFwaWhV?=
 =?utf-8?B?cnlTY0VoaGFPR2dZR2NUaWkxalN1UFZtSVhHTm9TWTFCUkY5MkRZMmNXaVNp?=
 =?utf-8?B?Tk1HMXJMZUE5WVlMbjB4MUxyZVpxa3BZWkZxdE4yWStYUElXQjBjNDNtOGtH?=
 =?utf-8?B?d21IcWxSa05UTGxsNDlMVkVRcjZ5L0tObkM4YkQvNUx6SXlCUnlRMkpKQ0Na?=
 =?utf-8?B?SXpBY25abHB6dFFCYi9hY0NaSXkxYVhUeVlpUVMwajdRbXlvQzhpbVBRM1Bv?=
 =?utf-8?B?ZWQ5eG9JWXRheE94L3hReHZ3b1BjdG5Fa0lLa1VvbzJOa2NxSTZlVDV2WmZG?=
 =?utf-8?Q?IL3foQz+Yu8BWVNUrlHNKuhSf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa5f570-407a-49a6-af34-08dcb5ef77b8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:12:09.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsqHkhS4/jsD3JxKiUDqvHSE9OAg5/hb32vzqaINOtzSuHqz7GuMuUqRTyrvYLDVQZl7r8Sn5V+4cDR+fr1h2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5600



在 2024/8/6 14:48, Barry Song 写道:
> On Tue, Aug 6, 2024 at 3:41 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/8/6 10:07, Barry Song 写道:
>>> On Tue, Aug 6, 2024 at 2:01 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>>>
>>>> 在 2024/8/6 6:09, Barry Song 写道:
>>>>> On Tue, Aug 6, 2024 at 4:08 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>>> Support mTHP's attempt to free swap entries as a whole, which can avoid
>>>>>> frequent swap_info locking for every individual entry in
>>>>>> swapcache_free_entries(). When the swap_map count values corresponding
>>>>>> to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
>>>>>> entries will be freed directly by skippping percpu swp_slots caches.
>>>>>>
>>>>> No, this isn't quite good. Please review the work done by Chris and Kairui[1];
>>>>> they have handled it better. On a different note, I have a patch that can
>>>>> handle zap_pte_range() for swap entries in batches[2][3].
>>>> I'm glad to see your optimized submission about batch freeing swap
>>>> entries for
>>>> zap_pte_range(), sorry, I didn't see it before. My this patch can be
>>>> ignored.
>>> no worries, please help test and review the formal patch I sent:
>>> https://lore.kernel.org/linux-mm/20240806012409.61962-1-21cnbao@gmail.com/
>> I believe it's ok and valuable.  Looking forward to being merged soon.
> Zhiguo, you are absolutely breaking lkml in another thread.
> https://lore.kernel.org/linux-mm/b2ea5b52-311d-4c6c-a59d-9982b8723738@vivo.com/
Sorry, I am not yet proficient in this operation. Could you please fix 
it? Thanks
> Allow me to address your question from that thread here:
>
>> +       /* cross into another cluster */
>> +       if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
>> +               return false;
>> My understand of mTHP swap entries alloced by by cluster_alloc_swap()
>> is that they belong to the same cluster in the same swapinfo , so
>> theoretically it will not appear for
>> (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)?
>> Can you help confirm?
> zap_pte_range() could have no concept of folios (mTHP) as folios could have
> gone. you could have the case:
>
> folio1:  last 16 slots of cluster1
> folio2:  first 16 slots of cluster2.
>
> folio1 and folio2 are within the same PMD and virtually contiguous
> before they are unmapped.
>
> when both folio1 and folio2 have been released and all 32 PTEs are swap
> entries, zap_pte_range() 's
>
> nr = swap_pte_batch(pte, max_nr, ptent);
>
> nr will be 32.  "mTHP swap entries alloced by by cluster_alloc_swap() belong
> to the same cluster" is correct, but when you zap_pte_range(), your mTHPs
> could have been freed. swap_pte_batch() just returns the number of swap
> entries. These 32 entries are crossing the boundary of one cluster.
I got it, thank you very much for the explanation.
>>> Please note that I didn't use a bitmap to avoid a large stack, and
>>> there is a real possibility of the below can occur, your patch can
>>> crash if the below is true:
>>> nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER
>>>
>>> Additionally, I quickly skip the case where
>>> swap_count(data_race(si->swap_map[start_offset]) != 1) to avoid regressions
>>> in cases that can't be batched.
>>>
>>>> Thanks
>>>> Zhiguo
>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org/
>>>>> [2] https://lore.kernel.org/linux-mm/20240803091118.84274-1-21cnbao@gmail.com/
>>>>> [3] https://lore.kernel.org/linux-mm/CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2qY2AgSxMwTQCj3-8YWw@mail.gmail.com/
>>>>>
>>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>>>> ---
>>>>>>     mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 61 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>>>> index ea023fc25d08..829fb4cfb6ec
>>>>>> --- a/mm/swapfile.c
>>>>>> +++ b/mm/swapfile.c
>>>>>> @@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
>>>>>>            swap_range_free(p, offset, nr_pages);
>>>>>>     }
>>>>>>
>>>>>> +/*
>>>>>> + * Free the contiguous swap entries as a whole, caller have to
>>>>>> + * ensure all entries belong to the same folio.
>>>>>> + */
>>>>>> +static void swap_entry_range_check_and_free(struct swap_info_struct *p,
>>>>>> +                                 swp_entry_t entry, int nr, bool *any_only_cache)
>>>>>> +{
>>>>>> +       const unsigned long start_offset = swp_offset(entry);
>>>>>> +       const unsigned long end_offset = start_offset + nr;
>>>>>> +       unsigned long offset;
>>>>>> +       DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) = { 0 };
>>>>>> +       struct swap_cluster_info *ci;
>>>>>> +       int i = 0, nr_setbits = 0;
>>>>>> +       unsigned char count;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Free and check swap_map count values corresponding to all contiguous
>>>>>> +        * entries in the whole folio range.
>>>>>> +        */
>>>>>> +       WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
>>>>>> +       ci = lock_cluster_or_swap_info(p, start_offset);
>>>>>> +       for (offset = start_offset; offset < end_offset; offset++, i++) {
>>>>>> +               if (data_race(p->swap_map[offset])) {
>>>>>> +                       count = __swap_entry_free_locked(p, offset, 1);
>>>>>> +                       if (!count) {
>>>>>> +                               bitmap_set(to_free, i, 1);
>>>>>> +                               nr_setbits++;
>>>>>> +                       } else if (count == SWAP_HAS_CACHE) {
>>>>>> +                               *any_only_cache = true;
>>>>>> +                       }
>>>>>> +               } else {
>>>>>> +                       WARN_ON_ONCE(1);
>>>>>> +               }
>>>>>> +       }
>>>>>> +       unlock_cluster_or_swap_info(p, ci);
>>>>>> +
>>>>>> +       /*
>>>>>> +        * If the swap_map count values corresponding to all contiguous entries are
>>>>>> +        * all zero excluding SWAP_HAS_CACHE, the entries will be freed directly by
>>>>>> +        * skippping percpu swp_slots caches, which can avoid frequent swap_info
>>>>>> +        * locking for every individual entry.
>>>>>> +        */
>>>>>> +       if (nr > 1 && nr_setbits == nr) {
>>>>>> +               spin_lock(&p->lock);
>>>>>> +               swap_entry_range_free(p, entry, nr);
>>>>>> +               spin_unlock(&p->lock);
>>>>>> +       } else {
>>>>>> +               for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
>>>>>> +                       free_swap_slot(swp_entry(p->type, start_offset + i));
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>>     static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>>>>>                    unsigned long offset, int nr_pages,
>>>>>>                    unsigned char usage)
>>>>>> @@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>>>>>            if (WARN_ON(end_offset > si->max))
>>>>>>                    goto out;
>>>>>>
>>>>>> +       /*
>>>>>> +        * Try to free all contiguous entries about mTHP as a whole.
>>>>>> +        */
>>>>>> +       if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
>>>>>> +               swap_entry_range_check_and_free(si, entry, nr, &any_only_cache);
>>>>>> +               goto free_cache;
>>>>>> +       }
>>>>>> +
>>>>>>            /*
>>>>>>             * First free all entries in the range.
>>>>>>             */
>>>>>> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>>>>>                    }
>>>>>>            }
>>>>>>
>>>>>> +free_cache:
>>>>>>            /*
>>>>>>             * Short-circuit the below loop if none of the entries had their
>>>>>>             * reference drop to zero.
>>>>>> --
>>>>>> 2.39.0
>>>>>>
> Thanks
>   Barry
Thanks
Zhiguo


