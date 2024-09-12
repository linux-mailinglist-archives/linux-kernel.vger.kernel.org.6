Return-Path: <linux-kernel+bounces-326109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7219762B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B671F226A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3818A951;
	Thu, 12 Sep 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JzpdcElB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD715D1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126231; cv=fail; b=UrgqdG5EUZ874iB1yeIy0EQN7HdH9Wb4MSrPBnR8GqNqT2NjbKgYBamDMBHXh2gYMLK8ynVVLJo2aNIn+QgIOkiseD/uOvPq7V2/3Z14EpVc0Dpki+iP60D91jN/lvkhHMmRO19TvxyTWmOodcN5uaQIeBVODYmuKKFX70ATljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126231; c=relaxed/simple;
	bh=ST7p62D3xU65znjURvIVgajrTm4nJQgmDzx8tI931mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8asUQjKwMfvbx9U45L1mv3TA7mHGneJxMSbuE5yqiwmpKbz8gnSNp57IcCyqoZU132TmAH81BpGOtDogdMu9+qdv+t8msm/oQRNOZuMJb0C4CEUzsmbmDHa+UMJhHVDzSOzkA6Chtl1gMzWARKgygZNUvk7kHtZnFzzTCLB+5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JzpdcElB; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSlxNwIDXAtAtyBTCXEUvuU6A/z5FOk5xk/cdZysxEKEP1rnsHCMadef9GI8YnKu1wQeZA+nSIftceat5k8FE/KHre0o/gbX3vhtJZsk4HaYCtrjDhtccKXkHm1n0cAyDRO8ZKrVGpSXksLMcRHRXvJ8+pBZIw7iBHMUL9WbccdkRGk+koobMl+e+S5SWp1zqrmy+7rwjlCd/QMffEmSfHbmqubq0MeY1SdTvGmRB4d/zxChrbWwVVcoDp03twMYDJui0NZ16OLl5frYFTvxooP9JbjYUBoVf7uOyoRd2kg4bhMxrvgqVgyaQkqFu+u8mSXhiOflPrgX+PT7aiLvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFfapk/8H2z/6mWs13AflD/kbeuM4pbBN0T/p1VTBUA=;
 b=pjtNRpeSrcpxj1s610na5abSZOhzijT7selRI9cmCkCqVyeFAltUHpqgYF/C9ntXTUPfzLptfab62068BhgOvXtD5UeOJpKgRqXjFe14ipun8yUvHogjbzQQ+JRYw/zTOoTx4gqerM4RBbModcpoNkX2aLg0an4LQ2nkQeWKxi88GMIMX7F4kN2S2bWsT77dMzbC2V51ewJRxHXJVbT8TZ8EufRKuG/iuk8iTf+7KwPna41ZzQKiBi+XuNKeuGgz8XwdmJlwe1sM73cET/0S3lB6W0ZmLGBeyD1TtAdSurcWbmZbwIphMK7zC7YlSuHJYCwAoGeW9COkH2y0n3cT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFfapk/8H2z/6mWs13AflD/kbeuM4pbBN0T/p1VTBUA=;
 b=JzpdcElBjR9gQa/MWQeEh4xAGbKmflYcaGKzxjhAz1EVPPMJVfjC8kgJhfI3kumxayuFLKSMmDJBbNzaahYHDJ0hFHjypiu4xE0DX0pAbRAoVOBMX7lwe1CgHzNqxjBAHwQ7Irob5O+A2Pbt9QW95qpI4zrkSZ8jsM4k+wBCi80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 07:30:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 07:30:26 +0000
Message-ID: <29a6055c-0e78-49d0-81b7-cdf7297091a9@amd.com>
Date: Thu, 12 Sep 2024 09:30:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: use u32 for reset ID in reset APIs
To: Ronak Jain <ronak.jain@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240830100042.3163511-1-ronak.jain@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830100042.3163511-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd971ad-6e55-43b2-8d17-08dcd2fcc579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVpWcFFUbEdlMm9NTklJZCtNY1lYeERFTlRQZkRENXpKTUhHcFJqelM2cDl2?=
 =?utf-8?B?VXhVbXY0ci9aL3lpZHRvS1VDQmZhNWV5RWtJVG5SMlF1YTMrRjM3aVZTaDJL?=
 =?utf-8?B?ZVJUQmFLZWlkdWh5aXFRejVsVU1xSmJwc3oyOWIxd0VzNWl0cDVGZTJYcm1J?=
 =?utf-8?B?L2EvM1RvSlZrZWs0aFNkS0thZ0x1VENEVm5Zd1RqWmZwcUhPSGlWWlNXamNP?=
 =?utf-8?B?Z2lQYXhmc2tzQzYvUzFCSjJZb3dldmJNVUJHeG05MWliUFNaZWhlU2JwY2lQ?=
 =?utf-8?B?Sm9tMW50QUcvby9DdXNVZXhUaWJUTHlvTVlOODFEckh0bzFCajJzK0NNK0w0?=
 =?utf-8?B?U21IbFhRL3NXSXVEUHplekt1THFxQzZXdnkrZStZZFJ1UFB0SkI1dmlqcUpL?=
 =?utf-8?B?WWpMQWxEWXN5N25hQVJ4NlpRRWhkdmRmSjVDV05xL2hadTZXd1dnbC9Na251?=
 =?utf-8?B?ZjdlRVJsMldydmFMREc5SUtXZGtMMk0rTXZncTBlb3dJcnB1THh6blREVkQ0?=
 =?utf-8?B?enRYb01DencxNGl2OGljVzdqNEdnRmJSVDkwY3RIbEZiZk4xUXUxUWhhNUw0?=
 =?utf-8?B?Rzk4UHNHbCtoOHRYbVBIVHhJVXF4RUdXZ0xwNUc3d09nUHBVcEZnU2FzeVBM?=
 =?utf-8?B?b0gwcmg5VEZSakc3UmUwa3RZczQzZTk5R3NXeS9OeWo2L3RHakFzazAxTW5X?=
 =?utf-8?B?L1U1K2pvbVk1bFpudXFSdklkTlF0emRsYlpLMVFyemtrbkdVZjNXbzJsMG5N?=
 =?utf-8?B?RXNPNC80NGtNT3lnRVFocC9vcUFwTUZiN09QYUluQnZ6SElRUnRId25iakxi?=
 =?utf-8?B?K1FONmY0NFBVbnBBOGRHaG5GWVBnbTNMUTVuTEhBeERVYVVWYjBpYStVbktW?=
 =?utf-8?B?cVhmMlBhRi9tVDVJNU1wY1RhV2FsVW0wbk9INlZPaUhqaGpUM3pJRGo1Z2s5?=
 =?utf-8?B?UVA0eFdpUEhsOWNmRVBac0ZvN3RxNXVySHhoMndVNnBVRVF6S2ppRDF0a1k4?=
 =?utf-8?B?RnJ2cnpnR0FlYm9YTDZZOW1zeHI1ckphUnM3Qk4wSFJ5NHZkajBsek4yQVB2?=
 =?utf-8?B?RU41dzhleGk4azBIOW5QOWNxUzc2SmZEandtTUUyald1MW9MMFF1QUtJNTBr?=
 =?utf-8?B?bVJlN2xQekNBMFYxdnlKUHhmaFFzc21KTERBNEUrZ2RJWE1tWjZ6S2J4b2hw?=
 =?utf-8?B?NnVtQVpWRUc0enBhV1dYSGUxL1VsMzBQaUFlNDVtczZQNVM1Ty9XeUFIUTR4?=
 =?utf-8?B?dDBzdEFQLzgxUmxpdE1uRDU2R2FmSWhaeHBIOHlwSDg2QlNuMktxczI2bXpO?=
 =?utf-8?B?QnVObk5oYzJFYkNnZk5aRzZKTzRWays1UDNzVGZOeHZXdTc3aXFpWVllV1Nq?=
 =?utf-8?B?RUYrQ0xhblVlTEE3S3lZTkVqSy9SdUVKbE1NQW4wck5VZWFDaDBLT2xXUHVi?=
 =?utf-8?B?azgyM1luYmpNMUJJblpYb3cxb3liaGZ6R1NYOEFBL3pNZ2wrU0oyVzFiZlBu?=
 =?utf-8?B?TEJsK0k0cUZiRkhjVzM3Y1ArTmxDY1V0UTZzbDVxN1JzMG54VFVsa1QySmU0?=
 =?utf-8?B?R0JnRXpRcE1tVC9zWW5Gc3hQYkl3eGttUkI5b1BsS1ZhSC9PUGw3QWpXZGtw?=
 =?utf-8?B?NFkycGlRb1cyNGp3UXZCeUViZTh3cXpjcnMveUxiN3hFaXlLVjlLcm9Obzhw?=
 =?utf-8?B?NHBaRlE2MkxLL2NwV0ZyVG9WaHp2UTV0UG9UT1dsVWFlVFFXVlM3aEhVSHh2?=
 =?utf-8?B?dTRPQVZqTXRCVStyL1dnN2o4UGcvVE91OTV6cjAyWEh1b2RGMnRaeXdzL25k?=
 =?utf-8?B?UlFoa1dSOTNwSjVNSjVzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm81cXBnb0I4S0dWUElEVlVwa3VOM2VkNWF4WkgwNlNYcE5jUzNsSGJVQWZH?=
 =?utf-8?B?VENlKzl5YklDbEFpVW9LZ1VnMDhqZ2Z1SkV6M3FoWlFTeFVWaTAyZldGN0t6?=
 =?utf-8?B?N1V6Vi9XTU1XNzVqdVVEWFlOQ0RaWWhiOC85YStFOU9XYUJpbmF0cnZPeGQw?=
 =?utf-8?B?ZlVDd1lYcS9hTnl6MkdTRlF5QWUxMlkrSmNhejA1aGFDbnM4dVdqZmhENWY2?=
 =?utf-8?B?ZzNGaVQ5T0NyNkpnemhibjZTV2MyRmlVT2o0MTVHUlFITUxHVEJuMXBiMW05?=
 =?utf-8?B?UysvRk9PRHBKRjZlZ2dkYXJPQkZNanQyK2JVOEZsVVJyZk41ZGNORUVtS3E1?=
 =?utf-8?B?eEEwMExKQXJ4bkcySDlvN0hpWkdobVlMSnowQW9vU282Q1RrTXlCaUx3c2pK?=
 =?utf-8?B?eGFCRFlqd25ZMSs1MEJLNDZZa3IyUVBqYjZjdko5alRVa3JQSkRZL1ZyME1C?=
 =?utf-8?B?aVhvYUxVZFlKSEdRL1NweW5JczNZQkdvR01ldEY0VGYzOXBHSEljMWYrZFdK?=
 =?utf-8?B?Q2NqVFE5NU1CZ0dOWGtjQWYyR3JzK0FpZkt3S0Vxc2FlZFp1N2hSc0VhRjRN?=
 =?utf-8?B?QVFoUitNUkY5MDVQbmJQMmZoNW9zR2hWM05mTXNlVWUrKzE0M00vV2dVZGIz?=
 =?utf-8?B?TTFYbENCdGlCd2RobzFNNEpId04rV0swN0FTMWJ5VDNuNVpwMXpUV3Z5Ymlj?=
 =?utf-8?B?elBieVVWem1hS01XNmt3Yk5meisyZzZoZzQ3NDRkMDc1QVkvajMwTVEyOHNR?=
 =?utf-8?B?RWtpS1BCOHl2T3RBbm52R3EvUFRVQk1WMXRzeXlaVUNNYnZiZ0pxRnVQMlNs?=
 =?utf-8?B?b05rN2NCRU1mSEc5Ukp5Mkk3dFoyYjhQVEZZMDhpRHU5cW9ZOUIwUi9qTkVC?=
 =?utf-8?B?cmltdGRKR1dvVnZnNFRqM0wraXV3Um5NcGFxK0hPdEpIcEZkMXJpaVZOSXRM?=
 =?utf-8?B?OW9vQVVpY0p4VFRoSTZVNHNYVStMTkNmWHlFS2xvVVNlNUtiTzl3ZHdoc25N?=
 =?utf-8?B?bTRZd084SEZzVUdOUVVqN1lBWC9WTUdFVmFpS2F5Y0M5U1dyd0FMSytmbjFt?=
 =?utf-8?B?WWd3WXphaU9qZmFPT2hJQy9FRjBKdTB5U3I4MWttaFFPSXA5dXJPUjlMQ01C?=
 =?utf-8?B?U3Yxbkk3YzFuTFV0UDBzd3NlM0JBVW9RZDdaemdSRVdLaytGTCtWaGM4enBr?=
 =?utf-8?B?TnVxdkg0OXN5V2l6NlF1aEJ4M3E1cFlxL1J0bGxlZ2NCdlpqaGo3ZHFOVlpy?=
 =?utf-8?B?QzNrRjV5SlVrNzN4c1cwbk8yV1hzOHk1TXJwUVhONStJTGxiOHdJN2YvNkdr?=
 =?utf-8?B?ZEU5K3F5NXpwVFhvSGlFOTBkak1LamFmUXdDbFRQNy96ZCtKVXV2UEF1cFR1?=
 =?utf-8?B?eFdBTzByOWtXUWlKM3AxUURHMkRUc1ZucGdZWlc0K3g1WFI0dTdyajcwQnF4?=
 =?utf-8?B?bHdJcXpqYjF6UmNLQ3p5Q3AxcXdiUVdnMi8wb2l5L2wyWG5rcFBqWHZSUzBt?=
 =?utf-8?B?N3dTdzJDekdhUi91U2N5SEdaM29OUWJHSGFUKzA2Sk5LSVFLNWcxSnlHalhZ?=
 =?utf-8?B?OHAvdXZ4U2JOTjM2TEIyQ1NPczZsZDlCV1Zac3liN3RxbjRXQ1JWeWNDWEY2?=
 =?utf-8?B?L0M2cGJFNjIvTm9RNHVEQjZTVkR0cUtDTnFIdHZoSDRXejBBVFNnMlVFNEJG?=
 =?utf-8?B?M1BuOTJUQVhFcHdWdFBtNXdGcXZtMDcwMTlsajBYMXlPa21abjVWL2FhMGpB?=
 =?utf-8?B?dVk0V1NINnRrMTkwZTZpWXNiSWZIbkx6ejFTWHNIVE1IS0xmZS9IcTFJalpX?=
 =?utf-8?B?dHBUWXNxRGY5RnRzL0grUzZKTnM4aExqVklYMHFYQXRUaTZYRFJLUTNvaVJS?=
 =?utf-8?B?dlpIMExocWcvQUZhc21EQnhtU1pjRHNucGtlZ1oyaUVGcGRUVFB0K2tzUjVG?=
 =?utf-8?B?SElFNHQxNkhhQy90TVpFRVVRVDhEaUdVWE54cnVNMVU2LzN4aDRqR1E3Y3JD?=
 =?utf-8?B?WVltUGNQMDRnT0FBZFg5YUpiS0lsZjlsaDM4YlNYQThGbGRQVXBhNW9kbmNa?=
 =?utf-8?B?Vm1BRnBjQzFpbWcySEVhVEdQdmJKcEJvOHdJUnpOTkxWaVVDQlg4WGRZOUZX?=
 =?utf-8?Q?dA+76ZT1/E9Basf+qP2JWEPgH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd971ad-6e55-43b2-8d17-08dcd2fcc579
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:30:26.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rurbk76l48WIdTshxZQSR3BX199XYbniQ/K+hPhezCIUTyTYkZbZHxZK9VD4mkCo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195



On 8/30/24 12:00, Ronak Jain wrote:
> Refactors the reset handling mechanisms by replacing the reset ID's
> enum type with a u32. This update improves flexibility, allowing the
> reset ID to accommodate a broader range of values, including those
> that may not fit into predefined enum values.
> 
> The use of u32 for reset ID enhances extensibility, especially for
> hardware platforms or features where more granular control of reset
> operations is required. By shifting to a general integer type, this
> change reduces constraints and simplifies integration with other
> system components that rely on non-enum-based reset IDs.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 4 ++--
>   include/linux/firmware/xlnx-zynqmp.h | 9 ++++-----
>   2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index add8acf66a9c..c8be32d9c6af 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -920,7 +920,7 @@ int zynqmp_pm_set_boot_health_status(u32 value)
>    *
>    * Return: Returns status, either success or error+reason
>    */
> -int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +int zynqmp_pm_reset_assert(const u32 reset,
>   			   const enum zynqmp_pm_reset_action assert_flag)
>   {
>   	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset, assert_flag);
> @@ -934,7 +934,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
>    *
>    * Return: Returns status, either success or error+reason
>    */
> -int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
> +int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
>   {
>   	u32 ret_payload[PAYLOAD_ARG_CNT];
>   	int ret;
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 563382cf16f2..5b938fc2adad 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -557,9 +557,9 @@ int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data);
>   int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
>   int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
>   int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select);
> -int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +int zynqmp_pm_reset_assert(const u32 reset,
>   			   const enum zynqmp_pm_reset_action assert_flag);
> -int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
> +int zynqmp_pm_reset_get_status(const u32 reset, u32 *status);
>   unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode);
>   int zynqmp_pm_bootmode_write(u32 ps_mode);
>   int zynqmp_pm_init_finalize(void);
> @@ -702,14 +702,13 @@ static inline int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
>   	return -ENODEV;
>   }
>   
> -static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +static inline int zynqmp_pm_reset_assert(const u32 reset,
>   					 const enum zynqmp_pm_reset_action assert_flag)
>   {
>   	return -ENODEV;
>   }
>   
> -static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
> -					     u32 *status)
> +static inline int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
>   {
>   	return -ENODEV;
>   }

Applied.
M

