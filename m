Return-Path: <linux-kernel+bounces-389778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D0F9B712C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77554B21F31
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E428C2FD;
	Thu, 31 Oct 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PxLwPv7J"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32B320E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334358; cv=fail; b=SbwiYKKNC8a+fevhdWLABRb7DvWlAnXtCoA0+rGLuML5MWjfD3EOHNF0dQt1pgMDtGWUbVKD9rjSZDlhTSHmEOM2FLzZHlGNsE4Y8IXordMRi3xEryr+Q0qugc4/QfwaICN5XhXdvyIc/ENDEDmn3viLyfD0mMo9su2Z1HOz+b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334358; c=relaxed/simple;
	bh=N8rfsP8cnLJ0QwMZ/M/E1/DcyFkuEXfJcxpjsfZQd+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QRMYfZn77dvQMsVqafEG6bR15eJY9L9bAuqt0Y/RdMCVbAVxRO5ZJElFZoLsjmvnB68kAdeXrKOWpyECWvPz9jgjNdD+jj3erMkwTJcy3/yv8FAZBLKvejuk2eOL6816uMmR/cqLiEfG8amXl8mdqCgDRw51pqoS9KJOfuZHCBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PxLwPv7J; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/MB1AptqZ/HMoed0NWNZII6T7I58sU6eMQn8k0RaLg1s8Jrt/n2t3hcQ5yacvKqWE3XAGR+dn2WvkEJLANWK0ZI9rrOyG89/pAbMjc9ig025VSHnCLjvdwiGhG+9gDk+jMPC0ZBUxwRA1byTYsfieZV85ibAv5R9fUkrqiMulHSQbWq4TWKcdxNoJKWaQAcGXNNwB4pyVsGzBvwc0ZMMCJ7FsAwg1F7YkHg385jDwr883tCjy9aVdsnFUiMZAvXlFiFP7Z2/j9G+XZlviDULHh1D3YEA4KAYuj+yRJ1AiUCuu24eiUhl9Ai4yVRKL2fgGJebVBc7nc+gJ62x8NLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8/jd8Ha+tWr94TpDBuy8+8MJV60nIyjzm6sE7qeRMw=;
 b=WWhVUdZgLOKV4fol1m7JISgjuuWIvKignQQUCP3sk8RgF3rbNpUn+2e8MDZaFvTMwHSSM+64puLDosMTEhaKpe68fF4tpify0Wu70aD26kiD/dMPFIlkjX5Nh6hgPYWlU4aNSTox8oSvufbE4UbjfkwRYdSEt4pf9x1sBwEHXyvDsijZJV3jlEinQuB5+8CO1Vefla/abKPy8tLyW80LWIDN9ZL/NvQ3M4A/eRwpXdW9dsLzQXmvl7ME1jU5CNO+LMICFnMPz5Haxzwb3pJf+BE3HjdNphhvzGx8M052ll6XdlBtPiwhj2zEVspqwsy9jDuOAdzayX0YMewsMzLzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8/jd8Ha+tWr94TpDBuy8+8MJV60nIyjzm6sE7qeRMw=;
 b=PxLwPv7JkbpgPhKksMOh2c1jn2ZYuc/wqoR+8BxKNQ39y0WOijXUgpVB04yJn9b2MU3+tVsATMIRMUxVm8lvDc3G8E01IIdm7cN/P4D7CtbL9GF666fE5axhqMNMb/A1Rdmn423hXmyQhOE8PyXhAURAKDS6IR2RLvf/ecJFRii6c5waAr1z/4ARueLQ18V8MtJPlTboSVfK26UZtM4V1X4deI2JpzY/w+lEznf+XpQZo7Ezw+JKsfHffYTDfeei6E9nZMuBOow8I4Fpv6Tisplh95jtDiPrtFeBHv39+G/X7yJZ15Rd4ys5R7ah0cDYM+ryQbUco6SDUXX+zQi2Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 00:25:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 00:25:53 +0000
Date: Wed, 30 Oct 2024 21:25:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	linux-stable@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
Message-ID: <20241031002552.GB10193@nvidia.com>
References: <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
 <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
 <cdfadcd5-d9fe-4f90-8794-a563744ce207@nvidia.com>
 <20241031000218.GA6900@nvidia.com>
 <21ee9aff-a9d5-495c-9e5e-38e9d25b11cd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ee9aff-a9d5-495c-9e5e-38e9d25b11cd@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:408:eb::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: a796de30-44db-498e-a4ca-08dcf9429444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9NdgfvFMsnOcBxTVmudS5piwu2KHsq5J5RXYepoH1Fj+wusCQWko90PaNDMh?=
 =?us-ascii?Q?WwJ84+QCjUSX+/u3GRxbx2k7abjAlDJ9ZaDQ+XE2Z1eXa5aHqcH+SiBOzP43?=
 =?us-ascii?Q?hjLh9cZ9JygNpvPMgXKv4/zTnLxLv4aU1xZPZHa28zEyLCkmyW6uB07yKVfa?=
 =?us-ascii?Q?Gi+7ecBGM25/+9EqcZxFjFJdH34jJolECCV/dpud+hkv+SI8/TfRKuI1jiLi?=
 =?us-ascii?Q?HDbOY6tJ1wSHqW+myNG+MdiLea04nCayjT5wgylR1Tq+WtJ1DpQtuxRWS2lM?=
 =?us-ascii?Q?yc+d0q9OKl5bIq2/K/zKb3ti77h7+gj/1nUqnn1sozi2KUWZNx5IO839ck0V?=
 =?us-ascii?Q?Xe9pymsPBDHb897sN6JIfClc/mO8GZhQquZYAgZV9KdciOPEW+ipKjUtCsr7?=
 =?us-ascii?Q?h6pLE8OAt5vcSToHKxGcaj/fZ+wPt+DRz/8NOPTOEuxUMyw0cK/qzWHTwqb3?=
 =?us-ascii?Q?TMK6whCO9EbxSsRyYP0++AF/p5hiTBpJqKZhvEX+iZGhSyPBtJdI3EN5mDWq?=
 =?us-ascii?Q?5wh1/qRgnjgwpVOz6ypJmh5BnHMNpOWIHhbyF56NFuSnZ9hXaUBuLJKZGL7Q?=
 =?us-ascii?Q?/Rcc+ZJaVVMWfhK2Hsg2uS5/jgJLo5QVHFDle9gl7w8Y2LApq6VU2Ok/lYHH?=
 =?us-ascii?Q?dbtXck1N3Kp3pE362VWzS4JLzOBPirdEVEpbfvh9W+yyJwZmKb5cp/7VVrxI?=
 =?us-ascii?Q?FtIUREWYPfpsrttpd7uf0bnUbG31CJtEc0EwWxunziiuD/l1L/HdzgTflnCg?=
 =?us-ascii?Q?1ggUeTIv3hgSzq38vucmSdXyG40KueoNSvoGhsS5tK8mKxk73xjsAcWmF86u?=
 =?us-ascii?Q?+5JXqQ0blJN/e2qEhM5XDbSTaFbiQ1r9UsUslowVX7EZTFyVmIFfnDE5OKtI?=
 =?us-ascii?Q?Z3/rbHkzSPmCIbVUPWo+RX0C9zdfO9a1gV7ghgTnlE1xccJMjsoJfow6hsG5?=
 =?us-ascii?Q?/767iq6LWZ7zOVS1XwKfUrVSSvPhmHvBNUnoRAQiF0tiboABSV1In27QlsSL?=
 =?us-ascii?Q?nR9v28/4cK672QWmBdVRnAv0AYACKtIofUWB8yRd7UcmQ/mqULC8pFneRQA6?=
 =?us-ascii?Q?iKpO5NoVGBuTSTTTUrULCmCS6KPOQ6cubxbCraoFg422UYj3i3u1uaDGkyze?=
 =?us-ascii?Q?QrL48bpw+i+YuNW5FXsACuE2iwf9y6AMOthsEyPqa1uAvEpuxD6ywjfpnx36?=
 =?us-ascii?Q?cLTYGz+8BLH5x/uiNdWyMRvdXXHtlyoutOuH1VpxLrAv40FihgzRZ50+tHGs?=
 =?us-ascii?Q?sohkDUxp91BciM/x5bwpPs91pOWd+XXppDObW+9A8a40vhESET75XejH+Bt8?=
 =?us-ascii?Q?3gdvxlp4r67H/3v3N5tvCeZ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QGrZV2Dp+zkeh2lJ34Kg2BGzDxxJPKGch4Q91PmeG6i48Dm0/xOTH59O8x9F?=
 =?us-ascii?Q?mA2sknTJMqlf7zdP2XmVdwPhbik1bHACIZGdGE9pDMwcIeBktfFzO6m/G5jT?=
 =?us-ascii?Q?LdUUiPZFwmRRnHntOY24fKYYzs3hyfrkShzfmIAJy1U5r8cLGpC8NM4CogVG?=
 =?us-ascii?Q?9eE2C8insW/rq1uHQFxjIBwP7Wj1JP0iZCuESAeK8yCPOeQ4drEQssKaAD8m?=
 =?us-ascii?Q?qvOrtlMWVBV929+tpC9IdHf6Crnx5u5XZhyXgeN2beooBBUF3K268BtgUjuh?=
 =?us-ascii?Q?eC6aYdZ+VZjOiaCpwbvRiuKsSIXt/Ywx6jMdCJNc1n0ZIKVvOPVoyToxMacF?=
 =?us-ascii?Q?6wDsScmgtavS1GesKocVeCf1tgEFuxJjECYvT7CeopvBY+S1jec0wwpizfkO?=
 =?us-ascii?Q?KbYirKUIAhZjz9/xQIf/5lXhjkC9fpXCU+1HG6Yz/Z8jCrvCkNr3agGGx8Ze?=
 =?us-ascii?Q?lCYHpAu10JtSXj65o3CtACQVO7NfwK2EA9Ocfad60DzsIA/oKviKH8BWQSnY?=
 =?us-ascii?Q?WfB3dU6mQ+TPiijwZfAXcYPWdy4CqiG6vbgkK26miabshQaU1/sBumwA7++t?=
 =?us-ascii?Q?Ise2BBipIRM4FFu+KgyiXo4LsIcl0afJ7uSE61JZdzAe4jUhqBH9422M9WQq?=
 =?us-ascii?Q?Bbw4/CtsQIXErUgCaRk8PTpaB71c8cfxFJvDfBBpKZ132O4gcvuWSR1BMfRp?=
 =?us-ascii?Q?GzmjfVk5mXv7NAPqpRZk2707TLtK2TI788XPZzI0rU+/Rnt6zsDnZX6yJUHD?=
 =?us-ascii?Q?1U6A1rw89dNhph145BX0/f0X8pYNNBwwVUWVAoCebDOU50GpTtOPJUXfOyZs?=
 =?us-ascii?Q?9rgkWxTMoVo2MxTLpPCRw3XylChUuDMeT3XoVTrSuAgX/+TJpAiprg58oXIA?=
 =?us-ascii?Q?YfPp8XxsQOQvegACbNIYIY3Q8HkIWfDnqnyA23T4vlbDwZfLON15WmGMYUP0?=
 =?us-ascii?Q?mg2+GloONOARnbg/q9DKYigNcL0QnWjR78BAYxONCUV0DFHfjpS6FVANuzbk?=
 =?us-ascii?Q?5NUziq2Kk6mE7zYmYESvsrjd4gbSnyIQobcK6TemhoRtDAoaykx5QY/4qxt2?=
 =?us-ascii?Q?g7gc2c+1YKOr5ZfSEzztYMwAYf7OsxZ7M5pQx6VCzAb2i234IzSXxFS+NttQ?=
 =?us-ascii?Q?Mlq9Y3DF2r58XNzQoHDA1PF0VbhbHhU1h0+pvisLNeSu3SzEdQyzoEfNiEIq?=
 =?us-ascii?Q?B5QflXaoYeB0IrmGZ4xDxCJcCf8UK7AqUqjTubW8zL6Xxj9y0qrfGIHnxa8S?=
 =?us-ascii?Q?dFk6Y68cP3ue8c+u0SxZuQ+roS3wgq2Is4MGWTLa2CAs0WIshz3CPR5Eef6k?=
 =?us-ascii?Q?bVPvEEMEjsmsQSop9kRdbaQOgol0KZuVPMtipG/ATI6Sndqou4YMnHHr5WN4?=
 =?us-ascii?Q?lnucALiiJzkRlpweKoEcDKOKB7LKWIV+a136Iimo40G3L5ykMoRW6RMyjl3U?=
 =?us-ascii?Q?vWNuOBy36ucKnfT6HStF8DQAZVuSYhUReZAfjSbM8eGbQlFG2cG4Dom3dhjC?=
 =?us-ascii?Q?EWt73A/MpPDm7/wdqyoZ/40HHtnkp6NDqSD1IIN42S4XwRdCfohrSpIiPnXe?=
 =?us-ascii?Q?bq/6D4XcdN3c5zxePRY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a796de30-44db-498e-a4ca-08dcf9429444
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:25:53.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoUe1Ru7EFSjVYZ8QRTS+h3OPL5o8jKMyw6LgMZyR9INvfBkZX4sAeU64zW1lIFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

On Wed, Oct 30, 2024 at 05:17:25PM -0700, John Hubbard wrote:
> On 10/30/24 5:02 PM, Jason Gunthorpe wrote:
> > On Wed, Oct 30, 2024 at 11:34:49AM -0700, John Hubbard wrote:
> > 
> > >  From a very high level design perspective, it's not yet clear to me
> > > that there is either a "preferred" or "not recommended" aspect to
> > > pinning in batches vs. all at once here, as long as one stays
> > > below the type (int, long, unsigned...) limits of the API. Batching
> > > seems like what you do if the internal implementation is crippled
> > > and unable to meet its API requirements. So the fact that many
> > > callers do batching is sort of "tail wags dog".
> > 
> > No.. all things need to do batching because nothing should be storing
> > a linear struct page array that is so enormous. That is going to
> > create vmemap pressure that is not desirable.
> 
> Are we talking about the same allocation size here? It's not 2GB. It
> is enough folio pointers to cover 2GB of memory, so 4MB.

Is 2GB a hard limit? I was expecting this was a range that had upper
bounds of 100GB's like for rdma.. Then it is 400MB, and yeah, that is
not great.

> That high level guidance makes sense, but here we are attempting only
> a 4MB physically contiguous allocation, and if larger than that, then
> it goes to vmalloc() which is merely virtually contiguous.

AFAIK any contiguous allocation beyond 4K basically doesn't work
reliably in a server environment due to fragmentation.

So you are always using the vmemap..

> I'm writing this because your adjectives make me suspect that you
> are referring to a 2GB allocation. But this is orders of magnitude
> smaller.

Even 4MB I would wonder about getting it split to PAGE_SIZE chunks
instead of vmemmap, but I don't know what it is being used for.

Jason

