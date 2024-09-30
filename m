Return-Path: <linux-kernel+bounces-344700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BB98ACF8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0940284DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797B1991B1;
	Mon, 30 Sep 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MuUg3XVa"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2081.outbound.protection.outlook.com [40.92.23.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761118EAB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724837; cv=fail; b=vD8VF15b6bEwVGX0LydmUf0V7YY7zN7IVqmvghnNCG+pPSXisoc1IgG/Zo233pYpnuYXGuQSYJJtKL4/N9iidSAp9TspS5y1t1qXTfiPaa6AO5XsSZJyhseDnMRrSNRE6sk9dm8vpZoMgC6dYgk65JvRKGVotHJdsumbBzzTGIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724837; c=relaxed/simple;
	bh=EOqeBXeeNtNX9oIDnv21BnM5bRpebgne8YcMcqlhSBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KTx36RQFqjBKlZRJ5spbO4CbclVFiP6a/qAPSN0PC0Yf7luAV0uABdjdBlkxLuHn8xfRC+zQfsOvfSWgRQV8Ji4IsXHaND5KyVlRaKDd6gCenCuNQ1oW2ACY0HWFzJkz9dc7spPRKPddm5cGccLXYR35RIOF3yh9Y+oJgEL4rDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MuUg3XVa; arc=fail smtp.client-ip=40.92.23.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9Elf2algmgwFtbLXWY6iEAg5DMotOWiYz55jsUmrnDZue8kUXWmS0PzESVCS9GDIj4+GTZogFglYCtW/VSlwqrDlkdrEspOpEfCbxmR0IJUdX8Fn3HBgUhgOn+Ek+dL60bUu8TOT95PqkovfqBN7A+2uKP1TvaDM2XaIgVLKfW5k3JZMN0HzHycZr++3bIVZ5qJIokbM2AtohfcECbMbgSo7vJ5UPLye2ekkgdRlqyVbNyg/bAGdYKo5MlPZiQthtYHBu0FRRegJk7oI4bsTm6CuLn29eYVHkFMd789tpUqxAqnjn9CkYlcVBTWLZ6mOxF1z33izCnve8sTjxE2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6b5bCPC0LkIAokfX8bSWsnXTBUH8d0G+q8kRwnloAQ=;
 b=rmn7961aYbpJHrQ5PkNUr6hnnhLltQA9pTcIVlabexPbMt2PqGYFXrgqonk2JwmSNFaeyvxOhb+1dvT75p832uK+NcBL/BzInFNhk8IJy80QOVD6nnCYYW3AgT5cQMemAaAOJFTVp9Q/6e/bkdxpMEddo/3tIGGmxevmmf0vhZwrH9aWFMq4oQotae+hv3MJHFme7VzzUM0ChauWKctvu/SM7et8oAzg5OHv6ymU0hJdMET9VfIghFMDp4O7m2KsuQKYpz4nxIe/WBuNFDA8chiz4hTFtuNVzvXHRkJPiMjSF0AuTC00gD0/ePrErl6tNQhRel3/RZkwkke8SMpYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6b5bCPC0LkIAokfX8bSWsnXTBUH8d0G+q8kRwnloAQ=;
 b=MuUg3XVaTktvMlaHhAr+uVsZu6F4Halv+VtNFftoeZ4b0DEO40MTidDCmfCH51DgGSBUyGurRne3/nzQs6+cwd9wD3upBHREy+VhEray4Gjmy68AX4tUMSD3UQfE/6mZK3biCMpmZcltzHLkGGSYi9y58ZZM7NXz98U5B3+mSfgUK1WkA2au+EKrRlEKhhrboDim8uL4/idG5vqB+aLqVZLbSUv9+SQJWdqHQP7sbwH8PkgfqmLZ2/vhzIE7RtmrZe+NKfFNALzYBvJlKVAZk3U00+L6zqvm0e5WhaXaFzmwd4FS/vIjIzAIyYAPXYSjmGEYXuPtwK8aADVO3scOLg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10161.namprd02.prod.outlook.com (2603:10b6:806:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 19:33:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7982.022; Mon, 30 Sep 2024
 19:33:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Yury
 Norov <yury.norov@gmail.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Question about num_possible_cpus() and cpu_possible_mask
Thread-Topic: Question about num_possible_cpus() and cpu_possible_mask
Thread-Index: AdsO+nSV28XUjpufQ325P0s8gOEPmQEE7vQAABhNqSA=
Date: Mon, 30 Sep 2024 19:33:53 +0000
Message-ID:
 <SN6PR02MB41572BDAD5CF02D22BF9D2B7D4762@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240930075600.GC5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20240930075600.GC5594@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10161:EE_
x-ms-office365-filtering-correlation-id: 325139f8-4e4a-46b8-3cbc-08dce186d1bd
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|461199028|8060799006|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 +fMPgqcoHgD4tk4aIhNAnlRJQcsrGOBxzAa06zpyiYHq2mAwNUajg7G4vmzEpaVpGILk8S1SRIKMzQp/1y2FYIWN30ZzWP9piqMmdsMbg4mxztczkwrMqM+WyvAVNmr57fJLr5KT5pcC1Q0U4lwz0PBYJ1mXZxK+6HBWIXYmFFki9bmZi7cQ66DY45A7pwI0XCFgWkVE7Slu0B7RrZNdvJzmZxOKvvfmzWFL/Q9jJOjleFXk/RayciOczDoTywSa4Mf8Y73XDBQa6RWli4mz/+9ITRgYI9Bu/bimCX8TRaEMifCTBj3I/Adzm17jmsZhR4QMVKqXVY3Q5qMbCYWCYduS+3Y/AT3wz4EXO7SP//AJ0nLWclOZ8F5mEfoePMn7YhdZP7nl5HRccD2Hp8z3FlBebVGRdq+xRQpCOyAyTmzpTnkePllmZQrm3qUa19kqAWjrJxmhtyYi4h0a1lpuSQNYNuO/2AxSPlUnC/m33c1EL0HjqwQBhQuWc/QlbAv5htcgb6gYfdBpDm8i9hP6zgKKzZ5uhzfmtu3MnUrrPbH1b9DArN8DRpyfNpxh18cdWrIW/Ycg/tNb5sXiK7TR9T+hWZC8UAtZg1D0GsTDIIgTdtP8+PxNrnrJFG1It/TbQnKe+st9irQP+t7Jn1wOrHf+Pv6+xTGGFONawJLdKhz7MLOlnMH7MPMORAPYrAp7lkUZmQBY8WgZ0kcUmw8s+w==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LvPgUBMkOULN+TZP3ohluDWQ95cmdG7yZXpD8P59yKkFrqiekUie8QssRH/c?=
 =?us-ascii?Q?dDDW0mRYy3DxRx8H98NsFQ7tKm3nnLFjzaR61QrSkHadAAvmC1or4A6P4+7Z?=
 =?us-ascii?Q?8MCPOnNTC6wkzAIdsZKwT+YxTkQSy9VdhyLRt5htgg3LBRhG4lq/OeJ+PwU9?=
 =?us-ascii?Q?jbiioRDp2ZC/NJOkFnyoHdEHM4jklJH1ERBbycbIpZRdkKCBAxgjMSM1/0uy?=
 =?us-ascii?Q?GGqKsl5DMZvCht4zWAMxCbb5CebroukIEiqbwDJq60Q1kKD/IPjvJytzgaCZ?=
 =?us-ascii?Q?8sM6QyGkHEkfI/16yba0fS+yEwoNf4rpe6TXik6YiGeFyeYYMKdv0nwnJmii?=
 =?us-ascii?Q?vvgpWoRiVeuhF+MMRws0fKIphQoGoRxroGHlPLrG9HB41CzBmQ14HXVu3E+E?=
 =?us-ascii?Q?yUm42HPWzmtNPd3biV16YTnue76/r9GvJBwOgxcGX/Xx/U4J0b5d/EMyhPQp?=
 =?us-ascii?Q?ix3kqutzfwKDqV9o2S1pn8nPyga2DlPCxPXKqmtjn1maCzx6Ocds8BkIc9lv?=
 =?us-ascii?Q?ShfwxkYQ3qQMxaKb5f5Ymw79aij7Mz9/9RzseR+iasxzi0SnVqR2T5tNoc07?=
 =?us-ascii?Q?8Tv4Z7tq1kgoli4Y66NfIvtKTlPAbAm43L6H74MCSnBF9oUsskQkEz/6inbu?=
 =?us-ascii?Q?IofCEhYhYIQ63FyiJQljSUT6VNchfh3UDny1nPo2fElmshYyMCK7pNfkjlel?=
 =?us-ascii?Q?x/3drxdGerHKyaj2ToS5k1S0qeQW/rWJzVwGYFuX95SAABY89GXQre56P6Q7?=
 =?us-ascii?Q?sL22zKDUB1sP8RYN77Z4rlaUtknQ2undJ+Ocvg/TXIsQAu1P4QlOrGvXrSae?=
 =?us-ascii?Q?QHZ+vE70cfDK7iGRLjWmotjA+hApBgtAd4fE5xzRhf9EWRrJaDWbm2nuQUPB?=
 =?us-ascii?Q?wOXjXz/bJJ219Dld+7ddA42u0ckyu/TyQGOdyan0xk/tEmOOsJU+oxUSdHAe?=
 =?us-ascii?Q?EvqDB0nmOEJaT1ntB2hNJS7oHxuAWAG3I+ZK1CzLveaHBuw3gltQgZKtOjVo?=
 =?us-ascii?Q?v14r+h9zvIuiJjCD3apPzE4TD83N70H7LxphPN4hP3dVbXLcG/+y5r5bMBgk?=
 =?us-ascii?Q?NFfA+A94lEfhwFuMuNvLa42UocJuWpEGlAbb84tluM9Vw9CwEeIjkB0T4UCc?=
 =?us-ascii?Q?aY9cTgDqcjqi41OUgfqgucLqlkP0FriUpss2OayGwpyN5Hy1+9JrPIh0faYz?=
 =?us-ascii?Q?dP+3tzKuYlJLcm5j8QSHOaSataKFAqrluRLXJ2HYw7kR5Ka78R2E2nOZKmU?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 325139f8-4e4a-46b8-3cbc-08dce186d1bd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 19:33:54.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10161

From: Peter Zijlstra <peterz@infradead.org> Sent: Monday, September 30, 202=
4 12:56 AM
>=20
> On Wed, Sep 25, 2024 at 04:04:33AM +0000, Michael Kelley wrote:
> > Question:  Is there any intention to guarantee that the cpu_possible_ma=
sk is
> > "dense", in that all bit positions 0 thru (nr_cpu_ids - 1) are set, wit=
h no
> > "holes"? If that were true, then num_possible_cpus() would be equal to
> > nr_cpu_ids.
>=20
> I think we've historically had machines where there were holes in. And I
> think we're wanting to have holes in for modern hybrid x86 that have HT,
> although I'm not entirely sure where those patches are atm.
>=20
> Thomas, didn't we have a patch that renumbers CPUs for hybrid crud sich
> that HT is always the low bit and we end up with holes because the atoms
> don't have HT on?
>=20
> Or was that on my plate and it got lost in the giant todo pile?
>=20
> > x86 always sets up cpu_possible_mask as dense, as does ARM64 with ACPI.
> > But it appears there are errors cases on ARM64 with DeviceTree where th=
is
> > is not the case. I haven't looked at other architectures.
> >
> > There's evidence both ways:
> > 1) A somewhat recent report[1] on SPARC where cpu_possible_mask
> >    isn't dense, and there's code assuming that it is dense. This report
> >    got me thinking about the question.
> >
> > 2) setup_nr_cpu_ids() in kernel/smp.c is coded to *not* assume it is de=
nse
> >
> > 3) But there are several places throughout the kernel that do something=
 like
> >    the following, which assumes they are dense:
> >
> > 	array =3D kcalloc(num_possible_cpus(), sizeof(<some struct>), GFP_KERN=
EL);
> > 	....
> > 	index into "array" with smp_processor_id()
>=20
> I would consider this pattern broken.
>=20
> > On balance, I'm assuming that there's no requirement for cpu_possible_m=
ask
> > to be dense, and code like #3 above is technically wrong. It should be
> > using nr_cpu_ids instead of num_possible_cpus(), which is also faster.
> > We get away with it 99.99% of the time because all (or almost all?)
> > architectures populate cpu_possible_mask as dense.
> >
> > There are 6 places in Hyper-V specific code that do #3. And it works be=
cause
> > Hyper-V code only runs on x86 and ARM64 where cpu_possible_mask is
> > always dense. But in the interest of correctness and robustness against
> > future changes, I'm planning to fix the Hyper-V code.
> >
> > There are also a few other places throughout the kernel with the same
> > problem, and I may look at fixing those as well.
> >
> > Or maybe my assumptions are off-base. Any thoughts or guidance before
> > I start submitting patches?
>=20
> You're on the right track, should not assume the mask is dense.

Thanks Peter and Mark for your confirmation. I'll work on some patches.

Michael

