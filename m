Return-Path: <linux-kernel+bounces-387810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE639B5656
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CCC283C11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9C20ADFF;
	Tue, 29 Oct 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y2rYyoLP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ER/C+LQ2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBD20A5FA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243058; cv=fail; b=DOtBnTR/iRqmyWmrT1BuYOnVNiFPfcFYGXDy6FDALV4+iAgYVTnZFiyFlNpKUbixrxJoqoOgmXh83POIVU4xW7XVO4ohGkxUH4STXhpOL6WHiq0N173ILUdN8FGA0/w54PTMwhQcQTy9fa3VhOKQYsndU1N2DX14KG8WvHuQcDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243058; c=relaxed/simple;
	bh=3mxIL8RYLlOXNzeKm4E+p3pdQfdbBMbSgWQbMGpUlKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NYoJ5HvZHk0i9P2gSz3w+hNx/g9TB0Kqw/lR3I6xtO1GGugpysa+gdNmjFUsmpA96yOiGrxRbKA+m5oyIN2e5uCLgqDb9KDbBml0aVpTFVwsrzWF/bhGJSyEA6KinA/KKbiuRZTqJIXhXpe6yM84rpqc0Nqy1RLomOGsqnn2AMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y2rYyoLP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ER/C+LQ2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfg2T004502;
	Tue, 29 Oct 2024 23:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/IgSPzC0o90l6+4eJOqFGS2v8bFyg++6MoN1qJC//c0=; b=
	Y2rYyoLPVpG/v+dnWXUY04Kzz7UkeEe4K0fUz176vPnw8C8ov2uRHyQfVVgycOyH
	DeSqS2G+mqDqPq4UmUHeEbH0n7rWE5hAdVN6Ou2e+htyghRBSrM/buJW/CGnedmC
	QvnxTWIl8lSpLUlgueVEqzIHrZXkkmrAgQ4ScCi7s668LERQNN/2Huyomq3nq8C2
	/a3CM/C4X7gx/MuFRcDW6dVTpEPtUclU/EZst+WDKj0ohw1a3aGcpVmfyu7Us7ku
	9VgffvwSEZSxjgggrxujLOmSMf3X6xK75KXf/+2zGcpLJ2bUVjCXOrwif7KZmPHR
	VYUprTmDdeeZyOP1sPWAJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxprt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 23:04:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMId3s011737;
	Tue, 29 Oct 2024 23:03:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnad8e6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 23:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAAve/h81dvMMawlYdcqxyaNvGvBXXZ6cZJG24a7mMObyAp4AO5JzBGCFpHSAhLbk342Icpvz9r2MX7hVKSOS7DUbnjECa30xyOyP6+H7BASs1gMD05YQ4Pww9jVUZxsh+j0uKNaAhlENCfnVlqP4uOKLQpxHm5QwpMlCzavErHWAf8XzhKwXKItIL3r4QSt9jijh20ke6H6oYw9zS60mbNu457QVWDkfAREwuyb2/dR4e3z3b68MLIlClU2iI6Yid05lqBUGTe+af7dpJh7tkKcN/ot4RR4PHtZaWt1voWpUm0mst7FMA3zqAHO223SC6SzgcamZ36zNDoEzkTMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IgSPzC0o90l6+4eJOqFGS2v8bFyg++6MoN1qJC//c0=;
 b=y/3YdesqTYXUxGNXM2GfQfyf0oOsuOEI3l3zEgB1EiUEzGyi12Y20vykgGY8DhnhdZPgfQJQmum8PSK2P25vZQbR/kwYIspb+h3G98Owaa0r1eC2eFIGk0DPqUoEGjOp5eyUNZNztYkGr2wH5u8VDjCGuJmGY7MMdMnmAkpL3CJx2ODSbriUibDYgd7KB1Vq7sZIt+i3uu6tmyjBHPEs8HjFopZVUgzJTaGITulFFisEchm4PfeUqC2lBH7vDbbm/LCCreAQIR7By+DkkAewNBL1PSEQTBDkQDGLc1iYPvQIN606TXDSdHhKz8ViiqJT9WiPd5JBvGVONgux1jGd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IgSPzC0o90l6+4eJOqFGS2v8bFyg++6MoN1qJC//c0=;
 b=ER/C+LQ2hnRfoHRxdHOTrN73x9iUVObH7UW9LTGbhXrzjlG50aGiZ/T1Mn7YZKnefPHK4nOtcVqETPvxLleGZByc+in0hrHa/Qursj5GY2vNDyhRajiFGEPEdsiNlHpexKeebd9vu7bhdA6S3Gj6l5k4gaSp3GgLzigzbKpY610=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Tue, 29 Oct 2024 23:03:46 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 23:03:46 +0000
Message-ID: <fa5dd074-0045-4f37-894f-861081f4cfdd@oracle.com>
Date: Tue, 29 Oct 2024 18:03:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dtInsertEntry
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, osmtendev@gmail.com,
        ghandatmanas@gmail.com, eadavis@qq.com
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
References: <20241010134351.1884580-1-ghanshyam1898@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20241010134351.1884580-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS7PR10MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2487c1-eb1c-4a74-95f2-08dcf86df146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU5mRUNrN3A4S3gzUnRKc3pTV2JTUmU1U0dkWUpOdGV6VGFpbXVtd2dxZGh5?=
 =?utf-8?B?dzUrZ24vNThZdUl4c0c2eFU1dG4rTlc0WnppSmxXNU5BSE1yNnU3R2FqZC9w?=
 =?utf-8?B?aWRjeVVpWWxIaE5CeDRyUkZUeTFDa2tLSUpKYUZRamxIV0UrRXBmdVpZRW56?=
 =?utf-8?B?alZtdE9NeHhTdXl6NkhLZkRFcUJHakdkY2FCQlV5bzFoa2FHTlNGWTR0bjBR?=
 =?utf-8?B?L0hCSlNuMngrNjdtdTkzckhPM1NCRDkyaldYejV4WkY1L0JJRk51WS9Kdm5i?=
 =?utf-8?B?dWt2N0IveHU1VUFFVHFtNFFMYkVYc05RQ2xaYVJ3SHJBQ3ZKd0ZtU2VnMXA2?=
 =?utf-8?B?aU0rNDhwcGhidHBpWjI3dkJ0RkoxeXNjdW5iUFZjWTdBNWhyem8vai92ajlC?=
 =?utf-8?B?N3dWUWpWVWpobmdJeGJkYTRJWUZBL1hJczJwazE3NXo2M3Q4d0ZOdnJ3K1A2?=
 =?utf-8?B?eHg5MmdoeTg2ZnBDK3VjT0V4akZMZXVmRTJ3M3JDZlUvb2UvaENPRzU5Sm9T?=
 =?utf-8?B?TkZmUk5rRVg3ZS9LWFptcGwyeGo2d2wwZUxSWkN3cStYZXptamYxbTE2bExm?=
 =?utf-8?B?TFNuQytlOUtXOVo5dWFCRU1FSkNoNkkwZ1lsclRnRFpmTlA0MVJzSTJvUUQ0?=
 =?utf-8?B?c0FXTTBlTDRzYnhVZmtBRUg5TlFmYytRQUFqcldUY3hlNFRDb3ZsRktlOFdz?=
 =?utf-8?B?aXE0STdNL0Z4K2ZJaC9UblF3K2k0WHBDeS9VK0FaYVdSdjg2Q1BMRXNlcGNi?=
 =?utf-8?B?b1dzaEUxb2xXT1RGaEdWeHdJVm4yWGd0cnlxbXJuNUhSQ05keitVMXlSdzdD?=
 =?utf-8?B?R01kMEZHYm10eHBTVlNNd2wzQ09YbHhucUdMQUE5b0d5ZnFGTU1MeHZ0cFZI?=
 =?utf-8?B?VFQyWUp4eWZtMUYxT0VQTG1Ud3I2eUdHME5Gc3VYd3lvaW9NVTZWTWNzaXRO?=
 =?utf-8?B?YjR4U0lXUHB3Z3FjT3RPU09hU1JTYWQ4RVFmVHFGci9YYkhZNUtMSy9iTGpE?=
 =?utf-8?B?WDBnMDNsUjMwZlNNNjF1bVdWZDhVOEVhaWRESVBCQjNKWDNodHlsMzBiMmhM?=
 =?utf-8?B?Qlg4d1kvMnN6QTNwbkpDeGdSWWJmVFZwYWlEUlBUWW0yWUpna2xxWS92dWha?=
 =?utf-8?B?N2hnUm1Bd2FJSnMxMkFxWG9oYmtSeEltMFA3QmMzSTR4ZUkwbDhHak04ZTRy?=
 =?utf-8?B?UlA0ellkeHZ0U3g1OEt0a1BDQmMzbndXWloxbnk1Sm5oVUhLR3hhR25ZS2JJ?=
 =?utf-8?B?RFdPNVUzNHk0cytlSTg2TG5KbXk4V0tBOUNvM0J6dUVoZmxUMENNUUVvZlhT?=
 =?utf-8?B?YjdiT3FSWm1YOTV4eUpIeUdrUEp5YVBhZm1kcjFVSFQ0a01uaEFKM2JYc3Zx?=
 =?utf-8?B?akhRTlNwbnltOE1zeHYzckVwSGJRQ2lmMUVSZ1A0UDVYNVhtMjNxcW5kVUFj?=
 =?utf-8?B?T0JrZTVEek9HdEI2VjkwekR6Rk96d29OdjZXVExVK24vVGNFYnBUbC9YUnlZ?=
 =?utf-8?B?TDJGQ01STVRBRDB1emZqeWdsR3VaUUVzeUNNbDVqMnRZQS9xUmhmUXVocVVG?=
 =?utf-8?B?cHg3OTdmSVlyZGZJZmxYS1FpZ1V6SG01eU9KNXNWUGRoNGxROUhYVTBUdGFN?=
 =?utf-8?B?TlZxZEdaSnp5VWZpWVBHRXR6MzR6MURJUHN0K2M2amFPcmJUZ2VqTWY4YU8z?=
 =?utf-8?Q?0njb3kLrZC8sw/1Q64yO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RllLREV4YktHamF1eGhSMG1SblBKUllmV1ZEMzRiVC9KaGp3WjlOREtSRm01?=
 =?utf-8?B?SnZVcThnb0s1c0V2T0hMSmZCak1EMVlUTDk2M25iSzlPcTk2ZTNGYTI3QVVF?=
 =?utf-8?B?QTBrVXBHWVdiSHpxa0dZNjRCcDRTUnA3MzNkc044ai9uWnBIZXI0SG9aRXM2?=
 =?utf-8?B?eTdwMExaRWt5bGZzS3FKdzhTQ1JTM2pHaE9DRXp5T2toZXczdGZPNFBzdlBL?=
 =?utf-8?B?MHlGMXNzR3VldFMxK1ZDbUEwVmpmUHZHZXdFdjZtNkE2TFArdzdFenkzM3JW?=
 =?utf-8?B?SlhGWkgzRWl0S0JSNmh6SXpyS1BhdGtFVFRWbmpUSTNiOVYyUlEvakJhUWNO?=
 =?utf-8?B?Mld4M0s2YVZYdDJDdW5lbGhCUnJEYXV3bmxSSDdoZUdiZ09BeG4rU3N2UG5M?=
 =?utf-8?B?Ny9vb2lzVHpCR1dpeU9ZM1hUK01qQWtrM2d3VHF1VW9MSHJPdkVzOUxKQ3Ex?=
 =?utf-8?B?clZsSEFxa1NsbTNKeFh0QjZmd2pKZDdQVWl1ckEwT01vaStIeGxLcWl0ZkM0?=
 =?utf-8?B?cWN0b1hMS1ZKMU1NakJCbGtVa1FpcFp5aGZkc1JQTmt0Q2orMmVnZDVnRlMv?=
 =?utf-8?B?cUdUSTdvcTQvZEZTYjl6Rzd3RkVyOGFjZ0E3OENFSVBhNEhYa3FKbU9GN1Q5?=
 =?utf-8?B?a2tjaDBGUk9XZk5RcFZ3VEdPaStkQlpMai9VamlySnRRREdZc2RNbW93TTY2?=
 =?utf-8?B?WUh6clFQMEo4eHk2RXBvUDJ6TUNiMHhjWXNGZW5yVmZIMklUdzBjSG5TcUlp?=
 =?utf-8?B?cE9Ya3JTN1g1cXMzcXY5OXFsNmNyVnlCSWlVU1B6aXo3YmN0bTFCSlRsbzhC?=
 =?utf-8?B?Yys2MWFqMFpzRGQzM20vUFhjV3BVN285L2pybFEwMjllK3AybXhrQjh2eWN2?=
 =?utf-8?B?S0FsSzhqcm5uZWNxVm8reTZrbVV3WHVrQU1va3VqalZkYUJBT2VEU0J4Rk0v?=
 =?utf-8?B?UEF4bGlMa3V6K3lMelVyUGE3UjFlMWRNL1l5MUZ4NVNkN1l2SnRJQmlsYm56?=
 =?utf-8?B?eWdweVJHMXNyY1hyeGZMRmhPZW1pTEZUSFZncGVmam81M2RtUnNITkFIVlBk?=
 =?utf-8?B?V2pBeDZ4ZnBHLzlwNDlla0pza040Zk1XZkw5am9HTjdYODc1OXBjem9WZlAr?=
 =?utf-8?B?b2lvajFCZG9OMkJ6dDdoNENYZnk0TEZEZVBaM1diUm1mbVRxTkhFRWFqTmJ0?=
 =?utf-8?B?VE1MMFFPeVVsR0NmMG5uNXlCc1dlL2VINjlHQkZwQ0Rvb0Vwa3NhMk16RkhK?=
 =?utf-8?B?OGlGejBpaGdOYnNRSlBlN2lFZU1UVUQwZ0M1OW1vOWVMWGJQdXE4ajVyaFNL?=
 =?utf-8?B?LzRKVXV4S2NTSExNcEtrMlNYUUlKR0Npckw0blByOExlVzhRRmd3UHNBaXVh?=
 =?utf-8?B?aEp4R1VTOFJad2pVSWFFZEhNRzFWdVdHWTN2S0VOendmSGUrNHJoTXpJbkRn?=
 =?utf-8?B?eTNjQmtsMk1sdkJBSklOMUsxdi9xWkdZbmh1ay9MYWdUdWNhd3FxQmVKNVNF?=
 =?utf-8?B?L3pqNVV2SWFtaHpVQlFsK2xvWXh0V2ZleUgrZ25WeE9BQmdOa1lkWHI0L1hE?=
 =?utf-8?B?OHJPSmdrUXhmZ0xnaVQzcXkzaCs5WlQ3MWFMVTBjdllwNEliYkNZZW5QOWJC?=
 =?utf-8?B?czFvWk5iUmNqWVNLVk1GSWJreUYrSGdtRlE1bDJXbnFrc0Z0Mk9xUHZrTENm?=
 =?utf-8?B?THVhbG1XZWlOOElGVTA5c1F4TGhEUkcwNFp1QXR3SDk0cE1vSUR4Vk1DcCtN?=
 =?utf-8?B?NE43ZlVPeExrVlNJZWNGb1crbWRCeGs4Tm9GMzNacmh0UktybXgyYnFKK1pL?=
 =?utf-8?B?c2s4cjZFQzdNRXRNYXAweUw1TXNVbTR5dlkwblVYWWZlbFNDU3dIR2IyckQz?=
 =?utf-8?B?QTVaam50TldIdzZSTFdFZGo3K0Z5ZVFqL1YyYkplRG8zTTJWNEd4c3BSVnRN?=
 =?utf-8?B?NHAramtTQnlaT3JMOE0zbjhveEY4ZDBvM1JmVWNuUzVacERpazdBeHBjbXcx?=
 =?utf-8?B?Ri9wMjYvSFZ2WDZaR3RPZnJnMmMybExwR0VSbHZKM3N5QU5yK09jakU1Nllj?=
 =?utf-8?B?cXRlOERqMWF0TVpRMk9VZDB6cHlpYWc4NGJLSVV4Z0YwZXpFR0kyaWlCRHdu?=
 =?utf-8?B?ekFiTktqcG1PN1A3eTV0a2EvTTRENkM4clFNT1BBejQzdWFXTUprY29hU2kx?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fNQoEdHHX1RVrmZxkoB9I5kf4LAYpxNZBKYzPE58dKuT5VoFfn7//shUEHUm48hpbyh0psZqQGMHwB3ozZazg5RbrJaRS2ohPDbaIRh9LVi89Guc6xbR9bQXN8VHBK9k0Lm5PCdR0eNxVpaDwKrr0Q/oxnSBF6Jf+CsYQC/DK6SuwMvDGhg4zxee82TTLjNVi5GcLWkmgJ25ntwX8caYkR2ZED3B2auop7X5AwriAYxlpbTEnWRKeDa73UcySSYE/N08zy7nCFBe7WsiK4Lml/n2NXF5uGYwqxmzljBZfcMGP5h3LUnDUOwxc6ujmPdFwQH6J6fUCLwHGl2JGKrI86NnEHAEoP3SQ9YE6IDlvW3T5BoVIvfy+HANxZDPfqxd0bt5aY/tPeU/GaqYZLyXWVNG31U3nbdw3bLGCEAKQyNi+oYSDdhK4FPBUNJDahKuhV6J+CxBjAcOz6r+8AqMsqyem02hVOSp1XQzjlbSyJBZq/L1TGupU2t5iqwTWLOkflHHwShq1DP2Es9vBdlty6tqcDYny76oMsbnj2qXGKvAc2i30Gj66jnb2/b8nYY6CwkYRIOCCUrlY9G9twtlTfhNqAVzjvhLd7zfOpY5k/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2487c1-eb1c-4a74-95f2-08dcf86df146
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:03:46.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFTdqm3cBJuaC86yStvpbW8syzuXUcB2jhM1KsxnV1IQhmnRfUcWMnHrJWh81Z4MqW64fU/7vhWhdLeOuhi5t6Jj0acsNfLEudYJ8K8m748=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_18,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290175
X-Proofpoint-GUID: 6d-Qzcjn1bvuuyR-beB3kcysroGU48Eg
X-Proofpoint-ORIG-GUID: 6d-Qzcjn1bvuuyR-beB3kcysroGU48Eg

On 10/10/24 8:43AM, Ghanshyam Agrawal wrote:
> The value of p->header.freelist can be less than zero which
> causes an error in dtInsertEntry. Added a check in dtInsert
> to address it.
> 
> Reported-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5f7f0caf9979e9d09ff8
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

Looks good. I'll apply this one.

> ---
>   fs/jfs/jfs_dtree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> index 5d3127ca68a4..51bb3e14551b 100644
> --- a/fs/jfs/jfs_dtree.c
> +++ b/fs/jfs/jfs_dtree.c
> @@ -834,7 +834,7 @@ int dtInsert(tid_t tid, struct inode *ip,
>   	 * the full page.
>   	 */
>   	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
> -	if (p->header.freelist == 0)
> +	if (p->header.freelist <= 0)
>   		return -EINVAL;
>   
>   	/*

