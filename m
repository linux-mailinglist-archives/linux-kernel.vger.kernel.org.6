Return-Path: <linux-kernel+bounces-348782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59198EBD0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377331F24399
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3513D600;
	Thu,  3 Oct 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OAEDgIgz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F113CA95
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945032; cv=none; b=g4n+pCzrqhnVh6zx2AfX7+l5LXuYzD4esorMtMvZR914mxXiFEn01LFvMmA71m4ueGoJk2D3wRQSl3Bs2HQQbeS0NL4snyj3jl/dtMTpZ2q+Vj+QcIH6p7WT4KcJJE5+PLXVJLNBahVybwXNwxTMRA65Sgv560XQv2Gco8ay9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945032; c=relaxed/simple;
	bh=V39ByUnb6eQA7DEYoba3mYdbfJS88SGqKjIcIGHEECI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uh/nIeFinsCtAQOqWxXqfcNqQKLH/AUAO05jwfFM+tzCzGxLGEUSSxDj2hqF8v9udJI4CrzLlFubj3FOE90Z1cEtWM6BY0tUFC6P4fx8c+U2DYGFhhLSqNTBBlA75dCg1EQGTqAPAkO9n8KWjrwgN37Pf52+2qvlCYpAFU/5XqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OAEDgIgz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so6441605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727945027; x=1728549827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91R25a2wyX7P6HDTIfgpwuQpgkreLb8uwItCcCtAsaw=;
        b=OAEDgIgzG645IelmgVnDuAV8XAm3PcEl0NIhwNuC/YtMKcFsWpsSSnrWhEjsdWmjRE
         pFtOs9D4OWuyGyTJMrupDlbrXV+m7FcNquLBhMOMTN30PeTdiBylok11scxe1DmJK3Ot
         p0jliDmJmeQgRiC6FGWvO7d20xVeIM73Wj1yX6c1PR60Q8LyqRgLuAEcbixZGFT1ltqV
         f0j5xpcAPErMZTHVPJVhS/Kimctc/rmj73w2RV1ExBZbYiHyqzGP2JacVIHl0Pv0NDxc
         qPkl0IHSggKNW60D0sh0a2DW6PIuD9hwdkfn55jHI9ZyHlGqXZgBE2/8+VX+9iqsZGan
         XRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945027; x=1728549827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91R25a2wyX7P6HDTIfgpwuQpgkreLb8uwItCcCtAsaw=;
        b=ZAEuttiYTFGsIb13YtPjB+bXXKoZsLQ4ftuBFkplflptRhBl9ldnvrX28FAG/3PJw5
         +ssXq5HoXXtqa6TeZ5V792Kum1J00/7YIZmHDbM5k8gApBSrdIy86Q9Qg5trRhSLuxa/
         mpECdZZf1eEgm7gUirxRgRu6f2aiq6H+H82l5sZ27hjdzWZ53c/5Jpxk+zfsTpzngHRS
         a0/vKUdC/lCfyUM6PxcSoLfSXzG8ftNJp4XEVNVwsB3ELCpfR6slZ6+dskvPYK1owVfC
         uPM66nUqgnO9qIaMq6tc2XbGp432EPG0Cp8phr5WjwIQYZfYda5gPuLzwlXdbGjb6fui
         eBnw==
X-Forwarded-Encrypted: i=1; AJvYcCXybWDlIeshbJvz14Y6Svm0yharL1vhVYfAuPzlsgIStbdXczm9SyKxSIgHLnSWeXSfmOekMLj3wEtpJi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBr41Ux4H/sa/VGZKvewrLDKdyIGb/s0qR8ydn5YyQLiRsk3p
	g3I7qrW6Ctv747vKTiyuLtQ7iDP+kYjmcFJX+oa8PvJC0mUtFX4/Yc0JhVVa7Vo=
X-Google-Smtp-Source: AGHT+IF8q7SdaJlu7Cz2gjY5BfS++DH+bKC94NBze2ggp+J2cvIzQEdbZw64rpaHfv/VwoxVyvianw==
X-Received: by 2002:a05:600c:3ca5:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-42f778fca5amr47022515e9.30.1727945027265;
        Thu, 03 Oct 2024 01:43:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d16b:3a82:8bfb:222a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02f174sm39362455e9.44.2024.10.03.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:43:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2] PCI: take the rescan lock when adding devices during host probe
Date: Thu,  3 Oct 2024 10:43:41 +0200
Message-ID: <20241003084342.27501-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since adding the PCI power control code, we may end up with a race
between the pwrctl platform device rescanning the bus and the host
controller probe function. The latter needs to take the rescan lock when
adding devices or we may end up in an undefined state having two
incompletely added devices and hit the following crash when trying to
remove the device over sysfs:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Call trace:
  __pi_strlen+0x14/0x150
  kernfs_find_ns+0x80/0x13c
  kernfs_remove_by_name_ns+0x54/0xf0
  sysfs_remove_bin_file+0x24/0x34
  pci_remove_resource_files+0x3c/0x84
  pci_remove_sysfs_dev_files+0x28/0x38
  pci_stop_bus_device+0x8c/0xd8
  pci_stop_bus_device+0x40/0xd8
  pci_stop_and_remove_bus_device_locked+0x28/0x48
  remove_store+0x70/0xb0
  dev_attr_store+0x20/0x38
  sysfs_kf_write+0x58/0x78
  kernfs_fop_write_iter+0xe8/0x184
  vfs_write+0x2dc/0x308
  ksys_write+0x7c/0xec

Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Tested-by: Konrad Dybcio <konradybcio@kernel.org>
Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- improve the commit message, add example stack trace

 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..f1615805f5b0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	pci_lock_rescan_remove();
 	pci_bus_add_devices(bus);
+	pci_unlock_rescan_remove();
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);
-- 
2.30.2


