Return-Path: <linux-kernel+bounces-239983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E2926799
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C246C1F23531
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5837187552;
	Wed,  3 Jul 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hsvr0vNH"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9B1862BA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029787; cv=none; b=CH4JUDtbRoS/Lor52rZZd2oqC3QmeApC+Z9vWRorHVaNXqLsMTeT5ZdIoanE4xcTbacJ9cXpaWYB1dCxr/HSD09p5Mw6ECJ7R+MR2cS7v/W/PigwaEaC+t+QhTorr4sL+BKnfcASf8tQP434+qXN9Lchgb8cp+i2OmHGV6zqdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029787; c=relaxed/simple;
	bh=wx7OUnPqplzfQMcHbN26g5v1Raqqc0udty5UGC5A9Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type; b=r/fFye3SeGY7Me+S5MlpQNmoQN6ml3Y6xutMU9sQK/OH7HtF+gR7JI5P23xE0b43wSmOagEgIEP2ZzCuTO4lHc0o3nmGQwBNGEvpeOvHq1+p4jH+xL9p5XK5EUMIvmiWEBc0i9oBjMIVQLZrNX/qEdAKm0edioHATd2RWgHYLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hsvr0vNH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ae093e8007so15131936d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720029784; x=1720634584; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVy+JEuti2LSOb2kxByRMvYK4+CcCWqMCFXLhrjG0jA=;
        b=hsvr0vNHfBNoMFAz4Ue08Cz2s+kqUuK69kfI/Vya1RWTIfxLiYgfMTvg2yNJYnu15E
         2mva4Ol9FLALUeMQRoFQ0qJ0Jdfa9UKAltZoi6zkUyKALiumu92lhgxyRCl1ZrSosCnb
         ZfndGjqxrDacRGfCnOD3SKgI1SLxnAtvKI+bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029784; x=1720634584;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVy+JEuti2LSOb2kxByRMvYK4+CcCWqMCFXLhrjG0jA=;
        b=Avc4utwXz2d75eOf4Z4ty1tiJmEa9kZYXgClphlgOXHEmQf8n1B3OVUosXRIrrLP1e
         V5MrzhySKFKJNlTiMyC2r/HlcCQgTC0DdvwbYgMy1dNcWXCVbJrMW5gnI8KfBRRHWLyw
         METrI6QcpJond1sn9qdj0H7C8ThozWfOST1XAkQ+8s5+ABV9dDYCi+58hp4bIfjB5rwo
         uBULbV3drTtgUNGqMlprveEetZb2wCyIsn1w5fvTu5B50Aj7G3fE5NSzgun7EHh1FmPJ
         T9GKzPZdnek23S2aPKfx8pByEdTo884I4WqyvCATxQ1tlkO39mFnW+ZQLuRcBCEbx0hW
         /l7w==
X-Forwarded-Encrypted: i=1; AJvYcCX13p+fYC6IomnA8NUfi40IOImvb62YOxeiacBS7xv52hvRsc7Stb9sI8eH2J5+N98Roi4yJdVn6m7BDTPHGut134NVDLoEVgVgAx2V
X-Gm-Message-State: AOJu0YxJYwOumkzc/pLVyBkb/fFXwPTi39iAa+9f25G9hfx100RoObD4
	b6SobKhZ4M4HZfPBviSR9gQF4w07tuxrOMx+/AxoNvqGSF/118MH8CrdBt6OOw==
X-Google-Smtp-Source: AGHT+IFDM4q/dSiohmeYRmbwqhg2/w1yGALoq+tXk+J4gFRMKAnMc5J7i/1W2ipQ4CiLed4t5I/lPw==
X-Received: by 2002:a05:6214:202b:b0:6b0:8fe5:4a98 with SMTP id 6a1803df08f44-6b5b7125599mr156917486d6.36.1720029783811;
        Wed, 03 Jul 2024 11:03:03 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm55589626d6.83.2024.07.03.11.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:02 -0700 (PDT)
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
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 00/12] PCI: brcnstb: Enable STB 7712 SOC
Date: Wed,  3 Jul 2024 14:02:44 -0400
Message-Id: <20240703180300.42959-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000513559061c5ba436"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--000000000000513559061c5ba436

V2 Changes (note: four new commits):
  o Commit "dt-bindings: PCI ..."
    -- s/Adds/Add/, fix spelling error (Bjorn)
    -- Order compatible strings alphabetically (Krzysztof)
    -- Give definitions first then rules (Krzysztof)
    -- Add reason for change in maintainer (Krzysztof)
  o Commit "Use swinit reset if available"
    -- no need for "else" clause (Philipp)
    -- fix improper use of dev_err_probe() (Philipp) 
  o Commit "Use "clk_out" error path label"
    -- Improve commit message (Bjorn)
  o Commit "PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific"
    -- Improve commit subject line (Bjorn)
  o Commit (NEW) -- Change field name from 'type' to 'model'
    -- Added as requested (Stanimir)
  o Commit (NEW) -- Check return value of all reset_control_xxx calls
    -- Added as requested (Stanimir)
  o Commit (NEW) "Get resource before we start asserting reset controllers"
    -- Added as requested (Stanimir)
  o Commit (NEW) -- "Remove two unused constants from driver"


V1:
  This submission is for the Broadcom STB 7712, sibling SOC of the RPi5 chip.
  Stanimir has already submitted a patch "Add PCIe support for bcm2712" for
  the RPi version of the SOC.  It is hoped that Stanimir will allow us to
  submit this series first and subsequently rebase his patch(es).

  The largest commit, "Refactor for chips with many regular inbound BARs"
  affects both the STB and RPi SOCs.  It allows for multiple inbound ranges
  where previously only one was effectively used.  This feature will also
  be present in future STB chips, as well as Broadcom's Cable Modem group.

Jim Quinlan (12):
  dt-bindings: PCI: Add Broadcom STB 7712 SOC, update maintainer
  PCI: brcmstb: Use "clk_out" error path label
  PCI: brcmstb: Use bridge reset if available
  PCI: brcmstb: Use swinit reset if available
  PCI: brcmstb: Get resource before we start asserting reset controllers
  PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets
    SoC-specific
  PCI: brcmstb: Remove two unused constants from driver
  PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
  PCI: brcmstb: Refactor for chips with many regular inbound BARs
  PCI: brcmstb: Check return value of all reset_control_xxx calls
  PCI: brcmstb: Enable 7712 SOCs
  PCI: brcmstb: Change field name from 'type' to 'model'

 .../bindings/pci/brcm,stb-pcie.yaml           |  44 +-
 drivers/pci/controller/pcie-brcmstb.c         | 394 +++++++++++++-----
 2 files changed, 326 insertions(+), 112 deletions(-)


base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
-- 
2.17.1


--000000000000513559061c5ba436
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCHHa4fhSXiRwvZIdPXjoEmqsLW/LBI
MOvE5vwXBcsc1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDMxODAzMDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAXvxZlh5QEO8bnQ32t7aouee3ZzRqqzGezX1G0qiVc9OD40Ju
F1EX4REBi5XAji3JwdyW5+msWbsY3KEkqCzqIplR+gPTHZt4GEscPUlwIs4HbOl+oQB4s0uDG0hw
4cJKCAh7gabHH+ewa8jRUsXCoaheznvH0sSRtQ7uamgtD9rwoGwQv+kK/kFkt4wsTCH4QhIjC22V
Yd2a6DOx3cImEzYL4vKoADJHn1zpwjc8jBpX3G5QvvOQkZ0uO7Cz4sr43RitypQPLpuy0lvq8Bde
ZHSAP6Mve6cURQs1qlQlVvmgtTLY4d9WhbTY7AQiJujf2LurfuqnxfHPM+OeOggUAQ==
--000000000000513559061c5ba436--

