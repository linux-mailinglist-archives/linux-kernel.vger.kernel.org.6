Return-Path: <linux-kernel+bounces-532030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E99A447C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BAE42705C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2929220E70C;
	Tue, 25 Feb 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4y/yAJs"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAB20E6F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503577; cv=none; b=Z9joDr/Rz2TKTXIWpUpx3BK8fR2igQGL/eJVUrpFb42m/wXagGVVnmVVBpr+IixeTUUiMOwezcmcQOQgk05yTamDUdRZqI6ObhizuEh4ccZwDV1yEF4C6VSt/8Bv1nGbrkt/zywyEbIv+w/ouw4OG0z1/DH5POJFb4IpH/C1Juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503577; c=relaxed/simple;
	bh=+tGGIMv06lp+ks8XnH860+Gw5Lwd/dSbE8h71qHq7Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6Ly9gcRtvS9lEEed8Nhu3irrSZwNS2/xwFxvio2AS4tKCxc5cl43gdN/AJ21ElQ0Xwu79fjOzsGXlny9bmNsXCJnf2k/raSFdGmEM8gSJ5wUPzwLblNNRs0M3b/YAgpYdbJcyNAc6IpcIVWTOpYA8BYCdixsxXmPgA3N8wHYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4y/yAJs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8cf98bbso39474995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503575; x=1741108375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2A4Pw1OXG2cGpbo5o64UmI83DrJNfZOQBEMUYC4MwM=;
        b=W4y/yAJs8GoxR5cax841iWfWeGUr5x+eZgtcIdQXKDJ/RsyKbNnlRJAaIZjd9DT66O
         M0r9CU0QbDNJYVP8YqVIh2phMb0pkOXEPXQ7WyjgpX1VHEaKFFa7gkf4K3XcW2hl9AKd
         dafJr/X3wBWdfkl8XxGGIXGhBbjCvmT2UfLIDrIz/cNgFumyiTMIWcKBg2qDKBSjA+qJ
         OaNnaw5vDDAPcD26CndOHe/ksYdWXbJpGNdB+3FG1Q3gs5aIlVRmBPrgLxuKHJBBUwtc
         7dtxGT+wQiumYMTzxjNQ9qNf3/0nf662ekf4WQdlO8WTYoqCWfVgP0vTei5sUP34r7WO
         OtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503575; x=1741108375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2A4Pw1OXG2cGpbo5o64UmI83DrJNfZOQBEMUYC4MwM=;
        b=JSHWVJANmW5eoScOA92cUiLzoz+0PRHIOoBH6Zu+XSiV9+oHJMjVGVLUGw8mPvdIJP
         WOmLiXRPH7Qgqz789yvPAW7jah6bz7JGGwjF77vz157SIc0BxSbzOej/LBRAyj04r1Bd
         /I5/wjxftU3CRP7iAi4DUyp96/WRMW8uaAAP+HNHXRsNmn9dPEwaXuhGf3MZyC3/bkl6
         2UI9OxdqzcQb0Zlyy6fOmEgiXWQiT230WRfY2QNLjhMUBVnRflKZRbxN9GSvCcj3091w
         AMXwWhI8uYHiooy5IeetYPcOAjIYiQunkdh/2tGGn3rhGsl/w+h1j+y6gYw2rI+b603A
         EMew==
X-Forwarded-Encrypted: i=1; AJvYcCWU9L/jOJC6W1xh1M+8vJtWpa/73gRzqUlC7oHvIi6Nnmrc5hUMpxK3ECGXdGjZG6E4YqelLIwqGkgIQqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rABI05U4mJOYAqOXn1HjdF4JAIfiMbW/Ub0hjNeJin8byqoI
	82WwGpD0K1G3qOcrCX0eCB9EqA2kCFu6hoQebWAfBrceuLolspf/mWlNl2iirWSjiiIIDCGlBHU
	=
X-Gm-Gg: ASbGncuFsdq5S5NjmhDlRU4B7NZmMfmd/zCq6Be7/ZN4fcvOmvMXclnX1qWFchLAZrK
	lwLlLJj99TqN12rrcT2/FSmey03m+DPWW7HT96zVCo6m+Rd5adaqdO5T03BRICxsu4vY5BzI+gw
	yCur1NvuDzLpMJtyG/MqzYOKsfEupV8VUyC0EI1GE1j+ZDiTwqbc25gfc13cgH7uSr6sxX74Wda
	jd0S0DLAbwOK8qDFX1SkMDDGJdee8RHwBk4ElPPvvcm7Bt8NtfRkGkH5Gda1yByVhGhbZuWTIHT
	pARcQuoQfzuOyRiAhNvuS5kWIrbS2kTCmrqiQ7hx4ysBhHiU7qvKxw==
X-Google-Smtp-Source: AGHT+IF0H7ee+2m65dVm/sTEhXmntHs5M4Jmtg3yLBFmQYpcVS+0owZYZL1XMbzJ3AMwJRYXJcklRQ==
X-Received: by 2002:a17:902:e54e:b0:220:f1db:d96b with SMTP id d9443c01a7336-221a1148be7mr311401165ad.41.1740503575534;
        Tue, 25 Feb 2025 09:12:55 -0800 (PST)
Received: from localhost.localdomain ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f40sm16844925ad.144.2025.02.25.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:12:55 -0800 (PST)
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
Subject: [PATCH 2/2] PCI: dwc-debugfs: Return -EOPNOTSUPP if an event counter is not supported
Date: Tue, 25 Feb 2025 22:42:39 +0530
Message-Id: <20250225171239.19574-3-manivannan.sadhasivam@linaro.org>
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

If the platform doesn't support an event counter, enabling it using the
'counter_enable' debugfs attribute currently will succeed. But reading the
debugfs attribute back will return 'Counter Disabled'.

This could cause confusion to the users. So while enabling an event
counter in counter_enable_write(), always read back the status to check if
the counter is enabled or not. If not, return -EOPNOTSUPP to let the users
know that the event counter is not supported.

Fixes: 9f99c304c467 ("PCI: dwc: Add debugfs based Statistical Counter support for DWC")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-debugfs.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 9ff4d45e80f1..1f1bd9888327 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -352,6 +352,21 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
 
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+
+	/*
+	 * While enabling the counter, always read back the status to check if
+	 * it is enabled or not. Return error if it is not enabled to let the
+	 * users know that the counter is not supported on the platform.
+	 */
+	if (enable) {
+		val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CTRL_REG);
+		if (!FIELD_GET(EVENT_COUNTER_STATUS, val)) {
+			mutex_unlock(&rinfo->reg_event_lock);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	mutex_unlock(&rinfo->reg_event_lock);
 
 	return count;
-- 
2.25.1


