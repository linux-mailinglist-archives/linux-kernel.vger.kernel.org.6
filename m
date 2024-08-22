Return-Path: <linux-kernel+bounces-297891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66495BEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CEF1F25ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33EB1D1731;
	Thu, 22 Aug 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k6CpqPnD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yVQ0IEDa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4D1D2F40
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354828; cv=fail; b=RQ7h/VEiaZU3wl65Wtf22AehRtscGKpvErKP45pNfsqJS8YpS4yMABxx86sc4+vc/T+D1cs7HlzwbCfdZGQz1XMbb3R2r0TOgxm6M9bB58UUcuzENX4HPZXvpojKDHt6qB6QZlHWCEeNipMJinofcgD7Gn83+0rCDMplvgLOxwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354828; c=relaxed/simple;
	bh=C6W5URgnGrozEDlG5tbQEpmXloLQm4sgl+FoFDqf5bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6KgcOt9KbF6Cg0/9VUlJxGZKr6MGhb1gZNGwZpDcGY20Ti/C3nSnZilVFY7v/DbOpc9PIqeRhh6knOWxWvTEZYr1ORE5J1Z1DIKgWdFdVvcAGVMyAYhIF6U1DoOoEy7fRM1t0Jt8WDtHwRePusEfjwYZw3iJX6UjNZpwbous8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k6CpqPnD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yVQ0IEDa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMYVF000818;
	Thu, 22 Aug 2024 19:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Lq7kRWDy/JaP69JbRtRp7VUtMeb++6kHnahDgE9Gb+s=; b=
	k6CpqPnD8aSWktIcZ6TwZNm3udxyuEOGh+VUcTGWfCToMmHA8w7rT4WZ3v8TDIyb
	UBLs6wcNagqFCws8HhIpe/Y2h9H+RL0ZRnCunuGpuLsoghC/GJfFyF6ttzumxMeH
	n6rgmswEhQ+MY3cmuqQvipK0nYtCAt+6FH2iuqGy3xOvSH7f7uVrru5oif02qUsB
	JzYyJccq0CdBEEqOxfJKHNvOQroatfAhnosEV4QwjtVO1Ffd3WLkyl6KTCOXdcf6
	9B6kKorbGRMOHYbtqFxlvLrfOeSvRZ/cvfLg5dm6S/xP7PTcufrPONX2ddE8KyQH
	o3MOml8YGM9dYxSnTej5IA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gjwrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJOnU005646;
	Thu, 22 Aug 2024 19:26:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG4FSBgOOC96TlP4ZY2TaYtx8TvbwmppN7jCy1lp2wyuB6usjzs05fuMCDDbKH2toAIn/PGqp/OumPz3jIjbQD0d3O0uFDcAdStZwitIoxCCTW64+jmWEFpMJ4dGfEHd6SNbMdh206MZ1d9JF3DO8D4QR6Glbg6LDWKCDtzALg+VhTb2znFlQu/kU8b9bc5VFce7uR0TThpzheTTkz8xawAN+1MADOdmKWOe+Tx8Elvc5phToFIRMY0xA2MilYbYgGVyNjb3EbHBxLqsJDxKUJX639i7CdjnMJbDQLY+qI4hjM9HMe2PbuvBXvRZlPr7tbvN1WdodU7UmYZWOP/dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq7kRWDy/JaP69JbRtRp7VUtMeb++6kHnahDgE9Gb+s=;
 b=uUWdHQ9lY6D9buLCU0lQpTzpm3M38JUgPr3VNoeAx+YpDjxqlp6KjprWPLvLZtZIzfmhEe1c6uOG9M0jeRy7oY9fOHDdvp0b46GL+X8W73+0Ay+/agiPmznow8133Tz2ro61wkVeHJHdbJs4HEjX1ICdj1ZBRB3HSUftRCj4Tenr5XVyvUK9AqKo8P+a+9m/MVRPuOHJu/ZCvlldyuU2Kx1gU4+pbDAgn9UdZdqV6lgMoiLUhtWJ3BhnFdxbnAS+ichKuaxWTBsykXOujQQQ5waMQVG9VZIXmfasc00tjHqCRDolx42gK67+hyiowTqJG5Yx6W38mCxxb7x6JQIPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq7kRWDy/JaP69JbRtRp7VUtMeb++6kHnahDgE9Gb+s=;
 b=yVQ0IEDa1c2wt1248cjptMsTF7Rw+vjLFXFsKpL75cow7ddEsh+XSA2phTcsAVZWkt6f7TkAp5skfLAxMBcvf5giwQu4rok7GNPSyWCNiMoIO/fmrucC9bwid3D4MINfjFDLLl3j9IRTX0DcUOlQt4TtQ9Z67X2aj1s+RlUUxLU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:43 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:43 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 18/21] ipc/shm, mm: Drop do_vma_munmap()
Date: Thu, 22 Aug 2024 15:25:40 -0400
Message-ID: <20240822192543.3359552-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 912e77fb-540c-4d1d-99fa-08dcc2e05aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jk93jM7BbsHqigYiyMUBREvP2TNhUYzVLD3hN+6xM7hLpqDsr2IzEjJEbN1L?=
 =?us-ascii?Q?3aTEPsVvuDlUF7Ahi99y2dooPpDq7+CpLf3Lm4JxnVRDKhojIFCOjAR+s+v0?=
 =?us-ascii?Q?j2NA+DwQ0DFLaTQKFiGUGt6ge6bT/dQKAx5EJGd77GvqT/9FfsbVFufz3QMq?=
 =?us-ascii?Q?vLLaMqkgoLbi4L05yYwUs9WRUZTEtyE1q9vWuhGN/aJ+efPo0Tgod0rPqO82?=
 =?us-ascii?Q?17i7gznvvZLhbx5ivsMnWvpW05cOkmgHbnc+pstCebpe2OqyM3BNIQBk7O4r?=
 =?us-ascii?Q?SycEGjRTsLEWJRDwcoNxaz/nCvBSQiDlUrczfcHkjsPHy776VOanr6g5QBPp?=
 =?us-ascii?Q?vn1NaFhz2bEB0rhB7KPjXdsCqTuVrPSeFrUSzYX+VJgMzgjiyZS1O52q8Wam?=
 =?us-ascii?Q?TR06kffpGfj5QZWjWqm8kZvgc8LVzFwkbpRsnnEocQhtbKCDO55X8i90Ksct?=
 =?us-ascii?Q?BUVCWENaTWJdDiBNnie+Mh2Vb7xrUX0dxG6juj2JyGAyBZKnLa0HNFVm43Ew?=
 =?us-ascii?Q?19/KfrDJce+NfqmYEEbM1RB+ufMnn5V+/foSmAZfCZeUQGUbJ6SGxzf1/Byv?=
 =?us-ascii?Q?0iIqfy43C6kpGclxQmcxj3EjlU6gihuginy141s2wwmb1bzGdXjlzoqSsFAI?=
 =?us-ascii?Q?exf3mAh207/bGBrQPq3BjaTqe3y1seE6bb+1wqD/ty8CVXvhL8+EmCwEr+pG?=
 =?us-ascii?Q?A3V4wQeGBnbldhtgP64dzWqiLwJL9FRM5UAlAKfw8UQqaUCBVgx6/1y4TtwM?=
 =?us-ascii?Q?1d64F9aLflTtSwlZklXsqyD6WRu4DGwOMEqgwNapj7pWA/gh595ZFt1hu9Ky?=
 =?us-ascii?Q?vcO+mg0OcM1wGrEy3+qcsmAxvfRm5n/cWnKcJQLcEC85Aa9/i6J6dtsZuLak?=
 =?us-ascii?Q?wPnU3LKcQ0szfjXBiOsRGmbxGfEp+HOoc1OON5DPmqMwCykZcaH40Q4vw9Ap?=
 =?us-ascii?Q?hsRLXlRZrsoXCP+rG/sQXc8OW1vAzF0jJiOiOs8UKCuLfjWz7fRrJ2kKUoRN?=
 =?us-ascii?Q?YRkVrebJE+iKH5oZRJYAAKrSVkP9YUcIxkWrBBM73lPQzmtGbKAvaj5FPCDU?=
 =?us-ascii?Q?z9NKo19tc8pk3FOvFftm3x9+T9ndRWi7DoQjCBXnUJn0DGQJElbZXKvsJ6rZ?=
 =?us-ascii?Q?rrqdx7n+ZZ5WLu71kRpGclMNBKE0SQmgIqWAeeG1atYW7DZdnYCaSiyI6gV5?=
 =?us-ascii?Q?hjOA4nnGIqoLXLMVNiaeybwFu/GxGcVajnPoG5XEnOuVeK18bc6dOF3j8+m3?=
 =?us-ascii?Q?5bFkWzFNyc+kqGMyhq1NPQUPxuwV2BkHWPmBJnIFIvJJn1ca+LCA0nFhcAFR?=
 =?us-ascii?Q?BI3XgtkGKa6Rds2OxMb1MldohguUOqktvexNSnzU4Iei2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kynkB7Ree5EiqR/nCqaSEiv//0jODJS1MvLXBUFBXB9NODsbctMGF42XDH1p?=
 =?us-ascii?Q?IjnuGW5THlWwmAyPUrfONlfW34zeC7ZuOcQElXRsuqBCe2gM96sjY1whX8zr?=
 =?us-ascii?Q?Pk0dc5/zkad5xxqHFu3hTCmqlK5mv49PJ0Vf/T8z4tvklOFykyhOgw+LMS87?=
 =?us-ascii?Q?P8zZ/2RDvfsdemidwDaJDyMqYQZuelkzG6tRYlBE6o7PwJdAnANp2z1derCv?=
 =?us-ascii?Q?UhZNKKTgErk9pOp2g4y+eDGjR+fSUbczCnp+QfayMGuZ668TJe/nQlMMUPdZ?=
 =?us-ascii?Q?v7/RsUWKXuv4u9huKIxDzbEjpUNjL3PQ2rBpoa1SzPYZXxRS7YvEuHTO4eF6?=
 =?us-ascii?Q?1MN9XdIObHTvYzOmv+RdDfznphfWeONb0HPj0XDAgHNaPgGYgzhQQKuOBD2m?=
 =?us-ascii?Q?8+IeOPFwpzzNxzYrCfJY0ZRpyyyKkiFnxIlqb9dWwShST7TkIVkgjVMz0Jed?=
 =?us-ascii?Q?TDGrc4H0U3r7mpnjIWm037NsJYPfWAXfCU8u/PCTEqV+35K09lKS/x2RhdcD?=
 =?us-ascii?Q?VgbcfI+JRK6ENNh2QYc2rLWWgyUnxCcd3ULszNXmKzMMqve8E4jJEfDJbuMl?=
 =?us-ascii?Q?b20uHgN7uVKd2GeE870bqJZ9HQ1fX0p3yaevimea0/qTi3UwRIoqf1xRMrWV?=
 =?us-ascii?Q?ph75fMaq5QAzhng/RjkcmU5/5xAiMGh+sekxDbx19O34lUUtAdhoXtZ7mHmB?=
 =?us-ascii?Q?gYf+ycsXMZPyXhHe3xaEuxKaBZXwGXLpVr3Y1iESDsJL8aUKNx5MVhuF06g+?=
 =?us-ascii?Q?MrIIdy/b85J02DU+ZH3Gve93RzxBHOzGxIXaJyRmZhpw52Xil6nuCf3W7B6R?=
 =?us-ascii?Q?vgwdXsy+N8EsWFqpqWcjxTDyHkm5JoqpHHobjXplXB4Hpr8xmdpBlECzUSeU?=
 =?us-ascii?Q?ySXM/hPgmMlhz8UpCsaZl/bYIMEv1btr2M0IG7eQVj2sxvKtXmSFvWvauBWR?=
 =?us-ascii?Q?bSuh5i2iOk6Z7qcJXNC31/eJ/xnGCcSRLvfaJDHDpSnFPWd2z4f/QMOK4+4h?=
 =?us-ascii?Q?cZC5Z4bh42uhF9cKFXtcHBWVD5YtTCX30GuHzGE2xx/5bFfsHGh2Jl8YpC6J?=
 =?us-ascii?Q?QwEjIKbEUZ9+Y4TsfD/OD+hpzlCoxZKbWrYnjE36Wq8Ora8I5ctOTi53/MoP?=
 =?us-ascii?Q?Nh7lrX1h8gvQiWLblTxQYbVSsGIUddGM9yn4VOpB4aNO9gp/di0/W0HUwGw8?=
 =?us-ascii?Q?k0FChbAsKPmmXSf1s9boQ1kWEdb+E7ZsJL6/NuvWU6FGGCyOyPv0wsmj3kqO?=
 =?us-ascii?Q?iecGOI7rNt4mJAD7xmM6LJ9UDZcap12xmo0i4RyeMyENEjn+neW5+44vo7mL?=
 =?us-ascii?Q?c9ZPUJLu7WNbtcPJdlmZ7ZAXB+NCQ0tav5xpmzFu9KD5QskLC64qILHrk/31?=
 =?us-ascii?Q?WWsnEx8mxtHNYtNretcHu6jccRtzbxgEKWlFxob/z3Va/D2bDrZU6Fm86Vl3?=
 =?us-ascii?Q?dvcrVLRo4lVzzdbmWvOFMalKDR4cf4LN72u/P9nDS5IttM/zM7ZZodd+RS9z?=
 =?us-ascii?Q?ONe04obMe6a616r9EUWSNzaZF/fyt1oLxok9Iu4klmXbY6uf4yFFuiE0KFoK?=
 =?us-ascii?Q?FtEfqD2c+bzn7bS7abCc6/8JAFy6pQ2QQ5Ctn9A0eyQERSEvKVGq22/M8t1s?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EP9KscxNfeGRCNLd+Poc1wZzUFaME12Jzp2pCLD+d+oKZjEExIHSHXn2RglX9IFpaMkdm0J+JHnOt/OQgp6kWFIleqyA1c3+TpRYv0Q9U+39RIfw5yb3zb7Gu3q/03zojzQLRvubfU+mIb+8u04cgiYtc1TcFst2c0Hb0x50kacz2Le2Ahzan533VMP9PDq5LZy6U7ByV9Yl0LR3/JFLkQWgbTHOw1bAytYiANX+POXYtHjykmeB0M22KlaH+gnh+LWerbm+TJ8pO3YIqaMzXy2GbpGqOpJO+IcjzfkLjV3w1oa4GuQGhBnqVjX8N/JpkhRe8aBDombR/0BjvyNwENlP544dxl+vAyZmfkfKxwcGaWEiKvDDYMPiOB8SLcVn062PtOG1QYuQ7BZaEJVa+W5jZB+DVrvDzYBsYg5qxMf58dzJiWwZzCZ0hNlaOHtJpn3PdvwfiPzlrAH0KMVgvb3HRu0vSKQMvtqmWplPqGfDeSOYDwdBDLd6nopQnBE+cSpEvuUTt+/chXVFVBoVAjBZHVsa1FZ8g9UGD2V5keHnitilp7xtWwz3dIR31PCOPBB63yKFMgPv04uSObXGCOOV99eM7CjuLrLugOfPSOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912e77fb-540c-4d1d-99fa-08dcc2e05aee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:43.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3ifNBehNGlnfbd9s3Y4W5JgQIqLdc5TsoQUm4lqdBWNc6NZ+rAFH98+tOhlxXX/dhsvQqijpZbN2bSySbSL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: Heg3FD0VzmWVWVKfoCUx9ddUPeAg4YOd
X-Proofpoint-GUID: Heg3FD0VzmWVWVKfoCUx9ddUPeAg4YOd

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The do_vma_munmap() wrapper existed for callers that didn't have a vma
iterator and needed to check the vma mseal status prior to calling the
underlying munmap().  All callers now use a vma iterator and since the
mseal check has been moved to do_vmi_align_munmap() and the vmas are
aligned, this function can just be called instead.

do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
it is exported via the mm.h header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h |  6 +++---
 ipc/shm.c          |  8 ++++----
 mm/mmap.c          | 33 ++++++---------------------------
 mm/vma.c           | 12 ++++++------
 mm/vma.h           |  4 +---
 5 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b1eed30fdc06..6f1835e3b430 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3292,14 +3292,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
+int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
-extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..99564c870084 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file)) {
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 		}
 
 		vma = vma_next(&vmi);
diff --git a/mm/mmap.c b/mm/mmap.c
index aa4aa49f3b97..51ab0bdb856c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -169,11 +169,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() will drop the lock on success,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vmi_align_munmap() will drop the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
+					/* unlock = */ true))
 			goto out;
 
 		goto success_unlocked;
@@ -1478,9 +1479,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma->vm_file = get_file(file);
 		/*
 		 * call_mmap() may map PTE, so ensure there are no existing PTEs
-		 * call the vm_ops close function if one exists.
+		 * and call the vm_ops close function if one exists.
 		 */
-		vms_clean_up_area(&vms, &mas_detach, true);
+		vms_clean_up_area(&vms, &mas_detach);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1742,28 +1743,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-/*
- * do_vma_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator pointing at the vma
- * @vma: The first vma to be munmapped
- * @start: the start of the address to unmap
- * @end: The end of the address to unmap
- * @uf: The userfaultfd list_head
- * @unlock: Drop the lock on success
- *
- * unmaps a VMA mapping when the vma iterator is already in position.
- * Does not handle alignment.
- *
- * Return: 0 on success drops the lock of so directed, error on failure and will
- * still hold the lock.
- */
-int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
-}
-
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
  * @vmi: The vma iterator
diff --git a/mm/vma.c b/mm/vma.c
index 8dc60dcb6e8d..91b027eb9a38 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -658,8 +658,8 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 	 */
 	mas_set(mas_detach, 1);
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, vms->mm);
-	update_hiwater_rss(vms->mm);
+	tlb_gather_mmu(&tlb, vms->vma->vm_mm);
+	update_hiwater_rss(vms->vma->vm_mm);
 	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
 		   vms->vma_count, mm_wr_locked);
 
@@ -672,14 +672,14 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 }
 
 void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
 
 	if (!vms->nr_pages)
 		return;
 
-	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
+	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
 		if (vma->vm_ops && vma->vm_ops->close)
@@ -702,7 +702,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
-	mm = vms->mm;
+	mm = current->mm;
 	mm->map_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
@@ -770,7 +770,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    vms->mm->map_count >= sysctl_max_map_count)
+		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
diff --git a/mm/vma.h b/mm/vma.h
index f710812482a1..8ca32d7cb846 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -31,7 +31,6 @@ struct unlink_vma_file_batch {
  */
 struct vma_munmap_struct {
 	struct vma_iterator *vmi;
-	struct mm_struct *mm;
 	struct vm_area_struct *vma;     /* The first vma to munmap */
 	struct vm_area_struct *prev;    /* vma before the munmap area */
 	struct vm_area_struct *next;    /* vma after the munmap area */
@@ -113,7 +112,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
-	vms->mm = current->mm;
 	vms->vmi = vmi;
 	vms->vma = vma;
 	if (vma) {
@@ -140,7 +138,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
 void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked);
+		struct ma_state *mas_detach);
 
 /*
  * reattach_vmas() - Undo any munmap work and free resources
-- 
2.43.0


