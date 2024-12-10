Return-Path: <linux-kernel+bounces-440263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212F9EBAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E61886F27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F522A1C1;
	Tue, 10 Dec 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/aEBcmH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429B228CB4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863324; cv=fail; b=l8CFbFnwLscYEV8Msw2GPsZIWS4PU/YBJEo5KAuJzbmUhTO9EHs4zbau4OO87b+EovZk/4MHXT1ZksUCX1mHW27toyKJI0xgdaP1tmA7odUrFpkcD1fyifwXvMDVnlyGXOiw9DIISNkXscds+Qkwe0wIGc36ReuLBV4ooracJeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863324; c=relaxed/simple;
	bh=NgFtloSTDVxKY2bEIiIQqWe5rl19PP0+dPMaB+2hd1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSWlaB2Qd02GTyPIf4qFM6dL2EbpcuscmsPPo2C+OwF1YHYZ4ZC8AqLl4IQ0QWTWUlvv+sC6ujdOUjkOxTMLv5eVRm2qV+N7+Gb/5eA3iFDTDh5DZbDJ3NI8E41SwQQqju7GMkNidWYMAr6GPJfn/P0F2oiZAKpGTHKxywHOSRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/aEBcmH; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h09JT+S98Qodfe/lR/3/Yz991hvX0IFjZ/wiEFuCiEkbBkIDNCPE0BcE9Br1jMViuOzm1i+7MkH3ZkmFBc6wzQp13pAdnIffQG7prJXtJjY//+TtBnKHehZ8PXXWxdUcl3rIlP9cMyxujrKKwK2UKLB2k32V6G4u2LuYaJ+T0e6AOCDAhXa1/snszOA0RvBJGe2lpjCKTJZa/jfoiD+hez5FaOHvR4pm6R46qQt4rPOcOiqZYFWglIPI+AlNIcBClgoZkemciabgBVXjz/QOfL3Vwty418Epzyyf1MPLrAQgN++UeeAhR4dSV95CaDS4OnYr0C3Zb+abKPuL4+jLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgFtloSTDVxKY2bEIiIQqWe5rl19PP0+dPMaB+2hd1A=;
 b=L3LiUmbLpOTK1fwPl62a2hCIEP6vp8Ddr0tXLq6six1Tg17FF56pUZHFd+UhtrxlamPObmRPYGUHoqm/r+5KORRUP4vxPq6Z6kxnWgwBZ0V31wBeeJRJlS/Rt0PkQo8qmtjvhasXLqdUe6kU+wrkx9qVPFdYC0H5Pm8cmWEP61FLbl3Y3Uh3ul+hhAz3ETGnk3ZUf3brKM78onutIqQC89XdlNOufQ2h+COszU6tPoFGuCphPa46AJf/DjKmpDTQdXmaQUD8stVCmw11HTi51WHECw/B7RtYcCMhTCpoQpO4+TuNho6GbyD8BK2Lp0/p8DTmHG4oE1dUOh5trn0Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgFtloSTDVxKY2bEIiIQqWe5rl19PP0+dPMaB+2hd1A=;
 b=R/aEBcmHweadp2w4/CxogExypRjffJyi3SWqwNc/qc2OnypJpt0ae2Qdnf+ni5TYsCwOncNa62iK0m8KyoButWlelIa5VdVyucE4+KFXOiUMWWTabD48SVA7IJs8G/fUc/Z4hBV6tPijAsTT3ggO+z0Ez71pG5UUXuScpObqTG1PxVkE1UegIN40ZqslWHNmkRLUk/g2c/2d3q+zmCisJ9A5vS+pfrUcy4MpXw5z4vEO/8JoWxhAaVy58bVWGHK/ox3McJAah8OU1t4QnuHQA/GCx3DBXed8JPBuAX3LKR9NeW2t8ZGPMee6iQGC6T6K+a8EHIs2M4SYYYgk1KIehg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 20:41:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 20:41:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 6/9] mm/truncate: use folio_split() for truncate
 operation.
Date: Tue, 10 Dec 2024 15:41:54 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <9DDA4D1A-8546-4B70-BCEB-7D98E69375ED@nvidia.com>
In-Reply-To: <ee92b309-db6d-416c-97ab-25abf8b12957@redhat.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
 <20241205001839.2582020-7-ziy@nvidia.com>
 <ee92b309-db6d-416c-97ab-25abf8b12957@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:208:15e::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 490ed6ac-ca34-44fb-0c37-08dd195b16ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BcOqe/krMK6Ciyl82ZuYQCp0MPeTLaiIo44QVtuwWhN49EnBkNMaZ4cMueGx?=
 =?us-ascii?Q?HB8yz/qQfdwllVfSXZWa/BcZGsFDVX0ECEk3UggyPjt9xID1aXT4I5m+hLd3?=
 =?us-ascii?Q?qUKEs4V2agqeeWa2MOeLqRvFkf6DwMEnTES3MJGlMgACrJRAsTrGb+ABLcEM?=
 =?us-ascii?Q?lrgaeQwhIZPHJK8cB9ecp9Cdku0h3LeGSA+QmMYSgIe4ryUZPFSwinAiYtA9?=
 =?us-ascii?Q?B1DorTSbs8U8WrMt+uGqwaPWrX2+te1VXRcACFx58Sxzt3O507AnqwdKqV8d?=
 =?us-ascii?Q?s1NLnDmukLOeymiHjp474KjajQW/rtcK4RLG29KFeTg/yByLjoNWwc+YnHz0?=
 =?us-ascii?Q?c+GLMhcwBqMe+omzctgrPsBUqiR/sM1YbvKI7lEQIcFcKiLttXIdbbYXowEC?=
 =?us-ascii?Q?Nxno6XXIqEEfNjhtoGRxtGu19JEpHpL/oX5BNwi5A6hqTv9MUGgjy0k1/7Y3?=
 =?us-ascii?Q?vElI8cWUixvsd1ILDWFc50a0SpJyudK0ANKGrzgVJNq1atneGUrK5M6Bfep5?=
 =?us-ascii?Q?n2N0hhV8HtT48i7p4WMlhX74A8Pc6RvwqSEO4H2W104PLbNDwNWb+Hcj6xWg?=
 =?us-ascii?Q?764Lxaud0gJgNTu3fWl4s+sun+HlD6kQFz7cBAfvMzz3N2PQ0eW9FpdXsEv3?=
 =?us-ascii?Q?14e5cRwMo438RITGkt73pkz9k+x3Hos638oRg/jrRMfDkXAtrPoO0/mNZ5GE?=
 =?us-ascii?Q?4vwZl9d0VSgjavf1Kq9nAKqW8neQePexub5hUd5I02mpwZINCooJTaghw0/a?=
 =?us-ascii?Q?3M21cag3P68m9J76Rz5MDJpTaYtdXFKQIUDtGx9GEBrvqTzlzLJ1I8OQrv/y?=
 =?us-ascii?Q?ccMma07KRW+ekmAvdDrnR7odPnIlevZGewd2tXjHg/ZqdR4GZaCcEMoKAfgV?=
 =?us-ascii?Q?KQxiBYDl7qqJVTkKngxiNLvF3EEiVQNF3aztLCx7lVVu6woNBriJqzngZeLl?=
 =?us-ascii?Q?s4PFW+XlrsHVxsI0+t1ezaBMiBpNdB81SQo9OWZa/WEiws8GFFlCQJIzQut9?=
 =?us-ascii?Q?GbzxE2G1SXDyj/b7IAH1kEC53jURfWrlGcFcNlgSvyoFliXKSJnVyv1hqQ+a?=
 =?us-ascii?Q?B+MMJ1GJdmvPy+e+043/0LXlEp3Ht33o5ybSqB4i4jMy9vrEu0ZpbyNV3vR2?=
 =?us-ascii?Q?098I6KKYfUoWG+aAulGlxfuTx2E8BpQwMn1uwAwVYdmynMfyvsWwF0TWV656?=
 =?us-ascii?Q?MadPIlOK/uYhcJ1C4bfazoigNx0E9eVR2P6lBQiMCMmE9Thfi+wiUG7XwvIc?=
 =?us-ascii?Q?NIPlyzH3luZX3x4lQxvG/pBttvKZBAat6E1jBvc6/ufOVbWAZSxpylUIbKTr?=
 =?us-ascii?Q?vNChkJbex2TT1/BvzYI0GVC1f9QRA1tkbP1eV7Geu2zCYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dijMfhykD7rVyh5aLoSpZ8TdrUC4CVvBV7CGqW/uZR63fxNZ13xCNC0QF8IX?=
 =?us-ascii?Q?hVJC5nTlwYlq3aLXTLVXk9+FgF4KRUrudVNSCttUzjobQXconEd6a1l1kzBm?=
 =?us-ascii?Q?GlYlsDoDDjQGUoVC0UwYKWYuvIf8d9THAmAmtCl0Ted+yRs99OaWlkp9pacC?=
 =?us-ascii?Q?mL4kzsvix9D5vucyYNFxO6wUy/E8ieFSt4fo665nY2JoUjyeOS1ZXfX1C716?=
 =?us-ascii?Q?BJlj21XwypUAfzXMv8yj2vOrEtxlQPpsTMqIszLJgMBL3ZJf/qHB++lwlce1?=
 =?us-ascii?Q?QL74zCtAiVpOGw6FvWOn0im/42yZj1Oiog2mV6s/Fw9PuznS3qqB7tjB5os4?=
 =?us-ascii?Q?JPd4rbtoX2dOhNBNXttgAi7Oy9vbUIkDxoDquHBddh9w/ZeaW3s2JsWWuAOs?=
 =?us-ascii?Q?7/77X4MmtCjoM7i0HLlgrRBhOVASYR+1YG7mCOizxaK9BTZ5AcGtN61rB7K9?=
 =?us-ascii?Q?OVJP0oFMXX2HPHZFOVlYwhRp9sSa21Z9ml2NRG8wnmUPGIkB7CQrvScCoUyZ?=
 =?us-ascii?Q?h0mRcJTB1wwbJpsom+H6LlGHlHDCEACM33E3PBlP/K6+MzzQ4ItbczCLk+WT?=
 =?us-ascii?Q?86Onu7VqJAD0IgEqAON2AUGTIzfOWZKgp2xQsXrjcUzI1FrVw5aWSoAGgs/l?=
 =?us-ascii?Q?u6QfkdIzp5+PXFavDoNcDuooH3KNN9nWt0UySA3P7j2FYaUrGVhLq0h52+ak?=
 =?us-ascii?Q?ZM5UPDX6JFaEFy7jpcYoVu6dUtqX0Dvxp8diWShSqPr2dlnM7MYX5W/VH9tQ?=
 =?us-ascii?Q?hy72tox+tWf9VEXJZ22pIxogTP3kuzqBFuZxdlyrxy1jjWimMhUupMNcGk93?=
 =?us-ascii?Q?Gue4hyPz3rULVns6ajMIu0ZLvZVU2/CTJ6us2mm7x7YOytkwff6m21yWpA50?=
 =?us-ascii?Q?C+59+v/Wi2rOdCFNV9GNwZnJshXTZ8BChFrnw4DH7faBR688Dxt+umHSF+aN?=
 =?us-ascii?Q?bmL/Ks40RdeR18zz+c3mDJWwYUjM8S3x2Z7K+dYuysqvs1wo9UFloVOhQe5Q?=
 =?us-ascii?Q?9v5FQWKVfTRi5nlgamWsbmdxj8honudiQ0jFEM5ljebzHT2eMMvff7nzKyg+?=
 =?us-ascii?Q?ytZsZCrPWfRLcLjsYwiV40wT7EROI6EKPvXWicTDCQMtQ0wIIQ78edCqBXzj?=
 =?us-ascii?Q?UGcqaJn1c7TUo8Hw6ax7Y1VyNAc02i4Sla3gPMPPD4NMlnNsrr6gI08xrc/h?=
 =?us-ascii?Q?453GPAcEc32N84j4ggtozuduUDcxOUISsQrcqfeZMyKvO8ytNTr76QqO43Nq?=
 =?us-ascii?Q?m/6o6CfpDfs8JaiGl8uKSK3c4zCdzjNUofc9DtyeedI4RgivHfQxI2GDcAzL?=
 =?us-ascii?Q?q2Cc9tkux20sYjc08fypcGUO8Jy1OTd+roSk+GJp3QAmI52fg9AMuJb09VXL?=
 =?us-ascii?Q?N1E9mt3ZMvZTp7j65dezqumFZXTAI1feGyJc+4+F83xOM67/cnJwhm+o9Zwi?=
 =?us-ascii?Q?SGLo5bbQdG3qlm7chIMTZyBdPJkDY0RIxChW27f+te21m/8SEgyIPtEBk+QB?=
 =?us-ascii?Q?IYwDjYblQNQ2oRX30QJpy13v+MATIhbXvTPEUhaWKauSnwMlmZbCSDg1x6j/?=
 =?us-ascii?Q?+9q3x+svY+gY3K7t1J2ufoSF8vVSl3H2NBLvT8jN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490ed6ac-ca34-44fb-0c37-08dd195b16ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:41:57.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RcCqXoMJU/bh+dlGiWA7EqgcVFcr3S/K2PfVHwsjrSzHLznd7VDQUnMJUiHVIMt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

On 10 Dec 2024, at 15:12, David Hildenbrand wrote:

> On 05.12.24 01:18, Zi Yan wrote:
>> Instead of splitting the large folio uniformly during truncation, use
>> buddy allocator like split at the start of truncation range to minimiz=
e
>> the number of resulting folios.
>>
>> For example, to truncate a order-4 folio
>> [0, 1, 2, 3, 4, 5, ..., 15]
>> between [3, 10] (inclusive), folio_split() splits the folio to
>> [0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
>> [8..15] is kept with zeros in [8..10].
>
> But isn't that making things worse that they are today? Imagine falloca=
te() on a shmem file where we won't be freeing memory?

You mean [8..10] are kept? Yes, it is worse. And the solution would be
split at both 3 and 10. For now folio_split() returns -EINVAL for
shmem mappings, but that means I have a bug in this patch. The newly adde=
d
split_folio_at() needs to retry uniform split if buddy allocator like
split returns with -EINVAL, otherwise, shmem truncate will no longer
split folios after this patch.

Thank you for checking the patch. I will fix it in the next version.

In terms of [8..10] not being freed, I need to think about a proper inter=
face
to pass more than one split points as a future improvement.

Best Regards,
Yan, Zi

