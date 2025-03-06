Return-Path: <linux-kernel+bounces-549100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69DA54D38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B01169CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0828F1;
	Thu,  6 Mar 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HN63rJt8"
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012048.outbound.protection.outlook.com [52.103.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FE1509BD;
	Thu,  6 Mar 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270388; cv=fail; b=UvP6xRZ6c1reliMLKXP3q0vgtUNNsTvlrRzCorwgiPnEV14gbhNAAj3XNGtq9I3iy15C0VEPdTWT3G2gRUKV5WgwR6vyeKcLiW311sC8D+q9wwSDbvvsk5XRrHU9KDCukNdmCCJ+EM3czzFmIckzmU45K/jm99aCuv2BvfX9EzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270388; c=relaxed/simple;
	bh=CKEi+Rhbyfi0tiF+xW+P7JdnIadWMcfUVURjjmO6gWY=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cqR7FlVewTv2lnOQnchAS8f4JYbMlX45Y9C2yhmwfbrqw20vGHAs5joqgztyZ0Xz0+wW5AuwkQSi6Mki/SO+XLsc66fACx1OLs8Uxcq06l23tSLduWRLYmvvMQLDU69TPwq/Rpo/yOxQejWHSUxOt5dHQMM9hpr3j/p/cDgLgAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HN63rJt8; arc=fail smtp.client-ip=52.103.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9KdE44NwRZASLTrPmgYG+LKizhgpIArfUfTTIwJJ8v11L6vlHqpeSR8qxIyEnHrnj8kcCYYkurGb+E2GrIUNxHQrxIEELtGcOfJZTmrPL7n07QLm9mtqOAUZZNQdGsZTYBKItv4Em/EWpNa40MFusR0SuRafoYch8h2jvWRS6Ij0SoyMLz6z1UyTcQcoTVNV/eSI/cPjwvVgCfpQxif6vVc8poOR26OVn1V172P8sPPDHZi4o+UN57Cs2Ons4ad+gEiYXYVoRLM+XLl6l5jsXsCjPmxPl1p/VsKZ5+q7kJzsxPGDuakbUJXHOUt59cbQKS5wmWnuKxkhd0cz7IiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTF5wmGnYoR+5C1Nj7XY7nFMNEw87B/CIboALuyNEtY=;
 b=xE8qMftkmtzqCJKKJsgT0TqQZCdIrV3/ohCCBsAlefhq3U3GpVKwwUSfAFPV28PKWgOoCOMK2JSaa8gM98YBv813Sj/rYWYEUGJmzYV6WUpgai0nBaVsx5J/LksvsENlbkgOC//ObGI5uWhNqEAYXUuMNbowwjomBTagnLk8BjbbnlYvw4P6TpexCLGD8HHVDv95uejGxPDJdr5HROuxiCrVk+beO8OOToutsh9G6NtMYtP4EIZsjqPslc7gNcbFxd/hqbHgJKIFHKKqEqyU4vlOei7CxQ72yPi4PkZ82BKf9yph/AwK7nImX3Gcuq3I5e5MCJ0FlBMt+1ZqvOxVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTF5wmGnYoR+5C1Nj7XY7nFMNEw87B/CIboALuyNEtY=;
 b=HN63rJt81vsnJB8axJIY3r282xqIyjqzghv0xH0OSdtIUrIx1MPFrqMhTZKEdzwNxGmrrUTSKDKBean7A/YqXVRHUjHi4hTMvwff8L7Z+cn5GWoSMbF0HnD9c66D/1ZBLbXSVvNotadS0FsaODKsIC3XVLUJnRupTXO8RkoxLIExMYgLOEoi404luR6+QSprhNDQ5A3mm9kbE2aylyHFnAj91HLwqeSL84/P1z44JIy83/IsbSzzF7g3621BYw1sYwA1kwf1vytbSmIvcceYso39wsIjkkneZpVbrqmvs7sP14nghhtc26KIcabrjvOdyak0vx3S38yYMMuZhO/qcw==
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
 by SY8P300MB0359.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 14:13:02 +0000
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3]) by ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:13:02 +0000
Message-ID:
 <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Date: Thu, 6 Mar 2025 22:12:50 +0800
User-Agent: Mozilla Thunderbird
To: piyush.mehta@amd.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, michal.simek@amd.com, peter.chen@kernel.org,
 radhey.shyam.pandey@amd.com, siva.durga.prasad.paladugu@amd.com
References: <20231102070603.777313-1-piyush.mehta@amd.com>
Subject: Re: [PATCH V2] usb: chipidea: udc: Add revision check of
 2.20[CI_REVISION_22]
Content-Language: en-US
From: Junzhong Pan <panjunzhong@outlook.com>
In-Reply-To: <20231102070603.777313-1-piyush.mehta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) To ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::15)
X-Microsoft-Original-Message-ID:
 <c36ff814-603d-4c95-a0bc-4d571ed73133@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0553:EE_|SY8P300MB0359:EE_
X-MS-Office365-Filtering-Correlation-Id: 384f7c94-c8ed-454a-22e0-08dd5cb90094
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPgu9FUvYZ88hunKvKD6srSwPfftjdhUq3WcetNGBtSjBrCTmXtJY1pQbF5vEF1x7ZsqVTk6HVioHfJRQ+FeVNKOAh6wovBpOjZSSuGIHQwPteDSp0o/gpwbWiVlAwZWU5zoQl6sdchsxLbaR+n8WmSvs3bd93zcSlBjqWxN0SSY6dE7fxow2IdVrKlraictb7hlx4cE0CRHoIxZqtkrgS3ZCcOyqOlRAvT8xHIkREKlQCDWw6IXqH/DNbz8VkqPZ/yjEtGU/R1YeU6I4F2hfB2Wf8SWOOApSmZJgQGAf8/Pe/YNlc+jQeb8Ih0dhhn34dNZIwRM6zlap0a5Osl2OwIUCo17Ho0QW+C/ByfGCsKbESnKuJmzdu+bxmeYmkwEMbBqg218cbtt6osPSV67Y7E5pP2eryYIHRXLOzAPjuz0oSWgdOnULvhyAofhyH3CPpdAjgWi6jovV37dUcYOem+yQZ85bUT4ck4WqX9Sq7JwZmpPv8EUWXEdvGlUObx3dsdRmfrUgEAvp8MhFiDhaujBnskv/BQ3qJhFiyH/Kwj6jm5XpqnKCNPsYhURA3DCpzKrmDzZm8yOzEZ/q8YZVQzS5kN3W2zFbNebu7bZx2JoGkmcegjjuy1xWBvHO4IuxMhZ3pNCE6d1zSEt1CtY3kn9c9xKhECs5dG3DWE7xrJ/pJQmosmbFCYFV27Cp7euy+60X9SLj84qjkR4a30KGItd9S1qQdCpLnpoJCa9/TVMFgyXRxUISzZrlx0TnbOfN4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|12121999004|6090799003|5072599009|7092599003|15080799006|440099028|3412199025|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRRY0c4R2sxUGhRUVJ2Vmd4a3hKR25QcWs1VjZLQks1TTM0aXVkNjBZREtX?=
 =?utf-8?B?VFpHVHJVYTdGdjFxUzRPdzN5RHBTTEdrdEh6UlZJUlQwUGJmWUNWaWxGUXJM?=
 =?utf-8?B?OGJQejBNcnN3d0VMejV4L1BZVWh4MFlVMkpUTGdaR1czOGJBalhPclFXdldH?=
 =?utf-8?B?VkM3WHBDVmtQRENLWXQrcnZBOWpscFNuemd2VDhKMWVkd3hvSnhDUXhzZmVm?=
 =?utf-8?B?TjZBNlhUTFVMeFl1UUhaMDlTUStRcDJrL2lJcnVhYkhTa2JPMk15QUIwcTZC?=
 =?utf-8?B?UGN6TUhMVGI3RnRoY2tZbVVHOTlBcGhyd3R1SDNNbkg1WFJvcWtwNFBabllM?=
 =?utf-8?B?aCt2RmdvRit1RWpSVUhPdGpQQkZ6aitJK05KMCtGUWpaQXpmVTNsbURuM0Ri?=
 =?utf-8?B?d3hsckhmaVlmTlkyU2xHQjM1ZXBteDVHcXpZcW9NNDVjT0R3QkdNanlpbUF3?=
 =?utf-8?B?Ni9jRW9GYWNKM2RFR3Z4NWlzdUNXNjFONGJzRERxRjNIQzlzeFk5S1U5c0F5?=
 =?utf-8?B?YXpsRWlVblRpOUpPSFZiR0tNWGRORmFoZlBmWWp5VkJwZFZpVGVSU2RZWkNo?=
 =?utf-8?B?YWZBcDlqTGwvSVZPL3ZIallmcFcrWURUWEFCQkpXVkt0OEd6OHhScFlJckVG?=
 =?utf-8?B?N28wSEo4Yk1yeWZTVFBJWXRZUXBjV1RGQXN6TisrdGRwSkZJczliVnF5Ukpw?=
 =?utf-8?B?VXlpNi9wdnJPMzY3RGt5ODlsRXBhVXMrSHhIN2V2V0dTSDFsYzlBdGpEcmJT?=
 =?utf-8?B?ZUlXR2pmZG0xbzdTb0NBaUlUOHVtdk1vNjVVODhMRUlnVjNrU3IrR1pxZ1Z2?=
 =?utf-8?B?cS9jaDB0Rm9IRjVxbGwzWGkvSmkyaHN6YmdxWEk0UWdYRlZuNGF5YmxTT3Rs?=
 =?utf-8?B?bjI4aEVDUFRaZVJsL3drYkROeWppa2NkVmNOZ0lTeFFRMXNRbjBLb3crRzIw?=
 =?utf-8?B?aGhDSUJMbHYyWU0vTDJMY1VId3IraDVxaG9scjlHTmltN01uaDA2T0xOTFpU?=
 =?utf-8?B?YjI1aVJnbU1iRnNTS3E1SHkrQm1JYkJ0VFliZ0c4WFdEb1ExVDJWa1NaWE5o?=
 =?utf-8?B?anBEV05FaTBxdE42elhDZDlxbDFVamZIRU5IZXltTWFnSTVUVnNBKzVnNWY2?=
 =?utf-8?B?NGR4Z2FiUHNjN0h0ZmFtbWFGL0NBcEY2WHZZSlcwRVpmQ291QmYvQ3FhR05D?=
 =?utf-8?B?bUtUOGtzYnpuT1lPdnRaU3J2QjdDTW9hOVVRQUZ4dUdOVDZoZTJtZDFKMnpZ?=
 =?utf-8?B?d09EY1ZqUk9jNkVnY1VuMDBmcjdkb291RnJGcjU2M0hTOStuUWtBM0NVRWNs?=
 =?utf-8?B?SzcwaFZONGlIQ0EvMmEvOVlqTVEzdG9qTTRJVWJMU3dGOTlUV29hZnRrY3BQ?=
 =?utf-8?B?YXFJc2lVSEN4UlQvUTB5NGs5VnlLdWZnUG9JeFA2Q1UwT2lhdEFOL1BaUGp0?=
 =?utf-8?B?bk01ZEZmeFlrVnVOYmpPbzlIQ1B4TW9nSVV3ZUc2RWRMeENRMU5mMkZtYTds?=
 =?utf-8?B?aVFBam5tWFJYTWtLSlE0RUlQVTRsSTlqdzljczNtdnBOOC9weG9ERTF4NkN6?=
 =?utf-8?Q?CDorXPArmNIRavIxjiWFofhyY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFU5OHlRYmpBK3hFNHpZcU5IanpxbFZlaU84SWJ3d2ozUkhJQVErRzYzSklp?=
 =?utf-8?B?ekNBSDNsTkF6emJuWEdmbDhQTGFCWjQ2ZlVHeHB2RHp1YU1HNzFWcUFuVUVk?=
 =?utf-8?B?bjBHT1BpL0dWNisvaWxsUVRwNll4N3VSTno5Tks1c1dJd1VhczRvMWhaMnI1?=
 =?utf-8?B?dWc4QkExN1N0L2o2NnZQdm45UG9EcEJnVXhoREthS3NmdWo0Ymp0RTFqbXFy?=
 =?utf-8?B?S0lVdWN1R0JIY081ejA4dTNLbWdFWXdEZnlTdHZlV1hIY1M4eXpUWmFNLy9h?=
 =?utf-8?B?dFoyTU9zVk5ueTExSFkrT3JCZ1EyTTh3VXIzc2ZSM21WSlg0cXJzdXVxMUpN?=
 =?utf-8?B?cldGQWtwYUV0QUVFT3JTSTRwcXVDZXovd1hRTkhqTkN2NmNuS24yNEI2QnNh?=
 =?utf-8?B?TzlKdWR4Rk93Qk44MkJkMUNNT05rbzVRano0WXFxb3l5NUZjRFZ6ZEpMS2RJ?=
 =?utf-8?B?bGErRi9LSWFFQnE5UCt2UTNOK0hINHJYR0ZMd0o4L0FkeENIRzc0Y2lXWCts?=
 =?utf-8?B?Q3RRUUlacloyaU01bEdyeG5qVmtCdjNqOS9Ib3FrR05FUmFSbklIVjBzL3M0?=
 =?utf-8?B?NGo4U0dYZUdHVlNzUTN2eDJtOEtkN2dDTnJXbjVtRVVGY0hjSVA0MjhKRDVR?=
 =?utf-8?B?dmJxc1R4RHErSnNxeXpaYU1SNWl1NTZQOXBYc1VVa3dxUUppKzQ3cUJJa3pv?=
 =?utf-8?B?aDlwRnlHZ1pKWlZYYnZTZWt5Wmh6Z1Y1TWxtUkdZNDBieWJVYk5FcExKcFRk?=
 =?utf-8?B?YStlcktNRUZUbG9uWTgrbzhVazhnOHZOc08zYUF5RUQ0bVB6YUNJU21YK3ox?=
 =?utf-8?B?QmZXa21CeCtxYjNPMnUxK3ZVNHlROU9vekNzaDgvc3hOMEpHdG1LM1pvZjIv?=
 =?utf-8?B?VzFNSTQ2Nm1iNXdXaDkwWEhlZG1HaDZWcXFJZ0Vhc0hGY0I1UllGcStaVmZ5?=
 =?utf-8?B?eEpRdnpzNmJ3dHJHcGpNcTNKS0lURTBGbFVtWFAwcnN5LzcyU0lvalNLSzll?=
 =?utf-8?B?Zkcya0VpMDNsaFlBVjNIcVk2UGtMeEFGQStIdnBZNC9BeWhUeVhHTEg3YVV4?=
 =?utf-8?B?a3d5T2pRS3ppOHpFVFFaRVpoN252a2p3YWQyU0I3L013ak92aDdPZ205VGRF?=
 =?utf-8?B?M04yckhBeFJHTU9zMHRxRU1xZysxRzBPQVZwSXdQVVhoYnh5ZzhOakxjak5K?=
 =?utf-8?B?MnFKckNhblo0V1JRWkpkdUYrMW1MbEJJTGpaRFYzWUZHK3pnK1cxTmpCUXFw?=
 =?utf-8?B?R0RxdUd3RHEzK0JhR0pKZzZNamRZWmlMV2NyRERtMVB3aUExN2lxbVZwdmN6?=
 =?utf-8?B?RUxRa2RNUERzMzBLd25qTC8vT0Zvc3ZRSlpzMHYzdXZOYmZweDkxNjJ0Smov?=
 =?utf-8?B?NGJJMFd4dWFjN0FDYnZwOXV4ZytRUzFqU3hCR1Y5M0dSQ09Qa1Nub005STQ2?=
 =?utf-8?B?TUNpenhYcUZQZnZSei9NNkFJU1pBd2dKL0gwbTVzaFIremlnR2VGbXpHZG1C?=
 =?utf-8?B?UUVCelUvSERralI3cnluRFRvNXVwV29BQ3haSkVDTWwxaXB6d0tERHROaU1S?=
 =?utf-8?B?TnQrd1BvOG4xNUcvQU8wN2kxdEtpSmY0UFlFUTBrOTdJV2RFS1lPTWRUZGVQ?=
 =?utf-8?B?UnVPVmtuVlBLVmpyaklYTW5rNEVIVW8rSnhKQXZ0MWc2cjEvcnVQdWR5OFBP?=
 =?utf-8?Q?oVnVg83KEkkXvQzVVRBz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384f7c94-c8ed-454a-22e0-08dd5cb90094
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:13:00.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0359

Hi Piyush,

> Issue: Adding a dTD to a Primed Endpoint May Not Get Recognized with
> revision 2.20a.
> 
> There is an issue with the add dTD tripwire semaphore (ATDTW bit in
> USBCMD register) that can cause the controller to ignore a dTD that is
> added to a primed endpoint. When this happens, the software can read
> the tripwire bit and the status bit at '1' even though the endpoint is
> unprimed.
> This issue observed with the Windows host machine.

Sorry to dig through this old patch email.

May I ask what does **the scene look like (bus condition/dtd status)**
when this issue observed with the Windows host machine occurs?

I want to know if it's relevant to an issue I encountered recently. 

I met this a tricky issue with an soc have a marvel udc (driven by
mv_udc_core.c, it's a same chipidea IP accordingly) when running rndis
gadget with the Windows host machine.

When the rndis gadget running for a long time (randomly), the udc would
suddenly stopped and no longger response to IN token sent from the host.

The bus trace looks like this:

BULK IN:
	IN
	DATA0 120 Bytes
	ACK
BULK OUT:
	OUT
	DATA1 98 Bytes
	NYET
BULK IN	??
	IN NAK
	IN NAK
	IN NAK
	.....
	IN !!Propagated Error!!(Turnaround/Timeout Error)



The driver doesn't receive any further interrupts when it stopped,
though the IN 102 Bytes transaction is finished on the bus, but the 
TD_TOTAL_BYTES of that dTd is never updated.

 ep num: 1 dir: 1(in)
  qh of current ep: 1 dir: 1(in)
    qh maxpacklen: 0x22000000, token: 0x668080
    qh td_dma curr_dtd_ptr: 0x658403c0, next_dtd_ptr: 0x1
    qh buf p0: 0x672dcde, p1: 0x672e378, p2: 0x672f000, p3: 0x6730000, p4: 0x6731000
  req 0xd81e245540 len: **102**, first_dtd: 0x658403c0, last_dtd: 0x658403c0, dtd_count: 1, actual: 102
     [qh->curr_dtd_ptr]dtd dma 0x658403c0, token: 0x668080, err: 0x0, dtd_nxt: 0x65840540
         buf p0:0x672dcde p1:0x672e000 p2:0x672f000 p3:0x6730000 p4:0x6731000 scr: 0x0
  req 0xd81e245b40 len: 1558, first_dtd: 0x65840540, last_dtd: 0x65840540, dtd_count: 1, actual: 1558
     [---]dtd dma 0x65840540, token: 0x6168080, err: 0x0, dtd_nxt: 0x65840080
         buf p0:0x20ce50de p1:0x20ce6000 p2:0x20ce7000 p3:0x20ce8000 p4:0x20ce9000 scr: 0x0
......

epnak: 0x00070003
epsetupstat: 0x00000000
epprime: 0x00000000
epflush: 0x00000000
epstatus: 0x00020002


Thanks!


