Return-Path: <linux-kernel+bounces-556158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC7A5C198
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739147A4C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF02253F11;
	Tue, 11 Mar 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HezQ36tT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OUeYMD/9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24893322E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697166; cv=fail; b=AYPMPE/bHTU2RxEInBU/iXB8Jm6aZIrex8V5YUOaPLTDmViGRkDRRJL9Yc5floXezgAyalGV6fmvG/HoQu661H78CGZNDkbkx2lXj4HBB0NK9wQFtdnlX5ds+bKytRFcCj3UBXee6tS6XXMeRXRODOiPup0fHZvp76DinerMUrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697166; c=relaxed/simple;
	bh=RBxjIrCDFEWcTlFntPmcg5d4K/UyPiRibH54k/gEfP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pPtC8ubkvGiybX3L2Jan3QR8J0mk2UczHM5r/OxI6NU0uw0Vwl40yUSUyNGec6auDgARV9z0mN2IsNvYvCE4SbKCAYi/A1VAVJVbNtTcJgHo1i3ec6YmQw99JX9AqnCms8c3gobf7QA47EgnXtntKQwqqqamBDAyVs93eIwhtCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HezQ36tT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OUeYMD/9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1hMQq008000;
	Tue, 11 Mar 2025 12:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1EkwfweiV5kTNBukVj
	hIqB7ComrfbCd1Pf8O3E3cGdo=; b=HezQ36tTqN83R2Mmy3U1BHHRNbeutlffhq
	KRzXMu9QT+pOzgzJAhrfdHeYMqo7g5ItTyFyh2DTtkQFWdZ41fLlw/zZk6uyfstk
	gNDW8H3yjRSA82WpNc0s3LNIJpdjFzsrlVnWS7mAwZqIDNHY8tPk5OCSyPoh2DA6
	lIDvh7UDcaXqVm0nCFVV/ruMXAsjwTnKmwipdcRuDzM4Cc8ZUqjdS0vCqFQyfh/x
	60wft2WrxiwidsPIV/G5kmoH2vx4hPtmrdXqbPSgKNf1VSCQaqp6arSdSc670BS5
	KThmZWhbYyw/rF5AzKtY79q57YlsGVRifhpB5bjtTJBsEjqzXWeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxcmr41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:45:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCMtq2026183;
	Tue, 11 Mar 2025 12:45:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8xyqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrhanxJHZw0IfOQBweOLhbtAl1vNRmAG+fy8WfVsEYV3IVnWfNOhPlx3cHqJ75JQ7VN0nFUCuy56l8zpje8j1HmsqpwTTrPQtudVp2JgrwLWTzGpn7+qt/kNY3za8mct8XC0k8qYCZz8I9j4qJ9OH2eWsaxnlVQPPonMhEg26X9DogJU2t6Nlp/zqTZ8/7AWHeGCHz/G162bKXMsqN3No2Orl6nivWCJLpwJFXGegwYVk4CFI7C+ZfOp09DfwfwF84o/AmJdOxO/CG/2HY4qZ6e9d/olNz2bGqY3T7175vMh8eLlsbKGsPtNrDgikYzzogYr561j1eK02ue+beKZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EkwfweiV5kTNBukVjhIqB7ComrfbCd1Pf8O3E3cGdo=;
 b=dWq3oXTVNC8EEnAerROXzJL8CqcHgiVKLEuNTkMZUGhUa9ZlJEq2sFtf+dYhJaSTa1GLBoIbnVG82GnwDvw9ZFDrf3karUar4aF3vHRWxE6c6OoDFc6MsaD1NJSpVxBfl1pt/L82nIurPElwZHxNZa64EaznZKBF3gPy47L2G602zy1txoKIasXJOvEgSyRD96eCETLew0kiUWPLVsvAWgdqMoaRTpMJ88npXa7tevfnt2+Uf/i1tqRR17O7fvL3CwxVLkZkSLJHLeXatEaI0+j9QZmCudO6i2PZ3rHnOhyzKA/0QtoGnYNQc672Nps8kyRcqF1ZdOdN2N0u+4ie7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EkwfweiV5kTNBukVjhIqB7ComrfbCd1Pf8O3E3cGdo=;
 b=OUeYMD/9A/FbkM8XX8CDHDNcxooWrR982d1ylpiw5T01tthYhPkzVbFVqb4OGeWjalgWDU4Dtd77JX58MgVFBzAYbAOjTsCWyi5zz+80RFGsQcDdhmiD1NySpuN7irl/uf8VDcXjQynYj1UifxkLhHQM50K0MWsrEKiiaFBzxRg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:45:46 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:45:46 +0000
Date: Tue, 11 Mar 2025 12:45:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/9] mm/memory: split non-tlb flushing part from
 zap_page_range_single()
Message-ID: <6250fc68-2ce8-43a8-a064-e24877033ce1@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-7-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-7-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH3PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 460b0d8c-1ad4-4a92-f400-08dd609aa4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uB3wNLC0TN5BDVznFjc/CDgo/9M/e0mMAkz2tz5cXCxlXQ8yIB22qMDMEvGe?=
 =?us-ascii?Q?rGOpS7UmWN2PBR4pOdL2EmvD7tAMw4FOMp08yTkquqadkNjYJWhpJICeOI8I?=
 =?us-ascii?Q?U2mPX+ox+QOIdQ+lQop7br981J8texDxIpoqf82vq1Mbe1VHrJnW9SLslGCz?=
 =?us-ascii?Q?s2Bp58BbwoDePwQ10ur5ATc2b5x2DwbEg9L8tVX6n80aSib39tOjameHfFtv?=
 =?us-ascii?Q?P8QCxpXySdAzknhLDaBGfn/jCwP28WvdawhxVXH7xqhW7pR3s60SwMJrwLPF?=
 =?us-ascii?Q?vvz8XsnEFv7ixPdfSYFMLd6UCMR4VqFJbhJIIucD6foBJyH5sK8jdQonGvm6?=
 =?us-ascii?Q?tBtbyt+g3URrl7fYHAMtN9uqk073Iaklo4O5XlLis3SlrY3+dQ4MkVQe4EN8?=
 =?us-ascii?Q?icT5JbnonoBolFOsmw4VZ7wTTw7Sfh0eVs1k75rNan+kJyLjtjrX3yJGL7fc?=
 =?us-ascii?Q?flJrAnNyh6p6tGfaJBUjss8Hf64dq3S9NUw8u0Xpb7A6qEZcjjdD0RbEWG8G?=
 =?us-ascii?Q?WhuMTWt3qLIAb2AgDjVdEZey5t2rRjd358B5LA35Cn0ZnFfsX6dhv62Gdegd?=
 =?us-ascii?Q?U3kGmBgBGmNP/Io2yBvCZeSJojKU+xGIspACmojrmAcC3DUjwsxZ4KjLhJgE?=
 =?us-ascii?Q?+91slfUUp/MHgWymX0FSiGBHXrlZAZ9q9x7IoElRo7dhijkLNuXxm9dLChST?=
 =?us-ascii?Q?Ys4IPzt2hjY+Vagw/vSShE/hJGlHEXKu04TvkIx9Ogh8d5lo30QqXrpjZVtZ?=
 =?us-ascii?Q?kma/YGruPuwl8IVUEpAfzoro+qXM7mCWGHfkSoA+cQnNCQY4VbPwsnM9LQyq?=
 =?us-ascii?Q?6C4qRAnis8w2AOUraIoqFpfOXxw3D79pTfQldcFvCj6RIPNxjpdAMluYmNrL?=
 =?us-ascii?Q?oLb8M1DYoIxAYtyu4bHtgc9afG5QRnzrzlAzeZWmiEFjJdAVaAhqq1b30cOy?=
 =?us-ascii?Q?xtejHoU/fYsoOqiA+pSCUvSW2p4Ag1iXEWaJGqgdUEFdzYg+OdE2aYOcB/X5?=
 =?us-ascii?Q?e4JLa67XsGfAWVg6L2IwcB+eh3o73DILL0qW9LyuPWWIXDC6mVlNj0kNKC0R?=
 =?us-ascii?Q?KVbmkQrBeDcS+KcWqSILuwF8orNrTofZZTLfqcpsU5yblI6cNymLNy9l5rWV?=
 =?us-ascii?Q?ENHi6gErxtWtL3fsdFMrqTWgmOHDo1bPhiAAfWtSHjGBRKSc2HuK5OtedXZc?=
 =?us-ascii?Q?AZWOPKi3AF6WLipwJKR31CowDyXMryldHtRDcZy3BfgmiAO8yj7OXaLAyEIc?=
 =?us-ascii?Q?7F0hK9zq41oqs3nmURpGhIw+D/RTJCQZDNPGc+JgSq9UGpHc57B2cfvTT7nJ?=
 =?us-ascii?Q?0xfqUNHozf2UFhkWhDOQ8wI/MG5sxLfMhbiG/GAnKl6QbmVcXEKPuMsJS+TQ?=
 =?us-ascii?Q?FR7x4xdswx6mR/afBKBcB0vFP3ik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4LxkVOdj1+NrzR9zGYCoRPS0v2GwJzAzvcm7oIEwGi/5PA/Mp098dWFTaM1?=
 =?us-ascii?Q?tTIPUpyfqB/1OKaG3E8eURUUGxYvwv239vxZlZTBC9eFudPtqUNf8o74rv6M?=
 =?us-ascii?Q?tmE21ALpvVx+4jjTEweGFki91bfGz32h3sUfWuGEDa4IG48HRqmtcQvLrq5B?=
 =?us-ascii?Q?WDmxYCrdHZueZO65ukMSANsWQ6+dI/O9HPJlJaeHudqVho0zBENJm/XG30IT?=
 =?us-ascii?Q?m+PZLfEZxaNpPTaUDaRroDClSbZA5/UH1fwXjItPnXWBD6cyJRRWnxEs5LP1?=
 =?us-ascii?Q?NhCaSLaUDFcrpV1BsWuwV4wKxJUdVRQIZydFyQ/IECyu/LfTydnpzR0N1IlC?=
 =?us-ascii?Q?TjuNE8OG05nfzcf6OCtmRmTFb6pOT6j/9CXytwdNdvFBvb6SqQIQdHcuW5LK?=
 =?us-ascii?Q?5BMjRkPxEudiqju4l4g1aC5JlkoK762eE6+hu18ngpdC5wwTQQn8l1BeE510?=
 =?us-ascii?Q?kUrlRLmrEgzwrqZW7idFMOIjIuN/UCRtwtufITFSHrmsplc/NhICNcXDsIq2?=
 =?us-ascii?Q?w0vlCPUdy9l36GQXAOMyk3HQHN4CasnsULURE1rUUd4H5u07q9iTOI05nrQS?=
 =?us-ascii?Q?wKZpA+nJbx8ahUhAykxyMYsnZVWCgvPm134gQIX6jbgBDpCVEn2iWtIizvJM?=
 =?us-ascii?Q?7EXJRq7HieCUjvquHnwPaE3YbIyC+7Ny9Z4TGDgbe0kmWKyU3v2Mz4zfBLpi?=
 =?us-ascii?Q?B8WlZa3ADPR6w2WRQSl0De2AwE6bowp2z7XxEQKX6h/OV4eMjfZ58io44Gmc?=
 =?us-ascii?Q?dvYvyKyk26a+NeqN9H2CU8nEj15XtK1YjvXAUN+/copybOSJSCVNJfr3xvCd?=
 =?us-ascii?Q?gfsgso77dugAuPGJgQFV+vywg9vqWu0cUrR7AAxf2TtXL6BzsjJw48LcyjBV?=
 =?us-ascii?Q?3Og4jYzWTm1cDPZ9eLAr9UGaXRQM5gRm+tUV4TFbdSRODOZqSl51TBtrhqDh?=
 =?us-ascii?Q?vxPoR7vDBvoxFFnGxtSuGcyMP+gh0NBaDJ5nFz1wXg4f7TpM7Ax91zBRsBbQ?=
 =?us-ascii?Q?ar2P7xJfCejkts+EpkRtocpBHwjVbS6zyyoVk9gRSAvGvTWKwCzM0Kx+YmYI?=
 =?us-ascii?Q?do4QwmneoB5osP2MymjYGnDzdtz1N5Hc07ekx4UevHjmGlzuxiDViL7dHy/M?=
 =?us-ascii?Q?/MRiOzOEVoyKpLGTKNKN5i5QhQ54enhbjf0neLrCYHHkBVbWF1Ka78utk/YV?=
 =?us-ascii?Q?9MBU62HpG/FswKUq6Cgeui0NOpECmUOHiGEDGFIHs2tx+e5JVLWhjMXVkk7B?=
 =?us-ascii?Q?IqXeZOgTQ0ue7yUuLBTyZpwY6wdQyJFJoJzo7EMoAI2CWWXw6LTrM9pM/vWt?=
 =?us-ascii?Q?rAITb9kEZff6WajGeOd7k/GyByTNZ4L1IwKVsX8NUOPXDmxW++TvIfandr3A?=
 =?us-ascii?Q?UD+zEdoq9cZRuUti1CN7m48IdrIbAvZaWJ2H1ZBJzWX0NGkSi6+KG6ni3ntI?=
 =?us-ascii?Q?ekq0sL/q9lYk2HybaP6/sZUwgBtnLbCg/7qdylaw35PkHXGcLUXyrbeE+RvD?=
 =?us-ascii?Q?7P3t5uCzyVkV/oCbJObpPM8nEIS+v1HkV2JMg1UcmSU8BPzESRO8O6Fj/6o5?=
 =?us-ascii?Q?zFjB7gow4/A1AHZAN40Rr7glF4OBCKen1+ejZ02ALzUXYl8kh7dm3DMRY57K?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fR0+QuZDxg8xzZLohPhGr55zZbeHpQLXzSRzzqUtBj6noNJqzVhHQIri7sVH1U+F4rw8PVL/gGGIdPRXZEpr9fedMJa4N1kD0da7Sxj7XUlygchJHRuVh2hrVQnuhXEfVJU4CaRaCIz3grxGgSSUgk0WIbi4FTQX9m6RXqesUVkhMQkaoEzi/yn/hwVuo3eTg7KAVHjzHWQDV5adErCyUXDD1uA18QmJocf0/zZCi1fhLDnEh/fjzDT3YO1Z10bx+tVT3kym5gn72k0GwvEuaARPUVbNau4HAddMdzPT7dQC27VcEACjmn8AsCzB5t+0KxAMq/STS0qkbSEsU1uiRqQCCksbvT8lFcYGp9v12eASiXZcnjgAYCpoeCC+TB9RV4Jn60o/nYccEKNfJQJQy4p7hYh08nBxYhemkx/4BfY2A1frS2QIRmRPyoSO0H6OfE+7DtzfR9qEAMAEDW6VNHyoruflaOH6cMxQAhnG5NIZ9G06ll1Sgom0+R4/v8cCaEHHE7NAm5PEoXwjU8BVmPA69zOpUx4hUE9uU+k5oHvAzeemOLpE03dbgfswzR6TcTtrUiixazAaQbHoN/sWnFM+9kiLEMnJWprprm2+6o4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460b0d8c-1ad4-4a92-f400-08dd609aa4aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:45:46.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ9jqqZBiPi3s6io7r4hs9/My9H9flJzYPxst2NKExFC5/SdcBWoii60pDreqyUrrRnP/u3uIoQAVGkLxn+wzAubKw8Z+NbeiTAUvYTQ7ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110082
X-Proofpoint-ORIG-GUID: 9LGQKoCXgHtIArucb9TPHb4fTUY3w7nj
X-Proofpoint-GUID: 9LGQKoCXgHtIArucb9TPHb4fTUY3w7nj

On Mon, Mar 10, 2025 at 10:23:15AM -0700, SeongJae Park wrote:
> Some of zap_page_range_single() callers such as [process_]madvise() with
> MADV_DONEED[_LOCKED] cannot batch tlb flushes because
> zap_page_range_single() does tlb flushing for each invocation.  Split
> out the body of zap_page_range_single() except mmu_gather object
> initialization and gathered tlb entries flushing parts for such batched
> tlb flushing usage.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/memory.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 78c7ee62795e..88c478e2ed1a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1995,38 +1995,46 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>
> -/**
> - * zap_page_range_single - remove user pages in a given range
> - * @vma: vm_area_struct holding the applicable pages
> - * @address: starting address of pages to zap
> - * @size: number of bytes to zap
> - * @details: details of shared cache invalidation
> - *
> - * The range must fit into one VMA.
> - */
> -void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> +static void unmap_vma_single(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, unsigned long address,
>  		unsigned long size, struct zap_details *details)
>  {
>  	const unsigned long end = address + size;
>  	struct mmu_notifier_range range;
> -	struct mmu_gather tlb;
>
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address, end);
>  	hugetlb_zap_begin(vma, &range.start, &range.end);
> -	tlb_gather_mmu(&tlb, vma->vm_mm);
>  	update_hiwater_rss(vma->vm_mm);
>  	mmu_notifier_invalidate_range_start(&range);
>  	/*
>  	 * unmap 'address-end' not 'range.start-range.end' as range
>  	 * could have been expanded for hugetlb pmd sharing.
>  	 */
> -	unmap_single_vma(&tlb, vma, address, end, details, false);
> +	unmap_single_vma(tlb, vma, address, end, details, false);
>  	mmu_notifier_invalidate_range_end(&range);
> -	tlb_finish_mmu(&tlb);
>  	hugetlb_zap_end(vma, details);

Previously hugetlb_zap_end() would happen after tlb_finish_mmu(), now it happens
before?

This seems like a major problem with this change. If not you need to explain why
not in the commit message.

>  }
>
> +/**
> + * zap_page_range_single - remove user pages in a given range
> + * @vma: vm_area_struct holding the applicable pages
> + * @address: starting address of pages to zap
> + * @size: number of bytes to zap
> + * @details: details of shared cache invalidation
> + *
> + * The range must fit into one VMA.
> + */
> +void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> +		unsigned long size, struct zap_details *details)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	unmap_vma_single(&tlb, vma, address, size, details);
> +	tlb_finish_mmu(&tlb);
> +}
> +
>  /**
>   * zap_vma_ptes - remove ptes mapping the vma
>   * @vma: vm_area_struct holding ptes to be zapped
> --
> 2.39.5

