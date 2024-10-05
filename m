Return-Path: <linux-kernel+bounces-351807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E699164F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D2F1F235E3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34BC149013;
	Sat,  5 Oct 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ErqPK3sk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q8p8G9Z2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC414085D
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728126710; cv=fail; b=X67Rd79OGe6/uA5+8kLAq2N98CZaXL9Mvyrs+rsSTLYRvaX3BBZKucaluv29jUx4Dtft7qBYYtIkljzAGXNo52lb4mPAQXHWglOmGqnDTmKufo4c1gUzm5dsVNNlkPHTCZ4E2dvWbPLe0n50bRqPT2UrbX2T3AEYHPKGXV/Dg34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728126710; c=relaxed/simple;
	bh=3kXvjkIRAkN3cmeX/lESG6mBTe4lPsSchAi6v3pmeVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTNRzi4WyWPVpTxxUgZ/OvCX7NjyuN9KXvEDxLIdj2FvRop7EBlqUtf3i18Wm+SYBTY15MS7Znvnk/eh9bMY2hp4jTSi1ASMGcemVmW7yuZjoDM6IRGoVf4CZqY7HitpaSoEU5fFu7YERt8fUItauYQGni9W3oZ9jxyqdu9VAPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ErqPK3sk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q8p8G9Z2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4956JhTY024979;
	Sat, 5 Oct 2024 11:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=drR0hCzNsz1DBgYdn+
	BOxRJHIbj2mgmxanOo5ci8T1o=; b=ErqPK3skzN8/vjZcPjXgq29r25w1+glA0j
	1n2oDHodgoGjI6N8MstLAfSWIVEZy+L1ex35R6WyHNg3KLPNKi50RptwjyPO+EvI
	X3MT/dQdKmrJzCvhkokZw/G/Zhv1pVHOZ1j4Pq8cz6LC6frZkjWtfNLkqcBG3N4l
	3vu8R5F/gOsOTFacfdTiVwipK47HaPRSB39Q1nHQsdn2bf+ZuGyeIxiU5t56fGTV
	s3mk+tbb2b04hbQfA1F9+Nd7gjWse9hWvGNc/pCN9B5++hu9ANI9+ocVLIUxO06r
	10NLIIoQC8eDDWuPq9cG37yD3069wPAte0EACXKMfTWGXF225Evw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302p875f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 11:11:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495AedDY012634;
	Sat, 5 Oct 2024 11:11:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw48pn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 11:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1ThRy9/+Q4/2o4A/WikROBJ1j53iSMOPoAfOcejH6wHRIsZ18smh5UQIaz4KjAemdZf/+FYJRsfDDqvthkI44zDZC765BVMehOodWbkTk7lfMlJDsnNWa808pG5Wt+reKxUplbsX4xshkB4wjfcqUwQG5tYSej7HEkRfUAL5/vl7CJXu2wJs1fCD9RScbFTF386nb18ySwBtKqXB4OraaOOfZk92x/kRFFPprUCTxDTq/a1cTDj8SKHA4L9cWA1ggor2LJk+K/cqu+gSpO/wVV5y/3nwz4eZMw+FfRG9ScPFx72vzii4QcS+WCnA4XDf/E8SFiMvnl7tRP8KyEkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drR0hCzNsz1DBgYdn+BOxRJHIbj2mgmxanOo5ci8T1o=;
 b=ZCTadgPOnZjyEMrow7SMX6iOfOZypLIp69kue88KJLYUu/9YSlHhUlYBls1HS+jS3FtOoIMVmdwUsh2W2yZjTC0+HbkVgHUzMTLmnxhLpCCMFj8Ix8GbihVgnMTiOA/gB+GFxlJRK5Ylw1us5PJdtPwx6pwaknmi3JaBgcK6757NekNIGlbUC1eQzbe8Kh4XS/iyQ+IpkWjLvn6q+g8FfOZjOc23ZcSNuhpTQQYK4t0GZqhfrrVl9jhHhV1VuBGMaYEtal72Gdf9epIkXsazTrKZ+gugzKnN89sE4e1wmrdulxOQJm4qEG+1vUaNjptbQlggz1n5iu4eTSvzwN8gWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drR0hCzNsz1DBgYdn+BOxRJHIbj2mgmxanOo5ci8T1o=;
 b=q8p8G9Z2DyU2tqMJNfsQ3VTV+gZCxDC2gYr+aEVpWK7YBS2/2O7G7M/vbhq053jIqzS0tFsPHqvElL8aj2Rb+mna4AYJpjbWIcDIzweEq1Q02Ei890g2mNMdrirxJSHk1TW5oDtpXvGtd3XLTqfd+IpRiyNHdvsNJF6vJuie1lU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 11:11:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 11:11:39 +0000
Date: Sat, 5 Oct 2024 12:11:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <2394412b-3037-4867-b16e-f155740d062c@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
 <3b83746d-b73e-4b89-9b74-5aba5a827f45@lucifer.local>
 <088a3541b85b783ef68337bd4bb790d62f200dfa.camel@web.de>
 <9e1f326d-7740-4f4c-baf5-45f9eae0048d@lucifer.local>
 <4bf6139bed2b7ed04ed0b599391dbff9272d33ce.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf6139bed2b7ed04ed0b599391dbff9272d33ce.camel@web.de>
X-ClientProxiedBy: LO2P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::35) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2f2f61-74eb-427e-c112-08dce52e7be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fzw6ezcGPt/UoBlx6INLIOLd9tk5DnxQHuC3vMuq6HjELNRPmlNB8pbnkBc5?=
 =?us-ascii?Q?vMUBUmbb05pICwBJk1jRwP1PuxA6RZNCSnZDEHjGCuWv1xLODayrrVXswjH5?=
 =?us-ascii?Q?Phlk/cvJVlXQBQKub0GYExCqF+2LRTAQqwknYJRM4XmAW16Wkj8w10ifQCn1?=
 =?us-ascii?Q?bBuUa0wi25P58C2jBbkMvddMoPCS36Yv8MVG1B7dWH5oUPTPqh77ATrTLjni?=
 =?us-ascii?Q?ulrPdOXHn/EztsngOdsngcIBmbHKW1iO426GSQS4cbdI8KuSvlaRQ/u+JH+H?=
 =?us-ascii?Q?RlIZBJkeqvAY/itndOvK+BxqPkhhiBf2/he8oY1AFSplZZl+Q3Mdu8PoSnJg?=
 =?us-ascii?Q?CzDe5kHudhF5PksVeokD+upHM2fuA8wvFk9cB1FqiktOquNDz7tRXgN2hUsM?=
 =?us-ascii?Q?Mq/+FKJwzz18dunwsXCxUdizMCJUW4eo9HaOLUVoSqXSYubtqgAZJEFK7EeA?=
 =?us-ascii?Q?Aa08P16LJjEOnVJKVTMFez8Q4f/0Tp9irYKP7WC6/PqKXOQ4YY24sl8xUkEn?=
 =?us-ascii?Q?eurIzzxUsHwsSfUu8F6ojrlWtJTBfkrh2MD5qzPTTPVkyPy5QwtN7fZ3qnv/?=
 =?us-ascii?Q?lBpFn5kT62Z+Xw1VzokzT/NGF8/qI3tsVaJHO01pn1F0tuEukOdB+uY2OLGL?=
 =?us-ascii?Q?RYiWnR78ogJ3bN3l8apMcIt1Se3jSBvzZQ6x3gr/1WJOVSLc5vCYfXPmFiuI?=
 =?us-ascii?Q?6tRKECgjnbdGtxuh9Q4xjQUPxKkXTQY+bk+lA7U5Rd0YpgwNSEitdDHJmYIC?=
 =?us-ascii?Q?UtGVgrXxBWQ9x92+3WLOT7ni0lV8xKCwpOyNaBoKTLAVq+RxvSzK9drYXmzg?=
 =?us-ascii?Q?VClYxGBIiGWLVrAgvxE/5Sb+btW1DYSTK9RIhOFbiZYdduCBXEp1SJce0C5J?=
 =?us-ascii?Q?GpnCmEs9TTy6TjLzPz60gtJb1mrSXdvsaAsvBzOJ4sAaufZffaUtIE+iXpR7?=
 =?us-ascii?Q?3Gp9g6WEmSTPaa6nTTtGB5DOjakbf1Pqcvsjzl/W0hxJC98TEAQbTNf1SFc/?=
 =?us-ascii?Q?abwdN+jhlrdf2v9Ar1lwGVMRwkjtdBCs2E/Q0l5ig3ArNbvyo4IUMc2Cguf5?=
 =?us-ascii?Q?c7c3W1QV5uEhC0k6DCHAzoOtu4rmiOtF9XThqL54ulz4LNb2A2mcqPL44VF3?=
 =?us-ascii?Q?rsHtiEGJKuxN4gKSJQ0Yr73A8ZwEdILdVCq5W5AYTTb/8bbASCn2ftGaXhlp?=
 =?us-ascii?Q?rbfHzvjP4+/0MYGbFxQn5gaxRN784W//Tn6SgMw5u0F1hEzTsGYlZo59oBXi?=
 =?us-ascii?Q?24OsSOvgfQBPvCyUiIqYCSufEiP4TrxlIRXWC1zLrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5epmbntwMzBFoBW91sYva29Onp3hTag6+UxBCtcUf0bNlBFP3ad7P9f6z/P?=
 =?us-ascii?Q?0T8OrDgTSyJspRnZqtBVpq+aK67pJLlRQm21cIswGS8uKDobdQ6UTaZyTjqn?=
 =?us-ascii?Q?iZXTDxpzNddB1edVrQu1iVsF10r1iMVykbugi1jbBIFjVk3HyzJpzBX1NGkY?=
 =?us-ascii?Q?0U4UfqoCRguoFE1Lsx60ujbD6HdU+IL2f1ifMDowPhm5EZ1ec7ou+viD0z6g?=
 =?us-ascii?Q?ZsIDGEMhE3FTI39ASkTS6/bHKT53mM6d1tZfZWtdMNUOM20YdONKP3DM5px2?=
 =?us-ascii?Q?v//xudtLyuJlwjCJHmZ16YS7Y/XL+BDB3XA/yYfslkiQat+HGV65n15lKQab?=
 =?us-ascii?Q?AuhTjOqUYWw05cCVkAWugrW90Eyr9EnI6WUge9KfddOKXmNFe2e5NbAlaIMr?=
 =?us-ascii?Q?ZYJDzws7PqwfLBjSAKUyQMMlCqdevNDUSQ0hricDR4cFl09AHnEaPyraKHax?=
 =?us-ascii?Q?OaaHLLBxKYffMwIGPQKb4EYdzrJh0eLbEOzZM6mApL6yM2PtFST+ztaVAo8d?=
 =?us-ascii?Q?I976hp8cgBdT0r9wnJJxwiK7jKF2HYRVsQeU2P24RArJyPobPBckavyKGY3t?=
 =?us-ascii?Q?SX+i8pv0jihZt8xy0alcoSBrWcXszOEDo0GnsAom3qx1A5V9+qvPq0sjXBiH?=
 =?us-ascii?Q?UB/ta9iEPS0xbwcwikA98J1mmSGlutCDYWsOuA93RQVCJAChtE4xx51Adl5v?=
 =?us-ascii?Q?UHbt2itHMaoeKo+P4UTzhVrMVerdlTa4pXpLHfOSp3SgcXhWaSpbXRD7hWGE?=
 =?us-ascii?Q?yfr0wfRaoUqjnhOBL2EEryJUE3wU+dwOfpkw2Q1ZAfO/iUe+tWJAnzaTWs+Z?=
 =?us-ascii?Q?sg3Di2eQndO2ffR5TqcuUKAGLmZ0AcqsG1NSrR7t95PQXAO4CsbNNXo1MbsX?=
 =?us-ascii?Q?KXlBY3RNU+0hShOplRo/kc9ojYLR2KCgDFrioHTQ8RG8PCoi/3YxQr6F26l0?=
 =?us-ascii?Q?uF4frH66BtBFcAiCTOk35XYJekbkBJfz0Q1PR6ZkBJFqyu1V5vXOphHKLa8v?=
 =?us-ascii?Q?KngA+jIXPZN8JwENv/6jsDP1b5p7uvbipCXKQ7jx0zqW4kkvecpaCGtEROqe?=
 =?us-ascii?Q?PNfSiKtADlixMhNX8qWqkUL75lEnprUodECuC/Glg/eTjzhfEo5F0ISpBvS5?=
 =?us-ascii?Q?LIyvnnw7xi++5gyyUe+eyaORTljp/0Tdq2K/ZIw2ouBHWqhZ5PHheyKPjJjU?=
 =?us-ascii?Q?6M60IhLaIiokZsLRRhQB7don55TKIwtaf2vdNRw078+t1ChIl1QyhhLLzYBG?=
 =?us-ascii?Q?fKfkBU1/4rYvUhdljobS+mkIdpJZ02WPdg8uMzbm4CYsl5wwhiPmtaImuEoD?=
 =?us-ascii?Q?W1AKoKCM5wdGwNnbXJcuq7iiteM8M2GvNPigcL0UWXz6GMUHyxtnOcLsH/Q1?=
 =?us-ascii?Q?x8mcAqoA3sZABoOmIOe8Z5fkx7MMH80XMtzy5rC2txmwkmwC//RP0Gsfgf+2?=
 =?us-ascii?Q?vLI+mrWIubvADxdQAsus7F07VhiE4W4bKr0vBVFKZj337lLp8U+XyGYXq3YX?=
 =?us-ascii?Q?r5J0OG1t22cslSZe45injq1T/W79V6EfRwjWyJVC4hQs7YlKpSbZCFFd1XYQ?=
 =?us-ascii?Q?FmcF0Hj7mS4eldiWEiASoAKXv/qoMOkEkTK1NWzGYqAXdx5EqP/k/Y/wLAfb?=
 =?us-ascii?Q?zJSZbXi/QmCIO7K3xR3bduJ/eDBhIzbH2KEmu4pfPO+TDRFUOvgbdB8z2UaO?=
 =?us-ascii?Q?MtFy9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HyOqh9gRwPFxtMUu215q4z0vTeiYUkj02cixtMr3onD4z0K8kEBXrLSlR5iCSacK4rM9IGJHyQKFkdzcjbhga8kJZxHjsP+9hDxOuKTFL0gfgVivy1p3S6gzYj0ICSyMRM3a+BnMcvTdknlbyMQm8Pwnmo1xw9gp8FmrbQu63ya/co1tspl5jHMOSRj7KF/LOWDk2NY8auE566DPjLYC4nqaATZp7/dcZ6V63xwffszlMAGrerCrPg2V2wVWHhmKvKjEi3nIeQgga9FmPY7U40JsUDBYhioW30VnEdARGXAEsOo2HfXqOpaTo3yvo7fSdGAHyLmgzemLnU5nE/nmigWekdU2fLEFgRgi8clbcMYqpq4Ti/wzxbiGlzl25CcPzy0tKO7wgR3VaZ75Frc24DO9/kYGe5vfENcs7FBv2IvCl/RI8h/dt//05T1pxGhRkOoCIO1lE/3Ld6dpYD+wm5AUz/eK73c+9O8zuQoGNmRAL9STPwRZeuoLjZLpYMBVj33KEKAA6svFDeVlV32B4tBU1DTyLDveiJUsmd7k+4x8/vV2Le0+0rYFhTu2gUkzLJvuRaMBYh5QxrJ2Cpoy6bS7/Wqa1bXrk6iepkW3nhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2f2f61-74eb-427e-c112-08dce52e7be3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 11:11:39.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5B9+P4UcZu22OipnedQ7r00tCejtWxDAi0mpJlFRCf4XqQihqEDo3DKpfPe6+Sdt+PslPTn3fg78/IHkxo8/gXb5Iorou8AHYlXwB0xkUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_09,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050078
X-Proofpoint-ORIG-GUID: 7-CqWCZqAHB34lzz-pc3NzwI2DOPebuA
X-Proofpoint-GUID: 7-CqWCZqAHB34lzz-pc3NzwI2DOPebuA

On Sat, Oct 05, 2024 at 10:57:59AM +0200, Bert Karwatzki wrote:
>
> > >
> > > I just tested this and it passed ten tests (i.e. upgrading the proton version i
> > > steam) in a row.
> > >
> > > Bert Karwatzki
> >
> > Perfect :) will send the fix upstream then as a hotfix for 6.12! Thanks
> > very much for helping out with this, your help has been absolutely
> > invaluable and HUGELY appreciated.
> >
> > Cheers, Lorenzo
>
> I also tried another debugging patch:
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e6f0da908ba7..35b0fe3e02f7 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3773,6 +3773,8 @@ static noinline void mas_wr_spanning_store(struct
> ma_wr_state *wr_mas)
>         /* Copy l_mas and store the value in b_node. */
>         mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
>         /* Copy r_mas into b_node. */
> +       if (!r_populated && r_mas.offset <= r_mas.end)
> +               printk(KERN_INFO "%s: avoiding maple tree corrution\n",
> __func__);
>         if (r_populated && r_mas.offset <= r_mas.end)
>                 mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>                            &b_node, b_node.b_end + 1);
>
> and when running the test this prints
>
> [  293.477904] [   T5720] mas_wr_spanning_store: avoiding maple tree corrution
> [  293.480202] [   T5720] mas_wr_spanning_store: avoiding maple tree corrution
> [  293.482087] [   T5720] mas_wr_spanning_store: avoiding maple tree corrution
> [  293.484786] [   T5720] mas_wr_spanning_store: avoiding maple tree corrution
> [  293.486644] [   T5720] mas_wr_spanning_store: avoiding maple tree corrution

Thanks, interesting it occurred repeatedly...

I suspect there are situations in which this kind of corruption can occur and
not be a problem too. Nasty one all round!

>
> in dmesg.
>
> Bert Karwatzki

