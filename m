Return-Path: <linux-kernel+bounces-569813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B414A6A7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EEE3A7D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B624224892;
	Thu, 20 Mar 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1oLyqwG"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55A1A287E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479254; cv=none; b=j0i6HsuC6K6Rzrb6vsZmM3GE2r5udrLXws4gNZBlH65vPgQYjhe+Lz++pnHq9mbTJw9Hh56A18UgkhVEZAhzx8HcbhvVP09o5ZMCwkfy2Llo10IiUuWm4InAkpR3INVh8XPRrnDB9NWstO6iSVJjDYBXxXEM1+6NX0lpS719GAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479254; c=relaxed/simple;
	bh=VhD8Av3HSuJHTUiv2cdROzFQDA9TdxYn3udhBrPmLPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUdb8fJ7TGgVIrSJzyifBYYQP8YO3W9kakOKSiXoqOXhpjByfNyUWCyHRbwPv7YBpc/FYUsXScgkPdf2ccZI55tMkG/z4KysYN9mxKfyAi5gIq052IRFfV8LUyosQR3mjx/3QsMetcJgaPIFlcjHX/ZUYMx4ONEiX7JLuarItsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B1oLyqwG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bee278c2aso21614001fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479251; x=1743084051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYAI2eqixUcWJERcq8+IYiHipQCgnbOCM34Jd7N+9HY=;
        b=B1oLyqwGqyT03rP0GFXC82s/cDUh4gdQlsUNZve/uzwAbLZJk2y/RLv6ITzPYDRx2M
         etIcDIxYMpHP57RLIZhziRzmc0pmXnh6xJxrEQ4wCJlOJWnuAOXjfRL8p/1D+XJZa07p
         jbhbMWdRoS3f085uzNlQ+MhdThzt76ct++dW81eKzTEJkSmvKIZ2CopIVy2M5RwgQUIM
         h3RHxuYwFMtB96hFhSI8hVSul1FnxSVF1LJLJP/K108g2vidlIeegvkzlKNBbiEqtybk
         1JDdZblJdqSeS8IDdOU7cI3JSSFlb6avt5L5dvO7wxgKc2a9xlqvZZI4dYuHDkiPVtOW
         nWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479251; x=1743084051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYAI2eqixUcWJERcq8+IYiHipQCgnbOCM34Jd7N+9HY=;
        b=gTXeVaqd7eJdobkl1+ggwfkHBC54fbsYdCd6DJtE6fhbRLztlRSFhAjPJx/UWVu+MV
         latP3ArjPFe9JxqxjNB3p7ZUw8tHhQNPrkTfXWmVZBDZ+KbI5ZqIJZa/TY+ceNyQjwkX
         joOeKoYoBPiOlX++E63RLMkBfR9v4XSTzW8YjA6CJ26jTpycDqcHIlM3avFW+wlPM6fb
         vaxrGySHgc42iUcCx5j4/d36LShjN34CsDAffBswCizbt4VwWOXnJYran/qbzjffC46S
         D0bCk1xDoQn5NEnwR5duLTpVMI7Vwlg9pLVOTkj9iUeF+yIyTwtSnVst5riCu+qXQ6JX
         9z4g==
X-Forwarded-Encrypted: i=1; AJvYcCWXJJMDzwX/6tKk86BpvlcJusw0RBayn3wXHmT0Oo43//jfoxNx/g+HzY2pOWVOe6x5KxI+9MvQ8+OWv6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpF3qlV05xqjQ+C46cZKGK5zmvRBqDz9XMLoiBXkpwJyhWr3+o
	IA8HtrmslNhAONYWXPE0Nq5nOc4V6za/tm3bCSLcuE5bDkXgOxBM1oFcGDtLJiI=
X-Gm-Gg: ASbGncunc3E7XgcKbB9mocyQQFwPTZJVxLpyPzu4K9ZeVJTaxnLmL0tJdtOHeuxXAzJ
	gvhD3ERGZRCOHSjJlo3KHJOSEDqJA6TXEhfWmH40TN6t2EKQOd5mjhAwEbWWHavKZL6aqXpMemY
	tTSMvyzMemIrzJQOi27S9EJVwt6YcS+s4E2Epk7k3KSEIgGYpb4BrjPTZGvWYo3NuFnXP4XhYA9
	rCNE8tnyZI5djRyzKflQjgaM2Ac94s0L5D0N9LCTXt3ALdrbDp4Qj5bVtlIjAqJ++vfrdEyf2A+
	SOu13bwLCjH6H0b4tmuk95UM12MeGlqUNXs9EyEuJGDpcnHx9XVF4se46LIJ2K/e4OtGbIjmez9
	erAvmXiJ3lia0L8G3vQM=
X-Google-Smtp-Source: AGHT+IE6l4M0DQlQYZg4ALvU5yllXDeu5+WFY7sQJFtppyPs0t//66RIGxg0FcrWHeDey/P2LeUHtw==
X-Received: by 2002:a05:6512:39d6:b0:549:6309:2b9d with SMTP id 2adb3069b0e04-54acfaa1caamr1050147e87.13.1742479250703;
        Thu, 20 Mar 2025 07:00:50 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:50 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mmc: core: Further avoid re-storing power to the eMMC before a shutdown
Date: Thu, 20 Mar 2025 15:00:33 +0100
Message-ID: <20250320140040.162416-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To manage a graceful power-off of the eMMC card during platform shutdown,
the preferred option is to use the poweroff-notification command.

Due to an earlier suspend request the eMMC may already have been properly
powered-off, hence we are sometimes leaving the eMMC in its current state.
However, in one case when the host has MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND
set we may unnecessarily restore the power to the eMMC, let's avoid this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3424bc9e20c5..400dd0449fec 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2014,6 +2014,18 @@ static bool mmc_can_poweroff_notify(const struct mmc_card *card)
 		(card->ext_csd.power_off_notification == EXT_CSD_POWER_ON);
 }
 
+static bool mmc_may_poweroff_notify(const struct mmc_host *host,
+				    bool is_suspend)
+{
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)
+		return true;
+
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND && is_suspend)
+		return true;
+
+	return !is_suspend;
+}
+
 static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 {
 	unsigned int timeout = card->ext_csd.generic_cmd6_time;
@@ -2124,8 +2136,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
-	     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
+	    mmc_may_poweroff_notify(host, is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
@@ -2191,7 +2202,7 @@ static int mmc_shutdown(struct mmc_host *host)
 	 * before we can shutdown it properly.
 	 */
 	if (mmc_can_poweroff_notify(host->card) &&
-		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
+	    !mmc_may_poweroff_notify(host, true))
 		err = _mmc_resume(host);
 
 	if (!err)
-- 
2.43.0


