Return-Path: <linux-kernel+bounces-305564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D7963085
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4242B20F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C041AAE0D;
	Wed, 28 Aug 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLLq42p0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uNWBv1w3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A114328DB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871476; cv=fail; b=LTe9JcVBPi6pnkMou7N3Vx51wUb584A9XHxl1SNiyS/tGIUxKFdfXNw30HkGwzPAiU8rexif1cn3dMKV6GuJAV1g+S57tWug2FmXW7GP3ec9HyK45PNpSfPtASo5v+9nfTmb74l8GgT/EyGuZIxQxeS4HI5POa9hbklzCFao1Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871476; c=relaxed/simple;
	bh=h22ANNcVgo0Qj8U4KP5TF7WFlZ4mySR1dabLkXd51oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WWwVdhNI/7gi6LpYAlrd/2lFc05uIm4F9wZZwYqr5hb5NGuTsFFD0OHDAQFPQlSlyQKVO9GyhMZJr62O3FmbJucug5qewaNO/PS6FbpGH0XIWXvYSprPES21ErRxawnIf8Sghd+Fz717Or2miA9RZC6auTlJ5MNrcTecZ9eGtr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLLq42p0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uNWBv1w3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfWDa009554;
	Wed, 28 Aug 2024 18:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4ZvV+ax+vSeus48
	MIjB49mRD2boViS3+GnEwvUDIO5c=; b=WLLq42p0Zj4yLDoriblxVfG+nfjTAqg
	Dnpot8hhKlFrvQYk946fEQSZLpJYEMvDRzCAsrMO90WI9VMwEV8NsqMD5stOzK5U
	jYwngNKIMxgAffeTKuQsh+y5A0scv+PaYewaxMmkqqF4IsDOeVpSGlP8/sTgNicq
	nhC4L52qtewgfWOhefBb29rjCtOCPn2TY4zcjz9ZmhOGJkUmbvTnYH8AnakXX1gN
	6652DtW0t9Ep0RftnXOW5Y8nKLB3sQlbtj0+xWfXRHaPxETZNAnrgSa9Ng1rkrOp
	71YbrEFw1X+qtPtD2hEidYxIvwjTn1fSGwaxj4F0oSNnHWgLuwpK36g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup2394-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 18:57:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SIC5KV032456;
	Wed, 28 Aug 2024 18:57:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vq400-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 18:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVWb6hDs/CrwtqHlICo+hE7p+3JFtLIOBvg6FzNDTSVhJUj4XZMnMlDeSTRSRfH43Hhs7wDpSAgv2JWHPlasgyn9aJE82mmpdsk1sGqkMMlvUcQ5KiW7REAr6zKUlgjxPYfVnGLxPWSELF4X+3uGhc/aZg8+C0gI3TnE7qJVzNKpnCH3NRsMbycKVdQ/NBHZN/cs6IG33uAV6zqzjWrpCAMX0AZWBmPYIz/S+aclTb23t7Haok/bqwMjvMyR4FA74QUXX4Lroy9lGdkSGSRUx1QE69lsbCrcfTH0Rip2lWnKtKIKxj70tBjMNfm/jHjmV/5s5GVycmrjX12yRhzytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZvV+ax+vSeus48MIjB49mRD2boViS3+GnEwvUDIO5c=;
 b=fW6h3Owx+OpY+qc514qMKcE1wwkDEfky8j2gEtyJ4hRh6Xlxdx58CJTYho+pbuXkeRorWHqmHfJfG1wH90OOw+G8Ax9vljl7j/wADXPQ/NjKedL2xOapyUmkUsj+zadOKbgRB8JpQdzD7RlMvwWYInR5zRCtDSxmiep+Wa+95d32kral3Kk/TXxetN46JN+s8O4f5PiHCbXNAXb5DYC7SBGxuyrLDtETckmX50vYvU34QZRR8K6cTubuE6jo0bfNXIw6Y5hebd2bt8iVpmTgrMKdQPwi1TJL1lJHcreZ1kSDwPbVoZC+AdiREeo0Wkk810KtRmYgJdnqRUEO/6VnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZvV+ax+vSeus48MIjB49mRD2boViS3+GnEwvUDIO5c=;
 b=uNWBv1w36gwBmQhULs3+cPWsYy54NnxCAjx1nwpJMhwuSYEYAqZkSAAjH6trrd1QTkEq6DqBc2ecI0xDC/xDQ7FrDE61Tb6MDta1st+eCv+jyuSYZPpl+INYA17tFVq8qyINl36prLgid8A8SYKT/+Hbe2JwzzFf4Ztn0obnDmk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7856.namprd10.prod.outlook.com (2603:10b6:806:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 18:57:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 18:57:47 +0000
Date: Wed, 28 Aug 2024 14:57:45 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: arange64 node is not a leaf node
Message-ID: <wxjq7waqbtsbrdl3vmbpcyngkqgndyskn2av2zmwqr4ggglkgq@n67jco6acbbr>
References: <20240826012422.29935-1-richard.weiyang@gmail.com>
 <20240827183426.ac84f442e18b66a8ce6bfb90@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827183426.ac84f442e18b66a8ce6bfb90@linux-foundation.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0312.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 6088275c-113a-4099-84a9-08dcc7934e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2V3kHyjlu1Jpr/s7P6IQEgpMpCHm1GweQolphm8xbFdn4c1Cw5+LRp6JjkI8?=
 =?us-ascii?Q?3oUhB1xx2TV/sg0mr/7nz9j4WAb8E7IsC8NT+5KJeirK+yg55L+bTqsB+/qx?=
 =?us-ascii?Q?/gLHOvkLTjbYfpgWEt5SGXUJVThpI+wZVKEKycKZ0+cbRh5L99XSXdnNcxs+?=
 =?us-ascii?Q?EFb+yGC++O/KXSTEpzo0AQX9SKd3L3OI7vEPCIMCsktHta/KsKQqd8tQbg8c?=
 =?us-ascii?Q?ozWqn+nt/FDuslCxi8w41KQP9b5Y8Or4N1NkuHbAFf4wWSr4Of2oK9rnA58c?=
 =?us-ascii?Q?oCwx6dDAp7q4slnY7G5EPBKPZrCi6B/8DzfKigY5u0Iv5BwEExaLjwnUiKDJ?=
 =?us-ascii?Q?IibGn9K2YNe/F7+Kc17EtDU1/Bkw6SHZehb0vUuXDnYtoZoazFj/3gGJ258h?=
 =?us-ascii?Q?qYU2GzJ9yHDXnZxNMGRN76fkDX3FY1cB23QUxF3Jwj+z8m7dJY4ESETKJJ+G?=
 =?us-ascii?Q?iHUOrFBv+p1r/A2VDNviuj35HDV/2zPiLPFJoDbLazQ7SIcamaTWk1iYP5hG?=
 =?us-ascii?Q?A9PgNSuw2ZDdpo8VWJj/0uTnVWjB6EsRXEIfYyLUd84rvPm29xeRTjsaRvd+?=
 =?us-ascii?Q?LaF0pEPgi8ZUuXanb7PV6+/deE4w9Qhj3C5dRJv8n6H/llZONnov2cpuvmjt?=
 =?us-ascii?Q?hGU+a5dz14xaxGnmsYjhU8FPRFJXwUyu2qOscN3K4eh6/e+Wqvw3TN1w6HsD?=
 =?us-ascii?Q?Y5klSmLkwdPnTJqIiVZMRNs+jOaeJNDhoSS7PKeummPaoIgzMI9peuPvw1Hh?=
 =?us-ascii?Q?e6tyOXCL5FLDvD7b9mDrr/XCToOMNv8+XZ7adkBUPz9xI+FKc7RJJ2crji7a?=
 =?us-ascii?Q?GRAII2Rdqi2yujzfnA75axgPWxu0j81Am4FzzOLTVTLhYypnw6bTZOvEiPJT?=
 =?us-ascii?Q?iyTs8me7E++kng0NNttYxUQXHhW+9qLjsz5wNQ65q7jxYVME1MsAprjNRAyF?=
 =?us-ascii?Q?wYrESI1L8tWnhfLoQUS1d1SQESRSgMJmHlOTFfYUmNK4F29EXIY/BkU+CBKV?=
 =?us-ascii?Q?jLIaz1w/eHjxIgtd4dC/GQUmwrZqGz7q1yh+vZONrcK6uiyke8T+8QcCh2bI?=
 =?us-ascii?Q?Dlw++y7YvpJkSG+N6Bg98Efx2GhmgS6ORaIHFQSsH27SjluNdvLtXdlQcxMq?=
 =?us-ascii?Q?K2Jjw3QW9arr9jp+fjZ5qzhq1UWDC2Z3NTWmJ4amplRguMLOp/HKvrDnCaQb?=
 =?us-ascii?Q?kVHdMv7047VjTfaBLL7JAu5VnRU7xaDID1zlGqlxxQu7FQqEOKRw4pu/mXsG?=
 =?us-ascii?Q?wIfE1F9mf/1fZFhkw+dhO0z/8m977jGIdLhX4K1INC/ygyMbX1Lc2lkpGhG4?=
 =?us-ascii?Q?fIJLrTvaHJYiflltVlQSXuMq8PcVwZevIsQ2UsHYjnQNZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQVhpaFZ7amdqJh19ZeIUh+PJHAXPhFnl8So8nq6FrQHgQW+tWoIs6C+jmfH?=
 =?us-ascii?Q?HSHQocI08BJNIkiFp7o9+3oIEuucs7kNSXQukRBgvJlRVTcWLFRJRPMQoAn3?=
 =?us-ascii?Q?QO8xGD33zfh7gOtfLfiK9bxfMWpqRcl5AUHkpOSmMgqmLzgKVQfXyMAlD3R4?=
 =?us-ascii?Q?IMJjslxcvtf0bc3ZXNq1FpVXDOAEmK1uKI9mUdLTET9xD//oPXlORmgms9D7?=
 =?us-ascii?Q?A7l3Kqo6As2nzzuSfKKqrCrhhRH1o6jGUBjHwUU/8e6zsQrihdaYtqSUTzus?=
 =?us-ascii?Q?tMVPLRJmopvZ41grHDwLmWXSNj91UWoFrfLjqVmKlaxLImsqo74Sb4UCCRGP?=
 =?us-ascii?Q?nHd9McRzyPaRohZ3KcWuPScpI/7TMLpVVIs3PTIjy3/c5OI6MOziHNDB9V+r?=
 =?us-ascii?Q?6a3IDFUPd2hl/cd+N/ZCsUX6iM1LjDbOD9rqwndgphqFP/+OuoR4qPinryt5?=
 =?us-ascii?Q?F1rVRwHv7g1HhyIWAsk2Dp4jhSNxHxlVM7vGN4PGVnFx0HX2tYdcj8ZDChPa?=
 =?us-ascii?Q?YgslN7oDCsEM+ilo9H7GVmmPr12I3/e09o7RtmP0o4mSvhQpNCzMJwZB7Tew?=
 =?us-ascii?Q?0U9Nl4p27cALrR5fYyzJoqjwLxWeFTNUQ1Nb2YM4cxa/6/2jeligcRnBHBnH?=
 =?us-ascii?Q?oefpucJLSKokrhJCxZFWqNxeK1H6ITT0DNC+4I6eBHvn2TqMge30gv0gisrM?=
 =?us-ascii?Q?fivjMYBvT9iRiyNwn1hvYNnDHnm7Y8zTyPWYq1hG1EJiAT/UbnQEMHN1iXRE?=
 =?us-ascii?Q?TVlk4/E+bwaWkV4nc85gFwq+VekCSl0AJTf97A8RZFcmF6+XJ+Nup6GR9YLn?=
 =?us-ascii?Q?rE898G/KjW3Wk/b3BICunnfxPz/sRGlUPlfC2D0+fp1Q213KzTV2r+6VB4ao?=
 =?us-ascii?Q?ZK1a9Sydf0nOsMGHmYpyB0ZfV1pP/qea0FIelF/XMzB8t3FPQJBkN9gji6YB?=
 =?us-ascii?Q?IqKEcfpoIoofLRsDdprzAwChZMjN3kj2vRkL531furMrHLP66sIoaTEhyZDl?=
 =?us-ascii?Q?5SrxNKIGgHxx+dZq1LR5RJpY6wDOlQttoACqpsI+nWmwDCk35TfCb478hlu6?=
 =?us-ascii?Q?Zp+2d+k7uVAe7pjx/xgNoMQ8hL36rKsIpJe9u5D9NMXYAfcgJPLLNgtwvgU1?=
 =?us-ascii?Q?NQCVPKWmcHDbEeBnATzzmvPDfFxKX+2456VDEDxFt+FyjUyt5f9p5ZhPp6EB?=
 =?us-ascii?Q?ORJBe/VUNCNAHBSzcuekryZqdzg2B76WFi553qic4Zr+rtBhlKwb2wIBWjs3?=
 =?us-ascii?Q?3TlzBAwk6LkGkgNizA0Al2sJQ1hk/W38l8E9YekThAbrNRm3J/9cW5ZeJUCx?=
 =?us-ascii?Q?6Z6DxPONPvbga4sn1AD0irGK5fKf7PeDFNEwnqBAsrUIdYPR24J2GoqEIE3D?=
 =?us-ascii?Q?gX0Z4TUWz/qZUHWojq/5muaHlBp4roI77pT4ovcB33QCy4nVmtHDk8d+qvlv?=
 =?us-ascii?Q?PbXX5MX88JYc0teyelLb9iRHJ1ZOJuE+4qUayIQzgKJm2DpK3HZMoXt0SaO4?=
 =?us-ascii?Q?PH/bQffUCMRgqYrLtTwfm/an6XepYiNGLIprgyQJWKuFoMPF/VdVSzUZmP9L?=
 =?us-ascii?Q?tZ7je7kR4L2Z5cn5r5QxjRtkH++zsoDV5v7ayCkx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XIhHnTzsLj13c9E/TYjxxcXWMdJK/gWEYEWMDd146ohfcPzBVEiCLzwth0tl5RHllA8HdiKmvLyTKZEmFq8g7ur12aeGDuKdPgLG0KexZRgxgOIfbS4iY+VuZzWsA2Hfui5+IREfL6ANI+MOj0EnfEV7iYTckTYdkfHkfnFxWlm3ZWdtP8EA3jvSoTVslAQ1etKwqPfLAPvu3LomdY58vQo3cAx1Lz8WZAEw4eDj12eQy3Hv3p1y82lGs64YPiSRZw+oFcDtYU1UgK/oRFs+Nj/8FqY6OZ3jY6x58XG/yN4+q+rW+KJLua+RzBvfuNUuhS/vCel3R5Td/SHAIfCFrRVESPbTOypAcamRtSTQAKG69v7BuN4c24MjUkMOEYAKdXyiSDj1je/ml/bmbjmU6Y5DX0qnbKUuw38FjKH6VNtKvd+CKsxZeGjtS/E3aqRn55+aPhC11KUH0ItOFr08KYi4kZIxexkALLX0QoLZ6xlIYhyLb9kQErFTuOGYAipfrbMKkSfdBcWFCSqWLKRBrJdPGrl2FgcqfS+eSaXE+tDgPOZfH1NkY+Ce9vvk2uNHoAt/Aok2ljRHJNvY4BSgnCZqcHnG/QmOTAcGwQn5gkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6088275c-113a-4099-84a9-08dcc7934e52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:57:46.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjwlWHWH6AJKspCaUKdeMCrlzBzYO6iqsIM5wbV0A+E2p9Nge7CO4b0MfygGK36cBUOf8E0mWa9pPsal2ENUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280137
X-Proofpoint-ORIG-GUID: k-sFAdmEVklPBOaUOoREUJhB3RqDSl3x
X-Proofpoint-GUID: k-sFAdmEVklPBOaUOoREUJhB3RqDSl3x

* Andrew Morton <akpm@linux-foundation.org> [240827 21:34]:
> On Mon, 26 Aug 2024 01:24:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
> 
> > mt_dump_arange64() only applies to an entry whose type is
> > maple_arange_64, in which mte_is_leaf() must return false.
> > 
> > Since mte_is_leaf() here is always false, we can remove this condition
> > check.
> > 
> 
> These are pretty simple so I'll say lack-of-a-nack-is-an-ack ;)
> 

Let's make it official then.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

