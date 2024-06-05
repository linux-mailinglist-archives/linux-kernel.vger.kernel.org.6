Return-Path: <linux-kernel+bounces-203379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB78FDA1D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7991F23C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D201607AD;
	Wed,  5 Jun 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0osHU+Z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FE29AF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628393; cv=fail; b=b8NrTJhb2z5/uXLB8V1HdC1YjXY+fcGIH2wK7wV3z9EwVysnFIrlsxLAAHVHHqLe/8OLu6OblAnIi3dGQTGHrIflyO4lnDAEQ3IoPebopw1OOrY5PrIasMrPb1GD0ny1L2QKEu0ZJ5Cmvwza6WHbwRwjQnrA8oGeL7nzkZA4qVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628393; c=relaxed/simple;
	bh=NBJv7JcMm+UvTm3JXfE6TwnxftY9UJ9jurrVX3T9Yj4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=V6B+wYRonz1GDYLKKAAbmFy2sUPTdvzsK2d/qxMIbFksfoKWh+wIdsRETNO9n+bo7pJJZFR7RTyCJtk8hNet50KFxa3jm/qFgvYBpcVqCFsAmgM7ar/aBWNxToAJ2VK6/J4GtcQAxnJpp2H12qhAevH6pWBpFkYgojOITjyMS68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0osHU+Z; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fqt56xHGzE7Nszk+LbHDR5izoEeT5gjXZ3kmnu5PT0m+51hl37L8rSeE5ANp5kiJmCXqUOobUjxT9fMg8Nnr9VoBrj5K66bJkbiNkq54Ce0M0ktAzj+YvFptTzCKRwQfq8L+2OWjH4ZW9Rygg30QTWDsJ1rLUziDghVmxI40+5jM3EYfuVGbgdGHuMkyNeecXjoIHLpodL+sGdx1Y630y90U4qtEYQ5AwV52kKI/kWLmeF9FpgBcC+z+J3LNTVPKClqukvIAz/5i9l7rN4KjwgPkV1uiJyD/MoR/k1PfziaQe6GTI17PRXbk19i1ei2m7AEYsOb/dQxM2SZ6zlCnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0OUqTCNsCkQCb4T8uKFQI5gFjrJrjuno7hJLWl+Ees=;
 b=HBMpQ2PZVFKscnoToDkclAynJ6mzau/YJvdz9GpgdOM1tTguiZA8sP9EMoSxdGNLDQNC3t3tt7rv+tYt6fiAW8u7FpNH4+aftJjnRxGIi7Dcz2mfxkKHKGKbkTBnXhivOJzlOL3+VLLZJFYVvWUClNPmQiGdb6jYj4BDpeDqSwA0pylR9wHdU1CaQocb/VorFWlnV6Ns8QLj9vL6q3efsokdBLh7d8zp8S99Dnr5cVzjgoX4r72pC/EvtS7E9KBYr1F2fmYtpYsjq74KlSVYzi1Pl479dPoJXKFOj9bINEnfn0XjppaeylHxDoyGmGGTcQpgu6HpydWEnL6S4RtupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0OUqTCNsCkQCb4T8uKFQI5gFjrJrjuno7hJLWl+Ees=;
 b=N0osHU+ZGbjo3KUPYrHCTadeNWBauW1Cxe+oy+Ft1F0HCATqAb+clAgz8rIg84NDxUZ8f+2o5Cm61DX68WWbeamGbsrAboLaBY++8FbWJbd4rYkRzc2175NasB7SJWagfCBmeTzjFvCP4gg2vqMqvkcc9fG7gd7FYr8JTQAXvRH+f8zZ3ov1/HIqWRzOemyABDGCHgaUXKMUKUn17CAfj2NMxqwq/O1jd71nyYsasVHleCwGs0dFr3meyIOcELafu4SuNiTuhcyXxS8uRl/2E2UDCNrlVrM8tfFIZIUylAa6pfeWsOOVFwaVbJoBqqo/7v28Y3lm34ab8g1Na5Kuyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Wed, 5 Jun
 2024 22:59:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 22:59:45 +0000
References: <20240605212146.994486-1-peterx@redhat.com>
 <6660ec883d31c_1ad63294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, peterx@redhat.com, Pasha Tatashin
 <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
Date: Thu, 06 Jun 2024 08:58:08 +1000
In-reply-to: <6660ec883d31c_1ad63294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87wmn3q9lv.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0004.ausprd01.prod.outlook.com (2603:10c6:10::16)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be240e3-63d7-41a4-5dc7-08dc85b33122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fcrcji4PVDLdFQmS3kdFmSItH6X35fF0XKXwjXCltU6x0qsPqmIeWYhxqvOo?=
 =?us-ascii?Q?txkxUlf/CBPO5vBkBePSr7tEDOxDV3r7jwRodh4oJNPa+BKJlysc7wuMKUyP?=
 =?us-ascii?Q?1r4AH2huvDQb0hAHdUQ2lsTjW92Q41MssCjjPfAmaKlaRCvyd9FiMrZMkSrW?=
 =?us-ascii?Q?3mxjCh91OZjvqDmvcNHQVcgJXUaK8dJi1jCikNoJkHXBfgyiFuBy4dA3muJi?=
 =?us-ascii?Q?bWWm6f13Oo0JS7Y66qMlDU/o3zXTg4C4cJbooGeQnpFX3UH99xMwKwHVjdnW?=
 =?us-ascii?Q?dz8akSDx5eZ/TJ13ezw36TqLMEo+FAvQTc61KjdSmbobF/iUwo1N4aRUOVQG?=
 =?us-ascii?Q?WsK7RV057BAp842hPYiMPx6fMv179RmshUOnf+Pjcvxz9UfdRFGg63GXolsB?=
 =?us-ascii?Q?fiVUdI7X250/TFWB7MhpSre/BEc56h/2ryUswGYowAeYRCChXpLjbOkEqU/H?=
 =?us-ascii?Q?5zlZ4P2iIV68pe31DIx1a3Wuc5cQj+gngNelQHwUm8Ly2rCpc5eYfBe9oR5j?=
 =?us-ascii?Q?7z+RjRPjRUlSOuI9Td9VjuzJRlm81PiDKddrvyzY0sm1fU//jfgBC0YjpswT?=
 =?us-ascii?Q?VbfDoeBWg6hvdOjNFloDQBs+jN7/WB26jAK7QKy5xFKthw0QeiYOtLwRsI6S?=
 =?us-ascii?Q?/QhN8iCg8nDqkv7YWzyc/XM3e5fEE2LUvRL5ntBi+aWoo3Tl/lb81Tgdnh6J?=
 =?us-ascii?Q?/Qec2uEOtpRBF44kL/a7RWWLfWiXlE3C6ee72HGVV/+Jh5trgDwTNTJW5B6u?=
 =?us-ascii?Q?pOgWRWZar+SyVaCQf7XX7XQHhFyRfajPoSFhfA+Lq+ENAJ3N9IKKtUfUP3rF?=
 =?us-ascii?Q?G47Gm2uaG+6On5NHe7lafsTf/sWb0oknDyMyhG+47EYSihv3D3L8F+KutS3V?=
 =?us-ascii?Q?QkMCRVSS4UvL1KGDBAy3ld9X55Vom2aAErByhj4hdUrjXRMid6yri7YLiM0T?=
 =?us-ascii?Q?CTDvaA2FV2Cz4NomW7Xx6jGTRpRxAHcORWsRbGePAIlb5+yImAIXLqfaMtYO?=
 =?us-ascii?Q?uM/mQEcgN8E+vs9DghTU2rreBWeIl58KqzYmUXqEfqe2Iir/6rNYGKmKMXBZ?=
 =?us-ascii?Q?3eSn0tCBCQa/83VnVUfcHRX4gUOM5CJY386DzhKDKGpXUBA9M8SIL5e6RGCj?=
 =?us-ascii?Q?uaFUn1tbIzP+eEd4Tanq+2AHw/7SUdVkikl2rXKpr8bUjI8YApoiX19NkPB1?=
 =?us-ascii?Q?RZfIWhjOU7AMP5gRPSlqNvMeDGBkAkiwjpl8d69H0QDJ662JQi4IAseM19aS?=
 =?us-ascii?Q?W8tcqZKWo9sR5BpvXBWEsbILLJdekF6cjxqOH/KVVfj3KPi4UC6rMEgqAQ9s?=
 =?us-ascii?Q?zMNqhzqD83C3ZCqNvJFo3gAp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jkr9o0go2kYZPwJ9wOKdjsU9Oz7pdJu0RarkyZ4RdNAkBTcYMbPpTb/USm1i?=
 =?us-ascii?Q?lPhwmJ+4NPMeEN0tx8BN7+jxCVWBIEy5w8FvOa4/Oen67jyLnooz3dRw25hk?=
 =?us-ascii?Q?w9GerXOCDqt9ukeP/7JBIcksbi0mCZy/HBdpEZDUU2dZmvXtN1GbKyrN7bOC?=
 =?us-ascii?Q?9a47xWRIQ4RPxgdH47HQP6AXt79PC+XOStFUybGKBp+5L4qixJn9X96t43RV?=
 =?us-ascii?Q?0BLEjcFTP4kAzs6MDjDUlQ/M/sivspGqCJ+6DlObCnZhsLEvauacyFAAgYOg?=
 =?us-ascii?Q?v4PgMJEIPJR3EUkVpNav+kqEjBIks/ud8Ur7Cx9wGbeFY5yakQsYwejRhkCG?=
 =?us-ascii?Q?VFckTNo36JTRQIe4Lx0m7GYi4NX8z/87uPTHTenan5hiN2h3GW/kMpUbTW4Q?=
 =?us-ascii?Q?3t1ivltIJUAan1fEXXCG+1Asn2tHLNdKsdpvh1eebYgWjB+i0tnO0p54HZYw?=
 =?us-ascii?Q?kwqp0N/coi288hmBKTyUmJnQt7NsyEIp4/J7/aa4zgNAO2+giZtU/V/s9TlN?=
 =?us-ascii?Q?tGvP1gGsutVPn/SE/cCrw6U1zy/Dh438+s9bFHce5pdRSb3qYdmvsEgQ9yMH?=
 =?us-ascii?Q?khfdK4QnnkBW2I1URDr/PcDU2R6mEqF6qrZPuVwW3F4U3CEPVoVtSMVKReTm?=
 =?us-ascii?Q?c78ePJosGJzg3HaUmd41lnlSfvvVYGN6i6nORCTZ0kt53rt+zSXS4q6lvm/L?=
 =?us-ascii?Q?wP66lnhjdlv7kQhgmyM3AntIVprxicxLwWPAve88rOrXUz36N13Rmynvpex3?=
 =?us-ascii?Q?tdlr+t2lIJ5boj2QmsiaKJfEarJJl/lPX1pWu47b19tcIXaVPU3b3GSIqnrE?=
 =?us-ascii?Q?YvXvXG0mYc8E7ChbRKlOMDYh/vT90xABNSX4YNsZp6XGOMAXB8MGbahoSDcm?=
 =?us-ascii?Q?/i2XvkOR+hVllKb/xDS2bHO+HSyjYyRixcFxS44sKjzw5XYpeMY2QnvTDv9c?=
 =?us-ascii?Q?0NWr+nJzOWbvLPNMnTIaRpRxaNz/s61mv2znVK2iU2uwSsxWkdfNeJ8U0cHY?=
 =?us-ascii?Q?yDxX84tWoaVTPV9BUwAlF7OFGvNLvVZt7wrgiNbm6GC+Ivjvy3N8lqKipvgz?=
 =?us-ascii?Q?xQHdCoXEJxyDnhaIUQE5edAkfMo59DPemoUv8pWGG2os0S6RRnK93Sr0xzc+?=
 =?us-ascii?Q?jdKkXNLLhDW6KPrN/bGiQJu5hqd63tysSJOQH1qWAjDPZt/QG7R1cdmz8XfO?=
 =?us-ascii?Q?UKcb5EZQ9hQS3bLix2fONRUE/onYeQR5k+NbI7Vh1CZfnfc6UcR5IiTaABHK?=
 =?us-ascii?Q?Qrw10HtqNKJDFHRrkh2S6QvtpAraF0rakVP+TZZfqiXULzYyN2baHXHHe4XM?=
 =?us-ascii?Q?2HIbWB3q6GzqLWFV1vcTGZZUvpdaaVOIVIDUPPqJ7Wm46UkWkZW2i4xsud3D?=
 =?us-ascii?Q?QraYzhqT6oNKt6Z0a51uDNmmS6IAwzIqMff9z1HAfCW2jeqsUNYUev8lVjE7?=
 =?us-ascii?Q?4W4WXooXKVyI/iODcJAbK+OEAfm76SnHrxrv/DUgD0jv9f6z88AXP6w51qbQ?=
 =?us-ascii?Q?f7xYb3woa2AVJk+iDpllzs/s6jPDK51G/SxLGufhvrEiyu164RiEgwd3g3ND?=
 =?us-ascii?Q?D0EIrBsJKo5h66WCU1O/k9AJzstxAalzyqHv9iI2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be240e3-63d7-41a4-5dc7-08dc85b33122
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:59:45.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrj+hPQf3Sepr4L+8ZkQ9jkZDzRl3X7sY7YAF2XSmbz2Dfh0EkI1etL4XpfUzsJ9zwvFOiDJWz4loFBob+r8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500


Dan Williams <dan.j.williams@intel.com> writes:

> [ add Alistair ]
>
> Peter Xu wrote:
>> Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
>> pages: they map PFNs directly, and they don't allocate page_ext at all even
>> if there's struct page around.  One may reference devm_memremap_pages().
>> 
>> When both ZONE_DEVICE and page-table-check enabled, then try to map some
>> dax memories, one can trigger kernel bug constantly now when the kernel was
>> trying to inject some pfn maps on the dax device:
>> 
>>  kernel BUG at mm/page_table_check.c:55!
>> 
>> While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for page
>> fault resolutions, skip all the checks if page_ext doesn't even exist in
>> pgtable checker, which applies to ZONE_DEVICE but maybe more.
>
> This looks correct to me, and needed in the near term. You can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> In the long term, the page_ext check may not be needed. I.e. the reason
> I added Alistair was in case his work to make DAX pages behave like
> typical pages for reference counting would also make them behave the
> same for the presence of page_ext.

It doesn't currently. However I did run into this bug while I was
developing those so please add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

