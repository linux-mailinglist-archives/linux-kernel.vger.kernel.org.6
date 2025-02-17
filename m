Return-Path: <linux-kernel+bounces-516963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0FA37A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EA83AD236
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A4514D433;
	Mon, 17 Feb 2025 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q2jTPxpP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A11854
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765267; cv=fail; b=eYQ8jdGm2YqY74gZj38qZHXc7iC386TLwwy/GO673EDrNn26r0VepERCdrvGyc8hE7oUJ7fh/n6502lLtQZ9a0zK+yEwoLi7/FKBJA2pNb471ni/v+RGjQ1gozTq+DF67m1evj1em9y5NsJOG3oyWM4tjGlrZDmFJ8jpHWsXBwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765267; c=relaxed/simple;
	bh=MpAq+f2dYjszepuBZOWPIEPWVNtaGr2gqwS5tkpIGks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gfM8GIpXlBlHVJ+w65NRW6LrvqJI7jph1ZMLp2VoGgqlBODkgZKxPIU7X3h22QFnwSNKPozldg3xtDZyPfAR4Dr9rNxgR8htZqv9xMCmWp65wjzGL10P5ofSJ+W1gNGElnnKd1IgkOXkxKWYOLwAkLpjAqDEe6ynTQzeLER1YMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q2jTPxpP; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1f4lisxl/a5S9rzBIBxlyp5c3ZXgwLQzbn0/pPhmAoZzcxqsif0tn9L7Ws6h4NM9whSr8aiW0jwC1C1e9T0ZODHKmaub0ZqtkbxQ/7mcsfKfAOWcL1TQ7igEDZeKiJnekOmUZSo0/qdqLvry1ufpqmr/eTayc1i2CI28cGOycrHPDs1PXcJDZiuHdZL1aCTEemqIhQ/AOjoGUdzRztHg3ZdJIvZA2KW2Co4W8YnGCgGeo/mxQtpr8/Qk0jm0YNm0CBFpoa/PTyd4DSAo9AEZEwBlK82Cne61hWj0Hlomb28Kw6xMM6eBU89qC4qKjG94O7e2wWO5ZR65MsXRDu2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGqRn0PStNOcpbpkpOJan47taRbpeQwE1ILdiNwONXM=;
 b=m36NZqxnBInwsXStxBFN64E/7WzoZSE/2Qm0QBK8RFlVbqUfanJRfhA2dzvWKesDdLuxUbEyG50t5X7hxInUVbErVAFqWJi7xaEjCetH0bhE7MPIGRzCCMVTG2foBf/KYhbkHONfUbjSI0pLWRp5ZJF36+BSwxKXEOGX37ezszfDpIUoi7zNjTmMDJwDTY/VVNod7YxgLwIEKmPQJ9M1mDW9QUpBXhCxnPxgQyMKXAwtOcogxfceNb64OpTqBATIqh0c6zT3/PzBD9KCIyD6oYm+qZ9LYrylYRdgv6/1vO6uU9rb6FUdVVNs6SuiHuOPUAbmQCDzjHmov4BYmv2iMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGqRn0PStNOcpbpkpOJan47taRbpeQwE1ILdiNwONXM=;
 b=q2jTPxpPjUwtvAs9QQOjXU0QkptEj4VOtlBdPJC2nDMh/FERf964nt2mhZntB1Bs9GYXtuUltRa+FCuGcjHLvGmGjSFe2QK0D/TIiP4HAijm339Uzw7+HNa2MRQtBUkyM8AFnNP+J6N+hgPPg+qI5La6LryHvlEXY4ktgiGGgqs=
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 04:07:42 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::66) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.9 via Frontend Transport; Mon,
 17 Feb 2025 04:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 04:07:41 +0000
Received: from [10.136.42.242] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Feb
 2025 22:07:37 -0600
Message-ID: <1272db25-454e-48ff-9acf-6f31ab183273@amd.com>
Date: Mon, 17 Feb 2025 09:37:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/eevdf: Force propagating min_slice of cfs_rq
 when {en,de}queue tasks
To: Tianchen Ding <dtcccc@linux.alibaba.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20250211063659.7180-1-dtcccc@linux.alibaba.com>
 <610e209d-5c12-44d5-898c-f18dffbc2062@amd.com>
 <958a085d-95bf-490f-9987-b269f80635b5@linux.alibaba.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <958a085d-95bf-490f-9987-b269f80635b5@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dc91fd-82bb-49bf-9479-08dd4f089fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WktyUGRUcVFiWExEWlBnam1QTzlSYzRVZ1NZaDB0S2N0WjBFeDVPRE9RVjY4?=
 =?utf-8?B?aDVYbGNlNm5wOWFFTkFUc01NcGo0clN6YnJsQ29NUXNYYzVud25HeXRZSGlt?=
 =?utf-8?B?Wmc4SnJVd0RnZkpGOTFDUGJkZlFxQ0R1K2RnL0FMQm5lQVUxWEZhL3lBQ0lZ?=
 =?utf-8?B?dndmTVRITXFEREdRa3YxRkgxdm9haFAzWlpaWlhKaFVlSTFSVGpwMTA3c2E4?=
 =?utf-8?B?S2VNSUw0VkEvTjkwa3RnZzdNSmF5MnQyV0FnTUdFT2pXNGlpZng3N3RVWHNY?=
 =?utf-8?B?ODhaSXlZZjF2TjArRVBvazAvSWt0ZTlpcnI0OU9IakV1d2gvYlFqblQ4akY4?=
 =?utf-8?B?L0l6aXpmS0kwUGdZOVBZNXBseWZGUnh0SVczYXQwVVpvamVCYWlQcWlCR0Nj?=
 =?utf-8?B?NkJsUXYwTzZHT3hTZHppRW5DS09sejBvWUNQOHJRTU4zNU14eVRSV29OcTN5?=
 =?utf-8?B?K2VmMnhVUG9sdE52MTlKM3lSRFczMnpXMUNmVzZMaERxS1lPa21od2hpRVhH?=
 =?utf-8?B?Uk5tZGZDajdEMnIvdnNWU0NETHRnMVdlSW90eGl5a1ZrV0NzUldZZDlmN2Nh?=
 =?utf-8?B?Ty81R1o1UDhoT0NjMVJ5cHBvYWxpVXJPMkV3TXZNKzlxWVRQSmIzaGdzbDM0?=
 =?utf-8?B?M1ROcmFzdGxiZTk1YzloMXphMnZWbEUxcUVpbDRhTEhpQWoxRnRCRStLb1R5?=
 =?utf-8?B?eUNtdWo2cHY0Y1NvSGxPTDE5TUNES0NXUkRWa3gzNmJ6WC9CeEkrNEVlSW1z?=
 =?utf-8?B?blBmSXlxbkJVblZ1Q1RyUDdBUDYrQ3dKZ1BVZmtiN3B1QUxITndiS3haYXB4?=
 =?utf-8?B?MVZUdStUaXBRRmUyL2NYQVZvSlRjWE9kU1JiMng4NTNVRmErSTY4SHd5dHc0?=
 =?utf-8?B?T2hsR3o3L0U4UmtZa0xvYUpnSmpNWk43a1k5WjJEMHBQNzg0bm9qc1NualNi?=
 =?utf-8?B?TG00ZnlLM3RKV0pzeWZ4VWRyTVRJbXBQZ2pJajlIUWsrNk1FeTEzZ0hiQUtx?=
 =?utf-8?B?eEZnR2hVemNLN3A4RzkrMUVtRjZlQXdXM0FPeDJ6Q3JxSmF0MExBUkpKUkE2?=
 =?utf-8?B?c3NKNk45d29aQnFpYmVxSkZzT1JhcmZPc1c3NDA0OTY0eTVxc1V0aFMvZVFK?=
 =?utf-8?B?OHlyYjV1Wm9JbStpMGx4QmN3OHZoNFpoRUU4QUJvczU3SXRKVnJheXdNSnQ5?=
 =?utf-8?B?dWdGNGwxejdLT2FtbWp2UGdKZmNUeXZxZURFUU9TZndZMVBEdlQyUWU1UEtF?=
 =?utf-8?B?SkxrYnVkKzQxUjMvVWlZL25LQWRKUDVBeHlaa2k2Mjd4MVFXT3I1cEhzVnN4?=
 =?utf-8?B?bkRRYXcwUWt5QlkvR29QWVZrUCtFM1VteEE5YkRERWFOcHJ1czVuNVh4LzVB?=
 =?utf-8?B?TFNLbndna2hvOTFudzNraW5xcnN5aThObDNwVElVSDZyNHdySCt0d1pCT3g5?=
 =?utf-8?B?aDBuYU5UUVZxU2RUdTNWMWEwWW53eWZILzVKTWFqemJJN0NzOUxrMGZ6T2Nu?=
 =?utf-8?B?bm5iakRzNk1UREtyYkdFL2FTZWxoQThqMEZydjlscFQ4VG9CUVcvMS9KbFhH?=
 =?utf-8?B?VXY3L0MySWc2TE90UFdRbnhYa3lacHE0cm5XYjFvSHJOdnNrWXFwNTNyK3F0?=
 =?utf-8?B?eW4zdUxncEx1TTc3L280YzNXVUZJR0h5N0ljMS9mR3FJQkhORE1HZGw3R0lW?=
 =?utf-8?B?Zy96cVFYQjdWWXJLWkpkRUx0UDNYa3pVTzBRbytrOVpoVU1Bc0Y4SkJ5L3pL?=
 =?utf-8?B?NkppV2tVMHpZM05XLy96RlVHMmxUQkE1WEVaRmZWcTh5OFkvWkRYdWVqUEpS?=
 =?utf-8?B?MlNUbHAvb1hFdjJWVXZXVVlFVDlUSDhia29zTk1VNmdmUUtJWk1BM3RvcUJR?=
 =?utf-8?B?dlhlNHRiNERDKzd5bUhkdG50WlI4MU55U1l1NWF2cjZYbDZwdlJlOVRBSzdy?=
 =?utf-8?B?NiszS25QSjBzeDFDUWZJMEw5UnF5R3hpeklycnQrc0lyZ1ZBZi9iM2xoTlVx?=
 =?utf-8?Q?BmDYbPObSOas3KQVNHuVj6PxsKKMyY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 04:07:41.2367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc91fd-82bb-49bf-9479-08dd4f089fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

Hello Tianchen,

On 2/17/2025 8:23 AM, Tianchen Ding wrote:
> 
> Since the patch has been accepted, I'm not sure whether I should send a
> next version. The current version does introduce an extra function call
> when se->slice == slice, but the loop will run only once and exit because
> RBCOMPUTE() will return true. So maybe the cost is insignificant?


Yup the cost is likely insignificant! I have no strong feelings and since
this has landed, I don't think there is a need to micro optimize this.

-- 
Thanks and Regards,
Prateek


