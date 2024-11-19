Return-Path: <linux-kernel+bounces-414588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47199D2AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E884B2CBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB121D07BE;
	Tue, 19 Nov 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dfhZZYzT"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61036199B9;
	Tue, 19 Nov 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032417; cv=fail; b=qkLki39WxBDP7ot7zbao3wAJbAU5cpxGbuuOoVsDy2sLk/jQQRaL8m4dMBqO7ymvhj9Osl1whHN7u64IDkOp+319HgX0M6AwDzudC8sUDRcQB4Q+s6BxEv70g2zOKGb+hRbdDXzy2MPW0n5soLaInNn3erYseY/AVm1jaP1hy58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032417; c=relaxed/simple;
	bh=sCbdAq+gW1fr2xe3asLQz2OTeuLNFiLGknXeSLiJa8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOaRMVwvQb4mG/Nn7oBOjzGemRXNUXEEKTODhzZF1KlU1fW4nACFy34+aunYhE5Sq0zAJ7Ld/fZm8m4PHuCtGW6lXCUqvbNCgf51M5rUsZ9KgzDjJkN1BfkjxkX99h0zG8KPIXqGe31Ky/MKWOiLBkrHQyQqB3/j2QvNioxOOHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dfhZZYzT; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ7trX8z14CFbKZyim6//mWHKqrDo7Qyq1uh67BWt9WBo2kBmmrUEPiPDAROLEV2cE4TTWoAYzKCkRI52edgUC17Vg7RbpHehG7ToOpC6rAK2PFccguI9tEBYhob9r8+7pil/FO7JxI4foCEQML79j5eyvdDMU1+SuNsV5NvZ9I1Ykyl3aSfozGLRKPrR5KledblzbxtccWW4fQrvArm07C74PiAjwJzdlDcmemXVE/tDFqov7qaTaltnPYAn9BiCnGwJ4h9xSg9HOY6EyZJwVw4QnifhVRuKSazLeHxAtmib1FRij6yRjszy3Ix4nJJy/2cOPoNNdKMUC1eQu0r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/0Ow2woF/v1zj0WhsHe6AmUOqU6QMm4vUTyC8XoUk4=;
 b=qYGZfUH6AXi7gMHQsMukZXLgLPyCZu/idGm+c8z4rfiUvlxcMsbyqdhniTURSeQnOGJ8fz+URQlTwA1wdSTvIaeHOY44Zo+9g25/NZXewdSZGm3Fv1SsDgBbAy1aU5tSMXtPKF8we/0ue5jWaevI9jmEZzePSZmlbn1ePMrRHlm0UAraxfThesE0DkYoeFYRQofDIi0avp8ZvNucPScyLWXiqYsmzO+UqKvLSLmE71CrJBUU4NaOc5d6QtnSAuipGQpLIipQg5RIa7zrenu3Rjg+5yidxWujpF14DrmQvEj6rOinH12ByE61VVcZa6Pij4dXbiBor/g+x2/E/Em39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/0Ow2woF/v1zj0WhsHe6AmUOqU6QMm4vUTyC8XoUk4=;
 b=dfhZZYzTmicKW7PdpQnjNDUcqzNZ8R3IjktW8fJm7XbzUn33q43Zf3YargsDeRAusy3q3Xhll2NxRtysQ8M6EtgPbnqGBj9L72TZOQ/TfRadZiSDuwzdYqlYKbXZWxdPL0UmKcmuTpgdPfs8D7dzMlZXYLo4NlmqdjCLn8tOt4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 16:06:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 16:06:50 +0000
Message-ID: <e02d8687-b5b8-4970-8bd9-ad3ad9549fc0@amd.com>
Date: Tue, 19 Nov 2024 10:06:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] alienware-wmi: Fix module init error handling
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, w_armin@gmx.de
References: <20241119043523.25650-1-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241119043523.25650-1-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:d3::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8c72fb-5096-44a2-0ad7-08dd08b42d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVRyMWx2eE0vaUhHazVQQlNndGtINnYza0luVmxaUHVkOUc4cUVpYnJlb0dK?=
 =?utf-8?B?UWY2YW5XcVk4TUt4TkIrcG9RRGt3RmxpcHBFd0R6MTk4Q0c3bVc2SkJLT1Q5?=
 =?utf-8?B?MVhPTkpnMHNVL1BUNmN0REVTZmc1ZG5MK0FaZ2pGUk55c0xEZGpBZVc4T0o3?=
 =?utf-8?B?ZVBHbzhvYnZhMXZKdmRzTFVrc25HTVNXSGRYOWd0NWE5Q0FBZkwxZk9sVEVZ?=
 =?utf-8?B?RVJFcUtDYUtxeVFXWWxsR1IyWjIvUEFNaTN5eEdBT1BZSFVOTnhQYTVwVWl5?=
 =?utf-8?B?R2dud0RtQUVkYUVyRWpxYm43bjAvZnlQQzQzT0M2N1J5QWI4K3MzZTlQb1BF?=
 =?utf-8?B?MzRBSFVjNnB4VDErSjNpS3MwUUZFQ1IwQ3ZtVWtIRjB1YXJzS2ZlNkliZlVB?=
 =?utf-8?B?UG0rdFNsYm9qL2Z4Ym04UXY4YkxEdGZpVDk0NzBudzhaTXdmZDJTaStaTGpZ?=
 =?utf-8?B?UnRWZzU2NWhDUW9xSE55TXU2T2JkYXpnZnQ2c1J1cWtuTGRYVVZFcU9sNGxm?=
 =?utf-8?B?R24xSE4xb0tyQUhzMkhEWnIzNklucHYxRWJaUWFBY0VYSHg2bXRTYnF5cWVy?=
 =?utf-8?B?ZmVDTk1XQVFvY0l1K3piMlptRmorRitlZllCTUN4dWRXSGp3YWxieW9Cb21W?=
 =?utf-8?B?ZUZNSFN0ejVGdS9YS3pETG54TG5aR1VhNTlQMVNWdkVMOVluRWZiL2MrS2Z6?=
 =?utf-8?B?T0VEZ0RLQ2VhQWpDeFpmRGJrSGxlYnJPVTBWMEZIZ1lsWGZWUU8vd2thMEFU?=
 =?utf-8?B?dnJnbXZVWTR1TzBEcWFxK1IrZkFyU0dJMFBuMlF2QkplZm1ydWxlRUMxcUZY?=
 =?utf-8?B?MjFFcnRpek56Z0VaOUtYR1dyOExsV2RDK3lKaUtXWlp0NlBWcXIvWjIzUHlo?=
 =?utf-8?B?T3o1NlgrdFZ6Skg5RDhSWFF4VlZra2N3Y201NXBReTVGQWFBNWd2bUVZVmJs?=
 =?utf-8?B?YkhtKzBjdnJZejkydnhURExZbUJYYTlTMUh6akI5SzJPUVpyN1h1WXJteUNF?=
 =?utf-8?B?ME84bVRKVGpRV1NVeTE3OWRxRTdtaFVBRmx4bFA3OURxdXhWT3VGL0VVZkV0?=
 =?utf-8?B?SVVoM3NzU0FreDlpUHBQOGNCOXJtNnFxaXowWTk2Rk9MZHAyWkV4c1phVTQ3?=
 =?utf-8?B?TmVneDlBOGxUbGxjMEtxb3Rmc29GNURkNm9OTzVUeEdvY25zNDZvWWVIUmha?=
 =?utf-8?B?T212eUVWRDhJOG4vQjgzQk9KVS96Q2VNd1oya2JYVHovYlpGNnhxOE5BSVlY?=
 =?utf-8?B?T01hamtsOGladEJZQXMwU09ubVpaL3FyeUZVQnFGTTdaci9qcyt2SjUzZ014?=
 =?utf-8?B?VXU1ZmI1bnhndm1Wa2NTcnhLdTBGQ0pqYUhERzFuTFdSSkNuY05CY0xLNmhC?=
 =?utf-8?B?dUFISWdtcm8vejhtcUpTTFBVWGVkWWhraCt2QktmT2pKMmJJSXVkN1pqa1Bw?=
 =?utf-8?B?TGw2YjIveld3WXl4SUJsTkZ4amZIMndFK2dOcmNRUG9oQkJLcnFZSy82UE5Q?=
 =?utf-8?B?SnJjS1pzVnJsSXNHM1lQSjJRa01wQVZXa3NRRERoTjBkM2xPVmIwRnphNWZl?=
 =?utf-8?B?NHJGY20xUzJoYmtybjFUR2E0akJ6K0JhaEF5V25LNlQ4SnBKdXA4ODl6aDBN?=
 =?utf-8?B?UVdKdFZXRHo4ai9tbkd6MGhFTmk4ZGw3OTFtSkswRGprWGZyVFF4aE90L0Fq?=
 =?utf-8?B?M09NOTNRaWdickVScjZmaUVOTHBBNUFuaVhwVkRETjVGWnNISDR6MVlOZjl1?=
 =?utf-8?Q?GbpAfAxwufDJjWvugwLi43Yjlaj7mJjqA4GTBdS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25vRVUyYmdOYlRKQkZiSjhnYUdRK2xmdGwycy9aRWxlaWNoa2FLYnA5YXlR?=
 =?utf-8?B?Zi8vWXRRSUFzMUxtOUg1S00ySDZxS3pCOTk3RU5lS2lkQ0w3YXdSMi9FSGFp?=
 =?utf-8?B?MmhEaVluZjJhSHNSYWEzakJ6Z0hTSDJzL28wTS9vZkF2dEJkbG1MVmJPaWZm?=
 =?utf-8?B?cXBXTW04dGptQTByTmhNTXYxMmJ2MjlYN2VDcjhVZFJTblVhaE5yOG5xdWRy?=
 =?utf-8?B?N1drQmZRS05ZSWFQYWh3dVNaT3VCTGYzb3EwUENZK3JSbjM4U3RqelRmVFZS?=
 =?utf-8?B?QUo3Y3E3QmxqRmJ1dk9mM2lURStkQTJyTm53Rm1uSi9rcHJMQXJQWDhaZ0g4?=
 =?utf-8?B?MFNYYW1IRGZMaHBaRUNKdnZyWVFyVi92UEV4SzFQSmZJSzR2aE9EanQ1YUJN?=
 =?utf-8?B?ZXJJSFRUNnFrYWFoSXdGRzM3YldsUW1WelV3Tlh4Y2xBRERKeWlGQ2N2eG5U?=
 =?utf-8?B?WkROQjRCZjlWSmdka3VZVU5Fd0xJNkZNeGhRSXhpN29IbDhPMlhHMFY0ZWZ5?=
 =?utf-8?B?eHhyNEVlOTlILzBGdm9SMVFJYWtJc1g3am5jeWJsWDBMb3h2SFRIeFZ0aXlv?=
 =?utf-8?B?TGJTSUhzSnpTRmpmTnBXUmdNenNxbVJFMEhkd2owQlRBb2FycDBDMXZMbnU5?=
 =?utf-8?B?ZTFBcHlCTVUxRXJHTFdnUmdoRVhtTVFRbE5rQkF6REFoSkJBVjFaOEhCbXlP?=
 =?utf-8?B?STMxemx0MGpURWhiR0FJWFFFdnhQQjN3Z0Focit1bnZQWm9jc0RuSmtCRzE0?=
 =?utf-8?B?dmtWcVZxNXVGeUVtZmE5QlJGQTFPeDB3cmxSTUhjRDR4NGFRV0s0cTV6T29u?=
 =?utf-8?B?RVRSN2Y3Wm9Rb3NsTHhkV2xHbGNSSW9vUVg4bXRVRS94Rkt5UnAyb24yYTFm?=
 =?utf-8?B?VU1YdnJpay83YUlwbzd4ajhjRDByYmxUY3dCNy9QUE02c2lDUmdmSDlyd2tl?=
 =?utf-8?B?T2NoNlRjY3pSQ2tyeldnN3N0TGNpcW1oV3ZNRm4wUkFDRWtvTjVkNG9lM245?=
 =?utf-8?B?QnlXbjhFdzRXVmxlcDZtcFFSRHJPSFJKdGd1SGY4Z01ObU82eGpJM3NGanV3?=
 =?utf-8?B?YzVBdHpkemt3bmdzeEFJZWx1SzdiREMxZTlQMUN6T1p3RnRNKzFXaDFmVnd1?=
 =?utf-8?B?T0NmQnVIWkRrUW9yNVErTkhkM1NMM0pza041Zk9PRDRULzVTYnNKTklHeWFL?=
 =?utf-8?B?TVdVS3hDUWFMQytteWVUaE1JN2RnTENsa2NRQjRwZW9VWnV3SExDc29pQkF3?=
 =?utf-8?B?UHFRSlN3Zm54cGZLeTVWbXhsSXpYVGVzVEVWNDhWZkJtN0d4eFlLTmJHTEhI?=
 =?utf-8?B?dVdTVXdFblcxUVNWdkxLeUJHcHE3VnJsUzVGc0taUUtvTGQrc2F1ZFozbXly?=
 =?utf-8?B?Y3lxVDFhbHh0dERXbEdxei9UNzB3OEMvZlBodXBKMXV0MHpVRkFvK3BOcEZN?=
 =?utf-8?B?eTlhUjNwOGllSUtZRForVGVVck1YaWJDSk9hS3VjSkduSndUaHp5QmxlWTYx?=
 =?utf-8?B?ZGExNlhzOUtDVUk1alU3WnFJQzFTQ1JOdTV1YkRhOHJsZzVUb05ocll6Y3Iv?=
 =?utf-8?B?eDlpdVl0ZElkS1RxWHpXTXlXdlZkU1JpdDNyYjEyMzNtalVRS3E3V0VtakNN?=
 =?utf-8?B?c1c3ckRRWjM1emdZM0s1Tk9pUit0a1d3bzJBUjNZRHNrRHE2NThrUmU4V1pJ?=
 =?utf-8?B?TjVUTklUZTJsY01rUkJoNHRsZDEwaHRrNThGN3FGczNlcHNaY0lKdTZtd2ox?=
 =?utf-8?B?eDcwbS9TMDU2YUNobVlHSHJTdXFhMTBjZWk1bzR6VzJ3NTNyN0xJZ3VrSmNI?=
 =?utf-8?B?b01tUHNUeUgyYis3a0QrelBTK2dYSHFCZ0R1NEd6RVFpM2Joc1hPa3l6bWZj?=
 =?utf-8?B?aG52dVVjaWNYazBiWkcvNHZFWEFpYTVBM2trNGJrYk1qK3c5dmhXTUZwREhM?=
 =?utf-8?B?V2lZd2pCbjlxeTkrVUZnaGd6a3NRRDRONlYwWkdnbU9vUDBsZzd5eDBPSHEz?=
 =?utf-8?B?a1k0NVFCNlFVViswUTEyUlVHalNxSFBGbklkV3U1SXM4NlJOYTc3ejJiVEhY?=
 =?utf-8?B?QzFSOXlITWFYLy80WDY5eUxjMjhnZ0ZnUHhNdzM1a1orL0RNdGpGbHNRWVB6?=
 =?utf-8?Q?TZmQg2JWI6uY2fbtIBTiu0lDp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8c72fb-5096-44a2-0ad7-08dd08b42d5c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:06:50.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcOP1MkNK1qlrDWHOvgiCix7v6UXKgCgKqoOtD/8gNFrf+X3h/1xvDx33LA6RJjdkNsK0dqtXdTS9/NfUz2EgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111

On 11/18/2024 22:35, Kurt Borja wrote:
> Propagate led_classdev_register return value in case of error.
> Call led_classdev_unregister in case sysfs_create_group fails.
> 
> If alienware_zone_init fails, alienware_zone_exit should not be called
> because the latter unregisters/removes the led class and the sysfs
> group, which may not be registered/created if the former failed
> prematurely.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 980ffc545093..44f1f7b57d0a 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -628,6 +628,7 @@ static int alienware_zone_init(struct platform_device *pdev)
>   	char *name;
>   	struct device_attribute *zone_dev_attrs;
>   	struct attribute **zone_attrs;
> +	int ret;
>   
>   	if (interface == WMAX) {
>   		lighting_control_state = WMAX_RUNNING;
> @@ -675,9 +676,19 @@ static int alienware_zone_init(struct platform_device *pdev)
>   	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
>   	zone_attribute_group.attrs = zone_attrs;
>   
> -	led_classdev_register(&pdev->dev, &global_led);
> +	ret = led_classdev_register(&pdev->dev, &global_led);

How about switching to the devm version of led_classdev_register instead 
so you can keep a simpler cleanup?

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
> +	if (ret < 0)
> +		goto fail_prep_zone_group;
> +
> +	return 0;
>   
> -	return sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
> +fail_prep_zone_group:
> +	led_classdev_unregister(&global_led);
> +	return ret;
>   }
>   
>   static void alienware_zone_exit(struct platform_device *dev)
> @@ -1223,7 +1234,6 @@ static int __init alienware_wmi_init(void)
>   	return 0;
>   
>   fail_prep_zones:
> -	alienware_zone_exit(platform_device);
>   	remove_thermal_profile();
>   fail_prep_thermal_profile:
>   fail_prep_deepsleep:


