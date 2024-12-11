Return-Path: <linux-kernel+bounces-440909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E9F9EC650
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9629188AEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF251C5F2A;
	Wed, 11 Dec 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kw9QLeIG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127897DA6C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904095; cv=none; b=dQByyTuXGqerSGUmrcs87udIfYQr1pW/sQ1M8FyxXYZzJVLMzGzLD5TmmiKtzIzrH/VaAerFT4zlMzJumCCr1sg2z6Jb4dMPOhNsnNelb1M84VwMb3YHXxtJp8ixqcNTDSiX3zfY7HOgft0MwN57SgFqQflXjv0Ycxfnejwhwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904095; c=relaxed/simple;
	bh=QDCClO9+ruB6VB/58Ynw02ygmft+gwI7j3Au7lq3IGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXi1B5rRg9ALEhK0KnnWcrxNqPy8rGmT1dG5qSMJOeBkzNUcHwwbqH0nKvR/N3Lus4qlgdepOAXmT4GZSb3zXYjSpI6aCMQBKFPzq8Wc0RikNFMjm+cOGAcZFOlse8qIuLIjBVLb6IrjKcdPcGLQvk4oUcCbh/gZgAx2QWcVyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kw9QLeIG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2162c0f6a39so3884915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904093; x=1734508893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEGhXU+QLmJOzGqN5qm96MkDiJr/KItzUXBN99PYXic=;
        b=Kw9QLeIGLVBhc/sFBNOd/koF+J7e7iofTdd3cKtJy5akBc14RHKsVd0Jzy5jgidxTA
         aFmNJ43oPSrEF2jQfyIxyRn+M4evk2CLGUm1qa1G9Bn3xpI8GjjQlTr2utiPWvAojg9M
         CWD1YBryWRu1kLH4NPjKQ9XHpZYO4TcZgRkVTxOBBLmiLEkxvXEivsx4wAin4CuRZquV
         Sylj1ZWyX+hl8zTGkxNruJ3hnbeVemJu8HEKrPHN/pmue0Td5b+84846GJH8TRam74Iy
         D/64YFOyV/zO66lnJbU4Cf+4m4fumOddtCtj8CyVRx0vA41DOaxaHy/Pv0ziSNak6tw1
         9dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904093; x=1734508893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEGhXU+QLmJOzGqN5qm96MkDiJr/KItzUXBN99PYXic=;
        b=FaaTs359dLf2/7FXvMggazVXek2VqEo0Iee06CNZudTQXU4Trmv8oW+FBbejI8GTb1
         xDUdjWVv1KCeHhGawTCHF7+gn/yiSqrWuuzNPqlAq/qNXlu1Z273p6zRTTKv4PQR7RRi
         b+ikE/CnE6rXIzCFykvylkZ+qamtC+41wT4WJUGLUkuxBV+lW52pKBMXS9ngc9aHdAdF
         FX/Y8tyJSB6GhYatqaLpmfmanuX51xCzpVpBrThzWJ3QAUv5ygMU8IiODgCbA7+fC0aY
         NHPI5gt55YgS7lYrBX18YeAc0jQQko9TI+y99/JIo7a+U1ubuSxx+L/Fb6rK+SHdhrGH
         J/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUoE/owuIiTroeCxx1gK5XuNj6OmD711nNfAu0+Gj/96L5mVSjB5pbvUndFabVCzB7GxD7RS050bqW8CrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBRzzeFgUX9Lcxq/m80RhWos/ijKBAnRuFe+BrEStpNyEpscy
	/JRPr51BF1Ek2nRPrLYBaiHHCbbuyV5AQwnFP/BCVb33x2GLg72l9kJ+3wt45w==
X-Gm-Gg: ASbGncsQshncf0jhLPPQftYOuvvBP97nvp1RMJSqqlN4Q1PpCCIXDcBo22RM4nU7TrK
	Acjr8X/mVJtHXyPKCsoxEMJp1JkBxD3kC+YKlEX/WBDOExCXitdHgIcZu+Bk/svsb/8nQAzvzG0
	rdg2PvvwKg1U05WlcKvwrNkzIvI1YjT3TGpGhJQIwYYH0/x85UWAeECXXU47BAWmH2gP3+1sdUG
	4+tIjhndZINLsuGkWYrHS4gL2x0DqWlRLwvrH/n8mBkonzbhoXdcKBVZNK5+lOy5VOZv8aEknUw
	Ff0r
X-Google-Smtp-Source: AGHT+IEjpYTPZZfgdWB4UyzQkMZqnr6AOgFIDYrlPTj+b2+sChMPtg1c+as/xrmzdknyus1FwtOTkA==
X-Received: by 2002:a17:90b:1f90:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2f1287a38a2mr2651334a91.8.1733904093408;
        Wed, 11 Dec 2024 00:01:33 -0800 (PST)
Received: from localhost.localdomain ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm12929775a91.51.2024.12.11.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:01:32 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Wed, 11 Dec 2024 13:31:01 +0530
Message-Id: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series carries forward the effort to add Kselftest for PCI Endpoint
Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
based on another patch that fixes the return values of IOCTLs in
pci_endpoint_test driver and did many cleanups. Since the resulting work
modified the initial version substantially, I took over the authorship.

This series also incorporates the review comment by Shuah Khan [2] to move the
existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
migrating to Kselftest framework. I made sure that the tests are executable in
each commit and updated documentation accordingly.

NOTE: Patch 1 is strictly not related to this series, but necessary to execute
Kselftests with Qualcomm Endpoint devices. So this can be merged separately.

- Mani

[1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
[2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org

Changes in v3:

* Collected tags.
* Added a note about failing testcase 10 and command to skip it in
  documentation.
* Removed Aman Gupta and Padmanabhan Rajanbabu from CC as their addresses are
  bouncing.

Changes in v2:

* Added a patch that fixes return values of IOCTL in pci_endpoint_test driver
* Moved the existing tests to new location before migrating
* Added a fix for BARs on Qcom devices
* Updated documentation and also added fixture variants for memcpy & DMA modes

Manivannan Sadhasivam (4):
  PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
  misc: pci_endpoint_test: Fix the return value of IOCTL
  selftests: Move PCI Endpoint tests from tools/pci to Kselftests
  selftests: pci_endpoint: Migrate to Kselftest framework

 Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++-------
 MAINTAINERS                                   |   2 +-
 drivers/misc/pci_endpoint_test.c              | 236 ++++++++---------
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +
 tools/pci/Build                               |   1 -
 tools/pci/Makefile                            |  58 ----
 tools/pci/pcitest.c                           | 250 ------------------
 tools/pci/pcitest.sh                          |  72 -----
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   2 +
 tools/testing/selftests/pci_endpoint/Makefile |   7 +
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 186 +++++++++++++
 13 files changed, 373 insertions(+), 602 deletions(-)
 delete mode 100644 tools/pci/Build
 delete mode 100644 tools/pci/Makefile
 delete mode 100644 tools/pci/pcitest.c
 delete mode 100644 tools/pci/pcitest.sh
 create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
 create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
 create mode 100644 tools/testing/selftests/pci_endpoint/config
 create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c

-- 
2.25.1


