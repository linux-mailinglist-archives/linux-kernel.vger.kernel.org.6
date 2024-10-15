Return-Path: <linux-kernel+bounces-365214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 752B499DF12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE1E1F21F69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11CC1ABEB8;
	Tue, 15 Oct 2024 07:05:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2107.outbound.protection.partner.outlook.cn [139.219.146.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106419B3FF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975911; cv=fail; b=CfxhGpf7ODFl5BzpHGEmyw23RuJhKhL89R9VHmD0B7PUN/0uAZsNXzfGT3MP7vd9rWCGnK5mJWdX2AapRDtNQkLgxI4Fp4EdrvdoyvlX9tONC8LKV0F8+8NDI7x26RSHMHkzypHxBmNvHk+bBuJ4rckk1JEFUEkqgSJtO++Wx9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975911; c=relaxed/simple;
	bh=rx4bH3TW9cZJbBO0eAByeZbzQTLtXzKkZjbI81m9sNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNMtZuFUULh/MVSAy6dVR6+lDXsgOXmq1ctJjHYf7LCrMX++Q3gudVkIEXa3OnQw6bxnSkpWynpeW4ZTYo7W8/K/WjYIPScLpMPnClWGyE6LVdsukqUC/cCAhvABbWzsH8ZqS2SMxNjFmDzVMyKD7ZnWat8yVA8HM5NeduKInyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjThpktzg9QDmyBbL5itfVlx21on0LPXnr1pY8HuFpaBGfA6S/vysstFxdDKlMhcjJHfITpk7RV/3qBR4Ed45eZwF3cOWVEu3A3EMxCN/MNMxjNZRRwSpGsmk8/MXrH8PHUvCWTdyVS6PVkbKUQgy3ZpKssLnjxqxZNE7KG6dCq1ag5/cFSirx5bZ0a0HCvqPZwrUIpMQnPDuCIHuK2Q/0EihbqiiIXmJDuyMMqI4Jz4yuDdaP8X3MDok3Z2jsJFuI4JytFlk8GkUXj3rw8hg9ZAuyXC3EdcFC7DtE3uEhMmLTiX2a6WU3TXHQaaE3iEird4+Je6MLsPpp9oHTnugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q73KT/RcXCPhUGu3CmQc+8QN2avphxQYytMMMPhQkL8=;
 b=UB2FccsRYPEfTrDGD2Fpa62NyA2LDGQMsSG7v2p66+bfx91+ahHQ6SQCJJ2ZF/LPqGTbOhn+3yEU8mqRWjbU1V9YILULzO+H5ufEB4FWNpZ3iXxFWutSRQddFCbK8bBzLJAL5fzj997DYCsiQmnD1AqQn+Wb5ORUni3ZSBzwMQGpBWCSDfeL/nHjy60QTtKlT35c297rW8N/t9/h6HzTeqevWy5kmS3kTksPcLEUWTyjSKNbSQOie868OWmU+zyvMiLPlylwaHKfm8Rx9NQQHyZtXf43CUdet9Uwsxbx+KEmxB4oCGtclMSUxyYxXYZuTi/wVVMeoV3tpQkEAkXdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn (10.43.109.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 07:05:00 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%6])
 with mapi id 15.20.8048.020; Tue, 15 Oct 2024 07:05:00 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	linux-phy@lists.infradead.org
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v4 1/1] phy: starfive: jh7110-usb: Fix link configuration to controller
Date: Tue, 15 Oct 2024 15:04:44 +0800
Message-Id: <20241015070444.20972-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241015070444.20972-1-minda.chen@starfivetech.com>
References: <20241015070444.20972-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b955a0d-19ca-4ab1-ee86-08dcece7af17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	kvQBP2mo5G6woXloYe+cHRRlWKXMLjPxHwmQq7vbM/xd0lHVf9M2NAbnDIPFEOqPkrGO3551NK2y4ZDypnvkMMP5uKMLH9ZoHDoZYPkHPadB13vByi2D7T30A7vO0wUGGQrQCSCav1lJoJIONbpnGRYLYQg5niniw4Oo1oTlmL3Xrx8NMUanom8uLP7L+yywHYUVTGTTdTfiB0pUeaRD0s0wKE0XEtZybyJ4FJHMaCC6dshRA31xhEBnW/VZBKCWTEduS/ZAxmTHIUf+bBFo+VagjzFz3DuJPDmsxXGozM9V+JVnHAE/APEpm8YM2Y+g6bs588/oE4PhfxQdtkiOT3lL5AT8rR1BnKOL/FW2Dz1fhChiJ64FEcZfhkMzmBgIWTGFYQXHAgdKJ8OaGzU0otZse6bwUu58MAhg4+7qSqU9yk6hvGsDjAHQUc1PnTSbPin38nTYsNfOXOdiOwCKFLDLlAEjzEeEt+m17bh+lN0ckMb3p6+FfuqhbmL0Z4V0nHRMo6A0cjl5pggPTzxwHgopxLVa+tO3TwmwkekOIwwRs+V1E+UfgtrIHK1xw2EnGFUzoLTgmtZq8W5/8OPVJvOgZujutd2iEYsrknwLEea3bfIY9wm2YM+xRNlRRnZt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqOg634tx62psuMZcvCFNEFGASSiVbCckTX+YG1R+EschhqLGIfDgVRsEAnx?=
 =?us-ascii?Q?TN4HqB7tfiufqeAXiVUYxd8QAm1ys11GNk0tQsg6nrJmNFPQ1h25YuBwa0j+?=
 =?us-ascii?Q?KewCkT4/9Y8lKk30lm7ePzrhGzCJ9oIDCh+kVLkDjjQIUu7RLhw04t6Tzlbg?=
 =?us-ascii?Q?bhvQ+h/SMvXZn18iZgils3R593DQdq5uWE6RtiO9QnEiw5peTKTwrgS4SGcV?=
 =?us-ascii?Q?7nMkOtRzTKoqtNOVxkayiC4gwKnrL86c2ZyyKD4uGTJ1IZHf3YbsL86LcoGX?=
 =?us-ascii?Q?KGueihfOL9PHnay8A0nSwGp5osufgEs9BVPxeuq3YW7GMaHRClyJ4y+P2TSS?=
 =?us-ascii?Q?w3p5wJSlplkvv69XBnP+2bdNbMUkW1NxpyE+uwBe2JJUddfsqsbSGH6OQS8R?=
 =?us-ascii?Q?gbNW6gRA7uXp/HTxzLWOoXbh1/0RJkykVSGddSJT1G2VPDr8Zy5g9SNx1sx6?=
 =?us-ascii?Q?jVCZTKBPIoUvFFy2fxfGaoF6RJMXJlBOsRM9042xT0xo91hofGL2otIZnKby?=
 =?us-ascii?Q?QXoLB+Q8uxWb0Dh32aQeLD2aDkP6KuQXlTvjD+uIA1C5XhNJNX4ar7pkOCcL?=
 =?us-ascii?Q?FgX08uxfEhi8htkBrc6Hg7GTsPoMDtgc8YLSmlGCtr+46fgfLhwzk5vyyaaD?=
 =?us-ascii?Q?OfYy627Pf++GIJsZglCBRPAGzThGXi6Yr9l3d0aDh7rTvjaVj31TyWhhBGE6?=
 =?us-ascii?Q?TolIkGckawvqKppNHdbYBP+j9D0SFZ39ZtvD4CVpjuRwFa9r8e6tSsr+JfvC?=
 =?us-ascii?Q?DFdwjEbGg+XO8h3W/YEa2zi0XxghyQFeHIp6b0d5O+6OQ54ZKjRmxA35Vz89?=
 =?us-ascii?Q?1gM+xRqIZ7a8btL60OnDmJY5KqpOBURxbRYW2FGBDVyIHZgrgCwnJyVNYVXa?=
 =?us-ascii?Q?DmoDSPZQsXn0Z6uPrfGVkvhUo+VM2yBts6aR3t3D/VEn5OdiL9MA/2Dxl35F?=
 =?us-ascii?Q?EZ3d8+oAI3axxH+qPQVz1Wt3DkrRwCA9RdiRCxpX1kDsWuo7P7xPKKjj5qSY?=
 =?us-ascii?Q?DJ8tW4CtfLVNe+LdBfPNv0T66QVgLpW2Ew59GAe0tkdQ82D/tidm8dpyyM6G?=
 =?us-ascii?Q?Y0FUvcIXgXM8gXjvTBBFklyDSpf3OQX0Db1zpZntGNWb0yT+M7EYpeySvV5j?=
 =?us-ascii?Q?fUSlfTUTYhD9dnu72pZophjf/ammkJ/ku3iYH4O/d0a/Z8d3rz43t0OrqzQf?=
 =?us-ascii?Q?UE4b79Y9ZTG4Bupg+A+Exfnx6S1sj1wwyHEmZwKahHm8XodRIwZk1CYzZ9n1?=
 =?us-ascii?Q?nD6eLeVOgngGkkozJ6zTOR4I44zqOXbnDgRGmhdO5ncFbQ9i1yP+iJg8vqCl?=
 =?us-ascii?Q?lstIb9rCNbf8qUm+meIe2W67SGYCEy+o4TkwYu9q89JsQRM1yBFh7JVUDfi/?=
 =?us-ascii?Q?uxMA+2f+fna7ZgBOs6KfK47RAi8DyflttxAd/DRFtVDzB8pn/VsROFr5TKsR?=
 =?us-ascii?Q?o/tmljURi+/BskHWZyA/ZJObo7tKK4/A0BZxb1S9DQlLRibKzxnKJd6IT0KT?=
 =?us-ascii?Q?LIs8+nRj1qGtbEpTqFrKh2RThvnXcgO+f+ML0COEtbLaCH/jz/oY++1Q+ntq?=
 =?us-ascii?Q?a32ffQAoUNQwzU33W3uO36UdZS+U+Ozux/kf7DyWZ2+lD7ENVnuyxi0WAwcY?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b955a0d-19ca-4ab1-ee86-08dcece7af17
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:04:59.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkYfwdf0WC9J/msBwtXgVhKsxa+6TL3LWVJgC3bLYxcjZSmrUivmr25uURZENKwAnIawKiV5wei7o1FZPH6amlkF2Y7hIOkDmOSNvgyGSuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

From: Jan Kiszka <jan.kiszka@siemens.com>

In order to connect the USB 2.0 PHY to its controller, we also need to
set "u0_pdrstn_split_sw_usbpipe_plugen" [1]. Some downstream U-Boot
versions did that, but upstream firmware does not, and the kernel must
not rely on such behavior anyway. Failing to set this left the USB
gadget port invisible to connected hosts behind.

Link: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sys_syscon__section_b3l_fqs_wsb [1]
Fixes: 16d3a71c20cf ("phy: starfive: Add JH7110 USB 2.0 PHY driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/phy/starfive/phy-jh7110-usb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
index 633912f8a05d..cb5454fbe2c8 100644
--- a/drivers/phy/starfive/phy-jh7110-usb.c
+++ b/drivers/phy/starfive/phy-jh7110-usb.c
@@ -10,18 +10,24 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/usb/of.h>
 
 #define USB_125M_CLK_RATE		125000000
 #define USB_LS_KEEPALIVE_OFF		0x4
 #define USB_LS_KEEPALIVE_ENABLE		BIT(4)
 
+#define USB_PDRSTN_SPLIT		BIT(17)
+#define SYSCON_USB_SPLIT_OFFSET		0x18
+
 struct jh7110_usb2_phy {
 	struct phy *phy;
 	void __iomem *regs;
+	struct regmap *sys_syscon;
 	struct clk *usb_125m_clk;
 	struct clk *app_125m;
 	enum phy_mode mode;
@@ -61,6 +67,10 @@ static int usb2_phy_set_mode(struct phy *_phy,
 		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
 	}
 
+	/* Connect usb 2.0 phy mode */
+	regmap_update_bits(phy->sys_syscon, SYSCON_USB_SPLIT_OFFSET,
+			   USB_PDRSTN_SPLIT, USB_PDRSTN_SPLIT);
+
 	return 0;
 }
 
@@ -129,6 +139,12 @@ static int jh7110_usb_phy_probe(struct platform_device *pdev)
 	phy_set_drvdata(phy->phy, phy);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
+	phy->sys_syscon =
+		syscon_regmap_lookup_by_compatible("starfive,jh7110-sys-syscon");
+	if (IS_ERR(phy->sys_syscon))
+		return dev_err_probe(dev, PTR_ERR(phy->sys_syscon),
+				     "Failed to get sys-syscon\n");
+
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-- 
2.17.1


