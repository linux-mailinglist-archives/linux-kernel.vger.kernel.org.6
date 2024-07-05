Return-Path: <linux-kernel+bounces-242877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29488928E41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF26B261BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D0176AAC;
	Fri,  5 Jul 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHgriqc9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0AzXYMr9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A892175563
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211254; cv=fail; b=q43jHDTrQX6zSThNAuHIlABPtPj4UxMb6nrotd3owQJMIyJuW1VAZ/oqjabk+8/btQHBtAxOsUDkbUus+miER2Dd5jPftmKZUihRpNuet1TFFmMlxWXtb/Td8/1ttR+6WM1r7bDcNJ/9ThNlBV8gU8h5wHvzhSTRd/xgrRcvK90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211254; c=relaxed/simple;
	bh=TC1e46tJQ5rGzfqR9OesEGPee0GR+hgkJwYCMmfQu7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9FQcZg12flXP41NO58wFx6XyU5+O+MJVgr0G1RkxX0XhcUQWK7l3xP8G3yAv+YfIr8MLy+y7ES7wM25xrnvDNsClc1Dsh372/w5ZpcONxUyNcJf+aA7Sv/bGSxTIMHups8ArnwNBt7KC44XSdcemO3STZj58udkgTwXTLx9zEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BHgriqc9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0AzXYMr9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465K81Jn024291;
	Fri, 5 Jul 2024 20:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nOHKSLw2u5PiiTK
	ftJarhvy0szUEHbxijcGlG0PD4xY=; b=BHgriqc9KE9wbjmZITxElX6Rdbh+Bly
	AGFuRZZ+Pg5zglp5CAszVirBYZz0iNseXALV3DrchscCW3Ouhlrg4xTmLh0IELf3
	Ox/uq6aYNa9QZkOuW7yqseRUxwuVigeCBH0TpmsJnhyDUykosw5hCqaxnpwq0WnA
	laXd46hX0s8ueIDok13yyNmIAAuNi/b2h60olnil+EecAmBcwJ+keOxd2Imv3lM/
	lVvMdX6tltrzcfzAu+wTrfs0VETjPdRQ5whdV/vPv4pOuluOQw7kg6DXgX1POE3U
	LRIXZShfDGHpwTyCcd9JlAuQUkAdsbZfu/rrHlSxh3WK2QzXDk0hXRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacmmf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:27:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465J20PP021502;
	Fri, 5 Jul 2024 20:27:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhskbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqRAhrkhfRP+j+wxwZVK/EOHmRcwMNYSoZh8rkPpLrroLK1R7otPPQ/CJnnQ8g1IexlFysxD+ChTb4CpHOwLCIezkSorMLuBBrUZ4A+Cjrvsh4WFwnrrxWh+dWl3Dxg/aqdFZ40Dn65BiUusUp5KITzwDpQ5C//V5fnfUMhOvFNIoQ6fDNwAd1QGf1O5BU9gaWXKV++DVCIRAYTquCXyrAkUzHaDWFivgAM6vFXF6Rh/BfEaAt1AGzgnPWkKEOj+tlRflIMX0lBL4xaNCtRDpMmq52R0wI7kL9UwcNW03WGowfjoDubke+A3BtMpw5MKClz0OW3I4Tn3832EdvClcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOHKSLw2u5PiiTKftJarhvy0szUEHbxijcGlG0PD4xY=;
 b=dSkASBMg9tGfvBciwQW/oWjXTu2fmTNNWI3LuCrZhTACU6BGPGLOOWC7So3E4vbtrZ3TPb692DGEJm0zkvwgYLJu4D0y9oYg5Wg5sxyBt9PK/V/EhPHuQob30yWnfZBxFFSepuSxL8vS8uJc8GU6gbplSTJrknBYwENTEieOF4AoDT0fwA3LfsaB9SfEv7PMTjm8IXaV+8MFuUwMtw0VCDk/mFPuLCNBcEm/cCjx+cBBmfvMwgkgRP/sooV+7CA2GsTN3kCzGJ3VnyDamEgucVantBQKMDXFS8e8Dg0R/OvhDk7/fKf/1uSm0SVj0aO6EmNtUsZMOzePBmvXwfYsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOHKSLw2u5PiiTKftJarhvy0szUEHbxijcGlG0PD4xY=;
 b=0AzXYMr961KOCpLd1mZIuRV7gK3/pIe0VEF24gHsX2EsgfLlwSBjCIDYixia6hgp6Te6YwkHHfonGX5vmx4W2Epb/M0WYSHpGxZVhGwWn4KnQJoAMgzvmGjCHWUKxMfCNjuTSwG8Bb+f05rkOvkwLk3yCrg6taI5htQnMp/Lp5E=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6687.namprd10.prod.outlook.com (2603:10b6:208:419::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 20:27:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 20:27:12 +0000
Date: Fri, 5 Jul 2024 21:27:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 11/16] mm/mmap: Track start and end of munmap in
 vma_munmap_struct
Message-ID: <37ea5831-2163-4086-8b2c-baff3be2e5ad@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-12-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-12-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d032ab-9599-4cf7-216d-08dc9d30da32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8FIqY0U3yd+PhrUSDMup0UqkJ6Y0r6Hlex7RKo8Jx51t3CWIJtTaWMH7eIuZ?=
 =?us-ascii?Q?Xnlrbx4VQ4inqt8OLhkgNwRfdRAdVmoiZ4VDfmbFB3LkIrrVmNui/7Os3iDs?=
 =?us-ascii?Q?cAbBlPIRkcpMi+47yLy32wYI0abTtShKoKy4wI0gzHr2ypmcwc5/OeTihtF7?=
 =?us-ascii?Q?6/al1E3w768cL5Khc3brsV2ahg/ZFjt7nuzSSd/8P40hJH9jHioJR8lKQauY?=
 =?us-ascii?Q?j9ns4ipQje/F/fibaaWpX9feE0GBCpEBzDCxUzx3CWPiZwqGG4YdtpoWkaxR?=
 =?us-ascii?Q?/qYKEsfFHYvYFDLn4Lpeu0y3VLBKNkmd/zC3ahM6RuapkLpHhoiwTPdSOucQ?=
 =?us-ascii?Q?mEJqIEROw3cxSmEqLPZ5w8oZhLua78Ww5TFiUw1radRqSjBXL/NjbojW9Buy?=
 =?us-ascii?Q?tsUtCQUvEEhT7VZlOOoHhE6OzK/At8Qf/Yj04ODzGdflCHIpdbBXfeVch+dF?=
 =?us-ascii?Q?XGE4hmmJlwZyFcpU+0W14Sbb1R7QjcH0vNi++7x+p4r03FS3S6/huC+fXIpp?=
 =?us-ascii?Q?/CuTdX2huQPCQz/uhqH+PKOmizpyihN2jxfdQkHwEJZJsW/OG/kY44g0hn9Z?=
 =?us-ascii?Q?C4tb/f2TubU0Ds8sPqYESVAMYN/hlA5gV6V9PnYYG1zwwtzxvF6hy0A9Zpud?=
 =?us-ascii?Q?AhfYg9d89OuHolk+a89FOs2aBUc518DMy4UTJE93BpuSuQd7jTbU1yEWCI1E?=
 =?us-ascii?Q?Qz8ofzE6DP2VzrGC9XeMZSPlEfQgEgKa7mcSxHRXdT6XtAPeyX7jDKtnWJlb?=
 =?us-ascii?Q?ngTsd2E0fkpvcV8ZIRb53V8t+XRi/ilgblcJ7VM0DeoIvTHQqYgrTK/FR07j?=
 =?us-ascii?Q?Q+Q+sn93sXLJgjS/inyrSby1LErZPq9B0l0M/mA3BcUwmVPXoFk3kqf685zR?=
 =?us-ascii?Q?FE7+xEiSIl15uGQe/UCSTPUNlSugyps2JhzS9g/DzXWrwGsMYZ7frfh3lYq3?=
 =?us-ascii?Q?GcHeq0FDLy4B1Hr831KCTe0sXaDQgxSVLmkWrafUXgviOwYEiffgY5FehJU7?=
 =?us-ascii?Q?YXczghNyk8nWV/Oc0B2qvD0Qp3OVGh9e6d9LwcQHCRVl80VlzZgQVdQ4bssW?=
 =?us-ascii?Q?d1BTE2AeiqfxrcKPeAAje2TvfgMgfq1E/SUeGPYBvcMW8iYKTichXZVfXR7n?=
 =?us-ascii?Q?8C5b75/xpzL7C2DSfhHZzs0oQpWkCbn8OZWm1xh7PlSREKwAEMfhjdGKJSU1?=
 =?us-ascii?Q?oxHXJ1S5hszE3R3OJAzQg0CBuzPkCdluuof6ZmmMHFnuNktLPvXYJtkeIUhd?=
 =?us-ascii?Q?JNub3na8ioYEli7wxLcC6v0Y5jq81Z/IRIqDd4RQBvh4bfUuIMwYa4euYc7+?=
 =?us-ascii?Q?h2T1a6YrD062jOlJRIeDwzeFrosEApS/lVC8ZDv/vPdntg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?27jcmxLUBxRwZblKjmqjD9EuCEii2ghCQLVAULY8D10b2dDxWd7OyjwtaeHr?=
 =?us-ascii?Q?JXWYFd8comiFgUe+OCubKFaywEpf+vhd7tsOtY8gmNxF3R3MfQZsyPaYz6xg?=
 =?us-ascii?Q?XxAMSB9Cgw7N5OvskNPL+q11Ce9xdcsVd4G4+bI6yOnMXJGxTN8mfQI2ZfkN?=
 =?us-ascii?Q?AwDGqIwldP9oQRcDPro5HQ3nClAyENuZ2oYfZk3eE/IEOqEPWgRTC9kvxUeT?=
 =?us-ascii?Q?IVA4M1kH41PHMiUz2VkoOkMGUF20VO7872CdjcYlnpPmLM+E9vgj8ccrnTip?=
 =?us-ascii?Q?uiLj+imDAOizAR91YmQ6FyDfuZ6obrz5ip6i6YeDrzIvmXIU9OwW+a4KuvoW?=
 =?us-ascii?Q?SBt3pta+PpUKdDFtty/ZNUVPJFyYjCS43dxR6paYzq5h4R3PVGgw+huz0d4W?=
 =?us-ascii?Q?C3LqQ3WzhsyIJvaBgKR4uoiMFdJHEoa0DWYzt3iMNzISFz7ImEKJzscmYAy6?=
 =?us-ascii?Q?1nVreSJGNNakXqUeatE720M38iUFpxuRRHzPiSm3WN4RN20t68mb9YGctt4f?=
 =?us-ascii?Q?Dagvuvrd21Z5KTSfYfiFP9twvGmfsfn60Tiv0YkRbULpzQZmJ2WhTEFxsV3X?=
 =?us-ascii?Q?DuFK9KwyoBcOQzigmLgB2maUXq+LU0D8Hg/e7WfIO3uegsvSXiFTSGMkzx9l?=
 =?us-ascii?Q?0iW16oCO7qtbOPUBx9K2gLeAGJqJiN2VN/r76MhiweJ8RTdr6FxB8LQb7rRO?=
 =?us-ascii?Q?J5BXlM75mT8F7Nqg3dS/VHNGQ0eiFjH4cgxDpP1XwyaretRoiJZumhsxn7l0?=
 =?us-ascii?Q?YrwlTOeIhOOAL5N57fpDwCRJk/R3mm+Zv/NGnSmNuXIzwaRMWH/ILTbil5Nb?=
 =?us-ascii?Q?E0mRPqkI8+U52IbJbc4/gvpDlvJkgo1jYZHIJbcg17CjVPz55RWSxOou6Yud?=
 =?us-ascii?Q?NI+whbAWr9ATpsLRxbnW4taIPiultPitiTolOS/chCPIWCpxwfM/gMf37kSp?=
 =?us-ascii?Q?4+n5rnoyfg1HAHpKmPsl7mM6Zj57QBRjH/X4xvwRv0RxNRkrQQySSvytlaxW?=
 =?us-ascii?Q?CiM2OYpBssq8S95q8+06Hpn+BKsVbiRjzhImoICUFlFmhJszfTFLAIX82VHQ?=
 =?us-ascii?Q?vGUHho3t+OMCG3hHMoukTHpL2tk2/WDUn48+EV37pYlIzS3cfnxxUI86Vdim?=
 =?us-ascii?Q?GaTuL5y2WZBZSxRlb5AnT0wqW7q6NZIk4EqwQULjNll+ACVLnc950uSPcbEm?=
 =?us-ascii?Q?DcDC0DxTPrVu1D6L03YGUE6hTa/9olX86G9n+nUMO1S22BfdxZJahYufs/f6?=
 =?us-ascii?Q?qzsgYspgb9/JY/FTVtB5YoMwNbXsrAbnwQJt9MoKe5IbZuTQw7F1xont9PSp?=
 =?us-ascii?Q?biL85zuhIeF1fRqc0qGy7gZEcklCMtFeFJZUaMHJ9leDq4RmtmFtbjtoZXl9?=
 =?us-ascii?Q?FBWdsVnvX3fP8I1k8Q1Tc/wN12yRyYVhrclYqx1LdMyBz4D0dMkB2rJanKQY?=
 =?us-ascii?Q?uKX4dvzrTb3h08mMbsb+gnRkZoAI3+ANNC8Kn9jvEE4BEJLtZ6z1KzyxPktC?=
 =?us-ascii?Q?hnYCzyfmq9ld0LzPAxGHdlGS58Owr9tfyu6beURVWEpEZM8ZJTH40MKuZvah?=
 =?us-ascii?Q?4qlVt4r8kK8g8RBbc7fCbtWkO1dcBvb7ohWDcYsuVTQ6wmv+7R9d/wmiOOgT?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qhRkY+IV/c9XjVtR/MN2mtKkfrcywEw3AzyTDQHHPAPIeQ0CxSYSztg7Uh81/3PJmGlBOPnfzTxZ5EwqX9Pgk5UKFistsdAjSau40AtfPicN5h0e8genIrBMnBbbarcUVxTdw2qy3AYWBrbfbcJMIaxClGYoehKCAnnw8iTpzVmI7RtJjSGsPZHyKkVG/Lz4irRYnkSpBWs4cVYK/kV98ybP+a4dS2GWBg4zgF1uP3Gs1F1UwTCx30xjY3IZzKdvCAxjMIiK7VsBpsoa0CAis2qZJh1EvyM8MnzcPXMJL07PmQlbKk4k33bLY5wMd/MpCNG8+lrT/64LLL6jZARsMO0L7YYQtsCu42O2V5NtuLzPkOc2fqwhVEMKOZHgtyZmqAr4EbiC2w6/xr7s6u8NLY9ZCenF7KbF6TR6K039IBwi2WembxLP1Xg9G/QQ/NuLRpNXrCARm6EjROAwaZD1LGId1DHjjmLECUZ57ZVL0LY4laSZC716SQd2eqU2LHSgEd8SgAdNGte47BF4JPrFTzfltycUQrhNEuM0uOU/pWTpQQpWdWxYJb4bE9loEPvmrAWKv2gP9REoSsWyJC28Ik9xgLck4gCATAk5E3R3efk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d032ab-9599-4cf7-216d-08dc9d30da32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:27:12.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub1JFGVnmLKNcWNSDOqqEgdbeQ/93VAfvPUn3xec/0ZRl8UK6hVBPLDleyecPcrHEtFVOrQgbS1yCbpPERKATkrvsQL7D6usRlPzJtbVKJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050149
X-Proofpoint-GUID: ChMn9VsaTDut2Cew4eftIoOKP3r02H5-
X-Proofpoint-ORIG-GUID: ChMn9VsaTDut2Cew4eftIoOKP3r02H5-

On Thu, Jul 04, 2024 at 02:27:13PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Set the start and end address for munmap when the prev and next are
> gathered.  This is needed to avoid incorrect addresses being used during
> the vms_complete_munmap_vmas() function if the prev/next vma are
> expanded.

When we spoke about this separately you mentioned that specific arches may
be more likely to encounter this issue, perhaps worth mentioning something
about that in the commit msg? Unless I misunderstood you.

>
> Add a new helper vms_complete_pte_clear(), which is needed later and
> will avoid growing the argument list to unmap_region() beyond the 9 it
> already has.

My word.

>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/internal.h |  2 ++
>  mm/mmap.c     | 34 +++++++++++++++++++++++++++-------
>  2 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 8cbbbe7d40f3..4c9f06669cc4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1493,6 +1493,8 @@ struct vma_munmap_struct {
>  	struct list_head *uf;		/* Userfaultfd list_head */
>  	unsigned long start;		/* Aligned start addr */
>  	unsigned long end;		/* Aligned end addr */
> +	unsigned long unmap_start;
> +	unsigned long unmap_end;
>  	int vma_count;			/* Number of vmas that will be removed */
>  	unsigned long nr_pages;		/* Number of pages being removed */
>  	unsigned long locked_vm;	/* Number of locked pages */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ecf55d32e804..45443a53be76 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -525,6 +525,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->vma_count = 0;
>  	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
>  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> +	vms->unmap_start = FIRST_USER_ADDRESS;
> +	vms->unmap_end = USER_PGTABLES_CEILING;
>  }
>
>  /*
> @@ -2610,6 +2612,26 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
>  	__mt_destroy(mas_detach->tree);
>  }
>
> +
> +static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach, bool mm_wr_locked)
> +{
> +	struct mmu_gather tlb;
> +
> +	/*
> +	 * We can free page tables without write-locking mmap_lock because VMAs
> +	 * were isolated before we downgraded mmap_lock.
> +	 */
> +	mas_set(mas_detach, 1);
> +	lru_add_drain();
> +	tlb_gather_mmu(&tlb, vms->mm);
> +	update_hiwater_rss(vms->mm);
> +	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
> +	mas_set(mas_detach, 1);

I know it's necessary as unmap_vmas() will adjust mas_detach, but it kind
of aesthetically sucks to set it to 1, do some stuff, then set it to 1
again. But this is not a big deal :>)

> +	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);

Yeah this bit definitely needs a comment I think, this is very confusing
indeed. Under what circumstances will these differ from [vms->start,
vms->end), etc.?

I'm guessing it's to do with !vms->prev and !vms->next needing to be set to
[FIRST_USER_ADDRESS, USER_PGTABLES_CEILING)?

> +	tlb_finish_mmu(&tlb);
> +}
> +
>  /*
>   * vms_complete_munmap_vmas() - Finish the munmap() operation
>   * @vms: The vma munmap struct
> @@ -2631,13 +2653,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	/*
> -	 * We can free page tables without write-locking mmap_lock because VMAs
> -	 * were isolated before we downgraded mmap_lock.
> -	 */
> -	mas_set(mas_detach, 1);
> -	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> -		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> +	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
>  	/* Update high watermark before we lower total_vm */
>  	update_hiwater_vm(mm);
>  	/* Stat accounting */
> @@ -2699,6 +2715,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			goto start_split_failed;
>  	}
>  	vms->prev = vma_prev(vms->vmi);
> +	if (vms->prev)
> +		vms->unmap_start = vms->prev->vm_end;
>
>  	/*
>  	 * Detach a range of VMAs from the mm. Using next as a temp variable as
> @@ -2757,6 +2775,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	}
>
>  	vms->next = vma_next(vms->vmi);
> +	if (vms->next)
> +		vms->unmap_end = vms->next->vm_start;
>
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	/* Make sure no VMAs are about to be lost. */
> --
> 2.43.0
>

Other than wanting some extra comments, this looks fine and I know how
hard-won the unmap range bit of this change was so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

