Return-Path: <linux-kernel+bounces-525326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF98A3EE85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDA070369D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D61FFC77;
	Fri, 21 Feb 2025 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBxPJWbT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="opFeJPMJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C84200118
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125803; cv=fail; b=gW9uGBvGE6726pDN8YVphym3u+/nw+/ygGNa4JPdXQZClErme5ckYyWi0b6+UG1rNHS8nRN2V6KaidrmaFS8QJEAn8USajPTneJNmp+eZU0uAdNZ++Z/vdBTThyEytpKrzQw8oSc0yy2ZbR6TASaZQASAiySdYJ8jkVArRiOTIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125803; c=relaxed/simple;
	bh=UFv7JYUaxrAIsS5Z1nSRdsRlGlZvcItmfTTX8/kGO9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tb25zAGN6WvaCQh2O8cM2BcPeJM7Z0Bdo+dKx7+945+/CRyESoWxYCGntVez1Op+jmFAtMtzXe5ZpCdmvxviwktuGB1Bn9VATV5ahmLvUNlx5olmFnDmR8VQljCaPZLpGeoWdTaJQBQguekTQPz6PbTIm7XmbpO2VwHprJHZUyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gBxPJWbT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=opFeJPMJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLrd4a013624;
	Fri, 21 Feb 2025 08:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8Je9RRTsxLq1ZbAFoI
	Rc17OxSl9K4VLUTM962c0TzWw=; b=gBxPJWbTPBTPQo+X83QfxPGk0oZZKoUlHC
	PA7oTvZR4Kt45KV07MI3KKOd4jnBfkXwPxwz4d9HWZrJo0/wxxoGOg4GCHBmWVvH
	Xpc46Oq6X1EpWlA9emy8b5rjKFxZMAeXKabKvPtXVOADdCPAmBtppXGcaWhMcKK0
	ZN8KKDC876x/AGaAqnKsbFlvTt4OV5njLtrS3+sjBh+6CoxU8jgz9h/O/ln2RZA9
	Kl4MDiejBmnpDIJFQ/r1rb4RztJPOAo2hTm/eTldyCPZk+cLMdrrydGG0Bql1Fq0
	nUAGIthtOIiRZGQf7N9hkoA8HBMoERG4rd8kLH7I6/uuUESCVzrw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nns8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 08:16:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L84n9D002183;
	Fri, 21 Feb 2025 08:16:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tpfe1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 08:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAFJNl0hrD/mu4PUuRrIuoy0ZrEnltASvpuedq2GTXm4tSUczrx+ENOg8YZbgvLS6rFOF2T0IzbWUx3oVOle1yu/0jPsJGF00XV91rK1a/E0FkiHQroSpwg1izsIM8vcRvNYPhnNoXc+IYYji6EFgEZMYpkyxOIQJbIxw9ctF/CcBurG+jj3rXuZmwpuDDqZf6ajjin0jkwi4ysleaXZh1FUR1lfNwgRnYeTc3pjZIVQ3QOKjPqITw8JRHju1AR10UXPbTaIP+AXWlV/Liwf/sRB+OeShzK1jyFuYjfULJqyx1DIW7zVxij4I5I7aQH1TxtfLvXvWHYuiYDjR8z6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Je9RRTsxLq1ZbAFoIRc17OxSl9K4VLUTM962c0TzWw=;
 b=T79/BlnVULWVuLESJUX8CbSrL4Qy5DkPXhqJvopWTU2ug9ztg6TnURvceqZmHbIBH/owvUY3HYSVb352qax8RdQQzDfs/kp7kYvQ1KZwWH35erHv+p8TGreaWrs9758+vfqcwe+zGgrxcy9124IxGzdp4PEGNYa62+Nnb2CYH5v+8wyanjgdUbAP/lIyhr+7GiWQ3grJjluhrrKzC2rmGD3fnDhcliKm2YYFzmg2/fLeqsE+a1A2AGF8CfO2m81b3PcZFf+RgD5fBPq8MclMPXu7ufOVDRApNosXIv0JMGZtgYMSAsnGDANUF6tgyRabtWyDN4rfsNENZM0rxvWEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Je9RRTsxLq1ZbAFoIRc17OxSl9K4VLUTM962c0TzWw=;
 b=opFeJPMJe9vGUj/5ZXkFyZ+Zv6NAwsW73U2btrznasSAffS70pedJhSaJWev9nGqSr4fAvwnqrRf1FXo3QzvGaafcAZhqunVGiVUb/nBXUGb9Wzk2TBjMu26cp6w5WwjLb1LrpYcZqQzwyd46IuTuef98l/YSpHbkGV+2VnviLA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 08:16:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 08:16:10 +0000
Date: Fri, 21 Feb 2025 17:16:01 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <Z7g2QeQp6HkyqCol@harry>
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
 <CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
 <20250220033953.1606820-2-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220033953.1606820-2-hyesoo.yu@samsung.com>
X-ClientProxiedBy: SL2P216CA0208.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f87736-df26-4ef7-fd26-08dd524fff86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BfSZbnYHUDCRbYYwJJLmdhz91tadK2t41nPBoRhSWHhrx2cEyBcC9gwJ+/2C?=
 =?us-ascii?Q?BpVZU0QG3QfJkeBlMAwYHhFe1wvF0egsEpdEJB7W49tPcBeijWTcUjL2lUpT?=
 =?us-ascii?Q?je3iodnjT/eULzIFviBbXfIV1OKM0OLRzDLBkUn3jjJv0CxfAikvpk2hsQy7?=
 =?us-ascii?Q?KnDZMSC0XbMWh3kaScTvS0gh5eKcz96RBQ/Jq1lZQt2IbFsvmzESz4vNEktt?=
 =?us-ascii?Q?BQT1vbxFpkoO3y67gA2ep8XH0kULyZh4k7ONHEJWpyGgYt727BwP8bw2r0a0?=
 =?us-ascii?Q?yofnbCmyF51ReoLBy3Ap6SO0yPujVziJDdfjM9guJp34BHmxpLdkdxV5WIuz?=
 =?us-ascii?Q?CcvGPj9wK1zZeF/cn2c2K09yGGo6YDUMCKH3EEIfrr2lm9ufsS48xMd3g0aX?=
 =?us-ascii?Q?x+2d4criAE9MbDv8lkfCYqS/VNVGKdGOnITeH5L/V21rihTTF5mmmzYXld7t?=
 =?us-ascii?Q?3vwNoq21OORlAy7CkaEHBvvuWdIVKT15XL9sk81zrkcGGjr4VUA6e5IAd7Wr?=
 =?us-ascii?Q?Y3U91J5MBZDhhMHIBPqhOsiLttNosiFZgSbyHonpN+wYTF9nA+cHrWb/o80N?=
 =?us-ascii?Q?GeVAvBDxy2wQKuaE6D4OPE31Fu4rKBO3pw1/gU2xeuuXMxPAayFp+HW9JVkV?=
 =?us-ascii?Q?kUIN5yjEZN6szOuXXdLfW3zwPRTKj177oGZfUpmUtXwHqFJ2LhmFk5T4wUR5?=
 =?us-ascii?Q?OAAeK+rOhwPWw21Mdb70p+64ZQC9ZeUvt6KsPRVpn31JMxKoVkI+2vq2dEol?=
 =?us-ascii?Q?kJOjvSer1JVdIOeuUUMGgYRsnX2v5qlabDTr3sHWdZWNk8cc+L0jZc/fK92+?=
 =?us-ascii?Q?rjW1ZT09FtLzRhQCqm2EddyG2D2i9e+SXuFLYemGoxm+q34q6u/fXrGCT4Q0?=
 =?us-ascii?Q?r52fRUhUYXg1HhTpAlvQ0dNcQiqdVlYg/Hsqr9tGf3R2yTQhDFGd+K5svTjC?=
 =?us-ascii?Q?SxA6V8MLNXkm5dL7b1nK2poJHwglb3InzoHke2kh8Tr/8PBVMalePigXVrA1?=
 =?us-ascii?Q?et9MTsQxx/5kEz1ATUEzcn3tn095jMC5EnL1AzhUjU8wkL/4TVjlnac8fntU?=
 =?us-ascii?Q?rBPjqzTzL41T2h681VUynW7bZNdbceWj3UrzHi9lTYIZ9GGK+VrVIlr2bt8P?=
 =?us-ascii?Q?xKuF03kTSp7ow7sWacSSrqEKZHnX0//JSX4lx/nCM65bjmu2UTOsJSNAH1sV?=
 =?us-ascii?Q?KfEkBHIDgc8LSywaABuLM7yM+eXxqkz9BSDGZYeO2Jun9GJ/iQMUnw3hsY76?=
 =?us-ascii?Q?tMz7GfCZmusAnbZ3AyEvIVkIK4beqObt+GhVVZeyDGkWb4bTr6n4adXECIUh?=
 =?us-ascii?Q?LKyqRwjY/8LQsq87UsjMWU+Zuu+efb9yZYkujMaafRkc7UgVvWDKnt32ms1K?=
 =?us-ascii?Q?VDddS16I3LPVRv+TvwpKY/Zr/3Rd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mHepIFHRZ1lZrYdmBWjU//cm5rj7HTAvFrdOfv+I4/ja8I280QQDlnKPyM1k?=
 =?us-ascii?Q?GGl+xuec0Qbv+5JZU4dTOxmoxllJPChF7kIzaclkCmoVk20HzQlAEjgKq7Is?=
 =?us-ascii?Q?foFapdY4VWq1flYjqdpnULR8cd4tXJW35DSEY9crFa7zGq0cDRMmRiO8v916?=
 =?us-ascii?Q?yhL2RUXMeOvM1hlQN9e9hsJ8xQIBybFhcntjVHVH9PGR6pq04Mqon3XxzFuI?=
 =?us-ascii?Q?CrYKCBDJP2WZiR8mrogf2/syrLaPRAkp9iwZEc5nWPTIk+bF6REEa3KjR1I3?=
 =?us-ascii?Q?RNPhRLVoizIzNpLWy17rB66Gd6HwsyObtJAbdeqjIuFUyS9g5x/9GaS2TU43?=
 =?us-ascii?Q?IyCx+J2LvcJ5Vi9qWSdbB4kU1gX1KQwHTRYLjYFc5tBJQHR+Sw88wX9uHOc/?=
 =?us-ascii?Q?oTTD8zJ4/OLucxiIe1mfXoqGMUtF1Ha3Hmo6ys23eKzjhC8RVHIBRc9of++9?=
 =?us-ascii?Q?hZ62gB+ilRK9gDGtKHcmpdqSNgxKJa0Gdv4Nz48xcB8woxCPs0QAwfzIpLGZ?=
 =?us-ascii?Q?XS9mY8EIWqG7jXNrL8wvQjyfJmDMFfUIuqC9Utz3PoUaqQfrPn62uT9wiltE?=
 =?us-ascii?Q?6FCcWj7a1ggUgcnc5rfWtzC6ul0Pc2lzQKVTP30hkEeGa4QC69zjVB9X6NpQ?=
 =?us-ascii?Q?OSoZcPwGkKFjNgtmV5tvv1+FgLrX+brhlLzQ0esHPeSPY3eyFpJn40DLy6L9?=
 =?us-ascii?Q?xOsc9Z9jk8UvzB62MNa4Ws3RVK0k0OWy5pauzbcPEqswIDhzvuIJ2XyZe4l0?=
 =?us-ascii?Q?vS6bz8iFmMWZRUWnJrhjNsndyD+GEmYuORSE3+FrwEtiw/weR5izvO/EjV9i?=
 =?us-ascii?Q?yaKkas1OoNconkqlgC0j0iSe9JBD0QeKJl0KrbZ29G+Tw83Qojn5DfzVCUm7?=
 =?us-ascii?Q?BDYkYcSIFkqkttd4kUTqn6JYfaorp4gN1w6oV+VXRZylb1T5pH71KWze07Q3?=
 =?us-ascii?Q?JWPL6sc/Sgm9s9Yti5dOvJ5THnlVKLg0AbpnW5VtKL32xnCwMSS9+FGRXesH?=
 =?us-ascii?Q?aNh6Q4D1bfaWBr313VW0Wi1q46UDeImQFJ4paBHZW5R2lRiEkclFBHzEpYVe?=
 =?us-ascii?Q?Zlm9NvYlMZXChjurp4X8zMRsP/puPokK8Rhn88PMFMba65hMR+q/SANLiwo2?=
 =?us-ascii?Q?6n2Ej91YwdOLE9Wzl/pUB34fEAaUkY1AJIXzNKfJYBvrU9nN4t7Z6XMoPDWG?=
 =?us-ascii?Q?ZjHb1d6VzOXzmZSsSvAT3ZjHB6fLRoyL5GubMcm6E5FWGcXWZFHu/pUJyOfO?=
 =?us-ascii?Q?ggSDQ8R323O7ObNf5ASwhBl4bT7GQOqvJtIKwb9/RGSB1zJ1HEImzl7Jvb3J?=
 =?us-ascii?Q?VuY8+dwqIEnyxDQyMYI6oio3Ka8h3oZWF1tpH1/P9C08f1IJicoWngbnC1WY?=
 =?us-ascii?Q?x+FBZbDtnmWZLWtU5/QMpD2HgVKFyMIOmwg4f9RlII/zDhh5oAiazTeqgaFi?=
 =?us-ascii?Q?f9dGqxutHxAmxudlylMPGyrG0zL3DIsqQRcu+sv6DIXtaySKp+fL3rxlmHE/?=
 =?us-ascii?Q?o0QqYVJ7bqAHWdfn28vC4VtzODJ3RXzCsoP+XeH5frm2ohgpuCXA/RM+itJ9?=
 =?us-ascii?Q?kiYHFG0211yGi6isod87ZA+2IyM14hCkrTdoJNyW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EXc2H2/gIlJjp5AuPebafh5kwhAtGuFGjH4CHfWmbcXhZlJsnxBEPtfNn8LdcOcww+po5ajh5pVRfhwfxGY01Apq8UiIuIyMq6M8NGf0571RGh1DwfS/po1Q+yYzTIDNdYt38LiFZcz3GPiQJNH1KbuMl1oPx0QJ6EHINAc35iCBLv00IOc8QZ3i1Q3TceUb7rrBEuEzG+A8JWDcPR3L6PEPJ/RZUYUgWrySKYw7lx1jSE1b2pcKcYJANgd8HLb5IxGL5M2T5q7ZQlUF5yTnW9vFPqgCOh997G+5kBlNrIIXHeZZFc5JPCVbcKIXEa8EFBPAgTOWLX83KPrDL0du1MqechajFUznWXk+HikV8mJ5XtHwhTT7lgqFoIr8bBlNuw4/Grqtb4bbkIRKys8J1ZNI14eL3oT9yX9/eZTs/RXN/ajhyYe0RY4vXAknnjaYvpGo3fy6lpJXHRO3hEbdsEPoIDwYTNer3QYG6GLvnT7mPsDmMRUPC7V1DMcDr27AsIhEGSrGFUOBYAH4TnX+KJD2bc9nw5IgYhQKLEY52CHtJP4Pf2c20mj0KE+xnL7sJZrLo28mK9dHShfTxRw409shCD5crOzi+NZ8SvE+qZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f87736-df26-4ef7-fd26-08dd524fff86
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 08:16:10.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MauwE/h8DyBna4n/9745ev5QdweI/tRUS7qS4sSOgLE1sd7SHWZ/NwRXon6BK/wKIp9Aiwb3lAM5FHpd10wlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210061
X-Proofpoint-ORIG-GUID: _Ums_CLQuJPkLo0A1GBqKMXu8kLBAIHl
X-Proofpoint-GUID: _Ums_CLQuJPkLo0A1GBqKMXu8kLBAIHl

On Thu, Feb 20, 2025 at 12:39:43PM +0900, Hyesoo Yu wrote:
> Previously, the restore occured after printing the object in slub.
> After commit 47d911b02cbe ("slab: make check_object() more consistent"),
> the bytes are printed after the restore. This information about the bytes
> before the restore is highly valuable for debugging purpose.
> For instance, in a event of cache issue, it displays byte patterns
> by breaking them down into 64-bytes units. Without this information,
> we can only speculate on how it was broken. Hence the corrupted regions
> should be printed prior to the restoration process. However if an object
> breaks in multiple places, the same log may be output multiple times.
> Therefore the slub log is reported only once to prevent redundant printing,
> by sending a parameter indicating whether an error has occurred previously.
> 
> Changes in v3:
> - Change the parameter type of check_bytes_and_report.
> 
> Changes in v2:
> - Instead of using print_section every time on check_bytes_and_report,
> just print it once for the entire slub object before the restore.
> 
> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> Change-Id: I73cf76c110eed62506643913517c957c05a29520
> ---
>  mm/slub.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 

> @@ -1212,11 +1213,14 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>  	if (slab_add_kunit_errors())
>  		goto skip_bug_print;
>  
> -	slab_bug(s, "%s overwritten", what);
>  	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>  					fault, end - 1, fault - addr,
>  					fault[0], value);
>  
> +	scnprintf(buf, 100, "%s overwritten", what);
> +	if (slab_obj_print)
> +		object_err(s, slab, object, buf);


Wait, I think it's better to keep printing "%s overwritten" regardless
of slab_obj_print and only call __slab_err() if slab_obj_print == true
as discussed here [1]? Becuase in case there are multiple errors,
users should know.

[1] https://lore.kernel.org/all/2ff52c5e-4b6b-4b3d-9047-f00967315d3e@suse.cz

-- 
Cheers,
Harry

