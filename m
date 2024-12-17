Return-Path: <linux-kernel+bounces-449091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD239F49AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D979188BDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8011E3DF7;
	Tue, 17 Dec 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO9vg68z"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628C23DE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434189; cv=none; b=S5etbMXG6pFx3ITmPk6ITZu0pwXU6LKPnvgnXs0Gg+ex7SPu3IhQ/s4spIKUPMUuMIDyqWfc2tQK300dDyiDvGRi859BYvmHb2mFpnpvfJvy3uLlAhDRpuFwbadtPzuWO76cHODkyXY/X7i3wRIYWHuohbelRFCmUsGeLUsALrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434189; c=relaxed/simple;
	bh=3QG33TGAvImy0IKHnNunGkxNN1+dYjEL77i+euCwbFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSgJ1tfq1xhKCLOEnQ2RgwLbgNLCkbk0b8enMiNpTUeczXr3SxX0J5PFN0vHaJFATT4bLdazW2y0scqyqKwjGgdCbqT2xA0d1NDz+X0YiUYYf0gubyYzroDoxzsH2f6HE5Afiz5QbYE/z6H1IRsE/57z+p/XSz4TDy0BzGdhf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO9vg68z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso9637214a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734434185; x=1735038985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYl6d4MRUfxUVOQcwFQKyfwAL51QVlz+/qWhrJ2KL7Y=;
        b=cO9vg68zrWw+8ZTxKYM6xSPXJ8IwdB7VKyUM6iSLoyCSlsxmJUiTyl3MUsq5JhqnVt
         yhttIf6VtCcN/H8Y+H7Z3I7W1FNkiJnicZBWcR3TENAhtwaIXqdvzuimZp/R/snd4G7K
         aGQCSPqp1keigV3eYYtq/kV9XKeTzAV7pBu9bJFgeV1Lz/tZWAJArOewuY1TwPUTcHzv
         dvtF6JXOJPK0vG8SkrcxrayQmoXLykrWyShnhye+9yuReIlNIYhs8R+PtFL9mb9KuRkI
         nxa7d6aP22lCBoKvmMxnwD1jRY9Euwx7UeZrVU45E3gB/tg4qW9CydF39wHgeEups3pv
         hnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434185; x=1735038985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYl6d4MRUfxUVOQcwFQKyfwAL51QVlz+/qWhrJ2KL7Y=;
        b=MqIjOCgaei5O72fEKGr+EBygUiun0FrVnxiSeBvLbf5rPGraADGRyihCjUBnokdv2f
         7v51JfoWnP7LonKGNrQAPvlSIGtpX/MnrcqmB9avl+JFTBnDj3g02wbJwWXCmALJgicX
         YUEy7JrJUNCBI8yNIw65ixlkqIxdJYFGfEIoWb814PbISO5FjQ9T57n272yPTa9AFN31
         eNtpX4nEUl6UR1Np7/ZU1QC3X1mbzCJbnkBJRnUZ726V41KP80E6pfk6xYIXIP2viJse
         o1byRlLryTMooBsihVKifEXvQES3iZ32QLlZt+/jRsOTwBnf6IPnzdM7shOksl9EeFSM
         aGVw==
X-Forwarded-Encrypted: i=1; AJvYcCX5b1U+2sGZL+MaKIukXZdKnC9vmeV1lZEsjOWEI5iki+AA17OxoaUrDqPUFRp4cmvG96V2p7vNnDLd8BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FAuX9p1TlPTmKXiF75wzzDy6/53dFrAeKUk7edNZ7wyc7vtb
	Avueesl3wzjrFx+sIqNaqkChpTgRrMVC8CZcKPAjdaI73nc8aPyZ
X-Gm-Gg: ASbGnctuIoPFctMX1z9YNNjnseYznwfyoAPU5AjQ3d0NQk3O0FR2n69R5yvhsHE5BfC
	oBUcaQq+UGocyhgf7ozge15KKXYReEzHiFioKq0fCbe0GBGlsIzNJp/p+W3R+YGls+5TskSPJDh
	lwZuKky9qsg0BWGzwI6TR2Xtk/MHVN1lSiaSpzeGzHILKAfhf1Ql9Bu7ZdAygR7qXmapEVxO2xX
	D3efe2JbOlN7wb5CJI/Iauxg5zE3bHklXV6Vma8Ll52xlZH5lTBVcZ9YuE=
X-Google-Smtp-Source: AGHT+IEnUOOKmqV/hBOpPlL7EMRXiX0BUILZ5Q5ZcQGOCv02YiP8sCT+WVCQIgWo1uXP2e+0+V4d1g==
X-Received: by 2002:a05:6402:5207:b0:5d0:b61a:89c9 with SMTP id 4fb4d7f45d1cf-5d7d55741eemr2727283a12.5.1734434184854;
        Tue, 17 Dec 2024 03:16:24 -0800 (PST)
Received: from eichest-laptop.. ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f25adasm4335171a12.54.2024.12.17.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:16:24 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	tglx@linutronix.de,
	shivamurthy.shastri@linutronix.de,
	anna-maria@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] irqchip/irq-mvebu-icu: Fix irq_set_type for sei and nsr
Date: Tue, 17 Dec 2024 12:15:40 +0100
Message-ID: <20241217111623.92625-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A regression was introduced in commit d929e4db22b6
("irqchip/irq-mvebu-icu: Prepare for real per device MSI") that causes
the Armada thermal driver to fail during probe with the following error:
genirq: Setting trigger mode 4 for irq 85 failed (irq_chip_set_type_parent+0x0/0x34)
armada_thermal f2400000.system-controller:thermal-sensor@70: Cannot request threaded IRQ 85
armada_thermal f2400000.system-controller:thermal-sensor@70: probe with driver armada_thermal failed with error -22

The issue occurs because irq_set_type is assigned to
irq_chip_set_type_parent, but the parent IRQ chip does not implement the
irq_set_type operation. This causes the trigger mode configuration to
fail.

This patch resolves the issue by removing the irq_set_type assignment.
With no irq_set_type, __irq_set_trigger safely skips the trigger
configuration, restoring functionality to the thermal driver.

Fixes: d929e4db22b6 ("irqchip/irq-mvebu-icu: Prepare for real per device MSI")
Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index b337f6c05f18..1d4dde719db6 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -188,7 +188,6 @@ static const struct msi_domain_template mvebu_icu_nsr_msi_template = {
 		.irq_mask		= irq_chip_mask_parent,
 		.irq_unmask		= irq_chip_unmask_parent,
 		.irq_eoi		= irq_chip_eoi_parent,
-		.irq_set_type		= irq_chip_set_type_parent,
 		.irq_write_msi_msg	= mvebu_icu_write_msi_msg,
 		.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
 	},
@@ -212,7 +211,6 @@ static const struct msi_domain_template mvebu_icu_sei_msi_template = {
 		.irq_mask		= irq_chip_mask_parent,
 		.irq_unmask		= irq_chip_unmask_parent,
 		.irq_ack		= irq_chip_ack_parent,
-		.irq_set_type		= irq_chip_set_type_parent,
 		.irq_write_msi_msg	= mvebu_icu_write_msi_msg,
 		.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
 	},
-- 
2.45.2


