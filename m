Return-Path: <linux-kernel+bounces-308835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DD96627B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262661C23801
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B855199952;
	Fri, 30 Aug 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EWfzwRH/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcPwmiE7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA711AD5ED
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022984; cv=fail; b=E6GrQui78C0e/4fevuVPDYtv5PST8FwOl6zK+Mt6NMKREx96/tbme2q30e5Uf99u+GWAj6GCFbh8yNO1o1fr3eEnsxwgoZVgnQjouKZciO4UD0EBhMOOIcTw/nDxpFLuW7PkDZLx8dvJqr0gKeJmm3ZAf/ygUzW4NZnolfmSvQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022984; c=relaxed/simple;
	bh=8jinGaFYpWl8TGfHkkA5Ng0jISrS3nOAGmkULSaKvzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UNLIZcG6ZutKg1vWyroxaSRjLhxAiwa4rcic6QOW0TqSQCl6qC7NVFipszeybzxp8UdEn1tMR3SBNK/V5jNvd3jFmqkBr0+q9hKJ100M2umBPt4WwMaIazrO4EXs1GllGIZL9uc044qDEtgM1BQKddLXYLEeKFAC3PosFzETzdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EWfzwRH/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcPwmiE7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCjIbu008744;
	Fri, 30 Aug 2024 13:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8jinGaFYpWl8TGf
	HkkA5Ng0jISrS3nOAGmkULSaKvzU=; b=EWfzwRH/y2yUDr5f5z1EdN8LgZgjzBL
	KtkwvcuVbCHJKK70OThW1T2ViT8t1J6ClxK+8cgyYJnyubev9Y+e37JRxuncstW8
	DOQW9kuMQGITpyk01PZYraksz9ApodJGXWtnNI2F1MBiiW/pDPMlx2HFEsCFVe1y
	pBhvC/R4H8ZY30otdiOTiWLOmMZAqO9cBKx0bDsCgiZrAfDLMWl/9kjESZP2gS5W
	zRBoXdLO5tmh0pX+UDFG/xunty82i9RkAb2gzhh7d3vsVE8nZVD4hDSEUgyR4010
	BO9Z22vORH+Xn2Nl3jzPShCLUPimyWx821HjlpauUFLXEuS8Y+tszig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b9v7gh72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:02:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCI1I3032456;
	Fri, 30 Aug 2024 13:02:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0y1ump-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3lNGA9KfoCaeT3DOQ/cVRjUdW32dpxyD19oFfrfLjGLw31Y5OUPztNVDWqjlW/kbasqtIOzyUpB2Qzt6fZlTfekCuseQH+MrAm9GbH2XsCrcLVfPqU4ujMX9nHQQl+5X0u7E9+btMty3NxR+bopfWbVwmeQEJJvZESO6vLj0pAq+Cd4UOCX+HYGLpRagkvoNpVhVLgZTSXSB4qmS6LQ5GYH87h2f+X12hCTyw7ktWFRQ8Y47rLbTXTrDA+TilQjITrcQ7shPINuKsy1FEkLCWEAyRHxiA603YAXDwEkBzcDqZxpLwy02XTOhpa17AeErH4vrL9fnw0Oo5v2UFlpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jinGaFYpWl8TGfHkkA5Ng0jISrS3nOAGmkULSaKvzU=;
 b=ygzcdSvpK6eVO/deYHawvUPlSF199NHm8Hw4VWmrCsft4/ZjsOoRI1RwLPzsggRu8PncH34e1iORJ/lLW/GmrkEZF5XBQDljVOc27vu6HC5JKoKTysWiAgWv2diVcSh430w6D4+7mSBIdUG+YsM1ajChz6f06WYuCgBSOcB9GEHKbkUEhWOMSbyuzHrAvPDZLrUCY0Y4vAZb8ZjCyKHezJelNCiboRMRNpmGj74jzGGF0Krot6cmSMvRd5xOieGpfaNJnbvnu1uSkn5DRzIGCjTU/Vi43oDnFEkYG3R7Wm9sh2wxTQrYSlRXMJFDMpJKIsVajkoLk7zhdDIV6RBDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jinGaFYpWl8TGfHkkA5Ng0jISrS3nOAGmkULSaKvzU=;
 b=zcPwmiE7HefPMxiFfdLwty11fU6BY9Nef1SUSyxCPhweR7KnY7DGe2zTaOACNDYrvxEnzLctyL+Git4cF+d0rVa5iKWXVuK+cj8260FzKA9fPRVS38a3/qcGzlVfqeowQ2KKn7tr0Mg+/kQfgpRgVwS6GJZb1wClrS+gRsjv28A=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:02:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:02:37 +0000
Date: Fri, 30 Aug 2024 14:02:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>,
        Aishwarya TCV <aishwarya.tcv@arm.com>, dev.jain@arm.com
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <82718839-dacb-4774-a72d-99d9c2b134c8@lucifer.local>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
 <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
 <9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local>
 <622b3769-fb5c-4a3e-82b7-1301623faf43@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622b3769-fb5c-4a3e-82b7-1301623faf43@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0069.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac583e1-6858-4872-b9b4-08dcc8f405a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQjyIN0kLUxdyYt0PpS/fLFrltsV0Gnf0Gpkcol8bg+9n0axhD+6sINmjz3I?=
 =?us-ascii?Q?MjFvegvYUgyOz93pfyHL7kdTFve9AcNWIydx+WW1EBcqF5x2DHX2LaxQ99Xw?=
 =?us-ascii?Q?QQbkHcshtNpk8P15P231n9ytXy+ppc2QkCv4vb9RrP+piu8AYtdl4jWgRhjf?=
 =?us-ascii?Q?5l1tZKMtJ6alfEGJwpbzhz3eQLRdLZ0VNEEcHm8Fh8fIlXDY8aIxHDhoqw2r?=
 =?us-ascii?Q?qDeysnIWM4jWSerpx4BRRtF1xazHssBI/zyjkI/Gy89WL/GRzyBOJG6cGyVI?=
 =?us-ascii?Q?39VN6ySasnn7w107mD2Z+d2Y6Idsv+nf3aXiUcawmsdNd7HD1M+EAakbQISE?=
 =?us-ascii?Q?cO20/DshRbYqFgnJLnlPRm5Fqrz/OFzUu0/EkElZmunfInhI24nvGXO0lFTf?=
 =?us-ascii?Q?oN+dNTiwOrtHd/Ix2qoPQ0IFh4dnbHrgkWwm/Pm+PbTalf5OggZmPjnibHxO?=
 =?us-ascii?Q?J8jH5s0MM0luVTAXzhXmfw66ypSzNm4PBtmLU58frdr2vmHrn7BwAvq46ZKV?=
 =?us-ascii?Q?ZdoHXEOYebAo/TBivv1W4wcuCl/Wbfvfn/4zOgu8X/H9zS1TYUoRsUCJXVR8?=
 =?us-ascii?Q?h+luwnZ3K7B3vpsZYvrxis1ZzrmHi2uwpZxsLjDENM7gZBXvLPIQbPLFjFFn?=
 =?us-ascii?Q?i+o+z6P7khMDE6xXHzrrRr0jyYMmS3V6MlAGT0KJyKer5pddOrm5tHkHPv1c?=
 =?us-ascii?Q?kLFIojWM7Yrkm1XZ/L0LigucMj9xTRe0igE90coUfv+et6ZvuA6mDYZ580Fd?=
 =?us-ascii?Q?ACl4OMELZe0oj13u2YvUTFmMUxgO9/MnwP/2YsDLPWdchIOpLNdsCb0NoFdg?=
 =?us-ascii?Q?pgQsNEpe8yAV9qUnktI0CGuocBAdV07s0QgNbjFDTjkTciWmO9MBlE/dKvg5?=
 =?us-ascii?Q?AVQIguazGkbxXMuU5x6Gqriqy1CeWufuGRdCSgN3a7bMxrZB8VoaFRpqjmru?=
 =?us-ascii?Q?Qa9BETZfQ9tHVIpPqGsWDU+EVEZjWhfplbz3kYdv6htPN5C4ljpOYQGjOpiz?=
 =?us-ascii?Q?eAqOzAba27de40Oi2VcW7+Zqum1lJ7zX1STnmrkkcfIMxXhzV9QXXujHZhOP?=
 =?us-ascii?Q?dlIcSdiulmSRYFq38ilCaa0nWLAWZ9e8ER2c28NTc0IUdPTU8A6JoX2hvzgM?=
 =?us-ascii?Q?+cg5PrBAM1lC2dNPwPg4DHshiaE8wYuS2RfgUfOiu/RAagwg+ZOIx5tjC9PE?=
 =?us-ascii?Q?pmf7Sew62L75gIZOiQ9LCgoUt/E+uYK68dEKd5l5Fg9NsVhOtKG6uP+eig58?=
 =?us-ascii?Q?aCeyv3LY7X/hZgDgRNt4GH1rZQuL1Xuje4+1eEWc9L7tELhmQEr4YlOKN9G5?=
 =?us-ascii?Q?CfPPW1CdrgewH7dhvIYlhagnUjyfjM5nR9yz0B04xWBang=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zK/XM+1AfozGaS3/syeOJXARoj8Glcj+XI9dXTyem9NDoZ8UkeI5WgE4w6bh?=
 =?us-ascii?Q?S5ffYtkzd157stcR74q30Z//rPPRDYk88NfQjpfcWVzfStp1xQ3Prrgj7+3e?=
 =?us-ascii?Q?WrOZKYNM6qBrHJ9OIRV1/bxK4EJogPSMU2JzmSrx8QhGn4xzNrrFOT1QvW5W?=
 =?us-ascii?Q?Of2vGSrqeHGLbgQwGRRRBtRGT3o+6mOj7X8IoniPsnMEdes+IXeaqiJlyTFa?=
 =?us-ascii?Q?9I5NC1L63OVZFyvZqd736UwI13/0A7o2R/+eFbKGz3Tlba5LCfAb4YJu5khp?=
 =?us-ascii?Q?eyprGFSxzVtOH+4ag48akz1ARBkVcPWLOdXdBaI0GfsolkcSrO5LfQ/Fdfp+?=
 =?us-ascii?Q?fU5/swj8Iu7N7pcZ1RV3bnM8ohWYcHSo3EQCkpGGSgi0mHu6yr4hQ3rGPG5y?=
 =?us-ascii?Q?QPjIC/4DbcuyQCu09WCMmnkdudlGqS8mNbkBeipHJN852+7rjMRMVw56/ZAe?=
 =?us-ascii?Q?MMCBRbuUT5YPBQyP66V/8FIqAZ7WqbqFcriIXLn+58v8IDnm7zSLnVbuveTJ?=
 =?us-ascii?Q?uxkFFCBucq0IJbCV1Ulh82k/6VDV4YQjy7jXjg2usApNNhD+e6+69B8zrhJl?=
 =?us-ascii?Q?mZ9NRjiP6ihCB8vGDxV2Sb9WFIkw1A0sKzKQSrIXPZ4r0A2uHr0WagKDHOHc?=
 =?us-ascii?Q?Q1eaEmzqvqwzUuraWRe2mYVGdd5PTZDHWqynjXtJSGTn7Oh6F9Pc5JdJMNSC?=
 =?us-ascii?Q?GYqQFxIGYIKbI6K+aT8FwPJ4AVyXYbUajnabyLbYELxrZxEr6TIC7P8Q+197?=
 =?us-ascii?Q?VyiydMPWQvwUUTIj7TykiO3LzNL80FKnadizVCz99COqVuAQyU0OPibfYO1K?=
 =?us-ascii?Q?WM+WYmhsDOsOlPGM6gJppxEy1HY7JLTg1wjPthhNY+gkUNec/Exgz8UJ/qob?=
 =?us-ascii?Q?DaAbYUnVBAvrWjTxfxjBdkxeANHaN4wIVYPi//pYM5d0XKWSdAwho9gBofDb?=
 =?us-ascii?Q?Vl4I/uITXSz+xkD2H7XY6sK2uxOnVyiH7fBSe+uvCZalu2D4yTa3sfkIZGQ5?=
 =?us-ascii?Q?+lXswUSo9KUNvtHr9w4SEia5VAsSQCU6vygYSEV8Ziz7hkty7Oaf22cBaw0b?=
 =?us-ascii?Q?PwG40i4Ik18r1LRCFIgmhzVcUQrlg/tbnir2XUOzTslHFRxm/RtIzSGSUy6g?=
 =?us-ascii?Q?rAo5siec0UINbe7llkUCcl5Z4bi00V0fKrGilPEo9SYHkDGbwDnf2dU9dlUR?=
 =?us-ascii?Q?kKROeuTH7eCX2rnP5PIBltwOrjNdRSYBa/J6MIoPfi+Fc1+/vRfUVuv9I8tQ?=
 =?us-ascii?Q?OjEhldOZndIE0LBcDIlXh89D69e0sOPFwemI/UqRqYjF4HRjBJITeRk99Zmk?=
 =?us-ascii?Q?Pa9HKmCEKDGVty61XXG3dCye4KG713ogDBAPrdpqGky4WVXZ+xWf6vIj36tY?=
 =?us-ascii?Q?mUrgzdQRx5SlnYqoE9dC/F7/W77YQ17n+hlLuxZZ3ag8QT074u2T/qPZ+HoZ?=
 =?us-ascii?Q?ueuBLDoU7GUFLA5cxyJHeozlk4w1GUYhFhj30DWuzvRMkQJKfgPhy9zuzGWr?=
 =?us-ascii?Q?D6CV5T92/pzZKCPBdLGvq+4OKqXgzMp8cE8rc3qbCSNAWHDyIIFBDbpjxQ3n?=
 =?us-ascii?Q?zCmMW9aPxaaWkm3EhhWpnSyGQlQP1JRrq5slfN7DvTPKexRinwzsPnoX00Q/?=
 =?us-ascii?Q?0N0j1jkYZXPD4EvVwbOVBy1HX0PZxx4g+O3x3bWbLomczdo/TYLNdGjvUD2e?=
 =?us-ascii?Q?aBdraA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JSAY5YCqOkcl99GYkiNWdC8AsQaQF6tcpAKvnx6t3wuJAdG6SsxBmVXSsnU5hAl6eEeTUhQYZGJw1uRivpq4+mTpIVA3+kQ4MXb/SPBQK9dW+CEMbRGbmmOR5CJZoLeTmJiC6CeJV+oOB0X8ZgPs2/5Fld/AtZAlofGpDy0BqQ99R9BwlIA8uoDqQMJd5l+u92JHUtPHODtUa8mOOoLS/6KKLCZsLwck/aVMPwEaR6dPIahlqIIJVYT5un2qvOo5TmrcsDfC9Dbr/9+0QxQVt5NSNdKCBbHhHZctWhiaL04lcAumFxCIuRgdDqe4xtTY2MbcsNLnEsSE3OdYb+9smD6h+PuGRZgP8rzGm4BPsqLaZNVIZmgWIbv6QcMW6TkdeANuKN6l7z6VjzoNgG2SIrC5J5OXTKPxt1xjTm4B3/EnxiM95FpWfAKId/Dxb/NLLptFSyGgsqT2CY8KoBthzZvVA2ExJEM/i3SN03j7oifA0fH1AG33MYrrtbgcrlUzMowj2bHJUHEO1H0sRQ8UE5vDwO9n9IXQXUZHBXCuPdkd2rlNjUKN5B06j8EwbiRThny+gVB1/wrcIitvnAUG05WLdUTRihNOcqTzZudHwOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac583e1-6858-4872-b9b4-08dcc8f405a0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:02:37.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNC4osQbMFUF/HecIn238bt64jMpAUIAlNxx20O0mUZfM2oGvPHeYgjwY8LuTBJXYrOwvhzp98cROef2CifcHSJFA0ytMfH7qCFQN0meb+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=869 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300099
X-Proofpoint-GUID: EHLmfxCJISOz2IYClV7vtFTNLlF7cjvR
X-Proofpoint-ORIG-GUID: EHLmfxCJISOz2IYClV7vtFTNLlF7cjvR

On Fri, Aug 30, 2024 at 01:59:37PM GMT, Mark Brown wrote:
> On Thu, Aug 29, 2024 at 10:22:53PM +0100, Lorenzo Stoakes wrote:
>
> > Thanks, I figured out the problem, it's not arm-specific, I was running
> > self-tests but eyeballing-failure resulted in me missing this.
> >
> > This is a product of vma_merge_extend() invoking vma_merge_new_range() without
> > having determined the next VMA correctly, after moving from vma_merge() (which
> > looked this up for us) to vma_merge_new_range() (which does not).
> >
> > This is after having adjusted the assumptions between v1 and v2 of the series in
> > each merge function, and I simply missed this mremap()-specific case.
> >
> > Andrew - I enclose a fix-patch to get a fix out for this asap, but I am due a
> > respin relatively soon and will also include that in this.
> >
> > ----8<----
> > From 3678f8a53f98de52f11946d4d32e6fb239d11c2f Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Thu, 29 Aug 2024 22:18:02 +0100
> > Subject: [PATCH] mm: correctly determine vmg.next in vma_merge_extend()
> >
> > vma_merge_next_range() requires that the caller specify prev AND next.
>
> This fixes the problem for me.
>
> Tested-by: Mark Brown <broonie@kernel.org>

Thanks! I will be folding this into a respin soon, are you good with me
adding this tag to the patch 6/10 in general? No worries if not, as fix
will be subsumed there.

