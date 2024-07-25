Return-Path: <linux-kernel+bounces-262020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F393BF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6761F24245
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F319885B;
	Thu, 25 Jul 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="cLejENe2"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2079.outbound.protection.outlook.com [40.107.117.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4F172BD8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901518; cv=fail; b=eY8VF4Gj6j5t3DSXkQz0A4tEckfZK/ZwlKyMIGcCy7EgGQw5uDzuM48osXnIXEbnu2W5bcRzo1jEr1Mivm+dZ1eB4A3AUxOZLopfKc/VKoKWNwP9Mox1hPHWxc+QXHLy1mDRpZ6kTgTEfZD8/U//yuk3BEdihdxDksiHMHGcQaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901518; c=relaxed/simple;
	bh=hOXGz/KwwZRY4jpkun+cnC3/OdYxqBStnoCFubQibOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIdtLXTEaylxJD+Qd4OJbRnT/NPlO2uMhFaSWqDJxhm0JuWlU6nde5SO6uh0imiLZulB2yTueGg2qmIQQeacNEoHwOCoJfBbHeDbO0sKq/GnWbd2k6h+WYh4jSeaKIqWrnROViGGsW7XfeHczzldfmygQQ3xUxHdVwtXVr/xt9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=cLejENe2; arc=fail smtp.client-ip=40.107.117.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHVuTS2Wc5QhLNLc1Fbe013B/aX7XkxlIz5zzr7n79gBjeQDAz+s2w99lunOrwZs1Zr/vctE5pJBo+BXgWdWADFNGOVyRilxBxd5r61eKAHSI4QWixgnY2wRfsgjWYA0BGgSjS0mu9cTGMIn0ENq+jjwuB3A8QkpTlbWTHZKP0REN2NXeRma0vrZgwNyArG+aPcmBnHfZMIUgBXz7LzUiZ2+hZ+wLYpfQMZT6jj0ksMHJ755GrULG64Np/MdpxL/j3jJAHtC9+8IBMy+LaqTBxNPVm7zbzUrfHDnSAgKhUnlypEcPEWM8bspa/gJw6zu5QPgif33YfOZBaZo33DikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdw3XeSmlKbLmlYSngEMzuXoI+GDyvubrZYsGwNLeWY=;
 b=h35bhgYk4hsFzsPIxHRMKwpapRCcIE6rfBTIbVtZGdCz9oizBD4F3Dkwaba6lJh0eT+Tqq4zZA6zrb6e5lyvu1UHstyaTMQAP2p0e9E1vuWzu9v0SUSJDbMMSXUjFOaATzr16LaFrww5MtlEcLXdYt0c15oLwyko5SLRPoL8/dJsK1aEtiuqoGvRn2rwrRa900d1aGZ6gx4Xh0RiDUflxK7rOjKsv9Erb3tb/tbGh9NhH+Q3zTrD9o2hikVWmESysWGYjRMq00xg1QdA6JPxuF2/mywziJp7UJRLaB2RwiQ+bQ22ICO4GElQwxlkEZtW1hFSP0loV5gTy8CkqpJIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdw3XeSmlKbLmlYSngEMzuXoI+GDyvubrZYsGwNLeWY=;
 b=cLejENe21wYbl4UnSaS6Y1Baqgu+4zQdwrvq6HQCWA3RpRi/sF+7ln0kNrcSsd1HCP2DIlN/dlr71V15VmOpfS3qhapPyK9F7Vbiv2LA3dGh425A6OG2VNF8jdHB3xrzhh4AxSWOXO4gkW7jhUDvucw7KfgOR4WJGPWoFxqVJ18=
Received: from SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32) by
 TYSPR02MB8005.apcprd02.prod.outlook.com (2603:1096:405:8c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Thu, 25 Jul 2024 09:58:33 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:4:be:cafe::e9) by SG3P274CA0020.outlook.office365.com
 (2603:1096:4:be::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 09:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 09:58:32 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 17:58:31 +0800
Date: Thu, 25 Jul 2024 17:58:26 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, "Tangquan . Zheng" <zhengtangquan@oppo.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240725095826.pqt4shyiw6odgcem@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <CAGsJ_4zWsh50Pzp0ntskT=eyfStALxD5BMNdWFrYJewrrx7V5Q@mail.gmail.com>
 <20240725091703.tsjpgltwgu3jwy5e@oppo.com>
 <CAGsJ_4xF2J=xxG1rVvFARJtVrvfrGAr7ZLtMCgp8obL6Q0TcMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xF2J=xxG1rVvFARJtVrvfrGAr7ZLtMCgp8obL6Q0TcMw@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYSPR02MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 48969417-b5f4-464d-faf6-08dcac9057ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUgwWktXUGl4NDNHUFhNQjhxWm9DcVhPRnI0eURvd2c2WUhVL1ArV1daOGRL?=
 =?utf-8?B?bnhJbDFtWVFOemlYUTkzTk1oUzN6OVZTLzhTUDJ5ekZhWVR5R2ZhZUk3TlJ6?=
 =?utf-8?B?TDR6QkZGR2hXRzVpN2R1aVU4WnRoUFpZaTVlNW4rUUNUckxJUHNKWEExK241?=
 =?utf-8?B?aUo3bThwY2ZubGlRWkFnWjNaZXJFVGhTL0hNT3BRWTBQeXVKWWRXSDVHdmQw?=
 =?utf-8?B?eDM3dEc2blB6L2lQeUpjaTY0a2F3Z2NGN0c1RmNCUTBCNEt0ZnYwNFFSNWpV?=
 =?utf-8?B?eEhZVm1QRmtNTkdNWDg3ZW1vcTZHb0ZxaDc0OURiVjlDWHJqdncwWTdydzNF?=
 =?utf-8?B?VndDVUNEa1N0TG1XZjhFRFdPNWN3R2xxeHhPN1ZnM2xpSnp0Q1YzNE1KWFN6?=
 =?utf-8?B?SmwvUmw2OG1oTFZPOUYxcC9vVzgxZG8xSVZYL0pUYitVZUpZbUJlOW1VQ3FM?=
 =?utf-8?B?ZFlNZDYvTFN0K3FBQVVITWpwZ2lwaEZyaVc5VkxFcCtHSmFndUgxOWk2ZTZF?=
 =?utf-8?B?a1d2MUs3cEhKdFJra3NBamU3U3c5MWVKN0JrUGh6T3VMa05ZWTgrM01xS3g1?=
 =?utf-8?B?cnE5SXRZdE1jaGFhL1VQK0pFZlU5UkhVdkhSOHZBZmlPaVNKckEyWW1KcVdD?=
 =?utf-8?B?RVdLT0VyN1hQdEtKNmhQNzdxUk05RElJcmcxcUNwVUJJOFRhT3FRN0NkMER4?=
 =?utf-8?B?YWF2WDlXaWRUNXFmeDJTYTJCT28rQk1BN1ovRm1HbEFZbkd1NUJKWGpFeFd1?=
 =?utf-8?B?NGh6Y1Y3eU1rRXBNUTUyN2V6TWNHT1lZM3F5THg2RzJSUGgzanRDVzdWOEJZ?=
 =?utf-8?B?aGJzSndqbUtadzNVSVNJcVJubTh0bVl4SWRadTlubDNXS3ZsL09SYSs4Q2hV?=
 =?utf-8?B?MERobkV1blNzczc4SW9Ob2ZYdDBuWWFkKytvSHVzcVZaemNEYnVrNXRzK0R4?=
 =?utf-8?B?UUo5Nmo2Nlp3NWJlY3BOdlAwUnQ5VXNoSGlvblIzak9tMzhiNnRWYUprSEVM?=
 =?utf-8?B?WVlQbDFmR2xPU1ZxOHJGVHlOM1QrczhmTUhDUWpPanNHUzl0bEdQb1dQcHYy?=
 =?utf-8?B?QVM5YXVIbkpjancreW5kbXBXZmFNb3JGWENpcWVhbVZNbnFiKzBsM0lmSDBW?=
 =?utf-8?B?eW10eHdKTDVsWXplVUk5UEJMbTRKMjd1QWp4dm80dS9DWWRRRUhiQTh6MmZx?=
 =?utf-8?B?QUErS3BQcURwaEpoUUdkOTE3d1BJMDQzd2kxeTZtSEdrcmxGR0laV21LUkcy?=
 =?utf-8?B?Y2UvNktSUE1HVnNmL2NQZks5V1A4bURVd0RwRHdNRkJRdmJrKzZNYmExaEll?=
 =?utf-8?B?SmI0L2dxdUpNYUlIWXU0NWIyaXd0OHBHVEthcUduOTVHRDRMYW0ybS95WVIr?=
 =?utf-8?B?aU9WMzNvZzBjdlF2dTQ5WUVvU3VNc0dnK25GUUhPcnBZZUdEWVprVFpYVEQ3?=
 =?utf-8?B?Q25JNXhrNzlLZTF0aEVLUmMyc2dPbHA2K1N4djZwV2NaME81dnU5TVRPVlJ1?=
 =?utf-8?B?M0ZjSVo1VlNIRHVGYXBaejczMmM5UG9qeHl0V3N2S0JBWDN1K3NkSFhzbG9E?=
 =?utf-8?B?SVFuTHVKQWt4YlcyaFBFOWdISkpXUXlhUWRBaVZhZGJ3WG9JaDNPajBwSW1j?=
 =?utf-8?B?eGhvYTlIT1U3TlBIN1ZYdmhkTU1pdE9Ub2dPR3BrTFRuZXNHd0FwWlhDcitr?=
 =?utf-8?B?U1R1VGVoOXA1c0huWkM5djV4YVNZTlJyUUptdXlWQnBYZGFmVTkydVhjQWJ3?=
 =?utf-8?B?L3hmdmNrUzlsRjVlS294OC9XeDJINEJQdmlZcHJOVXA5N1MrajNXanQ0djRh?=
 =?utf-8?B?TXVjYU1XajdtNjNaaVZ2akd3Yk1xRnZ6eENybGhwOGxUVS9MYUtHQ1FhYWJ2?=
 =?utf-8?Q?4M2WNNxM9DGDH?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 09:58:32.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48969417-b5f4-464d-faf6-08dcac9057ea
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB8005

On Thu, 25. Jul 21:34, Barry Song wrote:
> On Thu, Jul 25, 2024 at 9:17 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> >
> > On Thu, 25. Jul 18:21, Barry Song wrote:
> > > On Thu, Jul 25, 2024 at 3:53 PM <hailong.liu@oppo.com> wrote:
> > [snip]
> > >
> > > This is still incorrect because it undoes Michal's work. We also need to break
> > > the loop if (!nofail), which you're currently omitting.
> >
> > IIUC, the origin issue is to fix kvcalloc with __GFP_NOFAIL return NULL.
> > https://lore.kernel.org/all/ZAXynvdNqcI0f6Us@dhcp22.suse.cz/T/#u
> > if we disable huge flag in kmalloc_node, the issue will be fixed.
>
> No, this just bypasses kvmalloc and doesn't solve the underlying issue. Problems
> can still be triggered by vmalloc_huge() even after the bypass. Once we
> reorganize vmap_huge to support the combination of PMD and PTE
> mapping, we should re-enable HUGE_VMAP for kvmalloc.
Totally agree, This will take some time to support. As in [1] I prepare to fix
with a offset in page_private to indicate the location of fallback.

>
> I would consider dropping VM_ALLOW_HUGE_VMAP() for kvmalloc as
> an short-term "optimization" to save memory rather than a long-term fix. This
> 'optimization' is only valid until we reorganize HUGE_VMAP in a way
> similar to THP. I mean, for a 2.1MB kvmalloc, we can map 2MB as PMD
> and 0.1 as PTE.
However this just fixed the kvmalloc_node, but for others who call
vmalloc_huge(), the issue exits. so I remove the Michal's code. sorry for this.

>
> > >
> > > To avoid reverting Michal's work, the simplest "fix" would be,
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index caf032f0bd69..0011ca30df1c 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3775,7 +3775,7 @@ void *__vmalloc_node_range_noprof(unsigned long
> > > size, unsigned long align,
> > >                 return NULL;
> > >         }
> > >
> > > -       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > > +       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP) &
> > > !(gfp_mask & __GFP_NOFAIL)) {
> > >                 unsigned long size_per_node;
> > >
> > >                 /*
> > > >
> > > > [1] https://lore.kernel.org/lkml/20240724182827.nlgdckimtg2gwns5@oppo.com/
> > > > 2.34.1
> > >
> > > Thanks
> > > Barry
> >
> > --
> > help you, help me,
> > Hailong.

--
help you, help me,
Hailong.

