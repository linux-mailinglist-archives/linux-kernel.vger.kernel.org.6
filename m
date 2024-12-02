Return-Path: <linux-kernel+bounces-428151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE69E0C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2161B64A54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFE1DDC0C;
	Mon,  2 Dec 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMxfE0jA"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A71DDA32
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163197; cv=fail; b=K/XoGaoIGlv3azblp3xgBCea0fApNFvrUaQWEYg4Euep2EaGcZ4t9bu6OQBY3ozecz05xnSjt6qLsy4Mt7RLcOaxiFW2ULvvCdJEEvUce0RMHFDAFi1GHL4yhYAdkDJH5KrEV/eLClbJtP+aSuGt7Tcddov6brg87ohGavJM7aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163197; c=relaxed/simple;
	bh=esRVxYPYwOWgeL86XBe7l1uHSb5APaB2QCOsglvkxdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYV0Dehvkf+JKq1EfyiWL5xb/AsFlmB/2NGSOz8qpf0N/U+3zkgO7dXSYDrf5wsCG6l5uFDJtELNY4LpKPLb1YE2VNHJ31VngDn7jesp5UP0NqtiefrzjGXTPSBQROIr4lKm+GkmpGbtdVI5qfo5gWUYSujwTQDgpTfhqDAlamQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMxfE0jA; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz7M2j5LsXsifHDNEFmlPzZXQGukrGn6YRRJnulFYOs3mj8SEU6hgjNl5WYtqGpBCtMmZyuYMFa5Ua791204o4IRBqNWoAguIkODBm5ibcCFc7fz51MLuz8jEU+/nXnsA9jx0Q5bzGeZSH4a2X/Zw8v8SGSg2gdQmMhDuH3tuuRGFKfybCLVB6PaME1UJ+1n18qZ+9QUEfbYGNLFoTjJ4bAyAmpfh9gUQroKml56nIIz5furTujExMTlisl3ULLjUOKjSAlhfsUmMnDTlxO+Jnc5xfnVmirnyOa73P5afRIqvMeaVGyZAx5Y4giVjxAW/tTX3tLOklcjsZI0o0Z+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei0lTZ5eKbYP0Ivjgwkk/GM2PoXLbM3P6MnbxRQimv4=;
 b=vyr6CIFwCefugUqhJ82CxEX4dmP/jNCixZ80Vv6ZSqjgyIngt6jDn5RvtlbkVjz6ODilDxeeeGBp6KrwD7BVGBx+Nq503f41YcTIFnjs1/ma8Be//O4uQ+yZjQQe87Iy7EhEBKo8FpovIeKIUrHp9AUfzjacSfWspXGWqAwiBfTDgZn6PEqoyDyRCFbgU6FdURVfzQyfQOhCFQ+SWrcBlJpkvkZrxSh/FUup8iQneMRGGFuy73kISF/TFCpsEU7WEN4XHO2ovTcfbdlVtuhjK4QpfSw9SpE890aEfC1ybPmfJz1YWTwCT9gbqUx4CIejObJQ1X+0B8LFIz+9FTOhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei0lTZ5eKbYP0Ivjgwkk/GM2PoXLbM3P6MnbxRQimv4=;
 b=mMxfE0jAOm+jn/7NeOkH+SYLE/WCHxwJ1CYvGVhNKCyUng2p9QTq+qV7v1Tu2h6YEIsPUL98oo0dOu4RzZMMDrNmm4IyAE07mvQhD3OeQL0IQamHyHJff6UarlKkjtmy1T4n4jFkpHcVOE9POV5Amf7pG4ZGqP+MlP9ToiGcNL9ZigNragnVNVTMN0R7D0JD9NOHDV2gyB7B3PZa6GFbWaVVsRSUe4ljyw1fwGc6f73HIkNIC6UzTwFSpilzhq7Jmm0FRqaqEUUhlIV1JI9YKLXMgpUZ3R6AVyyA5qMTLCazkgc0VT++j7BAWUIPn0+B/vn/YFZRq7f3h4zjYFfpjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.17; Mon, 2 Dec 2024 18:13:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:13:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v1 3/6] mm/page_alloc: make __alloc_contig_migrate_range()
 static
Date: Mon, 02 Dec 2024 13:13:10 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <460F2E4C-3DCD-4E11-A175-FE3EAA130AB1@nvidia.com>
In-Reply-To: <20241202125812.561028-4-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
 <20241202125812.561028-4-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0001.prod.exchangelabs.com (2603:10b6:208:10c::14)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2fea2a-29e7-4dd0-8af1-08dd12fcfbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sz1qLBusXJSA0EDLyL3PCMIx6ck7FSpLW/ndqygsVYDkwmlWozhaPwF08hLq?=
 =?us-ascii?Q?tYM8Y5goStPp2nfGIq2o5sfu+IXQ1/qUKrCjQQIlyrn4rRZaDMwB0MZWzw6x?=
 =?us-ascii?Q?47G9d37SUNAI4kc2Am/we6RAHO6M3RHLZMiCLJfrB19lJSxGHAQYhpysiZVZ?=
 =?us-ascii?Q?A7Wi7vT+FwB9IHBrB6XWtsfVsVk4F3HJsPNxWzsjAEWND+JCalgIYWFdZKeK?=
 =?us-ascii?Q?w+22DMYiGvK4B+qX2kHLPTe+fhcCKVAvVhoo5fbYe17ptXIz4ogkI8dC+Zo1?=
 =?us-ascii?Q?Tnzin8cjsmgYoWuZmgQntEa5VXL1JHOiKFiIrTusZ6aNJw1XpNcTBOotAGsp?=
 =?us-ascii?Q?+mUt/Vv8TeMrdMd24ZBKDRV0SQfwf9LVC7iigRuUbp6XcoYr8088TvUnQILY?=
 =?us-ascii?Q?x2hlXvMihApYGbGlKLMELRq/TkRhy/w0m0qDK5kmRQXw5wiIG1seuQEuQP3o?=
 =?us-ascii?Q?m0dSae46yTTFr0c2uTkqi3GXLwhLUP+GByxj3hY4yKxp3sCWEc5gbYCNCC2H?=
 =?us-ascii?Q?Y1UrHYmAc75vRbSCfYHzqMOTRAO1w30QMGXOfwtI8mZUtSce5sITW9HBRtj7?=
 =?us-ascii?Q?DTlDQgl/Ay4PinoJe1acSAkLcN2t1IheP/MywrsHi/XuYK40pnXmL7FXYwFK?=
 =?us-ascii?Q?Q1JLV7B+5M2kkrHuSO6ulvLBSsmyimOHGCWL3z1nW2kODju2OQNCfg99LzQE?=
 =?us-ascii?Q?5dlsi0GDmtd7XKFJ3bo6gsMAFU1avQvWVQtaomyqSZsQeh6gKHm0kQBFHyyR?=
 =?us-ascii?Q?eUKUgag4dmpkAiF1gfuDg2hhfGUqPDZLnv+FWiScocqBGjQ8i6rI9Laypm4+?=
 =?us-ascii?Q?ZTAsEVmBT6iGaZoWkYma1ZXhu/zZcjR1h7GedTIj+M+CUfUNb/1RZ1I7n8WX?=
 =?us-ascii?Q?vpn5JvtsD2F4gXT8PtbtrD8tP8G6zOaI51bSyJd8E9wYvQyzkISLxHCGS7C+?=
 =?us-ascii?Q?cCd7vO6bJKk75P6FBVkCH6m0Fww66LB3g7qHu8TCS00QlAPeiydDJMBBAgRf?=
 =?us-ascii?Q?QKL8kggax91mp1+KkgnS3Ffi6HnpWfQyZnfAox9D3RUNI2dFenLuOMJcfJW7?=
 =?us-ascii?Q?XkSksE9DCb8Bn1jtQ2ztJQn0ymfMUSpDgKJmpqPcPUm1HufcfYYyPO7chKIK?=
 =?us-ascii?Q?H0ipLHGj/31J2OlYltbDB6n3aINDyN7+Yf+8nLvvQHVOT/87sxG8CgF3ojPA?=
 =?us-ascii?Q?XMj0k+leblrg+pMt1ZkXOlxwsizsOtIP+pYU+0w+21NCLrNeKqi+dMJAWenV?=
 =?us-ascii?Q?OdXkTvZmVoM0dIya05W23FiNQc6WXeNqpejiZHwh5NijFJv2UrKdkeJKqxTR?=
 =?us-ascii?Q?YQj7uSeJf90ObfAVC/gE3AeFfE7GTiDRJQqntf0Pi/cCRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DSQdlaaMVl+sCAO1B9dZLTXIQaY6VuFgRiSedsTuan21UHbKHV7xA74eMGK?=
 =?us-ascii?Q?sKp1BDJ7dpdwGjlykt5FzBNShyZpY5Ig3Gr6+TWDvD99IT/O//BGrPT8adpC?=
 =?us-ascii?Q?Nm648srLqQemtnk7t9SgeejI68hPy6A9TOtPBLo5uZSBTArPOytKTD0Udg+G?=
 =?us-ascii?Q?GBPu0hTVM+/71WayczzdJqD6FSdlMVM7ofeplY8UgJmESo5JSrB46EV5QKKi?=
 =?us-ascii?Q?T2mwdausNEsf1znjhg2lUKfjOmWcSBvgHOpUh79+N9Eh1gP9taSnOame+gRv?=
 =?us-ascii?Q?cS7fn0DPmHD1I11z9AbBNoUyFzOHyKDcUv4Dxe7p916bAJl+ZMOlnbf6ECMs?=
 =?us-ascii?Q?1hral8tvm4dkYg+3O8CaBNKdLtfhsXWTOw4Tu9PJnAFI0i2isDTbQOrLXDHu?=
 =?us-ascii?Q?NNXUnxMHsCGuYzuMr/Z3eY2xd3VsQ0IwPQ7r09geaMNdC9/JnDbas1tpKGB9?=
 =?us-ascii?Q?VVcziyDyb/YAK6QxvdL7CDr+BfLS4fUO4YNHrbOOg1GjdU+/vQrTWWQu+Uvy?=
 =?us-ascii?Q?JJdncn06TUW4rMraI0IMviMtafkScu+6LGXksnvSiLdh+f7LCd96miD+wzF0?=
 =?us-ascii?Q?VptSXQD5LMKXkaAVL7seA5/og9OWq6P3RAvgSbfMfM9s1mK3yWBx7PU/Q7z1?=
 =?us-ascii?Q?3AR4VYz2B5WsT8lYVj802DPhzQqNAEWHgGz/JWr9U28BtHvdRUcrbAmgmls4?=
 =?us-ascii?Q?90K1WaNlRq3rpBQBEU8r/cq0pHnbZxo0D0gZDP+DojcKXRJT7h03oPAlaTkj?=
 =?us-ascii?Q?FNke4nSGkTM2G5h6fXJiaTs0ZTcHQmQSIugmG43ZCQDa2ASQaGgZ2LBgxdSu?=
 =?us-ascii?Q?WKB8ZXDkDg3dTfPT/4OcyyIQxHjQ5DIiqddadX88a7tJhGOLTv4PEwEBFe5N?=
 =?us-ascii?Q?dZ2rrzHMDYcgnPjejDTDcJ1gmS4UKwpcbJH82Xxb1fP4vov8otRlbzvQsAhE?=
 =?us-ascii?Q?KyNBCVGbIyKcToTpvUPGVnjOJwqetDs3mbEexnwZlql+CIKHlY6J2/Qa0/lF?=
 =?us-ascii?Q?mE7umWZz6J3/7P9f2Wf3iaBvyeqZg2T9UhJffGYgkfE6gv3oetdMZDYmAtZE?=
 =?us-ascii?Q?/HfN+1tEjV3zJgDovtKWDW9VmlpiRr+R+tdyvsoqPNGMKrrUlOnkjGWjWV1s?=
 =?us-ascii?Q?sZ6y+j3ooU/vVbbcEEBbN5k2Snw/A49B5cmXIoWrLWwFtU+h9AmP0jJ1jLaB?=
 =?us-ascii?Q?vGEm4LWzG/LFjYcM7qZoOzdb1fghlcZ+S67EiaKb9j6G96aHsStWY3ojpp89?=
 =?us-ascii?Q?xQePOYNzTpbkbx7X0LHVkS5WyJm2CT1uSJMDy53hnvpZvEHFEa5XzpizvaK8?=
 =?us-ascii?Q?A/7lLN+Bgp06rEnMZL8T4DiuKSh+L845ThPB3R8eTBHdRTbcjKyG2DUTwe4J?=
 =?us-ascii?Q?RC58/HhhPKnjQwWBx4VC+0Lv/FnyUo71vJRJ/C9HN4BENwQ8l2di/V9u+UYJ?=
 =?us-ascii?Q?LjV5/qfEBE6y/brMHywfWqGh917hvhkOaXsHw76Atyxkvq8AkRUMqobMZKau?=
 =?us-ascii?Q?OwJeMWbKrCMpeabxk98Hcae01+yv1eoX7p8shSr5D4wfrYQAznWbiOQluCzQ?=
 =?us-ascii?Q?j1EXo3tDAVoG5tpscgKxDUYhsr2VPub0sJitF1UX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2fea2a-29e7-4dd0-8af1-08dd12fcfbdf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:13:12.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KES1rbRCN4MwETnRjMS8e5f0weecLwf+ne8eGpmJfLn5NcoBZK5IhMqc8Ao000ax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

On 2 Dec 2024, at 7:58, David Hildenbrand wrote:

> The single user is in page_alloc.c.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/internal.h   | 4 ----
>  mm/page_alloc.c | 5 ++---
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

