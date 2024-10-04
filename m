Return-Path: <linux-kernel+bounces-350034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998398FEF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CA31C21C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C254213CFBD;
	Fri,  4 Oct 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GSKDOLWa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="akD+aXVE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795F1802E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031037; cv=fail; b=FLpdxEYXhLS5ui7S2yfJ5vDCQs20VKXJ8EipAiCJP9z34w61O2EEzPPZSFTDxxhmSX+VU9982xTfH/E4KB+IwXHV3uNmjcbzVp8qczl859NkHwgCLUMdDibtxXH7l+Avq40afe2mk0uMKx0ymQsfrwu/bSup4pWo6M5jfO3URcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031037; c=relaxed/simple;
	bh=FoBsFMjlmN9e47RqQyh1ZOrt0iDrS4jJ/au7rrLnNus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7p+UOjcuHCHANri7wmyeYgmIqhGJdvlWZSp+9M9h9ZZbdmaip8QykIL+ihWhngAdf3vChSFUicz/MJtLWN2xQkby0MHGI/IzWSYhoZY649laGkN4xaTCUCGDd1oQ/t6UHkHh9d4noFQ2E4KgMHnOGtzZRr4Gsv7UOUYc5aToeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GSKDOLWa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=akD+aXVE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tf7f020700;
	Fri, 4 Oct 2024 08:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ph7PDCWK3Z6zZPB
	y+uX/a5xPQT8MzeTpe8602kh2MUw=; b=GSKDOLWaiPL+dW3+lBi3vSg66959Tjz
	W8zMffAgvhW1Q0y61IQdChImX/kcUl3MOwoGohdQL3NWX90df6GVJAstXkCeLDNF
	XC3ddsxoftqznCnLGV0/CbRNyOQl7mmBs/idrdQKF+kuQ9KY4lKDze68SQLXsEQY
	Qw32iXbbaQDeXHe995CHpwXEzLcysUlQFuIp4yL3R09MQdnvHuAzf1Eq34wY7+0c
	KL6xw/VMP6ei56iAqt1aoMCLX+ZW/nYZcLqyUFTJjCQ5VHlfSZFeK0EsZ7fvQlEw
	NZ0gxJYDKrRu85hZfKw60daFNrCmvKMDDlRM3+hcDhTgPtgiqs9B3Pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204993qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 08:37:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4946fuAT026305;
	Fri, 4 Oct 2024 08:37:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422055g2s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 08:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWz3la8HRHzvfhypnpxPzcpxGwmowdlMourcwvVWcpAAv5x3cXfJQxEBgMvxg9+IbBSkqQAoTbidqvtDvVCMRSXxFGB89qq04mJKFqsMucJerAtH/Gw5wzNMOT39073lmVDVi/3U5o4lq/yAZIU8kufsg4Ckt9zfsv+V7f3eimEERxoRVdo3Hc8X4+wr8uBw+UvmBYm5NyoShwE1Mz4JPAjaQWVQ14IoWUPbqJCNJOJhCGD1W8gWRUdjQIEtu2gyTzB2CQoqBtgTKr7WIUUiwCZcfAtsVm9ZfgCmtgeqY0ocUvln4V8nq4RlV899lcBmWZ7NZYV63YCVqDLuqMLsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph7PDCWK3Z6zZPBy+uX/a5xPQT8MzeTpe8602kh2MUw=;
 b=MaYqgwAj/YuAdvUKRbxP1pPOG54o92cjP0d7btRSUyerkW5o0Oj7QFyv5WgsdhfIn6omm2P3mIalPfplqHG7eRFo0djRjPhy1hmJMhhGdIk/JW3FeaxbIFquVfmjmh5Pt50pHZWL313yLZz9rlHMcK2SHNPN4KzV2EHtQ/dq83ExWGRslCqhs1cSuJ6NGEO/3ef8XhplsqjzNvdSAbvposcQzn+UDSiooIlGRDVzJr/B6pNHFZJmSQwvy5MHGEQWq9fxz2H/WpiqeS/OiDujiz+E6GXXigWZADAd7TlGAI5MNduGM8gGIgKd/UE/kynzNPnlKWsSt383P228hYYdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph7PDCWK3Z6zZPBy+uX/a5xPQT8MzeTpe8602kh2MUw=;
 b=akD+aXVEqaqLowTKUZI7oCoFIqd19I3xys2q7JfF2RvVBPyn/WrSQlpAk4ziTnYmrxYW8nuDexDrciUKu8M2OczB+YlWLTBGYrd0GNzs+5v7KxFmQA3n33hbF9Qz+Yu9bSekdnA7y48zn5fUmP56h2bA+WsLyEptwYj9ZU37umU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 08:37:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 08:37:03 +0000
Date: Fri, 4 Oct 2024 09:36:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <11f5f830-fa8d-40d8-8648-d71767505597@lucifer.local>
References: <20241003170738.2870-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003170738.2870-1-spasswolf@web.de>
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0cfce5-d56b-43a8-b7ce-08dce44fb8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lcP/DsWwGcGuIlk56wK+rHqhZ8groaP4HGHr41f8o7My8+DtozH2I47FlsF?=
 =?us-ascii?Q?r8giP36URlxYYXgSKmN/gxyL6xaQdEX6W2MOQZKM7rx0DgQIbotmk+ROmOC8?=
 =?us-ascii?Q?LDkI5ncaCjtD/MZqkBrK7vWyCrLBAULGkqkfHIuw1XseaIqsOoEGPQRo6WFW?=
 =?us-ascii?Q?4vd03nEsf+ZmKxesv2pgkeEJUGOQgfx9G7vLP3b00PDQxlpkInZlIrzocWHL?=
 =?us-ascii?Q?Em9F9ncI+oqxhxw2xste1oo7DYLNENvdmtPkRu2VMAxnCTSztyzT5DFaYo01?=
 =?us-ascii?Q?jKAruZgTeY8Az381U/YzFueVONJB1N0hNjhUGsMCBQiEWWiRubeBGkuUguBd?=
 =?us-ascii?Q?z/x7P5Vz75On9VYYeLnQjxvzJRsxRyPPYgEtQE3lqt+tcu3N+WE46vCCSmWR?=
 =?us-ascii?Q?Ab9+T9Li/EfqrP8/JEJNbMfDuHf8Q9Wnpn+ilS32kbfhB4NQmPWvC8MQEQkl?=
 =?us-ascii?Q?/2bWKCz8J9uOiemDHw1bSX19oyvVoDy3kZach3g+4CXR1R/m89F4PyOTSHTr?=
 =?us-ascii?Q?aab1qwdYSoCgceCpAw3rD7igAoXVGDyUUvp9FtP3iRp7GNPLkeaP+DvtY54n?=
 =?us-ascii?Q?oP+hpP3tJtxDUz7iqm0jdjpNpYoQJ3VkEL71jfqda+xyzD+pF5Oc9lpywuYw?=
 =?us-ascii?Q?D5N6OtoDRBWmOkPgedrlDLOs8e9gevYG6kyn7QjjndAah9D1WhtchZ3L2xhL?=
 =?us-ascii?Q?oJHXZDOuG4xdj15Uv4W1gHFAWLfFSqxk9WSEFKh5LycXUIEHwzQ3TWxHSudA?=
 =?us-ascii?Q?/vvSxRZlKUlbVOqRL0rtg/2NLDVXnYxUUKsjtJaDU/H4vF/jIYzuZnCk6fzr?=
 =?us-ascii?Q?yOBN+gVsv/uIcySh1sbcDdXqT5cbw8I21RqFXSYOEPuv/B0ywgqlwnlZenMp?=
 =?us-ascii?Q?7Ojhh5bvjgYYx3KlvcKLLE6GlcYq5Phh71U/A3cKMvTvob5GtyLw4fMxfIs3?=
 =?us-ascii?Q?h/EHSTGStMeSQlqkq7CraZL/GmxQq/Y8o0yzV0SYFbcH2jkLzlJBvqbjr5I5?=
 =?us-ascii?Q?4HCid0gQ4J7C7XdBq3NNrouaSdhbdvkmlqc/RLyE3BPzmpBNYqjSvK+O8smI?=
 =?us-ascii?Q?im5jR07fJnqTMishWFgD1dTSDRrklZw4dMx6gWfXw+A3rKiUIlN+aKFmMWXA?=
 =?us-ascii?Q?HRo7JXucTrw1YYqLpwDqXwhD2cwR4yenUZrGf8ojurkjmeE2FQFBDbIWmFSy?=
 =?us-ascii?Q?MauYxW611spA+sqSBPJubx90ciko6vvx6Ns+4D2j+pmp/bvStdrRjfRESuzn?=
 =?us-ascii?Q?/3EOLo9dI/GWHFopETQzwHmp2w/qhdWTYg515elVBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJdZtcPHDuFOD4SaUlN8p8CpQ+kuLL8G+e3pXcLMX6eOwWvn+DbOUTKwfhMJ?=
 =?us-ascii?Q?8Fi/QapS5ZhtNnTA4Z4rUtvJDFr+lCBJIbPfp+LnJ5wnvtMcugaSfv8Pn85S?=
 =?us-ascii?Q?CbixE5MgG86IHPTt/p2r2Qoh8ETJrzjG/MziF3zSAKZi6ar3P8CRHN7JIAMt?=
 =?us-ascii?Q?o5hyfrhtc9Fi6BHVHY9THISDDj1V3TjtoAvKJd3sLIzRmyQD8ihqiq7FW06u?=
 =?us-ascii?Q?iZCMGRCMV6ZYAPVszOUr3pECSdNyJyVyvr0ua7g2/8l733oIA/1g+qETV6lg?=
 =?us-ascii?Q?3TVpw/+PHTo0pwxaX2H63ov1tlnE6qijhW0lxg+nNsAMUy40Z1PSSnZ4/ITp?=
 =?us-ascii?Q?O4ePsHKnC67lkIOWOnfAX8jo9y6eccj+lNOosu7SchTvEVRWn9csS/BgPeMs?=
 =?us-ascii?Q?GgrBI9zENyN4BPfQstuGDDAbCVwleQW65X5itLqtXmCYv7500aGzccWyD/EP?=
 =?us-ascii?Q?emIqJC/NrqQoz4xg9yfIdXrNzb8soc2XluzXnpO8gQWakWUZR8KqPBRPgZmX?=
 =?us-ascii?Q?aCeaT1Ap4sAY0nPjQt9c/NPENs1+bVhj1xo2099uP+IXFRZxuWrJGGbmg+n5?=
 =?us-ascii?Q?7ozqZ9WkHmuNzooOvQAPfM26fluLfHb5pTWDqmOlyKpDCztsEb1QQQIYkWmm?=
 =?us-ascii?Q?vg8JLOmVmXdYVUads0ePo7f2zNjmSzGzuJaf00o7qBS9gfULAe9jY+yi4QGl?=
 =?us-ascii?Q?mfVmFrQDGtgJoVS7/H8Ub2jWbEUEDSIUVjmTEC9lBTnrQXI3gUws+wrsxhTS?=
 =?us-ascii?Q?m4S0zPhEdT4pZ5Hn40yb1wLpEQFRCspnNLCXVv+ICdqqQkjUQ86wAh94+/ws?=
 =?us-ascii?Q?qGIvKDsdNnft2PUjn8yRG1sH8S9DRX31gkYbM1j2OGbgXJ9z3dG2ytwr2QaP?=
 =?us-ascii?Q?TB/IWLy/zhrzpTSe5xByJkecjKUFc3QT1d6Jint/yz3OAq4oBi5C0gA9sd0t?=
 =?us-ascii?Q?q4GZjtG5zlwdPDUp1gZl5poF1+cADzdCqyC8LYPuBtX6ZZU7bbQyyDmIb7pT?=
 =?us-ascii?Q?lPgxWmYoyAdhE3zwzg7dqLoL9qv3ON1ctzb120hkPDnm3hKZxDvVmPTPcbrY?=
 =?us-ascii?Q?lzfxRnfSYyT0tkiBKrsAGOfTYb7Sx+qYbEOsuZeW9mFKNuI3kOetB+77/rW2?=
 =?us-ascii?Q?Ii2eL2HdOuchgO32p0FwBJjYMOekw1ncLeu2IKZEIHR6PJ/ynB1pHmwnZeDt?=
 =?us-ascii?Q?/+CMmKp8Bnx5vosaL4yK3ZfJQ8UNZ6WNHSZ7VAGoS+zV+1K1Rwf6qO6jsvpn?=
 =?us-ascii?Q?2kDzmkyX5U3TfLDosgctKrclEMX0rOU8/XDHTJ/j3YS0Tzdq/1m3lpJ7XG9M?=
 =?us-ascii?Q?JKHX9/znaH0CfwNo/zHEUC20zpl7XpnKuXW2IGbTqGLQ3N7DcsGPy+a1XQxO?=
 =?us-ascii?Q?yp3GEmLCgqt5wLXOjekz10pPHHp9sBbR4XGda6HwFGHMM0I5Tht/iM9YRsCs?=
 =?us-ascii?Q?veCP5Z13RTwZS/1ZfqmBrlq6UR90SWTpsUFGzYdgZz6CQXcNjrSmatQBI1V2?=
 =?us-ascii?Q?VEXsSh1QDn2aY+4dHFHQN2G5DPVm0ffrAUdDOuQbhYDopW6HwJw+hf4Rapo3?=
 =?us-ascii?Q?EJAAZiJylZNO0VpZ0MkBbKXpcrPWbAF3XeCnEcg6Hx7YS7FrZGyi8dCSDpDy?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ib+ie2DDsvz+NkosF80EAWpu68ScJoPmv0G4FDgpnwcjhKbmVj3HUYGh3750O/8Rv1BImn+pk6PjTCxcjWmZT6KbZt0NXd9D98YVLjcjNRrT78/E1evWokp8O9thrsc42HaHs/2vtBh8jXxs0wxMPSubrMp3os8ftITmQ1tebn5QDyI1ecJNjo62+KWjO9zO5NxDJmJRdh9DUdzEPZ6is0CFozmHIaAF4o9AN2+D2USFp0r+aJjAoB4ELKNemsDVcHCI5e0+cATIM7C6MJN4omukm8+9C/BXgUYVP+W7I4plbnxdU9gZsMawQChuBVZNIrH0NRJTje47iWz/2JXK8zE/RSeZbMnbSmP2Wd4HULHti1axcTkpP6Ht/0VZGG4eqSyAe0+zeNVUxfBk9nb6X9pTzCJ1rg+T8QEX+8M3opxUz7r5MeUKTsWPJp5Uh8F/a6ONTwFUQcHtDknwWd9jQ0yObxMmlNl5ZiQw09uWjZeZP7lpdEGWQp0klxSjUZnxiiVkINAxsNhDSyC8odd0HuYiUe6lD7CBau3M0PkmacnNtNXTsWyRBqy9mA5dc9oKr1kN4TF8k+PgBD+j5Zr8prAHCmZM3tV2iActDhSNrp8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0cfce5-d56b-43a8-b7ce-08dce44fb8ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 08:37:03.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuiOnzdJRm+gI+s/Dpi1V2CLzvd97aqFhGhsOjdL5U9dRxT6i4QPPQOziJ/MhEtEKEV9h/6LlRuzFw9RJD5EzAQQYM9hCKJ/bEEklzUNrok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040061
X-Proofpoint-ORIG-GUID: NscghURbwEzCZ5PJww0S9cz9rQA07cDW
X-Proofpoint-GUID: NscghURbwEzCZ5PJww0S9cz9rQA07cDW

Hey Bert,

Sorry to bother you again, but would it be possible to try the v5 patch
below?

This one should eliminate the need for you to set the no_hash_pointers
cmdline setting.

Sadly it seems I can't fully recreate the tree or confirm it without
disabling this hashing.

Thanks, as usual all of your help is much appreciated!

Best, Lorenzo

----8<----
From f7d1f54ffd166a52b2ae0ce94c99259aefd80521 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 3 Oct 2024 14:19:17 +0100
Subject: [PATCH] hack: set of info stuff v5

Try to dump the maple tree immediately prior to it exploding so we can see
how things are before/after + try to reconstruct.

Also do not hash pointers in tree dump...
---
 lib/maple_tree.c | 74 ++++++++++++++++++-------------------
 mm/internal.h    | 15 ++++++++
 mm/mmap.c        | 95 +++++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.c         | 51 ++++++++++++++++++++++++--
 4 files changed, 194 insertions(+), 41 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..0b7064ee8f39 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7119,14 +7119,14 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
 	mt_dump_range(min, max, depth, format);

 	if (xa_is_value(entry))
-		pr_cont("value %ld (0x%lx) [%p]\n", xa_to_value(entry),
+		pr_cont("value %ld (0x%lx) [%px]\n", xa_to_value(entry),
 				xa_to_value(entry), entry);
 	else if (xa_is_zero(entry))
 		pr_cont("zero (%ld)\n", xa_to_internal(entry));
 	else if (mt_is_reserved(entry))
-		pr_cont("UNKNOWN ENTRY (%p)\n", entry);
+		pr_cont("UNKNOWN ENTRY (%px)\n", entry);
 	else
-		pr_cont("%p\n", entry);
+		pr_cont("%px\n", entry);
 }

 static void mt_dump_range64(const struct maple_tree *mt, void *entry,
@@ -7142,13 +7142,13 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++) {
 		switch(format) {
 		case mt_dump_hex:
-			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			pr_cont("%px %lX ", node->slot[i], node->pivot[i]);
 			break;
 		case mt_dump_dec:
-			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+			pr_cont("%px %lu ", node->slot[i], node->pivot[i]);
 		}
 	}
-	pr_cont("%p\n", node->slot[i]);
+	pr_cont("%px\n", node->slot[i]);
 	for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
 		unsigned long last = max;

@@ -7170,11 +7170,11 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 		if (last > max) {
 			switch(format) {
 			case mt_dump_hex:
-				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
+				pr_err("node %px last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
 				break;
 			case mt_dump_dec:
-				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				pr_err("node %px last (%lu) > max (%lu) at pivot %d!\n",
 					node, last, max, i);
 			}
 		}
@@ -7204,13 +7204,13 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++) {
 		switch (format) {
 		case mt_dump_hex:
-			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			pr_cont("%px %lX ", node->slot[i], node->pivot[i]);
 			break;
 		case mt_dump_dec:
-			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+			pr_cont("%px %lu ", node->slot[i], node->pivot[i]);
 		}
 	}
-	pr_cont("%p\n", node->slot[i]);
+	pr_cont("%px\n", node->slot[i]);
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
 		unsigned long last = max;

@@ -7229,11 +7229,11 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		if (last > max) {
 			switch(format) {
 			case mt_dump_hex:
-				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
+				pr_err("node %px last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
 				break;
 			case mt_dump_dec:
-				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				pr_err("node %px last (%lu) > max (%lu) at pivot %d!\n",
 					node, last, max, i);
 			}
 		}
@@ -7251,7 +7251,7 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,

 	mt_dump_range(min, max, depth, format);

-	pr_cont("node %p depth %d type %d parent %p", node, depth, type,
+	pr_cont("node %px depth %d type %d parent %px", node, depth, type,
 			node ? node->parent : NULL);
 	switch (type) {
 	case maple_dense:
@@ -7280,7 +7280,7 @@ void mt_dump(const struct maple_tree *mt, enum mt_dump_format format)
 {
 	void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));

-	pr_info("maple_tree(%p) flags %X, height %u root %p\n",
+	pr_info("maple_tree(%px) flags %X, height %u root %px\n",
 		 mt, mt->ma_flags, mt_height(mt), entry);
 	if (!xa_is_node(entry))
 		mt_dump_entry(entry, 0, 0, 0, format);
@@ -7332,7 +7332,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 			MT_BUG_ON(mas->tree, !entry);

 			if (gap > p_end - p_start + 1) {
-				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
+				pr_err("%px[%u] %lu >= %lu - %lu + 1 (%lu)\n",
 				       mas_mn(mas), i, gap, p_end, p_start,
 				       p_end - p_start + 1);
 				MT_BUG_ON(mas->tree, gap > p_end - p_start + 1);
@@ -7352,19 +7352,19 @@ static void mas_validate_gaps(struct ma_state *mas)
 		MT_BUG_ON(mas->tree, !gaps);
 		offset = ma_meta_gap(node);
 		if (offset > i) {
-			pr_err("gap offset %p[%u] is invalid\n", node, offset);
+			pr_err("gap offset %px[%u] is invalid\n", node, offset);
 			MT_BUG_ON(mas->tree, 1);
 		}

 		if (gaps[offset] != max_gap) {
-			pr_err("gap %p[%u] is not the largest gap %lu\n",
+			pr_err("gap %px[%u] is not the largest gap %lu\n",
 			       node, offset, max_gap);
 			MT_BUG_ON(mas->tree, 1);
 		}

 		for (i++ ; i < mt_slot_count(mte); i++) {
 			if (gaps[i] != 0) {
-				pr_err("gap %p[%u] beyond node limit != 0\n",
+				pr_err("gap %px[%u] beyond node limit != 0\n",
 				       node, i);
 				MT_BUG_ON(mas->tree, 1);
 			}
@@ -7378,7 +7378,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 	p_mn = mte_parent(mte);
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
 	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
-		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
+		pr_err("gap %px[%u] != %lu\n", p_mn, p_slot, max_gap);
 		mt_dump(mas->tree, mt_dump_hex);
 		MT_BUG_ON(mas->tree, 1);
 	}
@@ -7408,11 +7408,11 @@ static void mas_validate_parent_slot(struct ma_state *mas)
 		node = mas_slot(mas, slots, i);
 		if (i == p_slot) {
 			if (node != mas->node)
-				pr_err("parent %p[%u] does not have %p\n",
+				pr_err("parent %px[%u] does not have %px\n",
 					parent, i, mas_mn(mas));
 			MT_BUG_ON(mas->tree, node != mas->node);
 		} else if (node == mas->node) {
-			pr_err("Invalid child %p at parent %p[%u] p_slot %u\n",
+			pr_err("Invalid child %px at parent %px[%u] p_slot %u\n",
 			       mas_mn(mas), parent, i, p_slot);
 			MT_BUG_ON(mas->tree, node == mas->node);
 		}
@@ -7434,20 +7434,20 @@ static void mas_validate_child_slot(struct ma_state *mas)
 		child = mas_slot(mas, slots, i);

 		if (!child) {
-			pr_err("Non-leaf node lacks child at %p[%u]\n",
+			pr_err("Non-leaf node lacks child at %px[%u]\n",
 			       mas_mn(mas), i);
 			MT_BUG_ON(mas->tree, 1);
 		}

 		if (mte_parent_slot(child) != i) {
-			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
+			pr_err("Slot error at %px[%u]: child %px has pslot %u\n",
 			       mas_mn(mas), i, mte_to_node(child),
 			       mte_parent_slot(child));
 			MT_BUG_ON(mas->tree, 1);
 		}

 		if (mte_parent(child) != mte_to_node(mas->node)) {
-			pr_err("child %p has parent %p not %p\n",
+			pr_err("child %px has parent %px not %px\n",
 			       mte_to_node(child), mte_parent(child),
 			       mte_to_node(mas->node));
 			MT_BUG_ON(mas->tree, 1);
@@ -7477,24 +7477,24 @@ static void mas_validate_limits(struct ma_state *mas)
 		piv = mas_safe_pivot(mas, pivots, i, type);

 		if (!piv && (i != 0)) {
-			pr_err("Missing node limit pivot at %p[%u]",
+			pr_err("Missing node limit pivot at %px[%u]",
 			       mas_mn(mas), i);
 			MAS_WARN_ON(mas, 1);
 		}

 		if (prev_piv > piv) {
-			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
+			pr_err("%px[%u] piv %lu < prev_piv %lu\n",
 				mas_mn(mas), i, piv, prev_piv);
 			MAS_WARN_ON(mas, piv < prev_piv);
 		}

 		if (piv < mas->min) {
-			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
+			pr_err("%px[%u] %lu < %lu\n", mas_mn(mas), i,
 				piv, mas->min);
 			MAS_WARN_ON(mas, piv < mas->min);
 		}
 		if (piv > mas->max) {
-			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
+			pr_err("%px[%u] %lu > %lu\n", mas_mn(mas), i,
 				piv, mas->max);
 			MAS_WARN_ON(mas, piv > mas->max);
 		}
@@ -7504,7 +7504,7 @@ static void mas_validate_limits(struct ma_state *mas)
 	}

 	if (mas_data_end(mas) != i) {
-		pr_err("node%p: data_end %u != the last slot offset %u\n",
+		pr_err("node%px: data_end %u != the last slot offset %u\n",
 		       mas_mn(mas), mas_data_end(mas), i);
 		MT_BUG_ON(mas->tree, 1);
 	}
@@ -7513,7 +7513,7 @@ static void mas_validate_limits(struct ma_state *mas)
 		void *entry = mas_slot(mas, slots, i);

 		if (entry && (i != mt_slots[type] - 1)) {
-			pr_err("%p[%u] should not have entry %p\n", mas_mn(mas),
+			pr_err("%px[%u] should not have entry %px\n", mas_mn(mas),
 			       i, entry);
 			MT_BUG_ON(mas->tree, entry != NULL);
 		}
@@ -7524,7 +7524,7 @@ static void mas_validate_limits(struct ma_state *mas)
 			if (!piv)
 				continue;

-			pr_err("%p[%u] should not have piv %lu\n",
+			pr_err("%px[%u] should not have piv %lu\n",
 			       mas_mn(mas), i, piv);
 			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
 		}
@@ -7549,7 +7549,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 	do {
 		entry = mas_slot(&mas, slots, offset);
 		if (!last && !entry) {
-			pr_err("Sequential nulls end at %p[%u]\n",
+			pr_err("Sequential nulls end at %px[%u]\n",
 				mas_mn(&mas), offset);
 		}
 		MT_BUG_ON(mt, !last && !entry);
@@ -7591,7 +7591,7 @@ void mt_validate(struct maple_tree *mt)
 		end = mas_data_end(&mas);
 		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
 				(mas.max != ULONG_MAX))) {
-			pr_err("Invalid size %u of %p\n", end, mas_mn(&mas));
+			pr_err("Invalid size %u of %px\n", end, mas_mn(&mas));
 		}

 		mas_validate_parent_slot(&mas);
@@ -7607,7 +7607,7 @@ EXPORT_SYMBOL_GPL(mt_validate);

 void mas_dump(const struct ma_state *mas)
 {
-	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
+	pr_err("MAS: tree=%px enode=%px ", mas->tree, mas->node);
 	switch (mas->status) {
 	case ma_active:
 		pr_err("(ma_active)");
@@ -7671,7 +7671,7 @@ void mas_dump(const struct ma_state *mas)

 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
-	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
+	pr_err("     min=%lx max=%lx alloc=%px, depth=%u, flags=%x\n",
 	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
 	if (mas->index > mas->last)
 		pr_err("Check index & last\n");
@@ -7680,7 +7680,7 @@ EXPORT_SYMBOL_GPL(mas_dump);

 void mas_wr_dump(const struct ma_wr_state *wr_mas)
 {
-	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
+	pr_err("WR_MAS: node=%px r_min=%lx r_max=%lx\n",
 	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
 	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
 	       wr_mas->type, wr_mas->offset_end, wr_mas->mas->end,
diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..cd9414b4651d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */

+static inline bool check_interesting(unsigned long start, unsigned long end)
+{
+	const unsigned long interesting_start = 0x1740000;
+	/* Include off-by-one on purpose.*/
+	const unsigned long interesting_end = 0x68000000 + 1;
+
+	/*  interesting_start            interesting_end
+	 *          |--------------------------|
+	 *           ============================> end
+	 *        <=============================   start
+	 */
+	return end > interesting_start && /* after or overlaps... */
+		start < interesting_end;  /* ...overlaps. */
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..8c5af1644a9b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }

+static void ljs_dump(struct mm_struct *mm,
+		     unsigned long addr, unsigned long len,
+		     vm_flags_t vm_flags, bool is_unmap)
+{
+	if (!check_interesting(addr, addr + len))
+		return;
+
+	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
+	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
+		vm_flags);
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, len, 0, true);
+
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

@@ -1375,11 +1389,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

+	ljs_dump(mm, addr, len, vm_flags, false);
+
 	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: mm=%p About to do unmaps for vms=[%lx, %lx), addr=%lx, end=%lx\n", mm, addr, addr + len, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
@@ -1390,6 +1409,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
+
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: prev=[%lx, %lx), next=[%lx, %lx)\n",
+			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_end : 0,
+			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_end : 0);
+
 		vma = NULL;
 	} else {
 		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
@@ -1413,9 +1438,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}

+	if (check_interesting(addr, addr + len)) {
+		char *special = vm_flags & VM_SPECIAL ? "special" : "";
+		char *has_file = file ? "file-backed" : "";
+
+		pr_err("LJS: Interesting [%lx, %lx) flags=%lu, special=[%s] file=[%s] addr=%lx end=%lx\n",
+		       addr, addr+len, vm_flags, special, has_file,
+		       vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
+	if (addr == 0x1b90000 && addr + len == 0x1bae000 && vm_flags == 2097264) {
+		pr_err("LJS: PRE NUCLEAR ============================>");
+
+		mt_dump(vmi.mas.tree, mt_dump_hex);
+
+		pr_err("LJS:/PRE NUCLEAR <============================");
+	}
+
 	vma = vma_merge_new_range(&vmg);
-	if (vma)
+	if (vma) {
+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: Merged to [%lx, %lx), addr=%lx, end=%lx\n",
+			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
+			       vma_iter_end(&vmi));
+
+			mt_validate(&mm->mm_mt);
+
+			pr_err("LJS: Post-validate.\n");
+		}
+
 		goto expanded;
+	} else if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
+		       addr, addr + len);
+	}
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1441,6 +1500,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;

+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=%lu new_flags=%lu new range=[%lx, %lx) [CHANGED=%s]\n",
+			       addr, end, vm_flags, vma->vm_flags, vma->vm_start, vma->vm_end,
+			       vm_flags != vma->vm_flags ? "YES" : "NO");
+		}
+
 		if (vma_is_shared_maywrite(vma)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
@@ -1467,6 +1532,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

+			if (check_interesting(addr, addr + len))
+				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s\n",
+				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
+				       merge ? "merged" : "");
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1511,9 +1581,22 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
+
+	if (check_interesting(addr, addr + len))
+		pr_err("LJS: mm=%p: iter store addr=%lx, end=%lx, vma=[%lx, %lx)\n",
+		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vma->vm_end);
+
 	mm->map_count++;
 	vma_link_file(vma);

+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
@@ -1530,6 +1613,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	perf_event_mmap(vma);

 	/* Unmap any existing mapping in the area */
+
+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	vms_complete_munmap_vmas(&vms, &mas_detach);

 	vm_stat_account(mm, vm_flags, pglen);
@@ -1594,6 +1685,8 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, start + len, 0, true);
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..729575903fb1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -605,8 +605,15 @@ static int commit_merge(struct vma_merge_struct *vmg,
 	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
 	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);

-	if (expanded)
+	if (expanded) {
+		if (check_interesting(vmg->start, vmg->end)) {
+			pr_err("LJS: mm=%p expanding to [%lx, %lx) addr=%lx end=%lx\n",
+			       vmg->mm, vmg->start, vmg->end,
+			       vma_iter_addr(vmg->vmi), vma_iter_end(vmg->vmi));
+		}
+
 		vma_iter_store(vmg->vmi, vmg->vma);
+	}

 	if (adj_start) {
 		adjust->vm_start += adj_start;
@@ -956,6 +963,12 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
 	}

+	if (check_interesting(start, end)) {
+		pr_err("LJS: mm=%p About to merge [%lx, %lx) to range [%lx, %lx), addr=%lx end=%lx\n",
+		       vmg->mm, start, end, vmg->start, vmg->end,
+		       vma_iter_addr(vmg->vmi), vma_iter_end(vmg->vmi));
+	}
+
 	/*
 	 * Now try to expand adjacent VMA(s). This takes care of removing the
 	 * following VMA if we have VMAs on both sides.
@@ -1108,8 +1121,13 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
+		if (vma->vm_ops && vma->vm_ops->close) {
+			if (check_interesting(vma->vm_start, vma->vm_end))
+				pr_err("LJS: mm=%p Closing [%lx, %lx)\n",
+				       vma->vm_mm, vma->vm_start, vma->vm_end);
+
 			vma->vm_ops->close(vma);
+		}
 	vms->closed_vm_ops = true;
 }

@@ -1179,6 +1197,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *next = NULL;
 	int error;

+	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+		pr_err("LJS2 vms->start=%lx, vms->vma->vm_start=%lx\n",
+		       vms->start, vms->vma->vm_start);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 * Does it split the first one?
@@ -1202,6 +1224,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       vms->vma->vm_start, vms->vma->vm_end);
+
 		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
@@ -1217,12 +1244,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	for_each_vma_range(*(vms->vmi), next, vms->end) {
 		long nrpages;

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) UNMAP [%lx, %lx) file=[%s]\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       next->vm_start, next->vm_end,
+			       vms->vma->vm_file ? "file-backed" : "");
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
+
+			if (check_interesting(next->vm_start, next->vm_end))
+				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
+				       next->vm_mm, vms->start, vms->end,
+				       next->vm_start, next->vm_end);
+
 			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
@@ -1295,9 +1334,15 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 #endif

-	while (vma_iter_addr(vms->vmi) > vms->start)
+	while (vma_iter_addr(vms->vmi) > vms->start) {
 		vma_iter_prev_range(vms->vmi);

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS3: addr=%lx, end=%lx, vms->start=%lx\n",
+			       vma_iter_addr(vms->vmi),
+			       vma_iter_end(vms->vmi), vms->start);
+	}
+
 	vms->clear_ptes = true;
 	return 0;

--
2.46.2

