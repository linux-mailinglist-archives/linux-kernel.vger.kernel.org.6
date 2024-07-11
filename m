Return-Path: <linux-kernel+bounces-249483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511FE92EC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036922820FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776F16C6A0;
	Thu, 11 Jul 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDzO5chn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sYt58oa3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C715957E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714099; cv=fail; b=FvmRIdWH07ssOkEoP8rkG6bxvvuKdjmg9XJic1ght+ogin4VsWEGafueMnZcfc7EbWROpihWGDkxTHJByN2uNFqlDXaXLw2B0dE57sE6k0nzabuEqNJnFbWjaiVU7QoIEe/MfipqUX9nMlYDrY2b0O7Wep7qTZDk9iX1gFYChBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714099; c=relaxed/simple;
	bh=YoqXIRkjJHQAo1I9GALjAY3goIqNflCowwlH8YUb7Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWsJuFooDF5EtTvI+suMka1kxqvuWhDR8P39oNwZ0X4ZcpzLrwdS4yvl0S1k5ETxhCRNsOOf0pKdlt9npod/1E1bTCCZMPgpbq+bktwfipIP6oXhwi8/lKyl8U0AD0YFRFet4AdwHnVZBUIWEu9OtZK+c06P8HZX1GvmgiMM5tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gDzO5chn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sYt58oa3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBWl8010292;
	Thu, 11 Jul 2024 16:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=65LBZ98KTN/gBId
	CP6QPUlYNRUaiz8yEAVIKkvAdTz0=; b=gDzO5chnGuU2Hslu1IqFSrQgae6IYhU
	y3npDoMkXPRrFrIjtTESo5GzxQHXULOcPxpiIiLK3agmULFCweg8mnHvgYJJBeSi
	0KnYLgb3RZUsn+9zZVWcJWXmC8jaBAdSMYm8rWIPVcIg2gICndLoEgujbovjmpSS
	7jIMj0dPbhq/p+ElJUlZ3xMXpttDbAxqxtukV1w/hf49wWURaOco/GZ6mzTKRSiY
	Dvnw0aC/2w/B+zh4K53Uoy22tjtXt/8/B0VjditqPlflYvYt6/enzWEE4jRm+1RH
	FkynXj64z1gvTbOSPC2UV5GPHKIWJcz9lm04QxGnvH1Cu3rwaQ4s1Tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8hwhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 16:08:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BG1Udw029998;
	Thu, 11 Jul 2024 16:08:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbfp6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 16:08:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0T221OinImPOcwpZxWDSVsnG5hamuDXVbu/PtxjFMU3D5drtmQiEQcTWGFz9aeqD62yfvVGRh9+KpubFZgumixmt1oCUdacSPFLcOnEWnQzd9iWVc+u0wCmfsPqzA1adTQztg4wyGMcJGLNvUTmBhopHvQ+CrmdzQxIId4tcLbb71ui9kjYj5wDuVg+fsLtKtXHF1iM/cbHxkr4y/UnX/kggVq9NFx4Vtw19A09eXYUiI2l4k+0kXXE7lsqT5EzxLjctUSLzwcnQfm+xZoSDwgrxkycAvYycjUMJQ1RkcR43Uv1dlHuqg87OUHS7vpHUPPxoZF4Vr3cDgY/LZzVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65LBZ98KTN/gBIdCP6QPUlYNRUaiz8yEAVIKkvAdTz0=;
 b=wEeRclwDzV2oN2bxSDDX/NoOZ4j8CZWWiWfTb1ITWqjAoYvDonge+6do2vnBw/h8IrdAssBPGL7q2zhHur4BXZPb2r38NriWfDeII6bw5Wk4mNFON+KPyQd+RuazSXEQ0LtBezSp2Dqus3qahhSxryZw//7T7vqE4/0F15hpy1StsEXp81pvC/ZW6tAYl8Ro3ipeHqeW4q0Ky+/VLoOXjj45WXlKvwck/V2U2sHhZOssiXv070Ipr0w3qSMS3HvJ9dRm2OuNAJckPyiKhGGC/Wt/Ej0JK51WskmmkuK8jRyBquD5VSq3Z5xRtk+O7z9FauWk8LOIjOC5QqrL5S4Qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65LBZ98KTN/gBIdCP6QPUlYNRUaiz8yEAVIKkvAdTz0=;
 b=sYt58oa3gPg+Xd58ycExoFzTxqOj82zaBqf/eA3asAperjPfkFBTKlSDIGqVm2F5nRDuKuqkQmjLz5yrRmdVMIoV/Btb06B/DVyR3jN2kpsxpbDOONsfNeruw1xlTPJqAyA05L+7PSOHXkTcMCxJpKgR+/nk/OpPsp8+CQuvZBU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7006.namprd10.prod.outlook.com (2603:10b6:510:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 16:07:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 16:07:55 +0000
Date: Thu, 11 Jul 2024 12:07:52 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <qjt7mjnwp3mwkk3jbvzickmhlutlgjwvpuy3z4hihkxjt4skbc@qoqxppownvxl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-15-Liam.Howlett@oracle.com>
 <6e29f050-89a1-4a7d-bba9-fc49c04292fb@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e29f050-89a1-4a7d-bba9-fc49c04292fb@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0452.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: e30c6e71-749d-4656-03b2-08dca1c3a00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|27256017;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PSaSnwyUKsxfsabDmgdoy6CeKBa5LtVOahCLfU3TQm7djwOLjX/9BLSzNEzA?=
 =?us-ascii?Q?DsCsl9v5F9bYyRhB1R0Y9yly3bF72ndobVXIy6H8c0fiZCTpbtBrsU5CWl3/?=
 =?us-ascii?Q?dmVP4klDL4MWWFNIzISK6C3rRehYA9Kz8NuDwsqKZfDB+qNe031y1WdQaVYR?=
 =?us-ascii?Q?t8hbVAntWWG1TVHyF0FLuCl2Wx2z0CEsjV5Kg+GVLFExoHczzK27IL8HOHg3?=
 =?us-ascii?Q?Zabti1DW2Wg8iueg0WhNKxuIxxl4UV78/YA9SJC36+bQNNzbfQYZSV1vKRyu?=
 =?us-ascii?Q?NFkLKCAJkuu7io06/QnApgWqyh9dipOstBpnZIFpZyqX172+bZc8LDEhMI+v?=
 =?us-ascii?Q?AZ0j9o5hmvW5EeOjm2HDFKGtqHX7Uiir/O4/g8IJrpEcAtI1Gv3OCzFUsm+r?=
 =?us-ascii?Q?E2L+DaRFAUkznV3Oa4CLz+hWB7BadMe/GVAzUjju9XndD+ojQqRdvXxjzf2f?=
 =?us-ascii?Q?SMdVfrDcuimd/R6j5PYJfhNtkth2xq6Et7hNnmgX/OvlXZp5mC9gxzsNM1sQ?=
 =?us-ascii?Q?TnwYAOQXCMe9w33y/DXes5xXokTdakCzkpImRyozl4xE9mwB1x2mTaGwI7Fr?=
 =?us-ascii?Q?uHOGOEOVrJDnPfgYjhrwH4KPUaellNtntO+eqfGSxTgBHy8rWH4CttqUhQk5?=
 =?us-ascii?Q?XmEjtqroUOZbqUYLNMAq5qAcjwhLL3IrU80cIVvVPtsFnytzA9xy278ehRgO?=
 =?us-ascii?Q?uEBiyfP1QP2ln/2XjLPXEA4MrGuPrSmlPdwAlkF+Qev3EyewSvHk+Z5k3U5B?=
 =?us-ascii?Q?4K5dmHeLRpxi4U8V82rqtk6/OeD/poxOGlIIMhhOm8PijcmR/LNpzPTHsYjI?=
 =?us-ascii?Q?cNc36GR3gx+itEbwNMJkhysgE0TM8Ziz0k1xXUJKO+LwccI55LiFjWiNM+iX?=
 =?us-ascii?Q?YfjrDs7ZCZ/1NhzcWF98zEJ3dy1cRYeObmwnir07jDTu8/i884wNbrs1OvXC?=
 =?us-ascii?Q?cSTxQ5PqjStpIu9GqOyNqyvBXe65dwZZU0PmcWl+DwcICAH/scyQ/6gVXU2s?=
 =?us-ascii?Q?3yBKUL0cB7JlrKxoqvkCJNhFpvgS+xxXIZXs94EZ7eFz2U3Sl4z9GbEsYK1Q?=
 =?us-ascii?Q?qkje6vggBFxnLjPZfKQ2hkZUB6OY9DEG7Diygx6EyaFBoCUBD10uaQl1vzLU?=
 =?us-ascii?Q?xPmjKxrkCSRCZGRzKzlP9feFxbfutZzddT4TQBLIXu70sOmnMn+Dk4L7dtvg?=
 =?us-ascii?Q?iGOgINJVc9sh8BvPYRv6Pc0lbNy4vraruV2E7b0vJ+KANX2+5JsaT2S/BNQa?=
 =?us-ascii?Q?hNGFJjybDh6pjNkpAkH3nrh4mh/spaCzMLxcG0u2qA8kdgld8AUWkUpRX6bd?=
 =?us-ascii?Q?gPFdfAkvtQhR7NV6WswfKa8fvwlxgT7qPzAgYlCMdFauRyVzFA17QglOyT0z?=
 =?us-ascii?Q?FPu8PT3J+fI1I8NzwCnsdt0Atj+bIxwE1GuhJvHRxAemHXh3tQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U3xvDbDtDi8Zauwy1KGBLMMZeVS/5mWw1VxiBiKH5SAXaOfHW76r3gM7PZtp?=
 =?us-ascii?Q?7QcCjvdKywSY4Sv/mvZufOg5GAARdbpRr1IAU8MHMgaHEPJepuCLsL1jcuK4?=
 =?us-ascii?Q?Ei6Bgxsb9SwGXmVhwZ9xX7G8bQyOYLsbO4LWe5/EkfbwBFPpsntitPK/zUsC?=
 =?us-ascii?Q?Yxfduv3IkpHuRIlosCrbDpJ/fjbg7ThJa+1bNzlhP6v2BU+67CBpShGGIDE0?=
 =?us-ascii?Q?ZnpO8+VfpiQJTs/NWqhaEnFqfaqOO//90LFJ9H5PuuXW6RyhxHkttGrkr4gC?=
 =?us-ascii?Q?xwXqf3pCBgmWSrTy4zoEs3YDDdJrmNloC7uVyMnog/SC0zZquEOQO5RNHpW1?=
 =?us-ascii?Q?nmmDwjX4UnLx12WLO+Y8+aCWriK+THr+Y8YJufA0O/wJoAvJkHqk3y7G2Gxf?=
 =?us-ascii?Q?Rq/gyMQ1/CEzCXdBLiCns+GWVq20lA07smLeKTOLjFjC1ydgrls0WjD7YXYM?=
 =?us-ascii?Q?N50xFbI+WHoYgtUMe+3Bj/BpBTrG/kfUFChjLp0bZtWOp7i2ISbOHjOAXhye?=
 =?us-ascii?Q?KerDhsvqXcOanZEdNzWmOzmoMxa90BmbxpO9hr9bIYtfkFGp22HDgvd/qEpy?=
 =?us-ascii?Q?5nYLmaU+VYFTaMwMELBn8HA6ZlxyC/cA8g2iG1ockPRk+Of5nFxclWZJnYmW?=
 =?us-ascii?Q?7SOfq/8SibVkxE6Kxv/OntCUSMh8luvA8ruRPBFljS8h1QU1baHlKRMTTaV9?=
 =?us-ascii?Q?eS0mCufb9T9EyXK6tnxMPHOOe7gKzhfKLOxPxz4yYU7FthL5nL0sWiWuHR7C?=
 =?us-ascii?Q?ywqKNQmbLhd80TfIAfdMkdmjuwEaBDwdPksIKhKdrlg51haQMeD5Wb6as5vF?=
 =?us-ascii?Q?RyfGjZmsvfl2NtZFfsF8Zka1JqU4SkIOh7J6kQblAcrRoZ23NPOXnl0RqEHk?=
 =?us-ascii?Q?cetSP5a7iGLrb4fxBzAH/XcrMkKrhtZXCINaHDAggHEav2XuSH7YCaRcAS33?=
 =?us-ascii?Q?tXzNCPS6Qq/j3l1f9V4UKwj6rIMRbE2lXQGJZXo+tgviKmUWcEl+Ulvl2AXC?=
 =?us-ascii?Q?q2LkqL5MRacxE/UUafm5p6Ux8xE+ZAXfSfbK9pZv2iDjP3uzbWXVVRP66wqV?=
 =?us-ascii?Q?O76SDQqlGvFILxzVGbM1YL8bTPFEqgYPEqswfzuSAY/940W1xbSp955C94Ag?=
 =?us-ascii?Q?wOhvdeBC9yXwzz/GpuvJAk2vv0birxg9D1oR5LHD5pzofqlHqAjaHY+mXlYu?=
 =?us-ascii?Q?JS+bamfJSv+jJgamuX3J8C45tb38sBzoKjxn6v/L6xU5eA5tTF4wHqFF1SAs?=
 =?us-ascii?Q?GssOWkCHI7Nkj6M7f90q02ROIQUqTr3MTx4gcneTgjn0Obdt37QHQUCAARdt?=
 =?us-ascii?Q?rL3JBBP5UCF08CArqDa5B7kOscu3J4dxujPHxyoHTm2ajyaWIdtP8XpNXBIT?=
 =?us-ascii?Q?+6kPBOvsXZE3ef5cMMlMEq+qNGDMm8dMkCk//Ns3u/HaDgbHhKWMJS5wFNLI?=
 =?us-ascii?Q?z7G+Z9dg996MGneM9pG91Q3Tnk9u3ODYHLNyN4k0M3ImW1DB5a6U6cJb2iRa?=
 =?us-ascii?Q?2iLHnH+EcFC2A33cVS0dLUeyiNJMYu3d9chNKBQAUSudUWpgLLbJnyAuFlnJ?=
 =?us-ascii?Q?pszpa3X1ipxLSx7xltB+lXx+A4MI0Ro+WanHWM8MaI/Fl2oQ85tgLm7nG/It?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ztKfFN/MTBMptS1NBBbWprNoVWNMiHeROFZNwEcGGD4jrRIyffTVczzkj9FBX+njfa5RZ4Kr3DqhLvxYOwdWGSxIy5Tw7uFuHRTGHTaJSyNxV4EWUVDqjFcoiB6HaIWgI3jb2XaT5zYYKC3lm68oTJGsjZDmqLbk2VvPPDZSYVnCq8Zkm5cc9bLH3DO3ekB0OaJ9jQV35JmJFcHS/CuEuXtjXD765m3waVgJOdBSE6JPm7FIcCpsHAzBf0UfuR+5kp9It/Bfi4pHrzkE8HZKjMhUBnumS5uYAV41zuGrhb0UpX6C7DcWPKirqk+BWSnI9RC1Rlp/TutkljZqHuMfgeczkgvHcD/d8MDGaayRL2ITgXg1UHKxL0rWIJXmYOwBBuDzB8zPQDG4PMs+xtXDqv2ZPZTneZ8AIuJ46j+1dQHZAsTq+Fq8qW5JF0Pq2IFdg84bS20dSH/ykDv32iBeF2ReDpQP2eK6kTLaDLMJHHzvBUOlOI6NCl3K1rp8CDi4fI3RJUUnAxuBNmFC8DTQN1z97GARciaZ9j8B8BK31DDUVJMFU8c31zGkw/2FAq9H5H8kp8bKjblUSKuxcmivz6RlQOmUTFq76xYStqejxkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30c6e71-749d-4656-03b2-08dca1c3a00d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:07:55.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3RqE3m5guyev+Fz1EdmsneBHjzrQF4lKGxPZ3kI+IT9WxWtVYUu7JzdDF7Gp/E75lznOFUZAAdcsGOkTLQKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110111
X-Proofpoint-GUID: h2jW2tA_lWYsmQkSSyAW6c-_-vj6t3GO
X-Proofpoint-ORIG-GUID: h2jW2tA_lWYsmQkSSyAW6c-_-vj6t3GO

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240711 11:25]:
> On Wed, Jul 10, 2024 at 03:22:43PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of zeroing the vma tree and then overwriting the area, let the
> > area be overwritten and then clean up the gathered vmas using
> > vms_complete_munmap_vmas().
> >
> > If a driver is mapping over an existing vma, then clear the ptes before
> > the call_mmap() invocation.  This is done using the vms_clear_ptes()
> > helper.
> >
> > Temporarily keep track of the number of pages that will be removed and
> > reduce the charged amount.
> >
> > This also drops the validate_mm() call in the vma_expand() function.
> > It is necessary to drop the validate as it would fail since the mm
> > map_count would be incorrect during a vma expansion, prior to the
> > cleanup from vms_complete_munmap_vmas().
> >
> > Clean up the error handing of the vms_gather_munmap_vmas() by calling
> > the verification within the function.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/internal.h |  1 +
> >  mm/mmap.c     | 80 +++++++++++++++++++++++++++------------------------
> >  2 files changed, 44 insertions(+), 37 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 11e90c6e5a3e..dd4eede1be0f 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
> >  	unsigned long stack_vm;
> >  	unsigned long data_vm;
> >  	bool unlock;			/* Unlock after the munmap */
> > +	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
> >  };
> >
> >  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 870c2d04ad6b..58cf42e22bfe 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> >  }
> >
> >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> > -		unsigned long addr, unsigned long end)
> > +		unsigned long addr, unsigned long end,
> > +		unsigned long *nr_accounted)
> >  {
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> >  	unsigned long nr_pages = 0;
> >
> > +	*nr_accounted = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> >  		unsigned long vm_start = max(addr, vma->vm_start);
> >  		unsigned long vm_end = min(end, vma->vm_end);
> >
> >  		nr_pages += PHYS_PFN(vm_end - vm_start);
> > +		if (vma->vm_flags & VM_ACCOUNT)
> > +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> >  	}
> >
> >  	return nr_pages;
> > @@ -524,6 +528,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> >  	vms->unmap_start = FIRST_USER_ADDRESS;
> >  	vms->unmap_end = USER_PGTABLES_CEILING;
> > +	vms->clear_ptes = false;	/* No PTEs to clear yet */
> >  }
> >
> >  /*
> > @@ -732,7 +737,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	vma_iter_store(vmi, vma);
> >
> >  	vma_complete(&vp, vmi, vma->vm_mm);
> > -	validate_mm(vma->vm_mm);
> >  	return 0;
> >
> >  nomem:
> > @@ -2606,11 +2610,14 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> >  }
> >
> >
> > -static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> > +static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
> >  		struct ma_state *mas_detach, bool mm_wr_locked)
> >  {
> >  	struct mmu_gather tlb;
> >
> > +	if (!vms->clear_ptes) /* Nothing to do */
> > +		return;
> > +
> >  	/*
> >  	 * We can free page tables without write-locking mmap_lock because VMAs
> >  	 * were isolated before we downgraded mmap_lock.
> > @@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> >  	/* start and end may be different if there is no prev or next vma. */
> >  	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> >  	tlb_finish_mmu(&tlb);
> > +	vms->clear_ptes = false;
> >  }
> >
> >  /*
> > @@ -2647,7 +2655,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	if (vms->unlock)
> >  		mmap_write_downgrade(mm);
> >
> > -	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> > +	vms_clear_ptes(vms, mas_detach, !vms->unlock);
> >  	/* Update high watermark before we lower total_vm */
> >  	update_hiwater_vm(mm);
> >  	/* Stat accounting */
> > @@ -2799,6 +2807,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	while (vma_iter_addr(vms->vmi) > vms->start)
> >  		vma_iter_prev_range(vms->vmi);
> >
> > +	/* There are now PTEs that need to be cleared */
> > +	vms->clear_ptes = true;
> > +
> >  	return 0;
> >
> >  userfaultfd_error:
> > @@ -2807,6 +2818,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	abort_munmap_vmas(mas_detach);
> >  start_split_failed:
> >  map_count_exceeded:
> > +	validate_mm(vms->mm);
> 
> I'm guessing here we know it's safe to validate?

verification in the gather state is always safe - we haven't changed the
tree or a vma yet.

> 
> >  	return error;
> >  }
> >
> > @@ -2851,8 +2863,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >
> >  clear_tree_failed:
> >  	abort_munmap_vmas(&mas_detach);
> > -gather_failed:
> >  	validate_mm(mm);
> 
> Additionally I imagine the gathering failing results in the tree being unable to
> be validated?

It is safe, but if it's here then it doesn't need to be above

> 
> > +gather_failed:
> >  	return error;
> >  }
> >
> > @@ -2940,24 +2952,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> >  	pgoff_t vm_pgoff;
> > -	int error;
> > +	int error = -ENOMEM;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	unsigned long nr_pages, nr_accounted;
> >
> > -	/* Check against address space limit. */
> > -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > -		unsigned long nr_pages;
> > -
> > -		/*
> > -		 * MAP_FIXED may remove pages of mappings that intersects with
> > -		 * requested mapping. Account for the pages it would unmap.
> > -		 */
> > -		nr_pages = count_vma_pages_range(mm, addr, end);
> > -
> > -		if (!may_expand_vm(mm, vm_flags,
> > -					(len >> PAGE_SHIFT) - nr_pages))
> > -			return -ENOMEM;
> > -	}
> > +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> >
> > +	/*
> > +	 * Check against address space limit.
> > +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > +	 * mapping. Account for the pages it would unmap.
> > +	 */
> > +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > +		return -ENOMEM;
> >
> >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> >  		return -EPERM;
> > @@ -2974,18 +2981,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > -			goto gather_failed;
> > -
> > -		/* Remove any existing mappings from the vma tree */
> > -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > -			goto clear_tree_failed;
> > +			return -ENOMEM;
> >
> > -		/* Unmap any existing mapping in the area */
> > -		vms_complete_munmap_vmas(&vms, &mas_detach);
> >  		next = vms.next;
> >  		prev = vms.prev;
> >  		vma = NULL;
> >  	} else {
> > +		/* Minimal setup of vms */
> 
> Nit, but is this valid now we use the init function unconditionally?

Yes, that needs to be dropped, thanks.

> 
> >  		next = vma_next(&vmi);
> >  		prev = vma_prev(&vmi);
> >  		if (prev)
> > @@ -2997,8 +2999,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 */
> >  	if (accountable_mapping(file, vm_flags)) {
> >  		charged = len >> PAGE_SHIFT;
> > +		charged -= nr_accounted;
> >  		if (security_vm_enough_memory_mm(mm, charged))
> > -			return -ENOMEM;
> > +			goto abort_munmap;
> > +		vms.nr_accounted = 0;
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > @@ -3047,10 +3051,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 * not unmapped, but the maps are removed from the list.
> >  	 */
> >  	vma = vm_area_alloc(mm);
> > -	if (!vma) {
> > -		error = -ENOMEM;
> > +	if (!vma)
> >  		goto unacct_error;
> > -	}
> >
> >  	vma_iter_config(&vmi, addr, end);
> >  	vma_set_range(vma, addr, end, pgoff);
> > @@ -3059,6 +3061,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	if (file) {
> >  		vma->vm_file = get_file(file);
> > +		/* call_mmap() may map PTE, so ensure there are no existing PTEs */
> > +		vms_clear_ptes(&vms, &mas_detach, true);
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> > @@ -3149,6 +3153,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  expanded:
> >  	perf_event_mmap(vma);
> >
> > +	/* Unmap any existing mapping in the area */
> > +	if (vms.nr_pages)
> > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > +
> >  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> >  	if (vm_flags & VM_LOCKED) {
> >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > @@ -3196,14 +3204,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  unacct_error:
> >  	if (charged)
> >  		vm_unacct_memory(charged);
> > -	validate_mm(mm);
> > -	return error;
> >
> > -clear_tree_failed:
> > -	abort_munmap_vmas(&mas_detach);
> > -gather_failed:
> > +abort_munmap:
> > +	if (vms.nr_pages)
> > +		abort_munmap_vmas(&mas_detach);
> >  	validate_mm(mm);
> > -	return -ENOMEM;
> > +	return error;
> >  }
> >
> >  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> > --
> > 2.43.0
> >
> 
> Other than nits/queries, LGTM:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

