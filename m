Return-Path: <linux-kernel+bounces-383785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C8B9B2033
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA67D281EF7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C017B433;
	Sun, 27 Oct 2024 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ids55RwG"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14242339AC
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059585; cv=fail; b=VJA8+DrsMA8Uhd2kHA7QnI7us6hQ+U3vQMB9ir0I0rhsP6IhIrUnerJaEEiHJ+ArDYgjZGeIVJS1oo6MQFfBXZ4oL2SVjIF9J/JjumMB5kwoAFUf/NUGnDcV/PBXtGa4+NKYJdxkeYUrGf+yQtwkpv38Hfi6vOu/Bv6o33/4qCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059585; c=relaxed/simple;
	bh=qxIYYNeh2AUyUu6HNoAJe18uhBTtE/DecFmYEJfrwVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbopcaemgxU6SAHFh9MXYHYUBmRY2r0F9KicRvAPY7TWD9AH3+zJiqyToOCJm3WlVFKBwRRWP+e0BU9X/hUrj6iYbh4qjqB4ZLqxRPQuDVfsrnrixxFRj42XYSzRH1INv4gdMj7dKFwNdqOx2+hXAsanVMQYw/xNowpnpPBW/KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ids55RwG; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY72WFbCHd3zi2VNcnEyD+dFNYZlzmmDsV9q4MKlB/YuyUhx/ukQNH5CaLwyMqutSQJLAcYE2VgphOYKWsCAdjDyI4S5MxHsrx3mxGDqHwuRLlzZuO5EKtPnCrFOUbQQ8qTsKqzhivZhKovvDPP/dvx/T4e65GBPNrvf0LwWBMaSQzWWgZpWSJwLw1h3IuvJUmTKsALkyEZBaKctwQ9r7SNCtxt3zPxpy0P69xQ3lXsRLBSurbwZ6s8O6Zn6VGL9yH5BlXEV2f2OhSgB1bS4enzf88Uwr5/bE+iNcUwBw40+oTeldFNfzXTEzIRyXl+lss6gYJ+NQy3qYOzaMbHIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW3WhCrecZvDln4x3ATBTRcgfD8/VrWuqBlEtxyRqEE=;
 b=kIVL9SEH6X/4Y/ZfzDKfochyO80foF425L00WmrGITzA+sJSJahT2ypBp4qNMa9rqUYoy6YeR5mP8hVN55MzpkbZqoQT3LhWUz28fkavAx/MsU8n6x2kwOBYGTwOFi3pZguFlZx5qbVn++k6Ndg0LfyFrr5kJ09ggEycG0oD6INwBdfEfReOaOQekU/R1wCZBC6f5q0pJy1EOcw+DlOdCgZNN55Q8njOQf8MqCdF12Hbai5UCtysiWD82P6y6hL/kHC4RBK9IHL2ip8AaMieflBnJW1mQ+BVy4J1TthZdyESfJk61IwMKvDn+cfE1Q3tBjT7n3sgyQ9MkygnCNEi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW3WhCrecZvDln4x3ATBTRcgfD8/VrWuqBlEtxyRqEE=;
 b=ids55RwG5DGmDssBJW7YGj0XRnj19quDQEBGPXkK44+FucnukNuIk0ay8HGgMoYoBTUniDG1TDErAEnrzdYQqAgz6nhe7uoXHn3mOK7Wg/+qlWbu9ef29MgaNDcwyf0GSSXYs6pvloxvSVq9cdZ5lj+NC0vWwcK6QqULSup3tonbn3Ts3z8mRgFrUOpXS5Os/2rzK+n3I7wXnUR4AXOD5NvfMm4+4AKgb6g0c3jrCM03urIW/e4IO/JNS8KnBpXXV20OUXJE+P4BnDdAPGr57cwW9YJvoS11l/tqetFyUW2Eh3PHOeWBV9U4L5FrTKzbrnExIzixOQ4R7HRLAJUtGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.22; Sun, 27 Oct 2024 20:06:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.021; Sun, 27 Oct 2024
 20:06:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix v2 1/2] mm/thp: fix deferred split queue not
 partially_mapped
Date: Sun, 27 Oct 2024 16:06:15 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com>
In-Reply-To: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6E60A512-3AEE-40E7-B374-00D5534116C8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca46160-fb8c-4a2e-a6bc-08dcf6c2d166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3oQ51a12jAwVGaEkxSAlHMtrueSGtonkSPoT8Sei7hhv0cmKEc0DwqqIBLW?=
 =?us-ascii?Q?+J1422X8fRvHDpB5PN95D2DG7SBvWjZPUXmWjeL9viRS1cEqFuJXuUkbVSk5?=
 =?us-ascii?Q?+LUof71JeOWLirc6R1lFTsa8Ir82dZ3bTQwj1k/L77fXqPBI/xKwK3kY3b8x?=
 =?us-ascii?Q?K9vk23x+BXRForZcyr5YCsShHI6jA69q9ycYXIcTKfeX4+CPxtivsypHlBXk?=
 =?us-ascii?Q?rMyJnFQF8XWgPruANWE9oS0+EFDFF3cLamqkn604EYM07yVBEo2tcZEH8O3A?=
 =?us-ascii?Q?DS37SxJOHkr3127cKI9Lpqjm14KZ/5C7yS1yJuk8RxHXxlLWAra7yvnUWuss?=
 =?us-ascii?Q?UYVq2F43Yr8HmugY42rKmRqlzDghl/yZMIP9Jn5yAmP58dsFDZNhpwJQt0Kr?=
 =?us-ascii?Q?1NfNUrSltLHMQ81+Cho1FdWV7AOvcD6wxBvgyhKpQ/2qW0qjiOnAL7anqm1Y?=
 =?us-ascii?Q?QqtSJsoXMLcg4ry5DJF7U+4LG3QeZGWtXWCmKb5Y1d1VdnRFiPEH0NZAGoQA?=
 =?us-ascii?Q?7Fxra1k3PmNW/3QdVhwJKSJzWRF+nHOcqu59cMp0OA/Ryjfg1NyQGzoaGDKZ?=
 =?us-ascii?Q?9naLhYLhP+qXpF+jPJHCQ5Us/8VhRHmJMBNqXG2dm7pzS8xhs5NKNOZzWpUl?=
 =?us-ascii?Q?wM9SxkwwnzM5OVanEKsJPwq/IRU2ywFacnUIzAJ7KwCk7X4JMZVtYqyKNeIW?=
 =?us-ascii?Q?xlDhExECV220VzSJj0r/wsqEvdFSD4FsIOMuWIVcx5L5lsxjzYEa0C64F/Jd?=
 =?us-ascii?Q?N/kcqd51a673hOZUs+loIpy7FzPKc1ojz0wEACBehdoJRe00MU51VloNt7uE?=
 =?us-ascii?Q?fm9/hwCNff3X23vXEbh8Yfiiw8wk/DJE++SvcePDwkQS5TD0wtinTv7nYyaZ?=
 =?us-ascii?Q?86wA8eBPZVM/LzkixQCgZPns75SE0r8024Ijd8RzxXMbKvB/SZqxe8adMZdO?=
 =?us-ascii?Q?ym+D3CkLSlIPdGW4gNTnPECdnVxx771HKKdSdtt+05jNpxUq5OUF/Nr+xJyC?=
 =?us-ascii?Q?N1hIKFPT5gi4D7OyZfdan3X6vaTzNetwdNjHitn4DNdk4+HdObWlGZDcVQps?=
 =?us-ascii?Q?rJWnADN5Mc1DzYBJbj1BtDYhKhp9PnJK30GossQFbq4cFM7Yi5DvWXMlrHfp?=
 =?us-ascii?Q?YSgedVeY5yYJJ0wJ8KLstiHLQ3UoERX5h5XGgOf9bsKeYo+E19459w20kELL?=
 =?us-ascii?Q?qSQ2nYHanN5Qt6ifkLRGo4SUXBzKZovriOsOYXBKK1Z3kcGOrTxUM6LlILJa?=
 =?us-ascii?Q?O49AhCv+QR7LkIsr2OSdJ50HXCWYNOf/81fLSwaXWJgkeT+qz/lEGSEBOgd8?=
 =?us-ascii?Q?+jiu3FUbDenFw82KNnNAhthr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KEHvUQ8kOjF2up5YDypR21nhzhOnm/Opvt9B4/0pm5xry2z7I/4JKwCN82Dk?=
 =?us-ascii?Q?uLiVm69gTkKbZYtzIlVnHjat63Chkv0blsz/pu3xYyyYzvWGcQ7KU1bCEPDp?=
 =?us-ascii?Q?S2gP3UvJsAYzAJ3/7T8QOxgGTQHk9/KFDsgosn1hCyL+wpPWP9v5Rmc9+sML?=
 =?us-ascii?Q?u9wZqAQy4Raw5yl2qfBtk5lxRpFUN5k0Uek5HCwzjmSl9H03UcJ2WO7YBntb?=
 =?us-ascii?Q?KYgv2V043QdMdS1FSTIRUl763wQc+I3xyMHsrhWJlNrDXHq5d+16i8EEXX+v?=
 =?us-ascii?Q?quJB3AF1pMNHb9D5ktNIHGhw9RY1YkiucGCt3js0ce5JCZIcymXBD+SISSVt?=
 =?us-ascii?Q?iVFNnMjVSp/bSgPMqBPybGQZeZUSAkGNCxtFHFZhTfUtJ7rOKtl4hgyiJasZ?=
 =?us-ascii?Q?4RJt231lOBUZa3N2+1GIoaebSyqZV16Z7DUTKJZQaI1rCz0BQUb8/mMZ6PV/?=
 =?us-ascii?Q?g1qpVX8rwkhUYBaaW3tcvUrg9zekn1JQbo+o5qto4kgb/McgoHw/ZeK+kO1r?=
 =?us-ascii?Q?l4RL4dCS1toAEBztXkJVjmBOlW7wyPmO9OHv++7qLAk58ba6Ia6bLpKNcjfo?=
 =?us-ascii?Q?DSSosRtmC8D0BwqKA+zBDxgXHX4wcjjrvNlyH6cXmN6TBYFcdRu1hvQJgjJW?=
 =?us-ascii?Q?zJh/bEyHv34Fn2hMfGpoCq1jL7wyMEjtZlwayRSvaPPoBDEDrJT1TN7O4gQR?=
 =?us-ascii?Q?opNDldqQTyvMzlD9CMEZ69M95/Qj2Vbz6wJfhiR9ekbijJ/o5uAeBOQAIrqh?=
 =?us-ascii?Q?PbRDhipNwKOzpoCDERB/gbOYfhhhv27vqBXDY+SX8+A98bXAJOPEsBTqMF6z?=
 =?us-ascii?Q?SIYGgrcPhnFnMvqV6OsOVc1Nhw6Dm7bPTisAhZFWA+2ZQTXuUGnWW0hV3/A1?=
 =?us-ascii?Q?QFcqeINn/fuB530VF0doloFQkk6rRcHnqPfJnUBYqGkVFKccNuiLtvqEJml+?=
 =?us-ascii?Q?EzsbY1J3fZIw3VV8ETJnIqwBziqXPCqn+EjBXfZd1NVpj0urqilWTWfSmt8d?=
 =?us-ascii?Q?uoB972rLld6tq7Qq2USBWpTK4UxF83xcYsOl/G+r5ajox9Nz3hUeQBa1e4yK?=
 =?us-ascii?Q?LJEyWeEPtFYbZt8tVy0Og2yx19a+00lL9t49BNGF1hWu1KMMjRMhl/To/sSk?=
 =?us-ascii?Q?NDFlFeMTb/L9otYRnJ93czbnuzboEaDAoiME4FSILvxatFhJuacF/N8FdOJp?=
 =?us-ascii?Q?SCg614krkY7QpXnuQw3M0ceqGnOLz4ftQEkkUATZGfpZDUz1CdJqYhArnuOW?=
 =?us-ascii?Q?SZ7b/7JmJlj9qPpXmIJfTLNLnVxkfj/g7HPaKm5rkZtfGVM6OWEgpzv4fnlM?=
 =?us-ascii?Q?NITjEEk+b/NStxLt5rCcUJhjg8nov+OdZXPywue+EaneNJy+T9/w0tdE580d?=
 =?us-ascii?Q?RjO30ID5HJi1aWSmrNkAON/pH6uR03ZW/6f8SJrJx2l0uOABNPFkqQNdkPqK?=
 =?us-ascii?Q?DWrEYKEy3FlEwD1rtjAHIDnzysLIp4K+Js3ZUfwpkTsvNHVQN23Lw7lxoiZV?=
 =?us-ascii?Q?L1C2zr7WlhU4z8L9RbNDld/1x7R0sdfZ6CULFVng8L4O+fqrbAowQtpUGUoT?=
 =?us-ascii?Q?KEsb3TUdkpXkkwO0TSCiKFQVScVnb1S5YHBFAgi2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca46160-fb8c-4a2e-a6bc-08dcf6c2d166
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 20:06:17.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM+oYwwS3TQUc9zu8Bymf92Yx8ZVKtXrmxNdYdS/9wBpnCpFprC93l0DzFAlO7fq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

--=_MailMate_6E60A512-3AEE-40E7-B374-00D5534116C8_=
Content-Type: text/plain

On 27 Oct 2024, at 15:59, Hugh Dickins wrote:

> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
>
> The new unlocked list_del_init() in deferred_split_scan() is buggy.
> I gave bad advice, it looks plausible since that's a local on-stack
> list, but the fact is that it can race with a third party freeing or
> migrating the preceding folio (properly unqueueing it with refcount 0
> while holding split_queue_lock), thereby corrupting the list linkage.
>
> The obvious answer would be to take split_queue_lock there: but it has
> a long history of contention, so I'm reluctant to add to that. Instead,
> make sure that there is always one safe (raised refcount) folio before,
> by delaying its folio_put().  (And of course I was wrong to suggest
> updating split_queue_len without the lock: leave that until the splice.)
>
> And remove two over-eager partially_mapped checks, restoring those tests
> to how they were before: if uncharge_folio() or free_tail_page_prepare()
> finds _deferred_list non-empty, it's in trouble whether or not that folio
> is partially_mapped (and the flag was already cleared in the latter case).
>
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Based on 6.12-rc4
> v2: added ack and reviewed-bys

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_6E60A512-3AEE-40E7-B374-00D5534116C8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcenTcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU0iEQAJLlS1uAn0hOGOqkULFLrlkToTq9AXpu3xl5
znXaXG9+gZrQoTeryAtY8RniHECkjxevyeETMgO1MFbGcbtnauTbC6WVCI8UgiY8
D/jFEFyh4kA12xW748ywiJqGDqxU59Ckg8YRJtZ8W0qJhyjp0RqQDtSr1Wc6jLnW
9/scGFQeh5BYw6A/f9QQc+VKJcDs8uqLKzE09mPs5NY803N3N7nWQDxO+vGD7YmY
X8TncmWog7TzrxsgKCep5yykBZ/A8hRJLdLFFZ1fh2hkjSFlmzaklnfZZOyqyYtR
ek0+FgHYYD9wEoKqmxaolVCTZF6fcPkZ9lBDAp3zI3ipg63A/svR5yfW6tOpIkmm
P9ZkzmzkThI0porIZcPeK9t3J1qHn9wj8h66KvKB2lIZvQTRTJG/hVBoPzmmxC7g
PV5gowEcGRNL2nr/5CblqQNkwDcnOSV8aSpK1iWAECiHnpURbVKlP4EBORiiLMnW
YuBFVpd2Y6Y66xs9i0Vq+lkdtWms28c9vRrhud/FlkA/Dmbiwg2mD9m5Wk8efntG
xkeBQPPvz/T2UCKnBwQoM8a+KBGvM4gD0tCWRsUBenmYTW5gKG1aH4YApsn47wZ/
BgTgaHAd5ykSAtWte/TJ5OovXe/emB/DXMadCEdqwAaaPZ/Y3vED2WvF85Jln3hM
Trbcp6h/
=pWW1
-----END PGP SIGNATURE-----

--=_MailMate_6E60A512-3AEE-40E7-B374-00D5534116C8_=--

