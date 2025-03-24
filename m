Return-Path: <linux-kernel+bounces-574019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D3A6DFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5B1889F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963E263C9E;
	Mon, 24 Mar 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HGW9+uiq"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F3263C77;
	Mon, 24 Mar 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833740; cv=fail; b=MQZLLb2KKCYYYBpScRYtYR/Z5dFJSIEtD72RQVkyuavCK4UgFnmPEDS4H4V6naJpCesonmeP7cn4e4gzpqebjVVqRZEEM9RuzZqQx1ClT612HUQhtZZa7eFFwJBmgc8GLR5ihWniNQiZh8NO0Vpgx2VoTMTsXIxILcaU5wCpz38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833740; c=relaxed/simple;
	bh=84tWVPIvHC1S7ccUgxHOd86ng3aQ8WenW+csBKi8R1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PHloesrOhRe4fT0AcczE8aLqzkWQH5PvOgqmL4wq9LYrkVMY++11BwSoshc2ZDHAFHuWW+NIjYps9ly4IfDqkFoleEJtf4F5FTeU09S/eM/GSEvCY/I6dG3IairhfvXwxVKnO15QGyCiqm3uxc2iFVmlIZc8f1XxaMIw/ZLQ0+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HGW9+uiq; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdI7/qiTaLFMnOO3TMzTbefSYbGVNHm+sKGjOFHO2/57EQLIMcpjg3itsO4zUvJby77V/DiG8i8pEMRVv8yEreqvJtofa1t3O929y209MHipFsFe6AeVw3bhP5rOlwYh7EZA/USPwa2q+JePz/XqT0axREKL2vd6s+/+y+gF+wS5iiB97kbOZ80cP/udEwSZ8H83Me6kfFvj90zes+z8NwwLIWJ7I9KjVBpz+pySAEMH5Aa56TztgmujcWHNAdAI7uQtoxkB9L/fJZ023WS31SxkaTluEm7ncujFs+N+1nMMR40n9fPXcIt/PWiiCR9KW4zVUx8BAJ01M5g7MDgrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV+C6tvjamxJ4X426YMRD+cxEIVDqEjZC8Ma+sfAYhs=;
 b=n4DAJhby6vc0veHAchOa4J7xrOWJSEWFYYZtGxaC1lHokPps9LiCm/qBvhyDdiwzdBLdQVj3UcxEYHyQb4SAm6PXVEhu/x4zreQDxYvKI/E60fBt617zlHMuF7b43TxVnmfyaTqxz4uiQ42OntAy6slTqHG1HwtdCwoiiTgdjAFHvBz5BECWZw9ejTGkp5XmzEUwQLJkDslLRTkyAUq+ehCvi8HRP3oHzu3g/7aoQJTXEyDhLKGhaPCrJLeM2juHNFUwmjELtC9hjWdstT3zzLDgGJPlaTYSL4Zb8ucos9pO7Nko5NfCkqw9i1OaoOyV7sbCHDo2klXjrTJ7E3+47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV+C6tvjamxJ4X426YMRD+cxEIVDqEjZC8Ma+sfAYhs=;
 b=HGW9+uiqrV43hm9lvK/nUbwXfGxb9mZptZWXgdn6lC1s5rWvv4imk9ZvVsVwk0/j5AqxF/rf0Kr0JTviZ0mWKtFzLWI90e6k0cCPmiws7hiNMJtA419+CcYEjTFrdILzxXDQQqOTqbBVm0zMM2rBbAa8nzE57d1g+Zpmn62tPym01e2E4iS4gj+sXnygJQsSTFEQec/jN2lVz8vSo3kL/vMmT+yiEKfIo6IRUdLhniEcLxZqjZH134HtSIKx+7KVizm2R2WwdA7cKLBisFd/zbnG8S5weZVmJnCEqt3XJDB4gIQJirBB5b8Mkm0OHO4pAO7628TKpQ56cZe8dIWmaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:28:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:28:55 +0000
Date: Mon, 24 Mar 2025 13:28:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Changyuan Lyu <changyuanl@google.com>
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z+GIRecXeYXiPrYv@nvidia.com>
References: <20250321133447.GA251739@nvidia.com>
 <20250323190204.742672-1-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323190204.742672-1-changyuanl@google.com>
X-ClientProxiedBy: BLAPR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:208:32e::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b857bba-35f1-4d41-db27-08dd6af0f878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDIISu9WESnPwal+3dOawugQn/zGlQ8j0p6CCa11N0j4atHbDWDP6O6qEo6w?=
 =?us-ascii?Q?gIxaGBoAfDp/pomoACAp8fZsUg7pt3hiLkapZvmNSKufraVqHHcgRyj42LIB?=
 =?us-ascii?Q?CSUq2kdX3fIwVF36V52WTC766okLBFQ0WiA+iwjDwQVeGV1E3WZBT9bxGV5R?=
 =?us-ascii?Q?1ncfUr58bZknj6j7N5HpiDZiWiUPHSmak8pBRBztaTyu+/DsAm4Iebm3b98v?=
 =?us-ascii?Q?kycWdc+8xMBWOfQbUPyJ1shebIlXhc1k14Hqx8tMsPhiD1uzx8TiYwY1oW2P?=
 =?us-ascii?Q?qvJhQw+G8tjw51zaAkfMWA/tiNyMUAgJAZGbqaCP/7vRU4mt37A9kEURWjfI?=
 =?us-ascii?Q?0FXZNVNH8ryNOQNy8lDqac+vj39t4gYnJmOHqN5P4nF0oMLDYH1ZeCQ7AAJc?=
 =?us-ascii?Q?BlMdARkAc809CTMUrBohGr42ZcqHhlQC5tBRFmNsxqC9HrQ5sOvtreRA1uOR?=
 =?us-ascii?Q?5q6yCYdiTq2GuHQk/CV9fEBvpWkfHPEDKz2KqRcjaQwcuxdhMGgWWgc+aiRG?=
 =?us-ascii?Q?Y/08/nMbaLlhqvwJXmgurP6LSWpC0vkh2tFbLdQneKI78VO7+xUD8+oonhZA?=
 =?us-ascii?Q?/B8CRmqKqwsH+o/vlwhrSMUvRP3G8ECOZmlt/ET/Ogobvu+HNvpEjfbzCpMd?=
 =?us-ascii?Q?5YX13PxteCjuRyyae49XDwKqsxBtx1v0Ps9NZGW5aYbk1B2uzUqqcOe/dahw?=
 =?us-ascii?Q?+hK9kC4Sj8vczoVBEOPFsc9AtGImnrgxmINg0sr8CDltqCs+cMP/CHFTeIkN?=
 =?us-ascii?Q?fvHRAaqK9NaBauucVOnlbREOjM1tHA2C0y6rXIul3qm/9ZuLoBR+UM6ay50r?=
 =?us-ascii?Q?LyeSWd/dpu4XVdUpk66+bcxqp+yZxbZNqKLOZUa70iAnH01KyXh7VTixFoC2?=
 =?us-ascii?Q?W5Xlnd0QbzauAQgn0V4onhYos4zc/anOvVSs7Z6DQyTo2MECPnRKn8cV2Fkn?=
 =?us-ascii?Q?8uY6ldq+vuNyt3AyThiWcGHcwzauNTVIZKWe4YqxaUDDMnqJXsoaMkPLytmQ?=
 =?us-ascii?Q?tEy7DAKxH/q4q834PfKvvqE3ZnagPL2Cy0xYUGFHkevo/MKOwEJC0NFfTwLn?=
 =?us-ascii?Q?G3J1tp/+Ij6VdUE3As8yirvJQ32zG8J7lat6PPojdHbLYGD9HtqOakW7NONi?=
 =?us-ascii?Q?EH2ucgD/BUgvg9PG1EpsJR9v0m/sTwrr6o+yLY4ZRFX9l6IE4agwb4MlLaft?=
 =?us-ascii?Q?VhBbJICJGJRbbiaCilShz3VukHygOa72McwrxqBY5fcyNTQC4owygh49Mgb/?=
 =?us-ascii?Q?Tnnn6n4wgRJwTCsoPZ2YY0puo3KpYAGS/a31yHteJ5R43StH7LvHjWAGFpXK?=
 =?us-ascii?Q?FUSEoBdqdERMJRT6nid5miqsHfILONLPBBvX8etYmloUQyho6IGHnVzoNvl8?=
 =?us-ascii?Q?TBN+gFth/Z5zg4WdJhySb40X7LfS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1g/CRns82T0FDE3aKveVW9dWwF8XHdL4g2gxqD0+mQfI2/+vOFUHSAG6c2LN?=
 =?us-ascii?Q?D3HA8vKKW53I51IZbZ9FN5NVl49A/L3ahYJUG1mWQqs4/HP7diFnekYHJMKB?=
 =?us-ascii?Q?zm6wJKA9irapwhSkD3Vm72bWgruoxr/fsGwi0SwQWGoAbi6hDy2bwyYty4se?=
 =?us-ascii?Q?73lXqgvtzHhKiegdwz9NZjPKtKDjNa6o0rAdRxnMx6MK5OlFylSRBJAidbCF?=
 =?us-ascii?Q?TKKha+HNhW0vi4Phqe96YCmaTZQyubGpl6flquJNvJhrLsC3nDT/IOeyD/q4?=
 =?us-ascii?Q?27LQ4weE3JnToJ/0WJULXIlaa4F7gIoqFAKBrZup72og3yFkmNO7Uyv32R72?=
 =?us-ascii?Q?fqrQRFd0F56DW0W0zJ91rxUUtDAksuzQkgiSmNevYOh6Gqi9a+FfHijqs+1B?=
 =?us-ascii?Q?eQu30AKqFIH31R66WnFBwKwQkTHiz/Y5JbGh4u6wG9xCgkg/Xf4mX1gqzhuC?=
 =?us-ascii?Q?5y6NUep8JGHmfts3X8305h8ETTE11iwMPHjdHRpMXIU6BJyOau3OuIsXoB4v?=
 =?us-ascii?Q?wdBxXbbYPzIadECP6TfkSqAUvMb1IbMtGE8bdNmOqTzU9lnN8kC6CEMur0Cb?=
 =?us-ascii?Q?QcuXcMYo/eYIptSvjPG9d7x8PS6Bicj4PSkMJJt2gqQMRnVvZYkWDQjQZcVk?=
 =?us-ascii?Q?VczcxqJFmdWDANzZhwaKyI+RXX4wkk1hUW6XMSWGOEkTGR5ItTZ4szafVIRj?=
 =?us-ascii?Q?EwAYeaLQciscRVSdRxk70Qjdp+SAN++0Nj2xImScdNKsTFgFYN+QtVJFW8Fs?=
 =?us-ascii?Q?pEIt30u2Um/AIm98R1UmZIIM6Qs1e+j3buLM4/FqF3wn+jrf21P31a0hz+Ml?=
 =?us-ascii?Q?uKhsxeFKT1AwPbyhM9PuIq0mypJA9X7qFGbZeVFd/WYrIGQgm0a42WGxmFpX?=
 =?us-ascii?Q?nY1rhH1zqNRSBUhjhRgF4MAkBP+f0MBOInaeylTOd5csSM8haYey9L4BebDD?=
 =?us-ascii?Q?TwX2hiHKrzt8sCLCT79+f9Z+h5oXdqfWlZffx3vAzTRna/Q81m9cvhOL8VbV?=
 =?us-ascii?Q?NdAv5VFVNBQqQNDAEkybJ9MYryA9eT9HJfLADlfs40pqENpy805dLcunNKd2?=
 =?us-ascii?Q?c9w/hfsZeBfaWLEE0fTiT7cOeZ4Qb7qt7F7wqW9b4F4df3TAAJY+Zzg5Z4Ym?=
 =?us-ascii?Q?8sqvEtdjeI/SKi4IXQ/Br6U8eNKqV4TbzGpfB++JYVsZrO5hcjQKFyPw8v/t?=
 =?us-ascii?Q?SkXKdch50Iw+ZABLMSbaDe7oSaXyyUFl+wYX1mKZsm9+oujo97dsgHSU0bck?=
 =?us-ascii?Q?kpg4KhVyFGSKDQoPpNr0IuJvStXW/yhirmjvlP/kaU8dT0iFWe/vPSB8eyfF?=
 =?us-ascii?Q?5gTwcQOtx6lz/F3vHp1W+yUA20K5quEY6l1+9LN4RG+Y/q9IFczRr2cnOOjt?=
 =?us-ascii?Q?u2+WSt/RWVunaZDihK/rZrVjquCobktdDV9MTk8nyy98XK9YEhH4XLEW9hp6?=
 =?us-ascii?Q?XKy6M+VqDVx7KYCy6d5MWJACVxl7QGnQBRxUQOjxRl9qsDMV7deMG/X8Sqbk?=
 =?us-ascii?Q?96GdHhWrABpoQjpKzoc3iuyJJoBjhHo1Q5bLSjn2r56n8JIONWbai6lUOo2G?=
 =?us-ascii?Q?FFyAiO4O1VFiWXUl11YiB0zLBh2bhwZhaafMkoW9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b857bba-35f1-4d41-db27-08dd6af0f878
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:28:55.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRalG4PrOXvXN4bTs8rhEOfkq0SYZ4A5RVSm8y+0IAehN6bAYe8ge1J4gPNBiuD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

On Sun, Mar 23, 2025 at 12:02:04PM -0700, Changyuan Lyu wrote:

> > Why are we changing this? I much prefered the idea of having recursive
> > FDTs than this notion copying eveything into tables then out into FDT?
> > Now that we have the preserved pages mechanism there is a pretty
> > direct path to doing recursive FDT.
> 
> We are not copying data into the hashtables, instead the hashtables only
> record the address and size of the data to be serialized into FDT.
> The idea is similar to recording preserved folios in xarray
> and then serialize it to linked pages.

I understand that, I mean you are copying the keys/tree/etc. It
doesn't seem like a good idea idea to me.
 
> > I feel like this patch is premature, it should come later in the
> > project along with a stronger justification for this approach.
> >
> > IHMO keep things simple for this series, just the very basics.
> 
> The main purpose of using hashtables is to enable KHO users to save
> data to KHO at any time, not just at the time of activate/finalize KHO
> through sysfs/debugfs. For example, FDBox can save the data into KHO
> tree once a new fd is saved to KHO. Also, using hashtables allows KHO
> users to add data to KHO concurrently, while with notifiers, KHO users'
> callbacks are executed serially.

This is why I like the recursive FDT scheme. Each serialization
operation can open its own FDT write to it and the close it
sequenatially within its operation without any worries about
concurrency.

The top level just aggregates the FDT blobs (which are in preserved
memory)

To me all this complexity here with the hash table and the copying
makes no sense compared to that. It is all around slower.

> Regarding the suggestion of recursive FDT, I feel like it is already
> doable with this patchset, or even with Mike's V4 patch. 

Of course it is doable, here we are really talk about what is the
right, recommended way to use this system. recurisive FDT is a better
methodology than hash tables

> just allocates a buffer, serialize all its states to the buffer using
> libfdt (or even using other binary formats), save the address of the
> buffer to KHO's tree, and finally register the buffer's underlying
> pages/folios with kho_preserve_folio().

Yes, exactly! I think this is how we should operate this system as a
paradig, not a giant FDT, hash table and so on...

> I changed the semantics of the notifiers. In Mike's V4, the KHO notifier
> is to pass the fdt pointer to KHO users to push data into the blob. In
> this patchset, it notifies KHO users about the last chance for saving
> data to KHO.

I think Mike's semantic makes more sense.. At least I'd want to see an
actual example of someting that wants to do a list minute adjustment
before adding the code.

> However, some KHO users may still want to add data just before kexec,
> so I kept the notifiers and allow KHO users to get notified when the
> state tree hashtables are about to be frozen and converted to FDT.

Let's try not adding API surface that has no present user as much as
possible please. You can shove this into speculative patches that
someone can pick up if they need this semantic
 
> To completely remove fdt_max, I am considering the idea in [1]. At the
> time of kexec_file_load(), we pass the address of an anchor page to
> the new kernel, and the anchor page will later be fulfilled with the
> physical addresses of the pages containing the FDT blob. Multiple
> anchor pages can be linked together. The FDT blob pages can be physically
> noncontiguous.

Yes, this is basically what I suggested too. I think this is much
prefered and doesn't require the wakky uapi.

Except I suggested you just really need a single u64 to point to a
preserved page holding the top level FDT.

With recursive FDT I think we can say that no FDT fragement should
exceed PAGE_SIZE, and things become much simpler, IMHO.

Jason

