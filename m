Return-Path: <linux-kernel+bounces-370774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE6A9A31E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA318B2213C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46733A1CD;
	Fri, 18 Oct 2024 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IdL/PoOW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5C20E319
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214241; cv=fail; b=A6/k5ckRydEULIYYSAaMCSjqpt2GbTFKyM/KTatEoTjbtn/X5VCTUUwLTe7/U4N2aZpzEipWHrUj0C0WPpY7pS8Sz/rSyM01vy0WxqyG0mBO2fhio99HAcHO/FJyYKkr32TaEmkgTHk7B02bX18IEAjq95jcNe5FNAf69K/wcBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214241; c=relaxed/simple;
	bh=hQhr4vbdGfa6FA6RRVUnGgwobod2nU2LUX1Fyex4wkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVOKr1OZZduv+ji8qx4oqVPNM4UdRwoDCYDrFzOZeIh+Co6oIcJQdx1o5C1ZkVNr8yo/1uBjamNnoTEthNvjbMx4FbQObJg9UbMHH0vS4wdwMpCWEMiqb6mMa/HeG91NSHFGmQTifbmAOxk0vK0v5UzXgyxEGrP86COieDTBv/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IdL/PoOW; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVnOtkV4HcVoNH0Uz5hJqRnqKqkH07NRMfflYxM601vzTDEvL3KlS1MfkaaqhOJt/hKMWgaexDyUc3jvtDuur0pJrFExGiUZX4Y/Mjsg8kix+22vS0CYzz91A/06wRp7ATZlGsKYSJ0b13b0KPBOKGJkSl9SqtyPBE2cPiQlDUQrFDhXYrHsZ+eQWzkbx03UzXfHqIIPgrdZlo2gr/cQAheSRHSkt8q4pjVKQ+yHwT9QvbnNMfMM9GtoGdQlUbWcBc3EPIbG/vPEhf4lCGsEDpy2R0ho0Chd2t7xr4SGy06SH2WONr5n5i5NutPihEkPEph6JGDYxjk3ZtM8gK7rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZAVy+a1Uit8MnAlbuW5dKC2vHWFJUruiB8FoQzkxfA=;
 b=EsBDGcgrPDl1Xwm1eS3TJ9tQ//YP5XqKk22tzMrYPD7rQt72RDICGgt4AaTYtNRWAXmy/2XqUT4GtPW8eUQYyF5OaWC6g075iOcrWp8isA9JP0VnpAXnLU1jazhPWQD09Rc0Cc50T61xM2GJ4jikgq2lR5TcD/NzGtQTTMhnFNvHsBr0ekwJM1QLLpnOUNdb9Qwd3hj3tWnk0Dd1GsztBmI6mZ6QY7Iqo9ocHbZX0Qz6kO/gs1rQ2z5bRkKBDA+q53nRkJAB3jUaozUpcjkvSdDoB+A8AYDf3TD9I6rXfWMGCqYVExLK3AMqR7ieuZRu5XJHToL3Qit3tljjqP+hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZAVy+a1Uit8MnAlbuW5dKC2vHWFJUruiB8FoQzkxfA=;
 b=IdL/PoOWrFONiU12U/U4+AnSFp6zWr33r78ZUCYcLd29+4QXX8Su7bImHNPGTohR2cAX3KGjGbRpSj0TKAzAyY6J8CwuRP58ja3sWHPEg/mqCjk+u/s4odqfIxbxQSu8H43pFIq4j+1H/nUxP7CFDaAjKqRtCrFHwPr4H8scHjNtRJUHr61QxiEa+q78nZEU6+WFJ+pYWBKKWCXLrrvwE0i5qoyIZD+yx6Wr8srEDmtHXzdc+idjfysXS/e/6jocDU34jTNn2+1OvJ8wiWAiGvtX469l0YZOt0lsU/+JjNpv2fRmsS9Q+Lbh2mI/35Wds7EZzGob14rUKXjKAv0ItQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 01:17:13 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 01:17:13 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v2 1/2] mm/gup: stop leaking pinned pages in low memory conditions
Date: Thu, 17 Oct 2024 18:17:10 -0700
Message-ID: <20241018011711.183642-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018011711.183642-1-jhubbard@nvidia.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0850f8-9cf0-42de-2c5a-08dcef129905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPFEmPgG2RAz/8NCQYsLiycVECysgyTlQhNpE49rIAalEFv2owswsK1r+zOl?=
 =?us-ascii?Q?0c8K00KPQy+Ewesb1cEFraamW+RxKhyK3IyfG3dxomz0VOS/s5xNPlZMjeZD?=
 =?us-ascii?Q?ROqnmr69T1Z1uGlczE8/qBzLL41tJOhEmRRXZHSdpCtW7yfjGGVcGSiUGyrG?=
 =?us-ascii?Q?kgEAUn21N5gy5+T9St6d2PVltOMuDM0UIFQHhLBfjH3HmiemTJQbQA4WYO9W?=
 =?us-ascii?Q?qM5lMrs5lZUgCNS94T/SsVdQFlAfPVCd/238LGJ7q6QYDSMls1hB4ZsSKAFL?=
 =?us-ascii?Q?EsJolUyyUFu28FL/u4bZyaVZRrNLB+zAtdljuY6uz17IsMOJwuZwCTQmA+kZ?=
 =?us-ascii?Q?OSybSfXMjXJFG7kyFqhlBP9Z7e9yGuR2XkZkT5nje2UXfAKqy4oecBowMPDS?=
 =?us-ascii?Q?SOltNfz7zMMKRdDg+3NfDvr4pyvLd0zt3Ue1IUCEOiCeck8+5K3eqL1/AnpF?=
 =?us-ascii?Q?+LqOBZB/cMcYxbOiPTyNYT15uuggFc4GOqEdu4BcUAohzpNFQSRj0DLa+m+T?=
 =?us-ascii?Q?yxoOI/JxL1vR/RHo5JoM9tZZ0ZW6pPvBhQ25zUr8/i3fTPBV1i84PCKKaa/l?=
 =?us-ascii?Q?9unWp/bI7rkUd2N8KdTvPxQsHFaCKAgabnRjZlYPPwP70Enmsu+cLTYq0VGi?=
 =?us-ascii?Q?TicNVKn94KNVxF62/JFkFxLaprObT5M6TKx3c9W2Qmw04HYDz4DiCla4rAzP?=
 =?us-ascii?Q?5DA1HzaKqIrRFeJC19v5BqBjQlB6ajzMfaAGvKZJRy8iJaemCoFGxZ3Gnd1R?=
 =?us-ascii?Q?/Q4wDb9ll8a42iKfblCmr/Q25TLKBmaFlZeWo6caGZcJ8gt/HbSi9Tp5Fvm4?=
 =?us-ascii?Q?fgT/Z4Q20b4QJ/3PD5UqzdpZzSTaeM5C13v1XPndJYRfb/yESW/pshzXwYaH?=
 =?us-ascii?Q?3Zqp1MDUYi+/mjabfUEyhZZbdVj9rkQNnQZvH4Iw+C0OV0jfZERTtnodoItr?=
 =?us-ascii?Q?ZBE4AKo4NdS/Wt/AwMTrIp+ctNQrN2LNB8swLy7TmnhxDkSb+nziwYxxNQPz?=
 =?us-ascii?Q?f6XyQc6HuvIEHn49gttTZVuhTsXtMD3MUCSYRXZoz9mhLcelf0Jn6DpuVmfk?=
 =?us-ascii?Q?yhiT8sPyeymQAtKWN2vkh3o7Noxp9EUgeQ6ocejuN/RevzwZ78kV90CaNjoe?=
 =?us-ascii?Q?8BtNQvnJPTk5JqD2smODwYEThCzeC5O9fZpId7mOk+aFR9XMg1DwKNbifJhM?=
 =?us-ascii?Q?EpfnO/DFdO13hwiskfGSZpmdMpQmfgi20yxlO8wkK4bz3GjXtdKBgcfM3cqv?=
 =?us-ascii?Q?8eO9aJ6US5JZUne9Pxnm4Vf4DNIlNVS0bRONyoW3kUVmCPZV7nTNC6qH1flM?=
 =?us-ascii?Q?ezNM0qOfteYbfS82BK2G405X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9jJWpWzpA7rDXA/fOmvk1XX/qVUgrhYJDblnsk7cmOiNg5+jVXJFomBAOEAs?=
 =?us-ascii?Q?A3fTOtywPIJnEzBWz9tf4GPICbTDtvJnOO1v4W34U4YSCC/x0VYQ+JWp24wm?=
 =?us-ascii?Q?cc/uAjMvdj3LxtR+kk4L1S+E1OuPbV1qHNzeCAV8dlzVRH4cFCxY3853UOhR?=
 =?us-ascii?Q?gI8Gg5nP5RIZdLCa2DRwen6KGPXStOrCHXcJsxoMMMHxORCFwztjrqHKl56A?=
 =?us-ascii?Q?/kZNBibQ+ggGsymEXLq8DYuvW204jb84KYMBl1xPUyLUYdDXpRDlhSRUIOTF?=
 =?us-ascii?Q?hopdvq485u/P+VWzLT5py3rQSwhu7H0q/mFimFlw9I4Pz5b67cu5rutDSVO+?=
 =?us-ascii?Q?OTMmODi2XuBzYXFXLvsYCjMo2JS32oNYY87xeRtLOJ8Tc6eL3+rqIGYLZ9H/?=
 =?us-ascii?Q?uSA8wCeplF5xIPFQaplS5NOxgd46V4llvsr5Y4i4UR1g/cCVbFFWF+r9kA3S?=
 =?us-ascii?Q?p3zUeKhV2eXSdIIXnWe4yE/GDL/gLoNm8PaKh/b0hOGJJKHMRQqP4c6tixBM?=
 =?us-ascii?Q?KezrG0X2otPTWSJgDgLdVSptnHxkYDzQth48aL7El2KcbiHb8nJYfW6Hys6S?=
 =?us-ascii?Q?yM4CSwlRVoswekcq4Ip4TXZsiEmrNUAzNxELg5NrkMj68n1r2KmDORLJJRsM?=
 =?us-ascii?Q?yv6OEyhpMlJehIodS5BaTTySx5pf/HtRR6XoJupy1CW7pM8Pzb0ZQDZm3N9a?=
 =?us-ascii?Q?AzwOq1TV9GBEOuWpFFpbBFBzHpVEmg46pIrrPUvZvSDNnFY+ivNXsp0+AXoV?=
 =?us-ascii?Q?HVFHXpc/WJJXXcbvz/D3lEjqIadEjbd86QOJBuY8IJ8BA0ZcMlPR6m58Ifyk?=
 =?us-ascii?Q?sRE/zUNznVkHRuBDCGnnwOrSLHVCc0Z/ikCobEl+Z/vLZNEKBh1Yq1mzKHE/?=
 =?us-ascii?Q?XytIZrTwCMfEpEagPNo265w3+j4BEQXYsTszsCWNWX6AuzzvGnZZk/APAwC0?=
 =?us-ascii?Q?ba676iwqkHXfSuK9bsm7FVWKpZbHbjx/YVM+jNv6Q2PMgRQGJQvdRXOq6xOH?=
 =?us-ascii?Q?P7MILplF/8apATLJSxh7+EphmOIo0rqB1b2ggtGIB3dJbDh8onVzThl/SylJ?=
 =?us-ascii?Q?nHX+ulCQqYz+XPpNx69ppwsMaxt4V0sBrhMcaQjEo7aCKBlUUOKtxGcc0DLZ?=
 =?us-ascii?Q?m4XfFaPgxZAUkQ+TQ9bo5wKrBLpDqzoFa6FuSa5MiUUDbDkwhMJlDBX9KvGg?=
 =?us-ascii?Q?rsf6kRFCaG+b4TJ2URc/OOh1OxS2xYkEZ0koyKtfue65D7B56ubhHcXpOjwe?=
 =?us-ascii?Q?b3b8d0xQ5J8kUlzv4r5oiMV/q6HQgAu/liCHrRAlfi96EnaT2bXP2fefj4ol?=
 =?us-ascii?Q?YCjyuhwd4v03s4KCBAUYA6qDY4Dc4Ey2hfr63CMRbOCcekE5LExHw343UL5g?=
 =?us-ascii?Q?KN3+ZCfqF+xuDwvHk0EH0sk+TY26kQrxMwYElMG+51V3dkQgAc0wC87s6N3w?=
 =?us-ascii?Q?ysiPulqoku4+cqEadIeNqHuve7UMgSa5biCIzHr5cQ51jtcnWdN3+cTdHZaW?=
 =?us-ascii?Q?lHkDn7U/BMWTbX/KifwmKYxNwmvj0YmoiGhnUsuzH0zx0u2qZ94XJxKOnu7F?=
 =?us-ascii?Q?zWCn8X9XBQMxsDJJHYKS7mMZtMSL0vuEduGtnbZP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0850f8-9cf0-42de-2c5a-08dcef129905
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 01:17:13.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dee9T8jH4KjqyfmUEDkkLZSVj/Srvpg/sXI7XUTeL/S7F+nwcKzZOishQQG2MQSuQMXdgKjQGFI7rmO7GXulcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
family of functions, and requests "too many" pages, then the call will
erroneously leave pages pinned. This is visible in user space as an
actual memory leak.

Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
to exhaust memory.

The root cause of the problem is this sequence, within
__gup_longterm_locked():

    __get_user_pages_locked()
    rc = check_and_migrate_movable_pages()

...which gets retried in a loop. The loop error handling is incomplete,
clearly due to a somewhat unusual and complicated tri-state error API.
But anyway, if -ENOMEM, or in fact, any unexpected error is returned
from check_and_migrate_movable_pages(), then __gup_longterm_locked()
happily returns the error, while leaving the pages pinned.

In the failed case, which is an app that requests (via a device driver)
30720000000 bytes to be pinned, and then exits, I see this:

    $ grep foll /proc/vmstat
        nr_foll_pin_acquired 7502048
        nr_foll_pin_released 2048

And after applying this patch, it returns to balanced pins:

    $ grep foll /proc/vmstat
        nr_foll_pin_acquired 7502048
        nr_foll_pin_released 7502048

Fix this by unpinning the pages that __get_user_pages_locked() has
pinned, in such error cases.

Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..233c284e8e66 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
 		/* FOLL_LONGTERM implies FOLL_PIN */
 		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
+
+		/*
+		 * The __get_user_pages_locked() call happens before we know if
+		 * it's possible to successfully complete the whole operation.
+		 * To compensate for this, if we get an unexpected error (such
+		 * as -ENOMEM) then we must unpin everything, before erroring
+		 * out.
+		 */
+		if (rc != -EAGAIN && rc != 0)
+			unpin_user_pages(pages, nr_pinned_pages);
+
 	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 	return rc ? rc : nr_pinned_pages;
-- 
2.47.0


