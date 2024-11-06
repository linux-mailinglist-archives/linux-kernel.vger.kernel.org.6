Return-Path: <linux-kernel+bounces-398450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F280E9BF174
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968722830BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD132022DA;
	Wed,  6 Nov 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otUj7P0V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JDAK8Fir"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98F1E0DA1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906445; cv=fail; b=XnscZ2MpOuyJ8RwWaafOgM0H/jlUXbibFo5bK1f3v+43ixMXm7Y9Mgg+VigMD8U0XzzhT3O3X+8lixj34uReWubtVoJQ24lG+dPx5rqkV13wis7514C5VQ5YKhvpKNcNjRabv5FYiYi/SVmvSyZFWSVHemode/kMrqrjL6w/aH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906445; c=relaxed/simple;
	bh=YTWambbONHQQsVKv3kqL7NakAZBAUP6cbReAWt4XZMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ruabh5frpJotKANskJhmVNN+t7By0gmTsWVmKXVYYUwcYRNuJw3ZuP8b1AyhwvMCFZRiHVqiRJNIJDI05VvkXq0IH3RHg1Vsl6lBZcQyh/lTVwxczu/u379yhYoIDUnyDGs6aUNfOPUOdipQJaJGL+RSKLeI+W2NI9sPI8bhVnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otUj7P0V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JDAK8Fir; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ci4Bn018061;
	Wed, 6 Nov 2024 15:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g2YE0mfDLPgmnm+D5excVZq1gTJQiA7yIn+Kah4PrT8=; b=
	otUj7P0VgMARd7sMlv95Qh3qhMEBhXTMoYA9xvJjsRH8pSH9xsHHXp70+Ymxs1z2
	3rfbr1cwKJvCkePFFhRlMilWiZgb6fM2/3SHkmqEWvjwDbKiRJcKrTi11UVz7y+4
	cY9faNaJzUSnherQOk+iTo5odD8Et/Z7toksNxO21XXF+vH423gri8V0sPyQCAjN
	ZprYyWyYDU5mDef6ZQO3/QIYWDBYYIlWy7J6+lsWg6n6f7hRg4JJerh2kpNbJwqB
	4eJs8i7GfMgVqKsdZw0U1bZ3hFvUHqpZrbT8q4B57/fTqBlYBdGHt1Sk7F8HQXVf
	PngRKbr9ocGsUXdvXmex3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsr3h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:20:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6E06Bo009108;
	Wed, 6 Nov 2024 15:20:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42naheymfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8puVQyVOA1mgn+HvKbglsdami3pfYQ99guhyhYVYz43wRALztDgA0DjnP8u0TPLOYHn+MOO7L+6orEL7BCrpnE11tHgaE1j9lDJSMYyFwDXiYEXfTFQLJISsh+mOM4HPcdIOKHmg1AilyyZDTpiE528zjDTeQmClbgZAw1ABVxBXPs4bFzKOkUxnGpI8XwmpEavNEILJ5j01UPtZ1WG4gUM0JOMD9zsyY4jnNlOzDGx93gN4zD4ZeFwWHmt8zWBGTuXzxER+FtlK0PFzT+OdcvVcm950qsw0po+c8vYbI9W/LYymvLyxwW/pEfMqkMJTVPT2VBy/ortQunlVcSIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2YE0mfDLPgmnm+D5excVZq1gTJQiA7yIn+Kah4PrT8=;
 b=TW8fagzw2Dnl6vO+2P7SAy/LBFGPfLjfSYmG9CPpvc2FFgMG/A6MRvD8qyKjsHfUJJrYqRy0CpVGEVNIxnTJbgKxvT/rbZD4vnYlPh9XK5WIl+xJezcFNb/Tv2eiKJjQ1l1yaRY7V/4D2Ur7GrRJTKVzBkbT9d/B5xWXPlaYeUcHH9C0LVqMFNU7cIQc9Py/eE3GW3szriRr2nMaIf+0HrOMODHhqI9vL838Vp73V1HFge9cg3Vp/npJ4JYgwzi7RIW3w4eacJYEZTpqG8Ial+oab1i5bs4pIJq/8rDx0US/UIjUhZCG/Ue+0tk83yHG5vubHIwHvsACDqp+LXb6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2YE0mfDLPgmnm+D5excVZq1gTJQiA7yIn+Kah4PrT8=;
 b=JDAK8FirQ8P5Bof+2+wGfGvd5UqOvvxhZN01ieTDskLR4xd5+JmoHVxC7rq7N/3d31Jv6zzAEEdbVHzZtXnWcObRDuGz9jTZJKS55I1KwkPzkmh6r9thzAiVc09lcQUZO1Y88YB6fJsmN2x5vqMQyHIPdoKWQsCL4KNqvlreq2Y=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6146.namprd10.prod.outlook.com (2603:10b6:208:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 15:20:26 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 15:20:26 +0000
Message-ID: <66ecc29b-d46f-4eb5-a8b1-5570649f4b3a@oracle.com>
Date: Wed, 6 Nov 2024 09:20:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
To: Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
 <3e26ec9a-4dc0-42e7-a383-2c1bd0a08412@arm.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <3e26ec9a-4dc0-42e7-a383-2c1bd0a08412@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::19) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: d1505f9a-1890-415e-3040-08dcfe768a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkJIdERnUm9iTkdUK2MwUWxBaEo2TlZoTEhlb0g4RzNUeFNaYVBVQ0JjT0hC?=
 =?utf-8?B?azdUQU9YUloxUDR1ZTZFNUtpbEkvZSsvZE1uU1ZNYTdKc3NXRlU5UHF2K00w?=
 =?utf-8?B?MlcrR0V6bkFDTFFiUmZYVWVXdmU1SGprWnUxS3ZCVzhEejFLbzdadEFDbmxU?=
 =?utf-8?B?STRxYzFhWGZsYWhlWVB6TnNvU1QrSERSNEVKZzBBeDNNUWJhbFZZVVlVeVRq?=
 =?utf-8?B?K1VHd2Zid0FIUnZyMlk5cnNxcFA2OUZUT0hJbE80YVk2b2YxQjdWNnhoRFl5?=
 =?utf-8?B?WGRteUV0VE9QV0dsQTcrRVVlOEY3U0hiK1RxYmh3YmZUMnJWYjJESzFHWkxC?=
 =?utf-8?B?U3A1d0lIcjRpVTZuZVExODdjOU1OSVkwUjhrYzcvdXlYSzB4OU1oMHRsNDFu?=
 =?utf-8?B?SG1kV3JPS1lNbVY5ZGV2K0w2VXlaaEYvMmxOTWo1bDBPbDdPdm4ycE44MXQv?=
 =?utf-8?B?Tncxc1lJb1ZpVmxKZFM3cGplbSs3Uks4dzhPQWxOeGMwQ3NqYWZ4SFJQRm93?=
 =?utf-8?B?TzRDQlpKMlFvQStYbVBEUlNDbWx0N1F5a0RQeGlxYTdKRDZsakZCcHlKVDl0?=
 =?utf-8?B?QWlRN1l2Ylpqc1BNOUVOYjhKelVicHZZZ0o4WllvZE9qNVZqRjBwMGZTZktU?=
 =?utf-8?B?ZnZHZ21JVi9NS0hQZlZQcDNqaVp1RVBjeGRsVzduajQ3TXhMMXU1L055b01h?=
 =?utf-8?B?QTJPRG93NDRmckM1OEdqTTJRbHZxeVF2V3BOVUl1YTJRN0ZRWDhrdFlhZlpi?=
 =?utf-8?B?RkNCWjV3WDNwQTdhUUlZSUI3YUE4ZS9tWlBhRXlRWjZuQk5HcWtra0FwL1BX?=
 =?utf-8?B?LzJmeVlBVnEzblE4RURMeDh1S25sU3hTTERPbWNEdkcyaDdMNC80STJBMEh3?=
 =?utf-8?B?VE9UUTlnd3pGViswMVd0LzhsQm4raVRNcTR6QnFlaXEwSDBGeTBTUVY3YURs?=
 =?utf-8?B?WGxlTUFUV1ZVVFJOYU5uZmV4dW1uREkrWWFlT0VDb0dEM2M3bE8xRzJLTG9V?=
 =?utf-8?B?L2dPQTJDKzRaSVMzbzhiTU84S0ZsR3Y2T05VY1JRUGo2bXF6ZU5zclVidk5P?=
 =?utf-8?B?Z25meDZNUEF0RHZFSm1kRmwwVTdWSjJqMTREUEQvQWtsTjR2aEdIZ05ncm0r?=
 =?utf-8?B?YXMzeWhOVEdEb0h1Uk4yaTNqVlJ5NC9xdGY1akp6d242MVZOeU1FMTYwREZw?=
 =?utf-8?B?ek1oa2oxRkhPQ0RDUjQzaklNeGZyREd0YVF2ODNzNHFiNmdscXczaWdVSkor?=
 =?utf-8?B?Q2xOV1BBQjZpb1hCSTRsWjJDMW9kcTV2VjZqL29JTjJJVkR1eEZSbU1reUZ0?=
 =?utf-8?B?bVFHODFRaklPSkFVQ1F0djZ3Ti92UUttUUNNWU4yMWp1SmJwQXFXMy9vbmZt?=
 =?utf-8?B?YTk3Wkp1L29NRXpESlFuSFJBYmMxT3pvMnlPQ2dNRkdUbXNpZTl4QnJPVmhl?=
 =?utf-8?B?Z1JXc0VWc3VFcTg3TGJ1ME5wMW03K1FMTENwK2ZOdmMzWlpwS1l2ZnYrUkl6?=
 =?utf-8?B?TVNUaDdmeS9ESHZGOG1ybVpBcmI1VTBEbEYvNE1XUVRUVnRYT1pxZTRqQlRO?=
 =?utf-8?B?dE9TQTZiSVd3YmNTT1BwN1RCSmdWMDIybVA0bWVrQlN2SGNURlByNmpBc0JN?=
 =?utf-8?B?ODh4aXRXOElEdmEwWG5KWmg2WDhrNkZvblcvMmdOMGt0WXIvbENyUXd0QkNo?=
 =?utf-8?B?dFlGL1BsUTA0OC9qK1FzZTViYmJiMDdkeUhBWFhRUkZWUlBobW5DWXkxeE94?=
 =?utf-8?Q?0pPqG7i8Y8RMQO4l31AJTZdWdTK/eAhRr55zGXG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVZKQkNQNTNSdnNPdUhpaWpPR29WSEp1a2g1eTdQTnlMVTMxS1VPZ1czdDE3?=
 =?utf-8?B?ZC9NRkR4Ty9Ob3FqV1pnQ1NOWWVvdmYzQWk1UENGbXdVdlpIdWpBL0FseDJ2?=
 =?utf-8?B?RXRBRkg3L2FIV2tsWmxSM0ZuY0V0c2g1ZzhmdG1hajJTditQcHoxSjRHNE4x?=
 =?utf-8?B?c0ZaU1ZCYWgyZDZIdDA5dld4K0grSkIxVTBTNUkwL2hQaGtnYTFYeXArMTg0?=
 =?utf-8?B?a0c1U0czYkppNVhnZThFRkFaWmlHbDBlZW5aWThKNGdLNm5vVGgxcWd4RGFj?=
 =?utf-8?B?anBBT2JWUzJSeXpudGNHTGl0T01hVHRZSlArU0ZRYWp4VnZPeDZlLzZIVVlr?=
 =?utf-8?B?US8zejNLaWIwL3RqcEU4SDFUTHJCRzdlQmFkakVpZlhacUFaalVXck9yNGI1?=
 =?utf-8?B?alpkcHhGZkY1L1JpZHdvZUxyMTl0ckRnL05MNUx2Yy9GZE5JMlBDemxRN3g4?=
 =?utf-8?B?a1NqMVRjNFFDVWphTU5MQmFZNmhHRTFOL0w5ZmpYRldsVUxEaGdwU3pOKzdm?=
 =?utf-8?B?Q1BkQXA2VXdUczNRRGhrMEtzMXBKRWhja3BzV1hGamRvdzNabnBBbnpnN3VM?=
 =?utf-8?B?a3F0cnJjZkU1R2xQc2dvVE54WnVaMm5mcXVOUys3ZkRzSjAvV1lqK1ZrTXpy?=
 =?utf-8?B?WGRGOFVxNThyMUhMM09HL05EYXU3SEtGb0lFdU1kV0Vqa1BFbHIwWUt3eVV0?=
 =?utf-8?B?VjlMZWl5SGlGaWNmZUNSMVZEOERpdUZKR2dlRWJpTWQ4QWtaSVhvdERyYmNI?=
 =?utf-8?B?a2JMN0pnVzc4R3BwcW9ZdUlHQ0dZNFViclNBeGFpdVR3OW5Kc0FoTlFveHV3?=
 =?utf-8?B?V05nUGhUNTFBV1FJbC9UQ012R0FaRWZmZityM3hNbWl5U01ZVHJ2dmNmcnlD?=
 =?utf-8?B?eXdqK085ZjZ6V29CbDBqaFlkZHFFSFVNaElXRTJ0OVhpM3psWFdpNlJHN3Ja?=
 =?utf-8?B?MWgvVjNvWDQzMTJNa2JsdGROTHg1TzAvUzNZNjd5akRwaG16TmRKd0FGQ2tB?=
 =?utf-8?B?WUJTU0pYVlMveE1wR1lQdGpuN1p2NUxNWHhRWVpQTzFLQ1FYc1NvdTBPZVls?=
 =?utf-8?B?NGdvOXkweDBtamJCSnBYTXdnOVYvcjNqUXFYb01LNG9XOVlkTER2LzJpTklh?=
 =?utf-8?B?NktNcUtFSXpDVm1DeDFnN0JFQ0U0U3B0RXV1VGNQRWs2dEg5aDdQc3MyQng3?=
 =?utf-8?B?a1VkbzRoMmUxbkZ2eTVvOXNIMEdVYUVYcmw0dW1idnZVSEk4WmloNktGWi9s?=
 =?utf-8?B?YVJjbThERlhWVytPNnZBa0lHTXJTdTFnM2xjdlp6TVZEc0phR3plbFZZci9h?=
 =?utf-8?B?ZDVoNXZWSDV1dzVvSTVuT3ZyMCt1RWNZV1hyK1RJc0hBb3Z1dlE4YWlqTDhn?=
 =?utf-8?B?SkU5S3RISUdIdzdMRFFYZ2hxTU1ETmFuTGlmc094OExkQXBnN1AyZlJzcXVs?=
 =?utf-8?B?SlREQ1JnUndWdEhJOE1NSHhQbDBGWlZPUWtzUzF5Z2hHcU5xbTJqTDRPeHBS?=
 =?utf-8?B?bGJxVmFXaVBDcVNJUDRRajRHOUxKd2FGZ00vOWJQZXpRMVNNRC9qTWdRV0pD?=
 =?utf-8?B?Rmg0aUljNkxmY3VkWGVraURTbTREdWZpVDluSE0zSTBoMWxEQTlkL0s5ZXBu?=
 =?utf-8?B?VlpWSzluNkdlUmNHbGxiS3RSc3lXRGhYc09qYm4vY0JBTGtEZUZld1I0NVV2?=
 =?utf-8?B?U0R1d1FscGQ5Q1NpN05aVFRDbkhxZmtNakNqcnIyRWxzRld3QmZabDY3NTF4?=
 =?utf-8?B?eWdHVnJxMnNRRHFmODNHaDhTay9IZDdJOUVkZSs1bmxWb042WXpIMll2TGNN?=
 =?utf-8?B?d1lxMWhGQVZ5QUMrZFR1TzVwWUVIL0Fockp1SEpQai9mc2ppOGtlQXRwcXBE?=
 =?utf-8?B?cE9oMEIrcnNxM3NzWVgvakh0YWV4eVRkaHdKUk1jYVVQVEF5QmZDajdVZE5Z?=
 =?utf-8?B?SUNyeXJVc0VZd1ExN1RXZkFwSmd5VHo2Y2hJVmtiZHYrT2pnS0ZkZnM1V1VE?=
 =?utf-8?B?S0ZPb3pra0lNWHpNeTZjT1dFb0g5c2s3TkNaNzR4TlFFZW8vRWIwK090VU5G?=
 =?utf-8?B?NE03MFZCZWc5S1FpVHZZem9SSU9lUk9xK1JzUDVDMkdyWG5PZFhBbysrNlJK?=
 =?utf-8?B?TW5zbFhSaG5sZ2ErMVFYZlE5aGQ4eE8rbFdmenJ5R3hGYWoxZFV5Q0VlN3By?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5F24J4psQuTI3gqZ85kET8pBTr3mIsj2dGMt7KDyyLNQBV1yKxNP5D8gBg+Jbg9KNG867wW/qrrCTQX18Ot52/hj8qU8dIZmYXSChnOxQPSdvdnMa13BHhpAxLVADHXRe4Yj7UQWCv9uthPZfCKQMURXTFqMCf4RHHVqosQhlILzpZHKdclWboiIP7HxQFDRGx1nKHLGQ7guk4XgCJGab7ibKf4lN/fT40kRk4GWiVVXf8ys3W/BIQs2lK+Ydk5ybxRgqLj0A24IP0CfmcRnh6bDLhbDsf/rokNvE9K1wtTp2wdFTUHPDhkYjrdCaOIP4lVymYBNmHN4H0rc9IdM4HMP8iPHuK4V3ddRx/UYYHUNrVW8894kYuK+7txg/YgtJK4aXqw/ndQ0h00BGlOkvYaGjBLHPqjGPWVxkyBPJ9k4kLxaGFiX7QNeFnmowMHcj3fQL93Xzf8aPsgumzYuOoB801jgVqBEJ8I2fn8fwPSOtOhWytLAs6KWNblNVC1HACXiXSn9vAz0/MbrGqL2EYG6GbIENDIrv0cCnWZ2tooJsIr4qx0GizNspqbYKgUYTbhATdSGHDmxL+rS5HdXJYKwoL1wnAnFgKULAe8IaO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1505f9a-1890-415e-3040-08dcfe768a4f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:20:26.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKuowoZ1qeadOkmQTuQTUKvkzaTG7zZS9nA6djSNDmeQZHqLbwq4N/jGlYFLBPXoPidjnJa0D67UZFN+XsKCFyzk8GnwjESyIaKg7RN3J+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_08,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060119
X-Proofpoint-ORIG-GUID: qLw8dj0Aid3YHtXA4LdFSVFV1YatAcJG
X-Proofpoint-GUID: qLw8dj0Aid3YHtXA4LdFSVFV1YatAcJG

On 11/6/24 5:44AM, Ryan Roberts wrote:
> On 01/11/2024 20:16, Dave Kleikamp wrote:
>> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
>> is no longer optimized out with a constant size, so a build bug may
>> occur on a path that won't be reached.
>>
>> Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>
>> Ryan,
>>
>> Please consider incorporating this fix or something similar into your
>> mm patch in the boot-time pages size patches.
>>
>>   include/linux/slab.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 9848296ca6ba..a4c7507ab8ec 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t
>> size,
>>       if (size <= 1024 * 1024) return 20;
>>       if (size <=  2 * 1024 * 1024) return 21;
>>   
>> -    if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>> +    if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&
> 
> Thanks for the patch! I think this may be better as:
> 
>         if (PAGE_SHIFT_MIN == PAGE_SHIFT_MAX &&
> 
> Since that is independent of the architecture. Your approach wouldn't work if
> another arch wanted to enable boot time page size, or if arm64 dropped the
> Kconfig because it decided only boot time page size will be supported in future.

Absolutely. I may be sending some more. I haven't gotten to JFS yet, but 
that one is my responsibility.

Thanks,
Shaggy

> 
> Thanks,
> Ryan
> 
>> +        !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>>           BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>>       else
>>           BUG();
> 


