Return-Path: <linux-kernel+bounces-356260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8C995EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1551F25B93
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4BB152196;
	Wed,  9 Oct 2024 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IloTxvwZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="brc1+i6G"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FD3C24
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448850; cv=fail; b=NvJ8cr1XjlkuZWweU8E65CuZZMEcPQ4sPYgfQLMTub3UP1IwPz9fKDPecMadKGweOXqYh+H6i1V7TcQOTCHGie1JQdYv5+PIshP+SrNoJmxf/GhG9dsM8rgxmcXfRvDi9vxmiD5BN7ciNoOQaV/k5YNBXLxnf28dUecgyAcFKEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448850; c=relaxed/simple;
	bh=YwM6QBO4WWxYSD3BzKH8hljIi2Vvsd+TpTjbeN0n0Rk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=cuKx5rrUEWeM4qsjN1K5P9GiaqLUrsqNdJ+Tgvf5QgG8ISnJp8p7qxlK4KopOOixX9Jc+YTZE0IHBFP8JlIXbNera75aXzAk4m2xRVjGYv/MXDFjUbqWozqiL+TWiBQaNAAbOSvmECneiarr/AV2sWH9Pew6XFqRs1RFgruYEMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IloTxvwZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=brc1+i6G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4991tmU7009667;
	Wed, 9 Oct 2024 04:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VLC7cPQlkjvg47RV48dhcz5f/b0y/7y9V2VJV8wu8tk=; b=
	IloTxvwZkt/xYlq9HpfdbTSn0B8HpsR7JFZnFk5RoGdE3qwC7EyrmvCnkht1c70n
	tg32jWx3UXVl8+kLB9BlWUvz+bwpHb6g+sLxTIgKB+iWzKP5Yy/4yHhAzwWiPVV3
	mdbANwfH9hP3sPBzJlPgB5Q52rfeuPDKvNW8evfkT6hQKP7vgj4PTEiWI8b8Ij5Y
	hfyFWxfO7F1hL22k32aohemDdyj/W/VWh+1ZRz+kUD3h8lrB5fMYRcS5X+n8ByF+
	MeU5sa1eIXBfV8cS6YW76i8wtvBIW6Yan9cogru6jFZZ2cwHE5vXigqmnZUPj4t8
	W525DTk9PASiMoUUU/rh/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dqa2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 04:40:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49930Ka2019083;
	Wed, 9 Oct 2024 04:40:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwebg40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 04:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h60lA5P5TeGiywuHbu7pZaTvBfwQFrZkRV4d6Cs3KAp+Wgul+DJEnqVcl6QrWcNLI8Z1f4wblof96TSXCnNyuaSqst7tw8T2SwM950Ld9OIwjNC9TC93+rjt1TTsDHGZXHScCBYcWJ3kKmTgytlkH6dcYjDFYpmFs1gD+ybXA7cOPc2I2LeL1bCHC69UKZyFFNh6+1WbcnEhOsIXgacmVBmxwyiHVOcncnjHdEKFC52dv9nnMF4gWj1rj2RuPOzltaCMDzpdybYOadf0QjMcvX3XIQQyKtDEunmwOjMtQCuLBzn/XIByINlrcfzHNNAKyoxBE9cA6Aw6s3lqiOBZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLC7cPQlkjvg47RV48dhcz5f/b0y/7y9V2VJV8wu8tk=;
 b=hatS30zZeraRrh1wV7gWKIUhXO5qLvuRcyONvzOmnTjgqWh3AqPXI0l+BScifgWKoCUWPcv0zGN2YR226pvqsTFFUneNHRZx/R1uHuBQhY/ibhuXIFi3Nmo6RoijZ4HW7cFjpPfHNxqfp3re0jQ19lWUd82Ys0pu+RU3U9yIfMy9crS6/6QWJMtYiDcVkFR6r0JJ3ZIzo/ZcYksUjJkAo245P6H17tHFMMrbhsp0n3ADAiGDLHMO4LsBLiiuqH2zvRNEBKBIV7Hcllyn72g9PLpBtRlMcsx9N+ic/Ejt+2vykXexhp90KTC+YApGJs6W1L+FjyvmrC1yrGhlBmuhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLC7cPQlkjvg47RV48dhcz5f/b0y/7y9V2VJV8wu8tk=;
 b=brc1+i6G9KhQxbdHHulrzFzJYO7BQMcfGgHL/D4LMGZ9TCAWuwJqhGtWdnjzEa9h0KVMx6XYNzW3A5a6X94I8GwRyz1mh3HhiTP6fLrAKGaoEkFbt51R5OHM4tgqqA+jjLAFaThvsNSEqZEm+GWiDsmZS0NX/Q9sD0spTwD+q8I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8005.namprd10.prod.outlook.com (2603:10b6:8:1fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 04:40:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 04:40:08 +0000
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-reply-to: <20241008153232.YwZfzF0r@linutronix.de>
Date: Tue, 08 Oct 2024 21:40:05 -0700
Message-ID: <87wmihdh3u.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a73a590-f7e8-4b3e-b156-08dce81c73ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3cvb21UaWRqK2F5bXg5WjR3YTlZdUF6YWJrVEJ4VVpUSWd3Sm5LeHloZllW?=
 =?utf-8?B?Tk5uSXAyRUZhOTRyVEpleWFEZ1k2bUI4OVF2dGtJcjYrV2huRGk0VzNybVN1?=
 =?utf-8?B?TXBCdzJZSjF0NC9FMjNrVnNuZEJTazh5TDFBZHkySGlrR3hScnVLclRXeFBI?=
 =?utf-8?B?QXZ4b1FFNE9yQzNvYlBONzNVN2NoQ1ZiWUpyVDg0YndOa0dybjVFcVdSeGVK?=
 =?utf-8?B?c1VwekNPSFJLTU1oM3VLZm56blo5RTltei9wOFBjMHllUTNWM1VoODd2R0pp?=
 =?utf-8?B?MHJkaUgrWWYvV2d3YlIzZ0NBcmdaZk12b3l6Ky9jd0dOOU52RlFuSkREdEVi?=
 =?utf-8?B?Tkk1dThGYWVMUVdrQ2NpMXBTZXRvQWR0VllqNWg5UmhCeTc1T00wNFVUQkNS?=
 =?utf-8?B?dFhjTDV1MmhMZ3F2eG83Ulg5Qm13SnAzMk1ITTFRMVJDM0hxVUdJKytseWkx?=
 =?utf-8?B?M0tqMUl1RFc5ZkFKTlFoY05JdEJ1ZE1RbmZmWnMzNVhLUEVqWjIvcEtEY0lZ?=
 =?utf-8?B?Z1JvM3lJUVhYZi9vcEtTekNuWm1MdHJtZ1ZxeDBtUW50dHhrTDlHdEpPZUtr?=
 =?utf-8?B?TzVldU5tUGdFbk0vYmZDRmpOWCtPcXZ0NDZvcitJQm9pL0FXT285ZUFrOWRI?=
 =?utf-8?B?NFh2c1ZCNHJBTE8rV2pwMURteHBSTlFTT3gybkVDcVkwOEQwVE5yYWZyUzAx?=
 =?utf-8?B?RXBtYkdFckJiZGliZEFuTkg1VWNLajI3WjBxR25RZGl2cXlQNU5yaUszMlJR?=
 =?utf-8?B?VUlCQytyYmxaQnFqNDJpaC9aamtrWGtpaFR3SUR5RFVhUVFBWHVrOTFNd1lk?=
 =?utf-8?B?aHJIY08wSmw5dTFNc1luaVcyRHV6Tm5ObzlkQ1ZXRzM4SWFGYUFqeU8wQkdP?=
 =?utf-8?B?U2w3K3RlSTJQZlBLekJNS0JEcE1FeFA5cDgyQ2RFbVBPd2ZSTHNsWEZ2dmNF?=
 =?utf-8?B?OVh2dk44aFRkWGhSNmxXSGpYYkMwbnhWRWVGSXZNeTBMYnVRdDRwM2crUFNN?=
 =?utf-8?B?SENRaXY3L1FLcnV2L0srbTlULzlKbTkxMXpjdXNZY3RFSGx0aEF0N0hOTitl?=
 =?utf-8?B?SXRoWGN4dEhXNldMVU80Wmh4NHI4WHBselRoSFQzU0RBLzRkSEdBUmkzODRu?=
 =?utf-8?B?OU8yQzY3SHZlTzlOdWpYTzZTVlZjNDNvcDNKQzl5K0J4SnRZYkI3ZE12d05p?=
 =?utf-8?B?cnk1VFBjZ3hLR0Z1SXZlK0piRGZHZnNtWFhxU05CKzh6Ry9BbmNKYVhyY3FC?=
 =?utf-8?B?blNFb1BBTTBYU2hMTnBhYS9TWmJxdXIyQVRkaXRBVzY5bENIMVFVeVEwSnEz?=
 =?utf-8?B?RGcxTWVHckVvUnpCRkkrVXBtQkpWajh2cHBuSUhPck1pSHltTUdkS0M3OUFX?=
 =?utf-8?B?VnEyVWdIM3lKWHFlUG5XcTJDSUIrb3d6Yko3aXhLRklGTVJHZW5aUjlNY0NK?=
 =?utf-8?B?OXp5Ymw0bklKelpqWDh3Rko3dnBnWG9BWnMreFFMKzVFZmY3a1drTGhsdzY0?=
 =?utf-8?B?ci9PQ0t6bEZhVUlRdWhCOGlOWXJxODZOSGNZSjFudnRaVUdZVWZhWldDckdj?=
 =?utf-8?B?clZRM1R0L1puOU05QWFLeklMaGl3cjNYcXRYLytNbDVObGEyZHB6WFpvU3Zp?=
 =?utf-8?B?L2RZWXJndmVxL244Y3B2ZUk2aWlGWmd6SEQ2Z3U1SW00dVZlWHVIdnl2bVdL?=
 =?utf-8?B?Y045Mm1rdjk1cUdpMWhneDVkUHI1WnpocnU3cnNVMHl2TkUxMVRrV1VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGprdUF5VWMzVFhkOW94SDI4NjdFVEl2OTk0UG1iY1Eycm9CbHpPbDF2UENk?=
 =?utf-8?B?Ykpxb3VOaWVHRjZ1WGV3bnBJOUpjTFIvTlRDMWRtWk9mcml3Z2NKOFR3NGJE?=
 =?utf-8?B?N2lhZ3lJWTYza2tpQU5YR2NCRk8vaDNRaTU3cXp0VTZVbXo4R1RBdUYwdGpQ?=
 =?utf-8?B?YUl0OVlVa29PSjYrdjlRL1A2NjNlRVA2U1A5aEhqcGJNQXozbjFaaUh1SVNm?=
 =?utf-8?B?U0NrZHRJSC9lMXdnR2h2NEdscDI0L2JvaWZybTB4R3hkKzU0c3BmS1I2MHZu?=
 =?utf-8?B?amxoRjM5NitVcHYyYlVuUlRaNVJtR2xnaXJRMWZmNnpObnV6ckdqOFBadytI?=
 =?utf-8?B?V2tkaUV5MTZBYmt0NTBaTWtzaFNHME5aR3UxYTJtK3FuL1ZQb0JoYVhFc3p2?=
 =?utf-8?B?aGR2aWdOK2ViZ0NlbjFVUS8wQ1ljMFRaUk9hQ1Z2SnVkdWhzVFJXWnIzaXZ0?=
 =?utf-8?B?OTE2eEpKU0JZeVhKdG5hNURONEtaTmFoMFJka2txdlZFdlNRM0MxM3JOVWw4?=
 =?utf-8?B?QUcwcXlXdTErUWxzWG1RTXdnREFFWld0YlZVZGxldkRLVG9GWW1sNVBTZUFt?=
 =?utf-8?B?cVBBZldzbTJZK2U2QnFidnRISVlSc3BjV21OUXg3WHFYK3orNGQyNTRqYUdi?=
 =?utf-8?B?bkZnZ2VMaXh0SFU3N2ZwSXBYa0l6NWd5bU9IUVNKVWhva3NYV1c0K0tqWXVn?=
 =?utf-8?B?YzQydU9SelBsRmZjUVQzc3duVXdaRDB2OEMwRFRramhONzRrK0d1QmVqNWJV?=
 =?utf-8?B?dW5xMlNZL0xlZkFDYUVXQmpKTjdXaUVOVzJyUGx4THRybGxTS3kxNGVCcmdH?=
 =?utf-8?B?TWtBTzhJKzdJOUloOUhsNTFvRzI5YktXdFhmRlZpQjNoRUFXVmJKVTYyK1Vh?=
 =?utf-8?B?TWVNNm5OTjRkWEhFQkFpN0dweXVmZDhoNXVUelA2QlEyOVF4VjF0MGliNEd0?=
 =?utf-8?B?ekgvOGpwMXluZXZKck5DeEp0Q1oydXVQVG5BdENvMkU4enZoL0E1dHpBcjU3?=
 =?utf-8?B?OVA4U3BYc1ViRTFiRmc2QzEyTW1SUFFkK2p5UUQrQkhIaVhZNjdBQkFRaHV0?=
 =?utf-8?B?N01KUmRYcHZzY3NaZkE3R0ozUXpnTDJoNzM5WFMvWEcvYmljQWZub3RabmVi?=
 =?utf-8?B?NzVoSndRN1hjc0d3TzhoZ1FpWUJtYWlLcUlkUS9jNXAzdEkwci9QYUNwelpp?=
 =?utf-8?B?MVhhYnNNN0xaalJSSEpBUmxTSG43dzBRWkJMQ2EvRDIzYVpLOS9GWHV5SDFO?=
 =?utf-8?B?UzZQZmJJK1JZc29peFJtWmdLN0lCQVNGaElwYWhzbXI2ZnhmMThoamN2NFA3?=
 =?utf-8?B?ZlBhcGxJemtMb2N6ekhzaVE4RUVpblV3Nm44UnFPZGtWTy9lOWdpNXZlVHFt?=
 =?utf-8?B?T3JrSVUrM0laTlhyMTNOMkZpVEN3N1FEUU9kMlBDV21qRklQUzlZMGFTMTQr?=
 =?utf-8?B?R0NtSjBXQWtoQXB1ck9uZXZtNC81STkxRmJJdmE0WjhsRjJ2aGxnZnVLSGJt?=
 =?utf-8?B?R1JwNmRWSzJkaVFTWTNwcEtIMStqVXoyZ0xuVjlENmxYNDVTNW9adEhFelA4?=
 =?utf-8?B?dnJDbVVKZ1o2c3JxV25oaHhlcW9sU044YytpZmVkNlVXcmVyZUxwQkZGWlBx?=
 =?utf-8?B?eHNJNTh6VGlDa1p3amNwMGZyOW9NcjBhbGZQRktiM3R6SzJZTUtFa0dIdGhj?=
 =?utf-8?B?NmhpWUIybUthaSt1OFlQUkRrdUVYUVk1L29YbnlPamQyd2xIVk5yOFJJTEVD?=
 =?utf-8?B?T3EzdlhaN3BERUFueDR1L25za3kxVXpuWFF0QTB5U0hadHpEbmJDT1JGemow?=
 =?utf-8?B?WGhPSEJhT0F2dXN5WDFxb1M0V2p2aUdHSXlDYjF4TkYvSW1jWnRUNjJqV0Ew?=
 =?utf-8?B?RXRkOENDdk9MQmZNM1l4cThSa0ZpQkJXbWpqbnF4OVMzWUYvMEtTL3NpTVZp?=
 =?utf-8?B?d3dZUGF0UTZKMjAzREpCbmIwbm5sbFIvSWNQTVZtbENDVDB4NlcxSkh3d2lN?=
 =?utf-8?B?L1lWTVZ3SHd3bkt3aXFVakY1Vk15L2dSbjluSTFtUDVlZ09NbzU0Slova0F6?=
 =?utf-8?B?NmhnYnlPM2YvZkZWTXdEdzdBbmV6d0NsU1d5VjdQVU05dndGb0VUSVhQaDhU?=
 =?utf-8?Q?3ClunMciNEsukiq4HWw0oDKbz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4e/6okECANc8aUt4siBpo3QkzVK2DXgdxhBLfosSv4wrs8nqQYtqaGNQ0YtIjW7eTeDVH5fS7UtjvuPh6nrTQYHg+CLJAFm0Aj3omVWL2yYFvzTyT6pglouiQJnIgIfvNcfGEm0vWDnqnMLMAPnRqezzZAVQz91mvm38XhtoEmPwfz5T7IqBByEpuC//cMfBRWXJtVlonHCMoqqCtBrIOl+82U2DN7uTysgyzP7DXk6iFgRnNjRyroYbAHqQfH6vHqT41C2H3X8HHH1/iiMlmlnJAY3wod0cFA8/+ckflZJoTGlLUiZXGat8FbX+zsljt1cNSiPiBcKasctzlyZVHRsbXp0saiWvPT1L1sYjFyYG1Cv6h3dLAIzthHPryo7Mf6D8lr6BCrULj8zzGZCVDcRJlJk8oLVNczxCEU2ckbgJ8maD0tnOSzlokWQsKjRb3XWg7kX182q+U25Nqhcwz7+B1eMsIPZA0werYF2Y2jOtYtWqG8pIV2WzxgjP//PJwg9U7Fu2TP6njhIWpm3UnsS3f6EZkFSrNjDAZ6TrntoyW16ci6mHqNvs9SiIDAkRolpysf2XI53JmS4SR9MFyFEn5tOK5jIpqSJQkkjjQ4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a73a590-f7e8-4b3e-b156-08dce81c73ed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 04:40:08.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XZ9ad/ML4SjzAXpaqKG8D9V2Ht5BIW5eVxnQsv4OUess2cuiJcj91+ptFXg7ZAgzqQKr4gj7isTyOkHfREoFsHla9fuAhtM3P3UBBEfw8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_03,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=479 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090029
X-Proofpoint-ORIG-GUID: xiZdPCmBUPZdNtKUnnQ4iG6zmEx7sloF
X-Proofpoint-GUID: xiZdPCmBUPZdNtKUnnQ4iG6zmEx7sloF


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-07 09:46:09 [+0200], Peter Zijlstra wrote:
>> Hi!
>>
>> During LPC Thomas reminded me that the lazy preemption stuff was not the=
re yet.
>>
>> So here goes, robot says it builds, and I checked both a regular and PRE=
EMPT_RT
>> build boots and can change the mode.
>>
>> Please have a poke.
>
> While comparing this vs what I have:
> - need_resched()
>   It checked both (tif_need_resched_lazy() || tif_need_resched()) while
>   now it only looks at tif_need_resched().
>   Also ensured that raw_irqentry_exit_cond_resched() does not trigger on
>   lazy.
>   I guess you can argue both ways what makes sense, just noting=E2=80=A6

I think we want need_resched() to be only tif_need_resched(). That way
preemption in lazy mode *only* happens at the user mode boundary.

If the scheduler wants to preempt imminently, it just sets (or upgrades to)
TIF_NEED_RESCHED.

> - __account_cfs_rq_runtime() and hrtick_start_fair()
>   Both have a resched_curr() instead of resched_curr_lazy(). Is this on
>   purpose?
>
> This is actually the main difference (ignoring the moving the RT bits
> and dynamic-sched). The lazy-resched is slightly different but it should
> do the same thing.
> I have also tracing and riscv bits which I port tomorrow, test and add
> to your pile.
>
> Sebastian


--
ankur

