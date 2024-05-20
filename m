Return-Path: <linux-kernel+bounces-184308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975808CA52F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E411C217D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F2137742;
	Mon, 20 May 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oRrIoxGX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uaqw4866"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3B374D9
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248727; cv=fail; b=Tr3VVK8JkmotUcU2ypY9v7ecYDrtUNKGpXFpoQDzId8hCSbuWXPGKckq0npm5ltrh6P+qX2XbCm8YvQhwe7sqSIlRd/uR+98L2ZMCgB03sPGCZL1vLsDZY5iz3ZjrQjHBDuMSkcZ4Y1O6SI4YNZqSUe7QchG0qYQRuZ6b5WhEzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248727; c=relaxed/simple;
	bh=yQ0VhT+I69TD6/u6xOzzuzol+abNg40NFo1Q91/1/T8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qe4tjDkS+7tx9tj41xASOzA9RRSVip4Wp7kqwCKciZ5txe5AUIwqMD1IyoJKV/yODUz6bAYd/CK4efJsLfbp3C9DzTNgFGAvWwqV9jHf0dJWEG55wfSyQSqftFkz1iWyoOGkhthZeKrD9NXdYELcTLpl1uqRfj6xCR3+Pi7fyKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oRrIoxGX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uaqw4866; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMwwWY031449;
	Mon, 20 May 2024 23:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+1l8CVPSoPtYuySsuoNrbF38h5Wv9lFll5IQCvEc/BQ=;
 b=oRrIoxGXeYdKQWrDd6vY8Qd2vDhnenQx51DLIbaqjtO58OnyPLPPHBRPW4FVEMsTsGIQ
 9QOtM56fZ9cGjkxAQts+yKGHSdTB7Uda85/zwdBA4clduKU0MfN5NZiJBib4zrOXz0kj
 tUjvOT6Sy5zCv50rJsY7uT8Ift1uLZON+0hkmtAHPvi7SujOMxNZWLH5lvYbMxY5YyHk
 aWlpornve+/7PYcF+U4/lIn2p6TtQhmF3hoqhrHQBdpGc38/ajT2qaoHCTuztEynS0zF
 U6BLLIYr9eby6TMLV9a6EwumL/5Pn8oC73b/y9ydzGidGPUocC3xVB7ulKCqlINFvBP/ pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k463w5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 23:45:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KLr4NT005021;
	Mon, 20 May 2024 23:44:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js740ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 23:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+TfJeplGS+XzcdAKcYCTcLq+Y5Gz7vPiKVsVS2xncI+zue8e6e5mAs7gh3e15wTw/5kB0RyHELxrgzT+Oxd0sLwcLXnbNJOcYBH5eT5IP3hD0wRvIn9mASalyLRG5m/HT4r4RZd0CSTFP92HlF+LDYL3LulbtDhD9wqWFHqgcoM5Y9q0fveHToCvW3Bs9s/IOQc3sVL1FuyjusTJE7ATlZHVqOXJWjzPxpxvHN02Kew5AA1Ue+uBMfDLkkUFq+7WDwClPg0pYnQUfLli94X9K3lIB+ZGpbn3MHE6VjdS6i6L/T4/3wyQhcyMeFBwzSXh188P57c3hPPOWgNcxfkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1l8CVPSoPtYuySsuoNrbF38h5Wv9lFll5IQCvEc/BQ=;
 b=aeho7On2SAWZzl9K8dvTGtuQ4EM+i6gRmgktYxuQc9b+tLzv1rPqqrGyMntCYqWOEYEmHa50VAjoTIwF8pa7CA60V6Kl0yKYnEC6VRxAcZCqFjwD+tCT/zPSSZq60PYrb34i6MsmA9Gw7y49Kua4qJcBu39HPqTXMR5nC6BNxlANtmm/hIXvj81h1+6mzviUk0s31v2tIr3nBBNPPU3VI2b7QWJa5igHCud1IVaexdpeAqi/CbmMDrT1tx6jWy/xEAmzCl0yBXaF8BtCf8sd5IjMj4dvPw1aLuuMkdHgRuNRK2CiffvgcuSJ2Az6X33zl70pTzOi7nnyJ+kXizypmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1l8CVPSoPtYuySsuoNrbF38h5Wv9lFll5IQCvEc/BQ=;
 b=uaqw4866KkLa4pGXFpIO06jeXwV4wBV1M1as+IA8p3+WGoQ50PfNuMKfHvAlKXzuIDXJQPbzC7C81SPSXh03lrwcxgUN5hQdc5UmKljUJv4jPo9HvqgJhyFkbA0eWyI7Jmd7j+LW703EXuKBbXuQ7gUt32OZe6q8pOPXfP/mjig=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 23:44:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 23:44:57 +0000
Message-ID: <26e49614-ddb5-4d4c-97c1-a3a8c06d5bb5@oracle.com>
Date: Mon, 20 May 2024 16:44:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: remove {Set,Clear}Hpage macros
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vishal.moola@oracle.com,
        muchun.song@linux.dev, peterx@redhat.com, osalvador@suse.de
References: <20240520224407.110062-1-sidhartha.kumar@oracle.com>
 <ZkvdAGyua4daHg_S@casper.infradead.org>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZkvdAGyua4daHg_S@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0093.namprd02.prod.outlook.com
 (2603:10b6:208:51::34) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 45222651-532b-4035-7807-08dc7926dafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WkpldEFPcHB1TU9WSVJSVnFyZ05BUHpEeERocFl4c1I4ek1OVmNNaHBRc1lx?=
 =?utf-8?B?VHBESjV0Si9ld0g2WkJXS2FPNW1lZUhzYm4xVmFNYXhMT1I3Q0l1dS9TSDhF?=
 =?utf-8?B?MTA0MmQ4VGtYNm5Oekk3OHhRVTY1SFdXekVsWGhVOHhUcFhnbEYwdzlMUkM3?=
 =?utf-8?B?YVNrRWxsT2J4RUpVWDU3U3lrWFNXRHdGS29TbWJDQnpQbU9Ha3dab1FSOWZU?=
 =?utf-8?B?ci8waFQvd2hNampld2owUE1Sb3lnci9senFCcUJUa1Z1cC84V2kybThpSkZ2?=
 =?utf-8?B?OStMVjFpUFZQZ3l6TGg5MVFhVVFjZ3NlUGFITitVZXZ4QlVLdnhYamU1UVBo?=
 =?utf-8?B?ZUtPdkhyL1V1cWN1QzFDL3hBUktoUjNaak5wclFNM3ljTnFDYVphZEhBZWxr?=
 =?utf-8?B?b2UzSzJXMUJiUjEwSVNFaUdBdThJK25ZeCsxa25PNHhsRWIzTjE0YkJmb1dq?=
 =?utf-8?B?cHUraWpkcyt3WWpKK0JtY0VpRWY0dWVvdXBrcTYxaU1FMDBEYVduWHd3LzlS?=
 =?utf-8?B?V3ZhbjRNM21oOVVEazdMb29kWEM0L2pjYjk0Z2RnRWZyM3UrVDZNRWpRVFRx?=
 =?utf-8?B?ZXY2VjFVc3FscmNVVDZxY2JTNzRQa0RZcXIxSkhpYjdkUXh0NFdONVBUeGVP?=
 =?utf-8?B?VlFCakhqYkQ4VjFRZy81ancrSGRNQUMzVmNSNStBR25kc0NjK0lodUtOMEhv?=
 =?utf-8?B?RXNsUDMvMXJhNS9yWEtDNVpSU2xzUjBDTm1MUVRXQlNrWUpzYVVFWWxYemNz?=
 =?utf-8?B?TERsdzN5SzBhSVF4Qis5NzNIVTJOeER2VVROMmFYcDdiZWxFTlBDMlNPMkpl?=
 =?utf-8?B?SGhNbGJUOFFwVG1oaGcweGpsQmJIN3NDR0k1czhIUUZsMWNwaUNRa2s0Uzk4?=
 =?utf-8?B?ZEFUdjlOOU9SOEllalR4c2FPS3dEUVh6bmpYeHVCdEFpWk1IZ0o4L082dmZ2?=
 =?utf-8?B?eHgwakEwVmJWZVRWS0l0Ymp4c213UVBtMHJjUlVTVWdQRzdwdDl3cDRFeXl3?=
 =?utf-8?B?ZGtkblRTREpMYjFha0lSN3BhaWkyUmJYeTI3Rld2QTREdXJLKzRxRGdlTnl4?=
 =?utf-8?B?YzdzTzFCTE5obDk2czJLWXlXYmpBbkNITFNNVXc4a2ZUdGRleWpNZ1RHTW1I?=
 =?utf-8?B?VWd6SCtIbGRheHRHV1VpQ0J4eHN6cnBmTlF2OWkxNTVPTld5bnpPaTJwYVpM?=
 =?utf-8?B?bnR6Y1hid2FUdVN4Y3l3Sm9WdkZpc1FCSC9TSjNvWWlpTWVDWlUzQXhlcHNq?=
 =?utf-8?B?QjRxV0tWaUE3K1h3TVMyNCtBV21FbXdoTXhTU0dCVFZ4Y0t6STcwcElOeGZJ?=
 =?utf-8?B?UnRqWmNzWEJIcisxbHVTbjlUVkM5K2RGTXNUR3prYXBGcHBtOVM3NFFtejJV?=
 =?utf-8?B?a1I4N0VEa0VVWkhpME1kanRVQXhhL1hlNWhTZXN0UjJ1WWFYOHVzV0hrZFJM?=
 =?utf-8?B?b1dGZmszUEZveTVOME13UjdmMmsrUDN0M0EvcjRDV3piK0t5Ykd6V2RrZHFI?=
 =?utf-8?B?eEh5VlZBeFVqajY1dGJrdmk3N0Q2YkF2MGhJa2d3YVNwTXR6YkdwZnN0QzVl?=
 =?utf-8?B?Rzc2TjJLYzRxUmJUMUdyaGszWEkycjNNTm5JTlVSQ1pwU1ZVNWd4eUw1RlN6?=
 =?utf-8?Q?PXiP0UqX+1dxOV0kABW8o2H92QyIj2Yc25rUcvA8L/vQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlFObkJramRpdDBPY2hmajhjQWhHemlpVTNoNkE1N2Evdmc3MzQ0cXhqQmVF?=
 =?utf-8?B?UEZaaVVEZlFkUk0vNzIwbTJWRXlXbHFXa3labDNlUXNncWw5YzR3cnJWOE5x?=
 =?utf-8?B?Tko1M1dPaVhzQlkyQlNrQ1lwRklQbVp2VFBWNExwOGhWaVdYSitUMGFLTUFR?=
 =?utf-8?B?ZDJJWGtqRzRiYTFMTUUzK2JDYnA4ZkZCZWJ1WFRmdkg2dlBodW4yOFJrRG5q?=
 =?utf-8?B?V2VtdDhxMk1laGpLMm8zUTlPRFI0WUdDT3k1TTFmL2RBek5ibXRQN2RKUzFi?=
 =?utf-8?B?cmMycnhwUjBJT3hxWG5xMTkvdmduekdwb29wdmgwQVkxUEZGY3ZjeHFJWEFD?=
 =?utf-8?B?blRpeThqYUJYUjN3Y0p0U0szMkkrdTVPUXRLNWNQakhiejFUQjhaeVVMaEgr?=
 =?utf-8?B?MVJRZldUY2RCS3lWNUw3L1dzSURVbXZ3ZjdheHVHcEZ2UmFhZjhuN3ZzRXNB?=
 =?utf-8?B?WWNZYU9wTFJuemJ6dFdsTUkyOGhaR2tCZmV6dTh3RFlvMEZOUHl0bnNsWTZz?=
 =?utf-8?B?cDJ6bWtFZk1LWmhMdnFwTElLNXFxRnJHSzFIMXlyeGp3Nk1vQUlzdkF2S3hD?=
 =?utf-8?B?bkNiT2lFUGl5dXhBb2NKZllWcEZiNXVqUmFGSUx4a25tRmNIN1dLdmlKQyt0?=
 =?utf-8?B?UEJZZWt3SUlldm0yOGd4aTBFS1hheEtOVDRLRzJsNUlKeVB1eXFOYTY2T3RG?=
 =?utf-8?B?Qnh5V1pjeTV1OXMyQm5IU1g2ZG53T2U4WWVvZlFMNVZXWTFsMmozUVo3MVRn?=
 =?utf-8?B?OCtGZzVKR3BBc2JHNXduL2xPZEpHejB0Qm1TQ0kvckR2czdsZFdMTkVMM0Y1?=
 =?utf-8?B?RkU2Sk9GVzIzU1c5YUdSOHFmRHd6eTZFemVHYWV4ZEFJRGhOKzZrdnRwQmlC?=
 =?utf-8?B?SEhaM0c2cFRHWTV1VHBxNE1lTThWV0pVRWE3R1FsdkRmYnVvR04rZXRpUEZZ?=
 =?utf-8?B?djkyZ3lSeEEzMEI3QkdqT0F6ZGJ4ZDNRdzJMMld4eTIvc0NMc2JHQ0xtbFFn?=
 =?utf-8?B?bWNjRXA3VVhYa1VOTkduM3NXQjdSZHlLUWE2SmphNlRwOXg4cmppY1BycXlh?=
 =?utf-8?B?ellzTmhwVWh5dW9BWkxHYkgyb0xwSUhEbVpEMVB6TDVkU0xmR1hidUs2dG9H?=
 =?utf-8?B?a0lLOHpSRmpKYlZZVkFwUVgreVlvVzQrVGJOUHdHYS9teFNEQTlKcEFUV2VF?=
 =?utf-8?B?NEFuTW9hTDRHbThad21ycGhZbHNFZkN4TExlTmRjWG5FdW5zbjkrYWlGdnZ2?=
 =?utf-8?B?ZXJSSS9BSk43Nk8vY1FSdkJmczNGWmIrRHdnYmk5NERTd0g5VXp6Sm5Od2VM?=
 =?utf-8?B?bDFwSUNtWkdYSXdWQnQ5NjMwbG1BMGRYcEFBNEFqS3I4OWdxUmdhd21NbTJL?=
 =?utf-8?B?TUQ5WDBlYUs5NXZaT2V0d1hONFpveE1sSUVURHJFdW1Qay83cy8wOVdZREMw?=
 =?utf-8?B?UFhBdmpERTVpWE5JWFdXMDdsWnArR01YMDMyTUJaOWlCNkhtWDAzbEFsM3da?=
 =?utf-8?B?REVOV2Zldk1sZG9xSE5NZ25QNVkzV3BsME12Q0lCcVEwR0FvTlB5UGlCS0pu?=
 =?utf-8?B?ZW9YWTNTNVdLQUNNZ0dST1FYUldyRFFqa1dYSU5pQlZkVGExSXJTRnRJSjFY?=
 =?utf-8?B?QUNPem9GQmxpa3pqV3Nmdld6SWREb0FkMUhzUkY3UzIxdUxiWnBwb0Z4UVFE?=
 =?utf-8?B?aHRaMXRhK0VTdnNobXc4VEdGOGUyV3VNWE8xeElrSUFrdE1uOW1WZDNnRERT?=
 =?utf-8?B?K244d241UU5WYXQ4anB0alpjdG5ZMDJPWW5YTDBPSjkyd2I4MlRCWmJ6aEw0?=
 =?utf-8?B?K1F2Z20wQU1Fd3E5WXZ1eGE3MTdWbnh1bnQ2RStpNU1LdDNXU3B1K0pMbzU0?=
 =?utf-8?B?S09nTFAvaXNXOGkvODhETXRsTzBzaFNlbXpCN3ovRWp3aXpiZkFZMTNwbDlj?=
 =?utf-8?B?MVRKMmZZS1FkdnkycEFDQ25zMGQ0Um1XRnJsM3Zlck90TmF0Z0wzVElaTWRy?=
 =?utf-8?B?cXZsRWQ1a2lXYWd4QWVTVU0zZUdNN1lsaW9ldDVMQU1wQVlQcWNBQnFqVE9K?=
 =?utf-8?B?cG9xVFplWVJDYTQyUksyVFFhVXc4dVdYUW1HY0pLRDhGWVpBdjdPbjdQRkpS?=
 =?utf-8?B?SmlqcVlaR1p4aGRoTm96elZBdWp6V0tDdng2VXdFalB1Z0FpWW5rM0RmZE1T?=
 =?utf-8?Q?0tS/M3QOd1TdmXbnMGRQlhE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9cbuaCN5ZLfAEV+TtPDmMBUtB+ld33WiTPw2V4FAPORpSdRya60wU5ogTK2VMdzkuKHSU8xH2YCYNusfJtpxw5B93gks+Of7lQX7+3B2a/8KlNwyleewpLI5Bt9pZfX0ckNMu9oG+3Y/jr9OiAjVREOxyHEyJ39qIX7SVP1MKVmDVD1Wl/VnemwsG1wVUPVjG6SPaJAsImwQoqaGPllbdkvrNs/dLOn44aczhfsjXcwbCqDD0SDV1XBrtMdXPlqSqb+CcTKalYufVWEO/FRdr/mTeBohAdBXTteCH9V3CjJki7fghp7xJSYdfuULds6DFfmc1d0Z/tUlg4ZwPw4N48uTVHIt02UqkEFmKqN2DOwvL5I0Hot9sVsSpZo0S5T5G4uCxdtaSRwVWrSqoVQT6QFNcQxKIUQ6JyS6+SfIM87D7n355i6qMof2zIGLckq8zeLfvoQiEpIjpYHUtOfNNNbOwIQz4+kFMOIEbprB3TAq8L8XCQ6e0C2Dgy3x9878u62aRL3kekQSzO5tmDO4Xw010zeOCZfKK+c7diZnUPKE0YREGfr6YY7DkSuN9o7+ma5/323CJHZsY9s81ep4s4K98Q91yAQAkxBRdk70Rhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45222651-532b-4035-7807-08dc7926dafb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 23:44:57.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mulgsf9vW5v5uG4NDMXH+At9lW82yZeG/LO1Ay0E7kNjQsc9tNeS+Nu7Oy0SjIbF+w6e3RO8pHPrljV4qrI1TTzfWmLgPcYO3gWt0e4td1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200189
X-Proofpoint-ORIG-GUID: jTM_tmeeaYDLaUh3UJrH0F39Rw6dNefP
X-Proofpoint-GUID: jTM_tmeeaYDLaUh3UJrH0F39Rw6dNefP

On 5/20/24 4:30 PM, Matthew Wilcox wrote:
> On Mon, May 20, 2024 at 03:44:07PM -0700, Sidhartha Kumar wrote:
>> All users have been converted to use the folio version of these macros,
>> we can safely remove the page based interface.
> 
> Yay!
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> 

There is only one remaining user of page-based Test version of these macros.

in mm/memory-hotplug.c:

		if (!PageHuge(page))
			continue;
		head = compound_head(page);
		/*
		 * This test is racy as we hold no reference or lock.  The
		 * hugetlb page could have been free'ed and head is no longer
		 * a hugetlb page before the following check.  In such unlikely
		 * cases false positives and negatives are possible.  Calling
		 * code must deal with these scenarios.
		 */
		if (HPageMigratable(head))
			goto found;
		skip = compound_nr(head) - (pfn - page_to_pfn(head));


I've previously sent a patch to convert this to folios[1] but got feedback that 
it was unsafe. But I'm not sure why replacing compound_head() with page_folio() 
and using folio_test_hugetlb_migratable(folio) rather than HPageMigratable(head) 
changes the existing behavior. With no reference or lock, can't the head pointer 
also be moved and no longer be a part of page like the comment states. So would 
the folio conversion just be maintaining this level of existing un-safety that 
the calling code should handle anyways?



[1]: 
https://lore.kernel.org/lkml/Y89DK23hYiLtgGNk@casper.infradead.org/T/#mb3a339b98386b1cd0b87f94f45163756ebd7feaa

