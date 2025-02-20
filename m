Return-Path: <linux-kernel+bounces-524160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402D9A3E025
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC857B0BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02E1FFC78;
	Thu, 20 Feb 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5suKJOt"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4B1CEADB;
	Thu, 20 Feb 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067472; cv=fail; b=bo1xnDo/mp84grpKUlxxmEiAEQwPYdYrCiHjgbzStso0xBpyzjomiFzAWXM+Ox31IO75m1IUnweC+co/76ETKxhIM3/cWTkSmfgQ4on67uvUVUv8hPAp74M5mJt2vjc9Y95S1qVBuKoWsm+Ql+2D9EbezCDw4dFeN+r6PO/q4C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067472; c=relaxed/simple;
	bh=mT3M4ugTvcM/gyt+Vsw5fkv090ZtPz+M4Sz+tSLtde4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qlOpqarsZWCYMIG0oCEcBUOIvXFrPvFLTn/oCq910sFifdlpcreL8R9MQrxPOzASWT+/o+yMdNvvo+uw5i9hrC5JtkeWFTt7Strl0lQvXRM7BvzWsrlCbcUD/N7dO3Dbsu+KsNEWaeLhvdEUlH3JsHSgeEcRAPR59xAtGvzk9Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5suKJOt; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYDbkq9OKofr4dnXnvzWVUp84rfpQGZ1m8IUhiE/cl2vL/TlX11V9zxoIBWBLVsZMnuLLp0w2JFDuQyZxiJ1b1PJy1uxXyNAbcdDDQhlnriJRo2OrtshK/l2ecp9+tNvSwvZg/RiZGZ8+jmsm14iedZBJxQFX1KiGbviNFtZ6ttOvEubjVnmBtOSEZyCB59tJOONvrkothQEFTlvPV7TTpfB7UQwvwJPi2a9srz15++9iZZmj8hH7tobFT4BYHlu5Ia9ptN4dDBsiGnj6nyDRI5bOpFKqm5ZLc5hvrmZ55pIwtFIePv+HgmCYJCdVvFSAbNGCSPaIAjoW0ogFVQIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3PwqAR9rkdScuE0hXLh/nVk17TuJ/qWRXs5AT7qRNg=;
 b=VctOuNShCNX+VvKIxcq4o0nBnczC1mtzXWV+0kdnS+TwEHxUjaaRMe4/cu+OQzxbLGYECGEYhOHqjbAUwl+5UdPCJhlvYoCBtmeB/ViS9RIszvlittNksu/jnJEAF4GzZ0cgEsPtaUweN0oSNb5oN586cYszorR2wzwgG8nyIO1sSxvQzEpNV721aeeGQzvjP+3gqX/LcB5sMijqnzEYr6k6GBwC590j03ofxYGJ5yJzAnJE0zgQKmFM2Wk0TNKNL87811cLPAMtw4Se+Sz3AXkAPPiSty/rcPxYJRYUQUoRhrJFl8Cn3Fh7fplBDWApJxSSY8fXNykYjp67p7CzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3PwqAR9rkdScuE0hXLh/nVk17TuJ/qWRXs5AT7qRNg=;
 b=X5suKJOtppDy851QnV78M9HXfwhVbSpLWenPcX1WzxsvSBeEYTM2oRw8FSmMBn1sYNI1CYTwF0qk2WPNyjVTYWJn/HMgbqalpZyWhnkRaiN3Rs0yXtd+lmznoF0Ua2uYissGXKvDZm97b6pR6QFUp2PTB7Da9rEgRzDT1qOA908n75bRo7TK6fBs+mvs6zf1jh0TnYsrlXH456tueQSQYZPTX6hu6YOmyIuj0zFQRiMcTbJOQa+CwkGhIEYZPzZ5bj2KM7ypOb4yg28gpw3J2VtVtsJTaCYubtVqZNAyzXf1Z1X5jGK20FmKglYdmterEvSZHbBmz1Tvw7Mz00zPdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 16:04:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 16:04:25 +0000
Date: Thu, 20 Feb 2025 12:04:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250220160424.GA66570@nvidia.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
 <f77d549c-b776-4182-b170-571d1e5bb288@p183>
 <2025022007-angelfish-smite-a69d@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022007-angelfish-smite-a69d@gregkh>
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d13be4-91cb-49d2-678f-08dd51c83f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hYI+40aIVja6/PlJ6o6ECE85EBpvGX1jlthxPXXQ6badi7k+e9D9biFAqwRq?=
 =?us-ascii?Q?/Lc4Dnp9KYDfHwTwBh/aGg6+m0rMr69jTjWTUl65xRdWnBDPKyEZrsvLH/TW?=
 =?us-ascii?Q?LlOv8+Yk0fTQo635uiWsYDB5OQCZWqJ8a88M2W6RsNFxooDmJ8ZxdkUqT9/H?=
 =?us-ascii?Q?A+J5N6WkXR1LzxJJUx7Z8CnE3yiPFgXLGKRfuBHxMrjCBUredFpgfffNv2gp?=
 =?us-ascii?Q?+pyC6vNI/5SSKmVRm9XxV3fj6HdmmcIydoZaE1m5J0tvEIPoBqE44yoBSsI8?=
 =?us-ascii?Q?jBbCgSuSshr8jAjeR81ppdscWQh7WOS0MCFtVaQAVHOMipbZhOmajpJCY9Dc?=
 =?us-ascii?Q?QrrBimvXmI0gcTNHFnQxvYMZzzTDf64nsYT9AF5GisxZN7BY4fZ2N0aNTMYI?=
 =?us-ascii?Q?7YNatOWKCi2mGY+8bMNERfW7hiEKLfR21SzaZvdS+/4Smpqd6o4NuIrdHDw9?=
 =?us-ascii?Q?8MvCwUof32YPHIputrQVH+OxxzE9kC2NQ//H5UjJfMMgRVctAss6mPRgdwdl?=
 =?us-ascii?Q?cOiAgPzPg5mYF4lNxD9J2pn1UcYAyUlUtB2WzSkiD+xE7XaCSs6viQSak/QE?=
 =?us-ascii?Q?rBaj7DUmVOs5rqyeAkFldL1hfyo+WYP5HgNZYX9ADd5paQkS9yjjXz2PCKoQ?=
 =?us-ascii?Q?Yg+rXXoGtMH3hJbWIEo9FX/eh15a+ShTJesDBWcdK6cISBurbuPYO8GCiQgZ?=
 =?us-ascii?Q?f/oV35T49lNbfGuzO0jgvvPqcDR7XFkkalnF8CYBBxktVupI4RPh+Hy+S4Ic?=
 =?us-ascii?Q?5T/3cCJ9iRumR/JrlhjPYdi+7KAL9Dkj/CAW3D6YONe+Tt+vcFHNuTAbxDv3?=
 =?us-ascii?Q?9HUy/JlIC6s+yAgdc5ZvjutHroLT1HbbRDrSxEp+TPWwcA+Wa5kbNE867KkO?=
 =?us-ascii?Q?bIbtM3IA/IDRin39bUptOCRVWGPgKWgx7mTZjt21L/o6mytMg6DhkZFhfbOY?=
 =?us-ascii?Q?QUbeSCHDP5J/xfcyNdRRGxOsCI4pdc708NmDvgZxsP5E80O5jsgKUpIiUhdJ?=
 =?us-ascii?Q?izA8k9kWM0yGRi935sUADsNJEeettz4nzx8t59cOTbP6cEy6FD25jSqzTDSY?=
 =?us-ascii?Q?noLYAJ8dSwl2fq6SK4QVsHH0nJUBhqmkMr+jEmnlgYD6UgZhz/6PHCIZNqtX?=
 =?us-ascii?Q?FPNldyAzYuahuhvoychLd7ItTjds4aHPcHOzU7ZyaNEeF4nM7P5lFWaI+TD5?=
 =?us-ascii?Q?R/gwnI6Jf1r82/hOCCvC4jdbnQzBxN4d5LOlMo9ZUlJQqp2u1cBiA9GA6vXC?=
 =?us-ascii?Q?MU08X5Ji9/MiWIDonjgddPUcRN2bHHw0f6ULxgJD5rnR/fgS3MInJvpRTGAr?=
 =?us-ascii?Q?zs2Q2NrHrWAbGolmkPuAwkAxJLSxXY8oeA/wNfk3w5UZ4iuJVGApyhPpac9P?=
 =?us-ascii?Q?X2DTvsoAx1uL+eMLtyNTXbZfxdz4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3TyolT6YHOa10Sb2I1lwmna8yS9XTvhT+Nlb23CV9j8leyYG/T24hTB6Smq?=
 =?us-ascii?Q?EZ6ObDnR6mc9z+hYA31YUjNuqcs6SOMQzXyf5rBVbRgYpl9nWyqz4g9GPQ1c?=
 =?us-ascii?Q?GnktCMv4mNb2LVsULaPeLsMtu56ON6HhpiztwD/JLfUnVvg87N480jaucW1B?=
 =?us-ascii?Q?4IR7kiIoVU6Z1ri0Z2QWbRnSHEWB+agGkIoP2pd5VGGeB7lbQrQvLHYhhzQy?=
 =?us-ascii?Q?DAwgSaBvzPDgCQUlZmo0n3rJLNAt/7cqVY8zTs3FVQ2l2J1lMN0iJiyMI9pn?=
 =?us-ascii?Q?edLzV3ptZjUwNvUwRXTltPOZeIcwq+2rk+amT23wQvSZJ11CLrJ+NWvEb3yk?=
 =?us-ascii?Q?8yLbDOcZERrIFm3BbYCHQcrgP1ISn9H/Hel5QF6ddPCJ5GBip+BG4njYkVSD?=
 =?us-ascii?Q?kdEHsXavKFglTHqOpmlYmvOf18M0l3N4PvlB/0WFLCtWdELBVGePmqF59gS4?=
 =?us-ascii?Q?yypgx2K+OD63j9kV845FQWvoJH3WQhDfFU3jtBhPuYCoQEr3sAMyMtaxSAqF?=
 =?us-ascii?Q?m/N9e/CihBQtQfnoAgoTWFMYOFGPiXUMZzT9r0FN2Wud4MZaBgMLu0lra5vE?=
 =?us-ascii?Q?yq1kmkBKbnKuhJj6Jls6NcC/aiACp5xdjF3qXiveEvq5V9RAzwADXhlSQ0fJ?=
 =?us-ascii?Q?uyXYuRE0YeluruZV2ovQvh6Ij4tiBGnHg56apBIaht3uN/wiwRXvabjrPYg5?=
 =?us-ascii?Q?RBq/kRQIGjSrjdRyIYTduthin8PhqbEZwlE2z2rVQYLFNf3OJ5W1GqIsmM09?=
 =?us-ascii?Q?u75VYc5KHZXr0tMy4tYavggJmvobLa2meeH9AHzyKsX0jEGf5GdB1rCl+BEA?=
 =?us-ascii?Q?FgcEGFsl9fD8jOmvHkZYFMuRvAzyKhG61l2nv1LEkcRHPu9AxGd5OoBoSS5a?=
 =?us-ascii?Q?Oa1E6tY4DnLEUZhhBBovcRzDweTMcJPkLrIta/4qBg5XDhX0M1N+YsMSV8tt?=
 =?us-ascii?Q?D5BMgaaFy5LJ082Mxxeo16LUyKXxKsAl7u6PUC0LXJGR7/FI+Epwy8TZrx5N?=
 =?us-ascii?Q?l4Mjp3800SF9QWaLFFtJJeoT9r6GVNQMaUzioNss/thL9tbLqS84SRJ/Mqev?=
 =?us-ascii?Q?3Rb9z4ORHItpoH81Z2Wlj34Q+IXYRnK/noHhrK9cSZYPGUzJU/+poLnz/APk?=
 =?us-ascii?Q?BWDzT+igS3+OmxZvYku8eSfEPOWcvZp6jh6aQZn0ealj2t9WCodqANiuCfZw?=
 =?us-ascii?Q?8HeQdsx566yMQnjFo7vv/qgcptAuWlq/ObRgNhQ4IzCMjeqEQTsW19mUWEOR?=
 =?us-ascii?Q?T5zsoC1/tPoLkwu5xLIYSRPmCK+a9dg7hqsnwN/9kH7me1ePem6jY9WFnkNJ?=
 =?us-ascii?Q?UE5VG/LDlObIVJqpvkcLFev8ylWSz3umNtSFH89bSkuF2E9Lni152HAyxolu?=
 =?us-ascii?Q?hBFn0LoXuEgODsFXWaVfImCVnrfTc5STUL4MnBHyy8iSQ4QBe/QJxzJJ04jt?=
 =?us-ascii?Q?7W+fjvk9P2K4luGPP8JsyJfNttWmfw3P7Qwz+91/9AeCPO2L5AFYUCnGdDop?=
 =?us-ascii?Q?7to8AijjIzW39RLZ0SAHXG48Rq06blUZ516X7tHvvn8gfITmvt3DzWTwWxgD?=
 =?us-ascii?Q?kEUwEEJkGvpVO/77aCE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d13be4-91cb-49d2-678f-08dd51c83f2b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:04:25.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/mMfFOiY9dzce/yrqJQ8AkEhEZJf1gmpKzFRx5P+BC5SSbKaFrgBkuegvHQH917
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

On Thu, Feb 20, 2025 at 07:53:28AM +0100, Greg KH wrote:
> C++ standard committee recently AND the proposal from Google about
> Carbon, a way to evolve a C++ codebase into something else that is
> maintainable and better overall.  I recommend reading at least the
> introduction here:
> 	https://docs.carbon-lang.dev/
> for details, and there are many other summaries like this one that go
> into more:
> 	https://herecomesthemoon.net/2025/02/carbon-is-not-a-language/

That resonates with me alot more than the Rust experiment does:

  Carbon is a concentrated experimental effort to develop tooling that
  will facilitate automated large-scale long-term migrations of
  existing C++ code to a modern, well-annotated programming language
  with a modern, transparent process of evolution and governance
  model.
 [..]
  Many so-called "successor languages" are nothing like
  this. They don't make automated code migration an explicit
  goal, and generally build a layer of abstraction on top of or rely on
  their host language.

This approach provides a vision where the entire kernel could be
piece-by-piece mostly-mechanically converted from C into Carbon and
then hand touched up bit by bit to have better safety. It is so much
more compatible with our existing processes and social order. A single
language outcome after tremendous effort.

It is shame it isn't v1.0 right now, and may never work out, but it
sure is a much more compelling vision.

Jason

