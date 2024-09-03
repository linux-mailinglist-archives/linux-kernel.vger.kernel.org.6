Return-Path: <linux-kernel+bounces-313373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3196A4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4D81F25BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1E18DF90;
	Tue,  3 Sep 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNDQhaV+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u/Bpnpy4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29118C929
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381514; cv=fail; b=jCPd1fSPxnBaLh/xnxuYqa30CyODuPEnHx6NNrSRdkNHHvZYsTxkMmKALTH+cGwaiiMehyAPKa/nXVmFgPIBkukDXdK5L4ijtcsUfg+Y6YOVJjEGET3VI+mkfGFOuZYx1n2bNBtxoU+pF7PJInCovIvBF3AM49C6sVPYrsfpWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381514; c=relaxed/simple;
	bh=Huh1uuut+oMv5knDkvPGrGeQ8tIh7TxKxN8LijJ7wfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GH3SgYa1OewkjmFby8q/tw2ibSRFdYkrbrMAN0FRV9z8GQJJVVf2V94zbK6zz45/mh29p4opfdOVSedcoTWke6KZIig6VTbQn2RlQyO0kQtRIB9WkaO070MHCrrvAGdCVoTAvpsW0p67dwevqHOpGQb9Rj7ck/kioocjgpolU0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fNDQhaV+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u/Bpnpy4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Errxu019404;
	Tue, 3 Sep 2024 15:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=e6TihWf4AG2IuR6
	6g//kvcfvtS7grh5X/gqeOrBnkpk=; b=fNDQhaV+L6Ti8kmZOHAElTAZWIXgLD4
	CTrqZH9zSHp19z3yFuDb2MHBdqeQYXXwD0LXxk0bBbvH4TOm62fKGv9V0t5Mr6c2
	niEQVCBLWWM1NHzFsmh0PP33lqIUjziz2dMUOGR0C/Kxi6Uraczt2MYcV9Zekqdo
	Uy1itSwkX080Bs4o08SHxEA2j4oCYxPsgIMBzvpp/QMayXkbSbGXc+BmdYUYAPxZ
	aDfv0K/P2n2FoYkJ+VlTlHrwil5CtIK7CMj4u4f/kwlj899RLvq2prgE6ajLCo6H
	ab9nCnk4NB4zSHM6uM5/mEU7qHgyVrz9afxulkPP7LPsUopQYdTfTkw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsa9a6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:57:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483EqsGE032658;
	Tue, 3 Sep 2024 15:57:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm93cat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1/W8vQZ0wLIDBbi/yMD3r3xSfe2IwFqrVNzijeJyfpjv2yNULDqcZcW5ODZrHz0f6EyVP5MpJl61BBgzadX6FUD2UvLDFfkrWIBzwhLgbLtrmo1ItUJTE/d5LWZradYSRRg9Y5Y2MJx1uGIioJBWi/F1UEF/EC+0uWeGceCm3uBKEDQ/b87sNGj61VbLeisRVM5c1OJMpTeu30D2KFgK5nY5lEq6Cl9h3tDYuwADaJmCx2pTXHYUrs/budx0uRDJdbhQpAUwwsgwEA1FZz4Yv9mGVxc0EOM0ZKgN0AWhptcPGqxFE++zKF9bkpy2fxRsIALuO7pJ0nUSgHulGYRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6TihWf4AG2IuR66g//kvcfvtS7grh5X/gqeOrBnkpk=;
 b=xsq6jcsFqLT9jAIMYgG3UFoc8usN5GAi1sLn7lgaKVfOQ3Vt8R0wy9yXEzlxA9GjYnbGf/B7XDOHCxWmogs4e7rVrrILe2qCO40MG1DTfV1ikIFcG8IYHBVK/IOwZcUpJ4V/aeRK9+L69HJWnkpUyNNzYY89zklJTiswjY7Q/x9vXBjaFmfRVdF1cERH+8LCYOw0i2vqySZmNqHTte/ejRAma/7rvXv41Y+nQqBJqHNkH1FYXUMhUkySLQkXq27Q40I92/QOzMFDUQfUBM1LGpzaDl1tUtRBgrvbhzGyvRU2K7UBPvWE2VkzXlkHUN9AWTlT3tGb2mqjx6s8ZD475A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6TihWf4AG2IuR66g//kvcfvtS7grh5X/gqeOrBnkpk=;
 b=u/Bpnpy4/h6hExB7Deu+QRmh6zIkiSC5as7E0xejkrMBQUhKioezNrZ3kW8n/YQdSMGBlpNhjyjN5o9TNnR6I3+1J3D64xcvBIC75h/R+qp/Zi0taT/XRVqX8PpxI2g1vlnpMZk0a4IwdzHZjVYmi+SMKGeFfJ5FserShGEb3M0=
Received: from CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 15:57:00 +0000
Received: from CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5]) by CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:57:00 +0000
Date: Tue, 3 Sep 2024 11:56:57 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <lfvhfjj2ysuut7sawru6aoywjowpsba3z2t56pjxh5tbi7kxfw@h7twfxw5oalf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nam Cao <namcao@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bigeasy@linutronix.de
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
 <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
 <20240903103616.i0GrRAfD@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903103616.i0GrRAfD@linutronix.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0056.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::13) To CYXPR10MB7924.namprd10.prod.outlook.com
 (2603:10b6:930:e6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR10MB7924:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d141e77-5222-4336-5f74-08dccc310bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ub0hgRnwJfKXrr+jXiocu5/BaVyGgt2SO4jZgExMTX8YkYCbREL/WbCiAJUK?=
 =?us-ascii?Q?9l1pUVT/YbS3NE14pp5LCRku7fgZsrCQBMUzciR0Cdh6V3livRoHGel8k7aK?=
 =?us-ascii?Q?q0B1KeIFF6sV5KV6gFq7Ic3PvAhDCSiGsfbt2185oL/GipwoI7PEpvYFreBl?=
 =?us-ascii?Q?rmjM5ZBDL/3UFTKKVa07vJCC+Os4DORX8V2SglE6csjMEr6fFsqhgrqTTRGb?=
 =?us-ascii?Q?qMsA/n1PPAFEbZZ22YwDHO/EG6HzoFLu7RWOQzDfujJTjPdLnrhU1s+8bCo6?=
 =?us-ascii?Q?Jiz3THBPU1WW6ID3wIusPa9DJ3h8UdBXfPV9ZaKfcPJACRHr6EIMzOQcrH7e?=
 =?us-ascii?Q?cZHSnQAoiv/VFTOvuRfcTdSTM0NBT4stm6/zUtKc8rzIuQFGxvssUdGKjK6j?=
 =?us-ascii?Q?h3wRgJqohzTLvZaaAOb2cald0llQGZDAcseDUD0yXb1obLcRasgdVNxCRxfF?=
 =?us-ascii?Q?lYypDotXyXGHeFlAJPGPGf36QIngANN/KDJFE79HvbB6HU116xJoVfMq8Ixh?=
 =?us-ascii?Q?6yQqUZSxTH9cL7TPuZdJX69iC1jCjDqctMIaD+gDuB0HwDzDSIL9qiUOJ0SV?=
 =?us-ascii?Q?bPbBwXGSzSG3erWs76sSd67alGUeFtNjuVpd2kXiiCeZZoSgqTu8uQg3zPdi?=
 =?us-ascii?Q?5oQ2lamCD6GPXVkXfxP8cIxYYgdGyKo5D5+U0zqLWaBXZH5RymmqfDy50ZgP?=
 =?us-ascii?Q?y2V4b9zWFQ/WsG+l7MEhj4TxF0GmZz+CfotaAfbjAHpRWVlFqmMQ0AtkBUF8?=
 =?us-ascii?Q?Hhgz2HwPIRFQ1/n7xfVd9yRth8aXx7PrD/6tN6o/rp9IxK/t8+ZO25BzgYed?=
 =?us-ascii?Q?tktaQ1hwIInc2C8WdNXPIfDBuJjRgUJDZf3k1SQpuCpyCyvSbu9MMewTjBZB?=
 =?us-ascii?Q?y/WkTnyuVCensfZBgSM4xHfDl3WfypQJ+l+M1wjafCTi53Nzb+JWJqA9o35V?=
 =?us-ascii?Q?a4ztgc8YzBdxlRVmzRoahn1AC7YrAcDCdyHOGZBk+JI34mctmu4NeLmDFput?=
 =?us-ascii?Q?kR4rg4APTPQnU66F6x23/FgF/Nhynn4j2ae//lazx9Mm6LHh4M4nYTZ2hZ7F?=
 =?us-ascii?Q?rKW6m29WMX46oYTZXxzBVHls4IUIbyA92R3u1iY0NTRvNAIFUK1WzYburbJh?=
 =?us-ascii?Q?B1jme983AptgTRO3yzrMFtmCXPqKSr+fUHLsXLq7JA1RXzqOPMef+KlIzTHs?=
 =?us-ascii?Q?5Z5yY2/OlvnT6DAnCZkfzurToIIlSs/YRBxJjeFKdBmKUNBkEAfoJwvn7zL0?=
 =?us-ascii?Q?jOlW1/Neoq+6n1nygPW6zTPGscpVhJNaRYr5cNLxhIv5EIJBssVeUVkyuUNy?=
 =?us-ascii?Q?z/PEp8aDhf6kvadff1UUAC+HQOJSo8IKlBtd/aPbpkCpuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR10MB7924.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmQH8vmtP7DfUdNETEjI1+pagv7mqE0ESpohwVY77gPZmvTqhWnhDsjVabCT?=
 =?us-ascii?Q?MmaRDzhR8H3x3tLsSTFbaqNVqpUxnL633O9307opHsfriIBXQcFaWPTuDtav?=
 =?us-ascii?Q?HKOYp/T40tlMHrFEQW3ph8UAwDFPLdxeQ250WjVJOf5MwODP3xs/SaQwP/3z?=
 =?us-ascii?Q?u/aRpvzNUAhVilA3doud2N5QEQUxM/EuSH7AjhfRzpnOrwGFv+XWJGQ74pP5?=
 =?us-ascii?Q?LxcnXnnNf/m6Oao7G7IuUL6B4D/uELYM+nWHMZjpmuQhs1sM/2vwtQtpyCrA?=
 =?us-ascii?Q?VqbDK3sMPF1HH3wdGdgdhJUzQNEVlUg78sVsOjos8NQmaf4gg25CgnlZRG8f?=
 =?us-ascii?Q?m7Lnw4pxaWGzIXrmvr6z5fJ28b63xYIngMteTYuwDJrK05oJuk+OP6L1dThE?=
 =?us-ascii?Q?rhGsxVlsWfGIAPqHrfxQ3RlZG+y/L8vkFzdMcsJ7JQsSxRNoT7X3HRqxLobY?=
 =?us-ascii?Q?Aul/GFxsiAl5eCpvXOnThTLx87JvDXAkIgKev6tGMec2FpdRY/PAtAIjGCt7?=
 =?us-ascii?Q?f058XuY1rCz/M0u8L4V3CBRiuP01sM/4VO/5VTcR10YXY0BoSqNL26s63QJr?=
 =?us-ascii?Q?D8lajqiFuqlDnFFVyqmeVEhuVO/g7IlZmVLmYEmFJ7H0mFlpnU5u9C8m3GZA?=
 =?us-ascii?Q?SWl5cKHu5ViiASIl2zOuqRk3c2+b15BOrgwGvd56Vw3htNBT+CbV/n0dgCoO?=
 =?us-ascii?Q?/QWAOwEcnS2cgHwWulRdI6I21YtHbHPamwqHOW1To/eg2nVw9ibJCyy8Dr7u?=
 =?us-ascii?Q?MxD0cJKuRxCcUv1i2cD8Zw9XbV7cxMqVTAlDPnAv7LwPMUJUegO1PmWy71O/?=
 =?us-ascii?Q?Reuj9hELUmFwrq2fYkb35038J7oAUqBDUytdP60SdHM/9n+g10lGlolHUrqL?=
 =?us-ascii?Q?UutcTUQs5f+xDyRntm/BAWQ1DPLiKyqGHQT3CV8Cx5fdtaEVAH/19jn88GZo?=
 =?us-ascii?Q?9uEL8e+YLmhIH7T+4ZpvlNc44IF44Xewnpl8qCG4ULZwDhnaFXm1Eub8m5ye?=
 =?us-ascii?Q?9Xbrd9kxoQMkgwhj4amUj21FGvZmCgN2uqAl4WFWhge34yskW7M1ALAlhvhb?=
 =?us-ascii?Q?tRG6hjCyq1Fbzg2fGYjIGacwp1pEs6PVCvv78acu/c2cuzRAQlXfGZSt23c3?=
 =?us-ascii?Q?zHKAG2CUlBAaXA7kDMfYuvb/PIo0zhqEmDeYLWKj4NvhepzMTn4BgbIStbko?=
 =?us-ascii?Q?LRUl6p6ImhjNm6dQRYNq7w9U6+cbdUXEGgQvpGLBgGDtn6qumlxpMmh90rax?=
 =?us-ascii?Q?pNWwYKN67R2RMl+ZcXH1bEtiMj/W5zhM/RAxyw9s1Xdf/PPgIHmkFe1CR+5e?=
 =?us-ascii?Q?dCdLsigs5unLZruJsfrpQqHEHKHD5GBNwmmp8gL/ogA3Sc3DPQtPo8Z/G99Q?=
 =?us-ascii?Q?zZDmBf249YgqIC3K7nu1XEY1S/HEHWq80qCQqb/AhAMTV3yWxoHysqqFtMSR?=
 =?us-ascii?Q?HslfbAlG5r7F9eU9CcRBiMWaGqjXd7T8SLhA/YlC8xG1Ailv42NqMCK0sK5w?=
 =?us-ascii?Q?lFHT8jypDeuNNLVA3qqYJimTOlDnNHcFVzJLm57GW6R5EU6q7bv+uewhVsC6?=
 =?us-ascii?Q?upFNguYdDns/s4Cru/57n4pZukY6Vb8Ygvp0+m8l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	puZc6Sjk+sxZm68yLYYSX6uO+wTA912EqHFB1lmUsTR4mKj6fZX5ztMoG0UoibN3Ry26wnGF4dDUkOBXYAQzvmZ6RBf+Vois8ENxroY/a8oVKrZOkuQC3rIMi2oQyu2smAxiTPHYmUjBb/lKLswvR2vLyf5NjcxhyAkIEcdP6VaWIW64gDls/kZkKqqhskycx5UA5xbgecapFrwghlm8+lgsDta7qjemiiS55sS7Q/vyWXu3EOuQqCQR7DfZ3KDF2PC7gw/vaA6HlhF0+G4B7HtNR7tjUSMvqlZm1Xpy1DxhoIHHsLoHxo0KS8TYn6svwbuhTPy53oqWJceiLEhpGuWDrYuioZwQp9MDq7/D/Ecv5ZbmnoQRDxlrc7st2+nV3gTEXxQQXPX82+ztxWEBN1n4JJs3hg0khHdypkLjJuHacUOG/VkAiylff0UBw/HtYE07dAWTTGm74kHOcRbN6vlIxHZe+LS9XJPGSz1OTspNK8lhYhj9ojvVSVEGBwoRBMslZwlhtyBzgawLRIgYpvlzc9mPFHrFUF+pLx/yuYV82BL0wqZDTT6KRRjKhIq38E7Cu4cXpF6WNsN72mS7Z8eP8zYmLGdf7SBKoP9u/5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d141e77-5222-4336-5f74-08dccc310bc9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR10MB7924.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:57:00.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeUhihRKtkT56S6l2dOJM8WVx32iffUDiCqxegJ6b1D/8dasEHvffkDN4Rh4zXY0eKmvvV12/8ZnYAK1br2xRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030129
X-Proofpoint-ORIG-GUID: BOZHEDVbol4B6xJMHDB7mQDJzOj8aMAQ
X-Proofpoint-GUID: BOZHEDVbol4B6xJMHDB7mQDJzOj8aMAQ

* Nam Cao <namcao@linutronix.de> [240903 06:36]:
> Sorry for the late reply, I was a bit busy, and needed some time to digest
> your email.

No problem.

> 
> On Tue, Aug 27, 2024 at 12:01:28PM -0400, Liam R. Howlett wrote:
> > * Nam Cao <namcao@linutronix.de> [240827 03:59]:
> > > On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> > > > * Nam Cao <namcao@linutronix.de> [240825 11:29]:
> > > > > When a virtual memory area (VMA) gets splitted, memtype_rbroot's entries
> > > > > are not updated. This causes confusion later on when the VMAs get
> > > > > un-mapped, because the address ranges of the splitted VMAs do not match the
> > > > > address range of the initial VMA.
> > > > > 
> > > > > For example, if user does:
> > > > > 
> > > > > 	fd = open("/some/pci/bar", O_RDWR);
> > > > > 	addr = mmap(0, 8192, PROT_READ, MAP_SHARED, fd, 0);
> > > > > 	mprotect(addr, 4096, PROT_READ | PROT_WRITE);
> > > > > 	munmap(p, 8192);
> > 
> > What is p?  By the comments below, you mean addr here?
> Yes, it should be addr. Sorry about that.
> 
> > 
> > > > > 
> > > > > with the physical address starting from 0xfd000000, the range
> > > > > (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> > > > > 
> > > > > After mprotect(), the initial range gets splitted into
> > > > > (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> > > > > 
> > > > > Then, at munmap(), the first range does not match any entry in
> > > > > memtype_rbroot, and a message is seen in dmesg:
> > > > > 
> > > > >     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> > > > > 
> > > > > The second range still matches by accident, because matching only the end
> > > > > address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> > > > > (x86/mm/pat: Change free_memtype() to support shrinking case)).
> > > > 
> > > > Does this need a fixes tag?
> > > 
> > > Yes, it should have
> > > 	Fixes: 2e5d9c857d4e ("x86: PAT infrastructure patch")
> > > thanks for the reminder.
> > 
> > That commit is from 2008, is there a bug report on this issue?
> 
> Not that I am aware of. I'm not entirely sure why, but I would guess due to
> the combination of:
> - This is not an issue for pages in RAM
> - This only happens if VMAs are splitted
> - The only user-visible effect is merely a pr_info(), and people may miss it.
> 
> I only encountered this issue while "trying to be smart" with mprotect() on
> a portion of mmap()-ed device memory, I guess probably not many people do
> that.

Or test it.  I would have though some bots would have caught this.
Although the log message is just pr_info()?  That seems wrong - we have
an error in the vma tree or the PAT tree and it's just an info printk?

...

> > So your comment about the second range still matching by accident is
> > misleading - it's not matched at all because you are searching for the
> > exact match or the end address being the same (which it isn't in your
> > interval tree).
> 
> But the second range *does* match, because the end address match?
> The second range is (0xfd001000-0xfd002000), which matches with
> (0xfd000000-0xfd002000) in the interval tree.
> 
> Perhaps I should be clearer in the description..

I see, yes.  The error is with the first entry not being found.

...
> > 
> > So the interval split should occur when the PAT changes and needs to be
> > tracked differently.  This does not happen when the vma is split - it
> > happens when a vma is removed or when the PAT is changed.
> > 
> > And, indeed, for the mremap() shrinking case, you already support
> > finding a range by just the end and have an abstraction layer.  The
> > problem here is that you don't check by the start - but you could.  You
> > could make the change to memtype_erase() to search for the exact, end,
> > or start and do what is necessary to shrink off the front of a region as
> > well.
> 
> I thought about this solution initially, but since the interval tree allow
> overlapping ranges, it can be tricky to determine the "best match" out
> of the overlapping ranges. But I agree that this approach (if possible)
> would be better than the current patch.
> 
> Let me think about this some more, and I will come back later.

Reading this some more, I believe you can detect the correct address by
matching the start address with the smallest end address (the smallest
interval has to be the entry created by the vma mapping).

> 
> > 
> > What I find very strange is that 2039e6acaf94 ("x86/mm/pat: Change
> > free_memtype() to support shrinking case") enables shrinking of
> > VM_PFNMAP, but doesn't allow shrinking the end address.  Why is one
> > allowed and the other not allowed?
> 
> Not really sure what you mean. I think you are ultimately asking why that
> commit only matches end address, and not start address? That's because
> mremap() may shrink a VMA from [start, end] to [start, new_end] (with
> new_end < end). In that case, the range [new_end, end] would be removed
> from the interval tree, and that commit wants to match [new_end, end] to
> [start, end].
> And I don't think mremap() can shrink [start, end] to [new_start, end]?

Even an untrack_pfn() call will only remove the first entry that
matches exactly or the end.  Since the tree is sorted by start address,
I guess the smallest (since it's not specified if it's ordered
descending or ascending, and smaller makes more sense) interval will be
deleted?  That is, a vma cannot span different attributes but attributes
can span vmas.

Oh wow, this also means if you unmap the end vma first, you will not
have an issue because the memtype_erase() (incorrectly named now) will
resize your PAT entry to match the start vma range.

I wonder what would happen in the "punch a hole" scenario where we
move/MAP_FIXED/unmap the middle of a vma.

My point is that it is unclear as to how the interval tree tracks the
PAT to vma mappings (a more clean comment would be nice). It seems
inconsistent and the situation you found should be handled in the
translation layer, and not the generic code.

Thanks,
Liam

