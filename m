Return-Path: <linux-kernel+bounces-343611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B8989D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62931F226BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A689313DB92;
	Mon, 30 Sep 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="CkElc7kW"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79E13D531
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686184; cv=none; b=qG8u9wqnRMttxDvYJ1coAZsr83SOAnGAnRzZ1ebru6hJ/y27cTh/KkzPONXswvxHc73AbMvIuILMLdIZ1cWePa0Y5gA7jRIBSRznNz+QJi5G8JMRFybqUt/9avRJzuJdd0Oyaka5omAlE1sp0VliI57ctAMHUSqMWrE8FzAB6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686184; c=relaxed/simple;
	bh=Vkf2QKjMMZln6LtloMLRj2/7a6w/QjR0Otd+AjYmdDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzkuOxzR5SbAT9/YQar4kjK0sj/UgeL0c/hp3pkeUxgzF2qV9UFDsHbarGv60KwBWXKbeFOaC2SrjJFJCcDOT8Unu7PNZpWbeXsxCxhzR+FoNvP1blwzNkfs2AimU8TvrYf2cvf12+lkGXef6zFSVDGqFzqLrSwPKci2HajWnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=CkElc7kW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e08085596eso3770974a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727686182; x=1728290982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZbysNIlOHPItNDMBaY/TpsEKwnYED1veTTB3Zccc8s=;
        b=CkElc7kW4Td92XFN/xUp0sYb+DjQi8FXfx3YoPCkESErArE/j3elG06j6Ho0gjQhDR
         JFYT2x9kXw+maGazoT5Xjfaone3czYz0W9luJ+S9c54oT1Vp/kPskfaQLO1SiNVoYPoE
         IIOliENL4m+a/iW1fqsue2b5JZVV9IuCzV3KlaAieVVUbJyPVV5TJvjv0svsasZfVHON
         28mTPeV7yjC8OtRCvQuJKs2WEjjvJovi9SSf+PwMoRpZRcTYiD/BojBbumOUtCWY1q/m
         8D2shBqN4Oa0R24oZyG+TEV7ZVHhlbd236gNuSyaY5lCfCE8Dy7ZCgidjlfEgFu2UaeH
         nRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686182; x=1728290982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZbysNIlOHPItNDMBaY/TpsEKwnYED1veTTB3Zccc8s=;
        b=CjlrJ9lTaz+laf41n98zAs7NPXVYU1FvRtXDy2h9t1kyZ+eTb5gnkbQXDXQNFEtQCd
         K21eynnqj10bSVxjh8ouROPG57MtgLa57Mh8xvxBYtfhTR4vy02LhdhDxlevYJqGRUDO
         rsr5lkNM8UffOGmftY0RxEamSYgxN5UpUnjZu/scKGLJqtTqFXrwshTXGG0/vrj2qGHR
         +lC0xaGNeXVgMtKPYEFR8WJaek6jmFkIWO0H+aTKVF983T05Mssuufm1quSH/6KyyuJo
         vjqjXJYriuf/OIvqjY11MwydmLO/CF7Gnv+tkJ1xqmMfdrUUN6mw1npsuem5bqBgjmB6
         0TIA==
X-Forwarded-Encrypted: i=1; AJvYcCUPBR7cYGxm7685CatQVnI9sOuKruXeuKWCrsg3o8kI63efHDux/NJBnPysdLIYXyhPkGHcADDLy6yt9+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWw0m+hbRCDT8K0cnV2RjOU2HqK4Y4FQU2Awxy4GrOGveqVmF
	nlvKHbvToa95vBqVtNe7ULG862j6LkmQyl/JC4N3g7f3YtYmUgYz+4g8Tnu2bxQ=
X-Google-Smtp-Source: AGHT+IHx4d72DodoB9zIC20IK7A8MZyAyZENySG3BGOZxvTHXfZzdZm2Jta5YQ3dDBcH7KW9JekMBQ==
X-Received: by 2002:a17:90a:c691:b0:2d8:f0e2:96bc with SMTP id 98e67ed59e1d1-2e0b887aea6mr14158969a91.4.1727686181572;
        Mon, 30 Sep 2024 01:49:41 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e2b1f3sm7260565a91.57.2024.09.30.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:49:41 -0700 (PDT)
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
Subject: [PATCH v11 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Mon, 30 Sep 2024 16:48:41 +0800
Message-ID: <20240930084840.13424-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930082530.12839-2-jhp@endlessos.org>
References: <20240930082530.12839-2-jhp@endlessos.org>
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

v6~11:
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


