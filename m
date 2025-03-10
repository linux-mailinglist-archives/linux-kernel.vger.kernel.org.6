Return-Path: <linux-kernel+bounces-554838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209BFA5A193
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABEF1893DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCB22B8A5;
	Mon, 10 Mar 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DzxDFSu8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LuEY7c/W"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7521C4A24
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629780; cv=fail; b=Z6gyBOnyXVv6iMoTocLz3sRI9VDhDwxNBL2Faq++wFAad7gxr6/r+lNvYjCTw6LPiBb4/UGdagXXfv+2dvEAdCZmD+pJg1DfIDbTvfF/hD6JayO2evMt6GLmhOJ0GCNREPqr4e2Y/YcxRP73vNgdtSHS5hIONhuYyqyuC+T2pt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629780; c=relaxed/simple;
	bh=psXvsF8kwR5scfbr8Kj86k1/f9bgaNbvswjM1nASwzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iq1pANwHyzoL31SefmRQg/v28fgQi1OUzdxO9zC8b+3oWdt0bITrk1zGHT/WPpIrAxR6qGXjYzfGbaDOQV9tHscRzAYMXWznSJ0ZJZIIx1o9lKIw/6n7+1Af8aMOo44i53pWbZyWHQVHkpjp6l2wKky+CoiI+7dzG5Dm8z66Yoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DzxDFSu8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LuEY7c/W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfmgU015827;
	Mon, 10 Mar 2025 18:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qgbp5gdB0Jpf6omec0
	YNED651VbXUlmx1FIqaJlSPbU=; b=DzxDFSu8ybLrsBTjDO7B+d6sSzQen3NLTS
	Do6x3cnQPqtAFfVrKKC2A3+Relb4Vy8IrEUhRuqV7zg8NaT98tusLvMgaX0PkWYe
	O0TNkFGmWJv68UIOmsD7vbjyZ4gl4ZU+Vaf2nfzHz22QPRXNtC0SPoDiRAMWizak
	+1XFNpFVBInL64YCsWILLpDI2CAOefwZXssZOMo3TJeafCNPWuUyw263MSiN+iH0
	jeBZgf+M9mnV1bmJc2Hqu+HbsKH7E3VMX71QW+/GdpMcYQG59X8aHpw/oLICW0KK
	rr+N5MOJ2dKvASQxBE+nyWl9rMMvLUOQLsYBhv302ICIEpZ1LSXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacb6yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:02:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AI0tum030559;
	Mon, 10 Mar 2025 18:02:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmandj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6tH2cjiKOt0Pe/zvTiskN+Qv2t2ClnOXWiXIVOt2Tn1El930nkumup7Cy+/iMSL5HE6EpoQnGcTgy0IyoDQatpo999zyHwZxmS0Tl4r10ZodE+Zv1QrpmHzWnk4Q9nXM+A9KANT/+57IolrxLRBPCELbsqOMhrtL2xYMkgk113Ckuhg/2bL+V59prxQyoSuiZV8eObXilObsCABzw3m4iuhAj1kwQxWBlAm9ZGeFuIt5CGPnVFGv+oeUyjn0ABFo+VI60J9kGT7R9sv7qJ4FyIPsx30lGsDIsrAHljGnUjE8FqHfe+4fR+LSlmAujXNwK52xWH7wllnmtIFFm1P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgbp5gdB0Jpf6omec0YNED651VbXUlmx1FIqaJlSPbU=;
 b=Nws1InB0SxLp5cpFRwIzzkNtJjFlCs/0C4gj9MfCRDofLFl8VlGQ5SAZifSI7DKwOIfukvBq7ctPYkomtMDz27BNzWI4yJOoFreGbH/x9N41SwJzofGvqNl1r3Cz6RbBMtHXkZK9Ze+sDK0JKoMnO0JdZUU9AfkqnQVBCkeNNoRkN0bF3SbTBwR6Hv0/MZ68jXeD/p6Km8V7B7Ul2S0JatzvAME4hb6P+05PkxDjQDQrJFGGsYG04PDfQ5tY6Q5o2CXPimWj+LbulwwaQy2udNIPrPqogjvY20Da9vFCvP1hBbMxMG5zZ1rbTAjOtwKH9T/uLWmnsrax5IVDEl63RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgbp5gdB0Jpf6omec0YNED651VbXUlmx1FIqaJlSPbU=;
 b=LuEY7c/WpuIcURXYdc+uAZ3HcdGDlbROWwf/TxVGF+xoRidbp+IBcDXQ6PkyyPbv/JvO81Gnl/FfVfbXWXTtsJ5M81hFKWtWC+dKDIHGh4Rai4V/tJ6Qjw1MPRn64uyxb0+1SY98fFMIR+kRPZqR5atiAXLpK9tjvSosb/8vrbw=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 10 Mar
 2025 18:02:32 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 18:02:32 +0000
Date: Mon, 10 Mar 2025 18:02:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        oliver.sang@intel.com
Subject: Re: [PATCH v2 3/7] mm/mremap: introduce and use vma_remap_struct
 threaded state
Message-ID: <4f9ae9e6-57ad-48fd-a861-0e18885fb0ee@lucifer.local>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <1aeadc40d377fff8796b7c114cb0351c92a68f20.1741256580.git.lorenzo.stoakes@oracle.com>
 <f3f1c8cb-b553-44b7-8c7d-7ac2e267f849@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f1c8cb-b553-44b7-8c7d-7ac2e267f849@lucifer.local>
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4afd57-1d0c-498d-6a4b-08dd5ffdbaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d1PHZ9i/pKPtDH/Utq8lHstYyh4Y2UJ/n50/ntdmnTb70XUUq3+bweTs5fmi?=
 =?us-ascii?Q?nehnAiFAd0ajN0xvgG4R807YkuuXXbPFgCgYTvKQ1Q70y+p6R2G3iGVqExB1?=
 =?us-ascii?Q?zPJWXnTvXmy6SLVA/mwQkmECJItNGJAcO7rkeV7kBbfFvF2AaaRWvrL0rD7r?=
 =?us-ascii?Q?p65EHEruCm/WYa7G3dRjIfWSwfGU/crUXQC5Vfa6x5eS3aHIve3PEhK67qGQ?=
 =?us-ascii?Q?x8LWrAHbB+Y92B454v9akBDkesYRKufhChZ3bu9FsjqWB57JbeTxsx9kx7Dy?=
 =?us-ascii?Q?yQvSeQvJ44akd+Ubsr64TorhCpzi9N9rnVCBWCXE/k2IiQCL9HcOygSyiRr+?=
 =?us-ascii?Q?cePHUPh4W6+IuuAOp35YkQi/VWqxssSXryVC/ueJBSY+zwaWWvD07R3RBCoI?=
 =?us-ascii?Q?jWfzepLEu85csXjsH1PBBJRqvF3u49BH2v6bknYweVlraTYDBch93Q0ATAmt?=
 =?us-ascii?Q?nD5/N9FoQAIIYt3V7HYfV6hAif6dxgdeMdgKmtlRUg5URNpOLBlzDZEbJXDn?=
 =?us-ascii?Q?Nx45EeoXb931gStV+sQSPWICZLVg3/p7wGI2G6fB77Pyo5Hwa52B3uDJp0Ff?=
 =?us-ascii?Q?Wy7grD9pkgim0BZ1MkCDTea+KCVHTmc7iCQE9LX/S05jG10tqZO6g4fAyp/L?=
 =?us-ascii?Q?hbLwRjtTeVppMbFm66lcctGdGBm9y8BxVDZgoQlyMQ47LiaZhSohGULKoMmb?=
 =?us-ascii?Q?t6f6PtMOumml1s+whtttJUKjIpynW81dVlk3mNVLovKasDRJnZ3PVG6r0Qqa?=
 =?us-ascii?Q?Jy548ZK5UTt/a6wVjdog98M8w+WxiC5RkF6wqU24e1lIQJH/LbOvOolqRJSx?=
 =?us-ascii?Q?m1EB3anUcSVf4USXSGwIFJDXtfi4aSy6B4eO8Jc9mc2jkRJK98bD2/UlXbtM?=
 =?us-ascii?Q?Qek9HRgvTGt17O4TSgX494rfVCoDWURvlW/A49XRF4HFmRWgXSKh1E0oe/MM?=
 =?us-ascii?Q?P1PTks7imNTiWQx2TaQDUWyODyII2vYHVli61p+Tdso4V/Bti42ASuYcuZfI?=
 =?us-ascii?Q?C3Mad7aTZ4/VMlG3fGJL4lHwN66a6YbvRFdodC72mCYPF1foMclo9c0SjA7z?=
 =?us-ascii?Q?U71ebJTLRGMrjnlMEJLDk7lwb3JyhPElbuF3kvrJzr+FDikVNFK0e0yh0qS0?=
 =?us-ascii?Q?E853+igrxCMs4OMzqLoixDTxG9KoqT3x3cYdvNa/I8JYS/e2okh8zkwfFgJN?=
 =?us-ascii?Q?O+uoD4STiQ5uM33xT/pzw1niswyFxtklo0dt48J0uPLx7B8GKWKpfuhWKK0h?=
 =?us-ascii?Q?KIaWlZU1lROZkX2strKmIGkpkHEWdXvB2HKVs/yxGUCXrlhW9d/tsgvlKsfo?=
 =?us-ascii?Q?lEl13mnxKQ1U8EsV7SWdr0vvMnT7EUiSUmIuqpDgsUbTN8iV2YVVAQHMUom5?=
 =?us-ascii?Q?JyC2tTYC2gmV+rLcPeCyYuZpLxdq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4newAWuwkD5LtrKzHl61s/by0+KPp6kSaUtXnXrG1bqhOOVB1mK/WEoivux?=
 =?us-ascii?Q?C200Ry1KbY0B1S1G2VgcPwDTdqxgoo/jXxhrOH8KZGX1ud/mCWqmMrnM9Z5U?=
 =?us-ascii?Q?6a8hMEQ6bA9U3zzSejLE2Ae7eANVnrGd8VlbA6gGhnPScj7kv19hwJKlzN8i?=
 =?us-ascii?Q?O+qedWWFWvHZa+FUOskzFL9/pkRzdOtHBb1d0pEK4YqAu2r/jqyOQqbA88Oi?=
 =?us-ascii?Q?yjIdft6S8uJBBZFieRdOntWD7jrom1oh2BeuMieP7u5OMCcFhkWDr4+WsaDp?=
 =?us-ascii?Q?ll+EK8McaVwIrC7h80LHBl+LhfHHqTWOIzStludMBDdX+p6k7RhE5mAhSrFR?=
 =?us-ascii?Q?ux1MjYre7KApAqOd6qPtQxPbOz649kojEnCi8HSIi2mwBxPsVRyQx20IBQWM?=
 =?us-ascii?Q?VcX3+R7fysDjHbgwU1uhWD5IVhRr+onKSWKRgwbjp0ONEvdAHUhGJBgSXrlR?=
 =?us-ascii?Q?ThnaUQCJDlPqip9A/KvoJxZkONMYGoIERdk7DyKqtuUNgEPohpT8MoNpwu8P?=
 =?us-ascii?Q?HRRD7RMTtOoHNxrSQFT0cYqIc0FdCWx+KVzf6cBB0BWcscgvUqrRLUeH90WS?=
 =?us-ascii?Q?dH2y0g4Ei8hL8QBFi/RYEEDZe/Ll4aMfMvOqHiVD9e+4mAbe4JOf+GAFenoY?=
 =?us-ascii?Q?Tpeka1Gr/fBqoMZO5UCeRFKWiTzLDQuIKVtrr6TZTt2ZP7diSqsTKJ3r6cSy?=
 =?us-ascii?Q?QiIqu3ZgDjwaP0iHEXWPdUE9mlYJ4uiK2IT2EnuxWUyAefG4j5W+TErpUh1d?=
 =?us-ascii?Q?gpOSacb4au+KAd2giTK2qY7RbLMMwpslMsRcVLIMTP4jqXR4lrhzN54tTair?=
 =?us-ascii?Q?kU5SrIIBqnUYSppXwCBlajnd2VhxP7Y+o3/w+msaHio3c15Kl0bCOUZ0Onec?=
 =?us-ascii?Q?XYZpTRFDilV5b0b/onBz6dQUB4EA22Fm1maA6KJxGXEMO4Erinan4Q4W0928?=
 =?us-ascii?Q?t44yfdFzMBSGsYZzQ843KTzOZtSSvdKh8lcm5ZdTn3XrbNapvge3SXG6LKnh?=
 =?us-ascii?Q?qDCHEEZBwuYjwRkLWe06Uq7sQjbTwVM28QrXbdhhQ4bFI7FZBCL0h1gUA0M0?=
 =?us-ascii?Q?jKrUJe3RQbJG7Sdyr6e5HrohB9W1c5pkWHy4OO/TqgV03F7iwEs9qqLmeaOD?=
 =?us-ascii?Q?wOXt3uuOIY3xyWVCmqJNOG8qSkuzQJbdJ6YckA2b7cciR283AVMx8nCINEQU?=
 =?us-ascii?Q?ELdF3LZm9x1XRIlD5gCJxBLl4y3ySsBTsO8leBNWZBVYYBEMTua8WXY1Yw6z?=
 =?us-ascii?Q?sksuHs3iBD8YaLY47N6J6PcrnJGWpFnrtE1e2QmgRwOCwqAR9uaTx+NYApyw?=
 =?us-ascii?Q?zCb3K1TgURm4tcsreBcayrJyPjVo0DRgSvEj55UhyuPf7/GMkEnum8xXgeRT?=
 =?us-ascii?Q?Rb+DtUhiD0XcBWQ/7wGNuWZPYZFPCegDBriNlj+W68XLqgEvxzKQ+qYtR1Bf?=
 =?us-ascii?Q?xEk3S86v2b1IiigINKpwZ889e552+k3Wrf/MNBfm48WNJwlXKdHm2N3KKYhB?=
 =?us-ascii?Q?BSdqaB1KCCs4M2/98iG4CM1QJYwN0EDgi3t05K1D2pea5Pn9p/BwgyPsQXEx?=
 =?us-ascii?Q?Cle/57msSj7ltBOv1/IowqNWBcfW5Ve1RU2DNnDoyl+6m+C/0az2mwyxU6hh?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5rT3N6RT++Zei6v79c8hxyh6Os/RJcHco85ctO7rZKerbNgkOOaybc0pltI8njnVHHdmP4CQBs4dgzzQMIqvagRImHc/Bwly/AYzowCVE73f5fEI5PH76p5zEvL+alRDKZDPy3oQLewcpJUvHXd3ZRclGylpTPt0G1L0IcQAvJBrtzgalnU4irDSUy4K+VtiDaaGXRpJNW4KpW0gtb2D+vL4+UCPH5sJRiCwRrLzwNK/Iq9kEvZVDo3NJC4foI+UGz+0FHKMqWxe2/maCE9gWkWSz59gMNIa1vzYNjtgTHZEJJdJv7sdwFvvqUIUl6jN9/DelY5LvFcMrANk1Ldfy5GzjjIytGFfgUDS8syR5O9gCPBr2v1WJOYmHdgw9v/vVVVbkfowwRezoml4085JZzWF6pK9CfC3A3Pi6MmaLKGV1+VcVssJ7er95sdU0QpVp1jG/C+LirDRvmh+fO7BkNPwuR+ESYErpf76moWAdAyULf0bgDLdGeKsnvg338lPSxyT5lDxOsS5ymVeJRJUFU2HgySNKYq6FSeickit1QLe8WfZM+dQMdn6mf+fjO4mJkwUn26i2gaTtl+b+8hTcf76LKrXZZQJTxsMsCsgv0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4afd57-1d0c-498d-6a4b-08dd5ffdbaf7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:02:32.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMmaHOdJSDCRni56dzB1nKutwZukHdQnwHAod1+QueDn1QmK/4UJhS9XmP3ZxMxTpmwQ5QW4zBH144xXWqcjy0xpian4tiRt6ID6vdqRihU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100140
X-Proofpoint-ORIG-GUID: DyxXFVUBxLrVuW4-P1WBhzzpCiT4SYc2
X-Proofpoint-GUID: DyxXFVUBxLrVuW4-P1WBhzzpCiT4SYc2

On Mon, Mar 10, 2025 at 10:19:17AM +0000, Lorenzo Stoakes wrote:
> On Thu, Mar 06, 2025 at 10:33:59AM +0000, Lorenzo Stoakes wrote:
> > A number of mremap() calls both pass around and modify a large number of
> > parameters, making the code less readable and often repeatedly having to
> > determine things such as VMA, size delta, and more.
>
> [snip]
>
> Hi Andrew,
>
> I have a small fixpatch to address a corner case below, please apply!

Actually, will respin so I can address Vlastimil's comments to make life
easier!

>
> I have checked locally and this applies cleanly at this patch and causes no
> merge conflicts when subsequent patches are applied on top.
>
> Thanks, Lorenzo
>
> ----8<----
> From 14a22fa872e19b468b6d06c15205efe77e460ce4 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 10 Mar 2025 10:13:17 +0000
> Subject: [PATCH] always check if !vma
>
> We perform VMA lookup in a couple more places which, in theory, can
> unexpectedly fail to find a VMA.
>
> In these cases, correctly indicate failure.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202503101328.442cc724-lkp@intel.com
> ---
>  mm/mremap.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0ab0c88072a0..af022e3b89e2 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1066,10 +1066,13 @@ static unsigned long shrink_vma(struct vma_remap_struct *vrm,
>  	 * replace the invalidated VMA with the one that may have now been
>  	 * split.
>  	 */
> -	if (drop_lock)
> +	if (drop_lock) {
>  		vrm->mmap_locked = false;
> -	else
> +	} else {
>  		vrm->vma = vma_lookup(mm, vrm->addr);
> +		if (!vrm->vma)
> +			return -EFAULT;
> +	}
>
>  	return 0;
>  }
> @@ -1108,6 +1111,8 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
>  		 * this can invalidate the old VMA. Reset.
>  		 */
>  		vrm->vma = vma_lookup(mm, vrm->addr);
> +		if (!vrm->vma)
> +			return -EFAULT;
>  	}
>
>  	if (vrm->remap_type == MREMAP_SHRINK) {
> --
> 2.48.1

