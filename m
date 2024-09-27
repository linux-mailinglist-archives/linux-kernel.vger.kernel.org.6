Return-Path: <linux-kernel+bounces-341625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47189882A0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBDF1F22DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384D18661B;
	Fri, 27 Sep 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="fVK/pveb"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8C185956
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433438; cv=none; b=MGfVn2x3JKbZyULjhEScIx/LeVNQZvjwC2giw7KAjest8cC7PesQsmuBXXYt/MxIHNlFJ8VpAsigT9hTsEvwUu993KDssDw0yi7xCxdP0XJCkDlrF/do0fePOlk+tkxMd68eIVu4wF1Omq/iAkKf4s+CKjcego/xQqtIAVgBBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433438; c=relaxed/simple;
	bh=Tt9jZ/UlU54e+UzJCTQL9NrMvJYonLk5qDAVRDf4jek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pfl01WRQ1TMH5RrKv0wU1dgvuCYshs2eW4Ea6JWdgmKG27SYJMcF5iBj6bPNrzmb68aatebgFFtlHaCu0XIQhnFDc6UsgPTaPAdNFVhmc4YFlg6r3q01Egops0/PjN5SSMel1uG2BvT7WSZBNcYpqRHNN0KDoSY1UkFeWS1v4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=fVK/pveb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e285544fso1564924b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433436; x=1728038236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGxVblQfa7uHrpy+5tBOyLSFvRT+VEn8gcPfSrU2Ja0=;
        b=fVK/pvebJxJXu/4HmJUhcL8gy2axYlsWTtjbKJkeXHkFL9BrtZrHekt+2PD4bKIwu+
         AMf7E0FNd7FZcBdUs9xR8tsUwqSSLo9u6wJQkE6tRC1iZHzUoPEWEXmYPBuZM3u37tjE
         3aNj9tERw5xYOGZQRrglqwNzmnJt8381+Q+FAVFAG8cTxfbLRH+1Ealg/+niw1MzNu0b
         jfJITKYJ0MU/30igzNFEi7VGLKLSZfScTmnJaGcmDjgxjb4ykfaXRB6WaFLU723UKzL1
         iAO+bBEKA/bAKfUYm9DQL6LSoF1gDl8Y/4gWFmEB7QVSTzj6VNWDFAeI/tfu6rntVgm7
         GlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433436; x=1728038236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGxVblQfa7uHrpy+5tBOyLSFvRT+VEn8gcPfSrU2Ja0=;
        b=kCHa5XSPH2ZfkKjDZYl5xtO6aD1HcS9C7NjhJ1ndc0jNBhbZlcZJ0sYzhxslbUvWtK
         JOsvEYYdVTfqhHylwZURMqB+vI8jJOaaEVHX34LT7cYowte4wdhT4B8G45YOsREU06u6
         cmqXwux8MmzqftUphsaTRcQNS5VPINdMsLL3GsL1GigP86vdYUy1rfed0H4qwx+SYitC
         cT+Sfmu9YQeRbw8Tqyy792S7dFfyXeFxi3p7gshuwHF+8Ljwju4GJTgdERQToY5L47dd
         cQxoPOc7SbatL+2I19H58PUqW5yMsc9OjSEkKPO4KZNEPU7R37J5Jz3eBkrojS9QzMo3
         oT5A==
X-Forwarded-Encrypted: i=1; AJvYcCVOuzvZcDUmUfZuBSVREAwXcAsVSjJRz44P+h3zDh5bILYVuD4cFeVSfIPLZTpNVmLU19zdl1AxO7IZ2oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjFEimCHmZLETbOGlqN3rsEaGkR3LKYmdEeLfyv0TTyIo2tiL
	OzQQPPIYMrjh+ESEnHC3tKD4gQf7D8+xgUvzKHduced9/ygbPNI9xnz87fplyoA=
X-Google-Smtp-Source: AGHT+IEdr2fEbI1BtpZEI2LBNs60DKodvJNbkxxgSsKjdyxmA9kEzrG50k1Zw1QH67cjtJ9+jtBG3A==
X-Received: by 2002:a05:6a21:1796:b0:1cf:3c60:b8dc with SMTP id adf61e73a8af0-1d4fa7ae2f4mr4012116637.34.1727433436352;
        Fri, 27 Sep 2024 03:37:16 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm1342036a12.22.2024.09.27.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:37:16 -0700 (PDT)
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
Subject: [PATCH v10 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Fri, 27 Sep 2024 18:37:00 +0800
Message-ID: <20240927103659.24600-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927103231.24244-2-jhp@endlessos.org>
References: <20240927103231.24244-2-jhp@endlessos.org>
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

v6~10:
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


