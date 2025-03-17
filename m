Return-Path: <linux-kernel+bounces-564242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F9A6511E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FD4175073
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37523F434;
	Mon, 17 Mar 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZjA25+k"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488D23F427
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218186; cv=fail; b=bjG0FTKKdMYe3baGk8DeGhlaKho3bmewmH9xt3Aj3W2SjMcAkAK3gaTkkPbs8foYpM7qGG/UZomH1C43Ph8ZBHx3vqhoWF57hLGdcoHFFrzIMijgV43VYtmvLTorm8IJ4KnzHmB0cjBLb25NJqkwTeBHgqI/7B1ro8hNvPfworg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218186; c=relaxed/simple;
	bh=t4x0+EOES1Mkuecf0RSZaeXNvhzfe3yfjs7jOdWkzX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsmfV5Ru1aZQqBWL33NSr81ztgfIuECu91EqkU91Vndf30HqYO3S9T3m77r73r88VRTXEtz85yNfDZASU8SajypAiTi85PpBpr6Tf/xaG9gX129zYDF0w4XDWyR9LchYInYU1SZyzbeQd8in8i5ATd0wrdmHoUlN0lpmySsvspY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZjA25+k; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N56xUKl3ZNQrV4KL8XdwXyUHPsF6/7jZ3Z/6alQ0fKBx6G0AB/i1X1QnWkxgYwGzKite61SeGLRdDPmgZfg6xvWmZKqmPvSpRltSERtCPoD7A+yiUXIaPS8qHxXEfU7TtDxLNVNMlv+S4ARqcK2W2mJaAwLnD8icvJdhLkoDuqRvJsFasDtiW/WUPDlP4zLy664PbkD8aMiF8kIhcwTSFmAlEsDKgdHTTKTHdZFoEGF1PLYEvmaCu7FEg9UyFR5SOKkLWm+VFBOJkFyG8Exx8McUd+KdtV/LmUdnKlU0BjZvelcaImKkcrSVJRIo/GKi63wMTTpiSt3SSP2vj3g+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnHRvmNXn8ONejKAvyoVGkFFbfQOCv+fpJdzP3CxcME=;
 b=O9ycPwGeRoBEh4w2nkEjYp+KSmT+sU5rnV36FtuR8Bg3N2pma3tRPo4c19dRPz86gJPurD+/mdlDYejVNh4og8A/GDJUHwrZ9F3geOVT0fC8Cpod53l9kmU9guNptkVk2h2AuU5nXqLSbQfAkUlqyzOdo/zzjErcwl6b2B+s3A8+dhTtpjTLbW4jgL3zEaiOO5d2sY5zrZIIS6lhFl/4iuOrL2uZ5I5DpwIaUWVTwf2kE5SUlR23Ri15+q6K0xxf9yP8hJ1xjotgjdkOtYytYBWun1h89ygjW7IgmelVObEOHeo085dKpouLOQFhmDhgTpt0PZkdU/U8dyFpwMeTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnHRvmNXn8ONejKAvyoVGkFFbfQOCv+fpJdzP3CxcME=;
 b=0ZjA25+kKBrCviCk3dWGT50aUesLvBntrxDT7DgDWXCI6ELkqg9+Tq5EwU5ML47nYpPy4/MCnEROnEGEZN++1IpBAA7NVCq4Lsq3kL3w+LIwpIpcIVzzQVh/Pvci5XQtpUkw924uiNpPodkDg65DExHpV/fDtHDg3xtbVtqRNFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:29:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:29:42 +0000
Message-ID: <28663df2-31f2-4726-9dad-a78e1b19afc9@amd.com>
Date: Mon, 17 Mar 2025 18:59:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Check data address for IBS software filter
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Matteo Rizzo <matteorizzo@google.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250317081058.1794729-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250317081058.1794729-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d16c1d3-168f-4450-c9ec-08dd6557c611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L09JNXpEWGRQZkwwbGlJUUxQdU16aVJ5ZnhXN3Y4UU1wUUxDOHZYZml4dnY0?=
 =?utf-8?B?eUM1VEE3U1FRa2dENzM0czRJVEQ3YjljbDZRVXVLWnBXdE1JejZVbG52UnpG?=
 =?utf-8?B?Y2p1aDVNaDNpb1ZjTEROYUZwaG9MNlFhKzNMVHBTOEhHK2tYcGJ5SzVGNEV3?=
 =?utf-8?B?TnR0UGZkanI0citXZHBPRWVrV3gwWldSdllEUDN4YzZvRUE2VUhGK0hJSTlR?=
 =?utf-8?B?M3ZsVGpoWUJWTTE3aDdoT0pBMUp1eis3K0pNV2wxZWJPTHRGL29ud2gwQm1n?=
 =?utf-8?B?b2FYeW56SWNUeTV6QU9LaEtGWGhndXpMUWttdUZEeWxGa042dFR2cDR6MHFV?=
 =?utf-8?B?MENvRXpCZGgwRGdnMllCQm5oaWtmS2ptNWpQbUhUWlBGME95dDl2THRuMHZJ?=
 =?utf-8?B?VnU0Sk9oWklyaCsvWkd0cGZ6a1BIbkJER1k5ZlpnMVppTkJZUGppRVA5YVZK?=
 =?utf-8?B?QmFqVUNtSysyQUtPSTJBR29LL3hIMHN0bXpVOVdNeVgrdWVkblBQbHAyOGU5?=
 =?utf-8?B?ME1GbThNTmVWQWxBT3ZkSWVlNTNaemMvS0ZhREJuSUNFRE03VWgrV3VZbEVR?=
 =?utf-8?B?YVFsZXpVVHRORUxEYzlzZVpueTI2TWd3Q2g5L2RwYVlMOGYvY1FGV2d5T284?=
 =?utf-8?B?anpGa2hpN3lkU1RmcENGU00wWU9YSFo2dlpxc0llWXBjRSs1S3pIVGljcGVQ?=
 =?utf-8?B?MlpJdHNzY0hhWndUY0UxNCtqMGlaTlRwVDNwT05ZRkZkYzZCZnlKNEdldjNX?=
 =?utf-8?B?Qi9qbEFQV1JMU1g4cWF4VEg1TDEvVjNkMXZxTGE1QWJ5NFZaWlFQWE1JdWkz?=
 =?utf-8?B?c0NTK2ZTYlRxejNiV0VNYWh3Qzh1REx1U0N3UGRlelg0b25McW1BblBkQnJX?=
 =?utf-8?B?bnhzQisrZWxzUDdEZkYrQkNPV0ZEZ1hXdXQ0VjZHVXBONkdtRTQrNFFsQ0pS?=
 =?utf-8?B?TjVhcWJmaUpITWFhY3lESU5VY09McFN1bVNxSllzbTIrUzY5U1IzRElJdE12?=
 =?utf-8?B?cGlHUkxxUFVuVnk5enhlSXFsaEFMM285dWZCQit6YXRZYUVpWEszT2F2VGJV?=
 =?utf-8?B?L0g5MmlxVXdpNTFYVm9mV2Rmc2NwdkI2dVQvQURpMzEweWRFek1FMG1QSXpQ?=
 =?utf-8?B?VWMySWY4Ym1oZGJrTXpqZXB3RmNhSk81d1ozS0NqYlFLN0g3UDcyb2pwNFZV?=
 =?utf-8?B?QmFoSXg3UzM1b1ZsRTB0ekZXcUhsK3RiRnZmaXYvNm5mbkFNdmk2NmFCcU9p?=
 =?utf-8?B?UmxldkxtUEMyQzJMK3JxTzhZZ1FPNVV0OFFXczgrOWxHUmZHSzZ2bytoMEhM?=
 =?utf-8?B?c3hIMnV0VVJVQ3JSWmRCU2lKS25aQXNmQ3VrbTk0dUR4RHNYcVNRV2dJSXcv?=
 =?utf-8?B?TktsL1diZVE5MzlYbzFqbVBDYmIyTDg0RXhuUVFoQVRJMnhXSVRhaUVHTTM3?=
 =?utf-8?B?SDUxNDNYdWxvSTNyWW1iU2VrNCsvcG1BOVRRYVZEN3g3NUYyODBCWWh5UVdp?=
 =?utf-8?B?ZTZNUVVnMDZGUThrN05NeGh3VXoyOHdzK2NNbnVyNTVhYkpCaFhoYkxqWWxL?=
 =?utf-8?B?K3BjYi9hQlJTNzF5MkVNQmVKN3M0d1FYWHZiT1dzSWt0eTdlUU1VZmN6M2pC?=
 =?utf-8?B?bEprZjZUbEtBRGpuQ1NGQVBmbmFnNjVVaUR0U3ZVRlZ2Z0VGM3FUWkY0N1c2?=
 =?utf-8?B?cEtaaGZWbWVheElwNEsyVmNKSTJZQlBOc2dZWjlnUm1vTE0zVWp2b3JOdWxw?=
 =?utf-8?B?ZXlnRFdjY0t1Ny9aOGRCSHpUWGdkQ24xMkdMSDh1RXBIRG8xbnM3M3pMODhX?=
 =?utf-8?B?enNrekp3dWc3MjlCN2xXVm9aUk5xQnVocXZUV1lKUmM5eElJaFRkRlVmMHNq?=
 =?utf-8?Q?2ctu6SSHfUMg9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1qY09aL3dRL2hqZHp4ZXo2Q3FTV3JPSERlQkJpWHQ3d2t1SDhQSXV2d1BI?=
 =?utf-8?B?VkltQnZZK1ZsZU0xeXQyQTVqZVJRMjNpTXIxa3UvT2p6bDZwKzFiMWhXM1E2?=
 =?utf-8?B?cjJ5VUtGUzJJTkxZU2VJeFd2b0hQV21ZUGdoZlMranB4Vi9sOXlWSDk0dkFw?=
 =?utf-8?B?OU1FNHlZa3p2WFVnWm5keGFndzFESHZjZm9HUlhJdkcvTDlGSXM5b0RBT1FI?=
 =?utf-8?B?blNTbDZuNWxRb1FqSzZ3TEptWmtGWHl5TnhVL0Q2R2NaYmVQL3M5bUdsdjZV?=
 =?utf-8?B?OVk4VnlabzRBK2d1aDdxcE51TmpzSnRCMUd0SjMrZXR2amM2dGdwMmcwblhV?=
 =?utf-8?B?N05ScGRvS0ZEVThENUphUGlHV29ZSWtPdnlra3d3Q1lYbmhRbjRzRURRMzJD?=
 =?utf-8?B?UFdzRGxSczdrMzdQM28vOEF2VzIvallGQzFGckNNOTJOUzVqaEU2RWR2N3Fk?=
 =?utf-8?B?azRNY0dRZW5SekZVOWJRbVp6R0lhNnJNV1UrWVphd243b1I4c3NaNGdPendL?=
 =?utf-8?B?WFYrd1NGWmtYanVFdXBleWk1UnRISWdodDk1dENUWDdsWmtFbmxQMkpEM0N4?=
 =?utf-8?B?N1U4WVJzVEQxT2FsNUtNcWJLSjJmUkJwVzV4UjBCeGFqTlpIckJKM0g0S1Rs?=
 =?utf-8?B?SzlnWGVpNnA5Nmw1ZERkNStacUo5M0hjNjhoaUhaRlNYZ21Sang2N09Rc09K?=
 =?utf-8?B?Um93NFFuZ3ZEK2xWN3V3Uzk0bVdvOWw5eDFSSlIwemdYZjIvNGlMd0c5QWN0?=
 =?utf-8?B?VHRKaHBFMDQ3a01IcUVpci9qanBlOWd1Qy9ZRGJ1NVBvanV4NUtDZE9JTnMz?=
 =?utf-8?B?TnNXalJ0bHpuQi9iUjkyUmJ4cFA3WUVGL25sZlRWbHFVcTJKNjU5bW1EUG5L?=
 =?utf-8?B?ZkMvdkY5Qm5Pd1VRVnVoWnhqS2k0enpkWUJOeDdaWDZWRzNidkhpU1Z0Rnhj?=
 =?utf-8?B?OHpaK1hHUzc5QTVZZExQQ0UvSWxvWjhuSEVZaThHVFVtcGdxamhmaDN0aEIv?=
 =?utf-8?B?UHExOGQxaVBzMGdRVXE0R1ppcUdqR01na3BvNzA2cWVteGc5K1cxbVlqbGN2?=
 =?utf-8?B?VXJ6L0hxV0wvbTQ4aG5FbWh6VVRMUG5yT2p2MGVVNU05RVZzb3RRenBFR2o1?=
 =?utf-8?B?TEpJL1FWS3RYSVRGYTVwbW5QYkk3WE9zNWNLcTI3dERvYWdjSlNUR3crYUhp?=
 =?utf-8?B?SUtubTI1TEdHWHNQdjlJNXZOOE1rT28xck92bzJ6V1NEQXNZSUJldmtpSmtv?=
 =?utf-8?B?bUJIMUcxSFphSk9Ub1orU3p0dGRXbXVENmQxbjlYQ2hNdU9ndlo2aGNOYmNp?=
 =?utf-8?B?WFJjTEpKUE1OUDdDZjhPd3VFQjd3NVFtRVI1RHJjN2pvQmVpaUViWGN5V3BE?=
 =?utf-8?B?RVJya1dvNWoxbitFeUZDRTIxTGZOU3FHM1RkNHZkSjE1TncwQW9rV2RSRWU1?=
 =?utf-8?B?ZVFJOUpoRUlXc216TmpiM2NqYVdZR2lVeVBCOUxUZjNyVUdyWkhaSE42VVdq?=
 =?utf-8?B?VnN6b1hmZTNGYmp5VGEvQkxqcHdUd2svUkhPT0JtY0F3RGxGVDlVMnFmZEVW?=
 =?utf-8?B?V3hNUFJxbnVpUi93N2lmei9FVGtRMkhCNlZlTWVIZ1MrNjdoRVRkbGpHOER6?=
 =?utf-8?B?VzcxQ1FSTDlTYjRtaUZ6T1FpTlpYOTlPNTk1Nnp5MHZlVU1iNW94bHI4bkVj?=
 =?utf-8?B?UzVWWlhFbWhydnVZOUk5d0U2YVFxUXVpU244bWk1b3VuS0VTeXVXd3BnSCt0?=
 =?utf-8?B?ZERpa2ZIa1huL2gxZldkZ1JYZFIrY2gwK1dvYnpZOXlhOXpWbURaK0tVVG5Q?=
 =?utf-8?B?N2dyQmoyck53aGlTbWFiS2h5VWJHdVpocGxSVUxIR0IvcUpVTkFnTW9XeXZ5?=
 =?utf-8?B?OVpUM2xhVlJKeis1QkNLQktoVWplcENITkgydFRBTmF3aTR4dG9vTi9sVUYv?=
 =?utf-8?B?MkVrSVZzSjl1MGIxSW9tQjVKYzNISUFSMGZEY1NTbkxkWlJwZ2hIbnVwZjhF?=
 =?utf-8?B?TGw0YUdqa2NMalVUN2VFYy9sQ1AzYzZLTUpKWGIxMTkyTG5RMTRjV2VrREdx?=
 =?utf-8?B?bExicnovamZXMnNQdEZUZlc3RTNrK21HU3pzSStiVGI4SFd1K1o3SnR4a0xG?=
 =?utf-8?Q?vmw2xH+UEacQLHKC+GYTFzfEg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d16c1d3-168f-4450-c9ec-08dd6557c611
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:29:41.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWS1vnX1EXkHvtdz6gL7OcDQpH26/815BMXqMug/7sXw8uEQPjb6BLVzxZNFy82Pssnp8axK2HCbHyReNF1R5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

Hi Namhyung,

> @@ -1286,6 +1286,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  	if (perf_ibs == &perf_ibs_op)
>  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
>  
> +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> +	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
> +	    event->attr.exclude_kernel && !access_ok(data.addr)) {
> +		throttle = perf_event_account_interrupt(event);
> +		goto out;
> +	}

Can this move up where it checks perf_exclude_event()? Use
ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)] instead
of data.addr.

Thanks,
Ravi

