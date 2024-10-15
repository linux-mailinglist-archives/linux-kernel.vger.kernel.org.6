Return-Path: <linux-kernel+bounces-366599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EE99F795
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42711C21440
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BC1F5836;
	Tue, 15 Oct 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rt3a96tN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VzWBRRoT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECB41B6CFE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022226; cv=fail; b=k+Eo+ZdRSBHSdswJ2AWijO6Rw1wH7TvKOK6otWDAVLgLaoFPgCTTP0d36qJbPvcvw99dfVhyi7pAXwfHI3NcCQPGtjAkjY87IM05hdMKc9WXmt3VXhDgKFRsmBomjrnVADvF28wbzEw3guR+gqqfTKUCTz4485LbntqUtR7ZpjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022226; c=relaxed/simple;
	bh=dVhTK6NrLVsVm6NGFosgiA+aPyCqGTJVxJlcwrZ7k2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s+CK5KOkMSCqtHkAuh0iLBDRGabW8r8uVLdX0DdPjW4gQQQe0bxFHu+YZLKXBnrujJfIGRyEzs5jzq/2do905bW+2/GDvra+KziLlx7p6whir1h88IBZH9cH+o+cSXpnYQQlqeegQ0RqfW1URRh33tUhz2ZbYvs/i1Eiky8HwGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rt3a96tN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VzWBRRoT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtd8L011659;
	Tue, 15 Oct 2024 19:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dZOs1hVmv6vJyNYkxD
	NjQ/me3LXTGjiFcrRgnm3Y8tc=; b=Rt3a96tNftAPzR1Boy7Q6OUia7CeSVY4Wj
	hYq+TGjOUrPaiipeDymWPFMm4LzJ69/S3Gqz9Hz2UCq3rujbxqoWt2q56GxuTjim
	fDG3b2bOillbSFlU1BPGbAgxT4PsEf0JynIezOGuHC0e3hCu4P0+OekLZX0VmQ7G
	JFRgmmObKHuc8EZRVEgLONZVDPIyhg1Pt3yCF6bkhjV+Vc21khKSzdnuwJB9yEWw
	AEMGxFhRLJN6Tni7gNGjiMqAGNMybtqjYhyApUVK0jkVk7G1VfrNLOLQE63rWJ1A
	gLyTkfoUmD0j087okjyh73/QzGaiv9RFocMflqvzlC+HFH0CvLaQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt22fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:56:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIFgVH027134;
	Tue, 15 Oct 2024 19:56:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjeg2tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXvFPNq3CtMIe6nI6K8qnAcix6w7IBNUAFwx6LSV0QRtyjbcgOGMw2tr8e5rufqVo2exoQDwGWinBEw0sjtMG/oiwdy0gjfTw+Pg8U2A6oPM9jhnpdkvUZklxaNjP2htzfqwk3PDIU8yeNqmOhSi3u21agak2SO1aq1+SuLKrcnKFbLqUsk/RFa10kf0cYbDe3AFFYbsLR/vXqD4k3/blJRDOAGYPWooEzsMt3rPdNR6X7HvFxGHS5u7DxrmyyW89TpRSgcMPVi3jog/oYNo5mkLJkPl08cAxtK4l6iJma0ngtO0INqFZo119b1Dg6OoLATZz0+3tghHyXQ7pa8Zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZOs1hVmv6vJyNYkxDNjQ/me3LXTGjiFcrRgnm3Y8tc=;
 b=EPn555ieTvgD7H1qWrC1fCoD7V3yUUqbYiXFFn8RWm3Xl+lWei9xoYN1ugQYdQeAhuLSRH5uW2zwWvjlDRCZYvNywjh59klgn1GARjNdflbXqlOKC46swGWJsVzur6OqSpNqIiP5+IejojRvIJqyIMD+DDcirQssmeKkU9kARbO6yNcq595uLPM3nfCnhhOOrlTIXS3WBkCJuj7HVj4fl0l5Fwh4SGZ/QyTWp18xqTD2lPeku/i4UWS/U4ntLFrFYj1gPS5gXa06NhRBXNaSqdZpyR5FSbCBG6tAYK+zZUUiPj5av42p6aSBmYHBlzqcdaa+Jp7zzjf3RtFGJoPkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZOs1hVmv6vJyNYkxDNjQ/me3LXTGjiFcrRgnm3Y8tc=;
 b=VzWBRRoTZLMf1oNQ9dRoRTocOaN+lZrZO9D+PEdZcmOEgnQXOyZUzICbh6fagTPDEsKUDMgpcq62ef/rmAHaAjzm9YWFCF4uilN9it5fohl+EfCK07vBK3LE5eaA2rs8FAjcUYeGSjryDv8HJF3M3mt/lqIsqMxWlQ/9/mRyIu8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 19:56:32 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 19:56:32 +0000
Date: Tue, 15 Oct 2024 20:56:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
        Jeff Xu <jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <af510726-4245-46c1-81bb-e32379c2c127@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
 <5b7227fa-d0f1-452e-b1b3-9d7b87641522@lucifer.local>
 <ZwiRdemGMY6Z6pSN@xsang-OptiPlex-9020>
 <fa645dd9-3835-4e1d-aa04-1892d97a6c86@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa645dd9-3835-4e1d-aa04-1892d97a6c86@lucifer.local>
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab79880-0ce7-4add-87ec-08dced537715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w57sZIvxCwn0WeLYo9KQi+UVl+yi7zPyncerogEljUisHZTRbYm9wyRzH16T?=
 =?us-ascii?Q?j0GqNiY7GMcoteyufs2dK3wfzq5rKZqRDOWoLpPwvx7VXgG4IoaobxDMB+qA?=
 =?us-ascii?Q?/C1kps//Gce1oiSo98WVjMsdG1/jIwVdWFmMAe9gVthRw43MFW2UhljPV+sa?=
 =?us-ascii?Q?cLVnkLnXayQQwZNfIeKmfm1f1pPgyPrc5JbGt7R5xhIqdvoEeO9uq66+z198?=
 =?us-ascii?Q?yzAC2g5YJeh4Q+AcKkvA63+FQdKwDRFwOhQQpEGB7mUzJVr/JnL+qEBxuxzY?=
 =?us-ascii?Q?3kS+TnhAeAExppoY4KZkqsxqlOJKtfpaPnylKkwQGESJoUu/8zMX67RwpNML?=
 =?us-ascii?Q?9MjECEguLYWu+yMKoamT7LPHpqFRXF80WMyumTrvBhEVCQdTLg6OZSdcmkxn?=
 =?us-ascii?Q?xBRyFL0ywXQcsP/mXybBJZs3Eq9R2ST380TRLtfZ7qWLSRjF8vSrUOhxGJg4?=
 =?us-ascii?Q?Pw3Dbm+KusSIhhwjJjdqYKuF1b8g0Mf3r33PPL8bS/Gn2fNOB+pEcousLi6x?=
 =?us-ascii?Q?t/Fbnu0FIQkWG9O0a4AgGxHdV0+kb2fqKAAWhZJa5Oxko8oiJ7PpMEpu+Zzh?=
 =?us-ascii?Q?h2oMEmn96nJ7uccY5xWmRYx1DRWmXjkF5skbH/+gXh+8Xpkks5ARp1mW4bEO?=
 =?us-ascii?Q?bXrs0NJmjaDzNoOWjbmy+ZXxLk2XDhY6fkmDI3U7/hkNI0XJUA28KZtVABL6?=
 =?us-ascii?Q?vKHfjB0dSxPfY3TLnWC5bVmnsMSNFTPSXWIc5AUodEo/9SkBgJP63L0Ky1S0?=
 =?us-ascii?Q?a2XQRPP/p1dxu8JcgKxadgBL1exdHlJ2JeDhyJMPq/Ot7iueGqW1cPaw4i8s?=
 =?us-ascii?Q?F/hIx37+bdp0SCVB1gRZYlTJSX+OhFyKcI9CG72DMvinHHykgIzu6/pgX9eZ?=
 =?us-ascii?Q?Hzfn6nORKk+BCxzY8wBozib4/9tXLhxCahn9qKgMfUVuAcyRR2+7uKm8BquN?=
 =?us-ascii?Q?5myMYzBBTDOT7FvfJIvgoft8oE7a0RV1a/e+DwrgNQ6f9CNT+3UAJwD+OAwA?=
 =?us-ascii?Q?81BWym8MzjMYw5sYmZ8BLIoQyxn40I760IxbBpPohNFg9+TTdvUd3OYQo6+N?=
 =?us-ascii?Q?6vFdSl6NHmC+dCBKZGap1yMbW8eTdA1ZncSjvjm4RGV1NWWFD7oNqzXt2JVu?=
 =?us-ascii?Q?IUZYTTytINRJ3wqVARoRNEOMveq5uXUy+u8PaJI2iMkxSJSOsbvY+4swFbCt?=
 =?us-ascii?Q?Lw0JttpPgIjcUzZyxuQQ8V4lW+FCWk5ZnTGsNDRCNm8oNCWRz9dSFzRXEucv?=
 =?us-ascii?Q?5Csl0TfqcBikPWV3h8c4v/lWxiICGmoSX4caLhhq2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCC/VFuXIwZR+Z9Ff//uzFnONWFly/XAhXe1eErMGjF90S7nnRj5Mo8gKPBn?=
 =?us-ascii?Q?A/JVLtOd/yX9f7pgEUkl895SaQ9EndAV5uJToFVwVr/v/BIbKGFIERi5kDKY?=
 =?us-ascii?Q?YbSf0+9dJk62oyQXj4Dv1lvfsdBHP32d1Axh6rfd89EfuFy63h4eLIzH9Sxe?=
 =?us-ascii?Q?ELZCwgwRZ1w35cSbObSMEC6o72zZHk9NyxW28rwpQdJ1MAVptoD+4rsipNfw?=
 =?us-ascii?Q?AvzSwS8uW9DzycDQ0/JMtNMN0a8EKUcsg1/76EknhY6v2SJPmhFhdhlMxudj?=
 =?us-ascii?Q?xib4g/5wR0VmvFfMpoqLuNYNHHbYFX89KQR3W96YApesitR0RuIDSCp6ypfc?=
 =?us-ascii?Q?VwI4hSRxQ8cUxUPYLG2NpK9fiAh2/bB4V+2t7l+kUlyPr5FcTQUPF8j0krkR?=
 =?us-ascii?Q?EREo+3J6dynAbKMAdl0b5mHg7umEJVCLZMg9yjBiEJ9x3elMebCt1k7y/mUW?=
 =?us-ascii?Q?p6c+2f8KF3shCAErHYh1unz+vS257TW9WIhkiGz9OvqsOOWZsucL6Jhs4Kq5?=
 =?us-ascii?Q?Y9B7bLM7l+uJfjcFuUgLlhIhePAPz44VdvWdDqJFv5nupa8NMxM2IpzkQkJg?=
 =?us-ascii?Q?X3yay3+tWxoy/jHg1PdpgQOfYcVRNdlgb6bOmVBlfh8csbwfkdwMD6sgXf0A?=
 =?us-ascii?Q?lo67VNmfgGc0oyEBT8vWXspSgtFFcI5VrNxtclujTV12ERTVCn7Kd+5My9QX?=
 =?us-ascii?Q?79TrihTG8zVGwChxl5lFzhu+ImlagnMyVShr9DGez/TBtx3Qe1diUSwjSHLJ?=
 =?us-ascii?Q?7C1nbYAfIEJ/WaIcvuy1Yvlwjo0e+il/xYH9VlSGziLE9rFUUV7QIGeBmcB3?=
 =?us-ascii?Q?L+Rw9EEs+WhVGzTTLA4FDbitxlNOxSE6zoAvVvCwDmhXfPoVRAcCmsLAT6PK?=
 =?us-ascii?Q?XuLyO1PAT1rOPuX148XPiV91ovs9P1xLihWyCdsFyBy8A5K199mWNJjL51ul?=
 =?us-ascii?Q?mZksmvLoDiqOHPHL3uiGe/N8a5Br27/lbUq/6SbgTaUyr/+sj9URCAwZpkOL?=
 =?us-ascii?Q?aBXcX7xHL4bYAb2d3X0vKgDUeQYLCQ4a/JeXqfMm7aRH+jR+Sf26mpeBbbAp?=
 =?us-ascii?Q?2knKyOxeEIHQctx3IAIb5s24VbinbIODbGXBjkNnlzwqvR0986s1jHkNBdlb?=
 =?us-ascii?Q?z5U+YVP07T4fO3MzYSi7jb5wlDD38ZAhjx5WjJzjQjJ/rL8p5VKoAE4NVtm8?=
 =?us-ascii?Q?fEJ/MFmRdtSdLQYxoJcm/h9n42zGhfCxR2Qg5Q8JDEWKHi/U0SmpTvwEQL6U?=
 =?us-ascii?Q?dVa6gmUvX/BAY9MtNNND5PC74hQ7P3ESpL+ZR41TEPDKTYcqs9tmXzRsOlyt?=
 =?us-ascii?Q?flHapiKt8GtvV0P1/pzJDAiu8wMLmytKEWf95LLOMQ23flGmLdEDc1/OrV7N?=
 =?us-ascii?Q?2pYqYHTTVAwB2D+Dn8hhZjWFqnr2AWb46s34ucRDMihfCpiHpMIfc6yCcccq?=
 =?us-ascii?Q?ViUxcVu6+S9FqvVsVmG6tmpSR7AXqeocEq2fwqYcusgz9L99mzQfkHKOrb3X?=
 =?us-ascii?Q?7dNRzImKONPd99KM3lk8HRqvYB+KBvrfWbexASjkSVd+xQocXeDz6Xc5Ftlk?=
 =?us-ascii?Q?cXhzjkW0b5Nnio1DLK6qwLnCC38EY+KLYlA9uhcUKPH1ZMEi0OtvKo62yL9H?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZoPUqu/IF9+Q2CRY5cR3udPPdeqJP9zKPgJHT9ak5il6b/KcN+AePxw8esqEEsw3ULbR8fbH/Rn7cp0/6MmkqDUOGmFMnhQINoOoRCANkxspaoI1Hbu17PKMJRvyb7mbBs+aV/up1q+fExRqwTkp+HKzfLzG19m3//VynPji8JBv5k+Lu6+zqFlSi7+4GOOUf2nI4wSx04ewYUNfqvpiin0aoyxFxCWIOiRnRlE5nysIbhXYvG4ov4mt0LaTun1nuhK5crbBFBW24cHgiegzs8YJlcJg/UIuMnJXeI2a/tpv9dlrsJjVSwF4D++Qdh8mJynThAkNmmwVQe/msbPCKmBPo1cI5TWBS6P0G1zgtuYUxd2ZL5F9+DlsJdapbhz6280KLSHqWIj0tbO9gBYJ0yKCRgyW3HPidu5AUytNtV9Z3AcUFbcW3CFQGUpElnI3tYKxBDKzY1iCpqwyQ6x3BKJsmix5rYX5OW3Mp7YHoUspm0KxCelKg4CJCNBV2DB+NS5NI7SuvD2QmnG6DZGUCJUYi9MnmY/wsY4Qm+gsTWD3UVZgx/2E4X3M4OSRDlSOK7r60yDmihbb5Xi2dUc+cL1H/DqOxV7bfBch5Dw5+04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab79880-0ce7-4add-87ec-08dced537715
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:56:31.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPwwqUGdqui1zll24xCAV0VnQmnp/0Q2xSETJZbedYcDPCgYA2ocVfyMBg6rlaCejnGfSnDz+voI4hUjJbQIQtLLl8gaRpUwL6bAC00q8o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_15,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150134
X-Proofpoint-GUID: 3mO3eZQsdrAAWvyka2gG673FkSlacXlc
X-Proofpoint-ORIG-GUID: 3mO3eZQsdrAAWvyka2gG673FkSlacXlc

On Fri, Oct 11, 2024 at 08:26:37AM +0100, Lorenzo Stoakes wrote:
[snip]

> Thanks for testing this suffices to rule this one out... I will try to get a
> functional and reliable performance environment locally so I can properly
> address this and then we can try something else.
>
> Thanks!
> Lorenzo
>

OK Oliver, could you try the below patch? I have got aim9.brk up and
running locally and for me this seems to address the issue.

This is against Andrew's tree [0] in the mm-unstable branch. It should
hopefully apply cleanly to -next also.

Very much appreciated, thanks!

[0]:https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

----8<----
From cee7f4196247de0da2b7632838fd36aee8b77e13 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 15 Oct 2024 20:16:32 +0100
Subject: [PATCH] mm: add expand-only VMA merge mode and optimise
 do_brk_flags()

We know in advance that do_brk_flags() wants only to perform a VMA
expansion (if the prior VMA is compatible), and that we assume no mergeable
VMA follows it.

These are the semantics of this function prior to the recent rewrite of the
VMA merging logic, however we are now doing more work than necessary -
positioning the VMA iterator at the prior VMA and performing tasks that are
not required.

Add a new field to the vmg struct to permit merge flags and add a new merge
flag VMG_FLAG_JUST_EXPAND which implies this behaviour, and have
do_brk_flags() use this.

This fixes a reported performance regression in a brk() benchmarking suite.
---
 mm/mmap.c |  3 ++-
 mm/vma.c  | 23 +++++++++++++++--------
 mm/vma.h  | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 02f7b45c3076..b99ba4cac9fe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1741,7 +1741,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));

 		vmg.prev = vma;
-		vma_iter_next_range(vmi);
+		/* vmi is positioned at prev, which this mode expects. */
+		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;

 		if (vma_merge_new_range(&vmg))
 			goto out;
diff --git a/mm/vma.c b/mm/vma.c
index 749c4881fd60..69ce9e07ab11 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -562,6 +562,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	pgoff_t pgoff = vmg->pgoff;
 	pgoff_t pglen = PHYS_PFN(end - start);
 	bool can_merge_left, can_merge_right;
+	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;

 	mmap_assert_write_locked(vmg->mm);
 	VM_WARN_ON(vmg->vma);
@@ -575,7 +576,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		return NULL;

 	can_merge_left = can_vma_merge_left(vmg);
-	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
+	can_merge_right = !just_expand && can_vma_merge_right(vmg, can_merge_left);

 	/* If we can merge with the next VMA, adjust vmg accordingly. */
 	if (can_merge_right) {
@@ -590,7 +591,11 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vmg->vma = prev;
 		vmg->pgoff = prev->vm_pgoff;

-		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
+		/* In expand-only case we are already positioned here. */
+		if (!just_expand) {
+			/* Equivalent to going to the previous range. */
+			vma_prev(vmg->vmi);
+		}
 	}

 	/*
@@ -604,12 +609,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	}

 	/* If expansion failed, reset state. Allows us to retry merge later. */
-	vmg->vma = NULL;
-	vmg->start = start;
-	vmg->end = end;
-	vmg->pgoff = pgoff;
-	if (vmg->vma == prev)
-		vma_iter_set(vmg->vmi, start);
+	if (!just_expand) {
+		vmg->vma = NULL;
+		vmg->start = start;
+		vmg->end = end;
+		vmg->pgoff = pgoff;
+		if (vmg->vma == prev)
+			vma_iter_set(vmg->vmi, start);
+	}

 	return NULL;
 }
diff --git a/mm/vma.h b/mm/vma.h
index 82354fe5edd0..8f8548958e41 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -59,6 +59,19 @@ enum vma_merge_state {
 	VMA_MERGE_SUCCESS,
 };

+typedef unsigned long vma_merge_flags_t;
+
+ /*
+  * If we can expand, simply do so. We know there is nothing to merge to the
+  * right.
+  *
+  * Does not reset state upon failure to merge.
+  *
+  * IMPORTANT: The VMA iterator is assumed to be positioned at the previous VMA,
+  *            rather than at the gap.
+  */
+#define VMG_FLAG_JUST_EXPAND (1 << 0)
+
 /* Represents a VMA merge operation. */
 struct vma_merge_struct {
 	struct mm_struct *mm;
@@ -75,6 +88,7 @@ struct vma_merge_struct {
 	struct mempolicy *policy;
 	struct vm_userfaultfd_ctx uffd_ctx;
 	struct anon_vma_name *anon_name;
+	vma_merge_flags_t merge_flags;
 	enum vma_merge_state state;
 };

@@ -99,6 +113,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.flags = flags_,					\
 		.pgoff = pgoff_,					\
 		.state = VMA_MERGE_START,				\
+		.merge_flags = 0,					\
 	}

 #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
@@ -118,6 +133,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
 		.anon_name = anon_vma_name(vma_),		\
 		.state = VMA_MERGE_START,			\
+		.merge_flags = 0,				\
 	}

 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
--
2.46.2

