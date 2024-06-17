Return-Path: <linux-kernel+bounces-218339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F030990BCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A515284991
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF421990DB;
	Mon, 17 Jun 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OPgGwQZX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqZtDQZa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811C19885F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659134; cv=fail; b=DozPaiCb5U17cM8Ux5SCcBfjKLS0CRWBY4i+pOPMlro/OpVfn4LMNJvpnBrPzJ/LnN4ZC1FhtDqxM3JyfRur3+WbmqZDriTImuvXa0L3iJAIMYzaUtF8RZOMPK93mKdcLwz2pk/4y8J3t6rDEaExsiGR8LitSXPkqk23eVclnAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659134; c=relaxed/simple;
	bh=H2f1uf8o9Bh1UhznPOHeFsulEs4+4bbUbPuHWf8J0rU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEB+HEbPG1uR8SQ1ms9e+0DJDXK/Nf9hAZ61NaS+xHQhu+un6/2nYbKvNsk45tsiDM0JvrthE0N/flliBvjDo7vtJmkGERyKWvk/6+WQ+8QzykFDqZrfHqapDWFmpAi68xKq2JZOy+I683Lqo74F1JgFZN41r90zLM76JGIhxQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OPgGwQZX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqZtDQZa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HItSlK012578;
	Mon, 17 Jun 2024 21:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=R0vxwqrbJQhb+fvS/OS5jBE5EcuyZrRvS/gW5GHRbjY=; b=
	OPgGwQZXoDPmDSKBjdodbf0CfpQEBF1ycsz8l0sD1/c0UTgiYowLYluKNIcR2qtt
	vxE5D7rFWSMEykpeTWhC6TPR/L7Y2raFzZQSsvlpwWlEtMWM44Vh4NSlC6E+/fQc
	uw5tr6VB7qqP0+k66Uy4hexm2strkiLXKVThzxlhrv+xvPhGJF8hhh5HxZgbPZis
	Sw5wCNgV+526zZn6xjfLd8fB7644HpT7GO4n8x6ANJBmKfYLRjEIUpaJavgG9gpU
	uf7ZuZhImqCcTKEUHuwk9mer2NnjWKCaXgzNpPPIq2GwO0Fkfp+Bfr1n6ogQn6KU
	wdgaVoZ45isEOVU+jmswJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc3npc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 21:18:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HKoqdA034789;
	Mon, 17 Jun 2024 21:18:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d78kra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 21:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpmJWSlxUk0L3vPyzq6r4lozaaeWFAxBoMrUplP+KVc0m3aZYw6Th4BuohyrlMXfM/jU0IU+REvH3zjLUAqRXAnfU4hIH/KCCcnoon5+5UAQ2lJ+FWoicv5tWjWP/m+u8F+A0/JDzryl4dWw+SZWU/T/X7ctblXMmfNTmiyhUtUttx86wFYkw4uuq0bWR49HNNIImdtOUeQZOD5sdHppVmktgSyfwVh9y+KgsbZ4xjjvRQCGFnmd8OwoD9lbihM8oyU8GA7X3nlgPob/U/o42mnKqF/mbMM2mZbp3OS42SCFjD5doH3sW2K/D/wPuxASrzYre3M3a94rmu/Ct/bTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0vxwqrbJQhb+fvS/OS5jBE5EcuyZrRvS/gW5GHRbjY=;
 b=nacH2KHcfu+iTjEf32KcWAAUDjzSyssM7Uay/Y7geeF3CFGQGPhOA26tcucZrlldK7Jc868r3zz1rD1zcaEzxbzVcw/cN7HVnw4LIXDEmoxX2q+sv/WcrsEYwfSrweUOzk49uFy6KjlZc1cN6ObblwDyJMesPxLz8rrs9vuIBNiTL5hit+GItT2um5k3zCjluXXlF6VOAQERG1vTvIPOF2TTu71CVaK9XvSxwnWNdsUxyn2Su5gepgL0cbApVEhxrDVLZn2KqnVDPrwfc13osX4TSvV0zH7nY8T/g7RZIRqb+O3rVPOV9dsiwHnBIAm6fMngVZkGDfQdeeMVrL6S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0vxwqrbJQhb+fvS/OS5jBE5EcuyZrRvS/gW5GHRbjY=;
 b=rqZtDQZa28wySpqjCB3cbe/Y4jozNmjSz/r1dmanDC/NJXmwJnPbbECayjZfZcepUL0gwVxxsAR4dIaX1RzxTTugThkVZcFXBdTazu1hArim5oVIMT4YiavwuR/U+83Fjp83UJu3ywUqxwtDJERKrXIv83T8av7Ef/p6GZq8KB4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 21:18:28 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 21:18:28 +0000
Message-ID: <fa90c1a4-62e0-48be-91f3-1cc314af7ca4@oracle.com>
Date: Mon, 17 Jun 2024 14:18:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] maple_tree: have mas_store() allocate nodes if
 needed
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
 <20240607185257.963768-14-sidhartha.kumar@oracle.com>
 <jcp3owxbphfqmddfb45lmmbwrc6vc35onyqmcobhptsie7yot7@liqrbyliqjpr>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <jcp3owxbphfqmddfb45lmmbwrc6vc35onyqmcobhptsie7yot7@liqrbyliqjpr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dd4bcd-ff0c-4cb6-f164-08dc8f130840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YmY5ZGRKaUFnMkdPRUJOQmpHRzlQb01acHNOM05sM2c2aFlnaEszN1laWW50?=
 =?utf-8?B?aldESFc0LzBTNmc0dTQ4MFBvT0VzVmZPQ3J3Tm8yYXExYXY0aENNbzNadFNj?=
 =?utf-8?B?Q3c2L2NyMHNRdHk3RFdwUERIYXhkSVRiQk50MkRNd1oyK2JJYnZXRUIxaE1G?=
 =?utf-8?B?WDY1Y0pjMnl4aVllVUh1QzI4RWFXSDFYK0ltQ2JHYmdOSDVXbVlNWjUvTk4y?=
 =?utf-8?B?eHFZdC8yaXhqUzV5TGJKYnpzTnRVcVEvRElnWlNnNzlrU3VkWWxaZDYyaitC?=
 =?utf-8?B?ZDVJc1UyU3BRZllSZHJoZmNUNWVQeFZ1RlZ1WEZpRGZZNDQzbnRHNHk0NlF0?=
 =?utf-8?B?RHk0M3MyL25ERXJYOGJiY3hXWWFUN2I2YllKQ3lvNERkOVFXTkljazdGZ1FP?=
 =?utf-8?B?ZWM5VDlXRVpLNVZFeGZlQmFxaklmUW9PQXk4R2FzSzNrcFVBSUpNaHpOV0lt?=
 =?utf-8?B?cTE0MlNqK1hVeTNIYnpIUkg3UGM2cnFJVC9pU1Aya1A0dGhVL2hYbkxYOHE5?=
 =?utf-8?B?SGg3aDhWc2ZiMmpMQWd1L2lqSmE3UTYyZzFKYkZVNWpEYjM3TTdRM0haN3Qw?=
 =?utf-8?B?ZmRabFgvK2NVYUVZdWVuZWV0TzMyQ2V3VEhZS1ZOQU5HNUk3djVZcE8vUS9E?=
 =?utf-8?B?VjZhMFNBVzI4TDhKYUIrbTRJS3BSSkI1ZFdiMnRjUmpaazEycEFnRCtXVFlM?=
 =?utf-8?B?UmlJaGlYQXRjMzlHUUlWb2lZaGhTbXorUC9QWHhCWVBxbEtBRFJibWNCaUhv?=
 =?utf-8?B?b0xSZjNzLzZWMVhja0h4QmdoTmRjdWYzVXlvTm1GVSs4QUx4OGkzZnNRcVZE?=
 =?utf-8?B?N0IwKzFid251QkxzYXpucXpIUHRlblNsNCs4WVdpM2YvSDhWdXZRK0RlUldy?=
 =?utf-8?B?ZGd3VWw4WXJMRWtPVm1jajBZNjMrRnF6aXZFYy91d09nKzB0TmhESytINVJn?=
 =?utf-8?B?R3BYS0I5eXh3T2owUUFhWlJOZEJFTS9Eb1BmS2x5b1JmdXFpYnJjdzJNT0FC?=
 =?utf-8?B?Nk1KakUzd3M2b0NMMHdJUEZROWFNZkFXVUd4Y3EyNEhFM1pBZG81aVhYUzQz?=
 =?utf-8?B?SjhCQjhtd3RLUjcyVy9DVTkzWUdpUmx2dlJSWEgrNmRKb01Ua1BNL3lYb0hJ?=
 =?utf-8?B?aFl1VU1zNlRtNmkxQnlpem9hdlJnSThxTDhIUGtIMU1BbHRSeEJrZmlvMk5i?=
 =?utf-8?B?U2NIZ04vZE1TVW1iUW5CMW1JY1NESjRYQ1BLSEIxdDJqMExrOE9xc3RGV1VP?=
 =?utf-8?B?VGxtYVpBYmgweEdvNURWTU1Yc3gzRTdmSHUvS2FRSmZMYk82QXNyTEZza3Bk?=
 =?utf-8?B?Zi9aRmI4YkVUZnRkVmF2aURKM3pqY0p0NXQweDNrTnMwKzQwclNPZFNYdzFs?=
 =?utf-8?B?RkNxTFNFM3kxY28zdzBPOUd1b3hFUENDMHE1SkpCT3Vwc09pM3JKbnJxRzRW?=
 =?utf-8?B?WWlMbFlBTjBqZXh1VkttVllrcUNBV0FUTWUya3Q2R2U0Q011RDlSNytCbzlx?=
 =?utf-8?B?WFdWSW9kTkY4eFVCUzNwRjBGQXZ4U2FsM2FmSUJ5NFNaNHRnUVdDTmovNm9p?=
 =?utf-8?B?Q1Q5R2JHN0N5UVB0R1BNdnJaUEdOYUhKYU5UdU5YNFlwVmFSL2FZekJtNmlo?=
 =?utf-8?B?dmJRYzdGMldiY255TzBYbEIxRkJ6eGhnandGN0pwZEJiOVF3dFdJOFpleUVH?=
 =?utf-8?B?MjFJcWc1MkpScnR4RjFnZFB3YjVnNzFxRnI1Q2dQNlpvSE9kWkE4NFR5Z2VM?=
 =?utf-8?Q?z4YqdQ9+do4wqfkZ3TJcs4//BkbtzwoRdfcLZye?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmZhT29FUEJkaCtSSEdzZlBrbldaSTNVTnA4UEp5MWhuV3ZmaHFmN0gzdFAv?=
 =?utf-8?B?ZVhXRmI4bTFkcnkyVHdldTdLVW1GWjY3cE5TbURUZ2hiM1EzSzV0M1BmL2FU?=
 =?utf-8?B?YjV0YUpsaXpzQW1URUR0QzZwekpiWjdLOEpJNnhxdlp6azg1QlJOWE9NeEJU?=
 =?utf-8?B?SEEreEQzTklMSzR4ZVl2SndyeGhKWTB2UGp3WmlTNXY4RG1YSGhZdDIvT0Vq?=
 =?utf-8?B?WVZLaUxvbXU0UFFMWVVCMVNKL25Jc3h3bkc5Q1hNcU1zZWdlckttNFZXaVRK?=
 =?utf-8?B?amtUeVJ3aUZMRXBYVkhRK3JTY3ZobkVDKzh4U0ZiS3VoL0dVejVNQXBkRk53?=
 =?utf-8?B?SHozcUttNFQ2SXBwWlp2NUNFSU9UUHNMODdtNW9DY2ZsZ0Zuby82ZHJYLzFy?=
 =?utf-8?B?WWV4bmZZeHptb1dmMHhsRU8wLzV3V2hXaVgxM1lyR1ErbEpXb2IzVWsrK2pj?=
 =?utf-8?B?cDQvMTdxWHdSTkVJMjAzUmVJNmhFVUFtYkRYbG9EbVBacFphcGRXZmJHbjVL?=
 =?utf-8?B?V0lpYnlrMlVCVWFXSlhVSVVROW8vUVE0SVBWc2dOVk0vclVsSTlUTGpKQ28r?=
 =?utf-8?B?OXNLdWpGM1BjY3R3anpHSStRM3RIbDdybU5KV0dlRFpPSGgwUzNJKy9oMXNY?=
 =?utf-8?B?aE1TdWw5Nko3RUZ6R0VxUUFBT3BBT2p2Zi9xc0tINTJZQk9NYVJZaWRZRHU3?=
 =?utf-8?B?c0QxN0Y3RVVxbTBkRUNNYktpaEE5T0huK1Y3dnI2elRkZWl4QXlFMDdRei9i?=
 =?utf-8?B?emR6ZTN1cHdvZFNOaTdpMVlSWXJkb3RUd3UvcXU3ZGxQeHRVM081U2xlUE9N?=
 =?utf-8?B?S0xuTWhMUEJXZTB4U0xUNHFwdkhCd0dlcE80bWRoOTRkY0lNaEo4OE9QeDVM?=
 =?utf-8?B?UHhnaFdoSHdaMEs4elQzS2VFcTYzMVZrczVuZHkvRXlhazhOcFNMcXN5M1R4?=
 =?utf-8?B?QlczRTV6VTNvL3YyOGZTTGpUMmZ4am9wdk9wdUxEMDJ5c1dQOFVUZzdhejFo?=
 =?utf-8?B?bnYxVTcwbldHdm1Pa3dMUXgrV0d0emZNWjN5M1U4NkgwczRHTTJXeWhtMnFS?=
 =?utf-8?B?NGk1eWVBbTNwaFZ0SVlUSitucGUzQm02dkFLT25nU2hFcDhzUktScTltejdm?=
 =?utf-8?B?cW1iZnc2L3dETkdDdUcxTzM4TG1zb2s1UFUvOTBZOVcyakQ0RUhmME9aejZ2?=
 =?utf-8?B?Z0N3bzd1TW1lMUhRY0hBaitnTXFQOENpdXFKUFRaaXZGOUg4akEwWVFKOWhI?=
 =?utf-8?B?WHp0SWVzV0FzKzFOck1SdnQ5amh0OWpmY0xFOHZWS3VWbnEwaUtBS3k4RHdN?=
 =?utf-8?B?SGIzQ004QUtZbStNc0JqVXkyNnpod1BzNXZYcUpMa2RyZUJvOEpBdDc0YUJ3?=
 =?utf-8?B?RDZIbkUxZTQ0dVJURVlKOWJVZDJKbnVCMWo3QVVFN0NSbGl2bGxEdHZnMWxt?=
 =?utf-8?B?bXdyNzY3bzlzMzhhUjVzU1hkOGJaTUZiVXNSRUR6WmF2dDZWRllXR29paG4w?=
 =?utf-8?B?Y2R1RlVhd3QrbnBIdXd5YVRRUEpNejVHNWJvcXBOL3lQUnpRKzBWNFZnTzFR?=
 =?utf-8?B?NER2Rm5GR0o2RUFiSVRGcDBWL0IyUXBtVThjSzIzNzRYUWVBRCt6OHh0MnY0?=
 =?utf-8?B?YllJcEVDQVhUY05LMkpyTlhjRnc1elZmTHg1OU9aZUZFQkhzZ2dhOGRBTHFY?=
 =?utf-8?B?cE1QZFV3cHlMSVBVMDRTZ2FOU3d5dWdJQS9ZOURMSUg4aGhadlpadncrcDRJ?=
 =?utf-8?B?RC8vRHMxeGZqc250cXVDNFQ1bUZybFl5U0hjSTN6TDZBRkxFMUptVE8rWi9M?=
 =?utf-8?B?bTVySTBYOWxHblZ1VndlNHlaZmtYTHlGNGtSL3FzM1JsSzB5TC9sbTFoVGxv?=
 =?utf-8?B?V1JPbDJ4aTBJTGE5K0xleDQzUUw4OUtEUDFXbWNyK0FUc1ZLYzFpRVdueUFP?=
 =?utf-8?B?Ri9yaEVCR2lTM1gzOHI1T0tOUFBnRFNLM1pqRnB5V1NjUm9VanFUcUkzRlBK?=
 =?utf-8?B?WlFFbGVmMkx1OGdyRnEzaXIxdFpmSE16Wk5PT0lTaFdEaGwvZVpjOUx3OWN0?=
 =?utf-8?B?L0hPZjRtcGc4czB2OTV1OFNDL04yZVArVGtVYmg5MFkvaU9PWXM1MExSTWh1?=
 =?utf-8?B?aXpFU0xqUUZBWEtObGw5TzdsUFZiQVRnS29sZ2JqNjFEMXNmdld6dDJscXFr?=
 =?utf-8?Q?xgttfq08zu2jyFomQm3OhO8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f5EMKEa/F/+VW3HFv82hkkA/wX7iozAzKrRU5LTdQzSurwc6cu6coRoP8zBslGHEbjl7KTXuGNbrvfmwgtlZQRbNuey8HhDzlIDhY9nnPmTedVBhsGenP3f7/Blt3BLbOeMcJodZ9eRrKCRSTCZzD7jegA1AXZZXPMiDRQIFw8UmWB0Z5IArr2p0f4RPQH7Po1GosakVzxN6K7rsio5WVF+SP7bhU7ibLvikTERa0EMoiFdv/IfYYEYqscWCDn1jujhZJPgJxX01Nw4PDP78Uuo6zs6Cld7VlMrUMKXLXb2H6XkavmnKPXa2xnMwReDIoGWus/UvZX0kkgKn52XIrrSVqD5A3dTYaGos/kWqsBY8TyJT+22PChqThl31ie0ay84+zVFlDDPkIcx5uer75LOF2uDTYr0/nZ6mP68hfESgAqZJIjJzhK9gfA3SjTrYA+zy+VEJcB9pvsCO8bDKxD+RSnbfhfnDvZSOmmv2I4AGwnbBfdXPKXexgEe4ZLdX0x0Ebj+7WYjyosPZUvDl9ftOVc9N9BPuE+GnOpFkZqLAbvoOSF4PVqJCFLMsBFIAQ6VX00iZxXSYZYaDefzPI3KQy00fwj3zLUY+iFxSpd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dd4bcd-ff0c-4cb6-f164-08dc8f130840
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 21:18:28.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0T1mUJbXzEsvUQ2SNKQYSYnfGcabgznGvD5O5cRtGW4ZO5kP3Zcg8j8QXQyThunKQ6d8IFRGjnD7Fh1NurpDlwQ0YfY95NK6ejCPaeRBdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170165
X-Proofpoint-ORIG-GUID: 7Z94sOSIcJ3TjwRCTFT3xu9Vb4BfQq1z
X-Proofpoint-GUID: 7Z94sOSIcJ3TjwRCTFT3xu9Vb4BfQq1z

On 6/13/24 8:00 AM, Liam R. Howlett wrote:
> * Sidhartha Kumar <sidhartha.kumar@oracle.com> [240607 14:53]:
>> Not all users of mas_store() enter with nodes already preallocated.
>> Check for the MA_STATE_PREALLOC flag to decide whether to preallocate nodes
>> within mas_store() rather than relying on future write helper functions
>> to perform the allocations. This allows the write helper functions to be
>> simplified as they do not have to do checks to make sure there are
>> enough allocated nodes to perform the write.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   lib/maple_tree.c | 32 ++++++++++++++++++++++++++++----
>>   1 file changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 8b17768db5f2..92f133ea5f00 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5528,6 +5528,20 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>>   		mt_destroy_walk(enode, mt, true);
>>   	}
>>   }
>> +
>> +static inline void mas_wr_store_prealloc(struct ma_wr_state *wr_mas, void *entry)
>> +{
>> +	struct ma_state *mas = wr_mas->mas;
>> +	int request;
>> +
>> +	mas_wr_prealloc_setup(wr_mas);
>> +	mas_wr_store_type(wr_mas);
>> +	request = mas_prealloc_calc(mas, entry);
>> +	if (!request)
>> +		return;
>> +
>> +	mas_node_count(mas, request);
>> +}
>>   /* Interface */
>>   
>>   /**
>> @@ -5536,8 +5550,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>>    * @entry: The entry to store.
>>    *
>>    * The @mas->index and @mas->last is used to set the range for the @entry.
>> - * Note: The @mas should have pre-allocated entries to ensure there is memory to
>> - * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.
>>    *
>>    * Return: the first entry between mas->index and mas->last or %NULL.
>>    */
>> @@ -5563,9 +5575,21 @@ void *mas_store(struct ma_state *mas, void *entry)
>>   	 * want to examine what happens if a single store operation was to
>>   	 * overwrite multiple entries within a self-balancing B-Tree.
>>   	 */
>> -	mas_wr_prealloc_setup(&wr_mas);
>> -	mas_wr_store_type(&wr_mas);
>> +	if (mas->mas_flags & MA_STATE_PREALLOC) {
>> +		mas_wr_prealloc_setup(&wr_mas);
>> +		mas_wr_store_type(&wr_mas);
>> +		mas_wr_store_entry(&wr_mas);
>> +		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>> +		return wr_mas.content;
>> +	}
>> +
>> +	mas_wr_store_prealloc(&wr_mas, entry);
> 
> Since this is the only place mas_wr_store_prealloc() is called and the
> first two things it does is the same as the if() statement above, then
> both calls can be moved outside of the if() statement.  That also means
> the helper function is somewhat small, which makes it seem like it's
> probably not worth having?  Maybe I missed something though?
> 

I agree the helper function is not needed, I'll refactor this without using 
another function.

Thanks,
Sid

>> +	WARN_ON_ONCE(mas->store_type == wr_invalid);
>> +	if (mas_is_err(mas))
>> +		return NULL;
>> +
>>   	mas_wr_store_entry(&wr_mas);
>> +	mas_destroy(mas);
>>   	return wr_mas.content;
>>   }
>>   EXPORT_SYMBOL_GPL(mas_store);
>> -- 
>> 2.45.2
>>


