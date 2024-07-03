Return-Path: <linux-kernel+bounces-240182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD59269FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ED21C2157F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B515B0FE;
	Wed,  3 Jul 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tmcaTVoK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2104.outbound.protection.outlook.com [40.107.220.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AF193097
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040838; cv=fail; b=eMC9KiJyKUGScpGhBw7ZKz77HWZCenfy8wNAzdgm/zYtRbX7VvB8i0RcHrPbE+Fvzfm1mpAHsuLFcX6J/txUscLFiGtMU9YEBt8SludxHmjWMjNvzq0b46VUwvZGMPALUyquTBuv8tZhKHIZc9nzcjJ5BDJDiiI7HKJ0+KZ2X0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040838; c=relaxed/simple;
	bh=RbR2aw1zXt2EaWNj9GQ9ObPtWLEkDgJ0uBMvzr1d1ug=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g0Ab9H3knm4OCQqXBJMNnixiCFGmyo9Z/YSgGe2Y8tWO5WPHxc7pAQOS0UmP7ZukD2DVgw+bDNeA53D72Htu/R6a4anXz1JosbcUSr+jkaalnrKc8BmdrIJW38rR7eC+knFW/mdwvHUR0bLcT5K8K6p/7bX72A+4pj1o1coGNjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tmcaTVoK; arc=fail smtp.client-ip=40.107.220.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVCo85U4y0fjzr1UKL2lM7PctJ7B15R+z7R2QpI1mJRB7HxiC/UrV8PKm9N0vBd6wcU0QEoBpJuOEgVneH6v5mHbboTNgDlg9Yzy2S0bW/8gtj971GZGja+cKzo21HzHmitFyo7Bl9JEYOVlatbqCA6ufEpj4e/5KOukfn93BKSK5m3TyCGI3UPVkYqe3hEeLwSGN2Tu9+0V4I0YnQC3jEf1mbrXB+kRfQTS7o0T1sru5XMzYJOqBeFCm8FJ4Hin86IdOm9LaX0igwD2w6wQ1Lt3C7okbxhLvurMGcmmGNl3B6y0ZoeYjKvmZqkLJWIzKIuQCyVrVmwfOUP5IcD9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr7An4FBlsxD40lNG1jTKUTNLtqBPLf1gB0zofVMejc=;
 b=XpElD11//1ImMTeCj8gd4Q1+osofuAWNmX0DtGDWufx3EetyuE71+1o1+ZNEawPx4inG4VyUmIUaPIBOMrCa/XZeVzAJzoCSKrq8uNAifMxv5cwtimb0jQOIbaNJq7g0QPfkVE9QjFipJsRtv1KnwpfpuI84RE3K+uyKEU1qlfjlByOTmyd6ZzPkYzxHA0aldJLbHcNfkHjwsLwMbvzMHWnqdNJDDbUta81S4LWX4Gy1e2qCbE+O6CYXXrbd5Aaum0v9cJKvN2i5ovbokPD86c/1KKPjuGWyQsInVnUC4uGqeQyWuL+nYFiDF/jiafa6MpTvabg9DRC2U+/X24pP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7An4FBlsxD40lNG1jTKUTNLtqBPLf1gB0zofVMejc=;
 b=tmcaTVoKx/5760xRmV2KUtBp/ybDI2aRZWuU1G4OyrP/gtHqTt5cJXL/8qZFlVyv4d0KH36dDPd3tIrU9W2iQh+fBo9lcANow2rqQLEsk8NZ4+4Gm5tjjkmhlMhvjWEANDS6dTgo8DpC1DwMprhlrEjH8/Ac7vnxmrFAWMLethU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 CO1PR01MB8843.prod.exchangelabs.com (2603:10b6:303:275::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.40; Wed, 3 Jul 2024 21:07:13 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%3]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 21:07:13 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com
Subject: [PATCH] arm64: limit MAX_PHYSMEM_BITS based on vmemmap
Date: Wed,  3 Jul 2024 14:07:07 -0700
Message-ID: <20240703210707.1986816-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:610:e7::10) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|CO1PR01MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff62432-ad64-4a53-84ed-08dc9ba41c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?weo4NxN64TwHUyQuJXrfiRgSnq3BxcX6RtUzk6bvexVFuATn/H3ytQDLyLjH?=
 =?us-ascii?Q?C9+uzP3BAQdZ9HXUbc2iuhrPJ4pQtx17pXZC+/Rf6zrz4N5pSMKYXvX/bVFt?=
 =?us-ascii?Q?mZjik17f3cgYZ0rYPuK3VzGZEXqYgCvPohk0XLUsW9jwe83ZHD15KUCXRfhQ?=
 =?us-ascii?Q?MkGHRp2oapPmCpKNQXTF+tNTzKvuPVSJ14W2+UBPkEQrPFSVjgqgfSzFQ+9r?=
 =?us-ascii?Q?2bAHm6bXTH+J46gkVQiOuzGA8TGKOYBbVggxGReNgGLrdEumZNqABOZn2Bjn?=
 =?us-ascii?Q?28/0vOaFGZOPhMSCpmE01FSkyc/QQt+KT1TnT0c2OR37OHEXvpFV7uOmvxi+?=
 =?us-ascii?Q?BzwN+ZhSyBvEX3ZeBjb75uAaGXN7FA9bBbCpgumatHKk0chFl/i7acR31Kw/?=
 =?us-ascii?Q?Mib7rnmd/+mr1y9XDVfqbqtu5lrMVLbBoUvzdZIJn1pCw3kVXD3tP3KsNrt6?=
 =?us-ascii?Q?cMt0g0S1TBvQ1iUWIu5BrE6UZfsEUnOYwVCE+hYGWOGnoejtHct4Yw/W1mwu?=
 =?us-ascii?Q?QYn8yNfx6j9KORuCqZGVgPBc0KcUu933MHiGhuv3jtFHhRxXzXUNSlGqshT5?=
 =?us-ascii?Q?5u3KdDnMxplj9dvc8DJ4FJHWZSO65Ja6fRMuzjK+ns8cKR0Ku3vl4zd8Ur2b?=
 =?us-ascii?Q?iM02naHwlKCqczh8mfZJiscEqxoUNOXa2USc7A8IBEyG9NA+UtjAtXqg3cH6?=
 =?us-ascii?Q?pxyxoJewr3EMc0/wEtHiDxdRSCTUiINQFJHVo31ILRBrdNyTRJg5MBHZHQb/?=
 =?us-ascii?Q?ehmVkAJ+AicsDwwsmuDnZEUmvOa20qUszoEAsXdL6z4cuFTLVQsJGdl9TkpF?=
 =?us-ascii?Q?8uUhvSJXlkpWkBMTTgGzwSAv2tHDFOWcAZziSB/m0qiQD/sp+AxE2H19QpLM?=
 =?us-ascii?Q?adjowAY0Vt4XV4TB6byAY+DMtWHwEvpuqKAOoImO3p0OXHNzTf9/0qK9io4J?=
 =?us-ascii?Q?7M1odYc8iAUmz/0aR1ZVrSeN+w/Q4OKWrG/Z29nmgYAxcGHcufai0DTWTy27?=
 =?us-ascii?Q?SORL/zf2uVJVX2T3U5cEOJZXSi+MeIHWd7wm61AqQYeF+vRRrL67a32tfoN1?=
 =?us-ascii?Q?1qEVkF3P9ifdUMIo4UeaUfarp6Nahl9F7LSXMxivDNaJ/+WbZN9NiQ7jxJHl?=
 =?us-ascii?Q?fAQIY2FGlyxHC6w6/CskUVaiIfKfluI8uY37ESliuW1lZTcE4eYZGnZOG3xw?=
 =?us-ascii?Q?q+f2apm++pel2ht/A5t4AhcQIjbxus8pkqQiidzkAPWtcQG3Johi6Sr6UmT/?=
 =?us-ascii?Q?jVSqD/S5Po01miqQzUibxt266toXlX1CwAUfa+g9LybVqXi68LcwNkj4i/5y?=
 =?us-ascii?Q?0PgRl+TmVvETBYRXGB/slEoVXGS7hyyxBuOtKaB2MQw5rE/pfn4b/Gpi3COA?=
 =?us-ascii?Q?/u/nC30XDoEe7xPntAbJLqlvV2+tp4GAKHBE1WrkFwYNeOyQRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dnxNFAOChIUh+Ti3r1xoPcO2RAhuN1+0k/JhNvEi8VZJF6/tOk3pM9kaa6L1?=
 =?us-ascii?Q?P49oZgfhzDonsT9pdvoFvVq++yhzdyBroGuB+efPmpK7swgYB9zZDS4EGBG6?=
 =?us-ascii?Q?e9a21VizKxBidZ3CCZV48nGGAP6rDBTabY6uDd4C0VJ33EjX0RngMaoSPPDK?=
 =?us-ascii?Q?qsYwTIY3z/fryXdYEktTsqb8b5anUkwD6d4gBAtV3kNIxRywiIaIC6Z8C8mn?=
 =?us-ascii?Q?KZDoxLLTmLs0/8eVDeF16Rrk9R7Dl+wj1TMBAAmwKVjNgiN1sRxMVUO/gxSI?=
 =?us-ascii?Q?AdCNBMQ09WaJ3dt1AKLuRVt4icSc9aGgwAUpptDDuZlWuivOiXvEPjrD6mV1?=
 =?us-ascii?Q?roV6S9GB9I56rmwpw2AB7GjQvfxnHsgH3phgbBeLabmwrLn209TwH3C5ZqzT?=
 =?us-ascii?Q?B6sCqLF4Xbd9rqavI97WW662euqRUXskr9h56ih2X1mboRFyuE01bXwQItgU?=
 =?us-ascii?Q?yfJ8hjvNEb8JAMx73ols34TVDGiHfe63JZekk2Tt6+ISGF7Aahuc4qb2LQs/?=
 =?us-ascii?Q?9X9DqZ4M++MUHRXKg65Fe33mQen84xlnI41XCgx8L35dkfG0pf6Jf/e8DXxO?=
 =?us-ascii?Q?l2FRXsDC0+UrUVDJu1UHPQKKn5FquVAkJKC2+/p0zm+0qFFYvgTXacieJBdO?=
 =?us-ascii?Q?wpgYvodMDYwhGb4KwmsRt090psrtV/NjK5rB2TOyePAOnGU3Hqg9ZnfZloCR?=
 =?us-ascii?Q?4QJRh3LsTLNXwfXpbawJWFtLJvKsCsh0hwu3OVCej1gtmhH/Wq/NlURIqb1T?=
 =?us-ascii?Q?wBLTr0zws1iIeXfaoLr87UGhk17eAXk6wItpfHbgwxnobuBgNod7b92K0HBm?=
 =?us-ascii?Q?DVKk3J1nNxttBfN/CWW3R9iR8v1c+2v38/wXf+lj4jI06PU0+PUYP0fdJSfJ?=
 =?us-ascii?Q?7MQpywRCXcLbw4By8c74RHfO259ecB5MexArxPcKr5rvW/wO2eVcX5//eFHp?=
 =?us-ascii?Q?nY66KZtbNmT0tX+WKkH5GkX9f9yZOPR3qKLd7457oRuFSZyVzzjUj0mwAsWw?=
 =?us-ascii?Q?AkgegBdZaeXe01maO/Xca/jHNqvc/HHiyYbPS9KaY1MntB99HJktTqAjaDbs?=
 =?us-ascii?Q?g6ZQMqqPgvgu3wC1lNUH+nU752Rc1CG4jSH1DhEzS8Lx492K2xXt/kWEovSh?=
 =?us-ascii?Q?hY4bYIflbZBJXr99ryYAb0Mt1ChCVieZFB13kMEvMDbXCGliAi17Pkq8hFiG?=
 =?us-ascii?Q?I/obhnGm7TeDBlSvYdlEDsJhdpQnJlQVc0SGwdlAP33DK2QaSmG7B/eSZu6e?=
 =?us-ascii?Q?Y1yFDSJZspgw4r+84wl8yaNbb5RFCy/s0cpdEOdrXcBxhnUpOK1E4i5dWtJP?=
 =?us-ascii?Q?4ti9cbYcc+SOAmIejW22YIerE07WP/yvkLqI0gtC8TbaARe8sNnvn2OYiGNe?=
 =?us-ascii?Q?7aeVRlfSLgwPHLp53sqbftzsfDUvcBec/dpnc9F9LwDTGj1aGwqhkyLpfbbM?=
 =?us-ascii?Q?aQWIb9R/CzKjP5tS0BrN+HysYAlp/iH0k7OdmBIwAYI1KqcNpjV1OUAqpluC?=
 =?us-ascii?Q?lfl6liBcV1+Ist5P5rG9kQWnzJhObCupP4ykDE1ildfAViaVQXxVE0JYO9tn?=
 =?us-ascii?Q?gX1bQG8mDpxfOJ0NrbJq7T01rauPvGTAK3H0JYgLpVAHYKCNDIsOdcgBxmzx?=
 =?us-ascii?Q?rZ/H6WpBG2D0rZa2mBCanX8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff62432-ad64-4a53-84ed-08dc9ba41c0d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:07:12.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgogFPLoWqb2F7f9crIrJiCJdbP951AXIqBW0Cw+Z4keq/tjxzNIMiqBJkEEwKbG5MCnXNC05qbyPDW7ekvSS1gKLSOkLUzpdim3xZbOsTDqUNAkPO85PJz2McAoggAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8843

Prior to the memory map adjustments in v6.9-rc1, the amdgpu driver could
trip over the warning of:

`WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));`

in vmemmap_populate()[1]. After the adjustments, it becomes a translation
fault and panic.

The cause is that the amdgpu driver allocates some unused space from
iomem_resource and claims it as MEMORY_DEVICE_PRIVATE and
devm_memremap_pages() it. An address above those backed by the vmemmap is
used.

Adjust MAX_PHYSMEM_BITS so that addresses not backed by the vmemmap will
not be chosen as device private addresses.

[1]: Call trace:
      vmemmap_populate+0x30/0x48
      __populate_section_memmap+0x40/0x90
      sparse_add_section+0xfc/0x3e8
      __add_pages+0xb4/0x168
      pagemap_range+0x300/0x410
      memremap_pages+0x184/0x2d8
      devm_memremap_pages+0x30/0x90
      kgd2kfd_init_zone_device+0xe0/0x1f0 [amdgpu]
      amdgpu_device_ip_init+0x674/0x888 [amdgpu]
      amdgpu_device_init+0x7bc/0xed8 [amdgpu]
      amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
      amdgpu_pci_probe+0x194/0x580 [amdgpu]
      local_pci_probe+0x48/0xb8
      work_for_cpu_fn+0x24/0x40
      process_one_work+0x170/0x3e0
      worker_thread+0x2ac/0x3e0
      kthread+0xf4/0x108
      ret_from_fork+0x10/0x20

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
 arch/arm64/include/asm/sparsemem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 8a8acc220371c..8387301f2e206 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_SPARSEMEM_H
 #define __ASM_SPARSEMEM_H
 
-#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
+#define MAX_PHYSMEM_BITS	ilog2(VMEMMAP_RANGE)
 
 /*
  * Section size must be at least 512MB for 64K base
-- 
2.45.2


