Return-Path: <linux-kernel+bounces-387105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311239B4BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56FC2821A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CA206E65;
	Tue, 29 Oct 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zir5zGNg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zkQ/vvmi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92448206076
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211544; cv=fail; b=W1e70SCee1rgAk/kmz0qTmunPm5jwk1UXcrVxtV/B1puvtjoron3V6u39VSYav1gytr7sNMLjuZqCIwmOcRialFNKtgSd7cKYyBISX+Rg/yyBzyNy2JsfvJ5gFLRyBELVzqYq5iov4dYI+fgJECA4Vub5eTClz2KRIe+EpdTBBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211544; c=relaxed/simple;
	bh=J2aHP0lfptTItIBXQpEKD7C52xACAactKP2Rp7SHu0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KLpoM2e+pYE/mIs8whoLRMng3GpPepLBsuAugXIHP2nAJf1+6BA6fO05NA+buM1MNXDkMKaqciq11Msspq+JGH5ddg/aSRewm1lZOld2sKd0d86bSWUhzH1kLyGohGjfP8IfO7coxUBr5B2NVlyb75AIPQzKCS53mQGLDg+YDvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zir5zGNg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zkQ/vvmi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCcxIc028539;
	Tue, 29 Oct 2024 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jLaEa16//fTCPPl0I+
	X/MK8gdJrgBwVuMElbdv/izl8=; b=Zir5zGNg4PgQqvyYMGGd+XoDqPYo0uA/ir
	BjKe23QSitrqj5ED5vbYCoEvokLzLvZ8g9sf9wvyueD0vTGKxJIiZZ1+ydX+5ANq
	4nMn+b5hv859FThw1s2BBuARkeOt3mwLidhIRVR8hzLd4OPsKWSzO7I05nFcxDMi
	KewQvYrquUE64TSckGMsQJiO5jzQMnTG2ckSrbuP2sMSydJWu7sz8Jn5NS9lw2js
	lmwdvmtor5UpnQe/Kl9dGW4dqnKbLfwugeCzOjNuUcp7Dntt3BDc+olx3dmow6if
	jKMNs1fz1pa38OmBOEbAGwxCNilt578R/uw1MCczrsdTVelGb/xA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxnk3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:18:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TD9q4P008423;
	Tue, 29 Oct 2024 14:18:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9puv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/0Au36nqr5LZLS/Jyv/kXJX6PEqnvk6zjAWgL7H5BH+i2cwcURFvw4wJKYQtOkdVJMCSsBVeotLxUgM4xEgxV9rc9dQC3K8Iw9hAeipwJrucRoemTOs9b9Jvg4pxqN5BvhG8eRS3xURRPcF+E8IObrPLi7IcNugxsdO/wvSHUYbxyhdbIK1F4ih5o60aneHNh4Nw/0JF0evbeDZIgbxb+O9QlPsK14nKxWFCn1J318i9WbK28XBMGuIRH8VwLzFVsLbIlR4RW4hynYE2+AZFRlVo7uWA+sSZEdRVFLZ5V89fkERJuRbwtYsg54jXwNJiYL0ynOxPqpKF4xWLJ9Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLaEa16//fTCPPl0I+X/MK8gdJrgBwVuMElbdv/izl8=;
 b=sa+8gNb8DjHCpV7B1maP053z0CULppnRBIrQp1gZuscbQ9BlhY47QKnFmD9+sAI5+gPFsR0eLO6nK0Q60glmD2AuZ8lBQUh5UqFrfiEDE36dye7LE6ekP96VSimXewFimPH6745UOLG7VD7bwMkFSNV6tLsbyq6k0Pyqb65w35irywdPZgPVFXrNOhxJPEMbihAiZ1m3LRLc3Fb3aeIsZj6pbO5iirwntTkZJNeJiw4YhT5n/WdTNxDcUK+drVlilXQ3jozca1nOL9IegSe485S8anXUHkToUbIzFTGf7iVkmRuRz5lvAt0kC2/mMMgsM+7PfxzthpAS1ep8ZGqSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLaEa16//fTCPPl0I+X/MK8gdJrgBwVuMElbdv/izl8=;
 b=zkQ/vvmihO37GWUFT9JHZ37xyAjCr/XKki0POspu0hcBSGkF8LpDU+On43Ltd/veNlPcWNr+ItGBdCBpM86jjDN8UGZf4pvdMOwUPzj2BwSiRhpYVK4vzJnavyfGOFi3h2L8JqTE8YUTUfijkDrjmfJNTv5z/S6MevkCIEXy9fA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6521.namprd10.prod.outlook.com (2603:10b6:806:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 29 Oct
 2024 14:18:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 14:18:16 +0000
Date: Tue, 29 Oct 2024 10:18:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Breno Leitao <leitao@debian.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        "open list:VMA" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Remove misleading 'unlikely' hint in
 vms_gather_munmap_vmas()
Message-ID: <cwn5sv6ggqrc6k6v55uwciuyohuwwtiknvlk6o3beqoocxtll6@yomkzc5u5mzz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Breno Leitao <leitao@debian.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	"open list:VMA" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
References: <20241004164832.218681-1-leitao@debian.org>
 <71b7cbeb-1301-491c-9637-e6d48938ddaf@lucifer.local>
 <20241029-discerning-outstanding-badger-6376bd@leitao>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-discerning-outstanding-badger-6376bd@leitao>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfd07a9-a12b-4fd2-1813-08dcf82487cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1jjbnshUj5e7EXqvhxJW2ka/9SkpGjVBkHHBjrefwJZHuaomLEh0FuA/Jj1E?=
 =?us-ascii?Q?sD/Fqz2Mqskp7Wd6RVPFzVo80uU0uXLj6xpg5ER3a8LUvNdm9tLjkc51R4/6?=
 =?us-ascii?Q?tmwEdfpYNi+QwO/T/rBUc2gY0v0OvY5an1giPV7gKpNPG+b0tQzurNa95GCg?=
 =?us-ascii?Q?FRFXgao96dOaxS4xlR+OqSrdY0OyZ/iyh2Dqy1LI+qZCclhDAvLQmX8KL9T3?=
 =?us-ascii?Q?cGClKvEoJvl4Y2Uu9+hQH7Y5LcULafsuC7rjv5PstX9LDqykAK6neesV3OgC?=
 =?us-ascii?Q?5iLKEedrPQmvKkY+AWKXMfr9cbDWxh51hjCkRhTgiMMr6DqN3R9FBdzsiryp?=
 =?us-ascii?Q?aCntEBXsZg3W2FFQvfPQaFcrNIalczNd7Nrr82LK9MRtI7kssM+Rr5eZOL7z?=
 =?us-ascii?Q?q6BsTh6Q1WbZN3QGVcAUAbCXf2IDDmlmsHOubIVWwTW8Co7YCz3xeoPF/IlN?=
 =?us-ascii?Q?Fxnrusi8H2bqdzRQ/Ey+L8P8AmXlchD3mjAWvpZ2dbXJpkcmss86wT/14NPh?=
 =?us-ascii?Q?5dVunAgmS48+01tUvW4FIP0NlCwVL6pBHoOGb587E3Q/GAOgnrGPWPQsfhC1?=
 =?us-ascii?Q?Z5h2x035jk2fC3hXFFmS1KlhYBjzK7hbHhbLv4+SlUIiJbNPPTLpiXwdL6tr?=
 =?us-ascii?Q?GD7pSPKKqFI/7tBC78SSkoyDxRXSX3FfkgkWWKrb8GGRclqRc76T5cMNOYdt?=
 =?us-ascii?Q?jC9RxSLRJFUOkBYTpaCdDS2/+8bfpAafX7tLD6OgKSVvJGqVQEoeayzhEXXU?=
 =?us-ascii?Q?qsAz5imOd11U5zBxZC/B7U/g9j1TMET8K1HuE80A5ivViD+0KzW63WnS7WFV?=
 =?us-ascii?Q?/vCT13ZpRW7C5tEJS544T4JRqrYjYx9fYhW8cninPFpPGh7D6G9xVaoAPyhw?=
 =?us-ascii?Q?wMF3qeEKLOzvnOJuEDMGxWJGnSLgeQXIeG4qXFz1fgQN7lSC+34f7Guf1YvJ?=
 =?us-ascii?Q?jA99FQwPkKafWS9G4mNxIOpQlt5HJAOOp9LMkkXtFMR+pAy7IH6BzelqktZL?=
 =?us-ascii?Q?fOgQdiWPROeE++Q1UXXqZPR0zoNFKvk/mSzPL/kIwbV8ksmGTr/zj5ie72FM?=
 =?us-ascii?Q?mP0JVbb6VTIAe7LtMaa6McEpkYnjlITdpWXVnUXvZ6nHbWOLdtGR06Gi4aFb?=
 =?us-ascii?Q?H8uqFmFt3DYekv4RqUtzaFL0vO8GhSFoGWPWA5GDHa0hxXCpl1i3OF1g9cpr?=
 =?us-ascii?Q?9hQATYhpD/5rtcMwO7Hs1Tl5NX9NBKV/YDGNGO6dIsFh9OHZ/SqKkwlo26Eu?=
 =?us-ascii?Q?ho5JFvnI59CAPrBm2yznLVwiOvdJJfOVoojAS3y4sbp4X0unxKMir1Q3hTxb?=
 =?us-ascii?Q?0hRwqClq1jzZAVU7GBpqywGo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wTnWeeiAvF/layoaMymvfl5GoSNzbzFMR/NTEt6VlyvbnLpm3nx8Wd/nyuIW?=
 =?us-ascii?Q?xEWrKeH2jf6ROkG9SrBLDFzUU5+5cggrZS2qUNqr+Sc0fa2KOHY0+qX/q8j7?=
 =?us-ascii?Q?iMsEToBsX4TPwuINq6s8qfWB6xUOAteIg8devjgzVV/KO7c5kYHgc6qQbE9A?=
 =?us-ascii?Q?OxSuPMR34cMch1ZoBEWCKnGH08f1zVBTSmL999w1pLqkAODxEn6B4RNqbx0Q?=
 =?us-ascii?Q?FkPXVTpISLNrqIWjXAjMP6QOScEHplUTbOmwNbbus8g7X4L/cB2zQwm7GcXI?=
 =?us-ascii?Q?xrGjQknuvzx+Z7SAd7ltPXED18+st3hYghc7lPJyuP5DXRFzOKDTcg0yGMJ0?=
 =?us-ascii?Q?w4SRBA7R2UzqXgIWkSlThZLWCCJYq6+NVRvv6ru/yjRGuhivVcdJuxCdnK6a?=
 =?us-ascii?Q?HQXRn0uvjhGDIaQQdws8qXXj09cwPsmUgTLcebZ3tn92hZw775IzQ741lzDI?=
 =?us-ascii?Q?XzGTfiIWq6ZDNNCbJuU3WnCszAKmiX9NtM0ke1jUiaj4S7vjBVtaHam0zT7c?=
 =?us-ascii?Q?Maeyitqanqapiq5oJIokM40+t406yMNL2spI/RxXr0ClW+Ey5qTVnqMTC5kw?=
 =?us-ascii?Q?TaA/2StwtNz4uJ8FTeft2g2Uop6ahu8Z4jpp2L+1/EGa5u8+wEkPGQvpxZ5I?=
 =?us-ascii?Q?08Idoz3VY1G9czjgQmnCkrOSNI9Z2gp880kLAvMA2/MxX0c9CIjj2NLVTy9s?=
 =?us-ascii?Q?d0S1Rg4Sj/L2lV8cTfqX6jMwNbBC2OIcGrOAcH9gUQXDlHGGAAMycqoulOXn?=
 =?us-ascii?Q?h3xZbYU5N6mMCKitkAtVJK+QKEtfM1PjUtuFDNzGgHplGYlTEvbyOa8s9sqd?=
 =?us-ascii?Q?SShZ9qhH9VX0XHW2biiCsyNJtzsFgBy8ruzOrTx+wTDqTG63BSFaWfp05oB2?=
 =?us-ascii?Q?6FdX1Ecqr60ZizReuGh4MgrN0DxUjd/fQAU2aEL4ZEOoy9B2j9U9WbnljxSi?=
 =?us-ascii?Q?gNP+avIl0McQRI7o3OMZRk6Z2725rZuuJ+Pjdss5bUX81UOC35mL4yEHjjNb?=
 =?us-ascii?Q?j/NLk5PELv7vXRoVnMINWHo1f9UNQJupR5Xqd3bdMAFFOp57OdP30PTjtNqP?=
 =?us-ascii?Q?IPOxfaXBjZeWY8TX6uvNnPKnQkmRh22tyT0ZFVRWlWulWMQpt23MBUMq/eLd?=
 =?us-ascii?Q?oGwtj0+i91557BWO9yCqLKBTC7DsBKMPA0QHekvJnlKOumvucZTLbQHoIVE+?=
 =?us-ascii?Q?zcS7eTJd+5Kut6FHuriUGuQqcZdgG+w0NmrCASZR57mwNF82xKO62pP93E36?=
 =?us-ascii?Q?y5nHl9qa67eFRL9oAhH86jKcL478C1KCEdlOckr0sTtzV8nsakhb32V1LicB?=
 =?us-ascii?Q?LPXkywK0OHkQHU1O+CoSTaLy3aFVNQWkz+KCxpkz7OnlY5zmiJGf4xekUJuj?=
 =?us-ascii?Q?VXihYQhHWu+Uou33ZCY13s/p7bY7TpTuhnl7kiV2wSYFny4YoDI2EegwTEmj?=
 =?us-ascii?Q?/N+Gr/XPsHEbHKELomMioCskqamZ58MEGln28zcx41ANLc9NcgcSE+u6fk5T?=
 =?us-ascii?Q?IGbLEYY+PnxIiPjxm1nAtDWtSuXcuUut0xxUUY7KHwxuINGTyLqu5T9R7l5Z?=
 =?us-ascii?Q?mPZqdtR883hpRrXVJhpryJ99PThd47c6yMN0xsrO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gFbwPMrij9bcSZJoWdLA0Me9FKH2bkl6c9bbkdJQ/cGZQ8WOu9yPDLFqMuA1XBNS9cyZDIlz+IuhdzMAxnNoxTwoDHsOD9gZ4QfT16/B6pc4qIbY1OcG7MSFqKiMQtlo+3TZkY2Twu+YRXe1gxCaUwkRKemAxo9y2T0AAx84QD00CYosAgkeq1TRfeOuqbxwMYW22Wy5nGbqB3aMat6XsKb4jnGQ8s6iNFUoN8CnT8ouDGXmDacMFfBDCDXhGnyfHSsmg2ile2NXu6OQuqAsRkVhy30hzY7CFA/HcUF8s0J9ypzlXL4uZbvJiT3D+C8I/O3CQrIFKD8AaX2h5FBQ2iKU1YOKCB85RBJ3wT032H63+vbl6r2FMQgcJIxW8tNHgGVLWjz0nlrYRAGEJfZKckuEP2GHryJlk6gsAECMfrm5t78n2xoXYgS6xYgxQhN5cLUylJ2us8+1LJH4b8z1aTGo8FgUpiY5ZjyQBE0eWnJyKQBYiXsvC/0KjmY3+OoYDlfVLIadA4hxLMvnVyDpqt37mz/ShIpU+mCwJRoHqkucuPyZfiuIncBEnR9tzDZqN/OQDJr3fndIwb1u4qp+wuCM1GZwJGnEPPQChwx3Gsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd07a9-a12b-4fd2-1813-08dcf82487cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:18:16.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1idmsjvXYNRrOcdshzqbtfBqSBGbDMI9SNDl1PTOIORn+i0aKynbxyqm/G40z48FG+kViFc3mPhTPj9Kc/FMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_09,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290109
X-Proofpoint-GUID: VAXH_sIuRUUgSwmy76N27CFaY_6ZTumz
X-Proofpoint-ORIG-GUID: VAXH_sIuRUUgSwmy76N27CFaY_6ZTumz

* Breno Leitao <leitao@debian.org> [241029 07:52]:
> On Fri, Oct 04, 2024 at 06:01:07PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 04, 2024 at 09:48:31AM -0700, Breno Leitao wrote:
> > > Performance analysis using branch annotation on a fleet of 200 hosts
> > > running web servers revealed that the 'likely' hint in
> > 
> > To be pedantic: *unlikely
> > 
> > > vms_gather_munmap_vmas() was 100% consistently incorrect. In all
> > > observed cases, the branch behavior contradicted the hint.
> > 
> > OK so this is probably because vm_mmap_pgoff() declares the userfaultfd
> > list head on the stack then passes it into do_mmap() and threads all the
> > way to this code... and yeah, so that would be 100%.
> > 
> > There are other code paths that aren't 100%, but the system call one is.
> > 
> > Nice spot!
> > 
> > >
> > > Remove the 'unlikely' qualifier from the condition checking 'vms->uf'.
> > > By doing so, we allow the compiler to make optimization decisions based
> > > on its own heuristics and profiling data, rather than relying on a
> > > static hint that has proven to be inaccurate in real-world scenarios.
> > 
> > Yeah I'm generally not in favour of 'vibes' based likely()/unlikely(), I
> > think it should always be based on profiling.
> > 
> > It's understandable that there would be this expectation, and it may have
> > migrated from other code that already had this check in where perhaps it
> > wasn't always referencing a stack object, but yeah this is just wrong.
> > 
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > Liam will want a look too when he's back next week.
> 
> Liam, are you OK with this one? I suspect that Andrew is waiting for
> your review before merging it.

I'm fine with removing the unlikely.

This begs for a refactoring considering we are calling a function in
fs/userfaultfd on every vma on every munmap operation in this call path.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> > 
> > Looks good to me though!
> > 
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > 
> > > ---
> > >  mm/vma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 4737afcb064c..9d4fe794dd07 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -1250,7 +1250,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> > >  		else if (is_data_mapping(next->vm_flags))
> > >  			vms->data_vm += nrpages;
> > >
> > > -		if (unlikely(vms->uf)) {
> > > +		if (vms->uf) {
> > >  			/*
> > >  			 * If userfaultfd_unmap_prep returns an error the vmas
> > >  			 * will remain split, but userland will get a
> > > --
> > > 2.43.5
> > >

