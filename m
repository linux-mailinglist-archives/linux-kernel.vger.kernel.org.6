Return-Path: <linux-kernel+bounces-286412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7DF951A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EDB242CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E211AED44;
	Wed, 14 Aug 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/2vDd8k"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9213C906
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637644; cv=fail; b=PqGxe/Ylsdw8rn3qB9O6hNyY6L47yp1UmnwBd4pF9gEHZLZyX7YJ+Zxdl3RFJ7CZVRwowhLMe0g+dnzMk/LTl0YofM1t1KuCwc55q7pGq9/pZbBuj4c1jeNUlK4tWpRkacfADMFhbAfxTSd5AmcNzkHZv6Y1h6aVn8CNK3BUs6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637644; c=relaxed/simple;
	bh=Cbvgma3DdW80fyC1WUpHA3JKMPw1hs2T1V9YtVr3Y5o=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=UYIGEMNK+T4Z7sRN+YJDrkJEuNMjEPo15/Q3NsTds7gPv4+PQzvENu90nzD57vBB2O4PmdHNosMm6LC6yCuRBtUZDgAP4cRCIRFo8HWthwHroOd3iT1nIYAwBhz5VB52pJbqqUBMWe+OBUt1yHDS0J4O0njULSapLQ4hmIxkV64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/2vDd8k; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh2AIGqKTUYipAElOgY3QXGaX/xUqOvh0GCopqWXVIm+43KfgwqoDxDELS+XxOuRzp7C0bUu4FTQMDqQQoKzrql10dKPE4m2lrKe2S6F7tWylsxrqKHMfO8dpgHz8NYfCQPxI0zFYMhfdshdSXbJXGLdQd+NCcSIdeR+3rpSLCpG96rdnthylywWjh8VqJ3QbtBit3QOqutSVEKx5+WYZ/zIDhI3MsoR2UpkFRKlmgGyeZWxt8qfKA9C/5/GwoKHh9u2TVWxeH/qMrwDAu1MGsQcqNdCovoA0hf4rzcVYA7LuCdbKKGbBeWSKD8mVAZqN9pjJOeHEBd39vKtowzv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yyV/RjQKrql0F64JheGu4HNkyfA7qJYlPY5N0Nki2s=;
 b=I7cFNdr2GjwiOgSsOmncgklhPFjtuyqwUMzUILXcpxtE9+RjZT99kTXq0p7OsfvgAEJysC6b8Scne7MWemx8I7hO4xO2J7/oM1Ab9HMBgun0bpW8Xr/IclsVT8QIIQxzrgB8k17JyBVRhoZ+kiJ+tW24wtJQ/UsHJQL9xJsZTpNhTsDw32zI8iLRICuGPI770pSdUyPqiLZ2a4Vlx5f7pRWkJeEjhXwqPEH5w2UxXRsCDL4oJXzLIAibGXPOK377wwQGMUA6KyFgPZ3E7OxMiY2zgQuEjgcLjQmzZbWQtAQGDdgRsPSz9Nldnq1HH7qNMyCYKRAcOQpX+IFlhVYHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yyV/RjQKrql0F64JheGu4HNkyfA7qJYlPY5N0Nki2s=;
 b=h/2vDd8kxg2gTLBM/vHimDNixte7186FnH8brOOC/XUHa+zc6jUfaQX1mTd1F9+jljEFWdcPVPXfoqjF6sTJTlMjYVeoHePag2TFUGvgIyvE/dZMwNQEAtK3Ug+gHyO775FMDksDEBNWHp5Wgkp+veEMlRcTiIXKi5uZni2QwQIhAb2juyin+gEkDUkE37r6My7oxa+8r7d7cucnjNFPeDkhLA+yYXqW1FmXwcD88Mk2Hv3g/YrdtLEAZ93U3q3ze1QH8FBueGAVAZa49kJSWta0p0xnmz7XOHd6714OK5mBoebZlmllSOjUeOxHGbiP5cvNblADybNFt78rfjVlTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 12:13:59 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:13:59 +0000
References: <20240812203538.82548-1-max8rr8@gmail.com>
 <Zrwyh9bKGVzkLzeA@infradead.org> <878qwzpfbi.ffs@tglx>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>, Max Ramanouski
 <max8rr8@gmail.com>, x86@kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 jniethe@nvidia.com, jhubbard@nvidia.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
Date: Wed, 14 Aug 2024 22:08:23 +1000
In-reply-to: <878qwzpfbi.ffs@tglx>
Message-ID: <87le0zmhdp.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0128.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::8) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: e61ffa7f-e524-49e1-f35b-08dcbc5a938f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bLkqRJNCKW8Fd5WLobfUjwPMr2X4IaIdTQZe9fRWnsKaa2OXiLldvCyKlfkg?=
 =?us-ascii?Q?58/FN2AoX4Vp+tH0R97uSn3JpUPdMpwLVp68m51aMBUE+m81YI/UJRzQo0x6?=
 =?us-ascii?Q?C6ak8sS3jC/qFWm2rP8GntL3OonETlDlXI5nIZDnkvlINsexlMJ898mWOime?=
 =?us-ascii?Q?UN7zfLrKO4wgsKXSPX8t/jbL01+2Q1U75WVwcw0ITxeUnTQXn9tqg7t89EuI?=
 =?us-ascii?Q?VKIPaul1P3EV0AU6zKyEF/GZqNM9m2Mxbv7pxsHol7Si94+zm/ZmFYL6pqYA?=
 =?us-ascii?Q?iJw3CpE4Eo+ysp23THgxI3MFPJ7+knxoxkfer/RYzfWph6i4tYI6hnNMfgvv?=
 =?us-ascii?Q?sw+zyevMnUr2d3qxgAD0hbcqx9GbgXFf7oIWajqUT8lA6xDTX0BvzWbgGhpr?=
 =?us-ascii?Q?bFwsLSmmXJy/5jpFCR7kr88XC3qHdgerNBY+cMhPbrJzvE6ZtSAEeXqfaMf8?=
 =?us-ascii?Q?4xgQzCG0lifONT1ic4zYRg+BqQTIC7M3uxOzTaW0DJ0EanSBjRqcOm7j1l5P?=
 =?us-ascii?Q?lVHIZaoXNAxl2UscUlqVT5XRIjR5Huqj7lB86rjrQgTCkHH5TtskuSOscwvt?=
 =?us-ascii?Q?5hUBH8/rEMGLzCyYXT9hZdq7wsdf/2x7aEQJqohTipZHXr8fJ1CYv6FirhWf?=
 =?us-ascii?Q?LP9sqhKDHySnEX+ELwRNvApbAFpWRvpXQLp3nvPZdg9YJ0//+LAXnl0pf98/?=
 =?us-ascii?Q?mZq7DzrYyKB+mhidYKhqBYbPBWXsUi+dwruYbswW+jr57e7vRv2ZWLhTrqn7?=
 =?us-ascii?Q?ZPeceg0fT9WIKyWFCtb5NFw9Vp016vK5uClRRRMQPQNS2tzpuDlMU7mvlSj9?=
 =?us-ascii?Q?PMOb6JPxlmgJWq5EvntYIL3N4zeJfhppXwDZXMn7U4oj4I6f2CJP6AuPf5ux?=
 =?us-ascii?Q?o7N4nKq7DRSDkhlEZX+yUeoTvbcdnUfE9RXG8LZn0I+51KHt6yQC3vUmlzao?=
 =?us-ascii?Q?GR79Rlgy2N/gWGLxv04q9IeyB7jjmCIs8g5BQBpuEE7AzjcYTpSp4m09s/Hg?=
 =?us-ascii?Q?gPIp27gjxONbxQn97d6uoJCZNJoPGdXcJQ5eIqoA3u7U56d+jaWCmD23Jxdg?=
 =?us-ascii?Q?F58UbZfhMGt9QiCuzVH4e+hXbOhSiNR+NK2ZvpHFZitRMmMXBljGNR4ZLmSu?=
 =?us-ascii?Q?iP0FqVkFNJIyTmu4fKvoBhehSL/pH+BQscqeck1s6XGE0MsDqun9U+DmebNd?=
 =?us-ascii?Q?pqYRuavrsAhzuuTcE+ia4HcZgfhAjGmwHqyCKZ1E5Hy2NEIdHb6mA2Z5Nryu?=
 =?us-ascii?Q?2PSSlstlSDorZ1M/z8Lj27WTrBN6ierItLLpDIJoirBwBwvwF9+kCmV1ynKh?=
 =?us-ascii?Q?atT+z9wVzgOGT7bjOra+sVvc/rBB3w5XQgehZYeAd3MnWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OxdDU/VjmZxc5dUMEo6c/Xok4eOB6jU5G5SSnO8lJVFT4L8EoZrZqKSNIv+O?=
 =?us-ascii?Q?EygCxNfHQD0GJNTpshS1z/iZBQYTAQe/XANyP1oiF3xwO0qez3ZC6mP34zsy?=
 =?us-ascii?Q?jfKYzxEist1IZfeCkVdbnve6uv6TYKaMDBcw69E980E631OcseREaOQ/N8mC?=
 =?us-ascii?Q?m9Bs5MYrF2qkGcJJHwQYV/vHKIA3jG+v02gGrWDjHQiIT6Y8ccn7Qtg0RB/8?=
 =?us-ascii?Q?tY0QbiZAWzPDB4hxsLn1hw11fPcep7jD6jz13FRhwcbF55WPq8c5ppzQLpzm?=
 =?us-ascii?Q?I4bw2LBd8D9HFux/PAvyFPopdQ9cRoeqNHqzGjPKhO0MQMPjrmLnTyvEQOYF?=
 =?us-ascii?Q?Qbi6Z/5GHS5BHvYuyb75IhILSAhy5kiRNQyidHez2HGxb4T9jJyus75+32k3?=
 =?us-ascii?Q?4YxI3UYJ55+R5jZ2fsJHbjqJ4ibbj0eJBkMGA5hcEzDAomuesp2JpMIVW8Od?=
 =?us-ascii?Q?zJOM3ojBXllfk+QoMTWGqdhh7OeDAuYP7oSsUB8WfQdQzO4Lhxt1LRypdZj8?=
 =?us-ascii?Q?O0wG7h7xztdAbklt75yt8hRch6ViAoFjt3jxaCw7Qhk1ETCvkxbWJ6GuVpgT?=
 =?us-ascii?Q?tfUPSHp3K2BMLMEgOZPv/KJEozis0+Xy0d2d7Q1DGPQd25UyDYT6frBNDpbX?=
 =?us-ascii?Q?VTmFg2g381KBr4m0nAPSBSZ+34yY+moLUUZRMbXNMGsuuVVXubf/AEwdKtEt?=
 =?us-ascii?Q?jLLUwfQ1hFw5ByqDIx8b+fNBnIxWogojdkgRHNGyBWRalDzfVFvUVdGyq606?=
 =?us-ascii?Q?FsofbMyMVss6NgbRmBIcLkFtAkOw2ZA1S0OI86yVoMymp279YqbKpg/OwuQj?=
 =?us-ascii?Q?YgEzQR4BmVIYxwMxFOGLJhpMPGAt4y+wrycTiakCxE0EN14NoWCOKkGn/X9x?=
 =?us-ascii?Q?i1mukKSyn1J17Q4ZNsVfDYvT4cKONTmGYacLR8qCcTGKxhd5Vbe1UYDlJd2S?=
 =?us-ascii?Q?OXIzgsp2fYs0RnEZo+t09FBQu9+7shDhpyYc9z3IrlO8wuEGT4PLgdTh1rzh?=
 =?us-ascii?Q?zHrIWQxECwFZkH/6ws0OD9kqjn6nfsuUsj4iE8WgXvBSsyPBJwUgMroTP60Q?=
 =?us-ascii?Q?2VLYKsb6LkCXQ7SNe6Q43mt8dADk5/zv674vKMGg7G6tG1PPABsZNiWAj/JA?=
 =?us-ascii?Q?/GHP9CxvgYmcnA3BN58Zph8OuQi/ein5X+HsOFYNorrr+L9Z2t9gKfr/UnE6?=
 =?us-ascii?Q?hriD6pqwbLLNOnVXClZQnDOc1bwI6tY2vl3alC3wvqqANlCxCmnMDA0X7Itj?=
 =?us-ascii?Q?QYvlisiBOMBmxyS4Cjzi49MQFTABbHtb6U1Kp52dBg56USJn/5CssdSkI77z?=
 =?us-ascii?Q?tn5QXqF904loFFllmpI1sEUe4odmb0NYrXtE9p06PYHS9z1w/cuCgyUYO99r?=
 =?us-ascii?Q?bxxTHH9qMcf3U1NcEfL1IpKlEARSpEkChGnYM48ZZU3GbhF8nWkhO9LBSNQu?=
 =?us-ascii?Q?uLL6FtAknlzpQaoXBPKvM6A52JTw+DAvDopgXUIOE3M4Dp37QlVOpEynAMth?=
 =?us-ascii?Q?56yOtPL/p/UwV0ViYmnJdL8qC4DBMPH/kkSsHQM35JqYojbZRO1/6gyA/bMI?=
 =?us-ascii?Q?TWGgr/F7WdlVla+5ps1VMah51BsGirzni2pIZXvS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61ffa7f-e524-49e1-f35b-08dcbc5a938f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:13:59.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu2ZKqAP1v1dLkpoNACBJBSh7W9O4HF/ir5nAOO8iv/PKURt4IrG/YZBX+JtGEuWzQn5s3cmDu6H+CCiC9WHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Aug 13 2024 at 21:28, Christoph Hellwig wrote:
>> Modulo the fixes discussion (and any commit log adjustments related to
>> that), is_ioremap_addr is the right interface to check for an
>> ioremap address.  So for the actual code change:
>
> I'm not opposed to use is_ioremap_addr() as it restricts the check to
> the actual ioremp region.
>
> That said, I'm wondering why iounmap() silently bails out when invoked
> with an address which is outside of the ioremap region. I'd say, any
> invocation with an address outside of it, is broken, but I might be
> missing something as always.

I would tend to agree and had the same thought when we found this. At
least some kind of message (WARN_ON, WARN_ON_ONCE, printk, etc) would
have made the issue we were debugging much more obvious. FWIW I have
tested running with a WARN_ON() there and it never fired except in the
bug scenario.

 - Alistair

> Thanks,
>
>         tglx


