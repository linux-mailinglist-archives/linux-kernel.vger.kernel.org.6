Return-Path: <linux-kernel+bounces-282914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15394EA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BEB1F2279A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5016EB76;
	Mon, 12 Aug 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ewEe78Gm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC971876;
	Mon, 12 Aug 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457235; cv=fail; b=JyL8PMqsBw7IKoYRlhEV6LOQsFev/WpzgjT3sNzdiFtSGknz1E1cVC9R1PnvVZu/jShsb2XoosNbLqi96NvV2D9PAPKuahSVaQ5zJRHXRWYgd2R3ZFZRRsOUVHC92AVVe60DbEJuzT88EwvYjXlTCU36mUJoDwmVQiFz+NUcdog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457235; c=relaxed/simple;
	bh=h/mj7sM8vhTT/aItzTYLoJY3YKx9Pdmy95oDSqhpb+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dZQ58mlMhm0ObJEtA35P8MSZrugC8lOW36RAC1sgTH2yUxDJvoXS9ZlU91aYFBMZyrOgAImdF22vQ6u9wyUZjZyfS7BKMdl+Q38GPwVb9UbtmVyf3Y8h2IHcycEO7/0f4ubEp/YBe0twStBE5/IwthuskIONPN9iTNc2JbBTATQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ewEe78Gm; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smE1T6AgwJbdHJTiiIBiBLDj7STABjlBaJ92gzE7WzqvO50xFyhoRTHXBwthmkIODE1IZPqMHVQ/IZ0H5yZaXJHN6VpFICbkOfCIkFdKpv+oUMgzl2jvSoYGwMW+IRFcI5JslySXQsFXDzBphghfZBKxU07eVyMfPd+3O1eNoyopEXZ0nK4NiCOa0AFeGNp79WI0sB8d71qTdBSJ7yGQKxmSQIOzhbHUjU5sDO1MFDBkEsoh1/BWf4COxLXeYfuavrbWD+oQ0iZMBpTx8ywHr3YPxBxYuGKSlBqA70QStwD/U42YvsYA2eMTLuTXV/j1tUoCpiUZpNP4kqcGjvnOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyk8ipdMfOPsSKFkljWs/pH5FyEPrux1sbQmo5NKnLI=;
 b=pIVr7ltwRgfJ4l8OXsqtAFi8j5rNvnHoVFiscLs2GE6mUG+RCzn5OzuTxMbLvVFr9pDidsIUHgnloZgEodF/AnsomUXARv/TtiNGi4EN4kbQQs2pC0AFoC8I5t0JSMc8dzGg0N6auJmQmfgfSgrQI+nhTnZk6pYCevixsVvLBtD1THZouMpguQT55p4TVzdrwIT0CAYsow8PS4sT5bU96VDTgihCcb3tKGye93MzsPbTaEn2d6b6do/ttes4F5c8z/t89K0/PrYEJICVtlewvbcfSpty2pCw7h2ysQcte5hxgQGiBYosevH5Cg+5fC7qYGE9O4kys9pCLT5jVDLACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyk8ipdMfOPsSKFkljWs/pH5FyEPrux1sbQmo5NKnLI=;
 b=ewEe78GmSwve2MENxXL1fQ64CI/QCDxUh8DjLSzneJWgIYpc90J7GyQGa+bV1A/pQcHu1usvNTp2+OgnHSyvtDTED2W8Bm0/MU8MP9dvHPF5Cj01vMxeRY93jP6AoumSCk0dJbqMS7MYGieP5J4/vsaLBF730K1ZhhXOxfhk8RW+WaCZf62v96qRCuNPmJ8MplvbZEOQFjOtWkp8cg3SGWT9q1ozRCX4p76hVwDg/GBcAzjRfncCPkvf+PiPsPgQ51fxgs2KGF0uiHvrx92El60/osLb/oOYlNUvrhdAWeAZfCaBOV1l4bDSHj2f/kX3du1ttkQ+iAf/DjQ52olYdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB9337.eurprd07.prod.outlook.com (2603:10a6:10:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 10:07:07 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 10:07:07 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v4 1/2] of/irq: Prevent device address out-of-bounds read in interrupt map walk
Date: Mon, 12 Aug 2024 12:06:51 +0200
Message-ID: <20240812100652.3800963-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a713d34-71ae-4170-06d5-08dcbab685ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9GKYlL8HMLU4AZWSCF/8+XmTjsKJKH95LGX7MtJKrXvwWYM1JXg7lBu6obI1?=
 =?us-ascii?Q?720hpy84KypoXpBEtQlfFoSssonDtmvNveKdDGZiAVxKoHV9H8ePZ534iqwR?=
 =?us-ascii?Q?/60xVAYCZ2f4Rm7Iq456iDtVjSnETXSgDlMMp+twjuHE7tiDdF+MRosGP9Xl?=
 =?us-ascii?Q?Dt/kHLqu7wf7zfmqVp1IxWfYVHnL5jtaHn53OJrtQp7rL6WDCPNc3sj0fx7E?=
 =?us-ascii?Q?ekE5/NN3wBdsvqdp8AS2e/1As4A0C1+k88GaHstYpYoPrMJMbYYBLKwnO/AC?=
 =?us-ascii?Q?Kgaw8GvPndnCegn+9hvBvlnhFbwbyDPOIqbyNg/PqBgNDtJWAVFwTZuNIPp6?=
 =?us-ascii?Q?/AepFeVKszT36gvbPwb8C161ixvTX0IaWB859tr+1K8gKNIwjTt5Tzn7JAHs?=
 =?us-ascii?Q?1vEGbj86zcSpQVSWyTvTCGbjboyog4S7AMmu5xZCeNhzqy9NfOa8rV7Bv4cy?=
 =?us-ascii?Q?59t2+PfDW12ZlaO5oYkMrG1TpKcsLLql1ifo5WLnzbyET3UXwTl8zUQDPThG?=
 =?us-ascii?Q?wmR7mKgpX6+zmI1N+bqbdWBkAYXoQRp8MLIYUYvxztmdxFvJhD26BpE9QtaT?=
 =?us-ascii?Q?h3gfBtFZSGkweO8RTq3JMMYXvCkbfnVOZ76WuYXW63UePoVA2MjODmr7E/I3?=
 =?us-ascii?Q?A9mHaMXS6SczS6lJ2bXhdPpgshbt5u+wUwPalQfGY1gLx9SPf7Zi8oUPBGo9?=
 =?us-ascii?Q?+uTLfPStMFPsczsC0dSyz9xeX8Ql4vGPZXMUg0QT4k+gGx1oAQrhB8th+uY2?=
 =?us-ascii?Q?ZPyRiJN4Hdx9vGNO8kuyaOXtFjibvlOKXu3TRspWd1f+04JFSJfcwS8sF3Nq?=
 =?us-ascii?Q?dFUzZE67tQFwpETXawdAyayVtmllFWJRIp4kj6usffvg/WShxiVVoD4EoQmc?=
 =?us-ascii?Q?H0hlbMrBu8qbA/sO0OHoPEoPwlGufMYrvtJb2JIun7H/MLYgTqVxbtzb+I5n?=
 =?us-ascii?Q?rNIvx5l5ilfJRan2PUzVb88s/+mTTI5mkf297g83yJYudcZVEnIRRPUdSTen?=
 =?us-ascii?Q?P/jd4fbC2UkspIwzc23F2z6XcBj80xw5yAzxSuijZmjZugpF3JbN6e6oc3uA?=
 =?us-ascii?Q?w653vVo/5eAL7WzAUKktYWphHFCSzvOljwInriM2Y+GKydDuZxc52Dxf4j0B?=
 =?us-ascii?Q?u6/LwMyeEUlxLrI9ugGvIAjACbKqtvczgYXnS68zg4zjJbQm925BeNZKtnjn?=
 =?us-ascii?Q?Hc7105JNwFd/TW7oQNRUphhw6uyKmq7uj/Anc6rsO7lKT1P67eVaHsm+ij6P?=
 =?us-ascii?Q?6Nt36P4amwVNQZnCXH4dQmwQ7c7MtFiMrRLIO0z3u5B0Q+ZEoX14M9fejmb4?=
 =?us-ascii?Q?3DcJAtNELN9kU8TPOvsxm+Y447GfyUXy/WD0GxnKfM4lP3s7wGTdUAziFiPp?=
 =?us-ascii?Q?X/EVbqU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o84dDEktsfeip9ii4lmXLzAHeaHnrjH+dLMYKV3NJKQRAGcFW9lHuxT/zcjh?=
 =?us-ascii?Q?0BY37BVzEt9SMoCAx8lhCOaRWtXs8T6AtJl8EaIk5c89jLUIfbFR/j8/JtSX?=
 =?us-ascii?Q?aWPxCMQ7TSFhHa7aapFSr+l6PJIagvsZpxJUQ0RqRmQMxGE0yzAy3EWX4y2h?=
 =?us-ascii?Q?DXvQ+Re8932rwS68HOZtI7x0VvFuJUyEDUOhF26hr9fjN0ghhjv29u7cDSYB?=
 =?us-ascii?Q?H1TcL9mWdTWLuUogRXEsZ5Q4vmtH4tJHzdzmLxCRC6loQ3zWaExDLto1dzgy?=
 =?us-ascii?Q?M2GFddO8cSiyCHroe2aKV5emV7DjUnb1y64qHfcP7oQkdCFY8537WvysYbf7?=
 =?us-ascii?Q?jZaJikFzCdSDMGOn0NRAyR+Ms23MvswVaXy6qW6sekPBAHKA4K8GBSLo961Y?=
 =?us-ascii?Q?YDcdB3ZARtuAqxzuXwJiVIfcti9jvMjK7xMjf/zrsbtu325SDzHz0qTu1oGR?=
 =?us-ascii?Q?N/SaLn7rWcTmMt/hIJxNex/LIYglxJZ97TJmvXTtznD0uZ919k6Pawxdfr23?=
 =?us-ascii?Q?1R0J+lfyAjM+6pZ1/jr2Gax1tLSG/YAB3/Wns9KYZDlfrGTKMyS1TACuetop?=
 =?us-ascii?Q?0HTTt6bZ27up0gMUshljCpquP+UuUjldRbe35HjSAFjmXay4DYzBmAbN4TK0?=
 =?us-ascii?Q?qhz/yeQF8nwFxPLfKfWKv4VA/EZXRnqfwQnUJIB4MFrbdZL3WyHBsdXiCwle?=
 =?us-ascii?Q?Ha/DDs1I63SAGldUgukdTTvLvs7rQ69+tCdKH26hkEHWpktsjWn/GsOW9FEV?=
 =?us-ascii?Q?q9Kd13rYIx4cX1JokaZae9BmaMeZU0UHQc2EL2nLuvgDkqq368ie6PvnXu6g?=
 =?us-ascii?Q?IKDcXIO9210QpDj339I445KvO+qFsEiOkzyttgtLfS1Yj2TuGSu+ptnGqwR9?=
 =?us-ascii?Q?NVauzEnh+Gfe6F3O0CjsJ+ZMoD9u4jwLkkokK30mdmbcag58grmZXMulc3N1?=
 =?us-ascii?Q?CfWKauLdH3vhT33FHdLRAsvCF+cmJWsBJXsY84FWOCl+cFWPh0Rev3Mvw8kV?=
 =?us-ascii?Q?ZLZ9F3wjcEeyl24XPOesOAlZo+qm+h00Kwp56C5fQ5F6kAewaJ7L0zY8jRYo?=
 =?us-ascii?Q?V62cirn06PWv0rlaqsFuQvqULcSlifcHAs+oGOb8Vexp6jD3MgTUso5sKiN/?=
 =?us-ascii?Q?K3KZFJ7dLyrBHOCfjpiUcUZM7KM4tS4yvTErfHy0SYH/Nc0x7PWYMoUwA/70?=
 =?us-ascii?Q?FBzzAqDbc+wcmQKYml22Y5vJXI+Lahfl+vh+8WFMq485Mxn9cIFZDSI46OiU?=
 =?us-ascii?Q?3RLVSY9uZxC5ZeoN93Ebm3KHbiTCjurOw03FV2sbHx91zGoeVpM/zCIJeLQ7?=
 =?us-ascii?Q?dP1qvR/etHA3Ko1p7pi0lxmw4xC8A3ykpxQK5Vl0GCATuGglVHMiN0lVe41d?=
 =?us-ascii?Q?uEKu7o9kxcgwh9X/76aj00QWFnVnNCuIuagKP67STO00RDVsn4R0f5OiOesb?=
 =?us-ascii?Q?qnhzWqaanKYmeyqOoE9eh9Vmi8jO5NofOZaGbZVU9cRSOZLoZoEhBUzK5nEf?=
 =?us-ascii?Q?PuOoq3CvUgTa3tGdr7I1HQ25NNI2F+tLr0Zvhi0LeEiXbH5kXjjf5U2UvJVO?=
 =?us-ascii?Q?lQM5qy0NFAHqJfQDKbctuIdKy6RwH5YhwNP9JOD+BAOn5/wsZHj+Gbwxc1VY?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a713d34-71ae-4170-06d5-08dcbab685ba
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:07:07.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO+l15rEYUvE6uFIcWGKcBggxDbv0GxgVdpWSP2bqFNCP7Y360/F7aE7gIBE372ZwBnXcc+XQanaj8aDYBSNIRv1JIJQN40gjdqfEird0U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9337

When of_irq_parse_raw() is invoked with a device address smaller than
the interrupt parent node (from #address-cells property), KASAN detects
the following out-of-bounds read when populating the initial match table
(dyndbg="func of_irq_parse_* +p"):

  OF: of_irq_parse_one: dev=/soc@0/picasso/watchdog, index=0
  OF:  parent=/soc@0/pci@878000000000/gpio0@17,0, intsize=2
  OF:  intspec=4
  OF: of_irq_parse_raw: ipar=/soc@0/pci@878000000000/gpio0@17,0, size=2
  OF:  -> addrsize=3
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
  Read of size 4 at addr ffffff81beca5608 by task bash/764

  CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c613561-nokia_sm_arm64 #1
  Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12.24.03-dirty 01/01/2023
  Call trace:
   dump_backtrace+0xdc/0x130
   show_stack+0x1c/0x30
   dump_stack_lvl+0x6c/0x84
   print_report+0x150/0x448
   kasan_report+0x98/0x140
   __asan_load4+0x78/0xa0
   of_irq_parse_raw+0x2b8/0x8d0
   of_irq_parse_one+0x24c/0x270
   parse_interrupts+0xc0/0x120
   of_fwnode_add_links+0x100/0x2d0
   fw_devlink_parse_fwtree+0x64/0xc0
   device_add+0xb38/0xc30
   of_device_add+0x64/0x90
   of_platform_device_create_pdata+0xd0/0x170
   of_platform_bus_create+0x244/0x600
   of_platform_notify+0x1b0/0x254
   blocking_notifier_call_chain+0x9c/0xd0
   __of_changeset_entry_notify+0x1b8/0x230
   __of_changeset_apply_notify+0x54/0xe4
   of_overlay_fdt_apply+0xc04/0xd94
   ...

  The buggy address belongs to the object at ffffff81beca5600
   which belongs to the cache kmalloc-128 of size 128
  The buggy address is located 8 bytes inside of
   128-byte region [ffffff81beca5600, ffffff81beca5680)

  The buggy address belongs to the physical page:
  page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1beca4
  head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
  flags: 0x8000000000010200(slab|head|zone=2)
  raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c300
  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                        ^
   ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
  ==================================================================
  OF:  -> got it !

Prevent the out-of-bounds read by copying the device address into a
buffer of sufficient size.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 drivers/of/irq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb3..8fd63100ba8f0 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -344,7 +344,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	struct device_node *p;
 	const __be32 *addr;
 	u32 intsize;
-	int i, res;
+	int i, res, addr_len;
+	__be32 addr_buf[3] = { 0 };
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
 
@@ -353,13 +354,19 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
-	addr = of_get_property(device, "reg", NULL);
+	addr = of_get_property(device, "reg", &addr_len);
+
+	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
+	if (addr_len > (3 * sizeof(__be32)))
+		addr_len = 3 * sizeof(__be32);
+	if (addr)
+		memcpy(addr_buf, addr, addr_len);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr_buf, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -389,7 +396,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr_buf, out_irq);
  out:
 	of_node_put(p);
 	return res;
-- 
2.42.0


