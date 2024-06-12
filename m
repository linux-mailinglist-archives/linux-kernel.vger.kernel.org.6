Return-Path: <linux-kernel+bounces-211167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6F904DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0536AB26331
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4E16D4FC;
	Wed, 12 Jun 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TQxk5MYK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216416C865
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180438; cv=none; b=QiczvrLxwXZ3aVkYqK9MVVDsu5Ee7BOLR1iwfXDKfsMLXRRslfUcmdYZFE/rat5LM7pBoMRyRzx4KjpjG27SzYLKv86wL05GECUmNnc3wfjwZgKECz4UMHMYpAC8o/eEPIaCG9pIlqJLJircHvcp5ynB85E8/puncQ1bUa5tBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180438; c=relaxed/simple;
	bh=7ODnCMLyMATh86YrN1ZPmjwWRMHpwQW+fCV8rLwj58E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfQRYBx4GO3lFTAMJgib4+5df8aC40tg004hqcRpSg3P6nxQBN0APF+G+0by8uFoCm4vEUd52DfLHS4QyrMaKe6IyFKJ4dFOVY9RZ8oCL04Ksx2uvA1LKo1TBod1LCTm+VFRAZgx2xDxXuVvQjDyYcET1Bi1qTVCmrl/UM/+w84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TQxk5MYK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4218180a122so13980075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180434; x=1718785234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+tryJWSLGei4yj4mnd/Wwwy83ERVx62Yqnj8MX2+CY=;
        b=TQxk5MYKztGI6IXzOvLNSX1Njy4G7Hep1ykBwj6IhXYoOEw9pKxLtEzPd2wxtFb+cc
         YAUAbUsz81k3PQwwtmjrzngEVjQP4rLRn5UMo326cRTX8vPoPRci43fPmLaByxOTfn0s
         n/+BQV91CFCQfd7B9ahbGfKBH2G/7GNjglh78dz6WDDucsESrZa2P7YjtAmSGe2Otl4p
         mHrThXSC9sEbti4UNFlq3kAWDNBu0OM8OnN7vKzYrh2PdIGXrNLYaA54VLL23wbtVBDi
         6AVHg/yCYS9XrSRZcSTyhPVEWqy7IoZ7N3QAegDDfM4e1rLHyOEZU1pu20naTZo6ShTL
         pYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180434; x=1718785234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+tryJWSLGei4yj4mnd/Wwwy83ERVx62Yqnj8MX2+CY=;
        b=DFf0uSK8ckkfomoxH1zChOXaiCnZCTRhQfJgGQ/EdJodZvMBtVRGEk3qVyEOvQqq6N
         G7ASNz8fODrjsw7czeUf7EHTC3dxfje+d2eHgvI7zTOxurkBNgnPEIbw3cmTmuBQ4Zta
         Wsd+notYaOZK+Zgww4znI1WuYO2UDWnZrCacWddPULO2xtokrLa/tttakyUYrzP97ehh
         HYFpn2LsEWXdZQpsWJhIdsmnfHyIF1MweAnFYr6neFwcW4fW0XWrqa+kIcVJ1zEVwcyz
         hsEkDcA/+n8qO/mxDofGbp0XEGQsKBGkgaR0mSbiggrVpU/IbCEfecbX/FQcvf6L0kBC
         kPmw==
X-Gm-Message-State: AOJu0YwRUjnXo3tSuTaH75RmP2HHHnXd+NLKnQao6Vvs5CRb55rmGxaf
	RR8jVcGWgcWeB3zaO+2N64Ryl8+l6R13H5sjITLEmqwnpvMlcRsLMxgHvmAbHZc=
X-Google-Smtp-Source: AGHT+IFDFkTt9Hyalt1EORmsWnUvoaT3No0XLhTfumJCHtinnWuBc/50Y76gRwgEs1k/81gMqxtorg==
X-Received: by 2002:a05:600c:1913:b0:422:727c:70b1 with SMTP id 5b1f17b1804b1-422861aed43mr12346085e9.8.1718180434362;
        Wed, 12 Jun 2024 01:20:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 1/5] PCI: Hold the rescan mutex when scanning for the first time
Date: Wed, 12 Jun 2024 10:20:14 +0200
Message-ID: <20240612082019.19161-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612082019.19161-1-brgl@bgdev.pl>
References: <20240612082019.19161-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the introduction of PCI device power control drivers that will be
able to trigger the port rescan when probing, we need to hold the rescan
mutex during the initial pci_host_probe() too or the two could get in
each other's way.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bfeeaf2d1fa9..b14b9876c030 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3083,7 +3083,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *child;
 	int ret;
 
+	pci_lock_rescan_remove();
 	ret = pci_scan_root_bus_bridge(bridge);
+	pci_unlock_rescan_remove();
 	if (ret < 0) {
 		dev_err(bridge->dev.parent, "Scanning root bridge failed");
 		return ret;
-- 
2.40.1


