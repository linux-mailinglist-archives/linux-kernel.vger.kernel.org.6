Return-Path: <linux-kernel+bounces-432943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3919E5227
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1823C18819B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCC1D5CDE;
	Thu,  5 Dec 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqcbs/m9"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AA26AFF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394325; cv=fail; b=hv48csUbfAnKY2sq7Vd0/cTRSm2s/ib6wjAS15pKk5f/5ckjipzaDOO9hKIDfti0tNgQxA0fPQ0rvLvs+zVrfNj2mqJQCMlppHrkFmuxUAUJxRX2WTbZNnZ7JqGlHq4F9KwAgLeuvtjes/1o5lE3U9FdW6qtJnbfHyu0xaD/j1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394325; c=relaxed/simple;
	bh=tE9ETVSd18xFZoWo67fUYQnP3caKhO8X7ngd7i9e4W0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1WF9w1LcfkfMKgYHDn47kAnrDu0NM4Fjq+SHWpsY3H6jM3ECn9Ed/57Eu0Fcj6zIIIedCQ65fd20dhAAO4rkMMc4hmtMp3Yfr6B452J26ipxIgUUMaA+sDVqSi9TC4+elDvKhR9e3FlP6cZghJvIWqYaMm6GRWv7jV7ZVCKXOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqcbs/m9; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBa2DT3MU8mcZYx/S24/8/JvKNq1vNIcTOEBsaVC3H1ICq8/f7m64oH4dBvUbBltS7dy+jRFdOSNc8uApuwew23J3XjUcZvCDUxbC9NwbNCYFk25yzu0JUiMgrxqVpO3CJtV9BnPhP0oZZrSBihfqDSnH3aPaXRjTWUfaUcXacgAYFUYwPOFg0eWtbLCPq7DSpVy5kLtBy7JeWULuS8jAB7LjwcYT0PdnJZuwM/DIMP/UmzwUfU5xzBCdK1igfQP39tbsp1+PJpSnKPKmXY2gaknqo6mVBFHDwPpgnXFfG5Xj7sgfB8JPtTanSyiFkWsUIy7J5c4yYJR3ZYvsfPvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD6vpY7g2PmLu5oWddnyKLwMcnjmJmVndH2mz0Qsg5k=;
 b=DOBjDoWqfRcJdW0fOvvZKfRL9C25/ZstM34VzaowUh0+q2Nd1VsGnNa0fo1ddqESAQ01MBnP0YKewmI+W8m09sJN3tGdYGGY5/iT4/6fc3ZA1Icui/TCoxUl0mkiGK8rlxKazgKkHZE1NrqN6BUhaSCnqAy49vGCY2rVGTOt+CQxkEcTlr3AMsalRtnTKJymZ/AMRLMlBZl3VozKO4x+IJOlCK+1Qu8SHYdyYhQX6e87tkx5I4OGVWzFsek7eZkbNs53OTrbICe59JcCjWa6uKeVZxLE3xsSs0iaGQTNelyu77+3+lTF/yxmZ6l9Ys3LF9uropNDBSmOnckJ9CRGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD6vpY7g2PmLu5oWddnyKLwMcnjmJmVndH2mz0Qsg5k=;
 b=uqcbs/m9kVqZdS0ngGiJz4Fw5ZnBmUE15x3S6UziXXGT4NGLRSL77AjXFUq3/k7kFV5KArC3KezTz0utlXYMLTOybx4spD6A3pL6Tp1lqIUYdPxtv8/1nJ0soRk+WoBSWi8aR8RBJ9YOTsOCWAgroDu813ERo2V6KVVu14jP6i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 10:25:21 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 10:25:20 +0000
Message-ID: <f70ccf20-717e-4d99-9f9d-5d79043202cd@amd.com>
Date: Thu, 5 Dec 2024 15:55:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ethernet: fix typo in annotation comment
To: Jun Miao <jun.miao@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: linux-kernel@vger.kernel.org
References: <20241205065218.1288394-1-jun.miao@intel.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241205065218.1288394-1-jun.miao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: aea8e315-739e-4965-87c3-08dd15171ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlhmL3JnK2NXTTZrWG9VZU9NenlJL1dodzJITXJwTXhBaytTRFJoZHYreUJD?=
 =?utf-8?B?VEY3YVlNVVRUb0dpK1BydlZZTFRKMkZ6Y3BabXNMSW5udTBDSlh1b1hycEwy?=
 =?utf-8?B?elJVYWRveGtxdmhtMFUyVUdvVis1d25pa2xWdjJCVHVtc1hQaU9nalM3SC9i?=
 =?utf-8?B?SFRjNjgwK21HaDNwYitWMXF2di9meGRudTFKVlJvWWhtUE1PUW9mNXh0cVI0?=
 =?utf-8?B?VXgzb1FHL0lTLzJMelhBMlhpRlFHVHljakthK0J6UUJqR2p2ZTlnWlh5TnZP?=
 =?utf-8?B?eFdCbWJLcDF6b29WZHFKSDNYTW1EaEUvMG1OVkNBRFQ1SzJHVm04emxhV0lC?=
 =?utf-8?B?YWlQSTVwTUQxRGQzdEhPc2VmY1EwMEJ5eUI4ZGxhVnI1Y250VFdrYkhNL01h?=
 =?utf-8?B?UWtpeDVwUW5JcExCZHg1NkE0YVQ2azYvUXE0TzN3VHpJNm1zZ2lWejVMcGRZ?=
 =?utf-8?B?QThPUW9KY05RMXdKSitJT3lOOU5UdEZmQmVoWUJWZHI3RHFHS0Jic0ZVVWRI?=
 =?utf-8?B?em53cU9YYjdabUswRjVxRWNtU1pyaUVEUlJ5VElnRlo1Q3JvNDI0N25VUG9y?=
 =?utf-8?B?bCtIRDF5N2crYWZoREJPZjZna1R2aCt1RXQ4SFZOenlyY2NhY1JzZCsxVHZB?=
 =?utf-8?B?alE1NTV6dTd5OUJtT2hrcjY1YXpNQ3c0bG9MMHVtbXdJdG83b0ZLTS9mMlU3?=
 =?utf-8?B?bEZScm9CdFg3c2lMZWlibytjZ2l0Smg0aVAxQUIybit2akM2b3B5NDIreU5y?=
 =?utf-8?B?QXc0WGJ6cWo0bzIxekFZYSsyOWYyd3k0aUlzL1loWTUzR3R2aFFqdkhwc1E5?=
 =?utf-8?B?Nys1LzJuaTRuektXUDI1RW96NGhNUzg0QkFnbmU1RzVXWDAzbTZQTG5veTJq?=
 =?utf-8?B?eEw0Y1hFVzZ2YnEvcFBCSVBmNTlZaWNlODJCWk5nczN2OXIrMEVOdXRIY1By?=
 =?utf-8?B?MmFqNDRqMlBsUWwvMklaaEYvTmpZbk5vRm5nMnIwa1ZLVnd2NSttVVExbWhr?=
 =?utf-8?B?Y3VYV2JzQnVTQ0pka3pac3pYSXFvV0hTSzRxV2pqcmkvbHEydjB2Wk4wclJ5?=
 =?utf-8?B?UkJGM3RZYldiVm1wSmV2VjdPL2lUMk1DM1pyNXBVdHhpZTFBQzBSc0lWdEVC?=
 =?utf-8?B?b1RHNVNiRTZyN21sSFpvOG8ySzVIaExXUzFEdGtwbDFBdDFjVnM5ODRaWUtH?=
 =?utf-8?B?QkgzVmduMjBnOTNCREdQVnBoOXIrRnNRaWJ6OWpmVkNwWTFYdGgreTZVNVU3?=
 =?utf-8?B?UFk4eW56NHJaM0ZlU3hnRCt1Q0F0bk1MSFVSRE9rb2JXeXp2RFFjRGxIcll6?=
 =?utf-8?B?bFlETW1vYXlMVi9ldHkyUUxqTkxiSmVqZ1Y0ZlUva0hDTis1K2FHRGpBY3Nt?=
 =?utf-8?B?VVRVWEZoNWx5a21xWUFDYWRhZGVubTc5WE9BdkY1N3A3cmFPWm1SdllnNFpU?=
 =?utf-8?B?TFRveW1JNTZQOW9QYlFMbCtkZUZvZTEwWUJOUEJ5NFZpU1R2b0RiTHBYTEhl?=
 =?utf-8?B?TU8xV1pzWGI1VFo0TGltM25RdENLZ2pKMzd5STBISkd3SnNiU2NsTmJxWWlC?=
 =?utf-8?B?ZlRMN3VUVWFoYURxeDVNZ3E1VHBoTmpJNXJsYWQwbnAwUHkxczlHd3B2cDI5?=
 =?utf-8?B?NFZYUnpRZlVTQ0tNbzRpUTFtbUlSVXlCNFdab0dRRHNyK2UvYXR4cm53bVc4?=
 =?utf-8?B?MlUzYk9sTkNqWFV6ZUNET0Zsc1BVaVBKN2pwdDBzaXRwbDA3cnJsNFk5VGsv?=
 =?utf-8?B?WXp5enhvQ2NubnI2Nm4vbTMzUjBreUdkNGRna0I0enQwQ1hkVysycGFvOFpL?=
 =?utf-8?B?aEI5QStDY2JOQ29jMGhTZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RElvbWVURklNM3NGZVh4cmEvQUhTd0RvekszeEFjcEw2ZkNXbkx3eGtPN25v?=
 =?utf-8?B?QVNGWkNCYW11d2xqNWFyVWRGU09xeTRJb3pkUUJ0ZFZPcFQ5RzRweWlHSU1r?=
 =?utf-8?B?R3lQeG8zVmx1Y0toTVplWWtHbzM3MHhTYkE3TjU1MjZjWUxvRk5wRmxoeVMz?=
 =?utf-8?B?WTlESHdRTEJyRXgvV0RlcTdSb2xmWSthenVUM1Erdi9lOFdweVVHbytWQTJp?=
 =?utf-8?B?Q2hLYk5WamJJckF5MnJGSUp3NW90SnhFbUNBZnZmSy80SnJNSXVNUkNXTk5z?=
 =?utf-8?B?K0o2bFkzQ0Y3UDZKQ0I0cWJ2NjVQZnRPNFlmenUxczRobU5mOVBwaGRncmVS?=
 =?utf-8?B?Y3NCbnpOTWFJVVMrQWVJaExIY2ljcDVHRzlZSktZcHc2MjdvREhyTTNMY25q?=
 =?utf-8?B?T3VIYVBURVVVTVlzaUFqcXQ0Mk00anB6ZXJ6SjJxN0VjdDRQU0ZwdkU5YTNj?=
 =?utf-8?B?ZmdmOTQrcmpxUjUrT2o3bzJuaHdtMzVSY0E0bVJleGZkV0ZqRFdXcVE0Q290?=
 =?utf-8?B?c2o1UzNNODVmWUVUSkorRFNKalN2ZTBkQyswSlVRVEVYSmR5Z0hFZXdmek10?=
 =?utf-8?B?SEM3d2hoRUtreURVRUU3R1ZvaVF0Y0NOdWdpOEFEbjJFSUtYMzRlVmYvZDR5?=
 =?utf-8?B?UURDWlZ6YUw0YmNRdk0vK2lJMm5ZVGo3NFRUaWM2ZzlJYk5kMkZsd3ErRkt0?=
 =?utf-8?B?TWVlWnpXaFI0ZDR2Q3dTanoxY2hOdC9PMFNJN1QzZGlpRE9vMUZDME8yY0Vu?=
 =?utf-8?B?bEJORStBRXpjTWtTMWM1Sk83VEE4RTJRb25vQ2lkWWFkZUZ3R2JXT09TemFm?=
 =?utf-8?B?cXJuRHlUV0JZalBTOFZncllGS3VLejUxK0Z0Z2htVCs2Mzd6OHE5MjV5SWtE?=
 =?utf-8?B?QWE5UUZxeVE3UXNaMTJKMUJLc2RHb2lRZTY0UlpBbDZlNGVNbU5veVI0VDhp?=
 =?utf-8?B?bUNIYUxmQjJVQkh0ay9LcWo4elJiTkpDREl6aGJCaGN3Yi9TZWVPdUlDbTgv?=
 =?utf-8?B?SUNxQXpCcng1WFdNNWxiNU1mUlpiQUVxd0JveHUyOGhXRDFVQlBuMlFIVGY3?=
 =?utf-8?B?Z1VSc1hTSzY4eUp1ankyMmxnekdIOXp2VGNodWJFTDFORzdKQmdUbHJZZHdp?=
 =?utf-8?B?eURJZ1hFQ2pIa1MyZDY4cUQ5dVFHKy8vdkZuWktCOVhOZGFubUEyOEYvS3Nl?=
 =?utf-8?B?RHhSYUk0cGFIbWc5NUJhc0lzakdVMFhaVXNLYm52ZHg1TSswandjVWVWSyty?=
 =?utf-8?B?dHNSeXdtUXNWK0ZBREs4ODRFNkk1Z0UyOFVZRUNuTWVHVU1TS3ZRTDM3RDFF?=
 =?utf-8?B?bVBNMDFxcGZhNWF5ZGV2ZkFzcWJrckNUQmdCdHFwZkZEdVQ4bWxoR2NXc2tk?=
 =?utf-8?B?K1kwcG9sRThPdUdHdEdPMXd6bm5UWXgyemR5REdIcnc0UnFLNENBYVQzUG5F?=
 =?utf-8?B?Y0RWVXpxWnZMNHRENEE1T0NMZzBpcXVMY2VEMTF3aWJLL1l3aURmTUptZ0ZP?=
 =?utf-8?B?TFFQNWtZbCtTeTBOZXlheG12RzNxOTlvZGZ0VjdnT0w4VVhkNkJ6bWFUeUVa?=
 =?utf-8?B?Q0p0RkxSWDhabGwvNDJoc2t6L3FNSG1waFVQT0JiNFVMQVo3WUZrNWIrd20x?=
 =?utf-8?B?QlpwYUNYSlNaWjB0aktvOUlxRmU4NHBURm0ybGp6cTMvVFJJcU1mQ0NQclR0?=
 =?utf-8?B?UkhBU1ZtZTVqTTE0bnJsMDBwTkVQSHNTWU1PNjMrMlpybGlCMjhHQnhCemlW?=
 =?utf-8?B?d3JWY05scHpkNHpsNWE5aWZnRWZETHRBUWdDZ3dlM1lJNnFYLzQyZWx0KzZs?=
 =?utf-8?B?bzl4eTNXUnlPS21hdzg1RkRqd3p2ZG5IMTRUNWlXYlZMbEY4U3ZKeUNBYkZZ?=
 =?utf-8?B?akFNaHZ3TC80NGlGR3haM3JCbmdrY2J1SzZXU09tK2hTNkFzQkRpWFgzSlFm?=
 =?utf-8?B?d3hhVUNRTmR0dHcvUnZwZnZJdkw1UWZDOUZoUkNFY1hpRDBqVFFzMnRGV2N3?=
 =?utf-8?B?cVA3Yks2TDJ0OEVreENSYVpsKzBKUkN6UXlTNStxdnhUUzdzb21WeFZRdEgr?=
 =?utf-8?B?OEVyRDMvL0NBZTlsaVZwSDVFNmdQTExIRVBsZnFUNmFGN0lxRy9UOEkrMkVw?=
 =?utf-8?Q?UIIunlvkNbdDVsn2h2328YVtz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea8e315-739e-4965-87c3-08dd15171ed3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:25:20.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNDxplkMZQL+dG/6h4PdtkB+Gm8F8Qg42dVb3z3lET/Sl7nXAkZfPxbyWteHDgrR/0FovUwwrhb3+DSrFqrx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245



On 12/5/2024 12:22, Jun Miao wrote:
> It`s "auto-negotiation", not "auto-negotitation". Let's fix that.
> 

Thanks!

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> #for xgbe-mdio.c

> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c  | 2 +-
>  drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index 07f4f3418d01..5597e7df0aba 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -1264,7 +1264,7 @@ static int __xgbe_phy_config_aneg(struct xgbe_prv_data *pdata, bool set_mode)
>  	/* Disable and stop any in progress auto-negotiation */
>  	xgbe_an_disable_all(pdata);
>  
> -	/* Clear any auto-negotitation interrupts */
> +	/* Clear any auto-negotiation interrupts */
>  	xgbe_an_clear_interrupts_all(pdata);
>  
>  	pdata->an_result = XGBE_AN_READY;
> diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
> index fa3dfafd2bb1..2bcce6eef0c7 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_mac.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
> @@ -1581,7 +1581,7 @@ s32 igb_disable_pcie_master(struct e1000_hw *hw)
>   *  igb_validate_mdi_setting - Verify MDI/MDIx settings
>   *  @hw: pointer to the HW structure
>   *
> - *  Verify that when not using auto-negotitation that MDI/MDIx is correctly
> + *  Verify that when not using auto-negotiation that MDI/MDIx is correctly
>   *  set, which is forced to MDI mode only.
>   **/
>  s32 igb_validate_mdi_setting(struct e1000_hw *hw)


