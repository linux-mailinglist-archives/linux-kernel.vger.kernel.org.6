Return-Path: <linux-kernel+bounces-193473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621788D2CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59431F27A07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7C15CD64;
	Wed, 29 May 2024 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOO/bRF0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA015B99F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961185; cv=fail; b=M6QTW053qU1gX/WhAPTdrCX6gfK4SFWq2NiVWPvCem6DR3LH8tu4VZQ+Hp36von8poe+aRno8tgEz5Lmv59cSvS9FZ8s2DDZS0a494oApghGULLqrTNGFIaPMzUC4ge6aaJghA1oVS3q6u3IGZXLIcC0fpxOJ9epSI89J/sQdvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961185; c=relaxed/simple;
	bh=0zEvx3ao08q/jTsdWG12ywakqJ80AILr/+OiidOOHJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkSf3ng/GteTnj6vh1iuzJ/HfZtessUYkuEkLh9YxiRcwuPtwgzSORAtqj4vSYrlmV3BDdQfXxDYXwCrY8U/tsVVm6ggCxCn18SySRFHhRwbHlZq6D8DdrocGbaKGNiehKYX33dAIwxS39pePKZJfnkab7tXU2/YQxvbA5YCLS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VOO/bRF0; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfMjXfRqD9t0uETkHvTP/6KasI4if9NH9YyPIzDpW9gxQ5Rb44le43y/ArjRkv8J3Us2xE1+szmPYaS4T/SK3dOhbvJyvRQZviwGpatx7P71v3JXV5W5S4lwJVL1uOI/wG2gJdzfLxGeZcAgAYwQqvIFHM38I/N65go5+JXKVRaaU8osJ0m+dPy3xpHr1zgI9rjaCm7NnS8vVih2jjfFYiHiDOeCObiAelT3HVbszSUaudQEtrwygo7pPxLQghqPFbgF/K5KXhLjPByBH04YXEZ/UgMvnHr6ZOuc+VxPCXKufFlZkUBCAlSV12C+Cmpou06NMSFqrqsCv27g2iyBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPYyGYTkjBIk0DwO1lK5lBbi2Swavo8f+KURsjJdQ2M=;
 b=Fm8Eyw/h+CrnIXlc+DGlNq7+PdkI5uVsmkel3tiLqMcXLRf9sDS5cq/1oVGpOOL0EaSL7udp/izazQAOk15FtSQ4QXk3/HPWK2DOoBMqAWmY4aOb/z4kyRYs0O8ZrT/y3HPLPPMlNRn0OkV3tEvRP5sc5QcCdYkbAg7Im9107tG8XJp8b6PixrsveaNhF2+wJWUXMM7tdSIKwT8cV14N4mV0jgzOSq5+WeFnjQ5WCnONkVleDRtLGRaWW/9Gzt6/9qtfNY+24f2ETVraPgwu6ALuYZfEaamrxFD6nPipqz/RhnrRTRmIxLHKH36DXqT0d5PKvLflpUCn162UbFr2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPYyGYTkjBIk0DwO1lK5lBbi2Swavo8f+KURsjJdQ2M=;
 b=VOO/bRF0rfd2lh6YCBsxS66+1K/MglOrLbBxWWDJpSAZNJisw0aA0TC6RzLLnSo5GYDwV1/S4jqm71htkQig8Ra7zkd14aEqq/yAV5IJo7LHx7XUv776xsH73PPtuM+8shu7eg4DGTKNC5/5Rj5jAKLmNIdnSGcYbrL7KvIPuW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 05:39:41 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb%4]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 05:39:40 +0000
Message-ID: <6c907190-f084-a6b9-ea43-9a6d3dacda05@amd.com>
Date: Wed, 29 May 2024 11:09:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_sched=3a_core=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYTlVMTOKAmSB2YWx1ZXMgZnJvbSBwZW5kaW5n?=
Content-Language: en-US
To: kunyu <kunyu@nfschina.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
 peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com
References: <20240528064532.42532-1-kunyu@nfschina.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240528064532.42532-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e8129c-f1e4-41f4-17bb-08dc7fa1bc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGpWNXh6dVJ3VnRQVWx5aDJwOXRMWGprMVQ5Ky8xejU2aWZzOVVKYTczd01Y?=
 =?utf-8?B?b2xhNGpiWDdnUTZTZVZwNnIrMHJLakd3eWhpMUsxN2o5Z0s0RVNhNXR0Y08z?=
 =?utf-8?B?WkdVaHhLbnowd0J3YTg3MXhCMXd1WC9JdUZLdkczRFJaU2loRHhGMExUWXp3?=
 =?utf-8?B?Nlo5NDZvVVZFQnVLNTRuY1I3d1FoS3Z5QzJKNC85T0hMd2JLOHpicXlBbFRm?=
 =?utf-8?B?VE5yS0lDY0lzVXA4K1Y4YkVWR3Fqd3lEY0JtRVRVL1NmN05BNGpjaGNpQ1pq?=
 =?utf-8?B?OTVsL1lkQ2lGOXF2V3VHYWhRWXlha205MUtoNHFpRWo4NFJHMkI2Ukgxdi9K?=
 =?utf-8?B?WHE2UnprL3B2aWNFZEJIWWhwTTJCMmw1R0c4MmF2WnkxcnZyRmwvODBIZ2JR?=
 =?utf-8?B?S2d3blh2MnZUOXRtYUVHcERSOWY5VXB6OUZ4a0UwczZ5d2kxeXdmbXBuYk1z?=
 =?utf-8?B?MWpYbHMwSS92NTZON0RRZHdESHpmbEhDM05VU3NCdHEyWWEyQk9wdkxDZWVZ?=
 =?utf-8?B?VVh3bUp2OEJwQjlaa25nZmNUMlMvY3JGellDb01ONEM2ODBkeWhTaTFnVzkv?=
 =?utf-8?B?NVIxZDg0Z1VGVDNPdVFjYXBJK3c1WkpFb0Y2dGpTTlNqOFBWNXVPUm15TVNK?=
 =?utf-8?B?V1ZCdXRCV1VnVVR1cmE0SUMxSUZJcHdVTEhraEZxK0VzVzI4eFozNFFyaUZL?=
 =?utf-8?B?YXZuR2ZFc0JnSmkxTDYxSmtYNnlFcjQwQjFWZXFlaEU2c0w1VzYzN0tvcG1W?=
 =?utf-8?B?dTRtdmk1OE9rQVk4cUhhY3RGOE9uT1FQZjdsMUhJUHkxRmNZVkhtT0M0MWF5?=
 =?utf-8?B?b0Q0K0FuVWpRSTBpTU1UZGpBaHM4Qm44RzZNcmwxMU02YnIvZURISkxSYTN3?=
 =?utf-8?B?d2FERks5WXpMVzVxNFJpV3c0S1RGcGVPczV6RnZXUFI4MVFMVjQ2YVRuSnVB?=
 =?utf-8?B?M1JOODk4d0czK2RsYTEyS3Q4K2FtN09hL3VaWUdMcy9QSDFiU3F5VzhXNGlP?=
 =?utf-8?B?Q0RvZVpWejNoTWV1UmxxV05rSzRoS2gyVTBYVW16TU4zOUNTQkppUXk0cFZK?=
 =?utf-8?B?S3hhQ1ZiZHpjSkg2cXFKVW5tYXU3RndHTGhnZG5EVy9lVkhSZWhJU01mdWNC?=
 =?utf-8?B?RkgrelRZOTlmVks0S0VIcHBJb1NzZ0ZuQzRTdSs2aEVxOE5idzVWdHdDNU0z?=
 =?utf-8?B?MmkzTHVodHpsVG5mUDZRYk0rWnpFWm1kQ1U2aTQvTHNTMG1lTFhKWmttempN?=
 =?utf-8?B?K00vUzdEZDVUUG9UcUxtdmYzN3E2L2RnSVAyQjAzY25STzZHS2NhN0E5ZmV3?=
 =?utf-8?B?L0tDeStKR0F6a1FVN3B4MlgvNjRjMkVvRmR3STh5Z1ltOXdDVzc2VXRkVkdK?=
 =?utf-8?B?S3luTUNZR0IrQ2RCdk9jd3puUVVzOXVjUENwek52NmpwUmI4U3JrSEZJbW95?=
 =?utf-8?B?YW1qYmlRV08yaVIyUHBDSHpYWDkwcUFkLzJUWTI5QWdsTW8vbnFvd2wxanRR?=
 =?utf-8?B?Yms5QVVVemVBUTFVV2EvMTgwKzkvQmFoZmFmMHZTeG1NYXFrUjdJdmxqNFBW?=
 =?utf-8?B?M1Vvd3Z6bGV1RVNUZWJHOFlZK0ZqaVAwU1pxMldtczFVaWFmMzhORjBlOEda?=
 =?utf-8?B?K051aGtvTWxENFVHdDZJWjltYzEvSHZ0UDJKMXpVNzZWTk9pdmEzdjlTR2lO?=
 =?utf-8?B?K3JHdVhqWmRLV0l5a2NpL3VWTVJjQTF6UnBWbENQZVova2o5SnRKZlBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUowTXhFVW1qK3IyUWhzMHV4SFNyRHV3clIzdHNRUE1HZ0lsMjBDN3I4Z3Qx?=
 =?utf-8?B?THFPT0FEVW1BT3ROWmhRVlNQLyt0OXZQeW9yakFQNnJnV0UrNTN1WkhFdHEr?=
 =?utf-8?B?dXJJWEsycVdJRkdRMUZLb2E0UEs4RFVKN1pTQlc5N0lNYU1qRlRHNFp3T0tT?=
 =?utf-8?B?M1M0OForWG03ZFF6cURyakdkeURRWHJKb2VubGY1K1AwSitIcVA3RUZuZDl5?=
 =?utf-8?B?akMzSC9BYmJvUEpZNW84L2Zja1N0eU5ISlVnYUErckVuZUlOMWRKSi9NdjY4?=
 =?utf-8?B?cisrdzVlSW0rMTZCL1ovejh6K1Yza1BWNTJJR2NjeHArWFlLejR3dzMvWlpM?=
 =?utf-8?B?YStPZTMrZ3VmYysvN3hKWVZpK0FnZlZtRzlRZzdkekF6YU9Ld3FXTWVkbnZ5?=
 =?utf-8?B?T3doS2tUdE1PbktUOWhRYThoeGsrc0p5UXl0NUVtYitCY3A0WTRDM1lDQ2ox?=
 =?utf-8?B?WGhOUzNKM3UxdlFaNDBRS2VyUkFib3NHZ3hwS3A0TUdWL2FXVHAxRVF5d2p0?=
 =?utf-8?B?TzhmWlhpNkx6cWZhWU1PK000YjNxWUg2Y2kwV25iMzI2NDBiY3VTRzE5RVpD?=
 =?utf-8?B?WktvRE1iRTRrcytud3lvUVoySnorQVJvUVltNGZuS21pL1FCTmR6Zm9HSHNo?=
 =?utf-8?B?YkNMTTNtYWNldGVNTDhiY2s5TjJuQ2tJOXRNTkQ4VGJMUEZuVmxpUjFkZUhL?=
 =?utf-8?B?TzdwZnV1V3BwUm9VYWV6R29IZXVRYnVUOUh4U2w4OVFheTY1UXVhUXNhMW8z?=
 =?utf-8?B?ZndONDdtSENONlRic1RCb2dwcDFVeVlrc3c4Ny9ZRmVzUWxIeW1kVG9vOWhn?=
 =?utf-8?B?RnVBTkFIU2l6a2ZwbSs0emJJb2cxam1NY1pKWmJQM1loQndwSXBlYnN6YVh2?=
 =?utf-8?B?N091bEZ1Y3o3OFdZSHJEdG1KR1p4OEp2aHo4Y1ZQbytGRG5FUXJ4YTNoVnVY?=
 =?utf-8?B?bmhYRjYwUFVTRXlZbExzcnA4MC9panhYWmVHaGlYY3o4UHZkaHV0MzJQVyt1?=
 =?utf-8?B?Rkw4ZFRLaWRadVljSkFuNWhiNVlmclBkVkZNb3ZHVmk3OTM3MTZOWkg2MklQ?=
 =?utf-8?B?MnRER09jSW1pNm5JMlk5aFd1Y0hqUWx3cEQ3S0l3dUIzS25TSTNPT3JFSTFm?=
 =?utf-8?B?d2E0UjFJWjQvUmMxb21BMzdzaDZkeXREL012czNTR3RhR3hyQSs3Q3ppekl1?=
 =?utf-8?B?clRyMjdQVi8yY1M0ZjNNeTlaTWV5ZG9taW92c2NHVWEvWWxGdGJkaFNlQkRz?=
 =?utf-8?B?bmtncGU4UXdBMVlWcCsyS1VDSWRJcjFYeE5uUWk0T1NVK1g4MWcvODJ6YlRR?=
 =?utf-8?B?ZUJ0SlZRL05DVXFmZFFVQ0tCZ1JHYWFBTWx3QjZkQkljOEJOelVPaWlSVFVm?=
 =?utf-8?B?SXdyT0tUZHN3aTNacFl2Q204NCtEUkVNemtxdGVSY3hhNDN0QjFPMFFOMGU3?=
 =?utf-8?B?QjFhWmU1dWlsRDdRM2llRFJqZWNXWXd4VlZiM3NsOGd4bnl0M1B2VElyZjdF?=
 =?utf-8?B?RFNjcHQ3dFM1VVRqdHJZMzRzUUZDcmZhQWs5T1RseXAwQTd5VWpISmh4U2JB?=
 =?utf-8?B?dkROYUJaeHJuVFhsQmN0ZlRWbXIvemtZL2RpSXVsQkFKSUl6RVJqdFREaVR3?=
 =?utf-8?B?dFBPWVU3YTBicTEwYUpsSjVGajlaeXB4ZlFnYi9jOURXckJTdEtSbmh2Y1FD?=
 =?utf-8?B?aWJHQWQ0YjBCTGsrZ2lOUWdYR2djRERyM0wxVGNabW5XeklieDFDdCtKOGtU?=
 =?utf-8?B?VU5xUnJ0R2x2eEVLVVBMS1l0UGcybFBEd0tyZkhWR200MzVoQmt4SU4yc1RM?=
 =?utf-8?B?MjJsaXJ2bHRPVk41eGI0eFFGTW9qNlFjeWhld0hlVXJaU2NyL2U5bHhJZUR5?=
 =?utf-8?B?WUo2b0g0TnA4blRqbkhsZ0Y2cG13bmtZcFhCbmZHMk5xSmtHMkdTSTJvVlYw?=
 =?utf-8?B?UVVIR0MwZ3YxMDdnTVpaY3dGdU8rYm5aWTZFcXFUY05HdWtkRU9aR1VTWmxP?=
 =?utf-8?B?aENSbnd5b3RRS3JNNHNGc3VGcUUzTWo3TlhGL2hHWVdjRkhjSzlQZ3JvQ2FD?=
 =?utf-8?B?SFdyRzVoNllJWkE3Y3kyQnZhSEtsaU1kUVlsU3dORTVxcUkwejY2dklGRy9V?=
 =?utf-8?Q?UFucn9jfbHuyrs9jqxcbocT3Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e8129c-f1e4-41f4-17bb-08dc7fa1bc29
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 05:39:40.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBRyJPqlt8D7pr24S4DI7OqcL3Nc1s7nDrGfLEQPtXYg84ByqLcz1p/Bv+SsY+r0enyCoJ6w8eBrabITUszf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193

Hello Kunyu,

On 5/28/2024 12:15 PM, kunyu wrote:
> pending is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: kunyu <kunyu@nfschina.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bcf2c4cc0522..e32fea8f5830 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2969,7 +2969,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  	__releases(rq->lock)
>  	__releases(p->pi_lock)
>  {
> -	struct set_affinity_pending my_pending = { }, *pending = NULL;
> +	struct set_affinity_pending my_pending = { }, *pending;

Can "pending" here be initialized to "p->migration_pending" and later
be changed to the updated value of "p->migration_pending" for the
SCA_MIGRATE_ENABLE case?

	if (!(flags & SCA_MIGRATE_ENABLE)) {
		/* serialized by p->pi_lock */
		if (!p->migration_pending) {
			...

			/* Update pending to new value of p->migration_pending */
			pending = p->migration_pending = &my_pending;
		} else {
			...
		}
	}
--

Rest of the initial assignments to "pending" can be dropped then.
Thoughts?

>  	bool stop_pending, complete = false;
>  
>  	/* Can the task run on the task's current CPU? If so, we're done */

--
Thanks and Regards,
Prateek

