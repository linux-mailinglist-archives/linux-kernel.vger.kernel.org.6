Return-Path: <linux-kernel+bounces-417303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758579D523C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0246A1F22DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF791A00DF;
	Thu, 21 Nov 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZM/2C/1S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FvkEmCU0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399A13A250
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212108; cv=fail; b=fzzH03bYHYDUIaMzi1r8NJ7W32HIDmD5gE7eaRAyEPFBy5DgZ+IkeUIc2GYKBfTn+0j0fK/3RgjxJF6UBcETPq9FinyWqMotZLq1Ux7DwXWKvjGbL64FmUJjD3yvo9IW0JiheH8ALKPGXdislgsjI/ljLNk3bjH0Cd1AHjfRznE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212108; c=relaxed/simple;
	bh=QfUJo5tMruwKm02fB+Jvw7tQUgsUk9ivdlzpCriTaRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hEs2R10QZsgbudjr9ZH2QKW8DwfkRu9JepdbBX7RdqlnY0aHbQej85UbW3SOlNHlTpxI1PZJzV+Usvf78RVUvg62Wj0Yb5thbsotiJUeBxw9EY6pg8nRaMGiiRj/ZzocYMpWrk6NJESejJIwnB3q6Y/8EsXoTKKxu4WHps6/7DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZM/2C/1S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FvkEmCU0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALI0rqv032004;
	Thu, 21 Nov 2024 18:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QfUJo5tMruwKm02fB+Jvw7tQUgsUk9ivdlzpCriTaRI=; b=
	ZM/2C/1SfbBo2rFJ0/QcGCYgs/9chd+aIO0BZxXegzHUih7LJSUXWu0WJsm9uvwP
	1NmQSiZy/fZWLmO5gfg9Mhdxgw1bSXTX72MtQXjmy8Hrhfa1/QC0njSZqvk/lJ0u
	VmBaIPz9tYnj86p+QA3wBV9JDa0El0duLHvhiyepiejTqHN7aD5h/v4hFl3q+h56
	fuv/2aN8iGI7rPT2DIsqwYv4r4iGxPyiSGEFjx5WA10ibHWwdO1OQ3FFeRku9n0t
	n4RZwl6HDTusssGG8kiVLexj/U70ho3oW4W/QEIyXZ5CERJn1ojJ3/sRH5s4rydz
	4IfgtoffXzmkybo5x9JFwA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430rs5dskf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 18:01:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALHeQqn038046;
	Thu, 21 Nov 2024 18:01:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuc74x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 18:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDxbbRoHpBc5K8YWGKnkOlKMoRTv8CfWaMS0rIIAyy3PnAn6lfN+HkEKSr9Bim1QOogcrYrRE+amDRXU3o3haFgzjjIRyyl6HvHe0fmBTPnO9RiscYvjA3IfDIXN8+Vu2TJEMhj6UgTnSyGEmoMakcuvlYNQawi4YB/zzGWYjzNGrvkeW5cVH3Zd0RfqMf0gExcTrIbH7HlADU9W3aSec8M3HSnFvV3+kjkyulvFc7J5y3HiJvFRn3iXsvWi8EiUR7WQ8BzlswqBeD4mknBPCXy138rWDlPkLCmgmpTCp54ScJm6tFA5BQiX9ifGDgODKLn/WyPkE+FZ3hpPiVhZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfUJo5tMruwKm02fB+Jvw7tQUgsUk9ivdlzpCriTaRI=;
 b=mfeILQw7k8UKXibeG/1gEFUwaqObjZOyrfsnLP72q48udQ9jwxxT8AONqbmkUnSlWgfTUe6y9eQoiol4PG2jF1Q6LMkVoAq5Wv6Au7ZHrGLt9L5/ASzL56jhE1Wt6N6GdLl+utRcmhOdCr1qyUfG2kHGt18Ethc/uh66omrKBQjojkfouOHxn0Xg+5sYrizeqQDhPUUq8rsGfE5Irb32wycHrrsqDxwc7G7jc0m0PXhCrmOaZRkAJ/maBicw1i8U8JNZld7GdzED6qjUb90JUWrjnCTTOPfX7VJ6rb+U2TC6Cpe3MhGaIybuBTgdFaTHFa5eLolYwrHHvV5rujkD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfUJo5tMruwKm02fB+Jvw7tQUgsUk9ivdlzpCriTaRI=;
 b=FvkEmCU0C5pNvo8kceZuHQeuIS1fzecJdvCfR666lGvpzkNjTx7aDAE9vOA5SKnUjwaQalKvXjwUiZQNkMd7yWuRA8WeMRAs5BOrlBkXmaHux6HZz9pOvhQ63H29COy+WmSGXEBxdbFe0P/+AJE/7JsfVVzWxxcf+6g+RBp9tqM=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by IA1PR10MB6757.namprd10.prod.outlook.com (2603:10b6:208:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 18:01:14 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%3]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 18:01:14 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>,
        Rudi Horn <rudi.horn@oracle.com>, Joe Jin
	<joe.jin@oracle.com>
Subject: Re: [PATCH v3 0/2] x86/pkeys: Set XSTATE_BV[PKRU] when updating
Thread-Topic: [PATCH v3 0/2] x86/pkeys: Set XSTATE_BV[PKRU] when updating
Thread-Index: AQHbOqrRloowU1nU60mwrw026bDFsLLCCT4A
Date: Thu, 21 Nov 2024 18:01:14 +0000
Message-ID: <F08E74D2-E805-4B86-9B59-8A4A592FC78C@oracle.com>
References: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
In-Reply-To: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|IA1PR10MB6757:EE_
x-ms-office365-filtering-correlation-id: c8111e98-3eb3-4d3d-e564-08dd0a567d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0NEbUhpVFU1ZXRlcXZibFgxK1c2SE8wRnFkWUxzMzZyTE5GMzAxMnpiR0JX?=
 =?utf-8?B?Y21ESmw0TmI5VXlrK29sS20yaHNjRHpRNVR1MXlyZ2FteTlSQmxkbmFQaGRB?=
 =?utf-8?B?eTV6VjQ3K3IrbHYxQ2dOUnBRWklHQThlSFhvN0xrQ05xRWVuVW9RajBGUHFu?=
 =?utf-8?B?UDFSRXl6WjduTENkait1RkppNzFuSnk2YjYrS25ud3o3cFdXWStOMEtTZ3B2?=
 =?utf-8?B?R2RoWmw4am02aWtHME1IT0VEZjNxMWxyNThwR1NRbUpKZ01lWjRxbkhmeXFl?=
 =?utf-8?B?cjVDWm4zMlpBSzJ2aTlGNGNoVkFDd2JwYzFlY0pZSVB6MFA5ZThnazhMVklF?=
 =?utf-8?B?UytWV0Z5YmxqdkVlNTNSdEdxb3U5Y2ljVjRjTmdvVlZXVEFrNS9QZUI2OWRn?=
 =?utf-8?B?ak0zS082cFg4MkZXbm1Jc0t2dkFENVFKemRQVmVFQnlNSGc2US9TSGt6bFF0?=
 =?utf-8?B?TnVXNWlJbkduVVA0YktTVlVZYnZBNkllV1V4MkNTRjUxdFFtSEVJZi85V3dG?=
 =?utf-8?B?Zk1rdXJkMGRLUkN0bmhyTnREaWh0d0kyaFhlVHhYS25qTmNSelJoOXJxNUkw?=
 =?utf-8?B?czVOelZTNDBaMW9KMk9YUUxqaTNTQmdxQkNqbjhvOXV6bGU3c2tXTnBoVkpy?=
 =?utf-8?B?S1piU21DUC9iRmwxajFMV0lqblV6SEMwN1ZXckFtdVQwaEQ4K0QzeFZxb3cw?=
 =?utf-8?B?UG85Mm9aMGR5bno0OTJESWlUUzc1NVJuT0NpWlZUMldBYzVTQ09wQ1MvMjcv?=
 =?utf-8?B?UnpQcDJHZlNHaEMrZEw0VHJSKytpZGh2L04xR2RqQkJmYmw4cVB3SWtORVdS?=
 =?utf-8?B?LzBtZGU1aFlWdEdXdjFQbis2TjBSVE8rTWtsSk00djZ6M0l6Y0lkR21obndy?=
 =?utf-8?B?L1g5RVA1aVB3RW0yRTdLWk5KZ1lnekpRMjZ6MVZQRkpzUG9jRGVwVkt2bVVE?=
 =?utf-8?B?ZVQyTTJQMWlvdzFQMmVoS0xHN0ltSzhrTC9ORUI1WGI3QTJ2U0FzdTNnK3o3?=
 =?utf-8?B?VWJxZzg5WFpja1lHOXg1NFN0VUs3eXlEb0dSaXRJUktySmc2WURuRHJabXps?=
 =?utf-8?B?N2NyR3luL1RDK3NCdnZjRzJHaHQ3dE81aXBEcVpEV1RGcFcvL1hFdDJDWDl5?=
 =?utf-8?B?SWlvVDd6ZzhWVnFxS1djTUFkVUFraklJSkI4WGN0TjdpVTRNSDRyOVUvbDgz?=
 =?utf-8?B?MjJ1K05oeDBGd2lDOXBlejRxYjh3cEZkanphZW9MVTFWbmFOZXVId1l5VFg3?=
 =?utf-8?B?VEtYd0xjQUlmS21ZRS9aUU02U3JSQ2NESG9tcTRBNVVwNXVLWlFEbm41azVB?=
 =?utf-8?B?YmNZQ1RPRng0KzRpL2w0T3M0WFpnL0NtSzJ3QWZMcTk4QkRRT3NvOHZDN0Ew?=
 =?utf-8?B?dm5MRjVMNG5SWlBEZE81REUycUNobVN2RGx6RGZGN0VkNFVhMGFQR21oV0FM?=
 =?utf-8?B?Y2RhRmo2cHkxM3RZOXRuSkRPd0tyN245aU4vZXltNVlIL3ZpV2pjQmZSS1Bl?=
 =?utf-8?B?VXFTclE3NXZtQTcwWkcxZjlqZmorS2lwWjhBbTlZWXVoMXVhemt2ZzBkN0Ja?=
 =?utf-8?B?VjZCMTRqTGpIUWlGRHJTOXZQYndZNFVhUWdDNUxNQzlJSlVQVk5xczhnTThn?=
 =?utf-8?B?SjcyT1U2V3ZKT3JQVk5qajRReGk2bDdlQWxDM0lTYnZGZVhXT0xoQlp2RzJZ?=
 =?utf-8?B?UGhiYXhEc0pWQ3dOQ1hkaVVkUnZCK3MzSEVUVElRYU5OanUwZkF2YWJDMkRT?=
 =?utf-8?B?ZUZKaFZJNXQ1SGd1NHZZcG1nbE04OE15MWJwajVKbTcvcjV1S0xwTVN3RDVr?=
 =?utf-8?Q?MUqefmt6QY55JYxohzuabt2meamzAZK2ZCxC0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjBmVFZxWWdxV0p1V1RhWmhIVDhPTzZLNE9TRkd6b0pJQXYyQ2JKSFFSdlVN?=
 =?utf-8?B?VVZmZEY2WjJaTWcyQkZSQ0o5TXFjR2VNUFZXeWM2eXNTN1A2VmxCeElsblRv?=
 =?utf-8?B?ZVBRUUtIN3ZKUDVXZlRGL2pOUFNjcnhRUlJOK0tKZXVob0pBYXFYRUZtQTIv?=
 =?utf-8?B?MVdtNzJIalFsRDJZUXJZekZDWDI3L2NYL2lTRWJFZmhrT1gwVkQxNUlPdjlV?=
 =?utf-8?B?L1F2NDI4ZEVIZlJlWmd5REs1WmhuSGl4aTFnOHpkajhZNnNJTit1V3IvRlo2?=
 =?utf-8?B?eWhnK01sbWVtWXJqRk9ZZXgzS1poT1U5ZWNabEtkWEF6UDAxZnlEL0VpYjgr?=
 =?utf-8?B?c1l6SmpZNDVKRm5tT0tnMS9OekFoMEpqOTNKZEs4Ny9ySFlGTjNKU1Fpc3BJ?=
 =?utf-8?B?T3hDQmNyZWU2VnZrYnZNV1RtdXJzMUREVTJLRTBpSHR5cTR0a1hTZFNheTlY?=
 =?utf-8?B?Yzd3QWQrT3lrc052R1FBYTlacmwxUzhVL3NIUCtXMyt1MGtiYTJpZTg3bkMv?=
 =?utf-8?B?ZlJBSWxhY1RUYjRLT0tXdlBFL3pheGZyOGxNWkt5WG5uVnc5QWhsQURoYU5V?=
 =?utf-8?B?NEZjZHFOYnV4ZklRb1c2QVc0K3BMWWdCNURqVlZTeEJzckhUaTRLWHZ6MVlF?=
 =?utf-8?B?Um16eFBiRk5CWnpZMTRaZzh3dW1UeTdFRnU3WWxTeFhZeE11eE1CeGtqQWNi?=
 =?utf-8?B?NFNodEg4TjZUQ0pxWGRFWDFXanpVbHV4NXVWS3Q2Qkp0MUoyUWdBL2ozVFc0?=
 =?utf-8?B?cmdja3VkVFpKTUVZZUczMkFCaUs4N2c3ZERhQTFHMUVwSm5vOU51WFREK28r?=
 =?utf-8?B?TmZHWjJSUVNYd2FBVzFWOVQ5U2NWTzV1b254SDhlRHF2djQ4VDVxYjg3S3I0?=
 =?utf-8?B?QmpDdmoxeXMyMzdqQU9SK0NxZGI4S0pZenJ2ZTRUcW4wWnpYdm5qNDNhTU9k?=
 =?utf-8?B?NlVMOUVpbHdxV1lQS1d4cS9sY0tZd0FLMDA3S1U5eDhWRjNXemJ3aFpZUDdq?=
 =?utf-8?B?dmY4ZVFXSTZsREZlYktMRGliQVByVDltQldiV2JZbEJHbUtQZHBnV0g5T3dP?=
 =?utf-8?B?MmFVY1puZmxMY25qZTdEeXVYM1o4c0VESTlqcjlINzZwRTdZZmFwNXR5NG9E?=
 =?utf-8?B?THg3WENxdkJ0SXJzMFVwa2ltZzQwTkxkajNCcTR2czEyN2F4NnZHQzRNRmYv?=
 =?utf-8?B?NWw1R29NNkYxNklQZDlrZHo3a0tqczRwWmNNd2RQVzNLRGRDSFBEY2w2ZjYw?=
 =?utf-8?B?aEJHWlVmUEp4QVkybFJpT2dyZ2hsMkE4Snh6UXZTT3BsUFNzSVlXSEg2Y25U?=
 =?utf-8?B?YThLMi9FcTJCUnMvUU5naTMydTVsV1UwUloxL0h5RFRTVGQ4TzFtcUhudkpO?=
 =?utf-8?B?SitYenUwTWdiSHZISFpTQi9DZkxIcFNNOVRBMm9KemRETWt1RHl4TnVYU1k4?=
 =?utf-8?B?Q3FwSkx6VzdJRkQ4OVE3R3BGK1lVb0RoaXk0TndIdWRPOUExRk5aVFd4S2t1?=
 =?utf-8?B?QzFzNDhNbzF1QVdiUjEwTEQ4Tlc0Umw4VVFNZ3AzNGhmTjdHa0FHSWp2R0x6?=
 =?utf-8?B?THFDZUROdVl3UmNlVGp4cnZNZklyS1lTemtsditKQnJPZ1JDdkZ3Y2tJNExp?=
 =?utf-8?B?ZkpmSmJYK3Z3eFEweFZ1bVl1Vk9wOTZ2aGdIRGF1OGY1aUpoYUtqcm9DMjZh?=
 =?utf-8?B?cUdTWU5DL2FGK09pN3hjTDIxV3ZHR21IK2UzWmJncG5kYkhYYnhBeEdIUGxr?=
 =?utf-8?B?d0FXbUdGTjQrUWxma3BnT3FYd3RpQWhIK0FHWW1zaG8zajNSbGRQdmVlSk5W?=
 =?utf-8?B?WU0xVFpvZGVNV0JpNGo4ZUJObm5hTVlHWG9EY0ZZa0M3cFFJNmZqM011YUg2?=
 =?utf-8?B?RURxOFlRSFhFNHRsYXkvVjdISHNlVko2cTdWNWtiUVl5Qm5ONjBGWG5PNHdp?=
 =?utf-8?B?SjRpaERLVTA2VloyazhNYlFzNGlnckVTS1U3OVVMNXl2UDZaZ1Nyd1ZFbEtN?=
 =?utf-8?B?VVk2Kys5Rmd4S3lJeUdBY0RyNnNjR01iMDdEdVFJVFFZR1Jxc3pzVWEwZHVJ?=
 =?utf-8?B?K0c4cFpMQTFnOVB1ZGxkUjlHZ1IxR2pKRkMzRVhKeElmVy9jL3hDVXMvTFBO?=
 =?utf-8?B?YXBUQzFhOUc4dEVHV2NkbC9Mc1JUSUZQbXRZQ0RaOHhaOXpCVExrSUZrcEU1?=
 =?utf-8?Q?NtuoJu5HuaKETX5ZkNDslQho4M0p/QASp/2nUf00Uy5M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B3C79744F7912499760B9D31DED34BD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X72GZDDSx9ZyAIXp1ivhPDUPqYBaUoLaAKt5XUQ5lncq1mDChq1rDWEyqKoTSm+/Kz298pn7iSTth9LVWv+Nkf74kkRQGwyt8YVx2NoZFuBLU8TvPzuCeg8Pc42xx1G1n28hd3EXkTk1jNZGAEofE+npMSeY224VSW7ees8rLqlxZi2hQE4twKo3rJR5JAjg2f9aw5/UgkX4/vK0XEjaV4nfSBL74N1YtEaREj/lFRYTNaB8ENxWtC5Vh27wtoi9PdpLhHOa3QOAtMjIgSwwRp/P9hTzCXERIrG1BIVYTYSFca4cOO/8Te7/VQzojJg02wKeIPQdDilKhkGyHzm2aGIEChpsx4cEGp4QbxI0czZM8Odi5cdX1/s4ZVSKBMkRYSKIMvI0NKk1YRJrmTiYq54RUA3YeMpl/r6ToujuX98fF9FBtAyLemN3ST4Uia6+32M8UCuu0ZUTGcq7VkyoDE/xKC5KJUIlwG4s3FfwJy4E3MBKStOXLGwUV6wmIlREGBVF0BsOTkQYMvbln/UzHiytTvIQ/5ZQrADdapXEQYNwEPk2FztBtMZAbOG010IhLEy5YRcGFIkgruVSDYmvzhSwjPEmlUUfm08Ch/r+fu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8111e98-3eb3-4d3d-e564-08dd0a567d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 18:01:14.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTtYfS0ine0JC6M2iPp0YCvrfUG67uaoXZ0tgzuuoBpvGN87M83k8sqi2nL54gP/GiUGSThZgjDAUlpEqFKzseeQx5nJxfQqUgw3zWvP1v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210137
X-Proofpoint-GUID: 02CWVErf1sPI3dZK-Sn_DB04s32NW25_
X-Proofpoint-ORIG-GUID: 02CWVErf1sPI3dZK-Sn_DB04s32NW25_

SGVsbG8sDQoNCkdlbnRsZSByZW1pbmRlciB0byByZXZpZXcgdGhpcyBwYXRjaC4NCg0KVGhhbmtz
LA0KQXJ1bmENCg0KPiBPbiBOb3YgMTksIDIwMjQsIGF0IDk6NDXigK9BTSwgQXJ1bmEgUmFtYWty
aXNobmEgPGFydW5hLnJhbWFrcmlzaG5hQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gdjM6DQo+
IC0gcmViYXNlZCB0byA2LjEyLjANCj4gLSBubyBmdW5jdGlvbmFsIGNoYW5nZXMgZnJvbSB2Mg0K
PiANCj4gdjEgLT4gdjIgdXBkYXRlczoNCj4gLSBjb3JyZWN0ZWQgY29tbWl0IGRlc2NyaXB0aW9u
IG9mIGJvdGggcGF0Y2hlcyB0byByZWZlcmVuY2UgeHN0YXRlX2J2DQo+IHdoZXJlIGFwcHJvcHJp
YXRlDQo+IC0gcmVuYW1lZCBsb2NhbCB2YXJpYWJsZSBpbiB1cGRhdGVfcGtydV9pbl9zaWdmcmFt
ZSgpDQo+IChubyBmdW5jdGlvbmFsIGNoYW5nZXMgZnJvbSB2MSkNCj4gDQo+IEFydW5hIFJhbWFr
cmlzaG5hICgyKToNCj4gIHg4Ni9wa2V5czogQ2hhbmdlIGNhbGxlciBvZiB1cGRhdGVfcGtydV9p
bl9zaWdmcmFtZSgpDQo+ICB4ODYvcGtleXM6IFNldCBYU1RBVEVfQlZbUEtSVV0gdG8gMSBzbyB0
aGF0IFBLUlUgaXMgWFJTVE9SJ2QgY29ycmVjdGx5DQo+IA0KPiBhcmNoL3g4Ni9rZXJuZWwvZnB1
L3NpZ25hbC5jIHwgMjAgKystLS0tLS0tLS0tLS0tLS0tLS0NCj4gYXJjaC94ODYva2VybmVsL2Zw
dS94c3RhdGUuaCB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAyIGZpbGVzIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0gDQo+IDIu
NDMuNQ0KPiANCg0K

