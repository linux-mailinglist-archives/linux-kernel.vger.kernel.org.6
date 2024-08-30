Return-Path: <linux-kernel+bounces-309303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D49668B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B236EB220E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBF1BD035;
	Fri, 30 Aug 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L62FSgzk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D79zxSJf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B51BC061
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041459; cv=fail; b=k7ZaMmxQ14um5qXcTBzJR0H6KgcwmNYaeqE1ggwSKYafTzFtEdF7nSTteGFnMF6dstgoz3+cjtNoOiWm2qMFrYVpn6iZVzzdjlQXp14iVhHf+xCf1qn8YJN4nUOR69sjBVX33CETnybXfHmS82fGUPbL2PLODu/Xiypw6MgMDz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041459; c=relaxed/simple;
	bh=e7F/9SttZGQ3qw8nO0e5C9GpNU4gw8ufrK07mCtsVMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1M7qt8MT6F7CiC0hb0Az2sWmK5pWD5GgVCMVQqi32JDFEb4FzVMFq+jtNEcbYh9ObUBcH+0j5yz2UwIiXqA8jx8KPATriTdiL1Io7xmu+q8ZCic2XIBmtnmHEjS54ZVH9RtYwDjl/IjBjwl+6KvURO05zklYXBq5JNJKhzlc08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L62FSgzk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D79zxSJf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI38SC025963;
	Fri, 30 Aug 2024 18:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=JrOopmNBt9BOZoibLz4aFoc9TugHVaASiNS4H3JryOU=; b=
	L62FSgzkokgiArVv1dYGiyUXRdg4Ou47O9pgz2tav2tinM4g3ADbAh1K4SzK9oAE
	3/kgZafRKE7C5sFSHPe8dUUtRN0F71hRmdq4ID0V4RvLu1uMkUzOGrnQ6YqIRJWj
	aLRWiSITfiDE91hLP5asdnDkyEMntyVLzyesmNwG+U2k0za4pMqcMkdxr8jYHZlL
	ZN2cY4qU+UO7+YYYtdwfcnZTpdc9F3HKHcEW9d0ZEh/feojhjY4d+aeBMj2S4sfk
	7tng5GJB7okq1woZ1jGwFvIYJavjcRYUEAp/Uc0cPX7IOMjcZ6/LmB/79BgZmsUm
	BN9xT9UsGvJp5Gr+iVhWEg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugycb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHAH46017427;
	Fri, 30 Aug 2024 18:10:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wru5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krw6pgV9itItcC4j1FtFYwj98XcCuXZqTCe7Mdnk4LoFObpt90nVm+lvbxWq1fSTJmi9kLmfYEqvhV8wav+goMzKWqxivMZslPSET21StQKNmQ2X3WdKGh4FRSElBbjnqcUc7jRnguUgAV9S7j6mQMxQLqVuyz5s++Loomy5XdqustXIwUyck6tBD8FL4e2ZwzdIx9HXfRyKy1+sjq3mcGw3qMXJUezSbxrPwXyXgDRjU1m8EelmrJrKJpkgRwkCJRH+NjPBwUS0aFDA+YQu7tdlLUnOZguOnmn3/fVDklcR75ENWWdrP56x9s7cTGKLhpZnU7KPK5+zGxYzajzOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrOopmNBt9BOZoibLz4aFoc9TugHVaASiNS4H3JryOU=;
 b=zBCz9quZr8HXnqwSZL4me/2SZEeEvivpsOrA47hxJ93c9tdqlZ9WAoA+dmUZyBl4ttR5EMfdDOsCwI9PCwWPEG8k49yjyl6HmLai5sHrg5j8zU4nlw9AxlubHNynPj1vqRqMIrNgqwgYVuqYnlhun5P80RSMmh/EX/Wb5lDlbnS3tnAAoNc/zg2GGZHN7iCyTD4c4fWy7dIrFJ0/ihn7V2RgBmEm+NBClH69nm5Y8Ky29O7au0Izs3UwK/CFjB7No4jQwE9wMZ7x/RQBHNFNKmMR8R3IriKFM6x6HFHazCGPW0mRH0bayPEeL8/kWxN+a0wxpoRrRLCSLRKGoWd0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrOopmNBt9BOZoibLz4aFoc9TugHVaASiNS4H3JryOU=;
 b=D79zxSJfTFRc0Q669QMfyH7mS07VeOH0n/ZTphjURJaXRj9z1VZu+8C4HqvJ+Ih+RzQOzp6Un8j8+a8yhKn/Lke7GPk4aD1pu6SuACkiMuRQ8KOwpwghLB/jSRRNqX2t2WQa6oWlDpzhZH24lcS1ftbREBFtbxKKhNAIpO2k5NA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 05/10] mm: abstract vma_expand() to use vma_merge_struct
Date: Fri, 30 Aug 2024 19:10:17 +0100
Message-ID: <4bc8c9dbc9ca52452ef8e587b28fe555854ceb38.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::32) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e85332-2d7a-4dd6-ba71-08dcc91f0f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ekidajJj/DZuU1Bheccem9MPqNqeBP7gMLbyLJMzMa+5fHQuJnj7xuFjjz2a?=
 =?us-ascii?Q?H8fuPyeTM05y0h5+Jp+Gc3KruRg3x/oEPM1mki53qLGv7aRHG1LJ0xuGRXEf?=
 =?us-ascii?Q?aacXDoufsMV8fiouXdUyhSltbS9i0UdLj5YNLjoU5KjoqdWxWcDuwwqJYqMP?=
 =?us-ascii?Q?T1B0hHB1+f9vNNVQBTL14+6CT8okoE1+55hhYOKnLyBWaks6lYhmhzzkCoW/?=
 =?us-ascii?Q?Y2XyS4lagwWLagAGO6Si8TsvozqIyhrEi0GjUKePd+0IbyU+cPvxG5u6hhfH?=
 =?us-ascii?Q?74Q5QHSwR/4K41KaxpqCcrkOTcPON+Zt3RKaHT//AlxvXjiydhz78ck5MGZ1?=
 =?us-ascii?Q?KPEGIPvueOnRw2RIu/Tm9gE86kUKv346qurHgPQ6y6cYMk2GgBqN2DSmDRyy?=
 =?us-ascii?Q?7sosid7H8F+JmmzydPWfN/HeXoebrbPusBHhKsYvuYXMistihekgTm/+bhhP?=
 =?us-ascii?Q?PY+nKwj1oxYT09OB0QmizBc5wCDH0Y1EooL2N0FIsErX/3EZvXxkW4wzAcjS?=
 =?us-ascii?Q?6S1GvqPy/+aebVZVIlhuBJwnk9mXao9qcoOPCSpLtKviXV8KDGgXUGqmunyC?=
 =?us-ascii?Q?1Tfj6iaN7IPAXMkg5JWuYH9VBQLu2gLM/0o4BhelgsJlgRu/Z0ruxcg2fqre?=
 =?us-ascii?Q?MpcgDe1yfwW4OcJFhzG8vgjH/mbgbzCX54sBCm2fECNW3L39jzcPtOZDX5EO?=
 =?us-ascii?Q?AI0rOX6S69jQI0lSjp5gxGphKwsYw9eD9FCfnbDr4Kqs3udfKDug0RUWxwCr?=
 =?us-ascii?Q?BjfSGb6MrlXOsJ2sFNwXU4s5WwFS2xAwPfCBDBmlf25Akoi7SlbNiUza5fTy?=
 =?us-ascii?Q?pOvgwn9hhU6uok+F63PHJL8WD5u2e1B4+9Xps7+DNKqYMMqlPvN2+B4r8WDu?=
 =?us-ascii?Q?Ueqd2z3G7FqWmPmwwyZ/jaX+IJQz2/dPNJKjG6ucLZoSutW9NQ+3XS2F6s8Z?=
 =?us-ascii?Q?d98CaC4coiaY44w3l8PSPC1UEPL8fI9UueZsoJ6KTh5vUAeNnMPyTrjCpMgw?=
 =?us-ascii?Q?D17fWsRY/fLL2VvHch+4aYc5pmDe2BehXjngH9RaM0hTCUiy44Q1yo1yGTIK?=
 =?us-ascii?Q?+aGpkwTSQVUa/2NngojsmvJQcTzlLU7cjJsVqU2gU/nyKXKYnLAb6qRPDJAU?=
 =?us-ascii?Q?i+me/QP7cGyPrcVAk232HYCEE4c77Dg+5RwEXikTMQwwP+RRU2wFh3H2ogcX?=
 =?us-ascii?Q?TvuArb/roTQA0hSkVrslP2lrXA9eRv0dPJjkmPvLMUIvd731O34umom6I4Ij?=
 =?us-ascii?Q?kOqBgxN4RCrulIc4jQrEa1goq7lkNHTPgLseBNhrA5jrm96mNiDE5C+sGWW9?=
 =?us-ascii?Q?biPM1rpBYTR6cbcBNYD3ef1o23+IJnw9Y4qnSQsb0FK9Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXzbYRw2d70C1rqKYdHQjBMTxBQWANlIspF4jMeABlObeykS71BRKlDW3qVo?=
 =?us-ascii?Q?hjw5ZwlCPuV2hF0X0YrjOkkgqsr/KzBrchh3R1feyKmF1T01wRzKPBdnY9cE?=
 =?us-ascii?Q?GzQu2D1h9EEXiGscMQNFiMw3/L1YPOqBzizSoaL98Esz1wrBJ/fRqxzjFce5?=
 =?us-ascii?Q?93u/yvenjxgnCw64gp0SvY8MfPLoX8JBvQVsVZ5Jg9jYV/UT8SDEMsk9ly9g?=
 =?us-ascii?Q?pyUe1EXsY5h0lsQnQuU7Ha8XFJ6FLVJ3zOB4+RNSkKN0melWB33VEvgttwZN?=
 =?us-ascii?Q?5JO0D4X3FWRIoQkByq8KZwI/U0lwuwFW0gaFG2AY7vX+6Deb575UM46w4hgj?=
 =?us-ascii?Q?JHX6lk70XnAhh5Xkq8xnDZlGXD4blBqdGpeeFgYx79CJnluXY+KpmkaOXvov?=
 =?us-ascii?Q?Ey2VbdmMhzlJELXBDQPp3x9EfQLzPBGx7OPIokaCko/UOv6ccsENY0RmIEpb?=
 =?us-ascii?Q?phpZOnEL7sIqVm3gWa/Nk4M4dRWPinXlLVpyYnt/Hn4sAt3uWqgJ3AsvbjQl?=
 =?us-ascii?Q?SQIDWMQ79T6LSuGw9C/X9ygRBIUnQecROQI+wJcxy2tzr5630rFVJIPLKMkg?=
 =?us-ascii?Q?p5LNFDaONPQrTbxNF9/A4yJXkoEdsNWfMwSJFFdl8oUGG0WE3zkXdzYgeYzZ?=
 =?us-ascii?Q?Oy+SvHzzzSUfPYTYDZwXARQjCPBKVXdUEoIeaCE+eaynA5puT4kgDw87kbAa?=
 =?us-ascii?Q?+DSyGQysjBwcnr6nSp/DOnTK8ErTyQOuBNBbwaAvCaEePRtRKi7fnsYj5ZE4?=
 =?us-ascii?Q?Xe+EVlDRJsdGqPW4Bqm9yag7YhxXbXTM0zDOv7qgVRKk7OeKdK+4PKV/meXR?=
 =?us-ascii?Q?kWzdvra5b5gD41JzUJdkmI4GY7rkbokjnlOcrrvrG41/ZrJR+HrUMYI8AC76?=
 =?us-ascii?Q?04Qt7M6oM2BANA1lBrjSd5EP+xwEHby475cL0krgh/Hmf2GhpQBxOtejUb/q?=
 =?us-ascii?Q?0fsJo8mnWwV3lQg7C1B562lK8DNfSNMCWd69ZAmDITYVUF61PmvZVV2SDOWX?=
 =?us-ascii?Q?kt62Srg2pMkqb4Y7JZyVJ6Wh0790pCjFfw+I1q8oRUyRryQ7uBQFu43E5vyR?=
 =?us-ascii?Q?CsrS3c0EBt9ZNgZfEH5VDbA0edPKW64BjdL/Zxq4X4XubjaEScb3N5QnZjJN?=
 =?us-ascii?Q?8pzu00G0wISHWKSFB1S0TSIDt2IthNIhHeHLs/5ecIinPIkg6SzFhqpUo/GR?=
 =?us-ascii?Q?r8JfBIM/NmMJEpmQndOCuKe+z6HTSgylka4lFF7h2DUBTi3kYomwGS1NXO9/?=
 =?us-ascii?Q?yD0EGUU4mOBMYquhE2Jzb2SEQEncH0DD1zr9lxtz7mEszR9eXjXz38rQ8OjL?=
 =?us-ascii?Q?DDKY3YUqwKJd0Ji5cFPp3tx/8/tC5dHSNPKhQ4WyzNFHvNVJh01ZPOHLSU4w?=
 =?us-ascii?Q?ywUn0ymVCz3woWuEEL/6Z4NETgxFT90nmiqxhZc/2ROY1RV/JA/zuisCYQZA?=
 =?us-ascii?Q?YrLefY+vW3ZLIZUi2NaPB9ZzGctcYI7DLs2RnpCuAggISpqw7JzSLssia3jl?=
 =?us-ascii?Q?9fDMw+M6+gEEr9f4LomXPxUqP1JXaxISGLcrxz4XEM6o9ez3VCnAh1PI8Od8?=
 =?us-ascii?Q?VM6nlYsYyPb/2u/u6GqlVuI5O5KNApj29l5JR866S+n3RLKOpWv4RzbszAtk?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aRPYkR7DFTXwsiLnxmlAtIvVaudgwd5mssJ3+/e3y2HYea9qPbRWMxfx81OOyFV21gnS9Hj5xIZNm44X3p2tNyoNCgQhF9IKOTkicPFKXXWoo3bAYHdQAPPjIuqX0BYGGhi8+Kof1GW1AIgBbmBjDhJiacSAuFTjOFnHInoCI1T+PS9yLjQDquAl/hluxBsoZ2C10lcZ0r+lJJjs1AuSlXUIVnR6Svzg3MoRg+62A/908/GQGbj/YELAvCH69Ug/SoDOZvi9cm2ovp4DI+JzROBsE2zIpgRWIecEI/yTW0iW44LfBPtJY+PIzfsp0Z70kJuUVtYDhnAs8k0h0hQAzw8NyrizjJdWs40UZlzUrPP+c2BrNvmaP/1s4PC4NEZ8OrtAl/LYofnhSXbvCepT+tya9NoZq4/T9i+tNPtGXTaaPCyyjt0ipLNXGvMCzr1vr2qTeV+9dYX7ixf46fFqXDHVRafZSuyuUQwHp12aDqEnXMHDXmmVORf5d+Q618f8FEzwT9F/WzCr9Cr/amzoPQbIxwzNWqZEv9bPUxTVMB0mTekPG5O1orPnAXlF0c+ooKBfvCsI4pL/yl+KndFQYH3lxpu/EGEoU9INwS+aEyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e85332-2d7a-4dd6-ba71-08dcc91f0f65
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:42.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67CJ6gGBesWQHZi4eM4bWwzo7w/5DzxkVWgWD+R9eA4cSLXzDZ7vJzb7+8icpwqCpljX3IF49a94nzX+BnGgAB/erxxnPRBYaYXaQch0gTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: cr70CN6C1ZWm_TVK8QQJHiPfoy8dZUy4
X-Proofpoint-ORIG-GUID: cr70CN6C1ZWm_TVK8QQJHiPfoy8dZUy4

The purpose of the vmg is to thread merge state through functions and avoid
egregious parameter lists. We expand this to vma_expand(), which is used
for a number of merge cases.

Accordingly, adjust its callers, mmap_region() and relocate_vma_down(), to
use a vmg.

An added purpose of this change is the ability in a future commit to
perform all new VMA range merging using vma_expand().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c               | 15 ++++++++-------
 mm/vma.c                | 39 +++++++++++++++++----------------------
 mm/vma.h                |  5 +----
 tools/testing/vma/vma.c |  3 +--
 4 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3af8459e4e88..2b3006efd3fb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1371,7 +1371,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
-	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
@@ -1424,8 +1423,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Attempt to expand an old mapping */
 	/* Check next */
 	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
-		merge_end = next->vm_end;
-		vma = next;
+		vmg.end = next->vm_end;
+		vma = vmg.vma = next;
 		vmg.pgoff = next->vm_pgoff - pglen;
 		/*
 		 * We set this here so if we will merge with the previous VMA in
@@ -1438,15 +1437,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Check prev */
 	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
-		merge_start = prev->vm_start;
-		vma = prev;
+		vmg.start = prev->vm_start;
+		vma = vmg.vma = prev;
 		vmg.pgoff = prev->vm_pgoff;
 		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
 	if (vma) {
 		/* Actually expand, if possible */
-		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
+		if (!vma_expand(&vmg)) {
 			khugepaged_enter_vma(vma, vm_flags);
 			goto expanded;
 		}
@@ -2320,6 +2319,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	unsigned long new_start = old_start - shift;
 	unsigned long new_end = old_end - shift;
 	VMA_ITERATOR(vmi, mm, new_start);
+	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
 
@@ -2336,7 +2336,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	vmg.vma = vma;
+	if (vma_expand(&vmg))
 		return -ENOMEM;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index 3284bb778c3d..d1033dade70e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -467,30 +467,25 @@ void validate_mm(struct mm_struct *mm)
 /*
  * vma_expand - Expand an existing VMA
  *
- * @vmi: The vma iterator
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
+ * @vmg: Describes a VMA expansion operation.
  *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Will
- * expand over @next if it's different from @vma and @end == @next->vm_end.
- * Checking if the @vma can expand and merge with @next needs to be handled by
- * the caller.
+ * Expand @vma to vmg->start and vmg->end.  Can expand off the start and end.
+ * Will expand over vmg->next if it's different from vmg->vma and vmg->end ==
+ * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
+ * vmg->next needs to be handled by the caller.
  *
  * Returns: 0 on success
  */
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next)
+int vma_expand(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
+	struct vm_area_struct *vma = vmg->vma;
+	struct vm_area_struct *next = vmg->next;
 	struct vma_prepare vp;
 
 	vma_start_write(vma);
-	if (next && (vma != next) && (end == next->vm_end)) {
+	if (next && (vma != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
 		remove_next = true;
@@ -503,21 +498,21 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
-		  next != vma && end > next->vm_start);
+		  next != vma && vmg->end > next->vm_start);
 	/* Only handles expanding */
-	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
 	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmi, start, end);
-	if (vma_iter_prealloc(vmi, vma))
+	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	if (vma_iter_prealloc(vmg->vmi, vma))
 		goto nomem;
 
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, 0);
-	vma_set_range(vma, start, end, pgoff);
-	vma_iter_store(vmi, vma);
+	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
+	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
+	vma_iter_store(vmg->vmi, vma);
 
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 
 nomem:
diff --git a/mm/vma.h b/mm/vma.h
index b1301d2c1c84..c9b49c15f15a 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -128,10 +128,7 @@ void init_vma_prep(struct vma_prepare *vp,
 void vma_complete(struct vma_prepare *vp,
 		  struct vma_iterator *vmi, struct mm_struct *mm);
 
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next);
-
+int vma_expand(struct vma_merge_struct *vmg);
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 7a3f59186464..f6c4706a861f 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -121,8 +121,7 @@ static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
  */
 static int expand_existing(struct vma_merge_struct *vmg)
 {
-	return vma_expand(vmg->vmi, vmg->vma, vmg->start, vmg->end, vmg->pgoff,
-			  vmg->next);
+	return vma_expand(vmg);
 }
 
 /*
-- 
2.46.0


