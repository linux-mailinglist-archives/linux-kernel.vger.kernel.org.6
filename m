Return-Path: <linux-kernel+bounces-395223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C999BBA7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DE1282744
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB31BFE03;
	Mon,  4 Nov 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ly091hUI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CzqCJgAQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4741C2DA1;
	Mon,  4 Nov 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738578; cv=fail; b=KdO9fp/YZSsyGicyK7hrbgkOO4CushqHJ4lIHiRXT9KEEHpfhmYZFQAwkNd6tZ5V9T6vbb1hfJgTY4c/hvFnLu289UPsCDHYbi5WfQ2ETfaOJLW9R3VfoZ8EyqCj96d+ielGq/lkm9cNM3VKKyfi7rt6Zq8BQ2fIOUtwsneXEIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738578; c=relaxed/simple;
	bh=A60vGyyxOJp9ZDsCqtE2mMkx2YY1NNXIAPIuD9i4a88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JxykfYUhGg52uuMTaDkAjRT7Ny6TQapEP4pPFCyRLAIEDjiqVAEUVJ/xD8DIIKfr4JrCHR5VnwMgzmp/KUMp8CVz2rSn7L4oIjcdh5+XpWPEJF2Ew5dfg4RwC2X7KxVumvgVQxkG/z6jX55YVdOPlpGox+x2nr530RlXRgJ47j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ly091hUI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CzqCJgAQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMbwu007265;
	Mon, 4 Nov 2024 16:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=or1N3xHi8Cb9nIUnxAoLzH4BfV3L4aS7lafbo/zbnis=; b=
	Ly091hUIPhn60nKf6ij6PQYMM1TLkzLGVgwah1CoZBc9xUhq52J7VG68+BIUOSGu
	IhMAP04ULrih6edW4W7OW7QFFHAXoUNOdogOxMvGSpGLjQF//EAF5CUdVsJ0a+yy
	Ako7K3A823lbeucCG7ea8INtxgFtLHahzth7NfVUFn4mjwGmFN8LqG5iH3jyzhPx
	0/UIMh+CtH7fA8HXzgoPchB5hjEhxb77xXxM3gu2K7VoydTH9AL6ib7rvgw+vxuP
	d76IX2fOjPN8F/bp+FFOATxdkRX/HL85jp0MjhNjCNdU8qClqU1DULTLcugfkwQB
	2nwd97vH7iQqHtwXlIfPYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt3664-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 16:42:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GZ1pi031469;
	Mon, 4 Nov 2024 16:42:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah5rduw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 16:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4VwSCyRDC7hQi18/2jk3K11OMyT0izZQ2r7L8WhrOQebVShjmx9Qcq194guV30gfDy8L7BbGeg8nowiZOIwzbDy2WQ9Up19P25BrOMIdF8xTizdInnjjxcsw1bPJny6UzKQEB8z0UvjfeOdfT/VLp3jGwmc/pPvlkjh5lJQO/sb52nVDwLkRZJPGD51bTImyP6dCLpSoUsfDYEB38wt2FW6E/ZaF9atAdMRIdHzm/Agbxsp2RK4bwAa2UFKV5i1WCwpPur2e0BAKod61bWE8Vk0D5DKaJlnMYDqGVU5ivWEOqtnJ+ZjOlwoOmUoDW0OGa0BOUuJ7W7Pog+yZWAJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or1N3xHi8Cb9nIUnxAoLzH4BfV3L4aS7lafbo/zbnis=;
 b=v+JQxm9TqJ4pfw+mwc5hkyftX5lZCG4N/PQmfSk91U+dSYhhV8oQXmgti808aS5y9wygi0zqjs57h4PVIYXcQsf1Clfez5WD9DGoN1w5pRyimPsXkgH+QELu/NKnQ8ad/VAArmXC3AjMDYWllHa8Bf4UrZaEwk3pnB2Yy45k8fHET+Noe+/vmCCAWmcriZcIXkAJPbKHGbmgoxDSaK/8OnsFWANn0dm6zIDXvVmmtXa+5K7Cf3j0n23NBZKecwSDGVrVEg2o8LJM2cUu7sQdmVc7m7cr+YBZM3QlBcvajQtit24C/5szrUzn8BTR43OPCRMBKh7OEPfIW0yUFEwNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or1N3xHi8Cb9nIUnxAoLzH4BfV3L4aS7lafbo/zbnis=;
 b=CzqCJgAQQZX/vhjfPYkxa9upEzagzZDhiz7dxtmepkXHh0fB3madBt3ivoOk7jq1fO3uQbsDQ1iYULa655YqQhSQen3T8rwmPz5Pxc3GaFmGujNwJBrHH2mygcXq2KN+Wq39w0Wu7KehLcytuZLR1UcHTUAfJT7aUweLw9yUvvc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB7172.namprd10.prod.outlook.com (2603:10b6:930:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 16:42:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 16:42:27 +0000
Date: Mon, 4 Nov 2024 16:42:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0106.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca19d7b-007f-46ce-0016-08dcfcefaab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmFyT2lZNzJISjhqY0p2b2xYTWlFUnlzRG53bG9VVlIvVjMzZVVpbXBUQkdi?=
 =?utf-8?B?cVBkK1k1R282dGRjd0NuVlFERzdydnkweXF2SHR2YWxqakxob0dGSXZ0UUMz?=
 =?utf-8?B?Q09ySy81YTZtV01jdWNFUytrUExmdUYreE5qOHZFeFpUdU9qaUR3ODVGaEcy?=
 =?utf-8?B?M3Z5RXB5amd0dGwxcXVmV2FUaWtqRmlGYmc0QnI0T25jTm9tdURjS0w5R0ZD?=
 =?utf-8?B?QnpaMmhUQ0x6dU5vR1YxNjM2MDZDNmwvNVBqaEtPUGplbU5lMHBoT0p6WFA2?=
 =?utf-8?B?UXlicDI2d3NWekRJMzJ5clBrSXg5SUQwSjVrNmpLZS9zMnZ4dWdLcXkvMDFl?=
 =?utf-8?B?UllHOHB5SmpRTVlVenhPMldTVHZWSlZxZWR6cDdkaFdEeHRNKytZRDY5aGow?=
 =?utf-8?B?NVBTeDZGL0VxcW9WdmNwTzh4SDFqWi9BMThCRHgzMTBTeW5BYjErc01PRVFt?=
 =?utf-8?B?NlZsS25zbHQvdEpjd1d4YVRJK3R1T3F6Vms0bEo4VmhZZGdQdk14bXpIUnY2?=
 =?utf-8?B?V0NLVnh5R09sSGxsbnpuVTJDU05ZT01ralJTcDh6Y3ljYm9sRFVlM29aajM0?=
 =?utf-8?B?L2s3RkRVbm1QUWJBbEpJVVgxWWRWaTMxamJrNFZWNkhuV1QrME93SEJRS0Nx?=
 =?utf-8?B?NzVZT1Njb0IrdGFNMTVRcDMrWlBYemFxZVRtcENDREZMelJIOXlNbE5SK0Uz?=
 =?utf-8?B?VGJTOTlDbWJ4SmRyWXlXaWpTbm1UU0FMQmZRditCS0hzVjErdjJ4WWhhMnpI?=
 =?utf-8?B?cjRLZDBhVENiV3RoRDhDYlZOV2hXMUVoLzhuQVhVYUt6eXBCOFMxZFlscFA5?=
 =?utf-8?B?czhoVHJQY1hqVUk4T1JGQXJaQ1BYNFdVYjh4b3pQdmhnbGp6RFBiaklXMWlX?=
 =?utf-8?B?bllHelpPeERudnFNOGdZOEdjNHFDOUxLVmpWM0ZYQVViUk1jZ2M2RHRwQXNn?=
 =?utf-8?B?c3R4L1V4eW1xZjQzdWpSTEZFN1FTWXZKVzVzc2U5MjlreVJ3QjlrQ1docHA1?=
 =?utf-8?B?eDJKWlQ5SlNGemJnTlVBSG1GeUQxWWt4aWRjV0E0Mm1qL2FTckxFZTFVbVJC?=
 =?utf-8?B?QzZLeGYzaitmT3QwYkNSRHh3M2p2NzJTOS9hTU44MU54WHpDNDFsdnZuSW5I?=
 =?utf-8?B?aU53ZS9yRTN5ZWJLTDloTUZtaFEyNTZoMkQvbWg0ajhCaEJTRkVxMGJQSnJG?=
 =?utf-8?B?R1hwcDNobTg4d2dlYjQzNEJteEEzUGN6Skc3OW4xdk5QdUVwWmVvNTJHU0tr?=
 =?utf-8?B?dW5Cd2RWWGF3cFNpcUlQWmxzRGdObGV3R3djQ0phb0pKVVA4V2R1YjUwK1Zs?=
 =?utf-8?B?aDVEQVJHVjY3VWNFaitPT0pISFRucFlrcmZBK2Q2WGtOQTd5ODdsc3cwQzRl?=
 =?utf-8?B?Tjc0MDFJQnZBdDJoSkZqQmJEM0RkS3VGWEJvcDFheFhVUmVMZS92NUpuQnE3?=
 =?utf-8?B?N0twS1hnMDBzOVMyWkdBV0pNRWZVWHZpT1ZZYTRXZnJ6Z21HY1ZkUm1pNGNk?=
 =?utf-8?B?aittcHZWVDQ5dUsxdVU2MVhsWDhqMWFoZkF1MG12cDB1ZTdFU0U1MmxwbUs4?=
 =?utf-8?B?N24xT1JLNlQxcG00eWlvR1l5MUVTT1NtS1F1REVIRTU3Q1R0UElGK0lsMGJK?=
 =?utf-8?B?QkFrbHdXaWxJTDJuUWQvK2hkcnppVEFLUnZNMWpkb1ErSERJUm5SNXZiUFRZ?=
 =?utf-8?B?Y1ZDWXZTV3BjRWNyZUFFTzFvUGJFSk5uT2o1MlFMSmFJbWRtSDJwMm5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZRUVVIM0k2NkdyVXpka3l1V1I1TWZ5cjJhei9rMitpbHJodExicnUwY3cr?=
 =?utf-8?B?U1A5bnhxY0tVaUVOUXR0elR3UWc2OEliSU9NMDZ6SlBPYkhmYzFISzRmTnRU?=
 =?utf-8?B?WnhHbkYwTEdLSTBvb2grV2ZkRS9zdnFlQTZZZHh0dm1NRzFZZEpZcmg0R3Nv?=
 =?utf-8?B?dlh6dzd6ZnFzb2pMcTRMYXM1NGNBWmZoRUd0UTY2Y2Z0SFZodU1KTnVGR08z?=
 =?utf-8?B?S2UxRVhpUXhOWjIrUzI4V3lwQkZhR2JvdWwxZWkyYXNpdjJMWXZzNXcreG8y?=
 =?utf-8?B?QlpQTjQrME1qdCt4Z2VjWjl0c3JUTHU4Q0hJbUFMSjV0UGgxdUZxSHBIZU1j?=
 =?utf-8?B?TXFVTzVQQUtJcm9RSUR2QjZ4bEx1cjN4UnZNaVRyaEMrNERnOFRkSlduQndT?=
 =?utf-8?B?TktscE1YWkgyUUg1ZWN2WU9qUXR6Ym51bFkvRG9yVDJVVmNsTktob1lEQVky?=
 =?utf-8?B?UWlWd29IbXB1NHJVWjZOVW1nYlhtQmZVRGxjeEhPWDN4UzJESGJrNzVwYlp3?=
 =?utf-8?B?WDNnREU4bFZwN0ducDk3WUdUcjNiOGIvdWdGS0JyU0hlLzdiTUhwTVpSRXZ6?=
 =?utf-8?B?MzVhU2dDQWx4d2QyOTFLZlg2eW05YkRXN21jMkdBandIenNJOVRVNHFOYlBy?=
 =?utf-8?B?amRMSEpCZHo4OGZpRm84eDMrNFJsWkRheDVCZjVBTWtrSys1SGF0b2RwV3Y4?=
 =?utf-8?B?T0ROQ3BhYkVqOFhKS3FpWXc4SGQxSWZlcmJ0VG9VMWZLVE9INkxCeURSeHNp?=
 =?utf-8?B?OCt2bEdwaXlveEVsY2wzSjIwNFpsOWhBMUhIbkcrelNTSWpoeUl5SVFnM3NS?=
 =?utf-8?B?WENBU0s4TGJwdXNsRTUybVI4VlRQQ1lYTEh1NDBBMzlZMmkwbjg0OU10bXht?=
 =?utf-8?B?M3R2MkxibmhIMTM4MnNWeWxRcTRrd0VzUytFbnFmdnVhR3cweDh6NTkrQWRs?=
 =?utf-8?B?a1dqUStxRnNCbmR2MUJ2cnQ2N1RJWmNvYVY4SXlqM3dsYkQzV1dOYzNsOXJO?=
 =?utf-8?B?VXZjc01tTjY1NTU3UkpmVlBmK24rNjBsMlZadWZ3emdtbU1aOTVGVWpMaDFN?=
 =?utf-8?B?ZUt3dmhGZHpnV0cxaG8ra0ZzYndnU0FnVGNnQi9hSmQ1WlVYOXQyZG5xSWFO?=
 =?utf-8?B?WmMvSzc0WnlBMDM3bk5wMlJJRE9GNUp4WjBISHlpREdWVzMxRkRWRWU4ajRH?=
 =?utf-8?B?dVQ2eXdRczN1M0ZIVkVSK2tGc0FXOGsvTERGTjVXRWJDWE9iUmxRajgzWWRZ?=
 =?utf-8?B?TkorSnZRZFovOUplVnZ6ZW1DV1JST0ZhWG1DTFJGeG1FQnQraFdJbktvNWJU?=
 =?utf-8?B?YWhabXpVU0I1TXFzTWVoSUJ3UDVEcVFCM0lPczJ4UGxtT0dZZWhZOWUrQWxp?=
 =?utf-8?B?TFVsa1JQRGdRbUxFS0w4WUlTUitUME55Y3ZDb25rQ0FTQnVWMnM0UXFVMmJx?=
 =?utf-8?B?ekZ6bUtrSnc5RUcxQm90SmpKS0V2akV0cTBHNFZoTFZxa2ZjNW40aDdyYjR4?=
 =?utf-8?B?RGd2SDlwVFovY0J5K25DalhSOURzeVBFMWlCelJRZG1IQVZCeGREK01mbjB4?=
 =?utf-8?B?UVg4Z1h6dXVJVDVGeXVWejY5cGRabi9XbGswV1gyRHp0RDlYTEJha2RSSndP?=
 =?utf-8?B?enFFQS9GK3F3a1ppa0NrTTEwYzV1SFJpQk50YUxxTUVFYzFlcHE5VHU1akMw?=
 =?utf-8?B?WEdxVjlFSERJUXM0S3ROMkF5Y1Rkbm9yVkdRSnVPL2JjcnU2L2R4TWQ2NjRW?=
 =?utf-8?B?ZUIrTmZzby9KSGlDd3FUUUM3OWx5T1M0K25ic2J6bDFJV0FHcmhqcmFjdVda?=
 =?utf-8?B?VUlOSEtCby9MbVRvS0xINzh5VWVNTmNsREsrTzJ4Wm4wQi9NQ3Z5NjMvOGRl?=
 =?utf-8?B?OVRXZWc0K0RPY083c3NIb05hRU0wcStBNTdMdHJQTHlIUFBQc0l1YnhNWGxD?=
 =?utf-8?B?aHdmTFJ6eFJHb1lsdnY5YStSUzBtZm9OVUdJckFxZHJQSmR6bmxLbFJoaEw2?=
 =?utf-8?B?ZXdRTUU2bWhRNWR3WmdmRDlMTjJXS3V3SkpoR3A1WXpaTllPUW5yeGdUZ1pF?=
 =?utf-8?B?MmpKRmJYRWUvb1lwTWhSZ3ZFQ0s0T3pRU2tkWkx6WTgvcFJwdklCN0hNU2c1?=
 =?utf-8?B?YWhQb1RJN09CQ3B5TDJhNXgzZWlZRmk0UHJkVWlqWVZnRGoxWkhZVFBRYWkr?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LpVQgjvdSTO/BUPoMAkPRpro88LX44aqLMrxvphbPyRrN9Utd0i7Sp04MH5LnhwzwSydiymiu9bAPDA5m99qUacHzjbda46OPb4/uD1Hc4Cyab9N5eeWTeaS3Vt8iUr/X+WcNRVho+f2/Tihp417dR/DC2C/pt7CTlPMZZoNbBA2WV/CeawEf/YSBctlOUwRKTX+DcjdVGuuJuXYMuUjkDa4lh4re8U85EX8MCVSFZ4Iu2OFzN46+PxYXdv8ivCluvaxiDNaBug1WQ1alxRH35pVIshsnPjVvFH9+Qc7t42+9hhYcdczrCmao/j1bmMtTk9T7qaIMNwvr9EgtDuM7zxGAw7DxcQQQuRbGGy4/zqgvWH8hhgYNnoZj3D/IcL7sLgmbPyF6jWFzt7WtDweTeZq9AWmVn9IFeZ6ozpwDZxkh+jE5DS5Snj2GINnd/EHkxZVgVMJzjqgWtk3FDrrZA38Sz1jiyw/Tvt1vA9ofrXcicWuBwjz4K9H0FwcO259yAODPpgeD0FRGWUuiVLdt7EdteQQJ/+kdnzss3l4wtMkmPpvu/IBjdPL2wJ+Zf5JTTBwnDzrbWkCmYhGVy4dM98geOLSmxxmuhhzDw0SicI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca19d7b-007f-46ce-0016-08dcfcefaab8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 16:42:27.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bby6v+kSLmfUmTALYihV2NGdhUWrKTJBDmeLjBC2S5o2Wa+zkagORw2DE++Zn6TBomvju/sr/PKdJdHwEHciB9+YMgYhWziTFuWahCVCjOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_15,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040140
X-Proofpoint-GUID: IVzCJlWGbN-Vvwyhno5eal_PBEBvls51
X-Proofpoint-ORIG-GUID: IVzCJlWGbN-Vvwyhno5eal_PBEBvls51

On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
> On Fri, Nov 1, 2024 at 7:50 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be interacted with when it comes to interacting
> > with mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards efforts to find sensible
> > abstractions for these fundamental objects within the kernel rust
> > abstraction whose compiler strictly requires some means of expressing these
> > rules (and through this expression can help self-document these
> > requirements as well as enforce them which is an exciting concept).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> > The document also provides some VMA lock internals, which are up to date
> > and inclusive of recent changes to recent sequence number changes.
>
> Thanks for doing this!

No problem, at this point I think it's actually critical we have this.

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >
> > REVIEWERS NOTES:
> >    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
> >    also uploaded a copy of this to my website at
> >    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
> >    read through. Thanks!
> >
> >
> >  Documentation/mm/index.rst     |   1 +
> >  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
> >  2 files changed, 528 insertions(+)
> >  create mode 100644 Documentation/mm/vma_locks.rst
> >
> > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > index 0be1c7503a01..da5f30acaca5 100644
> > --- a/Documentation/mm/index.rst
> > +++ b/Documentation/mm/index.rst
> > @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
> >     vmemmap_dedup
> >     z3fold
> >     zsmalloc
> > +   vma_locks
> > diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_locks.rst
> > new file mode 100644
> > index 000000000000..52b9d484376a
> > --- /dev/null
> > +++ b/Documentation/mm/vma_locks.rst
> > @@ -0,0 +1,527 @@
> > +VMA Locking
> > +===========
> > +
> > +Overview
> > +--------
> > +
> > +Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
> > +'VMA's of type `struct vm_area_struct`.
> > +
> > +Each VMA describes a virtually contiguous memory range with identical
> > +attributes, each of which described by a `struct vm_area_struct`
> > +object. Userland access outside of VMAs is invalid except in the case where an
> > +adjacent stack VMA could be extended to contain the accessed address.
> > +
> > +All VMAs are contained within one and only one virtual address space, described
> > +by a `struct mm_struct` object which is referenced by all tasks (that is,
> > +threads) which share the virtual address space. We refer to this as the `mm`.
> > +
> > +Each mm object contains a maple tree data structure which describes all VMAs
> > +within the virtual address space.
>
> The gate VMA is special, on architectures that have it: Userland
> access to its area is allowed, but the area is outside the VA range
> managed by the normal MM code, and the gate VMA is a global object
> (not per-MM), and only a few places in MM code can interact with it
> (for example, page fault handling can't, but GUP can through
> get_gate_page()).
>
> (I think this also has the fun consequence that vm_normal_page() can
> get called on a VMA whose ->vm_mm is NULL, when called from
> get_gate_page().)

Yeah the gate page is weird, I'm not sure it's worth going into too much detail
here, but perhaps a note explaining in effect 'except for the gate page..'
unless you think it'd be valuable to go into that in more detail than a passing
'hey of course there's an exception to this!' comment? :)

>
> > +The kernel is designed to be highly scalable against concurrent access to
> > +userland memory, so a complicated set of locks are required to ensure no data
> > +races or memory corruption occurs.
> > +
> > +This document explores this locking in detail.
> > +
> > +.. note::
> > +
> > +   There are three different things that a user might want to achieve via
> > +   locks - the first of which is **stability**. That is - ensuring that the VMA
> > +   won't be freed or modified in any way from underneath us.
> > +
> > +   All MM and VMA locks ensure stability.
> > +
> > +   Secondly we have locks which allow **reads** but not writes (and which might
> > +   be held concurrent with other CPUs who also hold the read lock).
> > +
> > +   Finally, we have locks which permit exclusive access to the VMA to allow for
> > +   **writes** to the VMA.
>
> Maybe also mention that there are three major paths you can follow to
> reach a VMA? You can come through the mm's VMA tree, you can do an
> anon page rmap walk that goes page -> anon_vma -> vma, or you can do a
> file rmap walk from the address_space. Which is why just holding the
> mmap lock and vma lock in write mode is not enough to permit arbitrary
> changes to a VMA struct.

I totally agree that adding something about _where_ you can come from is a good
idea, will do.

However, in terms of the VMA itself, mmap lock and vma lock _are_ sufficient to
prevent arbitrary _changes_ to the VMA struct right?

It isn't sufficient to prevent _reading_ of vma metadata fields, nor walking of
underlying page tables, so if you're going to do something that changes
fundamentals you need to hide it from rmap.

Maybe worth going over relevant fields? Or rather adding an additional 'read
lock' column?

vma->vm_mm ('static' anyway after VMA created)
vma->vm_start (change on merge/split)
vma->vm_end (change on merge/split)
vma->vm_flags (can change)
vma->vm_ops ('static' anyway after call_mmap())

In any case this is absolutely _crucial_ I agree, will add.

>
> > +MM and VMA locks
> > +----------------
> > +
> > +There are two key classes of lock utilised when reading and manipulating VMAs -
> > +the `mmap_lock` which is a read/write semaphore maintained at the `mm_struct`
> > +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock at the
> > +VMA level of granularity.
> > +
> > +.. note::
> > +
> > +   Generally speaking, a read/write semaphore is a class of lock which permits
> > +   concurrent readers. However a write lock can only be obtained once all
> > +   readers have left the critical region (and pending readers made to wait).
> > +
> > +   This renders read locks on a read/write semaphore concurrent with other
> > +   readers and write locks exclusive against all others holding the semaphore.
> > +
> > +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a write
> > +mmap lock gives you exclusive write access to a VMA, and a read lock gives you
> > +concurrent read-only access.
> > +
> > +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> > +complicated. In this instance, a write semaphore is no longer enough to gain
> > +exclusive access to a VMA, a VMA write lock is also required.
> > +
> > +The VMA lock is implemented via the use of both a read/write semaphore and
> > +per-VMA and per-mm sequence numbers. We go into detail on this in the VMA lock
> > +internals section below, so for the time being it is important only to note that
> > +we can obtain either a VMA read or write lock.
> > +
> > +.. note::
> > +
> > +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu()`
> > +   function, and **no** existing mmap or VMA lock must be held, This function
>
> uffd_move_lock() calls lock_vma_under_rcu() after having already
> VMA-locked another VMA with uffd_lock_vma().

Oh uffd, how we love you...

I think it might be worth adding a note for this exception. Obviously they do
some pretty careful manipulation to avoid issues here so probably worth saying
'hey except uffd'

>
> > +   either returns a read-locked VMA, or NULL if the lock could not be
> > +   acquired. As the name suggests, the VMA will be acquired under RCU, though
> > +   once obtained, remains stable.
> > +   This kind of locking is entirely optimistic - if the lock is contended or a
> > +   competing write has started, then we do not obtain a read lock.
> > +
> > +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()` to ensure
> > +   that the VMA is acquired in an RCU critical section, then attempts to VMA
> > +   lock it via `vma_start_read()`, before releasing the RCU lock via
> > +   `rcu_read_unlock()`.
> > +
> > +   VMA read locks hold the a read lock on the `vma->vm_lock` semaphore for their
>
> nit: s/ the a / a /

Yeah Mike found the same thing, will fix.

>
> > +   duration and the caller of `lock_vma_under_rcu()` must release it via
> > +   `vma_end_read()`.
> > +
> > +   VMA **write** locks are acquired via `vma_start_write()` in instances where a
> > +   VMA is about to be modified, unlike `vma_start_read()` the lock is always
> > +   acquired. An mmap write lock **must** be held for the duration of the VMA
> > +   write lock, releasing or downgrading the mmap write lock also releases the
> > +   VMA write lock so there is no `vma_end_write()` function.
> > +
> > +   Note that a semaphore write lock is not held across a VMA lock. Rather, a
> > +   sequence number is used for serialisation, and the write semaphore is only
> > +   acquired at the point of write lock to update this (we explore this in detail
> > +   in the VMA lock internals section below).
> > +
> > +   This ensures the semantics we require - VMA write locks provide exclusive
> > +   write access to the VMA.
> > +
> > +Examining all valid lock state and what each implies:
> > +
> > +.. list-table::
> > +   :header-rows: 1
> > +
> > +   * - mmap lock
> > +     - VMA lock
> > +     - Stable?
> > +     - Can read safely?
> > +     - Can write safely?
> > +   * - \-
> > +     - \-
> > +     - N
> > +     - N
> > +     - N
> > +   * - R
> > +     - \-
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - \-
> > +     - R
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - W
> > +     - \-
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - W
> > +     - W
> > +     - Y
> > +     - Y
> > +     - Y
> > +
> > +Note that there are some exceptions to this - the `anon_vma` field is permitted
> > +to be written to under mmap read lock and is instead serialised by the `struct
> > +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
>
> Hm, we really ought to add some smp_store_release() and READ_ONCE(),
> or something along those lines, around our ->anon_vma accesses...
> especially the "vma->anon_vma = anon_vma" assignment in
> __anon_vma_prepare() looks to me like, on architectures like arm64
> with write-write reordering, we could theoretically end up making a
> new anon_vma pointer visible to a concurrent page fault before the
> anon_vma has been initialized? Though I have no idea if that is
> practically possible, stuff would have to be reordered quite a bit for
> that to happen...

They make me nervous too, yes.

>
> > +lock-specific fields are permitted to be read under RCU alone  (though stability cannot
> > +be expected in this instance).
> > +
> > +.. note::
> > +   The most notable place to use the VMA read lock is on page table faults on
>
> s/page table faults/page faults/?
>

Ack will fix.

> > +   the x86-64 architecture, which importantly means that without a VMA write
>
> it's wired up to a bunch of architectures at this point - arm, arm64,
> powerpc, riscv, s390, x86 all use lock_vma_under_rcu().

Ah is it? Hadn't double checked that and clearly out of date, will update.

>
> > +   lock, page faults can race against you even if you hold an mmap write lock.
> > +
> > +VMA Fields
> > +----------
> > +
> > +We examine each field of the `struct vm_area_struct` type in detail in the table
> > +below.
> > +
> > +Reading of each field requires either an mmap read lock or a VMA read lock to be
> > +held, except where 'unstable RCU read' is specified, in which case unstable
> > +access to the field is permitted under RCU alone.
> > +
> > +The table specifies which write locks must be held to write to the field.
>
> vm_start, vm_end and vm_pgoff also require that the associated
> address_space and anon_vma (if applicable) are write-locked, and that
> their rbtrees are updated as needed.

Surely vm_flags too...

>
> > +.. list-table::
> > +   :widths: 20 10 22 5 20
> > +   :header-rows: 1
> > +
> > +   * - Field
> > +     - Config
> > +     - Description
> > +     - Unstable RCU read?
> > +     - Write Lock
> > +   * - vm_start
> > +     -
> > +     - Inclusive start virtual address of range VMA describes.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_end
> > +     -
> > +     - Exclusive end virtual address of range VMA describes.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_rcu
> > +     - vma lock
> > +     - RCU list head, in union with vma_start, vma_end. RCU implementation detail.
> > +     - N/A
> > +     - N/A
> > +   * - vm_mm
> > +     -
> > +     - Containing mm_struct.
> > +     - Y
> > +     - (Static)
> > +   * - vm_page_prot
> > +     -
> > +     - Architecture-specific page table protection bits determined from VMA
> > +       flags
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_flags
> > +     -
> > +     - Read-only access to VMA flags describing attributes of VMA, in union with
> > +       private writable `__vm_flags`.
> > +     -
> > +     - N/A
> > +   * - __vm_flags
> > +     -
> > +     - Private, writable access to VMA flags field, updated by vm_flags_*()
> > +       functions.
> > +     -
> > +     - mmap write, VMA write
> > +   * - detached
> > +     - vma lock
> > +     - VMA lock implementation detail - indicates whether the VMA has been
> > +       detached from the tree.
> > +     - Y
> > +     - mmap write, VMA write
> > +   * - vm_lock_seq
> > +     - vma lock
> > +     - VMA lock implementation detail - A sequence number used to serialise the
> > +       VMA lock, see the VMA lock section below.
> > +     - Y
> > +     - mmap write, VMA write
>
> I think "mmap write" is accurate, but "VMA write" is inaccurate -
> you'd need to have already written to the vm_lock_seq in order to have
> a VMA write lock.

Yes my mistake, will correct!

>
> > +   * - vm_lock
> > +     - vma lock
> > +     - VMA lock implementation detail - A pointer to the VMA lock read/write
> > +       semaphore.
> > +     - Y
> > +     - None required
> > +   * - shared.rb
> > +     -
> > +     - A red/black tree node used, if the mapping is file-backed, to place the
> > +       VMA in the `struct address_space->i_mmap` red/black interval tree.
> > +     -
> > +     - mmap write, VMA write, i_mmap write
> > +   * - shared.rb_subtree_last
> > +     -
> > +     - Metadata used for management of the interval tree if the VMA is
> > +       file-backed.
> > +     -
> > +     - mmap write, VMA write, i_mmap write
> > +   * - anon_vma_chain
> > +     -
> > +     - List of links to forked/CoW'd `anon_vma` objects.
> > +     -
> > +     - mmap read or above, anon_vma write lock
> > +   * - anon_vma
> > +     -
> > +     - `anon_vma` object used by anonymous folios mapped exclusively to this VMA.
> > +     -
> > +     - mmap read or above, page_table_lock
> > +   * - vm_ops
> > +     -
> > +     - If the VMA is file-backed, then either the driver or file-system provides
> > +       a `struct vm_operations_struct` object describing callbacks to be invoked
> > +       on specific VMA lifetime events.
> > +     -
> > +     - (Static)
> > +   * - vm_pgoff
> > +     -
> > +     - Describes the page offset into the file, the original page offset within
> > +       the virtual address space (prior to any `mremap()`), or PFN if a PFN map.
>
> Ooh, right, I had forgotten about this quirk, and I think I never
> fully understood these rules... it's a PFN if the VMA is
> private+maywrite+pfnmap. And the vma->vm_pgoff is set in
> remap_pfn_range_internal() under those conditions.

Yeah it's horrid. The whole mremap() hack that makes it the 'original' virtual
page offset on mmap() but not update afterwards is equally quite horrid.

>
> Huh, so for example, if you are in an environment where usbdev_mmap()
> uses remap_pfn_range() (which depends on hardware - it seems to work
> inside QEMU but not on real machine), and you have at least read
> access to a device at /dev/bus/usb/*/* (which are normally
> world-readable), you can actually do this:
>
> user@vm:/tmp$ cat usb-get-physaddr.c
> #include <err.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <sys/mman.h>
> #define SYSCHK(x) ({          \
>   typeof(x) __res = (x);      \
>   if (__res == (typeof(x))-1) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
> int main(int argc, char **argv) {
>   if (argc != 2)
>     errx(1, "expect one argument (usbdev path)");
>   int fd = SYSCHK(open(argv[1], O_RDONLY));
>   SYSCHK(mmap((void*)0x10000, 0x1000, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED_NOREPLACE, fd, 0));
>   system("head -n1 /proc/$PPID/maps");
> }
> user@vm:/tmp$ gcc -o usb-get-physaddr usb-get-physaddr.c
> user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
> 00010000-00011000 rw-p 0103f000 00:06 135
>   /dev/bus/usb/001/001
> user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
> 00010000-00011000 rw-p 0103f000 00:06 135
>   /dev/bus/usb/001/001
> user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
> 00010000-00011000 rw-p 0107e000 00:06 135
>   /dev/bus/usb/001/001
> user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
> 00010000-00011000 rw-p 010bd000 00:06 135
>   /dev/bus/usb/001/001
> user@vm:/tmp$
>
> and see physical addresses in the offset field in /proc/*/maps...
> that's not great. And pointless on architectures with
> CONFIG_ARCH_HAS_PTE_SPECIAL, from what I can tell.

Yeah, vm_normal_page() has a nice comment on this insanity.

Actually I'll update this to specify that just to be clear.

>
>
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_file
> > +     -
> > +     - If the VMA is file-backed, points to a `struct file` object describing
> > +       the underlying file, if anonymous then `NULL`.
> > +     -
> > +     - (Static)
> > +   * - vm_private_data
> > +     -
> > +     - A `void *` field for driver-specific metadata.
> > +     -
> > +     - Driver-mandated.
> > +   * - anon_name
> > +     - anon name
> > +     - A field for storing a `struct anon_vma_name` object providing a name for
> > +       anonymous mappings, or `NULL` if none is set or the VMA is file-backed.
> > +     -
> > +     - mmap write, VMA write
> > +   * - swap_readahead_info
> > +     - swap
> > +     - Metadata used by the swap mechanism to perform readahead.
> > +     -
> > +     - mmap read
> > +   * - vm_region
> > +     - nommu
> > +     - The containing region for the VMA for architectures which do not
> > +       possess an MMU.
> > +     - N/A
> > +     - N/A
> > +   * - vm_policy
> > +     - numa
> > +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> > +     -
> > +     - mmap write, VMA write
> > +   * - numab_state
> > +     - numab
> > +     - `vma_numab_state` object which describes the current state of NUMA
> > +       balancing in relation to this VMA.
> > +     -
> > +     - mmap write, VMA write
>
> I think task_numa_work() is only holding the mmap lock in read mode
> when it sets this pointer to a non-NULL value.

ugh lord... knew I'd get at least one of these wrong :P

Yeah you're right, will fix!

>
> > +   * - vm_userfaultfd_ctx
> > +     -
> > +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, either
> > +       of zero size if userfaultfd is disabled, or containing a pointer to an
> > +       underlying `userfaultfd_ctx` object which describes userfaultfd metadata.
> > +     -
> > +     - mmap write, VMA write
> > +
> > +.. note::
> > +
> > +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LOCK,
> > +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'nommu'
> > +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab' means
> > +   CONFIG_NUMA_BALANCING'.
> > +
> > +   In the write lock column '(Static)' means that the field is set only once
> > +   upon initialisation of the VMA and not changed after this, the VMA would
> > +   either have been under an mmap write and VMA write lock at the time or not
> > +   yet inserted into any tree.
> > +
> > +Page table locks
> > +----------------
> > +
> > +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> > +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> > +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> > +
> > +.. note::
> > +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> > +   however at the time of writing it ultimately references the
> > +   `mm->page_table_lock`.
> > +
> > +Allocating a PTE will either use the `mm->page_table_lock` or, if
> > +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> > +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> > +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> >+
> > +Finally, modifying the contents of the PTE has special treatment, as this is a
> > +lock that we must acquire whenever we want stable and exclusive access to
> > +entries pointing to data pages within a PTE, especially when we wish to modify
> > +them.
>
> I guess one other perspective on this would be to focus on the
> circumstances under which you're allowed to write entries:
>
> 0. page tables can be concurrently read by hardware and GUP-fast, so
> writes must always be appropriately atomic

Yeah I definitely need to mention GUP-fast considerations (and consequently
the pXX_lockless..() functions). Thanks for raising that,  important one.

> 1. changing a page table entry always requires locking the containing
> page table (except when the write is an A/D update by hardware)

I think we can ignore the hardware writes altogether, though I think worth
adding a 'note' to explain this can happen outside of this framework
altogether.

> 2. in page tables higher than PMD level, page table entries that point
> to page tables can only be changed to point to something else when
> holding all the relevant high-level locks leading to the VMA in
> exclusive mode: mmap lock (unless the VMA is detached), VMA lock,
> anon_vma, address_space

Right this seems mremap()-specific when you say 'change' here :) and of
course, we have code that explicitly does this (take_rmap_locks() +
drop_rmap_locks()).

> 3. PMD entries that point to page tables can be changed while holding
> the page table spinlocks for the entry and the table it points to

Hm wut? When you say 'entry' what do you mean? Obviously a page table in
theory could be changed at any point you don't have it locked and to be
sure it hasn't you have to lock + check again.

> 4. lowest-level page tables can be in high memory, so they must be
> kmapped for access, and pte_offset_map_lock() does that for you

I kind of don't really like to bother talking about 32-bit kernels (or at
least 32-bit kernels that have to use high memory) as I consider them
completely deprecated ;)

Might be worth the briefest of brief mentions...

> 5. entries in "none" state can only be populated with leaf entries
> while holding the mmap or vma lock (doing it through the rmap would be
> bad because that could race with munmap() zapping data pages in the
> region)
> 6. leaf entries can be zapped (changed to "none") while holding any
> one of mmap lock, vma lock, address_space lock, or anon_vma lock

For both 5 and 6 - I'm not sure if we ever zap without holding the mmap
lock do we?

Unless you're including folio_mkclean() and pfn_mkclean_range()? I guess
this is 'strike of the linux kernel terminology' once again :P

Yeah in that case sure.

OK so interestingly this really aligns with what Alice said as to this not
giving a clear indicator from a user's perspective as to 'what lock do I
need to hold'.

So I will absolutely address all this and try to get the fundamentals
boiled down.

Also obviously the exception to your rules are - _freeing_ of higher level
page tables because we assume we are in a state where nothing can access
them so no such locks are required. But I cover that below.

>
> And then the rules for readers mostly follow from that:
> 1 => holding the appropriate page table lock makes the contents of a
> page table stable, except for A/D updates
> 2 => page table entries higher than PMD level that point to lower page
> tables can be followed without taking page table locks

Yeah this is true actually, might be worth mentioning page table walkers
here and how they operate as they're instructive on page table locking
requirements.

> 3+4 => following PMD entries pointing to page tables requires careful
> locking, and pte_offset_map_lock() does that for you

Well, pte_offset_map_lock() is obtained at the PTE level right?

pmd_lock() at the PMD level (pud_lock() ostensibly at PUD level but this
amounts to an mm->page_table_lock anyway there)

>
> Ah, though now I see the page table teardown section below already has
> some of this information.
>
> > +This is performed via `pte_offset_map_lock()` which carefully checks to ensure
> > +that the PTE hasn't changed from under us, ultimately invoking `pte_lockptr()`
> > +to obtain a spin lock at PTE granularity contained within the `struct ptdesc`
> > +associated with the physical PTE page. The lock must be released via
> > +`pte_unmap_unlock()`.
>
> Sidenote: Not your fault that the Linux terminology for this sucks,
> but the way this section uses "PTE" to describe a page table rather
> than a Page Table Entry is pretty confusing to me... in my head, a
> pte_t is a Page Table Entry (PTE), a pte_t* is a Page Table or a Page
> Table Entry Pointer (depending on context), a pmd_t is a Page Middle
> Directory Entry, and a pmd_t* is a Page Middle Directory or a Page
> Middle Directory Entry Pointer. (Though to make things easier I
> normally think of them as L1 entry, L1 table, L2 entry, L2 table.)

I actually wanted at some point to change the naming to be consistent in
the kernel (though it'd be huge churn... but hey that's my speciality
right? ;) kernel.

The PTE = the page table directory as well as the Page Table Entry
directory is extremely shit yes.

>
> > +.. note::
> > +   There are some variants on this, such as `pte_offset_map_rw_nolock()` when we
> > +   know we hold the PTE stable but for brevity we do not explore this.
> > +   See the comment for `__pte_offset_map_lock()` for more details.
> > +
> > +When modifying data in ranges we typically only wish to allocate higher page
> > +tables as necessary, using these locks to avoid races or overwriting anything,
> > +and set/clear data at the PTE level as required (for instance when page faulting
> > +or zapping).
> > +
> > +Page table teardown
> > +-------------------
> > +
> > +Tearing down page tables themselves is something that requires significant
> > +care. There must be no way that page tables designated for removal can be
> > +traversed or referenced by concurrent tasks.
>
> (except by hardware or with gup_fast() which behaves roughly like a
> hardware page walker and completely ignores what is happening at the
> VMA layer)

Yeah I definitely need to address the gup_fast() stuff. Will do so in
teardown section here too.

>
> > +It is insufficient to simply hold an mmap write lock and VMA lock (which will
> > +prevent racing faults, and rmap operations), as a file-backed mapping can be
> > +truncated under the `struct address_space` i_mmap_lock alone.
> > +
> > +As a result, no VMA which can be accessed via the reverse mapping (either
> > +anon_vma or the `struct address_space->i_mmap` interval tree) can have its page
> > +tables torn down.
>
> (except last-level page tables: khugepaged already deletes those for
> file mappings without using the mmap lock at all in
> retract_page_tables(), and there is a pending series that will do the
> same with page tables in other VMAs too, see
> <https://lore.kernel.org/all/cover.1729157502.git.zhengqi.arch@bytedance.com/>)

Ugh wut OK haha. Will look into this.

>
> > +The operation is typically performed via `free_pgtables()`, which assumes either
> > +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> > +parameter), or that it the VMA is fully detached.
>
> nit: s/that it the/that the/

Ack will fix.

>
> > +It carefully removes the VMA from all reverse mappings, however it's important
> > +that no new ones overlap these or any route remain to permit access to addresses
> > +within the range whose page tables are being torn down.
> > +
> > +As a result of these careful conditions, note that page table entries are
> > +cleared without page table locks, as it is assumed that all of these precautions
> > +have already been taken.
>
> Oh, I didn't realize this... interesting.
>
> > +mmap write lock downgrading
> > +---------------------------
> > +
> > +While it is possible to obtain an mmap write or read lock using the
> > +`mm->mmap_lock` read/write semaphore, it is also possible to **downgrade** from
> > +a write lock to a read lock via `mmap_write_downgrade()`.
> > +
> > +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA write locks
> > +via `vma_end_write_all()` (more or this behaviour in the VMA lock internals
>
> typo: s/or/on/

Ack will fix.

>
> > +section below), but importantly does not relinquish the mmap lock while
> > +downgrading, therefore keeping the locked virtual address space stable.
> > +
> > +A subtlety here is that callers can assume, if they invoke an
> > +mmap_write_downgrade() operation, that they still have exclusive access to the
> > +virtual address space (excluding VMA read lock holders), as for another task to
> > +have downgraded they would have had to have exclusive access to the semaphore
> > +which can't be the case until the current task completes what it is doing.
> > +
> > +Stack expansion
> > +---------------
> > +
> > +Stack expansion throws up additional complexities in that we cannot permit there
> > +to be racing page faults, as a result we invoke `vma_start_write()` to prevent
> > +this in `expand_downwards()` or `expand_upwards()`.
>
> And this needs the mmap lock in write mode, so stack expansion is only
> done in codepaths where we can reliably get that - so it happens on
> fault handling, but not on GUP. This probably creates the fun quirk
> that, in theory, the following scenario could happen:
>
> 1. a userspace program creates a large on-stack buffer (which exceeds
> the bounds of the current stack VMA but is within the stack size
> limit)
> 2. userspace calls something like the read() syscall on this buffer
> (without writing to any deeper part of the stack - so this can't
> happen when you call into a non-inlined library function for read() on
> x86, but it might happen on arm64, where a function call does not
> require writing to the stack)
> 3. the kernel read() handler is trying to do something like direct I/O
> and uses GUP to pin the user-supplied pages (and does not use
> copy_to_user(), which would be more common)
> 4. GUP fails, the read() fails
>
> But this was probably the least bad option to deal with existing stack
> expansion issues.

Hm that seems like a just so set of circumstances though :P

I was around for that whole 'mmap read lock only needed for stack
expansion' series and discussion and it was all very very horrible.

This is definitely the least bad option at least for now.

Funny thing is, examining that code led me to the patch I sent for
eliminating the additional locking... as I found with the book, staring at
code for the purposes of explaining it naturally leads to patches :)

>
> > +Lock ordering
> > +-------------
> > +
> > +As we have multiple locks across the kernel which may or may not be taken at the
> > +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> > +the **order** in which locks are acquired and released becomes very important.
> > +
> > +.. note::
> > +
> > +   Lock inversion occurs when two threads need to acquire multiple locks,
> > +   but in doing so inadvertently cause a mutual deadlock.
> > +
> > +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> > +   while thread 2 holds lock B and tries to acquire lock A.
> > +
> > +   Both threads are now deadlocked on each other. However, had they attempted to
> > +   acquire locks in the same order, one would have waited for the other to
> > +   complete its work and no deadlock would have occurred.
> > +
> > +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> > +locks within memory management code:
> > +
> > +.. code-block::
> > +
> > +  inode->i_rwsem       (while writing or truncating, not reading or faulting)
> > +    mm->mmap_lock
> > +      mapping->invalidate_lock (in filemap_fault)
> > +        folio_lock
> > +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> > +            vma_start_write
> > +              mapping->i_mmap_rwsem
> > +                anon_vma->rwsem
> > +                  mm->page_table_lock or pte_lock
> > +                    swap_lock (in swap_duplicate, swap_info_get)
> > +                      mmlist_lock (in mmput, drain_mmlist and others)
> > +                      mapping->private_lock (in block_dirty_folio)
> > +                          i_pages lock (widely used)
> > +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> > +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> > +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> > +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> > +                        i_pages lock (widely used, in set_page_dirty,
> > +                                  in arch-dependent flush_dcache_mmap_lock,
> > +                                  within bdi.wb->list_lock in __sync_single_inode)
> > +
> > +Please check the current state of this comment which may have changed since the
> > +time of writing of this document.
>
> I think something like
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#overview-documentation-comments
> is supposed to let you include the current version of the comment into
> the rendered documentation HTML without having to manually keep things
> in sync. I've never used that myself, but there are a bunch of
> examples in the tree; for example, grep for "DMA fences overview".

Ah, but this isn't a kernel doc is just a raw comment :) so I'm not sure there
is a great way of grabbing just that, reliably. Maybe can turn that into a
kernel doc comment in a follow up patch or something?


Thanks for review, very much appreciate you taking the time to do this, I
will update and send out a v2 with your + other's suggested changes soon.

I think I'll keep it RFC for now until it settles a bit and we agree the
details are right as I strongly feel this document is of critical
importance at this stage, especially in light of rust people needing this
kind of detail.

