Return-Path: <linux-kernel+bounces-294705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C395917A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569152829E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7351CCB50;
	Tue, 20 Aug 2024 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Op6NbzJJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TUm45UZy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8F1CB31C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198305; cv=fail; b=UzijL7KOa83zu3evz2t8WI3YyJQfULPjlPlTxhTDU3HzbkKK363Ty6AGPmt+fcQY2tOnJ/rsmd4pa6x0aKzorj4gK9MiNnCeZmBDXXuEOROABmQKMomv6Puhu5CGiOYhQFT5J1rOz6rohb73tvg3eXeAz35Q21sDXBaLumM/28A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198305; c=relaxed/simple;
	bh=zlSPeqeLdJM6ktIgIDmb6H1/n+WxuUa3YPg6rTqzkKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAmBSqsCGC2qZj7HSx9dgU2HyTQa84MWyZeurE7+Mz5vEv0B2n7QsK+9WbFntZ4NPynCmz/l+QPqea95lYXeTNiAwnUvIiZIsytaZsyJ96vDM+mPvXZcZXv4NCm7cKa1kLHfWmxgASSfQ1ofAgttO4OCmSeFAZ/MV2reVSTsMNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Op6NbzJJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TUm45UZy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBlJs030503;
	Tue, 20 Aug 2024 23:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cnr2nj+i9KRBLtVAPLklyAzG/es9lZr+TlO+DI4Jsvc=; b=
	Op6NbzJJlGbeXK6uC6jcNk/RVbAfx0gGyMHCQiftRUOZnha0NGHILdgVL/98uaMT
	iVxreEVplYymi/H+xwOI9USBezCDiQoDgc8sMBhnwRtku/buLp0O535Sa/QQt5TR
	mVBpt80329u08OkwCT2QlZ9699hRmhn5jnaDCxjRCK5oWUZqUFGFWHaz9EFDpGQh
	WQ0ao93SxzK14yygXLI/6iUO6aFGDpoRbHl0Vgos1rDWc7hzmHctnviJye/Scz6J
	tnGznO6GBDrx8H0SQCnfWj20xK2EeUXvmIOr7D21K9buw47PBNCn5CLSw5XoYRCU
	8D362Y9T0VP69wwGvb3pvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dphed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJkJ040123;
	Tue, 20 Aug 2024 23:58:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbef-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVOB9/OA3VPv/2bdWgxlZ5+FrByO0iHHJrnXeLADVeYmkkyBB/3cRGUrzFjCmWnlbm14kYedcsd59NeaIpf8xKQKHplJJs7TC7klBgZZ5bRMW+RpdRNIRjAWoIpgQ5SQFgP4fLT4plnskuCBxBcFdXX6dutmPH/E2rzBw3/Y7oC08z3uEK8vU0Y+9b7PRMOsfuB+hkMuu5SB2tPr6wnf5gOHutB7epxD/J1KoQda3YyIIxaAouVjm395H5vKw9ycL+y31fMzM2GjqlY0llnTZlgk2VCW9hM9HeLBrSER6hq3JU7sBrzhSju3Bcc1CBZhpmOYBdvAQt/JBAeZwy7XDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnr2nj+i9KRBLtVAPLklyAzG/es9lZr+TlO+DI4Jsvc=;
 b=ITOi7LXiIpp4nrGMMrUetcbZ+CJswZmRLqe1fcfyoqrnwJFCymUASYOxHqDzUxft/zM/klgJQ3wewpCVFZUNEP9wEJk4bLs2SFx6LT8KshGKjuamhapirSFFuPDssFMDcuo6zj2aFpuqDYm0O6omINL9ygUeaVFkuhzbG5HnfUQ8GgNC5xtcGa27lCmd9uhpNsJ8vhg9tO+Q4DLAtZXtne6o3sAfd6hd46rVi5OLqO90tmQ46NLrnu75xv2CrVCE55iFYIr4ZrfUUCHESrwQvChC8ovUSdN1ZS35nSVgI083X44EzlgZJsTHvK4i6Hnh8PeQN7ezGIe2hCXNChCoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnr2nj+i9KRBLtVAPLklyAzG/es9lZr+TlO+DI4Jsvc=;
 b=TUm45UZyxCxOsd7UjhKMWpdw5Sjvf9YktNGBoGFrWSI/zH4JXTx/RgaUdSWAxmvfHCX+vf/3eYgeoRrI6ksqks4m3y3rHWDUopVBLXi1BMBxPmPdMo3pwqKRl5NBj/MbsspgpnVMJplWkcGPqZ+QCB4y2vc0H0HOsBl6OgZwkQg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:03 +0000
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
Subject: [PATCH v6 09/20] mm/vma: Expand mmap_region() munmap call
Date: Tue, 20 Aug 2024 19:57:18 -0400
Message-ID: <20240820235730.2852400-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0419.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 44399041-e5d4-4d4a-ad9b-08dcc173eddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XGII6FHdPFm8WNc8c0Cyjgfw26jpTqNGpxKf+UnCMFRfG1HmALOtpVdMC2gM?=
 =?us-ascii?Q?mQtuG6t1QCmBqvaodyj1cCCgEOCbGK0xeomOYgZw0VNvKOTsWFsgqal0p9+R?=
 =?us-ascii?Q?PU85c2oLPQtOIftlFnstjuXXZtjFPjrqutW6WrAgoEFWnZ/X4/Z/OSoFzxi1?=
 =?us-ascii?Q?Yi4LLMhiPq0nLw7wsGgCDbfFDGPU0o5ANAmJKh3VIaUDUcntbSkWWd63V5ph?=
 =?us-ascii?Q?/3UxGHkjelsYwMezpiBSdNjVg9ikubc6lqnnJikR2n++M1EjVQjc94+EV669?=
 =?us-ascii?Q?JpANs0I41kABHHTA/b0kCRvDRMwqwcotX7xtZ4K9yx6s+4xCDTJrBdJL+Fie?=
 =?us-ascii?Q?Mx0JQ2DnNiTNDVrp3KS3O/QU2Cymw0vdVdxb8VrU3XvQu0lBQyeGGiQRWyrF?=
 =?us-ascii?Q?7jboAxITMOuhhcHuTUnramaKvqhbqJlu8BVVtRQM0zCXb1vFdZR5VUce3Bpv?=
 =?us-ascii?Q?GdpGAowwIp1LCrGIyWDxfPCMDWw6RsT08C8yZbyfLWi6OEplhzqwV3cnHU9O?=
 =?us-ascii?Q?kFTxUSNdeCEawdke0XhoetXUlR5UHvwQeobDPXAZKoTQtqGPz8fs5FAVylTv?=
 =?us-ascii?Q?Fn8R9tfFaXnErD69GINUgyz+c2cvbE7bgMvEBsHSF1ErnWNp2phYF2r5PDYU?=
 =?us-ascii?Q?zB+HwWumxSfGTBT1cc+zanwxUk8MHvGahXxHTI5BFmx7GIDpqxMxhBGgPW5d?=
 =?us-ascii?Q?btFEBHiXHQCbSEZb+qzASav5NlL5mrK5w+mQ5YLvhd0ZVPyfr/4TUFlOf++Z?=
 =?us-ascii?Q?zpyRR8h8VS5o7DY7F84U/Xaje8g36KMdhTRCei60nJHmF2tfTl6xr/1+SCCy?=
 =?us-ascii?Q?tUbad8dFi7sv7XbZc5tPyJNe+ggiTrceTC5Ikt7eIIdU1wADiK+GvsohEHTu?=
 =?us-ascii?Q?DPQ0dusSx+VBTLs2zzu6vkurIyI77sBY3sl9HszlMnHZCtlkJ7zqkCKnytwr?=
 =?us-ascii?Q?PpkEaTrlMY9yzMEBN7/UQSp7BCVpYNxl62sFWHq17aTiuc8TYuBUaHDpPHhY?=
 =?us-ascii?Q?kLzmlaqV4h2k1G17aPOy3eteSicY7YA+8PyQ7pXNl9pD4bQKO7KivDvllCUR?=
 =?us-ascii?Q?RMtktXLgIqtNuhZVs+VX2aG+A9KI1GsOOnuJ/pdaC9ENxm0rGdM7jHA2foOg?=
 =?us-ascii?Q?NqrN7q0DOb98CNgjUnNTv26aB1PPSy45cSzTI0x8nKrtsmGwO1wNTRdR89Bf?=
 =?us-ascii?Q?QQWwNrP7Fuv4V6rDrRAmjL3Gu4XWZ6G0dINUNqQr9i30T9DGTkSl/ooTAD3x?=
 =?us-ascii?Q?W2tRPnec8SSTGhLqqQ+qWObkWyYulsZt/r7lP/oTKhoM712fwcS4ehE/lb4B?=
 =?us-ascii?Q?mabu2l9e9zTiS5T9+7R7+yLdVac1ryBkFySdR3y0jWHLUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Liaz9+YbcD7X34xHEwggQYVHc4ymPJJOknCva1vsmxDr+Mict7uifA0LNnmk?=
 =?us-ascii?Q?teQ0uu63aCleIzrMi457EC4E2nS10NIuLTLVeZWIZEmdyrZmuGhq5+XqtNiZ?=
 =?us-ascii?Q?9rN/LRbTIitI+4SAziw8Y3CQzzVyuRQ7LVZBvKrUDbRULsX8kHVghUw1Ctjz?=
 =?us-ascii?Q?1Za4yBKyPMGBMrriCioA2ER7xdq23hEJ0uabZYhCeaZh2LNzk6op1JDSR0sT?=
 =?us-ascii?Q?+OvzUJSmIi4mLtXO2HWO2UiJLAakJFxdgOGldW+XZQLW137LuRNzCWVvp2g0?=
 =?us-ascii?Q?mbiMhWchEcDAw96MzLMxm5d8x2w9cUYjSAffUeE13t0HXkb96Y5gsQWXDCup?=
 =?us-ascii?Q?3PFxJwmEapdqCbUky/bS6vGBkFg8iZ/yHWs/4hzpQ5mkWRNUsQTXjQ8NZQ6C?=
 =?us-ascii?Q?w6JcmuNUVHjvZfko/InfDJXoL7/6rnja7mYUD6Uk2jW1rmQdfLZGt/KMrS/x?=
 =?us-ascii?Q?e53z3LTxodM8CVGiQCVRwzlLOPKQKkT0muJryX65HtEYzHlRPGWDuj2NoHXy?=
 =?us-ascii?Q?l8sD4MaNUEcLGeibaZ2Sp5+poBb3O4e1ZiduR8kdXsqcT7Jff4wTw6/9Kzis?=
 =?us-ascii?Q?Lk6wO9ZnqJDM/zx146qUw0LT4QN4XdfDbRKWjEfGG12PfRUF+A/CxBPBr6lp?=
 =?us-ascii?Q?xZ4SaOOO7QmNhGt32dLwwMnxfN9SjNEDgvWGnkBtpT8JrSIW9hxK3tGQTW0y?=
 =?us-ascii?Q?L7OPmcxY/1YvVCWIq2q1cgIcazc1DbsJA7pKrpHEE+/MXt3jp+I3H+QznakP?=
 =?us-ascii?Q?a5BLBR4s9yLpli2ScETAX/DH0KdTqKg+s8yfRReuDBJg+0F5KmEGDF8cd8np?=
 =?us-ascii?Q?cRT8Qh7UwKn2tzui39Rwsptdl1ylydhGAWXp4HcXDiI/rxXfx/78GG42CPBw?=
 =?us-ascii?Q?RunVMRsnCq1xynpoLFIK++LINu9Uvce6eUKWe0vd7AURE7TKVSBUdnmzZbJF?=
 =?us-ascii?Q?CwGBiuYMe3HiZsPUo77mRIFYC1GP66CVRJoDwYxT2rjmF68kG+fe9cNLKZih?=
 =?us-ascii?Q?FC2ntuiEJtE2+8g2MuGQZmnpZLnaXf2k6Si0+EkQ4vi2FK4Y4/MYeUtWQcTP?=
 =?us-ascii?Q?OTN4O/sMZuBnvZIlpgbyb6FZysRGukduiW1cUdfEMWqIOa47mzwolXoZg9HX?=
 =?us-ascii?Q?CBAAgvmAI4Su3Dew3dJLmtKgBdD03eGwzXBpybtxE+f5ZwbPmkldr+LYxKw0?=
 =?us-ascii?Q?b+yOV84cxMm/ifJ1DJNyCyPwoNGIhQ2hr5GdURYhOZesgNCuQQpcjINzrllS?=
 =?us-ascii?Q?esYO/7u3wsGrvyPKbROQQ44j8E2+sslnRV72C+9CeitaPXkkQ5IBleeRyR2a?=
 =?us-ascii?Q?86ysL7CqPFaRqLmUBIdBJuc7Ln5fGuXiII/06XyFV7wCy6g+A0cD+TGLsjvJ?=
 =?us-ascii?Q?c7zLfXnQGmPmycPcnJl5HEphngw/ogsEZnb5lS9+LMdrmjzsWhZV19odF9iF?=
 =?us-ascii?Q?+Q7ACfi6zdYjrmN92kcCF98htBRfDO8hUUQIpX91wTDIcI61s54AQURhDSnC?=
 =?us-ascii?Q?K3VGNYF1wMHHc8qciLm13l96t+bOX4S1Vi1vwaUDY7i3BytIxFYQyAn1WlOG?=
 =?us-ascii?Q?m0weT+8XH2ndO5FBiGnfKDSTw74F2XJYMGKFlLz8bY6FydoWxvLyyD8LGJRQ?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iYhTyZ4X5CofWp27hMTQmA+21HupxKBPvQ5LX8peql6ulxg/oDm+mTdYRUuHhq+sq10MLyTCnNg82b9dwkKamt/BE8tz2+deU8UthHZYND2QkE02F4cHrIRbw/IZb7I07nfNsAoAKfr+am1LAfr4Uoq2QP5qJqpQ6r20EappTYgnBhCS/JDSjgQfAf2ry0AImn8N6DcJg5kfhgsoJsuOUNBXcQchOxINntLixj4/xcA0vmidBUAefzYn0izB2ORTE2dfN5f+ToWUlPZna9X7W9zH3BaYUdZW/MzBNzZ9vHihHjWrR8Nk+HjpWDeUQaG83XPknQ68VoBA0RKcjzPD1D7vyeb0OUcs6tBaeS4bT/WsvEPBhajkKuLH9ViINPUg+9A2boFM7UWFlA7Cc++s6nXvy7mARZ7DbCqQDqG/gpz5QLCPABDbBLAjTBOT/sS93cogdCinI/1SyiKSMSvHGbBbxyiW4UHaY1uz/lf9OnTW387SeJdGVpv/c6ZOZ5P1GPSfrNqx0QAPML4UWHoSEqcqjHCX9m1maRNYzkYhb5G3OwupK2m6R0L7NlIWwN+0K9nZ+Gf+PjdRsam2qzvv9i50Vb7CnuIVuIZSvHybkj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44399041-e5d4-4d4a-ad9b-08dcc173eddd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:03.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf2P27rkkfbuEZh6SmNmdyFgNVFniI+rGDrB/Nel5R1zWr0YU5OWlmFbOZhgMzCu3gb6RUqGoy683AnYjS7Eeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: 5P7WM8SD7g_jBwQ_ST1Bdx6a7XAPn53R
X-Proofpoint-GUID: 5P7WM8SD7g_jBwQ_ST1Bdx6a7XAPn53R

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

This requires exposing a few more vma operations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++++----
 mm/vma.c  | 31 ++-----------------------------
 mm/vma.h  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0f5be29d48b6..e7e6bf09b558 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1366,6 +1366,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -1391,10 +1394,27 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		/* Unmap any existing mapping in the area */
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		/* Remove any existing mappings from the vma tree */
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		/* Unmap any existing mapping in the area */
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -1407,8 +1427,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 5abda4c49c83..2840cbaeff8b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -80,33 +80,6 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 }
 
-/*
- * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
- * @vms: The vma munmap struct
- * @vmi: The vma iterator
- * @vma: The first vm_area_struct to munmap
- * @start: The aligned start address to munmap
- * @end: The aligned end address to munmap
- * @uf: The userfaultfd list_head
- * @unlock: Unlock after the operation.  Only unlocked on success
- */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
-		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	vms->vmi = vmi;
-	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
-	vms->unlock = unlock;
-	vms->uf = uf;
-	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
-	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
-}
-
 /*
  * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -698,7 +671,7 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -747,7 +720,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  *
  * Return: 0 on success
  */
-static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
diff --git a/mm/vma.h b/mm/vma.h
index cbf55e0e0c4f..e78b24d1cf83 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -78,6 +78,39 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+}
+
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach);
+
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach);
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-- 
2.43.0


