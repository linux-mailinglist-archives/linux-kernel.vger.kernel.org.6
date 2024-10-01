Return-Path: <linux-kernel+bounces-345510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1C98B71A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B48C281642
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953E19B3EE;
	Tue,  1 Oct 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="V3N4fUM+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CC19ABD5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771780; cv=none; b=SNhZyGsErjiJJhSnXH5Pjm7XxGHnPJpfZdUHlxMolYGix/RzRTEfkgRpkSxADCT/am1B4IDAd3x2wIWnDOxxNiNNIWEv6GWFwfIDH7U39pd3AK93VucKwKNJrRdnHd+vuaomaPLkt2hYl8pIz8MZXK2CHFlotsiVebarnO9nNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771780; c=relaxed/simple;
	bh=X762HUvHe79Sfszvlpr6AaCEObfNJ8XwLibj0VikeaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngoXY9thG3gO7B8I4D7j+DS9nfqkz5S1inYzNWGpdDmaoumSppNm+GieEn1k+V3hW9GZ4Uo+EB0Q2Y6g2/7rMmKhGOt7fEfzIcVuIaCu/jaGk5M4PJgs6I5iQ4tuePrBR/vnkza5EU7YO9A3zST3guD12WcLa2KvUsGZdyZHXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=V3N4fUM+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b20ffd809so3867343b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727771779; x=1728376579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9imT704LRAGL7Jvi8rBCp96QNuC359qUawNx+2cRI5g=;
        b=V3N4fUM+jzchbc3zlZM9EluBS4pOABr07F1u+GBSOZkqin3P8yVF1GDZMNusbKOdEi
         Hgvr7oSDYd1Ujw1c/kSin6tWYdTa8SJEZzlIhsmUT4NH8shCD8S1ndojm87oSuEmE5Bb
         TV3OKupMa6+XibwSOmJzqQYRRYkCP2fHFmMhNmElO1f9u4vuO8bXPfrybgytdlM1IES9
         6N9yJqja1LCdmkbPv1UdPEtUTRx5llBaBz9hm4A7rE366FKRSvZxz/s/nCg1PCp7v5Wj
         gn9zhqpQQbyXbBUiWyTwbhTR0bc0d4cM9AJE3s5q9NZiEHk3xp3F0kfE0XMsOZEZjWQg
         ux6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771779; x=1728376579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9imT704LRAGL7Jvi8rBCp96QNuC359qUawNx+2cRI5g=;
        b=Y7y9y+in2zrNBuqqeHGA3hU86mEW6xj74Q08qxC97H+RZFkRI6w208j1DKsTwlnhhm
         b+mAZxu2acKdGlvaRZR+T+tpkBKp2TTQlDO8GjbUH4EApyOa8Zxs/TqRo335IHSNajSq
         b4mW5EzBSdCfh4muSHbtNrYkAHpGnqoirKEfvy4JnUNWde7xW2SlnNDe2l4ygZvb9vTt
         LfJU7M5EoIPeQ2nwBnRrVEdgkNjQkctzicnN/eIa4sQazcidTb0SD0rJyhJ0fB87AvMq
         ZTeOXJD9VB8xNajYX4qFpdIibMNC2Bkia5sB4kJVZBhl4eOs9vF6K9+bZpBOg/E6MmBZ
         vFmA==
X-Forwarded-Encrypted: i=1; AJvYcCVbekJwSJz66ezizqg6mregQtm6DqDrfLao41jfgeWh8CPYyeeWEk8e+ushodbrv5h5cUuyk6KzKcxntII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OaonoJT3mxyUb3OTsIu4OwDEjdyQgo2+jOjbz2wO+SWwqp4f
	0WjhIC6uLWnN9BlhmMYQtVQqgvo4npqZQ4cT3BMq4CtUwtpKXAlqKFezhPFkQiQ=
X-Google-Smtp-Source: AGHT+IGTYZspzAErDSrmscoQdRmq6XKHRbgb09e/7smZlcCyPbeS3xskua8DxYNdwUkvMDs21Dj2bw==
X-Received: by 2002:a05:6a00:39a2:b0:717:8d5d:94d6 with SMTP id d2e1a72fcca58-71b25f4416cmr23558820b3a.12.1727771778836;
        Tue, 01 Oct 2024 01:36:18 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b26516148sm7521573b3a.110.2024.10.01.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:36:18 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Tue,  1 Oct 2024 16:34:40 +0800
Message-ID: <20241001083438.10070-6-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001083438.10070-2-jhp@endlessos.org>
References: <20241001083438.10070-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

v6~12:
- The same

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..bd0a8a05647e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1442,6 +1442,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1458,6 +1461,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.46.2


