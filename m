Return-Path: <linux-kernel+bounces-356296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A03995F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC728739E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70329175D5F;
	Wed,  9 Oct 2024 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrufRME0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD536D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452736; cv=none; b=M63mBakkiTTpStI4gMnNKNCtJ6t/dxDjmB3EunOpN76qKd0ZZfXltTDwYsoy30nI+/bUuVsmzWbCTmxpqmU56H4Z88clm+5/ceQ4CyMYXHsdS16vJLH9Mz+hB2Yov0eTM8fJ86ObNjCtWJgXgvzveRVMKBge4Xlxficw72bTjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452736; c=relaxed/simple;
	bh=6d4o8eIxCt1jU6na9mB3egocnoX2vrJv2Z9X1xsrJ4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7cg9lxbG89UFDpexSQEhfb0K3Am4vEtdELVECxEndrFjFMPd5gHiE3BiBsqeF+UPuPRYa7JPqsKAsvAnlRbWjopXmsgDWb/DZnmR5LmtJ3VpcNU6w8r9Ra2ye97G/FxAtNBxuUXFVPK8I8TlpNA+yDsW6SIHuR6JmSnZIEuVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrufRME0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24b43799e9so6152919276.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728452733; x=1729057533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7OxfjHBVOMntshe6fF8lKjduPpRHJuYOVoMFWNUSlg=;
        b=PrufRME0h3NXIAZ4rNNVHCyU+AEi/WH4hGhmFfiHZ821siW0dxnQrV1zAIJVWzFzRp
         hw7LIirHjHBKolCkXTJ2g9by+/QmUE82rHBljEzXSaEMN2z0xb7qZ62COdrgupuX1vfi
         BKJlcE9mSbx8yY5nBF4n0DfsCi/KQZcXp3bvSunfcZWnAeiVV0/TNxczy1l9p8LZMCUe
         P0XDsVZsqUjqBKOZgdx+7WBj4lPgJ/FSKd1PCHnWpsDU3TI3jOj9z6tSUGsvBu57du/w
         qh4WmE5wCcFoztSweDMlm9QldpiJ/64HdckC5hZynQRCiBtHtrkclelbxAhknRPkS6dA
         EPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728452733; x=1729057533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7OxfjHBVOMntshe6fF8lKjduPpRHJuYOVoMFWNUSlg=;
        b=iEJbmu/6mxsiWTCxjOsiYAYSQluA1CEsri1zm6tVfQgkyqx8GBFnkGHvkKtmHDEi4L
         68myFxhu7CFecAkSxCMEwPWHzJax4iwwJuBhIc0SLzeagwu56QTxYYwacYp60frLZcCb
         Pa3InekHJ5JfauplOGcPUrRx672I4dNH2w11Altb08CzZa7IIrMq3Y04ISdzc0k1diOG
         5yam9dlPISIUfVCYJo9JAFKZ2WCfZSWlRuGLLK9I4LorcMzMvzsLjQB53X+4un8bv0kG
         4SG36y18DU2ZwzRsjokbrQC7Gqg/MpQwaYxElRkZ872eqavfdYeY5K4u2ruGLFJVMN1O
         6Nhg==
X-Forwarded-Encrypted: i=1; AJvYcCWUJ5lGp/mxW+MW4hPgqgH8PcL1bIq0OE2agA+Sn5czf5X6hNln4/vwiLpOoldsNAZno8ooMzA5QDIsrmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZ5V1m5hYpY1wmyRgOtDeKtVCD5Q1FuE88GnYYTBNUotzjQ3z
	s5Vu9RI/FfCPFAuHRBdEhrnlypMYdjqNwXDOcFGVGAcGP+C5k81jzXholRlIs05hzu0Z9NP9coC
	jVa3p++IyhVJjtw==
X-Google-Smtp-Source: AGHT+IG0TjVBQAhPlnOaA7uJJP4BFVduzUTOPt4dgJIZVSVEuVbQs2SUr2CTFytM9/dWgOrIB0Aust+Xa594Smg=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a5b:a07:0:b0:e28:ef8f:7423 with SMTP id
 3f1490d57ef6-e28fe355de0mr12613276.4.1728452733406; Tue, 08 Oct 2024 22:45:33
 -0700 (PDT)
Date: Wed,  9 Oct 2024 05:42:56 +0000
In-Reply-To: <20241009054429.3970438-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009054429.3970438-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009054429.3970438-3-guanyulin@google.com>
Subject: [PATCH v4 2/5] usb: xhci-plat: separate dev_pm_ops for each pm_event
From: Guan-Yu Lin <guanyulin@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, elder@kernel.org, 
	oneukum@suse.com, yajun.deng@linux.dev, dianders@chromium.org, 
	kekrby@gmail.com, perex@perex.cz, tiwai@suse.com, tj@kernel.org, 
	stanley_chang@realtek.com, andreyknvl@gmail.com, 
	christophe.jaillet@wanadoo.fr, quic_jjohnson@quicinc.com, 
	ricardo@marliere.net, grundler@chromium.org, niko.mauno@vaisala.com
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
2.47.0.rc0.187.ge670bccf7e-goog


