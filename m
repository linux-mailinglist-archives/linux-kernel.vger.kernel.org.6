Return-Path: <linux-kernel+bounces-202758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9318FD07C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4522870A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CE17559;
	Wed,  5 Jun 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EaLsSoVb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7E17BCA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596590; cv=fail; b=Qz6J38pun/LikjZJQ0olfayTl/F9bVuCOV5JKdpSvnZa61GJXdAv6hzJQNtv9Ro8/desGgktuHRIjOEMEFoeTDuS8WItpmE29Fids4Mj0mxHVcjwqambHOTbO2h2t8Rju3bjdY9iJr0kb+ADsguoKxGKoxMIKWkz2Se+r9MnQHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596590; c=relaxed/simple;
	bh=I8X1pbivgdoMbUPo/U4OEelX31PHJhNGUjVnXtHizf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUeY1+8xitGkOhS1XDkfQYbJv+mYqpJu4aWQvjBnVplAYNRIduIvHVv2Tm9kCTTp5WzWR2r4Hp52L6hXkS39UljIWcM7e1UuNcPCAmAnNhWjt12uAfwJmd0CsgMnJ4tlNVpBCUcoxhiu2E35mCU8qkwdqriJ541YJCQm8fbfZVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EaLsSoVb; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IehODwUg2pPCGLuQxbfjqmiguLJBY6oCWBAqesO1k0iBe2nCedYNPCrWsOYf0RttvPxIuQBmdUxByF6DLDEa6u+AvjweUrAWWXBdx3u9e0hhxe/46L7twTqRjCIHa8IP3U+ImLfNu/kMuS8eJIrvnc08mX2Y+YrsosBQWr6WWHVOT2Ah6hM95GesFLeGTYAz0W7j61cIVD5FZzp8/R71wKprZNLllEbBfMLv6F9d+cNqrJORaI1dNkO9tdpryrzWjVd7D1z+2OAvmkszdFvtcWm4GQznhsEBLH2pC4d185cxvNqr8ZhOvC52SDQhtJ5MK7IxbSo3G/jRVsl9UlbqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6Rdz3gLqP6jIJmp8YZDatHuTIMWf+FLNopTMnQ/Af8=;
 b=d40EHIjcy6TyOzihfsAaMXQB+31g2FnAIPCxWw55E6CFCdstTvn5wwQt6RSH71yWSScCKaFhol0+tH1NckUC+j7X4lcwkEMnjKKuJikjU+q3JdoYDDW9Va2HFu+xbe69IW2uBM1YjCePcymXWciGU3Yfd5KgSPtZ1gHs4quEoI95R6u7093GyoYFXHTiFyDt3fJ/REDZIr02sjIDn3CFbY/Uz6Sr95/JCFq/VlTdLx4SJiKdZb1UAUFPCc5cGa56rxJWl0cF3Hzv+cBcx8cExHSvp1YdQHM6BzvUWgIL/yKAYbNUgsdDUoj9Xqd+dYk9kD4z9xiAYzco3Wn8EE0+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6Rdz3gLqP6jIJmp8YZDatHuTIMWf+FLNopTMnQ/Af8=;
 b=EaLsSoVbmGkzmDtPGhMRtEVQ1+/Fi/PeofM+3Hx4COwsCh3QgE3kYSt7hmR/Hc+qWIm5Jr46GLbEO0bqMIS7OCNae+PTbFV9xLXse0DDvRWSN83OtVvBNu+Lk70BBHk/6Bjkt0GxONRHkmw4mktzxa0yy9Nm73I/FJxau8Sd5t8fJbTBm9582zg0BSkqgbD1/VZvM2kLRivW/ksNipTCnzNkzQj2y6eAS/2vvilQi/fenLlUkAB2O+GexFdK7rIGcTTsZM3PFFjybRXwqXbq4AcnhRQSojDOsMd4Y0BE9DSXu5FMLOZKgjs+vrqm9frXxHSaDIkDYktvE+7McY3MEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 14:09:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:09:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: ran xiaokai <ranxiaokai627@163.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 v-songbaohua@oppo.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
Date: Wed, 05 Jun 2024 07:08:31 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <D667F08C-0CCE-4D5E-89A3-56674B0893DE@nvidia.com>
In-Reply-To: <20240605095406.891512-1-ranxiaokai627@163.com>
References: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
 <20240605095406.891512-1-ranxiaokai627@163.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_781623F8-93FE-4E65-9300-2E2C849131AA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:610:cd::9) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a60b7f-5ec3-44a9-f0b5-08dc85691ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbF058qb+iKIkHgja+Ze7KHllAM+pBMOcC5VqRPigwzfG+0zhOKvAmmbM2S2?=
 =?us-ascii?Q?ZtJ0Xqkf8t4/zcxh99SQQKiJ4eRT1F9DPvOUmEDsnlC3Lyt8OiI/z8wE0MdK?=
 =?us-ascii?Q?CPW4dQl5Jhgi21PU4C1zwOav15wmPie8+zwjs8SzjC3GQVqJ/cvtGUQSa2VJ?=
 =?us-ascii?Q?Juq3m8fAOGzZDIbcwcApLkkGyKqI06wsgSiFluCt1o0hSiYYmwaZDsTaOd7c?=
 =?us-ascii?Q?CSzYUpKkubzWgise2R9ei9zar32ZePpsf97EZ2SP66Yb8onJRF6vaKndxH/3?=
 =?us-ascii?Q?LyKKSMbpEXPaVwbLWp/Mr3IutthyEAIsO0bjonn3HNk0q3xJ8IQUrwgYa4G1?=
 =?us-ascii?Q?sJeZv6z/BWLVDJ4O10TU+mYFJvbBAZJbOyy5BUkGPwV5OiJywaZI097mK3IA?=
 =?us-ascii?Q?mBm5nAueE0C17z7x4rb0Uu2eKZ4bu9dyt9H+RbLtMsegtxWHbiplTlM/BW15?=
 =?us-ascii?Q?0TcT0aY9LcqsTa1b6ehkg1DXbnDbTFA+fKPys4KK67BEKMQRf5iQrTfrqiiH?=
 =?us-ascii?Q?Dw/TS4T2subl1G0FrHD5W8ly/Ceznr4TxOek00TME5yO/NtTTLj227dLX9bL?=
 =?us-ascii?Q?gWI+nRTP7BS2hxTv6loT/Zk9OiLabD/GRqk6Y2qLcDs2QNnBngykXlwlwdt7?=
 =?us-ascii?Q?2up8TyU1d81cLuiKuJfVOBZ2Bq0omKSZ4L+ygi4ibn4BTppaHg9zqN2kqiF3?=
 =?us-ascii?Q?EfW8xw9F6Q3uBs/Lg7OFRddHSX+HJumWW8I1MFZmQOnsB3nuqqF6by7EkDUW?=
 =?us-ascii?Q?5TD3r2PkBJGL6AKESdvVCl/TYBt7tAwbc7VSLYMhHJMPPWvvWrnbo2m3ClPd?=
 =?us-ascii?Q?zB8YePol9cCIzIlDNFW39obQ7VlDJw2c7cTmn7rjiLRMUmNGUEGiEfSoxHt3?=
 =?us-ascii?Q?HdRrcoSX6/jDI6H1XG4kFZ7psfHCGeMN8ZL/2GnBxNhp/yS72Pte73IEyIkD?=
 =?us-ascii?Q?RAmXuBDO5CEpjaDvIcOoNv4zFVd4KpbtjMyN5wq9ezSnlqYLFFQaFdh34qCJ?=
 =?us-ascii?Q?kEQBiMWYfNgZPuSPNmcVajS50UOGpx0cEe2iCMGYy5Sh9kFw3U34fcimNWpJ?=
 =?us-ascii?Q?8bIcJVuUQRrJgjpuEmmwhswS0qa6HWR4fNMClqLecM/47ewFCCp6atwW7OJF?=
 =?us-ascii?Q?gc0gPo+pVZ7h/Hjd8Qexy1m7YppkVjvs6kyopyGyn6vD6gpL01W5aBXgYyNi?=
 =?us-ascii?Q?Obj54KeZMnj02O+S/EMhY4ZjalHEdxvHa21Z1cDidoficgw+4QZ+dncgeI6b?=
 =?us-ascii?Q?0uJWVSZdkpYKzdyUu96XLLlsm0SHBPVhDoDwZ3q8TBc9Xe56gDXYqmwCj+DU?=
 =?us-ascii?Q?7dxpaykYCS7U+e/HdAN5CHat?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+0TnoCzjwbrUzqkp8snfg5e1uqmWYYAOaG7lr/XUPbxx9Sw2HqS3EpNGu9T?=
 =?us-ascii?Q?vszMfaVLCvKlyfj41Z5H1zMP21uz1CHmmIyriWCo9NK/XXG+CXS8RHP9+ke+?=
 =?us-ascii?Q?qrCVdLeNj4qHGoXQ8pj2TqG3RkcBLfUfO3suHfktdA+pRkfpu+YLzGbr1R2L?=
 =?us-ascii?Q?x58BSiIoXVdx74ap6wEFbBd7r+Q1b09+oOhNMfxDJzUaBSvyCO1GKf/kLv6/?=
 =?us-ascii?Q?3l6K7j5cBWcMQMGBjrqGmh4CoV2ZY68nca+pCasXGeceteOaQ5yelIUh1eoS?=
 =?us-ascii?Q?Ck0uykAgWQJa+X92fHPvAnek/K+bRIKPbCXI5j4uIqXhPnvSaGlOGQIrXvKM?=
 =?us-ascii?Q?ko3zwTsqC6xsILGNKnY3qvDXTr7iBnWmELrS6rOOgGk+9ulVx24vAxzmNiBR?=
 =?us-ascii?Q?MeTIysh+yEAUVYnSyoQhLKIr1hzsJ4XNBJfqzR7hnh3cYXeIIAE2OK5Q5b8U?=
 =?us-ascii?Q?xDSq2RKspf/tsNH+sDHFNDZysJdnNQ3CGQmO/K2gM9HN8ddwkcLPk7SFOsZn?=
 =?us-ascii?Q?klkt+i8C4GmnoCVUsPxSBuUH6/4HvOxGF5+BhrqcmU1DpRXn521IZkQ0cbUo?=
 =?us-ascii?Q?c7JDkHOgfKuDu+Ry8GGo5Yv2T7xDXv88HNtVAm2Wt2KEIYwPSCyMuLSSfQco?=
 =?us-ascii?Q?nbwNCaxKj+fPpQEZe9SWU1nWryygeHpnz+n+wt+9q2FcX5BuIwIlvT7Ol9F6?=
 =?us-ascii?Q?AAATgicw2AZREgY9hj/9XGrMw+gq+HJny0koggwCuUQRyjkCrU9771CP53jI?=
 =?us-ascii?Q?Jj9QTxOhH4/986bfFdZg/YxQ7SWOSJbeJs74UcrB33aaUFK3iUVTUAqphYam?=
 =?us-ascii?Q?Gjo8nwoV526aPmY99mPWrRxHE6SbANG3oI5E1LGrgtKMTEWDxJM4p2KVbNFL?=
 =?us-ascii?Q?VH+QUxM5xWL9xFYEtecl/RHqNqPqimLxgWWbujicuf8xmG75cdxDxxYAe6g8?=
 =?us-ascii?Q?nfPWglsdvHGkh5Ey4Txyd43uIcj7nCFbOiSJZHLAwrwwsnLnp3Un5H8gqjEN?=
 =?us-ascii?Q?7SEdNVWmUyP8psKrq6etDH9IuVe3RFcIKb9nxsGTDVyRArz9tDofheOMQrGp?=
 =?us-ascii?Q?2Y9Ac1wiFvaKfY0lPTiA2DbEyxOO3pyJeau8cOax/CYlu3R8rdaOkZ6Buidl?=
 =?us-ascii?Q?QQFvS8ZIgad/ZloUMjRjc1XZrvLoaHVp5noyAlflWKq213V4jQUcv8yd15Z4?=
 =?us-ascii?Q?he2iMhwGzpNwvlJ1y9TrYhnxjMAUMTFpPVs2Ix0hhBcvHW/JRqJ3mth8tvGN?=
 =?us-ascii?Q?3MqEJVd4azPDzlt3fSzBwga0cGrpDZOS6Om7LLfN7QM1hFJkIBklv8z/E0J+?=
 =?us-ascii?Q?2Vp+Ih8myic+qWsdref34p4IHFPtO+J44cmQoMZdwN7aKLfRu3vE+NqoHO8a?=
 =?us-ascii?Q?SwG19lXoFYyg3gjZqVVhLrEv6th3IOSSUVphIHMywBY3xWIa8OGIA9am/yXM?=
 =?us-ascii?Q?ct0LvjvbKsA80SptdJb8nzU5MC+OAmEJNnN4AyksgXgeSL4Z0dM4uUs012mi?=
 =?us-ascii?Q?nSSYxNbd/A0y7Yuse0tR9UXKy4KbM/3NsrVP+nQYmH1GSff/ldgcwbGuNpeQ?=
 =?us-ascii?Q?7gvZCp1GubD8trpVhYg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a60b7f-5ec3-44a9-f0b5-08dc85691ace
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:09:24.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0monpOIhOxp4yK6pQzgZs507VoLkNhc7dP7I61kHBCic+Y6A7N4iaxDljd/vCp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

--=_MailMate_781623F8-93FE-4E65-9300-2E2C849131AA_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Jun 2024, at 2:54, ran xiaokai wrote:

>> On Tue, Jun 4, 2024 at 5:47?PM <xu.xin16@zte.com.cn> wrote:
>>>
>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>
>>> When I did a large folios split test, a WARNING
>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>> was triggered. But my test cases are only for anonmous folios.
>>> while mapping_large_folio_support() is only reasonable for page
>>> cache folios.
>>>
>>> In split_huge_page_to_list_to_order(), the folio passed to
>>> mapping_large_folio_support() maybe anonmous folio. The
>>> folio_test_anon() check is missing. So the split of the anonmous THP
>>> is failed. This is also the same for shmem_mapping(). We'd better add=

>>> a check for both. But the shmem_mapping() in __split_huge_page() is
>>> not involved, as for anonmous folios, the end parameter is set to -1,=
 so
>>> (head[i].index >=3D end) is always false. shmem_mapping() is not call=
ed.
>>>
>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>>> patch, large anon THP is successfully split and the warning is ceased=
=2E
>>>
>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>> Cc: xu xin <xu.xin16@zte.com.cn>
>>> Cc: Yang Yang <yang.yang29@zte.com.cn>
>>> ---
>>>  mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>>>  1 file changed, 20 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 317de2afd371..4c9c7e5ea20c 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
>>>         if (new_order >=3D folio_order(folio))
>>>                 return -EINVAL;
>>>
>>> -       /* Cannot split anonymous THP to order-1 */
>>> -       if (new_order =3D=3D 1 && folio_test_anon(folio)) {
>>> -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>> -               return -EINVAL;
>>> -       }
>>> -
>>>         if (new_order) {
>>>                 /* Only swapping a whole PMD-mapped folio is supporte=
d */
>>>                 if (folio_test_swapcache(folio))
>>>                         return -EINVAL;
>>> -               /* Split shmem folio to non-zero order not supported =
*/
>>> -               if (shmem_mapping(folio->mapping)) {
>>> -                       VM_WARN_ONCE(1,
>>> -                               "Cannot split shmem folio to non-0 or=
der");
>>> -                       return -EINVAL;
>>> -               }
>>> -               /* No split if the file system does not support large=
 folio */
>>> -               if (!mapping_large_folio_support(folio->mapping)) {
>>> -                       VM_WARN_ONCE(1,
>>> -                               "Cannot split file folio to non-0 ord=
er");
>>> -                       return -EINVAL;
>>> +
>>> +               if (folio_test_anon(folio)) {
>>> +                       /* Cannot split anonymous THP to order-1 */
>>> +                       if (new_order =3D=3D 1) {
>>> +                               VM_WARN_ONCE(1, "Cannot split to orde=
r-1 folio");
>>> +                               return -EINVAL;
>>> +                       }
>>> +               } else {
>>> +                       /* Split shmem folio to non-zero order not su=
pported */
>>> +                       if (shmem_mapping(folio->mapping)) {
>>> +                               VM_WARN_ONCE(1,
>>> +                                       "Cannot split shmem folio to =
non-0 order");
>>> +                               return -EINVAL;
>>> +                       }
>>> +                       /* No split if the file system does not suppo=
rt large folio */
>>> +                       if (!mapping_large_folio_support(folio->mappi=
ng)) {
>>> +                               VM_WARN_ONCE(1,
>>> +                                       "Cannot split file folio to n=
on-0 order");
>>> +                               return -EINVAL;
>>> +                       }
>>
>> Am I missing something? if file system doesn't support large folio,
>> how could the large folio start to exist from the first place while it=
s
>> mapping points to a file which doesn't support large folio?
>
> I think it is the CONFIG_READ_ONLY_THP_FOR_FS case.
> khugepaged will try to collapse read-only file-backed pages to 2M THP.

Can you add this information to the commit log in your next version?

Best Regards,
Yan, Zi

--=_MailMate_781623F8-93FE-4E65-9300-2E2C849131AA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZgcWAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKhP0P/1CLIaYaV64XGPZzdAw+FS0dygPHkwxHDicv
OLGxGPsGgq0KFqPUAtlNiSf8BRYFPfg2G+JHH6BEYj+EatH+szvlTJQSt/i1vmyG
jotSQfY2jDTWKwlJ3X+u9UTiuMHDPHpCbo8lni8AjU3AYLOo4HXds9tvNkDwhXp3
Hiu/A8j57cXU3Nxk0vmp9Uqf5Wh9ZTDLolgrW3DMqfqj81JJX5+NOr55qOo68tob
9M7ZAIBwIjB1B5DmdNTuyletDPlyLsUQ7aNXtwITtsu+9jLNDtGKngZ+jGhxre62
rPBgQo+TJyGdhXHhReTNWmwdT31TJiw0emVQ/BMOZDE2GsQEO8+aCJfmXDzq4C6x
wPSUTdqbgwM7h33QzGN0pTfPHqfVC2YTPMio0EbvjJ/FVRHbtETAyNgujamgrePr
3X7RWtax7I17mFponyfEsaIYCpDH/eveca3J4s1HXQ8M/qoyf+nJvy3tMzNJwRh+
sDIbjm2sPPiVYedi6JKPx1fxyiEErxQNItFNWgXSgziTGN8xlKA5S2ZE+1Zev/uF
RkV1ROVZ0psB3KLXUCV2D704R31ayVZkywswIF3+MsNNmCQlT2bCuAXUjFYNJ5nD
t3l4i/cOLVkVOixXWMKpubyf+WzKqIuApTxH5e9vxAcqc5Q9z23FLyM9T0u/nI2P
cfhAX/Gy
=iCUo
-----END PGP SIGNATURE-----

--=_MailMate_781623F8-93FE-4E65-9300-2E2C849131AA_=--

