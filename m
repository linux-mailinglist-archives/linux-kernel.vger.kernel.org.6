Return-Path: <linux-kernel+bounces-513775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED0A34E86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AA916D0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0F245B14;
	Thu, 13 Feb 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c/0II1cg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MDiTluhb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5928A2CE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475466; cv=fail; b=cAQmhAI89Tduc45x6gwgv+hi0JHvasxk24K/wYDKktj98aXi3onudHtSGOLd6ESWOIL8ifDw7cr3LC3mKi84vVzFLYstmVZ38e7T/egY7QJMgDzuH2HQLusoHYaX52UpG0NluJaDpROvBVE1I7I8F0XIKJ6jrJPX5tlc7VpDgL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475466; c=relaxed/simple;
	bh=y9FuDfH+Lria+1zcjv9qEE4PqTwLuluQOCjZiMWgVMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z4ytTqC6px4H0Nu3Km2msrAXDeZOXJfQb/4pnxv9JzPP7G7dM9pV59vbHHYZBHU2lBmDbKrthY6RKwVHagSbkzAaglzTLLrBsHNv/zZylU2tPj6oqrMZuDFpx5ITKqs9lrFkeFeBQFe8ClA8hnIfAxILRznra7BeKstY2xbyxmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c/0II1cg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MDiTluhb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfhuD015319;
	Thu, 13 Feb 2025 19:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=H3pCqc6WCvjil0lAUN
	sfJdX8vl8hygF+8V0VMOiXifs=; b=c/0II1cg8n+EmLDHEwqj3YAvYxIynjVJBc
	mOE2jsacjVfa08oUoPTPhH3mXysM/fykKZciZxdWDJ3F/aKVAmedpM29lYm6carj
	h+pWm4MBwGtqq+WhUi9xe83AOjeMbPMccSJ93yYUOl/o/j5ZEUuNgnJ/p1sjr8/4
	QRe3kw64FZaZeHUCU9Z3FsPzMD6XSv4pM8LqrhkBR7Aj0W1ZitwhD7GwjfI4B6cQ
	+gqK9E6fPMtjnd14u5Q5bDcdiAPPVskFhmUueTs8sP0EynqQHLC8bYMA1fNzZWmG
	lxKBwnptphtQzg9jEJvU+3j8SIWK3yleW0ipfmugCvkaYpTla9sg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4a9bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:37:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIenJG017558;
	Thu, 13 Feb 2025 19:37:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqjgvbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNjtdai6pmctaYPb/V5Sa0fsXsGIAR5OwYbSRd1mI2TKNEJ7zexyhfc7NvBd6aPVR5MeJoMYtuVg1a1GPMvNzcQfLv25MbkM0kQ+z2BP6WUdoSUateOOM28i0WypFzl88KAuWSU9kLbDunCmMhQOUIcyT1MJjHfiwHbb0qpIung/MHZAJ8qVvaciEhU+qtuEz5Tet6CjPN/4i2jSzN053JI7iPIMJZIfHoMKHFNRCMYtjgss5pctsyqn0id5pS42Y6VT3qOsBCVYANaK+XAGz1KyKVhoW6WTjROJaKHFWNwFA3J6HgvDwhHpBsnYEo9f/3qPftX6hk4kABmEWtb0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3pCqc6WCvjil0lAUNsfJdX8vl8hygF+8V0VMOiXifs=;
 b=Whb0YcdZJhY8f4jxgSXHZOjyCdOP+Fk2bBFyi+zMcuQF+9qEcfgPxHNhf0EOIIwesUJA/uYV16V4vAyWs7qcUubWYUO7UFJT5QPsgZsQH7kmrmYva09u1NQHgnZb+99IVLfYLCE1xaOcea/zNndSiiJ6gFx82Am47WMb5h4oylRVrmcFJT7WAaKSBjh7+zpc7KipRGVzz7cOZDKQ7i9P8U10VzUFZo0hXHVkqndeJz3d6lCfZ75TPcK7n/zDMDL4/N0IPn+vgRNLVwn0FN7VXu9M5iJ56Lle1gmgbofVNulyP49Y2E2OSj4f4pibeyL685C0+Z3Oi6BP97pKj3fatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3pCqc6WCvjil0lAUNsfJdX8vl8hygF+8V0VMOiXifs=;
 b=MDiTluhbwli8+ccnjtKTQUN8XQP47VSBZKjD40lXjqa6f64rFWnyEEWb9y89dKmpPOfhm29XzU6Ii3h6+PhQ/SRqlKBYyuipodqGuU5CezQ+TSVGQKQC7xHr8Fm00oWv/ywGgCsrkR/2idgPryhi2TUemlgyncKIYNZqPnrsRNs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:37:31 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 19:37:31 +0000
Date: Thu, 13 Feb 2025 14:37:28 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
        "open list:MAPLE TREE" <linux-mm@kvack.org>,
        "open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Remove a BUG_ON() in mas_alloc_nodes()
Message-ID: <2asqgre2rmhe57zo2w446s5ohk2psqmvqkpthyfujoc3klylqf@wcayx3xqnzqk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MAPLE TREE" <maple-tree@lists.infradead.org>, "open list:MAPLE TREE" <linux-mm@kvack.org>, 
	"open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>
References: <20250213114453.1078318-1-ptesarik@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213114453.1078318-1-ptesarik@suse.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae0d5fa-2659-44ec-55aa-08dd4c65db27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dLP5wK9Nn4b2gHPdh/EcNu8j+6P7O2T5NFi93iEEA3VEhOOuysLShdNJQUAD?=
 =?us-ascii?Q?8IGiOHD+zKIQQBOMPl5u+TNQ4dYyZsjtC22ERfMhZ6ENxghFXOcQf+zkJ/2F?=
 =?us-ascii?Q?xIUDvdKVy9XZMcPv127S/B7Ygt0TaLMW8If3S+Lcwph3hBQRXvwXDi3Exf6R?=
 =?us-ascii?Q?cMrI8OgyzRVnFmFJz3jzXGv6nggzCDQDeofAqnbvHNIBrCPF2T/Dtv5BIXBV?=
 =?us-ascii?Q?+WSYV65lZJXBaZpU7m8+4vCvhzJvwi3e2kPO6cej4RtzS5gQVFfQXKm2HOL7?=
 =?us-ascii?Q?cDxlC/J038fDwYOzalgqGTMCxlAVDFpcEL0TVhOmnuAaRdt0i5UPUjFVzJ1b?=
 =?us-ascii?Q?T/daaap8Xp2VVpdukSpMmNYqsI2M7ERM0AIKV/MX2ohfVuqmfhRsmA+LrKN4?=
 =?us-ascii?Q?bPb5+eXvPiBXg8wry7k2mnOW8QSMVR39GuegVZfq4vivBdM6LalnZ0TF86yQ?=
 =?us-ascii?Q?oqxXLRwn+g77ukAiWuIIYqebU8RVaGlpTDUbSn/rXWzsL7xPixSrtqdcF08u?=
 =?us-ascii?Q?hWBcczdA6I9UjEZd2PBbZNTDHY0uXSI0Xm13B45IdDC1VbEvnMLr/ZStQ0xr?=
 =?us-ascii?Q?WvVEdkFuAauhDmmZA8oDcn1cgsarE3heLEg7N9rrX7AF/GKqdQMRE8YcNo4I?=
 =?us-ascii?Q?imJJFzXA5kW7wMbVmPqrDjidRB9TqvJjBfcl8e69AJ8aWve3A0vtTQyjbSf8?=
 =?us-ascii?Q?Bi11g1MJgWQd5ecd53yh3jNE3O3TS23jOZTX4/f3WJP8r0+cQBpYvlefvMYg?=
 =?us-ascii?Q?6U7nShnJoKbaYKkTtU34xhDh1Xh5JHX4sTugVHg5GgAH9b0vgJF0VGWYxZFY?=
 =?us-ascii?Q?WFe5pXGlWVxi4Rqc3lFsfNRKQYeATTujlRCBl0iCkvb0FBQWzj19dCc+wzid?=
 =?us-ascii?Q?oi3pZwrI4KPqaP208HDuSPZ6Bsnml5V/fJlRg3nuFKcbITOhH0+5ObLI2jhe?=
 =?us-ascii?Q?o3ABCdckLP6DR15UuaVPoosTdgQlo71XriRQMT7asGcgpDxx/2fsAGFFIZLV?=
 =?us-ascii?Q?uH9PUaikaNrQXi18Jh04MbEzI1nrKCDLYoSbWPWNBx7Rpflfa/Qyeg7zI1v6?=
 =?us-ascii?Q?RGVxDafmWTnfSH+Xy6B62v9vcT0CdHw39n8pzHAc3RxxI6h6eie/ulBoo019?=
 =?us-ascii?Q?FGRRzk6tQ0nJGQQ0SYi0zz5e7v+5rfDtW5BV+2WFN/hVEW9xCWwX0KbKKvnu?=
 =?us-ascii?Q?Wilj1XJN0hRLJvpSRPA7DbsAg37kAJF7qIQ11n13zi0EC1KYTY/fMxQ5Wpdr?=
 =?us-ascii?Q?8EQtSyH6cYrOVAQT3LJrJiylNJZI05iPivf1r0h5Q66wBr+Az4pJdfG9czM1?=
 =?us-ascii?Q?cA7JzHQdMA+DAoYm0mVxtSuouZKRond1Wqa0gN5LO3Mpvv/xaEx/gx0ive8I?=
 =?us-ascii?Q?yXWAAEKL/azIjC0TM7I27FY5GbvT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FiDtPePJgatruvN4PJLVt18EPbkAe5AU3ChsX4YfSZOWqxF8Sn8E/gJoVcr5?=
 =?us-ascii?Q?hMXO0tbyp8Ku+MGzBqeZtJl6Rgdkzcg5ChUGQakRgWJncG0zOOE+v7qC7XeK?=
 =?us-ascii?Q?CtWOwTTTDLRi6a0bFYkrnTW5MoU3W2ooxzXqQGiewYq30BJY4/QtpAHBHpdm?=
 =?us-ascii?Q?RIqelFCPGpr8h6gtOeqxxDrwIDxgaX+Nu9VwDVJFcG5kwUlUEamf1d378E1O?=
 =?us-ascii?Q?SwLhB+y8ToVlITQcWwz7NciQf3hiFih1TbYWfAhRhRGlhL+TfzIcWJZkEySn?=
 =?us-ascii?Q?1HCvMKWK1RpW7XwdRMGgOc61ZkZU/6iGNzHQoarPc7PU1C1+fIEabRyITHLd?=
 =?us-ascii?Q?hLd9RAHd87OP3uvyKNXrguZvDdo0Bci5swvUHv+d4TLULMa+/Hl5E7H+DNzh?=
 =?us-ascii?Q?OEsklscwcaGPi1y9rFwbbvvCqLhG2iTV7hojFa5napyFshQBaUt9q/SACkE3?=
 =?us-ascii?Q?wrsR4AiyBkM36DkvT7CMKHSL5hSZAbt9p8QrHTu8KQFzmt6ToZBlbpQ/euUQ?=
 =?us-ascii?Q?Uo3z8c1tQXJuLLgAfHV+nHhLrk3MKwhXu56Ineh2AXrOA1dO4V1sVx5t8b1T?=
 =?us-ascii?Q?utv+vPYnNBzwpyizH1MYVlFBuCagHUoat+0JNMPkvDj2WYcNxaG+LsXaz7ie?=
 =?us-ascii?Q?akX0qIt+TxzCeAVKGWvahw0w9nGNKHprC0JJZBY1Ink9d3hc+eKakXPmPwzX?=
 =?us-ascii?Q?WjdH9RpVyk/HiAJhoUwXlxFpMomG4N2r65YREoEbqEa92gKXz8z4pIuu87Av?=
 =?us-ascii?Q?+c4C3bAxr2Kz03749naPtwgR8qsQo3H7yh9Otv+fv26lUz1k/YfBgi1yJxG9?=
 =?us-ascii?Q?Sz+eE2fUf0m9FxMvMMAigCD+DUB4fxD1lvPnoAxQ1ulzsXP0S9+31S2OH8zS?=
 =?us-ascii?Q?hVN4yOuMGLb6voDoiqvkKPLApPnxUgHBsCb2Pygz2wCx5bEFFWY2XF4A2Wht?=
 =?us-ascii?Q?59ez5FTJOJ+4Sf5VhyU6hsn1xZEM2b1XvObMqmw5E6kH5oDYYYhN7fyZCSau?=
 =?us-ascii?Q?xp0mTpwVx4Zd7Yp7iJrfAb2VoKBARXvajmCyejhQS2oeUuq7Pk65k8w4lS8I?=
 =?us-ascii?Q?hMurcxndxy5ssoo/TmHQnpfcJhAPvu5RjR9ewN1W/QLyfLd5S3zWxVm9uh10?=
 =?us-ascii?Q?+kRF5nIe/uUGDCjvxWc5Pt1uQHIdxGc0ByFsXP2FQfe7SuwNXVVGRhJ3FFlB?=
 =?us-ascii?Q?F3akogJF8UTqzzb7N6IULWB3CaoUbBcxJ/dMNH53XeAGNMfD6fDGtZpgXa0d?=
 =?us-ascii?Q?2J5T7SMwvxCapzrdJhNtM8gjSz9ZB/CKfRE88NGvDMAFZJDDlKx1oRdaOiJv?=
 =?us-ascii?Q?ehwfMOF04XNJ22zZ3Vlqmm7EcMYKDufi3ANFhHCiap6V2KJ4TC7bJ4B7B3v5?=
 =?us-ascii?Q?1osm8S0rLDONrckajUf7rbx4CFRsPLyjxflRcFwOgTPVs8VJLkPYeYrfiFkG?=
 =?us-ascii?Q?GlrvJs2tWYIF4NXiv4XlZyz0Cg16HYfmd81+ERMJr/f5RQeAWdU4H4IhMTYo?=
 =?us-ascii?Q?b+6R+VA9JH4SdZv2fMAKpk4YZzOI19Oo4nmlvVOeePbRWjuh1yGWRQ1rn0WA?=
 =?us-ascii?Q?e9qLmJMu/8hwlurlp1QaMOqlHduF11Ks1tizJF81?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2YxQ2q1cW+STNaC8FXHQzkxmn/Zyarxaz2JMBGlTJ1cRmOr0WPdxzmdBUjPuXwAfxS9E4E0k8r3WmEDqgUhF0bYbv8S3sxpicQVOjHyDyishyr+K8Jc+pIPX6xQh4wkVEJz4c/aBzBujEwLtI2NK/vIvI0dA5FHJEkI5aS5hBroNk/OXYLLuCfQEh5CujoFYBtgQpJqkk8mmMYd+5ZaVgMBKQ4c3MQRTdY+555V+9UDdN1a8kP3YnpskUggj2e/oMX7q1WjPKeLQpfj0DBOz/sYw0HX1ay9S8keowDmtxY5+K97hBs3kNOn/UzU3QrlAJAi4aKMW242oyogyvdRa8MBSg3xElcffI3pS3Vl0HKk32KF4w4BjnULlxsCBHnJaNVu1atDbdCRhbzmIbwab0YMa/etJlq1qaFyRQGdcqu1IyyeC44eNXJR/5vTWNnNO3Nl3t5KJYL4P4+Jd8uYv1cSjj31OYzg5TnLpbdlPBnViXB7B85Tum1rMcTj1LkPofxrNW2hV90yzDyYWSSuXikOXgy20TPFALhQQlaXF/3GolAXXHo4uAJ2mXlQh/fz5cj4ZoejzavPgY2BJiBak9sPuFf+r/A6NzcW0iGQ4/hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae0d5fa-2659-44ec-55aa-08dd4c65db27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:37:31.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO7j25up3EOuez1IdGfJyEc1Q6CSo3CcDR6xGMxCE69rxntoQkjpeR53jercxoo8N3aC8hvJZFGxctTLDLm0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130138
X-Proofpoint-ORIG-GUID: rGMxmylRlMNRTizPQvsUm_RKCyk9oDDK
X-Proofpoint-GUID: rGMxmylRlMNRTizPQvsUm_RKCyk9oDDK

* Petr Tesarik <ptesarik@suse.com> [250213 06:45]:
> Remove a BUG_ON() right before a WARN_ON() with the same condition.
> 
> Calling WARN_ON() and BUG_ON() here is definitely wrong.  Since the goal is
> generally to remove BUG_ON() invocations from the kernel, keep only the
> WARN_ON().

Sure.. but this isn't going to have the end result of not crashing.  We
ran out of allocations so we will very quickly be dereferencing NULL.

Care has been taken to avoid this from happening, so I'm fine with
either as this comes up in testing only.  In fact, I probably added this
during the testing and it slipped through.  Thanks for finding it.

> 
> Fixes: 067311d33e65 ("maple_tree: separate ma_state node from status")
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>


> ---
>  lib/maple_tree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f7153ade1be5..0f2111d436c4 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1245,7 +1245,6 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  	if (mas->mas_flags & MA_STATE_PREALLOC) {
>  		if (allocated)
>  			return;
> -		BUG_ON(!allocated);
>  		WARN_ON(!allocated);
>  	}
>  
> -- 
> 2.48.1
> 

