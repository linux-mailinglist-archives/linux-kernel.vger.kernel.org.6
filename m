Return-Path: <linux-kernel+bounces-416959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884809D4CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4913C28119D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD081D414B;
	Thu, 21 Nov 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDvcnLmr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wRmqso7O"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238A1D5158;
	Thu, 21 Nov 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192667; cv=fail; b=qULV5JCXcKpM8mXi7J60DxlyPPDRb4U1x9PP4mEr99JOVMzZwh32gtJtxYtboTgE4bmpkXyP5Cpz7jbaQXaINrhvZUSRKYuKCFXjrBQyJnE6wkERZf5y9IjDiDYx56AadOqMEkBXfwfrEw2i0EJW934LNq74yMfLqp5eW3o/TbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192667; c=relaxed/simple;
	bh=/7kv4XsW+Ghs2rRiYvS88C8NxcBzMI2uOehFNoeSKjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhM+DuXWwti5qQ0Pi32fSIP8pwm+HHkC7faiDDnCGzmX1onv06XJng53CFaGvP47PE2vtuJMNXqJfeH7YCVR7twF6Ti+GjUA5tYjx/JrRewiHSu+o1ItEiAVOi3T/plJgafTD1aalHUwYS7VtSPkKRsS/bOCTQ+KIPFNVDhaw/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDvcnLmr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wRmqso7O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7Ffwx015908;
	Thu, 21 Nov 2024 12:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PtZNCwXHyqLBigf6OR7x6Yky9a0P6rJa1lwwZ/ve11c=; b=
	NDvcnLmrWy4daY4ufCQy2ibrFsVP68WVr29K8orWNV4EWsAnVoxEJ8kpdZ1ef813
	cw5hwVT65tHnAqQuXrsPJ2mHc7Xak2t+P6GQnhgswtyjso9ZH7LsJ6siAh0ml8PI
	JkGy1QjIpf4OQzzhGvf9vbKEJfjYme6vH2dYEfVxQYqaLx+63wC424HPvEwo4VyC
	MNyFVQpB7UF4cIIYDGVTviSs2cd/DSXabtSj5CoSkc2d+qI0LS37KhfQnlNWz5ti
	4U6Fq3c2IEWv3MOvN1Ca6WcgWTWgXa5QEtGwmP6TfIZcdfSJ4ORdzmdUXrTv/HzQ
	LfhF7ZmyPIvShFggtyFySA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkec1ngw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:37:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALBrfPS037319;
	Thu, 21 Nov 2024 12:37:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubn1dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoCcrJiLSRAae+7evUUzcDWUFEf3+R/EzzUi9GVkhj1DVasL6bBPU067s6alCyXPJDI1j5xIQDe+hzsBoAfjiECi2m7gg1majFDK2oQWsVnUH3fzOC6pVp16F21LJ0iLxC6fpKsgUx/6LWLijoG88ZtQFpYN/lFiU17yYxlhLP112Y7Skqlf09mcMxP//b2YQNhchb8yrWoTRmWxLEc8pMqOs5Qc2X2z4W1cLmJXmjL/Xyqom8RdKuo4tTD/Napmyy6VJXjhHyEiUU4E27jF6s30k8dMJSzJRJWpHdkARsc7EWkK0tpMQAQibqFc+DGzvm+LO1UA9PM+6CpzZI1nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtZNCwXHyqLBigf6OR7x6Yky9a0P6rJa1lwwZ/ve11c=;
 b=j4lKXeca7F7+uU9t9EkaYMqykAM5zzxuBKpuaWeyoMBxCed1y4ZTP5z0UCfQ8YKf+OjCbeZRtRcmgkPlAHK1/Q3bNDU2f726yx6IGnt759ANJMbY8/LUN2XrBqr86G32776YfZf10rDYuyvz7Ph+bApetCncJ/AqCR3dnW3CwLbl4Ix9UhltHBVSWgXwj/4kzPABElWhtM2y70kBjBm0a2JLl2xywDpM9os5sfbTzAEH5D2yXgrVmqXjXxkPO+N5x0+RFW4pOi9v/qaT7elgP/AbwzyIgCCga9Al4euS5eLANNY6rlvKINVKXZYqyB3eT1gQJ4YAGScOWDsgKpUOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtZNCwXHyqLBigf6OR7x6Yky9a0P6rJa1lwwZ/ve11c=;
 b=wRmqso7OK07JnvibDM0hVYb5F4A8oJSy0Bz1j0XfadUF3VnaEd6ZNJgEAK+5DFXsiR4Xca9kRvn43dYYsPxg7VmjaFuMLAKmtbuH9b+bnACjfhDM17V76L7fiE+ZxBqC2ZN5LwjVtQmE5kfxBFWEiU79R2SHqcgB59ioJU6RAfQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6888.namprd10.prod.outlook.com (2603:10b6:8:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 12:37:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 12:37:11 +0000
Date: Thu, 21 Nov 2024 12:37:08 +0000
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
Subject: Re: [PATCH v8 1/7] mm: rust: add abstraction for struct mm_struct
Message-ID: <5a06280b-955d-41e1-8ab5-0b766ec7d7ac@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-1-eb31425da66b@google.com>
 <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
 <CAH5fLgi5xbL=L-Mz_u64sA1QGLtxOgEvG_y4aJV2_mfy4iCxyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi5xbL=L-Mz_u64sA1QGLtxOgEvG_y4aJV2_mfy4iCxyg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dcbaff-1bce-4f8d-956e-08dd0a29382a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXgvWTloU2hpMlduMmVQWHV4R2JseTZWYTVRZkl1QUZHYjJUamRTYjBrQ0ZR?=
 =?utf-8?B?MmFlR2pJWXVZMHZqbCtFWTM5M3AvczNVQUJnRjJEa2x1bGMyYllZSDJDczJM?=
 =?utf-8?B?VXpxWm1aR016cHRRMmowU2liamROYVVKd3NVUUV3NUJkVE41bjV3K1lHa1R4?=
 =?utf-8?B?M05tTERSK1FHK1ZyaDltR3FDN3JCc3VXcWFSOHBZVmhQMTA1cFZaWmNYMmVB?=
 =?utf-8?B?c0U3R2hhejBNNFQzdHhCRUsySGNJWFBsZFlJME95RTFBRW42VUhGN1pjWm9Z?=
 =?utf-8?B?L1FKOUltRE5ZVzJYcXp0SFBZMWVjcWcxcmM0SkkwWjgyQTIwY2RidEJHSVBv?=
 =?utf-8?B?bE9LNXBsejRRRHpFd1crZnFDa1NlQktjSEw5aDNtTWJjUEdHM2VVYTBVeFpk?=
 =?utf-8?B?SlF1NWZYMzQvMXB3K2VOVXdmZ2NPK3FXbWJ3Rlc0WTJTeW5KYlNGUkFRL29E?=
 =?utf-8?B?ZmErZU5tZTBndHBSNnVNdzY3RVhqaVcrdVdzMEp5dktKR2UwZDRIa3dKeEw2?=
 =?utf-8?B?VVJvWHNVRjRJU1RvUUFaeHduSDNmQ05qZy9tdDlIditENE5HUFE3VWsraFRo?=
 =?utf-8?B?OUZLeTkxSjd0ZjVZMGdBWW1adVVWb0d1TCtQTHNlUDFUQ3ZtWUFNNWtnM0kw?=
 =?utf-8?B?bWxkdjVpdVQrUndXQjJYazBIdndwcDVRRWRZSG1MeTJDL2RJS2xhQ2VjNitv?=
 =?utf-8?B?TkxZb01kSllZYm9IckEyK0V6Z3hKUmZocCtVVlZvcmtrUFJ6czJDYzFLd1kx?=
 =?utf-8?B?R0hubDEyaVRQeXcwbVpCbkQwTm5TdjVhN05sbnZTajZlWjI5Um1rQysraE84?=
 =?utf-8?B?RHBrVDM0ajRjSDArWEZEbWExQXhhWHd1WlgrbmowaUlRSllZNElDVGk2QVJr?=
 =?utf-8?B?VTJMTWtyN3NYcFZJN0pBWFVkS2N3bTdYWjZVdTRQY0RhYWxpaWozdGtob2dZ?=
 =?utf-8?B?R01PNytqZE5kVWs3NE9lOFFSam9KOWFjdVdpUWw3RlgvSmRPN0lIdFZJc3Fz?=
 =?utf-8?B?alpKNXhUMVN2cUVhWlNaUEhyWUZNdjVBamNxcFN2VmFsOGpZaWlLdGt6UTJI?=
 =?utf-8?B?WEFKN0pwdi9jTUhVcGZ4eDJOeVpGWUVuaC81dm1ZT0RRdEZ4dGFuU3NuS2RP?=
 =?utf-8?B?VFBFSGhvRSt5VDFyYlM2RTVvUDZMd3VFRUFkdktmemUvQXU1WXdZWkZqVFBp?=
 =?utf-8?B?Tm9LdFpnOWtuM09jVnpiSEdjb2p3ZlpKdElDSnM3bnVlRW83STZNRWZEYzAw?=
 =?utf-8?B?QkdCSWtuTUg0OUhxMFhYek5aN2w1eHZvQXhSOWxlMi8zRi9wVnc3UHJXbWZ3?=
 =?utf-8?B?ay9td09EMjVSQjBCRnZTa3B0K2lwenhpVEdDZUsydVdlRXoyT0tySnp1c0Fq?=
 =?utf-8?B?czNKTzFjYzdvRFdUY2s4RjFjTmNxMjhoQWNTY3RsbHNOaVhscVk1Y3VVZEd1?=
 =?utf-8?B?SElYdDlDZmRIUXJLcFl6MTA4ckhUeDZSMEtqOFo2SWNDUzBGbUhJNlhZRmdC?=
 =?utf-8?B?R0ZBTGZvZUFUTFp6bDZ4WDBwTy9ZVkJSazltYi90aERpQjhhVUlHZzUvdjRU?=
 =?utf-8?B?QmdpM1ZjRytlSURlRk5aZmdMbmM2eVozSkVaZ3RMam1pa0VHNWhMUWo1dy9q?=
 =?utf-8?B?bzk5UTRyVDloSC9HLzNqYlBTK2cwc3FTYkdjc0FiNEJtYzdpaFlrSnFqTzhh?=
 =?utf-8?B?V243RmlWOWRJRDliSUFCNzVrd1RxQTJ1cHMzREY3OXAxeHhDZnNDWlhBdGFo?=
 =?utf-8?Q?0qy3YnS2IFtrTqz0oo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUxTR1pVanhaRGkzVWhkbkdVK3Bzd3U1bWMraktqbGdMLy83UUdxamVPSjEr?=
 =?utf-8?B?ZDZXTXVrWlNUMTFvTVA4cm15dGxrdGV2SmlQL0ljTWNZSE5NY0YvRUdjaVRn?=
 =?utf-8?B?alRVUU50UUxza3I1UTd6SThNelVzeEdsREJDY1l3R2N1anl1Q3pDNXJUS2FB?=
 =?utf-8?B?cmR6Uk5qKy9qVFJzSWkvdGJNZW1kNXNmdDlTNHB3cFlNSkFyR2NCQis5MEJ2?=
 =?utf-8?B?Mi96RU9kNldkOGZ2ZHNpeTAraC90YWEwcWRacEJkcG5hTnc1Y1F6dVh4b2ha?=
 =?utf-8?B?c09DUXZHc2x1S3RVeTRVU3c1dEErQU4rdFRxT3A1R0NsQmp6cHZrMGI5S0JU?=
 =?utf-8?B?TTNDNTcyQURtdEthaVRSZXRySGEyQ0s5eXpzYlpkdTZaNXFjUmJ1TXpFZVBS?=
 =?utf-8?B?cnRhYkNDNU9BVlV5NGdaaHNLQW1aTHdYMUhMdTJFcUdsTlo3ME81UUl1ZFlt?=
 =?utf-8?B?eFgySWgrTmV6Rjc3Yno3dHo0VlQrZnBCdmJzTDdJWnFzT09GSGVGNGNHaWNw?=
 =?utf-8?B?UVdrVVJDenJ1V1ZnclRGQm1EdVduSi80blJDc2xJTzZzeUQ1emdvd3NRRnRU?=
 =?utf-8?B?OGhwemR0WDE0b3NBMTNYNmsvNXJSeHpmb0sxR3RtTFY5c25VY2FLZWxpRXZM?=
 =?utf-8?B?TzZwLzhxTjlscUIwNmI0dU0wamlKTzNQQlZmcjR2QVJTaUFQbDhLSy83UkU2?=
 =?utf-8?B?RUxtcEVuNnNpemxpQ2JRcmd1MWlLQWtXaUNIWHJxbnNzRXAxZTFoME1OTHd4?=
 =?utf-8?B?RHlvVnRLWlpDV3F2OEl4N3NrTGZYWG52TEgvUHI4ZmQ4Q01QeXlOaTN2akc2?=
 =?utf-8?B?VDZCS1htdzU1bXlEK2hTTHllNy9NcHpiaDJ6bTRISVB1L2RnSkVGOVhsSS9n?=
 =?utf-8?B?eXhMQlI1NG9FT2dlYVYvUDN0SWw5MGRmVWVLbnhOTS9pdmQrZ2lvOTBIM09s?=
 =?utf-8?B?NFJhTUtKY3pFMFhHckl2UVJVN3ZubHlMQW8vYTczNGFidHB4MGRJdFlvdVJX?=
 =?utf-8?B?ZlJGMllSRFdqZHNKQzNLRzJUUDRZU3lDY1RuTUVsQ3BNSGpMVTRLdWlKdUtW?=
 =?utf-8?B?T3pIVXBnMncrNDV6UEZXTDdzVkVyYkZMbm9CaEpoQVpmQ053T3VlSzYvMHFs?=
 =?utf-8?B?a215UnpZV0J0bDR2d29jc1dMQU8wVWtYZjBNeUZJZWtSdkFNazJBbXBVWUNL?=
 =?utf-8?B?UFRYNnVGV0xWQ2tBR1FnQ0lVbWpUb2xDWnFuMkpkL1hJdkNlYWVZQmZVNEdY?=
 =?utf-8?B?d1JYRW1NL0lLaXRZampueXlKdHdyMFo5ODA1UnpaOUY1V1JhSUN2amsvc3Z1?=
 =?utf-8?B?YXpHbjRzdXpRWUhNVW4rUUtyZ2N2R1E0VXZ1S1FJZmdNTU9TR29TdWpVUzlK?=
 =?utf-8?B?VEdaMkhHeXhKaWNrOXdhNmpBWVFReHZnOGdURTM0QmROVzFxTXE2N1FjdGJw?=
 =?utf-8?B?TGZmZlExWTVqRFptbVl4K2RuQ0p0Zm5acXJERWlHdkVGRUg1UmFDUnlaZGxN?=
 =?utf-8?B?a213eUhhTm1ZOTFBckFuNjdFV2FmUURNV05KbWdPYXRFZXhOOHc4NmRwYUJk?=
 =?utf-8?B?c28vdHN1cThsWUErSGdsTi95MFZjcm5CelltQ0JUZ3lIVTFBQ0xzb0prazFJ?=
 =?utf-8?B?U0M2SHZyRHJHbloyOUJvY3FnZlE4eHBGS1NMUHV0QlRQTkdFTEp0bjZka3px?=
 =?utf-8?B?bklKdm0vV3RHcmxXU2d5WHBVTXU1ZHpmaU9vL1RnbmFjS2FoWmZFSUNka3dO?=
 =?utf-8?B?alBMaDVyYnJFd3F6UG5GSURHMk8zWFRGN1R6cEtRWE5HWi9PdWZrRnZsN1hp?=
 =?utf-8?B?cTVtZGpTc25GekZ0d3pJSXlxYkFRVWtrUjVZazgyajN1YWJCYWhpZ3gyTGVW?=
 =?utf-8?B?aDFLQTA1QlVReXlUZUJPSUlaVjVzTVJzL0ZGaktvaGVybDE3K29qdlpqeWNj?=
 =?utf-8?B?MWVIbmNHZ0NZZVk3U04vK3JweEVTM1BJeWp5QWFwK3NtVmpvZDdja1VSTTFv?=
 =?utf-8?B?MFZ4T2JLM2d2SnZoNmxSaHFOOGtscXJsOURLVzR6eWkvQURIWlBaVGNMdHdx?=
 =?utf-8?B?enNmN29oWEZPUFl5RWQ2SCtSS2MzODh1TzhxZ0RvYmkzUEhtSW5HRWJFVi9i?=
 =?utf-8?B?c2pQWVE1Q2lyM3phVmRRbml2aEtaTW9BcEJpeDZkVEM5RjVpUllDMzZlS2ZK?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+OpxMnAwhbjOIh6Lv8vknbRX9WL02xizjwWqvOBPem6z/Pu+yNm2ie/5KrQwzZmT3cFVClTmDedbpyldmu9sp6wPvxJ+TT4kDA2lh1d7gmumNjQughw+2jz4tB49LleU3VGUNzBoS1tO8b6p9h/VcsoTdrsSam1vWQOQdq/Ot7OxEfijkVkdN1R9uC2D098Vsu0R+dzhixgbLc0+Zbf4Q7BeIILe/tu0Ra8WoqNd4tLif2McX1HPB6OtWaAduyuSG6/uywNYorl2CnVAePbhXEN3Shgvkkxk7W348z2aCwfgkZW2LfmJxZaPFu1d5ByYmVKCO3uh45DAM+mHAJE2SlZ6s2P6TV9Zt6thgxhtYQvTAmSZvjeH77BT9Bv65Lk7mcBkxJNbJUqs0irFgEq3tI/S04vwbIxzTD+eePFrrbXIF0rmWoyAs5j6W+EyzzMwSNbvqV+OEyYgiqRu4HnY+sMWDRqr1AtaDCG6+2sPkuiEzUsnJ6ufMI2Jk7DXebrcZt9Lw6dPrSSsKqc/YuQq4Kk2QH4mtq2Tqv02JF6yuP5pNR+P830DFs9iXzit7W+a+l0qT5yXCQwmlPxWuYgN02fbhsFzZr1eCZOqDC/ZDLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dcbaff-1bce-4f8d-956e-08dd0a29382a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 12:37:11.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkHbj/TyVkGzPQAFaGrBUPikrBF5VmeG0cqAJcFO5FZ6HVasoURa+wvctjeNMcheABZC1HIVoKON7gvbEKwKWgHjY0t5Kxt+rVyi/MO1WhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210098
X-Proofpoint-GUID: gVqDDT3JuN6MBn946z4aBEbbETnkj-IB
X-Proofpoint-ORIG-GUID: gVqDDT3JuN6MBn946z4aBEbbETnkj-IB

I'm generally fine with this patch (other than rust specifics which I leave
to the rust experts), however I'm a little concerned about us taking
reference counts when we don't need to so this is something I'd like to see
addressed for v9 or, at least to be confident we're not doing this in the
binder code unnecessarily.

Thanks!

On Thu, Nov 21, 2024 at 10:52:09AM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 7:13 PM Lorenzo Stoakes
> > > +void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> > > +{
> > > +     mmap_read_unlock(mm);
> > > +}
> >
> > I guess at this point we're only interested in reading?
>
> Yeah. The write lock would be very similar.

Ack

>
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index 66f5cde7f322..cc1963510cdf 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
...
> > > +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> > > +#[repr(transparent)]
> > > +pub struct Mm {
> > > +    mm: Opaque<bindings::mm_struct>,
> > > +}
> >
> > Does this tie this type to the C struct mm_struct type?
> >
> > Does 'Opaque' mean it is a pointer to a type which is 'opaque' in the sense
> > that rust can't see into its internals?
>
> This declaration defines a Rust type called Mm which has the same
> size, alignment, and contents as `struct mm_struct`. The purpose of
> Opaque is to tell Rust that it can't assume anything about the
> contents at all; we do that to leave it up to C.
>
> For example, normally if you have an immutable reference &i32, then
> Rust is going to assume that the contents behind the reference are in
> fact immutable. Opaque turns that off, meaning that an `&Opaque<i32>`
> is allowed to reference an integer as it gets modified. It makes all
> access to the contents unsafe, though.
>
> Note that Opaque is *not* a pointer type. We're going to be dealing
> with types like &Mm or ARef<Mm> where &_ and ARef<_> are two different
> kinds of pointers.

OK so when you reference Mm.mm that is in effect referencing the struct
mm_struct object rather than a pointer to a struct mm_struct? and

>
> > > +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
> > > +unsafe impl Send for Mm {}
> > > +// SAFETY: All methods on `Mm` can be called in parallel from several threads.
> > > +unsafe impl Sync for Mm {}
> > > +
> > > +// SAFETY: By the type invariants, this type is always refcounted.
> > > +unsafe impl AlwaysRefCounted for Mm {
> > > +    #[inline]
> > > +    fn inc_ref(&self) {
> > > +        // SAFETY: The pointer is valid since self is a reference.
> > > +        unsafe { bindings::mmgrab(self.as_raw()) };
> > > +    }
> > > +
> > > +    #[inline]
> > > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > > +        // SAFETY: The caller is giving up their refcount.
> > > +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> > > +    }
> > > +}
> >
> > Under what circumstances would these be taken? Same question for MmWthUser.
>
> This makes `Mm` compatible with the pointer type called ARef<_>. This
> pointer type is used to represent ownership of a refcount. So whenever
> a variable of type ARef<_> goes out of scope, the refcount is
> decremented, and whenever an ARef<_> is cloned, the refcount is
> incremented.
>
> The way this works is that ARef<_> is implemented to use the
> AlwaysRefCounted trait to understand how to manipulate the count. Only
> types that implement the trait with an impl block like above can be
> used with ARef<_>.

OK so when you first instantiate an ARef<_> you don't increment the
reference count, only if it is cloned from there on in?

>
> > > +
> > > +/// A wrapper for the kernel's `struct mm_struct`.
> > > +///
> > > +/// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
> > > +/// be proven to be non-zero at compile-time, usually because the relevant code holds an `mmget`
> > > +/// refcount. It can be used to access the associated address space.
> > > +///
> > > +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> > > +#[repr(transparent)]
> > > +pub struct MmWithUser {
> > > +    mm: Mm,
> > > +}
> >
> > Why does Mm have this as a Opaque<bindings::mm_struct> and this sort of
> > nests it?
> >
> > Does this somehow amount to the same thing, or would you probably never
> > actually reference this mm field?
>
> It amounts to the same thing as Opaque<bindings::mm_struct>.

Ack.

>
> > > +// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
> > > +unsafe impl Send for MmWithUser {}
> > > +// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
> > > +unsafe impl Sync for MmWithUser {}
> > > +
> > > +// SAFETY: By the type invariants, this type is always refcounted.
> > > +unsafe impl AlwaysRefCounted for MmWithUser {
> > > +    #[inline]
> > > +    fn inc_ref(&self) {
> > > +        // SAFETY: The pointer is valid since self is a reference.
> > > +        unsafe { bindings::mmget(self.as_raw()) };
> > > +    }
> > > +
> > > +    #[inline]
> > > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > > +        // SAFETY: The caller is giving up their refcount.
> > > +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> > > +    }
> >
> > Hm, why is it we mmget(self.as_raw()) but mmput(obj.cast().as_ptr())?
>
> There's one assumption about references that Opaque doesn't turn off:
> The memory behind the reference must not get deallocated while the
> reference exists. We can't use a reference in dec_ref because the
> memory might get deallocated during the call to dec_ref.

OK I see.

>
> > Also I guess relatedly, why does one refer to &self and the other as a
> > NonNull<Self>?
>
> Writing `&self` means that the "self parameter" has type `&Self`,
> which in this case is the same as `&MmWithUser`.
>
> The type `NonNull<Self>` is the same as `NonNull<MmWithUser>`. The
> NonNull type is a raw pointer that can't be null. Other than the
> non-null requirement, nothing is assumed about the raw pointer.

Ack

>
> > I'm guessing as a non-rust person a 'reference' is like a C++ reference in
> > the sense that (well it is _assumed_ in C++ anyway) it acts like a pointer
> > for the type which should never not be there, but we need .as_raw() to get
> > the raw C pointer?
>
> Yeah, Rust references come with an assumption that the object is not
> deallocated while the reference exists.

Makes sense.

>
> The .as_raw() call converts from &MmWithUser to `*mut
> bindings::mm_struct`. So note that it not only converts from reference
> to raw pointer, but it also changes the target type from MmWithUser to
> bindings::mm_struct.

Ah I see.

>
> > And I guess in the dec_ref() case we need the .cast().as_ptr() because obj
> > 'boxes' around self (I guess equivalent to 'this' in C++ kinda)
> > guaranteeing that it can provide non-null pointer to the current object?
>
> Well, the thing that is equivalent to "this" would be "self".

Yeah, but in this case we actually need the 'only assume we have a non-null
pointer' value obj, which we cast to a pointer. OK cull.

>
> > > +// Make all `Mm` methods available on `MmWithUser`.
> > > +impl Deref for MmWithUser {
> > > +    type Target = Mm;
> > > +
> > > +    #[inline]
> > > +    fn deref(&self) -> &Mm {
> > > +        &self.mm
> > > +    }
> > > +}
> >
> > I rubber ducked myself a bit on this, so I guess this makes it possible to
> > dereference the object, and it
>
> It lets you transparently obtain an &Mm from an &MmWithUser, making
> all Mm methods available on MmWithUser.

Hm did I not finish my sentence haha. Yeah I think I kind of rubber ducked
myself further and saw that this was the case.

>
> > > +// These methods are safe to call even if `mm_users` is zero.
> > > +impl Mm {
> > > +    /// Call `mmgrab` on `current.mm`.
> > > +    #[inline]
> > > +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> > > +        // SAFETY: It's safe to get the `mm` field from current.
> > > +        let mm = unsafe {
> > > +            let current = bindings::get_current();
> > > +            (*current).mm
> > > +        };
> >
> > I don't see an equivalent means of obtaining mm from current for
> > MmWithUser, is that intentional, would there be another means of obtaining
> > an mm? (perhaps via vma->vm_mm I guess?)
> >
> > An aside -->
> >
> > If we're grabbing from current, and this is non-NULL (i.e. not a kernel
> > thread), this is kinda MmWithUser to _start out_ with, but I guess if
> > you're grabbing the current one you might not expect it.
> >
> > I guess one thing I want to point out (maybe here is wrong place) is that
> > the usual way of interacting with current->mm is that we do _not_ increment
> > mm->mm_count, mm->mm_users or any refernce count, as while we are in the
> > kernel portion of the task, we are guaranteed the mm and the backing
> > virtual address space will stick around.
> >
> > With reference to MmWithUser, in fact, if you look up users of
> > mmget()/mmput() it is pretty rare to do that.
> >
> > So ideally we'd avoid doing this if we could (though having the semantics
> > of grabbing a reference if we were to copy the object somehow again or hold
> > its state or something would be nice).
> >
> > I guess this might actually be tricky in rust, because we'd probably need
> > to somehow express the current task's lifetime and tie this to that
> > and... yeah.
> >
> > <-- aside
>
> Ah, yeah, I guess this API is incomplete. We could have an API that
> lets you obtain an &MmWithUser instead. Then, if the user wants to
> increment the refcount, they can manually convert that into an
> ARef<Mm> or ARef<MmWithUser>.
>
> It's true that it's slightly tricky to express in Rust, but it's
> possible. We already have a way to get a &Task pointing at current.

Yeah, but I think we should do this incrementally as I want this initial
series to merge first, after which we can tweak things.

>
>
> > > +
> > > +        if mm.is_null() {
> > > +            return None;
> > > +        }
> > > +
> > > +        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> > > +        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> > > +        // duration of this function, and `current->mm` will stay valid for that long.
> > > +        let mm = unsafe { Mm::from_raw(mm) };
> >
> > Hm does mm now reference something with a different type, as in before it
> > was a 'raw' pointer or such, and now it's a reference to an Mm right?
>
> Yes ... this is using shadowing to change the type of the variable.
> It's actually rather common in Rust.
>
> The former mm variable had type `*mut bindings::mm_struct`. The latter
> mm variable has type `&Mm`.

Ack yeah I wondered if this might be an idiomatic rust thing.

>
> > Also I guess the 'duration of this function' is because we put this in the
> > 'Aref' smart pointer which kinda takes over the lifetime of the reference
> > by wrapping it right?
>
> Yeah, basically, the lifetime gets inferred from how we use it.

Interesting, I do like this 'compiler consciously aware of lifetimes'
thing.

>
> > I mean I'm not a rust person so actually I have no business _commenting_ on
> > this :P as this may very well be idiomatic rust, but I'm just curious about
> > this.
> >
> > It's nitty but I feel like maybe we're somewhat overloading 'mm's here a
> > bit though? As we have our wrapped Mm type and then an internal raw mm
> > type. On the other hand, it's hard to now have horribly awkward and
> > confusing naming here I guess, and perhaps this is fine.
> >
> > Not a big deal though!
> >
> > > +
> > > +        // This increments the refcount using `mmgrab`.
> > > +        Some(ARef::from(mm))
> >
> > So I get that Some() means this is like a discriminated union or such,
> > where we can return None (as above) or Some, which contains the value is of
> > type ARef<Mm>. And I guess this moves the 'lifetime' of mm which was
> > previously with the function into that of the ARef<>?
>
> Yes, Some() is normally a discriminated union, but in this particular
> case since ARef uses a NonNull pointer for its only field, the
> compiler is smart enough to represent None as a null pointer instead
> of using a discriminated union with a separate tag.

Ohhhh nice!

>
> As for the "lifetime" of the `mm`, that's not really the lifetime of
> the mm_struct. Rather, it's the duration for which the &Mm reference
> is assumed to be valid for. That lifetime ends right after the
> ARef::from call, because that's our last use of the &Mm.

Ack.

>
> > Does the ARef<> 'just know' to use the AlwaysRefCounted methods?
>
> Yep! See e.g. the destructor of ARef:
>
> impl<T: AlwaysRefCounted> Drop for ARef<T> {
>     fn drop(&mut self) {
>         unsafe { T::dec_ref(self.ptr) };
>     }
> }
>
> Due to the `T: AlwaysRefCounted`, the type `T` must be a type that
> implements the `AlwaysRefCounted` trait, and the compiler is able to
> resolve T::dec_ref based on that.

Ah so this is mandatory for using an ARef<> in general then?

>
> > > +    }
> > > +
> > > +    /// Returns a raw pointer to the inner `mm_struct`.
> > > +    #[inline]
> > > +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> > > +        self.mm.get()
> > > +    }
> >
> > I guess this .get() method is on the Opaque<> object and returns a raw ptr?
>
> Yes, it just creates a raw pointer.

Ack

>
> > > +    /// Obtain a reference from a raw pointer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
> > > +    /// during the lifetime 'a.
> > > +    #[inline]
> > > +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {
> >
> > I'm guessing this funny 'a syntax, based on the comment, refers to the
> > lifetime of the object?
>
> It's a lifetime, but not necessarily the lifetime of the object.
> Rather, it's the maximum duration in which the reference is assumed to
> be valid. It must not be longer than the lifetime of the mm_struct of
> course, but it's usually going to be much shorter than the lifetime of
> the mm_struct.

Ack, I like how explicit this is...

>
> > > +        // SAFETY: Caller promises that the pointer is valid for 'a. Layouts are compatible due to
> > > +        // repr(transparent).
> >
> > God I love these SAFETY comments (I mean actually, sorry I realise it's
> > almost impossible to convey 'not sarcastically, actually' in text form
> > :). Is that something that gets parsed somewhere, or a convention or?
> >
> > I like that there is a discipline of expressing under what circumstances we
> > are permitted to reference things.
>
> They don't get parsed anywhere, except that not using a SAFETY comment
> at all is a compilation warning.

Ah, nice!

>
> > > +        unsafe { &*ptr.cast() }
> > > +    }
> > > +
> > > +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> > > +    #[inline]
> > > +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
> >
> > I actually kinda love that this takes an mm and guarantees that you get an
> > MmWithUser out of it which is implied by the fact this succeeds.
> >
> > However as to the point above, I'm concerned that this might be seen as
> > 'the way' to access an mm, i.e. mm.mmgrab_current().mmget_not_zero() or
> > something.
> >
> > Whereas, the usual way of referencing current->mm is to not increment any
> > reference counts at all (assuming what you are doing resides in the same
> > lifetime as the task).
> >
> > Obviously if you step outside of that lifetime, then you _do_ have to pin
> > the mm (nearly always you want to grab rather than get though in that
> > circumstance).
>
> I can add a way to obtain an &MmWithUser from current without
> incrementing the refcount.

Yeah, I feel like we definitely need this.

However we'd need to _not_ drop the refcount when it goes out of scope too
in this case.

I'm not sure how you'd express that, however.

>
> > > +        // SAFETY: The pointer is valid since self is a reference.
> > > +        let success = unsafe { bindings::mmget_not_zero(self.as_raw()) };
> > > +
> > > +        if success {
> > > +            // SAFETY: We just created an `mmget` refcount.
> > > +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.as_raw().cast())) })
> >
> > When you do this, does it cause the reference count to increment, or does
> > it assume it's already at 1?
>
> This uses `from_raw` which by convention never increments the
> refcount. Semantically we're taking ownership of the increment
> performed by bindings::mmget_not_zero.

Cool, good!

Though as above, we definitely need a way to get this without fiddling with
reference count.

>
> > > +        } else {
> > > +            None
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +// These methods require `mm_users` to be non-zero.
> > > +impl MmWithUser {
> > > +    /// Obtain a reference from a raw pointer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that `mm_users` remains
> > > +    /// non-zero for the duration of the lifetime 'a.
> > > +    #[inline]
> > > +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> > > +        // SAFETY: Caller promises that the pointer is valid for 'a. The layout is compatible due
> > > +        // to repr(transparent).
> > > +        unsafe { &*ptr.cast() }
> > > +    }
> >
> > I guess this is another means by which you can get the mm. I'd say an
> > equivalent for getting from current is highly relevant.
>
> This lets you write MmWithUser::from_raw in unsafe code.

Ack.

>
> > > +
> > > +    /// Lock the mmap read lock.
> > > +    #[inline]
> > > +    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> > > +        // SAFETY: The pointer is valid since self is a reference.
> > > +        unsafe { bindings::mmap_read_lock(self.as_raw()) };
> > > +
> > > +        // INVARIANT: We just acquired the read lock.
> > > +        MmapReadGuard {
> > > +            mm: self,
> > > +            _nts: NotThreadSafe,
> >
> > I'm sure this is a rusty thing, but curious as to why this is like that?
> > What is '_nts', etc.?
>
> _nts is the name of a field. The NotThreadSafe type has size zero, so
> it doesn't exist in the compiled code. It exists only to mark that the
> MmapReadGuard cannot be transferred across thread boundaries.

Ah right I see, wanting compiler-specific behaviour from the type but not
to actually modify the compiled object in reality.

>
> > > +        }
> > > +    }
> > > +
> > > +    /// Try to lock the mmap read lock.
> > > +    #[inline]
> > > +    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
> > > +        // SAFETY: The pointer is valid since self is a reference.
> > > +        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
> > > +
> > > +        if success {
> > > +            // INVARIANT: We just acquired the read lock.
> > > +            Some(MmapReadGuard {
> > > +                mm: self,
> > > +                _nts: NotThreadSafe,
> > > +            })
> > > +        } else {
> > > +            None
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +/// A guard for the mmap read lock.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// This `MmapReadGuard` guard owns the mmap read lock.
> > > +pub struct MmapReadGuard<'a> {
> > > +    mm: &'a MmWithUser,
> > > +    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
> > > +    _nts: NotThreadSafe,
> > > +}
> > > +
> > > +impl Drop for MmapReadGuard<'_> {
> > > +    #[inline]
> > > +    fn drop(&mut self) {
> > > +        // SAFETY: We hold the read lock by the type invariants.
> > > +        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
> > > +    }
> > > +}
> >
> > Ah that's nice, an actual guard for it :) I'm guessing the fact this
> > implements the guard implies that you _must_ hold the lock first right?
>
> Yeah so this code runs when a variable of type MmapReadGuard goes out
> of scope. We don't provide any way to obtain an MmapReadGuard without
> locking the mmap read guard.

Delightful!

>
> > >
> > > --
> > > 2.47.0.371.ga323438b13-goog
> > >
> >
> > Sorry for the numerous questions, I'm afraid there'll be a lot of this for
> > rust stuff for the time being. Perhaps advent of code will help improve
> > things on the rust front for me ;)
>
> Thanks for all the excellent questions!

Thanks for taking the time to answer them!

>
> Alice

