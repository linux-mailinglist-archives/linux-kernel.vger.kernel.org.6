Return-Path: <linux-kernel+bounces-372278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334C9A4690
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23802830F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF44205AA7;
	Fri, 18 Oct 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H+hGwrwU"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FE204958
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278639; cv=fail; b=V1aJxUpxM0mkROueCLGp1bmb+yOdD1k1t92xRwsudvpcWCuJAC9XDKBtFLtSB0JXXPvwK6Ey7btD4GdkJN/l7YfQ34YlrH5WENOooArBGVCRxB7ui/Cdksc+9lqFFGhqADPvOhuuQ8yF+2g4J8NdkwANrsugAW5DBglO5qs8Vos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278639; c=relaxed/simple;
	bh=f4tqwGEhn2G+e4YcYoNh7cs1bBcpDhc1hSKWVrTylGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8Lqf1v3YlxD6X/6tHYtk2+oNa9xIRCLhEpLYxZcFlxRmE9ZgT9fnukl4vV4rNnP91daPY8esqEL+q0geaEibg0GDII++F5t1/Znoimm4oiqj3m4wnXbahcb9E3gD+jq2HqxOdFeYBGpIDZMQJ4X5IoN5VYc0AD0TtBmTZjyD18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H+hGwrwU; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apbelf08l2PMOx4oRYcOiyyMADaoWrjbeI6YYycUduO4LM2k168z5cdy3QddzuyNKmOYYQUhl1NdbenEQW5L/HN2EMOBzTArefHC46QcWMN0/cTY1ZeKzdzCbamahDTDGt18eUyyGmDUfZRSF3EXIQezXxoLI8INlxSVUYUsGh5Cx4RKkiQGNnrIapAMXgtA3xS6pgR+H9qOityJ5F/KEcoO0NuuG5xvu1mgWykaziiUXKxlQ5uEOgiM15jq+1qho9NRdil+jb09Eup3snGzZ1TXVEGZuVCwobcxRaLt0ZRPD7MfkzJzoSkWoBo/AFsVyM9JkEZYp+Buq0QcP/f1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUrG8sOba8n//0//gLswgt+mdsElgpKIw8i+KKFLd7A=;
 b=ty+eFvBQ82YAlar5GGFkACMbqK9GQEUVjinfqDSGvPr1LB8twKGPSjxKY9cMZuEwPf0OLoMGeBXiJBXTR0diRXhW6zrMTH1dywWgBK08pE4hKQ8ZDC2PuUsNBa/USzSKciPF89OtjptHQJTWPaGXOcbnlPZSMk6GexAx42W86CziIejLa5tVxhWs1SQtSXDBvG+DL0sFPBMHEFgp3LEKGu77+Qy8wSbqZHOWn1vbGwxBIwRk4GsIPu7Ij7CaX1JOSczz27mjT4d48JbjR9jbcaCIuLeBdCU9MuanA6yjhhYe2+XyCeL6LUVXjvXH1Oxbz/r7mQgNpmAlYY4rsSGLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUrG8sOba8n//0//gLswgt+mdsElgpKIw8i+KKFLd7A=;
 b=H+hGwrwUYXXyKrgFqSVA3Ts7SEIpSpG4HXKrU7zE08BrXD7m9e5PFtZQatBIT4U29U31NKhG6dJmpRZFb/bXYoJpZRpPRQ9zYrF8xl5Eqcf+qnFeMuzShF8xbg5OJXoT3cXeZQ5hTYP74hCzb/v22BVyDXRuB/FizGOmjFDPxB/rzGv1uJt7VdVwFINkel6d59gi6aUyDgTIBqxFtzJ4KtLZP8gKjhzb5Rehk7mhBWDwleZYzgLziM61d4u70u6F1kmV1vyBD9jJCahtna3zBqwBvksqBoSQENoBSwFVf53UVAJitnXh8DF+ngHOvA+1XA+F6A4cVUEL+hlMCI/sHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 19:10:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 19:10:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Buddy allocator like folio split
Date: Fri, 18 Oct 2024 15:10:21 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <9A314663-43F1-49B5-9225-0E326A4DB315@nvidia.com>
In-Reply-To: <7ec81ff8-5645-42a1-a048-c8700aff07fa@redhat.com>
References: <20241008223748.555845-1-ziy@nvidia.com>
 <7ec81ff8-5645-42a1-a048-c8700aff07fa@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B324EC14-AAA6-48DD-814F-BBBF9AE4753C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN9PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:408:f8::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 6716eb24-cc10-429e-839e-08dcefa886a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jUgVO75rtdOyIzXHCNRFFnNLB47a9FJM8ZnYup8Je58VB3CV6joi5E5SQKu?=
 =?us-ascii?Q?D36K3EPKD5+EaGLY3heXxqTxMfJgdvMVQZI2+8QLqRiKW/PwSykVGia3zl0B?=
 =?us-ascii?Q?hWD+zM7Ldpmcl3iAZBp3k3jhuSLgXAtBI/Opb1e6K6LN1c8f7NhyHScCQtmf?=
 =?us-ascii?Q?Ywl3C2mvRTSzUd189ebvBvZJL89eYz4j9UQuHd0KApoTrtPD1EW27vb0R0Ps?=
 =?us-ascii?Q?HwLnqyxcI+BionFNTkc+IoI4G6/QBNqNpH7nXV/8tT2mCaSSdnOBoFSr/wbk?=
 =?us-ascii?Q?KcgGBik8RO44UwKrpuEABk7jMVVAEU2geaceT00x3cU5YWfkHh6TJM63+R/5?=
 =?us-ascii?Q?9Fg1xaHpQ+h4YconavW0LzB66AEw2B7IaH34FasHEaGdUwnZ9WyBKY1x4iX/?=
 =?us-ascii?Q?QifMTEBRVZgGK/ZcYfQFWA5WldvdluxLiMK8Mbg5xLh0puM0b0c4Kr3Ip4q4?=
 =?us-ascii?Q?9TyodjThVNFo6ayJfeN/VAjxoMJcX4l7p9hSBx3WNS2kMNJf80HTkdpRELGC?=
 =?us-ascii?Q?9n2BK9F+SZooKSYl5cQQhA2w10VbMN6PhjZGFpzjrXAtBYVBiIBlR1/44hAs?=
 =?us-ascii?Q?tP3cFgCnc0/wdsAf3Nm/ev5Gngv6HNwLuzyHk/6y9TQEBQRnvtaD4t6tKmSQ?=
 =?us-ascii?Q?xTcp2YfLyhSUrnPg4EvkvBHxxuT8nf6n9su+XQkSt62/HJymEo4/RS884/yO?=
 =?us-ascii?Q?56fp71N7hYKIwIqepUQ85MD9yiBPtiC+SfQLbXC3X9zMJ9wTIDakRcXnMPLs?=
 =?us-ascii?Q?HcxO2Sd4cyFyDERf823XiWkjcanVX4OMBg9ShxQ8Ogo3D+OovQCZcg5mCcwm?=
 =?us-ascii?Q?KMxYOB2iyrNuNlS1WWo6RCGU9UfrsvZnSLvC6F4KXIO4V3bMJaXIJeZ6pgjl?=
 =?us-ascii?Q?hDwE0tKUFzqqzpDjtNg2UPlRYxl0Mc+FWIKvdBOm7dcelqErmVYL/fyN/64C?=
 =?us-ascii?Q?P4NaYjOLn/78hbaNV8vrQA3ICYAWpO6CyjJ/qNwhABssk37fpizhfjb8VB7h?=
 =?us-ascii?Q?dB+DzpLWs22wqNMvCVLojyZBL+G1EUWqWbIZAcbg2kSJk00ryZoLtgykuzUc?=
 =?us-ascii?Q?V7gbdO046okMgxH3O8eiva/3FcO3MIN9HB0mnPJ5gAw98uFX5fpJFA4F+93J?=
 =?us-ascii?Q?urQUJPcgJF/GY+JuLDHdHNxeW7g2UJDJuOjOFaqjP3vK96EIc8O+ic1WJ9kS?=
 =?us-ascii?Q?+Q8L/KfosnalES3ng+1duwLuR0CxIoyvcdkgyr/IZx5Ksvxukbpks2mwKAaE?=
 =?us-ascii?Q?4FslHA9DHRIlLIEf+0UevBW3msZti7kzOM0eVVolK8I5y2eFV8qlicHD08RU?=
 =?us-ascii?Q?5sjf/2xS55psL8fwMTswp9zf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCmGlRiyZMyugMgHdkdRddDBSZjU7/JxYJziZ4L8W1HphtFK9uatBp6p+wao?=
 =?us-ascii?Q?cmkQ/ufscUKkVKzB8TldPuvLNOFctPK4a/1hQZSO4fRYpyaIpOGolmo+qzoh?=
 =?us-ascii?Q?kdsIOl+MmMDL/l0temLDLkGbvNyumEO+L5X1kVhmITl3Eh9Fos8qiUlZBoLW?=
 =?us-ascii?Q?5f9a1kXwd2ChjDXwSZCqoxwhJBt/zI+EoNDPDU5gqEiV1kdwuf64S1AXvBlj?=
 =?us-ascii?Q?U7csno/HglR2ntKTCnlazV1lUCBtYtiDTHY/S6qjgqjLFzqf1Vr925iIDLeI?=
 =?us-ascii?Q?vnZE5Zfyu42d8vBJ6P3u5xoh7ufVLucb5trJIDrmZutSAIHxXWoCCDFC5a3J?=
 =?us-ascii?Q?wcTpn4r2EOP+nP8CgeQl9ATrCZnSbmE+FMd12u+Q7WYLXcpvoQjPdKzDpVS3?=
 =?us-ascii?Q?UDoF/ZQsx5eRAEsvk8ad9AyLUypurMpzZNhnQ9BiviCL989h+H0SdXRTEVdB?=
 =?us-ascii?Q?b43PHPyEw0iWJTQsIKP3aTESvf2ta70M0SdGvGmjSvMCOb32qQlIGPrQxPct?=
 =?us-ascii?Q?YyrGXejmDUfTvrRLDHUeLBsH5d0QaWJZ68CjfqdColdKUal/eGiJZStAfV/v?=
 =?us-ascii?Q?BIzTbeuU139njVRH6k2NS6R5OQ86E14SNTQDJL5kQcWzf6ybaSk43QnELwjD?=
 =?us-ascii?Q?KSZWyii4mGd8+2qnijIiOBKC3o1Agcg5tcCjmU48ZO6rby+K17jy+1pDLCfE?=
 =?us-ascii?Q?kxVvTlIr95aynCI2QZ+D/9R/I0AumBGZADpTqhwIhJJSZ5jvp4bbqOqogkCT?=
 =?us-ascii?Q?gtjOp3S9R6kSPKexTbw1cA6QscKBmo9Hls3Fy4PZXHu5Rp4gYofJy1/w7OWz?=
 =?us-ascii?Q?yi9YIhj5/UtGgD534WKSGaZj7m6fniHo8HPUUQ8wZyYrnPz0dkOEWp0N5D+i?=
 =?us-ascii?Q?HEexoIybZbXX+kgQhdGZRWZvPr01rcEMFmy4hRDONhybMMWRxTVSt0cjig/I?=
 =?us-ascii?Q?uHbRGTsbHv0qZxFXakCaUsJ8sy6xohPPgEU4jlCyZ0f6hMEgQ9+oWcfccEjw?=
 =?us-ascii?Q?8vmBT4hpO9Dn1ReFe1MTOqRSW3fmWJ8Y5JQ3CmFiGDlZvb8bdG/U/ipMn5m2?=
 =?us-ascii?Q?z9gz00puRu1usAb/z40XmEcuPH5tzv1dtN4JhYI9Rx6YxuKIVxO7+CrUkcGg?=
 =?us-ascii?Q?zzIZXUxAeyrbc1bGkVwvmMQxcTqE8NsrG1DYhuRaZyv0w5LSx3FGMVoyRubN?=
 =?us-ascii?Q?/Rb0Fks3LxG16evomIjd+El7UQDa1dg1lN1ulYpkUMQl2QCH+yWkecc6THI8?=
 =?us-ascii?Q?2gppHAT4ebEaS67d33zqOf9PsTxel4wOim0/KG54gIRjaPg1gylqV3njiLJa?=
 =?us-ascii?Q?EIpkpGxD+QKteFcVuYF3xBRYeFHo24rpBIry2M0FxgClFO3U1IReYcSGsmvZ?=
 =?us-ascii?Q?Y08aubF8UpevK7vz8OfUfTjhCrP+Fo2hOGqQTcTw7+lRaY9BLUpHMSlZrc3A?=
 =?us-ascii?Q?8tzdF7Lk19acTK2cQ4a9AWmrTxYpy1FSzQUX4gNhERyKCFjMZXFKoSvtCr+f?=
 =?us-ascii?Q?b0fi7O8f/GTexqFVd4GuJAvdsm0nA+JZjvQV3iSdb3niAcOhjUxVhwUKuxr7?=
 =?us-ascii?Q?zPTJ9frUAw446O7kQoPpmNQA7f5wTbQhr04/WhSu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6716eb24-cc10-429e-839e-08dcefa886a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:10:27.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdCVCYpQ6TcSb9pZefo4SLPwKoLN1nQp1Fgia/PRCB5E6CZlr92H5Nv1qCZlA4lz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

--=_MailMate_B324EC14-AAA6-48DD-814F-BBBF9AE4753C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Oct 2024, at 14:42, David Hildenbrand wrote:

> On 09.10.24 00:37, Zi Yan wrote:
>> Hi all,
>
> Hi!
>
>>
>> Matthew and I have discussed about a different way of splitting large
>> folios. Instead of split one folio uniformly into the same order small=
er
>> ones, doing buddy allocator like split can reduce the total number of
>> resulting folios, the amount of memory needed for multi-index xarray
>> split, and keep more large folios after a split. In addition, both
>> Hugh[1] and Ryan[2] had similar suggestions before.
>>
>> The patch is an initial implementation. It passes simple order-9 to
>> lower order split tests for anonymous folios and pagecache folios.
>> There are still a lot of TODOs to make it upstream. But I would like t=
o gather
>> feedbacks before that.
>
> Interesting, but I don't see any actual users besides the debug/test in=
terface wired up.

Right. I am working on it now, since two potential users, anon large foli=
os
and truncate, might need more sophisticated implementation to fully take
advantage of this new split.

For anon large folios, this might be open to debate, if only a subset of
orders are enabled, I assume folio_split() can only split to smaller
folios with the enabled orders. For example, to get one order-0 from
an order-9, and only order-4 (64KB on x86) is enabled, folio_split()
can only split the order-9 to 16 order-0s, 31 order-4s, unless we are
OK with anon large folios with not enabled orders appear in the system.

For truncate, the example you give below is an easy one. For cases like
punching from 3rd to 5th order-0 of a order-3, [O0, O0, __, __, __, O0, O=
0, O0],
I am thinking which approach is better:

1. two folio_split()s,
  1) split second order-1 from order-3, 2) split order-0 from the second =
order-2;

2. one folio_split() by making folio_split() to support arbitrary range s=
plit,
so two steps in 1 can be done in one shot, which saves unmapping and rema=
pping
cost.

Maybe I should go for 1 first as an easy route, but I still need an algor=
ithm
in truncate to figure out the way of calling folio_split()s.

>
> I assume ftruncate() / fallocate(PUNCH_HOLE) might be good use cases? F=
or example, when punching 1M of a 2M folio, we can just leave a 1M folio =
in the pagecache.

Yes, I am trying to make this work.

>
> Any other obvious users you have in mind?

Presumably, folio_split() should replace all split_huge*() to reduce tota=
l
number of folios after a split. But for swapcache folios, I need to figur=
e
out if swap system works well with buddy allocator like splits.



Best Regards,
Yan, Zi

--=_MailMate_B324EC14-AAA6-48DD-814F-BBBF9AE4753C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcSsp4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKprkP/RnDEyifFjakOT4ZMCLIbdZDzVgzshiJvujl
LzZjeXYJq65G0GqR1U9NRZ45y33P/4qlziS3ty9VAcG0BemA2VbD8iYC2FtqGZZd
LC7mw9NIk3nZ3zYiur4LRaWSBFrFdUn9AoeDd26+jTEujGHxjq1YYMyw4EfDH4te
HAOQKXIAtyp/0EEsIiq+WqqVNSbIw2kNUsztrjc7mFNtJ3SxMqK1jaCcE8BRtAWp
YAa/qsK2BQtRtJdI2jat1iBIedr0fY6H2hvfZh9VckFrrv1X8DJ2h6gBaauhCVbp
hUAwjsBs75b+NKv9DoXG6Vdnv6qiZav+v2Z88cH3rFT++tyv97nKeXRtAm9nO7wB
CoMaJeryBQriTCiEoe/a01zFmOuXGLUqybeWAimfPhvjHbn32njiVczt8vHS+mRr
HsRdl4zTKexLtQeO6T1ZoeX8p4psbTkvQI9XwjBmXNwSQltDbGgLGSdW6YwNCqcf
jeiKy7LeKz1/k8GHnKA6AshGf1bOb/zA7gIs/QuX8Cji0ADimDUHqMH9AJH6Egka
z8pYnyQ2E2zC1TaxEPLW3JZdQ+6fekI6uZHUfTmHhGn71erHC+p36a2qcfMSuFIZ
UFTHykJVKI0+jQImdsL0JIISmnNrTkXh6WEAXGMCIdmD/hZmrpKL+1AY7vFSliR1
rgv55nVw
=Uu5V
-----END PGP SIGNATURE-----

--=_MailMate_B324EC14-AAA6-48DD-814F-BBBF9AE4753C_=--

