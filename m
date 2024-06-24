Return-Path: <linux-kernel+bounces-227381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB85915035
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3BF1F2383C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4082519AD68;
	Mon, 24 Jun 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YhMujQ3k"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5C148849
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240149; cv=fail; b=da8vr+SQUGTrCzctzP9YPgTy8paaih8hNFZ6DEKLqcSk1s5tUnGdMTDPMuJyNf4WX1PIRGwBenGhm7vK2+y6EhFhw2p5yvwT3HKI0YslQLMsKFhgJbeyjlByCHf+c+TwsKMWuLsx8WPWPimdkd7GEIMbvNUqLJeJItSWIOEJNXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240149; c=relaxed/simple;
	bh=g2JX9QCN7gYGvYOSBygfBblrqIqZNvdnXVTcD6mufBc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mf4B/gz4nc8dg21qG38hhP9v7jfIAM6bv9DpYEsZEDNhZPJaZNYiTeYrAQ/orlgtDhIx91P9SlZE2+5C9GQ+aqN7N0hqRn2/wQGTDkYcHqQmIDamT7sRAXoUP3mkxY2hsC7YGhwkao8rF0qZbC2FOsmqN9QPu+F6EcgrXefS7r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YhMujQ3k; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubr2BQOymwpoCDxQorWMCkV2DXWq/KkGkOB4Csql7DZimB85LyjadsSk1a1RMifQCbzif2z/SmmaW5hoGb0F33+hr44Sjk4E49j6W1WyP5q+2G/YvhxBgU0nnQsQnv/IU7GL6DCP1rSUifdSKmzk+Owqa1K6wt8jtUT96d1AjP1Ui9uTylO5a4J8OVszI1/zt+EZAJCyuxpq32lGS/9NLZVhlYzXFGdhIiQ/9O+tM22IFxZ20Rqk0YDeTNQWT+JpfyyOQnGRsmm6iSm6nDdjLQ1Urw9BPno0eFAuv9saFNIwdKZECIbp8GhavkpIu9H9YDgWgJa1xzEexloUJpYm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lenpssHttWTQ7LAOXb/Cv8rQkx6QbvfZ6Bgf/DOELFY=;
 b=fXqR9fouMxcx4uSYhg2UBmsQkcBwUN6YIJsGCU+Ci0DvA05WzuwfWZdAd6iwDJ/iJ2vpELDP+9MxWn2iHKJSG0HJXxZDA/3voxgs0ORIM1Oy9bNu9lMQDeiLXe579pcSqUnutJCx3pdsJf1dRSAaSdzjJs5cttM48g6UetFZKutG8+y/C6JeUBnqmVSYMLeX/biGeYsPCURLT9WZmeqnmMEg9Wr+PJkgo+9KK8lNTdw6JChvBeAGx8ESGXcFzcJT/89Q5ZR42pKi40uDO0V+CWu2Djf/CuIQvNgVwE4SYjUveBjdzeNlQ1oyAvvrD/gL5B2kuzWEoOIBvrsuDA0Wdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lenpssHttWTQ7LAOXb/Cv8rQkx6QbvfZ6Bgf/DOELFY=;
 b=YhMujQ3kbQSKcki+Fq0cNlu20dx+vfVA25aXMJRZcKY6UzqVElDcjWd7ZhVum/sGdRCC24+kBwh1hrdm6ZHysuaS0YrfJ6IYDqzbJ+ibxSmcpNDdru92igxr/6AzOSlNpkFm8tkBBOg9NJKNTKERVa2N4OjFpgACF7qU2uKy6fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:42:25 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:42:25 +0000
Message-ID: <943ca570-0ea8-fa86-0d3a-38b3e8e96ab7@amd.com>
Date: Mon, 24 Jun 2024 09:42:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/7] Provide support for RMPREAD and a segmented RMP
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1719239831.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1719239831.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:806:28::8) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce5ced7-4111-46c3-bbd3-08dc945bdd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mzl2S3NISjFBdStnYUM2MzlmVXcwNXMvejIrUEwrU05tbE4rZ1VWVSthSkhY?=
 =?utf-8?B?WnllN2tNRWprZGhxK01zSWMyWnBuY2dNeUdPWVE1c1lmMWFhV0RJR0RFcllq?=
 =?utf-8?B?enR5bDVUZHBOL3lnQSs4aUtYamxYUkY0S0o2YlRqaUJkc2tVeEJGZ3VTeDhR?=
 =?utf-8?B?eHM4QUM0SXp4R1l2TGxGRUdTMUZ6d2VldDBLYmJ5OWYvWWJTMS9QZmc4ckR0?=
 =?utf-8?B?ZE50M0RHR21RUVcwZG1lU2ljbUwzUjdVcy9MNmZQREJyYjFxWTBjaGxGQnNY?=
 =?utf-8?B?a1BUUjFWZ2tlVTRJMC9uRjlVa2ZibFEvN1lJSmZZS0laSGZva3BvNTBiNThn?=
 =?utf-8?B?YWpvK0pTMHNWeW9ZTkoyZHhORy8vQjd2Q0pOQThTSERFUjhTRmtqQ0JlaU9Z?=
 =?utf-8?B?Z3dSc3RYeHlmeVl5Z050N3Y2bkYrZnBPKzVyN1EybmJGVVkwVGs1Z1ptcEhP?=
 =?utf-8?B?VkhzdjU1SllVbm5PZEdIUCthME0rVUZXbWZNWkh0U0lSVVlGdHRrTnlVZXZV?=
 =?utf-8?B?ZVRheWZIbnJ1VjJPc1hQUnU1YzVjRUgrZE80WmE2bE1ENmRPQ01JSFZVbS8v?=
 =?utf-8?B?QmMzYnFEMnVseVlhYmxLRWNIbmlzK3lCdGRsRDh1RXJIYk1aYjNmQ0FETUtL?=
 =?utf-8?B?a2ppTldKV1VaUzVuWDdxcmdVWTR1UDJGcHl3VGFKeSthdTQ2R0lRUVlZK3Rk?=
 =?utf-8?B?RmExaGZuLzlnckJxa0VtUzlYWUxkTDNRQko5RXNsRWc2NzdPV095cFh2R0JJ?=
 =?utf-8?B?Ni9TaVQydU5YOEozNnBqSVNvaDE1Y0dzTG45MXVUWDRFOUZTemVnQVRKNHRQ?=
 =?utf-8?B?b1ZONm1mVzhST3pPUlNTM09GYVpOUWp1cFpCZWFkczNsSnJUM0NvSjl3RUZR?=
 =?utf-8?B?QkxPMTZwSzlwZE9MeE1UbU92ZkYvdWhuYUZ3aXZ5SUttRlBxaHJVZkM0T2dz?=
 =?utf-8?B?dWUrWjlXV0kxYWdjVlhkRHFnT09aZ2RJV0UwdWxXU1YzWUhoZEJrV2ZIVUpM?=
 =?utf-8?B?ZDBhajRVWjVyVXpRVUxocER2WHhDem1MdldMMloxR3ZGc2dZNllOREx3amo4?=
 =?utf-8?B?cFA4UHNsSDV5VzRva3diNEppa3hRVUQySnQyTHJYTzQ2dFlwYU5mcmVVOTc5?=
 =?utf-8?B?SGlOME5yTW9LVDNFZ2ZIeGhibm82UEdDRVpud1VPQU9JeDNlQzdSMTlsOVZm?=
 =?utf-8?B?alNGbm5HcHJLbTlqNHQrUDBFVzlrMW1sWXRiUThiVG9FcTAwSG01dVYvUTRD?=
 =?utf-8?B?ZHZ2ZU9odVhlNEhxWTlNTmdqUzFqMmphSXF4NWMxaDZ4M09Eck9nMkZCUW9j?=
 =?utf-8?B?cklKVDB2RTRBSStUYVNuNU9QRkhQVzFyWHZ4czRjem1SNXdFSWdicGllK1I1?=
 =?utf-8?B?NXgxRUd3WGFNMnpEZ05uNkw2cUovbGJIQk4wUlZ4QnN6RElvK1MrUjZnVmNm?=
 =?utf-8?B?V1JKcTZLRGFjcnZ4SWdpTi9sOExjdExrOWg4RjFwWjJVN2lhQlRWVC8wckFJ?=
 =?utf-8?B?VTZVMHg4cXV5MG81eUFPakMwbzNSbnBGYUtZbzJFb2k4SHlnTHRiWU5qcXUx?=
 =?utf-8?B?UStMUi9DWCt1ZnZXR0pIamtnVzZKQmNrcngyTTYvaVJrOU5SVThQbkoyVEpU?=
 =?utf-8?B?VVMwZ1lDUEZuMUlmYi9qbURNS3IvUGhtYXVZeEt6bTFmOFRWYWNXWTZPZ0dt?=
 =?utf-8?Q?PWHh5OYrmn4hE5P4QerV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJycUU1T0VKdDlMQ0c3cFViUFpLQnFCYnkrcWlOTzNDMWF4V0lQU2x3Sm14?=
 =?utf-8?B?dklRZ3BUb2xDWUh0Z1JuK1F1Tkh2WTllM3kyQjQxZlUwZnJLZmFpK2ZpbzJ3?=
 =?utf-8?B?VEFXTjZ4WUR4RDYvckYrWGpFQzBVT25mbFQ5YlRIWkFiL2srQXZhUGFMOUZj?=
 =?utf-8?B?bE02N1BiNGxVeE83ZmhPaC9QOEdPTkd3VGNFbnFxaWFCb1gvTkc4Wno5Wi9Q?=
 =?utf-8?B?RW9JN2pXaW9HK3U5a05vM0IwOXFQb1I0TFRKUVpsVW1sWEVVdzA0MXgyaTlD?=
 =?utf-8?B?ZWlmUitrM2l6THAwc3IrUjFQcGNscTJiMzhJN2JJNDZISEhJaHVvVmhyY1l5?=
 =?utf-8?B?QisyWFVELzl5bkZTOVFwVnFXT1QrWG9IVlBVL1FzK1lMZjhQRnlFeTFFSHpD?=
 =?utf-8?B?bjM1MjAxSFMvcEFTc3NHVXJaeGM0dEhMQWNRb3NvZFkxUmxzU0EySmJCMGZV?=
 =?utf-8?B?cjRlcG5sVmdVRXRDaXR0MGVXWnZKU1dsRnBYUk1sQ2NZYjNtQnBtTzVPVWFu?=
 =?utf-8?B?RVpYQlQvNEhlZmlOdTZSaHJHckpkZ1U5dC9DNVMzUHdZWUxmb2N3Y1VpRTFa?=
 =?utf-8?B?SENzNFI1RGxscW93M1NmZzZRdi85OXk2R0g2d1FTekJ0dms1MlJTZTQ1aVBL?=
 =?utf-8?B?Nk9LVlAvV25UaEFwZkhoRkYvWjlpZkt2NzNSeHY5RnJueXE3alBmYWNUa3hk?=
 =?utf-8?B?ZkplWHdqeGpETllvckV4c3liNjJTRi9pZVkwckV0RXFteXl6dU95ZTNqL2ds?=
 =?utf-8?B?L2swTnNML1Q2bk1HTVl3ZVF3YWlxNkxqczVJQ3R2OGwxRENvcURJby84YmVU?=
 =?utf-8?B?T1BGZU9mdHZGU1g3SW5wRk4rNCs4bnBEL0NwRUFQYm5FenkwRE8rclY4emZ3?=
 =?utf-8?B?Y0xkZ3E1UHM5K1I3Uis3eHRmNUJ1M3N6NlRZejFMdVVQTHRrV3VrQWNaeEdq?=
 =?utf-8?B?SGI2M095T0gxTGh2V2trQWFsSDNzQ0RvNy9WRXNIUVZVcGpIQU16MnRPUXdp?=
 =?utf-8?B?WkR3bWJNaVFoNCtZZytWZ3JUMmFhNXRtT3BlVkI2VDd6TTdVbytjVE1FNEZo?=
 =?utf-8?B?ZXBBQ244bzhSdFRWRlA0cStyR2h6SS9WWWx6WmxwaWlXYTcveGF3UUZKSnln?=
 =?utf-8?B?dVMvc3NvZVBDZDErUHdMNGNKNVFKQ3VGNkV0Yk9jdktteGJTd3BDRlVPdy84?=
 =?utf-8?B?SXA2ZUdtcXpxSzhEblNrcW90VHBXaytzUnBDR3YyS2l4NHBiRE1ERWhPbExR?=
 =?utf-8?B?T1YzQXk0K09SQWtoV3hzamI3aUx5aENQR01QYk8zVWUyVHdnTEx1Y0RGYmZq?=
 =?utf-8?B?TjQwaGgzNEw1cFV6UEpUbGNmTENBV3FQL3ZxQVZGUkNWT0cwOFhWZXBrSW9w?=
 =?utf-8?B?Q0g3emFiMXhwdHNMVkxmRndCeHhOMC9FZXQ3RzZmRG9BamlmVVQxMG9MYXB5?=
 =?utf-8?B?cHpyTVF3T0VhV1RtdlNEaGNycG9RSkxJSGY0WjlWMUlKdWZQSW9HaEJVOWE0?=
 =?utf-8?B?TmwzTHQxYVhtS3hNVm9QVnVFaWpSbnZVdnlWNXQ3K2NJUXVKeTUzdlY1eXhP?=
 =?utf-8?B?R0IwZUZSVTVkSXFTK2lQc05nbGNySnhnZU5kVVlIMnVLVW9GVWNiYmxsYnJG?=
 =?utf-8?B?eHpTRlZ5VnFvTHZyekQ5enk4a3RRa1g5cEluaEhEdTZFNmp0ZHRZTTVsMEZN?=
 =?utf-8?B?aUFqMkdCaisxQzgwOEI5M0VGaFdIODAyd3BHVHZabUJGZ3poWEE0Qm5ES3Fp?=
 =?utf-8?B?cnU1clhQazZnUnYvYzZtKzc4MkxzUU1paUhXekRWM2hoOENvQUlLUmFsNnRQ?=
 =?utf-8?B?a3Y2YzVsOTk5SnZiNGMvTGtrQ2xjTjdqOWxBcWZ0dEdXcTVFcUZ4dHEwaWg4?=
 =?utf-8?B?bVlJMU5FRERoZ1ZNc2hVSytyY2JvRy9lQU85NVllclFKbGI2bURXMmp6M05m?=
 =?utf-8?B?WnYwNWRWc1FEa1g4eHN6WnFpZUJSWE9OaW56a3diOXpMMy8xZGUwZWZLWTZC?=
 =?utf-8?B?ZjQ1Y2ZBczRHUi9ZalpBL1JXMzJsK1VEbUFHZGxEaUV2dWR4aEhyamo2MThE?=
 =?utf-8?B?VHJSd2h6akQrSE1OQmpXWTU0NHY1RWFYZ0owbTJzUDV3NUlTSWRNdHY4bXYw?=
 =?utf-8?Q?/RISUGGRFULR9IJcOQkP7pJii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce5ced7-4111-46c3-bbd3-08dc945bdd1a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:42:25.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZlM1RZzjHcefJQ0ADKnDFLAkYRDg36FAJ38ZeC3VgPEZ1FwtRMHMUBpdc7k5Hdf/e4H1OC+TxQrpZYtlwmbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

On 6/24/24 09:37, Tom Lendacky wrote:
> This series adds SEV-SNP support for a new instruction to read an RMP
> entry and for a segmented RMP table.
> 
> 
> The series is based off of and tested against the tip tree:
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
>   aedd5b6d65f7 ("Merge branch into tip/master: 'x86/percpu'")

Forgot to update this before sending... the patches are actually based on:

    2846f42562f8 ("Merge branch into tip/master: 'x86/sev'")

Thanks,
Tom

> 
> ---
> 
> Tom Lendacky (7):
>   x86/sev: Prepare for using the RMPREAD instruction to access the RMP
>   x86/sev: Add support for the RMPREAD instruction
>   x86/sev: Require the RMPREAD instruction after Fam19h
>   x86/sev: Move the SNP probe routine out of the way
>   x86/sev: Map only the RMP table entries instead of the full RMP range
>   x86/sev: Treat the contiguous RMP table as a single RMP segment
>   x86/sev: Add full support for a segmented RMP table
> 
>  arch/x86/include/asm/cpufeatures.h |   2 +
>  arch/x86/include/asm/msr-index.h   |   9 +-
>  arch/x86/kernel/cpu/amd.c          |   3 +-
>  arch/x86/virt/svm/sev.c            | 633 ++++++++++++++++++++++++-----
>  4 files changed, 549 insertions(+), 98 deletions(-)
> 

