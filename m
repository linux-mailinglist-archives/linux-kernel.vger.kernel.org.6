Return-Path: <linux-kernel+bounces-350496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D16990606
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C3FB23CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E19217330;
	Fri,  4 Oct 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mh8TuXH4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yPrJT631"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A97216A3F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052001; cv=fail; b=EUvqznuVBaubmYUFpzj3msMVsTRbWxXaCaPUJrt1X4JQ3vM83/RqLbkajFF+DScudmaNeS2AFKkXj3edAzyL8nIzbTvqM6Dps6FM9HBIRcBk/3Z0atV/Lx4jIk0SD3hVrhWD6zVFbYZTeb32xRJRxz8PMAIgwfBnsMCA1fhxZhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052001; c=relaxed/simple;
	bh=+UnJthpnyd9YpN1nGmENHUzXF92Qzyd6d6BHDWRGVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwFYvIykS/SoDaNQtPPbmLFv5VtSr8pitgsKKM19ip93GMh6pxN7Qb8B2WUBhUva8amLt7zz2sEa9cse9x4Ha3lzCUkJ3TflZ8ZF5GTZ2AFInfdJqdS3FiTwb5yNTxWhG1d/xsRtHz8hwTgx0IRjr+vb3CuHaOso3yX7AusdaXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mh8TuXH4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yPrJT631; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Dxwru004392;
	Fri, 4 Oct 2024 14:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=wziJJtC2IGUUfCe
	/ZxxSaO33oygYnW52ftedQk1e0JQ=; b=Mh8TuXH4bMiCIh2OTjwFiWxLmABmvwC
	G37ZAox9Xo099LNtS8op3Jur21qEVJbL08aXFv6AGMFKePXZaQa2ovbTLYiVQwFO
	737xc/jPMAKUqcRL4OblAOjlFNGtOzE07oyiQg+TGrxLukqY2DxQfAwsytkhk6BP
	6I/ijfCYvp7VuSUZFV1DMDDHVJYjEZ4A8opEO2VLVEO9CfyU4PZ9LGpxeIfEBHTb
	KGaG+FVNChLHCGK+pLQIayNQ9vnLxp94bzGZclLhCb1U9r/ydOm8CQ2M6b0uKwtF
	yqI5aUwOLiz37MjwDW5E1s1JlvJvlC/8suGY5oboOCT0piN9sZVZqEA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204espyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:26:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494DP746014406;
	Fri, 4 Oct 2024 14:26:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422057mdns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvl1nmdtZV4d2Lg3Zb2NJyjs2+vDgO8FpIOhYeV7NM7lXKxdiBf/wW3oyCg8k6Ab9KaBQrBTcl5fAzlddwgxKbqqq4jhiFcZ4Bav1i9HdAyGrglIHNc+nQx5HhKlIgsirgyH5syc0d1QMZsRF081nNnvHhR+LQP3RNSug95YO5i4PEiZGkACHzid4rdaBMUQCO+j6SGtery5UZLJSdK7CQYwdrrGHxJ/AoQiwEqok0tmPoD6peSgX4j0vYe56prp/fcEZsRGcHFXM1MaCWJtOuRdJ2SdQ5P18zl+rVn7eF4VrA5aySoEOpvX14dVyFqgr004/KUUqQf0iFNXzK2Hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wziJJtC2IGUUfCe/ZxxSaO33oygYnW52ftedQk1e0JQ=;
 b=gUkn2pzno8i0+d0Ds4SXHCbhSKaGn8zVDUuTpGEc72utgJsK9wtQBST+epGWrPvnBZ5NngRta+x3BS/YAWCdMJ6DH2ujsFfCmESOXCSNVtCg9DiL1IeKT5X9vA3i2CykTPJQE3ndM0nzPblzTWFP4pr+YMMEyIEn1ES6V4JjPKukXCVOukQnFVByniStOPhzIQxpPCFmwb9PjzurEXH5pGVzqVeYYRkovZ/WCRxqsIUpxSBn14DzQGmGJnjc39P/HOTV4sTr9l2M6SDYbSFitfrWir6xC9MeBVrZxb0FNxFvITfV+OnYjQiVe6X15UMdOjne+9NsN6gKR3BKc8zFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wziJJtC2IGUUfCe/ZxxSaO33oygYnW52ftedQk1e0JQ=;
 b=yPrJT6318PaF6GApwd9iCUce6cgYCNYSF3PXxC5JqntqG6esqVPovydGoAnY5TYwmAbmCnPZ+ALHqCgM41Qbt2dJZMFOwtecOOuspbIrt99KoPQkNGpyFvRT+z+eQfzBRQtzaoVmZyLISDugkrqytFOoZ7fS54u9IUS4/0ad/5w=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:26:29 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 14:26:29 +0000
Date: Fri, 4 Oct 2024 15:26:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <a34fe509-f1d0-482e-9aa9-8dc3fa0743f3@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
 <d07c85a3-d1b6-48e7-9e98-bb533bb73417@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07c85a3-d1b6-48e7-9e98-bb533bb73417@lucifer.local>
X-ClientProxiedBy: LO4P123CA0355.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::18) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|PH0PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d350a1-8ceb-47af-995e-08dce48089b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBEbCZ3CE/v51YF/I/280+lLcm3Qoh4SHHc9boRVsng5f5QiPm6D1YDU9D49?=
 =?us-ascii?Q?ItEfw+/8IgL7GuO6xCdjvurbOyzcE8eFWwdckOs2LUmgv461JnTV9roxY5Uq?=
 =?us-ascii?Q?Ev52qveznQJamgqkcduJX2IVoIq5d3YNCCMCksoGXchghD94KKB9i7OJNU0B?=
 =?us-ascii?Q?o/fz1fVwc+IXUGbjHzHzCmY0b60tTMV5cBfIrJ0IFLIdNOghPSuej8yolKN1?=
 =?us-ascii?Q?l/KOQE8HIuTClghi8LHPGvOP58C6hCWd+pWgPb5vENgpYkSJSqACEHVDLgTp?=
 =?us-ascii?Q?9+HwaMjNmKnXll16gG7Olc7WcYxrrvAS6xXYHSDZOxSI8eRCvRP+mDt8CP6x?=
 =?us-ascii?Q?C9SWuw1FGWI27rY7i2+uj8cUC54353hMCpUv0RF3IywRjMe23IB2+Jtzprj3?=
 =?us-ascii?Q?JnXXtTrKDXBQhjOhLmgY5v3bhKLpu0/a46+iU16GP5ABG84gLMWNfaFQLHlj?=
 =?us-ascii?Q?8bfvsL1EowF3uO3vHueK2WNPyDPJlGWxIT93avCGTURexPzFnz015Ro8NwJb?=
 =?us-ascii?Q?7roaW8zdEc3rwwkp52duOPPU5LWfMc1co5tLz9/BX7Q3/j08Ok+0OW0Gv8l+?=
 =?us-ascii?Q?EjzJSoZOzeYJG9CpqyIXCiuVa9Sja5E6sTy8IYmYn/C/PPFxFLVWYp0RdNB3?=
 =?us-ascii?Q?tvnvu5LHUziiOYb6ew/qrLZtt98R0gRefwsiY889V97YGsxxNAxlqg6Jak6Q?=
 =?us-ascii?Q?l/+oFlwgqAt+PPTiu8Ko09JHfcpanucj6tRWn8eyAA/dX+Mof6RUl2g6mAh7?=
 =?us-ascii?Q?ubvizHwTbqrMlbolXBSKN4nwc0+/ISBoNAwshjGPDbsyK7GzNWH+aZwjnxl0?=
 =?us-ascii?Q?S71pMfzdosE2R+ycuGhXcY4bEmpJfVlXaaMDzard6fEcj41yJWU90nwBkTy/?=
 =?us-ascii?Q?ANJXEyMyceyLUS0kG6P0Len5K18M60LBf82qDju5qfKT2wdY36pPjeJkk+g1?=
 =?us-ascii?Q?XbXIITGKWiqvFLMCfRr5lRrhz62SzdD+0btwUaXbwqsIZ2GA63Jl+48Umney?=
 =?us-ascii?Q?q3M/vrS9dfvsJJPr7uxIf5aOvKy6RW/hGeDuUyd4e4pIa0hV/pOQir3cB8yM?=
 =?us-ascii?Q?TCmbE5iNESG2rJtbUJspR/WrO+ptJsN17iCw6yFoEKY8CY1zCR8ji35zPFWP?=
 =?us-ascii?Q?M7WVmooF5bxChlyqPyKXJMEYw9O7rUzfh0TJ0bcIADCXQ/aAWWcyl983Fbol?=
 =?us-ascii?Q?soIw4jcl1YrYXgb4Mn3zMWsESv5vCFsmzL8+SWst4vTPTj1Mrg/OnsbfzddT?=
 =?us-ascii?Q?6fyaUUEUgpgrwTh5CQu6OF3LDdaCQ5WblajmNDqb2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4bbLLsXmnfa/NXKhCXI3jU59NmpMuQyf1o6fttR8dO1uzbStSOUxFl0gJTl?=
 =?us-ascii?Q?lGFIKq+UkNlg5myHxtcU5ZzACEk40vZ3h8LaJbEyW215ZbT9mzrZFaW7P6j5?=
 =?us-ascii?Q?DtzH0QdmzAIWMdB6KmhnlhfmBcBIXjeWtYPhlHgRLakqYuScvvJYPYbj+LT3?=
 =?us-ascii?Q?O1MMC2dB+QWrimP69txSVuEvhUoMmR6omJBJKAkDBigP9WXmsiVpIEFed0WY?=
 =?us-ascii?Q?h1RO1UhHe3hErlbbtnaZcwjBxRX4ZbDR0dFCxe6c2FEaelnONwA52osfBh3Z?=
 =?us-ascii?Q?djv9FGcZfeHLrcU8KZtGH+B+OebFmiir872/JB/KDsVUORtU78ctjkVS0Vqo?=
 =?us-ascii?Q?C7/V6S9LkAxqBQd0kbcCQvy0ndPL/xigQLg7R/uxLIQcNmEDTC9qjIiias7p?=
 =?us-ascii?Q?2szMjqPcd7nY71QVBso7UjcytzfY/YW1vf2sdTrLNwHg4jyJocZsVpJOOn8h?=
 =?us-ascii?Q?GeUUL+GuKy9fPtVrNCpTwNL0IjihniiQjnv6Uqv4/BTr8tOkMNb3PX8J+FX7?=
 =?us-ascii?Q?6f6zi+Cpt1F7UTqR77VRZWehuGAUBoH5CA7EX/cg+rb2SMhOHkKW2u+RXWiR?=
 =?us-ascii?Q?Xy9Uf+a/4KFlUoFkCyBI+Xa2HebCjbiJIcVOa559B1HLA0ZLnkZ+4D/5D43p?=
 =?us-ascii?Q?DQA7QX7ARcVdembz2RPbPn+kvmYz7P3vopKOY+t4m+tMPIJVSIFtdsaiVS1U?=
 =?us-ascii?Q?uEdPf+SLMP7K9cI8eY+YsBXQyriHBic1UkDEKel5e5onn8APqidAodEpR1nD?=
 =?us-ascii?Q?sFcm/5bAa71uTRyMmQCXc8VcRiL/IvamS76zgBwOLisQ49BXuCp4PFMIDhjr?=
 =?us-ascii?Q?x4VXtgDdMP3cDeLm1I92Miiq7iaGfqp4zFsZn1GxG+zBJ98EQP1Q+WKRL84i?=
 =?us-ascii?Q?nmgPLWb4CIbC+0LqYU5qYLYuE/vkoCP3g+4OSFuE7uXnm1qDjwwEDHA1nbMM?=
 =?us-ascii?Q?wRwxsT3TenI9lAjNQqAZ90F02MJyucgj7vjbTQTvBLTI5e9kaYFsjpyWsdNi?=
 =?us-ascii?Q?1K/7JMENUni0LX+RZDOPtRmZiynCOgNUigW9rzaqBjTyVbOJgUIK9bHZLAEo?=
 =?us-ascii?Q?bYeIneMHBdO3SWfQxd9OiH9cLSTZ7wRLI/OOp6iKMBRaW19TCILX6wz+WWw2?=
 =?us-ascii?Q?5VEh3hrvdmkpcEMw5QaLOzg/+RYMuI7LVcJ/G4/JE37gl+j2XZMH86lVZhSF?=
 =?us-ascii?Q?x56XXhpnL4g7LuYkjY95zOamk7HqjCzfk9YUnouRnaHxRzAlc8OjIgTcddDi?=
 =?us-ascii?Q?4s4kM925MMQjhtFOCLH+HCQ3YBASREj4w4CI0H666JvU+QvKV73/XfDgsPmN?=
 =?us-ascii?Q?eHFOwIo/KrVHUbtW2suR6lUuv3YAvkZBW7gwoYvzM8sEECnfLzycXO028UFI?=
 =?us-ascii?Q?HimWPfv8U68JuBeR4Gsn7sFJrOxjOGfepUMINOT7kTj+8sgLQVGf/lup29KU?=
 =?us-ascii?Q?RmdIeiFm9GPSCEAhxPaAFDzTPuJpiITzwy29PYBM1EfUfaiO/Kgb2kpo2p2I?=
 =?us-ascii?Q?dfc4spZiCvk+eOdDnQdErucNWzMKrgcQ2RAKeqEZ65wDXGqCZ9v5hEfne6Pq?=
 =?us-ascii?Q?25y7QWo3EoT93yv2OhgZ8CBzuwQ2j9NedEzNUEaYiwUHwHLZuDn2U/CgSexB?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y6kCG45Se76DIimYTlAnRzspv7M2BjnN1ECl+74IM66BHyX/hut9di4q+Nu0FJkz0ORFeh6f+K5JkQCSq5tsfK83Jyq3rqxoAAmdgX3S+5q7NLB9sjvnkkCIr/OLLfVVYxFeo2KBrkrFa3XhMgf//DFZW7bnt+Bj96Uv3MGXZUVK0NQl5oyLceurqrxic40jySFuVHlE1OKoiBkc6w/Y1EyWDSX2DP41kjuvJZ03ylQx9O6sTLTgv8waDSYnNU2htTmADBI8yd6X7tk2NnLHKNrxzT26Eafmjx7DaSGmwKmbaKqb+HzOK5x5y8TYWIEW3v+/Gc60SuJH0z0J9ZY3CiZci3x8wz0yeHTT/05oS2vDPbFDGdHoLN6TSt6dmryju3PXkcQ8PW8f4L4Z7zDJY74LwOIbBMz3PH8KuHpypd36ioz5a55npU/oJbIxvjbz2iMi/vYpG+V7Kk4FZya3WnOsnAcmvNwhJlus3BcIjUoM8RDZrQqomgXE+7CkJPTEw05In+qgi7RNAt3OQakXz5hssw+wtyBtb1mmrv4t65Y2F5fq7OyDENWt3JaTI3wuUTypew0Ud3yYPoPCvZGrGisBrUQDe82P6TIDOP94Nbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d350a1-8ceb-47af-995e-08dce48089b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:26:29.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiUhvAljIBRowcAsxL0elHR0YFHJcmYbYSNw3WnaucgugI/cK9fbLBFnzsh9KKdmKNBaiYE35QkMwYtfK6W5iMfbRu3lmKsaMCOG5h/MAqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040100
X-Proofpoint-GUID: kLEjTkUiQOMdlxffN2MyRVxW7_aXZwZv
X-Proofpoint-ORIG-GUID: kLEjTkUiQOMdlxffN2MyRVxW7_aXZwZv

On Fri, Oct 04, 2024 at 03:23:37PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> > Here's the log procduced by this kernel:
> >
> > c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> > 7e3bb072761a mm: correct error handling in mmap_region()
> > 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
> >
> > Again it took two attempts to trigger the bug.
> >
> > Bert Karwatzki
> >
>
> Hi Bert, please try the below fix.

OK sorry please abort that, my git tree was screwed up this won't work (ugh).

Let me redo this...

>
> It fails a couple tests in the test suite so this might not be stable but
> it fixes my repro, be good to confirm it fixes the issue for you.
>
> Thanks!
>
> ----8<----
> From 07485683fcd3d8d22996d82bdbde0e3647f2349e Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 4 Oct 2024 15:18:58 +0100
> Subject: [PATCH] fix
>
> ---
>  lib/maple_tree.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 37abf0fe380b..fc221a9f23f2 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3527,6 +3527,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  	return true;
>  }
>
> +// Return whether the node actually contains entries at or greater than wr_mas->mas->index.
>  static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> @@ -3696,6 +3697,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	struct maple_big_node b_node;
>  	struct ma_state *mas;
>  	unsigned char height;
> +	bool r_populated;
>
>  	/* Left and Right side of spanning store */
>  	MA_STATE(l_mas, NULL, 0, 0);
> @@ -3737,7 +3739,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  		r_mas.last++;
>
>  	r_mas.index = r_mas.last;
> -	mas_wr_walk_index(&r_wr_mas);
> +	r_populated = mas_wr_walk_index(&r_wr_mas);
>  	r_mas.last = r_mas.index = mas->last;
>
>  	/* Set up left side. */
> @@ -3759,9 +3761,12 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>
>  	memset(&b_node, 0, sizeof(struct maple_big_node));
>  	/* Copy l_mas and store the value in b_node. */
> +
>  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
> +
>  	/* Copy r_mas into b_node. */
> -	if (r_mas.offset <= r_mas.end)
> +
> +	if (r_populated && r_mas.offset <= r_mas.end)
>  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>  			   &b_node, b_node.b_end + 1);
>  	else
> --
> 2.46.2

