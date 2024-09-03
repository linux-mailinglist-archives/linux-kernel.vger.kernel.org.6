Return-Path: <linux-kernel+bounces-313383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499F96A4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2841C23525
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D87817BED3;
	Tue,  3 Sep 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="R+qUZF7I"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554F1E492
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381943; cv=fail; b=mkTmKMKYmw6LE4PfzHrE4cRFrJ1/diWACyNywsvXp96myVP0wWZ7oZ9ZACDkUSYRukCFVQNTGgEvUT/2nlbcCOrB4H3JLFOyZm673G6s4DPXMeK3wLsUTQ8jGVYt0rjT9ysRPnOIVJTGZG2xFvtefgh6U8erm8zEGy6uujJ4/O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381943; c=relaxed/simple;
	bh=giBhW84YlAA9uolrv0AMaz6AOYnWkE5sR1JiyNG7Sh0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pSdB2nAoLVizEi0SPLG+FVTTdwhITNQ43PInFkETZdIJ4Hi721mTX/E78gQy+KOM2fMnPk62oNil24WIYjGTPZY1gyTQuDwBUa9YqHGUGfipajTNHcL7OsnponwNBXzDXYLOEK7xNXsNjAol1lm+gWIzCAxCH5Q4m/IELbQt1JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=R+qUZF7I; arc=fail smtp.client-ip=40.107.223.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlYcSJ43xxK4pKNKD7agVEQIKp8SvdXsvu+u5aUiqt/bA8IAQAuwSRBlWM9M7dR7GIgNF8h8xcxcevlHqtXen2vyclxaCl4Gm9jkGyBmpATYjIumn13/c1U9NutlqEqxUXQDYIWx+RY/bsIPZeA2QKfLKbiXBtvjqpNHFD993+KbsJAebNT7ECHQ1fE6fsE4MbPtLSQsFT8q4b9G/VDJVeX2/v0MG0FD+GapWw12i1FcgLdRjVGZLBSSgG+lCZzAYMoLXAUjB76o3Q19rgclgaPBiCUE1bkE7ZkSJB9lwuGarB72uxDn27wyaBpaLqBJyzQJpfoJFU0jemy+MDHsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df/XyA43DYdDjGBfCcgN8b3U54LTgkInDm9dCaMVI+I=;
 b=GslwLxHmOGiCan/rBjYs1w3m/tNcQs8XnSSuVNSVoKWFm3IMEghV4aDl3Xp/lDVpDfsn+NxZLg/qYZlYcPW3eRsVvZwdsKVPLvGxLFNCN0rYY2LnFDUEftExz3wrP+8D0zEotkIRSdKh6UkIzEpTOwsyx50vzSXwB0qFtb7CsHX9G5cTaZ93fzPrvL9XkgC81EzsTCYPXcZ3PQx/YpwZURJUp7k8OsaI2tI03t1G67bl62yooglFXCB+BsGeKimRxhVfknToB56R970DPitAzzsB6FJVyMlg/6XBom+qNNwDcl3iguBjPwlwVScR3zVQ2Nop0GWDJCxjJX6mpMXEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df/XyA43DYdDjGBfCcgN8b3U54LTgkInDm9dCaMVI+I=;
 b=R+qUZF7Ipc3QSv9eS+zFqEjEZ2G1KTeFb82wP1+VWmCOAvGa8KLSKQni8gQNWteCHhh4GOLYlESOvNBUhijPgsT9NVHWLaVGFESsNDlda49hF79mNgmC1QEjOy9QskAwENEUzbiv7em3fWnOGKWN26OoG7aESXKG9nNQv9GnTTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 SA1PR01MB6527.prod.exchangelabs.com (2603:10b6:806:187::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 16:45:37 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%6]) with mapi id 15.20.7918.019; Tue, 3 Sep 2024
 16:45:36 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Catalin M arinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Baoquan He <bhe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com
Subject: [PATCH v3] arm64: Expose the end of the linear map in PHYSMEM_END
Date: Tue,  3 Sep 2024 09:45:32 -0700
Message-ID: <20240903164532.3874988-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|SA1PR01MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 58757440-4b8e-48f5-a170-08dccc37d5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DGL0wD6wOkbdhki1klL9HvJzD2BgUBAAflFUy0VV8gzb+X6SZix1/EfT+t7x?=
 =?us-ascii?Q?tZG9gzfflvRw3yBZlGjyuy+fbapesZPXIYIKy4rCSc537lzedFBKdazJP294?=
 =?us-ascii?Q?Yuk8DalvzUQUpNR4YSpav2YYVoXmuMreqS8GTszd+H+gH+VHXA4S5ya5Oszs?=
 =?us-ascii?Q?EIdpty8sUJDen0ScLiCi4o7E6lIb4aJBpD6kzsETt0B6QCLkBm9BNWHbmOG9?=
 =?us-ascii?Q?mrCCIauGQtb3yP5z7nMhGGsRGlSxObUGrKVTKb9IGgVFLX8P87degb3hlpbM?=
 =?us-ascii?Q?DsuPjkRPin9WozsohHscgFS2mM6m2t1Mru3JAI7eEZueQojW86LRy5C0O+zD?=
 =?us-ascii?Q?XcxVrpPe67DBHJSuTNrO9Zsr3L1QXonMfnjmqJpVd5PXd312+4fkPY9Y0Hkb?=
 =?us-ascii?Q?/8ZPFTLxAlr13dU1G41K+GJwbuODCDFLW4+yLANQSbzwihNAuiltlEoezx36?=
 =?us-ascii?Q?i0mbahGPp0l4ukHpbAtJ8egynSW/fsOjVpfw4VBuHUzSZiMlovEh/XwRjbS3?=
 =?us-ascii?Q?NrRgNuEb1Oon1n97ImkKl4nW5B/IW8kQRUaMJfvBTobHf1KD4ZD62SDka5/M?=
 =?us-ascii?Q?9/nGxcv5J3dpULiggtmA8MKP7l/32/Vey1PUMx8CWVjV5bv6IpywVJ965YYs?=
 =?us-ascii?Q?PRzjssmR9DiQqHxIIAuuUVqm3tWt2UQA9X2Dfdj16wcvGMcYAdCOYw8hjuDM?=
 =?us-ascii?Q?gWEN/WyN8RNEsddSZ0yEwQ7NUnadrGVPtVuISwIk5EcojQzcJS50islOjCiL?=
 =?us-ascii?Q?7XgZMiIHXPHqMQgxGDzSXiMRfPUBdLzdHR6Q2elgX3KwOnTF8zXDEAyEBPIE?=
 =?us-ascii?Q?0dD0zQ8RjtIBDBMUcOOEH+7HRquCXuNXbcp3dlJ/kYHEXv+VopezqQOfoNNx?=
 =?us-ascii?Q?q/wANilTxsuaSxyi1QFd6kFdkRVVzZb745YN43p2C8wTdCLuEtQgQ37r5RBV?=
 =?us-ascii?Q?EdsBL9L0/7fNi5TBnOoBiECqVXe+uR8JOTaNZYNA7NReiG2bQ+ZKPQEZQPKB?=
 =?us-ascii?Q?jAARDjp2vbfaZ98BpTIWREZdAZRncEsHNP4rWSH8XJ6ZtIrAlYzRzaos5XQ5?=
 =?us-ascii?Q?9fWwNw/dRuKbnUGz9vHWEd5TgebtnsHYw7nme8Fr2tVQdZ4DNVG0VxGc8d95?=
 =?us-ascii?Q?YTf32fj94/4Z40P4oBxUdIk5qQsP7p1qCG5zcM5jGRyagCeMsEP1SZouwpq7?=
 =?us-ascii?Q?B3JEkrapX6PbrWx8QV+Raw6akjEOPEd/rLziT2ZeVoaGkdMjVKV8C3HAJkmg?=
 =?us-ascii?Q?FpLAmojxexWbZjh5xhznKmUoD592w2VBRhoi3htdWvbgDdq7YTtl0aYVr0Th?=
 =?us-ascii?Q?xUxFrnKiAQeqTU3VvF+vvd2ZKvljNxY+AlW3w6O1x6fclceIW8tD3WfGcbqg?=
 =?us-ascii?Q?igP7EC1txrXllrYMIr8IXumzseSDjYSvg2weBpBr0wGYadkqDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjEso14nBs60gS7auwbgNKazAWzdfFbELK1aqlhrssROb30Z+803AHiq7l2h?=
 =?us-ascii?Q?h38hK2yraGDABmNhhkWzqg9LIWg52ctOnLpznWx7RW2RKOUTOrMcZOvINV9o?=
 =?us-ascii?Q?CvDFWDXEXtngTfIpKuYzx16i4Mp4VpsGc5an9zbnKfbZsmKix7RUOrbBjxXh?=
 =?us-ascii?Q?0sWf+urG51k4B3ZtmzyjFHctsoao0pBnOXAaXPgKnYFicMMChLb/zwPZxnwQ?=
 =?us-ascii?Q?DMT2hKACgSDbR1pcfE0ml8/+b0yfugfEQvfb+2fh4xDh8i5agkjA1wP5a6Qu?=
 =?us-ascii?Q?xm+Hy6jFo1Vz9zFxfxx+MC+YX+NmIRgtmdKsCLC972x+oBcmgZPmYOO0GGTu?=
 =?us-ascii?Q?OEFQQFQGWLj4C5mgI9+HGN2PqldB69FaOmffsjTNuPOY5a3YOqprkDGbwyFn?=
 =?us-ascii?Q?QzqyNNazsKxmiVBuqOVgltvr+a72cuvn4SoArSYRur2ym3q5meswX38jko5o?=
 =?us-ascii?Q?cLbng5qPmc6c80wUAk6xgKTh9jgQb0Es5dLaHbE6AsxwWXuSbkUZ5zytsRtB?=
 =?us-ascii?Q?eQo1NNd7b2LwAu3agnAr4OdWPO2325MmMgRpGwDl08u23fXHEyi78k9gjdUl?=
 =?us-ascii?Q?YtBXikLRfJ1UAJya6BWJDNzBo++owVQGWl3PjKiH1AcJneAM/9IFZFLIDcAj?=
 =?us-ascii?Q?ZXnbZCVbefPBJgbZ4gKFwu5ylQ16laZ7t4SyoLBK3g05c/vJ6d5XhGIArFvU?=
 =?us-ascii?Q?RmtP/7c47aKdbc0W8lKxkKN4Y4tD/pt7d7bdAPOe1Y7fOsRvkidwURmL2U4h?=
 =?us-ascii?Q?L36DRilZ5nBj1NM/WOxUa2NsNj5rVh7MTM7a9FCR4L85ZQzHbZq5Pyt7JDvp?=
 =?us-ascii?Q?gH9Z/J7LDrUPTu3wyoQ2mvMUe9OpCcGjC5YCj/E/vyo/eF1DguxyRoMdIY1H?=
 =?us-ascii?Q?uN6tOMvX0ZJEDBXa2F1RY+Q1rQ/3iHFlX2kqA4z8IV4ulKp7+lYb9UdiT3I1?=
 =?us-ascii?Q?cNCa0Da0xcXK+TTVJxUdhmwIfyo9V1/1DF9XH5Yk6+bS6VoLPTZwMiCiq561?=
 =?us-ascii?Q?sQFcl2R8KqaOATurKIRi1epPvMLmrYJzb2SPMYoqGKXD+8hG4aAiQCvu+7CW?=
 =?us-ascii?Q?pdQcLHOfvoIu/FDRLrQdJzYnxqxgEzPQ/jYdjnjSimmnCUHMhw9HuuOorKUZ?=
 =?us-ascii?Q?lD1xN/pmS4tgHF2d4RWdvF8knpTjNadr3Pvs+BbY/grp+JoJq9OxhyPtF1GE?=
 =?us-ascii?Q?FQW8MrjW79IaA374qK8MT5f5+U/yDdsRiJVe4ZIFPJI3hEfJNyTNZY1Gq7Rd?=
 =?us-ascii?Q?st1SEknSef2cuuauZSNqGVZJRpWu9QVnlWu5iIROwo5bTFbk8QB+da8aOrbH?=
 =?us-ascii?Q?GU4zxqbcjN9s0Pbhs413s2Lyi9s5PUqww3EXdFokBQc0kYA9XnduGj96kKJ0?=
 =?us-ascii?Q?VgDils3vBCcwQa1KX0hnEF1iazQ3Tq4lnSeKI59hxGEmiHZSShW1Iyd4B93y?=
 =?us-ascii?Q?uTQk6Sg8IoCrfxwHPMBLKqeDpyaLJ4m/Dvu5Ws7ogej/KDc+pOCYTuHX3PkI?=
 =?us-ascii?Q?/rQmmLo4EWEzI92h/PwP9MsD824aEUc83dSLg0NgTcJzd1XOw/uDeqnSAeeX?=
 =?us-ascii?Q?y2LRlobgtgTO7voFE4mDe1NBOk2pf5L/PnKXLJ218e4jlm8Ct/JMYflSc1cM?=
 =?us-ascii?Q?5w9lBOi43/+3eFnBPbA3/W8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58757440-4b8e-48f5-a170-08dccc37d5f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:45:36.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9E2bhCkI3vYjouGlDWmFyihn0oCWRkR58sRoIBuHyMjxzod8Rj8mfUT1owD9LtCntHNxU5tgZ6+WLeInnSAbCqVFnMTn2D8R+nQt9obr4Lo31luK8vBqm7lkylIIrD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6527

The memory hot-plug and resource management code needs to know the
largest address which can fit in the linear map, so set
PHYSMEM_END for that purpose.

This fixes a crash[1] at boot when amdgpu tries to create
DEVICE_PRIVATE_MEMORY and is given a physical address by the
resource management code which is outside the range which can have
a `struct page`

The Fixes: commit listed below isn't actually broken, but the
reorganization of vmemmap causes the improper DEVICE_PRIVATE_MEMORY address
to go from a warning to a crash.

[1]: Unable to handle kernel paging request at virtual address
     000001ffa6000034
     Mem abort info:
       ESR = 0x0000000096000044
       EC = 0x25: DABT (current EL), IL = 32 bits
       SET = 0, FnV = 0
       EA = 0, S1PTW = 0
       FSC = 0x04: level 0 translation fault
     Data abort info:
       ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
       CM = 0, WnR = 1, TnD = 0, TagAccess = 0
       GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
     user pgtable: 4k pages, 48-bit VAs, pgdp=000008000287c000
     [000001ffa6000034] pgd=0000000000000000, p4d=0000000000000000
     Call trace:
      __init_zone_device_page.constprop.0+0x2c/0xa8
      memmap_init_zone_device+0xf0/0x210
      pagemap_range+0x1e0/0x410
      memremap_pages+0x18c/0x2e0
      devm_memremap_pages+0x30/0x90
      kgd2kfd_init_zone_device+0xf0/0x200 [amdgpu]
      amdgpu_device_ip_init+0x674/0x888 [amdgpu]
      amdgpu_device_init+0x7a4/0xea0 [amdgpu]
      amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
      amdgpu_pci_probe+0x1a0/0x560 [amdgpu]
      local_pci_probe+0x48/0xb8
      work_for_cpu_fn+0x24/0x40
      process_one_work+0x170/0x3e0
      worker_thread+0x2ac/0x3e0
      kthread+0xf4/0x108
      ret_from_fork+0x10/0x20

Fixes: 32697ff38287 ("arm64: vmemmap: Avoid base2 order of struct page size to dimension region")
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: stable@vger.kernel.org

---
Link to v2: https://lore.kernel.org/all/20240709002757.2431399-1-scott@os.amperecomputing.com/
Changes since v1:
 - Change approach again to defining the newly created PHYSMEM_END in
   arch/arm64/include/asm/memory.h

Link to v1: https://lore.kernel.org/all/20240703210707.1986816-1-scott@os.amperecomputing.com/
Changes since v1:
 - Change from fiddling the architecture's MAX_PHYSMEM_BITS to checking
   arch_get_mappable_range().

 arch/arm64/include/asm/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 54fb014eba05..0480c61dbb4f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -110,6 +110,8 @@
 #define PAGE_END		(_PAGE_END(VA_BITS_MIN))
 #endif /* CONFIG_KASAN */
 
+#define PHYSMEM_END		__pa(PAGE_END - 1)
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
-- 
2.46.0


