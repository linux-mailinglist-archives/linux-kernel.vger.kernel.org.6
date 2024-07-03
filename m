Return-Path: <linux-kernel+bounces-239994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F414D9267B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CB51C24213
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5144A194A6F;
	Wed,  3 Jul 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eIwYLN6j"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0C194A48
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029805; cv=none; b=VHXpUDkTclJ4mCHCerFs1yCPHU1NLA2iE8SytURD0yWhHTkIj6GFHGKkeb1F2zaLY7lwJWJlJyvBcJmoowgdvP4ugSVrqLWnswigkYI1sMWyQOyau5xTBhAuFIX0HdgwBv6BpxGhZ2J76+XH4zdVK+JORUH6ghTktGu2564QDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029805; c=relaxed/simple;
	bh=+PyYSKRGCAXLcWwQadoXMzI5MMdGC9eOh+AdrZ6O3a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=NyQUVGoaAWUeFXEVHBjqwdj/o8fhNavJHCIWwWOzV+SOE6iR4dVf9qmzGdvwyJr6lOTXvkerIS2ef1QZ4igD7CziJi8wx/Oqh8/kJOdAMO50OXqRS5bM+l7TngxU4kjz8xlHrVMpJgfIkSZGLxYwbHx0XWWw39cKz6w9hV5nVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eIwYLN6j; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ae093e8007so15133476d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720029802; x=1720634602; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oj8l9W4+lp3TtPZCSCSymXcv+KfuiblN1diMKM8ET3M=;
        b=eIwYLN6jnp3ul14Pvj2wDvUajfoIoyrpf++29HlFeWEhhIZrK9laK1yXAkw7jxZW3x
         xPEnhLfhQIExD1D/P2KostMW/ACMgz32m1A6ikXhOCE9ndJQn4T9S5PV9nL3q+nJYhOM
         rII/uwGMb+v30D9v/QXHYKzTEv4V1bFhELD68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029802; x=1720634602;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj8l9W4+lp3TtPZCSCSymXcv+KfuiblN1diMKM8ET3M=;
        b=KvjADW09Y5JJzCAirpYLQ0pNGUu1OM94qixOyQgfZVkiPlmVyK0TlFEw8bswuRWKMx
         B4knNPC3DLEjBya+sAz7ZFiTY+N88jjweR24w0GuoazOCKI8dkCtkgCI7hm2lRjl/GId
         VJxznoOnKdVC78XpQqGfkJXwn6S30WMn3d4092H1OmQcdX/bIgGBjuhr39pGyQeFCGPi
         L5r1/hXYEUs/R0Hwheu3KvmznPgENXSsdMjwirezrsVKMpE7v/wRqvHeQs5KROABNZGG
         X2B2e4t8TEYLnHgLrOJh5jyocUGwEiAjHaHjiLNSTHuY+pxT84UKBGwMnmvUls13WXWC
         e71Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrXdaMXvvU1DnQ5AhoBDc/RbxJ8OTOu6hV+1PEpt7rTIShZ2Si6kvUBt2UIPCALnnGgk7qyMPTl3O4g75MYa+w3duDzQaPim1ZQe7K
X-Gm-Message-State: AOJu0YwNGz6KOLDQlwXVaOOHlp1zyIz+vjtFcMEsAWW99LRJrQmXyUkw
	QuFUynL2s9q/LK4qALeaaoUQNkzpKGAH1fC2dGrpJyP/10/dkHHY/H5SRsXt+w==
X-Google-Smtp-Source: AGHT+IGbJe5pkc2j7LdAc3NBpb3Lu+goP25Rbr3UThoc2CRUdNdd0GaOxU/sxrlkRDfdbHcsPnDlTw==
X-Received: by 2002:a05:6214:4601:b0:6b5:9a89:35d9 with SMTP id 6a1803df08f44-6b5b71f4d19mr160016156d6.64.1720029801406;
        Wed, 03 Jul 2024 11:03:21 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm55589626d6.83.2024.07.03.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:20 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
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
Subject: [PATCH v2 10/12] PCI: brcmstb: Check return value of all reset_control_xxx calls
Date: Wed,  3 Jul 2024 14:02:54 -0400
Message-Id: <20240703180300.42959-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240703180300.42959-1-james.quinlan@broadcom.com>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000680fdf061c5ba5e7"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--000000000000680fdf061c5ba5e7

In some cases the result of a reset_control_xxx() call have been ignored.
Now we check all return values of such functions and at the least issue a
dev_err(...) message if the return value is not zero.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 33 ++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 5f632fdc0052..1c3ce0c182d1 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -743,11 +743,16 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 
 static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
+	int ret;
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
@@ -770,13 +775,20 @@ static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 
 static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
+	int ret;
+
 	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
 		return;
 
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
+
 }
 
 static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
@@ -1460,7 +1472,7 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	int ret;
+	int ret, rret;
 
 	brcm_pcie_turn_off(pcie);
 	/*
@@ -1491,7 +1503,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
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
@@ -1506,7 +1521,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	void __iomem *base;
 	u32 tmp;
-	int ret;
+	int ret, rret;
 
 	base = pcie->base;
 	ret = clk_prepare_enable(pcie->clk);
@@ -1568,7 +1583,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
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


--000000000000680fdf061c5ba5e7
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCWNmdA057M4aj4vIgocm/SQTvnVDp9
7BPLUwyxEWXB7DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDMxODAzMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEApTzcTiE+1zq/BrjQ+JQfmSUeMKeL/7OwzCkDEAu3UC83avYJ
wJ63xeWhLg6du404I8EWXLXJzj1s8MEIAqfjllHQWcFzbYxGdNFTu2t0/gunM3Vu+1/A+HlkezV3
YFlwCY6YbQMQmaMoTUKCdGy3fA3HKdWjuQ7IuI0SkbKad68cmpmBTTvFVlFS+vgMLvsAmK5WbRDj
baKctkd+zjDou8nhGb6rJ9J3Xv1Q5bieUoUyPSbDhze1bS309od3+DbAywQJ2LSUfkcQyg2wTVp3
8XCVJwAcXtVTuT6x67F2sqsJnYtDyI5tPDsO7V6tvI99fspWHT+nWjPTNhhdzxo3Mg==
--000000000000680fdf061c5ba5e7--

