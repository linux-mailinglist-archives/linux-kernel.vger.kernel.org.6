Return-Path: <linux-kernel+bounces-244310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C392A282
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C221C21290
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F07D06B;
	Mon,  8 Jul 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lXx8Ujfp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xAFfcdpI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640F3C08A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441286; cv=fail; b=EArME8HZOaC9apxX4/HixqpWHWzWFaT9oiYzXdUui79PDTw3emD6hck3LxPl7mp1oH9poEMMtBWxioVjncNj2tzKm450c8SCK0Q/MGBlMlcD3RBmnXd83jiUsrnHq6WObvvw5lx0u31FuYNHy2UleFgPiGaVdXUWFWnX//WvkNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441286; c=relaxed/simple;
	bh=baOBJmOFGvSq/HsyFZyQN3u5wbKkctRf2SU01kIXijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAkXvS22tqA3eWbfQ6qwdPVRga1S5QTR4xKjLP+TpTUEEzS25FXmwFEMJnE8cZSy7G+FUrZAHAFff/geXkjxjpaQ3x8mUKbWCHCbH8mx6vp+5qCX0Jc/9gnKXpDxJNfu4hAT4AlePQO5QAErP53qtpAf0AeFjoqjKQZqUubyFxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lXx8Ujfp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xAFfcdpI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fUPM004404;
	Mon, 8 Jul 2024 12:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=/5ehi6Nh0tc+9jy
	6u1JjcuVfvkFscZiO3Qi35yEQM1E=; b=lXx8UjfpFiX5WFcVsqU1AyAZZviey9y
	d49myZGfSutstl4Wh9ianMat6r8vP5HViQjueIszdS400HS7hceAgqj0U8RySdic
	X19mmGpA2PZOPzT2/dISIPBkn0Qh0aUlrz3kYIvl8LBbiQ9g7UxBLWS0bu2d1dE3
	1yxCOdHipw4yIdaHSoeMxxHA54aakaHT6zskwSDKeDMC9scX3bd4k7vC+Px5rRIB
	qJMkqIv2zxwLh+XGUbK8Owwm1fr7gH9w5xbT5y0MA9ruSvpCaLxSWmxNx/gs7JJI
	l1PxNSy9k6zE+RO36DQPzGghjDyZETLN2FRAx2ZDr6/CQOJ7Ho7Aq8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsjfys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:21:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BZwM1014242;
	Mon, 8 Jul 2024 12:21:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txfahfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvfJiirYsAoJAjB7m7RHMvhsIyy7Fo4M2mkHuo6KgMdE8pcD1i1y8/LZVavE0BTjWLxEPEQAyFpqRAKc0L/bfhp1vgqoUCaJ85CACvi/JYO8MP9mczdyKwOuy5VR2EZD8bPslF8WJjZx8U3WLEZ2UVGwnW+vMo1BPinpzUMFlomAJEwJsm8UdwGn/3rKInSop3OkWgtiDfEXFvMev+UUC9d42lVbnw7E3aB6g/nQxUYXy2UJ0DZYc+c6O3gjQtzl0QWiEiFPh9M23PzGyOqvINoIym04GdAXBKta5340BogpuXXnLikP0EFoE4PZ9Jj1ZQomhcU1R3Imj/SZKkBOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5ehi6Nh0tc+9jy6u1JjcuVfvkFscZiO3Qi35yEQM1E=;
 b=hTCbMKBqLSbUCOz3spxbtiYQuln75Uq1n9kM59kzVcdEJAhoGcSLrF+0JQAQ10jJEjDophaDJC5Bl+r8mfEFMZqX2I843EVFTKXlV3pbvakR5ubU55ukEujtpVmlLh9qhcxPx0E9vLL0mwJ1pRNwFUDayvYkHVUXszxO0m2XTtEebhIBuH037P+Y6SIYq8sZB695KYAJhVOFVM+1yyZd5yOKHdqIQCYzx70DANhJyYDcFl1BPMsXjcl2+OaVqNLScPlVEH7CQQ20kP6lqNOsuDsnfQ9KAjpGTl4hG1YJ8FPR/uqwir+fS5PFFZagMV44uTA/LXLgCfGGIkXTh5/Uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5ehi6Nh0tc+9jy6u1JjcuVfvkFscZiO3Qi35yEQM1E=;
 b=xAFfcdpIZWYP77z5k3V1QnB2u9Hpfw93UwHbtI1QS43Cg0dOQ/dOMVEXYUi5LcEYfpHuDycWAav4BE7lDj+n7LXAZPcRBZSYog1rkPA/9z2PyNl90HywzWy348l/d3l4/nRMfZkJMZQbnWr10H2pami7eXgCuAtV+L2f7jmm/zM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:21:06 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:21:06 +0000
Date: Mon, 8 Jul 2024 13:21:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 14/16] mm/mmap: Use PHYS_PFN in mmap_region()
Message-ID: <7a0350b3-ea23-42d4-b2f7-4680d761c969@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-15-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eea2ad5-d041-449b-7cf8-08dc9f4870fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9kloX7cFY9h/hA/+eFOQIGRO8624VHRJgzVDVaPHeqY5DMT1iWzQQbJMsrHk?=
 =?us-ascii?Q?HbD4dchzEuCb8JzSODu7+8eLsb9xRYbeTUHfRJNeBMcuuy8OnYvz3z3rYXJ7?=
 =?us-ascii?Q?cy9y9y77xnZJLNORZtFiJrEyNSoGOID/gZcfEjiNKrTnasV1RnDhZsxhge6C?=
 =?us-ascii?Q?EnLibNDBQSC0k4jpQifRdkvX2nnnqRHyCs+fu59nLyE6gtbKCA+x3qYSEfsj?=
 =?us-ascii?Q?cV3XKC3GK7lQ10Uw8ZUxC0+C07OFXDx1jvyuH1jb/7i/qNjM9sFiexo8RskO?=
 =?us-ascii?Q?fzgbcc6SreDkxHgLHVnhsELvbppt/V6s4B8IXP8MBN/SwQBQCm5/6FPyDT/s?=
 =?us-ascii?Q?bc5L4eK3yhWxTMMeRTneIXOa4kVmcKoJ7key7w9Sp+U1z2PqDan42jLRgSxz?=
 =?us-ascii?Q?4Xo3Up2d+YJ3RJHaFeWLA00Bj1xxmwsizZhzWYgdmuYat4667FYTIP5QsZOe?=
 =?us-ascii?Q?xmz0fj4LyrZoisnA74RO5k2RBYJ+MXn9tbJ/Q4Uqc1nUBYyqCUSotwR/QQBk?=
 =?us-ascii?Q?XXl1ZQKZxTtPbjdv4KeJIKRZM6mxZrkvRC0eFm5P5DOxnN4JsVmOBaI38+hj?=
 =?us-ascii?Q?q4khEEK1wTGLWVd0pi2Ho7PtgRjmuJ+dI/AAs5rd/QVL1GTpvNNK3sKVgLhf?=
 =?us-ascii?Q?MPu+LSEGPhVpjQZ2naPZZl4PCgEMjIY3SI2d+25SCVwHzNfBNegt+zRT3O2y?=
 =?us-ascii?Q?pT3Nh7WNTWPZGaeZmyIopubg3XXVLp9hHWeOKpU9JGWn1EbTwAa/ELNW0udA?=
 =?us-ascii?Q?HS0gxwlxensgig53pfCBJrTsVOK40gJehiRVaF7N0ySFHo7klhpXmQGN+pz4?=
 =?us-ascii?Q?nCTm+GGY+vj1T6MEj+vuWUkXG2TwDcqMg/WTqgrn+tsnf08JKzN1UkoYGg8m?=
 =?us-ascii?Q?1wn+8NfMhylzzGB9CILRI/OupnkRz5GdKH+Q2kdfxr0malLRZ5EhYyz8X9x0?=
 =?us-ascii?Q?u/xfFS2mNknS6AAfUF3FcvRHOtXN+L1rSepPwkA2cFkFGBviE1J7TGv8qk9a?=
 =?us-ascii?Q?yPMG8hS+QPDgvqglA+Tcmm97Z35AEUWTRaHCEC9v32zB13VII47TRFe0CTbh?=
 =?us-ascii?Q?PUgYP15DSsgtkX/E+4evh2ovuBbawL/71rjawWZdmzEb9eDPzKop5rRP9dLv?=
 =?us-ascii?Q?IIdflY7YdrEPSZepsTh4vvgWbft81jnVt0EvmQv3MfWvlKIDIMLEgy+8uuUy?=
 =?us-ascii?Q?I2vd8sf+sR+dht+cYH2du9kC6d+wBlRtsMs1qw7M9vJKHdDStOKSaDzKpGj/?=
 =?us-ascii?Q?2Knux3P5DwKvcoaYiWlaVMSaD/S6shqRBWHzHkqYTLRIHxvngtoWAcIH2fkw?=
 =?us-ascii?Q?EPXlUVYdNKvKHeUGGrSBGxYQIodxGMOF8Mruw4DLnQQ93Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TcJ8CYz6ow7THVMhGemqgiywOKET2SNYYdBwkOGA9PIzs1092x4EnAyT6K05?=
 =?us-ascii?Q?IZeUebT+X/BhmW8env/0sYfhc9W2uuq+xFS95x4DaNuly8SHbgqys1S723Gg?=
 =?us-ascii?Q?fDsD+IrOnZs/6OmXZfF9Yn0A8SfPhEQYm8BQA7QfRplx9LRrLwzEgoCD2tb2?=
 =?us-ascii?Q?DHt9p8HICAd+PZbeC0nfpRZnlBiXgolaqZBRQrP/xDsS55UBKEVQoxXNmw9y?=
 =?us-ascii?Q?LSURpPvrV1s5AMif6QC6K/3HryedG3LA0E4fqowJGwmH98ZKmrUe2n+jIwm3?=
 =?us-ascii?Q?ZEnNLxFXJVFEu6gwgwJl3ycAeZVOZjzdanmMdUK5/+NLbTLu0/H/j+vu8cbT?=
 =?us-ascii?Q?6BcuRlDuvmWQJz39tMCc7lozmuBwRV15IUJf/Np5matej9dAVSSqHAn+knia?=
 =?us-ascii?Q?ognG3r7ZuLYp9Z58I6JSvdkbeQ4nUoZI7MVq7qkhbUAE/6QMehBlf9v/5CnM?=
 =?us-ascii?Q?YVy3mrUnvdcioD+MEVxOPHJG0C2Y/0dtBNMeotUzPrSK+uzJV7d/9cYNo95G?=
 =?us-ascii?Q?ChG0T7tpMoICMn9wjBJ5zyjBNL9VUHkegbHvDPblVU48XgcLSH5L8RGv8HrC?=
 =?us-ascii?Q?Vvaq5zXYqpPd3TaVvfD2jyIDmGs0I3XNywyyWoSWxRvEviAxzzqris9fRR8B?=
 =?us-ascii?Q?WJCLwIs79D5KznzDyzkyuLJeQKNISRVctIRYH66iOCh+yAmvFVw9dlmOvIBZ?=
 =?us-ascii?Q?4K8Yn1osXCBzOw+7AnXyk+Z5J4kY/pnlqCW1mAki9I0NAKvwOea+zDbsVSSr?=
 =?us-ascii?Q?17NZ/GAypbl7GhKhK49kdMa2QWKA+BFPlmYhZz1p3NQyekDKfgVLizpNmeko?=
 =?us-ascii?Q?ZkR6a5BC33lsCpG6zhWmiS69WIyQQmci4OIKf+CSrZ1UUPiIsRQuMzcq1XYx?=
 =?us-ascii?Q?vp0zTZRimyOO0k6vrp5+mbT9MoPT1e2XZvRwFlXqHlLW+tsH8cHcHpkYm6Cq?=
 =?us-ascii?Q?GvqIr/xAJ/kJRc477H9vNjyNYRJ2/FRYgfLSDrqkVNPrv9Aqh7D2neXpxijC?=
 =?us-ascii?Q?xyP0WyweeabVtXJAAOiwPhTfyKRr5sTvqXGrr66N/YtOB3+KPbbdKYcJayJz?=
 =?us-ascii?Q?rlBTBJfYB4pJQGYtD5FyWILq+5u70Oc0QdRtL5AQkjbYe6M3Co0tf9i78BC8?=
 =?us-ascii?Q?RVhAeHYFTwyx/LMCigsXXGEpOG1e5aiKQHqpHCY6dTA7FQDoXFYYVXZr1JmU?=
 =?us-ascii?Q?g/2cSc+c4S7rQDzPHqlOPXJQ33H7CRoDQ/4Grng6Zsja3r1W3vyScPj6y8oS?=
 =?us-ascii?Q?4roXpA5i2goNpPaQXkOIwjKFfxUGT5xpG6Nkgl9UEy7Hu4ap67fwZVXsR5oM?=
 =?us-ascii?Q?RlsUSFtD+s3gspljhiofP9/dI/utTUe9zNaZfwbbc76mY1EL2bA80YQzUeKE?=
 =?us-ascii?Q?A8Z3RE8ToQvdXEj/pkKU1UaA916i+gDn4DU3l8SpSCsTJx1BwvBVlnpSY91t?=
 =?us-ascii?Q?hoPf8Uyv9kuxmW40+CsCMPha/jedZHV9esZ9GnEbxVsD3L/YelyNPo3DRGYN?=
 =?us-ascii?Q?GOA2GcVbwpM6uOHmV9qtFfX208IaS+/jHSmJOS8flKc0SYbe50yHrymeXq20?=
 =?us-ascii?Q?vw8Iesdg10+D/k2PJJdpQWiswc9nJMFiOhjIduoUSRgfH4M4leMUiuONyWKm?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vB/LJ4CsRvO7P/3x01WljNtsy8Jq/QvYkkIpIeGu1m7yM37FfrsAfj6quqvBfW2nQBKfs0fJjf/tsn9o7rB5LcIVVgif1cFtlO5EiZHPBhsiRQOuGjGfiYfVMHpNB2gtG/daBrB+LV3uraQiQOua15YCOgj6vlRZ3iUisY28UqYm4XDPoeivM9+Y77i6wEstPl4hlgXRum41bj6791dR7gnRZlAKs/kIBWbxcJNFhbi+de7H/6ucao1nAu0T1zhBtZ0sNiYTrihg46SbFZDRwgzu0Gu4idokQ7PiWQK4c0eu5M4Y5bWtG+MaeW6I9hF/QlwUaa/bG/T4RUBElOnNGWIji2vTmQZw6pS9Ti8jHsi5PEtsEPi7CxbRo/DecsNI+GEt6rXWaJO5JFoXpH82BVaQAurVLtCbE4ZdPq8fObmhUNk57HpK+ZcEsogTGLNugrxy1ZO/0n07iQ05DwEhunXO/zOCk7L+FdKz8MSIekerypbISRRWzNjXiyD27nDoqdghGjCOTPcqJq0aEhh0fvndqP1GMHelIwzlQ0t8QgBZJBzOA8OkhNibG2bsXWrM9TAQMwvdO3hEHqy/AwZ+HA9PQAn+tMB1bn7FKlPjxqU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eea2ad5-d041-449b-7cf8-08dc9f4870fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:21:06.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzscyg4QeUsCSc+13lBk/LkPAHB/XmZE7k38EwvStIc+fODMvLrCeke39dfoMTTfMSsrqRZ1jNyH5r5swD1bHFZAPP5pAv0scjCZ6QSGFYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_07,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080095
X-Proofpoint-ORIG-GUID: iDK_czWnIaEPq2ZYq0YUjJb0H_xLlCoc
X-Proofpoint-GUID: iDK_czWnIaEPq2ZYq0YUjJb0H_xLlCoc

On Thu, Jul 04, 2024 at 02:27:16PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
> existing local variable everywhere instead of some of the time.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0c334eeae8cd..b14da6bd257f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2935,7 +2935,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	struct vm_area_struct *next, *prev, *merge;
> -	pgoff_t pglen = len >> PAGE_SHIFT;
> +	pgoff_t pglen = PHYS_PFN(len);
>  	unsigned long charged = 0;
>  	struct vma_munmap_struct vms;
>  	struct ma_state mas_detach;
> @@ -2955,7 +2955,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * MAP_FIXED may remove pages of mappings that intersects with requested
>  	 * mapping. Account for the pages it would unmap.
>  	 */
> -	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> +	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
>  		return -ENOMEM;
>
>  	if (unlikely(!can_modify_mm(mm, addr, end)))
> @@ -2990,7 +2990,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * Private writable mapping: check memory availability
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
> -		charged = len >> PAGE_SHIFT;
> +		charged = pglen;
>  		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
>  			goto abort_munmap;
> @@ -3149,14 +3149,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	if (vms.nr_pages)
>  		vms_complete_munmap_vmas(&vms, &mas_detach);
>
> -	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> +	vm_stat_account(mm, vm_flags, pglen);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
>  					is_vm_hugetlb_page(vma) ||
>  					vma == get_gate_vma(current->mm))
>  			vm_flags_clear(vma, VM_LOCKED_MASK);
>  		else
> -			mm->locked_vm += (len >> PAGE_SHIFT);
> +			mm->locked_vm += pglen;
>  	}
>
>  	if (file)
> --
> 2.43.0
>

Maybe I should literally look ahead before making comments :)) thanks for
reading my mind and doing what I asked though! ;)

However I don't think you've fixed the duplication of PHYS_PFN(vm_end -
vm_start) in count_vma_pages_range() - still worth doing I think.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

