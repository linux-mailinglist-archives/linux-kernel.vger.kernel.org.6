Return-Path: <linux-kernel+bounces-399742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269479C03A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A03E1C2267A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7C1F585B;
	Thu,  7 Nov 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LoEueBad";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OuattNJN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD961F5854
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978138; cv=fail; b=sdDCgQqGztZBSw9Uj/uO/WUJ4035ho04AthZ6ZZM3tBQIZy5TdI+GpYjT6iMbfNiX89xbGIQaTQH0bBruvyiqr9Rphgnxd46M4PCyDyrzRre3Aa5RJoZ1AfMQAhkvw6UXOJWFz05pQ20TjQtoP7HJkGx3bk99JJKi08UdiW7f6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978138; c=relaxed/simple;
	bh=vozfmd4t9nAQi4qKmnt7iznlxGphY7r55WLgXtYX0Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A3b8ZgECTHq1SaIRLHa8VdRvEJScjRENRi+p4mB5DsZ+weOlN6EkATQMuuoGXqteaX408FUNwk2Yv/Iq7AyykBiZikAtYaVaLDSTwCPbjbf4H3gfvez2+YTou7/UV+5HXjJXUxyLR8UuVihyJUDF1jEDgXbe+jvFyrJIuujGmKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LoEueBad; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OuattNJN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71fuHS011011;
	Thu, 7 Nov 2024 11:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7rP6j0eJR0TkWg8PIJ
	sxzo+NhLzEEY6KZdzKeZ729JM=; b=LoEueBadT9WhfzQ/a9CVMSGyl5E+WJYtwa
	+owUGgoTXZ28oYnkgZ3VSjdK0tcdYNfiv9slvWpE+EoOFqcj+pnwSdmEWHfURcpB
	DWYqA4j4DZsPgYtyg735neIdYsv3LfKsdCgb5XUnxj3y+AWp8HxqGqoIRn594sEi
	/rsjVnUs1/H0U+sB1XDhDeJmhG8f4Q/MD8tlBTwVaPTBgN6rGcBMrFvhFcgkClA2
	knqIuxyX4Xi1/fdxuLNjjL7PzXXle1EKl69yhM/HV8sZrvjWuIuieg8aLEROwRGh
	4YQSb+TQM3V31FGf7EP4PKpUEttCYXRVxD8AMuCAzRRM6WyyF7wg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagca708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 11:15:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A79Aii3031469;
	Thu, 7 Nov 2024 11:15:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah9kbqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 11:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L93ZUlN+WkUaCKeDo38gQA+IUhWfB90QFzBOPVkOQvz1lsqCzprIT3KjfHUzZJDkq5NOyNt4QlMUb1Wyac+lBEOd1WKWiW5vQEqP8u9NTDeOHfeZyI+bkoqc3c2ckCeF4f1BN0rh7Jbb0XDvwG09I6ewB2fijMQPl3XGevbbPhZL5zeFghykqj5HRLgO1P6cf4dWdtVAlP9iZPDKX7tjGg2aPIkPYfQwa/F/ijRI3S1cM3/JeYiTN0qEcAXryVih4iMVWdzESA0eZARLvsGbf3ePbpHyGIRoW4BUvAu8ijWaBonGTL9gANFz3loqE+tymag8+ppSEehMeUtGFFzZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rP6j0eJR0TkWg8PIJsxzo+NhLzEEY6KZdzKeZ729JM=;
 b=L4BqVwqWymX8QMK8FCp6yq5JNJjEn+j04PukdFOhtdHHBrOVOhLCb5m7V3VSS4jnXYjMbTZcZSNkp0ANjr35DzF2ODmzxatLep/BhWq8yF1sjrp7Yhj1IQwwupwgs7uIilPbAqeQT1EPh8hINzlfDNwSvDH1ejOkuyuL/gsLKzrwN6Rg1JCeLviS4xOf+Je8oc2VsInLHIVGF1QnMXdZxb5JRpionTk+Jr1SafgaSMizmqd0nFI+VEwgWMA9aKVoUkQA1kXo+FZK5H45W52CPi9Nn6NIKcTHpFGH/w6S1IUBLurfKj7oyx62qNv+fnyWu8HfpD/elxNnPEQ4N5eahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rP6j0eJR0TkWg8PIJsxzo+NhLzEEY6KZdzKeZ729JM=;
 b=OuattNJNJe9e2xnJck66loy85dmL+SWS3IAO3PPfxAx+8hHN+XslHnGlVZeq8LyUT/4/BnnM84m/3wz6hxj8fYM0mttOR3tEBBgYwL5AahMTivDUZn3m+jBdpbPyCS/HyGWDHXjVWoYPTxef/DWmWK0xP19tYHBUZdBvl852oJM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5581.namprd10.prod.outlook.com (2603:10b6:a03:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 11:15:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:15:07 +0000
Date: Thu, 7 Nov 2024 11:15:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <f2c8e125-8436-40dd-81d5-5bda786d54a2@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <20241107110717.3441-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107110717.3441-1-hdanton@sina.com>
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e08ba9-e83b-42f5-8f33-08dcff1d6f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnAwbKnyLaLoFj2mG2pzzPINrQJDc2+qGSxQI49NrWCTUZ6Dkx0h0P2gCxq+?=
 =?us-ascii?Q?rdA1SqiciiBO35opXgwngUpdvqAQrwa2Jsro54sO4MgI9v9l6yyEj1E4akoU?=
 =?us-ascii?Q?wCVodx6RgHcp9Oo6gHHbvCOjtnq0XusOZcSilXylZJnwXaqsNMKUpY0VcJZh?=
 =?us-ascii?Q?nnMR3nf0YfMLdmsbD7ToVromK6xCmp99k10Nwbhv4oigsmBtpb7H0+mdkpqU?=
 =?us-ascii?Q?pkFpvoXs27Is5XUG2d5k0qDr2Q9Lr/Tfi1rOGCZ5Y8rImiO0MSoiL/Mfzid7?=
 =?us-ascii?Q?MN83ccxbWlJQT7WNZwJQZ/6BoL755i+IvCJ5zo6hQVG7MqEdA9aWxGtXKsIt?=
 =?us-ascii?Q?8l9XyU/VT/y+s5waQZVlSN6ETMWssNSVOtJkOL2xdGWreT3ElACfKE57TTnu?=
 =?us-ascii?Q?ObA42av7PkoWGarswcWPPAQdYTM2pHZ0YbDTRNeksWDarQxLFk5vJSKsnllb?=
 =?us-ascii?Q?6WSrxKvtIRIAUU4qm1/daEaWvPhnoHx50SzXUN/5f1+HgmcFoXCmf3POhPsB?=
 =?us-ascii?Q?LIq/2rsAacyZiOVDx6Yoa6tEhPnhMqXfGRHBP72Yo7UoUMrgtohpr/HRXAQL?=
 =?us-ascii?Q?hTd7PPSVQC0Z7Oo0kzTtICjhJrziIKLbcVMKRkvWL22y62TrgCIsuNXdwL2w?=
 =?us-ascii?Q?Aj0z9UuTYD/z9ES9Kpi1SRk+WycaLifJsRgbAx1HSUA3E81/FeJjVEDuvGda?=
 =?us-ascii?Q?F4rfLA8ceqZGHNcyDjssaDGa/HoAttCbBiCZDhu5ifW//bIuAP8/U7+xFkYl?=
 =?us-ascii?Q?r3T0g1teT1E1crFksf7j3+wEBcQuoGXOiE4UizWYi2FGJsrGNQ6kCxOwa8fw?=
 =?us-ascii?Q?o/hF1j8gOqM2tnul5Czed9bK4Kwln3CI9zlT7mgnZr8WQzkeW8stftrVDuJa?=
 =?us-ascii?Q?zhUEVphrYE+LTy8yaS9oNLoMqCtYZ+MlyMpgvyAnRvFrcsGT03R3ZOe8+Voh?=
 =?us-ascii?Q?jPKx/e91lDqc7H9gYyKoakzX7SzJuuhiTy7ICvQmFJjpK6QTaihSjEXwgTVW?=
 =?us-ascii?Q?YpqoiP02cBoeBDjvSkm3KQ1a1eEbRpg4qbHOOcfLBSOQo7STDizeWkDid0D1?=
 =?us-ascii?Q?0GeTfN4Gm4Rvw3oADrQDblQMEAO1zvV857kqmyuXhLxz56ILufYE9LcVLAyf?=
 =?us-ascii?Q?mrlpmDnOT0tv2OJC22VI4gFmt3zKQqRLbhqxDjdnCI6+fS9iWySQTKw8WmKG?=
 =?us-ascii?Q?4gWDdbWrZTrVUXb7UUX3y4WOqW5wBsHUphjiv9nmQIJsDEQ6DCiAuuYnxN23?=
 =?us-ascii?Q?cJjq3ih17O+/hRdzdbixMFzCHGHfM5O2bm10NPSiEenVGLhap7hGH8ySj0zP?=
 =?us-ascii?Q?+L9mCPvZgk6MIFYiRsHtMZb0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0L1WkAu0OHywysAtZZ8IL3Cofqjxq9Esn1CoScUl8Zsj6J9ZH4BSIlFyh9Dj?=
 =?us-ascii?Q?sWRaotMpiO9TCfPuWgbf6BCbKA1RzOGaLWyOVtDBwb1Y8fAPKjlizsvdN25V?=
 =?us-ascii?Q?fa1TSYxri3LjKspk24ezXwhEHZg5k+mT/A58lPY72B4jiyMY8IcDKZXgCmJb?=
 =?us-ascii?Q?0M5gBNyPpueeBdL8OA4blZDwUaDzgJt8h1KIvDfOqxnZdcDBwa+pi/tZN0Um?=
 =?us-ascii?Q?KanZa7FUUY6l3JI71dbMT+nur2AngTu63d897xhJf3HO71LIiv0r+UE8TcFW?=
 =?us-ascii?Q?pmc9t4Q2+Wdheih8Cj4UlpgggM0C29BQCqAUYPRd3Bee+t909i5VV1SUyTge?=
 =?us-ascii?Q?82umL6IA4jGQSQeqx+lqT6JAleVM29kzEE0FQSfrSoTrQGsHx3u39HcOsa4W?=
 =?us-ascii?Q?5yhIPpfuzd+ex/eSd5pbXHIshnVhc2vZOg9ibLBMJDfXmLwvVj609TdMm9+1?=
 =?us-ascii?Q?aoGm/1XkTvc9v8WOu51g4bRqQfk6zL4weC6Grx0KjXuTJecRKnhJKKMFeSys?=
 =?us-ascii?Q?2Wjbdv0yTyp7mXRq3/M08L4OFsB7p/17fM61jZJizgo6DJtZ/EOawuSDQSnC?=
 =?us-ascii?Q?8n3ukalXiJG/9wdD11ncwvnIQ2Dwc1GNjHbNus2IEw+hq5dkXTAVUj9hKBOz?=
 =?us-ascii?Q?sAXU82feyi12PD4t7DPYSrcCVkaCyFXAzHstKGAWPII9E3BXJv6+OAhpasVY?=
 =?us-ascii?Q?LntwAiFn2N4v1WmeTaLo4VB7g+B/YcAxBJDpNhUqpU19UAtrddN3HfLdwiYZ?=
 =?us-ascii?Q?8BkDQDdWZ48IapaXJT9FhKpEeqwh47uUkG3A1o7iC6H+q+cClqK51XoC6+GM?=
 =?us-ascii?Q?cuuMWVZwuVFzSigM1mGFlPyo245kuIOCNMFeeGY3wXe7SjjfrzYaj1Qj6OIN?=
 =?us-ascii?Q?qvc7U/p8+3clwgNTKQsGTfpz49RF6hU0uTlPqPwghZA5AEjrmzRHzGB5noHw?=
 =?us-ascii?Q?3iQGPqQ3xLxEPhOgaJ0yuacAH4OQltNmmVdyLwcS7tbrkbRp4Q0/xL9LWvAo?=
 =?us-ascii?Q?bQuJlsG8T1vl8i/Y8Baywkkx96UyeL6QZlRaocQS6lhmgOAHAfs0PH7prYg8?=
 =?us-ascii?Q?CTl0S2FaXedfN9QI5+Ygj6u80fJ3tdkyP92OeKBO0mxEwmlxLwVZDqDQyrjK?=
 =?us-ascii?Q?cHQKfrswXlGwEtZ9kV5BB+ptoAGpe7vGvIpb6MzNMxSER5G2Tr1mLLRRkMfI?=
 =?us-ascii?Q?ZKN6LMjw60F20aV4BMZ7T7crF9GCzlPsq4LiMVihttFAELiUhBTdqmng7jIa?=
 =?us-ascii?Q?gUBIzwmMPKsDS28LGrkhE2P2IJHimrPMEwrAF7HZtXvVsC8fRdQY0H4vRJFU?=
 =?us-ascii?Q?KX7HihdNiGoVMeqkLhQmEP/5gbS+zEktmk4ZHIJ1IxgmdlzPIRaLyYTtwW6R?=
 =?us-ascii?Q?nIGR5RJxhfFwjy+tjj/8aOVJLF+SvTogmN1s7ilIKpRfno+EQy9Ey+a8Cule?=
 =?us-ascii?Q?doIG2rdnY9rMQE1KP3AqtE6f1ZTn52Qf7f7Cr5T8gbEGRKZ2NT7w9mjcYC6G?=
 =?us-ascii?Q?kWEnSOpQY8S6B0cmkSIfXZ23qd3wn6WLdR4XRVFGtPo1Ks42UgVCax6Tw3eI?=
 =?us-ascii?Q?9a3Wg7X8NMofOQdZKUHqO7tcXYQm1nFG2UL8ZHQROpZM8qz41nrfguCxKQkf?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LxQB8gJUcZ0WzTQcLXi45U+CjGbcMoijuGYZFsyja5XLxe7YdYeeK6Da9zO8OK4el1/WrVz8B4Ab96c9VHqGSsijZmxOIP/cqwT5GvYtJk6byn575zhvmP+YwfAQ1p2AGtJGlle2g95PK1+tAF5ukZWWRMmVmE0/cDY58jTnr84ZDI7on9HOdbNlo+XvUoYU1X1NCOouvpYyCoCxDIEBzu6p8hK9huakodVNZDdxMrlh9J8zVOTJbxgcflBoiKh2JbPko0fVf9GuzV+mAG23jdt6FD9b9/JdB7rhHf3YSqP0zdxEk201F6HarOsP/QsgRlVp3K7HzdpYjSfI7bB9BLGh4TAKTtxcpQdd3s9zx56roGt525EFq38+EgEJrE8rhO4laAu+flM/mPznZGcJ4mpLXEa3vkmRg10iACDlIknPcFEXaVfxTceSWKd1O7TcgdyogP/TCjyZJN2cBdW3zdmqGGdPDM9nsPgBSHKKJBNNvGSd/YR43i989VaonyCXJB5CT8ZzsJYU85d472Uz42RxxWnVXcvksTavYkxiiRE9ptHHoyoqRt8EOnLHFuFkXxu8hJwIv+QyyLrHpq9EqkG0F+Zseptkg1ijCF3DJIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e08ba9-e83b-42f5-8f33-08dcff1d6f7d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:15:07.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PO4sdlriuKlMClvUfoyNJQIS+tDdyt/k9MywiFlXkBtF97/AaD/YF+sgvbsdMo1fs9RPm4XfkmMeOl6xR6YNcIIpLlB+6IfhIcCyzbMn4ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_02,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070087
X-Proofpoint-ORIG-GUID: wWdxy37P9Lj82TPt5Z_bRatt8zBrKilE
X-Proofpoint-GUID: wWdxy37P9Lj82TPt5Z_bRatt8zBrKilE

On Thu, Nov 07, 2024 at 07:07:17PM +0800, Hillf Danton wrote:
> On Fri,  1 Nov 2024 18:50:33 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be interacted with when it comes to interacting
> > with mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards efforts to find sensible
> > abstractions for these fundamental objects within the kernel rust
> > abstraction whose compiler strictly requires some means of expressing these
> > rules (and through this expression can help self-document these
> > requirements as well as enforce them which is an exciting concept).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> What is missed is the clear guide to the correct locking order.
> Is the order below correct for instance?
>
> 	lock  vma
> 	lock  vma->vm_mm

There's a whole section on lock ordering (albeit, a copy/paste of mm/rmap.c
comment).

However I do agree that I didn't put enough emphasis on lock ordering for VMA
locks.

I'm working on v2 now (aside: my god you won't believe how surprisingly
challenging it is to write docs, I mean you'd think I'd know after book but I
forgot I guess :) where I put a very strong emphasis on this locking order,
including reflecting Suren and Jann's input on read mmap lock vs. vma read lock
(you'd probably not want to bother with vma read lock if you have an mmap read
lock, but the latter has to be taken before the former if you do - the other way
round is a deadlock).

The v2 respin puts a much stronger emphasis on separating a top-level practical
guide to what locks to acquire and where in what order vs. implementation
details as per the valuable feedback on this from Alice + others.

So TL;DR - yes agree absolutely and this is made clearer in v2!

