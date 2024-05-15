Return-Path: <linux-kernel+bounces-179279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C78C5E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB11F22207
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBEB4C99;
	Wed, 15 May 2024 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="X38KXFsY"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2070.outbound.protection.outlook.com [40.107.113.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184901FA3;
	Wed, 15 May 2024 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733473; cv=fail; b=cneREZ8c8ZLcZCpl4STWCTjyyZEKwpLlNyJS5WVxQ/Um+d/x/gAuCOljoUQQdaenwTrABlpHaRkFd/UISYhtlL8iP9ehrOprC/eZ3zh9qnHI4GqjoDQ/k7hHXI5djSGEV0ZZ1VGkTwWJJKEIia5qtLIVVGkLYmXzINbZWCXirxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733473; c=relaxed/simple;
	bh=76oWPDEifL0SWAodZftthmccmW+qEgMDHnQ0QK29rOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Cy2syMIyE5jE4ZJeshjvsiJsxpCVfpnoB4SbjmcruFzUa59x3+vtRnt8rYfsv0hDrmHhRa0TmneoDXsTfOG/PsmBxTLSoTEfl2ChfttC7HCnvFw8eabIQ5yG8kh2VOQIktA6NXEgkswGa+4uACkU1TsERpIh2mcBNb7uybkxLyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=X38KXFsY; arc=fail smtp.client-ip=40.107.113.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1RjE+I0m5pk7hTovzUL+QrY278AYdYmjnfhj+JuwppV0ytU01D9KJbBoUeRHzZB+B1ktEsmvKcJF/VN+4yTmdfTAlMF+zilPaPzkaKipguiUsj/6VYRufQt/wijO1MKE6Jeco8r/W4um3ytVPkGA3BA0JSjQQxlgHzo94rICRXqQC5CR5fsKSVN97pfAQeDcJd1WR5ynervpvwLJOqhD07kgVnlmAHBz10hTWQPDsMDoBrIcDquA+QWGlXdIG85S222o22GI5yEx2oufuRZCpnBOkwGqrRj12EtQF8zpNuEEYVljrdBLVJyXTktury5Ba7f8swnvbwLC/STdcJU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrFL3DR5R/m9RPsEZN+F6ch+tKAH2aKLKMJ7Pt+lVUA=;
 b=k7V345TF6DXlkVZhbK2X8mpikjvUdVZhVith1enextw0qX/q+ae1GnWNubJ1xpIBL8KZu11eN9Svn+A/6JVphfRn6aAepAWn2cHNRyMCkJyhS72/F0jrxI/CAyN7+cYwoQ97ln9N+bVuvGsCVHllSkfrSIqUF7t+Sm966G3HjvY7/jeq0yrkx7kzycj6uKLLpMo3l0xTKTo/IZKd9Yj/v3ke324yPPuQbKkR8NdM3V458BNp+moE7XLQgF2pnw++D7f0Ylah0hTsr+9tUiQLpPOQKGu1WLL2lOa2r5k0/MaD6GwKDkmtoVl3bP/vHBxELfyfjpMQ4e4+FQDxp5M38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrFL3DR5R/m9RPsEZN+F6ch+tKAH2aKLKMJ7Pt+lVUA=;
 b=X38KXFsYWUro1LPTAltbSpz62bf+rAIMdqJ4denMtdoMvr/RO9haL7mcg7vffMfmVvCW6s/nha3FETAKvzRGztzhmWVZt31Kio0R/VUcOJFEfDxRRCxt2v2bSkPB752lXUCs+o0B/YM3jD7X8pMupdhDq1J7Tcnx/BQYIvyJ0Arp82bwAGxS/nVYh/CT1GA4kaVDQhalJjQ1LzIewqex7mz+F6cSLtNF7hHCqhZvfv6XA4nQp0uratwRS2ZL1gRSiFYokqyK15uYHbx/a8K/kHfRj9E0UZ2C/WNGsbkNcBvxohpZFyh37NK6tu+dphNq7vf5Gj4b9I7s0t1m8pIKCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYCPR01MB7701.jpnprd01.prod.outlook.com
 (2603:1096:400:17a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 00:37:48 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::fe5b:1283:68a6:dacc]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::fe5b:1283:68a6:dacc%4]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 00:37:47 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH v7] usb-storage: Optimize scan delay more precisely
Date: Wed, 15 May 2024 09:43:39 +0900
Message-Id: <20240515004339.29892-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: OS7PR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:604:258::15) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|TYCPR01MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 871c35c1-e0a4-4a73-2767-08dc74773e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HF7dEFphRsEkuCiZ1C/OtAvt7/QQDNJbPR5OL2GeuLNC+XTCGDoxi6lWg+ZG?=
 =?us-ascii?Q?FM0FzYQ2vV5zUQ57N+6mekdAwcss+RiE8BY87Azlj4oBiOtNh1vIDWhcHjbo?=
 =?us-ascii?Q?abnonNBYjL3+fAwpHmgXnQF9ipoz3O/1QHmbgeaV8ickjvksQc7sejMeBqfe?=
 =?us-ascii?Q?Cg1DZrAd0Qg8T4O3IGxBq71itEsKkwc5WauJPectNEUDTBqlIAbuBASH2yQh?=
 =?us-ascii?Q?UkpH4hN3Xf/kz5Bicvj7XIYkWFKNqEqkSLoYLHctxbESE9hW52hIrT+U6KT0?=
 =?us-ascii?Q?uiydET5rquaAjxGK+CIFzu2Fk2OWyXBWkrZ2dRPodDidiks25WId+/5b4Izk?=
 =?us-ascii?Q?XYNmPHlGRb8BhAp9kFkIfbla1Oi9wJD3x8EOt9/MaBShomoCUgn2dgATfTlZ?=
 =?us-ascii?Q?zJLUTDur3xD5QsQRipTyBTiA6vFNzZSkWn/VEWRtGNFwUzgwgXa4qtfvaJyw?=
 =?us-ascii?Q?MSVfQB/0+3/PH1Hz00E8ERtJ6ZqXnD3Bj1O4J6ph+l5CNtKdyo3KAoFfn4Y7?=
 =?us-ascii?Q?MuY1JNGQRbpNzjqsqAPmRiJi49xY6RYiGiO7aeov0R2B2Sy+j36k6Env86pv?=
 =?us-ascii?Q?59ij2KSrW7moulEQusd/hgZj15tWZQKMETekBnXKIrwSWAszS62Y2G/mHnJK?=
 =?us-ascii?Q?DJdVQGVlizWebw1X6BFPciafLAKXBZ33crJ0cxIJAOayfNdoHmAYkL6bpFZX?=
 =?us-ascii?Q?xJn8SW60lNIVVlN/fUFG4tLPKpF231ummsQnQXVCkCTxCA5NyHlF0z4cuhL1?=
 =?us-ascii?Q?OgL/5PR3OFtgj/HRbUAZSSw3R5IQHc0KYUjI1EPHWaFbdtULfaLWfB/eMV8n?=
 =?us-ascii?Q?HdX23hgRM2BvfRFfAQIQSeRlWbY7EyyQbVG9SA1ygGGc2bVbpG5A6zwEpEG/?=
 =?us-ascii?Q?B3eLL1nfP0C9kGT3TUz8a0AYjzf0kNuNdT3xFOJB0BeJrWK+YjZkqjrH9ez5?=
 =?us-ascii?Q?V7Gyz1D4V3HlzgMn9vHBCxUzj05ys2hjstS6qi+Mk/ZhJNs8SF2Efq+OVn11?=
 =?us-ascii?Q?EVnWI+VRVnJwP6ZrkzIsgfvwGMYEeH3yBiP/vqkFSfrt09r8ufo4VfcfwLjy?=
 =?us-ascii?Q?bwU6zizte9xzd1N9vn6ySNZRyrHEczmoez3hKV2WEwyj3neik/GnCvFcdhm6?=
 =?us-ascii?Q?bT8Kdr5MfQ1AxTsPXImaZVsrGfB6XkZC8TTJpz14flHuuUE606G+ZS/NU9TO?=
 =?us-ascii?Q?XcfZur2HF5bbIVkzo0EiCA6jawq4hvze5WSZiBMLA6Y0YAlNDisNbXj+sj9m?=
 =?us-ascii?Q?m7aEnDLp+inIE425F6nN9X08Y8VY+3ZF/zqNmkwchsaUHb5eWD37A2Y4GqFz?=
 =?us-ascii?Q?emB9tZF6HkiNyURv2WMwCr9y6UEn8s8lO21Ep1/VLAUSIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eDTO8eSJG0HR4/7ec9es4GIAC/O8BbPtt/4jUmsfcM37kLts+RPDCY9Z2dd2?=
 =?us-ascii?Q?Jj0H0Nsv2HDKwYuhZIQMyDPIac1Hg8S8zxdA6/lPC09bUFH8nCegdo4a5E0e?=
 =?us-ascii?Q?LL233hhZvPe9bAVPKU/Q6Hb5P3nPghQCyL3x22fWEklbrMiVQVRkntWoyjOM?=
 =?us-ascii?Q?/wYWWMJiybZYc8f/IVJcYJG1Ec3Ebi/o7T8oA883q6bd3x34HKS6DpFDtWx1?=
 =?us-ascii?Q?4IjGd8nF/RU4tM32tLIdiUv0nCRt5t0mssMOc2nzim1/JwSFoJfim9qOHXXC?=
 =?us-ascii?Q?hdowE2n2IpkVc+jF5YULwKcxlPdzB3b53Gw9IdGMy59WOvO5Tt5eHkeCkVDn?=
 =?us-ascii?Q?FyN2zGOd+9OOpLLMM3sCDaOq/86wTDXaJRuvnel/UGqZ7iiiYzTIPxKYxkg4?=
 =?us-ascii?Q?xmEHyqvHIieomuWAzAVxMsC33ctpQ+H1ziaXEvS50I1wz6rkxHM3yli+ze05?=
 =?us-ascii?Q?hpvY8Cdm694zAv02w/cOoljTw6GSYO97hM3Kjp7gXfpi8lHWeuE2TqQPJmOr?=
 =?us-ascii?Q?+izh2/9DbNvXqHs8DDRWDAdrd/Z2CZUBy02RqD6bMXdiMvubAt8lKZZfywCJ?=
 =?us-ascii?Q?x2GdULrB+0EYbACtrIhSXPtr40vxMfbZ0yrX4VClzTQriFR42heT++IQOsyb?=
 =?us-ascii?Q?FSMeV7c3jgZixz04EjNJqu6FvyQzPSvF7D1sfs77gaa69+SW+rmm6E780K/c?=
 =?us-ascii?Q?DCu+nJ1/nz6Bh0Mng1ihQVXnXG80xJIbX62winyiSL36/YHufjCtGqpka7/J?=
 =?us-ascii?Q?Kcts9jm5awjT+h0EOKyfpPKgEYnVefXBOck5oOL41MobugRYZ/goRkzvuy6S?=
 =?us-ascii?Q?5QQTwbHA80Yl6uVERDJ21DHT34evAKboThkDz/DYJpr2u/Kiz37kLSD5xZKH?=
 =?us-ascii?Q?lp7IA4TRK/nD1LCeAJ9JcvaJSWc/OJP450sHXYnaOhcY84dkkDNLhfm29Mit?=
 =?us-ascii?Q?4EksiQu/0YGhJZwCLTe89V073mNKTIfnFQnjRBZYv113J3rCo7zv13u20PND?=
 =?us-ascii?Q?5+79I2lFxrdwIl0DkZucAoXgAWoVo3V97eNlAeDhoXV9OXJog1Vjh2UNkjYq?=
 =?us-ascii?Q?cIZ2uecPz/kbt9XFwlKoGgJnlTaSMD09qZLL84aaofiSqitMhjQwZ44yQZFV?=
 =?us-ascii?Q?Vt34xDOLUo00iEzIhuY5nuKF1fALkekuYoVbkm4X16FL9OWKm46nRM97tiCS?=
 =?us-ascii?Q?Khqz7/bSVqPTihX1r2qqViKQ+YY7eBWgdjtq8BuWvo6NeZRQPvbkWtRelp5l?=
 =?us-ascii?Q?FHiyMIaqKPIM7EdxPyr3RxlzmStlZprkRe9axvlvaUeXwcf8VPLxweY+yLSY?=
 =?us-ascii?Q?Xcg5O4LSjoCaozCRkeXTQzRRoFsNFgMd0OEeqRIjyfIh8/OY2RgEwJonTduc?=
 =?us-ascii?Q?BoxNP2/fKdjGXEsSVxsMZeagf/8/7QjfB9ohzr73mgvuCTHvf2at001nSVTC?=
 =?us-ascii?Q?KcXpC8yYjeAVzgG4Fjk0EMq7+dD0Rn36Iq6SDej0Co1lGJvDDPueKusDUzKh?=
 =?us-ascii?Q?bFBhub/oJhObdagCcI0wDa6BE7Onkgy6jwjxgCM0arasZmmpFqEmRXt68yrd?=
 =?us-ascii?Q?GsOH4jfGpttEc2ZInxxZDvlrPMEOti8y6Clm0vMw?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871c35c1-e0a4-4a73-2767-08dc74773e73
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 00:37:47.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhvlfBOnFEWUF+Q+K5JqZmTWYFeRx+9nvCf6CXZONKFObxkIR0FyxnoAjKhn58Zo/51lVcejrBv1NXOg/DCH9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7701

Current storage scan delay is reduced by the following old commit.

a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")

It means that delay is at least 'one second', or zero with delay_use=0.
'one second' is still long delay especially for embedded system but
when delay_use is set to 0 (no delay), still error observed on some USB drives.

So delay_use should not be set to 0 but 'one second' is quite long.
Especially for embedded system, it's important for end user
how quickly access to USB drive when it's connected.
That's why we have a chance to minimize such a constant long delay.

This patch optimizes scan delay more precisely
to minimize delay time but not to have any problems on USB drives
by extending module parameter 'delay_use' in milliseconds internally.
The parameter 'delay_use' optionally supports in milliseconds
if it ends with 'ms'.
It makes the range of value to 1 / 1000 in internal 32-bit value
but it's still enough to set the delay time.
By default, delay time is 'one second' for backward compatibility.

For example, it seems to be good by changing delay_use=100ms,
that is 100 millisecond delay without issues for most USB pen drives.

Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
---
V6 -> V7: Fix kernel-doc warning
V5 -> V6: Change module parameter 'delay_use' to optionally support suffix 'ms'
V4 -> V5: Simplify parser/formatter code and fix documentaion
V3 -> V4: Separate parser functions from module parameter set/get
V2 -> V3: Change to use kstrtouint only for parsing decimal point
V1 -> V2: Extend existing module parameter 'delay_use' to support decimal points

 .../admin-guide/kernel-parameters.txt         |   3 +
 drivers/usb/storage/usb.c                     | 101 +++++++++++++++++-
 2 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 561d0dd776c7..a56f906b960e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6190,6 +6190,9 @@
 	usb-storage.delay_use=
 			[UMS] The delay in seconds before a new device is
 			scanned for Logical Units (default 1).
+			Optionally the delay in milliseconds if the value has
+			suffix with "ms".
+			Example: delay_use=2567ms
 
 	usb-storage.quirks=
 			[UMS] A list of quirks entries to supplement or
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..0b5e86c731ab 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -67,9 +67,102 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
 MODULE_DESCRIPTION("USB Mass Storage driver for Linux");
 MODULE_LICENSE("GPL");
 
-static unsigned int delay_use = 1;
-module_param(delay_use, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
+static unsigned int delay_use = 1 * MSEC_PER_SEC;
+
+/**
+ * parse_delay_str - parse an unsigned decimal integer delay
+ * @str: String to parse.
+ * @ndecimals: Number of decimal to scale up.
+ * @suffix: Suffix string to parse.
+ * @val: Where to store the parsed value.
+ *
+ * Parse an unsigned decimal value in @str, optionally end with @suffix.
+ * Stores the parsed value in @val just as it is if @str ends with @suffix.
+ * Otherwise store the value scale up by 10^(@ndecimal).
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int parse_delay_str(const char *str, int ndecimals, const char *suffix,
+			unsigned int *val)
+{
+	int n, n2, l;
+	char buf[16];
+
+	l = strlen(suffix);
+	n = strlen(str);
+	if (n > 0 && str[n - 1] == '\n')
+		--n;
+	if (n >= l && !strncmp(&str[n - l], suffix, l)) {
+		n -= l;
+		n2 = 0;
+	} else
+		n2 = ndecimals;
+
+	if (n + n2 > sizeof(buf) - 1)
+		return -EINVAL;
+
+	memcpy(buf, str, n);
+	while (n2-- > 0)
+		buf[n++] = '0';
+	buf[n] = 0;
+
+	return kstrtouint(buf, 10, val);
+}
+
+/**
+ * format_delay_ms - format an integer value into a delay string
+ * @val: The integer value to format, scaled by 10^(@ndecimals).
+ * @ndecimals: Number of decimal to scale down.
+ * @suffix: Suffix string to format.
+ * @str: Where to store the formatted string.
+ * @size: The size of buffer for @str.
+ *
+ * Format an integer value in @val scale down by 10^(@ndecimals) without @suffix
+ * if @val is divisible by 10^(@ndecimals).
+ * Otherwise format a value in @val just as it is with @suffix
+ *
+ * Returns the number of characters written into @str.
+ */
+static int format_delay_ms(unsigned int val, int ndecimals, const char *suffix,
+			char *str, int size)
+{
+	u64 delay_ms = val;
+	unsigned int rem = do_div(delay_ms, int_pow(10, ndecimals));
+	int ret;
+
+	if (rem)
+		ret = scnprintf(str, size, "%u%s\n", val, suffix);
+	else
+		ret = scnprintf(str, size, "%u\n", (unsigned int)delay_ms);
+	return ret;
+}
+
+static int delay_use_set(const char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms;
+	int ret;
+
+	ret = parse_delay_str(skip_spaces(s), 3, "ms", &delay_ms);
+	if (ret < 0)
+		return ret;
+
+	*((unsigned int *)kp->arg) = delay_ms;
+	return 0;
+}
+
+static int delay_use_get(char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms = *((unsigned int *)kp->arg);
+
+	return format_delay_ms(delay_ms, 3, "ms", s, PAGE_SIZE);
+}
+
+static const struct kernel_param_ops delay_use_ops = {
+	.set = delay_use_set,
+	.get = delay_use_get,
+};
+module_param_cb(delay_use, &delay_use_ops, &delay_use, 0644);
+MODULE_PARM_DESC(delay_use, "time to delay before using a new device");
 
 static char quirks[128];
 module_param_string(quirks, quirks, sizeof(quirks), S_IRUGO | S_IWUSR);
@@ -1066,7 +1159,7 @@ int usb_stor_probe2(struct us_data *us)
 	if (delay_use > 0)
 		dev_dbg(dev, "waiting for device to settle before scanning\n");
 	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
-			delay_use * HZ);
+			msecs_to_jiffies(delay_use));
 	return 0;
 
 	/* We come here if there are any problems */
-- 
2.17.1


