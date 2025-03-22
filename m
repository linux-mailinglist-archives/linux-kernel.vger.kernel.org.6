Return-Path: <linux-kernel+bounces-572135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43515A6C710
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F561B60AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 02:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1FE7083A;
	Sat, 22 Mar 2025 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="js3k8rrm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286A29D0B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742609199; cv=fail; b=NcUdQhklZmLQ3G9VknZw7BAl3GnN1KfQ2Xom8YDpmSV02QSDi9Ww9jWgjoPX/Q/yWjn0irpwIFtV56lAt5+/JwCPBHaJrWqVav8tcJw7zWnMY/BHRu4inOy3jpF5FcrQVGsiiUKJZ3lEjei/MPdJX5t3DM3nM8qUMKAhchl+RpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742609199; c=relaxed/simple;
	bh=i4OiMAikXFO/0NPIpVR9E5jTyhd84FsbuJ8nR+OcJq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5PpdilTFiDH4Ozk62H/8kZTpvGVoSnyaiN558/YnzScWxL33HMG6jpnXi6btRmSzoNR9GhHdZOwyo0vVxxs7j/Hu8RZNO2VkFCsUlib5/mSwctPd+i9E6OIBhg50iG7wpvNCR388OcvssgTDWTyLSmaLFTQRrJs+cSLCOUtzcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=js3k8rrm; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf4YfASnFxQGrjQUVtcsc6oERLgGY4XyGPbaI7gXgmjwh8/HqQexmhbcwRKwvWIB14GgvQyLOegiM8BpHj3a5oBjUVl+/wV2aXA22N4Iw8v/rxYlDCcWSLbd47R7lD2G4ehDOYV4foOB/Rgt6JJfYSe8NVsP2q6Al+fTQRLL+SK8Qb4lcujLm76rA3yM2oFSmad0Pc3BlgrpxprbM6BOW3D0WR0AzFYtXVCqP79Wun0x1jKH62h0NsgHO3lpN+hCvam0IP/MrT3A7u66cDPE46kE4gwUtYkQgZFtWvNR0sYPXUY8SAn/4MtSEv/s+tx00kuLvJQqPpf9X0+Fj6ZIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0bOuFigRCkwisnJdtABOgvz4lXo/93flLTY0nK9qXM=;
 b=VdoDabbjjUKyjJOH8JqRBz0GhV6YJej35mIm7jptVp7MnEi4ACKPMLrIEbSlNIbf6RM1QGyhS1FCkY/RGN8Ls4NwAIZ7PB1QsVYpNf+zf+tS3Hf8J+5HPaakRte4uX9yCpXij76CBdGLrHdOd+Eiz9Xu7UCCaFifTw0EIuuETUts4TeqISJODc1TQ5YqsRJTOoRNh4RlNSomYoERzHf84K69yrR6s1MEmSmJ/vLLaDU7EEVxzVuPqIvjYDdBvECYiev94GGJMQ3ibScLO5ScLCHkTftbeobZw65LJOhSRPQYm7JJZkGm4Op5qVCKcoajOqT1MePtSs8GDcNrQBZoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0bOuFigRCkwisnJdtABOgvz4lXo/93flLTY0nK9qXM=;
 b=js3k8rrmON40PHd1T3DXMi4d7eDrZhLP6LKcYfFvYWbypySagSusJNTP/FuWsUT3qFCQDUZsiBa7HxagEPlo1twUP9clPumPKDmHUZsgc/Azy/wz80/8wrZlDxiS8vabQRfQA/7onvFsDIE0NBKtYqtkD74hP62b8OkvZ7bcJzdXmGveplhKat2tWpC3F5XGDaN7dZa3Y1m9/3rUAGtsJdQFgVk/RauEZ13NfvUl4gclnz8i9+uB6AvNBc1oAqCAQz/Zf8zjl3XYigyKTVBQ+xLAt+O2ZSmuz7b+/0wRmONaupGQCTzOKzT9a+LAaVRwXWKNHU3133JiI+b5ergH3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 02:06:35 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Sat, 22 Mar 2025
 02:06:35 +0000
Message-ID: <c5e5b3a7-e8ab-42c8-a33c-ce2c0dd21344@nvidia.com>
Date: Sat, 22 Mar 2025 13:06:29 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <841287f296579671dcd91329a49feed97186bcd3.camel@web.de>
 <d3580fa0-df0c-49ce-aa4e-e8c945172939@nvidia.com>
 <d2158680b8962c248c9faada97f2a93b3fef1842.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <d2158680b8962c248c9faada97f2a93b3fef1842.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0066.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::17) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2f1762-9238-4418-03e8-08dd68e62c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S01KVU5mazhRdFdnQy94VHd3a0oxMjk5RldSV3pFdjA4TGhjVjF6WG41ZjZu?=
 =?utf-8?B?aVQ1UlNIdURXQ2s2V3FMcjNlVWRRVE5pSHo5cktPMUsva1RoeFpGZm5iZTB0?=
 =?utf-8?B?KzV6dmdFVTJvQmI1Slh4dGRibGpCSng5disweFVxNVhmdnZEZE5OVVV0VGYy?=
 =?utf-8?B?dDAvTiswdXFkeVd6WDduWVhNOWgvVUdiSnZZb2YwRWplSHBCWlhsN2l3SDBh?=
 =?utf-8?B?WXI3RytUbVZra3NkNGpBTjZ5U1dya25WRDY5YmgzUFlVdlN6NFYrak53Rm5H?=
 =?utf-8?B?eTZ1UDFFTG43VThBWEx5Ui9xTXI0dmQ3TEdKa1d5N29SNkFldGpuRGp6VVhC?=
 =?utf-8?B?b2FiZ3NSQktTQm16c09GNWlpMEhxVi9TT3NtOGNxcng1bDdaQmt1aGFNeWtP?=
 =?utf-8?B?M3AyWFJPNXhGdEVKU2tqNmNLc2doRHRoN3Fxbk9ibStaUU5mdllvOWhYNnZQ?=
 =?utf-8?B?R3FXMHFQWXRueVNoS1A1enhNKzlldWJzZnZkVmI2RUFRV2c5UzBscnNPRHUy?=
 =?utf-8?B?eEgvR0x1ZjJBcVJWL0tuTzJVMjN0K3FqQzBFUXJrcFFxcUdzZ3dvWGpJeUMv?=
 =?utf-8?B?czFPclBmWWFJU2FXcllseENqWExkTVMwZEwxUVZOeXE1WTVqWk0vNlNnS2dF?=
 =?utf-8?B?a1JBYWxPYk8xN21ucC9oMDdjcmJ4OTV2alE4VlMxcjJiaFV1bmdTU25BRkV6?=
 =?utf-8?B?WlNMZjFsNWhqdVRDZUw2VmZ2Zm80SjBxQmFhaXB3QXBXSVlmM29UVEUyU3lN?=
 =?utf-8?B?LzhvU1JqSGtvYTlYbUpCQjdQUE4rektGRWxkNkt5eWsycUhqbExHRUh5cTJu?=
 =?utf-8?B?c2dra2dZZSszUWIwaG5KYk56VWhxNWxUc2lyNnNSMnhhTmtmeXRFYmlEVjlt?=
 =?utf-8?B?ZExHNmtTYXBES0FxcE1OY1pnajRtRUpOT2NFL2trclc5bStZM0NBSHVZeXd2?=
 =?utf-8?B?bC8yTkdnbFg1eUdwU1ZnQXQ2S04yWmQwMFpUcGJKMXhRWS9NMkV4eE8xOWtn?=
 =?utf-8?B?TjdEUld3ZkdZZUF6bVpqbzhuTmpDUjcvZFBaSFVnZDhJRFRsWXRyZTR4TXBz?=
 =?utf-8?B?WFJNZjg1TGdpc0VLWGFVUnpZVVRxWHZ0TklOeENxSUdaWXJUdTQxd1lOVGdX?=
 =?utf-8?B?NUxUT1hHMlJWcGh0SWNaMU9JWWN4VkpWM2c5Z05YQnQvVm1oK2pIcW9jYk9T?=
 =?utf-8?B?ZUhrWmdVV1BidVl6RXgwT1FWcHo5ZkJDNnk2RFJ4VFBvUGF4d244UUVpMHYv?=
 =?utf-8?B?V0pPN0NCcURhTW0rTndMTVdlQVg2T25kRFdlVHJPdk11eU1XRzhSMDM3Y0xZ?=
 =?utf-8?B?cTNUUWc1Si9PaFcreUowdTVWbmVwcmMwdHhTMmtZditjQWZUV29qNmJOMFRn?=
 =?utf-8?B?ZjFReXo2cDM5bUVqVENqdmFVQ2lTNk5HcVhmb1ZEZW9WbFFWV2hVY25JNHVK?=
 =?utf-8?B?UkFobEVoU25kM0w5WVBNN2tnZGZhVmFBK2FReEh1S0NRV3MyUEJ6OEUzbHlV?=
 =?utf-8?B?eFh4YjhTSkYwZ1JYTU5HMU9UazVqSEFUOHhURkJKUmYwZDlQeTY4LzJacm1B?=
 =?utf-8?B?dDNMMi9ETmZzU3UvOC9kYTB3cGRDaXdZOThwSzdtZ2d1QUN0QzN4cjMzTStl?=
 =?utf-8?B?NVpSQTBBQlNoejlkcHNBWDFPckpwU2xVUDA4aGVhQm81MzNVVUx4UkwwWW1M?=
 =?utf-8?B?dGxMVEMwdWZuRXdIZkNmZ1ZPRkRFNXFyb1MxQ1lDTzc2RSt2SGVXaFA0N29N?=
 =?utf-8?B?ZG9udElSd0c2TkR2VGxXZ0w4YlpPaTBxb2hRSmlKRklwQ2hkOFpPQ2duN2U2?=
 =?utf-8?B?QTVoS0Rqa2xaVmJHa2krN05QOFV0L0VTR0VXek1JaWZ1VHcwcXJpbUxJcjZF?=
 =?utf-8?Q?HgO8WDyHmMI86?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Y4MDVtL01iYUp0cllGK2hVeWZ2MTdzVmREVStlR0FReGVYODdoUllJaVRG?=
 =?utf-8?B?ZDFZbHpXN003V28rK2lYa05uZ280MGxQdm1BTW1yOVp3ZkQ5N1RERTArSHdL?=
 =?utf-8?B?UTBJbm1xOGtOWnRucEFyZVhTNE5aSnMyS2FCSS8rN2FDMVUwWjduUUpzcnMx?=
 =?utf-8?B?cXg1aklsTEZpVm81Mm5WZ2JRWWRuVXh2cENUUWtVTnB6dUlzWTdYOGpEWXNa?=
 =?utf-8?B?dytyN0VLYnVzd0RQTllpWDVPYmpTdllWNVJKU2hyT1VkUXd2TnlQd2wza0xS?=
 =?utf-8?B?eEp4L2p3TnhGanVJNG1tb1lWM1hhNVZVUXEzcVJVeTNqcFBvaTZqZ0JlUzRI?=
 =?utf-8?B?OVJyNXVJdmdTbmtpWG1weCtJOHpZWWdTNWtKVnJDUkRNdFhqYVR4VjRnZnF3?=
 =?utf-8?B?bzEyRVFmR3Jmc2d4TnJoRTZjOWpCd05FWGRwc0ZtWWQ2UElKY0t3eHh2eG42?=
 =?utf-8?B?SWhTZ1VIQWRIOHM1dE9lLzQvN1NDaElaaDFTR1N0TjMwbGdDWTVUWUt3QUpv?=
 =?utf-8?B?OWtySmFvRFU1RXMyMGYrV2VIdm9QM0FWWkNUM2s4bUtwTC9jdE9mNThibGRO?=
 =?utf-8?B?YkRqZzFJR3dBQ0hxWmx4REg4Z1NPMFdGMGYxS2VnYTFva2RZZ1dsUUtMSnRP?=
 =?utf-8?B?Q2liMk1zLzMwTDNuMXI1Qk5tODNZQ1owM3BodDhDWk1yYXV6VFhHdXJFdWsw?=
 =?utf-8?B?RWE2Y29uMkVTd2dvUkRQa3VEc2JaaGVRL2RPQVZrUjhjU2RpOTN2SEwvejN0?=
 =?utf-8?B?T05TVDdmREdTRDZGZjNhUWtKMEhJSlN0dWs1TUpjcnY0cG9zNmFLNUYyVUZl?=
 =?utf-8?B?OXVybTloWUo4bUFKMVF0dkplRkRJdXpVYU5mdERUSG9TQ2VsL1krYXFWa1RQ?=
 =?utf-8?B?L1FLdVJTbkxqaHE0bFlVM3JWOGRlN05lMTJhNUtVNmhCZ1hpeVk5UVFiTGRs?=
 =?utf-8?B?dmFlc2s2WWFpbjJFZktDYVBBTEdlRWNZTHNnWENyNkVFV2NKSk5Gd24ranZj?=
 =?utf-8?B?bVFpUXdHUllwNEt1NXFtY2FUSXNueW5TRGlXdTVwcHA3NmFUQVhWdElnQ25y?=
 =?utf-8?B?SGp5NkxONVhPdnhYR00zKzV0aE11MGlHVlJGRjZIaHlhRUZ5Y3RJMTMvejhC?=
 =?utf-8?B?cGVhU3NWQlFMV2lWK1hwakRzS3NWS1J2dmkxWWJ3T3NUWDVMQWZ6L1FSWWRG?=
 =?utf-8?B?ZHhSeW5tTU01ZXRRMndVME1DeUxqbHFkOWVLRnhTNGgxWis1azdsYlZyUVdZ?=
 =?utf-8?B?Y05pVzBvenZKT0RjRUNTNURCUEpNVkNhdVVMSzUzQ1NGOG1xWklVMGc4Vy9v?=
 =?utf-8?B?a3ZuYmIyZzRmTzJITHdUSVVDU01NaWd5cC8zV0VVcGJpQlhLZmVlU3U3Ynln?=
 =?utf-8?B?a0NMUXg1aGVTWTh6dWRnMjV2ODM4eTUyaU8rUHl2UUR0YzRCU0EyeDFESHRO?=
 =?utf-8?B?UEpDb1E3QWREcy81STNCTnd6dmNzUHBocmtla2QrV0lLZHpJbjFPQXVySE9C?=
 =?utf-8?B?bmF0NTNNbUh5Sm9lSEN4Tmc4bnk1bFNBQjhnSkR6SzZMbE12MWk5bVRlZDNX?=
 =?utf-8?B?OVRvMTlETGErVWdjVFcrK3pFcXk5MTV1YWZmR0F2ZFRKTnMzWVdFUkd5eEI3?=
 =?utf-8?B?c1RvWDRSNDkzQzkxWjhYQjg3MDZnS1A4WDlrbTUzUFZjeGRnQjVXcHVnV1dw?=
 =?utf-8?B?OEJRWFh0M29RMlF3YWFESFRGZWF6ZWFJVm1oeGRESU9SdXk4cGxDZEdsQ25B?=
 =?utf-8?B?c3kza3llTUxBS1VEUXpYNjhzczlxV21ndm05ZWpsb3oyTXpENEZFbDdJbHRx?=
 =?utf-8?B?ZDlmbHRCaHBnSjdSTVNhK0dKSnIyaVVPbTFIMTJPRlRQMmR6V1IzMkVieWtq?=
 =?utf-8?B?Y1A5UTlyQ3JMVlpKTldGZkVHQjhZa3NUOVNBNHJLeDM3cU5SREFpVEFpS085?=
 =?utf-8?B?T3NyS281WTFwMzNnTVpCR3pRbnZlY08yNnhSSXFaQkVrRFVYVEtkdDZuV1N6?=
 =?utf-8?B?bU9FdkpoNTNad3Y0bE9mcXVYOThMYnJuUE1lWWV3TVBlMXlHRDBES1diZEhl?=
 =?utf-8?B?bWRuMVNNUjkrNEJ2Uk93S2U3c2VSUVliU2NiYUJNSVpZNGxkWUdUNXFHOTVE?=
 =?utf-8?Q?BICezlQsA8OgZ3LqJE7ye023W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2f1762-9238-4418-03e8-08dd68e62c5d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 02:06:35.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U57fxME+R/0AwBVRsqdaIp6lReF7GwQLT1HBnJqBPIoxrJpKlJaGVXZLHVD+uoHGc3T3m2vcP6Uh0k/RV9e5zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

On 3/21/25 23:26, Bert Karwatzki wrote:
>>>
>>
>> I am not an expert in amdgpu or gtt_mgr, but I wonder if some of the deletes are coming
>> from forceful eviction  of memory during allocation?
>>
>> Have you filed a bug report for the nokaslr case?
>>
>> Balbir Singh
> 
> I did some more monitoring and in the BAD case ttm_global_swapout() is called
> 585 times leading to 54495 calls to ttm_bo_swapout_cb() while in the GOOD both
> function are called 0 times.
> 

Could you please check if under /sys/kernel/debug

You can find a ttm directory under that hierarchy and a ttm_shrink file? Is anything
writing to the file (like the game?)

With nokaslr, do you see a change in the game characteristics, like more simulated
objects (an increase in fleet size, simulated objects)?

It might be interesting to debug the ttm_pages_limit to see if that changes when
nokaslr is enabled as well

Thanks!
Balbir

