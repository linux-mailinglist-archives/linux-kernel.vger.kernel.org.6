Return-Path: <linux-kernel+bounces-422894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E19D9F84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4B5164C60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37C81DFD9D;
	Tue, 26 Nov 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2PrvhjS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A61DFE33
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663048; cv=none; b=OV+Z72prpK9yvGbygpO9uy0BE2gqhW/T+W/59DxScJepKh1BSknxOHV9e+aLk7XqQCHunZaheilEC4o4GWqo3jh9HIkxCu1gFfWuAOZe5GVbjSqG3MGd7HB8IOOGTVBdFGXAFMpWCVgPdVoZobpnQzRLZqznapN6HbByDYtt1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663048; c=relaxed/simple;
	bh=QNbYR62kxSihfmWFMFWaLTedOh3rb9Jygh9RH/srjeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOE+LSH5UWvEnhrg2YSo7/0rgFV+vkRXnuzR4C3pmybVYfDY8Qt1g2NrNzCMjFT0BTBQl6jdrHKC5EBK6EeQpJoO76GvpGWsytdXpfOlKI2gwZG2GLTzAb52XuqJCIniRbR2ZWV+9bTTFQ6AaPVCisQOosgtDbSCYKTpuYN0xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m2PrvhjS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724e14b90cfso4285182b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732663045; x=1733267845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgCywYrQljSdmItAV6QYlktlpASShyLs3PqDhCmMUsc=;
        b=m2PrvhjSoByxMiBRVShFI+V1jlKlo9c6pwHm8HB+W28cT1qFskemlNTJIpRwknpxDe
         nnpDLipU2fJJVPcBQcia5xEuNb+u+oOfHjt35SLtUIBfg1TWXThkz6x35FiQCDrERt8i
         CZooR1ASBhqsRm4LsSeopFQHTia8njbm2tdpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732663045; x=1733267845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgCywYrQljSdmItAV6QYlktlpASShyLs3PqDhCmMUsc=;
        b=dbdUHGMuVBgTRHY/9LyiQBKMkvioeeazXM2yY9qAgQTivNG9SgYlXkWHi2hAozzQb+
         FVJLMZWzuYAYGkfUkcHa2SAzKKlLK6ekg9aWiya/HNHgFqCPXU23UV9jbEGHBGXUZ0l+
         gvGiMBcQKU1nKRHiB6moYe82/t4iF76Nirh19aWLWPXFbL6RRSygTW3i/9RulmsUrUum
         EZ0JlpsRzzOK8fMPHzYIEE5CxK53pZP1AiYvyKZY1WJLjUQn7D4m/T6DC/TPE5Dwqdnp
         EWku79ksJHiiFt0E3e1ObIdscqHqHlE+bgBLXfbrCb/pbQZqWOhQG6sO2MF2KhPqlNGH
         Ettw==
X-Forwarded-Encrypted: i=1; AJvYcCUbp639HV0F+z0VJjZ2zM98xi/1dzS9AV7kugc0isBZ/i8WtknCx31EqWruUaGx3l6DgQlr/w3wPxWq32U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRGLeCBLBfg0cm5fomq8j0x/0kvGUohTTzqszcxLtLOBTEvky
	P7iqpfPczpjTaXoqgzrw/KEL9C2ajQEWA3rmqxUv30F90LQ5a89/eB29szeVig==
X-Gm-Gg: ASbGncsaqZ9d27rix2qvZvzXHUewTbVV5NVQnexdJtjRJpunVEUS8jTgzBjlJau6qwX
	KDaJ2neN8LAzreWM5ER7464q4gNVwn9+w1SzvxYoBqVyd9L4BIjFNYAZRcZaAxLQxYuSqdNhplY
	pmdVsn6VoY4bkRZ4OH9AMENEkLmqovwHZGD9Sgzm+KhUFFDWe4f3uS3GIykr0iy31e6CB/+ANDO
	rQl9BiQH8xDoIqT5lLtm+HvAoKSRccFdMhhn4vbpBQ3KESoO9+1R1eT7yWhOpJ6UdHaO1dseWgV
	RaO+eY760NE=
X-Google-Smtp-Source: AGHT+IFrllr2WVrew7Crqeczu1EEMEaxU7u5juTJ2m/FXo18xyEAoy25l2UGzRWh1AwvTk9GJ4EBUw==
X-Received: by 2002:a17:90b:38cd:b0:2ea:853a:99f7 with SMTP id 98e67ed59e1d1-2ee08e9d4f9mr1396473a91.2.1732663044988;
        Tue, 26 Nov 2024 15:17:24 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:c93f:3da4:a2a:71ec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ee0fad041csm96130a91.34.2024.11.26.15.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 15:17:24 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
Date: Tue, 26 Nov 2024 15:17:11 -0800
Message-ID: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Unlike ACPI based platforms, there are no known issues with D3Hot for
the PCI bridges in Device Tree based platforms. Past discussions (Link
[1]) determined the restrictions around D3 should be relaxed for all
Device Tree systems. So let's allow the PCI bridges to go to D3Hot
during runtime.

To match devm_pci_alloc_host_bridge() -> devm_of_pci_bridge_init(), we
look at the host bridge's parent when determining whether this is a
Device Tree based platform. Not all bridges have their own node, but the
parent (controller) should.

Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[Brian: look at host bridge's parent, not bridge node; rewrite
description]
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Based on prior work by Manivannan Sadhasivam that was part of a bigger
series that stalled:

[PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/

I'm resubmitting this single patch, since it's useful and seemingly had
agreement. I massaged it a bit to relax some restrictions on how the
Device Tree should look.

Changes in v5:
- Pulled out of the larger series, as there were more controversial
  changes in there, while this one had agreement (Link [2]).
- Rewritten with a relaxed set of rules, because the above patch
  required us to modify many device trees to add bridge nodes.

 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e278861684bc..5d898f5ea155 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3018,6 +3018,8 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
+	struct pci_host_bridge *host_bridge;
+
 	if (!pci_is_pcie(bridge))
 		return false;
 
@@ -3038,6 +3040,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_force)
 			return true;
 
+		/*
+		 * Allow D3 for all Device Tree based systems. We assume a host
+		 * bridge's parent will have a device node, even if this bridge
+		 * may not have its own.
+		 */
+		host_bridge = pci_find_host_bridge(bridge->bus);
+		if (dev_of_node(host_bridge->dev.parent))
+			return true;
+
 		/* Even the oldest 2010 Thunderbolt controller supports D3. */
 		if (bridge->is_thunderbolt)
 			return true;
-- 
2.47.0.338


