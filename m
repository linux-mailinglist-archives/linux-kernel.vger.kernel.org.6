Return-Path: <linux-kernel+bounces-565215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2BA66378
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5EB189CEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB874A1A;
	Tue, 18 Mar 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k6nptGbd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bA4IrWkW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB8184E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256785; cv=fail; b=YRchwPawKsBAhCUdPGfecrL38PV3px3q089YogoHRREMpcKwxxeAollnWAFlVREB4tJQakPIrKAQLTP1LElwlyG9yPWa60xBBaKzAcoY/VrR5vnX6BZ8JpZrWfS2MMu+lJhLkOwHrAlL73Wig/nDJ49QnOEGE/BhZxePEbpmJDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256785; c=relaxed/simple;
	bh=594DaOeFD/F5qKhegUS+cP5XhA2aqvC8IkQJSG9HjPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rn3FoIuS7yK4qeuWEETsT40zV/g73lFcAC5s0+205MDA5dJnMOeTBlVawejwdKPxoUYVykGtZS+mnyq1Ob1TaP+iLvUH2PcYgFVZmK5PEJKXsjSJ0So7Ri2QnXz5yR9oM3VnA4UepWkUHwxeaFQzoML0tzNYe0W5LywwnGhRBD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k6nptGbd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bA4IrWkW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HLtrX0005410;
	Tue, 18 Mar 2025 00:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B6xaLZ4ieqHe2pc6B8Bmr/P5cKvOBBIPMuzngPRMzmI=; b=
	k6nptGbdNbvN8LDdghBtfmBd8prBlHH0ym44ry+tchTdMnwXixHZy+i91F2O0hNA
	biCDA+dg1oijCVEtI/sAOoSJPf2BJ2s93hs/Xq+eDNIBV0c+wZnTihyVE9QiiQe/
	BWUt28aL8FHR9ady9jChHUXz6h+4R2wCThOw8QxjmJsnBLmdGg14EE9B1jule7TJ
	LDflf9asVYrK2+ID4OZAWyErOqLLeo7eipl+EwCX0zsokpf0isIg3Sr/186optJN
	pv2TDwIKKi19JOUjXAgQoSJBMdvbpIy5gO5AI5+hMaUKtAWaNtSNxhGEqPZatpji
	aUGBq7AKphFpFUrJ8nXwaw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kb45vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 00:12:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HNSvlj024475;
	Tue, 18 Mar 2025 00:12:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbgmpx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 00:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJaYZKGoohpA/KG79PjZjFa578WBIl7cmZCh1Zl1m5rj8MtYyoDRUEKpwPBhxXPa2FEVVirfD4uQfpn9qjyAQlY0X1nLqNT4tJknKK6A0/SrWWwTZohn+b4B8qfE+1cIzi8T7ZUgGUgO/25B7CY2cBGLcOqEqbZbmG9yR5en4iSSLlCOsJ2EmGn4J1AzSJjv5yTbGMG/eQXp6uqykc89jQnbYr4ZOkMe7VaCOS7kClW4IQmkMK8tCTayNSR7BLSMWGX5HYRF1YRljVs2WyqJGkYxOpeWvsSz8I5qbiuOYKeg/1IzKgydmHcELCNX/r1WL2D50XIUlNFo9pa5aMYpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6xaLZ4ieqHe2pc6B8Bmr/P5cKvOBBIPMuzngPRMzmI=;
 b=cV7dgG+3F75kwDfeEToEMgs7wex0wKYNOD3hh6VPQKWGWhESoTWdX74eM3fivtEj4+RP2Of6f1uDTT5tyYeTiaFLqabt3xLQsPMlEKi94kMARg5+Mo4T3NHzLzvoVoVriVgsMoY7Wuu5WkJeoQJCd1SNMFu5z0hf2FSM/MzzxW1KjxB64xy/aUTx9gjMEbjfNGp4X3BelRiZVMYkaFqr1KV+VdNQhQxndAEiTD4CGKJn2pGpyhHMEaSn3qWQhvhJh/FY9WfQUGMehRj7KCGu5LzKTiQlQZzPNqr+8CjYHg+Tt3loVlHyH9UMIb2nCMGIG1HpPWqoMZXFv0PONkMYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6xaLZ4ieqHe2pc6B8Bmr/P5cKvOBBIPMuzngPRMzmI=;
 b=bA4IrWkWOncS8Agq2h1vEpWL0NvzVNOdrV4OhlnN+2SghymZ0M/GE7PRBJC33/4Js/HfshvyiZCLEucVXeBqa1jXKXaEHprFskRwaUC3uyYeJKv5/GURKPvs3qefgwZrktYKbjQGszKrZomEdFNvPwhjTzTdv8oyo1KEkSYnbh0=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by PH3PPFBE2296547.namprd10.prod.outlook.com (2603:10b6:518:1::7c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:12:31 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8511.026; Tue, 18 Mar 2025
 00:12:31 +0000
Message-ID: <e93710b9-4ae3-4d68-8e3f-65439e2cf9fd@oracle.com>
Date: Mon, 17 Mar 2025 17:12:25 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
To: Tejun Heo <tj@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <Z9hW_3cPN8u7VURV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::28) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|PH3PPFBE2296547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3daced06-82e1-406f-bc90-08dd65b19357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0FIamJ5ZmZHNktSYzB5aWY4SG5xT2R0S1hWVE5BOTJyelJiNC9kcys3L2sz?=
 =?utf-8?B?NEFTMlUxM3RraHNhcDUzRzNXajllZkpWVDlOYkVacGJVVjRsNGZTS0xsQVNj?=
 =?utf-8?B?M3RyQlIxalczTUNjVVJ5U0xueGdoTjZyUndLSmh3ZVhWKzF5TVVvazY2SXFp?=
 =?utf-8?B?MmtaMnk0VlBNdUwzVzBSUHhGbjFubzhCNGtnc2ZYREhoWG5XVC9xWDRTbjF0?=
 =?utf-8?B?SVdEWXdRUCtsam9tY2QzR2RzWml4N09ZVCsrZEs2bVJ2UzdLUnQ0dC80K2FU?=
 =?utf-8?B?US9FdFVXenJYK3dhOG5KeG15djlEYTJjQ1lJYnBZK1Q2Um1LWjZlZ2Z6ZVN4?=
 =?utf-8?B?TXV6WlViTUEwWGh1QkZUSkZBL08wZU9FcUZFVXE0ZFFlUzVEd1VDem14WUxD?=
 =?utf-8?B?eHpwYzFkVlg2T2ZMWnRBdjRHcytyRnpyZDk4Qzc1ZGc4b25oY1lsNm5xaWMv?=
 =?utf-8?B?NHZiNWV5R3g4b1Y5dlRJcU5CeUpmQ3ZiaDJtaitHZHFkUEZYYTdjbUZZaWpN?=
 =?utf-8?B?WlcxOVdBdGl5OFIzQlJYeUt6SVo1ak9GK3Fhck9DdFRGUkRVaWZheHcxRWFK?=
 =?utf-8?B?RXh2NDFic2lwb2NsbVJmVGdQaWZnVXBENHRWSHU4SnQrN2l0TVBzenhIVEw2?=
 =?utf-8?B?RkNVd0N2QWpVekUyYXQwaFZsVVhTVDNsVjd0WVJDeS96SGJWZHA1WkI1RVJQ?=
 =?utf-8?B?SDVOdkZNSXU4NFlSb3ptSjRHVVJsVDBiQW4vSjB5OXJOcW5UbVNCQm9ESVMz?=
 =?utf-8?B?bmxiSm1vV2pGdlpZdisvQzMyMjg2dDI0djRITGVTck9vZjVZcmowRzhrb3pi?=
 =?utf-8?B?c0V0UE82TDlOOFRKcGFvVlFCdjh6UVJ4Tk5VZloyN0hLQW0zS0JVQTU2UHdY?=
 =?utf-8?B?cHVTYW9vNGNIVk9OcGNVUDljSGt3c0lIZDNNaWJVaEViTG1NRzJ0dk82NCt6?=
 =?utf-8?B?eWl6aTNpcnJmaUc0bUduVUM3SE1QTjFBUVR3TTVPZWdyeHBZSGxsNlhFUVoy?=
 =?utf-8?B?SXFwUmdtYTl2T1pmdGJxajQrZHZWZkxiZGs2cWZYRUxpU1ZQWUllZVZCL2VB?=
 =?utf-8?B?ZUtqYS9hTTdVMGpSY1lDeTdFK2h5SEdSeDQxa1BhMWZxTDZlOEZFbjFjQUdO?=
 =?utf-8?B?WGpHWDAwVUdQVUhxaitTTXJjVTBGWDZaNm1ka0JSZEdhMVdZRElDRjVzcUNH?=
 =?utf-8?B?TXpkSmJNNTl2d2dJQjFLcGVVSkxhV01aOVhCZDVtdy9Dck9hc0pKTXBNSmxm?=
 =?utf-8?B?N2dUUkR6enhCWHFTeFpkUE5BcFRqY3p0cXhFNUpwTnRSNHFac2NoNkZPdDFD?=
 =?utf-8?B?M055dkVTNE03RmxqcEU2cmIrWGcyMWROM2d0aFVobnI0V1Q3dVhOREhqckhO?=
 =?utf-8?B?Q2xNR0xpN29KTDE1VjBrZXVlcjkxRXY4MTVIdTZrYldtNkxteXJ6NkpDbVho?=
 =?utf-8?B?Z3lxekRva2lBRSthL2h1ZXFYUTNzTDhWMnJuMGRNaEF1dVJCNXp4My9HV2Ra?=
 =?utf-8?B?YUVtQzJsQUxIREFKcXI1eWRPdkozZU83UE5ud0JBRE9SY05CWURERXhMMVYz?=
 =?utf-8?B?WnBnbkRqdWQrdng4Y01qU2pzdzhud0xqWmlQRUt3NDdmMmxRaXBkTDIzWjIy?=
 =?utf-8?B?clVRZmRTWExnQlpZSnlvdGs4Qno3LzdMazF1TkpVT0hxSk52SkhJK3JPQnor?=
 =?utf-8?B?cXY2dzI2dlZXNjRmbS9PNDlWalllN0tZam9HRDdNL2kxUVRKSHhQUHRnaHFm?=
 =?utf-8?B?TytuRmllUUh1c2pYWERENXo1aTFSZUFTakpGeEtOUWNCSWlISlNVK3VsNFNn?=
 =?utf-8?B?QnB5b2d3L3IwY000Yk5qYTJnWnMvYXVVZldIMEwvaXRwWXRDZ3BQRTlpZEND?=
 =?utf-8?Q?4iluLbjudBVdo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3p6WXJmMDJMd3QzV0N5bDBxZVY2NmVCblVrLzVXZVN0Ym9ZMHlmcjUyVzBK?=
 =?utf-8?B?d1gyRkNDS25MLytSWE1SUEtEZk1vVWdjazg3Y1hQeU1mSjZPeFZmTzVGeWtT?=
 =?utf-8?B?WndOY1lNZmpqck1IS01mTi9Md1NieG1ENTVabUluQSswQ3V1RWN6L2dZdVll?=
 =?utf-8?B?VWVRU2JJek04ZTI1THRtc3cwWWUrMm0yREtWdFRJSURiU0RqMG5oaVBLc3hR?=
 =?utf-8?B?blBTcjNuZlNSSDFMK0xFQWhVZjluM0IwRFVGSlhNWWUzSVBBeTZmalBtVlZ1?=
 =?utf-8?B?N2JxdXJPUXpVeGh1TzdqSnJOUTlmQWE2SDFFNnRMWlFEUnl6UEpYVVNtMHNO?=
 =?utf-8?B?TXRBNXRZM28yMWlobVVnMW5OUlZ6YVpnVVlVSHpxSEsrNjNxaDlEbGx3Y3Zh?=
 =?utf-8?B?UlZYSkI2cE90TU8vTVM5WlE1VTVJN3lTVE4rcTRvL3p0VjJJUGkwUWZOdi9w?=
 =?utf-8?B?QmRjaytCemtEeEpmeEVFdEpyaUg1SVIvYUVndlVoajM3NXpDSzlwRTd1K2VP?=
 =?utf-8?B?NHp4TFVUWkVGZ09rUmcrYnBPemduZ0RHMFZQRHkvaWdYZm0vL0huNVNPb3ZD?=
 =?utf-8?B?dytYZnQ2bGEvVzdERk5FVE9uWlErY09yd1F6dUZIaldrT0N4QnBjVzNQSUNv?=
 =?utf-8?B?SnJtTm9PbzVrUERVUnZJdG9Pd0xXT0hkbEJHYkVJYUpMY3hMWlI2TVNzRDVp?=
 =?utf-8?B?QnpXd1Q2Rk80SEpGNGpTYVpldll6ZlNwQ0JYMFBqL3E4MEYyeUw4WDU1Wmo1?=
 =?utf-8?B?c0pQdkFUZGp6MXZuTXFrYkRCWm54STFBTGczbnNKQ1Y1aFgyNUR6VkFlVy8x?=
 =?utf-8?B?b1FYamNRblRJZWhSb29ScE8walh0dm1ZcWlLUG10UjhGQ0xZMXhkZmRLSjJz?=
 =?utf-8?B?Q1VuT0crcjh1RlhKZ09YY0QwRHRwUnAwQnBYQ1ROcVRnaE54dlhIbDljTXRs?=
 =?utf-8?B?UnA2QVluWVNZQjBCZGwzbDhrSHJNVkllMDZMYWw0eml1MVliTkZiT3lZdXkw?=
 =?utf-8?B?WmxLNFV6c3FCU2lRa2JER2dxeS9TdFB3YVV5dnhKRkVEUmp0d2JXRFJ6SGhP?=
 =?utf-8?B?Sjl2OER5VUlId2NPUUVRN3ppeDExejIxbWF4ZTFsLzlXWEN0dGZqcGFGd1B0?=
 =?utf-8?B?UGJ0ZFB0clFGUDBiVmUzUVhKME1IV3habzhXOUMvbEtVZzFlSUg1dUF4SXpm?=
 =?utf-8?B?M3pnQlNYamdXdVM0eDM2WkFJNDZIelU3Lyt5VnpGbEZQZFVRSHpOMmF0NHFv?=
 =?utf-8?B?NTJ4aXBXQVErbkNLRFdDUEY1d2FPRkdwSU1SbnQrVWpxTmFPQzlwMUREN0hO?=
 =?utf-8?B?UXpUSUlxdW5MRWJoUzFjRkdPdUJUcmxubVYwbzdTOUJBcnk4Mzg3Y2lwWVA2?=
 =?utf-8?B?SW0vK292elJPYisrSmlzYk92bUJwTllRY1YxUCs5aXp4aXZvY3JhZHA1TUZR?=
 =?utf-8?B?ZHh5UTZqQ2Y4dFRHYWt2eENvajg2enJKT21BOVB4SmRpODhQcGgxS3E3TWlP?=
 =?utf-8?B?V3E4VzE4UkRWWXpGUzROdy85QklDSUpueFUxZW5Wczl4NmNzWXBockQ2MTNj?=
 =?utf-8?B?QUtYWXFTMDBqMS9Zdkh5RkRkVVY2eGhLdy9PR0xUTjN6MlpEcHhJZzV4SGZx?=
 =?utf-8?B?Y2FqZVhCbjhpQmZjaUZmWTFjd1JxV3NVNi9hcFZhV1owNytZcHlkaDBTM29j?=
 =?utf-8?B?bXFhY2lQTXlQbjRjZ2x6R0FxSE8weW9mZ3VySXRTZ3g0MHlYQ2t1ZWV4Q09D?=
 =?utf-8?B?QUhRTldRZktodXFvTEdMeFVxUzZ6Y0pLdXgySFBRWGVCZlB6dDU2Q2l1Vndk?=
 =?utf-8?B?dHZ2VGwrQ21TNDZqN2d0dWdWZUc3WmlDNXNlaFFFbitPS1pwWHJzZk1hSENq?=
 =?utf-8?B?UUptcXhJbStPTElFSGVxeWJRWFlGaSs3RWhQNjMzSm5MRWlUbDEybTlyMmhq?=
 =?utf-8?B?N1c1ZnY2eUNreGh0MHp0WnhrYU1rQ002VzJiYlM4QWlielM4cDhmT2RVdjlk?=
 =?utf-8?B?MWVjQkxVRTJBZWVPOVA4U0t0cEFVWVpXcmE1cjR1RTdMM0JydzNMZ3ovUzYr?=
 =?utf-8?B?dmFuWU85RlcvSTJkaGYxTG9MVmNuc0lBRnVlaUpLRnl5YjJZK1cxQ3NiNkp0?=
 =?utf-8?Q?/gowKghxetIiyxkmAKKD27W/v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4tvGPbMIdhOJteymYRdiQQSMB5a+mb2cAMCUUgW1SPVt/Bh+P7+gkpekeAX9u25XWOALRJNgMb3somxgdXrRB7BOWCLrRxRERbqm4B0SQc4Sic7wLsYAL2GUtsyHXswUXUnpdA5IEHLcwbjR8OwSXtgXK2xOrNjTgijHu2VG+c2Oyx//54HL9UTOOfak61C5Rzcwf4MORbcQH5HwKDUKKXg/bfGrSCIFS0S/mlW+CtOAHhhqwTO8tDi+2HoHhenWcCy/YuP+hu6+adcnYsVpEfB+mw8Yzs52BfNIC7i+/zUW096dlBLUfOZAJjEcg287d64ip0nhNh6Hp2Fiqf7XwlBgDwsajoxa1RRmcTP1/ognS1EPgQQ6kfnyxFxBMp8Iwr0+aVm6S1cLP73bjGulZtpGt8VZNg71Zw74+KwviEa+FHUPOP3bYUmJKJgIqblQ/h7vkhTvEZIqjJzJp7HB3PHKON9qskHVRNEkI1rZi7ASlM+5FR4YsoB+rWcj9zGcToQRXlaFOZw3uTXTRRsUvxyebWjnFscnJWhC7aKSRVzZvU/tsFGMAUKZ5ZRcx79enrdRoBhitp8kMlkszxgnSGqEO/Kmu6WRi7jqaif0puM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daced06-82e1-406f-bc90-08dd65b19357
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:12:31.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdZEemzvlHedS1CZm3C3j6Fu6kWOSIc6FX6YLhujrys+jkdfnzZ3NaIqJ/63Ts9dkdb544S9DxH4DFNyGvTv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBE2296547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170176
X-Proofpoint-GUID: QLEy1Z624PovYFO8yFIOIuO-NRquo7Pl
X-Proofpoint-ORIG-GUID: QLEy1Z624PovYFO8yFIOIuO-NRquo7Pl



On 3/17/25 10:08, Tejun Heo wrote:
> Hello, Joel.
> 
> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
>> Consider that the previous CPU is cache affined to the waker's CPU and
>> is idle. Currently, scx's default select function only selects the
>> previous CPU in this case if WF_SYNC request is also made to wakeup on the
>> waker's CPU.
>>
>> This means, without WF_SYNC, the previous CPU being cache affined to the
>> waker and is idle is not considered. This seems extreme. WF_SYNC is not
>> normally passed to the wakeup path outside of some IPC drivers but it is
>> very possible that the task is cache hot on previous CPU and shares
>> cache with the waker CPU. Lets avoid too many migrations and select the
>> previous CPU in such cases.
> 
> Hmm.. if !WF_SYNC:
> 
> 1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
>    core in widening scopes.
> 
> 2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
>    idle CPU in widening scopes.
> 
> So, it is considering prev_cpu, right? I think it's preferring idle core a
> bit too much - it probably doesn't make sense to cross the NUMA boundary if
> there is an idle CPU in this node, at least.
> 
Hi Tejun,

Just as Peter said, this is whole wake affinity thing is highly workload
dependent. We have seen cases where even if there are idle cores in the
prev node, it's still beneficial to cross the NUMA boundary. Will it make
more sense to have the BPF scheduler implement/alter some of logic here so
it can fit to different workload?
 
> Isn't the cpus_share_cache() code block mostly about not doing
> waker-affining if prev_cpu of the wakee is close enough and idle, so
> waker-affining is likely to be worse?
> 
> Thanks.
> 


