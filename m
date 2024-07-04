Return-Path: <linux-kernel+bounces-241595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783FD927CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFE1B226B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B41369B0;
	Thu,  4 Jul 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jsM+xrnI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="REUuntBz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F273448
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117668; cv=fail; b=prhdeWV/gSAhjwp9F3jqad5FiT1MPQSgeXIKJyhgKCWITMhRQq+8PgWd3PdBxMwLcRtFK10ERyERgFn0NWLesItHFb7pHmQRAbiDt1DyTG97D3G8RkDAo3xd5cBdVswB65fRfqDviaNd+9ahLS4EY+4aNX6jABbOTtnslPBs/xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117668; c=relaxed/simple;
	bh=ZPESTzeh8XvfaDK583IP69YPpytuZWpRLgai7JM9aKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQCMO3AolvLaFZLFzpR5M0XuQ+6pKFw5BmUpz8nIDq8dG839L0WtfZSNry11gYMWr72q9kIi56LIEAaKwfLoPSlGTrWpqeOTU4LyaDRiD6b+aE0zFp4bZ290p8RYYJKZc6xDmA8sKqAN/vZb49XWFA2+SvxnP2mSOF8F0DUBq5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jsM+xrnI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=REUuntBz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Dn5Yi016715;
	Thu, 4 Jul 2024 18:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=; b=
	jsM+xrnIjqhzDKoVS9tHCNWhBskZomXjdCvR/Iqg6rZkTtWR0hEsAPTFqJN9irSN
	+/AtvZVMLNRElKE4sSp5LZgdpN7OZJH4K1HTHV3g140Siy+wao76cSADJmXaJE15
	JLNIeL1Yg99Z4m9+40YD3q13O9nzEuzppJx5R5V2p+SjyKbB2flIf01/Smv40I8e
	QIqyNIsc9bV20RUqoENE2jCMjtfbeVuSTpNT300cuXcN5DIPOSCqLyhPALd76Ied
	bh4zP6nx+HTuywDVYCRfKKerSntCk+W9wmH5TT+otRgJ/qBQJl2kj7zHKG4hDT60
	vEXGOvkebhrVRZ99ecahIw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attjpgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FVlJE023459;
	Thu, 4 Jul 2024 18:27:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11kmh7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpss7cz9cQdKGy9YGVCHriUF+LLEOzMeinsFobKbwuxAjzpAW4RhvDFfGtuufMRILBC1U78BsVQQsuDwq+8JH+fIGYNeMSMQb86FBTmJdMRzxbYPkoV4sDTj2EdS3wOjX2ApbjIyPyxOozkaaK0IKXpXybwUK3oEFnrib/48fncQWfwHwwEYmn54eFpeTwWRK/XSJS0pqZ6k6oZWodhN0rHKFDjw3VqtIeP46Xw8ae1nGu6zsjnez85628skBKyeehmQuW7lV5NRoDNGnebZKMbWzUIAlxNYLaWWsWuNnO/10GW8aU9EECpbspvtjdw4BpA02U7B0S8x0uExrpyr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=UyrF0d/3IpsWt8axTazaummk53SQN1O3emzkRsrIObSd7HtxCuWhh4M0O/eG9rjaPFM/3Bxfpa6Ywt67/PYQbXy1fJffG1qs3cfLFA3IrV6JjzjQPhkqc/NqgeZrJJcZXmllWc8ckYbyvwwPo7VC6nOWzWptyeVeLxTreMYoUwmU48+rO5SaCuVPCtzQDYOguSkUMj4Pp94PvAXo7QZozJ7ES5518K12TAd/Z4wg/WktdiYILYIUJRZ/R3L9UEitgn5aRO+xor7w/Bpfp4k3QR6vSz9mvCVAbxsVnPnF+x4PJwjNN0B1lrbzww1EPj68JZ8O4i1TsFonkL9VAXdR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=REUuntBzTEi1jtu4Dvpa54hr3mMxX4dKP9EL3OhQrcOBEouppUSDnRvaY9yMO99ticMsO5wxCicWXtQ7dD5iYkLmfq8d8oxcaiRwQ+3x0QCX8LMAgHTMtr9q3R3RVqOD6b1umvbQf6boqcGSnGumQ1jpCkoU0Yq++Iodr+yc4xs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:24 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 01/16] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Thu,  4 Jul 2024 14:27:03 -0400
Message-ID: <20240704182718.2653918-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0497.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbfa750-f4e3-4b87-0df9-08dc9c56f37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EJwSLKOxaIY6R/LuZK1Z0VZTx96+UKVnLd495amwSG51+pSWXwEUg/fXo0BX?=
 =?us-ascii?Q?ZvbefQUaWacBNrQjfSrb50/29645GNGQJQk180uVGD60O9dHeOuztRUcDshl?=
 =?us-ascii?Q?jZ0ZsRYpy4y2bxrk6Scss0b3Btx2PqwA6/DUfpMnHpDkXcqjQhYTN/nXgKNA?=
 =?us-ascii?Q?Nta4pQ1jvVkkQeWIAwo90CNIaEt1EFEqOUg+Wm8LSjKRWLjY7hHOeKiDe5VQ?=
 =?us-ascii?Q?1okvbH46Pck7Dk/Mwasn7Ol0rlgpAb6wt8kO/gZjOk8jzk1aD+2Fd1tyCVhc?=
 =?us-ascii?Q?fUVYOSlXJfPfB6VasIYCmSOQH/aTAXuYEr2MVzg2iO+zNPHrPMXXEk1B8ZQN?=
 =?us-ascii?Q?/5cXYu79YU59+xOxJnlk2+RSwZ7VBLFZC8x7BLpuu8w6+8R09vJnhRqqXUv1?=
 =?us-ascii?Q?ITxE1W1nQ8jp/rcARtpfKVfqxnZS284tRby9MEaNR0Ii+eN1R5cO00H/XUr4?=
 =?us-ascii?Q?Ue8P5ZP0go2ZkmBKwAexa5wD9dXORm7HzYkrPb08xkuPuQDjp8lnMHdqy4Dj?=
 =?us-ascii?Q?RSQu3PM4ai2zmtHInZTAbvSfMslXnT5+xPnAyooqvunW2/FYbRPeVkgSeMZo?=
 =?us-ascii?Q?hl8G2jfCzgF7ePy8QvugB6T3Iz2SiwEE39CUEbJCpJvxaftZO/WwGwl/y4bI?=
 =?us-ascii?Q?ZeKW/ihslIOLGMtZw0XJIW5xKU8C6GfXnmpCTpiwj6FRnZFWCDzbYBnHFZPX?=
 =?us-ascii?Q?5OfKOReRl3Cc+FjbkVOKKDfOW7eqxHSQbsv43LrONIm+9yvv9qknPRBC0X1V?=
 =?us-ascii?Q?UM8e6pCQuZuW1rIFZUTkHlykrvjuoCS8Z9mxq+Sgg1qh0Zzp6KHo1WBiz1Rc?=
 =?us-ascii?Q?qONk+zwwDxZEIWojZu8Dyu8y88ma3okNq2mDFV9sFVp216Jvs87/l4JyjxnS?=
 =?us-ascii?Q?sAQ+7TBCknIQEpHxUnohaFHjfuAuJaBdyf4FnGhY09VcQYcT2wrL/pmNjppi?=
 =?us-ascii?Q?j0/1dYvdImiU36VpLhL7h9/z4qyzoObys9++s6K/0qOOpMaqYOzRj0h4AbgO?=
 =?us-ascii?Q?0mvkyGtMf/iuU4Jx6zlsjyJXt0RoBRtjFJAFYrGrdtvrcnGUrqil8YyZdCvs?=
 =?us-ascii?Q?xjk6J4hMMyiw5PAYQBV4y4hG9KSpJvvqA72dheEXGin2rVKZ0mPbj6wiuFWA?=
 =?us-ascii?Q?YuNDSd7jbQAMuAkaVKGB5AHKakqzHqrybpsr8zqINbLoV/9xPKrgqtFtc/23?=
 =?us-ascii?Q?IAgjhSkrXOSHwTiINUlIfOiNHg5c6ZwOltW3jMYrrY8vN/W63HUE4F39o4NO?=
 =?us-ascii?Q?GrWiF09P5F7OHFfikaYLvZiYrdE5mnRo6EJgjp0n3qz0uUul24Q/AvHW1Ix+?=
 =?us-ascii?Q?eq1kqWs2/6IeNGQd9KL8nMdzzjyLMscWV4cbl7+tjPTOmw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sIqh+5WEvwQSIxOLjy3sKNYMThr0CgrZQXFWFRii5S1rVx20oxafVuRMtq6j?=
 =?us-ascii?Q?U0x3yomcGIh2au0TxY88jWIKgL1XeXju/Nit0OKu8jprluu0Xc+tGz4vKQEH?=
 =?us-ascii?Q?sUTbATKhPDCO9QO5tcavmG1OqqM/K0NRdLetBJFptYkcCPru8La3VMoHOd++?=
 =?us-ascii?Q?IjOnB9gllWGBBiw7aOsETF09BmyOYQmFV9UGiGx1HWCpjc8T9EG1cktk6baw?=
 =?us-ascii?Q?cntS9QWr9VlsAwKcd3TxyDgWp+W+nTlPlADMh2CThJvQUz//bZaXihSNuupz?=
 =?us-ascii?Q?BbADk7HV9xtZLmHt7vqUYD5VB7hT+rvJJsDwkeswNc2QcORTaRtIQdkF7GA/?=
 =?us-ascii?Q?WsQwG3yDrRfquXVkRRhYNzaWX9exm/9ABrhl8DtXzyABOqHvVBIYErYfNHNk?=
 =?us-ascii?Q?tjDxl2HmQUgXASkvo/JBnlqVARIuDkO4z/uj1cyVhfPC/kuhdb5hgTzeACRp?=
 =?us-ascii?Q?xocy+/HRe7bbpwj6Ba6ax8mi1doaFYNtJHmnaFWCEQP7BP/8iLGnTxIyRZXq?=
 =?us-ascii?Q?fOQ6QecO5bRoi4q+kQ/NDoPxcUdAHPdLcM/vhRAQQchvLeTqy2lzMmOYz5cn?=
 =?us-ascii?Q?cXmmkN6zGwQRJqeJPsxi/TtI9POWW69lBUJG+A7VbbcSN2tQlS3khwPFyyUk?=
 =?us-ascii?Q?eAmfvEbVC/t1uzO+nTO9RGOkKVTPSBygdocsrSUZxQSEG4Ev7mjiV4D4HQ6L?=
 =?us-ascii?Q?SdbsLAtQB4MhiDRybx204ZzmkUdLRaAFsINe+7rX7g12GRD8wsa9/Hkut/EE?=
 =?us-ascii?Q?uRyV6Ipz5DzVY9LpH70BDN2j+Si0m7kKcAtBMO8iXDh5/CbGDDVpYwTdVwiI?=
 =?us-ascii?Q?fO3b7yLYJMY6k7PHY30dFVAxidIuSrz+bTQRnan3dI2nttO7/YvyqKEx19CK?=
 =?us-ascii?Q?fFJKTqnoPBnujvqhy9e+GkMHXQGbc/+nMvJEnX+V8qBFN98cym6WSCDlETLC?=
 =?us-ascii?Q?l0CmgOBqAwh/VcZ9wNJv59DeDpsjLjjWt2X8bZ+8QCZQFXslJZNyfJHomu5G?=
 =?us-ascii?Q?9jvxeKsltd6hlWV9FK9jXykQVsfq+GWv2dEMuhtZz22PzjZtz7KMy23Rfkve?=
 =?us-ascii?Q?fRJ/1s7DZnb+fNcvX4TZXarD9Cwl3OaGSxK5KzxncWrS/jUN3ohsb12HpNRH?=
 =?us-ascii?Q?7QrQmwq5cTPwNS14tYvYc/BObhd92q9nNXoYP4ADiN2ca4INiKL9bFJab9Q0?=
 =?us-ascii?Q?OW8DRcxuPvPRchKjx1FhHMCuSMYpvKy/Mm4mrsIlfD6djswCy72drTqAenSy?=
 =?us-ascii?Q?pfAR4mV/e/PbvV/CI43qzLUWVxarBjCWdO5GQNBaxET+Z1Y8E2QmymnhF5bw?=
 =?us-ascii?Q?Q2ndMOkQNAUD6B69ghRyCFhjkQp4FLnkQX+AkiHGIgjYdfU+AWvvdOS5y3RI?=
 =?us-ascii?Q?ma4d924oOgNpusAjs/DM225WFFJPgaI/RUdiKPsJV0cz6PWqliLk7B36ph7d?=
 =?us-ascii?Q?a6R9VdQV/s46qjbCEmOtn+kDIv8fArRm3e5VMguDEbrqJ8AEs6g+qFOswVQW?=
 =?us-ascii?Q?8f4utmcJ063Bxm1R0muq6Ybqx6GKW51BG+EgWY9XHoZjLtKlnoq8wTVZPNJI?=
 =?us-ascii?Q?nImnLbt0uEA3vStB/n2SvYpjZ1jxCJtrCyKchxX6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ImesFqDqQqtFEofjEhPEZeBU3K6r4ic4AbmF59e4p6urZDW6kQChlrdDaW3pkcBkht82yuSHA76DDeRjPxXgmLj+ZdsXv6PENzCA6l4DuHwK7Y2cMMcvz7L3lvH9UhjId52Rg993OThhrBNq0ciA5zX8XwtNkSf1D+HB9OZEn5Hetv5bCA1zPaJ8KharSZWFIHYJorhxUqB7cde7FM0kt8WXzkaTkZXzM9UJfAHoe4+kRtrmCjOQOFG+ZLKIjMSU0481El3v59WRY+O47yWWB+BXgsbsznX3SPHFZCkRmeWEHlkJmXcxBfoQVr6Llij4vYn6+Bx/ipnZWCVf4VhWTcC0WPOiPIQYUA9NB8GBiG7oqex/erySEHYUtYGgv3db/+g/ibZEEJ4xNfYUD0ytT4YdWqmOS5KugJkORQ0RDBu82yx0I6yUO+w/n7Hp5wPkrv7eQ+yQCrL67aPFQExZCe5XSjwgBKIlQuvPP/cqf5cHqgcQx9IozFbF/WY8KRJQo5ojjRtqRK6OcOuc71KUZiNAdKjxJdlS+V1kahCmbUyLpkWKVb5i21TZ8P8ZSE6Yn6H+x3r5XY0x3FazoOOATQfOb+Gg6uuUAzr/VdkD/nk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbfa750-f4e3-4b87-0df9-08dc9c56f37a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:24.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmNKVhDLa0lmV7ySDbJ4DJ1ymIjaenoaZQl71Ro2w4IoN38iQ/ypNZerqkiyR2UdCVN9POZN1HKk0e41VDKTlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: qmyscRGXXsu5sO-R7I3C7fvSWV9vzbAz
X-Proofpoint-ORIG-GUID: qmyscRGXXsu5sO-R7I3C7fvSWV9vzbAz

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..28a46d9ddde0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2414,7 +2414,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original vma.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -2483,6 +2483,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


