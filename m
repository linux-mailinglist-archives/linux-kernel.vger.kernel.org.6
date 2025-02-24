Return-Path: <linux-kernel+bounces-529338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB983A42348
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168F33A7494
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BC2561D4;
	Mon, 24 Feb 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQaYmr4q"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFF1885B8;
	Mon, 24 Feb 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407339; cv=fail; b=int/uT7fdXb8c9T4WpLslLvHQTLUNRn4cST2jpyiwc8wuooDi2kwVvZuE5KBW2vNpOcwpmQmQmDW5G//oTz2+mZ4OMbrm1FDfW8pRK7/QwaL5jKlcqeJ2p2vpT+R8nvmMfJVqSOZsiF3EC5Hqk9E9yZSTnGrXKbeVC90kBNroww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407339; c=relaxed/simple;
	bh=wjPsXWf95lpekUOC7VepwKJD4Q2r7ZWYDvyCV2ayaoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y2GzlDbv6g5FwhsbP/sQLynOTWdsiGlpy9/XFVhRhkZkavJJLZVcL5uU1tmYyysuXGqKbSwLQlg7rnHLflMHpNX8O9DevGj7CmaqVceTpdGMGv4nYQ6rscFBx4iomUznvkY/qYn6O6OVHbxx3UxA1p5RTzq5UpZOrd/8uhCR8qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQaYmr4q; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnSmsWZfngqvF2A9U+6Z1HncqFdOmd7ib63dNxyl1H1lqJlt1BiW7uZiRTSQWZGaC2V2aNc8c6ncgbv/6+LOs2TswuSC6GANuJtFYyoggAOYG+TNGzbqq26cI2/rcW2090ms9hqpETv9CkiUnhpCaTLhXiYq3tL9iaKH+FG+UXJh3qB9HLJnyHljw7ojL71SSfD42oDSJkJAOizOeCSa5t5vGO7dUZV4bwp9ZNh4Ta6qAq8iVBdWH456oCslkJHrDsDRAoZ3G7/13pzsDXZDzCKRj6Iu2zJP+f1r2Pr0/h7fXxZtu+/dSufy5QiKFIc9j490UcW5gh4K8/v4QTJBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fIlJxgLgtAAYw3aYL4kQqy67xfeorp+3cTko6Rdv5w=;
 b=ZZcFM+qT4rBfLlxA90z9xGrL0tmdFeF8rKrHYmWRN8paUs+WT0xDoBZZAJ43WZ1C7mkUEe24JzeJjpVlSupn7TcJ0vyRVUkyUXC6/uDcxSfnHT4NQKj1z+oAKyv2sr3Pm8BZooBX1UbGHCIsD7O8aMlcvjT2yNaHBtoFz57698FAot4dQorazLeTPj0nxz/2d314VA1oyYktCFClTW2jkg3X4Ny7L2Hj715D+fmUPnHChOGcN+CiNMP9XfUutplF4GOSHO9m0pf4bdiILxpwTwvScpzDcdX0YKYtovq+lQivx0R6f7/EU3Qz1+4/WJIN0dZWZX6QQ2asaGlGiDWUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fIlJxgLgtAAYw3aYL4kQqy67xfeorp+3cTko6Rdv5w=;
 b=XQaYmr4qiZdeBrgk/7G3X9NbwleSHvGVm5/Dra39aPKjnNvmsdSnJGWVat0CIbZRQAZRzRW9g14arXcVb7DGaSWB8L3ezYd/75vAJC4GpZWArK0psiVbBdYvcexij+p9v62f4ss4c0wkfHJJmsL1C8vzuj3hcIFtCQHEmZSsl6qypxtbYKSBeF/BpjJBMdYcJJwd65c/GOKPlLo6T+lil7TVPWTgmHAPOM6/KdBVBQI4lMTprrNrCkbUdqD5E6IfBvSsvxf/xr29AvMytQvFCzNAma5B9aaNA5jIllNoK/DBCbjlMACnhPYYdNd1fcrJYRhpOeB+w1iDyMZAJ8qdDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 14:28:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:28:51 +0000
Date: Mon, 24 Feb 2025 10:28:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <20250224142849.GR50639@nvidia.com>
References: <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
 <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
 <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
 <20250211163720.GH3754072@nvidia.com>
 <20250212152336.GA3848889@nvidia.com>
 <Z6zOqtaLQwnIWl2E@kernel.org>
 <20250212174303.GU3754072@nvidia.com>
 <Z7tuL-FInR7KLD1l@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7tuL-FInR7KLD1l@kernel.org>
X-ClientProxiedBy: BN0PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:408:ee::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: f784f9f9-de01-4cff-82bc-08dd54df8ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Yt2KPX1CdfvNUu49HNG0iYHMY7bcYisEw/zpXhgeYzxYIowvHOhUzd62906?=
 =?us-ascii?Q?IGytbM7SCSFcFS/MW/FxHrQxE/P4UHLaAjbHiE480jvohU330Hr3gBfRdxoo?=
 =?us-ascii?Q?f7b0PVqqeTRE6hf878zkOWtMGOyS/n65ccrfWRm+RoRv02dp3o4QE3YKfv9N?=
 =?us-ascii?Q?H57eJmBwzfJW4QqKmdT/uVLg/JNGFzPXqwsjRHLEbL8apH527iGu83sGKxlV?=
 =?us-ascii?Q?VZxN1QFkYOMmXEs9FVo7O4x8TikfINlPKJ698oAm46hr/ROS3rxXI44y23JT?=
 =?us-ascii?Q?KlICkpMt/kosD+FJOnQWnvwR6xL+YmClYAEY678NqffYMWFKQKAJx2ae7yS/?=
 =?us-ascii?Q?uaMDKSwI5FfU7wrv0J0IU/f2iwaA0/Mh261LUh3wh1wCSawbJmjrjqiCSy6Q?=
 =?us-ascii?Q?SZUyMPKMyLm7s58KSrxBEeh0JMb7Wj7EDxxH0W4x7tFVgCNN3UQud8Cm7N1T?=
 =?us-ascii?Q?pH6oiL7RUt8OJxsiS8oBYfzyXvORMMuA9YAyFW6z1zj1E2ZWhMZXTBwb/egQ?=
 =?us-ascii?Q?ZFFCOZ6cza0fBUb88GjwuAp7zbKA1AVQO3ktqxIK2C4T+ygz79W2WkuBKzLl?=
 =?us-ascii?Q?Rt65GR4NkejrtX9N11iUAK+gwRep1bQTnk53GE9IWHnMotubQ1fdNf0ByFu+?=
 =?us-ascii?Q?XW+RzTbf+u3KSTugd6dTZJkrO5PFX9kskP2iO/g5/vnsbFvNtnQEtezquwHC?=
 =?us-ascii?Q?KGHT5DDPEdxCqO+i8nZQa90cRegZjbbpIjopmoVdN9T2D4u9TSm/wpJccvat?=
 =?us-ascii?Q?qZmFQtvJpotqOx5TA0644E75FJbwCKmBt9vPUZxABz+2PAkq0QKTMbUztLSq?=
 =?us-ascii?Q?7A1PlDtQw1j24Ph/vAjIxY6tzhY12wRKZ2R4n6m7/MBBPasJZx1D4OZCP2jJ?=
 =?us-ascii?Q?jIRiaf7zd29lw6I9eMulMhZxG91mqPWAihnW43es79AuPW6sTjRuX+Bv8wrf?=
 =?us-ascii?Q?MOi50UobjP3nR5SUlftEptWZfAFQJtpjaGyFhPSN1XbYRtxp67cxqhvlOZkY?=
 =?us-ascii?Q?ryokG/jjl/d+w/DSG/AySTCBw/QJCN8ZBpse1NonBi0tHn1h0x6BMcNZhKES?=
 =?us-ascii?Q?6ldPF/J9fNLt2hOHcHIqxZ6stjp59Nqb1XhvEdsX2BaMBCb+zLb3MLYkHgsS?=
 =?us-ascii?Q?l+t2bC2bEkGUzkuoYGq44/JTk0eHnXXszchGi3gr/A6++5ABgZNTYDrnuNdh?=
 =?us-ascii?Q?LrMnvcJfPMOysRO7O1vRCoK1IyEb4b0Tg3xIDdaInw5Ux3GgtoF/Wbvif6gq?=
 =?us-ascii?Q?Z7Ct6obrKf4y3gNEVg9RveYpe0Ee+hfyXZrHnzifbowG7IrT1BdjF9/5kXHt?=
 =?us-ascii?Q?9F4MH60/Bln3vJcmy8yGsSNVrB6xPeVnbXge9T0pzTrjQF5dVBsIlZr4nWO7?=
 =?us-ascii?Q?9Yo9P4Mfi9Hr12uH+mu36AlN51F9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WHCb9ZA35yqo1UB7NQM/SATrr/yv9GMj3pmNv6tEB/a13QUD+plXQDFL0YtI?=
 =?us-ascii?Q?bY8gXtbWETxjT9LzgE2Tb6SWNRcbol/B/jvbKVJk+MM3wcue99FsDmQo1OCQ?=
 =?us-ascii?Q?3H1j9FxWkn3Exb+464eo36Ag+gFgxXj5M7GkD7rgSCpHd8eIR0KD5USFZe7c?=
 =?us-ascii?Q?aUY6OXDYNllX7YDdkTsne/qI+7SAYi5nAYGz+W5ZjQc40gX5dk8gw1Nq7FSx?=
 =?us-ascii?Q?IAhnzVmgQ+j/GEjTefAU6CZcoSPveDBodyzBYvm8fGCTr30vK+kSONsrPMDW?=
 =?us-ascii?Q?meOSxmlsmjxjwjyaBuVN7NFMiXXaVq/KmEv/GvR5HeWlJYzszN2AfgOoGn/y?=
 =?us-ascii?Q?h31hUbVz9pFp0lC9OKnud1NDaQ2XBWCDbtZszgTcBfAhWkwZMzuoKhc3bFqx?=
 =?us-ascii?Q?ecMhGrxomTH9p3QWV7knc9UAhoT3xXU9uAg+vJw63E9o5Mz+Q75QrobbP8O6?=
 =?us-ascii?Q?fzyR9a8MTwl9KXDYKlsT+PVJ+W0I+uXcXb8cLsDfKi6WFIHGDuv4iqSfGCaJ?=
 =?us-ascii?Q?eQgFCgWAJVYoaKz3RDPqxI2mC8XViXyLqRDuPsu75HsMyRXe/5KKX05ijS+J?=
 =?us-ascii?Q?wex3vrA3tNY8gRHiBdBodEqqrNDN3I0fKCHRZJs0+IpSOnP2RglH7FGAnxa5?=
 =?us-ascii?Q?t6w/toTjCpUO8P/QgewI+/PfokCnvBMzPn8/Rlss4CJDy2xTlez6PGTKJjdU?=
 =?us-ascii?Q?HiH+hWneLSEyEtsgfmJajLuq5w4rBkXfhi7zVxbHReAnSUNWpv31CMPGhZDc?=
 =?us-ascii?Q?R2ufCeZdDbccJvCdwqGKu3+FR+gYxd5lTgin/7mo7CNuoRh//UO7XF43ZlNq?=
 =?us-ascii?Q?AaNHGbxGQrYQx9j6FUnxnLp0nqepsHK0hZw36nx4ZKyP51vBV6zcJmAWs38u?=
 =?us-ascii?Q?ub0iOwYWeXPWnEdnHhoY6z38KAu+j/NbCzNyjDAvjCa8Ks5X1BahsHNX8tPa?=
 =?us-ascii?Q?SB2b2vtdbbrKcoQ5TUEwBkvCbclti3x9jqGLXXyy9JpxBQ+JXDFr3JhKbNKR?=
 =?us-ascii?Q?F9anJdTUB0nQ1B9sz5CJughs54GeCq7SS8w0oc/Fzz6Bjb7ieiH6KprNEEit?=
 =?us-ascii?Q?a6iJvxzfdoJIBBDd46IGz/DH5NbQ9oOyGaJbQ7xsZQte3tQYxt63pFy6XmUy?=
 =?us-ascii?Q?JjOzFoxDWa6ArdFuOlBbVWD5bHRwz6JlTOj5IFN+YxdFzTHde7UMg6gZ8oiY?=
 =?us-ascii?Q?7+C8gClOWFkeCxCd9OjxwZ9NMS38HWkwnh9guDERvp1Nd3N3lgLjr0a2hJaG?=
 =?us-ascii?Q?0baWn5EoXmQLx6rtHKqnCNwJaA/HyfEVabiVstsCFbzfqhLinor4zENKGtnQ?=
 =?us-ascii?Q?bn13cjuGPRVTaaf1WZQyPzEtpbKsSYRvU4V5JtubvD4HA3jL2AZABMnQUd0u?=
 =?us-ascii?Q?Qx0dp/yg9OYrWUdDEI60i+CpDp9e8vIXEw5KmECUWc69M/8nL0MTQYJz3V9+?=
 =?us-ascii?Q?f2jZpDJyCzvlXD4JE8StrkFF3IncdNcWItcirLWSBUUINjfOk124NcbSHaU9?=
 =?us-ascii?Q?3EVLPTSuJafyg9xtW9ZpZpw868ra9XFDT6iYZaGg0u1PLqh96HKPRum5ylYL?=
 =?us-ascii?Q?LL5ibwCwDtvngS1Aoao=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f784f9f9-de01-4cff-82bc-08dd54df8ed8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:28:51.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJcp1uHiC7KN6O0huHenK7K0yxt+f9f3VqH+HTl/cbluGUsAmcqrYTUHQClWYynx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

On Sun, Feb 23, 2025 at 08:51:27PM +0200, Mike Rapoport wrote:
> On Wed, Feb 12, 2025 at 01:43:03PM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 12, 2025 at 06:39:06PM +0200, Mike Rapoport wrote:
> > 
> > > As I've mentioned off-list earlier, KHO in its current form is the lowest
> > > level of abstraction for state preservation and it is by no means is
> > > intended to provide complex drivers with all the tools necessary.
> > 
> > My point, is I think it is the wrong level of abstraction and the
> > wrong FDT schema. It does not and cannot solve the problems we know we
> > will have, so why invest anything into that schema?
> 
> Preserving a lot of random pages spread all over the place will be a
> problem no matter what. With kho_preserve_folio() the users will still need
> to save physical address of that folio somewhere, 

Yes of course. However the schema of each node now gets a choice for
how it does that. ie the iommu is probably going to just store the top
pointer of a page table and rely on the internal table pointers to
store the physical addresses.

My point is that fdt mem should not be *mandatory* in the schema
because it is inherently unscalable and not what we want.

> structure that FDT will point to. So either instead of "mem" properties we'll
> have "addresses" property or a pointer to yet another page that should be
> preserved and, by the way, "mem" may come handy in this case :)

I think the preservation of the memory should be completely
independent of the FDT scheme of the nodes. If ftrace wants a "mem"
then sure, but the core preservation code should not parse it.

Nodes should be free to select whatever serialization scheme they
want.

Memory preservation should be a seperate self-contained node with its
own schema version. They should not be mixed together.

There should be single API toward the drivers, there should not get
"automatic" preservation because they put magic stuff in the FDT.

> I don't see how the "mem" property contradicts future extensions and for
> simple use cases it is already enough.

You'd just have to throw out all this code parsing mem to build the
memblock.

It also makes the weird preallocation of the FDT and it's related
sysfs probably unnecessary as it seems largely driven by this
unbounded mem attribute problem.

> I did an experiment and preserved 1GiB of random order-0 pages and measured
> time required to reserve everything in memblock.
> kho_deserialize() you suggested slightly outperformed
> kho_init_reserved_pages() that parsed a single "mem" property containing
> an array of <addr, size> pairs.

It has to be considered end-to-end, there is more cost to build up the
FDT array, and copying it around as well. Your 16Gib of random order 0
pages is 64MB of FDT space to represent as 16 byte addr/len
pairs. That's alot of memory to be allocating, zeroing and copying
around three (or four/five?) times.

So if the bitmap parsing is already slightly faster I expect the whole
end-to-end solution will be notably faster.

> For more random distribution of orders and more deep FDT the
> difference or course would be higher, but still both options sucked
> relatively to a maple tree serialized similarly to your tracker
> xarray.

I didn't like a maple tree like thing because the worst case memory
requirements become much higher - and it is more expensive to build it
on the serializing side (you have to run maple tree algorithms per-4k,
and then copy it out of the maple tree to a representation). Maybe it
is better, but I'd defer to real data on real systems before deciding.

With the numbers I was working with there are 512k of bitmaps worst
case for 16G of memory. If you imagine encoding ranges in, say, 8
bytes per range (52 bits of phys_addr_t, 12 bits of length) then you
get about 65k of ranges in the same 512k. That is only enough to store
a random distribution of 256MB of 4k pages.

Still, I'd like the see the memory preservation have its own
independent scheme, so if there is a better approach it can be
upgraded as self-contained project. It should have no effect on the
schema of the other nodes, or API toward the drivers.

> > But why? Just do it right from the start? I spent like a hour
> > sketching that, the existing preservation code is also very simple,
> > why not just fix it right now?
> 
> As I see it, we can have both. "mem" property for simple use cases, or as a
> partial solution for complex use cases and tracker you proposed for
> preserving the order of the folios.

I don't think that is a good idea. Two ways it is unnecessarily
complicated. memory preservation should be integral to the system and
be done in one way that works well for all cases. We definately don't
want two APIs toward drivers for this.

If we have the bitmap then all drivers should be updated to use
it. The core code parsing of the mem schema should be removed.

> And as another optimization we may want a maple tree for coalescing as much
> as possible to reduce amount of memblock_reserve() calls.

Is the bitmap scanning really such a high cost? It can be coalescing
the set bitmap ranges with ffs/ffz if you want to run a
memblock_reserve() sort of thing.

However, I was not imagining using something as inefficient as
memblock_reserve() in the long run. It doesn't make sense to take a
bitmap and then convert it into ranges, parse the ranges to build up
the free list, then throw away the ranges.

Instead the bitmaps should be consulted as the free list is being
built up immediately after allocating the struct pages. No ranges
ever. 

I didn't try to show this because it is definately complicated, but
the serialize side has eveything indexed in xarrays so it can generate
a linear sorted list of 'de-serializing' instructions that are slices
of bitmaps of different orders. The code that builds the free list
would simply walk that linear list of instructions and not add memory
with set bits to the free list. Simple O(1) de-serialzing approach
with some cost on the serializing side

I think going through memblock_reserve() is a good starting point, but
there is certainly alot of room for improving away from using ranges.

Jason

