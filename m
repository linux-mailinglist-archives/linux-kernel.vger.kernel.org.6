Return-Path: <linux-kernel+bounces-428549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A7A9E1078
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78AFAB259EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22846154C1D;
	Tue,  3 Dec 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kbzwWEZ9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E914F104
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186343; cv=fail; b=XWAomv9urSWQvrsgsVNTy/BrHEBCRQ9r95L3CpzLwyCmQdfNsAPkVAAN5GubICMh3UOALxqvt6BBYqse1N1ohFbOR0J3YU0QulSM5K2lY91UunRKYB90thKZzAX81GmczYxJaMNAixLYoYYm3ZXKHJT3VtX3AnjMdi002Y6a8Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186343; c=relaxed/simple;
	bh=5mH+9IyBhglkcchYWEfVloPwZEREEo//CAT0uAp2bw8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DTV9skWM6heyNi1VCJ2y96cOCk/azk0kP9YrQg+tWFIstBcZPbdFmap9fqu7mvft72dnqC0A+rkaA8VwzIzRNDB1zqhVcIU7Hqq7PhlqfB/VCiQOl901/Jc+nSKxrpBbQR0GtxOkn4k851fSabm/rLWtnueSIwAbDoWxIf+07Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbzwWEZ9; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeqzXpl9vvxHrbbvb7JXApvwk9pWJ2j/h/vG4s+NxhrCv0XXe4p3BltL0UB1OMWpnBzMc5+nW2X5U9K+xJAA03gZWsI/B50nv+f2KU2xWDq0iPoIRZWHYQBUmVvfDVvXgKwoF/9apO80cV28Ss9tISImiWUdJJjNsdU5IXRyCxbywzzVD2qsE8l2Il4ry1uZgDSbXtPiv2hTyGdlvouYE/e31bBu4M5SvPJi6/j3tRH4UWGCIloiOHBJL53VeZiBO0AUbtQj3zsEMJaXpSYRjjmS1Brpl0G3ojmXo4qP6jgVLRewPiTDYCxNEVyHORsBVYIcOQkYaqBOJCosd1fQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXVdG4Xd1gKHjOhzbI3zXFm1n8jXoChDyvAjEn3StQw=;
 b=LRPMQx22sOMe/pmpf+VF2QW9Lj8dn2pt030ZMkwtl7Y78KjmGXSm8V69+cQsJbeDDC/5EIbCuFsHSI4k4VCu25uxjOPz3wLc388obbDTu5CpakgtIt9nv11HzQeVxp6e1B5Gah5ob6+AG8XwC7GtkJFDKGXQklyr+RDKGJr0ZiW17ItrKaAKfFlGm/qpGjfXXgVjPi3eiAWfKdwpZ2PJjoFr3y8WcpNSVang3lzd7uDzbc7gRc3NFaZDdAjKQ9I4V/OxtW4JPAaXjZgl2hMnbJ1g7hcT+abSE6TXiR9GBH4/vc7h5vMvIIgr5c5+7jc1+uHUN4dc2Z+FJyw22bRsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXVdG4Xd1gKHjOhzbI3zXFm1n8jXoChDyvAjEn3StQw=;
 b=kbzwWEZ9fzgBmEXp9TsCnjnDeVGKJ6v+TqXZq1YUS7rkYYQP+aqOHoctNHhA7XI1NgHjxonn2J+NNGnpGpBSNDGA49GCY5qew3FK7asZwPPHOPJj+FyIBsGfZczgbxtH9PTymFanx+uMke4q3evzathntRbAnz82xvJDAAyjDGDWJhZdy68Mz/tny/DiF5j7Lq+iyxA1lKVrpJH7ZirBEwpyZOYllo/GZgure0OFunULO4QSAodJ+/ErzZhtJ2houRnVkP5xRYg7dlAO8YPe/AR00DeCYp47WZHrdJCsmKv9dkzEJl7JCAvx76R/R8S6zKC3oCfPz1C/1K/pdZwKoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 00:38:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 00:38:57 +0000
Date: Mon, 2 Dec 2024 20:38:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Help with atomic fallback
Message-ID: <20241203003856.GJ1253388@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BN9PR03CA0738.namprd03.prod.outlook.com
 (2603:10b6:408:110::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a45ca3-46b1-4c41-5bfc-08dd1332df56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+U5a3oQqCnJPJLMWDJ7meADriKNy7fIGKuXKSkPhXvS8dx3mbDMc2MoAQGP?=
 =?us-ascii?Q?ykb65r7fi8NNCv2aUWSUkStjHvrjyaqALzxjZ07g4//MlFR1TDCnLAxNeyom?=
 =?us-ascii?Q?Z1L+Jj5H/0IR0NdNH3RmSPt5jn8V+c5WRNL0NiYTV1z782IJ4mCS7HDTMtXA?=
 =?us-ascii?Q?TJ8c3USGTVacXDfJorkUMO2wKR0zNO//yztwpaG4sNdS8QKgaoqLbWmCxaAW?=
 =?us-ascii?Q?zamZtDZqnrG7iSYTQEnB8Wh/76FZgd+UhbD9OeDSbZl4NS/TPCHFQ04Akll/?=
 =?us-ascii?Q?bzo0hzizMliToqP964NdW2BNtRvDwL4UDXuAKJRRhGz8GrgsPL1fK/9cc1c8?=
 =?us-ascii?Q?VgRSObGvhm3fDOXngFXP7rvrZ87nNcic/LZGhFPb3ENHgNPJq4Ikb3EB9IiF?=
 =?us-ascii?Q?6LzIvZgrP47RnkOBeHzZdRq9qVSqQ/+QNpgQhtM/7AtroedhOUC1XLpE+IT2?=
 =?us-ascii?Q?UNTDRRlR3yR9NzlFtiil4z1/OrChML1XPRMV7w+gPqj1fBhVKtgyqUbLhS9N?=
 =?us-ascii?Q?RDSO+aJRc7RVbFxBSYPUKqihYDRuwdo5WLjBlM8Epnh/2PaqETqaRWZGGhyU?=
 =?us-ascii?Q?Zp2dmUClzu7spV5VTLD4wMW6YhQBUVxlOZgCfZ3qvBprxtEmfGQ7PwAPYX53?=
 =?us-ascii?Q?tNfGV9kXnjEmHp1nKDcdm1mOC8WLl/mogDTBdpk5rhMU0lVXjpeWcPd6xaVX?=
 =?us-ascii?Q?GnCt/l+HoPrBsrx3oh/fbhn2CIsCe2WRib3/ZNNsf6voRndzZWMzdjURxxwo?=
 =?us-ascii?Q?G4H6rJHlFOCgmEYlgV55yl3SBEdK4HzzMcpr08eYWq43jVSHy6bHs1kg2D5Q?=
 =?us-ascii?Q?IL8XBD+BVKeJq7L12ZaOKbHCWNtIl9dBIAYSoZA5ch9Q2V3oV8C/hi4DzGMP?=
 =?us-ascii?Q?smcq+BjGUN+Ns/Cxcv6Keo2KPOfDvMsDm17Gu7nYgC6YBQq3IRS/79dAOZa8?=
 =?us-ascii?Q?Z58z2TcmMjYoOD1SlI2eyXiL006AauWSONeUvAVCyDSizYPlJ0ur8Ehh3OUp?=
 =?us-ascii?Q?5o51ePS97pjKD4xoqCP6kiEVjiWa04N7wpaHSFTae/SqgBSXg6QI3KZzmnV+?=
 =?us-ascii?Q?+KwT4AuCB5YYPhEsctfNC+Kf0C1LZA4onTEAAApLc8IrvLirAC09vCmTMTCc?=
 =?us-ascii?Q?1F2tS2nk02VnEvOCTgigaa1nEzBRdBaEj3nLlB6nOeWBxou6zHrgxMbpKRb4?=
 =?us-ascii?Q?DqBgTVx8RqcZGvJfY/Ll7mQKpt4K0eDJQjeRvYapfeB2xXENG+RTW+ra/GZS?=
 =?us-ascii?Q?WMeisU8UH7p0z4BdWVI/remXBjsDKIuKdp0KNi8Qu4aiWvGSgwbLtiSyqXOb?=
 =?us-ascii?Q?MMBb/ahv2Eq3mwaH9WFSjj+OoixyP3PkXU6B+9EF5zgwrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7blDmAnWtLtAIc8aS7Vxrtek/fDIYq+TMMsslK4Jnl1ku6VaNS+Bq4IJAWvT?=
 =?us-ascii?Q?68ddsyQAw5jmCoP6JS1RZZugCNtMJqpwbhwavGD0Pg6IwaL73iUSUOheiUWb?=
 =?us-ascii?Q?YA/xSnKbXoWxlsWt+3wy9PZ9yN8wVQrJthsqpWNok5evcYYXZDNEqG1ruEHl?=
 =?us-ascii?Q?ax1/thZPoKPdQTQROfkD57LgPRUzfJ4CgwRxwGbCI7BQxJB9FDxbDijPJ16l?=
 =?us-ascii?Q?mMi35vACv9nm2cLmuLw4y4wXvYl7qsEZ7Fzi9d/3LrzNiDExXOAI7S7npCTn?=
 =?us-ascii?Q?+eGg3M6lsSEAsaRI0dR1Wq7fGuGEQ7c0Tt8bUp4/4JoUBt9sQz91lDNHaEdO?=
 =?us-ascii?Q?/DyEr6+BWIDSYojJaU4nWLsnrCsAPDgHeT/pkPoEVCrcwaDZynC9PShtxN8n?=
 =?us-ascii?Q?x1riBfgqSg5FTV3zK5ohpFcwWyr95ZyB9rr7/6H8ji8WgjYWxZazFArQIT9/?=
 =?us-ascii?Q?ZAa8nemJ5MnfBEEHij9ig6bcNzPALdtI9bQfHSLh1Wwwe7CiznNueJST7YcM?=
 =?us-ascii?Q?0dIkiYZHAlQCff4Yg0+Qq34KtMOQS0N+74oVDtQblHn1y/KHGmNKRsIUi4H0?=
 =?us-ascii?Q?xe8+I741Mwf+QYKSi6c9RjGxGFiKE0j/mIudt9wCbIJ/91egMtWohnhkaMzq?=
 =?us-ascii?Q?gjW9c7pPnwq0e0xy5dIIEUgSsRh62z6/n4BRc9GtTCV8T8CMgtVp4Kffk91O?=
 =?us-ascii?Q?c4tCSGCUMeygbb55DRIrBlXU44V1PtVLG0mQSGKsRsukl7PIfGn4aaL/fYEv?=
 =?us-ascii?Q?I6BYg3l+JuLwzJKQePlFgsLRBxk0JhCTa/bQPRgQ/Ze6YJjonBTZ8wl9YbNe?=
 =?us-ascii?Q?FNZW5jsS077LhEZLGZPtHlzFwwd0dOx3DLHCuLQQAz/dyYDBS+ujD7bztBnn?=
 =?us-ascii?Q?y9QTLK2JHmNCF5aDEGe42x2GTfJ2QSt93LhSHv3SJisgBptfuYcWEuB1fng8?=
 =?us-ascii?Q?oyRYbJ/v16Cfdu8MSbR3lp7vZQI9uEhMJ3kMF4skZpNtg+lEoaJAV1nC5aA4?=
 =?us-ascii?Q?f7c6La465o1L0TgxbkvR6ONcH+8JIvWkeO+Vutp3sgo5tMGmc6jMp7lwl0xq?=
 =?us-ascii?Q?koghMjDIuHYxKsgG2hC+diwjOPhmztiMqHWN+jEyEHx63nFXRYJQvF0HmT1m?=
 =?us-ascii?Q?xkDSgO9IzpLV/JXd/rQZI0R0wUgFnocgZm98QXI8sLY+gI0Q+5dn8W0rYtlK?=
 =?us-ascii?Q?HoUEvSCD9Q7kNukGZpAMNoUj8OBE1/vAdQ4JtyqLgGf2miNrhl8V49yE3bsA?=
 =?us-ascii?Q?AB7/whNdcL0IEb54VLAq2FzAW6rMRXzuhA028ve2wck3Wgux9pqHTD9hg0Hx?=
 =?us-ascii?Q?pALkLZ3ZJOY/XgGKr6264crL+TXArgyJQOHYKAToI9aDlTuAm54wANaS5DEe?=
 =?us-ascii?Q?WiY786BWBR51jknEusRX/ev43DDsb16fRb8nK6foVBpGrSHbJX7WjQmm1JMW?=
 =?us-ascii?Q?ddEAMQyRZDk+MhYbeSCon/zhDxGilRGjPU2qqExkhT9mdY4/J6WvtaWGaNz0?=
 =?us-ascii?Q?CVyCtaOf5J2esm2EDJ3LTyXBYc6ydghB5k35S5719JghMxI9esHpvadrmI+e?=
 =?us-ascii?Q?sGcWwpzk4IeytCqs/tfXaL/Dg7W6n3ipoLLXi2Nt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a45ca3-46b1-4c41-5bfc-08dd1332df56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 00:38:57.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAiuYY6mYbndNxdzabq4CJ3ut6L5ADhGeWtviInbHL8GwGLpXlMyHSwKSu1IDsk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

Hi Mark/Uros,

I hope one of you can help me unravel this, I'm trying to use
try_cmpxchg64_release() from driver code and 0-day is saying arc
compiles explode:

   In file included from include/linux/atomic.h:80,
                    from drivers/iommu/generic_pt/fmt/../pt_defs.h:17,
                    from drivers/iommu/generic_pt/fmt/iommu_template.h:35,
                    from drivers/iommu/generic_pt/fmt/iommu_armv8_4k.c:13:
   drivers/iommu/generic_pt/fmt/../pt_defs.h: In function 'pt_table_install64':
>> include/linux/atomic/atomic-arch-fallback.h:295:14: error: void value not ignored as it ought to be
     295 |         ___r = raw_cmpxchg64_release((_ptr), ___o, (_new)); \
         |              ^
   include/linux/atomic/atomic-instrumented.h:4937:9: note: in expansion of macro 'raw_try_cmpxchg64_release'
    4937 |         raw_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/generic_pt/fmt/../pt_defs.h:144:16: note: in expansion of macro 'try_cmpxchg64_release'
     144 |         return try_cmpxchg64_release(entryp, &old_entry, table_entry);

Which is immediately because of a typo in atomic-arch-fallback.h code gen:

#if defined(arch_cmpxchg64_release)
#define raw_cmpxchg64_release arch_cmpxchg64_release
#elif defined(arch_cmpxchg64_relaxed)
#define raw_cmpxchg64_release(...) \
	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
#elif defined(arch_cmpxchg64)
#define raw_cmpxchg64_release arch_cmpxchg64
#else
extern void raw_cmpxchg64_release_not_implemented(void);
     ^^^^^^^^^^^^^^^^^^^^^

That should return int to make the compiler happy, but then it will
fail to link (I think, my cross compiler ICEs before it gets there)

However, arc defines:

static inline s64
arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
{

And I see a:

static __always_inline s64
raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
{
#if defined(arch_atomic64_cmpxchg_release)
	return arch_atomic64_cmpxchg_release(v, old, new);
#elif defined(arch_atomic64_cmpxchg_relaxed)
	__atomic_release_fence();
	return arch_atomic64_cmpxchg_relaxed(v, old, new);
#elif defined(arch_atomic64_cmpxchg)
	return arch_atomic64_cmpxchg(v, old, new);

Which seems to strongly imply that arc can do the cmpxchg64_release
primitive.

But I haven't been able to figure out what is expected here for
arch_atomic64 vs try_cmpxchg64 to guess what is missing part here :\

Any advice?

Thanks,
Jason

