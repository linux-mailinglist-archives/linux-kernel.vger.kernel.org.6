Return-Path: <linux-kernel+bounces-515275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF8A362C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F6E18939DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7082673B3;
	Fri, 14 Feb 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DNzea448";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VTEhLJHd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FC70831;
	Fri, 14 Feb 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549446; cv=fail; b=b+s2zcPFqNHH/I8zf7hMFl3PM2lLzsDA1sX3JE64DDzzDzbyd2cpdBIToTdPCT8SeHVybasXzofJim+qrGzffsfAFqD+8FRMwymuzTqrnZbcJVcv7y3t9oBvq//ruj9Xg6FG+cP+/12erqI1WeQjJYPYGjn4DAFuvjc0WOWfasg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549446; c=relaxed/simple;
	bh=49EJoQHONqu1o9rAnlBGLi+8XHsvpds11OI+x3ORfxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UPx1QcbbAmLLsPpRZHn2eq5FC643m7igjYE7Jn71Zr7w1bMa6OXyyMYW2IQQA7b0VcMLHXyzowVBvU+qB07xj+KTSvttZ5jS6IsW3FHTeTWjbsaIvROL/sNwstIqOcM7T+GYOxgtyyANFDdrtgF6woxGYbV+7rwUFUL/SqavsZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DNzea448; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VTEhLJHd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EG2aH7002936;
	Fri, 14 Feb 2025 16:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dUU0a31ruD8VyKPPZ8MTHc8uO/csTG5bd79DIfjLzQ0=; b=
	DNzea448VDE6ik7Rwxo4VEMoceeq3F2TouspSXD7Sb8QY8T7rrv2ixaFtGmxUCJ9
	aqnPPzh2n7+N1qUotTmQl+Z2WakqaNcvkCuPsQQcEGxUisk9Esf5itzBRP22K0ej
	4ItuNPKi/oUq4JHk5e/IkjIC4ZlghCBKu+w5zyrVcNPuYUC5DVSlcvfuLPuN25HO
	OOYGPdkn2uD3kzoDjST7bZPBlB64VkajDCq8yHFBt7mJbwHcpNpWDo8Z403Gssl0
	8spvxuypjagTwF3Z+gj5qnixwOKCaGJXALCtf8vI90z7hDv/VqjMqNucSfm8YLPr
	WRAO8NHX0sG2wsO/62nAXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyv1n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 16:10:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFph4T014118;
	Fri, 14 Feb 2025 16:10:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqkwm98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 16:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwDn5nAg2s5h3W47KOyhPpW8GbZYfqFADat6ppOFSZIY6CfMwX+kDMeZ4NZXAqJPIKG5hzWVqfZHVsvgynT55ruddNFkSR8fWHzf9qRxT2zTyZLBa63grfbhSFkjX0W/eujQ+Gj2dn3fzCyhewJGDaiFYgQIvolUdKhnu2d/CcSeKxIp3HLkfHFW8qECl2NwbIudtAlbB3ck84EQrkbSu5BAhdfH+FqIihTDQnRwflaeKDOCmyATGtKh0vyQrSQK9Ki4lD7BPbxg8IMTgz/tKHLNQBvXs2r6OIi5npE+/LX9ZLLrHntioKU74nT4wu0oZ1tu+YsoKUKheXBWAh4TNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUU0a31ruD8VyKPPZ8MTHc8uO/csTG5bd79DIfjLzQ0=;
 b=vtssy50oeB/AOSikk5DGNgv9cfMHOBtdyuePh+C4h+oPBucxfM2am5eTvzw3T7UN6pwhA7hs/o4Km02rR+LVpcXGa6x583hverCEy1yYzv/O7+kvWYt8wjnV7wM3v1H9vfnI43NgXpZPofc+lpoaZxhCkurCY2b/TKf773JlystaUhxp1MLMutHvSZ7BXYHdGVEiLw4DhJH0gfr66vCrpBsgqZ/HxMHLDpFCs6enipibCL4iOY7UU5A3+732/hTR055rkbU6rsAfDRwI5vYAP/ZASmbrvreOcUlTjku7+Jou2HJnix+K4DqPQdnvuUIV7X8ZGbD8B0JvhjdwczQKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUU0a31ruD8VyKPPZ8MTHc8uO/csTG5bd79DIfjLzQ0=;
 b=VTEhLJHdrfY4E/bSUPsIJsXWXoiphbLGeKPRUopX910vF98sb/SC3hxRHtkve4uRuQejox37tRrzNcqfz73NExBWnj4/2VfpowC4OjaVGfDSNIwmNMFswfQbF+LgIZgFqjFn5YSsLPXfY/o7X6lBsTBkZEVLUGfoiO4sOc5kTvk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 16:09:59 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 16:09:59 +0000
Date: Fri, 14 Feb 2025 11:09:55 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
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
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <2iypqaa3orklplwec4k5n4nuuov3gajtkiv2nt2ce2s2b4e7gd@7y6cmwrwr5te>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Balbir Singh <balbirs@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0419.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c0f8a3-2e12-452d-491e-08dd4d1207bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWphMDZyTm8zb3ZQZWVtVnFWY2V2amx0RDNNQXZib1Y3UnkrT0FVazgrWnFM?=
 =?utf-8?B?UWUxcCtENit1T0UyaUxkVzdqZFhYRy9ZMFhoTno2UVZqb2E3eHFiMDVHQngz?=
 =?utf-8?B?SXVubllFYnBTOXBMaGNyQkJOQmFUY2pFRktnRDIzUHFjMXRyUTV6aTV0dTlQ?=
 =?utf-8?B?ZVJUUWVFREUrTFB0UC9MbjZiRW5HbE1DSHc5cExSczIyaHZRSnhVQXI3ZEVo?=
 =?utf-8?B?QklMZFF2U2YzWUJQRFczTzlWS2xXMnpuMXE2RlNlOVJiMlF2ZERkcnRsTlIy?=
 =?utf-8?B?N2pEWm1DS1o3bjI1ckI0QnFYQnJSZDA0cFdsUDM4WVdlVEhkVHlJdHp3UENs?=
 =?utf-8?B?RXN1MEp3cFFQRHdlZkpQS29uQ0dLN0NLTUlITUw4bjI2K3N1K2NxMEoraGh6?=
 =?utf-8?B?dzZKbkVkUU5QR0E0bjAxSS85aWd2eC9TYU5HTFpYc1lDL0dadXJMQ0h2R0ZM?=
 =?utf-8?B?MmM3aW5LbEtpWmtiUWFONnlHWkV3bU53Vnh2RHhwQ3hTY2UxU0ZnQlFSS1h0?=
 =?utf-8?B?TjhEdFBzNFk1ZDJCRk9pTFBuYVRwNmVja0tmbkZsOGZkZ1IzaTV5bjVtbkh6?=
 =?utf-8?B?MGNwTVpjeW9PZFkvcENjdGhOcDJMRDFmMU9BK1h6dU9PRDB1NFpoYllrcmsv?=
 =?utf-8?B?QVlxQWpnK1VLRFZKNm9GMVU5SVZyY1VFVW5LOUc0Y2VIL3QzNytOUkVobS9P?=
 =?utf-8?B?YnZGMzRUV1Z6V1YydG9GdVBlQVFtVnlFZlY3dG5HckFFKzBoUnRZckl2dmVL?=
 =?utf-8?B?cXZJaDhkT1ExN1YwZE4rYTRrR0d2bm1lOVU4T0ZocmllQnNpWkk4dXg3RmRl?=
 =?utf-8?B?elRMY01lYUhvOGN6cEJPV2V1VDBrZ3lPZXpzaEpvUmNKVXgwU0FiYW9WWThY?=
 =?utf-8?B?a3VHYU9zNm83ZWdxWkhrK3QvZ2xqcExGa3BqdStmQXVGSEpTN1dkVkRKeUhL?=
 =?utf-8?B?dnQ4L0xEOXFIM1F1bnZPakM0RDdGd3hxN0xSRWRtUk15THAwbURSMmNXdlB3?=
 =?utf-8?B?djVvMHBuMzR2RGVkWDRXZFRRaWhWRHhyOWorSzJRUDZuZ0VVUW9GM2k3RUUz?=
 =?utf-8?B?U0MzVGZJS1hxM2pqUDVKeDJjUnRDcWZFcnBmVzdoWTBValJRLytucWN2cG95?=
 =?utf-8?B?RXVhZFBLYlJ4ZXBrcENMMXRma2RjbGdzeit0VXJSdjl6bXpReWtjRG45dkRt?=
 =?utf-8?B?aWZHbi9jRlc2d1kyVTJzRE52akhkYVBjUUNBakdHZ0xCTXVIMkZScERrVnV2?=
 =?utf-8?B?Ynh5SlVuWUZUTW9BNWE1aURITDdQQWhzdnN1bmhzS09JNzRQV0pJQXk4RXlJ?=
 =?utf-8?B?eVRzR05ZdUwzZHlUOEtIcDlmUzVlRjlYbW5YR3BOMG5tdDhtZXdXdHdUMHU1?=
 =?utf-8?B?V0pXaVMxTzFFanQvellraXhBYlkvZTQzb1J2b3NJZEVnUG8xaFk2eFV5V1lz?=
 =?utf-8?B?SWNhcHk0Q2VnZ0xaZytsWXpGT3hiNXpWN3pHdm9HSm84STVCLzFpUDZhQ3Bv?=
 =?utf-8?B?ZzhTVklyS2Frd1NiSTFyMlU1QytMOTdEQkY0OUt0QW1lZVNwdXVhRjBaOWw4?=
 =?utf-8?B?N2F6UWx5T1I5U2M5UHdiTGkyeVdCejZlSTlkbGFyczVHWXRnTHNiUzBjVWZK?=
 =?utf-8?B?a2tJejMrSlBOUGhxNGxIYWhrRnBCMnlFZnJ2UUNpT2kwa0l1Z2J1MEFNdDRF?=
 =?utf-8?B?L1Fma09GU2xvNnRUbkRVWGo5ZTRZMXpWd1hpRTQrZW92TCtqNC9QMFhRKzBt?=
 =?utf-8?Q?/DsMB7PY9STBWb7o+ZeKbMCsEmsiLBN7DepWP7l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3dDWktoeTVpc0F2ckEvR2pBNFBKcFdzbVRJTjlpWTBmUDhZcHY2TXljVFJP?=
 =?utf-8?B?ZWNKSEtvcHpSRjAxL3FCUFlyMDQzcFNjd2JWT21zK3ViVXVLOVlUWks4RlpK?=
 =?utf-8?B?Z0d1N2RiVlc5TnNySmZ6VnFkQk5yK0hWVWhwWHNsa3IwRFZNNlV0MXZEYm9t?=
 =?utf-8?B?a3RMdzJYV2hoRG5VeGt0ZzlyZ2tYRG50NlFQWnJwREo2NlhtRUwwQng0SWIw?=
 =?utf-8?B?bjVuNEQ2R0FwTnhKRkdCY1QzVzQ5WGxGWVJsMWtOMWZ3dkV5cUxGci9xL0NY?=
 =?utf-8?B?VnpqS3dlMGRkbzZ0ZE5JRW1LMkFNcm9Udjh3V1lTdXlqMmtmNWs3SXpEdEIv?=
 =?utf-8?B?UVM3NXpLYVRuMlA0MnoxMHVDdUsxdXNuUGROb1FEVUZxaDNVUVNpSFd0R0Uy?=
 =?utf-8?B?ekVLRXVDdDZKVXZSZFVJSGEzWVBIRU1SQmhnVFN4U2s1b1F1M1cyclg0WVlS?=
 =?utf-8?B?N2dERkdoMldqeU01dFU4OG1CY0dUejRReWdmek5DcWNlTUZEbjhoWUdsUDhj?=
 =?utf-8?B?NFB3dEtHL0k1NEdlL1kyeUxtTGVSakFkeU5pYVJYbHBDSG1pRzNpYTFiUGkx?=
 =?utf-8?B?cHcrZzZkc0prNzg4OXcrbFBzYmRDNUV6U1g0QlFpcTgyc255cktJUGRvRlhu?=
 =?utf-8?B?V1VtdHU1Zmc2SHZ6MlR2UnlRQU1tZndOejhMNTl4UG8zdjVzU0xsTWRzZGlK?=
 =?utf-8?B?emF5NkdqQUoyZVZOb3B3Wk9oN2YxOHEyTDlKdVdtVml0YjM3NGRlNlBYTWVV?=
 =?utf-8?B?T29UYzZSWUJxbnJDUkRJcmNaVVV1UkEydFVtKzFldnFSOGpHeEtDQ0ZyNU9s?=
 =?utf-8?B?Ly8ycnFTRmhZRlJxNzNRWGpzZjRnY1V3U3U0Qnord0VleDcvN0pYeWJXMVU0?=
 =?utf-8?B?cXVrQVNqVUs2TUpUa1FZS0orTEdiZ0YxNmVKNWUyb1VmYUZzajV5ZStkeGFx?=
 =?utf-8?B?L0NWZExUWlZWeTk2SW1Gajk5UW1YcWttNkNCeXk0SEFZVytNOEhKdk5iUlJR?=
 =?utf-8?B?SkxEYUhJVDU1UElrU2hBMzhWUkVzZzVJMUN0SjNJa0pRbnNmbXlkdTNXeFZG?=
 =?utf-8?B?ZVdhU1MxRFN2YTZnL0hXRmVHUGdBV21ZVHVVTElja201OENCT1M5QzVhVjh0?=
 =?utf-8?B?N2txcFMrMGRzNWFTaVpwejQ3UlZ4QTZmS0djdHc0djFGY0FrNXRjamxOZnJ4?=
 =?utf-8?B?WFlqazlSSlg1VWJIWStNSnhkUzdCRy9uZnN4MGJaVW9YRU0reHBJUDk1N1Vt?=
 =?utf-8?B?T1oyNFVCU2RaYnhWZEVJVlhhQnlXVHViY1Fpblh6S3Q5TEE5VUhvTmZCc280?=
 =?utf-8?B?enAzakgyRjU4UFVodHhWNkZxNi9rdlgzMHRjZ1k1Q2RCYTBOQU43dUt4NktR?=
 =?utf-8?B?NUxsYmV6aHlreldzT1Y4ekR4eUhQNHBheG9Nd3RYbzkyaXk2OS9qenl3WkFk?=
 =?utf-8?B?TGJ3eSs0ZUt2QkFKVWxzZWpaQTZpQ2phMUUybjVYZk9HcmFXTFpHTXRHaHZx?=
 =?utf-8?B?aktEUlFxSWozY01VL1hIMTVuQ0ZaNDZ0Ky9sUjRZQzJReU1xSDlaejJzdWRF?=
 =?utf-8?B?UytQbGgwU3dSQnR3dVoyeXN1b21VcW14OGxKMERya1FhOEpKL2JOSFBQSCtL?=
 =?utf-8?B?TVJuSVZJdXo4a0ZHWnBwNEVHZkpGZVNkcmdsVFdpUDRaaDNqUFA5MmF3V2FR?=
 =?utf-8?B?WnFUTEdPUFpMT2tOTEVPOW5JcVh0ejF5ZTd2SkJQOGVpc0svejdoOHBHazkr?=
 =?utf-8?B?S28zNXdoMklpK1BkNmE0SzYvTTlsMmhQNVVuQUR2VUZ5SkpyVWprb2tRRm56?=
 =?utf-8?B?R3pBaWN0eUd1ME5JbThSUFZxSjc3RlRwSm5sZlRISlR2eUo5U2krTkRseTRs?=
 =?utf-8?B?SGU5VDNUQXRVWDJxaE8rQ2NwZDkxMFVNaS9sZk1LV0wrU0ZjRFVURlF3aHg0?=
 =?utf-8?B?TjNiM243NHRZWWxCT1IrcUxRdUNMb0ZNdWE3VjcydSt2a1lObVpFUVJ1T2RO?=
 =?utf-8?B?UGZVeUdzU1pLWnY1QXo5ZTI4NDhqME9nTEdsVVZKUmxFVFNOb2VpbXQ0SU83?=
 =?utf-8?B?TGY2M2hmTUlYUFQyY3FMMGNmUFJpTldLaG9FaUxUMWNYMmtZRjZmQlB0ZVFk?=
 =?utf-8?Q?DlITBUi5AKIW2zrsXkh2kNfWD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b6iEcgwFmMZqTmAg27e3OPkvHDzPPEtPDkHkXrTTwdVDu13Nn1vgc+V7ce3KeCR1R2e0fyvEitimjYDg6+mwJrzwL86xMstFztj+jcD9zGZjkvwQdcqF/wmn43Wv9gW/INqr1Ur+6zc5y0P2K0A2vtv1jOnN7ERXNcg9bX7nRgiEeCCvY7CbldMwlPN6RCpCGJFNq0VtME7Ujwc0sSffpsecIxVprcfK2rjh9NFbpGBq36CcBx2APdY+p7gEvm1BorlOD4adZvA0uL3wgwThKSlQ358MiSeju0V4EFDddEV+A5+HzjfEXpobt6L6uVhR8ZxVce6UnNgDoJSKh35uWz/30IdtdENtJxo14Jfd74t6anQevsPj0xlRQxU10ag9ipSqNdl4IYWvhiIugLGrdT5y8m7/yYnkEZPWz/laRlgK0sCCqZUcC9+GIHd14V7/hscDT7iYomNNvV/Gh2mDRQFxtHLPAICX1TqGV2WBiz9X6ICCgSYXCiNdiAL665fbvnCoLNlSTbFxweh72ExBG/DndDxHckWRFGskh9fx2YK9CMubrTiaWcmF/1H9NfPFDh9LqQ44vEhQm7ahIVnCmG5LHdlD5FvrY2tIhOERLf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c0f8a3-2e12-452d-491e-08dd4d1207bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:09:59.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSodTTnvnzm2fYXopXYdpKn0YPRWVIyyUg7Iq6YGBi7we9wlz1v9kd8fdY3Vadm3acDX8KU2jfDAQff8EhYkRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140114
X-Proofpoint-ORIG-GUID: hsnZy_cMRXk_0pbvBCOMTuZ3Q_HzYGwp
X-Proofpoint-GUID: hsnZy_cMRXk_0pbvBCOMTuZ3Q_HzYGwp

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250214 07:20]:
> On Fri, Feb 14, 2025 at 12:56:29PM +0100, Alice Ryhl wrote:
> > On Thu, Feb 13, 2025 at 8:46=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250213 07:16]:
> > > > On Thu, Feb 13, 2025 at 01:03:04PM +0100, Miguel Ojeda wrote:
> > > > > On Thu, Feb 13, 2025 at 12:50=E2=80=AFPM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > Right, I don't mean the rust subsystem, I mean designated rust
> > > > > > maintainers. The point being that this won't add workload to An=
drew, nor
> > > > > > require him nor other mm C people to understand rust.
> > > > >
> > > > > Sounds good, and apologies for being pedantic, but given the rece=
nt
> > > > > discussions, I thought I should clarify just in case others read =
it
> > > > > differently.
> > > > >
> > > > > In the same vein, one more quick thing (that you probably didn't =
mean
> > > > > in this way, but still, I think it is better I add the note, sorr=
y): I
> > > > > don't think it is true that it will not add workload to Andrew or=
 MM
> > > > > in general. It always adds some workload, even if the maintainers
> > > > > don't handle the patches at all, since they may still need to per=
form
> > > > > a small change in something Rust related due to another change th=
ey
> > > > > need to do, or perhaps at least contact the Rust sub-maintainer t=
o do
> > > > > it for them, etc.
> > > > >
> > > > >     https://rust-for-linux.com/rust-kernel-policy#didnt-you-promi=
se-rust-wouldnt-be-extra-work-for-maintainers
> > > > >
> > > > > Cheers,
> > > > > Miguel
> > > >
> > > > Ack, for the record I'm happy to help with any work that might come=
 up.
> > >
> > > Ack, here too.
> > >
> > > Without the drama, I'm not sure how we'd feel so alive :P
> > >
> > > Can I be added to whatever list so I can be Cc'ed on the changes on y=
our
> > > side?
> >
> > I'm happy to format the entries whichever way you all prefer, but for
> > example it could be a new MAINTAINERS entry below MEMORY MAPPING along
> > these lines:
> >
> > MEMORY MANAGEMENT/MAPPING [RUST]
>=20
> I think a general:
>=20
> MEMORY MANAGEMENT [RUST]
>=20
> works better here as it ought to (at least for the time being) cover off =
all
> rust mm stuff.
>=20
> > M: Alice Ryhl <aliceryhl@google.com>
>=20
> I wonder if we should have Andrew as a co-maintainer here so people also
> send to Andrew also for merge? (and obviously as the mm maintainer he may
> have commentary).

Indeed, FWIU each subsystem is doing something different with some
taking no responsibility/effort while others are involved.

The mm space has been a very good citizen in both methods (merging with
cover letters, code quality, etc) and in code (always on top of syzbot,
bugs).  I think it is important to strive to keep this functioning.

This will become more important once we have more than just wrappers,
but I think we should talk about what this will need to look like before
it actually happens.  ie: unstable rust branch tracking unstable c
branch with build emails, etc?  Early days yet, though.

>=20
> > R: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>=20
> Am happy to be a reviewer this is fine!
>=20
> > R: Liam R. Howlett <Liam.Howlett@oracle.com>
>=20
> I am sure Liam is also, but of course he can comment himself :)

Yes, please add me here.

>=20
> > L: linux-mm@kvack.org
> > L: rust-for-linux@vger.kernel.org
> > S: Maintained
>=20
> Probably need these here too if Andrew is taking in his tree:
>=20
> W:	http://www.linux-mm.org
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

This is a good question.

I am unclear how the branching/merging happens.  When do we need to
start (at lest) building the rust side?  We've been doing a lot of work
in the modularization/interface level to try and integrate more isolated
testing, as well as the locking changes.

Do you have build bots that will tell us when things are broken?

...

Thanks,
Liam

