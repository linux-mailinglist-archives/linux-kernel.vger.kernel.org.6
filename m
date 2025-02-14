Return-Path: <linux-kernel+bounces-515441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D9A364DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A239171842
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2372686B3;
	Fri, 14 Feb 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WNz0kbvw"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8C269AE8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554820; cv=none; b=HBGHZp7AbqboLlULpCzuV9ZK+1syeOmo1kRSVnaKyCT3HtOUBR1Cp5Kyz+e+zIVqloAdwwWun5dkbG6O1Wu82IBHqQ1eEB6+CAbM/gudbYOMLEEnT3zgVeMu3vD8M89ArNR20bCMSiNmNF4/7cEwLRWyUFCIxJmgceRcP/4xQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554820; c=relaxed/simple;
	bh=fGgqLUYQ3l+rbJFzjKjU0U0rU073XUhDX3WKSwxzq9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfuVhNZr6qSchquLpidK0YbwsVmwoGF9D1/E3ypQ1zhw9fVHqpOlVbPdODEgd7YIummBLnIVVHpBu5fNTImwqgEvoNdSAvgqZ5nE2oJz3uzr1sXv4MEkhaciTVjrjdLk6ECfN3ZfknjfcMKygJ0Lgh4sZwa+ADj3nv8GH0psZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WNz0kbvw; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fcc45803easo47437eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554817; x=1740159617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSW4cfeQPfDzJdrXVnX+xGV7pqYpNxrZbvVlU0rLzgU=;
        b=WNz0kbvwBnyrv74gM3mFoS7i0v1Nqp8BWww4jLMV1PHqf+eqzo6tSn1Yb2S4MsCLbo
         xJzfKDhD9Rc5il7WDrrdEaP3sUyn0PjEBjSVQCKmDIrm0DX/67XHllFYyebMtdTjRQcu
         N+ujAQJHQByLxsLI5bUsBOrY9UNr5aFmtDF0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554817; x=1740159617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSW4cfeQPfDzJdrXVnX+xGV7pqYpNxrZbvVlU0rLzgU=;
        b=NqVkblARQC36SxJEZm6GIDar6HWXwhIS/CLnuV8T2t8Qc+oFULXlhAUNMBhAj9TQoP
         Wb4SuTqFZFO3adqiYlAGFEjNZoy4rTzlhPORoS718vVyuNbEjCazs13kQDkeU6LZ4hbw
         6t6yEVET76Na+IM80xjAkJe40w/Uu+yRTYlTEGhAdG+/3bJWMI/BaqAdKKm6XzktIB4B
         z7L+Siil3y308SuzJ+KQN9AfyaxO5oSbnJdUw7dCCJjRVNIGA1H25OFPu9V1IecAigb3
         TcGPocnJixsV8VoIkNaAyfl0CQYq+kubHXMXSsU2VFzoqQIUxZeGXYeI09jiGYbCuwEb
         ed3A==
X-Forwarded-Encrypted: i=1; AJvYcCVPrHOM3uMHk8erD3hizsjUFnb3h2/JtMR6FUCh69whA/zdhGLW6omQIy/XJM0qwRvkpDkG5AukB5jwZS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXU3zUxrXhISlV/IedA2C0HxBxGvR+XuLmugDFDDNT/4HGn+iw
	lSQ5sqmI07VL8V3QMGiWq3bjZo8L3JP2g2IuIF83VJDOjOwcaRWmxAyCJeo01Q==
X-Gm-Gg: ASbGncs+/2/aVnZaa5Re+zsYcscZNPxiItBCDiRrwpN7EgrEC5renq1T6DmoNRfkY3z
	fwgqvSyrRgt5y1ioqO+5d+Zaj8riycLfEHuBKm00S/bqvOJbSCWD6pFOJx4zfK5XPN/dpF55rwv
	pNH2qLVeiUXBAgeCPoi+0SHrTkumrmkXly9IDa+FcGF7NQTKAbeJ7hUtba6i4+GlVyPTKeFuhOx
	4wEs8wrJIFlxf4kn+XNOFlUKRV2XuIgIFaC+hH58oYOq8JLQR54tkOav7dTFHzmeXZaYRyaNZi2
	3cZ/C2A9zUvlEAcCxcXoqx/pOhcai+/tfdLAAkEfIGU4Poq8mMDc3cD/NatupWgWuH2/Ux4=
X-Google-Smtp-Source: AGHT+IGzGxY4gVdlR82gAdB7cjaGdcaL5kCbohfl9gRTT5OL6p6gaqIDXsIm/04V9i6hRIlQvRjbtQ==
X-Received: by 2002:a05:6820:1c8f:b0:5fc:98ab:2b27 with SMTP id 006d021491bc7-5fcaf54776dmr4801224eaf.6.1739554817648;
        Fri, 14 Feb 2025 09:40:17 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:16 -0800 (PST)
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/8] PCI: brcmstb: Make two changes in MDIO register fields
Date: Fri, 14 Feb 2025 12:39:35 -0500
Message-ID: <20250214173944.47506-8-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW team has decided to "tighten" some field definitions in the MDIO
packet format.  Fortunately these two changes may be made in a backwards
compatible manner.

The CMD field used to be 12 bits and now is one.  This change is backwards
compatible because the field's starting bit position is unchanged and the
only commands we've used have values 0 and 1.

The PORT field's width has been changed from four to five bits.  When
written, the new bit is not contiguous with the other four.  Fortunately,
this change is backwards compatible because we have never used anything
other than 0 for the port field's value.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 923ac1a03f85..cb897d4b2579 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -175,8 +175,9 @@
 #define MDIO_PORT0			0x0
 #define MDIO_DATA_MASK			0x7fffffff
 #define MDIO_PORT_MASK			0xf0000
+#define MDIO_PORT_EXT_MASK		0x200000
 #define MDIO_REGAD_MASK			0xffff
-#define MDIO_CMD_MASK			0xfff00000
+#define MDIO_CMD_MASK			0x00100000
 #define MDIO_CMD_READ			0x1
 #define MDIO_CMD_WRITE			0x0
 #define MDIO_DATA_DONE_MASK		0x80000000
@@ -327,6 +328,7 @@ static u32 brcm_pcie_mdio_form_pkt(int port, int regad, int cmd)
 {
 	u32 pkt = 0;
 
+	pkt |= FIELD_PREP(MDIO_PORT_EXT_MASK, port >> 4);
 	pkt |= FIELD_PREP(MDIO_PORT_MASK, port);
 	pkt |= FIELD_PREP(MDIO_REGAD_MASK, regad);
 	pkt |= FIELD_PREP(MDIO_CMD_MASK, cmd);
-- 
2.43.0


