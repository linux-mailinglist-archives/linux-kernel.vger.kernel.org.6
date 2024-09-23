Return-Path: <linux-kernel+bounces-336101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DB97EF29
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80974282B69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F6219E99E;
	Mon, 23 Sep 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hrqwyPck"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE019F105;
	Mon, 23 Sep 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108606; cv=fail; b=pFLU7fv3QGWVygTlH6nB4uZFdPMDe72cc9N0Snc3RBl9dA6g9nec7kG4F47wUiKSrK6s32h6wnKiBwpxeDJ9KNR1DV/tM8hE1gsA/wgDX0wwWXgQ30B4CY+1HlCpJR0Z0FD5b+dEp0SB5EuASSe+38pF3SxHPQn1lqJreCgmeM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108606; c=relaxed/simple;
	bh=24fRBk7mXbD5KhLvAnLsp6PpOwHD7K6A+KxQ8djF9i8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gpl1yrDOFNOfddalNY3ssSYVvZwMEVYYNQc0piKlLgzddFT7A77/QKoTaqRLcbbIvVb74u2T0std2C+rjOoDffqgwVY6qgkdU6xXyCf+GKskoQ+9Vf3z6WKImsHmWI7ubtyAFOZcQ+aRULoDeEwGNHCkS/tehu/fETG5/mTMwrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hrqwyPck; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg0Fgwl2QouXzOTMBBUWKO7igpAC4cMMXJHtiSwocZTMEnpzPWHsFHdMF9DeQFBVaPij7ST764LsjV3UqWTDCatHBkJFXZI3AJUSJBeofc78j9txawaIcZPZYtncGZVqSLSHNTq/Diw5/hfbgpIV+Jfym0A8BRfh+OzDYlBw/x79nwbR1FROzPTB1pRtP9Nl/b6leOWm4Vh3/jTz+d4bvQRpim3d/zPEFxxfVRkyCqgslUhiIoegxyTbwbmh8eZhRnlHxAg2DBAuTko0/PDFf+T+9b9aXXZlx1x/FIFJTc8Qx4mrwcslENZeU/brNuS1NjgfkApHw2F8ZnNmGKyioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9zmKSQhbzjyKg/LGM+h4ZinlCjM4gAWeRDU4HQYvPI=;
 b=knjSjOvUhDeGnYzeJH3AJH68xq0nAGpXeo6P/XSHzQ5RFa0FDNZ40tvmPXh37fjeg6+mp6cDxL6vh+uLQqvkanOG2YedVM26xpXGn9UxKaUCqicoTKpVwiGhdV0Ln4U/0lOHC7hmprStAbBJYbx6bJHkNSOebmKmzCOdBqg8gyVUEEleu8xeQdm/tp5bi5znw+Uiv2x6FTCQkFy8ktlxM6Ix4ZG5QlIzX5XGHqTAO+sldg2Y4jBti0pTlWXtY9tfp5gtjHNNq7IfjgXhqbfN8lFjJkGX+ViNTleIVQaLItRGRMHMsuo0upILd+F9mHfXDaQNpCWdXb8Wa4Rebc9GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9zmKSQhbzjyKg/LGM+h4ZinlCjM4gAWeRDU4HQYvPI=;
 b=hrqwyPckIWf3hQijy1+i6guzsLyW3BljcfQDEqG09/Rs5o/iQC2WIqoEFJKJBTWnlEkgCBJlwNSH+y5GR4up5Sr2kP11589AZy1S9DcdKuh/1/yJxUB3CTkxkRi2qqFXe8j/T4vgQX++vV/qPtOvPMOHvsDKoL1un5LbLwglgW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Mon, 23 Sep
 2024 16:23:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:23:18 +0000
Message-ID: <e523949b-876e-4c23-8268-b4baa39aca65@amd.com>
Date: Mon, 23 Sep 2024 11:23:14 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 08/24] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <e7e411b2055c50e036e5c2a833e36aa6d3016d3c.1725488488.git.babu.moger@amd.com>
 <721157ca-fb54-4f18-8bcd-76ebb021d484@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <721157ca-fb54-4f18-8bcd-76ebb021d484@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:21::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: a48d9dd5-548f-4f20-0022-08dcdbec089f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZDbHBWTGR5MWJ2d0kzVzFHMXpDYlR0RGlUTDVGSFplNE9INExmYkFRNWFz?=
 =?utf-8?B?MzdCZjh5WGRQZkJoZEFaRWdqSEN3SVI0b28xWmFGMmhJYVJHeFNOTWhPQ1hS?=
 =?utf-8?B?KzdQWGM4cDhrL1VUSU9IN01hbFErVHJEK2l1OHhha2MvWVkxalJnWjA0Tk5m?=
 =?utf-8?B?T0UvTWo5T3RlKytuSHo2ZlFKZUl6bHdoWGhlMGlPdHQ4NVlyNU5VNy9aNjJJ?=
 =?utf-8?B?MWQ5bHZBU3dEb3QxaURPVi9TM2FjdFp6Y1F5cE0xbFMwRmVPcVJ5Q1hyNUcr?=
 =?utf-8?B?ZElheWFrWGkrNDNXWVJ3UVNrQWRZM3BKZUE5d3p3YlE3K2J1dWMwenpSY0FT?=
 =?utf-8?B?UWJhSnZUWUpoY2N4ZytQNHNidUs1Z1c3T1F6cUMrL3E5VWtUUzlzTDFsaWlD?=
 =?utf-8?B?clhtU2pNL2cxZkNqdldmakV2SklwWm9sQlcyR05nWEJBdFVtcEoxOGNaWE52?=
 =?utf-8?B?WllucGM2Mm1NSWJaTEJQeXdFYUpoQ2I0NFM2aGUweHRQM0hkTEFOM3lScFJv?=
 =?utf-8?B?ZVduTW5xWUZXVGVSSFJ0SzZJQVQ0ekxpZ1FTQWFNWU4yRVh1MzJmOWpVYWFO?=
 =?utf-8?B?bXd0VVVXNmhmYnZRaGV6TE1xZnpSWWJURTR6UFVVaTl4eHJJbHdKeDBLL1dN?=
 =?utf-8?B?OCtTSVZWczFNeXpwb2ZRM1cxUSt6aTJRV3k2aXNpWSthZHBtOCtJSFRkQm1P?=
 =?utf-8?B?czQrakx0MHdkUEQwaHNXRVFQYVYxUG9mN25FNjNZY25KQW5RbnFSckVaazRU?=
 =?utf-8?B?ZHUxWXhKM2s3NWtyMGhSaUg3QW9Gdno5WnVkTE16b0N0NGRzL1g1M05jOGtO?=
 =?utf-8?B?cDZtT0lmcDhXa2ViZkJ3TUYxeUY5Ukd1UVdJWHJ4NFVKSk4xV0tISGxVSDZh?=
 =?utf-8?B?Y0o5RVc1TThxV0x6MmtFdHI4dUVrVCtiS1NUd2xhOHo1QmZQb1dxNVVLaDl3?=
 =?utf-8?B?ZkZVRkIwUlgycis1ZDdCNWVyVmUrZUNERys5WklEUTVMc2VMTFlyd0N3ZVBG?=
 =?utf-8?B?UXRvSmNDRk81L2xtenlpTVZDNVFVSmJDWitBTDAvOXg2UUxvRUI5SnFUUEJj?=
 =?utf-8?B?OVMxK0gvZDBRVXVBUFVRMXFoSURDWlZJQ25KbGhTYXZJT3dVRFFLTDlJeXMy?=
 =?utf-8?B?Vlg4MCtDbmdybGxUZHpHTEhSVVVyQXdFejNiSC9CeXJkblJ3RjU4aFF0M2xy?=
 =?utf-8?B?Z1JtNkhxYnpuUUVvWDEwUzFRVGc0d096R2NWb2hFWnltWE15dVdjdDB1VlI4?=
 =?utf-8?B?djVsaXUyV2E0SDYvYU9HZnhoMXcyaS91L3pnNHdvZEIrdzJjWjdyeGZpVy81?=
 =?utf-8?B?Q2FUN1h1M1FyN01uSkh2bm56N0Q4NEJFOW1FMTN4NU5XWndtVXhJVHNRMG5Q?=
 =?utf-8?B?c1EycDNxTHlGS0JuZlhwVzl0dDF5N0FCMUh3ZWcreCthRFo0MHY2WTJFalBX?=
 =?utf-8?B?RzBHMDQxRmtVLyszd1dxYWd4QkZXY2svaUVseWN5eFl3dlJGQ2cwelh5Mk95?=
 =?utf-8?B?eUdNRFB1WWQrSC8raElNTWVhdW9Fak91Z2ptT1d5UVdZVUdyUG1tYy84RTRw?=
 =?utf-8?B?K0hDTFpLbWJUQ3JRWFFRN0F0S1gwODBxZVdUdlplWjN2MjZkSS94UHQ1N0hG?=
 =?utf-8?B?dkZCYTMxbVlJampFL1lyL2ZYTms0MUcxR21LeWROQ1RoQkpPU01sWWdGRVFo?=
 =?utf-8?B?Rlh5R1RicWlRaTN5OUlBMXlVazMrM1NGRitYaStLb2hHRWdrZDBJTndBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3RwZFVFTG5YMVNmQnZva2N3MEIvUUs4UkRBTXJhZlRGWW45dEY2S2E0RlZ5?=
 =?utf-8?B?aFhtdGZuaXg0UTQxL2x5STFDbXE1ZndLUzNwRW1TeGtEY0FlSUlrVDVqMzhS?=
 =?utf-8?B?ZTRLL0VRbjhUYVVkRWRNNExNSi9GRkFqY2wyNHVRbm90NDQvcU1Bano0SGx1?=
 =?utf-8?B?U3N0UkJXd1lzQ3huTzdCWTVnQVA1bUtNUE56SGN4TWd2ZW84ZXpOMlo1TUZs?=
 =?utf-8?B?eS9MT3VhUTFFRXR5ZWk0bmFSczI1S1lIeGxGUDlBVE5BV3EzQTZXTEpaYSs3?=
 =?utf-8?B?RTYzbFhOcDBPRXpRWHNNWVV6bk1qb2xwOW9ZdnhOeHpOemVicWJxeDlObzZv?=
 =?utf-8?B?amd4eXo1VnNzb0J2b0UwOG51eld1cnhBT2lXY1NkcFcyYUw3eEZzaHd4VDBy?=
 =?utf-8?B?V0c5SUNOMjZjV3ZELzBSeDN0akZKN3k1Yy9CY2IvSG41cVpDRDh1dEc1M3NY?=
 =?utf-8?B?RXBwVGxBQjg5U3JqdEpXZVd5NkRrdFh2OEloWHdMYmc2b3FsOFJDZXZMZWxB?=
 =?utf-8?B?cmhzWUl2MUdWOEdtZ1dBaTFvMHdGcnN5eEJFOXVGK002Y1RaZ0N4QXI0Yldk?=
 =?utf-8?B?SEhzeHFrMWVGdXptUHBQZ1hXdER0SDYyRll0RkRDS3JXNlNTWjVTL1RPdTlY?=
 =?utf-8?B?UUF5dTd1TjdwRWZNVFRLQ25IU3JoS0lKTnNuak5mNU8xbTdGUHJFOEQzK05R?=
 =?utf-8?B?S3VnU2pwRXQ3UkVjU0ZCUXdJc3VTcVl3SWdERlBJVGlaV2E0aHRMYldqTDRu?=
 =?utf-8?B?S2pDbkFVQlVCY3g5V21UaFI3emNJT05ScFUvQlFCd3poRDJHUXdlbzhrMDFU?=
 =?utf-8?B?Y2pKU0x0SEdBTnoxdUlhSVU2Q1dOTjdQWXpndUo2R1hLSFY3SHdZc3hGVGw5?=
 =?utf-8?B?OFMyVDNXQ0lVUHhKd1Q4RWozc0xNLzd1WHFKRkNJTVpxbEl5MU1GOVM5b0dx?=
 =?utf-8?B?T2hkdEJWQUZLaXhkSTlvWENtMXF4K1RrWU9HaFNodmNKYTBEdGg4ZnVtM3Ay?=
 =?utf-8?B?dElyUmk1ZGhDcE55ZDZCT1BsVm45UVF3NDl6NDhDN0R4TDJRUWkvVDk3OHlW?=
 =?utf-8?B?akxvSGFqTm85TEp6WVgvUTd2cGN4Z2lwSE5ZMVZNVFJxY2JpWjBNNUFXWXBO?=
 =?utf-8?B?Z05EellDTlVab2FaOUtJRTNYSUpUTUJVQlZnVE5rM3Q2OVB2cWFYN0Q0QVo5?=
 =?utf-8?B?cnQrRDRjQktUUW16RjFoZ2owTGpWNFZsVUJ0dFRYZkp0SFd2d2p1WFdUcmVI?=
 =?utf-8?B?TFVKMjQyTG82MGYwTDVMTkM1Um5LQlZlMXZ1WldqZW1BNEJ2MENaNkdzNDYz?=
 =?utf-8?B?bTZMUksvblNFZ0lwL0U3NnVIZUF6c2h5L3QwdXQ3U3JuYmppUWNjK0hCMzRP?=
 =?utf-8?B?UFRYdTZmaTZyZHIrR3UzajJZV2pENXMvS21sc2xpOU5pWDVubHVwSGdmTG9M?=
 =?utf-8?B?T2twUGpDL2xhZlA2WFRPSzNYdEJrYVdZdzZXSDBFWUdFdXM5ZVpOTWFKOUVk?=
 =?utf-8?B?K0lFVnFEZzJaRjR3VzZVUnpVVEFxbmUzYVk3NjQwTTVNS1JLK0dPWm40eXhQ?=
 =?utf-8?B?SEFMVWdwLzRqSmcyazR2Zlk0dUo0SnNib2tZd0ZBQWpSVmlEQ2VEc1pFZWtF?=
 =?utf-8?B?NWpBSXE3VEc0NVZobWFxT3lwZ3NUQ0wzWC81cjdieHpVZUxvM1BCRU5FUzd0?=
 =?utf-8?B?NHc1bDVyYTd2anIrbE93WmVMcFBTK1NzV2UyT3lEY3g5dDlTZTkxYWRJMXdB?=
 =?utf-8?B?V0RTNk9BY3JYYzhGM3dad25SdTM4T3h2M3JycWJWc1V5OUlwUDVQSjRobTJM?=
 =?utf-8?B?VGMrdGpyMWJxcDZsQ0NyOGY5dXRXekVNOUdzbUNZUXkvcU1qZUsyN3ZmU2hq?=
 =?utf-8?B?b0xDOHJHWkJndVpNK08rRFhsa2hQdWlyUVdRdmZjbm9ObDRWNUJDNDg0ZWRH?=
 =?utf-8?B?TEdBaElhWHMyV0dVS2pqMHY3elp1aDVYRWNXNjVhK3JZeHVYai9qS0pjVm9S?=
 =?utf-8?B?bk9OeFp4QVpRY0haRGN3WFhLb2pSZnpJaXJrUFY1YzdjZUVBVGpIWGd5djMw?=
 =?utf-8?B?YkFVRlU1ODM2YytudENEbHloSjZSL2JtdVdlaUJhTk9nVW9nOTRnTzVrVU9z?=
 =?utf-8?Q?EIYQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48d9dd5-548f-4f20-0022-08dcdbec089f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:23:18.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yLiYTh8iDlgsg9ezbvGmAh9ozpORct4IeB4G0ZLAe+EZGSnULwDxv3yRC7MRbLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

Hi Reinette,

On 9/19/24 11:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> The mbm_assign_cntr mode provides an option to the user to assign a
>> hardware counter to an RMID, event pair and monitor the bandwidth as
> 
> Could you please be consistent in this series in how you refer to
> an RMID, event pair ? For example later it becomes RMID-event pair.

Will keep it as "an RMID, event pair" in all the references.

> 
> 
>> long as the counter is assigned. Number of assignments depend on number
>> of monitoring counters available.
>>
>> Provide the interface to display the number of monitoring counters
>> supported.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Minor commit log text changes.
>>
>> v6: No changes.
>>
>> v5: Changed the display name from num_cntrs to num_mbm_cntrs.
>>     Updated the commit message.
>>     Moved the patch after mbm_mode is introduced.
>>
>> v4: Changed the counter name to num_cntrs. And few text changes.
>>
>> v3: Changed the field name to mbm_assign_cntrs.
>>
>> v2: Changed the field name to mbm_assignable_counters from abmc_counte
>> ---
>>  Documentation/arch/x86/resctrl.rst     |  3 +++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
>>  3 files changed, 20 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index a7b17ad8acb9..3e9302971faf 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -290,6 +290,9 @@ with the following files:
>>  	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
>>  	if there is no hardware resource assigned.
>>  
>> +"num_mbm_cntrs":
>> +	The number of monitoring counters available for assignment.
>> +
> 
> I think it will be helpful if the changelog and the above doc notes when this file can
> be expected to be visible since its visibility is not connected to visibility of

Sure.

> "mbm_assign_mode" that refers to it. There also seems to be a conflict here where
> "mbm_assign_mode" documentation contains section about "default" that refers to
> "num_mbm_cntrs", but "num_mbm_cntrs" may not be visible if "default" is the only mode.
> 

Yes. Need to change the reference to "num_rmids" in default section.

-- 
Thanks
Babu Moger

