Return-Path: <linux-kernel+bounces-248333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74F92DBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3151F246E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9F414B082;
	Wed, 10 Jul 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VH8hU6Ua"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E915B116
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649813; cv=none; b=aORjbOjBDMyd7sbZMOHs6s1kxdiiea+vZNfyYxdRlGF5ae+ZkTCwnc/kFEoYZDwdlQMhdxvxhT85isGs3Wsg8ODkmKeQlfTmxb9QmWFFSWcKSGSM1MXyVtjkISp01+m7XClp1hdVg09MIgeTMLydefZURLMIhfaY0EYM9OO4zNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649813; c=relaxed/simple;
	bh=ZckxK4xbrqjnKtb5Uhjx1z0lZAUyGghEx7zNkbfekVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=j2LgeAMRRCiUL2SNYpXftOkx7oYUjgSELzvmPpd+ZN3gA5Xql7qOGD6PZYiy1DLYjiSIpLyTJkMvnem1KFgyDjcL+SL4N7YBXQh5CdA5OQFRA0VJq3/ULyK0am9L6JAEvIp/Rgqw9vN3Cb5+Bp3Gs9x1saHub+d8woJXvNwUQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VH8hU6Ua; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44bd4920ef8so1513911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720649811; x=1721254611; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wermAWEZL+O9uiSVWrg0Scxj1RWVlXbOPZV39D9S/WA=;
        b=VH8hU6UaBjrAegE2fkP/ZZ7S5k/XTrAanfbNlJVPuDH8VTgTHzItWCyfNsF+QaMmM4
         M/7l6R2UWMWAUNuEudO9nMbmTOX3FXmgVBVirCIYQkiuPINvllnZTWQ8tOdwu4VHEaoP
         ARMBoF9xbLLzaEHnwdnNONTh70NivCfkocY2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649811; x=1721254611;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wermAWEZL+O9uiSVWrg0Scxj1RWVlXbOPZV39D9S/WA=;
        b=VRF3+E5bL/0n/s67OlYWccRpY+5u8s1d+vBFLvZPNHz+hevjDRenTgh3+WP/BMVQuv
         qDSTd+18M7KCvYofzLDLlSiUsj7Td9QoRtBywcdjtiRwRFLm7lV+l4axQeA8bh2fwc4G
         ykG8uCWVpoYiumbFT7wQ5oze05VXMnuVUNRRBwfqcQDntnWztNM9IbKOlMHLNYi1ld24
         9BDjqIxqYFxiqF00nVMiTxeuk6yeGdLxFFY5eUbKjlbKTphIBXRpNCBL0Iekrw4mz0oX
         x3OwWfF4KDxXOLgM9xDwg9QOFdQdACjJNzj5NNKNgJGg7esUKiOOav/7oiTsob2e+N66
         ylvg==
X-Forwarded-Encrypted: i=1; AJvYcCVT4eIa6OGeLftSrZ5vQE6aaSPy1j5zuVPJbR7UznWrTztTyWULg3/3hj5LlCNl6gYpDlKKeUiB+EMJO0SwKidOtDTEBp8h4M2yf5Wy
X-Gm-Message-State: AOJu0YwHuZ1EACK19wsaQ8JvbQ0UasARjFeN6Yuuyxh16OzHVBnOt3AR
	7bNEkIc2sJH+QoRJ9wzF9RHUDW2y6WLz1s+l9SfUsoxSa/b0tZFrY5OpLy+LuQ==
X-Google-Smtp-Source: AGHT+IGjqDlbc7rPT0RcV2yWFo57iS/g/5deckdUl2pQL1XghCw9XWDRFpz43erjIC/qo7nVqflxMg==
X-Received: by 2002:a05:6214:20c3:b0:6b5:a4f6:daa2 with SMTP id 6a1803df08f44-6b61bca389cmr74737996d6.17.1720649810876;
        Wed, 10 Jul 2024 15:16:50 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba04c16sm20182326d6.60.2024.07.10.15.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 15:16:49 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 10/12] PCI: brcmstb: Check return value of all reset_control_xxx calls
Date: Wed, 10 Jul 2024 18:16:24 -0400
Message-Id: <20240710221630.29561-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240710221630.29561-1-james.quinlan@broadcom.com>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c78210061cec00fe"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--000000000000c78210061cec00fe

In some cases the result of a reset_control_xxx() call have been ignored.
Now we check all return values of such functions and propagate the error to
the next level.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 100 ++++++++++++++++++--------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c44a92217855..c334cc427fb7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -232,8 +232,8 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	const bool has_phy;
 	unsigned int num_inbound;
-	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
 struct subdev_regulators {
@@ -278,8 +278,8 @@ struct brcm_pcie {
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	bool			has_phy;
@@ -742,13 +742,18 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 	return base + DATA_ADDR(pcie);
 }
 
-static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
+	int ret = 0;
+
 	if (pcie->bridge) {
 		if (val)
-			reset_control_assert(pcie->bridge);
+			ret = reset_control_assert(pcie->bridge);
 		else
-			reset_control_deassert(pcie->bridge);
+			ret = reset_control_deassert(pcie->bridge);
+		if (ret)
+			dev_err(pcie->dev, "failed to %s 'bridge' reset, err=%d\n",
+				val ? "assert" : "deassert", ret);
 	} else {
 		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
 		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
@@ -757,9 +762,10 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
 		tmp = (tmp & ~mask) | ((val << shift) & mask);
 		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	}
+	return ret;
 }
 
-static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_7278_MASK;
 	u32 shift = RGR1_SW_INIT_1_INIT_7278_SHIFT;
@@ -767,20 +773,29 @@ static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	tmp = (tmp & ~mask) | ((val << shift) & mask);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+
+	return 0;
 }
 
-static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
+	int ret;
+
 	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
-		return;
+		return -EINVAL;
 
 	if (val)
-		reset_control_assert(pcie->perst_reset);
+		ret = reset_control_assert(pcie->perst_reset);
 	else
-		reset_control_deassert(pcie->perst_reset);
+		ret = reset_control_deassert(pcie->perst_reset);
+
+	if (ret)
+		dev_err(pcie->dev, "failed to %s 'perst' reset, err=%d\n",
+			val ? "assert" : "deassert", ret);
+	return ret;
 }
 
-static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
@@ -788,15 +803,19 @@ static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
 	u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
 	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+
+	return 0;
 }
 
-static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+
+	return 0;
 }
 
 static inline void set_bar(struct rc_bar *b, int *count, u64 size,
@@ -1008,19 +1027,28 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
 	int num_out_wins = 0, num_rc_bars = 0;
-	int memc;
+	int memc, ret;
 
 	/* Reset the bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+	if (ret)
+		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711)
-		pcie->perst_set(pcie, 1);
+	if (pcie->type == BCM2711) {
+		ret = pcie->perst_set(pcie, 1);
+		if (ret) {
+			pcie->bridge_sw_init_set(pcie, 0);
+			return ret;
+		}
+	}
 
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	pcie->bridge_sw_init_set(pcie, 0);
+	ret = pcie->bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	tmp = readl(base + HARD_DEBUG(pcie));
 	if (is_bmips(pcie))
@@ -1239,7 +1267,9 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	pcie->perst_set(pcie, 0);
+	ret = pcie->perst_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -1431,15 +1461,17 @@ static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
-static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
+static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 {
 	void __iomem *base = pcie->base;
-	int tmp;
+	int tmp, ret;
 
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	pcie->perst_set(pcie, 1);
+	ret = pcie->perst_set(pcie, 1);
+	if (ret)
+		return ret;
 
 	/* Deassert request for L23 in case it was asserted */
 	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
@@ -1452,7 +1484,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* Shutdown PCIe bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+
+	return ret;
 }
 
 static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
@@ -1470,9 +1504,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	int ret;
+	int ret, rret;
+
+	ret = brcm_pcie_turn_off(pcie);
+	if (ret)
+		return ret;
 
-	brcm_pcie_turn_off(pcie);
 	/*
 	 * If brcm_phy_stop() returns an error, just dev_err(). If we
 	 * return the error it will cause the suspend to fail and this is a
@@ -1501,7 +1538,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 						     pcie->sr->supplies);
 			if (ret) {
 				dev_err(dev, "Could not turn off regulators\n");
-				reset_control_reset(pcie->rescal);
+				rret = reset_control_reset(pcie->rescal);
+				if (rret)
+					dev_err(dev, "failed to reset 'rascal' controller ret=%d\n",
+						rret);
 				return ret;
 			}
 		}
@@ -1516,7 +1556,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	void __iomem *base;
 	u32 tmp;
-	int ret;
+	int ret, rret;
 
 	base = pcie->base;
 	ret = clk_prepare_enable(pcie->clk);
@@ -1578,7 +1618,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	if (pcie->sr)
 		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_reset:
-	reset_control_rearm(pcie->rescal);
+	rret = reset_control_rearm(pcie->rescal);
+	if (rret)
+		dev_err(pcie->dev, "failed to rearm 'rescal' reset, err=%d\n", rret);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
-- 
2.17.1


--000000000000c78210061cec00fe
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDbCtkGQyUOiAMYV8bkpZNWLh73/MwC
9LJ4wSVeoKg7rzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTAyMjE2NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAnwIWY3ce14HREAWc4smgn+nbQbFAF6ZecvkAZ93r0Do6vc2N
Lkenqr+Q16i6YkVzZHp95Ir2tPgazWT+dUjLjk7X8kxW4d0zacTjzdwpTPf2W+48S+4vZN6Z82fO
/CY2xnTSir250MvU2XRdvXN0xMyKOmUysDRuG5F+KS17m/c4fPZeUmwOTOekoH7MoFcutt8utBxP
vE+c3qSCsEarQX+7eyJ2qkCvtmAWac3TryKZAnYj71K3hwNbjwUJ9HEMGX2ElpbzzA3EteRc5gVk
hSMgWUTZNLPV1Y3uyrQIhJAo4fGp5T3CZK9kF0Chger6ww2WHwXYuRzEH77pFjNGUA==
--000000000000c78210061cec00fe--

