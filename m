Return-Path: <linux-kernel+bounces-385816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C49B3C14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E811286F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A71DFE31;
	Mon, 28 Oct 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWyuF12q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EeRnySA8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F118E03D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148229; cv=fail; b=mYl35mMo10KC7B+cBxd9MVKZtQ/pHv1SGuClv1zcdOO4i+ZTapiJuRPRe6RMbolovgMcofXiJLFa3SbI7mHYI6kmUjdtovM0kaX6xeDhclNg2bREfuZjhBt9395sXgOntWX24RvEX/kd3Go+Ne+bOoUYPdC9N87pGv49XjEFIbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148229; c=relaxed/simple;
	bh=/G7vg7TEjMLWlC8UtQHkaBU/fwNzTTht/RpTjNHIkO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h2CxU19vHu94UY7gZ6uwNvXCzY4Xvfa4FaeoG/Qt0qWPiN9lDuO2k2m5e69pnoc/fa69jfZmwTrhxyLkKsMYgA0zDWKA+kmMM8vJc80WEuy4Or/462kLiO59n/FRPDD/8QSRyDM1NNd9ETxmeoCecj0x9ptoUgK5xdXnKRYJ7+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWyuF12q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EeRnySA8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKfvsT021736;
	Mon, 28 Oct 2024 20:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wFXzASqXd8+vJYCi69
	M9Ghs8mxcQ1/LHzfePgZjq8qI=; b=eWyuF12qIf5k6ONfIRf6+sbB6uj435wRmh
	Vn9VrKTlVMnT2fJ6L0PhruE9EE0SsziIi/2qml5eM9RA02rdRYfxKuafWFoGbX+8
	tgyETNVqkuCNojLstW07k6cRDAoPhFSZM5umt7al1Kck/ndPNWmDvyj8ZDm9lFoi
	08n9WIMnOGoSfB1LEpf8A/+qtucbH0P8x+QiF+l54SulJjfTD71pYFUnV1BR5/LB
	7nqU3jSOWUIc6Hsmiv4mDHZl1hbUcdiRiCXCwss/kt+WcBL+Et4oHgfYh+ADiSKY
	f2Q24mUlR4jb/p6xkEC+JCTwm89xNpp7nIx0hUODu1oy4eCYhCgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys3xe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 20:43:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SJKZlB010191;
	Mon, 28 Oct 2024 20:43:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8vsmd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 20:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+Pbo+PiLQHwIrzQ8WMobyBaReoOBuF1egMRnRwMTWgFsyJal8jf+jbWYnLnlkJkFaaK/Ef0g/uq/rSVyOkuR97YEh4UcwxxJ2Cm2KSXGZWdsui4pbHuxS/OtLWl4UDrASfyCO2gwP24DvckJLBaGy8XQQbYBHooA2bAWF/YRMkSrnBAIokj1UtkCYm+v1iSu1jzUPLFnnYY8KTIOIcd1sM/zrmCmfht80SMPkVL7iaPgvGwn95IrMbMWVd16pfgTaoBgnFNuODNz3xGQBsMzeHPblP6lwQvQZw7aw6D23x6lgGm+DSc8KmHH5AIOf1sSiObu5WjOiJx/yFEPn0BSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFXzASqXd8+vJYCi69M9Ghs8mxcQ1/LHzfePgZjq8qI=;
 b=ebcAIkfog5io0JozHfYTwRFTYDZf9lxVgR4m+iZtxf2LestQ7laOSqi+4foJa1dQLQ+beoe3gdTm23cZ11i+mTga/GNaXUEtp3j0NbPsauEXg+xiPbiFwtyvCyi4waKn7LdvM0q++K0NATXb2t2ZaIfgEGz4YDMEC8/6PnXgQ8xYlyvNLvfgDCqbLf4skrAg/07ptKsT96se6ZlWLoUb+Wmdi1BVz1sAizRQSILuGnKxRTLED8Ed1/K14ow3iaxC1DubfB6yr5wreejk0ez8aHblcWxFEsLSBTJprHr/vUK9zOzYxBX4duYXT6AjraRBg57zvH6T1ov9aLpXQLUM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFXzASqXd8+vJYCi69M9Ghs8mxcQ1/LHzfePgZjq8qI=;
 b=EeRnySA8nMx4YyBxAu8QvcUValctNNvavnMHvF+Gsf1Q4KWQBk3I4V/mjbXChhxPqgyyf+aBkIomTqI7pQ2V2oB8nyyFxmL8tehtmzkriAiiglIX1oXs05E+wJVW7U1QHFmNOmT43pz1+AXPbSWyRgYnkC6PJDMTdHC+0cjSopE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 20:43:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 20:43:12 +0000
Date: Mon, 28 Oct 2024 20:43:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <a1ffccb8-3f53-4486-a250-282ddc7054dd@lucifer.local>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6204be-c9c3-4e3c-9aed-08dcf79123ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gouXp5t+5lS03M/kldRb0yPPfIEO3V5CdoS37t3v8u+ouGO9jq5Qt5V8zdTc?=
 =?us-ascii?Q?Frcm9BND1ZXt0hDox4Uza0FB6kcRw4+0R6rpWwANagiXtixQsDqn5j+zO2sR?=
 =?us-ascii?Q?+ybZtIS5vC70OZmPvAkx3juJjsgVmyLx7vIZOydNKp6BFzVcG8Rfu1UMXCGj?=
 =?us-ascii?Q?NbzfLQHG2tXHnRq4i7YM4zQwMEQ2BZeor0bRSUVhp+fBSuY4aDUfec1YaSGC?=
 =?us-ascii?Q?7/rjXWE9czysKGN634QUd1vsCnntldFV7Cl1bVJKqWrRvHhMFqUPqkYk55VD?=
 =?us-ascii?Q?Cdh9oVaPPv00qpR20ih51DQuTbe6weoY83Tlym+v8JWyl4ZdnNqwXbYa7sG2?=
 =?us-ascii?Q?W649oKQGyiPQxxDAJdqWPS3gnZOqx33a+nIONLZM+GfoV2s5HPMW00+9y6Hk?=
 =?us-ascii?Q?aPqk57Uo6QdWsnJkypY6s4jb9BtjbH02UgE+/3nQgf5HpsESs1u7gra9MTCU?=
 =?us-ascii?Q?kVhYsmM515fk66lCEuFdeP6sJbLfjZEgV40jKbEorO9r8roV958MNyG+mGV/?=
 =?us-ascii?Q?jnBe+1RQc7Y867oCM6S7+jXCaZrbaX4ztByMbb4itUV3y6fDcSPyYQ0gjSlW?=
 =?us-ascii?Q?npFeD0Za1nHilvJWsGEheLRnRsajYwZGcaZ8Jlw0roOTcfkzOT5dARRXnJNa?=
 =?us-ascii?Q?szVeEuumf7EJiqqN3JpCOprLlZAx9ekpgH/SznYQmnTQQtJw5t1xzwxB38ca?=
 =?us-ascii?Q?UOQC9A3aHOk3CURgt39k6A4v51ygsrj8+orSj9i0801Go4sxtYn7AISdZC7b?=
 =?us-ascii?Q?bBhsZLTvd2L+8+Ugcf6p6boU/XiGKxv1/aX6tKGggPO7xYcPqN1mQdLcQtOs?=
 =?us-ascii?Q?y3CDmCMrWoYywK6VlZq4gu+0pNeH42pi6xnbN1VlFsfGjIq5agJdWTuek0O0?=
 =?us-ascii?Q?aMhhTbblyPv8GzGa5Cu7r4JNh2sNzdhUyjyo0mID5PN2nHxr7m1owU1eS7vW?=
 =?us-ascii?Q?4eBPVZWwZvv8HTM8i2XzDTz5HdYL9j23sysqVeUVNMRmVd+4cNi34zgqrRUE?=
 =?us-ascii?Q?4vnntWVmMam8jhlMR7+q5CKwSpS//375sx3ZP+AuRFunYmhJhIirKTNsjhpG?=
 =?us-ascii?Q?fwITCEDMI72EqqheSgLCD9kp6+nkS+b+ZyRBIpMFT/FBuxiltbLXhMVTXoFU?=
 =?us-ascii?Q?6ClKVHsojezsrMeT1riVSPx2/zeD5efw4rFql469yJ3ym9kq6IIyqbfBPWUa?=
 =?us-ascii?Q?2HA5C17mw91GO5Frdipich9Yn/CPd+eeV1DDi8QSFTEjDNM5Y2rWorYpPOIB?=
 =?us-ascii?Q?z6RhMJW5+fsrNgp0UHcHs840jYyeP0o7FG6qYe3HFXsuZnCIKCIJxlRABxXK?=
 =?us-ascii?Q?FdyHlLs1db3G+RrKt/DNFC6e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rC250/VQR+k5xceyru+puZck/RT7BLX9XCjNvtvYMCPgjUdfclWoKiH/KwpJ?=
 =?us-ascii?Q?VuJeHO7yRDlgQGk2X7VYIwaaLIRi3pSXt1NmIgLZCjDcFiLMA7vcNhyj013s?=
 =?us-ascii?Q?bwQ8et8yl3ZnXt69mQj2D1eluw7h/liRhG0TckzXhk+r64DDiYu1wkU0MoA9?=
 =?us-ascii?Q?SLEUc74Uk9wOyaXl027S+EjIhAXJ6+D3NyMqWDyI0agfRTTDWLoN3LQ2yTV5?=
 =?us-ascii?Q?qNCtgJgZ46NBI/BR3Qg0aOwWo2XxgtG9EeHRanS7PC61v4swjuifNsjvFLvx?=
 =?us-ascii?Q?ZPobpIqLcZ4BrAM5aZLze+Cl0pP29QX9dZcazY2IKvC7il26xYTBQfOFmC59?=
 =?us-ascii?Q?WHdSG2HHeSebEjSCUItXxXWl2aOfPz+phuCdW0vpsQZHK2xJyGIs20Vuf7Oy?=
 =?us-ascii?Q?7MfdSJdO3yca1wGtK8z+uf9h9NLRIJcZj2Ui0LjiU9rQb5xPiPnMdLzOyx9Y?=
 =?us-ascii?Q?kFgFcqUVv89NHmlx3EJF1kNgIeRZj9miLw27HremOtiWDYZ7J1jZEk327Nb/?=
 =?us-ascii?Q?IdPIvTAmRrUrqtFbZHKZPFg2wMdZZquEnJTNxTa/uYrW/mJHujZzy4ETTOqd?=
 =?us-ascii?Q?/NfWuVlQ0p6N+Ijc8ko42QS2NDVhNjMRd+3prRPxAZ8OxriLieoVW9Zv91lq?=
 =?us-ascii?Q?Xj5rcFK8pZ0YfFqj2OivpTlkmBU9k2HAbNdVnZxkmVAjlPnfKP7R2dyPpk4E?=
 =?us-ascii?Q?UsPmEh5kVp0XSnaZ5MeaJ38CUX9btlyoP9SYItH0ofan77PgdOTO4tad+6xW?=
 =?us-ascii?Q?F1E2IGh6an63pHexW20RMGNzoNncTWoqlD76fvj0ODLbPXA/ERMDZPMBnH0m?=
 =?us-ascii?Q?+KAr3ydMUwvDih7JMzjbVMV4dvEw+zaK5Ev7UfHVPg04oF+6PXHP79aXhWEj?=
 =?us-ascii?Q?t/5MfAGcqFU8j6KpZIUlXX/ToL47cPCuRMv+mrTOy2SZWw4zumRxMhzGXXeW?=
 =?us-ascii?Q?sfwtYu9qF13PNey2qagiikLe1iA7bUDpSHxrYZ/bhyn67naG90YbI5fcTIKk?=
 =?us-ascii?Q?GRmlus/fe5fyzWUVmYm7DIQMXi3xu/kOiCTU6/3V2mOBYvKAVe65ZyP7pw8O?=
 =?us-ascii?Q?Kz4u/BsLYyIzzujlAXlRla45Ne6qwv7ScScYvlP/t0FsUDNA3DtHOqDec0sO?=
 =?us-ascii?Q?679QILoRlD9hurZuD1QRl7DyDpOc0TtKzzqPgjz8kdq5ibcFjYW10KSDgAm/?=
 =?us-ascii?Q?BIhr8auRZPTWdUZeLedN4p0thU9e0l4eKPswjS5sOqtCibTk0pdizcSpfokR?=
 =?us-ascii?Q?NUFJmyGWxtPJK0B8uwIeJLT/3tJLv+DrAO1kSQoUfdNNXyJEFcsrCuJ1eb+Y?=
 =?us-ascii?Q?2WyIsOQC3MEX/9zTlxRKfldYyokzhkZOyou/9wX9PRwCm8ikEWOJYDO0kIYK?=
 =?us-ascii?Q?rhQBganOHjac1sPnE+cn14Sx4MzxKOaRyfF0vvqjEcX9JwVEYZwP7EZKAmKe?=
 =?us-ascii?Q?8u1Ix2Bpdr9QFkptHLFt3K1DUWV+GolWgsRnNFluX92uNIVIwAs6HuklwP7Z?=
 =?us-ascii?Q?D9H6879PvXHhQhMVb7sjvPzE4a9Q7YUPuESnN0R/fYuyXe7K3XYHa3uwIq/e?=
 =?us-ascii?Q?cZ7AEZ1q/lA56q3JGB8q44qYVDvly5CVNqP2YA5OssbRQnP1gv+V5JR/Nyw+?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CjXBL5IuAKIu/ZlTzMnvsdwTK7lMwOzB6are/2CVQSI7xfFWjaWOwIoEiKh8GgxOpuicO+M4MQNhdSmGX3RWWZEFhk2NW49HdLk7VucKlqqybdOmo/28Fvh+cw32M9GobZ/+JdwlQHaLr998PBdHeab65anKJQ0wghm07JR4ZetVYmq7Lx79mfwWVU62tCu6emYtbb+S87rh1tSqoM4aWUoxjw0P4FgYg3DN0nz26ae8TxDrv6ZVvZZLpS0Mth8RBGaqKArhd/c4Gh6V3VDH4VxvVz1aKVnBK3BxITPhCu4qGXPlEfBs7qkWwaWr6fJB7Bdzg63T4oWrbn24Pbv9S40S9PKopgd9Zu3ZFNoALuORJO0PyB/qw9u61gDLHc9aJErsRkCXUKcUz3xgiQu2TXC3Pu75KT1MzWaaQC8lKIjaBIN1G39Du5UPF3nrXEcWWGz+66bz+COo53bFdVsCavJCtcEttduSeyE1Xwjm0g/1/Fbsq6MVMFiofehQ7E68KLqYhkkX2NiaEaO6Weass8Jk2JUmI8EqLvj1b6zUnJq80aP5uZeR/sPlHuIjTA+an0gtyMm7IWpU+onqL8wCrjri4CcURVLbSQnDeCYvTU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6204be-c9c3-4e3c-9aed-08dcf79123ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:43:12.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FM/HaikaXo4tFysYFBU28SUf9Emg9XISUMuJf3lmgnGdTrYFjjMQHWSkylhDkntfaIhZVoW5mmrq6egmJ48/0+2S/HAzVv4XJDCoQ1eQtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280161
X-Proofpoint-ORIG-GUID: zsdmI1XBWKb7heduRJLkVrSmOrrqRQCP
X-Proofpoint-GUID: zsdmI1XBWKb7heduRJLkVrSmOrrqRQCP

On Mon, Oct 28, 2024 at 10:22:32AM -1000, Linus Torvalds wrote:
> On Mon, 28 Oct 2024 at 10:18, Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > I'm genuinely not opposed to a horrible, awful:
> >
> > #ifdef CONFIG_ARM64
> >         if (file && file->f_ops == shmem_file_operations)
> >                 vm_flags |= VM_MTE_ALLOWED;
> > #endif
> >
> > Early in the operation prior to the arch_validate_flags() check.
>
> I would just put it inside the arm64 code itself.
>
> IOW, get rid of the VM_MTE_ALLOWED flag entirely, and just make the
> arm64 arch_validate_flags() code do something like
>
>         if (flags & VM_MTE) {
>                 if (file->f_ops != shmem_file_operations)
>                         return false;
>         }
>
> and be done with it.
>
> Considering that we only have that horrendous arch_validate_flags()
> for two architectures, and that they both just have magical special
> cases for MTE-like behavior, I do think that just making it be a hack
> inside those functions is the way to go.
>
>               Linus

Ah yeah makes sense.

FWIW I just made a fix -for now- which implements it in the hideous way,
shown below.

We can maybe take that as a fix-patch for now and I can look at replacing
this tomorrow with something as you suggest properly.

My only concern is that arm people might not be happy and we get some hold
up here...

Thanks, Lorenzo


----8<----
From fb6c15c74ba0db57f18b08fc6d1e901676f25bf6 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 28 Oct 2024 20:36:49 +0000
Subject: [PATCH] mm: account for MTE in arm64 on mmap_region() operation

Correctly account for MTE on mmap_region(). We need to check this ahead of
the operation, the shmem mmap hook was doing it, but this is at a point
where a failure would mean we'd have to tear down a partially installed
VMA.

Avoid all this by adding a function to specifically handle this case.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c  | 20 ++++++++++++++++++++
 mm/shmem.c |  3 ---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8462de1ee583..83afa1ebfd75 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1575,6 +1575,24 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	return error;
 }

+/*
+ * We check VMA flag validity early in the mmap() process, however this can
+ * cause issues for arm64 when using MTE, which requires that it be used with
+ * shmem and in this instance and only then is VM_MTE_ALLOWED set permitting
+ * this operation.
+ *
+ * To avoid having to tear down a partially complete mapping we do this ahead of
+ * time.
+ */
+static vm_flags_t arch_adjust_flags(struct file *file, vm_flags_t vm_flags)
+{
+	if (!IS_ENABLED(CONFIG_ARM64))
+		return vm_flags;
+
+	if (shmem_file(file))
+		return vm_flags | VM_MTE_ALLOWED;
+}
+
 unsigned long mmap_region(struct file *file, unsigned long addr,
 			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 			  struct list_head *uf)
@@ -1586,6 +1604,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (map_deny_write_exec(vm_flags, vm_flags))
 		return -EACCES;

+	vm_flags = arch_adjust_flags(file, vm_flags);
+
 	/* Allow architectures to sanity-check the vm_flags. */
 	if (!arch_validate_flags(vm_flags))
 		return -EINVAL;
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ba1d00fabda..e87f5d6799a7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;

-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
--

