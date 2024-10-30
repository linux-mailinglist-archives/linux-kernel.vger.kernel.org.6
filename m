Return-Path: <linux-kernel+bounces-388634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1539B625A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DE11F21564
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E901E572E;
	Wed, 30 Oct 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h06kLUAY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ww0SSmY2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E81E6DD5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289245; cv=fail; b=hCzJOB97VShb7KOMARy++ba7OfTZN4UZrklCMfypaQQlVf8kZDo7zGY74MMAWHnAGMaX3u0Lj0igy5FqpfYLpixTurx6UXq5MhyydPIx94RtgONZyoFtzi88sqaqqVkfLFYcielie7kSIlDHz+8ZQ7q6limP3NJz/oZ6WykJIQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289245; c=relaxed/simple;
	bh=MMF15mQHQFY0NF7JWzUZB3pLcVNOyF26xN6j6xHctkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jx16t7a/eTHaiNpcMdfR3Jt6CpTyL3/yVTJzByRMZsg1MQMVOW5VNlc6qo7ntRNTo/qIn7VpzlTh7/W0pKx2YwN9Fc6snWP5zdeKAcuerwUBAhbe2Z/Ck/5FYm8pg+daXO//0E+w/fIw5//l/JNcN/Y5L5lT50XDB4jtzCQUDVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h06kLUAY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ww0SSmY2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1fbGE018349;
	Wed, 30 Oct 2024 11:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OWCqb9d/2Cqq/VuBx9
	3kXHFnUHzoHSzR6pztkywoACM=; b=h06kLUAY1rfEpQdsvB+NWr1yjCFmUJZctE
	VXVcvT+/hakMI32zaYq0QxJzouRgpYblMQDKeDfbugz1RVoCrbe5xC19ND2KOFLm
	QPRYI5duX1H5rx6QKnL7HTdESOnznLvDPIV4rGVMH7qRUxyt6YjyuDGQ2D+7idZr
	gSxYjKea+MShja3tvxXaGHFT7wGbD+ky/VjrnvDmeXgmWY4Ie/pGaBDRAF+oMEYR
	Qs+YynbyVrD9Y7iusSpE44QZi54wdASIEs/yNAqFAdMqcnXFX1KFQWxl5oobKt0k
	YtAXK0xvHTAU+jU1SV8eVgLOqqWSwcBr1L2SRvOxc2/U9uv9vuQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1yqty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 11:53:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UB0xJD004797;
	Wed, 30 Oct 2024 11:53:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2vkbdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 11:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfTD6uQ2KlobV0hGb4x4IGxfNWolurXo1ExYgQwhCLlZpaEBOMW8+G4NRP5CXdRSuf6eJB57C+IYnv//7EJIU8B9PfEZXnuUMXAZT2O4eyWBXilJFav0/TZs3VEm/A6+D+sMmEdDuQedcP1SJUtH3MNr9HHqdHaB54t0SEY4j5VqjMxSJZQcsBs3xIbepyuT2sHkR+KTUQiwgfDVPfGUhU6EitxphHCky0SUJgDQH0yJaizGCrFN+EpwPgqqSyr33bjkhIWZ3XdXrtB4PEoBUA1WnjHt6MkzUgQCFwrY5pexvwqAZnxeGDaQ62rxGsQtx1ndtU4uOF9MzL9rU3h/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWCqb9d/2Cqq/VuBx93kXHFnUHzoHSzR6pztkywoACM=;
 b=E7Rsof2X8rC2n5gz6dVMlmSSlIvtxXLImpFbPykfNNS9ykP/n7O8F9B9h3o5ww7KXvgt9xqXbq7nY/kItKpMfvb1d+8rnNpC6la6Ny/7ML7Y6UnUMkbhQbka2H58+sV7eDT5wdfnuhQzqqGMABFhLxHTtJzkSmBT/V4oRKP4I7JfGuQB0TTC7KMpS5mzL7jChSEBBn+GsukNtYvrb8hPE4Ag6xxmORr5/Yyh79J2ZrvvnVqEyTydKBjhR/RE0PZz03i0rglyjhtJxnzZSyUtQDgsO/1k1EaFtPMgaPD9AWm6yZtIgBMhY2ySRgkDrLCriPww7rvm8E3HHRm8xUwiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWCqb9d/2Cqq/VuBx93kXHFnUHzoHSzR6pztkywoACM=;
 b=ww0SSmY2nUN+5vUbe+wNZ+fjYLxvqzL3bxKBnd30rTEyvpm0Hq4V7AcfyPaHezUGTCsg5puHAXcL+Va6ZWt1uyhTz/5/JiC/H1hEvFBza31pAuEm6CqKphmxFcffbZ1/CZ9jrHc7MDPmTc7ysGJ3GSXdzNFhzPI54B0NskFjIzw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY5PR10MB6238.namprd10.prod.outlook.com (2603:10b6:930:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 11:53:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 11:53:10 +0000
Date: Wed, 30 Oct 2024 11:53:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>
 <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY5PR10MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 01173618-d916-4be5-48d1-08dcf8d96d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pq86/hajZ23lqLLfY69TGtI3r2wP8Z3ZJ+LA0PJenA38CuAg2zuXjhFuUZIz?=
 =?us-ascii?Q?2qBBq35t16m+aCJkJR4qF+fJG32DqhA15mq+Z7qRykyF/xFhUjqKv3SNMigI?=
 =?us-ascii?Q?FEfYwF4lOIYtOOX7Bqc0cxNwO4CDDFHMex4Brch4Al+jj+POQrVNm4Ok5ajp?=
 =?us-ascii?Q?P6FJZwL42P++AsoftlT+EdY/prATL+7hKDTAEXGMM7A2GfwlA1ZJNuMP4mzi?=
 =?us-ascii?Q?BSbPaf0+TAAQyBYRhUm/7Fs/tvIvl2R5P5fSDaKgDp2qyBDI2Dq3tNd/3JLE?=
 =?us-ascii?Q?zfWRhRmSRU9Ek1xSKiNm5PRX9CBYq2+xqau2d0HzrzMd65OMdzv0srNqwFf6?=
 =?us-ascii?Q?DrIc6avfa8nXhLgY+Tm77fUDcdjLU80ISv16k39gXkMl73tMCO4N5UEjoFzO?=
 =?us-ascii?Q?r+69AYtOzT3YOrtSG2RlNBux/O4NyqjSZ86xL3S19BfR846rgpz0aY6U91Rl?=
 =?us-ascii?Q?C6ny2u12icZB6WM/3EYf5jOny254sBDVClvzEjjr10v3C6jY7yzCPXht+VPc?=
 =?us-ascii?Q?FvUrJZ4uRy9O2Z6OxnI7AzBd1mbZKrb51/o3mtO1LnjOA/8l1za4Ozx4kq+/?=
 =?us-ascii?Q?cn0/pk4HGLR4MU0VC4C0K0eBezpr8iOHC3aSedEyWK40DmIUH54u3sdgI+oT?=
 =?us-ascii?Q?7cAtgy39Z94EypZzegjmweNrIk4boAPcX58VwH1DKgVW3Bh3pRH5nd/USsyL?=
 =?us-ascii?Q?dQ8oxDP1ozyVMZcM3BO/GXjy5fGrizTJ7rxsoOuxbIlWrPfG5tCgXXuA+Jw/?=
 =?us-ascii?Q?RuFhLdMJmBg/2EgPy9TfT4JlcrzOEavaQHcrsydWF1rc+9qmfkfl44vGQsyR?=
 =?us-ascii?Q?4DG/1hEX0iJc2ZIffk7qF+Fm0H78p7QIPFO+HujBlEkeRqnsicKKdxH+UO9b?=
 =?us-ascii?Q?HQNDKbwLaK4n8U/yT0q4CDN0bgLsBZtJ0hKOJlP6yEGebCn4VyAG+pj9gdqC?=
 =?us-ascii?Q?SEsW+VGr6oQc9K0mjXgZ/7wjod3l7nFSlMj8bR2hncwCrh91dyYSio1cFeqa?=
 =?us-ascii?Q?2cQtmP1krSvZfvLyMx4qzEeabnKKqw4WJOvR1wGzzha8RqzogAvW/gT3lbUx?=
 =?us-ascii?Q?bKgMOQRnPnUjz0XTo+LkYzr4teuLE9ioYbUuV174athmpDzC9yhR+f6zoTlB?=
 =?us-ascii?Q?vHO3I1sByYc0N+P5dT1KElUNyEyg2bDUBpx0chNut+RcK/jaRYfpf+OwMrBk?=
 =?us-ascii?Q?N468SaYIRN1CilX4xtHnyxyIECrfmYY1Yxfppa4BWgMy9vOoVA2jknZaAGTg?=
 =?us-ascii?Q?jdzLFPaD11G7j5RN3bl1r7dfKQgajf/lWcwTEXPppQ9pL95YsQ9OPXy5CKH6?=
 =?us-ascii?Q?o6Ugrarb3Tt4e7yAal6YG3Hl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?am4vTqrmcbIPo7vprcyYah8F2o1yNTLKcmn/jTDIivTF7I0TBx+wL2Yk4JSH?=
 =?us-ascii?Q?zg5kslETvGHZl5qkQZoS6tF9dqY97vJD022ZxiVDqkDaxZNJ5wk1N7qX2PSk?=
 =?us-ascii?Q?a2irWjMvVLDtxtS0XbxLF8G6GFnzL9C3U7vi2kpb9MuX4Ly8LWsT4uVBhSpt?=
 =?us-ascii?Q?Rx8JAakfDBe3gYkR1z1+Be/AIFg9+P4Iq409M99Sx8R29ygh8dE55Rd+JyRD?=
 =?us-ascii?Q?dDamZEgQud89fVzZ0JVo4qjsZ2UGHjvDIZh73lP1aqTv8Efi5rK2PVJAr1pc?=
 =?us-ascii?Q?N5BrPmtPDHVpq41dTZ9W+7xQsKcAuBbTf4z45GXZRnibYdtL6LRaOvTkfveE?=
 =?us-ascii?Q?eIM0CohJaWtLQuWqsfc6azPg2nRABvsxi/bxyI66A3OUQifY9AMDqt3tXOA5?=
 =?us-ascii?Q?cg1rwyrinbT3SBt/0qrftckxNE0ZGp8jaZB0svTxcr5U8+/dwWR/KMeGTWRM?=
 =?us-ascii?Q?2KLutVD+b8e172sFSWRrEFyTlrg34uBGQDZDoR9NExTRav0ATobUg1LEBHUx?=
 =?us-ascii?Q?7SfSQ+NV/uSk5EBvIpoCKlt4hBrPowZC5e3LfqlHD2ViAqfYUIYA6obkoMDD?=
 =?us-ascii?Q?1Ag/8VJhi08EwvOLTsu8oULcLGMy8yONBRFWHdCT+yEBCqZi7NA9cLy4accB?=
 =?us-ascii?Q?j9/vRH3b10SNsXNlzyAduNQJhEN6OYDloX4sju/lF5xm+Kbu2Ufe1itao8kh?=
 =?us-ascii?Q?FnK+ICC401Q9Pyl9oSVKBQzPm50ETY0JzJwW19MyHoLtNm9EcoR9MpoG7exT?=
 =?us-ascii?Q?9DEC2E39q10VgA5VWN7QzhiVcf3rfosQ7jwuWaF4fAQRzVj76ma00S55iCgf?=
 =?us-ascii?Q?TLnWqJsqVzP3tb0NzDohy4uZ+4lJfjz6ttZAH+XkktZ/bZsMUKVLdQMNNanP?=
 =?us-ascii?Q?tLfgZ2NO73xTmt5disGtNeAwet9ThYVfCIa8AxbRDAc629oSEJzrSJS5cXOs?=
 =?us-ascii?Q?NCPIuJeYo/5y/K+cl2mjLdgMaUBTWdyWIfTIePjK0aYEDO1kOC68LEBfTOIe?=
 =?us-ascii?Q?APRmYsqnO3H1FlDegVUm1yc4OCLUQBQwqBYNXMcyU8KELC73EF7RCvt63ynE?=
 =?us-ascii?Q?wg8yyczKDUMCb5QTBLNx4re24CTdhSVcK+4LxF3B9vytOdV1c61PVQARVLEp?=
 =?us-ascii?Q?crC+JRRXJ8afIRrctUfwv3yv+3XDfM7s0EPZa3HeyrFl6Y0AJ9+F0t9orh+w?=
 =?us-ascii?Q?OyLwo10MAuGSJWzIbVEDDfEqjjDfwGnc5lS8VwRYt3eCj0cf6vyPvenlG1WN?=
 =?us-ascii?Q?SSCGgeyFkvm+uONdJ6AEUKIuAoaWn4sSQ/PHjnDAXElsi4B2Mk22322AllYS?=
 =?us-ascii?Q?kNIRZ8a4x3Erl4FhJbXEhHGH9gv2zo+gIjX+tX+v3X5GwUcmZLCDmK4EjPGw?=
 =?us-ascii?Q?jW3+BBHwt+ApBH8JBsuDxy59MzS9Un7Geo7nTYfOSjtKT25k+Ym7zMPstb9z?=
 =?us-ascii?Q?RWelTIH3j9n0WqSOruoVWGwtbKLoHdrMupaqE1d+9zUL0vMWPsgu3U6oSIXp?=
 =?us-ascii?Q?Rk0JNYXCiYUXfhmQzW9pFvmQ+ub/wJjjcM1PFhuvazt9xbKIUcyvXY6lWLbq?=
 =?us-ascii?Q?KzJDNjT5fFvEy43zvIFKLZk9bvnwJwu3NbBISId0XXOOJCWiz1fdhdMuv9e7?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f+Jw0eJomRoZlUD95dN6yvbMuPITGJWv+R3uCPXeR3h7OndqnuRJicW5soShlWKAZQqcYKNV49CTzV20+WWW5kaK2sz8wzzu0TLIkP5QX8xrg/y0byuO7NxwBPOtxoNMJYYdHwSz6+S1mPJZNaZCEI+bBC6Xig/85X+iMx7f+FAKnjwPNgO4wIsHt6by6FYaZIgs7czAUsbMA/lZx64PD459LtoSaa1M87T0YGXV8hAfogYj4U9dVZciFsmKFYtJqD5xnN5hqhSyXETXpEYvZJi/Z7xqBk5HkO7BhqdPqoGl21acsY+OYKiA9iRAgBLDblzIFYQpPD7W7l8S/wzulVFX5CicdaUj76rhz6OZvQOl6LHnDL1sdx4DxFcVdJBclnhMOmThWcAGU8oHf9HbnU8qL1BP/Ud7yiinhfT28rcFKmeZOJnSC3jrj+dSifTurmHWzw01WPPSu0L5kPCgFlWSu3j+rB3gvh8GKAoT3E/YHw/4cIWHbFa7Mj0wOHpxcHhLorYdTB2RGy3ECPJdl9CshLUREfsMgR3BQ1ahbQd9N+KrNnUYD/5VzdlceesZjMpr7GzRwVNoU+omWWZQJACYuNUWH2Ufeefq8/Tx6T0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01173618-d916-4be5-48d1-08dcf8d96d32
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 11:53:10.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxNo+LquE7BC/kk5nbvi0FgVjUFFoplzoSpu/S50ONvIimXCqjbg+vHgO/YiOY+nV0nCP+yJJZpFJ/IhgFCyIdZZp2FKLCKcYJRNevSxGiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_10,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300093
X-Proofpoint-GUID: 2wkMXGjZe-Lo7Dh0lEGrx1zJKXwBKxTS
X-Proofpoint-ORIG-GUID: 2wkMXGjZe-Lo7Dh0lEGrx1zJKXwBKxTS

On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
> On 10/30/24 11:58, Catalin Marinas wrote:
> > On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
> >> On 10/29/24 19:11, Lorenzo Stoakes wrote:
> >> > --- a/arch/arm64/include/asm/mman.h
> >> > +++ b/arch/arm64/include/asm/mman.h
> >> > @@ -6,6 +6,8 @@
> >> >
> >> >  #ifndef BUILD_VDSO
> >> >  #include <linux/compiler.h>
> >> > +#include <linux/fs.h>
> >> > +#include <linux/shmem_fs.h>
> >> >  #include <linux/types.h>
> >> >
> >> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >> > @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >> >  }
> >> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> >> >
> >> > -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> >> > +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> >> > +						   unsigned long flags)
> >> >  {
> >> >  	/*
> >> >  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
> >> >  	 * backed by tags-capable memory. The vm_flags may be overridden by a
> >> >  	 * filesystem supporting MTE (RAM-based).
> >>
> >> We should also eventually remove the last sentence or even replace it with
> >> its negation, or somebody might try reintroducing the pattern that won't
> >> work anymore (wasn't there such a hugetlbfs thing in -next?).
> >
> > I agree, we should update this comment as well though as a fix this
> > patch is fine for now.
> >
> > There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
> > should still work after the above change but we'd need to move it over
>
> I guess it will work after the above change, but not after 5/5?
>
> > here (and fix the comment at the same time). We'll probably do it around
> > -rc1 or maybe earlier once this fix hits mainline.
>
> I assume this will hopefully go to rc7.

To be clear - this is a CRITICAL fix that MUST land for 6.12. I'd be inclined to
try to get it to an earlier rc-.

>
> > I don't think we have
> > an equivalent of shmem_file() for hugetlbfs, we'll need to figure
> > something out.
>
> I've found is_file_hugepages(), could work? And while adding the hugetlbfs
> change here, the comment could be adjusted too, right?

Right but the MAP_HUGETLB should work to? Can we save such changes that
alter any kind of existing behaviour to later series?

As this is going to be backported (by me...!) and I don't want to risk
inadvertant changes.

>
> >
> >> >  	 */
> >> > -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> >> > +	if (system_supports_mte() &&
> >> > +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
> >> >  		return VM_MTE_ALLOWED;
> >> >
> >> >  	return 0;
> >> >  }
> >
> > This will conflict with the arm64 for-next/core tree as it's adding
> > a MAP_HUGETLB check. Trivial resolution though, Stephen will handle it.

Thanks!

> >
>

