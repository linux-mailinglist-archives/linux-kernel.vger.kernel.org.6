Return-Path: <linux-kernel+bounces-551380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5DCA56BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BD47AC8C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02021CC5E;
	Fri,  7 Mar 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LHqqK/bO"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012010.outbound.protection.outlook.com [52.101.71.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFC219EA5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360694; cv=fail; b=g4KT+0Dup9ahI1PmPTvesNvAkoS/uq4EaFdBnJVaPDn0t7u4tr2yyg2CVecREayfFIqkcsVJ1To/k7NQ7NnlwGhRZoWEo5zxjhaD4yzni9ZLb5dKgL/MTBnPWT/J8xobzSNd32BHvDNG6p5lCafKkSG1C9FoBrHadOLSTZa/5yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360694; c=relaxed/simple;
	bh=nts5SCqbNWiQHitcDkwNrZYwkWjQM9eO0i5IHL3q4RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aafvEhxVFAMysQNG1RLQkgsmhnrgkKHcd0NLj/EbScgpRLtVRQDa29i0iakQfKrj3X22jZYW4FvPS+SNJSo5OFxkJrOt34udBwlLFxZ/fJFcIQ0F2ByK/Kq7yErg2uXdicMb1fbkp5ePG3ShEFv4f8d1N0yi9y5SAQ2CNbyo3qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LHqqK/bO; arc=fail smtp.client-ip=52.101.71.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI7gRWAC2M/gg6GfFyFoXMjC3CVJCQwxuKBA0IUPqSMPsFExJBAV7IZ+j6cCvjZt+EgYRrTnrZvl7K8KUyx2z2Pl0OLtW95H/fNDhIM4t2dpAG22rm1mAFGsn33o93HlGi2UcTU8eBdX4vSgUCJPiVAt2t6lNKlTmFxB/QUyjQLHvbJtjXPHCnoMZ6RIVKsMpqolsuGdsfsVyN6Bviyk218G8L8Ml+1Chygl3p8Fa8TYNUBRascCZw+wWLs3Ka/dHsD1lKdEM3qImNW2G3hkw9+UAYGTbGvC6QD4osTtVFBQfolmayGiUeiQ4solH9nMI6YgJlwR5aBpry60ZxYFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe/svG1NV0FiQn2ioqhX6s/Ls3mlqAyf31ypU/0QRYA=;
 b=yvRxNnmXxnQi/B71UdD6zBEaBKyEM4VSgiT6uV8HtRVlTwMbtTKH72KGTelMf/tbnluQYaqfpRgnTN65IZjXmSUD6QX1ya0kLIusgaHcHirxQ7c3lRKcVz+Ih+Ro7MVV5NJfi3EABU1J3izmqBmKb8B5K8ILMEIEvTvCgAOeYEPrOOw+Zl+5xkgdAPWNuzl63e9+VWPTWyHh4UXOQWfX+K1O1Xx3Kf7/UVl3ZG+tYr+HttMfgBkLsZJmdGeAnbEbQSbrHbKC3gMwCg76iTic8dAXgMoaCH4bkknuLKmVKT+V7scul233Pyv/XJjXvxMkZMefnzlVQHmQYwlnLejSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe/svG1NV0FiQn2ioqhX6s/Ls3mlqAyf31ypU/0QRYA=;
 b=LHqqK/bOqNhcjzZmBlYGa9vjQ3lSlTc1uFz6r+7e5trRDJSxi7nqmVQpziujBDuUzCZW8sQNNi4nOnCUR96a0vKc4IEj9L9J+98EVpZoQGC/5EhWCUJCtOiWNdPCIt1Cq9s9xVGw2liS7luXXtg/4VOVTuG/+Jv7ueTrtxmFv9lxY80aKQuPAUelWODZB6sAUd6707vj9DsTbhK3Nb5Trs9V89jEsjV4u7eLLFclXI7lX//Y4STxaGKMT0P2POukofHYnfKZ33IDj2wVJQ/SjSXOD1nMAdFbECJ6+4/dM5ROIVc0KwjIt2idCMwZQ7bgaiLgwYIz01Jv9uTXlzHBLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:18:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:18:09 +0000
Date: Fri, 7 Mar 2025 10:18:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Message-ID: <Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
 <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
 <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049E260B10FD83E57B2DCB78FD52@VI1PR04MB10049.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB10049E260B10FD83E57B2DCB78FD52@VI1PR04MB10049.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: c55198c4-cc4c-4469-f81b-08dd5d8b44a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdWG9sucXH4guao2SXrDtJiVfWkP6kIinh6Om9SzMxZtN30dn59t85iLqAh5?=
 =?us-ascii?Q?xhOBc/E8/TeFBL2UmN+8HvnamNoo25E0ul2EMXfF0K8n9CT7P9MEHradE1jW?=
 =?us-ascii?Q?JZtGQl0Tq+Y2lGP6SLwoMYR8PWawlKCm12b+DA4MY80vAqTKWyIJedWC15+n?=
 =?us-ascii?Q?qpkTUM3lwzsVM2V8dOofoAWm6nk1rXaczYWMet8zj+x+gE/hxe4g6u3WPIOM?=
 =?us-ascii?Q?d4MrvvSOzWQM4q+aaJBLqvCG9eev4fiygcuXrA15UsDUHMtTPY1ka+K/JiU/?=
 =?us-ascii?Q?N5T/Hk8JvrnN1BZrZQL+BOw/rWIybM0nDhvFKkwkvlt/ZkIssjiugcEa2e+g?=
 =?us-ascii?Q?DsoasqPjZmZo35es9lQZFD1400TnlMOKXx3jAbr1QJNyAdsoOJHCmsZOtC3K?=
 =?us-ascii?Q?QfhCshJvuxluj91GGqvV9yThXFiHz5B5u4YZdw0dP/SvVBNJU7EfvyFTYfAo?=
 =?us-ascii?Q?7k4TOC/e3XOKiXNH13RP0tyLv5vEts1oMx85MZcZ69OK3Dd7wZqGE7ZRsSu3?=
 =?us-ascii?Q?TpAAsmkJ6NNZLJvwoW+z0DGEJOjw6iXabuq0AC+xKNX1JsR5rywo5nLCNimj?=
 =?us-ascii?Q?0vuGnthMrGp6DhPK0iv7zrufwWz8eODqfH6I4AoQiDghy5eOjgammTV0bg/c?=
 =?us-ascii?Q?EwRFf/zhW88asaMea1QXkMhc6KsvyZzMc62IaACc3qbCGDO94sb0bBhofUlx?=
 =?us-ascii?Q?qRPr98xSmTaZfWM3MCL4UJ6oY8LdkzLBFODLKcTDQQyEsCqzDe7dNF82iSL5?=
 =?us-ascii?Q?f7kugZ8k8HIqS1mbgFOji8kcgn8jg9KrUTNwKUb3YNjw7hC7IOLHwcznBoE6?=
 =?us-ascii?Q?GT7idSz+I+EcVVTmk9Ti5FzhkIdSEhaHh3okiqxWOMdYGV3Zjy8sLdMBKsly?=
 =?us-ascii?Q?qmlmVmU+Um2TMOKStC+utDhPL1ZGbashuoR3hSKCdHRBm0GE6VzfJ0ceGcYB?=
 =?us-ascii?Q?dtTun4Yjy4x8dl3j+MbNLRnDKZnZ1vyDf/TVMf8L6l60weO5nROlfMnsVjsK?=
 =?us-ascii?Q?TAuR+jVn5R9Piy5D70K6n0dnnkxCGQGu/ny7rBjdP/mbiWVUtTQY+Q2PKDaQ?=
 =?us-ascii?Q?Y2PA9VmFFJp7fc++7IXVpr48P8JK/ZzuV8D6EfrYsz/d3ac22CqXDkdei/6g?=
 =?us-ascii?Q?k/2KDXTOXieRYWGRhUenfrno1CFKuPuWwrmkMk04dLak6ptmkdwBjYHfC5tv?=
 =?us-ascii?Q?triNon/mEBZEhCm2Lkr3McJuYuYlZmNSd+fXbb4AgjF6Cwo9d72ArTaTjULc?=
 =?us-ascii?Q?oowZd3NCNfblqz5nChRh4zAs79686G37YbQmwmsUaCMmn7EVWkTkFrKvIEEl?=
 =?us-ascii?Q?VxmDnAiFgDyQ+lIoFEB0dE9TmciSjD/uTsK9uksjovpUPUCYf2AShk4dqH1Z?=
 =?us-ascii?Q?zAWVpzZhDqGTZveQtPU8i0Wrn1Irtgl+z+NvFIyJq0izxQiSfksi7sQ22cWg?=
 =?us-ascii?Q?RcE36z9iNIogE/8zEyw4JGIBXqI2XRNs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+S85sGBZZ9LQnM3q7ZO2kjNJnXrdqN/m6Cu8KVdXYq0Z3G/8L0Tv8pmnWtho?=
 =?us-ascii?Q?fYJTdtailENv9dcUBgnmXzV5AaGi5NtDnwhcxgFkx2St+WLt4o1gzMxIHvdQ?=
 =?us-ascii?Q?dT7wpjPyGc0OEi2PSBo6bmZ3VEqiFe3WjT2kikZ8hoAMILt88lPHJtXKnMm4?=
 =?us-ascii?Q?RhTkOlzL83qQOgimrKpn2ll1DsWM73vIp/JNbQNhGibMOXibU+/yxG2DZuBL?=
 =?us-ascii?Q?9rq3XhsBKIbI4H6UmsQehiWvZSco+mKraZayRNti5Nne/W8/XK6hHXeYqE32?=
 =?us-ascii?Q?Dll1308lrjVcu4mxOiF080NXUBDoDiIwAuvQGUzPwtW51KgtoGZ7XzgT31Vb?=
 =?us-ascii?Q?jFttIK0aJxVcn8T1BhrtF3B7SE3YdJzAQsaA2tE36jHjOImrcmeePQlCdwHd?=
 =?us-ascii?Q?mMqhv5MsSVZRUVptb0GCZMTbKFmr+cJ+MMerFAWGBo0KieqsxvWm2U1O0oJK?=
 =?us-ascii?Q?nlVpeU8KEnozu0IRCyl8tPNQDy4/n/cOpXLlL2EkJxxS4OaL4+KThxyq9syl?=
 =?us-ascii?Q?Li21A8cEF14k3ZoyC6/mqrddYD4LlkdV9Qn5SwD3wixFVRTGBJyLILrXu8mg?=
 =?us-ascii?Q?QOxNkqsCeMt2i3DNvRVpkumwEbDiJvjYSaM5DFJBAtq2sknw6fMrE3d1be5J?=
 =?us-ascii?Q?Nb80UDgCyVMJ4BB+A2+v7kNjNLCRssQM00AMSNuHVUdLnv3MvR+PHsdlBpYV?=
 =?us-ascii?Q?7qeYyBcmnhgwCNZPN+A6JqrYGRJ19U3nOrm5UR1497PLaIDUCtn5GZzq9UTc?=
 =?us-ascii?Q?oBM0IM3bg101XPidXBvPoYKuP32tR9HGPR+tcoOT7/EU0nAfznoz608vse11?=
 =?us-ascii?Q?mh0XUyza/Blicn5qyEzCe87N1lgDIKvGhYthIM4P3zgLgVZUyg5i+mj66CY5?=
 =?us-ascii?Q?TBcUWExWJAvSAis/0CKcuz/bfyNbFfxTwpRHVg+c30uK2Zs8IJwWpYz2/s+F?=
 =?us-ascii?Q?XWVYMb32igtSDOwHUCq7/3cNbOaKmbGrtoqf76xuP3XAPL95hhV9UYbsWj+6?=
 =?us-ascii?Q?TSYA3QMX/tYHa5BPNf5fbkRHwN6sB31oWSe2qq8H1U9O7JpHswfA7P83y4q3?=
 =?us-ascii?Q?MfbBUDep8j1Bkp4PiSJp7ss4SY61JFdm+r5GvGaqHOl1Z/1e3ylNCY7AmyiV?=
 =?us-ascii?Q?xgZ+AFXTgUVt2c9yvfzba/5TwqAcKYOXr73CgHuNv9sRqfIuRn5PNGQ54jyv?=
 =?us-ascii?Q?BNEmuRJ6Qp8MSWA/s1hxVmLQgm2XxbJP7Vm9I32s7F+FkUpnRm1r7otmZcOp?=
 =?us-ascii?Q?PMX0NN0yMCqQb9IdsWzF1kpFvJzxII1b+ALzQGEsyYc2SaN6jIzE+CuFZ1nh?=
 =?us-ascii?Q?cfikwOW5uh9Ofs0vUp+IzhXchQtpMzRWgFlnnv1Vzatv3yyBbIIT8yi/tvPQ?=
 =?us-ascii?Q?evwMyElCL10Pq7X51AA+gKdQpChvZCy4Jdpnd45hVN8baN4ll10K46IY0tBn?=
 =?us-ascii?Q?l9vcDMKtKS9a60Yy+1H1T5QqqW9HXWwJqApzN7JyMx2dm4LJIXmaZBWtRUOe?=
 =?us-ascii?Q?2TVHMaNdAQWZpRdV5egbh3haAQxNkueY4r64VA+oVlo7zuh7Nnh/aYj1UwCy?=
 =?us-ascii?Q?8TBgEMzaB3QerWagqPo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55198c4-cc4c-4469-f81b-08dd5d8b44a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:18:09.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8HnPMiA8yvaMrREVBH1WwmFuIUZ1/X+c8mYaff7oglkskMwvqvfyuYV1mpZSf2e9t8OZEZahpptB4b8OHcaFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839

On Fri, Mar 07, 2025 at 12:34:53PM +0000, Manjunatha Venkatesh wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Thursday, March 6, 2025 9:01 PM
> > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
> >
> > On Thu, Mar 06, 2025 at 08:31:29AM +0000, Manjunatha Venkatesh wrote:
> > > Hi Frank,
> > >
> > > Please find my inline comments.
> > >
> > > Regards,
> > > Manju
> >
> > Avoid top post for linux kernel mail list.
> >
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: Friday, February 28, 2025 9:19 PM
> > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > > fixed
> > > >
> > > > Subject should be "Fix read from unreadable memory at
> > > > svc_i3c_master_ibi_work()"
> > > > Or like below pattern:
> > > > 	Do ... to fix ...
> > > >
> > > [Manjunatha Venkatesh] Tittle updated as per the review comment.
> > > > On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh
> > wrote:
> > > > > I3C Master driver svc-i3c-master
> > > >
> > > > Needn't this line.
> > > >
> > > [Manjunatha Venkatesh] Removed this line and submitted the new patch
> > > > >
> > > > > As part of I3C driver probing sequence for particular device
> > > > > instance, While adding to queue it is trying to access ibi
> > > > > variable of dev which is not yet initialized causing "Unable to
> > > > > handle kernel read from unreadable memory" resulting in kernel panic.
> > > >
> > > > Can you provide more detail information why/how this happen? which
> > > > varible read cause this problem?
> > > >
> > > [Manjunatha Venkatesh] : Below is the sequence where this issue
> > happened.
> > > 1. During boot up sequence IBI is received at host  from the slave device
> > before requesting for IBI, Usually will request IBI by calling
> > i3c_device_request_ibi() during probe of slave driver.
> > > 2. Since master code trying to access IBI Variable for the particular device
> > instance before actually it initialized by slave driver, due to this randomly
> > accessing the address and causing kernel panic.
> > > 3. i3c_device_request_ibi() function invoked by the slave driver where dev-
> > >ibi = ibi; assigned as part of function call i3c_dev_request_ibi_locked().
> > > 4. But when IBI request sent by slave device, master code  trying to access
> > this variable before its initialized due to this race condition situation kernel
> > panic happened.
> >
> > Write above reproduce steps to commit message.
> >
> [Manjunatha Venkatesh] : Next commit will update this description.
> > I think it is common problem for i3c framework.
> >
> > You'd better change i3c_master_queue_ibi()
> >
> > void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
> > {
> > 	if (!slot)
> > 		return;
> >
> >         atomic_inc(&dev->ibi->pending_ibis);
> >         queue_work(dev->ibi->wq, &slot->work); }
> >
> [Manjunatha Venkatesh] : Actual issue we have faced with respect to 'dev->ibi' variable.

How about
if (!dev->ibi || !slot) {
	dev_warning("...");
	return;
}

Frank

> Pointer variable 'slot' is with respect IBI received from slave device context and 'dev->ibi' is with respect to initialization of slave driver these 2 are asynchronous events.
> dev->ibi = ibi; is initialized at i3c_dev_request_ibi_locked(), this is invoked as part of slave driver IBI init sequence, this is what we want to check before processing the IBI request from the Slave device.
> master->ibi.slots[i] this is where all device ibi instance list are saved, so here our slave driver init IBI stored with respect dev->ibi index.
> So adding 'if (!slot)' will not help to resolve this issue.


Please wrap around at 80 char to read easily.


>
> > Frank
> > >
> > >
> > > > Need fix tags and cc stable.
> > > >
> > > [Manjunatha Venkatesh] : fix tags and cc stable updated in the commit
> > message.
> > >
> [Manjunatha Venkatesh] : Last commit message missed to update fix tags and cc stable.
> Will update that information as part of next commit message.
> > > > Frank
> > > > >
> > > > > Signed-off-by: Manjunatha Venkatesh
> > <manjunatha.venkatesh@nxp.com>
> > > > > ---
> > > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> > > > work_struct *work)
> > > > >  	switch (ibitype) {
> > > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > > >  		if (dev) {
> > > > > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > > > > -			master->ibi.tbq_slot = NULL;
> > > > > +			data = i3c_dev_get_master_data(dev);
> > > > > +			if (master->ibi.slots[data->ibi]) {
> > > > > +				i3c_master_queue_ibi(dev, master-
> > > > >ibi.tbq_slot);
> > > > > +				master->ibi.tbq_slot = NULL;
> > > > > +			}
> > > > >  		}
> > > > >  		svc_i3c_master_emit_stop(master);
> > > > >  		break;
> > > > > --
> > > > > 2.46.1
> > > > >
> > > > >
> > > > > --
> > > > > linux-i3c mailing list
> > > > > linux-i3c@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c

