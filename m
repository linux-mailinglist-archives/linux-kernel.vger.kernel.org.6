Return-Path: <linux-kernel+bounces-545940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3159A4F40B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBC5188F59C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055C1465AD;
	Wed,  5 Mar 2025 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bi3E4gLr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RqzvdGII"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6653365
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139301; cv=fail; b=MmOXaeEpTy9m8Z6QWwURRAZa5IzP5bOFZkQuI3zfXFAlRekFpJqsDawwCHorf+x/JJmhdKT5sVtT+YgMfFMnmdFOrMLcOkSgSdq1wsw/U5W6G5cjyoKh/gNAUugYCohKMAbN21GABnVPUPVPxxU7XAnbwa8U/CGe5XKb7XwMZx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139301; c=relaxed/simple;
	bh=5TQWDKT9yHPhpBxHORbQMimOxQw31c+o7ESsG6VOd7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LQ1MKeYbzq/92l5pz9GORNrAhWIfvJmPW5nQynjPx0B0CuzE8DkDkvzUx5OSqyv0npeeo2B5pdG3uGoJaOQsRUbAHlOsivV6ynIDxiS+IqygdC1xDfKodrphvavsMbzhosvvLJYwIinKtDN+qHl269RZe4U0M1pbMGDFxQkDCn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bi3E4gLr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RqzvdGII; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5251MvDl006025;
	Wed, 5 Mar 2025 01:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FjhQaySHvyeDvl7kL1CtjkHnlBguxUvmwpcbfMwxWxQ=; b=
	bi3E4gLrizIpgwzZZ9W/g7xuGGZ1gMNGZfab6lheRfkvKiWncVIoTfhhbyAaOvl0
	PgQrAKtnJ/5OANKk7V3KaZ++XDczRSNdEgMcn4pY23+/NLxxPjA9UHs7+PBbtv6i
	skltJIPu/PJc9aBD0yMRIT0TuIxFs5/ogByQiBQnuconZZzf4xqjxbh3SOGhhYAJ
	xLQxtBdK4N9SfZeX/OxAGVXPY3L/y0GMQ+hOFQ5waXcEN5jB3JPHhekuAvCknf1L
	q41XgMsQ8/41elVYF0p53U1LV3BwBY0ZBvvv7jJ8rdZpEYbbLDALdfqO2rqrwMyQ
	UWo7klHCSM6Js8vXwhI8Zg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86pfsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 01:48:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5251j6L9039137;
	Wed, 5 Mar 2025 01:48:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpaf80k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 01:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDOVN/ehSOICzua2ofp0QV6kilxn5lC2OSErR1GUShSV4TbprSdetis4q1D7JSc0QF9EKCG/XWSewHTEepnPOUtpRW/0I6pbqV/FMyJaa0i+5TosImv2wgnjXr8UVKSURKCK+9QmaF363ZRTqs0XU+18++E/uUzrKiUv3v7J8tU2va+d11dlw3nhYf+hnDI+OkcCRZ5GSNP0hcYe2zvsjWw9Q+4TJkmohuExz3ezaNWUwc/yA6KY+D56xNWHrnL1wXfGka1IY80KqsuysvR3PLj5buFXUKp/cTaYZ6lPD5HtElFCUFCSF5ht7l7+txCCMNsliZj/+nH4NqmddhuziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjhQaySHvyeDvl7kL1CtjkHnlBguxUvmwpcbfMwxWxQ=;
 b=qCjRxras3q3dztUWk1NmREaRS+jFXPrKaHh6IDPfwM18Y17vj2i3AJtc8OjC3b0MpsQJ+HKV4XGurOAGUgmkCosP6Ikvm4wrUsaffeKA52dVozecnKIIw14RWfPJZyVwtSg+kWJjlJhFVb7EEgBTPW5DjC2P3RXrCTfBpOgu93RnO4MKqToiQSaKMHajpMLSCdTRSxblnhO4zJffS6XFFoo/Ae1Cl/nTt2Whfv/E1JFrckVN8XB407dL52HAMF8Oay38/8qz7ZdrRwdCRfLRg3mkeW+HGuc5sAPkgRbDlZCNciqmqmFe9XP92lq1uPlCnjSIv4YkUiLcuD3hNG67Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjhQaySHvyeDvl7kL1CtjkHnlBguxUvmwpcbfMwxWxQ=;
 b=RqzvdGII7dmM3BegsLFoG01vNqlnWjz8goxCkw2swti1MSvMt2bVWM9NKxy2JEZTe9tPRHy07IDman96+0r2pYGHQWPdT527SP9HDB0IhaJbJyygjK2fJ3PcW0uvxxZsjYCeW/7uSsC1p5nCOWZJaGx28WpdSF8zULMYPhpcxbU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 01:48:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 01:48:05 +0000
Date: Wed, 5 Mar 2025 10:47:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/mremap: refactor mremap() system call
 implementation
Message-ID: <Z8etTsy49fIjqVe-@harry>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SE2P216CA0064.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: faafeb50-c3a6-4c09-bc9a-08dd5b87c5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkRkUFJqVjFEZlFEQkN4Ui9weHpNc080OE4vS2R0U0UwMW5rZDZxQnMvcW9w?=
 =?utf-8?B?RFpzWFJCVUQ4c2trR1gzL1lzZVVscTRHckZrMXNiL1FidTAzNy9hUUkwOEVY?=
 =?utf-8?B?VzA5eFhVS2wrajA1RkZDQVF4SUxBNUJ6WlJhZnAzYXlYekdzMHh3NithdEU0?=
 =?utf-8?B?UkRDaE5lMkRYMS9XdktVVDRkZy9xYWFodEpHSnplOVlVNU9YUDBIbytGSmhV?=
 =?utf-8?B?MlphSENVVTFPcDZJcFhaWlV2TEFDbUkzOXVmUjM2d01tTjZEUFpsajlRZ1Rp?=
 =?utf-8?B?WFJGYjRKQ3lFMmxQcHN6OGJFWStRVFlhSW92dUZYRHZldHhaUThWOHd0bUZI?=
 =?utf-8?B?N2JpZlBzMmN4UGp4M2lndnlCWWdQSHo3elNLdCt2ZkRkMlhnRGJJYkRXd0lQ?=
 =?utf-8?B?K1I2eTZTRG1SMy9aa0VVS1hMWFZHeHRJa00yUWw1Z296MzJaa00yUHNSenJl?=
 =?utf-8?B?eko2aC9jWnJxdk10Uk8xT2VBVUVvS1gxM2o2dmN2R0J0eFoyUXBDZkJiSHVY?=
 =?utf-8?B?b3I0VldrTHFUUnJHUmlOVU9FTnVSYWhzM1RPUFFZVmRscnhwOVpteUtkc0Uv?=
 =?utf-8?B?YUFMQ1JGbExwVENWMFBZbHVQVC8vNStlbG5WNzZMQURrY0o1OFNqd2Z6bys0?=
 =?utf-8?B?Yzhmc2YvZVIwYnRlTzBsZEVVellLSTBJTFJybG9YaGpOb2ZxTzBTM2ZiOEww?=
 =?utf-8?B?TlZkdWlpQlI0YXNaclVMbW53YjAwN3ViVlBMb3k3MGxjNTVWYStCQ2VTcDVt?=
 =?utf-8?B?SUp6dHJuNm9zQVVWd1c1UVhnWHpkYi9ickxKUm5nb2J1VVVRMldMWExSaTgx?=
 =?utf-8?B?SmtBV0txKzFiRU9MYjVQSThzWXNvL2FsRXJHVWNqaWxRR1d0QnkyRE5BN2FN?=
 =?utf-8?B?TWcvUTlQNnZoV0tkUzRzWmxpSnllU2luR2pBbllEOUphMVJpUXJrNVZSL2Zj?=
 =?utf-8?B?djlKeVFGQzhrdUN4TDBOT1NWQk1nYnMrcHBLYTAxZ2dUTTVSaStIcU5vaVM2?=
 =?utf-8?B?NGlBRFdVRm9TeSt3UVhBN2dJRUFHd01PSytxYitvZW1Wd3gwcmxMeGNna2Zz?=
 =?utf-8?B?eVA4R0pQQVRnQ2lRQk1YZTBLSkt4NmswZ29OZGRnYlNIa2lTVDlsWisyZlNX?=
 =?utf-8?B?TkJWbkZ1Ny90Y0VvVDJ6dFBEd2Fic0M1NEQzUld3WmR2WnpQaythR2NTRmRJ?=
 =?utf-8?B?czI4d3l4cWJTeG9TSUc2NDVhNGc0RWx2dlZjSzVsWDJNbEUrWDZKbENLS2Fm?=
 =?utf-8?B?NzQzQWw5WkxjTEJ4V1N4bjZzV0NCZWp6OHBLR3pKVWEvVmNVMkkwOFJ0cVA0?=
 =?utf-8?B?SmErczM4cW11RnlmaldLLzZxalRtQzFKS09FTDhPN2hmc21CU0FBTDlGS0JJ?=
 =?utf-8?B?MjVqeEszdXZiU09hbEFXdkNmcDUxWWp5d1ZPUkFOVGMyTlV5b0RENzd5Yk0z?=
 =?utf-8?B?eXdYaXNnOVc5K21ZS2IyVjhBTFhuV2RWeTlyZWl3M1pvN1MvQm5kVDAxblV2?=
 =?utf-8?B?VEY0Yk5xUDZaSlBvdDFlQS9USXkxekdsVXVSOE1LbHU5UVd2eU0rM1p3UEM3?=
 =?utf-8?B?N3F3ZFFKTzdwNXRxOFd1V3hva2RwaWhjVDNjOVBpUlhrSFBPT2xVVzVYdnRk?=
 =?utf-8?B?RUFndDRMMHdoT2dmbURCVitmSlRWa0g1SWw1d2pnZFlhZmZSNDdkY2JqNFFH?=
 =?utf-8?B?ZDV5R0pOUisyVEcvcW5vdnBwUFE1NGFhZjFnOWhlRDNPRThVVmFkbGo2Ukts?=
 =?utf-8?B?ZmlMMHRLNGtITVpLZTJOeGM0VnhnSGFjTndiM1hQY1VidWpqTzN6c1hvbitZ?=
 =?utf-8?B?eDRlY2hjZnRlVnpCZ2pjRG9tNXR1SW16THFGYzVyUlRjczg0RXRoczY1Q3Z4?=
 =?utf-8?Q?rbHnUhOrZisCx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QndQc1RvT3JZZ3lITm9IV083NzhRMlZ3UFhES05jKzlGa3dBbzVCZEhjTVA0?=
 =?utf-8?B?YTZ5V0Q4UCtyVmNRRHZNamZ2eUl2ZC9GRUpFTFlrMVFrVXpqSEhYV2dMVVJt?=
 =?utf-8?B?KzNNZ2NQMkNLV2ttVlluWlZLSkJjajhTdUIxb1RGbE11OTkrL0l6UjdtUTVF?=
 =?utf-8?B?QUlSZWt0YmJmYkwvSjFyWnZYWjJYYkFXWGtrZ3F5U0FoN1Q0aTR3OW9zQXN4?=
 =?utf-8?B?ODViNm5FQUtFMFRseitVWE80Ky8xbXEwQTRvcFU3NFN5d3VDbUlaV3NrcEli?=
 =?utf-8?B?NjJyQmpjWXB2Z2dRRTZWaHl0MExmenZLRlkvam8xblVFMCtreGVIdFZNaHdD?=
 =?utf-8?B?RnR6NzZFNlRsZisvUFE1T1hkR3E5K2NtUGlHWExzdnpOR0pNS2NOL1d6Qm9u?=
 =?utf-8?B?MWJLNDNveTQzdHYrdFlsRFc0Qy9UZmhQRURDR1BwdTlIdE1OZ2dXMTNHOEV2?=
 =?utf-8?B?R1pGbDBvVUFJL2tEMitObWhiUEFBK3RMemlKNDJRMTJqYW45elpoRUdjNHBW?=
 =?utf-8?B?L2taY3dYMXdSKy9QL3pQL1BSRFVmSllQa25hQ3lIaWdHRTMveldlbktMM3A4?=
 =?utf-8?B?YnNlakdaTzMxODRmSlhrNlhKNWpSSkIzN3VBcllYT0lpR24vamlHa2gyYmY3?=
 =?utf-8?B?TlB0Z0dPS2FTaUE4Q0JwSitqRlpkUWFjeWl3V21SanJ0UVJZNHB1NGRxSzNC?=
 =?utf-8?B?UkF1UGhQbHFqRjRRcElZajNWK0lIaHBkVWFzektCOW5kY2hzelRJRnlzV3Uw?=
 =?utf-8?B?RVBuU0tUaHJjd1JjMDhEajJmeUlYc2lyRDRyb1QvOE1ZQVZuZkpFdlN1UEJq?=
 =?utf-8?B?OGxVWlBYMUtYNFNNeElzNWp0RDI3c0JRU2ltV3p2b3k2QlFlaHRpandsYzFE?=
 =?utf-8?B?bkxpVm5TeU5FeDNKUkFmajNOM0V1bUNqRTZ0bmtnRFYxajFmN2VEMWVmcFEz?=
 =?utf-8?B?eFNWNDFZZE5oV0QwdzdaQjU1TXNLUUpmQ3RydEZWZTZZTWJjUWFZR3JGeTh5?=
 =?utf-8?B?R25BRWhFQUJkQzZCaWJINE5qdFNrdTh4bUEzZ200L0NxaXFQZ2Y1NE9LNW4v?=
 =?utf-8?B?SlRkTUM1U29wUi9jMXA2RzRTNG5ITnQyZFRQQjBSanNaNzNTdjVvenhFSFpB?=
 =?utf-8?B?N1VqWmhhWlRrS2VlWmJ5QzhsZ1VDOGp4T0Zud2ZvZVNScDQ2WFF4MGZrMEM5?=
 =?utf-8?B?UkxVQUEvZHoxZytmeDdKSENVSnVUNnlRdDdBVnJ1bmtaSXQ3eW5lbEJmQVFF?=
 =?utf-8?B?YVRRMHVZMzRxeWN1aGE4U2RnbXJnaDVHclJNSFBFMFljVXNPMlNmT2NBeFlE?=
 =?utf-8?B?UmZXTXhtUFArS0NZT0pUWStmanhLYTFyY0VmMldmZlVlbGQ5Vlc5bUpSaFBx?=
 =?utf-8?B?UFVTY05SSkdDM1EzekVZakdoQ2pFZzBoSjIyUmY1eWJMZnFQSjZ1dnVBWkFk?=
 =?utf-8?B?VUFYOWlPd3ZuS0J5aHRQeVZZZmFxaUNZUHcxOVBpTEJLMTZlL1hFbmMwRk1M?=
 =?utf-8?B?aklWMWphK0JGbTJFR0xxRG5lRzh3SjM4Q3FzVU02SkNTQU9QN3NBd0h3dU5l?=
 =?utf-8?B?OFMrWkU3T0RKZmJVYlJocnA3cytVR05lZVZxM1ZuYjJuVzhGZml3cmpkd3RR?=
 =?utf-8?B?TitmTEx4WnhqMWVzdHZTUlNzaFNwQzdKOWlMNUVTMjdLRXl6c1VibFp0QXdJ?=
 =?utf-8?B?aXo2RXl3a2VBNENtQTB5SEhuTDV0d1NvT0RqeVZZODJtQUpneWZIVi9lYlE1?=
 =?utf-8?B?WVg4ZHFDbDV2cjBFVS9jT0NRc3V6Sm5rS1dvd3ZMVUtxWkhrSXhscFNUZnlE?=
 =?utf-8?B?Uzk5Z2dFdmxjYnh6YXhpMjBzSnpCNkU4bGplMlRCMzlMRGVaYXhnaHp3RDU3?=
 =?utf-8?B?VkNjZkNQZDZqVkw1ZTB1Tm92d2U4TzI1NUEzR29uRlA3cnAzVnJNYm9ZZW9J?=
 =?utf-8?B?WXJoSHpGM2lpOUU5cFRmQ3RRR2ZjVU1BcGpRZGl1Z3dDSHljZkp3S09SUkpm?=
 =?utf-8?B?RkZmSnRQN0pTWHlqbHNoT3M5aTdYRit4Q0ZkYXRxUzViSFYxV1liUzBveFAr?=
 =?utf-8?B?cU91MUltNEJScFp3MFZIUWJjQVN3c0hma0ZzeDJLTGZCY2JlRVpIVVBYRmNx?=
 =?utf-8?Q?b95xeS5yfwSOBqTwhY++G/uwI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/MMwgGZokJk+Qe+pHMv8de4ttKP18A4/RReTQdQmQyUlMHIxEqCYXqSyMna943ZX8CrMQ73hskbnNAvTBlGbT/kIvjxymgnA/k2A37c/VzESOLI6IeijkA0qxFTHUmnq3QhIqVfjawavFWw9zd96gERzUxP9NDqScIvXAHQb1DIvxpHB6DF/v1WJTFRnyMmUaYYjvKQuu48FEosP4hdL869ItSqyfDqpIe/vAD+E2tkyzXTvK0cuDA3/XiYXzo1F2OuDcA8HOUv9PMVTPTv6rH1WWyfNE3B/LvOAHeDM2D1snp1Cpkv9VFVh5osibPCbugDSIFho8Es49qz7gGm3hKMvgeDsTUgXq1MqucbVeJv997+2xxUjaFIjYqdfWIwJoNeGtAaCnB5uLHAO6EbnQekkizTrUnTNSBXJdU5zIN4YfcAgtCmU6k5U35CfNa2FgxMxU9X6z67uKyVq43PQ+UwoBPV5QzpzuL/AuvrLCoq6pJqQWzr3aAeKgokwHLGe9fyKJXgJ37XnFH2CPZDRvLoZsEd6yrKq5anZlA4ZePxIqMh2QO6zk/6534sTphf5aIypBlmesnGmBcAp2Re5GEPJ+zgmsaGysuHvUs5lhhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faafeb50-c3a6-4c09-bc9a-08dd5b87c5de
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 01:48:05.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPzqePPX039ln6qc3fqbRaMohbZgcPr9hjAasiqo2NBzIqLuHHnyMQrvfxnwGj329U7ZeVJfVeipNEy77sM2iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050012
X-Proofpoint-ORIG-GUID: SUNYbmN1dPgCHUyYbcrlJg8yG5WEFoPt
X-Proofpoint-GUID: SUNYbmN1dPgCHUyYbcrlJg8yG5WEFoPt

On Mon, Mar 03, 2025 at 11:08:32AM +0000, Lorenzo Stoakes wrote:
> Place checks into a separate function so the mremap() system call is less
> egregiously long, remove unnecessary mremap_to() offset_in_page() check and
> just check that earlier so we keep all such basic checks together.
> 
> Separate out the VMA in-place expansion, hugetlb and expand/move logic into
> separate, readable functions.
> 
> De-duplicate code where possible, add comments and ensure that all error
> handling explicitly specifies the error at the point of it occurring rather
> than setting a prefixed error value and implicitly setting (which is bug
> prone).
> 
> This lays the groundwork for subsequent patches further simplifying and
> extending the mremap() implementation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Nice refactoring—reviewing it was a nice learning experience.

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry

>  mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 251 insertions(+), 154 deletions(-)

