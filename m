Return-Path: <linux-kernel+bounces-308019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC9965623
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBB61C21D30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336F714D2B2;
	Fri, 30 Aug 2024 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SkHi8+99";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WC+uYKDd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6334165F04
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990519; cv=fail; b=pDnqfViJ4GtOFjOiShxywcy7SU5CxDFI9xnSsHShqgH8oVX9D7rbEuBw/A8/GFdHXVWTO/7viGrzdmXHo2H2AsnLExBvIAD7YkIs1hFuZla2IckiUE1ueiGjn/Z9uf78LxyFcsiuO3kNbEW6r+WlBt1YBnl9CmZSt0vf5O+9WTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990519; c=relaxed/simple;
	bh=Dlc236RtHwL1U+OlBHMZjJ9HLCzndA0bDgSwSDqZsnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcVO4AMnPtS1sEOvBPPSJCWdTm2zHvV37vqZ9IAhlkMlkE+QF20MUlhLpwJDZ6POSo104M/TGc2fNGwZ6n0U8GbAR367LyoQgI2OImusor0wyhqCARERa2RXa8pAndE2GZAUp0jLCNHlZ0BUsl/pp/tMRHqIwG2zWPENUSOER5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SkHi8+99; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WC+uYKDd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fU8g022832;
	Fri, 30 Aug 2024 04:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=nJx3QG3RDEW0OZLwG20OZtsi05/1/vVoSWZWUJoiJXI=; b=
	SkHi8+999tdsu/By25e5Jm4/591FBdSLscaHFL3VSNUl6pWdA7P7nvGlQUFT3x3U
	80RFMUIyqgBayQ/ReJc2CTD+00mjo/UsJSInmy145bXhQj25W48hFAQ4FDEUD9KF
	dXhx7eTwMaN2hH+9Oekkw7y7empihxvqQiud1MgVBPDRsjPUPiQ2RHppqgXLUQgQ
	hC4xGqxKiKnyRT14uHf8k+zzNE7W5Ygh3BLOsOkTq91qnl8h83Ndc+jy+P5rL5YS
	X3N/9BwUrDDQx/lmyx/8ISwoQeidAZjIiD9oxEK4oiUAeS73BvjzdHuTsIiyH6PG
	cF6OWFA0uxoTd8slK0mR0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b28508nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2YOTC036524;
	Fri, 30 Aug 2024 04:01:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2ta2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTaCBfES3nwf2CEQF8r2iO4dYwqgbmrZPXqZYJgHajDVdb/vtyag1JiytmGZX8G69SxoSSVecKx1pnWW7Cw58cBi0vmlDGwCt17LsVHndyZIUgQfg7rCb7KkpFbk5bj7h20n3ZJtdpiJYP4BFJQOGq7lioq1mp+gw4OFxmrwodQApbZxw0yiw19f/5h5LdEtQ9M4drHIpyBQD0HcFefYEi0kMgkYb2Pd62WUpBx5WINOXxjG53egOtmQ5JCZg7kjXDXP1QvOc+mzefjKI4Iy1lhqs+pQBNf9UKHMzHWAb4rhcxDutckRp7K0Sa7H0h2SfEdhULytQRFzvHw5O/Y5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJx3QG3RDEW0OZLwG20OZtsi05/1/vVoSWZWUJoiJXI=;
 b=rxOcuShv5k+4syitjXaLzwH9/J5vHYDcvMB3VyinfNgS4llPqvwj62C7M9I8NG0JZ8tlPTP2AOOs2JQBL1C4WQ7wnv5o+LNotDKzw9JfTKWxDglmsds4QRKy40FV1rbYRt6vYM4OhVu/FmgJB8A9fL669OTL9O4UbcrZh7WIFiL19Dnq2drwqfM3wMEns0zJyX90KlAsOHvJykPNULk6wFSwaeg+7uuHeG9h/xEAtSSxEDb5FzF5MSnYu44YwBhhsdCzc53ImrLFQI2PaUgOMKQIWhDwwMa2jU+23znghd/ieEY/cMzvGEkFC0HkND1/GCFl/vTrJ8BrTd5TRoWzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJx3QG3RDEW0OZLwG20OZtsi05/1/vVoSWZWUJoiJXI=;
 b=WC+uYKDdztlEaRWJQVf7+/HzKQLm3iET649adsWwC0nmxHUlUgKUkdRRE3f6tgg9k5iCH2umDVu0zWgcF94gpN17jj8emB3mku7tCcwhQ9tfNL76Lcd7tBM7oWKdkzvF01qR0oh8+8S3XL8i14oJ8RkGuvfju+xr6X4dxPKlBTM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:38 +0000
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
Subject: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Fri, 30 Aug 2024 00:00:54 -0400
Message-ID: <20240830040101.822209-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 6292d4ee-5e68-40be-b81e-08dcc8a872a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHr6D+ERTM+jHG1UqSXm2UvaOzKSX3xSPr5qXu9Y+NN3KBvj4F/n0BWfdyOf?=
 =?us-ascii?Q?sEKXWz+nx1FTS4btQQgsLenDi9as2twnM/5iStZLDpbbm2Is198JSu2nJBXL?=
 =?us-ascii?Q?LfD1Yxl4keT8GnAmdiuOL+qkmC2V81ku3xS8xXZidmPGxuk+VlYIHrbDf6sG?=
 =?us-ascii?Q?V7JHPWV6BWg4viIGBNLPlteVa00++QBdqhVa6LYpZ6QylAdjHN9vfwH0hXFF?=
 =?us-ascii?Q?uIGRQKAGdCHVzR3bVT49IsTZRrSFFqOSB4m/UcUNaf8LhQY51yAPBmLr7y3y?=
 =?us-ascii?Q?7qcDhv5Gg853DxyQXjsXKlWJBVZorIURzxEDjYZ4RoE/sNzwYX2BEydN8VC2?=
 =?us-ascii?Q?l3MpRLPYq/YKSgodk2JNMk9s30iiBwULZcIt90WB01AGGVdeXNdcsZctaGWS?=
 =?us-ascii?Q?enfg5sO0BfqA5A5mfx9mTO9I8+2x4RRbEfdT7k2t2qzPekOcpKNY5gk0HchC?=
 =?us-ascii?Q?/syObVLQMSGJwhzhtT4YOyjbT/IbqiDkVcQ5+WpXkR5WeR7BI0bdJJ250sum?=
 =?us-ascii?Q?U/r9UyoKK2TsmXS3mRQsTB1Igezr1S4tJkL1+FOQwVJWgICyuuO78x2rEFza?=
 =?us-ascii?Q?OdsLOnvs+JyLAmSjq+FHpLwAMybIdxocqkSrTaRTnKkd+0vX1I2NcSj/gG0e?=
 =?us-ascii?Q?tbUVbb9TY7tgudU7qrquWUzn3X3K3GQRh9yAa5BBP3DA49HpAhlwi56FFdX3?=
 =?us-ascii?Q?w7AJNDXUyK3vE8KFXlyoS0zCV60WUb5vDfJ5Wm3PLGNobVQJbInCNuuP5dyX?=
 =?us-ascii?Q?yF2HWO459wZNq20ZIMoMqLuNh9340mlEB7tbQdAVO0mrgWKo3Uo7MkWTOj//?=
 =?us-ascii?Q?frZrBVe+Cp18ycFtMB/rIxOJvpchLF3+kz4uhGFsuXeqvOlItHgP2hHOXYsA?=
 =?us-ascii?Q?OXfzHLQxxsJ+TOrNkL+/B1cBn0GJhYAocQWXoiDYwP2xj2u7BkL+JlRBcECw?=
 =?us-ascii?Q?sr3dusQlpp8SXnsBhs4N1uCtdGHLxA2KhuewmQPZDSGG0dinDm5/h47Cl8YK?=
 =?us-ascii?Q?9N/7h4S8Pj9LR4ZgW26atOto3mMnsaWhYnOpwexaW9Go+imbZIVN1JpUbObI?=
 =?us-ascii?Q?YcoO5yTfS0YzaiVTDqRMAB/LcIF1mpUXEh6rJVuM2T6b8VwA3XMqWNal/h2n?=
 =?us-ascii?Q?mXvsfumUuh+2G8fAxn2svVJVJrs3bYGil+oxEnKrDaUUBhflX4gv+0Yd7ZL3?=
 =?us-ascii?Q?ud/8CfqjLoPi4JN/y9bFUmz0kXoE49tlclH8lIkwAKER4P7tQCm/725AEyzA?=
 =?us-ascii?Q?CA3yUE2QTmh4BIEPa8JFoIeA4z64316KBqkUTuzhGvV3+caFjAMi43MBYHbp?=
 =?us-ascii?Q?q9sb57Zq+9XWRMgqcrLe/KHAd0QgNd9aZhXIP7/H6rh1jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPjVHYMzICQEphINLBXAwiSQAhYw/hl6rdxl66gWBlO6deIckNSyCb6HM7lD?=
 =?us-ascii?Q?OD9myGqatIV9QooRLGH8QV3elkUXv6e/NQiUToXm3Zp9l+ugjBgU2t+On22E?=
 =?us-ascii?Q?JF3tbjf1fXH18ENAapZqSj02Gh+JuyJERszXx6QNmRxz8lSxF0evPn9n7/xK?=
 =?us-ascii?Q?OZvDYhUgbKmkOwbvnV/2EHiUHcdS2pePboREdL2XuI2Vf6rWs/dKxrMV8hVT?=
 =?us-ascii?Q?qjC5eqYz02/rhD9M69fqlCGj//eb7taIdhYcOimk3py44JypJMQz0Pnh/wVG?=
 =?us-ascii?Q?GT8sf0+i3xkXPSQLOg1lGRLaEwMUxoKQafHn3Eam3DOafMDNEU4Dpo48iQ/7?=
 =?us-ascii?Q?tp1Kb+9JpObRQVU7bHDu4U5EOcvsIxmZbfy96bHdFbOLRYzIQofyHZOVoIq8?=
 =?us-ascii?Q?31JzEFphd5TIcesP1wDhAwcQ2Nx5PnMUarFI2zTl1x/KZd2Y2huLh9qVKpIg?=
 =?us-ascii?Q?hKbsEk+9jK7GakETWTtm1xHDgG5DcVRWBLbDxDUiPYwGlC1+RukZScMGyPZN?=
 =?us-ascii?Q?ecCmmgeU2/uH4nD3e6SNMKvGp/0A3VS+5as/u77pETk2D0CJiGrekpxhhZZm?=
 =?us-ascii?Q?6OgSP0iY+V+vijeWo92ND605yQ1c4hX+TNb8RYjil0/Qv15RhVDBwk/yK210?=
 =?us-ascii?Q?jfB7swrAVLEGhbWudbA9alc+Gt3x4VlSUpBraZBUOy0ckpnr/rS5JN6Chv0I?=
 =?us-ascii?Q?Z+03UOKXN2GRw0uD0K8ggRZfKk1F4g2wVGRPku1QOzpEwYWvPfS+OBGtJIfx?=
 =?us-ascii?Q?UGkzrIBj5TJWgR5ZHDnRhPKKxpZ6EusXi8yC7We2PTRT5TZKtwUPkPFa2p3Q?=
 =?us-ascii?Q?X9NynHtmAIjGl4llXkQIXF3g37eaAJmz8JDZ+qR9/SRbPmbDzJHxeO2O/Eik?=
 =?us-ascii?Q?c/4MUIkFWMBJHDf6Oja0X+P3SQBly633dH+1fz4y6qjwTxH04G71Ua10zRTp?=
 =?us-ascii?Q?EHL4bGR9gsDpOJ65whQ6M40t2bRtq/TmmXN29jFOxpRSNnXJ8kCScouH/nga?=
 =?us-ascii?Q?XrDHlN3aIPU6TjCww6UTHZYAEjL1y/QKcWrl4xhpUavlpaYc9sUVPXg+cnae?=
 =?us-ascii?Q?o+CaOx3fwRns8W7YYlUGkpFfK3GOuIXHyTBW2+nxKxu7DCGK4plz3nTKvrQg?=
 =?us-ascii?Q?qZwDA2pPzV0Pb0gqDBq1fIAZ4RwsHp/a7B6XWQOozPVJSx2fpYVUkfzf8VDi?=
 =?us-ascii?Q?BKDZ/5qe+vqKZ2NlTpdWbPI1G6+MZ7tJFfTNpWS44I28+gguj0YLYaiswwR1?=
 =?us-ascii?Q?pmRFB8sRDaEm+30DcIYibhY/RZTfz1p0mplM2ocA1oD3HBHGKLh/YTKHVE1c?=
 =?us-ascii?Q?FMlEUVt2MVzx7Mzc0JN295jRSVx43LvEcW/Sk0jf4V4mHZBIh5fl/YaHSmrn?=
 =?us-ascii?Q?6uFOXAsY3XmHQzcPjZO2V9jA/EpgsOpn7GanLEUU30bGVaCjiSJi15O+bTBs?=
 =?us-ascii?Q?2pfShDaRtBM5PMK9jWQJevLhBGZFLAwBnBhrtMqCSYv97YXz3hPRFlyiceJP?=
 =?us-ascii?Q?C7ZpvkeaRSAUYu6BM6z0srwpkkjYm/EX4v2rjGHPn9wf2NIGQOq5nKplLiin?=
 =?us-ascii?Q?LtrHk1YGRigvBLl80UABmKuQGSGGpZ1L37r6RJnsKIbqumVe7EvPoTZFkp+Q?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fwkX/2gh/9vVJjmrE8UCbLppm7WCU+k7SiP/KLk/KB5J1TZEjj9lc14pBYdGyQqeCkDsVlbvrlKErnaPJWcsDpTOf5V+PkY8KzA8NvWN7+tZu+n6NM5CHqB8Znf8nKUE4gnfjAdJ05YEk7HUM/9LHMdU1t7Sou9FcQYA1CAhgPI+YeUKJgt+FpvMl3Eyw1+Ki8Ah7V9/gZFRQjSuIJklfSUl1jHTYZgDYJUZ9NN+TPyv7Svh0DOjihYWT4gBgBMCQkV96w84F8TN6XgC9QZpeCi78pd4wj4leIxfHpAESr8Cq3/sWfUemaE0ekYRv6SHi5StyfpsAtIgBi948yS93thlExSI9hxgRoeoOqhWJ5XbeI4zWPQoV9YlT1Baoa8Rf3PbPU/bnkZ/Y+AMKTSa/cwVBBn2+DF40CWFlnQw8DN/Jg58wwqO6WJ6dOuuEf2+HuZowWSYxgelIsK9Hzb1/Owy+OL5JMpUysFuOvmPKFFIO3oAqQHQG7qCsu2wr7ZdVz+wIfUKTAlpweQGNH6pNuTW3mh/6VF5u3m8q5XOU8b/LO/a6VbY+SvKR/Vs9aAxY+MS90unoz1SBsvEsTXrFWBGRanD5pAj1r1C4Ml6fjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6292d4ee-5e68-40be-b81e-08dcc8a872a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:38.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSl3n9qNTldgPnkDsqEB+3OofRDEUUNgefVvvnPpx+/52e6dMDWf1u6PM94uDhvamCHQ7/j2u3g+sAV4iDQTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: TfGlakqAfAFPkZf5yC4KLqBVn5ZsHpXg
X-Proofpoint-ORIG-GUID: TfGlakqAfAFPkZf5yC4KLqBVn5ZsHpXg

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

To ensure locking is downgraded correctly, the mm is set regardless of
MAP_FIXED or not (NULL vma).

If a driver is mapping over an existing vma, then clear the ptes before
the call_mmap() invocation.  This is done using the vms_clean_up_area()
helper.  If there is a close vm_ops, that must also be called to ensure
any cleanup is done before mapping over the area.  This also means that
calling open has been added to the abort of an unmap operation, for now.

Since vm_ops->open() and vm_ops->close() are not always undo each other
(state cleanup may exist in ->close() that is lost forever), the code
cannot be left in this way, but that change has been isolated to another
commit to make this point very obvious for traceability.

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This also drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Clean up the error handing of the vms_gather_munmap_vmas() by calling
the verification within the function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 57 ++++++++++++++++++++++++++-----------------------------
 mm/vma.c  | 54 ++++++++++++++++++++++++++++++++++++++++------------
 mm/vma.h  | 22 +++++++++++++++------
 3 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 304dc085533a..405e0432c78e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1403,13 +1399,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto gather_failed;
 
-		/* Remove any existing mappings from the vma tree */
-		error = vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL);
-		if (error)
-			goto clear_tree_failed;
-
-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
@@ -1425,8 +1414,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -1475,10 +1466,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1487,6 +1476,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/*
+		 * call_mmap() may map PTE, so ensure there are no existing PTEs
+		 * call the vm_ops close function if one exists.
+		 */
+		vms_clean_up_area(&vms, &mas_detach, true);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1577,6 +1571,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -1605,7 +1602,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (file && vma->vm_ops && vma->vm_ops->close)
+	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 
 	if (file || vma->vm_file) {
@@ -1625,9 +1622,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (charged)
 		vm_unacct_memory(charged);
 
-clear_tree_failed:
-	if (vms.vma_count)
-		abort_munmap_vmas(&mas_detach);
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
 gather_failed:
 	validate_mm(mm);
 	return error;
@@ -1960,7 +1957,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, true);
+		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 83c5c46c67b9..648c58da8ad4 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable)
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (!closed && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
@@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
+		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
 
+	if (!vms->clear_ptes) /* Nothing to do */
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, vms->mm);
 	update_hiwater_rss(vms->mm);
-	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
+		   vms->vma_count, mm_wr_locked);
+
 	mas_set(mas_detach, 1);
 	/* start and end may be different if there is no prev or next vma. */
-	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
+		      vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes = false;
+}
+
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct vm_area_struct *vma;
+
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		if (vma->vm_ops && vma->vm_ops->close)
+			vma->vm_ops->close(vma);
+	vms->closed_vm_ops = true;
 }
 
 /*
@@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -702,7 +727,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, false);
+		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
 
 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -846,13 +871,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);
 
+	vms->clear_ptes = true;
 	return 0;
 
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
 modify_vma_failed:
-	abort_munmap_vmas(mas_detach);
+	abort_munmap_vmas(mas_detach, /* closed = */ false);
 start_split_failed:
 map_count_exceeded:
 	return error;
@@ -897,7 +923,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
+	abort_munmap_vmas(&mas_detach, /* closed = */ false);
 gather_failed:
 	validate_mm(mm);
 	return error;
@@ -1615,17 +1641,21 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 }
 
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
diff --git a/mm/vma.h b/mm/vma.h
index 82ba48174341..64b44f5a0a11 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -48,6 +48,8 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
+	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
+	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 };
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -96,14 +98,13 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
+	vms->mm = current->mm;
 	vms->vmi = vmi;
 	vms->vma = vma;
 	if (vma) {
-		vms->mm = vma->vm_mm;
 		vms->start = start;
 		vms->end = end;
 	} else {
-		vms->mm = NULL;
 		vms->start = vms->end = 0;
 	}
 	vms->unlock = unlock;
@@ -113,6 +114,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;
+	vms->closed_vm_ops = false;
 }
 #endif
 
@@ -122,18 +125,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked);
+
 /*
  * abort_munmap_vmas - Undo any munmap work and free resources
  *
  * Reattach any detached vmas and free up the maple tree used to track the vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
 {
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
+	mas_for_each(mas_detach, vma, ULONG_MAX) {
 		vma_mark_detached(vma, false);
+		if (closed && vma->vm_ops && vma->vm_ops->open)
+			vma->vm_ops->open(vma);
+	}
 
 	__mt_destroy(mas_detach->tree);
 }
@@ -147,7 +156,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);
 
-void remove_vma(struct vm_area_struct *vma, bool unreachable);
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
@@ -261,7 +270,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end);
+				    unsigned long addr, unsigned long end,
+				    unsigned long *nr_accounted);
 
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
-- 
2.43.0


