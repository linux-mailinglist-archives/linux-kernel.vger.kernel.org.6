Return-Path: <linux-kernel+bounces-531857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0613A445FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D67B3AD0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C818CC13;
	Tue, 25 Feb 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6mBFMZw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mv7QKZa3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F11917C2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500547; cv=fail; b=FbX8QIOy2DHsHKIe73/EnF7psE2vKXrA8JYEvZaLDy26sXB2dQc4B7aAhp8ZguK3d/yQI8RvylIpKLda4+iAKeVl8uBY1Kk6eNOMPdQIlYi4N7MAZeAwoS/m/04bA1qbqGMusm+HITAQbdhFzhxCgn4Nbf13xVzRPxu39QmtpCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500547; c=relaxed/simple;
	bh=aJvK7RQY/FQRKKPp7GMjT88kj5FBWqcu+mB8u8s31e8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQJ7aGheiNymxx7cFbVhrBcymQUK7voHufzmAyrjxe3Eu8FL6cIjX0KSOaWsnDtGwwlCxCrNlnGHf1iHSCYMy1zYkmRnbLk6hRRfC4aprjCGRFwrTunpbyoBHLq8PPqtooZgWM1AaItkTfz3KcU9pqO4xJ0M4klNU9WrCWYvZpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y6mBFMZw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mv7QKZa3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMjbk028812;
	Tue, 25 Feb 2025 16:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2OWZvNDMzAK6jlKywYeTGiKQ3MftDqZ5378rTAT9iJ8=; b=
	Y6mBFMZwChlIa/AYaG7JSjQS/qb2K079jOM5faJjPFTqOkZZ02FOBSXvSK632pc9
	ZrgioPsNEm/OAQnh1OD2sz0Npf7NNcxTkBfzFFISWgUf4zHHfzStTSy807UQb0D7
	c/LKkww8NqQt36ln4fkL7C2OKxFN0wfUmswjwmG2WufubVmHngmA8ULijfXjVeUw
	lWoMZ2HrUX8RYFtfKQVObLHloJ0aKEHQKv15WfWKfZBs9rxOYJDo9dY+WiGBJ+J8
	0rby7FK95ZaSiSCMYEVLV9Lm+cxOsomfM3M8erFsRAe236HIWy5jRDYUxAqCFPZz
	oH/Kbjf0slmniZFa8fWfLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t5nfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:22:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFsvqf008188;
	Tue, 25 Feb 2025 16:22:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ffw2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+PibREVVBrY2yut5VRJX4CZgpCMPgnVHYEmMgQ3ZTsqjE6aW+DioBfddAkFZtq06y58Pmyl0A4uSY5HhEH5XjJKhvo/NaliYIiP0YBl/6znR+nUwiF4W+KnMa4V3YvSi757lPCdBbUPDj9RGiJNW90yPqkUacDcC/jM2njBOsz7plWLiVc7rkTaJWyQ/CEwltoovXqEjGGeitPIIWdNGIxHm742VbBXuaF+54kPyR2AQ6k3c3hBwx1/Wq6KOJLqjIHQLvDL9TVqwMztNmJHUkC0oeEaQA1AmR0GN0T1EhS2V8odvGlrCqEnaA4N3zWlKmUq1qSiTsw/ujTDAOjAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OWZvNDMzAK6jlKywYeTGiKQ3MftDqZ5378rTAT9iJ8=;
 b=UI/xzj07saBc2zuTAOfBBUt/ldBlfB4oSA2129AZ0/sWMCtbpaFxii/psg9f3c8yWKjovyiJlxBfkSDoV0ycLNTxkMoTmRZlb+2C+G/Br31HUV2LqI/AMB+zMYU4ZmWGGuC4IOgbGYFy2OqnRhKBiw9xmAxpUiL6JhT/kMiPHj4cJeFpHaA0wW3DzlZy8h+k5/alXDO2tPIWKvW0Cdtr3oWoZbCr8Gpir8mt+3KBnptC/MsEf5JJaBiSSWb8/NVOqDyexpup5IuUYCUJRuSyBm5jYTdEqc0ei15olsEPi+b9+BGnG6VguvsnW2nGuCcqEjwQY+90vJh8XcImturmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OWZvNDMzAK6jlKywYeTGiKQ3MftDqZ5378rTAT9iJ8=;
 b=Mv7QKZa3g2BGEsNLPi4T8sNFZs1EU3QLsBZ9zWGntUTYFvg/WojR2qcOU56Imk5GqUaH3826SwpT3YW2Y6O3FmtnrsUeb9EvKA035DaURtROJnyPXRba+2mJLboOJsgdaUG1jYloQcZGABWLOsP5Amv/uM/BbDZDbk1sizPhCOY=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS0PR10MB8006.namprd10.prod.outlook.com (2603:10b6:8:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 16:22:12 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:22:12 +0000
Message-ID: <c43bfd29-8dfb-4751-86d2-9eb31955d693@oracle.com>
Date: Tue, 25 Feb 2025 11:22:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] maple_tree: use vacant nodes to reduce worst case
 allocations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-4-sidhartha.kumar@oracle.com>
 <sjugioveqmkfqwnse5j6tnnlcz6qk5sfvcqf4isqozu3hn4vc7@2ldyqovzngwo>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <sjugioveqmkfqwnse5j6tnnlcz6qk5sfvcqf4isqozu3hn4vc7@2ldyqovzngwo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:208:234::15) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS0PR10MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a35ebf2-8b3e-476c-7177-08dd55b88f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TThFNUNxbXV1U2tFM1g5V3ZTV0dKQ0IvNHNHYmhxNW9kUE5uMW1TVXptWjZz?=
 =?utf-8?B?alg0ZkxHUzhYT2NDQjlCaXRnTWpXMUR5a25jZjRUUXFuVjlIV2VnNFZhWmJm?=
 =?utf-8?B?bUZvSzdPQW1ZVXlseVVraUhYRUZpUUxQNTNvMnFQTmVUaXZIUW55WDFTZEZm?=
 =?utf-8?B?aGFFTDl4R3Budk5aN2puc1Z1WGdFNEVSNjFtSzErU05tZkZGWFdDbHRlSGN3?=
 =?utf-8?B?N3dSTmtqQy9tVDM4MGNqdlZSR0RWQjRreUN1Q1h3Z2NhRHZJNWFTUGYxRUp0?=
 =?utf-8?B?UlMwUnpVbFJUTmtXczBCdndCc0Y5QmhkZmMwdm9ITzFjaFh3OWF2Kzg0aUV0?=
 =?utf-8?B?SHNUV0lJM0hEb0NPbG44dkZnbCs1Qm9tTW9VaG9PWHNXWFN0Zk9EdnlWelBm?=
 =?utf-8?B?ZDlVdS81WVlTc2NULzZTOFlNSmN1Zzdzci8rLzVCb0tzdGx0UjZNZW90WU1U?=
 =?utf-8?B?SStUUlVXYTQwa3VoOGthUEJzNzQvOFY2a04wcS84eUVtMmUxTXUrS25aaFpN?=
 =?utf-8?B?UXdkTUMza1JNS3lMRUJxOTRXNnV5dDBLTmJuaDlBZlFuU3pDeURxRk1sS1Bn?=
 =?utf-8?B?dDN0WFNybkg0ZGg2NEI5K2k2K0pqb3c2QnZsejlpSXFPTUs2Vk96ZXhxVmV6?=
 =?utf-8?B?TFZuaFo5b09iMFg1Zzhab2poUXo0RmxvQjF1OFFkakMyWFhITnB4Uy9kdGZm?=
 =?utf-8?B?TmpwVmh2ZHl2SjBScXZ0cWQ4UHlvUDE0Q2tRNkNEbnNUK1lwU1krZ2s3UHMy?=
 =?utf-8?B?QmlPSGRtNThZdG1SMVdUVU40bzZDTTRyMEFQUU5NRU9zQStSRW94azB1M3ZL?=
 =?utf-8?B?K0dTQXA4dDA1VnRLRUI0enlOL296TC9vbTcxdEJMRHdHQ1BDa0l3REJKUGdj?=
 =?utf-8?B?Nnp5Mkw1OVU5Sjd3NUFlK2pCdmhDSHBkSlRxWUpRdkJSdkNPWjBQUGJ5Kytl?=
 =?utf-8?B?VTZlUWFLVHp4UDhjQWk2TVVManZ5KzdHSEN4WGpXZHVKakd5REtZNWhQdXF1?=
 =?utf-8?B?N1A1MFEvUVhGZWhsZVdFMHFybHp3dVY2YVlOcDVlVnp4bkdDaGVwVEtpQVcr?=
 =?utf-8?B?a1pac0d5THh0ODhIKzIyV2hlbEQzK0pOQ3dlQUxIcjNDWEFqZXhtQVUvbi8v?=
 =?utf-8?B?Z3RocUo4T25wQVJTMEwvTEt3SXZUVjlqbENIMUFtU2lMZm8vNTdhOVRjZm5L?=
 =?utf-8?B?eU9LM2xkUStWOHA1VkwvUloxNWJyaGdIK2d2QmMwL2x1bXMyTDRSSjJKYWRX?=
 =?utf-8?B?aVBGa2NzRjVKRmQ4RzZhWjZaQU8yTzlrN21Fc2M0MU14dTlZcHlzZkwwQlFR?=
 =?utf-8?B?eWM3TXJuMldvUUN3cHJoSEJ5VFdyc2ppMUNFNVpxYmRaL1I4aHRmaXZEaExt?=
 =?utf-8?B?anFWMmE5THlGeVRzZ2N5OW1EQmVBS3NmazdQRlFHVWxuWmJKWW43eGRDdy9j?=
 =?utf-8?B?SVVnUmFibmFFeDlJcXF5bDJLYWZ5dVhTVEU4WFhVazRseGxDZmlZZlFxNmNW?=
 =?utf-8?B?S3JiQzQ2U1lqd1p3TmdwZXFXMEcrVjJQMDU4WVg3ekF6akpHVURUK2dsQWJD?=
 =?utf-8?B?emdLNFM0WGYyVTJQTkFNRXNwazRBanpBaTBWK1FoTlRINXQ3RXhvN0dzQno3?=
 =?utf-8?B?c3NOc2ZCbGo0TitucWI3a3pDTXNNRTAvUDFNaFN3UWViT1V6VXVvUjdzeW1N?=
 =?utf-8?B?NkFFZmw4Nm1xSjBRaWg0N2Jud1VkRmE2OE1yV1JCbDJQKzIzb3ZmVFNBa2Fw?=
 =?utf-8?B?Y1E2YjB3dzFCTkRwZ3pyd01XVXRuNloyTjU0TXphMjJFbmJNS2FRYzU1VnFV?=
 =?utf-8?B?N0p2VGdWOS8zWjBWbmRpQXJVdTJ4WU1Fd08wczVScHNyT25odWpzQ3JDMnFY?=
 =?utf-8?Q?BW8qfKBvaPOlx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGg4aXpFQjJDQjBocDNmZFVMSTIyNGs4VGd4ZXA5Rm53MStuUm5wNXFHZ2xL?=
 =?utf-8?B?RzdRdG11N1BxS1oxUldQdEsxQUVQbDBGUndiZ05xT2wyWmhMNjRMa3lEbldt?=
 =?utf-8?B?RVMvNXc0VUcwK1ZFYnFuVW5jY1ppK1Q5UTE3Ym91dVBHendsSGQvcEF6TE5K?=
 =?utf-8?B?c3oyRTJrcDlpSXY1VXB0Y0g1ZFF5cnFIRWJxMzExUzlpVFdwQW1kcDQ4cGd5?=
 =?utf-8?B?M2NUWW1YUVFQcTNBdzBtNm0zbElSTG5CSlArK1k1S3VjN3NoNHRFZEdqWDIv?=
 =?utf-8?B?RHJsOTNLRllIOUNydEt0SnE2SmJVRmZneHVGVFRVVmNVVUlQZkZoei9FanJS?=
 =?utf-8?B?OHlkYXI4Qmx5NzcxQmJqTmY3aVY4WGF2SDdBVjVXMnJKYXJZaDkvS0hZNzh3?=
 =?utf-8?B?UUhMMzZ1UEhEZmlPUmdjTUpVSHJ3ZXpqZ2VycU5PT2R5b3lRS081UWtob2hZ?=
 =?utf-8?B?M1RycFZUanZuNVBNK3R3VDFEZUV1OGlwd3grZ2JWOUNSS2g1Y0x1REQ1ZjZj?=
 =?utf-8?B?YjdWenhldWNQMnhyWGxYR3hHc1FLSUxYWG9ZeEh1U3dOLys1M1ozSk1GeEpw?=
 =?utf-8?B?S1owR0dFaXc0RHRXQ3p3WWdCQkRoN2d0RE1KOTJGbGJKUXc1NnF5RC9Vdjd4?=
 =?utf-8?B?UkcrOElTWkc2RG5xM05BMEIxOWt4U25SNVV3QVZKRjNCdW1vSU1DL1BsMFlC?=
 =?utf-8?B?VVNBUFJDNFA2TlhZSTNyY1p4NHJyTnlDR3g4cFczOVNTbTQ4aHIwZDdyVjN6?=
 =?utf-8?B?T2ZHaUZFNGJhTlk0SDdFaTFpSG0wU2JFQnRJRVZKNmxsWkMwQk9GT2g0dEp0?=
 =?utf-8?B?OWNJbW1nQzlPanNLMTJtenZFYmhFdm5QSkFXMFBNQVdZQm1RcmVEd2NDeGtx?=
 =?utf-8?B?U1dkeTBpckUyUzlkMWk1UWpaRnN0U0FTam11TWtBbEdKOVBOMlJYdlVHcWo1?=
 =?utf-8?B?TEdiU2ZHSDNnL2xyLytrZE5PZ2VTeXJzYndtZWN5K1VLbWRUTU9YZFZ1MkZJ?=
 =?utf-8?B?MVFWODN3dElKZm1Uc244eW1uYTc2endOSW5YcE1hQTY2cHNPWmgrUnJ3R0pT?=
 =?utf-8?B?WTFFdW1xcVNRcURwTWQvbE9YRU9oNnFEOVJ1NXZyVnNIM1BIR3FqUXEyQTJM?=
 =?utf-8?B?MmVGbGsxNGs2aTk0Sk1TR1BBNkFuUE9kQ2MxYUY5TWRJZHI2bFN1RlczQnZJ?=
 =?utf-8?B?blBYTXB6SXowR2d6ekNKc2JoVDFTVlltUnFlOGRidk1QSzBWOS9rZmR6Q0FT?=
 =?utf-8?B?T3IxZ0pxSGFoeUJlRjd0a1ZyYXVCS3plRlFQTFQrREl6ajIxZDFYQVk4QWNa?=
 =?utf-8?B?THU1MFJWZlJHYml4Nkd3M0M2NGFZTTUyTWJaSjQ5K0hDN3ErVnFqVjR0OEVk?=
 =?utf-8?B?bGNWTHVOZXREeGlkZ2p0NDNaTjUyWkZHVUVtVGNua0RzQU1ZVVlOeUZ1WEF3?=
 =?utf-8?B?QTN1TnNsbndJWkNyNU8zVXMzbXIzNU84aDBLS2JOMTljVWNrMjRmSFZ4VDBF?=
 =?utf-8?B?dVF2NkVoQUppNzVFU1I1UjU5S1g1Z08wU283ZHNKbGhkWkpuNjdBb25GcEI1?=
 =?utf-8?B?T1luYzlIRitNZ1lER2ppY1U0WEJ0K0haZmxNYnZRbUFOenlqYkZKdDdkclM2?=
 =?utf-8?B?ejFDcWZyY0V3SmlhbnN1cEtHZitKbTljcWw0cXNoRjl1UTBTRWtxVWVFc21h?=
 =?utf-8?B?U3NHeXhXQ0Fjc1RvWDRNU29td0hxdU5TL1AxMHdNdThkWXpjWjRpMndYSVRL?=
 =?utf-8?B?Wnd5cHJjZE1xak1wSWZCdWNRaGFSQUk5QzFBNExDNTBCRWJaY3VkV0RBWnox?=
 =?utf-8?B?RUthWUpneWloSjltNmNSUVFTaXJOZjBENGs2ajdJdW9FbDlaY2dNZFg2TnB3?=
 =?utf-8?B?WXNsNHR5T3pWSEFMeTBTMnRaejFrb01JdzBqUVY0WVNJMWU4WDhmUEt1cU92?=
 =?utf-8?B?N3ZRMkVIMkJSMTlCR3BkTUhWREVzbXdVQlZSeS95MURXazZlaGI3YUtaNDJx?=
 =?utf-8?B?RDFUOEY0QnpVcmpsVFBFR1lHdGs5T252Y1cxMnRCZVRtRWdWRmVFajJlNUdX?=
 =?utf-8?B?cnV1ZWZpUmlYcGJFbVZ4dmc3Ynk0U1NBTlRMc3QzZHE1TXFucHNGNmN2WjZQ?=
 =?utf-8?B?a2hIVkExZ1JWbHlrdFlONW5qYTUrRlo0SWVyUG9GdncwZitiTzBOdmZxWTJV?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	evIYmXsipJukU/QhiBRUfXIRi03dvzDEAcKBIZfCkOd8bCBQUZlMppuGUwTzXSIZuapP4ue1hjT8ajt4yc2HoQBn0/Zz7r7nzFIG/4n4z+zrosnOIbQjzeCf2vJIk7Fjtz+7jRghMZ9a7O0T5KO4T5GvtexDzpR5DXypzxPdlr7KjVp/9ydeyPXxouujkToHt3I6x+0+9qTFkSeb5t4lThQVv8W2DhBUlG5k9junGPGGwgwYEU5j28JEWsi3LEn8m4Lt4mWoptFTGh6+WE39w/Wh/darmLpGl050+JIdFM1m5rvKT3curmIxPenv5pkfyZK5TaP85YVUm15qlLLb+H0dz7ygo3ypsT+rLNrn2RVYYSTA2db+/u225lI0rhgj2GBw7FSSNYOkdULm7GAX/IK6b9bt3uPHbL6x8pLsZYAgntSDBHAApe3GTw/WstqqrQHntWq5FhicsJHir19RpPCy++ygMKBTxGmS+Dg5HdMGSyI8jit5bFatHqstp9aDQTVJv/cOld5ALDcWC+7MuyVH4o6IvqGxbemBP/T2TjhxgmsOwstcAjjC1idFY+qpnnAoS6YdY/dHwj93D+90XWHc5LVbcfRsD+w00LfWW5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a35ebf2-8b3e-476c-7177-08dd55b88f24
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:22:12.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCBdhp2QfErZVCROm4tNIa9DfI4blipK6WAdZ+RZkXRZnm8knThCGVcK1zGq7F20zs3XIsy34Z/KCBDrIHjJfp0uqe+v2i/4VOO/b9pAAd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250104
X-Proofpoint-GUID: 1YPRhwyQWKhTSzNrtgw_o-coGwgMMdK4
X-Proofpoint-ORIG-GUID: 1YPRhwyQWKhTSzNrtgw_o-coGwgMMdK4

On 2/25/25 10:46 AM, Liam R. Howlett wrote:
> * Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
>> In order to determine the store type for a maple tree operation, a walk
>> of the tree is done through mas_wr_walk(). This function descends the
>> tree until a spanning write is detected or we reach a leaf node. While
>> descending, keep track of the height at which we encounter a node with
>> available space. This is done by checking if mas->end is less than the
>> number of slots a given node type can fit.
>>
>> Now that the height of the vacant node is tracked, we can use the
>> difference between the height of the tree and the height of the vacant
>> node to know how many levels we will have to propagate creating new
>> nodes. Update mas_prealloc_calc() to consider the vacant height and
>> reduce the number of worst-case allocations.
>>
>> Rebalancing and spanning stores are not supported and fall back to using
>> the full height of the tree for allocations.
>>
>> Update preallocation testing assertions to take into account vacant
>> height.
>>
>> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/maple_tree.h       |   2 +
>>   lib/maple_tree.c                 |  13 ++--
>>   tools/testing/radix-tree/maple.c | 102 ++++++++++++++++++++++++++++---
>>   3 files changed, 105 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index cbbcd18d4186..7d777aa2d9ed 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -463,6 +463,7 @@ struct ma_wr_state {
>>   	void __rcu **slots;		/* mas->node->slots pointer */
>>   	void *entry;			/* The entry to write */
>>   	void *content;			/* The existing entry that is being overwritten */
>> +	unsigned char vacant_height;	/* Height of lowest node with free space */
>>   };
>>   
>>   #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>> @@ -498,6 +499,7 @@ struct ma_wr_state {
>>   		.mas = ma_state,					\
>>   		.content = NULL,					\
>>   		.entry = wr_entry,					\
>> +		.vacant_height = 0					\
>>   	}
>>   
>>   #define MA_TOPIARY(name, tree)						\
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index d7dac3119748..ef71af0529f4 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3542,6 +3542,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>>   		if (ma_is_leaf(wr_mas->type))
>>   			return true;
>>   
>> +		if (mas->end < mt_slots[wr_mas->type] - 1)
>> +			wr_mas->vacant_height = mas->depth + 1;
>> +
>>   		mas_wr_walk_traverse(wr_mas);
>>   	}
>>   
>> @@ -4157,7 +4160,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
>>   static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>> -	int ret = mas_mt_height(mas) * 3 + 1;
>> +	unsigned char height = mas_mt_height(mas);
>> +	int ret = height * 3 + 1;
>> +	unsigned char delta = height - wr_mas->vacant_height;
>>   
>>   	switch (mas->store_type) {
>>   	case wr_invalid:
>> @@ -4175,13 +4180,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>>   			ret = 0;
>>   		break;
>>   	case wr_spanning_store:
>> -		ret =  mas_mt_height(mas) * 3 + 1;
>> +		ret = height * 3 + 1;
> 
> ret is already height * 3 + 1, you could add a WARN_ON_ONCE or such to
> ensure that's the case here and it's not missed in updates to the code.
> 
>>   		break;
>>   	case wr_split_store:
>> -		ret =  mas_mt_height(mas) * 2 + 1;
>> +		ret = delta * 2 + 1;
>>   		break;
>>   	case wr_rebalance:
>> -		ret =  mas_mt_height(mas) * 2 - 1;
>> +		ret = height * 2 + 1;
>>   		break;
>>   	case wr_node_store:
>>   		ret = mt_in_rcu(mas->tree) ? 1 : 0;
>> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> index bc30050227fd..d22c1008dffe 100644
>> --- a/tools/testing/radix-tree/maple.c
>> +++ b/tools/testing/radix-tree/maple.c
>> @@ -35475,12 +35475,85 @@ static void check_dfs_preorder(struct maple_tree *mt)
>>   }
>>   /* End of depth first search tests */
>>   
>> +/* same implementation as mas_is_span_wr() in lib/maple_tree.c */
> 
> Is this needed then?  At the start of this file we have:
> #include "../../../lib/maple_tree.c" so I would think you could use the
> one already defined?


I don't think we can use that one because the it takes in a maple write 
state as an argument which is not exposed externally. The 
check_prealloc() tests use a maple state and the maple write state is 
then defined internally in mas_preallocate() so I'm not sure how to get 
an external facing interface to the maple write state.

That's why a similar implementation is needed but one that takes in a 
maple state rather than a maple write state.

Thanks,
Sid


> 
>> +static bool is_span_wr(struct ma_state *mas, unsigned long r_max,
>> +				enum maple_type type, void *entry)
>> +{
>> +	unsigned long max = r_max;
>> +	unsigned long last = mas->last;
>> +
>> +	/* Contained in this pivot, fast path */
>> +	if (last < max)
>> +		return false;
>> +
>> +	if (ma_is_leaf(type)) {
>> +		max = mas->max;
>> +		if (last < max)
>> +			return false;
>> +	}
>> +
>> +	if (last == max) {
>> +		/*
>> +		 * The last entry of leaf node cannot be NULL unless it is the
>> +		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
>> +		 */
>> +		if (entry || last == ULONG_MAX)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +/* get height of the lowest non-leaf node with free space */
>> +static unsigned char get_vacant_height(struct ma_state *mas, void *entry)
>> +{
>> +	char vacant_height = 0;
>> +	enum maple_type type;
>> +	unsigned long *pivots;
>> +	unsigned long min = 0;
>> +	unsigned long max = ULONG_MAX;
>> +
>> +	/* start traversal */
>> +	mas_reset(mas);
>> +	mas_start(mas);
>> +	if (!xa_is_node(mas_root(mas)))
>> +		return 0;
>> +
>> +	type = mte_node_type(mas->node);
>> +	while (!ma_is_leaf(type)) {
>> +		mas_node_walk(mas, mte_to_node(mas->node), type, &min, &max);
>> +		mas->end = mas_data_end(mas);
>> +		pivots = ma_pivots(mte_to_node(mas->node), type);
>> +
>> +		if (pivots) {
>> +			if (mas->offset)
>> +				min = pivots[mas->offset - 1];
>> +			if (mas->offset < mas->end)
>> +				max = pivots[mas->offset];
>> +		}
>> +
>> +		/* detect spanning write */
>> +		if (is_span_wr(mas, max, type, entry))
>> +			break;
>> +
>> +		if (mas->end < mt_slot_count(mas->node) - 1)
>> +			vacant_height = mas->depth + 1;
>> +
>> +		mas_descend(mas);
>> +		type = mte_node_type(mas->node);
>> +		mas->depth++;
>> +	}
>> +
>> +	return vacant_height;
>> +}
>> +
>>   /* Preallocation testing */
>>   static noinline void __init check_prealloc(struct maple_tree *mt)
>>   {
>>   	unsigned long i, max = 100;
>>   	unsigned long allocated;
>>   	unsigned char height;
>> +	unsigned char vacant_height;
>>   	struct maple_node *mn;
>>   	void *ptr = check_prealloc;
>>   	MA_STATE(mas, mt, 10, 20);
>> @@ -35494,8 +35567,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>>   	MT_BUG_ON(mt, allocated == 0);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>>   	mas_destroy(&mas);
>>   	allocated = mas_allocated(&mas);
>>   	MT_BUG_ON(mt, allocated != 0);
>> @@ -35503,8 +35577,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>>   	MT_BUG_ON(mt, allocated == 0);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	mas_destroy(&mas);
>>   	allocated = mas_allocated(&mas);
>> @@ -35514,7 +35589,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>>   	mn = mas_pop_node(&mas);
>>   	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>>   	mn->parent = ma_parent_ptr(mn);
>> @@ -35527,7 +35603,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>>   	mn = mas_pop_node(&mas);
>>   	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>> @@ -35540,7 +35617,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>>   	mn = mas_pop_node(&mas);
>>   	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>>   	mas_push_node(&mas, mn);
>> @@ -35553,7 +35631,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>>   	mas_store_prealloc(&mas, ptr);
>>   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>>   
>> @@ -35578,7 +35657,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 2);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 2);
>>   	mas_store_prealloc(&mas, ptr);
>>   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>>   	mt_set_non_kernel(1);
>> @@ -35595,8 +35675,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>>   	allocated = mas_allocated(&mas);
>>   	height = mas_mt_height(&mas);
>> +	vacant_height = get_vacant_height(&mas, ptr);
>>   	MT_BUG_ON(mt, allocated == 0);
>> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
>> +	/*
>> +	 * vacant height cannot be used to compute the number of nodes needed
>> +	 * as the root contains two entries which means it is on the verge of
>> +	 * insufficiency. The worst case full height of the tree is needed.
>> +	 */
>> +	MT_BUG_ON(mt, allocated != height * 3 + 1);
>>   	mas_store_prealloc(&mas, ptr);
>>   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>>   	mas_set_range(&mas, 0, 200);
>> -- 
>> 2.43.0
>>


