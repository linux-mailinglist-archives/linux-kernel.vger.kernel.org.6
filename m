Return-Path: <linux-kernel+bounces-416978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15C9D4D25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE0E280A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C01D5CD4;
	Thu, 21 Nov 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAIuCCGd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjXTE94F"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E861369AA;
	Thu, 21 Nov 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193466; cv=fail; b=CCKSgC89jE4/f9qUXXXrbvx6NkzxQTvLC863slE3Z4T7c9LEHYSmBP09u5v8yzPFnp//ln+WmPd77zrXsBmcID0q9OWdSmJDz3SMClJ4tS4BL8fMDfYDVnjMB6Ohn7FI7soVtjqZmH9AQYG82hvS4AvrlQPJtNEXMlmlCZcza/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193466; c=relaxed/simple;
	bh=yWj96PICNRXRU6CZ2K8NDdl7R1crdvzGHTHkkQbolRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xsuh2hkkojGZeXF6++KnP7bVYWO/lJgkZCx/Xssf0cy6e5VJd3JbrK/NIdr+IYs6fPYfpUZZBrPEkZ0brBFC128yfpTdGIVQG9F/AvqtMLmffFSMHbgp8FBgzcwRQwiiFE61U0wlNi4lJ7ohKzfPiS58mBQk2iSOVSrcNtmFhEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAIuCCGd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjXTE94F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7Fi7N007035;
	Thu, 21 Nov 2024 12:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=t95R99R62dOBPU5kvwPOuJBuadc44LEIpcG1VdKfoYU=; b=
	WAIuCCGddmcFlzTOXKrD4bBkMjgwE9tKdrADIYF/3VDNOFZAt7NR8xh8DQoKnkyo
	p5zEp29HDNv+0Er4sv53C0IIpPZJ+Lwc0lQWEh31IBX5MidbmFwPEEjjGN1k0lyS
	sJUj/yae7VTot+9MtlYlM4Ir4uSjpMkKs8ALc3KYKLNlvHG7P332g4u4igey5k7X
	ajf4xHYczOB3IjeMETfl6aOQFkmlJBFnT6dnZwysN4AB0LrI5i6bSuna1Eysvjux
	3FOag5pABOCOrJqdfCpTkxRLG4AP6i0i6XeBmFzbM4/x0RhMjqiAa+Cp5i7CCEwg
	jvJGvPAlZQSk61yVBdzQtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa9jth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:50:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALC8RmI036975;
	Thu, 21 Nov 2024 12:50:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubnd6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptxVm1k1nwZyvWqzXVw4QeiJfBdq/eDUCfFaQNGH6BmwqFteUV0vZFqQu2P72YJQ2kUkK759RcXY7AipAJGMcg7/5ijlibLxHSY4KNCxJ+3WTVc+diN4AoKJu1+YJycxS4j/vqgMT+osiN23++CdnwVtt9B5ef+WbWjPLDJQvgbchO9a2nbPbWNv+8TWjbLOBxmgLzExXoLjS4GIog80hiR84cu7g51JgH0pHlKuH2cqVKKr6xK+KWjboV2HDP4oYyC2w6ChxItXL9fxMRNDoMcHe+dDjh72WVbNi3IDnlEpSgVvbDyhq2B0wRj7f6/Z5fVwa/rxrb9ptkw4Wu3uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t95R99R62dOBPU5kvwPOuJBuadc44LEIpcG1VdKfoYU=;
 b=w+mNw8DHs6P0R5lWl0eDUK1N6fEz+Gl5pcUwkw2iuNKVMbj4yi+QdGX1PeOEa7UuOjuGt445LdW4DmNVAW0fMsx4I7GdgHv0WjxhcSaJwEUFeKYcTbHLj/FXNLeSkcdpZldf5X1Jr1Q9X2zdTL4vvcToqQxSfJgJ4qlsXA+qkQil2J0rSDwhRKDEVMX5t3XuBGeJ8Eph44MQ0ETnZbmhFVyK9XVlxhBcAg4iYT7v46LBSrE0vnGu15N3kydcqjZLnGYLjlgO9HrXEM1Ol5gNsE/B0b8NOM+c6UtD+nNLSHVmVrQEOQuHWj51hTHLXVOaYjgxpUkcrvcoh9CGc1kr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t95R99R62dOBPU5kvwPOuJBuadc44LEIpcG1VdKfoYU=;
 b=YjXTE94FUbXOjlx/AMebtpmNMY1l4jSh0cznEzxtVgUr3ienOYSHmawawMC2IZhFR2s8ArTOG2A1ZbgDOingtIq2zrn7A6k9rvLwBveQouLokIObp6w3A2HwnNS3j4ViB/WxGxrNrkPObT3hdA8Ezws1R9blKYOLvm81xGcgZH8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7917.namprd10.prod.outlook.com (2603:10b6:408:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 12:50:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 12:50:26 +0000
Date: Thu, 21 Nov 2024 12:50:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 2/7] mm: rust: add vm_area_struct methods that require
 read access
Message-ID: <d2d1f25c-780d-4103-aeb1-461adc4940c3@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-2-eb31425da66b@google.com>
 <c26a63a3-0f1e-467d-b24f-3963e5e4e13d@lucifer.local>
 <CAH5fLghdeBvbtC+aPq0mSr1io+DUt-J54zYagys63cK-4tictQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghdeBvbtC+aPq0mSr1io+DUt-J54zYagys63cK-4tictQ@mail.gmail.com>
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 416b9378-a711-47d4-e7d8-08dd0a2b126c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmZLKzdINmNPM2ZTeGFkWHR0YWYycFU5Y3c3MmFmeGlxN25jSUk3ZDJQYjFF?=
 =?utf-8?B?bWJxeVhWMjF0all3MXpGdUtHYTBRRDJyT2UweWc0MkFjdTl1UDNTYmRmR2c4?=
 =?utf-8?B?amN0S2xSUlcycGFTaE92Qjg0dHNwWW1BSDRKZUhUT24wczZZUWdIWlBKMElU?=
 =?utf-8?B?akVqWVM5ZGRtTGtHd0FpbDFOOHNuRjhUbjlHM0pBTzZSWGZvY1JtNHV2cDlO?=
 =?utf-8?B?S0tTYnVHYmFoL0ZZT2F6dXY3a0VWU2w1aWpHSDJyNm9uWnJCOVVwMUxHVkg2?=
 =?utf-8?B?SHFkOVpHRnRpMk1DeEtEQ1g1RzRhWDJ6UklRMkVnWUFMZStwaHM5U2ZjWEVs?=
 =?utf-8?B?T0h6eEk5dVZIZEVsN01wQ1lKYy81NFRldXYwU2JKeG5CS2VXK2wvZVVxUmtU?=
 =?utf-8?B?RDJLcWV0Mks1aytaNlpmbStiMWRPTGRoMk82ZTNKUmNVY2ppSXhvWTNWRS9k?=
 =?utf-8?B?MlRtTDhTUzNJQ3psWGdXeTk5b25LK3ZVUFlOWktiYWp4VGc0dGxHWkhGQ2RL?=
 =?utf-8?B?enZ5VlJSTmo2V2l2STZDK3VFdTlLOS8yOEZpU01jNjN4UER3Ri8xK1hvR2sy?=
 =?utf-8?B?VStjN2orcXFicktZbDJIOUd0b21rbHM4bEdON0ZaWHp2TGJJZEkrd0tjb0Mr?=
 =?utf-8?B?VlQ3UXBXeUJkZXlYV3NlWDA2bUR1QzlKMWplZmNGdW9rYkVYNGxTQ0tUQ2JE?=
 =?utf-8?B?QnYrSktXRWxpUis1TlkvaFlRNGdzZlFwNnFnTXJ3THRiVmhlZGdjQ3l4RXhI?=
 =?utf-8?B?dC9jOFZ4TnpUMGhpZENOV0V3RXY1YW8xV1U5LzFkZzJKRHNqUDJVRWpNMFRw?=
 =?utf-8?B?SVpnb2F4QXV2Sy9OWjhUWWhQSWp2TXVlYXQzNnN5NWQyU1VNejlrWGJIN3ll?=
 =?utf-8?B?RDB3MFFkYm02ZnMra1NYQzlSblNWeFh4OU5pTVQ1K1N4VmRuWitUNnVsamg2?=
 =?utf-8?B?WnRrL3JOanVneFJhNFoyZzlrNG83YWpkM2dBVHdVTytwRFg3T1FpamxDdmN4?=
 =?utf-8?B?ay92RGhnNTZQRlY4RFNSREcyeGVENlZaSURnYkJQdmhySEQxc0hzdlRsNnJq?=
 =?utf-8?B?UUZOMEdTaTE2emhTYWZjQklpV2JHMVRWcEdnK1NYcUpJNVo5UFJQR0x1SmVv?=
 =?utf-8?B?bTRCMHU0T1hZRERLa2NlUjlZRTdmOTBsOXhrMmZZQ1hLbGxyazl6dmlwSUg0?=
 =?utf-8?B?Y3Mra0wvb2VSSkpJMHhZNkFBclNSSGt2bnR2NXBpaTQ3ZlJkTDFkNThLY05L?=
 =?utf-8?B?ckwxYVVpS2tJdHptU2p3cHlWWWx3WDR4UkIraUNyd2NENnRTZGV5L3RFWE9T?=
 =?utf-8?B?d0QwRE9rNXBZSWdxd3RKZEhRc1JpUDJFbGJrTVhsTHV3ZFVWY1pUQ3NWRDhz?=
 =?utf-8?B?V1FaQ1d0anVkRXhjVStKMGZNbjBIbUxmQ216ZUh2b2RjcnJNQm1jWXFENmxU?=
 =?utf-8?B?Zy8zR1FxRHRqU0R0WWxsWkhkdUhta2dyWS9EdW56QmtuVWR1YTJyMXMwZG1a?=
 =?utf-8?B?aTVhdVFzcnZyQnZFQ0NvK25MVjJQWHE5TkZmNnNZOXptVzBaMy90WFRxMmpM?=
 =?utf-8?B?N2I3WVhUNktXVncrT25qTGNuUWkydzdPZk4zMnFTWlJQTXpQVGphMDVna2Qv?=
 =?utf-8?B?alljL0ZBbTA2a2FwUXRrcWtrZk9oZDVIckQ4ZXdXdmNHYmExM0ZhRU53Tnhm?=
 =?utf-8?Q?kiray096M1I0zXofocyi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUp0OVpCNmd5TEg3NksrOTlOb3lrL05lbGRGYWpNT25KM0Y3RU8zTEJJbkVX?=
 =?utf-8?B?N0w2bzFuUXZJc1p5VmI4VDlCeDVSRitzdFpRN0R5dDY4TVpqTk9NYmNMaUE1?=
 =?utf-8?B?eHlqTzBwZzMvVzlRQXVXdXBrVEV4Q0RaNWQ1NzJFbjcvZnZPRzBBU0dCa0Np?=
 =?utf-8?B?cU1KVmpsV1FVZk9oV0FBR3hCSGRtZUpYYUxxKytWTGN3Y2drc0J3SGU3RGxh?=
 =?utf-8?B?UkxFR2FNVlEvdmtPdkEvUE9QZXVJb0w3NGVIL08zclVZV0g0R21YVGV5QUkz?=
 =?utf-8?B?S0s3cC9VbkFsZXVzTlBCWnRJNloxWTFXUWNXTkpObTlqWDJMNHh2OTFIeWM5?=
 =?utf-8?B?UlArTU9VRlZNdkF4WEJibUNYRnA3WjloRlFEdGM2MUY2Y0hYSjI2bGxxaWpq?=
 =?utf-8?B?NGFENTYzOGdCeUppYm5PWHBxdmxrc3NHYjVqYWVoQmpKcEVmSUE3WCtYaDB1?=
 =?utf-8?B?WEI1ek5FK20zM2l4eGg1SGE3MVc3Vy80U0YvbjVObHRUQ3pDU040R21nT1U4?=
 =?utf-8?B?YjNiSGtDMDFEaUJrdHozcjc0dUkyeU1acVZRV2pJNDc2RlQ0bkpkUHV0eWlz?=
 =?utf-8?B?bllZRS9jaU11UVFjNWx2RCttMGRlRFpsY0JDYVVTRFZDSTA2WHRldFNSSnVO?=
 =?utf-8?B?dzVvRmV3VE5TcDFWRFgrbEZnZzlnTVNhbENXaSsrUGZrcE4yVTJEUjNSL002?=
 =?utf-8?B?SE9CTHUyWHQyWmpuRStHQVhIcVI4ZDlLdnBnVEFXN3c0cE45ZkEzby9mc1Ex?=
 =?utf-8?B?anhySEE4TlVNNDZNT3pnNmR0TXhoZ0NmVktzaC90NnJZZUQzRnQxR2ZxVDFm?=
 =?utf-8?B?TU9DUkc5Q2dMeGgwYTJwVTZ2aWMyanZ6c3M5VmdZY3cwTjVtaWpmV0lxMklo?=
 =?utf-8?B?Zmp0cm5jRzc1OVAzM0tnVHF0V3A3WEJJZHVYRlB3SW0wSktrcE1wUVlCaHFG?=
 =?utf-8?B?d0hDNC82dDUxZnFRT2doL0EvbElUdGZhb1MxMGRZUmhwRGY2TDFMUHhJUlFW?=
 =?utf-8?B?ZTVhL3dLZGlPcVZqWjlsZWd6ckQ1Wml5WFh1OGF2VnE1d1Y4ekdrSHhXc2pE?=
 =?utf-8?B?Znc2Y1BsUzNRMktadURLTnFTZWVRdVVqQmdsaVpUbVVIYlExbmVvRHl4QXNC?=
 =?utf-8?B?UXAyUHhDUUM5eUxGaGRTNjlOZkMrTEFmNHNtbnBkaWV0UDYwd1VUeWlCWHVC?=
 =?utf-8?B?MkNLNHBxbWI5WmNQbkNJTUFHd1gyWW4rY01XZUhqUUNYZlhFQkZlckxZanQy?=
 =?utf-8?B?NS9GUkg0RlRYQ0JLYlB2SHVIbHI3NGFLNmpJYWxCTFlLZjVtVC9uWXNaYUlR?=
 =?utf-8?B?L0EvOG82WHcyL1p0MmRTL3FSZ2FLWEV0K0Y4ZXkvRlMwenVKd0hBQkNBdnUr?=
 =?utf-8?B?cVU5dGJwMGhScDhhaTVGbkNpTDkrczZrVTkrMjFQNi9wcmlEMFIra1hBUENx?=
 =?utf-8?B?bUtHazhWWGZ3YVdHNUpzWDNDSEwxVnlteEM4a0kzclFJT3U3MnVwUTJWNUFa?=
 =?utf-8?B?WkNTYWNsa0tSRlh5cHU3R0FQNk1ySkVleStIdEkvR0xKVnFYQllERHVpc1p4?=
 =?utf-8?B?Vng1REtScFArMEIvMXNtdGFnNVFDTVd1alZhUmlkWld5RXlxZjFJYTV1Mmha?=
 =?utf-8?B?eXV3K3BRcjdPN0svN0svQmFQaVpsY0l1VTd6bU90MkZJUkhSeWwySGhzWC9W?=
 =?utf-8?B?bUJKZUhDUC9wYUs0cWtlZkVRaW1FVjBkSUNncFEzYWJLMU9EcHFwckVhSEIw?=
 =?utf-8?B?UGEyOCtJbmVkNFNZbEk3aUc2KzU5R01XN2RSNVR6eHpXc1ZtYUZRL0cxMWJT?=
 =?utf-8?B?SklxWFYyUmFxbm8vTUZYZkwrcXB1UlBlT1FQVHFndDZFcGtoM0UvYjlzbERj?=
 =?utf-8?B?Z2ZpblFXS0cveEQyckVYQXJ6aHk2VGwrcEhSUGVTcVZwNVpraThBWm1rdWdw?=
 =?utf-8?B?eFJjaE1tdk9ZMEV3QTJqUDBuTVNtS1ZzRlE3cjNBaEQ2RDlPaW1XaUhWT21S?=
 =?utf-8?B?c2ZQamZiWkJoZFBCRGgrbWVnZWZxbW9USUFqL1psWkZnSXY4K21PbXQ2VFNI?=
 =?utf-8?B?UlJYVXJSa0pJbGFsRmlIckcwUjZDRTVhRDBJS0UvSnFpOWc1VG0rdFlndEU1?=
 =?utf-8?B?MEI1UElRbVZQc1lydmNHVDR4TU9QSjVwSTBreFdRSmFXWHRiN2QvUkc4TERB?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	artLYc4rPZ9ye3vBT14MaNIbFYaUMMhiE207ZPzfJ+cCzFjilOX8vhF87ie/wH5Hmepu+Bd/nHJGUb6eXivECxE+LoJbnWG7LTNExmtV5ZiOkgDThenGH2AlmlKS+AZRdtgl0rIRFrssU8mlmEsdNRCFPtimMeO8LEvd+bCN3z6dPCt3+rCspos8kgCG9FY61lkX/Ur3S3DmhQanjTyFzOBtw/3kH7GkaWFuBAN2ED8CkdMx4lIxodtlDz/vb06rSNkEytuc71HiN2WvWAYhbyWs5fjQP884OXa7cL9Y5gQny7hcFaGlOz7VV9gAA7+HsCkpJRvr7H6LLJ2rJi34In3rdhQ/5MH8t9/JrvcAB8tic+4eq7lriHKCSv1moccLMjGAPAx0LnXjA9pNxpeYO5R7AXNXmJ3ZeMWnj21oc0m/d4MrRq1mTPR33r/NMIwyaWv8HAAf1lIBnyPLxXhEc0JVFBMpN4u+kw8ImPuxLzI+KxK/OV+o2MvJ0j/rKlBx782Sj9M7y2Vq1EFFKW512IqSNp0SE1/jwADO8+uF8oFfopyElEYTajj4Nwnnq5crRnjBDufbrPwTBTRuJluW7O/vH6heVfx6dP4o+HsClr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416b9378-a711-47d4-e7d8-08dd0a2b126c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 12:50:26.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPjKEvWAcQTwqr7qqM5Rkksvcz+mFbI8Y81v1rMLBvNR80m4HIDjp2rISsSreC3Ba/56hkzBJcRYXGzMqrwv9QJ52KbKLE6eNE93NIaOtRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210100
X-Proofpoint-ORIG-GUID: tYtVrLvw3ExP_2nMW39Y3pTEn4tEvzxO
X-Proofpoint-GUID: tYtVrLvw3ExP_2nMW39Y3pTEn4tEvzxO

On Thu, Nov 21, 2024 at 11:23:39AM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 8:07 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 02:49:56PM +0000, Alice Ryhl wrote:
> > > This adds a type called VmAreaRef which is used when referencing a vma
> > > that you have read access to. Here, read access means that you hold
> > > either the mmap read lock or the vma read lock (or stronger).
> >
> > This is pure nit and not important but...
> >
> > I know we screwed up naming in mm, with the god awful vm_area_struct (we
> > abbreviate, for 2 letters, get bored, stop abbreviating, but throw in a
> > struct for a laugh) or 'VMA', but I wonder if this would be better as
> > VmaRef? Then again that's kinda terrible too.
> >
> > Sorry about that. I mean this isn't hugely important + ultimately _our
> > fault_.
> >
> > VirtualMemoryAreaRef is worse... VirtMemAreaRef? OK. Maybe VMAreaRef is the
> > least bad...
>
> Happy to use whichever name you prefer. :)

Let's leave it as-is, this is kinda our fault* in mm :)

* pun intended

>
> > > Additionally, a vma_lookup method is added to the mmap read guard, which
> > > enables you to obtain a &VmAreaRef in safe Rust code.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Other than trivial doc/comment tweaks this looks fine to me from mm
perspective so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> > > ---
> > >  rust/helpers/mm.c      |   6 ++
> > >  rust/kernel/mm.rs      |  21 ++++++
> > >  rust/kernel/mm/virt.rs | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 198 insertions(+)
> > >
> > > diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> > > index 7201747a5d31..7b72eb065a3e 100644
> > > --- a/rust/helpers/mm.c
> > > +++ b/rust/helpers/mm.c
> > > @@ -37,3 +37,9 @@ void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> > >  {
> > >       mmap_read_unlock(mm);
> > >  }
> > > +
> > > +struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
> > > +                                           unsigned long addr)
> > > +{
> > > +     return vma_lookup(mm, addr);
> > > +}
> >
> > I wonder whether we want to abstract some of the VMA iterator stuff,
> > because it's inefficient to look up VMAs by doing this each time if you are
> > looking at, for instance, adjacent VMAs.
> >
> > But perhaps reasonable to defer doing that to later work?
>
> Yeah, that should probably be deferred. Binder only has one vma per
> mm, so iteration is not useful.

Sure, no problem!

>
> > > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > > index 84cba581edaa..ace8e7d57afe 100644
> > > --- a/rust/kernel/mm.rs
> > > +++ b/rust/kernel/mm.rs
> > > @@ -12,6 +12,8 @@
> > >  };
> > >  use core::{ops::Deref, ptr::NonNull};
> > >
> > > +pub mod virt;
> > > +
> > >  /// A wrapper for the kernel's `struct mm_struct`.
> > >  ///
> > >  /// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
> > > @@ -210,6 +212,25 @@ pub struct MmapReadGuard<'a> {
> > >      _nts: NotThreadSafe,
> > >  }
> > >
> > > +impl<'a> MmapReadGuard<'a> {
> > > +    /// Look up a vma at the given address.
> > > +    #[inline]
> > > +    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmAreaRef> {
> >
> > Kind of lovely to have functions under the read guard and then knowing that
> > hey - we must hold the read lock to be able to do this.
> >
> > Imagine, a programming language with actual types... :P
>
> :)
>
> > > +        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
> > > +        // for `vma_addr`.
> > > +        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
> >
> > Why do we say 'as _' here?
>
> This is an integer cast where the target type of the cast is inferred
> by the compiler. It will go away once this lands:
> https://lore.kernel.org/rust-for-linux/20240913213041.395655-1-gary@garyguo.net/

OK cool.

>
> > > +
> > > +        if vma.is_null() {
> > > +            None
> > > +        } else {
> > > +            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
> > > +            // the returned area will borrow from this read lock guard, so it can only be used
> > > +            // while the mmap read lock is still held.
> >
> > Lovely!
> >
> > > +            unsafe { Some(virt::VmAreaRef::from_raw(vma)) }
> > > +        }
> > > +    }
> > > +}
> > > +
> > >  impl Drop for MmapReadGuard<'_> {
> > >      #[inline]
> > >      fn drop(&mut self) {
> > > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > > new file mode 100644
> > > index 000000000000..1e755dca46dd
> > > --- /dev/null
> > > +++ b/rust/kernel/mm/virt.rs
> > > @@ -0,0 +1,171 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +// Copyright (C) 2024 Google LLC.
> > > +
> > > +//! Virtual memory.
> >
> > Trivial rust q again but does this result in a heading in generated docs or
> > something?
>
> Yes, this becomes module documentation. Check out:
> https://rust.docs.kernel.org/kernel/
> or try out `make LLVM=1 rustdoc`

Cool thanks, thought this might be the case!

>
> > > +use crate::{bindings, types::Opaque};
> > > +
> > > +/// A wrapper for the kernel's `struct vm_area_struct` with read access.
> > > +///
> > > +/// It represents an area of virtual memory.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// The caller must hold the mmap read lock or the vma read lock.
> >
> > Might be worth mentioning here that you have yet to abstract the vma lock?
>
> I do that in the next patch.

Yeah saw, one of those 'comment in patch X, addressed in patch X+1' scenarios :)

>
> > > +#[repr(transparent)]
> > > +pub struct VmAreaRef {
> > > +    vma: Opaque<bindings::vm_area_struct>,
> > > +}
> > > +
> > > +// Methods you can call when holding the mmap or vma read lock (or strong). They must be usable no
> > > +// matter what the vma flags are.
> >
> > typo: 'or strong' -> 'or stronger'.
> >
> > Nitty, but perhaps say 'Methods must be usable' rather than 'they' to be
> > totally clear.
>
> Will reword.

Thanks!

>
> > > +impl VmAreaRef {
> > > +    /// Access a virtual memory area given a raw pointer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> > > +    /// (or stronger) is held for at least the duration of 'a.
> >
> > Well, VMA locks make this more complicated, in that we can just hold a VMA
> > lock. But again, perhaps worth doing this incrementally and just talk about
> > mmap locks to start with.
> >
> > However since we reference VMA locks elsewhere, we should reference them
> > here (and probably worth mentioning that they are not yet abstracted).
>
> Oh I forgot to update this, it should say "mmap or vma read lock".

Cool, one to tweak on respin also then.

>
> > > +    #[inline]
> > > +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> > > +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> > > +        unsafe { &*vma.cast() }
> > > +    }
> > > +
> > > +    /// Returns a raw pointer to this area.
> > > +    #[inline]
> > > +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
> > > +        self.vma.get()
> > > +    }
> > > +
> > > +    /// Returns the flags associated with the virtual memory area.
> > > +    ///
> > > +    /// The possible flags are a combination of the constants in [`flags`].
> > > +    #[inline]
> > > +    pub fn flags(&self) -> vm_flags_t {
> > > +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> > > +        // access is not a data race.
> > > +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
> >
> > Hm what's up with this __bindgen_anon_N stuff?
>
> Whenever you have a `struct { ... }` or `union { ... }` in the middle
> of a struct, bindgen generates additional types for them because Rust
> doesn't have a direct equivalent.

OK I see.

>
> > > +    }
> > > +
> > > +    /// Returns the start address of the virtual memory area.
> > > +    #[inline]
> > > +    pub fn start(&self) -> usize {
> >
> > Is usize guranteed to be equivalent to unsigned long?
>
> They are guaranteed to have the same size, yes.
>
> But again, right now `unsigned long` is being translated to whichever
> one of u32 or u64 has the same size as usize, instead of just being
> translated to usize. Thus the annoying casts. We can get rid of them
> as soon as
> https://lore.kernel.org/rust-for-linux/20240913213041.395655-1-gary@garyguo.net/
> lands.

Ack cool.

>
> > > +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> > > +        // access is not a data race.
> > > +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
> > > +    }
> > > +
> > > +    /// Returns the end address of the virtual memory area.
> >
> > Worth mentioning that it's an _exclusive_ end.
>
> Sure, I'll add that.

Thanks

>
> > > +    #[inline]
> > > +    pub fn end(&self) -> usize {
> > > +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> > > +        // access is not a data race.
> > > +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
> > > +    }
> > > +
> > > +    /// Unmap pages in the given page range.
> >
> > This needs some more description, as 'unmapping' pages is unfortunately an
> > overloaded term in the kernel and this very much might confuse people as
> > opposed to e.g. munmap()'ing a range.
> >
> > I'd say something like 'clear page table mappings for the range at the leaf
> > level, leaving all other page tables intact, freeing any memory referenced
> > by the VMA in this range (anonymous memory is completely freed, file-backed
> > memory has its reference count on page cache folio's dropped, any dirty
> > data will still be written back to disk as usual)'.
>
> Sure, will add that to the docs.

Thanks, I assume you mean this comment, which will form part of the docs? As
here we should at least replace the 'unmap' with 'zap' to avoid confusion
vs. munmap().

>
> > > +    #[inline]
> > > +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> > > +        // SAFETY: By the type invariants, the caller has read access to this VMA, which is
> > > +        // sufficient for this method call. This method has no requirements on the vma flags. Any
> > > +        // value of `address` and `size` is allowed.
> > > +        unsafe {
> > > +            bindings::zap_page_range_single(
> >
> > Hm weirdly I see this in rust/bindings/bindings_generated.rs but not in
> > rust/helpers/mm.c is this intended?
> >
> > Is this meant to be generated _from_ somewhere? Is something missing for
> > that?
>
> The bindings_generated.rs file is generated at built-time from C
> headers. The zap_page_range_single is a real function, not a fake
> static inline header-only function, so bindgen is able to generate it
> without anything in rust/helpers.
>
> > > +                self.as_ptr(),
> > > +                address as _,
> > > +                size as _,
> > > +                core::ptr::null_mut(),
> > > +            )
> > > +        };
> > > +    }
> > > +}
> > > +
> > > +/// The integer type used for vma flags.
> > > +#[doc(inline)]
> > > +pub use bindings::vm_flags_t;
> >
> > Where do you declare this type?
>
> It's declared in include/linux/mm_types.h

I meant from a rust perspective, but I guess bindgen handles this?

>
> > > +
> > > +/// All possible flags for [`VmAreaRef`].
> >
> > Well you've not specified all as they're some speciailist ones and ones
> > that depend on config flags, so maybe worth just saying 'core' flags?
>
> Sure.

Thanks.

>
> > > +pub mod flags {
> >
> > Pure rust noobie question (again...) but what is a 'mod'?
>
> It's a module.

Ack.

>
> > > +    use super::vm_flags_t;
> > > +    use crate::bindings;
> > > +
> > > +    /// No flags are set.
> > > +    pub const NONE: vm_flags_t = bindings::VM_NONE as _;
> >
> > This is strictly not a flag, as is the 0 value (and is used 'cleverly' in
> > kernel code when we have flags that are defined under some circumstances
> > but not others, where we can then assign these values to VM_NONE if not
> > available, ensuring all |= ... operations are no-ops and all &
> > ... expressions evaluate to false) but I guess it doesn't matter all too
> > much right?
>
> Ultimately it's just a bunch of integer constants. We can include or
> exclude whichever ones we prefer.

Yeah not a big deal.

>
> > > +    /// Mapping allows reads.
> > > +    pub const READ: vm_flags_t = bindings::VM_READ as _;
> > > +
> > > +    /// Mapping allows writes.
> > > +    pub const WRITE: vm_flags_t = bindings::VM_WRITE as _;
> > > +
> > > +    /// Mapping allows execution.
> > > +    pub const EXEC: vm_flags_t = bindings::VM_EXEC as _;
> > > +
> > > +    /// Mapping is shared.
> > > +    pub const SHARED: vm_flags_t = bindings::VM_SHARED as _;
> > > +
> > > +    /// Mapping may be updated to allow reads.
> > > +    pub const MAYREAD: vm_flags_t = bindings::VM_MAYREAD as _;
> > > +
> > > +    /// Mapping may be updated to allow writes.
> > > +    pub const MAYWRITE: vm_flags_t = bindings::VM_MAYWRITE as _;
> > > +
> > > +    /// Mapping may be updated to allow execution.
> > > +    pub const MAYEXEC: vm_flags_t = bindings::VM_MAYEXEC as _;
> > > +
> > > +    /// Mapping may be updated to be shared.
> > > +    pub const MAYSHARE: vm_flags_t = bindings::VM_MAYSHARE as _;
> > > +
> > > +    /// Page-ranges managed without `struct page`, just pure PFN.
> > > +    pub const PFNMAP: vm_flags_t = bindings::VM_PFNMAP as _;
> > > +
> > > +    /// Memory mapped I/O or similar.
> > > +    pub const IO: vm_flags_t = bindings::VM_IO as _;
> > > +
> > > +    /// Do not copy this vma on fork.
> > > +    pub const DONTCOPY: vm_flags_t = bindings::VM_DONTCOPY as _;
> > > +
> > > +    /// Cannot expand with mremap().
> > > +    pub const DONTEXPAND: vm_flags_t = bindings::VM_DONTEXPAND as _;
> > > +
> > > +    /// Lock the pages covered when they are faulted in.
> > > +    pub const LOCKONFAULT: vm_flags_t = bindings::VM_LOCKONFAULT as _;
> > > +
> > > +    /// Is a VM accounted object.
> > > +    pub const ACCOUNT: vm_flags_t = bindings::VM_ACCOUNT as _;
> > > +
> > > +    /// should the VM suppress accounting.
> > > +    pub const NORESERVE: vm_flags_t = bindings::VM_NORESERVE as _;
> > > +
> > > +    /// Huge TLB Page VM.
> > > +    pub const HUGETLB: vm_flags_t = bindings::VM_HUGETLB as _;
> > > +
> > > +    /// Synchronous page faults.
> >
> > Might be worth mentioning that this is DAX-specific only.
>
> Will add.

Ack.

>
> > > +    pub const SYNC: vm_flags_t = bindings::VM_SYNC as _;
> > > +
> > > +    /// Architecture-specific flag.
> > > +    pub const ARCH_1: vm_flags_t = bindings::VM_ARCH_1 as _;
> > > +
> > > +    /// Wipe VMA contents in child..
> >
> > Typo '..' - also probably worth saying 'wipe VMA contents in child on
> > fork'.
>
> Will add.

Ack, thanks.

>
> > > +    pub const WIPEONFORK: vm_flags_t = bindings::VM_WIPEONFORK as _;
> > > +
> > > +    /// Do not include in the core dump.
> > > +    pub const DONTDUMP: vm_flags_t = bindings::VM_DONTDUMP as _;
> > > +
> > > +    /// Not soft dirty clean area.
> > > +    pub const SOFTDIRTY: vm_flags_t = bindings::VM_SOFTDIRTY as _;
> > > +
> > > +    /// Can contain `struct page` and pure PFN pages.
> > > +    pub const MIXEDMAP: vm_flags_t = bindings::VM_MIXEDMAP as _;
> > > +
> > > +    /// MADV_HUGEPAGE marked this vma.
> > > +    pub const HUGEPAGE: vm_flags_t = bindings::VM_HUGEPAGE as _;
> > > +
> > > +    /// MADV_NOHUGEPAGE marked this vma.
> > > +    pub const NOHUGEPAGE: vm_flags_t = bindings::VM_NOHUGEPAGE as _;
> > > +
> > > +    /// KSM may merge identical pages.
> > > +    pub const MERGEABLE: vm_flags_t = bindings::VM_MERGEABLE as _;
> > > +}
> > >
> >
> > I'd say these comments are a bit sparse and need more detail, but they are
> > literally comments from include/linux/mm.h and therefore,  again, our fault
> > so this is fine :)
>
> Happy to add more if you tell me what you'd like to see. ;)

Sure, this is fine for now.

>
> Alice

