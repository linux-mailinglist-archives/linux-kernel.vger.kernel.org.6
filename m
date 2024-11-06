Return-Path: <linux-kernel+bounces-397822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA73F9BE10F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D911C1C21040
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A891D61B1;
	Wed,  6 Nov 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIUUBIpx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5438F82
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882120; cv=none; b=OzQlUZjeO9kLXXxoFBPu+fZlE9IQnlKxR75sdApxclmEBCLV5GHj8pHOVyPwfe91kNPbPJMpibuEAkbnLOny4KnZcsBt+iuASG6koF2QxBGokW6SYFDJuGPocvpXPl3B7mwERT6L/X8khvWXfjcAUKQL+wQ02o4EDghIfJ/lyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882120; c=relaxed/simple;
	bh=6quhFQ2ncrTjf4Me/OBMe3GF0xmYkzQjOFwbOPaWC0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2O+baggqujD5yfsOMPp6aiiNA/2LF+FZrxZYfNii7bAVD09fF2YxaAOvzhWLVksVd/QOLetBKNUfdadYpW6fmA7xxLwWWwSsCT3Azp0RB+FfBFcqEQ88V0qJ06WO/vIRIz1CSXykTTqz51IZauwQX3YZyeDL/kdnnaGIhIeEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIUUBIpx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so10409595276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730882118; x=1731486918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IumGmvr31fowXT167MDqh61gubvL7Xj6+sSzWudS0fI=;
        b=SIUUBIpxEU1QgoqFHps8B4/Ke/8J/e1WwIBPJtyqXg3FZggXJjtYIAC4RMA0p+5/SJ
         53si1ypLpPducj41yiPSAuf0FvZCYvuQeVG3DSwLTuK4c55GdjkfWJeyZ2TXpIZZlpyA
         ITd5RWwKgSi5VAoxB/6P0JmCjKp+pkFZ9IR1V/IWU2IrIIes157H6+vw1eUTojaJCQC1
         NE5xwCzdGPKw+Niq/oftZdU000OB3z562/qxWiHK6GSNHb2njnsUT6GS8wr6NvCCzhLP
         Di+yzRw81lN9ikeul9heYm6gBCSROVNfTcF54Gj2aR8e11E2uRZMijIJAQ2YTdc8wkaq
         tqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882118; x=1731486918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IumGmvr31fowXT167MDqh61gubvL7Xj6+sSzWudS0fI=;
        b=if488rvubOXG+3V723qkZ4BqehpG4HTI4/UOchCqdR6PDstRzOv2ymz024q7Ezuir2
         Ys1GqRMP1JAAriJfVWHoAKFbjyBy7vS2FUu1Swep6p4gVZbIuYLuSMZZCKOPphvCrdyG
         QYgTZGL8FXlDnEHC5ObxPKOYPMz5YBS46mxwBDstuH7If/gxCZGBLTMQIgPlvZkXI8Xn
         0ano77OoUSVFLrJ7ZTpYbPxOLkCn9GFGN+JswC1Xyr260Am2bCOcAEjTV3jjoShRY/PS
         eugHDDj2SXEvXdt3aM6HGecCXHNzdKzu4xnma86FZEhFKqhJkg7BpAftbW8v0omKBvxd
         8YMg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Bp2POVwZdUoDk6LX9RR/5m6cDS+Jg/+IApc26Std+CyDi4ph/pIPLA4L65M1x393CYZ7Y6GneiyvjTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjpf9fzK9eaBPvq6WGmLvUCspkIvdqkNtDDOXzNFeDeG6EX8r
	EvXYfYChUDismWUCE02Gzhg2btFZiSj/b++jB6Xy3lDbIKq5jUFKwfXs6/RgdzWPo3C/Sgtyjeg
	GanlrRtwNCnUHDA==
X-Google-Smtp-Source: AGHT+IFB0Awyro0SxbJwsUGskYgR6WNNcfW11Dy1ezhsMBzsh0YK7fbx+j5+Khbflu2XH4qFbZRp+ycq94C4avs=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a05:6902:1d1:b0:e2e:3031:3f0c with SMTP
 id 3f1490d57ef6-e30e5b0ee45mr15818276.7.1730882117985; Wed, 06 Nov 2024
 00:35:17 -0800 (PST)
Date: Wed,  6 Nov 2024 08:32:55 +0000
In-Reply-To: <20241106083501.408074-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106083501.408074-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106083501.408074-2-guanyulin@google.com>
Subject: [PATCH v6 1/5] usb: dwc3: separate dev_pm_ops for each pm_event
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
and hibernation. This is crucial when dwc3 driver needs to adapt its
behavior based on different power state changes.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/dwc3/core.c | 77 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b25d80f318a9..2fdafbcbe44c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2582,6 +2582,76 @@ static int dwc3_resume(struct device *dev)
 	return 0;
 }
 
+static int dwc3_freeze(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int		ret;
+
+	ret = dwc3_suspend_common(dwc, PMSG_FREEZE);
+	if (ret)
+		return ret;
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int dwc3_thaw(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int		ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+
+	ret = dwc3_resume_common(dwc, PMSG_THAW);
+	if (ret) {
+		pm_runtime_set_suspended(dev);
+		return ret;
+	}
+
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int dwc3_poweroff(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int		ret;
+
+	ret = dwc3_suspend_common(dwc, PMSG_HIBERNATE);
+	if (ret)
+		return ret;
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int dwc3_restore(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int		ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+
+	ret = dwc3_resume_common(dwc, PMSG_RESTORE);
+	if (ret) {
+		pm_runtime_set_suspended(dev);
+		return ret;
+	}
+
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
 static void dwc3_complete(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
@@ -2599,7 +2669,12 @@ static void dwc3_complete(struct device *dev)
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	.suspend = pm_sleep_ptr(dwc3_suspend),
+	.resume = pm_sleep_ptr(dwc3_resume),
+	.freeze = pm_sleep_ptr(dwc3_freeze),
+	.thaw = pm_sleep_ptr(dwc3_thaw),
+	.poweroff = pm_sleep_ptr(dwc3_poweroff),
+	.restore = pm_sleep_ptr(dwc3_restore),
 	.complete = dwc3_complete,
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
-- 
2.47.0.199.ga7371fff76-goog


