Return-Path: <linux-kernel+bounces-239985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138D92679D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2541F23BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BBD1891B6;
	Wed,  3 Jul 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WEcjwc/L"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597618754C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029790; cv=none; b=JD81kBdI+u6FtUfml6gvmtGN7A7at6ilRK9oYoUWmhufLs/FpuVAzeypnW2Mb4wNhjGAAyTdG0rDT9jdjYwBnF2cwJiHzsVJzvNwljZVv43fjxtGRYWY4En5eolJKgEmj9LWxBxsQFbWmgGJc7xP++rxj1TltZ5z5LLZjWDgGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029790; c=relaxed/simple;
	bh=xfDMzJ5L52th+ktiKW3MMzTI0wrVxvN5v5aR7CIYbD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=uKRVDihiJ1fNV0yny901r96kByx7ieikbTLi4EZmDnxp1AocpeqYoKrARVUz/mvmlcyRb3k3KLW7dj6k0sT98/jPWXtuQxPo8zwopdlf9Ng3gGUskNSFKW/xmviodgr2V1Tt7r1kGikR1dfw8yIP9U55K3Mdrsxvr/wna2lZuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WEcjwc/L; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44633a67e52so42327821cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720029787; x=1720634587; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/nFYQdjuBpq4mAC5YUwrm8pN32q20FFEM39DB5SsOYE=;
        b=WEcjwc/Lr2x1SLsADMC7EIzCXBkHEpHgZPQwn39YpX+l89gtHxgTd2qc3vWiVRYQRh
         z2L/7fAxJGZpTUhwQ3GH7LDV8qZzAX5/Uvyo3ambqVnP7X4WoyTOP4/O+suR255rAw1F
         bwKSvD2I/VqvdoAXYko5XXnWJg2qilFgsivLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029787; x=1720634587;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nFYQdjuBpq4mAC5YUwrm8pN32q20FFEM39DB5SsOYE=;
        b=cAJPTa/s9Qq2isYy365wKI8PWbL5L8LyrxGsl8WqQy0/ZCeQ4QEcWV5jf65BtnPSO9
         wnmN75v6K7yu7LwIz4JjbEoV7sZJqQtqwSvElEm/gim3q0u9VpTdwhFC+j/60mz6poNr
         kjUFJayqgbk6Lv3W/qZ5WjM8nSmLvjzty3NNukvcS6G/lLRI2qftoUNgs0steEywh0YD
         REbTId6Tg87e80OMNrQguodBEAjxsagXlhdV6vFomnzpoXisMbX2IbbMnaXlR20Djd58
         Y9chNF5SLdBGIwOHakAxmkii6kOTztuhXNVDfemjrrEpSJL89j5JiO6rU0RbcGhTHTGO
         mQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbOsvF4XKJz/KposA/lI+eFAO+MqZh4N1Qx4LzJg3DDdrTKGox2npbUIZPZ7cPFIDZXDcxR3cHDHPHjWd22Swqy173l5Hd+3DgA3tB
X-Gm-Message-State: AOJu0YxHzbSYaHZ6xZ9RISigXD66oW8ElRhb4NpDob7f4kPfiDH9uoAz
	FL1JniR+PwOFhU0+pQnCG42BziW9hAhVQAsJfMyDAtEyfNDnY2YFjv5J55sTbA==
X-Google-Smtp-Source: AGHT+IFXuw7cmg0WWrIFF051lnnYU9WCOItnYRzRjveFDrXAg2LZ5dgJsm5yAu5w/YAdJlWx84hg3A==
X-Received: by 2002:a05:6214:20a7:b0:6b0:8e1d:f720 with SMTP id 6a1803df08f44-6b5b71ad1f2mr141051136d6.59.1720029787375;
        Wed, 03 Jul 2024 11:03:07 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm55589626d6.83.2024.07.03.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:06 -0700 (PDT)
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
Subject: [PATCH v2 02/12] PCI: brcmstb: Use "clk_out" error path label
Date: Wed,  3 Jul 2024 14:02:46 -0400
Message-Id: <20240703180300.42959-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240703180300.42959-1-james.quinlan@broadcom.com>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000082b260061c5ba484"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--00000000000082b260061c5ba484

Instead of invoking "clk_disable_unprepare(pcie->clk)" in
a number of error paths, we can just use a "clk_out" label
and goto the label after setting the return value.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c08683febdd4..c2eb29b886f7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1620,24 +1620,25 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	}
 	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
 	if (IS_ERR(pcie->rescal)) {
-		clk_disable_unprepare(pcie->clk);
-		return PTR_ERR(pcie->rescal);
+		ret = PTR_ERR(pcie->rescal);
+		goto clk_out;
 	}
 	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
 	if (IS_ERR(pcie->perst_reset)) {
-		clk_disable_unprepare(pcie->clk);
-		return PTR_ERR(pcie->perst_reset);
+		ret = PTR_ERR(pcie->perst_reset);
+		goto clk_out;
 	}
 
 	ret = reset_control_reset(pcie->rescal);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
+		goto clk_out;
+	}
 
 	ret = brcm_phy_start(pcie);
 	if (ret) {
 		reset_control_rearm(pcie->rescal);
-		clk_disable_unprepare(pcie->clk);
-		return ret;
+		goto clk_out;
 	}
 
 	ret = brcm_pcie_setup(pcie);
@@ -1676,6 +1677,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+clk_out:
+	clk_disable_unprepare(pcie->clk);
+	return ret;
 fail:
 	__brcm_pcie_remove(pcie);
 	return ret;
-- 
2.17.1


--00000000000082b260061c5ba484
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAm78I8QU0d4/zldSUmVrQTdfEtjmyj
5qWsaZRo6sG3uzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDMxODAzMDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEACNpxZqIwHgQtjgH/3RdY9iwr8ZPTrY0aO3D/bZ0Db7OV1h06
XMRvHQldo3yUB4wZwCcj3tKKCHEqCszGFI46f5ZrMrTZ3K0G2NOIJ0fc0MPR4l6DWGq22hABI/C+
rA8jyhkuOFxKC2rsBMOsVDRjO8cWJXq+xVbvD2496iuRy4En0MDJqSpBjvf5miQnIYaZVHixMx8i
Z7T5bL9i2mVwYgv74wiv+EJWzTGGmwHSoncftAHMrHqDwY6uGNRqXGxJ+gbFkd9o18luLWrwrVXQ
qzN1K2QLDttn/BnxcMRZEsP8aDhOouzo3ZtyR/j2csKI1jf+bANeh1zxiJmrzR7o5A==
--00000000000082b260061c5ba484--

