Return-Path: <linux-kernel+bounces-303812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FE961559
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F56282CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB71CF2A4;
	Tue, 27 Aug 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tIA8s16Y"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F21925AC;
	Tue, 27 Aug 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779308; cv=fail; b=YbTBrukhIdc1e8138ZT9q5dfUUQIrJzG6y5AeGTmLkVkqOn5Tv+lSN/KT3e5Q4srqFU433GRBGsFNWuadvuiUHuCgU8ysjw44T6xIC7X0PLTTiydTgGYYCg/iXLG5YrBKxPXXE/zmOfUsmK3d4w9vY4rQC5cY26RMUToq8WeZEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779308; c=relaxed/simple;
	bh=r7q7On9DkloRprrdM6h5MomflsiW3GpFSZ4Vz3C7LJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LlS3tdyRcsd+oAOqiQ5t5mJGM0hQ00EadPmO/AirWoCe0BkepGJUNImmTY2sSkYgDvw/7LgiJIV6EOZJIAIrI+kcmcuDU7vYOlFeneujafBLI9tNDpNeov4Qu74+AWWIKqJ+I9Bij5GUkC7FxGT33Vc2bV+6LRBUVbfk887vi+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tIA8s16Y; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJBqeakWJD1cY7wwGZ1Q4Jx+FTtbNGt13CEn81Pd0KoQV8dqim/GPMl60i3DV+qzSDUXEFe7UQZmQEcwRdFt+x9F3CQYmi02OHr+fdfbxITmNXLj089zEa39cmcZW/PNjQtZ0p9YBi3UyilK0r8kHh+8ySMFHon6viPQDGyXLetBo54CTC5pm8g/MXaKNXWEXCS3QYI9uAReJEJLsWghNd9hGAoVc3QLMlNMWI3OH24h3rxetHiwPV9oGO3L3icnThYK7HB9lKsq/yswur0lmTX4H5qC54QUjy6cQrQK6qdL4iRRfV+/Gl1QOTjhZOr3yjD3OVejasSlJ9pooG3D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n97OYKKqsfVGkTD0fdN7vgwDHh9hyEXTNnpF4mDh5U=;
 b=gqCZezEzcTJ+7Jyrm0S9ChCCQqOblel8jC3j17AneL9HqsvSGRMaTqhBreExXtMHMknxHW/g8+A2ULjtukn9g2NxzRMr4uClpg3gD8e8yWpoT9ZLjQZ7FbIZKtoDE4gA58RE7TbViw8jDCed17HOjK5/PsNldbrUXzXCBofNMFHRwcv2cB8Ox+Szl9vFz80ko1Kxi6TJo8nen9ap1a6uPlkCHJ8wp//KsEOGLVgvABxi6KLA9Wxl7s+ABlNknUSnVk55StiaJhpU+CKzMHo2NEdqvnXAu+hvGL2nvjWsvbPmjNM1laukCwWXgNvLmRLT0S+VI88SeWZD8dU/ztiK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n97OYKKqsfVGkTD0fdN7vgwDHh9hyEXTNnpF4mDh5U=;
 b=tIA8s16Y5stKDBc7y8/Al3gmH55rprWJSvQU9MuUyke0VU7xQugi2jKIUgpDxL+VAc7rvf2T1N4l+TCv6E7FFsmozCv097TvEgDNZvRw3MGCEQN9lWrIIvY8y7wjRUrkwaCchkaQTeAR+2TeUf42cXR6905+1wZogqSosBhuG7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:21:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 17:21:42 +0000
Message-ID: <23f89321-5e95-4a27-8d0d-cc9ced28303d@amd.com>
Date: Tue, 27 Aug 2024 12:21:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] MAINTAINERS: Add maintainer entry for AMD Hardware
 Feedback Driver
To: Perry Yuan <perry.yuan@amd.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Borislav.Petkov@amd.com,
 kprateek.nayak@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 bharathprabhu.perdoor@amd.com, poonam.aggrwal@amd.com, Li.Meng@amd.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiaojian.Du@amd.com
References: <cover.1724748733.git.perry.yuan@amd.com>
 <834ba08575d9c183f38927c9b46105d38170a25e.1724748733.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <834ba08575d9c183f38927c9b46105d38170a25e.1724748733.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffd891b-3f54-464a-3647-08dcc6bcb841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDJWQms4TkNCSUtWcTgrbHlrWU5TMStLeklGTzRFenZOSEFyOHAvWTc2YWc3?=
 =?utf-8?B?NVM0U01PWnYvbi91am5jdGtEN1JzWC9YdjJtdlZXalFUcUdoV0tVME5aNDRr?=
 =?utf-8?B?UmpqMXpVQjFwK0V5RTAxUUo1dUJqUW44QXVjVmhBUngyM0lKZFNpWVhjWjZD?=
 =?utf-8?B?NGJicVhvMXVtSVExN3FETDRQRDEzUXhzWDZMN3VOTnFhWk9aazBlWk9LQ1ht?=
 =?utf-8?B?UWNsZ1JUWVB3WWpsZ2Zqc21kcDBsSFcwMFZKbHEzTXk3K3lVUzVZR0kyOHNn?=
 =?utf-8?B?aWdCVVc2ZUZpcXM4SmtlSUlURXl0TUF4R005QlAzSzdwZWZ3amNxZVNEYzdp?=
 =?utf-8?B?VzJFNXF0RDBJZEJldnU1emFSclpjYTQ5MnhqdThTdnNhWTVPNDh0VmRmL01S?=
 =?utf-8?B?NWpMYUgzTkVCamczMEwrQnNyN0lqeW9xZ3djLy9UZ2VNM1d6REgwaW02U0Iy?=
 =?utf-8?B?bkFHYnhRSnJ0UWs3T3loenpDMnQ5NjJnVU13dWZrTU1sd2dQeWFpeTI3REVh?=
 =?utf-8?B?RWg4cXgwaUdUSTcyYUNVd3RJdjJQNVk4R3JUVmFtc1FORGhHd3N4dFY4YWEv?=
 =?utf-8?B?MmVHdVBrTjRKRzVXMzdyUHBVNUZ2SWhXUGJ1dG16L2JTeW5sNS92U0xwZGtI?=
 =?utf-8?B?TXlMT3VpUGI1aElaVk5LVzhzQVk0NmovQVFueU9nT3BpalhuQzZ6ck9DZUkr?=
 =?utf-8?B?WDVLVWI1cFd4dE1QYVA3cHJYWldNUjZmOHJ6NEU4NnJhNE9WeWlhOTRzMmtC?=
 =?utf-8?B?Zk5RZUdGdDdIbkh6YlFmMnpJdzlwbGtET1gwb3BpbkdES3YzWHUzd1A2U3hM?=
 =?utf-8?B?Y1AzR3N1STBOcXFGajFobDBNbUVsK3dPbzJwZ2NVRzBoNVVIUGR0ajBYSVdT?=
 =?utf-8?B?UTkrNEZGcWpvc0tqYVdHZFRwRDhxekhST2xQSVZGemFnbzJHczVEd2lNOW1C?=
 =?utf-8?B?SVlMUVRXa2xxN3lRUzROTmJGM1B4eDJDcDVvZWNhZEhZd1VCd3N0ZTJiNzRh?=
 =?utf-8?B?ZWJhUzY3eC9EWi9EaWVLdGozRVFoQWZYQXNBMnhzbXg4SGVWMXlpaU40cita?=
 =?utf-8?B?V0RLVDN5bnpNZlhhSmcvS2ZFUHM1Zk9UWDRLeTJUR0NKRmU3Z1llWlZKU2Fr?=
 =?utf-8?B?L3o5NDcyZVBKV0Y5NVhSN3Y5c29yNk8vaW9VZDNWaWpRa0kxdjgxaHZQcEky?=
 =?utf-8?B?MnBpSWpoTGFtR0tmN09YS1B3cVAyY1UvTUZ0Z0hRSEpDb2xtMm54UTUrREcz?=
 =?utf-8?B?ZVh1Q3A5T01nc09QbVJCYk1QemoxaW1xOXZXUGttRHdIWWN4M0tCc01yN2h1?=
 =?utf-8?B?eGNHbDNJTG5pcnZINmtFdkVNNEVkZ0tmekpHd1VQNDNsMzRtRXZ1anNBK2xP?=
 =?utf-8?B?Y2lvNmNDWG9xMDV1Rm1BY1oxZXJXY3VsQkhHRDNJZW50UHFvM3Q2TnJHVTgx?=
 =?utf-8?B?L3gxdCtWQW1zMnBjNGhuUERwbkRoa0p5YjRya1FEY25aVXJ5Z0I5N2VtVnJG?=
 =?utf-8?B?OVVzcVRaWlRHS0ROL0w1K1N2amZQRjdja1hsN2JtVnB3MFFyUmwxdExmOWpT?=
 =?utf-8?B?SmJ4L0E0ejdRd2JONndyTm1zT0NmMUV2ZS92MEs0Mjh1UmZtSC9zVGo1eWdL?=
 =?utf-8?B?dHFzNEE3V28xcmtyekFheS9yRDQ5Y0hHQWwvRVFscjVnRzZsMXlDSU1BcmJt?=
 =?utf-8?B?YVBVclNBbTBOb0FzMzVNdlc2REdibUtyTlQxc3J4OGljTzZIN3NRYko0ZnRo?=
 =?utf-8?Q?lngAUbyKcQ9fZSRElY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGhEczFMTjN0Ty82KzRoS2M4bkZqOTdNMUhDQnFxbUI4eGNiSmlOajdUQ2k1?=
 =?utf-8?B?Y085ZVY0azhvWnNMZExGWU5TZmJEcVBCZ2NnUlcrM0RnTlgyQnRLRWR2NDdH?=
 =?utf-8?B?azdhU3UyQ3g1SDFVSTc4TVRIc3dTK0llbnM3T29IaEhMdkVPcFdOY1hPcWY5?=
 =?utf-8?B?U1lhTDRDYVRjTGtPQnFKQlFxWkpFblpvTFljMVBianVSYjBqM3lLUXZ1NUx3?=
 =?utf-8?B?bW5jUXhGQmJxR2g4WHZyTVBwWUM3TkNiM0UrUGFvV0g0dzdXekE0SjhlR2pP?=
 =?utf-8?B?WnRnMm9zMnJTNGlyR1lVWFA0Z20vSjBoVkJ5b2s5SE9vNjJ5bVdQNEhlTG1a?=
 =?utf-8?B?ZExWa0RNTWZxWXdtU2JGWGdHY1hJWnptaG5lRzc5eFhuc1VFOHFialQvRGxa?=
 =?utf-8?B?Q3VudmNGMW1ud1VmNHhwK3VONFA2dXJjdmZRZGZTM0hJVGp5WDBEN2V6NHZT?=
 =?utf-8?B?VEFVVVdXZE9mdGs3ZXNRM3ZxamdBeFc0VVRyQ29JYm9UeS9ieUhKcUxwdWRy?=
 =?utf-8?B?TzhENCtPejNCd3VDTjNXdUljYXBncmhkSXo4c0VkcDUway8wNk92S2phdm9M?=
 =?utf-8?B?cTJjV3Z5blNzdG1jeU1pbHhTcTJLVldaMWNSN2FVQjNTUEY2NllmeE4yN2Nl?=
 =?utf-8?B?bU1kaCtLTWRvcTFrdHlnV3VORzVFT2tyWXQvN0FWMENZcDRoNjFKdEU0NWtF?=
 =?utf-8?B?Nk5tS05Sbjduc0ZoQnFUWnpOb2lkajJMOGhhZUU1RVM4N2lRM0daWW1mV0pM?=
 =?utf-8?B?bWU3QmNDSVIrc2pvMzBwVnFaY3hEMVVRM3VpK3pvVTJxWFNxSVRGQmJFMEU3?=
 =?utf-8?B?N2J0aVhhcUhpdXNURmd6eVp1QVZrVmpmdnpaclhHbSt1U21vSU9IcHRvczRz?=
 =?utf-8?B?S0xqeGFpUjYzKzNGWXRwemNPUWh0Vk5lNUV3ZjY5LzZhbnJIdDRnR1BjSkZk?=
 =?utf-8?B?MjlYcnpkZHJwL2Z2S1phT21LdkU4cmhRVTZFWWZ0emNPam5mblRObk5XV3Q3?=
 =?utf-8?B?bldEZmV2bWtjdENiVGpHU1ovbHl4QllSUFBrSTVhR3drVlQxZVN4MGo4ZWVJ?=
 =?utf-8?B?V2IraDB0TXFBMmtJRTdtY3Q1VndRZWRuM1JjNzVpaFZwZ0laVkFoUVdMczVo?=
 =?utf-8?B?WHVsMS9mN0NVR09JSWQ5NlB0VW4zaS9BcWE3Z1d0UEdwZTJNbXRvL3B0b1F0?=
 =?utf-8?B?ZTVoTmJzNWhRWkRvNFV4UXd2NFB2QWw3M1VaOFpwdGdmTlYwNjltZ3k0Z2Ir?=
 =?utf-8?B?R1NJN2dPUDBiTmRBRjd4a2xnMnNDOW1rOUI2RDdPK2VlZUtja3BzNllGMWF2?=
 =?utf-8?B?SGpsc1huK1dONHM5OU93Q252N1lTTlRFdFAraDlBbldOR2tvckVCR1hicVFX?=
 =?utf-8?B?YWU0cDlWSmVsU1hUUFREOWRrSU03bEhQQUdMYkJRV1BpYng2bElpYUFvckpq?=
 =?utf-8?B?ZGpnQ1JHczJ0UmRtbHR0MVlhZll5NnlpaGhlMGNwazZGOHdUTk9EMTg3R01E?=
 =?utf-8?B?aHk0dC9RbWlqUXlUOE1HQisxLzVuOXRxWmY0cWhFa2FkUVhTYTIxUFl3cXNC?=
 =?utf-8?B?Z2RHSXhiVFJUVmRqODlqSDFaYWhjSVB4bDIzKzdoV0JQNTJhR09uL202TzhQ?=
 =?utf-8?B?YTJrSitwcllGSDJzMXpQRWxLREJ3VmErdVRWQnpBZndJbW9wRHcvQkh5NGZ5?=
 =?utf-8?B?enh3aTRKT3Y0RmdZOCswQjZ2cy90anEzbnVVeldVczFZaUNpUEkvYnRFR0tP?=
 =?utf-8?B?aDJqQkdTVURRdzAraVJsMzJPdjQyTzNjL21TZGhXZDlPNmU5MkxGYm1QT0lE?=
 =?utf-8?B?M1VSbTJ6NnJ2UEpSN05qMlBQOUZQNkN1dlZUZG9HTndUWVRPZGxmMlFQcUJV?=
 =?utf-8?B?UCtRRVpRZTAxd01hZ1FFZUhwTXpjaWljT1h4Vm8zOUZONGlhQ2tueGNqRVgw?=
 =?utf-8?B?NnVINlZPc2oxRjc1OGtydUF4aDI1bVY3Q1Z1R2JpbkVNVGhhcGlmMmsyM3Vw?=
 =?utf-8?B?bmZ1UUxUZDZPVWhFTFNpd0pNY1NFdUVhRGpSZFl2c2xNT1NqS0NrSlRPWk5V?=
 =?utf-8?B?MjNPbGdSdmRySmhHcHAwNEU2TkZKM29lQlI5ODNKYzRTVjhuRnhrbFpLd2M0?=
 =?utf-8?Q?D8pNl1RXFtc+ndo5+LVHo7zxy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd891b-3f54-464a-3647-08dcc6bcb841
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:21:42.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V7Mkq6pC9vsbMpM1RPbuz+Y8yfonFq5jjjOjeMRgj11Kgv85Br8KPKX9NmJbbsUYWoBZc7qDRBj46DP397O6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

On 8/27/2024 04:36, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce the `amd_hfi` driver into the MAINTAINERS file.
> The driver will support AMD Heterogeneous Core design which provides
> hardware feedback to the OS scheduler.
> 
> Moving forward, Perry and Mario will be responsible for the maintenance
> and review of patches related to this driver.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03090276a416..3ccc782095f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1039,6 +1039,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
>   F:	arch/x86/include/uapi/asm/amd_hsmp.h
>   F:	drivers/platform/x86/amd/hsmp.c
>   
> +AMD HETERO CORE HARDWARE FEEDBACK DRIVER
> +M:	Perry Yuan <perry.yuan@amd.com>
> +M:	Mario Limonciello <mario.limonciello@amd.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +B:	https://gitlab.freedesktop.org/drm/amd/-/issues
> +F:	drivers/platform/x86/amd/hfi/
> +F:	Documentation/arch/x86/amd-hfi.rst
> +
>   AMD IOMMU (AMD-VI)
>   M:	Joerg Roedel <joro@8bytes.org>
>   R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>


