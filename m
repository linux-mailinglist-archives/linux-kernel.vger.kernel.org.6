Return-Path: <linux-kernel+bounces-447948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB259F3911
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56A518904E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245820629F;
	Mon, 16 Dec 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GCH3pD6r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jg2VmHGt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECC43AA9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374121; cv=fail; b=dOSP7adA6Pgg2fgIlo3ie/F8DxIF3S+T6B3G3gmruMjrQfKlpL6pFLJGVvpsi3Kdz0tdjzPXDqtOZdbj7e8X4uCwMzyBQQFbfuYRyomFUt/13AdpImsP5wW4ybRkQSBC98yFy9aanhocSVlUsmNesXm64rXU4v/YjOBJ8t4nBrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374121; c=relaxed/simple;
	bh=RoCRlxo0VvCiYiA0i0J6r+0+3175CAB838EhpJ6R9SA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pbwyaowxg0i2tMHBU6QUHUTkn4y1A1PHklCCRWLUt+Zw6+6xJkDEMGFw1OZ6UNwonnUkbkbGK5KkCMs1mDsCPtB7NJhw9Se/hfvFYKZD5EV/0ZBKhfPGDcqGForl74GvwOG7BeXmPbV5dDLcGzNMZPCVC144Vask1NIe8Ct3IUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GCH3pD6r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jg2VmHGt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQic0021733;
	Mon, 16 Dec 2024 18:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dGCWiq7hIEiXM7Qa19vM8q2L3SnpEn/KStYfxwdGzl4=; b=
	GCH3pD6rZdoKb37C711nAwogT8DyoMEXK2nBFFCaauYxhxovf5No341GEOPh0wdo
	PDQgdmwCvV02msdbdza7SlaU9U1dwCdSif9mCHJDUDH5dvhdmbYPShSZGdS6k9Lp
	7em0I7O9x36dHtpc15i0SoRxPPc8YFnzamEaO0uQVVuSHvk8cR0LYpx7qIuFLULN
	dRMxe6x2hSdCFGsoJgN/LFdUzF9LCt6V6+5/5mdySxI4ausehVvLm7Y1fDzsj6m1
	hf7dzZ4L63yrI7JVq9YlTpxIVqlYSlwtnrefOzD7X6mOfPQNI5d2iiNKHpT6+E3c
	HjR/YTo1tdnMYgYut0DyNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj59vah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:33:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGIVXGu000573;
	Mon, 16 Dec 2024 18:33:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7mvj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8W2t4oOfEj2+TW0pSVjCCSkXjJhbonw8HYBhjgSUpEZvLlcWkulY2IQfIOSpZCYXHatB3Mc0w/xWhWubVtYZrrHNzFsaiA79aciVNDno0Xnig9Dg2Ql79fVJxSYHtImY5oG8u6WXOO7IpdW+yZRozyW3Oagq9qRS77PXX0EX+SDPIfzgdpSveoOSIG7OB3ASJjkFxfOVFLGIspSYro4Sb6472hrNeywUv5zpI7TJ6oqfN84GMweJgLqcmw9U/CvNKd3I72XUhNysPmwOa1o0Cc/GwAxHeTPTsAdEay34XMbJPGxzrg8xR8zMHjuPnZNiJZm7TfqFUIrnu79aOFnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGCWiq7hIEiXM7Qa19vM8q2L3SnpEn/KStYfxwdGzl4=;
 b=HKDwnem89ZMgT3uX3N15zWPIS/F0Qg6jvR7wCungeWqPOceO9fySEgkVkuXpNkSyWXXhlo98ewOTtU0n57VfaMF1hP2vXOaF8tDhdqlvkl1i6bWZ6xnDGDguZu3OVZoGqV+vWQgzFELVruhzqBaNsjvDn2QNHH4bmuFZ9ZXsfNuJm6LYB7deK5VHsBVCQfdL0uXeEZ2doA4QDz1rGYTwdwRMH3i8trp1ayCV5cIxHAC0mfNF921kOIRlRM35J+jVbaqR8mP8c5z2RgATUORc0YBIsPC6WZl4OMy3tYI+7tuZ+TgMb8XYpyJN+wkhQvJWmlD1nvO+VuPwEGf7HlOP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGCWiq7hIEiXM7Qa19vM8q2L3SnpEn/KStYfxwdGzl4=;
 b=jg2VmHGt97R6kl6l4Nt87v4Ne5gcY+liW4AKZLyBUyaTkeA7E1ab04NjYVi6U2T8D5OpHWNkAaAJB4hr+BSnep4jMsahQIdOGBBZPo2g98mRDDasbdR22MIQys3vbJxUvU4w0gbtHEYpvIndr5WFhFaIQex16sqfbb4vtQfF8mM=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by BY5PR10MB4338.namprd10.prod.outlook.com (2603:10b6:a03:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 18:33:28 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:33:28 +0000
Message-ID: <a4e938ec-ed63-41bf-8c5b-a3697a0fea04@oracle.com>
Date: Mon, 16 Dec 2024 10:33:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
To: Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Kenneth W Chen <kenneth.w.chen@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nanyong Sun <sunnanyong@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241214104401.1052550-1-liushixin2@huawei.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241214104401.1052550-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:408:142::31) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|BY5PR10MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b527d8d-104c-4a21-25c8-08dd1e002218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhyU3pqKzA3QTB1NHJ6bld5K0hMZEh2NE4xa0U2YlVoa20xV2RDeFU0TWxq?=
 =?utf-8?B?WmdSVW5KRFJUaVd4UDd3NWkrWnVMSGNTR0p0V2RqZC9IQmg0eCtwTXYzWVZJ?=
 =?utf-8?B?RjhOdGlKZXY2czFJUm5EVWUxVDRqRHA1T0M0MmxnZTVTUSt2R2ZnTUJNOFhD?=
 =?utf-8?B?cC9samVhQ1ZnSzdFSytadDNRTitzbWwvWlNpUHFtU3pLMGxyNk00azNnRUtL?=
 =?utf-8?B?SXJVTkxWMDdvRHZsTjhSSUtKcHc0eG1hSHNNaTd1c0wyd2dRcDdLNEtnSVk1?=
 =?utf-8?B?Y0h4K3QyQVNON0tyT25WaFpLemVTcUo4M3huUEpXNW1XLy8ydHRGVFBFOUdx?=
 =?utf-8?B?aHhxWU4zdUxMWGh1c2lBdUJNZFJ0UUpjZWlRUnZyTnJMd3BjSXN3MUFhbjdN?=
 =?utf-8?B?Mm9oaTN1WmpvM0NwSEIzY3ZPUFN3cmNaa0s2YmUrNGpOL21OcnVlcy9KQmVv?=
 =?utf-8?B?RUQ5dzhnK3NIeC8xWi9leDMrbjFGVDBnUmRnZCthWGxVQVhnbDJXcWVPb3Aw?=
 =?utf-8?B?TFB3R2VjUkZQNFZpQXlCYkpOcDVBUHVWM3RFNkJScEY4OUNZdjJUamU3MHpv?=
 =?utf-8?B?ZURlUHRLcXE4OXZ3UnlRdiswK0lyVS9nWjNyMnpvcXZPMDN5bUJKOWlqQXJB?=
 =?utf-8?B?NFBzUnJ4ZDNZR2FteUtpVDZCV3hBN1IvdGRMY3hUaGQ2ZnVObk9jbzMvTXp5?=
 =?utf-8?B?aHNjcnlLOUkrMkltV3ZnY0dGZVhGTU82T2dOSzlLOUFWZlpvUCtPUTNFVjFi?=
 =?utf-8?B?YVV1aDkzaXgvcHJEdXB5bXpHd0N5L0M0dmdnN1RtZTUyTVdnQUU2RDQwcU56?=
 =?utf-8?B?d2FnbUJtRExCcVZFQ3lYM1FOeFBqL2xLNzk3dkNjcTlCSVczRVhZblBNVzJi?=
 =?utf-8?B?RHdqaE12cFROdE1pbmttTjlUazNzK05PMlRXMC9iL3lmOVdwUkQwYjc0RXdH?=
 =?utf-8?B?aGVNQWk4ZGhJM29SZ3BRejl6VFp4b2x6Qk1Zc0NkK3B3b2RiTmczVzBwOU42?=
 =?utf-8?B?NXhzVlVLS1BiU3BVOTB0eHhjNlU3SFhNeHFVMSt6czE5UWdwWWEyV3lKOWlU?=
 =?utf-8?B?WVZHZjdlazdOQjdRWnFOMnBGNnk2MVo4czhucW5zNmtxVGRTakxDbEtZQkp5?=
 =?utf-8?B?N2Z2L0xWYmpMREdpMDVmUWNHOTJQU3kzOEs4eEFFVlV1TGpUWXp1Zm12Zk5U?=
 =?utf-8?B?V3V5NUNQR0dQakwzS3FnbzREbWJxNjQ1bjNrWEVJRjBSWlBIQjRrSHBnOUFZ?=
 =?utf-8?B?ZDJaWTNOU0RRY3gyNmtoK0J3UERKWFZoUVFGay9SckhMY2tEUjZrNFQ0ZW5x?=
 =?utf-8?B?a0JObHFGSHF0U0ZkQ21VaWQxa2grQXVXNDJDUC8vOHF4SjVnRjFjdVZQZkkw?=
 =?utf-8?B?Yzk1QmlJTFhyVTg1UFJjcjVhSnFnWGFKVGNwMVlZWlBvbm9GbE5KVkVRN29K?=
 =?utf-8?B?S3RLUHBCUmJyUDlRdGoremlSaXB6ZDdrT2ZwdjNMcHNycGR3OFNPOEpDdUFy?=
 =?utf-8?B?eUNRZ084Ulh5OXI0dGY1SGd3VEpBdUhMVXVFSjU0bkFwVmF5ZlRBcDJmdDFh?=
 =?utf-8?B?RjlTckVLYWJia00xZHVUdXdQTjYrOFJ3dzlxanV6OGlXZHl3R1NJRVJSN2pI?=
 =?utf-8?B?VXdHS1ZURGJvSEx5UE9DOTFCWjgxSWtiOFNNa2tKYm1aQXF1bVYyTjlQVnVo?=
 =?utf-8?B?MnlKZHVFaXBVZTMwUGxpVDRCTDltdXB4Qm1BRFZ4UmdXTS9VQ1M1RTY1M1RQ?=
 =?utf-8?B?TFJCMnJiMmx1WFlPTWJBM0lZZHY3RVFUSTZ5UFF5QkxDM3grcUk2OU1jTVFU?=
 =?utf-8?B?U2x4cnp1NGcwWjBJS0F0aWtWT3RUUTNCRkdwdW8wOFR3VmdiZWJ4RW52MTAz?=
 =?utf-8?Q?LYTpyjNMbHeJ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGNGVlY2WEFnQkp2V1h1QkpKbXpBaGhUanBYNkhOV1dBbW5TUGx6Vzdrekhq?=
 =?utf-8?B?a2Vhb05MOW94YlhsbDA5S085dmJWTzRIVHBVOEJyZ0t6emxFSHZCaDZRUXB1?=
 =?utf-8?B?NXVLTmxNTWNTTzU1bVVkeXErbzFTaStlVXFlcElZaUpNL0RGZi9BRExOWHdC?=
 =?utf-8?B?UGRUL1Z4RWo5aFlGVFFaM3NDUUdoc2ZZVzJWaTBRODI0RTFYWm1SVFdULzNw?=
 =?utf-8?B?MnJ3dXZrZ1UzeXoxamtSWmw1MHIyaTVEQVN3VnBZclhlWmtraERsTVcxU1pB?=
 =?utf-8?B?KzdES01TY0NvQkVNcXkzdS9tMGM0L2dRWC9FVytucmhacUlXdmtDdXBpRGlp?=
 =?utf-8?B?Q0x0RHFQL2FHUy9MT1R2Mm9PbzI2UG1pbS9VaThBcU5nby9pVnRyRUV2MGdl?=
 =?utf-8?B?RG0wT0JISG9VdWpPcVBVZVlYd3JvclNUR055S0dzbDN4aU1SK2htbU9DQmJ2?=
 =?utf-8?B?LzlUTEJ3S05zWDhvbmk4OE5qakRIWTB1dWR4RnN4QWxKZGNSS0VwRnJzam92?=
 =?utf-8?B?dk9IemxZdHkvNjYxZzRsWXJ2Vnl3NHB1WTFZOFBLTEpLVUZ3L05MQUl5a21N?=
 =?utf-8?B?eHd4dmZaYlg1T2NETkt3WDdpOFloZXN6UXducEs3R2UyOWpqUVBZaUtRZ3dL?=
 =?utf-8?B?WUlaa3pSc1MxOUVRL2V6SHFDOUtJb3orSldiYm1OME5SanhreU1KcDYzbnJC?=
 =?utf-8?B?SXhkUVQvZFBKVVgvb0JWQkRMRDBMMnE3bGgvenZ0cjRWcXQ5MUFaVU9HdnJp?=
 =?utf-8?B?a1BZc2JtZCtGRnVCdXhoUzN2QnkzRUZiVDRyT3I4blUraFBROTZFQXNIbXFy?=
 =?utf-8?B?TFlPSlBwNFE3ZDFJR1dvY3RkOTJXaGUvT3pqQlZNQTh2OVpUem1TNjVuaFdr?=
 =?utf-8?B?aWNXSWt1M1poWkJTUk5GNG10eit3VVZGQ3A1NHlnRlFRRUE5SVMrVmNKYm0y?=
 =?utf-8?B?WXJwckNKOWI1cEI0Qm5Jd3VIOE1oT2k5L1dXQnBlQlMrbVNxRkV1ZW5lYjV4?=
 =?utf-8?B?UDQvMnNXTFREbVFlVlBidi8zMGtCeXQ4UHJRaHY0V0hCbVVuK1p0ZFZvOGtv?=
 =?utf-8?B?cEVHS1lpMG5vdi9VTkJ0ZWxCWUFRRzYvamdSb3pCeWNYQ0dYY2Zad2hOMzBR?=
 =?utf-8?B?RElxdERub0xtMUhLQWVqbG5UTE5RME41WnlkN0h4N0FoTEp5dm9kNWVUZFFL?=
 =?utf-8?B?VjQ5OFRuTFl0Sm1JZk1LbDNNUDBUWWVPYTdROXBtTVZIQlRHQ3Z6SS9Xdk5a?=
 =?utf-8?B?OXltL1h2Ujh2VzZNYXlZN1NaQTZRaENQeGduWC83anJURWtrWk0ra3RsUW9x?=
 =?utf-8?B?ZzhjL3JqZTJwWXEwcWQ3c0N1TTNibFZJRXRJa0l3SSt4VnY4VDROTUdsZEZm?=
 =?utf-8?B?WTNTM2RlUXg2cGhTNUxaVnZZSWVIMFk0QjVsNm1iTk9jZDY3RFZsR0F1UWtE?=
 =?utf-8?B?V0V3Q2hVRGZNWVEwWGk1TUs1YzFyYXNwUEZ3bDFEOVp4UkpuYmhOZDNIdzds?=
 =?utf-8?B?b1N4OWp1dG8rdUNqU1ZTWEw4cmp0Y3NJZzg0TlRIb3NnUTcwZ3pxREd2UFU4?=
 =?utf-8?B?WTg2c1NqQjlxWVpxUlc2aHZSM2NhQm53TFdOS1VEYVJCUk9IanVLM3dJWE9p?=
 =?utf-8?B?azlibHNYb3lPV09say9mS1Y1S09CMDZWUTg1RlFjRCs0Ui9vVjhwM2hEdzlJ?=
 =?utf-8?B?WTVKQTA5VkJORkpsdWdlbnZGR1dlbWRZL2dYaUUzZlczWWlLTzgrWnRzV25s?=
 =?utf-8?B?bzQ2Y3hQRDhVVDJBRWtyZnNSVFlSWVJxUWlYT3c5ZE9NdHVtVzhPbU5YUUxi?=
 =?utf-8?B?blFBRDBUT1RyRHVhYXFsWDlUNWc0aEs5aWJ5T2hkT3JJVVI2MHp3WjJ3bDNQ?=
 =?utf-8?B?U0xYSFp6NFJYQ2tuTlpPSUNrQTE3TU5HdThLMUFyelN3eXo2RGhlZ1EreG5j?=
 =?utf-8?B?OSs1dVdGSVJrWnExaHY1eTQ1RTVjb2J6bGhNbmluR0J1MHJlQ1VHcnZhaG1F?=
 =?utf-8?B?VzdqODMxMDU1M09aeHJJdFpMOEMyUFpPSlM3RllKVHEyTW56V3NkUlVGU24y?=
 =?utf-8?B?ZE5KdW81UGxmdHdVTnYrQ3drNzdoSi9naXFBNEN0c3V2SzNKRFlPZzlSQ2dE?=
 =?utf-8?Q?YGAHjou0jUza+hDxmik6Pwf6i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3UQPnohhP4sf/2OYtHyIqQe/RVkjLvGR+RR06uOzpJsmhO5ibWeJREgBr2M7zfQFFI1AoqPZvOXJACPHLezVy59+euHKwqCU4EpUp47selnPDLvXRAVHwrmqhaSjvA++NbsFbN4rTeeL3hmswwVpzyZYaLAonwXaPCxOsjeytHgMyllxdVuhdJE0NLQcU0Ufhzu5nSwut3YPa4ZlLCC6UN74ySDmOzcObkwBdQkMWkRGZJvirkj7hBw3CEhqXEej6i7KUqfHwOsvqc+f7gJ/qT/Ek6fEyu6OajURQYYFz6mbJawX8WGInNJMt8+MZ9sjMPBoYT5ofEiL70kAOZyKaToWuORfz6/QiKPc39gi6679owwLGznoHjIP3F2AyF1FArBt+cEvLqGofxr2FQrAa5SlbrLJoctwfvKB6EN0dZkCDymoOWHVAC8U1IwtOtxWkEz0hiTaPtUdRjdhIk2Nk+haR4m49Whfn/FppNUYfn3mLGn721zaqeZnLRPwToFEbcUepRQ7zEs8PR9xt156gnUHyjhph/egNGiI7l5A4tGegzMaSpHFcBzU+e4OfP559HY5ws1KMIE+E7gmTbPLBbpY4AYJ/8+2we3UPNxms4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b527d8d-104c-4a21-25c8-08dd1e002218
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:33:28.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tbaADd0uslC2cHQIvBkD+9MWyxQPrBi868UupsP+m6l1BboCejTiMEpAqG32BomI0WUNvDDxtsa6pwqN/Fg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160154
X-Proofpoint-GUID: cxFMr1owj6wiH85ce1YTZ3jCcYId3_QD
X-Proofpoint-ORIG-GUID: cxFMr1owj6wiH85ce1YTZ3jCcYId3_QD

On 12/14/2024 2:44 AM, Liu Shixin wrote:

> The folio refcount may be increased unexpectly through try_get_folio() by
> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
> check whether a pmd page table is shared. The check is incorrect if the
> refcount is increased by the above caller, and this can cause the page
> table leaked:

hugetlb and THP don't overlap, right?  how does split_huge_pages() end 
up messing up huge_pmd_share() ?

Am I missing something?

>
>   BUG: Bad page state in process sh  pfn:109324
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
>   flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
>   page_type: f2(table)
>   raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
>   raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
>   page dumped because: nonzero mapcount
>   ...
>   CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
>   Tainted: [B]=BAD_PAGE
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x80/0xf8
>    dump_stack+0x18/0x28
>    bad_page+0x8c/0x130
>    free_page_is_bad_report+0xa4/0xb0
>    free_unref_page+0x3cc/0x620
>    __folio_put+0xf4/0x158
>    split_huge_pages_all+0x1e0/0x3e8
>    split_huge_pages_write+0x25c/0x2d8
>    full_proxy_write+0x64/0xd8
>    vfs_write+0xcc/0x280
>    ksys_write+0x70/0x110
>    __arm64_sys_write+0x24/0x38
>    invoke_syscall+0x50/0x120
>    el0_svc_common.constprop.0+0xc8/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x34/0x128
>    el0t_64_sync_handler+0xc8/0xd0
>    el0t_64_sync+0x190/0x198
>
> The issue may be triggered by damon, offline_page, page_idle etc. which
> will increase the refcount of page table.
>
> Fix it by introducing independent PMD page table shared count.
>
> Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

thanks,

-jane

> ---
>   include/linux/mm.h       |  1 +
>   include/linux/mm_types.h | 28 ++++++++++++++++++++++++++++
>   mm/hugetlb.c             | 16 +++++++---------
>   3 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c39c4945946c..50fbf2a1b0ad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3115,6 +3115,7 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
>   	if (!pmd_ptlock_init(ptdesc))
>   		return false;
>   	__folio_set_pgtable(folio);
> +	ptdesc_pmd_pts_init(ptdesc);
>   	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>   	return true;
>   }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7361a8f3ab68..740b765ac91e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -445,6 +445,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>    * @pt_index:         Used for s390 gmap.
>    * @pt_mm:            Used for x86 pgds.
>    * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
> + * @pt_share_count:   Used for HugeTLB PMD page table share count.
>    * @_pt_pad_2:        Padding to ensure proper alignment.
>    * @ptl:              Lock for the page table.
>    * @__page_type:      Same as page->page_type. Unused for page tables.
> @@ -471,6 +472,9 @@ struct ptdesc {
>   		pgoff_t pt_index;
>   		struct mm_struct *pt_mm;
>   		atomic_t pt_frag_refcount;
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +		atomic_t pt_share_count;
> +#endif
>   	};
>   
>   	union {
> @@ -516,6 +520,30 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>   	const struct page *:		(const struct ptdesc *)(p),	\
>   	struct page *:			(struct ptdesc *)(p)))
>   
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
> +{
> +	atomic_set(&ptdesc->pt_share_count, 0);
> +}
> +
> +static inline void ptdesc_pmd_pts_inc(struct ptdesc *ptdesc)
> +{
> +	atomic_inc(&ptdesc->pt_share_count);
> +}
> +
> +static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
> +{
> +	atomic_dec(&ptdesc->pt_share_count);
> +}
> +
> +static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
> +{
> +	return atomic_read(&ptdesc->pt_share_count);
> +}
> +#else
> +#define ptdesc_pmd_pts_init NULL
> +#endif
> +
>   /*
>    * Used for sizing the vmemmap region on some architectures
>    */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea2ed8e301ef..60846b060b87 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7212,7 +7212,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   			spte = hugetlb_walk(svma, saddr,
>   					    vma_mmu_pagesize(svma));
>   			if (spte) {
> -				get_page(virt_to_page(spte));
> +				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
>   				break;
>   			}
>   		}
> @@ -7227,7 +7227,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   				(pmd_t *)((unsigned long)spte & PAGE_MASK));
>   		mm_inc_nr_pmds(mm);
>   	} else {
> -		put_page(virt_to_page(spte));
> +		ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
>   	}
>   	spin_unlock(&mm->page_table_lock);
>   out:
> @@ -7239,10 +7239,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   /*
>    * unmap huge page backed by shared pte.
>    *
> - * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
> - * indicated by page_count > 1, unmap is achieved by clearing pud and
> - * decrementing the ref count. If count == 1, the pte page is not shared.
> - *
>    * Called with page table lock held.
>    *
>    * returns: 1 successfully unmapped a shared pte page
> @@ -7251,18 +7247,20 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   					unsigned long addr, pte_t *ptep)
>   {
> +	unsigned long sz = huge_page_size(hstate_vma(vma));
>   	pgd_t *pgd = pgd_offset(mm, addr);
>   	p4d_t *p4d = p4d_offset(pgd, addr);
>   	pud_t *pud = pud_offset(p4d, addr);
>   
>   	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>   	hugetlb_vma_assert_locked(vma);
> -	BUG_ON(page_count(virt_to_page(ptep)) == 0);
> -	if (page_count(virt_to_page(ptep)) == 1)
> +	if (sz != PMD_SIZE)
> +		return 0;
> +	if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
>   		return 0;
>   
>   	pud_clear(pud);
> -	put_page(virt_to_page(ptep));
> +	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
>   	mm_dec_nr_pmds(mm);
>   	return 1;
>   }

