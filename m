Return-Path: <linux-kernel+bounces-357204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66D996D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E749F286AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5CA199920;
	Wed,  9 Oct 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/tk9Bjh"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F5196D9A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483672; cv=fail; b=UNgkkT68hHNwrKDwY5RjaCT7gzmKQFDW6g+s0QHTV+WQ9Wjp12WNw+JJrH3wzniTZ8Lxav4FTFaDJRU7FZJN+WafKAPM1CaSPZKbcKWh4aL5+whA+Bi9o99AJDejx19ULGPEvqFLI0vpJI1cwJ49EQkSs+GdlO3ORM7T/CULjE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483672; c=relaxed/simple;
	bh=ldxc4rQsjKj/0sRzNhaEQj1jHJ0KNDyYrDZujcWiVZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEhwNq7+P/GP9EcGUNMVZ6xkPYt1JsFDLHH9eeP6EalS4rRKY8z+a61Yvm64BA6qHsONyC3wIKQKa6ZVkqClEqAFoNU/Pwv7ir61rRfgzZALS3FRamEQrEkWk2gUhzm4lU0IsHQJVXtzGcXy+w+nvhjPOFaG2d+AIgXV60Gxfns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/tk9Bjh; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZkhJUQlG876CyJFkh8vfdJgEJTELiobhbyBd3Nsc+6cdiFBj5M/YD+1XgWo7FDSdkyxYCpuSpH7/aJQL2ePBA8IpZlenz1ucfs8QiaYZ4KkZgr+bBnW7NdyPp6oOPfIpNOkrFnikWcqULahcIpkV7Y80hCmdG/sEXTmOEK6UWF8yYuYx9BBPfCo0BCiPIKTW80cH0okO9mn0GUFOt/nn9Ju/F5DaAGHZkE8ynFiYCtAstXyPRUuQ3e8wvqGVvC+qo7Iad9l7X07O6WeB2zooajmXwKgv5YTntFSSz/fqChx05cv98y92yEO6kNNlWVSxp3LwvYXTsHFz6neAyABPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBvxj3MQF7QyTNWIDOtrMOSuATzzR6F182/EqGmntgw=;
 b=Xbghldf7yvPy398TOfIWSXukIW2rJ7xxq57N3Xn5Z52BKgktuV616N82WeTLTX+usdtsC0frgyvft7voRLSBogJHAWcqVUlD8n9/apBTUjK5iE/O1fxwBfM6dhAkZBAbM5IR/A6UAN9PC+i7ck8l165tzuHeHhPxowVldXdVdV/AVZr81n5S7g3LClR7400bEMbdjv2qqIRJ5lpu/F2t/QUF6zNM/1Lo4VvhmoUxkTpHuxUpMgn52LbgT+YrEkAVRaesrPw2DIS6hnPZucCRflyTKJnxeYxXZyVJWBFn2qmX82hiG/7SEd97Lm8yyC0EZ7/2SOKDITF9crMadzJh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBvxj3MQF7QyTNWIDOtrMOSuATzzR6F182/EqGmntgw=;
 b=j/tk9Bjhil8xg4eK/2iZny6MUNyufuDfUorRr+BNv07T4RXk2Yl9b6AMZTaFxHJieiI8apv8XPbEnim74QpODEtNV9wH8YAG2yeBHevfI7MoWQKAj4p9i6l1UIgBNkDxdU9Iz7cCoMWdtJKO0tPi+UNh5IovCRhE4+C2I5QMXrZyNSJes9b8QXDjP58mq8RIXqXc2IZJDY9T3iNQW2JwWHjRLwvyd5RP22f1R7v/eU583rwZQlvDXBh/SHVYnqx4g1K9eldgVNS8ylJ8eOqHEz2VpX3JmdbixVcM0aDp4QZpnxobgInVWxNuyQiyEHY3ze5lf9tbE8DLhF9zV1SO2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:21:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:21:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Buddy allocator like folio split
Date: Wed, 09 Oct 2024 10:21:00 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <A8E67D62-8857-4A99-B6CE-5144D857EF0F@nvidia.com>
In-Reply-To: <omwjkm2iealxsdxtaxkxjpet2zqz22x7ryvbzmhaxf5gp5k4se@7p5a5vznnsnq>
References: <20241008223748.555845-1-ziy@nvidia.com>
 <omwjkm2iealxsdxtaxkxjpet2zqz22x7ryvbzmhaxf5gp5k4se@7p5a5vznnsnq>
Content-Type: multipart/signed;
 boundary="=_MailMate_C2A75BDA-D3B0-41B8-ABDD-6BC9AE94861A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:207:3d::44) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 79822758-8884-4135-4208-08dce86d9abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q4lwjLyht/YT1R//lMVphOvclb4KVnU/DyxoDlqbA/wz90iU3Dyr3c4Z49Av?=
 =?us-ascii?Q?ttJ2K3mt3T4jd4JT+shR54NzTRjjsCU8fPHeC1owA4YCM1oIc5Y3Qr0I1M0Y?=
 =?us-ascii?Q?87cPW6TI5Q6igtNzGeGaJU0dWCWgBqmqoc3BrXpetIHSL1gbLOGhWaDaTG51?=
 =?us-ascii?Q?Lf9oLGTX4HW0W2uZkpSSe791de+tRt804ZLFngql4ig+8jK2egHf9usk3Xv7?=
 =?us-ascii?Q?jfTlWSquNexsr5hwTEitkla6KMbosFVCRG6HL6KJ9wrp+8z5wajvIh6ZQGLl?=
 =?us-ascii?Q?e79Z3DAIRsUYMTNCTZuuUseCv/bKinWrMJ9/+ntXZlMX3iVqTN0GS+IvDI/l?=
 =?us-ascii?Q?PAxt8mbf46VKufrFKhF/k43ecBMnN6icCiH/b9VCDLDUKJWjJoZ7bXhtfhck?=
 =?us-ascii?Q?NedaIaTjxT30a5xKo+Yd4jT4d1JMX3/ysxrWmfccsEpv+PPQS2mAr3JOisqb?=
 =?us-ascii?Q?MNKGNFtoSJTATsYV/f6bEF6++sR9S/F8/ep2xhjf3MXVHTxsUPKErrI52VH7?=
 =?us-ascii?Q?4V1wb2Cd5tBXRmhq093u+tn0KHWoN8MwMq1QBDRsKnvwwKUvQ8AoCqP0yhgK?=
 =?us-ascii?Q?jbLjAYVFuUPigOqJFZqmjDLW0CTa7dTLRg18r7aPogwr0y/4ikLNTkt8/dzL?=
 =?us-ascii?Q?XgB7BXLg/I3miUXUBp1eR/7XgtBtxHl7r3dHMUEmUpGWsGIfvD9+PVd9fJIA?=
 =?us-ascii?Q?RyYmQR8HAmFRNZPf/euhSSwVAdFDVNkppLm/wraQmDqI2DHX66LUbnNI4IWM?=
 =?us-ascii?Q?MyzkJhbZyXVu+VCF0CzrngYxl3oeNYqqMnKdvlbsNoM1NbzogEmW2Yf+0Ad4?=
 =?us-ascii?Q?nU0GSQ284shSV4C0dgwKRC4+6Y+TJq1dG+3LL4essUXqmu/d7B0dnC+VLkFz?=
 =?us-ascii?Q?jwjyk7XQFRZ+xgpjac+SEl/BZFKPBIj6sRthPHWALlfHqqDRAe7WVYJewqv1?=
 =?us-ascii?Q?me33qj30sgmLA6Pv+6oj9ARqPRv/lFBcQ/J3/XSfWNf3BkLpipc+44bFPvnT?=
 =?us-ascii?Q?4JdN3ram6let5gYOa0zyhUZzFFAOYik7zYTzRTi42jM2o6z54L1bGXSELjRz?=
 =?us-ascii?Q?jQGOQMzGwL+ujBPjq1Umdwma2bb9OTMpOUPUBhiX/rphiCDOcsCmVb2ykokT?=
 =?us-ascii?Q?zpG6HGCmld7Szz9tgOD7oBwxnU5OIoxem+YssD7h1uOPQJdsX/1Ce+tqVugg?=
 =?us-ascii?Q?m6lQ7zeId8VXhctByMt0OImowUbGjMrVbAXvDvkJ2Y27UjphxGZT5yPtEf5o?=
 =?us-ascii?Q?IB9h9zIPBe10Kn4uxkCXZgL+YwS+fbo8DWWqlgMTWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEikYaYytp5q8DUBfa943oeBJmgRmBIaaN1FLXB1Bnr4+s8CiX9Pnmf2zkSs?=
 =?us-ascii?Q?uQ5HKIqeQ5NEQqFkSTLxAYtEptwPv+8cyNfPk+8xaCMMA0+2IafQJGrv2DbL?=
 =?us-ascii?Q?dehL/lndWlXZqCWQH71zhVwHepQUw7+UOXZ+rNbreU8PSkyus3aSJXH3fxZA?=
 =?us-ascii?Q?juYZ1ASoYRjGH2bQvoxJpXPpA0gfT4oHHLS4gxBJ+L3kBR4ZsQ77Zm4lmaO5?=
 =?us-ascii?Q?0mQbnJ+d7bMw+q2VwUE03xSV2Nc9HBGt2DzZMRB+suAF4YV2p16QPKSA2TLf?=
 =?us-ascii?Q?pFKVek33bsIK0buJ7eeI1yonfd8ooj4FBUBS74ZmkfWRZ3vFO5Mba4OpknPu?=
 =?us-ascii?Q?9356Av5zvGTeSn3En8K99GNvI8gGjrsbVMCAdnb5rXT7S+Ik56cUw1C+tiYV?=
 =?us-ascii?Q?e0+2aQKbUco/KmEdHRdKWvMp8PU+qGBtlU3TGnUWQU0lYj7q1OYZhnMN9AlP?=
 =?us-ascii?Q?gdiVAl8KeGWrCexBr7/OQOk0+3ahoNZHwaVwoQjWwRDdiARfvK8/HFxXhfWg?=
 =?us-ascii?Q?vzUnWuo8/Ih0Qf9H20mxMOaCNGgFG+dqgVBa7XBS9jvOVTUL8UzzZOLcGG2R?=
 =?us-ascii?Q?jdQYp8dI4D5F+saCT97kPBSWtOe6QV/mGc1eFBqQYT+nWGLJayNr8sERQP2u?=
 =?us-ascii?Q?QnfaUsBFfrMJd6QP4lW69/1Urw0u7cVSP0WlpPXvGgxTP1P66wXivpTLpNZy?=
 =?us-ascii?Q?LD8r7pLWgW1yfaQGthHyu8cFGimIKES4XPnXz0gdecPj2kPMuFQScJsV0tr5?=
 =?us-ascii?Q?V31rEsIR70Lv7hs9+3rKC1ayTPQLkvmTw6WXo8ABvSfrKkfqVOwx3fKVYW0t?=
 =?us-ascii?Q?Y9d0jY0/FuiFrXBVF5GwwrjU+oMUsh+5f5lOVKLqk/zErUNBig+Jidoslkac?=
 =?us-ascii?Q?PdE2J+U8Yn6SgZJ4feWUs6mvCcobJ7rQntvDKbhprBQcUCy5qIO15dN5Nbwz?=
 =?us-ascii?Q?kB6jlmbdnD5+sUdjQkEKO6AWHNitNf3YHJwVdsQs/l/tICsTwmMoL9LWcIZj?=
 =?us-ascii?Q?vaFWml/6UWfl4W9fYkeNQx8u2aiK93QJd5Yly9CdOMziUvuNrz1sCOKXAsMN?=
 =?us-ascii?Q?YvZN0DgNKjxEAsGIQ29wMKD593DJ2FYo1FEHQRrkM8dIKbse5ytkDClK4fov?=
 =?us-ascii?Q?SKLUcSgkVVgzehynHi5xYkjEyvObN0GN0e6dc86VUn+JKUmCd4cCRN4QjkY2?=
 =?us-ascii?Q?aLzxwneF+sGR9+lcXne2llUQCj1f8zDjgSSspJcZ0tKStJlN0L9AyhCQo279?=
 =?us-ascii?Q?fwM6TB6HM8KIKrejAvA1g3hKpAGOUHNM85yIIb8cOY2eEHvxXnQ8SASRToF0?=
 =?us-ascii?Q?g0Cn0jsgbUHqJKXwXES7by7HJgREaRR4OLrKhfTvnq/4u2MCUuNqXh+NLoVs?=
 =?us-ascii?Q?HP01FL6pcAgjJ0TyjEXf42wpAChhArPMQcu8PQ4ry1P9/IlyLm14sRNE+u63?=
 =?us-ascii?Q?LwjF6ws1lzmskMTC3fDOC3W5LYmsvm70Zhw9T99EMsnDlQa6Xn3+wwY2gNBw?=
 =?us-ascii?Q?P0iZemTCsHmyrXqnpx3F533J+dol7GNAkeQQ+Pz8s2E+asGswwlAQIEnmdZ9?=
 =?us-ascii?Q?D6s2Cmhy3DmuYp9poV8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79822758-8884-4135-4208-08dce86d9abd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:21:02.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mOSlURyej9aQDkEFjOjVfYHhaBZd+u14td0zCYBrS9Erz78ZNXdLJmGbkMcnXAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

--=_MailMate_C2A75BDA-D3B0-41B8-ABDD-6BC9AE94861A_=
Content-Type: text/plain

On 9 Oct 2024, at 5:54, Kirill A. Shutemov wrote:

> On Tue, Oct 08, 2024 at 06:37:47PM -0400, Zi Yan wrote:
>>  mm/huge_memory.c | 648 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 647 insertions(+), 1 deletion(-)
>
> The idea is sane, but I think it would require a lot more ground work
> before getting it upstream. I don't think we can afford two parallel split
> implementations. folio_split() and split_huge_page*() should share the same
> implementation internally. Otherwise it is going to be pain to maintain
> them in-sync.

The goal is to replace split_huge_page*() with folio_split(). But for now,
split_huge_page*() is still needed for swap cached anon folios and shmem.
And this might take quite a while until we have a better swap system.

I think it is possible to use the same internal implementation
for both folio_split() and split_huge_page*(). I can give it a try in
the next version.


--
Best Regards,
Yan, Zi

--=_MailMate_C2A75BDA-D3B0-41B8-ABDD-6BC9AE94861A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcGkUwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU9LYP/iumxNIl9u5AGTkQBYX2XEaXylF8+FR9JTrf
6iXsaHw2EN9eMMntLJqckp6b8eErnyaA9kmyOtkflYFZMjzyFRFntpwqCo7VRZQW
/QMfS8+inJo3FuLCD6u4a6eUlallNSfjsfiMonsrd5eBQKR/U6pQZLAbApapkUDX
n/FLbQsPIllAV9JNq/DWFrLLzWteDEXqop0ixTj5NOQOnrOwh3VBmhCS2Z+6mYvE
eviXeZFBrCiwPboPhMU6csCe9jJUGdl2w0rZ7qtoNoBfxXw7HEJaMbeoP0UC+xDg
b0hsZa3gWCVEOqGSTIcZj9jvzBT+aG0CeKbQEGSj2JsPgmfc7qChQJDzTTyvy5DO
hv7GKLLZymwDDexgtJl67cbS/5TDXAVJBFBsty+tz0lZb1O9HgTJCS2JNeSoZEMO
siWULqrEl58bNtXfJCP28e0R5CIOItNjGKG9nfGVlE5ukXUsmwTOxAgeA82+Qq/C
GCSNhaiAX0TsZXWpuAYjLHIcONXMsmrr4QB2NYXketnBI8r5T59wcmB/695vyArk
aBz1QloHNWVC15FucAGl6ussSs4GiafzP26TvZ5MTpO0Zcqxq3mDqLGQKnsA2PYC
c3JH82aBKFpMeEKfvDFVl+fYBHhaaPWiRq1JP+1mCa0wiCAOO9aTvGgE8Fae2Huc
SvMA7PHa
=OIrV
-----END PGP SIGNATURE-----

--=_MailMate_C2A75BDA-D3B0-41B8-ABDD-6BC9AE94861A_=--

