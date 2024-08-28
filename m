Return-Path: <linux-kernel+bounces-305602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BD0963108
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE67528648F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFEE1AC435;
	Wed, 28 Aug 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RjfBKUOu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bebjSR1q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426D1AAE19
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873724; cv=fail; b=HP4LdcPFybWQtxqemjTEWsUA9STZG27/i2G0m6H6eTdhhgR73x4n5Hpx1Ce2OWRpGJkSDoSxvk5R4qaPntIomcUdYyoUNfV7y+bGP7xARWTxVEC2rj5BMgiBy3wPkzWyhB91KOXeeZFAP5KohyLoKZoJytcNV6Ghtk7D+M8vSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873724; c=relaxed/simple;
	bh=gu4+LERpu/DSR0cxvojQtiZjLmRLfTzfFnjHlQhLsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBBssOY105Ci2yo8/LKIKMn4GGMyviPkH170oHcFvYk1N5V2jMMBDItcdeHzKUOgWoralWLsJ83KZuwDnNb7HX9Rpshj6JIJLzVQQcs13D8E1eKJqV84HuwgdaLJDjF8AvDbN/Y7CC0pcR8TDWOL6lZOoYWdshnlG97ol2oQETE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RjfBKUOu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bebjSR1q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJYO7N013600;
	Wed, 28 Aug 2024 19:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=rw2Ze1m6t0yq6HY
	bzYBZrY/avk1lgi169y2CLDB7WM4=; b=RjfBKUOuFNoRcfMb57Q4EgfxpRCmocr
	o+WEKhijauJd+HxtBap4xM7hf/6JxIdfrqjt7PUPztFgEOsnmr8GwMZJPr3LUyq7
	RLxgeCC87reiNuWJZXtH609bYpxESHmwuVFHhwPbyGLlxS8AdRS9dN4YoDQEmhL2
	Gr4ZqLSWJNViZWxrJizGFLgueRHPFpZie2GMmicmhXgsU/1KrzktSahwiLBhm4Jj
	doTT1vaqQdnBw2mLnZsVWk5BQB/9jepWpasuJIWKHx3mi/EOwSz3iH7XOt5VwFjj
	LkGcs5mOBcbsGrxHVEOGnrWjvzx5Z6PlUkp1eJYCwkHtrp+F0dBMeWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pus25kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:35:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SI1wUR031774;
	Wed, 28 Aug 2024 19:35:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vrefe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsKdXf5cDZbJFbN135tXgj8q36fzAvuI6kgYhs4fzNVVhuPhcFTTpv6tbzxCyKhAn5ggvi/gy9FtLtQMT3u1PpR180j0SZArJkHdLbcwBggYF/z3K1Q5ei4OPJHCCRl9Shl2/++64IV1okmT57FptLLN9tT2GjA9NEdwC+NJjSEXOfHTj5eJlsdKPHZ3AMJDfoeUBRr2m8Ar8UaBp8YX2yCklrRpgIpK3eF/UMZeltwanaXKaypEplTYWb0DYjUvuU+tzXvWSZLqp81U8S3bQ3FIfiajWvrmpi0uIGF0CrPO0uQx149xE3zr7tzD8sinTAXS8vr5WJ1ZeHK5id2C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw2Ze1m6t0yq6HYbzYBZrY/avk1lgi169y2CLDB7WM4=;
 b=a0JpHbXCNh3WSA6SAZQT4Acb3xwIhl2HUV/EochnN6Mc562EY4Jw70mtpM57aWy8pg1XxmKCciHGqq5rVyRSwHeyG6/Y+ER7oqrSkGNXyv+8kWXlogF4HK5SdrsXdh5OS622wytOkfCovkDclxoWydMQJWUmk4MLkFamsfFwgkyNtFJjDXZwna/35YSwGBXtkeO66eJUXTPTZEqkbQed4Jq1jo2r+71ZRUa235WNtkV00KVDkCdNfl/unYkx2DLnm+96uvneRQZHUZGek92l5K676tKKV5rK84EnljIG35V4KY1Ehe3A5AHE8czHtY7zIe9HzT5xMmLLsLtgEVDY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw2Ze1m6t0yq6HYbzYBZrY/avk1lgi169y2CLDB7WM4=;
 b=bebjSR1q9xHdx0ZXBbhqwatVTnDgVsNWFyZPjUHsONnRs03TArWjXy0NOxNe7VaqRdfkqZ/gP+MaCh6uRrBhqYsrtshWvCUJgvs2CW3zUf8ArrWcFJsMTfwQtkFFwKeFE6mlSUSViJ0gP4gfWwAVOoVQhqmVwgJYJ0zEpMBPPIM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 19:35:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 19:35:08 +0000
Date: Wed, 28 Aug 2024 15:35:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 03/10] mm: introduce vma_merge_struct and abstract
 vma_merge(),vma_modify()
Message-ID: <mly5jrnbqstukybd75wse3toj4zgb2s74rcdqausorkphtfigz@oo5s4oqtia7o>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <ecce1383916a978fba6b75dcbb74132d8bb1eaa6.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecce1383916a978fba6b75dcbb74132d8bb1eaa6.1724441678.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: d9705fb2-5e77-41f9-fb46-08dcc7988616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7Hb34NI01HIFQZoTIGBIa1cPSCLMpiZJLR96eVpfzLWMK2O62AusVkHJGO/?=
 =?us-ascii?Q?f9af107873tNQ9JI9mKE0KuT0pbh/gxv5PUXaGAumhVEwlbaQUVdpcoeLvXt?=
 =?us-ascii?Q?///WBySEblr9yDNTI+4TAXpPMltJ08WCBftrPOfTYL1FJrkzBiPCiqtrod+k?=
 =?us-ascii?Q?FbzxlRrguTpB7//Sw5heyLx9ctNiN4W/s+cxF3oI0Qwx+MFUcWge7jyqxGUQ?=
 =?us-ascii?Q?LQUMZ+UPSOt+Njw6EHtDikmUnrQmnKg7qkFH31UKDgu/aYaQacUej+I++7n2?=
 =?us-ascii?Q?yCz4V01WwkYkveKFfkZwRganhQyxQIQU9ONYWImEy0LtE3X4ISn8BqQEH1qg?=
 =?us-ascii?Q?mDG6K8nJrfNQFXwfZ3ofgXIDu3DJu5hACcdO2Uw8KtlRXudJxknCiwVcReqS?=
 =?us-ascii?Q?GJZJqQu5cyVXy1Mh/QBO915Y51HXxGAUSqYsX41oFv7LVLUIHN8LoDM12Nkd?=
 =?us-ascii?Q?QH4EPs7g7NuPTx0f17Sa+deZ4LVmnzWndqxL5Tzd6/76zsrnJapN2a3KWLcs?=
 =?us-ascii?Q?K+6kRLnZtgUt9Sw7lNsF/e2GERFoPWKumtjpjJQbb4o5as9k+7UWEd+pPrOB?=
 =?us-ascii?Q?Tt2J9WnTLTDBTmD2MyK6zNqiNuR5eB0veSGLm74Yt5nRRK88PPUreGbBiARr?=
 =?us-ascii?Q?XeKAfeWZCzxNvRwsgABxJaeBIXr8ZrKn0cSorRwDyeO5ViWPw8xpkITblBV7?=
 =?us-ascii?Q?QUrViNy4Skuh2X8BK0Qsvq90+kVxwut9l86Mkh4g6Z9jpGQROqEJf3gJQ0Qm?=
 =?us-ascii?Q?QhYZUeMi3nUiSRVMuJy0yPpuHAS9Zloi0QDkYCHtRBuCVXW5QBcN5rmwnWTK?=
 =?us-ascii?Q?im0x0tmMexkYgQjlSvE5kfpFmjxx6r62uUIwaDpng0Mb8L+dAEi0DSAJ+xPa?=
 =?us-ascii?Q?x3m8i4dVakNtd6PklXbGES8hFyROremyJ1iCGYc1xtgPGIANaWPMGHo44CYE?=
 =?us-ascii?Q?ZNgCVnokPhU6ELVxPYpB3gxlCtSWd49ZGmB9/fpqQ9jd4lUUxLQfi+MbmFGu?=
 =?us-ascii?Q?RlFECppy1ns0o7bH3Q78trrEm4Kzj4hDl7Wqx7GzZwzWPaaUMwz2xsRcf+so?=
 =?us-ascii?Q?PLW4K25qHYZzh+9RCSnUGrD2e+H1A3wyY4UMH+pmHcFWoL8ekzxoSzL9w9sc?=
 =?us-ascii?Q?QxWxArPElpt74Cc4BgRc3+1v8VbKvuzaDxVx6xWjM/ebKdDi6hLurvgLfMMP?=
 =?us-ascii?Q?+73dKt/HLpR54xN9ZIGI4RkVg6Ceu549O2PsJHypTn6NlO6U9L3CQwGx/6u0?=
 =?us-ascii?Q?/xdCxhJskol2LQngd/xRldbSm7HVjzGJ4DMM4VMML/PjRjlGRQy+qHXCyFVC?=
 =?us-ascii?Q?EfKF84o6QutLVvpYvYR9g83wwfekTGCyv0252yZLPS59bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBH50ByjSzeyzcdQVCD2awF74PquJoDlq5mtou6HI/jDZQQSk74Z+ya0lX8n?=
 =?us-ascii?Q?jyuhb02pxIfkh3OD6Ghu4xlWditYcPyd1Rcw4PzGcXDSGWYWrAEcWW7gn8lB?=
 =?us-ascii?Q?Y3XmZaCF9L8dcG6wQPGLMGS70oaMUPBMNjMpb0oH5p3cGOviC0iLuk3zhkfu?=
 =?us-ascii?Q?zDbgypPpJ92evrExbxlQjKL0xjosX+/ihUx//L2gjb1mY/th3VIp0rJyXuMa?=
 =?us-ascii?Q?BOgwOeSwGxnYpp5OAzP4pxYrj67ubaO/PSqxeKw0seCb/2NkBp2deY/2hcKh?=
 =?us-ascii?Q?nqqhQ1jCzvdZfGui9++0Ra+2ujMp5AxB5WIQEV/x0pm56pzsw1CmLuoiH82I?=
 =?us-ascii?Q?ViM2JCg9MyOGNX/on1xKX8z3XmXZgrqGXhh4TLASzvlwOpsGuO+WZh6qv71g?=
 =?us-ascii?Q?s1tSgybL0WhJ0msyTBgG7xufTxZl+FnsPLKOI2ysmMua08wkNQ6HHlNL0cq3?=
 =?us-ascii?Q?sdnkfihwWuTsec018+cOoYqAJb/5ccSUVWG1QiMDXH5UTnj6kHzTcUJQW99K?=
 =?us-ascii?Q?CJdnwwmCPS/ayAYs49GSxts0Bk1rpKygLxZALO3NmZhFgTGD6smZd3V6i4cD?=
 =?us-ascii?Q?Ab+JbQhLXr0hkYCgLY9qnF1RULsVdu/P98Vp9RUjH/yh0GJDSmoWsL+cXW8D?=
 =?us-ascii?Q?Y+8t7cmGs7Xt3BhrwRL7EbtiHMBRNRys4EADo9y8+TIRQhX9k/23wgLgsmvN?=
 =?us-ascii?Q?wvzRlkYsyCtG4YfHbyYtqEOxUnbTtCgQeviPal+Kdk+05QGabgV2dJfmg8cS?=
 =?us-ascii?Q?WKzaHMQXgB7W5+9b2DRooXvBZ0H9ckRzJn9EmuzUnm84WZ6LuG0BFXOlZovH?=
 =?us-ascii?Q?bSDu1EQrKPph6+7AfWn8EbCcTmCyutOeB5F64LPOFhr4yXRuvz5CEH7RM0v6?=
 =?us-ascii?Q?kvWvHyUSxsrxdJj/oxqVvxFKa1rEiF7exPzaiCB4x7m7tzJkF6Wh/4V0YoTL?=
 =?us-ascii?Q?zeOKMht8lj4PTjO6kRebj+zHKSrbgiPh2VAgGuUwIGcXMHme9EGnol25l0HN?=
 =?us-ascii?Q?P7ksbnuTwBg1EnUZnh7G93sjZWRSMfOEMukAAoZaIlqPbWMPMOtxHFYsF5Ya?=
 =?us-ascii?Q?Y73KEpmkjb0AOvikoMc+c+CfS0ipbVhAmcL+uha2USG17CWOcIZVVHa6bHdj?=
 =?us-ascii?Q?lWUhokdacqRTVy8Ifk1X2V3FVH6iE5qKHxOOHTileuYLqSQfaWKggjYVCAYm?=
 =?us-ascii?Q?fj2MClel7KjOY+r3xuCLh3gTWS36Qo7tK20XCNiT9+VluoMLH808SNAm9Jfr?=
 =?us-ascii?Q?sAtwMG51ocCXtnRiP2Q0jFA3QnXNbO3d04shozxjll33DBDk/GEYzyDdBHZ5?=
 =?us-ascii?Q?V0E5Ki1L0/P6k9M6LqS84CyZGlbjvh/T+7arJpcDiu6sW9hNDr8cUmGrrnFs?=
 =?us-ascii?Q?MvicpcCbVfuCka2QIQcp6C3Cmn2WogQOSBy09VE7mqBgjVqZDVdVIWprPiHJ?=
 =?us-ascii?Q?E/kTTVS4K+3+rylOC+tvFm8hHSzdfVY+u0thlvx8vmb77mkY6hFhrQrg69y5?=
 =?us-ascii?Q?/9W7X9UtSHkE+UHSrTGhdx2VY8/X/Jcz7bJsb/bAYK1lEKxebn9PibsFQn3J?=
 =?us-ascii?Q?uqXPrZzPwmqqKbjHIMc+CfcIXYmLPj8yRg8O+1rY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zNUIcg0GaJGRLrADjDJfUXs4zX96H1ZIsguEw7SCFKrAe1HfTIpTPQQU+WN7cL1b7jGl8nJJYsH5fzW21/HXnDsPpNwNFRFHCex4YUKe4bZUCvMCu76T5ELki25cgim+RmwV5cqTyey2X9Mlduq5/MJj1uYd1aCbUXh2fToEvheZrv+PWguRU2oiCC4bI5CQEQyG00uLAg/I6oqsLMGa5S/3bWsn9ITr7v2XJp+5Df+bhFNj3PCiLxdXG9e/neYd5E0h3K/gXPx6lVUxX9/lgheeZ3556IxUHCo7U8x6pW1zlVXLDNMqOfW0V7wmbgGRFczJRuCQcp8tMWkOyXUo6CJGF3s2GKhSIjg9p4OQ7jDRAeLF0wh9Gj8k0eZ2jpgQZ0oeG6Y8jDWwif1OTIxRe+udOU+4M6kQ48Hayh/9sDQvjos2vxIdmpeG4xID2sS9GcNMIKF7jx5pV5xMhAh81PBcV1UYh4WO5h7ZT6TNJxkOvNDWLWp+ubxsaQatfEBhN34RZ7k72lUgj8R7YtKGEm4DQOX4cjlR2VFQlgWUkKeLIzrpd9IAtfKNG6f3CcpAQa0k0CY5oFmxiLP1tgX2UzI3/wcZGNq/uuN1bw0Qvtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9705fb2-5e77-41f9-fb46-08dcc7988616
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:35:08.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYhZn0QYi89EK7bh3lmrwHPqXlHgvTkZ5RWsqr1CSEZNhiTVPqpcRQ9QAzzRzX8nG0FWEHZK0FMpiYgbtQfFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280142
X-Proofpoint-GUID: AhaECns4bXIk1KsCmc_BdlU3EAFCfwoo
X-Proofpoint-ORIG-GUID: AhaECns4bXIk1KsCmc_BdlU3EAFCfwoo

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> Rather than passing around huge numbers of parameters to numerous helper
> functions, abstract them into a single struct that we thread through the
> operation, the vma_merge_struct ('vmg').
> 
> Adjust vma_merge() and vma_modify() to accept this parameter, as well as
> predicate functions can_vma_merge_before(), can_vma_merge_after(), and the
> vma_modify_...() helper functions.
> 
> Also introduce VMG_STATE() and VMG_VMA_STATE() helper macros to allow for
> easy vmg declaration.
> 
> We additionally remove the requirement that vma_merge() is passed a VMA
> object representing the candidate new VMA. Previously it used this to
> obtain the mm_struct, file and anon_vma properties of the proposed range (a
> rather confusing state of affairs), which are now provided by the vmg
> directly.
> 
> We also remove the pgoff calculation previously performed vma_modify(), and
> instead calculate this in VMG_VMA_STATE() via the vma_pgoff_offset()
> helper.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Some small things..

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c               |  77 ++++++++-------
>  mm/vma.c                | 209 ++++++++++++++++++++++++----------------
>  mm/vma.h                | 128 ++++++++++++++----------
>  tools/testing/vma/vma.c |  43 +--------
>  4 files changed, 249 insertions(+), 208 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e495b0381265..4066c0444495 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1373,9 +1373,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long end = addr + len;
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
> -	pgoff_t vm_pgoff;
>  	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> +
> +	vmg.file = file;
>  

Extra whitespace here.

>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
> @@ -1388,12 +1390,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>  			return -ENOMEM;
>  
> -		next = vms.next;
> -		prev = vms.prev;
> +		next = vmg.next = vms.next;
> +		prev = vmg.prev = vms.prev;
>  		vma = NULL;
>  	} else {
> -		next = vma_next(&vmi);
> -		prev = vma_prev(&vmi);
> +		next = vmg.next = vma_next(&vmi);
> +		prev = vmg.prev = vma_prev(&vmi);
>  		if (prev)
>  			vma_iter_next_range(&vmi);
>  	}
> @@ -1413,6 +1415,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
> +		vmg.flags = vm_flags;
>  	}
>  
>  	if (vm_flags & VM_SPECIAL)
> @@ -1421,28 +1424,31 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
>  	if (next && next->vm_start == end && !vma_policy(next) &&
> -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> -				 NULL_VM_UFFD_CTX, NULL)) {
> +	    can_vma_merge_before(&vmg)) {
>  		merge_end = next->vm_end;
>  		vma = next;
> -		vm_pgoff = next->vm_pgoff - pglen;
> +		vmg.pgoff = next->vm_pgoff - pglen;
> +		/*
> +		 * We set this here so if we will merge with the previous VMA in
> +		 * the code below, can_vma_merge_after() ensures anon_vma
> +		 * compatibility between prev and next.
> +		 */
> +		vmg.anon_vma = vma->anon_vma;
> +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
>  	}
>  
>  	/* Check prev */
>  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> -				       NULL_VM_UFFD_CTX, NULL))) {
> +	    can_vma_merge_after(&vmg)) {
>  		merge_start = prev->vm_start;
>  		vma = prev;
> -		vm_pgoff = prev->vm_pgoff;
> +		vmg.pgoff = prev->vm_pgoff;
>  		vma_prev(&vmi); /* Equivalent to going to the previous range */
>  	}
>  
>  	if (vma) {
>  		/* Actually expand, if possible */
> -		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> +		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
>  			khugepaged_enter_vma(vma, vm_flags);
>  			goto expanded;
>  		}
> @@ -1772,26 +1778,29 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Expand the existing vma if possible; Note that singular lists do not
>  	 * occur after forking, so the expand will only happen on new VMAs.
>  	 */
> -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> -	    can_vma_merge_after(vma, flags, NULL, NULL,
> -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> -		vma_iter_config(vmi, vma->vm_start, addr + len);
> -		if (vma_iter_prealloc(vmi, vma))
> -			goto unacct_fail;
> -
> -		vma_start_write(vma);
> -
> -		init_vma_prep(&vp, vma);
> -		vma_prepare(&vp);
> -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -		vma->vm_end = addr + len;
> -		vm_flags_set(vma, VM_SOFTDIRTY);
> -		vma_iter_store(vmi, vma);
> -
> -		vma_complete(&vp, vmi, mm);
> -		validate_mm(mm);
> -		khugepaged_enter_vma(vma, flags);
> -		goto out;
> +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> +		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
> +
> +		vmg.prev = vma;
> +		if (can_vma_merge_after(&vmg)) {
> +			vma_iter_config(vmi, vma->vm_start, addr + len);
> +			if (vma_iter_prealloc(vmi, vma))
> +				goto unacct_fail;
> +
> +			vma_start_write(vma);
> +
> +			init_vma_prep(&vp, vma);
> +			vma_prepare(&vp);
> +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> +			vma->vm_end = addr + len;
> +			vm_flags_set(vma, VM_SOFTDIRTY);
> +			vma_iter_store(vmi, vma);
> +
> +			vma_complete(&vp, vmi, mm);
> +			validate_mm(mm);
> +			khugepaged_enter_vma(vma, flags);
> +			goto out;
> +		}
>  	}
>  
>  	if (vma)
> diff --git a/mm/vma.c b/mm/vma.c
> index e5a5e418c7cb..74c627ff0313 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,16 +7,18 @@
>  #include "vma_internal.h"
>  #include "vma.h"
>  
> -/*
> - * If the vma has a ->close operation then the driver probably needs to release
> - * per-vma resources, so we don't attempt to merge those if the caller indicates
> - * the current vma may be removed as part of the merge.
> - */
> -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> -		struct file *file, unsigned long vm_flags,
> -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name, bool may_remove_vma)
> +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
>  {
> +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> +	/*
> +	 * If the vma has a ->close operation then the driver probably needs to
> +	 * release per-vma resources, so we don't attempt to merge those if the
> +	 * caller indicates the current vma may be removed as part of the merge,
> +	 * which is the case if we are attempting to merge the next VMA into
> +	 * this one.
> +	 */
> +	bool may_remove_vma = merge_next;
> +
>  	/*
>  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
>  	 * match the flags but dirty bit -- the caller should mark
> @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
>  	 * the kernel to generate new VMAs when old one could be
>  	 * extended instead.
>  	 */
> -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
>  		return false;
> -	if (vma->vm_file != file)
> +	if (vma->vm_file != vmg->file)
>  		return false;
>  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
>  		return false;
> -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
>  		return false;
> -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
>  		return false;
>  	return true;
>  }
> @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
>   * We assume the vma may be removed as part of the merge.
>   */
>  bool
> -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +can_vma_merge_before(struct vma_merge_struct *vmg)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> -		if (vma->vm_pgoff == vm_pgoff)
> +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> +
> +	if (is_mergeable_vma(vmg, true) &&
> +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
>  			return true;
>  	}
> +
>  	return false;
>  }
>  
> @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
>   *
>   * We assume that vma is not removed as part of the merge.
>   */
> -bool
> -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> -		pgoff_t vm_pglen;
> -
> -		vm_pglen = vma_pages(vma);
> -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> +	if (is_mergeable_vma(vmg, false) &&

I started putting /* merge_next = */ false, so that it's easier to read.
Not a whole lot of arguments, but it is still useful to remember what is
passed.

> +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
>  			return true;
>  	}
>  	return false;
> @@ -1022,16 +1017,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>   * **** is not represented - it will be merged and the vma containing the
>   *      area is returned, or the function will return NULL
>   */
> -static struct vm_area_struct
> -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -	   struct anon_vma_name *anon_name)
> +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  {
> -	struct mm_struct *mm = src->vm_mm;
> -	struct anon_vma *anon_vma = src->anon_vma;
> -	struct file *file = src->vm_file;
> +	struct mm_struct *mm = vmg->mm;
> +	struct vm_area_struct *prev = vmg->prev;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
> @@ -1041,16 +1030,18 @@ static struct vm_area_struct
>  	bool merge_prev = false;
>  	bool merge_next = false;
>  	bool vma_expanded = false;
> +	unsigned long addr = vmg->start;
> +	unsigned long end = vmg->end;
>  	unsigned long vma_start = addr;
>  	unsigned long vma_end = end;
> -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> +	pgoff_t pglen = PHYS_PFN(end - addr);
>  	long adj_start = 0;
>  
>  	/*
>  	 * We later require that vma->vm_flags == vm_flags,
>  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
>  	 */
> -	if (vm_flags & VM_SPECIAL)
> +	if (vmg->flags & VM_SPECIAL)
>  		return NULL;
>  
>  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> @@ -1058,27 +1049,26 @@ static struct vm_area_struct
>  
>  	if (!curr ||			/* cases 1 - 4 */
>  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> -		next = vma_lookup(mm, end);
> +		next = vmg->next = vma_lookup(mm, end);
>  	else
> -		next = NULL;		/* case 5 */
> +		next = vmg->next = NULL;	/* case 5 */
>  
>  	if (prev) {
>  		vma_start = prev->vm_start;
>  		vma_pgoff = prev->vm_pgoff;
>  
>  		/* Can we merge the predecessor? */
> -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> -					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> +		    && can_vma_merge_after(vmg)) {
> +
>  			merge_prev = true;
> -			vma_prev(vmi);
> +			vma_prev(vmg->vmi);
>  		}
>  	}
>  
>  	/* Can we merge the successor? */
> -	if (next && mpol_equal(policy, vma_policy(next)) &&
> -	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
> -				 vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> +	    can_vma_merge_before(vmg)) {
>  		merge_next = true;
>  	}
>  
> @@ -1129,7 +1119,7 @@ static struct vm_area_struct
>  				remove = curr;
>  			} else {			/* case 5 */
>  				adjust = curr;
> -				adj_start = (end - curr->vm_start);
> +				adj_start = end - curr->vm_start;

unnecessary change, if you respin.. but it's temporary.

>  			}
>  			if (!err)
>  				err = dup_anon_vma(prev, curr, &anon_dup);
> @@ -1169,13 +1159,13 @@ static struct vm_area_struct
>  		vma_expanded = true;
>  
>  	if (vma_expanded) {
> -		vma_iter_config(vmi, vma_start, vma_end);
> +		vma_iter_config(vmg->vmi, vma_start, vma_end);
>  	} else {
> -		vma_iter_config(vmi, adjust->vm_start + adj_start,
> +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
>  				adjust->vm_end);
>  	}
>  
> -	if (vma_iter_prealloc(vmi, vma))
> +	if (vma_iter_prealloc(vmg->vmi, vma))
>  		goto prealloc_fail;
>  
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> @@ -1187,20 +1177,20 @@ static struct vm_area_struct
>  	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
>  
>  	if (vma_expanded)
> -		vma_iter_store(vmi, vma);
> +		vma_iter_store(vmg->vmi, vma);
>  
>  	if (adj_start) {
>  		adjust->vm_start += adj_start;
>  		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
>  		if (adj_start < 0) {
>  			WARN_ON(vma_expanded);
> -			vma_iter_store(vmi, next);
> +			vma_iter_store(vmg->vmi, next);
>  		}
>  	}
>  
> -	vma_complete(&vp, vmi, mm);
> +	vma_complete(&vp, vmg->vmi, mm);
>  	validate_mm(mm);
> -	khugepaged_enter_vma(res, vm_flags);
> +	khugepaged_enter_vma(res, vmg->flags);
>  	return res;
>  
>  prealloc_fail:
> @@ -1208,8 +1198,8 @@ static struct vm_area_struct
>  		unlink_anon_vmas(anon_dup);
>  
>  anon_vma_fail:
> -	vma_iter_set(vmi, addr);
> -	vma_iter_load(vmi);
> +	vma_iter_set(vmg->vmi, addr);
> +	vma_iter_load(vmg->vmi);
>  	return NULL;
>  }
>  
> @@ -1226,32 +1216,27 @@ static struct vm_area_struct
>   * The function returns either the merged VMA, the original VMA if a split was
>   * required instead, or an error if the split failed.
>   */
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name)
> +static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> +	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *merged;
>  
> -	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> -			   pgoff, policy, uffd_ctx, anon_name);
> +	/* First, try to merge. */
> +	merged = vma_merge(vmg);
>  	if (merged)
>  		return merged;
>  
> -	if (vma->vm_start < start) {
> -		int err = split_vma(vmi, vma, start, 1);
> +	/* Split any preceding portion of the VMA. */
> +	if (vma->vm_start < vmg->start) {
> +		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
>  
>  		if (err)
>  			return ERR_PTR(err);
>  	}
>  
> -	if (vma->vm_end > end) {
> -		int err = split_vma(vmi, vma, end, 0);
> +	/* Split any trailing portion of the VMA. */
> +	if (vma->vm_end > vmg->end) {
> +		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
>  
>  		if (err)
>  			return ERR_PTR(err);
> @@ -1260,6 +1245,65 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
>  	return vma;
>  }
>  
> +struct vm_area_struct *vma_modify_flags(
> +	struct vma_iterator *vmi, struct vm_area_struct *prev,
> +	struct vm_area_struct *vma, unsigned long start, unsigned long end,
> +	unsigned long new_flags)
> +{
> +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> +
> +	vmg.flags = new_flags;
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_name(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       unsigned long new_flags,
> +		       struct anon_vma_name *new_name)
> +{
> +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> +
> +	vmg.flags = new_flags;
> +	vmg.anon_name = new_name;
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_policy(struct vma_iterator *vmi,
> +		   struct vm_area_struct *prev,
> +		   struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   struct mempolicy *new_pol)
> +{
> +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> +
> +	vmg.policy = new_pol;
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end,
> +		       unsigned long new_flags,
> +		       struct vm_userfaultfd_ctx new_ctx)
> +{
> +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> +
> +	vmg.flags = new_flags;
> +	vmg.uffd_ctx = new_ctx;
> +
> +	return vma_modify(&vmg);
> +}
> +
>  /*
>   * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
>   * must ensure that [start, end) does not overlap any existing VMA.
> @@ -1269,8 +1313,11 @@ struct vm_area_struct
>  		   struct vm_area_struct *vma, unsigned long start,
>  		   unsigned long end, pgoff_t pgoff)
>  {
> -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> +
> +	vmg.pgoff = pgoff;
> +
> +	return vma_merge(&vmg);
>  }
>  
>  /*
> @@ -1281,12 +1328,10 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					struct vm_area_struct *vma,
>  					unsigned long delta)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> +	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
>  
>  	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> -			 vma->vm_flags, pgoff, vma_policy(vma),
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	return vma_merge(&vmg);
>  }

Many of these are small and can be static inline, some (all?) in the
header.

>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> diff --git a/mm/vma.h b/mm/vma.h
> index c774642697a0..9060a1a1edfa 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -52,6 +52,59 @@ struct vma_munmap_struct {
>  	unsigned long data_vm;
>  };
>  
> +/* Represents a VMA merge operation. */
> +struct vma_merge_struct {
> +	struct mm_struct *mm;
> +	struct vma_iterator *vmi;
> +	pgoff_t pgoff;
> +	struct vm_area_struct *prev;
> +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> +	unsigned long start;
> +	unsigned long end;
> +	unsigned long flags;
> +	struct file *file;
> +	struct anon_vma *anon_vma;
> +	struct mempolicy *policy;
> +	struct vm_userfaultfd_ctx uffd_ctx;
> +	struct anon_vma_name *anon_name;
> +};
> +
> +/* Assumes addr >= vma->vm_start. */
> +static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
> +				       unsigned long addr)
> +{
> +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> +}
> +
> +#define VMG_STATE(name, mm_, vmi_, start_, end_, flags_, pgoff_)	\
> +	struct vma_merge_struct name = {				\
> +		.mm = mm_,						\
> +		.vmi = vmi_,						\
> +		.start = start_,					\
> +		.end = end_,						\
> +		.flags = flags_,					\
> +		.pgoff = pgoff_,					\
> +	}
> +
> +#define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
> +	struct vma_merge_struct name = {			\
> +		.mm = vma_->vm_mm,				\
> +		.vmi = vmi_,					\
> +		.prev = prev_,					\
> +		.next = NULL,					\
> +		.vma = vma_,					\
> +		.start = start_,				\
> +		.end = end_,					\
> +		.flags = vma_->vm_flags,			\
> +		.pgoff = vma_pgoff_offset(vma_, start_),	\
> +		.file = vma_->vm_file,				\
> +		.anon_vma = vma_->anon_vma,			\
> +		.policy = vma_policy(vma_),			\
> +		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
> +		.anon_name = anon_vma_name(vma_),		\
> +	}
> +
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
>  void validate_mm(struct mm_struct *mm);
>  #else
> @@ -208,80 +261,53 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>  
> -/* Required by mmap_region(). */
> -bool
> -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name);
> -
> -/* Required by mmap_region() and do_brk_flags(). */
> -bool
> -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name);
> -
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name);
> +/*
> + * Can we merge the VMA described by vmg into the following VMA vmg->next?
> + *
> + * Required by mmap_region().
> + */
> +bool can_vma_merge_before(struct vma_merge_struct *vmg);
> +
> +/*
> + * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> + *
> + * Required by mmap_region() and do_brk_flags().
> + */
> +bool can_vma_merge_after(struct vma_merge_struct *vmg);
>  
>  /* We are about to modify the VMA's flags. */
> -static inline struct vm_area_struct
> -*vma_modify_flags(struct vma_iterator *vmi,
> -		  struct vm_area_struct *prev,
> -		  struct vm_area_struct *vma,
> -		  unsigned long start, unsigned long end,
> -		  unsigned long new_flags)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> -			  anon_vma_name(vma));
> -}
> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags);

Does this get better with two tab indent?

>  
>  /* We are about to modify the VMA's flags and/or anon_name. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_flags_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start,
>  		       unsigned long end,
>  		       unsigned long new_flags,
> -		       struct anon_vma_name *new_name)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> -}
> +		       struct anon_vma_name *new_name);
>  
>  /* We are about to modify the VMA's memory policy. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_policy(struct vma_iterator *vmi,
>  		   struct vm_area_struct *prev,
>  		   struct vm_area_struct *vma,
>  		   unsigned long start, unsigned long end,
> -		   struct mempolicy *new_pol)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -}
> +		   struct mempolicy *new_pol);
>  
>  /* We are about to modify the VMA's flags and/or uffd context. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_flags_uffd(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start, unsigned long end,
>  		       unsigned long new_flags,
> -		       struct vm_userfaultfd_ctx new_ctx)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> -}
> +		       struct vm_userfaultfd_ctx new_ctx);
>  
>  struct vm_area_struct
>  *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 9b272633ca9e..b12f72979478 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -22,26 +22,6 @@ static bool fail_prealloc;
>   */
>  #include "../../../mm/vma.c"
>  
> -/*
> - * Temporarily forward-ported from a future in which vmg's are used for merging.

the future is soon.

> - */
> -struct vma_merge_struct {
> -	struct mm_struct *mm;
> -	struct vma_iterator *vmi;
> -	pgoff_t pgoff;
> -	struct vm_area_struct *prev;
> -	struct vm_area_struct *next; /* Modified by vma_merge(). */
> -	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> -	unsigned long start;
> -	unsigned long end;
> -	unsigned long flags;
> -	struct file *file;
> -	struct anon_vma *anon_vma;
> -	struct mempolicy *policy;
> -	struct vm_userfaultfd_ctx uffd_ctx;
> -	struct anon_vma_name *anon_name;
> -};
> -
>  const struct vm_operations_struct vma_dummy_vm_ops;
>  static struct anon_vma dummy_anon_vma;
>  
> @@ -115,14 +95,6 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  /* Helper function which provides a wrapper around a merge new VMA operation. */
>  static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  {
> -	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
> -	struct vm_area_struct dummy = {
> -		.vm_mm = vmg->mm,
> -		.vm_flags = vmg->flags,
> -		.anon_vma = vmg->anon_vma,
> -		.vm_file = vmg->file,
> -	};
> -
>  	/*
>  	 * For convenience, get prev and next VMAs. Which the new VMA operation
>  	 * requires.
> @@ -131,8 +103,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  	vmg->prev = vma_prev(vmg->vmi);
>  
>  	vma_iter_set(vmg->vmi, vmg->start);
> -	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
> -				 vmg->end, vmg->pgoff);
> +	return vma_merge(vmg);
>  }
>  
>  /*
> @@ -141,17 +112,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>   */
>  static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
>  {
> -	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
> -	struct vm_area_struct dummy = {
> -		.vm_mm = vmg->mm,
> -		.vm_flags = vmg->flags,
> -		.anon_vma = vmg->anon_vma,
> -		.vm_file = vmg->file,
> -	};
> -
> -	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
> -			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
> -			 vmg->anon_name);
> +	return vma_merge(vmg);
>  }
>  
>  /*
> -- 
> 2.46.0
> 

