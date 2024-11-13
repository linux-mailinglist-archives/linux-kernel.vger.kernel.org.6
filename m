Return-Path: <linux-kernel+bounces-408281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE79C7CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AC3B2ECD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5678207A0D;
	Wed, 13 Nov 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt9C9wpg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F4189F45
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529340; cv=none; b=UAkAYQOrf//UWXKt3QyyASzx9XmzLo8VkRDr1sN5pz90kCmVE+4kRXy/nQ+t50AVeQNWj7W7wdy1p04MPF6eJmyKYt64YrOWYx/yWZIQrblThusZmiW8vTVakpMl4WWRzahwqEe6JAfeRmbvzBkuWsJ4DK6gua+CXP97QER5ThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529340; c=relaxed/simple;
	bh=i1reo/puGs40XsgdXpRo5jLuvVCjJ2MdZ9V3/j/rjsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0QTyl2K5jSVo7kmAhy/qQq17yee6aGwMI9VJFKEJ0eUw1b4C5MMgf027FB+kuyzXAZBAxcki76JaaFuPwmdaNXEbTqDGh7jWjLFRkRTT6qhYVL1+gClA0kQ+88Crlpbd3+a8lMLB1yKXnNSdwyo0U0iw1ylDqTFvoo0ws/dLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vt9C9wpg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so125351197b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731529338; x=1732134138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJGyo8V7hZdpO0Kqq5qpbbvS7ePkaWzpyfoWKyhMfqw=;
        b=vt9C9wpg+qlrz9flU9C8aOowOA3Uy374AEpUOCasqLGA7K+PBRQvbX36YXzkJnP5Lr
         XoYYlQ+hBaRmtwGMgAV6VwdeM8xfMk0GmJsV6ENm1vHfJWh6RaU3AnsR+RCfHKj+hHuL
         GJuYyM79ne6QgYkasMgpAvWMpfB4+JK1IWKvq2MxAIuY+CSfH5MOVeVg3XmyJhFOT3mJ
         YQQGAngJH4WCDZAclu6wIHWa2gpnJFxko2E5dmx5H19wIHVz9cvGJXBqeNBXQasiUtrn
         DXzibR/OFV0XadTxgKMXN3CMVIwpZmjnrSahcdJ9PqmI/5x6Kbr43rlGQNXutElTjEjD
         tQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731529338; x=1732134138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJGyo8V7hZdpO0Kqq5qpbbvS7ePkaWzpyfoWKyhMfqw=;
        b=W1MB8HrmQFFHZkV4jtSJCA5hK6T50b6yPBipo5oAiHP6DJuPW4E+TUIjlPUBImyHnK
         i3riwvGVMmaZxyWeb4xJ2WZ+2iKJAchiA5kmA0dNlrZwo3fgbn/kb+SbtE4SZskCM3Qi
         LIqobVVLMLsZID4BwfUQEUW3b4bbMPGTWv4BgX1EFeFEbgmj3PQEJVLL0A23cOMyu+Re
         Iy00Mjk/Tc0j876h3m9ul0WwFByl4DSbNqVcLfCmkJZM8WSVZEh9pn2uuLK8ljTfX1V8
         cIOlUer0C1SVxUPu91Jkp9ZR40j07fw5plFTHcQgmKl9xQZ8tp2q0V7IO5DIiQVWRTxv
         q/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUDZumPwnwCAu00/IJOp+oXoewUaJeBfhZKjz1F7Rq6kDCOpHh4w7Qnpg25bvBan+fRwMLsc9EvkthfqMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvaSxIXNZxo92mCAD8K+FRxh7ErS576m8RDf8+VeOLhz0cOIv
	dMDtZAxhAwPm1KvIfaWN6v2R485HZq7hFx0LorQBDDDN7E2nUQfO/5r5gNJGXP1mhG6m9DDqVDr
	z8Q+MPw==
X-Google-Smtp-Source: AGHT+IEgGSNApUMGmwT/5GWxoKIRky9G2mDTqjPFWSUJWlfb9He+rGDVI8sa+ciqObwRMeOIZsiDz7ItzLGb
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a05:690c:6608:b0:6de:19f:34d7 with SMTP id
 00721157ae682-6ecb31b51f7mr2229637b3.2.1731529337892; Wed, 13 Nov 2024
 12:22:17 -0800 (PST)
Date: Wed, 13 Nov 2024 20:22:12 +0000
In-Reply-To: <20220426172105.3663170-2-rajatja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113202214.1421739-1-jperaza@google.com>
Subject: [PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: rajatja@google.com
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org, Joshua Peraza <jperaza@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset rebases two previously posted patches supporting
recognition of Microsoft's DmaProperty.

Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 12 ++++++------
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/iommu.c       |  2 +-
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         |  8 ++++----
 drivers/pci/quirks.c        |  2 +-
 include/linux/pci.h         |  5 +++--
 11 files changed, 44 insertions(+), 18 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0.277.g8800431eea-goog


