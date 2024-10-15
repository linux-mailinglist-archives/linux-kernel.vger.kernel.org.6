Return-Path: <linux-kernel+bounces-366711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F21C99F8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044A0282FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C0F1FE116;
	Tue, 15 Oct 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Es04bfnH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679151FE103
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027056; cv=none; b=D0RchUG5tqd0cQwWzApsKHamwsRe75PjirmBbuG5mCwUMGj0sxigpQmixHQoUKY3GJBE4OwRvScjsTDuPqHYzKLSKGglevKpRt6RpzrrPBGl2AyFrphPsEEnyZ4nbqnXVnoEthGF1nUdyVs0XEzWZ7eg8WjyYdHGJz5SsAaaifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027056; c=relaxed/simple;
	bh=sq1soXl6abewwlFa2cbC8njUDVPYJn8dPV3vVeC5jfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MsMJj9Uz163wgxNlD2L9X4ItCU+DBXMS4zXabmY86z7LfuIXEgt6wNOf4TbS8mRmvQnBR8JzXJYcNt6qT7HHy8v1jv95oYeCQFtJuJ9sgqTRJtWM4yhSkVD5hKoXC11QfMJo7GCUBoCsL+ITYu/6KtRGyez5WbVZkOWsXClYt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Es04bfnH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cf3e36a76so23653405ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729027051; x=1729631851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45JHgiZllHV9bG+rAdE9g36380sJR4Ghem5bkWEe8y4=;
        b=Es04bfnHbqQMIpb3BGY2wj/E7r7GNf93YN5M9k4bgRM/cQtCisjTgdtiZO4M8Raka4
         YWaxTIakiN0meX6YmnAnooEX7ws36BKLEXo+FNzNgbq4qSXI9Oqlou24+DHBjtIy9gse
         wwlcFBe2uCaiVFOwYF+VQ/O2UC2NW+1gwooBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729027051; x=1729631851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45JHgiZllHV9bG+rAdE9g36380sJR4Ghem5bkWEe8y4=;
        b=OafNR45OsJAF2XrcRChvRZSB7uyZEA1sLnZzeEDKVzE9FHoo89jIwAHwfnf8GfKhsI
         +HbMEtFfaHe5O2rCBNW/4CcIU+bH+wbvDkBs3P+lk6kEMKHvDyo6LrIZ6wWrgVDMZToA
         WIZoXTfzuAI5y50+sKmrvR0k1X18BdMi2qirzxrhCHZ1tIs7iq0ikV3Ebnw4szw55lqU
         NrT1m4OUGqiCryVFRI3HREl6TRtPmmbPbE3aLiqDjdONDwsMet40eAYrqUUnYps4e5fo
         DmC58M2xFbtdtDy2xgK5N7QeRocVikPQ8lRUuXwZs+dYR6hoAhC+AVAjNYCDz00VZwc3
         QZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOJsvOtEGEG37bMOw0AFBy39Iv/nVZq1L2rZKYGIskpG2rf18RadaKH4zqNzy1AoGzENLWnCqdINScj2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnR/I3/rT9JwhMxpq/UwEC30GaZJN7Zb3kiGcflKlW/8wprM5R
	jOvBbjUXB0xBt8bzpUZpOS2hgs6lCgkbAlkxIRzDEIdBjA5HAzLVdzT+9xYm/w==
X-Google-Smtp-Source: AGHT+IEBiwMyi3fjfu1hF5JodP8eCHbFlmnTBRYbtyOyrIuYZzVq5QuUA3QT0frTpd8QsWbReK0dag==
X-Received: by 2002:a17:903:22c4:b0:20c:a055:9f07 with SMTP id d9443c01a7336-20ca145f3d6mr197854775ad.26.1729027051559;
        Tue, 15 Oct 2024 14:17:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eef3:dbf8:fbe3:ab12])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20d17f828c8sm16720525ad.37.2024.10.15.14.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 14:17:31 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Brian Norris <briannorris@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Date: Tue, 15 Oct 2024 14:12:16 -0700
Message-ID: <20241015141215.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

Per Synopsis's documentation, the msi_ctrl_int signal is
level-triggered, not edge-triggered.

The use of handle_edge_trigger() was chosen in commit 7c5925afbc58
("PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API"),
which actually dropped preexisting use of handle_level_trigger().
Looking at the patch history, this change was only made by request:

  Subject: Re: [PATCH v6 1/9] PCI: dwc: Add IRQ chained API support
  https://lore.kernel.org/all/04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com/

  "Are you sure about this "handle_level_irq"? MSIs are definitely edge
   triggered, not level."

However, while the underlying MSI protocol is edge-triggered in a sense,
the DesignWare IP is actually level-triggered.

So, let's switch back to level-triggered.

In many cases, the distinction doesn't really matter here, because this
signal is hidden behind another (chained) top-level IRQ which can be
masked on its own. But it's still wise to manipulate this interrupt line
according to its actual specification -- specifically, to mask it while
we handle it.

Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..0fb79a26d05e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -198,7 +198,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, bit + i,
 				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
+				    pp, handle_level_irq,
 				    NULL, NULL);
 
 	return 0;
-- 
2.47.0.rc1.288.g06298d1525-goog


