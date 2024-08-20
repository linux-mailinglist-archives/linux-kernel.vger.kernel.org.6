Return-Path: <linux-kernel+bounces-294712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445CA959183
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DFB284A25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2C1D1F71;
	Tue, 20 Aug 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FdbP0w1s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q9bD9RSX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0431D1F43
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198321; cv=fail; b=fSbmIV0xF16vxCi1F+LqLNvRZRqlm5rJ49vSjVpoWWnfmAdA/wqTVOf5b5PXYMEq5iQcWmlk+iCs3zsR/l5fS6O0Mqlec+89sjUH0wJa738SjOV30BDFDvv92LtmWaiVWng2ff7erV2jSIXzIY/D+uhuOHmMbvPP2cRS3Zwh2Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198321; c=relaxed/simple;
	bh=fXjZ/pWtmSTH6rGjOcnhcuWBU2dnkeU8CKYlysYxopM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGcvB5CBjUnKaygl5zEVvNKmrDC+Qq9vygyJbFYLHLK4X6/8DqNrmC3XpDu6KiWVbbjyFbdugltbIy4PaqjbPW1CRIqUu3cBibIZaGkJt3SUHYXuY96GQJfvdnRAQhO1kJT+QyS5ZR5YelCpXHqNogCQOvngODxWGDYP6JVeue8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FdbP0w1s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q9bD9RSX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBegr020565;
	Tue, 20 Aug 2024 23:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iJjBw8j0sW6lJf741suOdG87104nAgRAShghgbnodso=; b=
	FdbP0w1s7NgHmipXSIgejy2+kijlnRuiG3DPnkXrfL9itDWv0I5u/xSySKhnvuxh
	ip2Xiy1XgKNogjgineTXG8RvGsyXI4xqIZFHUprrUXI6VuB83Kr4k3i9I39U1ceV
	p83iNHN6fdWz0F4icdYke50zRIU3s3T+SuQkhH/6GYYFCHxfqgAKhx5xK0/R3RjL
	rTMjlPq3cvA3a4u8R49kyywl3xOovSoOpOA1x3IVM6CN6bi4BlLAvizh3EH3y8bB
	1bZuqkWp78cJwtFRd0uMvbWV1rgr/BlwZptZux6ZVBSyM8Pi3iNTsey7y8IDIT4F
	F9ev6lJrw3mgZ/lcxwSgGA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6ged2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNJP2r024574;
	Tue, 20 Aug 2024 23:58:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154qdgtc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/XO1AmoD1sI4ruT6bx6yU5kKLLYN2jEh7GhTwpV0859zUpFvR/1fikRqKn1xkPhlzJSk/vrktomzQiKMDJj9Hxn9T5N0pxCb48Qgp/I+VZevCma6eaiuLk/Imhvw2eu4QKtSuXCzSR8cXvRsA6TT+8oC/rtO1+FYbIhjhUB/ehkquT3mjVHRvCyCVHVqeZ6cxPaEWR6GD6+YEh65z8/o0R4Hc7UFevztB2OK2a9gXzq4f036ekr8X36wWU9B51km8CWWo7NK6JJkqPeYC8pP2xXyzv8jO9V0ZS5f2/CwOAoaYuAh3lGLTObRN4jSHUYDU+jcTxZNqA1c+TGJZjZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJjBw8j0sW6lJf741suOdG87104nAgRAShghgbnodso=;
 b=OXGiYEWuxqiLlT98C7MsyDDhjrxjynsBimMxb3qLkOe8auduD5D70I45v3RsgwdH+F3kpzRuVTu8jXzs5g2YLN6AK2j12Im85pQ1Y35jaJIwYl50dJCWzd4UN+Xyy4b6S8xkv+XGZ/QeqzEtTlwAzLHvOryNeG/5EnhrAuUMm5nkks38SE/TxKYs1G6nMwvXGUmfjLhbOSwCG6yNdkgDjp1vg1ZN3H2ke20mg+naiPhvejoz/tto24MlBag52wQB0iYYNJa09Ng9VzDaqV/k4VrGIT40S0G33BDmoe6VyukWJuqFUPtuuzF0bFA8rMwKJkSIwqUbXh+dlZ88B9lTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJjBw8j0sW6lJf741suOdG87104nAgRAShghgbnodso=;
 b=Q9bD9RSXssMHIw+zysZVeL4kgOft0rI1az5UHismi5plegeH8MCSJpmvqxkGLxR4bohXF/7v7FPZe3d2sT8AgYYE3fDXcHU043Yyc4MH1DMvtzyiB9F0HKEJTK4qyOJ9Rwbs7ph5h0tbQElU6MlpUYAo/wAQHYX1DEVH0nt3kUs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5053.namprd10.prod.outlook.com (2603:10b6:5:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Tue, 20 Aug
 2024 23:58:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:24 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 20/20] mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()
Date: Tue, 20 Aug 2024 19:57:29 -0400
Message-ID: <20240820235730.2852400-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0404.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d3ef11-70ec-4be0-2605-08dcc173fa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yK/2bZUkEsXqN2k4RIj/7rx3+zdI9UJhpP3m+asJNy86XqKaBTNxAEavWdBX?=
 =?us-ascii?Q?kXNvDHeLJJJNh+QwE3CH4qMvZrjrexQhKl6vMa3t6JUIFes+tR+M9i+iKmHJ?=
 =?us-ascii?Q?FRdG1RbS0ZSlOrWwcwzz0lInO2+DvQ3/VQrO6L+szvvM1xv2X0qLCvHHNmU7?=
 =?us-ascii?Q?oE6tOBtrQ+NpZK+5z23Xadgdzu10LZs0lXReCSHqwJEOXPFiHTBgFt05NOnd?=
 =?us-ascii?Q?F0viQQFQCpqNjRcdjq7aNjyQW6RKGGLn/xaJ4qORA/UL2JlS495S/pd+rYK9?=
 =?us-ascii?Q?YY+4XOtr8Fza7FXIh1hAZZrOUhfH5jv/spvR+YUCZxb1uIGcvEfN9IAHygUQ?=
 =?us-ascii?Q?IpLsDAFAy2nhiJRZ2gj2RQsnsON2dFQxaCLFn34gMCKyyHKBLQQVNAMBuE/F?=
 =?us-ascii?Q?sDR0lDyrMkSNzD8ctMS0LylkVzQAFqaoe2A0Kq/SvhlG/l4Gavv4BGGazVNj?=
 =?us-ascii?Q?2gUM+6zaFcvZl5nM78wZBpHGrL3LT/h8r0/lQWAAv0yPQWOU696lgxV4TZUR?=
 =?us-ascii?Q?l1/FgWOLoM7z7fkXM9odGg/yf/7RsDHX8G4NDuLrmoAnMWKQwpvb5eNJmc8l?=
 =?us-ascii?Q?XPjXvb4yVbrQIjETj1UtQZ88GwsXcpv4h6riRkZ0dzquIIz/YHaEnfuz6M0S?=
 =?us-ascii?Q?YGz1/N/RsJcU3zcZ45Peku+g8h68/K06rn2KkKNuzzHT6GIZThAqiDauXAdT?=
 =?us-ascii?Q?PGY2x9pyFB5iwSjR6mIh9xwGCy6xgkPRw9wZzYZAjdjMWsweUha9jeXE9T7T?=
 =?us-ascii?Q?V9EwacEU9XzlxYqXmit2iunWmi2lwLTf5irRGG+D7ScXvwUV1ZGzafa2go10?=
 =?us-ascii?Q?UNS0lpvwCOTjhNLz7a2pzhX2AdEUcrufQYfxxAI9YM+7JOs//7v22KSNwJ7u?=
 =?us-ascii?Q?Ov7u//UGfA8qHJxUTztCiCxMbh44qQ/bUPv+UocsWVmYcZF2ejVjzkiIR0iU?=
 =?us-ascii?Q?isop+SSXuo+w2bJf24mHXQ6+wxyZiyrLwC1jM6/93EVdSAp7EHXjJyHgqeVn?=
 =?us-ascii?Q?3uAH8RH+jkXAVrvoRjzJPk314ZYLvJFyshEGn/6AG8CaTIrWRZojYpVelrpF?=
 =?us-ascii?Q?22Mll4jf0VdXAAqNexHavamqk+4/1tEs2BUHd0zczcjMYdDMT8k85Mgp+usW?=
 =?us-ascii?Q?FIMNA5P92zRZiyWxnBzJpYM0sn2/eXJ0WW4oKObvO6ED7rCGQjfOPadk6k1y?=
 =?us-ascii?Q?zrXNc8DDcfXj/DhMzdQW5b/eu7VLGAVzx3Vvjt7wwNga9LT9CxLMfCz3ghjr?=
 =?us-ascii?Q?v2zfdV0839EungO0DHbtZw9tl9lqmciZaIWsOq+A31pdmeYukdIQInggiP/a?=
 =?us-ascii?Q?amkTl2COjjH2bm3sMhys1DCjXjsU2OndRX+bc/OjmnPqCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z84Pliy0AVRBi2cqHEncXz4HtIVydwfNUUeEFoFksnua2RVkzHPomDbDRacV?=
 =?us-ascii?Q?CaG859oQhZEFBSU47YO4rIkK8YUchxyVliOkqXUFjr+/JlBahM/KMhWT6K4I?=
 =?us-ascii?Q?OfEJfVEQ+SWNrfQV32EcTDkw0GfOjzSYtpqqmQm2Ne9pOxNlcXYv8jnvNXfM?=
 =?us-ascii?Q?Kbe9iOopca0Ri+s0m/v/OuxfsRyMUKtrBYO/IG6JpYacDcyJHnQ80fSiXPcy?=
 =?us-ascii?Q?hov/B88JMcpLoVl9sBqZ9GGvogu++6aI7QP2NPzRhND2Np9GpixPPWfVIyrM?=
 =?us-ascii?Q?p1oy78nAtNvFxShZVJe+zUYjYJvNZc5djCQAF7uZEGYupwtCn0Hu60Kmw3uP?=
 =?us-ascii?Q?JKCyhB8raxnhP7HUYpdYg42KM8wMWtZ8/Ys7EP/0Kcykb9LetqcGwO9pnHnn?=
 =?us-ascii?Q?WiSCmyrD17zzvFLvSOPSRsTBhTCjR2sdNcffrkBxjZqKSEOQltna5x+NBg2e?=
 =?us-ascii?Q?TQI5G42B0xMIqXj6mekdDQroCIJ8GZ7zoS6P2SmsVYBcdGshtIFepEHoz0NT?=
 =?us-ascii?Q?17mt0Xut9U7XJVMifgkd90j4hOENs5VQPT4haKyeQiu6Ns7Db0eaiHXE9s9o?=
 =?us-ascii?Q?CEZfpNe/tw6VLrqs1Bp2xg+WF7FfoNW+LHYEksyTJWra46E+oDKD1RvA+/AG?=
 =?us-ascii?Q?hWiiA6rOHDnJ2QutUqCMxwIdE37IU1+y3pSkclNCeaPpzhtjSZYjgTgK1/lA?=
 =?us-ascii?Q?M3Ts+KzVBgV6Ey1vuYHOqEinur1KuafrTfosA5sU5sRWzAdH6Hj7Ljf9ZyYH?=
 =?us-ascii?Q?eLTxFB4eMh9Cb9tKiW7ip8JzhnhU8eMmo7hHZm8u/Yaoi5frDBNMvHEf8nwc?=
 =?us-ascii?Q?2C5eQISwmDO7rcvjLoh+b0pbn1SfKt/FvIgJDfdcgF8WchOjDlYnKmCfDE/A?=
 =?us-ascii?Q?tN8Cb4t1ItQsbNCXOvJd6iBPNnmk4ukOWdE35fscOLM3eYWs9qVPXWpodY/8?=
 =?us-ascii?Q?bWRoVguTw/emIhburLBLlwSYYR+wD4GzAC0IlJ+FnPreet1rnB2aXJC+rO9l?=
 =?us-ascii?Q?yhnXERyRmZPR3FpXhSmXvK1OpaVipiw18Yc6jvULlznlhmOkP4SOGO+9byIv?=
 =?us-ascii?Q?Jwx5ObNun8xxV1cILYNbprqXP22g/3P+KG8KKbuD7tS8d/i82VQ4qJWv5yO3?=
 =?us-ascii?Q?tWzATq2/lCa93ZWYR0dr9k07uh30YfsF/b0eLs0U6YMZ/5RhivXKJ5TfvvTO?=
 =?us-ascii?Q?i5gKC45YSdbsZjUwSi7H5RT98bjSRPqAM+Q20Rc6rHk1Nc6wkQqwIhLE7Ca3?=
 =?us-ascii?Q?vfvRWjQI/lB/9d8B+aIs1xXHIWCugoscpFH4JRY5l0RBt/NCNMFOecDk4jcl?=
 =?us-ascii?Q?E34+9ehOkEavFqoQjPudwyJ5aEYDb8OiItAY2fbju3+GpQvN/ypByFJeRBze?=
 =?us-ascii?Q?volycvzmxtQJ3ICejo3UTgLwglWkE6uDXjlgXnBjTu7Ys1zJRFOFTHaTCMpL?=
 =?us-ascii?Q?0/YJc7xcaC737jEOkyO4rLzoiqwZnzLxIAwcUjZ4CoziYABP+hjCwmmNXZ0U?=
 =?us-ascii?Q?JjS4GW0l09VBqINS3KsqX+CHKqhmn++tXk9uBx9sHqIP5DCDUEdM+V+J6kvr?=
 =?us-ascii?Q?wXjnQWxet9qUfmb9+WyAq1TryLhb/ZhCDP36gccJ0tnpxiDclHOUo+ZyjHPA?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etezmWG/3+uK48/B6eUOYKjOvQ6Y22e4d26iDQ83DApTQR3dTm1hrPSsmlGu4uwa/wsGr6d06ldQlV6g1Ltm3MURBjYIS54IK6wmP6fFiY66fOBqKcpPgWGe0SxS5ts8AwkBQicputMBOaawReur6nbiKcMVFL04oIRiBlVb06N3geSMjrcmKNDP8VF2Nj5u1TO/EUip0wp23wJhDv0jUkgeAwkTNhN7zvDiTYVSoJOxDGmXUa0XVz3wYSNte9uMiCbJbu48VmIdn9YFlqU4MyL4zLxpQurkcI2XJ3ucwz3haVjIQSKoDpXRaGSt7666E406CwgmL9hTVwFk7OyoXQ7dpHiLSkFkOLqUPq/f9BI034nooUe/jD8LcWYsdj0kp7oA/NyHgOZhzgkuSPiDYkWvXixbdmthEFWfIJliPloQsfCiWrZbXhuwwbFcyldEmIQ1MWXWIyF/dVkx2SaDr9e/UbI0cHXdBZWvthhyI7HiPZPABQRRQbDYtSyBx1tln7efSXibNsPS+/QoMglFi425dcZIySeM9+dsIhVgsfhW+2QT/tO/b18AVHBXaroHojxsnaAP6iU5VJnfvQK4tEp++gAbu7kFQ4DnGko+jaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d3ef11-70ec-4be0-2605-08dcc173fa02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:24.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GzIeVWKMlfxIO4RBvPQoA4nfOaAuw5izPpLF5y6yic+N9P34jjKzpcwsSfX1Ojrl7BErq0meQYUTdJBwL8Wzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: 6KvRuAjfHFK0uZofFfzJPmdMpM_q-lAl
X-Proofpoint-GUID: 6KvRuAjfHFK0uZofFfzJPmdMpM_q-lAl

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The comment has been outdated since 6b73cff239e52 ("mm: change munmap
splitting order and move_vma()").  The move_vma() was altered to fix the
fragile state of the accounting since then.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index f277ab1b0175..dd064b0abe17 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -750,13 +750,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-	 *
-	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
-	 * unmapped vm_area_struct will remain in use: so lower split_vma
-	 * places tmp vma above, and higher split_vma places tmp vma below.
+	 * Does it split the first one?
 	 */
-
-	/* Does it split the first one? */
 	if (vms->start > vms->vma->vm_start) {
 
 		/*
-- 
2.43.0


