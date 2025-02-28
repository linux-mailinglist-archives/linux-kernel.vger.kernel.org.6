Return-Path: <linux-kernel+bounces-539230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6BA4A244
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA4A177E38
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658F17A308;
	Fri, 28 Feb 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vypbazrN"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84E27700B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768984; cv=fail; b=gmMhf0jSnNkh+Pw2SIrwTRiqjwaHZsUcWRLhGKa7IL72CliWiARpDM+lIXRc+MlXExqxl4GoAUjNS3xtUel/7AXS8ox1vM111DscgXb/LvuTGmDXFxcdQ+VohUNgV7M2iofGvgtkfdfCGhD/Q7oSgKOK8SiiAuwEssSjdQAAeQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768984; c=relaxed/simple;
	bh=HJCEBkh0ORn/aHPqBkMYAj2jacE63LBMpbPgOIl1sOE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YnNhFR9qc+4ALNYPoxgE+6q2qRnTOLHam3iBWpB0IbVdfTHK9svhrSxbmz7V9rXbudvdXBMeOFDqRDKY9tIMXiYhuFUH2lMW5hlFPtWsWdFzcDjDAHBvLDLvABDCby+JBzRFeh5VU2iWmjlozeBrvMccSBsE9sEaG5NmH9CsuLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vypbazrN; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkKwTYn/kF4eRRWygMWA8QIzFYAocEKjG6fTXR+9yk45k5ohtHW4hGOrZQyhFJXYjNeSd8WbjTTv8935pwO919czJzyYZkx2VIf9lfL33MqOwZBdHV36cqdqNnbEb+h39eWKyXfBY07FLSmB63GUUsefj0gTJQiXfGn3HE9RGNd/ls97zTMExl2sBAY8TfJsvKp5gs7Zpx1g2/Rp+7tBpFqnAKzHwQOKyZuQNC8E9u09WUG2QBlePsRLpZwqFirfvc1fgp+bwrkhzs1TU9Y2zOeXw8oAaAK5qsJs7w7f6xUsJgnRzTqj7zPIftORg3PhJ2uaq+OfUGlA5jXEMqRLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7Pzj5UoTtMgVXVcp7DAmaXI/L7clZxkVeYwX6bmhOs=;
 b=hgu1gHCC43MYqsbJXbw+hsCMNIobIK1uCjx9bLSDof1tFyTuJPe/zvyWbLqNA5dLQNys0pKOjnWgPArMASnWs3+14aikfFYngFA3KD6hj+w4iPeZ5UorW1DtcXpTjZzSJF9rb3dJGW55lax0vUOo78Z7Q6mFHFe5l8//iMQW4Rg/PTPs7EqWGumdI0nrJ+5YgbOjQGoKnMhQwNQjonXR6Uc4S4//CDVyYGF/7cJjvOzCJNARnPXZ9QNby96egubOLXZXIi8sad4JKw/edsGaUSL4kFsmMwffAAMMpcQpnVV/Lyq8aOuct7ZDFjW4Co9f5B7hZF6FItZICneY2Y9mKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Pzj5UoTtMgVXVcp7DAmaXI/L7clZxkVeYwX6bmhOs=;
 b=vypbazrNkrbtM8LnC8QDt81FNxADf6yAEqEMq+pk7UnEsrSHsSXCfc8itJf/YNh+Jor++KmjTDOeF+Qjir9oaevW4znvD/s8O8OiLG54AICNx7KMsdqSbxuWawR4vJbSmUAYb8CJZ+sxDBiG4EWPZMkXSx2WzT4Terwwz1anyxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 18:56:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 18:56:19 +0000
Message-ID: <d70cdb0b-cf47-42b8-bcce-7c2e74a72d36@amd.com>
Date: Fri, 28 Feb 2025 12:56:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: panel-backlight-quirks: Add Framework 16 panel
To: Mark Dietzer <git@doridian.net>, linux-kernel@vger.kernel.org
References: <1c96811e-4d54-480a-bc09-bcd2999e8e66@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1c96811e-4d54-480a-bc09-bcd2999e8e66@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:6e::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e40def3-9a4a-484b-dc3d-08dd5829961f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGJFNExMWHdnR0YxVkFtOXVTd1Fkci9OSzZwYUdKeGhORlZ0QWFsU2pwK25q?=
 =?utf-8?B?Nk0yT24zcWtpT016U2poVzhNT256SjREYWFGbkQ0K2RhUGZUMTlRTTFCNHZF?=
 =?utf-8?B?V2RialREMTNvblkwcXdPSG1yTmVkMnVobVJWUkptRmxDaTlSdGlFOXd2TU5p?=
 =?utf-8?B?U1JiZTVYVjZSSjc2aDR0bXVONm96MXZjUFB5Uko5bDVrTm9xYmlzczkwVkUr?=
 =?utf-8?B?RC9nWlN2U2RXeVlCY1NBRkRIRE5sUnVQc1cxSnp2S1ZSbFg5SUNCTkpMVmxB?=
 =?utf-8?B?Um56cmtpQWtpQVdEWVBBZkxJbldFdWdjZXlSU1RPOEo0Rkx3OUpick9JMGU0?=
 =?utf-8?B?OHBsWFp0U2pJMHBqQWJxU1lFN0FsaWkxMEpDODRZcXBOV01MNElWbXZxRlEz?=
 =?utf-8?B?cm05dUM0SzYvSFRZbmZURThjNjlxUzVtRlgvajRqaTJkM3ViM1ZKMHNGcGFU?=
 =?utf-8?B?ZGlwYmtlZlUyU0FBbUphandLQmhva1doYkhWTWl3a1VrQTA4czBxbTk0UWMr?=
 =?utf-8?B?c2RuZU1VRWxNWXNWbFJXYkxiVEE0anJtc2FncmNQYmlNdTMzdnRabHJsRE9v?=
 =?utf-8?B?VzVUVTZOdjF5bXYveUFrZGVnaDJlYUJQN2dSZXljWCtkWGN6czRmdUtFQ1pP?=
 =?utf-8?B?QnBPa3JrYU1EWklPZjJuRzBNb3lhVmV3RHhqcHlHdXlPT0dJMzBsVUI0aXV4?=
 =?utf-8?B?NTdJbENySWlBMzFUemg4a3VnYnFNWHVHd1Bma2txUE9xMTEybnd1VVArZnVU?=
 =?utf-8?B?RTdQL0YreHRqaEhZUno2MjB6bTdGU0UxTEFKRnhSVURCdmRSdTFEcWJDODA1?=
 =?utf-8?B?bmFvRVd4RXU5NEkzUjJGOU5Bb0tJWHBrMHorWkY1RTFNT0puTGpkc2pQQzZJ?=
 =?utf-8?B?YmtBQitEWDNjSjdSZXdNMHd6WFRyTHczSlZDL04vOEtoSVYra0toSlpReGkr?=
 =?utf-8?B?azFmR0lJRXMwaGR0RVpKQkNwM3IySXNKTzc2NDR0cnBwQnNDRjJDTS9TTE1p?=
 =?utf-8?B?ZWdyUTliKzRSTlNKa1JMdGpISVAwRlhyeFJCM21ScFhnaVZaMWg5THVWUW80?=
 =?utf-8?B?UktEcGx3aElqMmRCaVhDQmJONmpNaGxzbDJHZmxZYjRqcmRKeDI5eFAxcmkv?=
 =?utf-8?B?dDQ3TXowSHMrTU9XZ3NZclQvcUsrdEVYWEYwNWdQL0hlUW8rZzQ1QWFZaDdn?=
 =?utf-8?B?OXhFZzFuLzUyUGRHK25na1RzemZEUWdHNkl1Wm9Hc3NOOUNzWlpYMDY0dGYv?=
 =?utf-8?B?enhra0N4OEtEM1YxbDk5NUVGQ0I3aHE1RklwVDRGZlR1R2x0ajZkemtXbHJj?=
 =?utf-8?B?VWdyamM0cVpDRit0c1llMmpaUlFieEV3a2NtOWFvVEk5a3Bpd2VyWFFuMUR3?=
 =?utf-8?B?NEh0VTRFUmJqUXI2bS9BZzFFVjg4NmVkRFN3a1R4S3VmNDNwK2VTOVhoaS8v?=
 =?utf-8?B?YlU2b2pXYnBIVkpCazMyckV6U1c2dEZJeHJZMC9BVE93RkNvKzNGSytpb2hh?=
 =?utf-8?B?TWplZlg0MFJxa0xEOXdDVHhnYVlXcmVRN1pLTmVZZ25pZWxRTnR0ZWNVSFlR?=
 =?utf-8?B?WkcvZ21RbW14djhnMHNlN2FkQTVDWVNEVGFGakpyMVpEb1JnL3NMaTBTclZr?=
 =?utf-8?B?M2NZZU45dm5LRG5pbm1yd3ltM1FKdEYzN09rc05FZFl5NnhDVVgzWGpwbGM2?=
 =?utf-8?B?Sk9Lb0xYNWk0WWh2OTBVQjQ4K3pOM2pCV2NNcks1LzFsNjlEVGFaWVB4ai9h?=
 =?utf-8?B?ZTB0Ujc0bldQbEZDUFFyRUtseThwUzZKRzNkZ2JCdWx1a1QrZlRhSjdYek5X?=
 =?utf-8?B?SWxqajlQZEpKY0R2NDVCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTZ6eWxjdHhpVitwVXB1RDNnVzhCTzFkNDdCaHZvS3VqNzZzOE5UTFhabjEw?=
 =?utf-8?B?RXZ1Z3NnK0ViSFVJMEJkajFUWHE2bEJXVEwzQWN4VktTbGc1K09SRTM1V1d4?=
 =?utf-8?B?N0lRTE1qYkRKNFdmWk5uYm1wQkF1KzRKUE5yMVZYUWlwQmNoaWYzS1hyZ1JC?=
 =?utf-8?B?clZ6THg0eGZBWkRnYjhmcC85SXFzOWFCL2JneXNmNFFCeWFhOStDcEsyUWlo?=
 =?utf-8?B?SWI3T2hTNEhleVI1U25GbUVkMVVkUG9HZG5Ka2tNRVhjSVJzQ2JpTzh6MXlv?=
 =?utf-8?B?cXFZekl4QW11MFg2T2M3RXp0dHFKZ0FTWG9vUVNBQ1l6aGhHMENYbFFMUkZ1?=
 =?utf-8?B?L1dhWHpveTRKdnJEU0xVME1veU84NzBKRjZRQTBiRXk4N0Z3dElpcW9HRjcw?=
 =?utf-8?B?SGlhMU1tR2NZU3VtM1Z3eVhudWdhT2pvT3ovS1RUQ1o2L2N2K0FQcExyQ05p?=
 =?utf-8?B?dFZnR2QxS2xadHB0ZmltUkdya3pIS21ybEFvbjZmVzN4UjduNXJJT0w2bmdZ?=
 =?utf-8?B?MG15bzdSLzJCOUhkcW92TzNodDBxeHhOUjZXdzAvM0NpYUQvTEljVU0yQThw?=
 =?utf-8?B?VWJMbSt5d1Evb2M0bXFQVHJBRVpaV1lDT2FxTkNrRmJ0cSs1V2xoWkFJT2x4?=
 =?utf-8?B?Ynh6VERTQ0RjY2M5OWlRbHhzMjZWaFVqcXZHSnBaSityUmZnQisyK0RQZnVC?=
 =?utf-8?B?c25ubU1YbDJXSlFzN2hZS2trS0RMaW1PeXB6Mm1vWis0ZldqTEc1b1pWQlRt?=
 =?utf-8?B?eXQwK1hoYkZkbHVLaHo0R29FTzFxbUJta1k4VzJ4Q2M4YklCZGN4TldMN2xT?=
 =?utf-8?B?TUN4SlVoN3d5d2ZQUzlYdmdpVjJOUHNremZXNFZXLzhhZGVnc3JnVG56cFhv?=
 =?utf-8?B?RmdaT1NwcW9BbXdQNWZEN0lnSnhjeUIycHNkblhvNGtmOGRVOW1XblRrbGF5?=
 =?utf-8?B?QlJSREJtS1lYSjhLL0pJMVRrMXJPamZnNldKeTZmR2NvMUo5M3IyaHhEcHJh?=
 =?utf-8?B?UGZRUEo5a2ZsQkRNWkQ4VjZuS3VmeEdMOVMzbS9XTzMvNFExOFZEWFlSKzhl?=
 =?utf-8?B?UnV3S3lJRzZFdVJCSk1WanM5bEQ1ZWQ1WUlLVmQrWTNTWTBnMHdqcTQ2eFRS?=
 =?utf-8?B?eEVyeVIzaHVwVmVsRjlwMUgzTmxvOWVRM2NiM2RpcGFSeFlXWEw4YXRTUWd3?=
 =?utf-8?B?blVNeFliS1MwNGQ4UFg3MkZ5TzBFWWFqNGlIM09PaXpOYkVJM0NyYjRLbnh2?=
 =?utf-8?B?eUQrRDh1N3dLVi9JbFc0UGlCZEpqUVVPNTE3TkFxYmFxcTB2M0xZdmh5UFg2?=
 =?utf-8?B?QmdOWUxnYlBkTVQxdXB0RkZxUlhnUy9PTmlpMGUwVzkwSFlXa3lhU1ljeHFv?=
 =?utf-8?B?a1dEZWsydjV1UmphTEE0Mm9JLzVXMytVcjJsVnBsWmNWbmtZOG1ocitPVWM4?=
 =?utf-8?B?WlY2U2FtUU82c2pNa01hRnV3YXlSV3M4QnF0bGhLSzNuTDA2Z2hjK0hBbnZH?=
 =?utf-8?B?MlFpLzBiWnZQcUFEVGIxT2JWSXdKZHdGOXRXY0NUUGhhcG9UczZuelRhby9S?=
 =?utf-8?B?aHRFS0dTekRIQ3UxTkpCSitsRXJMS1hXZVpOWEhneG5DaXhUaHY2WlJLMTln?=
 =?utf-8?B?NklCWXJzcDdyOUVHaC9BYnY4NWRJK3VVUTFSTGhSWml5bVpSZStnUXA5MEJ3?=
 =?utf-8?B?TFdnbDhFZG5DdVR2dGxZSk5SaXAyVVE1eFN4elRNWnhhbW53dDhESisvYjFo?=
 =?utf-8?B?Uk5OWlVPdnh0eEx3SGttR2cwQzFraGFLY09xVlpGZjl3cW90bDg2MUhlRUJP?=
 =?utf-8?B?Z3hVRGpYNkFGVUFJOE1mZnIwMGZXMk96YnZvVHhnemhhL0NGWVUvaE5lME5x?=
 =?utf-8?B?d25zclFtTFAwbEhmUVR0Ri9WaUZhdTMxZEJxRUJ3TEEwY0NBQ21ZM0hTc2JE?=
 =?utf-8?B?R0x3RDdFRyt6UitTMUgvTVJkU25rUTVOck83U05Nd3QrZlhITGNYTlVOeHhH?=
 =?utf-8?B?b3RnNkdGSC9MYUIvYlZ1YWRqOTJReVFCWjBSS3dIU1FlUG5rNVR6TEpWcm84?=
 =?utf-8?B?UmtFYnhjMW4xcTFGMzlUY0JiTDFGQTNua2JBT0l3cmNYUnFCRlJBRkRsQXNm?=
 =?utf-8?Q?tgq7ZGRxx+siRgHr2AuiOWdK8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e40def3-9a4a-484b-dc3d-08dd5829961f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:56:19.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5lLv+z49Ayr5AUyskLJanB3Kuyb5xYkTobT44ZZLDf/u2YmRbXb1i9+DppBQqKJXKd0qwZzSILPZoVGIA1zTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

On 2/27/2025 20:40, Mark Dietzer wrote:
> Similarly for the Framework 13 panels already handled in those quirks, the 16 can be helped by the same kind of patch.
> 
> I have run this on my own 16 for multiple months (hard coding the value to 0 before the quirks made it upstream) and it has resulted in a darker minimum brightness (as expected) and no issues.
> 
> The Framework community threads between the 13 and 16 for this improvement are the same one, so user reports in the link below will be mixed and likely more focused on the 13.
> 
> Link: https://community.frame.work/t/solved-even-lower-screen-brightness/25711/60
> 

As an alternative to this patch can you please have a try this patch series?

https://lore.kernel.org/amd-gfx/20250228185145.186319-1-mario.limonciello@amd.com/T/#mfa68d07facf78498776fe12bf64d4dd122d5a4c4

I'm not sure off hand if there is a custom brightness curve on Framework 
16, but if there is the interpolation of the lowest value may get your 
desired outcome without a quirk.

> ---
>   drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index c477d98ade2b..52aa2a7fa63e 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -41,6 +41,14 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
>                  .ident.name = "NE135A1M-NY1",
>                  .min_brightness = 0,
>          },
> +       /* 16 inch panel */
> +       {
> +               .dmi_match.field = DMI_BOARD_VENDOR,
> +               .dmi_match.value = "Framework",
> +               .ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
> +               .ident.name = "NE160QDM-NZ6",
> +               .min_brightness = 0,
> +       },
>   };
> 
>   static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
> --
> 2.48.1
> 


