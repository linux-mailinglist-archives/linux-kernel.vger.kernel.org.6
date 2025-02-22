Return-Path: <linux-kernel+bounces-527256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B04A408E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9387919C56B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7C14F9D6;
	Sat, 22 Feb 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CSUJkJ0y"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021097.outbound.protection.outlook.com [52.101.100.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD77DA6C;
	Sat, 22 Feb 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233728; cv=fail; b=b5dtJpO1uo/xaFOT4sZTY3ENPXaNz1Snos+lJS1JrG4zOgrgDaIX1TvYHdQdjo5UtYhPmW4rGj3+0qEQ52ln3qqtmbx5TS9ZXzyOzMlm+A2bq69aKTXueLXs48w1Al9VwkshdypE2R0oP8cFgOXVXkbBf/wfyJaxZjzB1TN8HTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233728; c=relaxed/simple;
	bh=M1j36ssUhpxc8QfqUaWkjK4GDQ2A6TWOUS7IEiJPyaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOBCSrTLf0vnknzoBO92jb2hTqccyH1KtaCWPrscRu8wRgzibLSlzdcBCemq9nMwNefDq+J6ThuviS2DY8SPg0ezQLO0rD9topWp/pnRAfUEegzLi99ZImtKixi8C3zwttnzRAP1jNDN+fnSpHdtE1N6CahGHkvnxFLLBoaNg6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CSUJkJ0y; arc=fail smtp.client-ip=52.101.100.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdiFZjXeSe6i7RE6L8Yb5OSpbfc9G3vzWPZXtauQJZYELTVAB+dqEwDHw1600rsXqDyHb3zeKKKpLQmjBBLGTnCiWxYlH861XWswCcb5WDgmUDs8SLLRLcAzApGmTpMbiwr0eOcEr7wtVexfzCKg9iKvCkckk5MtYRL8wfahqdMDG6yKpJCeJkDxazGin1pVM/GM8IwDp4FJFF6QW6NSBXdNlVncBEa+gaPOyazfv0dqlOVstrzZXh5FBP2AF2UesVjIIoho3nExLjskk3Rkj47xo/OxI+c0cYjCFi9aReLfQ/TVn9lPzr4uwgALMb8764FQgB6r3/klh8zUflTgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cpjdAVNX+V02KarxSUikh+knWLaavq2lgNoD7q+ZXo=;
 b=japmCFpxSQPSGNvdWDAqesno7Wef18jEF57Uxa3ggSMMjlQKtY/hVdZqqShc3dbf+T0qQTDaexH3TpgcLonpQr+qVU8PRTWIjt9dLO+bsb/n2AaEb2VvjxhArAkiqsjOM/0aZQo5advdUzEW6ZeqERKO4A7eHIbavcSyvY6yxSgp9Thz+ih8FsuB4ORjuO1G98fIlcGwgk1JR0TD5LxP+dhYqRYHB9H1j+7DggNm8Y76HEUAz8bX8yUmtvziLcC9By7ELy2IQ9a8m2O5jj1FArkhhmu72eEcGALPLTeTnTObb5YWyOm/u8Eo+qfHbiKcpgqBzuVPzyyZbJgs5cA8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cpjdAVNX+V02KarxSUikh+knWLaavq2lgNoD7q+ZXo=;
 b=CSUJkJ0yI7L7f5LMwWUKRYYazZzKa79NNjNersTmtpRS/E3mFzcwLdUeVevaUhqPL67Ha9PLmYi/DkYih2dNMhs+wnr2owUQdBabV3i9aRVK4m8iDJ1YbYXFOPYiTIJJi3GySvRXlk6CxtzkZJl99rJeOIstrR1cGnNDF/x1PdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5804.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.14; Sat, 22 Feb
 2025 14:15:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.010; Sat, 22 Feb 2025
 14:15:22 +0000
Date: Sat, 22 Feb 2025 14:15:21 +0000
From: Gary Guo <gary@garyguo.net>
To: Ventura Jack <venturajack85@gmail.com>
Cc: torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250222141521.1fe24871@eugeo>
In-Reply-To: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fe04b3-b581-4dfc-74a7-08dd534b5865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EjmMgECnuSyzsy5HRjwyB5NwKscrdSHhHco0jhGb77ADLNBNVNILmCc/7LFn?=
 =?us-ascii?Q?VQEMtON4hUI/HvPV82iZwaft28IEVnb5AendigBbulCUjy8aFDsJEJaCfLl+?=
 =?us-ascii?Q?r/53ydhaBmimD+pj3thMYiuhXO75RAR59NM8EnWj0CE1Gmp9oJLs26KH7/dU?=
 =?us-ascii?Q?y+tK1QRPL+sVnAIx1SG4EWpkSJe7U3H/YGLqLbgo+Yteu68gxjpwKtejO7U5?=
 =?us-ascii?Q?U89hardYOt7x7Uq8mn7qlnHGwjjOjJznH8Bfh/CQa25VlVrBBA8TqIf1RAcm?=
 =?us-ascii?Q?rhLLNYwVIDdtsKVttRtFWeSB+oePVX1i4kxJrBNnz2kv6MZuJDIoX6dCgx8E?=
 =?us-ascii?Q?oJ5fmR9HTQhYGL9xxokDPdSDy1U/bS5PMylbyvyBZGDaL4l2sYiJIOw9MhXG?=
 =?us-ascii?Q?vOawIs5Mg6cPHEvxgyNKhk6spGC7oQ33/m38R0HLhReyvCVqYE2fWXoyD1pb?=
 =?us-ascii?Q?2F1D0mrgIPlCUCXnkZ/K8LEILMFmWUQFnPqJnQfujp1nNkUZxEHJWfEMmoIg?=
 =?us-ascii?Q?HdplScdpX58zUlWRLlQtTRj/I2Lg/XRPQQuKDNzp1ouzUgtEdRBxIbZnZGmj?=
 =?us-ascii?Q?QX+UhA0/MWDKmRBhPCatheKULkbmscsV2H9nsE6T/qcgYtOj+mr582sHXFpy?=
 =?us-ascii?Q?tY3AGNx9cByV3YNxAB68sbFTRvxPGyxlbPYcwCx//10zc5uMHn9oc2LAfOgq?=
 =?us-ascii?Q?jnCO9ye9nkpVkOnW6IzJ/w/WbC0NwaOP/IOct5o1ouTbWsKXdekhj/sFYK9W?=
 =?us-ascii?Q?kZh2Gva+1Bq+xehQ0drx+oN1D/eCjVqOsFXShzdcvDtTRCw0lAUwJo3v2SHl?=
 =?us-ascii?Q?Ao4enjGeeaBrchsn9Eu0thmVx3KZ2nvjZUg121KY3SiM7D9TPdWImqCshTVA?=
 =?us-ascii?Q?Pnx+XNsNZleGjwKNLzONLEy40dwTkUnKn4ZT5GybtNv5+U+5wzJkD3m0j1XP?=
 =?us-ascii?Q?7T7y/Vy/QvmwhM3ISI94YMdbU0qJhMDzZfH7V/7VplCNzGzND3iLsbKkI27w?=
 =?us-ascii?Q?7jisGDB8I7JBKgrjc3Cy1+2s9DBNiqY4mM3EEhwtUon/W2eLFGZ7hE4Wp49w?=
 =?us-ascii?Q?GN2AIxdti04RakeSiVxRst+fjIyUpG4l41allmh/b4q0mkfSBSLCoxLXbcqr?=
 =?us-ascii?Q?lGDQvVi/Hc940mmY15eN+lhKDJWl8916v1Tb2p4PNEa6/H5HGnuLaTnrWyAL?=
 =?us-ascii?Q?2LFFm7xd95B5VVIKBFLyk8bfIlnaa57Ipf5gZzdNMdlCgGMXs4T1yeTCnQdG?=
 =?us-ascii?Q?1g99C8Bl6qsDP2xa4Td0P0yDcATuom05Qww/p9XovYYwoggFekw3ab2uTf5R?=
 =?us-ascii?Q?CXE8RK8BzBk2e6q6omUqHIJhVija9EYTLfqTCq8h6SeEsd2cwAqLXnucthQW?=
 =?us-ascii?Q?e24LN2kR+ljkE0cg+EicQ8GUc88J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJmNnySrAtXwL3NFMTqLxWbLDx+dhwwYOwuUnmJd99JHxhX0KtFIuDc1vWSx?=
 =?us-ascii?Q?/vhSqnrzBGfDN0kib9K3JckuNAAmAk2xyMsgs0ECMuTveNs72JFCZm3GxWqI?=
 =?us-ascii?Q?oICxH4TPMVzwQ+7ypylgbkeT8gknzwz6VnBLWP2JxjFoLKs9AXwchj5qffvj?=
 =?us-ascii?Q?bYWL9o3VMaZ14qtXvBHR2OP5DkjejPELG74GGqQ4BMvzCV9RGz9kbwCJJlBa?=
 =?us-ascii?Q?0VNHnoz8vxPINKjer3S7XeaEQ88n7KxA/yeEftpBaXcDBgp8pDCHKFKQl0d+?=
 =?us-ascii?Q?xS/jN6rzjWbD+EjsDmGb0ZvapuaHtrfQeC6EWpRWpnRZpoiM8QW5vLnhjhfx?=
 =?us-ascii?Q?OOLyjbG78J702vQe2BNCQ3Bie4VjmBr+l99g3MF/7HQrbf/U6YMYXIYHhrb4?=
 =?us-ascii?Q?qDyUomG/wsS2td9dHeTWPXjgl9vPIyTFocs1K4EtNLQF0821yXT1lhYGA5wc?=
 =?us-ascii?Q?8JIDjl4Ce1BkCAKJ3lC2PD7rHPJNpHcZolyhR14egrAla4ywfrhAglusBpjU?=
 =?us-ascii?Q?a5pl852e3lIcKvliEJDubwtTqSSOFurjdtJPCHGZ6kmhAtCzeYS187tBsUko?=
 =?us-ascii?Q?VsDKpxUVLEE2vyXf/5roHcqGg663z9f352B1j3KmL8etnDcfKjOR9Bx4So1T?=
 =?us-ascii?Q?T0POyLx9QhiBXt0rtDntPwN2y2/cWV/wOCxTJDOy353ax5Z9KfbnMNyX8AD6?=
 =?us-ascii?Q?B44arKIW4ZiN3bdstV2WDUVFrozOh97gFTUV7Um8GsHUMrARuD01N/fUwwS0?=
 =?us-ascii?Q?EdTW5InklI/aOHOp9LnVuv7uMs2DKpt6Q/S/eUlABMb4/B7no75l8/G7mkJa?=
 =?us-ascii?Q?xa8gMZB63tdrH0zKMfiqdACo8p2FQFkRIgt0vbGdyqfnTQIN6NbQlvoCAd09?=
 =?us-ascii?Q?3EFb3CyMpp0PiSK+thmL8ltjpbNwYpCuycQcvssItNPkneqnTGW6Rr9ferVU?=
 =?us-ascii?Q?kmm+TJap3no71olRFw2fs9/wUtYLavOv5fgYFa2Lc3+2XmWvJNNKf2gBo3wU?=
 =?us-ascii?Q?tPSjQE6zy0C5cqMy/zwNtCCwXb6qO3Xu7RKSuckvG9ytiglBS+nCEAdNSDja?=
 =?us-ascii?Q?pDmiYz80xGtZ35JbpxgblIFDYmPba3BIu3hp+NncSqLBhiXA1Mk/vDqbB6VJ?=
 =?us-ascii?Q?b3xFaGsY4fH5bF4/jlYrYl2kcaqsJsAon3KerYr4DU8FX67MCGt6AA5rVTEb?=
 =?us-ascii?Q?SBqSAVLdVTqBomtod9gcDqu+B3ml819l1GmhZzadiiCBTDbe0wE2G25JgjRi?=
 =?us-ascii?Q?/Cbi5WjMx1EIT5CBgmNYCF9gL/jfwbUOqoGGJJh/kINsCjGwm9Ng98gw25Cd?=
 =?us-ascii?Q?wHQsZh4oA3P6WU6aBPAVg6snkgbp4WTfL9/+wT9SpRe0T9dEx7aiHJeVyDWf?=
 =?us-ascii?Q?qXIf4fPZ7T4EgEvb5N5wFa4ISL4G8QD5u3jgHNAU2crlCummAVtXKQAGHwu8?=
 =?us-ascii?Q?v44bTFoJ5IT0Tt71cfE0kA8nnlkxOHKDdvLtwu7NPujc2lU99jSTbnKGgzYA?=
 =?us-ascii?Q?KdwrqcNOzbUnCFYzJdOrTUaoUg+b81agPJA3UD8mdDjfT+oZnDlaKKBuNnU6?=
 =?us-ascii?Q?TbMmZgXmidLQb3+gs9gwrwRxkR+G/8mT8KVJYLw9p+7zksUHFxfPlVsgp85P?=
 =?us-ascii?Q?mA5nwpahD6WT0fY4osVAe1DfWG11oKHpr2DIDo+tcUeD?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe04b3-b581-4dfc-74a7-08dd534b5865
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 14:15:22.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ/n9K+e6STNcs7da/YfFztX8wzENBn8E9Ut7eu8YWHv6ecs8zpYUUz8i41g0RobrykB0kGqPnSaNgMJXUKJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5804

On Sat, 22 Feb 2025 03:06:44 -0700
Ventura Jack <venturajack85@gmail.com> wrote:

> >Gcc used to initialize it all, but as of gcc-15 it apparently says
> >"Oh, the standard allows this crazy behavior, so we'll do it by  
> default".
> >
> >Yeah. People love to talk about "safe C", but compiler people have
> >actively tried to make C unsafer for decades. The C standards
> >committee has been complicit. I've ranted about the crazy C alias
> >rules before.  
> 
> Unsafe Rust actually has way stricter rules for aliasing than C. For
> you and others who don't like C's aliasing, it may be best to avoid
> unsafe Rust.
> 

I think the frequently criticized C aliasing rules are *type-based
aliasing*. Rust does not have type based aliasing restrictions.

It does have mutability based aliasing rules, but that's easier to
reason about, and we have mechanisms to disable them if needed at much
finer granularity.

Best,
Gary

