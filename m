Return-Path: <linux-kernel+bounces-372506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57499A498F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FD4280DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606C18FC67;
	Fri, 18 Oct 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NGR0h0Kf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A514900E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729289788; cv=fail; b=ul9uqTOQBG05SK12m9bVsJAhCyQB/h3BAsLPO8xfRQipye2uInF02Wgtha/cQ8RYhjPV95QhWpiGpIJocFzthGfzmnTXza4AuyGzPiNH/u6c+sombI1GFpxBNzsCI0vcAt0+F6mnL1lxtpMsoFgbKwy7DCEh3FehEmWITsgl7+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729289788; c=relaxed/simple;
	bh=VoED7ZBfIjYwHnbRfODE1TCrw/MBtJC6JDcIpAYZH8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kmgoaB4osvJ6Bk4RVufwTBa6nqWtHO6BCvd5HTR+/+0CYB5T2rItRhZwkz3//AgaQfOv69zJal4iULpzTpeyTTH/8hea9D1CKVhAt6Nfa6p4zeWuC8anS34VlIxP3ptsT2L+41jxeOBTNFl0rQrdbATGpgr9cZDUWFnSL1AWebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NGR0h0Kf; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYUm6W8GYJd3sXt5fW6ZEDggmVwLSEtSt8lpS9NLJOOZr+8K4JrTl0YEGgCFVojKTCZoeG5ATlfV9F7L1zW0cQLFaB8vdcr3R0Rqyhl6tWPP3F8zu8PMZphUamJSS4jxvll2ji+8JdfZ9W8EX7/TjJKu58PCYCKp8zooBmcF5Sa4MoahvUJer8V7WseZv8XgzoZL5wHojjWxCcs+M59OapJ56ORBHuTFQBwUcaA7jp6Dwko9mZe0iAJauDSOZewa1PS9Fvqa8SAfIwuCUNL/ROOYw2YunwgZZnUYmPANh49g/ffJmuanGwwnNjdgW2KHVc/QPm2RTDu2JogCShCB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMVNnai3zVEIkrXTxFGmxkAkRtY47leUybvigTzomH8=;
 b=arEk0DJ/vn9L2EwTUpqCfmlbNhgmeklLyXw8CucJ+eFIv5GpYiD2YCiwmt/kQflXeHYTF7rZrySPxQ+Qc/mhv4FXgC4Uqx20s9TvyvEc/Z90Rx4wEnxteQYm8C/qlqLG8iMXeiwCD7Xs3De1VwMhEqCHWJCAu6BJ3SNWBLhoHKjbJ004BMuawUsdXIWuyX1zABGpJPCQ6qoisukfjQq5jnNoNaLduEJvLBbsYsKk1ZqJjfcIHTmuAAa66Ed5iIZ9fETf/7ahhthWmFTWdGxoiV0iaRQz4ArSYt1hV3cSkDUvKyfLmfItmSKNoImm86GtqdwwXelBOH0RGXJwhc8q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMVNnai3zVEIkrXTxFGmxkAkRtY47leUybvigTzomH8=;
 b=NGR0h0KfpjbIPHG7cf7tIV2kutzdPXeoAhtINKQpfHgeGYYj0k1nVpIsE6llWzVYoM0nK7dO22ryLc0itS2QAIWaEJavEO5NjSD1tuXuBXIpWod9SEbX/LXDAIvfYSxBvYiuS5h3sZFpTMA8mnyrRrUYeb+8VGSZCYfqOY0epzNZwO1tETj46po91OkPaiZ2QakEWc6Mvzfatot4QmtvnICMOYfrSNgv0r6ZqN/d3hAGNMiPOcwMp6Bn6ZFpDXE/YzPuPcct0PjQJoFlCpUv7qpS/RbbKdCe/9IlZPGRKWUtzQgbc82DK259RPvtIxr3SSS2i8SIb13fg/U+AjU4Ug==
Received: from MN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:52f::15)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 22:16:23 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::5f) by MN0PR03CA0008.outlook.office365.com
 (2603:10b6:208:52f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 22:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 22:16:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 15:16:04 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 15:16:03 -0700
Message-ID: <691ae680-b8c0-400e-b2ad-f3d43057f350@nvidia.com>
Date: Fri, 18 Oct 2024 15:16:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Andrew Morton <akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Alistair Popple <apopple@nvidia.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>, Hugh Dickins <hughd@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Junxiao Chang <junxiao.chang@intel.com>, "Mike
 Kravetz" <mike.kravetz@oracle.com>, Minchan Kim <minchan@kernel.org>, "Oscar
 Salvador" <osalvador@suse.de>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>, "Vivek
 Kasireddy" <vivek.kasireddy@intel.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
 <20241018151322.6dd3e6ccbbe73599f70179d4@linux-foundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241018151322.6dd3e6ccbbe73599f70179d4@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a5edeb-8c6c-4b0b-e1eb-08dcefc28002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2VIbm1WRXlEeElJNFV2WmhWWHVuV04rY3JmNk9oN3BFdldmZkwwWExSUEhR?=
 =?utf-8?B?N1FvTlBpdjdWbXZ4TjY4azVSK1g4eUg0czRLdVR3QlhKdVRFZk5wSk9ERkEz?=
 =?utf-8?B?YmFsMUVNakdLbWNSbFBEV1AvQ1ZWK1dQN1lMaWtMcXJ0UXJXZkxhbDdxWTZ3?=
 =?utf-8?B?SnFFVmNvS3hNU1c1RTlkNWZXbDh4S1dpdGJxeFVyRjdJaTcza2J1SEJVRXpO?=
 =?utf-8?B?d1hpQTFYaUhrem1VNERhdU1BdXBQWjRsaTdsZnpwSisrVDRpd2tnS0Q5c0U1?=
 =?utf-8?B?TlFoZzhpbURtYzRtRyt3WTgwQkg1NUx5azJUdFRuNTA5anM4aTVKMzRYM1R6?=
 =?utf-8?B?VEtkdVVNOGtaTzBtUUZXNjNpR2xMUWppNld2bWpjcnJQczRDL3BtejJBNzg2?=
 =?utf-8?B?aU5Nelh3NzJoQy95bnI5ZTlHcGNGdVJxeGRROVFWN2N4dnIzcVl5anZHbFJ2?=
 =?utf-8?B?dnVhZnc3NSt4czZVemZxMCtrT3BOdUF0TjBiOWZoUmFCU0V5THc3WVNycC93?=
 =?utf-8?B?emREVEVzYWVmSGc3eG9yMGRGaTd2ck41RWdPaFgvVC8yR0twSy8zU2xESCtt?=
 =?utf-8?B?TnQ0NzJRbUZSYnpSN2pRK0FEdmJ1SXI0dE5EME9uNk56bjZXWkJ5Y3hZdlhF?=
 =?utf-8?B?K2hwYVQvRlRnZ0RxSGRQdGl5S0pPWGJEU25yVmVqS1AydWU4ZmYwVmRwbWJK?=
 =?utf-8?B?NnRONE9LeWllSDJMcGhmMk9DVkF5SWhmeFFEQk93MW1vZ3Z6THNvb0VSZXk5?=
 =?utf-8?B?cEdIbmFPN0JXSWc2WWRIZmNVVGRWbm12cW1OeE8vYWRvOUZ3bGV6bnNsYmNV?=
 =?utf-8?B?SzFNeTRDdGpLT3NpSXJLS05ucy9ZWjZxMG1MQ0ZESHIvVGhBVTFZRHI4ZkQ3?=
 =?utf-8?B?ZXRLckdwN2xIZjBSWXlMcjRoNUdVYUYrdXl4bGpvRnRUcEdOL3VweGVxUzdZ?=
 =?utf-8?B?UW1DdFJJejV0T3dHMWxIVTRQTkdXMG9aNzJ6MzQxU0lRdzVKeHUxV29NODg3?=
 =?utf-8?B?bW9qSU56dHU3TU0xSytqSXJiMGVrVFBtclIrR3QvZHNOZEN4dmN5S1BhcTZW?=
 =?utf-8?B?U2lXQzhxdkNHd3VlYWRTRDdrTE4wZk01WWRmQTgxYnVHVzkyZTZ2ejU2cUwv?=
 =?utf-8?B?dnNWeG1KL3RMdms0QlMwVWViZncvQ3ZVbUpRZ1J4Rkp4MlowcmhRL0xxSlJC?=
 =?utf-8?B?Ym9uaWNaR1JjQjZReWtzMlN2bTNPQ0RhY0FndlVVVEUzN0RseUJDNHd3VzAz?=
 =?utf-8?B?eWV2M1NLUHdkZjF6MGI4dTAwQ2lPVnJQa3VGV3d5TUkybzlFcnEwaUJTc04y?=
 =?utf-8?B?M08yWXpHSWF3azA1RTM5bHpDZmZ2eThQV09NZmZ6cXo4MHBwQ1U0cElpcHhH?=
 =?utf-8?B?d0NCakZydjJkVng1clBYOGdNOU84OGxGSjB2MU53WTkwbkNnRGZRRS9yUGRs?=
 =?utf-8?B?eXRaM1BEaGlIQVdNMnJiZkcxUVV3RkVWSEk2YzZzWU9IcmNYTWx6Z0F1Z2pv?=
 =?utf-8?B?VCtCU1NjaytiZkREQjZVb2ZubkgvL3hheC9pc0xkMDdDMkNEbHd5cXFna3Bm?=
 =?utf-8?B?cVUrS3ZPcGVyaHdFbEFOaXBKV1N4TkExVEx0MWRMY3dQdnJnS0JNY0dkb3hF?=
 =?utf-8?B?SXBuUkUwM01VZ1Vkb3NBN2tUeSt2N1QreXl1L1ZiMjZ1S2txTG5BNVBaaExM?=
 =?utf-8?B?ZjNieThSd0ZqdnYrNFZpTlpQL3JhMlF3aDJyd3I3dkhPQ2lIYkNDbEZpVExr?=
 =?utf-8?B?VEpRaHFvWVJ2bUNFbzd5TlVueTZ6enZBNG9jY2Z6WEN6U2ZaMklTaDlVT1B4?=
 =?utf-8?B?MHFHeE9VVWhNYjBZZnlnam1kT2VncDVuY2xQNHgzZ2JETG9RUDYzVjhWUUVV?=
 =?utf-8?B?YW85b081d28yTWpubFp3MURDNTBZQTFNNVo4dEplVkc4SWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:16:22.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a5edeb-8c6c-4b0b-e1eb-08dcefc28002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

On 10/18/24 3:13 PM, Andrew Morton wrote:
> On Thu, 17 Oct 2024 18:17:09 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> 
> I added cc:stable to both of these.  Which might be inappropriate since
> "patch #2 is not really required".

Right.

> 
>>    mm/gup: stop leaking pinned pages in low memory conditions
> 
> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
> 
> In mainline since v6.1!
> 
>>    mm/gup: memfd: stop leaking pinned pages in low memory conditions
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> 
> Since v6.11.
> 
> 
> So these are quite independent fixes.  Kernels 6.1.x ...  6.10.x will
> have the first patch and not the second.  That's presumably an untested
> combination, fingers crossed.
> 

Probably fine.

> 

Ah, I'm actually about to send out v3 in a moment, which only has one patch,
whose diffs are just comment changes, plus David's latest suggestion:


  static long check_and_migrate_movable_pages(unsigned long nr_pages,
                                             struct page **pages)
@@ -2437,8 +2440,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
         long i, ret;
  
         folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-       if (!folios)
+       if (!folios) {
+               unpin_user_pages(pages, nr_pages);
                 return -ENOMEM;
+       }
  
         for (i = 0; i < nr_pages; i++)
                 folios[i] = page_folio(pages[i]);


thanks,
-- 
John Hubbard


