Return-Path: <linux-kernel+bounces-413429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0959D18ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0561F2223A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F091E573B;
	Mon, 18 Nov 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJqbrK9f"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBB1E572C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958234; cv=none; b=Xs8Z9XTX21IUhm6KcdEavzzA3NJ66qEglt8ccLtXNFj/M++vXQ3GPwUbkWUUz8e/qQYQPM2HigkZsI/7NfVjRpjNDi5B3V2GiiF+9KdyfVYgWCFyBXaH1kcv30l7TB6jI0/EaaAWrAOLKdv3RFHAuiEe2LFPdyVpiTwj6x7NBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958234; c=relaxed/simple;
	bh=TXHvwthUxyKkucy030t7OQ/t8utulAiGHXcKf+Rfzo0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hc+ihhIMty/Aa70cCFBNsKKiI85UAFFGD9QkP5/zhXGpS85eZbk5M5UJhIqmi0PRUKXCSl7+2+Y+xkWfXlRSWeBLo+87k7ngI5k0kmDalTtHv+WMOrh6p0mUrgttuHqIjUfqsP6NXoW8ofrXTN2hel6OjrTn20iH0qlERsphF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJqbrK9f; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea9618de40so4797577b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958232; x=1732563032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CLLTznJHtiA3Z7FprTvybK93w9NP6cqpZVxzAkyep8=;
        b=dJqbrK9f/U8dtM2jSVw5t12edEhISxMfGATl/mNlKKL54GKNjjh3eD+VzWh1jEoNM4
         +K/NiQSvt0p+Fn2lMlB71jRJdZn3mb4fcShPJfvoWkIg66aWjUgrE7mXPiS1HWokjiPe
         YDYLqJ5TTkNl0+2v92LzgEDkT63BJxywsm1ilsxtBe/GwHHjW2kQ+/PgkiJj4RpkqAYx
         HaoR/WOWwVxw11cXCN1GATFN4GhI5i33teeyARiAUQPSrJaJKZhK+ogf70O4FC8zgB5P
         ShI7TvHMLFCf/mYx6OhazNLZ7N1addOxK1XIpZn4NNLtGNFhGEKa10w/+KYDAN50qNx8
         6dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958232; x=1732563032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CLLTznJHtiA3Z7FprTvybK93w9NP6cqpZVxzAkyep8=;
        b=WeRxitEftzvuMO56rMzMp7lJnP/VjddaU9kNfetlj04r9fO7h8G/JbyIczXd5M2IF4
         nxuANozQrKlzWJW2TnmBEegfnLsrXPf/LcqQMLV0KHMApgNu7phkRd+Z+4pg3QFY0HCX
         j/o1blaeKpFWSQRHnA8ACVIaI+bED4UbuZxMvOWDGAnivTG+V0gjkrRDmqaxZia20G4V
         8un819FTfvqniTF/qE3DVJKlH3WGh4bHtQHkpt7X4Ou/TFBm6ThHPAeVQ9F2m9idMxQU
         QlCp4MOpV08bJerXOEncIsej9eZeBz/F+7rC5UmlFiUiPmUNqOWFujHXerKJREJaBBS2
         IHJA==
X-Forwarded-Encrypted: i=1; AJvYcCV+QbPbZvklsbx1wxoFZbs5R8h1XSqnLl95GhGNF8bvf8Ak8tZMYCP/Y+i8MIy35Cvjwbj+kpMNXVGRsUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBpTa4av26GY0em4B2rVOvVqOe80q6DSa4+yPKPllj15+WX+w
	flMz2/7MnaST+N+lKvjDLZV1IzZlyO32eYOu5VzWfyZouB3tZxAMa8fZ18JLXnRFxV1Y/+ZiKMR
	hkxwqkw==
X-Google-Smtp-Source: AGHT+IGI12rDi2j2Em3Uzj0nPxjRZJXlGUUwEV7OobEm70WjZPuHminqW6f0I+E4Dxk+zPq/CiUJPuqKcuZI
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a05:690c:8b14:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6ee55c5a91bmr477037b3.3.1731958232230; Mon, 18 Nov 2024
 11:30:32 -0800 (PST)
Date: Mon, 18 Nov 2024 19:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118193024.2695876-1-jperaza@google.com>
Subject: [v8 PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: gregkh@linuxfoundation.org
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jperaza@google.com, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatja@google.com, 
	rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset rebases two previously posted patches supporting
recognition of Microsoft's DmaProperty.

v8: Joshua renames untrusted_dma to requires_dma_protection and updates
some comments, reducing use of the word "trust" to refer to PCI devices
and matching the word choice in Microsoft's documentation.

v7: Rajat updates a comment with Robin's suggestion. Joshua re-sends and
Greg requests clarity and documentation on why untrusted_dma is the
right name.

v6: Rajat renames pci_dev_has_dma_property and links to Microsoft's
documentation in the commit message. Robin suggests clarifying a
comment.

v5: Rajat changes the name to untrusted_dma. Bjorn suggesting changing
another function's name pci_acpi_check_for_dma_protection to
pci_dev_has_dma_property and seeks clarified documentation.

v4: Rajat changes the name to poses_dma_risk. Christoph suggests this
name doesn't capture the intent as well as untrusted_dma and Rafael
agrees.

v1,v2,v3: Greg suggests that (un)trusted is the wrong word for referring
to PCI devices, recommending a name something like "platform wants to
protect dma access for this device."


Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         |  8 ++++----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 11 files changed, 53 insertions(+), 29 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0.338.g60cca15819-goog


