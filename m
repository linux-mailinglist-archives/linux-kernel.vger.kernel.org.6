Return-Path: <linux-kernel+bounces-242781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F199E928D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDAEB230C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AA144D3F;
	Fri,  5 Jul 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/1Y5Cva";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1rjtZMf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04016D4F7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201168; cv=fail; b=mMfWWcNEuWRs1y6X0+KzahJ0rHimLMeR+Dj07Td1OPY2SFrQq7LBgvggeMwWMTyHfpcKwbnKHHIP7+/URPVVKyC8pIrnBUIfNl+AHRaiQPgmANYUAD6AsEsr2z+hrkN+nMyVfUyg6GvLdONoMa2WtNFF2Z88m8+23CmTMVZuI00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201168; c=relaxed/simple;
	bh=0gs1yPMuRMdQr3w9aXkJKUkj4e3N4hnPAXafANLABb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kbn3Hwn4ztGiu7THXXgq+ANtzUQf7b6335Zn+nuBgJtY0rPMFWRcoGKYkxprsM1b4zHBC+/SGHYHx7UX2/a0qU3k1qONVgbNp/2t7pHGU7Us272yujrR8z1S5BAJo1Sst4yklNHVoj8v/qkinCeuX7XC7zRV4HxiOXKcinb10/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/1Y5Cva; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1rjtZMf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMevf013563;
	Fri, 5 Jul 2024 17:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=E+pvqS25NEhc8Jx
	90L6LnH9RTcYoIiQo2TFGr8p4J3M=; b=K/1Y5Cva3sJilpa9TrgIArsAy7y+NJy
	6QHTg4d38Pko4wncW5SuVqu45pzHRjxLag1RK+EvoyA2WH0Bn18fBfmIoHlZGQEn
	IF6kOcMcm2SEydShCHoB/gZ2OStuCmePQ7QU2Ol7GYnop17+IXNam9Ek8xY6F4Fx
	ROQrz7b4fHiXQDdC9inA0yhJ+daWkVrDoy1HsRhLhtY8UFeu40d7Y3kdAA4MuvRv
	UMy9Ymv9RopmNFVIPSZYZhPo4v+ieC+q91Bl/x08q1e12dhzotaLj0nAVaUJFX30
	fU64OBsNbCHEQyWlQJBUsCkKRHLSBef2zHUWjVTsOxm0Kazgwf7KA1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b4cb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 17:39:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465H6DDu024208;
	Fri, 5 Jul 2024 17:39:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12jbwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 17:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqfv5BR+Gyy4ndQ01RmhV/Ay/SPMF9r3esKd0ETnD1GNlVR3n+d+mD14UKj+bZneAIWzPwNl1zr9KuGxEu2KEFwfL46cXExkPHRPLdtGPvgY4XOuchX8Qiq+Yy1nguh6/Sdf50G1C5yCYa5Fm445MRw/nPYzIvwVspnohMs5AXk/3FKAKSh+KVuDbLJHaii5hrznZKEA2w7oALzQFy4RVb8nv3Mtnc0JB+XqF6QeiZSKtNTyJUq1kDgCSFd4R+H5BgqWQJPxW7LbhxEmCSrq51wZrZZSmoDuXMZ9QyhNriSCcKnDRxFCPHHZyC9fuZre7K0dRkmOSCDQfQL9M1qnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+pvqS25NEhc8Jx90L6LnH9RTcYoIiQo2TFGr8p4J3M=;
 b=KoCRMjOgrLwhfQTLdOSBwmXf5sPRdAX9OAsWI0LB9VopKvhxe5u6mOOljx+EtecduDmULXQuxnfBCQAqFr960oplbJpHDyupppNZfbN1/qIKiIZ+RrOiTfly3dOw/aPSY3PR7XUVeAx5+nghTS3YkUyOT0c+/kIq+rcioeFxeEdF+20wrXGMlKej8PjqyRDvjOjfKNKIuA4pk/xvWc8v70mxuYw1r2HnkcxsfuGbPa4V/lwNwzklWbZqRKLbx7fpZSsMAUUPzABuTLs7DmYMfBrAcGmVOvJ3o6gyjXGJPXkxk4iwsKw1lZw+bNGcLofYG3F4zQbvgSe3V1s1S9RLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+pvqS25NEhc8Jx90L6LnH9RTcYoIiQo2TFGr8p4J3M=;
 b=f1rjtZMfn/F8MQehgs6D/+MB/UsCkz/gfkJJTERmgWhHHUA7uFg6djQ3Z9WRfI2kAnCBH4Hha4ZVzNCKuH8B4g6hruD0i22li+DeLBfAUwlwbb0dj2OeYC1285sNhUHro3fzKz5CvoqvIcRNLq/PKKuusqu84A/g/xDJngtW3CM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 17:39:07 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 17:39:07 +0000
Date: Fri, 5 Jul 2024 18:39:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 03/16] mm/mmap: Introduce vmi_complete_munmap_vmas()
Message-ID: <6f082ff6-78bf-471a-be6d-857209d07726@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-4-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-4-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: c244b6df-1181-4b64-f949-08dc9d195f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fqxMmtRHT8Ota+wa79yTTuDv5MVcvWdlTwd4/HretWKl0NUIm+NHbpRj7DgE?=
 =?us-ascii?Q?ZHOunlge0k14bF6HcPYMHlRVdXz5xoOw22scRMAKAaJwod6zXJX62XZ7xfhG?=
 =?us-ascii?Q?HwoWHSU4jENwmq/UNORwvf8FQIojMtqyManFH1SC65tW5RWFX839zOx7r3aP?=
 =?us-ascii?Q?MuI9zFdI/Y2Jt6oeVERZu4SPF4bMTDTfqcOhG8i9f5SR/HuMSiqdESMrTm+h?=
 =?us-ascii?Q?dCYDusHBvzpPcFaWYvqKcYh0T9Bk6G4rHTBuDfidTejozUnG1IY15vEsGefs?=
 =?us-ascii?Q?evp1Uu0ropzud921qQs9Vk5aWGfU/XHu4C9El4tsqvU1ljxpNldEXayk3jh9?=
 =?us-ascii?Q?Cjvc04CX2Sh7CCxlHaJ0y06mDqCWoVrUyKv3oTaEBR9lGspQEX+yxsvYjfzZ?=
 =?us-ascii?Q?nVOjcjuP9BJQON2tO8mZcFGVfygYAsLw38f44NaET6Xkawa6MCmCLa70CtU5?=
 =?us-ascii?Q?oBNzgKbm4xlN9rAXPjv5E6edjVeJAufClbJNO14EUqNRtXxxVR54SwTlx0te?=
 =?us-ascii?Q?yvWnubRFTEPuC/M62LYNKQIc48KBgGMDCtB+BmJubUNmsG07z8b/CnzCgeEb?=
 =?us-ascii?Q?mmTb0GgPyiMJmgooPV/W14SxhRWYVR1iU4V2oH+7LGjylOh8B5qYgadpGKmQ?=
 =?us-ascii?Q?WLJyKfFWPhpWAe8tZRBtl4vopL1Q5OGQRjLOwOKeL4dIHqRS+Oy/hzUDStUp?=
 =?us-ascii?Q?HZCYXxEbiNILnrr8mIfVxxPfHJZw80RmUF6YNNRe3+57ZYIBNWlvRhye8Ucn?=
 =?us-ascii?Q?H+NxH9EOPKqM8mk33YAj6dRKA+Pge4krQCpw0wWLeBNtZtHEXtP7YmfxFnmo?=
 =?us-ascii?Q?WTJP8IZo3UQFYrp+HDTXjBZHIT1swowaUxlDhXPPWwHBe/qZaQp7iV4h4BHt?=
 =?us-ascii?Q?U1IwkCzZ0fff5kfhFuGWR7Zbp+bQseUSj58RsbCOZrnC8p4bYWgJCBxszUIO?=
 =?us-ascii?Q?Y8wk+b13WB+v63wUn7woTnnrRE9GKFkBNjUYn8K+T9XAbmpCxPWlseaC6tzG?=
 =?us-ascii?Q?5IBlss7A9dBrdHgf/vj4rq3UqS24rvcdgMdwzxUlzzj1qON933ycXZh68NOI?=
 =?us-ascii?Q?U80Wzd0EHkfwrcQtOCywJ98kPd4mevb7pJ2ZG300n1usgGFqZwOVoybIrpbE?=
 =?us-ascii?Q?yTE+25dPzd5pRO4AYhf15UAyE6QYsszye9Mz/02YXoFFeYohXGopjrO2iDTg?=
 =?us-ascii?Q?IftDckE5YBhc7+NnEpjebD+f/mD7cf/GYP/BF4DPoogEjiJFY/tyD1ALTLY3?=
 =?us-ascii?Q?ZfPQyKnm+QVFSP2cmPdjcJ+2s5FW/VRM3YPGJuo1TnWUWuJohPY6tcQFC+TK?=
 =?us-ascii?Q?2dpmyj9LMjFYxhQ6KES7n3A2f7njdpem9J3Iq4VO6Zro/g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O1cwDiIPhd20HYBFH2z0LGUkN0nBmnolXQLLdWBx2Z5FGtf6W/jnpu8Yrltb?=
 =?us-ascii?Q?Y0DrwLeBmmX8rfBRdyUNCenC4NP8i4UrOiwFnyFEN1S4xhgcLRztzKVZ460q?=
 =?us-ascii?Q?U24YQgFdHGo4JMhbRD0NryVA1ECYVg00C+IgScrBnGydjGoFDSIXlyUmaaRj?=
 =?us-ascii?Q?bOxkCiZCixYBQbDpE0J8dCnxSS8QRcCk+nrXQVXoJfvh9oAt7hiLlgzq/XnX?=
 =?us-ascii?Q?1jKq5brAs89QsgOZPympH2khmAXW5bN+tj7CSx51uhsnYHiV4D59iso9DnOd?=
 =?us-ascii?Q?7Ai+l0QVFL+08Q2j7fjPmIs+dtRYjMN124x+tlAkDXqxCf5ZDk+4X9kSwV3C?=
 =?us-ascii?Q?KteKe6jVM65Ta9zEA65kboHcDiqHyb+Wj/8wt3wqASITjkY98bdBkLV1gkEL?=
 =?us-ascii?Q?hMmeraMZvyUtKB325owcZXPeZjoqwBkjYXSCtI64OHXY9qcNvkXZtMaG0Gp7?=
 =?us-ascii?Q?eSn6IeZ1JgGOP7/epunVExSAgMSCVtB2ezdRBZsFl4jLAGt4Lxq6hKS32pg0?=
 =?us-ascii?Q?7yZqyvaH37UHenog1mFcIBs68wxBPRdgkxUDTzFpaE2ll6mq2Lxun40SbUaV?=
 =?us-ascii?Q?oUsLikoowTgt/v+dW4quZM6EUPHdJzxs10DU7gJOGZfYMji3KkLwz4KzNLkw?=
 =?us-ascii?Q?MaVqNTx8kzTIsEZ4M1xBObWPCzoPG8UzlVrFrjWA760dzTKY08CJv+I7jbe9?=
 =?us-ascii?Q?3cdaKyLjfaNXCyWZUcP43uc4rpqsnXjxUMdD6UwMN5mdNC/szW5GDiKsbVoq?=
 =?us-ascii?Q?EZ68b2oWh+v+6eNMRkxv3VNaga6D7xaEVjEE6p4dhC5ra9sL5RtnpXBeR+YT?=
 =?us-ascii?Q?qzeU2dR8xCv619xgfy8/Xsr5Zmfbr1av7SLXBo1cY4H0/XciXrrt/Vl5UyJ0?=
 =?us-ascii?Q?D8kp5m5KRjEB74hjyQcenLzXQakKw9JuKH4nulsxcBpwkexSne++RcyAxDAD?=
 =?us-ascii?Q?ZC4kAgdlYt2dp9g6qfJtwXqKIQtDokzdeisddXhUeQrNklmmYaBMyrlWFPtO?=
 =?us-ascii?Q?6T3VCE58rPH9RzBtwe989kzgIRe+/fedkQKLf64Hu8nXS8H38JcmMMn32kSx?=
 =?us-ascii?Q?GAAPTwPwkPELcYJknMuiRr60P5wZF11xUeQJPscl+Vwq3aSnuBkNmPUhQRl3?=
 =?us-ascii?Q?NsKKAoIuVws50t8d/bdK5U2cKfAwCscjYfzw7MTJpUGpBAC1p2cWeJfBo/78?=
 =?us-ascii?Q?qjn51q7iNtiN2KIEbAlLSbOaPzsSkLxufyJUXA4I3jbs0uPSV9rFxJMWlS6L?=
 =?us-ascii?Q?JmNatNGrqcIKnhywDXAOpzykEtMu84hSOhalPbehAAy9lf/inpqE08JC6ydU?=
 =?us-ascii?Q?OU7/jf6w4WpS50wvTV5m7+7qYbYF/RwbCEnMcVUDJRo/bDHjKMN2FDquOGvf?=
 =?us-ascii?Q?pilRGZsgoLbThoxIamujTdHEAOcL7cax1MJbKkeLjA+gQLcF+gemY+M5bDUf?=
 =?us-ascii?Q?WXErLYLjd9OBArtRuV0exE+ZfkRpB8KPChAQlEhLzaxiJHEai130gGAdPsWF?=
 =?us-ascii?Q?I3SKLlcpJbqe+K3W1+fXPNceppW3OMMBEVYdeHcUb0HAZI68sUGoxInlSswB?=
 =?us-ascii?Q?Q2uB4/kIL+A5Z604IRCsIOhDyDtpXutO2Ot1l7hVUuxgtrttS6OWRiwknBAN?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	barHTORFyLK1rtwmgxHLSjHicGHSBQknqR3xVIH9DeH+NKf10sp5IQWWhzy2mAH9TphK6nF9D3BWV2w9hngb+gmuofWibroTVg8/FXRd/1JisxmrbXeMpzPEmxi6V2ycwbqov4AS5h1dU6yiAcQVLVXeFKNVU+mP+6TKlQ2iGex2sr/HynC5/QqPACimbv6inVpEEXNoH6arWN0c1+qDEixF3BGwCWxObKBpPAw5c2ksCgmI9jJhdTwbw8X62Ym5vWktPmQXezwhj1352jvYBbmqfeY7ooSr+FKKi+4XnHAYIjYEZBsfaqzVBzKjQeAGfYZ209+fsDcHbWCMKI6vjfruC6u9dPbaSqybLN/DFw1tyoLzPqAs4TPk+naASkbUideMclXASCqxtVGhAbE18uLn0aOxBpMaYd+BJKec8TfZ6zVIzkSH49/+erZLsHnTj9U4yEyssp/ifwdSEvYyLsh1vLvWH2LoiUqjdWlm7qaCDw+7TWDNH8iY9kZQ5QRHoxv6B3YimnZVIm0HTOEE5IwvEfLBp6nOF3Fde4szqka3VowDOq6ZOyeFMo7/sgSFD3Jjw+uCe7pHZ895kJX7LxVTedNOP7TxbfpxaNkiDnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c244b6df-1181-4b64-f949-08dc9d195f03
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 17:39:07.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOp9sbJZ6slAtqso+4BQWVy4SPzpO87BnQX4vG5A2gC2iN0EZoE1xwsKdzMxkllmXLLA2x7KNzm+6wwh6kTMsT7wx3+pUaBUrVRzYttNsLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050128
X-Proofpoint-GUID: iS9P2-MA0_9crcQ4CG33TKC8T2wo3ukp
X-Proofpoint-ORIG-GUID: iS9P2-MA0_9crcQ4CG33TKC8T2wo3ukp

On Thu, Jul 04, 2024 at 02:27:05PM GMT, Liam R. Howlett wrote:
> Extract all necessary operations that need to be completed after the vma
> maple tree is updated from a munmap() operation.  Extracting this makes
> the later patch in the series easier to understand.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 79 +++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 26 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d572e1ff8255..411798f46932 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2605,6 +2605,56 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
>  	__mt_destroy(mas_detach->tree);
>  }
>
> +/*
> + * vmi_complete_munmap_vmas() - Finish the munmap() operation
> + * @vmi: The vma iterator
> + * @start: The start address
> + * @end: The end address
> + * @unlock: Unlock the mm or not
> + * @mas_detach: them maple state of the detached vma maple tree
> + * @locked_vm: The locked_vm count in the detached vmas
> + *
> + * This function updates the mm_struct, unmaps the region, frees the resources
> + * used for the munmap() and may downgrade the lock - if requested.  Everything
> + * needed to be done once the vma maple tree is updated.
> + */
> +static void
> +vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		struct mm_struct *mm, unsigned long start,
> +		unsigned long end, bool unlock, struct ma_state *mas_detach,
> +		unsigned long locked_vm)
> +{
> +	struct vm_area_struct *prev, *next;
> +	int count;
> +
> +	count = mas_detach->index + 1;
> +	mm->map_count -= count;
> +	mm->locked_vm -= locked_vm;
> +	if (unlock)
> +		mmap_write_downgrade(mm);
> +
> +	prev = vma_iter_prev_range(vmi);
> +	next = vma_next(vmi);
> +	if (next)
> +		vma_iter_prev_range(vmi);
> +
> +	/*
> +	 * We can free page tables without write-locking mmap_lock because VMAs
> +	 * were isolated before we downgraded mmap_lock.
> +	 */
> +	mas_set(mas_detach, 1);
> +	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
> +		     !unlock);
> +	/* Statistics and freeing VMAs */
> +	mas_set(mas_detach, 0);
> +	remove_mt(mm, mas_detach);
> +	validate_mm(mm);
> +	if (unlock)
> +		mmap_read_unlock(mm);
> +
> +	__mt_destroy(mas_detach->tree);
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> @@ -2624,7 +2674,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
>  		    unsigned long end, struct list_head *uf, bool unlock)
>  {
> -	struct vm_area_struct *prev, *next = NULL;
> +	struct vm_area_struct *next = NULL;
>  	struct maple_tree mt_detach;
>  	int count = 0;
>  	int error = -ENOMEM;
> @@ -2728,31 +2778,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		goto clear_tree_failed;
>
>  	/* Point of no return */
> -	mm->locked_vm -= locked_vm;
> -	mm->map_count -= count;
> -	if (unlock)
> -		mmap_write_downgrade(mm);
> -
> -	prev = vma_iter_prev_range(vmi);
> -	next = vma_next(vmi);
> -	if (next)
> -		vma_iter_prev_range(vmi);
> -
> -	/*
> -	 * We can free page tables without write-locking mmap_lock because VMAs
> -	 * were isolated before we downgraded mmap_lock.
> -	 */
> -	mas_set(&mas_detach, 1);
> -	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
> -		     !unlock);
> -	/* Statistics and freeing VMAs */
> -	mas_set(&mas_detach, 0);
> -	remove_mt(mm, &mas_detach);
> -	validate_mm(mm);
> -	if (unlock)
> -		mmap_read_unlock(mm);
> -
> -	__mt_destroy(&mt_detach);
> +	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
> +				 locked_vm);
>  	return 0;
>
>  clear_tree_failed:
> --
> 2.43.0
>
>

LGTM, feel free to add:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

