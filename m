Return-Path: <linux-kernel+bounces-397821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D69BE10D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EB61F23E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D341D5ACF;
	Wed,  6 Nov 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgnsZzxj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6438F82
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882114; cv=none; b=kX+oTgcGni4OArVAaB+N5+CZjeWRdlhaZSVgOQltAg0v4ZwNNc66/r7C8Cbs6loa5bi6MpXtySmuKO0+Syka2qQT0B0k7XzGCezZtcODj0Mp4mc89WTvS9Ps7hNt3uFXribYxs2b05bLDUlrISRhVW09QvtlGjsSpOwmDEU6hZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882114; c=relaxed/simple;
	bh=1gKbUy0hvqMiIFVOqU0r6R+JX/FdNFtqzepVp9aPdHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p0eleJVbrKCtg8wQVTWIKtAUyZmq/HrOE56ycnggNsH5ZRkhF43Y1yxHTX5fX+bjqC222hV+M5PQR2k5ws5Vqk/1kmtFloBpApQNBTqzoWRV8FcBMOIa17pDRdYYK0FwyW7CgeZ21iYwOFq72HpnSZDU4JDBMRyiwEEGDYWYj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgnsZzxj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29205f6063so10546423276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730882112; x=1731486912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+sZnhN4f59w8eaVlm9uPspF2D1aSNtZ8q/ULxpzacKg=;
        b=QgnsZzxjl1pfLAa98P51T2P1UJ609DOAFGsjhH8zBUeSJJFSYqp39lRNq+6Ch65CbF
         9XJzSsq5XeJvAgWzY3uyLbYk/mooezWc/E3FIZpAElvD4DoqiWgdSFx1d9ZlVHC8boCr
         T8EGYb0cpzBBatw4nIKx0bT9Q8fCBExLT+wth687I4OeNR/F4r30lRvqP+au2+Bed7AO
         13pPFAbCImTHLTxwZDXTkghwRuUWkxgAvAOHxMzLrVmDXjmFPfqUebWhnGz/xWxFJ9Cs
         wpqOMXxT5NPeGgbZj+1HkLLMSVZBLgw/EfvPDmgFBZCaWlxZgvFgUr67HWNX708HcOwq
         Xbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882112; x=1731486912;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sZnhN4f59w8eaVlm9uPspF2D1aSNtZ8q/ULxpzacKg=;
        b=s7Ti36ozcYkdVXKTcbHQzTBiH3NOt/AqcNhardZx463LbsdAWKWukFlqyDGVN2WqVm
         Bm8M4BxJpwVu1bbl39pyna1mzeowgUG1NMIigUzRnhoTXguVpyjDuVcXPgg0S0xjCNiQ
         0XudE4Y5ovxBOGTnJd8bwUN5ETnGjgXB4UXMvQWzXwxlSx1FFZx2eY8u+JSPYnYp9/sM
         IL646FjpgKDRsfKU8kSMJUVYzb5Nl6VSIGUBQKSluM28JCkbiDxx8za2OoIFioHYVSeL
         Y5l/AGuMuNetrKtz/QC7boOyxtrWWnLBpPq/0MZzuzRs3lYRnrKTi9fS1hK0XTy8q7ba
         jm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVRhYDImbs75YQCAMVo2NTV41jhgmqJCYZpV1Fj31Ft+EIQj3JboSydcbXa0HhTQ8EVMeKEPWoMFs0D4CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Fa3J+MS92tGYJIFaZKsHwN1RIVa0ogfWl6p0NP75rhsSlZzg
	EnvvqDP433Fkt52QhefLwWuuqCRSOB1nuRYqbe0OQI34GlRnCRgKgCYEwKcz6ko15vTdm/hBP6b
	FhgDV04833pFH1w==
X-Google-Smtp-Source: AGHT+IHOksJL+AHrN3er9na69HscWBTL2INnAN32T9B6olbGvvN+npsilT1SmjoIKHmUPaN1Z/4NdH5ApfdcALQ=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a25:a407:0:b0:e33:4850:b1bd with SMTP id
 3f1490d57ef6-e334b7cf78fmr10125276.1.1730882112322; Wed, 06 Nov 2024 00:35:12
 -0800 (PST)
Date: Wed,  6 Nov 2024 08:32:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106083501.408074-1-guanyulin@google.com>
Subject: [PATCH v6 0/5] Support system sleep with offloaded usb transfers
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, sumit.garg@linaro.org, 
	dianders@chromium.org, kekrby@gmail.com, oneukum@suse.com, 
	yajun.deng@linux.dev, niko.mauno@vaisala.com, christophe.jaillet@wanadoo.fr, 
	tj@kernel.org, stanley_chang@realtek.com, andreyknvl@gmail.com, 
	quic_jjohnson@quicinc.com, ricardo@marliere.net
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

Wesley Cheng and Mathias Nyman's USB offload design enables a co-processor
to handle some USB transfers, potentially allowing the main system to
sleep and save power. However, Linux's power management system halts the
USB host controller when the main system isn't managing any USB transfers.
To address this, the proposal modifies the system to recognize offloaded
USB transfers and manage power accordingly.

This involves two key steps:
1. Transfer Status Tracking: Propose xhci_sideband_get and
xhci_sideband_put to track USB transfers on the co-processor, ensuring the
system is aware of any ongoing activity.
2. Power Management Adjustment:  Modifications to the USB driver stack
(dwc3 controller driver, xhci host controller driver, and USB device
drivers) allow the system to sleep without disrupting co-processor managed
USB transfers. This involves adding conditional checks to bypass some
power management operations.

patches depends on series "Introduce QC USB SND audio offloading support" 
https://lore.kernel.org/lkml/20240925010000.2231406-11-quic_wcheng@quicinc.com/T/

changelog
----------
Changes in v6:
- Fix build errors when CONFIG_USB_XHCI_SIDEBAND is disabled.
- Explicitly specify the data structure of the drvdata refereced in
  dwc3_suspend(), dwc3_resume().
- Move the initialization of counters to the patches introducing them.

Changes in v5:
- Walk through the USB children in usb_sideband_check() to determine the
  sideband activity under the specific USB device. 
- Replace atomic_t by refcount_t.
- Reduce logs by using dev_dbg & remove __func__.

Changes in v4:
- Isolate the feature into USB driver stack.
- Integrate with series "Introduce QC USB SND audio offloading support"

Changes in v3:
- Integrate the feature with the pm core framework.

Changes in v2:
- Cosmetics changes on coding style.

[v3] PM / core: conditionally skip system pm in device/driver model
[v2] usb: host: enable suspend-to-RAM control in userspace
[v1] [RFC] usb: host: Allow userspace to control usb suspend flows
---

Guan-Yu Lin (5):
  usb: dwc3: separate dev_pm_ops for each pm_event
  usb: xhci-plat: separate dev_pm_ops for each pm_event
  usb: add apis for sideband usage tracking
  xhci: sideband: add api to trace sideband usage
  usb: host: enable sideband transfer during system sleep

 drivers/usb/core/driver.c         | 87 +++++++++++++++++++++++++++
 drivers/usb/core/hcd.c            |  4 ++
 drivers/usb/core/usb.c            |  4 ++
 drivers/usb/dwc3/core.c           | 97 ++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h           |  1 +
 drivers/usb/host/xhci-plat.c      | 38 ++++++++++--
 drivers/usb/host/xhci-sideband.c  | 92 +++++++++++++++++++++++++++++
 include/linux/usb.h               | 20 +++++++
 include/linux/usb/hcd.h           | 13 +++++
 include/linux/usb/xhci-sideband.h |  5 ++
 10 files changed, 356 insertions(+), 5 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


