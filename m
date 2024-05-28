Return-Path: <linux-kernel+bounces-193124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322858D2729
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C931F26909
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D817BB19;
	Tue, 28 May 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpEOGdYf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71617B414;
	Tue, 28 May 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932208; cv=fail; b=IOLpee+vZf/UfmUFHynn45CCoYjZ2+bSt5dTjvqks+dr1P0aJ4c4piZW+F7QHt5oMni1pea88eDOSvfY6W+eVXTBlLdNulYDBZ5GyuT7f7DkPs6cMM5NH/3GR5N5MJVINckeqyLbiw2jHAPA2VElwiXrN4fFC8yyREJw3nKRYvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932208; c=relaxed/simple;
	bh=qtUj0/VHr4S8CVwlFCSr6P7MM3lemCF/IE+64WYyWZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NGHAAJpgqTm8DwIMjJpldIVOu+hYpJd480nWRBo24qyyE5PmE6OtQiOX4yiYYi2ad0h2/dAhw1MknpNVZDJ0uDBGAPEfQKXvusm7u4OweiiyN3E29XdcoNG6GK7ndvfp6y1eHB2YTwn0JKv8bJBqT6KEs60oxATPakqSWz16+38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HpEOGdYf; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9z/zrgOQ0g6l1/Z1O61SGcj8iDcZ4Z4Ng0WmvAprclLxkNgdoDfzkScUvyLxjcvxeShIViIJVVu7TCWm20LSY5U4wcC3KlQ7O8xduevD+kyoQsWk6CKwgWAsPD0TOvETkKuU2DQsRycwxKXvFCSCl3yEMDKvhgipGEUwNxMY2Z2bCuNO0QRyQf1fOsrDtoRLfwFL6kn+5ZHI/MRVzKD+GArC2Lo8OwHGZg94FwhiCkasXsIFdEdgNokhUJifTFmscllcnhw+XRLbKgF144ax1o6uhc6g060Xo+QOG8zrjia1kXA9DOvclHfI2nhjWaCOHjXCUUppcptmhAdUdqk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhgcI5BxUIGrq8RdZl9zDjnr9wkyPp+mUGX9Ft5fPc4=;
 b=YER0IAz7MLz1dbqNm9bJ06OIkcpshnzJdORqcPgWQQKQSkdv4M6+xlceJJeq3lDjaAx+6p+sEbUWa2mOIWT0hsKvnxDJSYyti+nT1Ui4eXvZ0HH2BJlk/+Me5RRa4zjmAM9uhZ7RSl1R3Z0SHy0Gme1NLY7+Xezas7hE858irxaB7X+xKbvtfacF0ggxyiSjlxLSWwNJ628DrqwnBVJriHp1NU38pajtUjUrtE8VB9yzeoFX25/bRBBSdURlBZzb7fctlHPV/Tqjrc50QOUlp+2BRMA4zBUEINWCNGmBAaAFXzHIr05hlHrO1guscllZCfHLij+In+WxQsso5vI6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhgcI5BxUIGrq8RdZl9zDjnr9wkyPp+mUGX9Ft5fPc4=;
 b=HpEOGdYfj2P+uTuWYIq/aYHj9f0tqZaDZMMogXleUFFTRMk1Ce9BUWuJM0ygnqGZahZL20X4vsGgrhvR7e5820xi/X9dvoMccmNNw3wL+hIJJBgZp5GCb9vhnfq8zH7sMg7NSm3nloCcLi2nzuE7BESLI8rjn4w8lKg0FB2wR8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 21:36:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 21:36:43 +0000
Message-ID: <5390b2dc-bba4-4d3c-be50-13d9bb4b9c4c@amd.com>
Date: Tue, 28 May 2024 16:36:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
To: Luke Jones <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, richard@hughsie.com
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
 <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
 <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
 <ac597520-fb5b-40e5-ae1f-de825450d2db@app.fastmail.com>
 <371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com>
 <6d4e7f1e-ccd0-4ac5-b450-f9c5f8d5c90e@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6d4e7f1e-ccd0-4ac5-b450-f9c5f8d5c90e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:806:6f::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0240c68d-1495-4320-fc96-08dc7f5e44d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklFU1JzLzZMTjN5bFJHRXJIanFRdXNJcTd1WUM0WUM5M3JSZEtrTUxiN3Jt?=
 =?utf-8?B?RThLTjM1cGM3RUYyY3ZHUXlScXV3dlBtSWlmM0RiUkp2UVB3VXRBRnRyMFVH?=
 =?utf-8?B?YmExcXNlcmo4ZG0reGlGYy9wdFVRdjJPOGJETWJUai9CUGJUSENCUHlKY095?=
 =?utf-8?B?TmlNRDBXaGoxRVpsU0hPblp2Z2lob3VBWWZWUnZNdk51SjlHZWJnQjRlUWZP?=
 =?utf-8?B?Si9WQzgvaWhScU9DOTdEU3dPMGVQNEpxK0t2UzVwaDJ6WGE4bTdOY09DcVlC?=
 =?utf-8?B?TWt1c1FmbDJlL2RjVGFCMFJLbU5vMFNrbHhBdHBPUjJRSTl6VmdhaVo4RzRX?=
 =?utf-8?B?TkhHcExDdWU3eGd2ZFJXZW11RW1jSjllYkZUWUFyRUFEck9YTHJhYzZ4bVlP?=
 =?utf-8?B?dlkwdTY0ZFFXaCtTTGpMclRrOHhlVS82UTQ3dUJWR3JRTVFXR1ZvTmMwQVFs?=
 =?utf-8?B?SXMxaG1yTVdDaUlJbVhPVWVsWVFGcm5udmkzWjhNNW1UNzRlbW9zdWlTb01w?=
 =?utf-8?B?am80Z1VneTlrNVExRllxYm8yLzNmYmFDYTJCcnVmdXVJT2JJbmc3VW9PWGtD?=
 =?utf-8?B?R2hlYTNDVm1hcmhwdnV2U2Jyd3VzWVdTZ1U3M2lVWDBycFNyY3pwclFuUXlS?=
 =?utf-8?B?aWdycG5kT1ZkeGc4Ymo3Tll2Z01kTnYwSTlZUnhQY0FsT0RBOVUzMlJNelBt?=
 =?utf-8?B?SHdFRDlhSmVISHl3THlUTGx0NHVycGFGaWdRMm1vM1pUenUvYlVCekF2aDlx?=
 =?utf-8?B?Y05pZmp2eTdUQzJJZDEreVJEUk1wTUxsQVlHZ3hSQWpKRGVnenRuSk5JN05Q?=
 =?utf-8?B?TnpKanRrNTdMMUYyTDJSSURxS092b1NrWDJwZnJZYmxCTHI2ZWdYQU5KQU5h?=
 =?utf-8?B?a0JKYTBJNFJjeWN0M1Q0dVZRZ2lVa01LeXZ6N2xoOHRQRU02dXZmVEV4bzAx?=
 =?utf-8?B?TlVlVHkvV2d4TGc1VTNkUU5oY3F4KzZEUWRhQkxuME5JSExNVmo4RTFxU0Vj?=
 =?utf-8?B?MmJRTWM2ZFgwYkNaMXRBRHV3Mnl2VVFMc2h5S01Pazh1Q0IvOEJnRFdMaTRT?=
 =?utf-8?B?UGw5RWZIUzFZS2lRbE5vSnpxc3BobDZNS3FZdlhQTkp1WWlPTUNoZkF2dXhZ?=
 =?utf-8?B?MTJxN2l5SFdtWjgxQ0xHNnE4VVJleW1YSnduTUNkUUpFTE5qL0NYZ2F0cTQ3?=
 =?utf-8?B?cFgrU2hsUEw3TUoyV2JIRWZrRWxFaW1jbkc3QUx1VC9DYi9CNCs5Y1VFMlY2?=
 =?utf-8?B?ZnV5Mzc1NFJISjhuRjlQck5scVNWMzlLVVBOd0hIbmttL09jc0tybUllWW5x?=
 =?utf-8?B?U2tVc1dKMWY1cEFWbkJDVXJvSmdxQTJXZ1JqNGFzRDZSSW5DaHhVbWRxbkF3?=
 =?utf-8?B?SUNuOUEvT0MrZ0ZDTnBVWVZPK1NRN3l0MDFYcW93N0QwU1JFTG96L2VBbUk5?=
 =?utf-8?B?TGdaSk1aN1U4dmRFeml5VGV2QXFUSlJ3VE41OUlHSmpRL0xoU3RPRm1tR2Ri?=
 =?utf-8?B?SXFSZ3p4MW4yY2lnZ0hzNjQ5VEVoRU90OVBjNnQ0T24zMGo4c29zU1F2ZzZN?=
 =?utf-8?B?VmdLVkFQQm5MSExGWjFBMzgrd2hWcis2cTVsengxN2s1dlk0TUV4SktTUFNx?=
 =?utf-8?Q?GzM01sLp/lbbNYZWCDCg1xy5jQlMs0yX+/XBmtuCss9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlFKNlcxc1RUcXc3OTRxeGFEdjZBOUcySW91cEFIQ2NoU0ZDTmdDUUQ2SUJn?=
 =?utf-8?B?UEd5aW5uME5lTDZlYnh1UTNKUTVUVVhheThxZjl5WWFIMHovajdabHVFcFJr?=
 =?utf-8?B?K0ZuRlJQUFkzMVNkZzcvYjdjcWVZNjZMSDNBbEhEcTU1dEJMOTdYZWZ6dU1B?=
 =?utf-8?B?QTNCOU1HTkV2QzkxSjZ3aWE0c1lmbSt0RjJxcFZuUlJPSmJIcXhxbEpjWGll?=
 =?utf-8?B?NkNJK2dPUzRsMGEvd3ZDUXZSamdOZkFKVjNWWUxhdHBUWFQ2enBUZFk0QW5S?=
 =?utf-8?B?QWpoeG9rcTI4SHZVZkFMSTUveTNIOWZVbTRabFMrRUdVNG9iMDZJSFRhL1BO?=
 =?utf-8?B?ZUFhdGswWXBNa05VY2Z1VFlMMmVZN2R1YWZONkJ6WmMrejhKbk9BUUV6N0ds?=
 =?utf-8?B?Z0g2WDBid1Z1MnhDdnkza1BRNithQk43a3FqUmg3SC9ORTV3T2xOeGg0THdV?=
 =?utf-8?B?ZE5KMFl4dHBPckNZcW1uME1Hd2trRzBwWW9VTkxJSXR1dWFSRGd5NFZoZ1dw?=
 =?utf-8?B?QnBjOGl1VUZJZFBIM3JncUpHR3M0UnZxWm1iNVdtZW5WT1k0VkNkVWQ1WXdr?=
 =?utf-8?B?MFhBcDVreXl5WDU5VzRmTDVYTS9aK1g0bUUrRWVXR1cyRjYrS2ozc3BuY1BH?=
 =?utf-8?B?cE9pWFRGRmVocnBNeDVONUtKblpqcVRwUlVZTTJWcmdrRGt5MW5tYVpLM3VI?=
 =?utf-8?B?dTFKa3lUVEc5bE5ndXd4RFVXWFFhYVBYYjRMdmNBVGF5U1lCZGxaYXA4ajd0?=
 =?utf-8?B?NjU1dXU4aE1rNnA2TW5OdEliWFJkaitPUHZPRDB4emM3Q1Z0QlluWnhZMG1y?=
 =?utf-8?B?ZmhXUWJKdHhwYTBQeXM1VXgzZlBLQTE0ekMxVXo0c0RqR3krZGR1aEx4cEpt?=
 =?utf-8?B?RlJzWVhsYXJIYjdNWUcycjZsNm5OYjVqKzZWUVFtVW1SMFgwRDQwaE4wMFNk?=
 =?utf-8?B?MGFxM0tFTVdCMGlIMFFyV3d2czU5VElEakV0bklFWTg0REVCdFNzVHhKQ1lB?=
 =?utf-8?B?Q2RSNzNFand2UUdnWWttMUpyNTJ6cThhOVliRHBkYTN2ZWVnaGh0bHZIVG5D?=
 =?utf-8?B?enFKVEQ0UVFyNEpFcE0vSmJmVGY5Y2o5eTZNWkRaeHZmK1Y1NVE3OE5GUHV1?=
 =?utf-8?B?cnJKYmFwdyt6MUpkSUJzN3lNdVFYV0wvcFpFSXJGY09JOWlQNWNXNnNwQklk?=
 =?utf-8?B?OXVHa1A4b0llSTVYb1M5MS9SNzVkdEdjMXJ2aFJJWlVUckV2RW8wMU4xV2RR?=
 =?utf-8?B?TmhBL0FkTmpZV0pIUk1DVHhBa3RtKysybndielRCS3pVQTB1VWdQM2l3dWxl?=
 =?utf-8?B?K082bWFTZDdmVnRvY2I1L20vd1NOc0llVldKMEFHWGkxeGR5RnZxTW85cnhN?=
 =?utf-8?B?WC9FODNENTJxTnk0T1JLKzFQTHpzTHlXeVNPVVNLWDJaNU1YUlpqS2kwRVFQ?=
 =?utf-8?B?MGVrRDVoZE5aZzVZNjkrQVVlNmt3U0RuTUJudlNYOWxRUERmMEJkNE1mVXo4?=
 =?utf-8?B?UG1WVDFlZnV5S2VrSEltZXpTQ0tRajdEQjdHWjZOVGdjNkFKMC9lR0lseDRU?=
 =?utf-8?B?VlRXdnFhanZzRTc1TUxnWkVoWXRHK2V6anNjNDJ4NjRNemY0UEx6clRQUDZa?=
 =?utf-8?B?UlVvZkpSYTk2QWU0OVNXYmFITTVvV2xRcVREOXI4YXRaQzdza1lmeFRDc2oy?=
 =?utf-8?B?M2F4L3FvTTArNTN1Z1kyRDV0MVM1c25ySHlOSWN1dFhURHg4UnlLemVpOTVk?=
 =?utf-8?B?bkNsVVJxWVdhdkhBZXF6SC9NU3g3RUNZaVY2SlFNR1FkRkxFNTRvZnZ6d1hQ?=
 =?utf-8?B?bm94YWVSU0NxN3piVURNQnZOc1M2Y05JWnVrSmdpcFFseHpNWUxtRnp2TndT?=
 =?utf-8?B?aEZCTFgvejBHZU1pZFloWXdjajJHQU1nNUhVRzgrYWUyV3I4ZFU0ZU05NHJn?=
 =?utf-8?B?aktRVUI3UThJTk5KYm0wcmF1NVNqQllsRnNFNklHYXRyZnRWMFJYUDBRVy9v?=
 =?utf-8?B?VE9mRWFSNDlqeDVFa1c2MVhwRFlZWFlZWlBuR2w5SFRoUC9Kb01WWWpFRkNa?=
 =?utf-8?B?Nk91MVFRTVdqdHB5TkloekJlK0pVdW9SekhlMU5uZWtLcHRSYmxlMmY2bTR3?=
 =?utf-8?Q?hVKp6T0Y5hdFqWTNfFYlz88i3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0240c68d-1495-4320-fc96-08dc7f5e44d2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 21:36:43.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mGBym09Y9FNKRjGljJEvN7tiFMpkks2CmmsOZUoyBTmKKgL+bpBtsT1eOj6crc+iq/Zv71ifjN+iLFmYhDprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

On 5/28/2024 16:34, Luke Jones wrote:
> 
> 
> On Wed, 29 May 2024, at 9:16 AM, Mario Limonciello wrote:
>>>> For any "new" attributes it's better to put them in that API than code
>>>> duplication of the BIOS attributes API as well as a random sysfs file
>>>> API that you can never discard.
>>>
>>> Do you mean the firmware_attributes API? If so, I'm not opposed to adding all the existing ROG attributes to it also.
>>>
>>> If I'm understanding the docs correctly, for example this apu_mem attr would then become:
>>> - /sys/class/firmware-attributes/asus-bios/attributes/apu_mem/type
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/current_value
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/default_value
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/display_name
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/possible_values
>>> - ..etc
>>>
>>> That's absolutely much better than what I've been doing and I wish I'd known about it sooner.
>>
>> Yup!  And even better "fwupdmgr get-bios-setting" and "fwupdmgr
>> set-bios-setting" [1] will work with bash completion too.
>>
>> If you want to build a GUI around it, it could use the fwupd dbus
>> interface for getting those settings and manipulating them.
> 
> My existing GUI effort revolves around me adding these attrs to both kernel and a dbus interface. So if I can drop that then all the better
> 
>> The dbus
>> interface policy is protected by PK.
> 
> What is PK? And I'm guessing this restricts users to requiring permissions to change settings?
>   
>>>
>>> So if I go ahead and convert all the new attr to this are there any issues with also converting much of the previous attr? And I'm aware of "don't break userspace" so really I'm a bit unsure how best to manage that (would a new module be better here also? "asus-bios.c" perhaps).
>>>
>>> What I don't want is a split between platform and firmware_attributes.
>>>
>>
>> My personal thought is add everything to the new API and then hide the
>> "old" interface behind some boolean Kconfig option that defaults to
>> disabled.  If someone enables it then when it's "used" (IE read from /
>> written to) then do something like a pr_warn_once() that it's a
>> deprecated interface and it will go away.  Wait until next LTS kernel,
>> and then rip it out after that.
> 
> I'm happy to do this. On a serious note though, I should make a new module for this right? It would make it much much easier to manage the "conversion" I think, and then it would act as a separation of concerns.

Yeah; I agree with you I think this is a good idea.

> 
>>
>> Need Hans and/or Ilpo agree to make with that though before you spend
>> too much effort on it though.
> 
> Ack
> 
>>
>> [1] https://fwupd.github.io/libfwupdplugin/bios-settings.html
>>


