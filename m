Return-Path: <linux-kernel+bounces-413860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C309D1FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DDC1F21180
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79F14B96E;
	Tue, 19 Nov 2024 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GMXPIi+u"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2118.outbound.protection.outlook.com [40.107.21.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC4142E7C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995305; cv=fail; b=Y/U7NZY5iB1F+zMTmDHexedXbougPbF2cgPkxWN87nkeuErUZOy+iSEKS43cD0vKiyN1tXMl+a5GcJvfOu984qHF+WOpG3+F2KQjfuQS3c7oFHnWO86KOyYMkVV4qH//W80z44YjNwKweC0UW/dUCLWU9GNZUzhYw/z13qWDXQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995305; c=relaxed/simple;
	bh=Ozr8eCOQRfLSX7HsqM35l1cygmyw7FGlDnYnEz+8SCc=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=tQghEZzuihC6FmGUk+sZPPGk7iEnFEcuJGaq2ynJZF6Ltnbsi4eJkNsRefJD4td9HflMzJ7a9992MLhSD44VDQEmzsf5SMJ8HMnGxxnqztiXjI8ySBW/o6j96Wf/z3IEE3l0JwWPX60gnw0xrtkI6hp1rgKnCyb7G2yhtAHP/P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=GMXPIi+u; arc=fail smtp.client-ip=40.107.21.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocIahO/Scuoo4hhtLEKa9TqaUBfWikuCoyin5UFuS80RQkeqoN+tazE1SYH9pf21zudbE8Vo06sa9B+pMhCJ+3eq0u7NzhPMLJg+G0GmF6vLun7JQNTCyq2GDWXEtkUPod3sLhEgmeaKqtGwooZ+8YpWtw5R8/pXMbJlD9AMoKir4fyLZFRahg0oCNDrdfXTre/0heTWyvvFrGIMVhZuB8FqtjmHfoDRczg7X0oFTkU/FXiZ+BjMvxXh2eGfZ0/XYnjoPF+1fTZBwT0DCeOzOcYejeFP4H3B0wDw1SUKnsBkoyikp7y/YcOHxqiWmizDWDnhkZiCsb2SwJtvQycNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLMMnI7EHTDOKqRWnahpG3/f/4c5Ymx8ATfl/w46FaA=;
 b=TZiQH3jfNqEvOKlfz2n+t0u+d71/6RlZN1NtHlPpGv3Do/PGFF7/v+XKRCyp36A/lNSPnVlDSI8ylP1tiFm2uxgXaeZC91aJA59Y83+JMGmaStk5Rort0gY0n8gBcApIz/LxeuAhDnCL6ye9QkotvRL1rPBfpvf7L86FmULfm11LA1eCJE238iWWHsHho1//ESPUpAldpWEseKznRyYZBcs12BjstF/KgZilzjDaQgV4Cp5GOUt2qjtBdP7QGBZY7NnlYlof7gRqYnH3ajEOyMJ/7xWATiDiAO6H1uzXBt5ZUQaIHuKKmxorJHqQfNGQQB9L2+VzMG8izdwW0Dicqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLMMnI7EHTDOKqRWnahpG3/f/4c5Ymx8ATfl/w46FaA=;
 b=GMXPIi+uIlLau2X8J0Fhx4wG/lL6GvmPE4zG40SJcZ/9O/NQ2KPbJFRId4fL2FgZuCD3wEtZbhRXfs3JXgpRkIMMDXfc13ala6nOp6WsJ2rNR+F29oXxCv+uRFrp0UrTPIk9gcXlfqfp7iDOlJgBRsWZoWJchjwzc4s3pMo5F48nBN280vwsPnPFpm8bJKvd2NrmSqN05+djUl1GbZL/kHa8Vdp0zCBsruuwOP1t0QSQSJLuLuU4BhpmHPbRmODgTVQdDNQYMRuRvC9g1B05GnTRIT6ddthcodqiHgNXzMJFFGOiiak18GcRXV5qLYK1hWlGSoBF+cXFUM0auoOTCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM9PR08MB6292.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 05:48:19 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 05:48:19 +0000
Message-ID: <112f93f3-455a-4b89-94c9-d12844d972ef@virtuozzo.com>
Date: Tue, 19 Nov 2024 13:48:15 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Question about vmalloc(GFP_NOFS)
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 lkml <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: de1042a8-41d9-4b7d-d4f3-08dd085dc542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXhtakZQTi9BZ052SUJUTklOajJsL0M3YkhtbnNjR0hnWFJPMlRwdlZxdDlH?=
 =?utf-8?B?dC9oMWJia1pHQXR3OURvb21VUmlvdy9LaDlKVGRZWFN0b0lRYWlJUUoxYkVI?=
 =?utf-8?B?VEVyMXR4Uys0WVFYMExhblcvLzBuS2dxcUk5ZnZsK1dRZjdmSWNVK012QVdZ?=
 =?utf-8?B?S2NoNHhSZ25SdHdjcUhZWGtMeUoxVkQvZkNBbWg0RHZKNXBTQUMyUkFmVG05?=
 =?utf-8?B?V1lBa05vR1JRUzZrbG1MTG9hUGJ3OUNHajdwd04vbTlIc1hrak1RN1I3ajl5?=
 =?utf-8?B?bTRFeDRKM3IxT21LaXIyRklkaTVvWUpzbTd6bDJPdXp3WkZFODNETGtxMVZq?=
 =?utf-8?B?QmRlRkFCM1lSUVQ5VFozdlBmaUd0SnRRK3h3c2RESnQ5VjlEZ2ExeWtQWjVV?=
 =?utf-8?B?S25ZeXpZMk11TlhJbUdYVmdPOGEyNXFUM1FIelgyL0NaR05NZU44T3dKZVBh?=
 =?utf-8?B?UzdPSlZDb0dvRWRjSVlybzZIcmRvRnAzcUFHR1lwYWN4WUpsVkdLRVA1Ui9T?=
 =?utf-8?B?cEQwL0dIcDNONkRIcDUxQ0hIUnBLb0NBaUFJcm9wNjl4SzdidmVQVHdLVHAz?=
 =?utf-8?B?cjB3TkVEYVR6U2VkN0x4WFVuMnlBU29iOGkyN3Q3aXVGVk8vV1Y3TVZuaTVU?=
 =?utf-8?B?QkdOckVmY1IxbGZVaTZueHR4TzdGdmhWMUtMc1E0SkxZQmVnNmcrNEZJSkZj?=
 =?utf-8?B?US9NaEFTbWFLUEVNZjAzK01QOW11cjBtWGQzczlrSElidHpSQit0MkFQMkFu?=
 =?utf-8?B?dWI5MXBua0ROU0FXbURoUVJmdDhqNlF4TDhpYUZtcW1uR2dMSTBZalp3UkFp?=
 =?utf-8?B?RzRTNCtCWUZoM1R4U2ZMVnRkR2FsemZzNHVjVDI2VmV0WFo3eFVJRDc0MWZ0?=
 =?utf-8?B?L0plZEhzcVdvcllTU3JOcWxJUnhOL1NhS0JiakhYS2hlZU9laDM5RTI1T0FL?=
 =?utf-8?B?aU5xM1p5eEgramxnZVY2WVlMaXlDM2RoTmxHZmgwYkJZcEQ1VDBNMGxSUHdU?=
 =?utf-8?B?ekViaGJKcms3OGJYaTJMRHB5UXhRVWhhNFdjTndOMkNnbDB0enBVaTRmU01o?=
 =?utf-8?B?UHhGc29QNkxmWjdQeEp3QytQRlRQVjhVZmlDNHl2Qk5hNWN5OVpLOGNaQkd4?=
 =?utf-8?B?WWEzOENIMURPdjJjejRxVUozRTZBNVVtQlV3ZFhIVllFUDFGTkhTSDIwMUJR?=
 =?utf-8?B?MHMvdWJrQnFzK2VzOFFUR2Iwd3VTcGNKN2ZOZ040Y1d3MTdwRHlsNEYvT055?=
 =?utf-8?B?RzVUN2xud1JzUWl6ZDhhVU5SQUpiZ2tWRmdOMVRNY3NyY0RMTjZXamE4L09K?=
 =?utf-8?B?S0lUZmhoVjVrRVQ5cVdwUVhLNHZKZ0NYam9iRldVc0dNeXJ2U0JoVS80UHY2?=
 =?utf-8?B?cHhHd21IUm5aSWIvbFgvOXhlWmtDSXFOVXV2dU5tMXp2SjFHSGtnTDFUOXN5?=
 =?utf-8?B?UDZjZlRlclFrSkJuZzFVdW9qQUl4V295eEZBYkF6MUVRK0ZPc25rYlZPejFa?=
 =?utf-8?B?RzRsa2lwZ3N0NUpabWdPS1RiajQxSVV3SG9yZDJkdk81TDlET3RhTEtMT0Jh?=
 =?utf-8?B?eUdHYXUvMW9vdmlaV0c5S2ZUTWJlYkVLUTF2ejZKRGQ5UTZ4cTVnTHRSODdk?=
 =?utf-8?B?c0VyZG5NdGg4NHQyRVhSV2preDZqdVlEdS9NVnIyTDR6UW42SU9WdjNiVHUv?=
 =?utf-8?B?L211eFhpaysvdHhQV25Ud3hGdURGdFR0TTFRZ1A5Ym1Yd0tUM1htMEtsSTRr?=
 =?utf-8?Q?YAYHq1P1Ye8J6Lxw8adEdEC88LYO1tX5oPyANWg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmh1VmpRTFA1N292SGZuWXFYQWZsbmVNd2MxS3p1QmVCRkJQVmtiZUF6TXdF?=
 =?utf-8?B?VzBvUzA5U0tkazlDdnFSeG81Z3lvcmJvekpYVzFqSkFHWFJxTVRKQk56c3VI?=
 =?utf-8?B?bUJKTWsxdVY2aHk4UW5BaUlDRzhvZXh1YzcyZEMzMnlESWFIbElVOFRMMHI5?=
 =?utf-8?B?Z1dpak51RDRNeXBobGRoa0hrNENSdFdoUFhSNC9WbTZWSVY0emE0QUVpMkRl?=
 =?utf-8?B?b0s3UDh6YVJkVXpxMWdSeGtYNEpsR1hPOFBtMlBnay9uQzVVNHhaeG1UYVRJ?=
 =?utf-8?B?MTNVZjJyZmdlK1R3WkV2QnIxTE9TQmwyS2JvTkpNTlZZdE4zYll2bUIwbFA0?=
 =?utf-8?B?SkZjalRQYWVRaDI3WDNvbVVEbjhwYVBsdldXWVhkdzd6cE8wdGF5QmdwL21v?=
 =?utf-8?B?bVRUM2pjWnNoZjBIY0J0UnJGRTl0RGtNUTM0dkNjU2hLSGhZUVB1TXZYU3VW?=
 =?utf-8?B?N252UlFPK0RlM0d6eG1odTJ5R2tLeXo5SFBpOFFFSWYvM2xBYkFKbFRMcmRO?=
 =?utf-8?B?NnZKTjY5UkM1T0wwSHVwdmtJSUw3R3BWOEpvSFp2V1dCTlJKMmlZNUpScWVY?=
 =?utf-8?B?MGgyWjhsbS9KK0YxVFkyMGZMWEN2Ykx1ZnhsdlVsdlkwemxNZ3lWZ1J3cCtT?=
 =?utf-8?B?YVp3Qm1xZGl1UG9qbkE5eTJGT295QWR4NGVtQ2EwSG84U1RlNlhDQVBrczIx?=
 =?utf-8?B?c3VnZkRzSTB6ZG5Fak1BbnhyOTBGWnRjck56VEwzY3dLVlhlNDN2K3pQNjBR?=
 =?utf-8?B?YW1NZXFRT0IycHJHdjh5YmFma2xKUFZjSEVKRUxESEc2MG04eldOTWN6Ni8x?=
 =?utf-8?B?WVB1YnNaMFhjV1lIS01BNG9hakl6R3JrQnVhYXlSZURDMCt2Ni9TaEZqUEhj?=
 =?utf-8?B?dm5EN0IzeWFscXpEZW4xbWFrT3h6TFlmdEdKQnNjbUphMENSZUo5NjArWUxm?=
 =?utf-8?B?dkkwVkNQRGk2RHVmai9aMWh5b21TWFowT0VDNnluWEE2MmNzVm9RZXNWVjZk?=
 =?utf-8?B?MkdPdTJGOUhTRXJTaWttblF5RVAxWVJaa1pVcmxsS0RJNUF5cDVMUzRydWNL?=
 =?utf-8?B?NlU1eW1tY254aVhWaERDamE1ZjkwVlEvQWRBMlUwNy9LKzQzamxwOW5XeWdl?=
 =?utf-8?B?NFpnK0FYMVZJSVI1SDBiQ2JIcUdOTWNhQUNEWm5DYVgyQ0lNMmV0VlpEUDRi?=
 =?utf-8?B?NnNiL3JmRUpHdTFJV2JCYmNrbEJRMXZTWUhacDBVTTJEQWZzUktTUy9UV3hp?=
 =?utf-8?B?bVpqb21udUpnK1BnaDZNZjhoUG0rY25hSG1LL1ViWFJXdHZLbDJsb1NDT3hz?=
 =?utf-8?B?OEk3TW85TDNxbWhYWExlTytqWGlpQUR6dENFV2JpOERaR3VUc2I4anFBT1VQ?=
 =?utf-8?B?Sm5LRnZ4VlpBc2g2S0RVMmQ1T2FydjNldHpGeHZmcncxTUsvV3pSL0h5MGRK?=
 =?utf-8?B?VGhMYTAwSFdEMXYxTG03bno1OS9mVzZ1Mi9XVEVVenB1eldSRDB5NXVQdldL?=
 =?utf-8?B?dFNiSUJUVHh0QkdIZ0gxWWlFOVJibDlkUWthSHg2THBDZTR6Qll6MFQ0OUpv?=
 =?utf-8?B?Z1FhUzNuWjNLVW9paWF1R2RyNzIzRTVKdFVoUy9za0dsL3oyN2RPSE1hWTVo?=
 =?utf-8?B?UG5GTnBCVTFyMXlvYzl1WjFubXk1cmRXU25Tb28xZGRvam1PaXdLVnpVVHY5?=
 =?utf-8?B?OS9qZGFDVzdVUERKaFk5QzVZek9VNW5ZWlg0bWxDUGY4VFZhQ0ErY2tpQWJa?=
 =?utf-8?B?YzJtN3ZQTlNhTlZoZlcwMnJvZmV1bi91WU14cTRQWHBySEowZXRiNVRBSmxW?=
 =?utf-8?B?eGhMR0ZpOVNNaWFaU2ZkTWhCWmZMVFlQNWlGd1phelRqRHFBMjRVVE1lNDdQ?=
 =?utf-8?B?cXdSY3lwejk2VXZNTkFocWQ5V3Rkc2w1NFRvN2VKbEFEaEdnK0lieEdlazAw?=
 =?utf-8?B?SFcySTZVNGZUU3FoME4zUHhjcGVmdmQzblRnYWJNaVBISmZDUWdCWjRUeFg3?=
 =?utf-8?B?ckNjTE9HY2I2OVBnM0QzMGw5VjhHRVNIT1BFUnA3SlB3RjJPNkR3bU5XQjR3?=
 =?utf-8?B?SnI2NWlsSEppL0syOVUzQTVnNE9EL3lXTGVmbkZLVThMcHZoZ3A3Zk5jVmRx?=
 =?utf-8?B?Q01OUjdIZEllMjR6N09iZmZub1dRdGlUZVJTWnpaVzRURW5wYjJxTnRPSWlL?=
 =?utf-8?B?cVZ2cUNXTkRJMWRmOWdMbWg5cStNL2J1RHlQY1dXdEo0RGpuMjU5UmczUUQ3?=
 =?utf-8?B?TVRNOFE4b3k0bC9YUHFSREovbnRBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1042a8-41d9-4b7d-d4f3-08dd085dc542
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 05:48:19.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJQGb5mjoO/6x19teh+V3UT0UVPrzSEynyaxW7OrdiWLgAv6PyR2onZFEgi4qibz+So3tFeb/OIzWCXxHi+Vd4WbXxL/B8q8ABcBtxOjvh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292

Hello,

I see that in kernel code we have couple of places where kvmalloc is 
used with GFP_NOFS flag:

git grep kvmalloc.*NOFS
fs/bcachefs/journal_io.c:       new_buf = kvmalloc(new_size, 
GFP_NOFS|__GFP_NOWARN);
fs/ext4/xattr.c:                buffer = kvmalloc(value_size, GFP_NOFS);
fs/f2fs/compress.c:     cc->private = 
f2fs_kvmalloc(F2FS_I_SB(cc->inode), size, GFP_NOFS);
net/ceph/osdmap.c:      state = kvmalloc(array_size(max, 
sizeof(*state)), GFP_NOFS);
net/ceph/osdmap.c:      weight = kvmalloc(array_size(max, 
sizeof(*weight)), GFP_NOFS);
net/ceph/osdmap.c:      addr = kvmalloc(array_size(max, sizeof(*addr)), 
GFP_NOFS);

and with GFP_NOIO flag too:

git grep kvmalloc.*NOIO
drivers/md/dm-integrity.c:      recalc_tags = kvmalloc(recalc_tags_size, 
GFP_NOIO);
drivers/md/dm-ioctl.c:  dmi = kvmalloc(param_kernel->data_size, GFP_NOIO 
| __GFP_HIGH);
net/ceph/messenger_v2.c:        buf = kvmalloc(len, GFP_NOIO);
net/ceph/osdmap.c:      work = kvmalloc(work_size, GFP_NOIO);

And AFAIU documentation 
https://docs.kernel.org/core-api/gfp_mask-from-fs-io.html#what-about-vmalloc-gfp-nofs 
vmalloc allocation with GFP_NOFS may end up doing "GFP_KERNEL 
allocations deep inside the allocator", which can potentially lead to 
deadlock in IO/FS code paths.

Does it mean that we should rework all those paths to memalloc_noio_save 
/ memalloc_noio_restore variant? Or is it already safe to use 
kvmalloc(GFP_NOIO) in modern kernel?

Or maybe I misunderstand something, sorry in advance if that's the case.

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.


