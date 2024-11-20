Return-Path: <linux-kernel+bounces-416252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9089D4289
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276C51F230E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35571BC9F7;
	Wed, 20 Nov 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GEJCNVxE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WwzTN/Cm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D5824A0;
	Wed, 20 Nov 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130449; cv=fail; b=UHRwRo98cdLLmMCD02h9wpZXcvf628Axp4pMZL9Y0tC4VZtYlz4RhJIAjeoQgK8LQOxvV+cXCVuNfG9tkssQZxeVAUgvWYHJpIOHQSlsLi95BzoTKIBmLj4yKFjXt+Ybhwyuc0cUqYozaVwESLTxgsj+S7ppslrvq4EPr27Actw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130449; c=relaxed/simple;
	bh=GVsSKXe25Jy4+0HQW3TqR0br7CijoWVcyawgYvIXULk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KVzmct8JPlojeFjY+X+tdZ0u6ql4GNEe6JzAY+6zs42dcI4yD44g+TmCm4xuvAmC/lrm2rhUU2pt6iS33PBThZ6jrSxjQQ/qOJg9IQICEovADZBB526ltUX5+ON+xw+mbC1lSBG5Lzl8PMlbNjabT9o++qn2oqHQgTlWtTQcl3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GEJCNVxE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WwzTN/Cm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtYxE029572;
	Wed, 20 Nov 2024 19:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4vCHbbNaGhu3xkwnyU
	2RfwiFAgmKcmw17si3YzauKiU=; b=GEJCNVxEJeMdjeHmwlYnzMTbvxIR5HdsTz
	pFctdYdPQUcAS4VDvyh/65bjHiddwGK6KKMEX6HAZRnwdt6TLCCPGuITjVfU5/0g
	UMhZI+w35Z3S0zu1lqeGghXGiRfTVxEX83+hvA6vIEfSp5QQm2kSiZ4FHqP6M3+4
	y7dZRhbnp6vk5Agx0qfDMwY12DPl4iLh7+PFubnEXQasmqP92Akfi5Rz+5y0WXbb
	JWwme7WA+sA+LrbRC5alrdj1GWaHNoEWRpr8R2ImTgkdsON87y+t/M8/PYYZlt9e
	3wwkiQu1OMXGLWv1YDKnxSFrCuUGI2B37DHIFBi6hHNI3r8E+94Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyyg415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:20:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKJ4eG3008457;
	Wed, 20 Nov 2024 19:20:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuak7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCpvjL+t0c8XXTLz8OIte2jHZZtDpjtd3xNPLnVARO9WZyrgKewzunrl415cnh2tt20F7vBsFyD8SaT/ps/X3bxB919rooPEwq6+gU15AmaeMW6wxjjxATaqOTJKBsDihZe6vroQUeZ2hQ4vKlfmbQjNxFuUl38sedDVLSNgTTuvS12TzVe9kgPGqbiu0I6yDXVxsygIEUezP6qeLCRFz0AIMVQdX6jdrLw92KgwqKhiUkcWkyVyppZzUd+SVje+mvOfyCAZEMkuAoqX07xSyJsUdDdCbIAcgjrI2Xl5k5/LDGusRVApOYC7PuF23l0Vwnt/SY0qxaMT5cd//sU+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vCHbbNaGhu3xkwnyU2RfwiFAgmKcmw17si3YzauKiU=;
 b=UJDygjVOQzkzKedrgl5T1SgCyRO6p0kvrlthhFDZPnBUjeCGgYP8JtNrja3bvWhclqSBZorcCQ3be3j4IQEw1DSUXNVB7rnf1t6oSaEr9iNA+sHfc89N635iwaECfAtYfTwDLE2vER8Z/GNFDvHh/TTsZlp58oS4AIIgqHseryi8sE+Cd4aiaTooFPVpVefrJ/bcZZd4e60l3cqKBrlcT8BMTDKq3+0KCcNGVw/0XSrSeOYeQLqa/XBnxOLpqYIXci1gNanTjdEDP5sXHEdd26C3uOaj0Ou6HaMB+G101EYbe52BopD4jNbf3ui/D1EGMorTxsejsKzxcdhkl+Q1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vCHbbNaGhu3xkwnyU2RfwiFAgmKcmw17si3YzauKiU=;
 b=WwzTN/CmbEN1WpulFcrWyn3ddJx1yb3BiQ1Z7FVRnSqhIu6bn+VkHp01QkMQyh1Mw/TkbbjPUdX6trmPN2oaSw4jlhU9LrMW8h+Z3croi1oyKqUcHwEYbWURCE2+PXQw9ihn01vt22GN8/mNu2hVHfEesnjCIlBgtFI+IHqk1/E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 19:20:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:20:15 +0000
Date: Wed, 20 Nov 2024 19:20:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 3/7] mm: rust: add vm_insert_page
Message-ID: <e5660b41-c1df-47f1-83fa-c243805f74cf@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-3-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-3-eb31425da66b@google.com>
X-ClientProxiedBy: LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27)
 To BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b53e83-0567-4302-ac43-08dd09985cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UuZOQQOKZnr7GTGjfoz7ePQZ9Bbyxt9ZQdzudIFpTGh+ln4g4fkwmJ1I9pib?=
 =?us-ascii?Q?hZohgMWlBuATZG36wUSyphwbl4zK76TN8tUtok/3wTY4+sIUjdvjkhlwpPfX?=
 =?us-ascii?Q?XDGu4T0oN2Kms6H9g3a/bXKajvz0WWMf35XYKlW1+BRTnUKi0wrjEX4A8N0S?=
 =?us-ascii?Q?g5R5Vkmf2Y8j8AY2zIBjI8i6XR6C5Svt+kcmbtKRLZkL00szHEGddP5jxkM/?=
 =?us-ascii?Q?AOxvXFaHJzqbIEaQ9pA9+oYH9zQZ4CF29dyzWWESTUe9DgEb7GHjKiRSv56R?=
 =?us-ascii?Q?2kgQSM8uzjDdcF+v41BJeyAFLsNSc4HTiXdbFklVwCT24qjkfZLsWFTXxUYC?=
 =?us-ascii?Q?bn9qP4i9iNW2in/KwOXstW/3IoSfH/c+n+Up++gqMi0xnE2HvefGMhhguq6O?=
 =?us-ascii?Q?p7GgEflFr4yq9qUtzKfdA7SvRbiHLsU8zE+mL4vCaeUOdOLrUWnnzWz2yoOm?=
 =?us-ascii?Q?zRIjH4RRnwTSYPAcHJ0ZXZllDG0AACiRjLcWfcjUlbySjNJ9iY8DxliCIL48?=
 =?us-ascii?Q?Jq+7tj3WRRHg9wiSCJlHTNGCsIUEwCCgSOW6WY6q2WR2mBIYb2gkrKhpLlrB?=
 =?us-ascii?Q?FiOoQRUFdKypOMGYGzn94dBD8+PFSsR67g7geCSarw14YetCYVCWiTKsK11n?=
 =?us-ascii?Q?2mbNOhBle0YVlC4pKly4Lz4+NqKaDd40nljPf/R6dvajRqXJeEH0/srKOa/J?=
 =?us-ascii?Q?nbwjOVwXBSWC7lfCwnfMA53d+rVZmsasHwSeVVQE+ucD3dG0EOwmNgk61nl3?=
 =?us-ascii?Q?jjGgjuZBN3Pd3YyQ9RuBlAdk5Bl9zTPYYJlSm4w4MMBgWaxcxB1EPURQvbw/?=
 =?us-ascii?Q?maehtXsr3tnATYqlrdwgI6MSN+0EnARXa+tm5L72MmJNdHFIqIlGT5GuqT39?=
 =?us-ascii?Q?zvQ7LDufTQtgwwtWoLuuzh9crM4BNU26yqfNqxYYrZHJNy4j0EC6KaHYeJAL?=
 =?us-ascii?Q?vB9qOn4LsDRuRJGwuXYvZTIv+Qn7ZGDVuByBMfN8xQcz7N2eBGxQzOrNIiK7?=
 =?us-ascii?Q?XRZ/ym3mRF+qSVOTLk+JFk1GZEsxI578kAdDQFnQDvUWbIL0Z8ryrgyVpBcb?=
 =?us-ascii?Q?OQ/16KTjCZ6ITUX+kNk2wxPXCd2iNq57kIWAIUW1EjRrjbfGpg92pO6OkGWO?=
 =?us-ascii?Q?/W258bsYFZwl2O/Oa3YFVZLkQlB2Caj+cmcAXM2AlzBLhSFu1JGIJmFU7PsT?=
 =?us-ascii?Q?7aqMzX2INRxHrcu9OTjN/yVP3qgoPTHQSBbkTWplnjc9GOnXpWHJNaZEMo0/?=
 =?us-ascii?Q?wM3rQRz7RrOqxGkqCB5wdWZYM8FRocz0cSfQxzEaguN2tFCxQKNW0wxnWZ4g?=
 =?us-ascii?Q?JGynCC/qzqiyZrYeoP3afeE3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrXzN/1FUmLhHkSPbl1FGQuTdIvM2v6zJ69atsY75j7Bu/oC15J091RmTjV4?=
 =?us-ascii?Q?Rk/nKLxS66Zj5e1DbVtLw15UKXA3Tjdb2uu1oAC+OYSqpttSMC4TyN6Al3Wy?=
 =?us-ascii?Q?FZFDCFR7FFIt3j0iBgexJJYs8S4MUshiCn+1KTcCSy1QWKr5jj/x+jzt2zZB?=
 =?us-ascii?Q?NymfTrFdus2yBJVqCT0Frlt+RHii2cpOPo8fILYO/fsaRTLBxfhaSo9Ix9TD?=
 =?us-ascii?Q?WeEQkcfoDQrjUGc/2VVL+wYYlPasBdS9ezHsUb4FATlwafaw/6WS8DZHOnfS?=
 =?us-ascii?Q?uJgTfRsy+90bPSP31V6e3FImoOenKTmEOF3PBiO5imKrerJk+yRkXJ71dcWs?=
 =?us-ascii?Q?Ub/0JPTcocLsZB6/MO0/mO7ywu6SGbD/oLRzspkizSivjw4OmUsTKw7b1tw5?=
 =?us-ascii?Q?aGeERoOHNHETvI8TpdKCIgHTrtC31n0+xuSzDYwkDWaTzsNvnoh/fX4azG64?=
 =?us-ascii?Q?uk1g3UzCRqPmEohljsrQKPYoRAZhXEioSow62caz2tLry9KqPx5JjVbJlcLl?=
 =?us-ascii?Q?6Ztt1gKHJ9ZQixYSfdhWtPVrTGRgMwfg04gGKbW6InQ9oXSmJvsmfcHLkfvM?=
 =?us-ascii?Q?d3OeZl2956qbw/0lU4NVl43eEe3wUmhC+TaNz7yJ5dercrkfynfpXlZPFP9L?=
 =?us-ascii?Q?x6QCo1Cm3z+jgl76q8BQ+efkL5p8g8bFJ1bzWoabvaYCypoHs/PryDWQW1ti?=
 =?us-ascii?Q?9GVOnhcwXWjr313VjArLQPHLPIGsl38A0THCwWkI2xSwOLexmxrttnM4ktfx?=
 =?us-ascii?Q?gNIb5HuF/B8RtXzMJLMexrOXKcaonzzSYsLLgDjAd/qCok3nl97qxdJ9Ltqh?=
 =?us-ascii?Q?aLLL39uuoT89dg/JRgdYcDJkBKZafQxSIYP2Nm26ZyJMe9q+fIQwsQnIWKPd?=
 =?us-ascii?Q?LSSOPqtU6ED9iXetdyCnb/AKgFWuiZ3BD6+7qJY1sAwwPkTXHFc0Pi2nDZli?=
 =?us-ascii?Q?p7w84LMqjAElpG7ZigzfbFau/nx6Kkb9GRFWev/xiObblFftees2VfJA2Ph6?=
 =?us-ascii?Q?8gZycJn0wIWuovqaUA5g2/UTPkBUoQ7hPv8hqhyh59mopXbSsDH0B8CWivyq?=
 =?us-ascii?Q?+9sHR6vmcWg493Nwpeav5prmw4CXg3CpSI7rmW8z2FJfRubY97FC7kKk/ukn?=
 =?us-ascii?Q?N7PHsADQyRRsM9Nkwj6XOq7D+40IWJ0qxbtmTAJziY+dmyi3s60N9N/vL0iu?=
 =?us-ascii?Q?bpneF7bnI2ykN0FicUcw7O5Lnq4oPwn4Bp88R30aRdq6BkLeGcGWkP+DhJcP?=
 =?us-ascii?Q?rpOU4MNJvfKd3dUY8alNApzjHwWGF4vcEnCuWLlldOVaBqjf3QmLIxkQwAYN?=
 =?us-ascii?Q?p4SrFXeUvm1+TJcpDsPbtWImGIkpSfx55m+U4el2QzjfnfB0olOGEM2qIUgW?=
 =?us-ascii?Q?e18n6UsvHVgG1F5LGNKdqWSPOmylbOrYlunTIAKETxPDWtoMvAg1kxUoctBn?=
 =?us-ascii?Q?1MSIiY5lmvQk6OdWY8yHeilw2TQhsnhU9qhpdbloTjMuSYsnu3KoLR7q57Pk?=
 =?us-ascii?Q?X17IXTdtpDzPST9h35fknFZK9O3UoOgd+cMDd2gLttXwkcR9xZL6RJ6JTp/9?=
 =?us-ascii?Q?igp5NzgO0mNeVTOJB9U3CdgoQttzOhg6u6mf8AGyAWHIJpsfbMorJ6b6x38W?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PqgQ6wcur65egvRrJQeHOWkbFQVVGxcD1M01ea+0WebOvr8nwe6ALSaw08MRB+9mM744fqgLhYcq3j2paAerGcHQi7nQ3CdzOK47TVGqrRvh2HCRj09K/TCDw4E+5OUJqutPqoeleOVVzOlmW2gfxL3jYZYpnic/mVsmco/alipe1/Uio08f8n4piN9n9ccDG5qv+SvXdWtKJ3j1CGTz787rPO9CP6Q5ks4eJ+sKPcgb5t7BddZlptX6yIChhVLlXZzWblDFzCHTEA+gh9WkwbnKoyDm7p4gf5X07xCKyD7PZSt+GDa2gL2apx6cCB/ML5bUN2r4DQy+40M2OEMsPohDe7FxmT22tvT9SmfTwONsGcqJWBCMYUbY8sQLx6gHJ/eZGHQKJ1IZNRnAhB8O1WpTa6KbNfb1OVxsDbJeQ2AzMk2BgeqgsZujCJoEw8gTXE3KGFYQSd35QF5tLisxgBtsve0S9bTkD6w88I6CX955Maajy7z1IyB4NcZW8sKw7OHKKkdNghHUdGMtQvIHKEceZfvZvp8oz185/O57G0IjKWVDnQW58EFlRhDRI12uiFRKGfS+s1uf2mq6t/MmWTqYe9Gc42wBRp2DNTWLc04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b53e83-0567-4302-ac43-08dd09985cf3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:20:15.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCpuLcfwG9QcwxeZ2gNmWiivKL8Xp/Lg57wfYFdA6DeMKSNEDbS7YMfwv4Z99vGu0oTNoB+zs3NplsUln+5dZnMloIIlBYbZy8sQldyRWSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_16,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200134
X-Proofpoint-ORIG-GUID: N_vvxBYPDsVgdJGFsspCbZjm2hiUEoXV
X-Proofpoint-GUID: N_vvxBYPDsVgdJGFsspCbZjm2hiUEoXV

On Wed, Nov 20, 2024 at 02:49:57PM +0000, Alice Ryhl wrote:
> The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
> flag, so we introduce a new type to keep track of such vmas.

Worth mentioning that it can be used for VMAs without this flag set, but if
so we must hold a _write_ lock to be able to do so, so it can update the
flag itself, however we intend only to use it with VMAs which already have
this flag set.

>
> The approach used in this patch assumes that we will not need to encode
> many flag combinations in the type. I don't think we need to encode more
> than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
> becomes necessary, using generic parameters in a single type would scale
> better as the number of flags increases.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm/virt.rs | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index 1e755dca46dd..de7f2338810a 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -4,7 +4,14 @@
>
>  //! Virtual memory.
>
> -use crate::{bindings, types::Opaque};
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    page::Page,
> +    types::Opaque,
> +};
> +
> +use core::ops::Deref;
>
>  /// A wrapper for the kernel's `struct vm_area_struct` with read access.
>  ///
> @@ -80,6 +87,65 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>              )
>          };
>      }
> +
> +    /// Check whether the `VM_MIXEDMAP` flag is set.
> +    #[inline]
> +    pub fn check_mixedmap(&self) -> Option<&VmAreaMixedMap> {

Nitty + a little bikesheddy (this may be my mistake as I am unfamiliar with
rust idioms also) but shouldn't this be 'as_mixedmap_vma()' or something?

> +        if self.flags() & flags::MIXEDMAP != 0 {
> +            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
> +            // satisfied by the type invariants of `VmAreaRef`.
> +            Some(unsafe { VmAreaMixedMap::from_raw(self.as_ptr()) })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with read access and `VM_MIXEDMAP` set.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
> +/// set.
> +#[repr(transparent)]
> +pub struct VmAreaMixedMap {
> +    vma: VmAreaRef,
> +}
> +
> +// Make all `VmAreaRef` methods available on `VmAreaMixedMap`.
> +impl Deref for VmAreaMixedMap {
> +    type Target = VmAreaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmAreaRef {
> +        &self.vma
> +    }
> +}

Ah OK, thinking back to the 'impl Deref' from the other patch, I guess this
allows you to deref VmAreaMixedMap as a VmAreaRef, does it all sort of
automagically merge methods for you as if they were mix-ins then?

> +
> +impl VmAreaMixedMap {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> +    /// (or stronger) is held for at least the duration of 'a. The `VM_MIXEDMAP` flag must be set.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Maps a single page at the given address within the virtual memory area.
> +    ///
> +    /// This operation does not take ownership of the page.
> +    #[inline]
> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {

I'm guessing this 'Result' type encodes 0 vs. -Exxx error codes?

> +        // SAFETY: The caller has read access and has verified that `VM_MIXEDMAP` is set. The page
> +        // is order 0. The address is checked on the C side so it can take any value.
> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
> +    }
>  }

It's really nice to abstract this as a seprate type and then to know its
methods only apply in known circumstances... I guess in future we can use
clever generic types when it comes to combinations of characteristics that
would otherwise result in a combinatorial explosion?

>
>  /// The integer type used for vma flags.
>
> --
> 2.47.0.371.ga323438b13-goog
>

