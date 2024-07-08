Return-Path: <linux-kernel+bounces-245005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812D92ACE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B04C1C214BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE586631;
	Tue,  9 Jul 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sYzjRIXO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2109.outbound.protection.outlook.com [40.107.92.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5213C2F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483583; cv=fail; b=bpWh+O9fPX/jHxg36peJAPU91Ih+0F1dwNnhy0l3VXxlGo94IeggY6yYSOfEIWvAsR3JbEdI4rDVRymjcLLEC7/HrHZ5T+9JBqh/qmm9GBGpmMd2c4NZ0SY02SpHx9cWgxR1q+fB/bJej0Y/HAsEE0VF1nMP/QgunDMlerauTBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483583; c=relaxed/simple;
	bh=BMn7bXvrVgwdP2wVYRvJTvl2StXDkpm//M/ix6zOQK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=In7rM+3E8/W4WkVbsrvPWBq75LPWG41nIcie9p+6AfLs1FgaJ4aq6/0P75Drv7LK3yjckH04KAynhsyBfSB+2lxBL3rjWWKREJj4RVNgZhsTTlCjGWM6KwUaUvQAeOKj3Xdfzf4WIm5RkwI9BxTjjVGZoOqw+Bfu19RCqY/pf+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sYzjRIXO; arc=fail smtp.client-ip=40.107.92.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm5HfVf/qT9yJL2IAKV0nErHFOfBAkR23SAfSQgrU/sdwtLJNfmARPuAQSKKS6PbBLs8LdkCYCu+IzgjPRXTXz5RPNLGy+8on5VEJXO+WyFStmqOU4Zxy8BLTrBl5u5fEDJUWyrg8iriBRI4MZx3cC+Rh+2jKSxHD7WfUi3T5Zc82xLemWMPQc93qs8aAOLNgHTqWQaPF6uEVaIe7m/pw5O3iocxjPCmeEdOr0bC0Q3yfrpapLM7/UdoCqUTGQzdhkVT+kLHsNMKXBfs8iPru7XUPKPwMVaB29m/1B9jON5GEhkn3ZB3DpJFb9XsMJ+tasDqmdPhUUkJUCRfTuVafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/vxICJKyDS785BA4bUfDoZkqFCd8zWstIoTjw7w+Fg=;
 b=YQ1aXmfVyno4Bhps6RBYYHSneOlwTbnLDlYrZsOYKC5OH6M47cw6WK0mJQf0lYbbpUsXxnTGvDnxcefA4MO3+Sc8c8IVsuSkqpwKLUhl8iX9mNvUXZOwYB6CZ8dBzdJzo0EwPMKf08fjpNxVcC5dMsd/MQX7xYIi7hj7iy0kmA7mTkHdj8rGb5Bq+de7JxthRMfHZAXVslWYFwvN+6gje9aMp1vHAMokv+j+Jnca1IaSoW0pfMO/gGyi69LApUfw/jw9HiVhE4CwsARUZZiT8U/jnjEtsVzlWcYWqRgJaPaZVkpB2ZB5HuG8KWAwWlbbwrkxTYjDYru3kHD4McryBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/vxICJKyDS785BA4bUfDoZkqFCd8zWstIoTjw7w+Fg=;
 b=sYzjRIXOWJoRsAlQ0jMNJ18dKaD84Im+n7ASFCqHu8WvfH8Hz2Fj8DQX8Ey2R2fKxpvaO6XZmn4qLIzH8AJbXIb0f3fWg6pxzCOQzTkBTfkCCfibNrH/lI7ybyg7zWSLR6pUEUWT7nFpnK2y84Fbgk+CAjOnYCVGfdrGsvjHxoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 PH7PR01MB7605.prod.exchangelabs.com (2603:10b6:510:1d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 00:06:16 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 00:06:15 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
Subject: Re: [PATCH] arm64: limit MAX_PHYSMEM_BITS based on vmemmap
In-Reply-To: <7d7134fe-f97d-453d-b90d-fb81008fff40@arm.com>
References: <20240703210707.1986816-1-scott@os.amperecomputing.com>
 <7d7134fe-f97d-453d-b90d-fb81008fff40@arm.com>
Date: Sun, 07 Jul 2024 20:52:03 -0700
Message-ID: <86wmlwk0bg.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|PH7PR01MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: f631723e-5944-4e2d-9053-08dc9faaf32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SeTgJM+qGY0kv9+O/cyoyxgqrmfc8DihcxltuMF8NZF8kMOzOG71Wsd2EH36?=
 =?us-ascii?Q?WH1Ns3Ie41lTuAe63TlXOWyILIYBVRKhJpCDFswreLQ7ov7WQ1l7QjwCrQFa?=
 =?us-ascii?Q?US3dUQEZipasm60r9mf3slnoiyo6uQgq0GqMIl9hFzXVPNl4U30vjoTbNbB9?=
 =?us-ascii?Q?O83valSKp6GSGOVdcgg3Rsz1ZmvLcPPaMLSBhIK8GbSeRRa1r2YDrXCgGZ8z?=
 =?us-ascii?Q?9IsSLG9GBOmGcgNsbXAUq6tr5jsY0lOqRwRNjJuwI6kjC3SbiyKkN8xJw1rN?=
 =?us-ascii?Q?K1Y/E8Y9du+SEXFeugsOIQW/PGtS7kFQGamwJEORHUH27lo72pRsR48gkVzG?=
 =?us-ascii?Q?PR5TAq9QsrMQ8oamNlS88iRsRcNr85kZpqoDhHqgD2K0WC3j3LJ558yUJO0R?=
 =?us-ascii?Q?3vjXjjUMQe8QAJyVEgw4crLpG2HXQYzzhnTGULunlmf8n4hVhRXHLhRXiqxf?=
 =?us-ascii?Q?AAtJaIKYoIns/L3IoJHezBWzj2Aj+VVlqUUvFjulXxLv0oe9nrd9Yyfqoant?=
 =?us-ascii?Q?0Z5bbajZvhTA7vDsBJsjN4HMY8Mv30sE/db5PGsrO+0ZdcpPJ9nobwXTyv9V?=
 =?us-ascii?Q?SvyA9ihUaBJI3LxJyvR635iNzCfdyAC+xEsCG9YNKJbl1jlIhAp0IvtzH16j?=
 =?us-ascii?Q?mJBzCkuH16jChccAaIr3ZX1othriC50RdqBA/iSOqJE2GDk+6PU39IXD39sB?=
 =?us-ascii?Q?12JoNK+lNfto1lLZVpPAg5iCyOdIIWxAjjNJsxAa0dfR0RSSpvMOGHBfhw7T?=
 =?us-ascii?Q?VSVtVBJrJ7ei2PxlPgGPjLCXYlibcq7J0fzwdZd9OWy8opnOqvIr/v/qj0IC?=
 =?us-ascii?Q?TXBDq3/a77By57uJthku4jlgEg9FWegmo0m/HZujKW+mhpQP/0CY++XdQOrW?=
 =?us-ascii?Q?y7B6luUVzVCpIWQY6jrdqFY00+KGfQeKWr2v/SYHsLjonWZ/WGJGr+eIL0xd?=
 =?us-ascii?Q?AE8zY6llhvozPXjVtOLE58fjhoR4sGV0xvOTpRjA4/vWbtDcfMh4VIHvoDNq?=
 =?us-ascii?Q?+EtQqJDX5fifu9FAX8qtcY/eSdnIEsaPSyXeoKGT+O/CTUTFgjKCkCQlOmYg?=
 =?us-ascii?Q?SD+oj8pTFvQSc9vNr8Cf6wZ3lXpV94lUdxp+ZGhWZI1UY/TtHXh6o5BapGij?=
 =?us-ascii?Q?aqXprGGr93Vfju8R9bnxyy7LjoEVKV/0B9aXvc8mqVThhp9HI7eCJfaXHOMt?=
 =?us-ascii?Q?N01mncA14aYNcD+HB4rVBT8/CZed0K/chx4vD3ppKtb9CmgqdJq/opl5c5Cy?=
 =?us-ascii?Q?ZjhfWbVfToHEhEpi08acgRfOChf8GPoxRNwGt1/3OT1r8eG34LuC517uBIJ2?=
 =?us-ascii?Q?Qa+lalueElE2Bm0nKSnicgHNFLJ6w3yT/mqBCLvbFqlKk1owEzazgiYmV4Bz?=
 =?us-ascii?Q?mFSyLjcVvOE2XTvz4cI2x+R8ikYyfhTTlXPw40FYw7xJnrw/VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8L3dqztPrreI4/K38f/U0a9ySFvGPMWrEWsITVyiCBUVQhp8fFPYdF2oK/9O?=
 =?us-ascii?Q?YQsFzJke+a+ABeS4Mz+0x5VhlFD5A3Cy3EytwdR+8BiC+VlRn9kj5R8qjAq6?=
 =?us-ascii?Q?sLF+paG1cfMKcdFDfvERKJuo6nfjuKthf3IsuoJYTK3TssJG826CNpFJt3Z6?=
 =?us-ascii?Q?GWlCf4uJKJLVecpYcSj4dzziHTBmQLgi7RLqXJTyDhEaz/3DYfQ2yBglUcxZ?=
 =?us-ascii?Q?V2kM5zTdRxmkDBFD3fgXZTfacU5z1AmIaEFt5u5aGmkiBSMZ7pKOU8N26OAu?=
 =?us-ascii?Q?kbuPMwN0+S12ck5Xn08lb5rTsslDKRm64use2WYvVpj5J8Hfj5AdvZNNLlmX?=
 =?us-ascii?Q?foPJzQvLSsVyxYwhQ6EJrJUcMUxhzD+5uG+9yQJCdz06jDEcWluzf8AtslkT?=
 =?us-ascii?Q?yBZfe3zH+Sn0tP94lkuxtrMo+2j2urPjPZ/6WL5pKAsMPlLzFfDOiziGXPrF?=
 =?us-ascii?Q?WldiaxgP081n1QJFuD+eiTBcnR1OQWF5kNXkiRr4ObMK7b95vaWOL0RwPann?=
 =?us-ascii?Q?fihsGK1SBJWTTOAd16htKz7d8CrPHXv7S9pxmYBlf9fI5A9rRAoq5DuzVRc3?=
 =?us-ascii?Q?i9IHKMqDJaxFfP0hBoNMmmXUR2QVa4xClOi30u9pqxRxg/NrMpstIbcb4wOD?=
 =?us-ascii?Q?uuMFYdER2mM1vZv+Ux004MPu9xifV6uKnJgksoR9P+OqG00hPHIZM4vYy8df?=
 =?us-ascii?Q?gIwWsoJeebDcY9QJ8ZXE8QVPg5jbq+O1/fa+QYjxkX4oxuezQzt3yHP3yQC5?=
 =?us-ascii?Q?j5SiL9AiOvAyoH5+i7hhSgOmCkb5gfx5bVyj86ucrwCdeiiJVUJ+ZzVoRzM+?=
 =?us-ascii?Q?7sBBMi3fcMlc+HAnfPWJGf+cHQCndVnc/Z+Qs6ELOlp1q6q11qFwIZBmFYF2?=
 =?us-ascii?Q?R3ZL7Rdzk1peDYfVoQqEc9X7h9bdVjMj1V6FYjZJr4zpMco5iq5NLeYokVGm?=
 =?us-ascii?Q?DAmzxbmGLfz6gpPf1yg3vNEmgmJxMyBQN0XXdEBFnPkLE8bGKnuUfXSezL5B?=
 =?us-ascii?Q?XEVi3WIzjNodM11JvEyTzK0gRImAh4ocwTTudPAFRwserGPoMoVJ0k4GARrI?=
 =?us-ascii?Q?E1JgAx+HmvlhgIpRbEhf3A4uzpIxBddJBZVN3GM/LG1q6DzFo1ea0MvyFCvF?=
 =?us-ascii?Q?9qJoZv9w42lB3I6sRCwThjbj7VZ1URSUJLfYhLkN2FUr9CLv/tBLWV4qUlY4?=
 =?us-ascii?Q?Tj4EdKFTzCi0WK0venRVRuzRT584119zynAiIdhCLjGRg3OlxttAC51Wlgyo?=
 =?us-ascii?Q?qTb8iHeCUm5bqZZa5fMv080gHoX1zqgkUtfZ5w0krlftFK9dd4R7rCBbqdLz?=
 =?us-ascii?Q?btO71gJ2w0y5p98U/fHVFp1JJcg2qyGGhJeCiQTpQ5ODTQvg26pA+w2Nnslt?=
 =?us-ascii?Q?fxkVsWH8pspbXlNL6B04NLuU9aTuF8RqtcThBZ3elDVkIN2afYOkvgtkOoIF?=
 =?us-ascii?Q?hLWKcJAXEaK+3ywljuwwOCgUeYW1WB0oXIUTyjSZacexEAwzcU+b+7gn0SG9?=
 =?us-ascii?Q?F4zO5TpF6IbUBjnNL1bvkI9P3wAdd9HQKc3GG2xJVhXuR3tpJzdBKZG3CcK+?=
 =?us-ascii?Q?f3ZayZdQreSh7TfuJbYg1rWP7G05R5LWqjinbonB3zA53NLoGdxdJ1AiS14c?=
 =?us-ascii?Q?Mt9FVkAqjSSMLHHa8Tb4lkA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f631723e-5944-4e2d-9053-08dc9faaf32d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 00:06:15.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFFwxyASUmGx/h6tZdFQ05YENT+WwjkmtLSPlbSXlI4hxNd/Jcjk8MjG7CviKSYw228fKjTbb325gFkjOuaxYQ9H4IAU3u2BzUYjnY0PEEgaSochyK1oBvLR2znfxlwE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7605

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> Hello Scott,
>
> On 7/4/24 02:37, D Scott Phillips wrote:
> > Prior to the memory map adjustments in v6.9-rc1, the amdgpu driver could
> > trip over the warning of:
> > 
> > `WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));`
>
> Could you please provide the mainline commit ID for the mentioned memory
> adjustment changes.

Yes, it's commit 32697ff38287 ("arm64: vmemmap: Avoid base2 order of
struct page size to dimension region)"

> > 
> > in vmemmap_populate()[1]. After the adjustments, it becomes a translation
> > fault and panic.
>
> Probably caused by accessing memory which does not exist on that address.

It seems the changed VMEMMAP_START causes the out-of-range address to
wrap around to the low virtual address space.

| [   22.177085] Unable to handle kernel paging request at virtual address 000001ffa6000034
| [   22.186641] Mem abort info:
| [   22.192201]   ESR = 0x0000000096000044
| [   22.198720]   EC = 0x25: DABT (current EL), IL = 32 bits
| [   22.206798]   SET = 0, FnV = 0
| [   22.212624]   EA = 0, S1PTW = 0
| [   22.218612]   FSC = 0x04: level 0 translation fault
| [   22.226343] Data abort info:
| [   22.231992]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
| [   22.240245]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
| [   22.248064]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| [   22.256145] user pgtable: 4k pages, 48-bit VAs, pgdp=000008000287c000
| [   22.265357] [000001ffa6000034] pgd=0000000000000000, p4d=0000000000000000
| [   22.265362] Internal error: Oops: 0000000096000044 [#1] SMP
| [   22.265365] Modules linked in: amdgpu(+) drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp drm_buddy gpu_sched drm_display_helper cec
| [   22.292879] CPU: 0 PID: 564 Comm: kworker/0:2 Tainted: G        W          6.8.0-rc3+ #2
| [   22.300957] Hardware name: ADLINK Ampere Altra Developer Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.04.100.11 (SYS: 2.06.20220308) 11/06/2
| [   22.314763] Workqueue: events work_for_cpu_fn
| [   22.319112] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| [   22.326062] pc : __init_zone_device_page.constprop.0+0x2c/0xa8
| [   22.331886] lr : memmap_init_zone_device+0xf0/0x210
| [   22.336751] sp : ffff80008359b9f0
| [   22.340053] x29: ffff80008359b9f0 x28: 0000000fffa00000 x27: ffff07ffe3e3a7c8
| [   22.347177] x26: 000001ffa6000000 x25: 0000000000000001 x24: fffffdffc0000000
| [   22.354300] x23: ffffcb2dc0b21dd0 x22: 0000001000000000 x21: 0000000000000000
| [   22.361424] x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000001fb8
| [   22.368547] x17: ffffcb2d80f67db4 x16: ffffcb2dc00f7090 x15: ffffcb2d80f5cc50
| [   22.375671] x14: ffffcb2d80f6aff8 x13: ffffcb2dbea78a4c x12: ffffcb2dbea6d82c
| [   22.382794] x11: ffffcb2dc1661008 x10: ffffcb2dbea78a4c x9 : ffffcb2dc00eef40
| [   22.389918] x8 : ffff081f6fdcd2c0 x7 : 00000000ffffffff x6 : 0000ffff00004000
| [   22.397041] x5 : 0000000000000001 x4 : 000001ffa6000008 x3 : ffff07ffe3e3a7c8
| [   22.404164] x2 : 0000000000000000 x1 : 0000000fffa00000 x0 : 000001ffa6000000
| [   22.411287] Call trace:
| [   22.413721]  __init_zone_device_page.constprop.0+0x2c/0xa8
| [   22.419194]  memmap_init_zone_device+0xf0/0x210
| [   22.423713]  pagemap_range+0x1e0/0x410
| [   22.427452]  memremap_pages+0x18c/0x2e0
| [   22.431275]  devm_memremap_pages+0x30/0x90
| [   22.435360]  kgd2kfd_init_zone_device+0xf0/0x200 [amdgpu]
| [   22.441301]  amdgpu_device_ip_init+0x674/0x888 [amdgpu]
| [   22.446989]  amdgpu_device_init+0x7a4/0xea0 [amdgpu]
| [   22.452415]  amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
| [   22.458101]  amdgpu_pci_probe+0x1a0/0x560 [amdgpu]
| [   22.463353]  local_pci_probe+0x48/0xb8
| [   22.467093]  work_for_cpu_fn+0x24/0x40
| [   22.470831]  process_one_work+0x170/0x3e0
| [   22.474829]  worker_thread+0x2ac/0x3e0
| [   22.478567]  kthread+0xf4/0x108
| [   22.481696]  ret_from_fork+0x10/0x20
| [   22.485261] Code: d2880006 a90153f3 91002004 f2dfffe6 (b9003405) 
| [   22.491342] ---[ end trace 0000000000000000 ]---

> > 
> > The cause is that the amdgpu driver allocates some unused space from
> > iomem_resource and claims it as MEMORY_DEVICE_PRIVATE and
> > devm_memremap_pages() it. An address above those backed by the vmemmap is
> > used.
> > 
> > Adjust MAX_PHYSMEM_BITS so that addresses not backed by the vmemmap will
> > not be chosen as device private addresses.
> > 
> > [1]: Call trace:
> >       vmemmap_populate+0x30/0x48
> >       __populate_section_memmap+0x40/0x90
> >       sparse_add_section+0xfc/0x3e8
> >       __add_pages+0xb4/0x168
> >       pagemap_range+0x300/0x410
> >       memremap_pages+0x184/0x2d8
> >       devm_memremap_pages+0x30/0x90
> >       kgd2kfd_init_zone_device+0xe0/0x1f0 [amdgpu]
> >       amdgpu_device_ip_init+0x674/0x888 [amdgpu]
> >       amdgpu_device_init+0x7bc/0xed8 [amdgpu]
> >       amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
> >       amdgpu_pci_probe+0x194/0x580 [amdgpu]
> >       local_pci_probe+0x48/0xb8
> >       work_for_cpu_fn+0x24/0x40
> >       process_one_work+0x170/0x3e0
> >       worker_thread+0x2ac/0x3e0
> >       kthread+0xf4/0x108
> >       ret_from_fork+0x10/0x20
> > 
> > Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> > ---
> >  arch/arm64/include/asm/sparsemem.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > index 8a8acc220371c..8387301f2e206 100644
> > --- a/arch/arm64/include/asm/sparsemem.h
> > +++ b/arch/arm64/include/asm/sparsemem.h
> > @@ -5,7 +5,7 @@
> >  #ifndef __ASM_SPARSEMEM_H
> >  #define __ASM_SPARSEMEM_H
> >  
> > -#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> > +#define MAX_PHYSMEM_BITS	ilog2(VMEMMAP_RANGE)
>
> Just wondering if there is another method, which avoids selecting physical
> memory ranges not backed with vmemmap. Also will reducing MAX_PHYSMEM_BITS
> below ARM64_PA_BITS have other side effects ? Do other platforms have this
> exact same co-relation between MAX_PHYSMEM_BITS and vmemmap range ?

I'm not that familiar with other architectures, but I assume that high
addresses of MAX_PHYSMEM_BITS work properly for hmm as the code to
allocate a free range allocates from high addresses, descending.

