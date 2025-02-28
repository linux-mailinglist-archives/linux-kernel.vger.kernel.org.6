Return-Path: <linux-kernel+bounces-539006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDCA49FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CB83A97C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132361A8F9E;
	Fri, 28 Feb 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ehZ6YYm2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B54271824
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762358; cv=fail; b=TX76RkNsiyK+PvuzYD9Vg2xdVTTS/ymp0IaumK4klO9JYh3+9QZ+MdLmRrULPixaWWTQd8CU/teL0EuTj9kw1DzLKgN0hrD9EerAH1WF7Ix9nl/is4oeZti13/l2d1FVZvOYSRvasbzTPymCqWGU/fVFD05Fi8vZRN/Yy3e8g/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762358; c=relaxed/simple;
	bh=gB0XI303QPRt7eX9QBk5Yxt9BXaELdfoTK/kFO5ye/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oys2uumQujmKXAr57Q4coUk7Zx7X5RRa8Wf8vC6oXv6RLyklIADs3tThHMuwvYmB3e18RLRiWkbTembmd+H2Qh+6mxWwmIagCSJca6rUofZ+YKiCJjfvp6OF0EEjjspEZk54GutIMPTwK44kesASZ0gnr5j372oBIIj5mR39aec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ehZ6YYm2; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtEgcx8rbnffXlf1jznt58ez62ebo6srKWTcWuG6VJK//2hn4hikoyJ4ymGbH2ergXfXWU7ch/x2LNLDE2YsYLbpSyZcqjLZxJckU9da+DATUXfDOGNTOaiEtG0XPlpiASf4JrU5S7CyZxGxpnbXZSi2P02WzxeO/3Nd2ww0dtnldemLkGVtdFQCln6+HmSe4yfX9cMw2CGZ6ILw86RbI3quvevEDTB6G5LhAhTfSzXaxiz+pf3itgI4zRYBLsXNEMk4nLxXqoa2dP2WM0OvLzU8pPj6dDKRGtWAfWjPc8lJ2gkl5MT5rMh+NgHlitgHdr6Qd06z0jXqcN/Ggi4vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1ajFW+ozIB8310lbmOS4snt1FDs/GCeOkFiyaXLrys=;
 b=ADw2CaD4hSNpM2s+HoFdAes9TOY69rjoE6Eijw9iJv/lVk5WSxrkw+bgt0PNiNNlijCaNkdxrxm6o6dIEfMt63+nYrj+nK0NFY5DF5eJ3IrW3sqDuGL8TSk1Y33JJcv7BqkkX8gnXLAWmd26SRkf9s0eolAEC8fIvX4qm7ZippOcRqmS6Qwyitl+jU4hS80MQOwtHxOQVU2Vuy9Hyl92FoZXwcsAMVpXLZY10wnPWJ4Irk4t0I/oYIQbWCfhO2fSmSBoACsXqkFEjsBhxelRX/Vvb6qerXmVMDasyzeylErFFNeNj9Bzt2KexoFpd5iy9j++4IhWrTNu3W2xkhB5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1ajFW+ozIB8310lbmOS4snt1FDs/GCeOkFiyaXLrys=;
 b=ehZ6YYm2Z+IlZ8vucRcJy/Hifw/Xb0eSpJCBjMFwWgKz8xcYxUeJ7ElYQoHndTqcM3cvbq2DDRiekqXJJVsU+7J8OCsgVSxd22cPcUAZ5PDr08V263Ths/HgOWcZ9zpLZlWlaTmr7iUgcAkHDW6IuBDeGpo+K+PWz56d9KjMcSqFPdvV0II72++G9rQRR64KIkwKjUcsimhGHOzGGa2pYHs2gKbwvmt38LGbPBqpiwp6hfqO+KXYoMc81p2lQ9jZdh2IUi/Zx0MRk1NK/hgICsgrDSd6L0oRoe8huRWdqHniEWNINtTBO8ZRL4/Xu7IRW2ZBSkhGut7M7Pai73485w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Fri, 28 Feb 2025 17:05:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:05:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix shmem xarray update during migration
Date: Fri, 28 Feb 2025 12:05:49 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <BBC5BC50-C32A-4609-A235-AFB0ADA30B52@nvidia.com>
In-Reply-To: <Z8HlvyKod4pbi6le@casper.infradead.org>
References: <20250228154219.2214149-1-ziy@nvidia.com>
 <Z8HlvyKod4pbi6le@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:208:23b::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ead7a6a-d6ff-4162-534d-08dd581a2811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjRVSCtjaFQyYTFWMXM5TDlTbTlvNGlCQWczRjRBTklMSVlOUFhzWEJLSG5u?=
 =?utf-8?B?T0VNdEtyNCt0N3diTVdSdTE5dndFbHVOSUo0UExFQzhBZThpM2hENDRRTTN6?=
 =?utf-8?B?SHE4REVzVm5lbi9LYlJVekU3a1krREdRR1g5UVZ3V0xKNEt1ZjBVNHFaNDc5?=
 =?utf-8?B?U3RtT29MWlRGZVFYWis3anhPTXlRY1JGVEpwYmRzOCt3c1JEakFWNXJ5VzJw?=
 =?utf-8?B?OUV4U0hLclBnYXlLalcvMFdlQk9McXZxM3NONVJ6Y2F5TGN5MmZDK1FTQWVs?=
 =?utf-8?B?cXpQWGVha0xCTE5SZ2E5UmFCSGNvcXlmOWQxTTJVWE9TQjBMT0plNEEvTDBJ?=
 =?utf-8?B?ZjNQY1BmUC9iVjBwY1ZtRVY0T2gzSFgwdmlUcGltNmJxMWxWdlYxSWpXUlo3?=
 =?utf-8?B?NmoxenVEMEozRjFhK0g0eTRIMWRBek1hdURPLzhaV2RmMTFBeGppTWdONGxS?=
 =?utf-8?B?cUpsZU5yYXh2OEdTRUQvb0lZMFY1M1VDQVc2cTdLVEtCdWVGTGUvMFNOVVVI?=
 =?utf-8?B?RHZEOVpRSTFoOG9PU0F6RTRpeFNiYnREOElnejNETEpxQ2cxUnFlbTUxQTFo?=
 =?utf-8?B?OGtaVE1KMXNIbXZtYnNab0pidUtXZFVwU0N2T0lGL0MrRjhqZjcvR1FGNGsw?=
 =?utf-8?B?OUZPZm05SDN3QnlDQ0t3ZHR0MU9HT3BTSXNaQ0xRd2FEWnY1Y1VQdENBY0Ny?=
 =?utf-8?B?ZVVkTi9haUlaL1FSc0VhSlVKT0sxdTMyVTE1bE5QcWVmSTBkZ0xpRnovTU9h?=
 =?utf-8?B?aUsrY3JGRmdGc0ZYN1JjRzNEZ1dnMUx4MjZJTnkwUVdkTWx2MWllSmhSZ2FL?=
 =?utf-8?B?Q0kzaC9vT2Vsb1Qxdkdhb1gyS3F6MDhRcTcyWGVKbUMwV21DQ29CWkprYVpy?=
 =?utf-8?B?YXRud0M2WWpqTDgyUlQwa0llNUtvVUU2M2xpZExwWjhUSkE5dFRkTXFGcFAz?=
 =?utf-8?B?Ymx0VHVUWkhEdXJ3RmZZbmdyOXdYNHQySmNXeWpFT3lxSFZIazVDaG9qTmcv?=
 =?utf-8?B?dW0yZ0I1NU5GaS9NbVJaTHNQTmpFMEI5TFJNV0JiTEJtWkdwMVAyRTUvbEk1?=
 =?utf-8?B?VEdPeVdJU0p6TFYxQnhQQ29VMTFGamV3ck8zMG5CMWI3Ym9kWmdLOXRKUDVT?=
 =?utf-8?B?OTFFUzY2MEtDYWJCc1lWTm81L1VOQk1lWXpHWmhIeVJwUVU4SEVFRklNODV3?=
 =?utf-8?B?Unpwdk44ei9HT2tyQ1grcEZJN2VnenRMNWw0a2o4S1hrZHQ0aStBTy8renVB?=
 =?utf-8?B?S2s3d3NEeUprSm5mbSttbVo5eTZCeGZMTk5CcFFvcGhybm5JeTV6RUxtL1k5?=
 =?utf-8?B?Umc1Mis0WTNnb1pLQi9WMjBBdFdhSmErM2lCa3ZHZXNScDFkYjNjRWtDeTRr?=
 =?utf-8?B?WWZqR0Z3Ri9nVHJOZ01naVZJcHpKNnF2OFFFVUJ1SitLYUxxM3BNVGJKT3Qv?=
 =?utf-8?B?VHN3UEpNSGRuZjlXRHJDeWdaY1RXUXI1a1AxdllqQ2ViZ20ra1VwZjROUmpm?=
 =?utf-8?B?RjRTdWZkMlhabXRzcDVSK1lWbE5VNVFscFZkQm9kS01JbTA4cjBzemJRY3Fw?=
 =?utf-8?B?OUlpdEM3NTJocWNLYjEwc2YwL1gxcWFWN3B3Lzl0NmFaQTc5U3hES3pRVEJx?=
 =?utf-8?B?MXRWOS83NFRmKzVOT0Y1dmVQUHZ0bkt1Q0N2TlQ1MndRVU1LMHlqM3ErRHJU?=
 =?utf-8?B?OUNxNEJPbDBEcjJ4SHpZeEMxc25hZXhXb2NUT1FLbjVBbjdPRGk5RmpUd3px?=
 =?utf-8?B?VkFJUy9NZkhJeXFoYUZ5Y3FmTjVyK3RpdytoMEY2Mk5uYmw2SzU5cm5NZUJK?=
 =?utf-8?B?VnU4U0F5MGxOcURaZnowUVkyd2I1ZDRFWW1tenAvWE9jWE1IZVdhcmh1cldP?=
 =?utf-8?Q?a01OeepdPIo31?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJ4TGZ0d1pud2RWQTNvTWh0KzJYMElheFIxMDFWOGlOUWFDMzdvVTl0bHVx?=
 =?utf-8?B?UlBDazA4K1pWMExhaGszK0hGSGZTMXlROExxc0pDSVlWRm81L2NrZ08rMklG?=
 =?utf-8?B?T0NFL25IbHU2K2lsOVZzV2g2YjNHQktWbU9hZ2JhUHdNRHZodThaT0VjSlNH?=
 =?utf-8?B?aGNWMkNLalljV3B1ZWY0TTVJYWFYVytEVUZPaXVsaXI5WUxENWE0bjlESjR2?=
 =?utf-8?B?UXBYTVNrWGdaYnFhY085aTRIRjVwUVdtSnE1QnhkYytjd0FIbUxhL1c4bzJn?=
 =?utf-8?B?aTIwd1g2QzNWY3lORUVtRkRVUndaVTVHRWJra1Q0aFYyemxacFBkV0hwUmdO?=
 =?utf-8?B?STVYNTBhWTBwTkhMSEExNGNrQkR3ZlF0WHl6L1ZZZW8ydnkrSjZIbnV6YnQ2?=
 =?utf-8?B?WXJUV1F1T2daV1N3RmpuZ1JTeVd4REdCZjRIVzNleGw5MCtiZkV1NHBPYmI3?=
 =?utf-8?B?di9wbGc3QXppWGVGdmxmUGRSN3g2dnZnemkzR2lwZVhqL0VZQ2gxVDhnK0tj?=
 =?utf-8?B?Q2hqd1c2YjNLWXpMMFIzeVA4dWxOYlk5dVVpTHQ1QkVaZDFPTVdWZEJHSG1K?=
 =?utf-8?B?YXZEekFKaDkwUW9uYmNjcm9LeXZ0UGZmQTFEbmJmZEFUZWd4SFJtQ21TbGd6?=
 =?utf-8?B?TElxTTdCR1VZVWp4MUNHRDFyNUtvSklSRzMzeldHUGhTNkJjdkpBVThpT0Zm?=
 =?utf-8?B?K29mRU05cjNDT3o1VjVYQitPbWMyaWtVdjYzc1c5Y0RtV2trZ2lkTXp3dW8r?=
 =?utf-8?B?MUp6MStnSHhWNXV6WWhoSHhLVUU5K3VnSWg4WEJubW5kQ0lZNjFqZEMzcmVE?=
 =?utf-8?B?a095MmQza2JpM082emRmN0JQUitnM1lRVkx6TTNaaldweDh4L2syWWZvNlNn?=
 =?utf-8?B?cnBwZTR6bDB5L25GTDJrUWRmd0RGbzdHM2JZc29RQlNnaTFHaFBaL1VjWWdR?=
 =?utf-8?B?VzlYWlFNL2hLajF6V2dFcmVhVFVkZGluTmxNYnZBV0JvUGNLVGhpN2dLcGVu?=
 =?utf-8?B?UkdwWWZOMmVtb0Z6dzZUZk9hZ1Q2Rk4rdStsRFhzclNOYmk0S2Z4MCtnRDhm?=
 =?utf-8?B?d0VZKzdKUk02eDRqSkY2UHVvQVdyVktIaGVBTFJydWRhVU5qalQ3U25nTTZB?=
 =?utf-8?B?QTdJUTQ1dU5PZmJoa1pjNGhlRGJHTGJxWkNMdkhMM1IvR1kwNHh4cFdVUEFa?=
 =?utf-8?B?V1BQTFJsZXFZdThqMlF0TWZoTjJIc1hXbktVMUlMOVozaDUyMTBlRGFSeENI?=
 =?utf-8?B?UEY2cWFSdHVYVXlldkRCamF4K21yT1BWR2NSYU5EaWtGWFBWN2JNSkhFNUtB?=
 =?utf-8?B?aUNuUlV1YWxLT0E2RmExN3ExQzVaZkZlMHdhb05zVmpTbXJ3TThvNzZ2QTFo?=
 =?utf-8?B?SHE5N1pza1dVK0U3NHZ5MGZFNC9nOVovNjJlQ0NkU25qdlNHYVFnYmpNUW5s?=
 =?utf-8?B?NlBmd0JHZm1MdHdNK3VZajNzdHJkeitNc3RvQkFZdlJaRURrTXFjR2hEbmww?=
 =?utf-8?B?WEZqYUVDQnZRRlV4UGd1SjhmWGR4QmFBZkdRTml5RmJRWEtqTEdhWVNSNjZE?=
 =?utf-8?B?cVI4ZGowU2VTT0tpOEtSK1J0VDNyYlZkdVZZeVNwZUQ1Vks2T2tNOUExdzVW?=
 =?utf-8?B?UnFXaURLNDNuQzBSaXBqWnR3aXIrQ1hoWWc0S1BOK25hV1B3VjJiQ1VzWS9w?=
 =?utf-8?B?TkZZT2IwWW1YNDh4aDdnK1NNR3U4VmlrQlZqaTgxVWZRQ25zazh0MkZJbnQw?=
 =?utf-8?B?Q1U3azF4SFhCeEMrK3lGUTR1ZWt6SnE1M1Y5YytRdWNUcVAzYlNRL2w2VDF2?=
 =?utf-8?B?RDdFdXFNODNVcm5hek9DbTF5N0FpcFpJMmN3N21McmVONzNQZ3BkSmpibktT?=
 =?utf-8?B?MFZuN1NSS0dXSDZScVR2M1lzalVDdHJQS2Rnc1FUVXNmakZuWHBwVitoa1ZF?=
 =?utf-8?B?dU92SVRpeXBCbmtMYW1sZno2T3RRMmRTS1F6K3d5UU00QXBYSUNCTnpjczgx?=
 =?utf-8?B?Wm5HNGRnb3RSMTBaM1B4RWtHRGlxQm9rWHdXZ2tHM201Yk0yWnU1Tmg5VzFS?=
 =?utf-8?B?MjRvYThrcWJWZlBjb3pFaEZwZzRuV0dxUFRQZ04xRlZVbVAyNjZiSVZJWC9S?=
 =?utf-8?Q?5EWU27OXY1zGU9J3g3CfSEOPI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ead7a6a-d6ff-4162-534d-08dd581a2811
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:05:52.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG7c+LLfZcdvrESNBo6wRcEzg8Pc1/DrzFCwjGkwNNoadduNcSNNIOYKuWQRwPc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

On 28 Feb 2025, at 11:35, Matthew Wilcox wrote:

> On Fri, Feb 28, 2025 at 10:42:19AM -0500, Zi Yan wrote:
>> @@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
>>  			folio_set_swapcache(newfolio);
>>  			newfolio->private =3D folio_get_private(folio);
>>  		}
>> -		entries =3D nr;
>> +		/* shmem uses high-order entry */
>> +		if (shmem_mapping(mapping))
>
> It's be cheaper to check folio_test_anon() here, right?

Yes and it gets rid of the new include. Let me send v2.

>
> Also, how did this bug remain unnoticed for almost 4 years?
> Our testing is terrible ;-(

Probably not 4 years. Before fc346d0a70a1 (2023), shmem was right,
swap cache was wrong. After fc346d0a70a1, shmem is wrong, swap cache
is right. And before Baolin=E2=80=99s patch, shmem only has PMD size folio
to use multi-index entries. Maybe getting PMD size folio is
really impossible when compaction runs a lot?

>
>> +			entries =3D 1;
>> +		else
>> +			entries =3D nr;
>>  	} else {
>>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>>  		entries =3D 1;
>> --=20
>> 2.47.2
>>


Best Regards,
Yan, Zi

