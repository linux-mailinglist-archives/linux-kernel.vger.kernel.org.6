Return-Path: <linux-kernel+bounces-437954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDAF9E9AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760D116551F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5A12F59C;
	Mon,  9 Dec 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ef0VcanF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j28bkE9V"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF6126C05
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759613; cv=fail; b=epr1FkIqfNoiN8RJ44V5dmitn47CfbDUrVLjqRQGSaFQHP/3AuUOutpnNKGXr+ObvH8kx+6CNodckfDvZYEulI4rCKrtmO/wx4IGoDkJdptmuQUquwzKKul+bbG0OtdoIf3nh/I4ZmsnlbT4IZN0AG6Az/H4bZ/MUledFn/Uxp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759613; c=relaxed/simple;
	bh=BUgk174E9YRQURtr9zOl4wzK83WExd2ymUtDY6Esxhc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k0R9ogK1TGDfn/Rnuv4InP8NsbGHuoA+WA+tbybqotIVwSkWMmWQR/LUU/wxGpYlx7s6T8Yp2rAbMJjUD3/JKnrQlMsfLuq3YHrh4BDgx7z2NEA5cON1Q/awhuoXDaD7vnvxWWT9lWf3KHlDlknSiH4tihI88UV+fhtX/Bk5loE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ef0VcanF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j28bkE9V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98frsh022557;
	Mon, 9 Dec 2024 15:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rffvD5TCMP9lEr5MoMsfBAAbAZ4IZdlregXtcJpyeOQ=; b=
	Ef0VcanFaErlg2irwnKgOPcriv6VlNaQsDQ9WSXYMnfgPCbDGKh+xiPqRPnMaQ0L
	ApXQHAuxUpeFFkICARY/cuTo7tSK+J62At/G6f/scVUXqd7EJ5I88bmjMCEcO6fd
	sVylqq64CATgsYlTZcqh2n11LzZTvPsowPjoHeTA9lNHgRSOcP/ashcNECGKlYJU
	a5hHSelCvJ9rj1bZ9lDbcBRJ9nfWBCz/Ba/FVSVtI+iChROgPVhDII87uVz29hDt
	i0aDksLJic4zMX+Mb1DvD9leCxjiDbHQ6kATjhmDiaXvTuhPfcrJ6tFn98sz9T8l
	MH0BE0yKCGVlRisPqkmD5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc3jq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:53:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FjTOt020567;
	Mon, 9 Dec 2024 15:53:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct727m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCQgR8FEfS4CsoCeufJz/uIEsCGXf8MryrUy4DJ6EvLREe0x6fFE6/pD6bFumyaECSTzrd9PUO8N8Cf8Ie7wzdjCbmplFUyzoiEJbBB75obdEucU5ftwEVgLYzGABcymYXDoAeskd81EuiiGrHq2uJcNX0dQcPmmEKm4bjwjI12sQZioM6ghwa0XYEnx+RZWWhm4JYMpIgdbeUvVtA/18qduBtA50vZwrtPw7M6i/xspmk3cIf+3GCg3P9szjjH9hGrdR65TRxn84JaNJphfHQIP8renOGkibaaDROhAKAdNTxQItSbmfYZtqU+AZL7QoEaFkZOOS75lqzC2Ye1v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rffvD5TCMP9lEr5MoMsfBAAbAZ4IZdlregXtcJpyeOQ=;
 b=kWDRuXfkmtQPUy370SvwlHujDLj4KMNsQsgNC0pJML4d347k8/cPjsXjsAP4fashCQrDKyaJKrUB5SJdI/FJ5qJoGrfJ/wTPL2Erv6muGMy/377amSdgGJ6hb03KfTU08PjbI79OS/VA+xdAgj9nix0aouGjpvgUbDVj+ME617gxU6YznaM/7H1h26PTRaya6eS8xqA5sAfCudVUnonfAX1XoBO+Q/aPvzw3ateWrOgUbcQh1v6yn5rGCTh5SDXvTMIDJJizvjwFZvVeWCtF9g0YjGv/2pgzzyK/SGkZXVhmuubNDwiY6Oxoa4Cq6Hm2blNu7egqx0stq3sp4eAqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rffvD5TCMP9lEr5MoMsfBAAbAZ4IZdlregXtcJpyeOQ=;
 b=j28bkE9VFUr8tUVCOm3MCoQAVA4KlaiOFMGE5g6quiUnbxrugPfuLNHwLuvbrVshe8estbRn2yBS1BXg+LJwzNu05UUl2bNbqzs8usHhxxOOwm8Z32eTYcgYkj0tJw6YuHLEWGq3NLSjPUL5+RGJqbZxQEu/DYuMGgfqanDy4EE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4219.namprd10.prod.outlook.com (2603:10b6:5:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 9 Dec
 2024 15:53:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:53:15 +0000
Date: Mon, 9 Dec 2024 15:53:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
        syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <4d05caee-d900-42e5-84e1-448cc62435b2@lucifer.local>
References: <6756d273.050a0220.2477f.003d.GAE@google.com>
 <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
 <CAG48ez1d60kH1W8uVvOh-+Vs8Jz5TX1a8LD+mh_O8_3HFHAx6w@mail.gmail.com>
 <e9b3987b-8cbf-48db-ae70-ff9e2c0954aa@lucifer.local>
 <hzzshrolmkewwxa5bejqrcb5xpbe2upfpa7exvxmq6svdszwhl@wsqg4gksstne>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hzzshrolmkewwxa5bejqrcb5xpbe2upfpa7exvxmq6svdszwhl@wsqg4gksstne>
X-ClientProxiedBy: LO4P123CA0134.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: e15132d8-9643-4c1d-f338-08dd1869979f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3dIL1FaRS8xcnNyNzJUQXh6TXZIbkx5alNsNng0dTRqOHRaUDdPTXlmWFps?=
 =?utf-8?B?Sk1vWnZPYkdqZklPMVFESUYwdFI4alN2T2k1UHdOcDRLeXovQiswcUxEUGZv?=
 =?utf-8?B?UFllTGlXTkZ4cm5NRXg3V1o1R3A4R1pXakhEZjBWYUJ6V1pWYXpiT09ucFE2?=
 =?utf-8?B?dXFLOGVjRWIrOXJxSnJQTTV1L1ZIQjRGam5JZXJkcCtlRnJnc0VNWWYwd1JI?=
 =?utf-8?B?cU9hcFpMQnFjU2ZrOCs1bkpmL0pHdk5sc0dNa2V5NzNmL2tNNStuU1drbHpx?=
 =?utf-8?B?anRYT0RVSU5NbjdQNGc5SWhNWkhSOW51SGRmZFFxNlIwUm5tTkNoaTczMDZN?=
 =?utf-8?B?dFpGcmloT2dkTGVXN3IwSDg0YVRhUVA4aFgrL3lXWXFyNVpDWWNJTkNsMUMr?=
 =?utf-8?B?a1ZUQ3Q4NjRkUVdSVEdpSlA5aWcwckFGaHIxaHN1RUwvM2JYRTRoSk9mSjVX?=
 =?utf-8?B?MFpqNDBtSDRwV1RhSitWdmdTK2N4VWNZSmxxczlnK1VBQlhUZERMeVg5QWlR?=
 =?utf-8?B?MStPbHhRaGcrUnJ3SUt3dmZxTXh3VFpZUzRMOFRvVW9vSGZJLzV4U1UrUlVX?=
 =?utf-8?B?MUQ0bzdYTjQ3a2I5VWlNbThOT0R6U0RPUUc5cjk2VE5HQ21FdnZLek56WC9x?=
 =?utf-8?B?eWJkZk1VS3pQRDBLL1BseFEzRkJLZzMvY1BxQk1kZzVZVTVvMjJjOS9GK1dp?=
 =?utf-8?B?eElDaytmTkh0dURYbXNDNUI3NjhGeFFsSDN3bjNwM2xUY2wrRklOUnBld0Uv?=
 =?utf-8?B?azdQZEdBN0NlZTUxcUdBOVlLRExUNkNKWnI5bG9nQW94eTVMMlFBNk53YSty?=
 =?utf-8?B?TmZrWVA0NEFaclhwYldzK3VacFFsU0Z3NWhqWXB3VksxeHk3ZXZzZUFTQ1Vy?=
 =?utf-8?B?OFcrcnBlSDVmTDROVmMyTjl6VHg3SWRXQlBnTUc0YUNpdVRMQWhqQkJxQ1BG?=
 =?utf-8?B?YUFmemc0K2pWaXRTY0lhTk13dVo3OEkwQTVKRllENzZtZzVJbHVHY0tVMVRh?=
 =?utf-8?B?V1RUK2JYQkY5Zi9ibGd1cmJwWW9GYjhaTVBkU1g0T1dUM2diS3Btck4waW1K?=
 =?utf-8?B?V3d2Ulo2MjJ5NEJXYldNRlJRbGx6SkVRSnBuaHhoR3ZITllYbE5oRkRXdk5J?=
 =?utf-8?B?SWgwb09DZTlnYlZUVVVObzh4OGNUa3dZVGpPTnM2TXMyTFE3YkYxa0FyOHZn?=
 =?utf-8?B?eW45VUtHMWFEenhpa2o1eG5RK216WWJTbU43U1pwdmtnanJhb29PWXFJdjMz?=
 =?utf-8?B?Q3krZHUwK2Z5ak9iYyt2cCtucnExdWV5bFlmekFxaWpFc3QySTZmQVVGSDZJ?=
 =?utf-8?B?T0VRMGNPVWhyL09IL3JHZkZmS3pVTjdoY1c0Z3FUNjhSNGtQQlYrOVJKdVc4?=
 =?utf-8?B?Si83d0cyUlNNV21CVVM5QzFRb1ZrU3hMdGQ2UmlweFVPdldzZ1QwY0hDWEhj?=
 =?utf-8?B?RWpKY1dBZkFTM3ZmYmU4Njk4eTNwSlVpejBkbzhSWWgvMzVNNzdSbU9GWFVs?=
 =?utf-8?B?a1BXQTdUNHMzV2ZKYkQ3blp0ZldZQ1V1a3ZHck5OUkNtVGtVYk14UDI4Mm8w?=
 =?utf-8?B?WnE2aUdXQTJwR2thbjNjZjBCeUpoTDNkbFJwYzIzWmVycVdEVEM4ZHFzWkll?=
 =?utf-8?B?MEp3OGN6MXI0a3ppR29uMTVyMzFwRk9MRWhXdmhZU3oxbXlBNFRVQWVvQzVs?=
 =?utf-8?B?dUFhMFA1MmREYTI2YW1jeW9xU1BuVTVwak5LVEVnVjBVdFpHazduY1hMbDht?=
 =?utf-8?Q?ZLk/y/uQUiTnfJJ/JQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmFtRnNKOHd2ZXNteGpocmdjRjdseDNHQXpiazI3R3RIdVRaMDlnbi9yRWNa?=
 =?utf-8?B?TUJqbTNDT3g5TTNaME9ZNjEySUtkYjVwclVIT2p1NDFoUW1jcGlPcXdXaGpE?=
 =?utf-8?B?S2d5WCtyNVpqU2phN1h5NDV4eDEvSmx4K2tSTWNRZ0VldVRqcDRrcktXMXA2?=
 =?utf-8?B?dERmVjFFQjc0VTRGcE9keGV5SE1KaktDdWhXb1U4QUl1T0RNNHlDbkdSdTRD?=
 =?utf-8?B?cTlyVHdicVNTaWt1bEF0akpKNlM2QWlQTGxSYSttT3prYVcwOGd1K0Jkb1NF?=
 =?utf-8?B?TjR3STVNbUlpYTlBMEVISTJ0WjhOdWN1KzFWaFhkOWN1S3NuWVFtYjdMRkpo?=
 =?utf-8?B?bTVjTnNIZDNIdkRiUk9HNTR5bkFLRFI2RFJrNkdiNVRBL3ZHNzdwM3pid2R3?=
 =?utf-8?B?OU9FazJjdjNBVE0vQ3l2eTBCNkJqb0g1dk1IeEVpcVAvRzZkSFJWTXR3cUFn?=
 =?utf-8?B?Q213dGsxN0xiY2NtaVR6cklVUXB2SDRuTWUybEN1R1g2bGF6VVdhc3ZqdWJN?=
 =?utf-8?B?RU5FSTBOMmxLN2xFU0FuN25PSnUvMDhLdlVpYjV5aFpvdEE3VGNNMVozWTg3?=
 =?utf-8?B?aDMxSlNLakUrYmV1bXh6ZGlFSUJXanFyZDNWcE5CUFRJYU5CYzRiNDROYlNX?=
 =?utf-8?B?M1Z5ZUZBSFZKajNJL1V0QnZSMUExRFJJV0Foc1dtT2dyUXNTeGtlZzVkSktu?=
 =?utf-8?B?cCtxbHpUM2lsVDVENm92NytQS0g0V1Rib1RNcVNoYldOYU5EWG5waGZsVHNC?=
 =?utf-8?B?cjU3K0xYa0hTK1l3WnVqRk5yT25pdWlQUzIxdGhkVnpodjFxbmdLSkQ1MWRF?=
 =?utf-8?B?UWlHV0xNaW5xdXFpZGxSa2VvSktnZ3dKSW0vWi9jUkloZUUxVTVrM2lGVVUr?=
 =?utf-8?B?SXJseXlDcHlndkRvRlRWUFlOcVc5Yk9EdS9OVDNwZkkwcEFyT3Q5YWR3bGpU?=
 =?utf-8?B?L0RIcEdjVE5hbWZXcVV2cHordWpmNHBwOUZDb1NoQndNNGFQbjk3M2pURzhP?=
 =?utf-8?B?VjhvbHZPYWpOMkFOVko5VWVTRTZZUXpXMWQxTDcxVXZUTUxicjVLSHhjSDZr?=
 =?utf-8?B?bHZ1YW13QUhhNkF0eFpYaXFpcVlFR2pWa2RjdXF5VkZ1a0N0M0g1cHc2L2lM?=
 =?utf-8?B?S1pZLzJIU0FBRWI3djg2N1hvRW5Hb0lVakF3b2o5SXFwblJmRlNnOVBSNHJT?=
 =?utf-8?B?eFZBckpjUTlSOWlhRkxORzUwNkdEdVoxTDl1Y1BGK0ZDdzFVZndtUDBFSFds?=
 =?utf-8?B?ZHJZUEExbXZTeFNkalVXQ2U0RmRsaUIrSDhUSjNDbWREd0JVVkdpZVI4djRx?=
 =?utf-8?B?ZTJONUVucExuTG9uTWVoSW9oREdwaHY5MGgwVzFIQ1prRnN5UUxFVGdPY20r?=
 =?utf-8?B?cWlMNllWSmI5QXNrTFZFMUhxYWloTVUwdFhDUFoxT3dTL3dSSjRKMnZlN1Fy?=
 =?utf-8?B?WkN6aExiSVRjd3JTeWdLUzc5Q1FHMGh2MVJhUlBOdGd4OGhEazNEUFVZNTRP?=
 =?utf-8?B?NmFDRkdEZTdVZjBsMzM2V3hLU2JaWW02YXpnVldMRmg5Wnkwa0IyRHdGeG9j?=
 =?utf-8?B?VGhmVFpua29XYnA1UVMzYndBTkI1WDJLOUI2bk1HRWVJKzhlK1RZQjY3Qldh?=
 =?utf-8?B?cFU4YWxLcjZpQW10ZHc0SGcrTll6NGVSLzlEZDJ3dHZDblFEMmhBYTZjSDFl?=
 =?utf-8?B?Z2Z3SmlVZm5OK3J4SW5lcjdIRDUyOXRwbktXTk95YkczMjVjOStGSlZEVlI5?=
 =?utf-8?B?RzNMSXR3VEFXb2lqcWpleE5NSVpqemFIUGdIRlRzYUE4a2FEUFo5Q1BpZjRQ?=
 =?utf-8?B?ZVJHZ0FJTzgrQ0RQMFNIQ2dMalZtT1lBdkQ0cVNuejRXR3FROFd1aFd6MWZj?=
 =?utf-8?B?RmxhYU9oTkc0MVNHbEpoa0tLSVRXVkd2L0kvK1BzVk5lMFR2eHN4K0ZyOEI4?=
 =?utf-8?B?TitxZmcrWG9yYy9zVE1WOXZhL1U0N1lBQnYwNStpa2RzT2Fkam9IbE9PTUR5?=
 =?utf-8?B?TWJpZDNpR1lvUzFQU1E2UFJSL2RwNExKY3BKbi9qQ0FYUVZGNUdXK2IwbDdN?=
 =?utf-8?B?ZjE1bmthNzF6K1pMWlNXQ3c0bG54TVJjL2lCRy9sZ2QxK1RTdmtySnZMSlJv?=
 =?utf-8?B?Znk5akw2RExSMUc3L0FvL054Nzd0UDNHWVNmVEpmb3lWSlZhOGNBRjZjZ2N6?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VPSTz/ReZjRuFYitx29rYHRfPxgYKWkvVS2QpfqMuTNWi9ibZOS1jBicxOLT5QKLyerGuABagn7e9D20Om+bIOClQYNNoQjqKHyxw4OIrFjrBG/8Hy4xPw5stv5SHvlMMs3JZwaLAKoj8kYSauWY47K/I+3fdbj4Zp0rJNIZwmBSKeKb/Jel//LahUaGz2YMVW/DViHpV1YfQPBo/Z2LXyNy+QvMtOGzNpHOW3EUZg5EdYLgPMDb3dqKlo8wmvrr5EliuNWBsIIVTOEIcjqAJAc59LpSEgjer5x/2CRxrue3h8FeqA5eFoSSMjaNupDHssULYT1YLLdafxsbFfu65OzpqN4AtEma2RlMLocBrRbx1ucC/sudimUv6WjDuseZcYvj5rL1AWkvLa0g0/XgFAICQWT+5s7stvW4jg65J4ErH4PH86ESLxSFTuNAqykZUextjwAKFNRU/gws++gGFCP/R/YgcOyCEgt6pBdsxl85FGA1FxjWfF+nKFtJFif05bxwFEJCjw/81gtfxQhYgJ1O8onAS3AnBZOu+TSO8EPdYW0OxdwNVj0zwbjWtVxEsThNSc/xvBFl+e7ktI5+bU7PNdYOodfhapZyXUp2J7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15132d8-9643-4c1d-f338-08dd1869979f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:53:15.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v77PvkmsvNXlBRF/lWXPWYtMM7kg8hd4EC2N22/A65dVV6f8/hwA+HKzC8Dg+1zlP0NUdsgWrN1nRkFRUCYoPHuvjoxr/0Qjt3mpHs5YbKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090124
X-Proofpoint-ORIG-GUID: Qr5dqt3YM_umCRqmMYEva8CcSeYsbsih
X-Proofpoint-GUID: Qr5dqt3YM_umCRqmMYEva8CcSeYsbsih

On Mon, Dec 09, 2024 at 10:33:56AM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241209 08:58]:
> > On Mon, Dec 09, 2024 at 02:52:17PM +0100, Jann Horn wrote:
> > > On Mon, Dec 9, 2024 at 1:53 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=2d788f4f7cb660dac4b7
> > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Points to this being racey.
> > > >
> > > > >
> > > > > Downloadable assets:
> > > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> > > > >
> > > > > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
> > > >
> > > > This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,024)
> > > > bytes in size... and the actual faulting offset seems to be 0xdffffc0000000080
> > > > which is 0x80 off from some KASAN-specified value?
> > > >
> > > > This would be vma->vm_file. But that also doesn't really make any sense.
> > > >
> > > > But I wonder...
> > > >
> > > > I see in the report at [0] that there's a failure injection in vm_area_dup() on
> > > > fork:
> > > >
> > > > [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> > > > [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> > > > [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> > > > [   73.848496][ T5318]  should_failslab+0xac/0x100
> > > > [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> > > > [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> > > > [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> > > > [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
> > > >
> > > > I also see in the fork logic we have the following code on error path:
> > > >
> > > >         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> > > >         mas_store(&vmi.mas, XA_ZERO_ENTRY);
> > > >
> > > > And XA_ZERO_ENTRY is 0x406.
> > > >
> > > > Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTRY being
> > > > properly accounted for, this might explain it, and why all the !vma logic would
> > > > be bypassed.
> > >
> > > You fixed another issue in this area a month ago, right?
> > > (https://project-zero.issues.chromium.org/373391951,
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f64e67e5d3a45a4a04286c47afade4b518acd47b,
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=985da552a98e27096444508ce5d853244019111f)
> >
> > That's for ksm/uffd though, neither pertinent here.
> >
> > >
> > > And we came to the conclusion that MMs whose VMAs have not been
> > > completely copied and might have XA_ZERO_ENTRY entries left should
> > > never become visible to anything other than the MM teardown code?
> >
> > Well if we came to that conclusion, it was wrong! :)
> >
> > Error paths at play again. I mean I think probably the slab allocation is 'too
> > small to fail' _in reality_. But somebody will point out some horrendous way
> > involving a fatal signal or what-not where we could hit this. Maybe.
> >
> > >
> > > > > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > > > > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > > > > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > > > > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > > > > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> > > > > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> > > > > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> > > > > R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> > > > > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> > > > > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
> > > > >  anon_vma_prepare include/linux/rmap.h:164 [inline]
> > > > >  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
> > > >
> > > > Here we find the VMA via:
> > > >
> > > >         old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
> > > >
> > > > Actually one unfortunate thing here is... ugh god.
> > > >
> > > > I think there might be a bug in get_user_page_vma_remote()...
> > > >
> > > > I will check in more detail but I don't see anything that will prevent the
> > > > mmap lock from being dropped before we perform the
> > > > vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_lock
> > > > shenanigans in get_user_pages_remote(), and if we get a page after a
> > > > dropped lock and try to vma_lookup() we could be racing... :/
> > >
> > > Hm, aren't we holding an mmap_write_lock() across the whole operation
> > > in register_for_each_vma()? I don't think FOLL_UNLOCKABLE will be set,
> > > the call from get_user_pages_remote() to is_valid_gup_args() passes
> > > the caller's "locked" parameter, not &local_locked.
> >
> > Yeah I was just about to reply saying this, that code should be cleaned up
> > a bit to make clear... But yeah it's the bool *locked of the invoker, and
> > can't be &local_locked.
> >
> > So yes this rules out get_user_page_vma_remote() as a problem, which is
> > good, because I wrote that :P
>
> The mm_struct isn't fully initialized at this point - and won't be once
> the dup_mmap() fails.  How exactly are we getting to this point in the
> first place?
>
> I have some ideas on fixing this particular issue in the not fully
> initialised mm structure, but we will still be using a
> not-fully-initialised mm structure and that sounds wrong on a whole
> other level.

It seems like uprobe can still connect at least via bpf... it uses
dup_mmap_sem to prevent races with dup_mmap(), but then in no way checks to
see if the fork _succeeded_ and assumes that the uprobe is good to go.

I wonder if we can tell uprobe... not to do this in that case :)

Some MMF_xxx maybe could help us? I guess we're full up there... but maybe
MMF_UNSTABLE somehow?

>
> Thanks,
> Liam
>
>

