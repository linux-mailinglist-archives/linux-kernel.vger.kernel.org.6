Return-Path: <linux-kernel+bounces-354361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10294993C7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720AAB22852
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7B1CD02;
	Tue,  8 Oct 2024 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hOvNucjU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENV9z8fk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29371C683
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352279; cv=fail; b=NJn6inC2rbizy8UWBiO6ZAhOGLHcL6NzjEemLiELHlctBieuydMIjYQ75QpVjKYSMGmiAKqNP1RUZuWb938fuU9AvfeYhHWgL9hiqy8MF4z/23fQ/3vCZlnpD3wrayXX5xiXZxT4tfMC+uH09CbcFVhZKTMdNZkhEThgW7llYRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352279; c=relaxed/simple;
	bh=h2UwBk+lUmg5UGZEpKq/dANuQzUT4iF1hMfY7aNzgI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+HjLpgt1zbybj1DHK0DBQxzv/qJgGwqaN56uhgrqjftw5e7VhYoJHvbP+yljouDg69YbppKpw9fAM7l63lXv8IIFvJs40Z9ZVTYLIPZZ4oj3u2z9ytigqDVmyEeaqohWKjaEzTj0ERaLP9Wz6lET/gpn0S2jMJLy1wcPd28NGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hOvNucjU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENV9z8fk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4981McNk016135;
	Tue, 8 Oct 2024 01:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v5r4eltSEHSqot9RE3PlMlR1aXDDec9aJiMKtOVrYC8=; b=
	hOvNucjUESY/pDRmE26YLBLVALvCOxeEwQUtGAlJEbvF0VVBq8TI1rKH5pnlTdW5
	3UtIpFJurU5Ty+o3EqjihsC6mDc2/jA4RJ6+Lw3mXmTT9F/H9bwpLDnCrY8tUBnh
	FBxCyAAF+CPI0xPnSfVMfh8a0BT5HOoIj9jhFuTfdodcKD8/cmiraOYdCjMeLSBO
	gQESd1FjJETWGHW0byykIj6kG9qUUNIGb5nK+VrqJLgIUFwyzzs+bs4RtsxCivXH
	cqVzDgUZd/rIg62XKBCrZmv6VAzQ+Svx0xSHQ2iNU4WuGrdS7ID9+THt3CjFoR/d
	vOB1zhnA9TFH7yJHvKYPHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv4rs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 01:51:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4981kXV3003144;
	Tue, 8 Oct 2024 01:51:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwctqwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 01:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5NssXs/vE8OLOcG/xdvIAQzUEN1sI55LX1CXN9qaEpirCzlPpaCDUGQrw7Y/qH5S/ETwMlLEQ2iooyga9H2u3e6k3t3JbvsEZ/PyxMrm3wUyvh7vnVWObBaRAPOYcZmsK3/48SFSir5eorpP515/V1cGG2iCahrRj59dlwjutAxqQIAqi3vVFgvLAHkAKLrGVOEnEIOHWkPT5PcJqxG5whd/ByL3hY1wyySZLXUE9saIJS9v5q76klZ0FeeXHfSWABZYZuYgdovSG9fmCAwTUfXXkWFJPO+83IKSTPAkOF21yKdHX1D2qi9m7/kckNlymDkAWqDshai+/Ua1/g5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5r4eltSEHSqot9RE3PlMlR1aXDDec9aJiMKtOVrYC8=;
 b=aUrcyFTDUX9npVIm2XLEeG/i54Ayvl5Rqik1kNFsHEwof60vVCkurP0iH+zSGN0H2ljKllahxKgraolijkJeJgIqYPEGMnrWjRNCrmex9Qi3zn6UsaZizQAe6shhYOegCEa/qCUYRzgQFRwOlGI4blcb1Xk3bDY8kboJekNGhSONh0AVyWyDxnF/fCbh85vV0TJ3zzHlrb2oRvltVhARgI4M4w4VO30T3qHms8hdIYZE9NqgwxBezJNrvsTlZmi0WGJUC7D13yrXTVHYMXnGX0Mn/bNMlryyKMh+PD0X4gwSZRmMHVn/jiDyGJUhScuIxCoRx9zHNx78xQR0KrVRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5r4eltSEHSqot9RE3PlMlR1aXDDec9aJiMKtOVrYC8=;
 b=ENV9z8fkxjdIY8Kk+O7UDkN9ykJMb2nQw9ALHCGJvA7+ZyN6GHPgocCHhBWPntPtfrdyb9QvPla+3NINX+1oYMbliiDgnXU0fcVIp4hxb6vgLkR3c/yUMYC5cJvJbagV0qoh1O31as/CaeLStqck+ZwQ5pBi4iQp93ugeakLmiM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV8PR10MB7845.namprd10.prod.outlook.com (2603:10b6:408:1e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 01:50:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 01:50:57 +0000
Date: Mon, 7 Oct 2024 21:50:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>, Seth Jenkins <sethjenkins@google.com>
Subject: Re: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid
 zeroing vma tree in mmap_region()
Message-ID: <btu3mxc7qn33vux2jtzewuavth7ziq4xb6nudiu5kf7bs3bejm@e7btayqaavzh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com>
 <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
 <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
 <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV8PR10MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b01458-c082-4339-bb23-08dce73ba750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG0xMmhOcnQwRGUzaEhocklXMEtteVFJVnp4RU5mckZCdVdpT1ZvRlZGcTh4?=
 =?utf-8?B?cEJGOCsrSHJTYlZWOHF5blBJSVdnS0hUMnFxd3g0VWZxT2FMZVdlMnRtSDVO?=
 =?utf-8?B?YzkxbDRWLzhSa29ESE4vQXlSdGsrU0lDN0U5eHI0TWhTZGI4RUNQV3BHS21O?=
 =?utf-8?B?TGhQZW1seU4zckI4L240OFdXVnA0MER1OFdqSjZGSERRbDdwL0VqMElPeHlP?=
 =?utf-8?B?dGh3OUxYaWo1N0FPYjJsMTFaSlM1aWxRUjBZSGxUM0ZMRlNrY1JVWk13SS83?=
 =?utf-8?B?QVVCT1JRUDNHRmdIV2ltSkduV3RiL1crMWVYUkQxZ2NKK0ZkNHR6WUdPa213?=
 =?utf-8?B?YlFDT09FQkc0VUNVSmg4blI0ejV0a3RMVjVvZnVaZUxXQ3BPYXNDN0I4d1J5?=
 =?utf-8?B?dENXSlZxVUMxMjlXTldVcHluU2d2bFJ4TG11MHljbVdOZGViRDhKcWFYVkNo?=
 =?utf-8?B?clRLcmt5bTBLZ2pZYlNCOVBPL2VrbjhkSWJ1UXY0SVhCcGhrNEtnbmhjVjlt?=
 =?utf-8?B?aVJQYnJ4NE1NUUpRc3duSFg0VHcvcU45eEdtTkVsTXVDK0JiTmhXT1c1Zkh4?=
 =?utf-8?B?K3NCQ3N0dXFHYUo0N05ieU5BaTNrNFZRcU16Y0ZlQVNpUGRydzhvSy83WE5C?=
 =?utf-8?B?cTNNOStUZzJuVmlUK3B6MWtOUlJtSHlUZ29QSVZHQW9KRDJiVG44cm5QQ2p3?=
 =?utf-8?B?djRreDd6NE0wTnF2ZkFxZ2YrVzdSUXlLbEZKaEFnazRXVDBRU3JRdjBaYnMy?=
 =?utf-8?B?MVhSamo2ZjNFbXB5Y0NPOUZCaTF4NUpjeVAySTBtVEQveWdVNE5hWGtiMEdY?=
 =?utf-8?B?cXZzWmpUOTd1cS9QY2swUm5JVFBpL0tTcDM2bENaNmxldjk0L0tEVlB4cytk?=
 =?utf-8?B?OG5hSWRjU2N3MFBYcjRoaWRqaXhJQk1MbitxcFhXZzlKTFJTVkQxTXZKYnpX?=
 =?utf-8?B?NExXdVAzMi9CQWVyZ2JxQUxJS1dUa0F0b0RjL01vNXQ3MDhyM1ZxN0JDNTU2?=
 =?utf-8?B?b01vWnBocTZBallkREZLMHNKa1JCamluaDJaRVpBWEVYdjFXT1dRMXp6VUY4?=
 =?utf-8?B?RjJwMkl6b3pmV1lRbkN6cXhid3FYdWcvVGQ3MG91R3ExWGFxREZkS2lObjBr?=
 =?utf-8?B?MjdBcVM3K2Y4aUJFT1NZRFhOMkhYeDJqQ1ZoWXJoaWorQlAxYTRtNTA1TzUz?=
 =?utf-8?B?aGg1L01MbEdUdkFFb2ljRFR4ZEZIZ3JVbWVOa01xWVg2bUdCdS82WDMrL3FL?=
 =?utf-8?B?YTV4YWwwUFVUTUtxRDFMVHVFZEx4VWhTaTlKejJERG03VWo0alN3anlIZDcy?=
 =?utf-8?B?OEkyLy9UVTdROTA4QmVZSzBjL0g3Q2NqQzUvZHlpM2t6VDJaV0YzcE93Z3l3?=
 =?utf-8?B?WkxtRzZBR0RTblF4eGVqTGdNWHlzalVNZWdlbjhIcFA4cmZ3WEZPWTd6V2U0?=
 =?utf-8?B?bFZQUnZ1dWdWZkovT0VEaGlyMllzL0NoM1N1bVhQOUxOTHY2eGZ0U0F5WGJm?=
 =?utf-8?B?Q2krckxHQWZkWld3U2R1QkttZlNhRUZncTB1aDNONWhLam5QWHQzT0owK3I4?=
 =?utf-8?B?ZktnQStvTjgvTFN6QkhHdzdnVWRvem9iQVIyRllaTXYvb0h2b3Q4VmFLamxQ?=
 =?utf-8?B?SEFwWG5aYTh6NFJZbmNUZTNQcTNneWFRMlJzZjFXUEd2VWNrWFJkMTA3dzR3?=
 =?utf-8?B?SnlVVzg5cEdzSzkyZG1uWHJTWmJmRnI5ZHRLQksyZ0RsTEFqbkNvRStBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hZTDErTjdlbHVNTy91R09XMFdmMlEvV3FoeG5wWndDL2Q4SStlS3pialBT?=
 =?utf-8?B?VVIreWlocnNzcXhINjloN1dZek93eHUwZEZwTmtES1Q1K0FPWU9MZ0ZqNDBh?=
 =?utf-8?B?SjJDTkpVUGVIeDVRSHBKYng5Rkl0U0tvRTQ5K29KYUxFaGFuSWh4K3g4Zmpw?=
 =?utf-8?B?VkgzL3QwNFlHeUdQK2U0T0JKLzE2OXVWazh3UUlYMGtTM0ZYbGNCYWdsNFQ4?=
 =?utf-8?B?SnFkRURnUmg2cUZYenNFc2QrU0tQMTVYMzRDeU5aanRwN0ZiU0dTTno5STYv?=
 =?utf-8?B?TlBpN0QyekczRlcvMzZDT0NOYUM4U1dsMjlwWWsreXh6bHlEYy9ZTE90bzVM?=
 =?utf-8?B?c0V0bEJJenNRak5oWVdNek0zNUNxWWsvU3RicWp3NzFxVm1yd25HUFZWczhI?=
 =?utf-8?B?ekNjMU9Xbm5rVFpwQUdNSUp1RjlHOUl2eFZqSWYyb2U5QVQwbFpUVnZpNFJq?=
 =?utf-8?B?Y0dsc2RFUXZmd1NZN09HV1VGQ1JxTGw1Q3JFWkEwVytLZmpsOHRiNWY3d0Jk?=
 =?utf-8?B?NmN3SU5vVUcyNkY3dFovcVdQQ0VHalcyYnJiY0xCR2M4V2ZyaGIvWWNiazU1?=
 =?utf-8?B?K3d4WkdURWN1ME5EWU8zYmFuQlJrYTF5VkVIejNTNUlld3V5RDRMM3d5aHAz?=
 =?utf-8?B?OFh1UTUvQnQ0RGJ0bzhpYnFyV0lOMEtBSlM2M3BGbHE1VVBNTEtwVzNyQzhH?=
 =?utf-8?B?VlJRUDRualRGdG8wbHZpUVZ0QXNJd29jVUZrL2dQaGdJWGtwQzQ3ZnNmdkdw?=
 =?utf-8?B?M0crS3I1NUdBMjFlNCsvaG1xSVh2VG5pUTAwbWZoV0tpS1FNUFljOVhhUGtz?=
 =?utf-8?B?WXVIWVRQb2hMejNpYVFobkloZ3l6VWcwL3pQSlFwTEpLTU5ZZ1lrOU5RWjJI?=
 =?utf-8?B?SVh5eDFaT1N3WmxTMTlDaVFCMDVYYmdGSE5nNGcwRWptYlZFenFHcjZNSExT?=
 =?utf-8?B?NFo5b011WTVCSlljVzNlbGNLeDhBMmttbllGNGRBTU9IaFdXWjdyQUFHcmJs?=
 =?utf-8?B?ZkQwRXlWUi9md3BUTlRTWGNHdk1jSU42d3hManlpSS9OY3dCZUgwN2NKTHlh?=
 =?utf-8?B?M2hiL0NhNGRKTW5JeUNKWUdhNHFlc2xjMkpFUDBxeE1RNTJMajRKeEZXQ3BG?=
 =?utf-8?B?TFVxZlluMEV0T3Y1V2xBa3RiSE9hSEVvaTkxMWdTNEI2NVNHMHJveHU1SS9S?=
 =?utf-8?B?Z2xqR3BacU1zdDE3NzRuUlNzcmhOc1VpU3NHb04zdnd1VXlWYlFhSnlvQ3g5?=
 =?utf-8?B?bkxMZnBnMFVBU05UalFLTzd1Nk80dWtmNW9vSWVUMXAxYktQQURMbFVEV2I2?=
 =?utf-8?B?Z2lLQVNaYUdxMEw0dnlmTUpaSktNdEQrTE5qQVhEQkJad1IyNkp2bUljMjB5?=
 =?utf-8?B?amZtMkQ2SmtubDVWOGF1YXU1WnhYZnBwcU5BRjgycVpZZnhESzJvbzZHUUcy?=
 =?utf-8?B?TTNyQ2R4aTJmaWxWdEFOdnFiWUhNcDV5dzF0R0w2OXpQaG5rbGJBUU04dlRo?=
 =?utf-8?B?M2Z1NnFkZTM5YTNLUEdKY3lhTFl0MkxRU08rdWVxOTZaMzFON0poV1kzUkhG?=
 =?utf-8?B?UXZmSWNLQTFhamdpWlRRbEZVWXlDMTFFNXZTTlBOTVovRjRFdUZSVjFGK3pi?=
 =?utf-8?B?a1cxUWN2L3VlbFpWajloeTNXR0pyRXducDNidkhqRS81dDBjMkR0d2ZBMjhm?=
 =?utf-8?B?cklubGpVVDM3cy9UbTM1ekZqQzkrSGVJSTlhMVlCVjJtRi85UzhpMWk4UE8z?=
 =?utf-8?B?U0JMckhmcnBGZTFJYWJwYnhYUEpXL1JGTnZrZUh6bTdZSXhPeFFLZDR3cU5Y?=
 =?utf-8?B?ODVnTVpYTUZKSTBFOFJPUUZnUEV1R3psV21CQUszTzliVk53ZGZpVVdWVnE3?=
 =?utf-8?B?dXJPeEVCdWpQbWpFb3N0OVVXUHRUT3U1b2NiVUNFY05KWlpoLzFwVFJtNDFr?=
 =?utf-8?B?MnZLUWtmQ3dQeTFjeEVTb3pDckV2R2EvQ3NUaExRRC9DcGJOUEFNUzllMTlS?=
 =?utf-8?B?MUlUVlZiN1lkd3lvTVN4emhQNlZYTm9zdkNCWnlrU2ZTdTE2a0t5VkVxVDhH?=
 =?utf-8?B?eVNHWlZJSFFMTWR0eERrR2lyNlBXb2R3cW4xVzBsOWc5d3ZmbndZc3NJdUVw?=
 =?utf-8?Q?SJ41U69/T5CVl4xN96XI+/q6r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UUJbT0NLKI80W+PL6nL8YqZifW4hscnYuqdAcKFCzFwFGcl4v1OFCNJ+23+jOUIyCv7aZ0+NAF38YN5Ek2ujS3bR5zTVrqldmWSCQsBWq01AhI1K6WgHuHfHRMPeQiJC1a0Obmvxkp3FJb0TFZHBnSAoi1BEz+YvgBQIeVNKffZUF5s4MyDZvCg9iIHCpSVCPeeSXlCI8SnFDutXrUfSv/yR1Basr6uheT2gpnnAVLbJuhsuVPqDNk6/6DfYJ1dWwXD1bobNa/h0oexoLhUlKGYntUqjqr6jvmpX4erh/6UJhrpKGtUa4lzUoXJprqW4i9ImVPakGOE1MJxKdpTO2kohGt3x5SKXPT3xE7hYFjRwLg2Bkb7CJPhQx9KYrtcJYji6GPUIxrYxgvGkjpONjzoRbir5x0uH5BwU8msvTU+z4DEzWHvY5vYq/Sr+O3b3w7VwKJdTNlJzXnYS8GC+2Ka6I3aknKTAIjwJqsLB3qe8+1iupi07oJb611KjiQseyQUZ9bIQ4WomzRbEYFVFOyMr69zZq1ZF9DPMM1yZYNeUnFChEc2Mesu04VYYCDpP4N00CmMDDE9v8luogBdQwErNOfmws+4mlPLsxIia7ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b01458-c082-4339-bb23-08dce73ba750
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 01:50:57.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFRRnRO4rIvF+5dTPooQvPjkCvqzNaobPsAPZjuS2HKQFkoRWzo7nBgoqXRmCIOpyn4sgifigUFdAMPQ9+FfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_01,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=988 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080009
X-Proofpoint-GUID: NfMN1XO5iUGVbo-ViaNyOq4rVD4HwS7M
X-Proofpoint-ORIG-GUID: NfMN1XO5iUGVbo-ViaNyOq4rVD4HwS7M

* Jann Horn <jannh@google.com> [241007 17:31]:
> On Mon, Oct 7, 2024 at 10:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> > * Jann Horn <jannh@google.com> [241007 15:06]:
> > > On Fri, Aug 30, 2024 at 6:00=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > > Instead of zeroing the vma tree and then overwriting the area, let =
the
> > > > area be overwritten and then clean up the gathered vmas using
> > > > vms_complete_munmap_vmas().
> > > >
> > > > To ensure locking is downgraded correctly, the mm is set regardless=
 of
> > > > MAP_FIXED or not (NULL vma).
> > > >
> > > > If a driver is mapping over an existing vma, then clear the ptes be=
fore
> > > > the call_mmap() invocation.  This is done using the vms_clean_up_ar=
ea()
> > > > helper.  If there is a close vm_ops, that must also be called to en=
sure
> > > > any cleanup is done before mapping over the area.  This also means =
that
> > > > calling open has been added to the abort of an unmap operation, for=
 now.
> > >
> > > As currently implemented, this is not a valid optimization because it
> > > violates the (unwritten?) rule that you must not call free_pgd_range(=
)
> > > on a region in the page tables which can concurrently be walked. A
> > > region in the page tables can be concurrently walked if it overlaps a
> > > VMA which is linked into rmaps which are not write-locked.
> >
> > Just for clarity, this is the rmap write lock.
>=20
> Ah, yes.
>=20
> > > On Linux 6.12-rc2, when you mmap(MAP_FIXED) over an existing VMA, and
> > > the new mapping is created by expanding an adjacent VMA, the followin=
g
> > > race with an ftruncate() is possible (because page tables for the old
> > > mapping are removed while the new VMA in the same location is already
> > > fully set up and linked into the rmap):
> > >
> > >
> > > task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > mmap_region
> > >   vma_merge_new_range
> > >     vma_expand
> > >       commit_merge
> > >         vma_prepare
> > >           [take rmap locks]
> > >         vma_set_range
> > >           [expand adjacent mapping]
> > >         vma_complete
> > >           [drop rmap locks]
> > >   vms_complete_munmap_vmas
> > >     vms_clear_ptes
> > >       unmap_vmas
> > >         [removes ptes]
> > >       free_pgtables
> > >         [unlinks old vma from rmap]
> > >                              unmap_mapping_range
> > >                                unmap_mapping_pages
> > >                                  i_mmap_lock_read
> > >                                  unmap_mapping_range_tree
> > >                                    [loop]
> > >                                      unmap_mapping_range_vma
> > >                                        zap_page_range_single
> > >                                          unmap_single_vma
> > >                                            unmap_page_range
> > >                                              zap_p4d_range
> > >                                                zap_pud_range
> > >                                                  zap_pmd_range
> > >                                                    [looks up pmd entr=
y]
> > >         free_pgd_range
> > >           [frees pmd]
> > >                                                    [UAF pmd entry acc=
ess]
> > >
> > > To reproduce this, apply the attached mmap-vs-truncate-racewiden.diff
> > > to widen the race windows, then build and run the attached reproducer
> > > mmap-fixed-race.c.
> > >
> > > Under a kernel with KASAN, you should ideally get a KASAN splat like =
this:
> >
> > Thanks for all the work you did finding the root cause here, I
> > appreciate it.
>=20
> Ah, this is not a bug I ran into while testing, it's a bug I found
> while reading the patch. It's much easier to explain the issue and
> come up with a nice reproducer this way than when you start out from a
> crash. :P
>=20
> > I think the correct fix is to take the rmap lock on free_pgtables, when
> > necessary.  There are a few code paths (error recovery) that are not
> > regularly run that will also need to change.
>=20
> Hmm, yes, I guess that might work. Though I think there might be more
> races: One related aspect of this optimization that is unintuitive to
> me is that, directly after vma_merge_new_range(), a concurrent rmap
> walk could probably be walking the newly-extended VMA but still
> observe PTEs belonging to the previous VMA. I don't know how robust
> the various rmap walks are to things like encountering pfnmap PTEs in
> non-pfnmap VMAs, or hugetlb PUD entries in non-hugetlb VMAs. For
> example, page_vma_mapped_walk() looks like, if you called it on a page
> table range with huge PUD entries, but with a VMA without VM_HUGETLB,
> something might go wrong on the "pmd_offset(pud, pvmw->address)" call,
> and a 1G hugepage might get misinterpreted as a page table? But I
> haven't experimentally verified that.

Yes, I am also concerned that reacquiring the lock will result in
another race.  I also don't think holding the lock for longer is a good
idea as it will most likely cause a regression by extending the lock for
the duration of the mmap() setup.  Although, maybe it would be fine if
we only keep it held if we are going to be removing a vma in the
MAP_FIXED case.

Another idea would be to change the pte to know if a vma is being
modified using the per-vma locking, but I'm not sure what action to take
if we detect the vma is being modified to avoid the issue.  This would
also need to be done to all walkers (or low enough in the stack).

By the way, this isn't an optimisation; this is to fix RCU walkers of
the vma tree seeing a hole between the underlying implementation of the
MAP_FIXED operations of munmap() and mmap().  This is needed for things
like the /proc/{pid}/maps rcu walker.  The page tables currently fall
back to the old way of locking if a hole is seen (and sane applications
shouldn't really be page faulting something being removed anyways..)

Thanks,
Liam


