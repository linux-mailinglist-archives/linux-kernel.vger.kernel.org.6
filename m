Return-Path: <linux-kernel+bounces-283368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF294F190
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E664A1F236A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E680184529;
	Mon, 12 Aug 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mH1osZnA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tARoLelC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C4183CD7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476187; cv=fail; b=aCMsehItbzw3in7KMQnzQIbMr49SvYl3AJYzezvaxI7nuR3BkQavLcWwqCOCYVNCUPiNLCt6E7GEoFNXKK6NyagEMD5RgLmzHMd8SudMpPQHS0OKtYA+lLgWbD8l9+PRl5XMwzog1kbN6ywo/M1rS4hZkTYFIDz/Jryb9b+LZQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476187; c=relaxed/simple;
	bh=oiT8c5ZoyPoxC5gmYM3PPAUzqw8BeWvHf5g0mOA31lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZLQzle8THhd08NJq3hZ/+uoJpQvEyDh04pmKkQ84kufsNAV5JcJoZku9/7Dc1wgThk0yvWMIO4Srxbb8/FwVA8SKqGifIUcmYJFywhKv8E5Km3ZHJtzEEoGaAKmyth2g6rvIUfZA5wbgx6/0+T9Bt4yDVh0LIqDTKFEoYrcCmi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mH1osZnA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tARoLelC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CEtbcL022774;
	Mon, 12 Aug 2024 15:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=RE2lvoAKqeDKslI24jw+y/uK5mgCa4ikq7K/75CfTBs=; b=
	mH1osZnAnbL2s2Ey3UHKx6g9EmdvqS9/zM33INspZpbEcpaCkwU/P0pzLLHE+6Nd
	K1pGPOTjC7Ti1D2S6AuBiAy+5q1oZRs5+KelgwhmgXl7GUeJ/C7g6py1soKsnsB3
	a4yW6jM7SqT3lJDfaX4ri6ez91mr11hHS0Ru8/1+y7apRpzh8OIWVM7dKlQZP4V4
	UWtOLcvhMQydFEki2mVMlOXE9is3/e0APVbhmMRPjzP6uR1rATUc4XlI9vGS+29f
	6Hrnp45ZJsQk+YWukCWzKIMTNwJoSSb0DPJL6OajZm+Giwm/a5Qo5yfP1r1F4FSf
	ZUyiFHSDEDM0DeQ2/ATGoA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0392uv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 15:22:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CE7AVq010840;
	Mon, 12 Aug 2024 15:22:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn798a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 15:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzVJaT6o+MuYo+2xxzO3SD7dKJSaMjdrAu8L6ZsN48/cqhty9KCBS3sYIsJhjwd4iUolbSDBiA1P3x0zhgzWsA8Umbdym39sIKndpkJJGcQ60eGJKxdWp528IlhuVnr+JJlWbdwTmRBGJ5/wFpwTiKx+ynRV3iXem5OjSZZLsVtTpzE2SID+mDY/WzzXU2jkYZCJz7lovWFkMuLgJGNrqV4IsIdMz+078fYlBOXhpWf1wv91NrPfkHVAAFDkhX3wVM9c57NePdoAaET/FaA5GB5v33mWKN7SXYhY432zUjPcF1rJpml59Qcpd7AjTzsk8Q5mPqozzUJYFk/GQHtV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE2lvoAKqeDKslI24jw+y/uK5mgCa4ikq7K/75CfTBs=;
 b=sNolYzZpBMV5Jz2Qq6Spvi4V5NBDnNhptyijvzoNSolieGZkSHdWtq6lrfRBH/IjrawaOp52bkBpK84Z1EDHTAxdsr21xxJMF/aeM3r9LPbj03U8/dCvX16OV7WDdd+5zbrh2eCDmm8JJ2EDRTAES7OZj3ZHDj1RdyYdxpzZG/HK6b7SYSssQ4cybBBjIkzchfknZP5M5GVdhbRoBWDrM8f2Hq5SGTK7ZgTx/d7j7x526wZkrWww2lfKNS4CitbkhHoNWkhetHELGSDu5Bu2dwx/eM8KIAFxUjVIm6TTbb7kdCFXris++WbXOA0Ak4+utf5fuBCdy+r35dH3LHKWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE2lvoAKqeDKslI24jw+y/uK5mgCa4ikq7K/75CfTBs=;
 b=tARoLelCiOjJEtxPh9FyHSJnfrzfuPCIz41oXnScHt6Iqyt0R/Fv1CIFYKAiuxVvrF7G0uY52j8CIb2v8L02DZzVxrvZDVYnHZCb/JoQBE7ZuC38zLnTEXmbRcpm1hGblrWVkg2tix0NPXQtZyC06x+BUUbSiDnr+aZhFcwpGmU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Mon, 12 Aug
 2024 15:22:45 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 15:22:45 +0000
Date: Mon, 12 Aug 2024 11:22:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 4/6] mm/mremap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <lkrt2eatc2cl5ai67femr7xnbewayxrthxz3yjtyazxy4nq3lq@h3qqce5tovvg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	jeffxu@google.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-5-pedro.falcato@gmail.com>
 <52wapi4gdnh3i2oiyk44utrco4ck5zph5mikoejfjrlfz2pwhe@eyiaozi4q23x>
 <CAKbZUD102gMDJeryA600LJ--GpKOm8q_18i-zhqWYXKvHNU1yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKbZUD102gMDJeryA600LJ--GpKOm8q_18i-zhqWYXKvHNU1yQ@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4673:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbd6271-67b5-40bd-2d94-08dcbae29dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVFhdmcwZlFpdVh4L0IyejVDdEZGSHQvTlQ3Ly8ybFAzNzdnempaNEJqYWds?=
 =?utf-8?B?SVZrbVF0RmZJK0hFK3NFTDY1NHFuVjlDbXYyQjB0VWRaMytRNHlpNmk1QlJL?=
 =?utf-8?B?T2x1YVh0QXIyYnFNM01CYzcvNkJIYjhvTlJ4NW82OE1xMW04MGE0R3VUTy9M?=
 =?utf-8?B?VTExcTlJSW15U2N2OCtoalFEdFVHVm1xVmo1WWJSQTVpYVkzZ010UWdoTkQv?=
 =?utf-8?B?MDhvSjBVM0M0eTMwRHBRMlZqOWo2MXhWU3pCVTdvT0l6M3FWTmExMGppdGNT?=
 =?utf-8?B?MDZjNFZFdDNLZUhseFA3SUY0MVRDYVpuTkpNdWoxNnZqWFloa1B6UUt1VkxZ?=
 =?utf-8?B?VUI0azNaQVVFNFZTa2FRTW9OVXdNVzZuSmhlZ3dCTURoTW5mUHZiQ2RjUjdZ?=
 =?utf-8?B?WkJQV2dTYks5b0NWY0htdVNFbWFWSmNRd0d4aks3MllwQkNvaHhTWWE5TkFT?=
 =?utf-8?B?VHJLbUhuSGFhOEdTM29iVnkzeDlJVE02S25YSSt0SnpBazBhRG9HQmRGWWdx?=
 =?utf-8?B?bzZUOTAySjMrRnJQa1V6VjRpdFhDMWV4V25VSm5DSFpFVWR0VHNDNmJZOTJ3?=
 =?utf-8?B?dmpwRlVLTVBKMnZPK2gveUsva2pvVEhTWjl6UURkVHgreDhLcFRjMGhPWDc2?=
 =?utf-8?B?a0MvdmtKTjdsbjE3dmFmYmNmblpSbkdtbmZtajFBTU9kTXlPM2JMbUZ6ZVpi?=
 =?utf-8?B?UEI4VVRWOXJaL3FWbUthS05IendkUWxobkd5TDU1QlE5OGVGUHNsdmk0WG9m?=
 =?utf-8?B?TlZlZU9rWklONkx4MXkzVWxVTjZIeXlYc2ZwWUYrc1hhd3N1NzJLSDdMV3NG?=
 =?utf-8?B?NjlWbTdQUWpta05RaU5oOXJKMTBwVWlSdDJBc1A2dTIvdDluR1Y4TGNnOUQ1?=
 =?utf-8?B?UjcvakJSVVJoYWlFSHVXcjlCS2pNT0hzVlR0aktKVmpyVithYmM4MXpuTVo1?=
 =?utf-8?B?UGp2U0txelp6TElCb0UzYjIyREhSMm02V1VzVXhYeFUxMnNrVXlYNlg5dTgv?=
 =?utf-8?B?T05IcHYyQzl6ZDEraWhxbGVUNDJSeTdiYXY2em56YnUvOTd2N21XWTRaRHFF?=
 =?utf-8?B?eEtuajZVNUQyZVNacTJ4MnppWXlUMHQvR3dJcjFtam4rM2dKVU0xVlpOMitU?=
 =?utf-8?B?bExoZ2JwTE91TkV0c2hqVk91ZFdCOERueENaak1tN1NhR0p1VWJqaVlnbkhG?=
 =?utf-8?B?T2RwSjFCMzJ4QzJUOFRrbFZDeE1sV29xRUdWL2V2NkNra0swQ0dpeWdHVTZm?=
 =?utf-8?B?blJZS2RibnVrMXdpdzc1S1dleWlkZDdIL3F6R05yR25MYXo2blZ3dnF6d0Ra?=
 =?utf-8?B?Q3YybE4wOUNzOWg3TkhlckJSUnBMUDZFUzhUa3FFRE1pcHZIZ0tDZjFTaEVv?=
 =?utf-8?B?Tm5JM3V3aHBxTktQbjVWUWxhM1d3eDg0QWo2RmEyVDR3TDU0dEFEUFpBenl4?=
 =?utf-8?B?cXFsbmZKUWNXOUNwWFluVVpqZVp1VlY2SlRmWkg3UGNxZ0Q4bjN3N29nWXMy?=
 =?utf-8?B?eWVCOGNGWnhDeHJEZ1Rsbm1Kd2J3RzFDM2ZsbzV5NnJvVzVFMG1hdE5vOXlX?=
 =?utf-8?B?NnA5M3dpb1htUUgyTGt5eW1VemxvUFI1K1RJeXl5MUswaHhzT0lybGwxaW9y?=
 =?utf-8?B?QWJDRzFseWNSNnJHY3ZKYkZFeVdPMnJydjZkcm4vRnBQZVNXZWpHeFhxU0ZK?=
 =?utf-8?B?cytyR0lYbEhPYTVGMzlncnBMRnpEUnNpUE10UjBubGdzeHNuL2FGZnRiS2E1?=
 =?utf-8?B?MHRabWZERjVnaFQxYXFhd1NTelJiVXQ3czlyWWVFMXJlNW1sTTlyeFRuUnlh?=
 =?utf-8?B?VGlwVTRHVndlNUJNVzdCZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnpRRDdMMk1GQ0ErQlZGcmVTYkFuTWEvUVFBbkJsWnQ4VkhENjV1TXg0MitC?=
 =?utf-8?B?WnZ5dGNlbHprS0l4akJhWkdsaTY4dEZ2UGMxbFNnazBqc3Y5ZFd2b0VyVUpP?=
 =?utf-8?B?b0N2K2t5Tk56NDhRZWhJOU1qRWZkNWo1YW11VDRLRVRsd1RTVGYxcExoYW44?=
 =?utf-8?B?NHk3dUZEWDhGTkhzUDJGYjFwV1NYU2RUU1MvSUoyOUFpZmR6dGg1NXVjOE9K?=
 =?utf-8?B?b3BJbllwcjVlWGsxODFKZXBXdndhZzBhNDZ1bEM0Ylk4ZnJPczBHRjVqbGhZ?=
 =?utf-8?B?bTZoUUVuRmZWbGlEb0kzWmlvajVncC9WTlp4OUphZSs5VlROOTIrRmxSL1k5?=
 =?utf-8?B?c0VDVU9wVVFhSVZXWm9BaGVLbUJ3V3NMNS9ReWYrTmo2K3M2YW1hYU9QcWVC?=
 =?utf-8?B?QzBnVDdzZTgzV0tLZDh2UnB6OFp6Znhyc2JWdWtDRWYwdGJOd01lY1JkeGpZ?=
 =?utf-8?B?ZStsOU1YR2ZObUZjUmx3TzJBZUR5WUd2VVBrOFZLQ0haUnZWQTB1NXFxNTgx?=
 =?utf-8?B?VkI4STUyYWNhSUpBNERlVTZIa0RIai9MVlFVTXJRbTV2WXduQ01VaUdjYmw3?=
 =?utf-8?B?NFBlaXNjbFBnRzlMdFRndDd3VnU4aVJuODgvek1hdmxjV3ZXMUptMUlydnhs?=
 =?utf-8?B?YUx4RlNUbkdUemVzUG0xSDdJOHAxYVp1WjBlS0pnb0w5d3U1QzkrOXVGQnNU?=
 =?utf-8?B?bmVIbTd6M2FxMHBzSWV1WHVVd2JBN3BOYWxIbG91OSsweGppcHBSY0J4V2di?=
 =?utf-8?B?TlpCS2MxNkVxSi9McG1sNGdxSHZKZGRpZEJldUxONVNkT0VleEw4SE0yVDRU?=
 =?utf-8?B?MWd1WENGdlE3MUN1NUh4NHNackhIeVZxNitMS0ZQVWlFU3h4bGE3d29OTTM1?=
 =?utf-8?B?aGZTMCtSMkdRZ1lLeW1OVE5CeXhtRkNLdm5xZlVvaUtjNlRVVkhXTUNzY2dx?=
 =?utf-8?B?b2hBVTFsYlg4QVlKdVE2d3dSclgzWnlRbDBabkVRQjNCb0pRL2o5UGc1MVVR?=
 =?utf-8?B?TlVvZUxQb1Q2UFpwTnBVd3F6RHJQeEE5VEQ3NVlidGxsSmxUcCt6ZHkyWjNY?=
 =?utf-8?B?Ym5jaFZtSjRKUFoxOUkyYjVSQW56aVFBLzZ5dUxjVDVQWWFQd3RTcHBkZTAv?=
 =?utf-8?B?Y1I1SEtEQWpnaGdsUERaSXhFM3d6am1uRS9admkxVXBncG8xZ24zY0FUbHhV?=
 =?utf-8?B?Vnk1VnVkdkR3Z2RxOFhCeUlNMlcwS0JkQVc4Uys3UlVnM0pHMWVuSWd5U3dz?=
 =?utf-8?B?Ulo0U0NiSk5GZ2x1VEF0bHVGUE92c1dyakVRbnpIYUx0dzdsWXFXU2hubkln?=
 =?utf-8?B?SGNkbThLU2xPN0RONFE2TlVFQ3FJdWVvbWxPMk9DL0xDZklhMkExN1FWdkY2?=
 =?utf-8?B?SU5JTFJZTkFQb1RpQUVueUgremd5Yy9TR0tsdENaNFZHd1dwU0U2YVQrUDdB?=
 =?utf-8?B?UUZSdEYrL0lEbWJYMUp5Y3dYMklGcHZmMmwzVDZQN1RkRmdGRGxpaEN1MzMv?=
 =?utf-8?B?QmxneVpJaklGejB4TUZTZTlzYThGdU1OMmxPYnBaWjJUVnppWVhQbWxVWDJE?=
 =?utf-8?B?bDR4VlFTT0VmaWNwTzlmRFRLN01LZmVFaU13YTB6a3ROcGpVRGo5MGxiZkds?=
 =?utf-8?B?STdKWWt1cGtmcjQyK0prK0sxWnlKSFhZRVY2ZXRNdVFGRmUvcndlWmptcjVT?=
 =?utf-8?B?SFFFTmFEK2lrbGpiM2w0VkVxNmFIZ3ptMXZCTTE4a1g5ZEJBWEVGTVQwWjZo?=
 =?utf-8?B?c0dJRUVmTllVM1pkSWdTT2x5bDJQU3lLUEx5dkxiR2VOcGFFNmlZVDFqbVhs?=
 =?utf-8?B?cUQyVHlhREViY1V5a1JzVnk4T3dCQWt6N0lFMDY0cjFjbWlacEpGQ0xMbXFG?=
 =?utf-8?B?SkhiMHY0bDhvWTZUZzh5eU14UCtES1diUCswR3AybEJjNmNNSjdxQlBnK0RK?=
 =?utf-8?B?cHhlNWN1Sm1HY2MzZ3NSSVhPSzhlK3R0SG0zekpCMVFaelJKeDJxZnBkNUlj?=
 =?utf-8?B?ck9wbUYwTWVBVzd2L0FsazhubkIvTzE1MWZuZlQ3T2d1R1RnVFBVUitoYk1v?=
 =?utf-8?B?TmJwSEVGTXNzTnZMQkJkREd1dVhqSVRFcEd4VXFsRWxwcnM3Q04zOGVweGxl?=
 =?utf-8?Q?SziBBH0AGiXIlsA0OBRG7XkWY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	knVoHRZRXv4+UyuGVDXJtB5lOyFAEDnnqJRrqwClBby56jSKnKraCqh/LD8B+W7vTgo+eVIqRWYvJy/YPfKmYes6Oe9/GpyQiY1pBJAenyZQIEJR/C8g4DA4gasBoIv9eOfzjGbHJjk2YCl4jQDxjnP9tgUGUR5pPExzyiolGRchvvM0acHlCsfpkHexvNqP8MqkclmUaG7T41dg8U+bbKCTl/4/YHFip6Lh/MRrmnJfImBw4RevzSDaTxGgfwjf48boPELvMATU3ZtUX5PUT6sdO+Gq40M9bQzcxubTO9zBJ2T4I54eJV1kbkFtHFXwxfqEUD3QJ70DermGv4bCqnFYVvNNqFdVh1oPWdhKSn7iP8JKfHcIlz6SWmWwYOIhyPgM+82HlIM/HD5S2h1DH1ZKMztZaHWI+a6nO6mKW9kh3aYrvhHeEbg3oMo7mXPxQ5ik08ofp7MrqRnli6SWbPbkLOCJOBfMgXgMOJuw7x+7zjoSz9NJ/iwqXy57tDvel/10/XDinW6bMDS0Osb8O1sxSlxZplPfqW8DB/rJxmRmW/UavuD1JwFAmFqPlMvwQVy6Idl6vJMgMP9SugOyqvJ1otSZpqU8qmhjgq5TTbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbd6271-67b5-40bd-2d94-08dcbae29dab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 15:22:45.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjTjBKGSEdPjTwMKP7jLAUEhDRSTxyY86knLeLHBANd1pXW6ssXoKeE1OGrz+5MJs6fvAKr40hPUewMd98XQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120113
X-Proofpoint-ORIG-GUID: ltS4joYMz7brR-8DbDyugwvTPeyitQi3
X-Proofpoint-GUID: ltS4joYMz7brR-8DbDyugwvTPeyitQi3

* Pedro Falcato <pedro.falcato@gmail.com> [240809 14:45]:
> On Fri, Aug 9, 2024 at 5:06=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > Delegate all can_modify checks to the proper places. Unmap checks are
> > > done in do_unmap (et al).
> > >
> > > This patch allows for mremap partial failure in certain cases (for
> > > instance, when destination VMAs aren't sealed, but the source VMA is)=
.
> > > It shouldn't be too troublesome, as you'd need to go out of your way =
to
> > > do illegal operations on a VMA.
> >
> > As mseal() is supposed to be a security thing, is the illegal operation
> > not a concern?
>=20
> My 3 cents (note: I'm not a security guy):
>=20
> - Linux m*() operations have been allowed to partially fail for ages.
> POSIX only disallows this in the munmap case (which is why we need all
> that detached VMA logic), but not in any other case. We have a lot of
> other failure points in these syscalls, and would require extensive
> refactoring to patch this up (very likely with an inevitable
> performance regression, as we saw in this case).
>=20
> - Despite allowing for partial failure, this patch set always keeps
> the sealed VMAs untouched (so that invariant isn't broken). The munmap
> semantics remain untouched (and POSIXly correct) due to the detached
> VMA logic.
>=20
> - I personally have not heard of a single attack making use of this,
> and the performance hit is very measurable and exists _for every
> user_, despite mseal being a very niche feature (I cannot find a
> single user of mseal upstream, both in debian code search, github,
> chromium, v8, glibc, and what have you).
>=20

...

I really have no disagreement with the above statements, but looking at
this further: vma_to_resize() is called in 2 places:
1. mremap() syscall
mremap() calls vma_lookup() and then later calls vma_to_resize() which
also calls vma_lookup() in the first 5 lines of the function.

2. mremap_to() static function
mremap_to() is called only from mreamp(), but earlier than
vma_to_resize().

If we move the vma check to mremap() after finding the vma, then we can
avoid partial failures due to mseal().  We should probably check as much
as possible there, but that change would be too large to fix a
regression.

iow the check was in the wrong place and was the wrong check, but we can
use your check and move it up ~15 lines and everything will be the same
and faster.

For a later patch, there is an opportunity to even make this faster by
passing through the vma to vma_to_resize().  We could remove another
walk of the vma tree.  Probably not necessary to fix the regression, but
it would at least reduce the instruction count - if not a performance
increase (depending on cache use).

Thanks,
Liam


