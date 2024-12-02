Return-Path: <linux-kernel+bounces-428142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E19E0B38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C1FB28BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424F1DD9D3;
	Mon,  2 Dec 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PvBecX+B"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866511DD863
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162923; cv=fail; b=YdKnIzOxb8kCTNs3lSZbh+6uhZUC+cg6QJZY0F/+Gk4RbM6mIUQpPhx7c1yT+kjgfHSLDh2YitGjeuJu38eN6vL3RvUtWZivvfYba6cyGpkyYJ5J5azD218Dlq41RTD39lgbYJT4SaU8j3miU3xWkaKhXglNPy+4SCGruyTm41c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162923; c=relaxed/simple;
	bh=N3/Md6xJjOLVZylxWC8bIm3nkvCeuq2KpsObkY9Z+KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhQWcH50oGAcUesR6x5CDCPhW9wIw6TXfZpvKhpJYjRw6nVB9pZ18QbMav7UldvC2KVFJlmmKTS3t9OwARYkRNuV49efa6cejndnn0rHwQMbFrn7J5bC97bAoI8dwazrO8fOVs+3a0dEXkT2M3DCqsjo1CdtWxpj5avu9l0+ThA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PvBecX+B; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtj5mQ1nQ0zlthydZ3Us0I8KogrAFsNvS1kzWUaV88y+D8g4kb16uC586v+fX7H1v8ao3CWBnJareA5u78sTCVHQdPeISMnehDFM6J+zUKufxIvqyepQBvD5IYwE+Cd7624D5y19g3mXtJnCf04zpY1FJ1xtv6tBfN2NrqNe17srdrqBUWHlE6svIIpr/seDnFhsUSZpx6+Z9CBser2e9HhffgguG5hdEq6Ft8Dy/EmDQAbOUdaKtr4EsIYMCwVv9MTvtahKaK6KcR00oxdwJ67+Slj20gG2On37p4z8JumvZRnoFDQLeOZ+v4s5MeFeMhDROX8USti+XR29wrU9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thCjgzNJiCM2g6Pp9BYSlFxJ0y5I5dcxwgAyxt8IKLo=;
 b=FfSeipxgT3HHGQEF8koQ4CGGNrcHdagLNKYCFyD9Z4P9iHhKRvLHsDz7vh7m0XqGdLGIYtKLfCo96vAfNQBgVv4+Jlcnjvwstqawc8o5IZII0xJtWsbrfntt2aeF6JR9/7H2smOi6UaFVmx7HJRVgVqjXfxM2QoLh4mxOLNfE0eZzl7am3VwD/047nXGLrTATewjyr68ouOn91byJDzp8L0NrZgAOlTU4ICnIojpmElgcgd63f5rraWjj2n1ODc8REP6BOAW+3Tn5sWb5NGEcCED9BJdya3tckhkpbJb31Cf431npDxOG/xtAbYlhRpuAHiW2m6AYym4wBYvXRK8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thCjgzNJiCM2g6Pp9BYSlFxJ0y5I5dcxwgAyxt8IKLo=;
 b=PvBecX+BhgRCPhCvJbfbiLp9Z0GNGdGsx5kjHcTgGx80luSeMLoDjF1upfyl4N6kd/qlnBGGSEwuRfkw9LpCJhXQBG7hUUVL1PHn0fYPcUJyQSLAjT+4hLC2aWDry74ogWcR/kaNlW9cJlpbsXKbibAcYVJpzvWYNHcZJbz3bI2RPNEccVdAGM1WZKcGPwYciivsTZl3trBAV1e+mZK0tlJpjiTiA+B/28Tiwj24mTv+XaHIumINhKMP1Na+wKQy5s5jIoNjEGUnXa5u4K2GctMUpLkyO2lYuG/FxADI68bdpfpl90XdNAnWwYTC8tzgK3p/BDfl8zpR2AxH9aqp2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Mon, 2 Dec 2024 18:08:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:08:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v1 1/6] mm/page_isolation: don't pass gfp flags to
 isolate_single_pageblock()
Date: Mon, 02 Dec 2024 13:08:29 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <ECFA727B-F542-42E5-BE32-F9FB27F5DCDB@nvidia.com>
In-Reply-To: <20241202125812.561028-2-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
 <20241202125812.561028-2-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:408:ea::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e90ff17-2393-42ea-86ce-08dd12fc5787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cqOyrpLmqy9vpAJk7sRmjcDB0eobxtJ7jeBA2EK1DbffagyVc1olVZgf5MP?=
 =?us-ascii?Q?0lrdF6w2D/w0x7UxIp71bN77GXEHIvcB7nX749ypq9X8XHGLzZ7jqfqAFjqj?=
 =?us-ascii?Q?BBcc1LzNLB9YybwYQz1/ALBXnEAeqPgMdh4HdLfscxS71z496B0z+oVz1FeD?=
 =?us-ascii?Q?J+c/VoKRGrQkt2cc9aCs0ynzojXcmHgPCQOpL71b7sPls+WTzwcKYMpc462t?=
 =?us-ascii?Q?wp95/3cNSreUv31UfMqJjfTbjhF39vay27BMYjgMlGftjkPX+UhDUMYm1QGu?=
 =?us-ascii?Q?JImeeQGkdRO3t//s6Qho/ugY+zU8OJTSfqiXZ4W+0FwanTUPtqeG/6QXMrhE?=
 =?us-ascii?Q?m6PQaY4wbeSG4NX5mvNL96wpFkbo150X8S5ncdWFMuj0qqOz2sPrvsakEhIi?=
 =?us-ascii?Q?9PB1ky/PQSqVZr7LJTcaGq15FpwE70HBPvkh0A3wMbcIK3gaKVv3ISBKkOqy?=
 =?us-ascii?Q?CKGZ4rKV8Zkw89AlYXqCnn6pyhabQYyq0JCexHdQ1mQKdp7OxyKWi4yZPqkL?=
 =?us-ascii?Q?3KQ+gqvjAZxSB/yes34giv7QuUemOCTTPdilrf3qrB+Ec9Ua8BSAfYPfbwYj?=
 =?us-ascii?Q?KhdKbYwU9fKWldsByrDFqocW8Cfl6wAsrMRBfgg9ZLYcUu5WePOFv8jHEjob?=
 =?us-ascii?Q?gcxYUJTHNALADBnASCxGAZiNXVlWiIZ9MSQ7A5XLSbyxVLDNiLRlkSpyuSXQ?=
 =?us-ascii?Q?MTdK+yz4dSakJxxUV6hZPmkQion0P4h27be/I4bKDuqr9eJAxKDhH01e+hjj?=
 =?us-ascii?Q?MITtmJvBCzU3/oRSfLnJtP64YiEMrhPiLLDRhb+vgv042RxbNuMCqApLBzwA?=
 =?us-ascii?Q?ZzKU4d4Osib8yS+/3tsNFVtT9YG1NeuglCOWI27O2vEINUXM66gc/ApYWQ7r?=
 =?us-ascii?Q?05NdwuOyIU8CaTzIMNEPfNuet6eiJdjsEAHFzueG6HJ+ttRMgcoIxl4DZ1Ol?=
 =?us-ascii?Q?nkzV3eaVOPO6bF2cGnJI6bVvSGvh0fu3EbVx+XysceuldDME/BX1Nv2DSNuP?=
 =?us-ascii?Q?pQiFAJoiS2iyMyIvuM/QqiBJY3NM14p+THhgPTbKRW0fso4MoMjsZHX1EwZC?=
 =?us-ascii?Q?x/lMdXTe0tiILhnEKCyE/MIZCzLvf1IrDa8WMejp2newzDbhwhOZMWMAK9/F?=
 =?us-ascii?Q?fUYb+U+gKPKUtsTgDmjLVtxcFQxd/HarP9mZrLHnmPwEYXifZ7aIpijZVAUa?=
 =?us-ascii?Q?njj5B+6bylAx/sZFvKPJuskCXeraiEkDlLpoSAgSqtacPEa/MGT++AjRzGtA?=
 =?us-ascii?Q?y5GZ3x9OWP8XW70Z8TCv+PaoREH0Xm0sN1unAJeCXmh04Tsc7h5+xA4GhIJn?=
 =?us-ascii?Q?alcskse3VBfC8DQHnh9Nc4P7pxdLIGlk/musNNGwv27S4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQNNt/6r5R3peixAU9FkdLESIRy5zhXXgjNrt+Q8XsWMgkSmv9vjCNZxpBhp?=
 =?us-ascii?Q?6vGX8ka9bDwpepS/DpW8xrtuZvwVCMFhe7r02BY/5GRXHiFuugZJmfUgo0Hg?=
 =?us-ascii?Q?ULGa7/AGCofikmM92BYaztPgwBiLOmZ/0LXQKT+m8fD/5oqJJi9W01MbYPOj?=
 =?us-ascii?Q?Q0JQVdtPSXSSbMbDEoFovut5szmRDQzl0NiWdTONpaGa2uK09RjDL2Elf/MG?=
 =?us-ascii?Q?8O0wVTVy5jcAowVC5G9tbLfofBjQRQPFRGzB/vJcAsN2XgEtGMnYSXf9RRca?=
 =?us-ascii?Q?vowsp8ki+3BhBQ75tRo+DBhJ8IPNWyzs2kdxFpVoyTpSJjY0SJilclZ+jpNA?=
 =?us-ascii?Q?H4iMbiUirsRPHhZzGKxnQ7uOtZvAb/MCc9TWRgRzgVU3XCqbBy9X0jdq09RC?=
 =?us-ascii?Q?EuQgYeglzBkp8kkfDPrDE5WvW+51elQHRGbcUIH+60s2/yfxkOhoi/+bj5t+?=
 =?us-ascii?Q?r1/X1UTn3xABLEK2B5xsBEY5Nj/V1HRp9H2Ffl17dc/VZDQzBode3u5Knd0m?=
 =?us-ascii?Q?zGErk2vdDSbBa9JFpCBVyvEEnv/tmoL5FHUo9oXwgwMtINkNgXORUQBU6CpW?=
 =?us-ascii?Q?jKcNxE16QybEcPoauBORQ1nvsjHkhAufzxwPjn/iDjPEyA+luezXklsbj2+L?=
 =?us-ascii?Q?VdomFgiiCqv3XH1RxfNI6MlF2uWEo9VbKv/XGyP7ufCX3OtifmLZ3+AgA1tX?=
 =?us-ascii?Q?Nck8jofz3+VT59PFiyKrrVUA30mIpjLDJ2L98QMDo2k2MGzmwaYrTEya0e5d?=
 =?us-ascii?Q?xu35fQRz8o9U4KpOHNF78apUlMZgn9hj5mx1C9CAXmd6E/QdR6Dy6QecU2qK?=
 =?us-ascii?Q?QiegMFo7+2s7bEBaw4iHf9A8F2WINjLWHdzsrtHPcu6pz3Qb+/8UOJQab8rr?=
 =?us-ascii?Q?NqqHx7PB/wH+uTRKaTh8iuwrbvSFySdrgydOjwT2Zbv5p6lVqOY4kdQA87GY?=
 =?us-ascii?Q?ZU6wqVJBgIOtoT0Qm/UBJ6FTg4NvkgGq7dVxnwh4tXSwPGPBeWkLv2pDmfPc?=
 =?us-ascii?Q?n2TsaN7p4tBKMKSzKzKuKj5BfXOSTevRxriRf3Y4RSDbI+7WSt9joOwYJ64q?=
 =?us-ascii?Q?20DYIoAD5/a9YGBO6ZJLo1rbHqV0bvkEINhRCxan+Wc5CTDN/dcxyPOMU60a?=
 =?us-ascii?Q?oZcVwUxq0XH7kXjQ1lKPCAojKyVKkIgCKWiCQh9cL+61+oRF8XOIhTsUFlJp?=
 =?us-ascii?Q?A70tue6RlQJf4wqjXNrlbG7KB4ulP58+bi869kqcHwozL7sJHZu88riCkAx8?=
 =?us-ascii?Q?AEDmRGVUGveEKOehPSMoqkQ6gyBl9dviEYqV0TYxZnxcBbXMJ1ik9kEKJ5+6?=
 =?us-ascii?Q?sicrfujn4jj9hX3qIQyTOcQ4S/qDVxaTNYxSMU1HjkOYQYFLRhGrUAunYtQi?=
 =?us-ascii?Q?cU6ROtUUEwLsTC+MHJQW/THsRF+gZZ9ribUzDIF/2Fu4zC5mPtAKuwdZPHbO?=
 =?us-ascii?Q?+0+FKf724lW22KByOTk3YkI0UKcCO5+bUx9z8J0tvJmnnLKf91G1wgZL9t0a?=
 =?us-ascii?Q?pmEzwTz1OkIIpFoT+tsw6GcNYNm6Cq9tuOx80L8JwZpn6NEvqEBNEY2664Q3?=
 =?us-ascii?Q?RsJz4Kyicc4y0/QrIXXCkMpUlSfEpUSdBFEZKSa4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e90ff17-2393-42ea-86ce-08dd12fc5787
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:08:36.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffnGaDvPNUegRKi06d9FjKrzUfNaLe6e8lZD9ZjBxJ6ZFXxijSpFSqmp7Tt1kew5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912

On 2 Dec 2024, at 7:58, David Hildenbrand wrote:

> The flags are no longer used, we can stop passing them to
> isolate_single_pageblock().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

