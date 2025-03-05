Return-Path: <linux-kernel+bounces-547596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E3A50B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E8616E156
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CE24CEE3;
	Wed,  5 Mar 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y44MCuF4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BPa0eunY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAA1591E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202826; cv=fail; b=thc8Q/zSbIScK4TaQYugKS4TcmO82z0PAYsduan1Kq/N27FuNYh4ij5/5UMeUrBDqbuWSckXY7NPXf10YNWx7hJxRiED4H2Tc+eSGKGj54Ta20swUhGkhgeCYnSRiTeAD+iSoPEcJ60AhJo6LuQq7U5cD5Bzdzuy++aDhswYriM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202826; c=relaxed/simple;
	bh=30eaFUPben7Z6oEGsQx5ptAyuX3IdkC0ny5Ym7+CYls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDPfzux2KIaQ4yHwHUPbVNPc4hbjDgmry+7JHI0ufl7LZY8xsDS4ybBNQdrr+4rhuxo9a0S4vQiHM0PoIyEoLXrnmycZiGJczspAMa9OYf+0eaf99RuP7TH5r6poILNWF7AO5TQtw+aU0EMZ8sxwi0KRad0Y28AVb0XgA24l7/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y44MCuF4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BPa0eunY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMfjV014093;
	Wed, 5 Mar 2025 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4QZI5HjTZpl8ikhwxo
	ItHg+8s6M4S98ni2TDDxBBShg=; b=Y44MCuF4ziZNbO4uOiOjIMxeoba66UGFE7
	Ni/oI9YQEEP+VymtAsZxefZcpyYGkzV6N3MEVxO+DmCknYMz/I7odYVtT0VHlNG1
	xPDy9I6XypgNGNJZEFm2WANRb/NlyzJGFCBG5EbDCNB79GzTBQKcjCWdNfBv2K+J
	oONGdhV4RvQtQNUVgvWqTL7CZtb0qy7Us3dHi72iKtXwpmWcyRGA4mV5B1NVoFgd
	cspzf0Gjs0+JCpHeGF4j3MBg42hVQRZKtGwH8MVt+Cbvxiv3aLk2+8g12KWWXg2u
	VrtHv302FBPgno6jIkGOoy8LVmVH9yjsQdcCiU5FqxI0Jkh3kA+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u820ec6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:26:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525ITKH1015676;
	Wed, 5 Mar 2025 19:26:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpc1sdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIW5V0prGubj0usSdJO8gBQ3WY6k5FNr/a9Z/5ZUm0flCM167Q2aH7Lz5IHjr2vHu4K0Pc/WtwOWZdxAbCvOS+ggEfxD+5W7DHzUZ9ogmG/BBx5PZ3XcVBCb03UnCnu17G7TmKswWeEU2RjnNsYl6o6ho04+Jb4Nq8Vcay5HGGHHHAxfPXyXe3rqwAVJSuNGdJAxzvjLAFkbX3DWobMu+a6vbE2lf/5ijI1+LCpLOA9ytDusuzq1WZf/zeLn+yACws5o7qc75hd/uX1RxjlJl3203ulQJU6HMcLW/vlV6zgjDyGWM0hQkN2c51xdZ3ksLK7SKuG1YZArftpjyn00Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QZI5HjTZpl8ikhwxoItHg+8s6M4S98ni2TDDxBBShg=;
 b=unmqudiGsxSZsOdFThf1ISS58caTCm+9XkudcqprQmN7RgkJmqdjwhEoOUHwraQ0suiraojRL4D0daMhNEhc37vNKzqy35xIK3VLYKZVCM+HnyWnVYVnBb9kJYYehS2i5fW1McmG6gJN3RfCqSBHmjkzn+1vOXXTeTQs0vRL+6mBsC9eCQUX2IO8i8Xjtwx26WOBirzGq5/XlN2T+mUFMmD26r89T3XY6ybYLkX2DbSJO6WQT3UAzZdLuQarwtp9dJZ+BIAuniA8dukQEj+LPeAnVMJaJw9f7Y5DpB6loGlEhZjWhJkGjtsYCsQic/spaX8YTfx2DbxeM7X7aQdofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QZI5HjTZpl8ikhwxoItHg+8s6M4S98ni2TDDxBBShg=;
 b=BPa0eunYgrEuD/g736FsvMwxMPLZTlVcaBw8OESxLjjQk0J3Wm6ljBjLUSrg3FThj8/ViB2CAmwVbgDVz0rBH1G6i6qbv8YHxfJI+pyRrTgJY2iULGZCmWbdSLks9qcrcxrYIHw2ulskjedfLkPpiut1gQnRNbkA50/mlXqZKHo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA0PR10MB6428.namprd10.prod.outlook.com (2603:10b6:806:2c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 19:26:26 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 19:26:25 +0000
Date: Wed, 5 Mar 2025 19:26:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <8c7714ca-a766-4a07-bfdc-f1d91aee379d@lucifer.local>
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
X-ClientProxiedBy: LO4P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::6) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA0PR10MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f807f50-d726-4a81-7b33-08dd5c1b9ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXl2eGGgGYi6ndXih4/ILqRPbdaG/n18XOXK6fOAvPfW4O7yY+vFypnC3/zO?=
 =?us-ascii?Q?KROix+Fm/DAwmiCBiYpOD7CLKmr9aDcK9pvogPeJO8upcaaHOoKVaho2wWZx?=
 =?us-ascii?Q?9wtyrRdYmmMOwmUM9qeLspOq6jj3yQoTCmGtfdTn/BKlWCaiMXeDAwiOn72K?=
 =?us-ascii?Q?5jhd+TeiL6xvAqj7R3EMGYf5LkMeBUI6gWdStkFzEY3cUXKUZriN7Ce3gnBH?=
 =?us-ascii?Q?WkTBIdwZyLpnDaWZ1rCNW2Avim7p2EJsmTW/ErOSGBOfS7njSNZtc10AW85U?=
 =?us-ascii?Q?ZjLUjJgv7Nrrfyy7udRVp17wdONUpIJ1zIbfVmaHYCuX+cSjR0BGK8qFeH8C?=
 =?us-ascii?Q?3KBHtwFiBw8rXs6j0g+kRYnkgQQujpRXVPZ8ZcMsYeagRbXPWRV5yHE+inc0?=
 =?us-ascii?Q?x1YX+TpBmbZ9zVqwYIlLJ7PxcHj5Ig4PpsFpvJzb6J7BjhFZ8FPCVJi8H3aC?=
 =?us-ascii?Q?OK0UFVBmv3AyletdxmR+NHyztMIEuislSXEXlqZIYJ7Dg0TJG0FFMkseogGU?=
 =?us-ascii?Q?khgGwPU6k0eabZVAO5U85TBkf34aBL0UgV0Ly31t4YJTZ4OCFL4thoX3czgh?=
 =?us-ascii?Q?cCsgR6vxuDLY7u1IgybTJkyvjtgwbaBz+8fB1YMuDHZnB4crKXDH39ZuNxkb?=
 =?us-ascii?Q?y33GUgjeYaNL2nL7dMgmJKY4moFWrU0ZMXBWoahNsI0Mll+9FpSts4VjgeDA?=
 =?us-ascii?Q?cpYmYJgTEqV8cWqujPPF/W+wz7GnKXvLlCGsIWbLuYedPLwIUJvRf5hGv1c3?=
 =?us-ascii?Q?SMY9sVbz+7uKgFHfBucyDVfoqL42l81WlPwIY/pB6W4lVFwO/4h8aap7MXry?=
 =?us-ascii?Q?TDA0yDQhUszOR9aXGfXp/M4LUxVmbmGy+Fx0p9twksJVh1UJjDMsMNH/VKCp?=
 =?us-ascii?Q?NTI+UIRpQJUiRfgQNm5BZdCrZxDjoMadK4vfCe8Ni10ULEJXLioZfZTMTzId?=
 =?us-ascii?Q?zvBg5muDVjJuIlXkhTeHT9uWb8XglZMK3aXSGCxD/xJEeSuMxN384MK7dgpd?=
 =?us-ascii?Q?M3ZI9a9YS7jOQyHRPouRoy4t6fOIYJbHcrIMKtCZ7GErgGAHKXSBlmXg+6zY?=
 =?us-ascii?Q?Gu6MTcrfoo/5upzo5XfQ0+apJYE/VScWwyEQWcm6mAMOJxB5xa0hc7h1f0Ci?=
 =?us-ascii?Q?bIvecNTpSpteT1WL+/+q2FSb7f4YIPgY4P2/+xyi2Ows7USWhKVY2yOdGB79?=
 =?us-ascii?Q?f+O2mnGGU7EyrO4I4DhIDon7YCrPuQIF7QVBMIgfglWhAesUQ/SUfM0fPVMm?=
 =?us-ascii?Q?fJqlztfcy+hLqzgNkR08L497aolTpd/TE+zNfmZ3fhlzADR4GG4vM2QR1BI9?=
 =?us-ascii?Q?apwIn8kFfL1fsb3uAFBu9Q/eAyq78Uf5ASJGre67ZyJWKo4itmQ5i5RbN4jH?=
 =?us-ascii?Q?o0sUVjt8JT/VTmQFAI3lLl0bvseq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqUcS9u9O9uQIb1/jeUVW8VKaTlIF9BH3T4/40ucYpTFSoYtpKVJXna+Swgq?=
 =?us-ascii?Q?vmdvudGTOvJB5plPSwspZUCu5xSWVwjMbjjv7UPJyxlOjPfqE9Lez4YXy5p6?=
 =?us-ascii?Q?0Fk6fi4GuJkdjOWcqjkbo0rY6uzpvwOHoZF4fpmoff82WYQ/JUeSYkpFfNpl?=
 =?us-ascii?Q?F9H1CSTURpNhqN0HF3VShfjmCQW3rh1hW3tAr6TEfJEvcjjI7Dl6S1MgpeQY?=
 =?us-ascii?Q?xqnplIFi24Qjapn4aaCX088Zg6X+A7sNDhGB3AYcpGwKWh0Fz8rRpux+jqHU?=
 =?us-ascii?Q?JyBnU2vK876GtY1NQXchnS/nwekwxt2sbRBrAn2UB5cwlHtUz1bUqP6KOGA6?=
 =?us-ascii?Q?EAUA+2fZNYxd/RCV7czwfJX4SxcZKHQ1M55zU3CWpCabL3nL2XsiOdiu38CP?=
 =?us-ascii?Q?ebdfv1Zad5vaOg9RaTfaG2PwqcTomsq2tc2RsPqgs/BlwmXgDQaTvQhFsEdR?=
 =?us-ascii?Q?gK8QvYHrGx4zhfPofWAFupv5+HveCqpLHF4Zs0iLYCM9pvhV00yIFLofB8Rv?=
 =?us-ascii?Q?86pctjJYPQqAKww5/dyCSc+9Q7yg8M4XoGcUs1HUkXAB+W9/suHqBYfmdyGF?=
 =?us-ascii?Q?SSz/PobLHeSov0a861sS6WjrjLc03GnUDh6GBgZBDfRazIY+O6/Gopue+NgE?=
 =?us-ascii?Q?bb7pBtBXxhfgG+wzDQyw/hcABDpooUAPelVtvF0J05aiEGs/G1AUlSvo98bg?=
 =?us-ascii?Q?Tdj7jAOZ/AHH+DuLjQ4nIWi75EncACpU1+DoG+NBJnxHOyJ9uloz58NPwcA3?=
 =?us-ascii?Q?q+cDxTCJXzwLriLCSW1UjEPG3Itc16mSdOfAARjctBLayUGPgOZ6XAXfn5y/?=
 =?us-ascii?Q?wckVl4X5AjWouXBpa5oeNecwBS7TihqazFXGav4Rpu9A4M7BNSw0GdCBWuoA?=
 =?us-ascii?Q?0J/lCBLoMjeaeF700mwsI957C0dZjiK4e7X65e3BndDozPHBlezjy7SycK8r?=
 =?us-ascii?Q?YkC6ALoLW8HcbsNmEA3AXv8Kd5aapc1xFgRyO5ESTuttzZDXqY+WvsETeJQq?=
 =?us-ascii?Q?PZz/i9hZnaqvTswJx+VDrIxCsd9dZLtvZalGIf6YftPyE81pOgr/o2oWTcGK?=
 =?us-ascii?Q?4g+3jQCPGMt25sgVeWwfIpRMeXqfFKTvgLrb/riZBEt8D4T7f9WsQbiMSw1U?=
 =?us-ascii?Q?y3B2f06dQZH2JEi303pIeL9vZgCgeGjdvh9GLUtdqBraU/CyYCR7kpEHpDgg?=
 =?us-ascii?Q?L7R39gZfwQ7oBZw5Nzc/6Dnqk0HrvV0ULhvFC+XwLI+CoTcn5atML63wPbbc?=
 =?us-ascii?Q?3rVvu4HldHT1oKsvB0HeFRa4psIW0UPTpSwArBG80DiXCzgyuE9LWMkcNaIE?=
 =?us-ascii?Q?iCAdieGHmuHgYp1QIFNFyMAg31xN4ROY+M4UOkJ3NZMGKKAY/qhe/+W4CNuW?=
 =?us-ascii?Q?CbMnqnH6DFDOKl9uFk+2GBJ4ZpHYptvE6UQBvu3AXF8h+yZYQBI/9/eQNTF6?=
 =?us-ascii?Q?BXTmoYNcZzqxLg+HXFQFkFn5CF4GWZsyur7bwdUwVXbVoA8v6+OwYNicaoYf?=
 =?us-ascii?Q?agrwXU2PGo/DjhLMSCA+6VyIb2iaAdShmBChImjD3YtJLR3ZPeUhhw7NJf1r?=
 =?us-ascii?Q?4ISI9sUm0nVjxaybVAOzPLuku0qHVnDeN7uVhsyFegMvRQNVswD802KsWR6P?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kxLrOUBJKyxt5Uv9GENAmvFDGSAkXvr61V++4iprqqYnS8WHVO4BP3IFd3jWEhNY3I/VIMzklzVihAfhueetG9WP+7ZbRpJG1M0tg0dDnP2WiY/xnXtc/q/SZMwA8UsoH1vz0p3nk7VaLAdR6A8oINO18Fj+6HWENEzakCOb+WWhxShOFyEnaN2J6j5b6EJ7f4bnCOaHduIVd6XKTe3LItT39N2UDBNljWwNeDUduoFvlQaICovCYmOLrkj/9YpBJC++vtoFLScAHvlio1kq9TZ2yl4hjbFzlEp/GvcuMZvLm3UuQnYWiN1hz3tIcqoAdaIUd2CcS7PpgrAKywxHvUCXVGa2ixqeZ8XhBkjRJHGoRmgEeJ+ozUCYTd/ywxSuyf4P44LY9eveKj3TTBbgSAlOEAmtEPRQAAifua1I4JyWCFVhRND1FysTZ/vyayca6YMBmYiUJPjXWcjvExo79YqXcauVQOoWYo9XvlQTm8vWca66zBz1MjNHbfvrJAwvx2k+gmOL0ueL43dQ6jI8qEurJbVaxXjeb5/uZs3I/S7h5Fvk+K++nnFMQG7dd9tEijrg5odoz22WZDzOy2eXcK2A43qW3aiFac71o0K7CKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f807f50-d726-4a81-7b33-08dd5c1b9ee8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:26:25.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE4zp61oyU+D+QAmMElCmEMsKFHIg4pRZKdLC4oL9JCQAVSBIp0e7BwhzkhHPVbFlpyKKwu9j3oF4na2zSK7CJT+kzGuW4RYx+4QsbhVrjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=986 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050147
X-Proofpoint-GUID: hnsAmq6o3JqG6tavnfhAwhf9sbIEd3MC
X-Proofpoint-ORIG-GUID: hnsAmq6o3JqG6tavnfhAwhf9sbIEd3MC

On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> On 05.03.25 19:56, Matthew Wilcox wrote:
> > On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> > > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > > can happen for each vma of the given address ranges.  Because such tlb
> > > flushes are for address ranges of same process, doing those in a batch
> > > is more efficient while still being safe.  Modify madvise() and
> > > process_madvise() entry level code path to do such batched tlb flushes,
> > > while the internal unmap logics do only gathering of the tlb entries to
> > > flush.
> >
> > Do real applications actually do madvise requests that span multiple
> > VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> > call to mmap [1], so why would it make sense for an application to
> > call madvise() across a VMA boundary?
>
> I had the same question. If this happens in an app, I would assume that a
> single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> does, not that many (and that often) that we would really care about it.
>
> OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> would make more sense to me. I don't recall if process_madvise() allows for
> that already, and if it does, is this series primarily tackling optimizing
> that?

Yeah it's weird, but people can get caught out by unexpected failures to merge
if they do fun stuff with mremap().

Then again mremap() itself _mandates_ that you only span a single VMA (or part
of one) :)

Can we talk about the _true_ horror show that - you can span multiple VMAs _with
gaps_ and it'll allow you, only it'll return -ENOMEM at the end?

In madvise_walk_vmas():

	for (;;) {
		...

		if (start < vma->vm_start) {
			unmapped_error = -ENOMEM;
			start = vma->vm_start;
			...
		}

		...

		error = visit(vma, &prev, start, tmp, arg);
		if (error)
			return error;

		...
	}

	return unmapped_error;

So, you have no idea if that -ENOMEM is due to a gap, or do to the
operation returning an -ENOMEM?

I mean can we just drop this? Does anybody in their right mind rely on
this? Or is it intentional to deal with somehow a racing unmap?

But, no, we hold an mmap lock so that's not it.

Yeah OK so can we drop this madness? :) or am I missing some very important
detail about why we allow this?

I guess spanning multiple VMAs we _have_ to leave in because plausibly
there are users of that out there?

>
> --
> Cheers,
>
> David / dhildenb
>

