Return-Path: <linux-kernel+bounces-208285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC0B902322
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D170F1C20925
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0620D158209;
	Mon, 10 Jun 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yGdMvTAI"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227815746E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027057; cv=fail; b=sy7PfbW71w2S6UUvNFgFgFZAI3zDH1biMsTkHJNZ+/PIAO3oyoAmhvOA1GwUBcKaTTscn8cRv1XWJopfqz8ZHKTUKUUmj2UGxSO9tDboFFqgn6z+X+bXuvfRqYzCnjMrwb8uxQ1KstpmZtwcq5hURHJtOS9xYNO8P0dZIMmriHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027057; c=relaxed/simple;
	bh=HYx2gtF1RooYfqJiQXyag0UnFdRUKAhrzI8wvBoFuhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kk5KAKj6lyieW4WKJ5fKmLDSamwAVkKv/sNiFXpPJTMk0MKIymEyJKMZTtAZ2wBStlmvVp+fuXUlZwRUmedN3XKspnIRjmZ1JeZI1azYFJGYB5/AtQLUkqTS2Jw7RtiyP1hdqJmfVk7OwZNXgegvCOA5BaQnN1I29Y2k10drtpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yGdMvTAI; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz4vlPu1L9MqvtNr/j5S+6tqWo9TAvtJineNVobE+ZslbzkhU4b7DzX2alNUbTzTkSJ0y5BGutDKPWKSiS9L8aisQ7QMtNGkhoJkoEHrIW2TwHxR5f8WRXQDeUkQdfjiV7jX477J5q/N82hjBjYNFw1oE8V/2qwZmt3rDThMLBKXy3VX/KZ7o8CyNI5AC+yTLKAOmB5H8sxkrV2oBxzV+cdBW2pL2+ng0aSQxewac6PJamgRRDC3eInVflcfqr31K60coR5GLqtHje5s4cOCYZAG5/cREUmESRs3rAXhztIYipNtP8TeBS5hclxHkVpInEucy1pZnkNa1lBfAM7MGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccy0qM7x1rnJ+Tk5ZZc3WSsJHUrKWptozJm/HRmCONs=;
 b=Yp6/6h4Jn/uLLpc6G9EU+/sji7uo6DgwbmQ6C0V3rR7ixiZ1H8BRZJFsq+22pEyDf+9wBffTYtO4UUkZ3RVBHJNBkqD45llMYQjFiL9DXn9DHWi/0oxABmHCybI9C9XpstX1+3SFNLgfFDiSx2yeUnM8NC3c4JsJJomSszfE6nr+iXJmwxK6VE3N9euM8tVFd+vOxa54KGfhUdmM1fZ7/X3pNpmQ9XC2mbQP+HuVkvZD7oAzkXtydsJgOijGzZ8/ru6P2A3bTrTaj2h2NfRcEdOZX6+PLza9C5UsuZdIAdVQyfqKKpUGU4AbZ/5tiZtGGicNBlB5o4tyRZaIxE16iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccy0qM7x1rnJ+Tk5ZZc3WSsJHUrKWptozJm/HRmCONs=;
 b=yGdMvTAI4/KPosgSUB6SPLn96vND/BdsAYI0DouXdWDG1XY+T/iSUkBaJcPT7/CY0NpAtRE0KvRFnDcCb4PbSwJmLWF0BrxADo3xdFAirqE4gJSJs/VSqfJDOw5yspsgaLbd7kNEFiAeA/jAIksZYujlCGC0fW3OSQoRBItiv6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 13:44:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 13:44:11 +0000
Message-ID: <682dfa6e-7f81-48cf-920e-14d4f2c46fc1@amd.com>
Date: Mon, 10 Jun 2024 19:14:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
To: David Wang <00107082@163.com>, jsnitsel@redhat.com, joro@8bytes.org,
 suravee.suthikulpanit@amd.com
Cc: baolu.lu@linux.intel.com, jroedel@suse.de, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, sivanich@hpe.com
References: <31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com>
 <20240610131550.53651-1-00107082@163.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240610131550.53651-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 2678a0ae-99e0-4ccf-f5f7-08dc895368d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RZYXN2MC85UnNjbjJtSXFLOFRVbWttTmk3bkdkazlrU2V5UE1CWTBqV3ZT?=
 =?utf-8?B?ajlMN21UbExXdFQ2aUw2c2plaWdZS3V2VTFSNktPVWkrTmtCU3RVVUo2dlpY?=
 =?utf-8?B?M2ovQnVKSkhVNHRJZlB3cVNWS2ZUbWhSaXhOaWtYTkJIR0lvQ0xqRkVFbmlR?=
 =?utf-8?B?M1NmS1l0UkJTaWkxNjFPM1R5dFZYZ3gxNnpYOTV5QnJTbklPSks3UFJjamg0?=
 =?utf-8?B?aWtva2RaZ3ZSZzRWeVRFL1dvQlV6SmFJNTlwWkJWbDFsaURFY28vRG1kbEFE?=
 =?utf-8?B?cEwwT2xTajNtUlducUJGYlcwblRvODU3VWRSbmlyUHhUY1ptbnZwdXRPR2FZ?=
 =?utf-8?B?YUxXZmQ1SXZOcHZyYzJ3ZEFRQmszUDhjUHIwWnFtZlZ0M0YxMWpxcDQ2ZVJY?=
 =?utf-8?B?RjNYRHQ2dUNYQjhFa25ROGRWbW9UR2xsdGFBNXFxSDZyaFdTbWo5alphd0Er?=
 =?utf-8?B?MEhReFp0OGtaRng1ZjVsa05QeG0rTXowenhoazBocW15SFY2T2szYktMb1Av?=
 =?utf-8?B?Ulh1MThsTUtUdFpWamorNE13aGhSd0VCQVJoelUvZWtsWHo1YnUxODIyUC9x?=
 =?utf-8?B?OFNoWW5WWHRpS3Z0N2hPTk5IMWR0cGZyMmh5YUJYVy8ybjMzdUc0Z3lLbVlY?=
 =?utf-8?B?Z1UxT1hveXN4ekJYSk13OXhuWnJJbktqWGpTRGVEWjBVZW9BK1Q1RUlFOWV1?=
 =?utf-8?B?N2p0Sk5Sai9veVhjL2pxL2FPMlhCVEJDUzh6THpYaXI3MnNCUW4vN29sUHp3?=
 =?utf-8?B?YnZ6ckg1Y0NxYlpXeVFGaDVBL2oreUZGa3lmSEdhZXlTaTNCY0ljd1R6aGM3?=
 =?utf-8?B?ZVl2bnk2TWljUDFmcTNkMllONUg5eFFZV04xYW1Zbm1UVWVuNjIwNmZyeG9h?=
 =?utf-8?B?NS9mL2s5YnY3NGIzeWphMnVINEVqQ3VhdnhNblhFa0o3Um1KUkQxSi9XUXlS?=
 =?utf-8?B?d3BwUUJsbm1rRjlZQnlKRW1CanU2Vm5uQ0l3eWdWZlYrQmp1WnNCejBzcWFF?=
 =?utf-8?B?VllTZlhXWHNJRVkvODR2cWRpMWdCeVFWdGdlaEkzdzB3WlJWNFA4YjF1UDFq?=
 =?utf-8?B?UWd2QmNCQXc4VW9TWjZoaDRSVEM1ckE1VG9LTHJXckJSeTlURkRoaytwWk5P?=
 =?utf-8?B?bkloMmtpNGgvU09zSk9VZ2IvTU5PTldBV3RUajRYK0VwMzNOa09lbDg0VVVM?=
 =?utf-8?B?WkV5eVdNOUsveTVVWCtXK2RTeklWdi9GcHVlSE9td0hKWmxiQkdxdUdzN2Rw?=
 =?utf-8?B?aEFFUHgyQmx5UVhVY3cvcjN2K201RVhRcjRKVVJ2VXlmd1pwVkdjeHRwQ1NV?=
 =?utf-8?B?NmljVTdvSVhBdmU0SzRzZmNHdHM2eEg1SDk4aDJZcUR1aHB4MCsrZXNYaU0r?=
 =?utf-8?B?MW1iUmhxTXlKQmhJalVGZnNvaFBIVHU3UXRRMFc5RmVuSXdMOWU3WlpsekFE?=
 =?utf-8?B?SDNLT3RkOE5RdXE5V0Z3RGcwRm1uWTBCL0ZwbjI5emRpSS9vcVBpNlhOS1l5?=
 =?utf-8?B?eXBkOW9pMnA0RFJoeW5UcjhvYWFvYnRJc0FlOXZ6dGhMZ2JNU3RteGU4aFBn?=
 =?utf-8?B?c20vNDZsemF0T05hUHh2MTBhUklWci9TSTE3dGdjeWkyVmFRMjl6d0VVeGRT?=
 =?utf-8?B?eXIyQWRkZHdCc2xZMkpDQ0g0c1YzT1NFNXROVnJYL2QzWktOQXdtKzRxU04r?=
 =?utf-8?B?V01DQStvMFNZb1RQUGZRNzBhWGlaekVVRlJpNDIwOGRjMzZ4anhOZFNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T20zRVhvTzZpOVZFVDJtcXJFR3FxVzZmUng4NWxmZ20yUFN5L2RPVDYwRU0z?=
 =?utf-8?B?cklpWmlwdk1jOXNkK3dSZjFTUzNvdks1SjJyRmU3Wm1qd3pVK2ZlUm5EYnNa?=
 =?utf-8?B?Y3pWVDRWLzhFSjRGSUlQRWE2b2tOOG1GKzA3cFRmUHhjdWNSZjR5VG1MQWlu?=
 =?utf-8?B?TnlaNUJ3VEFGbFMrQ091MTdBK2xDUU1GT0dWUWp3SmcwVm9Gd0IxSG54OU5S?=
 =?utf-8?B?TjBJZXVyVnA2aWw3Ym5TaTlSTkRMTDNya0ozdGJuaWtDRUgrQnR5SGtWYkRW?=
 =?utf-8?B?ekZkV1B0SktNMG0rRThpOWI0WGUzOTFhZGFURUgvUkE5WEt0WEJYeG9MaVVr?=
 =?utf-8?B?MjlSRTM4T3BPcEtUNUNoYzUwQ1FzMUpwS0ViSkxQaWlEbU5nQko5dGZsaFZT?=
 =?utf-8?B?MmtrK1haOVhGbUpidEZEMlk2MXQ0VXh1YVVwRGhNaDVxd054L3c3MjQrOEw0?=
 =?utf-8?B?aGNrRVk5Vm4velkyQ0NwVVhxZ0hucHBSb21OR3M0SXhuN0J3TGNYdlBxVUtV?=
 =?utf-8?B?c3lIdkVZUytsdG16VXlnZUlHM0tuclc2clE3VjJ1dW5BWFZjMUVNYUFSQjc4?=
 =?utf-8?B?dW02Qk9Wa1cySTNsRTVVSWNmT1F5V3h2eUIzVWxob01hNWZIeEZSa1JUekRu?=
 =?utf-8?B?bk9KbGVYOUhpeXJlWUFBMW9wbG4yWEMrVyt3Qlp3UENoUlVHQ2ZhbjlmdFNn?=
 =?utf-8?B?NVZBU1FVR2hQNXpLa013dGNNN3RINElaMGNKVVFnWFR5dVpmYzJVUi9IcFJF?=
 =?utf-8?B?cGFKVUprVFdWcVB0bjkzYXlURDJNaGNpNjVOVDV2Z1cvcjZVOG1XWCt6RHlP?=
 =?utf-8?B?WTBJWWx3dUVLWWF3bE4rSDdMZUlyd0pTeWhSMDZPaklUdWhuNU5BVDNURERL?=
 =?utf-8?B?MEVPdkxOZHpQdzdtUXpzMFg2OTVnVDZ3OVRESnN2MkVmcVFXZVNLbTcrcHVm?=
 =?utf-8?B?Y0dYUmlaNkdSVGhmbjdMdVUzeVpVWHF4WmdUWFhBazh0cWZxVFRFM2pZYTlw?=
 =?utf-8?B?QytnY2dKeS96WkZpQWJmSVZpZVdHMUFFcWREeDRWbm1VVE93WEtIa2lTakJ2?=
 =?utf-8?B?RXk2VmpycjJMWG9JOVlRNWtLU3pGcGJaUXB2SS9SQVN3Nlh1d0tuUDhKRkVy?=
 =?utf-8?B?TnIvcFgxZUdsSEFDTzNoazZrT2pHTTFteTZXVlZTR3FnQ1Y5S1RBemg2UTRj?=
 =?utf-8?B?SnVCWENDVnNycnJBRCtZbUppYjhhZ2NXWFR3enFrUVNlYzlmVVY5SWxidmp1?=
 =?utf-8?B?RGZrTDlPSjVLa2F1Vk56WFMxWlVxZzZKR1JqcE02UkNiRXRzeXFFQTltMGJk?=
 =?utf-8?B?ZlF6QlRtNWlDc3dSQ28rU0lxUHdhRmYvQjA2SUJyb0FUUFVnUVNOUFhXVWw1?=
 =?utf-8?B?K3RNNFJoTjM5dUp3Rk5MQUdmbWVqejlnWGtFOFQyRUpuWmEwZExmaEErcjFu?=
 =?utf-8?B?SklFY0RyM08wcWNYUHhVakhHb3ZhUHk4QlZZcFByc3FuWkxQb3kvVWZidndE?=
 =?utf-8?B?eWlISXV0aFMzTU1iZERDTnVqaDJxdVF1cFpDOFNpYS9LVDhrNTBGVHVVaC9P?=
 =?utf-8?B?MHRpbTQzM1pCaTd3ajA2RFp2SU5oUXh1VjVTcUxCdHpmNnZHMUREOTZDRlVa?=
 =?utf-8?B?VWJMclcyYjE2NUFNMTZTeVQwRmNibm5CaEIvYU1MYjd2MmFWUkh4dEduK0ps?=
 =?utf-8?B?dmYzbXFHOUVaT3RiSERwWEt4MW5jT2FQNGtxUWI0Tm1CTm5RQjdxMWROL1Nh?=
 =?utf-8?B?M2RmSnFKaVhNbjlLQW45OFFSN0tHVUF5N0JVcXU1SERLbmRyc2toQkc2b05N?=
 =?utf-8?B?c0V1VWNiYUdaVC82alhxektOODZRZUFrYk95M1RvdDNTRi9DWURQQzhrTW5W?=
 =?utf-8?B?a2xSNDEvdFNSUUpZZUh0VmxFYktJbzN3NG5JL0x6M3lGekNJcHN6WXZyYTNN?=
 =?utf-8?B?KzR5YUptZDMyQjZwa0xZb05hWDkreCtXZGM5YitqSFE5b0h2eW9iZ2hnMFFX?=
 =?utf-8?B?QzhkbWtBVzFsYzlpOUx5dUVzVVZlSmZpeFlHbUlDZ3dRWEVadGptZG80WWRu?=
 =?utf-8?B?Vkg5WjJpbDlreWRKQ2Q5ZUEyc21VNnkxNzhVM1o5NmxSREZ4bXdzVnh5SUxl?=
 =?utf-8?Q?tqmQWC8Y/ODM9DJ03pHml0CB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2678a0ae-99e0-4ccf-f5f7-08dc895368d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 13:44:11.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfqzgbnTwaerziLbf8iVA/EcnBY3kPzGac/oDhsnuoDxEu7w8bsar9W3zFRLw3w008FQvwE1MnzYjAJiw3QMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

Hi David,


On 6/10/2024 6:45 PM, David Wang wrote:
> Hi,
> 
> This still happens with 6.10-rc3...
> I think this is a serious problem for AMD users who used to `suspend`...


I am sorry. Can you tell us which issue youare referring?

Is this `ILLEGAL_DEV_TABLE_ENTRY` (one described in bugzilla [1])? -OR-
the kernel panic in amd_iommu_enable_faulting() path?

If its kernel panic, then patch [2] didn't make it into rc3 fixes.


[1] https://bugzilla.kernel.org/show_bug.cgi?id=218900
[2]
https://lore.kernel.org/linux-iommu/lsahbfrt26ysjzgg6p6ezcrf525b25d7nnuqxgis5k6g3zsnzt@qsmzecwdjnen/T/#t


-Vasant

