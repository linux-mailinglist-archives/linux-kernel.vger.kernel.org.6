Return-Path: <linux-kernel+bounces-524163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E19A3DFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1344226C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8C1FFC78;
	Thu, 20 Feb 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMZAHzUz"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A01CA84;
	Thu, 20 Feb 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067539; cv=fail; b=W/RSH8uod/h0WlxhKDqQ1uip1gj5irfZCJYUMJicNkSiD03nsTx3oww44khPpcROs6TYi3U3aicSsC6ymrgxLO5igexn12NYg9xjrkD1ioHqp5ky9cykE0ANb8HFs0mg3jsxVYX/nPNOCfwsc4A5fXgkewoQECYfjXlBKi/GzIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067539; c=relaxed/simple;
	bh=ML6h+zsJoIrr4RMSNpncscfj9ka45AEInKmUuvjJsbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QdTT0dfpGsHryNo+X0pW+uHxDaioXB3MPLT8V4CsNR42qm/CkyDFv3CqdXhWlqrPzDIK6sXBbalpx8+YH9M5+RK5AWW82WWmZLphyx0h8+Qe2SLHq22ZnsGohv1vOoPvCCVIdjJ8XZ3SuTe7OUIYCRqbxvnSj4Pesv0SCxGsFEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMZAHzUz; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLIV+wvBzIUmrphd/fYfdfouRx+hdZySGblxnViPoOigXtDkHdRd4O9G9NxR/oUPLiMwSTv/YrrgRU4mnVQcDP3ysCYqetHhEShKCSvHmOeljlLxbAwuI5xNr+GjKbVb/ER911aT6Oid6gR1mK4cAP0hRZSX/5+CXYsjNDy79yfbdXdoVJOaBkX/RJlRWNjoQjRKMBqlDBI8NK0Djz+pxX8UH840WbcObUDHmOJOE2pbCG8Mg1lKW7Ybx5266S6IbdZxV1adEulna5FPdfP0VeBZowswh1OnzFcWGV2ddiyGQQ989c8/ecBs9zEwUF4pd3Ij/va4OaVxYEO0UR+0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sit1K2XbmEA6gFMTXg3dA9fLRHlSSkGnsCvtiJ8J9Ps=;
 b=gT7POhe0Fqee308ONogBNLzfx7PlsjniGsrRPRw0bPPmjKulg+vgUQ1kLIcLGTy1gge0vmS5H0MiWlMYZOn6AVv7RITjXUTnlGH48I0Gl+XyZbCL74OKX7nhAgi2P+z5LszHeKgVuWnVehy6WXlc56K3/Pffueqtw1Jgq773AqA0sx/2MS3E1HEY82ESI/0VX1/plt0BFMC5ijmBN+fV1IxeqUrTRIHF/tkLadBk8K3l4zcH+Cjit3sc9JBlhCzuKSSC9ogB/SQ43MG60KxcGL6ZTspqfZoWMxafJXJOKSSkJYmQCsNed7syzggQc0gWnzCPw3p3O18FfN4uiKl9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sit1K2XbmEA6gFMTXg3dA9fLRHlSSkGnsCvtiJ8J9Ps=;
 b=mMZAHzUzxZ5eeC1SW2y2hySDxfDpypqAHusoLABDrjgwAyI+vVGOC+PSiwTb6c+ch8QsTwGopvodQJJjzbrcOSy61E9ufAdDMGlEDJOK7Jy5dY6VPCzM08LEhbC0Dd6SpDTGXUebkthdf0nkA6fa+asTMY/Y4EG15amOdVCjw4v4P++Ln7FBdHrvt004+i6K20Q7Dw9AbhBvFOrr3CjEmB3G9MhTOpw5NAyKtXP2ecG0nKlv2njyG9hb0T1dkEl0/lJoEWMFRbUoeT6RWH24vVnO8CrHk3ZWF826YQCYyOde6yScH2/YBBLRNVQi/eNHlBzppMjhnt4hf6wsfKcnQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:05:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 16:05:35 +0000
Date: Thu, 20 Feb 2025 12:05:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250220160534.GB50639@nvidia.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook>
 <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home>
 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
 <20250219160740.52ad61d4@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219160740.52ad61d4@gandalf.local.home>
X-ClientProxiedBy: MN2PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:208:237::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ac4700-ecbb-47b4-baec-08dd51c868d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NwS2LbuhIZ5O9EJqJvK6joR7Qr3SN+2dBqx9HLlpVyv3WBYqpWT8fbTAT0CM?=
 =?us-ascii?Q?xi0u18Aay01Ag9PHrvyYnu6vwPDv2eLEukBq2FbpOOO4mF64QFejqgfvFjqJ?=
 =?us-ascii?Q?bQpnffRZZPVNWl32u9asb1vg+lWNwViT3ftNN2f/40LBrLOy597IdR/jEg/s?=
 =?us-ascii?Q?aaaZhjXoKRejF8Dl4Q/jb0dBpWncD5XD/Znkty0Oxgaj+2HLjTIuPY/M0gWm?=
 =?us-ascii?Q?hcHxwlEvNURaK4VjtY7kMJ8dUIW2p/7KI8ihaLsBL9AMTSS4JgGSuAd1km0B?=
 =?us-ascii?Q?o2Sa7rbz6INM6O7hXJF28RavnH7Fu4s+dzilx5PGpvUN10qg/Pk5gp4BvI2d?=
 =?us-ascii?Q?BXejQxqEoWPPA4Ll4mEP0CGmCb0ZnDyVb3XstM5VFMI2ocp0v3GZh1VK+SuN?=
 =?us-ascii?Q?lLv0CTeFE4Dv3oYeXNwaV5SyfGGo7pEZcIBnVLknPsND+t9p2zZwgqyug43O?=
 =?us-ascii?Q?VnIuxskS38MikTO5TUX1fnIks1lDsNdkKCsNTdZPzDlT8ovqcKB0S10SOZuk?=
 =?us-ascii?Q?I+LPjCRaVBiW/9/g0ago71JTkFSExb8tdwHkNMI/VvIGNPO/YewRNBVWWduX?=
 =?us-ascii?Q?mxfpXhhYfEYqE80b2lDXJ3sk2PCeFzuT2k2SovRf7Twi4PUp28zLfy3wA69J?=
 =?us-ascii?Q?xh3WWetu10CFWX/sGBTfj9S+Y5KofQR6/Fpcb4EV/fRbDrlQlmwAL933f6kt?=
 =?us-ascii?Q?W3xbgxSGBkNh/sQ1zQ+Y5iorzprwonvQ81dLe/tkglMDPIOypJBDz0t0jvRs?=
 =?us-ascii?Q?jo2HMwVEYVFmY0iYDbl48O7a0sTFaxR5qbf3FjTr/UE0rzW/Obk5nx/v7aX5?=
 =?us-ascii?Q?0KGSN9EdFg1Taqj6EqgPugWTWwTD89DOqkZIT2n6hAXTC2JHdA9OchFjji1b?=
 =?us-ascii?Q?zhcSDozys6CXka9gg4G/PlW1TqIXgnrRtTvrEK0+DixVJo6SDtKqrNagqY6w?=
 =?us-ascii?Q?QFrVkp3QNR5J6ohq66qDPanolWNVFm9vmrsqWMamDYYI2VCcR7G976oyyZAN?=
 =?us-ascii?Q?Z3MpBcBwOBrVf/ZN9Iz9Q6IdXSyHMVaFp4WimT5s2WfXHubb7bvoJZ5boGT6?=
 =?us-ascii?Q?HW57MUfR2IzejAEswF94ysAPZRdoe1ri8/OtxvQbvI9PSEbkM9Cyit8sM1Zd?=
 =?us-ascii?Q?AV+S+ktXYyoW4gCIutqu/Au9R4uzkKgBXQe1nVRScGsxFL1b/3cXYFaEQdcK?=
 =?us-ascii?Q?bldrI8zIWPFeISoDNOS/eFL1OJC/9nphagI0izk7/bzgj0v/yG+WqZ4ehb/h?=
 =?us-ascii?Q?J7NSVT1rB2X+/rwvDjP51DfMNWKqa2iVk0yh2Lt4X1HXmv8FmbH2l1OxQQnZ?=
 =?us-ascii?Q?trtveQojjO3UTlA1RSACEKv2WeNfMZMBQnyQG/mt4TxImEb1Gx6oFWxJLHdf?=
 =?us-ascii?Q?QB74ArgZtOKlcv9bE8SpNyUtOH7x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MU3cK3laiMFGm6n9KkYJORPSaT0C7S9JN4b1elFAqTQYScVsFvX2MwZQPUP?=
 =?us-ascii?Q?FvA11L+zcEYPd0BSSIXYdyRNLjDmOwjc41FhcKagErXUBg587FOH1vo4ZhCc?=
 =?us-ascii?Q?mR5Fn3MioGBKR726G/37T4NQwMRIpRZES0J3Cebtw7507bfS4zoHMy867lp5?=
 =?us-ascii?Q?d/f6BSSQ1u52KFcxXTabiCs5SbaHYb2JQO+w2dl/wNq3aHnY5tr03em0nt4z?=
 =?us-ascii?Q?qe0UpJ2PiUCvlTga8PvFSAmI3dw+2w0Tiw0SLfB/jOVH+e3REh0QC0PB8ISL?=
 =?us-ascii?Q?072av63jiJol0YGSBVbiUIS1rpthXQxkAaJRtzNors5VFC4J4vft4oCoGY5w?=
 =?us-ascii?Q?oOjJ4opix1J97zKu713HmKpuO5A250A1Z2eA1IGJNV/qiJpWtgSa129dOnA0?=
 =?us-ascii?Q?/3v81OZBmLCthF5abym+JqFAfESQrKWRo9iWQLzbKvtWU05tHjfye2yJEuRE?=
 =?us-ascii?Q?Je4S2JJbre5Ww9n3veeO0J+9FXT9Lh2+JcvBrtt3Y8ldu+wDwm2gZ5V7BMBx?=
 =?us-ascii?Q?bj181F73SIdLVevvcVI0d3qb3dcHqT870/dosSgehtkTXjsTsYxl4jYN4Z8K?=
 =?us-ascii?Q?mlFdgRjWv8Y+dSBKeXDZFLm03L06YuGcRYPPfm2daeTJF7vCwHyQP9XAndpm?=
 =?us-ascii?Q?2sqgtIqUL9pe4sC+R/uC0nVOiCrAowmJ/fECbiF4XqKH1bK5kh5LRc0LRAo8?=
 =?us-ascii?Q?DCAxLuMkTvfQLOP0mQZZd/ug36YTKdp1is4wQ4UbwQfLBdivSwSZlBowZbxU?=
 =?us-ascii?Q?gYRvq2oGm7r6CY5sGeENZ21FFFFes48gKQ6tGgWkSAuzFm9kUbwXiyaGw+fM?=
 =?us-ascii?Q?5QK1241DLa094DGC5GRmD15rO4Fsn9j+psGUWc7bbdxfTCJEZgMZ/DtLywWg?=
 =?us-ascii?Q?JTko4GB7jcLBy+EPr2Tnco93znC8sKiKaCXYuTS9FFU3mg98HDU9ElOfuqv5?=
 =?us-ascii?Q?DJ0IVJva6HoA/OsN3AaiovXVzKt8qyIDFsYbrKPW3cwFh9mnRpP83+7G/R8E?=
 =?us-ascii?Q?uidh+KzLky8IhGLAPFedrqYUEZ+itrGIBfFnFb6EDipKySC6NW6Ur3zxIM4O?=
 =?us-ascii?Q?IFQfj0OKz93DH43IQN8lr4iYKI7Xhk/6n12qpjMF14bMIl8uT/JtI8rjVWld?=
 =?us-ascii?Q?ht2AhsVn8OGVCXQTu4PNLV/dgQZUJPml40dvqZuFKjyj0nG+8pq0+qrJ3GWf?=
 =?us-ascii?Q?wwZU9565yHCJBDXQD0V6q/kBdFMnLwwe9uK+dQrvtuUxpcglE9GWFTbthSFl?=
 =?us-ascii?Q?Cy5Y9HfMBf+ynuWmIhhsYu6DUNKkqnfT0Y50+6Q70AmIaVLb7yY9+sMiUFOT?=
 =?us-ascii?Q?jicWMjARxKoWGymGkz2Z/YUIcc0NOrgfcitjRgbCBmlV7JvnRzfuY5nuqfl8?=
 =?us-ascii?Q?36vSenp+vod4TnavKOxGeIb3V4BxqrRY6GWjAxJKh/ukgKRxWbzWEMg5O1nk?=
 =?us-ascii?Q?kKTIPA9a0S8KusIhI+631q+47j0JGBNnFeLg48kV2O6qjsCgyMXVu0RJEeap?=
 =?us-ascii?Q?4jF5PQ+65P72o8kc6X++yTcuXdBQFmoqgagaSUYWVXLTricyV7H8Mv6kJynj?=
 =?us-ascii?Q?Bv8FIUkSWADlBl85BKElyo+6c/E6sVwxvZDq/F5E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ac4700-ecbb-47b4-baec-08dd51c868d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:05:35.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhLkDY+ZE1+xUyJd3KMPJMb4TSNhP/AlQIY7McY7eThNp/kpMf5hxlgywX26vnr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

On Wed, Feb 19, 2025 at 04:07:40PM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 12:52:14 -0800
> Bart Van Assche <bvanassche@acm.org> wrote:
> 
> > On 2/19/25 12:46 PM, Steven Rostedt wrote:
> > > I do feel that new drivers written in Rust would help with the
> > > vulnerabilities that new drivers usually add to the kernel.  
> > 
> > For driver developers it is easier to learn C than to learn Rust. I'm
> > not sure that all driver developers, especially the "drive by"
> > developers, have the skills to learn Rust.
> 
> That's a short term problem.
> 
> But it's not like we are going to ban C from all new drivers. But as Rust
> becomes more popular, we should at the very least make it easy to support
> Rust drivers.

If we had infinite resources sure, but the whole argument here is ROI
and you often here vauge assertions that it is worth it.

What I was asking for is some actual data - how many new drivers merge
per cycle, which subsystems. What is the actual impact that we could
see under this "new drivers only" idea.

Personally I think new drivers only is not sustainable. I think there
will be endless arguments about converting existing code to Rust for
various reasons. I really have a big fear about Chritoph's point "with
no clear guidelines what language is to be used for where". We already
have so many barriers to contribution. Random demands to "rewrite X in
Rust" is going to be just a joy. :(

Jason

