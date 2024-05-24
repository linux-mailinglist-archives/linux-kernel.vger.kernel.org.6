Return-Path: <linux-kernel+bounces-188770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73458CE6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96B41C221D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F812C7F8;
	Fri, 24 May 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="F0YZxaoJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16A12C49F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559706; cv=none; b=XVDiZevzjneGdjc/K52uyKt6t7R8vwfeW7cnJHSDd/+8evyzozcWec9SCjRD2rtaK4vDbupWu/xh2mQwj9K2LzBJ8YCizQw+8h/AzB4DX4BZGjX+4Zh6rvj9QvDEEHfAlT26JMEZ71yb9F2NoYlbFmNvzFFdIbbV45nuCQICZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559706; c=relaxed/simple;
	bh=7OBEvpz5Q88pQOrflUx2/3L22kl2uVXTa0s3B2NDpl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av7wM9qJXXCBLlPjib+toaIPMksdo6oPerxdDPQupE5EMTAvb3jHaHp8/pCyS+c4nF3iUVTnbCJ/6JHV3o2reea6Na87SwOReZ5h7ApvhDpKWen5gmWl+hoRkwhqkRSbS+xY9eb5MmfEWBhUtaUf17vDcoXPHvQFjxCygbVUyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=fail smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=F0YZxaoJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295bcb9bc1so766152e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1716559702; x=1717164502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDE4KdJDPFFGuDWV9tGz0a/UMLuzw78uuyBOxXbpDBs=;
        b=F0YZxaoJsZ/EPQFLVJjnKnbTx6I3sb/3UO9KMmceH3Y3dUHMMeBygqH75fPiDGAdOa
         h2BnGTf07fpRRf3ECRzqG/awLsAa4newpoL3P2mPcp3lseed0NV7eNCT9dGrnlEgf6EK
         1ZwKev0m9UXz4GKA2mcNsYdk2iPArjIHu0R7vqg27D0CBVgYdiG9LqLDinO6DSvddSTH
         xI5M8oC8ldVUqyxFvKQGgcylceI1kkiLykuuIGwVu4DAKsCKEE7Z7aT1C//FhG1x4KI5
         M0P8oFGl4/me3d00cgaMBID/BVPD1vVarCmQA1M8v3D0sPM8YitnxxZKAqv+Gy+29JUo
         ipFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559702; x=1717164502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDE4KdJDPFFGuDWV9tGz0a/UMLuzw78uuyBOxXbpDBs=;
        b=YgZc7in/Lzg9+QsMpsHAnUZDmgJhZ1HK8FKo0GUCyZvCfjV1ZrRF0Sma5L0gr5vmmJ
         evpGkREgqb8pf+0H1V1H2/7lPgGWaf5b01qLq+Pt/WE0gwofe2/mBPGOzR+0ECaqKn08
         BXXqUc/QszzWnAVLIs/VLF5n9NAwbGlXp0hF2eAgGMMwoMAdstLWaEU6hVE1jJdW6Tpa
         3ldJUyVkt9BTOXEWWqELaVzkr7N7DcRXkgZI07bECRz804ieR8/zsjQ88itC8yuTllrA
         0BAcIcosED1ah4jC18EchcR7VkQEFN2y6/B8D1zQh6AjjljZjnUhiMvx9odRb6MAMqFL
         MYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI2smPiXmjlNav3xvgeohwrAbnNeaZkfLCV3L0XGcm07Bv6SYsG4tzp82TWSmcELsQ4A2osA/oLLkl8m+Ue6FRQ/VF0yVkMu5dAL4T
X-Gm-Message-State: AOJu0YwJWCBTaMwYiJYPpbckXyY/pHWbpfSlx+sLAqJ1X3KHs5DNDmSl
	NSagVX/ST1ZnOZBPmoK3OA83xti2c5MQ4y4tWn9DuLmVbgiBh1FR0avof/bioomR86kKwyUKC6e
	/
X-Google-Smtp-Source: AGHT+IFu0aQYxgeXNPBjdFM51FaOoGQBrL3c/qdkD6x0M4ZdNKvD87xpWSgptuyjhQxgl7T4rSMP1A==
X-Received: by 2002:a05:6512:3b8d:b0:520:85cf:db7f with SMTP id 2adb3069b0e04-52965479b50mr1991284e87.28.1716559702401;
        Fri, 24 May 2024 07:08:22 -0700 (PDT)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5296ee4a9cfsm185474e87.75.2024.05.24.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:08:22 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: parthiban.veerasooran@microchip.com,
	=?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 1/1] net: phy: microchip_t1s: enable lan865x revb1
Date: Fri, 24 May 2024 16:07:06 +0200
Message-ID: <20240524140706.359537-2-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The microchip_t1s module is extended with support for lan865x rev.b1,
prior to this commit support for rev.b0 already exists.

Some of the operations performed in the hw probe and init of the phy
require access to registers only accessible via the macphy spi
interface (lan865x is an integrated phy), meaning the init call has
to interop with layers above, namely via read/write_c45.

Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
---
 drivers/net/phy/microchip_t1s.c | 189 ++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..3c5153aa5c7a 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -5,6 +5,7 @@
  * Support: Microchip Phys:
  *  lan8670/1/2 Rev.B1
  *  lan8650/1 Rev.B0 Internal PHYs
+ *  lan8650/1 Rev.B1 Internal PHYs
  */
 
 #include <linux/kernel.h>
@@ -12,7 +13,7 @@
 #include <linux/phy.h>
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
-#define PHY_ID_LAN865X_REVB0 0x0007C1B3
+#define PHY_ID_LAN865X 0x0007C1B3
 
 #define LAN867X_REG_STS2 0x0019
 
@@ -22,6 +23,7 @@
 #define LAN865X_REG_CFGPARAM_DATA 0x00D9
 #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
 #define LAN865X_REG_STS2 0x0019
+#define LAN865X_REG_DEVID 0x94
 
 #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
 
@@ -84,6 +86,65 @@ static const u16 lan865x_revb0_fixup_cfg_regs[5] = {
 	0x0084, 0x008A, 0x00AD, 0x00AE, 0x00AF
 };
 
+enum lan865x_revision {
+	REV_B0 = 0x1,
+	REV_B1 = 0x2,
+};
+
+struct lan865x_revb1_fixup_op {
+	u16 mms;
+	u16 addr;
+	u16 value;
+};
+
+static const struct lan865x_revb1_fixup_op
+lan865x_revb1_fixup_cfg[20] = {
+	{.mms = 4, .addr = 0x00d0, .value = 0x3f31},
+	{.mms = 4, .addr = 0x00e0, .value = 0xc000},
+	{.mms = 4, .addr = 0x0084, .value = 0x0000},
+	{.mms = 4, .addr = 0x008a, .value = 0x0000},
+	{.mms = 4, .addr = 0x00e9, .value = 0x9e50},
+	{.mms = 4, .addr = 0x00f5, .value = 0x1cf8},
+	{.mms = 4, .addr = 0x00f4, .value = 0xc020},
+	{.mms = 4, .addr = 0x00f8, .value = 0x9b00},
+	{.mms = 4, .addr = 0x00f9, .value = 0x4e53},
+	{.mms = 4, .addr = 0x0081, .value = 0x0080},
+	{.mms = 4, .addr = 0x0091, .value = 0x9660},
+	{.mms = 1, .addr = 0x0077, .value = 0x0028},
+	{.mms = 4, .addr = 0x0043, .value = 0x00ff},
+	{.mms = 4, .addr = 0x0044, .value = 0xffff},
+	{.mms = 4, .addr = 0x0045, .value = 0x0000},
+	{.mms = 4, .addr = 0x0053, .value = 0x00ff},
+	{.mms = 4, .addr = 0x0054, .value = 0xffff},
+	{.mms = 4, .addr = 0x0055, .value = 0x0000},
+	{.mms = 4, .addr = 0x0040, .value = 0x0002},
+	{.mms = 4, .addr = 0x0050, .value = 0x0002}
+};
+
+/* this func is copy pasted from Parthibans ongoing work with oa_tc6
+ * see https://lore.kernel.org/netdev/20240418125648.372526-7-Parthiban.Veerasooran@microchip.com/
+ */
+static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
+				u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return bus->read_c45(bus, addr, devnum, regnum);
+}
+
+/* this func is copy pasted from Parthibans ongoing work with oa_tc6
+ * see https://lore.kernel.org/netdev/20240418125648.372526-7-Parthiban.Veerasooran@microchip.com/
+ */
+static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
+				 u16 regnum, u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return bus->write_c45(bus, addr, devnum, regnum, val);
+}
+
 /* Pulled from AN1760 describing 'indirect read'
  *
  * write_register(0x4, 0x00D8, addr)
@@ -112,7 +173,7 @@ static int lan865x_revb0_indirect_read(struct phy_device *phydev, u16 addr)
 /* This is pulled straight from AN1760 from 'calculation of offset 1' &
  * 'calculation of offset 2'
  */
-static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2])
+static int lan865x_revb0_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2])
 {
 	const u16 fixup_regs[2] = {0x0004, 0x0008};
 	int ret;
@@ -130,7 +191,41 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2]
 	return 0;
 }
 
-static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_revb1_gen_cfgparams(struct phy_device *phydev, u16 params[2])
+{
+	const u16 fixup_regs[2] = {0x0004, 0x0008};
+	int ret;
+
+	// this loop attempts to de-weirdify the method described in AN1760
+	for (int i = 0; i < ARRAY_SIZE(fixup_regs); i++) {
+		// only the lower 8 bits of the results here are used
+		ret = lan865x_revb0_indirect_read(phydev, fixup_regs[i]);
+		if (ret < 0)
+			return ret;
+		// The AN states that the readback value is in the range [-5, 15]
+		// and that it uses 5 bits, bit wonky of a description, it really only
+		// makes sense if the read is sign extended.
+		// Since the regs are part of the reserved range there is no way
+		// of telling how this really works though.
+		if (ret & BIT(4))
+			// The AN specifies 'ret - 0x20' which is again pretty weird
+			// the addition here gives the same result on a s8 (with overflow)
+			// the assignment here are downcasting to s8 for sign extension
+			params[i] = (s8)(ret + 0xE0);
+		else
+			params[i] = (s8)ret;
+	}
+
+	// And now for the really weird part, there's no explanation to what any of this
+	// means, just that we need these results written to magic regs.
+	// Since these ops shift a lot, the previous sign extension is probably meaningless.
+	params[0] = (((params[0] + 9) & 0x3F) << 10) | ((params[0] + 14) & 0x3f) << 4 | 0x3;
+	params[1] = ((params[1] + 40) & 0x3F) << 10;
+
+	return 0;
+}
+
+static int lan865x_revb0_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 {
 	int ret;
 
@@ -145,7 +240,7 @@ static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 	return 0;
 }
 
-static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_revb0_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 {
 	int ret;
 
@@ -160,18 +255,29 @@ static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 	return 0;
 }
 
-static int lan865x_setup_cfgparam(struct phy_device *phydev)
+static int lan865x_revb0_setup_cfgparam(struct phy_device *phydev)
 {
 	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
 	u16 cfg_results[5];
 	s8 offsets[2];
 	int ret;
 
-	ret = lan865x_generate_cfg_offsets(phydev, offsets);
+	/* Reference to AN1760
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8650-1-Configuration-60001760.pdf
+	 */
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_registers); i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan865x_revb0_fixup_registers[i],
+				    lan865x_revb0_fixup_values[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = lan865x_revb0_generate_cfg_offsets(phydev, offsets);
 	if (ret)
 		return ret;
 
-	ret = lan865x_read_cfg_params(phydev, cfg_params);
+	ret = lan865x_revb0_read_cfg_params(phydev, cfg_params);
 	if (ret)
 		return ret;
 
@@ -190,27 +296,64 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev)
 			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
 			  (22 + offsets[0]);
 
-	return lan865x_write_cfg_params(phydev, cfg_results);
+	return lan865x_revb0_write_cfg_params(phydev, cfg_results);
 }
 
-static int lan865x_revb0_config_init(struct phy_device *phydev)
+static int lan865x_revb1_setup_cfgparam(struct phy_device *phydev)
 {
+	const struct lan865x_revb1_fixup_op *op;
+	u16 generated_params[2];
+	u16 fixup_val;
 	int ret;
 
-	/* Reference to AN1760
-	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8650-1-Configuration-60001760.pdf
-	 */
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_registers); i++) {
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
-				    lan865x_revb0_fixup_registers[i],
-				    lan865x_revb0_fixup_values[i]);
+	ret = lan865x_revb1_gen_cfgparams(phydev, generated_params);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb1_fixup_cfg); i++) {
+		op = &lan865x_revb1_fixup_cfg[i];
+		fixup_val = op->value;
+		if (i == 2)
+			fixup_val = generated_params[0];
+		else if (i == 3)
+			fixup_val = generated_params[1];
+		/* All of the regs locatd in mms 4 could use phy_write_mmd as these are
+		 * accessible via MDIO_MMD_VEND2, but mms 1 not 'indirect accessible'.
+		 * Less conditionals are favored here by doing the set in just one way.
+		 */
+		ret = lan865x_phy_write_mmd(phydev, op->mms | BIT(31), op->addr, fixup_val);
 		if (ret)
 			return ret;
 	}
-	/* Function to calculate and write the configuration parameters in the
-	 * 0x0084, 0x008A, 0x00AD, 0x00AE and 0x00AF registers (from AN1760)
+	return 0;
+}
+
+static int lan865x_config_init(struct phy_device *phydev)
+{
+	u32 rev_mask = GENMASK(1, 0);
+	enum lan865x_revision rev;
+	u32 mms10 = 10;
+	u32 devid;
+
+	/* The standard reg OA_PHYID (mms 0, addr 0x1) does not contain any
+	 * information that distinguishes hardware revisions.
+	 * HW rev can be read from the vendor specific DEVID reg mms 10, addr 0x94
 	 */
-	return lan865x_setup_cfgparam(phydev);
+	devid = lan865x_phy_read_mmd(phydev, mms10 | BIT(31), LAN865X_REG_DEVID);
+
+	if (devid < 0)
+		return devid;
+
+	rev = devid & rev_mask;
+	switch (rev) {
+	case REV_B0:
+		return lan865x_revb0_setup_cfgparam(phydev);
+	case REV_B1:
+		return lan865x_revb1_setup_cfgparam(phydev);
+	}
+
+	dev_err(&phydev->mdio.dev, "unsupported chip rev: 0x%x", rev);
+	return -ENODEV;
 }
 
 static int lan867x_revb1_config_init(struct phy_device *phydev)
@@ -280,10 +423,10 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
-		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0),
-		.name               = "LAN865X Rev.B0 Internal Phy",
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X),
+		.name               = "LAN865X Rev.B0/1 Internal Phy",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
-		.config_init        = lan865x_revb0_config_init,
+		.config_init        = lan865x_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
@@ -295,7 +438,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
-	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X) },
 	{ }
 };
 
-- 
2.43.0


