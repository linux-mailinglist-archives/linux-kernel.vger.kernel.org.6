Return-Path: <linux-kernel+bounces-199097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E0E8D8215
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91A7B2213C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20112C7E3;
	Mon,  3 Jun 2024 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TPBGWB9v"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24C12C481
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417140; cv=fail; b=rSFs8t9THuYYye3RypBc4DIR6/38tgunod67sqiZ1JIGIzyu3AjaY8tp+GBMNAxDX1uXmu5h0OYil9cicnw33bHaZ0KYTpiix4YsRbsamj/TmFBZv7Cw9meSzLq9OJ6YgHsxjkb8bXVHdBv09gQBmIiyvd1Rspw2a3wpqNnc8Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417140; c=relaxed/simple;
	bh=QkGSF0l/x/nsqtadY0jTMfNcTWToFE8eW5fCe081VPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWUre/3hySZC2c2HRCr9opdpmh41ohRtx8FpgU5JsDO/nbY6IjIPIYwhN8lI4iTkcl5hk1HnRfUQEbDqG17domt4TIXbKMycWPo9ijyTXswCG4AyAwJ295yd3PVULhfKq7+QMoWH+sG3cIDnsR4SqepPoG5XmGKaiLTtw2pjxTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TPBGWB9v; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpmCbg2mczwEcJ2ZxCeifTYkefwaLW+jqKHATFbWX50S4IH6wpXoV4FyCtyWL+2jFrJoLJ5OP1Nmm/avi/CrFCMM302Y0EXgoZ+7cKWiikCKWsigZXY7smo9aCPHcREODirHqRjDeUKMSxlUAkBMPrUonVxPs8+wrvexV7to6LLF+aqep1JSPdRjmnWh8/CVVqF9TpnCKtr8VcbKh9gpAhoLxeKkkty2p8Qm3ouPfCiQi5AOeC446nSZOWMSlvOEHYmnn+rmPBHq8v+otuy67dvlBceT7jNDlh7ZrfC4nIZ2YIYoxQZ/8vrVDx87pOW4Kevrmx7QjexY7wT0RU7UjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkGSF0l/x/nsqtadY0jTMfNcTWToFE8eW5fCe081VPo=;
 b=hliTMp8OyrKYv5J80WZxOihcb2OOzSOLC+nv56sVKObDDhNfDWrTt0THvpN8IuXoNe2TY7w2IHwxz0CjzwU+B8NtRpSXpE/FggArACNdrgwnCQcEGvt6BWVVJ0DvJavvUmgnB+S2COgfCzITgti/SS3qRwccxpmJr/1xw4IlHlnEPulH12AdMRazKHBUKe3adNXLtW1fMY53DtO90GUfbVVg9g8vNpRoqvOJdYBbx+LxwPrb6hOUBILhIWSRcRdKcrmOQw2gs+QdrzGZH+B20FDeEY/SgPXvqG72mMmh1IQQX8kzHRsBwOxp3CGzTs0ahblUZX/UIvx76LIpn08EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkGSF0l/x/nsqtadY0jTMfNcTWToFE8eW5fCe081VPo=;
 b=TPBGWB9vCUjukXN+iDK2Rll6b5vdXbAFNy0LAoWGgP5gasoslTIWniNthe1HqDcV7Oh9hRRd8tSt4SMqF1oxk5CrZGapJSHi0It/uOAgFE1WCLL9DLyL4cMf4uX1VyoZjJTbqMQP4xR1BWjCnNVjnwRhU/vMVppNV35uK4BC9R2QjQn/eTP2pPw4Km4iMgmXaoefRUXfyCbVfcSP9x7sKsy/f3Zg0ylvGWxftk7XnebMDIDqCewjSXWdwVZm5i7NZv5r/rMb69v3aasBkSpp72b3Kf1EYfh89vEePFpD6frTwXdPtG6DgugAM6WXKMmY7Fe7GcvsBHzcz/egQVzxKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 12:18:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:18:55 +0000
Date: Mon, 3 Jun 2024 09:18:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	=?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
	danny@kdrag0n.dev, mic@digikod.net, linux-kernel@vger.kernel.org,
	joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
Message-ID: <20240603121853.GA19897@nvidia.com>
References: <20230601075333.14021-1-ihuguet@redhat.com>
 <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net>
 <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
 <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
X-ClientProxiedBy: YT4PR01CA0480.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0bf52f-f4cb-4589-ff90-08dc83c7562f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ltRKEuCjVRNVJMH9csAEexZaQ0bKUu5RRRPkCpP+k1no+plWgsYvsK+r7C0?=
 =?us-ascii?Q?LZ9Nfk/BBlNKlkrsxWyp0Deqa29tqidVu0VTR34HMRItEqq0Kh0JhyIItivu?=
 =?us-ascii?Q?AoJ2syg1mu+wUQh02QA/7Lj46U5iguEtQcQ057MV2q3ufSI2wPyVVFEtowdT?=
 =?us-ascii?Q?VvQrCdw8MFcSBfv6/MoGXVZVXdnZcoZL1lBtT3mMOjQkfyTUUpSa8dEZMBEm?=
 =?us-ascii?Q?AQrdYdirOGOgDeqwUA/4kDriOBxaL6dGFSIgQZ9qLUgmAkhGnrAzzwg0Ttkc?=
 =?us-ascii?Q?8hNtN5xSY2P4bionsdMa7u/Md8gJOwdUPBjJtfJwiglYlPCsa+sIdj0555ML?=
 =?us-ascii?Q?CRwgEvxinvjp40tx+mwBCfKYkKwQMT90It8TA7T2HgXLdjAXjNFEeNugoYJY?=
 =?us-ascii?Q?YXDRQuMmC7uG3zskE13YzJhJAqMEafpu8wJMJoZJJkBqPgqTDeCcvv6OJ4u5?=
 =?us-ascii?Q?m5b6AwFm4oSAZ4G2X8o88h0d6wg6UMDD85NEB9kZh//EXaBOK/n6WdteTe5B?=
 =?us-ascii?Q?eAPLE2dMsEuYpdZGIiUJrnzcHeNReDLtNWwbNreRiJ0QYcuZq+wDuUNAJM5n?=
 =?us-ascii?Q?HIDGeUoEXz1zpTv/QP10cAb3qGstfCEJQfbpOB/IsV9FaeKgpH1v4WGoiMbj?=
 =?us-ascii?Q?GTXTgQ+c+ueYAu/NtRhq7NpH/Lf1n9kiEKU20Va3wWM2x98BM0SZcSZtBBcu?=
 =?us-ascii?Q?zcolCHcOoMslel1C0T5SW9v7aL0gU2tExvhdM09Nvz8wbUvzTYoZpM+7spKH?=
 =?us-ascii?Q?EycXrw/tsgHx0FjhE4jxC2Ju+U1wxBu3duL0L/CDVo+YeT9zzDCpTqLsGM02?=
 =?us-ascii?Q?rbT0WGxwPHc+Zbkro1TbLXN8qXl/OSJ5yL4wiZfpnThCnHrDP6+oSf01c8JZ?=
 =?us-ascii?Q?NkkNAP6z9eK7LMkBk/hXLbikFoRzr+inCnYAKtSfo5IONUUtDiW5euIEL+U3?=
 =?us-ascii?Q?0VdU8RdxwntBkslDkDs4AWmTy4nGL46mjDXHCaWQUosloWNOI+eIiOSn+zNW?=
 =?us-ascii?Q?S6s2a/BdwwO4K1j5tXDgOJi7O7tk4EGthTBzuz9ExkXJjxC/Vae177jpZmbI?=
 =?us-ascii?Q?ybHNn7sOWd/rO0Ko5xDBd6NKpAJnekH2SFBw5cXSsauXefsIvC0LrhiH9SmU?=
 =?us-ascii?Q?Zv2rXRuBcGx2L+hKqp9lar71YaRIuyIG0n0KUWIyC8L69Qp+HKFMRK9bVN6+?=
 =?us-ascii?Q?ZkWTRjtAetl/iHTMvdoGPc2j0yAWbCY3joKUTi1jrBQsSB8m1EBDb9S/RdMe?=
 =?us-ascii?Q?w801FfLZloYT+ms27dsH2PSwGydE5w7EfvwPHwIVhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cG/esBxDgRlGbQFpu9i8d8kfYB1vFM5DVYQFOM2JglyYKLahkTl/pVPwOP8v?=
 =?us-ascii?Q?RgIs0V81JYvde19+KH9VHlm3bVXEsLIOY7kgMH1qXAehoVrrUQZ4eoTc/8K3?=
 =?us-ascii?Q?Ghca2z5V+shKkjIAEWKK4Jb3JACOngSLWIT/HKXU/2iWsBi1pp2sdYrYdeBM?=
 =?us-ascii?Q?kcldbO/4V2IGgrrmXuxq4dkTrXuAuHrsaH+bFC8klQJDOhcdrkKcMIl5h8EZ?=
 =?us-ascii?Q?GuOm9i8mr1ccJpk/wmMxx+k4KolpTJu+BE9zUG/mFy5IrHpV9wVlI+rnKNmO?=
 =?us-ascii?Q?6KKzl3NIXM9OhaHusanMtgaeVv5L9yqY/bYTzjqmuVOv4kgwjbU+ZdqknzNI?=
 =?us-ascii?Q?GdoALAjxj5/PfBJNDbJL719IaX5DnW4a7f2PJ8JCvkyEEWltVzLjK+5ipk3E?=
 =?us-ascii?Q?HC+28Y5FsY6kC1RZQvT3S2EiZ62j7Q1V+oEROY+gVyB7pNkC8Ei+WP08iEqn?=
 =?us-ascii?Q?KBqFXDduoTMk1U3WflPMir7YyWy7+aIQsIr+Encb+yrRQsn+7fp/M+l9UPhC?=
 =?us-ascii?Q?7Gvq74yfvvG1RGNimptoy8RbQ5kpp+sE6bNIf7qZ2CbMGWmvjfSL11R8F7nK?=
 =?us-ascii?Q?UQ4foXp+3F/FiI0HPbu672/HydqlUMtWoeFJPLrZ4Vrz6Zmym9BOxBbNDME/?=
 =?us-ascii?Q?rFl13yS6KWoM8iyeGlP2T7RA6qvzwXHC2QvRw0LsVaFXGvN91FH6ylxXvd03?=
 =?us-ascii?Q?PyetgDWuDWbQvtZakYdY2pHp7lnX6QJjk5oEO+tqZLAjKXTR7dRnhLjSA1Eg?=
 =?us-ascii?Q?npY1e3sQNzIyifqKBBzjBvrlosokKw6JqRcjYMxUhnRfvEwroEKoLB33JaL4?=
 =?us-ascii?Q?PhYchi8x6Cx5xcXD9vz6Ml4hCSiLYxxVSvfGq6ncQGR2+FifIXwfKDEv5QBL?=
 =?us-ascii?Q?4AQWGh4CKygjJzP1HmwQTY3QNe69Nwq5I+e//V4RZ/dXKwy/Hi50nY54bx6F?=
 =?us-ascii?Q?JBcyIRhyMvl+ZpReqa5tIVqDzvPsAMfQD95P/Ghrhw9iCcgjTkr6ulldTSjD?=
 =?us-ascii?Q?vO9BPivhbLk8cmbRDUFaAqjEJWscX89k3Y61wC+dsZS/miNJ1IhDH6OVCrA+?=
 =?us-ascii?Q?aGLLVu6U6lsatL2koOOrWKcwWR6RD9IYSSKGaYl2EGCmfcqlVPKOJ2UL3JkK?=
 =?us-ascii?Q?IGhkIMHW1yWVDROwVHUhdHZ0TSqILpsHsmyJDnGEJgwdcDgtvB6PvgQ4rgbs?=
 =?us-ascii?Q?7Hi0aClGfwP83i6UvkoHUFIBcjZQ/U1eFwX/gUZmJZ9raqYCjogUojo49Yr5?=
 =?us-ascii?Q?HLPJnr32KHFrYbVmnUHDew60rs2J/gqXAUd7AuMu6s0Fm/33xvKk6rF8IDn6?=
 =?us-ascii?Q?Almf2X3KsVzNBKjhS9C/Svr0ejzTj/TTBd+hATMC6Y6b8Z/W7LHtTdMyFx1g?=
 =?us-ascii?Q?j0g9k85H+3qejOTvd+GygJDfBIjO1z/ooyFMur4uCh3pfndJBBY36GpByYS8?=
 =?us-ascii?Q?D/OowoaqHXd7plCng8NE9O0ByAz6MrcgjxVbs7v3giM+m4Cne/WLaQF1RCZU?=
 =?us-ascii?Q?erZeN0gARt6cEVdIRbjluMfgJnsZ/kYXGhjsc9WaPAeb8vXAb1MPFsKEoUeC?=
 =?us-ascii?Q?METmA9p+bYOZuYtc6EyCgdpTcRHfT1kNbBUIRSw0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0bf52f-f4cb-4589-ff90-08dc83c7562f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 12:18:54.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ihxWIVJo4w2Wy7Dou6QpHSAmKnhyA230Ta4nbTONRzvleTtC6+KRzTh+9nIn614
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

On Sun, Jun 02, 2024 at 05:30:51PM +0200, Mateusz Guzik wrote:

> As is I think the config mostly gets in the way and most people have a
> setup which does not use it (for example my vim does not). Alternatively
> maye it is neovim which is overzalous here and other editors don't treat
> the entire file. If there is a way to convince the thing to only tend to
> whitespace issues in edited lines that would be great.

Yes, I think that is quite overzealous, I'd view it as a vim issue.

Jason

