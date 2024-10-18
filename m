Return-Path: <linux-kernel+bounces-370776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A119A31E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270951F22999
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243636F307;
	Fri, 18 Oct 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1rSnmyV"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5646444
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214245; cv=fail; b=F/AwVKz+cOGHNjdKwIw6Zh0YPqNk7vAl1N1Pj+bd1xRuy3tpur+2YTA3nswqQsXU4p+P6KdBTcCT98mdWOTtxfQBbImK5e8EtRMS752oOIS4DTOtoS3An3g7m3V5MCH3isC1lcLmNesN6MIBEaHoVu3UNf99a/68NC7MKR19rqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214245; c=relaxed/simple;
	bh=UYssHrNGAq9KXgJ2QPhrf0wKcdlxH9FyLsmiECT69sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dSD/twrOTjuHh45rNQ86nzxyHjalF/sNB6JhYGxr5JnVYfMkJa5gG1DqrZ+0ekCzOs2TzCdaFzkJF/xDkTObvW13HpFOucXGKU5ld8EuEehVZH6cjZC/ulT0UGvKlBmg1bnbgFiT5ux/jXbZ+XmuNbTFqF2mZ4+qRq/tpUJRudM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1rSnmyV; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drWu645H172MaJUNq/CikRaRJF/MCvBF8S/MwV2AUoK2vgaW3PywTInEO0BjgncHWFt/h2ZDYwwjJNHlDQbw5WUiVV3nShznGcN/Jmv1EB1dx9WW3vq81s2dNFD5ORfuyIiQwYFzfNB9TgTMSuSDiSdAb3+hE4CeJ44oJgkaYt72EjXBOYGl/5oORKT9BOiEUdZOPDHFUhZnwDv2/w2NzKw4aM+lr5kif3ZCJPCKJ/3UfaMdyR1J6N0IVISE4vz1wyvf69uIFuJDorGModjTdfN4NFLVmSVzP56RB+K+63kwvcXsYvqJrIyQIDXUybCfAwUHhmkB+zrMfjhjTDMMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md1MjpdHuilWPTTJzdr6SW7W/BrD9InA2SMVrB7H2Hw=;
 b=nyuj3jsPRWTH1iBsserpUGOn/Hfam2FDTMu8KxWEKAwLudN8RZ3TvLzavmbNAcau888C5oqciJW+twxiioh/lALf+IUpHexmjR+JTRcU/iterACrSuBQVS5z/VLzcf2oFOz2P98ZuFyOl58qcbJWsEnX/PMLScTkPx9WHgsG1h/dtgZR316VYEXNf14fnRljg7MMDf3zglq3clVQ6WZ0givjCcCGGn2ZMcSjAw8nsZ9yvk7WnKy+Rw+y7cF3OWd001BVXc6VCl398ZbybVRpYya0X4ETfSaLAFM7z0YzR0hOoCOKjTICieUZofE3QtF/MltP5KCUauhiHsB5OZB0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md1MjpdHuilWPTTJzdr6SW7W/BrD9InA2SMVrB7H2Hw=;
 b=Q1rSnmyVPk4jIRnjeeBzwxpAadgT3gBg4nNn8veCg6CiBl1bANhExvbHQQu+CaLXMwaGhBTf12OORM6Fzfexpy2WqnvcC5+UrIlC9wCRZPT+aa8sEEkhK2zDA2XhNDOs0RYowgg1GkaOuZBa+Q2G+LCR7K9APKW4v5aX3OXHpa2TGgYwPBORkHMdpytStSNpbuMa06egs8aOiSmkgoIKEm7iuUocDmUpJuIZLsyP2LFM3juiBZBdpVjYUBCSk2TC6RwTNaJ3XNU4caVYdyYMJSn4DjzyrSd3eHY5lgAkge11TEcUBZ5mbpMnAj6q/uC5uWiJTepeZWWeZ3UafeGDUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 01:17:14 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 01:17:14 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Hugh Dickins <hughd@google.com>,
	Peter Xu <peterx@redhat.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/2] mm/gup: memfd: stop leaking pinned pages in low memory conditions
Date: Thu, 17 Oct 2024 18:17:11 -0700
Message-ID: <20241018011711.183642-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018011711.183642-1-jhubbard@nvidia.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b67244d-bbee-471b-ac17-08dcef129963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u+xgi/RPVQrRtaIYaIrdsoyHkUKIF8OlSoZ703MVWIIyhQ7Po0mORhreDwOL?=
 =?us-ascii?Q?xNwpyIKdbsg2PmmEN+Rx+odB9Fj0b5pt/xrpW/jcOvKvoaPHEbbC4oB73XoB?=
 =?us-ascii?Q?tPt9QcRFiH2H6A0ElxXlKsIfVbKL9UiGRSJtZUNUMZeDZ9CbWQhTFRQvxsT8?=
 =?us-ascii?Q?Ii4XLChs38vVdvscJpVU2IYtTEmQ2w1XJ2PbND/fdqKMG7UaGLxIbfWyvBqw?=
 =?us-ascii?Q?iSYle4VnmvI6FrTfv9dDyEPJrurBLprrgl8Vj7HbJZuZrjC4v+CyWlDgu6Xf?=
 =?us-ascii?Q?oaad4t/qfzUtwSL/j9f/r52is/staT1vDAaTLNVeO8zUIdWV8n22L2fhowrI?=
 =?us-ascii?Q?wOJ0I+q7UTR7vjuWKejYdSmCyILuzaOZi+WqzKXZQWGuJOptRxZ8+DP4YZuD?=
 =?us-ascii?Q?JkeEDYq95ceIFAz5i9mSUHV4aDf+5jimJ6zIjh8Du4u5WVNOdFfAEQqj7nr0?=
 =?us-ascii?Q?MJiJnCqLd5Ond7ESGRk+k4CKgOVO74Wa+GuJ3HlgtF6VlTPneyXlyuG/5/71?=
 =?us-ascii?Q?ORaHUXxiiQW1V5EkZ2+QEeAUFVUK1EgsEgZ9lsEs9qljHIhtWm6VTBBeUOUI?=
 =?us-ascii?Q?zNYBpp1sNq85j4dGg222rFNe1HP8jP2DWbBY+EtlS9wltr9I3Zc2h2JvBYUH?=
 =?us-ascii?Q?c85X6R82Wu7YxxxmptxIJtUUdDgF0In0zyW+LfaNGOpBXQhRY0jVyrAHy3L1?=
 =?us-ascii?Q?Mdyg+uyFYkUm2NRqP27oCsXlzahCM/hWGmDKOK8+2X2xbO/3Hh1AFoLPWYIq?=
 =?us-ascii?Q?FAp0cYVaD/MZMXpdQbOAQI/cQy7lM0uAfsyen5u4GbSMlFqaQ2XUUzthhFKI?=
 =?us-ascii?Q?xgdex8akmL9ocW0wpgBxgy191NRdUClQMy2KSThPIcVjJKQ2LEfSPwneO0gY?=
 =?us-ascii?Q?DHAIm2Wm70WG3n/E8pO4gEFttJMeb25M5QQfTQKNJKTmYZKjOCleo3B9xwwD?=
 =?us-ascii?Q?hqTxWfztFjjJhKk+jHd3x1R8NFzTmRTWWPe+abvyLEH9/s8fqHuoqovtI8gW?=
 =?us-ascii?Q?+lp9nn7/9Lf/pPBujOfN0lGlrZ1zLu4diDbYBgS+d2cVjKWsktNAGoasdOK1?=
 =?us-ascii?Q?xbbfM4yyKHJ7NG6n5IVNmRMsoNtLW+poYJifHLkblxSSuo0v2tNADAlssZhh?=
 =?us-ascii?Q?r195PvDQf2I6CIVb9wo5AOmWi0CRLLfrjLnbFUEAWUrLfBggbJ/bYUgnyeKN?=
 =?us-ascii?Q?X1Lvg1d3tgSReHkPqvIgGqFUEW1d24lxDgBV1YQhZETlidvtZ4ZcOUGjWw0z?=
 =?us-ascii?Q?6wAehLJe/FmPcODOHtk/xMScpFYPNiXkBUJBr0K8hRViQXJH9CYz6hl0t5EC?=
 =?us-ascii?Q?dZpLDKtxwIUnbm+CdEgu686l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBqpOBTS+8Iw2ubqb9DxjwjU8/g0iXBwNaHwAc8J5i3uY+HQvZyNrbiTCFg6?=
 =?us-ascii?Q?NFVLDfqnBQ81bNy7s5qyKIptGfzp90B//DxXlLTHlnOYvcsPMhWyp4ZscF6L?=
 =?us-ascii?Q?Luy7AykWeL81Kcwn7bpupHwULvl3C/hQYxsApA/pz2Vm2myeqtiXKch1XjNS?=
 =?us-ascii?Q?lVUXnZkjNwcemhEEyi5je0w+y2sqRXDUB12/e0zlL96lFgGgZPrfVLztaGIl?=
 =?us-ascii?Q?Ep7R99Un+cNwLmxuR2vJqBsq/N37LUfCkCFob33yo3i0hcnzXqkDDjRrMzEc?=
 =?us-ascii?Q?eGkwqlemujbaLu3L/pqans8JkP2g7YWdfp+nGHjtT+W6MJ3pSYvvaoAGRMKW?=
 =?us-ascii?Q?ArxSvwXFm2Wulbt5FyVlO8nrLKhwPvhONNjNoHcRvaegLyVjOPHov8LeVqJl?=
 =?us-ascii?Q?UCHY9ZRc5BbOR4vXezt3kkh5GipvoClNw0uKHpLYqG9CddjYI2iibc0Bl103?=
 =?us-ascii?Q?FyaC5fFLaKdawlPmPC4VqwBLd4HNzFv13NDOltLeGTn9Y1Fp0wm2OLvi0M1N?=
 =?us-ascii?Q?nGkqHfUqFxLwTI1Jj3QFdS/W7dsxe/Oxf7FfprUS0ASgvuV1TcmP6cFOceBU?=
 =?us-ascii?Q?q4t/JLqIjXAWIOrpRmu0TFTfW2DTisc41etqAxXh8Weumawla1TFbYpP0Weo?=
 =?us-ascii?Q?PP3dj3sRPQps4YVYPgaZeGteiwc+Md+8U2d7CAOqI6J0oIWkVgifFuIusJQA?=
 =?us-ascii?Q?Y6INIgLxn7+D2ZpqvL3wEMb1PNE0RyfIDxVd/UYXHrRh5n9LUBBT7bzdNDPE?=
 =?us-ascii?Q?gkl8/8sU/RpeylpfuiO+BrhGHgNVYbZFNK2lZ5qfjNyInCoQaPqbaBjWIZuM?=
 =?us-ascii?Q?4AYOPdpT+g2o6pPFbR7avXCWfJP/4qbtmoOKkdHovpddji0f51I7QP0s3xWt?=
 =?us-ascii?Q?wIOYx4onfRW6NRRObycaFjGb+OHaMONTdCAUMvhNgxE/9MXBQ05KuIDyTQdg?=
 =?us-ascii?Q?a7InEvNGPFJyffU65/vdjKyHSV1KoKZlBW4EDFK8O5huvr57FzAweGJrZXZ8?=
 =?us-ascii?Q?hr8IXOGNITYrF3VKndmMdhUlKDoLISAQk60tVq3ev9Jz0eJPwNpUDAfOfx3W?=
 =?us-ascii?Q?t8NHPrcqnu8FuRycnLGOy5NbJPC38d0/KSnkBl1pbhQFLgWPRv5zAcTISKsr?=
 =?us-ascii?Q?e6GSF0LcCXsNBRG052vKfZ1HAV1PcDA2gkKh1c3qQYP0rnEC2sru/xdissq5?=
 =?us-ascii?Q?S9/5DzftOoapfcLYybvjQjTmq/5JoWVFunerqQzNPl4OkkLC6SVXFAyUyAcp?=
 =?us-ascii?Q?VXWAOUN917A7YNRgcZp3LpfjQZZ8OKZLRtj0D1VruoqJj9PJcbbOD0p2lqUu?=
 =?us-ascii?Q?xVjmrBfxISQNFXRIWDX7fKYYKgjuo/9qYP8tEmg0RBWBT8CE41cOM15wrwGv?=
 =?us-ascii?Q?36/sfCuu3t6KmQKLatdkm3Qa7yYlJAo3IKsPvXPMAiMmpHtMH7N6M2I3PS03?=
 =?us-ascii?Q?WKbmOpatLbYxuA0KJkTV+1TDNMGFbVqbbuRIVv8K8fm8j9SsIXA+ZokbzNMO?=
 =?us-ascii?Q?g/uL1fHwEMRaqqNQkaop7SgRQjZsHyFyh+vDOKIbCbIF8mJOzIuApROe6Kij?=
 =?us-ascii?Q?f3E5yrxMd5nvISyhYkiRBXPC3xaKIqoScMQpVJOw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b67244d-bbee-471b-ac17-08dcef129963
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 01:17:14.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yqFJFAWNIz6A5S5htlIkGZ5NSI3BAed7Utd+y1nVtlniNqXCMAlHpVp9SKA2qgCzgtAtj7aON94A8M1f9t+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

If check_and_migrate_movable_pages() fails, typically with -ENOMEM, then
memfd_pin_folios() will leave pages pinned. Those are leaked forever,
and are visible to user space as a memory leak.

Fix this by unpinning the folios that try_grab_folio(FOLL_PIN) has
pinned, in such error cases.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hugh Dickins <hughd@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 233c284e8e66..dc4906243b97 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3719,12 +3719,10 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		ret = check_and_migrate_movable_folios(nr_folios, folios);
 	} while (ret == -EAGAIN);
 
-	memalloc_pin_restore(flags);
-	return ret ? ret : nr_folios;
 err:
 	memalloc_pin_restore(flags);
-	unpin_folios(folios, nr_folios);
-
-	return ret;
+	if (ret)
+		unpin_folios(folios, nr_folios);
+	return ret ? ret : nr_folios;
 }
 EXPORT_SYMBOL_GPL(memfd_pin_folios);
-- 
2.47.0


