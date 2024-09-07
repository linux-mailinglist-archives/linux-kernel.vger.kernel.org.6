Return-Path: <linux-kernel+bounces-319933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D29703EB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D850282CC8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB21667D8;
	Sat,  7 Sep 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="jdy6c1kt"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D07165F15
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737334; cv=fail; b=L0I3S9+GRcRPWi7AQJzbMemzel3xXWapR6ZaCKTDk5nVykZE/YcX7ZBJEOJ8oJoheLJiMypOEIEqEF5iS/h47zZTEcitApyVIHIDLQJu9CL7f6tQDnOHRohBaCo4TCblD7GHPteybM6Gdxf/wTkEEL5nM7utcfCUGre+SyGp9mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737334; c=relaxed/simple;
	bh=uwMnOkdHQPy6aqz4lVLbACX/PkFfeI6SxzFDEdfnO5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HQIXmiJul1RHPMBIrQN+BORFzRgz5TrwreNlvbs+QStxzJ0iBvwl6o7FpSKOsaFDINOMkIfE+/MPuiCUpT6TPiCEv8RaAmoK+ooaKtBM4IXgklx+dc818sn3Eci+zZiiNrGTkS2E4QdqJcEA7Ydx2JjeKFgu/6PPruijqtgsr60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=jdy6c1kt; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAbbJz4nbBnoEu53Dt400prUgJPxDxJDCuFoV1WFlHzcsQjMylu8XPi0jO0rl1x5/gI90+3UjwoAYyWExnwofSx4ge3+7VJd0t+fcyQz0Prt52FF8cpFz4wwQqQvKSaNp6sZ9U8UerIXO3p4jLaIA2VZ+hn/NKSVXV4CvOs8scxBrvKSMsdkGfrAbWVu68LvQbuO/H9i3L2IhOdNt9ybW1OGDCV0ZPaX0/89Q85T24EAFYawLhADNfvw6ru+sTBDMplj8UH6/NR83lA7HBElznZvxPDBWBJh8lDOFEKWg/gWSmaFLJs6wBHwEwOc4D6WKTI7yxp3Qxg+g9UQeFoJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjE3uT3yTixY1vg83W/16AeCADhYhnmlLOR0uz8enmQ=;
 b=qxSIxuL5A9JNm321l/q0pvgKitxNujbp6ZP0+M4XRdvmtXj9ZPRpVnKzhTFB9fMi+0ZGY+z2rLZ/79fZpsKkIdRPaeq5aS0yG8HZJ0z8bHH5wBiyvLZaslIC1hat/pa0BrsKRgQSsg9Ok5XRTUoWcvy4d7ZYlmRy9t/Mj69dG7d1nn5yH33w8rktGwToDFrhW8K408NGEPpW5QKKotpniBpRvkRiYZDG5JZ72phqVif9QlAELWoBUC0T89QtCQrb03oCLtz/0IMML3pxhHDbRU8ZesHoB4gA/pzwrgZUOmY/wupUd9WR+0IZfyL4Zp8NpODlpV5AbgXVnapgSYq4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=bootlin.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjE3uT3yTixY1vg83W/16AeCADhYhnmlLOR0uz8enmQ=;
 b=jdy6c1ktVwLdPoVj4813gV/zRTN4f8fbFwPyNsbUNfN7F6rEwCfOA4jvSahbLsAIX4E8/HICvg1tvurBYalEe91s31rP6Pl+qZnx3erd5NUYTqX5JmmGdLtIjnq4k0jMH9lyrfd6oe2qn2rMfaLokcs0YIs/4/GvQ/uxcHTBU0k=
Received: from AS8PR04CA0200.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::25)
 by AS8PR02MB6680.eurprd02.prod.outlook.com (2603:10a6:20b:259::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sat, 7 Sep
 2024 19:28:45 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:2f3:cafe::74) by AS8PR04CA0200.outlook.office365.com
 (2603:10a6:20b:2f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Sat, 7 Sep 2024 19:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 19:28:45 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 21:28:43 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Sep 2024 21:28:43 +0200
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id A14C2137;
	Sat,  7 Sep 2024 21:28:43 +0200 (CEST)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id 9E1BE20C9556; Sat,  7 Sep 2024 21:28:43 +0200 (CEST)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date: Sat, 7 Sep 2024 21:28:26 +0200
Subject: [PATCH] ubi: wl: Close down wear-leveling before nand is suspended
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240907-ubi-wl-race-v1-1-6f7f5e0aea7b@axis.com>
X-B4-Tracking: v=1; b=H4sIAFmp3GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNj3dKkTN3yHN2ixORU3VQDY8uUJAtLQyOjNCWgjoKi1LTMCrBp0bG
 1tQD9kKcgXQAAAA==
To: Richard Weinberger <richard@nod.at>, Zhihao Cheng
	<chengzhihao1@huawei.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"Vignesh Raghavendra" <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725737323; l=5829;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=uwMnOkdHQPy6aqz4lVLbACX/PkFfeI6SxzFDEdfnO5s=;
 b=TBnXo201oKQKFwgrSCmEI2eXZj83wMCURwirVepxXrSOpVyWaK9oT5MYWSyKRGpdIo+uANfxF
 DG/NPTfjFk3CNHaYX40HwtNh1G2iN0F273nqU8O5U9eZsf7O9XZwS1S
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|AS8PR02MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cd151e-7243-46fc-8b66-08dccf734a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TllGMzNFM2ZBbGZCUHpKNzdUa21QWmlFM2VEeUx5d1JLVG53VTYreDJCQVBY?=
 =?utf-8?B?OXJnUlUyWldjWTM4T1hoZ0ZXaFdUSFl4WmdjL1hWQ1dTa2JLOXYwQVBTVEhi?=
 =?utf-8?B?eGMvYURuajV6a1JHTFhsQUxzYnh5b05GUk13eUthdEJyRjZzbmhEVllQbmcx?=
 =?utf-8?B?ZUhkTVY5R3dRVHREYW8rQWlTZExSeFNvT2tKdUlIeEJHcTk5Vk43KzBjSnJp?=
 =?utf-8?B?b0g5S1c5RGR2NThzQWRnQTRpeiszNWRQNTI1Rkt4MExDWVJHaFBYWlNHU2hC?=
 =?utf-8?B?VVhuRTN4eUtpR1k2YWNTcVN3KzFsQjlDU0pEcjNvNVpuWVorZ1NDSFdybTcy?=
 =?utf-8?B?anE4NHRUZDk3N1p5RWJuNnhuZGIybDBwcUZwcVN5RThvaDlDdE5yOFJCZkMz?=
 =?utf-8?B?Um9FaFVPdmVPblRHdDRpNHkwZi9kczdMNGVaQ3BqM3BDSDYxWGlyOFVOeUFo?=
 =?utf-8?B?WEFnK3pIcUpiSVBEUENqd2E5M3lvS2loUlNWUnhJcGFkZUJWOFRBemduM2pJ?=
 =?utf-8?B?Vmpod09heGlTcXNHTjFMVVUyMk5GSEgvSTFDZGg2N0dGbnhXTEI2VEFiY2Vh?=
 =?utf-8?B?VUdmMUFGVHFqa2JyeVVTMW5DRnl4bU45V1ZzTHhnazVsWEhLN0ZSalplVnZq?=
 =?utf-8?B?QzRFeWxIRE44MDlOYjA0MEFwV0J6NldWbnIyb1c2YTg4Yk9ld3oyd1dkdDVP?=
 =?utf-8?B?cXNzbmtsYkdqelpsaWROd0hvRzNOVnFRVVBHOC9BRDIyODM2Q0pRUk5EM1Nl?=
 =?utf-8?B?ZzRMRGZybjVJNlkrbTFlaHNYZ1dyM083dkFvdEdqc0JVS0s3VytndnRXUnJH?=
 =?utf-8?B?SW1WQXFWSGlmVDZ2N0ljMlA3K3NvOGVpZmM3MTBYMXdqSVdjcnFIb1ovOVdm?=
 =?utf-8?B?bnllOHFSa3F0WmtJTlRCczlqeFlSLzFSajdadHQ1WXpURFJJdjYwbG9aUTgr?=
 =?utf-8?B?SmRJQWNESXdFYUEvVTJPcVlXSDFRQTB4WXZ5bGwrWWcrZEVrNnRhaWZJbFJo?=
 =?utf-8?B?TWtESE9GOGJpbFZIQjZqTENSalU1Z3FBN3FVd3ErZG9PUWFIUkxvdm9wRS9W?=
 =?utf-8?B?NXcrM0hYRXFXRTV1Y1dibEE0bDV0bjR6QVBtNmlma3lxeVhsbUhhZjhCZnhI?=
 =?utf-8?B?S0VaY29wUXFjWTJKaHFEbDgwWU8xYlJkWlh6SnY4STBCWlBGL1ZINldIVEdQ?=
 =?utf-8?B?RVZ0ekpOWXlvYTFVOFp3Nmh6Y1J3RmtzOThEWEVjcWhWUDNaQ0Q4QllOOGFV?=
 =?utf-8?B?Wm0wbTFOUUxsWTRPOHNsV3VSSDVhdDBlZGVpbGNIMmpzSU9SaFJvWlVVNWJt?=
 =?utf-8?B?SjlEbmpSYlgwTHBjUnJPNGdJaEl4dEJEazRWZG9zaFFlNUdqWWRWWnV6M2RM?=
 =?utf-8?B?VGVMTXZaamY0ZERNdkZ2enlTQTFVTEExaU1MUElFZ1pUdnN3TTF2aldwelZ0?=
 =?utf-8?B?M2lMUy9QQnQxVDVkRzY1Y0dzOGo2SHVnd0dlVTQ0NEdHQkNpU1hOS1p0cWN3?=
 =?utf-8?B?V2FUMFBaL1g0RDl4c2l3UXNQSUQvUXFnaXVjc3J4dzc2MVl5a29IaXdzeFFh?=
 =?utf-8?B?SWxVYVdHVEhJaTk0MTVkU2w4eU0rRDlCbFBGN1dZUHZHM2ZOWTFYK3ZSS1VD?=
 =?utf-8?B?MVBnaEEwcnBiYlJQTWdYN0s0aUo0YVhrMWNmK2tCVjN1aXRFSFc2M3ZLQ095?=
 =?utf-8?B?Y2QyYWdjSmNrSk5MOVhYbkJkWkRNbXM3cjY3QVc0a21MWnhUZFltQ0FMNG1I?=
 =?utf-8?B?d2dHL2JyVGo0SDlWSkZSRGZLOVBETnhZcTNxdWcxc1R4Z0tzcW1UMDRRS0Fh?=
 =?utf-8?B?OGZQYy80RmVQYmlNalM0YUgvRXZBQ1FkMDg3eTl6elFIVy9EL1h3MDVGb1hl?=
 =?utf-8?B?SDU2SUExNHZSRFZGYWdQTFNCYnMvcmVsRlVxQUdDU0owQi84TCtRdHFrR1p5?=
 =?utf-8?Q?KnY5EsVUWeZ9rNWS3UFHPJv24gE28kEw?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 19:28:45.7360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cd151e-7243-46fc-8b66-08dccf734a7f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6680

If a reboot/shutdown signal with double force (-ff) is triggered when
the erase worker or wear-leveling worker function runs we may end up in
a race condition since the MTD device gets a reboot notification and
suspends the nand flash before the erase or wear-leveling is done. This
will reject all accesses to the flash with -EBUSY.

Sequence for the erase worker function:

   systemctl reboot -ff           ubi_thread

                                do_work
 __do_sys_reboot
   blocking_notifier_call_chain
     mtd_reboot_notifier
       nand_shutdown
         nand_suspend
                                  __erase_worker
                                    ubi_sync_erase
                                      mtd_erase
                                        nand_erase_nand

                                          # Blocked by suspended chip
                                          nand_get_device
                                            => EBUSY

Similar sequence for the wear-leveling function:

   systemctl reboot -ff           ubi_thread

                                do_work
 __do_sys_reboot
   blocking_notifier_call_chain
     mtd_reboot_notifier
       nand_shutdown
         nand_suspend
                                  wear_leveling_worker
                                    ubi_eba_copy_leb
                                      ubi_io_write
                                        mtd_write
                                          nand_write_oob

                                            # Blocked by suspended chip
                                            nand_get_device
                                              => EBUSY

 systemd-shutdown[1]: Rebooting.
 ubi0 error: ubi_io_write: error -16 while writing 2048 bytes to PEB
 CPU: 1 PID: 82 Comm: ubi_bgt0d Kdump: loaded Tainted: G           O
 (unwind_backtrace) from [<80107b9f>] (show_stack+0xb/0xc)
 (show_stack) from [<8033641f>] (dump_stack_lvl+0x2b/0x34)
 (dump_stack_lvl) from [<803b7f3f>] (ubi_io_write+0x3ab/0x4a8)
 (ubi_io_write) from [<803b817d>] (ubi_io_write_vid_hdr+0x71/0xb4)
 (ubi_io_write_vid_hdr) from [<803b6971>] (ubi_eba_copy_leb+0x195/0x2f0)
 (ubi_eba_copy_leb) from [<803b939b>] (wear_leveling_worker+0x2ff/0x738)
 (wear_leveling_worker) from [<803b86ef>] (do_work+0x5b/0xb0)
 (do_work) from [<803b9ee1>] (ubi_thread+0xb1/0x11c)
 (ubi_thread) from [<8012c113>] (kthread+0x11b/0x134)
 (kthread) from [<80100139>] (ret_from_fork+0x11/0x38)
 Exception stack(0x80c43fb0 to 0x80c43ff8)
 ...
 ubi0 error: ubi_dump_flash: err -16 while reading 2048 bytes from PEB
 ubi0 error: wear_leveling_worker: error -16 while moving PEB 246 to PEB
 ubi0 warning: ubi_ro_mode.part.0: switch to read-only mode
 ...
 ubi0 error: do_work: work failed with error code -16
 ubi0 error: ubi_thread: ubi_bgt0d: work failed with error code -16
 ...
 Kernel panic - not syncing: Software Watchdog Timer expired

Add a reboot notification for the ubi/wear-leveling to shutdown any
potential flash work actions before the nand is suspended.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/mtd/ubi/ubi.h |  2 ++
 drivers/mtd/ubi/wl.c  | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 1c9e874e8ede..4a48ed0ecdb6 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -549,6 +549,7 @@ struct ubi_debug_info {
  * @peb_buf: a buffer of PEB size used for different purposes
  * @buf_mutex: protects @peb_buf
  * @ckvol_mutex: serializes static volume checking when opening
+ * @wl_reboot_notifier: close all wear-leveling work before reboot
  *
  * @dbg: debugging information for this UBI device
  */
@@ -651,6 +652,7 @@ struct ubi_device {
 	void *peb_buf;
 	struct mutex buf_mutex;
 	struct mutex ckvol_mutex;
+	struct notifier_block wl_reboot_notifier;
 
 	struct ubi_debug_info dbg;
 };
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index a357f3d27f2f..b3484e9e969c 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -89,6 +89,7 @@
 #include <linux/crc32.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
+#include <linux/reboot.h>
 #include "ubi.h"
 #include "wl.h"
 
@@ -127,6 +128,8 @@ static int self_check_in_wl_tree(const struct ubi_device *ubi,
 				 struct ubi_wl_entry *e, struct rb_root *root);
 static int self_check_in_pq(const struct ubi_device *ubi,
 			    struct ubi_wl_entry *e);
+static int ubi_wl_reboot_notifier(struct notifier_block *n,
+				  unsigned long state, void *cmd);
 
 /**
  * wl_tree_add - add a wear-leveling entry to a WL RB-tree.
@@ -1943,6 +1946,13 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	if (!ubi->ro_mode && !ubi->fm_disabled)
 		ubi_ensure_anchor_pebs(ubi);
 #endif
+
+	if (!ubi->wl_reboot_notifier.notifier_call) {
+		ubi->wl_reboot_notifier.notifier_call = ubi_wl_reboot_notifier;
+		ubi->wl_reboot_notifier.priority = 1; /* Higher than MTD */
+		register_reboot_notifier(&ubi->wl_reboot_notifier);
+	}
+
 	return 0;
 
 out_free:
@@ -1988,6 +1998,17 @@ void ubi_wl_close(struct ubi_device *ubi)
 	kfree(ubi->lookuptbl);
 }
 
+static int ubi_wl_reboot_notifier(struct notifier_block *n,
+				  unsigned long state, void *cmd)
+{
+	struct ubi_device *ubi;
+
+	ubi = container_of(n, struct ubi_device, wl_reboot_notifier);
+	ubi_wl_close(ubi);
+
+	return NOTIFY_DONE;
+}
+
 /**
  * self_check_ec - make sure that the erase counter of a PEB is correct.
  * @ubi: UBI device description object

---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240903-ubi-wl-race-e039db89122f

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>


