Return-Path: <linux-kernel+bounces-239992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BB9267AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182901C240A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D919412E;
	Wed,  3 Jul 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1PWlRj0"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708D191F74
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029800; cv=none; b=jfjiIokbTFTtKzKe8vGAgzC3MiL37Fm9Jpko3bSWVWaiOwE109zk2Rzm/Gt2kVZyTtkaJJhUa/QOkeLFaWQ1E6mUSHQEvUlH3UFGEiqekbblnL1rdF/eI6/kbb3nDGmvIziOq/GfaF+bzki/Wp22rWLNTPr2yD86JYl8K0RULSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029800; c=relaxed/simple;
	bh=5OPdPV1qzBnU8Ur1oTKEihIkHcljk7yE2Ii9HEL1gX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=DuUNj+wz48nluVrOgYoYpgxhL1qGgWZ2jB5u2S5Bu23KHc3snWFBrDQDk6GEMLItExct0B/ynu95KFj7xYG2MkKsRLqWaUHdf0T1xfGAD9mYsFHA2gkQ2VFQfSUiB5Qo3BSioDHpENMeL1cNWbuDhkH0IF4PPUcYsbNEj8t26nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S1PWlRj0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b590e36a8dso25648886d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720029798; x=1720634598; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UXdooYSPiUSHDR6j4xF+U98lgx3baJVNMemOW3ldOjo=;
        b=S1PWlRj0L/d5R0vUKy5L6kMChbpfq0g8i6Yri7l+wmzuvL7G5sNCwror37l/lccSkZ
         xqDE3L0IcvGL1eaIOr0MpE8HuFlSmFmd8BZVnNVsMpzcZqWRLFX3oIJfmtgyAFqbRk1f
         ZhXp+lWsvPZxMjCD75i0iI+mN3u5ak1B6XAKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029798; x=1720634598;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXdooYSPiUSHDR6j4xF+U98lgx3baJVNMemOW3ldOjo=;
        b=MrqDO0TjH0a4picq7GaaF4OdYRpCqocXEGJC6OmuFlx/mKUTaUOocy0CwdkCBQjPZF
         PWRt3BScnbu3caPx0HJZ0dLX1tehek886hejnHdMkUDMKW72PSCWuA8V52xsiTVeRpz4
         +eXeHWOSJwRRfLaFeLzVOyOkN0VvQ+pF2GP7gShDGJpqN4sI0XxzXqPWh45PZmGYyJha
         X/2R1ifUMRktGVgDdXQPEMZUcNNyrg6UDeSyk+kF39HIqF/1tVGsr+VqvFUTcR2SiKhK
         3pTcp44sOkI3uW+xJDkndAdLIifuxOO0wr8pnWSZsPddjf0DlQQxy5pme5N4AqjiLeWT
         LxXA==
X-Forwarded-Encrypted: i=1; AJvYcCVMIdzyBMkxzq71MgpKAqaG2tdj0w8zlvgJPCgmmVf/HCWlyqZCMiWmzZUWT+CpGGbV5gn6DV4qnE2fGY6Dl+XuSMUdeS7bjgxcDpna
X-Gm-Message-State: AOJu0YyDFekBZKGqalsv1x+SllHFEykJwLNf9iiGjcQpqTGxWngh0XYC
	iQ+Ps4jTVkAKCd12pUqMK07uzjUEQyQ34b72c0zgBCqvi/DxYE2+scoQQX6FOA==
X-Google-Smtp-Source: AGHT+IEjxUaTGLmO7EJMAa/TgB1qW7iqWFCD0RMo8l2bw7YFxx+GoQgQJT1u8o/uNPyZPEbzb8Mvww==
X-Received: by 2002:ad4:5ae2:0:b0:6b5:db70:b980 with SMTP id 6a1803df08f44-6b5db70bf68mr58937496d6.4.1720029798171;
        Wed, 03 Jul 2024 11:03:18 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm55589626d6.83.2024.07.03.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:17 -0700 (PDT)
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
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/12] PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
Date: Wed,  3 Jul 2024 14:02:52 -0400
Message-Id: <20240703180300.42959-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240703180300.42959-1-james.quinlan@broadcom.com>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000244156061c5ba5f9"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--000000000000244156061c5ba5f9

We've been assuming that if an SOC has a "rescal" reset controller that we
should automatically invoke brcm_phy_cntl(...).  This will not be true in
future SOCs, so we create a bool "has_phy" and adjust the cfg_data
appropriately (we need to give 7216 its own cfg_data structure instead of
sharing one).

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3aa82871e9b3..ffb3e8d8fb2a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -222,6 +222,7 @@ enum pcie_type {
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
+	const bool has_phy;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
@@ -272,6 +273,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
+	bool			has_phy;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1311,12 +1313,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
+	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1559,12 +1561,20 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7216_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.has_phy	= true,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
-	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
 	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
@@ -1612,6 +1622,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->type = data->type;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
+	pcie->has_phy = data->has_phy;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1


--000000000000244156061c5ba5f9
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBHWfGRk80xgGrnXlcbIaSaCS6hiKZ7
UONa4k98XLSkVTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDMxODAzMThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAQ5SqaW/6wvGENGC9z1TaAbOiBBd3nfnCTwOQ9iOqzXpErk9T
XE9LF72iZe0N76qOmVTq1lhzrWHZlteh0yTp009F/897NI+hAa7BaZDVGKJeG/nv3ISZpxU45755
XS6PWHYoJnheIqfac6fbGzlhU5v8f4ZHfERyHmI5UFDZR5MyoMYl51hpvaE2mCjvo1qq1j3Xekhb
OXm0w2DjZoI4On8eVuolwqYpW0CpTLDqK94yFykhQWg4199DetDOIYJxrT9vyJVACu1AbIun3pVH
aj7FUMQRnMY1AjZV/C0fkfvFbOMta990Waio7kOZ/Px6EEFKACHOmR4sNuX3tvgZ9A==
--000000000000244156061c5ba5f9--

