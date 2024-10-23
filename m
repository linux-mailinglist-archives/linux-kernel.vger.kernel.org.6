Return-Path: <linux-kernel+bounces-378598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9D9AD2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0CEB2335C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D91CC179;
	Wed, 23 Oct 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bR+0kjK4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x36MVXiP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4412D758
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704655; cv=fail; b=FOVeq1nVDr256Jn5WUFnauKbzJUPW14BC/xYejMtWjTAb/79ScKPeFik+Qa0iJ3Okl0hVJ9pPs1bvhJF5J0CSPeXSD1NJ3f7aw4Czr3ky4R6b3Ri7bvglkKZseBRhSpI/o74LpqMXT6iPBak28jbLGjNFtHRYr4JXg27zlUTlDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704655; c=relaxed/simple;
	bh=0p2RSdIcpQ71lEGgG7OA0XddZSTs5WS5VGTDgidd2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X6yMcalJbhPZI3vVTQ5iKYoDxIyoc9R6/xj9RLO5oWxAyW2yY/3mYpIE/14AXQh4F0+kuTjxbK8p46nFaOsn9ZS0S+SoCijaqshwFDWwk64mzhWmza5Zrh3XAYHmoaGWn58abgIcoa8pfysa71qGJitW0FnopnerbGL/yjSc2Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bR+0kjK4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x36MVXiP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfcnv001595;
	Wed, 23 Oct 2024 17:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GyQqcFA17mbZz3fm5n
	mCQ3bhnM+L5RXQ/BZESGi8NG4=; b=bR+0kjK4tLvhvqtNLZ3XAEkNylNmdkZLSf
	8MtcV/SLj4v836CNqc9YJO6QMb3kAgHAzlPy+imyoxCwNc/Hpzo9PP5WIolCwKv+
	BK01mCNbRtJgtKkaJizAWyo3hUYXjcWowTFHdJ/wEtIiR+yWUsvYFHG3GQVVauvo
	KYviCtuHG1+0M2tdsO/TZkmaehAbCQ9ZUyM+6oowO/6hqtdrKulUXyG/cn795NiZ
	AljbNFjIgkAUXV7+LofPmFPdBqkPH33vmaK6HmdmzVrelPA0QRBW+4/ZshsZ8j7U
	sXevZbDcf/BZdcpTEJrOaXagxk+q0zGWeDFZj9ZoUH08f8fEYdww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qgrpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:30:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFwlG7036141;
	Wed, 23 Oct 2024 17:30:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2ts46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZy/Znyg1H3cvL69DaE2TdGVwr8SvBvUlYt1+KRkOGMY29fKpDdUBByh+aovKWStiqbM6VmwwkZcG/y0uqxmutZKXTxdb55WzAZJSUcjSBNg3biAt26BEI2tWHtMboTCC3Qyvy5VGYC6lrHlkuD0jtOTb9XpatTrqej9LQ1BEtMvok/RjbKV6FDFFCm8H/DQIMItHIc6N5oCWdYowaeEqBfYqqCynqQL1GGR3m99tUvJxWCTRP2VAglFdVmFtGL7Kth1/AkiX5TWXdIZA4Re5KLFRh2nSS/CiW3dP1IHfRt+o2htPty4/hp3mwAouNDiNoiLRVTiyNjmyon+nYK95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyQqcFA17mbZz3fm5nmCQ3bhnM+L5RXQ/BZESGi8NG4=;
 b=cZEr1B/XY9NxbtsC+1556Tg+HQhKJoORQCTI2KtTpFH0OUA+LFZ61FRMfVkUPSaj5Wiail8SkDqxJvHChVkh/d9kjhJRiV58W16/lEWa8akxn7k/sxgh0nhUJG5xB8Gvpo89sLdT8pmp/9odi4Iiz0Qm/1o9o+WQPxlGYQM40cyYVrFwc9eKh3H54Herp5pmrlcJfMjMbk09ws15FalQFH/Yh8kzSz5BVRodSB7fC396L3wZkFqjW3u75YqgCP3+hdLc240toXFVGy+m5dOf+f6qqxk85kZgflFlEzbpL6L+HFvQr/sTWbqn61s/aNFBVeT92ny4y1wHafBGTkyDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyQqcFA17mbZz3fm5nmCQ3bhnM+L5RXQ/BZESGi8NG4=;
 b=x36MVXiPW8aAXk3yOtlf63h0gp5syaTyYphe2kwstlGF0vZMb8Uds0OtdFyE1CFH8gaRIp8hCl7IFsi+SkdCCIV0iiOeW7BWTzV4htqU6wnuqy0Cd5t/qYGEm0ZfY41CUdBs1GeWkzLa5Ys/lcWz3Bw3nPmc/jFr6Vy+R5VZND4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4253.namprd10.prod.outlook.com (2603:10b6:208:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 17:30:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:30:40 +0000
Date: Wed, 23 Oct 2024 18:30:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Message-ID: <420e4a9a-28d7-4667-aac4-abff3dbf3b22@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
 <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 09013df6-4bcb-4e1e-01f7-08dcf38869e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x15KxYN9y2hlUFh9qWN2br8O3SFhKdWIjIOPYEGrpN3h3T3ImrSujkabKSCi?=
 =?us-ascii?Q?/qQUV+QhwzN4f3/rxO6Ku6hoLVaj9mze6XURxCdBUy1yOMu8VsDekawCRcsd?=
 =?us-ascii?Q?AtJ1FHWKEofgkC3TmiTTam5l8D/jqYy0v0O6aC8HM3c4OTfucCxLPMI9Jg1b?=
 =?us-ascii?Q?5aJXnAJWhsLBfsuv7H0DyKJweu22sz2+jmvUfWK7G1FvlD6dJgxbYTzfqkWP?=
 =?us-ascii?Q?pZGqIH9uXJ1UICY49OTToXBqqTfOZwc3UUbYY/6WPuT/UeAuGNlY7mW3QtDx?=
 =?us-ascii?Q?M7B7+D7aD1k8RAhs9hhblHAGYvmuRcqp2QgsePCNn60gmYDEh/FTSbaHnNck?=
 =?us-ascii?Q?3X54nW0w/js8RJq6fODdw0LcCLbh0hDgOaKKeB4mn9r7FMQtdbDzxMtDbbQQ?=
 =?us-ascii?Q?klnV3W5cVpyp/kY75xUKRLi1WVQ9JsqZTrKT5xC3E33fv+9pMufhWQaBjRl0?=
 =?us-ascii?Q?SZLh46eOxtl2hrNGZVVLR/fo0jc2aTHVC2xyUAco4W1Fsdsr6uU438UdnXQl?=
 =?us-ascii?Q?XmUL1c4TShut53MrrHEErcydNwMPvR5uAvqzFb5gB92OLhujpHL2TTu5H0m0?=
 =?us-ascii?Q?oa5R5K6LGytUI4ZlxbZuu4+SFNIc2sr8prwrMLO6an9bxEsf9+dlzVLqFbrX?=
 =?us-ascii?Q?hKaTnHwzLFTv90WNwEEK5W5LF5m/YI32WgoOBqPTOIV4XgWVE4rzKnh1K/Yu?=
 =?us-ascii?Q?RkZx18JnL+LigizXHL757PSElPVB2d7dUtRtAy3c/gNnNNnLM2c3z0fKSrta?=
 =?us-ascii?Q?acghiEhLlb6ilLJMGPgtz66rWM+jc163fdA+6L4WGXhtNggTrwLtyzg8B80Z?=
 =?us-ascii?Q?aq7+osSIVGw7K90sISDTjlUZfbunGsjB9QN2JLcnF3h3b8awBps1Dq9RdBem?=
 =?us-ascii?Q?aimYDpwYZDGdM5anjRkAe08VYcdftXH+OCkAcReWDZO1SUFLPxssK6RUbxE2?=
 =?us-ascii?Q?SOG9mrap7i7wKsHvrMF1mT/Y095tP6PhT6YwuOWP8fFJdT27xBofZ1tFf5Qj?=
 =?us-ascii?Q?FrMkYRi5MKx9lGZKu+vTkaRq1lbPCClbhztNr1LiJr93mvxIEMnEe9R/FxuS?=
 =?us-ascii?Q?POqaeql1mCeLmnQpUN8BmMQuEy1/FqhOwWay7DrgXkGwWAYCKJsp4QZNcUR2?=
 =?us-ascii?Q?V+Q1DdMWs6oxswfchPhpiW4ceCoCygCuYbzLQgTSVBSN0gtSibpX/NX/ExzH?=
 =?us-ascii?Q?Q5gt9F9l3P+wacpr8DLpHigRFy57+s0qjJfq69MJsjhe668o37MQpDZcajvx?=
 =?us-ascii?Q?0iAR2Umevulg6dYWj6efQG51JaDP16HzLdan+cZGmc1bqiqgfqnpaLk+ch39?=
 =?us-ascii?Q?A1cRCQiXgc9ei0U/DQ4I0a0N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ss42q49IzEfZBRoEVNnIWy74g9trjin/y4l9sErLrdZ0g8Qoa0xcgFNEWv1?=
 =?us-ascii?Q?tk8bSDPXGFqo590hBDCmIuVzsCPMtc1Gx7jYJsbFBA8DiCrCpZfuFGnnavIU?=
 =?us-ascii?Q?ilWDf+1yh+9OqX00uIhGIkSKXEDgie4yLy5uPjJ34LBB+qKs3374xnO/iGNQ?=
 =?us-ascii?Q?tCvIvjPNCcsA9nSfqlH6mR0DH7pUq0D0SfDHJb/MclbsbtBY5lmSF6qVxE90?=
 =?us-ascii?Q?m9f1nMPrpNX5LjJn7FGpkUIhaksu31WV1J7684Qy65415vzL1ugE3u3Ti5nH?=
 =?us-ascii?Q?GzIxFNEh6ExCkozKlJmbOSBWDpLOhHFUTFB1Trz/qoC17aTI4lvE54X0F1+A?=
 =?us-ascii?Q?UEIYdbz1coBQgfcKO+xkbCdJRlJit0Qq45LLnMbi8t6GqLAGDHL5TVKohQ87?=
 =?us-ascii?Q?Pc/X+maGt23m/e63MTPA2ZgBZKDNlqe1JbxC9Cnykp/3Ek8NI1Ot44LNmxwq?=
 =?us-ascii?Q?JUA710c889T0TMXQ0vV4yeMyFcb4iTtOoE9c6wuqPFAHTA2k44WyMgUq8RPY?=
 =?us-ascii?Q?s4NEWx8DfP++hiFCoIiFW7dEkyGJAnvvq8R40qWDQgZXz9IWZ4Ed8OJ2BXEM?=
 =?us-ascii?Q?d2B5fnlkGgvcfVd1S/lJllNe0SLKd4hlWCT/frFITlIt0BjOaZfo17HOva+I?=
 =?us-ascii?Q?IXvFTG3wufC2Leq7XuQ3rOmcq1zhz1nbw4+W61nTTPRTZgE9vowjcpFj8ZSS?=
 =?us-ascii?Q?CNRVJdWk3LFMUsHYEspK2YoMQXZ3UBLe+wl4T/LTdifyFMejajgl7Kry0CJi?=
 =?us-ascii?Q?4xSnhGKRbFpUQ2rGUSVPMo2qFuD4UbhFtikt/s0kwtulCjUp2sbxjNPHiL07?=
 =?us-ascii?Q?62BFo7Cbl0hjLuNQPc16aQScSluOlwvwrGMYtml/YsWXoaQCBSVJgJ6qdy6G?=
 =?us-ascii?Q?BAiBMGLEvREH5io2ZeezKBytMyURl4I37OT66q0GaBWC91GHdKDn5vVpvXd7?=
 =?us-ascii?Q?7Nwelde+a9cpYuoexQItlJ9uKsvbT30thsCevRPrWPHkH++XIS+FC3QxWDAV?=
 =?us-ascii?Q?GiBo1Z0b/qXOXvILbspwhS/9MES5HPjpyv3vJvX89fLZZj95HqPoORIJYJAA?=
 =?us-ascii?Q?tkvN7ajjSVa4vZVwtgYznGrDRkHCZycQqcF68JvfaJwjEyK8mMKBz9rGNR4h?=
 =?us-ascii?Q?hfYf48MEK27fA2iOt3apw00dojpOSpZJOyqL0z2xeLZX5XRw9c+/ptjIFAlv?=
 =?us-ascii?Q?jBNJpvGy8fyY8zX5wHuJhVZ7ctgB0bp5LygVv3jzPx7PcUV26TxLU3BsRRb6?=
 =?us-ascii?Q?HGfYN+YsWtS3b+PqTVIoEW5/kdWRJWjU6mTBXcPaETP4b20cLQRipyF0RHcR?=
 =?us-ascii?Q?GKj6KCH4kH8NXlJlcQCnjrACBfaj6jzhfZgbirkJ6uNG1MejWqh0ef7lPxJe?=
 =?us-ascii?Q?oy+IXfenPuELfEuR0H06xLqNtsNcS1SdNOAV4P57b+bQcrZNQA5p06stYuO6?=
 =?us-ascii?Q?2yJrmy3mQYAMi+Eg5HTXUMRJnIjFipFUHpTPXB6s3YfoAxwqntHNSVI4LjSf?=
 =?us-ascii?Q?LY6MCZ+NcJrfOaD1Uieu0ZHJ0fcTmF+ureCuN1f8tix0MoNVLgy+Sw08VXop?=
 =?us-ascii?Q?nCZoIzLfzjO9F/0Mrwb/kk4xtuxdBVYlusq7SwPYIEcKXnO2flpzN87i0o1c?=
 =?us-ascii?Q?KHnrbwaNVPjKdF+Vebwoc7ywZuL4GeBi8+US+VxbUB3kysGAy2XAgFT0cBjQ?=
 =?us-ascii?Q?BAQrvg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MXzzERM0gwn+AgzJXI5iCXIrRsm5CDspTwTyvKm8KigDdxIjwnkMAfJ/KrwPq7d02TxqBgf7e5KTCZqqJF9KtE1TpPo7L4psHGQsKPlS8q1X7e+taSwh3x5x8El7eK4DFXesg4qj5d9maYkjxeSUzMlvEosg0VeUgVKIkCIVurvl1q2wFC3DI/IFynDEBxGnS6gFa99QIcbwtaBPaRKadqmHCgQNDReznZAHBpSk/2mS9+ta8chjloIjuoK3YtwfPIOkT64VHVZYlWBdth5E6efXBKuy8xA25bOqjB+bQYoNFLasM1BMimlCigd3L97sLMz2EEp1mPmI3SyohFBSoGjl+QP4dgXi0lfEjMqbPTEyQTbE6ep44zTfiLocxhcFdHS8N8zWLlOQFhrg1ZFG6DBW73iDgBY48gEpwX1JdGz36tsDYjqAGi+EjEZ/jiimv3q6BXRK89sUmOz4bZVKR3maanuuR/ZUkzkHIXi12YaxWsotIG/Jq59J5is63z/lWAmqmxf6ha+RzUHwfP9jNB7NMGZGwwZTRaZdLk2OvqQnjeOISk+xJEKvDgquKkLI1C2h+50B5PqIoOe+iTKCsyAEuTaKLUmMIy1lx0RxlNs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09013df6-4bcb-4e1e-01f7-08dcf38869e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:30:40.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whtfcgiPuZ4RafFO7Oa+I5LOXqlJA1YSaaHKXOABNkGh39wFg4VOuV8rk46Hw8OAnrManoSAnDwcaUymGunJHZpd4iXibxDjNyCtxUbE/70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230110
X-Proofpoint-ORIG-GUID: c149G8tFIzyRnKBJvjMs17APouk4hmTh
X-Proofpoint-GUID: c149G8tFIzyRnKBJvjMs17APouk4hmTh

On Wed, Oct 23, 2024 at 04:38:46PM +0200, Vlastimil Babka wrote:
> On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > We have seen bugs and resource leaks arise from the complexity of the
> > __mmap_region() function. This, and the generally deeply fragile error
> > handling logic and complexity which makes understanding the function
> > difficult make it highly desirable to refactor it into something readable.
> >
> > Achieve this by separating the function into smaller logical parts which
> > are easier to understand and follow, and which importantly very
> > significantly simplify the error handling.
> >
> > Note that we now call vms_abort_munmap_vmas() in more error paths than we
> > used to, however in cases where no abort need occur, vms->nr_pages will be
> > equal to zero and we simply exit this function without doing more than we
> > would have done previously.
> >
> > Importantly, the invocation of the driver mmap hook via mmap_file() now has
> > very simple and obvious handling (this was previously the most problematic
> > part of the mmap() operation).
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 240 insertions(+), 140 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 7617f9d50d62..a271e2b406ab 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -7,6 +7,31 @@
> >  #include "vma_internal.h"
> >  #include "vma.h"
> >
> > +struct mmap_state {
> > +	struct mm_struct *mm;
> > +	struct vma_iterator *vmi;
> > +	struct vma_merge_struct *vmg;
> > +	struct list_head *uf;
> > +
> > +	struct vma_munmap_struct vms;
> > +	struct ma_state mas_detach;
> > +	struct maple_tree mt_detach;
> > +
> > +	unsigned long flags;
> > +	unsigned long pglen;
> > +	unsigned long charged;
> > +};
> > +
> > +#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
> > +	struct mmap_state name = {				\
> > +		.mm = mm_,					\
> > +		.vmi = vmi_,					\
> > +		.vmg = vmg_,					\
> > +		.uf = uf_,					\
> > +		.flags = flags_,				\
> > +		.pglen = PHYS_PFN(len_),			\
> > +	}
> > +
> >  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> >  {
> >  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > @@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> >  	vms_complete_munmap_vmas(vms, mas_detach);
> >  }
> >
> > -unsigned long __mmap_region(struct file *file, unsigned long addr,
> > -		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > -		struct list_head *uf)
> > +/*
> > + * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
> > + *                    unmapped once the map operation is completed, check limits,
> > + *                    account mapping and clean up any pre-existing VMAs.
> > + *
> > + * @map: Mapping state.
> > + *
> > + * Returns: 0 on success, error code otherwise.
> > + */
> > +static int __mmap_prepare(struct mmap_state *map)
> >  {
> > -	struct mm_struct *mm = current->mm;
> > -	struct vm_area_struct *vma = NULL;
> > -	pgoff_t pglen = PHYS_PFN(len);
> > -	unsigned long charged = 0;
> > -	struct vma_munmap_struct vms;
> > -	struct ma_state mas_detach;
> > -	struct maple_tree mt_detach;
> > -	unsigned long end = addr + len;
> >  	int error;
> > -	VMA_ITERATOR(vmi, mm, addr);
> > -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > -
> > -	vmg.file = file;
> > -	/* Find the first overlapping VMA */
> > -	vma = vma_find(&vmi, end);
> > -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > -	if (vma) {
> > -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > -		mt_on_stack(mt_detach);
> > -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_merge_struct *vmg = map->vmg;
> > +	struct vma_munmap_struct *vms = &map->vms;
> > +
> > +	/* Find the first overlapping VMA and initialise unmap state. */
> > +	vms->vma = vma_find(vmi, vmg->end);
> > +	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
> > +			/* unlock = */ false);
> > +
> > +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> > +	if (vms->vma) {
> > +		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > +		mt_on_stack(map->mt_detach);
> > +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> > -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> >  		if (error)
> > -			goto gather_failed;
> > +			return error;
>
> So this assumes vms_abort_munmap_vmas() will rely on the "vms->nr_pages will
> be equal to zero" mentioned in commit log. But AFAICS
> vms_gather_munmap_vmas() can fail in Nth iteration of its
> for_each_vma_range() after some iterations already increased nr_pages and it
> will do a reattach_vmas() and return the error and we just return the error
> here.
> I think either here or maybe in vms_gather_munmap_vmas() itself a reset of
> vms->nr_pages to zero on error should happen for the vms_abort_munmap_vmas()
> to be a no-op?

Ugh yup, I had wrongly assumed this would not be the case but there we go,
makes the point as to what this whole series is about... will fix.

>
> >
> > -		vmg.next = vms.next;
> > -		vmg.prev = vms.prev;
> > -		vma = NULL;
> > +		vmg->next = vms->next;
> > +		vmg->prev = vms->prev;
> >  	} else {
> > -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> > +		vmg->next = vma_iter_next_rewind(vmi, &vmg->prev);
> >  	}
> >
> >  	/* Check against address space limit. */
> > -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> > -		error = -ENOMEM;
> > -		goto abort_munmap;
> > -	}
> > +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> > +		return -ENOMEM;
> >
> > -	/*
> > -	 * Private writable mapping: check memory availability
> > -	 */
> > -	if (accountable_mapping(file, vm_flags)) {
> > -		charged = pglen;
> > -		charged -= vms.nr_accounted;
> > -		if (charged) {
> > -			error = security_vm_enough_memory_mm(mm, charged);
> > +	/* Private writable mapping: check memory availability. */
> > +	if (accountable_mapping(vmg->file, map->flags)) {
> > +		map->charged = map->pglen;
> > +		map->charged -= vms->nr_accounted;
> > +		if (map->charged) {
> > +			error = security_vm_enough_memory_mm(map->mm, map->charged);
> >  			if (error)
> > -				goto abort_munmap;
> > +				return error;
> >  		}
> >
> > -		vms.nr_accounted = 0;
> > -		vm_flags |= VM_ACCOUNT;
> > -		vmg.flags = vm_flags;
> > +		vms->nr_accounted = 0;
> > +		map->flags |= VM_ACCOUNT;
> >  	}
> >
> >  	/*
> > -	 * clear PTEs while the vma is still in the tree so that rmap
> > +	 * Clear PTEs while the vma is still in the tree so that rmap
> >  	 * cannot race with the freeing later in the truncate scenario.
> >  	 * This is also needed for mmap_file(), which is why vm_ops
> >  	 * close function is called.
> >  	 */
> > -	vms_clean_up_area(&vms, &mas_detach);
> > -	vma = vma_merge_new_range(&vmg);
> > -	if (vma)
> > -		goto expanded;
> > +	vms_clean_up_area(vms, &map->mas_detach);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> > +			       struct vm_area_struct **mergep)
> > +{
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_merge_struct *vmg = map->vmg;
> > +	int error;
> > +
> > +	vma->vm_file = get_file(vmg->file);
> > +	error = mmap_file(vma->vm_file, vma);
> > +	if (error) {
> > +		fput(vma->vm_file);
> > +		vma->vm_file = NULL;
> > +
> > +		vma_iter_set(vmi, vma->vm_end);
> > +		/* Undo any partial mapping done by a device driver. */
> > +		unmap_region(&vmi->mas, vma, vmg->prev, vmg->next);
> > +
> > +		return error;
> > +	}
> > +
> > +	/* Drivers cannot alter the address of the VMA. */
> > +	WARN_ON_ONCE(vmg->start != vma->vm_start);
> > +	/*
> > +	 * Drivers should not permit writability when previously it was
> > +	 * disallowed.
> > +	 */
> > +	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
> > +			!(map->flags & VM_MAYWRITE) &&
> > +			(vma->vm_flags & VM_MAYWRITE));
> > +
> > +	vma_iter_config(vmi, vmg->start, vmg->end);
> > +	/*
> > +	 * If flags changed after mmap_file(), we should try merge
> > +	 * vma again as we may succeed this time.
> > +	 */
> > +	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> > +		struct vm_area_struct *merge;
> > +
> > +		vmg->flags = vma->vm_flags;
> > +		/* If this fails, state is reset ready for a reattempt. */
> > +		merge = vma_merge_new_range(vmg);
> > +
> > +		if (merge) {
> > +			/*
> > +			 * ->mmap() can change vma->vm_file and fput
> > +			 * the original file. So fput the vma->vm_file
> > +			 * here or we would add an extra fput for file
> > +			 * and cause general protection fault
> > +			 * ultimately.
> > +			 */
> > +			fput(vma->vm_file);
> > +			vm_area_free(vma);
>
> This frees the vma.
>
> > +			vma_iter_free(vmi);
> > +			*mergep = merge;
> > +		} else {
> > +			vma_iter_config(vmi, vmg->start, vmg->end);
> > +		}
> > +	}
> > +
> > +	map->flags = vma->vm_flags;
>
> So this is use-after-free.
>
> Maybe pass only a single struct vm_area_struct **vmap parameter to this
> function, and in case of merge, change both vma and *vmap to it?.
>
> Although I can see it's all moot after 8/8. Still let's not introduce a
> temporary UAF step.

Even more vom. Will fix. The irony is I 'fixed' this code to something
'neater' by referencing vma here, rather stupidly.

You can tell it's a rarely used path since I ran a full suite of tests and
didn't hit it.

Again, speaks to the point of this series in general...

>
> > +	return 0;
> > +}
> > +
> > +/*
> > + * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> > + *                    possible.
> > + *
> > + *                    An exception to this is if the mapping is file-backed, and
> > + *                    the underlying driver changes the VMA flags, permitting a
> > + *                    subsequent merge of the VMA, in which case the returned
> > + *                    VMA is one that was merged on a second attempt.
> > + *
> > + * @map:  Mapping state.
> > + * @vmap: Output pointer for the new VMA.
> > + *
> > + * Returns: Zero on success, or an error.
> > + */
> > +static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > +{
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_merge_struct *vmg = map->vmg;
> > +	struct vm_area_struct *merge = NULL;
> > +	int error = 0;
> > +	struct vm_area_struct *vma;
> > +
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> >  	 * specific mapper. the address has already been validated, but
> >  	 * not unmapped, but the maps are removed from the list.
> >  	 */
> > -	vma = vm_area_alloc(mm);
> > -	if (!vma) {
> > -		error = -ENOMEM;
> > -		goto unacct_error;
> > -	}
> > +	vma = vm_area_alloc(map->mm);
> > +	if (!vma)
> > +		return -ENOMEM;
> >
> > -	vma_iter_config(&vmi, addr, end);
> > -	vma_set_range(vma, addr, end, pgoff);
> > -	vm_flags_init(vma, vm_flags);
> > -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > +	vma_iter_config(vmi, vmg->start, vmg->end);
> > +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> > +	vm_flags_init(vma, map->flags);
> > +	vma->vm_page_prot = vm_get_page_prot(map->flags);
> >
> > -	if (vma_iter_prealloc(&vmi, vma)) {
> > +	if (vma_iter_prealloc(vmi, vma)) {
> >  		error = -ENOMEM;
> >  		goto free_vma;
> >  	}
> >
> > -	if (file) {
> > -		vma->vm_file = get_file(file);
> > -		error = mmap_file(file, vma);
> > -		if (error)
> > -			goto unmap_and_free_file_vma;
> > -
> > -		/* Drivers cannot alter the address of the VMA. */
> > -		WARN_ON_ONCE(addr != vma->vm_start);
> > -		/*
> > -		 * Drivers should not permit writability when previously it was
> > -		 * disallowed.
> > -		 */
> > -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > -				!(vm_flags & VM_MAYWRITE) &&
> > -				(vma->vm_flags & VM_MAYWRITE));
> > -
> > -		vma_iter_config(&vmi, addr, end);
> > -		/*
> > -		 * If vm_flags changed after mmap_file(), we should try merge
> > -		 * vma again as we may succeed this time.
> > -		 */
> > -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > -			struct vm_area_struct *merge;
> > -
> > -			vmg.flags = vma->vm_flags;
> > -			/* If this fails, state is reset ready for a reattempt. */
> > -			merge = vma_merge_new_range(&vmg);
> > -
> > -			if (merge) {
> > -				/*
> > -				 * ->mmap() can change vma->vm_file and fput
> > -				 * the original file. So fput the vma->vm_file
> > -				 * here or we would add an extra fput for file
> > -				 * and cause general protection fault
> > -				 * ultimately.
> > -				 */
> > -				fput(vma->vm_file);
> > -				vm_area_free(vma);
> > -				vma_iter_free(&vmi);
> > -				vma = merge;
> > -				/* Update vm_flags to pick up the change. */
> > -				vm_flags = vma->vm_flags;
> > -				goto file_expanded;
> > -			}
> > -			vma_iter_config(&vmi, addr, end);
> > -		}
> > -
> > -		vm_flags = vma->vm_flags;
> > -	} else if (vm_flags & VM_SHARED) {
> > +	if (vmg->file)
> > +		error = __mmap_new_file_vma(map, vma, &merge);
> > +	else if (map->flags & VM_SHARED)
> >  		error = shmem_zero_setup(vma);
> > -		if (error)
> > -			goto free_iter_vma;
> > -	} else {
> > +	else
> >  		vma_set_anonymous(vma);
> > -	}
> > +
> > +	if (error)
> > +		goto free_iter_vma;
> > +
> > +	if (merge)
> > +		goto file_expanded;
> >
> >  #ifdef CONFIG_SPARC64
> >  	/* TODO: Fix SPARC ADI! */
> > -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> >  #endif
> >
> >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> >  	vma_start_write(vma);
> > -	vma_iter_store(&vmi, vma);
> > -	mm->map_count++;
> > +	vma_iter_store(vmi, vma);
> > +	map->mm->map_count++;
> >  	vma_link_file(vma);
> >
> >  	/*
> >  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
> >  	 * call covers the non-merge case.
> >  	 */
> > -	khugepaged_enter_vma(vma, vma->vm_flags);
> > +	khugepaged_enter_vma(vma, map->flags);
> >
> >  file_expanded:
> > -	file = vma->vm_file;
> >  	ksm_add_vma(vma);
> > -expanded:
> > +
> > +	*vmap = vma;
> > +	return 0;
> > +
> > +free_iter_vma:
> > +	vma_iter_free(vmi);
> > +free_vma:
> > +	vm_area_free(vma);
> > +	return error;
> > +}
> > +
> > +/*
> > + * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
> > + *                     statistics, handle locking and finalise the VMA.
> > + *
> > + * @map: Mapping state.
> > + * @vma: Merged or newly allocated VMA for the mmap()'d region.
> > + */
> > +static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
> > +{
> > +	struct mm_struct *mm = map->mm;
> > +	unsigned long vm_flags = vma->vm_flags;
> > +
> >  	perf_event_mmap(vma);
> >
> > -	/* Unmap any existing mapping in the area */
> > -	vms_complete_munmap_vmas(&vms, &mas_detach);
> > +	/* Unmap any existing mapping in the area. */
> > +	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
> >
> > -	vm_stat_account(mm, vm_flags, pglen);
> > +	vm_stat_account(mm, vma->vm_flags, map->pglen);
> >  	if (vm_flags & VM_LOCKED) {
> >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> >  					is_vm_hugetlb_page(vma) ||
> > -					vma == get_gate_vma(current->mm))
> > +					vma == get_gate_vma(mm))
> >  			vm_flags_clear(vma, VM_LOCKED_MASK);
> >  		else
> > -			mm->locked_vm += pglen;
> > +			mm->locked_vm += map->pglen;
> >  	}
> >
> > -	if (file)
> > +	if (vma->vm_file)
> >  		uprobe_mmap(vma);
> >
> >  	/*
> > @@ -2364,26 +2447,43 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  	vm_flags_set(vma, VM_SOFTDIRTY);
> >
> >  	vma_set_page_prot(vma);
> > +}
> >
> > -	return addr;
> > +unsigned long __mmap_region(struct file *file, unsigned long addr,
> > +		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > +		struct list_head *uf)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +	int error;
> > +	VMA_ITERATOR(vmi, mm, addr);
> > +	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
> > +	MMAP_STATE(map, mm, &vmi, &vmg, uf, vm_flags, len);
> >
> > -unmap_and_free_file_vma:
> > -	fput(vma->vm_file);
> > -	vma->vm_file = NULL;
> > +	vmg.file = file;
> >
> > -	vma_iter_set(&vmi, vma->vm_end);
> > -	/* Undo any partial mapping done by a device driver. */
> > -	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > -free_iter_vma:
> > -	vma_iter_free(&vmi);
> > -free_vma:
> > -	vm_area_free(vma);
> > -unacct_error:
> > -	if (charged)
> > -		vm_unacct_memory(charged);
> > +	error = __mmap_prepare(&map);
> > +	if (error)
> > +		goto abort_munmap;
> > +
> > +	/* Attempt to merge with adjacent VMAs... */
> > +	vmg.flags = map.flags;
> > +	vma = vma_merge_new_range(&vmg);
> > +	if (!vma) {
> > +		/* ...but if we can't, allocate a new VMA. */
> > +		error = __mmap_new_vma(&map, &vma);
> > +		if (error)
> > +			goto unacct_error;
> > +	}
> > +
> > +	__mmap_complete(&map, vma);
> >
> > +	return addr;
> > +
> > +unacct_error:
> > +	if (map.charged)
> > +		vm_unacct_memory(map.charged);
> >  abort_munmap:
> > -	vms_abort_munmap_vmas(&vms, &mas_detach);
> > -gather_failed:
> > +	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
> >  	return error;
> >  }
> > --
> > 2.47.0
>

