Return-Path: <linux-kernel+bounces-568386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80219A694AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7873BE86A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185571DE899;
	Wed, 19 Mar 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wu/HlofJ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2B23CB;
	Wed, 19 Mar 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401119; cv=fail; b=BUS6k2tTGtjy4bj46SqAzfbaCQUvbptBzoqF1t8/2u+GoCOVFJOf4TZty0cvmS6i3a7ONA4vpkClwGez7z1I0gQLzWTaSxKYjOq2ct/ax0fmePeepfx7sX3OS0VkXtBIw9T6zAakRmdx1szTI7IR5wcIuB+ie/zB6Oh5/c9Ozq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401119; c=relaxed/simple;
	bh=DKr3CxlmPnUzGX4VyoEUdCL4sWlQ1O/YgKYYWEbxALk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JowmtsBjJE8FtdpY9R5FS7A1VyZUGvKpcl66q2ghPHT8zDHd2DSecyme0c82AcwyPrFvAneXFfeQab4VI1S+5cyJwKtOnX+Hh9LWQe1Bfdmp601/jx55/7PkkNB21XcOA7U/dmVKDQr2XCCnM9ClvZNu85atfYX7gMPjFcm3jKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wu/HlofJ; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPFnb1AfzVIB3pVKw8s3eI300IaMnLOlhBTQi3f55D8KcMXtILY+xH1K9Q+Dsyb/Tdq3w4LgyiapCgCNPl89h5Oh/dzQtFKKkN4Ibugz9+8CQV614qVF/5RuJeKurnfkcxxluyXwbBe+fGnX9VKeh76IYAvHECGxPq/AkYSHtpA/qM0rytCB2uemkP8jP5VzWraBXmWxok9LyQ/UkVYahYMEIvWniufgagh1aYzBjWjP8ZkbhI6/39C819pTo0aWc0hLLORukIriHarcISHFHALDAntQL5fG/vbRY4XjefqXEXeSHxA38K6P+nEvrfBprULDm+Rzp/ySNwPZpw3Y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD3gLWNtIS9LJMavxdjBFCBGhvkq7jgmiYvrmqCnqHY=;
 b=RgsflyeiXumTlndW3Ithc1vs5NuWNnlzPlJYv9RIt7zWnxwYH2Gd2t1vGX3HWhvT+O+Ph8VdhWN9EDDtb1jr0FstwUySRLBnL8uVFs1Irm3F9xo/0IrmPjRxwboRYDaHlq5YY9vLdEJRpuz8crpC8fURBF59w2Ga29tlIXbpFOi1HF8sp55XVANZnpadqMIQHhn0qmNKYHPtUJpRFOVTy2anWx2caTMoUAHABbDD/9nuHVx+6+rNlyWVlBt1oz/LzoTcyY2u0rjPbjIj3HBx/fsN+OPq5FqdrC2S2XkI2LqpF8D4PhRz/PepzoC1MTlcfUYtMZsIIMCIF8cJiUB+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD3gLWNtIS9LJMavxdjBFCBGhvkq7jgmiYvrmqCnqHY=;
 b=wu/HlofJNzgclVnwkHICqRaksr489uzhV+hTkzUueHzvGLve+cDi2N3+rZ0t+26HJAxVlGMahcNmw8JTeS3pthYuAspnvOAuiFEaQWXgNnqCUP3mm5O3KCuc5lsnppXQvlcXw1tKMx/63gos99N/M54sAJrcW+HXuEMxv/9RWv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 16:18:33 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:18:33 +0000
Message-ID: <b9f49f34-1a69-41bc-8324-2e969e53f9eb@amd.com>
Date: Wed, 19 Mar 2025 09:18:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] pds_fwctl: Fix a NULL vs IS_ERR() check in
 pdsfc_validate_rpc()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Brett Creeley <brett.creeley@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <925355aa-c98b-4fa7-8e49-b97f6d551a86@stanley.mountain>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <925355aa-c98b-4fa7-8e49-b97f6d551a86@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 96211b41-d3b6-4068-97ed-08dd6701b1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHY1Vlk4eStWbTVLOHJJMjFrZEc5QnpDUW9Kc1o2SEZoNzVEMU1MZk9mUk1p?=
 =?utf-8?B?d29YZVBqS08yd0dUcHNXcUxzamNySDh3TlFsTnp0UldWeWVaeTlSTEJtMDBw?=
 =?utf-8?B?Z0ptenhHaVVySjZOWERENXV1blo0Z29tM283S08yQUdpOVowSnl1OGtGd2hi?=
 =?utf-8?B?ZTM1SktSb1lDU1pwQVNua0ZUVTNDUUJ0Uk5qRkg5NEdxbnlxZVV6VVk4b1Jz?=
 =?utf-8?B?czlKVWhUUGxjK3VtcWFTSGJ4VlpEL3JFQlczTnhEZjhVSDVPRVRMZTRJVjBG?=
 =?utf-8?B?WG9hdVdpcldKSHc0Q3NWWEw4bXhxOE8rVTdCcW9BSjRaUUt3ek1IVUhoYjFv?=
 =?utf-8?B?eFlEeFFXcmZVV1h3dXpsTEMrKzR2eGJiaEhEY2ZkcjdsYjlhbEhyd0t0V2Ir?=
 =?utf-8?B?dDJ0RVNQeFNGd2RoUzZobU12MjNCWmg5VDdyMHlhUjdUOVFueTdEM1A1b0Yy?=
 =?utf-8?B?SFV0MmJEUUp5QWFkZmpSWGNIZXA5a3ZoNVFFenFyYXN3cXd1eGRNN0IwTDBR?=
 =?utf-8?B?NklIb2xqemltSW9pQ285dnNzRTZMMGIvZ2I5S3hDeGFrUUJmT1poZTJxV2Jm?=
 =?utf-8?B?cU4xVVpyOUpKd2hFd1ZCYzk3YWJNMWFxbUwwdWlYa0hsLzBHOEF1MDlZTTFk?=
 =?utf-8?B?OW1nYmcrZk8zaHpRVFFrWHNxWXZYSVBMemZoUE9mNGdiU1Z0VjB2clZKSFVw?=
 =?utf-8?B?NzdkMmIveUxBekttc04rd1QyL1p6eDRjQjRWUStPREFmR0lmbVp3ckdUUWtz?=
 =?utf-8?B?YlB0eEw5MUY4Vm1UN2NBUHNTeDQvS3pibDBRLzdYUjQ1SjlEZVJvR0FyaUd6?=
 =?utf-8?B?YldUOVgvOXFrSGhCU25pb1FIZnRyelNkVnFNcXIrYk5wajJsR0JsYmpyK3N3?=
 =?utf-8?B?dW16Q1ZmRittSVlpaWxVdUJUdXZFNmdFaHFRS3o1Q0lwTzlRWkw0UXBJRzBK?=
 =?utf-8?B?cG5iSlg0RWkwNEFaZWNaK0RJQWxEVVQ2MXNTTHJpNEN6OW1EZlo4elAyOWhP?=
 =?utf-8?B?VE9ET2lkdW1idERnc0prZ3hDektBZkdKeFhZNUFjZU5JUkJ4c0JvYmtWRHBS?=
 =?utf-8?B?cVphQXFoLzhWQ3ZhWTVsUVltTEFaOXZkQTVMS2hFMjJ2OFFTWnl0QXBqOUpM?=
 =?utf-8?B?N0ErR2lCamJaeDFvTWNSLzJOdkZJMUg1ZkZ2ZkY4SlRwbElYelBPbnlySTly?=
 =?utf-8?B?eG5KZytDY3FKRzh6NnlzTDltN1ltTlJOT0ZxSHhJbjM1T1k1a0hWaDNTOHZh?=
 =?utf-8?B?QjErL1dqSzlmeUhBNjFzazcyRlAreWlWeUh3QWxRU2JUQkdnR1J5VFMyWWE4?=
 =?utf-8?B?OXVORVdraWZKRDlzdFZXSWcxRWRwT0h5Vk8wOFJqOWh1RjJuUjRHTmRnYW44?=
 =?utf-8?B?eXZTSjE0YTl4VVJaRzVzbmpzbE5YLzFVTDRtRDdIT2tUaHNjY1YxdU84eGtu?=
 =?utf-8?B?clVoSENQc3haK09Nd1NqR0tmeVJsOHNXaXYwZ2VZQnNWM25nR01PcG9qRGJI?=
 =?utf-8?B?L0lsUGNyc2YzSWhzUFhzRmNFNzdDRkIyZDY4Um5BTEJVMmpCNFppUzBIbmNM?=
 =?utf-8?B?VjNaRG52TnlaTnJNM1ZDczJIVTZUWDN0aS9MeUMxVmRpQUIwbHIzdUwxdTdH?=
 =?utf-8?B?azlUcXl1Y2t3YWd2MWliSktvaE04WEpvZ3BmajJ3OExYdnBYVTVReEhBRlVz?=
 =?utf-8?B?bEhKeWROaTFIT09FYlhyY0tCN3EzU0NlOGRCVWF6UGoyOHRFM2ZZUWp5SzM5?=
 =?utf-8?B?VVBOT2FTaE12ZjVWZlhDcjRKQllXTCtVd0tabUdNRnNuWWlkUTZNczNzZDFO?=
 =?utf-8?B?aXJaT2FGeDZocVB3c3NOdkJTU1UwN2tzam12blY1ZThGaDRVWWdXVldNdGFG?=
 =?utf-8?Q?2lw8P3LVx5bbC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFJHd082TWZJbmxJNVdrZjRNVWEyWEhWRVpybXhZUUtacnVyVDRPS21Ya1Jv?=
 =?utf-8?B?dnFGb3RXbTJ4MjRDbXJMK1RCOVZzMnlMQUlleWVTUTkvdWNqZVRKWWhwNGR6?=
 =?utf-8?B?ZjAyeVFKVktzZzlTSVRZbGdzUFAxSE5UT3lHNUw5V25hTzgwMEMybnpQY1g2?=
 =?utf-8?B?MWlVMkZwWW03UEdFYWdHSXRNN1A1NThSZFFMQVVSWGhodWdFYWhIVHo5bjBC?=
 =?utf-8?B?QkFVR1dMU1Q5OVkyY3NnbmthWVJVQ1NHdWttVXhmTzBTRGxwVXRKYjJjZ01a?=
 =?utf-8?B?YUZYK1ZjbzVUclZWUkRFRmVmSjJENXZMNFBIYXQ4SU0xdVVkU21jTS8rYm9Z?=
 =?utf-8?B?RUlpMXF6cjh1cGcxUVJIcHFsaWVIeUhPVmkrWVREK0F3cXczTDdJR0l2ZFBT?=
 =?utf-8?B?Z0JocjlMNEdJbW1qejRsaUZ5dncraUd5T0VIYnNGTXF4WjI1YTZEZkJEb2lO?=
 =?utf-8?B?MzJDeTRIdngvd3F5c1VKcWZhaDh3cUNCL2JqbDAwVVc1MEI0Tk1uKzNXRkVO?=
 =?utf-8?B?WWJkcVE3cmpsTnlteVlsUGhiSHRvMHJ2MHB6eG9IMHoyYnpIWVlwTFMrS0pn?=
 =?utf-8?B?N0l3Q1F0aWNQelYvMU1jMkVzMVoyUU16a1BRVWFvSXg2cTF1OU5RZFRPM0VL?=
 =?utf-8?B?dXAwUkdoTTJ4SEVFNExydWYwSVNyVGhDNDBvZzYrS21nbnl5WU96MDVpUldF?=
 =?utf-8?B?ZFFOZlBhaEtRNXp4TXZCQ2pFRHBuVFladSthaVNPUC9iSHFHci9kdURuRGJH?=
 =?utf-8?B?QUFjWmFPRjVSNld1OUMyS3FURDhCRTc3SzlKSHpaY21tclF1M2FQeVpnakUx?=
 =?utf-8?B?UXhXdWFTNFA1ektWVVNFVXpFWXlKamJ0WGFKSUlQblVBRFhqTW9UZFUvOXZJ?=
 =?utf-8?B?NE9sR04xNFNMVVpUczQ3MUYvWFhmeFNxVXNYL20yL0R0SGgxYUhKWFdjNnkx?=
 =?utf-8?B?aTVuTWRLZk9SdHhqU0E1K1lpemRrY1V0aVNSRFZHd24yaVUxdExNZG9yMVhl?=
 =?utf-8?B?OS9CVXZvL2RrZkFaRjBBTGhqemVQSmhFRUNtY0lvYkM4c0tLQ3VLL3lnRVZW?=
 =?utf-8?B?dmg5cHhpelR5M2tQZVhUZzNjVmVnRGgxZHFDRTNiSGFNZ2Q4M0tkY3pBbmFN?=
 =?utf-8?B?QWZKWEZzRFBsMkE2Qm55cFBjRURnZ2N1SG9GZlVtRnU3eUlNN21EbDFuQXpq?=
 =?utf-8?B?T3VHbVZCMVFxZHZlMVIvMUdmQW1NQ3RsOGo3WUtBeEF6VW55QURFZEt1UjBG?=
 =?utf-8?B?aVlIZEVMdmpBRDN6Yzh5aFZ3UWtBOFhwcUZjV1hTVzVWZGlieDBRVEFIOUUy?=
 =?utf-8?B?YzJoZ0I0bEdYYXo1ZmdmaU9uQ1V4RkdPU2cyK0svZ0MrNDhkTVgvN3kycFB1?=
 =?utf-8?B?YjltdWE4UXI5NkVzOGVnUVE5d25IQitoR0FhQ2M4bUFaSTZkckhsYVBhcGpB?=
 =?utf-8?B?WGdpc0JaTDJKeWV0S2ViaHhSRGpzWVVWYmQ4bjdFVEpDeTg4blFOaVltSjlH?=
 =?utf-8?B?TVBtQmxLZkhwTmpwNFFpU0ZYTUJzbjQxY1V6NTkzL0s1b1F4d2I3cG9ma0tO?=
 =?utf-8?B?VWVpWXJlMm02elpFWE9jdjhyNkZMUHo4azNGWWZiODVGN1N6UGMzd04ydkIr?=
 =?utf-8?B?ajF4djZER3FUbmZ2cDZCaWMreDhpQmxQNU9UNkhyUXpDcGtjSW9EZE1ZTkVL?=
 =?utf-8?B?am0weVhEbjBMTUlpQ3cyZ1Rxa1VPUEU2clcvdm5nVkJPZ0s3SUNrUDJHRXcw?=
 =?utf-8?B?aW9SMmdMdG0zVnZjQmhzVFdkRzRGREFTWU50RHFEcTE4SGZCeGtGRW5IOUF5?=
 =?utf-8?B?aUIxQ0puLzJpQ09EMXF4b29GZ3hXOGhlRVdKKzVzRHdNVHI1MHlJMUxVeSsr?=
 =?utf-8?B?ZDRhQnorbTZXMjNYOUZoWmJzWXVGQXplanFpY2NrMDkvSUdzVDF3b3NaZ0Zm?=
 =?utf-8?B?NE5zSWw3S3ZUWjZINWhrUVpYUWV6RGJlRmFiNVFFL1RQMnQrcEFpWjdBczNv?=
 =?utf-8?B?dXpTd1BDWFowTWtuQlU3ZHRsZ0xTc0pzMUM5ZzAxTE85YmtHd1VHNktWWkV5?=
 =?utf-8?B?UVhLZlhzWmJTN0Nkc2FaSjVmMDdLOU5IekNiL2JuSU1lRjlXb0E4SlhaODBs?=
 =?utf-8?Q?T1+ARZB76/dnlf34VTMQovhON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96211b41-d3b6-4068-97ed-08dd6701b1dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:18:33.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuFUJvNAmImqapNSMghFI5nqWW6tGPqUej8fu4nvX9nsMIsp70plrTvzo5a+4/OHaXfwawwhDW7fLmR1zah2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693

On 3/19/2025 12:06 AM, Dan Carpenter wrote:
> 
> The pdsfc_get_operations() function returns error pointers, it doesn't
> return NULL.  However, the "ep_info->operations" pointer should be set
> to either a valid pointer or NULL because the rest of the driver checks
> for that.
> 
> Fixes: 804294d75ac5 ("pds_fwctl: add rpc and query support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Hi Dan, thanks for this patch.  We also have this same fix in the 
patchset update that I was expecting to push out today, but you beat me 
to it.

Shall I continue with our v4 patchset, or should I now be sending 
smaller patches to update from earlier review comments?

Thanks,
sln


> ---
> ---
>   drivers/fwctl/pds/main.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index c0266fc76797..a097fdde0b55 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -255,6 +255,7 @@ static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
>   {
>          struct pds_fwctl_query_data_operation *op_entry;
>          struct pdsfc_rpc_endpoint_info *ep_info = NULL;
> +       struct pds_fwctl_query_data *operations;
>          struct device *dev = &pdsfc->fwctl.dev;
>          int i;
> 
> @@ -287,13 +288,14 @@ static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
>          /* query and cache this endpoint's operations */
>          mutex_lock(&ep_info->lock);
>          if (!ep_info->operations) {
> -               ep_info->operations = pdsfc_get_operations(pdsfc,
> -                                                          &ep_info->operations_pa,
> -                                                          rpc->in.ep);
> -               if (!ep_info->operations) {
> +               operations = pdsfc_get_operations(pdsfc,
> +                                                 &ep_info->operations_pa,
> +                                                 rpc->in.ep);
> +               if (IS_ERR(operations)) {
>                          mutex_unlock(&ep_info->lock);
> -                       return -ENOMEM;
> +                       return PTR_ERR(operations);
>                  }
> +               ep_info->operations = operations;
>          }
>          mutex_unlock(&ep_info->lock);
> 
> --
> 2.47.2
> 


