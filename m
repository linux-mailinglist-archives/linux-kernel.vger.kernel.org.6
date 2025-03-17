Return-Path: <linux-kernel+bounces-565118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9BA6614F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC82319A003E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59B2040BE;
	Mon, 17 Mar 2025 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2gOS7in"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0552046BB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249477; cv=fail; b=AMqV4k70QZIzD5g54oWXdnSiC4hGLKEcxZ3VP/PrEZDnfz2SP7r7PBOLuF/ubcYmz3QASOgSsZIsP9parqM8O110hct8QNavAS9piZIu0IzxzCZ9wsSGLieRBbeU7o1np9tY+uxqhiP1RGMV3PlRf4aon4unzQnSzMkZSn9TIvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249477; c=relaxed/simple;
	bh=O1DDoe85wC20e+8d1kVxt8SLq19Xy8DssIARWlIOdSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUTOJFk0WrobSnscnYnDnSwdKzUhr3FVmaDDc3FbzQ22XABNIAZoQDUwwQQxUeMpDAUqOTDr1pB+XNqSlRoZve/S5E7Mu00Dgt4A5y5Sa65/j12j1jQCTNdPHR1bG+ldByzYMY6ipq/DcF1yQPm4hCMj0RfJqM3Nj+p53cMZrGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2gOS7in; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2Wwm29t5lbZqk5EaGVGamMPv/RoI1H6nuGIJHmYP21gZv6F6uAQAwmuaStWgM2N/S9CYPBQ4toRxL3Bti3pLKZ7Chd/DdkkUkwNGBWAL0bIWbQNeY/NnYd0y19yz2+GESc2jiCkhtvVvLXpCVD1vPDQhxv4avdCYeS313tcqJsTt5gS1d+Xqre78Hz99/P8o575a+wnu9LduWEO9WXbenJROwoo9GaRETePsfIdtgh20ucF8STZAWF8uS3KJrVNaHjW1+g/4bJRh/iCVB8iopG7fugszC5nHsDyHtQ1szfSZzyVvsUJ0vaAfTlp17v/NkbvZ1agMTn4B+gNPobA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc2IvPy4PGburOP81fpO3/pNOPP6ees/rA941Ib0ro4=;
 b=ZTrlmNRge3d6VOI1dRzBo0CLDbKY0+lq4q6RJMLC7fpwzbKmirWLCUh9fN6cQvKgCnSrebqvgKNzEsELvshSRMgbUBqqHbZF3bv9ZSA4SdvMIrBX64wv12Zv2FzCn8ux9COLTeDUaeSCKxwQrfUNZQpl2RbjbbbNS7Luv60i3ISBCdn1bfcTQyhmG+T3uhCwSrQ804QAMwlD3HDkNgVlRXrGJSrdoZJI23G15/o2KZL216GdW4UP2L+oGYX6vL8XkglvgnWpYX1hwSMxk/9IPLtvwtX5nXbrmyX4VrjLkX35YF2/Zad0zNJEt4efuqN1TMnnAM5P5sal72jYoqaswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc2IvPy4PGburOP81fpO3/pNOPP6ees/rA941Ib0ro4=;
 b=H2gOS7inRBjbr2Ow58uFyJkpPxebKIHlcyzBJs7F8i772vJRPKvzP3Cb+/u9+QKY21612wnNcgRRl5kimVFugR6kF6AWCXOXmk4TIVleetJ5wcxLDTHp2vyGpF9KKb1NQExKkdEDo4pDsUqvR33q/PTtgxw1Sxxds/TFTepMXuqJQRAvtrN+eX8Ih3kuXrO5DG3smybxFYz3RUuUdI96OVeUtNpebb0eYUDvV1BudAB0VpDxRnFnbb5caH4hGMdhK2TYXvQOXjbybZmrBUByyf+ZW2+FE8E+PNg1uSJDWo+UBV8H6OkJBhSjv1eOOIcgHoo/+wjav3MepbDshwQKBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:11:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:11:13 +0000
Message-ID: <d9bbbf0c-64ad-4304-aca9-ea48febba402@nvidia.com>
Date: Mon, 17 Mar 2025 23:11:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org> <Z9hcUSp6P72wT5ig@gpd3>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9hcUSp6P72wT5ig@gpd3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c547b4-0d9f-404a-c766-08dd65a0a161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THRubVpmSGtJOWFZZWpHaWNxV1FCSUxrSVVrckhkUERwUnc1SFdrV3dUR2lV?=
 =?utf-8?B?dll2ejlucUZNanhIMFg5Sm4wQm9GTVhVZ0JtUU1xWXBzWVV0MHdmSkpEcExw?=
 =?utf-8?B?cXB3MGZnZ2p1T0ovSlRaekQ1WXZEb3ZIWUJidndKVGhyUmFSRDB0bkt3d0hC?=
 =?utf-8?B?VlRwNkFyOTJRSnQyN0hqVm5xNkZTRDZPRFJYL2Q2aDJzTU9HQUhHQThLMDVp?=
 =?utf-8?B?ZUVFQzZsWndvRERxQmRha0YyRGNYbU1YOFBKSTFoNFdKRGlFNnp2T21ZUDk5?=
 =?utf-8?B?T2gvUXR2VnVZSC9zcFJnSjJZY1FDNHV0UHcvaWJxUEtFNGhEQ24xeTZPd0tL?=
 =?utf-8?B?Nklzd2tyWWNkZVMxdjNPZysyY3laUWJkQmZqTjFkRFJPcHY4Y2w2ZjJEU3Bj?=
 =?utf-8?B?aVltUHNSaThzQ0dCbnVkbHlGLzhtTWlmUFFRTzc4ZHZMTDdhWktkTmNaeFZN?=
 =?utf-8?B?clFiV0ZybFl3bjJybzNhR3czQzB6SHhzYVQ4YzNXU1B4M05seUN2QXhzamxT?=
 =?utf-8?B?VDJkU3FBQzhWbWxEbjFZV0N4MzE5SUFCVlR6RlB2djNuRHJDa2xqS25BZWNC?=
 =?utf-8?B?YkQ2RFhkOWVCakc5MzMzdG1LSFhVUGRMRlJaaFRjQ0RqOWN6bVBSM0FjR3Zm?=
 =?utf-8?B?ai8yWFdPZGRhcWliclM3MEw1MEgwT0t4SXNVVWh5bitCdkFlOUZGb3RacGxH?=
 =?utf-8?B?blFPZjYrWWNFMDVCZ2pzTUNuNEtaV0JIN1lQSlQzZHJpZzNtc0lEc0dVb2ZF?=
 =?utf-8?B?SVJ6bFQzdHpMWUN3TUFEaHhyZFlQTy9Cd29JOVJ3ci9yMTd3K0NxYU9yQXFH?=
 =?utf-8?B?NXQ2NUM0MUxhdlJhV29FVkRraVpIdmorYUFMUW42MEpQeExnT3Y2QmU2NHBG?=
 =?utf-8?B?U2xLODJnUkpoYmlDbGUxOW1xK2haYVlwNEtHTUNmZlRjcVZlVkE3NEIzTlVK?=
 =?utf-8?B?c0srd2cxQzFqdVc3ZWdieVJBem91dS85L1J3aC9sa28wU1pWcDJicTA3aDlD?=
 =?utf-8?B?eDdiZnVlN0JJRXU5TnBwUFFpM09iQ0hDNWt4V05Oc2kxMlNRcytyb2QxQ055?=
 =?utf-8?B?RStDbndQNHlUM2xCSEVuMkxoTlNtOHRPNW5pMzE2YW95YTNQb2lCY3pnZ2Vh?=
 =?utf-8?B?SzQxN3RqQWVYOU1nOFFGcjVlK3A3Rm40VWlhRTF6YWxKOEQ3cTR2WnFpVVRU?=
 =?utf-8?B?VjhESzhhdkUwZ3hNNFIwVng4MDAxY3FYWVZNdkdqNnl2SjBJeW45SFMyanNs?=
 =?utf-8?B?cXJJa2NXTTZiMGJFWGowY1ZGbnJXYTlhY2M4MS9QNG1XcG5sazJZTjhOTWhz?=
 =?utf-8?B?TVNubWNNYzk3ZDRMRnFWa3JMdU00cTY2Ly9YNnFsaDRCUHRjbzVaSzZqUzd1?=
 =?utf-8?B?Y0FZZ3ZuRzRVZE91YnE5TXNrVGpsWHZNRFRlYjNkSUxKQXlmNUNiUHNCb2NY?=
 =?utf-8?B?RUFxWElvbWtDc001NDJERFB3anFWY2RvTXo3YUZyVFZ0ajYycTRjekppRnA4?=
 =?utf-8?B?TWV6TXI2L2RoQitONjBUTlhiaFRXTFMxdlJhb0k1Y01CWDQxUkxEa0VwNlJN?=
 =?utf-8?B?ZWxNTXFEVEdxcTJnYnlDbXc3dTdPTGVsQnEydjFTK015OE85M0xnNmFpQ1hV?=
 =?utf-8?B?dldDR2VUMkdTbEFpVVdxYkU5c0JBYXRHMmdDVk1FZ0MvRkUyWFpJZG5lSjQ2?=
 =?utf-8?B?Y1ZDNys2cEwrVXFMaUJ1VVZkbTNaR1VRaFh1cFpKMExZRWdwdXo1ZFhsNjRU?=
 =?utf-8?B?cHZRQWZsZ1VYZWJTMEVPMDhEUzRwRXVaSU96Ulp0NFE4WC9DQ2lFTDk5cm5u?=
 =?utf-8?B?NXJOelZiT2Jvc2Fnd29CcDRrZXI5MG1QWkNxYUxQNmlMS3MzWm1ZNENZLzJr?=
 =?utf-8?Q?0aiEwFgxPzUBz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODBIRGdEcGtYMUNUcE80d1puN3NQWWdqeVpCd2Q2bS91eEIvR25VLzZBeEhB?=
 =?utf-8?B?c1haSG5UcFlBeGV6NHZjUEg4L3kxVDNKc24vYlFRZ2poTXoycW5wMHZzTlRU?=
 =?utf-8?B?b3FISFFaUDFoaitwdXhXd1lZS1VWUzlxZStHZkFzK2Jzd2dJY0lBWm9NTXE4?=
 =?utf-8?B?U3JMZGdualA3N3BRRVo1VkRkMW1HQnoxbXFNcG90Y0RBT0FHZHNJajdzZ0Qy?=
 =?utf-8?B?c1NOeldRTWRzZVZYVnlwb1J3L2R2Q2hKWEQxckdaWUlORVd2S1I2K29DZ0xI?=
 =?utf-8?B?OWc1TmNUNkg1b2xaU013RVhCMFUrV1ZRYzRDSE1XTFZKUThMUE9pQ2Rsd0xn?=
 =?utf-8?B?aVhJeC92Q29adFNaaVNtRExORld1ZjlvQWU0SU9PL0hEdGdGS3pMeG4vTzE3?=
 =?utf-8?B?OWtlRytRdTNzUzh6Vk53SWg2dVVxVW5saHpBUmdVNUx0MldkS0ZqK0p6dFFR?=
 =?utf-8?B?cExMMVlsMkYydzZ3L01uUTJZMjZJelE3Z25OY3hQVHRqd2JlbnlDdDRjZStN?=
 =?utf-8?B?ZytLQkcwSnV2bTVlNXB5MmE1NWlUSVp5Yks4L0FVSER4M0VOOEtQaGtDOEE4?=
 =?utf-8?B?VWY2ZDQ2WHF5WnUrVkErS1pTL1d0cEwwd2tmZ1hnQ2lFMzZ3cm9iZHVKaDll?=
 =?utf-8?B?dUxnN3BmblNIaXNaeHRKSTJ1dW9pbXcrd3NQNGM3UjNBRHdmbU9IZWN0SWRJ?=
 =?utf-8?B?ajczTVF6ajFQZ05veXVqVVV5bXltUHpOYkJsRC9sVEorNGJCcWhqUEFmNkVw?=
 =?utf-8?B?ZDdvWTZuU1l3ZklsRGtPdWxMdGVJS2F5by8wMDJRMjFZQ0pvTFMwVm1XY2tW?=
 =?utf-8?B?QW1aOFp4TzJuYU1OMFRiWXdFbUNvNEFKVVpiR2dNWUdubkFMWEhYQkFJcHNh?=
 =?utf-8?B?a2JiOS81MDZ3Y3FPVjNDMFhpZmo1VkVxallScmROZ0M5bWdON3lhRDR5eEJI?=
 =?utf-8?B?aFBzeVFwaG5mVHQ3NXZ0NUJwU2RSMEE2QjJWa1M4Sk4yZHBlaUI2dlFpM0Q1?=
 =?utf-8?B?ZEZqaERvcG4xM1pYc3lDVkw0RlFaZmI1L1Rnai9IbnJlanJWT1FrZm50RUJq?=
 =?utf-8?B?YnhMUnNoSURjT0p5RnErQkpENzFOOEpOSTJCaWVFVzNuL2tLZ3VXYzNFUEdS?=
 =?utf-8?B?cW9CSTg4enJNYUtJcEx6cWE0VStGSSttNXlUWDVaSjBqM0ZleXN6MzZzYkU4?=
 =?utf-8?B?RDUxcVAyK1BCOUcwWCt2bDloUHpxV0MzM3lRc0JIZHNOdnVkc1dvbUtEU2tK?=
 =?utf-8?B?NlBzdkpTRTJUelROVWFWdVp3SDdMR1RRYzVwQXV0MGQ2R0FGNG1WbGxreUYy?=
 =?utf-8?B?bmJWQ3VJOHdpTWtjZmd3ZDdVbUFHaEJuTk5kSWlsQkZuZElVQ0J4c1cwcGw2?=
 =?utf-8?B?K2NFYWNZS1lGNE9MS1Z2c1pMcDBoMFlscmVma0l2bVQ0aHNMcExWSUd4cVAw?=
 =?utf-8?B?NzZLZGhKbE9oWXBaZWdTdVpubmJoWWlHRS9FU3A0cmJwRU9mSmFmRzFFWFA2?=
 =?utf-8?B?WEdqMnJKM1QrRm5pZm9YMlY1NHRIZFMrbnpLRUlvNXgyaUVmK3F3Qk8rUWNN?=
 =?utf-8?B?OGFTSVk4MUY0NWNKT29uOUxCUlIxRmZINThmL1RMdS9Fd1N2Tm1heUdLWnJr?=
 =?utf-8?B?ZW5FYk4vUDVucjc1b2VJYzk0ZDNVSXQ2WGtqVTlhYVZYclNEelpEWW5VekhD?=
 =?utf-8?B?NHVLQzJVdDRGeW0ydm45d0NacjlXUHF2b3Y4N2RuVndXbEpFMythRFNOZGE3?=
 =?utf-8?B?a2JZS25JRzRPQUZCNTAwZStnZmlQbW1ZbjkyTU84STRFd0VLcGtsNmZTWWs0?=
 =?utf-8?B?VlpPeExqWUFqVFNNVnB0eXY5bFJEd0MxWWdVbmdXNDk0ZVhkeWdqZ1c5eHox?=
 =?utf-8?B?QWgvbURvZnJ0Zmp1T0U2bXk3bW1abm5maFVGWENxT1RVWExDS1AwS0dPaFFX?=
 =?utf-8?B?QUplU2FhczFpdVA0Z0NmbXpWdEgrS3BycGk3R3lMREZVTW9QcXJObXlBQkpo?=
 =?utf-8?B?MnA1OVovMGxSY1VvWDZWVHl3WVppdUpwdGwyOUgwa2NGT25Va00yRVpOeFpG?=
 =?utf-8?B?bXZvU1ZUYUpLekl1T3oyNThtQXNaS0NzVk9hYUdtZnRsS0ZZUml1aUo0Rm04?=
 =?utf-8?Q?Our836DIUTfVgdbSByVzR2mzU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c547b4-0d9f-404a-c766-08dd65a0a161
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:11:13.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oCQauJQDL7N9UXcSG+/Dx9vXOLQFwkgbRGTs6zq1sNsycJiIWWttQ4vdcJLN0z/wdsdmVN+nhtBD5EHVBm5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427



On 3/17/2025 6:30 PM, Andrea Righi wrote:
> On Mon, Mar 17, 2025 at 07:08:15AM -1000, Tejun Heo wrote:
>> Hello, Joel.
>>
>> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
>>> Consider that the previous CPU is cache affined to the waker's CPU and
>>> is idle. Currently, scx's default select function only selects the
>>> previous CPU in this case if WF_SYNC request is also made to wakeup on the
>>> waker's CPU.
>>>
>>> This means, without WF_SYNC, the previous CPU being cache affined to the
>>> waker and is idle is not considered. This seems extreme. WF_SYNC is not
>>> normally passed to the wakeup path outside of some IPC drivers but it is
>>> very possible that the task is cache hot on previous CPU and shares
>>> cache with the waker CPU. Lets avoid too many migrations and select the
>>> previous CPU in such cases.
>> Hmm.. if !WF_SYNC:
>>
>> 1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
>>    core in widening scopes.
>>
>> 2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
>>    idle CPU in widening scopes.
>>
>> So, it is considering prev_cpu, right? I think it's preferring idle core a
>> bit too much - it probably doesn't make sense to cross the NUMA boundary if
>> there is an idle CPU in this node, at least.
>
> Yeah, we should probably be a bit more conservative by default and avoid
> jumping across nodes if there are still idle CPUs within the node.
>

Agreed. So maybe we check for fully idle cores *within the node* first, before
preferring idle SMTs *within the node* ? And then, as next step go looking at
other nodes. Would that be a reasonable middle ground?

> With the new scx_bpf_select_cpu_and() API [1] it'll be easier to enforce
> that while still using the built-in idle policy (since we can specify idle
> flags), but that doesn't preclude adjusting the default policy anyway, if
> it makes more sense.

Aren't you deprecating the usage of the default select function? If we are going
to be adjusting its behavior like my patch is doing, then we should probably not
also deprecate it.

thanks,

 - Joel


