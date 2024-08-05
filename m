Return-Path: <linux-kernel+bounces-274630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A40947AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF17281F68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB0157A43;
	Mon,  5 Aug 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrAZKxia";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dcCPAUQO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259C15746D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860077; cv=fail; b=iX+pJ/Ozc8wyd12t3r2tT9Vc9dAhsaaxrWyFAf+3XfaNzO2EQ1Q+khX7eInU/+bjFY8QKkLp0dUrfLaC/j5M+ijes5ySgmU0b4xe2oaszLPgpYy5BBIhS3PyRILqN0P6m8qLTCgPazUvy7ZLgkgbCs7wuqegeOXb9dddCjprRVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860077; c=relaxed/simple;
	bh=minXZLS7E4gzrwD66dU4VKUPUgZW0+2F1xKLrpX7Dq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YF+6XJw5kKmTIXvmkJBEGZgp3c4AId2wnUL0xdYcfpMo681O1yp9dQ3NOnJcLX/vYbucepa8wv+6LjsQiZlVD5Ptp4H2xjv0WBR09N2ELRVOxzYorb63c/BiqyuWeQ9JEU65Tdu4up6SypqrAw+5ecsPS4drJxe0YoY5qN69CfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FrAZKxia; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dcCPAUQO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fZ5E017605;
	Mon, 5 Aug 2024 12:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cETyroPp4Qzekm0Pgwh0kaDe1z2NOaT3zirK2ZeRr90=; b=
	FrAZKxiaIAtJ9NI8cdIbp/OMfrllylygsWqz6Cyqm4jLe4wjhaxURLM4J7ppFyIs
	VGoOiwhUsEmnsUp1RVEgrEJICbX+BeW2ygI0+AncHZhAgBFwrsYx/refv9um/FgS
	aNzBH67YPQmxpJ4hPNTbbIYyqX/r7HFeyvJttnkPDydy9v3eq5/ZH2q5T8V3fnjg
	SjXIwyLhCCSW4HojORf65Mu/CD6tjhUWhmelFRV+vGnrY5D00rY5dCxhXD9a5dV3
	F3pct9Jr63icUsB7iN5e7pGqTfGFjZYgk/Ogv2ctsOBS4CM8NxBTdDUhe/wPPBt4
	m0v/NOoVvTz+nWpQjzzPJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye2gwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475BqNaH027379;
	Mon, 5 Aug 2024 12:14:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0dempv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goYJuHniNDYIh8p/sMuHtEGJf3QifWVZsans0WKyaYFwKS9gN/NWzmrRr49xDbFMHk1M8EH6J1hoNCuAe+jjkSW+bLdoKBQVxGMxQefTrea/RrS5w4RYxod4Ru1cfyGtbHQ5UX4ykvRMI0xwatCE4rNogNypAvcac2LTgE831C35ShRhFY9AabHqjQ2qpBoKgDLv1LtqQIprYBxFGArH1JBukvlLLcK7Hsfuv8DhGQ7pzgw8ySNrzbslL4M4P+gFGKI25TI0pZPIjZAe+58GiFEjvqg+0U2xBlYdwAPXFzKV1640uhZJYDmXRYuQ4izAZJi14+uN23oUekADyqT/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cETyroPp4Qzekm0Pgwh0kaDe1z2NOaT3zirK2ZeRr90=;
 b=E1XoCIcSkZDEI3BgIM6SOKRrOumZKibMu8hFCk5pacJ3mxGpfCGlA0KjPmWfZh3/aF7NAI2bXHqbPCDzTOs8N3IxKRkOtiOZBMpD6PznwYAwjQCDPRYTbX1pU0p+g7VsUr3TGlndAV4VgsUiE2EEAgP3unGd8ihUo1XagHnvp381B34Z8w/fzqBSzrqRchFKJIsbMgq46tnueJuFlU084hS2W3F7ZnsWPp2puxHCiYp4mhTFpHcjXEJQZyIRJv0hyxDa+2VCq8IvZ/X4XDyRJgIjIeOO/4sgl+/c8KlxdoVyw5JY2SPwWrQbtEDziT5ilotlh9wtvNXboLicyaJEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cETyroPp4Qzekm0Pgwh0kaDe1z2NOaT3zirK2ZeRr90=;
 b=dcCPAUQOmDA7HkJg7WTdnBxbSD/IFJqaf9KqVvjZHmBPqLEUDO36EFThHlDcn2ooDCAJxhJfxbOJW1WxN9Vyv5OBkiV3Ma/Zrs5AXFMAWA93eXlfnKj1jYyoKzAz1nXuJ44hz6V0H/YlMvi9L5LaH/XrGkR+yb+yPL4IqYw5RUU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:25 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 03/10] mm: abstract duplicated policy comparison
Date: Mon,  5 Aug 2024 13:13:50 +0100
Message-ID: <bf56244f473e6ac9378cfce420b51c4dac7783a7.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a236f40-a6e3-4169-c9f5-08dcb5482596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Cp9RGaQy8ADR9kuCSjsXEuMfHij4b2B0YOuREKiaYMDQd9HFG41j1AmI2xY?=
 =?us-ascii?Q?W85tRooOk52XUeCVaVWnYV6yTM5f1JT8WBTR+vL4NrtJcz3NPWchLnK8fhs6?=
 =?us-ascii?Q?w7cC/4ulLTQ5ynv7rzLjAxlq+RZh4c/WAHXCe4gdgh4xQCPdTynMkZn1u6hD?=
 =?us-ascii?Q?yH0DXt9cz7Ze17VhPQ402wmThh0+H8vdKfTEvjMsZjxMuRa6tVNGvj9RGsed?=
 =?us-ascii?Q?kwwB7KUy5ORNQHC1KxpTrIB19WBtN/ssxPZjlbmR67FFKUOfIEjo1fDYdzfd?=
 =?us-ascii?Q?shwhCNNfsKCsPuMSRFiKJyWr51aiWJM7sD+DGO+quVQ4mxnIEj5X1t5J0W1K?=
 =?us-ascii?Q?n0sV7K5tPVcOFCXf/LI8t7VtnG1b17apa5Kdo34yiS53XxdUVI7m/38ChhhU?=
 =?us-ascii?Q?v+bEUaUF/9oiLJl5PCqUjl6TP+vWvQd5MS63DyExphGukIqd6hdcwKHmHb3N?=
 =?us-ascii?Q?XcKnFvezD3K3xU1pcvWfJvjav5YpdZXbzL21W+PgOZAMIVVZOAJhn9zsgrTO?=
 =?us-ascii?Q?7bkiej21ZPYtDqO1oWi2pRF4KF18GMpxjlXug7GXXYva0gcO9Dr/wK7+KxTq?=
 =?us-ascii?Q?bb5F50jAi8ZF/2pFBpN+EIg8SzlT7cVo+3LG4D9EhGRgO2z4YoUp/Rhstkb6?=
 =?us-ascii?Q?9Jvy+9at+i24C5d2zIV7MR79xWa8ZmtthgRMYxwn/Pe0R1ccxtfgOTIduoNE?=
 =?us-ascii?Q?RqYTkHgDdaTdCRIUX1AEUYa6Xw5ks+qEAkfvfEOCknWI2DFxAlTuO9uOBbBT?=
 =?us-ascii?Q?g9LL0J+vZnngD3PWOJ1ZULieMImlCMoPBhWV0X42Ru2Yn2tzAxAdWSO/0Wn1?=
 =?us-ascii?Q?R1tomsTu78UlrfnOu+FM5kOCtJfKyumcnnyCet2tVHd4mf/TF/4U8mFRCef6?=
 =?us-ascii?Q?aFzlnygV7wHPMJZeb1TUo6eLmSeGQ3yygEAhx3XyFe5aBLpiPPxXOR5oJza+?=
 =?us-ascii?Q?iqbc0AaoYXNqZ9wgmpxRwGQNj7u/syy9pNEaaiz568q9RKIXc95N4clZRD0r?=
 =?us-ascii?Q?KmSdpJZiS38iuZpGoqLf2Jbh7XArOPphuYPdyUOAJqywsERyXxaZU5jFb2v5?=
 =?us-ascii?Q?xbd6wTOFB6cOL0h0zVWhQ+1IY53zre8gmSoQ6eKTB0ZVsyJptaqXbVW0oexx?=
 =?us-ascii?Q?mA2FAz6H81jaGTPTot87NPv4ZtobsJCR/1lCXY4KdRrPyFzbDIQU3Rq4ZzBv?=
 =?us-ascii?Q?deDFbO6ojBlbWRldU2AL9kyrRcK+PDbHwDhk6FNJ/UrqGzIt5vJn/NkBSlE1?=
 =?us-ascii?Q?WKukmLW65Vm6L6PCNG6IClhb7Mwjare9KUVPqUCmCZnvniXsRrdB+23Kepph?=
 =?us-ascii?Q?FgXLbm5fwFfo5U+MBCbQPdSzXEDh+p2CbBOIYkzVAO6Asw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEwjWTT8nZGdXEIlLgHGEKaD/JKXpRKJkaXwt+DEp/p4DyTvPq0qPqIh5Ssf?=
 =?us-ascii?Q?/pDaPTAJzsHjJUuhV1pueh7Qiq/Wn0fyOvnqLX09PDgysici4fsB+L/BrOXt?=
 =?us-ascii?Q?G/kAv2+Ya9lve1Qi0IEO7m8EOIdXiyfi4IporbxPI8gaOepmWM7tHUs5oJwg?=
 =?us-ascii?Q?h6fMwIWEfLzC2aiqq/Uha6mm5WgBcDrwqOgkqxXDxRtyADloJvQ6WY5SczO4?=
 =?us-ascii?Q?qWdkv8coe23jqX5lXOVgZRMvJW7jzpsxNJP9uzhj9qLFM39eRRS0fzySNN4E?=
 =?us-ascii?Q?FWlx69TLCkIat9ljPWniYqAapZ+TT5adwtXL0SkaNVHaT0tJvQwqYMyeWhVE?=
 =?us-ascii?Q?lqdTIySP2zXu5cZBoA6kDAjRLYfame20uQZO1PNSjNqEh/ocMsYKXphZgI8H?=
 =?us-ascii?Q?mVIT9e/h9d/S8CxQowoDknty2cRRieujdMg1JGgV5OxN5Cu440qJiiu4Qi20?=
 =?us-ascii?Q?z+7Uwnssc6eyH0aV/ayPHFCiJJ1kRN3X4OZWRfyGjwEPvKVHvdwb3BaOJ2Nt?=
 =?us-ascii?Q?3AeUXhe4N4lmvl1+QSlFDIE7ZD5hb4fXOLv4v5ai6rYQr1lLJZt7h2/Ttx6D?=
 =?us-ascii?Q?h/egN2bcR5DqA/r0nUHshlJ3Pn3GK7r7j3n3Z02/uKjVyx2rqysw6mUEw01u?=
 =?us-ascii?Q?wD2Mol5t7HwcXrAtDnteJ61STQsrLI5xePG9vuLLfpj0vK6I4I/SWHdeLE3W?=
 =?us-ascii?Q?JqKwbZXhV42zyvvKAsnACmE140T1HbE7f3kUHYzJ3DH5WIpE6rrBuCgjgxLo?=
 =?us-ascii?Q?P2pDTYEBUmAMWcCLy8hw5bPVb0IgQ4UAiIEMGKAuxSpcoNwdQJfVw4AA2cV0?=
 =?us-ascii?Q?zusbgpGAxfJeyeounTV72jNXaSXOr22MEpQfNQyl4hfKve+ZTLR/k8Pe4AvM?=
 =?us-ascii?Q?QbNDoBUwwICPCHHisQAol/Ivb25oRGgYe4W279MaG4PrTZOUzld6Druz9WA7?=
 =?us-ascii?Q?nUh8k14DA6VaN7d0fDtlFoqz9f1AnxoSBn+zKlvv9iXl3rOmIHoMlwowi3+k?=
 =?us-ascii?Q?S9puzKuXFqbP2mOXs6LVIXlS41fNo9jIqNg1UQKrr7T1tdYzNSaSUe4pfKRw?=
 =?us-ascii?Q?4J+ntn3wq0iMOQW4ePds5ie70gd+rMzkX4cJqJHMzg0KGXRfwh0Nn1cyCMek?=
 =?us-ascii?Q?CBDMLqprpLJO+Ddd0JxCl4t1bM668I7+aCp8BK+1pfGDLgtG3wiRDl+OB4BA?=
 =?us-ascii?Q?clXTkJyINTlfF/ZG36xf4WdqIxyZBZ7EmIK/FpFDY/2z7RwTbt+STokpDdBi?=
 =?us-ascii?Q?+bV5DlYzsAzFd8XdGkilY6FPb2onvQz4vwF/fEQtgFwabNnwTDMt8Rx4c5hG?=
 =?us-ascii?Q?EzosCOngUQS2sKf1x5MH6TfPo9HTccXYQAGK2zoIbKdS5BCwEuytbOJVsyrU?=
 =?us-ascii?Q?D6bGK2Y4bVYRZUyn+Hy9GCUUenkkEXybmKnZcxlSS1kaSJPjrkeczNU+notJ?=
 =?us-ascii?Q?/RpG+Nq7WTsPrOHIeyKQthEdYsTJBBIQfzRxnAn3MwwYC/3b4VWLPonkUiQn?=
 =?us-ascii?Q?w43vQP/qlNTM7XP53FpeYEVE+Ebbreh4FVsNDVPXBgrVdm0SrjswInbUJ+Vx?=
 =?us-ascii?Q?+bJ1C6Tpu1U5yZz+O5IwKSl9Trw1WbQVl9mVkUCHBLZhxVzI8MfifojTUet7?=
 =?us-ascii?Q?PFv1iTHaBLK5XZV4Xft9fGqRQg9vg6bye+x32M4nPygvhvqLe8PmsmuurjZ0?=
 =?us-ascii?Q?jxiT5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lCgpegdqqA7toEmUmXCZQV35o5bm0VL9EL0HOQs+xc3zxIjwrz8R1rP68X4K1B5Cgo2wyCFnTK0EQ0OB3CNeQ9OCbGxtEOI5MRCPFEQjkthPmv8Q9SkVm+NK0wouXRKZLVx/BjUU7o1dnvo3T+LnBPziESTs95COlyQUUUiBmMFQClIpKGSz44moDimhk5FtffWanbuSw0a6ktEhEBXSPcxoYZN3d4ZMW8NTKm4Yt4EMtvp3SNJ5xxBsoRvzA2yEZiRBMO1wGJ9xklhkCecbmwOpvdtv3lM9e7VnfUfoDu5kcJYY9dCkDASKIZMo/gYQhbHweVoyfwyWa9bFNyqYhJoxdkLIb7tGxvWJxysuyjIQCoc1/JHK4Al8ZQBf9jNfxsH9cKPhyKvmgdS/1TkeEn1SfH+du/k3E2pi3vefsWFRxBHsDRlfJHoJTEoe8306aNx7fAV7HkpgaO4gGv0+NZU6sbSu9GA6CGU88FavxZnS9dZFSwa16vD8loHbbGDQaZYRoozMbfnIR+ZCZ5I9M94sxIiXcR7EFi8UGQBCOTtg8x0ypjJpuSmFdLpV8kL5BlnbOynnE47K3KAri6pXmt66sD3g/j5McN993kAAecw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a236f40-a6e3-4169-c9f5-08dcb5482596
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:25.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3ZAV96fQ4QKmHOU35lUtYydPyaHVqSf5wyrVDFn7r81fJdiiByq29P4YtLDeW40u4mgYIF4PPfK4OsZELJJAt3zVt5w+VZGXp2BERCmNF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: hceqNbCgZ5VLM9oATMMBfUwVM60Jhyxp
X-Proofpoint-GUID: hceqNbCgZ5VLM9oATMMBfUwVM60Jhyxp

Both can_vma_merge_before() and can_vma_merge_after() are invoked after
checking for compatible VMA NUMA policy, we can simply move this to
is_mergeable_vma() and abstract this altogether.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 8 +++-----
 mm/vma.c  | 9 ++++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f931000c561f..721ced6e37b0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1422,8 +1422,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
-	if (next && next->vm_start == end && !vma_policy(next) &&
-	    can_vma_merge_before(&vmg)) {
+	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
 		merge_end = next->vm_end;
 		vma = next;
 		vmg.pgoff = next->vm_pgoff - pglen;
@@ -1435,8 +1434,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Check prev */
-	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    can_vma_merge_after(&vmg)) {
+	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
 		merge_start = prev->vm_start;
 		vma = prev;
 		vmg.pgoff = prev->vm_pgoff;
@@ -1798,7 +1796,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
+	if (vma && vma->vm_end == addr) {
 		struct vma_merge_struct vmg = {
 			.prev = vma,
 			.flags = flags,
diff --git a/mm/vma.c b/mm/vma.c
index 20c4ce7712c0..b452b472a085 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -19,6 +19,8 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 	 */
 	bool may_remove_vma = merge_next;
 
+	if (!mpol_equal(vmg->policy, vma_policy(vma)))
+		return false;
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
 	 * match the flags but dirty bit -- the caller should mark
@@ -971,17 +973,14 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 		vma_pgoff = prev->vm_pgoff;
 
 		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
-		    && can_vma_merge_after(vmg)) {
-
+		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
 			merge_prev = true;
 			vma_prev(vmg->vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
-	    can_vma_merge_before(vmg)) {
+	if (next && can_vma_merge_before(vmg)) {
 		merge_next = true;
 	}
 
-- 
2.45.2


