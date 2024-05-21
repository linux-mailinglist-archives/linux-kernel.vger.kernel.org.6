Return-Path: <linux-kernel+bounces-184654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131D8CAA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B376DB20D84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C058AC1;
	Tue, 21 May 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cgwxp9Fu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3254BDB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280513; cv=none; b=HxJEFeGF+iAgmrauY3O7dUETxcXn69gcplDAt9dmCR1CgO9OLRwM28ORMXobJdudP8YQJEC99CG9ror46saPoXPgq72At3wuVgG4ZTzdx5pNR10AeEOrC2wdQdGDgmyrlIG8O3cZt0HbWZU2n1X7s8qJN5NX762CgLnQEX+EfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280513; c=relaxed/simple;
	bh=kNZI+tfNPBQt9dkkmteDOfG96JtFEZcf2Sv6/JIELrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfPodqD7Z20AHHZs8qVBDOiSmvnm7m4/t78thniDYJERVcX9G21O4kp6RS/H6K2HwtJzJi4JLLJN76Dz7BnCdQO0d2a+zFKaaBySKEqB8DAUPUHeHBMBOOA/49a8LvtyEkPl/W+88FQZaN4LZVrioLb/RjJCwi6YX/3JLqL8eg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cgwxp9Fu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599c55055dso789754266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716280510; x=1716885310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeUzaJgucCPR+zY9E+AvBWEfJ2LsXQToej63r5VWGuY=;
        b=Cgwxp9Fue7rRSDVSezsi0r80JzLqSafgcM3l0o4GwUPhE8aJ3o4tad6KyyEW0d6x7L
         1Sbxl6r53uMkhO3NTKHkfHGt4OP/ewFHWPkBky57fNedKmDAfdGGkb72zSwQI3yTXu0G
         t9TGQSqWuhFyf+Pjm1uv9X6QwK7iUSFGNyae7pW4oM0upm0GTsl4oYU+WhIGfRCrJSKP
         adnVFle45ktAqtwXy+P31wdRQM18uZqC7ra0AFntZUBTA9D62JQGqUG6AjgH9bTLaSnC
         103Q0COs+iosXWPLkAuQav5TBjRdIg0Chl9Zsft2U40qoQLLDcTVWMNJoRQifmpHIfhU
         4tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280510; x=1716885310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeUzaJgucCPR+zY9E+AvBWEfJ2LsXQToej63r5VWGuY=;
        b=EBQATbwRrZjNVx+RqMqsgadoHBFHQ9BxxZ3zGC3WEwLjvvCDXYPbxYyC2Rxn8eID6s
         Lx7mPV0zybojCoV+7iTwq1/VBMRxMBTIe4W6kkIBa+UfTwYVpmG7cuzjFnKG/8OF25JQ
         r/nH50MjJYmXTR/um9nmoWAwszWEKU4qaR31Mm18sz4asJbmKaUyuk8lEGD7dpRY6aJh
         jpQiBM7anC0SFXnrCBedZdeQi6WfRqrLWbVmUDoN7684z3xrTh8ZPDshdlDPPGQyoaVQ
         EcT5qqtHsK9kYz/+ZXNYWD6ovGF7cz8moz8LlvI68ijbT7Z/j5nXpNR4ImaktAMw+0Oq
         zq0w==
X-Forwarded-Encrypted: i=1; AJvYcCW8NxKFSSWYDVGKRnj/AYq9gfcUuKKR2RWW7FvU0SfIhBG/1Ht26dgrMJ/xme8byqYI158EsGKssjSYrtbEhpy0wYWNIeRywU3FlMS0
X-Gm-Message-State: AOJu0Yw38EhXxnsaA8pErR0inCZrg8svLG/NzelPFe/ab4D8cGszd2oN
	6HVGkcqMn+2C+fTZJfzEMHkREYFqTXUmUWNPTBhLCRbiDrg/07ohJhvqFmBDCcM=
X-Google-Smtp-Source: AGHT+IFGVFbO+Vvt/HLW1ts2sBvZryzev6bkeYdTBdUsoUpVu04fdJMUBuNaBT0ihT7+qGIBU1QAIA==
X-Received: by 2002:a17:906:6415:b0:a59:adf8:a6d5 with SMTP id a640c23a62f3a-a5a2d6786fbmr2042739566b.72.1716280509907;
        Tue, 21 May 2024 01:35:09 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f49sm1572664766b.101.2024.05.21.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v3 2/4] dt-bindings: mmc: Add support for BCM2712 SD host controller
Date: Tue, 21 May 2024 10:35:14 +0200
Message-ID: <d7c8bc0143c6b8c8b313413860840ae5bf2dc22a.1716277695.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716277695.git.andrea.porta@suse.com>
References: <cover.1716277695.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 has an SDHCI capable host interface similar to the one found
in other STB chipsets. Add the relevant compatible string.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index cbd3d6c6c77f..d584a7ea707a 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -13,6 +13,10 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - brcm,bcm2712-sdhci
+          - const: brcm,sdhci-brcmstb
       - items:
           - enum:
               - brcm,bcm7216-sdhci
-- 
2.35.3


