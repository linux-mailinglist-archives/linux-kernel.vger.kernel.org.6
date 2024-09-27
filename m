Return-Path: <linux-kernel+bounces-342004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCC988984
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768B5281E99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704491C1748;
	Fri, 27 Sep 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W86PweGX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE816D4FF;
	Fri, 27 Sep 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456803; cv=fail; b=tdEGYtgC22Mq32/n90bzpd94/BVCbiIArtUSCedIM6oqcplg4qqi99rBrqauARnzvbPs5ybqBXGHSG6x6c741V/2Nt90J5HdLoTu9sweh/5GsjK9DwA0vPLRQlsBvfpkDWZMte1Vw7TDT9ETNNix0DdAzuneRobasaOBZoWXKwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456803; c=relaxed/simple;
	bh=2SL8a1qNxfLU3mBroI4bXacz8RMnEJ0CbH5nfwpVb2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yo+6yy0CVdudup4wQ+1Yo18xjmsOwF+lnjiYms7QnUJd5osuCrvMRD7vC4/87Mzf8PbdQYqVqjc3CQ9REfU8uwFpPZztJZvVkj3hTHNqBWO8UIx/ozNdi8HORBMVpAPtFFJjAnmQ7Vs/GFH6Pxe6Sq5P3FCuMlEzgvUpBi/SJKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W86PweGX; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSQv412rQojhT1w564NdEdB8VYEnritRORiDr5w3e91kZb9svL7orHajj60U94iKmgT3tgYA3YAJPIF/6lypSwEqkCSVyXPANzuxJx3az205JqJHCwJ2CmoG93MHXr4KEmBCWHMrganxE2ul1p8liMCaBP5MPX7hCvUcc+hfeorDoWYGlLvCC3wnwc+fDudK4sA39hOYkq6Tc3NnMWeD7fdoF1xLz7QKfZpUziAim9usXnWChqL1k0Nj/MPHjx1CWu2J5NukZTXtPAb66IlN9feBAqjk2katB9u9z35HeJi9O2G9VNB6XZeP0k2jv2Qo+B1dBw1NuP7VjJbasYJKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVyavfYfCYNX2SKSWJ1BY+WVTdUy1gW4IVwFPXaBUXo=;
 b=cvXnsa1GCNnOtigdYHbg7sebovQpnUW9yU0wjP8qjPbAt5gA2uuP/o4Cn/c7iM1ecBPr50qhpiGBIeJnMBtqRTHAqYU2idlckA/bNUyi9p27nCWWdYSlOt2w+nvAvJsT+erD7fzDucnuZQ1yucRtjVrAFWsN9Pq2uVVcb4X4QU0Z1dPDLoyQZcYRl4CvqVKYLnuY2C/Khi/sgJNAtDacqPCmshn/YYukHot20XN7K7ftEgs2fvMW8Rp0qkg6o/2i/MeNPA4i8S+rFyHqcagAYzuMlNQ00eCVTiUc66NsR+L6gjsoAbLCgpU/d3hmDAwxBpXOjObugxkpg2UIIS/I2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVyavfYfCYNX2SKSWJ1BY+WVTdUy1gW4IVwFPXaBUXo=;
 b=W86PweGXDiZyaDjkWF/8zNCTY1sG3gaDGG+13AkL43eepW9sEJ3B23l07AysRy8LsWfKbbP2prr6j3kpxNRvDD6ZXVBct04jU+qf+ioG3mzM5LK+jpaj8eb9hkkRkUxN3zmulKCIDXezVARA9Z8nqlMNendPdU7Us+dfSiVPcU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:06:38 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 17:06:34 +0000
Message-ID: <9a1e086f-c46a-6c6a-fb87-f0a2ef6c20cc@amd.com>
Date: Fri, 27 Sep 2024 12:06:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 23/24] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <e6782ee97520b92d44ba80e510e8983895426e0d.1725488488.git.babu.moger@amd.com>
 <fd370cfa-cee7-4b3a-8a95-b6047794d475@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <fd370cfa-cee7-4b3a-8a95-b6047794d475@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b38654-092e-4290-9ac1-08dcdf16bdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXdzRkRiVEh3bXNZcFdsaXJCR3hpS1FUQ1BOUDBXNEExb1ZJUmxaU01QWlM5?=
 =?utf-8?B?TUc3d2orQ2lsaldGY0V0T2p0WTF3ZVhueHFkeEdHQzFKcHd1blladllYT0F5?=
 =?utf-8?B?ZzYxMEdjSjYzeFkyY3crUEZ3MlJyWk1FK2YyOFo4SnNkOG5sb3IrTVhNZFhl?=
 =?utf-8?B?L1Zna3c4OXBwUm1qT1NtT1ZTaUs2Z1pXSGM3dE84SHhITzNRdkNNQjVURCty?=
 =?utf-8?B?NEZFdkkrRjVkdDdTYzliTHFSVzM3dUJ1N2M3cGFXVDNsdnlaLy9vK090cEhj?=
 =?utf-8?B?QzdGMVZwcmNFZ0EweHRCS1ZqYWwwZDhtZkhvTlZ2Q0hRb0tvanR0MWw5UFZG?=
 =?utf-8?B?eWJYc1lwd2wzekpVeTRPdHhVMEJMWmdoang1WUZKcFpNZWRqYmNzRUhiaWNG?=
 =?utf-8?B?bzM3ZGV0a1ViaysyZG1nWTZyN1kvbGo5RkxXMDdZdUV3L1VZbitjQ1BHOGZu?=
 =?utf-8?B?ZWt5TURVQVQvQVZtTUFQVjhhc0dxSXovRnBXc0lWQ3dlVFhJVU03TWV0eEFW?=
 =?utf-8?B?ZGVGWWt6Ni9tZFRnSUFnbXAvRmQ2S21pL0tybGo5bkE0cHhhWmVPOXJCOStY?=
 =?utf-8?B?anpFYVl4TCtiOUFaWDdSbFNhSSt4bDNlbDFRdGYvK25pSEYzSTdjVXYraDMv?=
 =?utf-8?B?MFBOSTlsV05rMUsvV1NQcVdzK1dwUENzMkZBaFBqU1FENE5VdWI3NlIra2hr?=
 =?utf-8?B?NEozUEZyQ1ZIQ0hVSS9qVFNjenppUGFjSFJHVUF0OGN2U2RwWGtoUHkzZWhy?=
 =?utf-8?B?OHZ5RGtuZkVYZStZQ0JzaVVMZHlBZEFBYjJydHUyOHRNTENYM0N2N2xnc2ZP?=
 =?utf-8?B?cGRNUkJjMnhVdFpXbTUwbitsc1ZXTFZkV1V1djVPVHRXYnR3U0lvRERTaUpi?=
 =?utf-8?B?QlpTQWM2SFJ0YlZKeU9FOGM4MUJtRWdZZmNJc2RMTlFpRkFwMnJzZWtyR0xv?=
 =?utf-8?B?NURhKzVHT3RnTEJOVFAyRnVDbGpYdWlkT0dLVExtSE5YdVRoNmcvSUgwWG5x?=
 =?utf-8?B?QWNFZGZ1NEdxRXgzQXUzUS9TRDhYcFY3aGVkVXJ2NkR6dE9pN2pFMlQ2emhx?=
 =?utf-8?B?ZGZSYlNMc0RyTXQyLys4Mm5LdEpYTEdvUEFEZmhTNUVTcGlzMFViWjRTaThB?=
 =?utf-8?B?RDAzUXdWaVBqRFZ0WGQrRENCVHJySEY2R0lTemsrdlNEaHVQdEdyUkYyVkxX?=
 =?utf-8?B?MFEzNGVETDBkTEJ1blU0MTBRaEtXSUtCVmowRGxvVWYrVGIwSEdkNVRUcDV6?=
 =?utf-8?B?ZTJlbE1XQzBTSVJZMWc3VEQ5K21tY1Z1RVloTlhDUGxYQ3dvbFVzMlpFaHZh?=
 =?utf-8?B?QXBwdFpYRk96aFpxZElnbXY4Sm93MFdWMitYVElhR01OZlIwSlBaeHRqelR4?=
 =?utf-8?B?WldCcGp5emthVjhmZElaWFBDZlJLODF4ckcxc1A3TGM1YkdSb05DNmtheUty?=
 =?utf-8?B?LzVDNHRrMW45VlBOVDVpbmkvQm5zeGNDL2xCZkVlblpzTUVreVp5NDFza2Vq?=
 =?utf-8?B?YWQ3Rjc2cDNTUUFTclM0dTF4b3RIUjVaeE51MGxteVhZUmRQZXRBVndJWSty?=
 =?utf-8?B?TXNaa2FFaXZ5ajVTVUY5LzZ1MFF0V0lLVHIrNTlwM3pOOUFiOVJvWGVNU3g4?=
 =?utf-8?B?S0pGWEZhcXU3cUYweTFrVk04VzRWbmhuQXRrVVJHTUkyNE5jUmgzT2lVdWhw?=
 =?utf-8?B?aTM1VGtpVk50cjQwbVkwZlBpaTVpYjVMUHp6b0ZIZ0dMc0Mwa3QvWXlDL2F0?=
 =?utf-8?B?WDhPVWNhSjlKL2YyOUFMZGJ3MjJ6ckNXOWlaZEY2MGJpSFcrVFhkTkc3OXlv?=
 =?utf-8?B?dzB3TFc1b1ZVdWUvSmJLdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGIwQjhrZWNpdTUrcUhFLzk4Rit4U2RKNCtUaWwvVUVtQitwTGQweFhENTNE?=
 =?utf-8?B?a2lOaEZiaHMxbit0RjNrZW84QjdFWGk0STlqc1hBbHhaREpDWDRQbS80SUdt?=
 =?utf-8?B?QUhocHZtTGR5VXl1Tzc0MmJ4OC9kaGtCVG9jdWZmYzYxYXJMVHNtUXZpMUNv?=
 =?utf-8?B?akRpZTNubVp4Y2JDMFI5V2xENUEySWs4c21HZWFvNEZiR203VEt2WWJUZG1D?=
 =?utf-8?B?b25CNlo5czVRYnlsWTREQ3p1QlpoWVNiQ2FsSHZSMEx4TDk4bnoreHBncW43?=
 =?utf-8?B?bC9ubGRxYXNXeWRsdlczR0ZNRjY1OW8wOWhQbWhpakJaQWxKK3ZsS1JwbGFT?=
 =?utf-8?B?V2lzbEhlMjFYcTF0endhdjEyOWJsTjdFb1NyM1ZPVEMrNkJrNWVGVmVrU29M?=
 =?utf-8?B?NmErTUpmT2xBNDNmSkdYakJReGhKMEdDalhnYnlmMTlMdzFHU3ZZUC92eC96?=
 =?utf-8?B?eVdaZ21Kb0xFMHVLUzlUZit1RlR4c0dTUTVkV2F0Z0pqZFY5YzRsdzczcm9i?=
 =?utf-8?B?VFpQSitLaEtLYnJNZkJxbyt6L09MUXlMejFubGwzcjNpSzY2VXRhdko1RDZS?=
 =?utf-8?B?UklyaC9GNEY2YUtNcFVRRG52cjZQb25zRFR3bGZ2eXZZYmdkb2s5bXpLWkpR?=
 =?utf-8?B?SUdrV1ROL2puR2llcFNvQnA2Rk01QmVXMVFQZTIxSW5MdTIyeXkvS2F5YTdN?=
 =?utf-8?B?YU5FS1IvUEFmeTRMbS9vNERJTGs4LzkvUlBaUDJNZUFtUy8rNVM2MXc1NzNX?=
 =?utf-8?B?ZUJ5Ry9VdllaZ2JHL25CL3RSZE84Ukk4MUp6Q3c3NVZCMFJzbXgrZ2VMUDFY?=
 =?utf-8?B?d29yQmdDcHkxZk9IU0hFRlhLLysvYXRzZzJSZE41RndMRzIyVnFMajA2b0FL?=
 =?utf-8?B?V3Jac1p1YmdVMlJLTVF5UG1NYnNRaXZoZC9jNGV4YXJMV2xSTHhHbFFjdUVI?=
 =?utf-8?B?UDV3Y0hDRiszU2RoVkNoR05zdVg5MHhEMDV3M3Jaa3crcWd3UlFNVFAxSEwy?=
 =?utf-8?B?RnNoVEZKK0JpZ01tWjBsQWVUbFpyS08yb2QvNjBwKzNRVkZ4bGljWS9mMkRw?=
 =?utf-8?B?WWFEMDI1NGFkRUNaTDV6dm54ZjAzZHJIRll6aXhWaHVQajNmL0lqQVhiNVlB?=
 =?utf-8?B?REM4WXByR3A2YjhqSjc1amJCdFpUVnZpWFNwY0w1aUxkQjJQVDhnL1Bod1dP?=
 =?utf-8?B?d1VTTnhzSkNvSDhCLzl1MkcvK2o3b1VhR0RPSWs3YklIeldUSEFYNzR0Y3VX?=
 =?utf-8?B?bnBzYzNaVnRXYklaTUZ1d0JEd0ZGN3NVUVFvaGxESEZQQ1pXMGtMa0pWOEVI?=
 =?utf-8?B?ZC9oblV3czVrajMzTUlzcDFTWXF2ck94b1o1b0FuWUhHTWppa2NXSDl4TnRW?=
 =?utf-8?B?WFdtMWErblNRQ1BLT09naUVRNGE2RHM4RHdpek8wQ1djRUlwenlaZnBVWllT?=
 =?utf-8?B?RW5NV1BDVU4vdnNxL1BKUStsTUtvcWNRcjJIZzAzNUdiMHc0Uy9VcnBGRXJ1?=
 =?utf-8?B?QWwrNWYvTFdWQ3oxV20yYm5FTFhVUyt2bUdYQXQxQkhLQkNtR0s2SmFqUlB1?=
 =?utf-8?B?azNmZmhLc3E1MSt1cWxrNkNWaTlpQXQ0RVlTcHMyOS9YZGgydDl5b01maDhE?=
 =?utf-8?B?TnU2cDM3ZG81SnQ2UGp5NWIzUm8rY2YyODhzUHVKRHoveVl6ZllZcVFFeUVO?=
 =?utf-8?B?U2J5NVJyZzJZUmVnbVFkNzZPYWh5ZkRvNDRFMWZlMEFvODc4RXdCanpCOTIv?=
 =?utf-8?B?UDlJdytjMlBnRk84UEFPaEs3cnoxQ0dMMW84L1ZOd3VGeU9KaEd5NUpCM05r?=
 =?utf-8?B?ZUdTQkxrRUFZVS9zWnpDRXNINTlRemRYc0YwK3dMemp5bFRmQ3UzbWh5WTJr?=
 =?utf-8?B?OVhkQUgwMlBPcUx1RmdFMVdPcFByeG1XTUdDbnNIalBOWkQyL3Y5V09JYjVp?=
 =?utf-8?B?bUFoVGUySXZnRWtBc2JlMkpxTFJLUE9FZS9LNTRrWkNFZ1NHcTVFMmRRcEYz?=
 =?utf-8?B?NzhvREhKVXpnZHJITDJ0TWtianhmM0pYQzRUdkQxSG4vckN5dnkzeUQ3Yk01?=
 =?utf-8?B?RnliTThVSkZ2Vy9xdkZyWG1DVDRrcTliWVg4OEE4cE9QY2w4MFNCTDRjTTNu?=
 =?utf-8?Q?RnJ4mThQhmR8BgJ1qGbQQZByx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b38654-092e-4290-9ac1-08dcdf16bdd7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:06:34.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmKCG066XxkrZOhUYA3EWygyVTj7BDxzrtJqEvk8K1gnphCxzqH8COx2UKGMGXZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

Hi Reinette,

On 9/19/2024 12:53 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Provide the interface to list the assignment states of all the resctrl
>> groups in mbm_cntr_assign mode.
>>
>> Example:
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> It is not clear what is intended with above example, was it intended to
> have some output?

Yes. Will add output here.

> 
>>
>> List follows the following format:
>>
>> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Format for specific type of groups:
>>
>> - Default CTRL_MON group:
>>    "//<domain_id>=<flags>"
>>
>> - Non-default CTRL_MON group:
>>    "<CTRL_MON group>//<domain_id>=<flags>"
>>
>> - Child MON group of default CTRL_MON group:
>>    "/<MON group>/<domain_id>=<flags>"
>>
>> - Child MON group of non-default CTRL_MON group:
>>    "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Flags can be one of the following:
>> t  MBM total event is enabled
>> l  MBM local event is enabled
>> tl Both total and local MBM events are enabled
>> _  None of the MBM events are enabled
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
>> +"mbm_assign_control":
>> +	Reports the resctrl group and monitor status of each group.
>> +
>> +	List follows the following format:
>> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>> +
>> +	Format for specific type of groups:
>> +
>> +	* Default CTRL_MON group:
>> +		"//<domain_id>=<flags>"
>> +
>> +	* Non-default CTRL_MON group:
>> +		"<CTRL_MON group>//<domain_id>=<flags>"
>> +
>> +	* Child MON group of default CTRL_MON group:
>> +		"/<MON group>/<domain_id>=<flags>"
>> +
>> +	* Child MON group of non-default CTRL_MON group:
>> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>> +
>> +	Flags can be one of the following:
>> +	::
>> +
>> +	 t  MBM total event is assigned.
>> +	 l  MBM local event is assigned.
>> +	 tl Both total and local MBM events are assigned.
>> +	 _  None of the MBM events are assigned.
>> +
>> +	Examples:
>> +	::
>> +
>> +	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>> +
>> +	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	 non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	 //0=tl;1=tl;
>> +	 /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	 There are four resctrl groups. All the groups have total and local MBM events
>> +	 assigned on domain 0 and 1.
>> +
> 
> Please create the docs in chosen format, like htmldocs, and see how it ends up being formatted.
> For example, above seems to be intended to be a code sample but the description ("There are
> four resctrl ...") appears as part of the code sample.

Sure. Will check.

> 
>>   "max_threshold_occupancy":
>>   		Read/write file provides the largest value (in
>>   		bytes) at which a previously used LLC_occupancy
> 
> ...
> 
>> +static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>> +					    struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	struct rdt_mon_domain *dom;
>> +	struct rdtgroup *rdtg;
>> +	char str[10];
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
>> +		mutex_unlock(&rdtgroup_mutex);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rdt_last_cmd_clear();
> 
> This should be done before any attempt to write to the buffer.

Sure. Will move it up.

> 
> 
> Reinette
> 

Thanks
-- 
- Babu Moger

