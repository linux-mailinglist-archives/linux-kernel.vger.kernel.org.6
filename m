Return-Path: <linux-kernel+bounces-409849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8839C9287
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B61F22B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6319D8B2;
	Thu, 14 Nov 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chbek+6c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OM0JVxvP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965B187555
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613337; cv=fail; b=SNCpTwGh5LbaxTbjL+p5DV2qlzqrcLdPqB+inQ11nkGFuYaC7xyfLjwPYcKygD8lyJXFwOgB2+kwrr5jBNAjU70w0s3OnKhSz1WV8mXNLkL723hi3jUaNMjQobxdTz/4wICNAVXSBeCMd2uDxrOp2DKzgs++945iTl34o6OX8c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613337; c=relaxed/simple;
	bh=gxER9FXJlCydG6Y9TSfljIecCQ0d3geVnbU4y3Doks4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFGXujpw5Qdwpa16EcpGmJEkSOfP7HhhcU4S7xl21lRnXWrE2Iw+m7MB7h6cqXCMlgST6p84/PH9o7SjeoWpzGTBhD3XBk0RKUBGStnro/3KeFT+4NaSGZha1MpUdWwqCHEIClwvwRA5fPXkF+z/mbMGJne4As1CCuHfImRO8Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=chbek+6c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OM0JVxvP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJfeOS010946;
	Thu, 14 Nov 2024 19:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gxER9FXJlCydG6Y9TSfljIecCQ0d3geVnbU4y3Doks4=; b=
	chbek+6cpD7vF6/YH/GZhUMti2PapcZ2Ga9FRwwprsE1d1WAPQisQm626C9Ue+DW
	fJfbPds8/rKqtO6RYDnLHhxZt5whK5Cp6TFChJ6r2+E0g5h3b5jb27yGnLrudIzH
	0Ihv8jQavbPAbs6IUjgE7ImWc6+/AAfE1M0jQp3Rd2qlqWwnQaA++O9rsF904shL
	M2KyeMdhlzJBwwWtyFxTzKHDy+vpn6J/lgirvxbWRBrVo3CbTUJKLTRoPiSvNvyj
	9DfeeitBVzxvp6CEUoY95tyb0UmtbUuc4ZZiy1vE6NBkubS/DnX/KAsJ2hOfEAx0
	ZiCG3DKXmY84ZogHUbJU7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbj570-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:42:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEI13aL025870;
	Thu, 14 Nov 2024 19:42:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b9wbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0LbhBmdVVLWS196GLqtpkZJ+AobmOKTDzqjqIgmA+Vgqe+beDQcNHPuF/FsezKO1WIv0oX0QGUQIPxbDRWC9YfpXNWFcLL8h3fgxDxbksc9fkJ1UYhW2JdXQICWjnpIuWYEztGSU5KdjTlYia1r2/SpVuF/xs6JEp2vWams90rLNrjMuuZNSUaQGb7Ydto74tMVCYn2F+JTZZmx7kIG5pNi9cjIu9Q0GtV39a+M/SpoK7smPEP7K1VB+Ff2aY8btZXFrOKoPTRPHPBNblqRuZ7D63UND931bv7HXEjq0GSKvvkfXj9FT0BEf7IAGRI3mukCfC/Elx27Uhku4mJ0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxER9FXJlCydG6Y9TSfljIecCQ0d3geVnbU4y3Doks4=;
 b=r0BebQE1eVif1C53VCOC2UQ0/5qaESkTz6RwiSQV+E1Ix4fusxXOegd92ciHZgyD9xqE/OTHilBU2N8X2/q8rp3VAQDcc/YnpHwKCozza7sljAGqtJCXFAd/6b5sus1Vn71qcs7vuKgcE8CGPMb+5QVnaxrsQiItAF4Mwtk4TRm7sG42CL9HZh76O2vACu/kjZXtqVY6N+Jz2LOs7nDwXmciRiF8ntObrvm2nTb0u9MzBPMIGFpqulBzv9vShtaw2TIzKZmAw3r1+YGq7oBZgFBwuUZvT0/FDG88CGz3oLfq6cVMDIIEzmVEzpIzvkVSLnUZAdoig96yZoZ3mI+MJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxER9FXJlCydG6Y9TSfljIecCQ0d3geVnbU4y3Doks4=;
 b=OM0JVxvPG7r8ssJ8pobZkOIbKUN59LrPSCdKxWnF4NDmLtvSg4zWl4MyA3xpDOqbARJ78bpo/PK/vRANsJy1P+fyNNE7MiAnMgsxl2kT+IH8E5SZ7GF5VULWoSxrM8c+tnUZdxb7G8fFTqLzLVlh6VH5q3m7nN5dgKVPmWbSKi8=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DM4PR10MB5965.namprd10.prod.outlook.com (2603:10b6:8:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 19:42:00 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 19:42:00 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index: AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAANEACAAAlsgIAA77AAgACalIA=
Date: Thu, 14 Nov 2024 19:42:00 +0000
Message-ID: <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
 <20241114102834.GM6497@noisy.programming.kicks-ass.net>
In-Reply-To: <20241114102834.GM6497@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DM4PR10MB5965:EE_
x-ms-office365-filtering-correlation-id: 4e0507fb-ca96-4d46-d917-08dd04e46862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGlUU0Nyekd3MUhPc0RDSitDQ1hTQnFDei94VVFxV3VZT1ZFU0ZQSWgxa2xz?=
 =?utf-8?B?YVFuUkExS0dKcS9ZWW5iNDVWemp1NHhxdHBHclJpWnBUMXpKMmNHOSs5VmtX?=
 =?utf-8?B?UlllNmdFWWRPUlFuY2laRW5OR1NFbVVJUmJyQ3dKVUVXK20zUS94NzdGTHhy?=
 =?utf-8?B?eUNOZG5oYTJFcVViSFhYWTlXRjVURjE4enNCVTJsQlJCSVZBNzBDT21DZUt1?=
 =?utf-8?B?MStJOTVSdkFvQWFQRVRybFRQTmZya1laYm9uS25ialNvMzFDSzdubHpCMU1K?=
 =?utf-8?B?SHRKTlpNcG81bmpJM2lGV2VUR2VneDQyaStDdWdOWUNvVGVjbVpLbWVUdDFn?=
 =?utf-8?B?SDE5aGwxSkpFNGROUXE1Vk4yOTNaN0tXanNOVmRtZExCeFcwd2I0L0M1UWRn?=
 =?utf-8?B?akhGYi94Wk93bzBaU3IvWFBrUWJ5ckJvK3dEU2pFWTdzUDVxT3NaZmNoR2l6?=
 =?utf-8?B?UmhTWnFkTHo3OExoaHZXSTRzcGhGaUM2RTgwUTVxV0t2cDQ1ZVJmenNVODYw?=
 =?utf-8?B?aEJ6dklZM1kzQnMrL3RYdHlTTU9ENjM0NGIrREw1RVRacjlLVVF5UzRtY3NC?=
 =?utf-8?B?RTg2ajZiSXU2MFlsSjJtd0xXSTIxREhWdm5JL3hrd1BuS0huRjdVei9lejFq?=
 =?utf-8?B?U0xkc3NXOVN2NG1sdUdZR0RKVmYxaEZ4R1RGeU9JbGk2eThtU1lzZlN5eWx4?=
 =?utf-8?B?TitTNExoVWlRUlNQNlZ0M2lmZzlESzNHenpMUnJHdkJiMmkwU0Z2cFdkR04x?=
 =?utf-8?B?Zkp4K1R2WFUwQWlqM1pqV0lYUXZFeXFGZStHc2pKT21oRTJYdkE3Wnd1Tk9h?=
 =?utf-8?B?K2dGYXBNWlR5TWhENm9vY0RNUUlHb0dUTVBTU2tJRE50YkthcmdDS0YxdHU1?=
 =?utf-8?B?dWd1Rlhnb0JhdjZUWHdJV2N3eGh6TjFyRnZwZEM1R1hZUDdubEFkT1liMFZj?=
 =?utf-8?B?NEVuUWVXand0N2VGZEk3Q3AwM0VHbnBOUk12T3JyYlZ1eTcvbXNVS1Z1Z3hs?=
 =?utf-8?B?ZW51QTJhYk01aW9yR2VNUWlwNmVjb2FKaVJJVUJjTFV5YTRvaHN6VGMyc0hj?=
 =?utf-8?B?WTVyUFkrZDN3Z0hmd2xFNWFiaVE1ems2NTZKTXNuOEwvMTdsQTIzK1pnTlUv?=
 =?utf-8?B?Mk0zOHl6ak5WcTNOeWNhV3A4OFBuQVJGOVdVZmRJaVlCckJ6V25RMm1QdTZL?=
 =?utf-8?B?dXAyVWY0NUpxekw2WXFHY01rZk5XTFVYQUs3NDVZT0c4Qi95U09vWHB2cHdq?=
 =?utf-8?B?QVEraGdGVmlTR0NXb3BQUmhxOHhsK0RUZnZWTFJzVzBQdHBNZ1BGUVVQb3VP?=
 =?utf-8?B?RlZFNmRwNWJHODliR2tjVFgzd2RDUzVxMFFGQ1VtYzl4dVVzN1B6V0d0Um4r?=
 =?utf-8?B?YnBzbzJ1Ni9GNzUxaHlhcjZMWEhIalB1K3J5ZVJKWXB3TlQ5bTBZS0lrZGV4?=
 =?utf-8?B?Vlc0QVlIZS9zTUx6N1pHOGtNdDhSM0xxdlNaS0FQOFBPNFVLR1IxdldOSzdG?=
 =?utf-8?B?bllBNzJjZTJjLzNrM1plb3JDUUU2U0pNVk1xUU9SWThoZFRCOXRsUFg1KzJ0?=
 =?utf-8?B?d1VucUx0YnNXd09ucStBNjBIR0hSM3V6V0w2VmtEQmJlRjNTM2ErdGhmWjRT?=
 =?utf-8?B?QlVHT2RGOGZhd0FIS1RrTTZqY3RiL2ROSnA5dGJtM1ZUL1lMRDdwV0dWTWdx?=
 =?utf-8?B?WlJzQ0tTZlluWldvNmk5cklEV2JJTHRNakZPQyszd0owejdzZFpERW1HNnUr?=
 =?utf-8?B?QjBnVjNIRXRTd1dNL2FEN2Y1ZE9WK1VReTdCMUxlcHhtNnJGRHYzZEtYM0x6?=
 =?utf-8?B?WVBtdFRNeS9ETXB6SUxJeHZCQWszenpsejVEVngrNDN1aHNaMjBBWmlUNE9T?=
 =?utf-8?Q?bn8TRR/RP1G3s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGpIM2thUTZlYkJHZEZ3dzFubjJmV1h0K1lIMThxSm9YMGZYSVVUVW02aHZG?=
 =?utf-8?B?US9DSVhWME5rNHdNdGVDZjF3czVjemdjKytnK2F0Sk1MdGM4TjZ3Qm13UzFr?=
 =?utf-8?B?dlEyQ3g0enM1T3IyVWhMMUcvbzFHVmMrckRaN0hyOHhvaEt6eUx1aCtITnJv?=
 =?utf-8?B?Y1V3WG96V3RyWGFRcnlpL1ZNYjREMEptNHUwUlRKcTNOL1JtSFJ0L1gwdTgy?=
 =?utf-8?B?MlB6dnVNQWc1ZURLV3RObWVmWnk0cWZwYnRiQ21sbWZITFhHeXpXZENnbmNy?=
 =?utf-8?B?U09lRUdyTFVqNHN6WDZZUXY2K01EQkpJMitRaEV2SUNKOGdjZW81YktOYWFh?=
 =?utf-8?B?V3MzWkhrT0lhQ0laRWM5YkZnY25iRmJ4clEwaXhHcjJ5ci94WU1MUFh2T2Er?=
 =?utf-8?B?QnE2ZnVPM1ZiWG85ajg3VXB6RTlxTnlpQnVvVkxtazR2OW1wTG5SeUtqL3pP?=
 =?utf-8?B?dE4wN1VMVTdDZFAzQU1KdDRaVWFSa2xuUThiak0zdERGMEtCUWppd0M4OVpJ?=
 =?utf-8?B?a2xGNGh0ajZ5ellma21SNmRoYUhsRW9hZmlOaW03TXFEeGlMZk4wdTRLbERh?=
 =?utf-8?B?RjJCZTJxYnYvM3piQVJKTnhKblpaanNCcFIvWTJmTDZtNlNnYXZBSU5YTVNU?=
 =?utf-8?B?UVEyMENJdERiTUR5T0tDTUZPeXJqdUhZL3dPU1VoOXRTRk1PMWhzQytxTVB0?=
 =?utf-8?B?RlVRb2lyTEdrQTVkUnJGQjU3NlMzRU5tUlBDOXV5WWtwUFZpbEZBRGFoNWZQ?=
 =?utf-8?B?bEdaVllMNXE5Tlg3K0J6YXcrQy9WRTljR2NXcTliamNEbXArQXErQTV1MHNu?=
 =?utf-8?B?SXRmZnNtOGYzYUVwS0R5MkgrU3JaM1BYWG9VZUYvSTc3U21iNW5wQld2TW5N?=
 =?utf-8?B?NVliV2lKQ29CL2M4VmN6cDlTLzVWVlV1YWpYOTNFWnJpdy9PRm1mYnZhc1Zk?=
 =?utf-8?B?RUduVHhhNFhVeFhyMi9LaVhPYWdxY3JZSWJSQW84aG9RYkJHRC9WODdIVnl4?=
 =?utf-8?B?aHJ1UDZUZUMxZ1NRM3pNQlE0MmZaYU1DYnFZSkl3NTVFaytjb1dlSDRSVUp4?=
 =?utf-8?B?dGx3SXl2eVZ1eitwQ3p0a1lzNUsya3J6b0F4OXl2M05RWTZ0Qk5QRHYvMEM5?=
 =?utf-8?B?UzNERGlJMlJJaHFWa0hhL2phcU9GSis1a2p5S0dQMFV3Tmp2UGxwYjJUajdW?=
 =?utf-8?B?MGtKNCtJSisvc25qYlhNdmZBbzdUNDFUTEl0ZnFqTkZ3SXNWMTd1N1ZuVGNR?=
 =?utf-8?B?U3hQTk5tOE5RZzZMVnJvVG80c1BRR1BycW9CWEc3SDd5QVhBWFgvZDM4RVZH?=
 =?utf-8?B?UTFlY2xoKzAwSENIdEZmUFR2TFA5b24yS0NXUkx0NnVkaUlRcXNxM0dJZlYr?=
 =?utf-8?B?c3FZMk9pZHVQdXVCcXZsbnFIenBoZDE3TE9sMDJ5a3oydWhWYStxZWhHTktw?=
 =?utf-8?B?aU1yemtHTTJZNjhEdTlGRnBQbnBwOWVPbGNSNHREZzRPVkxrejJuYS9RTlp0?=
 =?utf-8?B?QnQ0am9HRG1wZzRLT0lCOUtTSTdjUWkwSFZqWE1tcVRPLzBCT093QmpFRWFz?=
 =?utf-8?B?WmdVdmZpS1FDNmJTS05HRkF2WEhIZkRhbWN6RmhHZlF1d000bTNqTDczOE4z?=
 =?utf-8?B?S1d3Qm1xWWpNWG02SG44djVJcWU2Zm9wK3R2NjlkeTBaeHFuNzNCa1hwcmdI?=
 =?utf-8?B?QTNRQVVVYmtaejc3OFNJRUwrcDBtZ3dJNzZXdmF6Wk1tZEFpbVRGdnVSV3M5?=
 =?utf-8?B?VkdHSTZLK1ZEUzA3a01yaDUwMHF3YmxKOFpxdFEwV0tRQ0FKMkJXK2x2YkU5?=
 =?utf-8?B?SG9xM1dXN090WDQweTcxa01BQWQwWWRpKy9HSTFVWFV4UGN6U1c3SXNiVnRR?=
 =?utf-8?B?VUNTTTJSKzJlVFdYNmJWMXV3NEZDTFRtM1RXM3pncTVPUGloWjIzcTdvODJK?=
 =?utf-8?B?eUU3MUNzeTAzQjA1V0ZwMGVVRFk3Z29wMWNsaU5hVmVPN3d0OCtJOVVReTN1?=
 =?utf-8?B?QTE1a3VINmpQaWdmeU1XYko2dWZRZUxvZDN1TnlmMEZDTldscE5qM1RwbklO?=
 =?utf-8?B?RHh0Q1ZuaERkWEIra2FBdVB0OGhiUmZyQjdYeWV0UjErc0FwelFmTkNYeTJ6?=
 =?utf-8?B?ZE1EcEcvWTBKV3kzRlBISEp2YzhtZTdscXR0VlNxcFVVOE5QMWoyZkRST1d5?=
 =?utf-8?Q?Wyc8PweQ37W5u/H1zwTTIpfX0wcF0YmugPYqyZ9r60RU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A00B89C588E01040A8F08563C4BAE7DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/jhI8tNMZO/GBDujnl+7IP0WzEYrF98xAxO/x3wnihU9e5pB0zX82T4gLe5W2yIkAT6k5zx8DLFhtfriFoXu3D7qB3sev1F/7dxfUrwxAco51ugfWzimMAjsL+rDroD2KblnRwMhSv8vYvuWrQEN5dX/G5J/ct1Bzr4E6r9sxsS8N4VlDMZoj080783mqza+gpsErxL+MnzC5TXsGU75Xt+fZmxjEoHN3PQ7DgjC5XXIOXiBTPNVuUUR12a14j3IjondKWlMjKCPGdTAoOaTQKT3C6bUtiQr0855imNG7h+nhw6BevXbqIAX1gzTaAvwIrcOFgduMs86xRK2/noWY9w7cY3Ql9+SfMo96RiiBqEJ2aJkSAciRmX6l8jaymYdC+Is8Zjjc8BbnWWSI9+6+Xnba9/hYsXmA3J4YDqTBXmmz9/l+HQxa+64tcz4/dEd+it91jzH0jwDGqq6PM1fHhiyPnuEWi08XknsyqjZBALPROP8/5AK5z6ymm8l8k9u0Rqn6YnZGSY3cSw7BODli/sYmEwFEAjFzGUElJyYKAgtTsN/bOAplRG9iZfVRGOq8E2o9HJH+eHhcoEjF+z+ZEv2YZ4h9Gpg7xZfCCSwwjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0507fb-ca96-4d46-d917-08dd04e46862
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 19:42:00.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZPtuna1ykduBVRAV/VliZ5PsIIjSx1aFzfemxIoiRFF9yUAf0pJT/7IH95+CSSeO2weQj4T7GzUpKXxqvJcA5w1os/LEy8MjzT43JsG6kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=896 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140154
X-Proofpoint-GUID: zFX4_vPcFuhRxyhYD9JQye5X_sCsp_Lp
X-Proofpoint-ORIG-GUID: zFX4_vPcFuhRxyhYD9JQye5X_sCsp_Lp

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCAyOjI44oCvQU0sIFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE5vdiAxMywgMjAyNCBhdCAw
ODoxMDo1MlBNICswMDAwLCBQcmFrYXNoIFNhbmdhcHBhIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBP
biBOb3YgMTMsIDIwMjQsIGF0IDExOjM24oCvQU0sIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1
LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDIwMjQtMTEtMTMg
MTM6NTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+PiBPbiBXZWQsIE5vdiAxMywgMjAyNCBh
dCAxMjowMToyMkFNICswMDAwLCBQcmFrYXNoIFNhbmdhcHBhIHdyb3RlOg0KPj4+Pj4gVGhpcyBw
YXRjaCBzZXQgaW1wbGVtZW50cyB0aGUgYWJvdmUgbWVudGlvbmVkIDUwdXMgZXh0ZW5zaW9uIHRp
bWUgYXMgcG9zdGVkDQo+Pj4+PiBieSBQZXRlci4gQnV0IGluc3RlYWQgb2YgdXNpbmcgcmVzdGFy
dGFibGUgc2VxdWVuY2VzIGFzIEFQSSB0byBzZXQgdGhlIGZsYWcNCj4+Pj4+IHRvIHJlcXVlc3Qg
dGhlIGV4dGVuc2lvbiwgdGhpcyBwYXRjaCBwcm9wb3NlcyBhIG5ldyBBUEkgd2l0aCB1c2Ugb2Yg
YSBwZXINCj4+Pj4+IHRocmVhZCBzaGFyZWQgc3RydWN0dXJlIGltcGxlbWVudGF0aW9uIGRlc2Ny
aWJlZCBiZWxvdy4gVGhpcyBzaGFyZWQgc3RydWN0dXJlDQo+Pj4+PiBpcyBhY2Nlc3NpYmxlIGlu
IGJvdGggdXNlcnMgcGFjZSBhbmQga2VybmVsLiBUaGUgdXNlciB0aHJlYWQgd2lsbCBzZXQgdGhl
DQo+Pj4+PiBmbGFnIGluIHRoaXMgc2hhcmVkIHN0cnVjdHVyZSB0byByZXF1ZXN0IGV4ZWN1dGlv
biB0aW1lIGV4dGVuc2lvbi4NCj4+Pj4gQnV0IHdoeSAtLSB3ZSBhbHJlYWR5IGhhdmUgcnNlcSwg
Z2xpYmMgdXNlcyBpdCBieSBkZWZhdWx0LiBXaHkgYWRkIHlldA0KPj4+PiBhbm90aGVyIHRoaW5n
Pw0KPj4+IA0KPj4+IEluZGVlZCwgd2hhdCBJJ20gbm90IHNlZWluZyBpbiB0aGlzIFJGQyBwYXRj
aCBzZXJpZXMgY292ZXIgbGV0dGVyIGlzIGFuDQo+Pj4gZXhwbGFuYXRpb24gdGhhdCBqdXN0aWZp
ZXMgYWRkaW5nIHlldCBhbm90aGVyIHBlci10aHJlYWQgbWVtb3J5IGFyZWENCj4+PiBzaGFyZWQg
YmV0d2VlbiBrZXJuZWwgYW5kIHVzZXJzcGFjZSB3aGVuIHdlIGhhdmUgZXh0ZW5zaWJsZSByc2Vx
DQo+Pj4gYWxyZWFkeS4NCj4+IA0KPj4gSXQgbWFpbmx5IHByb3ZpZGVzIHBpbm5lZCBtZW1vcnks
IGNhbiBiZSB1c2VmdWwgZm9yICBmdXR1cmUgdXNlIGNhc2VzDQo+PiB3aGVyZSB1cGRhdGluZyB1
c2VyIG1lbW9yeSBpbiBrZXJuZWwgY29udGV4dCBjYW4gYmUgZmFzdCBvciBuZWVkcyB0bw0KPj4g
YXZvaWQgcGFnZWZhdWx0cy4NCj4gDQo+ICdtaWdodCBiZSB1c2VmdWwnIGl0IG5vdCBnb29kIGVu
b3VnaCBhIGp1c3RpZmljYXRpb24uIEFsc28sIEkgZG9uJ3QNCj4gdGhpbmsgeW91IGFjdHVhbGx5
IG5lZWQgdGhpcy4NCg0KV2lsbCBnZXQgYmFjayB3aXRoIGRhdGFiYXNlIGJlbmNobWFyayByZXN1
bHRzIHVzaW5nIHJzZXEgQVBJIGZvciBzY2hlZHVsZXIgdGltZSBleHRlbnNpb24uDQoNCj4gDQo+
IFNlZToNCj4gDQo+ICBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMjIwMTEzMjMzOTQwLjM2
MDg0NDAtNC1wb3NrQGdvb2dsZS5jb20NCj4gDQo+IGZvciBhIG1vcmUgZWxhYm9yYXRlIHNjaGVt
ZS4NCj4gDQo+Pj4gUGV0ZXIsIHdhcyB0aGVyZSBhbnl0aGluZyBmdW5kYW1lbnRhbGx5IHdyb25n
IHdpdGggeW91ciBhcHByb2FjaCBiYXNlZA0KPj4+IG9uIHJzZXEgPyBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjMxMDMwMTMyOTQ5LkdBMzgxMjNAbm9pc3kucHJvZ3JhbW1pbmcua2lj
a3MtYXNzLm5ldA0KPj4+IA0KPj4+IFRoZSBtYWluIHRoaW5nIEkgd29uZGVyIGlzIHdoZXRoZXIg
bG9hZGluZyB0aGUgcnNlcSBkZWxheSByZXNjaGVkIGZsYWcNCj4+PiBvbiByZXR1cm4gdG8gdXNl
cnNwYWNlIGlzIHRvbyBsYXRlIGluIHlvdXIgcGF0Y2guIEFsc28sIEknbSBub3Qgc3VyZSBpdCBp
cw0KPj4+IHJlYWxpc3RpYyB0byByZXF1aXJlIHRoYXQgbm8gc3lzdGVtIGNhbGxzIHNob3VsZCBi
ZSBkb25lIHdpdGhpbiB0aW1lIGV4dGVuc2lvbg0KPj4+IHNsaWNlLiBJZiB3ZSBoYXZlIHRoaXMg
c2NlbmFyaW86DQo+PiANCj4+IEkgYW0gYWxzbyBub3Qgc3VyZSBpZiB3ZSBuZWVkIHRvIHByZXZl
bnQgc3lzdGVtIGNhbGxzIGluIHRoaXMgc2NlbmFyaW8uIA0KPj4gV2FzIHRoYXQgcmVzdHJpY3Rp
b24gbWFpbmx5IGJlY2F1c2Ugb2YgcmVzdGFydGFibGUgc2VxdWVuY2UgQVBJIGltcGxlbWVudHMg
aXQ/DQo+IA0KPiBObywgdGhlIHdob2xlIHByZW1pc2Ugb2YgZGVsYXlpbmcgcmVzY2hlZCB3YXMg
YmVjYXVzZSBwZW9wbGUgdGhpbmsgdGhhdA0KPiBzeXNjYWxscyBhcmUgdG9vIHNsb3cuIElmIHlv
dSBkbyBub3QgdGhpbmsgdGhpcywgdGhlbiB5b3Ugc2hvdWxkbid0IGJlDQo+IHVzaW5nIHRoaXMu
DQoNCkFncmVlLg0KDQpUaGFua3MsDQotUHJha2FzaA0KDQo=

