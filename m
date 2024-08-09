Return-Path: <linux-kernel+bounces-280316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B039E94C89C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E551F240DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20816179BF;
	Fri,  9 Aug 2024 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IRh3ZeC7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CD12B73
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723171000; cv=fail; b=mFOmgjXZhj9BT8fIIDLOR4pLrBJJBwSPQjEpNaWKEehH12UOimtZzWwweO024rVsGpay1iA/dhANtIeknTNcg1ev0eGMdqV5jNPwcU+2c7a6VjwZlItS4PGPi/uOfC6p3fVZgawOZZuhOnCVkgQU6XPv2Uy4xVjLek5CxJBy6Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723171000; c=relaxed/simple;
	bh=TCuRphNPINIZaDRbJTNrSpoxz3HVLLujTcrh72a4g4g=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=AY+HWruuHu1XUHZc78nf8keyaL4zYxdrXZJsRrqcfJZDWYO7Z8OODWWyqf6yjaNfRrP8yTfSHW+jO81wz5U2PDgopIuGCJV6rQDOHgbkzKPg3JT0JU7sYF65paytIV4F+e2QzJEfm89vscSUyw5CLFKButFiLYavgYl9Xn1Hiok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IRh3ZeC7; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBg26FT/3mgIus9tTM/5PJvdXFBgi3fzWESdjq9EAoGxgoaMrrs910cUSv+umx6ckLm3gUVR7sl25z0flhjd2jmzih7x49EBCMIIcny5/x0B49+UZ9NlFOiV5TDWKZQqJZfhxNUiv4DlSghIk27l2Z0zmlWdAeNEyJCHi3AySMU/i51bCFRdLD6HF8HYnyBM2LGgnZP/jH1TsVnxxFq/Ev9j8QyAaM7oQ2Tow1re47V9RIpKFqbkdgOIH8FYC9YnSQBfR7kQRYUH67pnDDkl6uOr6MipfnXSaPfCCWeHo/msVnBZtP/6t11wL0xOH/DCnDCV2EoidbYye9oe4GSMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbCsJuSe1i7q+UOjhHvqbbJMjzjlv5EV1eLcs/xb6Vg=;
 b=HuTw58DIZFD62m+MTltmiknA9QnRjXdWO8wf2vLTQQpDMi3nTW5F8df9yYbpnGXM99Xtsi5dz8zMx3BiEw3b7FDcUkqn7kviG3wBJ375lbrj9OsFabZ+q5Ri7PZA1G2DPNZOGhAsXCDqCA0I6Zfjj/iIck0bZSvijB1YhHFU36AsJjcFmV1toKD9EtiYUphTAxggmfK5vhaaSgMabInRL2G1Fu5rqhl/AUuMhrHj0uWPa70Ine0MtIFF54nFJXhH+4163/pCsOR6Vh/DYqfRSOYuMo4zUsDXdzd2vPLy8LJwmMXi+Ce1+a3wC6U74AVypTAsVhavk5yqQhI66QHzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbCsJuSe1i7q+UOjhHvqbbJMjzjlv5EV1eLcs/xb6Vg=;
 b=IRh3ZeC7bMK7rTSIXsZ74qWMN5EhmSVcbQPqpyDx871PB13oZLrCSrJNYqbML58WOpYNbTf/A3B+zMMo6VfaLIPTAF8t4+omjuoBb/9CcVvrEmk5ebUbaNez/lmKdXAOWv8ZjRjX17SxVy81sbfxtC3e+/+geRZcbFCHQzUuPh4lt3rkkwvmXC4LEH09ONYL3G34+6jW4bmtveBRKO8O4PgnvBbzFUevBo7V7hotyZioVpe7c79anNvQEJBLgCZ72X9JwPkh5/KBrhcowshM8dKWwGqjSLCB7zOUD7kdDpPHGO462/BfOBkAJx6aE/fZaBksS0nCbD54X0+5gyz6RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.14; Fri, 9 Aug 2024 02:36:35 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 02:36:35 +0000
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Date: Fri, 09 Aug 2024 12:28:17 +1000
In-reply-to: <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87seve4e37.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 58abaf12-e7ba-4a05-6bb8-08dcb81c161c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWqT55B0CnFRCCa5VJgwaM0dRo15qm7vUYwZYancI4qrGrEdRjQhiSYxLmqo?=
 =?us-ascii?Q?5YWcwqLvSYeiePAmA7rK454tjMiHQGrALukKkgDXrzkgZ24go7p92IqHu7BQ?=
 =?us-ascii?Q?ggaQ+mp1PsQ8rkFJd3zgzBu6vOYr9VTDOi0c5Jq3UUXaa2kU703CCXHLKNxl?=
 =?us-ascii?Q?drpYt2SAIJGEx+swBk3lNrD+L5OOxF/oXdcYuzhU1ggIZ+nyuk4aATh4NvFP?=
 =?us-ascii?Q?G4g9kVk2vsASYJx6e86EyUJTPxboU6NwkC1ALtvTsadvEv7HtgzETH/4ovdF?=
 =?us-ascii?Q?SuoU69mYfgbT7wwfHPdEZ7O3QwysCNCxZzdZgAfeXIlAd54XqYi59/DrKQ97?=
 =?us-ascii?Q?OuURkbVZ6cjQ/6BWGaR0mXrruEHmIXTUhz7SGZZsGA8wXBAZSmMMLMVd8/R9?=
 =?us-ascii?Q?Odj6x0MkMTB1cPlloestxN+nBUof8elSSXC0+H22/Q1k+Vqmk5/15ykMO914?=
 =?us-ascii?Q?C/53bWsGSJk24lM7VjRwkLsKgszxQOQQdnl7AIr9hJMcamPgtanxUrvVcEsV?=
 =?us-ascii?Q?EJTjbDGXG8zlo/Gm5t1Kh6XjT19k1NF1EefEa/G/L6s6VJ+ilBHZVY7P9vGI?=
 =?us-ascii?Q?T6mcgNynn/joKEoSEGeY1TVV6hWLFi3WdHwR25CRCu1VXOc71p2KcFqr57Tu?=
 =?us-ascii?Q?ix2Fy613Z1V3Eyqrm60YVCYKB/vh80yd8o2wOxFRKcSem9XAHsv1iGyb2KEQ?=
 =?us-ascii?Q?3UTFdrpezn2SYHckcz2MIzsWr79hCrllZgjAF3DUBssXVdpB82DyOuIzgDtb?=
 =?us-ascii?Q?Fcs1M9AfGHt9NpE+1NxH4cAgJCEJ0f78i3HTz949eO23BawN3eRF+2FQZYgo?=
 =?us-ascii?Q?JkcifkIOqvsZAL7nkjZrSifOP7KwsQFC5xonk46ojxH9WJtYzrCj6wwEhHw4?=
 =?us-ascii?Q?22Luowu1FwW4YECiDzc5Gb+5dwhg9NvPClEqQG3aYCjWpTH4yl+lWkjJqk8X?=
 =?us-ascii?Q?LC1cPLpj9Gami/9xLTNzfh/K1M1hONEVUEKcG8A8yz3IA0DVOVo1BmyGvsk6?=
 =?us-ascii?Q?ihf3y49Q3OJMp/4fGVuqjzakDqBlijuhc352XfV9EoFSpO2jKwg5BPqFhNCp?=
 =?us-ascii?Q?hM/cBl/0a0zG6pBpG3/K0lqNtlwLP1XikmiqAOndO9tzJCQrxA2pNSi3Htu1?=
 =?us-ascii?Q?V/5TMQ+Ba+mDJZ96QFqdtnta6PBMCvao8Mpbg5EQBavDjWIOqbr7j7H51iPi?=
 =?us-ascii?Q?Ex+N8r3mI8bhORdOaDFB3uH6FTgQEvNahadXqL9CcNC9xVdMe2tR6XrUXkJ5?=
 =?us-ascii?Q?8I5pzyA94/zKY6GD3fs5Lsr8obXPRf6Edvuhy01soCOIPvglo6f1rsnQ3H07?=
 =?us-ascii?Q?DgFoQegafb3PgrNku1ObOpnNvZ3tIsXbGeDQTWbP9fWkDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/174UmOESKaMGJuPovDC6taUFbH+zg0PCDqGnvzyrp2NOyn+DnqbceA1YZsW?=
 =?us-ascii?Q?8KhZuZyyEAnA4wOzUyt5r/XiXRYraVo4kXjmtFcU7ixOQYJPtRSvBPhpHHy4?=
 =?us-ascii?Q?oakX5zKiHGr+HBdjGSo4uZ+qYAGaJaVRTB36MFpKomTUzjqWH8AXqL7HCY67?=
 =?us-ascii?Q?zkO6Ww3/GGCuml8pl2yQ1oewWCJ+En1R7FsXIn9Vxe9Nc0uf+oK/Ym0EUw1v?=
 =?us-ascii?Q?PE5TK3ZqEIhyCADHLIaPEg7aG1H6tDvcz/rd0wJwhOx1bK0ZZ8KuaS0/P6sS?=
 =?us-ascii?Q?K8OlYqEbEIhpmngVqdGQmU27Rkb9i5cubXLpa06ZcHJX/lYdQktwJJfU5t9s?=
 =?us-ascii?Q?n0lzzEuxv6kGyVTinCfrYKkbvNVflPZAKnV9SO+rIuySIdazmalNh5xxZv7S?=
 =?us-ascii?Q?ehxX95JCnNAnSnSWe1OzP0rfF9wMFMCyPZnpEjFQTXS8QvkS0lUSonJ44ikA?=
 =?us-ascii?Q?bAu90X+q0koBTGk6tqS3TTntI1KJkuFZuFctl6MLMpnwNTs62dVl60wwTpQ7?=
 =?us-ascii?Q?wYSzlDmE2X1ldeUrCkymcGsgCosiGciGuDy7eEIfRk8JSpDl/GGnZ6SowU1U?=
 =?us-ascii?Q?mppDtxePFenH5R65m7TpxmnAVoOXbsMiqRm9tQSX7eQ7s7vOfMC0W4+LoXk3?=
 =?us-ascii?Q?T7hhqOLHd2eahg5xEFtpedXWmjJ5DSRGduUffob1ErrUEi55m+rTaAJbUsdj?=
 =?us-ascii?Q?l/MQZmIMKzHuxmiGKPPiSrQP8vr6pkN4rDXZHdVxWdKJeDLlh1tjM7T13yQ4?=
 =?us-ascii?Q?1KPg7c/ck/QovFL7SojivEl6gQt5zEDOrhi2mMDGXAEWHk7nXR9HJoCEG1po?=
 =?us-ascii?Q?eZ5fEaxnNJF5UmNEGJRCOxwPBdiQUg0V52NhhG9ke8EEQS9hpYQvmlqAd8p7?=
 =?us-ascii?Q?10QM+aJ9PGfdP+YM3PLeQhTC1TX8Y8Fk4CjuGBch72ujUx9xgvXCDrAiHlYg?=
 =?us-ascii?Q?kcXP0ICirjBDpfIe0PFlm9t1G1ZyK0CXqVvTWXBLm4wij3d3Wc+wHNjwk08o?=
 =?us-ascii?Q?eZ1zHdPq7gye5P8ioeDnq7ly+Kn/M7sO2kY0OdsKIUu/uEigV//inV2t9oEb?=
 =?us-ascii?Q?CN6loso4K4Au7vFqHFgWwBTOt2YtwCYI7R0SpI+JPFs2r4815/VCFCX6+r/7?=
 =?us-ascii?Q?hWby/LpeqjSaYwMDIkF9ZKBhPfC1VeEO7CdJ1VvpW7zDpq7X0Hip7R1iTP0C?=
 =?us-ascii?Q?B0P6lWhalRPtMtviKMsBl8j37hcnwAryYXMo3Kx0NLcH8AnavCfd6bU9/JwD?=
 =?us-ascii?Q?Nkbz69oBMDVYe4IyUyOfTGSxVjvVD15mm1AaL1Y0O1PNNP2u5FGgJy2J1f34?=
 =?us-ascii?Q?+52bg89bZLYU/sQDCN+Cqm71mbko+2ThvF4q+FuTR18TN3gPR3nap7Nww4vj?=
 =?us-ascii?Q?lKXrOu2uR6W9wl0m4+TzKDyD+y7Iz1AxOW9ICx7ls/WLCaCqtqn8B3IUj3Hg?=
 =?us-ascii?Q?jkZMRuRuG8pW5ppeUZy0EoBH6i7hVB9IzDQ6OnCrKwoVBXBG+byfkEx0rW6E?=
 =?us-ascii?Q?ksDRA/vRRHxdr1+suj4ZQdWXvJzngFrlrYzRA6bNXav3Ry77hdC8QRZBcU+Z?=
 =?us-ascii?Q?2pvnSVxIfBZsu2tSwdcluyhKNtidFHfl+WbfSlUH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58abaf12-e7ba-4a05-6bb8-08dcb81c161c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 02:36:35.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI67j0PY1KXmRVe0HPCCbwTMQh0ZyIS7wWDRe3UIAANbWB1i222qEGmS9PBk8bEfTRxetRgkdW99Mi+aDax5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096


Dan Williams <dan.j.williams@intel.com> writes:

> [ add Alistair and John ]
>
> Thomas Gleixner wrote:
>> On Thu, Aug 08 2024 at 09:39, Dan Williams wrote:
>> > Dan Williams wrote:
>> >> Apologies was trying to quickly reverse engineer how private memory
>> >> might be different than typical memremap_pages(), but it is indeed the
>> >> same in this aspect.
>> >> 
>> >> So the real difference is that the private memory case tries to
>> >> allocate physical memory by searching for holes in the iomem_resource
>> >> starting from U64_MAX. That might explain why only the private memory
>> >> case is violating assumptions with respect to high_memory spilling into
>> >> vmalloc space.
>> >
>> > Not U64_MAX, but it starts searching for free physical address space
>> > starting at MAX_PHYSMEM_BITS, see gfr_start().
>> 
>> Wait. MAX_PHYSMEM_BITS is either 46 (4-level) or 52 (5-level), which is
>> fully covered by the identity map space.
>> 
>> So even if the search starts from top of that space, how do we end up
>> with high_memory > VMALLOC_START?
>> 
>> That does not make any sense at all
>
> Max, or Alistair can you provide more details of how private memory spills over
> into the VMALLOC space on these platforms?

Well I was hoping pleading ignorance on x86 memory maps would get me out
of having to look too deeply :-) But alas...

It appears the problem originates in KASLR which can cause the VMALLOC
region to overlap with the top of the linear map.

> I too would have thought that MAX_PHYSMEM_BITS protects against this?

Me too, until about an hour ago. As noted above
request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
down. Therefore VMALLOC_START needs to be greater than PAGE_OFFSET + (1
<< MAX_PHYSMEM_BITS) - 1.  However the default configuration for KASLR
as set by RANDOMIZE_MEMORY_PHYSICAL_PADDING is to only provide 10TB
above what max_pfn is set to at boot time (and even then only if
CONFIG_MEMORY_HOTPLUG is enabled).

Obviously ZONE_DEVICE memory ends up being way above that and crosses
into the VMALLOC region. So I think the actual fix is something like:

---

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14..c58d7b0f5bca 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2277,6 +2277,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
        depends on RANDOMIZE_MEMORY
        default "0xa" if MEMORY_HOTPLUG
        default "0x0"
+       range 0x40 0x40 if GET_FREE_REGION
        range 0x1 0x40 if MEMORY_HOTPLUG
        range 0x0 0x40
        help

