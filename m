Return-Path: <linux-kernel+bounces-259981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A161F93A0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58256283539
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269B152196;
	Tue, 23 Jul 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiQRrqkR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC444C97
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739832; cv=fail; b=TBGzi/SEstYhhPkrVqNNWnw0s+Q5U21X/6l6wMVlHs+Qy6MWxOtSNE7I5R8MQCmLKMStUNDvZ9cSn9y5pY+yHNVub8+qZ8vSSa3j2tSU0kA+qXzvHj49pAZzgqCN7ZfWOydS9AcZ8ckMMbLZZwsvoJHyR+fEHlOVvE3lsHjXJbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739832; c=relaxed/simple;
	bh=uA8q30nvDQW30xSMmC4IgSbYQlkKrc4O6X3EqH81ufA=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=shYlNoU19GNeVmX6+mL3SzCQzbdf4+mV6N83fJ6q6/iPSaLb/5218x1UTshk5OvWpV+s79TF93XuQVYogBB+QYCwuXV4+EOTELlFRBqE8m2GUSkyQCPgXVVnAM3gsbkR0Xl87oZ+SGRxRPSI/cJ4WbNzE3jB9U3oYkbvCh2jxB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiQRrqkR; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaYp8vljynh5wu2jext64kKVRHqqAReyMx4tIdv50+YKMf8cAFzE3YbbPU3wrUA9JaDWH/DjwNKUWXGNCfId8AHagwJK315gCzc2g6Rb0VOxbIWIihKtHeg2bYixy+CIye5GFBnL+O4QaDoqv5Hoa5086fQuP2s5eXvi7L3yBRJ2RBAjZpkYCAcz35DL1ey8HJwNgVtS0nLIt2jnbzsm0lG6m2Pa751Wee+WFvZovzgO9he3KAIDn0mNEnL3RizYvVBfLT5FEtSshBanDi8RIH56zVyURQJ9gSl/lmRKevsNd3GlCtbps/EQ4c1cNyCC6o0WlWOEHtwrAMelG/zoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A2n2yVmp1vbDb3dwi/I3H2u00sF+lu4GwqXCbawyzQ=;
 b=vlECkq5fvV/dKn61VJCSDEUwzUnz7rx58jf+6Xz//7KpGmR07/heSBsyseIlJjvq8oulsmEiTWR1Xi5T+H0qndPshKUAqgYzj29FsvITyGUFbp3gjvvizGhncm/gVNFTFD29az7kAHbxskCZP8zsrQP5iWo91BOchBii5SebawdSLP+VooYtQPRMWVhGyQP95NclC/EpOqAGVh5dzFiiFxkXpz3BXB7seKnlPPIiJKaAFLekFHMx/LZ6P25IAZAczdwJ283vV7xOh0Ogt66HId6MYIrZFDta5KRHwvX18DPH7aZYNDQ2IzekEB1Idtxy9C44BT+gUt+UNMPYrdjovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A2n2yVmp1vbDb3dwi/I3H2u00sF+lu4GwqXCbawyzQ=;
 b=TiQRrqkRW7BrkeT25UseDYXUIDg1OfaoaIn4yIABKgmJzPk4VH8/rm8CtnHmzrmzUv3UA2RJ4MnizQFmjTWyvD6/y1n1mHXzTcY0fiBJkqNouUxu3gfOKS/P7oq6+H6w8NqPjGhH3BDIupolmaSzImDutJR65eIY7euU7qfLqTSp8hS/xlmMd7w1fTzQh1njeVg+PkDE7DAY/wwnTArduUdPUwWsJJFiSAaCuFmIZdSKO4jPWPkdfTr6KXfZJBDsHCNHfiLoOHJDlb62VjLvJrZPxDGcRzVZh+cCbMwlvhpI7TNrvuAvxPw+8+64fSqznzDDVqLCZhrlB01JjRwkAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 13:03:44 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 13:03:44 +0000
Content-Type: multipart/signed;
 boundary=bc0195806e1505aaf8d7ad4c2bef81ad0cc3f12b62af8587750d2d8b072f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 23 Jul 2024 09:03:42 -0400
Message-Id: <D2WXTV2186EV.2OTDTPCJSNVN1@nvidia.com>
Subject: Re: [PATCH v2 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem
 tiering is enabled.
Cc: "Huang, Ying" <ying.huang@intel.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>
To: "David Hildenbrand" <david@redhat.com>, "Kefeng Wang"
 <wangkefeng.wang@huawei.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-3-ziy@nvidia.com>
 <5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
 <D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
 <d31b0226-6013-4152-af4b-1526146eb179@huawei.com>
 <1621fcbd-38b5-46a8-8b68-911f2920d52e@redhat.com>
In-Reply-To: <1621fcbd-38b5-46a8-8b68-911f2920d52e@redhat.com>
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a1ce6c-3497-41a5-bf81-08dcab17e1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnhZc2trNkVBSHcvaG9XTndRdTl5ak1ZaVp5aTBGS0VaTXo1M2FaY1RSTDBO?=
 =?utf-8?B?bTZVdnltQ2R1a05Jc2dkQ2xIT3dvTEYxTzZNWkRzRnZ3NHA2NjZNOENwNmlj?=
 =?utf-8?B?MmdlamtWR01KcFJnYytlbjBIUGVpRVBsdWkrdUMrMFIwRnRHanRxNmtXVFZw?=
 =?utf-8?B?QVBIZG9QTDhiYTdCVzBOZkxlOXZRcXhpOFFSbWhYR3pBaXVhdHk4THpMaHJm?=
 =?utf-8?B?RlRRdTkwU1VFdWMvNDUvU29wb3N0Y0J6MHFocHIzODlKV0JuTzNQOXQ3bGs0?=
 =?utf-8?B?TjVGa0xDVXU1WUFLZ08raUNFQWFJMmxwUVVzRlM2NWptaTFrUklCdGJMd0hR?=
 =?utf-8?B?K1BMTVhETXlkK3d2R0gwUXYvV2JWS1BIVzVvVFpnaUQySUl1NDRrUFRTWU9O?=
 =?utf-8?B?eERLT0RPZFAxczNGSmxQelBOdTVIaWp2a1o5cXd3b09jL2hCbTFHYURubW9l?=
 =?utf-8?B?OUhmQnhHRG5PWFpnbzVmeU5QMGl1d3p4bnVFbFljMDh4NjRoR01kUHJCek9w?=
 =?utf-8?B?MU83OGh6K0dqd0c5V1dlR0RXZ2FuZzRrbytUZmgrZkdTcGV6OHp0UjJoUkM3?=
 =?utf-8?B?U0xqV1ErVWR5SXJlL0pGbGQzSnB6NHVua1VHU3hyY2xFWWh0cGQxc3ZkUG5C?=
 =?utf-8?B?ekc2dVRsYkt1Tnhib3VKR2VQbzZWS3BPU21mUWhoMG1yeUFLTmtSUjZ4aWN1?=
 =?utf-8?B?cFBPNjFpZlo0ektlYUZrbGJWdzZPWVdjaFJzblJUcW5VV3laZUJOQ3JhWmwx?=
 =?utf-8?B?M09hTWRMOTc5b2dYYjFVbjI0TDVMOWZHK2JFaEFQZGZIK29CWGtGZTRlVHhI?=
 =?utf-8?B?SElJaEFhU0lRT0lRb1puVDdjYkNpUGZhSFlwZTFhQUtRK2ZXelRWRHVtYXBo?=
 =?utf-8?B?azAyUTB6d3NwajM2cHJ1bkdRN1NTaEhicnVUQVpoVkd1dlpJYUlDcitLWjFu?=
 =?utf-8?B?RHJEdk5lajN1eStLRlpYRGo5ajNwNU9OSFFDOUdQNHh5djJEZWFIbkJwL0R4?=
 =?utf-8?B?dzlnT201QUV5aFNXSjBXVzhiTloxbmtPM0lYd3hQWEdtZTVHQ3lyeHdBdmNk?=
 =?utf-8?B?Mk1YZ1BtNjV2Mkphdk9aK3N5N2hHRmcrbEg3Y0JDL2JqazhqZGd3VjRoRDA4?=
 =?utf-8?B?ZFQ3SXpVNllFSy9Dek9EU0hjeHNPcExGZzV5dUR2ZVAvYjVOYm5vNjliblk2?=
 =?utf-8?B?YmtDT1VDUUtqaHBLa21YeUFvTWYxMUVVbWNiUG05L2NFaCtIdmpqeUtGbk1N?=
 =?utf-8?B?NU9ReVN4KzN2NE9ZOHlyNUdaRUlHby9nWHhGbW5kcEt5Qnl5cXJnZm5WRGZo?=
 =?utf-8?B?T09qVDJ3SUpGdmxGYW10elJRVlBSN3ByUHB0RzNMdDJnb0VZWWZlaGt3dXJ4?=
 =?utf-8?B?OWFSUVZuWFNhUDByK3hidm5wSms1TUlCeEJPWlRFMTJLcmNVdE9zVGYzQ0dl?=
 =?utf-8?B?N0dmc2JBM1hWT25udUdpK0h3WCtBd2ttWllFQkd1RmJPa0dEdlpCRjJGQy9Y?=
 =?utf-8?B?SUp5cVZYdWxiZHppSkdWckVtVXQ3VHUzd1BIY2c5Z2ZDY1phVU1BVUxhYTQ4?=
 =?utf-8?B?VXBaVFB1d2U5ODBXUUYyK29PdWdFZi9CN0JoSG92QmN5dXNlTzNOcDU3NVJU?=
 =?utf-8?B?L0Vycy84bmFlUTEvMk1tWHlQbjBKWlFyZ2hVS2ZBcmh3Q1NoRjdBRCt2RFQ0?=
 =?utf-8?B?aU9MQVBZTFA3NFI1QWJxbklJK0g5NUpvSkVGMWpZaDM5aUZKOVEvd1lUVWpt?=
 =?utf-8?B?YTNqSFZjVTRLMkRHVUV5c2M5YmRqK1pSUTNyRVBEMlJJekhGQml0SThBaFAv?=
 =?utf-8?B?VWJCeDYwcUc0cmxRTkRIZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3I4Nm1NYWpLcEhHNkNBZ3ArcVpydmlJdXpkODZFbTNnZUdCQ2xOb3JaTzdB?=
 =?utf-8?B?MmhRaG10dFZvTDFmNGF4THgya3RnakpscnBkb0hjVnhzazF2YlZudUJiMjZM?=
 =?utf-8?B?T3UwTVpFZU1CT3hhWDBTeUhxY05qZG9iQXZONXBDaE5mY1RRK01CNU8yNzAv?=
 =?utf-8?B?bXVHWmdSUWRhWDV2UGwxSEl6RkZ4R004VW5PeEt5T2NENnJhL04wV1JBYzJQ?=
 =?utf-8?B?UU9tK2djSVNjT1dtSDgvcUw0RUxWa01FTlFPTHhSWDl3dVE0aTNyYXZoVEs0?=
 =?utf-8?B?WEdTR3FlZ1ZPSE9sdWhISU8vSVFVZ3lGVjhxSExvT2I3cWRSZFc4OWkxd0lZ?=
 =?utf-8?B?RjJKY3M1YTdpelhBYnpYVDYzdnQxK24xRDNuSVdVUjJkcE0wcWpLVTU3a2VT?=
 =?utf-8?B?WXgvL0tkblF1WXhUSkFUQ2lqNkJDZTdTdmJrVkZlZ3VjWlJCNXVlOGNCL3BB?=
 =?utf-8?B?a3R4RDl3WGw0WllrNnRYV2Flci9ZcnZWRjIxWTU1UmYvUGdQMlpyMDRKTTBa?=
 =?utf-8?B?UDFSZUJTclN0UXhFbWtVaXhYVGZ2dFBnekRNZFprTWVJT1hBd2dpUkZnWnEy?=
 =?utf-8?B?bWVDdmgvaFVsS0VZRkV0NENUNTZxY2hscko5VXVGR2NCT3ZvRVFhRm1mdEha?=
 =?utf-8?B?dllUL0tqMzlidXNVcTM2MExrWTUxNDVidkFWbW1JREFidXFiaUx2Y2FheWV6?=
 =?utf-8?B?R2l1eVBISE1iVmIvcmF2cTZVa1FOcm45Wm12Z0REbFRGaE9FZzlGYUxxQzI3?=
 =?utf-8?B?dDZpbVlNY3FUZUpWRituUFM2ZEJWRXl0MWYwR0FMcmRtR3hFZUorZ1FTV21Y?=
 =?utf-8?B?UWhUQlVScmV0R1Ywa1BneUJBQktMSXFXaXRzcDhraUtIR0h0eHVGdjd5d0RU?=
 =?utf-8?B?anlyNGV3N0FPdE12MFhvNjVBYWtLNWJoYzZ6c2NNS2ZqMFQvWEVmd0VhY21T?=
 =?utf-8?B?dVpKUUUvbEo3K3BiUXpSc0xDKyt2T1BqSkNOTjdJMjdYaXkvZE9CKytjMDR1?=
 =?utf-8?B?M29Ia0VlMkM5ejBkUC9SQnU3OUQxRld2S2ZNUGUwamNmY1h4MlBrWlAvUlFv?=
 =?utf-8?B?VTZNNVdYK3B3VFlHMmZsNzExdnBqL3ZkQmhrdXAyeTl3TWdYK1k4N1dGcFlD?=
 =?utf-8?B?b1MvZ1M1d05ZZWo5QVZpTnVmOVFjbE92NmNsKzJVblc5dkp2dEowN3daUERv?=
 =?utf-8?B?OXdLS2F0aVZobmR6MjJ4VVladGpieS9ma1hONlVoYmZjNHE2UEFydU9FYVBh?=
 =?utf-8?B?SEhjSHFyT0ZOcXZGVVlXeE9rVmRaMTA5ZUxMcHkyeGI5M3R3Z3R6cnZielJv?=
 =?utf-8?B?V0w0WG1tbWNUbDMwUXlubHpqWVhLQWN1YlI5TTYwekpPUG5HWkQxejZ3S0FH?=
 =?utf-8?B?MHNFNVp5cS9lSXpOOCtobDFjWXdqaG95K0sxMmdLK0orK0pvR3d6bkc2bHlU?=
 =?utf-8?B?Q3gwTTFtbmo4K0ZOd0ordHhBVTFOTnVpOW0wNU5HUTg5eW41N29nMTJaaFpV?=
 =?utf-8?B?NVl5MTdyYUdCOHhrb1VMaUFrVy9WUm9JR2I0cDNjSnB4ZmJxQjhla094d3R5?=
 =?utf-8?B?eFpFcmJ2S29LaEN2UE5TNi9tY3F2YUcrZm9mczhML0RUZnRjV2JwQTBYM3lH?=
 =?utf-8?B?RDFsQlFFNFViRncvbUNWVFNFNlc3cVdyRWNUc2ludFcxdDNKVmMrQXNpcUhE?=
 =?utf-8?B?Zlh6YlpobmF3TGxYWUJzT2pveDVCb3c2NXZ2N2hHMWszQ0o4UUhiS0daUC85?=
 =?utf-8?B?Tk1HSmFHM0dhNmx0WFU0RUw1b0ZEK2VIbG1iZnBOR0l1QVBMUkk3aThCcEZi?=
 =?utf-8?B?Lzd1V2N4Y1lOMkczMEgxa0lHRWJuYXN2MWpYUGluRnl3UVBUNElNcGxKTGgx?=
 =?utf-8?B?Qmk1UHNabXlSdXFXV2YwbHpncXNzZmpoSHorSWM3aGdjWXZuSnM4b24rQ2hk?=
 =?utf-8?B?L2xBREFibHhVdmJtWk9FbVhzNDlqZnB2SytBanFoZTFnQUpWeml5RjJhRVQy?=
 =?utf-8?B?amIzRlUrNUxXem9US2c1d3h6RjlmN3ZJNENaQ25TeDJ6QlZxM3NQajEzbmU0?=
 =?utf-8?B?K3FXV2EyeEZiNXlPdk4xMlpCd0xGd2NQbzQzRVFwWURVemFzZ1VIZzJsRlNX?=
 =?utf-8?Q?+8vjG+qcPT2hqsg8raqc5Vvzm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a1ce6c-3497-41a5-bf81-08dcab17e1ee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 13:03:44.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGjvyoYSIUnr6SIzKVYI3195t9vN5BvLrkgoBYIIpwloraWzaV3Mg83XmbWTjaCW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

--bc0195806e1505aaf8d7ad4c2bef81ad0cc3f12b62af8587750d2d8b072f
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 23, 2024 at 6:17 AM EDT, David Hildenbrand wrote:
> On 23.07.24 05:24, Kefeng Wang wrote:
> >=20
> >=20
> > On 2024/7/23 9:54, Zi Yan wrote:
> >> On Mon Jul 22, 2024 at 9:48 PM EDT, Kefeng Wang wrote:
> >>>
> >>>
> >>> On 2024/7/23 1:29, Zi Yan wrote:
> >>>> memory tiering can be enabled/disabled at runtime and
> >>>> sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used t=
o check
> >>>> it. In migrate_misplaced_folio(), the check is missing when
> >>>> PGPROMOTE_SUCCESS is incremented. Add the missing check.
> >>>>
> >>>> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>> Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64c=
f2d716c1a@huawei.com/
> >>>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint p=
age fault latency")
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>
> >>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>
> >> Thanks.
> >>
> >>>> ---
> >>>>     mm/migrate.c | 4 +++-
> >>>>     1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> index bdbb5bb04c91..b819809da470 100644
> >>>> --- a/mm/migrate.c
> >>>> +++ b/mm/migrate.c
> >>>> @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *foli=
o, struct vm_area_struct *vma,
> >>>>     		putback_movable_pages(&migratepages);
> >>>>     	if (nr_succeeded) {
> >>>>     		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> >>>> -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
> >>>> +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> >>>> +		    && !node_is_toptier(folio_nid(folio))
> >>>> +		    && node_is_toptier(node))
> >>>>     			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
> >>>>     					    nr_succeeded);
> >>>
> >>> The should be in advance of patch2, and change above to use
> >>> folio_has_cpupid() helper() too.
> >>
> >> It shares the same logic of !folio_has_cpupid() but it might be confus=
ing to
> >> put !folio_has_cpupid(folio) && node_is_toptier(node) here. folio's
> >> cpupid has nothing to do with the stats here, thus I did not use the
> >> function.
> >=20
> > If folio don't include access time, we do migrate it but it isn't a
> > promotion, so don't count it, other comments?
> >=20
> > PS: Could we rename folio_has_cpupid() to folio_has_access_time(), even
> > without memory_tiering, we still have cpupid in folio, right?

folio_has_access_time() would be the opposite of folio_has_cpupid().
If memory tiering is off (either at compile time or dynamically), a
folio has cpupid all the time.

>
> Maybe call it "folio_use_cpupid()" or sth like that? The "has" is a bit=
=20
> misleading, because the folio has a cpuid in any case, no?

The folio's cpupid field is reused to record page access time, when the fol=
io
is !node_is_toptier() and memory tiering mode is on.

In sum, using folio_use_access_time() as !folio_has_cpupid() seems
better to me, since it covers the special use of folio's cpupid field.

Let me know your thoughts.

--=20
Best Regards,
Yan, Zi


--bc0195806e1505aaf8d7ad4c2bef81ad0cc3f12b62af8587750d2d8b072f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmafqi8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsnsQAKkhyR5mHxnOPG0lpfvj6v8pinRWOMC3Szgc
6DjU3Pg24/SGnF4yd3CZ09L/s/Fv0ylGta+F6tz4FUBnYj+kn4M2mnowz7NFy8JO
A+u2yjG8n3KK362XoDLwh7TAeizA2+VBwJKltxqumySS2uigDTquiFZev9Mnz5rZ
39PXGedK8HNKVJADy/rlq6WI/UMm8Mdc8g0KnGZtcp4RG5UR1wJSUqk36a54T5Xf
eyfFoBFVqL7g6xIwDog4smT1CyUmVMaf2CJdsyQNpJw2p73lAaImQclwR8492KgJ
e+v58J6+jbKS9h+aerOB4Jb1cl83q6pFm22aEpv9ELo5MFOXvQ/bGiSIlnflLKxL
yoPnNs3U/pZZKhSvaPKCg9a7dqp/x2/sX0LGbxTy5c9pjt7DqNoCX5nOLOHcmvb4
xLPjiftJhrG3IAuz0dITAG8udUMoFM2QOHTZFuVjjhtaf9w1PV3elL2dYTrV585k
8eICFiINdq8AEwQbT8dZRlPMO8baUkBCIaePGEiEwGGcOMp/jQBCPyhaOV3vAO7H
c4+nJ6CAZqXBqsU9cSeCqUaKskmhITYmWiQBqnC2FE4SpQZNNWz1DLhRuHhVlyi6
KW8h4xh+Ed+XfJwnM6PKFa7VLev3kCq3jUQAwUWhW/K4l6AlMZZ31EN+/IIJQfQj
6eUAkN0K
=T9vB
-----END PGP SIGNATURE-----

--bc0195806e1505aaf8d7ad4c2bef81ad0cc3f12b62af8587750d2d8b072f--

