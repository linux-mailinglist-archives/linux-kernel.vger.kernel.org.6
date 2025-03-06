Return-Path: <linux-kernel+bounces-550004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBADA559CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC07A75E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0327C86B;
	Thu,  6 Mar 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sGa5dqI6"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A61311AC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300289; cv=fail; b=h4lEKE87qVODmqJb48zPQmmFNhcQblVXhTREM/4TGw3+1zV4Gr1x3BW/eqs9z8sV3cOUzH9HS8tvottmWRVqSf/wIlB90L4k1JminMA5m/2ei1XWk2e8j3AYIPi8Y3cchXdspgmbyuN5mhtLD6Mkco29HGVKC88VY66kW+sGCk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300289; c=relaxed/simple;
	bh=TuvP7HloEBmu8UHzYOJlCrQtlJipu+ZWqUc2zL4CIFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7mEY350h17i4DHRb2OR1OEqc7xIN2IJEK1O25N2Unj1UVPsenCxAGblUcbTdFe+6JvexX4xOhmhlhndEtEwTtaNY2l1CpfXWPNhZm0G4i41q3UUJmx+7874hSbp7rMp8Q7NFrlwZRxHbqZM5sCFBmfKcdTEgB1qFPttw1Q6JaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sGa5dqI6; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5MqaoOWO2wDOtq2FCLKbYstk/F6qxjTO536hqYI+qRhJiV+1MMknXcvYuCpo3x4b7zcDQz7I+mzUumoGVrMLofcqhGZVoHU3ZqcJ+7IMnlZkbOUzzb0jpxTKBVG7onXltG7lpuVp+EkrXPM623guGUjCNbYC2G9NYXiIC0oZXkxQyVN5WCPTU+jGsBJqymufeC1CTYK89kRNExip2AjLZvsukQZjxp3/FjfV73BDceX9O1WbI37+t0pRFSpRMGswoKKVyXDs1GB0Bv+BEiWvFWXGluCFCYcMSwGgz+ZaPIYQFHaGJWBypKvZ7j/OqKXh7r52Nu8/dqhY1/rmbcu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuvP7HloEBmu8UHzYOJlCrQtlJipu+ZWqUc2zL4CIFg=;
 b=g2BYbGIRjg//05aVbID4tmdbu4Xrmie9T0FpbQ5jNwlMbhlsBEh0KnF5V0Ei4HxypXbAbxLVrou+JXrwD2YS2aRb8pswPGhOasq1cgR7ghS7U0/PDUCxNZOUwjAGJusy4y41HKX39Q6QmPn1YJSrr5dejfaZg7QtUk+LZNYqasShCG7iR7j8XwvdVroFzol5eWNDAhIdu8XQ4yGU7SRstonrp3MXeflcD1dE10e8WIARJlwrFO9Z9D1OU6iFeI1O0Q1WV/OX9NUfd/6H8WWeY0Js87wUpUH8sNPUlLLDcEX83LHzJw5KgoiKyX/e+Wlr0jXqFnNarKWNAak5tRcZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuvP7HloEBmu8UHzYOJlCrQtlJipu+ZWqUc2zL4CIFg=;
 b=sGa5dqI6QaCeUmLeVM3EgvqkG7ZguRx2hjyyxokCDe6ddd8lHiw5aujCa1J/sMZmL9AsRcVfnL8kFQQjSOiFnT4Rn9t+qxCuTUxLrSfAk789uOiD9THbrlevq2ClK+cWvY6QEtHY7v62v/vVzMlehsvucg9WIOy3hOMdYpSBz7+8nup2H0ejIsh9Z1BKdqdaBGgwjxQMTD6El4uNvVueVny82is3AKvpKXKuhyzHWj7j3Dg7mbtJvr2tKNQ7vrc2C/uriK6VqLs/Zc3Dkbfn07FzxToQX/oOAFbwiurecCvkPzJGxiqlw9NPE4MTTZ5fFuiKWdMfKF+utL6gyztKcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 22:31:25 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:31:25 +0000
Message-ID: <bb83bfb4-29b1-432d-809a-b95a6f9b4a3b@nvidia.com>
Date: Thu, 6 Mar 2025 14:31:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/49] x86/resctrl: Move is_mba_sc() out of core.c
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-36-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-36-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: a402bb14-9339-4dd1-c167-08dd5cfea0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2pVczhwUThLOThENjBkKzlhYTkrNEdkNVlPZVEzU0lheStuSlIyZm5yU2Nt?=
 =?utf-8?B?VzMwaHBEYVBkWnBYSGdHQ0g2Z1FCcXF6cExMYlgwSE9BeHJCSWp3Q2ZIWXlz?=
 =?utf-8?B?ZzZsdGdjRTVjVy9LWm8wbE84QWtIUEgwVlQwSEpIV3lWeGcya2NtejhhMmNy?=
 =?utf-8?B?dDNQQW9SODdDcUl0OHlnR2RNbGVkbWhjTWxEUXd3dVJscTR0aExubnd5aFdQ?=
 =?utf-8?B?aC9sQS9Db1V6WitLUElPQWN5TkFreFJGS0pzbExtcldsbGlCcnZtcE5PRDRl?=
 =?utf-8?B?a0hBd2s2TDZ4RUN3c2dXaU85S2Era2lKYVZjQWFNK25qbmRTWk90VVJha3pU?=
 =?utf-8?B?ZGNCb0M3L2ppNXBDMk4yaDRNQld1MWpSblRnelowRllRdmNBa1dHYXRqV3Zt?=
 =?utf-8?B?UHBNQk1LbGZJZTNxU3V6YXgwZHdWZ2JUVjFGY25ZeGJWTzBtZEkxS2x0dmJG?=
 =?utf-8?B?QWtmbTk3T3N5UHQ2ZWZaeEY4eUNGc1pQd3RncGp0aGJPdVRuVDJONEp5Y2hG?=
 =?utf-8?B?WEFLODZzdWZaVllRdFBtYndJQ1d6Ty9hZ1NXQnpKV0ZIa2NWVnJXUnJjazBI?=
 =?utf-8?B?RHpNa3ZicnpqYjA0cTNNY0ZqUFZGZG1wTnRNNkpER3hKUVgrcno1NUt6NTZF?=
 =?utf-8?B?Qk1FNzlINE16STI0SmlBVlBNRlNQQVlObHJSK0VKQVFnRDVKUUFIN0wwM2VW?=
 =?utf-8?B?ZVp0MGZQLzBXM1Y1NEpYTmgzV29tRUJ6M3ozaGpGSnEvWHFrdVJDdStweDJl?=
 =?utf-8?B?RktPQ0FLOHFGOVQrc1QyS0szdktrdzV6MUR3YkNkbDNydHgrVk4xcUlSdlI2?=
 =?utf-8?B?RXd0dnJ1N1gzNUliSzgrSGc3MHZCekxDdzNSY2JvczVuemRiYlhzdXp5L3Qy?=
 =?utf-8?B?aWRHVEpIaktNamluVGVWYVdMN3pVMFhjeVRkcEZRS0VLeENXdEtNVjNCUmI5?=
 =?utf-8?B?a1hHa0VjSDQwR0NHL3MzOVI1Qi9qRjduTnhvVUM2aCtnOXg1RCt1MGJVQmdU?=
 =?utf-8?B?UDNUMGVtWVZvaCsxN0hkQ2ExWXJTUk1OanJPNnV3ZzQ5UmpIVzZLRC9aRk5n?=
 =?utf-8?B?MHJMajFBMGNhN1BIT084RCtpTDlDSzIwamFlRjJ5dEV5VGdETVdLc3QySEsx?=
 =?utf-8?B?UnhWTk90WDJKRmpIK21KNjlscHZocGsxUitEcXJBZTRKWWZLWVphVDlsSWRw?=
 =?utf-8?B?RGZkbGhkTVBEc3pBbjNmVytWTkRTVllUdlBPcW5YWDNIN0ZqejZ1ak13NzFK?=
 =?utf-8?B?L3NRZXFnZUYwOGc0VHB1QnN5cHNPK2t5WTNFYVdvOXQwQ1FPdUp2ay9HdjAy?=
 =?utf-8?B?YVRJSTcvdmxISXd4K0FEUEZzRWkzMi9uSlVLUmwwNGE2TldNQzJkWFdLRjMv?=
 =?utf-8?B?aGMzUkZ3TkRMaUJqSjg2MTFFZURaRndqMWltQzdaNFo3MGpmWEdxUGNWQkI1?=
 =?utf-8?B?SXVSSFBTbDAwRG9icS85dGxSOEZTaktuMGRva3hGOGpvL0RMS29yVzZCRXgz?=
 =?utf-8?B?UjB1L3VvTFNHbkJVbVc2d1FDTGE0K2MxR3FEVC92SnNRc3hnVTVFc29Kbjdy?=
 =?utf-8?B?MjVBVjZpZ3lmcWcvangwa2VhZngyRTI2aUNMaS9GWCt3S2QxWXFGaVFmZFow?=
 =?utf-8?B?L0FtQjZHYmZSZC9YdkgyNFY3UWUrTGhLZEZ5RFZzYWp0bWlubkdvcVc5MVov?=
 =?utf-8?B?QS84VmVMSitaUnB6NEN1amcyeXFTci9OVWJVOGhaZHBjWUQ1TFZNWUtYMVND?=
 =?utf-8?B?cmJwdXRrT1lBSFdvc0VnNUtoS3ZpUHh3T29ZQ1pTSUJTMzg5cTVkT21WLyt2?=
 =?utf-8?B?dUEyQjdldzhpL216ZFdPS0dUdjBQRFlBcVRKZDhndC9HYTNPUlNVTXZOeGp3?=
 =?utf-8?Q?CnD7HPJn0dVnd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmljbDJtenZKOGc0c1lFdURUM1YvcWxQdEFLVjRlRFFCYUZzbllGK3hDSjkw?=
 =?utf-8?B?cUwrSEp0TWdIZzVlMHlWa2luNHJBYTY3emVQTkt4UlRRcjZhMXNpeVdydUhr?=
 =?utf-8?B?QVk5eXlDc1MzUW0veGV4SVFDdnRIbE1YdXpuQThRbVZYN0dvYU82S21CZmZW?=
 =?utf-8?B?dFRjMlRvTGZmOVlqekZZUXJPRGRBS2lZM3FBUCt6TzZtYnZud2dVZGk1ZkhC?=
 =?utf-8?B?VzBWNmxPZjRoMkNyb3lSUThsNFdaSjVtRUQ0QkNJbDZ5akZ6UWUxU3dwWEVR?=
 =?utf-8?B?cFoyVEhKY0lmYWZrV0VXY1hNdU9lK1BEeGYrekVtYWFEWGpORE95M2dLa0ZM?=
 =?utf-8?B?WFFFZ3kza25hZmpzbnBNRjd0dktBVTVtSFdmUm5udTRiekhNSFhwSmJaWXd3?=
 =?utf-8?B?bTRXUzlJR2dqQnc3cmJETnJ5VHR3d3dMcDZGbG8wa0VSbTVHYXVLZms3emFn?=
 =?utf-8?B?Ym5mSE13by9NNlVEQXdIMnVIdTZuaDZDTk5wNmcraXcwU0tUZmtHVTM5c2Qy?=
 =?utf-8?B?M1F1Y28vWTR1ZnU0dVA0ejdEbTRjZW5xQ0Jpb25mWm1wR1kvR0lYUmRONk9u?=
 =?utf-8?B?WWhpb0h5aE8zYm5Kb0ZvY0V6RndxUkJhMk1kdVFhWGZGN1ArRXhEUk5pcjdj?=
 =?utf-8?B?YmhVcTh4c2ZPUjd5UEJ3TEJpSG9zQUYyMnlRd2lzbEkyMXVYa2huWllsWmV3?=
 =?utf-8?B?bG1QbTBxdW1ET0NrN3NKMTh5cktjL2ZhMzR5ajBpVmJSTXQxMEkvcEVuYnRF?=
 =?utf-8?B?SEZ5Sk0xUVEzQVJETmRGL1pGMzVXZGd1V3VKNkVTTDNjYlIzQlJ5VnJGWlN1?=
 =?utf-8?B?NE91NE0xQ0lSL1hGTHBnbU0wYWdBdTNBc0RXNklSd3QxOGVkaWIvcUR1U2dx?=
 =?utf-8?B?cTcvUm53WXJ2NFYvdk9JZ2tQK0FkZ1k0c1NBaVpETWNYK0FMWUNkRjNkdUg0?=
 =?utf-8?B?WmR0cFc2VWYwc0dUU05hWGlaWkpSVkkycm55UndLYmsyQmJpakxQdFowM3Yw?=
 =?utf-8?B?Q3FETkVNMVA4ZUg4RUhxN013L0YxaHZHL0xQNFR3R01sV0h4TTN3MmhPSWx2?=
 =?utf-8?B?ZWY5RWx0cW5VMGdaSll5azZjQVowR2tWb1hSZ2FTTngySUY0eUViZlhkQW10?=
 =?utf-8?B?Y0ZNSFVTNk82ZmdCbUxQM2MzWUx2Y0lXWTZYOFFwU1ViUnA4bXZ2M1g4YzZy?=
 =?utf-8?B?aUdDS0VnRWZDZnZiVkZDb0h1VlMzTEsrNnZTQy9pYVJ6Q1BZYjdVRVdLYUJW?=
 =?utf-8?B?TnI3UFkreFd6SkNMeGw3WEtsWWlWMHppdlBLamVvRFhnaEZSd05DU0dORlFu?=
 =?utf-8?B?ek4rcUl4d0ZueXBrR0xLV3FuL3dqRDIydVIyWXVLRGxySmVoZWgrUSs0dGF1?=
 =?utf-8?B?TCtEa0JTQi82SVNJQjg5cjVtRVcra0RDaW5mQXd3Y2dmS3VhZUxlSGlUTWp4?=
 =?utf-8?B?a2w5MDJwZWhVcTBwSkliWUNmdTFtdGc5bXB2MTAxV1VqM1R4Wmw0MXZYNmdz?=
 =?utf-8?B?ak44SkNOaXJCaWdkZWtaeDhDR0tLODJoTDdtdHFpSDEwTnV4RGt4ZEtCQVlG?=
 =?utf-8?B?N2FFek0rcysrdFJYUXd0RzZEVkRRenVIazViLys1eWRMZXpWUkNwWllhWkYx?=
 =?utf-8?B?VE5ZbWlBdTVWMm1qRjRJOHd3eFBBY096U1plTmhEMjBpNnlwL0dlSm9QL1Va?=
 =?utf-8?B?SkRHcjRpWFdvRnQwanJWMjk2QW10Sm5ITGhROUllUTlEL3Z1UjRXRTMwR2E5?=
 =?utf-8?B?UEU2Qi90WHp0MzZYZlkvYS9rcDc3elJLOWhLamRoVGk3MFFGUXhsZVVVTnpU?=
 =?utf-8?B?Ykx5Ty9iRitqK3ROWU1BSDdrT2Jjbk94OEhZM2VSbmdycVp2U0w4MmpwZDEw?=
 =?utf-8?B?YUhpeEZjdURCdlFLYU1HKzdra2hYRTE5WHkzekFiNFkwbVFMS1FZcTVUdDNz?=
 =?utf-8?B?bFhiOVJCb20rdGYzbDRTZzJUNnJValZ1KytGc1JzWTd2VWNNTTBhV1g0cWsv?=
 =?utf-8?B?cDVsc3djdVV3czRTcFlKVjdROVlIWFE3d1NETUZoVEJQK29nYmpvdm1oODlF?=
 =?utf-8?B?S2Jvd0l5SHYxcERsZFFWUVhjREdyblJpbGNJQTZmQ3RLUWV3a0Z2S28yRUxs?=
 =?utf-8?Q?16GKWBXVL3xL1gcqAU15x18CN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a402bb14-9339-4dd1-c167-08dd5cfea0f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:31:25.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94A8NuFX6XydjDg+4wRVpHRhYyptwJw2gJnl6r+sr91f9GE1TRr+5cW799ElLrlM1jiRP9HD9/iRp8/sM8pWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474


On 2/28/25 11:58, James Morse wrote:
> is_mba_sc() is defined in core.c, but has no callers there. It does
> not access any architecture private structures.
>
> Move this to rdtgroup.c where the majority of callers are. This makes
> the move of the filesystem code to /fs/ cleaner.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua

