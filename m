Return-Path: <linux-kernel+bounces-416985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5A9D4D43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0271F232A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731CC1D8A16;
	Thu, 21 Nov 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IAbq1YTO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RIdac4nI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388611D4325;
	Thu, 21 Nov 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193787; cv=fail; b=azdsoBp0haot+4bEKb8FafNefptVw1GIx1XBs0Ouu/S6tT/2Ls7Rqe4b/yQE2C8iSFecwXmIQ9tWhg36VLXKndhhnG+0PdOdfZ2w28exKBzzeNGK8lwTHHIsAFf5hli8jdqexPDO05Cmo8HtALuymfB3B1JGLa0DjWhOH9vxw/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193787; c=relaxed/simple;
	bh=NAx8ZxuvTP2DWVj/ZS1Yjml0GSrHhXEYtS9KSh1z92I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oS9WAOW5FuVxPrTCHllCH8RphEHLGIEp5Ba64f/yt1FXpoeRJCdZPitxSodEAvZ+mDBvxF720E0DP95zHSqURQc51Bi+3lh0YmSKh4z6MwoAosJug2xuKCI2y/wX8KBRQ2YIITbx8kllq6ZQ/2HlC1jEuz05nQwFQDKfdyRGssc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IAbq1YTO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RIdac4nI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCtwsF021782;
	Thu, 21 Nov 2024 12:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DaDnZ5JzOLBM6W6y4G2wHRCFnzFj1u757cIIdUX5Co0=; b=
	IAbq1YTOInRliI2Gv2ju4pHjnzvapCM6tFOyefbbUNGfcCnnQdb3uMkTYa26u1vg
	Q/hilvRXCgZCiMlKW9ZQ7HPDGvlKDh+yIX3IebX1+ZFURUu3rcY8vQlIAdafVD/s
	dsbEq9kTwXThUvXY4BsXY44HA3Xv3Tp+NM3GGieHVo6dX9259yZ+9e7DEDCf3cDF
	qHDJHN5zcz3F2+ZpEF2ETCfed4sQNtCw2oVToZ10xxTUCZ4C9UlQ4cSybXw9xsr/
	s2M5wxPkc4S02bPRL4nD1I5r3fysoDY5QULuh3tCVxN4YV79eF/gW7hO9fgkHd5p
	bCZ9xT/ZYLb8vaCFft0ZAw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa9k0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:55:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALB7SsF007836;
	Thu, 21 Nov 2024 12:55:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubma6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRhJjnoDxSwpebwT/qX4sF8sPyaMhIuI6zwDZhbl5LbhCMZPSA1TPCc8ShdEoc6FTPFy3K/VJSK3sV7PqGznUUnRMnX6z9YofLHeJq4+qS49KLPAiieQw3/8O0jVWgvXAIPeNbdQt8LCvrtB1INYQi3R6xYmMK1zEpt0MHXm4gNW3c/8vyI4LImY8+wK5CHE+HkrZeSuAV0RhNKB7pB/QP236mcuT6TyaAk1n3v5DrBovUf4yvFGJoedyminsaSDsPa6PLipVL9v4z8bzoESgYqyAuFUjEJGds/cF0FdYwqpPj5xVhu5U9XkQJ47NSvs9XepPGgu4ziiy2SJch22YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaDnZ5JzOLBM6W6y4G2wHRCFnzFj1u757cIIdUX5Co0=;
 b=iDc0i4OCA0cOIbL4iwoWm2xTDr7vXaYIywWFWNrmdZJw8apUUq6mRQBBFrRIBI4FpthCXIJDbnDa6BgsVloHpQfblJLkQ5vX8y3lPn7GooxI4TOOdqsTEWVdoL1fxPzPGCo3QtlTImwLUE+hsOUWnd0930qzTWcgUuINUTCVD12Wpq2cvIeAxfshh8WfcnY3Shyu77scQjHnrnpbVjR2ucJsVQEXhU8UKj2ZJ6YMSE42g439tZEqDHDTRnvGYJQAvFmUWBB2elRht5bymtt4w7+nKvW2GszDLmnYnJg3VJubizq25fxJtqaJeRvbyS0kfw01q0ZOwsbTct+p3X1XUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaDnZ5JzOLBM6W6y4G2wHRCFnzFj1u757cIIdUX5Co0=;
 b=RIdac4nIUUuRWfFITvxtxUY+Fa10IFMSJjzpWqA0NZrUeGfZFHA6aYDMRm7O3a5lBJFIp6vs0s0K29UMJWa9XxQlink5uJCtG3VA0ecE6J80muRYPC1hPAPfHYVFvEBFr+ubl8QQqP0+rYHuKq0vz4yoEYDdwQy9oC3fkCqDAdU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7917.namprd10.prod.outlook.com (2603:10b6:408:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 12:55:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 12:55:53 +0000
Date: Thu, 21 Nov 2024 12:55:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
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
Subject: Re: [PATCH v8 3/7] mm: rust: add vm_insert_page
Message-ID: <99feac91-4b32-4e90-9462-0bee639c6810@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-3-eb31425da66b@google.com>
 <e5660b41-c1df-47f1-83fa-c243805f74cf@lucifer.local>
 <CAH5fLgjsk_t=tQdAkB6O3cCDZQp2TC=uSB3EUsY_4qDegpVEYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjsk_t=tQdAkB6O3cCDZQp2TC=uSB3EUsY_4qDegpVEYw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0637.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: f502ba86-6693-4dbc-524a-08dd0a2bd4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVV5SWUxSHBuUG9GdkRJNnZMQnF1M0krb21OVU43ZWVNWFMxZTBMUElzN052?=
 =?utf-8?B?d2ppVTYrV244Z0E2UldOU241T0xXMzZDUm9yNkRKM25ocXJ5SiswQzVLaGYx?=
 =?utf-8?B?ejRUc3NNdmE5ZEpRRE00U3JXSzJVa1hzTHhWOUdINW1PK3gwOGd0WHJ4bEdr?=
 =?utf-8?B?ZmZsNzl2WHpzUzdTcml0Ti9PMDUrMk1ic29TU2hNc1IrL05kNTRJQ0pibVNO?=
 =?utf-8?B?a29hYmdXN01sRjBaYUdaZGR1c0lXelZKNnluNWhMWDl4d3BnRjhxdEx1M0lh?=
 =?utf-8?B?bUEwNHhQYXdTRzVCek1kSHR0RncxaC8yMjBSM0RhcGNXMEF5MFhndEtCbDE1?=
 =?utf-8?B?R01sZDZXcTdDSm8yOTNCd29FZjBqb2t6dkI1VVc1Njl4dW82dEEyQ0NPb2E5?=
 =?utf-8?B?WHdvVmFjWXlBTGRDdFFOSUxkcTA5eEJJOGRpVjk1NmxFMGdYMlYwQ2UyajVs?=
 =?utf-8?B?cmJWbnFhZ1FwRXZvaEF1MlRkQ3FlQmJnYmk3NGN3b3dZYlhJbW4wWDRUaUdy?=
 =?utf-8?B?NWNOL3R6b1prNzlZT082MUpDeUZ0OEpxdTE3b3RSOFdkZmlNaTZScDR6Ry93?=
 =?utf-8?B?N1R2a1luUzVxdjRCN3dxdHF3TGxLN250OXN1anZIYkpkTmowblhmVEJvY3Zs?=
 =?utf-8?B?T2FDRkNxdzR0WWQrQkNQeFJsUkpxWEhPUnVOU2tMQkl5VjlvQXpqNEpqbWhs?=
 =?utf-8?B?WGtlazVab0s0bXdQUTd2SWRqL1FsNko3bjVGLzNOa1NDQnhnVGo1Ri9DeG9B?=
 =?utf-8?B?U1k3UEdycGd2VWxremxzWDhTa2RocHo1SklITzBRWVFiNzZlWlZYcWxRUlNm?=
 =?utf-8?B?QzhTUW9MeU5WdXZiMWZHMm02eG5VYUZXckw3UUlyUUFzcjZGR2dMSWFuVUxx?=
 =?utf-8?B?ZVdVcVphRitBYkNHRVQySW9YVEdKaEUybzZmLzFJNXNTRHJwenluMlNIOUs0?=
 =?utf-8?B?NmZ1Z1lQUE1tU3phYzVYdEk4dEZFSmlGYm8wSjh1ZTFFYnluM29NQmYrdDRT?=
 =?utf-8?B?YTVQb1ZHcVZaaEpJd05Fc0xWTlBDS09zblNHRWJKR2xFQXJJV296ZSsvN2Uv?=
 =?utf-8?B?SVE2aUJBZ1FhWDRPbUFqYTlMQmtPSnR0dkpVZk9NWG8vYUZRYk9YT09FRmhs?=
 =?utf-8?B?VUN1UmdxVk9ra3d0ZStKa0t2SXgrVjU0MHAyZEloak9Ia0QzYWF2NnlNM0hI?=
 =?utf-8?B?WndFV284MWZjalhOck0zbUR2eHFrQWlXTEkxN0dHMlM3N3hCaXpncXFFZXc1?=
 =?utf-8?B?WExOYlBWakR3WlRXUHh4bjFFWVMxaEl4TStPNlNNK0p3ZW5LQ3BSL2MzMVN2?=
 =?utf-8?B?SWxBTVdPczlJNTVwNFVGNDB6OXhFL1UxQlh0eEFZWE9TTUQveFY5ZkUwcG5N?=
 =?utf-8?B?WmVXb0syUVh3elVqK1pGaXM5bkduWDlVOElYbjhsVWtGamlmczVNdWpzR0NT?=
 =?utf-8?B?OTZ1TDdnWGRrVGVOZFBzNXd0bVIxcTAwRk5idUlvejRwL0xtRDYxMURKOE95?=
 =?utf-8?B?ejNMRVM0QTNhQ0QrR3RRNk95Uy8wZEh6VHpCRXVGc3BSRHI2SkljUTBWV3h4?=
 =?utf-8?B?N283Tng3VzlMNlltSE9ucXYraWZnQS9oNzA3RTRVQVpwdUhxZG1yd2RKaW9D?=
 =?utf-8?B?Zk1iZ0dOaW1MZUFxdHhKS29UOHNGMFZjOUhQVGVMY3ZqMGo3M2FZZ2NnUUdS?=
 =?utf-8?Q?RXDWv+YypVGQREbVaJHk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHpHTE84bWhQS21RUHpZMjArcUxVcmx0VFBNdDFjWGxGZFhML3l3NGdwQk9H?=
 =?utf-8?B?T1pPb0Y0Y2ZmZVRFWEZZV0t6WHVGajZsN0lHVXFWYkNEL3AxYmpDcjY2blha?=
 =?utf-8?B?cm16alZmU3Z4TXBoTHNLVERPNW80NlRZWCtZMEs2MkFHcHorcFREckFHOUpu?=
 =?utf-8?B?eno2eVhXL0FRSmUxZnU1ellNRzRmT1ZPRGMrYmkwb01EZUl2Wm9pUEZTc2t3?=
 =?utf-8?B?aHJlcUR0UUFhalhwRGNHd1F6QkhISDdpMzI5TVpiNlU5TE1QeW1KclFZQzVH?=
 =?utf-8?B?YUV3SkRHN3UyVjZEeksxRXhoY3ZQTDFoa3M5YlNacFFzOUpLZ1hrVHNHdWRi?=
 =?utf-8?B?Yk5Cd0EvdDJQajV5S2dTeTMyN2JUOElsRktXK01JQllyamFqSTRNU3FvN3lZ?=
 =?utf-8?B?ckxVbTY3RFN1K3VZRDhaVWhOMDQvSkJvdlYvamlCSFNHOGc1Qk81V0pKT2Iw?=
 =?utf-8?B?cXhIR2d2a0RhZDBXaGhGQXNLdldUamh6NEFyUmdUUlZzbVFVa1c3cnZwV3p0?=
 =?utf-8?B?Z2ZEWE1BelZwbnFzanFYWHUxT05uOEdlRGpZZndyQ0x2a1NvZEQrdmVnOVli?=
 =?utf-8?B?ZDJEd05DVmJaSGIrcmxaUWNIdTBhcWx0b0tqN0dNc01GaXJPQ2l1RE5WdkdC?=
 =?utf-8?B?QWdsWis1V2krTlhYNk1kdUtBZlM2d3p1T2puSE91MjQ1eWR6NTZkaGtZTVJF?=
 =?utf-8?B?djY0SWNSVXhRNmpSb2NEUURkaENFUWpNWnhaWmlFZXhzeDR0QnZqUWUwRkZZ?=
 =?utf-8?B?cnBYMUhOcDZHRGhPYmZCWFg3WWw5alZpYm5mU1E0V21KbWkrM0hmcTVhamlp?=
 =?utf-8?B?QTBqdTJQZGNHdThPcTBhK21hNUFWYkpieW5TQjFCdHZUYnlJVFBVSEJ4bXY5?=
 =?utf-8?B?aEYzRDQyc0lHdWVhRlhRZElwb25wcVVNMVQ0YkMvdC9adHU5S2kvVXR1R3dC?=
 =?utf-8?B?Q05iT2pxeUZTWjJUVW1BR0UybU10OTBxTDhLMllYUFQ2bDFOZXlIS2pwWUVy?=
 =?utf-8?B?aFpBYVhWZWVBbVhqNkU1L1NYN3hXcjlNWkZJUkREcTdFREJrRUFsNDZVMm9G?=
 =?utf-8?B?Z2FSMmpoV2ZXZUFkZDN4N0pqdlNibkNvNEZraVlyU25iQVpUMEhoM2svWGx0?=
 =?utf-8?B?dEt1MWlaODBCLzF2WW03azdJWVFkYmh2T2dFTkNMNmV3aXcyZGZqbGp2Mmwv?=
 =?utf-8?B?RmVpVXFybThWcnd3NkRZQjlnME85dUdvWnJTMWpSTS9ZbkdDc21lNFRyblFU?=
 =?utf-8?B?U0lzQjQvR1pzanhKVFFwaGgrdDgrbS85NmRLalVvS0JDWS9pWTZYeTYyZnVJ?=
 =?utf-8?B?WTBWR0YxNEpoZjNrcXpvQjB4MlY0RjQvZzdCZzNUWEFtZDVxYnk5SzdkL2NM?=
 =?utf-8?B?ZWxrd1Baa25Xald5aUNHME1aTTdPb2VlcEc0bUlEeEU4dmNkUC9WOUFsS0J2?=
 =?utf-8?B?ZTF0R0dOVnQvN01TV1RpTGRiaHc5cUs0QWNoejBFdmZpZ09FRzA3Q3l3TEVp?=
 =?utf-8?B?QVJBd05IV3E3cUlUVEhtT2NJbkRDdzcwajAvbXI2SFdsQTg5RjVlN0tid2Js?=
 =?utf-8?B?bzNtNHF2RDhRam5JcW1VU2oySXFxWHhKemhSeGJVTUk2L2FSbTBYWnNuRlc4?=
 =?utf-8?B?RE1TN0JaNlpLc3kwOXdET2dyZ2ovTnNLMGpmdDI4Z2tlVEFlWGRlb3Blbm5Q?=
 =?utf-8?B?TUc3Qy8vcjFRRngwSEdBcVdjQjFjM3Y3SUVvRko3Mi9DMDhaUUlqMnB1WmpS?=
 =?utf-8?B?WndaRUZEUERhUWExYnlwZjBzTXNMY3JSLzZaSnV1end1RnBCVGhPM29rZ3kr?=
 =?utf-8?B?NU5BelkzVGwyczNPaTZIWVFVSW5KWDcxQytHMysvMjZ0Yit6SktNbDRCTnFi?=
 =?utf-8?B?WHIvM3lVdUlTb3pGRU93cUpiRU9pK0JsWTlVZGcxRU4vM1RucWEzSVEvZVRk?=
 =?utf-8?B?TjlVN2loL3ozQlIwNDdCODJwQm9zQ1dNNExybkpkSzZOWUQ0VkZ3U1d3RFhI?=
 =?utf-8?B?RjBoaFJ0SkowOVYyUWIzMUIzTHh2NkJaQ1hUcEE0MDdEbm5xTHBXQ09wREQr?=
 =?utf-8?B?eGowN1Fzc3RsbWlZQTJSRS9oZTc3R0RvZVRyWXYxajF0b0R0UDNhWTJ5aWpW?=
 =?utf-8?B?WFdqQmNGQ0JxTkFhS2sxRnhMVmE1ZjBza1hEWGpyRzFINDYrdjlaejV3bFVK?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1+9gl6n6Aj7AmZNP5KQ1Py1ZXWAl4k6negCK9bRca7PSdUT64nUAWeVkayU9Lsj/y0r7uOLh1esbb1ylEjbOrelwAUa35tarD15NaCie7r/FTlOBtTJXLQ4X3Vt7ToLAMJouizVoyg7FMOUHPpzuJy0VF+SyHNxOhJkRhcFSBf7udBgedhGTyTu2E7DF6dnnQDyE9JRfjYaBQ5sTyOiVo4FmZJPW/4uQu+k0z7MOKkxEUR/Gv8BEx9z1f/P5ATZeXtpTDwwTwvFnUCYY0Jm37F6xXouoNYMkFNE0mEwln0d52n89pCYXXq1qfIth6UhhcOiQineZ4eunt/O9jXALAZW/lPDUW3YLhoAjRGpm7F4ZeneX389y49VO2p8XKUlNG+ORj8H4iOPqQQkwRBtOKXWDx2e4h8LNNJR9DiqVYfEr49cfu5RHWfEp7TcodAd5vp2e/1p/S4NK+R7IgxsZP3lgMLAvUBNDe+68+p1MEc9BikiTuO05ifdjJaF6CuiwaDawsQjoqiPkWgcxKeWF44534TID77JCH687xHhTcW2y3aMeNMva66XGbK8hAZyGHmtsFp0vcToU4oVfWow7J4BZv75dI7u952ywzb5arZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f502ba86-6693-4dbc-524a-08dd0a2bd4e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 12:55:53.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GArMYWMMBl3Rs1B0mMkNGA2/rDAkhyv/vg/1fK/AG91QrIlQPKR3xS3dTgtsa+qNZ7JcFXRtMU+TzF/KaMYCuyMkYjDxo6hVu23uebxSwvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210101
X-Proofpoint-ORIG-GUID: ggZcNCKNuLzVPewb1Ky67lAXrKjzsb4s
X-Proofpoint-GUID: ggZcNCKNuLzVPewb1Ky67lAXrKjzsb4s

On Thu, Nov 21, 2024 at 11:38:29AM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 8:20 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 02:49:57PM +0000, Alice Ryhl wrote:
> > > The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
> > > flag, so we introduce a new type to keep track of such vmas.
> >
> > Worth mentioning that it can be used for VMAs without this flag set, but if
> > so we must hold a _write_ lock to be able to do so, so it can update the
> > flag itself, however we intend only to use it with VMAs which already have
> > this flag set.
>
> I got the impression from Jann that the automatically-set-VM_MIXEDMAP
> thing should only be used during mmap, and that VM_MIXEDMAP should not
> get set after initialization even with a write lock?
> https://lore.kernel.org/all/CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com/

Yeah he's right, but we do allow that to happen, perhaps we shouldn't. A
separate patch idea ;)

In that case let's leave this bit out, as while we allow it, it seems
inadvisible except on very early internal mm initialisation perhaps.

>
> > > The approach used in this patch assumes that we will not need to encode
> > > many flag combinations in the type. I don't think we need to encode more
> > > than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
> > > becomes necessary, using generic parameters in a single type would scale
> > > better as the number of flags increases.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> > > ---
> > >  rust/kernel/mm/virt.rs | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 67 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > > index 1e755dca46dd..de7f2338810a 100644
> > > --- a/rust/kernel/mm/virt.rs
> > > +++ b/rust/kernel/mm/virt.rs
> > > @@ -4,7 +4,14 @@
> > >
> > >  //! Virtual memory.
> > >
> > > -use crate::{bindings, types::Opaque};
> > > +use crate::{
> > > +    bindings,
> > > +    error::{to_result, Result},
> > > +    page::Page,
> > > +    types::Opaque,
> > > +};
> > > +
> > > +use core::ops::Deref;
> > >
> > >  /// A wrapper for the kernel's `struct vm_area_struct` with read access.
> > >  ///
> > > @@ -80,6 +87,65 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
> > >              )
> > >          };
> > >      }
> > > +
> > > +    /// Check whether the `VM_MIXEDMAP` flag is set.
> > > +    #[inline]
> > > +    pub fn check_mixedmap(&self) -> Option<&VmAreaMixedMap> {
> >
> > Nitty + a little bikesheddy (this may be my mistake as I am unfamiliar with
> > rust idioms also) but shouldn't this be 'as_mixedmap_vma()' or something?
>
> You're probably right that this name is more consistent with Rust
> naming conventions. :)

Yeah, I think it's reasonable in rust code to follow rust idioms and
conventions.

>
> > > +        if self.flags() & flags::MIXEDMAP != 0 {
> > > +            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
> > > +            // satisfied by the type invariants of `VmAreaRef`.
> > > +            Some(unsafe { VmAreaMixedMap::from_raw(self.as_ptr()) })
> > > +        } else {
> > > +            None
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +/// A wrapper for the kernel's `struct vm_area_struct` with read access and `VM_MIXEDMAP` set.
> > > +///
> > > +/// It represents an area of virtual memory.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
> > > +/// set.
> > > +#[repr(transparent)]
> > > +pub struct VmAreaMixedMap {
> > > +    vma: VmAreaRef,
> > > +}
> > > +
> > > +// Make all `VmAreaRef` methods available on `VmAreaMixedMap`.
> > > +impl Deref for VmAreaMixedMap {
> > > +    type Target = VmAreaRef;
> > > +
> > > +    #[inline]
> > > +    fn deref(&self) -> &VmAreaRef {
> > > +        &self.vma
> > > +    }
> > > +}
> >
> > Ah OK, thinking back to the 'impl Deref' from the other patch, I guess this
> > allows you to deref VmAreaMixedMap as a VmAreaRef, does it all sort of
> > automagically merge methods for you as if they were mix-ins then?
>
> Yeah, I use it to "merge" the method sets to avoid duplication.
>
> The main limitation is that you can only deref to one other type, so
> you can't have "diamond inheritance".

Aww, diamond inheritance is such fun though! ;)

>
> > > +impl VmAreaMixedMap {
> > > +    /// Access a virtual memory area given a raw pointer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> > > +    /// (or stronger) is held for at least the duration of 'a. The `VM_MIXEDMAP` flag must be set.
> > > +    #[inline]
> > > +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> > > +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> > > +        unsafe { &*vma.cast() }
> > > +    }
> > > +
> > > +    /// Maps a single page at the given address within the virtual memory area.
> > > +    ///
> > > +    /// This operation does not take ownership of the page.
> > > +    #[inline]
> > > +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
> >
> > I'm guessing this 'Result' type encodes 0 vs. -Exxx error codes?
>
> In this particular case, yes.
>
> More generally, Result is a discriminated union containing either
> Ok(val) for success or Err(err) with some error type. But the default
> success type is the unit type () and the default error type is
> kernel::error::Error which corresponds to errno numbers.
>
> In this case, the compiler is clever enough to not use a discriminated
> union and instead represents Ok(()) as 0 and Err(err) as just the
> negative errno. This works since kernel::error::Error uses NonZeroI32
> as its only field (as of 6.13).

Kinda selling me on rust again...

>
> > > +        // SAFETY: The caller has read access and has verified that `VM_MIXEDMAP` is set. The page
> > > +        // is order 0. The address is checked on the C side so it can take any value.
> > > +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
> > > +    }
> > >  }
> >
> > It's really nice to abstract this as a seprate type and then to know its
> > methods only apply in known circumstances... I guess in future we can use
> > clever generic types when it comes to combinations of characteristics that
> > would otherwise result in a combinatorial explosion?
>
> Yeah, so the alternate approach I mention in the commit message would
> be to have something like this:
>
> struct VmAreaRef<const MIXEDMAP: bool, const PFNMAP: bool, const
> MAYWRITE: bool> { ... }
>
> listing all the flags we care about. This way, we get 2^3 different
> types by writing just one.
>
> (There are a few different variations on how to do this, instead of
> bools, we may want to allow three options: true, false, unknown.)

Sure, it's something we can come to later I guess as we progress.

>
> Alice

