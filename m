Return-Path: <linux-kernel+bounces-244200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A792A0B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180E828202A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC71DA4E;
	Mon,  8 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCakjIXI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WnBB9s7l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFC6F2FB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436924; cv=fail; b=k74dQr4jbID6CVDpjI9gFYN2b3CPpsWyIrstsEOUTWTK3HOWe8HbvoE1VFIsSTvBPlYOeXvRAoaGnx0Wwex/qJod6yMdqv6JlNFMcvH5LTwFR7XVzg4SnSSwack9JLqck7CtdM19+TYwAMXDy5OTbQYhyb899c/g7TmOzG6wBZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436924; c=relaxed/simple;
	bh=zYXBDYjUgePgrWSbyz9pNeK1fqtllTnEddBT1iyp4nc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfnE5/C2v3cw1FLgJ/ILE5RpiYtF33887yJrWC77uP8AFaXvuHgobfQHTcRMzaKDTnvMn8OgMGjJZk91aOF6vhZdFdhAp+HSSHufzJ1ib2gXFmvSUWOAu5l7kFX+XUHliBGRgyJsQLZBn1wyKdi0p7vc63+EXJaVFBs/MYrRUes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hCakjIXI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WnBB9s7l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fSJh011848;
	Mon, 8 Jul 2024 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2Rj+J6dW2wKyXzY
	9A6LnCLCk8vf01Re5/9SSTrzg4OM=; b=hCakjIXI1DgHcf0qlhl5YZ2F7p+zjvH
	Hv9Kz46ZB52BKJXspjNkX9fajO8XiDWi9yY6y78F9FuywLxqqZC2cPiEIoTjOln4
	Et76UBCWEAIl2g1fKg0M2K8Upv2fv0DhVekM4V5caicx3YmyS06H7ZwYrBggnGAL
	V0FlQ440yRj+nadbkAmMjQdtt+fGOA5qPb5Cb9zbAv70nKiQ5moK6KI0SiGHvRjQ
	9zKFWymZeyQBRUQ0ajnnmsddurep+dQUV4Jr7iPfKnrJgZH8F1kJgZBnmlWYr/Kr
	q7txmBL3+j9HW/ChdlxBbSjxrF+xxu5f/3zZdDrj48NFJyk7o7otm/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybjcjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:08:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4689RR7Q013574;
	Mon, 8 Jul 2024 11:08:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txf872k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl+mIfl3gwkabTrJfkiCL/IA6tRcG803gQtrIE7eh6ngPxxMTIqldIwzPUpvnJUQ8w2wnuzYOG3W6lIPLyCNvdireJLvNH3YvCFP/879H2dQVcPEmlmCLgILZddJ2cb0KfnP6nY7Xb+WS/DHRSRj+2K/W1WqCXOW07w8pT/ytXJO3QSGKAit1/RyE+f8kP0ipE7ChwHERZoXvqPQb0qkaQRWXuZGtceJT4ERUb9m61qaGJA1EQA4BAk9z1xN7xxYKu0siTWJzXcUDw/dp/r1jjRLC8sWrbanXQO13mgGZVcclT6k9hGGwTmQOtB9EmRcz7kbv+rTMtmUsC0/+5rwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rj+J6dW2wKyXzY9A6LnCLCk8vf01Re5/9SSTrzg4OM=;
 b=D5ordikwFkJa1DeTqA/lxq3y6fq2jZRX5Ac4VEQBAPCYvjhICGZzd8QopE+lFjgBrh20ZePcWbT2Zcq8OofFKW4OJHsRXQC9VfM24nHJAorluvFMuvfa5+EQ80KNW0ieqvMdmLE3EPRgc/SHS3O42RNfgvO88SrmUjIx7xZQShbama10GqPzSt/1GPIUXRSg7HaiVIDpt68yxuNkkQgiqeQNnovyayUVXJKfflLuZNzm1TLjplWRihds0wlBQbMkpZcPmr+9IMdgNWJX3WOt1FusBs3kK3/qvGWwgu3tui2e0umwcRrf/jLrc+3DAm3jO8K1lmJG1yNhh0eFk5WMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rj+J6dW2wKyXzY9A6LnCLCk8vf01Re5/9SSTrzg4OM=;
 b=WnBB9s7lCINyWhdQQ7SkqgjzegbUhjuGA5LHbKyiW0+TZze2LIjzz4V2V0TA+ZkstlpssyUCryhAgrB+d/X90Wdb7e1EfQM3Jm/0obgumR6RCPH+0WPHS41y/dDg0BRh1LBWxV8vrazTAQFa3T6QJ9aLc2HZb4NtUpQn3NhHGKs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN2PR10MB4158.namprd10.prod.outlook.com (2603:10b6:208:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 11:08:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:08:18 +0000
Date: Mon, 8 Jul 2024 12:08:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in
 mmap_region()
Message-ID: <c894bfb0-8cc5-42fd-ae55-96ac33631769@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-11-Liam.Howlett@oracle.com>
 <76625760-1fc6-4c81-9df9-ee47697995ff@lucifer.local>
 <c7vcig3ee4n3zpfev3tbv5epcsdeue5it3joi22iwob5vx24sg@ypl6ienxns76>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7vcig3ee4n3zpfev3tbv5epcsdeue5it3joi22iwob5vx24sg@ypl6ienxns76>
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN2PR10MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: c75e2e99-0887-4ec3-a8e6-08dc9f3e45a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J7qvtbEf7aTG2Sb8+Zhi1ElsaTgH6uVx5YoG2MpEJN8C16b+agYGMxF6sm7i?=
 =?us-ascii?Q?Sp3LoUWDhQrUWJ/GpwV1P4gL7yfG+dARX7y5MDNNx7R3Whj41AoNcMidy3V/?=
 =?us-ascii?Q?/0OwfTVI8V17xonYDIMXaFKn4LS3G6Ut4jT3NckwmEfz9nqcnGUXeG9gvwdz?=
 =?us-ascii?Q?Yce5NAXaTnRYEfYrwAgKbgwOdbBQ0aGW82djtMV1iEa/a4aGJyczVkDvjAk+?=
 =?us-ascii?Q?K1JzXCZg0hbkFjgHsutpDrDfaC/uexSmGZgvvfST/GnMurgcyQwBbV4UjyPX?=
 =?us-ascii?Q?BRNTN2UC0kKKINUVs99URHpSYCTERmQm7vqV/tDgMMeRKpGnZcaf3DKoM7zU?=
 =?us-ascii?Q?L7wBbmIbn0LlKYNqC6oMnYHJgacZ1WEgBz9fuG3GiRRrWxfAOA5DkAFtq6vK?=
 =?us-ascii?Q?xg6SDS15SBR4JUZH3TLiV5R0uXL8VJtLdQs339wcu/4eTXCT8v/tKGT8ZElx?=
 =?us-ascii?Q?nW0Lb55/e2OajQZl0ih+dP2S2l34od3F4Rl7Q6NoGG9AZQnsJql8gEO5vMdF?=
 =?us-ascii?Q?KyXWFaGSF+G0G4l1Y9MejNQ9A1xFE94TSAWr/JSQq2xleVuANYy2RjbZ0PgE?=
 =?us-ascii?Q?lrgLeahZljv77vxIhwCJMprj56YDA5cYRBWQ59cWEhNyUa7sig61FmCywP3m?=
 =?us-ascii?Q?hBtWm5WATV/4nNB8C6UBgf5+zhxvqTm3QKZ3/8DCUtl6JjYrPHPlmkCExm+/?=
 =?us-ascii?Q?a8N52CoVudJLXXX6rQgkuAigNGjxobwBfHV6v8q08rDBBesyEJu3WFh/sAba?=
 =?us-ascii?Q?SWYQMCgiMwwb5sA0zm7GsabVaeuSU6VkYbxWAKM5KHQ4rODzahOZ9esVj8yw?=
 =?us-ascii?Q?EG4O2+ns+ctps2DdKNOohUrYJGwY/UO5gHDnxYdJdnioDM67AWbGtPiNGyYu?=
 =?us-ascii?Q?nxeZ7dI0o5PFbXRq/6tY0ac4iNJmhbOcZN0rnqzjilRTP8mpqcvNGqQIrqjV?=
 =?us-ascii?Q?6he777H+V05D69mYebJydvIrQTqVt8XOAfvBKRoCB6V2b61Q4VNNG5TDju17?=
 =?us-ascii?Q?/ORAegIFZP6hcIX1+SBqs/aekgdbZbgUFg/PkrTWz1IZP+BM1tx13GUzAIiy?=
 =?us-ascii?Q?SUIMUDI67rF3iYpZqJ5Gt8/JNEqEOo2zH7t74AKkXdtg0Ojrx2isjbAjieow?=
 =?us-ascii?Q?5pj+q7eMnLBlX8YmAnyfZEBouSVtUk9v/tQVMMJr/A/MlGBqOxDrm95sF2vA?=
 =?us-ascii?Q?BNiWL2jX0e+tpCxd1sW+bqWEeqPS+7H6LgE2vKllPaKoNbTwIH4ClA6K9/nu?=
 =?us-ascii?Q?MWKJ6zUXJvKXHAJWgSRUj6/Szu5vNdD4VOh97kfvBAGgyNNQ6NTUJFMmQ6Nb?=
 =?us-ascii?Q?PNcnuGCUy+novnpObboP7J8m+ohyXCuKf2/Vt8T0PwC5z74RBM6fcIqmmYp2?=
 =?us-ascii?Q?NuiBQXEBFtwej5ootp8zU/PgZUEL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j3o1qaBmZgfDxDENcUjcXqI2MLR75RM7Z9K5wMaO3sdXuIAV7xs3K5F+OsEO?=
 =?us-ascii?Q?Zzp37ntfBbBTuWng0DBnB/g2HbKTY4aR+r1oa7i6hy0YhJ97jX7MYKUjFHFu?=
 =?us-ascii?Q?arX5J25G2Qq5QMYMXQCXW2S3hXLF/nwKYA6SIT7eKPhjeWQ2q70OKQsdpHIW?=
 =?us-ascii?Q?r5s+PsnvEyBJMWB3nwKV6GnfyECNDwArF2APFuOx7whnfumrH+wzxp1dRLKC?=
 =?us-ascii?Q?CNrCw1IyUv34UYyhJ3vLTtvnsznBUDb883TPdvShXkUP8xIORsNb7n0LgXWC?=
 =?us-ascii?Q?riQ0Vr1iZiNujbOL3sFWnbpB/8OBTsIkn0IFiw6IycJ6CGTPb1HDd7h+h3wv?=
 =?us-ascii?Q?DTgwy0pgpjE59vLbtnwX4GdmBTs6++QZIXUuxeAm44mBN5ja0kzri7UfQFEK?=
 =?us-ascii?Q?0ka+0OP5QuARJ0JLFosU9r4/5plS0oLqXdaPyiYfvTJ/9QlT/XJE4Qhi+iwm?=
 =?us-ascii?Q?WiPxix4j0asrb2sj0MuGjanocJfywi+sZmD3qd6ZPODV1D8mUwyjkEsArDUc?=
 =?us-ascii?Q?PqipJH4OZnVhntTtQo8Tres1BeJOJyJ6UZt36mxUR4Zgz5dkyLpySsWPSLrO?=
 =?us-ascii?Q?2qxlOAnPAxcLlDOG6apZi1WPH6kZOV2un/p1Qccd67NWkU28FsS/OPuA0AHH?=
 =?us-ascii?Q?cGWovPgOKaDB05sQPlfH7EQwvDBXxtpQIh1OmUUR5gH+1k4VGqqNvIlHsFX5?=
 =?us-ascii?Q?OqIKa8ceCKxGcbO0G2KfBQsBZV9zjIi+UcvlAvTLxKXuLwrm6xo6sSG4mfez?=
 =?us-ascii?Q?nIBLmNOGyjH5lrcBf85yM3SDVpFggf8YyWLRLjLsrRq+r8kbEaG5HN8kHHgq?=
 =?us-ascii?Q?MNNHJiHSHrId2eiShQprDxCeJt6rnxyhKmZxyi+RfWhRBc4WwnoySjcID/yT?=
 =?us-ascii?Q?XoxupXwNt9mHQ1x7NaILf6VTR7COoeKXYDJzWc/RX2BlFrLLvVsNmO+7d+zz?=
 =?us-ascii?Q?1CKmh6U/9WZ1x7l9HQdxohgjyU/dbao0c2PDFvJfoWdvaRtodWCLf/F7YVyT?=
 =?us-ascii?Q?uq3lCb07D90GWID1xMpfrKwDFSXIVlh8YQfOrQ4bofBgqxqdP0QjDO/WzRYK?=
 =?us-ascii?Q?v8EJBEWhtGsDdvy4XxLKK+9/nw2zbNl6VIibrE06dghj6+2vz5h0C9ZO+g6j?=
 =?us-ascii?Q?TiSk0B3afEq9Wtdpc3uingW3pa50QzYRv75L/VKEsGuNjNZ58Pn487baoJU+?=
 =?us-ascii?Q?fFlRq0MiwqNdhJhSnlewZIetrVmPlT5zE1xm0S7Xz2y7L6/SCNqtkZa68gCl?=
 =?us-ascii?Q?bLK19YfqtbyzO34HBuu41oJsFZzFJ1LvCpFsCrRVOAPVVRyWA9WzIl/FqSWZ?=
 =?us-ascii?Q?dTLrEC8LVtGIZgMYNZ1lgV0q2pQWVtaLK7NDvISO2oGjpcXYoJEhdGutr4Q8?=
 =?us-ascii?Q?2HZXJ24wvJ7HlGNbHgIEKkOKLScFHzDzpHzL23i9UvPhQPj87wvLyAXcwkhy?=
 =?us-ascii?Q?uDl5E/a8krX3Hazkn1muIs7tAUmxy7ep1ceCTKWUOub2T283o0P6bQUMsrWa?=
 =?us-ascii?Q?MlL8ruYRCHiB2LEy32zyFg5SimylJHWsa9rDqeRy8R9d6LsBoOH3ZwEauVf6?=
 =?us-ascii?Q?McG+UPOUNyrfUfx0f51z39jtpqXAh+pZN0A1Wo6hLVuSHW7qZ6nswe6X173m?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hqs2It6xJCQiJsILwpg3prINTf5bIpUz13VNha75ivzYYgLDhYRTXbgyf8VSJTsEwk2yI9OtQmeKqKbuQkgDZ/dqOmf1pYu5Fn6mPNH9cYtakWT9pgM11wPj0JNxiNUmPTEYTMRPO4B+9vjR5LgJmr0IQxaJbp9/X1QZCGRVRLBjJXRPETD7xucmb5y5hoo8SeC1B6Bo6kp42CWPn6FENUhXkDKL1b0NSSg9AUYPVqxbyNdflTUT3/Bjt25t6a7oy/p5c1K1G1vep6Ir4y2yn7ASjH+mPIXjkEdiNTC8ktG12MUD8oivqYMh+m9DBmZQR2c6ilOtpT9EmZWwIEefIycw3SNLJDr0VCah+Fuv+EWhWel1WfwkeSSm2P5wNYXiRgnm4rMaf04JFPl2IixRmBrUBr0sQV7GlPVAkrV6xHM681FW6h+HPIlSAFGdwEhrbgm36POvzGD7gnNGlqUYeNuYPIsPJdkZgnuA8X3rRQsAk45vXqkjtyo/Kh74sbm7nMS5MsdrIJ8rWtpUz7w28NWctPWTtPSwqN8/EAcMnd9bUL/ei1diEuqdfxC0AAZIZUdt4unw3X4ecejvgXoRmYCAwxFzbbkuD0wNI6SGEyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75e2e99-0887-4ec3-a8e6-08dc9f3e45a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 11:08:18.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvy7So/wQZVxLf1nlTdrmPe5thR++llbiuMvo31L1TkVnQC+cAcvyG1IrvIbufhxstCdoVi8ye7GQ6M8AqbF4Pcq8iXtT0cB0UL4EULtEFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080087
X-Proofpoint-GUID: 0B672OK6lknOr9MWaKramgupRyzx-jk-
X-Proofpoint-ORIG-GUID: 0B672OK6lknOr9MWaKramgupRyzx-jk-

On Fri, Jul 05, 2024 at 04:56:34PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:18]:
> > On Thu, Jul 04, 2024 at 02:27:12PM GMT, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > Instead of moving (or leaving) the vma iterator pointing at the previous
> > > vma, leave it pointing at the insert location.  Pointing the vma
> > > iterator at the insert location allows for a cleaner walk of the vma
> > > tree for MAP_FIXED and the no expansion cases.
> >
> > I mean, it's funny I litearlly just asked why it was being left pointing at
> > prev and I guess this answers that basically :)
> >
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/mmap.c | 28 ++++++++++++++--------------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index f5b33de4e717..ecf55d32e804 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  		vms_complete_munmap_vmas(&vms, &mas_detach);
> > >  		next = vms.next;
> > >  		prev = vms.prev;
> > > -		vma_prev(&vmi);
> > >  		vma = NULL;
> > >  	} else {
> > >  		next = vma_next(&vmi);
> > >  		prev = vma_prev(&vmi);
> > > +		if (prev)
> > > +			vma_iter_next_range(&vmi);
> > >  	}
> > >
> > >  	/*
> > > @@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  		vm_flags |= VM_ACCOUNT;
> > >  	}
> > >
> > > -	if (vm_flags & VM_SPECIAL) {
> > > -		if (prev)
> > > -			vma_iter_next_range(&vmi);
> > > +	if (vm_flags & VM_SPECIAL)
> > >  		goto cannot_expand;
> > > -	}
> > >
> > >  	/* Attempt to expand an old mapping */
> > >  	/* Check next */
> > > @@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  		merge_start = prev->vm_start;
> > >  		vma = prev;
> > >  		vm_pgoff = prev->vm_pgoff;
> > > -	} else if (prev) {
> > > -		vma_iter_next_range(&vmi);
> > > +		vma_prev(&vmi);
> >
> > Why not vma_iter_prev_range()?
>
> In any situation where we arrive at prev being able to merge with the
> current, the prev->end == addr and we are already pointing at the gap
> with addr.  So vma_iter_prev_range() and vma_prev() will do the same
> thing here.
>
> I thought a lot about this (and created a small test application since
> it is so difficult to test vma merging right now..).  If we do not clear
> the gap, it is possible we will be pointing at the first vma in the
> range, and not addr at all when we call vms_gather_munmap_vmas(), but
> the loop at the end of the gather function ensures the vmi is at the
> correct address (vms->start is in the range). So the result is that we
> consistently point to the correct location and so these two calls will
> do the same thing.

Might it be worth a comment here?

>
> >
> > >  	}
> > >
> > > -	/* Actually expand, if possible */
> > > -	if (vma &&
> > > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > > -		khugepaged_enter_vma(vma, vm_flags);
> > > -		goto expanded;
> > > +	if (vma) {
> > > +		/* Actually expand, if possible */
> > > +		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > > +			khugepaged_enter_vma(vma, vm_flags);
> > > +			goto expanded;
> > > +		}
> > > +
> > > +		/* If the expand fails, then reposition the vma iterator */
> > > +		if (unlikely(vma == prev))
> > > +			vma_iter_set(&vmi, addr);
> > >  	}
> > >
> > > -	if (vma == prev)
> > > -		vma_iter_set(&vmi, addr);
> > >  cannot_expand:
> > >
> > >  	/*
> > > --
> > > 2.43.0
> > >
> > Looks good to me,
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!

