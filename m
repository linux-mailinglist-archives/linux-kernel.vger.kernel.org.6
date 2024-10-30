Return-Path: <linux-kernel+bounces-388638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5B9B6267
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC3C1F220B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D51E5738;
	Wed, 30 Oct 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPfHsbvd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE11E3DF0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289597; cv=fail; b=CI14ljgH60FVkfnIpG0aDYDJNqteYJibAyVwoKDvh60MvUS0lyhzLqS/3dWbFph9L7n7tGzyjGDmaYhY6QKpP1dQWKtTlWzUAbEU9gEyGIvDYOcLOv/GBI+SbhhCDj+4+OpUqOINufJXmpmLvUXFwawC69jid8Nbg2NHiQmBcv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289597; c=relaxed/simple;
	bh=f/KJPfLN5GOWRyty/tB0TACOFSSstONcCIC4zse6q5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIYql8+Hhqy+f2u+5oSqjy4u1SeOFAqMKHbRAQ8mnHpRz/oknsic7GG9CnjTZcsttxLdI1vDSvpHhfiYxpV4nuzrBb/xT0GGXpXNeEoGFb4LNf5uz9iRMUFronYDlupUim+SbPanzVd8GbbHSrVPwBqT02Ee+XGYnx7FcNlz0Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPfHsbvd; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvIg6QLMSe9S+y+JjxsQH1/+d3sSjI8r++XKM6D/PYkbvaCjA91gP4pCxMqffVSj8BuqjCUkP95zUva+FD9bkiHtz0VnTXJ6lst2uW+PRcp1HU53rzrp2tlwOkUNxqIfzzxms4BLo7R6JUd4zI0iDiipI0JsmXOBjA3G2f5cB6z1cA/9svDiU9sklfYzXSd1PTMDQH3MsKM/C1mMej+DA71nR6Go/8+OzRKTP09pFfZFV5o01xo13fkngGdTWchzc5wM7g2Ytr7LToNEzY1XzXfmQ/HCZc3CU9q6O1rx9QGI2Y8l3Cr2SKYXQsjMvbvcnaqGoZU6HQXqqPwpRVkxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X82E8ZowwCzD28MJW286kPPg8OevZbML4Ym9yu7EzhA=;
 b=wuyCzx05KLy0EqhWKlgj5mEl55MBs5iNQnHq2Z1hNE1xLZNGl3jziwRY9YWlaEX1sjER+SY5xMx0tNSrh+8Wpao74YGWJVnYF292QL5eWKtJYIJcUt6ug1CuLeEztTsUbSEdJLXJgLlqleakR8PP/wOeiRI7Z5lWXYIH6J+V4wEbW70LKr6p0TIxuC20SI8bhJgGDpK5aiCB7mewct4MPH726m9/+B1RlwMc/GA3jaXJFgsP5YyJO1OkB+V8MRTLTgtEc+KP44rC4dVWKIo9Ip9YaAqu25M8s4ZixWw2wQuim4ddMplYY7O68+MM6bNVkX07JZXXKTuRvzZ1W2crKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X82E8ZowwCzD28MJW286kPPg8OevZbML4Ym9yu7EzhA=;
 b=HPfHsbvdrv24rWcUyxEr1d2bn9H7UdJBB63Ft3z9bUV+Z8Ml8kin0By8s/TcBXEuexT77XW2d/Cb41I6xHOa//MHUP7V5SDZOHjTYNl0+OWVrXvQijY/+sGfsAsRb2r5+sepCD++NBeUW46NT6GKrciKCra9aBiTc+aZ0bwkV2g7mr+LlPGTRn1ur144WxC87RURwW/kqFStTUnT+sxHHmzovRXc158qGc9oPQ4yCEjYGLWq7WNlFwjY6mP/aCzXT18SEFvNwJknwJLrvVWdnVC5kU7fdDfFT8asVlTKCprbNeKAhxwle1SPwbrTLNZjDKSc6pSyTdyl8cId82QUxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Wed, 30 Oct 2024 11:59:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 11:59:52 +0000
Date: Wed, 30 Oct 2024 08:59:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	linux-stable@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	David Hildenbrand <david@redhat.com>,
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
Message-ID: <20241030115951.GB6956@nvidia.com>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyG5IumNPMUDBQOq@infradead.org>
X-ClientProxiedBy: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac83662-d791-4340-d68c-08dcf8da5cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k03ssPyxIqVSNgRiGowKgrNeDzrjA55mClJAkbhtSk3fbqYRK4Bstw1p3rbf?=
 =?us-ascii?Q?wDzqhBYlJWXBrii4UVHhnc2opKw9FOlYB+5F3vKO/2vC1WY8e5ZqqL6L1i3c?=
 =?us-ascii?Q?bcOs/s5SkcNJfpxGRQ1t6KkN0TdUM87pbmZqQi02+L2Tu0MMYeGBelAcGMHU?=
 =?us-ascii?Q?1IWwIHxRFjO4DIrUBPSa2voxx4AC1nviZPEkLIQ3snnWl8r9OyfXxSwiKYoQ?=
 =?us-ascii?Q?TxHpLTQEj8oqEV1YcRXXEwyprQ24GWVncKcAKI/3Y5x4cvn+YFRUdYgswZRN?=
 =?us-ascii?Q?XJhz7hqfJXWvhrylCDwyahkj+gVoeUJC4Hid+cnDjtcx6gIWIseso9TM2umW?=
 =?us-ascii?Q?7fOpqi1vC5WUFetas0xOeh+n08DolTjSNxRYsc6aP2bH0KzLda9qThzCJbHI?=
 =?us-ascii?Q?KX2UR++yIDV7WrK1kEtRZmQdZnsXw8PfV8xml9b4l7sgn34yajDkVh9EhDT0?=
 =?us-ascii?Q?bx/4bD5f0h+IQvfeSr2Lx3g6vKPlv9IGyz6MNtR1/4f0pRlsCb+d8xihGZ4S?=
 =?us-ascii?Q?QCW+wtNQfS8bm9KAHSTqo0NZBHZcx74DTwuWxTphbTK7YpqmAhbU1y+OcBtY?=
 =?us-ascii?Q?Wtl3uUXD3IQ/6JvFVu1jgRRnFaYBcjVtVh3sVzEz/vdvuz4zFv0sKoWZgmPR?=
 =?us-ascii?Q?DK/wUxCN0eoub9fLRG2N4T12SuvMYrgsf8WHq+Fqm09lnyzLLTE7KvYG6Lt/?=
 =?us-ascii?Q?LiA/H7pvaO+XyoMxCq48OkWix3trc6PkCk4+BHac+sVtacoAFWsNN5GAmGWi?=
 =?us-ascii?Q?xpPSVWaGVaEmUnEJAcK1ZzChY+Kwmq+iPEZfqNql+1n23LNalCy//Msa2sRR?=
 =?us-ascii?Q?+a3pb1Lq0pO1phWvL+q9Li07h9rLJAL7yUixqTY8UB+rOuuBl0LXuNFbM5q6?=
 =?us-ascii?Q?MvTipeufpjqf01YEJGiuGpD5LO2see9jg6gXEIjctxAEafZYdN33qSFSg+IK?=
 =?us-ascii?Q?ff9a22CWvIyVKmaD7GhnWoRJ7J7gTl3BLlPRJeT607z9Y5sCA6NmDoNKu/iG?=
 =?us-ascii?Q?b1YH5d2BSuPJkdFj8JoLliDxtfD0n1dVXBAzcU5g7nLdiQ3sjNqzSTLL6w7q?=
 =?us-ascii?Q?6l14/2eHJZZp2CnRmqOrg8VdHNs38P+bs4ZDj5d2FGUDj0xinvf0Nyl3v386?=
 =?us-ascii?Q?W9ZjcqZxIZkPN2VZhZn85pxMhRkNejngjMM3mUXR+RdTVd6zjF7Bo5ALDRMk?=
 =?us-ascii?Q?VQA4UFw7nhWxL0HzxEY9Wp3IJh+i7MSB7nCeBrsYgAbmzikD2Jg1MTBKHNsw?=
 =?us-ascii?Q?UievULpgrTg6vkg+/AtSEjRuyuY9VaaO5uwiB1qbk9U1G8q9r1VVEWcISb7f?=
 =?us-ascii?Q?FkE3tDL25EsPrglXJM6l3Acn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0d79jCa61D0k3RtAqznIehQrzuSoOGtLjEXgIb8dTRyNKvfu0bu8Yq7fahU?=
 =?us-ascii?Q?YTWOgMkKwRYG1tWeJl4/Q48Lt4JIdy4RM8NR0V69ahkGK0SHW8hn+bOkihS4?=
 =?us-ascii?Q?0cgPahLs9xnLCOvIOldFQMbAVe2S4DuuIGD9i+TWAMVFztffZIGkLc3Yc7RZ?=
 =?us-ascii?Q?Y9A2MS/Vb/j85E4eswP5bWt0XPoMYbTomLGKmnWK+CjRsz0y0iVdUleh5UVS?=
 =?us-ascii?Q?19MG7Srfqzy5tpiwd9e3ckmKoB6kludaQpKjfEKsnig/MWp35/UEQFpm/xJa?=
 =?us-ascii?Q?mCt/TIx8EfHC03HpUA90cvzNsu/sdvS+eFsWPUzQl4nTeQ9Lc3RSVXXXOWf8?=
 =?us-ascii?Q?mOEuRX00rXBSHJME/3Ax2KbqZYRBl3RUuohj2CrRPm/khjloCIj7T9Z9fApB?=
 =?us-ascii?Q?VkiSjFcKEcCHz0qDOofn/n9QRGalnYLyT005CJvd4eJqRIHbkAmp8vKB45L7?=
 =?us-ascii?Q?DeNIfozqXFuCf9gpQ6DT3fVz0sy/maVH9XhlacUEx781cewDolqPu7J0Jayy?=
 =?us-ascii?Q?sQ6tXBoVK7Ki126RfBdNJB/0GDrBxDdVBc9Xs1jkdpJWysuztlr3gQwBo7hU?=
 =?us-ascii?Q?1faCKneWP79SovPTgptQqkX9dCoJN/V7qVAYdqe7wobrcjJJ4+vDBOa+A+PF?=
 =?us-ascii?Q?L2MKCSGax6WG6PB5NyzjccGddM4SNQsQYJs9eUONDXDMPGhVRB6OWQW7eOyz?=
 =?us-ascii?Q?2WG2xNt0hpQDuemeuuASGOGpirp+dYq3ui/lubfjqMJzXjFH+/zOuZQa942U?=
 =?us-ascii?Q?ICRDj0itHnw1PoBUScksTn/qPqCmL76fjQF8SaK46+sLYkK3C9r3KncDGqly?=
 =?us-ascii?Q?Iyx/xzsJ5kX0h4R2iMqHMy8jID7LQVU+bRrS+OhR3YmenUfoUt7y3DljSpcM?=
 =?us-ascii?Q?5hrr9M2nsY6MjIZ1FtJusxOl1fSurFaHKfVF/Sb5UBQF9H5RGaQLu1DcdiDH?=
 =?us-ascii?Q?lJoVj2O4WAM8Psy2CsERowoESdENE+/1xrYQRqarE1Lt8Za/GDsWNJ9F75L2?=
 =?us-ascii?Q?etyqNqTaMUAR5aYGHJQDl1XMrl6iDEkxHtRr9prD0OxJwkkZrxq1OASDNxbm?=
 =?us-ascii?Q?gUSWpeCbmNZ/+4B2JiZNkhXjryTGhvExEgnO5BIwqPhlk+KUJpNWEzSfLDqU?=
 =?us-ascii?Q?6SlaI8gC820rDMIW3R1583quJQqWoAdgjSb2sG3TxhcrqzjnjjbN1rVIMR3B?=
 =?us-ascii?Q?A4wRNn7UCmyTiK1tIQYxa3qVS3qNc6F4Nd1m8Dir2Jv6XyU8N6oPt0tdKhJM?=
 =?us-ascii?Q?vHkOlgiwxOTVasOVrtXguCs/CIzdlh4skPmb/vwHFUn0eNaJ0R6N95gZ6AAR?=
 =?us-ascii?Q?jm3gFbPb2yJegOIsgQMS+drcVNwyXa91B/JwB+B+eK9ajRFLr0Fy1A9d2sEU?=
 =?us-ascii?Q?aEIUO1TLm8S/u/1Homf2sUqMHkd2n9gnBqrqfJMY/HdajR5FVU93nYgoG3sF?=
 =?us-ascii?Q?2k4h9ghSjoYyrowWa2DKKDeFy6pWSRyVi9dgywO/nzo5U/dN0Z/fDvmndcpX?=
 =?us-ascii?Q?SinxAQs5Ybu1/JVEqeYr76BPfcvXtFLq0JogWnb0zzsnOqSy+U/V1dFvrzUs?=
 =?us-ascii?Q?kxsm34yIKPJH0IC9v2w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac83662-d791-4340-d68c-08dcf8da5cbb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 11:59:52.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pOO/UCPFTvxGgyDx0/lT7Drd/5tMYEAea9Vicb435ZXskh+VhOHxPZ+o9pP+rO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232

On Tue, Oct 29, 2024 at 09:42:10PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
> > I expect I could piece together something with Nouveau, given enough
> > time and help from Ben Skeggs and Danillo and all...
> > 
> > Yes, this originated with the out of tree driver. But it never occurred
> > to me that upstream be uninterested in an obvious fix to an obvious
> > regression.
> 
> Because pinning down these amounts of memoryt is completely insane.
> I don't mind the switch to kvmalloc, but we need to put in an upper
> bound of what can be pinned.

I have RDMA customers that pin basically the entire machine's
memory, which is 100Gb's of RAM. It is a dedicated server doing some
HPC or Database job and it has been carefully setup to do that.

Many VFIO VM deployments will pin almost all the memory too - just a
little left over for the hypervisor. Again the machine was carefully
setup to have huge pages that cover almost all system ram and are
dedicated to backing memory for VMs.

Pinning almost all memory is a legitimate use case.

Jason

