Return-Path: <linux-kernel+bounces-515438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A840A364CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75003ABF49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525326983F;
	Fri, 14 Feb 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LgAXDMVT"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699A269837
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554813; cv=none; b=tjNHE8tKHeL/OgM5cXrtJdi7LnBNQ90AkrgVZL2SQmwafDOb0NxD0NM8OQDzqzTGQExCFfKFo4WgO4SpH5HpMaGvYc3DYEsx2QtwfUW77+oxRblSijkduZu3WPoycPkNG0Gd8D4TbvPk2ADNiZUhh4wJ77grkaprwvWcDJubKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554813; c=relaxed/simple;
	bh=8sIVeXISLhuu8alyiP65k7wuvZYSU2e6JSJtcZ8AiwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBBnYeqRz6cOwNDfLO9Quu7t5TUbnjPHPsnwiRLTILV7jZMj0FKsAakRSdB3wUHqIFGqaAWjemZkGZ9GB1nurskNdRT3qOUsawoLCn5lR3r6873laDV65r0fMF7a+XrcXTRtKfVCUC5Pa8YfUSEP5SOSE4LAE4rgbORG2loJOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LgAXDMVT; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so730098eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554811; x=1740159611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxVjaXboKEqmhgPS1SWexvRwQQsKkPF5XcZy4FqcIn4=;
        b=LgAXDMVTpw/WAdSLmznL0ewBKHivLZRXxMua3qNK2PEe+upzgXqoaOJ1u3weeuWD3b
         neNwWdKqL3Qis0dz5Sj8jhwEhP/vFajzUfSbm6nMgfk/iZojaEiL/saEA7syaFghbk/l
         aXoWX6OMnZCQqYwN5S1K5Z8ZMXwEwXN9wOy5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554811; x=1740159611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxVjaXboKEqmhgPS1SWexvRwQQsKkPF5XcZy4FqcIn4=;
        b=R6SRdqYo2EqI+snXIfZ2yo7lJU/6mjdaKRl6key71LfPV/kfINlzIFk+wyM27XkP/2
         UF1szot8CxIR3pX34kUKhpJ9SlSq0PmVQrUl62VGA2o3hipU/fujd+szd1lKvYs1csz8
         o0fjTEUpkzYs8rnBosUY340cas4LF/7A/r8TK0dbwUOIyp1MBTcPMrUQobnoR5bQtE7D
         fgNiNkyMXAS6DF2h/PYjvrN0TJU+6n1LzHzUghs367WPwig5TpdrvADF0HpgUs4HZVmC
         blTibBMmf02raL+Vd7/D6dmG5cyqKuehIxzdIdgXmAZ1piE1cKbBqMeis2fM4efhwpm/
         +New==
X-Forwarded-Encrypted: i=1; AJvYcCWCsAZ7iTeuhYv7j2DokPfK5nd7NOzOGOSBVHWU+4QTS+H4uFn4Yx7iL90gAYMuSU6GNB8DGA9Nl/MjKjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJE8kcveG2hAbv1TteKESc55BeovGYEZ/h99DI+MRPTPPCC643
	ixA7a0tZgDMQZyA9XxQv+BLYrkb1B/LUs4pIP3Ra31LJWrr/UEnZXqHdpDOU+Q==
X-Gm-Gg: ASbGncvOfq0vf1oBWWzLRV+CzWVJ3+cBeWdgM199mzjbk6ftCZ/dCAX8pb0X2qm/S2M
	Hjwr7Iers3CJwM8UqF0V8ABrBmv0QHQoS1Z5EPbKponmOCQnFq7LGdxHgOzj/Q4ilBqr/3GCjXn
	fdSV4ZDk8QqiOhFLnjuVWbWv8GdmVj13EzCXbSRu6b94hN4wu7kM9j5sL08D/O6F9sF8Zk+5cqZ
	xviKVz2Agtru6bUKD4j37l9uxV2jzbt6Q3rLA6LSR054y0mnjwjGd9A4fIhsIPLXSCUVlv5XFmq
	h9K3arzY7uVB2+ckEdzMWnyCF+rv4wQw5H15f7oSOzjX5v+zaxbbUIgZw2iOo0P4wFK2fa0=
X-Google-Smtp-Source: AGHT+IH+XOVc8NTHW3k+78X5WYAnuU8kXspEfNlGrsjwFcY/02Yv6CZB+J3SozAcYaszP+QsOrsaFA==
X-Received: by 2002:a05:6820:1c90:b0:5fc:abe1:98a6 with SMTP id 006d021491bc7-5fcc54f758emr37937eaf.0.1739554809423;
        Fri, 14 Feb 2025 09:40:09 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:09 -0800 (PST)
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
Subject: [PATCH v2 5/8] PCI: brcmstb: Fix potential premature regulator disabling
Date: Fri, 14 Feb 2025 12:39:33 -0500
Message-ID: <20250214173944.47506-6-james.quinlan@broadcom.com>
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

Our system for enabling and disabling regulators is designed to work only
on the port driver below the root complex.  The conditions to discriminate
for this case should be the same when we are adding or removing the bus.
Without this change the regulators may be disabled prematurely when a bus
further down the tree is removed.

Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 56b49d3cae19..e1059e3365bd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1440,7 +1440,7 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
 	struct subdev_regulators *sr = pcie->sr;
 	struct device *dev = &bus->dev;
 
-	if (!sr)
+	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
 		return;
 
 	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
-- 
2.43.0


