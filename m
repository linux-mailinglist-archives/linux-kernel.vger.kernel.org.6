Return-Path: <linux-kernel+bounces-340926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C885998791C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B111C20F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C0165EE9;
	Thu, 26 Sep 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bm5j0P2Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AOwkTBQd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CF33C9;
	Thu, 26 Sep 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375367; cv=fail; b=Y8Pcp7QbA+BMVkaeckbprEImCyJxIj9y+skIULzws9DECa8evOPQoUd9vRLEdX6zkVFHyGkCkjVkQOZSOJr8DJeBIqY6adU/PkqIrnBdAuBzmL4ED0Q42VE7APNxDD/5EDJddFSRhJ46+gjHysLGtoXiNMl1eeoi7/KGjD/9+ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375367; c=relaxed/simple;
	bh=hH6bBGua5nXwQ1tmTeQSRaijazGAsvp+2a/JZyxETFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/kcFJdFFfhU09FYolEhZvFpokbY5Wea3MCQAZx475jq2gEQRRrRNchqm74CnkTha4lY/CdWEbWwiEbFAvQscIViucmQNA8tFIl/G/mYlWCHaXI6s0nnajU7crt11/b/yYCBvwQnsjhUPcciDNRxTcFcsVHSaNN7PoIrTlcB2UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bm5j0P2Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AOwkTBQd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFiVp7029558;
	Thu, 26 Sep 2024 18:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KhR7kLKlRtyJv90VsknxiKmq1LsouRCPNW9xohNc32E=; b=
	bm5j0P2YXyvyrl1fRBU5KCnB2YtGENiSd3pLhBqfiOyGTUuTs/dLw/ygyc+gQUR9
	JXuyNIydMjufYRE79vBfGwUCe6/Tplju6EVzaRJnrB2DycaQ3uGVLZM0ZYMSdEOG
	98jGf12avwug3joRCsM+42RVCsr3jvG3Jy8H57l+3lMH5lr/eAUyL8PnvWlfl+ei
	Wd15domMvEAGQGIfLWNhxa4au5GiIH3fYHbw9TxPLjNk0WOWGKE+AJhxlF5tFsrh
	V/LGlMXJAEZvwhMXzrO0lBiSn3mxY2snmR6CAv4bZeptD8HnxA4MwU1IAzv23m1X
	NFJGujNW6NqWNIW7dGbpkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6ckhy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 18:29:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QHOIVQ031483;
	Thu, 26 Sep 2024 18:29:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc94fhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 18:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRRXPtIX1GHrtQO9m0bEVIx+pkh8AcaPt9ete1db3ZQ6XRucH6be+SByQ2XJ2BBCVr5pz2oX5HdbvgO6TtKcN6wjjat3/y6se27YUGQ2tlZmmZzuYOukrKCeQ5lexGz5iMHl3EloGtc6uvjRhLqF2L2ZQygop8qV+/gK7jRwVJ0tQKoKxcRVsXRAB3KSe6NVfVy2UuNigCaf4I2gJftnjqBDeOvp/g0CU8nFp/8syXIJJ682RZm+vuAJySenfnElEwnIzkcEqdfa/+oS2F4EBd9DKsuQWTNRs1y2gB9MkmKdPb3Hr5WLRxgdjBKUqDIg6iIcEpiNbYOEJJBZy6g4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhR7kLKlRtyJv90VsknxiKmq1LsouRCPNW9xohNc32E=;
 b=OgjBMpVLa8BsqML8QzFggXRnGmVpn/3z9L/CEkgx6vPPcsyGM+kMuvlfxZh2+L8W/HUABUDn16lOLf0CVRSFMyY9G958pMinLxM0f7H38o4jj8STBWQq6tw4Zm1LKGs3zr+76pUfmry4Loc0YRcRQ478/1sy3G+3iHBCEOIGXrtNoHt+27kugmw3mgKjMUkD3MLNM8oIUs44ujOc5pGzALMou19HAj5xvwVgZL5PgtBeUDGp7oxh5lKkYIIvp2e+phkLCXeMxNHvIVlb1AUzXOSbZSes4/y0llMnlSlxwrgo/HiP/bqIJMwZjV6FuHiEKJIGETMBXamPJcMdUPjEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhR7kLKlRtyJv90VsknxiKmq1LsouRCPNW9xohNc32E=;
 b=AOwkTBQd/Tv0oV+IvJIDql8vBmXOdAxrnOn8NWr0zZLbc7nxAgTbuQLNMVuU+sKMm8yy+V6I30PFn0hsjvgaYWH73AKL5RAGYWuYcjF/nivC4LBdB1VhAoeTLohNjJ40MZTF6HiSkYNTD2uuP4jpNtugCps/C3EoY7txTExYKAc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MN2PR10MB4333.namprd10.prod.outlook.com (2603:10b6:208:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8; Thu, 26 Sep
 2024 18:29:13 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 18:29:13 +0000
Message-ID: <d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
Date: Thu, 26 Sep 2024 20:29:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
To: Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>,
        Brian Mak <makb@juniper.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Roman Kisel <romank@linux.microsoft.com>, regressions@lists.linux.dev
References: <202409160138.7E27F1A55@keescook>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <202409160138.7E27F1A55@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::34) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MN2PR10MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: e3950268-1059-4a6d-0790-08dcde591eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTlUTmdmN2Z5RElGa3R3aWRjMU5VSFBYN0FBWHFSNCtVdkpzSWh1NnRnbkk3?=
 =?utf-8?B?R0VQczc3YlIwUTAwNW5aS1N5a2txNnpQRURJNDBEY3dCRE1xNkdGYjRLbTRk?=
 =?utf-8?B?Y1hudHd6VUlGdDlReVNvNXhqWmZjaTlDaUJ4RDFqYXQ2djljQnZaRlBlTzVR?=
 =?utf-8?B?SGRSdTV0NCtMWmtEWEZKOUlVcDR4eGowSldUdnJsSmdUOG9ReHFvVDdjTlVs?=
 =?utf-8?B?SnVoc2ZwSkowQW5JTzFIVmlMRlQ3c3UzYWpSUmlTWWwwbkMwQmFhUStsTXpC?=
 =?utf-8?B?d0IyQzFpa0lBR1h1bHNkNU9LVmJISHB1b0pCcGlVQ2hTUlFkaHhPMkRmOXBY?=
 =?utf-8?B?dEh2NnBPc3RGOFYxNUI3RjdYQkx0Z2lqeWxDR0xYYXVBSVJ2TUpxeWp5djFv?=
 =?utf-8?B?ZjN1Tkl2M3h0bEJwaGVtNUtxNk54OUxEQWhCM0hLeVZYWVB2S3p6SjV2U0xr?=
 =?utf-8?B?dnV3Rm4zZXFsUGN0YnE2NDFwTE85U1lYdTNWS3Q5cHJGK0R6T21XSnovK081?=
 =?utf-8?B?MjdUcnpMTVJ5cEFRWkRwRjFSbnVWZnFDQkRKd0hDZFdwTXRBeHZJdWpsTHlz?=
 =?utf-8?B?SEpmMTlqUytLd0dDc0drdUtCQTVaYUVGQTJFNjUvUU4yV2NtcExWL0w0bjJh?=
 =?utf-8?B?cDFqcGdacWZqWFp2aHRmSTdVaWhiZ3JyWFBwcEtyQjJJdU9VUTVXZlNpejN5?=
 =?utf-8?B?SHdYb3dOTFY2Z2dMR3htcmpqeFFxQVJyTjFnOVVMT016dFQ5YUovQlBVY2JT?=
 =?utf-8?B?UzNtTGxoMU9QZ3Q5Zkgzbnl1WEhpVlZlSzZXS0h4UysvTkpTbmxHaHR3SkQ2?=
 =?utf-8?B?OTJwMDR2WDgwQXBnankrTGFXZ25qT0FERVZaOXpjMWhSNXBHQmpyYTFtL3ZC?=
 =?utf-8?B?Mm1DMHdwYnMrQmFNNDFnV012QmUrOXZValg4bjJwNjB1Zkg0b3BxSDJkRGRO?=
 =?utf-8?B?RmhJYnYyQ3MrVEswZGk2YURLT2JwM0Foc3M4OWVWZXcrOWh4amJuV1VmUnZ4?=
 =?utf-8?B?V1dwdG9TQlFjcnRWcWx3cEErYWpHWXBuRE52WVJVMU8rSlhHbWkxZnZ4WmJu?=
 =?utf-8?B?MjhabXBXT1FSQnVhWHN1Q2pwY05kaUM0THZxaENHa0RaMXpnNkpEQ0ttZFg0?=
 =?utf-8?B?NzJLQ1FkRVMyRlBrNWVNQjhQSGRBaDIvL0toQ29rRjVsL2FNYncrUWlhMU5m?=
 =?utf-8?B?d2xNbXBFTit5ZDFqMGxOMGl6eWdyS2lDK2F3cmlqMFh3dmNCRFN2OG9TMnBa?=
 =?utf-8?B?eU5Fb0tKNGdPMGM5YXZJUFpDdEtXbmpnTk9VNWc0eUN1QkZBZnBqUFpRalRR?=
 =?utf-8?B?Qzg3WUhSWXVMQ0M3SktBTGpQaDU5Q1dqUFNKOVM5bDBRV1Q1TDBEaFVLSUE3?=
 =?utf-8?B?dmtCN25BV1RkYlpQWDFPWnFRUzhGTWtFT3d2QjhDUzVPeHZaZk1HOXAxVWpW?=
 =?utf-8?B?ZmhFRWRIcHd3VDQxLzNSYTAra2lBelR4Y0R3dmVqMnRPN1k2ejRPQzYrK1hG?=
 =?utf-8?B?VFk3OFE4L1JxNlQ3RmFrbmFLcjAyQXJRckVaMXBtKzA0UEdJR3d5c3hwSUpX?=
 =?utf-8?B?VU1SODlIYWZIckNUSHg3WEdTZmRoaWwvOEJpbEx4Zm5TR2hnY0srL2kwUFZq?=
 =?utf-8?B?bG5VMW1oTGFQVUhDMVZlZ0pJbmJGdi9wWGZQMHp1Y25rNVFjUmZmc1o1cmE4?=
 =?utf-8?B?NFVENHVDcWN6WTVTZU9iVStzVm9rYXR5N2hrQ3E3empNRmRHWlhvaXluRmwx?=
 =?utf-8?Q?qAK3RoWZG9SiJ9WfeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEhmREVtZXBRSTZrSXhrZ0lVazlVSmo0S1lUQzUxYTVoU1oxRjRNbWE4ZktK?=
 =?utf-8?B?UnFJRkFhbWo0Q2FtdU9GalRwSVhkc3NHTXV4bzdNRkhvazJXa0NpK0RxOW9Z?=
 =?utf-8?B?UHkxcTYxQU15bnB5dXlweFRwMWZscUEvZzB5ZzRpQXBFVVZLUVdVTlQ4RWNq?=
 =?utf-8?B?M2hSQnlpMTUvbU1FcXFZRVJIZVloT0VKY3VsTWt6anFQeUQ5Znl1NUptNzNu?=
 =?utf-8?B?KytRRUptYUVOZHZrSTlVWnUwdTVHRDhYanJJSkZRcmpCbjdJc1pvM1BYdlR6?=
 =?utf-8?B?L3QwOGRUdU9hQkRGQlRkTmhzdFEvNGd3ZmhCMmgvSmIwYjZENi90citNRE5p?=
 =?utf-8?B?anF4NUdLeDh4L1pxcmlPNjk3Zi8zZEs3ZkUySUlKdSsyc05LV2thRWhOcjk0?=
 =?utf-8?B?YVRySUFwR1R5SnN5WjNic1ZIQ2ZYNmtqNGdBQzYveEhneVNjWGRLVnZzYnND?=
 =?utf-8?B?R2pRWXdXQXJMbXBrSG5LZFZZdVZINHliM1hTSCtMOVhLYUdUWFU3RXVuVFRT?=
 =?utf-8?B?SUFFMzc5Qyt6RGhkWTVYOVYrZlM5K2EzOTVFZTdXRFZGcGJxZkh4aTZuYi9u?=
 =?utf-8?B?aVRZVFZRajJPdmNxWncxcGZUcGdDVDJaMTNvVDRIemU1TlJ6dVc5WHJ2eW9m?=
 =?utf-8?B?aVhvWEw2Wi9neXZMb2d2QlJHb3BsZ1Q4TG1aSTd0UHRIZjUxRnAyYlpIM2E1?=
 =?utf-8?B?YmVxRzBpVFFjRzVWTzdOcEFwTWlKem1nV3RQNEROa1hmQlNsTmdOY1ZYR2xO?=
 =?utf-8?B?TDk1L295ZzFyNjlmQi9TUSs2Q1BkK1pJQTNNZFJkVlBvbnhsUUp0ZFRwSG8x?=
 =?utf-8?B?d094SldrYysrWWo5VHN2dEhDMHlGUTBuRGNmTkNPZllGYXBESndkbGtIWDZK?=
 =?utf-8?B?UmpVbTY4RytvNHFNbGdhMDMwUzNWRDlocFBOSkFTY3FyQ3d5azUrOGV2dTNJ?=
 =?utf-8?B?UFN6Y3RvS2Z4eG9rUGpwejEvVlIwWk5rVU1aYUR1aU4vUVJiei8vdm9sL0gy?=
 =?utf-8?B?em5GUFlrY1VubHkzZGlYeE9sN2hIeGdaSjFrT1Y3YzYzRnRHZzJLbktxSVVx?=
 =?utf-8?B?UEpzN21YUGdHUUFaR25SM3oxSnZJUzQyLzNEek1XWGNSdGp3YUhtbWNocC9l?=
 =?utf-8?B?bS9YcEttemVLNWJMUUlYZDlIcTIrWTB5MXBDWUtzaTB2blY2SkE2cWIzbER0?=
 =?utf-8?B?czVJb29vQUF3SE53Vms5UHJKNFhjcldVVUEwOU1POTk0enEvaDFqbHlBVjMw?=
 =?utf-8?B?OWd4dStGSkJFRXp3NEUzVG41RWtKeXIwaldRMFVReG1lVVBPdHdTNGltWDFn?=
 =?utf-8?B?U1JxRFRmTUdKeFMyNGlON0VpRkpYU2ladFZMNFZkYWhaM25iRDI4RHZ4SXdt?=
 =?utf-8?B?SnFvSXdGNXJ3YkNVMlhrSEdTQnVJUFdvOWQ1emNuQm96b3ZCOGZlSzNka3Ri?=
 =?utf-8?B?TkFKdWFJTkwzcUUvRGZUSXE3Nk10MDFYNnF2UU5KbVpVS1JjbWhxV09jcVFH?=
 =?utf-8?B?NzFMMmJxU2MxK0xlWm1Nd2RXbzd0eGE5ajRRei82bGRUaDdGZkRNUEpDWm41?=
 =?utf-8?B?ZDZTamNuWVZTeis0V0VjcWI4L0ZyMjZGakJJWE0wdEFCZVVCVTRIcG5EcDZK?=
 =?utf-8?B?LzVMVFVXQVNsbWFsK25SQmNLSEJ4RDdZYTVSNnlSNENjSzhUVnN1dDZLcFBp?=
 =?utf-8?B?amRMa1BxYXc2cmpKc0lTQWFNbEFZY294OHQyNE15SXlUMVFLbEpHZXVuSGZI?=
 =?utf-8?B?SFIrNFlwZXNMcWhtaFkrS05JNDU4M2VXZFEzNU1GeXBhWC9zRUczdXdIODEw?=
 =?utf-8?B?c2IvQ2I0L2lTczMwZnpmYmZ3SkVEUW9QY2ZVdU1yRnkxMSsvUkUrQVVFWjhE?=
 =?utf-8?B?Z1VNVEl2WnZKWUMwWUkzdnpYV0c0bytSQlJnMG9MeFlrYW11TGphTnNpUmhj?=
 =?utf-8?B?TGpMOXV4MXVWZ0pNb1F1QjhIbGdGRUVjTS9ibDREQVhFOHNZdXdNMHVMNWFm?=
 =?utf-8?B?MjFUayt6eHlmaTQ2ZVQrakNwdTlyaEx6LzhJby84Qy9FVEk5QVZwaTRmcmEw?=
 =?utf-8?B?ZFNSdDRCa3JpbDlUajhuTFk2WlBSK3J0S1ZCcFNQYkIveE50bVhHYUVLbVhs?=
 =?utf-8?B?U0NWQzhKK0lSWmdYTHFzN2VMazMydjJGb1NzMEZRbjhKUmRESUNnalJCcUly?=
 =?utf-8?Q?J3oRLydt0GgyhusAgIub15U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8o74pF8kUcY/yVpdKB8Ud4eW0x5ZWB+q9J525nr4yojhgFSFHPAL0tRLvn+6TEvSLKwfqKhV9tJyKTJTMBvfvu2ezVuqPgkAqpj3hIEfRvcEo5/25nTH4WB7N/j/4tBbkMtJkOXlWUEjcC2cjAjxs6nuXNbdb1IoOxQA0KEdmZf2d2HSQ5lyvRMqaSarIHbSpgFO+6dyP+ttycaVjn5jsTRbomLaZdl614JBSiZtHFUVSgtcsa2urFVfUykUzvPVwbJCCXoxvETLUu53Lz1VO4/zZnXwLxSYiU/Sd2Og3rtSZffqPtS3Gsjds2/lcbdjZlxB5Ub/xeB2hIhkpN1ERXRgIfulfkfobui0GD2TjdCmipjS4XahnxJhOsY4BJ96uxJePi2cpB4p/CBosx0uP29tZULpgt4/rkB/X2v8HbEYRHbbCSMPbCY4sqxiOIp7m/dztuANAZennnTnHjdkJjIJT9a1/umTxXvNrVsHm68RUeLaShxSNQVYA+nTa/5PaurXPJvxVgD6+3h+1+5/7r7B459IRx7DgbIOoLQWDtDIFJesl9EnOAhT/KIFCWwI+MBatMoG7n6MNahaHI/WnQEq269nRy3WVxLJ1I2YBSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3950268-1059-4a6d-0790-08dcde591eac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:29:13.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSGWfEDCp2ceAO9nu09zJcVOOGdVt5Qg/0HMqdLLmt3NO6thQyogeshoTMc/E2UgxZpf1HIvsy/h6WWBVAtIsbowROWqoxes883SYRrrXzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260129
X-Proofpoint-GUID: 1jWeGQ8O5iHZVDx8nGzSFQEw_VrUlEmq
X-Proofpoint-ORIG-GUID: 1jWeGQ8O5iHZVDx8nGzSFQEw_VrUlEmq


On 16/09/2024 10:39, Kees Cook wrote:
> Hi Linus,
> 
> Please pull these execve updates for v6.12-rc1. Note there is a trivial
> merge conflict between this and mm, which was resolved in -next with:
> https://lore.kernel.org/linux-next/20240909171843.78c294da@canb.auug.org.au/
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:
> 
>    Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.12-rc1
> 
> for you to fetch changes up to 44f65d900698278a8451988abe0d5ca37fd46882:
> 
>    binfmt_elf: mseal address zero (2024-08-14 09:56:48 -0700)
> 
> ----------------------------------------------------------------
> execve updates for v6.12-rc1
> 
> - binfmt_elf: Dump smaller VMAs first in ELF cores (Brian Mak)
> 
> - binfmt_elf: mseal address zero (Jeff Xu)
> 
> - binfmt_elf, coredump: Log the reason of the failed core dumps
>    (Roman Kisel)

Hi,

This last commit seems to introduce a regression for me, creating a
completely unkillable process (but idle/0% CPU) that is stuck here:

$ sudo cat /proc/2453/stack
[<0>] do_exit+0xee/0xac0
[<0>] do_group_exit+0x34/0x90
[<0>] get_signal+0xa63/0xa70
[<0>] arch_do_signal_or_restart+0x42/0x260
[<0>] irqentry_exit_to_user_mode+0x1e0/0x250
[<0>] irqentry_exit+0x43/0x50
[<0>] exc_page_fault+0x94/0x1d0
[<0>] asm_exc_page_fault+0x27/0x30

$ cat /proc/2453/status
...
State:  I (idle)
...
TracerPid:      0
...
Kthread:        0
VmPeak:     2240 kB
VmSize:     2240 kB
VmLck:         0 kB
VmPin:         0 kB
VmHWM:       568 kB
VmRSS:       568 kB
RssAnon:             136 kB
RssFile:             432 kB
RssShmem:              0 kB
VmData:      420 kB
VmStk:       132 kB
VmExe:      1644 kB
VmLib:        16 kB
VmPTE:        60 kB
VmSwap:        0 kB
HugetlbPages:          0 kB
CoreDumping:    1
THP_enabled:    1
untag_mask:     0xffffffffffffffff
Threads:        1
SigQ:   0/62622
SigPnd: 0000000000000100
ShdPnd: 0000000000000100
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 00000000000020db
...

The process is so unkillable I can't even shut my laptop down without
holding the power button for 5 seconds -- apart from that, everything
works correctly.

Bisection ended up here:

# first bad commit: [fb97d2eb542faf19a8725afbd75cbc2518903210] 
binfmt_elf, coredump: Log the reason of the failed core dumps

I have to admit I don't immediately see what's wrong with the patch.


Vegard

