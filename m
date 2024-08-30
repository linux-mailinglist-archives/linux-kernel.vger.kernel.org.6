Return-Path: <linux-kernel+bounces-308018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C17965622
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EAD285E08
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567D14C5BA;
	Fri, 30 Aug 2024 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1nuX0OQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WOGOJekv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFF14C59B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990515; cv=fail; b=Wie3KNZ7DSDsuB2qFZhXZNlbSKXpopBD0JJBrPSZaahBjjlOw7iwFTADAqzLj+kVXOpp9cQMOlJ78jpEWiyysa3rxe3OSxH670oBlzM4IM60vNyaDj5DbV+j11EEB9fY3cABmOasaUnTZT8EBG4oiitWl5gVC9TZ98lPllZWmQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990515; c=relaxed/simple;
	bh=vu22OMbGp7avSkj97Tt16jI+J/mjSJ8DQEcWhmLxKNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rt1aa7B8MzPp4Jys0W2UbSCkHApe3cVKpptagyu+yNxaAAqhQh1pPeoSB2FjRb6J+xi9WVnSbbAobmv9f6Jl1b7vtZDIwMc3dK7ywu2TX+hTqE1f5uAr4l+Ih8gbjN8fF6OQGOEvrGIedwO8Tzb3qfw9Epctx9Ysc1jfokAt3Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1nuX0OQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WOGOJekv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fV0h022842;
	Fri, 30 Aug 2024 04:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=76Q2ukEjjb0hEfT086y7aNLQ+jQfS3rZu8flZm0AWsM=; b=
	g1nuX0OQWE4Gh2cbdG7TS4duqWOKl9E+eRv1X6cHJ85+LCYxu6/+Uc+oDKtDRxP+
	y2LS7Od4xquAeocczc2inybnYt9l/GFkSizHW89HaXHZygT2iw9XFuGKrzKZEdML
	F4Vgyh+UkGdXNPwYKqDOPudwpZQPvrh0QPV/XldnDpJRANvdeUD5icGtKPXt11xF
	I0miOZX3CXOrgnC5RPtSpZlaXf+jarkP2j1lm8dotsHPkDyC3GRZIyvica+IexUy
	Qpgy8/fb0b+E6wwfXnAEAS1DCI/1qdbiAmjbx4TuVpYYfNclmI837FLMjDbC09N0
	FakENgSS2OpS2wLSPKQcNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b28508nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3hBLY016852;
	Fri, 30 Aug 2024 04:01:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5vy50m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G//IAJ2oms38khheTgJTqN9wmmcF98bsWcz58NRX/O0lwl6qh+gV6Xu0yLiQxMnCLz/7MH1uoEpzO2Qw4EemAN72bc0hYigRDZZIVbADQR6oG8ICnwjj/h7Y1xqrnfcsq1NL8eRGJFI4zzlHtpaG7aUAFv/gvFfOyiPtDvCyrHyZpYBvYeai7PIY5mb9ygc6iGmrmamLlg5QDXiqeMqHvNnM86E0+oz/mTukU6VBum+n0BDbgQVjE089QGCioh4KdnF45oY/gag3YEWiaSY4WojFGSYqP6rvETNOCKQa+RPHb3JmH4+7+YfIijP9UWCdHz2SK+NMFhOtgQ3pcoSneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76Q2ukEjjb0hEfT086y7aNLQ+jQfS3rZu8flZm0AWsM=;
 b=phSg8iBiLVFqdHO7wcTrJbSbbFgcWYWB+U62xLFz27FWRqZRDjMUrKlZNBfq9lKAy1mFE+/K5Nz5oRGHqbP3514decOoSljwEdUxwVVavnKLWP8xNTaPgFOmrfUxAVIjl56SmB90g5uqHNKzaFeaaAnWbjvACn+o6VmQHoNDXiz1UohsL1TrmpFtuvh0g/lk5FfSOutIjn9W2g3gHsxGpN2FXYrGC8eRPQA/IClN+PCNddoYwwRevnnSHNy0MZzMT77HCxkn8c3Nfe4XSnfoYFu46fOEA5eGPmbSURMPqMvHhlRgxYO5lEVaWg9eXg7l/G74TE3AgSUISnAOU1cVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Q2ukEjjb0hEfT086y7aNLQ+jQfS3rZu8flZm0AWsM=;
 b=WOGOJekvxvwcTinf4vrlEtwzWfNltT6Vm6p9SlkXUvPHKWWe/4zM2atNoeKeDcqd1ns1u/sCPtxGV0l76YoULwSeD5aPgzsKgGUr8bNXUbdIzVMe/eXNHLQUgc1OCsidDU4uBWF5lK8edljjB3wnXyHQ0/NYdQYJNoz3lUi0YZk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:36 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:36 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 13/21] mm: Clean up unmap_region() argument list
Date: Fri, 30 Aug 2024 00:00:53 -0400
Message-ID: <20240830040101.822209-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 9142e4e6-45a5-4951-e3c9-08dcc8a87145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/iJNEne6aF2T/rLX8iiU0BEdC88FDq0ny5mYE/fjUVBk0F5aUFQJ0Ih97Zj?=
 =?us-ascii?Q?m2WUIx8e7EgnC021M8XYgTnWefl9Pwmg5t170FpGmMiaK5kMRqI/OKPcRFy3?=
 =?us-ascii?Q?iSDbQClDq7zUDI3too663vKd3bRLe30f4MewYBJhX7Sxam7nKEVPhMm5DIz/?=
 =?us-ascii?Q?B5FF3H4X2buG/PoCmt8pOhAIVdy11M0LPzzB9+11ca3jUPCzr2NBx/S5yDAk?=
 =?us-ascii?Q?dqVZr5l/3RrPcDJCFAm1BQPIdIueZ1MLDCVc4nvEJMEO9OSDdDyZyjQ2BciI?=
 =?us-ascii?Q?1ag4nRtSiCegDOAnmTuROg6IwmaPh3ustbw2kicQ3qDjO83kjQ6YEmHAWXux?=
 =?us-ascii?Q?dK2cMu6ZGHkMzWV7WYvTQvfrlaMwr41XL17JGF0mrYiQ4VaR6zTLO90gQREi?=
 =?us-ascii?Q?fKUu4fH+Kbz41AHIp3PEhDj1mFbtdyTKKUKc2GZCx5dcP6R21+dT42tBvce6?=
 =?us-ascii?Q?o3bAnBFxDJseBhKPTAnqELrklXj12/r31YQt/UOOTjeAQux1Nqj4qilAyFmV?=
 =?us-ascii?Q?3R8ZnP1SWRUFLiwiMwvdyCkBoiYbT/BOPFHoXWfIMoMKu5s+fyYS5zEE2SSO?=
 =?us-ascii?Q?c18j8t9zIH8nykd+vffO8hm+Dm/aLAGxhDOTUO/MJ2T4fvANKc/tG6e9XbBi?=
 =?us-ascii?Q?H6ERPRz3gVBnEj5IEp8Hz/O2cVRBSbeHW1KSDfCXUaic3udloQ2NRz8l4Mem?=
 =?us-ascii?Q?4jaGnlEl2U4j2UbI6cYl+8T7/D/7kvJTNA0ztLSba/iCzjHizHTfsgKT3Far?=
 =?us-ascii?Q?HTmiQsWv47c++trXtqlRGM3fumq/sqyY8cFFw8Ru3pqhKK1g1D0zVMlzxPIa?=
 =?us-ascii?Q?kAESV+16GZWAVr5iCes/sKr0HuKq4YX0PD7k3IjQP+KAwjWAGBp2YZCooHOR?=
 =?us-ascii?Q?Fbp2eeWmi8sGsFGnJc/wPTJpKO2acAyw6FbMStz4gKhH38Am97rOh6It8pP6?=
 =?us-ascii?Q?qZ2ESzc6/8ok8aXbXUU7C2fDC0ARAXTHRdRY+ihGSfbumtcWLzkPf8wq/UrV?=
 =?us-ascii?Q?RnAbNgezDhjO2pThldaxVHqbGsdpegx2YUjuT8Jpq6L3qVox+4eULgoVajC8?=
 =?us-ascii?Q?p8hrusDkPRzc3EdPOJtJvZRXXTM0hj4PMpppzeMTieK3YdleMYsa+8alnFFg?=
 =?us-ascii?Q?nHqHdSjF1ZmrwcdfmOxGOyg0VXXp7AXcwvxq1QW3++ojpG9PlmVeIYNA7zSv?=
 =?us-ascii?Q?tQQNTwHAeT/1YPlJwpgfeHkdkZkjzCKY8KHagCNzsnBhmYLAXuvRyJ3mqhKA?=
 =?us-ascii?Q?PXHImSCcox2lVD2SrxhitsZ7khfvaNdPmtf4p/lRshXEmD1+usbJ6QL0nut8?=
 =?us-ascii?Q?Hyjp6S0e8dw79iRLlc0fdy/9FxYuBFYkxsQUAodpDGFngw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMuinCNqFcj+tNUxoSNpomxwc/N5uMVEDXmF+Kz/HiO+yz5cPhMNEJsa9zHp?=
 =?us-ascii?Q?DsB4/8I18e4jJdc01wUWCDq/WSxrxFysXq+1EgXRLqvgZdY0R/xt0UwGKKCQ?=
 =?us-ascii?Q?C0+M541IIvz3Mv9tX9Z4HxZ+I+s0ogEWtjssmf0RYMtUWkjgVGBIl5E3X1mo?=
 =?us-ascii?Q?eOwnST7qEKnddAuNuUOixSFb76Rr7a7RKYGXR7P88QVRdoSp01/aXigiLDIz?=
 =?us-ascii?Q?4IwfltvmA/M+xAVlzODjxt08rpK2xuX502O/KH4Ng7bWyclJHpDI6U5/mEIJ?=
 =?us-ascii?Q?FkAhJzbbA97kBEhs+Z8FvcCIN88yAzbtv8qj7dhuwzcz1Q9ahz0oyYKG5w5k?=
 =?us-ascii?Q?uOp+593cNwnNOaE2/lUEmR7sR/P3v7lh0qyFXt6iGKRF7IKLtLnAnA2FuiOR?=
 =?us-ascii?Q?e6cPP7YH71HJVqXJHfUxi8DXq9TVuCqqRaTuUnl55+BxnvKiKVbAOs3lJXHc?=
 =?us-ascii?Q?5O0s1kmjG3kV4Lxagf/FXqvpOx81/WHpk4G3gD5mpBJMS/d3gMT+//846HkS?=
 =?us-ascii?Q?+o8xUx0TWHPapzWGzRin3HZcqDNldKWba+NvROEVBBivJq+p92q4HHk7X9I7?=
 =?us-ascii?Q?0eV/+/lapoheyofy33crdnX6o5/BG6QZfQfuq12+BymR0qVaInVgANbTKkYg?=
 =?us-ascii?Q?nRJiHcJ4cL6MWYMhIlM2ZCtHZ96Bh57fYKsh8fUxokTKz2cVNfiGqJztZnMl?=
 =?us-ascii?Q?FTbW37ESF+ib468BRi/VHl5UfSTgpfr/n3I06gtwQHT4dD/ipnr/szjxEpww?=
 =?us-ascii?Q?EvQ4P8aZ0u6I2uLe8FKuqt4Ql3sjCckR1b9UyvOAkcn2pNcDq2TnovzqUAgE?=
 =?us-ascii?Q?jt+VUvMzAg8sW7N27RAcx7bf6mkS4saV0nTgmZ1aWr42acJnorZmkU5oRCkF?=
 =?us-ascii?Q?cmJuWmTrViQH1Gh6Pmb97cpbnrSYCdSFnDhQYzgr70+RdhkNz5qryRZ2wM3q?=
 =?us-ascii?Q?tHmezYva397B1yqi7qMLhmaRS2BJ0jV+BcYU1+twcXIw2HwHVvKFdbjGvSJT?=
 =?us-ascii?Q?t4jEax0VcNG4EJAh53D4huCtN4Yc8/vLc31f2O/VMc0yj0yUmnZclEGDHMLD?=
 =?us-ascii?Q?DfMSu2zMNz1VdEXxMxIQYLBbtxH2rT7dDOh9Z6g5pcQWVevH5IeC9Ru+yemv?=
 =?us-ascii?Q?NbHGrJkW/FTDIO3XgwkMg5Sal4Rt9jVwM5z+4MEsA2JKf/ty+QqptZV9EyRi?=
 =?us-ascii?Q?g4X5xobo28GhAAGC+DVAE2ILv9jjOdzFsAwD6TkqP4WqbpubkiAYT0/VMiqe?=
 =?us-ascii?Q?qP2NI9ELL53fC10YL1qzneEoI5EFnG2hcnRCJrBsSlKbIDmMzKi//rTmmCzr?=
 =?us-ascii?Q?KZ6ovV2ScEMatGk7PAcXHRpoAOMoCkC1BjEZPt88Xfa7Dg4XHiQ5KzsKoR1a?=
 =?us-ascii?Q?4TGy0wE1vKv8sFoFvg1KwUG76w/gQXEZs2rKhtyyb8u59XCjxvKz5X4H6YWQ?=
 =?us-ascii?Q?pSxNFt0pl1l75a84sySWWkrudve6fbCXOFqVvVD0V/JuxjAOK/hbnWAzCAqQ?=
 =?us-ascii?Q?GlnQ6i2UFbB0Lq5/Tjp9D1FpbnvJn/wy2QzEmlpvH9wd95oxbAVOrTQrBlPZ?=
 =?us-ascii?Q?hv5lO4148mfrhsQGDUwzKuf0VsNogOq2kclv5op+/XMJvAI9KOPHUlC/JTb6?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rvDxd9h0IHDwew7o6QYUieGSLHqNNYcTiT4eezPGMdpAag1jxkcji1Y0hKImSQ1sy4hUbGyAn5n1pmeULxDGG+VuDAxOu/suF/HechFFfPqB44psIS/0ByBpMJdwDXotw8dIoVC1Y2LOGdisRX7IJh4QeOuCVqX+R+9T/AEiiNBWru0BO59tdGAsX5mPn0z7JMOVuths9njcjllg/bR2rEs5nP07MkdYRi+VIoIVTD3bVJo8LQZI2GbG26S4IERbTN/c4gOPKgnvwa/WWU0MzwG/lOtwmQIb1qSmCbo7rPp85CrQONyyF6LnOUpWOqa3ASMIKE+BIlTIQcyMSp5E+fsg5viUUPU8rHI1fBh+qgMMDj+viHH9vjjE2Cgnm44tU++VNXpX/lHJKX8KgSiGWLWiVNG4beZsnPRqEiziA0bgxARNDt5Q63jd1aOX82qGWlzInrK5+zDD+KOnwZxc4xoPFNeClPaD+wJRVBBN3s9XAe3y88c3mBB5u7FXKwX8iAf2MmrDK4UNjGlHc+Gd0tPPwY36Vpnf0QbCD6HcR+7XXmQR4DQil91vvdClmzaZGDWFZETllQNeEkfLsLDAZHFac7FYT4LM7zUALLVsgkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9142e4e6-45a5-4951-e3c9-08dcc8a87145
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:36.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riKuEO0cB54gEVl/A8cnAnNMpSeXf1dREqKhFr283FCMINMKSi1aeHtgxPmrxOYqyA2/IV3FAOMWj6EvuKhrNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: 6g6YUpPvGEfzmkLgHF3vEdC8_ZUWdpVO
X-Proofpoint-ORIG-GUID: 6g6YUpPvGEfzmkLgHF3vEdC8_ZUWdpVO

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  3 +--
 mm/vma.c  | 17 ++++++++---------
 mm/vma.h  |  6 ++----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 08cf9199f314..304dc085533a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1615,8 +1615,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
diff --git a/mm/vma.c b/mm/vma.c
index c71dda026191..83c5c46c67b9 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -155,22 +155,21 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
  *
  * Called with the mm semaphore held.
  */
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked = */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 8afaa661224d..82ba48174341 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -149,10 +149,8 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 
 void remove_vma(struct vm_area_struct *vma, bool unreachable);
 
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next);
 
 /* Required by mmap_region(). */
 bool
-- 
2.43.0


