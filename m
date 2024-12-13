Return-Path: <linux-kernel+bounces-445071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FD9F10BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F00C1881A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52D1E2009;
	Fri, 13 Dec 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FGZwoySG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ln10KPqj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27D17B500
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103204; cv=fail; b=Wc39tOfEP9INa2Se76egmRzC9+2rQkjep8X2v/O5VNzP7kXu6KnQ5qD3iYzEunqLCrHm+TknSS9qnYlUleukGzMrK+owQ/8dL8XSApA1/tYJj7DudF7qW5NMlE0+9r4V2DxnOGceML7vgHB4hdTw050nEzfWt4wG+lheHk/Kx3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103204; c=relaxed/simple;
	bh=XIPObF8QBvGIUw95rmxkNsJfsNkx2i2J1olJyxm1LJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CpgZo4PlWwFu8nYGl9qejsXDg01t4qUAECcJauPRLr83u6S94FaNUh0l5sh/AhVNN9dRXKGBaXILDbgGyKbw90Q00GDuPwgpdHeIHQwjTX37SJ98hpnrQkJFBj655WlY6fe4JAomincTIIn87dw7zu6sdIU/0ZqCapQD3TT+wSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FGZwoySG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ln10KPqj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDkBIn019668;
	Fri, 13 Dec 2024 15:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jDV67e4G0kejOE4NLAgjVHC536QKMAa4ZY8icHsSKBI=; b=
	FGZwoySGesyMks1ezLURjMQ3nPbPzw2oTjyu864fAnG9LNXIrzU0PL7aajaFNZAA
	8QleyeJ+eYv/syy+R8iOeebCwQ+M2QBCy0EXXdrk8jvgSoxD6ojRJBVqOnJXYjWF
	CmFtuo6HYbzcpl5cJhg8c6eDsbichZqWTAwGeX2G75I1d0AlsT5+r0o/X70EA4dq
	/MaCs3u2k1S8bPoWXsGo8adiaA3Hx97qkmWIdJ+EmEIUUXw2mbet25FSWjpV3xnR
	q3ZgW3fRT2rGohoraTYdVQLjQPVx9KyPV/qhZG6SyXYa1xZo9LZh7N3czkEtIDuN
	XZXG4j6lYAzBpI1rMvASPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedcdpnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEqZix035650;
	Fri, 13 Dec 2024 15:19:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcum0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsjOzFw9hDpDKKLiYtQpKWnc1YtEs/hBvoCVhWl5mNRqQKVZNPzVK675Sj+GJbMLawqIMfNMe1wlOQd2xqiwGPvOkUysQsgv9BFAgcg5wAJlu6e008ah5JNZxp/OF0LvwcfGleNM9j0Vh+BiorThPy88WmAxQ2ltB53IDlXEoWU2BVxsJgZVeP7ynVq4HsGTqu0FGuPMLbXHxnwHPDSJ820JxpJmvgRTt2ljOXH/r4u2w7iAj9CQp0m8ksCMSS0DLnTd+fOTO5NN3vZsLDTN7NyQ0cQ4I1z0/v/5NSmzOxcSNavqBbFSjvhE55kTJEAisDk8Q/T/T4n/yG2ECQa9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDV67e4G0kejOE4NLAgjVHC536QKMAa4ZY8icHsSKBI=;
 b=bKJdKaXJDan6pZwhSkW4oGoo6VeeK0Zxr0OFMMULXWL1ZUOu6x47Z4f5xZZyx2CbRzTbJnSIIWgNx+T+1KniB58ETBpe+BhA8Oys5QZPNSXqnmuD9H7LlIvJ8OOIe+MagVmO1xEIa/EVkbUjs1RkkjN0yUgTWNCq2fHZrBm+urbx8hNUZrGhaj32j/+boydR8B34Zth4uAc4Rr7X1U4KTP04uwhE6yOsE6iOGUIYP6D2T4ZzB0COhLcg4hMi20PAv4a41bS36CMdTxMUtsByfXC5ChJqfz9Y09R//s9yRqtNzUU7VTNgh+4a1z9Ll64Wti+F564SnjvZQohHsC5RsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDV67e4G0kejOE4NLAgjVHC536QKMAa4ZY8icHsSKBI=;
 b=ln10KPqjBsPZyQq55PHnnxDo1fOQHgl5jp8zBqV0rjAmdPlTwQsnc58sUPv36l4ZB0HbVIU3pmXRuCVlfU6gJJ6PgqTR5KgNPA3b1MF+u1bAVScHXm8A8DroDqaXjz4FSzRacX0wG9hMD9U4Ad2mb643rSKYai+/FkYBT5gULOY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5766.namprd10.prod.outlook.com (2603:10b6:a03:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:19:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:19:49 +0000
Date: Fri, 13 Dec 2024 15:19:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
Message-ID: <62e40a0f-93a1-4b75-b613-e877a12da1bd@lucifer.local>
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
 <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
 <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
 <cb5eea98-2515-4b06-8f65-515842e1081b@lucifer.local>
 <CABi2SkXgTnjiTnBF-dwsf1Wvjo0FngOyHAMw6ba0MAKf1Wr9PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXgTnjiTnBF-dwsf1Wvjo0FngOyHAMw6ba0MAKf1Wr9PQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0517.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 154502d4-f6af-4e26-ba6d-08dd1b899563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dC9ucG0rNnp6Vmhnbnd3SFVOMkhqWmdaQ0JjcHAvbzZTa2NRNGpmNmg5L2xQ?=
 =?utf-8?B?dTdCaHhPK3RWMVZwR1VxM1BaKys4eEVMRVlYL0tDNFdjSzdnZVdCVVErbER6?=
 =?utf-8?B?RWt5QVFNWjNQU1FxajhpYVpPMlIxUlVFMmtxWDUyOHM1Qk9WZWg4UlBqdXdS?=
 =?utf-8?B?S0JTNzVUclJDSG82UmVDYjZhYjY5bmt1YW0xYXNuczlKTFlKUVArYUhJS1B0?=
 =?utf-8?B?MVdWdndRNlFIU2F4WVFSTUY3emR3aDlUU1E2QU54cStqUDRKS2FwZDVHcTN3?=
 =?utf-8?B?VmtSTjBwSUx6SlFTOXEvc2diQmN4TmR3U0hmb3lrcUN2WmpHaTZLdHltM3RO?=
 =?utf-8?B?bGwzcjhFUjl0Y0hLdVdJcE1vN0dqYWpzU2dPV2VacXFqTlFZaEdKV08wWmoz?=
 =?utf-8?B?MmNyZFJnQ1M5Z2Y0U0duSndWekZwNk12TkM3bk5OcWdYenZBMXBBM3JVeUdp?=
 =?utf-8?B?eERvTk14c0ppWDNqQldjcEFPemNJN0ZmS2hNUU0zTmlWd2UyQStiRW43MTZB?=
 =?utf-8?B?QWV3TXZMRDFLTkVOb0xKejBIQWd6enNhUXAvTkpPMlhLVWNGdm5KVEp4LzIz?=
 =?utf-8?B?U1NxUW81RVJENUk2cVFiKy90UG9TNXd4Ry93S1Q2UEk2cmtvVzdPK2YzSUcw?=
 =?utf-8?B?RVFXUWVXMGEwcEY4TWhydktFRmw4YnN1ZXJVQzNKMWN2RHloakh3d09YZzJJ?=
 =?utf-8?B?NjFhNldKaUZPVFlSN203emdrTEJJT1poUjZaZ1FxQ0RwWS9ZMXJqN0NTUXNm?=
 =?utf-8?B?UUlhbEtvbEFkWHVtQk5PVmZmK09kb2tlNVlKWE5QTWRuODhML1BaRDBoVjVt?=
 =?utf-8?B?d2hOMVRkbkxUN1Z2WVM0ZTR2VzlQWDNta3BOM3RHbXVZVWRPYmIvYjUzNjE4?=
 =?utf-8?B?eVhpcmptSityQ0dSQytYajF0bUQzcnNudi8zZDFqdGp6Y1ozZm5jYXptMHlJ?=
 =?utf-8?B?MWJUZXVjVE1kOFV4bDhzblFiZXViR2I4WTBvYmpLbG0xN2xOTHBnd3lXcFp6?=
 =?utf-8?B?TGtrbktPRUJzbkplS3lCUUpHS0xEampGTE1NMHhxNGxTZ3RTUTQ5QW1vQUFt?=
 =?utf-8?B?bGZoV1YyanpHYzJ1bDcvcFZWeE1SaDRrUkxoZTFRNm8zS05zYXlXTkxWK1h1?=
 =?utf-8?B?czZydUtoWXVIcEFlTXIrVllFK1F2RDhyQ1NXV0RVNFhIV1YrbStDV2xCQ1pE?=
 =?utf-8?B?YXlTdEE0b0xsaEtkOGRrRjVPTnhxa3duT0tqN1FtMVBDOXh2ZmdObTFmNE1I?=
 =?utf-8?B?aUwwTytpZzdpOEdNRTB3R0tTblBJeEdhR09kUWpoR2doejZjc0pOL3M5WFc3?=
 =?utf-8?B?NHB0VndPNi80cDVIbjJoWWV0eWI0dlBTSUhRVk5GdUZMUFl1b1RmTzYzSERL?=
 =?utf-8?B?NElJYlpjSFJEekdWM09PYXlpbWowY0VocGFYVWl5Zk85WmVpM1Q5eEwwZGp5?=
 =?utf-8?B?dnhxR0FCbkx0VG9ic095VzVJanltbjVLN1JNWXVycnZLS2trSUkwS1RsVDIw?=
 =?utf-8?B?bFZWekNhUVpyLzJudlA0V0VpeW94dVo5djFDaWJuODhZWXN2cVlyT29KZWFG?=
 =?utf-8?B?bjV1czVBUWNCKzFhVmd2Z2ljOW05M3Rud096RjZ5eE00UGMrMGtQZUNRdFYz?=
 =?utf-8?B?NWdWRkVkckNkOC9ydVBUV1NHU2JSTy9jbzEvcnZjK0toQ1BxYVNKM1ZodWxT?=
 =?utf-8?B?a1lIM25rWmk0VEQrVTlqSTl3eFdUOXMxQis1ME9ZZmtGWk9zVjFqKzVadkMw?=
 =?utf-8?Q?gSIdYVSXiTVwiHKPfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW95MHY4aFRIV28rQWNxT1U2TkJjNmVrREtoSVh3anpRVFZHa3hjNi9qalM1?=
 =?utf-8?B?SHJPcldkNW1UTjVGdUhoUDlhNGs3VUpKcFA5K1JBZjR2R2lubmxIWlAxQWZs?=
 =?utf-8?B?am0vVC9qVDZjVHh5bWZ2OXd5T3djZUV4NlR0WGd2Tjc3eEFjRE9Ed0RlWldq?=
 =?utf-8?B?SmM0R1Bma0Z4cktkQ1llSlZ3UVd4dFIwblJDYVVxK3g1NThDSXhVcXNRQ2ZB?=
 =?utf-8?B?L2RTb0hFazlsbnM2WklpQWhUTEpZbU8zNkI5NGwzenNobjdLZzNjeG80Uk1k?=
 =?utf-8?B?bnROT25oNVE0eDU1dW9sdzZ1eVRpQ0lsbDJXUlluQ2kzUTNpd3U0VDl0WDZE?=
 =?utf-8?B?NGFxa0FsaFA3Z1FSVmJsRElLcCtQeFlKNzRtdjNKc003akRTQmVDNGVEcjgr?=
 =?utf-8?B?YmxtMERpeEIrT3l4Qlc2blc0SmRhMjd1ZXN5NWJValhGSmtYNWJFUWY1ZFJj?=
 =?utf-8?B?VzU3cEFoc3ZRcVcwTUh0bnFObnJVTWt1U0hUZklHc0xFc1RHdUlTOVJxOVUv?=
 =?utf-8?B?bExxbDJsejVIdDZMVDBMNDhldGc4K0xFdnYrSnp3N0hkUGYrcCtzODFTNmVZ?=
 =?utf-8?B?YnZUMG4xc0VJNXFad1BpbUloNy8yMm9OQlJvZVM4c3REZVFLU285TXBHVEVC?=
 =?utf-8?B?eDUzQVNpeWxKMTU4ZGk3UW03YjFkZWFvV1pyamg4NER6TlIyRW1KMXV3aFhF?=
 =?utf-8?B?VndlS1V5blNqRnFOU3JRWVZKc0Jkd3UxWkRVUDQ2VjZRUWlCOVMveFFPVHlS?=
 =?utf-8?B?aE0veXM4bEhTRkJvcUxDVjVxVC8vVTZCbkp3OUN3NkRJdmVqbk5zeDVEL1Fn?=
 =?utf-8?B?NkxvYWNNVlIwSHN5VFVTb203THhrZURXQzBxZzdUbVNHakc0dlZpK0o0cXZs?=
 =?utf-8?B?MjJaSVl4anB5YW9KWGljakRxSVVFUkhyelV4cVFSaG8xcEdMK1Y1a0loQjNs?=
 =?utf-8?B?TXdIR3dCMzY5UUlDTW5aeG93NDhQUUoyaHdSTHFzeVdzVmoyNnhGZWdtL3Q2?=
 =?utf-8?B?OHl0KzJyMWd3SkRLd2JJWEZ4ZTZQMVZDME91K3o1Z2hmTitlUmpVSCtTcGZY?=
 =?utf-8?B?eHdqL0xQQXpER0NLWGNUbkVMN1E3dTQ5d2xxMXEzeTN0R0RXUzdVZ1ZIK0Rx?=
 =?utf-8?B?TlJPbUJQUmdWY3FUZVllNXVDdysrMjFWbXhHSmhMRFBRMTZkNTNiT1NGMWhy?=
 =?utf-8?B?cEQ5a0o4L1ZSRzlpMlBjbFNHeUlCMSs3UnVZTG8vVnk5c3psZGxuanRlQmxW?=
 =?utf-8?B?NTNQMTFrSitiUVNoQ3A1NGcxTjYyNDdaTXpFUE5TWDZ1SENHMVN5YlVBN3lk?=
 =?utf-8?B?eElNcno1OC9XdVhLY3VjTE0zVnAzRjJSekkvOGZzakUxa05XT0hFZG05YXpu?=
 =?utf-8?B?ZVJpM0Q4TDhUZElpSm9xOXA4UjFNNWg5RFN1UHRUWWNNV0o3U0doUkc5enFy?=
 =?utf-8?B?MFdTbG9iSUgvQWN1dTYyaURhajBQRDZnVS9xaHVOa1RxK1ovU2FmQ1dVeWl6?=
 =?utf-8?B?THJ3Z0s3RFlDSWFRcTUzdzR1SmxvVC9qaHZaYUI3Z1JyY1N3eHNhSXJvWGxL?=
 =?utf-8?B?NjEzM2drNG1SOVA0T0JGSks1VVBGYnlqbTBONklwOHMrcXlCdGxxTUU1WkZq?=
 =?utf-8?B?N1ZvVVFoN2phb2IyWGV1Q2EzckFGZkk0WXhaYWF3SGp6SjkyOTVqeFp4NWZC?=
 =?utf-8?B?ZnZsWnM3bWVKMUJKUmhMdXBMeklvc2JWNHVIOHp3Y1dIK3RmZ0dwQ0U1d1Q1?=
 =?utf-8?B?NWQyWkxoK2UzZzlIVkNUZjRmOUREVnVtdkkzSUw2MzU0RnBiOTVtNFhhZndQ?=
 =?utf-8?B?bFp4MCs2SVZsWEtZR2QyUWR5ZjRDRDRTUlFndlMxZ3MwMXJJaHNKaUF0NGV4?=
 =?utf-8?B?S3d0L2N2dHFHdmFXREFpTEY3UEZYUVpvL25mUU9DL21pY0dxYXgxRXVWd0ps?=
 =?utf-8?B?WkpUTTVscjlkc3JvTXQraFhUQy8vYU56cWd2UFN6d016SUttMXptWDY4ejR0?=
 =?utf-8?B?SXd1bVd4cC9qRmtYQUpRYnNqNzBBSVk3WE5DVmd1WGhFdjYwT1k2V2d6SW9S?=
 =?utf-8?B?TDJsamkrZ0hVVnd1dXYzNUpnNnFZM1NlSFBqQjIxTEVJQUpXTGRoVCtSNTFG?=
 =?utf-8?B?K1Nxb1lSeVoxN2lrVzNic1U1TDdvUzdSM3VUb05QODVremNaTFIvMWZGR0o5?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y/JfPvcfUrqGrVmVB7MN1LpDFPCU30nXSTH4inkcMaDKX1V7gsmvV2DCuh6Das89fomoL8Pb93BNLWSk0D1nMOoC47QgrkyPjAjya2aOHqb62hGwo0ZAGMnYNzuRdwmmlw8PAUabktFUeXa2uMCO9vqsZJCCwVt8vDuIGO8ipTmUYNxFaDMg73VVa+RhIScYrWdbrt4cK7Cn67u2scawWE0n9l2ZzF2aslStlGZQ5HgeK8PuNQ81ECHRHZHjCst2uPxDw5Y8/Smr7NGxl1z8Sl8DTGNe/3ms/5g4YUlxo9ElC9uT944aevOVvdFcmKXXIV6TLPTV03cJeiEKZrxb7Vb+mA3LysuGZq2hyCOSYQROMEbCdY2eG5ZPwwEB1+9P5ygup91QQcFRA31+6TRTNLyCf4aOGpCAhZ/bbmmWdZRSQcqayU1q1FvwQPVkm/CFXnE4PqdQOc2t6s5Z6EmjCQffbIwbyPLnlReECJ2CDOoVYtoSi8BDldvbAzDlDv/7aGAas8fn1+YEsl2FKiGdfV9NqxxAqcXJJ+zU+hcKOX15k/NNNrLvzpk0nKCsuIA+ICgC4z2utUychnhQqVyL8x/sEdyP3BB1h2a8j9+wmuk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154502d4-f6af-4e26-ba6d-08dd1b899563
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:19:48.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieFfWPXvB/WPerQKFtwMhkNdLoDJoy4rlp0YdRF50G15/zPwPOR0FwL7otVfRnMG8OSvSl/Ts7aTgyswS62bZy/fSwKJVlLGQzPZKAQwPSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130109
X-Proofpoint-ORIG-GUID: ACSjBx2ByHPA5n7d9Yeji29ZB_SZ5hwv
X-Proofpoint-GUID: ACSjBx2ByHPA5n7d9Yeji29ZB_SZ5hwv

On Fri, Dec 13, 2024 at 07:05:06AM -0800, Jeff Xu wrote:
> Hi Lorenzo
>
> On Fri, Dec 13, 2024 at 1:18 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 10:50:19PM -0700, Yu Zhao wrote:
> > > On Wed, Dec 11, 2024 at 11:57 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Wed, Dec 11, 2024 at 10:36:42AM -0800, Jeff Xu wrote:
> > > > > On Wed, Dec 11, 2024 at 2:53 AM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > Update the MEMORY MAPPING section to contain VMA logic as it makes no
> > > > > > sense to have these two sections separate.
> > > > > >
> > > > > > Additionally, add files which permit changes to the attributes and/or
> > > > > > ranges spanned by memory mappings, in essence anything which might alter
> > > > > > the output of /proc/$pid/[s]maps.
> > > > > >
> > > > > > This is necessarily fuzzy, as there is not quite as good separation of
> > > > > > concerns as we would ideally like in the kernel. However each of these
> > > > > > files interacts with the VMA and memory mapping logic in such a way as to
> > > > > > be inseparatable from it, and it is important that they are maintained in
> > > > > > conjunction with it.
> > > > > >
> > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > ---
> > > > > >  MAINTAINERS | 23 ++++++++---------------
> > > > > >  1 file changed, 8 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 68d825a4c69c..fb91389addd7 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -15071,7 +15071,15 @@ L:     linux-mm@kvack.org
> > > > > >  S:     Maintained
> > > > > >  W:     http://www.linux-mm.org
> > > > > >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > +F:     mm/mlock.c
> > > > > >  F:     mm/mmap.c
> > > > > > +F:     mm/mprotect.c
> > > > > > +F:     mm/mremap.c
> > > > > > +F:     mm/mseal.c
> > > > > > +F:     mm/vma.c
> > > > > > +F:     mm/vma.h
> > > > > > +F:     mm/vma_internal.h
> > > > > > +F:     tools/testing/vma/
> > > > > >
> > > > > Will  madvise be here too ?
> > > >
> > > > No. We had a long discussion about this on another version of this patch :)
> > > > it's blurry lines but it, in the end, is too much related to things other
> > > > than VMA logic.
> > > >
> > > > We probably need better separation of stuff, but that's another thing...
> > > >
> > > > > I'd like to be added as a reviewer on mm/mseal.c.  Is there any way to
> > > > > indicate this from this file ?
> > > >
> > > > This is something we can consider in the future, sure.
> > >
> > > What'd be the downsides of having an additional reviewer? Especially
> > > the one who wrote the code...
> > >
> > > > However at this time you have had really significant issues in engaging
> > > > with the community on a regular basis
> > >
> > > I'm not aware that this can disqualify anyone from being a reviewer of
> > > a specific file.
> > >
> > > > so I think the community is unlikely
> > > > to be open to this until you have improved in this area.
> > >
> > > I do not know Jeff personally, but I think the community should make
> > > anyone who wants to contribute feel welcome.
> >
> > This is very unfair.
> >
> > I have personally spent several hours doing my best to try to provide
> > advice and review strictly to help Jeff get series into the kernel, perhaps
> > more than anybody else.
> >
> Thanks for your help (and others ) on reviewing mseal_test.c.
>

Thanks :)

> For the reference: I sent RFC [1] to follow up on refactor work of
> selftest. To save your review time, I made minimal changes using two
> test cases, and intended as a baseline/pattern for remaining
> refactoring work for mseal_test.c.  If you have time to give your
> comments about the RFC before the holiday break, great! I can start
> refactoring the other mseal_test.  Otherwise, the after-holiday will
> be fine too.
>
> [1] https://lore.kernel.org/all/20241211053311.245636-1-jeffxu@google.com/

Yeah I'm so sorry for not getting to this sooner, that's my bad, got tied up
looking at other things. I will definitely take a look and PLEASE do ping me if
I don't it's no problem.

I do think at this point because I'm off from next Mon it'll be post-xmas, but I
_will_ get to it.

I will do the only completely reliable thing for me re: TODOs, which is to write
it on the whiteboard :P

>
> Best regards,
> -Jeff

Cheers!

