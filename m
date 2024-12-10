Return-Path: <linux-kernel+bounces-439749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A49EB37F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB33188417B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080171A704C;
	Tue, 10 Dec 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ffa+KiBl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87A19D082
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841390; cv=fail; b=bqJA/dkbycbU2up7VWsbA+oSvbpCgh99dLw/lLCr1KW/WLUAwJA4zFiOorWDoB0Jb8vxVH5b6yMUwUX9OGF3SUfIueXpEvYlXJgBIIJRhGcSbabAKYHDHamG6sBxtxL6Xg/J/6V2aLYQkmM+v/DKhdIDzaagXyAVcIcxRl75ZHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841390; c=relaxed/simple;
	bh=v9vnGQl02Gv1PYSiKvumNGuOJmCawUC/YTVUw/aSevM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9kNKglLmx9X6RsyEkAg+sfzL+THQpcRxc+oY8jA9PZqYciQtDC8Wljyo8D2VAhO60xjKdvx8Js4aiYDLMlvYx8bW+eqplardNJhZFiDAIxsKffYQh1iTqFpyksjK2rAGXS+1zRq69TcqjXXT1J3WvPHAxix/fpXcRD8rUd+Yjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ffa+KiBl; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFNSbj4JoKRJvb12Wmx5gs5jFMEbWSXA5roaJLTGbo++Q9Yh6sjKfhq6xEIKTzKyquFQgfGEk+0TEJdoC0vHyUTabD4R0Brhd1I6MPEvAV816oLvcD9oju4hQd389wQ6NmuGD+n/nLRuT+YOrxTJ0gWxaVVw1jg6doBAMyXuUXZeGA3GATp08gfrJT8IxTM1cDsv/tGrJnJTL/qHe+JmSdqCPUCGjynWsPfGT4tBnRhBjzFskfCkro2lRU0E1EEqH4W6e7FvGI7OFwtUN67Ha4/+tkPUexF33NXFs0jdL5E7sX9nW2d8gg2vFP5MukzMS22RIwnQGt4HzD9zXHuRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnv16CYlXa7YX3HMQsnTpqA0EfMHkQGuL5Yz27NKfCA=;
 b=XkD1ctFtmfR/v4WaY/pFgdf0h7i+R56ZdBYpo0Bqgbf2H30iN1086brU+zIwzJB7g5QgL4ndwwgrgkscre6gaml5MLgCUpqP93oHjlMipRhAkuo6o+SgqmNC7wCRHUkdbrBv54Ded0hP1C4itsZ0aNtR4QrVBhzMVX4+5a9txgKP1khwnRzD2Y8X6KsacHrkfaa/xSff+zuBC62SptoNqeVnj7CZmfVyfNSB+FS9gnGFsJCE5OQblySRHNDkZ18sSqPgQRvw35dDCjIKjfWWQ8GS1ORZ6fEmZol71BxFvZ7LFqekLQaOcPW+IHYUb8hwadWWGTUlFTx3QAqjZ7Wtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnv16CYlXa7YX3HMQsnTpqA0EfMHkQGuL5Yz27NKfCA=;
 b=ffa+KiBllTYlfkriJO+WE1LMSDa6s+fcX/tdi0i2t7OrwhGMe2714ZeILB3Im7SYhGh6g+38d1o+dvPdQR9r+Sgfz04Wf4t67nc3L6rsh+cKR8PwyhA/TNV/RcTwAJTDQHHvpQPcygdXUAhl95iAlJGl3YFz6Ca8tRAiNhU/Qu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 14:36:24 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 14:36:24 +0000
Message-ID: <aa44a331-dbd9-f9b3-4c79-e5ba448b54cb@amd.com>
Date: Tue, 10 Dec 2024 08:36:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com>
 <20241209194320.GCZ1dIWDMPppdXgzxJ@fat_crate.local>
 <20241210102835.GCZ1gX04evsuTcS01d@fat_crate.local>
 <20241210104810.GDZ1gcapB4bTh2Nf-o@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241210104810.GDZ1gcapB4bTh2Nf-o@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0190.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::27) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d31c98-0f4d-4127-f56a-08dd192805ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkp1V1ZFSCtUM1V6NVMyR0hrUVBBNGswdGIxUXdwV1hLbHNaN25jZ3NRb1l6?=
 =?utf-8?B?dGQzdXFxWWZuSlZxWWdIN1lvbStQRXhTaFowbmtqYi8raWlDY1M5bk1YTTIw?=
 =?utf-8?B?K3VBWER3Y0Y0OVJSTGJkcm13ekttTi8xNlpxOFk0WDJkQWEyZ0FCNkJMbTFQ?=
 =?utf-8?B?czhIYnAvVnBlVk1PQ1R0REE4VnlNUGlDL3JSNGtlRXR2QzVUSFl3WHNFTzFJ?=
 =?utf-8?B?blZYQUZrdHVYbFNHeXVJUGtqVmxOZDFtVElPMWMrYjQ0MkJDdXFwNzlZL1l6?=
 =?utf-8?B?MDNVQmJNTlphc2dqWkk3NjRhNzBxRjNaRHlScGg4WnVJZmlzYldGbVVKSlVy?=
 =?utf-8?B?QmF2OVRibWtrZk12TW9FRDBEY0FJMkkyNWd1ZkJvRkl1K0RjMnRHWmF2UFBR?=
 =?utf-8?B?a2dJdzhxZVFVVzRoYkNIb0pDREpicm9TWGVvK1poTFB3YWFKcGxBeGEzamlY?=
 =?utf-8?B?dTZyUzZFOFVXZU1Qa01ITjRRbE1QVnp1M2ZuSnQ1Y1BDV1lZcVQ4RzNzdmpi?=
 =?utf-8?B?U3BocDNCWGd6bmdEOEQzZ1dPeE1FY1lwSkt3Mlpya1Y0bXB1dDhhNVlxejFj?=
 =?utf-8?B?cHNWWkw2OVp0L0hCaG5mbmdCL3RHbzZsaXBiSHFxVElQRCtiaGJReTJZQjRM?=
 =?utf-8?B?SzVPSndJOHM4TnA5OXU1dDFDN0ozbGdjQ1JBbmRBczV5bWNPR3JlTUZiejVh?=
 =?utf-8?B?NTZMRHRQZGI5bFZZeTNIdWZaTUtJclJmSlJHTUk0NUJJZFhlSGxCWU1pd1pr?=
 =?utf-8?B?NlhaMU9MbHI5eDRGY2MyY3BGSkx5Wm5xdGpaL3N2di91OS9EOFJZbEdMbFhJ?=
 =?utf-8?B?dFFHKzhLWUdIcFZwYXYrS01VTEpVNGJ5ZnBPbUU2L3ZYOENiM2ZPMGhWdUIr?=
 =?utf-8?B?TEp3cGFVdDBXRENCQmlQTVR6VlZXMTJ5WWV6ZXdLdERpSVp1dFhpNzlKbDYr?=
 =?utf-8?B?cnV2czZpdUxjR1FtUDQzWTRQcGMrVnlrTjZ4cWJKenhvTk1OVCtQdnpYazEv?=
 =?utf-8?B?RVk3RFpGZ2N4R0FsNnFVcVR4VHFsN2tWUVdKamRKNVhudnRhNkZjWCs3VXM2?=
 =?utf-8?B?R2hMbmRIUmRwaWtpTTczbUZyR2tVNHp6Q2tIR1c1ZUZseGNIeWZPRlduYysv?=
 =?utf-8?B?THh0a3drWmRBam5wOVE4Vy9iVlZ0Ri85Tk9WQU9xa1BvMWNXeXJ2dEphbFd0?=
 =?utf-8?B?d2wrWDMyK3VxRTZBQ3o3V3Q1SkhpL25qNDBaQnp5SGJxTzgyMjZUV3FaNUFH?=
 =?utf-8?B?SWtNY1kzMzRWU0ZOV0VreUMrbnJacGJDQlRkWFlpZkgwU2tKVnJnV3RBZFk5?=
 =?utf-8?B?bGVwcGlPajFmTk5iazQxTkJJVDZyK1hPWFZlMDRtc3p4RGpFNWhLbDZpeHpx?=
 =?utf-8?B?TVd4Mis2QnIwMDFYWUFuOUpkQlQxODNSTk5MVk1RSGhFRDEzdUlIa3ZISGlX?=
 =?utf-8?B?QTdNZW1lbkVZT3VrWWE4MEpvSWcyekN6OWFaZWNxSlhQSWlUcGtpL3MzK1di?=
 =?utf-8?B?SUNjMkl2K0liRHgxVE5MUjM0emRIcDU0NjJmNHdBeEx0Vy8vVU9MVzRSSFU3?=
 =?utf-8?B?cWl2MGoxUDFOVERvUlF3OVozbDVuTXBWU29iWjQ3blJmeVFYNzFtYXQ4ais2?=
 =?utf-8?B?TitVWU9CQzVqNi9GdU1WUU5uZktrQUZNVE10MWJUdnhLMVZrUTlHdk4vejFO?=
 =?utf-8?B?ZHdHckMrendTaXJkb0FzUlRNM1FrRDFPeDFLQXI5WWoxTHJqMnduYzRVRllv?=
 =?utf-8?B?QVBkYU5STGdOb2t2NjFEM1V4TFdaR3VoYVJwRTM5YXl0bGZaR1V6NHg1TVhF?=
 =?utf-8?Q?taVKicnVRAnGitk81pQqOQyQYi3yI3k4c8rgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cytob2RiV21NWWN3V2R6VUN1cEYxN0NTVHJpSjlMQW1pRks5ZjB6QjRyNHor?=
 =?utf-8?B?TUUwNHJobWZlU3NBTnl3N200N1pVVVROckUrWmx0ZTJyeGxBY3p3R3IyeXEx?=
 =?utf-8?B?Nlh4d0VJbWJXb2hQWWEvR2srUmVCTDBMNmFJZTZNdHI0NEJ3M2pmTGtRekd5?=
 =?utf-8?B?VlRhYTh5RFhFVzBncU9TeFJrdFRxblowTktMVitlOEFveXVORXdheTlPTkJM?=
 =?utf-8?B?a2FERUJHcHBtTTZqeUlJMmVWS1lqZllqQzNScXpSeTUrMFBHc0tzZ1BDWTlG?=
 =?utf-8?B?cy9sQXNPTjNYOENiemU5cUJZWG9xQzcwV1EyT1BYVmt2MWFQTVUycWFUcGhr?=
 =?utf-8?B?TzdjZSttRjRURllmcUdZMU1HcWFrTHJZSTArTko1UHJ6dGo3QkViUUc0bXlY?=
 =?utf-8?B?V1FLdHRJMjZsVmRHSlE4b2VGTFl0aXI5R3ErOHN6bGh0UjluUEt1dWxXNnF3?=
 =?utf-8?B?WW41aEhvWG5HSGxtS3dRRndra2x5b3lsVTlMSmVhellsY1VNcUNRRjJZMytZ?=
 =?utf-8?B?KzNPa1dRTzBQN2sxajJmZUJRSGs0NVUwMGtaN0lpUCtyQU1ReDZ3bjg1d05O?=
 =?utf-8?B?Smp1YXVKeXhUU29hRmVsbHhZZ3FrOUhSZTcvY0U4SGVDRjhJSU11Y01HMVFH?=
 =?utf-8?B?UDlCWGdUWThjdkhLa0tTRUhSOTQzb1ZXTWN0aFRUVWNzVEF5ZEhINzdUcC85?=
 =?utf-8?B?TkVpN0VRTnNxZkc4QW91eUdTMzBWSDMrVnEvcTVXMnlGdXVnQ0xuaW5EZE9v?=
 =?utf-8?B?SWhXUlZoN2VwTi9QZ2E0M0xOZTBQV1loTmxtWVN0ZHFHUllQSEFZM2pwWGk4?=
 =?utf-8?B?MmFFUEdHcnhrUjlwdmlMYWJLaGJaNG9XaHR2dFZ0RVZ1dktFTHBVYWZXdHhX?=
 =?utf-8?B?T2c4cFpYRHAwZmdST0RQNkVuZUtWbEEwY0xqcTVuZzNCWVNlL1ZVd052Qyta?=
 =?utf-8?B?ekhzSUZZZzh0ZUtMMDJLQ1hhREtLV0xkS29pNnVRSGZnTGx0Rk1WUEt0MWJD?=
 =?utf-8?B?azdNK0t6Tm9iM1ZSdENYa0ExOVE4dnorY0krMjMvUk1teGI5OC91ZWRIOGdE?=
 =?utf-8?B?Ti9RcEk0RlIyR2VqQlh6VE9kdFZ0WnpXdUhScEtUa3d2OGNkaE5uNEdHY2x0?=
 =?utf-8?B?bllmMjlLUmVvZWxKZkwzbVZteHVobHBCQSs1RnVUZ2xuNkt0QjFQWENDeVFQ?=
 =?utf-8?B?NDd3akpOZk1rR2R4QzBleUFpNk5PV2RhUVFxVFBRSDF2dFNJR0Fob0RjSzZs?=
 =?utf-8?B?ZFBGdnNPcXBZc1YxQW42RUxPMVlUQWJPRm43d1FMU1NxdlBzU29lUUdFczJX?=
 =?utf-8?B?alh3eWpwSW1xc2xRbXdVYjRXNXZxQW5wR2dqeThOVTBRZVFBSlRCY2FoUjZ0?=
 =?utf-8?B?MkFNdENBNG03bGg0NGl1Yi9PVmNCcy9vdEVVY3BZZjRsczVSMkRqUld2Njdn?=
 =?utf-8?B?VHhDRzdESWkzeTIwQnJ1d0ovU3c0RENDbjJHV3hWVThSdHFQOUhhVGltbEJm?=
 =?utf-8?B?Z0hHNFdGYWtnRkpBMFRBbC9yZ2NOMXROMG9xaTRHOEN0NnkzRFRCR0dFb0FZ?=
 =?utf-8?B?RGdud3d5YVNyYzY5QVlOMnhGWDMrSGxGc2YwRnFPSTdYcDFxZDdFejl6R2Ev?=
 =?utf-8?B?MVI2R1p6dFZaeXZ3dVVRTzhjdjRlVG1iNkhXWU4vdkwyRFJIRzdQN0E4TkNv?=
 =?utf-8?B?U2ltcDVPNDJvRVZHRXp3dzhMcHcxb0c2WS9aOHo3c3FPaGltdWM1cTA5T0dq?=
 =?utf-8?B?djV3ZGdYN212LzBUcDJWNzhSSGp2L0pyODg4TUNvVGxNRFM2MTJBdFkrMC9F?=
 =?utf-8?B?cXdlZGZZd0RLdlBmbzVlcGZxQ2Z6VHgrSERiaUlRTzdmTXUwWnRnaFJZYm5F?=
 =?utf-8?B?Z0RwWW5rZ0l3bHF1dVo5ZFgzWFFUb2VIMlM0YW9ydVZaMnU0Y0NpSG5ESVp3?=
 =?utf-8?B?OEZrZDhBRG1lN1N0R0pka01NTmE4T0FhV0xENjBOY0VteGhqcDNYWlJmSEhS?=
 =?utf-8?B?d1ZIWW83UWM3Q25IRnRjZEhOMUdYYjJTWFpMaTRHbGUzbUdKd2lJWkhxYklO?=
 =?utf-8?B?ei96amNHKzJnaFNxUnlrT2RMcjFvRk15Mjh2SnVlM2QzSWFIZzRyUlVuVi9W?=
 =?utf-8?Q?oKT5GDuCYxoOOrdxzDFFDNNAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d31c98-0f4d-4127-f56a-08dd192805ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:36:24.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpKYJcs3dDvUxYUwwP3ytXaPH8MsyKMXQv+eeA56bKJ0XfWfV4/I7mHxExg4LAU+GVDgKFe0rRnm3CIg74M5hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355

On 12/10/24 04:48, Borislav Petkov wrote:
> Final version I have now:

Looks good, thanks!

Tom

> 
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Mon, 2 Dec 2024 14:50:51 -0600
> Subject: [PATCH] x86/sev: Treat the contiguous RMP table as a single RMP segment
> 
> In preparation for support of a segmented RMP table, treat the contiguous
> RMP table as a segmented RMP table with a single segment covering all
> of memory. By treating a contiguous RMP table as a single segment, much
> of the code that initializes and accesses the RMP can be re-used.
> 
> Segmented RMP tables can have up to 512 segment entries. Each segment
> will have metadata associated with it to identify the segment location,
> the segment size, etc. The segment data and the physical address are used
> to determine the index of the segment within the table and then the RMP
> entry within the segment. For an actual segmented RMP table environment,
> much of the segment information will come from a configuration MSR. For
> the contiguous RMP, though, much of the information will be statically
> defined.
> 
>   [ bp: Touchups, explain array_index_nospec() usage. ]
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Link: https://lore.kernel.org/r/8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com
> ---
>  arch/x86/virt/svm/sev.c | 199 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 180 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 2899c2e28db9..e50b71c67fab 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/iommu.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/sev.h>
>  #include <asm/processor.h>
> @@ -77,12 +78,42 @@ struct rmpentry_raw {
>   */
>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>  
> +/*
> + * For a non-segmented RMP table, use the maximum physical addressing as the
> + * segment size in order to always arrive at index 0 in the table.
> + */
> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
> +
> +struct rmp_segment_desc {
> +	struct rmpentry_raw *rmp_entry;
> +	u64 max_index;
> +	u64 size;
> +};
> +
> +/*
> + * Segmented RMP Table support.
> + *   - The segment size is used for two purposes:
> + *     - Identify the amount of memory covered by an RMP segment
> + *     - Quickly locate an RMP segment table entry for a physical address
> + *
> + *   - The RMP segment table contains pointers to an RMP table that covers
> + *     a specific portion of memory. There can be up to 512 8-byte entries,
> + *     one pages worth.
> + */
> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
> +static unsigned int rst_max_index __ro_after_init = 512;
> +
> +static unsigned int rmp_segment_shift;
> +static u64 rmp_segment_size;
> +static u64 rmp_segment_mask;
> +
> +#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
> +#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
> +
>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  
>  static u64 probed_rmp_base, probed_rmp_size;
> -static struct rmpentry_raw *rmptable __ro_after_init;
> -static u64 rmptable_max_pfn __ro_after_init;
>  
>  static LIST_HEAD(snp_leaked_pages_list);
>  static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
> @@ -190,6 +221,92 @@ static bool __init clear_rmptable_bookkeeping(void)
>  	return true;
>  }
>  
> +static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
> +{
> +	u64 rst_index, rmp_segment_size_max;
> +	struct rmp_segment_desc *desc;
> +	void *rmp_segment;
> +
> +	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
> +	rmp_segment_size_max = PHYS_PFN(rmp_segment_size) << 4;
> +
> +	/* Validate the RMP segment size */
> +	if (segment_size > rmp_segment_size_max) {
> +		pr_err("Invalid RMP size 0x%llx for configured segment size 0x%llx\n",
> +		       segment_size, rmp_segment_size_max);
> +		return false;
> +	}
> +
> +	/* Validate the RMP segment table index */
> +	rst_index = RST_ENTRY_INDEX(pa);
> +	if (rst_index >= rst_max_index) {
> +		pr_err("Invalid RMP segment base address 0x%llx for configured segment size 0x%llx\n",
> +		       pa, rmp_segment_size);
> +		return false;
> +	}
> +
> +	if (rmp_segment_table[rst_index]) {
> +		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
> +		return false;
> +	}
> +
> +	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
> +	if (!rmp_segment) {
> +		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
> +		       segment_pa, segment_size);
> +		return false;
> +	}
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc) {
> +		memunmap(rmp_segment);
> +		return false;
> +	}
> +
> +	desc->rmp_entry = rmp_segment;
> +	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
> +	desc->size = segment_size;
> +
> +	rmp_segment_table[rst_index] = desc;
> +
> +	return true;
> +}
> +
> +static void __init free_rmp_segment_table(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memunmap(desc->rmp_entry);
> +
> +		kfree(desc);
> +	}
> +
> +	free_page((unsigned long)rmp_segment_table);
> +
> +	rmp_segment_table = NULL;
> +}
> +
> +/* Allocate the table used to index into the RMP segments */
> +static bool __init alloc_rmp_segment_table(void)
> +{
> +	struct page *page;
> +
> +	page = alloc_page(__GFP_ZERO);
> +	if (!page)
> +		return false;
> +
> +	rmp_segment_table = page_address(page);
> +
> +	return true;
> +}
> +
>  /*
>   * Do the necessary preparations which are verified by the firmware as
>   * described in the SNP_INIT_EX firmware command description in the SNP
> @@ -197,8 +314,8 @@ static bool __init clear_rmptable_bookkeeping(void)
>   */
>  static int __init snp_rmptable_init(void)
>  {
> -	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
> -	void *rmptable_start;
> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
> +	unsigned int i;
>  
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>  		return 0;
> @@ -227,17 +344,18 @@ static int __init snp_rmptable_init(void)
>  		goto nosnp;
>  	}
>  
> +	if (!alloc_rmp_segment_table())
> +		goto nosnp;
> +
>  	/* Map only the RMP entries */
> -	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
> -				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
> -				  MEMREMAP_WB);
> -	if (!rmptable_start) {
> -		pr_err("Failed to map RMP table\n");
> +	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	rmptable_size    = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> +
> +	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
> -	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> -
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -248,12 +366,20 @@ static int __init snp_rmptable_init(void)
>  
>  	/* Zero out the RMP bookkeeping area */
>  	if (!clear_rmptable_bookkeeping()) {
> -		memunmap(rmptable_start);
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
>  	/* Zero out the RMP entries */
> -	memset(rmptable_start, 0, rmptable_size);
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memset(desc->rmp_entry, 0, desc->size);
> +	}
>  
>  	/* Flush the caches to ensure that data is written before SNP is enabled. */
>  	wbinvd_on_all_cpus();
> @@ -264,9 +390,6 @@ static int __init snp_rmptable_init(void)
>  	on_each_cpu(snp_enable, NULL, 1);
>  
>  skip_enable:
> -	rmptable = (struct rmpentry_raw *)rmptable_start;
> -	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
> -
>  	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
>  
>  	/*
> @@ -287,6 +410,13 @@ static int __init snp_rmptable_init(void)
>   */
>  device_initcall(snp_rmptable_init);
>  
> +static void set_rmp_segment_info(unsigned int segment_shift)
> +{
> +	rmp_segment_shift = segment_shift;
> +	rmp_segment_size  = 1ULL << rmp_segment_shift;
> +	rmp_segment_mask  = rmp_segment_size - 1;
> +}
> +
>  #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
>  
>  bool snp_probe_rmptable_info(void)
> @@ -308,6 +438,11 @@ bool snp_probe_rmptable_info(void)
>  
>  	rmp_sz = rmp_end - rmp_base + 1;
>  
> +	/* Treat the contiguous RMP table as a single segment */
> +	rst_max_index = 1;
> +
> +	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
> +
>  	probed_rmp_base = rmp_base;
>  	probed_rmp_size = rmp_sz;
>  
> @@ -317,15 +452,41 @@ bool snp_probe_rmptable_info(void)
>  	return true;
>  }
>  
> +/*
> + * About the array_index_nospec() usage below:
> + *
> + * This function can get called by exported functions like
> + * snp_lookup_rmpentry(), which is used by the KVM #PF handler, among
> + * others, and since the @pfn passed in cannot always be trusted,
> + * speculation should be stopped as a protective measure.
> + */
>  static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
>  {
> -	if (!rmptable)
> +	u64 paddr, rst_index, segment_index;
> +	struct rmp_segment_desc *desc;
> +
> +	if (!rmp_segment_table)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (unlikely(pfn > rmptable_max_pfn))
> +	paddr = pfn << PAGE_SHIFT;
> +
> +	rst_index = RST_ENTRY_INDEX(paddr);
> +	if (unlikely(rst_index >= rst_max_index))
>  		return ERR_PTR(-EFAULT);
>  
> -	return rmptable + pfn;
> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> +
> +	desc = rmp_segment_table[rst_index];
> +	if (unlikely(!desc))
> +		return ERR_PTR(-EFAULT);
> +
> +	segment_index = RMP_ENTRY_INDEX(paddr);
> +	if (unlikely(segment_index >= desc->max_index))
> +		return ERR_PTR(-EFAULT);
> +
> +	segment_index = array_index_nospec(segment_index, desc->max_index);
> +
> +	return desc->rmp_entry + segment_index;
>  }
>  
>  static int get_rmpentry(u64 pfn, struct rmpentry *e)

