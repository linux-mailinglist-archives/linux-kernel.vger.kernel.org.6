Return-Path: <linux-kernel+bounces-510137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0457A318A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EF97A1641
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5F268FDB;
	Tue, 11 Feb 2025 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JX0mUym0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E0267715
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313233; cv=fail; b=oIEZeyVvDnjh7mIh8Bgbvpy3Y4qdkLHldnj8gENNcLscKd/y1W/q5qNhfXTxbxVbEEl0AVDrp1j2bI/92jtWp1alu+gEHhs5H440dM0shN5Cn4H8UAWpRdaN2T2r4Vx083v5yTHpwSbIbIBz7yQAwHA2DK0lPsDPTYYnb/o/bNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313233; c=relaxed/simple;
	bh=i8vPmz1dssiUEu9sm6e4DQgVmpLYrwDEWjjQmwpaPfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tSJOYUV+TR8FNJ8/ZqT9GYg9Fg2x76G44Vd26QQdptGfNjhhZSgPrjTAERLp9Mj7hNUOnuP2mlHIemZN7zEg/qHYZwei+fwNXjs0CfqT4j48P15fdQU+/eueqFfEj4UVfAX1uTjUibB5nGwPHYx+cJYYIo9wKIN6ZXpc71+29m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JX0mUym0; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwOeWOdE6HpTMM/inCPNwOHGydUKdq66K+n7WObhaxzIf91afVIriC75vzqKWvQa55MlONb4tlUvmZX5VZlxz+bsEEwvxqpqYF/K2t3G4oii+f+v1Wx2zuuEGJAVTzZkUutzBCwiMl+of8fL9qeCxSklqp3jJ54fhGXZKuE5V2kuJ0DItfHw8RlaOha4JAooBSNH2v4bBZzGtg/alW0vzuek7GIXG+XErOoyZCdiwYpi88nwAV98QnykdwLeigx3A8rmJ/RXxye9GkwSE8UHdFwxYVf1z/P8chPZ7xm1l3lcQZhLxb9pBRrHk4oqFxgG/d7+oDpWciTZecN5p7htfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpkDBU5QMzkSHpNEvaObhMjSs20m9yNSOltN+nq47cU=;
 b=J2KAGNz7y1T5NgBCjgNk3rgn3+sD9ByF0dTJVZDLXniT9pgcssji+XNlJlbc9eSS9b+g9ye6KCfhlRfj6AHPdcpbWSZ4wY9rpxRL1gpcMU+Wshqyt+7CR8xdBFNOv+u+oxpHV/eKd7Jwkov7cYkDpyqnfejxPvlsw1QILUcpas1NGE2Zup0wdp99IiMBJMWZBgslwrfRxzEgMaGdzYYMyhip2ZigCY06roQm7q87+N31rlFtJOAmUCEm2mAqyw5GGDGMLnKN8kdyT3bxAKGMx5USFn6vtB0p06di1GGjAkNZ7k+JztyRyuIht+kBWC4qBQrK8Wf06/SlaJW4S3Z2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpkDBU5QMzkSHpNEvaObhMjSs20m9yNSOltN+nq47cU=;
 b=JX0mUym0k9udj7XQ5WS8JEpVJ+DQF91G6mOCd+gkOy4MZMeJAGhx9LtXyxp8B39KpcTUXjQcbyOvjcu9NY/mc8FwF88ptkJhhu6K6dJIgenJBQK2/4KLNF9Dg+gL+h4v43m2SKlNEGNx19ufxMV3mkfC4NuI1TEL1fb+yLMheItc2S+i3NzTIxOXqUnTn5svPlNenVWliL5XWAoiS29Nx/0HOT1KsN1DKsW5FtY5VMBfEmoIYLeJGHbCxAx1Tquw6ygpsgJdriIE8Rinn/KS1Oe2zCGovEaZOcanj3iQT2rNQ685wkCuFCrxiQwRU7NG31Tjr/3A4qs6YesFtQZcRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 22:33:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 22:33:46 +0000
Date: Wed, 12 Feb 2025 09:33:42 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1] mm/migrate_device: don't add folio to be freed to LRU
 in migrate_device_finalize()
Message-ID: <n5nejzgqluxjdu7qe7ninf66yba3bzat5a4uimuk34jxhrvskk@hgbyhlnidmyy>
References: <20250210161317.717936-1-david@redhat.com>
 <snlfl6ewz6u4fqdjjfo7nlqjemdcl3snk3vxt6ta4wee23bxps@nmdwftkjijsa>
 <a38f547a-355f-4050-83bf-ddfb4af5f71b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a38f547a-355f-4050-83bf-ddfb4af5f71b@redhat.com>
X-ClientProxiedBy: SY5P282CA0035.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c91091-cfbc-4a86-5339-08dd4aec25d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MicF6WAnjI7t3j1/ccCHnLcRFP/hqRaOv3mpZoJ0uPEGVo7uzYw+CRoXQmSV?=
 =?us-ascii?Q?JXXKlstfVQrH9/s29cRJhxsnXYulaKvW7FcOl/snbNe8EcKzQjbY67fBDjQr?=
 =?us-ascii?Q?qPGW/WO5fqgpeu5doIODxryHRE0a8kO3lHQRpzSjOMn1/uPZ+BLpck5MhmZi?=
 =?us-ascii?Q?blHR9k3GVpJ5jN20952/jyFcnVddo9zWBSTPGg2Ugfp+BPu3Lz0TH+cE0vCY?=
 =?us-ascii?Q?NFflListCH7NUY7aAuSgFhFfnvEXsD7vFd5VMYmqBgBK9Ul5LlOOdezDsQ8m?=
 =?us-ascii?Q?NeVMJ/ZhHxk5oedTNGv/ecCSlfgrLkWv3HK8Q10hTNJmet7O6NS8W1G/zsUh?=
 =?us-ascii?Q?6FEQarI4sBQq8vvYZjH7EjJfJ1cj/exR8AhOYhAC5ST8m2n7sC3rzKOaru4R?=
 =?us-ascii?Q?fNfONJoL5kh79mD0Y3GZRIJvVhCem2Nm+b740AHZqTELjgvqA2uIyzpyuR1h?=
 =?us-ascii?Q?nSawCaZDx1sTQQFb9qBBB8O9D6Y4jUGgW1L7iy+ulHrMm9uJtzRd0pV1h+G2?=
 =?us-ascii?Q?tagizE0oQjZyZjApDH3RhZODZnWKdJevKlIkbYW0yTm2NyTENQEYM2smvaII?=
 =?us-ascii?Q?bDGz4rE1S0GQMeXAYAkgbZcHOgEu+rU0oCyNrbjMqJgJm+CHi6xmjYYGyVMo?=
 =?us-ascii?Q?HlDHFSJD85+wwTwl8bsHhvBmURNGKUJwGvb9Q/2DULV9kIRy8TXVka6iEJ6g?=
 =?us-ascii?Q?LWJMIq7kV3xZ3Eo0mNcHgdauSzkJj+nAkKxzWZiIT/0b/9n0S15FHAB3Ra8a?=
 =?us-ascii?Q?znv233om35RcjQZ3KOfpwQ8tO5Jrm/X1CGynejCT8pbTkIeln/X/XNZ/laNT?=
 =?us-ascii?Q?LPTRhYtT5ajV+XQ0+0kiVGdvasUc6f7RKnsslXIV9v+dFQ42opsc967lyVhu?=
 =?us-ascii?Q?UJfdVVIOB9dUhusHTt85ryi6cLIHFu7LMDg051WFoWdY9fsE3RahrXYOiKJy?=
 =?us-ascii?Q?W9LbXF28pm2UCnQVPN18gbf4WPlekzOkPS3MDqFo0ERSYYHiz8fOOfG3jm3d?=
 =?us-ascii?Q?GdaBeL6nmZtHnabvXhTDqGu6Zy6gtIPb6Vqn3a4w03Mx001unboOHcsV51xI?=
 =?us-ascii?Q?gHWi79dmq+f0GxgAhKsL1m2wxrB+Q0BUWCYwNdgFO1y2EHaHU6QAuAdXxail?=
 =?us-ascii?Q?PG2U3xhyeejDDUFSPXsGzXD/0V+S3dcH2N8Zk0IwUGTNk8E4hMHlDdI9wWQn?=
 =?us-ascii?Q?jlg0ZNjfMDWyfEFUUmekD8LxXuEPf/ny3soZ9uOxcWWr7J7RaeQFn9axNqKF?=
 =?us-ascii?Q?wFNeO7asx2lwclIqA9pJyRJgaXPsiim7kx5LwBmzI+3WvS1hFg3d2Jds8rS+?=
 =?us-ascii?Q?AHPubUcmn6KpfA8wPHdjPywigDe/CItwTTp58Rk138wgMuieZOvm/jhDpn5O?=
 =?us-ascii?Q?ieJf3eWLxdImtzFNbBRjW8PnidKgh6MHY+rOBeEe5MItUuVG+v//PIRTwaDA?=
 =?us-ascii?Q?qh5SG6vweLH5557tZAhJw6mL42sjhitZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5WUZ0nDGIkFqaliOLmrSrhghqN3HqR2aFogZlW+rhj/alz4YgskpMwSLKZX?=
 =?us-ascii?Q?Y51OOc1EADsPg16e/NPkZXhKfRC81SkpLAsNym2JSmlLZ3fPdfRLYm4fN4Qf?=
 =?us-ascii?Q?cdSS8tCsDo8h+wwY9om/Z6gAkYkImEcZ6jUlM2wY+v/91R6ICyhh/qRW1ycA?=
 =?us-ascii?Q?uVB3ZArg46LMd2yEVR3GGYk0NBn+PTUHrpe6vFzU7sCWrKAV0/7dTc5YHdzf?=
 =?us-ascii?Q?CiUM5XfEe0iP3hUjEI4zZiOmDcqzW12j/JKFrXQvyrpuJDAICsNYlqEaXaVn?=
 =?us-ascii?Q?3l4f0A2XDjD034mXLO2VDhbjC04GuE5S/jU5EFzEavpAVxCCrKlQZ8xYIJmh?=
 =?us-ascii?Q?NcORMo9qgkyVZgenjWGg98tdO8bdgGhQgdVN/P/DcAZxsy2u9IiNg1Dw5LHB?=
 =?us-ascii?Q?6PD7q5IeJYTF0++iPEELzNvHz4YpPK8SiKHtN0UGyUCUbfMHx+jmN6Vpi7IP?=
 =?us-ascii?Q?eYdMF2caOt+AYN0MK2YhCgsoC+oR2xo/LAFs4ui8REX/m30uX1na07dkFXEa?=
 =?us-ascii?Q?n36cf6U8VRn8/8Of4feBXuYZNTts9iSGIpWB6wjxMI1bI5TKytOjDboLenVq?=
 =?us-ascii?Q?5MnKCG3MMEVcXRZscBzK84UTeGPFz0w5oqjxw/q/M3VakPWZMw2xnFufxNn+?=
 =?us-ascii?Q?Pp0tMNSr7AUZRbrecRhicD4xhs8yf0GLLHCzaOEG8twKFDIhUIZq40FZhoDE?=
 =?us-ascii?Q?TBCNkkjkf2FDC0aqUwK+wq+0DHw8hLTEK82dSn3Gm2z1AXzR5FWqAiaWT5aS?=
 =?us-ascii?Q?CHp/TXyF52TEs2lrGni4VL42785lWJ3mDhIyfiElzpDqgHaQEda92gC8cLaL?=
 =?us-ascii?Q?Fm3Lu1tRekjh3QsEr8flVV/QP/vLQv3wkzKdwI2mnhNYZZNZxq3zWuIa7Yd8?=
 =?us-ascii?Q?2vp0kBK+cd/vT50RBoue3pkxH+cseLNjfYNAxJRq/xT3X++pcvxdVhZ+QXWr?=
 =?us-ascii?Q?hoNbOF+M1GyuSCU6gzBRF78KXVJqv77277AGUNVGmTqikd2XYkKD24/ntdRO?=
 =?us-ascii?Q?Sm0mguaIBWCupP8MTHyTujqU9xhDWSN0NRKEso/nxs6jOnl7ITd0bnzso38J?=
 =?us-ascii?Q?JlIOzl0OHxyFBQf1Pv9zOcHkrixQm2NoTlpZglKfT2hRbpYH9SixUAp4aUay?=
 =?us-ascii?Q?TXj52lilRTdAmSdyXvgLNXzs34MctCJWKrwjCpjdWbLdhBOOBFrMj10UEl2i?=
 =?us-ascii?Q?VeUxgUuvS8Mb9pje0AIWPBUR8qCxqYMJryKcZpWKGKCAnC33l+pn/cqMPeUV?=
 =?us-ascii?Q?CL5A0DZwH/hZ7gzA/MNLkDiLSRePzuhiCaeua8VIIyFRnN5Po5shfQvTwwgs?=
 =?us-ascii?Q?HviXgT2+uAdQPtCLKh95aROaYflW7bKtgQ56Qkm7MG3vDUOlN83B/16KI47L?=
 =?us-ascii?Q?4JXGNTJy9uylGMXxn8kEEjc9gw/26USIBZb5pH8ko+SmIG6dUr8y1hHYQMl1?=
 =?us-ascii?Q?7RQeIjy6T4/Pp5LQoJxIdo0mPEb0bIlHsI74GXwN0yJhOpch8bZZayADpNk5?=
 =?us-ascii?Q?IeiHcFGqPiw6CoUvSBiiGkJ+of/xLhu20gXmUkAUnUfqjYTPUyj5+7fzy9LI?=
 =?us-ascii?Q?CIsUFarXSzKM4fRF8nQWBWTFn7qWvshfLf6ASUxv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c91091-cfbc-4a86-5339-08dd4aec25d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 22:33:46.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+if/tSe/kcTLTRzkA4MnuitE8jqPc8EBq4DniIf5bDlWUzaYS8x6gNAdcdy+PaLbaOsU0kFjfb43RAAUxH9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757

On Tue, Feb 11, 2025 at 10:05:01AM +0100, David Hildenbrand wrote:
> On 11.02.25 06:23, Alistair Popple wrote:
> > On Mon, Feb 10, 2025 at 05:13:17PM +0100, David Hildenbrand wrote:
> > > If migration succeeded, we called
> > > folio_migrate_flags()->mem_cgroup_migrate() to migrate the memcg from
> > > the old to the new folio. This will set memcg_data of the old folio to
> > > 0.
> > > 
> > > Similarly, if migration failed, memcg_data of the dst folio is left
> > > unset.
> > > 
> > > If we call folio_putback_lru() on such folios (memcg_data == 0), we will
> > > add the folio to be freed to the LRU, making memcg code unhappy. Running
> > > the hmm selftests:
> > > 
> > >    # ./hmm-tests
> > >    ...
> > >    #  RUN           hmm.hmm_device_private.migrate ...
> > >    [  102.078007][T14893] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7ff27d200 pfn:0x13cc00
> > >    [  102.079974][T14893] anon flags: 0x17ff00000020018(uptodate|dirty|swapbacked|node=0|zone=2|lastcpupid=0x7ff)
> > >    [  102.082037][T14893] raw: 017ff00000020018 dead000000000100 dead000000000122 ffff8881353896c9
> > >    [  102.083687][T14893] raw: 00000007ff27d200 0000000000000000 00000001ffffffff 0000000000000000
> > >    [  102.085331][T14893] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
> > >    [  102.087230][T14893] ------------[ cut here ]------------
> > >    [  102.088279][T14893] WARNING: CPU: 0 PID: 14893 at ./include/linux/memcontrol.h:726 folio_lruvec_lock_irqsave+0x10e/0x170
> > >    [  102.090478][T14893] Modules linked in:
> > >    [  102.091244][T14893] CPU: 0 UID: 0 PID: 14893 Comm: hmm-tests Not tainted 6.13.0-09623-g6c216bc522fd #151
> > >    [  102.093089][T14893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> > >    [  102.094848][T14893] RIP: 0010:folio_lruvec_lock_irqsave+0x10e/0x170
> > >    [  102.096104][T14893] Code: ...
> > >    [  102.099908][T14893] RSP: 0018:ffffc900236c37b0 EFLAGS: 00010293
> > >    [  102.101152][T14893] RAX: 0000000000000000 RBX: ffffea0004f30000 RCX: ffffffff8183f426
> > >    [  102.102684][T14893] RDX: ffff8881063cb880 RSI: ffffffff81b8117f RDI: ffff8881063cb880
> > >    [  102.104227][T14893] RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> > >    [  102.105757][T14893] R10: 0000000000000001 R11: 0000000000000002 R12: ffffc900236c37d8
> > >    [  102.107296][T14893] R13: ffff888277a2bcb0 R14: 000000000000001f R15: 0000000000000000
> > >    [  102.108830][T14893] FS:  00007ff27dbdd740(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
> > >    [  102.110643][T14893] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >    [  102.111924][T14893] CR2: 00007ff27d400000 CR3: 000000010866e000 CR4: 0000000000750ef0
> > >    [  102.113478][T14893] PKRU: 55555554
> > >    [  102.114172][T14893] Call Trace:
> > >    [  102.114805][T14893]  <TASK>
> > >    [  102.115397][T14893]  ? folio_lruvec_lock_irqsave+0x10e/0x170
> > >    [  102.116547][T14893]  ? __warn.cold+0x110/0x210
> > >    [  102.117461][T14893]  ? folio_lruvec_lock_irqsave+0x10e/0x170
> > >    [  102.118667][T14893]  ? report_bug+0x1b9/0x320
> > >    [  102.119571][T14893]  ? handle_bug+0x54/0x90
> > >    [  102.120494][T14893]  ? exc_invalid_op+0x17/0x50
> > >    [  102.121433][T14893]  ? asm_exc_invalid_op+0x1a/0x20
> > >    [  102.122435][T14893]  ? __wake_up_klogd.part.0+0x76/0xd0
> > >    [  102.123506][T14893]  ? dump_page+0x4f/0x60
> > >    [  102.124352][T14893]  ? folio_lruvec_lock_irqsave+0x10e/0x170
> > >    [  102.125500][T14893]  folio_batch_move_lru+0xd4/0x200
> > >    [  102.126577][T14893]  ? __pfx_lru_add+0x10/0x10
> > >    [  102.127505][T14893]  __folio_batch_add_and_move+0x391/0x720
> > >    [  102.128633][T14893]  ? __pfx_lru_add+0x10/0x10
> > >    [  102.129550][T14893]  folio_putback_lru+0x16/0x80
> > >    [  102.130564][T14893]  migrate_device_finalize+0x9b/0x530
> > >    [  102.131640][T14893]  dmirror_migrate_to_device.constprop.0+0x7c5/0xad0
> > >    [  102.133047][T14893]  dmirror_fops_unlocked_ioctl+0x89b/0xc80
> > > 
> > > Likely, nothing else goes wrong: putting the last folio reference will
> > > remove the folio from the LRU again. So besides memcg complaining,
> > > adding the folio to be freed to the LRU is just an unnecessary step.
> > 
> > Agreed - I had always wondered why we did that instead of just dropping the
> > reference but figured it was something to do with the LRU batching and never
> > looked too closely.
> > 
> > > The new flow resembles what we have in migrate_folio_move(): add the
> > > dst to the lru, remove migration ptes, unlock and unref dst.
> > > 
> > > Fixes: 8763cb45ab96 ("mm/migrate: new memory migration helper for use with device memory")
> > 
> > If this was introduced by the above I was trying to figure out why I hadn't
> > seen it, because whilst I don't religiously run hmm-tests and similar users
> > with CONFIG_DEBUG_VM I do run them often enough that I'd expect to have seen
> > the above. It turns out that prior to 85ce2c517ade ("memcontrol: only transfer
> > the memcg data for migration") you can't hit this, probably because pages were
> > double charged during migration so old->memcg_data remained set. So perhaps the
> > fixes tag should point at that, but maybe it was always wrong, I'm not familiar
> > enough with memcg to comment.
> 
> That would likely explain why we haven't sen it on the "migration succeeded"
> case when dropping src.
> 
> However, not so sure on the "migration failed" case, when we would drop dst.
> I would assume that the new folio (dst) would not be charged until we
> reached mem_cgroup_migrate() -- IOW, migration succeeded?

Hmm, good point. I don't think we actually have any good tests for migration
failed, and mostly it does succeed. So I guess I could believe I haven't hit
that path on a development kernel. We don't have any good test cases to force
migration failure, probably I should add one.

> Thanks for the review!
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

