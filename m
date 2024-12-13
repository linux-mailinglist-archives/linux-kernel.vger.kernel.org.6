Return-Path: <linux-kernel+bounces-444293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B69F043C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0C2188ABA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C53185B68;
	Fri, 13 Dec 2024 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uY9cPSp0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2104.outbound.protection.outlook.com [40.107.223.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359844C6C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067921; cv=fail; b=CAKV+yfVXFll42tC3DLHAq7karPva33bpv1Ww00dqB0/yyeYm/jtAMqxFeGgX+DONlu9tD8TrUbTQUawtQMlvXV+d4tkJ24HuFQY52a0N6+R9d1Lnkp8Lx9xGxIHaA9SGMlDDFqtkT+1aUQbAGbLO24wAPt6Upk37gyV58dwx4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067921; c=relaxed/simple;
	bh=9xIXuXBkQY8pv4e1gWIk1HU28tR8UokS7WP2FWBzZ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqRWQWx4i/2WdAjEwrXIkNTh/HOXf2UO0m7GKDMr5SfsDLCDeDa7RDSZyTBv1dRE7eZlpC/T2sTNzp6SyOK9Zy794SmFkd//vFtnwQRnmTsolQX11QCvAdKJYYm5eyJeFMuYborrVYTDyihWNhva/7oamY5dwFGysS4j84/8RyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uY9cPSp0; arc=fail smtp.client-ip=40.107.223.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOkx6JLuSQ72ETOimRPA+IfXw1DUbDGDu1yVECFQOPmTL/VZAL0GDo/XNSCCWvvc5gbQcm5N5ABu6N+hEMDEZrLWqNF0cIz+LR8HdkezOzgPWTurGT35RFgGZuHKZC6dOSUZS0xWowbBtZHNLG89lUYJYSCqs6ZmKQA+Ipkuy12MKN28e2OMjdxI1H1qg3DSg6N1luW+8VgdBR2ME2F63Hc97JlmvqfoRCbDHhrlJeUAGQm+S4ZPEAQVTz3nmR55GZri/4iCWKcajN6LDw0QbcdONndkym8zYfxn7kl9Glk+YyYwcTf2RpEX2v5Z8M/x93p+rkCt02o2pZ0fhK7Vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRHhT8hWESy6pQarMOcmjVGiA0htP/Pw6bI07K0UWTU=;
 b=UPShFByfDhoqKyKqo6/d4szctLfmYIS+IsPCcgqhGN6ORy+msg3GYbxF1i952LbeQirRZpyLifZ6hzPJt2BXp+0i9u3weKvAFWWt9khfOoqXyRm8kEMpRBKTxZgv/Wf2tKXT6z6woDrsY13a0BL4+J0+H76EDRsr7H7HUMOGISHfuzKEQZvOXyyddauQYPUJmmcVI3grLqLgjevYGek+xWZ4nvogygRGoYN0tyNooCHeAvrHxPCFGubfexMIAdy6isor96wIsg7Jnyy/cZB+m+Out+tjZwgXgYRf7naA2ciM2yPXNtVy8XIk3bz9RSA3XQf8ucIm8ZIKoaJcMBJC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRHhT8hWESy6pQarMOcmjVGiA0htP/Pw6bI07K0UWTU=;
 b=uY9cPSp0U8nZcp2FiDo12R3kuz6x40yjgbKLj2wCqNXXNcohW5ngvmcULgNFvuSRAh+hzvSMKQ1xJGjQlfv7XeHTikxfmqZICVBXKK+C7+odJEdjPBoJhSokJ1YDUu/ialPb5bxEvOth/Yy7sE7knYHhT39sh3LJRFQb+bkNEDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BY1PR01MB8851.prod.exchangelabs.com (2603:10b6:a03:5b0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Fri, 13 Dec 2024 05:31:56 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 05:31:56 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	corbet@lwn.net
Cc: patches@amperecomputing.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	inux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v4 1/2 fix] arm64: refactor the rodata=xxx
Date: Fri, 13 Dec 2024 13:30:49 +0800
Message-Id: <20241213053049.7592-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241212082426.4110-2-shijie@os.amperecomputing.com>
References: <20241212082426.4110-2-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::20) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BY1PR01MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: f7552657-f823-4a3c-1516-08dd1b377532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kq/7xJF6ashhEFKQaBtz+bAT5R4r1FU8subU/A/KOITHrfp+q83jY0GYco2n?=
 =?us-ascii?Q?AiV7PoUAc49ZWbYguJG6cqCNlNBKsW9N8ZTEbOFL0XD/HO8R83mwKOEsF/cX?=
 =?us-ascii?Q?zyHj1McDYmp3dwXE91n4cJjSaEAU38pOadu9w+2jBikqRslpl9HgKxbBj8cj?=
 =?us-ascii?Q?O9Q7JEN72NoM4y0bsu3tiQbxXRl3v1skl+jcCf6Q6gBHNdThx7S0qEhUGnK3?=
 =?us-ascii?Q?s0LpovW2s5WD8loDr52IC7+iP3/f+32dE53b8+cuW6suiD3jSSki78TGgvhn?=
 =?us-ascii?Q?mcXOqWEAG1WSwuO/kdzLgH/AfddR2TVPCqskHIzzIUKP3ROF2AIgQ45xBiVe?=
 =?us-ascii?Q?lwduEI4zkA4ud2QdBu4aYU4Oh4/IBo4wWUq3KU5hh4dY06fvWZ4cBd6zUhc7?=
 =?us-ascii?Q?dRw0JUfSRIfl3Swjc9pdCD2PUYwcKB58CJCcCFbixKjySaag3TGu7qWmhi2q?=
 =?us-ascii?Q?6bcv5T7HMIZZ7f/BU4JXLsAizPMkyPz/I58AzODQe64UThosl6+xJL4BC1k0?=
 =?us-ascii?Q?o8PFF5S3GJH5qcaPVxvooTkckUJErOvriswUg6x2UNn3KA2q6+TpMjDLaDRJ?=
 =?us-ascii?Q?Wj0UIrjB0OoiosP3/5Zxirc5ilIODs0POcNmw8CjJoftncEMiZOK2x7Mb4Sr?=
 =?us-ascii?Q?HjT4bBkx5ae9rHe9sbt9Qv0sCTwRy6UDH7PHZUMURJxvjeqO1RPGMC6Z+yN/?=
 =?us-ascii?Q?VeVYA2tkt6rZ4pqK1Crgkoct7C5825cvEEYqzaj88DzsUwJz2QCm85M763nq?=
 =?us-ascii?Q?antCq4NfiZ03z0BKqrXO2dEmKKXSSo8vkquPa2b2BrBXqFo2QXsgABceCpbg?=
 =?us-ascii?Q?UsDtWdtkWnvv5W82TeGIvjyrkGNWT7m4XIHSzHw+8bkkS7n70vEGTCD+qGGX?=
 =?us-ascii?Q?DfVUNqshTQVDpEKWBVX7rTZdND6g5Y0AD2kVlGOXP6NmZ9AO0NxZUhUnxVzi?=
 =?us-ascii?Q?UOxZMf6edjXNqgktBhueuNk3R7jb+oPWmcj3z3lZG4wxqQWVxHK7MLm9gHqx?=
 =?us-ascii?Q?aX/VuoVUzrFKvP4aLWYfYEIqmAKJSE2dWrqwS4KCE8HJoz2TTBxlBEVi+AZu?=
 =?us-ascii?Q?siCZ7glB8ZDDa3YB76foD8jhrET4lH/TbXVPLwFdrWgTNIMg+QQ3i1kxIEML?=
 =?us-ascii?Q?cSpH78+kMk9GLqLyypJPGwRLEvC15oWCwwqktdJXS3q2sNWXkWV5AGgArIJS?=
 =?us-ascii?Q?NddGOBUZvnKs0iwuHb7qLre0AkmJ6q8xvls25yrjG1+NcjStO29sg152hkyF?=
 =?us-ascii?Q?OTCTACGhgNaCndpRp0x8jJCDnR2nOnMk6tuSCN8/Aesz40r4KE9Ki1xlS6dB?=
 =?us-ascii?Q?gB04dt7CjZJxzWxgh2wRrTCJjdP81Bfq1uJFWll3ajqPkZUVA0WgJLo+IhK0?=
 =?us-ascii?Q?AZ4aibP9e+fAzDXWMQJSctymJ7GTAOFs8MJte16dk8mDFp3CEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1a2jqTKeq3rvIWMAeG86Df33vWraIivAaVCZojeJXBTPgNQdGtisOXO7yHh?=
 =?us-ascii?Q?hmhNUj5ddUrgDxZhi99QVlk19RpXkPpCSP6T2nxMzopxaOUOmx3NxIOhVABy?=
 =?us-ascii?Q?gChmwDUC4aK+WQBH0d8f50LI/dDSKpUO6O+dRlXogY15/nBG4jbqYa3nIyA8?=
 =?us-ascii?Q?T3szEdcXZuBY3bZ3MwMJon/p5xqDTntLReNYCRzPVjlgyruouMnQEmLKaed6?=
 =?us-ascii?Q?8DU3S/aYTu4F/okGRQw9oGeVsZ6xsCG+FNmnRAsylnfOz6l61LMAlfpNbcTe?=
 =?us-ascii?Q?RJTXFajy2VbRjlmrZDi4nNWDgYVVcCyjxS+pQ0c7qvKsU6Glqvtd/lwElIgP?=
 =?us-ascii?Q?BXttQ52ACIYf01AZrzbjBjfp//fbNkVUv/c4Gn8sTeRlkIYJMKFsiUwlDotg?=
 =?us-ascii?Q?Nu2jO4TyMhn3uOW7aJSWVK3/fDolGJVT0d82u3ewqkeLC03eZGdTao6APpH7?=
 =?us-ascii?Q?2plFQ3xfz99ff20Peb8iO5XZk3QtAwX/MwNZsWtzPWp+86S7iGOtMCCv3cfT?=
 =?us-ascii?Q?wAKtdulWfUgxR3DFnQhUiibUmnObGw5AeJlJrTlopS7q1wHTJlz/BxBgwDqy?=
 =?us-ascii?Q?GHAHIaKUwV+cQCklXbcpHzSZK6e1VWXtnuGMedfmNsywsZ4XV50AFgFNKGO3?=
 =?us-ascii?Q?J3PohDxIbMm8+LBZ6B0kw/osUAul3lmEv33vBbMd6YMoTHOx7L3ID2g43HgH?=
 =?us-ascii?Q?guqH2YPpMK7wBOMzlStAnpcVs+wGcGgXVHueqLf/wg9B+/UzrsNLMkaJ43bI?=
 =?us-ascii?Q?zC8IiPoxes1MUkabMiMkCcUJn+9fI35AjmTCLYPAqWN4U4jWEM9YplZ2xDhX?=
 =?us-ascii?Q?Yt7EPNgUvi2zJfHB7Hj2A2rXNJhuBzgExNls7TRodhxBv6/PyIAQMeKlJ3Dy?=
 =?us-ascii?Q?3s+gWyMgSeypCJeIzB3xRV0c3LhxrZJc3DF+gA1nRluW7lwginZ1E79Bzrct?=
 =?us-ascii?Q?t6wRVa11XnBko54nqhbqIMwb9dZNL4ggAQR8o/oHsY0gFga1SRJPGVW+ZGyK?=
 =?us-ascii?Q?92kkPUSJ35WJOcGc3F2/8+A7SNGXKBsoON/Qt8Lqdpe+qZ7CJV8bL9Sx4l+R?=
 =?us-ascii?Q?aDMV6kVOoVn6Arp0w0DYe2wgcjH/SJs9FAbZkBdERDImOx61xYSTxy/fI8nQ?=
 =?us-ascii?Q?lmLcsqk6L5XAm5JIZQNhgmvw3zNXCrp6/H2GLjdsYZoMjDkE4XyPiPH8HhAr?=
 =?us-ascii?Q?f2NBSQVT2E4M8l5eu191TPDEzRuTq73Gqe/sliOP6VLG90AcmOiAVUQQYsxy?=
 =?us-ascii?Q?tROIpizGEM1uCFS6zkK7QsfXwetK9l73kNy3Mmk31I3pU0qVSINVocL5BK4O?=
 =?us-ascii?Q?U3baG7HWFvvBh6O3dV61kElhH2IoR+FHT7jlFxdNS2ugfLppv1nlKQYBHAyc?=
 =?us-ascii?Q?kepCi8t9OFmL4SN38Z8xvtrHRSYeiClIuOsHT3QfwiLgI5AGbkdaqX90b7Le?=
 =?us-ascii?Q?hsaGza7ORGKvTh6t2FrvCX8b0GTsSXVwtOGNDif/toKYfokdCfVJ9qBVsDIj?=
 =?us-ascii?Q?hrpg5Fv1lhixBHTQF4AodTocOeUXSkdVwKTAZKEGEBiTJMyjcZE9eQizUzqm?=
 =?us-ascii?Q?KS3aCIuzDQvfnhXDpsVCJTLRksubBJFfObYYXFdHn87SkTm18/dEkIPwGsxR?=
 =?us-ascii?Q?uBEGBF5XAESRjV/Xju5db5g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7552657-f823-4a3c-1516-08dd1b377532
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 05:31:56.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmy2aB5Od5Qvwp+QdcGAj+Iut6UFZ6GR9X6uNi9pCC1F6gbssZ6e0dH0ls/d/BslcfYtpe+yXbDdpKFS/+V7bG9Hg25lE9kyG+V1YSJs0jMKSWfw4358ZgGKgLBbPFOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8851

As per admin guide documentation, "rodata=on" should be the default on
platforms. Documentation/admin-guide/kernel-parameters.txt describes
these options as

   rodata=         [KNL,EARLY]
           on      Mark read-only kernel memory as read-only (default).
           off     Leave read-only kernel memory writable for debugging.
           full    Mark read-only kernel memory and aliases as read-only
                   [arm64]

But on arm64 platform, "rodata=full" is the default instead. This patch
implements the following changes.

 - Make "rodata=on" behaviour same as the original "rodata=full"
 - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
 - Drop the original "rodata=full"
 - Add comment for arch_parse_debug_rodata()
 - Update kernel-parameters.txt as required

After this patch, the "rodata=on" will be the default on arm64 platform
as well.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
Add more descriptions for "noalias":
  It is not a security feature yet.
---
 .../admin-guide/kernel-parameters.txt         |  3 ++-
 arch/arm64/include/asm/setup.h                | 27 +++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a22b7e621007..f5db01eecbd3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5901,7 +5901,8 @@
 	rodata=		[KNL,EARLY]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
-		full	Mark read-only kernel memory and aliases as read-only
+		noalias	Use more block mappings,may have better performance.
+			But this is not a security feature.
 		        [arm64]
 
 	rockchip.usb_uart
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index ba269a7a3201..0ef57d19fc2a 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -13,6 +13,29 @@
 extern phys_addr_t __fdt_pointer __initdata;
 extern u64 __cacheline_aligned boot_args[4];
 
+/*
+ * rodata=on (default)
+ *
+ *    This applies read-only attributes to VM areas and to the linear
+ *    alias of the backing pages as well. This prevents code or read-
+ *    only data from being modified (inadvertently or intentionally),
+ *    via another mapping for the same memory page.
+ *
+ *    But this might cause linear map region to be mapped down to base
+ *    pages, which may adversely affect performance in some cases.
+ *
+ * rodata=off
+ *
+ *    This provides more block mappings and contiguous hints for linear
+ *    map region which would minimize TLB footprint. This also leaves
+ *    read-only kernel memory writable for debugging.
+ *
+ * rodata=noalias
+ *
+ *    This provides more block mappings and contiguous hints for linear
+ *    map region which would minimize TLB footprint. This is not a
+ *    security feature yet.
+ */
 static inline bool arch_parse_debug_rodata(char *arg)
 {
 	extern bool rodata_enabled;
@@ -21,7 +44,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 	if (!arg)
 		return false;
 
-	if (!strcmp(arg, "full")) {
+	if (!strcmp(arg, "on")) {
 		rodata_enabled = rodata_full = true;
 		return true;
 	}
@@ -31,7 +54,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 		return true;
 	}
 
-	if (!strcmp(arg, "on")) {
+	if (!strcmp(arg, "noalias")) {
 		rodata_enabled = true;
 		rodata_full = false;
 		return true;
-- 
2.40.1


