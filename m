Return-Path: <linux-kernel+bounces-336033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACF97EE51
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E61F22608
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7192745E;
	Mon, 23 Sep 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SYNxiEwa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AERWNt3B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C71E52C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105889; cv=fail; b=OjJGt/PxvWEUeLL3aYg8XYS+93r8Ity1DhZsPRJ9TE/fbJGghhPMzWj1K1fNhhEC5qRN5Bsjcd7LvRt6ijG7mwb4PStxwmhBqpkZzttGgOuoZ99IJppvl0jIXYvbXudFCVucbLlFPmKvomGKdf9QjakBrysidFeUFbUQvT+70fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105889; c=relaxed/simple;
	bh=x9+CSPA5xXkVQdEUfvjdfARyyhKc7NAsWJ2crG4Qxxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wh5GZGW5ytHhusSAW/mrcdNq4dFFRC4Hh6C48/O9pUF4vef4iys1N2hWAg/2cD3XM9Pz7tp1vB4HL5lTqdnnExVvRe2gtgvQHUDKb+Gzala1RaTkk4zShi9Khga7E7jerlvr4fB7zUtmQ/A77yNg9j6kVBl88BasX2AJi9OeM+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SYNxiEwa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AERWNt3B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFMXiq031568;
	Mon, 23 Sep 2024 15:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=bGrYJOqRJmw/4GPJDajdNVaeoalChs+OtSxPAEfnRUk=; b=
	SYNxiEwa5OC1QRgUaJPmyusgZpCaVgFkV1uCKr0ePzdRbVWIyujxlMS1L1uRAWE7
	oOr5G4d2lXQrqRHQpgIhs+aAtdPYKHqXJYpss+3yVm/xIDXYOLK1fISfa46m4dhh
	ZpAr6/jxfy2Dqzj6fe7raGvb7B7nj5S/d39xP2khmEA1n88dlOb+zo1X77XhQjfY
	++Gj8fbWWOLQ51sReQjNCWjaZFjD9QiBggtFGjVmOEfhHCofO/6ACh9l4BGmE230
	z8h5qWD1hbIIBpe1Kk8NQa4sXxCAYhCy9/gyNAg+WlFhV1XskCNye6+O2nb58zXG
	ezGK6GAG1AlA1V1ohrqsoA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx32mm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 15:37:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NEibov004679;
	Mon, 23 Sep 2024 15:37:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7yhy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 15:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTb7Opr2IS2q6FU8ldPLO626GNHZg2djW7h1gbslyi5veyyNBxu6BDG2wSj9a/gDIkqCkQhdhU+AJhW7CMtsBlCX/vYYE5VDjXy8u/3FcQMYbw/y2LG7zegDfK51tvVsPQsdiYOk9PQ9LhFLMU7LHv4XMOZGrJXUACVJ3tgkhXNh0gqJIyuZJCZ56Ckg5qkri21SlDNblw4PLozCDL4kYB882LWR91xGv6gGKEJQvj/LfhfquBoaoIP/LqU3khfa3Xa8ry55AuRBTh96XYDe5RQaEZx9C6qDcoZHeeMsnbeCrfbU+NF6DUKPgvOOI5Uy+YDenkBUhZI17GHrR+z6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGrYJOqRJmw/4GPJDajdNVaeoalChs+OtSxPAEfnRUk=;
 b=oJbd6n3hIE5iZABzlYxzlwb5XXU/u/zdry4kAG2BcusHHCd7EJsrIzhoTr+6J3zAdRNfIpOPSHAvAaHZlY1B1uVrWyNtlh631q235V4p8+OCtjsPwFcwGwkXSgUYnSzEf3i8VgcFN3qxw76q+eYDOGy5fQaA/UDuQkSvtmtPdEhuy1hMnyeK/xjHgQ5B43CNuCrMMVLxB9ZlwvdD8C2a48uI99lBM1YlFgv9PQxNj7TTdne7posWxM+Vsqrpr3azoMLRNB6mVV6e3vBY1zszosVj71G4FpQMJvZNnT6No1bEA1g8o0cgw1G21ywEJPgsv+kWebMPjwgnANrEn/hyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGrYJOqRJmw/4GPJDajdNVaeoalChs+OtSxPAEfnRUk=;
 b=AERWNt3BgD5ReM+QpBGhl/nem2tdUYO+MZdlT+lCu0XYVguSDT65BVfplWWCt8zdIrRNyB3pRmlcSAWf+AoLYD979HoBLqTJ1MozibLXMCvBFEGpqbZ1MCS6GIRk3bnXO4RfWVS0XhBFbE1wOkVTlTvEAF5XSHoFfwvloqbzeRI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7955.namprd10.prod.outlook.com (2603:10b6:8:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Mon, 23 Sep
 2024 15:37:46 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 15:37:46 +0000
Message-ID: <f9060eec-5e90-4f27-89bd-c82476ea6213@oracle.com>
Date: Mon, 23 Sep 2024 10:37:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] shared: linux: remove unused variables
To: Ba Jing <bajing@cmss.chinamobile.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
        zhangpeng.00@bytedance.com, linux-kernel@vger.kernel.org
References: <20240903032952.10120-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Sid Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240903032952.10120-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 17daea36-1144-4f93-9eb0-08dcdbe5ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3pNZ1pXODJtbXdJcXJEYzNsMEhWOWczS0NFOGtOVU9KNEJMbW8xL3hqQUU4?=
 =?utf-8?B?T2FISExGWXRKMDJzNmxVRjVjL2RFQzVTZVBnbG94SDZoLytVdW45cDdMN0Ja?=
 =?utf-8?B?d2Q4bEtGdXgwOXl6bUY0MUhjUnVzbnM2MStlUUF2SXJmYzcxZ0Z2UkFaQStP?=
 =?utf-8?B?dWZvMHlENVQzMnNPS0EyVXJjNks2WXdWYWE4Q1pobWFqM3l3V0I2WW9reXhl?=
 =?utf-8?B?V0ZLTVRydkhEaEp4TWFPVHZEdkVDTnVkRWJQUUREYlF0VmJWYTBXQitZWEZk?=
 =?utf-8?B?b3N2Q21FOFZnSEhrcnpPYU90YnBQMDk0M1hGRWFVVXFBTzBkejRkWHFydDJz?=
 =?utf-8?B?Q3BiQlVkbjhoOWhSTDRFNzJYNEd4N2M1WkNYYU0zZ3Fnc0NFYU5DQ09nK0RH?=
 =?utf-8?B?VjB5dFpoa3NmUENldUp2MlZNcStVL1luZm85cjZkSElKL0J1aW9BQ1VrN2po?=
 =?utf-8?B?WVFSSlp1ZzRRQ29vWmxaRWY2YjRIQWk4RnRMNDBBaXgwR0hNNTNoYVV3dkor?=
 =?utf-8?B?VWNCWXZxNW1WUVo0R0hma2FkWE56eXJTemVPUTdYN3BsbmlGYnRuTWNDcEMr?=
 =?utf-8?B?Z3I2aFV2V1pTV2xuQ3oyVVRRaTFxclVJT05GMk03WnNHc3I1aE96RTFJYmVo?=
 =?utf-8?B?TXpTUTYzWlJLNXpqK3Z5b0NzQUpvZFo1cm1NNy8vTzlyVkZGUnBhSGtDVEl3?=
 =?utf-8?B?LytLNTlYVS9PQ3A0L3dxMFNNRlcyVzJidDJObWZ5RytQLzMvWk5nZ1c5VWN3?=
 =?utf-8?B?WjlwU0V5UGdVY0RMa3VNVFhtcXRoNWVtMFBMWHFGTUF1K2Fja3ozN2dhZzAz?=
 =?utf-8?B?dGdhaXRINWtFQ1Q2dHZUck82MUtPUkN6OVlMZ1JTQmZvaFMxSEgwWHNEU2xQ?=
 =?utf-8?B?VE9QelZQbzdQTE1GSDdNQmZabFdqZmtUeHdWOWZRQkdBOHluVkRPNjlkTU42?=
 =?utf-8?B?M1NiN1FPY1RhQ0hiTDZsR3I4endDTjVNUW9FWExYaGZDN2tTdnBsdUNUTk54?=
 =?utf-8?B?TFg0aDFLejlyaDIvMmc0dEl3cVdINFNJNzltUlZtdUJLWUhzWmlhYk42SW5a?=
 =?utf-8?B?aXRyaDUvVmlhcmNNYkFvemI0TG5Rd2kydkdMa3E4c3VzclhrejBKaTlRc1Ar?=
 =?utf-8?B?eWRxYUh6QVlqYkZzMHpVTXMzWVpVN2NuamExT3BhamVqRkc0bElBNmhqb3p6?=
 =?utf-8?B?R3hGTjJzWTA0QUZKTmF4aXdGSmR2OUJaQ3JzTnpaN2N0ZFU2cnVMaENXY2Nr?=
 =?utf-8?B?UUMyaFVGZnVMaW9mSHljcTdVVEJ5S2lxOUpIOVFja256Zkk0eGlCd3E4anNz?=
 =?utf-8?B?K2ZhWU40TWU4WDk2MWdqVkdLWmxCN0ErZnpJQ091aTlWTXF1cnhWQXArbG4v?=
 =?utf-8?B?YmhhVnRNdW9PS2Q0R3kvVVRtYUMzeFVmcHNrdWhzbmZXMnFFd242L09Nd0VP?=
 =?utf-8?B?WnlITDFyc0VkZE1rUnp1UDhDNG5XN0RDQzRWUVQxL3l0eVpNOGluMXBlV05Z?=
 =?utf-8?B?UlliV2tycldDRHNJc2pKUTVMRXQraktpWEtWWGRiNERlTllDR1ZUQjF4QTRu?=
 =?utf-8?B?VndIY2U1MVF2R0NWdzZRemVuUjBBcHg4WXNHdzJCQWQ5dVF3c3FsL1BOVklk?=
 =?utf-8?B?T1NvYi8zQWxIVXB2MHVYRmFadXBpWE5JUnYxbFk5NEgyZkp6aXVZNHV1R0pP?=
 =?utf-8?B?WjdudStWbnNHaTNnNEhKL2RUSHNWTGlhMC9admFHY0xQVktYeTFCKzlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qjk1OHFteUdVOUdTdk5Oa0E5aXppb1ZqdDFSNi9yWTZpeVI5S2V6NTBrVDAw?=
 =?utf-8?B?TURBbTE2bEFKcTJ0YjRoU0RNUVBvRzM3QncyZ2k1YVRCaHkwN1I5NlV1RkJW?=
 =?utf-8?B?dWd3WTFEVm50SC9yUlE2U2o2dmVTZlJnTG5vWkFGWldldVFhdnJkSm5YTmRD?=
 =?utf-8?B?K0xyQ01yRVNsbGJ3ZUJ2YlZmK1dHSlVFNHRIblpybUZ1bW5EVHRFcHM3dmpD?=
 =?utf-8?B?TXRzbjVNckpuaDJXQm0raTEza0M2QmdpNjJEU1hQci9XQzhtNHFrdjVuVWNE?=
 =?utf-8?B?N3IyVXJXYVppRnN0M3RDTHRjbnU2ZHM0L0k3YzlsOWNaTGtPVUVsa1dGNkcr?=
 =?utf-8?B?bTRLQ0xPUUQ5NXZ4cUxpSnJYL3p3TTU2ejJiMzY3TXFmOEZMdTdKZE1OQi9E?=
 =?utf-8?B?NWYzUGpaOW1RREtZSFJBOVN5OHo4SEczODU4TXEwc0xFVE5sOTNBbDNPUno3?=
 =?utf-8?B?cW5wdEVrMUdqSkJqakE5R1preXNLVWdXZ1gxSkZSWUZrem1hb2FodkZpS0dw?=
 =?utf-8?B?R2p1YTVlQkNIWnJSUmNQU0U2SVVRYmpWNkpsYnNyanhTOXZnQlFmYXhaZTNT?=
 =?utf-8?B?SWpwTVhqMWlMMng1TUE5dG1XMnpxb21CWC9WRVhKakRDNXZQTkdFS0gvZmN2?=
 =?utf-8?B?NFFsNzhzOW5JNjdxcVQ3YWRqZUFZMmw3N1ZudmxYUzZWV2Y2NmZvT2Yvb21l?=
 =?utf-8?B?ZnEraDJPai9uNkwxWEpCbnZrOFl6S2VKNzRwMEQ0T3ZXMUcxMDR6ek12MkRU?=
 =?utf-8?B?RVFVUTBIVjlqSWo1NXpBY3N4V3pUVXN2ZVIwVlhEVWZyUXNUZFhNaTA5eHMw?=
 =?utf-8?B?d3pSbzhBZ1lEU3NCRTBrVWN1bEFzanJ0Q2EvWE1XMTcwaVZPaGlCNENiQ0dw?=
 =?utf-8?B?ZG1UcS8wSi85bHg1WkVFTjgvNjRoVHF2MFJYQSsvbG9UTnBJbnJHK0VHK09I?=
 =?utf-8?B?cUhYZTZSMXdiUkhSK3VMOUtCN2REUitKRmhmdE1nWlRpUTZzaUVmSkRxSDRK?=
 =?utf-8?B?OHJpciswdk53QVRhWWhIaElaMm9UNGhLWmhxcFd4RC9vdHFGL1VKb1doSlpQ?=
 =?utf-8?B?dm8zSkxjVWNSa1BWb2tCYUsvTmJGYUlDSE5ldTI2SjA0OUZSVVBZUFJLdlYx?=
 =?utf-8?B?K2hJT2VRRjdNWkJCUmR2d0dSSExOZTNlc0I1UUNGcXdFMEEwRmQreE42ZkZ1?=
 =?utf-8?B?NUJlRWpNeDE4QXF2enk4T0NTZlBkZ0N6cU1hRmV4V2RYekc5NVBUcTBsVnNy?=
 =?utf-8?B?ZUFGTnN4QWNwci9WYkoxNnJLWUwrYTlkQ05UcnFPR2VCazA2OFd6U0xBaXUw?=
 =?utf-8?B?SzNFNGxSZnZ4MDF3S1FmME9RZWNTam56NXdwK2RQSEMvWVBFcXRxZ0hMSUIw?=
 =?utf-8?B?VTRMYWRDUmg1eisxMXdUSm9SdjZHQ0FKOUt2aEVTZXMveHhyZzgxMXBkRXU0?=
 =?utf-8?B?L09TcHRKTk04dUsyUVFiNWVxYUxnQmg3enNhTWFQWW10WmdkK0ViaHdKekJw?=
 =?utf-8?B?TnRRTFJOSDJ6SFJmMUNDMWc0SXNvL1NVVWlHZ2xhNzdOa2VzcGhLME9BMUdU?=
 =?utf-8?B?SDBDSjdxYjdFNmJoZ2NyL2tYTUJ2czR0M1JkQWFHMW1Qb3M0SGhDdjFSUmpm?=
 =?utf-8?B?RHlNa2VZQVJwWjdnRFo4SFp1dyttMFBhQ3dDbFRmS1U3cnd0ZUtvOFA5eEQv?=
 =?utf-8?B?MlZjL3VoblV0VGpiMnZuZ0FmRVJwRVM3Zk9zM1NnbTV4TFZBMXBrVHdLRnJs?=
 =?utf-8?B?TEw1NTE1S05KRnA0N1hlalM3WG5qU2d2MU5zWitUQ1dUVDBMclZtN1IwMElE?=
 =?utf-8?B?b1AxVFNicnNPWDdlRlMyaHdSenQzMjg4b2F5MGJtUndoc1M0bHJVY2dlOE9t?=
 =?utf-8?B?cC9ZMGxJdFZld0xVcFNVMkRzQ3lDMjlTeGdSNGorM2syYWhDVlkvMHlpek9k?=
 =?utf-8?B?d3VRZmJyd0FTUWZBQzNnRWRFK0c3eXhJZUIwYkpURWJmMmlFcjJuelFlcHRz?=
 =?utf-8?B?UmRvU3N4T2x4K1REM3FmSU5wUUF0M3c1bHJTc3VnQ05VY3daUm5jL3FtdjNV?=
 =?utf-8?B?NkhxSXJwQmlyQVl2WU1nVFdTOFRGRytmT0RMQ0t5YStSdjRPZkRDbWpJU1Zk?=
 =?utf-8?B?L3JSU0ZoQXA0Q005QkErU0dyTXoxaVRmak1yNHl5b1k4NXVXRXlvbkR2UHhD?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LaCX/+IHjmh8GocmZHhKQ/x2T4huFar6RNlhjlfZydZiCRKblFxP3m/W+0T8MEhlXBgWjtNVOPjB10BUiUloBBfjcimgsF2tRDeKIFEYwrVFynyqV9i5HpE39gbjbWDJsN2AjtwdRdiJWyXyzgAbOi8PVr5Ju1tuNTb6jfJCURbIdtw6JSE7Lc1/uKUmmSCEOxZlrwJPcNMyaNXsnpaTv2Q6TunVfT6VjTQIz/yqZnH//cuBJDEEVN/ZKmLmGOud5TPjgLI/3FjeHiBDGoeApYAhkyimog60LAgM6NB8uXhYLZXPMeuoepJcxXE4eaO68LZXI7Ju4v9/zcZULyIoxMI5MLiUkWxuTc/ZbSUSw2NKImgeuQ7fFeiHSGq0rxXgqgCiN/X9Re0CQS8w8eLuctG+8x6RwghNMcywPqVj4VzAiHyHvDcp6DFmDE6VHVexJ5APz6U5RhN3iMIwxLle0PIqMEhRA9u2UgIftfWeWf0wbg6p9JmxigZYRFcxkYuKijV1OC+eQv9adgRvkD29NRnJD68vO77OSUMXgB2vGQYkWq6fs7NfK+q36+oAOzYw51QAcj6ha4TuYqM6zZKEOfzhSXxiBNpR8gb0s8zuRJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17daea36-1144-4f93-9eb0-08dcdbe5ac2b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:37:46.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hss905lYmKj9RVeemD2+SohV6GTn5eYsoWE4A3RryxbVLDnyOfAURpiHni6s34E7NKEjvx6fvGif9oS6ffRg4SHPb85uI1cwYAk6wQz3AZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230116
X-Proofpoint-ORIG-GUID: W_6zK6A9IN330DBstJncJDgWBvAUUrja
X-Proofpoint-GUID: W_6zK6A9IN330DBstJncJDgWBvAUUrja


On 9/2/24 11:29 PM, Ba Jing wrote:
> These variables are never referenced in the code, just remove them.

Hello,

I think these variables are needed and they are referenced in main.c 
within the radix-tree directory. With these lines removed and running 
make within tools/testing/radix-tree I get the following errors:

/usr/bin/ld: 
/home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:74:(.text+0x57a): 
undefined reference to `test_verbose'
/usr/bin/ld: main.o: in function `check_copied_tags':
/home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:135:(.text+0xc3f): 
undefined reference to `test_verbose'


/home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:243:(.text+0x1d68): 
undefined reference to `preempt_count'
/usr/bin/ld: 
/home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:243:(.text+0x1d8d): 
undefined reference to `preempt_count'

adding back these variables allows make to run successfully again.

Thanks,

Sidhartha Kumar


>
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/shared/linux.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 17263696b5d8..eb1b1878cf64 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -13,8 +13,6 @@
>   #include <urcu/uatomic.h>
>   
>   int nr_allocated;
> -int preempt_count;
> -int test_verbose;
>   
>   struct kmem_cache {
>   	pthread_mutex_t lock;

