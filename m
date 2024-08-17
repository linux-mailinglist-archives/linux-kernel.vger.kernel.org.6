Return-Path: <linux-kernel+bounces-290513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206C39554E3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A6B22314
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729651CFBC;
	Sat, 17 Aug 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PXaMvzSW"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2063.outbound.protection.outlook.com [40.92.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DED15E90;
	Sat, 17 Aug 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861442; cv=fail; b=KKRSDXJCTGcnv05WM+jGlfaSOiJqrc3etoIvRHTDHrhmwY4qGmpZbf4x/BEXSTpf3nngrm5ddJ6ugusai8VVbqhuRXFejjq376eSswRHn9zd0s/AJd6sezbZ0fdW7cH5eA4sOr9HIR9AhRRzmJIgJJ8iuVeCdyA5iD/wh7L3LHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861442; c=relaxed/simple;
	bh=0RQj/2N28nLENxgeeuSHKE6QLsW6jiwxyfSICCm/3gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3rxa/QKjQPYuzHv+p27jwXC3YD2hfbeaCzZQCtqNrBl5pGe+GMrUmqle+x6cSIl/9APZD42SpwJOj2/0PIBZyFljR7WSa/CGzPnYSYrdRVwFIMpenrEZYeAtrcr3j2pZMAysAFPDNyPavyQcLOYo/wN3famtSQjc0a0Gx72Gbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PXaMvzSW; arc=fail smtp.client-ip=40.92.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyMhxF+GrintoeJ07+TxvJfBfqPoePmPdEp/HNTnspKMMp8taxc1eau5A0ZKuNWgbSnP0lfxIOt0KmQ2ltbGkHtUKWN3jWyexTeqil55GhjZQmk500AX29OJICVTZKmUkYsyb54RDYfkdRo/MNlh9VC4DkrVTOHPxoSkC+aKLH8pjRYpKwnRQ9F1mq8gBWOHcOkto0sX+7ZbbGM6Q7zp39wSOtDskSthtZZV+PR5VxNhgXuQg3syk9UjgMw65nSe7wDefIMrYVmpgApdZZuLlleF4oSAeHbOlSgfHTBM/B/d4xGcLsk1CUB3vOhmnIh1AiWXIQuTTglkR7BgE7srvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1jAVsTw8hZ/KN1DR2QpYyBsseR5e1kBRaw4LadbN7o=;
 b=AVD3JFDhBCZd2d4nq2h+WPawMCSPAn+fOiVReJX9KcTnRkwGVTCp7MhmRAKwlS8mQiCFoydOzWCmlpdJXjAxJGacMj1rQaTBIZVWKTZ6akgwHPo/aBFWSbMGM6tIyfjbGTZ16qKoqLhsqMKRf1C2wEEEIGcvtHJlW8DMBIxmHOc95w48lKZwy0W5wybCly9/tw5mWA1A82B0EpolOP2bWZxvxdM1Z8L641ZYbP4qRV5r8ozQTIJAuv1hDXdd+9prCDxK+ScF2qrJh0h6i33YjEGVYYNGuUIuzDe5Db7QX/1t9kLm9y4xRvir/FpQrDYTci4/AY4CQngyNiUBcRRbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1jAVsTw8hZ/KN1DR2QpYyBsseR5e1kBRaw4LadbN7o=;
 b=PXaMvzSWSd1mehsUk2DHlOi40a+Xwf9TLMSI7Ls+7L/6O1diqiBm5EY7n+JfZ48OMMDE8bNJP9EzsKrxIHdKj3S8WY+yiPGxdtTi/GJDGn5MR3gJafGAKgltH6l5t348noOn4+1NYFTTFCWQYRa9Bh5Od6v/8BmY62mfk54f1zIF1qCnE2PaSOdRlSpffI27N9HTOU+mJr+Uk5D7t3vKK1vrwxetDd5X19/6T3dzuBu9FPxez4xim5XxAk9uXEhlDHzrcLsEXO4oiWutDt9oP604Sf/oktRyl3KpClp2mfAHFCiGZqxfhq8pDCf28OhB8WR/r1+LUJEsrrJB98UqQQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5337.namprd20.prod.outlook.com (2603:10b6:510:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 02:23:58 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 02:23:58 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 4/4] riscv: defconfig: Enable MCU support for SG2042
Date: Sat, 17 Aug 2024 10:22:59 +0800
Message-ID:
 <IA1PR20MB495328CBB9937FE7A90CDD20BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5R0tRRUm7NMeBpiCw6KXTpuzA5vVN/UdmPgOpU9NPR8=]
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240817022300.360949-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: af1a26da-30c9-4ddc-0c99-08dcbe63a62a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799003|8060799006|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	ki/O8OGWEHGb3jQt5lv1Fe9Bww2iEXDvg37urMsbfhkR5ZEW0Ijs7pOHWGy+Hfm4iWq16gbLWrbY+sP689zv+uMZUpaLJ54GSjQ6kMzCpIr76hqKIvVWydz6WxF3qDQtm98bqlHrJafDnj6uSepflTbhXziVQcd945hsfvR6UGihD3GkHP7dQe2MbDLmRhQJFann0A7oKTrVuRwoDxRMh/V33aPpPSoXhcwKTf/paYIFNIUcs4GM498l2JCHjb9vfNIGOdMRI5e4Wk4MhmAgWeYyrXnJfDJ31MQBwTqx3kpjiHqK6/NlScRfkXgngbdl/DD5lV1rE9XE6RQGEL34rdKxxrZ97VIfUa1AqLqyXFIJ7Lj7FakmTz+UfiP4V3H3IxZkW4pRdPB35bjW2MIsyrvqWwHCumkw+j1IqfNI7MERv4cdE4VOyBoGp8nwg6j/mpBxqsJyX1Oy+9df80LsiZkPWWpCdxp+RMlnOLRXDanDz8zOXsEFg6Gzfhy1Hmn3cKchnkCmyOL/sv9ttzxgTIxfHjh2+FBXLr+rXdFeMV75k/pCQcgeq6arJxo5rmzQADouYo7EzqqMzdmztpEo55FZLpO2XKKMV1QGDR0O2qYGRAPiM/uBAYdLO9MtQgzRnPoFOPT0r593tgJZeeMgYAoAzHif0HLKjukpF8Ae5phUhV4aR0MRDuk75pxY3Izvmvw4DZLxXU1geJO+QMJjQSbAYKWPutuE3V/jDCPDzMs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IH4mMdPfPDVZySgrn80+v6hpzqCMLgm6ovKFzXAIC8bWhSURkx464Rg6p9TF?=
 =?us-ascii?Q?SvK/MZQ2RWo6ixXqFZyY/JXu82334AIfwun5JszoRP2rwlfcbSnlmtemvP9C?=
 =?us-ascii?Q?9rr6Vm3G5sLCmAhPgi9Ms6llIfvtVFqSGZRhTF+qED8PzXjIpuf8/53j5kuK?=
 =?us-ascii?Q?IRqjFw8j7HbGQIFKXzqnu6fcFBz3a8FxbXT1I/TWMkeCjApRCL96LEAV4W1d?=
 =?us-ascii?Q?OAnflbUYR3a48bbaU4d0sIrsfaCWZ8ZRSleG+/qykEWAEr9+Fh1j/cpjzGV/?=
 =?us-ascii?Q?4c1Jd6QR8KS014xNWD3cwcWpzd5nSeVwFp3EiOL8KlhHDGpqYkhPZ8yEvwq4?=
 =?us-ascii?Q?O3+NVmQe3gEbgdjiaZV8lFoCJshT0Y3M1sBxLyT37mpjZ1+YdGldW363Bo8q?=
 =?us-ascii?Q?6fMh8hAV0xTyddqdd44LLBS5ykteCP1u6/Ku5h7/jEGaNhIgwriqit/ORlH4?=
 =?us-ascii?Q?fhMYqQQ5gKvuF2Xk8XYx8SIqIWBmg3eVDFUS98c6UsPIzmXwk2y4vgeLKBlo?=
 =?us-ascii?Q?lRJiirmRkl0478ZrOtldKsyZiZn4vynnqaUFPyu+5mqEf51vyIq/8XHzFPNf?=
 =?us-ascii?Q?tSoDGP2YNc0OkEZhqLsgPQhvszk/BWIZysCbXBzCT2kR3MoDWTFzI7quWMxi?=
 =?us-ascii?Q?+N6DiwntBauDR/PSyRxyoJAeFUV8VK0a5JajRWUH05EibY0fus4zy+Z/UFKV?=
 =?us-ascii?Q?XiCD/TsbQE6BrTAp4WDj0Nza7UL0WfRkIVkESNsopy+0L8fpq0al/CKvES30?=
 =?us-ascii?Q?SPp+ypqnxDDSDTO5f4Z+Zb0LX2z4DtKOCQMcegsn1Rud+VJZESIZ/guZKiuo?=
 =?us-ascii?Q?f5kRdwMB6qlkMDfb9dnHAGq1xLTQDLOT2DpuYgbY0f5WaXUlJhLn700YAxQn?=
 =?us-ascii?Q?QeuUqAA1xRb2XnmfY/K9ksmWCr/KnPqM0JsAkgF/0A/1Bo0e3gd+BGprULBi?=
 =?us-ascii?Q?FySbrdL1kOeKNuqCK30E8w+5cYFtuSf2zUv/tM7frJTD0mnjTcd12DLDuXxq?=
 =?us-ascii?Q?QYjSsTXfgeyrMYuB0VLi9xvMPogdXNmXfli2M65416pr9lTFSWoDK/J/7OpE?=
 =?us-ascii?Q?14gMyaskCz5DnM9aVIZXn8nEou75rdVVm5xT+TLWNFsQEYr5gXsMSi5jaUUC?=
 =?us-ascii?Q?QR0y3pnWJXFTkauarqHMJlhMYrSydsPcotUwV4NGkShg/TswgYusPKii6L2b?=
 =?us-ascii?Q?bE/JPVnL1JxZSQ3KwGaJckhNkNaDVitp2hKGYjT7XALgTMGhvbn0p5KBraPs?=
 =?us-ascii?Q?5iKGObOfKYy6DViBRERO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1a26da-30c9-4ddc-0c99-08dcbe63a62a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 02:23:58.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5337

Enable MCU driver for SG2042 to provide thermal and reboot support.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0d678325444f..a0f346301df6 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -170,6 +170,7 @@ CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_SENSORS_SFCTEMP=m
+CONFIG_SENSORS_SG2042_MCU=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
-- 
2.46.0


