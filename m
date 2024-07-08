Return-Path: <linux-kernel+bounces-244502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7ED92A51E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F021C20E62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE4140395;
	Mon,  8 Jul 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DkXlHnoi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lsHacwRb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A541E521
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450214; cv=fail; b=pMfy+k8wTSKtJaMrlZ8TjJJ9oEtGCCktFkQ6X53NAs0u9ZArBYOVmk2L7OOexCU7FMBShEN6qkJL56Cai9/XIV/dUFE9N62m6IMv1wQnH1JyxVk79jjGu2F8NeQZxLL/WshPW8vNaH7KvYmVPiheMIho2x5sE8FdNFhpEL5yJoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450214; c=relaxed/simple;
	bh=TootHEAw7dR/zI5ttERNjd7L2IuJdyX6WQtL0bPOPzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdSaE40oXj/Rnzop+0lE5RN0khUjpI1BAYfk4o6WzbvjX/GwmfWZTNxTEcOx8jSKGf6JokO1KGYvAHZde81DXEcZOeUJP9Xb2KO5knyeomhL8lANoHrzcKXsRWiweAEOiaGxG6rQlLPgLC/n7daEXgszxPnaiWk1eSEslxszc44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DkXlHnoi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lsHacwRb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWJA018087;
	Mon, 8 Jul 2024 14:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=jhX0BE5jiGaig+K
	+LPdO6yPXuHbJNWBXx1S0HHb48tM=; b=DkXlHnoiK3c0BThuqYOpAGr3ft7ShWj
	p50wRG6FhJmEdczKVZWQYYjFxid509MN2TIaSbBOHeAi4dH7Sjpl1IJ1AfWXahkW
	YY1vaWNSQI80VSt1AZk0oJe6do4Pd95yKCFuIpw6rrXyIkGuc9CVmDDi8T6wthJn
	aOCXkkNQKd5FFxBqXECTwtT7CRRi5uTXUs01mMO9YU/z/NdoX7dmdKSrTNSTNvDC
	1xz0hWVrRZcrIQws2YxUGrsmrVUC+UJjehl56l1a+L1FcyA7CWvR7w36creVdDRE
	/KgbymFVO5STH9ciWDoP6tOZuFmVS09ZGhSNlPHJizPsWkC5QWuNJdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emst7bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:49:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468DJrM5005052;
	Mon, 8 Jul 2024 14:49:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvc8d6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq5x98VB24vuyNxLcSADXpiPTIQtQJCEL2J07uB5P5l4JPgfOHMWC0IPD2g711CQkfWoCPKSf+mBDe1g6U/jwaOkswS/wSxRtUvmZXz5vWrbnoFf6A+W9IiFJAWyW6P1+3UdbyEsnzGDKkfCXeNPEeAb8vApuIKUSQGvL+DOxQAAoF6NK/BKjgMSjJL38ZvmB+Ekt2blOI2bG51Gfm2ni2Se95WL1ZuXU9rUn578D0KQxtCj9MCuu/uwMlaXZzBqWltcWanDLxEY1KtvJ8xg8ajmtZJuvjYEoKrdmSpJA0hmkVmN0XWKzpEFPkVkpxQny4HyZc3+dEOoFfcnbGHLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhX0BE5jiGaig+K+LPdO6yPXuHbJNWBXx1S0HHb48tM=;
 b=K5lYxziBNB1QRc7/CsJAJAPIlWKJhG9Neidv1a+u6vG7JpKSMIGKrhVL7wAEWQD0ybgqhhxL9JbB+d766gLmvQMvGVurkGjL+waMqhJeQ+jOv3efiX55HyGi2rt5C4jKStc8MCwavqefSgUuOU+o3tO5nix4cFLGbmXsy7XPvQNEwY2KzaZnCRVT8aabVPxvcfMWdHSQ1iwKWY4+yaLlP06On5LfqRQj6jJ3g8B7PNzhMOPCp9WCyVJWxDzsqZJZvLfiyNGjeaB3E0jYgXNGFHGm8VoGIRlHnL5Uj6WSbx/b45ClKCEVCj21kkVPXz0sxg+/xXIAQoHifEAvy+i9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhX0BE5jiGaig+K+LPdO6yPXuHbJNWBXx1S0HHb48tM=;
 b=lsHacwRbKU6VZ/1/czTSkXsbYX8e9Jge07z66amxnNjsZqvlvU00vfe4alDamg+cGb3bgL/mveHMgbH5AEbrCHUj/Q3bxDdbIuiqKh2SXXeWwrI+tkHiu2EtAn6vM4AafdOmWiYL/VI8t/tw5xcvT2MPP01XX6Uy4GLa3XCV3eM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV3PR10MB7745.namprd10.prod.outlook.com (2603:10b6:408:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:49:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:49:45 +0000
Date: Mon, 8 Jul 2024 10:49:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 09/16] mm/mmap: Expand mmap_region() munmap call
Message-ID: <vbrnpobomijmzvkhfwupt6oydnb3bmjbrcpf5ctoavuk4lrdyh@d6x5jk2wtxif>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-10-Liam.Howlett@oracle.com>
 <b283fae7-fe72-4bdf-a7d9-7508c3f93293@lucifer.local>
 <pnnhq7ok3uhm7a3va2gdnpjvywziqvicxrzp64a5dhfbmydjv3@x52pq3vq7zdv>
 <b18c9a27-9bb8-41ec-8808-9a146d162202@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18c9a27-9bb8-41ec-8808-9a146d162202@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0197.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV3PR10MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc46087-d359-4483-00ca-08dc9f5d3510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UUEKw1+8BIc1q6v8wd01p32EmaaOHMJphc9Tp7miM0AL5ye/hW7gASZUTCpa?=
 =?us-ascii?Q?+b7aQZLTiDZQDAfPZGaSN5XfvuJaZTOunIO5ugt5Y0ZfWnGr8kefsSlrhcon?=
 =?us-ascii?Q?bf0tyL7VrFlhtqn+RgvIQRCGb6GcfGz4i3Mqw/1hych9buUDJ9HPyhb9Si8I?=
 =?us-ascii?Q?HyWH6oH5ZVWtq0BgbpfRgpM2geMCBC17FicgslQvMQdkm/BRuejd19AdwosI?=
 =?us-ascii?Q?aUgB9V96kx+gywAbT0PjK89uQ1/QCWa1BFqhYNQrxU6RxKTktMkv5XTSLyQc?=
 =?us-ascii?Q?9YgQW7rXU9Fk15v7WSnsRFWTNqYegA8DFaFJ+ftdoV/Qf/os6ZRqLoRmZT1f?=
 =?us-ascii?Q?NYIkdYlDHf4FrixdsutDsW+azH/rPpptCMcWWbxQka0A6sBx0hj+r82i6T5E?=
 =?us-ascii?Q?C8DXY83LsIYLukunLWiiYHUW7r4T28saEN6lm7ywW5Bh7vyWICa9Jz5tiBCg?=
 =?us-ascii?Q?GAlzk/JQjknzlhqlpmSx/U3KmIcrYdisB/kK9LcsHSvDdjNxSwz4kYOy6Xqo?=
 =?us-ascii?Q?utHBp36undaTEqHsrA+Luwo5nTey4d3wkRrNhfU55h1RwSCF6yo0EW4LUDnS?=
 =?us-ascii?Q?X3GWmY0ZNRTb/mq2UgFH0FNwcv5yX81mB9nboIspd2qSkXhwAnfEQriWSOnH?=
 =?us-ascii?Q?yJHDhiz94em0cRLhzSMK0eAtdnNpOK49QlDUKZK6KC9ejHAoZcxK7D/w8mok?=
 =?us-ascii?Q?pfJDScUH30MojLRFM1rCK8kFYfpjE+sOyG5uHXEwxakVh6waQHLLvRsQAMct?=
 =?us-ascii?Q?hT02Uvt7q26b3Bbr2Z7bBr60g6O+eMgsDqvQ2ATeDXQhwbhDe35COpc+j8kw?=
 =?us-ascii?Q?XhGIhsGFGk1sUnfMAdFQPqVNtsLLZJ+Yzm3sNivTHfSdShjGt8d7BnI5C8m5?=
 =?us-ascii?Q?w4ahBaM7rPPUOEbW53EocZhW9ztW8cnE9g2biORm0S5fhFRCBco8VtGVgzGv?=
 =?us-ascii?Q?r3+qNK8HrYfdjlHBMaqnn0bme8p8Es93IjyqyHUldvzOxVYxBLNWzOWI1Mnq?=
 =?us-ascii?Q?ZUKB2N1nSAws+ScJ2cc75no2370+Pk/+du9uWPLk+oVxfq4PH/APM/ntmoeR?=
 =?us-ascii?Q?nM7qbFcZQYGqwD/ihSGAEzvRCQcB7p4cD7F6X2xGipCqsHJ49PHBm7jwtQdt?=
 =?us-ascii?Q?V0y44wwU10edXN3QOCMJtl8sqNNt0Fzwn3sPfEjrv3qG5IqySvFh773DRVDw?=
 =?us-ascii?Q?dZ8yT4W4z5RE5HhoKuIeTU8v6gkgJd5F6O8obwQ4CgkLoNuH2bkowIWsg/Y7?=
 =?us-ascii?Q?FzHh8a8RiA9StmBHY4VCToH45OtxWhiJBY8U9C22v1dS6ytlJmnxcBfDw/VU?=
 =?us-ascii?Q?2eJjPUiZ1145YXxsv0Vnvdv1RhPWahlSgyFt+f53JnzWlQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sqvwRjvlvhsv7IMLcJeKr6KDAvkHx34sNXiTLQgibBj90WVvnqiq+YcGgxMK?=
 =?us-ascii?Q?6iqbtjVjFJLqpupo5lV46otaMhL3Dhc+RcDzAjNKeJ+2Q7gWXhA4Yl2BFnnN?=
 =?us-ascii?Q?VAN6uM+P/xIyGB65+mMmRIQgTt2feqj0LUzQOrUXAFCOITRPhr76BhuOMuJy?=
 =?us-ascii?Q?iV1yEtjUCgfdtaRuRLagrAmREgbxwhYU4A0EGrnSG3C9LdNmDd66GYClB4py?=
 =?us-ascii?Q?z21+UwiSFLKvl8oj49H+YYetRtuMkC4f3HIc/0SbfAi+46ZTpsr1IWqQ0urS?=
 =?us-ascii?Q?Bj2dMbmOqy5UpUJg/k5M63v6Ssdw4K1E9zjvf97s5qUXHwm+553kM93xWknk?=
 =?us-ascii?Q?j4ryNgjVvx50HLzYOjNguj+eYZ5RsI/Ols9rPG2SGnFM3L8Z8KqYiqK9QcDR?=
 =?us-ascii?Q?hcz1yvXp6n/WzDt1Z3iHvENXfuyBsXTIEBUrIeuSMCk9QrbhYTGF3Tq8ydkx?=
 =?us-ascii?Q?KkuA0aDSKJUFGBgYAMvGcwU8dvuiaRrodQZAzQwMQIlTYjPuxL+1HnPhZICH?=
 =?us-ascii?Q?0JGo3nvspI987Ak17zwTKysMGZfLNbybxxCAOuVYZHusvbXhak5bH4GTeQg8?=
 =?us-ascii?Q?sspC11Rc04PXJLOAtkh8VFkzsAOloBR3yyGvsccbkfW3tAw7rXHT+Jvf2yPV?=
 =?us-ascii?Q?yHXLGK0JxlSVdLPH0TKugJH5GE4kW5c/D7wDVWlcG+SO7xVGRfZdxNQ4MjDG?=
 =?us-ascii?Q?tgKFqwc2jepmBYRo4cz8jB2NTGucRxJ3oJJYcmxYmCxZNi6xUe+gq5nXCKHN?=
 =?us-ascii?Q?f2uR/KmlSVsl1SznsJWqTzkgriEg/pCcU/cJ1Puz4XlCct6M1hzLYRuECq8y?=
 =?us-ascii?Q?EbaNrkjQgP1NMu07JHrcZ+SkrXNpuag0nXRXZiauf9LamSYj3Al/i8G5cox/?=
 =?us-ascii?Q?DlEUFtB3d6+aLFjTRlQHVEi9hHQ8fn8xFEm986SscgPmJero/9wLv5uv7qbz?=
 =?us-ascii?Q?9trN90pA1WimdJL1eX/YMlIpb797bj2c6O1f5pomv0e8Rg2Z5yfFyAOUpdIq?=
 =?us-ascii?Q?QtdGhzpjD3C7xumv6oA+dsguDmyCi9fB70ZeoPJCs2oltQbGyoyVv76ccQTL?=
 =?us-ascii?Q?dk941G7QqUfcQYnVXLY+avBOUfMUdOlNOwuXoNPRtbwndsSArYwpkCPpVd+q?=
 =?us-ascii?Q?dIxNlQOM+IKDG/1EU096v4edrB6xMUu+PEzomj5TnrvT+ybWviETlo70JxZn?=
 =?us-ascii?Q?BxCEc7BYA2SzXujYsTV5CZzUiDiouF7yuWGY/MkREcF+5+TrXjpnwjNtZjEG?=
 =?us-ascii?Q?xALmqmvJC7Kq+HThiFe/LVOOzW5wGVk6oPi7JJNlTii6bmWoSBM9fN7aEj2Y?=
 =?us-ascii?Q?5ZF2QbEJk5ZWP/EPTJmuzs2YEmLcPPqxLyLHDG9087o0Jbj699AYWepYTe2D?=
 =?us-ascii?Q?Yu99+EfBe8b4GtilkGejKnHtu84h1kBVmYJGlmcouDSEhbxWB+cjVBZA/LEx?=
 =?us-ascii?Q?8DC7g3aDOuXuk0XTkD9jZhny6QYAK5rqQ7B90KqydVZFvVR7IypVp9d2+0PS?=
 =?us-ascii?Q?/N6t3hWqJuftM4jeoe3nFXvQcf0eajTlgIf9YlXXG4Bnkq/iGrHyRuLQHCi/?=
 =?us-ascii?Q?aX7CQEmlZmHweHaVIS7M7OeURTaNkNY/2F3J/hCp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7gWhFtAVhFLzz3TaXn3lw3Mv8+sTbdn+qT2XT9whE67maBNnUhtGYrvPQGlkzu28RFyP8VqJOYKzGl7/sq7Kz9sKNhH/2cXXInXNKhJQc+wTOouezDyQKwZGOZ0HYoToPEGsjRtHMmrLW3gB9nF6kBup4TjPSwfGWXhGjWRpQ/nUIH7o/h7afpOChikgbbJ++7HfSpaATBiMYn467sy9oYBVJsVj/1afyPtUOCJIPCyFWC130M+kg/CIeW+xVbNrf4+bSJpx/cyK6Tieupk9nuC9g859C4fRi2n4ULljbyWRjTly4o5QQeldUVi9435Qu8eFB1wqqANegP2fYvojrROYa+yuNG5rzK0zmoralgzwORp1IwkICRVbQaElbHps8I8KEZct70FjmkRwn7zEV+1SPxiDcjI2ijTb4es9zYcirJRhU3sT5/npXgY3wWE1MugJRdlxl+9Ac0n09wVuVIJvY/5K783nPKcp/kgYEiXtRAEkgLO2rhd7DWUJokkMj7RFL0raVL7o+N8182KAiAp/rEwyxyjmVrhhyPExd4kglhIsttwuP85S1ERp65ZNk1VWbGujenqaOqubkxWvjC0cFcOXfkg4KPNyl3iYIn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc46087-d359-4483-00ca-08dc9f5d3510
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:49:45.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMj2ATwrZrl917XOuyC9ac2jDyhqT9EzX7n0vqr6UOYamhNExppoxv+qB+wwpCM5KMN27oQirpe7TpwxSiVzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080110
X-Proofpoint-GUID: zXW9Baa7dl5oqeirFh6aWxCBd1zA6v76
X-Proofpoint-ORIG-GUID: zXW9Baa7dl5oqeirFh6aWxCBd1zA6v76

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:36]:
> On Fri, Jul 05, 2024 at 04:30:46PM GMT, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:06]:
> > > On Thu, Jul 04, 2024 at 02:27:11PM GMT, Liam R. Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > >
> > > > Open code the do_vmi_align_munmap() call so that it can be broken up
> > > > later in the series.
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > ---
> > > >  mm/mmap.c | 22 +++++++++++++++++++---
> > > >  1 file changed, 19 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index e9858ca8bbd4..f5b33de4e717 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2915,6 +2915,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	struct vm_area_struct *next, *prev, *merge;
> > > >  	pgoff_t pglen = len >> PAGE_SHIFT;
> > > >  	unsigned long charged = 0;
> > > > +	struct vma_munmap_struct vms;
> > > > +	struct ma_state mas_detach;
> > > > +	struct maple_tree mt_detach;
> > > >  	unsigned long end = addr + len;
> > > >  	unsigned long merge_start = addr, merge_end = end;
> > > >  	bool writable_file_mapping = false;
> > > > @@ -2947,9 +2950,24 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	/* Find the first overlapping VMA */
> > > >  	vma = vma_find(&vmi, end);
> > > >  	if (vma) {
> > > > -		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> > > > +		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > > > +		mt_on_stack(mt_detach);
> > > > +		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > >
> > > I'm guessing this is exactly equivalent (or equivalent enough for our purposes
> > > here) to the MA_STATE() call in do_vmi_align_munmap()?
> >
> > Yes, what we are doing is inlining the function call so that it can be
> > split to parts.  So for reviewing, I just made it in-line.
> >
> > >
> > > Checking the two against each other it seems that it is indeed.
> > >
> > > > +		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > > > +		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > > > +			return -ENOMEM;
> > >
> > > In do_vmi_align_munmap() we also invoke vmalidate_mm(), why aren't we doing that
> > > here?
> >
> > I don't see the validate_mm() call in do_vmi_align_munmap, it is called
> > in the vms_complete_munmap_vmas() function  though.
> 
> In do_vmi_align_munmap() you have:
> 
> 	error = vms_gather_munmap_vmas(&vms, &mas_detach);
> 	if (error)
> 		goto gather_failed;
> 
> 	...
> 
> gather_failed:
> 	validate_mm(mm);
> 	return error;
> 
> >
> > >
> > > > +
> > > > +		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > > >  			return -ENOMEM;
> > >
> > > Same here.
> >
> > It would fail here, our count would be wrong.
> 
> Right, but in do_vmi_align_munmap() you have:
> 
> 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
> 	if (error)
> 		goto clear_tree_failed;
> 
> 	...
> 
> clear_tree_failed:
> 	abort_munmap_vmas(&mas_detach);
> gather_failed:
> 	validate_mm(mm);
> 

Right, so I also missed my cleanup in the abort_munmap_vmas() here..
Thanks, I'll fix these.

> 
> >
> > >
> > > > +
> > > > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > > > +		next = vms.next;
> > > > +		prev = vms.prev;
> > > > +		vma_prev(&vmi);
> > >
> > > I'm sure this is correct, but just to double-check - we want to set the VMI to
> > > prev here right?
> >
> > Yes.  In the current function, the vmi points to prev when we are done
> > this dance - so I put it there.
> > >
> > > It might be worth adding a small cmoment saying '/* vmi now points at prev */'
> > > or similar, I've found it can get quite hard to follow where the iterator is at
> > > sometimes.
> >
> > So this is about to change..
> 
> Yeah, I saw :)
> 
> >
> > >
> > > >  		vma = NULL;
> > > > +	} else {
> > > > +		next = vma_next(&vmi);
> > > > +		prev = vma_prev(&vmi);
> > >
> > > But here we move forward to the next VMA and set this to next, then go back to
> > > the _original_ one and this is prev?
> > >
> > > Actually I guess if vma == NULL, next gets you to the next, and prev jumps back
> > > to prev, with nothing between, and so that makes sense.
> >
> > Yes, this is what I'm doing.
> >
> > >
> > >
> > > >  	}
> > > >
> > > >  	/*
> > > > @@ -2962,8 +2980,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  		vm_flags |= VM_ACCOUNT;
> > > >  	}
> > > >
> > > > -	next = vma_next(&vmi);
> > > > -	prev = vma_prev(&vmi);
> > > >  	if (vm_flags & VM_SPECIAL) {
> > > >  		if (prev)
> > > >  			vma_iter_next_range(&vmi);
> > > > --
> > > > 2.43.0
> > > >
> > > >

