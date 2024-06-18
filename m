Return-Path: <linux-kernel+bounces-220193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624D90DDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B879281FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C22176AD2;
	Tue, 18 Jun 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kzBsWcJa"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82981741FC;
	Tue, 18 Jun 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744570; cv=fail; b=Gge/4bo+1RKGX/vTD657xaIhdeAbMciUVpXWOckYUTGYCmIP8dbRvOijE8LYzxNCFgJdTLGdL5fsBc+/2sioBQkeezV3DOo6MVx+Vy+UZUgoc/Re0NZG3XfcfE3BuIhmDoSSqg4v7Qe0S4EE6D/Xj74liXiJVBor7DC92+obAI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744570; c=relaxed/simple;
	bh=6+4kXQxDluVmecmUviZNRZJr7AEJoZeux99HSuVhcwM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgsyEranFvJiQkbHzV+UXQz+zz8fRKmTMLapWrF6cdO7XTRHzG9cQ6knBkvc/+N6/0IbGqB6HFRoD1TdZ2A8P5a6CzFrdMt3Be6a+l4AynBd4UY4K4xafC4sYqLhm+NWLdIMwMqoiZIqvjQR4Z/Aoyr8M5NQI5RHW+m7dD8/Olw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kzBsWcJa; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbNjiSn2/woKUTxCkZ02w9x87DCPHxJPFqp3R49++zDGgt0l6i6CbQTpOYdswZaTnqf+/y6vImQLo4O7JLLo7BgATof1Nu2QHDmDo0cuiL0PIuBgfTe365r5mqian8RMrYuBk1kcTDZm7BFs9Oemrs6gCYnF56DVVgYBSsWvrbsK6CjtjBmDRvVxYwHfgFExXjsFjWjfDT8D5KWDTYOug3huN6BR8dfHsAnMjYPHDzNlKym63iMEHhU+v846t95EqzrahW0Z5utSVQpvHT11Gt0RLgZmqMbz/XWBOuMrrXZzMdJhjtEaQA5eSfSix+6bZs7mhyCdWwoZBW5STzYDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iPmryi904hDPg8VPxhQDF2aey46x/Q0uO6TT5GjVTI=;
 b=f9+nJ2dcDw6ukGOBqI7zpMJXIL7zGjDxZjCIhVkVD+Jd+fJSegfmp749/N6WTVCUa0Z0Hx7hainH/GuAaIb+GC2Eba1kmwuxbZBnG+/Cih0EFWfd8PBKgVHfkKHvhPISvPVxu0QFOEcywBZjnUSXPn1tlgHAJQtTGTXAiEnJprfGjvcjba0zAqzFkp02opzZj8Gm42mlH2PMl6/A3N/XAGF98P2WCC56Q5LYTKzfltB4U/nU2cJHeGECLdS7+HIj6qkKNpXRc0X1fOtNqGVlXElcfbEaGtdzNtLmQVx4eowJuHqIJMpzTw65ScGWELg3VlvxD71fY0R5YTqkshgcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iPmryi904hDPg8VPxhQDF2aey46x/Q0uO6TT5GjVTI=;
 b=kzBsWcJaEmLvNkAm89W1dv+o40PPMEDPwIU26vAGQvXnX2nkKwRm8kJkeE7UOi5A6bOqWOjA01fPNTt9zEk2M5XTzFGYRBEiIju+K+nbuGtIbHiNtQWz70lAO5UPRqQgNWoBLyCwY7D2mf0eHEUrG0BmxJ2xhAIbuAFk7KQhV6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:02:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:02:46 +0000
Message-ID: <f1ba9cbd-c4c5-8685-5928-265bebd280fa@amd.com>
Date: Tue, 18 Jun 2024 16:02:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v4 01/19] x86/resctrl: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <38ecef15c453f5b70c8519ce1a5765f7ddd6a4cd.1716552602.git.babu.moger@amd.com>
 <6c1adfa8-8fb7-419f-9c52-79105cd673a4@intel.com>
Content-Language: en-US
In-Reply-To: <6c1adfa8-8fb7-419f-9c52-79105cd673a4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:806:21::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: fe839cb1-3cbe-4546-7ab0-08dc8fda010b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWFrY3J0ZEc2MXc4b0s1bVFNa3hKbjl4K0hzZ0pXZ0J5UVdqS2d2L09OUnY0?=
 =?utf-8?B?WTZXYU45YTlnazVFZVhjdXBIWnhjVUdEZTZ5dktEREMxamJpem5iSXBjenJN?=
 =?utf-8?B?azZFeWJodDRBV1Y1Z0RVU2RnbU5qRWhxaXRRSWZTSU8zTXQvQXdPUHlKeG1J?=
 =?utf-8?B?Tk9zbmhGZGZ4SHZaeXVzV3l6enNtWWpoK21zZC8vdEZ3SjJYeEZManJmMlVE?=
 =?utf-8?B?ODlSZG1IWmpxLzN0YUN0Y2M0ZS8zOXh3RmREck5NT1Zvb2dmQm1FTkpPUHE1?=
 =?utf-8?B?MVBOVzM1SHkvci9oaVZwNGFsVEFxa3BzdGdYNjhybW93OW96TjhHWHlwYVBy?=
 =?utf-8?B?R0RYZTdDNkpOaVFxMys4a3huTjRraGR1d3RZaFpjL0c5N3U3Mk9pdDZNVW1F?=
 =?utf-8?B?dlEvSFJNL1UxUlhzU1U0TlhQV0dBRUtRVGdId3VjR3Jsa1hGVHhBdUdQRmwv?=
 =?utf-8?B?K2g0MGdnb3cxckV6U0RhVnhjdWZML0xrRys3OU4zK2RZeVNKZnNObFpSOXp5?=
 =?utf-8?B?TkF6RHl3UlFiU0JKVGpTcjU5ZWNtaXY4ZVNZVEJ0RGlMN2lOVlY1cVlKWUNQ?=
 =?utf-8?B?OUxBcGc1MUNtYlJWL28yU0I5QUVSNTc0L2pqelIvWGJ1ZkJTbkg2czR3OTI5?=
 =?utf-8?B?cGU0MStwOFRtc2ZDODU1Qk1PSjJ0SXdVTDlhMUZkZC80UE9pS2RnUDlESHJi?=
 =?utf-8?B?c2gvUjROVE5lMjdhbnRmSDVuTTBZMXpiRWdWSlRQWWRBVnVpbjhLTHFLV21D?=
 =?utf-8?B?M2VScE81K05XVlo1R2dvcUNhdjFJQ0lEeFFBRnBuYW8zU2VGaU5uSlJiaDdm?=
 =?utf-8?B?VExOYW02U3llNXZLUDdnbjhZaUFuYzg5QXpEOUwrdnBmZHlEdERiMGJjcVdG?=
 =?utf-8?B?bExQcHVRMWx6NGZwYkt1UGVMN01yMVlzT1RRZ3dRbHUrQlRhVkoxUm00Tnh5?=
 =?utf-8?B?aWpPTFBFanJhRW1lVjNCeE9ydnQyTVl2RUtDaHVQMFczU2UxL0RPMmhPSG1i?=
 =?utf-8?B?WE0vNVJ6R2tzUEJkTGhpcGw3bXZwMEh0bThKOGR6Z3ViMDllU2RaUWNqWDhq?=
 =?utf-8?B?aDBQU3REMUxUZXlpQWgzZXlkZFQrNS9pZzFJSkx4QUR5MEphRnNNbW91Q2xt?=
 =?utf-8?B?ZDJKSzlHMTlDUTV5MEYrRU92MXlrODloUUJITWFYWDVwaldPNzRZTVh6S1g1?=
 =?utf-8?B?ZHgrcnB6ankwSnUvLzZ5UENDRXROTVRPNi9kRkFhSUlUU0w5V0FvMUxpNjJ3?=
 =?utf-8?B?UnhPMVp2V2ZiUzRzU21WcVNQdVZCOWYzWlZIc2VNWVNnVTBtZEtuU2RMMVVq?=
 =?utf-8?B?U0g4cHVJZXJscmNacG0vTGdGbnQ5RENHaFQzNnI4VWQrbkF1eTFRZzNCNUtJ?=
 =?utf-8?B?TVVDdXJpRy9xeWNiWENoaVZ4WXQvcjRrSUg0MTBxcUVueVRrV0NnQmpxbFgz?=
 =?utf-8?B?amJWUHpBNDVabmpCOSt4R2N6YUtQUzkrWGtIVEhCWWxkZE1CbU8ra2VWakhk?=
 =?utf-8?B?NzBsSDdIZ1pjMTNmVUpZVjNobFVaNElkTnI3ZHBkcXhBdlRnb0xvQmU3eVk4?=
 =?utf-8?B?SklUQ3pCaFhnZlFuOGFWci9yV0hMWXd6MzVCQWpYTkREeE5ZYW1NeWFwWFQ1?=
 =?utf-8?B?Y0w0bzRRdjh1WWdTQmtmOENDV0RYUk1XSElSOWZITHY4eUVTMEp2S2QvK0tv?=
 =?utf-8?B?bXYvaUxsZ1lKcG5pTlZ5OVBHcE90K2cwRitWK2cxWVpVenpCSjUyYk9uVFRF?=
 =?utf-8?Q?59Pxo9CAeYelQBV3MhT/wYueQsQcXeF1NSxKMAD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0JKTkROQXN1KzB4OHB2QkdURnpuRUE2OWc1MlZheGwvb2kvWnp6Z0h5OTVI?=
 =?utf-8?B?YmRrVVNmN1ExODBnREM5QUNuVWttR1FDU2ZqcFUxMFpUS1NDK2dncGRDQkcy?=
 =?utf-8?B?M0kweW55dnptTTNadG5FVlY0Vi9MdUZ4VGJuR1d5QnYzb3NxQ0Yxa2tXR1BX?=
 =?utf-8?B?YktNREhBV21RVi9TVU9KQmZiTGhXMVdXaWpSREpCc3dPNUJkS2pja1p1Umla?=
 =?utf-8?B?UTd6UmlQY0tFVG1CYmZTNDd1Q2daTXZoSXQ0M0gzUWJ5Y3VoTkJPNXB2aXhD?=
 =?utf-8?B?bHJSS1lJTVpaZGhObUY0N2R4eUhFSzNpK3lJdmQyTDBMRHEvUnJiaitaUy8w?=
 =?utf-8?B?M1FlZWR0UHZmdyt1amovNWxDUTFJQ2hPcUNZdmluRjBPSzFaQnY4UVpyUUhp?=
 =?utf-8?B?YzNUU0VqZERPL0Z2SEFSUHdRWDNCVkhOVG9WS3M5eWcwdTNBbnpUVXYrYjRm?=
 =?utf-8?B?NVAybTJVc0pwWmQzdk55T0hVcE5xNk1LcUV4bzNaVnRUWWQva0VwWUlEVytE?=
 =?utf-8?B?dUR2T011TTZ6TlVhT0tBUEZlTndLSHNmY2ozWngwK2JxNFhxU0dLZE1DWjgz?=
 =?utf-8?B?d3dhbERRTGIyVTQ4aldDcWllSG9BdXgwZmF2ZGpJbnJxODdsZzBMNWtFQmNW?=
 =?utf-8?B?YlBMZW8yRTBmeUhmWE5VbGFrTGQxSzcxd3d2dUlwa1RETUVGSFdYR3FwK0VI?=
 =?utf-8?B?QTVJNGpUSnpZOUJDSVA4U0RJQ1BubjQ3NDlsTlNzaU9EVlJrS2ZhamZiVy9h?=
 =?utf-8?B?YzRLZnlMaW4zaVRlZCtDL3ZrOFE1UTBnMU5LWHBqdXBaV3p0NGNrdERjZzIz?=
 =?utf-8?B?MUJaeWNMUUc3ZlEzUlJDOGVlN2syWktXWXBWaXpRbFRkZVlQaG5OSXhvdXg4?=
 =?utf-8?B?cGw2SFpMZm5Sck5KdUN4R2FpS09YenlxNmFhN2JQZjdvcGluL1NDV2tOM1N1?=
 =?utf-8?B?NDJhT3dYRXEvVjBJYlNKWGExNThyOGU4dnZKR3N6UWsvVHI3YWdkU3RJRVFX?=
 =?utf-8?B?WXliN2pXbS85cXFXUTFtVHl4RjVLK0VaQUwxeHZVVjc1YlZVbnFFaDVhR0Nx?=
 =?utf-8?B?aDQ2R2pBc0JEc3FRd2oxUHZIRjJjTTdDRDlRbngwM3RTbStCdjFiYnZTUTN6?=
 =?utf-8?B?K29MZ1BtWVRJbGFock5OdFZhVlo0bmhJQjg2OEFmeXlFV2krRFRCWWJ1TVAv?=
 =?utf-8?B?WnhRNjZ0aE5MUCswUkF3eExJTEJYUlhwZENic3BSYmd6WHY3NjBVSHcwNVI4?=
 =?utf-8?B?ejk1YXowWVNhTEZYTXYvVGZHdDNQcXBrRjVjQXJ5R0ZiRmw0ekl2R1kxSWR4?=
 =?utf-8?B?M2QvMFRlelQrTWVkUGwrMko2RFUyVWM5SE5pbURQSEVhR2p0L3crVVBMUXlz?=
 =?utf-8?B?WXFrMnJWZHdGdUhZNGw3VUd2cFBlMWZUNXBoaGVCamJHWjZXQ0VXci9pM0Fy?=
 =?utf-8?B?OGJoNDlDNDE1Tlk3RmxDYnRYdi9HUzR3NWZlRkRqSy9KYzQvKzM3ZVY2eStX?=
 =?utf-8?B?a3Eza2FKNUtnZWlYN1I1Z0k1M2llSVE1MDBHT1NhRFBtZ0lUWENZeXBjT0xY?=
 =?utf-8?B?dDdVQ2s2T3FJcXlKZWZEYm9iNEJtZFI5aTljYzdGY094NWdVQWRBQThER1Z5?=
 =?utf-8?B?VGNVUGErTzhVVy8xWnBNUG9OYW91cWh0SmtUckpxdjVhWE5zWklYbFlVS2Z0?=
 =?utf-8?B?NjBYYlNPZjFLV2lOL1BwbGZQN3l2Y3doWVNDR290MEhrUHRXNFFEQnFRZWtV?=
 =?utf-8?B?amZUcEJXRlRCZFUzVE9yMERGNHd2ZFA4NWxBOThpNDhuVit6NmpaNmVaNlRR?=
 =?utf-8?B?U1BIY3ZZNUgvUFpBOXdkTS9taW0zS3dkN25BRE16ZGtoLzIyR0d3d0UrdCtx?=
 =?utf-8?B?ZE5ML1YyRHNZZmIyU1dQNmN3enJaNmdsYmhvcVJRTGxBUjJHdkpMUFhoOEc3?=
 =?utf-8?B?cFJwc2s2SVpvQjRRZUg3eTVWdzZjQ2o5R3AyODE3dGNURFNyK05nZHFQQVJW?=
 =?utf-8?B?bDBwTURRR0d3WG1XVWJpUTkyblcrR2laODViL2xRTEFzczlTTExYNG9oTkh3?=
 =?utf-8?B?WHB4R25FZWFnTXZac0loTTlDV3JkL0ZLeEJmUS9GeEtBZ1Z0NzdqbFFlbS9Z?=
 =?utf-8?B?WktYaTBUejQyYjVZQldEa3hKU2s0UlZjbnBKclM5OUtNUWpYdjBWK1M2dHZp?=
 =?utf-8?Q?42mKCmRyJ1oA9CAJ/KeO9IHZHmCi4yKLRz93nyoeSzZr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe839cb1-3cbe-4546-7ab0-08dc8fda010b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:02:46.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nWdMB2ZJNnchxxcK5to89A2nLCMKp8XW+cxTqcCAc+AqCCdAXOc6vOk0+A6TYpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360



On 6/13/24 19:54, Reinette Chatre wrote:
> Hi Babu,
> 
> Could you please change shortlog prefix to be "x86/cpufeatures:" to
> make it obvious where this patch is headed?

Sure.
-- 
Thanks
Babu Moger

