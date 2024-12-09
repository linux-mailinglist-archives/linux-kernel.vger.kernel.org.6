Return-Path: <linux-kernel+bounces-438182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BAA9E9DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E186A16742B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458AE155A21;
	Mon,  9 Dec 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GUvc9aCy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051E1F5F6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768067; cv=fail; b=uoNrlVBdYCoKYcKBn6VtebGDLe3AWTDmxSDlFOtSA4Mt1oiIY4lM24BH6Ozpc/CKQiKnBBNTBUwvoDSqyzZzF6OVB9qQoSiIBuUUcTu8fhrDijHJ67YP1VHjDBfHvA9y7lyvfAPBYjuXYNKyUMyOuoO9rvhz8xOZCob0VXfGK4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768067; c=relaxed/simple;
	bh=rZ/VwLnCIMTZky41PC2gmz3PB7Xwma8SCjMooi3E9qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uq2zR6Bq0pFLOKYrtNiV4ZYUa+xuCYRuun03DbMJj2uvxLYphjGDjGnOYd8ZnuoREQwZBErUaB4C1uAGyth8K9BsukMqqlgdBRSXUHdMfkgpkkBRvNeBQmkBMTKVOCx7pc97OpxnUdl+MnoEMOZNb1aNsv5dm3iTvtp3zLYYvSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GUvc9aCy; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXbyWGai1Tdx5OVgoYEAokZPzSNEZbqIx3RtoDaLkUP0pbLJLwprEcg9Hx6nOLzAmth7I6HXH0j/roAhw9SJWvBoU3PTqaeulCix4M/QeqkfH0UPdUhuMIhLuKzSw/quNj3P5wQlH7t4t0qKkEnmD3R9OuqdI/dcf1SY1m8hMfR9a8wzklcc4hbHmMKLh3DuS7mp1faDPaCjPXTtMhwLY5JRNgQ6oJdWvhvU9BDS961Qhw5ez1qBTIQwGyVdGpCvodyONko4lgXYPwvKNh0tMGGcaVhpEIJBy4omQbY81ptUajKW4qi9F0hERzhgub9QIVhGkm/XMAVKn+7l+luH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ/VwLnCIMTZky41PC2gmz3PB7Xwma8SCjMooi3E9qU=;
 b=iVrWhCbVBdseOYxIBmXv9rG4c7kkrfDXaW/faK+Rl2VWCq1+QwVpQkIRRRlENA7FI8eSSWk4xa5RHYeJ9yZoIZgyTdHW0ab/LHxmZM+DNhoK0KQrRvSuEbUZkrEVQw552YfmVemIrh5NjD7MuHnOEa/yRsMVjMabhYrb7LdJDR+eGPcULt5q+6v4FZHT+kjEseAV4MKbOzqRB0G4I3w0K3g5OPzvUO0TpiTNIm0qsLCAvQjvi+9zGCulUv/zRQ0i2R+FtNrMWIZf1qgx3GDD52aXe+wgAZ2kp+Od+iNMKPonPyYH4zexgrQBBqdOWamtnN16LXJKS+sCCen2jVazIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ/VwLnCIMTZky41PC2gmz3PB7Xwma8SCjMooi3E9qU=;
 b=GUvc9aCy4cJMEFt9etzsCY9WFO8wxbU0cpmrhXrUKzAGYO2tbB6glPHQMq2BbUAch7xaaxFGew5mxLJZVtBETinK8mRAmqnj76NM83DIaK1IjrNEjae23bOGbWT8EjPin19Tjf+NM7tJRmZNz1c/tMn/yqswuJ5Ct5fjQyMmwRkVzKBVN9EEh+VrmG5PU/jRXXSEbSCPr+mPxBjO0M1iL/Np39Ri+CMyMTnmCpJ1gMtzfaKpAb2e9vnsTB9tzjfca2we8LchhPRn1QToamk5DMGY0brb+BttTrAPC+OFAHoQ5qdbRNS/RjA2eZiMUZ5JX0VOyJe/yy4a92Ehd8QmXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Mon, 9 Dec 2024 18:14:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 18:14:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v4 2/2] mm: use clear_user_(high)page() for arch with
 special user folio handling
Date: Mon, 09 Dec 2024 13:14:19 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <AA1E2DF9-ED7C-4304-8BC5-5555167B1330@nvidia.com>
In-Reply-To: <673d05d5-276d-4b65-941c-6c9295e276b1@suse.cz>
References: <20241207171631.2853336-1-ziy@nvidia.com>
 <20241207171631.2853336-2-ziy@nvidia.com>
 <673d05d5-276d-4b65-941c-6c9295e276b1@suse.cz>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d8ff4d-b483-4f24-2f54-08dd187d4e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24cXdrYHlAPHF//OyvZIq68oWetAlagEafSC8QuJywZZoCKkuX2uHLO8BgNO?=
 =?us-ascii?Q?vFpStYPF0Xioj64owDKNUL2Jvor4POaA843NXKst9wHyvF65UE9rnVuRqLLR?=
 =?us-ascii?Q?m6UHDWBwIAYIupAIZrQkltRqJ283msXIWZZ4DU3lxVF5EsS6xz1v+L30u3b0?=
 =?us-ascii?Q?bsYV0NTKhP8DtFrWyD8xjukXk7SMsfGu7xPGA3fmRP7J43QUTMBEWWVv/e09?=
 =?us-ascii?Q?zD0eir4MOBBBfhbVs+nD4KVOTO0+IPRkmJLW10uziTUZax8UCRKpSt6g/5Wl?=
 =?us-ascii?Q?DPdLHGOW2L0XqpefZPGyEVJ3VrZ7NwLLdMccL40EsZWXHF/MXcMo04Iq9fcI?=
 =?us-ascii?Q?lFPsWCp/XtbNAWSzTTephhY6GfcBrzhmuH9Y1Z6Yw0y+AE2o51/9MbybMaKt?=
 =?us-ascii?Q?Km3zu81EnPzse2Xn5IUmJQsKs/9cXLVEV5LQFGix1qbcFGdzQIWrAenZWfA0?=
 =?us-ascii?Q?7x6mlVUybHJr3N5cx0YyfSOJtM44ebi5hZ3lgvDkzsMWJzQBw8f2df53I7/f?=
 =?us-ascii?Q?pnTOxgFuvK8n7CvlRfQbhmC33/lwdl6FAQgxrmSovtMwL2p70kLK1V3r9WIf?=
 =?us-ascii?Q?LiUXSZW4t2X94UjH3EDBk/SassdecLMnwswAUGnBGJBR3i/KaCGDQv0HjdMO?=
 =?us-ascii?Q?Duc9dDoLlR0wuFDAMJ8EmiFIOA3f3nSzMmeFgdtUXTx5ztMLQKATb+L0KnN6?=
 =?us-ascii?Q?BGV0WQMxoTl1S58AMAE2OcyPLAJT4uuLombyCAPdAYOdfnWVqEqKXLh14Hzw?=
 =?us-ascii?Q?pGDsGdUz4A/79FbH32vG13st8Hpy9sqIF9CQ2Y+o99H7GSW5oWuPe3PAoybM?=
 =?us-ascii?Q?pz80beYjwhNLQ+/cvE/zJTvP1+hJjR+fl+AGaIcq33XQs1j2KePuMJzP4d1w?=
 =?us-ascii?Q?mXo+oKm2wUnyT1/QRVfC5JSIhH7cOGrlPSgQjtr5qMqAMMQDDewS8qpc6JUj?=
 =?us-ascii?Q?H6TRQsWV3wjbaPjL4LKc3GTwNNKEj2xZEHmZzKMst0g7zgJOXfQahnfr3Ujp?=
 =?us-ascii?Q?xVVfmHB1sFVlaRU2UygQ9w4Bv1TNpStqNf1cSlkZoTVwcTKstainmMSWbV1v?=
 =?us-ascii?Q?d3j2QaczJIKMTNThzphGawyS3oxbg4Rx5cTgFQLukbgc9HNC0roHh+WPRFBz?=
 =?us-ascii?Q?fyaNowMXFM83s9iKxS2Xi87CskJdsTsLDObiq07yf+T2eIcXUfnP40k/pQjO?=
 =?us-ascii?Q?jlbEmPe+WG/eDA1lQtoQjRFf4sisyyCFdmR6JGe81bsqtQcDiNKsqKiNb5ue?=
 =?us-ascii?Q?XTM1sQAPP6WT+XI7ANFrq2O5lae6ZU6OViZYQAHsIARf+HsofZcf4f5vBb0d?=
 =?us-ascii?Q?CHoDSe4G4AqIePEgxDxMv3PZZxGYz6j9Iz9pIuRIeqzjJIq/zU5+3eO4fZGx?=
 =?us-ascii?Q?GdM43Es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lpt323Y6toS2o4RKjKqqeQ7bgHMZFmcrBWEV/dYrSOjWYt5jADukPZBH3PZk?=
 =?us-ascii?Q?n2Dbi4T/5llEi2DsksUzorRHG3XYkYgkvWYGKWCO/oS14xspEv5fneT3rWo2?=
 =?us-ascii?Q?NKZ3Zqo1/20ta4chvOzAB4jyK3tlUjjTOjAwAf7Edf8ZQYj2sY/RCaDQ5LEo?=
 =?us-ascii?Q?gBklMnYI8JknbhGLsajJENXlbsa2vKv18lZMQK+NO9KSPxI3Y9sBHYOwHrDv?=
 =?us-ascii?Q?z2xavc50kyZxjkEbOa6azuu2aPLkV7ZDg9PzFIg0SzP+KPoIJSQqnGJvFrsr?=
 =?us-ascii?Q?015cCoztga0fDFazhJQ9Ulpx6q29gCWQa0g2PQ8ffTTKynAX6qvZqdbZjfhf?=
 =?us-ascii?Q?eFRu725ldGDpjh7wSEiPlxiQ9AOluGTo3/aqXxIRbrI1oYvvb6kI3e6eiLDL?=
 =?us-ascii?Q?ACpxURm8sKnASUkYtqzNSBbu5Bx6vGzWI8PqPbCSCx9G0oJBeAxG9Wm1vg/Q?=
 =?us-ascii?Q?Cw0n5uYqFk6tij5Ad0BL1AW6kOWEByEUsEnI4j5F6Ng2LlHt/i+bIELkc1bn?=
 =?us-ascii?Q?+mOFg6B8Kg7hpCcBJrf5LlMhIj9zsBYJavD9T6mpxq0MsIAVa24y4TnfoNFi?=
 =?us-ascii?Q?5KISs8l0lxUMOG1Dq01asn5F9czxVSNnQgg0ZdNmXzH7FBLJFDVufucjaPDP?=
 =?us-ascii?Q?h9ymUo1eWsPD/WFXjgRTOYjvGpGQGet3Zh2S44UATcwA6zOrKm7SRZ+CO9kM?=
 =?us-ascii?Q?8SOOrj0NiWLYXZNZ5o/Kk3KdLFymj0bboqcsaFGfHPpYuVTgsKYyvkeT2EXo?=
 =?us-ascii?Q?4kJCIsWk1zBOXUa+H4DZxuQEtK1hBm4p2vRfEUvQJmjKwxpbfVXKMRBRpjE/?=
 =?us-ascii?Q?cUDWZMy2bs1bAT2tgbb4pbW3nLrinegu6kpaXMN+ymGfhkUY/U6ndnevegja?=
 =?us-ascii?Q?whK0S2T6OWL8EZEVv5m4WIehYcyJiWK/C7ufqlMwVJ76xc8dvVNUWah+CFYK?=
 =?us-ascii?Q?oD7nRa2q22sVqFfo60r6YWX5zDk2EMdWomjMD8pkJeTTkFjtl6SrQIbMCoon?=
 =?us-ascii?Q?fxT5TZ9fd3y1QMjbe8U5UoeNdzO64ubSa5T03JbK3uonUS5FCZ4FzBUWsChJ?=
 =?us-ascii?Q?iMOZIvrr7EPzzl9UEERXxs+C4EVt2PKkYsGYomCK6e1VnniUvQxMI1VI3qes?=
 =?us-ascii?Q?L2GRuQtRiqi295BbjkZThVghmCEFt5shIgdad9+ctxqXwFOZwOc9Y8ie/KkC?=
 =?us-ascii?Q?qCvjMovpAPEboWdQQoeeHBTaCeIgdPnrtuAiDVX82Tz9aII8qMBn9yAtiF/8?=
 =?us-ascii?Q?R6EAg5jLFa84sLFDs/Zt3ZwyXduw9iaeD597CCobk2iUhJkuMRzOPyOkGcuS?=
 =?us-ascii?Q?dik3Vn5aCvV7V21Q2tdHEkIxa7Fl64u9Pf8yNUj5m2mHFB12lBHid1dOW10S?=
 =?us-ascii?Q?haegaRlgy5q0iDf557VsK95lg4GEgvX6lbysKTMwpb8GmZ/AM7QOo9oCh2NQ?=
 =?us-ascii?Q?y2NrMvXBc2IJDyCWQ8iflK55Ybhyy1d3YA0SejQT+k+gcidjOCbyes1707x7?=
 =?us-ascii?Q?BqGkaR1vS0Ch7TKOV8Rm+JlledCD/QYUXqE1rxNfJsBtmQxFI1umA2Hqx9Xu?=
 =?us-ascii?Q?BLfr0wkCe643pR/LaOHUAnUunuKr5wj3ohzkcJeV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d8ff4d-b483-4f24-2f54-08dd187d4e5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:14:22.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW59t/713L3paOGAStarqViw/IJEW81yFvKj6I9l4nUtLbn9FwDqU+gbO46AtA5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345

On 9 Dec 2024, at 13:12, Vlastimil Babka wrote:

> On 12/7/24 18:16, Zi Yan wrote:
>> Some architectures have special handling after clearing user folios:
>> architectures, which set cpu_dcache_is_aliasing() to true, require
>> flushing dcache; arc, which sets cpu_icache_is_aliasing() to true, cha=
nges
>> folio->flags to make icache coherent to dcache. So __GFP_ZERO using on=
ly
>> clear_page() is not enough to zero user folios and clear_user_(high)pa=
ge()
>> must be used. Otherwise, user data will be corrupted.
>>
>> Fix it by always clearing user folios with clear_user_(high)page() whe=
n
>> cpu_dcache_is_aliasing() is true or cpu_icache_is_aliasing() is true.
>> Rename alloc_zeroed() to alloc_need_zeroing() and invert the logic to
>> clarify its intend.
>
> user_alloc_needs_zeroing() would be perhaps more descriptive?

Sounds good. Let me send v5.

>
>> Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with i=
nit_on_alloc=3D1")
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=3DHsfgK=
QeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.


Best Regards,
Yan, Zi

