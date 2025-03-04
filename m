Return-Path: <linux-kernel+bounces-544080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9577DA4DD26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A464E3A9E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0B201256;
	Tue,  4 Mar 2025 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EEi//utQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ljx6sbD/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8D201025;
	Tue,  4 Mar 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089295; cv=fail; b=nrTvK26bGncqhQ4fQ+0Me1g3Ua7fMMQQV+ssLn21Ixzh7y5EmQJCq9dsOp0Ic+aa56SO7vwCu9h+uoJXZGhyQASPBvwjt/8BriUa4E2zayMYLhBli5DRw/6V+6EhHRyB7jvGKmcd8OL/11kV2Tjb6OFLD5bvIm4cJKZengnC70s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089295; c=relaxed/simple;
	bh=pk8ZW4IbwJyCddw/bLYphITi/0OUSd82J/PbH0eeRGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbxPIuZqa/1NMJ1R5woS/mqO0KRELAWVJPuwrMLKqv40Wxbb/SWCfs19fpI5k/YGeDKMU273I1W2DbbF+YvqrwxwtxjzDj59CqXPviOGkrU+kcwpyuv/9ukGM5dtF1oc9Hg/Sz2f91ML3cOrGZKn/bxdsezmATwK6zKNkyUtmqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EEi//utQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ljx6sbD/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249feo5027981;
	Tue, 4 Mar 2025 11:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+dYb8zspzaBJdawm0N
	LHk5RxW2KCEuapR+iQ8bl2oxY=; b=EEi//utQj5oCCJWVaVj0EHfkNpS2AmFp50
	xbelEX0zM11GY7UrVQyC5fEkfvI+IofdY+GaXQsoeL0AW70nJi8wlKGKmdqWMDBp
	1ZWrKcRcdvvyrTvrVvXGO7SCPbsx2Es0VBCYtJ6oiO00XgkRuyPJi5ZZLqPvvBmo
	Uv7qbZRPQSQxS9UAvog/anOhI4q5F9uU1pWqpO8OoGuTkb76fRpdIh9Ri15PDMUC
	S6uOv5R7icV4sy7lHhKgxAQHLsm7bflJPZjKvTvQcydzrB6OdKLCc3tLPjPKNaa+
	UlwCEkv4L/alWEJiiiqt9Vkl5QXdnQatrl68+xvODCBV/1cyEVDA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wn03q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 11:53:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524BLQTn021947;
	Tue, 4 Mar 2025 11:53:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwut38a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 11:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxuK3FK0BGnKxMPfit0Bvw+vmFr4asjUKCTkPKIQOMJYxA9UFU0DPiKmEmYxVeaU42rBSSGQzQRw0j+KzoM8JWKPOJ3M1Y5wMPBUZ9fKgZlGEKvLNbp+8XyJwEE9/jJaKDl3+fFBL+uA19FpP5/uqzjyckDghX5q9Ay4w7eh25o9AklCElJI8JygCHSiI7yhPPztKoFTjncqRoC/xCMb/z5G3DmD7L6mejTNZY827bJViZLo/yRCiGIMx725Uqvtlftt0SOMEHmazdK/t4QwMsQYZmzz7AFq4RME2Ra/p6hlCxpkiavEJWpnJyRsU+7RhmLv2VJasFYek9Xq9m141w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dYb8zspzaBJdawm0NLHk5RxW2KCEuapR+iQ8bl2oxY=;
 b=DvVVnQVfVbJ1w0SlceX93d/DVDIWQW49AGtrvkyxbBZYlcszfpgQWcpsC1laelitkB5f5Uj68ATpH4PszyCVKCPjzF3wq2Rd967vHRBF5I5DH5W08+txJQT44y9SeN0q3HfmLp4pKfucXQIA5ZMnf4+r+Rq6h7i3xzJd0WPdfKHnF7bkF7hM2TD/VSdZPNxVqf5nI6J5T2QDb2vVyhr56dbRVbRoCQR/Rz3D3Xjz5FVdZaKTxpALHId4NX8kMxg/98IYIDBBB1mV5EHeXU/Wt+//5jBxOmdlkeKJxbq3muoSui28BjIpUn1wICWiyLF7RcaIgshw6S813N7/EPNKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dYb8zspzaBJdawm0NLHk5RxW2KCEuapR+iQ8bl2oxY=;
 b=Ljx6sbD/7QwMPbwMzC1YTtYOwKIdZ9N/MYErNO8EAnlsjRvcDjoFoDcDDafwUiRboufJeDTB9AadTk96NSO/vUKV8dbXCQXSvK4eCMEoezFWhNji2Pwm8USOSYtNYuaEdmbAFFhgXJPPJXpdprZ0TUeiEgHWCFuVCtuEb1bhbGo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 11:53:50 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:53:50 +0000
Date: Tue, 4 Mar 2025 11:53:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <1cb266a8-46b3-49c9-85d0-1487d30b2d4a@lucifer.local>
References: <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
 <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
 <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
 <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
 <r3iEw6cWkz3wBoUc9l7we40uuvdTVbQBJU3rWXKQspv1GfvviY_0pYLyFtTJPBP0VeofvKHx8-l0WHFT-OQfcA==@protonmail.internalid>
 <33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local>
 <87h64ahr64.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h64ahr64.fsf@kernel.org>
X-ClientProxiedBy: LO2P265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: c653898d-216b-49c7-87a9-08dd5b133a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeYHFqU6F9+oNlhHylG4nk3Fb6ipzbfCarnQoUyM39LQHT1C4gaAVpipUjmS?=
 =?us-ascii?Q?LryJCqU38KxcTbuYB7Eb5a5GElf0WkXnIQlfvkvr6nJcEgufveaVA4lAgYhJ?=
 =?us-ascii?Q?fyUacXOuethxUhZDtMoheOyBnFid9IEObd7PRPNd2ikNck/bcVUHL8dIQmqm?=
 =?us-ascii?Q?aufJ+NyGaelJtt3sy6F5B/ajviy3GQvXfEb04qr6/tPsbbhQSs5mmrlz4toM?=
 =?us-ascii?Q?JSGxHweVJHordAZhdOjhljiE209ti5zj9zbiQrqLf+9sjqbqnqfd9PmIjSyl?=
 =?us-ascii?Q?2jBS5S+n7uEDSmu0YCosR3yxEo2/U21HDOH+6GcFwbX69y4VusOzZuf1Pton?=
 =?us-ascii?Q?1B81nzpLKm7DpevqI/l5cltju9LsBxByFW8QWBV6BXjpDcnPfiHpB1IrNVuF?=
 =?us-ascii?Q?Xrax3ZFF5Sy2c/IuI5wbKKa/R2Ng+Cz3SEsIPjI0OfYfpAuTqtwEtux4TOPq?=
 =?us-ascii?Q?zSE6T7X1OQZlKfchX+Z2neTuY753+7mbvpyc9FUJYAZit3bSeVFLnL0aInEb?=
 =?us-ascii?Q?no8y4p0cjkaTv8HC02MFM2Fy2BUIANJ5g02OkCRJlGQLq2ZvWzHcJ9ePYbXL?=
 =?us-ascii?Q?98UDpfxFpA8efrRCCC1RwjBpbOKSSNAnGF98EFfpPaoO5S9u/EwNzCa3Kjro?=
 =?us-ascii?Q?HMw+PTQ1vgX/7iisbkQ1cIAgfYQYZK41zLz9uh6DuHNe3VvWCZnDgnhI9fr6?=
 =?us-ascii?Q?gTdmcSddR//8Z1v6YIlwcB+pZGEKq9upnZNn0f+knk62Mya/mPi6zlsRRd1M?=
 =?us-ascii?Q?uZezWa5xMgYqrd/r3BFpXSUN/ElCk9L0KQlWFQ/EAw6KfL01iP8nHdMQUBOT?=
 =?us-ascii?Q?hTQjj3rRVozTBzM5hYnWLQLyLraSNdCRLRdueH4ztLAncxLG50e2VkfwLGez?=
 =?us-ascii?Q?U9gk7tBYm/ot3xdqm9sAx++RWW6sazLGNQtr48K6mYfFrOTN62n6u7H1lqJ7?=
 =?us-ascii?Q?3PYAdKuboaSIqXhHTfTY+ilYDHuyua9LgIsPaZv2f9tmuSwmVyGgyGTsEjfR?=
 =?us-ascii?Q?jHII79/ryNZdDJRbKbvNlCt16GXOhAw+D+zQ+4hvcf8sJVRRHsYuXBoWgAgb?=
 =?us-ascii?Q?L7g0QgYiPKsAZ7A4gI9863AzbGFB9g7tAKgsOzeCdY6N/axcELafL2lWonyE?=
 =?us-ascii?Q?c12/ZyDWVd4T9OflWVWt2i0jJ2rDtCp0xA5R0nL/WNrnGyUDLUrhdpewzWcp?=
 =?us-ascii?Q?HF93EGbhNBBPlHDH+aLU7RBj6nj7YLUSKjKrNwNU0eWCSJVkPfdp7Tfe+udO?=
 =?us-ascii?Q?wBd8kcilECR1+PGSd/l8opWkPqwzo2VHvqR29ZJrxf5UBfOkf9UBCX7Q0/Mm?=
 =?us-ascii?Q?2WgLflHxwYLD+MR0tJjtkCA9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZr6WapHn2x5QQBB06KKLugq1o0Z/AFwrdfacYvnYSe5jiF1N5q/xu0j7xLj?=
 =?us-ascii?Q?Yi03ooKzswWushh9YKaM7rbxiKAIQBWOBnBbosTC6Vzg87gv/IxH0pIu3at0?=
 =?us-ascii?Q?zJBc+JWTV7l58rNRs2stYfg3UiqpT3dtObzgm559rXBW0C8uRankvkCiLfsY?=
 =?us-ascii?Q?yXbt9G4Sa5ZV+Lqp2iHJu61UBDfFOw4bw61gaQCZJ3iXBZxlZlXPY9zqn8vX?=
 =?us-ascii?Q?5Eg1NXilY5ZGz2A6qq/2TL2DEG8o0IUqWo9WRhnFlznj3tTjFKEOm69Tzbar?=
 =?us-ascii?Q?Tc+PdSiCKyONmcho7j/Re8xVQQ9ToTmCsNjh81keC9QpmmVsOEV99EuxG+dM?=
 =?us-ascii?Q?sXM2rMv4xlwBGKEwTgmet67mp47/wQcaVKy5yG7SNDrsDJULz6CucpgwUBjL?=
 =?us-ascii?Q?uOx5WoLjX3VWtonic9LwsSQ8EzlkLZCZlTRd4B4zZaDq5QTLXWizFuqSgxJZ?=
 =?us-ascii?Q?p5MDgfEdMa/dmB3tidhn6YGOBQBKY3ik2czn9OR7qBW5t/L+aKEB0p6CT4fR?=
 =?us-ascii?Q?xilPZQ+axbQorGCAeW2j1IOfVAHz7fD8fLeQ8IMxU/lhSECufbUUaSLc68Wn?=
 =?us-ascii?Q?YXABpGh7VQ8ebfv9ZmjKMsLaHiLrPZxKw4X/2Ud5G/0pv5CbFVEv/5Vo47hv?=
 =?us-ascii?Q?oU6SeHdNagZcJl1FS/j0A8P+tJejOjvE08fPpoaEaMrsXSs9vTrhLWk8VfuZ?=
 =?us-ascii?Q?8TjXZXlUHerY7GJRbdFsTI0ag7kGgIAFv24gmFr6rfh8r5ty5EV+0XMC+BEi?=
 =?us-ascii?Q?NRccFjYZx2hyRX4CgqO4avtKsYpYamSrdS+riEzMyLuQcdw2SkznDq2++ETS?=
 =?us-ascii?Q?Yz9biaLjNsPh+tO3q2cmsG2VVbSsOOtbh/j74B9ZdEBdQQwiqI89TQTuH4ed?=
 =?us-ascii?Q?iydRgMmV6pVSpjQVgO3P/XMuyupyQYJ/eR12Q9xeXp8O75QLVU5Ekm+/RLa7?=
 =?us-ascii?Q?GdZPIQpTwWUdmhRTrRSvn8UHGO6d1DT8vYh9/4lxAX2N8XYCrQMkxbOf1u9e?=
 =?us-ascii?Q?76Ky192spPgcY6cqsZvZWU1S2ycPvrR8a7f+S+wi02NTj6rC8UhI5Y6bvra7?=
 =?us-ascii?Q?yZQQ/hu/kotRiTXbixZeBaTry7IqElhYrByhcEe3zYmq8xcJD5phWJCYz2WW?=
 =?us-ascii?Q?aBSAGFYqUF89l1ruPcTdbbHcIOTTnGmiG4CJ3Fzo3TDLZHKTD9Kgk+uz8wAQ?=
 =?us-ascii?Q?1RyR/ZNYYPv4tcX2bTaWke0C1JvHNogu+szHXqvHXwC4u2NJpBAAKki5DAcD?=
 =?us-ascii?Q?CdFrPSoqthPWrEIXm6AnWa1M4fN4J+Hdr9zJYsO2ILoxQhlZjSdvN4blpaN2?=
 =?us-ascii?Q?Cl2D2zI/clFwH5Fgc442CvsOxxg/Qg06GmL+hntpgOrJ1VLsYH9vsFKrqnUq?=
 =?us-ascii?Q?tUku84sncuxZZiFAU4viVT/UCFYAfukgBkfmeakYFeF9COsd1MuMqCCqdTSw?=
 =?us-ascii?Q?l5i2x3B69IUX87WxeV8FvNjtngSCQ2q5OPyCLeXbro0PKyxA6kH2Jm2GSk2r?=
 =?us-ascii?Q?ZZwSZ3Z8tvdSMjIyFQbiesVQsrFUHUXCvjk/3VPgR/XYjVGP+N3qpgJRcnNE?=
 =?us-ascii?Q?mBwuLW2+cLhmPMJThRGtQGEit5SjgNp+uSEfWxNkaZI8NmqCkBN6x5Tqcwfk?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yvE9I1RSXK+D9JIIHAqTrxuk0g2J24i2OQfDtM4xGvR8sT/6Wwwb9MJt5xTYWv0PvjsES+lWjBPeasWTmyb0vev1Ag5nemt7A9emmkzvAKgphsHpMSoNuN0jHY7U/iPa/GFXLDhxGfy8O0hNUcEzHGGSUCS1gG2o8ICs/4RefSWjF70VK/Wx4pWP5f0X8UuopN2LVpCNynnAqLjYNVQN1W4UDxlZpuAddZhA6wR6r9PqQC7IUpUfoAGnXimXhi7+xHVThMVAZVlV0PEeclADZYmwSTnE3DlGIzZX3PjKyH0GVdKUdKbfSe+6HueeYg1TkklvHH4ZtywWd2ITUJF+xdqD/Tu6G0JX1VdxR6CanV/fJ8DYM+M+jS/cGOYjYD9wlWEXx3DDNdb+SQ05zl1rp5va17RfS508rYFy5YSKDNckZo0mrv5QuHIq0aVEIGAnCu/BMJg7/nZbD2xUMwZviEMm3gfyAOmCwoTvCLUxFBKJUg7mpjHkXvZSI3fxA/WZJoInku1G1N6lcBat2CH9mxYpjmUvhobMx305fMwP4nb2xItBN7C2AChh/psXNmCSnr+JDFIASNInOJrCQEOLeUiP0eu3Ux3Sccr/58Mgr6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c653898d-216b-49c7-87a9-08dd5b133a64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:53:50.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0VOza7XgZriDaGmLo8A4jN5rY9xSbAqb/PkTWo5REfDC9L5n/WDh1bIwOXLwm200nikvms0JRl9xnFWOBYYs9MHHSYfMwcnBus0oY0WQ7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040099
X-Proofpoint-ORIG-GUID: 61qC2khcjs0MVRrd89iLvw8uyMXljFBT
X-Proofpoint-GUID: 61qC2khcjs0MVRrd89iLvw8uyMXljFBT

On Mon, Mar 03, 2025 at 08:04:19PM +0100, Andreas Hindborg wrote:
> "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com> writes:
>
> > +cc Linus
> >
> > OK since Andrew seems caught up with other things, let's go ahead and propose
> > the entire thing to make life easy.
> >
> > Could you send a v15 with any fixes (don't think any are necessary now?) and
> > add a patch to add this to MAINTAINERS in the alphabetical location:
> >
> > MEMORY MANAGEMENT [RUST]
> > M:	Alice Ryhl <aliceryhl@google.com>
> > R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > L:	linux-mm@kvack.org
> > L:	rust-for-linux@vger.kernel.org
> > S:	Maintained
> > W:	http://www.linux-mm.org
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > S:	Maintained
> > F:	rust/helpers/mm.c
> > F:	rust/kernel/mm.rs
> > F:	rust/kernel/mm/
>
> Probably a single `S: ` entry would be enough?

Yeah ack, a copy/pasta mistake there :)

>
>
> Best regards,
> Andreas Hindborg
>
>

