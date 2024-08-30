Return-Path: <linux-kernel+bounces-308021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B8965625
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC671C2245A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE6166F3F;
	Fri, 30 Aug 2024 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLqZ8Jht";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g1qbXRjR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901514C59B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990523; cv=fail; b=qJOQvjnQRiMTXG9Oym+Y1iiH3zoFaYh6913MaPUSxJuqeFjK6mM1I2Sa2v5TCT7HVlk9XG60SrWcBVa9QZvi7z8GJ/ANpDpq5JT4bg6LAFJeRvWcZU2Avh1OdZaGAEfWFdQ75PueoImVmkwbqbWnq1S3egyH7EuKpexvus2WDfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990523; c=relaxed/simple;
	bh=unPHXTiAaBPgJQgDSYBtiqoEAMNFbYTgEExwsR2UVi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heEhNSf2vvYlCsXNP3HSmE/kMeoTjRlvTyFu36O+VHW8Qty5H3f8Jhk+w7lbjY2Zz0mKS7u66Tc4Y0UFHojVjPXq1kC2g4QxAMOLgMMaaMJVNc1gkBRZDejg6HHOKYB+ssiAa94qu+4hfntv9WS15RDlsNVTDxy+RGUNxHS5aq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QLqZ8Jht; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g1qbXRjR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3RDZi029580;
	Fri, 30 Aug 2024 04:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=wu2pkeT2CbgfgdpPn2Zuz7ayl+XthYdcArrCgG1Zpro=; b=
	QLqZ8JhtHL5vt89eNHFLnj0Ro7JveAhbmFiY4HfdgywuhjP2zzwgX+ZcuaZiM86o
	r4B+92enhp6FuSx+dYwU58pM3HKEq1wOZ7VbSEG6A5QZCThG5QfvjwmO5Zd5o2Ye
	21xW66Bn0CaECDaVyGQETGyNaoXLSM0b2lQXNVh0mckBOW1ytp+QdV5aO6supKoK
	16l3r1PL2kQBsgANCMXv4AU976IxpBEnLLSTOPeFmPCmGpwLOxKmrjlVSHiwDP6s
	kBbQMSNs7DgTHZcBsx4jT4PQrXhSxCG+K6iPEKxnmLncCPta6Tl+xzaPgdqoJSoR
	XsXKIlOsPMGH5zPZ0Mpk4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q381hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U30EUJ016784;
	Fri, 30 Aug 2024 04:01:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5vy55m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4LnhBMB+vckaocx9WVUVYLt4dJtSLHxALD3gzKqybTDcX8+msoVc0lJF4OSAmLFW1lB34/bjsOzCUYrGpsXdicXo5EmIuJW7mzO5znW8KEdHEK82hORK63ozLseOonG/ci6T1MXHjHrky+S4y1IMtbARkz08AVz2kcB/BzfULwJ/OUOGVMSFgBj7HvaqJuX+67nv+WBcEp916H8RKjTlq50jUkWh8s4w5EEhvSC7yHU4DtoRNGIUxiI3qrngwtWTPKIV9zU2/N/cGmbAo0Ql3i9pGgL9bbhvdcmFIfi76Or03L9EoH9Us2A6B8sySckvCp18vdTHFYAICnXsHRsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu2pkeT2CbgfgdpPn2Zuz7ayl+XthYdcArrCgG1Zpro=;
 b=OfEmNfSUNJChy6O6LgP7D+RkPlsi0W8NECAY7AOIYvxVd0snSqTN1SP7gBBGu6xJYTYZpevDQVbLjNcLjzLjEaVew805t+VJueXl6RRyskJxbEVGy1M4jdlexrdUQJoYTK+HnGLwsRHuPIgarISYd/xFfiAefpJkg3D3F5hE8Bdl8CxAtuysQzkIlBZmq7/94W76eIAqzlTr6h8B2EVK+s5LwraJWrFBy0JzcsryqCsKjgqja0A1lJQ1h3C/7XWZcOr1cODZFFmg807j1d7qJcMtbGru94PqEqbHl9SQR0NuhOQSaPLYemskOJre3uKC+8i0yOFKiuQ+v5wiFjON4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu2pkeT2CbgfgdpPn2Zuz7ayl+XthYdcArrCgG1Zpro=;
 b=g1qbXRjRUCmrVKZoq56Bf1DjjR46X4MDZmRhBtDTppe/klsy79aY+m57tvoHuAkfFVjKWEzpN9qFhiBcVfg5Xv8bAJvc57pKpu5id6+eDtOfcbobFFkV1k5P5wOYmwJQHuDcZvWNAWokCrvn3WdQr0FfOBY6A9mRQzTQCveU5PM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 04:01:43 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:43 +0000
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
Subject: [PATCH v8 16/21] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Fri, 30 Aug 2024 00:00:56 -0400
Message-ID: <20240830040101.822209-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa3af08-7d3e-4acd-e4c2-08dcc8a87565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdLS9fsAz5u1d9J4yNn6mnGVP0f5qoZ2xVk4GPP3D5etmuiIKoeVtcgjOMCl?=
 =?us-ascii?Q?EEoT/HgcwyyXPOaIO04K/EgNe+0QZIj20UPVbRTfDEA9n1EIAWN3V9pd7/RD?=
 =?us-ascii?Q?IJez82QBWUx8morc5KI42xFbcdpc74tZj13OdFl5z9IWnGWqOP/LKXSZCZKl?=
 =?us-ascii?Q?zrHv3Sq0WgXhV4EuoZ5dg5fSsD+CsGsYfUDIkdvSIsQ9MNeBBUq/UbN5t2nC?=
 =?us-ascii?Q?8pMC98uWX7r/v7P1+vvEQgFm4vLwl1HwyjbrSOsAx2+ONwUtNP+4n+cOHusO?=
 =?us-ascii?Q?aGogRw6WoU4yI/Lv90lssBULBOv4WGsabwDTc4Lty3ssnNyRAF7sUHBY/2Ky?=
 =?us-ascii?Q?JknszWauxOuwISpVhJNwIC3Yc+RJlvo+DMZZ22vE2lhmy7QpjEbMVyYzJutN?=
 =?us-ascii?Q?aX1V/2Vljo3/8gnlJDbbbkGvTVkbc2J0RpkANgEzJ+ypASfhGlhNCaCEnDwK?=
 =?us-ascii?Q?SztTxENjl7ypFtTKKF8unsUR2lR8ufj+5OuvtR1yp95RcYV/yuMBakDGnnRM?=
 =?us-ascii?Q?NB0uivxD+d1Q19IEuBocIk010wf84qs88hgdkD+4LzdDd405ExiF6AsfGdod?=
 =?us-ascii?Q?kVx7AjIXVR7NsJHTXu/Io3Pu1qYDKvx3IGRDdcTFxhHLpcD5Lg03VrAqAEKz?=
 =?us-ascii?Q?msJfSYGChYxzVg11rv5oAr0wUsHBPH+7izLcnpTEPxPJ/hMKIHczVMXHvxLk?=
 =?us-ascii?Q?YaBPt0GlybkkcP3hD5diuIZ5Lq8ynYB6wuOaOuVDDPGcLe5oL7EL1US+pIdi?=
 =?us-ascii?Q?H+2FbdQjPnh1o8qmKbXcr9mptrjP1A02lqUVrFcpRaQbBqaVdSjrTarfhhZ5?=
 =?us-ascii?Q?aL7VU/OXF8Lmv1v4CDWepSk5WamRbwjJamqaNP67h6zgPmOWmmI/K7SCscXW?=
 =?us-ascii?Q?SefP3eY7V5J/WAHRgLAHMHay6agYe1APs12XT+tr80wHNeFw6wouZwyaE5u+?=
 =?us-ascii?Q?OnK//kG5IbMrKr/qf4eX6pFI5a4Wrb0vcWvuZDQ6S0vVsLZjSSWjml2gD+2H?=
 =?us-ascii?Q?nNeHDo/KajTaTaWAKYVT6hmbXObB1w7P5BaR6+L9yhNwKWRbScCYKOhUPAx+?=
 =?us-ascii?Q?7t9luZmJ+z9MoDf5QuAfHGjx0RYb8pDUEuNbfLmktug19zUNRmgr4CJe3zd0?=
 =?us-ascii?Q?pgAvy80LWNm+8HKA9QwxKXuicver1l6d0bMULxZOi3BzOJuaVP1InNjL6hDz?=
 =?us-ascii?Q?Th6lzG9LUcpsmZ3q2Oilw5YRfMfN/OA2hAJDezCAy2J46ltgYZjP04f8i7L7?=
 =?us-ascii?Q?c2dCBlgN1qf/1fXcxvL1AMp/RmrE5rozZ9/F3l84YURKbvYMWNcqRddesQp1?=
 =?us-ascii?Q?HbBsshwddU9TFSXtjNDzA7bbv+6uJSpdHyHBVooskPsZ4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CXTUPXpezwFqC9FRFPZWEOqcuYg4pE6GrJZQ+ih4DgjndUk5LK6gpa/uc9wO?=
 =?us-ascii?Q?LZ6krAiZojqqhyZpF9Wn8njI33bC+nebwK5pcnbsN1RrHQfAccFIvSPZ24+t?=
 =?us-ascii?Q?E9Z3svOmPNRkZBkBCjU8IJFZ0PnRT04EHfulF/V0IFbAJ5uQzIPKZ7K6Sn1g?=
 =?us-ascii?Q?gI6pnVmgXGLW1ksRQs2PtONeJMdaA5B/JACEPBEwqHuIXodbioR38l5sQZzG?=
 =?us-ascii?Q?Om+qZYZ+QaWSf8y5H9xAs/Pnv0LUdQ1G5FGTJrjc5L7RqfEghlLnO2BFe9Ff?=
 =?us-ascii?Q?1wkoPVhQq8yiIr7WtXQd6h/WCEnb8kqE+GzJQGHKc0IRWo2Ho574BViO6P1T?=
 =?us-ascii?Q?HKslhh+SmPtpTJtri7+OCDwG3rjexCu16CZ6lRhZlBl68FHe99f0rfwqX3Iz?=
 =?us-ascii?Q?Vvbo028oQuvVicp4fH11O2U0lWNUJnFtyFfh+cprb33MwVq5Qh0DJELvjRs4?=
 =?us-ascii?Q?SPuyNIdfmm7ylCx4SqvFRgFk8T+ORAKPXdD8iypgApYfFvS1tOGmcWhRmJcu?=
 =?us-ascii?Q?a/JZuJwV09bN4Kiwia8xEXeDrIu8EdgZWef10zfySPANzmUA4nkI/OM8NByl?=
 =?us-ascii?Q?vXHmH/mjK3XxB9NTfplmWEwS/AhDsg9UmosE/Fi/vSzHbZsA2hyME0CM8SMF?=
 =?us-ascii?Q?rQzHqymdX53N6qbH02V5AJ4KcPQ5DoQ73cRCCqAuvHzeB25HbFZnWcCsykWK?=
 =?us-ascii?Q?t9ShUyQtqiqtwOdb+8uNJRzJ9xIgH6W4mGcawXnQTaeR0EFriShXhYz5SMUg?=
 =?us-ascii?Q?bBdUSeKHMVE9HJhwIuRP5LiyhMgy8+eXgFU75dzq9c7IN3C05PPNwNpBkdO/?=
 =?us-ascii?Q?t5AWdFVhzz0SbfdkjXj0wQ/8ym5xm/grduWT1ndb0AqthuxM9/LuxOzv3a3i?=
 =?us-ascii?Q?puz0upmiZjTYEgvH0axzfpqdsql9/Qt8LCWaAUJzTfCf1vq1+6uFVxXbr9ee?=
 =?us-ascii?Q?IvHyTiGDK9Tmz5Y6CvogfAodb4QOJOLfNcTMajXxOMYuiIqyFjs8wWUb8VOe?=
 =?us-ascii?Q?9S4k/jYfx6yGcDlEpvW6q0dDDfXblQ6weTj3gauEzSV2j+IjYP9sazR3W7U1?=
 =?us-ascii?Q?i3jkIg+wMdxsuIyGzo+bkDHI1NcmBafibdogb8Lrir1d3MFV7dUj7/tm75b8?=
 =?us-ascii?Q?II5pYp72OHC3m02NH41ZY+KHiHZWzM6X85tBK4ySqQx4njAGo+grEdNjp5LP?=
 =?us-ascii?Q?wbv6EXZ3sRX8uGog8v0PD+AlH46lX9oBbHFqJ0QUDKhdPNGTYZnUQ9SgDsIr?=
 =?us-ascii?Q?BI+V6abiDXo7mQDpa3Y+sSxsoKLYDruLi7e74BczR9S2WiRCt9wW4bR3Zooi?=
 =?us-ascii?Q?xqdlR8R9vJDcnRQepamCWqEudtIfKwEwh7JAPgYKyNxFvSwNB5BziLEYqhDz?=
 =?us-ascii?Q?7/0huxa8frKbby4lEdKNxlk5VUOsA+q2cBmZDd/rdghFJPjTmYSrDrqCvGSz?=
 =?us-ascii?Q?A0J8ttKIphm6dBieD5cZPKg0AIhZLMhL8zh/UzXL9WVmoKNvhSkIIMIrRuuS?=
 =?us-ascii?Q?HfIYgAKfP0ZytZDUfmqerpBOYSvIIFUy/Mkuc1Y5MiOKsoSzfaCWPzQkRzpL?=
 =?us-ascii?Q?j8/6w/drrKBxeMjwth9c2YOV/VZ0G6voN3VUOZEEOsVhNUXByzfLSZTYCbpL?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vjJYDxKPjuLEJayaxiWbLOwoptTvnAdF405r/eI9Lwi17DExpb9fgFK4SYXCyufnuY9V/LxplL61wM3DvbgULHp1vinXsX+zE56o5AdFaiHGl1YWt2pICrtwOuYE0+v43029+Ug/8yS1F8Luiq9cvA4r8Lnq2Gz2dxjERF7R7cq/0p7azoKHwbOss4trVTRD2oosp1vUoK4Sd0y9g9/S/3aOfnb8xXQeBrnTSffAMGyxaivHBut/RluNdr6nyiqNxCW8cpocTwVoTuYtIb0x5iTrxcTy+psZo/2L9UzBuMfePZxhti1VqiVY2jUdK8Xhc3f1rNocubrFRuIbcSJMQdIllEe1m7Qu+NsNI75O7A5puraaoumrzZ53k/mTrfoxPJIVxjGsf9OE0XfUGea7cm3TFrLGg22JJtmXpZr1EyTc9LHLx7z6Faepcz/NYba14eaetsFSAV8IvK2ZpBXP2pNyLDXZgwfou6WnGxmajWup805Ef20EMPUEACiase8qq5DshKm63Jt8drs+ncOLxlbuXi3BcIBHOZodj4mRa8qKAxYnJ3fzH/8Hws3BC9FX5I4N0h1mEnnq9xCg6g8Lswro50XackSBhNg3OgF73II=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa3af08-7d3e-4acd-e4c2-08dcc8a87565
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:43.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3LTC2rv4wxWELSRkXCA5kzst/kLKALzC+1qWH8+snGZAxFWZIazJ0PfVCvuUGaBqz3xy9cgL+ZgaEK36YEBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: xtpqy_dRwCm76aPN4EPg24Ekjl_gyL1N
X-Proofpoint-ORIG-GUID: xtpqy_dRwCm76aPN4EPg24Ekjl_gyL1N

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e1e5c78b6c3c..cd09dd164e85 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1364,7 +1364,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -1384,7 +1384,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
@@ -1413,7 +1413,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -1574,14 +1574,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Unmap any existing mapping in the area */
 	vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


