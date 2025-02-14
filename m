Return-Path: <linux-kernel+bounces-515437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7CA364CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827563AD538
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580EF269806;
	Fri, 14 Feb 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WHFxHSuS"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF552690F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554808; cv=none; b=qKIqK2VsH4/a61eO1cQq40EEqdAVph/mE5crrWh9qRNSv6+ILWG6IhsuXvNL64ru1Ql37fTNQTBaKU7XVO7wVq6Q9mzSCBMdBZrW7jEgxuyw6idj3WINlEgl56yqWr/KMyFCBQ4NvtxRzJtKkDt40G0PgkTJXN1hWDjmbnD/IQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554808; c=relaxed/simple;
	bh=hpYFno3xFpTtIFF8NpBFjFKOov5U886g51Xm0GPpMkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwSaR31K1+e+RUQH9H2LggOA7X9eea6xR6AU9SIUZJFd3GLTbIsPumCbmBPfVj8PqTrCGS1Y84+6LuAI3KYiEMOhdmVpHROxbtx/kWeo1CuG2j3xUleuzWysPyYoKMIywW8g+EZFIE1uP3xWOXfthfqvK2jFzyBvt6e/KwLM2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WHFxHSuS; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcbb00261cso562232eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554806; x=1740159606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW9nWifCzwYZy8eQdCTo6EqgINRvFFYuVj87cGvTYVY=;
        b=WHFxHSuSMEUZc0NEZk60+QjWikrCDjNZrflG9iuLSfcSNseE8X6ZfGUbUrJwXW1ebC
         cL+jqmO1KKePcZifWYNYcGIWNMBa2MQIMSQNLWeF2oo6pGeIz1gXMsR6s3pKAP9BXK6M
         TO7zRNAvSX8E0msGMnLDFg5L8di4xPTEZUqgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554806; x=1740159606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW9nWifCzwYZy8eQdCTo6EqgINRvFFYuVj87cGvTYVY=;
        b=CKgAulj0Kw6R6JfsV9JMmwHRIznFASJx2XBHUIzobw4g+V6cU5XkVDG64qjbGsW1cq
         tVM0Y7a+uI5CVcFCH135xVtyyUmGs1HY1RkNwCTEDjBZL3Ca+b0Vh9OlXeYcD46w4KN/
         QoZRuE4/cIwTf7HYWIB69+Djv6tipoLWogO150lThPiVY2M3sMvUS9XFG+u72U7LMhkM
         kIvptPAGPjFfxhuGqke/OgyXIgXh9BHbvHU6dPsKyDsGuiW8wjK9RkMlWQD6kam0DtRw
         /njUs+IdoTjvPFKAIu6BLgHw6BypPJiXLnDQDB4HemK7a9eCRvYhMvJIJ2ldAkqoMIUc
         d1rg==
X-Forwarded-Encrypted: i=1; AJvYcCW6kGgl0/UQwjN+ApOVq6NTcYJXgzwb6hjIL0J3ggj3tFTFfI/qB9aHd78kdNLfeVIH1h5alyPNu+F09UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6Xk7fXNy7jd4V39Wt5X2lRtoVJ6VR+EAjnHDZ3jGzwkGxUX8
	5xxwJS3XyHdj7/giBOfX8dF/RuQBAWYe8KSK4haB6hWhE+wa6Go/JPhFIM5EDA==
X-Gm-Gg: ASbGncv3NqvqpomJSsulkkfzVpKIlWxNgm0GJn5qVR8s0nVpiewvQ+Raf1plF5KOeoT
	3JugQ1gG7utvK++XE6z8MWYhooZQkV8Ew9e+MkmripT0sKsfJvJ3qNG7zhSnrRJzAy4vDObFMp3
	O//4B+islEcoAHDi8tlG3qS+zYLfvLQVFme+gQv44fjoNGOasLSpgJzfUfgx0WQt0Hd/LUMCTC7
	pcA+0mvcSAabJIQNvoKxwvUOvSj6wE8r+UkRhZOQSbVz/XrlAxZqyXyJCp5RUQvluiqekdpGnDc
	yZR7ozxlvXxyjKeGYcOmylW6SLq5BPNVcij5AQjDmJyGh83mf0UgGjtrpVQAJ8zivYiLvmA=
X-Google-Smtp-Source: AGHT+IHsRBlmYmWP6ec6QvQPHeSSiuic4NDtKAA7m7DLRipohduC9tXO6eBUjYvMvWROPLOlA/zw6g==
X-Received: by 2002:a05:6820:c85:b0:5fc:b1d9:9b68 with SMTP id 006d021491bc7-5fcb1d99d08mr4047840eaf.5.1739554806336;
        Fri, 14 Feb 2025 09:40:06 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:04 -0800 (PST)
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
Subject: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
Date: Fri, 14 Feb 2025 12:39:32 -0500
Message-ID: <20250214173944.47506-5-james.quinlan@broadcom.com>
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

If regulator_bulk_get() returns an error, no regulators are created and we
need to set their number to zero.  If we do not do this and the PCIe
link-up fails, regulator_bulk_free() will be invoked and effect a panic.

Also print out the error value, as we cannot return an error upwards as
Linux will WARN on an error from add_bus().

Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e0b20f58c604..56b49d3cae19 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
 
 		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
 		if (ret) {
-			dev_info(dev, "No regulators for downstream device\n");
+			dev_info(dev, "Did not get regulators; err=%d\n", ret);
+			pcie->sr = NULL;
 			goto no_regulators;
 		}
 
-- 
2.43.0


