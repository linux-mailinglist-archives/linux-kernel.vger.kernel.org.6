Return-Path: <linux-kernel+bounces-538209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6CA495DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ACA3AB8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87145258CDC;
	Fri, 28 Feb 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PaflrEe3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UkR91dri"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33101F9416;
	Fri, 28 Feb 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736202; cv=fail; b=b8HMxfSKs+g66MM2mjPJRkx334fuMRrTN8wsvhy626aX0fgiqN2ZzGHtR0nPb/GFVD9gToRVPKZLyDaBXgl+0RCHOvzJ0GiKO5u6FhTXNgM2QREHqNBbd+nvdKmWjCEFhkOkeUaBE4KTYifRtPfgxFZz92FFdCU5NGLBN6R8PaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736202; c=relaxed/simple;
	bh=HiBHtR0bT2FWmbQZQWihyym4fb2SbfNco8eAigq+Tbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=stD1/o7a/DDeYBlbLzGrsUarUtbpEcLwCGsa3Jr6731kz6oHlhBOK9KMbNioDQ8Si1XpO7NsDUQ2tq8r3FbQ52UM1xD6eWYGYQMmeB7zsg7kuU6Nlf5VlNiJR7s/xJvKsi7VBj1orbGAi5OepMjyDIP6796mrU4t+8ZIEF/e7NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PaflrEe3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UkR91dri; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9BnSn027182;
	Fri, 28 Feb 2025 09:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4esQewLIntfC1qQV3f+fMitHNbeTYuXAyK4LzTMdBu0=; b=
	PaflrEe3xpoiUZWXIQTFajSXE1B9CcNxIJ9tOajn5d7HHnzoAfu/zUXAt+TWyqGO
	67H7g3iTgP40SiAj3edTXLI0ZBPdca4pZhvKWLlp286lmJaNu6LBxfQei/p7d+bG
	+Cr6ELf6q7anTX+Uc2a9Zj4ITuLF5Iy8QtyJFQGZFNxz5BY9brbNMGpvdY6ZSbtR
	HzF6/qrG8JpMcL++eC7QHm97O5DybCoeKJiHNBAbK3LbH7B+iAZtIZ1GsSV1izxj
	r48GJ/4SxHDaHh4yArQK/wLGNANBxZ51XhrRCE+rxl1RgQx8Jb3gFFSP0C7KJWCx
	oOJX+0iZ8CnuBng/UfM6ZA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psed7p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 09:49:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8LGhJ013165;
	Fri, 28 Feb 2025 09:49:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4530jwnfk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 09:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT1EdE7Arfr8iaKskvMAcud/7Pbh7/FHrqb9844z/V9HV0lRB7DaLf/sUSqbuoLP2ILI8m5YbRxjwbdqR7C4+MJhS8o+oXCO+Tr4P9okMyyvHuJV9g5ed97nAFAyy40mjPnDunNvNZMHhTTKu3qjsWiraVW3CwH+Fp7dmEkpw3j3rfMgO40Mqu5Rct+yrLCXs+O1SIiK4xAXD7aNYhs4sD46MNgWl+Lqfhkk4go3mGUh66Q03WAoshwIFB3xXBOfSsw06BVwSvu1UFMSyye9XdqP3bHVy6fYH6w3oDb92jou8WSyOEKSSgu0NiAIb2lTIIy7u4FlG+DWU5imNZn9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4esQewLIntfC1qQV3f+fMitHNbeTYuXAyK4LzTMdBu0=;
 b=tafHxm9jySDUB73MHvy23GePcOX2rlha3ybUkHcQCuhujOn/JGjjkxoTOi9stTkTEIfs6AZY0kqgXEwntGNp/nzbC33LW5v0Gb9NZA58tVdTS3b551EjgLc4BSVcisdaaCveL77ju16tTF30p+ipsxnM19qv/ANDakNnmeErVqM98ZPdi4L75oCHBoJ7KqctCbdEN+QHAuFg/nu+4yti7T0VANZMS7XIU2oU8Y/nPmrmc6TYinb541Ys+a5BHuN6lp3A4id9l7htmCCyuiG/jfMJJ4KJRiPfDIZtlAlZpZ6d+Hn9dESMKCHEZ6v84cBoHF3GOte+J9Sqt08cQoLzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4esQewLIntfC1qQV3f+fMitHNbeTYuXAyK4LzTMdBu0=;
 b=UkR91driULOOxIlMJP0xV1EJ19qgJ7K86idmphnoAjg5HvAPkZwNaXX3l9ZPyzT1+2Z3mF4Xz4K8VSCj+SGsiqp0DwM0UUmAZubiPMlV0FsE2k3RwxE8hEryIqKpOu4l1jR1MCKgbBAdlgwNGsKw3jtkbYaTf4BrDUjmUt1uog0=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH8PR10MB6386.namprd10.prod.outlook.com (2603:10b6:510:1c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 09:49:05 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 09:49:05 +0000
Date: Fri, 28 Feb 2025 09:49:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
 <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
 <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
 <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
 <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH8PR10MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 278c94be-f0ef-45e4-3c28-08dd57dd239d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk5adFJjLzJHdER5SndTeHNZMkFEMnZTNUZBOHlHb1RJRFdaZ0dtNXVuV0ZQ?=
 =?utf-8?B?SC9WZ2poeC8ydkxzNHFaQVEyRnBpalVEV3IwTVdhc2hpcnJlL2ZIbWZlOVUz?=
 =?utf-8?B?QjlYcGtzOWxhUlpjWW9TQWdaUk9FbklRK2lWT2pJMTNQWWo5aXppdnRyZlpU?=
 =?utf-8?B?SjdNQWYxYkFGV0FCV2M0djJmYjRQeUd1bjViRGxFZjA0M1NmeEhnWnJpNThS?=
 =?utf-8?B?aTVnZlk0L2dnNEFqQXF6ckd2Lyt3WWpoY3cwSnlDZVQyT2NIYnlqZUNxR3o3?=
 =?utf-8?B?eWZHbTNla2ZqK25pVzNrUTM3VXl2Tis1anhaWThPMjZpbzFjbU16T3FHajNk?=
 =?utf-8?B?dUlNMjE5Q25RRVRnL213SjBmU0lxaElOWllUaE5pWSs2ZW9DcXUrVXFpMzQ0?=
 =?utf-8?B?TkQ5c0U4VVduLytaWFp1VG51dkJrb0dEL0J6WDV2YndJejJaVmZOUHhzMXBF?=
 =?utf-8?B?TUxXUGtEcWZMeEdDbklPYXhBdFJsby9sRUFqcFBWaHZSTlBSemtneitVSHNZ?=
 =?utf-8?B?dEt2WU9LZ2paK2ZIN1l2YXlKbVArN2c2Uk5KdThGeUxGVStkdDhqUzliNXdL?=
 =?utf-8?B?bGFhMUVyZ2lmNklIR0FkaWs5OXpncHRDUGtKSFBleFdDc2tHSzU1S2I1MjM5?=
 =?utf-8?B?dWY4bEJ2eTk5TEk2NjlXeVAwMFVheDN4VWlyZWJDWXgyZ2VKZ25tWHB0MmZL?=
 =?utf-8?B?VEJFWStXMy9aYWlYUlBWZmVsOS9KbHZFSHBqY2grdUt6dnJVOUwvOFFxeGdE?=
 =?utf-8?B?cG45MmtzdFBiNjR6TnFTYXJmRksrbHZ5bmxPVGhacmxWRmVHQk0rYjBZYnVy?=
 =?utf-8?B?cUN1RnpRWFlGd3R2cisyS0J3VjJFTmRoNmZuam94YjRIbDFxUFlRUXdvM3I1?=
 =?utf-8?B?UDArRVR2SythVXYvQXVxeDlIc1A4R0xlVUgwRHVhcDcydTdyajJpMitSajU1?=
 =?utf-8?B?VVJpQlBqdWJOOTR5RTBTa1B4bUFGbmpmVjZ4dWxpc2NzY3Z2dnBqaUkrQmJl?=
 =?utf-8?B?L0tDbnpGQU9lWExrUlh5L3U3ZS9jVk9FRjFsNkd2ZWxZZnd6d1FMYTUzTTRB?=
 =?utf-8?B?bHpWYlFOQ1d0Z0RUSExJMDZQZWdzWlY5U1BrcHZlb28yVGhwN0ROV203RHRL?=
 =?utf-8?B?Tk9ZYmdRbmg1bjdMWHpzTjc1ZU5oOXU5Q1NILys0dllaY0FHWU1RRjB1KzE1?=
 =?utf-8?B?akY0bERlSHpPQkQzbFNuVjQxN0d4NkJWYkhocWZxaDVqckgyeUJmQ0VxbE1I?=
 =?utf-8?B?M3BjTkhWdDVMd096UUd3N2w0UTNSVUNNek1QdjNmYlE0bEJUMEt5UWlON0py?=
 =?utf-8?B?VlM3eGFXMXlKdWhpUmZRcWplMVdPSW5yVHJPM1lRSURabzBEZXhwd3prYmV0?=
 =?utf-8?B?SEFPTUNkeitFemtkbS9HaUMveThSWFI5eUVUNUpzbXkzTTVNNk4wNnlncXFh?=
 =?utf-8?B?OG5PK0ZCSVIvSnRHNVNlVk5tNW1panY0YmxuQU1BUXJlbU9SRlNzejRRWjNu?=
 =?utf-8?B?NmxwbDR1WjRGR1lZWGFOdTJyamFWMEdNZXZDQ1kvUzF3ZFpBM3YvbHA0Zi9B?=
 =?utf-8?B?eVcvTGZmOGtKWWoxSGVyZjRDODBGVEkzT1dUNnV5VTNlNDF5UWxBZ1cvR1NC?=
 =?utf-8?B?R28zaXppbDhUYjNTcTlseHpYS3FkRVFtMUZ6MXJtSEpYcDRzcUh0T0VpWWxU?=
 =?utf-8?B?VTFXZ05VWEdub283Sm9lMnNid2JLUTFHR0o4aHI4YW1NQjZNUW9yTm9yRkhv?=
 =?utf-8?B?UkxBZ1ZlTXZmbnJaYjR2cjhvYnRVM3UvbXJUUUZIcUR5ME9GaSthckV3RHh4?=
 =?utf-8?B?NU1sd0NKcDVtekV3SHBsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUtIVWxFWTZSWktERDdkdWJudEZXWGVlSVJxSTB0Z1A3Y0FTNGxaRXRSZGpK?=
 =?utf-8?B?aXFqZGdIaHVpMDRTUlBFZUFGdHdPd0dTM0VnYmp0bVZwZ3kzdXJkM3hrOFdZ?=
 =?utf-8?B?ZVhmTzVNaGl0QTR3U3UvbjEzSzgyZExnOHJqUVBia0ZFdjcyZjVHMy82dm5j?=
 =?utf-8?B?dm45R3AwOEJTa21mT0hqcXQvSTR3VkZjR2NjRHE4T21leGdxSlorM2dGd2Zy?=
 =?utf-8?B?cGZ1bjdJQUZxbC8wVU9vaUd2SWVBTDJieExrbElsVjJ3Ry9JR2gwNnl2bnhm?=
 =?utf-8?B?L201clNHS2RWdU9nd0ZxVCsvTk9KU2cxRXJDNWErbXhLYS9ZZUN4RGE2a3FG?=
 =?utf-8?B?NHBGYnJPUTFtVmFRM3lUWkZkNjJFcVZTRHFZMk5mbU5DNm5qek04d3dLOHV3?=
 =?utf-8?B?K2M0RTJFMVdWaXBZeGEzNGlMT2tqTjZOdzdwK25NYzh2MTY3M2lyK1BZQTV6?=
 =?utf-8?B?N3lhTHF5MmZsWWNJZy9oV1htTFNPOTVWbUhhQmZQRnAwVGVCNyszbVNVQ0Y3?=
 =?utf-8?B?RERTTTRmc2ZTQVF3VGFucGRKamN5bVhRQW1LU1hSQUxEUFhVZUkxUEl1YnBT?=
 =?utf-8?B?L0owTGRYcnBHUkViL004VFg5Q2hCbHFMeHI1aTZUaUJMZFdwRFJEWkVUeWxi?=
 =?utf-8?B?YzE0aE10Z3U1aHZlc0NpTkN2bktKbE1pSElleDgzRTJkRVhiaFlaRnNHZEdV?=
 =?utf-8?B?UExPb3E3YzNuYi84d2F5SC9FRDVBNjRuazVWQ3hGd3J5QjhMNE4rVnZGd3BX?=
 =?utf-8?B?VklqSlJHeXZhQzl6OVI5L1p1eFpzZnhxUnlOVzhzTWhmbmkzM3QyWjRGN2Vl?=
 =?utf-8?B?RG9zU3BEeWthZ3dMSUFURVovTjYxaDVFQmhmMC9yY3ZnaDdXaXYrRTBrSWhO?=
 =?utf-8?B?UXJlTjZ4WkoxWDNjbFIxZ0RHeVV6dXJ4aXpUMjkzUlA4RGY5M21nbHA2cXFQ?=
 =?utf-8?B?RWkxOXRRQ0phbkw3R25vbmY2ZG9KdjQ2YWR1cEVjdjFPaEFZam95Ujhlc1A3?=
 =?utf-8?B?YWxiRXVNOFY0WVVrSlgvSzNKaDRlajRiK1pHWks1OTJYLzVCNmtCWTA3SjFj?=
 =?utf-8?B?M1pQQ1dWNFBSZnp0TkVXSi9WZjc4M1I2cmR6Z1V6dkNLb21kTStjRDZqcEtN?=
 =?utf-8?B?S0hsZ2pWSk5hcGdBYzRGRHdTaW1IdXppY3BiQXNIZmVZSlZPbTZsN2lXTmhj?=
 =?utf-8?B?emxXTUc3b1ZwdzYyZFBLdlYwQVhKMG9EUXJvMlMwWVlKMnVHSlN5bFdpdFNu?=
 =?utf-8?B?ZzdGUTg5RlQ3aVZDNVIrUnNEam0wVnlSWU1RVE5wQ01KVHZ4dFJxaE1KOUFE?=
 =?utf-8?B?MmhiME42NG9yaFR1Um8xSHFKTlhyT3lBa2pWbWNGM1dUeG5SQkpoOHBvajZr?=
 =?utf-8?B?QjRydUYybFRwdEc3TVlxVi92ZjBUN1RFZTllK0F2UWQ3b0VZUFhBQ0dyZmJF?=
 =?utf-8?B?SUR2bGJhdVhiR0NGMkRtTzNsNGExaWRMNnJHb28vTkQyMUNyczVDdXNnQnRZ?=
 =?utf-8?B?WTZtWmt4VERWNjlOV3l5SFNaQjdDOXBWNWwzZFpHM2N1Vzd3cGxKcm1IYlNL?=
 =?utf-8?B?WlpvL3lTOC9GUDhCNXRuUHB3ZFFWcWZuYyt4YklHcG91V0FUSDUrYzZ1WHNi?=
 =?utf-8?B?UG5mTTVSUG9DaGt2UWh6aTBvemRnQW80elM3OHU0R2hUMGVtOTN0aWJZS2Vi?=
 =?utf-8?B?VGlsQ3cxc01ia1h6R3FvWVVPbFB5ZWZRRS9SbUluczFWSE9PTDlweVUxOFgx?=
 =?utf-8?B?UXBndjBZaVREOFVWY0FzeGdqeGxhZDhNaHFaVlVpSzVRTkQwM3owQTBYN3Fv?=
 =?utf-8?B?UVBtOHRPQWJaVkJlOUJMbjBuajVBL2VwV05ySTVMNmNHRDZJNml6amQ2R0tF?=
 =?utf-8?B?dHFDQkVzTDVtMDJjV2F3VmJJSjhCUHZPYkdTMWZkV3ZUdVh2bXU1QnI2K1FX?=
 =?utf-8?B?MGJSZGVrLzA3NnZaSmFsa2daSk1QV1I4dXFMMW1yYWFGVzc2cXhCWGdjL0Z2?=
 =?utf-8?B?QjdlV3VwSmg0SGJ4NE52YWRmZ00xZnlOQ0Z3ZEpoOEkwb1BqblRLWld2T29U?=
 =?utf-8?B?bHdqcjVzdUkxWkZ4bnMrdVo3YXRZQnRQWkI5R0k2SzdaUDJEd2h0bHdwbXFl?=
 =?utf-8?B?aUg4Q2pNUzNEa0dKbEx1L1hEOXE1TVpzWitDT3NKK0MyVzJ0UGJveWtRQVhG?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DjnPy14hlVjLM3xwp//emhKEqJJX/MZc2WYDEEzclsVIj9OvX3vMBw41Nni7Z79JzTlgYbugkS2cy7Y0wtUHXK7N3CP2yhqxkjjCQt/qbx0FmVzevIYEnrBJbnne6GEKDXp4eIHmNcgVaVpFKckvgPdHQlmOPTWuz+nZ4N80YNsPLtHQG2KF2+96tK01rmjwfEYl0VoXA50e6B8a8vB6ZZlmz7BjUVs+3+CLN+78wGpDO4ZIzfPnOWAsRoMR1AQeWK4/TbCz80KT1a71f5dI9SX7OzhE8jXY9mZoYnm6efuUXWdVsDg4KP5+E3+p+0Dp0ZwM2uZag44CHtsgXajoW1C93QTZib/h712illC9K6qADKW3zI9Sg0iVGfEaIQ3vyVlr07KB91a2a/C8nqCN26+10mus5pcpUWkxqXs8ZPhIY7+fZlzQ2pFHYPoenLulOBXh2pGczFO/54ZcJD9nmA9kGEGZz/CvNMHzluFuCcKfYC+oDp5FRmXgeMsQ8impjOC6WFHTEpZw6t8UAvLmsC807dtvCnVNoVWgxlp4vHOeFp0yhcAdEJHh7EY0m639Z4yDR3ZR0gr2czkUPQzkNGxrpSft578tJeGrH3yqy3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278c94be-f0ef-45e4-3c28-08dd57dd239d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:49:05.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVQtfcQZj2Y6pIfESngtxdPVnNssTnMW4cTQk9X+owDQzkAWec5GjKgoAIN/YR++EUOMKmtsBRthfwHVD82n05WaxviNcDDnAZP+x7el4bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280070
X-Proofpoint-GUID: a-ElMsL43Y_KFaaPuNZRUU1iOMBUMQrb
X-Proofpoint-ORIG-GUID: a-ElMsL43Y_KFaaPuNZRUU1iOMBUMQrb

+cc Linus

OK since Andrew seems caught up with other things, let's go ahead and propose
the entire thing to make life easy.

Could you send a v15 with any fixes (don't think any are necessary now?) and
add a patch to add this to MAINTAINERS in the alphabetical location:

MEMORY MANAGEMENT [RUST]
M:	Alice Ryhl <aliceryhl@google.com>
R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
R:	Liam R. Howlett <Liam.Howlett@oracle.com>
L:	linux-mm@kvack.org
L:	rust-for-linux@vger.kernel.org
S:	Maintained
W:	http://www.linux-mm.org
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
S:	Maintained
F:	rust/helpers/mm.c
F:	rust/kernel/mm.rs
F:	rust/kernel/mm/

With every patch reviewed from both mm and rust side, from my point of view
there is to me absolutely _no reason_ this should not be taken, though of
course ultimately it's up to Andrew/Linus.

At any rate, hopefully this can help get us moving again here :)

Very keen to get this landed!

Cheers, Lorenzo

On Fri, Feb 14, 2025 at 12:20:18PM +0000, Lorenzo Stoakes wrote:
> On Fri, Feb 14, 2025 at 12:56:29PM +0100, Alice Ryhl wrote:
> > On Thu, Feb 13, 2025 at 8:46 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250213 07:16]:
> > > > On Thu, Feb 13, 2025 at 01:03:04PM +0100, Miguel Ojeda wrote:
> > > > > On Thu, Feb 13, 2025 at 12:50 PM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > Right, I don't mean the rust subsystem, I mean designated rust
> > > > > > maintainers. The point being that this won't add workload to Andrew, nor
> > > > > > require him nor other mm C people to understand rust.
> > > > >
> > > > > Sounds good, and apologies for being pedantic, but given the recent
> > > > > discussions, I thought I should clarify just in case others read it
> > > > > differently.
> > > > >
> > > > > In the same vein, one more quick thing (that you probably didn't mean
> > > > > in this way, but still, I think it is better I add the note, sorry): I
> > > > > don't think it is true that it will not add workload to Andrew or MM
> > > > > in general. It always adds some workload, even if the maintainers
> > > > > don't handle the patches at all, since they may still need to perform
> > > > > a small change in something Rust related due to another change they
> > > > > need to do, or perhaps at least contact the Rust sub-maintainer to do
> > > > > it for them, etc.
> > > > >
> > > > >     https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rust-wouldnt-be-extra-work-for-maintainers
> > > > >
> > > > > Cheers,
> > > > > Miguel
> > > >
> > > > Ack, for the record I'm happy to help with any work that might come up.
> > >
> > > Ack, here too.
> > >
> > > Without the drama, I'm not sure how we'd feel so alive :P
> > >
> > > Can I be added to whatever list so I can be Cc'ed on the changes on your
> > > side?
> >
> > I'm happy to format the entries whichever way you all prefer, but for
> > example it could be a new MAINTAINERS entry below MEMORY MAPPING along
> > these lines:
> >
> > MEMORY MANAGEMENT/MAPPING [RUST]
>
> I think a general:
>
> MEMORY MANAGEMENT [RUST]
>
> works better here as it ought to (at least for the time being) cover off all
> rust mm stuff.
>
> > M: Alice Ryhl <aliceryhl@google.com>
>
> I wonder if we should have Andrew as a co-maintainer here so people also
> send to Andrew also for merge? (and obviously as the mm maintainer he may
> have commentary).
>
> > R: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Am happy to be a reviewer this is fine!
>
> > R: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> I am sure Liam is also, but of course he can comment himself :)
>
> > L: linux-mm@kvack.org
> > L: rust-for-linux@vger.kernel.org
> > S: Maintained
>
> Probably need these here too if Andrew is taking in his tree:
>
> W:	http://www.linux-mm.org
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> > F: rust/helpers/mm.c
> > F: rust/kernel/mm.rs
> > F: rust/kernel/mm/
> >
> > Alice
>
> But in general with tweaks I am happy for this to be added to MAINTAINERS
> _personally_, am I but a minor figure however, it is up to Andrew
> ultimately :)

