Return-Path: <linux-kernel+bounces-174787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73248C14F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644CEB23558
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A527CF3E;
	Thu,  9 May 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VezJEGLA"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D297EF02
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280094; cv=none; b=C51zae12rsaQHB5DVFRTv3Y8gY1m+Np3vUrg27efZHWc24Jhz9QQ2yjRh+2K1YnltxgpdlNJkco5Fy1oX6SxKKQs9x4PwJa0W1cDhhySUDsDM7igLmue5lIzCWpj6zbZo90hW8IZaAhgSKCKGfhsK3vAAeLypGIOM7scVmHQlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280094; c=relaxed/simple;
	bh=7ATk15QdB/S5pmSsD6KGzazuE/GKwaK5QgCjJGDzFlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACZ/0LIAGBIGbpLxt6J/EzZFEFJiH7fIDLKl5M6f/zzCtorn6vszE7WCgdMcojx/BAHJ6FPhVXRQI2ZhQLDr132/hjyVlse4F1LyIvYY6dOYNYLZcji5GLe7NziIoooDj3iot4YWFmqUGfv09NDb27f1+zQ6dFbX+JhxgBSLhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VezJEGLA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e50a04c317so6917615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715280091; x=1715884891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbK4EEbe0hcgx1L+Qk+amL1rZ7gk1BOQN0FHx81DIZc=;
        b=VezJEGLApANFh9JbDBmg7UgsEHFxvPumB3/+g1EHz/1vTD9taJpNAz29yWInuasd3h
         p/fF9hThrvcMfGSGxtuzSrsf3xxh/mOdHDZ0RBL7RRwBydyubwlgS5vTpuFX1MhLhn2Y
         PHldBQVRrgI6li4KTY9mla+MboxwpQsEZEfQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280091; x=1715884891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbK4EEbe0hcgx1L+Qk+amL1rZ7gk1BOQN0FHx81DIZc=;
        b=sxQrSUH+Sb4auNaQT+5mcNFc7qFd21apCGXbMGA9IiSlzVXpu+inELWBzAPJg2SdWE
         XESBgeSqlwdgto7Ecp0p2HjAVRf+AvWSvEPJpwpG3o6hzMy4qYo2d2YfxwXP6+ST8rlr
         76udbLoHvGUczhtsXqrLhJIpMJ2wWTC5daRZSiSK9ovYWuhGIYPmH+MJvnaaqeIGXKoh
         HkE0ck/QKTudrKSyF9CjWHTv4cju7YRF3dZDTaBDGBQDbQRkD7mU030sCBu2MP0cJZ1X
         cLbyHQVF7Tjjn0jJtYX699PTKTolvAvjGq8+csQkwzfOmItCHtHtXyXRpjtRV5mEH6Ba
         ZmVw==
X-Gm-Message-State: AOJu0YzWFT5GwToNofLX23G/msuas5H2VfmJgQy0MBUHAlEdi4zNxEfy
	WdjOGydas2oNu8Iqi6zPUaInmvIvaVFNpx3FBL2X9bFSrVZsSkV2H4abUm+nM5NQa8EmVVP0RgU
	=
X-Google-Smtp-Source: AGHT+IEBLu7hk4BBeGG3wbznANriJSjMk4kzbAb63zB+bN0rkgoA0AZC4i4t3YoYXORKce9BUP+Htw==
X-Received: by 2002:a17:902:efca:b0:1eb:ed2:f74c with SMTP id d9443c01a7336-1ef440596b4mr4519385ad.67.1715280091590;
        Thu, 09 May 2024 11:41:31 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ef0b9d40c9sm17904075ad.49.2024.05.09.11.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:41:31 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] soc: qcom: rpmh-rsc: Ensure irqs aren't disabled by rpmh_rsc_send_data() callers
Date: Thu,  9 May 2024 11:41:28 -0700
Message-ID: <20240509184129.3924422-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan pointed out that Smatch is concerned about this code because it uses
spin_lock_irqsave() and then calls wait_event_lock_irq() which enables
irqs before going to sleep. The comment above the function says it
should be called with interrupts enabled, but we simply hope that's true
without really confirming that. Let's add a might_sleep() here to
confirm that interrupts and preemption aren't disabled. Once we do that,
we can change the lock to be non-saving, spin_lock_irq(), to clarify
that we don't expect irqs to be disabled. If irqs are disabled by
callers they're going to be enabled anyway in the wait_event_lock_irq()
call which would be bad.

This should make Smatch happier and find bad callers faster with the
might_sleep(). We can drop the WARN_ON() in the caller because we have
the might_sleep() now, simplifying the code.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/911181ed-c430-4592-ad26-4dc948834e08@moroto.mountain
Fixes: 2bc20f3c8487 ("soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free")
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 7 ++++---
 drivers/soc/qcom/rpmh.c     | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a021dc71807b..568d0b8c52d6 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -645,13 +645,14 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id;
-	unsigned long flags;
+
+	might_sleep();
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irqsave(&drv->lock, flags);
+	spin_lock_irq(&drv->lock);
 
 	/* Wait forever for a free tcs. It better be there eventually! */
 	wait_event_lock_irq(drv->tcs_wait,
@@ -669,7 +670,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
 		enable_tcs_irq(drv, tcs_id, true);
 	}
-	spin_unlock_irqrestore(&drv->lock, flags);
+	spin_unlock_irq(&drv->lock);
 
 	/*
 	 * These two can be done after the lock is released because:
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 9f26d7f9b9dc..8903ed956312 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -183,7 +183,6 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	}
 
 	if (state == RPMH_ACTIVE_ONLY_STATE) {
-		WARN_ON(irqs_disabled());
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
 		/* Clean up our call by spoofing tx_done */

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


