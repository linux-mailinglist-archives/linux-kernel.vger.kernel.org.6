Return-Path: <linux-kernel+bounces-556162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51584A5C1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B4A3A9E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58750253F13;
	Tue, 11 Mar 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HM7tib10";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qzyx/ChH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611461EA7FD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697403; cv=fail; b=NFGqQwD7s1XUshHKWrv0UKZUThyMLQt0KMZD6wBphqrrYrHH0lEEOlqK2yqTii2I0iKG+QhFB3cQLOAUZ4UUsEJm4QlY3bgzJIYAb7HozZM51fqstp2tLukdjSYYG1oEWZZd9XrEIwQ868QtTckWAsGTU9j0T/jp+x0JkSsdwDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697403; c=relaxed/simple;
	bh=VydugSBWWpewoSRC1jSMTMiGWUblNYJgPrYEZL5NBak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ss9fsSP9zdsxtJ4D/EweOm/o1dEUkZidCEt9AYEnmLJj/UQnuizcOKLWukMUlTL9qt4ELczq0L33FVetx4PTDLAeIYuMnLRhbZ5WlCP+d89moQO+nwWXK1t0Ef/i1KPDKe3L/BwaSOtWZC15aqdmQS4YymMyvAQIJLekY9Esurw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HM7tib10; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qzyx/ChH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fssc025394;
	Tue, 11 Mar 2025 12:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pkyqcpzTxW4RlGiOX8
	1ZvcOLTm0rsQtRp2vKF8c5Q1w=; b=HM7tib10DNTpBnog2W3/IgQkjw/TPMqTOq
	Kcg87odF2A7lJlyUZZKejvMVcFHBl2TXBelSPQfZiWQM+X18xASMWS31ap7SRRbM
	b0oqOJ/R8k7uZuwZKS4Sr4uuz5MMEQsoG4sq2jnTS+rNip9A6mDdj7Pz6mVLPipN
	MXUa3Nc7Cvw+Oywsd8jOdCObGhtVsEh9YXu+/ea1kkHRN2d3R8bE5JoZdKc9UWhV
	eiPYUbowdh4FKXKLAHwWyQN5gf745lluiLFBdoDaRY/qn79o0KuczVk9/0KNOMSn
	x2DBkvfPgaSxqyVNnOPw+nYuQBv9h72MmnX6Wvec3156djSqnsig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0vsvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:49:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BBx0kp017608;
	Tue, 11 Mar 2025 12:49:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8y9w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKI/TCr/91UYbxoXYFA0D+8WGg/kk8yzRoJsmMyd33Fx8Q0MfVlOe1b39Jte0rhJHwAmGRU7IOBXOZVRaV8iKXrnzVs7OrjsLjRCNQ0GQreqjtWYEzcOygZ+zwQ4xjzgh9IwXOZoaJYxw/loV4NU/BlZLTn7ugPOeihv4pi3LfY2CKEJgcJbLb0J9SXMX9jf3FTTIr2r2vdjU5d/FXf85l4pgTGrI9QjA8JyUPuQjRoHjCRXZkMp0a98zcH/8EogJLOQItVoaPK55OLCzY3nRQocdSlZwc+sL0MwSLafVG3SMcWLnnqkfpd3JrWUsD7BTMhfpf8b7qXz7YmFjk12Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkyqcpzTxW4RlGiOX81ZvcOLTm0rsQtRp2vKF8c5Q1w=;
 b=pvK1Iap3DidFkyAPek3ec73n5e2vu5rw3ckc0ijrzl9rquXWU+9dz/XmtdcorRAdyewc404ci7O7qKTr3BtCG/p7jCxExcKTOuAvQ8Ule98q76HxH1hbtyDRCohOEt1urcmrRCpGrybPCEqCycLWxWmR59wXGBIOvVS96TTu/Gqo14VWMMGxRb3UVTdsTIeth3VpsLv3RQ346i0BX6psOgDnbslHh0pRlblnp63n0KSVaSM9cG/T87/p4VkTszorg9n23ihAqcq3vqdQAMOOiycVBL7BTy3y+VKMS4ICzI/vEgwXpowvZIQEh7FI96cQgrUYWW20yS0Kx11hkzE/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkyqcpzTxW4RlGiOX81ZvcOLTm0rsQtRp2vKF8c5Q1w=;
 b=qzyx/ChH4IMki7cuS0ZBfVfPY+jaZGdMh+RraMGMCdvT9cdD3sm+uDLXvxR0CC6o+IF4HTHcitL9MzwbtTDcpFYVUqan6keBP+rL+7ui+uOCKBJQWIOGVaMxiPeNca+h1kRlIDm764tz8SppMmsiKc3IwseqcwtwoM1XxqCPkwM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:49:40 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:49:40 +0000
Date: Tue, 11 Mar 2025 12:49:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and
 MADV_FREE
Message-ID: <0f90d56e-5960-4478-803e-1054696c0cde@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-1-sj@kernel.org>
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA0PR10MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ed6513-b539-46d8-345d-08dd609b3046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3BbGU42zP4z0Ulxk7s+f5mEjjsQAZ/JCHVG5E0ECD8lRLargdOzi7XIsqqr?=
 =?us-ascii?Q?g8Ln+DPwe8dDYI64tDgKYkpWD9PYi9kTgGQqrFburG9m4rafay2t2GAamphD?=
 =?us-ascii?Q?fB3VTU5UE7Y90RhYmc5evdwWwaeNuaEraSWK151hWD2rgvpJXGiU3qPGdb4Y?=
 =?us-ascii?Q?v+vwVlAHQspeIxhZZaNzZB/GrmCoROxruPf2lROxFxBvrZgTsJscb2vFPgOT?=
 =?us-ascii?Q?YA4OU/vsPfNGxgO2WKmYMFXjqBtdyEnlriiO1osGB4kgjkqKqSuJLCZpXxtf?=
 =?us-ascii?Q?ukZKpSvgOV3oTQZnw5bIIduSx0eGzzKiOHsrnBOiMq3kR71Lw84DEe2+jH7Y?=
 =?us-ascii?Q?fFrBS7E62X2bJQsHj+dMrSLd//zPUYKhdpeLKDVDKrt3kybKnB6m5Stvyp+0?=
 =?us-ascii?Q?SB4tqjxl13ryWGdT2856nmHEyxQhNhDO0Wo46H0Dt1E7mTDk1GAPT8pDBaCM?=
 =?us-ascii?Q?bBDcCW3+QfhcW+9klKTcOzBG+afuOjpbF9p8mL3CrJdptaO9hg1Wdd4zLZF4?=
 =?us-ascii?Q?RtMuU6jhW4+Elc6WFv7Ts20s5iSA6Ab7oGJDI+dSfY5DsdpEeWmOlxv3Xa9F?=
 =?us-ascii?Q?iIVsRbPk+unM+yBAP47WzYxUeKRN7g+SBHUJTo4jZI9inxmyMsLDn9R7otCD?=
 =?us-ascii?Q?xoWGlGEU5RA3QjGb1Q11QAJeZ2rsE5K75FOxMHtFfeHOeAWsNjC6ksh2Mtit?=
 =?us-ascii?Q?xgts1iZ7JIVlFJlQH0dVdpmWw5a5y2GUYkCAgbWd2zJHFbeACNrAXyiri+SY?=
 =?us-ascii?Q?aK0TJ7VY4GB/oWqdqP8WycepGU1NeNHmcCSUc4kKoBFrX2LTiq+yl8sW27+m?=
 =?us-ascii?Q?cM9GRNHA7y6B+YiNaKT7FrV+tqjkzI+zVp95r4TVIjpjiD0c0hjcHjzfYRCv?=
 =?us-ascii?Q?FES77cMy4Y3G4GwHB79knZyvL4po6xKGg3wZFPPQHSQmI68GfF57hDyXDqFV?=
 =?us-ascii?Q?B8E9SBKxW+IbDszwYLtZ5mflpV9NhBQX1lh1WSxP5EVsMogokAaHyrZV93E/?=
 =?us-ascii?Q?AR0cc0p2J/++UPgnEpjQ7oiK6ItX3rV1LU7eksb7AO4QDPsAPzen0KE4tMKV?=
 =?us-ascii?Q?kuTp9SSVNN3AQdjotCHbmZuvm+T143It/DLl6b4jFwPikUUZpsuXfIY/jxyt?=
 =?us-ascii?Q?yVRMBSHbDN54+GGE6iBrt53GE8SK3kqc2d7lYprT46a4s2SrdlHlPRGAd8Ee?=
 =?us-ascii?Q?EQSesvGoLwM4KbWgbuyf5rSLuupG1MqB4p4VStz7AtaRYdDkIOtvEgne7n1B?=
 =?us-ascii?Q?dtyo6KtWl2qtw5a5Wn4ggCqQ19HWaJ1rwIfS9MBUummOgnuenCDRXiNyMzyt?=
 =?us-ascii?Q?hqLvn7isdic2BMZilo/URMZd+s6bCkwjDXlw+Ue1fpFn+9709dCj9b/rU3Un?=
 =?us-ascii?Q?7QSPtFYJ1EjRMNU04yiZ4DAiAIH63FCAalOxYZ0JSEFE44YU+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCDMXTPLfCSNRK/rlWDPrp8ICyqjKLIecGovzsCFt+gi6uuDFaa0u8QLJDjb?=
 =?us-ascii?Q?fG12URicO28UDrMrorUc9b4vIiC0XGxAWlkUtbiEWzSJdsIcrWiORYMSudNx?=
 =?us-ascii?Q?wjDpYr6PBkKChwbW23ku6VqJ4HtQvnADFwlaWeM/Bhh3EyxSwYE7j1EI9z52?=
 =?us-ascii?Q?NbZ22l1KxwONGHX3bO+RrncSo3dnkBYc7DhROAPM3jP5/dbrbjMv2htC39aO?=
 =?us-ascii?Q?u6di4fDDDWih8kWKBFbCtQ2lBikK20mjZ7IHXUoOqA0nVS3V6amlzpr1KTdk?=
 =?us-ascii?Q?CAP6s3g17H0UR1NqdZzg84vXq542lxNTenK4v0psYgeu7CeMU9ExWq7D4cUN?=
 =?us-ascii?Q?Rb7mKjwP4xNNaAqPqTf5byhm3pHkV65D2r8ICDd4xe/FjvO4ptD9G/wrtvnE?=
 =?us-ascii?Q?l+ZobXHnrIrr4xuSeWu6ZGM03KoHp9F+qFqyHpXpbplfb432LE0iotbeslvm?=
 =?us-ascii?Q?9y9YGHHZTqbq6a2QZUGaJkF/Ev3MaFagI1pc8kcGEC7CJAMn1NOV5P98jtUD?=
 =?us-ascii?Q?c9fJxOkjpvXsIii7CxVCQtw28q4C5xmmZlW9hsZm+3SMf2cKXtJMcEkuS50V?=
 =?us-ascii?Q?PCeZzl4wFCwgbGzYe3mo2V5VI2EmgeJmbtj510WmEtgmia3bVph04a+1W/ep?=
 =?us-ascii?Q?3Tg/MS26N0cKh+2/tEHvsq8V1CZasw1cFVDbPVlymN9aA1Cqg4xnzbno5cMZ?=
 =?us-ascii?Q?j3uQ1fEvEVAoDlsyD2CsfIfRrUyY53D0yCqF5hRC2igMQO8UsMk0Oq4IIHbt?=
 =?us-ascii?Q?Rb9hdXkVYdU8b5FeoqxsE+3d95eyPxiJFQVv8jx5rXqZ6Ex9GsjLHqiH4WyN?=
 =?us-ascii?Q?2SsPUgS91P6fpa4XduuiouE6lKAvKoeE7gtNJCDXxVQUKi94j4UTA/9kZHJh?=
 =?us-ascii?Q?pgPoKk5IKT40AWEA9tFkzhS7E/nuikYvcjv+dTUPHhPt0qq6tmakpD//1a7m?=
 =?us-ascii?Q?1dCsjaGMXNcY1NLOeOXUVw1DImtry4oBgOI6SfNQQO3yhkPHGRocdI+k+dCd?=
 =?us-ascii?Q?wumCv335GJiUwyhaF0L/WTHe58zQbwiAoPUMnppBdSK9HfNmA69lt4nE4gSz?=
 =?us-ascii?Q?38poYg90BoredU0dnyPP6HuQBKnH35vxHvEaoqJGBhDq45vHZaJctJ770u/Z?=
 =?us-ascii?Q?yHAYBmRswLbck7AvoxjxFQ/1MSgCVU8NKHg5l75p36D8LH9trjr7Lt1vtPw/?=
 =?us-ascii?Q?EiLO/Ejvhyst9IHMHXL4ILnpMmH0rW7BaYgYRzPPUL5HBO/6dUb3nJEQoMEZ?=
 =?us-ascii?Q?PQovNerrexnj/HCb0iwN+wjX7uqnoSbnCrwQksG/R51xWtNTwd8xWsLj9lup?=
 =?us-ascii?Q?eS5Sz+IAVS7Mum5P0rxCe879Bdeh3867P3LQ4CR6ioGu3ZVVmMQ69wNQWNgO?=
 =?us-ascii?Q?yykOxHaY8ZCnO99r9wepemvIwWb6ZOiBcKbsWPiTo5e5nmavfRADafh/M/hs?=
 =?us-ascii?Q?IzxSCdcRV55J23FDhwB/4Oby+/YQrd495xa9xXi7Lmntq2xmcFRsiOcAmTDf?=
 =?us-ascii?Q?Se+wps2az8zey4AbmmSr8lA4INXNVTv3/TzlUo0JV/LSH0Szl9Cwiu3Ea/1p?=
 =?us-ascii?Q?a5M/MIbx9l8W4G5XZTT3a26Rx15K6pdwLrK6nrSPY1NlLw7tKp48ZoX8CelZ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ePnsdnLRxRyo78HZJmQaitJn2XCuW3eARPD1F4Z9W+U9UcikWn6N47GSdhqIFMYYFoxdLgbsdvwXfzQNTXhxdEWIS/gfYV6iM6gxLTQYbyMPK8sJgkk0i+awLzIAiysez+v+FzOTRF/uQnYyB00JaMSB8f3LCc8f0gegsJjfCaiORmIVCdMOjkF5Dc8wkLd4rH7Sgzo7ldKYtO+VAATbyQW2S6Bb2EcJjCG7bvPHPk5G4D7azE80kw6Maulw4HJedvvjJ3nWyPZnxrcYh3ID70/2deOebJYFVx3tQcOzL5Uj/ztVDNO62Dx50Be6+PpCNJHebirs+vmC2CUzCmOTbmpf7Sxli3+L6YRXwBmsUURk7U9J3FiaDlgwVg50Jp/d66aRI6j0S7+oCrbMOYTyTryyQ8EdLIKLBkPgJk34w/m0aV4lYFWwndTIDfP7eH0F/VwC2VNjbKlPvMzKesE/5Rc2LaVvMNMxKfl1SxyYuQcX6xruYMBKX9D70MzXbrRtj9SwL80pIGcUIo2j9lYzMSUEfqy9ordowf2M+LGav0iuzHLH3C8kzCaFGjocdF5hYGIJ4FTYBmlrR+UkTMRKkZm0tnAEDVJkeQlA+mAJWhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed6513-b539-46d8-345d-08dd609b3046
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:49:40.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNmoa96yyD+nPWjkZBg7eHPJCzfvrJgf6HOT4qQaVpA1xABLb8lMuKYndZO72IDdtqYL09b/VLMb9T30+KMLPELS2ceOdJPM33D//eI+fQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=930
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503110082
X-Proofpoint-GUID: BAPlniq5WrNdNP0kzhp_jnJnoLm4SCcf
X-Proofpoint-ORIG-GUID: BAPlniq5WrNdNP0kzhp_jnJnoLm4SCcf

The below commit message talks about tlb bits, but you spend a lot of this
series refactoring mm/madvise.c.

Can we just separate out the two into separate series please?

I am doing the same kind of thing with mremap() at the moment, but sent the
refactor _first_ before the work that builds upon it :)

Your refactoring is great, so I want to be able to take that (and Andrew's
objections obviously don't apply there), and then we can address tlb stuff
separately and in a more focused way.

On Mon, Mar 10, 2025 at 10:23:09AM -0700, SeongJae Park wrote:
> When process_madvise() is called to do MADV_DONTNEED[_LOCKED] or
> MADV_FREE with multiple address ranges, tlb flushes happen for each of
> the given address ranges.  Because such tlb flushes are for same
> process, doing those in a batch is more efficient while still being
> safe.  Modify process_madvise() entry level code path to do such batched
> tlb flushes, while the internal unmap logics do only gathering of the
> tlb entries to flush.
>
> In more detail, modify the entry functions to initialize an mmu_gather
> ojbect and pass it to the internal logics.  And make the internal logics
> do only gathering of the tlb entries to flush into the received
> mmu_gather object.  After all internal function calls are done, the
> entry functions flush the gathered tlb entries at once.
>
> The inefficiency should be smaller on madvise() use case, since it
> receives only a single address range.  But if there are multiple vmas
> for the range, same problem can happen.  It is unclear if such use case
> is common and the inefficiency is significant.  Make the change for
> madivse(), too, since it doesn't really change madvise() internal
> behavior while helps keeping the code that shared between
> process_madvise() and madvise() internal logics clean.
>
> Patches Seuquence
> =================
>
> First four patches are minor cleanups of madvise.c for readability.
>
> Fifth patch defines new data structure for managing information
> that required for batched tlb flushes (mmu_gather and behavior), and
> update code paths for MADV_DONTNEED[_LOCKED] and MADV_FREE handling
> internal logics to receive it.
>
> Sixth and seventh patches make internal logics for handling
> MADV_DONTNEED[_LOCKED] MADV_FREE be ready for batched tlb flushing.  The
> patches keep the support of unbatched tlb flushes use case, for
> fine-grained and safe transitions.
>
> Eighth patch updates madvise() and process_madvise() code to do the
> batched tlb flushes utilizing the previous patches introduced changes.
>
> The final ninth patch removes the internal logics' unbatched tlb flushes
> use case support code, which is no more be used.
>
> Test Results
> ============
>
> I measured the latency to apply MADV_DONTNEED advice to 256 MiB memory
> using multiple process_madvise() calls.  I apply the advice in 4 KiB
> sized regions granularity, but with varying batch size per
> process_madvise() call (vlen) from 1 to 1024.  The source code for the
> measurement is available at GitHub[1].  To reduce measurement errors, I
> did the measurement five times.
>
> The measurement results are as below.  'sz_batch' column shows the batch
> size of process_madvise() calls.  'Before' and 'After' columns show the
> average of latencies in nanoseconds that measured five times on kernels
> that built without and with the tlb flushes batching patch of this
> series, respectively.  For the baseline, mm-unstable tree of
> 2025-03-07[2] has been used.  'B-stdev' and 'A-stdev' columns show
> ratios of latency measurements standard deviation to average in percent
> for 'Before' and 'After', respectively.  'Latency_reduction' shows the
> reduction of the latency that the commit has achieved, in percent.
> Higher 'Latency_reduction' values mean more efficiency improvements.
>
>     sz_batch   Before        B-stdev   After         A-stdev   Latency_reduction
>     1          128691595.4   6.09      106878698.4   2.76      16.95
>     2          94046750.8    3.30      68691907      2.79      26.96
>     4          80538496.8    5.35      50230673.8    5.30      37.63
>     8          72672225.2    5.50      43918112      3.54      39.57
>     16         66955104.4    4.25      36549941.2    1.62      45.41
>     32         65814679      5.89      33060291      3.30      49.77
>     64         65099205.2    2.69      26003756.4    1.56      60.06
>     128        62591307.2    4.02      24008180.4    1.61      61.64
>     256        64124368.6    2.93      23868856      2.20      62.78
>     512        62325618      5.72      23311330.6    1.74      62.60
>     1024       64802138.4    5.05      23651695.2    3.40      63.50
>
> Interestingly, the latency has reduced (improved) even with batch size
> 1.  I think some of compiler optimizations have affected that, like also
> observed with the previous process_madvise() mmap_lock optimization
> patch sereis[3].
>
> So, let's focus on the proportion between the improvement and the batch
> size.  As expected, tlb flushes batching provides latency reduction that
> proportional to the batch size.  The efficiency gain ranges from about
> 27 percent with batch size 2, and up to 63 percent with batch size
> 1,024.
>
> Please note that this is a very simple microbenchmark, so real
> efficiency gain on real workload could be very different.
>
> Changes from RFC
> (https://lore.kernel.org/20250305181611.54484-1-sj@kernel.org)
> - Clarify motivation of the change on the cover letter
> - Add average and stdev of evaluation results
> - Show latency reduction on evaluation results
> - Fix !CONFIG_MEMORY_FAILURE build error
> - Rename is_memory_populate() to is_madvise_populate()
> - Squash patches 5-8
> - Add kerneldoc for unmap_vm_area_struct()
> - Squash patches 10 and 11
> - Squash patches 12-14
> - Squash patches 15 and 16
>
> References
> ==========
>
> [1] https://github.com/sjp38/eval_proc_madvise
> [2] commit e664d7d28a7c ("selftest: test system mappings are sealed") # mm-unstable
> [3] https://lore.kernel.org/20250211182833.4193-1-sj@kernel.org
>
> SeongJae Park (9):
>   mm/madvise: use is_memory_failure() from madvise_do_behavior()
>   mm/madvise: split out populate behavior check logic
>   mm/madvise: deduplicate madvise_do_behavior() skip case handlings
>   mm/madvise: remove len parameter of madvise_do_behavior()
>   mm/madvise: define and use madvise_behavior struct for
>     madvise_do_behavior()
>   mm/memory: split non-tlb flushing part from zap_page_range_single()
>   mm/madvise: let madvise_{dontneed,free}_single_vma() caller batches
>     tlb flushes
>   mm/madvise: batch tlb flushes for
>     [process_]madvise(MADV_{DONTNEED[_LOCKED],FREE})
>   mm/madvise: remove !tlb support from
>     madvise_{dontneed,free}_single_vma()
>
>  mm/internal.h |   3 +
>  mm/madvise.c  | 221 +++++++++++++++++++++++++++++++++-----------------
>  mm/memory.c   |  38 ++++++---
>  3 files changed, 176 insertions(+), 86 deletions(-)
>
>
> base-commit: e993f5f5b0ac851cf60578cfee5488031dfaa80c
> --
> 2.39.5

