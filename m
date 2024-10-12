Return-Path: <linux-kernel+bounces-362007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA799AFE6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D896B227A5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25FD528;
	Sat, 12 Oct 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fITEmszb"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2105.outbound.protection.outlook.com [40.107.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759053A7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697676; cv=fail; b=NZmDz9xeyGsevdmk4RCZO4qpYIeQCKo+r4fujHq3ZBtDoRhIPZ23a4CMJ3/TmODRbTykmMrzgM5vgRoxQ8VpHDuMAPAK/YqvJcEyEabMr3YUC7xf5wOBM+aRmy/ZOrFb3T4jDCawgM5FcZYXlKZrnsL35pzKNrFB4/CAkkPJZqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697676; c=relaxed/simple;
	bh=NJ4pW2O0HO+g0v/IXlFB9BXTzDDDjjVYzSfQxKtTwyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgdsSZBttjbEhf4soiU7dpO1I7NYgtDFQMzhZ2zlzqBVwB8M/U4CkWBGGHB+04U4nZJSMgp9kplhmhI/3S+oQYGsMUo9mWoqwWnl3pMhvmB9MGB/0xB5FDaoaeTHeYYlDDLUhqgfDNKKcBwEGbH0O8YiT4yPmODEbXNlYDPbiFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fITEmszb; arc=fail smtp.client-ip=40.107.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nckgqjLFMSb0RetvmZB6MxPt0SUlgRkhXN5Nh/3NCwR4wg0kOcF2ogLuYVjTGRgIQXiT6AWRSKEMbCDIqgZj6YlmWfX/89NlgpbOH7xPPzu7pmAeT7YFlohsdAqML+13BuoGVmSf42f+su74q0hrRKji+OuZ3R65yN+1O2dGa+xxiO9KNdatWAS8gJMPtXUkkGjs7S7epJDDXTZcNlv3QVWrhgpzvDdEPN7YS0kS5mkQpwDGL5l1DVbuRYpJUkVn/5TjrU12yhgBslzORMVSmgiRdhs0HYbo3u1hk/RzINHKxMQ/PAGYzPA2I0RMJuzBtvY62hf918cjK0QjSPGoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wjx57DGsljkFbvnSw3RHXy3gf6W0Y8/jGxWoqb7fPg=;
 b=Kj2MFm8m7C/p+xnKyeouEBslwFvm3Ex5IYC/BQh0O29ILXaYhCrMB80hIrVSHs7Yh9d17b4IH5maf4TGLy2hEtzjLlC/w6IYzGwxBf0D4RYpLUt0jc28ODT7INllBUS2Qxm5thBnp9/R5ojfpO4i7jiUULzZ6cU9EpEzYcm3KzZF8OKDy9z9nnolZhuz0HLfIcbOPKi5Hy+puUhhaS2KyprmAf+GPX8IMnDX+wkApx7+yjO1mHva+XCptH0Ps8/sY2Xxhqby13z/leGF8ELzSNA6qTy/ND/XQQKR8hPaCKv2445HsGGebMXhxZKxS59viNnXewCpvjAZyaeLl7s4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wjx57DGsljkFbvnSw3RHXy3gf6W0Y8/jGxWoqb7fPg=;
 b=fITEmszb2H7wZ9Vyl+HxHFSn0O+0lwSXA/PgGweImjmE4pjF8jQJL+yDqjZeuXkTu7DedNzZp75VqowWZRYHQ5N9rYxmvwg3ZLRf14A41lGcF1HAUph253Hogfnkyl+6z/z3rR3XXlkP2DyGrQGhSBQx2eVb0ebR51vIhZxTBHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5545.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 01:47:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.013; Sat, 12 Oct 2024
 01:47:51 +0000
Date: Sat, 12 Oct 2024 02:47:45 +0100
From: Gary Guo <gary@garyguo.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>, arnd@arndb.de,
 kees@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org,
 ndesaulniers@google.com, ardb@kernel.org, jannh@google.com,
 song@kernel.org, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, yeweihua4@huawei.com
Subject: Re: [PATCH v2] kallsyms: Fix wrong "big" kernel symbol type read
 from procfs
Message-ID: <20241012024745.3807a071.gary@garyguo.net>
In-Reply-To: <ZwmgKHxgl2BQuKp6@casper.infradead.org>
References: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
	<ZwmgKHxgl2BQuKp6@casper.infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c0a418-b93e-43bc-70be-08dcea5fe1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fXa15m03qb+dRnLKtqYS5KgUe5qv3gB0bQapeYUF6pgI5MtmhzfPF7r5uhE?=
 =?us-ascii?Q?viOsavbszpE2eYcMdrqObuh0u3K3BsPb6jy1RYWiUxF46R8HUcCKl6ObXwMK?=
 =?us-ascii?Q?9O5Xvx6IwvwB7fcniqNwu2jGB8aNfs972EkexIh2dKd2CeilwJ1C57SQdMlx?=
 =?us-ascii?Q?oNkFBDdlmM+Ea5xDUJ57P3Iboq3KPmHNpofaD86ckXEYMzpQcMesHH2qhSM7?=
 =?us-ascii?Q?p00y6U+wzgg/aobSdELnTKZ2KBZmNcRhPGjnN4XGprbRqFukq3xuG1ImyoZo?=
 =?us-ascii?Q?pW1/tvLObrhphKQSzq2xQBBWk4ouZ11cpIUBpO5dq5Jqi2+1Ct4RKyV3As4E?=
 =?us-ascii?Q?ufvCUqbGRgdE16RZauj9tgwG714gdnfY9Ta/Xz03VRfMLEQEw6CpXiGdqaZb?=
 =?us-ascii?Q?BdR3+p0v3e657p57JkmtCW6SRB7v68lB19REueZ2jI7+R2AYdZu8cAdhxCE3?=
 =?us-ascii?Q?JQlb0Q9Uswv4t56vQGMq3dce5QdWkHIGRz5xj/RyqVo2X94c05P9xe0XlRRf?=
 =?us-ascii?Q?A/YL9gizBTQlE+fPBFkNHDSKtmQ4CHng/QqW2uznDVZzMltDTuMjAdGNHOQr?=
 =?us-ascii?Q?4NSRcDLdii1/J0/f33YqieTweOdaEStmCshM5WkKcYbh1Vu48n90NhivPRha?=
 =?us-ascii?Q?odoIt9TTaei4XqFDe4huILYoaPyTRwYolzQ3ZQpkueWat/LpcqbzEKfsG4nH?=
 =?us-ascii?Q?rNn3QvcOJdRW0ObsKJ5v54zm9z6y5yM3cSWY6TS6bBiBlJ5uj9eNIMAivVDU?=
 =?us-ascii?Q?NDl9vMzL9WwHnBZrJj20WOFaSRh8kg7dPvJA6j153s6iOfL8ttADH018skeU?=
 =?us-ascii?Q?SwgUVqPanvUOeQcTaS6yxT0sBAYY916aEYGREJ+LL+zIp5RlGnUtSGuoomNd?=
 =?us-ascii?Q?IHziXogEKVNXK/QpxYEHcRYZ7X5Q0BEVa4gJgwn8KYh/+jOWypCy94F5HsNr?=
 =?us-ascii?Q?BtpMxiEpNwyqUpKBpCAyUmpuTiIyNXhDKkS/loldcJltT1E74HdJR8Nwup2n?=
 =?us-ascii?Q?//Xhk12MWKGtNmhFAqRW7VEAFytCJEMxv62B2Ny/e80yyPLq4cslU1FL9+9H?=
 =?us-ascii?Q?MrytNqx8h7D120iE8HIRHJ1wwlbwNiDfcBPVYhK11nbGm7hbvDXH2lcGuEq+?=
 =?us-ascii?Q?JvlMS8UqdMr8IShDSCLMnCk5Nx7uUlTPilopqjgEdxaz1B8Dg1p/0KhO3ihw?=
 =?us-ascii?Q?R41UHCuzsv5Wcg6klmbQliVNpS/Te5gRM0f3n9snwJRRgNFsltFBzrDEvpSv?=
 =?us-ascii?Q?EAuAzbe2d/MWQ65u5vW/GHkAFEQWldVV3UuGkfZTgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RY1YHCBbi9hColEWjsCgsVD74Hxtv9Lv4rP0UqBlaodBO3INq3YiDBHNWQFr?=
 =?us-ascii?Q?/goBp9uSS+XUhE7YgIkTWOaGS3nrYKl7woesImYAvpXDQenDiuYNIZqP/4qn?=
 =?us-ascii?Q?rYVgNesjWiTJex9t8ZVAtB6Cm8na4gDeHc1+OL5/8yWf55/NuXZf1CqeqHU6?=
 =?us-ascii?Q?kQxCrSL8blYFCekx3BOm9b11qGc5qRHPOiGPshD5usS6sqy4Gdr6pmBvxDWs?=
 =?us-ascii?Q?yppb536nZUPLHSbAcr1V9AjYTEV0dKr5Ot2qoh5gzDl69RfBrykFEUhEqtnf?=
 =?us-ascii?Q?NL5lXKOEKJ8LbpOJMKvUGByucP0xLtqIZjrIh8jutW1YRPuH6XGjCHsebDm7?=
 =?us-ascii?Q?QYQhN8n7sZ0AN2UQMtIWgoIPD8HzJasrnxuu+oMotiePVRZHdBjtv6QlX8+i?=
 =?us-ascii?Q?/ywxioAauvjYW3OMdDQxJiiuYBnWNWp6K37PANzmG7TjCQIVCAOQNzd108pj?=
 =?us-ascii?Q?e3NqWdFiKB/JiPOSzDCwezAbHpdZh8yX2C5t/DbJMPg4uZv05tVjeZLoZWH/?=
 =?us-ascii?Q?grUBY1lzR4Q2aFMq+LaCgRqTwnP5aTWvwzIHolNFpMAP6Lj/xWr+/U42+GXG?=
 =?us-ascii?Q?DTCQT6ONfjT/VUONNJj6nTp7tkwvpd6pV/4IJtfUnj8hj7pJW7ZBth8HpSZM?=
 =?us-ascii?Q?JzXJTd5gZJoZTS5q22W/ajUbiOoCPi7eJFlvN6DdHgnb313jvVGDNpH4Hi6U?=
 =?us-ascii?Q?tEYDA6u7D6U7D1Af5kQBhaJPiG0D9OoBwf8QfJxH+udTfICtee6e+kzjvgPS?=
 =?us-ascii?Q?xyN9tp32NcekklGiozc7iQsWoXGpJBrwj9oIVOA31OJQ2MaveCtN6UA0GcUx?=
 =?us-ascii?Q?5XlCgvOy/ZqG/aZNlsiBFV2Zn6TaugnOj4dwD7d+20J8ZTILePKzBxmfras8?=
 =?us-ascii?Q?RgfjRD7g6VEpOCaN9EeuHlsyl1zTemozucydadGRUiO5IxxjluDgzOSuKQxV?=
 =?us-ascii?Q?BBfxVB6VHR+rdDEQmF+iW0IZCqSnarSJ09GIgdMdtKQULgpiyIJLCP68Wsu6?=
 =?us-ascii?Q?JK/dsr4CzlkLjImN3aXV1ayyPFqGAb/mBAsSPG6R0NFDgeJ9MsKbkTLH1dKE?=
 =?us-ascii?Q?iDCYuhmj4Bfe28qqEYrQkV42zEbZj/pRJekvntkmCjiOtJ4CM0lSBSJX13S6?=
 =?us-ascii?Q?dLhkUEoSW6+amgSQXmviHr96iZZ7nB+AXkkTUWkZkPshYeoOPQzLTPy2iqKA?=
 =?us-ascii?Q?AoAgXcpajVUgFexOEAP5tSwC0t5OKSVsIa/bl82MJ+XJgQVp6dkLon2jdHol?=
 =?us-ascii?Q?Nt/p7qJMvCooRhxiPIzOJNPYAU9cF6wcjV+8IHViZ6V9h1DJn3fjXZ2yqm2a?=
 =?us-ascii?Q?1OnKyb3xAccKGkLKcFx6iBslJ6guzoQW9GvnBnb7DM5xvhmztYNSOC7XUf5s?=
 =?us-ascii?Q?M5Z4SjCqb63gmUgvlRw2iJJqR2U1ckzOYx3oBrOMJyBLxuTS3kf6X1ZL/xuV?=
 =?us-ascii?Q?/cYO8FM2Gn6tt+ckxX8WF/HMLeR+PViG2Qydw0tHb4qqxGIcl9saJrqPDoAt?=
 =?us-ascii?Q?gD9bZAM56tVrsL4D8j9usQrfQkQ2w+x9aUkg7p86T6VcwKV5DA1HjWX/NxMd?=
 =?us-ascii?Q?ohoO6A8ehGnAdhJsbOYA8AACd8v2plR2zV0I6hpE?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c0a418-b93e-43bc-70be-08dcea5fe1fa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 01:47:51.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrUeWfceypwpdFe0roRMqrtKRPWWsNXNnopVK2LRhCdR7Ya/o8KzkL+BJYwDYp322KXxCql8DS76lZDr/ALG6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5545

On Fri, 11 Oct 2024 23:01:12 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Oct 11, 2024 at 10:38:53PM +0800, Zheng Yejian wrote:
> > The root cause is that, after commit 73bbb94466fd ("kallsyms: support
> > "big" kernel symbols"), ULEB128 was used to encode symbol name length.
> > That is, for "big" kernel symbols of which name length is longer than
> > 0x7f characters, the length info is encoded into 2 bytes.  
> 
> Technically, at least two.  If we ever have a symbol larger than
> 16kB, we'll use three bytes.

Let's not worry about things that would not happen.

scripts/kallsyms.c have a check to ensure that symbol names don't get
longer than 0x3FFF.

Best,
Gary

> 
> > +++ b/kernel/kallsyms.c
> > @@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
> >  {
> >  	/*
> >  	 * Get just the first code, look it up in the token table,
> > -	 * and return the first char from this token.
> > +	 * and return the first char from this token. If MSB of length
> > +	 * is 1, it is a "big" symbol, so needs an additional byte.
> >  	 */
> > +	if (kallsyms_names[off] & 0x80)
> > +		off++;  
> 
> So this "if" should be a "while" for maximum future proofing against the
> day that we have a 16kB function ...
> 


