Return-Path: <linux-kernel+bounces-397824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968C9BE114
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C019282CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EF1D8A04;
	Wed,  6 Nov 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yvWpNIa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017331D79A4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882127; cv=none; b=Lp2IeDREWTsd7kY9IUIc0WcIQm+6kbfLNGM6WFdcZfbIdfDqJBe7MA+Lb53CAvVABl/y/nftF5K5wXjKrjKB8bxTi0KadRwn5zvHdNQIMGEWcw8LmWl4t65ImBuDkV+wVRVqe3Qi3gQfywY7w1iOGK71jMkYkQ8fItk2cRjCfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882127; c=relaxed/simple;
	bh=wSFwOkVM+mO5y/3u8DCOm6hsOTQ9xA6YsY1T5SxSGV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cMSHw2B7msEdals6jGwD2zgPBY2iUBnGLzPlwtXnVnEJMUhThVsa9QdbXHAqOAzVVUTxZnaHNwmcUdKNEE4TNmpP/OmLJVxMSgiuFHkVC540zejzG5Ah9DwukQlOJWEiDMxKhwDSZ2Bk0DztI5VuWWML39pI5OhSRRhVcHFH+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yvWpNIa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea90b6ee2fso50641367b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730882125; x=1731486925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+9ba5PoLuD4xHrXW8Z318SApTB5yygR7YGjjV9I6Qk=;
        b=2yvWpNIa4r6SXgrgnTDwU6bnPG2z+zhWpoxZT2n+VEFbLkQ7lzZS4/DJ4QQOZK4Uqm
         N7lepL6htrPpovClAfgse1g8SMWRV8TIv7FvwwmMoWgA2Sr6UoT+vRPhWCcx2KfEDm3W
         b+h8phWkPLxoZfByI5uZxax9i2xEyxQDtPjdavix6XyIqBoVcP2hZ0dhbwy02MlG3G9G
         BMrnc/O/lvy+Xd6D1ThfelAQZu3odgpxIM/9Qu94MnNfq5v868i03faPZ2K00eF9cmYs
         9lK0Q5DNWKpBoPqkWKXR/it34HhtXFbcyl+kMhfjiPkfO6FuUKcTS0mDYsAUdvbKZzjH
         h4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882125; x=1731486925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+9ba5PoLuD4xHrXW8Z318SApTB5yygR7YGjjV9I6Qk=;
        b=HzzHJcnTFSRw7muzPAYbvGy1m+n3PBgDCZmQ5xUhb5p+P22Mr/ceYioPKHUav+ZbOR
         EoCAeo215mbM+wHsIaBhIIBWwc+z0HhxMChF6Pw2N88lani/iHL8B4ikmuNmh/9LvDRN
         ZyWDkfpzrsrRDfCrT5jmD74InVlWcuJXbzLGvGYDdNTWwo8R9xnaG/QFoqCePrR/EhFV
         ynlW1dQ//LKxTdG6FTZxC+W4sSeP1N6oJBrdH/uSG9FES4frU+tbGDsTMDcSV0sRsKGr
         qgruKzOiPJQ6dp8vbjZKCiBM1ONislDbfS8as0PoCUHj+qDaBNaiPY/MIfrNFOyTf88c
         p2vg==
X-Forwarded-Encrypted: i=1; AJvYcCX7GX295ZDQF5nLQbgizHiDO5VyEy7u4m+q7Eu/Zl+5kuoGTb+Nx2od6CjGcG0pSWoqzldu0KFANjzhP+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYiqr8Esle9QxLjMax7KRA17+WPj64TWc/pteCJkgJZh56kWy
	VMvJbL7TwigFNMWvP1fp6smXpbbJEBDgwk6fTQDdVqoa2VJ2bFUkan5myp3+4/PSvflIrp1REeN
	1DZhd7Y4t4RTi+Q==
X-Google-Smtp-Source: AGHT+IFmbWrVFpsQS9VmcdMhtsMdkxe2ajlxASbMTbD3ZoxaYeV/VYnyNEsdPpB7139H2vGMF8BJ8Yv81OBrzPI=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a25:a3e6:0:b0:e30:be64:f7e6 with SMTP id
 3f1490d57ef6-e30e5a3cb05mr13136276.3.1730882124935; Wed, 06 Nov 2024 00:35:24
 -0800 (PST)
Date: Wed,  6 Nov 2024 08:32:56 +0000
In-Reply-To: <20241106083501.408074-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106083501.408074-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106083501.408074-3-guanyulin@google.com>
Subject: [PATCH v6 2/5] usb: xhci-plat: separate dev_pm_ops for each pm_event
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

Separate dev_pm_ops for different power events such as suspend, thaw,
and hibernation. This is crucial when xhci-plat driver needs to adapt
its behavior based on different power state changes.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/host/xhci-plat.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 8dc23812b204..6e49ef1908eb 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -450,7 +450,7 @@ void xhci_plat_remove(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(xhci_plat_remove);
 
-static int xhci_plat_suspend(struct device *dev)
+static int xhci_plat_suspend_common(struct device *dev, struct pm_message pmsg)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -478,6 +478,21 @@ static int xhci_plat_suspend(struct device *dev)
 	return 0;
 }
 
+static int xhci_plat_suspend(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev, PMSG_SUSPEND);
+}
+
+static int xhci_plat_freeze(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev, PMSG_FREEZE);
+}
+
+static int xhci_plat_poweroff(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev, PMSG_HIBERNATE);
+}
+
 static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
@@ -524,6 +539,11 @@ static int xhci_plat_resume(struct device *dev)
 	return xhci_plat_resume_common(dev, PMSG_RESUME);
 }
 
+static int xhci_plat_thaw(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, PMSG_THAW);
+}
+
 static int xhci_plat_restore(struct device *dev)
 {
 	return xhci_plat_resume_common(dev, PMSG_RESTORE);
@@ -553,9 +573,9 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
 const struct dev_pm_ops xhci_plat_pm_ops = {
 	.suspend = pm_sleep_ptr(xhci_plat_suspend),
 	.resume = pm_sleep_ptr(xhci_plat_resume),
-	.freeze = pm_sleep_ptr(xhci_plat_suspend),
-	.thaw = pm_sleep_ptr(xhci_plat_resume),
-	.poweroff = pm_sleep_ptr(xhci_plat_suspend),
+	.freeze = pm_sleep_ptr(xhci_plat_freeze),
+	.thaw = pm_sleep_ptr(xhci_plat_thaw),
+	.poweroff = pm_sleep_ptr(xhci_plat_poweroff),
 	.restore = pm_sleep_ptr(xhci_plat_restore),
 
 	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
-- 
2.47.0.199.ga7371fff76-goog


