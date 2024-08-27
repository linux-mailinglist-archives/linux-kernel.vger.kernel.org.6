Return-Path: <linux-kernel+bounces-302469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DE95FF13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F542B21C35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADC168DC;
	Tue, 27 Aug 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="noLlCLOI"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010007.outbound.protection.outlook.com [52.101.128.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5C16419
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725761; cv=fail; b=j7EcDzOVyT6WZyf6Tqud1ERFTO0uapje4jndTruRP+JNhmWwJqwZAXRnONGrrAK3IXCJ5S2A/Gp8CvS7dUAYxiK+MKo7VCy5UXMS+HRjhjhcBzhDpWIvgeFDvBXl838x+w8jeRxqKsr6YFWWe9VQ6zIHBdG6HlMGypUz2I8sQFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725761; c=relaxed/simple;
	bh=xNpaSBnP4Ts8bzhSI1sCStbg4FpG4z0pdxzgFBckX8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGOEtd/JvDpqAePMUcqH+Wp3JbkQQgQHrPJl5zceM4cOklVE80xWy3AvlKA8WB1RuSZHg3BUxZaQbdqSFbGHivt03S/+BrM9Ry2UJ7RKDgpGPPxPrXa9MPLJJN610fOYaux//wancNDY3uKRK3MMCSCpKh7k2/3DKRUmBTe/hRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=noLlCLOI; arc=fail smtp.client-ip=52.101.128.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBYSLYvJ5rAlqBCJvLg/PaV+4CjDHMxQ0YITX+EQneEBwKGYprGtMHoT6LR1muRhvRoTrFHlYYTCizl/PsXcMbcaD5/fbSWMKALH505RKGCiKFwk2ye19lIXtJyQwXoWFG/6lpV+d5DAMpWIckfK2SzDxr3Q32LVyQQrb2R7norZ2GE3m4LMMWjaOiD3z0aD2OrRdAzT97S2GX06wl8QvUK2NUilbNJcwqs4JpGLxVnsMig5OjxXJhYErFYZJJnj8+u7l24VzZvaKAVwUJZ7gsJCiJdpK7984d0hYqdFHBRtRn5/egpTpS+tyCdb2giQEyZq0ss65pkimV3jMr3+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNpaSBnP4Ts8bzhSI1sCStbg4FpG4z0pdxzgFBckX8Y=;
 b=uHpZ+/rGVzM5sK2bveA9OvYjn9LfQrtStrN0Vwr7dO0iT82CgqhiJYZHbxAAR0UMdRCxieoVcwJksbpvl7gimjJKqoHVCDBH84HCSh9o7Tj0B6Z1W1jwpYMx6zwwBc6BQttDzeSlVtOso2YXHm4BUVVqtTuA+5mJb1UXpgGlc5+vHN+UYKrGrzsWR5jubhrQDg+i4I1CtXkYCRhcMj/IMAZzIoTaQWKvwBOJbyex8OItG0iu6TRXhUqEMfOOLJPwcZFGNJQb6u5JepjLn+3SChTce9+zMXZu7Cn4xJrYnw235cTPOUOfr1uUATJuTikUiQ9XyCqowkTq3RM8gjWfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNpaSBnP4Ts8bzhSI1sCStbg4FpG4z0pdxzgFBckX8Y=;
 b=noLlCLOIT8m4zoCFHhKSZGMMiL6BznezXbMmrE+1DzCR5MI/XZ/cJ3vu1z5/yRwEH9fs+xFipDLiN1jcQKTclkvLBNqLfdjuOkF6o8wQz2S+nmBuJg9tbkxjfHLzJI6LJ7HpXlDZ77Yhm51kOf1GIKSHZ0ZC3Kh3ZsHndWvxIQ8=
Received: from SG2PR02CA0042.apcprd02.prod.outlook.com (2603:1096:3:18::30) by
 SEZPR02MB6614.apcprd02.prod.outlook.com (2603:1096:101:19d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Tue, 27 Aug 2024 02:29:13 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::f9) by SG2PR02CA0042.outlook.office365.com
 (2603:1096:3:18::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 27 Aug 2024 02:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 02:29:13 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 10:29:11 +0800
Date: Tue, 27 Aug 2024 10:29:11 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: Lokesh Gidra <lokeshgidra@google.com>, Suren Baghdasaryan
	<surenb@google.com>, Nicolas Geoffray <ngeoffray@google.com>, Michal Hocko
	<mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li
	<shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
	<fengbaopeng@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
Message-ID: <20240827022911.bcje3ofucegg6vjl@oppo.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
 <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
 <20240827021351.iq6i7zkwm32xili3@oppo.com>
 <CAGsJ_4wUrm1Q7Oxb5BHC2ypyf4wAH+UO9KYhCUwsEbhkcc7QGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wUrm1Q7Oxb5BHC2ypyf4wAH+UO9KYhCUwsEbhkcc7QGg@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR02MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba27a6c-794f-4d50-23e4-08dcc6400a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnFKSzJ2Wks2K3A0a0M4U3RlMW5qRUdVNkcrWm1KY0RKUWlMdjNTYkEvd2dz?=
 =?utf-8?B?UFRTdnZDblFTcTBLeWpBYzVadFQwamFmVmEvdHhQSTYvRms5bDlrRGE4bTB3?=
 =?utf-8?B?OHE2dlpSYVI5ZjZFVzF6dmUxaDJmOHFyeGdIUGw4Uzk3R2IrM2hkVXNkWlN0?=
 =?utf-8?B?cStRTXJNNGRlWEs1WlZ1QkhyT2N2L3BmOWdKcmVvc1FTMGdRc0swWkFPN0RG?=
 =?utf-8?B?MzhkdlZPZkU5bjc0aEQ0TUtISlZSckRXYWhQUWZmRGlESTlDL1pNSEFMWXpx?=
 =?utf-8?B?eEwybzA4V1VhSXN4b1hhSlZRcjJicW0vZHpHZUpsS2sxMXVzUy95aVRvNmpZ?=
 =?utf-8?B?Zm11VzVNek52R1hRUG9UWTJPcm5VelJFOVJacmpVQ2U4Yi9TZHc3di9VQ1ls?=
 =?utf-8?B?MGM1OVFPQWhkTXA2dzdZUFh4SlIzbHZKV2greVpVanRqcUs0bCtQak43a2Y4?=
 =?utf-8?B?a2JsSFF4QXFrcTdDbFoyeHNKNHhvYTJwVE5IcklRaGdWdi92aGZwc0NlamY0?=
 =?utf-8?B?SzVwZGNIN1RJZ01qUTlReXNGVzhvVmJwZytqeEZ4SzZ3di9Wc3hwWTZyWVpX?=
 =?utf-8?B?K2FEa0FLa0gwc2l5aTV3ZGZ4ZjlhZXZlTW9PWGRxRkR6WmF5bGd0eEpPenNx?=
 =?utf-8?B?ZXRDWEsyYkxrdzJXRkx3M1o3U1h3L3VocFAwcTNJWS9neVU4elcxV1NSWkFq?=
 =?utf-8?B?YUdKKzVEZlpmNllReUMzTjVyUThmMFlmeVVnRmcvQVN3THNvVW9qT3FWYjNQ?=
 =?utf-8?B?L1FSNmJsaE9hc002ZG1HZlMxK3ZiMTJ5YXl4SUJJN1pJVXhyLytUdmdPLzZi?=
 =?utf-8?B?TWlJalJzWE0rM0FPa1oweHZlRGdndWZLMXAxZWRpOGVRM2cyUCtQOFRWS0cy?=
 =?utf-8?B?SDV2K0pRemVqTityN1ppVmNnajZ6OCtySlNqN2ZOU0pqVUZ1Sy9ZdkljS2FE?=
 =?utf-8?B?Yjk1L29KVTRHeUF6dUV1UHUxZURWcDVrVjZRMVd6eithUm5iNUpVNGxabEFK?=
 =?utf-8?B?Mis5dE5pZ2tTaTlCVE9GcU1ObDV6WGlpbER1TW1FcG9xTG1GajlIdmx1Q28r?=
 =?utf-8?B?Wm1MbGl5ZVhzbE5rLzgvdEN0NmlpNEdKVy9wcjZ2WmJGL3hOSVBSRzgvdHUv?=
 =?utf-8?B?YzNkbkJHTkluRS9hK2pBWEJ2RE1SUTB1amwzeEpNVFErMnlkSDdLT1BFSHNL?=
 =?utf-8?B?TmhSMkpzTTZuZnVsUVNCamdTSkVlWjZmYmpnQkVjcVlhb01TNGZPZXg3cGVR?=
 =?utf-8?B?RzNNQVpoSmMzY1ZBTm4xaVI3VUtneVA1OThsUjladVc2dWJWY1NGVDRKTURN?=
 =?utf-8?B?VkJKdEtFdUk2QWl1elNrVGNKUEF2d1g4TDRLdmNQSEt1T3dBNjAyQWU0WFRM?=
 =?utf-8?B?Q29rNml1dUR3SjhGazdEeFJ1TmQ4d0tITUhxelM3WUV6QkpDcW1RdW85NU5S?=
 =?utf-8?B?eVFlNEVnME1Vc1dOaGY1UWFNR1U1ZzlRYmVFSlhoSXVaUmd5M3VmcTNMYW9F?=
 =?utf-8?B?NE1iZmhtNmxpTEUxVFJPZjQ1b0VBVWRaU3VseS8weFZCNUJVeDFUS0gyTjVn?=
 =?utf-8?B?QjZtWk1BSjNHa2RDZUpJTWtTS1MreXNjZ0FVdTl2ZDNqWEdnb3FwR3NNTTM4?=
 =?utf-8?B?WUFIRnFrY1ZsQjhOYzNMeW53Q3IwY2kyWitMeUdHeHI4ZzJJODhHbTRWZlFR?=
 =?utf-8?B?ZTQ5ZkRzdmdDQWQ0bi9QRmxTWk1FM0Zsd2ZDS3AzekF4KzAxWjlpTmg2anhz?=
 =?utf-8?B?SHVvUzRGa3h1d093Z2RDVnVYTFpwSmRCbGdVMHREWGtoUHBMeVZqMjBnVkxP?=
 =?utf-8?B?am1JNWoySEVQV3g4b3djK2pYVEZpNXNpeElRQ2h0bmoxaGR0VU1hS0RMcnFq?=
 =?utf-8?B?WDVUNjJhcHlXYUxWaHBGZDgwaXA3a3dwV0YyRXg2UGQ1dk9Ba3NMSEh1aW10?=
 =?utf-8?Q?nDRN9jwEF+8NT96EgSaQ9ZMOMOnWpfMA?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:29:13.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba27a6c-794f-4d50-23e4-08dcc6400a69
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6614

On Tue, 27. Aug 14:18, Barry Song wrote:
> On Tue, Aug 27, 2024 at 2:13 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> >
> > On Mon, 26. Aug 09:37, Lokesh Gidra wrote:
> > >
> > > IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> > > prioritized for reclamation over file ones.
> >
> >
> > > >
> > > > Adding Lokesh.
> > > > Lokesh, could you please comment on the reasoning behind the above
> > > > mentioned change?
> > >
> > > Adding Nicolas as well, in case he wants to add something.
> > IMHO, lruvec_add_folio is enough. if lruvec_add_folio_tail why not use
> > MADV_DONTNEED instead? In MM the reclaim policy prefer to reclaim file cache, if
> > MADV_FREE'd pages directly add to the tail, they might be reclaimed instantly.
> > Also the benefit of workingset_refault_file cannot be convinced for me.
>
> My understanding is that MADV_DONTNEED will immediately free the memory,
> whereas MADV_FREE will release memory only under memory pressure. If
> memory pressure is low, the anonymous memory may still be gotten back
> without causing page faults. This might be what Lokesh is aiming to achieve.
>
Hmm, IIUC, for the reason of watermark, the kswapd would do reclamation without
memory pressure. I worried here is that the madv_free'd pages reclaimed too fast
if add to tail.
> >
> > So we should know the reasons and the benefits of the changes. page faults or ?
> > > >
> > > > >
> > > > > >
> > > > > > --
> > > > > > Michal Hocko
> > > > > > SUSE Labs
> > > > > >
> > > > >
>
> Thanks
> Barry

--

Help you, Help me,
Hailong.

