Return-Path: <linux-kernel+bounces-388646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FE9B6289
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029DEB228CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0341E3DF0;
	Wed, 30 Oct 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBtOwO/N"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F01E5020
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289902; cv=fail; b=UN47lVCXwqVY/SRayOOSCm1bcHcgC+DZqyGxa63uof75/H5/sDGFqGVxy7Ir+B5xepBF67b25q5Hd7aDe8/z9WeQEzSG2Fj0NaQaJyX38X0syfVzfYhE3LUrDsInalmJij8RrMMpFFvBTnlnHjKYc6FTZWkOcdY2vNRPRL9MSlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289902; c=relaxed/simple;
	bh=YF1SzaLbBDav1Fi7bGIdHLBYjXxm6JG9xdX1DVkjEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qOJdAfZqCbIhn+cTw3yhjW8i9j0r3Kql/6uu4efp/T2gmm8HfWnhVruJkP8ESlL9cmJIxfJ0EG+U4rm6GqsJvJH1AAh2Mf21HwuZQhyTnW3b0AU253t5l5PND7MvJinZJ3wnVWXN1N41zgnFBpHA+qFwzHIKPhWOnn9GmaPFLDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rBtOwO/N; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv8vHb0Lo2gEfRTOkNiofjKJB8G6cIknfSsiSddxC0tWHXVtgGN3Z++L5mEXqV7jAJ3BkCOjm5ySVePXDM1q+raKPkadLEXQkHHdFCsy099AK0EJveE3bR9WBCvddo7SAiT9nbxrejzSTGIqXITabgBbyqLftJXnGh1pfeA5vYMe9mI+lVgznTPQ7+JKOMXNu14B7VHYSR1RifEi9D089CYSE2Z78TyYbNstuVWuu6K0Sc+sDnv0JRUjyBGLkAOOYNKXmaImnDFB9NVRe+VnU7Lm/zEFR0I9hf3d2eYAoQCU3pFhwCgmkNUz3qpdPAzFtuSkzZeuZCctlBvboFM1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYbCVHJNkN0s4YhqGj3SO72XiwDd4677QNNzuUh959s=;
 b=RCZKOt0TpXoonUHqq3lJ9dzXFwIj4M5LGVUQeOV0WHD+uW1JrCz1mqZ8UZKsQ9OeVs+ElfWzu8uWsHCFj4ZLLmxcbDvgPdrPMzCvWFe1whEz9/Wy0MrMKFePu+4ykj3zMxEK2E9zwTzuNwDkWXApNXgFY2riEndiS3V0/s96eMVuYcY6lkTiiGTckRIrwvXXoUuCDuJVmc3KiiEGaOLBK4q4I8LyGHNxmsQCIOF9uYu5bzcbK0Z5Jk3zFJHIOnBRoED/ti0RdiYgeUzo6u/WMjkD1miwowA4lRm2dAqwIMP1zAopNoToYjXQ1VDhBNnUzeu52tidxPmiA8aIBXFgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYbCVHJNkN0s4YhqGj3SO72XiwDd4677QNNzuUh959s=;
 b=rBtOwO/NeV4ucCiwPTGivQZZTNfW0VGde5l1Oaeuqs3/Hg1NhgMv1VoUG0lAsKIwGQ/y1JDdMsHOlhXjVU0rOLaCkQnxbWj8SvgQDQxicpBKxsLNAj22NfhCqWkGbqKIEVjYZ54oRtqSRYeaAPZHItjev0IYNUUFRHCI8o1jyNezjgODqrdf/O/MoqHjWN/6SQ/N2Uo1kOMvThO3hZM91QNdmjuL79/+MlTNvLwnu5hp+YJB9jI9TDxwZ1mS1BjPGKWn9G4kT5sX7TfjqEOMwK1gY4AktdQHnO8K+Fw0IhDFiD9r1Hx5dKkH51iaCWCnGKsWVS0o5mq0IU/YM2BDKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 12:04:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 12:04:55 +0000
Date: Wed, 30 Oct 2024 09:04:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20241030120453.GC6956@nvidia.com>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
X-ClientProxiedBy: BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: a78e5a5f-bd77-408a-50f9-08dcf8db111a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owDg7mSz+RoqIUA4OkycAlyVlJX4wboYXq4UGoyioYVRyh+3QfxzY6ospuRN?=
 =?us-ascii?Q?5vIqItj3KExfOE9TxIGD2JHd4/FOyc2niZwb80lYR8quzl5ingG31rUwNTqF?=
 =?us-ascii?Q?gcLk2gxuRYADMkmwV/urc7Ua17ScVZtquuQgr9c6MjdwSsoirDpg2EQxBTs5?=
 =?us-ascii?Q?pR/LEzhiiKs2Is7caxEcMhAzPa/lKnC8eBLrJZShhwvgrc+/6XAznY+aPbrg?=
 =?us-ascii?Q?Gq3vk8+FeL5Sy8fLde36Z8IoVDMiTaisKca3I14UKOFi8YydJNujb0xZDusw?=
 =?us-ascii?Q?u60uevwRjYDdBjp4N5PTD0M9aIpkNK9rcSDYLwtj50cxOxztknQIF5ouxaFu?=
 =?us-ascii?Q?zDjllDrCFy4MI48yO1H31rGOvtv9+++4M5eKZ6P1wUE8keKdjBXnfoME9Zin?=
 =?us-ascii?Q?hIgHlsfhWZ5+cDl+OIG+9dnTMxTw35LIGO8bei48ooi9auaPpHwJas1B3XGt?=
 =?us-ascii?Q?uaBbjVwsBH7JjkBA4PlLTJElRMj5gFWXcfgxj9zFe3k+5Kgi/qZbhyc76V/E?=
 =?us-ascii?Q?jP8I835Q3xnfINwQWEEqn1mq2gVCmLiDpTutIithVNr2WFWOfbDvW4ZUqp2H?=
 =?us-ascii?Q?z562LGRBmoTLma7NAKtYWYB6pmkkyqtO28T2Rvckj2BEyD+GGJY1GtZIqLaC?=
 =?us-ascii?Q?u5GrmhZor9Tun0PV/y2nQNnIeKn2jnTVEgW1mqErsJfDVphUXOYBbJLxDRtG?=
 =?us-ascii?Q?vM2TdcStAFfkseGEnaR9ZfkJAnGSWUTUqCuGvIM0Ge+xQJJ5jN0WB3N77B4I?=
 =?us-ascii?Q?RM3uFmkOOGN/CKHCLCmiFVgXl939PDNAN7/cQpUBWEK5MqosqvcOGAMWZ/9z?=
 =?us-ascii?Q?fhCpdQyAsZUvGamROYnS3rmuBgSj3kvn0FmOotiF4lVYtq4iNja1e8mFGhZe?=
 =?us-ascii?Q?zre/M7Jw+jujBDmgzqG9hkGtL9kBkqrdglj8RQQGrq0NMm83D2geEvBRm43w?=
 =?us-ascii?Q?f1sumom5uaNAMZr3Q+bey4D2Nrzk9OHKlHoV8m8gcOGXMPFEsLfx4v9tI7Le?=
 =?us-ascii?Q?uluGVifK0itow+qwA/nVMEIySE4JLU8NS+8X4Pk9gGpb5dUoFUVNFH185Ppm?=
 =?us-ascii?Q?KAs9dZIt+PH9SmrsQd1vmizo6cMK+YLVN1YIJyKNXy3/dtgzOY6fydlI4OFq?=
 =?us-ascii?Q?cAdUfyre9MS3yz9CzJxL4O5CHwm1YhFzZu9awruU4wMy1Wbbh4dt0KcQgAgT?=
 =?us-ascii?Q?BtL5BBIK3BVsw6LyOnlFtuw9mh7FjGPHJAtJxTskRmFR0EK6gEnUcP35nvfI?=
 =?us-ascii?Q?J4UQl5qHrllKuIrZ0XytMlVpkFd7MBktxZCGo/Q8xYr3QBEcb7rRiTYQ89Fx?=
 =?us-ascii?Q?sJQ9+ND2qEm4voSLjZIrMnOv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzimbAMtE6yM8CdO74f/T185/3N7AZBSksGtnOsOAIShFQg2ubbbXyBQKLsL?=
 =?us-ascii?Q?ZycICCBzM6B0uwAVRdofW4WgS9JYNQ+AiCjRifFCAl/AZwCXY7cW6wJ7y9t3?=
 =?us-ascii?Q?4lZKtIcgf/NvD+4jKrHaH5OD7t5xlK7i4qJKByxedwNo5nDxB42VsWXOGw1b?=
 =?us-ascii?Q?en1fSeaEgX6ZrRqycbht78B5BKHxkk50ukNM2Ts5md4FV9v8uIlayPGrTY7Z?=
 =?us-ascii?Q?Csn4bYduEIK0ft3qY+mECy4cev0jFKLkc5E9wSEXJo3pNj0oSDO+EIHkccRV?=
 =?us-ascii?Q?8ryqxiS3H7TlPxEqV8/+Or61GmGPwVYqlMKjFYmWc7GE5qbAG00IO9saoKWx?=
 =?us-ascii?Q?Y3qNKKSjrHS+kaGAfxoyR6Dp1SeKFLW7ZQWmwA8hWyoc2DXYIYNAxgcBqX/n?=
 =?us-ascii?Q?3bM0udEuJcwg19nx0JOm/i8v9UQS2T0HsbOBrkACs7ZDUNn1locNHwvX+W2O?=
 =?us-ascii?Q?zi9wTYH0uFqM5pyRSMgQbnUofw4gUhm5hD3i3HmOM8NhCq13XabGM2XDsVZR?=
 =?us-ascii?Q?0c5rTcbjfG9HJDicfXbpbuZWh/HMEwl6/u9VE2bEfEsh0aYAxS4F4VDUV+1Z?=
 =?us-ascii?Q?FvoFuo4NGU6QKESrBu5rmNEs6l0A4D/GajqS/GpBww8mHi5UEzICIcH5jy2K?=
 =?us-ascii?Q?144Z5K1IBqAWuii81aNXWUOhRLws8c20wx5GRRR5gPvrfKk/VCg+Zt4CbzxJ?=
 =?us-ascii?Q?o1269HKA116r5Pw5U0yk3WFeEFUoznjcVq9X6huEu3vYWdzp9cB8Wia0aYrV?=
 =?us-ascii?Q?trkNtuUNbPMpjf4/q+wMRTtaf0AGjfZgig9zSXXCEHae5fs2l7oOfxF8nkfk?=
 =?us-ascii?Q?0nN7rmOSd8Do9B5BEm3/yWUZH93HPBUWc1y/4YpttautegJsO8lJrT86+Fiw?=
 =?us-ascii?Q?ZbfWqve7vmGHoDSm0xU6sNmzQt9CkZHbQXPhkfroKUBLMDjvz8rjIgnRjF/x?=
 =?us-ascii?Q?uqjmgJxADg41zoU/bLDqOl74Xl2+b4PefpDHTC8tvW6TGXRLDyI+TtUZonrx?=
 =?us-ascii?Q?DQgKCqUuWWRbFxd1YBd13QDGKEDOOZrJG8CFCv/vqIrfF/FJTgWlIhukpU1u?=
 =?us-ascii?Q?8e23CFH4jC1FtooC3Sz1C1rXnk3xhSMIeerkOTR5Dtng9VLQPNBh7C4EMpkN?=
 =?us-ascii?Q?Y5As2Un3WvV6MPeKxP98LPFkzoWjVO3i61lDtxm2u3m22zH1SQfqUpwWFuov?=
 =?us-ascii?Q?ocE8K+8gTu+EMcJjilT7wGfZL7h4khL8hwR5OaLYHhEU1Jw50rdHxDd2p/O1?=
 =?us-ascii?Q?qwjcwm6k5d4hQp04Wp/AwpV27FTTkTqw7yOc0ut/pGHjEjoCus+17bAhRy7u?=
 =?us-ascii?Q?6+xuoGbmZWSNKeLZINejUvDCtaCjl77r0tgqYdI6P918VDXeYQQb7JqBn1ps?=
 =?us-ascii?Q?Y86D9WzsZeKJBo6aW3bIfVr5ZfIBiLNpK72ZTadrfjgKNr8o8AOnRbQ1xKbC?=
 =?us-ascii?Q?K8pnL/+hMys/oXWehTzdXbj5qWghqy+gPG03FO7vbjp2WoKUYmLQNPmKxauk?=
 =?us-ascii?Q?OIMTz8oODLbiayAUzGfQXR4rMqKGdmqgGbsw4A7NJBK1PlAIK/qmMNWHsZkY?=
 =?us-ascii?Q?pkob+psXHGTnZLaaMNc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e5a5f-bd77-408a-50f9-08dcf8db111a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:04:54.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKZuXoa0cd78PtLsZKHsOs35jyJcXtyWolgju+aVQCtG2PdFbjti5fk/IVJd7WCb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

On Wed, Oct 30, 2024 at 09:34:51AM +0100, David Hildenbrand wrote:

> The unusual thing is not the amount of system memory we are pinning but *how
> many* pages we try pinning in the single call.
> 
> If you stare at vfio_pin_pages_remote, we seem to be batching it.
> 
> long req_pages = min_t(long, npage, batch->capacity);
> 
> Which is
> 
> #define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))
> 
> So you can fix this in your driver ;)

Yeah, everything batches that I'm aware of. RDMA also uses a 4k batch
size, and iommufd uses 64k.

Jason

