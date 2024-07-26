Return-Path: <linux-kernel+bounces-262822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763E93CD28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB371F226A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC606249F9;
	Fri, 26 Jul 2024 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6wRZ4lf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF862135B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721967404; cv=fail; b=XvL2KiPGFuZRTIMHCHPzhhtOizn/ogveX6Y6fDDzAXPFUopJ/RRr2xZlr3j2wEXHYffOrO2V2Ni/av0SxgS5d+TnfILkIp76s0K3dCsobLB4OCKPNvRudXXiuwEVK/YcUVn2d5S1MhImuaFoLhkbrzSZoqtlOn3Ye2x6ChBWdTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721967404; c=relaxed/simple;
	bh=gph1qf5TbsjTGMkZDtE/8P0aiYYpGm9idpy5BHXeAqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jCITy3wBXdubk0Fmkqj400d82Zs01MxdjWPJLDPILA3roghWAfHPFpM++s7Xr4oeu1hrbUpPl0LbE6PPaBBZ+QYL5dl7umy/CKzwtqpGXjlocNZmRI7873tT8lIRMgi3UXhmMS0T+oZFQS0rwv4oI2nnJ2Ilpw/bnQTGIjc8oH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6wRZ4lf; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbGLzHrZtebL6GYu04aQ/ZEeZ2Cy3hlH8xjYp6xKOm2t/n+cErOeiOzrIyLUzCHbXoEj7WQgxGMF1jZ+IAEJssKD1FW5fT0XtbO3GHRlJn9ZohnAFceTXTxPN/LZKSGnuecEf867WbwXtzMpn752owhpAoSEujkM8Z9Rr2GRGgxRYGp6ikX8J869fYg8xYKLNE4TlZWBBtJ7TrggZiQ67OmQE//c22fLv3mMWS92P8ozsqgJn0iAKxhd0QP8djvF+6wuFLt/T3OEdfBXc7UurhGQAOhpnv82vqtZpM9mLCKBDbY/xPxSqWTpOaV9UV1O6dDcApKXxExBJVhYm7lFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T15tjsisP69rJx+i2iEbXK4VHFIE3okDysv9hU5DEW8=;
 b=HhpVS4qpOaJBTeP5ImBAZihXt2GYFD4XlQJuP4SwIgB+FZPMHTy152+BeDFtTg+CTBBcAcz9Dbwtk+Nu2G7+SmrNSe7Q4cK02Cuq1Z3wA/wFyxKXY3VwD9EPWDpzNNnhcmw/edsfGxLQposo2rV4xk9pEQ26k/Qu3cp7tC6NZzqSGq0UHhrnRhd7GlP8M3ajc1+WF6wulRw2VNE61fSi7wob0uIaGXM7f1sDK1B/A/gaRv9DqNl7asAq7BOrylehxgaQJSn5h1PyEVoLiRFll0mBhLz9ji9h7LAwMffdKIsELMnXaiTiOu4LJHrhQ2KixQR3/IF7RhXuGCqfVV5qIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T15tjsisP69rJx+i2iEbXK4VHFIE3okDysv9hU5DEW8=;
 b=w6wRZ4lfhbyXYAB4+VhmH/C9Fs89eAZtHqhpS/5SATa4lHdUZhd3GIJzNVnOoqQi3q2mm6DOtPp1oescz2UVrmNsKDi23lqQCZVxGe9TsvUrLaHwWqpiUal70sp3fIWevu8xRLcCzZ+tq/zhtJRgc+87uEFMWv1tCi2bWepB9TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 26 Jul
 2024 04:16:39 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%7]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 04:16:38 +0000
Message-ID: <32f8680b-ca66-4126-84ac-d8e375ce2f18@amd.com>
Date: Fri, 26 Jul 2024 09:46:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmstat: Fix placement of per-node stats in
 /proc/zoneinfo
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
 hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, hannes@cmpxchg.org
References: <20240725105626.824-1-shivankg@amd.com>
 <20240725124710.76206c2c9baa27b8463b825d@linux-foundation.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20240725124710.76206c2c9baa27b8463b825d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::18) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6c6007-da12-442f-0ec9-08dcad29be81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mis2L2hKOHd4VEdqdzB3VTZZNXdsRVU4bVJRclhLaXUwRFNMb1J6SWJyd1ps?=
 =?utf-8?B?TTVHWmppcmwwUjlocjNhQmhOcVgwZGxsbENGU2c5NnlrU0dERFZ4R1FSRzVL?=
 =?utf-8?B?RU84clJQdGhQUWJXVndLRXZ6Wm9ncEtNR3FsTk1DZlIrVHNiMzNzR0lqNmpK?=
 =?utf-8?B?MDVFaThMekJrMlYwYUc2WHdKdFkxdmJKNm5MY1ZvSGQ0c29LbldHWnVBdE5T?=
 =?utf-8?B?U2pmQlRmWm9tVDhPUXRvT0RDNXdBYnVZWjVPTlFTYk1aZERUWXpUbmZma3BO?=
 =?utf-8?B?aGt5eGR4VjJnNE1EREZlbklQZ0pMK2xsQzBYTi9FWlV0d0dzUlB5dXBSZVlC?=
 =?utf-8?B?aUtRcUpNUjU4YWhzakZWZlFvb0k1c0VybDRtcUdzeGRsVUh5UWxSRHcrT2gz?=
 =?utf-8?B?Um1pL2U3ZWlIbUc3ckNZUEZWbWlkZTBqai9hQUg1dHg2SDVvakZrb0MwNjVN?=
 =?utf-8?B?TDM2SXlNWjVSang4SzlQWW1zaFRCWUhnZWRnZVpoRGY3REJvZi8wNTBYQmJ3?=
 =?utf-8?B?VXVFeGRJKzNQN0J6RWdIRFdFZ2tmS3Zudm5jbGxvVWdmQXJJRWhhNCtRSUwy?=
 =?utf-8?B?aE5Rd1NCdDhyQjNuMjRFV0hEVnhqbi9Ja3dRMHBsRG1jLzFUODFmZjN3Snpz?=
 =?utf-8?B?allpaWJuTTlhbmZLRmx4MnBCYWJybEpwa3FMeEszbG5mWE5OdTYwUkZJZ3dv?=
 =?utf-8?B?Q2x3aGN2ZHk5eU1RU3IrZFlSV3RqQjVxSTdMbUNFdHpEZ0toNyt3Nzd4Q2My?=
 =?utf-8?B?UnliazZFQ00rMFp2ZHhwWFdRdTJYWllYYUtCN1VONlhtdk8rS1NjK2xLbGI5?=
 =?utf-8?B?dkd5YnVHcS9uS0tZZC8xdFBpVFd4Y2tHYUxHWGR0ZFp0QXVlWEtwcHF6Yndy?=
 =?utf-8?B?aHU0dzBEYUlmdnBUZ3dKVTNsd1pINzNkZlRzRWp4dFZ0VnBhTVdnaHF3ckYr?=
 =?utf-8?B?aTU0QSsyWnY2SHg2SGJkcXptWnp5eXVjUzRxbkV0V2dNS3lsaFdiYkJVbkRM?=
 =?utf-8?B?MHptNk8rVmRTaVA1emovS1ViSkx4dFMvazExRHlYdzExRzl3b1J0dHA4eElx?=
 =?utf-8?B?ejdqdldhTHdGSUVvN2U4ZFZ6cXZRZlo3NmFzdDdkMnJqbDk0V09UVXI4cFRN?=
 =?utf-8?B?RHJtVUM4N3E1WnZCYU9vV2QyenlmSFdYdE5mQkN0RElicWdLWXNGZ2FzZEpU?=
 =?utf-8?B?T3JTQUoyL1RsSTUzSCs1bTNlMGNMQTczRGxCRDd6LzU4bDVZemhVaGZCQnRG?=
 =?utf-8?B?WkovR2tkbk5NT1ppV2VrYWhGQlJhRGdiejY1R3BacnV5MFRHR0U1VlM0UmxB?=
 =?utf-8?B?TittZGEzdWhReGl6TnJLc0ZRQ1Ivell5dnh1VXVieWUydzVIYzR1N2NHWTBr?=
 =?utf-8?B?a3lDU2g2Z1JRMGFUMHVsQm9QMW5BeGx6TlhJRnlyTE9qVVE2QzZJRS84V2p4?=
 =?utf-8?B?d2lPNWhNa01telEvNmkrV0FhRm1KT0VveFNmSG5uT0hvVDI2WFhSWFc5a0g1?=
 =?utf-8?B?UDd5a28vd1NzcS95TmRlVktWZldua1oyd1dKbnJTb0ZVUUhZNFB1emZZUlRS?=
 =?utf-8?B?RmZka2QzR3pndkFRNEYwVXc4bWlPYndjU3VhZzQ0ZkhLYzV3RUg1NFhuUUE0?=
 =?utf-8?B?SFdEek5zbzlZZDAwVEpjUEtwL2J2VnhFMzN2M3R6UDBTV0FPd2hBbnlzQ21q?=
 =?utf-8?B?S3FKMDhCQnhYd3YrME5NWGV4cWZZbXB6aWlSMXlZbThvUEFJZ1dWSmhFaWlC?=
 =?utf-8?Q?i5rCrNU080NNWDV+ns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUEzcE01elpGQXNYM1pBLzR0alFxOXlEcTRBd2ZtZmgxNXJJMjdsMERUMVRE?=
 =?utf-8?B?bGVCSEw1SHVUZlNJM0pFQ1dOcFErejAxNTNpUFFhTDVCajE0Um0vdjAyOGtj?=
 =?utf-8?B?eGlkdk5NZmNKdUxHcmV1RWYyQUV1MWdTM0tJOUV0K2ZCaU5TTEZBRFA3cjJX?=
 =?utf-8?B?bWVhODhvT3FlMEZ0a29tV0luREVmeTVVdzMrMlcvK3hSdnYrTXkrd0xYSzFT?=
 =?utf-8?B?RkNjbVpua0pNTm5ENnpvUnR6RXU4Tzg1QkJFMURNZGxXNmpXazh5dVRGL0pS?=
 =?utf-8?B?bGdDM1ZlRE1aZWl6UHcxRkorbHhaRVVrbnJsZkIzR21pTnlOUHpBdGJ4K2N2?=
 =?utf-8?B?cmpPUkRScEdUWGxOekY4ekhmK2ZFMTlzSFhDODRjOHRreWVSQ0V6WHVKbUNq?=
 =?utf-8?B?b2FNYklpYUtaM1RxTlFqYWZCZVE3cUZmWEg2RDVOQmcxSXJpNm5WbHcrcEhn?=
 =?utf-8?B?Y05vUHZVaStxdDJoVWxwd0c5cGxwdEhUYVhXSi9XWXJUUlVqYVRHUVIxZ21S?=
 =?utf-8?B?UG5OeloyK2lJajRLVytJVDZwaUs4TjUwaldZbjJOT0U5V2VJVk1RTjdEdTJu?=
 =?utf-8?B?R1hrS2hkby9NdkxOa3luR1l1ckg4TGJrSjFjbTh0dlZ0SFJJSFpNRmRwTlNY?=
 =?utf-8?B?SVRBbXp5M0d4aEtGZkpwcHd0eTI2NlpHS2ZSV0k3RlEremtNQWZLYXg2VUpK?=
 =?utf-8?B?cmk3ZlhxMHJPb1F3VVE4cElEOStJV25Ec2dOMDBmYk13NE5xVytkY1puTTdP?=
 =?utf-8?B?TTMrWEx2VGQ1eWV4alNIb3FyZHlIc3Z4NGxmYTQzSERUVEd5VkFHd0dZT2Jh?=
 =?utf-8?B?OStkQXJZZ1FZeEpSUHZMSzFXSVkyMFZqTDFZbmtLRjdzQzAvYUtURmJmeE5C?=
 =?utf-8?B?Q0E5VGljT3ExKzRRZm1DZXdDWlRnVEY3dExxYUp5SEhHY2xDT0hmbHhHV1Mx?=
 =?utf-8?B?N1BZbDRpVU5ZeVIwT0VBZkVKbFV6bXp5MCs4ekQzemlMTkV3cVlzS3lBLzF6?=
 =?utf-8?B?NFNTZUFYaW9yTmxUZFlzZmRDSzFOUHJQOWVNUk9hSERoRGhEZXFId1Jmd1NO?=
 =?utf-8?B?cnEzVElWZmNkb1lYMGdldkYwRm1EaTYyeGZJdEZBMy9LS2U5TDVIUFh1REhF?=
 =?utf-8?B?RkkxMkh4NmxjSEZnRDBiTE05dzNGOXREZmlJOUl5TlpSRXM1NmNwOTJaVkhK?=
 =?utf-8?B?MFVpZUVVWnlJbC96ZVU0MmNpbHJjZElQUmZrRTcrajU3d2k2NHhPTEo4TG15?=
 =?utf-8?B?V0kyeTIzTEMyOXYxSEpNU0wwUmdHaGVySG1oSU4zaTFDMWlKYXNPVUxLWUk2?=
 =?utf-8?B?bi9WTWhaMXVHSWxBQlRWT0dBYzNLNnIydkhEbm1hNjRUTkZ2ZjlyS3RTSHpU?=
 =?utf-8?B?cDExcUlpenBsYnpYNk15M3JQNmxaZTJkb0JacVkwdktOTUQ1T2RiYlcrTExO?=
 =?utf-8?B?RllybzUvL0FsdDhFUm5MWmZGdGdZU1FWbUYvcWhvS1NTQ0xKQ0VZdmFhU3Vq?=
 =?utf-8?B?c2dKc05QQlJNUFZUYmg2VnlQYW95QitxbnBqMnJUbnNMWDl4dG5iR0V4Z0xk?=
 =?utf-8?B?elozNWc5VXJpaGpGZVl2TkVyR2tGbytWYkRHR3pHTVNHdUE1Qmp2Tm9JRk9Q?=
 =?utf-8?B?MnlQcGd5N1ltaUJDVFNlUmpLcmFWYWU3bDFkMCtVeGZ2b01CNVRJeDVKVG5L?=
 =?utf-8?B?V0hvZkhXL09scUN6UzhjQkZ1RWV3VWZXbWluSDJoYWM3WThwNHI3WE5mTDhM?=
 =?utf-8?B?KzRUeHNIcWwzS1pwSUt5dThNSnA4Wk9ZZnlrZmlMQ3JCUE1DWU42UCs1R2kz?=
 =?utf-8?B?UWd2Uy9Hc1JSV2JOS2VTT1JvWWQxSGt1NVpiVmZGNVExZkFheHhTWnJvRnVH?=
 =?utf-8?B?WjFJaGZYeUtEYXF5dUVMNUUvRlNBTUVuaGFKZUt4bmlYbTBEOVMvRFp1SzdX?=
 =?utf-8?B?OERSQlBqdzVqRUxCWDk5QllBalpSem5GQUJ2aHRZTGJ2NUt1VHgrb3dDOENI?=
 =?utf-8?B?NjFoL3NXRDNjK0lCNlVLcklXQ0Jqa0w3YXBXZGRjZGdXNnFrWWMxSkFhQ3Nn?=
 =?utf-8?B?bGVocmJFUURoUTFuUkZrNG15Y1VUUCtkTzdBdTRoQXRzdXo3RXhMQSsvM0NU?=
 =?utf-8?Q?vzgrzE7qiKtpxZ9E7DctfE2h2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c6007-da12-442f-0ec9-08dcad29be81
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 04:16:38.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhMK2dJkDRCxSmNkat678hPVbfeftzwOCaxkuh4x04CrOZKnU5eOLHcRRXfviwW2ZYtvJFQUPpxop9IYsTNpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992



On 7/26/2024 1:17 AM, Andrew Morton wrote:
> On Thu, 25 Jul 2024 16:26:26 +0530 Shivank Garg <shivankg@amd.com> wrote:
> 
>> The per-node stats in /proc/zoneinfo output are incorrectly inserted
>> between the first populated zone title and its specific stats. This
>> creates confusion while reading or parsing its output.
> 
> I pity anyone who has to write a parser for that mess.

Some userspace parser have faced an issue like this:
https://github.com/prometheus/procfs/issues/386
In the fix commit, they are ignoring per-node stats section.

> 
>> This patch relocates the per-node stats at the beginning for each node,
>> followed by the individual zone statistics. This fix results in a clearer
>> and more consistent output format.
> 
>> Fixes: e2ecc8a79ed4 ("mm, vmstat: print node-based stats in zoneinfo file")
> 
> It's been this way since 2016?  Surely there's a risk of breaking
> existing userspace parsers?

For some of the per-node stats, some application may probe the
/sys/devices/system/node/node*/meminfo (in KB)

There may be a possibility of breaking scripts, but it will make the
output more consistent for future scripts.

Thanks,
Shivank



