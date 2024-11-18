Return-Path: <linux-kernel+bounces-413239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268E9D1575
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F181F23085
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BD1BD9D0;
	Mon, 18 Nov 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mGcxz7pt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LP0dXBKP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD61AA1E4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947810; cv=fail; b=HlKI6ZEqxcQUDKOnk48s3q9NWCXPfOX8+CF0flbA3PVaG9VqD0gEgWuF9UE8WR289c3ktZl39/F8D/xw/YdQ6e5VSzLZwdctF8mcDMeQntnMeAVgZ7U6M1ZRE92jucVkprz8YkSjAQLDkLU5VMNLmFpJOYSpoDdyShz4ZJa5FUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947810; c=relaxed/simple;
	bh=G6yYObTRvh+bpNb+zCmdfnIe/HHoic0yDzA1Y0Gj0Qg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1a9ZD0KeO7wD+MhphFHpInIbZX3MEWcYgYKdbAPzbstdnSXrHU4K51CjBRGjTnZ9buG4KeOdtcaoxeMZXNP9D76iPDHo+cF4CEGxnFd2GM4JGfEcU/KebNwM+xvDVnDVQcNEb3cdy0rTm6qajG8h/tbnIAhMEhKB39qlnE5zpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mGcxz7pt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LP0dXBKP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QdFN012283;
	Mon, 18 Nov 2024 16:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GQWlQ8UYWCwFGD+y8FINkreX6b0FBjcd3a24vE2vQbw=; b=
	mGcxz7ptcC9YuqnXT1WHPgYgv1Zc2RhZCIRbyjEefQLM66YDiUCFsSwJV3jYRZw0
	+k0AxJFm/eBomhpv4ACPzj6dlri/ZNmU+ejSltmAh/8128YXm7lfp2OzvV6KsQp9
	Px5BrL7cqu4GHbeT4IMeWNISeQ+fS8rbWJIFi/yc+Jf7AHMElh5ua24+oiE7wH1e
	Ioji5246MiXwFiPjGXm4/o72MGrmqV/D6G2t2N+fVMV8n89dsXLCGFb5lhrNyq4c
	xbP1Iq/cupLBdAlXKbK05f53vmH4zOJks7vSaZBtarJM9suWMyVl1+bs7T0lusWT
	eUqLy46IFjD1c07CYiVIbw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98k1v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:36:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIF9pZl008899;
	Mon, 18 Nov 2024 16:36:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7hn79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzJhyESY601ByrWgxAbUa41fUKVg2HWglyehbbRmuKxqewgNq/Bpqz9C57SfmJG4tOi6Fyofz3K0w8Tf3yOCBymo3Q+yC8yIDjHCiCrgbdc72DHHz0bGmfDCJdujKsS/RQUOLfRUS3/B4jz6G9Ifm+AY+lKd8/eGZi9lgHAd2gEztZRdrRai7VorFzGCBP6fG2jAFFbILpBBLkhQMz0JN202Mb/t+9BJsnfto9ClXkomm1CaN4WLmDNlLXBYqqR14Ju5AJX2SOBTqzcxPDqpBByZEEa6gAZxpgmmtJO9U5rWO8DU74wmi/7uy6kOUHKlx5SyHrYvjQcMcXwvebC+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQWlQ8UYWCwFGD+y8FINkreX6b0FBjcd3a24vE2vQbw=;
 b=asFBl3zDFqgalcXcWgHJDcux5QiDqrmcU9IxkU5XglsZbAyxOW57WutqMSFKMK8IFLXj0wKGJBNQrxNAf6LJr0T+zMenTLlxhnFjV5LxHM3Ha0MaNzlOl8+zazwygCkMxMSWjlzKJ/ThxhqZuWV88xkwrOWI+cBdvdGSl1kAXFX1hB576HhCNoHhBBSdwekSzau1Q9iqn0LzqLNTSw0VuBYV6vsNbXjst3f8y+L62TzInPcJN/jL4bslr3fyX0Ow4RGXzqJLFkWxz6D7nkV0NfiEQIZ+UXRYbgb96KmN4AsuPSZldUuoMEI29cR2anNSMrv7UjEt53OOzojmBTmI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQWlQ8UYWCwFGD+y8FINkreX6b0FBjcd3a24vE2vQbw=;
 b=LP0dXBKP/bu6VDDFL/8DL5EeBf8prLLkdylXxZh0MKgxFg+EIP05b2YwQgT5O7uZoGdGH51IRXEd3eTQd7CfFlXRb3MYD2ZFVNcxUgXsMa92xitFjXYIDP+VsQUP9V/MUBohjE5OKY+jW2vqKu02RqXKSUBvum0YPRHc2QgsRdI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 16:36:20 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 16:36:19 +0000
Message-ID: <74e8665a-3818-4e6c-83d1-9a0220a79e49@oracle.com>
Date: Mon, 18 Nov 2024 11:36:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] maple_tree: use vacant nodes to reduce worst case
 allocations
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-4-sidhartha.kumar@oracle.com>
 <20241115075203.ojspk255cw3sr3s3@master>
 <2aa439f1-d33d-43ee-9945-5ac570506c7e@oracle.com>
 <20241116014116.a7am7z4p7k33rkl5@master>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241116014116.a7am7z4p7k33rkl5@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:408:fd::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4628f3-b03d-4824-9f53-08dd07ef214f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2N3NzBYQjd6S3E1SUhVZ01uNTB5a1diUXMyb0NhNVpHWDdxdzVoK0xnVW9F?=
 =?utf-8?B?T3RzWHAyejBmaXlYRWd2d04vczlHU1J5OGo5YXk3NTRJOTJtS01BTE9iVGox?=
 =?utf-8?B?S2xKM2ZXMU51V3AzZWhJekRhTzRnZHBmNWEwOXNOTFlEMjNZY1l3UUdOa2x1?=
 =?utf-8?B?QlQ4dys2aEtsWG1EMjN2TENJNWZOY040aXcxc0hUdXVGcCtUZjN1b2xlS085?=
 =?utf-8?B?UjY1TTYrcEltdmNLclIxTHlOakFQei9xWmUvbjhLZ25YWEhKd3FCRXBsb21E?=
 =?utf-8?B?L2pJN2hXanR6cVlPWTNNMFFrNDR6REhhVnZVUmQ5MURYM0h2bnhxVmpheVQv?=
 =?utf-8?B?NlpHYXhKY24rdGZHSGFOaEhLODNyZjRXRXZ5R24wb0R6Wk5HeFpMMTNOVDBh?=
 =?utf-8?B?TTFsR3hUSStlM1hrYnZmSkdNMXZsTlJIRnI1ekEzT2MrMHc1T05HbkRTTERw?=
 =?utf-8?B?UFgvSHFvRWlBQzl3WEVtbmhpdkpEc1lUaWpXZUpWYWt6NDZRcmFNMXBKK1RJ?=
 =?utf-8?B?ekJPVDV3dUtTWmhReXBRRGJVMHJ2RFZEbkswdyt2eXlrdjdERXBYWnQ0T2hn?=
 =?utf-8?B?MlI5QWNIcG5rK0Zzek1oT3h1TG5tYllkSitEUW1oOVJqWGZ3bTZxM3FNSXcv?=
 =?utf-8?B?WTBMV2FYYjJudkQ0UHhFeFpRZkUzTUtxSEczQkFCK0dXRXJJUGtoVXd6UGpI?=
 =?utf-8?B?ZU1IZkFMOEdGcCtvWWVNb3RaejQ1TFBpL2tFRVN5bCtPbndZSFQzYjFuUUJy?=
 =?utf-8?B?NDA1cmUwdWJJOGE4KzM5dnI3eGhnYkFPamdLWDU4ekNmWWx1RWR4OENMN2dM?=
 =?utf-8?B?S1p6TzlWbnAydDQ0OSthZmJJSFBsOHEyb0Q1MDRjalRKUmVyNjl4VFBZUkJo?=
 =?utf-8?B?cThRL3BTR2oxSzkyVC9COWdNREtGa1NYUFJUM0NxT280UlRPZzBhemlzQmpj?=
 =?utf-8?B?QWNRWnljL2RxSXNHczRwNit3aHlhYjdua3hMb0IrcWptOXJmZUtFOE5jK2E1?=
 =?utf-8?B?aXUvcXB6YkNvWUZiWFZFNUZOa2FGVktWVSs2NkQ0QWx2TjcxMlgvTUV1c1g1?=
 =?utf-8?B?WmRPSVh1Ym5TNWo2QkM5L244SHlrWGxLN3lDc3czNGw5WXdzdExEVXBMSXZ6?=
 =?utf-8?B?SXNTamhNdlE5aytwWkc3QUVrOW5TM1NMcXpQaVFlR2QwRWdueXNEK00zU2dL?=
 =?utf-8?B?NTFYdWUwS0JVK1NyMUFmZlZyOWlZM0hPQmtkMndiL3ZtZDlLTWxIcXBxRzhr?=
 =?utf-8?B?S2NRcm9rV3JhemNtNGdZdDRCb3NKTkJPTjdHaStMcVZGeTFzWm5pSUhyQ2kw?=
 =?utf-8?B?a1NrTy9idEJGYTM2OEgybjZZWm52NHdqSnVLYW8yQnhqaDRidkllVlprSjVm?=
 =?utf-8?B?a05DL01ieXdJa3VMdjRuMW5NMmFwVU11cC9wUXI0dXE1bXJsVmx0NkQ3Smcv?=
 =?utf-8?B?NjBIdW4rc0RNRzgyUzdsNnBXZE9xNHp1bHNTWDlkVHVWQWdVMTZFQzlSZWRu?=
 =?utf-8?B?bVlyQUpYQi8wSVdRSm5lMjQwNWtzeVpSMnJCMGR5NEFKTGpqMzJFYzZBUGpn?=
 =?utf-8?B?VnZaMEljNEpWaEdvVCtDWlgxM0VpL244ZENKMU94MEk4Y016NnAzUStsOW81?=
 =?utf-8?B?M0NVQ1hoeis2OWRmM0dPRFFuWHBOaldJa2QxbU5ZeHNqdW9xZFJvYjhVYnV6?=
 =?utf-8?B?MHMxVXNmZElDeUc1N3g0YUJ5V0VhQTliTXcrRTNiRmR1TFNZNTZsVkk3UXB0?=
 =?utf-8?Q?oNxA4ZLRYMrvB8vyCMPhZXIRGx0YikPtcG+I8Ni?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHk4UGo2SUx6eW4zTnd0SEQ3ZXNOSUlkVTRKbmNEejcrc3MwQXNRSFkrUGFt?=
 =?utf-8?B?a2JieTN6WXE5N3BTK01BTExJSkxTbHI1YithQkZWc3BjTFE2Y3F2NEVJT2NJ?=
 =?utf-8?B?eWJ3QnFjdHE4NUxuc0luSkxKSEdQWStkOUI3M1M0aEhPS0VIdFpiOWcwSWp6?=
 =?utf-8?B?cEw0VDVvWnFpUmVlTGZOOWorWDlIT3B4RzFWRkR6RDRST3VsOHVwUWVONFl1?=
 =?utf-8?B?OHF6SEp6Y0JpeE5ZTnJjWmFhUXArNWZWSWtjSlQ1cFBHTTlBOFZKWXI4eGZm?=
 =?utf-8?B?RkprL244QXVmQTVrSStsNjVaYXZJZ01lTEtUNTVZSjJrWEpzMjY2T250N0JR?=
 =?utf-8?B?OHBOSEU3NHJtR3k3bk9CWnpOcGR1QlhHMTduSmMvUFF4WW5GQXpyVk5QTDky?=
 =?utf-8?B?SklJQ1puQVk0UjQ4ekVaNWRYZks2UHZhc285NW5Vdit3SjFRL3Rwa0RHSnBy?=
 =?utf-8?B?Qm9DSElMaUN6a1p2azVJRW5XYmp2QXRXRkt3dDBveFFSZVNOWkdVVTJ1bUFS?=
 =?utf-8?B?Q3NrZFcyWndZc2VGTUd0djR4WXhoWjIrT3BEazVHT2FmcUx5TmhYajBUSVAz?=
 =?utf-8?B?WXlvY0huMTU1cVRjWnpXRU5vN1lxQVpxdU9uOHdBU2NXVkFvUlkxVUZLajRU?=
 =?utf-8?B?aXpxOVlrT3JLQlFwNythTmFESWlDeHNQRjFPck1RSnZpUnVpQXk3Uis4YmVX?=
 =?utf-8?B?RWUyZWhkeEFmYStuTDFGNUMxZUgvREM3cC9QNE0zOTVseTROOXAvbXMxcndP?=
 =?utf-8?B?MWdWUW42K0xBZTQxdEtYNzhDUXdjaFFKMVk2NFVlSjlZK213ZTVRZDR0eGJN?=
 =?utf-8?B?T3I4amZCcEFja1FNZGtzWkZMWmd5d3J0TFMxclF1ZHB4Qm5CWFJJc0ZXNVB4?=
 =?utf-8?B?dWVBbDB4amtRbWp4OXYrV2ljVmpYcm9ub1QybnZpbUFFc3ZmdWJ1bGZiOXpB?=
 =?utf-8?B?S0ZlQ1RGMmZSODA5Y2ZoQnBLbkhpUDdBZzY4LzdYNWw5ZVFUZWw0SFVXUHQx?=
 =?utf-8?B?RllrOHVobVBBMnBSYm1vR29lQ2JHbDcvR1Qva3NXQVpzdXdCRnVNVUtrY3NR?=
 =?utf-8?B?VDhTYWlMUVlvVTUvNXJTQVYydlc1eHhYdkw1c3NJajVIS3dyV1Y2bVcxcmpR?=
 =?utf-8?B?T0NtUjVkQnhEdUFoUG9KSHcrNTE3TnhEQkVwUm5NNEgyVyszNFhFRzl3bUht?=
 =?utf-8?B?LzVzbSs2UDVFSUc4QzhlSXlLeDdJVVlwdmFMTnE5T0UvK3VvR01oNEtBQk42?=
 =?utf-8?B?Rlk4SEJUSlhHUEgwdEcvVFg5a2U1a0dsOGlydGVQZkJkWHVqaER5UDI5NDFF?=
 =?utf-8?B?Vkd4eHpRM0FvVXJhYW56cXZ4MXRTUVo1TG5TQ2lSRVhFdUoyeTVmWFdnbzdp?=
 =?utf-8?B?Y1NzWlRRb09VMExDMGdQUEZWT1ZUQ3lzUW1OZUlmbWd1REpKRElWblo4Uk5s?=
 =?utf-8?B?dHN2ZERJQTAyVXlDNnJodUNyUDhxbUUyWlN6ZTZYTWFOT0ZBTnVpOTU3T0R3?=
 =?utf-8?B?STJROTFMUW1uSWRJdWxJYkJncGcrQlJDdnZ2N2p6d24wcGt6TlFTMDNHdGxm?=
 =?utf-8?B?cVdYb3p4SHFIRmJGVXczKzN6SEVaN2F3ZE5xbGNpYm9uSGRKN1EvMDAxOVdt?=
 =?utf-8?B?YVdiNDc0Zkx1L0hQdGc1Sno5eGJmNVg1OXNKYzg2eHhVQkRSeEJ5VnBoUmNq?=
 =?utf-8?B?aVpCdG5LTHQ2L090ZHFzNGkvOVhHaHFaTU5TbnorRm5ZUXBFMXNXbG5lRklT?=
 =?utf-8?B?VnhDRnI1NkdDNE5UUGFoTldrWGxBTjdFVUJBQ1c1eHk1Y054SXMvUStGRzNq?=
 =?utf-8?B?QmRsaHg2MjhqWkg3d0JlQTNhYjUvWUNhaURpYjBMVUZuU3BvN2JScDIwUTRj?=
 =?utf-8?B?TlVaWFg3WnBqZXVjSlliZHF4akY1S2ZqT3crb1pVcnJndTFycHI3WVEySTZY?=
 =?utf-8?B?ektibWVlVGZtTlNlbUpJSjR5cGY4eWMrZTFTTVlUVTVleUFUQS9Za3ZXSXBv?=
 =?utf-8?B?SzBMUUNSKzVCbzA4c1g3bUdVR2J4OCt4WWU1SnVBUTQwamNkdkhISnVEKzZN?=
 =?utf-8?B?NnoxQlhLRHJ2cUtySmNaOEpsTC9LZTllclBXSjRVTUhmbjlLTWYwSmx0UFhB?=
 =?utf-8?B?a2hKSk4weU5aRlJFYlpIOHQyQnJua09CKyt4VEVEcDdEZFRNcTVRUytpdVYw?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w0F0K/IvowsqiBZl/z0d1h/IDhzrmJy2X4kbOoYpZuYluzi8U8oBl4EPmoxOvP/tnt2zJ2Y10gHpnqgmwgeAt0jfE1RTs/ZoFtj3/u98OU8MMNJ3j0wE5w2FnPYsaCQA/zY20mU0J6ETRq0ZfzcZ1rC/H4M5Sf8A3yLsd6wGynsnT3PP6Piy3dTnJtt/YJnLA3g7X3EEUpmGJjwYoexNaV7ojEjK4pqd+/TChP90ZxRDH3cOe3OiOL7nxJZhCFl3jeGzQUla4IVxHr6pcHoT6pqNpSq0+uljAW8tP4oh1suZZ+dqOn2WmYScnLuKkSfpvxtXjS90gt40fOdd0fMSkupE/YCEB6ime2jZCatRfyLhJlNCiwx13YcavOHTX7tNSVmAV5vQPKPz06srzXB/q9z30iR0RYgJnlXQwI9ZS5Y71ourBvd4w6T/tGhNSF/WJ31iVEwKSgrolTMs/ld4aV2J69+fBpfOy1Q4Piu+9hm6L33CQF0pO8mVsNrj5Bc9on49rWtoM1WGKprF2S20jdX8Fx9SARgB6/IjQ6+ZA6sMf0xkwqVrRe1jL/g0TpUg2srttoNCz7zBFGt//8RAoiyBdxATgOVUvmuz07TDte8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4628f3-b03d-4824-9f53-08dd07ef214f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:36:19.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNn0UW2QSbTMGUNKFY3nfi8a13e2mZqvjB2UM138DVcDaUCJrAI7Jy78WyKKprJ0x8KNpG/DsUU39IJ4EojhM2bC8Hkw30E/0EKy8s7LysI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_13,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180137
X-Proofpoint-ORIG-GUID: XJ_BCF7Mpn8EJpV3_JoUnx6_jJ8yKQgB
X-Proofpoint-GUID: XJ_BCF7Mpn8EJpV3_JoUnx6_jJ8yKQgB

On 11/15/24 8:41 PM, Wei Yang wrote:
> On Fri, Nov 15, 2024 at 03:34:55PM -0500, Sidhartha Kumar wrote:
>> On 11/15/24 2:52 AM, Wei Yang wrote:
>>> On Thu, Nov 14, 2024 at 12:05:22PM -0500, Sidhartha Kumar wrote:
>>>> In order to determine the store type for a maple tree operation, a walk
>>>> of the tree is done through mas_wr_walk(). This function descends the
>>>> tree until a spanning write is detected or we reach a leaf node. While
>>>> descending, keep track of the height at which we encounter a node with
>>>> available space. This is done by checking if mas->end is less than the
>>>> number of slots a given node type can fit.
>>>>
>>>> Now that the height of the vacant node is tracked, we can use the
>>>> difference between the height of the tree and the height of the vacant
>>>> node to know how many levels we will have to propagate creating new
>>>> nodes. Update mas_prealloc_calc() to consider the vacant height and
>>>> reduce the number of worst allocations.
>>>>
>>>> Rebalancing stores are not supported and fall back to using the full
>>>> height of the tree for allocations.
>>>>
>>>> Update preallocation testing assertions to take into account vacant
>>>> height.
>>>>
>>>> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
>>>> ---
>>>> include/linux/maple_tree.h       |  2 +
>>>> lib/maple_tree.c                 | 13 +++--
>>>> tools/testing/radix-tree/maple.c | 97 +++++++++++++++++++++++++++++---
>>>> 3 files changed, 100 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>>>> index cbbcd18d4186..7d777aa2d9ed 100644
>>>> --- a/include/linux/maple_tree.h
>>>> +++ b/include/linux/maple_tree.h
>>>> @@ -463,6 +463,7 @@ struct ma_wr_state {
>>>> 	void __rcu **slots;		/* mas->node->slots pointer */
>>>> 	void *entry;			/* The entry to write */
>>>> 	void *content;			/* The existing entry that is being overwritten */
>>>> +	unsigned char vacant_height;	/* Depth of lowest node with free space */
>>>                                ^^^           ^^^
>>>
>>> Would this be a little misleading?
>>>
>>
>> Could you elaborate on how its misleading?
>>
> 
> As you mentioned in previous patch, depth and height has different meaning.
> 
> Root node has depth of 0 and height of 1. So I may wandering whether this is
> depth or height.
> 
>>>> };
>>>>
>>>> #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>>>> @@ -498,6 +499,7 @@ struct ma_wr_state {
>>>> 		.mas = ma_state,					\
>>>> 		.content = NULL,					\
>>>> 		.entry = wr_entry,					\
>>>> +		.vacant_height = 0					\
>>>> 	}
>>>>
>>>> #define MA_TOPIARY(name, tree)						\
>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>> index 21289e350382..f14d70c171c2 100644
>>>> --- a/lib/maple_tree.c
>>>> +++ b/lib/maple_tree.c
>>>> @@ -3545,6 +3545,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>>>> 		if (ma_is_leaf(wr_mas->type))
>>>> 			return true;
>>>>
>>>> +		if (mas->end < mt_slots[wr_mas->type] - 1)
>>>> +			wr_mas->vacant_height = mas->depth + 1;
>>>
>>> For some cases in rebalance, we may split data into three parts, which means
>>> we need 2 extra vacant slot.
>>>
>>> Maybe this check is not accurate?
>>>
>>
>> The triple split scenario which you are describing comes from the spanning
>> store case not on the wr_rebalance case. There is a check before we set
>> vacant height to return if is_span_wr() so I believe this is correct still.
>>
> 
> Hmm... I come up with a case in which vacant_height may not high enough.
> 
> Here is the subtree where spanning write locates. The first level is the
> parent node of the second level nodes.
> 
>                  vacant node
>                  +--------+-+-+-------+
>                  |        |l|r|       |
>                  +--------+-+-+-------+
> 
>                  l                 r
>      +------+    +----+-------+    +---------+--+    +------+
>      |      |    |    |       |    |         |  |    |      |
>      +------+    +----+-------+    +---------+--+    +------+
>                       ^                      ^
> 		     |                      |
> 		   index                   last
> 
> When mas_wr_walk_descend() to node l, mas_is_span_wr() return true since last
> is in the right sibling, node r. Let's say the parent is vacant and l/r is
> leaf. So the request number is (1 * 3) + 1.
> 
> Let's assume:
> 
>    * vacant node is just sufficient
>    * l's left part + r's right part is sufficient but not overflow
> 
> Then the "new vacant node" would be deficient and needs another round
> rebalance.
> 
> For this case, I am afraid it doesn't allocate enough nodes. Or I
> misunderstand this?

I think you are correct and we need to use the sufficient height which 
is introduced in patch 5 in the spanning store case similar to how patch 
5 uses it for the rebalance store case.

	case wr_rebalance:
		if (wr_mas->sufficient_height < wr_mas->vacant_height) {
			ret = (height - wr_mas->sufficient_height)*2 +1;
			break;
		}
		ret = delta * 2 + 1;
		break;

> 


