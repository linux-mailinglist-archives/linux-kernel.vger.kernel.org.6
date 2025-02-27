Return-Path: <linux-kernel+bounces-537181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B6A488F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5398168BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCF26E95E;
	Thu, 27 Feb 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEO1hrl/"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EC26E65E;
	Thu, 27 Feb 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684208; cv=fail; b=RfiVNps7OIElGtunVlPMcUeNTPy/XUNWWIkVfRLnELLAO9u6BX4/pNRd38hwTme0uw/J/XvHLmccMHYoK6JwzHttyqs4iS84CHbQ9shFBIAC1hbsbC3V6eizM4agRAT4EB4lczg3L9wirZ+Ap19CGrs8GN9aBnnrqSeonF6tyNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684208; c=relaxed/simple;
	bh=y2XyWXlE3PSNmLwoONuXQK1l+Yxu8A4zRU7NAJktPOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwtxMRdzR8Dfu1FkkB40pjaUfoleT8NGTD4+2GZqfRtPOubAr7cbP+YkvsEukBRTqciGQoJgNWGqH42Tdls/60RTkcJi+1HPEmLpH/IumKJfdQ4rrzEzfwmpNrLGXG//+a65Dz7psOPeRpZkI8DDu498YnGU4a8dTzPFdxrBiMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TEO1hrl/; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTB/72BRAT++CsgkbuYeQmZ1u1l1lsnzY+hYeNZMT1R6iBr+rox0ow+bAgtVKgaV7AGuMJtaLwwmCOuVVCiqAxAQO9IVnW447MrM6TzzMb+IlFH4DR6emfVaqd0twSLAx4e5znSQSGrWKGF36f54baTENWoksHEI1zF9c35Qp1nhQPBaUYRE6v9Uyp3XHuDWXekpysA05ERKBioxzR671x+TkcJOYjorLS8Kqxobd8X+FMLiskyKOVSZCt65xI7ZCxBQilBrXa95yY7RIMG+Zmy7BueqMeMatEx4bViG602dH5kN1u2Xao3c75d5d1E+NVpmo09gjWyn3+gN0ywowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6U4b6LANJAPAVXDC+R6gSarqXPfbZ92Paqym34T3Wt0=;
 b=Eei3U497XSLgytmZLZvlYyXC9z9G98z7YJ40l4oC7CKQr2NQHdOXgqOzCS+3CJQ1HFuQXpQWNjQUL8GDn2wrcQS0CAb5woYea0hmhurIvVd2BuFPoZ61OxQx1sZqhyh3mCrU67wFcB3OQ3njC1p73VHrAP2Ov8/by5VFKYc674LTl3AEMJMJQTDA9jNbBGL3N6dJebKINp3E/IeXV7+I2568onTLy3+bkALX6g4LNUAMgRhet8K0X2eSVw/t+mKa0cwWy4Ox+b31x03/aU8xBB+dDJRdV/Kyk93dhTg4nCDn7xaV/9AR4guU+of1HEhSA2NHuhj+daI+dLsKTq1Vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U4b6LANJAPAVXDC+R6gSarqXPfbZ92Paqym34T3Wt0=;
 b=TEO1hrl/mSUi8qxpBhZ90rnvV6YpKNSRyB7uNLsFYVkoOfD+Ii+iJN+Sl7fYFi4qzRwbsSntpjYC9DvGneDenNspvwPNxLiNEhrCKv0FZAzoq/aMJv91VolXKmRbyr83VDdPYqQ/JOX3QEG1XRwHpEAr4YKOgwKepW98Pe2r5cC7Zd7ggB1vJFSw/VmUfeHnNPz0dex+gDHXRP38+QuCGWBYqWMafFzT6sqCr1adIYre4RwpbCVscWLPPHQ/Gp6i1XYu1DAKHbREwCbAKISi7XB/rVDBkUarg2qTQrIArq8Zory+tz+RTd6psPTWSx5rYS0SSXdjJ8MUyj2zRfguKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 19:23:23 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:23:23 +0000
Date: Thu, 27 Feb 2025 15:23:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <20250227192321.GA67615@nvidia.com>
References: <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <Z7-0pOmWO6r_KeQI@boqun-archlinux>
 <20250227144618.GE39591@nvidia.com>
 <Z8CCKl_yA74WjpQ1@Mac.home>
 <20250227161733.GH39591@nvidia.com>
 <Z8CY7fqbtbO4v1jv@Mac.home>
 <Z8ChnwPC0UwM8xBe@cassiopeiae>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ChnwPC0UwM8xBe@cassiopeiae>
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 55707f6a-e3ac-4483-3825-08dd57643391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/0SSgZfV6/7ZN6B47xy1iapyty/NCG3Y4nulZlMHZu0kastyzAAKAMU/1Wx?=
 =?us-ascii?Q?ddBQIepCEh1fJqTwqala3+12EYwII81ZeN5b8YfpByXo6imJzTvJDoGM5R3i?=
 =?us-ascii?Q?sRspnJsK2G+X9E9G+1GXfwHXVtmI9LRKMkAUrgEo/N7U2RlJWDP1aX6l9Rh7?=
 =?us-ascii?Q?ZtPy29Ic0ZMJaiTKivJesaE+NjHHvjb+fC6kzITXBVf9iZdcw3TuRcs+ZUgj?=
 =?us-ascii?Q?1rHptVFw20O8I9mCg9EJ2Je69WPEW8gFX5vK8XDx2t0sJ2w3Su0t103J3LOX?=
 =?us-ascii?Q?jm/M2yDwuZ55Zd69skmgfxp4b2EgvOZVKnZz3Cf3h2WsjlUJW9Cgtwj04Z8a?=
 =?us-ascii?Q?GQAi9AWMzz/z0Ak+p0SHi5hOp9b6o2etV7Zk7DdYisST4ZUC+xc6E2Dbq2Hf?=
 =?us-ascii?Q?Ffvbxt8cbQlyf/ZBeCdBBRvum1d1TSDiV9XfdEpfqceVhNWln25K9cFEGF5b?=
 =?us-ascii?Q?B4OYkmcPoaJSBwCcd8uPn8d6wEf2sUYqZPga51MOiyFRjpG1UGiR3l4+Io9i?=
 =?us-ascii?Q?PhqhfbLBgAvc9z8qi+pZ3QOtq1YgLJimvFZUlVaQACuTv2/WAI1KNDvyrZAg?=
 =?us-ascii?Q?e1Tt2hpkbktDjsn9RIsN1tf0mcvmy9ERLvcjoCTICHqh0Gnh6kmOdYUDrz4h?=
 =?us-ascii?Q?iRsA/PWe50kYRvpxujSD7h+AuVjXLJeEfiJT2YJSsm4hE/xA1MdUJbuVah51?=
 =?us-ascii?Q?CmoKhinJ5QSYVKR64kiJhX6RINAmdLC1AKfbQ7XYmaOztANTUGCP+xDVE5gS?=
 =?us-ascii?Q?p/Y9eLofTm2PPgfTiCXYYA1fgfhTfILkIJ6kAaJCcY74XkMPjVKvsi01qcO3?=
 =?us-ascii?Q?d7SDhpRVntyS0v9XDSJafp67ED7vNzTcnW9I+uCG+cAUSIO4PLdsBc2GOPio?=
 =?us-ascii?Q?2kDQFDdAep7s9996S3B5dhjjK1rBk8h0kDSBSF6uIJiFXJeJk95zouTozD9P?=
 =?us-ascii?Q?UfRCSzbGaiLzOE9OssJgEqm/9vw6KFX82xyUWWGhtafPLq3vtOVsgE6gPjGl?=
 =?us-ascii?Q?ARDZLWkXLRAUlAG08MZ+DwN56pYxD60bufM1hQPSmFrvzsIqBCr8j5Qv7zWw?=
 =?us-ascii?Q?qiOW94SFyKbD5f0ED7ZJm94UOSLNo7jGb1SKKMJ1Dfo7ClUQ0BDn688C3tQX?=
 =?us-ascii?Q?9eO5Br4jlhj0fnR5nc7xP9nzSACwtjRyO/eUp3WOHowL1NBwvB/gMXoj9SHq?=
 =?us-ascii?Q?ZdmGHaVgfk2zIKlZRWczEIOSBaHkxET8OYOzu3n8qcgr2OebMVxIUu2uD5px?=
 =?us-ascii?Q?Cg0ynlQGArGuyt3Adl/UjsUsUM1MMpaRkoTM7OMP0ovstQSRNCUmbAjupLrW?=
 =?us-ascii?Q?fPt1nUj6IyyG2jGqjkNuXbA0/IGg2zeKheufF3PUbGTOHlPRzTQgyukCao4C?=
 =?us-ascii?Q?A3hqZd0oG1s+k7WZ9f/wB29B8cOW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/9b+U1oHEqffJPvGfQLGnr43C4RpQYZcWt3hQT+VbcCVuRbErih0TZKZ17l?=
 =?us-ascii?Q?s6A7s2R6yOaZTNXCWTpJV29GYPLWQfXO/KVX7TFsXz592uY0NQvR2yhUQ2P6?=
 =?us-ascii?Q?tMUyoXFZ7sZvpeCq7nMt3AIEKiElJriZRfmtLmbvIoia8aq4JSfzZrxMSDGT?=
 =?us-ascii?Q?MaxeVbVR5Un44RbrIRGcn2lNqzVqjZBMLyaJADhz19Bgx+bOEgWvvIbnXDM+?=
 =?us-ascii?Q?Y44bBgIkS1vLJM1O0TWwg+XWWEVopwsmIDybz9yo1R5xkjQLlHeCdThZh0J4?=
 =?us-ascii?Q?6It4qsX4z2Z0v9/zOQ+Mkon4ZapQDFDj0SS5IaYL9SzDpgrllnqxm88aE7Me?=
 =?us-ascii?Q?F4u3jEeVOhW4tw0W/OM4t4Y9/FkNNv61rCKx0r1uB/mgdobHvqZwZEraPBQy?=
 =?us-ascii?Q?4xKydlyV8/kGh7+vWkL3veRbt5rxw0zwCBbz3vwipuh3qnv7s/vVbrL21Ycf?=
 =?us-ascii?Q?jW7ueCuj8Nesge9WP/8xxkBHNRplRd3yRX8uXBR/aGpTB6YF2dsfE21bClrQ?=
 =?us-ascii?Q?Md0lzB8sMguKW3k50orp95MzV38JLzqJ2V0y7+iubue/ayCY/MQuYWFn8q1b?=
 =?us-ascii?Q?QUWp579RjNxMPh+m0Vf0IoX8qIKQbzNhgQzcZo2pHoETWnQNmOsspOB92CE9?=
 =?us-ascii?Q?xiMM+Tcw8Qd5U2AzlVXNK+LaZ4+9xmjdtM90uYFHwyBEbUnfFBVulvNHmEjW?=
 =?us-ascii?Q?zAks/QDyBF2HhKlJvkZlQ0Wh7vHXWASmqTe4FZBpp0MNGtcu/s4dKJYEl4wV?=
 =?us-ascii?Q?SSPgIR6LNSTo073bOoAZxyXQ4nr9/3AnMGaP8Z04JIPy0hcjxdSq6GqRrwNk?=
 =?us-ascii?Q?uE0uoZhcemukiqJLT0BI/BoY3OBz8Ta9usuxTXWi7ZFqwPM18mXtpmI2NLey?=
 =?us-ascii?Q?KzEu+vPHcpzZWZgsRev8lDazY+PJHIaZE7eohDEHTHb96XXX9Y4PyEcdSgtH?=
 =?us-ascii?Q?oNuvzfRry+QeCabV4XHyZyH8xHPsLvSPhkpa83bel0yxB5RZ2hvnjR/Y7fIm?=
 =?us-ascii?Q?3EFB0xVO3047qHbq4/R/WQPZo8YstJwT8gCuERa+9LfkT8m8qiq6MwYOuyur?=
 =?us-ascii?Q?YWgB7fyEMlOLkIpSBL9bgyS+SUZ86zvpp9i1i6Wqz4bGnfSzdBLbW0tpJXFX?=
 =?us-ascii?Q?xt6zGDaJtU5nQ1n9Rjjp0vipX2VciYhXFNAkTpN2P0y7XD66nWFr9QFHiHIo?=
 =?us-ascii?Q?vQIS97RgX61g9QajryRDH67o5yE7zfyp9xHzOIQdxE9cjDYNaC2znYCNDSBo?=
 =?us-ascii?Q?xXPf8hXLeTWBI1zq/1SGnPFEgWF3YYzl8/h1xaFyVtlndLltH1HANf8jy9WP?=
 =?us-ascii?Q?REyAEGt4BlHNOYp8zxg3iQ8lhI20/OQ6W33sISlf/ewLt8S2WUlpKXK4magw?=
 =?us-ascii?Q?obZQRQ9gII3yKUaK71vmDqe87wnSX+iwndyikA20+TwzJ0A5ho7Zxvn9orQB?=
 =?us-ascii?Q?w411I+HimDRJH9OQbFZYboYJsq14y5h5LEg3OWa/oAfiZAcjS2bdTEK/Uooy?=
 =?us-ascii?Q?unSKANKdkZK+I/Nz3AD7rLNWfldLdudd1hpwHvR2V/r2EM6Cc9iUruUEqW9A?=
 =?us-ascii?Q?MsD/x7s3UEQVMdzd8oY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55707f6a-e3ac-4483-3825-08dd57643391
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:23:23.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v36MNaWC+84WliwRNZ0LInfz01xWgM2143eXtIgpmOdrkvMLO26M3hlt4JMzdGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784

On Thu, Feb 27, 2025 at 06:32:15PM +0100, Danilo Krummrich wrote:
> On Thu, Feb 27, 2025 at 08:55:09AM -0800, Boqun Feng wrote:
> > On Thu, Feb 27, 2025 at 12:17:33PM -0400, Jason Gunthorpe wrote:
> > 
> > > I still wonder why you couldn't also have these reliable reference
> > > counts rooted on the device driver instead of only on the module.
> > > 
> > 
> > You could put reliable reference counts anywhere you want, as long as it
> > reflects the resource dependencies.
> 
> Right, as I explained in a different reply, the signature for PCI driver probe()
> looks like this:
> 
> 	fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
> 
> The returned Pin<KBox<Self>> has the lifetime of the driver being bound to the
> device.
> 
> Which means a driver can bind things to this lifetime. But, it isn't forced to,
> it can also put things into an Arc and share it with the rest of the world.

This statement right here seems to be the fundamental problem.

The design pattern says that 'share it with the rest of the world' is
a bug. A driver following the pattern cannot do that, it must contain
the driver objects within the driver scope and free them. In C we
inspect for this manually, and check for it with kmemleak
progamatically.

It appears to me that the main issue here is that nobody has figured
out how to make rust have rules that can enforce that design pattern.

Have the compiler prevent the driver author from incorrectly extending
the lifetime of a driver-object beyond the driver's inherent scope, ie
that Self object above.

Instead we get this:

> If something is crucial to be bound to the lifetime of a driver being bound to a
> device (i.e. device resources), you have to expose it as Devres<T>.

Which creates a costly way to work around this missing design pattern
by adding runtime checks to every single access of T in all the
operational threads. Failable rcu_lock across every batch of register
access.

The reason the kernel has these design patterns of shutdown then
destroy is to avoid that runtime overhead! We optimize by swapping
fine grained locks for coarse locks that probably already exist. It is
a valid pattern, works well and has alot of APIs designed to support
it.

This giant thread started because people were objecting to the cost
and usability of the runtime checks on the operational paths.

So, I think you can say it can't be done, that the alternative is only
a little worse. Sad, but OK, but let's please acknowledge the
limitation.

Jason

