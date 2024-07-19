Return-Path: <linux-kernel+bounces-257061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853199374A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3561F21BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A05820E;
	Fri, 19 Jul 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrD5wPCD"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013032.outbound.protection.outlook.com [52.101.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302673D0C5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376150; cv=fail; b=Ob8he2ZlyFLjLl7/TFYPRhFqwfUyDUhD9CQxOY6VdIGyv+Y6MnI11fNaXY9GMIi8I5wXxsBAd6Ldef0bNA0FlNZ8FSUz13PFxCZiDJxuDt9OQil1dUwQIH0uPNh+rJChKznC7DYyctZP87gLn5B+WT2MBMWMYFH5OfHT4o2HsSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376150; c=relaxed/simple;
	bh=McBx9bF0+ityKar16L6NtGHZZhAva3YyCHp7LYuD45c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dXWSUey7J6WlPYPHDtb+cJ/Pns0dPDK1yOXie6qUGwUhxfiJJ0UDyVA7w/BXpuBUnzXqMTwsXiCMkAwjMcY4q8B36K5SXdpfaQwSFDKi3zr2EGqL4JouwgCdHEi0GcwxNzoW+qDdqWSwGDpWVbWDedn8WJfzTCHsRca3OJsJ9Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QrD5wPCD; arc=fail smtp.client-ip=52.101.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYtulHmlggoRx2m11h+xqjNQ8REoemws5Iqk5hiHhQ6d9FHpRU5mlKGqRTVo2iKrZfBqrmrYhtAyWkQAqS6tH00o/EF6xjW6JLofSj3g/2EajHbpjkw8+qAUW4N8jgt+fBN0oxhuB68LEaiNkRocoJfTWuvljH+YLV6txAtGgwRjXDprxlL9fvE2Ku223h5DqS+BwEVzRidSWuNwDp80hc/QXmrqhWGFIszwxc7NAltNokKyi2nUOmUZUzhmBtKNU8FmSbW0q/VmNPCDeo9xyItPO6oQE3TGXxOYnqRJUjCu0d5v7A6uJfd+IA4Na/vfZO3crWTys2+eZtubBC3oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kclzZsf89oU0/8U8AfbHE692mz65GEw4MU5xRzHnk+w=;
 b=fNhpA22oCg5oj0L+PC55VEHdc60wre81sNBGKF/g9wknMfSVP6l3NJ1kf8VYereuHYicObhs0IQhrm8cGHbLTIVpjkykyZbva3xx5DnaEn7AU7PUetjK9yNo4uFLZkmkrW7KSv8/ax2Otlx4VtuBpjh3PSrErg+2+byN6zNy+HbatC6jrW9RTKhdWselKLLg+E/fcNe6zqQJruge7pJfK1OGI+1pn8KAVJzed68mkMGk8qDTq4BfmrDqKqNiCTS5Ixt6jWp1sFNqQG5SdX/oYHkXAX92fmIVf9+xFapr5VsLD+Q3PrFJcxuoMdxv7fwlV7WnoSlT/MCDlYcUN4lahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kclzZsf89oU0/8U8AfbHE692mz65GEw4MU5xRzHnk+w=;
 b=QrD5wPCDOfqkUXoUiZ6BXWefWwGDwEExBKq4cgWDnTfzwv5fapX/17G6OJnuS/0fgMx8BlQuNegA6SVoZT+t9joRHokIyB+afQAdHSvYyi3X1H4iprs5NL/L6ivwhhsxXUIuzjv+3puuuyS3WgxRX/5HdtWCbT1LCluxmFPLe2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 08:02:25 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 08:02:24 +0000
From: carlos.song@nxp.com
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH v3] i3c: master: svc: adjust SDR according to i3c spec
Date: Fri, 19 Jul 2024 16:02:33 +0800
Message-Id: <20240719080233.842771-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7cf83b-4cbb-4f1a-361d-08dca7c91fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qewXQm539CvVUzT0qVFByOCRPr0aGuhUZzvM8cCTYmivHFQXlQboQanz/2Zm?=
 =?us-ascii?Q?LlyAI54mEy2hOWfFSvG0bfH+Nzuw1ASLR3z6mRqha8CrhqiSNYyUVFuvTKr/?=
 =?us-ascii?Q?dnOqmbdI2UIbFpqwM+FO9hkxwkJGVbKl533q9280bDtD6MsUXS7XGn1EW15C?=
 =?us-ascii?Q?bgHWnDDCnmP0LunDLEVz1sjQLB/6MYCYFsXqIxjGYWPIK72lF4S9TKHtDgLx?=
 =?us-ascii?Q?dQuRPXOjk4ldl+LVHfMtitY2exoGXdxiN+f/cWyOi4dmX1R/ojQw9ktkgViE?=
 =?us-ascii?Q?7f9Uy3s9QaNDeRKYNYldTtbvTU1gBfM+zdUUZBAqHYFlpWRhsRTqE+8Y4Vk4?=
 =?us-ascii?Q?/iWSXgWFNT1gV6rERlTEPPerCsr0UUUDmektv3ir/BKTBSf2y4tyPkV41BZL?=
 =?us-ascii?Q?OnXteAQAEA+qtdjaPa5lzI2fAGn4VdlnqKjGfrbDuNfxcjEK43OYWPJx9PYM?=
 =?us-ascii?Q?VxqARgLHihf/5TsIuU/gAKGyhbvcIxNWLCGgNrd6JWf3DkoDei9DgiMR5ZH7?=
 =?us-ascii?Q?gLCAS4IzsBRHDSkZP8P8AjVcFqHQwaadX0CcCUOLaXesJCai3NBbD6FgUw71?=
 =?us-ascii?Q?PRowioUO3VylPmMdoOuDxQttj1rWqX+BurkzoC8qhbIxx1piOB5HGwtphGY8?=
 =?us-ascii?Q?HbtG+B1aw3Y4fKOjHMB71lKNKvYsgeBHCjj9ydsbFwxZhs22p4IiBjHeYAJN?=
 =?us-ascii?Q?2t6SgsPLDXgwvGcXS9nLD2NH/O2H+ulQBzPnrbfv6U7OeA6A6GcaMQ7V9VWx?=
 =?us-ascii?Q?M/F+meMZ2nkIxE362XtUrI1sI81icmlbZ2ZHJg+j+C77VPWmL94YQu4FJ/4S?=
 =?us-ascii?Q?0qYT6lRLqEwnnVA2u06mAt88BvDo2QoGsJiogYTax/VN45V0usv0p2NVg6Jq?=
 =?us-ascii?Q?INEqeevzzK6wq2tJJPFLgu6EG6I65erOGd+ypDm3xN7NkcqK/XYto4rSeZrY?=
 =?us-ascii?Q?6syssQorcyz+Q6urpJyxzQCJO3Hi/GrhgR49aiocywTtcYN9fB6yBMudQ8kX?=
 =?us-ascii?Q?DCwnbZRXMplIpIXVKCs+GlP8lYUVI2GqE/JmUP8tZbLD5lsuBRnxgR+lkC/q?=
 =?us-ascii?Q?XeJ9Uc2O97tf5lPCcKioNQBbx8lXao+QF3EplTIXlEPqBUqq7yKzUyCSH8tR?=
 =?us-ascii?Q?mBxaFWaytVQAxux0ymOJky+ZlUs9W1y/Wix/2DVRB4uB4aNyQlY52ld5QlsV?=
 =?us-ascii?Q?5cZdnfUm4LqwFAsu9oZqRNWB1Qf2+JPzXahEVnMrVDGna7pBxkOfXHGtvl7F?=
 =?us-ascii?Q?o/qBP5GNMI+UtBKEW6iEWUCvpeTt72j/wfj0jQKh3NrIhrcmbo6/1MhtrbU/?=
 =?us-ascii?Q?ycWxb2vPzmcLmOHg1/nfMPHbrz3H0Mb+N/zc4YMPaZb/sr4GIEX4bsPKAXIB?=
 =?us-ascii?Q?7cCpx4KO1ZInAj1YcVfgP+a221Hxr5v4h/cyWSKKvzvSPOqhGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iJbHlLqpKwVj9QvnCaKvSMYWmosJBJhk+oOkLhA7r5V6HCegpUVyeNFtHgVU?=
 =?us-ascii?Q?oxN8hP/HUd2dwenL1Rh49pnc34uGRyRo9Lb/mQ/WM6vAMVhjyV6wXXvELy7f?=
 =?us-ascii?Q?Hu+O/h8NVeEtkeQmVOyZ8vv0wDDlsl5oieO013HW6R1JKgt7Uii3NXXheiDi?=
 =?us-ascii?Q?FiOR7KJFlKaST5CsXZJZ7EEm4kaRVeto5VQ038jn7m+ubgzGyITXGVXOxtdR?=
 =?us-ascii?Q?MsHfSwe6FBiqnSuG7cn02Fe0FNdYAy9vGbEg4ZWMbkxCSo8JV/ZrZ2I5p5YQ?=
 =?us-ascii?Q?em1Eo7NJsZAGhSXubYer+xyOCVCjK4FSxWT8rtt2ZhvVUnSAib9L/O72t2fJ?=
 =?us-ascii?Q?kJ6zZ81tnTRfzJPaHOTrMTmNfAb75cDLIo/uVoYfS2QM2rbdusteomT9AUSh?=
 =?us-ascii?Q?vHgMXgvnzrmpR/jmhna0G7GSUv2OlJZFVSpopW+d0ocmJMJj8WKbccK40nQ9?=
 =?us-ascii?Q?qAYuqxoGYi1P6RxbkMW3l7Wa6KXv5uliIx0mTa2blh3w0ToZcAzyaLtMuVr1?=
 =?us-ascii?Q?8vyKvOoFlnvbJRqbVy1FOEpwD4gscDRGnadaCz5Xzlbj8coTuw7FqDpqKRkZ?=
 =?us-ascii?Q?exCJnII/vFC3TMxcdfMCFEUZXXPcxfDwnYXgv0nRWPmYL8wMyZqLHvmeCn/M?=
 =?us-ascii?Q?vPykexkyZn/Hhgwp63M7A+lO8lEyTrm0zCdrn/qUxYXwZv24us0Vl8wITZL2?=
 =?us-ascii?Q?A/xFw5PZH8ac8iyn9FY0sZWftm6oZ2HrxN1XEo8sQS1l7pIGc4GUBATrQFgv?=
 =?us-ascii?Q?j6lW9J3mV3rZ6Cb7yZ+h144Z2Eov4VhWLGgl5mXNnCSBVahv32LseMakD6xh?=
 =?us-ascii?Q?a0Vn8k9qYR9ZFhZcQkEnQbnzUA8INJqDPMzhOvZSMIiOw1FLuAIdq5Eqtrcg?=
 =?us-ascii?Q?56cKjLJLSLmo4ZQjmO40ySOa0LzRtx7X8SwQC3N9/JGu/jKjOuERp+7fbE2m?=
 =?us-ascii?Q?r0ZcT9IcFQqHUghZQfk4WL/R0c8zmJKTHyp/Ut2KjXm8qKSInQiJmxbfhcmq?=
 =?us-ascii?Q?LVVjBSfUk7QpjJ3OKeUsVTejBAcq4Z72GhiJerRlWKmlz+ur+hs9M/5qhTvN?=
 =?us-ascii?Q?Xw9zzEtmvL2oBfL7Llpumac8FTY9NfQhtZG6Tiw2MMw+fpmXpWeUervrVQfg?=
 =?us-ascii?Q?rHkOmQMPNWUDzRUTUFwnXTMyE5l3rRAocBjPXctFTAG/JitKk83lvPB875iQ?=
 =?us-ascii?Q?OnLEtiqpi15HRJVCQncH7kJy2xRHSXmvxgg5VEAZv15+zUIy1Jp+IRF6LuCM?=
 =?us-ascii?Q?HIHgLPatKYXtDurRbAkJJDQmdl4Xa0Q70OR59OS8GjOCl4qeMc9b3Ck8bswZ?=
 =?us-ascii?Q?2AF/RY7xJeFLwcq/cTktNpMJHVoCsi0NKP/8G/H4EbufLF9P0YxAqxAbmX6W?=
 =?us-ascii?Q?BqFHssQd1talsMY1mYdyyldQ4Xn25dseNVZWWVcVXVbrmL7lNHgE+yotztKY?=
 =?us-ascii?Q?HwVEVVoONIsldMFQ07ry6OBunjlzazh0F+PbY8Mm6uMFXhZ6p5DH5wgfTtSy?=
 =?us-ascii?Q?LTaFL1UzKQIx8iJAwIGyufpm5zUObMIVWn7JI5kD0sPrTbj1q0RuOnu0kF6O?=
 =?us-ascii?Q?YhZ+faC9l9wtttULq/SHAIw46vQhHhl7aVeU5cZ2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7cf83b-4cbb-4f1a-361d-08dca7c91fee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:02:24.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ozoyNNS0x08adFGdXZEt5j1zXv7r9cZQcf2gNws3mUfug4oYAkihkKHTIRdoSMD66GfITr7J0m64XRkOdLY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

From: Carlos Song <carlos.song@nxp.com>

According to I3C Specification(Version 1.1) 5.1.2.4 "Use of Clock
Speed to Prevent Legacy I2C Devices From Seeing I3C traffic", when
slow i2c devices(FM/FM+ rate i2c frequency without 50ns filter)
works on i3c bus, i3c SDR should work at FM/FM+ rate.

Adjust timing for difference mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <frank.li@nxp.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Change for V3:
- Add back: Signed-off-by: Frank Li <frank.li@nxp.com>
- Add back: Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Change for V2:
- Correct I3C clk configuration and simplify the code:
  Pure I3C mode and MIXED-FAST I3C mode just use the same i3c clk configuration:
  1. i3c push-pull timing is 40ns high and 40ns low at 12.5Mhz
  2. i3c open-darin timing is 40ns high and 200ns low at ~4Mhz
  3. i2cbaud should be different between Pure I3C mode and MIXED-FAST
     I3C mode.
---
 drivers/i3c/master/svc-i3c-master.c | 31 ++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e80c002991f7..78116530f431 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -127,6 +127,8 @@
 
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
+#define SVC_I3C_PPBAUD_MAX 15
+#define SVC_I3C_QUICK_I2C_CLK 4170000
 
 #define SVC_I3C_EVENT_IBI	BIT(0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(1)
@@ -535,6 +537,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_bus *bus = i3c_master_get_bus(m);
 	struct i3c_device_info info = {};
 	unsigned long fclk_rate, fclk_period_ns;
+	unsigned long i2c_period_ns, i2c_scl_rate, i3c_scl_rate;
 	unsigned int high_period_ns, od_low_period_ns;
 	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
@@ -555,12 +558,15 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	}
 
 	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
+	i2c_period_ns = DIV_ROUND_UP(1000000000, bus->scl_rate.i2c);
+	i2c_scl_rate = bus->scl_rate.i2c;
+	i3c_scl_rate = bus->scl_rate.i3c;
 
 	/*
 	 * Using I3C Push-Pull mode, target is 12.5MHz/80ns period.
 	 * Simplest configuration is using a 50% duty-cycle of 40ns.
 	 */
-	ppbaud = DIV_ROUND_UP(40, fclk_period_ns) - 1;
+	ppbaud = DIV_ROUND_UP(fclk_rate / 2, i3c_scl_rate) - 1;
 	pplow = 0;
 
 	/*
@@ -570,7 +576,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	 */
 	odhpp = 1;
 	high_period_ns = (ppbaud + 1) * fclk_period_ns;
-	odbaud = DIV_ROUND_UP(240 - high_period_ns, high_period_ns) - 1;
+	odbaud = DIV_ROUND_UP(fclk_rate, SVC_I3C_QUICK_I2C_CLK * (1 + ppbaud)) - 2;
 	od_low_period_ns = (odbaud + 1) * high_period_ns;
 
 	switch (bus->mode) {
@@ -579,20 +585,27 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		odstop = 0;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
-	case I3C_BUS_MODE_MIXED_LIMITED:
 		/*
 		 * Using I2C Fm+ mode, target is 1MHz/1000ns, the difference
 		 * between the high and low period does not really matter.
 		 */
-		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
+		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
 		odstop = 1;
 		break;
+	case I3C_BUS_MODE_MIXED_LIMITED:
 	case I3C_BUS_MODE_MIXED_SLOW:
-		/*
-		 * Using I2C Fm mode, target is 0.4MHz/2500ns, with the same
-		 * constraints as the FM+ mode.
-		 */
-		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
+		/* I3C PP + I3C OP + I2C OP both use i2c clk rate */
+		if (ppbaud > SVC_I3C_PPBAUD_MAX) {
+			ppbaud = SVC_I3C_PPBAUD_MAX;
+			pplow =  DIV_ROUND_UP(fclk_rate, i3c_scl_rate) - (2 + 2 * ppbaud);
+		}
+
+		high_period_ns = (ppbaud + 1) * fclk_period_ns;
+		odhpp = 0;
+		odbaud = DIV_ROUND_UP(fclk_rate, i2c_scl_rate * (2 + 2 * ppbaud)) - 1;
+
+		od_low_period_ns = (odbaud + 1) * high_period_ns;
+		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
 		odstop = 1;
 		break;
 	default:
-- 
2.34.1


