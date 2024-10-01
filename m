Return-Path: <linux-kernel+bounces-345692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5298B9C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7B71F239AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812F1A08A0;
	Tue,  1 Oct 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n34AXio5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xW/+qkXt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7761862BD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778814; cv=fail; b=rU1c9VOuE5mWsnHwhTu6nB3yi0awJ3bgIdGMPLF8hljPgEIdbm5YIRiaDJsG6XoHEi/BHnhMpF3wu3i1oI4CHxYsXeHcFgooeT0/++kwVMAo5QTXRdEcClK70i9nEh8wq06X6CuLP6ooQvUTetGfWFyW95D0ZoMd2Wqy3E77SGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778814; c=relaxed/simple;
	bh=7bLtLogSchkxj+JY6jKf6p0tuGstZ94uPdbQ/SQ/TE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qMMA9DqLC7R4F/VJ3ka0F0TR6w3mZvCzNw20CfmFEGyCCQzy1VYX07ybAhohGhR7EK0KfVodoXk/YJABiKjbfG6PZbRjjmI8hD7DfS9IfHMCYg/ND4NuuKld/H+T9e4DF4YP8VdiNY3ge0lZTmAuLKuG554fXw62YCYJA+KEkho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n34AXio5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xW/+qkXt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911taOo024350;
	Tue, 1 Oct 2024 10:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7bLtLogSchkxj+J
	Y6jKf6p0tuGstZ94uPdbQ/SQ/TE0=; b=n34AXio5I7JU57BrFikaEjyQ8rmJTNe
	RR4BQpDhDJQOkYs+TWHIRq5WR+SN5FliJOUi8IlQ+b6ffiwce9xiCd3iaPLPq93E
	IJ+v3xKtRm2n91GxURWxKHMM7rHzWLO2IEpsdV7hh8vS1ath+AawTJAWmouKHmnI
	J0coOvmNcF2YKe5C+N6I1NPg1y1WbRunB9L7WV2d6H0zrnMpqEEVAW5WDlOOCAB9
	GjMjFBb1alenZq8Sz7phX8mq4OVLKDO7z3ZaJecUZRxwzoBuyboBhZzpO/X3TjSW
	33saGefj2Rc4JMLslFpmzDY83JSYzq7bVStnSj9wKObXw3BPVRNx4hg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1dwjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 10:33:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4918csSZ017338;
	Tue, 1 Oct 2024 10:33:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887atd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 10:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oud2zpJEq20ragXIXEv9kC+pKEOg75iDLXeBeyOiKqDB38akNsyyHVzWEe0YO00wINIfQfkiGM2bHej4RkGblQMq4moYZNk0ddhnJlEB7hnncXlkrUw+b3c89OMnNY0Oh31hP6AcwWlqCsl2cix30TN0X+Om2coVU8l8k84XPxxdv09Q1ln+4Ciu5cu9ut0iohhi3jXQDpda/+xsYxcDXlQmtg1x6UYIdMqdBYZotM4obmXALnGk8ToF/6rxBmLI7y2Ye6rzaiKdAJzBN6qcYiycLRWzHPeF4TxvGDLlHkhCGwiVuXvU5TTSGS/kdyYvHNT0Jo6A04YDK+AXGEyafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bLtLogSchkxj+JY6jKf6p0tuGstZ94uPdbQ/SQ/TE0=;
 b=kTsuqY5DrAljg12E2BiUYA+kYy6GAGPtZcOfcfUQ+b+MjY6SVujGQWBBc5s04uwSA6PhhMxew7QzofSrTs0SV+kgrfB7h5eHioxRzbfbfWVWFcbZUF94sQPcVVClf0RNe7havrzsXF4OsWGzE7ks0ezwYR+wsnjyABhhPNSb1uzgj9gcumjtblw4+6R9wNWrU5vkJJolkv9y5+f7kMvKCjOkDITgH0P1sXuYJeBm105OGYNcu81JZe3kqfEUbU8mbVOwDl8XfzArBnbgTKD4Fqmu022djKyOXr6qyMSb/1+SkgTmrS8ToevnSh35dSnPmUrkZU0I6F+z0KvPcQaE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bLtLogSchkxj+JY6jKf6p0tuGstZ94uPdbQ/SQ/TE0=;
 b=xW/+qkXt7KLrKmzX3VUpts6a+lsJsGlaqJQ/fhG0szhYIWbaSn/CvRi0kamJmiQSmzPZBhKfQWdkrcaHsASZz+mMu5zjZWKQSLu+6GfyruUU0zeDAiKLPIX2vYqavFuaOc6djEQTrdOjkHOsL2sKhqN/E9PgL2BU4qQ3xdLnFgY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 10:33:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 10:33:22 +0000
Date: Tue, 1 Oct 2024 11:33:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <ff1c8321-3830-41a3-abe3-6b32a4f72238@lucifer.local>
References: <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
 <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
 <386f485c-5dec-4c7c-81f8-a23aa98a72e7@lucifer.local>
 <0e9eb75f6342a7aaa1fd0eee3dcbbb15fb1f6539.camel@web.de>
 <81235f36-7266-4ce0-8175-7c4d0e6ae3de@lucifer.local>
 <dac4dd705b0c5084cdc15b3bae4d363bc6448544.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac4dd705b0c5084cdc15b3bae4d363bc6448544.camel@web.de>
X-ClientProxiedBy: LO4P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f309735-1e03-4c38-682d-08dce2047987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/C9ZbCOmzqmJPjlfOr9DUw/O5R37b20CPNgqs54+Sx1a3xmaNTGb+9ICRet?=
 =?us-ascii?Q?NIJp3N2yQpFkpRoE+AzL51h8sw/JIlW1GAPX1aWARNgKDybNhuKTzH2FTEAP?=
 =?us-ascii?Q?NAEoX0aUDu8dImgWZPvxqZAe7U34leondDkm2r9AxIing6moFj2wosm0NLwG?=
 =?us-ascii?Q?3wy3lZV5hcX0uNNedY3VICNfEbXwuLPCTzHx3NcmRV4IIQagACfFka00HAcf?=
 =?us-ascii?Q?wG9G06XpST+zEkAzvmn2Ol3FEnbsaKDidn3nnBJhZzzFdwyxtgQI4ayVRlY2?=
 =?us-ascii?Q?gV7vUZhfiPoAqBicppRr19ZclVBeU8Lztm3GhilblDLKDQ9Rbsd0NGxFTzd7?=
 =?us-ascii?Q?PZGIyrjhcSNHYdPM4RhuqKQCM1MgcXfhiwbe9VriNd3phPf+xfMa5DE0acvf?=
 =?us-ascii?Q?ikKAWQnuwvR51LRR+CZYHYFzSO9e9hPM7WbAMrRXaK1Yi9Pj6YFvn3xiOWKI?=
 =?us-ascii?Q?/CQlbB6Du4rWDYRZxZZyixQJ7DLEDvHMkvpVD8VbVIM1SL1lDwqhaybixNq5?=
 =?us-ascii?Q?U67g0ZjD2h1N43m0L5HPSWQ9JwYTqxES4wyIPJFBFLWQzzR49VPjisSLVD5A?=
 =?us-ascii?Q?z6ucV4osh24J6s5kpGgUvF4vNz3Nh/vCvDgzzi9Y52HEHa6ptjmUD7eAnLiH?=
 =?us-ascii?Q?Wr2TxagmDPu5zUbRT2KURoVT7GJ+QS+ijhkQpVSULdxc8Mck6ibAJUz/amIf?=
 =?us-ascii?Q?qlbfaauhgSYJiwINjisRcHgB8MTC4lwqKHPfrldNDI9caD3zhX6qm/Jzc3Q1?=
 =?us-ascii?Q?yhyrd29RdoLJln3Wlc7ZKvj7pNwSDACpCyFEnoCV8kuhdOXxvVlyaxYVBo6u?=
 =?us-ascii?Q?jANytrsNrDQmOCZhLtCmQL7o5ROwUobvzzi0wjQNeYG/Db9A8i3h1CIuOVru?=
 =?us-ascii?Q?lz9puSTmihAqzg3MQSDd7u6etTQh1RSvonSbULPUht434DsrYcYIi4jTgDPr?=
 =?us-ascii?Q?1masNvoA260Mtmh5bJ/P7w2QiSmKuqwPHeuU1DvR+qclgQPSOt/b41uQm7fE?=
 =?us-ascii?Q?DQ8Xz20Y8RnAS7WM/YjIfAVDtv4utbF2Cxnme/KwxyCltyMaSUA7L57qXTlb?=
 =?us-ascii?Q?hvcZsjWpY/u1XhO6hzHj7yAPI74JWsFMwcz5UKV0OS3tc+WjvhlsAGqy56m5?=
 =?us-ascii?Q?8Hoarz+AXC0hBGSqt3uRt8peA159DTP1/Jk9J2HwS8hYMq93ByLk2VevXBQe?=
 =?us-ascii?Q?BJZwFAJrVAMtA3yLMwes2Bfls2qAqCl1rpCcqo9dbyE3W7XtsCC6zYbHvlYe?=
 =?us-ascii?Q?vEiuK5WRFstHyuOBmEiBXVPtOiHO3bSjo0+rOdoHju4YkspzIU30OfH1slAd?=
 =?us-ascii?Q?R9j/AJ+laLc99Fx9KYr5Ej2dySkALaV1vvtgj5pqWknoXPCJ2lAc5PHSuqUa?=
 =?us-ascii?Q?nSGMc7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hlwed0dZyvJN5o1RDzg3jc2ggMtzdmrLiIThu3yOpA1YMQntDiIRoAxofw7Q?=
 =?us-ascii?Q?R9yiHgO6SUhOctDyzMSBqNPGQbWShr/jNHn0bfRxEjm9Jlu2/ZKy5RbYZK8y?=
 =?us-ascii?Q?GhVgEgpS++GZlEc58/YO8GVWt5hv/CYC/mVIfIZs6H+EepC+4tzXol8Evn9C?=
 =?us-ascii?Q?RQnx6SFemvvkSgVF0rMES9i1fN+6dkG2RGNm8xvfHErc83KfpAnAJE19lP9L?=
 =?us-ascii?Q?BUCmLW4ntu/suLrncsV02QLt+MTTdcPryWo6GSkemgQ8SSvGnuIu1vxzL7j8?=
 =?us-ascii?Q?divtKu/dExTsVsVm7+4H9vLndV5lf5Mj7aOcUhtsUqZy/HTDheO01P++YHB/?=
 =?us-ascii?Q?xL38ao9mc4kIRZ2YjMoOuCY57taJm3TrAgV74J0OvYceDwB8B/AfSBElvEp8?=
 =?us-ascii?Q?szN7OQHRh/oN40BtwLVEl4xeMtsKHC9l9wJ8akSiDCSfRjF2i3CskV0LVK+n?=
 =?us-ascii?Q?7GbeBdlhmGTPVrVdqBzPzGVFW3WVcU+mM09QJtvpXqvG4B/UmJTzbHoDFOzf?=
 =?us-ascii?Q?TTsAlWvELKYTAnit5CI9my+lS5CydW7ftapr9sGIEbfJCMCspXOsNYZGM/Ln?=
 =?us-ascii?Q?8o/YNUusjC9r/fDcpkocsRegJaqPAuJAkx5ysBAIMs+0sMrTJihL8G+m7B1d?=
 =?us-ascii?Q?k64Tv8MRllpZpq4DbZ9JhIEq5G2+Qtam/0UCckt7n2PB9WUb6kxu2WiMwrN1?=
 =?us-ascii?Q?k0QmCbFHTVbwCr6OmXxTI2w9llJYJJfjQRbIN7lgIvNT1yWWEL0uVYV1GxgF?=
 =?us-ascii?Q?IU8x9BMe+EUxTvpvfz3/5RltAjR8bylc/xNUzHKVbyzJOfjbhRdeje6X7Ji6?=
 =?us-ascii?Q?eIs2xGCBaKEP32G6EevcItqgZkFyeEq1wgLY58Ekk9AxOOcz3AsGPl51PhIO?=
 =?us-ascii?Q?ZZ5q6aucMGmEJ666YoUG7xxtK+PgkCx20zYMjvPRaOpNJUXWWau/rXfLkWef?=
 =?us-ascii?Q?5qO43Ad/Md9622VbcGEynkJt3EoQpH7RdxdDPRnjb5aKzopybepO3YmekhIH?=
 =?us-ascii?Q?Er5SSB4jQuh+z/4g5gdFMh18r29igh1x6NYeMeOIsDyn7d0BFwMbS8jkPjJJ?=
 =?us-ascii?Q?m51EZYVLn3D/myNNi10l3Nn4usGAGd6PLzUWwnXPXxtYQs3ijwRZYD9uMWl4?=
 =?us-ascii?Q?rYoTD0ZjTw5U4kskSc6Lff+B5WPECav58QBBVCs+XDwbDBQXva+J+aj2ZwBI?=
 =?us-ascii?Q?nWmyr1Oru6bKGhvJb9XPpvwNRGXUIj70GcCAH2Rf0G88K1UpPHiVlhTX+fPW?=
 =?us-ascii?Q?XnU1o7M+61skThAfQct/jnAB052r+/Ywwe7lMmzWDpam1HmmAXIYRyoHz+rw?=
 =?us-ascii?Q?0/uMxD/7wwcGkxvsj79BEwRWf5iihTmEwaAHy/YIAv96lGuUZN+zXtHUxkSb?=
 =?us-ascii?Q?hmzECnbk0yuaYAx4uJT5q9BmeSdy1+y7XA9TdO92+ctNjaB85OUSMqYPI0BJ?=
 =?us-ascii?Q?x9YCF/A29cSfqSQwbChtT85DWVjZ4Nkh47N19kDGWYPML+kYQ+SIbhB/LqlJ?=
 =?us-ascii?Q?sOuYdOiOD+2PNMZQoDaaCKMXH/881FPraunpuOFmgHq3RujXp+r7kHoNTWfO?=
 =?us-ascii?Q?dtpm1KU+RK20jnFalag5TJIMRzQO7E1WFbnyd0sC5ci8WsRIez/JGtIgrM6d?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ax5kw3XoNgmSAK41iozcioe/CDPAmiWA4yPZKfg6b+klMBPEM/x4i55YIrbcsXLqiRJZa2lt6KSEQc2535b2noRVb+8t8Fb564YWcUWkqbxEGT+a6KN12ZakbyS+u04HJ+VSi+19kYOIROZA+Uma28Dtj/JoEaJywz9VThBSh7oPECznkkiAjYnmO28DaZSEr8i4KmeCMHtHZMwACNvvK9pkIKinO944vy+B83RHqI8o13OBAAagH4ydhB/RS3m1IT6Dc95qEsSQ3kGogzEtQRiiJU6nKDnD69xcajCVi+IP7RsQtwi1aS68Up6qoj73Nl5lW0QtNZOb/H76fT1PQzsD4dGQZP7UB98EqqVcuQAon07wvjzqxE8YV7P5ivbCTgccF3BcJ7fFNDFl9CimC0UJ4QW8Z+izIFfgca0W8HDHvr52W1oIIP0wxUS55HMZPLDbl32xPNesBWH8rl/iLLTrVnLPfJy7byIdUWf4l3lTo9fSl8z4BezkSCFyclvagb7ikauvMskjbLpfn3EJeZov6nvLaDK9Ilrh2iIOwkoD8PqRgEe0vhnjqoprHuXwKGZJ/julHIESblqW/G5g5wqq5datJ/I2Zw43bQ7rtn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f309735-1e03-4c38-682d-08dce2047987
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:33:22.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/1chkV5qh74+9xKh5vDW3oH1sQ6Jwq75wA1PbDgi0Jg9cI4ReyIxXM4keJ+S9O7Vi64EaPdPXGEIijC42HuwOY82sECfhe/WV1zp1jEs1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010068
X-Proofpoint-ORIG-GUID: V1ZvHF2-lS9rg0OlGCxtk52FVIVWN82V
X-Proofpoint-GUID: V1ZvHF2-lS9rg0OlGCxtk52FVIVWN82V

On Tue, Oct 01, 2024 at 12:22:35PM GMT, Bert Karwatzki wrote:
> Am Dienstag, dem 01.10.2024 um 11:02 +0100 schrieb Lorenzo Stoakes:
> > On Tue, Oct 01, 2024 at 11:57:02AM GMT, Bert Karwatzki wrote:
> > > Am Dienstag, dem 01.10.2024 um 10:49 +0100 schrieb Lorenzo Stoakes:
> > > > On Tue, Oct 01, 2024 at 10:20:02AM GMT, Lorenzo Stoakes wrote:
> > > > > On Tue, Oct 01, 2024 at 11:10:55AM GMT, Bert Karwatzki wrote:
> > > > > > It seems that the maple tree broke down, here's the result of the run with
> > > > > > CONFIG_DEBUG_MAPLETREE=y in all it's g(l)ory. (Here I didn't need to try to
> > > > > > kill
> > > > > > the processes to get an error and soon after the error occured everything
> > > > > > stopped working so I had to reboot via powerbutton.)
> > > > > >
> > > > > > Bert Karwatzki
> > > > >
> > > > > Yike thanks very much!
> > > > >
> > > > > If it's at all possible for you to confirm this happens on Linus's tree
> > > > > just to be super super sure (again I totally expect this) then that'd be
> > > > > amazing.
> > > > >
> > > > > I ask because we have another thread which bisected a problem to this
> > > > > commit which we didn't think was the cause and seemed actually to be the
> > > > > result of something else fiddling around with things it shouldn't so just
> > > > > want to entirely rule that out (a fix was applied to Linus's tree for
> > > > > that).
> > > > >
> > > > > [snip for snaity]
> > > >
> > > > OK so looking at the output it looks very much like your report is
> > > > unfortunate truncated...
> > > >
> > > > There is a 'BUG at mas_validate_limits:7523 (1)' report but immediately
> > > > prior to this there should be a line containing data formatted to "node%p:
> > > > data_end %u != the last slot offset %u".
> > >
> > > Actually one can just grab the report from /var/log/kern.log after a reboot, I
> > > just forgot to copy that line, here it is for the old report:
> >
> > Well depends on distro etc. I suspect systemd systems probably store too but I
> > like to go with the 'easy' or at least straightforward option :P thanks though!
> > :)
>
> Distro is debian sid, last updated 20240929.

Thanks!

>
> > >
> > > [ T4598] node00000000f48524f2: data_end 9 != the last slot offset 8
> > >
> > > and here's the error report from next-20241001:
> > >
> >
> > Can you confirm that's definitely the first line in any bug report in dmesg from
> > boot? As after the first the tree is likely to get more corrupt and later
> > reports are just not going to be that useful.
> >
> > Could you upload the full dmesg somewhere and give a link? Or send it
> > direct to me at lorenzo.stoakes@oracle.com? As pasting whole thing on list
> > might cause lore to sick up a bit. Possibly...
> >
> > Thanks!
> >
> > [snip]
>
> I used bugzilla.kernel.org as a pastebin, here are both full dmesg logs:
> https://bugzilla.kernel.org/show_bug.cgi?id=219338

Perfect.

OK so what is less perfect is this looks very genuine and present in rc1 so
yeah.

Thanks so much for helping out here - I may ask you to try some patches if
that's ok at some point?

Cheers, Lorenzo

>
> Bert Karwatzki
>
>

