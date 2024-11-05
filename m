Return-Path: <linux-kernel+bounces-396647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D365A9BD00F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921DF2822C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0491D9698;
	Tue,  5 Nov 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmDJLems";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lys1JKn8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2573FB1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819241; cv=fail; b=AMooltxBSf06xlMgv7DljnkoW7nyzojSoLpemHL9T183CYLKw2rRY/lu2VGeB7XbCQ+mMRS9KbkFawa1i5WgISww3g+8e6kd+pHQjmc4Um+O2+XUSKqNbhnBIuiDAK1SdqI0tk8LMYpxF96n2sYr0Om+R+SmR9N/GFLZepFFtMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819241; c=relaxed/simple;
	bh=vkGrXbHg2QKh+mpluAdoke5KFJAJVuYS1Jj+VP4DAjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnjFFdo8CxRpCIRh2oXDqjVr6nbQq5e7aGalg9OqX3lmSMUphSDHT0GrHGiot/znXOpaTdedozhih5XPnwbgFCDq+ZSi9v9p4Q7XzaYeS8OE/8nPIiCmvqCIpwT+2WXoaxPLiteoopUEjOueNkat8WVQfz57Vpz7SPOnojoeJlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QmDJLems; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lys1JKn8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiYCd009205;
	Tue, 5 Nov 2024 15:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OZSjq9BqTb/tLC1FIE
	DZJNKnuhx3hUKUsw6Cl1miXL4=; b=QmDJLems4NY00JGiQvqfUGEGeg/0QArDCs
	PxRetbYKd9P+gYQnvifIA1WgefdV/zdrANO9AQt+hrdSMfMsspTUYfXYjh0s/rj9
	DZRe92ZkI+42b6xca1gBZiL0QFoFJINUaxvuuvgT4DyeUvRKj8uJQK1avEP2vUke
	dpZayVuW6qUC/VSgpn2U+tgPmWVLYm+Fr5t9A7Ieth4j7bp0KDdrINAfGlbe1mz4
	NiTYztvEQ6LI0Wxj9EuysqElnlq0z7KEfb+u0XGtKEqsLvd5r4vorPvYt5mGe7uX
	L3iia3SvWOp/3bFNL0x3gAxHEarQZ2KytI56jeHvDegML48qqpMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt5hnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 15:07:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DORO6009824;
	Tue, 5 Nov 2024 15:07:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahdhuhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 15:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHTuW+aSMW3yVPxYSwrj6UtzlCl9DcXg3w6SteZb9fnIFcvSZF3J1xS1rjxqUBJPzSxQli4qukxEgA96kPoVydugcxjKu/LhGyKomIIVI4ZMyX2W+JFOAP0EcAs5TyRDXtYCuxvZ06DPkmbCfu8YDfpMfd1v/oEBF9Utd0TIq2yKL9CpIYuaNqvfxlzkRYePkfW8c65Qx5km7jzEUlRT4wX4oNKbqECIJR31rvQDvcrif2R8R8REr7tmAqvlgwGLIuE9BnUP7vBbTSUBhq0miPyer4RqzU1hC4sO3rPMfhMmDkT4RiQfCal24U/gNWUaos2cxprvRwJHpcthf9U+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZSjq9BqTb/tLC1FIEDZJNKnuhx3hUKUsw6Cl1miXL4=;
 b=gvNIJ16MOdd9MtDTBU6b92WoX6ZhioLusiwncqY3Gnb+EzifsCEepR0+CkBSPz+11aTvlGXzvEtInDF1uoRgtpm/eyvtSSSoqlFTSaNVwue6AX501RXlIpj3jFOSZkJAN6pGYOofGzulmU3J7qfMkCoBkG6hGSK8dATtin0yvZCfTLuF52tDVvbggUGY90uDou1lC4tuIRj39O38anLjfcm2DqWcwwg+7eWVcqfDPYpY1Di2yNtKI6Rd2MTZ1TZchCcqgL+70dfTnSuwr71xRPBQ9xL6hCgHKJ/fPSxqgVcja+t6PN5zKXm/CJGSaTigJP+vvGY8UzR1reGimy6dUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZSjq9BqTb/tLC1FIEDZJNKnuhx3hUKUsw6Cl1miXL4=;
 b=lys1JKn8mn3mJ0ZuKnE6/QZFCt/cTCcmm/L8bsNSoBgVLA1NOfwfM4q7lvvLSbjVcKN05QHoIv6QFYt2G+fV4wSZ76HFbpQXIA8YIziMn5zDVLs8Na6tiUi/SwIZrZXjaroZUjuftisAHrlVajv21Iz6SyIJgQJKio1LG30wXU8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:07:04 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 15:07:04 +0000
Date: Tue, 5 Nov 2024 10:07:03 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove unnecessary page_table_lock on stack expansion
Message-ID: <y7kqvhytmmcxw5kp4pcncr7i2y5rozj2tuqzttqkavlalx3bo5@7jufqeyyntor>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: f84c3653-b043-4f21-27a0-08dcfdab823c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8Ceby9+EVYuIekk5RGhsJsK1aeiqdohMr9LUaOvSt+qiF4JrWS+cB8LM3MG?=
 =?us-ascii?Q?ZtanqvrBzu8HarfbsAvaB8r2XByVd5b4vgtWLbhmVHxGNM9LVVVmJqUcyB0r?=
 =?us-ascii?Q?10E/gF9VMNVAt07B3Q2T00PhMOuVo2OkPimNO4GBCI2ESdxS0jZh+3rnVpKK?=
 =?us-ascii?Q?sfVX6CG3/USQtNLmBDvnBQVERnhZokmCkyRzmVWkivN7zyD0+PUYM5yvOhoY?=
 =?us-ascii?Q?94kSeTjdf/T+DgnfPA8UP0x2wtPjRMHu7Uo0tHgf+xWsWJZqGNyYRlHpt26c?=
 =?us-ascii?Q?bl5VA3Vv9BufZ8M3KlhwYQoh/Ca0xRQiJUGBioJGk2tqHxCO+f8mRHYrAWbI?=
 =?us-ascii?Q?geN+GhVfvu6IaZatqs3zWmn1Da5gwKl+/Y90L7NCLvP5y8WloAYfdAUnPhMt?=
 =?us-ascii?Q?sx/V8v3K8hsZCU/yr8e9kaK08FqD1MK7594BNP7hjVF3varJb8jjQ2ubXL8W?=
 =?us-ascii?Q?fOp7fO4fm48s5hPUGD/TkXhJHJSxU6sXcLHBHoNQEpYVr81eOCLqUKxdal3q?=
 =?us-ascii?Q?2CXxEnuLxU8IV5JbtDkY0LK7UBivGHatOtDa6Lhn1EH2KZ7ksma+Mb+iXUTd?=
 =?us-ascii?Q?PjDP1z434mpFAHRj/QZOOWjtWnz/PR8Qn6QEtoRkh/JnNYBjrQXuUAn0/6fi?=
 =?us-ascii?Q?oMfQWNoDAsyyOvu7Szn2P95KVsK/3Fxe/UvYtmVhGRUzyrXWUXtWOtYkogSS?=
 =?us-ascii?Q?O6e22DGB6G1RDNwcqIh4vCT6gtIN0T+Et4XmM/c2q3cryoywrPMtC6KZOHnC?=
 =?us-ascii?Q?6yeGImpHY8mA7RbcSErVe4RbM5qmuKXwqfpYj688Vk7WccTW4L6+SLf99G1V?=
 =?us-ascii?Q?12aQE3gc9xPd6gsvs0bPi4Qn33Nz1MiECNRQHj0sx43swMTqdR5fQGja5BvD?=
 =?us-ascii?Q?HJe2S6oYssIJ0RUiMzP/D1atNEyVsuupxeuyWZyT8KT2S/6i4W0QHbvyqoOM?=
 =?us-ascii?Q?R/MK8UbA3qKHqwAY+Y70kZpkplbPPSd5figYsVPQ1bUI4+sIbZnIkvbggMbj?=
 =?us-ascii?Q?zy7ut3kmrSoR1xEfr710Ql+tZTrV25e7U0OJSg2nePcfymPtfg7TLqzublK9?=
 =?us-ascii?Q?uREuMhVGkKUazL4NHyf0N8dz85zOzJbVm18kASiTnrLluiiwAAmwD/W2o46P?=
 =?us-ascii?Q?Xy0/3b38rBVj2KJU7MPnmtyDC19FufXZBrUspIvZQPsE1JNdkOo2fyfMSxZ7?=
 =?us-ascii?Q?FeuUMNAFE2c6RB3IsWBOV0LMIWrfC+Vg6hhXrh50GiO69iTDowwO/IpD9vkx?=
 =?us-ascii?Q?LoQE1wDadb+ztVL5AbrqZRW8bhQ2bZpba7hWYNTxkfXyHmePuuHmkQsQclqC?=
 =?us-ascii?Q?3/02QytLJNg2fWUD6rooorlz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4f9xLbKbe5mzZpBLuwrXILTCjhlrrkW8yddLyVLl8g9NnNMY3FermMtZ1se4?=
 =?us-ascii?Q?jB0mU7WW95k6HnENIp7GaSZt2BC8mxC+WyV17A3SsekKIf4jJGdt/DIyCbiZ?=
 =?us-ascii?Q?yqiivEw3zkXzwfkP5pkW6LviodIAaTwGaTdoOPbKO7B9oD0Bd0gfByHsbd4+?=
 =?us-ascii?Q?EesrUEfaNgiuSz6FSr9THA83QRkuzT8TEqP5kXOesSSs29xAg0+5RG6GOilI?=
 =?us-ascii?Q?IoX7SioY8Og2mNCSyqEAWFfXcbO1o+wQOanPJwsNe0DuMiXSFg7Ivs6RlVBE?=
 =?us-ascii?Q?nOgQkdPsJ4eOxWKj9LSey4pyy0U/R6emfezWGNEJ0HaDTeeuWZnzI2pzPRQw?=
 =?us-ascii?Q?zK8jvuSQOEhMbfq6BB6lFWJXwjIRWduVpzcDKU+Qj5QJAvYIqCuKEtP6ZSQm?=
 =?us-ascii?Q?tvCEmktdWzrqhV61dwr1UsFpFRxJ8ZIln0jkNWy9b1isB9+pYoYQtp4zz2y3?=
 =?us-ascii?Q?bmJ/qQRkx/p4rKnzOCdHZSr/acp09WkU8S61+BQOi9dq1Xwjk6FTz3pj3ShC?=
 =?us-ascii?Q?jbcWyXc5HSlW+BFvakw9ZCGFIKUTKuWp0yYSWRI2An4GXs3hQsFwzNV+WUS3?=
 =?us-ascii?Q?+RSgExmZrd2svqd0+qlOZh0z8BQ61Ad9llRf6brM9GhDnTa1PQLplcOoh+ep?=
 =?us-ascii?Q?O6PHBH8Lk+ku4TIo5fEfKlzfh4YcMDbVX3ggwD9ldPnFYP1TRnhC7KfcX/O5?=
 =?us-ascii?Q?KAobndpDbg92Y24TH6pkyx/8fYKCc0kHr7FzjlIHxa6qNLF/N5VJ9FfICWzP?=
 =?us-ascii?Q?uOYTuhLk/fqlSvojzvZJr1rE0+zFkj6gtm3ZJ5PkuDVe6F0GTs4ODWL/jPiX?=
 =?us-ascii?Q?oD96omds8sjNps74msyYkHBB1dM0HkHuTPEz6lOqvR5gHvP71v54pz1jbJ+F?=
 =?us-ascii?Q?dyDTnW++cY4f+MiP4Ibkive7wpg7DM1A9g0W/nl/JkJhlL4ZOTdsyCJ/hkmp?=
 =?us-ascii?Q?ATSRa/vbZPeU86k0tBTfOWAjwz8bik3zJydX0roxYKjJl2XIIIwjfNivyso0?=
 =?us-ascii?Q?rR2cI5ChqKc6dIlOIBNsPOw2HRLXT6Jig4aPdIJJEbPw2SOl0pBl4WvjCi5J?=
 =?us-ascii?Q?htQdMUVWMxW1ToEKt4Ir8UEQYWMe/h/PUMUyU47MyYpiocleRbcA9c7XVe7u?=
 =?us-ascii?Q?zUk9XnvHyxMti3xL33odwssL7bXBts/n07NGqUYAQFOoUT3zf8fWFBED7D+I?=
 =?us-ascii?Q?vrjq/kA4W+vVswSENL2RtwIy1IN84uRGnhlkf0kv3TxOxIktJczPUBZ9nLx5?=
 =?us-ascii?Q?EWbIVDCyibu/jQuB0PFj1Ek9F1AsaTwM72pvNYIcX5xlvyyVbrBXe3PjmlBG?=
 =?us-ascii?Q?SWaO9SlbkIq9qW+knaXVsbNlknlUni3h03gzn0MWLhUtHg4M4Q67YPl5vhSq?=
 =?us-ascii?Q?9hhYJUOIbeASrzQ1ApDR0wzyh3uW+GpICXxb88JC1KrxxwweaUlE1IVTJvU8?=
 =?us-ascii?Q?OKi0kNJLDWaXjMXutrVNoMmidKD3StMRv33N51DywVNHe9jWXnetltqMu+Gj?=
 =?us-ascii?Q?gjhy8F/8hoetZPWghNZGUKWSICehX5wrcBiEWXzDhXLe6hGFwaonB5LFq6Ji?=
 =?us-ascii?Q?cPytuJfSFlfze2VyhBu+ZExg7gVL3xRZhXxNfBtq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pN9iLs7rcufPjVH3TwYhgBZjSLk3IY2fR8mduA5iyfsUOJRWijR1Pp+XGGviS2oZkBlfEWk8el5E/h6x0XAbmicifgMRZuoLf/1lYdq/cm6LAd+d0s0N555F4qDzkOVDFW4VwV4jmWrMrW9WWXayApZscYJR8slqsu0TDX9WpBAxDVf4pRmXtzZsVK8MdCmbbtR96qKyQv7dnvnhLRdRuSvUXYBE872N9hs/WpTZIcN3XEsVYnml3YIjfYcrSLavkO8moL2cNiDIXzQqsBNP4QruWCWLxVDDa5r8YkRM84RilL/LYCzQ5FxVfHVYorhCvmfCBOIJmjSzKZ4el0VvknHXhMZP8mRaXKK2aNwrWaCfbZL9jQfbiumLVkKQAdOPvGpcKGsXhLXZ6+3U9foZg6jFZ6jzUoOmMYqr4YdwC6BfYVcVcL7Aek1tNdILl8LgwbMYnmA03W1g3UKKsk/I+ZUkeYTYv+jxUHangZ5XbZyDMsOhNAsR03nyYdRvFDEOVZa/rXL82ZmIHVHBzb0dRTKC7L0g7F3U5anffpE9X19TpitOL/wRZUVc27woUE8F7bfd7VdM3cB5E3iKsxf5yI3Q4T6s4qPpPSne7YWk1eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84c3653-b043-4f21-27a0-08dcfdab823c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:07:04.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Gtq8ZPvLtHtbNtwN1yKXbXfgo2JRriSgFQ2cHoreKAEZ2F4+Lm7pL6qFDJjCNRiaVNJ3f5BbwwPV4VbGRXvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411050117
X-Proofpoint-GUID: K5j6fgt1JrHzh3l35MD0bN2HChrgjj3K
X-Proofpoint-ORIG-GUID: K5j6fgt1JrHzh3l35MD0bN2HChrgjj3K

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241101 14:46]:
> Ever since commit 8d7071af8907 ("mm: always expand the stack with the mmap
> write lock held") we have been expanding the stack with the mmap write lock
> held.
> 
> This is true in all code paths:
> 
> get_arg_page()
>   -> expand_downwards()
> setup_arg_pages()
>   -> expand_stack_locked()
>     -> expand_downwards() / expand_upwards()
> lock_mm_and_find_vma()
>   -> expand_stack_locked()
>     -> expand_downwards() / expand_upwards()
> create_elf_tables()
>   -> find_extend_vma_locked()
>     -> expand_stack_locked()
> expand_stack()
>   -> vma_expand_down()
>     -> expand_downwards()
> expand_stack()
>   -> vma_expand_up()
>     -> expand_upwards()
> 
> Each of which acquire the mmap write lock before doing so. Despite this, we
> maintain code that acquires a page table lock in the expand_upwards() and
> expand_downwards() code, stating that we hold a shared mmap lock and thus
> this is necessary.
> 
> It is not, we do not have to worry about concurrent VMA expansions so we
> can simply drop this, and update comments accordingly.
> 
> We do not even need be concerned with racing page faults, as
> vma_start_write() is invoked in both cases.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mmap.c | 38 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f904b3bba962..386429f7db5a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1039,6 +1039,8 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  	if (!(vma->vm_flags & VM_GROWSUP))
>  		return -EFAULT;
>  
> +	mmap_assert_write_locked(mm);
> +
>  	/* Guard against exceeding limits of the address space. */
>  	address &= PAGE_MASK;
>  	if (address >= (TASK_SIZE & PAGE_MASK))
> @@ -1074,11 +1076,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  
>  	/* Lock the VMA before expanding to prevent concurrent page faults */
>  	vma_start_write(vma);
> -	/*
> -	 * vma->vm_start/vm_end cannot change under us because the caller
> -	 * is required to hold the mmap_lock in read mode.  We need the
> -	 * anon_vma lock to serialize against concurrent expand_stacks.
> -	 */
> +	/* We update the anon VMA tree. */
>  	anon_vma_lock_write(vma->anon_vma);
>  
>  	/* Somebody else might have raced and expanded it already */
> @@ -1092,16 +1090,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
>  			error = acct_stack_growth(vma, size, grow);
>  			if (!error) {
> -				/*
> -				 * We only hold a shared mmap_lock lock here, so
> -				 * we need to protect against concurrent vma
> -				 * expansions.  anon_vma_lock_write() doesn't
> -				 * help here, as we don't guarantee that all
> -				 * growable vmas in a mm share the same root
> -				 * anon vma.  So, we reuse mm->page_table_lock
> -				 * to guard against concurrent vma expansions.
> -				 */
> -				spin_lock(&mm->page_table_lock);
>  				if (vma->vm_flags & VM_LOCKED)
>  					mm->locked_vm += grow;
>  				vm_stat_account(mm, vma->vm_flags, grow);
> @@ -1110,7 +1098,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  				/* Overwrite old entry in mtree. */
>  				vma_iter_store(&vmi, vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
> -				spin_unlock(&mm->page_table_lock);
>  
>  				perf_event_mmap(vma);
>  			}
> @@ -1137,6 +1124,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  	if (!(vma->vm_flags & VM_GROWSDOWN))
>  		return -EFAULT;
>  
> +	mmap_assert_write_locked(mm);
> +
>  	address &= PAGE_MASK;
>  	if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
>  		return -EPERM;
> @@ -1166,11 +1155,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  
>  	/* Lock the VMA before expanding to prevent concurrent page faults */
>  	vma_start_write(vma);
> -	/*
> -	 * vma->vm_start/vm_end cannot change under us because the caller
> -	 * is required to hold the mmap_lock in read mode.  We need the
> -	 * anon_vma lock to serialize against concurrent expand_stacks.
> -	 */
> +	/* We update the anon VMA tree. */
>  	anon_vma_lock_write(vma->anon_vma);
>  
>  	/* Somebody else might have raced and expanded it already */
> @@ -1184,16 +1169,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  		if (grow <= vma->vm_pgoff) {
>  			error = acct_stack_growth(vma, size, grow);
>  			if (!error) {
> -				/*
> -				 * We only hold a shared mmap_lock lock here, so
> -				 * we need to protect against concurrent vma
> -				 * expansions.  anon_vma_lock_write() doesn't
> -				 * help here, as we don't guarantee that all
> -				 * growable vmas in a mm share the same root
> -				 * anon vma.  So, we reuse mm->page_table_lock
> -				 * to guard against concurrent vma expansions.
> -				 */
> -				spin_lock(&mm->page_table_lock);
>  				if (vma->vm_flags & VM_LOCKED)
>  					mm->locked_vm += grow;
>  				vm_stat_account(mm, vma->vm_flags, grow);
> @@ -1203,7 +1178,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  				/* Overwrite old entry in mtree. */
>  				vma_iter_store(&vmi, vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
> -				spin_unlock(&mm->page_table_lock);
>  
>  				perf_event_mmap(vma);
>  			}
> -- 
> 2.47.0
> 

