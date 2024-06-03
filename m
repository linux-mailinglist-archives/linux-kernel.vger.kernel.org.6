Return-Path: <linux-kernel+bounces-199217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CE8D83FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E4528D0E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DD12D766;
	Mon,  3 Jun 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VcNDLSQE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91012DDBC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421433; cv=fail; b=uJSI6ZRfCroTlD1V2OMwqYHz4TyEIhgX5AdK8wAIjGOIoMXcV0S0SL0ExNF1TRxN5NBqnigCykQS/kprlxTbcCw7ECLrNK6PBpwiAIFlD1ckbEVElF/jmUdEoboSvnU+6ClbjZLpaaDT3HVWTFPaeCcFZ11JtLHi3gnR8+ceLSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421433; c=relaxed/simple;
	bh=dc3CepVevvZJzD7tFWZCcFN0h2mo2mWB+hzZAb0LJZc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4KQbgm7VR256jUaHcej3M3QoxiyoPZcbxPtLKfMUoQjHKEtyT5vde8FdPwWWxw+xFWfxQIZd8Ch7McYSrvWWN1kpFSLLCmgX5fm9rwlKDaR/q7AZs/2sXl0tJhsY3dLQ76xMMnlofAxOXzkiU2INwvG1vdmOQo6mD4Q75xkgxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VcNDLSQE; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDNSmXnKWYbLayGxHC2gWYgTPYmGgsNt+jTcmiCzk7tn4854Pfm9w5WW9M7wTCm6zVdg6OaT0fV+lEXM7iIQu5BZ78Gywf8u+7IdSuuT5KSBGboe6LXzogwaRAPpNpJWZLNCkdHp4VHFWkeAe35aisYjWB3Aj5470B1m+rnF2/uxh+1Kijv4NGRJIkc72E5vcTiYP03n3TdUwRBT6Pfx6pGEHpvmz4AlJFDjxf8bibd9/xAO+E+CGjyVWczo2kRGMqhQV0RgvW7WKt89rb72L3G7semY+m6je5+ydUP1huRmOMhGnqAv16F5ubaZUcmaethujLYXZArrsXixRHtevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOOGQAv4JINuuFp3Y6y2+VVhOQLpJFGjRbhuC4jRbjA=;
 b=Zb8eCo2p4tNRTkp4//iqJAXfLwzqLFcsc7fn7IGKvjtId2q1Zo00wVY4QybHhHIYoJ5cllpkJyFlG/I0cX8muZdopcBZKZOKte/GSSdZwetM0w/qLa0wczQ6Xwnk/tkyG5AQgKk20DbZDfpb8CW7oIi1IgxneMjZb7LJeaC7NCUUhY5RH8/c09FZmUat/kTHoZJRJfmO95zx/ReEX0J6y8lOZ/qR0qSHvMPkunmAq0PW2eF+OWUuPB2o+Jp5CDtwaeM2E56/X4UFS2psqVi2ohN/dAtusfAqG7gXc3uykiCCOb5s8cKQhTgIRj3Bq70T4mX0ZuJM7+F67NYI+xv0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOOGQAv4JINuuFp3Y6y2+VVhOQLpJFGjRbhuC4jRbjA=;
 b=VcNDLSQEsGO8NdeDw+xKY3hZ3R9x8+3a7znQbu871MpGAUEr7ABNap74UCbBvJUPQMqafAVNyQQw2NGkiGEOMeSmpjDvDfUpcTWUNyki/XUzuDxOTAEg2xYN0H7IDyQgZAmxpZDSM+JK78rn0+Ls8jS3mNCxtPnKNGkrpCOrYaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 13:30:28 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:30:28 +0000
Message-ID: <16622c3a-034e-9f78-3afa-b0c273ee4949@amd.com>
Date: Mon, 3 Jun 2024 08:30:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Kaplan <david.kaplan@amd.com>,
 Borislav Petkov <bp@alien8.de>
References: <20240603083036.637-1-bp@kernel.org>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/kexec: Fix bug with call depth tracking
In-Reply-To: <20240603083036.637-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: e3315204-6339-40cc-5e33-08dc83d1553e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTl5bzVzWnN0T1pVcFJocFNodGROdjFJNUticURwdHlLNzNSemNKaU5Ecjgx?=
 =?utf-8?B?VUJTbXY0OHU0cnZGZm5kYVhpVEZ3MlV1RnVPKzFwUThvdXo4dEMyUXpxNzI4?=
 =?utf-8?B?cHM1dlJ2b0tONHdOUEJLcGQrNnlOQk1EQ0RWVlFrTTFhQ1FXWFcwS2JCbDJ3?=
 =?utf-8?B?MVhMUllBbnpUQVBjWS8rOWxlOXFhL1VLbFFsY3Zuei8yMFl4UEZVU3BUaWNo?=
 =?utf-8?B?TEx4a1lwc0dsT2V0d2RRNXpiWllMSmY2SC9uZDd0dEJzR0NlUXdpYlJDTi9U?=
 =?utf-8?B?K1lHQjYrc1RMcXVNdTNEajYrRGt6RjZJR0JQYzNnamwwbFRwdHRsUDJqUVJH?=
 =?utf-8?B?dFRKcnBFQlEvVlZZUk03UW5oT2o0MS8xOUVBR1Z0U3hMTmhLajNkaGViaTBZ?=
 =?utf-8?B?ZE9oaGZuQjd3c1N1RDhkSmpPVVF1T2RPZnVBbTNQVXUvWU8wZFpKbWJMSFpj?=
 =?utf-8?B?QnFtckMreGZHaUoxN294R3NQY25kNE45eUxtRTFaUTI1MUtiQjlnYkd2UG5n?=
 =?utf-8?B?OHVxRDhCeGVTSHZyNzhiMlNTUXBZTEFGL0loMklwQVlwMVQyS0VaNEtuUnk1?=
 =?utf-8?B?SXQzS2FubU9zR29LSmJ4QkxPNGdQZTBKcmd3eTExaEhSOGR1L2g5Y0JPVS9K?=
 =?utf-8?B?bng5aERyeTRTRW02MXBGK002bDh5aXovaXlXUUdYbFdFTnFjRm8zaFEyNW44?=
 =?utf-8?B?cGFObktLclVPTjFOcEIwUEo4V21KVXZMVmxuZ0tGM3Y1YUFUMVczSWIzUmsr?=
 =?utf-8?B?ZGNOVS9hOXJnK2ZLV0hXQktkSUJaUDBRV2h0UGZZZThZVlp2OG9SZDc5VjJm?=
 =?utf-8?B?Vmh6b2JvdGJIWjZlYWkvVUxkKzkxVHNQby9MbE9oR1owOWZDbUF1RmlsTkhN?=
 =?utf-8?B?aU9idjBUY2MxbDlBZWpRNzhGMTZBUG5WWk5RbHJNM0pZY3pZZUtHbFNiRnlM?=
 =?utf-8?B?ckZRckFIMHltU3AzNTAzV2g4MnZhcjc2UjNLWGFhdVZXUmtlVUZuTFg4ZkRW?=
 =?utf-8?B?bm1PNHA4ZDhia2tJZzlSNld1bGhtbXY0NW9hVjZWZDcvNk9FM1FFc3BiT0lq?=
 =?utf-8?B?bEp1UTVRbVBnVTB2amcyTnhPVjR0MGR3Nk5rQ0MrYTB6dUQ4Y1doczJCd0lq?=
 =?utf-8?B?a1lNaGpuSFUzcEMzZkVTSHZCUjZSQ3Q4UnBWT2J2S25mN25MWHRHNDBzYVds?=
 =?utf-8?B?aEt0SW02NXJ5THNJQnpGd1pZdUdjMlh2UkFicmpIZ3JtWHhBNlUwKzhDK3RS?=
 =?utf-8?B?ZTJ6WVZ4K2lQekJQTXhrVW93eXR6YnA1N0lRbjhLZ3JFbG1VS0pwbmhXcVJG?=
 =?utf-8?B?RW5taTNUb0pQN3lDRDBRcHFWM3UrVTNxeUxOLzhoMjE1cTAyTzc0NW5hWThU?=
 =?utf-8?B?TUJ1bDIyVFN2bEVlNURpcTFaSGVMcEJuU2NrTmUwTTgrdGFyT0U5MTdYV2Vo?=
 =?utf-8?B?WGpRZ05CYzl2MWNlUHVlNHhjSUxzWk5VMitZelEwSWgva3N1VUZQeEdwL0VY?=
 =?utf-8?B?LzUzZEhHZTFtU1h1bjU5cFc2QU9UamZFN0tReTQ0ZjJNcDNrdmxaQ0lhZ1Fw?=
 =?utf-8?B?d1hJRzlZWGFIQzJ3Zk9UanRkNnFQc3FrQ2hlblFmNXBISEQyU0J2V0JLajla?=
 =?utf-8?B?MUxJb3VlaWVHUytXMk1iU3RQZzVGbWVDc3F1b2dpcEJFUitjbmFPdkVHN0Nz?=
 =?utf-8?B?ZkY0VzBXeWJEZU9lYW1jMDR0cko0SlpNd2dpdkllc2graTJZVHNaM1h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjk2WnpvamRlcEhORUNTUkh4TEVKaXZydGVmbGpmeitKS0VncDR0alVuNzFJ?=
 =?utf-8?B?TzFGYWZWTVFLc2tBeDRIOFZtWitUVTNzMzhLL3lDdFhpMkdXcmpZQm1FaUZm?=
 =?utf-8?B?SHA3M3p5bDI4RUtMSk90MzF4M3R6Z1VlUGMxTmpLdHV2S1hMN28vVkF5dzhK?=
 =?utf-8?B?NUxQY3JHWWswVUdwSVZXZGZjSWFEZWIrV1N6RWpMK3F6NEFvWkt0T1FOMTI1?=
 =?utf-8?B?ZUNIZG5NdjdkRllzRFFzNTNhSEsyc1N0bUl2NGJYM3VhYXQ2U2JKZitCdDdW?=
 =?utf-8?B?eGVWRnpFK3BqTFhKTHhlZFpKNjVrek9aV0RUMkxLZDgrOUNONVVUTmgzQjg0?=
 =?utf-8?B?YWx1MWZZVzhNeUhpM2xjUGNJaExacmc2V21LNzdmaGNLQkk4OEtyUjFEa3dW?=
 =?utf-8?B?Z05xNnIwR0J3WlhLS3p2WFBNdDFGeHBoQnBCZ1VTdFQ1U25JVzRNSzM0aDBL?=
 =?utf-8?B?dzhJMGI5VVVNOUY3OEtrTjFTUDBodFIrcjdHM3ltSUg0bGZ6aVNxOERUZFEz?=
 =?utf-8?B?R3U0RzlOdGM5R1A1WDZjSmFUTlltQnpHOEVWbWFYME04WnlmeDN5Z3k4dUVx?=
 =?utf-8?B?T0txL3lNa3BRdVZpU29RRFk0cE9YYzVCTEgvRFF6b2Y4L3IzcWQxNjYycVc5?=
 =?utf-8?B?bWhqNWk5a1pKc3pjc0ZtdTZHT1dJdTZ2VWxkTjk3VTUwVWI2TXQyd2FIOHRQ?=
 =?utf-8?B?Wk1OUnBBRGQvSVY0eWJ1akNYV1l6a2ZzV3h6ZHdLM1dIUDJyMWplQWR6VVcz?=
 =?utf-8?B?aE1GSjJESFlrNGtQNHNuNXludGtma3BQSHJpSngxc1M2YVJURk9mVWdPamcz?=
 =?utf-8?B?eE01bEtMSTRjR2FoZjlrKzA5dE9vSC9EUVZEYjRKdHAwVDFEdm4zRmhjQ1pR?=
 =?utf-8?B?SDR5bDZiQ0ZsZ1oxMktCeGhNRTFQQ0dHVUdmV3VQOEFJWEtOajN4TkxIYk42?=
 =?utf-8?B?ZityT2VkcXAyS3ltcThzV3FieHQyaEk0dXNzanVLZWFZZkRRVUpQQ3Ixejls?=
 =?utf-8?B?b2kwMXpEZVJkMHRWdmo2MlBicFgxY200cFVYYXhML25DcHNSNXZ1eXlOSFVO?=
 =?utf-8?B?RFBrWXdMVkIydVk4cGJvRDRJU2Yrb0dOSUlMcnR5Kzh1WUZBemxaK1MveGtp?=
 =?utf-8?B?T0dhLzM2UlNxZ25uNGNZdzF1eWdPbkFPNms2VHZOMG90cnFpV1dBYXNZTVRL?=
 =?utf-8?B?dEUrUFNGS01lTktGQmpNd2dkc2VSeWVnZWVkYnM1VU9DVGpCM0xUbU1PY1Vp?=
 =?utf-8?B?czFNZ3Y3dnZ3RDhlT2lmdjMrK0tNcmNXanI2ZWY0dHVsUTJ0TklwWEZ4NWxz?=
 =?utf-8?B?Y2FHQ2FUN0V4Q1lhd0lwRDlJN3R0Y0JBcUZpOHpldFVSbU1QMm5GekFyc1FG?=
 =?utf-8?B?bVljUEg5WGFLeEIzdStMTmM1SGZ1VTdnSWhiQWF0N0NLU1BJSEk0ZFhhRjdl?=
 =?utf-8?B?KzRLMFkwS1FNc1AvaEN2RmhlRnNqY2dlN2hwaG9CbGFnek9BNVp3cE1HRU84?=
 =?utf-8?B?SHBZRTJZR25rSnJVWjJxSndQd1MyeWZQcFl3N3lPWmlSNWE0L3B0czRTZTBS?=
 =?utf-8?B?RmNuN1NWcnM4VHR6Q1IvQW02eU1rU0lsTldUVm9JdlFnNTdocUpQR1FveVh6?=
 =?utf-8?B?Q1pwVG5YaVExUHkyam1TWVlkZGFxS1QwYjNhRENuelAvb0ljQzhHN2VSdFJp?=
 =?utf-8?B?ZGtFQlFRa2N1RzhWUHRBem5hOUVTdFZBUUxEL1NtK3RJUkhuVWxqR3pldS9H?=
 =?utf-8?B?cUJybm5EelpDNzdHelNuTCs5S0M4S2txbU5YWWNFMEhZR2hZanhMSUdaeVA4?=
 =?utf-8?B?VkZ0RmEyazZEc1cweXN2Mm1McmREUlhhUU1WSzdNTXA0dUl3TjFXbzgzUFF1?=
 =?utf-8?B?QTUyQllvMFpwSEJucTB3UmJUeVlUUEtpczcxdk14dzA2YzFNdnVNRFRTdEZJ?=
 =?utf-8?B?Vi8za2xVNytjTnJsbnFWQ1BIVTc0NDVsWWM1c2x5R0loRE55SmtxN3dMVDZD?=
 =?utf-8?B?d1pqWEFhaFpTY2ZIWDZtbmdWSTM5NUhsZDE4ZVpESDU2RXFhSVQ1SjJwSXVq?=
 =?utf-8?B?NDlVUkd6SVczUHBFbytwdjFhT2w0YkphOUY1bUw3YUF6NzhMQ2RESVBPNWVk?=
 =?utf-8?Q?XMaDW6PiS2EBKl/pc8Q9xfxA4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3315204-6339-40cc-5e33-08dc83d1553e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:30:28.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3FYgbdMMSvI6npFli4+C7RBMYPYSeIwup0EOwd52x0LEk5ZUiBA0nwP2gRRK9IJkjSdzhQlhjLQWg0rk5cn4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

On 6/3/24 03:30, Borislav Petkov wrote:
> From: David Kaplan <david.kaplan@amd.com>
> 
> The call to cc_platform_has() triggers a fault and system crash if call depth
> tracking is active because the GS segment has been reset by load_segments() and
> GS_BASE is now 0 but call depth tracking uses per-CPU variables to operate.
> 
> Call cc_platform_has() earlier in the function when GS is still valid.
> 
>    [ bp: Massage. ]
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Minor nit below, otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Does it need a Fixes: tag for call depth tracking (before the change to 
cc_platform_has() it was a call to sme_active())?

> ---
>   arch/x86/kernel/machine_kexec_64.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index b180d8e497c3..90b1946c06e5 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -295,8 +295,15 @@ void machine_kexec_cleanup(struct kimage *image)
>   void machine_kexec(struct kimage *image)
>   {
>   	unsigned long page_list[PAGES_NR];
> -	void *control_page;
> +        unsigned int host_mem_enc_active;

Looks like spaces used here instead of tabs.

Thanks,
Tom

>   	int save_ftrace_enabled;
> +	void *control_page;
> +
> +	/*
> +	 * This must be done before load_segments() since if call depth tracking
> +	 * is used then GS must be valid to make any function calls.
> +	 */
> +	host_mem_enc_active = cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
>   
>   #ifdef CONFIG_KEXEC_JUMP
>   	if (image->preserve_context)
> @@ -358,7 +365,7 @@ void machine_kexec(struct kimage *image)
>   				       (unsigned long)page_list,
>   				       image->start,
>   				       image->preserve_context,
> -				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
> +				       host_mem_enc_active);
>   
>   #ifdef CONFIG_KEXEC_JUMP
>   	if (image->preserve_context)

