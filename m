Return-Path: <linux-kernel+bounces-422779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738569D9E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC504B2450D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206D1DE8AC;
	Tue, 26 Nov 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WkpzsDdb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GqU1EWbm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59151AAD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649571; cv=fail; b=IQQJ84HPsNtr7sis5LuifiKAIjT4upZhbzzhvDWtAhlKMXFEL0DItzVKAbGK+w9Gd6p9RiE5/Qj7aCZlDlLt+jZ9LXGqitdeofcRMayfnS7S61DSaUXBmIbfNamUUbKWPz5v/NIEJTjENG6fSAwfKhEihftrcElR9xANpanrfZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649571; c=relaxed/simple;
	bh=SzjEgA9j+xDObaWo92W4iGc7UEQOSUHR+GXJMqowWro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URG9xtLqp6s8SrHBqY/hgHsEbXdz2aARqhKsK8Iv1xhs1IMnmxFE4fqReKIK10VFt0HQjy7fvKyiE//17b79RoU+biwcYVWk/AdVPwPrvAKYUvtXJEIq7vrIgeQxueWJ169sMC8hUa+DvCUEjJeNvpYBuqBQXex3qwVcXCYtXks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WkpzsDdb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GqU1EWbm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDLSNO007239;
	Tue, 26 Nov 2024 19:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Kn7bEutt52BHgKy0NNrEDng54VQc6awFKYKTXA+IPSA=; b=
	WkpzsDdbcORXKrAttKwvVO2dpZDcFp08O6eZaWtyMOaVIswlDYTV5I5Eu9EE845t
	vW/wEKZYq0pD4luyo+Kz81wxm7ZJA2/77UaykTz0L1CsuFRgLZ0lSLZzv2QuuIcu
	u3aTgb++xWYJsgc0ReGMemvpVwJ7VKovstII8BNScr/FgW6SQN9Kq2YQJvDehHjn
	WNOJ+ETdtGx7HP85v5NQrgR34K/haykD8qx/rGmG7CH7TXDm+FW8pakOpTcuNQoB
	aCOPGy4q/pV1OeKUn6Egi4EsF2acaPMtnuVZnyVWfQLRZnfUEqy+ENEvJMTuFslj
	Xx/RsKIbZxySDlwcxh1WWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385upabf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 19:32:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQI5Wv8027263;
	Tue, 26 Nov 2024 19:32:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gfvmvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 19:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sERCxXfei81j0ZJiuMfNInAU5Dn+NqcWIwC8iFf3JPVuh1RGKB2RUGSQaYIWaROJWjrlP5GdapDqCpceyWJGZPnFoasG8Dbv5xtVl+lNITJ2rljDUYYh4nuSoRgMDi15kdfLbToHl2fx3b54ZJdp6jxZ/PZXdDAWZyOlyLlk591Mfb8SNFdzyZeISK2wrF33jKXEJzrIE7VcoJNgQIxCPixUA6GDuV1OzOvF4dH+y/0dLAk+7hQglolYajuRMojDJLfvsoWia4crkESxJxeHnnDx0dp34vY194MPdYVoUW+5oCvAVeSqLjPd7F3kuf9rSwhdrr2IHaXGpCvq1XVa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn7bEutt52BHgKy0NNrEDng54VQc6awFKYKTXA+IPSA=;
 b=esBm9mryxd3OakylX6oPtMTdcM3kb9mUrQHNLm5PMwWUHUVk3oxuiICfukdxc9Zgijm2T/1NfXq1JhyEaaJsWTQ1mWs5YiSAfHsP4dAgRWBBflrsE13dx9BEn4VPxmubvPMY8PC7szj5k/f3bAzqpP7O7gvnM8GOdAnsU9yV0c6EuyUlIBEi51j1WOJIIg24k3UhvoeEPBEiT1FRgoRT8+cuDjT1iCNHRsBEdQtAushJs8vMCltlAH1d3a+KEQKrLKpL7WQ/6/oGeyK+p+/Ix8GXLNJXyAHhMbrAQfh9MZxpLYLBwHjrV3ojZXEcnyH9216kSGjwc0oPkLzneac11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn7bEutt52BHgKy0NNrEDng54VQc6awFKYKTXA+IPSA=;
 b=GqU1EWbmYn06YOyj3C8ume4Xbigt5eU+iSjb+CA7lkA8cJPhC9UqD/hhbhQuAU6EQDR72S9cGIgSRtBUXHq1wNBlur+Ac6T1wtI66HKt9flZf9fGYs0IWEvwpzttjljgZ2Gg9kC3ni1aln+3tc7QisE7maEnlIQ4PmM62pfTiLQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB4464.namprd10.prod.outlook.com (2603:10b6:a03:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 19:32:35 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 19:32:35 +0000
Message-ID: <95b2cf29-78be-454e-b538-14cb7f5fe964@oracle.com>
Date: Tue, 26 Nov 2024 13:32:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Track node vacancy to reduce worst case allocation
 counts
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <a522ec38-582a-40b1-b3f6-06dbabd731ad@oracle.com>
 <20241119095951.a46jgpbkz7suaahk@master>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241119095951.a46jgpbkz7suaahk@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: a04f0cbc-095c-4323-6614-08dd0e511407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUFIUUJwZ2VJVHJsa3JOZm1Db3lDem9CSDNMb0pNdWtCNFUrc1k2aW95M281?=
 =?utf-8?B?c1JoT0dEK0tFbEI0bmF6M0t6Sk5yK1B4NFZDWkdGT3c0TEJxcEwycHNteDZI?=
 =?utf-8?B?b2RsTjVWZVRHcUhwWVdxOVlmV2hCbHBSaVBrcW1Md2MwSlQ4dE9tZnJGTHZY?=
 =?utf-8?B?ZDNNalZHekdNODlWemQ2Zjlia3d0OEp3SmFJY0UvZ1ppbVZKQlUxdVNOQjFp?=
 =?utf-8?B?dnZsSFYzWkdJYVRGOURmbWh5bW1rV0ZOZmFzcStTcFdzVTZKcUZiSHRXWVhG?=
 =?utf-8?B?SmZuVFZnM1lHVGF3RjRkUGhhbVBHbitpNUVweFoxam9pS2ZPVWFMcUVUMnN1?=
 =?utf-8?B?blVoM3pUMUhITFRyNGYrUlZWKzhnR21MTzN1UmlSNDdSNGhUcVlvNGo4alBK?=
 =?utf-8?B?RWtwby8xamM3TW5wUlkxTWhHRjEvUlFPek1kSU53bVZ3Ymx2TmNIRXlKa0t4?=
 =?utf-8?B?TVlSd3duVlcvMzRjeWFRSDJDamJRYlovdi9Bcmpyd2hlbDdlSUFHYXBHV1BC?=
 =?utf-8?B?aEZ0SXBhUForeFNDY0ZNV1F6ZnR4RmVVUGRSMmJQN0VzNUF2OGl0VmJTRWts?=
 =?utf-8?B?d1dwUGNWNnZIRmV6UmlzRGlLUi9TT2NvVWN1OEhKcmNGaWx4SzlUZEtJYnh1?=
 =?utf-8?B?QXhqcUtjd0hlai8raTM4d2toOFBPR0hFYjByWU9YVkJHeVg1T1pYQU50Wjlj?=
 =?utf-8?B?aG5aaUlSMTlRSTZtemptVEtEelgzS3pta3hJc3hrbWY3c1VkWHVSWElnaE54?=
 =?utf-8?B?bnJDVU1sekFVWE03S3hwQThpTS9lWENFb3R4blBDNzRQSEh3bCtWM3ZrTlk3?=
 =?utf-8?B?eUU0K1FMa04wYmJXdHc0TUtWTUZJcWVHWkFQVXFUcGFCMHBvSXlrbEorKzhS?=
 =?utf-8?B?dU5hb1l6SVFROHRnNHJ4eUxWT012Y2tiV2wxQXROWUFLOUYwQm9zREY2azAx?=
 =?utf-8?B?bTBQd1ZPNU4vSGdMa1QvVUJzZmpVeW9WeGMrSklSWkRzNEZzdDJFc3RtYVRm?=
 =?utf-8?B?L2hMMk5WNFVEczczR0FvN2RFM2RCZ2VGZmNwM0lwVzNnVHlPeEJTaFQ1MzJx?=
 =?utf-8?B?dkRURkNQMUVUS1l4MVVZeGdzVEhHWWFVbGJYVmdsUC9wRjladHJ1VHJxVmJK?=
 =?utf-8?B?R21HT3dqZGxWeW5OaHhaN3A5Z3VlY0lQcDZla2FVRXNRUmk0YkJ3Z2RydEE1?=
 =?utf-8?B?VnhGMTJoN2QrdGFCaWMxZEp5blRqdlp6WlN2RjBoY2ppQkVKbG9sakM1c0NF?=
 =?utf-8?B?K3RIVHVGczNBMW5CQmZ2L3krcGVSaGNFT1hYOE9ad0QrUy9DNFZzTUlKZkto?=
 =?utf-8?B?cG1wVTBjczFwUm9FaS9DWjM1UXI3N21NdHpuekN0d252ci9HMGJydmFxVkFy?=
 =?utf-8?B?YTgzWXdYV3ZUb2praXhWRktMOG5yYzRrZEFXazlLdi9mQlE0MFQrdm9XNUtQ?=
 =?utf-8?B?WHFMTmwxNm9nZXJnTzQrRFJKYW1CRkpJM0lUY01wcHdaMmRtYm9WNi9tR294?=
 =?utf-8?B?S0tXcFRYdlo2ZjBKN3l3V1pzdHdhRnpIVTBiZHJhdVYzOHhkSjNoTm5mUThW?=
 =?utf-8?B?NDZrNTNpRlFENUpPOUJVVGNUTjk5NFRSdkRjZkg2SlpjR3NCUTZMeVpXQlFI?=
 =?utf-8?B?RmNENnJ0VkNVeDM4RGFIUUEvUWk5WDFabnh3eExLTjQzTG5yYTBUSEVuVVU0?=
 =?utf-8?B?RWFDbExkc1NNM284amx3Mm5GNkZhdDJVQThrekh5WEdKZWtKdGRaTlZSeWhp?=
 =?utf-8?B?MkFGZ1BvVEtWbnd3UXlsYUt1cUlEcnFicERGeDhNcWRTWmpQbnR0dVhCYytI?=
 =?utf-8?B?WU16akRLZUN3TlpOd0lDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUNBY0hxZk0xQVQxcEFGczZ0V1FNZmxrRkw4R2dYYUNlWGVFdHRDSlA1TVd5?=
 =?utf-8?B?bWFpaHNJWDYvUE82bVJwcHVpbVkyNkExSFREZ1ZnaERPQWN6alcwbTdJRUp4?=
 =?utf-8?B?SVRrVGpScDNhQVFTU3FjaXpqL2o3TEZSRG8xSTJvSDRTa20vT3dmNHhRSXBJ?=
 =?utf-8?B?Vk9RZzZiQWwxdlVwanJCZGFLc2hTUCtoelZaa2dBMW1taVpSVU80OEh5VkEy?=
 =?utf-8?B?MzUvcmZXRmwvVmxTV3FDQ3MrR1ViNDZ5ZDU1ZkszZTM1U3E2T2pzb1cwMjhU?=
 =?utf-8?B?WHdGSUl2bXZDU0dlRmQwWkY3L0ZYYnJvbjRRd1J3RjFYRWRicFdVYUxBTEVq?=
 =?utf-8?B?Sk9LMzhUT3YxMDBCbFRuand4T2wrM1ErT1pzMmcycGtyZDlpRFZ0eFpDbzJp?=
 =?utf-8?B?RlpKMjM0MDNLRUVRNnU4d09NUEEzTkw0N1JKY3lVVzZDQnhoTElRWnFtZUhG?=
 =?utf-8?B?d2QyaW4rWUhZY3hOQUVGSXpqNnVVYjltekZVcmxzVTVNSmxCUGVjamluelJu?=
 =?utf-8?B?SThKMndDZHU1M28yOWRvQTJ0Tll5RnlWRWwxMzA2N2o1ejZhRjM1WUpMUkpD?=
 =?utf-8?B?dzBCdm5tNS94UnhGNGFySmltOGphelFzYS8zdHlreDhQT3ZKeC91Q3J5Tisv?=
 =?utf-8?B?dWNnOGQ5NFpiT2FwRjNDWndMNWg0c3hFaENZQ255MVpXbHVScDcvUlJWeUVV?=
 =?utf-8?B?Qnpua3JGV1BYMUlVZnMxeWFteEhiVGx6RFhOaGJ4Vm5tUFRneno4ckRWdVBm?=
 =?utf-8?B?T1hnVzhOcnIwdUhJOGZucVlSc1l6cGRyUHZCU0RsTjJ0YlVubVIrbWVzWlJP?=
 =?utf-8?B?WmxTVnRBbWt6Vi9lT3lFVWRpaXBBV1VFMW51Nno0dUhZM1MwSHpQeG5veUZj?=
 =?utf-8?B?aHB2VkRodHVmUVRUa0pIQVE1S3JLdjVzS21BNmY4T2NOMmYwQytGdGRERUt5?=
 =?utf-8?B?d05TOFFRcFk3bmIyMmJxUm01eE9tT0xHSjBHTzY0ZWwxUG1jZ0U2Y3hxSStu?=
 =?utf-8?B?cC9hRlExV1hhZDVBUkdiL3plTmozeExXOUQrTW9vOTJVZkt5cnN2bWVKU2N3?=
 =?utf-8?B?Ti9yajJmWFl5NEdCY0lIVUh2b0RTakFBbm0ycVQ2alBBQU9qVGY1RzVMckhI?=
 =?utf-8?B?UU1oYzJLWEUrd2NWdzJDVDhBeko2eTUySHhUSWJEa3lsZUJOZ3pwcHo0dGY4?=
 =?utf-8?B?ell2YStXcHU5Q1JqdS8zRC9mOUFEbG50SDE1N1B5YS9sZWtjZnJWTC9VTVZt?=
 =?utf-8?B?RVVwKzNtQVplcW8ySEhhMmFoczRaNFdFcEpjK2IvdFhDYW4ybkxMeklsSW1H?=
 =?utf-8?B?VlRWcElST0tBbll4Qk9MaENvNDBBeDJKZGxkajMzaDRhQ2JqbzVzdDJzTDg0?=
 =?utf-8?B?WlNOTm1BenZ6bkJJTlMxZzczVG56cFVDcU5haXc0Q0lFUVg4MUxmVHNKOUxG?=
 =?utf-8?B?UHlVNDBoYjRlYVdsMFRMalVkem0vWlBBakROQ3VwMDFCWGhZUkhVOVZJSGQ5?=
 =?utf-8?B?bUJ4bGR3MDEyMXNHTTdyeWJsWTMvcHNkWGhIZUdRV0xtYVRHMFZzS25ib011?=
 =?utf-8?B?dmk0Zld3OU85Ty9GaDliSGcrQUQwdlRXRTJMQ3ZKdlNLdFl0dHpjZ3g5N3h4?=
 =?utf-8?B?eFdhMU1tWFovdjhLRkQyZzZKaUlEU05GMnFDbTQrNDFkN0E4U2p3VHo0TFE1?=
 =?utf-8?B?cDRKZFhNSU9RRTVFZTcrYkZLRlg5NVlDaGVlSVR1MFlFR3NHNWRGZm1YWWph?=
 =?utf-8?B?dU1aalpPNkxXcDdyQ29oZkpYOUZPaFYzMjV3Ni9tdHdVM2w0YjZTUlhna3h1?=
 =?utf-8?B?L3NKcTlNVGlqYUJhbHBLOEk4ZCs2bVYzNDhseXB5RnBiU1dibmpZMHpkTTZK?=
 =?utf-8?B?eStsdUQ2aVN6RWFlZ0QxMXNva1ZGbGRRVC81cWIwM2k2Wm9CSjJTVzRFdVBI?=
 =?utf-8?B?RGtDeVZXUkZxeUFBbEpaclBXanRZcHVLTnUwdmE2SWREQTl5RGVGY3QxNlBP?=
 =?utf-8?B?allBVDRreWc2VDlhSjFYVm1od2JUaUd4ZzFjZlhRUExzS1BRdlQ2dlgxb0R4?=
 =?utf-8?B?MkcrRkhSV1FDRHBudXVvR082MVFzRjF2cUszTlpzaW96ODgyUVdnbUEwbmlC?=
 =?utf-8?B?SlJGTzVCenlzL1JqVGpNMFNjalRzaWRzWWxvZ2ZFd3JaN1VHT0o4c25CWkRI?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rubsbqba2SS10KSlQxxwHh+TsiU4t7+K0O1fPpjGp+TtQ9hQPdr5KYtXdAtOfizzHBnEGNv91Dmpmc+xUFPv6EyXJXAPkm1J84ziyoqnSWN3L8NqUyRxxGe0VM+tnMkKQxq9msq8ryAI3rqJi5JHuXltju7rWlJlXU8zCKH6Z01nFBn/H//wtmZi4IePHbZka9buEPD/ktO84QkaZ6A/YgYnFDj/+9KsKWbZErQJW4nHGz2yLcYUkmxsgtv2PQRc5i+Eh4oNk+r659fwrPPd7RWwOxkzuz9cjCbQYqxXnORM3WkRNuoCONANRNtc2K4mo9fH/IKgeFKR4WNZRBjz6soIKShutjx9SgOT+I9XsH2L5zB3Yk7Oaf7RDDKmQUXyjN9BmaZA8ATOMZfAs572qjg4AMSD8n/4rBsAfmrQpXfo7iEal3WhAVzZPpyb0bwoHqdE7z8gOzFiwaek5ZmMecp5BMcx8saqhd6Pe1euFT4gh2M2iES74azi9075ZjPnNXNdsAjuiDXFpGj5atTHtQ82R4qAbfB/C/nALf0ewn81gjZiiaKXaTOPoZ6fAsJL8kvN8WhU1rcfhQ0yqIfuj+qM101qaUPNqGfzTbOWOPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04f0cbc-095c-4323-6614-08dd0e511407
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 19:32:34.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaMPOJbhS+q/NICMwTDADR1R81suBRTl+AvopPY2S2hD7cJ/JNxEywN6xb69aUMvzjOtRnIsVehTsrlprQIR4gPzcp12njypicqUf864AvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260155
X-Proofpoint-GUID: XLPBS2QnFISPkuvfcwsJ8Up1jF_dAVtZ
X-Proofpoint-ORIG-GUID: XLPBS2QnFISPkuvfcwsJ8Up1jF_dAVtZ

On 11/19/24 3:59 AM, Wei Yang wrote:
> On Thu, Nov 14, 2024 at 04:39:00PM -0500, Sid Kumar wrote:
>>
>> On 11/14/24 12:05 PM, Sidhartha Kumar wrote:
> [...]
>>> ================ results =========================
>>> Bpftrace was used to profile the allocation path for requesting new maple
>>> nodes while running the ./mmap1_processes test from mmtests. The two paths
>>> for allocation are requests for a single node and the bulk allocation path.
>>> The histogram represents the number of calls to these paths and a shows the
>>> distribution of the number of nodes requested for the bulk allocation path.
>>>
>>>
>>> mm-unstable 11/13/24
>>> @bulk_alloc_req:
>>> [2, 4)                10 |@@@@@@@@@@@@@                                       |
>>> [4, 8)                38 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>> [8, 16)               19 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
>>>
>>>
>>> mm-unstable 11/13/24 + this series
>>> @bulk_alloc_req:
>>> [2, 4)                 9 |@@@@@@@@@@                                          |
>>> [4, 8)                43 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>> [8, 16)               15 |@@@@@@@@@@@@@@@@@@                                  |
>>>
>>> We can see the worst case bulk allocations of [8,16) nodes are reduced after
>>> this series.
>>
>>From running the ./malloc1_threads test case we eliminate almost all bulk
>> allocation requests that
>>
>> fall between 8 and 16 nodes
>>
>> ./malloc1_threads -t 8 -s 100
>> mm-unstable + this series
>> @bulk_alloc_req:
>> [2, 4)                 2 |
>> |
>> [4, 8)              3381
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [8, 16)                2 |
>> |
>>
> 
> This is impressive. But I come up one thing not clear.
> 
> For mmap related code, we usually have the following usage:
> 
>    vma_iter_prealloc(vmi, vma);
>      mas_preallocate(vmi->mas, vma);
>        MA_WR_STATE(wr_mas, );
>        mas_wr_store_type(&wr_mas);       --- (1)
>    vma_iter_store(vmi, vma);
> 
> Locaton (1) is where we try to get a better estimation of allocations.
> The estimation is based on we walk down the tree and try to meet a proper
> node.
> 
> In mmap related code, we usually have already walked down the
> tree to leaf, by vma_find() or related iteration operation, and the mas.status
> is set to ma_active. To me, I don't expect mas_preallocate() would traverse
> the tree again.
> 
> But from your result, it seems most cases do traverse the tree again to get a
> more precise height.
> 
Hello,

 From looking at mas_wr_prealloc_setup(), when mas_is_active():
we reset in two scenarios:

	if (mas->last > mas->max)
		goto reset;

	if (wr_mas->entry)
		goto set_content;

	if (mte_is_leaf(mas->node) && mas->last == mas->max)
		goto reset;

it could be that this test case specifically hits these two cases. In 
testing brk() I did not see the same gains that this malloc test had so 
in that case we are probably not traversing the tree again as you say.

Thanks,
Sid


> Which part do you think I have missed?
> 
>>
>> mm-unstable
>> @bulk_alloc_req:
>> [2, 4)                 1 |
>> |
>> [4, 8)              1427 |@@@@@@@@@@@@@@@@@@@@@@@@@@
>> |
>> [8, 16)             2790
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>
>>
>>>
>>> Sidhartha Kumar (5):
>>>     maple_tree: convert mas_prealloc_calc() to take in a maple write state
>>>     maple_tree: use height and depth consistently
>>>     maple_tree: use vacant nodes to reduce worst case allocations
>>>     maple_tree: break on convergence in mas_spanning_rebalance()
>>>     maple_tree: add sufficient height
>>>
>>>    include/linux/maple_tree.h       |   4 +
>>>    lib/maple_tree.c                 |  89 +++++++++++++---------
>>>    tools/testing/radix-tree/maple.c | 125 +++++++++++++++++++++++++++++--
>>>    3 files changed, 176 insertions(+), 42 deletions(-)
>>>
> 


