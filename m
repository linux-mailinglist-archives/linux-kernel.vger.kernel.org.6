Return-Path: <linux-kernel+bounces-554412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 843ECA59765
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A969B7A5E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331D22CBD8;
	Mon, 10 Mar 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UT0MKWKI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fg7YcA1+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228722AE7E;
	Mon, 10 Mar 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616439; cv=fail; b=u9XAOfY4E9iR7KtYjsMN/FFVxEFmG1kbRgcl6OY+6IADSkGHycLqzIF5r3H+d8jAIyM9e/8+pEGHhkxcQWt/PlTWSUUiMeZ/35OAylad7fi/dQQCzIgW+OBj1c/Frf3XZ3MCxE7n+0/JTKMoQcWiEADvoHAZ7KzzAnmvAB5xaWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616439; c=relaxed/simple;
	bh=0nZwSso80X3CVQi0EFeIYWJiKwvrPZHUc/yLBaE3Gko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yklr1wGuAf4hb6eR+NdD+cOrkBoa7pxF7/kUlFh2O+Yr/TedIUtyY8EtCiPVlMRn4qt9WiEj0YSYp2NgrEkSTqr6Fo3dpMVIbaFCCTuxc1kY05GVzMZtJttIkCTrOyd/RBSQXiEsML4rgrMbxrVdzTMu3C7O1Zzzx8yqyqYl6QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UT0MKWKI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fg7YcA1+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADwQOU003856;
	Mon, 10 Mar 2025 14:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=g/V4KRXalZq51wzi09
	HC1Fn5mjW4FGgsiJ7TaSiw1oc=; b=UT0MKWKIztNtWIZcc/soB72c49xo8rmC5T
	SrhUdA+gejPX2QfJAXNSVrIDVAW8DmEMUM7u99qjrYyOlQ7Ljjl6fil5Gy1JqM07
	vqM6Hvy9wnZ/5R9JqxPooEGPnroszpm/K46sOKEwbwF/man6mPxqu5NhKxptl7xa
	0zACU5ccRjQzcMPv55fnmzXkzEXko3YNjPnXhF7nDmSXmokUOYj251N4bZo+vRbV
	Kv0/N5heFyZP14VvxQ+Ea8L41CDmItXtW5etMkXb88crWvWgj2eB73bSEBkBNr5M
	3qdVVVUq7LtSX84zqZo3hwKbaociFjOZL86zp21RDqPKllAwQGXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb2qwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 14:19:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADDwAR017599;
	Mon, 10 Mar 2025 14:19:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb7n6m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 14:19:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlx3uzjNSank8CtQE3nZts64lTuDSJc5PkVdyQKqnog+IcgV6NVJdqWn67GJJPn4oP95bJNj7X/Cyn1zEn4QhXylSBvYt5JTQGhKu8OHxBj50LfuEovLMTXWZYnNnMuzAyImJ2KTKxukJmhYYNNGmCnDN+o+lhGv0gKFellocQVNhgnw/YNOFXp8i8rx9YvU2yYxLadC98m00qR4isTWjqJiFkpZbGD8h5FpWz62d0VkgT5qHNav381RdJ5xoOWauCFzN0VHpJZ7xg4ois8ZLaHHKmB5AeuV1nicR942VwUkU14N/tAnqy6aOeM2QPQOOkVjX/CupO3F01qW3CWg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/V4KRXalZq51wzi09HC1Fn5mjW4FGgsiJ7TaSiw1oc=;
 b=tMR/T+kAYC4XdxX0RMcMLhLStKOt47ITjJ21xKvm6QNNS7Wq9W82Da8TVO3FMxupAGhhADH3eGYTrqnjljqmTjcdfdZVGOf3Q6NeLjgNASXGySAkV13KNbwJbiTJ6QuYoituiT9LXNtlTvCKjOXBhw2cyGD4i7+w+AJ4zb/d97nFGKHcE7U2zjZuQIjqjygs1rZ4u7Cvcl6zlgz57Yj3O+TR+2XY+zFyxzau9F2pJVVAwMVZkK4Us/EXNzjnF6CqDv5IkzssF5awidj6dGb/i84yqq1reFv+X7F8clEQvaQHa5/LoyyWTzW++z6VdtaB80qQ1j1Uf97OKHnwRN4feg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/V4KRXalZq51wzi09HC1Fn5mjW4FGgsiJ7TaSiw1oc=;
 b=fg7YcA1+wd80COIgKS873aU5Ejk3hbK3zc0kESiEIz7a7WubDAzWApXfWmb4zTQ0brfGw+WWhgOJnLTVUcS/U+Zmu7aIzqt49dYbuFRrz+Zkfre+TQSqm0Xs0tSNymg76vbsx6dvdrSPm9EdQj3hQlSElk5cRb2rY5cPom+r53k=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA1PR10MB7791.namprd10.prod.outlook.com (2603:10b6:806:3a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:19:51 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 14:19:51 +0000
Date: Mon, 10 Mar 2025 14:19:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: kernel test robot <lkp@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v15 5/9] mm: rust: add mmput_async support
Message-ID: <f8da228a-fbc9-413c-8fbe-cfbf074a3053@lucifer.local>
References: <20250304-vma-v15-5-5c641b31980a@google.com>
 <202503091916.QousmtcY-lkp@intel.com>
 <Z86vpQBMYuonWsM_@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z86vpQBMYuonWsM_@google.com>
X-ClientProxiedBy: LO2P265CA0400.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::28) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA1PR10MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: b2217216-05ee-4892-6fd8-08dd5fde9ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BCGtyqgAdXf50foqHXbEbTkSnNautGG6viRhaPVrUuMh9BpCA0YNzU2z5apT?=
 =?us-ascii?Q?rfce6n3HY3LbWYa0mLCA8VO70SBmeYhMC935z2J2spBpENQv8HGlz5OBcUo8?=
 =?us-ascii?Q?Yj4+Z0J7Tik+TtUKsVBL0/Ua6SH2EGPEGGYkp74K+QrBeLdDhS/7JwLFYbI1?=
 =?us-ascii?Q?k8wqNPg09mSniwbZCVuv4cLllaatYcrg0PWqQx4X1YGOGW7OMXyZQySIZjrV?=
 =?us-ascii?Q?M4s/Yu4VvX5ffg6plPnSd9yiZOCD/NKUTiAffS7N+ae7nE9eb8sNHOG53odm?=
 =?us-ascii?Q?/ThXaN2CCzp1pvaqR3kDgaBwQPQmgPuooriO7f1Hto9/ZCShxU88QsP7HGNO?=
 =?us-ascii?Q?dzsuwv3cB6k2QEafZEr+ZNnsfV/ZXpe1tMaKaPqYtb9ZCEEE87HbJq836Xc5?=
 =?us-ascii?Q?mgnfTc/obDGI6kJ30NOU9hkJXFNnAshxsgIV44e3P2ymyChbkara8rgn5/ND?=
 =?us-ascii?Q?H45EV1Pl2Q2yTTdAU5eiCBNKZi0FiPhlT2fBi/Rg8smLe666W2Stz2f1VqvP?=
 =?us-ascii?Q?WMqgPukwOgkv9GJA9qJroVD4hkKUPA2b73mV1gSjT63NfxIwsTHhpPwxVD8c?=
 =?us-ascii?Q?TxvSSEG9WDSwrNgHiL1HSk5WQYglPr6U4VcentxbVkiDLRvxjuz9tZI+PYka?=
 =?us-ascii?Q?B6T69UDxWskYi0Psy4zrVxzME1ql+N5vQ6IWzrwa+V1YWv1UOxvB2E9a1k5Q?=
 =?us-ascii?Q?IWAj8npiAMJtkDulLQDcsKudJiGYAKC4rdZhpacWx+c5BvBuayyCyTT3+FIk?=
 =?us-ascii?Q?3/W8ONDDi0AxJfmQ4US3vtPUy4lBbh0I9T/CgCEI+F8TMcZsxClotI6PxNxc?=
 =?us-ascii?Q?Wr/tN8vhTwI9k/vov8UCUyxcIZJQuSoC7jXpOvtMJETqUDQa6a/Ye+DNECoM?=
 =?us-ascii?Q?FbsdVVyYObVLNGLMGWvm7KcB27aQi9omJDd+/9jiF/9F4laPjL1lX+fmb7K2?=
 =?us-ascii?Q?GFOTQGLgTObjirp8rVawo0uLret4bxAI5yM4BVp03jP5iVC2SW6RilAKZRGR?=
 =?us-ascii?Q?MrHr/26Q8rzwwsAq1A3Gj88O8A/379MeEqi1TeTDlp+sITieZgVdt5cNFqo8?=
 =?us-ascii?Q?dL0+gLNw9yP4DD+OFjJpUaI1Ovf8GQbrfadH5PFaRzISoTWAE+5RJln5l/dF?=
 =?us-ascii?Q?Tgy9beYRzPcIpW3NFh/gbAASAYY1r0Lc1gop3fK4ElQGqql6PFv/i8aHDehf?=
 =?us-ascii?Q?CyucCm/CcQIlOBqGhyAvGX56tRGPuuhWb2nBLeC81jkfebMfkFUO/0/kSz+A?=
 =?us-ascii?Q?+U0uIr/Lw2u2cby4x2lkgfTsqRHenk+6zEUHbsz05+b98bLSkgLDzSB5Dlm+?=
 =?us-ascii?Q?aUdKy8rBD7SPzQrcJjO0Cp+2/HAuIf9mdw3sI2kF9u1IEXmdRDmBYDb9jfIl?=
 =?us-ascii?Q?Fw1mwp6oKvb/9S3MB1A7tbgzQvH4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tgNf4zJiF2EkHXktclbwOrKYLmY4gVTLQfovwXSLPSn67+hCdk/8eIqebmzT?=
 =?us-ascii?Q?gIq3bvGzFbuuj9C40vraLogbh7CFQD5KplRlnfC1qNJLXkZuiG/MXlP42KU2?=
 =?us-ascii?Q?ejINo6BMvruU7yldFY+g1CSx5gR9SglahqNAyJKu0ski9RR0far4ZNhXi33L?=
 =?us-ascii?Q?0BjFj/DJAj0Ykn0qNGGIQKmiS8PubKIH6pTD7Hcb9/S7yL7UMaRnoFCtOb4c?=
 =?us-ascii?Q?MV2AOnEATr+eQ6FQxFEbE8wVLMVQCZ1J21rtPFSbS8jVYk/nicCQwDl078KU?=
 =?us-ascii?Q?pa1tZT1KJOX7+TBTGBRVZ7G7UV54TVEKC+MV6LpAdT+xn1sM1Vtb63asSuo1?=
 =?us-ascii?Q?hZ+VuL8ctrdaeCaP7xsZtux7rY0A24nAGhlpGw0aP34blxbtKXudm0HGz7cA?=
 =?us-ascii?Q?lgNUKduPz+qXPUYdQFCfz5C8B8a0EvBSe1iMIkoZiqWESJK9D2BCqZnQUMIx?=
 =?us-ascii?Q?7x7RjEc7vELNKk2pGv8I4uuEsOBrLcpET0OW9N5DN9nWIK4dbJy5Q/fxY4s8?=
 =?us-ascii?Q?n0uZh3G2g6cXxOF6nQ0dAxRz81kSMcuMY78ZAqaXPGemv34t2Iw1toZqFBcy?=
 =?us-ascii?Q?5O5s8+yoENIbHtg8YAq5gq5TrYPZ5LhnliofTe3DSt+oTPSCVbKn0kt1xHIh?=
 =?us-ascii?Q?AJDStTW+egFS38iAt5qGZjr9/LrxhdtkbQ8uUmMKXizPcc39sE2J+5Cn1pYB?=
 =?us-ascii?Q?M53TM9687Ay28cs78woTy67Cbk54pxJY+yBJk5MVmga4hd221SGL4yoJwZ2B?=
 =?us-ascii?Q?/cQRpilg+ppi4R5C2YRu5dbmyapd906jSpX54xcE/qL5epGfcozNSnLWvL7W?=
 =?us-ascii?Q?M69YmJlBTeDEov2No6fSgGUPX7F5Yp/tpKJAstB4YOWles85bZyT1n4C4NUE?=
 =?us-ascii?Q?C2uerAGAZYQDeuaV8Kgz5j8ckLbrMNmUbqrB9lgEG9+5/qNlbrPb5so/uAQq?=
 =?us-ascii?Q?WH5woSiCjDyyEmohwQVftZkKkxR1aafA3aOl7gPguky5NyDejS2MrgEDHQsM?=
 =?us-ascii?Q?F6qkNKKwK8srSYGTlJVHZsmt+OA9hwbUslm2Mr954WGu385D5CkwlHxeWo1/?=
 =?us-ascii?Q?DvGt0/i/mIoOfp1+bBOdVejc1XhfuA45IvXiD81gplFOs7r5PmKhIEBcriD4?=
 =?us-ascii?Q?00Y5Yf8uMyIJ2u2HRFvmkYmHuwS1yT8iB6fP4T7arK9a7Rrx/dwTpnTXiuvx?=
 =?us-ascii?Q?m8CBt+QDR1gITjl6BYOGUZARzJV2MGzENF90cy2/gH2w1AHRgO0raPI409U3?=
 =?us-ascii?Q?iEw7uHAoWhYnZcoJd7l05+cI40mzINdqUrs06LgrJ0Ivi2fb/NBltsD13R8T?=
 =?us-ascii?Q?LQYWBMwSLJl8GRrPDFKMaAzJS7FNxxPlLY9++LiQ/njri1FHJ2AOVbyAuNMc?=
 =?us-ascii?Q?ebiPpdRFylnwLDq5AWyGUamhxTq3AcmtkW5cl4Iky20Cey15PRr5FctTEYSB?=
 =?us-ascii?Q?zTmo0MjHBhm9BHNE/VxT3EAsY7W8umbQPeQ+Zhbum4caJaQ8KPmpzNWyud4+?=
 =?us-ascii?Q?Tyd2iDKP+cu2jDj/6rpcYLyBQJyo23QwpNy/pMZ+M+EmpkyviLF6GpuDhM04?=
 =?us-ascii?Q?olvPhNlm500fYR1xQQPOlJA8zXrsX4SEOCfiKxl7VEBd95ZVeHKSfkuShiKL?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fstd4GVHeaUBKmpw26YkQPFTfjqwfS2SssMZ4XxwrYAwyRuqETccBklw2gVFMkJnvs39rEPv/zERPeMJQUICJ2aLJLkUWtVeg5tFV2Eh4thAoMHofUyK0GDLwE0HSK7Wz+MIeqK9NTP2HQ/aF9Wa4SpvD3R/YFfjeMV0rZU0eyjUW38y1lgypNfPofyiNTTxlE1XYakp1Kp8ceA8lHKFKOlELClyKjwWbv5Edb4s2Ala1X6/NRlIn4dqytVV9PFqLxImAOdhNuEhDLYWwQOXdicQb8TUAyYY/7Ynip8J2URyfwj7Uy3zX87kFXItbDQgXqFEVtza7FdL0irOOlTIoCrjQZtUmXu5YLbotMUZ/ufOAIaPTg6gtQXot7u31/75q/N2fXEwub+43RRqRiOlwM+77gfAzsQNDj2WcjZRlZsg0da52nVq+FT34j96Y+Nj0mDe4Nz9B3gzZzJpFHYmZfx0NamB0v8yj0kIShG1svcy20WHjNW3KCWnr/7FOMkptFXEUEUtjpPFKc60LCpCMiV3WWu3SsDJyHl1zo/BvCC7LxWghAFjaGNYJWQ1nSQ5tswVD0QFV530WplE+Uk6QewukFcoRjAnPBkJw2BJLmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2217216-05ee-4892-6fd8-08dd5fde9ef0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:19:51.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1emwypdheSPYtqYPmdpg3+EZTlpmTcqq8Vih2bpdtm4mvZ2bgzLnBDibbC+af/Yh1nmq3ZxRs5ghybvjx8DUTla5uzEuKJyk/F0mMiAOd0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503100112
X-Proofpoint-GUID: HpbDvwZ6vUE2EKdo-AHpdVZQ0FbhUoCS
X-Proofpoint-ORIG-GUID: HpbDvwZ6vUE2EKdo-AHpdVZQ0FbhUoCS

On Mon, Mar 10, 2025 at 09:23:49AM +0000, Alice Ryhl wrote:
> On Sun, Mar 09, 2025 at 07:37:54PM +0800, kernel test robot wrote:
> > >> error[E0425]: cannot find function `mmput_async` in crate `bindings`
> >    --> rust/kernel/mm.rs:143:28
> >        |
> >    143 |         unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
> >        |                            ^^^^^^^^^^^ not found in `bindings`
>
> It looks like the mmput_async function doesn't exist at all when
> CONFIG_MMU is disabled?

Yeah, !CONFIG_MMU is a constant source of headaches and pain :/ is there a
way to just require CONFIG_MMU for the rust bits? As far as I'm concerned
!CONFIG_MMU is a relic... (not everybody agrees of course :>)

>
> I guess I can just make the MmWithUserAsync type not exist at all when
> CONFIG_MMU is disabled to mirror that, but it seems a bit weird.

It can sometimes be a bit weird to figure out what should or should not
exist with !CONFIG_MMU, some things end up being bizarre without it.

But I'd say, if it relies on a CONFIG_MMU binding for this to function at
all, then it not existing with CONFIG_MMU is valid.

>
> Alice

