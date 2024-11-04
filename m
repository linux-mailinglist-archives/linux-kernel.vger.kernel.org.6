Return-Path: <linux-kernel+bounces-394385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AF9BAE4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F64B22447
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C541A18F2F7;
	Mon,  4 Nov 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a1k4DsAJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767218BB93
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709651; cv=fail; b=opC/fd5VZXYqXo7gqMKg2E2tXxQRLW8bnpWQxUocVsf7QWrRbJK92xgwMsxb+GaOeeMg4XW//38bABEcC8HaDWAHLrW1upfp2XDM+4bQwrrEHA9OBOeccRWk2AIJhUHy5vHPX3tUrS2w0HjVr3Ut4G1/g45X5Gdxuw7scsvOAXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709651; c=relaxed/simple;
	bh=KmPm8c1qT7/uzUxH5piLAz2qz6cAHu2GwRBAfyI4Wpk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fm6rjldiUSWZh9TkZrE1C/saz8xRfOKIsGeLQF+lL3VYpUfi44zX0O6i7s7cm2js7chsS+O8BK4TjrJVow6lv+DQgr2mCSTIYoeuree/V2jvnZdncHxx0S21gzMvV4qIKaQUD2iQKLgDzoW9PkyqbAUtX7HG6YN/6O1TDsvutV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a1k4DsAJ; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG+EbKHJIUp8H3+5V7RiLsLAd/pun4k/qYL7sBvVexa9BVq7hJ5uVNnAaC0ia9aJapC6eLS3IhPOYO/ottr5lyS8Bl5yGjD21iB+d57X5uGX4ELzBWZt5U0XGlyksFxGaGZ5SsbSXU34r7ik4k8ganxi5ersOih9xVM+Yec/M7jxGcVmmqCjlBlF4QyHsPlTBH+os9wKbDCjAsazASEBW/oTxkd2++3SSiKiqmbbYckAlpt52XYmEpSwhVnW0rZF3Y30iuoQk1/wqdjkacnRMXxqi6ZTxhb3LXOIgghbqqcJU7A/dYXuPxLXe6fs2KGrU6C/wQcpsIbILs9HpeW/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqbTdhuuYannyHovDaDAT1E3PLYcTCZ/i4MMBOM/Yu8=;
 b=KphbMDbgHTYw/8eOnrSYdtd2WfOh7VTK9PhEsCMplYISwlKCjkWc6vB9AoHgCPwMwn9Oy8X8ksTgjjeMOiKNkE8rsUZVwJTFhqp/I0MTsYXmeheVxnQQ0VV+hcWYNyb6hpCdJCl+JfyZR7RBgox94bWAA1tFxzrefdSZQhRarkAJvyhoRiGNmzAYoApc0c14Pl6mmfyd8wAr7Y/8HJKprIxfpEWp44lngJbhifO11hxxssCTdNzhLMdXNk4Xa1qjtpdukKtaZjBUqlFfQpNTlnlLcTLhzyVU3mOP2I5WcY80AVYHXv6QLrS4eVXLTp3ZT2U/LvGQh0ZsPLgZCvCEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqbTdhuuYannyHovDaDAT1E3PLYcTCZ/i4MMBOM/Yu8=;
 b=a1k4DsAJNTuM28whkxdyKJBYHaLyLedkGVcRnWpvmao28Pi3VzUrahRKV1pLRxv7Cux7Iev8rYx7Usk7QT5GdBdyi1Oh/wnEQT6RBspl0gpxwzSa6ACO1/iyB9BGWxTfWPbupFrA7hFv9k7IvENmhTPlkyf2cFco2cMcdjbrcxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 4 Nov
 2024 08:40:46 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:40:45 +0000
Message-ID: <5ef943d9-1ce6-4b20-8c6c-7cba4f1b3ea9@amd.com>
Date: Mon, 4 Nov 2024 19:40:37 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC v2 2/2] tsm: Add TVM Measurement Sample Code
Content-Language: en-US
To: Cedric Xing <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Lukas Wunner <lukas@wunner.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
 Mikko Ylinen <mikko.ylinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
 <20241031-tsm-rtmr-v2-2-1a6762795911@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241031-tsm-rtmr-v2-2-1a6762795911@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0071.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: fb411f80-4e50-42ab-f7ff-08dcfcac5f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlaZ0RWc0I1bDZRb216Qm8rS3Y0eXBzSUZ4SEtPcjJzNFVVSjVaNDdrSG9v?=
 =?utf-8?B?UTBoWUhqZjJoODMwUXd1bExHRlo4a2NFZ3pmNGhqcGNGcld2bG5xYkRobzlk?=
 =?utf-8?B?cHRyWkhBbk9qRXNSMit0UmZrZXhPMk1kc0QzNEtiMDRaaURWL1ZMTFJmVnpJ?=
 =?utf-8?B?bFZUMkxNaUJpejNvV1ErbnVlR1N0bzRIcFpKazFOc24rKzBUZ0tMd00rVWw0?=
 =?utf-8?B?aGpMbENzSGFUanpGdXNGcTBtS0RkNlZNNG9IQVZnM1NiMCtobXFNRmtnWG9W?=
 =?utf-8?B?UlcvSmpjUllzdzRjc3lSV3ZRUndJNXJjMkZqRTdaSDE0dm93Ni9lQ0ZFL0k3?=
 =?utf-8?B?RUVPem1Ra243T2RYQlJmRjBOSFFjWi9MeEY1T3NzZXRxVW11K1VqK0dKbktl?=
 =?utf-8?B?TEhTOHpTTHhxclh2R2hHRUtoMXdmcEZzdENsMjRyVDIxY2ZaNFIvZnhXQW5W?=
 =?utf-8?B?ajV6TTg1TjRuMEtTSTlTR1I3MzlBNERTeEJIaWpPTW5hNTZ3cmQ1SkZTc0pq?=
 =?utf-8?B?alNUanR2QzN4WE5Gby9GYzlKeGFZSVlkVzQrRzVRaGNYZk5yd1ZOb2NSRHZu?=
 =?utf-8?B?dTVma2pXRzBKZG1OSTVyTVZvajdhRVFIOE5pQS9HMTFxbXErYzVRbGVXbDRi?=
 =?utf-8?B?dDNjK2VQUThCcmhOZElEWGtJazVucnMySlVFVnQyTno3ajMxV2k2ckhpUWFv?=
 =?utf-8?B?YzZVQVM4cE1sRWJJN1hRSVh6QmhUZENCNW5wMWRyeHBDakd5dDBQODgxZlJI?=
 =?utf-8?B?RCs0c29VNDhYdWN0NnQ4YUNEUmdMbUl6aXJtZ3NkcWlWWHRyWGhpVEt2cmpO?=
 =?utf-8?B?MWE1R2ZyNFcxQXhFcXZCV2Z3ZGYycGxhUVJjeWRRazV2aktxbiszejl2NWlW?=
 =?utf-8?B?RnUySUlNVWErcTRGNzhEaDVrRkpWeFFsbnA0UEcwOGt2VGRCcmVNZjFhTk9N?=
 =?utf-8?B?MHdnRFNxOG9ybzY0TkUwTmU2M0JnaTBpQW9PNmR2MVU4MzZBSzlxVVpwdVVo?=
 =?utf-8?B?bVJrSnB0dWh2YzAzSDlRMDBMdnhjUGdEM1BpTE5pdWlUYkdybkNvVEtYWlZN?=
 =?utf-8?B?ZUJmTDV5TlZaaVNnblVUU0pqL3pKZGF0TThFOHNEaVdzNVUwcW42TFRwRnh2?=
 =?utf-8?B?ZUxSSk1xdGJaemhQUTlJdGNTbStjUlZVWFlVc2hQWjQ5N3NScE9raGtkaWl1?=
 =?utf-8?B?cjErL0JhWGhhZHNtQW01a0hxb1RJbmhYNWFNcXF5OC9ua3g5V3A0OVZEaHBr?=
 =?utf-8?B?RG8zV050b3h0dzhjRHk1cEJQMHJCb09Icndxdmh5enRZUFBDWGsxWEFucjFM?=
 =?utf-8?B?TkRyVzhHaHZKRUVQL3VicWttdDhTWVdSUVFtVzZPb3NUTFRnNVJWZ1F6THFO?=
 =?utf-8?B?N2p1MmRLSjUxSVhGMGUwVDBML082T1hDRGVpVDRZLzFtcTVpbXpab2NiWmph?=
 =?utf-8?B?VzJrNG5jVEdRUURTNXNERmZPbm1SWlFSZ0ZWUUw5S2lnOHlqVVk4Ly9SaEty?=
 =?utf-8?B?ZjV1b0ZjQmRBMEQremhYMkw0YzAxV3JSdTNNQk5RVG9RSlQ1ekt3dHZLSmR4?=
 =?utf-8?B?eFRaMFkxSHVPOXdPdU9rMERESFpXdFpGSHJIL3A4OTBGcHNDdUp2SzRMcUs5?=
 =?utf-8?B?OTBJelgwMnlzaFJtSUZhNEhaSW9iVmg0YytPd3NKb1lpU25pWmVkNEtTL1cx?=
 =?utf-8?B?S3dudTA0MGJNRVhCWjlyalV0OEpVbmorQ2xENGkxRU1KMlg0YnBMZFZObmhF?=
 =?utf-8?Q?Bev6WqsABbLIE48H53TL5MraNFfJR2qpiq60wSJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE9BbndGWHREMHE3cXFUTjZ2cHlYTlloalJqYmN3YnZKekg4aWdpRm8xdk1j?=
 =?utf-8?B?NUNYRitLWmhMc1E0ZmM1OUFzY3N6STREY3VYRFpzVElqQStpSHpOK0NsWXpU?=
 =?utf-8?B?NUJ3Und3WDRrN011SDNmbjFmalRSMktSNEZBdk5UZUF6eXBKL1htcTJtcDVr?=
 =?utf-8?B?d1V3L3FMQjd6OWdtRE02VDRIaHlVb2ZkTXh3M0JmcnFGZUFPUkdXY1FDZlVn?=
 =?utf-8?B?Z1FCbm5HbmlIVmlDdFhYWDJFdXVnc0dlZkJMbzRHODhOY1poT2VVeXFNU3c1?=
 =?utf-8?B?T1JmSjd0cCsrbS83MWxrc29hTklENjhhRk4raVZjNloxUndhVWhMMFN0aUhw?=
 =?utf-8?B?M0xuU0cwYlZrODBJTUUyR2FqN1NiTDFDd2dReHpDcU1QcFIwUTlrNnJWRGl2?=
 =?utf-8?B?OHQyaUxiK1N1LzIvWXVJbVhUMlRKMjVQMjVTUHJiKy9DZzcxQ1hHc3NqTWYr?=
 =?utf-8?B?TjJ0T0JJdTgyNnJidnI3aW00dWRIOFM1dmlBN010SmQwcytVUlFVMW1DUit5?=
 =?utf-8?B?UFduRGsxZDlJY0k4eUx5WkRIKzNyMDVRNTJpRlJXMnF1VnJkZTljZXZuYlkx?=
 =?utf-8?B?YlVtcU83N1MrQmV4ajROMkZpUDZ1ZWNqdmpuWld2SjQ0MjNMT29POGtuMTRW?=
 =?utf-8?B?ZnhOS21aTzZEaGduaTJWQTRBT0R2Q1I1WVBacXdIZW16eGZSeXZwNk5lRXh2?=
 =?utf-8?B?NThod3ZFWHVFSmx1RmZaR3VWeDJlRzI0RSs4ZlN2RmFUaWpiREhyUSthNFZk?=
 =?utf-8?B?QlQ2bFIwQ0VvbU5oelpQWVlJaUU0eDkyUGlLaEZjRHVWVGRTNEdnWmh4bmF2?=
 =?utf-8?B?aUtiMFdMR2dlWms3S0dWbmRha2lPUHF6NWRwT2Y1MExvRGFTdUtHTVpUTXJv?=
 =?utf-8?B?enRiU3FNejdOUmJLYXd4ZGxIZlNXSmtWWmRhcEpEQVJhME5vd1M2Z3NHV0hG?=
 =?utf-8?B?dVdIb29zbkdoWEVnNFk2WWV6QnlVTG82Wlplc21NSER5cmx1MnVmbFk3V3F6?=
 =?utf-8?B?MFUwYXlzMXdKWkRPTE4vU0wrdzdNQmdVY1lFclN0MmxYQnhqZFNqcDRzanZP?=
 =?utf-8?B?QWZnd3lnYXpxWkRkNWVueFpjZGVqRkVjcnd5a3NmZ2pSSHFxYWNsOGZNRmU0?=
 =?utf-8?B?cVhwKzEydmRqTW1ZWm1rZjRWNkxyNnE3OHFCSzRqUndkYnBNTHJLMldQTzJv?=
 =?utf-8?B?a1BjZzRQbDh6NjNJeVlkN256NFViRTdnZTUzQ0wxUXk0eUVQeXNOSm5oZ1hm?=
 =?utf-8?B?YnVUT1BnTFp0aG5uTTdDMEE3Zmo2OHVaLzhmSk1VcFFiV0VMWCtUUVNrMTRs?=
 =?utf-8?B?bnVwbE5GZFY4bnZzL1F0bUhSRkJ6UWNtSkhVTzVnc09JRDYwazV0aWFDY1BP?=
 =?utf-8?B?emlhY01HQlQwdzl0OU8yOHZlbm9DaDNYZURMbnpMYittSnFKbjl3ZWRtRVdZ?=
 =?utf-8?B?MnRZYTJSaUw4ekhVbDhxVkdTaVh6bUdFdW12ZC9HK29zV3JscGJZdHpMSHM1?=
 =?utf-8?B?VWFxUWxmbE1MYjdZVFZqdWFOK21sUW9CbXNvaEF1cFRma1lLTk15TEZaVUNR?=
 =?utf-8?B?QUhIdGt3Y3M4Zjd5NVB1d0hVQThNeWRxQytGL01OSnczQk1XMHNtcXJQL3BR?=
 =?utf-8?B?Q3NUQUNHT2xOcTRUVjZaVnJ4NnAyTk5JUnpUeWg3bDVIQStzZHFUSE54NG1w?=
 =?utf-8?B?QnQzREo4eHVpSU1vdThhUVl2WkgyUkFMQmZHSWJKRkJ1M2VWc1FRUWtLQ29G?=
 =?utf-8?B?OFh2QWxOREU5c28ramVJczhtU1kzaHhkNFJFNE4wNlgxSUMvaG8vTWNrVG0z?=
 =?utf-8?B?SjQ1ZFFQNGZ0YlVNeCtYVDY0WUg0OElIRWNHTkw5RHlIV1hDNFNZMnJ1ZWZQ?=
 =?utf-8?B?eUhRQWliK3RNamRpckd1ZWpoT1lBT3IzZzRKYUExemhrNGFoenkyOURnaW9W?=
 =?utf-8?B?Qi9uT0NmanQzNUd2U1BJZHpwNmlvQmhYWDk4cmMvUGhyaVpjQmVvbWtqeU9a?=
 =?utf-8?B?U05IbU8wZUxjU3oyU1QxSkQ2dkRpaWRwdFdHMDhKVXhNRklSaVlBL3pYVjlw?=
 =?utf-8?B?YjByV1E4MlQxdzlOY0dzZU5pQUw1MlpSMldBdTR2c2U4VThuRjQyb2RQMm1i?=
 =?utf-8?Q?e7oVo0vCBt1QXefsA5BAvBBwa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb411f80-4e50-42ab-f7ff-08dcfcac5f8a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:40:44.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyKu1lIYKPgGvSzhOFrJxMCBfRYUkHr8+uehhqXIgUUh4Vmlb6AXtG4gzEdEUtVQItpm/pOTpWWLIujsPUAsvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

On 1/11/24 03:50, Cedric Xing wrote:
> This sample kernel module demonstrates how to make MRs accessible to user mode
> through TSM.
> 
> Once loaded, this module registers a virtual measurement provider with the TSM
> core and will result in the directory tree below.
> 
> /sys/kernel/tsm/
> └── measurement-example
>      ├── config_mr
>      │   ├── digest
>      │   └── hash_algo

Do we actually need this many nodes? A digest is 64bytes long (or 128 
chars), hash_algo is lot less, "config_mr" could just print 
human-readable 2 lines (one with the algo, one with the digest), just 
like many other things in sysfs. And with one node per MR - no need in 
that suspicios _kset_put_children() (which at least belongs to 
lib/kobject.c). Or more nodes are coming?

(ignore if it's been discussed)

>      ├── full_report
>      ├── report_digest
>      │   ├── digest
>      │   └── hash_algo
>      ├── rtmr0
>      │   ├── digest
>      │   └── hash_algo
>      ├── rtmr1
>      │   ├── digest
>      │   └── hash_algo
>      ├── static_mr
>      │   ├── digest
>      │   └── hash_algo
>      └── user_data
>          ├── digest
>          └── hash_algo
> 
> Among the MRs in this example:
> 
> - `static_mr` and `config_mr` are static MRs.
> - `full_report` illustrates that a complete architecture-dependent attestation
>    report structure (for instance, the `TDREPORT` structure in Intel TDX) can be
>    presented as an MR. It also demonstrates exposing measurements in a file.

It looks that /sys/kernel/tsm/full_report is a binary concatenation of 6 
digests, with no hash_algo and no hint which digest is which, hardly a 
"structure". I do understand it is an example though :)



> - `rtmr0` is an RTMR with `TSM_MR_F_W` **cleared**, preventing direct
>    extensions; as a result, `rtmr0/digest` is read-only.
> - `rtmr1` is an RTMR with `TSM_MR_F_W` **set**, permitting direct extensions;
>    thus, `rtmr1/digest` is writable.
> - `user_data` represents the data provided by the software to be incorporated
>    into the attestation report. Writing to this MR and then reading from
>    `full_report` effectively triggers a request for an attestation report from
>    the underlying CC hardware.
> - `report_digest` serves as an example MR to demonstrate the use of the
>    `TSM_MR_F_L` flag.
> 
> See comments in `samples/tsm/measurement-example.c` for more details.
> 
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> ---
>   include/linux/tsm.h               |  63 ++++++++++++++++++++
>   samples/Kconfig                   |   4 ++
>   samples/Makefile                  |   1 +
>   samples/tsm/Makefile              |   2 +
>   samples/tsm/measurement-example.c | 117 ++++++++++++++++++++++++++++++++++++++
>   5 files changed, 187 insertions(+)
> 
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 11b0c525be30..291259fc85fc 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -5,6 +5,7 @@
>   #include <linux/sizes.h>
>   #include <linux/types.h>
>   #include <linux/uuid.h>
> +#include <uapi/linux/hash_info.h>
>   
>   #define TSM_INBLOB_MAX 64
>   #define TSM_OUTBLOB_MAX SZ_32K
> @@ -109,4 +110,66 @@ struct tsm_ops {
>   
>   int tsm_register(const struct tsm_ops *ops, void *priv);
>   int tsm_unregister(const struct tsm_ops *ops);
> +
> +/**
> + * struct tsm_measurement_register - describes an architectural measurement
> + *                                   register (MR)
> + * @mr_name: name of the MR
> + * @mr_value: buffer containing the current value of the MR
> + * @mr_size: size of the MR - typically the digest size of @mr_hash
> + * @mr_flags: bitwise OR of flags defined in enum tsm_measurement_register_flag
> + * @mr_hash: optional hash identifier defined in include/uapi/linux/hash_info.h
> + */
> +struct tsm_measurement_register {
> +	const char *mr_name;
> +	void *mr_value;
> +	u32 mr_size;
> +	u32 mr_flags;
> +	enum hash_algo mr_hash;
> +};
> +
> +/**
> + * enum tsm_measurement_register_flag - properties of an MR
> + * @TSM_MR_F_X: this MR supports the extension semantics on write
> + * @TSM_MR_F_W: this MR is writable
> + * @TSM_MR_F_R: this MR is readable. This should typically be set
> + * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR
> + * @TSM_MR_F_F: present this MR as a file (instead of a directory)
> + * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
> + * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
> + */
> +enum tsm_measurement_register_flag {
> +	TSM_MR_F_X = 1,
> +	TSM_MR_F_W = 2,
> +	TSM_MR_F_R = 4,
> +	TSM_MR_F_L = 8,
> +	TSM_MR_F_F = 16,

Usually these use hex.

> +	TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
> +	TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
> +};
> +
> +#define TSM_MR_(mr, hash)                              \
> +	.mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, \
> +	.mr_hash = HASH_ALGO_##hash, .mr_flags = TSM_MR_F_R
> +
> +/**
> + * struct tsm_measurement - define CC specific MRs and methods for updating
> + *                          them
> + * @name: name of the measurement provider
> + * @mrs: array of MR definitions ending with mr_name set to %NULL
> + * @refresh: invoked to update the specified MR
> + * @extend: invoked to extend the specified MR with mr_size bytes
> + */
> +struct tsm_measurement {
> +	const char *name;
> +	const struct tsm_measurement_register *mrs;
> +	int (*refresh)(struct tsm_measurement *,
> +		       const struct tsm_measurement_register *);
> +	int (*extend)(struct tsm_measurement *,
> +		      const struct tsm_measurement_register *, const u8 *);
> +};
> +
> +int tsm_register_measurement(struct tsm_measurement *);
> +int tsm_unregister_measurement(struct tsm_measurement *);
> +
>   #endif /* __TSM_H */
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b288d9991d27..8159d3ca6487 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -184,6 +184,10 @@ config SAMPLE_TIMER
>   	bool "Timer sample"
>   	depends on CC_CAN_LINK && HEADERS_INSTALL
>   
> +config SAMPLE_TSM
> +	tristate "TSM measurement sample"
> +	depends on TSM_REPORTS
> +
>   config SAMPLE_UHID
>   	bool "UHID sample"
>   	depends on CC_CAN_LINK && HEADERS_INSTALL
> diff --git a/samples/Makefile b/samples/Makefile
> index b85fa64390c5..891f5c12cd39 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
>   obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
>   obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
>   obj-$(CONFIG_SAMPLES_RUST)		+= rust/
> +obj-$(CONFIG_SAMPLE_TSM)		+= tsm/
> diff --git a/samples/tsm/Makefile b/samples/tsm/Makefile
> new file mode 100644
> index 000000000000..3969a59221e9
> --- /dev/null
> +++ b/samples/tsm/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SAMPLE_TSM) += measurement-example.o
> diff --git a/samples/tsm/measurement-example.c b/samples/tsm/measurement-example.c
> new file mode 100644
> index 000000000000..3abd67d3e569
> --- /dev/null
> +++ b/samples/tsm/measurement-example.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#include <linux/module.h>
> +#include <linux/tsm.h>
> +#include <crypto/hash_info.h>
> +#include <crypto/hash.h>
> +
> +struct __aligned(16)

Why this alignment?

> +{
> +	u8 static_mr[SHA384_DIGEST_SIZE];
> +	u8 config_mr[SHA512_DIGEST_SIZE];
> +	u8 rtmr0[SHA256_DIGEST_SIZE];
> +	u8 rtmr1[SHA384_DIGEST_SIZE];
> +	u8 user_data[SHA512_DIGEST_SIZE];
> +	u8 report_digest[SHA512_DIGEST_SIZE];
> +}
> +example_report = {
> +	.static_mr = "static_mr",
> +	.config_mr = "config_mr",
> +	.rtmr0 = "rtmr0",
> +	.rtmr1 = "rtmr1",
> +	.user_data = "user_data",
> +};
> +
> +DEFINE_FREE(shash, struct crypto_shash *,
> +	    if (!IS_ERR(_T)) crypto_free_shash(_T));
> +
> +static int _refresh_report(struct tsm_measurement *tmr,
> +			   const struct tsm_measurement_register *mr)
> +{
> +	pr_debug(KBUILD_MODNAME ": %s(%s,%s)\n", __func__, tmr->name,
> +		 mr->mr_name);
> +	struct crypto_shash *tfm __free(shash) =
> +		crypto_alloc_shash(hash_algo_name[HASH_ALGO_SHA512], 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +	return crypto_shash_tfm_digest(tfm, (u8 *)&example_report,
> +				       offsetof(typeof(example_report),
> +						report_digest),
> +				       example_report.report_digest);
> +}
> +
> +static int _extend_mr(struct tsm_measurement *tmr,
> +		      const struct tsm_measurement_register *mr, const u8 *data)
> +{
> +	SHASH_DESC_ON_STACK(desc, 0);
> +	int rc;
> +
> +	pr_debug(KBUILD_MODNAME ": %s(%s,%s)\n", __func__, tmr->name,
> +		 mr->mr_name);
> +
> +	desc->tfm = crypto_alloc_shash(hash_algo_name[mr->mr_hash], 0, 0);
> +	if (IS_ERR(desc->tfm))
> +		return PTR_ERR(desc->tfm);
> +
> +	BUG_ON(crypto_shash_digestsize(desc->tfm) != mr->mr_size);
> +
> +	rc = crypto_shash_init(desc);
> +	if (!rc)
> +		rc = crypto_shash_update(desc, mr->mr_value, mr->mr_size);
> +	if (!rc)
> +		rc = crypto_shash_finup(desc, data, mr->mr_size, mr->mr_value);
> +
> +	crypto_free_shash(desc->tfm);
> +	return rc;
> +}
> +
> +#define MR_(mr, hash) .mr_value = &example_report.mr, TSM_MR_(mr, hash)
> +static const struct tsm_measurement_register example_mrs[] = {
> +	/* the entire report can be considered as a LIVE MR */
> +	{ "full_report", &example_report, sizeof(example_report),
> +	  TSM_MR_F_LIVE | TSM_MR_F_F },
> +	/* static MR, read-only */
> +	{ MR_(static_mr, SHA384) },
> +	/* config MR, read-only */
> +	{ MR_(config_mr, SHA512) },
> +	/* RTMR, direct extension prohibited */

What is indirect extension here? Thanks,

> +	{ MR_(rtmr0, SHA256) | TSM_MR_F_RTMR },
> +	/* RTMR, direct extension allowed */
> +	{ MR_(rtmr1, SHA384) | TSM_MR_F_RTMR | TSM_MR_F_W },
> +	/* most CC archs allow including user data in attestation */
> +	{ MR_(user_data, SHA512) | TSM_MR_F_W },
> +	/* LIVE MR example, usually doesn't exist in real CC arch */
> +	{ MR_(report_digest, SHA512) | TSM_MR_F_L },
> +	/* terminating NULL entry */
> +	{}
> +};
> +#undef MR_
> +
> +static struct tsm_measurement example_measurement_provider = {
> +	.name = "measurement-example",
> +	.mrs = example_mrs,
> +	.refresh = _refresh_report,
> +	.extend = _extend_mr,
> +};
> +
> +static int __init measurement_example_init(void)
> +{
> +	int rc = tsm_register_measurement(&example_measurement_provider);
> +	pr_debug(KBUILD_MODNAME ": tsm_register_measurement(%p)=%d\n",
> +		 &example_measurement_provider, rc);
> +	return rc;
> +}
> +
> +static void __exit measurement_example_exit(void)
> +{
> +	int rc = tsm_unregister_measurement(&example_measurement_provider);
> +	pr_debug(KBUILD_MODNAME ": tsm_unregister_measurement(%p)=%d\n",
> +		 &example_measurement_provider, rc);
> +}
> +
> +module_init(measurement_example_init);
> +module_exit(measurement_example_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Sample tsm_measurement implementation");
> 

-- 
Alexey


