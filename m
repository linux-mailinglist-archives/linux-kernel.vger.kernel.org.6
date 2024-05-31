Return-Path: <linux-kernel+bounces-196197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195D68D58B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48BF287133
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7378C65;
	Fri, 31 May 2024 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Dn2ixvYN"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2493256D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123715; cv=fail; b=XQ55anRzpmiEqBW+khJjGJ0wwEWDVFm/qt86H8to/rleJ6VU6uxYgtMp/AkELjF/3pcnVP70RXbcpmgZxCYcVJWHOlnF2fSkTX6IxnnlC0ibsKv7nPbYbQIAiIOIj5bqFtO5ahIlE66OBFDKZgcD3YICk/Wd5KYoS89Ues2+6Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123715; c=relaxed/simple;
	bh=hXpm846HVMzWpE71Jfh2NIUZBAgQxko3AtQiGAvq3Ng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+lkCyCydlscdikpaeNoFIJmJlBqP72OfO3OTYbg+eWMaq7h4uL0BCkDwEdvBGwU/H3Y/fjRftOCLIVd8Pw6kf3fACEwS2G3PsN48m6fh6QoZt2XYBzdGSMicbJRqq0koOrx6UFz7W1afFxJjoEU8NYN9r1/5c5hTUE+sXHFUJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Dn2ixvYN; arc=fail smtp.client-ip=40.107.117.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHWEyK5tjZ5ihFJWL5jVv6mKGLQTj/E/2wtEUgJ/fSYXWkVdBspDbD37l//cU1qFyqYKOEUeFNoX3aKyG67/nAd3Xqb2mwVVfuqNycZ+Wgwab2HoeKYyuMvSpnjHabrFeIdy9rZo87vFIPkRXypr/TxDk7AbJgii24NlWt9uo9UCFlwtKQ1LoirRSwKdXBLE27NAjL6/YNs0liJr9YsCMbCiL3bm0MNghUyY+phl2PfljNKm5Cg51VF6LTnxJdbomzJ2p+d+/Sd+RsvK3S9CTpTt3pR5Cv/Oez688wMHZmmxCha1ynBp1iUQqbGe1SKfPlvl5B+dH56F1tMkcAKY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSsPEhSqYtAUWFgSxFfeptI40ZNsE6nLejj9bfMpIkM=;
 b=TYn+Bf4f7o30sXgZJnFfGUQYdoFHxFyF1y2cF7/ADmIMb2lkqAftuLD7hi9U/uXr8UFyaLT5fmZZZioOGUKt40Mu81VVmxZcNo6Q7QXMvN89tD1EUEubEVlTamYTo8V0sdwy1vheTNM1q4zeeawhxv77K2m04ns6xVJrA9cd1TYP5WyQRcFbKOhyhSwX5Es16SLdwh7Jgmjg6qSqDmYmn+fWCdoJsCvf3+dQrZ+cIdBTXCgleLwh8/76BTrExD/CHfET86FwNwDIX0b+lfgf+zbJUQQxFCw2uvUktZvWySxRPY+dgTD5m5iyL/JE/XYJqkL5qUupo72RMuULBOwICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSsPEhSqYtAUWFgSxFfeptI40ZNsE6nLejj9bfMpIkM=;
 b=Dn2ixvYNJsOYfge4J0vfGC+ksLHOeWCIz9VGjwa+8LE4iLVJjEW2EkxDmLx+9KweYJW7RWvfAytmgKxUnXp+IK51MzRSMLLnMYhsors/V6/XbiruBc5ZiKKSpFaHWjLVGK8xogctXLQErdsCV8ci6TCTQxPXUU9trMcS5tycAqs=
Received: from SG2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:3:17::14) by
 TYUPR02MB6276.apcprd02.prod.outlook.com (2603:1096:400:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 02:48:29 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::94) by SG2PR02CA0002.outlook.office365.com
 (2603:1096:3:17::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 31 May 2024 02:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 02:48:28 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 10:48:27 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <guangye.yang@mediatek.com>, <zhaoyang.huang@unisoc.com>,
	<tglx@linutronix.de>, Hailong.Liu <hailong.liu@oppo.com>
Subject: [RFC PATCH v2] mm/vmalloc: fix vbq->free list breakage
Date: Fri, 31 May 2024 10:48:20 +0800
Message-ID: <20240531024820.5507-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYUPR02MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb0567e-223a-4246-2485-08dc811c266f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEpVZFhWeEE1cEcrLytJS0FmQXVDWkVjVUxjRExDdGkvTU45Qm9ha0pwRFMw?=
 =?utf-8?B?Q2ZHOWRsKzBHOWFDWlZpalFWR0dUWXFXQlRPSmhyNWQzRVhWYTNnOFlTMEkr?=
 =?utf-8?B?SnBFUVVwRmlrU1dWdlp6b2ZYcElUZ05uV1hQZEtKVHU4UmhranhUcnI5cGRy?=
 =?utf-8?B?ek5tK2VLcm83aWFjR1A5QXhJeFZjRFU0UXl6dWpPaGpXMmJlV3NubDZxT3o0?=
 =?utf-8?B?WHZjRk50amJUTURYZVF0c2ltaHE4S1ZHTkZDYlZVeEdwclNRM3FkMWZ2NXl2?=
 =?utf-8?B?d1JSekhROEl6VklsQSs0aGIxbWFWTTNhR3BxUjh4L1VOQVZqWlY4THA2bW94?=
 =?utf-8?B?dUxnbmdPanBVeGlSR21EUnhQd0pIdW9zTGFYaFFDQnJHN0U5WG9kaE4xMXpx?=
 =?utf-8?B?Zm11eGZVTkJSYzRhTEZXR210Q3FxZEtSUmhPVXdYZzZsRFRIdGQrOTFNaU5G?=
 =?utf-8?B?ajBUMFlReGpVT3lRcmpGZHgzNUxHbVNPYjcrZ2gydCs3VDNXa0tjSEphbVNW?=
 =?utf-8?B?TlRkQVJubGpFaktyeEhXNGIwZXJQYjJzYkgxU0N6R0hWWDVNL3lqdHdZSzhO?=
 =?utf-8?B?UkRSS0FWK3V4TFJSNUhteFQzd3d4dlJhSHI0RFljWlJ2R0V1RWpJSGp0SnQ4?=
 =?utf-8?B?L1FHWC93c1VVbDJtUjg1TE1FR1JwSzE3T2thZ1AxYzcxR3RuLytGQU96MXN6?=
 =?utf-8?B?a05rRTVISHora25yUlZMMFlucTBjM0Nua1ZJaXpBSDlwQlRNQzVNV01tWHM3?=
 =?utf-8?B?UDlVaFI0UVo2WTY4WTNQdjgvMU94VFFzZE9EWCtvS1R1M0xtUTBTSWQwNzBH?=
 =?utf-8?B?TU1LWng2VXR5cGxOVlFFMWtWUGdCRjRHWmpSOTdNcnIxaWpyZHpGMUlBTXdC?=
 =?utf-8?B?NmRVb2VaWEx2ZktvUHM3NXJsaVlLQWFGR2p5L1pkK3UxQXIwYnlLekVtcTR1?=
 =?utf-8?B?Rk52K1loZDF5bFZLblFuSUFVbElYNmF4MkVyMlA5a0pOT0RPcDRxRk9sWkpL?=
 =?utf-8?B?NlI4c2F4RnNGcVU4cmwrejFsTlVaMHloeXlDbGVJUmY3SFU2ZnJuUXRwY0ZU?=
 =?utf-8?B?RDZMcS8xa1A4THVmTWI4UXQ1eVVQU2YzMkVyekduQ1REN1RFVGJOM2lXbnRP?=
 =?utf-8?B?SEp1bHoxWWJYRHJRYmcyL051WWFac0pUeThKN1lkMkdPK2tHOHFXVFNoa1BY?=
 =?utf-8?B?MVFLUzJ3Zmw5SXl2eWo3NjVENnpqWTBaSEwvc3N0anEzSUU1d2ZyMTVMNzB1?=
 =?utf-8?B?NWdDUEdqT3lrN3N6TmJyVG1mRFpmVWE3NWFhQkJ6V1VJNUVLdUpPWXZVZUYv?=
 =?utf-8?B?VmZCOC9Gem5YMkVtdmRNc1hQVlA5T0tvUU4wR2hHWHJ6cExOUmpOV1Bia244?=
 =?utf-8?B?SDFmMmsrbFQ5cEQ1ajExdGtJLzFSZUNPWW1aRVNCTlRvY2JtdHVvSGxZaTE1?=
 =?utf-8?B?Q3E1bkNzNk5zSXNQUWpHck15U1JTaS9NWW5mNElranNodmF2Wkdvak5aRU10?=
 =?utf-8?B?emQweFVMYU80VmJUakRaT1A3U09Yb1R4TjRMNGZjdXprdHZaNVEwczRnYS9t?=
 =?utf-8?B?cTlFR1dYQnN1WXpDdHZLNlVyZENrMkMreWx0R3FjMlEwcWEyd1VKci9yR2cr?=
 =?utf-8?B?eWR0M255SXhDWUIzSDBoWENKNy9qWGFKU29wZjhXUmtKY0lMUFRQT21jS2NF?=
 =?utf-8?B?VXY0UlJob2lVZzFJbkc2eVo5VnpGL0RNd3kvTWRxRjZrZVZjT1FRbCtiS2Qy?=
 =?utf-8?Q?x10t2JEpqyVEQO6WzOCT2pJd+4JxUJDFogStg1a?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 02:48:28.2559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0567e-223a-4246-2485-08dc811c266f
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR02MB6276

From: "Hailong.Liu" <hailong.liu@oppo.com>

The function xa_for_each() in _vm_unmap_aliases() loops through all
vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
vmap_blocks xarray") the vb from xarray may not be on the corresponding
CPU vmap_block_queue. Consequently, purge_fragmented_block() might
use the wrong vbq->lock to protect the free list, leading to vbq->free
breakage.

Incorrect lock protection can exhaust all vmalloc space as follows:
CPU0                                            CPU1
+--------------------------------------------+
|    +--------------------+     +-----+      |
+--> |                    |---->|     |------+
     | CPU1:vbq free_list |     | vb1 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+

_vm_unmap_aliases()                             vb_alloc()
                                                new_vmap_block()
xa_for_each(&vbq->vmap_blocks, idx, vb)
--> vb in CPU1:vbq->freelist

purge_fragmented_block(vb)
spin_lock(&vbq->lock)                           spin_lock(&vbq->lock)
--> use CPU0:vbq->lock                          --> use CPU1:vbq->lock

list_del_rcu(&vb->free_list)                    list_add_tail_rcu(&vb->free_list, &vbq->free)
    __list_del(vb->prev, vb->next)
        next->prev = prev
    +--------------------+
    |                    |
    | CPU1:vbq free_list |
+---|                    |<--+
|   +--------------------+   |
+----------------------------+
                                                __list_add(new, head->prev, head)
+--------------------------------------------+
|    +--------------------+     +-----+      |
+--> |                    |---->|     |------+
     | CPU1:vbq free_list |     | vb2 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+

        prev->next = next
+--------------------------------------------+
|----------------------------+               |
|    +--------------------+  |  +-----+      |
+--> |                    |--+  |     |------+
     | CPU1:vbq free_list |     | vb2 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+
Here’s a list breakdown. All vbs, which were to be added to
‘prev’, cannot be used by list_for_each_entry_rcu(vb, &vbq->free,
free_list) in vb_alloc(). Thus, vmalloc space is exhausted.

This issue affects both erofs and f2fs, the stacktrace is as follows:
erofs:
[<ffffffd4ffb93ad4>] __switch_to+0x174
[<ffffffd4ffb942f0>] __schedule+0x624
[<ffffffd4ffb946f4>] schedule+0x7c
[<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
[<ffffffd4ffb962ec>] __mutex_lock+0x374
[<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
[<ffffffd4ffb95954>] mutex_lock+0x24
[<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
[<ffffffd4fef25908>] alloc_vmap_area+0x2e0
[<ffffffd4fef24ea0>] vm_map_ram+0x1b0
[<ffffffd4ff1b46f4>] z_erofs_lz4_decompress+0x278
[<ffffffd4ff1b8ac4>] z_erofs_decompress_queue+0x650
[<ffffffd4ff1b8328>] z_erofs_runqueue+0x7f4
[<ffffffd4ff1b66a8>] z_erofs_read_folio+0x104
[<ffffffd4feeb6fec>] filemap_read_folio+0x6c
[<ffffffd4feeb68c4>] filemap_fault+0x300
[<ffffffd4fef0ecac>] __do_fault+0xc8
[<ffffffd4fef0c908>] handle_mm_fault+0xb38
[<ffffffd4ffb9f008>] do_page_fault+0x288
[<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
[<ffffffd4fec39c78>] do_mem_abort+0x58
[<ffffffd4ffb8c3e4>] el0_ia+0x70
[<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
[<ffffffd4fec11588>] ret_to_user[jt]+0x0

f2fs:
[<ffffffd4ffb93ad4>] __switch_to+0x174
[<ffffffd4ffb942f0>] __schedule+0x624
[<ffffffd4ffb946f4>] schedule+0x7c
[<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
[<ffffffd4ffb962ec>] __mutex_lock+0x374
[<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
[<ffffffd4ffb95954>] mutex_lock+0x24
[<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
[<ffffffd4fef25908>] alloc_vmap_area+0x2e0
[<ffffffd4fef24ea0>] vm_map_ram+0x1b0
[<ffffffd4ff1a3b60>] f2fs_prepare_decomp_mem+0x144
[<ffffffd4ff1a6c24>] f2fs_alloc_dic+0x264
[<ffffffd4ff175468>] f2fs_read_multi_pages+0x428
[<ffffffd4ff17b46c>] f2fs_mpage_readpages+0x314
[<ffffffd4ff1785c4>] f2fs_readahead+0x50
[<ffffffd4feec3384>] read_pages+0x80
[<ffffffd4feec32c0>] page_cache_ra_unbounded+0x1a0
[<ffffffd4feec39e8>] page_cache_ra_order+0x274
[<ffffffd4feeb6cec>] do_sync_mmap_readahead+0x11c
[<ffffffd4feeb6764>] filemap_fault+0x1a0
[<ffffffd4ff1423bc>] f2fs_filemap_fault+0x28
[<ffffffd4fef0ecac>] __do_fault+0xc8
[<ffffffd4fef0c908>] handle_mm_fault+0xb38
[<ffffffd4ffb9f008>] do_page_fault+0x288
[<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
[<ffffffd4fec39c78>] do_mem_abort+0x58
[<ffffffd4ffb8c3e4>] el0_ia+0x70
[<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
[<ffffffd4fec11588>] ret_to_user[jt]+0x0

To fix this, replace xa_for_each() with list_for_each_entry_rcu()
which reverts commit fc1e0d980037 ("mm/vmalloc: prevent stale TLBs
in fully utilized blocks")

Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 125427cbdb87..4c65e9678b83 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2806,10 +2806,9 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 	for_each_possible_cpu(cpu) {
 		struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
 		struct vmap_block *vb;
-		unsigned long idx;

 		rcu_read_lock();
-		xa_for_each(&vbq->vmap_blocks, idx, vb) {
+		list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 			spin_lock(&vb->lock);

 			/*
---
Changes since v1 [1]:
- add runtime effect in commit msg, per Andrew.

[1] https://lore.kernel.org/all/20240530093108.4512-1-hailong.liu@oppo.com/

BTW Reverting other people’s submissions is a foolish act. But we need a mapping
from vmap_block to vmap_block_queue, I saw zhaoyang already send a patch
https://patchwork.kernel.org/project/linux-mm/patch/20240531005007.1600287-1-zhaoyang.huang@unisoc.com/
use cpuid. pls free to use my commit message here to help others
clarify the issue.

fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
IMO, if caller could call vb_free, it would be not used address again.
so I don't know whether we need to flush TLB here. and loop through from free
list looks more resonable to me.

--
2.34.1

