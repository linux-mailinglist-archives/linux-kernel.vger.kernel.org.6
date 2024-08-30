Return-Path: <linux-kernel+bounces-309200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7C96674A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D566C1F248D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A81B6544;
	Fri, 30 Aug 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzVz5H0J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DHiMr/2b"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366913BAE2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036547; cv=fail; b=aIbIUByrfPU9zWUh9FMZ0lqxw0TDWylDndRUpwLFW10Y5K6pjPs/bx3L1gIbP0dmfd61ihG9lJy/+WZMkxffGRQ6PCh5oOQeJpxoZzZZFuS0ihMwjjxBLMln82YUyXBXQ0FK7dAW71Xf+ZSQZSMDzzRxfzCPIDgQVX8RumAzDhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036547; c=relaxed/simple;
	bh=soumXmjWu3PES5pVZXQzyIcPvFA8GF1JDBPVgegCx5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OD69NMbIihxJztGnBcYfuikrYpV5ByZn+fXr9bASiJb2Di8bj9VJZ1S5HpttuUQpjQ8T1VeSlJIc4WBc7JpTUEMSqOvmVJmgPQTZGIJmcjOF9mmZU9K5ygbeQi7oUhoO/WV0vhnMldjLf7/Cn972JvIBnWWKUJvUl3W5RzFEKgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzVz5H0J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DHiMr/2b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE3DON002845;
	Fri, 30 Aug 2024 16:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4qe/roC0FcjwI2S
	MxiVuprauaPng7hpnckXM5bBwNfU=; b=hzVz5H0JGCNPEdQ72T8qJVZAINvdudy
	Onz2Iayj0ihqxEdKtO4vbZUASeagbfZtR7rohn3cG47WdYNUB66r22bMPjPK8hiQ
	KQyGabFDFZmqTUBnsYvmUI6J2ixlCKLellkuYkBHk0ugRNCvLNIt0BhBmXIDvlFd
	sYQ1Yp1NaQq0pEzUn62CA6BAkq+seFuzlf36/vrUiDHZii6FeR4zLG0ACToajh2X
	lo8t7rdga6nOHDPcKcpFcEaO1TtstjMWtNZE2vGRKSa1lPFgLzSHDNIeOUQwegas
	HRkmlG/5ACeRpnTvAVwfgoZjz/ww+aGeIukld31PJCvR2YMpBL70stA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj8c1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 16:48:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFkV4v034790;
	Fri, 30 Aug 2024 16:48:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxmky8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 16:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRjuo/8tgjTzV2/1j2iBJUcEHzzJuYnqjOvNkdKAXH/eoT2DmCM/BjeO65P3Iduewu2VtmfahCM8JVD7f+Gt5sPCLuj9W8Wan3c8CN95IVtlTU3dZthb1VdlV1jj3R00Ay/MGs+lKjMWqsrA1xRhHH4WvFuRedBWbXi66rcp8gF+LNgK7a1L1D2W5awGo0IN/sScctNJHq/4LBY49bTggaRJ0RiFbVvjl1bc6kH147dx80xU/721h7bIC3gBAbDkKpDlqLURKsv0lkoC5wmZmqIZSfuF3ESFOKaoeMK9kMcjIiJh7ixXjifDrqQESSgqFt0jhFEG1N8ePZaYo7aH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qe/roC0FcjwI2SMxiVuprauaPng7hpnckXM5bBwNfU=;
 b=POPRqdVcEzwNozlVsKvNFlt1fTNhdI8dGNLqWtDOxqQy26DHJQnDYMnhvcuVJnIgp/OkZi6W1lGdnduKGEUQhQhiLMdxEXLH9rKjRM89vYPRNx+dOClnzU8tqi9xNfoZKvDPMGRDXdF3b/kTuOdFjLq23qTMZLXAB13ntnnmtTMsahIvTkut83JxB241sR3xdLxRJYaCwHpkoUiRzMqskvkzclhkYZH6OqENh8UXI1Z12FGvrWerajStG8BY14ObYYknGekUvYmfhs7JTys8q2YPp2ZBfjiztqFhRv41GFH5E0BsEkq/EHtjBOn8ydlQUMTOxvwx5q/JHuRyJL8blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qe/roC0FcjwI2SMxiVuprauaPng7hpnckXM5bBwNfU=;
 b=DHiMr/2bF1JSBBTOMhOyfcL4CQiBnpEgzQz+aSImfQ88takUpjp5yMGuuoKR74UxbtCwnjKFoMD/CQKRLZvuguBGwsUg56V+KsknjetXASJFTdCO0e0aPOELQVq/ZW6mprDAtbDemNOXHNoq1C+RvQhf3761U2E6c/7zK9jPPb0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 16:48:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 16:48:43 +0000
Date: Fri, 30 Aug 2024 12:48:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Petr Spacek <pspacek@isc.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
Message-ID: <4usw5eqvmvr7mh35hwulyiwypgyp4symsvjxqsn5afwzsgowvk@pifzkcn46j2g>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Petr Spacek <pspacek@isc.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
 <fa76bdf0-81e4-4f7c-9dce-217ff8b464ee@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa76bdf0-81e4-4f7c-9dce-217ff8b464ee@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d02c5d-9d17-4687-fb35-08dcc9139be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uw/1Nrkgy/VratfSHjVO6NYm9aPPX0+/RS9TZgaNxmSFs61dto41uQW8syVa?=
 =?us-ascii?Q?9yCa1q8uwxrAT7HzSJa6O8bRm/2lIspMOzape8Rw9tdJ6wlF2VnQLIkmDXbw?=
 =?us-ascii?Q?Xn05YCmr+mSbp5CDvDDZVmhgI6EJ2YSu2py6agakU3nbQHcyQdSWSFWqfS6s?=
 =?us-ascii?Q?vTxcR14CssZ4BIAj+rtKAaEyqI2MG8YFOmCzr+qz4Hn9W8ER0J9H2TfnbhqG?=
 =?us-ascii?Q?X4644Pk07/GSMaENZDzkqJxki6hnaOj/Me9rOkFEvuOfbf6iTDbMFvQMIlRV?=
 =?us-ascii?Q?jSpCJFXqOk3XdcCSac9TKSSeCg3yAX6Kq1e+7gqw+VdjOryUwhUyMc41vPut?=
 =?us-ascii?Q?KlopsWXmFPuVg0nPzvcPaCV2rpf8CxTZAN2cdSlVq0Rao7Cb0uHaSF5CRjVU?=
 =?us-ascii?Q?MeyxYs+FJvj+akzX3TBqQjcysOZpB3gpuzCDmRc5jJcudmPCp4FwzSdFvEU7?=
 =?us-ascii?Q?xZvpK4CcETzgO/yB0Q/uzUR1l43SjAnfVTeUwIk8OXGqWU2jOZH3PTHubLie?=
 =?us-ascii?Q?lhAe6YuVzgQnohl+IxiGnQIOp4X6Vl0M28lqfjBqqfxGNuJ8S7dEAxg0WO5L?=
 =?us-ascii?Q?woQoATk6Jh8m0iO4R6zVakisKcN2hHfba2J54G7dSKS5HJJS1fHx3DASqI0g?=
 =?us-ascii?Q?ziFMgdR8GGHb2KTBkhnFoQfOgVNnN1QGz13ZJmT95q4HCBkBxaNrS1tVFvuk?=
 =?us-ascii?Q?vfCfiqKMiAD8OMahI4n7bOtbNmAqjYzZpbBl2JpAFFFl2eNp2PKDjj6EceK5?=
 =?us-ascii?Q?WTiG4U+wWVeFL1tQ/kJZ3KFjbgVJTdopPChe8owDp1Fz4MH8rOUnQd4+AY38?=
 =?us-ascii?Q?WgGJ7Y587Lpw3TtskE2xH75XDUlyR79gRL0YHoqMKHBAelVrE1SO65iWSDnA?=
 =?us-ascii?Q?txxEkpYFlZMSQt7+z7MCFYYoR/swnXDkIS/KBGqUWglG98QiNS1/UVPVRfPT?=
 =?us-ascii?Q?JvbPhBHGO4rI2po3OP8s7KhE5W+FCvy7LDrdLwBHlER8oPiI17Xf5BvQgSQH?=
 =?us-ascii?Q?rUE3HJ9WF27ATWEAkk2rza9is7PpOBKS99O0In+t1UKBVauavke+OT2c0POf?=
 =?us-ascii?Q?S2Vqe6SRhFoh7OoJgWx3BKJMPcKnO7TmldFbNIY1bTE8TgSrI1wlM1xLRUAQ?=
 =?us-ascii?Q?DPQVuIXrOdLFE5HbNfF2Nkjeref9z6wTKwW+FGSlN2TtOCan60S1QYFOboV3?=
 =?us-ascii?Q?pcmZPt+CWibVfLjDnLdDZGJyGzsFqZ3yOGfifAx4OmQWiW6QTrXNPmkNFBA2?=
 =?us-ascii?Q?F8CVNJuaapTI/QLh0jH/9Qf8r86b0c0R4KxnTlGlcni3k6IPglDTnI0DSTj0?=
 =?us-ascii?Q?p/lsHTxRBVSUMTGYkxwl4MZx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Fv31ztGKQ6sD5gWC19fwJspPQzyB2t4rvymssqVBbRnlIBN0bAqT99Myw/O?=
 =?us-ascii?Q?8hbHPixqCiDBAMOnreT1x2EyGwVA8lSCRsTTv/yhPVi0ZGvsXnKBY+j7py8E?=
 =?us-ascii?Q?VFpAF1G3aLAWn1OMtozY9tCDFwf9aBUgBsIVowY+jWDUQ9dkcD2t6lOA7QbY?=
 =?us-ascii?Q?W7w2USF3CuXCQtTGivFu0lUa5r9HId9mq6Lkmy7uLgVpysjvafX6CEZamv4V?=
 =?us-ascii?Q?77E/56S7D+p7+Tkr5mvZVUxKlNYzpBzFPqO04gXn765HPNHqjRO/pPQKGfaS?=
 =?us-ascii?Q?Cr/SuONB7xm9F6Qxcj7EMjOIsoOCliFiNnlFqwsPKabtFD/1Hz3B3c4afNSI?=
 =?us-ascii?Q?GzpBmeWk1vHiTc62BjMwM1+6r1W38LgDJPabsCqQWE0vFk1z/zOLxE0tvQhW?=
 =?us-ascii?Q?huDN9516cfP5A4XKDhuvFT7n+RHqe4zMI8C2vgpK4w21fAjimcPMECjqfoSv?=
 =?us-ascii?Q?Yu9tIMNVummWRHUgiqwisUdnWNLcoWyLZzXH1jWL67bNjjMmi4LjaBRmFemd?=
 =?us-ascii?Q?qNNhgruOK6JeK47dskj3BDacXboKImwFDhzkbE/VfG4TOd6gnxxQ4dwO7DV+?=
 =?us-ascii?Q?moluc0ToW3hXlCqrJKrMMN23eYpAtRxU5W2yTHu3fCHh9t34ZzIk8iLvT2O0?=
 =?us-ascii?Q?jkt+JVEoPxA/gBXq5tb8LZhyRVh0GfXxBA7VaJ/lx4vlr0XIbC0EpuqEz+en?=
 =?us-ascii?Q?SH4TPQuDdBmNMQAvbCqmWcZmiZw+lF13QTJqcVCuab94OosNAPcoLpxxFw1F?=
 =?us-ascii?Q?lhNXlET7bzEkOsrAUWkLNcTfzTiixvrXG3pciroLk6o5hFKaEIAglDvnKgfL?=
 =?us-ascii?Q?8v9hZzBFHBiAeqXHQR8OIuMDCT+MoS9LwSyhCjsnNi5T7Fl6BTGulfCw9lha?=
 =?us-ascii?Q?sd7CGxVNbqiHfkKsUn3Rj9Zmojbp0zsMw/2gywNpTgykkPetUDERz7Q6tTqM?=
 =?us-ascii?Q?TSLr1mm7cfkFrMyE4imkduyMe3kPPi7f6HJJwX8fabXUs0yAiTEn/rETNOLJ?=
 =?us-ascii?Q?W6XRcAtiLKfIc6LdDcbRjCBHNYhB2cGIiH2pEVX0npWTO292YSOOZfaTdM8x?=
 =?us-ascii?Q?ltx4buviY6QZKH4Dqb09kITQcLJ9/soKMD8+KtczBVZJfZ1kpL3doT2vGOQk?=
 =?us-ascii?Q?JRWk7SZCVuSjPmOvXdMYo/PCcuRn3wHSqAIHWBiejOTMDF2fdhGf1Xn2CEN+?=
 =?us-ascii?Q?28gxpXXRRTCzTLK7wuVacToremBEkl475UxROZIh5bQ2UBhdUt06QEa5dzLz?=
 =?us-ascii?Q?B9RRf9ATSJiwaYzVkO8/NpIPgaSldWjIfMHIDG+RgXSko+gp8zASMbOYWYU4?=
 =?us-ascii?Q?fk0+tHRxGFfucSaJV9SmWwx8AMEu/TdkhbaQa2Wh4QH/1SU4kvaOl4LuvVnj?=
 =?us-ascii?Q?8PELKjNODw6Pauu4ZIb/vtwq8K/PrYyN5RE5RSlQMT0ZyqW3T2q8FSzEUnGV?=
 =?us-ascii?Q?oHxAHTM9mT4UZMbINvjbrI1aWFXuSwJZCFSUVCU0pm9V9Fv+ydDjiY+5k6w6?=
 =?us-ascii?Q?EUGgohZTOTZcG7LKflf518j9hJqDUe+MwMA7tA7idTSqBghNO5vu18B70NI3?=
 =?us-ascii?Q?n2F4IIq/z7ScRek4JynGP6/NSNDAzcgJ97HJEUEODlDECjkmmJbKschkPSqC?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZPXoQUk2O9b0WwQ3fQ/u66j57NqhV+iAGcsbCprKcAeqIu3I9GRIpyMgLXzPsbLwFvelAqhuUhLv+/Zsjl3yh22h+a8nq/GIM/5V+FytSIEgfQXZR9HtkmjHKZ4xFHac9eIs8FGgZolxxeY4z95WWRkyxpkTQcX2leCzgMz+5nwC9a2YpAJmY96b+PhgvEPKyhOmPMjYkrqilQVU90myhw+JM5stR88UIyI0JySIKsyP1YKJobEMckSX5vBeRBWhFYgGmMxe5UF3IqcFFq/hX37cn5LX0AYBXs2M2WA+MuxKwSO7YEUNzaX+D9fv+9Je0EmT0ikKDRv9FMlWoheIJBLvWFlEJ6rfgbSThnFs1pSVd/FviYrHzYHJkh+xdPm6UfqwHQj0RYUxJeCfGTQXWwRtujxdi15XAPOUNO8SfQyj7I2jYEQOo6BJTQleNksffa3xNLsnAXw5dkMtjD7JWP7bN3giz92RkPSIGvbXcZXnWFyEKNx0r5EBSxzSBfyjZGqqfRjnu5zpH2TalVJzmQHAmXXutIN9cdIonEv6BHNyp6Z4UFSrt4jHW6ARUEgQJCpDnPqv+X7+yaVZUQiXUExR5vHtzFw9mg4iqiUMT3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d02c5d-9d17-4687-fb35-08dcc9139be5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:48:43.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBSBoJ2S13DvEnVpGR8gFDq1fg5kJu2vF72bzdPAi64RKPfupcgltglrR0v3z6ufqalfevuRp8Ea25znDJgDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300129
X-Proofpoint-ORIG-GUID: J_dYWm7uQoQWIqhtEXALO9LbMMWF4h-V
X-Proofpoint-GUID: J_dYWm7uQoQWIqhtEXALO9LbMMWF4h-V

* David Hildenbrand <david@redhat.com> [240830 11:24]:
> On 30.08.24 13:41, Lorenzo Stoakes wrote:
> > On Fri, Aug 30, 2024 at 11:56:36AM GMT, Petr Spacek wrote:
> > > From: Petr Spacek <pspacek@isc.org>
> > > 
> > > Raise default sysctl vm.max_map_count to INT_MAX, which effectively
> > > disables the limit for all sane purposes. The sysctl is kept around in
> > > case there is some use-case for this limit.
> > > 
> > > The old default value of vm.max_map_count=65530 provided compatibility
> > > with ELF format predating year 2000 and with binutils predating 2010. At
> > > the same time the old default caused issues with applications deployed
> > > in 2024.
> > > 
> > > State since 2012: Linux 3.2.0 correctly generates coredump from a
> > > process with 100 000 mmapped files. GDB 7.4.1, binutils 2.22 work with
> > > this coredump fine and can actually read data from the mmaped addresses.
> > > 
> > > Signed-off-by: Petr Spacek <pspacek@isc.org>
> > 
> > NACK.
> 
> Ageed, I could have sworn I NACKed a similar patch just months ago.

You did [1], the mm list doesn't seem to have all those emails.

The initial patch isn't there but I believe the planned change was to
increase the limit to 1048576.

> 
> If you use that many memory mappings, you re doing something very, very
> wrong.

It also caught jemalloc ever-increasing the vma count in 2017 [2], 2018
[3], and something odd in 2023 [4].

It seems like there is a lot of configuring to get this to behave as one
would expect, and so you either need to tune your system or the
application, or both here?

Although there are useful reasons to increase the vma limit, most people
are fine with the limit now and it catches bad actors.  Those not fine
with the limit have a way to increase it - and pretty much all of those
people are using their own allocators, it seems.


[1]. https://lore.kernel.org/all/1a91e772-4150-4d28-9c67-cb6d0478af79@redhat.com/
[2]. https://github.com/jemalloc/jemalloc/issues/1011
[3]. https://github.com/jemalloc/jemalloc/issues/1328
[4]. https://github.com/jemalloc/jemalloc/issues/2426

