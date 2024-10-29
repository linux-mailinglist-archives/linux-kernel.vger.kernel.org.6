Return-Path: <linux-kernel+bounces-386229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642A9B40BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B8F28349D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7F1F76B2;
	Tue, 29 Oct 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNRPHB7C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EF199920
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171003; cv=fail; b=l+cgyZKkbNfNdj9xBcAwr9MIXJd0b80GxIYwoZa1yTxre9DEmK3nClQapKkoUZqMLuPU7HgQQ1lvZxoraPicQuQZN197IS2t1noPnPLEF1E2JbQUS99244Bl2NQp2EfJLOEz6iD3+qgkC8ZefncbyDmSnGRKhZKe58v00kSQ40M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171003; c=relaxed/simple;
	bh=XT81kfgPluPHbf9sDXmFGHukEWBH8yqBX6khFlzexjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uua+dTWArJxMdWGG9xdGMTe/1mM2tmPtC5hJuW91M38kjixna49mEdxe2HlcNkiMd0rrd5LCpLquTrNG+BDbEDJogdzzxv5TfgYHjpZPyx9tsM5QyK0dwF+g97iAZC635j4faV3Nf26q4cxBAY7NrVkJ6DvGl6TXF5H4t/+AN3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNRPHB7C; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730171002; x=1761707002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XT81kfgPluPHbf9sDXmFGHukEWBH8yqBX6khFlzexjk=;
  b=PNRPHB7CRqODfVokNoBykURjjulBdoHXO+D1EyRQur4jK6GGX2x0slnK
   /GYoUv77pHzdB9PaHOex+OB9L3MBvO4d8ASFdqWlgpeHWj3ox+u1HDTX1
   dBy/wd15k9xFLViSejQDpCKclCz7vKSCI+dLK/N0wm78CEO6vVcJ9fuIC
   lokS/i8kp9Ga1j7QgUo+KVSlAiPPHECMgCzjrkzvyq5fbvdpzaYFlEtaf
   GwkOdZuNJRPsWsvQPJZdU6Pph1s6eCS6sqdz+l0Kj8VaFsbWZzAp1e62+
   s/YO8tI991Ps00DX1yIyNiVfJPjP7N/G0obT1BPPkjJTDAhKWdwvX3Plp
   A==;
X-CSE-ConnectionGUID: l9VWja9YRgKmTMmrc4q4yA==
X-CSE-MsgGUID: i4OF5RGYRraY819AzSjy2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29933817"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29933817"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 20:03:21 -0700
X-CSE-ConnectionGUID: yW20lCxfRwqkrH+bQQqf+A==
X-CSE-MsgGUID: aZQvFqsYSZ6QT0h6nq0MDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="112627204"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 20:03:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 20:03:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 20:03:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 20:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3X5arf5juS0071dJlNJKGPj+dGbJtJxHi25GGlY9usomBrXn0vXti4HfjzsvjeZscKmH1wSBqvCt/E/feVPN8ZSch/6feVOUA9AzY5e1eqWg7GQt1IZUObabUr+zNs2s7r94TnTB8K+hYIUC9HziiN2q/S8HSILcHwsVg4Nh5HzU2+JQSCZsoOGPiDJS5VcX1GeXmKRhDrI7ItpFbyrtXHee2nGYSYr2wYZZrJ9CCL0HxRagJPoeYfGee4m4gpBR+FL7ieQWRar4n+HqtsZcIzy6yRhGxebu6RdnTVOrryD3xGyh6jABE0I7WOMW/r54ipoY1KWmXib/qGQ2J9Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9By53RPvnszH60OUE7rqYNp9dhTM26YVzfHdlAnzqDA=;
 b=Yry/8RCrGbk3cmeSYwcHRGifVwXw1CapfIiB9I/bMG816U8ug47/2ZNJkhumaHUBcDqPt9DSEaJw+PraLfRzYtheYI5deiw8v2HsHXHQDgg3lYCDhaUJ2oUrPQq8RjI+EAHcLkTvtjeWOQv18IfOS14JJYSoU0RF9WkVkk7uPgOjYrvba7K4mt5A0k1kOTqFreKZLeTCm/8vT+1ePgtR+G28zxfPuU2uxRrNoWdE4ZWqN/NojhSRQkL6jGS60ulR8s6sKcDsznw8Shak4gtbxpOdakT/NjnbgzrZYv/jkt1eG9O08FE3wU8kdFd2LaYSaIa6U7pxGT6l9bEcG35DmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SN7PR11MB8264.namprd11.prod.outlook.com (2603:10b6:806:26c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 03:03:17 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 03:03:16 +0000
Date: Tue, 29 Oct 2024 11:03:07 +0800
From: Philip Li <philip.li@intel.com>
To: Matthew Sakai <msakai@redhat.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	Mike Snitzer <snitzer@kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <ZyBQa45RTWXiXJke@rli9-mobl>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SN7PR11MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: adbd30b1-ec76-420b-f515-08dcf7c63c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lHhSFex5ehPBttEJEknNmceZSopJ1ciDcmzazGVSJXjDM7Ye0Qp8wX9c9//s?=
 =?us-ascii?Q?hc5uhhfTqfJNXGAzkg63H9g6EOsGbDgzuAl/TMm+hAn1LEwPmP+5G5X4rwEt?=
 =?us-ascii?Q?XFbdE2sy5djxLg4I+aWoqESHTT/A2X8XbYPiFohmAlfz88q5T9vvn+ovi7EO?=
 =?us-ascii?Q?H4FiUKrgOm4VGquby5LNnFCuciRw7pWQ0rSRdYXkNyFxFrSDf7hHjDmC3Kfq?=
 =?us-ascii?Q?2KdSB/Vy0unOV5SomMd3Jtt1EhjX2hF/hlf1AGh1qTzOGXt73xuL2AFZR8p9?=
 =?us-ascii?Q?oUpV6rE1vwIwiEucrcUWnwzFhYaOQ060og+b6vzoLO8KsmuUOeDkvqvzjvFZ?=
 =?us-ascii?Q?r7qMgMcM54NKUEy0bWeb/PSgOocusYWs85E0Y0K9j0wjpzVSCQTXY2yST48b?=
 =?us-ascii?Q?qNKR+bDax4EBir78ZkJF3ReZfCDYdUSaVZQ2ifb/URiPOcCnUAPmLUlTDvs9?=
 =?us-ascii?Q?+IYXGu4xDvUdRPtpD+8SS6st/FhmVcRwEiok7CKRtwPxrWoeTv00KRnRv68x?=
 =?us-ascii?Q?Ebye4vvTG53SYiPNbMwt1hM5deKOHg+y2Y3hXWGQ6+ezp2m6fcuWRkJD6pRw?=
 =?us-ascii?Q?optTRzaEfjWz6rEgJWb5ydOO7w9Vb3jNli6ifccUF04MB6d9jIsGY20VMvHK?=
 =?us-ascii?Q?oOcs0W1g9wT3GD8xICYl9WiypkmYp2mn0RjBvJh77GZtOs69z5ebRnLYxIP5?=
 =?us-ascii?Q?OscnapdDs+0lIMrcYoDYTtvYI+P2dDLQ/MrqWB7Ze8UFz6f2tTTbRnQ+vhqc?=
 =?us-ascii?Q?6/AfaElkGRDydTYLtQztNeiwKcRHzmvfQix6cLJPoMJpKRs+tfn6dcQhH6Ad?=
 =?us-ascii?Q?3GbZVM+f+M5I8e8ojHFV9QjK9pT1f2gKmnYIJ939IcvzmIOBurcl5f3n6veL?=
 =?us-ascii?Q?QyH+LLk78y6ux9Z6Zg/7+0/wfSNmCoEup5KbghGhHzZBC+ns3dp2j7Oa/6XG?=
 =?us-ascii?Q?p9cIRJCiOn+lp0WP5E4L1enmWMU7pRTL7LwWg3qXQ41o9aKAzWgJ03cy3Qfd?=
 =?us-ascii?Q?rYHGeyUjSZyNl4UUibhlATxNZZlLcJXQz2YPkPDQWYYfxQoRR26mtAobbOOT?=
 =?us-ascii?Q?snuSOLQu36FCiduWljC+pKfv/nEcIkEWkTUo1zF6+j2W9SyqsWrYV91jKEWH?=
 =?us-ascii?Q?oT48aAuwYi7Ge5q4AoL28+lmnTuQT3OfzeGuLorfTit73u4yBHzk+//PWeKq?=
 =?us-ascii?Q?y2UigH52WdwN19gz0mnLWNtljXOwJvKFTFP7Cl1j0U4HCwTw9TkB5dJfqUt8?=
 =?us-ascii?Q?hXkGQjDWvSvgQxcZfhub2iuS218GF3mAuQ59E7eN3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4K4AcOcbuoRzPF/58NcEbt5XP8PLpFPDfAzY1mIbqE2wUDFi52QRIkGAt+d?=
 =?us-ascii?Q?hJn3TfmiGKrp5xZmaZd195GMn0IH5u/tYxYibq9PNB04tXcC+BgEIaW56Mc7?=
 =?us-ascii?Q?08vAzEXKiNKBkm/wZxDDWvSDWurgWpLYM7AwP9cizdFpcpIsxH9KPlVfRgWm?=
 =?us-ascii?Q?EJVMAvDjd3YCgLqvnYpnnNWmXsZb1ssHxRnwPS9b28D3vM/UbJNv8SSRQy6I?=
 =?us-ascii?Q?QBwXKNcXqbgMo/Z5vXOsgxq1X04fiwkHSZmbYgUKBCSudNowZUy+6t+v7yml?=
 =?us-ascii?Q?/G86nqVaPv92argA1UTqmCBhx50ubZEs2a0TkQM+68okg72MvQhplnbEMs+S?=
 =?us-ascii?Q?QX+/0GPKD2B9wAov6fjVrOtVntbBD2LnYaJlv+QUifctnueSrYBQgQh3XA2k?=
 =?us-ascii?Q?e22UjBFc9sOHUsbTc3NgNr1mRTMRTBuqYw2CGCtOnrKdhWCPduuOkDja0sAX?=
 =?us-ascii?Q?56JDbzZK5Xqr/dlzyMRPinF5zWhSIE2+uSqwmC+gHawtVs+HxCyijatia+ns?=
 =?us-ascii?Q?/BQhrkJm6sZSoVeDHq7YheeohroKxWXRV9HL73SVjOwvT6FeG1mbVyBgC4g4?=
 =?us-ascii?Q?f4uwZPTKt0gkMp81IplGKFlc8xWt+ckDUWUXDAtAYun5YJZZEhcwuIEEgAoR?=
 =?us-ascii?Q?VmoglZAneOnZ/7ernUsJwbj+tgopF35UUINn0g3hJl834jDX3WF+YMeHH8Dc?=
 =?us-ascii?Q?LcRs+1J9R48+drh5FF10fWn4TJy0BwkUDt5+lhqoYxMsJtif6U+19UMJdqBA?=
 =?us-ascii?Q?k/6qTHnrYg9XkZ0XHryK7stYd/RpLuw6rF0tGol/dw0oEa0emulxRlf+XIFy?=
 =?us-ascii?Q?IOJNsyPgTfZSm9DdMCMWvck+CnvYilCJKAZXsK48vJZEiLjPqcOlTUDy3b/l?=
 =?us-ascii?Q?PXlJiQfYTqc97TUolyhoQu2C5l0k+NdqgnQA80wUKob0QK439BBWiTDLXFTT?=
 =?us-ascii?Q?XnZEOP5vn1lad95/t1kuRswZc5wR1piB2Yi+rzuyyay+uFLsW4XmziDlcPJV?=
 =?us-ascii?Q?P3i5MJx/6XWToBLtuTAK8pqp3BUGz0l+0o/pfFKvUFz8DZPk9tX2tYwycbuO?=
 =?us-ascii?Q?G39odoI9WkhSpYb+SndLaTB1A9ZXAOrv2VU3Bj20/xp3LpGGm/jms3YqqdFP?=
 =?us-ascii?Q?Cr9UqPSgEtGUp85lGlbJte9ntguzz1yp/Xg+FcTahyNNKxjZ/cnlgTh8DcHP?=
 =?us-ascii?Q?sN1dDp8ONSOPv5AHP8JBt6M/dvjRJ0ghnQjXGAh9lp3vq08XndAWcThOBQiX?=
 =?us-ascii?Q?k/Uw3+MiICreOyKmKiMa9ZXOAn4YRHjf3wL6qP8hIri1G2/6bCRGU/7qebti?=
 =?us-ascii?Q?xDg4SbucEDYR0kCwAWrvnmLIPLyFe+OlUFjuB9mZoYCn/G/NLyu22macHEXt?=
 =?us-ascii?Q?nXx6tMkUgbCYAPVHEc1dpaMjG5mrM05T3IGsgsyEzBRiiMN56bNOIcrSXdPb?=
 =?us-ascii?Q?ymK4ufVAORqWL8rXnr+FX1cd9VWcE+Jn8R7IrDGN+mpNC7mGewqmLhgpgI8e?=
 =?us-ascii?Q?yGu93d3lqZBFBojNDJbqF4UN2XA5oIsbpZdpAg0dxNHLqdl7Oz+hSuxwE3AC?=
 =?us-ascii?Q?5LlP0xqbTGtlF5u2XyW1XVwFTItm3z1kOmS6FiIY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adbd30b1-ec76-420b-f515-08dcf7c63c21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 03:03:16.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jooutQ7yxrRwZUYkUnkCRMAZTz7babgYFPjVHrJAn3K+uIXbgtbqLpUZOmZv4WbDq/lJ/4Wd2WPczlg7YmC7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-OriginatorOrg: intel.com

On Mon, Oct 28, 2024 at 07:00:40PM -0400, Matthew Sakai wrote:
> This should be addressed upstream by commit
> 872564c501b72ae0c84af51084753e8652e4a84b ("dm vdo data-vio: silence sparse
> warnings about locking context imbalances")
> 
> That commit is from February. Would it be possible for these checks to use a
> more up-to-date version of the code before warning us about things that have
> already been addressed?

Sorry about this Matt, the bot side will check why this happens and fix
the issue asap to avoid meaningless report.

> 
> Matt
> 
> On 10/21/24 3:19 AM, Dan Carpenter wrote:
> > Hi Mike,
> > 
> > First bad commit (maybe != root cause):
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
> > commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
> > config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191209.osrd8z9H-lkp@intel.com/config)
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202410191209.osrd8z9H-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
> > 
> > vim +976 drivers/md/dm-vdo/data-vio.c
> > 
> > 79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
> > 79535a7881c0cb Matthew Sakai 2023-11-16  959  {
> > 79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
> > 79535a7881c0cb Matthew Sakai 2023-11-16  961
> > 79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
> > 79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
> > 79535a7881c0cb Matthew Sakai 2023-11-16  964
> > 79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
> > 79535a7881c0cb Matthew Sakai 2023-11-16  966  	spin_lock(&pool->lock);
> > 79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> > 79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
> > 79535a7881c0cb Matthew Sakai 2023-11-16  969  		return;
> >                                                          ^^^^^^
> > 
> > 79535a7881c0cb Matthew Sakai 2023-11-16  970
> > 79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
> > 79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
> >                                                          ^^^^^^
> > Still holding pool->lock on these paths.
> > 
> > 79535a7881c0cb Matthew Sakai 2023-11-16  973
> > 79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
> > 79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
> > 79535a7881c0cb Matthew Sakai 2023-11-16 @976  	launch_bio(pool->completion.vdo, data_vio, bio);
> > 79535a7881c0cb Matthew Sakai 2023-11-16  977  }
> > 79535a7881c0cb Matthew Sakai 2023-11-16  978
> > 
> 
> 

