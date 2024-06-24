Return-Path: <linux-kernel+bounces-227531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CA69152C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FC3280EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC019CD1C;
	Mon, 24 Jun 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cs2/oqGb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HNIIIfJX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AE19D88B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243846; cv=fail; b=bor5hy47tRxFOBCe4O8Bj3wbCv4/CLWnTD9Gw4deNd64C9Ps2H/M48GQW7oEs8IMRcac4xrl2FrcEX6Uj3S1mmRk86JwCJXr/S7fYYl7vA32VytNua1L8V+gOaotSk/vc9ddEud18edZifgmf/lRQOwV2ipjb50hUWNi+kshonQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243846; c=relaxed/simple;
	bh=If7Gom/xBQw5qEuhP7DGGcP04M8HaG6nj1p6G+LA+CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbymUEl6KUww2WoR8s8vHhlEGZ2e78jBBPTg2V5EooRWQ266nBdsSnzrMDMWWItL4QCZ+xa/37evQu6jHBAcy2+eL2PS5nHRgyyhqmQWOOfWWzbFWkd1lZSlMxwzovFJNu50KnGLjDrPMLMpz/nA1fgHN5Ru/KeOocafRq4zGWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cs2/oqGb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HNIIIfJX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtOpG021753;
	Mon, 24 Jun 2024 15:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nVesaP6hZjTBYyn
	/AVmOSYTqKhuRlf1O4rIBp6L7/wM=; b=Cs2/oqGbe+9fLaSGmUs18zBk7ePCLFO
	RZCriMTocqJcu00031rzQbj1l3R5kCWo4H8pRxkOGPt9x6O+Ipyf0IHAKcx17LUz
	FaYC1wo44caQgIk0rKtXdLJuXjY3ypDndDd5Kk8/Rc9q1l1lPeE9ErVKGwB8OPi7
	uHypEGx4vOGdHqDW0bFB81vvHWLCgsqY1mkmrnyT+f58fItjxzqhGEUsgR0rT9XL
	1hCA6cdI1FE3OJUfzV3ATQVplVdG+1iWP+NF72g4myejhcltDqlrEqkEEL4NMWdk
	8vWDcSa5ZNaNr+rS5dnBbpYtPCHveohVWLjfLh80OXt1TFB5i4YwjzA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc2xue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:43:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OEnCIZ023341;
	Mon, 24 Jun 2024 15:43:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2cmnru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKyLf7m+UfWVFeWS7HLOnMTINUNJiJifY1Kg+l1S47egATSLNTKSmgFPPgsDmohxHpxh/j9EEHlCcOTkEtv+DeAYMlpMiRb4u2xAYPsvEtaBW676lxruOmPfpT1CsbHToRtrZG8Rjwd+EKGaCr01eJdlaUZKlD2TGhpJA7EwNuQGKnM6df8b/yEXc9T9GlnswmF35HD6/ru3r1wFNdcLveucBLJLCDWdp6GJdSVGnFsG6TvuyApLbcXRC/9l5ZKjdrhMPkgCiSZFylDD3iyiWq3+R40STCuXsfQnVCJ9RongVurHM0STXpL0g3lubSlIb6xZdzfsf3SXz298p8/+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVesaP6hZjTBYyn/AVmOSYTqKhuRlf1O4rIBp6L7/wM=;
 b=XGk3Ymz1EQNBIcHg0iOY29LRK9CJHe2/SnAYGM8r1RvRNSqIAeJbKkkwOit1Q5eeM+RmiN0M8360Og9Rdw7IBLwrPqBfOSh3vr4NkNgzvIbqlaaxtDBaqScXg3eoib9NaG9KQ22JR+hJbd5hFgBVFe5+bdmsy/UL7APxyQabDZxuNcSxeUeajiSbq5sg+NzKUQ5OJAqY0AMuq9vOwua7SvzZC1Aj/pMCHDncDMcsXlpAkRUQ5VhaLTYpHLCRdcz7+EAspILfhHcXgtWv+E8K/PaB6eKGkBrhPjyUYgydcQhv9Wyqf9Rdo9xYT6/6KMNblMOWtt46d5/xvaAYKsWl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVesaP6hZjTBYyn/AVmOSYTqKhuRlf1O4rIBp6L7/wM=;
 b=HNIIIfJX7eIjwwQydH2A1w/1bWt2Qv4ZwxQtw7gCpDNDxhW9dC7W+/VYuQoOZ3d9gyL6vPfbI/s6yjGQO/j2a0YJ6auLGQ9OH5vy2KXzM4hdmmEMdKbyC2oix2HXVwkczVRSb79lm045jp8z4B3HSxusp5m3HBQ/NpbwPa9q7dA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:43:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:43:44 +0000
Date: Mon, 24 Jun 2024 11:43:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v3 00/16] Introduce a store type enum for the Maple tree
Message-ID: <oaimbp2onjag4u5dida73hu62aqcajf2siqtvdc4mxq6y2dylz@g6ik3a5gquu4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2a4462-329a-4923-552e-08dc94646db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8Wm8SohYMBk9e7bgewANioTb/8TH22PYibv0Qd0WSUmLuKo/GTpV332pqKnf?=
 =?us-ascii?Q?HBcoso+mJgFXxu0C9A1uzAEPMqsNIJceEd+j9bopTwsAYuGSh+gwNiVZXhZ1?=
 =?us-ascii?Q?bdMJqXMs3dfQIbKxRm9VpkFjl99qWhdaam+JwcjARLth1mazFPUf348TKoFV?=
 =?us-ascii?Q?kUrUIRQ4n/ILhOwXnAaE7bmyKaxiotBnEg+r5EWZEWn6bZouQYiW6bOvp5Sh?=
 =?us-ascii?Q?siRbQqt1lzIK0SsFVRxUuK7b7OYTUYfuBBLxcewQFtrxsCPxA4YbYb+VWDjV?=
 =?us-ascii?Q?zgdUa8mvPK8Y5WkQSg1Av3/Fy1S66YjaNlN8KhGBFrN5c1S4ysgKVpAgTTeK?=
 =?us-ascii?Q?J2K12JSTUP1FMs0shnqRwIg3LM1ro0IePzZhc1nrYvJc4MzS46ulA1ip6Z8L?=
 =?us-ascii?Q?BVmzlzDNcXd82nE13+oUr5hqN2qOT3jiRpIbwqotfJnlIAc8kSdQynuIRlcD?=
 =?us-ascii?Q?po8+D+jbf/E8mLkBd6I9zcmvyb8CgmNBCL7Sxm73wKzo7ZUZnhw0qTDc72SA?=
 =?us-ascii?Q?qEYmK3+jDxdbV1UhKhlzKHE8uI0DpZ9Eselyv+86PoWKx7aZYoGd/WgLcfMT?=
 =?us-ascii?Q?od124yhxuogzdCUghp9zTmwr6+n4jWi90V5swlLkRegX/v8efStL6iI7sevg?=
 =?us-ascii?Q?Xu5sVDNEzjjhNgVtOnMsK80U1qtCPuKgxyjBBS0NvgZWejHLYHq0gYlZNQhT?=
 =?us-ascii?Q?etKX+3aYW0yA+0AXLYwvRJDERndn+I5kXvayyFc+l8qNcGWb1/BqOSUzkFPs?=
 =?us-ascii?Q?2Ax8vKVTTnVTBXsYpsLjIu6T/wfjs7J6bYC9IKydUTM2I/+D4fskN+h0gEqq?=
 =?us-ascii?Q?u+ixMDsrjklCsYzGcgnbAgnk6xtN+s14+WNJ40y/++YCw77DimmLu1qxDqKp?=
 =?us-ascii?Q?lhcZ0zYHsW7RYkpUnT1YmIHuBtFqSmXY4zt0K2wHQqwNV+vAHlsoLfbNeMM4?=
 =?us-ascii?Q?E82dkVGNgyJx9d3BYqGxUD13V0SuRpw1lilFFgeM7YEt3qSTqAVuAIPdntNN?=
 =?us-ascii?Q?+y4irhtbJZ6lFGHikq83fGo0esMnD7tJvdAfYSHw1B8wfgUxf+7s9xbNK3jG?=
 =?us-ascii?Q?q+3ObOLXxmF6JwUIw8m7Bm1R/Vps9+CWVtGRUHc5BEZYi5peUYSgnGqQ4zcI?=
 =?us-ascii?Q?Ejbeplj7TUggsgUc4NoPVWt0ao7uY78hXCsIZxz11Dyc7FRFibaZ7iGeET8t?=
 =?us-ascii?Q?cuvFYd9XSQTQAlGVb4Dbxet/JV7RQwsrWSY4lrtXnnYES9BFLK3lG5Vyfr7f?=
 =?us-ascii?Q?U2f3PlIyIJsYyGz7bGv1kqRpCYutIfh387zS3iRSDQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SLU5zpBVLhGO5FTr8HKj+4SV/v7FmjrZURY5WUe6fTbEmRbHQLABIAC2RHq/?=
 =?us-ascii?Q?wL/tgTJFx9Be48RIZ/sHmY/qZlIPMR4BjP3ygFu7imj/viiLlmXivrtwMkbG?=
 =?us-ascii?Q?L2PPJJdiFX18UsOjHFiMctKHOoElL+kc4bM1VVj462V3DxwLzBpOcDyj7Jn/?=
 =?us-ascii?Q?M+wH70F9dIr9XKXdhp5tu+0T2U0fk61HkrDCK7LTHFbl191IwfkR/F/sCmog?=
 =?us-ascii?Q?ULxTc1KA8HtYMvPSMPetqDc6gXXi9Zz3j3T2uA2+OeJbn0ZLvMhT525xN2WF?=
 =?us-ascii?Q?qN6A42ehNqA0/OxABmkCqXabYM0+YbeZi994D3TyBfPo+zh8zzmkvkMdW8P/?=
 =?us-ascii?Q?DpsEBCr8ixH2/LL7u48dKXWYxXkWVWPT11ZB/ctlXX0MayopeHX4c5mwKoRI?=
 =?us-ascii?Q?7teU8wnxY7KHG1Dv/FHWASir6B7rnD3u1GBXabstiORaoCXe7wJOZwjUY02C?=
 =?us-ascii?Q?YvY36O3Eoujcj/wedeo7WuXKEDhjSdAFRZgsrKyVhNrHoPt7oxLOQmCoAKBa?=
 =?us-ascii?Q?9p9hdRgdq0ihwq+praPki3/x1e5jEYJle83ZJ7S1y/k/nOGM2XdrTAwdob2Y?=
 =?us-ascii?Q?SMlFZpdSZ2wc5xK/rRKb3tiVeTTbP4fSyR+GPlCYvolg088sSUR5kbQEJoX3?=
 =?us-ascii?Q?DbHDIxkoFCgh5cDF3waG+xWIqBzSrKOy8OOIRWSTGEzntj1bTV1GiK5xvMG8?=
 =?us-ascii?Q?9a8UWg2FHZT1wdwdvaKDtqnsu66VcCQtSGgOy5tuZVbmse9oktgMATOUHJCI?=
 =?us-ascii?Q?tpgEmuePVrF5UnHSyDmyhXqArLes3ltwVoQ8r7c1qw6PTvlC5OsmYaLkuzGp?=
 =?us-ascii?Q?pCeND99eiSpzM74cygq4qjtgoAcGjPDy8sja9Wd5DjCPIqmN7r+MLuXMWNA+?=
 =?us-ascii?Q?n8AKSzXPgcIW7wXPfcINpxO3rHaq+FM1ZU6BBa8ftRPQCI3RTU5sStNYosQQ?=
 =?us-ascii?Q?RweqvCT+bLEUSodCIEMDMpFa0eU9UxEk8ehomunlVyWEIUA9/2WMSmcAxJrK?=
 =?us-ascii?Q?mXL66BiDT6T64ivPv2t0tLrN4BccH5eeuCAmRyXm+ewpbD3NdnXHz+iGEF1J?=
 =?us-ascii?Q?AA+3OEau40IndPm8F++1cKwo8PJr/lei4EaQsCEQh0zAIgAUU+e3ON8znj5c?=
 =?us-ascii?Q?2WyP0ptno7Zl/BEDxGAjB+DDbVmkAzZreTSTw11EpCak3eO6H0aJAUlkhRcY?=
 =?us-ascii?Q?fz8lMQEqXahQ0FO/hVKW36lIZaLAlk7ltu7fCknqfOd6D9b5v5GyFXb4NMqI?=
 =?us-ascii?Q?Fc/iMQJZhQmrNV1/RXEdzrZX1iXEzsJXhUo/ZGu4MEMGKj56obwU6gdnkkte?=
 =?us-ascii?Q?6Ji/XgOuNle6qWqNutrLDpRiruu3iY13E2Khx3YEZ56HXoWkZh3Gj/Rd7d4i?=
 =?us-ascii?Q?T6RIKk8z1ElvvbAnpHcLtOGpxhuEZ9pmogSOTAdQ5XdzO3w6v/44deBiZR2r?=
 =?us-ascii?Q?jnyO9Xe9jiwBN2ldhdwBiDAFx3GEEB4+fj+WqDwBYk4Po+HIIuZBTkdWVapY?=
 =?us-ascii?Q?9feNjtTWduk1SzMqqzcz/A4GRS4OlBVY1EFCf62H8FxjX0TCUDUAshZKa8aB?=
 =?us-ascii?Q?BbBS9nz9IUav+2XS+dlmBL86MoSZsm+/df7AxGjd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DA9z4Q0BfF2IKK0gqhLqx8aYj2uQ93C8+T76zeGOqLDLogEhh+fGBLCUO7aNIk+t6gMR3Ij0gOjw5k5RyAFO6DUd8Hwv9qHc5CzDuCmhBC0JtsP4ahldlBGZsuh+Ltrzio5358AicygXDQrdBr6uWM5P//wOgLBPf+7Ul33DaVSjfC1bzlrt1mPoyd05oUq+5rY8Pji3kgurKwyzm2zRu8CJ/ftUArrrBt+01SDrzsN2W83t0kkPNI1C87urVybPml5vgQRBUGyRj5u7e0I3KOkRNY0eW0yC3wYWeHQw/qgbMlpw1jUiNo0sD7OwZr3EP8eEoH0I5MQ+ANTQOwoBZhCFwRmQ7OQbuDEEedNygpKgHfMT5S7y/OX3yFop2xBR6WYbsfIsyETXoxlWYpJDvVbk8oSgU+1Dhv9xVpfPVN2Nu9A9yL/gdEQrLoUNcI02BDsswpV59MMtOM/SNA+pZrN/uv5XOcDYO1uYgA5fVIfmOubA1gXPwYjFKe5Fzxp+3bxxxPQAZK2lRIiX448Oa3kqXTsC/OVrQmprgQdMzLOiZwC+BN+gFbAgRrQzZzHddZYBAi7f0Spta0ONfUWQIC4DVJw/VPqxlERyfM2G4pk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2a4462-329a-4923-552e-08dc94646db9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:43:43.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsPV4vtBKaPxsWRdCYSySXJuFNzdaac/53eQxSE2ri4uNzEhGS1G/G1EDPYaKPgvesqQ4u6/5QdudEKpizaAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_12,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=26 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240126
X-Proofpoint-GUID: Z66BpnfRCD_45khWfVV9GGKrg5UJTmR9
X-Proofpoint-ORIG-GUID: Z66BpnfRCD_45khWfVV9GGKrg5UJTmR9


Thanks!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240618 16:48]:
> This series is rebased on top of mm-unstable + the patch:
> maple_tree: modified return type of mas_wr_store_entry()[1]. Andrew could
> you add that patch to mm-unstable before merging this series.
> 
> 
> v2[2] -> v3:
>   - fix new line issues throughout the series
> 
>   - remove use of helper function in patch 13 
> 
> 
> v1[3] -> v2:
>   - previous results were noisy, replaced with stress-ng-mmap config of
>     mmtests
>   
>   - document function parameter 'entry'in 'mas_prealloc_calc per Intel
>     Test Robot
>   
>   - explain why mas_reset() was dropeed in patch 4
> 
>   - add locking and mas_destroy() to testcase in patch 4
>   
>   - squash "set write store type" vs "set store type" into the
>     mas_wr_store_entry() modification
> 
>   - only set ret to xa_err() in the err case in mas_store_gfp()
> 
>   - move MT_BUG_ON() inside lock in patch 7
> 
>   - noinline mas_wr_spanning store to reduce stack usage in
>     mas_wr_store_type() in patch 11 per Intel Test Robot
> 
>   - document function parameter gfp in mas_insert() per Intel
>     test robot.
> 
>   - further simplify the local variables in patch 11
> 
> ================================ OVERVIEW ================================
> 
> This series implements two work items[4]: "aligning mas_store_gfp() with
> mas_preallocate()" and "enum for store type". 
> 
> mas_store_gfp() is modified to preallocate nodes. This simplies many of
> the write helper functions by allowing them to use mas_store_gfp() rather
> than open coding node allocation and error handling.
> 
> The enum defines the following store types:
> 
> enum store_type {
> 	wr_invalid,
> 	wr_new_root,
> 	wr_store_root,
> 	wr_exact_fit,
> 	wr_spanning_store,
> 	wr_split_store,
> 	wr_rebalance,
> 	wr_append,
> 	wr_node_store,
> 	wr_slot_store,
> 	wr_bnode
> };
> 
> In the current maple tree code, a walk down the tree is done in
> mas_preallocate() to determine the number of nodes needed for this write.
> After node allocation, mas_wr_store_entry() will perform another walk to
> determine which write helper function to use to complete the write.
> 
> Rather than performing the second walk, we can store the type of write
> in the maple write state during node allocation and read this field to
> complete the write.
> 
> ================================ RESULTS =================================
> 
>                   v6.10_mmap     v6.10_mmap_store_type
> Duration User           9.80        8.69
> Duration System      2295.94     2243.85
> Duration Elapsed     1010.50     1009.44
> 
> ================================ TESTING =================================
> 
> Testing was done with the maple tree test suite. A new test case is also
> added to validate the order in which we test for and assign the store type.
> 
> [1]: https://lore.kernel.org/linux-mm/20240614092428.29491-1-rgbi3307@gmail.com/T/
> [2]: https://lore.kernel.org/linux-mm/20240607185257.963768-1-sidhartha.kumar@oracle.com/T/#ma3795b93f9d5c9c9286291e12f089bff45b87fed
> [3]: https://lore.kernel.org/linux-mm/20240604174145.563900-1-sidhartha.kumar@oracle.com/
> [4]: https://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html
> 
> 
> Sidhartha Kumar (16):
>   maple_tree: introduce store_type enum
>   maple_tree: introduce mas_wr_prealloc_setup()
>   maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
>   maple_tree: introduce mas_wr_store_type()
>   maple_tree: remove mas_destroy() from mas_nomem()
>   maple_tree: use mas_store_gfp() in mas_erase()
>   maple_tree: use mas_store_gfp() in mtree_store_range()
>   maple_tree: print store type in mas_dump()
>   maple_tree: use store type in mas_wr_store_entry()
>   maple_tree: convert mas_insert() to preallocate nodes
>   maple_tree: simplify mas_commit_b_node()
>   maple_tree: remove mas_wr_modify()
>   maple_tree: have mas_store() allocate nodes if needed
>   maple_tree: remove node allocations from various write helper
>     functions
>   maple_tree: remove repeated sanity checks from mas_wr_append()
>   maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()
> 
>  include/linux/maple_tree.h       |  15 +
>  lib/maple_tree.c                 | 580 ++++++++++++++++++-------------
>  tools/testing/radix-tree/maple.c |  46 ++-
>  3 files changed, 396 insertions(+), 245 deletions(-)
> 
> -- 
> 2.45.2
> 

