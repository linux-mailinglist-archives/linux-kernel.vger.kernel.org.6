Return-Path: <linux-kernel+bounces-551645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D8A56F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A8C3A9052
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463523FC4C;
	Fri,  7 Mar 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="r8sqv57d"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71E2940D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368884; cv=fail; b=aew7m5QHbZs71xkZDaBjsMCDcKA/Q5x1qMEn+MZmZ1HSF5E7AxEbZLtShX5jG7qWMfraBO9wA1qdG+wurhyp5K5V9YhMBpFlxq+nJ64LAjlm29uoxVU2o6S3mxz/WEDqBM3I+MIRBhi4Lrx8v7W8S/E/9ounlSKkh5jrwU74YGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368884; c=relaxed/simple;
	bh=2hXFjRROx4dZP3n3rd9PNpOFzKJXpridDyJbgTfHpvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvOmujJJzlMt/g+ez7l7hAl/FdzchN29VQg21P/5oZWJxJ5b+bfIZVGPS8V03RfNCI0Iqbe5RYpZSGmqCFKN3HrXRfdn4scnEZ6K708kfrGp3ESb9AxGtOIPEk7ChbOr4MtbO5qpQ07NJ+bJCdxNAjvDl6l1z81aCfhAE/FT7hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=r8sqv57d; arc=fail smtp.client-ip=40.107.220.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT6wFlRZTDnB8LKsUHAFhfy0Y9j0Q5Xh7BfE55iBX5keg6pDGW8w9krkAfAEF3NwV4l8ECSnma711Yy+2wSZBi1Bhc1RbrUSbcdw5J0JVyOjg7EPnLoSRBrvFMk5tuFHY9mWKtAtxkXS5TY2U6UsfD4Kh78or/N5cEDZXauTQZmxhu5j3Hy9+KAa7qAiQRJ+ucdhZsMlITsby3NhEE7Av8V+cfB25cBheg8LBtMb2gEhK5b6Z6x2gBDsbKZhdtlMtG7/201C07PI11JDYae1jtxT577wcr/7Ohs81fQJtRSpwbxDIU5AEkHBOSjc08mOrQQiKkxw11EJLHHwmpsIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHME40vjuaI1T/AGDiy2EbjIPe91hjg5WB/YTQu80cw=;
 b=Djq54EpzZGsWRh3qo8AahQ6gk56KcvmYCmiDa2BQjKJdJ4tV8a+qQnhLJoLHCJU0GkLVGIMARmkpQzJz4io23Ws/aULI+88zVy2jFiHTKYUX+a5V8oOu4MI2tAap8DIDe36tClurI5MuYx8eoHuIdN8QRt50T4o7aZVk0+2MEydwIeGyTDYsK6fMR9XfTv228G/Y4mFCEypQCNneUeaJzCQ/XXOZhRq1nxjkHiHxqr+g/ABLmu6kg7KrdhZgO70ey+ET2IbiByen7eXYPnR+RI8ilgkcmctK2LKgFeVNF9WG5kGtXDihubVlMxCf1ZWgJwfQD/fckWweHZhXi5MVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHME40vjuaI1T/AGDiy2EbjIPe91hjg5WB/YTQu80cw=;
 b=r8sqv57dRJeUT5/ehYc/D/9Y5HmYHvYLgm+hgFPPnCpfTvfnB4FbZa5eoD4/HwX6W20t1Vs7lSVBXlISidiwmFjjXwu+sax2HCGJbeXMmYryMJKqiIKIk5z6mQH4RbxZ3UZdTXeNTBnOAXgxNEY1USxeFXyUPCP8mKxxsKSBOyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM8PR01MB7160.prod.exchangelabs.com (2603:10b6:8:6::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.23; Fri, 7 Mar 2025 17:34:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:34:38 +0000
Message-ID: <fab81387-7f19-4a2b-b71d-1fa6e0a08226@os.amperecomputing.com>
Date: Fri, 7 Mar 2025 09:34:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 oliver.sang@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250306214948.2939043-1-yang@os.amperecomputing.com>
 <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM8PR01MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c391c8d-8285-41ff-82f0-08dd5d9e55a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0oyNnBrVXN3SUR5dk1NeXZuaDI4WERNVm42Vy9XcGhiZUVDRmRMZWU2cGEx?=
 =?utf-8?B?THY2UCtLNUVkK0xaYkhuTVYxZmJXd0lLcitMNFUyZTJFUVp4MkRmNnVHZUZC?=
 =?utf-8?B?eHZoQnZHVFRyR3VzaldEZ3R2L1ZneXJHNGVhNjdLczVRNnU3SFVtS3ZFdWhu?=
 =?utf-8?B?MVZrQjVMR1M3am9PeDliTE5HOXhxc3FZeFNJdXJVK1lIM2s4NTJ0Vys4SXpF?=
 =?utf-8?B?UGtTWmloQUFPaW5nTnpObmlWcVRxTFdNbDVtaXNEei92UFlzMVlrNjRqR0p4?=
 =?utf-8?B?WHBuRlNKSVhNTzBsb0RWZW5tMnlaRHRlRk50R2o4WVVnMkhrYVlOSVlDZE5a?=
 =?utf-8?B?ZGdzL1htS1pBcFFwUEhFYUhaZmZVWUUrc1JNTnVwdGFSRUVjSGV6bWhyVGNz?=
 =?utf-8?B?RzEzQ2VxbDg1L2F6Y3AwMW5NMkZad0pYSXNLalY0RnNVejNocTd5Mmh1aXVr?=
 =?utf-8?B?VjJlbVJ1czZyZzl1MDdiOXFISlo1U3lSU2srQU0vM1lGZnA5T283MGw1MjMw?=
 =?utf-8?B?QVMvZXpxZ0NnUjNIQ0tHL0ZtUnBKM3NpaDhHY2dmSkZLTkJhOUZCYUdxNTNR?=
 =?utf-8?B?eW5IUlVpUkhDZ3pnUEJHUHI4ZUw3cXVzNFR0TkNXa0JvQXV5VFBGMzBBNWha?=
 =?utf-8?B?Z2Y4d1RVcmFzMyt2NlBOcFZ1SjU1bTdPWW5TZnBYTFdmdjVzVTZJdnN2Y3U4?=
 =?utf-8?B?MFNQNHovTjNReFp3MTlsUU5QYTZSYmxpNzY4MXpxdUU3QW5rUkJPOUNIOFBG?=
 =?utf-8?B?eE1FTUlaTnA1Nm9pNDZ2V2ZvWUZFYjNwR3plUFkraWszR0k0S2xURVp5bmZ6?=
 =?utf-8?B?a29xZktGQnZqVWJEWUc0ZVNOR0Vlck0zNDVveWJMUUdYcFI0WmpQaHBQTTlX?=
 =?utf-8?B?eGZYWnZ3UzBlSS92ZWNSWU83RXVtUTVTRDFTZVhmZ2dmZ3hsL3ZpQVBXTTg1?=
 =?utf-8?B?U0pWTFNiSy9QMVRFUHZTYW9mZGVnZFRTbkwyLzJXcFlhSjhocFM3TXZjMzNE?=
 =?utf-8?B?dkt1MkdKQkVVVmtCajdUcDB6bGxSbk9YY0l1b3NOTVhyeTVqVGpZY2xjNHBi?=
 =?utf-8?B?c0V4WEI2OWRCQXdPUzllRlUrSURraEpMUm5DVmdvdm5nbDBVQlRaL0dySmlP?=
 =?utf-8?B?eldPQ0twNWlRdW0wUk5hdGJBb0V5K3pWNTFIUzlIZ2s4MUduV2pzNm9zaFg0?=
 =?utf-8?B?dzBUaDk4Y1FHUDgwVVN0N3V6ODlYaCthV09WYm1CMjFGY0xtcERDU3pQVjNy?=
 =?utf-8?B?MFhrYWd1MEYzVWZjZ1hjeTZLZ0IvRXhrazUySUhUU0J4NGcvQmpkemNPSXI5?=
 =?utf-8?B?K0ZlclVTMWNLKzZ0SlB2T3JNSXU5bkt5SC9MZDh0WEtlNU9HMWpUbU5nMFk0?=
 =?utf-8?B?UjgyUFFlWDdYZE0rejgzQ0VHeVBJU1RtSGVYYUNXN203V1RjbXVTRDlhQXFU?=
 =?utf-8?B?VXgxRmdEM2QwVXQ4V0xEejU3d29TWmp5YXRreG1aUkxneE9tMG5ESCtlazV0?=
 =?utf-8?B?bE5Xa1RvSysrZ3hzSFdqUy9BWmMrM3FnMjRXamh6Nk00WXNhZ3VNRlF4dUxD?=
 =?utf-8?B?UUVoeUl1T241aE1qcStJeFJmaEIzSVhLTkhnTGYzd084ZXBpSXZJRHdURFhD?=
 =?utf-8?B?cWpVYi9ZY001eHdFY2gvWE1MN3RneS80UUJEZ3hDWWVHTzROTTgxWTlhdWlB?=
 =?utf-8?B?UXk2ZjR5eU5sUEZ2TVBMMHBmZ21qSy9OR1VRRS9uRnFrVFJCMEd6L0NUZjFF?=
 =?utf-8?B?djlBSjFxL3FwM0xpN3lBYWRxNEl6SDBSQWVUTmRHM0pwR3g4MHR4d1ZUNjZ4?=
 =?utf-8?B?aEU0RzBMa21EV0d4SllPZ1p1V1BubkV3MkVRWk11VmxvNndQUCtmOEExcnov?=
 =?utf-8?Q?x/GfnjsY2trHj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXJJSW85WU81SVdCbDU1SGJtQnp2bnFicUI1NU9QL3pkSVg0RUh5RFZudlQr?=
 =?utf-8?B?NjVGczU3ajcvSWprUnBNTGM3RllWNkIvWnN0ZHVnVEtjSmpTQ1hGTkdRWXpK?=
 =?utf-8?B?OHozNmg1blNmTTNUc2lOYTBxc3BVUGs3MkNadUZJRFFMT1MxMWdldmlVV0wz?=
 =?utf-8?B?Z1Nic0RoNk5YUHo4U1dZT1Q5L0lkN2dOMHJlU1U0MkZCN041NHhXU08zWDJx?=
 =?utf-8?B?SVMvczJ5TWs3K2ZxSDBMMFFMc0FobEFTRis5dHJ2cmlIWVlZbktpanFjU0Vk?=
 =?utf-8?B?UExxZVV1aDJhZHQ4dmw3NEVLQkhtZFBEYmZIVzRsZVdJY2Izb3pOVUhaNUxr?=
 =?utf-8?B?cUhGL29ENjIycmFrOTFVM2pYbjJmRFkzY3BxcTFZVlpWaVJ0ZElLdVRJNFNV?=
 =?utf-8?B?T0puN0NxakZWREMrWXIzaXI3NUNkN2pSWnR1YVgzcmdwS1lLUi9JdkhhTm04?=
 =?utf-8?B?TTdpQUpDcGwwT0FYQWtSMTFjakN2Z1BmL3hZdjRQdzQ2YUkzWUJnMStMVXhJ?=
 =?utf-8?B?bVNTM254OS9qUlBUbVA3UXp2WWhwaG92RWxpL3R4VnpSYmpMZllZbmtFenZZ?=
 =?utf-8?B?bk1hSHdLeTlZaTBZRWl5ZVN2dnlFVDNBNXBNNFkxaFJmTGxPWXVTbUxxVnhT?=
 =?utf-8?B?TENpYSt4dTNXZFk5WjNObzRYSjl4ODdjcFFKUlpZQnpRWHNGQk5Cc0hXODZj?=
 =?utf-8?B?clZUTjZGNEJ3T1hqVEVIZUkrTGpURjUvMDZEbHJkZzcxVGlJdU1SSXFFcVhZ?=
 =?utf-8?B?enZNMWFmVGFVWTlRWmoralB6YVFIQ1BqL0tIZDdvVVk3RW1YVVRxdHNHcW00?=
 =?utf-8?B?Z2NJVjVUM2JwRlBCV05HbStiYmE0MUFNR3JPVVg5SUpOQXZKWjZZMXFITUNr?=
 =?utf-8?B?c1pZQ3NJSFNYd09TVG10L2VXNklsWHFIZXVvc1FmZ3QzQUdaV0MzUy91V29I?=
 =?utf-8?B?TElTSVgwQnFzajI2NEllNWFIb0xEOXpDZnpVWDJycGFERk5FZ0QyVTVoQzhY?=
 =?utf-8?B?QTVINlI2SjhRTFlIbWRjc0xmUDl2N2oweDRtU1N3ZWladmlVVUVWZGN3YkZz?=
 =?utf-8?B?SGU1bTlDc1RnUmRXUHV3L0pmVjNRTmVlSEp2bUxCTUwwcTdYeGw1d09CWnZk?=
 =?utf-8?B?aDgzNTQ0UlZ3Z0UvV29kWU5zZ2Y1VTM3VG9xVklhK3ExbnBoSUFCUmZOcHVR?=
 =?utf-8?B?THd3MEVQWVQ4QlhYaGEycnJPYTN2bVVHd3huNHRkYlBGWDBBY2Y0ZitWZzk1?=
 =?utf-8?B?dWY4VlJ6SzViT3VXc2JaZGh0REhSdyszeWtCVFBxOENmbEVLMUxWQWdQVy9D?=
 =?utf-8?B?MVhYVGNqbEJheDZ2SlBBa3B3VUVNYjBReVJyMkQ3S3RqMEw3YVhMNWZVU0lN?=
 =?utf-8?B?ZlNqQzZNNkhrdUcwdlpCUlM0U0dJMW0yMnMvVVpoY2QwcktiTU04WTNZK25R?=
 =?utf-8?B?OW9VOElGNURZQ015aGtyUWRPUHdZVmpkdDJuSDhaZjRkMURWUWpicTMveU90?=
 =?utf-8?B?QmJmckcyTVloN253Y3U4dUdLdHF0WXA0c3BFRnE1dGJRVzdKMjRSVXZWempp?=
 =?utf-8?B?bzBvazdHVXptSnNISkt0ejhYN3BWZ0ttRm5EVjJ1UlM3dk5FQlIyVXowQXl0?=
 =?utf-8?B?eXJEUURJVmdjeTV4cUFGZjR2a3kyUnNudG1ZMnd0L2IwWnJnOVZDamVMci9G?=
 =?utf-8?B?QW9oZzNOWCszSmFOdmFwWkMzT0ppMmcyZFc5VU9FV1dvZE5VeUQrUEFCczlX?=
 =?utf-8?B?THNRV2RCeEhjSzVwTVhPQjRIZng5NlpmNXdVRGFrajNrQUVaM2N5M1VoZGZh?=
 =?utf-8?B?blFPRld5Q2s1TlAyV0w0S1BLVjhtYjRYL0pUTHVDUi9YSmhtU0RMekpKL2V2?=
 =?utf-8?B?a2FpYTZ1WEJveDhDZUpSQjJSVkN5bm96Tk4zYVZvY2pMYWxGMUJiUlBMRnhK?=
 =?utf-8?B?SFpEYzdnajdaTEJQVXE5aFBxS2NlZ3VQa25kYURMZ3dHVC9JTVNORGhVNEk4?=
 =?utf-8?B?Qmsxem9CZUJINWxWc1lIMWZhT1VWckFqbmJNVXZtOWE0d1J1SEQrNzVRcXR2?=
 =?utf-8?B?UU1HRW1vWWxJaEtJMVRPTEhzVURZbVFiSFdiUk01VElKQzFHeEhVajd4T0ZC?=
 =?utf-8?B?SzBBQWdwMXRhUXpyTnZobXpjNW0rQ0VqbUVBcDFESkdnS1JRQklVWUw0TXBh?=
 =?utf-8?Q?AjASm94YOaF2F54vrpQXnJA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c391c8d-8285-41ff-82f0-08dd5d9e55a7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:34:38.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE04HbNL0FdzrgC1PRm1LuJl9PqDxU6sfz1XJSNftqs8OT6lleHtDRWTg03BZ/4UTZs6jMrrcAJDOWg3/dte1X36FtvYwTRYxwrruC4kbfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7160



On 3/7/25 5:12 AM, Lorenzo Stoakes wrote:
> On Thu, Mar 06, 2025 at 01:49:48PM -0800, Yang Shi wrote:
>> LKP reported 800% performance improvement for small-allocs benchmark
>> from vm-scalability [1] with patch ("/dev/zero: make private mapping
>> full anonymous mapping") [2], but the patch was nack'ed since it changes
>> the output of smaps somewhat.
> Yeah sorry about that, but unfortunately something we really do have to
> think about (among other things, the VMA edge cases are always the source
> of weirdness...)
>
>> The profiling shows one of the major sources of the performance
>> improvement is the less contention to i_mmap_rwsem.
> Great work tracking that down! Sorry I lost track of the other thread.
>
>> The small-allocs benchmark creates a lot of 40K size memory maps by
>> mmap'ing private /dev/zero then triggers page fault on the mappings.
>> When creating private mapping for /dev/zero, the anonymous VMA is
>> created, but it has valid vm_file.  Kernel basically assumes anonymous
>> VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
>> rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
>> will be inserted to the file rmap tree, this resulted in the contention
>> to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
>> to insert it to file rmap tree.
> Ughhhh god haha.
>
>> Skip anonymous VMA for this case.  Over 400% performance improvement was
>> reported [3].
> That's insane. Amazing work.
>
>> It is not on par with the 800% improvement from the original patch.  It is
>> because page fault handler needs to access some members of struct file
>> if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
>> the same cacheline with file refcount.  When mmap'ing a file the file
>> refcount is inc'ed and dec'ed, this caused bad cache false sharing
>> problem.  The further debug showed checking whether the VMA is anonymous
>> or not can alleviate the problem.  But I'm not sure whether it is the
>> best way to handle it, maybe we should consider shuffle the layout of
>> struct file.
> Interesting, I guess you'll take a look at this also?

I looked into it, but I can't determine what is the best way. We 
basically have two options:

1. Regroup the layout of struct file, for example, move refcount to 
another cache line. But I'm not sure whether it will cause any other 
problems. This needs extensive testing.
2. Put refcount in a dedicated cacheline. Currently struct file is 192 
bytes, a dedicated cacheline will increase the size to 256 bytes. I'm 
not sure whether it is worth it or not.

>
>> However it sounds rare that real life applications would create that
>> many maps with mmap'ing private /dev/zero and share the same struct
>> file, so the cache false sharing problem may be not that bad.  But
> Right
>
>> i_mmap_rwsem contention problem seems more real since all /dev/zero
>> private mappings even from different applications share the same struct
>> address_space so the same i_mmap_rwsem.
> Yeah, lord above, that's crazy. Again, great work!
>
>> [1] https://lore.kernel.org/linux-mm/202501281038.617c6b60-lkp@intel.com/
>> [2] https://lore.kernel.org/linux-mm/20250113223033.4054534-1-yang@os.amperecomputing.com/
>> [3] https://lore.kernel.org/linux-mm/Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020/#t
>>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Thanks, this looks sensible, other than nits below, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you.

>
>> ---
>>   mm/vma.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vma.c b/mm/vma.c
>> index c7abef5177cc..f4cf85c32b7a 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -1648,6 +1648,9 @@ static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
>>   void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
>>   			       struct vm_area_struct *vma)
>>   {
>> +	if (vma_is_anonymous(vma))
>> +		return;
>> +
> This really needs a comment imo, something simple like:
>
> /* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */

Thanks for the suggestion, will add the comment in the new spin.

Yang

>
>>   	if (vma->vm_file == NULL)
>>   		return;
>>
>> @@ -1671,8 +1674,12 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
>>    */
>>   void unlink_file_vma(struct vm_area_struct *vma)
>>   {
>> -	struct file *file = vma->vm_file;
>> +	struct file *file;
>> +
>> +	if (vma_is_anonymous(vma))
>> +		return;
> Same comment as above.
>
>> +	file = vma->vm_file;
>>   	if (file) {
>>   		struct address_space *mapping = file->f_mapping;
>>
>> @@ -1684,9 +1691,13 @@ void unlink_file_vma(struct vm_area_struct *vma)
>>
>>   void vma_link_file(struct vm_area_struct *vma)
>>   {
>> -	struct file *file = vma->vm_file;
>> +	struct file *file;
>>   	struct address_space *mapping;
>>
>> +	if (vma_is_anonymous(vma))
>> +		return;
> Same comment as above.
>
>> +
>> +	file = vma->vm_file;
>>   	if (file) {
>>   		mapping = file->f_mapping;
>>   		i_mmap_lock_write(mapping);
>> --
>> 2.47.0
>>


