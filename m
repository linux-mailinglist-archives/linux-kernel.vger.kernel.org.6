Return-Path: <linux-kernel+bounces-532029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D855A447E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BE8883E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE5207E13;
	Tue, 25 Feb 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3mbytdo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B320B80F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503574; cv=none; b=DhVcu7AhIVsUDakDdpDHJBn6avyYVgCIoQGXBrwgT8OCSo4nzkjYrAXfqnoqeLr/t033ChcBwOj48p6MfobIjNaYpzURqXkUQgrbZtGcj3zTiRr9HmAr2L7/BoaMOZyBpOzAEGP6AyZLgBXflP8bniSijZib2ZaV5c3oY8HIG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503574; c=relaxed/simple;
	bh=FnUacC9VqqRTi29gXJo7HKIQwygyqPBosmqqmN5z+pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjNJlC/lzHk31TFD/jy3Z0wLQBcv23Ka1cthq0FexUWG/HGuwwud0Iqn8Npbt8p1t7N7Eubkj3OS7Vgs47DN4eosqnYjHlcTKxlFE4FOhc8qIFqFIKMSl+S4EWKssZBFEq4vSA5VCcMZIOnIeBufhI40pEhDYFdokrbSP3oQUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3mbytdo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220f4dd756eso125291585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503572; x=1741108372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5lxY7B542/PLdEoJyDDrjtx4yD4vXFk48rEXnqEjwQ=;
        b=g3mbytdoVZEX7ZA7zKRirvzIYoazIPF7Ip+vVmtGRxCRnTiPnJKPfKMnV4qaQUJQPV
         igsbUbOq1xu7s4+tHbCV/rH+hc4M8oDeofNvzJEEeAJcHJwclG6kCXG9vNnK3sHU4hpu
         lXCktHOOimAkRtZOR6OlZgxu1Oh30uf2s1R+Z61XcMDy1Y18VN0bTjeZbceiuwpPcHJ6
         v6jniiZ8HjYT+6/dIMcfK/bmYEwzjajxtvyTA2jCmfXJKcTCv3v9YCrWhaGwK5WvDIFr
         8n1q1IngxQ7Q01OKGnpp6B5UNe0M9/rXLQ6NZKBA/idXKYgJwlQFXSmysAnjWx4C7FCN
         8t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503572; x=1741108372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5lxY7B542/PLdEoJyDDrjtx4yD4vXFk48rEXnqEjwQ=;
        b=OREuE3+9bbF0St9nJ4Cpguo4QHZZk18S50apLEYaA+nLidDB2jA+j7VPnF84CYCzpY
         YeHWwkTY5GhB4g0JmbXxTqbsia+opKnkfvH7o/p4biLohdstmo/zfVArLHsfVI07sPeB
         jk/mVzSrIbreE4422WGpicrY2syMLlzorh9NoCdd9yHNMzq5ant2p1RHTAQOn0n4+wxO
         8EejgIBf70mOnTa2xzmQykf4eYrD/o2PGwOBoPHKf+0FoW9SCaqMxmx/5izv25Jpa7Hx
         IGKGiv6lGKeGTo9T2e1zTro4f5T1EH3fwL7IsTDBC8x1MFoBTAi3IvZlnMaMGxrd/Lhl
         b2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVZvOGfkoT5Z/k5SgPtJjcxwh+vU4f4wTMYFTpLNaG1jnCAHNt4IGnO84rr8uFpWDSYZxa8C5nSkxVlEAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFB17u7zh38MqfAgvyKpP0RD6GfGjNHK8xw3l6fDBWJZCbZ1Cp
	PvvFeWw2j/uKGiGFZSlhnxsogiqE3NLfWQkuu3Mrqhh4OTUeyX8zTWI5KxLhYw==
X-Gm-Gg: ASbGncsDh6CL+bZwmuFNJ3vg7A2mItT/NTeBsiVEHMYQdfqJ6FGiOPPQzxbxexfgavF
	RHLjqr1zFmdFtoBbhJkjqdrmv52jQb48ABAR6TWRE9wgHbT59HzmgfqPFKNTEp7SsE6VXACOnxA
	qmQxsnz0975s27DF/UpOHt/TtC/DXjGos/mGcjRGeDELHqmEQtVM6P8Mf11PLO1iSSh5pm7J+Ld
	uLafPZ+PAGWZwJjT4ICFC6yU35nj0iQfdae9vIWHInewB48dK05hgFNQzwxpTX968N44KPm30A7
	tEp2uxeq8soulB33KeQNYnUPCSFyPH0LPY0dt3zbLPuB1DxFAJCaiA==
X-Google-Smtp-Source: AGHT+IFw71b3OYVPNe+t05CidalajI1SiIlNZ2RN6zsNLW4GExT54+gYQjXEbzLSFC9QbDLlJoqFIQ==
X-Received: by 2002:a17:903:2344:b0:215:b75f:a18d with SMTP id d9443c01a7336-22307b4554dmr67545865ad.11.1740503572170;
        Tue, 25 Feb 2025 09:12:52 -0800 (PST)
Received: from localhost.localdomain ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f40sm16844925ad.144.2025.02.25.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:12:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shradha.t@samsung.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] PCI: dwc-debugfs: Perform deinit only when the debugfs is initialized
Date: Tue, 25 Feb 2025 22:42:38 +0530
Message-Id: <20250225171239.19574-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some endpoint controller drivers like pcie-qcom-ep, pcie-tegra194 call
dw_pcie_ep_cleanup() to cleanup the resources at the start of the PERST#
deassert (due to refclk dependency). By that time, debugfs won't be
registered, leading to NULL pointer dereference:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Call trace:
dwc_pcie_debugfs_deinit+0x18/0x38 (P)
dw_pcie_ep_cleanup+0x2c/0x50
qcom_pcie_ep_perst_irq_thread+0x278/0x5e8

So perform deinit only when the debugfs is initialized.

Fixes: 24c117c60658 ("PCI: dwc: Add debugfs based Silicon Debug support for DWC")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index dca1e9999113..9ff4d45e80f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -535,6 +535,9 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 {
+	if (!pci->debugfs)
+		return;
+
 	dwc_pcie_rasdes_debugfs_deinit(pci);
 	debugfs_remove_recursive(pci->debugfs->debug_dir);
 }
-- 
2.25.1


