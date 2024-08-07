Return-Path: <linux-kernel+bounces-277972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C185194A8D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4454D1F23883
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B51E7A5C;
	Wed,  7 Aug 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="PWmplvKR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923F16D33D;
	Wed,  7 Aug 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038353; cv=fail; b=NdDR852Mh+gO99jCV4JJtmBB11H8hyv8oxrVQanspGUZQ3j/OlL9/G3XJceAVNyGGJ+ukf+P+dGG69lheuKhB2dGj1hfIkWuv6nN49loNXb98O4HoGtli/6JoHAiErEN0L3Mfv6jTCf2hAqh+EXqymbO+4LRJ5GOcZJFGhEcsCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038353; c=relaxed/simple;
	bh=dtZGjLqkY2I5OBNPga3Ra1+IpJ2G6/z0n7+Zgo3y5Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gAti5026QqZK3P3x0M/ok5nmvejnJkGRKDC/tzCpMYhQ/5aA3VXzFOB6hy2+ZPHORuSGLVuecsVrzhOU02LM4rJca44XNov8AlL06bOIUKAPcVovqOuDKUlmS7ThV1d3SBjhdNMfA+nhhaAn3RnHbyhJC8a0qfe4MkZbZU6Y1fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=PWmplvKR; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfAc9Js6zLdQBo2whBWcEjKPAazeW7qDEt4JGVn6sS2DMAKl3QrYWxYCqSJhLpbr9W4T2033ReORpwxtDaZNShZTHXEH+ROCHLAxPnDh7VwIMok0C62GwTyvU+cgpkjzFk/Mk+bzkNXGrg4MS4kG/8WadisRbFvzkczo9mO5DbL/Sowy/JEE6Z4Ilo9RjFWEvnNKKAYnexuQsDwbEIz9bJ2IkxLPpa4yvgANkXHX4alEr4urzLexPQUDQWZMjUPTTwWJBMrATvgWLcl8Hbo1KYwCX7ooKqX4p3N6FsGkpWaI3mzCjbJnL0P3aS6j+kudqG82shsjvtJXR+pZPjJCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vw11ggtCW7h+uGR2zdDKmpgE7y/f9t93R/vh1RUxgc=;
 b=O1varbFmykkM93ra19r8T7rKB1l2Hi98fB4+rTHQRmAn2BUz5MopZSHS4FG2wjW2qBQkf/4XkduUNE0/3cqR0WOqskJVOwRr0koxUZi29mS1+WtRYYH229lcunK6QFpS2Dlr2sGjehQyDHJK1v5JvBcu2rJtKiiTX8dmOnkj5HfHo9Jhmp/UIJRuuuyNVSbSRBLICIlFFyuw7diOr3ap2h2ZHI1wAQXtA57aLBAG4Rl0k8tAg4AkjVJjBOLDioP2ewYQhsJxE7Brdj+7te6pf7c/dgVHfCQoxKx/ePZOONj1y3exfvu88RjY3DElCpiz1lc03s9R/aod05kwJbNDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vw11ggtCW7h+uGR2zdDKmpgE7y/f9t93R/vh1RUxgc=;
 b=PWmplvKR/fnr/BwXD4Zk9l2RkEeYwpJU7PtTjeuAJFP05xgb3oINWNea0veG89oJfEOFYO85Xok9auoRKWPcpr2NDSEW8ewbepzbyf3hjIxU4dYICe2qFnDmxqrVnqjeFps5s1nvhPDfJcC+gTF6RwHiUPtEPwYbfqoi1iKYcxr5ovE8butnp2LwxgFWcQU4AEIY8esxlXih+snIlNMVWcBrcwooxNFCquJ0TiRDvSnJ8F5KbdU8LlvmjIs/1kYqzjfZYsHb+mBHByW3Rk0C75yxWbqkp5fEUE1R8SbKt+wahdpfD9j5mGinQhroUuvPqs+yGQ+rmsl8N7pvQ37hIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9084.eurprd07.prod.outlook.com (2603:10a6:150:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10; Wed, 7 Aug
 2024 13:45:47 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 13:45:47 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v2] of/irq: Consider device address size in interrupt map walk
Date: Wed,  7 Aug 2024 15:40:33 +0200
Message-ID: <20240807134032.1364503-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a83d44e-ee69-4098-c6b8-08dcb6e73deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5RvyBviBbTaqyacxvC8Otbih2eWdtR42DEJlDbkvWT6BkRbHrEyOtnPgAMnI?=
 =?us-ascii?Q?yqNSeM1yLwskEmmIa89JB87G8Nliad7gK1pgphCavOjvqTxa8ei7MxGwQIJt?=
 =?us-ascii?Q?yxvfET8UVWuuBsPntqCsoeB2NedtApdskTdIMdYkmt0c2r3ZXv1PDzvJSRw9?=
 =?us-ascii?Q?rHemseByG+ipN7sH6HZa8QOEFmhcXnBpPvOXSvdnwk9MQIMBrycpF0jk6OUy?=
 =?us-ascii?Q?OTrWtg1bg0AAf1258atR7WiIpDgqHbhYNHUgL4x/wHcAkzyfuvTgs1sdFRGn?=
 =?us-ascii?Q?5vAnsmdYj/TmG5NELZLKneok+8bANAvxbECgR53vLzxo3XquW075/+D1HiT1?=
 =?us-ascii?Q?fujs2asXm5fPnTJoCw3uWrflGYZm8Ksv0uUyrOWc2Aad+UbZWRS7j7MhM45E?=
 =?us-ascii?Q?6o8F5sPmXCR9/NLbUuTtVhnlYhbOumCrMRvcL9i0XL1swSQ/Gtfli6kxmwGG?=
 =?us-ascii?Q?euiYUFgczfRM+3oEAAlGc6vy2xZRrJNfjtdoJZhiaMxSUPV3bkCjZ4GyoFkA?=
 =?us-ascii?Q?g2cm4UdOiesEjN2NcLYomi+ht/dd33PUaTPV4t0L79S8qmypNusW3a0VHdEf?=
 =?us-ascii?Q?AmJWpJ1q7tPjgaw8fZF7qEhn/E7nBlzhMCe5K0DZPp/bcQnmXkChMdwUu8r/?=
 =?us-ascii?Q?GZMtpXaGihiI1y+Uth/8Ne+oMFzZgo/F+ogK83zrhQR7sPiN1Vp31WOU1cXp?=
 =?us-ascii?Q?9/AzHMMYYLrUsYq6M5kTinEiW6OPhjT7oVPOnotExfaUovABTQi/2GgNe+Mg?=
 =?us-ascii?Q?HsK+iMTA1UicPbVz8tvg0Y3C/Ozia//0yaDCv/F84q8VfsoPVKAoxNFOAdmr?=
 =?us-ascii?Q?p8IzAQBgkxbAJ8lYEvEYyZf1bM8xG5xHnGyDgVa2pGPPfVab/UfyLEb7pgxo?=
 =?us-ascii?Q?a++m7OWrWGvnyGhspkQq13Pf6pl4+ka1epVGBiRzwpPb4676AsyESZJbUTHq?=
 =?us-ascii?Q?B4bX10dQ70HNA/D/w+wEd2LInLDLDdP26pUvAz0Hm8UTu8cecvrQrY86BYPT?=
 =?us-ascii?Q?60NUMu5P+3cDASs/lmKLJXu4GXn3P7cypOfdWsP5OjXbmyw4n+O1jVPeRL6h?=
 =?us-ascii?Q?t4VtycRyXeivjmz8LWbRDHMqEHmwOWpgv2qf+jPnKQ/ZmvRQCkO2/sVk+Ohk?=
 =?us-ascii?Q?RK+jvZ9Vv4KpMUVqZDgsPM+DTJi81bKiGjC6zodVDycyxaR1BRZNwhnqtgZm?=
 =?us-ascii?Q?SAsSi2YGLaz/biikSMzT4ZSKPapzCCF3ZG2cHELyJgV2LPKzB5tLTvji0qHT?=
 =?us-ascii?Q?USZQNaLR0XgxtGEBRGgpPw3t7Ma1cqtXM/RvjWVVPjuTBDJret/sdqu/YPwY?=
 =?us-ascii?Q?iQFBglUIIHsV/HfbeeURmSiIWex1uF7A78zfZH/JemUUF+WNKphC5+qWF5hc?=
 =?us-ascii?Q?w37FQboHi7GHNo7lRGGV8dnCBrdWv4wXUidGXUea3iORYMMDRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ur+Oa5RsowWCnJwqMtGs9oYWinvga6NA2W7qOZwHCYtK7SpP3/Ls8K/Hhg5R?=
 =?us-ascii?Q?Q/MFdYEaGFdSDLj0mcoaNFFOyRj09xEEMbx2cm44hJCPwYoCUIWod7FOoyBP?=
 =?us-ascii?Q?zA8+VwMdTz94R5ceDHd+h4H7INg/EOCqfHZtBIvnrDcjQ1mlT4KXJ1C5Ms7S?=
 =?us-ascii?Q?EgqNdUBe/rEiIy80p/Iwj44/+5CelDcuBOeDOeWTPEvIdjKutj8DNoCXlEM5?=
 =?us-ascii?Q?SUgGol7aVdT3dPwpZhF78IeW0Bg5KrSs3wzczkFzBCzCzc2lkROGXSSu8vFS?=
 =?us-ascii?Q?y1M6rrP1ZzrKAGYTkGHyBTExfCwdQHUcnQLmCC3klt0gXOsptJC87W0682Rm?=
 =?us-ascii?Q?zdSqzL23ui8NzTuX14TM45kjzDWu8VT9tt4SJTBacQZNgrxo1vnEWoMj8l59?=
 =?us-ascii?Q?gNpAZzpEsBkzo40vI8oepRDIHnUJ2zLqrmsxJTNUoij3N3VobfhN249IfaYU?=
 =?us-ascii?Q?ZQZqCCJ4lZ8+FKr2JzUmo4GWioHQw5zK04DlySPrl63sjVfVsj3e4ZqqVCU3?=
 =?us-ascii?Q?sHjZlCxZ+zeRdSvTMEkrOFnoE7rjOxOqri3q4To+scB7ltj0UinPeED4nDxk?=
 =?us-ascii?Q?clHCkXPmnM5nDm53OpT9C8Y6nFxf9zLbQj65rKOglVOCe+HhdvxPt8u5c0lz?=
 =?us-ascii?Q?deTCnT0536N/zo0zeg1DRVyuoYwoZsoPiwdnJQRA0Pnv6qxIXq6cLRM9jPfS?=
 =?us-ascii?Q?WdK1S+KrcNBfu1mf9j5Ll/sX+CcHIHiP8TwbVVucJrihDxMsAzHFiKJ2mH9k?=
 =?us-ascii?Q?1tzPKS0cr5i3npswZEWN2TIY4d5+Zayrk1YmIqC5fAx8dPazOL8cUiHBnjN8?=
 =?us-ascii?Q?ulGKRO5Bh2GsaUU4cXM0sHfA9JJLd2Y8f5o/oEUPTxjpn5D/eK1+en2DAqkg?=
 =?us-ascii?Q?W6Dh/zH7dk6gQdmeCpUlVVFE5MoRY8dnn9FCXSIf3T1PzQFNGtlhjPYfiziQ?=
 =?us-ascii?Q?WEtpRNZ5Aa3jFOIxFhXJgVZ+/VfUakbZ6+/SYh8bxU15IjhR2/ZPknWQkOxU?=
 =?us-ascii?Q?SE4Aewmj5QF6QNm8L3BD/XAB2Z017XrtdCN0SvHvEGSuqokNnxJwRL0iC+5c?=
 =?us-ascii?Q?1mHZ4IZI/3MfWNoK0h9Aqii7xYiZhuzdhYrwgds2jCJyG5hllsI7onH0SddI?=
 =?us-ascii?Q?CzrC+ls8NYUBi4FxXoxyl8rXnKSQEIRLC++YykfjImyuO74bFFp6DNV4fY78?=
 =?us-ascii?Q?x+DCpG31d5vf1aUtjx0ehmxwc6iF+rWoJwGKsNkpVQD8aPH2C2ejbnmLzYj0?=
 =?us-ascii?Q?BeDHfFydf7aynLbe/egx3UY111iKEXaWb6wFqgfg/1aInyNOOU3B+DZ4LqZD?=
 =?us-ascii?Q?mmSKgNljo+JlRdre9lCfUt4yTev8dFEo/TfTy9kZ+vMt8Vd+thSIPBwRavxT?=
 =?us-ascii?Q?dgrL0nGN3U66auoge3YWpqH+cccDJD/vo9QYhapm21q/HOv7CD1KT0jAkM8c?=
 =?us-ascii?Q?/ra9MRZU/VVHmLOWfwo88XMUmXADD6F6kGApBpefcHmcUuwbhWeomhV0CCBF?=
 =?us-ascii?Q?EBU4jK/uvIjH3vjzu/TR4FsP8v8p/iSouJ4Ojmh/Q9xdC0CGj1WZJ8JAj//z?=
 =?us-ascii?Q?+hlb3lQWAqWMUwjT4+JsRt46JNJq6V+ssyVrAo/pRkEwTvd1snkH1YtoCH0h?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a83d44e-ee69-4098-c6b8-08dcb6e73deb
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:45:47.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx8dPNG8J3MLiwsw0jJlCBL1GjkmURp3yJ2Hb6RO9zsHK9r9UYxbbdqSGiah4mV9AfWk1RAS5guLvNdXqM3evt8Uu0vHItM/CvGBS4FkMZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9084

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

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
- Fixed of_get_address_cells() open brace found by checkpatch
---
 arch/powerpc/platforms/fsl_uli1575.c |  2 +-
 drivers/bcma/main.c                  |  2 +-
 drivers/of/irq.c                     | 65 ++++++++++++++++------------
 drivers/pci/of.c                     |  2 +-
 include/linux/of_irq.h               |  3 +-
 5 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index b8d37a9932f1b..8da36f72b7b48 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -335,7 +335,7 @@ static void hpcd_final_uli5288(struct pci_dev *dev)
 	oirq.args_count = 1;
 	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(31, 0) << 8);
 	laddr[1] = laddr[2] = 0;
-	of_irq_parse_raw(laddr, &oirq);
+	of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), &oirq);
 	dev->irq = irq_create_of_mapping(&oirq);
 }
 
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 6b5d34919c72b..57d946305496a 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -175,7 +175,7 @@ static int bcma_of_irq_parse(struct device *parent,
 	out_irq->args[0] = num;
 
 	laddr[0] = cpu_to_be32(core->addr);
-	return of_irq_parse_raw(laddr, out_irq);
+	return of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), out_irq);
 }
 
 static unsigned int bcma_of_get_irq(struct device *parent,
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb3..78c35f81cde8f 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -151,9 +151,30 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
 	return imap;
 }
 
+static u32 of_get_address_cells(struct device_node *node)
+{
+	struct device_node *tnode, *old = NULL;
+	const __be32 *tmp;
+
+	/* Look for this #address-cells. We have to implement the old linux
+	 * trick of looking for the parent here as some device-trees rely on it
+	 */
+	old = of_node_get(node);
+	do {
+		tmp = of_get_property(old, "#address-cells", NULL);
+		tnode = of_get_parent(old);
+		of_node_put(old);
+		old = tnode;
+	} while (old && tmp == NULL);
+	of_node_put(old);
+	old = NULL;
+	return (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
+}
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
+ * @addrsize:	address cell size ("#address-cells" property of the device (parent))
  * @out_irq:	structure of_phandle_args updated by this function
  *
  * This function is a low-level interrupt tree walking function. It
@@ -165,13 +186,13 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  *
  * Return: 0 on success and a negative number on error
  */
-int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
+int of_irq_parse_raw(const __be32 *addr, u32 addrsize, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL;
+	struct device_node *ipar, *tnode;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
-	u32 intsize = 1, addrsize;
+	const __be32 dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	u32 intsize = 1, ipar_addrsize;
 	int i, rc = -EINVAL;
 
 #ifdef DEBUG
@@ -201,24 +222,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	if (out_irq->args_count != intsize)
 		goto fail;
 
-	/* Look for this #address-cells. We have to implement the old linux
-	 * trick of looking for the parent here as some device-trees rely on it
-	 */
-	old = of_node_get(ipar);
-	do {
-		tmp = of_get_property(old, "#address-cells", NULL);
-		tnode = of_get_parent(old);
-		of_node_put(old);
-		old = tnode;
-	} while (old && tmp == NULL);
-	of_node_put(old);
-	old = NULL;
-	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
-
-	pr_debug(" -> addrsize=%d\n", addrsize);
+	ipar_addrsize = of_get_address_cells(ipar);
+	pr_debug(" -> addrsize=%d, ipar_addrsize=%d\n", addrsize, ipar_addrsize);
 
 	/* Range check so that the temporary buffer doesn't overflow */
-	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS)) {
+	if (WARN_ON(ipar_addrsize + intsize > MAX_PHANDLE_ARGS)) {
 		rc = -EFAULT;
 		goto fail;
 	}
@@ -227,7 +235,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	for (i = 0; i < addrsize; i++)
 		initial_match_array[i] = addr ? addr[i] : 0;
 	for (i = 0; i < intsize; i++)
-		initial_match_array[addrsize + i] = cpu_to_be32(out_irq->args[i]);
+		initial_match_array[ipar_addrsize + i] = cpu_to_be32(out_irq->args[i]);
 
 	/* Now start the actual "proper" walk of the interrupt tree */
 	while (ipar != NULL) {
@@ -254,7 +262,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		 * interrupt-map parsing does not work without a reg
 		 * property when #address-cells != 0
 		 */
-		if (addrsize && !addr) {
+		if (ipar_addrsize && !addr) {
 			pr_debug(" -> no reg passed in when needed !\n");
 			goto fail;
 		}
@@ -274,10 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 		/* Parse interrupt-map */
 		match = 0;
-		while (imaplen > (addrsize + intsize + 1)) {
+		while (imaplen > (ipar_addrsize + intsize + 1)) {
 			/* Compare specifiers */
 			match = 1;
-			for (i = 0; i < (addrsize + intsize); i++, imaplen--)
+			for (i = 0; i < (ipar_addrsize + intsize); i++, imaplen--)
 				match &= !((match_array[i] ^ *imap++) & imask[i]);
 
 			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
@@ -306,7 +314,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 		newpar = out_irq->np;
 		intsize = out_irq->args_count;
-		addrsize = (imap - match_array) - intsize;
+		ipar_addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
@@ -343,7 +351,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 {
 	struct device_node *p;
 	const __be32 *addr;
-	u32 intsize;
+	u32 addrsize, intsize;
 	int i, res;
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
@@ -354,12 +362,13 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 	/* Get the reg property (if any) */
 	addr = of_get_property(device, "reg", NULL);
+	addrsize = of_get_address_cells(device);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr, addrsize, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -389,7 +398,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr, addrsize, out_irq);
  out:
 	of_node_put(p);
 	return res;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5abe..5d4b2ec5a3b13 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -506,7 +506,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 	out_irq->args[0] = pin;
 	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
 	laddr[1] = laddr[2] = cpu_to_be32(0);
-	rc = of_irq_parse_raw(laddr, out_irq);
+	rc = of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), out_irq);
 	if (rc)
 		goto err;
 	return 0;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index d6d3eae2f1452..74268e33d7305 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -32,7 +32,8 @@ static inline int of_irq_parse_oldworld(const struct device_node *device, int in
 }
 #endif /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
 
-extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
+extern int of_irq_parse_raw(const __be32 *addr, u32 addrsize,
+			    struct of_phandle_args *out_irq);
 extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
 extern int of_irq_to_resource(struct device_node *dev, int index,
 			      struct resource *r);
-- 
2.42.0


