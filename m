Return-Path: <linux-kernel+bounces-435812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD6C9E7D6B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B5188576F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35142EEC3;
	Sat,  7 Dec 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TW99JI/N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wkVB1yPg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2AE56A
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733530673; cv=fail; b=OIZaNnlOCL4ssnsxkVyQdwO5lGTU1hNgVdBjGynausGNUcvxYwxHfZKGqcOXGoFwzS3slDaGRgcCyVN7IGTCigeBxDV/IpWv8dAVWvQ2E8Rgk65p57RAzOdV4V1EbOB6NS6XTGVeWeOz14MynoSJWbYPwkEdUxtTmeVtdA+mhbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733530673; c=relaxed/simple;
	bh=w5QxslFbaugi45G6cinlkMDr/ntqY0HxykZOR9OLGBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZ2JWw+jrzo3Ls8D4SkhdmPvfPSqth0gwhUvyo9oauQqG2pYLVWFjK7tDdJBI/3xtM6v/GeSNIxEkOom+0icR6ThiEr9dbHaQk1ZDi1xRsndz3gkvzTEbj33Gca2z5QYaKUOZIzUN6E4OPHfr6zMnwcNAn+vgHFTKXgb6BqpWvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TW99JI/N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wkVB1yPg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6NgGo6017983;
	Sat, 7 Dec 2024 00:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y3aFvgO/SuaXiMld9785bfdW/17TbDcy+SOtzHBM7f4=; b=
	TW99JI/NEQl7h8nrJQuBzN+I+d+Ozxp2SH0ofZDrKBjWs+siE15STJizh9LqM2/+
	GFUKVCkOPCVabSTgWW05MPeAkDIEH1SJW4YIaCLjmz96lfNcdpELtGVP4X1Y6aeW
	z5IOF/rk1DCkD8VgbFTRa6S9lsmDnrJAYcF0O9v05Iqe36H1Sx1tT/BznD9Uhp6P
	hmnosmJW3ll8jQKmlKrG3RIDXrwiiWttcFDPxfD6/Zjgri4N2bxTkKuXy1KGnRoc
	Qq1qqmFoFH+XbLzy/kcewvJ0tYUdLRIQxExXByQ2FwIDp6NV5DaSe6z85RTjuQwi
	XqRf2Ub/NCWqrJb6xqsRyA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk96ejm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 00:17:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6MUO6F020544;
	Sat, 7 Dec 2024 00:17:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cwntr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 00:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9u4kMSuBaw73Hjh8C5M+dga8hkBG4WEI3bYAqBAMzm4Ih81ya6Fj/Qtg5izrKTzhvepfDp2NxiqnEBHoGEZlGMSbDCAKW8wqnInsCu7TxsMEdQ2o7zj6c0y1UkYhUcmwNzjTvin0gISbZ07Dnx/Sg7aq+nqCOEXX67LK6MJAijlzMPyNkVIfeg2bLh6Zs8s/pKwzzfdtdMiUoPeLnVEzpqY8ytO6tY6JPqLQQSpHLmxajshLR+NIhuI/TIp5krSCQzEP7SWnYoJ1KxQMaPuhqDqn/KDi+zjBOBWNhAhpLITaGbhTY9ayhPBQTS7ETg++WI3mTItJGHtSpBPfPL0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3aFvgO/SuaXiMld9785bfdW/17TbDcy+SOtzHBM7f4=;
 b=c3rseno2L8CzWpr/aSS4b4T1JupeR6paN4A9T5in/MAriDh6v3phg2I3D1o4QZqPK48jKszeP0OtPaC0aSH0BBXCs9gldXgMZMgbZV8HE6R/4oGiP+96tQc0Pe9D6KMm/00g4/Qzk1UzQHekKFX6eXcuBde6yJjzEcV+whinshvsnIziC1Nqo+JvUg7qaMPH/aTZdLZRMsfbwb7swbdNCyDDPZDkxxGUOpEsfKH+Eqi1ZwI5aXfYbd6bx0e6CHa9q7g0bP+PTufrrRs5dRuiDZ5rUwUTaziuOenW/1UdG09/y7BCjE2ZQneN8fbsxrf4fkoP7I7qctjKRMLWuCHYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3aFvgO/SuaXiMld9785bfdW/17TbDcy+SOtzHBM7f4=;
 b=wkVB1yPgn74r/fgAxGnQNLr8OgENMdsTIgbXrQ9LN/YMBH/q8TXgXt6bZzPPqjZbyQ6MKL5/ZIMBNtKHKJZ5WYIahLTOYFUXwIffrcVjwWRjAx/hLJ3zAKNAQKm0MZ8lBFctsVbsVxtxvOZ1fXHtV+ff7KN2tifUM+9pAqqfrN4=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 00:17:31 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8207.017; Sat, 7 Dec 2024
 00:17:31 +0000
Message-ID: <83a8698a-fe11-42e2-8a4b-ea236721f93f@oracle.com>
Date: Fri, 6 Dec 2024 16:17:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
To: Miaohe Lin <linmiaohe@huawei.com>,
        "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>,
        'Jiaqi Yan' <jiaqiyan@google.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
 <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
 <TYCPR01MB961770DF6F58C0D8A16185F7E5292@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <098640ac-f1c1-95b6-e367-a2673c3ceaae@huawei.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <098640ac-f1c1-95b6-e367-a2673c3ceaae@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0513.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::23) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd38111-ed39-403b-cb8b-08dd165489f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGsvcTNRM1MvbFhGVnh1RnZkYmpVYkRUcExWRy9id1YrZHFwbE9WcElBVVNY?=
 =?utf-8?B?WWFraDhnK0plSGpjTEZHbUkvRC9CWjJtVjU2alkvSHduTmxDZFErb1VPbWZm?=
 =?utf-8?B?NnVJOGsxVGxrenFBRE54cmtpblkwYmk4UGhNR09oUktlUzBiQ2MwVzdrUnBs?=
 =?utf-8?B?Vy85OXczRE5ZdUZiL0JjUHE1Ym9TMmZ1RWtNcllmdHBjc29aUnVxR3Y4bk8w?=
 =?utf-8?B?N2RsbU1MTks1SnJBcmhUWmRGRHNRR2J5a3RCTWZSblRnNWFDVzJ0ZzltWlN5?=
 =?utf-8?B?RlZSQWNJYlNxTXpUaldDQ1g3NXp3WFBTd2YwNkg3TUZmTnM0NC90Mko1MW5D?=
 =?utf-8?B?TFVtR1hkQzR3RzVnVG5oaFB3WEdDSmptYStBZ2UvdEhBVzkyOFE3SFlLRnpx?=
 =?utf-8?B?cUc3Y1MyQUdLTllZVXV6TlpqQVlodDZtaCszRFhYVHBLWTJGVHFxZVpOWHRJ?=
 =?utf-8?B?MGp6aVpyYkFVQUZzS2Z2Z0ZtMkJIRlYxTkcwK3cxZnhBNjN5WXhabHN5T05B?=
 =?utf-8?B?OU5xMU9yVG5GUmRGdkpMRkkrU293MTR4akVqKzZZcWlnOTQzbFVFT2k4UVhT?=
 =?utf-8?B?Sk02TDhDRnJyQnIxOXVibkFCdk5KSTFFTjAzbXB4RVB6N2NVcVRvQjQ3bk5o?=
 =?utf-8?B?dzJmQ2J6WjJSaGQ1ODlEZDYxSVBXWnZsUG40ZHpNTmVLYkhObUlka3F0eWd1?=
 =?utf-8?B?Qm9rRG9ScjJzTW5aMTh5M1BJUnczVjRqODhoTXQwNHpKV2dNN2tXVjNXc2xy?=
 =?utf-8?B?QmZnTmdXTUE2OW9QWHFvNnJwSmcrb1lUL2FrSkptUWxjWEF5dlVEYVg5OUhw?=
 =?utf-8?B?Yk5UdXZTUXVrTDBQbkRQWUNMUDdKOGxxaTZpQ3FYUUZ0bWRZdit1R1pmSDdr?=
 =?utf-8?B?UlNQRWVpNmFWS29GLzFMSWZOK0VoMDVNNFVQUnNzSlVIeVcyWDVlWHVrcy9M?=
 =?utf-8?B?aEJkc0hTS2VPS1k4VHhyeDZwZWpwdVMxVHBqc3VwQXNjb3dSVGZ5YnVBVkFl?=
 =?utf-8?B?aXJnUTJsOEt2RmkwNjBha0RwWnFURFBDVmE4OERnMEdvTVlSenYvS3FLS0Ft?=
 =?utf-8?B?QVo3N1llUTdRME1vRlN3S3BVQ0szZEtCSHJQM2kzSXRxeFVXNzRVcmppSUx4?=
 =?utf-8?B?aUxwQW9GYjFGVWwzZ2RQTGhkVHZ1ZzBHYVJaV1FlZFFUaGcvVFpWNTJmMkFJ?=
 =?utf-8?B?eW1vU2ZkNHV3Ui9wdXY1aWdoUEpiWUdmclVBVGpMbzRIeE5hTGU4OStJbnph?=
 =?utf-8?B?Tnk4Y1NvRlV6SE5EYVcrQkdwaHU2SHJERTJSUVMxYjNOcXh2amRRa1B2RFRD?=
 =?utf-8?B?THVwMFZFaDBNUlBCbXlrcStMR25TdzhCM2YwQTl5THFJQnUxcytHVHU3OHFP?=
 =?utf-8?B?UEtBSVc0Sk9Vcy9JWnhtNDgrMXRFYjlob3hobGhWVHVPY2U5M1VTQWdEOWxI?=
 =?utf-8?B?ZFNjRWRQTUtURmdMK3dFNmY3S044QkFELy9uRnhEK09ZM0M4Uk83RzE3Z1Rz?=
 =?utf-8?B?d2NVMFJ6YTFrNEprN2ZVbm1MQUJZZWxEdmorcGV4TWpiWXdUbHQ5N0JzUVpW?=
 =?utf-8?B?TysrL1RyVHZCcmZrclRTbkhnMEtoMXlna2RlbDNoVitRU1N4dmtTWndGc0ky?=
 =?utf-8?B?WnRLWjBKSEtLZnJhU1NMbUdlbE1ORTZWYTI2QzVmcXFzYXh6UDY4bkdTZnNr?=
 =?utf-8?B?ZWhUclFjdE9zaXBoYXpDTURaKzJZNVFXdjV0ZTVqMWxuNEU0N2d1SCtROFJR?=
 =?utf-8?B?aDdBRDV0Z0RMTWRLWktzYTlIU3NybHVIaFZmbVVLUmJmZ1VadTJrNS84UmFB?=
 =?utf-8?B?KzhsYVl4Y2xjTXVEaCsrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VSVWZEeUdONDUyTldQaHgrcUpmNTRFSlJqNEQ2cjZMQW0xbVJQWEhPb3Mz?=
 =?utf-8?B?ZWtaMklvMytCeWl3Q0FTSU9BN0ZnaDFLdHE1RGVFQ25XZm13OEhoR0ZDTE5I?=
 =?utf-8?B?VUM0RjJZOUFXemEzei8wRU1qc3FlOVIzL09XZWlxSVhXZXVGN01jcm5TOEdM?=
 =?utf-8?B?MDVGemtrQXpkSzRkbis1OUxCQXArWXhMc09GQ3VZQkdzTFNMakFSSVVwZ2F6?=
 =?utf-8?B?TmJreTFYQ3BYditobDRjb1dSWGpjK283RjQwU0Jlb2dMUjZWSGp6RFpsd3BT?=
 =?utf-8?B?SEJvT1dIRDhQSjVpbGRxb0xWT3dhMVVjWkJpUHlGVjUzdnp2MXNsL2prYThC?=
 =?utf-8?B?T2ZJdU16aDJVZjlsb3lubkd0a2tUK0JleXBaUVF0YzNjbERxTGs0OS9pd2xw?=
 =?utf-8?B?eDh4SlIzcUxLYjJIa29hYldZVHVKMmVnaFZLQVkrRHRDclo2ZWRZUmhCenA4?=
 =?utf-8?B?ZkJsUU9yNzZZNU8xVXJocXpCUjkxLzRCWVpwVUd0VE9PazFkTU83MmRPVGxM?=
 =?utf-8?B?dVgvUFNRQVlzK2dhUjhMSy9CVFJEa1JEUERMRVpQb3QyaTM5Y042NHB3aTRi?=
 =?utf-8?B?aXllUGhMYlZFblc4cGFnNm5UNWs3K2NqTnRGeCt6ZktUNURDR1VQWVhuOGpI?=
 =?utf-8?B?WEpxNGpCTmRQcWlKeUlaT3BQQzNMaW9mSXdIM2VkQzBCOE12VWFLVE4yUlZF?=
 =?utf-8?B?dG0xMHlobmdzTXF5MVh5NVRZbFRZenV0Q2hEY1lualJNeTlzWXowazE5TEwz?=
 =?utf-8?B?S3pBMWZEbWZjblhCcnRzekFid0JUVEtvdTNhNTk4TWtLVTZXYkxjeFkza2E2?=
 =?utf-8?B?eEp2QUozT2w2ZktUbStnVlFaRGExY2lpb2pka3NTaGsvKy9kNklnb0dHbSt6?=
 =?utf-8?B?Nzg2aHNjN1ZsbHlIbEVDTk5xSGFTZlFkMHZlMjFFNWFSNTV4YVlTUjZiam16?=
 =?utf-8?B?Y1pUazZnRStVZVE5YUFXcjY1bnkzZTl1RjVoUFpRanMwZHJuYkNmV0pHQVlx?=
 =?utf-8?B?V1duQlFqc1UvQ2dMb1U3UTB3V0hHS2h2SGFKRkpiYnR0cDF0SGM2b0dKcS8w?=
 =?utf-8?B?NW9MMGZlVnFvMXlZdWVVSGxNRURvZVZrOHNrVjdYbnd6YzJacnFtQXZRWWVE?=
 =?utf-8?B?WjA1VjF3SmRyRmwrM3Bhc3h4S0JiMGNDU1JPMEVlM1VRdHNFOEpsNTRsYngv?=
 =?utf-8?B?Y1NBVEpFdDQzcXBWZ3RudTVWVlpPaUVpaWptSFAxUTVXSGZmNFlVVlBYZXFn?=
 =?utf-8?B?Rm1nNjc0WWROeHVRMjVqSUdXcXhSVEd6RXRDaVdKbHU0UHQxaUVKc3NSYkRy?=
 =?utf-8?B?cTk2TFprTHpLNlN0TVJpNmRlbDhMZSttdTlEWWlPY0x6V0FIaEY2YlRhRG5j?=
 =?utf-8?B?NFNsZmNVQUFvK3RmcW5GN25KVy9wNTRDQzRialZmMWhxeXRjN2k4MnNyL2Nm?=
 =?utf-8?B?dlRHQiszN3JTdWdJK3pRUnBIci9SL3luZ0tXd3h1Wk9abjhadWp5VXV5Tzls?=
 =?utf-8?B?TnhDYTlGdUx5TkNwTWh5MUFITG9kdkN2aWdqRmdtK3dRUWk3MjZ2L0p3WXNU?=
 =?utf-8?B?bWtsOHRyM1JDL0NFN21XZC9NdE13MXozcUpObTlCOXY0V1E5dVJMUTVqSWRa?=
 =?utf-8?B?Z2N4QjUvSnVvK1B5NGUvK3RkZzBNYkprOHIyb29WanRVMXVzK2tXcUViSzlk?=
 =?utf-8?B?d1A5dGRPTGVlQnNxK1NLYkZJSjlzQ3Q4M0d2MXhnT1dQRDBLVFdyUlkwanhF?=
 =?utf-8?B?MkYvckRWelhoL1pNK0JiR0d4Vjh1ZWprb2tzSjBNQWZrYlRRR2FKR2t5RzYz?=
 =?utf-8?B?MGhWQllJbHB5L1JLakpWS0U0S1dCaitVdUlRRjBvcFlYek1LNkxxZVlzY1hi?=
 =?utf-8?B?Y1YrKzNlMFl1cVdoVWtOU3lvLzI0VVhqMFV0dUJ3d3ZlSmdRc2c5VGVteGdZ?=
 =?utf-8?B?OW1lNXJ0V04yYWFkOU1jQnVESjN4cjNwRzY1eks2N1N6R2JBTThjTVpUdnZL?=
 =?utf-8?B?RmFSRlJBWjMzV1JOS1NuUUVMREFWc1k0L2MxMTFuZHhubW5nR0VsTVovMXFj?=
 =?utf-8?B?OXo5QUpxWHM0S1FTMGUwdmVWUHRmWXU2TTBJY2x3RStWUTlZbHFqRitTbERp?=
 =?utf-8?Q?ugf6S2kIGUhURcP6QeS2jIVjH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hudjRmfdhfkqWWp6mGBEq6b+PTFOKz8Hfd8Uue5mvb2ABXp8X2gL5k94vjF7jepkM5W1+8flns4EjLTHmsW/ngGznyx3pNTZd012eG6dNz44tlJltZIO5OvNfPqovjGeHhPIUoeequ+K8NKCCsnH75pdYX4kppCHA07fphbLV/vpvpO5y56t/cNZ1L6bkpDMLEeQyyFH1vi09PMotkwAZoZZbkjRVIW3958nhG+P4X6tSIwgnQ8WDTR5nIwcICFKmsHxi9upAxK2tK17yeWTzHNf3bJvRZk3BgWjQMWbDUWu/r3OL0KNweHZPC9GfUNWFzX4Fj0XI7eaIs7ioRS7MvvUKIPzHcza54195cw3kWeOxpbLn1FxnKYilqUxzgkonpEYCWANRq2Cj48myOxGkidabZmH38gZgJA7WJvToHqABvelyrGmzlNnUwnuUh+fFmIh+lXbd/TBhwlogehejqpq74TvJS8Gk6OHjnR4caYI5c/ISe6dvZDksVfMJY/Fa/TBZC/8uKDe5mJaQJbwaBU/3DNKIG9hFdnlmYWaJs8LM502xmZW7HhFovLj7gl/lFFVJYtosE8Q7k9dqYHlVp8RXfJtG6ifdDuyvfqBDkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd38111-ed39-403b-cb8b-08dd165489f0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 00:17:31.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEyGz6IyUlnOUuYjsRD0TqDDj9ZGcozWi++IhGzXCpRcjKOxvdumYNjgrD3AfpLjq3OI/n/oFT+ManPXP/5EwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_17,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=876
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412070000
X-Proofpoint-ORIG-GUID: RZYgo7fsOnnRJNh-E5Yoe3lEGzx5tYyd
X-Proofpoint-GUID: RZYgo7fsOnnRJNh-E5Yoe3lEGzx5tYyd

>>> And
>>> 1. total = recovered + ignored + failed + delayed
>>> 2. recovered = soft_offline + hard_offline
>> Do you mean mf_stats now have 7 entries in sysfs?
>> (total, ignored, failed, delayed, recovered, hard_offline, soft_offline, then recovered = hard_offline + soft_offline)
>> Or 6 entries ? (in that case, hard_offline = recovered - soft_offline)
>> It might be simpler to understand for user if total is just the sum of other entries like this RFC,
>> but I'd like to know other opinions.
> Will it be better to have below items?
> "
> total
> ignored
> failed
> dalayed
> hard_offline
> soft_offline
> "

The existing "ignored, failed, delayed, recovered" apply to UEs while 
"soft_offline" applies to CE. The difference between UE and CE is that 
even a recovered UE page has PG_hwpoison set, but a soft offlined page 
does not and thus could be re-deployed.

So if we want to flag CE pages, they seem to belong to a different 
category, something like -

/sys/devices/system/node/node0/memory_failure/Uncorrected/{ignored, delayed, failed, recovered}
/sys/devices/system/node/node0/memory_failure/Corrected/{offlined}

Thanks,

-jane

>
> though this will break the previous interface.
> Any thoughts?
>
> Thanks.
> .
>

