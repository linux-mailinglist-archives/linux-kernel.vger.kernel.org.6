Return-Path: <linux-kernel+bounces-363593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B7099C4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74675B2A7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE02F157495;
	Mon, 14 Oct 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6h32L9y"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615B158DD0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896325; cv=none; b=GgTjASUY/mpB2dK0GhEYUd8PvMv/QNxb5QD4N0vJY+xkmLqgQcAwoR2Ru5Bl/krvmQO3FaZ88P+g+pwocV7tZkygJo+SMO4SArkUPfDXdJeQlOl1bPS2LyaFXDO8+48Yyd9VFJYKaYVNsMZzX0D+PNrmjCJDK8rwlNAeyXTBHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896325; c=relaxed/simple;
	bh=2lp7pWa+Y9Lda05LwotKzYc/laDTaan9URjSvGwxaaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iU+Xy465x37aQpGOQF/tMJoolltulZGFN6hbEzlBFjG6bmikr452mcwWr9aRvrj5msuJvCPjA39xv1SSdo1/r+JFZlR5v3bmxA8NppwUCRYI1OKNmbr0HKwcij2RRcjPTlzvt4OhUDCwJZMVJobz7iKUncUc9RnIMuR+fIDj53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6h32L9y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso37343307b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728896323; x=1729501123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbiVbUE4n2QmVYqe4n4Co2Ibt4J5qV8FN5F6a1txb10=;
        b=A6h32L9yC8ytugPzN5dK+Dq7bIFrJOLY6W14oSM2KuOYXcv6M0m0AOCdsnJQfUqLct
         WDJHvYHEU638lSbSrVnQ1OpLS9fevWK3lvhgazF0Wp9Cuk2kHaU3ykmMg9AiILxVXzhd
         zulCkrENajD66ZmohMQ6b//2ezl0Zc9SXqSVnP7ZyWQcMCKiAt4rTXymfROEfNDBYj0v
         3GWGX/dIH4LSc5QecX432xi8tHa4Ri7JN4IKqP/byJww4bKF37sjd1Yd/TA9iW7QzSlL
         pduRm34h+QE28i3l+Cn6LlKFv5Y3M5jdQ8m2kakJVBN8V54HuqGrdNZDh60TvWwWFxkK
         qt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896323; x=1729501123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbiVbUE4n2QmVYqe4n4Co2Ibt4J5qV8FN5F6a1txb10=;
        b=kIl4I9sfVdKMlhE3YO3bwBe//RatdcNuz3yg9sTTVvHUCezn+bSQZSlW8+13fH+HxQ
         3kJUqmkgFP3hbou4c/WWXTZ9obFj4EKhMPjhqD63i0/gjOTs4KIKDUZx0saCFq+NTqbi
         4rLw01GxnK6sW1r8jSd//UVMV37BfoFH49alGSgzhR2rd3t+nFAzn5h7y9s/tHVhKV9m
         3C8aK6S42fJlX47utH+iTN6lYM7U+8TQ7Vh0Lb+F9KDB+iEjY386cLolcxsf0w+QBs2C
         UuT8YjN/3/VbPtKzGisjW6RUUdgnipitfa82UX1rgo7d185APdhwTyIHdvjVtHynCqDf
         BGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfsj3YgCgBmhbu2rJ8dwQvRgJaQcRzrQIh82MP5ucIs+Y1WvC6lMWoHmjt8I2nO1JlX+fNVjN3mgDthek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+knQGzM/vjEhXZTbJbonUZSPsdwwbXoyjnvwk5KwVMjL1G0mL
	tWygtRhQC8l1+3vc6yErI1/RpHk5SGuw2M+7n25bIl9XpycgSydsqWJMzkDRgWpFYun2JyeiTac
	E/vYvN6zwbF1kKg==
X-Google-Smtp-Source: AGHT+IE/5EOgs1bQNwKCDuXAlvqCP9BqZx0Xs7qoml7G+FtAvsXrY1GIN+Lb4ymiqx+wllbQf0cGzNfuJtzOSng=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a05:690c:2b83:b0:62c:f976:a763 with SMTP
 id 00721157ae682-6e3477b6b5bmr908487b3.1.1728896322306; Mon, 14 Oct 2024
 01:58:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:50:26 +0000
In-Reply-To: <20241014085816.1401364-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014085816.1401364-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014085816.1401364-3-guanyulin@google.com>
Subject: [PATCH v5 2/5] usb: xhci-plat: separate dev_pm_ops for each pm_event
From: Guan-Yu Lin <guanyulin@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, yajun.deng@linux.dev, 
	sumit.garg@linaro.org, kekrby@gmail.com, oneukum@suse.com, 
	dianders@chromium.org, perex@perex.cz, tiwai@suse.com, niko.mauno@vaisala.com, 
	andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr, tj@kernel.org, 
	stanley_chang@realtek.com, quic_jjohnson@quicinc.com, ricardo@marliere.net
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, badhri@google.com, albertccwang@google.com, 
	quic_wcheng@quicinc.com, pumahsu@google.com, 
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
2.47.0.rc1.288.g06298d1525-goog


