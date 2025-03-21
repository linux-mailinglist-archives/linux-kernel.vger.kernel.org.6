Return-Path: <linux-kernel+bounces-571623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70DA6BFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A4817AA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC1226CF7;
	Fri, 21 Mar 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRUz1OIU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XHlgsvxN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DD1D86F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574218; cv=fail; b=cTDWJToCHSzNhSztiY4lRqEQzsSc7sgkIUJjDY3Jdmyz1Dxqb1t01wqXZrrkZpicD+HA0tgONxzgaeQOJpyMz5TgF3Rk0uNPmdMMeQZMK9O7hdsS7zR5CnaeTMvgFVqNMlT/vpziXZLgX0AHTP1Z9fJll8jNrBSjJZEtPJLdYuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574218; c=relaxed/simple;
	bh=cEmtyBJ3FAWZs4voJeMJKIngJEzmkwDyWW/s8VNXROs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iz1o8DpfbO7kybpFigpZEkeaQOp71WaV7ja45YoSMTkUbJt46jODdGkoTZ/UEmoa7krGWLY1+qGdkfXF9fKVMN/OTCuXWaxrqwnuS7tBjLJkpRfU+jV0teDtg1IET4aU8xX1nbiRDrT6j2iRWDFpDp6a/7fpZtJPuhKxJDe5riU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRUz1OIU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XHlgsvxN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBwB4024288;
	Fri, 21 Mar 2025 16:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W6W/X6JbVs9QEC+sXKZuLL6WrVb5qLyrK4Ue/7g9AF8=; b=
	FRUz1OIUPBqHBXGLIj/ybvVHOKOcEfuK2XQQFMiwfPXlN14ZDIya+nHD7J43KNbr
	AXTuPVB5nS0XeaEgehmuDx/BeFwD3lxB0rdt58LqHjhgkjvopLrCuHiYiRifQ8rj
	P52LroqaErOy+R9vduq1WNh7eRKv+eZtRBcnn4rV45JA8UELn+bld+nmpPh8fA9Z
	a0g3B4nQARH4QNLM6PzQXoep5dE/OfSnB9mT6GvEUHENH3HW3di5GLGHVfwwUeb1
	Y97Bd76Fa8GixmIFoj66J+kkTG1RxvOTmYMTFxXuSyASFilqdMRab2F0A9TNrqd4
	9ttbQJy6SIuTm5ObYn1RLA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s92h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 16:23:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LFrQcS022388;
	Fri, 21 Mar 2025 16:23:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxca5h9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 16:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwzpSCopxo2Wba5AKs4TWf4ydKYc6r2wuuuhpMO3uOI58qSZqhH3+CAtkRi7w5TQBzEFEo1kLCKBnBf4o6NyuNQhDAbXvVd/7NCM810yBzM2+QrCWiM6oSNwwHzgv6o4WWQw6BkhYCiLhppiORv8y4obA0PJ2nvyWcf5EKaQTN9iHZaEx889mnwK1KCXIP90e/vZim1wIW56qPs9UyI+l+yxxkuAnp2kmjy/k0jI5+g51YDKQXGnFXXKfUCIczT+fTCp/hRQpe08SF6WFjCrgfe7Qxvt+mef2WWK2qZdyNLChjxs2mBE/tDgV9je6BitpQS1x0/Wbcy/sD5cHB9GBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6W/X6JbVs9QEC+sXKZuLL6WrVb5qLyrK4Ue/7g9AF8=;
 b=YN2KYuhnVNJVi0O5fhN6PKVv2gBCsVLkmy3BM3bMJxvwtd6bTwJQdWgeqm5STib282GDj/JU4cHk0CXagVvtX+Pk63FkKZ6VHk8KBPUmFiMcXIl3P7JTbNhEfFfAr9I+Lk49MTgXynscCTpVBGVnwkOd6FO7QuVK0j1JBGQZ8hJpJf1HvWOTFNLUeTzZ4OmLW4BKseUCZhxdNcLtO/K2kX7wIGcbd2Vk3RfOjk0imwtdzoCBlSn90Mv6BmcrCdbU7iDhzbSS9ksBWxCMJBB5xME0PuuDwVF3zBZFZ3UGmAWeVWVUNIC5RDzMsrhg+2URo5SmMfxrdh8YIcMVh4B3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6W/X6JbVs9QEC+sXKZuLL6WrVb5qLyrK4Ue/7g9AF8=;
 b=XHlgsvxNtXbqcxtatnQLb44FIqaPa6QeCB2rG1LwP23H2BDhx02b5uOePT4J0JkZcrpb19allzB95FajT575DG5DCQajIKIYIPNAU1ogrIfvU/Nb4GJTUMKZ+J50CicZn9wxT7o2KJAuxNE5NGqAWDcA23vYJrARWpPEFdEpoOY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA6PR10MB8013.namprd10.prod.outlook.com (2603:10b6:806:447::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 16:23:19 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 16:23:19 +0000
Message-ID: <923e7fa7-6476-4140-bf49-3e4e67419479@oracle.com>
Date: Fri, 21 Mar 2025 12:23:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
To: Ye Liu <ye.liu@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ye Liu <liuye@kylinos.cn>
References: <20250321062053.607044-1-ye.liu@linux.dev>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250321062053.607044-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA6PR10MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4f4d41-b0e4-4c49-07c9-08dd6894b0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3hHSlJhT25KZjRmQUhNUk5Ta1ZNWXlmaS9hRW1ZMGpHdmZtbWcrSVd0OVgv?=
 =?utf-8?B?OXJXMWo0NGxWUlZvNlFIc2VGR2pkSFAvTEo1bVhnUElCbFprOGhySndBQURn?=
 =?utf-8?B?QkNlbTdWOGVlbkZjVWV5Z2JGbmtTUCtpUmRUblVCNDQ1aDZFektGTEF5RE5X?=
 =?utf-8?B?ZE1VaE9URUkzMkdRbDFIWGppeEZFekQ5NlBSbVdkUy9HVUJBaVNpdXcwNjlO?=
 =?utf-8?B?VnpsdFhQSGRuWWc2bVdsM05Dd09JYTZ1cVNObWEvQloycWFxMEVwWjV1UGwv?=
 =?utf-8?B?UXVwL1pTdFFqcXZ5UWdyTWhsbHhNc1l1SzRUVmVORVJyYlVXNTZMTTU1SW1T?=
 =?utf-8?B?NjA5aHUyMmxTRXM5SXlINVJtYTlEamR5ZW9oVWtWRE9YekRoU2RvdFo2N0l1?=
 =?utf-8?B?UnRCMEhiYWM1SXd0NnZFTGphTXRkMFVScmZQQVBBbHJFcDhCaGlpaGQ3NU5S?=
 =?utf-8?B?NW1MTGJSWkpiVWRxNGJ4YVpSNXNIU2psU256bEx5ZDM3a2ExcFVmKzFKcFRv?=
 =?utf-8?B?enpveEozL3lWVW1JRlc2dnI4MUdLUDJvVXBZcTNUTm05c0J4cFhYOXdheUIy?=
 =?utf-8?B?cVJQWG5IeGFjYTdvUzEveG05NHMzbmxxMWRNZTY0Z1VlT0Y2dVpRTzJ5Sk9x?=
 =?utf-8?B?KzRyUW9neXRqSkFnUUJWMjVMdEY0THgzelJGWTVuZFphZTlrWDVHc08wYlpz?=
 =?utf-8?B?N0loc3FzbXRwZUkvNElRWStZc1ZqUDJjYkc1N1lGNjBPaVhrN0hZNWMrS1Jj?=
 =?utf-8?B?K2VXSVVQN2ZHcDB5UktQNGJkU2pGSGFZa3RQS2tKNk5QR0wrYng5RCtBTXdC?=
 =?utf-8?B?ODJKajBZcFUzMjdXRXVKNUtRdVh0Q2ZHRVhJZ1l3SVN4dlVKbjBvRnlLU3RG?=
 =?utf-8?B?UmZ6b2Z1TlFCRnhSNmh5L0dHZ1h4V0pzTmxaUE5lZzBJN25OVmVsNEJzQWg4?=
 =?utf-8?B?TExmUzkxNjN3NUhWUVQ3TW0wY084SGpQakVqYk5lODRhazVwMytocmlmaHY3?=
 =?utf-8?B?MEtHVEd6WWVhL3UreHlqZGdnNlVFWFhaMVpsZis4Q2YvanVXeWRZamxWR25s?=
 =?utf-8?B?Y0xDUGxwcTM0RFZ0TFdJZkRsSngrOEpRRDNuRVNvbEdoeCtacTdVNjU3Q2JI?=
 =?utf-8?B?bE1BamswanorYjliLyt2T05OQ1huNXZaTWtVUDY4QUU2QWg5c1FyV1ZvOVAy?=
 =?utf-8?B?Q3Z6a2E4SE94RXcxOHBhR2VJcW4vSlFHQ2kzNnlxWktQbnVLRFVkNUNoaVNR?=
 =?utf-8?B?bmRnV2QwcXdyUGxyU2NCM04xUzV5b3lqR2J5QmowR051dUlySXV6cWNuQ0dx?=
 =?utf-8?B?RDBZQ205bHlKVmlCL2J3THZIeitCU3pRM3hPTGNFaHlnSXBaKzRjYUJsZ1Jw?=
 =?utf-8?B?dzZSSXA1dno4azQzNlBaYXREZVViN3dEbFRjYjlOc0ttVVhCSzhHR2cyVWd1?=
 =?utf-8?B?UXhwdXpIYms1SzRnL2ZtNS9wZkI3OFZSRGJicm1ScFVrU3hmQVl3ajZxTjRZ?=
 =?utf-8?B?ZDI4Zk96a3JybmVRUkNlUEU0d3hpL3Q5K0xRTHI0WWdLbUM5eEdmOUxvQW04?=
 =?utf-8?B?YmQ4SVVGOEVKTUcxdWF2T01MZG9HaElWdXFITFBjeEpYZ3p4Qzl5V1ViL3dW?=
 =?utf-8?B?dVArVUF4RmVIMkx2NnNkTklIZHRyQy8zRnFIWDRHT3pJc1h6bWdvWlhQeDk1?=
 =?utf-8?B?K0lMb09EVU1JMDlUSTRHeiszMUdiQ0hISlJ1TVBrWFM0N2l0SndpRzNFUHJC?=
 =?utf-8?B?UWFqbDdydWZmdVVqUlhNSnJzU0c3b0VWSDhNeUI0R0dXcDdCWm1mYlRtNzhQ?=
 =?utf-8?B?cWdxNFdQMEZvTVFvZitucXdQM0gxTm0rQVJid1k1WEMzUE50V2dIcUxyVlFM?=
 =?utf-8?Q?3luw8gFN1YeVN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnh1ZnkzSC9QSEdIOTVicjlkd2VVT3B4aW9yQ3FCaGhmeS9nNURnZ1dlRTNV?=
 =?utf-8?B?Y0ZUKytZZFdpYURUc0dqYkJUUFQ1MmNOM1pMb2VvL2JBb3dtZ0R5SkFPS2JR?=
 =?utf-8?B?dng1VjVJR0RMUEpuR1h1eUdhK2U3bWVzellIYVpwYi9wb3dEbXdaU1NCNU82?=
 =?utf-8?B?ay9HdWo4THZXMTJwQnZJS1VodXJhMG5mRklOdTdVbHROSjgrM2N6SmxxTzJv?=
 =?utf-8?B?czhKdHZEQ2ZManFJZGVqV2VDdWMzNmsyUk1KTWtGVm16QnQ1ZUVweXFwZkVJ?=
 =?utf-8?B?eFB4QmRDVnBtQjlOZ1FIMkdMM0M5T1NjMXFOSUtGQXZ4Z000V043OGxpdU1R?=
 =?utf-8?B?R2lUaklYRWJheGhRR0RHVlVTUHpuWmwxV05ZNDBabnN3ZStxMnZkUkhDYUVz?=
 =?utf-8?B?aVZvdU1WQlZCcDVaU2F5OXZGUjE2U3R0bzkyai95eVlrZW16YnZBSkkxNysv?=
 =?utf-8?B?L2FhRTlaREYwWVAxWFVyU1ZQNlhpUmJ3bFpia3g1Y3ZWVGw2a3VsN3R5RVZo?=
 =?utf-8?B?d1dKNXIrdXo0SWtOY3A4UlhXYi9HS2lYSjAycHB4RVFkL3ZXR2kyMVNNdGdU?=
 =?utf-8?B?L0FFRjlrbzFHckU3NGlqUDJnNTZGVjNXRzlIZU9BdjJkQkIxNXlhaEdoUUE2?=
 =?utf-8?B?dTVzQVgwZHcvaEJ2RlYrUktMUUlEMXVqMW1MZTBTMkliUktGYnZNUXppMjBp?=
 =?utf-8?B?OGJrWXJoSEJoL1Z5SStXMTVFTVZCTVRxV0cyRmFYUFo2V01BTjNyMjB4cSs1?=
 =?utf-8?B?WEt3cWRjNTVncFZCeXVNRllUamZqMCt1UEp4MGZRZWtic09lOUhVdG5GTW5v?=
 =?utf-8?B?N1l3cmhaZ1Z5U1JiWXpoWm1WeksycFZycDVSN3dQZ3FqWnBHQkluM3QxenJl?=
 =?utf-8?B?OW5EMmZabGJDUXBhSmZkSEl3dFh1YWFrRFpOQ1BjQ3l5MkE4RWtLNldyMll3?=
 =?utf-8?B?MDVoOURraGYvb1JFQVNvRnpXRlNFdnplcmFabnJPeFg2UzFHK3JUck5sOUs2?=
 =?utf-8?B?UzV4c2Ztb1JIZFRCanZCNU5pZDFwcGQ5QWhONThFdnQ3aVpaSUpuMnozcUYw?=
 =?utf-8?B?TXljTTZYMHNHMWU1YWRzVGt0N0lOSXNNUlAwQ3RrV0tpTm1Kb01aSzFwZE1L?=
 =?utf-8?B?ZVFtNXFDb01UQ3hETDZjTnJkTVpENzRmOWs5SWl3MUFxZmtxNVBNV21HTjdm?=
 =?utf-8?B?cHE0bGFYY1ZJMkZSRWkrNmNHeDJIVDV5QUt4RHZ6QlRJRjAvWm92enlxYWFk?=
 =?utf-8?B?TGxqdldXaWZSd29aNkU0SDgzNTNkanhmcEM2cEw2TkpGV2N4TXUxcjBOSkJs?=
 =?utf-8?B?VDUwVVJqZVZvWUdkZmlGSTYwM3JNeTFZV3U4TkJ1d3ROWDhLUmNGYlVaWDgr?=
 =?utf-8?B?ZlJwbjdyRlh5RzRVTkxCTXFOcDNqRyt6VFIrVnZMNUw5QTJkU1cveWN5WWh0?=
 =?utf-8?B?N1dEdTk2cHE2b1B2ZjJ1ZXV0cmROZDlrY3dINTFTZjhzWVFKQ2xKVzI3N0tk?=
 =?utf-8?B?clltelBUU0dRZGtyRk0vM2k1ODdpdDBpM1YyVVA5VlBob3NoeWlRd0ZUYVZS?=
 =?utf-8?B?dFVWbnJjcTlIa1ZxM1lQWXRaZkU3eGJGYmNGRUxwc255OVB6WE9iRVh6VmpS?=
 =?utf-8?B?OEVWVHdJRWRtdnBsTjNqbDZwV0ZlazIwR1dWUWhWakhEZ0ZuY01wVSszQWsr?=
 =?utf-8?B?OEtodW9XdGJXYkhrWTFreTgwQ01SUjErUXZ3ZGNjb3ZFZFc2Rm9KUkVNd3Nh?=
 =?utf-8?B?OUkxemFRQXhQVTIxaUlweHIxRFRNb3ZrRjF4T0tTNWQzbXZNbWxaV1duQ1Yv?=
 =?utf-8?B?cVdTanFFMVhuaTRkelhTRlFNek5YYUU0V2RLNnNMaEpKWEV1NFcwdi9QWCtm?=
 =?utf-8?B?cFhSZXI1QnNPYzdDSWF5djhOcHRCWlV4Ry9XblpvR3VqQkQyYStEOFYrNzlz?=
 =?utf-8?B?QkExQ096dDh5SVFhZ0hSRExUbGdWaXY0WEtVdlZUSi9VRWxRS3c2ejU3RFlK?=
 =?utf-8?B?dmZnR3M5WWJBN0c2dHRkRFdXcm14Um1odGtTaXE4Z3RqbytqVjFkazhqZzQx?=
 =?utf-8?B?WGEvdHJoV0RSbG1UaG4xSWxOcWRMNG8yR3V4ZXFIOVhtT2Jtalduc3d0UVRR?=
 =?utf-8?B?dEJTbFlyS0lsSWN0N1JCUnBKWXBXMzk5VngxRko3RDh6eGRpN3RJR0tFS21V?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0F6I9Nu2oE9F2aFDfNyOlPWE1F6+2ev00WiHjPHp3Fp7ugsqwt4YOvNuBelRbUmiLIuSsNG8Nowgd/W6OHYVqboLp9XVNtMqyAJYXdbkjr+1Zqls+WH0Tyuv0HE9uAmusLJZZTMSW/lwCMyjxSvGam+YauInG/v13J9c6sjgm+QyVLsfAKuovkIYm9zIOnwbyG55mQPUyxuisdsIK6LwRbiRVuDHa0xw2qKMkwdw5V9CWFZkkQEFSOCencNFncnBi7FNPn8fPxeKvNv2KRI/XRKAzoPWVoFvpSthphC9y4ZSmcz0oPZJjoX663fOOflvMO4buQs7craQWAVEECgVhjvD0UfGZBJZZdjiqlrPi45EsvQlkypqeRKGw4HDrV6lkdW8rRZ3aJnqr+lgeVz7cnsAivowmtFs9zc71wxhGzbVz3ZTZDuc1cCr6ChvGJ+3ziGmFRPhy5IQO3Dw+LBaJIpBS/GHsLj5O7/ApMVh71d2JKcPx9+nuwwskyN8Itkmk39+pUxWUPlhUGZipwloil9KT6zEbhd79g2HI03r+nSUHGfHKyJesSU+8f5zLSdwcqzbnGZdXtSVOmmefAQt4qLj7MIxTnUd5aTdgQJmpsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f4d41-b0e4-4c49-07c9-08dd6894b0ef
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:23:19.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqIVZ2dFyH8v070AW04DNhflpDYoVITidRy7w6UN3mx89f763hRl7MFksVweH8JYbdRiFyyPZYUgh6rSZdl4G01MRXg12WVr0dipdvf8GXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210120
X-Proofpoint-GUID: 6-glf4kTJbXWJs3Lw5shh8lMA4gPQcGg
X-Proofpoint-ORIG-GUID: 6-glf4kTJbXWJs3Lw5shh8lMA4gPQcGg

On 3/21/25 2:20 AM, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> This patch consolidates the handling of unlikely conditions in the
> page_expected_state function, reducing code duplication and improving
> readability.
> 
> Previously, the check_new_page_bad function contained logic to handle
> __PG_HWPOISON flags, which was called from check_new_page. This patch
> moves the handling of __PG_HWPOISON flags into the page_expected_state
> function and removes the check_new_page_bad function. The check_new_page
> function now directly calls bad_page if the page has unexpected flags.
> 
> This change simplifies the code by reducing the number of functions and
> centralizing the unlikely condition handling in one place.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> 
> ---
> V2: return true instead of false in the PageHWPoison branch.
> ---
> ---
>   mm/page_alloc.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2842da893eea..e8b95c6a96c2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -903,6 +903,12 @@ static inline bool page_expected_state(struct page *page,
>   			(page->flags & check_flags)))
>   		return false;
>   
> +	if (unlikely(PageHWPoison(page))) {
> +		/* Don't complain about hwpoisoned pages */
> +		if (PageBuddy(page))
> +			__ClearPageBuddy(page);
> +	}
> +
>   	return true;
>   }
>   
> @@ -1586,29 +1592,15 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>   	account_freepages(zone, -nr_pages, migratetype);
>   }
>   
> -static void check_new_page_bad(struct page *page)
> -{
> -	if (unlikely(PageHWPoison(page))) {
> -		/* Don't complain about hwpoisoned pages */
> -		if (PageBuddy(page))
> -			__ClearPageBuddy(page);
> -		return;
> -	}
> -
> -	bad_page(page,
> -		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
> -}
> -
>   /*
>    * This page is about to be returned from the page allocator
>    */
>   static bool check_new_page(struct page *page)
>   {
> -	if (likely(page_expected_state(page,
> -				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
> +	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_PREP)))
>   		return false;
>   
> -	check_new_page_bad(page);
> +	bad_page(page, page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
>   	return true;
>   }
>   

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

