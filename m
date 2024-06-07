Return-Path: <linux-kernel+bounces-206711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACCC900CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE74283EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D186C155312;
	Fri,  7 Jun 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LHEeGxj0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WKJ/mTYt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B51552FE;
	Fri,  7 Jun 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792243; cv=fail; b=NXK0Go2AgeAbS5xEbTCjN6Pc6yyGflqftz1JA9NDM8+Z0JFKGM+llFRZJULfOcc9644P8hfg85XbtP50R9uQaOu1LBahqeg3yS6eaFBQR0kUm0VMFIei+A/GALOPt6ktuQyYURlZLnDcXL77Re+pdYGP43s0w6Q/WaD9y1D/6+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792243; c=relaxed/simple;
	bh=s5vwL0gIyqStJgJdeYn0Ll0U3tjtmKTGJFNT85ckHs8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pq0C412JviapBnvZq0mM5DOHjKpIXYoPCqF2ukOBw+qwZtjUDeJZ2IHX58RPpgTG3gAbGa+fnEI4TJuwQ+EKmgGQeYXpSCjDDrxTjMLNZXAA5BSWjGNl+h9H2JK3OPgOPgiz1/OrS1N1zNwm+A2NxUvDiVw4Mm4hoqgSjIPlAvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LHEeGxj0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WKJ/mTYt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cuc0Q020071;
	Fri, 7 Jun 2024 20:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=pbyrtduys5jlGj7QioDhK1ww5y69hPgjfX1hvgHBIO8=;
 b=LHEeGxj0CnEVshJ2xMvdb8VNrR65Uv2o8Y/pPPG3LPL3ekilcYrSok/HV98xSPXyDOJq
 biqiQCa1fOFtrS28ryt9lv2fsM6Nm33xe1Rg3Oghcmznq4k58g+qT8kj8UTiHVjdmnKe
 tP8+7TRTmW1+UGeqm6f5su6fPnKcNzL6hynvvBHdMqAE/CLVB++X/OffVVAiLjt49iTA
 uFavyi+Bc6nuWv+f+wgepVVWyJMly8tRy4B99xRVuAR2M4uRBdb3lp1GOZL2i0r5SnWO
 VOB8Q4m1U5deCIdLkZHV8LoUUSX13ianswOvJpmwWY/55eqN2+d0WhR8oK/Do3FSb3bH bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsyedwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 20:29:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457J0kRW016146;
	Fri, 7 Jun 2024 20:29:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsexgjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 20:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgeWYIA1ulJcdLxf2E4fBhZbgEYWL7NlwM8rdpbi5ECoeEPjGOJsbspeO1FLUOBVFMR0vFsh4tNHaQQ+2+kJL5UK7veqvADNLMkG5Y+OpQoA/PZeTJW3N7EzsIwUd/jw4L5RWFN4O7KpFcIZaDvljbN7IwYhi4760pzAfNR6dyZZBqQyxa9d0xv4T6qrDh6Q2wZDwXlqKs6IU1VPYT9FeNdPNQyPX0pWbWdo/krtR94HxyBRnxC3jpwNEzckRbOr4ypS4iVEl8bROlsnx/6m1kYCqHcINbhplF3obW4ydo6344wOFV6tLg4LKMOFO0b6lAF7V3cxfErFIhFqXMuvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbyrtduys5jlGj7QioDhK1ww5y69hPgjfX1hvgHBIO8=;
 b=b7LYbAM30vse7Luz9uvEt0a11yvAbOKl1O0aiI1WN9WjbEb9bXDZtKDLpF9bM3Ds2/XKc0kDoPQFk46oFUE8RKunhI0x3Tivm9YM/cV2Wry0x+o9nGRyqJ8dUp0d6HQu32dUXQY5338IaopC47eJntRXTiwxZ5ZtibjnMBb1enxhj9DtyVbRCvCQK9/HkAuKHvmIHDEWfA8d3YzUPTOReMK8OWZ53pAsTcVVExGvKZhr7Hv1K7YXIlXo/kAGT6SWQkPP3kX7E4lxMueT80ej6wak13M054lEoCky3KIsQp5kQRW8DNeiCY/okNbSOcdYLx4ErZZpLGPRIUPp4FW/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbyrtduys5jlGj7QioDhK1ww5y69hPgjfX1hvgHBIO8=;
 b=WKJ/mTYtYlopAbdDNtlvz8W26Z4p1ob6z7yp4GcQ4beWPAl8s3rclkOAxVKGclJF/uxs3H+UkJ7r8nYZyMYgsRLwCBeuDLDQkO+BGHe/sU+wQJSEdYI30EU5rKMuxGObNlB3ZUzIwRt7Id13VYcxgiqP8rBOlWYzW8KfnvbA1N8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS7PR10MB7251.namprd10.prod.outlook.com (2603:10b6:8:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 20:29:56 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 20:29:56 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hao Ge <gehao@kylinos.cn>, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm: convert page type macros to enum
Date: Fri,  7 Jun 2024 13:29:53 -0700
Message-ID: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:208:178::32) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS7PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b20a55d-360e-45f6-89bf-08dc87309857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UKb6fXqgaJXlYvW9PwAtkPIxrkRpGJ0ejFf2HEApoiwvvkhTlMqF4o5FqvuV?=
 =?us-ascii?Q?uDulWJZEm9fCgTWB37m8IOJXBb8Ml8IBN4NlBCoYa++Ox/wkxk5HbWFyBnOM?=
 =?us-ascii?Q?pffjoNWorc7JQAU0hesJrXXOxLGAfMmNUPlO535t0nXh4QlsFBYQ3BznuRaQ?=
 =?us-ascii?Q?lozlkLEVUOyVRRWK/fDtDd5NTZCP8rTch6As856i46m75TBGlqbBUDyFAC4f?=
 =?us-ascii?Q?p2JvJ+GpNzpI6xP3Fn30SNEyPvTJIET8XGHAEOqzjqzojIlYgNM0d+HncxKq?=
 =?us-ascii?Q?RjHct7gDQPWz8PknlPKSajKNZ3Bv2ma6b9aTZs5SslFhe6CCqoqNcFEjwm0e?=
 =?us-ascii?Q?UaQXZUdZqRtM+acONmpo2Kq412EYexDN85nyt/Htiqqu8nIALtM3E30RXZYv?=
 =?us-ascii?Q?IU7chTdgPHxCIOt/G3UO8xau5f6A8I50Z36YYais4M2ZkyH1GuDeFfNj8+mh?=
 =?us-ascii?Q?2SMzgB6tKvZxNoeG6NhSIUYjyWVA1+bZxKgkvhlBGtVzYybY+5aZ+5A+nvV+?=
 =?us-ascii?Q?fLWIfsAu2II/9ZyFgIGFZV6rc4rgMiuBoGkTs4nGx+fm784AaT+TFspZSeZ9?=
 =?us-ascii?Q?qAk822k7yoYy5VIFjKxq2gnRx/RpCwmgEbynAvp8aMbrW/parOzHLxz18qfc?=
 =?us-ascii?Q?wJRXOq48HFPR4hIdMREEIFLqP2s4OGYTwXIA7O4yAKlOCzvimWEaCEu4MbE8?=
 =?us-ascii?Q?vocHHeK+BZd+fBUlbAMPvbFmEZeEfp6jZDwz0ckX6i55ksGFi29dGa87VxHt?=
 =?us-ascii?Q?TzlMO0NMN0jtx+znTPa4u3JIj1AFKhaXP5HQPjQqaPm/3g3eLqhAnBnEvz8s?=
 =?us-ascii?Q?Uv3GOv/uUEdbh1l3uqwTZPVSTOzh/ZkpL+2N5peRrxUwvpYjBQuJxOtkxhCV?=
 =?us-ascii?Q?7/KFc+yCw3qO1BiXVpocoJu3+htVa3QgeETJwPgzV4aAuJKb6cNfoAPLtGLm?=
 =?us-ascii?Q?2Q8EBHe/GtR7JyPpKB/VlGz/KAo3uAP0DILaGdop41dKHaRmcWYnmYiKB9jI?=
 =?us-ascii?Q?pJKolGVWGy3ZkFW8Rhur+rlScBKzeInvhmbDBdTabAYqV3uJVY1mkR2a+iIA?=
 =?us-ascii?Q?bTzM62Yw9H5KWEKV8BNc+qptSPkr5VfzH46x7hi7quncE5tqQng89AE8pw3l?=
 =?us-ascii?Q?OC9mCDlrC1t7cwtnfcaV1POq+H0KGVDlk2qrg3vNPqm58p3XqoeVU5/ppXs4?=
 =?us-ascii?Q?m7lt+iH/f99muVtA2zF/lECU1cwTfedh3VYgTwXlL7t+b1JgLzaExRHHwO4I?=
 =?us-ascii?Q?6d6ygRCPnDgBy3bXbir3vgj5lV/azUPFwnpvAsYd34RwWeSEA62DEtccSENL?=
 =?us-ascii?Q?QGzE+QaXcn6udFFD6n2bdnrh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YlN4k2MehHKBY/DDLpq/nCmKzeu1+acaMrgpAiwBllcAC2ScxSHDDZOpOiRw?=
 =?us-ascii?Q?Y96CdQMQRdEdckKGY+gm4WXuPoGkHmZpqaOzM9AcGUO1xBI9gBMiw03mrzfQ?=
 =?us-ascii?Q?ftqzYVHCOvMm5Io1CJKUjFloXrX4Zh/f89tVdCHEm82naA4NSQ3SHbX8yAne?=
 =?us-ascii?Q?BY9npUR+eWpMyoHXNmXReZsL5smpv7KUqtL2TuRNEdH2vPDrWRdBM/LF/TRf?=
 =?us-ascii?Q?8ixAj0UVTRcRj4e24nO6MKX/WjtlJvZzniB36n+3QhbW3Kemc1PCNYoscvtv?=
 =?us-ascii?Q?K/MUSEMva6vZZvnbJpL9IG6a0haU1+rXjwrehCQuKjsVWIbYq4EKpIqbRodo?=
 =?us-ascii?Q?y7P/0oveRWx2/jlVyF5AXa45F3zYtXB45vOBG8pJAGnWQqMGF65Nr+xcpWMa?=
 =?us-ascii?Q?DKX8O5IzSRUGLsF3+FXDdi+SE8G9s5u1Md3J4VzZ9D+IsAYETKbnNerv0Tlj?=
 =?us-ascii?Q?Wf3tr/wrvZtjvvy4X27a7kbK87ys6XqurX5UD0/bQYlBZM38nf0lHJrf26X9?=
 =?us-ascii?Q?ZwrDYL7gFwtNqAaaw5+gB2fL3O2NRhT1pYRT+icNDnIQmnguT0W102AqClWR?=
 =?us-ascii?Q?7STpxXSi6ASbXVCDAA/hooyQwDhf1ubtIwIeP+xeA+nzOx8Yw4Z1T/6JjZUp?=
 =?us-ascii?Q?9EySPeEhkPHuHjRWcF2kcQUgFPPt9RoqqtiUQRMexqXRrPAwB5rvV4HFNI+1?=
 =?us-ascii?Q?CI0xW2SM0psuOGAhLRK/6vIwPQJMdLvCS9LlZLEIEmez+L7HdC+AnbesA80X?=
 =?us-ascii?Q?xE1wLDNm3o8DUT0DTA3DASEebk4+WDNI4OZOpLbSZQnQASX51qsQpqCK372T?=
 =?us-ascii?Q?U1E2emmvEAOAMhhG28uhG5X7dSiTtutbgmvoy2Pauy5Thnvsq5corIhCGBSZ?=
 =?us-ascii?Q?r7DFVcqdxWBkbIn3MJjCwtv2zKmtIMtmAzx7JUsinsJdc/wtVXf2wZYTQPag?=
 =?us-ascii?Q?I3VETrulZ3TS8E/MzzInW42kkseSi6eC1Ycpe/i9qUn0M1A3Rcby28AccM/f?=
 =?us-ascii?Q?Smnr00+DFioTD3tyDY4d6K2s1R8STWDidV1obGT1wsSk/FRSUzk53NsNL2n+?=
 =?us-ascii?Q?jgZA4zZ44eT/OGSRNS/2Z0FF/CBfdtN++0lWLS4jBGor5GMtNrGZBTEPKwTJ?=
 =?us-ascii?Q?eThKKLb7d1bhFezImlX2GIUtMNvI1X9lFRT++TFeltvgCl4fh/Nn1imh0w1t?=
 =?us-ascii?Q?f8iCu5Uco/Hljp0Cnhq/hspb+X+iXjshlHtSPRd9IfMcLHT78vtvzt4hKidC?=
 =?us-ascii?Q?oLC44TdurBK7UCwZEL0CayWJ+rtnabQ7G/Rcc0n+Wu5/ENBzbCWlmrp0fRts?=
 =?us-ascii?Q?XZc7HJxekPw0epSGT3SPL87BvkB0ag/zz1huEFbSrTs3zogt/S/ydEh2Aw77?=
 =?us-ascii?Q?eoUDQT+xM9WtioOHabA7Rs9NU0Vfk+rs5n4pIDGXpFJjmUCpi17m/o6WzO/k?=
 =?us-ascii?Q?D0n7T+fKa5xkTzbvp5KGB9pHDmg4BnefKTbNu85yACsIhFStHzyFiCTXo5ZT?=
 =?us-ascii?Q?/gPi9T1a6qfmIHy7bagKCg+LhWLRQa+ETxRkk0XwYssDEF72m8adWXoKEkvg?=
 =?us-ascii?Q?zRxbtRBTr4nYbRw95lP08ss21H0tvmZqzIU1mcg/XXUBlPRXjbYmDZuym6Xa?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1HwiAKX1f5/J2ZedtfJeGQZfDm25X3XJGjeQshpueyAYqTFozJS/zPqg9mxikcPdBp1y4GHxpcAkqihr9ZzMKvfTHV69p2Hp3nR7gEB2DCOfY0h/xBkvpZ1XPX/J5fS3SDoDa1m5SOPd39LO6kbVLDpU5iPbvSqh2QNDRSyukNJ27014H5XVEbFs7yFh66DdXqYSFjKZWUr+g5AgBYPtPmKCK05aimwGAzPjVuz+S7ZxzYXYMfwhn0Tp7rDrEFSZfaESvz1ddrPp1w+fPnwcYUfKt39ArRx+Ak0dsyh2aLM7LfWP5vt09LfM0QkNC3HydY/mRneMhU/DJOIaB/LH+9X0lkGr3cUNIs+HxmWabqbc4n6wlLGug3uhGvs7nvutwj1IVV/WBOFTMXyN2LsmljZiq+VbLzA8yiRbWB/hBiDZ3Pegx54eR0uTykUBP0llMPFb/Zhp6kCNwNq0ZGRcn4OjwbKTE3rZ7d4IvskZiUhzHlZFIRXeZIpt13SDCwMvphsvUDQWnCQhbmZJRjgHdlggam26LRyXk9CP+Rjq7qv7VQhaA6WpF9v9HJLuRXq3wxzD6V4yCGiWHv3rXjqtL+f2ri++IYXVxyWx1X1kryo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20a55d-360e-45f6-89bf-08dc87309857
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 20:29:56.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsbekK4rUI4Y3U7feC2TFqqnaEGoOq7+wCJ4Z4gMUcUhYa1TD8lAe0BblVfJDgEu7C9yJMwMc/SQWBkkn9O9+nvuUtn+9pccPMFLam9+5lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_12,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070151
X-Proofpoint-GUID: b8kITbBsEjvOOPsz0VKdrrl5Cjc1PjRL
X-Proofpoint-ORIG-GUID: b8kITbBsEjvOOPsz0VKdrrl5Cjc1PjRL

Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
("mm: free up PG_slab") in has the unintended consequence of removing
the PG_slab constant from kernel debuginfo. The commit does add the
value to the vmcoreinfo note, which allows debuggers to find the value
without hardcoding it. However it's most flexible to continue
representing the constant with an enum. To that end, convert the page
type fields into an enum. Debuggers will now be able to detect that
PG_slab's type has changed from enum pageflags to enum pagetype.

Fixes: 46df8e73a4a3 ("mm: free up PG_slab")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
v3 -> v4: rename to enum pagetype, avoiding conflict in f2fs.h and matching
          the name of enum pageflags
v2 -> v3: rebase on mm-unstable
v1 -> v2: include PAGE_TYPE_BASE and PAGE_MAPCOUNT_RESERVE

 include/linux/page-flags.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f04fea86324d9..32722c6e8397b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -945,20 +945,23 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  * mistaken for a page type value.
  */
 
-#define PAGE_TYPE_BASE	0x80000000
-/*
- * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
- * allow owners that set a type to reuse the lower 16 bit for their own
- * purposes.
- */
-#define PG_buddy	0x40000000
-#define PG_offline	0x20000000
-#define PG_table	0x10000000
-#define PG_guard	0x08000000
-#define PG_hugetlb	0x04000000
-#define PG_slab		0x02000000
-#define PG_zsmalloc	0x01000000
-#define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
+enum pagetype {
+	/*
+	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
+	 * allow owners that set a type to reuse the lower 16 bit for their own
+	 * purposes.
+	 */
+	PG_buddy	= 0x40000000,
+	PG_offline	= 0x20000000,
+	PG_table	= 0x10000000,
+	PG_guard	= 0x08000000,
+	PG_hugetlb	= 0x04000000,
+	PG_slab		= 0x02000000,
+	PG_zsmalloc	= 0x01000000,
+
+	PAGE_TYPE_BASE	= 0x80000000,
+	PAGE_MAPCOUNT_RESERVE	= ~0x0000ffff,
+};
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.43.0


