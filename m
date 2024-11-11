Return-Path: <linux-kernel+bounces-403874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE6B9C3C20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C5C1F221D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86111171E7C;
	Mon, 11 Nov 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT/Knw0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F62B9A9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321420; cv=none; b=RFdjtfYqmKp2Hhen2UFHMz2fX2qKN8DcLB/6G8ERW8hCWd3a47WbwfkxvQZyJjpH7Yu8zOC9Uxluaxzex5/0Whw9iPPi/3QM86rw5DUcDA9W0ywziY2/g7PVDAzJ6tHPxFWMLuUStQP+v6T5nQbyJtvCLkY1clBd/hwkPDn69IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321420; c=relaxed/simple;
	bh=bXU6qDTSZfdnUSD+4IE5/jWD0VuzlQrzjYHOoEMWsy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itOqF7lu/WDswaaSSRo9qG5hWCKNav72utM+pB1xHzNpiHdORcge64f8Ib8QF3oHm0VUXomuW8EoGwI9EmLU8QO7hV3FRFdeD4Lm5N21Z58o3F6AHnMkbmgWs0GLOfjMYN7BWDkEMwD4Fb0ozolrOZskxR1FcXmV/NzSMl00dkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT/Knw0q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731321417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7mKvZHVqjxIR5wxBFLvC1h4vE0943EV7c7fgh6Pdqfg=;
	b=bT/Knw0qMYtHifVj/ECTkxqqEaapec7KCm+K9u61YyS3vOcdFtoUyZ247FMfCUXZhz+Bxx
	wy9YKoDdHuW14G8zIZfZnTG10x2E1pLLdUA6nzzpY5qIaWN1AXuPqYQOpGdRS826MVQyTu
	DmKgoqlhNUwEwSnltIpesR4KHHumVx8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-eUMn4L1jPgWVy5et_QjfdQ-1; Mon, 11 Nov 2024 05:36:56 -0500
X-MC-Unique: eUMn4L1jPgWVy5et_QjfdQ-1
X-Mimecast-MFC-AGG-ID: eUMn4L1jPgWVy5et_QjfdQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315d98a873so29585225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321415; x=1731926215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mKvZHVqjxIR5wxBFLvC1h4vE0943EV7c7fgh6Pdqfg=;
        b=lfRiNY0ParqEqW5+OO1XBEaOKvDR07XAFEYMDV6oaahI9WtGfl+BNX5oblBEunjP/f
         r/91tOQlAVHh5Gbb3wro5oHVkGhkVBaTQBYa4hcGL66T0ZETA5+EckrH/PsBLGFHkpLH
         DL/DamXY7t9IH0Z3gcUL73kDsvHhcMbTzfvU04W5XZX0JHLB7veEKkqFLwkulcMwyEQ/
         PVqQmPDEpqvtKQZTBNe3JUavOb63KJ/vW4WKaRJTFXoaRNoMfJ2gW/wvPar5oKrckJ34
         W/D7c6CSeuwn+KRaemr6kQaqgQG7dQhNyU1s9eoB6QiNVbX+VUtZYYZs2YhJyvCmIgKC
         Lspw==
X-Forwarded-Encrypted: i=1; AJvYcCVN/NdQ/JEzIZg4Jkm3HXZUds0o4OYXdJ5V0C1O2Ru5IKJUhRhF5I9MiGJlOSqGwU/B8+AK/jUTMP0OGiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwAv4EmN1atCCRNz/6jJ6Yas7N4WQRQO4F7TfyrKycpjGnQ25
	8alFGYSWMtZhAsIt9FIA5UG9E0Q1eZnfBB14V1HQYjYJpDUWY+WJ0ZTe1F9BsxUJca//bevRzpu
	AYa+tUAecHSCrI6x5fJ/vvtVJJf36ycVT+UKbvJwLSKH4IQ1j5Ahg+gftpeFboftnc1Uehw==
X-Received: by 2002:a05:600c:1c14:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-432b74fc9c5mr107169775e9.3.1731321413272;
        Mon, 11 Nov 2024 02:36:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENwrhfUBy1/5CRb94lG9HyA0lrxWL80J6LxeKnMdJ0WNHabZPawLpABaX1uhN+Wpl3BRk2Yg==
X-Received: by 2002:a05:600c:1c14:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-432b74fc9c5mr107169555e9.3.1731321412896;
        Mon, 11 Nov 2024 02:36:52 -0800 (PST)
Received: from eisenberg.fritz.box (200116b82d9ab900a46c5a062bbe27a3.dip.versatel-1u1.de. [2001:16b8:2d9a:b900:a46c:5a06:2bbe:27a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c11f8sm204440725e9.25.2024.11.11.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:36:52 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] x86/platform/intel-mid: Replace deprecated PCI functions
Date: Mon, 11 Nov 2024 11:36:03 +0100
Message-ID: <20241111103602.16615-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
respectively.

Replace these functions with pcim_iomap_region().

Additionally, pass the actual driver name to pcim_iomap_region()
instead of the previous pci_name(), since the 'name' parameter should
always reflect which driver owns a region.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
  - (Re-)add dev_err() print message. (Andy)
  - Add Andy's RB.
---
 arch/x86/platform/intel-mid/pwr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
index 27288d8d3f71..cd7e0c71adde 100644
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -358,18 +358,18 @@ static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
-	if (ret) {
-		dev_err(&pdev->dev, "I/O memory remapping failed\n");
-		return ret;
-	}
-
 	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
 	if (!pwr)
 		return -ENOMEM;
 
+	pwr->regs = pcim_iomap_region(pdev, 0, "intel_mid_pwr");
+	ret = PTR_ERR_OR_ZERO(pwr->regs);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not request / ioremap I/O-Mem: %d\n", ret);
+		return ret;
+	}
+
 	pwr->dev = dev;
-	pwr->regs = pcim_iomap_table(pdev)[0];
 	pwr->irq = pdev->irq;
 
 	mutex_init(&pwr->lock);
-- 
2.47.0


