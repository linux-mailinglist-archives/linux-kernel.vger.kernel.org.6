Return-Path: <linux-kernel+bounces-532028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B58A447C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD28C423247
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748F1DF98F;
	Tue, 25 Feb 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL0GYxMp"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EED1EDA19
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503571; cv=none; b=N4gsE3CBSMJtCGOMQlKFhYDKaJRfASa5R6TaNvU2u2u4sPreOY6V6tX/ZUFPLoZEl7jxv6VkpsjwIZL5vKWAE1xw8sVJGDVTphDn8Eogn2dinMnL5cqL1mafksfw5l7VekbgvjdcS2UT2bAejT2tEvdQviiNGYAzP5jR2XEGj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503571; c=relaxed/simple;
	bh=solmisJfOwq7tSo+vQhMg46du8qP0Mm5gMU1KVww0NI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqaHo0omd4Z2Sb+CGHzfT418kAkih1LGLV+gMb9/TWGcM/+Apgz9Dx2mxMtMu4dd4wVOlcXhYO3HX4IEYFaE37pNIJWMAqF797ofQsiz4hGYByJrDCJNACTeZc58+NBEEKrXn4KEHgrrcO4DSJRwp5EoRB4+mhg69zwyIzMXPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DL0GYxMp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2211acda7f6so133301025ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503569; x=1741108369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jG0W9H5EHgY60+XGt77vkeLnWA8gkbVQ9cdgHwuEC4=;
        b=DL0GYxMpYglS0lhWClMZUGd6/PdKyx+WD1rk6Tv0FBVSU3YyysYRMh1Qe/DkRWTfRj
         vW1WE7lf+746zeXLyKws+xqtj6Px9kg2Y/Ij70iiaQkMwBh16tc6JEiTtN2ZPZSdW9fW
         z/wsNALWMHfgrraBwtO56qAdhzXX7TKXl/jg5twhwQvwZTw4XNbRlxpdJLqR6U1kIFKZ
         0eDw3zjEhw+psATGHZUZ022Wg2GUTH2Ww6lwlaKeOdKew7E1Ug/uamqU5WPq9RBt5vMX
         5Zof/sH5KlrlqOyEJ/db4Vyg4qLsnbhXC+ea1Ax+dOM1xxG4HngabVOoP3fSYlwzUc/j
         B1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503569; x=1741108369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jG0W9H5EHgY60+XGt77vkeLnWA8gkbVQ9cdgHwuEC4=;
        b=pGsrQOG4qQ9H1DgdhORXD4S7qsSlW8p6IcrbRofOAPopOv5UgdZTr7mcXlw9UuEM+R
         kTn/hEOQYIytZGxC2IrB79kr6DYTptcXpD85UPmaXRBzt+5u3NyNUIN9RI3QLE4FgICB
         WwRxKrSFVS3Bm8r3Aiehh1XK4P5/jT5sQ+oARaDsijiwD2X3tpfIljh3/GtGGMm8etEv
         TdLnxFHOHtiffDN2v97OKdX6y7sB8J3sFst5aPZ5tkNMIKOLJTQX3ZxEHoiEmEFc8nkW
         VefVI+9ZeCQWTDvkxe6Tb+wG8dQEUHz/uhB4tqi+c0rXwEqFF2pEQ2HHJ5A0lIL8OrvW
         lSfw==
X-Forwarded-Encrypted: i=1; AJvYcCXnlYxTvroK8fHA01s61R3KHqMEX+cTFI9fnPIiusNwxDQSvxEt4iRdyN4yzEFbG0X9lkW4NxPub0WC63w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEhuY2ZW7YUzgcxrkMxPbhS9bMZyfzbBUZBQNcQyMDuQKViyK
	PYahColAWjMM1+UR/oCiMRp3vuras3iL3GohGs8wS007af5kgfjfBV0e8RKhqg==
X-Gm-Gg: ASbGnctg2HHNlInJDa00sgR+otJEVGeF8w91wXxGAfLMEnRE+T22Q/48VdiIStw3UYa
	p7umFIqciKNqQfT+7s969iLRbB9p00yJ9ETgv0QsHAjvjUxPFtsP1UoTaJ3C/nisfJhgjSk9EuF
	wWSpC981KFbIRzO+FmNOhYq2pVzDyx5b+yGuSHMQzotu+BLhsdHNNG4cnn3JZzY8VNsUkmdO3gP
	/KBQizAa/Z+CeAi2QRe9yT7NhJepN4GgIFOeUJHjHJWQ4YQQqlIo4FCsZtqJxHwNz4wA7ODzJZy
	t7JBJmwKusLte3/FP2QF0Padj+MEmUlHIQPhwXKSeABNaX6V1scEDA==
X-Google-Smtp-Source: AGHT+IHjmQd2iyEjNZ5iWvHuuhwXr+ROlu+iTqFwv0oDwguUc9oGY/92+rxd8sOUv0ftc2AvvJk1eg==
X-Received: by 2002:a17:902:e892:b0:220:e63c:5b08 with SMTP id d9443c01a7336-223200853e2mr3925605ad.11.1740503568871;
        Tue, 25 Feb 2025 09:12:48 -0800 (PST)
Received: from localhost.localdomain ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f40sm16844925ad.144.2025.02.25.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:12:48 -0800 (PST)
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
Subject: [PATCH 0/2] PCI: dwc-debugfs: Couple of fixes
Date: Tue, 25 Feb 2025 22:42:37 +0530
Message-Id: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series has a couple of fixes for the recently merged debugfs patches.
This series is rebased on top of pci/controller/dwc branch.

- Mani

Manivannan Sadhasivam (2):
  PCI: dwc-debugfs: Perform deinit only when the debugfs is initialized
  PCI: dwc-debugfs: Return -EOPNOTSUPP if an event counter is not
    supported

 .../controller/dwc/pcie-designware-debugfs.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.25.1


