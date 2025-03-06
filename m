Return-Path: <linux-kernel+bounces-548216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7736A541D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94367A5ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CC19ADB0;
	Thu,  6 Mar 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cl/17yYn"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DC2F50
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741236558; cv=fail; b=poZmHkl4pgt+qG+6F2/2g+jvDpHYpGaYzICgKEabYdjz9EdDJxj4zQgsAkZETfqwvwq4FUrP5p9VujDqEDEnK7wr8wUT0ZB6+j9Ijw0gSqL9cKbGMq9Fg9FRJOZt2FOvd0RAqCCE46TdfNjjrU2CrUU5kQwFXLySNlo5VtTlPOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741236558; c=relaxed/simple;
	bh=ocAIFiwiUPAYwOntqd4FpEX60hkYsSydmuJInUyZXss=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9v9/o4PfPnjWF/1gd3ODWPKYUZQeF70pLqQRYjWE3St+rks6cjpabLganuuO6jDIpedDP1tbRNfZPsrjVMkqTH3xoCaKvhnc+wCd6PaQ3CUMW5TRV21NvKi69oYz5PXgbtmM8zCelCVPSHk4RQGzEflwONleVPuuektvpENRMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cl/17yYn; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqP86OyEWPsMe23HHP12fBv9aDuUo/OeRJPpiHU8rVQNz6FOQN9Wr/Ug03L7mMCOYfn4TK6wjIqHFbwVvBmiVSJwtPCdhvIEkKoKdeg/ATqUCwNYR9oQLbuJbCTf7huKIDbh6/e5iPXE6MQly8HrYxEiz5moL/6cKVrfcI8mjFY4Y172c2JYiTMuk5tVzTzhOLeY1Yj9BeG0r3ObhEXaMIu/uMcuqDP+vnO3D0px7bifsqybJWPPM3IRdppC6V1R+EDCdxjuAIwFXVLsv9dWbJlbdc5rMZFE+Ebz7mY7hy/Q/GNaT3gFSthacEAdvtOlD1In3RUtQv60jNIemRQXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v8ZGfPVUJssfDbU4lGsI//Hvg1ao0ZfW1BswMSUaLI=;
 b=xX+DS15IpORXCjHUNRvVNJZGLoPgMlN0hPYKk3kcBZwzx054TYZBIFaswu5x1V28UKHR9hUJzFHzHc6dZsPFASR6DowkDhPeCer2/BffGKUfrK/0e5tqxytlHo1M8gF7Ldmw5QB9jtA9hcdwpQvRLsRMM9KDpeyM5yJ4AsBAWaLFqJaWrUgoKS7rfQ4YQ/bQ6RTeZmNNcp61V3+KeyJPLAUkLK2suGUphoyuJFyRMMwpd8ySvFjEkbZNIxm75Y78uOmXcslg+sPlBHQJDgdh32BMk9RqyFvKUZ7QVrylfC1rOA0YdjPhtb4fIEZFCB7G0/h6SPLqMWl5WVDKImU16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v8ZGfPVUJssfDbU4lGsI//Hvg1ao0ZfW1BswMSUaLI=;
 b=cl/17yYnCuvjpFQHTAyyk6u6SUGJCd7LqTqnbo7Ni8mrnS2AL6XPpUs43PWKKHb66nMZSOZtwDSGP5P2KNIn52Syg4uDa7xYDRIE/ymbQLp4czg+aBSW5GrxC09I/Glr8z/t4h7LylVTBy8ryVq622kPRSr+o/vwrjVCVliFAOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 04:49:11 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 04:49:11 +0000
Message-ID: <7bda5c5c-3f2e-496c-b5a0-6f7d9120dacb@amd.com>
Date: Thu, 6 Mar 2025 10:19:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ktest: Fix Test Failures Due to Missing LOG_FILE
 Directories
From: "Jain, Ayush" <ayushjai@amd.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ayush Jain <Ayush.jain3@amd.com>
Cc: warthog9@eaglescrag.net, linux-kernel@vger.kernel.org,
 srikanth.aithal@amd.com, kalpana.shetty@amd.com
References: <20250305041913.1720599-1-Ayush.jain3@amd.com>
 <20250305190159.7c590242@gandalf.local.home>
 <faadd6ad-3b85-4ad3-8d17-acb5e0991a18@amd.com>
Content-Language: en-US
In-Reply-To: <faadd6ad-3b85-4ad3-8d17-acb5e0991a18@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5687302d-5650-4393-5e09-08dd5c6a3c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjZoQWJIM2ZEUTFnUXRkRERkOWRtdjF6bXdCMWo0K3dDcTE3bmR4eUU0cWlJ?=
 =?utf-8?B?RGJHSUEySjgwNnlVTnh5blNrSGpvTXNqSGVCajAyRnVuSnhDWWRET3h0ZlhN?=
 =?utf-8?B?VVppenRoUHZTWFdRbDM4UEU1SjlLL0NnOTNmc0NSYlRkZW1wcFRhT2hCRldE?=
 =?utf-8?B?djVDbjZNTWUvNnAxUWhvaEs1ekRiTnlIRlQ0RVBEa1pvNE9oaEJmckpNTW50?=
 =?utf-8?B?Z2ZQWHN4NUt4MFVIdzI3YXVsVnYzck01OWF2ZDI1UWlCQkZueVMxUFpaa2RN?=
 =?utf-8?B?N1IwSFc2ekZqbjlQMXRaUWp3cmc2bDNkSVJ6REdBN1VqZXZGVWlxcnZFTjNq?=
 =?utf-8?B?VDhMQVFYVFlpaTZKUUR0Z2R3UGI2eTdJZGhvRDhaOThieVl0SWF5QU1WVnp3?=
 =?utf-8?B?bTNXanpzWm00OHQrODJoZklaUWhEWDBFR0RCaVBJZFNqM2xwL2IycENEM3Jy?=
 =?utf-8?B?Nm92N2w3RkpPMjZZZEYxc2FRb2JZdUhWMmtiMGQxMUIyOUlyRTc5cVFpa2V4?=
 =?utf-8?B?a0VEdzhuVlZmeXVvbFVnNVQ0U1liSUxEMzdYSEdUTWdPMzVyUWJHQjl4Z096?=
 =?utf-8?B?UjVWZVo2SGl4UCszYm5ieWNUeGhFalpvQng1MFNpQ01WbHA1eXFabk1wRVZ4?=
 =?utf-8?B?WEc5NkRtNXA5YXhVSGgyWFd0Nk9SVDlyQS9rbE4rR2czcWtWV2hEZUxGb1I2?=
 =?utf-8?B?WGZQSFVnSmlZTHBHY0drT3lJZFFkQnFKcWdnVmsvWStNNWk1d1lXQXVDc0hR?=
 =?utf-8?B?N215OWxJeXAxcTFjL25rWlQ0a0ZLbGN5R243U0xRZnBvNW5KSHdLZWdGakJQ?=
 =?utf-8?B?dkRDbnRBVzFPV3RaZnRPczNaalhnVE9SV2Z2Q2l2ODduT09hbFNZUjkxS05S?=
 =?utf-8?B?bVFubnlqZERNNEpnbWxNd0FoTUYxMWIzVnE5UmJVamtQUVJRVVhhTFJWbG5E?=
 =?utf-8?B?S05qN2VpbG5UeC94cmloRHdvUDNHU0I3Z2RzS1NkQ013SDNzdnJLUWRrY0xx?=
 =?utf-8?B?bS91eGtoVVZvQ0lsUkVSMXBMbnZYN1lJWlBpMEpHNGdrWlB6dzBrSHBHTkgw?=
 =?utf-8?B?ejRNdWl5aUxtc2lHOEd6eVV5enZiRnhhQ0tBK1JrazFvYlRqcHQ4QTFKS1Ex?=
 =?utf-8?B?QVJrTHZVYlhxdjBReUxrRGZ1clRHblpKVUlNZGNoOHluK3E2TDlkaFkxK1c5?=
 =?utf-8?B?MGxPVExReHJGYlFxV2hIanVsSUltaGdzdVFKOURPTWN1eXJhUlZtNnZQVUVh?=
 =?utf-8?B?TndkYlVKakpvcGNtdUl3WXMrMldES3JNaFBHZ0x3SU9ZcEhIbmpSMDVpb1lq?=
 =?utf-8?B?SUxpRWx3YzdXbzVyUk5hc0Z4OWgra0k3Nkx0S2FKenhWQWRPSDNzM0tjVGdz?=
 =?utf-8?B?dW5xWGV0bHp4R0FJYnhyQ28yZTE2dnBFeGx4cmJsemdwRlo5c0NuY1pTT28v?=
 =?utf-8?B?TmdFSkFVY3MzREhzQXorUFd5SWMwZERsZVp2T1hIU2ZUU2tWUk1vaUFrSnJ0?=
 =?utf-8?B?SFNZOGUrUEsxT0IzTW45b2FXRUxuNjlFblpwUXRQMDEvcWFTUlhtSTFuSEZM?=
 =?utf-8?B?SnZ4cmY0cXJLOHZmd2RvZzZwOHNSSmVBcktZNzkvSnFtOU1YUHcwSXVjcHp4?=
 =?utf-8?B?cUtyOVB1QlBHRGs2aHdobUVMMm5nd3diTWlrekkxYUVIbkRmTlA5L0JWZ3VX?=
 =?utf-8?B?ZUxHVmgwWnJ1cXBEMWlCZDY0U3lxU1phSUk4azNISUtYYmRibFJ1TzZpc3c0?=
 =?utf-8?B?eVBORmVBOUlXdGhZZEh5Zk5zV2ZNem0rT3pkNUkwK3E3OTNZc29PL0FWSEZp?=
 =?utf-8?B?akRSRGVUcTdUbHNaaEEyTlNvN3ZRdmVOWGtIckJ4Qlp3SmFic2NyZ0xGMS9O?=
 =?utf-8?Q?XVHcsinc+qjak?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdvT3NmMXoxYTFKZHkvT0pCSXE2UktsTDBlR1NWYzdBNmdPQ0ZZMUJYa3hP?=
 =?utf-8?B?TFZtNTlPQmh3bVRpb1NwR3JpQXd0SHIzeTdWUWx5TzI3WG9UdTRxbUVqdFRR?=
 =?utf-8?B?aUprTlBzYy9RVXV1UjBad3ZKYnlBZ05EalhCZnlGbGRMUG0vZjdFd1lXWGtq?=
 =?utf-8?B?aXk0cm5qRTQ2eEU5VmdjVUVDTEgvaHJsa1dKQ1E0NE51Q21mNFFNREdwQ3pL?=
 =?utf-8?B?U1RjenNhTXpJZ0pBU0NhMWFYbjVjOWRmcE41V3lCNTNlaWZpZmFNM0h6ZUpY?=
 =?utf-8?B?cW9td3NnbFBPVkEyQVR4Mm1FVG04MCsyTEJMQkE4eHVmb2FvblFBOW43UUQ5?=
 =?utf-8?B?REcwcDFGY2xmbDdkZE9EY3FuN0ptTDJZRy9pbEhWeTlCc2o3NjJjQ3U5cEE1?=
 =?utf-8?B?MUR1ejNGbWV6Kzg2V2hYUGN1ZGhKYU43VFNaUGpLZkx3QUFUdUUvb2VnU1hx?=
 =?utf-8?B?YTE3RmRSR1NTaE9HSjg1OVgvc1U5Y09nQkg2eDVsNGtQRUJNc3IwaHJJbWdz?=
 =?utf-8?B?blVhK3l3RG1rODdodmREKy9tTDZiTm8wZFJYTldJSHNFcWNubmp3cklVdEFl?=
 =?utf-8?B?a0htdjUxenk0QXg0WWcrTmVhTVhCU0NnYlA1YnR1QVBLZEQwT3k5Mlk0V29O?=
 =?utf-8?B?eFFRWHV1eXljb2hlQ09ZVXRzUXRxeGlXYXo5UzVsMVdYQ3Q4M2RCcy9Cd3JZ?=
 =?utf-8?B?bVpBWGVNYjZrTUt3RVBZVTlzd2RuakVSb2Z5MmQzVUwwaXlkY05BV1VRdXJI?=
 =?utf-8?B?cnVNcnM5cHVRK0txaU9hSTlwWlJzRzN0MDBYSUYvTFFYbVBHWDluYzJPdlpx?=
 =?utf-8?B?dDcveWlSZS82Q0N0N1YrVy80WHF4a1lzUVJFMFRHeWg4cmdVNHRSTHFZY05v?=
 =?utf-8?B?bHl0U1RHTHlLWFplRHRjTWNrcHNQV1dIUHkyNFh4UUpYREZheXRxRnE0Y2kw?=
 =?utf-8?B?QjNvUXBXUHFRUnZ2Y0dLdmhXWHFneVhadGdYNXNrYWVMSDlyakZCVkdwNnVL?=
 =?utf-8?B?aVFTUlNrSlo1OWQxWXE2UVlROUdBYm9scGc2RmxRNDZZZ3ZVbnlNaHBESHM3?=
 =?utf-8?B?bHFzUG91a0pnSVBjY2JOcU1xTUJGRzViU09QejhGWE5RdlZuczlYN3pmYmsy?=
 =?utf-8?B?dE9HQUFlUTB6OXhoWldSQ0FFSHREZFFsenI0Z0VmRTU2MTJUb3JnWmFwZjVr?=
 =?utf-8?B?b1F6RDM5M1FHbDVvOTUzbmROcGl6ZmswaG9OY2hrNUZpQVJnd1dJU2IySm1u?=
 =?utf-8?B?Ty8zcThjWlBrc2h4TXRTWk5iTER3ZkE4V1N2VkVzTFRrNmd5bktUMWVHMk5z?=
 =?utf-8?B?NlNwOFd0MEhMY3NNejE2TVYzQitEZHk4QU9SNGZPREdSMGwyNWxnUk5ielRa?=
 =?utf-8?B?NzRwQVJXS25pbUZOMWJ2Z3RnRmZyTGpPY0RNNGVOaGNSVlhudWFiMnpZaUZq?=
 =?utf-8?B?d0F5NEVZMnZ2OUlzWXNnbXMvd2pvYTFjTWc5V2JEVTVrUFRGOW1rQjJOdFdX?=
 =?utf-8?B?cHlBMlhXU2VacllKUWVSSUx5bHFlSk9aOFpmdnRzN0JKb3o5b1ZFeVlEVFgr?=
 =?utf-8?B?dlRtNkZsODNsTDRCVWpPRFo5QWJtemdCMmw4T3ZHSkVNWkI2YjR4WXJ3ZHFI?=
 =?utf-8?B?TkhIenNrOVVyQjFIK1VybnFMODlEQys2NmtGTGx0Z1pRdndDa216WXovaGxX?=
 =?utf-8?B?N25VSkR4NW40TVROc1p6OWhuRytXeGRDcVhjMUdpcTlsZTNLd2Y4ODFkV3k4?=
 =?utf-8?B?OGxKTHpUamFBZ1R6elBva1Nnbk05eWYrMXRHaEZJVGhHRlJtajdKRGRSRnlF?=
 =?utf-8?B?MFdUQXplNnpsbXUvRjlhUHJUU0hNelF4VTVNK0xrT0dtVjRoK29RWGxlSFdi?=
 =?utf-8?B?VW1tT2lLY2RlVWJPbFcwb0tFazkrODNGWmptdlZpaGZybC8rcEovaE1nbGhi?=
 =?utf-8?B?L1FUazlUYkk1c1pXazRTbkRMSnh5aktjMkh6TGswblFWRlE0bHA5YzAxTUx5?=
 =?utf-8?B?V1NsQkRwUVMzMkhwM0EzWmFpM29YaGppdHVwQWlFNTRXaDZpN3NPOU96VTlB?=
 =?utf-8?B?YlFMVDJ4TDZhS2IxbmJ1SExRZWNpMTNOMWd1VVVqWVU5NDBtaG1sWEtvbnNl?=
 =?utf-8?Q?jMOwCvO8MWoR3KX0TvJ/XoZGI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5687302d-5650-4393-5e09-08dd5c6a3c78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 04:49:11.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1pkrp5o0JHt4q0AnO/tJFdLe0ZAwYhXB01lQOKR2abRn98QUOxi9PFqGk0Fj+UQOdbkbLEipBb9Ujj0oevvtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216

Hello steven,

On 3/6/2025 8:29 AM, Jain, Ayush wrote:
> Hello steven,
>
> On 3/6/2025 5:31 AM, Steven Rostedt wrote:
>> On Wed, 5 Mar 2025 04:19:13 +0000
>> Ayush Jain <Ayush.jain3@amd.com> wrote:
>>
>>> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
>>> index 8c8da966c641..13b97e6b8459 100755
>>> --- a/tools/testing/ktest/ktest.pl
>>> +++ b/tools/testing/ktest/ktest.pl
>>> @@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
>>>      if ($opt{"CLEAR_LOG"}) {
>>>  	unlink $opt{"LOG_FILE"};
>>>      }
>>> +
>>> +	if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
>>> +	my $dir = $1;
>>> +	if (! -d $dir) {
>>> +	mkpath($dir) or die "Failed to create directories '$dir': $!";
>>> +	print "\nThe log directory $dir did not exist, so it was created.\n";
>>> +	}
>>> +	}
>> Hmm, somehow the indentation is messed up here. Should be:
> Sure, will update it in next version

Just to be clear on my end, you mean 4 space wide tab for indentation here.

- Ayush

>> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
>> index 8c8da966c641..13b97e6b8459 100755
>> --- a/tools/testing/ktest/ktest.pl
>> +++ b/tools/testing/ktest/ktest.pl
>> @@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
>>      if ($opt{"CLEAR_LOG"}) {
>>  	unlink $opt{"LOG_FILE"};
>>      }
>> +
>> +    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
>> +	my $dir = $1;
>> +	if (! -d $dir) {
>> +	    mkpath($dir) or die "Failed to create directories '$dir': $!";
>> +	    print "\nThe log directory $dir did not exist, so it was created.\n";
>> +	}
>> +    }
>>
>> -- Steve
> Regards,
>
> Ayush Jain
>

