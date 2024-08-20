Return-Path: <linux-kernel+bounces-294699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C6959173
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF29B23B96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F521C9EDA;
	Tue, 20 Aug 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMWW41EM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvyCKn7P"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825D1C8FBE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198298; cv=fail; b=MfzWZHaCLUfpPY6h2/hkd1v350DBvRnfD9wA8EDAeEBJfTWAsXdDuy/J5TrBf05OI7fRw5mVssPdzWTv8Pu6pfxMqd7W0aUjv4Bt3vuE3cnq8hnfS9UGBXHrVrSuqc1opSG1oArlZWl79p8wOV8AQHv6t9yKMEfSAd3P+SPGYxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198298; c=relaxed/simple;
	bh=USyM0d5e+NS1vAmS7PvP+N0ZqvpcyNvxzzdwm3sdw8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXPhEa6akLNnExf3hmIVslb82CxsZpR516mM4+vjbKB+DJdpuNGt3J011JhA7gC10UdDG2auWmbcJUO7iNkzdvp1uGmc6O2VtYC05IlavUGRgIeow46zwpZfhAmWohJ/glrxETTXHn2w9LLZaSnpl7KmBul1fxTq9/VGXRlaO44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FMWW41EM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvyCKn7P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBXE3005239;
	Tue, 20 Aug 2024 23:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ttsU2jqtp5fvXasFNgS0NAcV2R20c5Zpzh7VMtrTw7I=; b=
	FMWW41EMAMgYELv+Yrv7T7SfOamffpGVZbFCt+Nev/BVC8zc0GA/9ub36ryyuHPS
	X57WjyKDt9K5bkk2ia8XgWk2ytqba6G8xNbMd4rAgwP/ciykduqkKFgP1IgSIqEu
	9Vq74lUJtiRqvs07lRNUTJXhxVFhZUyQPqUCddtLhDO4xdLk1O05iHFJyq1jhzjF
	14oBayeSZ5asgpgJ+9Co75a8mBePSGWpmM2HHVEN6VVVTLufWLjX1Rfyr+vwQ4jw
	s103NQ2cfLznNNrO8HD24OJYzKIOXUbgG6oy4CXhjiWnLKLp1VWGiLI86P2RtrrL
	nCGQ/QEjcJZd36cvvxBcDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj0mm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJCq040079;
	Tue, 20 Aug 2024 23:58:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e337Fl4lN/Q7vg3uAuv8DiybjJUJ+Uj34n34Fcde9vA6yZ6GE5uFVmlorZWEFCDfYZp4+gzFmpMVTK6OFqzHfLfXwIiusfG9SMI8UA0Dlo1TDTENDwLvmsgk7GDAxtA+zVqQUfD2gikBL/wI89n+uSDljte1KmTp//1A/9Ne73SK/O12bYY57V2HVvElFWO3ofSVLaudjiPpQb2/JKF8PA8tj1wfK24yMhefyvw2NNEFdeQS6W+kEhUXOxjiYw2lK4f8qe57U7emsjvIuc7zHn7G1EZBVfDbNPcuYJVpYG3YCNt4+iWPqyKMk/z8tnP3oyUiXsImUVeGg5ZCP8mc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttsU2jqtp5fvXasFNgS0NAcV2R20c5Zpzh7VMtrTw7I=;
 b=xAt9hqAmvH7Uid/ZEAF2IvEh6Inw+e4LZ4gOtSGSr+74mlJJ7UUrU9pq3ktRbkzTFj7JYQ67yljkRmWW4ModTSHxas/RbKRAZ6Xh+sMYzCH7tafJxG85XNpXo+IwZAH3RngFEnAxawrAztQVPmvXlEfnfWIHDCjukYSj/Dus2+MaYT9doh3825M9GfiVYh/HvqNKo+e3uWY1QPmbP3CidvDc6XFJ57wlyMLbhhNAKjaOCUWuMI/Yvk+Vgvb1tO4qQQhHd5/0t+OVwBk2GGwznzD8zVR+lPfDAHb4SZY/sGf2sMTXyrKsS+uuT3NOd7tanVBN6hgqhSTzEpugfBaLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttsU2jqtp5fvXasFNgS0NAcV2R20c5Zpzh7VMtrTw7I=;
 b=dvyCKn7PveBsNQCpLPh5HG/IBBUfks6lCDX3I9horSN3xxwZtQyeGozRc9grGn3xD3DI8+MQJiMRVRwZiRKzuzguIC2EE3nUi8+knKpQGzTIB3fhIemqc+ASqGkwdGjGF7lxvuskooAOdKZwE+sM75yMLiPZMPdjTJpqDx/ihbc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:57 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 05/20] mm/vma: Introduce vma_munmap_struct for use in munmap operations
Date: Tue, 20 Aug 2024 19:57:14 -0400
Message-ID: <20240820235730.2852400-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0427.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: e7759fb6-d8ec-4bd0-bd43-08dcc173e9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zh7AF0ygk8UwplSDpU7ZyO2iC+5/6YgPO+hx2wUIGCvbkT/1TBeobaZRaCme?=
 =?us-ascii?Q?29c9GAeRWepSs8RdvsqqzDUe25hIecvyHqDkM2ffrJIZ2K0RKw3sL+K9FziF?=
 =?us-ascii?Q?CWK5796VJuIFWZMuihTrFn2/Oyio33a9SO0A0CBVOcR8McvvVI8YowgME7oa?=
 =?us-ascii?Q?glo0iUxlT+zCx4Sb8zDHmnKs0T4zKnCsn1cKad/frmm4qVpAbQvq1X5q7nlA?=
 =?us-ascii?Q?uvPwGTLXk6ERVcmSUQhOrDyT91Zpb4q6O5HWzcv6mIDmTDWIYb8dh0F5nwdp?=
 =?us-ascii?Q?p73jsCCnOJUe765oMZbP2qX9qQAH9IZAUTUkltrWwF1YonEk3BOMtfwm2Gkl?=
 =?us-ascii?Q?Xiy8vXIAMBytEqVYv7/phdx0iBzl1Xn7nAfo+9TeTD9QcpfodNNBf080c8Zz?=
 =?us-ascii?Q?STyQ4dhu4Zaogv5No8rBkuQgHKDxeuVwxrHwVn38PU4duHG+/OZmugGXykuZ?=
 =?us-ascii?Q?H0jKGIRwlGsxSjvHHRddblj8gMdTWLUzMTgECeI3+0+ROi/Wqk8tKoCaOHqj?=
 =?us-ascii?Q?4Hec5V9Pl8Rbr3Z8TL14tnJ9ni8XgnCQms0Dv8toEvpiT9ZDfDmeYTzQzGss?=
 =?us-ascii?Q?EtzW7pOc3wVe7esTPFY6m8+KPqTcxUmBNoVaBfEv41s/go8R0+IvYRFxqwDF?=
 =?us-ascii?Q?vlg7+NbMfkKPqr9XTW6tcPQ7hEgBb1rDICWcdDvNmbW9FBszlTCSAEZ6DlXU?=
 =?us-ascii?Q?dj8cCuWZPL/GYtm/qmzu+EkxLnpdBXn7A31L96SzumJ+VJgiDurTqYShemWn?=
 =?us-ascii?Q?zOMfa0RbpwNDZPPD2UNTS60cYor7jtdE+mIrAQeiHV8XQsFBxsUAKbO3HGjQ?=
 =?us-ascii?Q?5rH/3cAvpXgHVNOyilGhOa9vK5KLAv7nq41b07jbEpwK2TPWvIn2QRaFy++W?=
 =?us-ascii?Q?uKcNyzc3gCoYKJcbORl5Kn4Pp9OINa3L6jZoMvGIfENjO22TC4y1AF/1jzzd?=
 =?us-ascii?Q?uyQBVmHCKyxbqB8lm3sVcc4xbTYwEXq8cqoovKqM17SYvBUo3iPlV8B9nn45?=
 =?us-ascii?Q?BuxiDBBucmpczVNTbffEIiJ6yRGpSMaARXqW+y0FU5pvdK1ATtrP8Z3JHRd5?=
 =?us-ascii?Q?Clp94TneKo30a5DcyPFVMoA1qspoolQXE5LSvWjsL+j0tEGEoEBuRyOpGyuc?=
 =?us-ascii?Q?Zoi908xjYUf9AzuwRs3y1+O/VIYA+rX4cMqQZpqlp9rEHKKHPt1LdPQY3LQn?=
 =?us-ascii?Q?6rfEZmoiqT0NUyBB+Xq43vRZ/uH4trjwj+KZ5fctmqnLuVFv3sJ+BwFJ6uxE?=
 =?us-ascii?Q?jeCn4tXjPJpuO0VuTsPlbYKLfhV7/bbjNIN5jysT25RNp0ylMCpeSyJD0NYq?=
 =?us-ascii?Q?LJm9YoseGrmTnc5BWV1YiNmelegUt933JkWINIXO8Y+gAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPo68WCQIvg8wQg6Ns4gYonoEDyxjcQ8fygT2i5N1RRiyI/sCvxTCPTVZ0yN?=
 =?us-ascii?Q?QXK2epQxHoEmxI9IwwBooWdilPVVV/K0jc6FhaQSuaIy9ae1tKo3Ws9CQsg8?=
 =?us-ascii?Q?9nHYZSMy7laFbcairgFaSDAOpDpaFDje49Xb/a5Dk6OFkwO2tsJGKvKV3lo4?=
 =?us-ascii?Q?bwI9sORggfn/OLgQDYLEy72d4BKGEVnRApsc4e79/PreSFjBK6oRr9m4+XLu?=
 =?us-ascii?Q?ugHDyTCNLWI5Jv/hVQvTHxi7heIrBLAfwEmdowCnFC9aJuQM7YBY9PudIn8z?=
 =?us-ascii?Q?HP0r6mv8ERXxUxaxYiKhbMRcwbQIF0Ofk9jsDtPn6ibSdFIWyilZTycEm1Gv?=
 =?us-ascii?Q?+Ngi6da1MGRhLypxsuxia3S6qJOhtj9L3wLNclgydOEjq4JRTBjlCYcbilFk?=
 =?us-ascii?Q?Dj58KpdS8P5dPNRe1+gvjnPb4Y5+m8V8C4K7zrVnhSahKvlWz7JFLS/d3Ii7?=
 =?us-ascii?Q?QbmqpHRgK/rbSC2VDgdXiKcYzO0VzBtBHLWCRnHCf9CdWo+o1qijuQXbmLo+?=
 =?us-ascii?Q?LxSpSYgzurmFhRc3NYJFHOAj4CBXGExnA/gV4AbWpIXqbyViRkzhoF9s9NBU?=
 =?us-ascii?Q?Gjqs2JuNcL0RqNdZ7JNZb5wW7bTx+d5OITH7CTM2DS5YWUoLXUsX/hfMmZWq?=
 =?us-ascii?Q?oQIouUFCl7AycYB2yixxxwaxqS9L3x1N2gme9iAgoGr8LSFS+VIfIpM1nQjA?=
 =?us-ascii?Q?gK+0/hytMo7dHeldn/TJD7DVaAS3o7DT+K0enzVSvNa3g/fOfIGFo8LItpey?=
 =?us-ascii?Q?PCtF7c8xTnG07IQOfcTtvnaDCzQCD7uNx3ddRn+Tlm4q+wlpNc7tVwABrjud?=
 =?us-ascii?Q?/cuZ8qXvMANbhaFf3cSOKlL6d2avoe0j9cGNFc4uYEjTF++bTd2Ihpiso2fC?=
 =?us-ascii?Q?bqIByWPqIQloN6iGG13agwNc1HcU2zDtxNjf0trg8MlQIfl8owK2YxIxEWl/?=
 =?us-ascii?Q?dj4xRAGW6zDRXJkDhDwuepOZS/DUsuqO9XcQ/XjSGDbOIdrtMaY/giC0QeaV?=
 =?us-ascii?Q?BzVJ9raTOsty2T2QcoMJXw6tLFy73NxQEzo1fM3eTIZaj6qCBpX1YEnSpAD5?=
 =?us-ascii?Q?SN2bM/CwTBgDHx1g/NTuLSjLpIP2l9nZksFi8yoqrxuhqylmDydlGaVnwWHn?=
 =?us-ascii?Q?OVSkax983+OHslHGyLpuZapXmFtsrXItyuI7XKgwqKrEeFOZgWd8NWpASzhe?=
 =?us-ascii?Q?takoYp2nJFvDXoZpzTrFhEPHDiqpI1i1W4BBKwLS6cwOse6g9FkXz4AUaKqT?=
 =?us-ascii?Q?YttZ5/GiE0WgTJy0B2WF6umTfD+biNNLeXPFttn2NccphDCQk25muPSkd18i?=
 =?us-ascii?Q?GpVEJTih9xYJ7KXeDxY60UY6GGcf09S+KXn14Uik6hYRZZk6NXDhcdVE4MnY?=
 =?us-ascii?Q?VGsb+Jm+6PEZrho70EVNhlVexy2w0hO4ifLbwrom81mp8pwa4zEXm8+CFovH?=
 =?us-ascii?Q?KZMcXydjndov9Ua16afiGxbSNFW8bxPha9GbbqMVDj8Loo4FlTku+c8N/at+?=
 =?us-ascii?Q?/Dz4YqEU5o7kG8wFEdfYA4gq4w7QWb1zPpw7Edg2fGVXyw4YaZ/CqYPJAzar?=
 =?us-ascii?Q?nNTMFO92uRWOqd3EAB6qIN6rvWTnwOa3bHz8yZrr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23SczwdhUVMuqNULoUZDVZS94TzUX/f//Ecdt3FsLT7Pre2d/uqu/HxT/bw60y4whiiHZ29K6liJt8z1zNzs58iu3nuKpVurhUlxKP/dBvT+wtEQCmaq2fSb3lyruLjl7D7btyObAAEWVnzcPNsmxCCKIyuCpvZ5u5QrMcHa4BEabXWhoJAuYsLaKFmFJRI/Zggu9JS1sxKIPJzORx7cQuf8JAeuX+u2PDqcXPRKY3fWyb3dRGkFhWV04jU1LzKGtDX7Yh/TZvs7Th590poIh6tjI9zOgkRg6oIjHh0KJQPTiMGq5WJkP/WemeMupOVOFZu2tI61gjiIoP46Py+XoMuBGqCZnxSPaANaIImOJdeGmkoQoiBRx4dOOICHVr0kyQZ5R6Pf2nX5x/r4aCao+0aaVyhtofIJrtTx+THZ3qTwv3rLm9CSqBG+Fe4tVUAd1VvW8j6hVeewXFOyjRE5qMtTMWJCHDfVx8139LV4cSOpTGT3gUwCEs+PiNKU4mAQ3NSDE0w0weGt4jPYmB0W5Z09xfS+p1L7ascBPAcCXy0BAmneH7uDeJhluxZDSJhC/d90RRN00MVTNqzXkHR38JRiHr9mHZ3tvoOi6APkF2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7759fb6-d8ec-4bd0-bd43-08dcc173e9f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:57.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh/cRlWWkbniJEuHND/A38nn2+C/XU5wEGjzrNEsiyZdwLm7U+UYjjLoU7GjdvsGEDauVNzUS1cxxyZ7if8Qyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: ZcCOpgqyqCSYHzYXJZ-Z_8CQ4o5vUScW
X-Proofpoint-GUID: ZcCOpgqyqCSYHzYXJZ-Z_8CQ4o5vUScW

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 142 +++++++++++++++++++++++++++++--------------------------
 mm/vma.h |  16 +++++++
 2 files changed, 91 insertions(+), 67 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index da489063b2de..e1aee43a3dc4 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -80,6 +80,32 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 }
 
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
+	vms->nr_pages = vms->locked_vm = 0;
+}
+
 /*
  * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -685,81 +711,62 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @vma: The first vma to be munmapped
- * @mm: The mm struct
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  *
- * This function updates the mm_struct, unmaps the region, frees the resources
+ * This updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start, unsigned long end,
-		bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
- * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -771,23 +778,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
-		if (!can_modify_vma(vma)) {
+		if (!can_modify_vma(vms->vma)) {
 			error = -EPERM;
 			goto start_split_failed;
 		}
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -796,7 +804,7 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
@@ -804,22 +812,22 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		}
 
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -829,16 +837,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -847,27 +856,28 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
+modify_vma_failed:
 	abort_munmap_vmas(mas_detach);
 start_split_failed:
 map_count_exceeded:
@@ -896,11 +906,11 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -909,11 +919,9 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
-modify_vma_failed:
 clear_tree_failed:
 	abort_munmap_vmas(&mas_detach);
 gather_failed:
diff --git a/mm/vma.h b/mm/vma.h
index da31d0f62157..cb67acf59012 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -26,6 +26,22 @@ struct unlink_vma_file_batch {
 	struct vm_area_struct *vmas[8];
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;     /* The first vma to munmap */
+	struct list_head *uf;           /* Userfaultfd list_head */
+	unsigned long start;            /* Aligned start addr (inclusive) */
+	unsigned long end;              /* Aligned end addr (exclusive) */
+	int vma_count;                  /* Number of vmas that will be removed */
+	unsigned long nr_pages;         /* Number of pages being removed */
+	unsigned long locked_vm;        /* Number of locked pages */
+	bool unlock;                    /* Unlock after the munmap */
+};
+
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
-- 
2.43.0


