Return-Path: <linux-kernel+bounces-178289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924B8C4B72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C31C1C20ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A813B657;
	Tue, 14 May 2024 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LgfErv4S"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176D17F7
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715656789; cv=fail; b=DKLVMqSFwtMXIOGstDeGtBIwxT0Pm+k+FzLkyoE1qtvwdR7UZvvCa+ZLb3r9/G5dTAixhhoPR2ltPZu5/m9pXqGTDTugbugpWHv1sNGKd819mX4z1EEm7saEu03yWs8DvJBr9/yoJcTLj44Nh5hUBq1HCgiee5tKxqNRAfv2qdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715656789; c=relaxed/simple;
	bh=6goCcyIWC9aRwFYBveQXO4zLYLGAzQCiJRejaZGo9WM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgB4TqLXIG1eZimglnr/mqGbBut0VYg5eV3IzrGe3qqp/bZxDEOM+n2osFkGKJtI2FWSs+3nFWyNuXW/kPAb6yiQdjnj5Cn0Zdu8uaCNmOK5EKOsoRuQhf8HwGCW2hz9g+GrSavJ3bY0ATTLAs9vWOmZl0zELRDQR34WlbkQR+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LgfErv4S; arc=fail smtp.client-ip=40.107.94.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn7NbRC81Yq0zFiM1YSohNZiKHMgZLQVkIzAgbLasY3YggFzehPY5uTIg0UqIveCulK6ErkSTufo30laF8cJgWOd3OVCWFUMY7JznXXLSER4q0EyZexxY9AqmSnhGYgRsLkWh7QRAWBL9rSoekWQslUTx4H0vw6IPMfLWebj8NpZWSlWEmCrgHjUituRyxi5haLI9GfcRBgQJKVaVqMEzu+1bE9LenEM+vCcKVkMuddbjLTolFXWlzbrRLTkL4i6eEaV4lLfELusU0zLe/0Xtv0Q35LqOF0x43P9dH533g3ShS2jceztd5cb3as98V6Dchj3bLHcnL+9QLVuf/vDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+voMX81utP0KRuzUP++cQ9HKlaHK3CYvU7q6YHA7ns=;
 b=EK+/NC9fXOYkESSQzvlykgyOfC4OnN9GeITYCVSPIk8rZwYoJiRj9sPew9RMeQEPi9GjLsaIycrGDgBykzOcsWzVOTzDcpsVoNDgmDtRTJlSfy+Yj8TXLHOQbC5bIs46IMGw7yH9tAL4rq3jdsBTpzXT5thh1vKukAq5XEp9z/QYuYXUF9T//st2TixvRnzjKGkiCtOsZXwEODQOk6s86w3O5GG0OjlSJmYoknf1S3ChRqmF8yR5RiCHjFiXf0FJlmQkP9rwu9N7qZols5+wbIoE5rQ+UXoryq4tFvd4Xznxi1HJX0VDS+bUYmemfHMlYFKfpRLar8AY03o12xBo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+voMX81utP0KRuzUP++cQ9HKlaHK3CYvU7q6YHA7ns=;
 b=LgfErv4ShLhQqRaQ+fPqwR6ZjChHiAB89SsTeJo2kCr+4MEC68+7oy3kqsHbEkO0x91Kv1KKbH+Kdr2bbZZOgFN5f1O+uTbDqXYEPuIMISMmqU6KFSJ15ClqmdA5bUMlX/3c5x25IFCaBdSJdXsY3kXTHEFVI1Lbz3/PojjXtq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 DM4PR01MB7666.prod.exchangelabs.com (2603:10b6:8:65::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 03:19:44 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 03:19:43 +0000
Message-ID: <f1049f13-53e4-470e-89e5-d99d7e171d39@os.amperecomputing.com>
Date: Mon, 13 May 2024 21:19:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zj4O8q9-bliXE435@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:610:50::27) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|DM4PR01MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 32411dea-9942-4bb8-bff8-08dc73c4b302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWJXREVWTEZTdWFnekxGMXMzZFJhL2Q2cUh5UEI1WWRZWG9qQVhjVDlDdGFM?=
 =?utf-8?B?ZXlLdnpFRnlCWUVxVmxaRG43UzVzSk92ZkpxYnJ6ZWd3WnZrbXFWRzkvbDlI?=
 =?utf-8?B?ckZOL2U0Z1lNdG1sU0Y4VjJ2RHk3VnpydzJ6eEx2RkRTd2p2SklIQVJGd0tZ?=
 =?utf-8?B?WlhQeTZVckZnQjhpeUZXSWliNGk4MlltYlRwT01SU0lmYzExbFl0OEFNUDE1?=
 =?utf-8?B?WFptaGRqOVBQWEZ4SkJKQ3BDTFNEbUNCUVo3SGRpUHJrdTZkdmNjYi9Mb1kw?=
 =?utf-8?B?TjJmSU83eFZENjMwYXhQc29nQ2dMZHlkRzVlWE5pMWJOL2IzMG04dDBXR3Z1?=
 =?utf-8?B?bXpLMFYwNW5NZTZYZ29EL3JlNW44MWpuTmZEQUpoVDhTc3krd2JaZnJObXEz?=
 =?utf-8?B?TkhhaCtGTWM4YW1OWWhSU2NWYkVWR2NPVWZRT0lZWjlLakYxalVFL29oWEE5?=
 =?utf-8?B?Zy9uZWFBQ3hPNVArdyt3d25RelNGVXFrcCsyQ1V0ZDhFUTBpanRHOFh0c2Vx?=
 =?utf-8?B?b3lqZFpmY0NUU3IvYUJhMEZCK1EwSnRBcnJ5b3gzeU1zZmlFaHhPTElqWm1a?=
 =?utf-8?B?SUJ1MmNyeUFNWW5mVi9yblJzSG11ZEc0eU41QVRjOEpSa1U4bTJQdXpkTVhl?=
 =?utf-8?B?NmFObG1sVVk3eXFNNTBKSHFEOVhUaExxaTJlclRmdHh5c0pDRHZocXhsUmh3?=
 =?utf-8?B?SjRtenhjbjBGRjZiMkVPTHhjc0VxN2puYkp6eHVsYnJvcnR3cjFsVjUrN0tz?=
 =?utf-8?B?QzNaNXpSOFFvM0RyVDVkUjdSQVhudVZGRHpRZW9GZVQ2UHdkMlA5M2U4c3BM?=
 =?utf-8?B?UW5USURnUzJLSzV6MjJmNXh3ZnhpcjMwdGEzNTFpTW50UXZ5SkV1N3NmbjMw?=
 =?utf-8?B?TTJEbWFaTDRldEhVbUdvdUdnR0pLTnY1eDhDWUFSekp1a0UyaFFjSDhZZ2xq?=
 =?utf-8?B?VFBxdVgxUEMzUkpTK2ZrQ0ZhK1ZDUWFNalVEU3JTZkx1TDRZbnY3WHMwUHVs?=
 =?utf-8?B?UUl2ZVRHb01KZEhNTzNnTlFINTVpRzFzUjhURDRxeDRHVFhnbTdmbFFIUDZE?=
 =?utf-8?B?akxGUTlwT1V2azQwMjN5czB2MmJ6MG9vbXAvQk5CR2duQUVIdnljYlczdzNn?=
 =?utf-8?B?M1hkc3ZOT01zakhYcEsrOUVYUXJKV3pOSkRIeDNiM1NlL0xBOHowU0xsWXA1?=
 =?utf-8?B?NTFzUUJ5bUIvSjZPMnA5cDJFam1ENHdlY2pPN0NNbFZsbkRrdU43UUU3Sjgv?=
 =?utf-8?B?QXJDdVdaWE8zWEROdXNaYXJPR0lBOEVFS1BqTWRlcFczNkEwdW81bEgxcXk2?=
 =?utf-8?B?aU1mMTYzSEkzSlVGNWJYNXBBanhETzFrT2gxM0I5aC8vbmRYdWRkMldSd3Bm?=
 =?utf-8?B?UWRjOGg4c1dpbzYvV0dwUi83SzBnZHdhbWV0VWppMXVXNmR0T2l2a3VwTmow?=
 =?utf-8?B?Zyt3TFZBN3pQcUEzRnoxbzZmaFd2eTdNdm8wQ2ltRU1DRTQxeXViL2RyQUI2?=
 =?utf-8?B?Q3o2d24zWFcrUTMyNmYrK0s1aHI2WGpvTG9PTWtWcVlPcSt3S09nbVVGS0Rj?=
 =?utf-8?B?NThLeE85Sk5pYThOTGxKbGIxdXl6cFZLcHpNaDdWOFg2cndPczlTb2QvT0hw?=
 =?utf-8?B?djBDT292dU9LK2prUTJwNC81NS9YREUxWktYeFkvYm5Oa09kVGd2bHRENlRR?=
 =?utf-8?B?RDhOZjNQVFNuY3BsQ09UdFVDUmF4amM5NmdjUmZhckF4MHRsOFhwaG93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVp4UW94RFJYSEV6TDFCRW1QOHp6ZkxxRXRsK3loNlNNRzlXVC81cFlkdjcr?=
 =?utf-8?B?anByVFZQNDN4bTZQV3NiR0hGbEwyN2I3NGRoUTdJRTZhMzZab05NakhIN3Jj?=
 =?utf-8?B?cnlNYzVSTGlFb1Q1bXpWVmN4bUMyb0EvWVpBd3ZlbVVRMkhKNzRDZExKeS9Y?=
 =?utf-8?B?RURZK1Vmdld2czhhdTBNcERRbXlhNEdlUTVaQkVqdGpQOVA2TFNCZVM0R21F?=
 =?utf-8?B?N0RQckk0cDk0N092ODd0NWdHY0JxK1FjWGNzWVUxb3NWckU4SndVWE54SXpG?=
 =?utf-8?B?bWcxa2cvdXJtWUdCcDVPdXI1SVB2dVEwbG1RY1Q2QkRHTGlyZVorZmNFQnNv?=
 =?utf-8?B?WnZDRHJ0REZpdzBVdmgrcDE5Q0ZSOW1EKzQ2eVRFMXZUODFDQzBadnc3bm1P?=
 =?utf-8?B?bTJJbldwTjVzaWhHeEg5RUtDdjIxbjZnQnJGdS9jTXpSRlhtTDd6YWVVQXF5?=
 =?utf-8?B?d2QreGxJR2Znd3VWTHFXeGx4aFptdkdrWVYzY2RNL3ZWcytRNEZPcVBwOFNR?=
 =?utf-8?B?UU5mTWVWaW9ENTdSQUQ2S1JyaTN0MGdrMy9GZjJtelZ5YnkxU3pxQ1B1ZG93?=
 =?utf-8?B?T2JqaElhMFIvb0tFNkN3aktFcTNua1ozejJrcGZnaHovMXBQa1hqSTh0N3hY?=
 =?utf-8?B?bmRvZ0FpTHd2WFNDN1BBdVpMNEJtcERZalg4MHR5RGJMM1k1ZEpxd2VRdlQ2?=
 =?utf-8?B?djNOQjZiQjhwdGlEOEpUeEovYjNSNzJrZVA4ejhhcVZpeTlTU3B2Rm15R2Iy?=
 =?utf-8?B?UmRDSHlacVVwNnY5ZFE0YWhvNit1M0k0MFJjdVlNWVBpRk9PZ0ZUSDV6S00z?=
 =?utf-8?B?NGFQdmp3eTZvMEFxQ1F6MjFHZmJyVGdXYmtpWmM1UmNIRjUzTmVsZ3BZMGJD?=
 =?utf-8?B?OWtxT21sTm5KdU5YekpjVi9lZy9URHppT3ZhYXFhejZnSit2V05YSVNUUHYv?=
 =?utf-8?B?c0RibWs5czdzT3FQbDlLS3RZdjRiRTZkZkRXRzZyUEJaZHFNR2Yyc0hreEV0?=
 =?utf-8?B?aWordThqenJTZC9jbVZObEVsUlVLeTBWdW1xUkpqQ2dsOC94RGNjeUl4ejcy?=
 =?utf-8?B?UjhGUVdUMGZTK2ZFN3BoVmJaUUo2aW85NmNoVjR0SXhHem55VUhIZ2plcWpN?=
 =?utf-8?B?SXRzVUJlcVBvVms1dDZ4VkRYWmkyem5OZ0pXa0ZXYTZLUEhRcmtjbE9PdlZY?=
 =?utf-8?B?aW1ISE05TU9uZDhWaUFXUyt5RjcwQlUrRkNwMWlTYXdxY01YbHhPSnpjVGVs?=
 =?utf-8?B?VlBvcW44ZC9pUmxJTEFzMVdscWc3aytLVjBhajgyRUFZQ21ya0Q3a0tEaTha?=
 =?utf-8?B?dFpPMEltSEttNlF5bGludGNQbDVXaUU0WC9pdWtSQUZyMFVaSm5weXk3ZnRF?=
 =?utf-8?B?ZCtkYVhHNHZndDQ0K3ErU1dkOWFyVXUyNUxKQVp3SStCUUV5SklKWkhHdXNM?=
 =?utf-8?B?SVFFQlo4MFlUbVJnODd1ZWNVUnFXNE5IOWtVdmJrUld3Tk9RTjR5eEJiRXlP?=
 =?utf-8?B?NkhYSVI1L1ZPZjJZOE13ZXVENzB6QnhhNWl2MFdsRHJNZkNmbmdVOERraFNG?=
 =?utf-8?B?MWVxcmZ0bEJEczlRbkY4NEl0SGUrcjYxUFgva1RjQmNHaDF1N2hoRU96RVFa?=
 =?utf-8?B?akRzaFB2VXE1ck5uYmRoaTFRNkZIdnhaT3RRSWhPVzhaS1BjN2Q2Zmd4YVZX?=
 =?utf-8?B?dStpaHJaeE03MDY2Wi9qYnM2ZlFPVXNZZ0dVQXBJcFlpTk13bUQ2R0lyU0hs?=
 =?utf-8?B?Y0tycVpwQlZndjNPQUl0YlE0R0JQdk96OTFtcVR2SURYcWFMSDVhRzlWSEZj?=
 =?utf-8?B?TFNOZGhZV3RrM3RKZmtJMXdXaWxPOFR6VzcwbExWVnZNMHMwSW5wK3BjOFJT?=
 =?utf-8?B?cUNJTGRMbHdSeUExM0JXVWhVZ2xPN25IeU9oK3dWalpLQWZ5TjNTUzh3OEJn?=
 =?utf-8?B?OWIyUnplS0lwbGxia3JONnYwVmNxWk15Uks0K2g5Y1A2amsxMnR5SVdBc05t?=
 =?utf-8?B?ODk1TTNzM3hPQWNBZ2R3UmtodTNybkp2NlZUd290QXhCL0R5QlM1YjcxSW9t?=
 =?utf-8?B?a3llZy83RTM1MWdhQTdIdjVwRjdOZXpDZW9hWk9tVnBWeVVrSWlja3RoZi9z?=
 =?utf-8?B?VGtldHJDbStFOUhHbjIrM2UvZm1XUXVxNEt1dzNxRXd1Z011NG5lVDJlWjFE?=
 =?utf-8?Q?F7f8Sfs/4baGGecTJdR76Cc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32411dea-9942-4bb8-bff8-08dc73c4b302
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 03:19:43.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX7BQw+HUouzabfHIHztUX/lUj7fHaFMHvekNTE88kuqHqOzF0oJ/EYQcw/nEcuOGWvdTOT/9+D1qd0EBtr2q2gY5i8sxoxdNwtzHBSHJik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7666

>> +
>> +	if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>> +		pagefault_enable();
>> +		goto continue_fault;
>> +	}
>> +
>> +	if (aarch64_insn_is_class_atomic(insn)) {
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +	}
> The above would need to check if the fault is coming from a 64-bit user
> mode, otherwise the decoding wouldn't make sense:
>
> 	if (!user_mode(regs) || compat_user_mode(regs))
> 		return false;
>
> (assuming a separate function that checks the above and returns a bool;
> you'd need to re-enable the page faults)
>
> You also need to take care of endianness since the instructions are
> always little-endian. We use a similar pattern in user_insn_read():
>
> 	u32 instr;
> 	__le32 instr_le;
> 	if (get_user(instr_le, (__le32 __user *)instruction_pointer(regs)))
> 		return false;
> 	instr = le32_to_cpu(instr_le);
> 	...
>
> That said, I'm not keen on this kernel workaround. If openjdk decides to
> improve some security and goes for PROT_EXEC-only mappings of its text
> sections, the above trick will no longer work.

I noticed futex does replace insns. IIUC, the below sequence should can 
do the trick for exec-only, right?

disable privileged
read insn with ldxr
enable privileged

>


