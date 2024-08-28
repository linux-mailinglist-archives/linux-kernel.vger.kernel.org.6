Return-Path: <linux-kernel+bounces-305705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA596330F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44D01C23DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858121AC8AD;
	Wed, 28 Aug 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="escCSPqA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DlIhwAsD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651E187862
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878348; cv=fail; b=hZqauWIIuXeWauFI2vA3MLsh8XpQySvdh3VVg/uMjtHkTXJmgEHQQbZuL9yn5BViIH2GwGAF9mSrrn5PawryGkhSDHntZKOXAXTV4M5ufslsbgaV9bsTOHy8dZcRZACNPl7eyAwoNNixpmhuATqdk0xd2iZ0iVvtWEzbfH03V8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878348; c=relaxed/simple;
	bh=MljTMSWAwSlW/LO7wJUjl1KnAS25jGQ2KSlcD1Pysns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGn4CbbhxN1Suon9s4nys8MwiPhynLTEpis08ggPC5xBjaUVvdfHmSR9/QmYnOS+h2lqLy1zWxxmg1hZM+lyw4YKwQ0HG1DoxCFEi2bh6dHVFffLcFHDC1Y0rndBaNcWOV6TEY8R9s5mVQaEDMSo5e7BgafV7zO0WheOJP5pqcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=escCSPqA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DlIhwAsD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SKiQIP001693;
	Wed, 28 Aug 2024 20:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=pKrGc+I2tRdQD9E
	o5M94WHLrR3Z3bkYbxGy5cuwtSgY=; b=escCSPqAo6UzJzKUiVCdXlg8Y7uxf5p
	n3iyalyGj9o1PEQtCPz9+krNga/Cz9UUWmr+2Mis/n395sni77ggHRSbGir/Do9d
	QfyLnFjNyGYOBaPOzNED4+Adw1VX3tCJ92XPmU9QGvx6u1Tvwp8YuXesR37e3Wiy
	8MrFTk/cULxL1myOeLD+VWWq2Yqr8UfffrxXQgfxInQyJ06jZYxU7maD926STm+K
	t8dAhAzIunxddMnU8Ynk1r1eBzVXpcgyJIbbgR3XfqjaM8L1odSrbPXeEKaBYFbX
	sFYA5uTvg7PxVM3eh/E7yOlin+RdxjLw551wNpPK9WuHfSGUIS5Mrdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419puktanp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:52:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJKQcH031777;
	Wed, 28 Aug 2024 20:52:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vu86m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEGNq0inT6q8wAeka1Olvl+S996NT3xRHyXkpr3xPERDkfvVkA87LKMZDiXz15LcYbRkKDjkMrouIQhS2+AErlOm9Rrwh6EOjCk1+ZeshPEybr8mtFzIODD/bREIPfl4lshdpUlycOuH8e0CSq/2TK2BWwNYcD07tU0rBgmp/rjgw9VM66vGhUO0RB42fIRUrbgBfd6G9TnVi6ftNVbvC61X+xa38M2AxmawJSIWsaUxPRuNrjR6K66jMoQ+y1TKUQcwEvS2Ux0dIQbWxbudXnvyQOdwrKnrpCioDOZro4KlLpOlMjKy4ZjroZH5pjS8hqU0lZuqTiWKFZTfV6or6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKrGc+I2tRdQD9Eo5M94WHLrR3Z3bkYbxGy5cuwtSgY=;
 b=Ec27Q94MQ1A8kJAAIse4Y6FcNtnapOvudsmuJ0p5e2ath3qF8Ia2N7q/bJQT04AFQIA8yD2lbSVeU8rp/QPk+wJTBSRDBwqCgfYObLv2/9Ig9CZv10nTbTA96zGcKjcMQKxgd0S+iLxaXCtP9leebXqfvyMFfTto+O3ugf2TWIpgbQAfEAb0kG77qvoBmqlNmb7HjhN76WXawRSbvhhI1uEFPHJ0lpNItFUR2dH21XNb/PRWeeccAfOvZllhaNWE3jkK7pp1snQb1muRW+lN2GX7CPSF4IWcnYayJIMoE2WzF8msq4NDWW1s4nFMwxdBdTViWOixUxfk3Jd3QTEgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKrGc+I2tRdQD9Eo5M94WHLrR3Z3bkYbxGy5cuwtSgY=;
 b=DlIhwAsDK4ygXIgAbFq2SrsLGe5MkzDMoMSdiLrNVTVAukNbznCQz2spS8bqnQACW0FLFgJypZPvGHbdVoykyUWt8X5L4nxuEelqFlabbr1x1ztgbxUYRmWNakaXmn+YfAH7IrkxrLxNIWRc00dCCKEyoGoGgtYQ9ad6UvFTaYs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB5062.namprd10.prod.outlook.com (2603:10b6:408:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Wed, 28 Aug
 2024 20:52:11 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 20:52:10 +0000
Date: Wed, 28 Aug 2024 16:52:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <yyywfqdagobkzz26znuqgembxq7jkciq6kbhhhdvo4gox4idke@ixtspzmu6ttv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e23076a-6376-4ee7-762c-08dcc7a3489c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cMYQih67xYJJwuVQMZBePmh9SmE37OTyLGKi9GWLxvjNcKJkLCIZ8mAJ6Jdo?=
 =?us-ascii?Q?4NISc5Z3qZCCrAZvqjiok8qsFjqI7uPHNrliMEXBWM35vAmdXrae3bnMABjV?=
 =?us-ascii?Q?OLn6V4WZj/TX6UaqO0J01sZi12baN2h0T3qzmfeOQlbByhOey3NF+FDSeDLZ?=
 =?us-ascii?Q?oGUJucX9LFk7dBam0XF76bLgFRqOcD43RPbPqgR0xglX32wcUTJjZQ8ZAu5g?=
 =?us-ascii?Q?ySW/C+FPeKx6HEL9Afvf3pmWf+u5Xx2zym/Ql+0E+iNAN8r32iVHDAeaqn34?=
 =?us-ascii?Q?bLFIqmlkGuMDLyYT63kuXvWKBZ3sVmQq1uBuFSfUv9XRfmIcbRDiBr0LFKJm?=
 =?us-ascii?Q?Kn/+a3JlAd2xBtyHtiocmiyjU36QleCuGNRaYS4mXY5iGXWR6kB3/aIi3hCS?=
 =?us-ascii?Q?JOuMG1O2QeL5lxePRfQlivScb5d9zO5jDLHapR2kYrYG/RgijWxEM7/Ew4Ti?=
 =?us-ascii?Q?QlpcmaNmawvASg8NvTqNqbZPFc4l9XEntpl20DbLEp3qCEH0VFT3X+tgnlcy?=
 =?us-ascii?Q?Yc0l6wOizDFUz6HU+iJSaAEglJIJOWIGgqVNMj68B8975Z17JgKYpBWxnrbV?=
 =?us-ascii?Q?rEJCTYH3Q1mlo3t9eoNPnq5watQo59v6zD+bzOLVYiNU0txHbFoRHQASQG6G?=
 =?us-ascii?Q?Q33szMFGQljI6z52K9T4FQAU61x5hF47bqGhlQrQKkh6RE9r9xAAg8bRPI1w?=
 =?us-ascii?Q?1ucAfNU3LJO7JB620c+uRI2rZaKufRnc3R/inY8fgVH14PPdvJewDkT85nBf?=
 =?us-ascii?Q?bGuIK1yVC96U6lWknP5wJdXQyXPI07MTx+/KKcsgdqTu/2EnWLHG+eGfquos?=
 =?us-ascii?Q?uCxnQGXxl2zMeBvqyfIUCYRm2NtnumMvTa9XRmLuT0DBsj5wdASSOxxBI0PY?=
 =?us-ascii?Q?8Qnr/UPL61i6DHpcCMU2BVbnfDO99sDGpJLiOztsLM3tbu6GWO47nW+QaT+w?=
 =?us-ascii?Q?l1N9elXvjv1ZvRRjsd8WSddumZl9Ir1ADjf/+tgf+mtPijCcvEeVIWyO4sR8?=
 =?us-ascii?Q?BoKGYJh889NNRXHU2oJA60SGidn5JTwvzDNqtR5k8PHmOw7O1jc51qkUboi0?=
 =?us-ascii?Q?e1PIfNcf79V47H1WmS8bhNV6IUeNkbq7D+popLq4mfh/IoppXcKKkLzMqbK6?=
 =?us-ascii?Q?+CVGMN8wI5wghyyH9nEanqqGlHIBeJImcSfsKrYHLKgwPNmI2cSWwIs1hTUy?=
 =?us-ascii?Q?kl0lLDqTXZYGAfLRWqOLF7HiZ09asxw/3RpzTGDxsxucXvGHtCnuuGUwgOW8?=
 =?us-ascii?Q?XP0dcSuaRgBTXmyuycPHmioKApT82O1j1N+rmYhdQhSrCMB+YtOkSpiMKlrd?=
 =?us-ascii?Q?nl4/zo6fMby/85ya0JFqu7TOFg0JX+Ugz5Je04Smh2c2aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzJwhlZcSBZVtucctX8BjACF6+KfzbZwXoUCGo5Q0y0noc/FAGlbu8oFLceQ?=
 =?us-ascii?Q?84vPd7qX4X7vtDvtZBH5OX/RqU3LZUF71lTIyaoBbBgUKwdieS9A5P6sfwi8?=
 =?us-ascii?Q?nrF+w2Pl/4v7NVUBzulBkFKHZWwn4p+qjqaU0M/3Ii/nJuIMJwH0f74zC2ve?=
 =?us-ascii?Q?584n/f5SGNfFs7znDCBDDL6I3snnXs/XgDeS+QKBdqweOycPfBISc8+HTqZ+?=
 =?us-ascii?Q?UedhIGxiCYMqIMawEyXGGyPlLIXW2KyzxD4j0n+MO5gwML6xD8lxZQGFEk6R?=
 =?us-ascii?Q?+L27PHgcCtkEgKNxNsTfnc5ZhYS/gvZVJmXo5o2zi5kKW9ghZEAVDFF8EptW?=
 =?us-ascii?Q?0Rjy0vnoXweWkg3PWNuNBQ59PGc8FtLe+L5iLc39YhNgOLEvkzK2NU1dCfq4?=
 =?us-ascii?Q?RGhkdqb/ww6m0wTuWaU/RV1e7QGDTPTDHqsCIqmb/DgkONVxAdGUbpObtVFf?=
 =?us-ascii?Q?lFIJJbHByFPA0jFmu/1sKxTQE3RmmsoHxdqAl5BnszlyBK9RUV+BkLt1UVxi?=
 =?us-ascii?Q?PFt4BPj/NMUdHYQM9YBFK7b41/2VcTrd9yZCMQxPmYklgA58gO4fuv0k2qVK?=
 =?us-ascii?Q?4TnJG6OtziwO0Y4RDWKN9qrl8QuR97OWrCGD1nBjG4PsHHdXApsnZlHa6ave?=
 =?us-ascii?Q?z08/QLxLc6Nzq7S/5HQk0n44XxTDkN2if2BcXQyGH1sOPUXDkWrKm4EQts1s?=
 =?us-ascii?Q?oyQYWE05kfeyS2ku/ujXsek4kw6yUnS2VRmryqjDS8jizD53SI/B6wItb+Oh?=
 =?us-ascii?Q?A+ECVJsxDw4cjm0XOSjNxaSuVcekhakBIELWRtWzeWfp+YYnXy0lfRf9Hm5j?=
 =?us-ascii?Q?jYLfhqum36p0MbRMcsHPwryG9IBQBhxClOCGb7NEX95Q7ZBOSomUdr9oGk25?=
 =?us-ascii?Q?fUvstJGvPFV/EgGOMlLuefZ6i8sr7b4cDzHOv+7EdK6PjEBWgwJkQl2sSKYK?=
 =?us-ascii?Q?g4EGPdsFq5HrAU8ynTpceCoOysoIoBtf4Hwd8y6xRuqTUWrFpZA2rRmTHV/H?=
 =?us-ascii?Q?WnVgg9m9PM+Zc/UBcZl8NfX6zv719qptrpZtvtKcQnvlS+LkNqd5CIeWLQQs?=
 =?us-ascii?Q?MroESANM/Nbx6OC6V5gJOrWvLcC2Fn2A0OMRxVz7YY//d6Bu5vrOMg2/EDv9?=
 =?us-ascii?Q?FpxV6EbvpBzzdzzAv270lNevo+RLIP7NrHBrutFmVBK98pz0VTjAbEz4OT0Q?=
 =?us-ascii?Q?Tg5JUpERT7K1V1WAxh/dWTLtNeCxTF+nU+vtPucK2lAWrLPKMMdRk2jFKVEh?=
 =?us-ascii?Q?N6kDsIdW6rT40SXF7j0w0OFnCUuMnD2HoP5UDQkGeplY3RKwoE2U0RU9skra?=
 =?us-ascii?Q?rZp1IqGJ2ULThAVGbxYQVcAk51GzlwbQptkIMBpl4SgOmrYrEWuFsSQGT1Cm?=
 =?us-ascii?Q?iI18svRSi0zUCT/1fNjKzoWFBrGbXSnncC/kszxGbMnQr0wLv/zFXYfoUfCZ?=
 =?us-ascii?Q?BypLH21GfOj/uc7RtcWDZO8SQcUgyHDF6D5Y9eKPnAdosA6of8i7MUaAA88+?=
 =?us-ascii?Q?Gkunuu6vM13XK11CuapbSNl515zfTVSpwa+xFU0JaL4xMXrqS2M89G+xImeO?=
 =?us-ascii?Q?1JvxcPTDucVwBKcW2BYD6Og0HtXZkYK4w8ZwuGSm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T68sRLmknDQwTMhp0AdWn9L7otayRz/BvYbVgpwS92/My0fUtNZjQD26vPimXJ2JGEVLZvfuHrhGSUbcBk++JVx7jJbNChQgsaDzXvwYKHFugxG/HrgpUeTJ+vUZDwPuNhp3sE11p5Vi696ZjK9wJgu0SASVvlRrMfQh/+8bS4je7/Y+6PB6WcJjaMJi5PTRweY5khCTqAywqIslaP8sO9m+zoWM3+OmEXxwjbeTBmJuDqk07jzcy4lvLBV80Aqa6FHW5ek/4oriJEeBdvL5d8Lh3x5C83aSaxwIx4R6dmi10M0AslWc5VuLrQBT3ROfiegApKCeu13xfRW1E9jkMUIk+AK4ycNDW64oPHMNBG8Kby1ADj5NvtozwNwv1+/CcrjJJcHb8iCXNdG208GwP1cSXI5rMWVgS1k3mldLBPmYqzLmsarNFyVKf54/zJW4IgguHbEfmWDm70R01KmwFCU7yvtQzuKpN66vkD3M47MRbTivgu4SBHDxKHWJc61jocyJodeLbu8G+UjKxtk0a7k6duZlvnEkwKu9oLMX+tUcwxEAjMO7khTe/7xH3ADobjcMo9lrp8zzkGBRqU0hMN9PeZC9cJX4IDYUYLEueos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e23076a-6376-4ee7-762c-08dcc7a3489c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:52:10.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yigpymYSo2P0eiDssTZzJ2u82WT17tbrRsxBWccz6U4VPu++scgQQx3x9g0TX9NSa/zzc22h4D5/AMe2d77GtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280151
X-Proofpoint-ORIG-GUID: Nc2S1lDCHdCtGgsT2xY5HWPJz3_EFxp5
X-Proofpoint-GUID: Nc2S1lDCHdCtGgsT2xY5HWPJz3_EFxp5

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> Abstract vma_merge_new_vma() to use vma_merge_struct and rename the
> resultant function vma_merge_new_range() to be clear what the purpose of
> this function is - a new VMA is desired in the specified range, and we wish
> to see if it is possible to 'merge' surrounding VMAs into this range rather
> than having to allocate a new VMA.
> 
> Note that this function uses vma_extend() exclusively, so adopts its
> requirement that the iterator point at or before the gap. We add an assert
> to this effect.
> 
> This is as opposed to vma_merge_existing_range(), which will be introduced
> in a subsequent commit, and provide the same functionality for cases in
> which we are modifying an existing VMA.
> 
> In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> to use vma_expand() rather than invoke a full vma_merge() operation.
> 
> Abstract this logic and eliminate all of the open-coding, and also use the
> same logic for all cases where we add new VMAs to, rather than ultimately
> use vma_merge(), rather use vma_expand().
> 
> Doing so removes duplication and simplifies VMA merging in all such cases,
> laying the ground for us to eliminate the merging of new VMAs in
> vma_merge() altogether.
> 
> Also add the ability for the vmg to track state, and able to report errors,
> allowing for us to differentiate a failed merge from an inability to
> allocate memory in callers.
> 
> This makes it far easier to understand what is happening in these cases
> avoiding confusion, bugs and allowing for future optimisation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c                        |  93 +++++-------------
>  mm/vma.c                         | 162 ++++++++++++++++++++++++++-----
>  mm/vma.h                         |  20 +++-
>  tools/testing/vma/vma.c          |  33 ++++++-
>  tools/testing/vma/vma_internal.h |   6 ++
>  5 files changed, 216 insertions(+), 98 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0d242c9b1f4c..80d70ed099cf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1364,8 +1364,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
> -	struct vm_area_struct *next, *prev, *merge;
>  	pgoff_t pglen = PHYS_PFN(len);
> +	struct vm_area_struct *merge;
>  	unsigned long charged = 0;
>  	struct vma_munmap_struct vms;
>  	struct ma_state mas_detach;
> @@ -1389,13 +1389,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>  			return -ENOMEM;
>  
> -		next = vmg.next = vms.next;
> -		prev = vmg.prev = vms.prev;
> +		vmg.next = vms.next;
> +		vmg.prev = vms.prev;
>  		vma = NULL;
>  	} else {
> -		next = vmg.next = vma_next(&vmi);
> -		prev = vmg.prev = vma_prev(&vmi);
> -		if (prev)
> +		vmg.next = vma_next(&vmi);
> +		vmg.prev = vma_prev(&vmi);
> +		if (vmg.prev)
>  			vma_iter_next_range(&vmi);
>  	}
>  
> @@ -1417,45 +1417,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vmg.flags = vm_flags;
>  	}
>  
> -	if (vm_flags & VM_SPECIAL)
> -		goto cannot_expand;
> -
> -	/* Attempt to expand an old mapping */
> -	/* Check next */
> -	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> -		vmg.end = next->vm_end;
> -		vma = vmg.vma = next;
> -		vmg.pgoff = next->vm_pgoff - pglen;
> -		/*
> -		 * We set this here so if we will merge with the previous VMA in
> -		 * the code below, can_vma_merge_after() ensures anon_vma
> -		 * compatibility between prev and next.
> -		 */
> -		vmg.anon_vma = vma->anon_vma;
> -		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> -	}
> -
> -	/* Check prev */
> -	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> -		vmg.start = prev->vm_start;
> -		vma = vmg.vma = prev;
> -		vmg.pgoff = prev->vm_pgoff;
> -		vma_prev(&vmi); /* Equivalent to going to the previous range */
> -	}
> -
> -	if (vma) {
> -		/* Actually expand, if possible */
> -		if (!vma_expand(&vmg)) {
> -			khugepaged_enter_vma(vma, vm_flags);
> -			goto expanded;
> -		}
> -
> -		/* If the expand fails, then reposition the vma iterator */
> -		if (unlikely(vma == prev))
> -			vma_iter_set(&vmi, addr);
> -	}
> -
> -cannot_expand:
> +	vma = vma_merge_new_range(&vmg);
> +	if (vma)
> +		goto expanded;
>  
>  	/*
>  	 * Determine the object being mapped and call the appropriate
> @@ -1503,10 +1467,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * If vm_flags changed after call_mmap(), we should try merge
>  		 * vma again as we may succeed this time.
>  		 */
> -		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> -			merge = vma_merge_new_vma(&vmi, prev, vma,
> -						  vma->vm_start, vma->vm_end,
> -						  vma->vm_pgoff);
> +		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> +			vmg.flags = vma->vm_flags;
> +			/* If this fails, state is reset ready for a reattempt. */
> +			merge = vma_merge_new_range(&vmg);
> +

Extra white space.

>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> @@ -1521,6 +1486,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  				/* Update vm_flags to pick up the change. */
>  				vm_flags = vma->vm_flags;
>  				goto unmap_writable;
> +			} else {
> +				vma_iter_config(&vmi, addr, end);

This else can be dropped since the if ends in a goto.  I guess, what you
are trying to fix is the merge of the prev (which moved the iterator)
that failed.  Might be easier to read, either way it is correct.

>  			}
>  		}
>  
> @@ -1554,7 +1521,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma_link_file(vma);
>  
>  	/*
> -	 * vma_merge() calls khugepaged_enter_vma() either, the below
> +	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>  	 * call covers the non-merge case.
>  	 */
>  	khugepaged_enter_vma(vma, vma->vm_flags);
> @@ -1609,7 +1576,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  		vma_iter_set(&vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(&vmi.mas, vma, prev, next);
> +		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
>  	}
>  	if (writable_file_mapping)
>  		mapping_unmap_writable(file->f_mapping);
> @@ -1755,7 +1722,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long addr, unsigned long len, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vma_prepare vp;
>  
>  	/*
>  	 * Check against address space limits by the changed size
> @@ -1779,25 +1745,12 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
>  
>  		vmg.prev = vma;
> -		if (can_vma_merge_after(&vmg)) {
> -			vma_iter_config(vmi, vma->vm_start, addr + len);
> -			if (vma_iter_prealloc(vmi, vma))
> -				goto unacct_fail;
> -
> -			vma_start_write(vma);
> -
> -			init_vma_prep(&vp, vma);
> -			vma_prepare(&vp);
> -			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -			vma->vm_end = addr + len;
> -			vm_flags_set(vma, VM_SOFTDIRTY);
> -			vma_iter_store(vmi, vma);
> -
> -			vma_complete(&vp, vmi, mm);
> -			validate_mm(mm);
> -			khugepaged_enter_vma(vma, flags);
> +		vma_iter_next_range(vmi);
> +
> +		if (vma_merge_new_range(&vmg))
>  			goto out;
> -		}
> +		else if (vmg_nomem(&vmg))
> +			goto unacct_fail;
>  	}
>  
>  	if (vma)
> diff --git a/mm/vma.c b/mm/vma.c
> index 4867ae722a9a..8a5fa15f46a2 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -464,6 +464,116 @@ void validate_mm(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
>  
> +/*
> + * vma_merge_new_range - Attempt to merge a new VMA into address space
> + *
> + * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
> + *       (exclusive), which we try to merge with any adjacent VMAs if possible.
> + *
> + * We are about to add a VMA to the address space starting at @vmg->start and
> + * ending at @vmg->end. There are three different possible scenarios:
> + *
> + * 1. There is a VMA with identical properties immediately adjacent to the
> + *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
> + *    EXPAND that VMA:
> + *
> + * Proposed:       |-----|  or  |-----|
> + * Existing:  |----|                  |----|
> + *
> + * 2. There are VMAs with identical properties immediately adjacent to the
> + *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
> + *    EXPAND the former and REMOVE the latter:
> + *
> + * Proposed:       |-----|
> + * Existing:  |----|     |----|
> + *
> + * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
> + *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
> + *
> + * In instances where we can merge, this function returns the expanded VMA which
> + * will have its range adjusted accordingly and the underlying maple tree also
> + * adjusted.
> + *
> + * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
> + *          to the VMA we expanded.
> + *
> + * This function adjusts @vmg to provide @vmg->next if not already specified,
> + * and adjusts [@vmg->start, @vmg->end) to span the expanded range.
> + *
> + * ASSUMPTIONS:
> + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> + * - The caller must have determined that [@vmg->start, @vmg->end) is empty,
> +     other than VMAs that will be unmapped should the operation succeed.
> + * - The caller must have specified the previous vma in @vmg->prev.
> + * - The caller must have specified the next vma in @vmg->next.
> + * - The caller must have positioned the vmi at or before the gap.
> + */
> +struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> +{
> +	struct vm_area_struct *prev = vmg->prev;
> +	struct vm_area_struct *next = vmg->next;
> +	unsigned long start = vmg->start;
> +	unsigned long end = vmg->end;
> +	pgoff_t pgoff = vmg->pgoff;
> +	pgoff_t pglen = PHYS_PFN(end - start);
> +	bool can_merge_before, can_merge_after;
> +
> +	mmap_assert_write_locked(vmg->mm);
> +	VM_WARN_ON(vmg->vma);
> +	/* vmi must point at or before the gap. */
> +	VM_WARN_ON(vma_iter_addr(vmg->vmi) > end);
> +
> +	vmg->state = VMA_MERGE_NOMERGE;
> +
> +	/* Special VMAs are unmergeable, also if no prev/next. */
> +	if ((vmg->flags & VM_SPECIAL) || (!prev && !next))
> +		return NULL;
> +
> +	can_merge_before = next && next->vm_start == end &&
> +		can_vma_merge_before(vmg);
> +	can_merge_after = prev && prev->vm_end == start &&
> +		can_vma_merge_after(vmg);

Can we please rewrite this as if statements for clarity?

> +
> +	/* If we can merge with the next VMA, adjust vmg accordingly. */
> +	if (can_merge_before &&
> +	    (!can_merge_after || is_mergeable_anon_vma(prev->anon_vma,
> +						       next->anon_vma, NULL))) {
> +		vmg->end = next->vm_end;
> +		vmg->vma = next;
> +		vmg->pgoff = next->vm_pgoff - pglen;
> +	}
> +
> +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> +	if (can_merge_after) {
> +		vmg->start = prev->vm_start;
> +		vmg->vma = prev;
> +		vmg->pgoff = prev->vm_pgoff;
> +
> +		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
> +	}
> +
> +	/*
> +	 * Now try to expand adjacent VMA(s). This takes care of removing the
> +	 * following VMA if we have VMAs on both sides.
> +	 */
> +	if (vmg->vma && !vma_expand(vmg)) {
> +		khugepaged_enter_vma(vmg->vma, vmg->flags);

This might be able to be moved into vma_expand().

> +

Extra whitespace

> +		vmg->state = VMA_MERGE_SUCCESS;
> +		return vmg->vma;
> +	}
> +
> +	/* If expansion failed, reset state. Allows us to retry merge later. */
> +	vmg->vma = NULL;
> +	vmg->start = start;
> +	vmg->end = end;
> +	vmg->pgoff = pgoff;
> +	if (vmg->vma == prev)
> +		vma_iter_set(vmg->vmi, start);
> +
> +	return NULL;
> +}
> +
>  /*
>   * vma_expand - Expand an existing VMA
>   *
> @@ -474,7 +584,11 @@ void validate_mm(struct mm_struct *mm)
>   * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
>   * vmg->next needs to be handled by the caller.
>   *
> - * Returns: 0 on success
> + * Returns: 0 on success.
> + *
> + * ASSUMPTIONS:
> + * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
> + * - The caller must have set @vmg->vma and @vmg->next.
>   */
>  int vma_expand(struct vma_merge_struct *vmg)
>  {
> @@ -484,6 +598,8 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	struct vm_area_struct *next = vmg->next;
>  	struct vma_prepare vp;
>  
> +	mmap_assert_write_locked(vmg->mm);
> +

There are a few unnecessary whitespaces here..

>  	vma_start_write(vma);
>  	if (next && (vma != next) && (vmg->end == next->vm_end)) {
>  		int ret;
> @@ -516,6 +632,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	return 0;
>  
>  nomem:
> +	vmg->state = VMA_MERGE_ERROR_NOMEM;
>  	if (anon_dup)
>  		unlink_anon_vmas(anon_dup);
>  	return -ENOMEM;
> @@ -1034,6 +1151,8 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  	pgoff_t pglen = PHYS_PFN(end - addr);
>  	long adj_start = 0;
>  
> +	vmg->state = VMA_MERGE_NOMERGE;
> +
>  	/*
>  	 * We later require that vma->vm_flags == vm_flags,
>  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> @@ -1185,13 +1304,19 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  	vma_complete(&vp, vmg->vmi, mm);
>  	validate_mm(mm);
>  	khugepaged_enter_vma(res, vmg->flags);
> +
> +	vmg->state = VMA_MERGE_SUCCESS;
>  	return res;
>  
>  prealloc_fail:
> +	vmg->state = VMA_MERGE_ERROR_NOMEM;
>  	if (anon_dup)
>  		unlink_anon_vmas(anon_dup);
>  
>  anon_vma_fail:
> +	if (err == -ENOMEM)
> +		vmg->state = VMA_MERGE_ERROR_NOMEM;
> +
>  	vma_iter_set(vmg->vmi, addr);
>  	vma_iter_load(vmg->vmi);
>  	return NULL;
> @@ -1298,22 +1423,6 @@ struct vm_area_struct
>  	return vma_modify(&vmg);
>  }
>  
> -/*
> - * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> - * must ensure that [start, end) does not overlap any existing VMA.
> - */
> -struct vm_area_struct
> -*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -		   struct vm_area_struct *vma, unsigned long start,
> -		   unsigned long end, pgoff_t pgoff)
> -{
> -	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> -
> -	vmg.pgoff = pgoff;
> -
> -	return vma_merge(&vmg);
> -}
> -
>  /*
>   * Expand vma by delta bytes, potentially merging with an immediately adjacent
>   * VMA with identical properties.
> @@ -1324,8 +1433,9 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  {
>  	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
>  
> -	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(&vmg);
> +	/* We use the VMA to populate VMG fields only. */
> +	vmg.vma = NULL;
> +	return vma_merge_new_range(&vmg);
>  }
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> @@ -1426,9 +1536,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	struct vm_area_struct *vma = *vmap;
>  	unsigned long vma_start = vma->vm_start;
>  	struct mm_struct *mm = vma->vm_mm;
> -	struct vm_area_struct *new_vma, *prev;
> +	struct vm_area_struct *new_vma;
>  	bool faulted_in_anon_vma = true;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
>  
>  	/*
>  	 * If anonymous vma has not yet been faulted, update new pgoff
> @@ -1439,11 +1550,18 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  		faulted_in_anon_vma = false;
>  	}
>  
> -	new_vma = find_vma_prev(mm, addr, &prev);
> +	new_vma = find_vma_prev(mm, addr, &vmg.prev);
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
>  
> -	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
> +	vmg.vma = NULL; /* New VMA range. */
> +	vmg.pgoff = pgoff;
> +	vmg.next = vma_next(&vmi);
> +	vma_prev(&vmi);
> +	vma_iter_next_range(&vmi);

You have already fixed this.

> +
> +	new_vma = vma_merge_new_range(&vmg);
> +
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma
> diff --git a/mm/vma.h b/mm/vma.h
> index 8f01fbc20fe7..dbcdf1431014 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -52,6 +52,13 @@ struct vma_munmap_struct {
>  	unsigned long data_vm;
>  };
>  
> +enum vma_merge_state {
> +	VMA_MERGE_START,
> +	VMA_MERGE_ERROR_NOMEM,
> +	VMA_MERGE_NOMERGE,
> +	VMA_MERGE_SUCCESS,
> +};
> +
>  /* Represents a VMA merge operation. */
>  struct vma_merge_struct {
>  	struct mm_struct *mm;
> @@ -68,8 +75,14 @@ struct vma_merge_struct {
>  	struct mempolicy *policy;
>  	struct vm_userfaultfd_ctx uffd_ctx;
>  	struct anon_vma_name *anon_name;
> +	enum vma_merge_state state;
>  };
>  
> +static inline bool vmg_nomem(struct vma_merge_struct *vmg)
> +{
> +	return vmg->state == VMA_MERGE_ERROR_NOMEM;
> +}
> +
>  /* Assumes addr >= vma->vm_start. */
>  static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  				       unsigned long addr)
> @@ -85,6 +98,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  		.end = end_,						\
>  		.flags = flags_,					\
>  		.pgoff = pgoff_,					\
> +		.state = VMA_MERGE_START,				\
>  	}
>  
>  #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
> @@ -103,6 +117,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  		.policy = vma_policy(vma_),			\
>  		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
>  		.anon_name = anon_vma_name(vma_),		\
> +		.state = VMA_MERGE_START,			\
>  	}
>  
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> @@ -306,10 +321,7 @@ struct vm_area_struct
>  		       unsigned long new_flags,
>  		       struct vm_userfaultfd_ctx new_ctx);
>  
> -struct vm_area_struct
> -*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -		   struct vm_area_struct *vma, unsigned long start,
> -		   unsigned long end, pgoff_t pgoff);
> +struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
>  
>  struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					struct vm_area_struct *vma,
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index cce1ba78c57f..3a3a850d951c 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -101,9 +101,9 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  	 */
>  	vmg->next = vma_next(vmg->vmi);
>  	vmg->prev = vma_prev(vmg->vmi);
> +	vma_iter_next_range(vmg->vmi);
>  
> -	vma_iter_set(vmg->vmi, vmg->start);
> -	return vma_merge(vmg);
> +	return vma_merge_new_range(vmg);
>  }
>  
>  /*
> @@ -162,10 +162,14 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
>  	merged = merge_new(vmg);
>  	if (merged) {
>  		*was_merged = true;
> +		ASSERT_EQ(vmg->state, VMA_MERGE_SUCCESS);
>  		return merged;
>  	}
>  
>  	*was_merged = false;
> +
> +	ASSERT_EQ(vmg->state, VMA_MERGE_NOMERGE);
> +
>  	return alloc_and_link_vma(mm, start, end, pgoff, flags);
>  }
>  
> @@ -595,6 +599,7 @@ static bool test_vma_merge_special_flags(void)
>  		vmg.flags = flags | special_flag;
>  		vma = merge_new(&vmg);
>  		ASSERT_EQ(vma, NULL);
> +		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  	}
>  
>  	/* 2. Modify VMA with special flag that would otherwise merge. */
> @@ -616,6 +621,7 @@ static bool test_vma_merge_special_flags(void)
>  		vmg.flags = flags | special_flag;
>  		vma = merge_existing(&vmg);
>  		ASSERT_EQ(vma, NULL);
> +		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  	}
>  
>  	cleanup_mm(&mm, &vmi);
> @@ -708,6 +714,7 @@ static bool test_vma_merge_with_close(void)
>  
>  	/* The next VMA having a close() operator should cause the merge to fail.*/
>  	ASSERT_EQ(merge_new(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	/* Now create the VMA so we can merge via modified flags */
>  	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> @@ -719,6 +726,7 @@ static bool test_vma_merge_with_close(void)
>  	 * also fail.
>  	 */
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	/* SCENARIO B
>  	 *
> @@ -744,6 +752,7 @@ static bool test_vma_merge_with_close(void)
>  	vmg.vma = vma;
>  	/* Make sure merge does not occur. */
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	cleanup_mm(&mm, &vmi);
>  	return true;
> @@ -792,6 +801,7 @@ static bool test_vma_merge_new_with_close(void)
>  	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
>  	vma = merge_new(&vmg);
>  	ASSERT_NE(vma, NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x5000);
>  	ASSERT_EQ(vma->vm_pgoff, 0);
> @@ -831,6 +841,7 @@ static bool test_merge_existing(void)
>  	vmg.prev = vma;
>  	vma->anon_vma = &dummy_anon_vma;
>  	ASSERT_EQ(merge_existing(&vmg), vma_next);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_next->vm_start, 0x3000);
>  	ASSERT_EQ(vma_next->vm_end, 0x9000);
>  	ASSERT_EQ(vma_next->vm_pgoff, 3);
> @@ -861,6 +872,7 @@ static bool test_merge_existing(void)
>  	vmg.vma = vma;
>  	vma->anon_vma = &dummy_anon_vma;
>  	ASSERT_EQ(merge_existing(&vmg), vma_next);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_next->vm_start, 0x2000);
>  	ASSERT_EQ(vma_next->vm_end, 0x9000);
>  	ASSERT_EQ(vma_next->vm_pgoff, 2);
> @@ -889,6 +901,7 @@ static bool test_merge_existing(void)
>  	vma->anon_vma = &dummy_anon_vma;
>  
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x6000);
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> @@ -920,6 +933,7 @@ static bool test_merge_existing(void)
>  	vmg.vma = vma;
>  	vma->anon_vma = &dummy_anon_vma;
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x7000);
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> @@ -948,6 +962,7 @@ static bool test_merge_existing(void)
>  	vmg.vma = vma;
>  	vma->anon_vma = &dummy_anon_vma;
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x9000);
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> @@ -981,31 +996,37 @@ static bool test_merge_existing(void)
>  	vmg.prev = vma;
>  	vmg.vma = vma;
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
>  	vmg.prev = vma;
>  	vmg.vma = vma;
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
>  	vmg.prev = vma;
>  	vmg.vma = vma;
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
>  	vmg.prev = vma;
>  	vmg.vma = vma;
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
>  	vmg.prev = vma;
>  	vmg.vma = vma;
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
>  	vmg.prev = vma;
>  	vmg.vma = vma;
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
>  
>  	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
>  
> @@ -1071,6 +1092,7 @@ static bool test_anon_vma_non_mergeable(void)
>  	vmg.vma = vma;
>  
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x7000);
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> @@ -1106,6 +1128,7 @@ static bool test_anon_vma_non_mergeable(void)
>  	vmg.prev = vma_prev;
>  
>  	ASSERT_EQ(merge_new(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x7000);
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> @@ -1181,6 +1204,7 @@ static bool test_dup_anon_vma(void)
>  	vmg.vma = vma;
>  
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x8000);
> @@ -1209,6 +1233,7 @@ static bool test_dup_anon_vma(void)
>  	vmg.vma = vma;
>  
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x8000);
> @@ -1236,6 +1261,7 @@ static bool test_dup_anon_vma(void)
>  	vmg.vma = vma;
>  
>  	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  
>  	ASSERT_EQ(vma_prev->vm_start, 0);
>  	ASSERT_EQ(vma_prev->vm_end, 0x5000);
> @@ -1263,6 +1289,7 @@ static bool test_dup_anon_vma(void)
>  	vmg.vma = vma;
>  
>  	ASSERT_EQ(merge_existing(&vmg), vma_next);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  
>  	ASSERT_EQ(vma_next->vm_start, 0x3000);
>  	ASSERT_EQ(vma_next->vm_end, 0x8000);
> @@ -1303,6 +1330,7 @@ static bool test_vmi_prealloc_fail(void)
>  
>  	/* This will cause the merge to fail. */
>  	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
>  	/* We will already have assigned the anon_vma. */
>  	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>  	/* And it was both cloned and unlinked. */
> @@ -1327,6 +1355,7 @@ static bool test_vmi_prealloc_fail(void)
>  
>  	fail_prealloc = true;
>  	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
> +	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
>  
>  	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(dummy_anon_vma.was_cloned);
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index a3c262c6eb73..c5b9da034511 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -740,6 +740,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
>  	mas_destroy(&vmi->mas);
>  }
>  
> +static inline
> +struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
> +{
> +	return mas_next_range(&vmi->mas, ULONG_MAX);
> +}
> +
>  static inline void vm_acct_memory(long pages)
>  {
>  }
> -- 
> 2.46.0
> 

