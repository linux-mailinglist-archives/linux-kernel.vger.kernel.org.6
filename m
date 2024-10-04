Return-Path: <linux-kernel+bounces-350242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03F9901FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517512815EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCDF157492;
	Fri,  4 Oct 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pRlx2wSZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77834157481
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040792; cv=fail; b=MkuilFj4vNJ1Bef3hbCI0MHiHZsElgUcIH9vvh8p7PttTfxfD86ckIiGt0sC+FL0E5h91Wkge2KqssJ3SlrVj1jLGqmMxfSsbpr2X+yFVW6MnBEbcnavIfX/6GWzP9395CXz7OD4fE49QcBCl+66f8hpSNWfwv0Us3oVCkkjz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040792; c=relaxed/simple;
	bh=N9XiyWIZZNauuL3Na9oV2iHEkEDfXNZldYYJ82r/wJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C1Nr9kB7CSsUh7o6ZSXXXPj10b8YxIm3T4D4zBt4DG89jwtUgGI/EFjP/jtre3i2qwtxZq56v7b9BXrRNTem5tU7HFadc0F48azP0p+lXWmdDLAtuElEbe3OU+56aw3HWJW4IB6Myrr7EL5JXomYkIjI5IqpIW+imO0O5NsSomc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pRlx2wSZ; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmwlOVkJ1+KlYBwZeZDC0xN4mmlk9Clksn0yE+TSXreFb/x5DfZLOXlx/6JqZ8qOE9CAmVLe3ioVgNlbDeCIzpdN+4YE4VMFkzNoT966n9uqS47P4A5KpaC1RfIgCKtHxPUZfwLHA0TxNts8JgvsLOcMcnGQI/qAKqdJ33lKPtjX0oAsD2xbJXzQWlWP1gbbykpvJYGek3T1e4ob/6dVknb7oWTlj6S029E802bNw+sYiLxYsmbyYFBaiG6l+B/SED4o5EUWyDAdZjFegkVIdiovnREqb2zL1M9okqzgw2s/1wnpMP74/kUE7388FKe4qL5AzR5T0EtJETBBr4Xpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5ykewNLRva8vXYpUSlaVDkJxKm/vrHurwSwp6AWVD0=;
 b=xwH2QYNOpN2SH3EyhO4JQimmNh+DiUM7dDpc6C+5eQi8uWhEMNOCZ02fp0i1qvxCMS9ohgCAofag9ixogyhBxPnmoRfjM1rYmQ594hRiLbViFtgRl85hiIn9ZvAVimTTRDt9R5llA89SigLFr0Avor5MQIaJpmuE1YjnbvjPRvb0HUOQA4+1vw6cUK7n0hxP0Xl2RC+GkhUGARX2Rg6skro8aVziNYIhSdnQYKbr3m7bXx0u5ZCRlPs1z/wPU1Zg5d6VNpReXHqPA8ziFPiOZacKiOrQ8emT/zUzsMmJAgXZKxNoVfhcqW0732JeKBdbMcTdWzxXzX42+Pv3mjWpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5ykewNLRva8vXYpUSlaVDkJxKm/vrHurwSwp6AWVD0=;
 b=pRlx2wSZdCXwPgXLzL05zGBzJzoX/bRS9sFr4hE7UdqXmfjGW6tBmfkpDB9n0AQsAat7tGpUTKklUFWCjIEyDUwZZDWV0VrnvKnpVOK6gvI7G+QRWjuBdD8L8PsGBUMOQwpg/+4l1XmgH8kRkO7Qluac2sz55Pm+4zLRBbqQR7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 11:19:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 11:19:47 +0000
Message-ID: <1dbd3687-ab21-421e-a978-3fdd8597046c@amd.com>
Date: Fri, 4 Oct 2024 16:49:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] Fix unintentional integer overflow
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, leo.liu@amd.com,
 sathishkumar.sundararaju@amd.com, saleemkhan.jamadar@amd.com,
 Veerabadhran.Gopalakrishnan@amd.com, sonny.jiang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com
References: <20241003102623.11262-1-advaitdhamorikar@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241003102623.11262-1-advaitdhamorikar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 299f2b78-b012-4086-86e7-08dce466749e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnJvNm5ENWllMWxHZ2Ixd0x5WXJ0eGpuN0UxMVhQcXBvZW5ZU29MMHRoRWt0?=
 =?utf-8?B?UjlqK0J6dVB2US9JZHNCTjhaU3Q3YS9IMWswL2srNHVSMVFYT3lMTDRSS3VH?=
 =?utf-8?B?T1VkajdJeEowUytOSi9VaHc3VUZQa015OFRhVFhmeVNuUWRSTGNHdHp2S3RB?=
 =?utf-8?B?cHVqSUd3cFV0RmRLcjNkb0IyNkpSRmVrK0VtNEhlaWM5YVpPSWtMTEdWVnU3?=
 =?utf-8?B?LzgvVGxGYVM4M0V1REgzWEpRM0VzU1k1VnN4YThqV2IyU0dtT1ZlTTR4VXZi?=
 =?utf-8?B?czVVNTFKMUIxMm9MS01MQXJmUm4yYVNmeU4rTmRPcEUrbkhHekFzcWZOdHNa?=
 =?utf-8?B?WTVOaTA0WUxNWkY3UjYvQ0hTU1lEdnREUUVla2U0WnZ6alUrYTZqRkJrVzly?=
 =?utf-8?B?eVVNcHNZaDFEaDltM0xBcHRTZnhFRFllN0NqRjNKU0lWR3BjdXRvdnJsS3k5?=
 =?utf-8?B?SXVMc09zR2Y5NERpQ3lzNk8vVkJiNUg2VXI0b3Q2UEZjWkU2bnJXZHlvS0Vr?=
 =?utf-8?B?Q2wwd0MzOTRoek1SQkd6K0FsSFhUMTNIaGFmQWdsVU1pT3NwTzUrTXB3WDVV?=
 =?utf-8?B?ZUpiTk5nWDEzanNBZG1mU0VXNUFLZVJsSTJhbEtIRU81YTNMckdNWmtxaFRU?=
 =?utf-8?B?SWtKS0FTSHlCN3VnV3pNa0c1QXNkenVtZDQ1UFg3WG9ER1BPTGxNdmsxWjRW?=
 =?utf-8?B?bjl2V0kzc09WV2dtQUZPNXlPS3hrUEtGTjJSVTRYb1MxcXhJa1FKdVVRZE1t?=
 =?utf-8?B?M29FM3FPL1lFTXk0SlJtV2JRN3Q1K3ZPQlFuQ0IrVm1WUVN2d0xFRHJiME1C?=
 =?utf-8?B?QWc1dElZSDZsczY4UTRVdFRaYU52NVJhVFVqV3FoaUhCUWFvRy9qZkJqVUU2?=
 =?utf-8?B?eGs5dmJ0ZDEvQjA3TzBzSmZJS0VDSVFRS1liVEZWQjRlVklXS1R2eUJPYWc4?=
 =?utf-8?B?RzNDdXY2dXdFZFhCV3NCdU5pQ0ZteFpvY1lHeDVBeFF2ZFUyTkpWY1llQWtX?=
 =?utf-8?B?UTR4ZXpTVEsvOXNFNUVWNFcreHN3WUFUL09lb1EwVkJBc0NJTExpQ2l0SVBY?=
 =?utf-8?B?R3E3RU5NSlBTcGh0M0Z1dVdQTzZHK3c0ZXF4MndNaHVGOUJJWWxSM0trYU85?=
 =?utf-8?B?dTBHTXBjSkJYS0VLNmd3R25iVzExY0l6aHpTRTFRdmlDOExTLytFdXh6YXk2?=
 =?utf-8?B?enlPU0hzdnVpM0RuNmE0bzlSS3FuYVVZVHNqWC9abDVRNjg3cFJ2Zm9IOG5W?=
 =?utf-8?B?UVlKK0paN200eXJSTXUxT0NyUlJDNSs1SXpCaXc4ZmpzSTZaSWR0YUhuMFJL?=
 =?utf-8?B?NU1abXpiRm0vczB4L3lFZWRJV2czTkpkZ2hvcUlvSHBrY0tydm1XdzZtbXJ5?=
 =?utf-8?B?MFJGZElFamE1OWZ1M3ZVM3pXMndjTUVrOFRYaUdBQ1ZMK3lvYTNZSEJ1UEsr?=
 =?utf-8?B?dkF2SFErUExCSVFhTW9uUkphb0hGLzRMYlBpclFYQUZnbjZ4TzcyUzE4WGJO?=
 =?utf-8?B?QlNKNzB1NG5aNXBVU0djNWVpUkFmc3ExMTdTYXZ2MmllaGxTbDJxeFhrSVBw?=
 =?utf-8?B?a0hnNms0bVhlaTNtN2lNcHhyU0Nia0FWeEovWEtMck9vdTNwck8rZ3NqdWJB?=
 =?utf-8?B?NEk0TU9GbktWMmR6SWVOS1ltS0NkWWlybTNQOFAvQ293eVp4OElCdVc3Zlcx?=
 =?utf-8?B?VVNBU3A1VDF2bEJVQ3BzU3lGWWxkVzkrTUFobEdQWXIvb01iZDdORkczbmxl?=
 =?utf-8?Q?/TNtXlXy5Dz+ixvhamSLpNLv434vJ9wc+feaBJq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGtMOElhK1grUkdkRDlLY3BTZjZWNGhyZFk2b01WeEJ0WGZrU3B4RkoxN0ho?=
 =?utf-8?B?dW5SUU13M09LZFZJZFY3NVBDaHQ5SzF5UFh5R1IvZ2oya0hVbFRyeVhaNEtS?=
 =?utf-8?B?aWxDcnZ0NnYrSU1lZGlzQVlwZm5iT0x1S2JGbkZHU09JR1ZyNjhFeitiZEVy?=
 =?utf-8?B?aVJBcjF1eWJFczJmVGtSOU1ZQmMxdkYyUmIxVG5maUNRakVWNXcvOUN1cXBO?=
 =?utf-8?B?ektpMG1OaGtqK0Jzdm85ZDZndEM5YldRTU5hNTMzK0hFVGdDcFFVK2NXK0ts?=
 =?utf-8?B?NGlxckNTRitLcWRiSll6dEx3SmF1QlU5UHV5cHB3d1BCQTFvUlhsUUt0Mk1U?=
 =?utf-8?B?MkJ6d3RwUytwSEhlWWR1MlcxWGlMNWxFTXdrMlFZaHltdUNxZDJQMjhHc0hQ?=
 =?utf-8?B?TU5WU21VSXBJWTZCYmFCcmxwVUlWMDVWekdqY2UwcEhxNm5vbHlIMnBYYmov?=
 =?utf-8?B?VHpzYVdseURhWDduSjY3NGpqSEhsZ1VjbUE3bmM3WVpvMjNYd2ZRZ05RZERD?=
 =?utf-8?B?UFJXSndWN2dRM1BLc0ZqYU4xRUw2SVFpU3I2enY2MW41dUtVdXl1a2pLcEhK?=
 =?utf-8?B?QVZhUUEvblRHVU5paUpNWHpLL04zUHpvT1Fhbjg4aUZIMzlCUXI1OG5MQ0tL?=
 =?utf-8?B?QkVlY2xCaTlMVjkvcGVUVVkrVmx1MENnQnlYRmR1SndTMjVDRW9xM25YdEZu?=
 =?utf-8?B?RWloeGxDWU5paGR1aEVUa1ExNkpPR05GMjJTT1B1ajBJK2FqMWwrMjVoUUlp?=
 =?utf-8?B?Rmt1TEhGNnRSblk3QXhOcGRwL2cxZkdCck4yL0syaUFGSlpNT2xtR09VWEdQ?=
 =?utf-8?B?WTB4YXlMbllNWFVpYzRlMk1RUXRsV1BkMnRnZ2lmczlobXVvMHV3azJZQXZt?=
 =?utf-8?B?eFNzT2ZjSTdIcmtWRS93M2RzVm9ySFlTLytudXJXeGZISnMxbGo1cWt6V2Ux?=
 =?utf-8?B?N1AyRkJpbndoUjNSSWNNWndzcmdZUnQ2T3FTSWxhQ3NxUDdMd2dlcUo3QVdp?=
 =?utf-8?B?VTdvcHdJODhwVVVGNHZMU2JxT3NiOXdKSjlJSWt1L3FGcDJQa1JXM1FwMi9l?=
 =?utf-8?B?MEh2ZTFYRVdtdGVuMzY1eFFvNVJZK09qV3dxbVhnYUI1eFBmUGRpVC9BVDlW?=
 =?utf-8?B?TzV1Vnh1bWZpV2d6NTMzRjRBOGNMYmVwQVBlekRkekdQZUZGeVJtQlFZQVo1?=
 =?utf-8?B?SXdGbnlJU0s1b21yRWh0ejhlTmVKM1piQmw5ZnlhK2VWSjBmOGZLeDRHTkZI?=
 =?utf-8?B?WnQ0Y243dHZJUFA5d2VUaUQ0UGtmRnNPQlFDWnJlaUZ2aUM2OEpLWXJEK1B3?=
 =?utf-8?B?OTVGQXZlQXdrNFAxWlQrTVVmRGN6bDBKL0ZGMWxJWXpMOG5IOTVKenZqYVIv?=
 =?utf-8?B?MTlpWFZUSXJ0NHgrUUFMMmUrY3VJbFJsUmxEUEpROHRvR1RIMHMvZmVBaktI?=
 =?utf-8?B?cGFrNzVDSTk0T3N5ZkN3TUxkVzRDZ1RCVnI2bmluYTRqWENqY01HS2t3aFIr?=
 =?utf-8?B?TVRIbjNaQlRaWXB3bjIrQkg5aWtNQ2lHcU40ZnAxQkFRT2tWQnRnUkRiVllR?=
 =?utf-8?B?UjQ2YkRybWlZVnd1OW5UUS81WlJDZmVKWXpiVWJCU0R3bDg2Y1hzUVBsWjRM?=
 =?utf-8?B?UWR0ZVNla0RtWmZQWGxJL0dYMmVHQXZpbGk0ZXdrb001aUgxWS9MY2xaMzNT?=
 =?utf-8?B?YTd5L1FSL0hka2xFSkF3a2xMRGg5WXZKWE4wSmd2ZUtpQkU3eGdkalhUTTZo?=
 =?utf-8?B?dlg2VnBYSVdWVlJ4c3cyWVNZWVh2TGsreTdyU3RMdmVLQytzU0JiNnI1YTRY?=
 =?utf-8?B?SGprT2d5a052MURHM2lqTzJZZVozSnZkQUVOR291dVRoRThlZjN4ZllwdVVq?=
 =?utf-8?B?YU1DUG9XbkhVK3lnQ0wrYngzeEFBaVZGd2xaVUNESmhYUUc5dFhxYUNCOE9m?=
 =?utf-8?B?Y01UN0FMS1lZWmZhYXpjaGlBQkxtbU1hNXhjL2NVR3o1WnpadXo2TGY2YkJ1?=
 =?utf-8?B?eUUzMytwYmNYcWZ2Z0oxQ1RXZ3BETDJUV21LWFpoQkt2RitsSVBvMjFwUTVK?=
 =?utf-8?B?USt4VzR6c0d0Nk5Hem4xUEI1KzJVOWtRVHppU2tqc21SUGdUK3A0K2JGcFNP?=
 =?utf-8?Q?K90Rav3S7bPQwQdrM+ZKSWssX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299f2b78-b012-4086-86e7-08dce466749e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:19:47.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKs+XgOqLWEsA5XJocxX25foOL+O+Ac7CV+EgpqA7w4oXtmufPjv5TuqVqQt8bpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095



On 10/3/2024 3:56 PM, Advait Dhamorikar wrote:
> Fix shift-count-overflow in JPEG instance
> multiplication. The expression's value may not be
> what the programmer intended, because the expression
> is evaluated using a narrower integer type.
> 
> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  V1 -> V2: addressed review comments
>  
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 95e2796919fc..b6f0435f56ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -357,7 +357,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
>  	if (!adev)
>  		return -ENODEV;
>  
> -	mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
> +	mask = ((uint64_t)1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;

Using 1ULL here is more legible.

Thanks,
Lijo

>  	if ((val & mask) == 0)
>  		return -EINVAL;
>  

