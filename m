Return-Path: <linux-kernel+bounces-193901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF128D33D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFC21F23242
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A216EC0C;
	Wed, 29 May 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="cJ6BwDvl"
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020002.outbound.protection.outlook.com [52.101.165.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EF16E89A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976721; cv=fail; b=u030i1KdJ5/1wLT/xjjmvDsVy5BfM5ZNgiKR4qjanvGKBfn0n7cqKdVUr6OxQ/H7F5AhNqc66ecMW3BIDTVA7SM/TW4+bMb5DjuS5B9PWd8RQbrDBa3HJ2eJfFWRYMpplChwoIQJcL3BWIapvQkPdNHRbfAmbaHK7tR4DnuEuM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976721; c=relaxed/simple;
	bh=Jd3PWnXcGr1kq+RtXGnEeVagweK907BGRRTqKzvNY8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzFkoW99CC6qjnnwKYfZK0gN8xdfA0GMGjWsOT/lZIu4MbmgDYu7v5CVKRu0exvjwFjquN7By4+kor6jBFIDi5MdxsN3nQUb6E80L5sVOL7osLF/IGZ+RMxmbEFTNVMTJxYdqHbdtQfc/3zQpsHluVIZCKkxleX4E5tzUrTI3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=cJ6BwDvl; arc=fail smtp.client-ip=52.101.165.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2REusknzmHToxsO968QKzkUOeOokcJ5wzvg+sQFgMtEThuXO9VQzVT7EH7AMS5u3lvycQGru3IcSSkxjP0UoGF5ihaxvHY5DpUYgNNrTSUC8HrQLEQPMcLgJiMkxVIFLjCiJ5jymC16lU+5N5MMDCNDQ6dvH2AM09tFzbPyCPshqwIKSFGinKIpABEHOZGpEmGXQ0SI0OgZ778kpSAz5NRPZ4/xMt/Bd1fJXS90g6a8TPDZyd0yTEFi4538nMNGYR5pYRh1Ae8azcyBtjM3MNpeTLv/RiLfJm4agwOewQmJZ/cEyLO/c1CuTcBQ+JaW1IF1NK9YxCALc0W8AZirjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd3PWnXcGr1kq+RtXGnEeVagweK907BGRRTqKzvNY8Y=;
 b=NcTvevTlGtsN5IeGEBr5Ky1Ls0VJsDJ3OteQoXCzWPd99JsbLlAaD+uOSi/jguV8mQxu/DUYCTa00KLXptSuWDlFZeaa/7mflir6RUNGL/WMnawU5eTWSsifXPD+OpxX6UGZG9MmuV+rfWWa3G7MzcclS/yQMs5pMXUEERfhm8jNL7IGFP67V0XX1Mj5GbRSd3f5XQAKmWzbPT0Fhk+tA08C4dbopNrLuTDwrj7WcvOqYeXJSekyYn2uM9VbSTu/IQa95h0wi1Pno772qnnk1Kn+D0R4EjguC76bkBXNnvY6DpX8+2Ne4K2+3Nx0NcZvgn/NtA3Nck8H45YMx5Tr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd3PWnXcGr1kq+RtXGnEeVagweK907BGRRTqKzvNY8Y=;
 b=cJ6BwDvlS4KpeqdMIE//dYng35RB44ZK95iyol01Wp1RL7teTj9c6taquG+zvpGpVfiFDgSA5GBhLh09enyRDUASF6SDgAapWNNmP2d4A0PE49we0G6Oan9kRoNpU7aHmULMZEUZCDiEGR0nrDEjMRDiufUoMufVWfPIm/IxyB3kYaSEQ7KAA3wYSOrKPQl7MtfR/u/lDsaNjCvuvgsW7n7isSy6i4IEE62yyl6N1i2Ru0KV81G74oYRtTJHzFx40x9Cxn9rmHeIwyv95QdfIZV92y0xYbEhIai0UAbygpe5hCRM/miIufqClzN9eDPjbhzj/epRMzTylDA0MlJxvA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR0P264MB5209.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 09:58:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::96ff:7284:1fa1:b02a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::96ff:7284:1fa1:b02a%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 09:58:36 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Oscar Salvador <osalvador@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v4 13/16] powerpc/e500: Use contiguous PMD instead of
 hugepd
Thread-Topic: [RFC PATCH v4 13/16] powerpc/e500: Use contiguous PMD instead of
 hugepd
Thread-Index: AQHasDoZLKencktwvU2i8Pkb0dFo2bGt6b6AgAATV4A=
Date: Wed, 29 May 2024 09:58:35 +0000
Message-ID: <b95f61ea-b40c-4d7c-9a39-7bf927f7b0cd@csgroup.eu>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <56cf925576285e2b97550f4f7317183d98d596c5.1716815901.git.christophe.leroy@csgroup.eu>
 <ZlbsEb_T2eQYO-g4@localhost.localdomain>
In-Reply-To: <ZlbsEb_T2eQYO-g4@localhost.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR0P264MB5209:EE_
x-ms-office365-filtering-correlation-id: 55914fe9-9b4f-4547-11de-08dc7fc5e824
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?anB1VkhSRTd1dUlkS1U1Rk1mY3h0R2xheS9PeG1jQmN4U0dLK0k4L1JuVm42?=
 =?utf-8?B?OUkyck9ScWdoZi9vNGVHMzZaL1MrMlVCbXBJUW9VV1VJMFl0NG9NQWN2Zkx0?=
 =?utf-8?B?YnlUbjJiL2lyWllDZUg1c0RxbStpTWlqcXQyRUsxMUVFTFRDa2xWSWdOSU80?=
 =?utf-8?B?MHBkTmlYV0ZwU0lNV2h1emN0UjNQUmlkQytsWHd5L2hKd3lTc2haY1FKek12?=
 =?utf-8?B?dWRVdEx5Z3lRbGZiM3AvZnNaaXIwTFI2emkrSlBjRUpuRGlHdGZVc0g1NWNu?=
 =?utf-8?B?UmV1L2piTFJpYnB1cEZ2R09DdFNpZXhscy9hR3R1VUpRYmFSbUpza3drdWFx?=
 =?utf-8?B?bGl0N1dFb1paMkVDSzdPdWxsS2h2YkhBRlYvUjBnL0g0cnBneVF0aEkwa1B3?=
 =?utf-8?B?ZzU3TW9jY1E4SEo4dUh6aHNUemc5N01sUkwwb2F4cExaYk9IU0UrUmgzcUNs?=
 =?utf-8?B?dkErbmNHYzhBYkhpNGZUcnVCbFc0NzdLYXlIRGtROXRJV1RwQUV4Y3pNbTYr?=
 =?utf-8?B?aWs3NTVURFI0ZmVRQ0FTd1JJeGxMSGl1cEV0YVdzYStOUTZQS1k1RmswYnJo?=
 =?utf-8?B?SGlWTDdXeGJWNmdNL0k5Y244WEVYTUdCZkxDejlGeVpibHVrN0NsbXpJd3lR?=
 =?utf-8?B?aG94Yi9WMW1NMERKTkJYZHZadkFBc2ZZMGJCVGdHSjVZN0ZjNnh1LzRpdGhi?=
 =?utf-8?B?YUJ6S3hoUHhvZ29UcnBqZE51cFRrRTlVMFM4UzBYTGtPMEZ0dStWdTUxcTNn?=
 =?utf-8?B?MkZNc3p4d2J5bkJxVVgzZnVoSk11YzAwV1JENkgzYTJKRS9NczlHdnVZOXhE?=
 =?utf-8?B?bmlWNVRLb0ZTRVpEbG1ITXdoRFdwTnQxNXBmL2phY3BsQWlOOXQ1MWpkOGg1?=
 =?utf-8?B?ZEMzTllRM3lRMnVYWmR6cXVONDhJRi85VjBXbExWVW1sVTBobjl6WDZ0MUNa?=
 =?utf-8?B?WnVyalFiN2hac3ordXh2aGJDZEZyaFFnczdmVlVWY1NiZzZQSGt3UFU3MlVl?=
 =?utf-8?B?TmplOFhnNkdielRIMVhYbHlRUWRCM2ZEN3p4Rzc4d2xtTUVIWndRQWp6VGNN?=
 =?utf-8?B?QzR5WXpkdkwvZ3JIcHk3QUMzN25Pd3pkd2I5RkVablhxOStlTXRGdkRpT0Vn?=
 =?utf-8?B?QmdRRm9SUE9pMTFJMVJoQmlQSW44NGpxQWt6R29KcTB6eGxDTlgwVnUzS3V2?=
 =?utf-8?B?SVJiRTZsdVFxSlpCU1ZpMkMxaEV5ZDdZUm5wdHV4RFVPVG1JTUhWdGNFdHp5?=
 =?utf-8?B?OWZuajVmQU53T0I0Nms4U0NRSXUvUVJ4b2gwYmE3SGhiUVFKTHl1ZmVZdGU1?=
 =?utf-8?B?UHRmZHBPUjVhT2tkYmdBQUY2QXYxZnlBc2hENlJ3U3NvSmxFY2FyS2FHOVNl?=
 =?utf-8?B?ZHl3OUlRUFVaejhRNDJlTm9YNUhKZURMMzlqb081Q2RNN2pkb3I2S3hmRWt5?=
 =?utf-8?B?UkV5VmcrNGp6dDlyWVRhdzhSNktERFBtcElEb05rZEpXZG9yRDFIU0JPK0N4?=
 =?utf-8?B?N2JNdmV1YXlMQmk4cHpVQ2RMOXRJTWNEemdKazhQYjZQVko4ZERHT0VKM3pM?=
 =?utf-8?B?bllXRFc1YXlaeGhtSUVKMXcwWlFFZU1zcXE0eGdjTlk2bTd2MVEvVGx5a2dY?=
 =?utf-8?B?THpzWmE3dVhadVh3WE0xeUFnS1laREtsVnovUHoyazZLczd3NXNIaTZoeDhT?=
 =?utf-8?B?Y2t2ajVZWTRjUG5EbXFMT0UrVjhPU3IyODRaYUFBUkhrSnFVZjhIczZzSVU5?=
 =?utf-8?B?cCtMb2lNMWErQnJhTmpmOUl3bndCSFdSSXlNcVNidHU0YjhWL1NWZUY2ZGQ5?=
 =?utf-8?B?UzNjeXVVSEYwdDBMYXR1UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3l6NWM4amtiOFdpMXBpa1VzY0RWK2cxYUkxV3FTaXhFVjJycGs1WEdFSm5v?=
 =?utf-8?B?MmVwNGdHYWdXTjcyd1VDakMyZm05WS8yc29pNkwxcjcweWtqalg3aElXeGQ5?=
 =?utf-8?B?eDdlZXIzSU5SQXhDKzJDV0ZmRllVZ1YvVEN1azA3ckllUE9aREZIZ1V0VFNr?=
 =?utf-8?B?Qi9SWHZVTVJVRWRSOWMyV3VGU2lDUHdRa2lYdHpMOEpOWGlOcTh3dGQ5UXdR?=
 =?utf-8?B?YnE4MlN1ajc4bVlGUmoyVWJEazBuUjJoUXB3UTVrTzhvbkZTbkVHcHBxTHFE?=
 =?utf-8?B?NWc3eXN3aExNSXd2d1R4bGpnc2x2OGRXbFNXcFEwS0M2SlkyOGNPS3JSNFUw?=
 =?utf-8?B?V1RlR3NXdThnaUVFZTVHWGZUUkw4TVkvYVpYeVk3cnhZNXZBVEJTZ1MrMk5Y?=
 =?utf-8?B?U1RCTkhQZjc2UDVmcEdTUG4xcHRaOXZobUdibmJMSlYySEhhbXc0MG5uWkxI?=
 =?utf-8?B?TDEzSVNCUjUyMXRSOHdQSktzY1h2V1g1QUxRWnR1YTBVZlhtdUk0Q295eFVV?=
 =?utf-8?B?TjhLWExZMFMrR2poQU1UbmdGVi9LOVZPK0FqcFB5eE91amxSSHZuQVVETEhQ?=
 =?utf-8?B?ZFdnRkNFQmx0YnZtWkNKUXhJUk1mVWtrNTVBT0pUKzM2Q1laS1NTdFBOS1N3?=
 =?utf-8?B?eHkrWWhPa0JjMW80bFJEMnBvY3hRdnp0aXNvK0RoWG43QUFXemdtUVc4QmJD?=
 =?utf-8?B?Z01KeUFLcW5hVVh1a2x6T1ExVzdjeGhVRENmNlBtR3JpZ3JGbnFkMHR6MXlJ?=
 =?utf-8?B?QU8vYWcwcnB0TGFEOHNmQTVjZmliRjBxYjlBeE9lSUJRSE1FSXY0a1p2RjZ2?=
 =?utf-8?B?Z3dJM2ZWY2xnWTBHT3RyOUtwcW1kb2F2Vk05LzhvdkRlYlh2YVYyOTljMXlv?=
 =?utf-8?B?dCs0eXdwQjdJeWd6bkZJcnNsa1ZGWWFFbDN4TUh5Y1VjMlVvOTJrSzR3aXJa?=
 =?utf-8?B?Z3MxSk12WUIyM1BUVi9tNUF3czhzUGVzengzTkNIbktrSzlwRG5ULzUrMm9M?=
 =?utf-8?B?Qk03VEI5VVF6d3FocnJNZWJvbEc2WU1aOWNMMHVGbFhwSmU1WCthOUt6Smk5?=
 =?utf-8?B?UlI4N1BSaXRxRzdaOWE0eERrSGFNall4ZHlqdVRZWE9HdCt5emdpSXdQdVJP?=
 =?utf-8?B?VFFFczRMVDFWWWpLRS9iRXd3SkIrQjkxVjVHQ0xZLzRqY29ocnAxam04aFFT?=
 =?utf-8?B?YUllN2daKzFLMjdHWC93bnpBZFY2SUJSNkw4bnNhRTlHZTV2Q1dsOGpXVVFF?=
 =?utf-8?B?K1o3dUNzeld4blJzMzdTUnY0L2hhdDVMdStHQzU1N1lIY0g5WTJlVFRtNDVm?=
 =?utf-8?B?b1NiUzU0Qjc4VXhQMitFNWdWR2VyRHlnTzJsWldidGN3eDlZSjBQa25FUUw0?=
 =?utf-8?B?WFdzRnIwRVJQVms5ZkZYTlFvS1d0UnJ4bTBqOFdYWExsUFIyUE1ZYlloMERD?=
 =?utf-8?B?Vi9tQUV0enNBd3lYa1hQakNiM25OYThOc3pVMWVhQTNta1RlMkR3T3cwcW04?=
 =?utf-8?B?eDl1Z0xCWC8wNzdEMWNKbys0TUpwN0Eza3R6TXd0RmJaQmhYUkg0SkFrY0ta?=
 =?utf-8?B?cEZ2VGlZVERTSmxad3JxbFpPcmdYbnowa0phSCtjRzIvelFKWTBRTGdUdjMw?=
 =?utf-8?B?Uk52c2dhSW1nOUl2ZElpd0ZWWGtlYXlTM0VXU0FLWWt3MXBqcTdzSjd6Qks4?=
 =?utf-8?B?WG05N1lHQVZZcUNHVmJDTzFhbUplUENjMXJDTnUyR0JaSEhWSG1kNmlHSHZo?=
 =?utf-8?B?V1V5WkV4cERiS2lyVy8yY0I2L3hlZ1hHbTkweDlyd2pyUGlQMktXV0J1NnRy?=
 =?utf-8?B?OGt4UElLSnBHNkMrMVRDSkxQeEYxclBTV3BkMVl5aFI1aW1MejFsU3YxSFgx?=
 =?utf-8?B?bEVYc2p6VEVub25nRG5SeDN2Q24vbDY4YWFQd3ZaMit4eTg1QUVmTE1wV0RN?=
 =?utf-8?B?aktkNjNGN0Z0L09PdUlmWU4zeUhrdTkwVWMyc3JNemYzKzJUUnZGRHJlRkFm?=
 =?utf-8?B?MU0vc0l4dDhubGxIN1YyYnlnRGVaN2xTV0pPT2RhNXZEVGRRR2l2UDZSVy9o?=
 =?utf-8?B?Vjd1R3B3SUxjWER0eDIrQmtLK0cxQjV0bWs3anlESGg5TGtHT2JEQUYwMmNX?=
 =?utf-8?Q?lBMnN7uleo/YnsheLTwxDJTKD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <751E099259F0734EA05809E454B685D9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55914fe9-9b4f-4547-11de-08dc7fc5e824
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 09:58:35.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B16pwzvQN3bWs1jxy5WfU76dnZ8EQ29lrJCBDs+nxKh80Vn9cMBllGXh+jj9cfC7mI6WiFYg1aBDrRV7XDbf0tu7slmeVBnwhJ5AITqnnMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5209

DQoNCkxlIDI5LzA1LzIwMjQgw6AgMTA6NDksIE9zY2FyIFNhbHZhZG9yIGEgw6ljcml0wqA6DQo+
IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIG9zYWx2YWRvckBz
dXNlLmNvbS4gRD9jb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCA/IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBPbiBNb24sIE1h
eSAyNywgMjAyNCBhdCAwMzozMDoxMVBNICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0K
Pj4gZTUwMCBzdXBwb3J0cyBtYW55IHBhZ2Ugc2l6ZXMgYW1vbmcgd2hpY2ggdGhlIGZvbGxvd2lu
ZyBzaXplIGFyZQ0KPj4gaW1wbGVtZW50ZWQgaW4gdGhlIGtlcm5lbCBhdCB0aGUgdGltZSBiZWlu
ZzogNE0sIDE2TSwgNjRNLCAyNTZNLCAxRy4NCj4+DQo+PiBPbiBlNTAwLCBUTEIgbWlzcyBmb3Ig
aHVnZXBhZ2VzIGlzIGV4Y2x1c2l2ZWx5IGhhbmRsZWQgYnkgU1cgZXZlbg0KPj4gb24gZTY1MDAg
d2hpY2ggaGFzIEhXIGFzc2lzdGFuY2UgZm9yIDRrIHBhZ2VzLCBzbyB0aGVyZSBhcmUgbm8NCj4+
IGNvbnN0cmFpbnRzIGxpa2Ugb24gdGhlIDh4eC4NCj4+DQo+PiBPbiBlNTAwLzMyLCBhbGwgYXJl
IGF0IFBHRC9QTUQgbGV2ZWwgYW5kIGNhbiBiZSBoYW5kbGVkIGFzDQo+PiBjb250LVBNRC4NCj4+
DQo+PiBPbiBlNTAwLzY0LCBzbWFsbGVyIG9uZXMgYXJlIG9uIFBNRCB3aGlsZSBiaWdnZXIgb25l
cyBhcmUgb24gUFVELg0KPj4gQWdhaW4sIHRoZXkgY2FuIGVhc2lseSBiZSBoYW5kbGVkIGFzIGNv
bnQtUE1EIGFuZCBjb250LVBVRCBpbnN0ZWFkDQo+PiBvZiBodWdlcGQuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0K
PiANCj4gLi4uDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9u
b2hhc2gvcGd0YWJsZS5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL25vaGFzaC9wZ3RhYmxl
LmgNCj4+IGluZGV4IDkwZDZhMDk0M2IzNS4uZjc0MjFkMWExNjkzIDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL25vaGFzaC9wZ3RhYmxlLmgNCj4+ICsrKyBiL2FyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvcGd0YWJsZS5oDQo+PiBAQCAtNTIsMTEgKzUyLDM2
IEBAIHN0YXRpYyBpbmxpbmUgcHRlX2Jhc2ljX3QgcHRlX3VwZGF0ZShzdHJ1Y3QgbW1fc3RydWN0
ICptbSwgdW5zaWduZWQgbG9uZyBhZGRyLCBwDQo+PiAgIHsNCj4+ICAgICAgICBwdGVfYmFzaWNf
dCBvbGQgPSBwdGVfdmFsKCpwKTsNCj4+ICAgICAgICBwdGVfYmFzaWNfdCBuZXcgPSAob2xkICYg
fihwdGVfYmFzaWNfdCljbHIpIHwgc2V0Ow0KPj4gKyAgICAgdW5zaWduZWQgbG9uZyBzejsNCj4+
ICsgICAgIHVuc2lnbmVkIGxvbmcgcGRzaXplOw0KPj4gKyAgICAgaW50IGk7DQo+Pg0KPj4gICAg
ICAgIGlmIChuZXcgPT0gb2xkKQ0KPj4gICAgICAgICAgICAgICAgcmV0dXJuIG9sZDsNCj4+DQo+
PiAtICAgICAqcCA9IF9fcHRlKG5ldyk7DQo+PiArI2lmZGVmIENPTkZJR19QUENfRTUwMA0KPj4g
KyAgICAgaWYgKGh1Z2UpDQo+PiArICAgICAgICAgICAgIHN6ID0gMVVMIDw8ICgoKG9sZCAmIF9Q
QUdFX0hTSVpFX01TSykgPj4gX1BBR0VfSFNJWkVfU0hJRlQpICsgMjApOw0KPj4gKyAgICAgZWxz
ZQ0KPiANCj4gSSB0aGluayB0aGlzIHdpbGwgbm90IGNvbXBpbGUgd2hlbiBDT05GSUdfUFBDXzg1
eHggJiYgIUNPTkZJR19QVEVfNjRCSVQuDQoNClllcywgSSBnb3QgYSBmZWVkYmFjayBvbiB0aGlz
IGZyb20gdGhlIHJvYm90cy4NCg0KPiANCj4gWW91IGhhdmUgZGVjbGFyZWQgX1BBR0VfSFNJWkVf
TVNLIGFuZCBfUEFHRV9IU0laRV9TSElGVCBpbg0KPiBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
bm9oYXNoL2h1Z2V0bGItZTUwMC5oLg0KPiANCj4gQnV0IGh1Z2V0bGItZTUwMC5oIGlzIG9ubHkg
aW5jbHVkZWQgaWYgQ09ORklHX1BQQ184NXh4ICYmIENPTkZJR19QVEVfNjRCSVQNCj4gKHNlZSBh
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoLzMyL3BndGFibGUuaCkuDQo+IA0KPiANCj4g
DQo+PiArI2VuZGlmDQo+PiArICAgICAgICAgICAgIHN6ID0gUEFHRV9TSVpFOw0KPj4gKw0KPj4g
KyAgICAgaWYgKCFodWdlIHx8IHN6IDwgUE1EX1NJWkUpDQo+PiArICAgICAgICAgICAgIHBkc2l6
ZSA9IFBBR0VfU0laRTsNCj4+ICsgICAgIGVsc2UgaWYgKHN6IDwgUFVEX1NJWkUpDQo+PiArICAg
ICAgICAgICAgIHBkc2l6ZSA9IFBNRF9TSVpFOw0KPj4gKyAgICAgZWxzZSBpZiAoc3ogPCBQNERf
U0laRSkNCj4+ICsgICAgICAgICAgICAgcGRzaXplID0gUFVEX1NJWkU7DQo+PiArICAgICBlbHNl
IGlmIChzeiA8IFBHRElSX1NJWkUpDQo+PiArICAgICAgICAgICAgIHBkc2l6ZSA9IFA0RF9TSVpF
Ow0KPj4gKyAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICBwZHNpemUgPSBQR0RJUl9TSVpFOw0K
Pj4gKw0KPj4gKyAgICAgZm9yIChpID0gMDsgaSA8IHN6IC8gcGRzaXplOyBpKyssIHArKykgew0K
Pj4gKyAgICAgICAgICAgICAqcCA9IF9fcHRlKG5ldyk7DQo+PiArICAgICAgICAgICAgIGlmIChu
ZXcpDQo+PiArICAgICAgICAgICAgICAgICAgICAgbmV3ICs9ICh1bnNpZ25lZCBsb25nIGxvbmcp
KHBkc2l6ZSAvIFBBR0VfU0laRSkgPDwgUFRFX1JQTl9TSElGVDsNCj4gDQo+IEkgZ3Vlc3MgJ25l
dycgY2FuIGJlIDAgaWYgcHRlX3VwZGF0ZSgpIGlzIGNhbGxlZCBvbiBiZWhhdmUgb2YgY2xlYXJp
bmcgdGhlIHB0ZT8NCg0KSXQgaXMgZXhhY3RseSB0aGF0LCBhbmQgd2l0aG91dCB0aGF0IHZlcmlm
aWNhdGlvbiBJIGhhZCBwbWRfYmFkKCkgDQpyZXR1cm5pbmcgYmFkIHBtZHMgYWZ0ZXIgZnJlZWlu
ZyBwYWdlIHRhYmxlcy4NCg0KPiANCj4+ICtzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgcG1k
X2xlYWZfc2l6ZShwbWRfdCBwbWQpDQo+PiArew0KPj4gKyAgICAgcmV0dXJuIDFVTCA8PCAoKChw
bWRfdmFsKHBtZCkgJiBfUEFHRV9IU0laRV9NU0spID4+IF9QQUdFX0hTSVpFX1NISUZUKSArIDIw
KTsNCj4gDQo+IENhbiB3ZSBoYXZlIHRoZSAnMjAnIHNvbWV3aGVyZSBkZWZpbmVkIHdpdGggYSBj
b21tZW50IG9uIHRvcCBleHBsYWluaW5nDQo+IHdoYXQgaXMgc28gaXQgaXMgbm90IGEgbWFnaWMg
bnVtYmVyPw0KPiBPdGhlcndpc2UgcGVvcGxlIG1pZ2h0IGNvbWUgbG9vayBhdCB0aGlzIGFuZCB3
b25kZXIgd2h5IDIwLg0KDQpZZXMgSSBub3cgaGF2ZSA6DQoNCisjZGVmaW5lIF9QQUdFX0hTSVpF
X01TSyAoX1BBR0VfVTAgfCBfUEFHRV9VMSB8IF9QQUdFX1UyIHwgX1BBR0VfVTMpDQorI2RlZmlu
ZSBfUEFHRV9IU0laRV9TSElGVCAgICAgICAgICAgICAgMTQNCisjZGVmaW5lIF9QQUdFX0hTSVpF
X1NISUZUX09GRlNFVCAgICAgICAyMA0KDQphbmQgaGF2ZSBhZGRlZCBhIGhlbHBlciB0byBhdm9p
ZCBkb2luZyB0aGUgY2FsY3VsYXRpb24gYXQgc2V2ZXJhbCBwbGFjZXM6DQoNCitzdGF0aWMgaW5s
aW5lIHVuc2lnbmVkIGxvbmcgcHRlX2h1Z2Vfc2l6ZShwdGVfdCBwdGUpDQorew0KKyAgICAgICBw
dGVfYmFzaWNfdCB2YWwgPSBwdGVfdmFsKHB0ZSk7DQorDQorICAgICAgIHJldHVybiAxVUwgPDwg
KCgodmFsICYgX1BBR0VfSFNJWkVfTVNLKSA+PiBfUEFHRV9IU0laRV9TSElGVCkgKyANCl9QQUdF
X0hTSVpFX1NISUZUX09GRlNFVCk7DQorfQ0KDQoNCj4gDQo+PiAtLS0gYS9hcmNoL3Bvd2VycGMv
bW0vcGd0YWJsZS5jDQo+PiArKysgYi9hcmNoL3Bvd2VycGMvbW0vcGd0YWJsZS5jDQo+PiBAQCAt
MzMxLDYgKzMzMSwzNyBAQCB2b2lkIHNldF9odWdlX3B0ZV9hdChzdHJ1Y3QgbW1fc3RydWN0ICpt
bSwgdW5zaWduZWQgbG9uZyBhZGRyLCBwdGVfdCAqcHRlcCwNCj4+ICAgICAgICAgICAgICAgIF9f
c2V0X2h1Z2VfcHRlX2F0KHBtZHAsIHB0ZXAsIHB0ZV92YWwocHRlKSk7DQo+PiAgICAgICAgfQ0K
Pj4gICB9DQo+PiArI2VsaWYgZGVmaW5lZChDT05GSUdfUFBDX0U1MDApDQo+PiArdm9pZCBzZXRf
aHVnZV9wdGVfYXQoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkciwgcHRl
X3QgKnB0ZXAsDQo+PiArICAgICAgICAgICAgICAgICAgcHRlX3QgcHRlLCB1bnNpZ25lZCBsb25n
IHN6KQ0KPj4gK3sNCj4+ICsgICAgIHVuc2lnbmVkIGxvbmcgcGRzaXplOw0KPj4gKyAgICAgaW50
IGk7DQo+PiArDQo+PiArICAgICBwdGUgPSBzZXRfcHRlX2ZpbHRlcihwdGUsIGFkZHIpOw0KPj4g
Kw0KPj4gKyAgICAgLyoNCj4+ICsgICAgICAqIE1ha2Ugc3VyZSBoYXJkd2FyZSB2YWxpZCBiaXQg
aXMgbm90IHNldC4gV2UgZG9uJ3QgZG8NCj4+ICsgICAgICAqIHRsYiBmbHVzaCBmb3IgdGhpcyB1
cGRhdGUuDQo+PiArICAgICAgKi8NCj4+ICsgICAgIFZNX1dBUk5fT04ocHRlX2h3X3ZhbGlkKCpw
dGVwKSAmJiAhcHRlX3Byb3Rub25lKCpwdGVwKSk7DQo+PiArDQo+PiArICAgICBpZiAoc3ogPCBQ
TURfU0laRSkNCj4+ICsgICAgICAgICAgICAgcGRzaXplID0gUEFHRV9TSVpFOw0KPj4gKyAgICAg
ZWxzZSBpZiAoc3ogPCBQVURfU0laRSkNCj4+ICsgICAgICAgICAgICAgcGRzaXplID0gUE1EX1NJ
WkU7DQo+PiArICAgICBlbHNlIGlmIChzeiA8IFA0RF9TSVpFKQ0KPj4gKyAgICAgICAgICAgICBw
ZHNpemUgPSBQVURfU0laRTsNCj4+ICsgICAgIGVsc2UgaWYgKHN6IDwgUEdESVJfU0laRSkNCj4+
ICsgICAgICAgICAgICAgcGRzaXplID0gUDREX1NJWkU7DQo+PiArICAgICBlbHNlDQo+PiArICAg
ICAgICAgICAgIHBkc2l6ZSA9IFBHRElSX1NJWkU7DQo+PiArDQo+PiArICAgICBmb3IgKGkgPSAw
OyBpIDwgc3ogLyBwZHNpemU7IGkrKywgcHRlcCsrLCBhZGRyICs9IHBkc2l6ZSkgew0KPj4gKyAg
ICAgICAgICAgICBfX3NldF9wdGVfYXQobW0sIGFkZHIsIHB0ZXAsIHB0ZSwgMCk7DQo+PiArICAg
ICAgICAgICAgIHB0ZSA9IF9fcHRlKHB0ZV92YWwocHRlKSArICgodW5zaWduZWQgbG9uZyBsb25n
KXBkc2l6ZSAvIFBBR0VfU0laRSA8PCBQRk5fUFRFX1NISUZUKSk7DQo+IA0KPiBZb3UgY2FuIHVz
ZSBwdGVfYWR2YW5jZV9wZm4oKSBoZXJlPyBKdXN0IGdpdmUgaGF2ZQ0KPiANCj4gICBuciA9ICh1
bnNpZ25lZCBsb25nIGxvbmcpcGRzaXplIC8gUEFHRV9TSVpFIDw8IFBGTl9QVEVfU0hJRlQpDQo+
ICAgcHRlX2FkdmFuY2VfcGZuKHB0ZSwgbnIpDQoNClRoYXQncyB3aGF0IEkgZGlkIGJlZm9yZSBi
dXQgaXQgZGlkbid0IHdvcmsuIFRoZSBwcm9ibGVtIGlzIHRoYXQgDQpwdGVfYWR2YW5jZV9wZm4o
KSB0YWtlcyBhIGxvbmcgbm90IGEgbG9uZyBsb25nOg0KDQpzdGF0aWMgaW5saW5lIHB0ZV90IHB0
ZV9hZHZhbmNlX3BmbihwdGVfdCBwdGUsIHVuc2lnbmVkIGxvbmcgbnIpDQp7DQoJcmV0dXJuIF9f
cHRlKHB0ZV92YWwocHRlKSArIChuciA8PCBQRk5fUFRFX1NISUZUKSk7DQp9DQoNCkFuZCB3aGVu
IEkgY2FsbGVkIGl0IHdpdGggbnIgPSBQTURfU0laRSAvIFBBR0VfU0laRSA9IDJNIC8gNGsgPSA1
MTIsIGFzIA0Kd2UgaGF2ZSBQRk5fUFRFX1NISUZUID0gMjQsIEkgZ290IDUxMiA8PCAyNCA9IDAN
Cg0KPiANCj4gV2hpY2ggJ3N6J3MgY2FuIHdlIGhhdmUgaGVyZT8gWW91IG1lbnRpb25lZCB0aGF0
IGU1MDAgc3VwcG9ydDoNCj4gDQo+IDRNLCAxNk0sIDY0TSwgMjU2TSwgMUcuDQo+IA0KPiB3aGlj
aCBvZiB0aGVzZSBvbmVzIGNhbiBiZSBodWdlPw0KDQpBbGwgYXJlIGh1Z2UuDQoNCj4gDQo+IA0K
PiAtLQ0KPiBPc2NhciBTYWx2YWRvcg0KPiBTVVNFIExhYnMNCg==

