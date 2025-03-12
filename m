Return-Path: <linux-kernel+bounces-557159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E699BA5D456
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A252189A3F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C814601C;
	Wed, 12 Mar 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J2512LwS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNRH8aA0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BB360
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745931; cv=fail; b=h6IDSgqQMYHQP3SaejmWWHe+zkP4k0q0dIWa0aiO0tua7VEVMcbnWMhQn1UK7z9zUeZdov0AVMv/c9fVxHlhe5LMV7EteOZyb3B+5yIa/ghoiODoK+z/2BSZ4Vprp6ogiexkGQcCFJ9ftqrrVwHeBPew8j08XhiS9lasE0DKUFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745931; c=relaxed/simple;
	bh=2VCSW5ZiH+SH759Xp91I20Rye3ZnN1GqcxQ1UZ2hC+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V64U+RjApPnebJlLGoodh0QTRha8L680bG0kZZBMwrvR+bXXFzfZwOuOIiQy85ZuZ5x6mVi9uobR0U7PxFNaA/YaIjvf+0nMO5SYdhm1+kxFAPMbV7uEk0cVBmcSe3VJDe0aho80/aykGzTOT2wBwbimU7aEaezggAEUU+Cn1y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J2512LwS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bNRH8aA0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1fo7d031939;
	Wed, 12 Mar 2025 02:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2N01pZ6gsRJLiTs1xvBO8KDo+mnqG5l3N+Uxpj8/Y70=; b=
	J2512LwSzddRYQHgcHnl0ei4wAlFI7AVWxZdJ482xhtc/+EgkpbIo0jdGe/GvPt5
	f21Xw3wO9jVoLxktHdx/yPdUX4M7HfdekjTrhwN6I0HahuuAYIu+ha31Z4xE6E7i
	/JdeyQ7I5cs94SfVLFZYGBy8srAWEJPhez8JwmxBvxXJLTuP7TqYLIvOPiwKBz80
	9cpUxdjajZKbGIE0E18BA93T3l8eG/93Vz2XZZl13DqTfVKYJkG1YEUuzPf6VgWi
	8WkTrqFbRTjdp12B2ckwMdk/Eqzy8eHOojiZ0OUwZqoZNC0N48G2qxLJK87tvUPj
	hLTG3drppCTc6prOnY1hSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h8mkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 02:18:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1VAtg019474;
	Wed, 12 Mar 2025 02:18:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmyw800-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 02:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUKv+8NwkTFoRI0lL8K0x71KsJZN3Bm5TACspTwJ6HCQldNWmIjG3f4d3qDGwjeESFhT04Riz16SDF8fYN50ZOYV4VQ8d6OAM0mFH6wD9LQVXSoHglCv+tk9SYx517AI3QZGVZdh4utdwvzVT+eAigNN3hSMw2opo4A01Su2Xu06Y70pp9BzwOb1NJ1M4E5y5E73HRdiFQfw8zA45+M/y7N5ZftIar5sArKvMt91FeZst912IuiODPtRTmzKV+utdKBQnciqJaKMuKrn375byZ9dND3A1jc3M+CERMy7/BhPxzozi/tKBZ1p10o9/oN7c21QpvH4oPv3pstgcI0QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N01pZ6gsRJLiTs1xvBO8KDo+mnqG5l3N+Uxpj8/Y70=;
 b=kjuM5mM/TBHAJ2t3BoujYMcp8TCEA98bvuUjjtFvRT3QjHYlBcHpYj8ee7RlHMsuatWa9XnLgWFTohGIrda+xjYKiE3LoeaJKr/+/hlNjdYRpr/C98GM+1+ulCZxv/MFf3d1nHXwhEfBt/TPK/T6q75AFbeBLpL7t+7hcRHFSozdrsRZ5v2WeBb1KZWdJKBZY75SuccBEg0HNnrQlWgaWiWR/Xy2ns/wLOxU9UOq7DH1YAslbNgy8FvYOR+krgpyjSL13aNxttgJmkwYiumyFs6L0yXgsQFHM8RLZKt4oVJCUvM6JPdJw7mw++nXqj+OF/QKR12qapSmwCjECFKkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N01pZ6gsRJLiTs1xvBO8KDo+mnqG5l3N+Uxpj8/Y70=;
 b=bNRH8aA0Hl7kxNdMXJOiOPBMQXYtA6+qTQH5wi6qVuBs6dWRuoqso+CGucQEwBNMrxabXVSVfcOVClaUvaf8oKcQWYtyjaeaDurrbVbCMFFPK9ePPeYdVjnZAlCVm+E0jSqkyAc7vkNXoM0dkCLAkF3fFey4Jr+Pft7UWWRSVh8=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:18:27 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:18:27 +0000
Message-ID: <f9dc01fc-3b89-4724-85fa-14c7766033f4@oracle.com>
Date: Tue, 11 Mar 2025 19:18:26 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH] sched/numa: skip VMA scanning on memory pinned to one
 NUMA node via cpuset.mems
To: Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mgorman@techsingularity.net
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250311160447.2813222-1-libo.chen@oracle.com>
 <825fb8bc-91ca-4de4-9c8d-44590b6c1cba@redhat.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <825fb8bc-91ca-4de4-9c8d-44590b6c1cba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|DM4PR10MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a453c36-47ef-45e0-4127-08dd610c2cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHcrNmVrR2wvY3QyUXZPRDkxL3FvbXAzNHRoc1NnZkNuYlNDRHQxZCtORFln?=
 =?utf-8?B?b2FkR0ZMZ2E5N2JLNHBSUlV2K2xDYXU3bURYZlpQSEZoY25VdjNvcVVYUUl2?=
 =?utf-8?B?bVcyMm05MjF6Zm1lOTJ4akRPeDMxTHNkZW1hdkliSjVia2tkL2EyQWoxU3Fq?=
 =?utf-8?B?MFdIZGpjM3pSeDQvUmE4N0lsS21qVWgza28raEFJTzRlalF3T1FhZGRBdkg2?=
 =?utf-8?B?R2pkcnI3V2tWeTVOYzYwNEdtOTAxeVJNNHJlVjZ4OUxwcUY5UzZ4bUVDL3Zw?=
 =?utf-8?B?bU42Z3RjWHp4bHN1anl3RFdTUEp5cTlsdDJUcTU0OUJzQmI5NjJaZHNPK2Jt?=
 =?utf-8?B?VTVUdFU3L0c2VzBUeGxPdzFuUC9WekFwYzd1VUVqc0I2YkVpWDlzUFpLVmlO?=
 =?utf-8?B?a0NzQzE4aXFYTEdtYTlvTHZMMHdsMXk0WUlNaUZLMVk4MGhqM3MxZHYzVXZ5?=
 =?utf-8?B?SGl1Z2EveFZoTlQwV3drN1hRSWoyM0xrVnlPOWhLY2JzVURhT0JmNXJhTy9i?=
 =?utf-8?B?SmVVLzRYSnlCNzlTWVNKUkhwalY3bUR6c1RUYURvdUlEM1FBeVpSTERQdG1r?=
 =?utf-8?B?ODgra3dMSENnYnJScDJ2aVBOUnhFd081TFEwN1laT28yK0tUcjhBKyt4TVpB?=
 =?utf-8?B?ZnZ2dmNWcTU3aXNjQzdQa1pyNGVOTmVEKy9VVmVYNGw1VkMydy9KaHZ5ZnBy?=
 =?utf-8?B?T3o3NHo0UXQ5SVlLdHVQeVhXVUVlMStQQkVad1pPd2hGSWo3ODdkTlRiL0xD?=
 =?utf-8?B?ZzNFVkpzaktYZ2lFUjhPVzRrMjI4TklMN2VHb0VhL1dhV1pEa0tIU3NMOCs5?=
 =?utf-8?B?QW8xVExjMkNnT2pteWVHRmtwcm9JQ3lGQ2VVdDA3bGJreDJJaklhdWhyQ3Fj?=
 =?utf-8?B?R0l2NlVsN2dpVHdnSEVqL2NyVXBUQmJ5MFhpODg1VGoxbHRSN0k5MjZEdHdp?=
 =?utf-8?B?WXZwNWtlTjFPUituVHpCR2tTWWJRWVlGbU53N3ZZODFyeHpFOGtJVlh2SFFI?=
 =?utf-8?B?L0U5d0R2c20wbHlSb0Z5KzRNVTlmZVF4L1ZLdmxmUkJxZzdnZzdHTGpRN1hQ?=
 =?utf-8?B?YitWMXVhendJeGVHNXBzMG9BcGR4blZScWNKL3pEMkcxaW5SaGJTWGoxNnN4?=
 =?utf-8?B?aHdBS095eWpIeEVaclozZitKSmtDQ1pmVlg1VXVDVjVYdWFmTkJKcTl0Qldq?=
 =?utf-8?B?OFk2RUdMdGdlN041blMzc3BndXdOSTdxMW5mbk5qaDMyQzUxZWxzR1ZQMk5u?=
 =?utf-8?B?U0FrVUlNbVlFMERuOWlHMGFZdzdueG5QcmIzLzJCb2duZC9MZC8xRUZDM09I?=
 =?utf-8?B?Z05TMjNXOEo4QVJDdkQzQzJaZjJXN2dNYlZTR0dUanV4Y2hsOHBtc3daOVdX?=
 =?utf-8?B?WUMwTW8rM1dWcUVrWkdDYzZyRHhuMk4vdjUwcVRDcU1YUnBrVUtIZ2pKdkVu?=
 =?utf-8?B?QjdhekZ1eklRRUw5Z0JzMjRYNkh6dFd0REpmcXU2VlVZTWlIcVVnYUZNY1Mw?=
 =?utf-8?B?NlVyMmQ0UGNnaUI4eHZiei9KZ3liSDBTZ2gzWkR3eXFzMzRVeGx6WEUwdW9B?=
 =?utf-8?B?ZVhSbGNkODM4bEI4SGNVWFoyMFB0RnNuOFN5WklHRElJdzQ5c09OUlN2UVc4?=
 =?utf-8?B?SzBBV1VYMTdmbTdwYURqTTAzS3hRS2w1Yk5iT09FaCttUmNvTkFsUXBwMC9u?=
 =?utf-8?B?QWNKb2cvUDVnVGwvSHh3VE4zKytCejVVQng4V3NPSFkxMngrRWdPcllnMEpS?=
 =?utf-8?B?UUp5YVNTNDRCbXBnRW0rOTVvcGJiMCtTbkE0cjNQMmdmMDdUOWF5dVpVSXpI?=
 =?utf-8?B?T0tGRGpNZ0YzL2g5Vk42QVpzQ0tqSUhNYnNGM1RRSDNMV1RMT2JpN2J2VmM4?=
 =?utf-8?Q?Mw/uyujCTDPXD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZsZ0twaUlUaGhPN0ZnMWdWVndIRU1lMVFybVByaFNEaEg0ZEpkODZlcURF?=
 =?utf-8?B?ejZJSkdWaGFBSzhRUGFDTzBDVFN1VUZBaXFRRHNUL2FsWjZzVXdyb1JYTTJr?=
 =?utf-8?B?U0RtU2ZjOWlWaFJ6M0xzVTZLcDBTMGRvL0E4bXQwTml6VldBd3E0aW5taHJH?=
 =?utf-8?B?V0g5SUwzbFA4V2xoOGdxaXJYai9ZRm5PTmFGQjRnTXpGMmVySnIrZkJZeWJU?=
 =?utf-8?B?ekNRVDFubnNnMDQzWDhKQWE4QlBaT1MycjJyamM0UVJJWVo4NlRYaFhvLzJx?=
 =?utf-8?B?MFBPVjBSMHNKaElvSjVpQ1J3bE5lSnA5dUszM0Vla3hFZTI5MWNkdW1YbDR4?=
 =?utf-8?B?UGxkLzdZcFZKM2QzSHBzNi9ib2poV3BzZ1h5OG1zaGlSdTZHaWZOSCt0WUcw?=
 =?utf-8?B?MDEvVTl1cUJiK0Z0ZCt6TkltM1pad3BwM2I5VUpOcDhoTG0vMDIrUjF4RzYy?=
 =?utf-8?B?d1ZaSmYxbUU3ei9HMm8zdE1GNnpwVEVxUlRUbmhwMDVXZ0dSVWR1Uy91bkV0?=
 =?utf-8?B?L2ErWG14ZGttQTVGYUR1ajloNnhsQ3p1WVdHZnBabWVxSkdQanlkMXkvQngx?=
 =?utf-8?B?MjhndHFzaGg1M3B6bHBXNWFsL0gxcmR3Z0dQN1RDSEoyN1U0dGVkZVh2RnQx?=
 =?utf-8?B?aXduT2EzRHhDTUp6ZFliTVRyaTVtUU1yMEgxbFNkcUszK1g2d21SQXp4aWI1?=
 =?utf-8?B?clhjVk5uMGRwbTFOQWVGTmtBb2tSTW1tdjljWEhPODkyd2RhUTFCN1lQSjZR?=
 =?utf-8?B?UisrR2JWSFVLblhOekdsYitmM0t3UGswcVVOZjltcFdtdUt2Ui90a0JxWjFv?=
 =?utf-8?B?cWdVZmMydHJlWDlkdVpSVDYyYThmVFB1UkNCQmtsQ2Rwd3FjekJJWHFaU0dD?=
 =?utf-8?B?eElRekU3M1Nhamg5ZWx1TlpIMlphU3FVT1BSdmpxMkxCd2lDdTcrR0hqSzVO?=
 =?utf-8?B?R0dxbmd2MDdjQ2ZYTkZ1dHlqaUVYUmpaQzlnZnlnaEpGUzJKY2Jjak1vU2NJ?=
 =?utf-8?B?K3BXL3FraGJTMzlQLzlFWngvVHdndTNLVVh5S21oT2tKZ0hMb25uOGkyZFVZ?=
 =?utf-8?B?WmhzcGluTGd1MWxXeXRsZTdkLzRsTjAxUi9Mc1RpTzZBN3lBN2k4UUUxWUFC?=
 =?utf-8?B?TzdtQzk4ekpWU1Z5UmR3cmNWZXhyTVhHZkFad3FxQXV2NnZCUGNDSkpuRWNY?=
 =?utf-8?B?YTVhSUVVTGsxWGlBK0JmNytHSUVsRFplVm5rYjNuR0J6U0dBckJ2RmRQY0hv?=
 =?utf-8?B?ZkhLWFUzb2Mvb1BsWWZpUkQ1cnVFby9hZEh3azczTWF2Q1BYZlBzelp5M2VN?=
 =?utf-8?B?eGVscERQa2duZTlTVFBIdmJmVktkT1R5aGpRYnZTVXJ4Z0ordEZEQitzSDRm?=
 =?utf-8?B?ZURXRjlSR2RuRXdCM0NwaThNaXp6b215eVpSMDdWdjU3VnVPSkhHSENKNkZT?=
 =?utf-8?B?L3BJSVhBaFdodFQyd3gyVWxzV0dLQWtISEQxd25qc0lJRE1Fdk5DVDc3a3ZZ?=
 =?utf-8?B?dERDWEEwSU5oU3lycVhKQWhKdm9JeHllMTB6MzJDdm1iN0FlNHpYalVHcXNs?=
 =?utf-8?B?ZEFENVVTS3JJN1V4SkVKME5kQmJvTFdUT2ZnU211N1lja3l6VitNLzV4UUhj?=
 =?utf-8?B?YmZrT2ZuTHpqWmlKRTdZeTJmS29jNDZaN2ZBejd5aXBaaUNYeG80YXhkVTMz?=
 =?utf-8?B?WVQ1dVVqNC9OU2NzQjJPRGZteDhxS3N4NmhnZGZwWUlYQnFxNmowaVdUT0tt?=
 =?utf-8?B?aWtscFovKzNjNzE0MlEvVi90eXRRNkhyaEdHckxkRGgrNWRKREh5M0U3NTQv?=
 =?utf-8?B?TC8xbUpDemNTRDVJZERuSnlpRGI2WFY0OEtJSnM5SlRtRU02ZWZXRXYyc2dS?=
 =?utf-8?B?ZHErV2RadmRuVGdTREdidnR2YU1GcWJldTQ2cU0wMmZ4ZldndVZtdWJqMXg1?=
 =?utf-8?B?RkZyV2hsZkhvcEF1OTc4QXZub3c1aUtKNzdqSkVoblJKd3hONFdmZmthQlMx?=
 =?utf-8?B?ZEdIdk9XZUplVEw4aEpCQkpFOGU5RWxLcUVNZXhQWXFCaWladFZJSXBIcE40?=
 =?utf-8?B?ZGcyZzg1RktuRkJ3VFVTUmxYUnI5enlkTjB6S1ZQSWExT3VqQkE0WUxidWFi?=
 =?utf-8?Q?sVY3Dj57J5rmbZ6V52Tpt0wJB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQ1uIChfyB5hoNkfiRd1PbyyJCtu7A5/Ke3CRYk91kudA/Mat8W7w0GU69ePcz80w1VvtOtpfkCxI/KUQKxX2oJ4LMvi4nPl2v4Rh2GnkPDM3YqvM2aOju1rLe5PTnuSNbuXPlEZw4C0Cet+32PIWkdiB/2ePJmtjQyvVx3pDObSe/rWjRIYikQNTE5M+HsJ3Vn0Jrbc2AiB1mmfLi906YuSdGsnkLxq+nF4COd1OCalgfsHhF4JToMoWqk+d0zPD520oBGN4S5WJCaBUpoAw3i4xmiM34BMg6IzaDuk7pOKLig/YNCK2/Fa5qb00Bz3F0uo3Y+ZXBuf7DmxL7vOlo4G3gAxLTws3XR0y/jkeoWSyk/yzqYaOb3sviUo0cQ75LNUvPpZO8sUQhOo5GcZsTyyllUtWZAWIX4tdZJZ2Fp9Z6bghPavzOcl80PZpO6BME96J1GKklJTmvSrbxcnXEiBDef5gnVLWdP2GGevk92VU/71HRg3vp8J9YU8Cm7sJs/NJmRzQJB/g55g7xGVjsJfzZNKSto+XvgrMV6oI7Z9i6Sqzki64034OD5JPGir4yOaiBba8uZVV4zIACaaTfBiQhvbPs7zpfC6lP8/wGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a453c36-47ef-45e0-4127-08dd610c2cc5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:18:27.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz4puENicj54LWRiiviWoFxbE5aPkYto8O+JdZk0DFUDrp+ryqrEloHbu2o5jNY5TE8SUyirgJ8Hz8GZPtHzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120015
X-Proofpoint-GUID: T2FswPX-GPSNnorP8XfzFZMQzTL_DIvg
X-Proofpoint-ORIG-GUID: T2FswPX-GPSNnorP8XfzFZMQzTL_DIvg


On 3/11/25 10:42, Waiman Long wrote:
> On 3/11/25 12:04 PM, Libo Chen wrote:
>> When the memory of the current task is pinned to one NUMA node by 
>> cgroup,
>> there is no point in continuing the rest of VMA scanning and hinting 
>> page
>> faults as they will just be overhead. With this change, there will be no
>> more unnecessary PTE updates or page faults in this scenario.
>>
>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> ---
>>   kernel/sched/fair.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c798d27952431..ec4749a7be33a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3315,6 +3315,13 @@ static void task_numa_work(struct 
>> callback_head *work)
>>       if (p->flags & PF_EXITING)
>>           return;
>>   +    /*
>> +     * Memory is pinned to only one NUMA node via cpuset.mems, 
>> naturally
>> +     * no page can be migrated.
>> +     */
>> +    if (nodes_weight(cpuset_current_mems_allowed) == 1)
>> +        return;
>> +
>>       if (!mm->numa_next_scan) {
>>           mm->numa_next_scan = now +
>> msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
>
> Do you have any performance improvement data that can be included in 
> the commit log?
>
Yes, will put out some numbers in v2.


Thanks,
Libo
> Cheers,
> Longman
>

