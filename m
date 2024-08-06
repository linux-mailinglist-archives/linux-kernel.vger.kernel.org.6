Return-Path: <linux-kernel+bounces-276376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E59492A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E821F21525
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6918D628;
	Tue,  6 Aug 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WveOFC3m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dDF6BHsR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C417ADE3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953335; cv=fail; b=aXvrz87gLTugi3SrQXEFwr8LcjqPZJA17FTHY47VXzd0rEWJr2aeLZpTbUNpL0lhdjFAdKJAl9MzYhy/xOPYw2RNBwYWjT6Uq4SFYVQc/nucqNH0O8d1ve3P+iKeDY0l/rnXtC6M9Yn3BlDCJCtfHKhCk1dhJ4IQx9ZRKf4D7Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953335; c=relaxed/simple;
	bh=zyMmQPwia7UxbZDyjsNXNluBcvGJpx9RI1CEmTyvQ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IR0s+fYFnCqNacBDnAOs/OSZNO9T4HLiFuZOVzRP8NnSKQRMLzTYnD5H+shG6tb1wz/EuB6t5WxJ5Je6VwO1ho8WvFGXQiroarQgb5tJIz41fZf1kOpr9289zMh6Z6fkzTZzr78i7Kqd+E3bmBtbueYJlIgEO62/0vehrf2jicQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WveOFC3m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dDF6BHsR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765kbrp031228;
	Tue, 6 Aug 2024 14:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=7TUDwlOHqCBSAeCqzg/3VIHsVBUMx40hOnJoyVlildA=; b=
	WveOFC3mCvwUvvFwE99byQxjlGHi0DlJxlAY4jnemV6iJdR50zFcorZI3L2X3RmQ
	+udp/lmtKLLBBi9mi0/KVXCRUxX9dp+IFFwEKkYU3m+YS/E5D73dtrnOeDsZOt2H
	gvKxTl+a6oC1a6apFp/2it66yXDc6cjD0mFP/HnbgAoiKalQ8/2lEFNbVmJfxsN6
	PY3EdeIsN8lLn7e4khQMdzk5h/KcqfKUTw2nSkOS+/jF1ELctUbs+768wPEkyFrD
	c+lOOF9BQ8UOsxs5zLczwmOfdlyxQ1dYMBs2roYGVg2zgTdpIV/7x+BwvYac/T66
	bR9EnxjLbUaTKZuWfWFbqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2nf00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:08:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476Ch7Rd017035;
	Tue, 6 Aug 2024 14:08:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0a0hur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRVJzq8Cp0YSNMqtNFDP95AAt01SgMjfY6VJafL5z4gwfK/xdIeyDIXhSegse/qPaKjts9rB+170W8SmkPBCLiPb9LySd0grt1oKuKwowCWGBM3CYDbpxvRi6gl//Aov3mbRwUiqSaKrdx4Z1ExHBrlVbC1fIiCZYF6F4O868AvlaX9UyhH2MbOTXYHl+sHYwwZ80H2tm9K4E3pwFf9C1zQsbtKdkTk4uq5rUL8HgkplOeLR/3JwZuhrto/r2wExiA+LTMdoGpb5KDszRY54f3oCm335xSuRsU/IaWs0VI0YfcIfBcqJKNVinZ5l9eabNO/xAQmIlwAS3/R1vO6r2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TUDwlOHqCBSAeCqzg/3VIHsVBUMx40hOnJoyVlildA=;
 b=HwxHtzpnTwYNoJC17QZE6aTXKkXyqH+hzZfQcPsWmpCX4ylslPT+Z9CX3y309AU9DUw+I7rGQMM8zlNzk9DyExZuaGe3jjR2bASgwiY1qbcLqSahV5W/KxX+Jq0nVlhOczIcJ0aeotaYKamvngtPKLJZJ1mW5JPIJMTxd8Dsms8vnaco+dkqXmLSQnCS6he8LRiYi7pFdNllvNSkqoc3xndbf48nFjBtVO/QCf30LNU6DYtFVvKJ8MYBFFZDUahDFVIFOrxHFZkSfTYsFY5XbvboX8oIVYSag6V4litUaNBF4ks0+PGLrQfsGIp2rJcojBRfnrrT5VKTR4+7e00NHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TUDwlOHqCBSAeCqzg/3VIHsVBUMx40hOnJoyVlildA=;
 b=dDF6BHsRXVz3TqmJtFsiW16nLKn2lzO7FtLQEkH4g4apXmw516Sp/HTLUG/mDn5fnLbvrWCLqWrGRfY3HIRu2D5aZnopsQJJljMSqRUekR1G4R9zL3g01g5fu5nQSPns3Or4o7DnVSUhalbCQhRMmqqV1djqp/ZYYLQkXmG91xc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 14:08:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:08:37 +0000
Date: Tue, 6 Aug 2024 15:08:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Message-ID: <599a5806-5209-4454-8d4c-60e458905f2c@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
 <20240806155555.1125554c@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806155555.1125554c@mordecai.tesarici.cz>
X-ClientProxiedBy: LO2P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::29) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f25b45-f1ec-41fa-b98d-08dcb621444b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDZLSFE0RytWVEkvODBGdnVISDV2d1puVWJTbzFxa2tuRTR6N1IyUlhmMVVx?=
 =?utf-8?B?ZW01VjZ0MHl3WkVndDFTWjkvUkVDZ1JuSWFYSE1vZ3F1WWN0OG9KV3ZVSURx?=
 =?utf-8?B?ekhuYngrblMwLzVFdFdkcWtMbU5BWEMycDUxZFM0cTIwNm5kRFpkSU5vc2xD?=
 =?utf-8?B?NjdtNzY1STE4TkMyemtkd1NHc3VMLzl6ZEFMZFk4SEF3OExzblBiNUU5YTA0?=
 =?utf-8?B?QjFQYkI2RHA1bEQ5T3pTbzErMDNyVndPcEs5ekkvcUdtdlgxNWJXLzVMTDRZ?=
 =?utf-8?B?RDJTVUNidmo0aUtVQjZ6Vk5nZFJaQndnWW9xYjBHWmMwYjdzU0xVODRnUFRX?=
 =?utf-8?B?NEpCYVVZSjVvQ1VPOVBmSGUwQ3ROWkkwdEVxWkhMNUVYaVVzdDhjSnBpWk51?=
 =?utf-8?B?WmsyYnpMUjRMVDNRN2VKRnJpd3ZHZXpFMzg2T3VadUZrRFVFQTlpb3g1VUJU?=
 =?utf-8?B?UjlWWWE3QTZBbDJmd215MzFieEg0UFhyaEw2aUJUZ1ZwYzdreHduY3p3QWxI?=
 =?utf-8?B?cWNSQ1RHRWJlYmx0ZHhGamphTEc5WnRSMFhRQTlUeDM1SXUwaW5pRzcxZGRJ?=
 =?utf-8?B?ZDA1djhiVDNBU3ZzSUdJZC9XaDJHNzNLbDdKSXA3MkgwcndvOFB2V01BL1B2?=
 =?utf-8?B?eXRtSy9oTnFMbVlVM2FvVG56MW5UN0VhNTYyZUtLR2srRWhwUnhoZGNONlpW?=
 =?utf-8?B?Vm9RNWZJVFA2MHAxd0FmdWhJc3U3UjB5cStCbVJqeEJZWVdsbjJsdGVkQ0tE?=
 =?utf-8?B?ZGdsYnYzOUZSNCtKNXdnQk5YQ1FScnBHQzZjRkZZSGR5VFpDRjFBbFdtQkRP?=
 =?utf-8?B?U0FMbytDbE1iZkZRUDhOeGEzUnhRcVlVL2tvVkp0L1lodFJ2VzN1eFVGcFM2?=
 =?utf-8?B?OGh0SE83UTJsN0U4akQ1T0Rnb1k5T2E2UlVsdExxQXdaTDlqTHhwZFIvUWVM?=
 =?utf-8?B?cnlFTk9jNjJBSnJ6K01OSnhzcngwRlhSWmJMLzdNMTVrbVE2bXZPcnhHVXlY?=
 =?utf-8?B?NzcxaE1mRTJEdmU0b1phTk1Nekp3WEtHWGg5K3RCOTFkemFERG9UQit1d05U?=
 =?utf-8?B?ZTZvTzkzbGpXbkJHdENPVk5SZVc4aUt3Q2NlVVVKZUxibWJVMmJmWEloRXVI?=
 =?utf-8?B?WHh1cVVuNVJsdmNoVXNTb1NIRW9meGRQak1SbVcrTlRSVUlsUEswWFRtanB3?=
 =?utf-8?B?OGcwV0FJQzlORHFyRlJTUzBkbkw5VzVJZmJoNjJzTHJicnNUbkN4R0M1L20w?=
 =?utf-8?B?S3kwbmpxdVc4Vjg5a0FGMnJmSVdQeE5WWUk0b1YwK2VBWWpSemR1U08rRm5l?=
 =?utf-8?B?NFRXSndPWENFQkNGeFB6ZGRpMzdQV0xyeWpoRFQweE4zRzgzUFV3cWN6OERr?=
 =?utf-8?B?azJDS1FGUWgvbFZtQWZ4bk5lVDJxRDhMTmlGMU1Edk1yY2V6YTJTNE9VcU5R?=
 =?utf-8?B?UHZ3MHBUZVI3cTNXUnd5TzMxUkpseHJYQkRsR0ZFR3EycFdPN1YwR3JFdzJo?=
 =?utf-8?B?UlFDWEt1VTBDaldLUHFvOWwrQlJvU3U0cHVGdlN1bjhTU2s1cDk4V1pOd1Ja?=
 =?utf-8?B?MTJueFhHK1ZocEg1dHl3dFM2OGdNdUFiZEcyMTBySWVFMEtYa2ZlSFIvaTFX?=
 =?utf-8?B?SS9Id09pS1c5Ykk3RVQvbkdPU1JqV3QzbWJkWHROQi9rRGFUM2c0L2VLdFJ2?=
 =?utf-8?B?aUpER24ydEIyVUt4eEk3TCtCNTNEUTNGcUdlK1JDYTZVbzBzUFhUZklCVjdS?=
 =?utf-8?B?MHZzZzVBMHU2a0FVUFVyaVY3OHNSRGxaakx5SXZLYWRsTFphUmVkeXJXMm5D?=
 =?utf-8?B?Z1paVXpiNldDUnpKRVdSdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhvZWhINmZTd2RNNjhNZzNKREVvWnArVjYxbjduSGVGOFR4MzVic3BnVzRT?=
 =?utf-8?B?VVRZSjlJYk9EQndrRXJqdnNFZFpWQWJZanZULzlwdmNDMllNZnc5RlRLTTBl?=
 =?utf-8?B?czJoeWxaaCtxU0tqVmk2S3ZzZ1B5eWs0VHFYVU4wZklJQTJRNHJvdS9KUGVX?=
 =?utf-8?B?V3paMmF5WDAzclhtUlpJNzhSWVEyK1FtQVRVNnlmb3MycHhKQ004V3RZdHU3?=
 =?utf-8?B?VS8rSXlORnlqbVR6TlN2eFVzZFNnMGJHWHRQdjR3VWpxRUxXQnE5TEpBTjNX?=
 =?utf-8?B?WVBwYW1DSTVjTG9qd254S3VYaVp5V1ZxQ0xZV205L0VOSGZ6Mit4bGJiSzBs?=
 =?utf-8?B?b0RFU1FsK1dsalBJQ0drK1Y5V1NEalVlTEpEZTM1cVpiUmUxUFVETHNXaEQv?=
 =?utf-8?B?MFhtd2l0Q05MK0xnWEkraHMwY1BGZnZRdkZxdmpDL3VIM3lDdGNKSU9lbWlm?=
 =?utf-8?B?Mk93NXBUU1pBUUdnZGVNQ1NwbzFuQXp2YXlnVHBkR1ZuK2pHNEw0anFGRDM2?=
 =?utf-8?B?R0VCdFJBd2pLY3BDODZ2V0l4S0tRQktGb25JNlJJVWprTGwvRjBmNXpaUU1O?=
 =?utf-8?B?NTdINk51OG1HV3BzY29IN0FWclNPQkNwd3JHVVpNS0VveEZmVUUxZ1h4TTl5?=
 =?utf-8?B?enAybU9aV0FHOXRJeUlrL1VwRHJJOUlpbkxHZmM3bWM3ZXY2VEg3dldhdndy?=
 =?utf-8?B?RTFjd3JucXNTTmRJUGdhRThPdnFNbHdmcGpkWnFVSWZSN2dhanVMWWxJcjlS?=
 =?utf-8?B?Q3RiZDZwRFUwdVd5ZktQZTl4ZFJJYWZrb3VuVTZYa3EyWkZKalJPUGkrVGMv?=
 =?utf-8?B?K2Z2VWZvNnR4eFdib242K0VaZlNndk41eGNkUkE2VmZFUnh3VW5SbjdSakVl?=
 =?utf-8?B?aFR5ZVJITUZub3RiWWFpM3R0ZTh1WXVHOEJuMVNEcDdCSFhxakVCc1JZOVBV?=
 =?utf-8?B?ZE1kSHZnNEREVThrNU9GeC9wQ1ZCNWQvVnBhNks0SU5jQ0YvYXFJdHFLeTh3?=
 =?utf-8?B?MzQ4aGcrOVdvVkJ3SHUvc0hwaUhqSDllelpiNDM2RUdMVkowVTdCUmwrdHIr?=
 =?utf-8?B?OHVEQVRCaW1Kc2JWa2IxaUVDN3lMOFRtQUhEL1VvdDVrZm9pcStOd3ZJaTdn?=
 =?utf-8?B?ck5DazUyNGhUcytUTzBUZ0hCekFkdUNiY3FwVTRKc2I1RGg3T0crUGtyQlJn?=
 =?utf-8?B?MkRwaEF0SXFVaFpmNFc5LzB5cFpCWW9HVk93RU5pRjFLN2I5aERJT01VQlpa?=
 =?utf-8?B?Q2w4SHlRcXdVZVBERWxLbzNLUWhlQzExbklhck5mT0tnclhlUGQ1V1l5NTly?=
 =?utf-8?B?b1cxVTFNejdpY09xM1cwQXJmZTdtaitQbTBjbU93V2NubnYrUkJWU1FaZDlT?=
 =?utf-8?B?SjdrN2c5ak80N09lZlFTLzdyUzFDd2pnSWVzcjhlSU9La1RnckRaZHN2WEJt?=
 =?utf-8?B?Nk9hWmtxQ25ONHdDSTJmK1NibzY2a3d4WGJFNkdRbVZxOHZWUVRsN3c2WnNC?=
 =?utf-8?B?NUUxTTlOaWpIWmI3Z0dmM1c5VWt1NHhaMlBBdmVENUwvVnE3a2ZnWWhHUkh3?=
 =?utf-8?B?RVd6U0xEVTVEOHBvZWo1Y2VyMXNhbGlrbFlRR01qODlGMDZpL3VOcnM5bmpP?=
 =?utf-8?B?REhzVzdKaDJ2em1uRXh0cXR3K3RpNTJGM0hNckxoQUR5a3lrZFVxOFJ4VnA5?=
 =?utf-8?B?NGpadkJxemI4RkxsUzVvOU5VeTliN1oycTNhUTdZcVo3SXlraFZFUnVXZVdF?=
 =?utf-8?B?LzdYaVI1MXBpQzlKLzcwbXh1RXJZektzNG84WUpPZFNyV1ZSTDMydVpWVTFP?=
 =?utf-8?B?Z0toZEcrNzRTNHB1ODdua1hYUFNrbWxweVdnK0FhblU0d0ZuZURtVWZyU0ln?=
 =?utf-8?B?d08xTXVHYzJOK0I3K0U0TDhsNkNqVXNTSUtvQWZ3S0s3VE0xVC90b3E3UW5Z?=
 =?utf-8?B?YUpQejZ5T3JTMkV2VWVCY3NlMHdJQ2k2WktReXFxU0FhcWVWcHlvUmYybFNP?=
 =?utf-8?B?dyt0M0xQTTdUTVAyWkdCWm45bkJVUGxXTG81eTNqU1cvdmxQQ2ZRR1V4V0Rw?=
 =?utf-8?B?THNua0w0MUNnb0pqdHB3S1pNT0pLTXRnSzdEZ1VucFlHWGtqWjIwZmM3SlBO?=
 =?utf-8?B?VUlQNjdIVFpsemR3YVZ2V3dKTmR4dkVBMnByYy9ocXAySlVNWFdPaW0xcWtz?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5j2gI5NwnpPS0bZUVfQwfKoybwJS87lYmkYKWaiFxd4MwWEUOj/8pnQKsKvKz0oyeWAijzuNN5+h1GTtmsVegtbgVu9coVUi8+y/iIegVlITgDdNUR7CE1CSrCr+hgMhEOidxzLT8DiG4TKZ90t94sNUWEqOir0zuJ0CXEuyzFJ2WvtPofodHOFrYyjxrEY0PX8nofdmgnQTZYxTg14ses9pESdj3zS8XCGUcDaO833dvy/DtbS/ry72g7XFPFtqzaBzpwuyk7vX8AwJEoegWyK07k/aSywt/ASPCvgyXCK6/by6yQEdLsWSrJOUwTsW7msKP032K8vZwfgjXXAcTnlGKwWR2wZ7XT2Wn2xhvKArYVZT6ZAsfa32swxfB7P+1EEni+jVPI92KK7HMn6O4+ZyGD8n6usPQdhPWKm6umvGvh8/gmPxVvYTvs0sl8TRyA4eM56/GQApjP39dp9KqoRrIeJAb+majU9V2hPEtWpuZWRKRiCuEp/Cq7IjQkXXzRDonALikAeVsOxOEwGzd0obKEVyOZ3ytahi2CQ628yRvdSVdxHH0r+O5GXqAT8eO9/wesqIoIBcK9ShE/eNa2YDsvO7C57t3E75hlnjwdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f25b45-f1ec-41fa-b98d-08dcb621444b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:08:37.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tHIiH5Vyc0sfg6Xa/Fy5OMZbthPQGzE3b/dhJBULks4cKUrK76R0HVsoZS7ZDXLNzX+KlUv2wo9K4H/uwbk1hkZluLgDmQlpjc5Ha4TFzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060098
X-Proofpoint-GUID: zcNXenX2bUwJG5oPdnb8rHbmOdEJpr5g
X-Proofpoint-ORIG-GUID: zcNXenX2bUwJG5oPdnb8rHbmOdEJpr5g

On Tue, Aug 06, 2024 at 03:55:55PM GMT, Petr Tesařík wrote:
> On Mon,  5 Aug 2024 13:13:57 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
> > removed in mergeability test") we relaxed the VMA merge rules for VMAs
> > possessing a vm_ops->close() hook, permitting this operation in instances
> > where we wouldn't delete the VMA as part of the merge operation.
> >
> > This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
> > case 7 with vma_ops->close") to account for a subtle case that the previous
> > commit had not taken into account.
> >
> > In both instances, we first rely on is_mergeable_vma() to determine whether
> > we might be dealing with a VMA that might be removed, taking advantage of
> > the fact that a 'previous' VMA will never be deleted, only VMAs that follow
> > it.
> >
> > The second patch corrects the instance where a merge of the previous VMA
> > into a subsequent one did not correctly check whether the subsequent VMA
> > had a vm_ops->close() handler.
> >
> > Both changes prevent merge cases that are actually permissible (for
> > instance a merge of a VMA into a following VMA with a vm_ops->close(), but
> > with no previous VMA, which would result in the next VMA being extended,
> > not deleted).
> >
> > In addition, both changes fail to consider the case where a VMA that would
> > otherwise be merged with the previous and next VMA might have
> > vm_ops->close(), on the assumption that for this to be the case, all three
> > would have to have the same vma->vm_file to be mergeable and thus the same
> > vm_ops.
> >
> > And in addition both changes operate at 50,000 feet, trying to guess
> > whether a VMA will be deleted.
> >
> > As we have majorly refactored the VMA merge operation and de-duplicated
> > code to the point where we know precisely where deletions will occur, this
> > patch removes the aforementioned checks altogether and instead explicitly
> > checks whether a VMA will be deleted.
> >
> > In cases where a reduced merge is still possible (where we merge both
> > previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
> > could just merge the previous and current VMA), we do so, otherwise the
> > merge is not permitted.
> >
> > We take advantage of our userland testing to assert that this functions
> > correctly - replacing the previous limited vm_ops->close() tests with tests
> > for every single case where we delete a VMA.
> >
> > We also update all testing for both new and modified VMAs to set
> > vma->vm_ops->close() in every single instance where this would not prevent
> > the merge, to assert that we never do so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c                |  69 ++++++++-----
> >  tools/testing/vma/vma.c | 213 ++++++++++++++++++++++++----------------
> >  2 files changed, 173 insertions(+), 109 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index c55ae035f5d6..9c779fc65ba8 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -10,14 +10,6 @@
> >  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> >  {
> >  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > -	/*
> > -	 * If the vma has a ->close operation then the driver probably needs to
> > -	 * release per-vma resources, so we don't attempt to merge those if the
> > -	 * caller indicates the current vma may be removed as part of the merge,
> > -	 * which is the case if we are attempting to merge the next VMA into
> > -	 * this one.
> > -	 */
> > -	bool may_remove_vma = merge_next;
>
> See my comment on PATCH 02/10. You're removing the local variable here,
> so maybe it need not be introduced in the first place?
>
> >  	if (!mpol_equal(vmg->policy, vma_policy(vma)))
> >  		return false;
> > @@ -33,8 +25,6 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
> >  		return false;
> >  	if (vma->vm_file != vmg->file)
> >  		return false;
> > -	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
> > -		return false;
> >  	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
> >  		return false;
> >  	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> > @@ -606,6 +596,12 @@ static int commit_merge(struct vma_merge_struct *vmg,
> >  	return 0;
> >  }
> >
> > +/* We can only remove VMAs when merging if they do not have a close hook. */
> > +static bool can_merge_remove_vma(struct vm_area_struct *vma)
> > +{
> > +	return !vma->vm_ops || !vma->vm_ops->close;
> > +}
> > +
> >  /*
> >   * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
> >   * attributes modified.
> > @@ -710,9 +706,30 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> >
> >  	/* If we span the entire VMA, a merge implies it will be deleted. */
> >  	merge_will_delete_vma = left_side && right_side;
> > -	/* If we merge both VMAs, then next is also deleted. */
> > +
> > +	/*
> > +	 * If we need to remove vma in its entirety but are unable to do so,
> > +	 * we have no sensible recourse but to abort the merge.
> > +	 */
> > +	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
> > +		return NULL;
> > +
> > +	/*
> > +	 * If we merge both VMAs, then next is also deleted. This implies
> > +	 * merge_will_delete_vma also.
> > +	 */
> >  	merge_will_delete_next = merge_both;
> >
> > +	/*
> > +	 * If we cannot delete next, then we can reduce the operation to merging
> > +	 * prev and vma (thereby deleting vma).
> > +	 */
> > +	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
> > +		merge_will_delete_next = false;
> > +		merge_right = false;
> > +		merge_both = false;
> > +	}
> > +
> >  	/* No matter what happens, we will be adjusting vma. */
> >  	vma_start_write(vma);
> >
> > @@ -756,21 +773,12 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> >  		vmg->start = prev->vm_start;
> >  		vmg->pgoff = prev->vm_pgoff;
> >
> > -		if (merge_will_delete_vma) {
> > -			/*
> > -			 * can_vma_merge_after() assumed we would not be
> > -			 * removing vma, so it skipped the check for
> > -			 * vm_ops->close, but we are removing vma.
> > -			 */
> > -			if (vma->vm_ops && vma->vm_ops->close)
> > -				err = -EINVAL;
> > -		} else {
> > +		if (!merge_will_delete_vma) {
> >  			adjust = vma;
> >  			adj_start = end - vma->vm_start;
> >  		}
> >
> > -		if (!err)
> > -			err = dup_anon_vma(prev, vma, &anon_dup);
> > +		err = dup_anon_vma(prev, vma, &anon_dup);
> >  	} else { /* merge_right */
> >  		/*
> >  		 *     |<----->| OR
> > @@ -886,6 +894,8 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> >  	unsigned long end = vmg->end;
> >  	pgoff_t pgoff = vmg->pgoff;
> >  	pgoff_t pglen = PHYS_PFN(end - start);
> > +	bool merge_next = false;
> > +	struct anon_vma *anon_vma = vmg->anon_vma;
>
> Calling this "anon_vma" feels a bit too generic. IIUC you want to save
> the original vmg->anon_vma in case the VMA turns out to be ummergeable
> with the next VMA after vmg->anon_vma has already been modified.
>
> What about calling it "orig_anon_vma"?

I disagree, that'd be unnecessary noise (and this is applicable to _all_
the fields).

Again we come to some trade-off between readability and inherent
complexity. I am not a fan of making variable names unnecessarily
overwrought.

In this case it's just a short-hand, as the only instance where we'd retry
the operation anon_vma would be NULL (from mmap_region()), so we reset that
to NULL, however strictly we should reset to anon_vma.

I'll change that on the next respin just to be strict.

>
> Petr T
>
> >
> >  	VM_WARN_ON(vmg->vma);
> >
> > @@ -916,8 +926,9 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> >  		vmg->end = next->vm_end;
> >  		vmg->vma = next;
> >  		vmg->pgoff = next->vm_pgoff - pglen;
> > -
> >  		vmg->anon_vma = next->anon_vma;
> > +
> > +		merge_next = true;
> >  	}
> >
> >  	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > @@ -925,6 +936,16 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> >  		vmg->start = prev->vm_start;
> >  		vmg->vma = prev;
> >  		vmg->pgoff = prev->vm_pgoff;
> > +
> > +		/*
> > +		 * If this merge would result in removal of the next VMA but we
> > +		 * are not permitted to do so, reduce the operation to merging
> > +		 * prev and vma.
> > +		 */
> > +		if (merge_next && !can_merge_remove_vma(next)) {
> > +			vmg->end = end;
> > +			vmg->anon_vma = anon_vma;
> > +		}
> >  	} else if (prev) {
> >  		vma_iter_next_range(vmg->vmi);
> >  	}
> > @@ -978,6 +999,8 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  		int ret;
> >
> >  		remove_next = true;
> > +		/* This should already have been checked by this point. */
> > +		VM_WARN_ON(!can_merge_remove_vma(next));
> >  		vma_start_write(next);
> >  		ret = dup_anon_vma(vma, next, &anon_dup);
> >  		if (ret)
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index e465dc22e2d0..0c0a6ffcfc98 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
> > @@ -327,6 +327,9 @@ static bool test_vma_merge_new_vma(void)
> >  	struct anon_vma_chain dummy_anon_vma_chain_d = {
> >  		.anon_vma = &dummy_anon_vma,
> >  	};
> > +	const struct vm_operations_struct vm_ops = {
> > +		.close = dummy_close,
> > +	};
> >  	int count;
> >  	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
> >  	bool merged;
> > @@ -370,6 +373,7 @@ static bool test_vma_merge_new_vma(void)
> >  	 * 0123456789abc
> >  	 * AA*B   DD  CC
> >  	 */
> > +	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vma_b->anon_vma = &dummy_anon_vma;
> >  	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
> >  	ASSERT_EQ(vma, vma_a);
> > @@ -406,6 +410,7 @@ static bool test_vma_merge_new_vma(void)
> >  	 * AAAAA *DD  CC
> >  	 */
> >  	vma_d->anon_vma = &dummy_anon_vma;
> > +	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
> >  	ASSERT_EQ(vma, vma_d);
> >  	/* Prepend. */
> > @@ -423,6 +428,7 @@ static bool test_vma_merge_new_vma(void)
> >  	 * 0123456789abc
> >  	 * AAAAA*DDD  CC
> >  	 */
> > +	vma_d->vm_ops = NULL; /* This would otherwise degrade the merge. */
> >  	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
> >  	ASSERT_EQ(vma, vma_a);
> >  	/* Merge with A, delete D. */
> > @@ -573,120 +579,145 @@ static bool test_vma_merge_with_close(void)
> >  	struct vma_merge_struct vmg = {
> >  		.vmi = &vmi,
> >  	};
> > -	struct vm_operations_struct vm_ops = {};
> > -	struct vm_area_struct *vma_next =
> > -		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
> > -	struct vm_area_struct *vma;
> > +	const struct vm_operations_struct vm_ops = {
> > +		.close = dummy_close,
> > +	};
> > +	struct vm_area_struct *vma_prev, *vma_next, *vma;
> >
> >  	/*
> > -	 * When we merge VMAs we sometimes have to delete others as part of the
> > -	 * operation.
> > -	 *
> > -	 * Considering the two possible adjacent VMAs to which a VMA can be
> > -	 * merged:
> > -	 *
> > -	 * [ prev ][ vma ][ next ]
> > -	 *
> > -	 * In no case will we need to delete prev. If the operation is
> > -	 * mergeable, then prev will be extended with one or both of vma and
> > -	 * next deleted.
> > -	 *
> > -	 * As a result, during initial mergeability checks, only
> > -	 * can_vma_merge_before() (which implies the VMA being merged with is
> > -	 * 'next' as shown above) bothers to check to see whether the next VMA
> > -	 * has a vm_ops->close() callback that will need to be called when
> > -	 * removed.
> > -	 *
> > -	 * If it does, then we cannot merge as the resources that the close()
> > -	 * operation potentially clears down are tied only to the existing VMA
> > -	 * range and we have no way of extending those to the nearly merged one.
> > -	 *
> > -	 * We must consider two scenarios:
> > -	 *
> > -	 * A.
> > +	 * When merging VMAs we are not permitted to remove any VMA that has a
> > +	 * vm_ops->close() hook.
> >  	 *
> > -	 * vm_ops->close:     -       -    !NULL
> > -	 *                 [ prev ][ vma ][ next ]
> > -	 *
> > -	 * Where prev may or may not be present/mergeable.
> > -	 *
> > -	 * This is picked up by a specific check in can_vma_merge_before().
> > -	 *
> > -	 * B.
> > -	 *
> > -	 * vm_ops->close:     -     !NULL
> > -	 *                 [ prev ][ vma ]
> > -	 *
> > -	 * Where prev and vma are present and mergeable.
> > -	 *
> > -	 * This is picked up by a specific check in vma_merge_modified().
> > -	 *
> > -	 * IMPORTANT NOTE: We make the assumption that the following case:
> > +	 * This is because executing this hook may clear state that is pertinent
> > +	 * to the VMA range as a whole.
> > +	 */
> > +
> > +	/*
> > +	 * The only case of a new VMA merge that results in a VMA being deleted
> > +	 * is one where both the previous and next VMAs are merged - in this
> > +	 * instance the next VMA is deleted, and the previous VMA is extended.
> >  	 *
> > -	 *    -     !NULL   NULL
> > -	 * [ prev ][ vma ][ next ]
> > +	 * If we are unable to do so, we reduce the operation to simply
> > +	 * extending the prev VMA and not merging next.
> >  	 *
> > -	 * Cannot occur, because vma->vm_ops being the same implies the same
> > -	 * vma->vm_file, and therefore this would mean that next->vm_ops->close
> > -	 * would be set too, and thus scenario A would pick this up.
> > +	 * 0123456789
> > +	 * PPP**NNNN
> > +	 *             ->
> > +	 * 0123456789
> > +	 * PPPPPPNNN
> >  	 */
> >
> > -	ASSERT_NE(vma_next, NULL);
> > +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> > +	vma_next->vm_ops = &vm_ops;
> > +
> > +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> > +	ASSERT_EQ(vma_merge_new_vma(&vmg), vma_prev);
> > +	ASSERT_EQ(vma_prev->vm_start, 0);
> > +	ASSERT_EQ(vma_prev->vm_end, 0x5000);
> > +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> > +
> > +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> >
> >  	/*
> > -	 * SCENARIO A
> > +	 * When modifying an existing VMA there are further cases where we
> > +	 * delete VMAs.
> > +	 *
> > +	 *    <>
> > +	 * 0123456789
> > +	 * PPPVV
> >  	 *
> > -	 * 0123
> > -	 *  *N
> > +	 * In this instance, if vma has a close hook, the merge simply cannot
> > +	 * proceed.
> >  	 */
> >
> > -	/* Make the next VMA have a close() callback. */
> > -	vm_ops.close = dummy_close;
> > -	vma_next->vm_ops = (const struct vm_operations_struct *)&vm_ops;
> > +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> > +	vma->vm_ops = &vm_ops;
> >
> > -	/* Our proposed VMA has characteristics that would otherwise be merged. */
> > -	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> > +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> > +	vmg.prev = vma_prev;
> > +	vmg.vma = vma;
> >
> > -	/* The next VMA having a close() operator should cause the merge to fail.*/
> > -	ASSERT_EQ(vma_merge_new_vma(&vmg), NULL);
> > +	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> >
> > -	/* Now create the VMA so we can merge via modified flags */
> > -	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> > -	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
> > -	vmg.vma = vma;
> > +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> >
> >  	/*
> > -	 * The VMA being modified in a way that would otherwise merge should
> > -	 * also fail.
> > +	 * This case is mirrored if merging with next.
> > +	 *
> > +	 *    <>
> > +	 * 0123456789
> > +	 *    VVNNNN
> > +	 *
> > +	 * In this instance, if vma has a close hook, the merge simply cannot
> > +	 * proceed.
> >  	 */
> > +
> > +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> > +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> > +	vma->vm_ops = &vm_ops;
> > +
> > +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> > +	vmg.vma = vma;
> > +
> >  	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> >
> > -	/* SCENARIO B
> > +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> > +
> > +	/*
> > +	 * Finally, we consider two variants of the case where we modify a VMA
> > +	 * to merge with both the previous and next VMAs.
> >  	 *
> > -	 * 0123
> > -	 * P*
> > +	 * The first variant is where vma has a close hook. In this instance, no
> > +	 * merge can proceed.
> >  	 *
> > -	 * In order for this scenario to trigger, the VMA currently being
> > -	 * modified must also have a .close().
> > +	 *    <>
> > +	 * 0123456789
> > +	 * PPPVVNNNN
> >  	 */
> >
> > -	/* Reset VMG state. */
> > -	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> > +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> > +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> > +	vma->vm_ops = &vm_ops;
> > +
> > +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> > +	vmg.prev = vma_prev;
> > +	vmg.vma = vma;
> > +
> > +	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> > +
> > +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
> > +
> >  	/*
> > -	 * Make next unmergeable, and don't let the scenario A check pick this
> > -	 * up, we want to reproduce scenario B only.
> > +	 * The second variant is where next has a close hook. In this instance,
> > +	 * we reduce the operation to a merge between prev and vma.
> > +	 *
> > +	 *    <>
> > +	 * 0123456789
> > +	 * PPPVVNNNN
> > +	 *            ->
> > +	 * 0123456789
> > +	 * PPPPPNNNN
> >  	 */
> > -	vma_next->vm_ops = NULL;
> > -	vma_next->__vm_flags &= ~VM_MAYWRITE;
> > -	/* Allocate prev. */
> > -	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
> > -	/* Assign a vm_ops->close() function to VMA explicitly. */
> > -	vma->vm_ops = (const struct vm_operations_struct *)&vm_ops;
> > +
> > +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> > +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> > +	vma_next->vm_ops = &vm_ops;
> > +
> > +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> > +	vmg.prev = vma_prev;
> >  	vmg.vma = vma;
> > -	/* Make sure merge does not occur. */
> > -	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> >
> > -	cleanup_mm(&mm, &vmi);
> > +	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
> > +	ASSERT_EQ(vma_prev->vm_start, 0);
> > +	ASSERT_EQ(vma_prev->vm_end, 0x5000);
> > +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> > +
> > +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> > +
> >  	return true;
> >  }
> >
> > @@ -699,6 +730,9 @@ static bool test_vma_merge_modified(void)
> >  	struct vma_merge_struct vmg = {
> >  		.vmi = &vmi,
> >  	};
> > +	const struct vm_operations_struct vm_ops = {
> > +		.close = dummy_close,
> > +	};
> >
> >  	/*
> >  	 * Merge right case - partial span.
> > @@ -711,7 +745,9 @@ static bool test_vma_merge_modified(void)
> >  	 *   VNNNNNN
> >  	 */
> >  	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
> > +	vma->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
> > +	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
> >  	vmg.vma = vma;
> >  	vmg.prev = vma;
> > @@ -743,6 +779,7 @@ static bool test_vma_merge_modified(void)
> >  	 */
> >  	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
> >  	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
> > +	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
> >  	vmg.vma = vma;
> >  	vma->anon_vma = &dummy_anon_vma;
> > @@ -768,7 +805,9 @@ static bool test_vma_merge_modified(void)
> >  	 * PPPPPPV
> >  	 */
> >  	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> > +	vma->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
> >  	vmg.prev = vma_prev;
> >  	vmg.vma = vma;
> > @@ -800,6 +839,7 @@ static bool test_vma_merge_modified(void)
> >  	 * PPPPPPP
> >  	 */
> >  	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> >  	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> >  	vmg.prev = vma_prev;
> > @@ -827,6 +867,7 @@ static bool test_vma_merge_modified(void)
> >  	 * PPPPPPPPPP
> >  	 */
> >  	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> > +	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
> >  	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> >  	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
> >  	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> > --
> > 2.45.2
> >
>
>

