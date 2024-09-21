Return-Path: <linux-kernel+bounces-334904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04997DE1F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3331C20ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBFE282F1;
	Sat, 21 Sep 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="npudf3f4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2A1799B
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726941198; cv=fail; b=XouopHIbzLP42NYhANFa/biXT48XuFdgHuiAasz2IHAucHG0WxutMiglAfB9DbusQ/4Rs6GkUfe+CqcybjhYryVm405oPmUqcCwhr+BhVlL51ICt00mKiK5zzpEIibLzq8oZnYsu/AZCL1MECWWbAhquFBywLHgnZY2qb6rZsSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726941198; c=relaxed/simple;
	bh=tABYus2ZVWq5j57lCg20WaPU/mur5FXzT/C3ihk8y6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tCkFd4i/gK9FiHyjUwxYLrdql2Z095g5YUuPWcyOlna0aVUgewGo7txoph+KMaX7OOJ/f/RRfQTpgSuMEZ5mec1Lk7WeHDHn7zw18oH6sKD6BUdDR2cqeZrgPlbCsv5mvM+p81j+6HZPMRLQ1uGWerLXl2tTEj7wTjy/Me4/OLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=npudf3f4; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7A9RMbkgLmhQCc4171c6D6LXpQ71PaCAe2mqyo2+6ONSM6j2LE60kaLAFHbknA7M2ls5YAMBVTS6pzRYcf9dd0b2XVJbnhyjVyNE9OcBXvYPVRfuIuJGuMdRka+IYrfaW11WvhSamTfM55XQN8R9vm3lP0VWlVvhDiyw3Xt+U/8rzaI2ULM92NiT+KFTi7xB7Q0iiCXZ4pKtwDfYXu8MXOVptMocHfFANptnSJ/FTOqtnCd2AI4oOAwq+xX43bvNGGMw2gCHLtNi4eZ0YCvGhGM7E7WPPeBIrz6x/s31MqkaiStYqa5Z/09ZmRAp7tSujy4+2w/ZOg/KrnWuKsPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEjie0fF4ZQUazkEa5ZwtiYbMRtJffysjkQlSDR741w=;
 b=pdzkKZC1UPlQ+KdxwdVBHhk0/w2+VE68s0BF9pTMvj8wWzrmB4TO8a/cVg6ioO7rNsaaKq3VlXtNjxhlkTq4pl/TZF/KTqxAJRSDOiAhTJ0DELr14m/1uhLix2mTMannFduoHvsohceMjBCUFLIk4/HG4iTy8f/E1YIhDi/TPW1QfQOOAA8fb+y+n+8Zk9vGlllT+HN8nk+4Fu7LxaPss907QjVzenuF5VPGB9d26hd7p19f966EhXlukSvCcRcV4hk1YBxcWH3mutEzHWvHimV/UDhlIc+YD1ASxbqziqpo8Np2jv+UUo12VD9taamH2pwfFtGzMpKkP+HunTP8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEjie0fF4ZQUazkEa5ZwtiYbMRtJffysjkQlSDR741w=;
 b=npudf3f4CHrTQe2hhggWRAnQH1nkZnKgtq40FeIa259GxZmKOw/aUcWA3OzSBOj3jMi5+IBT8ZWfEGMOq1JSLpDdjcE39zF/ZtE8uuQutcy4QkZJAyPzpa2XQMHect0F/IkWNXZ1+hlkxwlGviLa/p+zuc0OCZNTGwIsYdGRyxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sat, 21 Sep
 2024 17:53:10 +0000
Received: from CH0PR12MB8486.namprd12.prod.outlook.com
 ([fe80::cfe7:2803:1f0b:a8b4]) by CH0PR12MB8486.namprd12.prod.outlook.com
 ([fe80::cfe7:2803:1f0b:a8b4%4]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 17:53:10 +0000
Message-ID: <96393a13-20c2-434a-9d3d-41c083958732@amd.com>
Date: Sat, 21 Sep 2024 11:53:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: AMDGPU 6.11.0 crash, 6.10.0 git bisect log
To: Bob Gill <gillb5@telus.net>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
 <Zu3-nJ7LpVzoN5Bj@gallifrey> <1ab1991a-382f-4b59-9e07-76a696159631@amd.com>
 <894c29d5-0997-422c-9013-d1a17990b8a0@telus.net>
 <4bbf68fa-6ca2-47a0-9966-6971dabd7a0f@amd.com>
 <609d594a-62e8-44ed-9cc2-585f9bf5ef70@telus.net>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <609d594a-62e8-44ed-9cc2-585f9bf5ef70@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To CH0PR12MB8486.namprd12.prod.outlook.com
 (2603:10b6:610:18a::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8486:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: c45da4de-9bcc-4bb8-1204-08dcda664198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEl4ejB2UkJPSjY0dlFObHRQRmRPOXg1YU1GTlZFTkZ2Z3NMZjhvMm5RVysx?=
 =?utf-8?B?QmpBOEFlWmJSRDArUCtBUWg0cDJKdHdObzVnRmVJd3o0bWNlZzJsTllESHQ3?=
 =?utf-8?B?VTBXdU1WREIzUVRzcVFhdm1WM3BtYmgrZ3J6VFZrYVloTlg1TFBsbWY4OWtq?=
 =?utf-8?B?dStzbTFWdDJha2FyVGRlQjNTcW55K1F4blNYM0ZpL3dMNGg2TDhUMlVlZ2N2?=
 =?utf-8?B?OTdBbXlpUExKSHhvME1RZWg4M0UwWXQvV2NFbC92ZDRHOEpmcFQxU0I2Ujkv?=
 =?utf-8?B?ZWRBM0FiRXlOUEk4eVdxY0h6STkveVNwc3ZmMHJPQ2xOVHErK2pjQ1hmQnlj?=
 =?utf-8?B?VWRBbzl1dDZVZ1VCZDlJSnRjeXdEdStmNGZVTTM4Qjc5ZWgreithYjFDUFVi?=
 =?utf-8?B?SmtFeWgxdGljTytGeHRmT2FWM2t1NEZUZjNoQ3lhL2dWcUJqNnBCU2taT21P?=
 =?utf-8?B?ZWp1MGlxTU90YTZ4TEMxV21HaTl4UERUQjFPZGliQTRyeGIyUEZ4UndJcXEw?=
 =?utf-8?B?UWtXYWpqL3NKSHBJQVM3V25VQlY3eFcvMmFnTXlWalM0ekZPU0FNczNKeEhx?=
 =?utf-8?B?aUlqbWZNVldMNHh3YlB4YUczY0FGKzJQdGJIL0Rmcm5ERENCSFRvRzF3dEJT?=
 =?utf-8?B?a1pHb3luWHFqUCttcm45T1J4OStYbjZjNGY2UnEwT2JKTzA4RGdhRXE4VGtS?=
 =?utf-8?B?dWtmMk1Jd3kyM3J5dmhveGFqd0JQdWxubDJ4cGEwWUxTVU8zNSsvbkI5Vzhr?=
 =?utf-8?B?WE5hUXY0a01JSHhTVENTQTZkcFBzdlpZdmdXbmoxcGNRcnVLQ1pTWnNtTjlq?=
 =?utf-8?B?SEVUaElKb2xCalpoZGVzUnVNVU00MjlDenl4QzJ0ZmNZNkUxeDMvditGN1dX?=
 =?utf-8?B?YUZlcnZKS1pRNTlHMVRTNVRWMmkrekNwRldxWWFmb2J4MXNvcTFMQlAzMTB5?=
 =?utf-8?B?TWxTVFhDcWU3N0EyaC96K3RDWW1URklsMmtrWmV4Q0lkZXA4eW80Ni9wNmd2?=
 =?utf-8?B?a3V6VHRwbFFqdE9JOGlqVXZYUVJJZTNmVlNxQ0ZtN1ZybkQ1b2plWFRnQ1hz?=
 =?utf-8?B?SlFnc1JFS3ByZjNpK09ra3lZQlVLV2N1UGluR3dYNllmZDU2MnAwMHlmK3ND?=
 =?utf-8?B?NUxVUnlFcURhaDJVakZDYjBVajh6eUNwUmhnNUszRmVlL2FKc3B3ZHkyWnkw?=
 =?utf-8?B?T3RmSlI3c3ZGK1JZS3N3N1VKdXp3SGhYeWo2ajA5Ti9HMmVFaFRGK2xvcXNL?=
 =?utf-8?B?Zlg3dnEzV0lIWHpyT2hOSUFZdHJTRVVvVm1WaU1KU1FzQXlmazBobEVSR0Ns?=
 =?utf-8?B?RTNlQkp3Q2Yzd3lSdnc2YUZBYThWeVhFSFZ0RTdJVUZielR2Q1ZxMm40V250?=
 =?utf-8?B?bEt4TENiWE9xOC9FQ0hMNkVnLyswMGlnbHFWT3J3WDVtK24ydC9USnUvUjFV?=
 =?utf-8?B?UGt4RmtaZFdIODNEZU9LNWVFMWIzN2MraDhGSHM2eFYxTE9MREN6NjhBZ3dN?=
 =?utf-8?B?ZlRoMjRxcHpGVEY5WTFJdGtXK25zTmZ2UlB6dldURlBycVpxSTE4UjNaeHY0?=
 =?utf-8?B?WjVwWE5GNWVPT0xhWWY4QVlDNVRzTzdQN2ROYWlKT1Q3ZXA5cTlsdmVEejdn?=
 =?utf-8?B?ck5CckVlN0JlL3lvR3diOHFtaWlMcTN0dVpWdFUrVTRjSUN0QmNFbFVtM2Z2?=
 =?utf-8?B?K2RnbjBqaGFrUlVMTmdHL3MzUGRNdnMrakZCUER4ZWhjRFRGSzRsMjV2M3Z4?=
 =?utf-8?Q?tkHNJu+5zjlsNvhOlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0VpQ1IvaEt4ZG1qSWZMWExDRG5YcWJnRFQyRnlINGRqWEhpTFhyck5lZFQx?=
 =?utf-8?B?MmNUQXhoNnR0QXdLRGhSbFlIY3B5dEVTWTAzQ3pROXlUdHc4cVRHSE9YaWx5?=
 =?utf-8?B?SFlWMnFyODdSRHdHTDF5MEErSnBHWlVYL2FxaHY4WENPUXBSYXE3aElZN1ZO?=
 =?utf-8?B?cjRZQjYwYURXVm5jbzlEYkVpL0h0TXJkQjRFdm1tSjJOUjJYNGdLOWJMam1I?=
 =?utf-8?B?aVNPNmtNUzFsZVNOYlpPYUM5bksrdnRETTdsZU5vVlZjenVGRGlNa0Fjdkhl?=
 =?utf-8?B?b09ONEdmS0VNbzZRRUpDVDI4NFFBU09oTWpzN1NDbDlPdVNXdmN4ZEIrb1I4?=
 =?utf-8?B?YnllQWI1WDM1K1lvaTI4Um8wd0xZaFhrN0trbHlvclpxZ0RKNFRybElvYWNJ?=
 =?utf-8?B?eVlMZUEwY2VHMm5MTEJBa1RMVEVUQVppVFpsZHJXeWdhMmxMWC9KUm8wbkMr?=
 =?utf-8?B?WjlrQ0xWS29sYmpBRUxpUFlZR1ZZN3N6Tm1KV2pqOUIrU3Y1UXpINVlEaFZK?=
 =?utf-8?B?RE1pWEhkK3EzNU16V2JFZXFCY3dYK29Gd2k0clRLMnJPSjJ0K00rVmpYZjVV?=
 =?utf-8?B?MGVNcmp5QUxtZDNwOHBEc0lJRzhVcXdjY0RGUzlQSkhHc09oOE9DVDNweWE3?=
 =?utf-8?B?eWVqUTM4aGI4T1dIclA2UHl1ZnNERmNwMm9oRS8zeSs1d2NMbVRaMi80Vyt0?=
 =?utf-8?B?Z2lMTUY1K1Z1S3M4Z2hIN09xdWIrMFNYa2x6UytKUERpM1ZSb25LMTZheTZ5?=
 =?utf-8?B?Z2NPTGJuN0ZoV3EzaUpqVEdvN3dFWGxWWWlzWXliYUtGTklaZW02dHVzaWFW?=
 =?utf-8?B?ZXlwN3pZUGdFQVN1TzNFQkVINlNhU0E4TURzbmZuM2FibjlYUmtuUTBBSEFZ?=
 =?utf-8?B?YUJYbTdoRk5pSTAwNHMvRzAzaUhGT2h4bWcvMUg4Rms3a1lSbUtGd1NwRVhs?=
 =?utf-8?B?eHpYdUhNWVZQT0N6ZEYrbVBldEMwZ0tld21WL3Jjc3QrK2Z5VmswTlFWdmlF?=
 =?utf-8?B?akgweFRxZzNjWlRpcGlIS0ttM2ZsTUhSL1pTWXpmUHNmMUp6UGJhUmpxclJ4?=
 =?utf-8?B?TDcrcVRGZ0tVaXFnV3FTNE5UOEs5N1JxUDNqUGs1RVZmZlVDWWY0M083d1BU?=
 =?utf-8?B?TlU1aVA1b1A4NlhNakZwcE9kTW91M0NSUmVlU2JBbVlQMmxwM3NHa2U1bWll?=
 =?utf-8?B?aHBGdzZQSGZZSDMzeHEwVmJlcXNjOHg1THJURGxZK09OQURwVlVrcEJVcFZZ?=
 =?utf-8?B?OGZUQllHTjNuRGl3d2JQeGhSeVVOTlczcGNWM1FCQ2dOM2FVNjllaGZLdkhE?=
 =?utf-8?B?NE0wWWZhZVozVVAwMmRmZlA1U3M1bmpJMGxZOHBhUWpBclJNbnVBVW5Qb2dP?=
 =?utf-8?B?YlRwZjE1MCszaFNqVDVkYy9hTEtlYlR1N0hFTGdCRWVRYmRNL2hFczA3NTN0?=
 =?utf-8?B?RWhZcUlFQks3dGVnOVkvYlN4ZUtuSWNFYWhiSCtzVUs1RE4wMDZsV0wrb3Bv?=
 =?utf-8?B?eFNNYXdtblpCLzRxMDB2SFNhYS8vQWZsNHdWalQ2WldOYXBIbVh4d29pYW1x?=
 =?utf-8?B?RjRKbEk5dlZMaElaWTIxWDZZWFMwb1p3VjI4NC8xTkFKc3p4YUc1eGlnK1Vw?=
 =?utf-8?B?N3JZQTB6c25iaVA3Q2NKSVYvcHN2aVRuMHBlcHU0ZEVlNmZtRWIzbyszcDZW?=
 =?utf-8?B?OHd0YmpsZFpTNDh5aVkrbW5MSVROelRLUjJTQnNnelNNdkFBZ3ExeHRpK2pP?=
 =?utf-8?B?K0dXbGo4bms4K21aR0FCVXQzU2Y3YzQrVEp5enJNTUEwTFl6aG4xSDJnazlq?=
 =?utf-8?B?WEduUWphRkxnWU9OQmY2Sk8vZUsrd0JqRThwUXd3ZEJNSVE5M3dFRENhaUkw?=
 =?utf-8?B?cEprTnZFMzZmWHZxVVFBYVo2bmNpcjFwTEZlVmR0cm5FK2FqUWRwRGVVMXE5?=
 =?utf-8?B?T1ZGYXhJUkFPSFA5UzRiYVpVSXRpTWVFTEU1VzFVdmN0bU1ScWt2MEthVDNE?=
 =?utf-8?B?UWN2eEtZdWFYZFRlMmZmV0owOCsrRjl6Q2lQbC9MdVppQ3BOYUt2ckpZYlha?=
 =?utf-8?B?c05lcWRpczVWdDh3SGttVGZZSFEwdVF4MDBWWXZXU3M1V0xKTURIR1lOakRz?=
 =?utf-8?Q?Vk6Oto8jz1yCdDfWgpt20ofwW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45da4de-9bcc-4bb8-1204-08dcda664198
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 17:53:10.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luKZJXNQeMJj3s0rXszkeIj8ee0gL7+eVzfY7YmVAECS1AwY5/3SR/CkiBwn6Jf9M33AH+8nql1NT+dI0+aIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069

There is a fix in amd-staging-drm-next:

3e54e61e5636 drm/amd/display: only trigger BIOS related assert for older 
ASICs

--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -227,7 +227,7 @@ static void init_transmitter_control(struct 
bios_parser *bp)
         uint8_t frev;
         uint8_t crev = 0;

-       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
+       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev) 
&& (bp->base.ctx->dc->ctx->dce_version <= DCN_VERSION_2_0))


It should land in 6.12. See 
https://lore.kernel.org/dri-devel/20240906211008.3072097-1-alexander.deucher@amd.com/T/


On 9/20/24 21:51, Bob Gill wrote:
> So the final change:
> 
> CONFIG_DEBUG_KERNEL_DC=y
> 
> (about line 227) of drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> 
> BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
> 
> with the 6.11.0 kernel,
> 
> and the X server is working OK.
> 
> Thanks,
> 
> Bob
> 
> On 2024-09-20 20:20, Alex Hung wrote:
>>
>>
>> On 2024-09-20 18:20, Bob Gill wrote:
>>> Hi.  Sorry for the late reply.  My config has
>>> CONFIG_DEBUG_KERNEL_DC=y
>>>
>>> I will set it to # CONFIG_DEBUG_KERNEL_DC is not set
>>
>> Hi Bob,
>>
>> It seems the below change in a171cce57792 causes the hang when 
>> CONFIG_DEBUG_KERNEL_DC is set.
>>
>> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
>> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
>> @@ -227,7 +227,8 @@ static void init_transmitter_control(struct 
>> bios_parser *bp)
>>         uint8_t frev;
>>         uint8_t crev = 0;
>>
>> -       BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
>> +       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
>> +               BREAK_TO_DEBUGGER();
>>
>> If you can help confirm thefollowing fix the hang, I will prepare a 
>> revert patch next week:
>>
>> * Set CONFIG_DEBUG_KERNEL_DC and revert the above change, i.e.
>>
>> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
>> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
>> @@ -227,8 +227,7 @@ static void init_transmitter_control(struct 
>> bios_parser *bp)
>>         uint8_t frev;
>>         uint8_t crev = 0;
>>
>> -       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
>> -               BREAK_TO_DEBUGGER();
>> +       BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
>>
>>
>> Thanks a lot
>>
>>>
>>> also,
>>>
>>> cat /var/log/kern.log | grep VBIOS       gives
>>>
>>> Sep 15 11:53:43 freedom kernel: [   16.372684] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 15 13:58:04 freedom kernel: [   16.705182] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 15 14:20:05 freedom kernel: [   17.043288] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 15 14:38:23 freedom kernel: [   16.625105] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 16 09:40:52 freedom kernel: [   16.780135] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 16 09:52:39 freedom kernel: [   15.764412] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 16 14:59:23 freedom kernel: [   16.077181] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 16 19:03:50 freedom kernel: [   16.613359] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 16 19:18:13 freedom kernel: [   15.895630] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 16 22:01:53 freedom kernel: [   15.768717] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 17 09:48:50 freedom kernel: [   15.758361] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 17 10:31:23 freedom kernel: [   15.762467] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 18 09:43:12 freedom kernel: [   16.086531] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 09:32:07 freedom kernel: [   16.034418] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 12:04:46 freedom kernel: [   15.771447] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 13:54:41 freedom kernel: [   15.791940] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 15:37:35 freedom kernel: [   15.749058] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 17:25:04 freedom kernel: [   16.449671] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 19:43:06 freedom kernel: [   16.312367] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 19 21:31:28 freedom kernel: [   15.864131] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 09:12:39 freedom kernel: [   15.764786] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 11:31:36 freedom kernel: [   17.332211] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 13:23:19 freedom kernel: [   15.759616] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 13:45:07 freedom kernel: [   16.557215] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 14:01:17 freedom kernel: [   16.433437] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 14:24:14 freedom kernel: [   15.770057] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 14:47:27 freedom kernel: [   15.725150] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 15:02:31 freedom kernel: [   16.591276] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>> Sep 20 15:19:44 freedom kernel: [   15.863542] amdgpu 0000:04:00.0: 
>>> amdgpu: Fetched VBIOS from ROM BAR
>>>
>>> so not what quite what you were looking for, but when I run cat 
>>> kern.log | grep Failed :
>>>
>>> Sep 15 11:53:43 freedom kernel: [   25.730013] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 15 13:58:04 freedom kernel: [   26.025432] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 15 14:38:23 freedom kernel: [   25.883820] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 16 09:40:52 freedom kernel: [   27.204539] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 16 14:41:22 freedom kernel: [   28.985885] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 16 19:03:50 freedom kernel: [   26.510748] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 17 09:48:50 freedom kernel: [   25.682372] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 17 10:31:23 freedom kernel: [   25.547899] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 18 09:43:12 freedom kernel: [   26.243232] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 19 09:32:07 freedom kernel: [   25.267332] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 19 12:04:46 freedom kernel: [   25.269450] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 19 15:37:35 freedom kernel: [   25.494803] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 19 19:43:06 freedom kernel: [   26.288598] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 20 09:12:39 freedom kernel: [   25.291743] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 20 13:23:19 freedom kernel: [   25.884358] uvcvideo 1-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 20 14:24:14 freedom kernel: [   25.312379] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 20 14:47:27 freedom kernel: [   25.352905] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>> Sep 20 15:19:44 freedom kernel: [   25.297893] uvcvideo 2-5.2:1.1: 
>>> Failed to set UVC probe control : -32 (exp. 26).
>>>
>>>
>>> Hopefully this helps.  Please mail me if you for more information.  I 
>>> have changed my .config and set
>>>
>>> # CONFIG_DEBUG_KERNEL_DC is not set
>>>
>>> I am attempting to build 6.11.0.
>>>
>>> Thanks,
>>>
>>> Bob
>>>
>>>
>>> On 2024-09-20 17:34, Alex Hung wrote:
>>>>
>>>>
>>>> On 2024-09-20 17:00, Dr. David Alan Gilbert wrote:
>>>>> * Bob Gill (gillb5@telus.net) wrote:
>>>>>> Hello.  Kernel 6.11.0 crashes. 6.10.0 builds.  Al Viro and Dr. 
>>>>>> David Alan
>>>>>> Gilbert have been helpful, and asked that I
>>>>>>
>>>>>> post a git bisect log.  The last log step seems odd, but the 
>>>>>> second last
>>>>>> step "Remove useless function call" might be what broke.
>>>>>
>>>>> Thank you for doing this!
>>>>>
>>>>> My reading is that's fine, I think the next one:
>>>>>
>>>>> tree: git bisect bad
>>>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check 
>>>>> and log for
>>>>> function error codes
>>>>>
>>>>> or the one after it is the culprit?
>>>>>
>>>>> Adding the two Alex's from AMD back onto the thread.
>>>>> (Also added the [REGRESSION] marker the notes tell us to add)
>>>>
>>>> The commit triggers debugger in case of in case of errors.
>>>>
>>>> Is the config CONFIG_DEBUG_KERNEL_DC (Enable kgdb break in DC) 
>>>> enabled in .config, i.e. can you check "grep 
>>>> CONFIG_DEBUG_KERNEL_DC .config"?
>>>>
>>>> If so, can you also try to disable it and check whether you can see 
>>>> error messages "Failed to execute VBIOS command table" in kernel log?
>>>>
>>>>>
>>>>>> My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem 
>>>>>> with an AMD
>>>>>> RX 6500XT.  That's the odd combination.
>>>>>>
>>>>>> Thanks in advance,
>>>>>
>>>>> Thanks again for the bisect.
>>>>>
>>>>> Dave
>>>>>
>>>>>> Bob
>>>>>>
>>>>>> Config:  (.config)
>>>>>> /data/kernel/bobtest6.10-64
>>>>>>
>>>>>> Build line: (last command tells me the job is finished)
>>>>>> make menuconfig && make -j $(nproc) && make modules && make 
>>>>>> modules_install
>>>>>> && make install && /data/music/pl.sh
>>>>>>
>>>>>> Rule 1: Do not modify ANYTHING in the source tree
>>>>>>
>>>>>> git bisect start
>>>>>> git bisect bad
>>>>>> git bisect good v6.10
>>>>>>
>>>>>> Bisecting: 11273 revisions left to test after this (roughly 14 steps)
>>>>>> [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of
>>>>>> git://git.kernel.org/pub/scm/virt/kvm/kvm
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0+
>>>>>>
>>>>>> RESULT:  boot 6.10.0+ fails
>>>>>>           screen black for more than 2 minutes,
>>>>>>           (caps lock key unresponsive, reset, power
>>>>>>           buttons on computer case do nothing).  Reset with power 
>>>>>> bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> Bisecting: 5677 revisions left to test after this (roughly 13 steps)
>>>>>> [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0+
>>>>>>
>>>>>> RESULT: boot 6.10.0+ successful
>>>>>> tree: git bisect good
>>>>>> Bisecting: 2855 revisions left to test after this (roughly 12 steps)
>>>>>> [dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 'x86- 
>>>>>> percpu-2024-07-17'
>>>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0+
>>>>>>
>>>>>> RESULT: boot 6.10.0+ fails
>>>>>>          screen black for more than 2 minutes,
>>>>>>          (caps lock key unresponsive, reset, power
>>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> Bisecting: 1478 revisions left to test after this (roughly 11 steps)
>>>>>> [32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL 
>>>>>> state
>>>>>> verification in TBT mode
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>>> tree: git bisect good
>>>>>> Bisecting: 739 revisions left to test after this (roughly 10 steps)
>>>>>> [b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize 
>>>>>> GC IP
>>>>>> v11.5.2
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>>          screen black for more than 2 minutes,
>>>>>>          (caps lock key unresponsive, reset, power
>>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> Bisecting: 369 revisions left to test after this (roughly 9 steps)
>>>>>> [cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase 
>>>>>> autosuspend
>>>>>> delay to 100ms on 40xx
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc1+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc1+ successful
>>>>>> tree: git bisect good
>>>>>> Bisecting: 184 revisions left to test after this (roughly 8 steps)
>>>>>> [0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add
>>>>>> `__counted_by` attribute for flexible arrays
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.9.0-rc5+
>>>>>>
>>>>>> RESULT: boot 6.9.0-rc5+ successful
>>>>>> tree: git bisect good
>>>>>> Bisecting: 92 revisions left to test after this (roughly 7 steps)
>>>>>> [9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use 
>>>>>> periodic
>>>>>> detection for ipx/headless
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>>          screen black for more than 2 minutes,
>>>>>>          (caps lock key unresponsive, reset, power
>>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> Bisecting: 44 revisions left to test after this (roughly 6 steps)
>>>>>> [a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag
>>>>>> 'drm-intel-gt-next-2024-06-12' of
>>>>>> https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>>> tree: git bisect good
>>>>>> Bisecting: 22 revisions left to test after this (roughly 5 steps)
>>>>>> [51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix 
>>>>>> cursor size
>>>>>> issues
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>>> tree: git bisect good
>>>>>> Bisecting: 11 revisions left to test after this (roughly 4 steps)
>>>>>> [871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add 
>>>>>> workaround
>>>>>> to restrict max frac urgent for DPM0
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>>          screen black for more than 2 minutes,
>>>>>>          (caps lock key unresponsive, reset, power
>>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> Bisecting: 5 revisions left to test after this (roughly 3 steps)
>>>>>> [5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check 
>>>>>> HDCP
>>>>>> returned status
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>>          screen black for more than 2 minutes,
>>>>>>          (caps lock key unresponsive, reset, power
>>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> Bisecting: 2 revisions left to test after this (roughly 1 step)
>>>>>> [e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove 
>>>>>> useless
>>>>>> function call
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>>>
>>>>>> tree: git bisect good
>>>>>> [2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check 
>>>>>> and log
>>>>>> for function error codes
>>>>>>
>>>>>> latest kernel:
>>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>>> 6.10.0-rc3+
>>>>>>
>>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>>          screen black for more than 2 minutes,
>>>>>>          (caps lock key unresponsive, reset, power
>>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>>
>>>>>> tree: git bisect bad
>>>>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check 
>>>>>> and log
>>>>>> for function error codes
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>


