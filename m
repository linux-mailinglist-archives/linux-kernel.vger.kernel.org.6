Return-Path: <linux-kernel+bounces-173445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053228C0087
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF06E2843D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6886651;
	Wed,  8 May 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0Iz2A0E"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD884A23
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180204; cv=fail; b=fTmikHpWu3/xK2ZBW0+Llj0/tHUy7pADp1phij5cJnfc4fiydSUD2+np73KLBcSGm/sqkOzWeSA7bCZOuHlVcNzEx7XyOn4mbeCmWX9oASjE7lie6WA8WkrhIRrGc+xrhX9DO50nwFRxfuxula3tQcmEJhB/CKySjQZgAYxmay8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180204; c=relaxed/simple;
	bh=822Nm1fWSSf0ls8fwQugptUXUovh1NiPJu4sfAwdPig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTYjR7iPJ6amrQAwxU/H3iK+yzugiHF2rLT+71XcRBvFLiRtCe1i5d+jkwz8o1V36IuY0fmnHYpOGQPiWyeFSOpEY8PI8NaZRqfXKd3UMNQE2eq6/fC1FUw85J2Bw6WWn5bqZgabi0HMOS0kYJfnWe4ymn3vGucVHwpvITDjlwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0Iz2A0E; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSkrhw2gan2RBUKqZPzNPOfEPoUvGZOVGp+vARv37FG9WeIzRlsXoJw66EBIFBCuS3o1hw7U0z9Xe0ou/kQpdBWg9X4cFA8ln7H1ko5iu6nQItOohAY6oJhr2+YKAU1ZspND+zGvkkIA1OREYbG36//ihp09fNxbtzeM/N3mxtNQoULTddB9MlmiZewhQ+zvCRUItZU35SvFYa4Gt9LUqSfjdppmxVPZdKbNBsVXa95OhAa9z0lIxN4riFe3v+TPChrsr0OULdh8eEkHdNiXJg80NGH4ydJAyqOn44uxMnDD8P+/eVq3wIHZ9bOxHLaGaV36uRQDh9lwOG0gOy2t4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyjao9UTrqvpvi9Lxybl+oteeLH0gMw36bnnGDeLUEM=;
 b=gQUhjAiov+gc4UuhcpSXwMl12ftoFL9I5sedsJCEc/ViFzITOxDCGfSIdnkgc8EBxWmyoNRYzcXAmwSoIe+7b7Acpj4mZUe7krPRJOLOmdBmDXGMWuF8+fhzm/80bQpvORc98OsRghVM7d2TJ4i+6Ph3/APMe+GVyf0heHXiArQ+b9Sx21OIdN9wVLTUla/u0AaYCkNX9DNq8gu4SQyuhANFLtXvZIRAGs3VQe65KFAZAjawR7ajp9xIao8KexviRdONfELLhUe3U25AjM/ppS9dOos34nPM41CGipPdP66gG0r4LkMg/9IhYJCwzgL+ZVaWyOCzw1a6MRjMMWAaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyjao9UTrqvpvi9Lxybl+oteeLH0gMw36bnnGDeLUEM=;
 b=a0Iz2A0E9uRaRRpwUAyFevkc9S3FTLPztGLySfO/uPx8oOByaVBz+gG954fIqwzXehhariHTZxnYRWCD+5ir3TazqqUkxme/jqwpPNNXcRtQa+NSxFtyk2SO5eRxJZFSUr/7rwU1QMJHpwBacWZsDmztQxMdraJdVltwwQNR9KqrfTDxrxbaZooK90sy0lUKL5DvWn/RtrAkaHA6SI00Pvux2cJZJUZCE8eTyi/fwEuwA5VFuIfiuKUrhwoJZARIPbIU9NDdG5VL9Rcvsm2f2hJASu0OBT5+dqaOqk9JZySLZi8Pgjlz020cT0d+jqRY3aGsAnissTqO9/sUwYNiKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 14:56:36 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 14:56:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Wed, 08 May 2024 10:56:34 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
In-Reply-To: <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
 <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D639E333-3ACE-4732-AB37-2356431BC286_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f70af3-291e-48c5-e6b5-08dc6f6f0ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktUMi9NNHd1SEsxbkEvNmpQZm5BR256N3JFUFBrZFRmck5yS004Kzh5c2Fk?=
 =?utf-8?B?aURuRDNZYkpOa3F5aG12Q1JvbWJTVndkNlFHTlJwVWlIbi8vblMxVzM5WXkw?=
 =?utf-8?B?aGhackliamIvUmRuNUVabmxSUUpBOXRCNy9qUEI0S0lYbzJDWFVwWGpSdVVw?=
 =?utf-8?B?ajFTTUlFVExxMytuQVFhYlM5YXh4b3ZsMWo4bHVrMUFMaDJZd0tqdWl4b294?=
 =?utf-8?B?NUZTNkRvUzc1TlNKSHpUMTNIanlXSm1uOUllSUx5andRL2VaVlJBVmViTGR4?=
 =?utf-8?B?bXc1MkFXYXRNMm0wcFNjaXpKMmY1UUVTdjZCalNGOWN4T0I0M1J0OWp1MHMv?=
 =?utf-8?B?a0prQURaM1VBRVFVdzhFRUVRY3RBQVVxZTBGUmN2K2hHanlsdXpvREdvZ3lJ?=
 =?utf-8?B?WllQc0k3ZXVzZXhWSkNoWlU4c3FvSkdyK1FOOG1zZVY2czBrZ0ZTTFQ5VTlj?=
 =?utf-8?B?cjkrcEZ2SlhDbk9VbnZmSWRxdmR0TUxLajlrNnJ3bDJ1S1FOMXJManJIclpC?=
 =?utf-8?B?dENzbTJ1anBnemhUTllPTVAwK3pXdjhNMWx4WjVkamZCYWNZT2lQb0JndzhD?=
 =?utf-8?B?VXArdUM5UW1Qb2FkcmpqTkVPWTkreVNHVzRqWWZ0UHF4MTBoM2lLODFkaVdE?=
 =?utf-8?B?TjZXWTFEcFptT3hLMHpybFpiVTFENjFTdHp3SlJKVEpNK1k3ZjNqa3VUcmxk?=
 =?utf-8?B?STJOVHZyRER6SDdUOEtCSXdRSzhLQXhxQjZVcGR2MmdkSHh0RXdIVFZDQzZY?=
 =?utf-8?B?RXBzQUZkZ0xVMnN1bXgrVXdibG1GSFFOajJLVkExT3lKOEQwaUcxc2tua0RP?=
 =?utf-8?B?Nlkyb3F1cU03cGRrUS80emdYeTh1S3o1QzB1ci92QVZBR3dkUG14aWZuNmNZ?=
 =?utf-8?B?YW9RVzVnZlQyUmhoQXgreHBNVDY2Tm9PcTgrQTJGWk15ZkFwRlVEeTBuU1p2?=
 =?utf-8?B?VVFQV0hwS1VCUU1ETUFkR2JNWDBxblptMDB2aW9rMmpieU9MWXdBdEJMcWlR?=
 =?utf-8?B?NzIzelNuUStZc0lNbVF4OENQc3JmVDBnbU1UK2d5WVViL0ZWTHJNQUZPVGFU?=
 =?utf-8?B?Zkg1c1hhMlJmeEtlMnlTZlFSbGJRcGV0UzVmQnBWWVl5Ym1wb3daczhHTlFM?=
 =?utf-8?B?VFI0Mk5aVEZjLysyQWkrdDMzZ0ZZZUdGL25Lb1RXZzkvSjZpRGVkTU8zYzV1?=
 =?utf-8?B?YzR4Z3VMOWd1RGtUS09lemQrWU0ramxBaU1VQzdsNkl6K1hSY3NvQjNXYmxX?=
 =?utf-8?B?Z3VSMlFFd0d2L2hpMTRPYlhQVytUZzNlcVloSDNHNUJSK3FUR21XVzd0Wmkz?=
 =?utf-8?B?V0E2ZGl0dzZ3Tm1VK3I4VlZ0Qm11UVFGeklBTmV0QkcyeUV2Qm9uS284V2t6?=
 =?utf-8?B?VUk1Mk9yTGlzMTl1Q0lzQmxlaGc2d2ptWTMxUlRCOVBMU1k3dzRjancyU1BL?=
 =?utf-8?B?V2F2UE1jN1QvdGJ5TEdsd0FINmNQSWtKb2pSY2FyZElDYitmRitTM1RMWUZV?=
 =?utf-8?B?RkZ6MXBvd2VHNTQvdzZKV3UxYm14UXZKWTZoYjhWWFhWSHhQYXdHQkxDSjZq?=
 =?utf-8?B?V2VoNFdEWVQ3b3JqR2J0L1ZKbHIyV3JBaDlNMXFzVDd2bmtDNWZqeHRoV1Rp?=
 =?utf-8?B?cWUzMjJUQ3lSdXRPTzQ2Q1U4NDNVR202b0VWMTV3eHJ6UlJJV1FKVG5rUnhy?=
 =?utf-8?B?M0xtUDI3ZzdzYjZsZ0xUNmdDeW1oZWpKeTBaS1dFQTNDdmpSV2FGRGZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzVsRlA4RU9aeVJtYy9KODQrR1pmTHZmQ3RGV2ZSc1RlY0xVNTlFVWs4M05K?=
 =?utf-8?B?NG1KcEo1b1BzM2syZ0RqVWp0d0FsZjRkeStuQlVoSkVhYUFtcSsvbVl4NnZm?=
 =?utf-8?B?OUxHRUxoVnlGTXNmdjZoaEltT1Q4ODFMYnl3dGQxTENNc1ZORHU3V0s4cFBH?=
 =?utf-8?B?WC9qalplSm4rVVd1UFl0bE5HNjZvUG9rMkFXOVF3YzVkVGxWRDI4NVhWNkJt?=
 =?utf-8?B?YVFMS29EeGVLbnlJVFZXdFhHaDVIQjcrOTRFOFp6bGd4TmYxajQrdElBS3Zs?=
 =?utf-8?B?c2ZOdGtpRmFCbmFXZllsTkVsR3Fvd3dBWmFCK3F5VkEwVktTbzVzM1FrT0VT?=
 =?utf-8?B?YU1qd09HVDJ0azZqbUhUb0V1WUZuM1AxUDBzYXI5RFUvOEpBb2hHNVRPbmlI?=
 =?utf-8?B?akpDS3VybG9rVlF0THh2a2cyZTJjOXp2V3hjZWVac0pmQU4vaG1EY1FmMFVp?=
 =?utf-8?B?VWRTdDdab3JKL0lYdlpHTWt0VlE2aTVkRUJ5SXNlbys0UUN5RUtCKzlvbkFp?=
 =?utf-8?B?eURXMGJSK1RudXhYY0wxZmZrVkROY3NML1lIUjNWaEV2ZmpXeVVYL3ZISXQx?=
 =?utf-8?B?aE42V0cvOWZWTVJqZFBJYTBpVUVOMFF6TlNQRXBKWStTMTROWnh5NzFUYUNH?=
 =?utf-8?B?aDZIU0hRZ1I2WUhHMTZneThXVyt1WDBDK1F5UmNZaXB2WkM5T2dIcUFMWmdD?=
 =?utf-8?B?UDJockFXc2lXR1JZcmlkY05BSmxuSm5xRTZkdG45bDhWdVdaS1NrMEpPemhh?=
 =?utf-8?B?U0pGbVJvdkJITU5DVjZ1WEk1all1b3EvUGp1RWV0TG9xeEhtLzI2RGpHRnJV?=
 =?utf-8?B?a1FjaHlyd1VqekNNWUVwU1BwbmpINVpMeDkyQkNWeHlXQSs1N0RVb2pSVzNi?=
 =?utf-8?B?QUNOYzZnL2FoQ0w2Y1JwMTVRbkVSZGNBVzNnci9ySlVIUlJqVENMeW16dXpL?=
 =?utf-8?B?YTFjZ0ljb2Jra1IzQ1M5cmdxaGpteTFVUnZwZXNGQTAwdHNia2tBeFlXNlp6?=
 =?utf-8?B?RkgwNndtNXhzMUNYMnYyaXkrK1MxRnJEZ3d0bklpUnljU1J4WUZvOVpqQWZF?=
 =?utf-8?B?VldWUWxMenZDUTBsdDErWE4va09Ld2s4UVVXMjI0V0ZzK3N3bUpUb3NuSmRi?=
 =?utf-8?B?SW01elRVeEtwUUlXc0o5Tnl5OTNiWnFiOWc0V0lOMFJLRXdQc0wrbGE4OU01?=
 =?utf-8?B?WXpjY2p3cWRKRC94UkZRekxpOFBLWjlRbGI5OVRFNFhXZGZ0amdER0tHT2cv?=
 =?utf-8?B?ZDU1WGt4YzRmbThWNEw5cFZCRXU3eStNTzg0TzF0aWVNeS9xMGJIMzY4a2R0?=
 =?utf-8?B?SnJKRVRYZHhLT2tlV1hxelFCTjAxZjBMZWxQMGZ5QnlLQzU3OGRaUVVvdGh1?=
 =?utf-8?B?SVh0MG1xYncxQ2tVRlBXSmFWcytoR2FOMlhzVmlpRjlJN1l6cnFxNTBocXIw?=
 =?utf-8?B?cGNpbGFObUx3THVESmhxNnlMVXJEb0U4RnptM3gwV1ZWeGV1S3VscjRaZ2gw?=
 =?utf-8?B?L29qNG0rNWlzbk01WTBhR1N6TWN3ZXNHRVFTVkwrdWQ5eHlTWHFScTF4azd4?=
 =?utf-8?B?L1BneXlXZmc4VHFKQ3hRNjFPWkhUSFJzbkNtdm9nNGVWNHdmNGI0UDl5Y1Ny?=
 =?utf-8?B?b01HbFhuOWx0M0x2YUhYdC9ZK0E4dzIxNU1lS0UrcHpnK2FIM0RQaVlqdHY2?=
 =?utf-8?B?VGlkb2hBNlUrZ3p1ZndlckV5K2tDUC9ERTZwUU5KSW1zdjRocXdKMlRPOGxm?=
 =?utf-8?B?SXQ2RUY4aEsxVHptMmRmUDNPS2haQW9ramx0SWhQQ1NxUVl2ZGtZT3VDNysw?=
 =?utf-8?B?dDZKbFIzMFN3aUZoa09FMFE0a0xHdXR5dnVzS0VJbE9qY0NaRzJ1d1ZjSlJx?=
 =?utf-8?B?Q2ZTS1lJME41VFZ5TDhLMHJVVG1rcjhxRGh1bzBPQlFUODBaS1lFV1JvemlM?=
 =?utf-8?B?Q3NvVXlFeXBoSUJUR3R1UVljQ3Y5Z0JTT0R2OE1qTklzTzViZHdZZW9FakN5?=
 =?utf-8?B?N1NoYzJsYkhkUTJQb3NTYVFHdlk0aDlmbkZWbFFSeUw1M0NsUWNEekxHK21S?=
 =?utf-8?B?SWVkbnd0Tjg4QWpQZTNKaEdPZnRyNE5rS1BIL2pGR1QvOG1Vdkc2T0g1bHkv?=
 =?utf-8?Q?WUj8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f70af3-291e-48c5-e6b5-08dc6f6f0ea7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:56:35.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hri1YvBgtW+N8qucLSrWwTeJTPTDQ7LQK/FVRZj+xe4gqaZhpeZBCml/l2Hj/nQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

--=_MailMate_D639E333-3ACE-4732-AB37-2356431BC286_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 May 2024, at 10:48, Zi Yan wrote:

> On 8 May 2024, at 10:35, Lance Yang wrote:
>
>> On Wed, May 8, 2024 at 10:07=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:=

>>>
>>> On 8 May 2024, at 1:43, Lance Yang wrote:
>>>
>>>> On Tue, May 7, 2024 at 11:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrot=
e:
>>>>>
>>>>> On 1 May 2024, at 0:26, Lance Yang wrote:
>>>>>
>>>>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapp=
ed
>>>>>> folios, start the pagewalk first, then call split_huge_pmd_address=
()
>>>>>> to split the folio.
>>>>>>
>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>>> ---
>>>>>>  include/linux/huge_mm.h | 20 ++++++++++++++++++++
>>>>>>  mm/huge_memory.c        | 42 +++++++++++++++++++++---------------=
-----
>>>>>>  mm/rmap.c               | 24 +++++++++++++++++------
>>>>>>  3 files changed, 60 insertions(+), 26 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index c8d3ec116e29..38c4b5537715 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(vo=
id)
>>>>>>       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>>>>>>  }
>>>>>>
>>>>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned l=
ong address,
>>>>>> +                        pmd_t *pmd, bool freeze, struct folio *fo=
lio);
>>>>>> +
>>>>>> +static inline void align_huge_pmd_range(struct vm_area_struct *vm=
a,
>>>>>> +                                     unsigned long *start,
>>>>>> +                                     unsigned long *end)
>>>>>> +{
>>>>>> +     *start =3D ALIGN(*start, HPAGE_PMD_SIZE);
>>>>>> +     *end =3D ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
>>>>>> +
>>>>>> +     VM_WARN_ON_ONCE(vma->vm_start > *start);
>>>>>> +     VM_WARN_ON_ONCE(vma->vm_end < *end);
>>>>>> +}
>>>>>> +
>>>>>>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>>>
>>>>>>  static inline bool folio_test_pmd_mappable(struct folio *folio)
>>>>>> @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm=
_area_struct *vma, pmd_t *pmd,
>>>>>>               unsigned long address, bool freeze, struct folio *fo=
lio) {}
>>>>>>  static inline void split_huge_pmd_address(struct vm_area_struct *=
vma,
>>>>>>               unsigned long address, bool freeze, struct folio *fo=
lio) {}
>>>>>> +static inline void split_huge_pmd_locked(struct vm_area_struct *v=
ma,
>>>>>> +                                      unsigned long address, pmd_=
t *pmd,
>>>>>> +                                      bool freeze, struct folio *=
folio) {}
>>>>>> +static inline void align_huge_pmd_range(struct vm_area_struct *vm=
a,
>>>>>> +                                     unsigned long *start,
>>>>>> +                                     unsigned long *end) {}
>>>>>>
>>>>>>  #define split_huge_pud(__vma, __pmd, __address)      \
>>>>>>       do { } while (0)
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 8261b5669397..145505a1dd05 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct =
vm_area_struct *vma, pmd_t *pmd,
>>>>>>       pmd_populate(mm, pmd, pgtable);
>>>>>>  }
>>>>>>
>>>>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned l=
ong address,
>>>>>> +                        pmd_t *pmd, bool freeze, struct folio *fo=
lio)
>>>>>> +{
>>>>>> +     VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>>>>> +     VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>>>>> +     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>>>>> +     VM_BUG_ON(freeze && !folio);
>>>>>> +
>>>>>> +     /*
>>>>>> +      * When the caller requests to set up a migration entry, we
>>>>>> +      * require a folio to check the PMD against. Otherwise, ther=
e
>>>>>> +      * is a risk of replacing the wrong folio.
>>>>>> +      */
>>>>>> +     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>>>>> +         is_pmd_migration_entry(*pmd)) {
>>>>>> +             if (folio && folio !=3D pmd_folio(*pmd))
>>>>>> +                     return;
>>>>>> +             __split_huge_pmd_locked(vma, pmd, address, freeze);
>>>>>> +     }
>>>>>> +}
>>>>>> +
>>>>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>               unsigned long address, bool freeze, struct folio *fo=
lio)
>>>>>>  {
>>>>>> @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct=
 *vma, pmd_t *pmd,
>>>>>>                               (address & HPAGE_PMD_MASK) + HPAGE_P=
MD_SIZE);
>>>>>>       mmu_notifier_invalidate_range_start(&range);
>>>>>>       ptl =3D pmd_lock(vma->vm_mm, pmd);
>>>>>> -
>>>>>> -     /*
>>>>>> -      * If caller asks to setup a migration entry, we need a foli=
o to check
>>>>>> -      * pmd against. Otherwise we can end up replacing wrong foli=
o.
>>>>>> -      */
>>>>>> -     VM_BUG_ON(freeze && !folio);
>>>>>> -     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>>>>> -
>>>>>> -     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>>>>> -         is_pmd_migration_entry(*pmd)) {
>>>>>> -             /*
>>>>>> -              * It's safe to call pmd_page when folio is set beca=
use it's
>>>>>> -              * guaranteed that pmd is present.
>>>>>> -              */
>>>>>> -             if (folio && folio !=3D pmd_folio(*pmd))
>>>>>> -                     goto out;
>>>>>> -             __split_huge_pmd_locked(vma, pmd, range.start, freez=
e);
>>>>>> -     }
>>>>>> -
>>>>>> -out:
>>>>>> +     split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);=

>>>>>>       spin_unlock(ptl);
>>>>>>       mmu_notifier_invalidate_range_end(&range);
>>>>>>  }
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 7e2575d669a9..432601154583 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *f=
olio, struct vm_area_struct *vma,
>>>>>>       if (flags & TTU_SYNC)
>>>>>>               pvmw.flags =3D PVMW_SYNC;
>>>>>>
>>>>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
>>>>>> -             split_huge_pmd_address(vma, address, false, folio);
>>>>>> -
>>>>>>       /*
>>>>>>        * For THP, we have to assume the worse case ie pmd for inva=
lidation.
>>>>>>        * For hugetlb, it could be much worse if we need to do pud
>>>>>> @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *f=
olio, struct vm_area_struct *vma,
>>>>>>       range.end =3D vma_address_end(&pvmw);
>>>>>>       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm=
_mm,
>>>>>>                               address, range.end);
>>>>>> +     if (flags & TTU_SPLIT_HUGE_PMD)
>>>>>> +             align_huge_pmd_range(vma, &range.start, &range.end);=

>>>>>>       if (folio_test_hugetlb(folio)) {
>>>>>>               /*
>>>>>>                * If sharing is possible, start and end will be adj=
usted
>>>>>> @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *f=
olio, struct vm_area_struct *vma,
>>>>>>       mmu_notifier_invalidate_range_start(&range);
>>>>>>
>>>>>>       while (page_vma_mapped_walk(&pvmw)) {
>>>>>> -             /* Unexpected PMD-mapped THP? */
>>>>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>>>>> -
>>>>>>               /*
>>>>>>                * If the folio is in an mlock()d vma, we must not s=
wap it out.
>>>>>>                */
>>>>>> @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *=
folio, struct vm_area_struct *vma,
>>>>>>                       goto walk_done_err;
>>>>>>               }
>>>>>>
>>>>>> +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
>>>>>> +                     /*
>>>>>> +                      * We temporarily have to drop the PTL and s=
tart once
>>>>>> +                      * again from that now-PTE-mapped page table=
=2E
>>>>>> +                      */
>>>>>> +                     split_huge_pmd_locked(vma, range.start, pvmw=
=2Epmd, false,
>>>>>> +                                           folio);
>>>>>
>>>>> Just in case you might miss here, since you will no longer align
>>>>> range.start as Baolin mentioned in another email and you have a VM_=
WARN_ONCE
>>>>> in split_huge_pmd_locked(), you will need to align the input addres=
s now.
>>>>
>>>> Thanks for bringing that up!
>>>>
>>>> I do miss the alignment here when I decide to no longer align range.=
start
>>>> in another email - thanks!
>>>>
>>> No problem.
>>>
>>>> Zi, could I move the alignment here?
>>>> IIUC, we will not encounter a partially mapped THP here, and range.s=
tart
>>>> and range.end should also not beyond the VMA limits.
>>>>
>>>>                      align_huge_pmd_range(vma, &range.start, &range.=
end);
>>>>                      split_huge_pmd_locked(vma, range.start, pvmw.pm=
d, false,
>>>>                                            folio);
>>>
>>> I think you can just do
>>>
>>> split_huge_pmd_locked(vma, ALIGN(range.start, HPAGE_PMD_SIZE), pvmw.p=
md, false, folio);
>>>
>>> since range will later be used by mmu_notifier_invalidate_range_end()=
 and changing
>>> it might cause secondary TLB invalidation issues.
>>
>> Ok, makes sense to me - thanks!
>>
>> But we probably cannot use the HPAGE_PMD_SIZE here; it will cause
>> broken compilation as seen in v3[1].
>>
>> Perhaps we still need to add a new alignment function for the huge PMD=
?
>>
>> [1] https://lore.kernel.org/linux-mm/20240429202040.187453-1-sj@kernel=
=2Eorg/
>>
>> Thanks again for the review!
>>
> Or you can adjust the alignment inside split_huge_pmd_locked(), since i=
t can
> be called other than __split_huge_pmd().
>
> Hmm, I notice that split_huge_pmd_address() has mmu_notifier ops but yo=
ur
> split_huge_pmd_locked() does not include them, I wonder if that could c=
ause
> issues with mmu_notifier issues. Adding mmu_notifier people to confirm.=


Hi Alistair and Jason,

Lance is improving try_to_unmap_one() to support unmapping PMD THP as a w=
hole,
so he moves split_huge_pmd_address() inside while (page_vma_mapped_walk(&=
pvmw))
and after mmu_notifier_invalidate_range_start() as split_huge_pmd_locked(=
)
and does not include the mmu notifier ops inside split_huge_pmd_address()=
=2E
I wonder if that could cause issues, since the mmu_notifier_invalidate_ra=
nge_start()
before the while loop only has range of the original address and
split huge pmd can affect the entire PMD address range and these two rang=
es
might not be the same.

--
Best Regards,
Yan, Zi

--=_MailMate_D639E333-3ACE-4732-AB37-2356431BC286_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY7kqIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUewsQAKiJmfQ/yYr0Dd9wssDIjT9zYeyhZfMjofXV
jH9uuXfP/1qL4hwbb9tXA0w+TZQMtelOCNOGhsnLGC3dZZ6vH9wdMTnCe9WRun3x
geORhXX9mkcszfO31bn3ekqiPx0JONzTtadDy27LHIwXxFIF6v1lJxBnJOa0yray
atEwaAe9k4RmyDwtSFGHNXsUdkW+cphLiEDCFhOMMl/tGkGjSSNmgsr/+pmM4mXf
e2/MzIioVjEBBBF0EvIiV+FS3Qq86JsnR2pKcqBeOAkBq/CHNaNrqyqi91TJYKwz
XrWe1veFqnbOhBUkkeE44uuryMpy6XZB/ZvBC3RBHih7f9l1JJiSLwxXE4jYSS6Q
PECJrue5ZTUuN0gVferEtuverPvat3Fn42vX0QLzUdx5sXgmS2t2eqs75XhTy7BJ
n6wsshHWJX3iCWiLbZIOGS+Ay1volxawwkSTCldYGBbIqMvzZINXz3O8DKsSFYUQ
6EgXVTvzbU49aU+Iqfu78AyNNotOQTZ8sQBF/BPzS95uh3inS3CTgl3+JjB9qJ7j
wxHQSu1/GNEDPz3d/tpdnPEELL1OPlU2s99QCKpz+jrBj1rv1FtUf1pn79fyfChb
RPpFnAaOVyAwt+ttq4oVVw1W/ZDaCL8cCm1F11B6tlFMPOcTzxjp/+r5Spvj3diG
c38dCxcH
=1KK7
-----END PGP SIGNATURE-----

--=_MailMate_D639E333-3ACE-4732-AB37-2356431BC286_=--

