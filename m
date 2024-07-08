Return-Path: <linux-kernel+bounces-244308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B492A277
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1030D1C213EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407327E10B;
	Mon,  8 Jul 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oC/l/Ews";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pk5FvaqN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF822F1C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441155; cv=fail; b=D3IlGzXtk9qcmACcYJBlvSoe2YH84QwYvM8QaJM+PQGgW/Han5JoGXwDL+3JqfJqwaHGnDPma88L17kt88XjvBcprjUinmj94tKxT+W7mU410sZzAiKcGaAMFW41OFdBvjBgEKAN/6s9dWMkJVQmRl2BTkARQkka+w4vvRZI5cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441155; c=relaxed/simple;
	bh=XJAhGGK/2hNyXmytRP4M/pw3M+aXeZnTWsaIzfnSHaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s2WiOCchEKBUmQPdTwGer9uETp6Ic/ylBrMBoI48nSB+DHPGrrwnisOldDjD8b2zrNoO4mrZNNABGXzyXFfrIlYlWmKqypdWZaik94sm4gPAOEXQahlDC2+6XjJAvuns993xPllfkNeiKsDnaRyEoprlp639pLf+zDqCO9bR1wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oC/l/Ews; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pk5FvaqN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fXRJ016806;
	Mon, 8 Jul 2024 12:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=YVSkplPXB40EywF
	QBkwd2nk2N43nNFf2c/hXT7yQ9rc=; b=oC/l/EwsZ/s+1x8XOzg8Mc6uaqOXwnb
	u0vlAROvkN6ObW07s4TLEK5S8hjpF1bb6QFHphSIM2dDD+yg7E3bkt0ydKcWKE+g
	3yT/D21iwBfGS+KUdu/Y9ism8dES5j9qZq0m+3iapwUqPCk1si7XgmI8kn/Kh24u
	aRCKdZZs1egf+SaNtdcGWKH4LAY06Q7wrPpVHpHSucpinIrgWlEpuGu5Q0P7IDzc
	430jzJ5b3UA5mG7NKNF4ziTf9yjjCOHX5esdha3XaCkzJmXZhQDTHLfPNFaT2Wfe
	FsNTNTbP9Ch01BEO+V97itTNTRzm5tVZ7RWqwkmfO27Lexm7ZjIz4+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky2h46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BYYGl007626;
	Mon, 8 Jul 2024 12:18:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu1jjx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1dtudVK4ZSB7z4Skm1Sd2WPetknwUzAeDVuXhlrIygn6/4JbEN4V/N7bLsAvUjIwIK4GZE1t+7biXyEgfoELo+r4L0qFAFvKhbSDJlJN5+uAovuFII1zqDq6gz85yaZ7PMe2FfmjnXqWAchSlwDtO1HYto9CgAIveKeaLe7irJrGQoJKo6GzY6vo3MbbtSaZNwUEjXlDPYOBFQVB0zMKJ91BU794KNW39y1PIBZONYsR86TIjRcCkvaQ0/ZDSutYuY+DMEQjrxyHHtx2gJZW53614jnbzZ4MElghvQzrmo2NLkiWCVkcTfOdqleUwz58cw3MYF8nJ3uc1k37jX61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVSkplPXB40EywFQBkwd2nk2N43nNFf2c/hXT7yQ9rc=;
 b=N28JF3fGBsMWvs4PGTcqyzIbA52sFYaFc7/3QBiY8IkpRNEs31BdBW9sWvl5nGJdvoJnJVEJ1y3Nl4I/lihjVoycwG27hOTCV2FSijaFCSeoTXYdMHy/gHRAQ/xrBNMf9jgjV9W0OYTnJluzaHGn7NUB1SxNfejCZc0hhS7MQOgryqA2QQt9K+WylJrx3kQuhfXQdmQqXieYc+CGQDHbXUsQK65D4KTtpkNsCbpOqqSKaKfo2A3NImX+6JLgy88j+rCDATL2PhBakACGgu1HJCwnfBoG71AJtM4McfwZXwpcNd2sT5urVZHlCQHXd7bzomgpOZpPREeEMzDEPwH4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVSkplPXB40EywFQBkwd2nk2N43nNFf2c/hXT7yQ9rc=;
 b=pk5FvaqNXCT3I+NULuEJuo9tI98B7uUpwwtxxycZTa//fRRSGkaZjHM6I6EPyhnK6iBC8QvShOt0gqPhLQOIWF3Du6x9QYUUAvrcXFl0hWIq4WGQpvDh/Zj3Avw/NxBm7PY+pINcDoaEySuXbtq22UP2kU6DULk6YvOoGouYNUE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:18:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:18:43 +0000
Date: Mon, 8 Jul 2024 13:18:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 13/16] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <867602f8-85bb-4c2c-81df-c15de15a2bf8@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-14-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-14-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: b753ab8c-528b-4dc7-4df1-08dc9f481c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wesHObE1SjZXEHTxIPyCUOqmXPbYRnhpFQsFaeIs+3NNgzLeWPFPVCRgxmwD?=
 =?us-ascii?Q?G2SVpzOtxy6l82Ga2fQdHrUJWwo3xYQQnOA/d56cwbURxsEp/9IdbNQOh9QT?=
 =?us-ascii?Q?VILPhnVoeOwKlyq1DHIGa+x0t4CzPh70AtKjlCRaZPYKO/qXXYkPwqRlHs/h?=
 =?us-ascii?Q?iOL9GVdbQKDHEzPUDBqpskXiIK/kT9UnmHxNADCAttgF2i9bLf/E0MfPKZJq?=
 =?us-ascii?Q?bYqCLMYKA33H4QDivaIiLtnXZYb80kRA//DuBT6S+e67a5iEFt2GzmcrKo2c?=
 =?us-ascii?Q?hVUxZK1hMWlyteZnI828LDgc8Xz8eV8bY6TBeSDQbYIrJwtwusY8o6jBpfuA?=
 =?us-ascii?Q?jBkgK/kHPszqL/F7CbipfVH0sFkjSeKPXZtyMYT8/Sc3KzBq7IsMvZ31wF7V?=
 =?us-ascii?Q?oJNk8nbdrC09R2D9pA8xFBTs3ko+RMqw+4++D3v95PAm4ZAgMThIFYijVSOr?=
 =?us-ascii?Q?95MXv+U+Gz171C7Iw3dhqPdEE7Rk0h6VyKPggqEuwShsQdqsdIAllR3BL6i+?=
 =?us-ascii?Q?4zOHNnd4FvDZ6oA9tOwAxJqqDL1t9wzAo1k2bsZ2ScZUpy4zwR2CEZqky/YI?=
 =?us-ascii?Q?jac7hDiIT48CuWuzyCaf3cnWwvpa5qI5S80exXSGeNl7mK23H944OSGzBx2W?=
 =?us-ascii?Q?qjQG3H5ndw55JEmfUN9gbsIq6iKvqq9t7pnH9e5e8KizpvnoZGDWTrTzIDrW?=
 =?us-ascii?Q?R209gSv8Kwn1DG5TjxMEYVdSV1qF6TykOvv87VRWJoixotMCam1tffjubiOy?=
 =?us-ascii?Q?FDQJFe+FR5iRHYj6KQ9ovPmj6cIjCmK3kZ7NSxrP61afrXp3gQNvTLbXbjEI?=
 =?us-ascii?Q?opebUT9+wSy5x03EqXpPOphExjdg3tkDXURiTcDMrxRGtc6ik3xAQW701Lbd?=
 =?us-ascii?Q?O6LvdJo2YJ8w5g5eXYtjdFjOY2KkA1FdIsD45ihM5SHe2fl1Ef2YZsGmwlGt?=
 =?us-ascii?Q?XuUsuY2/qOerKtAHnW7dL3TrxqmKnZRcwxApsan3uHrgGjjtsVeHQW1sC3O4?=
 =?us-ascii?Q?Au1FH79lfc1OCEm5/wyFfSUgXmUq33k8MYHf5TgDhaO1vy3pO2uZYJxb1WQh?=
 =?us-ascii?Q?r6Ruofk6C29AmoYBlDNGJ4L2PGxdMZKfHTsgwCz9kdS3JVuwIIgtLM0sALfo?=
 =?us-ascii?Q?ckqRmy1tVAfDWpE82U4x9IPehcEu5PXS3klxGDoIn0NXO+pJuXpArwM0BQI3?=
 =?us-ascii?Q?gFnSzO/lMqkcKZrc66zQiLwRGw8zwrYBnklDntuHkxNLJb6vhXDDhXuGReQF?=
 =?us-ascii?Q?lZ/qkAnAcHPXjJNuFYxmZ9xgSNyVIzAnjkrVxEnRhSqLQFlGorpsI8rhGIaP?=
 =?us-ascii?Q?E3gtwUCRgXwxGJMKocSv1piNZG6pn/YbS8FV9viSt7xa+g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hd4SroGrAMQtZSsRk0OwoIbD5rKcBMFW/3aMh5C789aTghd3UCRIbJY6FY76?=
 =?us-ascii?Q?B/Hj1iYg2+2KZIdBfIC4XGbMbPWNccdPOsxXR61bda1PVMpaJ4/CJBfGPD2A?=
 =?us-ascii?Q?UtBSaqt2vqs77gu30vOQJeIEY6H54+9Wp3nK7MXLz2fOWohMCrHxov/HjS5i?=
 =?us-ascii?Q?oV5/K21o0YuSJWYSdytku/xSYmn7W5TgVeZgCuZ7JEwyh+GabpXNwtabwkfG?=
 =?us-ascii?Q?rCBYZIrypR0JKdEAsNoOIbxhkU4tqLUUTkKt7UvCruQTB9000EQfdMTA7R7h?=
 =?us-ascii?Q?FrF6aR8t7k5BE63KGW/J6DCD6U8TqKpxDj9I5xXmONf6DErGcuMYmzVHOL7y?=
 =?us-ascii?Q?v32bR/2cfoHsJ0gYCYWAo9FBEKoPoFEW+aTVvTH7J2THDKOYgAAF3VHFHMD2?=
 =?us-ascii?Q?iayhEu8Our6WH18l1horUJbhWTVNDQtQzGIF67nmb4zXMNXNRhPzNLGgD+mw?=
 =?us-ascii?Q?oGUtovDyBUq0MHcttGgceQ8pGZEaKf5fyMk11Qz1BQypzbrKUwfwPxuYjthQ?=
 =?us-ascii?Q?0ydvMczaIsDA+XCfGPlqdHswFhY/K/WJcJbXXPPwko+/pxiAP7IHvv5yHt9w?=
 =?us-ascii?Q?ce+Nsesn+ncV/WJOUlc1kDuRAh8Zsh9H63ZoPxdVsy8+3g0ATnkPM3cWDIs9?=
 =?us-ascii?Q?DXYjGhkEQ5m4gdStKShnDuqBwE2itZFbE7ERg5/GW/g8d+Blp+pzcb7YCAVt?=
 =?us-ascii?Q?4X8/LgB8kgI6Nd81necY66Zfg0ia88dD6OTp2LrNb58dQ/xWvc7XlYwgSsUX?=
 =?us-ascii?Q?/PN6dex6vBJiHLIT2wbA1zrOcy2LnEbX/MSd4x1tG8LHe5z6STek2Ko+lAFr?=
 =?us-ascii?Q?hqKG9MchC2pXHIvd82S+CclwMzyN6w05uSUWMF0i00pSCOXslVNjCYcjTsXC?=
 =?us-ascii?Q?VeAC9/CO3DjO1H6njeYsm+6PZ1EYHIYY24QqqOF5TVwTfzloheL/8JZG0ND9?=
 =?us-ascii?Q?zbsIt3w33vqVWT+pHEmUUdOvFJyTVE6DvJOSFUhPbvQPKUBWdF04OOl88via?=
 =?us-ascii?Q?MrdxUw5g+zTm8MEbKVWr1pseWhFLAR0LUTg+nXvSM83TSxUsezCAvkaWGZvC?=
 =?us-ascii?Q?f+4z6dKVOHKgZbAqWCw36XCkruo4KnQ3r3BRQ1cQ4A9w19UEWnVkGik+Vn8T?=
 =?us-ascii?Q?bsmxz6yGHTvvgQjG4cuheFsUeY6h6rWEjB0WXXduuS6SzFUG44Pl+/yVlbDt?=
 =?us-ascii?Q?MS/4TlN3aHgA0cYEtzcrxYligDxs3WZR1vYVOYDsv0u83BXY0Q+AepqobGcd?=
 =?us-ascii?Q?D8W3GLx5280Vx9Xu0awKHbyOY+TD7aIbGvwgjjOkx8wmNXogGq536Ck1YTh8?=
 =?us-ascii?Q?54KTFObTQaGvQlnclvrtDPclPtzH2wB5HzOopAi7xkc6az0rzH/1bhC1IEAx?=
 =?us-ascii?Q?mGs1G3VJvWxUVRW1DZzjgYJ92SPyvo1eLKhxv+08a0WNoPXqtY8dvzODfKHe?=
 =?us-ascii?Q?Qzmx2bJMZJaP4V4LGU5bv2VNPGw77jqIheZ2Vt2lC2NvBThow7eA7mHsRPtX?=
 =?us-ascii?Q?WSFN5cCeCSVSnjmvt2Syj8rPVdOLDYF9YxpZGybhu9FBXtqEq3ga1rMi+CL5?=
 =?us-ascii?Q?JUk+sWJC97PeDbwf0Jfpk06R/k3Q7zG/FK6+oP50QziSUdHMGAVYsBzYLGoj?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8gAUyWUwBktZGiIae6dhol6Y1DrY0nc+s89AxCZhhF1Cvk5norLN6eghbd0YqDWPp6UiCf+Uy73RPLEC9mxkebVHZpnpYKtWIYDM7gUj2S+NOmeF9Ld1ItEzJACScRpVaYn/IdIrGCXGqv8kzLT2+It1f/Ejc8Jt45Q0VLjALe4N0xzkVjh2QkVDrCylFskbiTAhnUFdoUdl9s+Yjdk3A6VAozcbYOSTJ0IvHXIoWRcwrEDKWIxwnzGhqG+HSukAUYHm7k9PbODHStweuZDwkuWL8C1MvxW5rwcbE5SdUYutoeL/ar6TD21ZH/yf7SRUTMItriwzqTeSZ1xaQ4MCaZnNu7kDlhXn0JBhi3MSmMhuGiZ+8EAaKYRYzeCLgLmO/etPVj0+nTSizhSACvFofZMipL7exd9MUOeKaJsq/LaGWWrt/d0bXY9IhPr7zib63lkeDavSvi2atZ/04Z/+Je64hk3E9N8JW9FjoxmWqrriRU8EUgPWPfjWsGwU5PSoxNZSd5s8eM7MvFLTK5/WgboPMd7CybgW84ztvKbywbN+34S+dPFnoAhVi2Nbo3PAKGCq1rz+Lel2QzudJsYjkRcAxbZZ86DXTIjpfP9Qgt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b753ab8c-528b-4dc7-4df1-08dc9f481c16
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:18:43.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlkBZA0WUdUSyL1wdUxL/28iEdfMJ9elWE5h6hlTxgwuJ1RqOEkrJqx6u5VA4WavhbyPWmNqWthnrytTev+hikeIwoLKEguGd3x/p0vaB7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_07,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080095
X-Proofpoint-ORIG-GUID: V44dPeil_9gaDuhAmJJe7vStkd3rXcLm
X-Proofpoint-GUID: V44dPeil_9gaDuhAmJJe7vStkd3rXcLm

On Thu, Jul 04, 2024 at 02:27:15PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of zeroing the vma tree and then overwriting the area, let the
> area be overwritten and then clean up the gathered vmas using
> vms_complete_munmap_vmas().
>
> In the case of a driver mapping over existing vmas, the PTEs are cleared
> using the helper vms_complete_pte_clear().
>
> Temporarily keep track of the number of pages that will be removed and
> reduce the charged amount.
>
> This also drops the validate_mm() call in the vma_expand() function.
> It is necessary to drop the validate as it would fail since the mm
> map_count would be incorrect during a vma expansion, prior to the
> cleanup from vms_complete_munmap_vmas().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/internal.h |  1 +
>  mm/mmap.c     | 61 ++++++++++++++++++++++++++++++---------------------
>  2 files changed, 37 insertions(+), 25 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 4c9f06669cc4..fae4a1bba732 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
>  	unsigned long stack_vm;
>  	unsigned long data_vm;
>  	bool unlock;			/* Unlock after the munmap */
> +	bool cleared_ptes;		/* If the PTE are cleared already */
>  };
>
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5d458c5f080e..0c334eeae8cd 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  }
>
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> -		unsigned long addr, unsigned long end)
> +		unsigned long addr, unsigned long end,
> +		unsigned long *nr_accounted)
>  {
>  	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
>  	unsigned long nr_pages = 0;
>
> +	*nr_accounted = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		unsigned long vm_start = max(addr, vma->vm_start);
>  		unsigned long vm_end = min(end, vma->vm_end);
>
>  		nr_pages += PHYS_PFN(vm_end - vm_start);
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			*nr_accounted += PHYS_PFN(vm_end - vm_start);

We're duplicating the PHYS_PFN(vm_end - vm_start) thing, probably worth
adding something like:

unsigned long num_pages = PHYS_PFN(vm_end - vm_start);

Side-note, but it'd be nice to sort out the inconsistency of PHYS_PFN()
vs. (end - start) >> PAGE_SHIFT. This is probably not a huge deal though...

>  	}
>
>  	return nr_pages;
> @@ -522,6 +526,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
> +	vms->cleared_ptes = false;
>  }
>
>  /*
> @@ -730,7 +735,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_store(vmi, vma);
>
>  	vma_complete(&vp, vmi, vma->vm_mm);
> -	validate_mm(vma->vm_mm);

Since we're dropping this here, do we need to re-add this back somehwere
where we are confident the state will be consistent?

>  	return 0;
>
>  nomem:
> @@ -2612,6 +2616,9 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
>  {
>  	struct mmu_gather tlb;
>
> +	if (vms->cleared_ptes)
> +		return;
> +
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
> @@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
>  	mas_set(mas_detach, 1);
>  	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
> +	vms->cleared_ptes = true;
>  }
>
>  /*
> @@ -2936,24 +2944,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	pgoff_t vm_pgoff;
> -	int error;
> +	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	unsigned long nr_pages, nr_accounted;
>
> -	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> -		unsigned long nr_pages;
> -
> -		/*
> -		 * MAP_FIXED may remove pages of mappings that intersects with
> -		 * requested mapping. Account for the pages it would unmap.
> -		 */
> -		nr_pages = count_vma_pages_range(mm, addr, end);
> -
> -		if (!may_expand_vm(mm, vm_flags,
> -					(len >> PAGE_SHIFT) - nr_pages))
> -			return -ENOMEM;
> -	}
> +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
>
> +	/* Check against address space limit. */
> +	/*
> +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> +	 * mapping. Account for the pages it would unmap.
> +	 */

Utter pedantry, but could these comments be combined? Bit ugly to have one
after another like this.

> +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> +		return -ENOMEM;
>
>  	if (unlikely(!can_modify_mm(mm, addr, end)))
>  		return -EPERM;
> @@ -2971,14 +2974,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>  			return -ENOMEM;
>
> -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> -			return -ENOMEM;
> -
> -		vms_complete_munmap_vmas(&vms, &mas_detach);
>  		next = vms.next;
>  		prev = vms.prev;
>  		vma = NULL;
>  	} else {
> +		/* Minimal setup of vms */
> +		vms.nr_pages = 0;

I'm not a huge fan of having vms be uninitialised other than this field and
then to rely on no further code change accidentally using an uninitialised
field. This is kind of asking for bugs.

Can we not find a way to sensibly initialise it somehow?

>  		next = vma_next(&vmi);
>  		prev = vma_prev(&vmi);
>  		if (prev)
> @@ -2990,8 +2991,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = len >> PAGE_SHIFT;
> +		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
> -			return -ENOMEM;
> +			goto abort_munmap;
> +		vms.nr_accounted = 0;

This is kind of expanding the 'vms possibly unitialised apart from selected
fields' pattern, makes me worry.

>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> @@ -3040,10 +3043,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
>  	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> +	if (!vma)
>  		goto unacct_error;
> -	}
>
>  	vma_iter_config(&vmi, addr, end);
>  	vma_set_range(vma, addr, end, pgoff);
> @@ -3052,6 +3053,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		vma->vm_file = get_file(file);
> +		/* call_mmap() map PTE, so ensure there are no existing PTEs */

Typo? Should this be 'call_mmap() maps PTEs, so ensure there are no
existing PTEs'? I feel like this could be reworded something like:

'call_map() may map PTEs, so clear any that may be pending unmap ahead of
time.'

> +		if (vms.nr_pages)
> +			vms_complete_pte_clear(&vms, &mas_detach, true);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> @@ -3142,6 +3146,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  expanded:
>  	perf_event_mmap(vma);
>
> +	if (vms.nr_pages)
> +		vms_complete_munmap_vmas(&vms, &mas_detach);
> +

Hang on, if we already did this in the if (file) branch above, might we end
up calling this twice? I didn't see vms.nr_pages get set to zero or
decremented anywhere (unless I missed it)?

>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> @@ -3189,6 +3196,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  unacct_error:
>  	if (charged)
>  		vm_unacct_memory(charged);
> +
> +abort_munmap:
> +	if (vms.nr_pages)
> +		abort_munmap_vmas(&mas_detach);
>  	validate_mm(mm);
>  	return error;
>  }
> --
> 2.43.0
>

In general I like the approach and you've made it very clear how you've
altered this behaviour.

However I have a few concerns (as well some trivial comments) above. With
those cleared up we'll be good to go!

